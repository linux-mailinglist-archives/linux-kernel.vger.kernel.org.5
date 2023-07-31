Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7994769166
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjGaJSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjGaJR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:17:57 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6008EE4A;
        Mon, 31 Jul 2023 02:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K03A4l2D5N9ixBUku0Ein8XQZpkQTB7MfDFXNJ8rpwSE4qrQNgQaOk44LDWZw6k/ivSSeKVs6ybHCoYhW6NDnc4mIU27CaqJLdM4n+nvE40PUciiwJKVIJDltUtxTOIR4RyTtYivmCCEZbhp4RiIwFX+eSBQM0b6gznvv7mB083buseJj7mmhDKa+cRHxfZg4EgVOQQ8tEFlVrkWyVGfqOIa6fxGP1ROPnH9g6RuCjo5++hZasocUkN8OuanyAwZJ+GJKx83sCYJ12vAeI/akk5pTSmrnQYw19xg7X6+rv1ltqVBTqPaR/UE8bOzHYlvt3/RWlRPqJZYNTnKpYPqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQ7+//hB2nHBuYRnT0c7NqDKl+YugPnH0JGutZ7CRUs=;
 b=LzbD0rhDOMhw4YG8uG7Xt9d48aaUoNnOnwOlYrZD/d0/+lV35fG9GvvVjxWKse+GTZ8FBwx9ml7sk/V0wmevs1H/ImOMrjQxwrONDWspnfX1Z3Fl1XiHN1TyH1AyPsIjDuj1+57fRDnTy39uUHrhhU8CLu8UIa3SkqTUcbzFAe2knk12l+ehGc9vQXMbexTnsX+x5DxBg6lC5cBbrHeXatKV2XMDXv7hEJUL5/rZHqH6kxlwGXhSRPivjJ6j+06n8FDuoFgeN1a3XeN9IbiQapjRroaBxbBr6aP6uYF4Bvxr0FSrco8tZFxWwOO/KXxxTfirlzez3UBLPEgghz4WZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQ7+//hB2nHBuYRnT0c7NqDKl+YugPnH0JGutZ7CRUs=;
 b=eDpar4bLWAZBgKFtOd4AvSsVFLzDKXUUE3JtDk/lMU6CuZ3FmhKDmZ280ZU7diMwoe1b/EePinw1eGxWlrOag4jC4tF2dNKDwhWMTAK+WiuzbxUSsTEwVIFCaXOTRzvW93IrYgXZsEvAxuMe0cyyfh3pSv5o7Kt6C9fXvGPz3EU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by GV1PR04MB9085.eurprd04.prod.outlook.com (2603:10a6:150:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 09:16:46 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936%5]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 09:16:46 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v5 10/11] net: phy: nxp-c45-tja11xx: read ext trig ts on TJA1120
Date:   Mon, 31 Jul 2023 12:16:18 +0300
Message-Id: <20230731091619.77961-11-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4280c740-3d3d-457c-5d08-08db91a6dd06
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GVuGniuwJL6NVU3wukxA+k/BFQLbyQScRVMJG7dFIsStSQZoOwYnEIA9+dChenh9T9F5rJodBRfxDiRCh5Xsq8WfpREVZs6gTnmR+rfwDZ0ACXHBRX13D6E1dJp719KfVBky7bnz1AkcII6Bdm9xJez4nc7BmeQuhk9gVadnA83aaYdhAOM71KySsDwoBA2O/j/mzSzpnc/7vjQ5jnLGzb3nPMwzQ/FExyGPpnTqyDu+Xy0whNPsXF0Jfco5QU7XN3KBThQYlQfgIiNQgC6hfYCfkrhI1vFb6iaPaGByj6nyZFX9euH8P7RlTTdi82kK3zi07GwXZLMhJXA71pPuUeo65AUO/F2S2PlikVYGez5JzW4b11H+8KqSYS/F9UKZQ4B6/ladVjzbWtgl4894m4w5RoDfBN1BZAvXttUiesbyiYZdf1f6zm7DzGaHVzw0s/8eE9dmmrFGo0DEVqekXD5gQ34TyKhnx+7jc/i2gUzP4LY36umwaXZDyxdsiR8iY86XmRQdqnU3q7oVcp4devdfzaBU+SjHANESC3QJ+ZGWAQeBBoPSMxGMd2NJw6EPXlrV38s6s7U/E97LW5pgbAGuHrHxKof9nQS5nq/bA6eEfDpK8wmK8SjFw659GoJX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199021)(66476007)(86362001)(41300700001)(8676002)(8936002)(316002)(5660300002)(4326008)(7416002)(66946007)(66556008)(38350700002)(478600001)(2906002)(38100700002)(6666004)(6512007)(52116002)(6486002)(6506007)(1076003)(26005)(83380400001)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NjXLkdm2lfjYCTKr7H7WCr3e18cOqgCp6US6zxlep90ckaSiXiCeHR+pIYJz?=
 =?us-ascii?Q?3PV3VDZMumbaqXIWI3c9J7lVZR9+DnBRHbEUk4AR4SkKp49S8neYBZjW890n?=
 =?us-ascii?Q?sDohhZ6CjQPdnwpJYDtmShg7E0p6NGsepAlXX2+S3GbNNpLMMOSD1HU4MzFh?=
 =?us-ascii?Q?09vI+U87I4RiWkXFiOrKRJ9RTnQwxcItY2HIzsycLlivZP9Yi0voLTZpkOtR?=
 =?us-ascii?Q?9UcCp5VN4NBbqjEMZmzMpeEL4LH/jU+lRYFEEWZX0Rajp3/K6LVONgFif/O4?=
 =?us-ascii?Q?2t+ar9WLECqVeeFHBgbRp4V1BvOr59msZbkZCVCqvRu8Z9HEt98DnGIeoajd?=
 =?us-ascii?Q?SssOP551r5Rt/3MwSkecjS2qnUMcA5g0jghac7MtA05o85YOm0Sct3Om2DUN?=
 =?us-ascii?Q?3FSvTRRD/IHCdEIBO3t7IGLKaTMDuuKotZyKTIVnNl3vEDtRi6kHoMAl2Z7g?=
 =?us-ascii?Q?e8K+m1IgZoa/aPA95peC3qUUOtxHU+GDWhp0W85qr0/OebonCNeF9wCoG2T2?=
 =?us-ascii?Q?EEdywA+9s/UwUWn9RyAc6lzGSru6CjZEcxNKVUkFxLvih/8tE88rfffyktp7?=
 =?us-ascii?Q?C0hWSD+8hIrDjFC0NTF+AhwgarW0fTBCqd++52/RLLW2xNoF4iPm3fXpEFPe?=
 =?us-ascii?Q?vagN7pYVuo2f3/fn+XcvehvtOxjWFhOnLpAIatAyUCYax8U4+DsPb9s7+VqB?=
 =?us-ascii?Q?Dag9/wQBR1EJ7BiFJ+yu2KEgt97U8Mh1xBnPjStLSQGu2lJTF1ByLZtZZ2Yv?=
 =?us-ascii?Q?Wy3uWAhNcpVgLxu88ejTMp0Jwn1/EZpKedpax8pdIkrCHBnju7/nLWRwHXcg?=
 =?us-ascii?Q?PR62WqEZ8mibXbbjN5tsG3pebhL+XF+8TQ88cDqWcg5trhvD5D51qJNLVbwF?=
 =?us-ascii?Q?67vc4oioGg3wZr5HRxfa4bXX2pnR3fD1OzjORmJvro3kq05C55LqTMCTd084?=
 =?us-ascii?Q?92stB2rNvD0N8PWjcWpT+b08mWIGWfSMWhe5sHqLNNblyxmsMY9yRCv9W5Cy?=
 =?us-ascii?Q?H+GLH8Uyxs/rdxP/7ykMqbP2Ysba0qUcVWQo0gNJKVyz2fHtmDRiD7fLnr7K?=
 =?us-ascii?Q?FE8G3p3LyaVKtRqD/q3jjOJWWbNgxaHBBkza8k6Cgu3B6w+k6ld6BYR2Bz8Q?=
 =?us-ascii?Q?vwJngyjQKXq3/3rYt5JNsMqAvMNdzWV3zdzLBg7MdR2mkMvwoeRChxiCJPqJ?=
 =?us-ascii?Q?DSLnDnFnGoK9VXoGIRnKqELl+wpGHnqPzM+lLQHlcOEfj9p+zuhGOXFpgbWq?=
 =?us-ascii?Q?ORId+bK1jAV+I29FGnK00a6yGP8hAXrF7S/EUNRUwytm6D6Y9jSo5duQZyIO?=
 =?us-ascii?Q?wtC+z6zkF9hjHunFdGbWcB5cQAtWL73SuwPFLzL6zl/KJpEzTXFq395UIWgy?=
 =?us-ascii?Q?KAcBhLVdHbsC97NBoYjSJvn4oMyBTIYJ94ernYRKnkDwdtZxfz1KM3aMjGnm?=
 =?us-ascii?Q?jAnoDeQY6u0Bkj78cjvqqmokMpdNXgZPb7gp2yVpIeif8j33PpojKgFZpSyB?=
 =?us-ascii?Q?KDLz4VxYo2UXGDQdzlW6MfeFu02GXq9/vzmb5dTjW3IALU/dowgZla4IV/Hx?=
 =?us-ascii?Q?iR58kzkxsqV89OWcJ88rkaoFFH3M0lyLgnhLqSj3iZPrf1MgMEdP8TxF91Qx?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4280c740-3d3d-457c-5d08-08db91a6dd06
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:16:46.2889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hth33ND1SOpakAbdv1YeQyCBkPYN5qtN4TybXs9xdliWLg11YyZzcffQ8ZZaavc7NflFXg8PmP/Nksry2ECZ6OX/uFvAoICDLqdBhiGsxW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9085
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
index 92a2eca2a02c..48657307ffb5 100644
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

