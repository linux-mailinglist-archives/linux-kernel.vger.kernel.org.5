Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1110A769155
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjGaJRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjGaJQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:16:47 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CF610B;
        Mon, 31 Jul 2023 02:16:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClqKdgu142pgBIJZadbkgz1ULpxZeTRSNHGUYTeFQL1CmOBLntIP5RQ7caTAgxOmLv2W66vDnIgCPNIPDniO/goY6+eiTXhhiA+AwNub9eUIwy/DQSh6j2tMIJ2SVie/PYJPQADVWV8+DqfOVV4RqqreptHPL3YJrnolHjfWpA9T1Pe39opfpTyWlItaQkfrb4frMe5qNtDa4h2X6B+Jiy4PYuB3r2w3h/gyTypvAYpC2DPQWX5H02vyAZkhrkp0T2wXHbMVHd3Mbd6DFUHuRa/FZntDVCrb2107iMWkutrIQrWQEoqcTlTWE/A+0vNJfBI2NOrIp6QZ1s+iWuQ4Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIpvsv7GVggjzmzBTfYwTK9gTfy07Ke0k+H2ZsbeHCQ=;
 b=KoEMUCtBvJOkyhLScPaKAYX0GuAlfV4ooLnro8VYCQx2/tpB2xrcj6OrcoG4InJ0A8wjj6ZDLe2wnIfHHFK2dd3kutRbxvQHAd8nBER5jtaSMNOA6JxIpjxJy7Xdy3485vOMXFfE/WhdX6HEsCPb6k3psbnirnI0FzladjMbsGYied7P8G4lWfOvvBsD/x1TcQ9hFhexRpVcSSjBrIvFlzzs89x535LcpnJpQ5X2gA1CGjO3KVd3OuDMauXpnABrdwbCSLOhK/zYbZheju4XhsRol7uyza7tJ6YaOnuBEWbvw7kot5Xa3WdPWGk1HhSU2OJ5Jy00VWoVT5nh0qFp/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIpvsv7GVggjzmzBTfYwTK9gTfy07Ke0k+H2ZsbeHCQ=;
 b=AKXtd9x95c+P3dB6diK+/L/+eSmP9W/nH/9bYkCS35DYSQtcnPJ3Vn3JTyesfc56CEd6fLAMJc8I4TGvcvk/e23RUCYvdJsu6xZPw3I4y22GZySJtDDjPX9+XlISZV1JYFrbkWFjK+Yr1SiYq3i+nalvAAxzt0lhXp7cTf5tUmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by GV1PR04MB9085.eurprd04.prod.outlook.com (2603:10a6:150:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 09:16:42 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936%5]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 09:16:42 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v5 05/11] net: phy: nxp-c45-tja11xx: add TJA1120 support
Date:   Mon, 31 Jul 2023 12:16:13 +0300
Message-Id: <20230731091619.77961-6-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731091619.77961-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230731091619.77961-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0044.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::13) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|GV1PR04MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fcf4f92-e051-4d4f-7020-08db91a6da93
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YHN62Orj+0Mb7SgvkXIaQgzpQM7zfVhFRa/MkV1LDdgC9YzKgtEr26UjZwqqXQyYAjeo6Vp2TdMcDx61rZUzmhX/ztS7s9rKG6frkWNhI5glUGAVh47T3ABk65mGUpvKAVyUbQ+fbhcynTHM4m8nJ9hFbV0Hf0/NZETAdtOPKgwqyPQ/NGADU7D6IFKGwcnA5xxXOSpuRFoUSqTaMjhTG+WIInYyGa/qccNDpgMrtW/3aw4AcqQ4PeNjItcvapU/5oGqlJbjcI3IrZEVRKxPO8bXHoFm/VUNkdNSc4rOkfdfU0uJxJJWWq+zWWTRi/fzpca1g3ScrHxMU/G9ej2HDYM+7ykSbPWFQWH9oKcSTjPm2p9YfFuGpw8zSxm3tscGFhKlfNlgsEvu4p45vRxaicz/LhTjd+x4eZmSrXbAdULErQ1Rz8dhtU6m4DGQU9n1IxPDOMHs+SKEIuGFEhs+9I3uWpQ136n1P40iXrjiWSfQUOIaaEu48mMlFLVdPgnpvFS5ZzeaMQUAHnbf8fRpMqVx7cwSB1xXmgTGZWj7RqthIFdGd6V/OXPwhY18WK3A5bO8Dvv3/2wQMft7/z7vjZKotj6kzizq1NxNbsTOMzKLiKHMga0JmHU8LgmZcohz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199021)(66476007)(86362001)(41300700001)(8676002)(8936002)(316002)(5660300002)(4326008)(7416002)(66946007)(66556008)(38350700002)(478600001)(2906002)(38100700002)(6666004)(6512007)(52116002)(6486002)(6506007)(1076003)(26005)(83380400001)(66574015)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VnUoEo82pJuKEg40UV99qubs8UZgA9TuGIdK/UR4F+ZcDc1GZBLMjlRXAq1d?=
 =?us-ascii?Q?DkHhGQKM5e+YPQdREViDUHXH8qxi8ZupjCi0dY1J03M2Ae3YIxOXUN+NiJ/m?=
 =?us-ascii?Q?VnViZIP3nHTUSXrsCwHbuu71wy7gB9UCFmZ9HSQPVt3wqx/NRZnMu11ckKz3?=
 =?us-ascii?Q?WxzTQFfYIgbl8wMQqY+AtYgLFVGJcpguJQKeBDkoSRVGWmG+d3x1j05Po5uT?=
 =?us-ascii?Q?jFHbH8UqBno3MMPx3etaJXG4yeigC15Hog+jetHBs1v0hyJW4SNDEbbpX7hs?=
 =?us-ascii?Q?QNekWNGy4wBIsD9HXXQioWFTpK5t7Z4HVRyP6MyI2YDOf6RuVc/oy/FdtUqi?=
 =?us-ascii?Q?bcfipavygIohow4MQ3s7MpShR9J/80ggYuV0Np3ZFwMu2Hdy866ReXe382DG?=
 =?us-ascii?Q?NA6Ra8/POHCf/zfA4jUH4fdAevvBlu4NawlY3GEjOpTPtdWJgScNMEX/21oi?=
 =?us-ascii?Q?Vtzbhkdo8b4hlunJnCvVu0CEw3zYfFOR/ht/Axgr06Nl9Vccv6VdZ6/5FbVg?=
 =?us-ascii?Q?6w8rii9s4PcSkSKaJrNqCnyX5scz7CNm5+hwRr/FsZL8gmNDjyZxvKElQTlK?=
 =?us-ascii?Q?+5tz8vOozujQM9PggQnWAh/Ecoi3xVSQvTA1/dQkmS05VLm7f7HUOvWeDcMo?=
 =?us-ascii?Q?21aGnNt6tmgYEdKkkC2deTrgne1MriI3rV/EYRU21cQK25fJ4EZrqhDAs1sW?=
 =?us-ascii?Q?6U2IVS46cDTKZUaR7M/qkFcUSWRrMMagna1WN6kxr9ZuU9aS29WzuFZHB2tO?=
 =?us-ascii?Q?dPwuamwS/c4CtY4Jd89kEbfHiSv3b46wgjz5VVsvJsoItc1RXediuO45TJuM?=
 =?us-ascii?Q?aWj8LgIliPu1VDv4FmUV/JhjXPDHRIMKSGSYwzZteRpnrAZ7I0TFDIOUfr9M?=
 =?us-ascii?Q?oPSzykDTQsdrpnwI6Bj/sk8UyYgMJAem4bvtPVwXFZyLIEPSsbTqnrLhjHQB?=
 =?us-ascii?Q?mvS0sUKpE8Ga+XjLaEtGEFo1dw1kZwm2ecKuYA0unorRmG1k6qPMhsE9jnO0?=
 =?us-ascii?Q?TU8Ma3JEZwkNhxcy6OHqTEQUCIW+ryQz6FJMAtjL+zN3MfRt8zQ+z9PZv5ZP?=
 =?us-ascii?Q?MeDeNnjsyEteWMteFzpcYrqq4MRUeDIijirxcjqMOHn0ESsriP6gwyFDIhVq?=
 =?us-ascii?Q?hjH8DS9CYAh80vJG7RRuadv1SbvhdErbUBlBzLz6rG8sG67yIJD3cLWe00wE?=
 =?us-ascii?Q?2fULRx2OP+GKJ98+SxJ2mLKgUBPpGCM3JfbGAh9Sy5SkZybYhY/wALPVfAJI?=
 =?us-ascii?Q?hQ2XOFSuCw8hF4C5FLxY3G783yLZP6E0yL6t+uN9zHyuiuKP6sLqlJefNpyg?=
 =?us-ascii?Q?Em5gnTXKwxSSd8xXcF7kjJrkoGd1BT2Pm4pNLUFO40JUmLnrkfMgASKzmiHm?=
 =?us-ascii?Q?6bkeRS+o/BoyXzxvwa1Yp1Hq3e8YrwqGb1T8XevJU7BLoXT3Eio8jjTvo1w8?=
 =?us-ascii?Q?0aqONG4uPPheLK0T6liHwOel5/QvG85up7jRn1IRGSZLTBExGqWaVVoRzRhL?=
 =?us-ascii?Q?TnqdMJuuH4kMGo06oFIuXc1Wx+NQOQ25oCdz6dyzHWQwk9jw+JI7YeoN8h4A?=
 =?us-ascii?Q?SxXUfMHmmhq2Kw5q3JFXTNQ0qEbQu99XagDImtRlckeyJGVAYwYFaxcou52x?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcf4f92-e051-4d4f-7020-08db91a6da93
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:16:42.2143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBpwc7KfV/kwbWS/OhwSVWHVIf5/7hFTeClghVmKfTykKQjUjQIpjX6Msv5tDf1a7lzqoLVDG8AGeBVPssClGvR34ZAQn+SBIeAi4LRSWHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9085
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TJA1120 driver entry and its driver_data.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/Kconfig           |   2 +-
 drivers/net/phy/nxp-c45-tja11xx.c | 159 ++++++++++++++++++++++++++++++
 2 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 67aaeb75301f..107880d13d21 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -306,7 +306,7 @@ config NXP_C45_TJA11XX_PHY
 	depends on PTP_1588_CLOCK_OPTIONAL
 	help
 	  Enable support for NXP C45 TJA11XX PHYs.
-	  Currently supports only the TJA1103 PHY.
+	  Currently supports the TJA1103 and TJA1120 PHYs.
 
 config NXP_TJA11XX_PHY
 	tristate "NXP TJA11xx PHYs support"
diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 573083f0550f..dbfaf1e07ad5 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -18,12 +18,17 @@
 #include <linux/net_tstamp.h>
 
 #define PHY_ID_TJA_1103			0x001BB010
+#define PHY_ID_TJA_1120			0x001BB031
 
 #define VEND1_DEVICE_CONTROL		0x0040
 #define DEVICE_CONTROL_RESET		BIT(15)
 #define DEVICE_CONTROL_CONFIG_GLOBAL_EN	BIT(14)
 #define DEVICE_CONTROL_CONFIG_ALL_EN	BIT(13)
 
+#define VEND1_DEVICE_CONFIG		0x0048
+
+#define TJA1120_VEND1_EXT_TS_MODE	0x1012
+
 #define VEND1_PHY_IRQ_ACK		0x80A0
 #define VEND1_PHY_IRQ_EN		0x80A1
 #define VEND1_PHY_IRQ_STATUS		0x80A2
@@ -76,6 +81,14 @@
 #define MII_BASIC_CONFIG_RMII		0x5
 #define MII_BASIC_CONFIG_MII		0x4
 
+#define VEND1_SYMBOL_ERROR_CNT_XTD	0x8351
+#define EXTENDED_CNT_EN			BIT(15)
+#define VEND1_MONITOR_STATUS		0xAC80
+#define MONITOR_RESET			BIT(15)
+#define VEND1_MONITOR_CONFIG		0xAC86
+#define LOST_FRAMES_CNT_EN		BIT(9)
+#define ALL_FRAMES_CNT_EN		BIT(8)
+
 #define VEND1_SYMBOL_ERROR_COUNTER	0x8350
 #define VEND1_LINK_DROP_COUNTER		0x8352
 #define VEND1_LINK_LOSSES_AND_FAILURES	0x8353
@@ -94,6 +107,10 @@
 #define VEND1_RX_TS_INSRT_CTRL		0x114D
 #define TJA1103_RX_TS_INSRT_MODE2	0x02
 
+#define TJA1120_RX_TS_INSRT_CTRL	0x9012
+#define TJA1120_RX_TS_INSRT_EN		BIT(15)
+#define TJA1120_TS_INSRT_MODE		BIT(4)
+
 #define VEND1_EGR_RING_DATA_0		0x114E
 #define VEND1_EGR_RING_CTRL		0x1154
 
@@ -110,6 +127,7 @@
 #define PORT_PTP_CONTROL_BYPASS		BIT(11)
 
 #define PTP_CLK_PERIOD_100BT1		15ULL
+#define PTP_CLK_PERIOD_1000BT1		8ULL
 
 #define EVENT_MSG_FILT_ALL		0x0F
 #define EVENT_MSG_FILT_NONE		0x00
@@ -929,6 +947,27 @@ static const struct nxp_c45_phy_stats tja1103_hw_stats[] = {
 		NXP_C45_REG_FIELD(0xAFD1, MDIO_MMD_VEND1, 0, 9), },
 };
 
+static const struct nxp_c45_phy_stats tja1120_hw_stats[] = {
+	{ "phy_symbol_error_cnt_ext",
+		NXP_C45_REG_FIELD(0x8351, MDIO_MMD_VEND1, 0, 14) },
+	{ "tx_frames_xtd",
+		NXP_C45_REG_FIELD(0xACA1, MDIO_MMD_VEND1, 0, 8), },
+	{ "tx_frames",
+		NXP_C45_REG_FIELD(0xACA0, MDIO_MMD_VEND1, 0, 16), },
+	{ "rx_frames_xtd",
+		NXP_C45_REG_FIELD(0xACA3, MDIO_MMD_VEND1, 0, 8), },
+	{ "rx_frames",
+		NXP_C45_REG_FIELD(0xACA2, MDIO_MMD_VEND1, 0, 16), },
+	{ "tx_lost_frames_xtd",
+		NXP_C45_REG_FIELD(0xACA5, MDIO_MMD_VEND1, 0, 8), },
+	{ "tx_lost_frames",
+		NXP_C45_REG_FIELD(0xACA4, MDIO_MMD_VEND1, 0, 16), },
+	{ "rx_lost_frames_xtd",
+		NXP_C45_REG_FIELD(0xACA7, MDIO_MMD_VEND1, 0, 8), },
+	{ "rx_lost_frames",
+		NXP_C45_REG_FIELD(0xACA6, MDIO_MMD_VEND1, 0, 16), },
+};
+
 static int nxp_c45_get_sset_count(struct phy_device *phydev)
 {
 	const struct nxp_c45_phy_data *phy_data = nxp_c45_get_data(phydev);
@@ -1511,6 +1550,101 @@ static const struct nxp_c45_phy_data tja1103_phy_data = {
 	.ptp_enable = tja1103_ptp_enable,
 };
 
+static void tja1120_counters_enable(struct phy_device *phydev)
+{
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_SYMBOL_ERROR_CNT_XTD,
+			 EXTENDED_CNT_EN);
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_MONITOR_STATUS,
+			 MONITOR_RESET);
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_MONITOR_CONFIG,
+			 ALL_FRAMES_CNT_EN | LOST_FRAMES_CNT_EN);
+}
+
+static void tja1120_ptp_init(struct phy_device *phydev)
+{
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, TJA1120_RX_TS_INSRT_CTRL,
+		      TJA1120_RX_TS_INSRT_EN | TJA1120_TS_INSRT_MODE);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, TJA1120_VEND1_EXT_TS_MODE,
+		      TJA1120_TS_INSRT_MODE);
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_DEVICE_CONFIG,
+			 PTP_ENABLE);
+}
+
+static void tja1120_ptp_enable(struct phy_device *phydev, bool enable)
+{
+	if (enable)
+		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 VEND1_PORT_FUNC_ENABLES,
+				 PTP_ENABLE);
+	else
+		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				   VEND1_PORT_FUNC_ENABLES,
+				   PTP_ENABLE);
+}
+
+static const struct nxp_c45_regmap tja1120_regmap = {
+	.vend1_ptp_clk_period	= 0x1020,
+	.vend1_event_msg_filt	= 0x9010,
+	.pps_enable		=
+		NXP_C45_REG_FIELD(0x1006, MDIO_MMD_VEND1, 4, 1),
+	.pps_polarity		=
+		NXP_C45_REG_FIELD(0x1006, MDIO_MMD_VEND1, 5, 1),
+	.ltc_lock_ctrl		=
+		NXP_C45_REG_FIELD(0x1006, MDIO_MMD_VEND1, 2, 1),
+	.ltc_read		=
+		NXP_C45_REG_FIELD(0x1000, MDIO_MMD_VEND1, 1, 1),
+	.ltc_write		=
+		NXP_C45_REG_FIELD(0x1000, MDIO_MMD_VEND1, 2, 1),
+	.vend1_ltc_wr_nsec_0	= 0x1040,
+	.vend1_ltc_wr_nsec_1	= 0x1041,
+	.vend1_ltc_wr_sec_0	= 0x1042,
+	.vend1_ltc_wr_sec_1	= 0x1043,
+	.vend1_ltc_rd_nsec_0	= 0x1048,
+	.vend1_ltc_rd_nsec_1	= 0x1049,
+	.vend1_ltc_rd_sec_0	= 0x104A,
+	.vend1_ltc_rd_sec_1	= 0x104B,
+	.vend1_rate_adj_subns_0	= 0x1030,
+	.vend1_rate_adj_subns_1	= 0x1031,
+	.irq_egr_ts_en		=
+		NXP_C45_REG_FIELD(0x900A, MDIO_MMD_VEND1, 1, 1),
+	.irq_egr_ts_status	=
+		NXP_C45_REG_FIELD(0x900C, MDIO_MMD_VEND1, 1, 1),
+	.domain_number		=
+		NXP_C45_REG_FIELD(0x9061, MDIO_MMD_VEND1, 8, 8),
+	.msg_type		=
+		NXP_C45_REG_FIELD(0x9061, MDIO_MMD_VEND1, 4, 4),
+	.sequence_id		=
+		NXP_C45_REG_FIELD(0x9062, MDIO_MMD_VEND1, 0, 16),
+	.sec_1_0		=
+		NXP_C45_REG_FIELD(0x9065, MDIO_MMD_VEND1, 0, 2),
+	.sec_4_2		=
+		NXP_C45_REG_FIELD(0x9065, MDIO_MMD_VEND1, 2, 3),
+	.nsec_15_0		=
+		NXP_C45_REG_FIELD(0x9063, MDIO_MMD_VEND1, 0, 16),
+	.nsec_29_16		=
+		NXP_C45_REG_FIELD(0x9064, MDIO_MMD_VEND1, 0, 14),
+	.vend1_ext_trg_data_0	= 0x1071,
+	.vend1_ext_trg_data_1	= 0x1072,
+	.vend1_ext_trg_data_2	= 0x1073,
+	.vend1_ext_trg_data_3	= 0x1074,
+	.vend1_ext_trg_ctrl	= 0x1075,
+	.cable_test		= 0x8360,
+	.cable_test_valid	=
+		NXP_C45_REG_FIELD(0x8361, MDIO_MMD_VEND1, 15, 1),
+	.cable_test_result	=
+		NXP_C45_REG_FIELD(0x8361, MDIO_MMD_VEND1, 0, 3),
+};
+
+static const struct nxp_c45_phy_data tja1120_phy_data = {
+	.regmap = &tja1120_regmap,
+	.stats = tja1120_hw_stats,
+	.n_stats = ARRAY_SIZE(tja1120_hw_stats),
+	.ptp_clk_period = PTP_CLK_PERIOD_1000BT1,
+	.counters_enable = tja1120_counters_enable,
+	.ptp_init = tja1120_ptp_init,
+	.ptp_enable = tja1120_ptp_enable,
+};
+
 static struct phy_driver nxp_c45_driver[] = {
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1103),
@@ -1536,12 +1670,37 @@ static struct phy_driver nxp_c45_driver[] = {
 		.get_sqi_max		= nxp_c45_get_sqi_max,
 		.remove			= nxp_c45_remove,
 	},
+	{
+		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1120),
+		.name			= "NXP C45 TJA1120",
+		.get_features		= nxp_c45_get_features,
+		.driver_data		= &tja1120_phy_data,
+		.probe			= nxp_c45_probe,
+		.soft_reset		= nxp_c45_soft_reset,
+		.config_aneg		= genphy_c45_config_aneg,
+		.config_init		= nxp_c45_config_init,
+		.config_intr		= nxp_c45_config_intr,
+		.handle_interrupt	= nxp_c45_handle_interrupt,
+		.read_status		= genphy_c45_read_status,
+		.suspend		= genphy_c45_pma_suspend,
+		.resume			= genphy_c45_pma_resume,
+		.get_sset_count		= nxp_c45_get_sset_count,
+		.get_strings		= nxp_c45_get_strings,
+		.get_stats		= nxp_c45_get_stats,
+		.cable_test_start	= nxp_c45_cable_test_start,
+		.cable_test_get_status	= nxp_c45_cable_test_get_status,
+		.set_loopback		= genphy_c45_loopback,
+		.get_sqi		= nxp_c45_get_sqi,
+		.get_sqi_max		= nxp_c45_get_sqi_max,
+		.remove			= nxp_c45_remove,
+	},
 };
 
 module_phy_driver(nxp_c45_driver);
 
 static struct mdio_device_id __maybe_unused nxp_c45_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_TJA_1103) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_TJA_1120) },
 	{ /*sentinel*/ },
 };
 
-- 
2.34.1

