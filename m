Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E27783E35
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbjHVKqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbjHVKqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:46:06 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CBCCE3;
        Tue, 22 Aug 2023 03:46:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuYgMyptLH/wxbQDgdRSqAk1nOGC4XsUlQ2niVRAiz9SMc/VYeWO1bK6ZcJ254P/US+A2Rby6MfntaoWClgNuIIlcUpTL3GK7Rc76ksbq7/7K9jd+aOSEnQaYUPE3/C3GwN0RjDGBdY7Zs4vOC0EAMOhCRI4fpN6TZf/5TZzdkPl64zvMfemaXLhTmEPlX+XTAY0qhhGNpEiwvLCfRXtzfujV8ukM9T+yIIhX8iDxxx2eh3lhQCcz8GpisTdEnrMo+bZ5dlfuJPF71Pm2A+T7NXFzGqEOFIGsqfW+UeMtk5vEvJtovXtldfG8OQsdxONzu0hR4SWYTz8ajpBZiRVaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGiTEPnm28PmrIZe5Tb4lCbvnQidsfAeguQg7AAlVFs=;
 b=ZQ2vP7Fv7Fi56nRrMy8FSl5mQf8ESOHHC5m5Shf7qVcKBhX9Lypq76liWg53bN0RE4AFcE+C60PdawIgSq667AKMF+SJTiCrbj6CRyvwN6PTlSCSKSuYExS6LVhBYF7dWFywRNVfU4PEVrFXF36+fgMkFKO5Gozo8FjUcbGeYEPHaauhGtR55keVV1X3NM1F/bDZRrcOeh1qsd/TcDoWfCqnzo6hHPKmtd9KpocyNYlj0qwsR26zTpG+bCGZwuvuQcE2wI/rCBhRabRoYS4zJ1LAr296jU6w89BvCKvGWuRSOWWTQXoTOoRE+FJPbpusxF/fqPTHeHazncHAt//FUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGiTEPnm28PmrIZe5Tb4lCbvnQidsfAeguQg7AAlVFs=;
 b=lmmYsniqZiuJWFc2aUnkP6MJFYZFUmRnHFoPDllRdAsmz6qbAUoUm9uDhdHCVtvHMkTmUOdA18byUV3tKuKRjZ7jW6c0dLWR9zZOv3uRf07h4jOttUAdY8cQ35b9bcg6vjtxlnXNLJ5PKgRLuKZXFmpWcT1P3HWcSWnZiPlhkgs=
Received: from DS7PR03CA0212.namprd03.prod.outlook.com (2603:10b6:5:3ba::7) by
 DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Tue, 22 Aug 2023 10:45:59 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::6c) by DS7PR03CA0212.outlook.office365.com
 (2603:10b6:5:3ba::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Tue, 22 Aug 2023 10:45:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 22 Aug 2023 10:45:58 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 22 Aug
 2023 05:45:57 -0500
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 22 Aug 2023 05:45:53 -0500
From:   Srinivas Goud <srinivas.goud@amd.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <p.zabel@pengutronix.de>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-can@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <gcnu.goud@gmail.com>,
        Srinivas Goud <srinivas.goud@amd.com>
Subject: [PATCH v2 2/3] can: xilinx_can: Add ECC support
Date:   Tue, 22 Aug 2023 16:15:35 +0530
Message-ID: <1692701136-1422086-3-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1692701136-1422086-1-git-send-email-srinivas.goud@amd.com>
References: <1692701136-1422086-1-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|DM4PR12MB5120:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee2c12a-e6a4-433d-75e8-08dba2fcf8a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jvuXuJjsSIzNk1NTt0sMI2mEjqVVKghKjuJgiGmGq8AgS1Wex9weuI76ddPrbYhkM+JH3yx0qXWJTQu6IfipnG32KMPbSPqDtxaZbSTAyWMoPCmckA7b4nUIcTRSYpT4IwZTuDt9saZNyRpXc+5HOt7eM8zWOd7DEeh4+ob5SDAjiuAV/JPyaLYff0IWZHEi1tTTGc5/d6lXkMr6GkMCRQMDGJqdf+DvpWVoQbLuZwbOTBvTyul4TJH2svBJslb3xb98Jcg6IWdQgank0roXzRjtWUGDJuM3roKCv1h9BA+5paLh0bSlPyn3SNIHwx+gzmNZpvV7ii747RUST72uN/Uwq5+2i58RMotwyeTNLjnG23ObZPzMYyrnKT6nwW9lOTtVF3jq/XMhhZZ+3qms+dBUOBYoqsyJvV8VJlIk2aG9Av7+8ayOOCDloINm3QO9y/AQjGppPvNPxKPpX2eEoQVgMGWkgswRVPueD+3D6b4w++/N/K/Ua6KC/Kk2Wr5H/MZCJyiCwBlGhpy8OPm+Ay8VXkTGcKvusIbR+zLEmjHinQzWtM6oE5/xlsFUAm36vs8Mc1/O8QFiNAqJp318taoIzuIPv/4Y8pj6Ps9eL3oVaTC7lozgkCFE30GSbcCTkCU9nXhJZXFn/oaF/ibrnp1Hlk+dundPeAZrWcSgmy/WitFjXkQEwSHEoXwDMoeygxl22DcJdpykc0NwliPhxYz1Xm9SyTbml6WqRkdrbVaFGAZ78Vtv/yMGXilqCt9qX6Ug3hNPxReog2ZvzKcP8J8S/zxnINy3AAfsaTp73xc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(54906003)(70586007)(70206006)(316002)(110136005)(8936002)(8676002)(2616005)(4326008)(921005)(41300700001)(40460700003)(36756003)(82740400003)(81166007)(356005)(478600001)(6666004)(40480700001)(2906002)(7416002)(83380400001)(86362001)(47076005)(36860700001)(336012)(44832011)(426003)(5660300002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 10:45:58.8974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee2c12a-e6a4-433d-75e8-08dba2fcf8a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5120
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ECC support for Xilinx CAN Controller, so this driver reports
1bit/2bit ECC errors for FIFO's based on ECC error interrupt.
ECC feature for Xilinx CAN Controller selected through
'xlnx,has-ecc' DT property

Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
---
 drivers/net/can/xilinx_can.c | 129 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 114 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index abe58f1..798b32b 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -53,18 +53,23 @@ enum xcan_reg {
 	XCAN_AFR_OFFSET		= 0x60, /* Acceptance Filter */
 
 	/* only on CAN FD cores */
-	XCAN_F_BRPR_OFFSET	= 0x088, /* Data Phase Baud Rate
-					  * Prescaler
-					  */
-	XCAN_F_BTR_OFFSET	= 0x08C, /* Data Phase Bit Timing */
-	XCAN_TRR_OFFSET		= 0x0090, /* TX Buffer Ready Request */
-	XCAN_AFR_EXT_OFFSET	= 0x00E0, /* Acceptance Filter */
-	XCAN_FSR_OFFSET		= 0x00E8, /* RX FIFO Status */
-	XCAN_TXMSG_BASE_OFFSET	= 0x0100, /* TX Message Space */
+	XCAN_F_BRPR_OFFSET	= 0x88, /* Data Phase Baud Rate Prescaler */
+	XCAN_F_BTR_OFFSET	= 0x8C, /* Data Phase Bit Timing */
+	XCAN_TRR_OFFSET		= 0x90, /* TX Buffer Ready Request */
+
+	/* only on AXI CAN cores */
+	XCAN_ECC_CFG_OFFSET     = 0xC8, /* ECC Configuration */
+	XCAN_TXTLFIFO_ECC_OFFSET        = 0xCC, /* TXTL FIFO ECC error counter */
+	XCAN_TXOLFIFO_ECC_OFFSET        = 0xD0, /* TXOL FIFO ECC error counter */
+	XCAN_RXFIFO_ECC_OFFSET          = 0xD4, /* RX FIFO ECC error counter */
+
+	XCAN_AFR_EXT_OFFSET	= 0xE0, /* Acceptance Filter */
+	XCAN_FSR_OFFSET		= 0xE8, /* RX FIFO Status */
+	XCAN_TXMSG_BASE_OFFSET	= 0x100, /* TX Message Space */
+	XCAN_AFR_2_MASK_OFFSET  = 0xA00, /* Acceptance Filter MASK */
+	XCAN_AFR_2_ID_OFFSET    = 0xA04, /* Acceptance Filter ID */
 	XCAN_RXMSG_BASE_OFFSET	= 0x1100, /* RX Message Space */
 	XCAN_RXMSG_2_BASE_OFFSET	= 0x2100, /* RX Message Space */
-	XCAN_AFR_2_MASK_OFFSET	= 0x0A00, /* Acceptance Filter MASK */
-	XCAN_AFR_2_ID_OFFSET	= 0x0A04, /* Acceptance Filter ID */
 };
 
 #define XCAN_FRAME_ID_OFFSET(frame_base)	((frame_base) + 0x00)
@@ -124,6 +129,12 @@ enum xcan_reg {
 #define XCAN_IXR_TXFLL_MASK		0x00000004 /* Tx FIFO Full intr */
 #define XCAN_IXR_TXOK_MASK		0x00000002 /* TX successful intr */
 #define XCAN_IXR_ARBLST_MASK		0x00000001 /* Arbitration lost intr */
+#define XCAN_IXR_E2BERX_MASK            BIT(23) /* RX FIFO two bit ECC error */
+#define XCAN_IXR_E1BERX_MASK            BIT(22) /* RX FIFO one bit ECC error */
+#define XCAN_IXR_E2BETXOL_MASK          BIT(21) /* TXOL FIFO two bit ECC error */
+#define XCAN_IXR_E1BETXOL_MASK          BIT(20) /* TXOL FIFO One bit ECC error */
+#define XCAN_IXR_E2BETXTL_MASK          BIT(19) /* TXTL FIFO Two bit ECC error */
+#define XCAN_IXR_E1BETXTL_MASK          BIT(18) /* TXTL FIFO One bit ECC error */
 #define XCAN_IDR_ID1_MASK		0xFFE00000 /* Standard msg identifier */
 #define XCAN_IDR_SRR_MASK		0x00100000 /* Substitute remote TXreq */
 #define XCAN_IDR_IDE_MASK		0x00080000 /* Identifier extension */
@@ -137,6 +148,11 @@ enum xcan_reg {
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
@@ -202,6 +218,13 @@ struct xcan_devtype_data {
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
@@ -221,6 +244,13 @@ struct xcan_priv {
 	struct xcan_devtype_data devtype;
 	struct phy *transceiver;
 	struct reset_control *rstc;
+	bool ecc_enable;
+	u64 ecc_2bit_rxfifo_cnt;
+	u64 ecc_1bit_rxfifo_cnt;
+	u64 ecc_2bit_txolfifo_cnt;
+	u64 ecc_1bit_txolfifo_cnt;
+	u64 ecc_2bit_txtlfifo_cnt;
+	u64 ecc_1bit_txtlfifo_cnt;
 };
 
 /* CAN Bittiming constants as per Xilinx CAN specs */
@@ -523,6 +553,11 @@ static int xcan_chip_start(struct net_device *ndev)
 		XCAN_IXR_ERROR_MASK | XCAN_IXR_RXOFLW_MASK |
 		XCAN_IXR_ARBLST_MASK | xcan_rx_int_mask(priv);
 
+	if (priv->ecc_enable)
+		ier |= XCAN_IXR_E2BERX_MASK | XCAN_IXR_E1BERX_MASK |
+			XCAN_IXR_E2BETXOL_MASK | XCAN_IXR_E1BETXOL_MASK |
+			XCAN_IXR_E2BETXTL_MASK | XCAN_IXR_E1BETXTL_MASK;
+
 	if (priv->devtype.flags & XCAN_FLAG_RXMNF)
 		ier |= XCAN_IXR_RXMNF_MASK;
 
@@ -1127,6 +1162,58 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 		priv->can.can_stats.bus_error++;
 	}
 
+	if (priv->ecc_enable) {
+		u32 reg_ecc;
+
+		reg_ecc = priv->read_reg(priv, XCAN_RXFIFO_ECC_OFFSET);
+		if (isr & XCAN_IXR_E2BERX_MASK) {
+			priv->ecc_2bit_rxfifo_cnt +=
+				FIELD_GET(XCAN_ECC_2BIT_CNT_MASK, reg_ecc);
+			netdev_dbg(ndev, "%s: RX FIFO 2bit ECC error count %lld\n",
+				   __func__, priv->ecc_2bit_rxfifo_cnt);
+		}
+		if (isr & XCAN_IXR_E1BERX_MASK) {
+			priv->ecc_1bit_rxfifo_cnt +=
+				FIELD_GET(XCAN_ECC_1BIT_CNT_MASK, reg_ecc);
+			netdev_dbg(ndev, "%s: RX FIFO 1bit ECC error count %lld\n",
+				   __func__, priv->ecc_1bit_rxfifo_cnt);
+		}
+
+		reg_ecc = priv->read_reg(priv, XCAN_TXOLFIFO_ECC_OFFSET);
+		if (isr & XCAN_IXR_E2BETXOL_MASK) {
+			priv->ecc_2bit_txolfifo_cnt +=
+				FIELD_GET(XCAN_ECC_2BIT_CNT_MASK, reg_ecc);
+			netdev_dbg(ndev, "%s: TXOL FIFO 2bit ECC error count %lld\n",
+				   __func__, priv->ecc_2bit_txolfifo_cnt);
+		}
+		if (isr & XCAN_IXR_E1BETXOL_MASK) {
+			priv->ecc_1bit_txolfifo_cnt +=
+				FIELD_GET(XCAN_ECC_1BIT_CNT_MASK, reg_ecc);
+			netdev_dbg(ndev, "%s: TXOL FIFO 1bit ECC error count %lld\n",
+				   __func__, priv->ecc_1bit_txolfifo_cnt);
+		}
+
+		reg_ecc = priv->read_reg(priv, XCAN_TXTLFIFO_ECC_OFFSET);
+		if (isr & XCAN_IXR_E2BETXTL_MASK) {
+			priv->ecc_2bit_txtlfifo_cnt +=
+				FIELD_GET(XCAN_ECC_2BIT_CNT_MASK, reg_ecc);
+			netdev_dbg(ndev, "%s: TXTL FIFO 2bit ECC error count %lld\n",
+				   __func__, priv->ecc_2bit_txtlfifo_cnt);
+		}
+		if (isr & XCAN_IXR_E1BETXTL_MASK) {
+			priv->ecc_1bit_txtlfifo_cnt +=
+				FIELD_GET(XCAN_ECC_1BIT_CNT_MASK, reg_ecc);
+			netdev_dbg(ndev, "%s: TXTL FIFO 1bit ECC error count %lld\n",
+				   __func__, priv->ecc_1bit_txtlfifo_cnt);
+		}
+
+		/* The counter reaches its maximum at 0xffff and does not overflow.
+		 * Accept the small race window between reading and resetting ECC counters.
+		 */
+		priv->write_reg(priv, XCAN_ECC_CFG_OFFSET, XCAN_ECC_CFG_REECRX_MASK |
+				XCAN_ECC_CFG_REECTXOL_MASK | XCAN_ECC_CFG_REECTXTL_MASK);
+	}
+
 	if (cf.can_id) {
 		struct can_frame *skb_cf;
 		struct sk_buff *skb = alloc_can_err_skb(ndev, &skb_cf);
@@ -1354,9 +1441,8 @@ static irqreturn_t xcan_interrupt(int irq, void *dev_id)
 {
 	struct net_device *ndev = (struct net_device *)dev_id;
 	struct xcan_priv *priv = netdev_priv(ndev);
-	u32 isr, ier;
-	u32 isr_errors;
 	u32 rx_int_mask = xcan_rx_int_mask(priv);
+	u32 isr, ier, isr_errors, mask;
 
 	/* Get the interrupt status from Xilinx CAN */
 	isr = priv->read_reg(priv, XCAN_ISR_OFFSET);
@@ -1374,10 +1460,17 @@ static irqreturn_t xcan_interrupt(int irq, void *dev_id)
 	if (isr & XCAN_IXR_TXOK_MASK)
 		xcan_tx_interrupt(ndev, isr);
 
+	mask = XCAN_IXR_ERROR_MASK | XCAN_IXR_RXOFLW_MASK |
+		XCAN_IXR_BSOFF_MASK | XCAN_IXR_ARBLST_MASK |
+		XCAN_IXR_RXMNF_MASK;
+
+	if (priv->ecc_enable)
+		mask |= XCAN_IXR_E2BERX_MASK | XCAN_IXR_E1BERX_MASK |
+			XCAN_IXR_E2BETXOL_MASK | XCAN_IXR_E1BETXOL_MASK |
+			XCAN_IXR_E2BETXTL_MASK | XCAN_IXR_E1BETXTL_MASK;
+
 	/* Check for the type of error interrupt and Processing it */
-	isr_errors = isr & (XCAN_IXR_ERROR_MASK | XCAN_IXR_RXOFLW_MASK |
-			    XCAN_IXR_BSOFF_MASK | XCAN_IXR_ARBLST_MASK |
-			    XCAN_IXR_RXMNF_MASK);
+	isr_errors = isr & mask;
 	if (isr_errors) {
 		priv->write_reg(priv, XCAN_ICR_OFFSET, isr_errors);
 		xcan_err_interrupt(ndev, isr);
@@ -1796,6 +1889,7 @@ static int xcan_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv = netdev_priv(ndev);
+	priv->ecc_enable = of_property_read_bool(pdev->dev.of_node, "xlnx,has-ecc");
 	priv->dev = &pdev->dev;
 	priv->can.bittiming_const = devtype->bittiming_const;
 	priv->can.do_set_mode = xcan_do_set_mode;
@@ -1912,6 +2006,11 @@ static int xcan_probe(struct platform_device *pdev)
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

