Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB0975F979
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjGXONJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjGXONC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:13:02 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C771FE53;
        Mon, 24 Jul 2023 07:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJtFgp0GWf/RZzUyCPdNmneCatmCXwCDB5CWcUGcDGtL0eURj0uMebLCysSjGcAp+DPFzasEpkFi5lEWuIguvw5mrIK+Bxw89618WgqSfMllbHmOQiLGuwapM58qmMCeI1+iArLQ+u8BdPnPs0U35nF5f1jgfZFrN6x0bkYJYSXlJ3B/jPNDYWYAcQ/lJdsaCFTgAsUxaaQXy28cbnR7d9Yd+MhrKOZQWoZdyTcZUmW4/WOX0L7D5eZ4Sf9f7v7tp6qLLuAqK3NCHsixpcs2XA0Jz51aYT4MAFexZDCzcZEOAbItgcY+aF6XJ+McYYJY6zClaE8+qlMst6iCi4Blfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0i+EqVPH+dSCRPnSwHsB1/280lgau8mOLLHBMZHOtw=;
 b=SFzXirlvBWKjlVqW3+QuB+lofV3oEZITDZ56A715a6RxU+6jVUPipkWwbAk58nM61WzglQ1WPcz8AzBzx0EVLqU4fEmdlsHMBavcy/GlTb3XoJHlI0eL0TGhVK7QtYmY4TWtrjekweTOLCOvcSNlsasrFlqe8kD6zirvkhkX9/VxEhhHdjPIi4lWCI0xQFlzlD6hXPB9f6il0QdNfCojvr4MQu0swaEmsB+DHO2SoO0PprxjRChDv/J+yS/EdEEzI+DY9fKX4RKYN9YYYbbKIhuGd9ZedfwrfFLE2vp/dAjp3Nba8RGvbnfjFowWuEkQhS4vtkJu9vLigqU9hXihkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0i+EqVPH+dSCRPnSwHsB1/280lgau8mOLLHBMZHOtw=;
 b=klyDtmOYeIEnkrtCyFhSLQLS+3vD4TLHSmp6FOzDVzeRl2J7mqVt27yBYFUvrAl7BCY82/Qv0xtN9Hzt+ptS/4UCZnCgKvhDWS2YXxBJB1YMQItk5xJ1tixvKcaFeUBpRF1wZChFw+Z5tJ4rqYCIRVH863rAWm39cackIAvqSNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS4PR04MB9690.eurprd04.prod.outlook.com (2603:10a6:20b:4fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 14:12:53 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936%5]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 14:12:53 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v4 10/11] net: phy: nxp-c45-tja11xx: read ext trig ts on TJA1120
Date:   Mon, 24 Jul 2023 17:12:31 +0300
Message-Id: <20230724141232.233101-11-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724141232.233101-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230724141232.233101-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0009.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::19) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AS4PR04MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: e25295e7-13e1-430d-d9a8-08db8c50122d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NO1FcM+kqIPSStvbPVBzYOOxZM6HQUuf2wI1bk+rw0H1ChuA/YJc9hOcU0FLBtc3TWnndz269D7yfVxWKswEtZGRKdwhYhN6ZMzgkOgVAznQJL3f5z+IfDsNBhZrHC9ilrs55B3X9oUeB5IxZE5XuedNoNKmSYGL6wDCaAzsxXSLOc0qaF+57RwtInzNJUrmUmTeQaFobwHHhY/WXevl4AN5xXVYhdhIqa51AnoZIftny2ZX51pibybUSoG2PnFIwSNYaw4vg4E+TNx5+b4RbwLKlCmzLrPsPqpcaxTvzuiN5+BMP5t/VsiQZy7QSsxitM/yVRkpd21QaZcxDAY8ntEybdrestp+KEAvmebVpndW2EwRGRrbjVdshwXhDDK140DNY3WKbToCcSttfOEvWMZI7MsZWbDxdOJdYFJDVl3X7YAp5RTGCnZuyjIiwHnfrbpOOjNjMU5LXkEE8fO3t4GsQiK2vhDAQX/FmNtch/SroxL5WriLpS/agbVfu/kIrnrbuqTV3r9Js4bHeSY49aIRPmtW42gYkyONOs4j25L43rCWa9ia/4XU4jjcfEohDxg93ZJ9ZSGztaZLWYsjZFzlnFVMbPmxkylZrRrV690AeiI1ZYGmLKQzO3KaAqca
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199021)(8676002)(8936002)(478600001)(2906002)(7416002)(66476007)(66556008)(66946007)(4326008)(316002)(41300700001)(5660300002)(38100700002)(38350700002)(86362001)(6506007)(1076003)(186003)(26005)(52116002)(6486002)(6512007)(2616005)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0pz6SZ+/L55jn6hTAIgPJJ1Vk3JTFLZOuA4AfB8bSJYFKBL1o/2FeJ8k41lT?=
 =?us-ascii?Q?cgcbGL6x8nA1XUS/keL83KnzngObKavrz1MeKDI7Hzck4U3P0oaRx28oIilU?=
 =?us-ascii?Q?D5kuSlPl7BjqyrIRU51WFXQ2celECUQ1rM86NcyIixY9klXQaUyqYd2+xFAe?=
 =?us-ascii?Q?Y6k3vCGIVrEVfiOY2kuUT9fdkFfp9xZ6T513e5SWI36zM3fEC72A+/1THgoL?=
 =?us-ascii?Q?oA7AK2Z7iPbwc2cF6pXqjFmxfOUFBr9TOe5mI27xgnwyuK1dPYnSdRbqE3RN?=
 =?us-ascii?Q?8cRXyEqwbXvJFv7n4hC0/G9Z4LZFeCYJRgqH9RdP5EVcrXwu6yxyuW/GCTLs?=
 =?us-ascii?Q?8nVDpuG6qMb8TLF2rJHo8SCTVK81fLyar4VQ28B6TeTFApPhRPsUDBp0e9Lb?=
 =?us-ascii?Q?/X/0OByhXnUuxJHXLK1M8DXcQGyt2BlgbENViZ7do8qjipmLZ0yFGKOK4wxM?=
 =?us-ascii?Q?uWWhE/ziL4cw6i91RF40LR6z6Gg3ubGKgIdgQTsffmAxoL8YwYym/+gcUXJd?=
 =?us-ascii?Q?NgDlVY1wFca8X1K0c/HtW4I8rcr5iy2R/WutlZBWP2a9gd9N/dO/2bJx7/zh?=
 =?us-ascii?Q?4qFdm7buemxRryQ5e28dkV3x7EzoHa6PpN6d9pOn2gkXOU32IYkY/SircLGt?=
 =?us-ascii?Q?1SLi/K6lbadVJNemVA7w1x0oUFWAQEanOVpqggXUf02njpI0ts4RLDKpQ0WC?=
 =?us-ascii?Q?fl4SC9n/gh2KburWMzzkQAeWibXSWJUno5pUxzkJ59FCTNcipLEbjz04iIWJ?=
 =?us-ascii?Q?RsjrxZhmSsW3SVUcyf+89paOWtyJzEcjW4cUaq+T5yWVddstle3y3+dZFJq2?=
 =?us-ascii?Q?9paTAOHvtqa7L5lzC8mNpi85/3p3F7UmFlmQWDLuGHqqLgjssyeEefF/dcpz?=
 =?us-ascii?Q?hoxcmpWF2i5nKeNjKuXYILEuQT6EeICd7Ykhgf7vWumlLz3KaIO8+w5VNXfY?=
 =?us-ascii?Q?LuMayCWEpqqsezXf248lpaFggaMtr3ImMG3QD+M0eIQvxLpnCiD0P+UAg1ND?=
 =?us-ascii?Q?o9n/oXv2s12l/hrYzFc1G5kMWTkg5Cd3/gIAlKBAMbrQauqi3p5liXV+tzxt?=
 =?us-ascii?Q?OKKj+raLhlNie4GoZO2WfUtThKUWCCHn95lfuv+hMbMa9HO4JLQ9ajtyXjcE?=
 =?us-ascii?Q?9drNJF2jfHHGERmalVBe0+ctIlOoVbqlnajt9eHJHnFQl7q/5ZYbQyvugFRF?=
 =?us-ascii?Q?4MGUSj1rShYGA+a1M7Mr8rv+vAnWSP/aU0lksk2pFL3KRwzooo6kdKRA9f3/?=
 =?us-ascii?Q?cPGZjc1gaaM8xpWm7wjFufGR1O9bq8MMaYp9W74YdYLrmuNT7xCPPG09un9C?=
 =?us-ascii?Q?RupzFDUAIxTUNvzcPM+TODHFV6KcXMfquNww/a22jEUccIkMN1xbAU8hX6VS?=
 =?us-ascii?Q?Eozl5eEFKjdsA5c1pJcoCscJ2mUGv5AABbUXQ5YjmN/fevAOJlnSln/qtUUg?=
 =?us-ascii?Q?ch0s3hrOlPGodIZsAA1CKhqxBWa0N9vjbNYbW2GipUYRIb4JZOIYJt7JAmQ+?=
 =?us-ascii?Q?dXHMjjD4mVAhTb3CpT0XdZaCKTaXMvXJusna6GgnCgjdwoVguTAljnO4efrF?=
 =?us-ascii?Q?5+b+NOJstYuk7HFKdPDZSoie1Ur2+0/5hEaepL2sbt/UAJeuZobBbeAUdCWi?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25295e7-13e1-430d-d9a8-08db8c50122d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 14:12:53.4812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stG+rd8ax2M460o9o0RLxZhcu3HLavQKSMjphV/97On91tS6qQixBx9C/Z0ZQhcAl3HsKp0Y0hTchOgk+Vst09zHP0ShJ4gPs6Empx2TCBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9690
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On TJA1120, the external trigger timestamp now has a VALID bit. This
changes the logic and we can't use the TJA1103 procedure.

For TJA1103, we can always read a valid timestamp from the registers,
compare the new timestamp with the old timestamp and, if they are not the
same, an event occurred. This logic cannot be applied for TJA1120 because
the timestamp is 0 if the VALID bit is not set.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 64 ++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 8097ac8d6962..c21c6aefc705 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -34,6 +34,8 @@
 #define TJA1120_GLOBAL_INFRA_IRQ_STATUS	0x2C0C
 #define TJA1120_DEV_BOOT_DONE		BIT(1)
 
+#define TJA1120_VEND1_PTP_TRIG_DATA_S	0x1070
+
 #define TJA1120_EGRESS_TS_DATA_S	0x9060
 #define TJA1120_EGRESS_TS_END		0x9067
 #define TJA1120_TS_VALID		BIT(0)
@@ -269,6 +271,7 @@ struct nxp_c45_phy_data {
 	void (*counters_enable)(struct phy_device *phydev);
 	bool (*get_egressts)(struct nxp_c45_phy *priv,
 			     struct nxp_c45_hwts *hwts);
+	bool (*get_extts)(struct nxp_c45_phy *priv, struct timespec64 *extts);
 	void (*ptp_init)(struct phy_device *phydev);
 	void (*ptp_enable)(struct phy_device *phydev, bool enable);
 	void (*nmi_handler)(struct phy_device *phydev,
@@ -509,7 +512,7 @@ static bool nxp_c45_match_ts(struct ptp_header *header,
 	       header->domain_number  == hwts->domain_number;
 }
 
-static void nxp_c45_get_extts(struct nxp_c45_phy *priv,
+static bool nxp_c45_get_extts(struct nxp_c45_phy *priv,
 			      struct timespec64 *extts)
 {
 	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(priv->phydev);
@@ -524,6 +527,53 @@ static void nxp_c45_get_extts(struct nxp_c45_phy *priv,
 				      regmap->vend1_ext_trg_data_3) << 16;
 	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1,
 		      regmap->vend1_ext_trg_ctrl, RING_DONE);
+
+	return true;
+}
+
+static bool tja1120_extts_is_valid(struct phy_device *phydev)
+{
+	bool valid;
+	int reg;
+
+	reg = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+			   TJA1120_VEND1_PTP_TRIG_DATA_S);
+	valid = !!(reg & TJA1120_TS_VALID);
+
+	return valid;
+}
+
+static bool tja1120_get_extts(struct nxp_c45_phy *priv,
+			      struct timespec64 *extts)
+{
+	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(priv->phydev);
+	struct phy_device *phydev = priv->phydev;
+	bool more_ts;
+	bool valid;
+	u16 reg;
+
+	reg = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+			   regmap->vend1_ext_trg_ctrl);
+	more_ts = !!(reg & TJA1120_MORE_TS);
+
+	valid = tja1120_extts_is_valid(phydev);
+	if (!valid) {
+		if (!more_ts)
+			goto tja1120_get_extts_out;
+
+		/* Bug workaround for TJA1120 engineering samples: move the new
+		 * timestamp from the FIFO to the buffer.
+		 */
+		phy_write_mmd(phydev, MDIO_MMD_VEND1,
+			      regmap->vend1_ext_trg_ctrl, RING_DONE);
+		valid = tja1120_extts_is_valid(phydev);
+		if (!valid)
+			goto tja1120_get_extts_out;
+	}
+
+	nxp_c45_get_extts(priv, extts);
+tja1120_get_extts_out:
+	return valid;
 }
 
 static void nxp_c45_read_egress_ts(struct nxp_c45_phy *priv,
@@ -656,12 +706,12 @@ static long nxp_c45_do_aux_work(struct ptp_clock_info *ptp)
 	bool reschedule = false;
 	struct timespec64 ts;
 	struct sk_buff *skb;
-	bool txts_valid;
+	bool ts_valid;
 	u32 ts_raw;
 
 	while (!skb_queue_empty_lockless(&priv->tx_queue) && poll_txts) {
-		txts_valid = data->get_egressts(priv, &hwts);
-		if (unlikely(!txts_valid)) {
+		ts_valid = data->get_egressts(priv, &hwts);
+		if (unlikely(!ts_valid)) {
 			/* Still more skbs in the queue */
 			reschedule = true;
 			break;
@@ -683,8 +733,8 @@ static long nxp_c45_do_aux_work(struct ptp_clock_info *ptp)
 	}
 
 	if (priv->extts) {
-		nxp_c45_get_extts(priv, &ts);
-		if (timespec64_compare(&ts, &priv->extts_ts) != 0) {
+		ts_valid = data->get_extts(priv, &ts);
+		if (ts_valid && timespec64_compare(&ts, &priv->extts_ts) != 0) {
 			priv->extts_ts = ts;
 			event.index = priv->extts_index;
 			event.type = PTP_CLOCK_EXTTS;
@@ -1724,6 +1774,7 @@ static const struct nxp_c45_phy_data tja1103_phy_data = {
 	.ack_ptp_irq = false,
 	.counters_enable = tja1103_counters_enable,
 	.get_egressts = nxp_c45_get_hwtxts,
+	.get_extts = nxp_c45_get_extts,
 	.ptp_init = tja1103_ptp_init,
 	.ptp_enable = tja1103_ptp_enable,
 	.nmi_handler = tja1103_nmi_handler,
@@ -1838,6 +1889,7 @@ static const struct nxp_c45_phy_data tja1120_phy_data = {
 	.ack_ptp_irq = true,
 	.counters_enable = tja1120_counters_enable,
 	.get_egressts = tja1120_get_hwtxts,
+	.get_extts = tja1120_get_extts,
 	.ptp_init = tja1120_ptp_init,
 	.ptp_enable = tja1120_ptp_enable,
 	.nmi_handler = tja1120_nmi_handler,
-- 
2.34.1

