Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F002F78B3DD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjH1PAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjH1O7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:59:53 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C38BF;
        Mon, 28 Aug 2023 07:59:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGgDYbP2jHsZSTVjv+mXU9F+9+G8cMnJUZVrR9NMF8Sb80WreYuMcUbZp23gBZBkEfJwLtF+PNFzxOcNOchVLyZartBsHUrjY+SgyhKsl7kpuAwYKsLcqAMW9/hqC90oorB/7wyy4n9P1oUOeCVjHHfH/RTpXJiBko6TNQ5NPqE8n6FgqfCluiNRTk3upe8VVmN1/8JpY7GIlnrXmOplBLhse1hZTLTrBHK1cEDEIqPSx/9p+o1pUkakETMRKS1tHZUyOXTwMk0P+exw3GXj/q6Z7SkhobC9KFlg9ePo2uVn4VREUGKXijSM/v/o0TCleATxgtt0AQSxCFXPwJTfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cg4JtQ9H7fOFLkHEXuEG35S8gN/ViMY+L1e/9zrjG+Q=;
 b=mzNepqnIHtgQhbS9XL6ZuEOpnAaqlwNGsFU51iBbi1uj1NI+WfZtQSW6q8wYesUZ4lFyECOAdNPWcUmE/iFanU7b0WTlNkjpxLEt1H9dtsbQAcGFS+62kNUuBh7xA1W/aI2FUX0Ee8euMGC0j0GGUA+Q0JH4qUQVdz8OvUvyN5sFIvmuC/i5hrt/WyB7Lpo+axedmPz1Gg63j/q5igP4MuJrjvXsapHEiVWOSz4nqydaIzG8N0JxuUnW+boQOfF0FnTTe5gls5UMgr2WAvXyjx1uVTihNjqx/NFAzyBlPbTEVPjHSPzZ/SkoMrE4NcyqOxqzIhAaoNjqTcKIwKJ5yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cg4JtQ9H7fOFLkHEXuEG35S8gN/ViMY+L1e/9zrjG+Q=;
 b=aNHUgKkMi6+5Q0kllfKXWOZtXmxtqpDVsKiY7tEG5YR8PcZo4SB30dvGww5mfzLs1zUl0gNpPZ3IHKzBpITJBWtRyYejjoAzK0CK4mQ78t64yBfGP1i9GoPIJFYmOS/9j7BkPudh4+vziba2BaKZC9uMDOUtU2heN6TmJ2xJZ4U=
Received: from SA0PR13CA0020.namprd13.prod.outlook.com (2603:10b6:806:130::25)
 by SJ2PR12MB8651.namprd12.prod.outlook.com (2603:10b6:a03:541::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Mon, 28 Aug
 2023 14:59:45 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::27) by SA0PR13CA0020.outlook.office365.com
 (2603:10b6:806:130::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.17 via Frontend
 Transport; Mon, 28 Aug 2023 14:59:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Mon, 28 Aug 2023 14:59:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 09:59:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 09:59:30 -0500
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 28 Aug 2023 09:59:25 -0500
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
Subject: [PATCH v3 2/3] can: xilinx_can: Add ECC support
Date:   Mon, 28 Aug 2023 20:28:44 +0530
Message-ID: <1693234725-3615719-3-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1693234725-3615719-1-git-send-email-srinivas.goud@amd.com>
References: <1693234725-3615719-1-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|SJ2PR12MB8651:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cabce4a-a800-487a-f974-08dba7d76ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o4cOedkUhyzVE7a+ebICpOtHpiFAEq++qADOvcY13mmD3trOwMHBS/ckO1gIsBb9So3jFZwXsoVo8VFSo2HFT8R5PofrPr/u1gthjKyoT3i/sy0EZeklkxZ4UgV8LZfzUQVFPVTz83YiqtQeelg4a+0lQwCtx6AXExVkj56s5ajeiVXSySBnsb7X59OA7uLKVyYFGqA/6bHnKQHfel3ohwoY6PDqTsadIVRUjMgQYIIzm8aJmobOItd12cKYi+M0SNGkKqZwZWmpCWfLEemC6CvIYft11bk5OKpjvDko+ktvHWnxNnUb4hyIxMoC3JQZr88JxtlONYkNF8ntcn0zFo8ouXK+40LK75j/ktWemGoz9I0Lqf2BmD8mtaZ9AWqB4lrKg+p4zwY/0AEVW40KPfmOwsC7YDL1WEZZg06Z6VFapTRtYPitBxDs0xdc6Fku0KzMQG+p3M6gaHfhd3Fd7ObKo6055Shv1VfW9msdH9skSCxKKhbxWs2gBwxVIP0azopDC4nOaNPpej/5PKPBfaWWTlxiBuekklId/6bAiUQqoAzQkIGVHXL+vyjpLsdglc8KXs4s4t3QdyN9FSvIsuT9pY9+FD5XRk2NAPM6YLJ5x3P4s5GV0Y5/VRo5hXI0r55g/rIe/eg9bvHNfq8okUnnT6VlV2gmAOquIoXpBB26RBJDO+1bRcGK+c0y0xNJFU9DSMTEJ9UE7p+TiyloOsPyY2qOaXXRhP7YTgkPAIPMMnlQj7EVqve4PSFl7onUiNd1JRS+KsClM5tQcbeipprCc9SkAjR9/ZX2vnsTxls=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(186009)(82310400011)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(82740400003)(36756003)(81166007)(921005)(356005)(4326008)(8676002)(8936002)(54906003)(40460700003)(41300700001)(110136005)(316002)(6666004)(70206006)(70586007)(86362001)(478600001)(26005)(47076005)(40480700001)(336012)(36860700001)(44832011)(7416002)(83380400001)(2906002)(2616005)(5660300002)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 14:59:45.5826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cabce4a-a800-487a-f974-08dba7d76ae7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8651
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

