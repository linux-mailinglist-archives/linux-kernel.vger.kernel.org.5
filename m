Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084957A7734
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbjITJXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbjITJXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:23:10 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4A783;
        Wed, 20 Sep 2023 02:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErCB1RDqmP3IcwjqkbAi6PQmIK5x/trLLmWn5+TVne4T3vp3locNLXv5PJ25f/lIgCbMMkra88ZrjdEMGacoQMKa3/bt05mrcyI0cTrWUgm7biw7kxoHu6tFO8jYGBm6tAVviZ8ZOddnR1jBzIHaClASBm7fFrQZuN2BHFQGfDBMqBR4PPJroPPAWTf2UPljv5nVspXrbhBJLd5zaSgBLaHHJL/va1fG51DjoAsEY/pUQOqmEtRbkkDe1jn1ps6sMp0oMKIwoxh1HwufoIg5WCC1X+nK9B9FKCvby9LPxzvfo0vFmv8r6CM/4OtzY/ZqEkYS8ZWjiz+sqRUjijrEmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PP/hKhQ3wPKlDPR7iS1D32F2ejCO+UtkgsTDMqXoQ5Y=;
 b=XH0S99W6KG1vyAyhcgSBnLTHawaiC2MrAMTvu6eZA5xnWZ63jGhnP6GgR70KaXtCIgFVraDe2KwFe1Syes6U0RCSubJeGgAG7pO9T2W1ahtRYG2xpBiE4Qjaba8T1v1jHRq1QYTKXzl+auhSBGHD1V+F8ltKy/RiplhUnpK4X6XiH0ALc9lU9zhoGm2mlpcS5QJooEA6CfzZrO3OPO/0cW3VQiS+XXqqxmJbLaLgMBSXUMYUE4fmLO8Tr2+4MUb6kElsholcMcpHch4mB9bFGvsgNMsuBJknhQaLziEYxaQMZUj7gC8QTfjo+6+oguEUl4yL8jdjK59KnfqD5ylCGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PP/hKhQ3wPKlDPR7iS1D32F2ejCO+UtkgsTDMqXoQ5Y=;
 b=WnCXOi1Y0rbI9U5wqM95lcTJmaDjz9/O8IzzLkAZHoH/JvvP1mHl/P4sKDZBHpBEqIyTcrZBEZ2YU4BzdsewDOZaL+E86NYmlB8CBLOXxO/G4W01zYjn2eCwaaE+xIyHftQ17DoY21S1A0rZrk3pFzR259aoM9GGzIeIq/GSnz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM7PR04MB6933.eurprd04.prod.outlook.com (2603:10a6:20b:10d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Wed, 20 Sep
 2023 09:23:00 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 09:23:00 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@oss.nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v5 3/7] net: macsec: indicate next pn update when offloading
Date:   Wed, 20 Sep 2023 12:22:33 +0300
Message-Id: <20230920092237.121033-4-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920092237.121033-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230920092237.121033-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0019.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::24) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM7PR04MB6933:EE_
X-MS-Office365-Filtering-Correlation-Id: 6984d7e0-bac1-4dfe-185a-08dbb9bb2efb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PSNUmnjfyCC5m6QfpsYh4uZI6+de7iawCm7hkiLM+3ehV6ZUavtCiPkBxJG5x0xM5xQW03Ky863PlEtZzM/55TzSJMV3I+a+tDilo2NP7iaSibuIt4w99cIFmfbB9b78PujG14HhcSTiX1fZGRXshPWF5x1htG8lz806PLAulHzIBwNgbGfAsvavfh5Y09VQ8PXqw3LeYMluTN4Q8MBeCYakR/s4IBQ5nnRs4slF3WR54p9YL3g9H+zymIqmuImmL2TIzJSS7Akj4CxqZd6kXZTe/VmukkbVFRCi7fw/smUp9KsbsM7vPRsX9/482nY09ZfqyIOUnOcAVtF6V/lqECUcofn+nV7wnpSjpxCyb/NE/yFUF2ezNLtgC5d854Qli9FMkajvtFmES/08/IFW3sGUFwqeLDr1HOOG2EqwCke2W3j2GgN5iIyLIoA0us7Ep2rAsblfhLI1MbCTYSI3kqlj3nCF/ZLi+rOxnB3MtU054i+O6Y6y9jdeH6jmR1gIZXFVRcZRWYSQ8PMbCclIOnQzoWeOQfXIcrMLsdNrgVZAi3d8SCI1lGh5VMmZOoxxbuW4BCjhQ0x2JEs+jQ7JEtj3mtbjScQ8Bjt0YY1ANmyZAkGZ4lgaeWm/vMtGLQ3QoXXnu29T2d2HlRRZTal+LJNseh7qS7tKHT8msfte9LI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199024)(1800799009)(186009)(316002)(41300700001)(8676002)(4326008)(66476007)(8936002)(1076003)(6512007)(83380400001)(38350700002)(6486002)(6506007)(26005)(52116002)(2616005)(6666004)(86362001)(38100700002)(478600001)(921005)(66556008)(66946007)(6636002)(2906002)(15650500001)(5660300002)(7416002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WwL83MoNPdNqLfSUH8lrxF60SB7+/AqabYMR2O+YRysYRpQm5IQbTfwnC4Ur?=
 =?us-ascii?Q?J5nrxbbpLlxDc+2a1jB3EEh8SePFCGj4Jf0dmbiZ4bChz/IWgLzUO+QBENae?=
 =?us-ascii?Q?bFqhecJk7AwKZ4/SrHwAmrg7D5nmnhdzC8euhPHImkoPxGCZwfkKgGcCj832?=
 =?us-ascii?Q?j5IUz57XofHEXyHhN/AbVCxkwVKGB+6q288hv3pWtx6A52wFqdyqbHiK9r8C?=
 =?us-ascii?Q?zetC4CGdqUOEOGDghKxVhSZh3cJE27GS4HR7nLBujodYko+2JLrx0HwdoMkT?=
 =?us-ascii?Q?tr8dZWyF+yqBmbbd+iiNUqs9BNSc7gPw80hxe+Ny7KTfOauRgMw8XWdTShWS?=
 =?us-ascii?Q?u/OAgTCHDcAZozKtQI8x7MnoXdEOVffqsEhdIkYz6UZ+LxBv9pXSui0lPUl6?=
 =?us-ascii?Q?+omgHrM30NBchUW2yz7d2aXlXryddI/d73pGSMw5bzB1wihXnXkON6xuJLpX?=
 =?us-ascii?Q?OMCwtK4NOVBOy3a/R8HSbBiJMqizK9MDDwhm0VqRF11hSNU+IApROnFyejya?=
 =?us-ascii?Q?TeXlNLm7hJwsea3yEvJlhFEG0wYhSWHILLtRaPDQuMOAn2jCuQTCq7AWJpjj?=
 =?us-ascii?Q?5wgKDVjsdr5B0ahWM+hII5jD5v40VSr1RTzgy0geY7iXXWDZEof6PPKdQo5d?=
 =?us-ascii?Q?oxZ70RqoNc1Mb4TIgA1VjZGzl5Gyg+u4Ggw8KbzYWgeQ+eBns6WgX8v8Osn2?=
 =?us-ascii?Q?+m5t5Ii/NNcXlw75l9A0asmAWkogOznILQTBFmwvY6+ThbXaYM0ko3LQZKxx?=
 =?us-ascii?Q?oRoAaiJuM5lWC3hleD9nMZ8AZ4saczjmcX4nnoAnWl563oAiImpPc5dmlm8q?=
 =?us-ascii?Q?APUEo5CV8YaSmMMPCkJzRZJdO0dqMKoXmu4aD0m0DXy+cWc9zsghC9BoqrcF?=
 =?us-ascii?Q?9UH++gM2rWM/BK9YMoYhPq7t5RMIdA2PKV2HaFgsu8x+2ul8GslYp6Ufwx92?=
 =?us-ascii?Q?xJOLl+AJZavOGTZIWCubT9ZCVQvKqox09V9GW3mh0UQtYfJYV5J2AN3hf5Sn?=
 =?us-ascii?Q?Z/PR+4tA3Nfmhty6nU8YUd8lLJLSo0JYYf4ERgciMD5QHJn4u4djYkg+4y5z?=
 =?us-ascii?Q?0XOgIj8M4A3/WShz6A3IL4znM1Tf+yQTBF1d9R5VwK+KmXkyM5DG76MXt3u9?=
 =?us-ascii?Q?RfiX4/RbgQA4jmFpPWC00dh+rxII6l8JdtsO/mSYFymgYBjXMOmoCs6kKIVb?=
 =?us-ascii?Q?OZaNmohbETCBgobTT30xpurzVMBEdu1vU+qlv1Y1MI0bRCDRIwvGf40hyX5R?=
 =?us-ascii?Q?cYa7r9aFK6792Rl9pQGQcF+pjt+xaGGcQ3y0r6QMDJ7IEdlgLkwoyvFHDArS?=
 =?us-ascii?Q?Q656lmpURoJNRroNcQBLTDAuE+lZQQZMuEiqFaA8EjSY3jRLm8JrBhDqXI85?=
 =?us-ascii?Q?aWK8Kz8K9BgML+aCVwYIPkYSoj3GWlaboivNqUyNcw8bIStt/Ubc0xzRq3sZ?=
 =?us-ascii?Q?e5n8Xikhns0PHobfbbGvCzBPf1G7I3igQXa0WmQGxziX4ySIxzS1xij4hOUx?=
 =?us-ascii?Q?UDVOw3sz3ETlE83YeycEc3MGB9CMumkK+reQN2xJvg04zdZDTP672X5R9JeH?=
 =?us-ascii?Q?Rh4Wbibb6N8inWZHvT4YaspwL2DEuBtHIMiBmJOIvAjjKZqW9RGLjYWyshdL?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6984d7e0-bac1-4dfe-185a-08dbb9bb2efb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 09:23:00.2870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpsxc/uMrKDM80z7c/0J6GzDL250tGyezKk0RU8eSKStH672RVYTSW/I05Vcbq6Nk7YCnLVzkXcAlu1q+F1Sv/D5o3BX2mGy544UqiMNnb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6933
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indicate next PN update using update_pn flag in macsec_context.
Offloaded MACsec implementations does not know whether or not the
MACSEC_SA_ATTR_PN attribute was passed for an SA update and assume
that next PN should always updated, but this is not always true.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v5:
- none

Changes in v4:
- patch added in v4

 drivers/net/macsec.c | 2 ++
 include/net/macsec.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index b7e151439c48..c5cd4551c67c 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2383,6 +2383,7 @@ static int macsec_upd_txsa(struct sk_buff *skb, struct genl_info *info)
 
 		ctx.sa.assoc_num = assoc_num;
 		ctx.sa.tx_sa = tx_sa;
+		ctx.sa.update_pn = !!prev_pn.full64;
 		ctx.secy = secy;
 
 		ret = macsec_offload(ops->mdo_upd_txsa, &ctx);
@@ -2476,6 +2477,7 @@ static int macsec_upd_rxsa(struct sk_buff *skb, struct genl_info *info)
 
 		ctx.sa.assoc_num = assoc_num;
 		ctx.sa.rx_sa = rx_sa;
+		ctx.sa.update_pn = !!prev_pn.full64;
 		ctx.secy = secy;
 
 		ret = macsec_offload(ops->mdo_upd_rxsa, &ctx);
diff --git a/include/net/macsec.h b/include/net/macsec.h
index ecae5eeb021a..42072fdcc183 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -254,6 +254,7 @@ struct macsec_secy {
  * @offload: MACsec offload status
  * @secy: pointer to a MACsec SecY
  * @rx_sc: pointer to a RX SC
+ * @update_pn: this flag indicates updating the next PN when updating the SA
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

