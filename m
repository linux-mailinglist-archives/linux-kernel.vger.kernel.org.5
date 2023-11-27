Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A20F7F9D83
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjK0K2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbjK0K2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:28:44 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4DA192;
        Mon, 27 Nov 2023 02:28:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imZ8fFun5olhN1oTYcz6fjZXIDPcNMBMWWWJmAohcEVsWFSssSf1DpzuCkDMVZxl/lf6vEHp2QXQAdSZlJ5I4qrmhbEohs/L7+akW5PJ7rVjPQujLrEdSe33EOXWx51OOui464kad5IxJHst8uAW/f+0ZrAvVnF6fVcj+JXjCGurzuFuUV6ad69tdIXlB5Au/Zrb0Lt6hQmTX2BaN6VcWE7CkZco6+MzV43Y4JmkjsRZx5J3boci5QwXA2g9nB4D8CqlUOm7z2bt1bFTB1voiMGG38iXj04nLYIU3aXByqS+ANX+30o7tlEQfGpi+fMBHu9oZkcrVt0sAmu+Cj2W4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adrn8x4Xb9ucyvP9lmiGhChyGVZHEshSZWsFtIJ7jaE=;
 b=dm/SRxuiOFln+5Yu2I1r9lur3GKRxPrtlbWwzCrMlrZ5WU4UZEySVKpkrXdpMMse+uP/ooPFh1lWB45VYyWKkn031OlM8etFryFh3mkl+hgl3L3ZlMZqGEJhnrno+vMlFPOyHR7O4oW4AoT98C7srXmYidtvtSZhOMoA3LO0/5IGf70/QBqDCLk7HmYeS7LXyRsmnGBVbuX7tIsEoICetvXPGsIOFtrpHemHvB+R/5hp1LPYDXtKmPDlfmVtkXo/7R6gelPQ/Op80V206nIg1JNfUUPhVZa2seNQQrBiX8ZTuNAqtuIY8C/dzji4WHwEw0DvlouaoK7+XyolRYd4Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adrn8x4Xb9ucyvP9lmiGhChyGVZHEshSZWsFtIJ7jaE=;
 b=hFUF5YBfuXAFccUF60u8OIDCiW0ggfFFBqZalS1SVVUUKzaBVTtdxG59P2+u4QSOeDz5M1lJzP/1BkJ/KwSYm+Wr8yesFlQ72sVAAq5n+af56Zrh1MnK96H3s9T+PtYeC+LwLxdPN+vv2MMYpT85H9cZImsagXDasV28hxGWpcA=
Received: from SN1PR12CA0106.namprd12.prod.outlook.com (2603:10b6:802:21::41)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 10:28:43 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:802:21:cafe::e9) by SN1PR12CA0106.outlook.office365.com
 (2603:10b6:802:21::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21 via Frontend
 Transport; Mon, 27 Nov 2023 10:28:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 10:28:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 27 Nov
 2023 04:28:41 -0600
Received: from xhdvnc205.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Mon, 27 Nov 2023 04:28:37 -0600
From:   Srinivas Goud <srinivas.goud@amd.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <p.zabel@pengutronix.de>
CC:     <git@amd.com>, <michal.simek@xilinx.com>,
        <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <appana.durga.rao@xilinx.com>,
        Srinivas Goud <srinivas.goud@amd.com>
Subject: [PATCH v7 2/3] can: xilinx_can: Add ECC support
Date:   Mon, 27 Nov 2023 15:58:14 +0530
Message-ID: <1701080895-1475-3-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1701080895-1475-1-git-send-email-srinivas.goud@amd.com>
References: <1701080895-1475-1-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|DM6PR12MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d0561f-ead9-4904-7802-08dbef33a10f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oBHB1Tpyewm4YyahILV9nI01TUcaAT/v4HnTb06K4rV9jN5o8zrCkQvvlkdycgB/dKsJ1w/IIdYaYbUXunVUbccDW2612KaBsGumMlnolD+/P1t0d5qzlRcACq5Rdlr9Dtz9Xep1P05zrF+siMzsxBd313LX9rIey+viDsI8kJpAqeF5bg0sgnbmP5t5vNfrHKkczcrwRw9eCS2rI6xlo//Gv/ft1IUKSPLz46PLWyPgiVvIpfVT9tk9/lORzQ/Jz2SqAtKW2MRSni1KuBwC1RCQgQVUXdWZgkLEtjWadgxe9lcaUuyshbNmOLPBChwmW7159UcRAKNtfQmVSV06kczEllMjn/TvgX+7fQXE2D+pRCDPG0B7lHyp0cMe99p81G9ZM+fG0dLXm3tyHtnAnDb7SZZe2L+u+JgsHRRoNLtGFfgQBkh+Xhuy/sif377biVIlSa4IKxEanS2/rThs3sOHuMmsxA0h4ymudQnVir6MV6WvAA+NSN/G8WCGPNUuRZOsH95q1NF3Fcp8lZ/y1BKjI2wkmdEjlCW0oyJ+dkoakHIz8hu90+6FhcF5AwnDj6lo67yoMQT47y+pmKgzDMQ+Cmi/e7pcc8b0jbKA9QJKwFo1cI39e5NQDrsfZr6/BjbF16mcnY2F/8z34bcpTm9fZ9GRaXmAMNCZ+x7RQ/l268X/pPn29cINWd3GQcIXLaQxx3nV9BgogFSF8TYsMUvrOBcngtWP+KubKic8FjyGa1PqYOqeAloHWo94GE4/GC7ptpnq+hSMGfUje+7DEEGYFUg8qbd/J+DMxBVbFlY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(82310400011)(1800799012)(451199024)(186009)(64100799003)(46966006)(40470700004)(36840700001)(83380400001)(81166007)(356005)(47076005)(426003)(336012)(82740400003)(8936002)(6666004)(8676002)(110136005)(316002)(70206006)(70586007)(36860700001)(54906003)(86362001)(44832011)(4326008)(7416002)(478600001)(5660300002)(40480700001)(41300700001)(2906002)(36756003)(921008)(26005)(2616005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 10:28:42.7104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d0561f-ead9-4904-7802-08dbef33a10f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ECC support for Xilinx CAN Controller, so this driver reports
1bit/2bit ECC errors for FIFO's based on ECC error interrupt.
ECC feature for Xilinx CAN Controller selected through 'xlnx,has-ecc'
DT property

Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
---
Changes in v7:
None

Changes in v6:
None

Changes in v5:
Address review comments
Change the sequence of updates the stats
Use u64 stats helper function

Changes in v4:
None

Changes in v3:
None

Changes in v2:
Address review comments

 drivers/net/can/xilinx_can.c | 105 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index abe58f1..c8691a1 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -31,6 +31,7 @@
 #include <linux/phy/phy.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
+#include <linux/u64_stats_sync.h>
 
 #define DRIVER_NAME	"xilinx_can"
 
@@ -58,6 +59,13 @@ enum xcan_reg {
 					  */
 	XCAN_F_BTR_OFFSET	= 0x08C, /* Data Phase Bit Timing */
 	XCAN_TRR_OFFSET		= 0x0090, /* TX Buffer Ready Request */
+
+	/* only on AXI CAN cores */
+	XCAN_ECC_CFG_OFFSET	= 0xC8, /* ECC Configuration */
+	XCAN_TXTLFIFO_ECC_OFFSET	= 0xCC, /* TXTL FIFO ECC error counter */
+	XCAN_TXOLFIFO_ECC_OFFSET	= 0xD0, /* TXOL FIFO ECC error counter */
+	XCAN_RXFIFO_ECC_OFFSET	= 0xD4, /* RX FIFO ECC error counter */
+
 	XCAN_AFR_EXT_OFFSET	= 0x00E0, /* Acceptance Filter */
 	XCAN_FSR_OFFSET		= 0x00E8, /* RX FIFO Status */
 	XCAN_TXMSG_BASE_OFFSET	= 0x0100, /* TX Message Space */
@@ -124,6 +132,18 @@ enum xcan_reg {
 #define XCAN_IXR_TXFLL_MASK		0x00000004 /* Tx FIFO Full intr */
 #define XCAN_IXR_TXOK_MASK		0x00000002 /* TX successful intr */
 #define XCAN_IXR_ARBLST_MASK		0x00000001 /* Arbitration lost intr */
+#define XCAN_IXR_E2BERX_MASK		BIT(23) /* RX FIFO two bit ECC error */
+#define XCAN_IXR_E1BERX_MASK		BIT(22) /* RX FIFO one bit ECC error */
+#define XCAN_IXR_E2BETXOL_MASK		BIT(21) /* TXOL FIFO two bit ECC error */
+#define XCAN_IXR_E1BETXOL_MASK		BIT(20) /* TXOL FIFO One bit ECC error */
+#define XCAN_IXR_E2BETXTL_MASK		BIT(19) /* TXTL FIFO Two bit ECC error */
+#define XCAN_IXR_E1BETXTL_MASK		BIT(18) /* TXTL FIFO One bit ECC error */
+#define XCAN_IXR_ECC_MASK		(XCAN_IXR_E2BERX_MASK | \
+					XCAN_IXR_E1BERX_MASK | \
+					XCAN_IXR_E2BETXOL_MASK | \
+					XCAN_IXR_E1BETXOL_MASK | \
+					XCAN_IXR_E2BETXTL_MASK | \
+					XCAN_IXR_E1BETXTL_MASK)
 #define XCAN_IDR_ID1_MASK		0xFFE00000 /* Standard msg identifier */
 #define XCAN_IDR_SRR_MASK		0x00100000 /* Substitute remote TXreq */
 #define XCAN_IDR_IDE_MASK		0x00080000 /* Identifier extension */
@@ -137,6 +157,11 @@ enum xcan_reg {
 #define XCAN_2_FSR_RI_MASK		0x0000003F /* RX Read Index */
 #define XCAN_DLCR_EDL_MASK		0x08000000 /* EDL Mask in DLC */
 #define XCAN_DLCR_BRS_MASK		0x04000000 /* BRS Mask in DLC */
+#define XCAN_ECC_CFG_REECRX_MASK	BIT(2) /* Reset RX FIFO ECC error counters */
+#define XCAN_ECC_CFG_REECTXOL_MASK	BIT(1) /* Reset TXOL FIFO ECC error counters */
+#define XCAN_ECC_CFG_REECTXTL_MASK	BIT(0) /* Reset TXTL FIFO ECC error counters */
+#define XCAN_ECC_1BIT_CNT_MASK		GENMASK(15, 0) /* FIFO ECC 1bit count mask */
+#define XCAN_ECC_2BIT_CNT_MASK		GENMASK(31, 16) /* FIFO ECC 2bit count mask */
 
 /* CAN register bit shift - XCAN_<REG>_<BIT>_SHIFT */
 #define XCAN_BRPR_TDC_ENABLE		BIT(16) /* Transmitter Delay Compensation (TDC) Enable */
@@ -202,6 +227,13 @@ struct xcan_devtype_data {
  * @devtype:			Device type specific constants
  * @transceiver:		Optional pointer to associated CAN transceiver
  * @rstc:			Pointer to reset control
+ * @ecc_enable:			ECC enable flag
+ * @ecc_2bit_rxfifo_cnt:	RXFIFO 2bit ECC count
+ * @ecc_1bit_rxfifo_cnt:	RXFIFO 1bit ECC count
+ * @ecc_2bit_txolfifo_cnt:	TXOLFIFO 2bit ECC count
+ * @ecc_1bit_txolfifo_cnt:	TXOLFIFO 1bit ECC count
+ * @ecc_2bit_txtlfifo_cnt:	TXTLFIFO 2bit ECC count
+ * @ecc_1bit_txtlfifo_cnt:	TXTLFIFO 1bit ECC count
  */
 struct xcan_priv {
 	struct can_priv can;
@@ -221,6 +253,13 @@ struct xcan_priv {
 	struct xcan_devtype_data devtype;
 	struct phy *transceiver;
 	struct reset_control *rstc;
+	bool ecc_enable;
+	u64_stats_t ecc_2bit_rxfifo_cnt;
+	u64_stats_t ecc_1bit_rxfifo_cnt;
+	u64_stats_t ecc_2bit_txolfifo_cnt;
+	u64_stats_t ecc_1bit_txolfifo_cnt;
+	u64_stats_t ecc_2bit_txtlfifo_cnt;
+	u64_stats_t ecc_1bit_txtlfifo_cnt;
 };
 
 /* CAN Bittiming constants as per Xilinx CAN specs */
@@ -523,6 +562,9 @@ static int xcan_chip_start(struct net_device *ndev)
 		XCAN_IXR_ERROR_MASK | XCAN_IXR_RXOFLW_MASK |
 		XCAN_IXR_ARBLST_MASK | xcan_rx_int_mask(priv);
 
+	if (priv->ecc_enable)
+		ier |= XCAN_IXR_ECC_MASK;
+
 	if (priv->devtype.flags & XCAN_FLAG_RXMNF)
 		ier |= XCAN_IXR_RXMNF_MASK;
 
@@ -1127,6 +1169,50 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 		priv->can.can_stats.bus_error++;
 	}
 
+	if (priv->ecc_enable && isr & XCAN_IXR_ECC_MASK) {
+		u32 reg_rx_ecc, reg_txol_ecc, reg_txtl_ecc;
+
+		reg_rx_ecc = priv->read_reg(priv, XCAN_RXFIFO_ECC_OFFSET);
+		reg_txol_ecc = priv->read_reg(priv, XCAN_TXOLFIFO_ECC_OFFSET);
+		reg_txtl_ecc = priv->read_reg(priv, XCAN_TXTLFIFO_ECC_OFFSET);
+
+		/* The counter reaches its maximum at 0xffff and does not overflow.
+		 * Accept the small race window between reading and resetting ECC counters.
+		 */
+		priv->write_reg(priv, XCAN_ECC_CFG_OFFSET, XCAN_ECC_CFG_REECRX_MASK |
+				XCAN_ECC_CFG_REECTXOL_MASK | XCAN_ECC_CFG_REECTXTL_MASK);
+
+		if (isr & XCAN_IXR_E2BERX_MASK) {
+			u64_stats_add(&priv->ecc_2bit_rxfifo_cnt,
+				      FIELD_GET(XCAN_ECC_2BIT_CNT_MASK, reg_rx_ecc));
+		}
+
+		if (isr & XCAN_IXR_E1BERX_MASK) {
+			u64_stats_add(&priv->ecc_1bit_rxfifo_cnt,
+				      FIELD_GET(XCAN_ECC_1BIT_CNT_MASK, reg_rx_ecc));
+		}
+
+		if (isr & XCAN_IXR_E2BETXOL_MASK) {
+			u64_stats_add(&priv->ecc_2bit_txolfifo_cnt,
+				      FIELD_GET(XCAN_ECC_2BIT_CNT_MASK, reg_txol_ecc));
+		}
+
+		if (isr & XCAN_IXR_E1BETXOL_MASK) {
+			u64_stats_add(&priv->ecc_1bit_txolfifo_cnt,
+				      FIELD_GET(XCAN_ECC_1BIT_CNT_MASK, reg_txol_ecc));
+		}
+
+		if (isr & XCAN_IXR_E2BETXTL_MASK) {
+			u64_stats_add(&priv->ecc_2bit_txtlfifo_cnt,
+				      FIELD_GET(XCAN_ECC_2BIT_CNT_MASK, reg_txtl_ecc));
+		}
+
+		if (isr & XCAN_IXR_E1BETXTL_MASK) {
+			u64_stats_add(&priv->ecc_1bit_txtlfifo_cnt,
+				      FIELD_GET(XCAN_ECC_1BIT_CNT_MASK, reg_txtl_ecc));
+		}
+	}
+
 	if (cf.can_id) {
 		struct can_frame *skb_cf;
 		struct sk_buff *skb = alloc_can_err_skb(ndev, &skb_cf);
@@ -1355,7 +1441,7 @@ static irqreturn_t xcan_interrupt(int irq, void *dev_id)
 	struct net_device *ndev = (struct net_device *)dev_id;
 	struct xcan_priv *priv = netdev_priv(ndev);
 	u32 isr, ier;
-	u32 isr_errors;
+	u32 isr_errors, mask;
 	u32 rx_int_mask = xcan_rx_int_mask(priv);
 
 	/* Get the interrupt status from Xilinx CAN */
@@ -1374,10 +1460,15 @@ static irqreturn_t xcan_interrupt(int irq, void *dev_id)
 	if (isr & XCAN_IXR_TXOK_MASK)
 		xcan_tx_interrupt(ndev, isr);
 
+	mask = XCAN_IXR_ERROR_MASK | XCAN_IXR_RXOFLW_MASK |
+		XCAN_IXR_BSOFF_MASK | XCAN_IXR_ARBLST_MASK |
+		XCAN_IXR_RXMNF_MASK;
+
+	if (priv->ecc_enable)
+		mask |= XCAN_IXR_ECC_MASK;
+
 	/* Check for the type of error interrupt and Processing it */
-	isr_errors = isr & (XCAN_IXR_ERROR_MASK | XCAN_IXR_RXOFLW_MASK |
-			    XCAN_IXR_BSOFF_MASK | XCAN_IXR_ARBLST_MASK |
-			    XCAN_IXR_RXMNF_MASK);
+	isr_errors = isr & mask;
 	if (isr_errors) {
 		priv->write_reg(priv, XCAN_ICR_OFFSET, isr_errors);
 		xcan_err_interrupt(ndev, isr);
@@ -1796,6 +1887,7 @@ static int xcan_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv = netdev_priv(ndev);
+	priv->ecc_enable = of_property_read_bool(pdev->dev.of_node, "xlnx,has-ecc");
 	priv->dev = &pdev->dev;
 	priv->can.bittiming_const = devtype->bittiming_const;
 	priv->can.do_set_mode = xcan_do_set_mode;
@@ -1912,6 +2004,11 @@ static int xcan_probe(struct platform_device *pdev)
 		   priv->reg_base, ndev->irq, priv->can.clock.freq,
 		   hw_tx_max, priv->tx_max);
 
+	if (priv->ecc_enable) {
+		/* Reset FIFO ECC counters */
+		priv->write_reg(priv, XCAN_ECC_CFG_OFFSET, XCAN_ECC_CFG_REECRX_MASK |
+			XCAN_ECC_CFG_REECTXOL_MASK | XCAN_ECC_CFG_REECTXTL_MASK);
+	}
 	return 0;
 
 err_disableclks:
-- 
2.1.1

