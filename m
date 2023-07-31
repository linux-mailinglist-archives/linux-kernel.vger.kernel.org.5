Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF88769158
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjGaJRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjGaJQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:16:49 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADFF11B;
        Mon, 31 Jul 2023 02:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTlEkQw1f2j4gtnpWsKZXJ/fFjtbmxlcideYbUgdzbH5UnbbGdjOdF5jDQdZD3f5QffUO34uTyVywXRj7pTKCp21IO4igUi+EVioXvChzLKswP+KqviEFBYzXugiDTxcy6BTsfHNDfbMX/MvQ1mxKUEz7x1riVRdzgCUevimV205Na5Ti2+pq12EiEUUJn1lFQ98/WBeYQpG4oh+iv26ORMOR7MYeKV+BS7zqz5gLl3hPYfMYxAcAt3xSmJGc65a6EsXnV6/4nNKz0s9PZfswZBNDqgxCxv5FEeQeHT9lgVrLDUeJVS3gAAv5y2Yh4XGnq81657BQ0mWxg5Af1g+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHnbdZU3kpG+fED17AicWuznV8Gq0hpKxxKj6jHhgvU=;
 b=RD+hGILBzyB4dazOnegZ0XAJTe54aomWecvhlUu6JSZpqvbXL12vlah3ddMegOaFQ3qkgClidxoKtRKZwTCB1BuRd7noz7RYHIWOTzTSh5dNzie5Jb1zi4QzE2RD4PLskhYGYdwIfgI4U5xPM+Gfeq384UqtNgxH2qlJ+supmo7gay8HHgoeSXvTyNGkWbLyc356CQAUqN3fScnFegsvmjTRxbAZgQtXa93YcfwDg8OL7dOQdB5cFykmrqDC87fnCGDTmw0xsb5ELqOF45hm9hIoWRaz4L08cVJj5bsNQjVUHUNIwYEG3UIhKb9SiN+LaMrrzdplb2gghFlEEoTj8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHnbdZU3kpG+fED17AicWuznV8Gq0hpKxxKj6jHhgvU=;
 b=bLV7s6j7c4uxidQdWywKFz4H9Z1nGAGtJrKL2EdotmSKZQz7rbKigWoYr6b8aGZ5RHuK3ah8fpU8pTqIeJvjHNjls6bSG0vo0wwhgvK5OaYlUTtdAi32C93+Q6+jS118NZfUh307ap0iM5kLzwJytE7rS630YZxkwMx3o9NnV5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by GV1PR04MB9085.eurprd04.prod.outlook.com (2603:10a6:150:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 09:16:43 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936%5]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 09:16:43 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v5 06/11] net: phy: nxp-c45-tja11xx: enable LTC sampling on both ext_ts edges
Date:   Mon, 31 Jul 2023 12:16:14 +0300
Message-Id: <20230731091619.77961-7-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b7898a63-019c-43fb-627d-08db91a6db0f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vsBwrbRPIwxiVC4AZ4gqwFiGGbEltLdKk01NxJpDCK3taSAXDemEN4YnakIesvkOCt+0BnYcWX2iy9Z11AEXTpkrJwsVnePHVPJaozTuTX/JzLlxGLy08NZ7KKLbavGyB31JQYABIK9OEpLqfwrqCMIFjK+q6NGAZk5MnKDibB9BqTHrEkBEIPLWN+lEnMnSHvgtBizbAC+VDv+Spqsm1D+rabw3jnvbdIgg1E7/WATYhq91A+Y0DTKZs6eI1rwiqtZ0xag53I+aQkV+ZsUdukrXqSgBMSD39xQzgwnmlLY3+LScRaP1Cjbe/hf5h9qOkQZ+T+WfinX+fnM7a6VYS0v+r3cWxFxv8U9rkka3XDz9/A0A5V+3aGuy2QJ8QkaOHzc7f9dzEInB/6/9oOGbr+GI3mnODG+s5kzM2E+7nagBaIHayohuDI9t+b0GkkLBeBSniVsI3+SyhUQxWH1fQU3ZLW+wpNul73WWhMpmlnIrb8vCKzW6OcDsT8/Dsu2OJ1gpPHzA1PwBO9UY87UaK5Y5LI5qwfMFm2YRxAVMwLMS1LU+PJkYkJ4vTTzqXtp7F/uWleKzjW0yNUZ2xgY3GxnIHPaDNI8U/dFLhmqwZ7fQR3O54PnY/IvwIOs9O7gd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199021)(66476007)(86362001)(41300700001)(8676002)(8936002)(316002)(5660300002)(4326008)(7416002)(66946007)(66556008)(38350700002)(478600001)(2906002)(38100700002)(6666004)(6512007)(52116002)(6486002)(6506007)(1076003)(26005)(83380400001)(66574015)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Oi//y9ZJ1BTLTcffnnghJIbaZ0nAMLxrMxfwZyRmOMUn9Xx78BMfp+ITv78?=
 =?us-ascii?Q?u7lcMtcMub2+RpHb5sSfqcASLTUZMxvwLmcxWcmR3Uze2XdQDG4wcpgOZ2Wt?=
 =?us-ascii?Q?HuD1yHE0joTIjv5KxXATVOF9OBEw5ImVL1wPBKH+41vwzSSI8pRoCTsTmeqh?=
 =?us-ascii?Q?gmCeHpf1GfgwG9d/j20KGEfCobbGK7e25BxK2W4/VosL4TlCxY8FXTYs6B1x?=
 =?us-ascii?Q?IbI46THXNgaBuC4KNOLbJkMQTKZ20r+Js0aPLluIqy18dCKQe2R3kwwWOPBB?=
 =?us-ascii?Q?7Tpu+6hWJeQ54DNQ4CTUcsceq/ut91MnTYHdZ/JLRSblbW05/Js72nJjtu1j?=
 =?us-ascii?Q?odHF0IENciB9phZvK2r7Jlv/sWOGfe8lJ+HtxblmWU+kEeOFEuteLu93Mj43?=
 =?us-ascii?Q?UHRLtMzThNhg0SOVnHCcES5gRWpg5mCgID6cwNQxyVyK7qNskVNDauZun0gs?=
 =?us-ascii?Q?u5n92aK2xnpHZj5cxoaHqK8L/dZAx4/5Eji9py9jEPQghMXeTo6vO6skTUCX?=
 =?us-ascii?Q?meNPou9YMCKIm2ZuU8BrRillkAcpOGG+dI+fR2tYgzvcpUAeFgomrzmqmGOA?=
 =?us-ascii?Q?Xut4ifJkYtkvli4plwZ5QeVOZYxzJLnUDvBZu5bSi6QjYlBPOoXnVWY8sghh?=
 =?us-ascii?Q?Io4py9SwlKpFLRkM57jlGRHlvtUMyFIAEU+MNFqLKxh3/sqgTTLPESTKf2xi?=
 =?us-ascii?Q?NHpGXpVtu6HzNdZv5cwsNecTPSn0hNX/UyFVAjHbE8FtfwBP818nn+IbqGeZ?=
 =?us-ascii?Q?yFN718gU06Wi/CnouJ++1FozCl1EpKlH/INX1E5AbnbAkk4Truj/lXWwmJXC?=
 =?us-ascii?Q?GhjQG2kVIq25+757EdfKlIUcodLljQc4iL7c27uuRe6SHNWq5+CUsfkO1ZmH?=
 =?us-ascii?Q?WsQe0V8FF82BREaev+94huYciDta2uSTnbjpwa+kPFz8ormh2aruR4sqWRRU?=
 =?us-ascii?Q?X1Tiuf4ISumK+HPlEyRQBTfEqiMfNIXepY1fmuXsYJVcpyKEyYKz7g7obVgW?=
 =?us-ascii?Q?zSke8rEz1SmbST2K8QGLLNTrKTc6EbGjW1owTYGQ0AAe3hYcMeuEkP11ahXZ?=
 =?us-ascii?Q?hbIu4ocojPfztSO9xQ/5wIK7Sn2RKk9XOW0TBHXkMP5iwH1g2kzTb4ZsMsTY?=
 =?us-ascii?Q?xjFI88PxflRNGz+w2t+eYGfO5jzMNIt7lrJhsw11TquB9O1ZBvUeRyJ4qEEG?=
 =?us-ascii?Q?cpmxhGMMOAwDWzFMsbqRSSOMqEe9zwlisGKtyvFSEuz5stELEJ58io7qhHDv?=
 =?us-ascii?Q?cvEOcJfc8IhquWyxosp56JghkKO38voq4pnOaf0mdWH7eLetR+CckByg2ZF2?=
 =?us-ascii?Q?48f7LWVw0CKozHNi6/iFySKTZkysbncEFRph2+QmquGrjw+8xhuY50m6dtjt?=
 =?us-ascii?Q?E7g+ssEIb95/uPD7ycPKs+eM1kMXTgOiuuvY201Aq8vKDDqyUG1fGqTM0TLJ?=
 =?us-ascii?Q?+a/NzsK1frqxBXqZ7CsPANgqCJguGBMD+kn5KSJa6n3b2bicfI4cx46GqTM+?=
 =?us-ascii?Q?IgJn1MnLmLpM+r6C9KfepBiU633+vmWj4ZZRmvUgp58Bi2vugaRl9qN9v2xZ?=
 =?us-ascii?Q?KGthSxuINVQ8ZD2iEEXCsajhkYo4OUY07IgnNmB9A3LG7cmKoiaoSw2iJHK8?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7898a63-019c-43fb-627d-08db91a6db0f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:16:42.9999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DDhriRx1i+1dXAufZS7ZnLzD+qOcQBqNZu+PhjuCVF6dySypbQ6FMKCH9q0huqr200hqfySZ3o8v3sQjdEd4GGGVMrAHq8zyqo+CnwdUzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9085
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The external trigger configuration for TJA1120 has changed. The PHY
supports sampling of the LTC on rising and on falling edge.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 60 ++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index dbfaf1e07ad5..8393c17a83cc 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -101,6 +101,10 @@
 #define VEND1_PTP_CONFIG		0x1102
 #define EXT_TRG_EDGE			BIT(1)
 
+#define TJA1120_SYNC_TRIG_FILTER	0x1010
+#define PTP_TRIG_RISE_TS		BIT(3)
+#define PTP_TRIG_FALLING_TS		BIT(2)
+
 #define CLK_RATE_ADJ_LD			BIT(15)
 #define CLK_RATE_ADJ_DIR		BIT(14)
 
@@ -238,6 +242,7 @@ struct nxp_c45_phy_data {
 	const struct nxp_c45_phy_stats *stats;
 	int n_stats;
 	u8 ptp_clk_period;
+	bool ext_ts_both_edges;
 	void (*counters_enable)(struct phy_device *phydev);
 	void (*ptp_init)(struct phy_device *phydev);
 	void (*ptp_enable)(struct phy_device *phydev, bool enable);
@@ -684,9 +689,48 @@ static int nxp_c45_perout_enable(struct nxp_c45_phy *priv,
 	return 0;
 }
 
+static void nxp_c45_set_rising_or_falling(struct phy_device *phydev,
+					  struct ptp_extts_request *extts)
+{
+	if (extts->flags & PTP_RISING_EDGE)
+		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				   VEND1_PTP_CONFIG, EXT_TRG_EDGE);
+
+	if (extts->flags & PTP_FALLING_EDGE)
+		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 VEND1_PTP_CONFIG, EXT_TRG_EDGE);
+}
+
+static void nxp_c45_set_rising_and_falling(struct phy_device *phydev,
+					   struct ptp_extts_request *extts)
+{
+	/* PTP_EXTTS_REQUEST may have only the PTP_ENABLE_FEATURE flag set. In
+	 * this case external ts will be enabled on rising edge.
+	 */
+	if (extts->flags & PTP_RISING_EDGE ||
+	    extts->flags == PTP_ENABLE_FEATURE)
+		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 TJA1120_SYNC_TRIG_FILTER,
+				 PTP_TRIG_RISE_TS);
+	else
+		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				   TJA1120_SYNC_TRIG_FILTER,
+				   PTP_TRIG_RISE_TS);
+
+	if (extts->flags & PTP_FALLING_EDGE)
+		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 TJA1120_SYNC_TRIG_FILTER,
+				 PTP_TRIG_FALLING_TS);
+	else
+		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				   TJA1120_SYNC_TRIG_FILTER,
+				   PTP_TRIG_FALLING_TS);
+}
+
 static int nxp_c45_extts_enable(struct nxp_c45_phy *priv,
 				struct ptp_extts_request *extts, int on)
 {
+	const struct nxp_c45_phy_data *data = nxp_c45_get_data(priv->phydev);
 	int pin;
 
 	if (extts->flags & ~(PTP_ENABLE_FEATURE |
@@ -697,7 +741,8 @@ static int nxp_c45_extts_enable(struct nxp_c45_phy *priv,
 
 	/* Sampling on both edges is not supported */
 	if ((extts->flags & PTP_RISING_EDGE) &&
-	    (extts->flags & PTP_FALLING_EDGE))
+	    (extts->flags & PTP_FALLING_EDGE) &&
+	    !data->ext_ts_both_edges)
 		return -EOPNOTSUPP;
 
 	pin = ptp_find_pin(priv->ptp_clock, PTP_PF_EXTTS, extts->index);
@@ -711,13 +756,10 @@ static int nxp_c45_extts_enable(struct nxp_c45_phy *priv,
 		return 0;
 	}
 
-	if (extts->flags & PTP_RISING_EDGE)
-		phy_clear_bits_mmd(priv->phydev, MDIO_MMD_VEND1,
-				   VEND1_PTP_CONFIG, EXT_TRG_EDGE);
-
-	if (extts->flags & PTP_FALLING_EDGE)
-		phy_set_bits_mmd(priv->phydev, MDIO_MMD_VEND1,
-				 VEND1_PTP_CONFIG, EXT_TRG_EDGE);
+	if (data->ext_ts_both_edges)
+		nxp_c45_set_rising_and_falling(priv->phydev, extts);
+	else
+		nxp_c45_set_rising_or_falling(priv->phydev, extts);
 
 	nxp_c45_gpio_config(priv, pin, GPIO_EXTTS_OUT_CFG);
 	priv->extts = true;
@@ -1545,6 +1587,7 @@ static const struct nxp_c45_phy_data tja1103_phy_data = {
 	.stats = tja1103_hw_stats,
 	.n_stats = ARRAY_SIZE(tja1103_hw_stats),
 	.ptp_clk_period = PTP_CLK_PERIOD_100BT1,
+	.ext_ts_both_edges = false,
 	.counters_enable = tja1103_counters_enable,
 	.ptp_init = tja1103_ptp_init,
 	.ptp_enable = tja1103_ptp_enable,
@@ -1640,6 +1683,7 @@ static const struct nxp_c45_phy_data tja1120_phy_data = {
 	.stats = tja1120_hw_stats,
 	.n_stats = ARRAY_SIZE(tja1120_hw_stats),
 	.ptp_clk_period = PTP_CLK_PERIOD_1000BT1,
+	.ext_ts_both_edges = true,
 	.counters_enable = tja1120_counters_enable,
 	.ptp_init = tja1120_ptp_init,
 	.ptp_enable = tja1120_ptp_enable,
-- 
2.34.1

