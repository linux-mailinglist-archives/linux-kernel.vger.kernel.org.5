Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C1A78FA1F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbjIAIlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344165AbjIAIlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:41:22 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C1E10E9;
        Fri,  1 Sep 2023 01:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaW/zEwJVLE46/+MtzhVP0lsOHY//0pOVFtHi4VqBB/mQlUMbyMDUHQU34EiEI7fRA+Hm2wiLmGyDThjeBHhoCDyo3hY3GXHaPr0bzDOczuoWsKLAUpIB32InYR0JN1s9bxyUVToCt6IocONvGEIAFZOynkghoCwQshoiZHh7GoZg7ADxL5JpauzvPkJpVb4578efI6zkR2hmX+vCQGES2uySjHokCfu3oeHhZGAboLwozfaYvV4vsCdlV7zSRTJDwYy4J3fGD0CnjaP7EnQcHjRckSFlyH8roKem8EFyLIvw7maiHsfbbpdoQHdNW+e0Ghym9w7DmKm3V/wCPeSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgXksxVMpmOG5gCyMZj6CG5P9D45+cSWp6v4jSE86dI=;
 b=aUOnMYIdPp/J13oVe5wF81SN09S4Ahns2r577QOmJ81q2TJtFzILmcVFMilgiDtuOexqtBE/GoNw0raSZelPwhDrrhkJWAzIpMFf9WO+m8vdj1LUWch+2Ik/+0r0skKzDlWy1Zvv4+HeFLAErpNXJrcXmBifJ40XXjZR4A/xO/m22ohZqRidqGkWH7zAR+WoJLzIPZ4qy2/25zHiswv7oM9K7Gv6Z0XV0GyA5xsWa/BpPIK+XFCJpsZUdYNa3tqzvu9AJJzt6Lh/M8/u95NGJulZllG+1XhmS1rKtd0sBqKI2zgNwQolipUoSOHHk9x/MdEjqOLQGZccDyPsYLRu7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgXksxVMpmOG5gCyMZj6CG5P9D45+cSWp6v4jSE86dI=;
 b=h0kKznWlTH6Kct8owrCtLKBeFGArrdBfnOkCHW1qRGhnbIJC4iPs1s9lC695LYEqwksADb8jvvOSAkbqchxDQreO4JQaxwF7klOk3Ru8I3VnQmsvKc4kKfZ0Isw+0Z/ChjarglC2VoF8H8hMZb8jW/WDwu5mMoskTs4OY8g9wUI=
Received: from BL1PR13CA0244.namprd13.prod.outlook.com (2603:10b6:208:2ba::9)
 by DM4PR12MB7623.namprd12.prod.outlook.com (2603:10b6:8:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Fri, 1 Sep
 2023 08:41:15 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::a6) by BL1PR13CA0244.outlook.office365.com
 (2603:10b6:208:2ba::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.16 via Frontend
 Transport; Fri, 1 Sep 2023 08:41:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.20 via Frontend Transport; Fri, 1 Sep 2023 08:41:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 1 Sep
 2023 03:41:13 -0500
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 1 Sep 2023 03:41:08 -0500
From:   Srinivas Goud <srinivas.goud@amd.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <p.zabel@pengutronix.de>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-can@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <appana.durga.rao@xilinx.com>,
        <naga.sureshkumar.relli@xilinx.com>,
        "Srinivas Goud" <srinivas.goud@amd.com>
Subject: [PATCH v4 2/3] can: xilinx_can: Add ECC support
Date:   Fri, 1 Sep 2023 14:10:44 +0530
Message-ID: <1693557645-2728466-3-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1693557645-2728466-1-git-send-email-srinivas.goud@amd.com>
References: <1693557645-2728466-1-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DM4PR12MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: eb074498-e5b8-4ddc-13e1-08dbaac73428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RMw6r26D/0yXibKgbB3B+rFvwIXoFR+lG2HM5CUru6pNoj80n7lvc6qio5gwFukQbWeRrVKk9fG7jmHvuhr6kEFNSIpEvZoB+78e1z7x9v9Y3xCUwqffKv756aeymKf3nNujNlbBWTXO3F9/XLFgXDbOnPOOx0BcPIdRfc9nYS8oH6pxlpkm45h0r0hffAw4NWWh6n/aDRrlYmNCIUF2oUIlTyv1uXMf6WI5JILCk3pw7QBQGRvVqnzS57Ju5uLUWJGumO0N70oBAcOPtVXls1GfkQnxv/1igr13JLGxe6h5tAPla/tOl78dVZqvxCKlqfmk9neL7IRw2VmnOBMyeyXMFEPhQnZzI/VS71gilxxCfS3HP8N4JzE8T6PHaiX0Y3sKR8vmd/SDhznmyp4G469bjMCRL5G9uky8MXVxYyIOLTHriRPQoq4yzXsALF8lxKG619uF2jQyzpNN0Wr5dgLUEZsv8pKcHTlvZs3/mIsoO/ELseDxAY7aqxrgh8KtT0XCDy9h5OeId3zpD+jhE+QIQ01UXPHOa7rcb1bxlHCXiqDE2SnPX/rQHE7h/+toIl+gXqNV9H6ZcGEjdLVKFC9WBGq2nI2vAYGLaPVeLHc8RtcoDr5YkkIQJek8pkw+1GOz6YEDA+cM1JfNAfM4W8Owg0+aCLdQneQhCQHPp35f2yp9+oPGYqZRkDYXzGGY+O7xG6/RFjOkadJEAPXRlMUzETNG0xfoGQb16IQ1aiZntHMOZUEeNStJnF7FYt3BUlc3N9lfwKI4pzgPMrsrkiS/95QK9ZurjmcmH4fb0JE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(186009)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(7416002)(316002)(70586007)(70206006)(54906003)(921005)(356005)(110136005)(82740400003)(81166007)(478600001)(2906002)(41300700001)(44832011)(86362001)(8936002)(8676002)(5660300002)(4326008)(83380400001)(47076005)(36860700001)(336012)(2616005)(6666004)(26005)(426003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 08:41:15.3000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb074498-e5b8-4ddc-13e1-08dbaac73428
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7623
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
Changes in v4:
None

Changes in v3:
None

Changes in v2:
Address review comments

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

