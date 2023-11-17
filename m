Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7704F7EEEA6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345710AbjKQJan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345758AbjKQJaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:30:08 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAA0D7A;
        Fri, 17 Nov 2023 01:30:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eStAvRDqIzLUgOgvqRs/ZBMxqK+mqQ6BYjo1NUSJNkj5pk1c01RUYX6bqVyZCNX/zpOtRpbouN3hszobeqz1w9SK5uey0vmnDbOsBu5S+j0Vb+Q4Ty28A5KcnrwtEY57mtamrQXAkDJLEW0MDEUfUkeYRxoWQWDjnqURZIccEX9hPk6Qt3DhfUz2SSSYLeJpn4N8TIuhwn1z4K7Z0GJYyPcoXmfnPfKLMnnxuYg68zLvsNrqDwrJna2wQl+EwgcbaVScn6NfBUAmbs7ZyOSSQT3Wa65StY1WaEnMv1Jhx1Nv8J7RrVulKo13VhbjshcACrwacSCWooAFi9dPU0w+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSqUIaLKUg4pFLio6Ww6X3/0Xy7t88D1Fq5Xn+n6KYM=;
 b=eiDGk0z5ZiJ36nhsYssD2ra5Ho+rn3WyoOBjwIqEBNxgV/+wNYmXkurTYuz8RiwH9wziI4IimLgQ1vZZIqzUBVCWk+Hz0y3zhzU1Q7gTofq9gmUzv8TRlR24xSVD/if+lGXf8XBAf8ihCR3I2PgvRMtUV8cwNN4OmJHaz9ahn6JkzbL07JVuXIqPZkBmzLRmNI1AufBaYhGUspwHHsyH16gvlWlnABY6dhgLLBtRZQuaVOrfINd/tPuOx0cr+KahENV639pXFlLX17tK2GzTV2/KXSkS4pnl5XzEca/CUgHuOSLoO8IlfrMaQ0FCjFTJSkZp5uAvHyhfOuk0o4E1MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSqUIaLKUg4pFLio6Ww6X3/0Xy7t88D1Fq5Xn+n6KYM=;
 b=ZjJrNjMzAcEzuOLSVGd7L9Nq0EbcqcJumJaRTl3bEiI7viP12kejvUAPqa6G12HlLh+di28SE5RdVF6nxij08WJrqrFOMzfqmxAV4UV6NN9bjGntSwXg8zWC9ocZin1gkQA009f6NQbYFMv2yJA0DoXCOovEM7VcOztZLoWB5+4=
Received: from SA0PR13CA0022.namprd13.prod.outlook.com (2603:10b6:806:130::27)
 by BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 09:30:01 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:130:cafe::2e) by SA0PR13CA0022.outlook.office365.com
 (2603:10b6:806:130::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.9 via Frontend
 Transport; Fri, 17 Nov 2023 09:30:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Fri, 17 Nov 2023 09:30:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 17 Nov
 2023 03:29:58 -0600
Received: from xhdvnc205.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Fri, 17 Nov 2023 03:29:54 -0600
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
        <naga.sureshkumar.relli@xilinx.com>,
        "Srinivas Goud" <srinivas.goud@amd.com>
Subject: [PATCH v5 2/3] can: xilinx_can: Add ECC support
Date:   Fri, 17 Nov 2023 14:58:55 +0530
Message-ID: <1700213336-652-3-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1700213336-652-1-git-send-email-srinivas.goud@amd.com>
References: <1700213336-652-1-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|BL1PR12MB5221:EE_
X-MS-Office365-Filtering-Correlation-Id: a7865918-a121-4149-f3ce-08dbe74fc5d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vb9THgW6wAOEqSj8OIbbiGo8jc07YuDlG6RftFYmUPkpki8fCjhA5KJEDlH7Kbs2HRlWfJvxVhRgiHnz6+70dKUypoIzuJCo86RTqY//JAlUpTHCM2gd34pvSiktKE3cy2YISI+TV8TPSKb1gPzyrQrXl/kvLYODx70TybkZT0I9GCw2nakcgzgL7l/ix2ofJDAj8zYL1QpEI6+dzm3eg97JFumNV3WvvBlgSH5BMnp8XZex5WDyulnd3md96bsMyFdvdkdKiHm6SbahNpxYnBfkWFln0gXD3JwCTUgmNzXZ9uyGIRGB8dWaoRkBTCw+EpsuN5pujQdIJHIE7+pJWea7YoyX+10UPEa4/wEhIarOn1tuEaPpyoqzHQ5D56HRjZ3ARw+b/VKvjnNYcv0kAW3jwsS8RiV49UPUOmFFybZ6Eva77LpZAJQdAzvMa91I6neOK1uA1sGvh+hBhD+tMBWLIINo+ua04X79/kjD4PT7uLKMar6C/ZYiLYbq+7cqtl37HFRJ0fgcrLkMhsEa9rhPaKIqAmIgaZIdezaLCMNMcFDPMdGlHR7/2yOX1OtgsrknIg4fUzbuNC5E77ZVzJAQts4qXan1Uukj4D8KhXhoDigq1g6dQAixoXBHaKVHaCU027n2rIz3KzT7djep3fyo+JE+n+pgKaQzyLvGLj7z6DMDbv6azihDWVmWU0I8/DzYX0ckdpcXmFGuhQ8d2dbBW9QZlwkr+k9G3mCVSwGHGl3xXECwuAj+3aKva6Oi3dyG14JN4yCjKKcDcBujtd0jIknRRBbuFYDEYw+eA7E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(40480700001)(478600001)(83380400001)(2616005)(26005)(110136005)(70586007)(54906003)(316002)(426003)(336012)(70206006)(36860700001)(82740400003)(44832011)(5660300002)(2906002)(47076005)(41300700001)(86362001)(356005)(81166007)(7416002)(36756003)(4326008)(40460700003)(8676002)(8936002)(921008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 09:30:01.0194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7865918-a121-4149-f3ce-08dbe74fc5d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5221
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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

