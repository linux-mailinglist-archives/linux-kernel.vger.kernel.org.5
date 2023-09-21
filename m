Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D077A9656
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjIURFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjIURFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:05:12 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4DC1FFB;
        Thu, 21 Sep 2023 10:02:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTaXL4iqlcf7LZgyYWl9I/V9skEqbsXkhJroRBQAdkbYvCstfuMxTLm9/uKvYqieTfJlv1uHgfehhliWrFi1/81JSNhri1UsVId0mD7gVIcD5BYywc7S1+3/ItGv1mggZ0JghT3Hn15mG2AtVa7jtI7FTtN9phslgBs3gHOmtwzkUKwn0k3mjiSvCsNPel4jnedUGQpJX1n8Whizr5LlSD6dJeGxQI1xeB7Hg2JZNm95lQdagpG8UjtpEvVQpXpVAWatgJEJezJaiHXy1p1lq4p8WQB3VR6LX0HEyzTLhZ3qsr2XfoY8Kq4j6ZDUKhUyrNo4rYz74ln9Cd+HU1VZNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rFqxgYrESLMeHsTvx4azW3yc8+GfCVIG3LrNSMbg/0=;
 b=hymhXPnwdHXqZOoQs2vhMrsoJfsoiWP3BvhbSrxJ63oAusjH/WjKztHI0HB62vq7NY2lnFLdVPgZs+aRJsbnrDui8+UvUnibHyrf8gICR2dummEF14vNiOV1vePSTyQl3riapWYsIPXhY99vjPCYiAeGyZOxnfM50HjLkw8cgtppcPQlinYEqEu6a6ZDub5DShPVSJIDkdh9wypc7ohK6PcP8WRHMAfwFB41x4ptL/ZjY5gAMcM+uOXle2u0aj4oYqnkKkPzFWZqLEROfgnIQMdx2R4Ecl+7IAmzaTegboq94BQ0HrfnwO/36+j72io/qUQrp5fuGDa3ufZ+Ny0dXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rFqxgYrESLMeHsTvx4azW3yc8+GfCVIG3LrNSMbg/0=;
 b=HTbTbvpOmakMKzyaszNVJzuZAVJ/mQsHhAO2yDvQ8k3n1WPT4SEgU3ijJ374oUHsodE0qdD55Wl13lKIqnaOztAroqVSbXcypPljIMire/fN5f0D29p2FAiKdRf0F8Qll5Lbjbqo87TViL8WWbUKMRnxQzCfARLcsA9eu6pAiLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by DU2PR04MB8967.eurprd04.prod.outlook.com (2603:10a6:10:2e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 09:45:11 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::86b7:e0cc:dd24:12c0]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::86b7:e0cc:dd24:12c0%7]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 09:45:11 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Silvano Di Ninno <silvano.dininno@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Gaurav Jain <gaurav.jain@nxp.com>
Subject: [PATCH] crypto: caam/qi2 - fix Chacha20 + Poly1305 self test failure
Date:   Thu, 21 Sep 2023 15:14:44 +0530
Message-Id: <20230921094444.2121891-1-gaurav.jain@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To AM0PR04MB6004.eurprd04.prod.outlook.com
 (2603:10a6:208:11a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6004:EE_|DU2PR04MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: f3656c8c-07f8-4024-242e-08dbba8772b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0OllQldvw+ZZznn8BjY89DRkYTDASm8ml5VvCdv2Nacp3MKcFrM/ANJFhfxlDrHV56DCEeFFTYui+vG8PdSCYbFUg1014ffPm1A6BuJPCWNphiAEIYqveFK1lPkY1swTVdStgPuPmJZ/ffGlvcGsl/vk21gF5bOdySIKm9YSD31qF4YduBANe+bq4bMWWdrZ3zn3ejuLwteX1KZNFutQM5G8qBy0xHf75lNaqea0RRJD7ORbtwjeluy8O/kKmVeD8huSnvl7BF4qSvlsxwU4U7qZ6FjNAL7Ud0ovx2SnhdZsAB+FJAAuVLRdMaPkf7MyPIctTTHMNJ5zhetbozqROPGR9tbtSDL+m7dFh0y7tbWLvVvSKI17pvQt80XWFXw7tyj84/rfcgEeajuAvvyAUrI0QEjNqZiFva8UcYU0QUXVZLdzhUw2wE3fR8gGA7yRg26q0GKj9LZZr4NRnHroWoXyP+pwcZHPMDV+4/zweoFJO++X9rbg6SVnvqBjVVLUDL8sbZuwzJGxZ1EwM+PosCODPDuPF+zJS8VNaKmxKowrdlNP4h8Bm7Qi9gYKULocDvaPGYuPCwLzqo/jSh6tdjgltm4aNFMVGCYkuGBMoYbWa43EJ1L4XKa5VoGG851b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(1800799009)(186009)(451199024)(2616005)(1076003)(26005)(52116002)(38100700002)(6506007)(6512007)(6486002)(6666004)(83380400001)(38350700002)(478600001)(36756003)(86362001)(41300700001)(54906003)(316002)(6636002)(110136005)(66946007)(66476007)(66556008)(4744005)(2906002)(4326008)(8676002)(44832011)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wWmELYLpMCLddA49veZMXHgR9O05HdTu4NYzejEa3nZwSr1C4KKqI7rEv+ot?=
 =?us-ascii?Q?WhhgRhh5dlM2OalmoGVd/0PUEJHV6mJD+7IMoc6dKVossz7Yh95xr4QY2XtS?=
 =?us-ascii?Q?u3KgD3poUX1X6w4j4/iyYL9eX+HJ/OmiJZKvIYntAFyCzSLsYe1+VONp6e7L?=
 =?us-ascii?Q?jfxFugibRewVpAFez6TYqOniyNsOafcHh+qnu+JGq5IH35byCZ2ON+/9TmtI?=
 =?us-ascii?Q?oo4fwpb2w6wqoxhVqZ6TvaBNPxvf0xcWZmLoHcjIyp3mfR/DvXRmAwMjs/cC?=
 =?us-ascii?Q?wvz/r2sktCeSCPIXl+p/XVbvTsvKDm/zcXxYeOSD84cfncXP4dKSFGmA6P+s?=
 =?us-ascii?Q?JQxSULTLX3l7uUnJfj9c5ZYFmk8ffCsvxfttoLp1v+gKTgOc1cuZZ7aIikuo?=
 =?us-ascii?Q?Ql/wHAWrD5K0d1fXuQ9QnLYi3WXwokcOke+K0yu/SLu5PYKW0/VlC0XdeN6v?=
 =?us-ascii?Q?S1vqlaZyZHYnxgDkQEXIxT6AcVayr8uLhROLvxLMSiLtR3Q8KjFfXjIp1T1L?=
 =?us-ascii?Q?lMrYb0p3xM70ffowbDqHEnSKpKfKTZ1Y86s9zvrLdUmmaXP+RUv7BAnXM773?=
 =?us-ascii?Q?7NfZiGMaoZYCni24hsv3EVc8lnygbygHmMrGVYw4w4xt4MeZCLCXbgYSF6Rl?=
 =?us-ascii?Q?fak88lo0wPVdUb1dRnNSCveKCnElGbcn/046f+G5I28BqX6L6A/PXxkw2GwF?=
 =?us-ascii?Q?+SXBAH4knlgXojIiaZLrZh254XJn61NZEtAnbz1MSi79f07Mp4zr8S7oTICn?=
 =?us-ascii?Q?Evz7vuB4CNEPD5RLqR0YxTLxYytBbScWGCJZ81n5yNgHSvWwu+QGCtywQZH7?=
 =?us-ascii?Q?x82WwPEjWe1Pk58WVMa2p+AiGxtll8XZlcrm87d8gYebxLhes9HxkYcTpsrD?=
 =?us-ascii?Q?cxSyZaGyPrxyXELM063z4CR8rKUoyFjndeqUZEM3ubVLlf0IO6+2ITkSDxvt?=
 =?us-ascii?Q?b1PJSZxcgKYp78/DSDw/TOjwXhjc6ENgzdXo/fculZ0Sdee+lM2JJ+MqKAq0?=
 =?us-ascii?Q?mxbAboX9X09OF4/ZUxgfIXQVXz0NR8lVIOGjuWRdU86DVAZoP9JLm8UoeqxD?=
 =?us-ascii?Q?LKbdog4Bb70u5feE3IjB/NDZT+6sXnr7H7YUZMmQLYdb/0+TAtTPQVznvQRA?=
 =?us-ascii?Q?ufd5ALf7+mUSAhcWG0h+aa8dIiehiy/jjPkAdGw+7sqh6v7jx7vIGq42N2T0?=
 =?us-ascii?Q?crWlXPFeE1XPYBOG9sKvoV70WPoTd+Ex7tlZj9e7kNzI4wGHDL2qkjTVUXC5?=
 =?us-ascii?Q?HUCPJ5dEdXWM5ca+udEwbq0vQUa76DHiqxGgJcDID9AEza6AJV0xl2mCU9Gl?=
 =?us-ascii?Q?xLgIl01Kz54HjmwBR6csNwLp2rW+cQ+FDRV3PsOJSA4cz3SODr9UV/KCcKP0?=
 =?us-ascii?Q?FoDLW8bfSXKUKMNidH2AofTNZe9RDzLWnZiE88p9BfbIcRuDJGMiZcjpljap?=
 =?us-ascii?Q?Qd8YmpK66y5v+z1xfkOUd5RpaWNJcy7PbzPNaxLCKJflwtjPERalUx61ipAN?=
 =?us-ascii?Q?vE1LSfmexyPE53jaVoQhNKLPFxNr+BwFC0g+iCp7udPEKhLgwOuVKBa+1OBS?=
 =?us-ascii?Q?D5VVz4zMNAZU1Qe0RoGOrW1gGA/WAYyLLIY4hgI4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3656c8c-07f8-4024-242e-08dbba8772b9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 09:45:11.4569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+rPh7EA8udp/Y/+TpXqghSwYs8uUdvIPEJ7tHiENpA/V6uCN7ToeWOhryhIZT/DjQ/PKJt/U9g/pXxEVe9lnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8967
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

key buffer is not copied in chachapoly_setkey function,
results in wrong output for encryption/decryption operation.

fix this by memcpy the key in caam_ctx key arrary

Fixes: c10a53367901 ("crypto: caam/qi2 - add support for Chacha20 + Poly1305")
Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
---
 drivers/crypto/caam/caamalg_qi2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 9156bbe038b7..a148ff1f0872 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -641,7 +641,8 @@ static int chachapoly_setkey(struct crypto_aead *aead, const u8 *key,
 	if (keylen != CHACHA_KEY_SIZE + saltlen)
 		return -EINVAL;
 
-	ctx->cdata.key_virt = key;
+	memcpy(ctx->key, key, keylen);
+	ctx->cdata.key_virt = ctx->key;
 	ctx->cdata.keylen = keylen - saltlen;
 
 	return chachapoly_set_sh_desc(aead);
-- 
2.25.1

