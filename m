Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A47879E954
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240932AbjIMNcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236214AbjIMNcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:32:31 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B225D19B1;
        Wed, 13 Sep 2023 06:32:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxKU7WY2HsGbObS8mxxBnKDmkUpTO9NJOY4ZmidiX9rwHVaF1OR0hoZkM1axQmK0KRts8nuSrkxqQ539YhQXN0Q4rnRvNXHD0vJesD/dfFDBc1Fva6CJ3eXcmWtp9WEOwYh5ZZqUGj8yXpQULFsOzEyZL9lXzAEP97r688+vIaH20BhxuE8/R3/R8lXiQLJA/1lf0JnsFUZLr/+80deCMQTYLKYy/ug48Bni7zvMN+y74U0ZFKqQTi2xZ1N8vfnR9CpH3VnAchUyVr4C55YLfj2uc5eZ+iVPAB8vsBGcpvnk2Rfi2t7FZYMq8AA5u7oNx8XWhDsSmH75uWX2p9BZiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZs/CfOWcju4P4wbc2E1qPQRYa+hIUgg46SFBBGJ214=;
 b=dUaCft5+zUbUZUjkKd3CmI5GmjB+Heoa+LinPbPQXpfDTLTOSKb1CTmqMlJxeFOYyGsRH9xTA5jZ0CSRS1mZPW46XbTuQ3khtdWhcdlF9cPvydgE6IHtkzuwgl1M4NWVhr3fvRa+QviVQxZ2by+GCD9H7ZKs2LwaXmmGt2P/W77s0WyqnzmPqCKecZWOiNDCvBGPP761xEOm5qWJuYcM4O0J2f4AfSpkwQ7zPMBlKy7Z8eRngW/vbC85uuBKwzIQSvBQYai7jBkDh0saktiVOodeUIWmimk8LdIZo5rXOFhm+n88CATjSE/z/90Nppg0X6HMGxBoh4tYMpQaAyY9gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZs/CfOWcju4P4wbc2E1qPQRYa+hIUgg46SFBBGJ214=;
 b=fS+sLsnkZymy0tjp/YFYv+ssk3PW0MsuWwRG8JF6JWwoDSbPZrbfnhnpzHuNID1mi9gbq9SMJnQ9inZ/r7R8+K30UfPaWXxzv4nIxomCAS1t0VWjlErTqwD7nYHYD+p37TQfRAQA9/hJmko3G6lmM43wEBnZvA9AmXtHa2OnL1w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM8PR04MB7235.eurprd04.prod.outlook.com (2603:10a6:20b:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 13:32:24 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 13:32:24 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v4 3/7] net: macsec: indicate next pn update when offloading
Date:   Wed, 13 Sep 2023 16:32:01 +0300
Message-Id: <20230913133205.3749628-4-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913133205.3749628-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230913133205.3749628-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::10) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM8PR04MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: acb32566-af57-48d8-38b2-08dbb45ddd44
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S5EkO8bgQayuUJ7fpFajdq8UNiY80GHxoMB7z+l3fx8nQovApZJ9l1aJpZPA0RHUep+HHuI9shmjVkkXga3Dm8tGJOg/bf+6xC1X746968SlUaSLFEi7g2jeCS+XI7OwwMVdkFhtdvjTEVIRa35tYxqMcfmPRJ16f50srmO9fYGtbTPQGSIc8WMQPZsmb41YJk370pMW3iV4yH/iHYiztF6wLo/tYMR+vWPV1JW6r75xt2GNQ232lVlN1vrZC3rt/Djnw1mi97eCHB1MXQ23Zo38ZHunc3z9TSasODXn+L2iqyuT0r28Ozh7vGHvGEzyYna7BsK8vvpduAK1nwgmiXKrP5lg0cCbqW8c2CXMopLiVtrZbXePAyHEGkGKXWel3bIK7Wc9jP+mo3i4j2yuUqjo64W0OQBGLUzOkLM8tir70MNFij/m2T76LPVF5+/qZOhv3q5tgzQqS9J1lINBvHKOYJuNPkEp1e0/PeN4QomJN79OVBZ5GyJmS9cVMZBVqx5toljhdhtDFYWl6nf3l8iaVfa8sMH2PTKOM+oI7Pnf8AL1jwNi2IPsXMD8Whe1sZrhK/hfbp8XPLqbjxodiyuPlTgkl9I+HgNHCs95V4ZBxrvlCi9jROtb+tzLHeHIIcKgrlQ2CMPx/xhbMi2SgqOm1hbkdyJ7TLPWxTrffrg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(136003)(366004)(186009)(451199024)(1800799009)(26005)(4326008)(8936002)(8676002)(52116002)(6666004)(1076003)(38100700002)(921005)(2616005)(478600001)(83380400001)(5660300002)(66476007)(66556008)(66946007)(41300700001)(6506007)(6486002)(316002)(6512007)(7416002)(15650500001)(2906002)(86362001)(38350700002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JoTfGqzhoCrgw1J/qo1nzuT1YlRDmlzDFnuSWd15vcjQGP9/3RTNS46Im03K?=
 =?us-ascii?Q?EMZFkHGqCEBsCKWWa8GOwmHO8UELXVjVB28hupdDNdmEFBTdhRsOaeTEqy2B?=
 =?us-ascii?Q?9Fiq9IEfnJN8Awz+wx1QOko14fL6GMMgvE+FLv1ovNUeFqoYVE7dFvETSipR?=
 =?us-ascii?Q?cpXYNOHTsFEXEzFBng1WhqTmE7eCY3ZnVaf6S6fCg+sWN0kpPi49ZuwkkVmO?=
 =?us-ascii?Q?SmQ3i0OyboVI1e0iktbsRdrkpxyZG8BGB744hQben81NohJYQKO7hqQY5yKH?=
 =?us-ascii?Q?di2JZ7AcLuCgIVHJA0nKxAvH0QsFCqLFUHSBeeLmsI4sB9/BaPUet4dgjP4/?=
 =?us-ascii?Q?oUkWQZwTZ4sjLe5x+0aLRrqm4Dm8rQdxhELA4NonInvCyb6Jn6fwJi95M0oN?=
 =?us-ascii?Q?nYChUZx5jPcXYQgPwdQPZ0b79T8MlFjmJewyouw3MUT7XGVIysBHTPDVyFCF?=
 =?us-ascii?Q?JjdIP6tXcD0/fg6ULdDn8NSbtU/t9fWnBkHxRI3cZI/hgunC0WhINfIEKaw1?=
 =?us-ascii?Q?ER2m0jKSsDlE978vOUCrHi9YsLL2qrwRMGwBZ2tBqiTPU4g/IKhV9d9gh3xy?=
 =?us-ascii?Q?y6aNMy+Ftw70CybCT8J5Tpaes6jE5OowGEUaIeRfLoxMNSvlMFTLUx9PUTL2?=
 =?us-ascii?Q?htHKzdJLln080bh/W/bgI+uI7RKRV1b+vtmGoQn0cF208GV8x71yFHuBWat3?=
 =?us-ascii?Q?G/kxBrGGFzG17sCwpHYG2s8OV6mnOk/BQe53BWWSt2cPvpWzOhlsqVEd57/j?=
 =?us-ascii?Q?hICwtv0WOrD5OkPokOpZkCWGsg3eR2TvsMOyhrNePoUSUYxxt4sYfQs3Tkbk?=
 =?us-ascii?Q?0AcGjQRutYBTV+pDnZvK8yyJ6tJSgzY0aNCez5wcKRnMOQHOXs6RkyLejwmt?=
 =?us-ascii?Q?lYDrB3/VnK2KQruoAyf54FPUpEpKzdPMbKJvYgwP5nAcwOWtUgZzQFNocIab?=
 =?us-ascii?Q?4nLUzPFO/p7kLoarIRWMtToBIgTo+dEQ1Q6hIy5kW+2lA/fiTGDmwPx+mgsY?=
 =?us-ascii?Q?zlIDlQh6L29rbW03E3nPa1e/45U2B41b+p5WfTT9f/H2h/hvtCKcGlxOoIjw?=
 =?us-ascii?Q?sGYFNI6tY69J97BJfwMbD12Z8gQmaspjt0BsTWvRRVBtG4TlPXJAU1O3ZOT4?=
 =?us-ascii?Q?XVwYAPm0yiF0E1Tv5sunwVFLoBLeV3tGu47o7D46xMNS2+Pmsy/HUzhspWxy?=
 =?us-ascii?Q?QZKXoHDLxiHVqI7ZL8UL+SB7Neo5amvQsjZZ23uHCRn8CQTCAV0gve4t+4DH?=
 =?us-ascii?Q?SEaK3YNwNyeTAsySnb4fhS+v/KUIjcVaciuiC4Zq3v8AbLK8RDeADCSZSwXR?=
 =?us-ascii?Q?u3EvdmNuavZve8SJXabGPe7eJwf/neEsoeT2oIMb8sVQ1mB5GxTWkjncDo7U?=
 =?us-ascii?Q?+B08k5aiu3KS6o+2fNS3VGADiaQWt3omakc8lj4nrJrKmwGHbDmCVlw+qhm0?=
 =?us-ascii?Q?PkmtpIsyHw8rg9bcVqKd+9aD8qPeOLJgeJ8KIqYXWORYav73Sg+0A4B5gHo8?=
 =?us-ascii?Q?wLNsILc8RezmrjICj+Wbevj2CrOtManLXT3zVKLUcgof50lR/FzAoBjNyhKl?=
 =?us-ascii?Q?M8YK4IROmt6/r5nKaGPBLBPHCGdpCqaKZCbLzbqi2jvqjuPoEv+R+diatT9b?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb32566-af57-48d8-38b2-08dbb45ddd44
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 13:32:24.1859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8KHFkKPGAg9TAkJkwdKCAQ+5HMXLyhO/oNXIxDwO7oL/ERMCEnX8waZh6Zc33Lqa2tyTUKuoOf/Uyaq5p0QQxEaXyXFFIpD6+AUmMtzPiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7235
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indicate next PN update using update_pn flag in macsec_context.
Offloaded MACsec implementations does not know whether or not the
MACSEC_SA_ATTR_PN attribute was passed for an SA update and assume
that next PN should always updated, but this is not always true.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v4:
- patch added in v4

 drivers/net/macsec.c | 2 ++
 include/net/macsec.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index c3f30663070f..2dde22e01fc1 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2384,6 +2384,7 @@ static int macsec_upd_txsa(struct sk_buff *skb, struct genl_info *info)
 
 		ctx.sa.assoc_num = assoc_num;
 		ctx.sa.tx_sa = tx_sa;
+		ctx.sa.update_pn = !!prev_pn.full64;
 		ctx.secy = secy;
 
 		ret = macsec_offload(ops->mdo_upd_txsa, &ctx);
@@ -2477,6 +2478,7 @@ static int macsec_upd_rxsa(struct sk_buff *skb, struct genl_info *info)
 
 		ctx.sa.assoc_num = assoc_num;
 		ctx.sa.rx_sa = rx_sa;
+		ctx.sa.update_pn = !!prev_pn.full64;
 		ctx.secy = secy;
 
 		ret = macsec_offload(ops->mdo_upd_rxsa, &ctx);
diff --git a/include/net/macsec.h b/include/net/macsec.h
index ecae5eeb021a..5e0b24a2f49c 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -254,6 +254,7 @@ struct macsec_secy {
  * @offload: MACsec offload status
  * @secy: pointer to a MACsec SecY
  * @rx_sc: pointer to a RX SC
+ * @update_pn: this flag indicates the PN update when updating the SA
  * @assoc_num: association number of the target SA
  * @key: key of the target SA
  * @rx_sa: pointer to an RX SA if a RX SA is added/updated/removed
@@ -274,6 +275,7 @@ struct macsec_context {
 	struct macsec_secy *secy;
 	struct macsec_rx_sc *rx_sc;
 	struct {
+		bool update_pn;
 		unsigned char assoc_num;
 		u8 key[MACSEC_MAX_KEY_LEN];
 		union {
-- 
2.34.1

