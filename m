Return-Path: <linux-kernel+bounces-24626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9D182BF5D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9A0CB232A8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5674A6A33F;
	Fri, 12 Jan 2024 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bHd6QZY4"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B145E6A327;
	Fri, 12 Jan 2024 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6Qpj+Yoh5qIvCbr8nmcW3ZDlo5vVEvsmky9xsgx73dU6I/ggfSNMQJYGB8WHNMBN1Sg4Wbk7kwB2xFoMO1t8fJ3Rjjks5b/wYTYSyfXDTiOfO6LEgHdmkrsPxTaC9/hOKOQTEO4nq2gdOQBKFVmbz6nPLoqjG+aL9faOhwVm0s0sMZAoMOm3lYPIJ4VSCw66EV3EAnnt9bTrCP7zV2J6Ndt94QOr6SxUyMJYUfg7280IvFKpzUO501bcQVsJOw9kcB9QKwpzs+ViQCtmGQv379Vgdtkq5EQP9I7bdEO11e5iXxCvmAu882WzNRh/P6mATkXF/M7m3+tZnVnDBmI3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adrn8x4Xb9ucyvP9lmiGhChyGVZHEshSZWsFtIJ7jaE=;
 b=T5CdgMYxOnOZP8QFMdCbGtCTgrLT2QZYnHjG5kEIlLpWOfGOr8ZhAxIImlQqP/cqqxdX+Xn1HfGyTkJ3OqxMRuPkFLzBtomghdwBkJKkaBTL73Sk8Sqhz6UIRz8ASsJcqdLBxXpDPL/p2oOcZQ8yLUr7kXS4IdGR/SZoD7il92nd00X6qQmj8xG57GKkYtsGm6xTPRM9PHcOZoacwpD7DcvohwL0kh/58wmepmnmSJfgYNQuGcpnM/l3Y70qdoXAobRsz6NSPHQhFlDyxsS9mA73Fd4mbsZZnljSzX26XT6681d/loka5j4v84q0AaQh1A+xo8X8wyU/kx/AOVyXgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adrn8x4Xb9ucyvP9lmiGhChyGVZHEshSZWsFtIJ7jaE=;
 b=bHd6QZY4mFQ+HaiyIC/njYLsWKRbPJsVAVkeUGYj7PXZ3oByWyFy0HIOTzbg3M8euO/X4ENwwsxQXzt5F58nEjcik5AEXK4JU053PBjY+wgcrH1jGROrBKDoLs3YsJzRid+eBzKWbGYlqZVkz1hnwq8bYexSTTVRVhfIyq5G/o0=
Received: from SA1P222CA0134.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::7)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Fri, 12 Jan
 2024 11:41:01 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:3c2::4) by SA1P222CA0134.outlook.office365.com
 (2603:10b6:806:3c2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23 via Frontend
 Transport; Fri, 12 Jan 2024 11:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 11:41:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 12 Jan
 2024 05:41:00 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 12 Jan
 2024 05:40:59 -0600
Received: from xhdvnc205.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 12 Jan 2024 05:40:55 -0600
From: Srinivas Goud <srinivas.goud@amd.com>
To: <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <p.zabel@pengutronix.de>
CC: <git@amd.com>, <michal.simek@xilinx.com>, <linux-can@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Srinivas Goud <srinivas.goud@amd.com>
Subject: [PATCH RESEND v7 2/3] can: xilinx_can: Add ECC support
Date: Fri, 12 Jan 2024 17:07:32 +0530
Message-ID: <1705059453-29099-3-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1705059453-29099-1-git-send-email-srinivas.goud@amd.com>
References: <1705059453-29099-1-git-send-email-srinivas.goud@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 518bd8f8-4aab-450b-9a4e-08dc136359b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eLWB9kJywG9xqlNdMdi+hbEo15WFWQ4XJfC6JmePEpXzFVdmcF5NTYCY31rGxhWs8u8Bqb8dsnAL6+nxG6lLLFiQuZCPLxyr1vUk7N3wYNSfqNwYhXSjeBkYeTBG1XiHEzGwvTd4LtxkjXzA58VSZx3X41DupnKeCJ5rVj+xkogYMQY6eBpJo5Fx0dsPdevrUOEvdAMDmG1PgcYLgElYHkZsCwFZkLBmSqDCeOwHkqleSGRwfrtA55a/giqC9mu8/q0JmW3ApWWxzfmbeJPMnsGyDMnIzFG3B2wVWOKCuFiO86M3mniP3yV/KOXTr3oeER8JHZfriBeTzCpFG1lFITgZ8O/nQaquBdliJIfHLAedhiLB3XqokOZh6FCJcI7uBIFQS6RRXYAccNk7CYnHlOU/r97F+wJDd7SHltyiQk7EBdVH8Z8eP6LM7/UaHYFRMY1KMOc+IkcWQc0connp5kmwn5U8Xzt9gX9cIQVdNwboMjrhhfZjTFK+kWqOX/MbyLuh7GBOl8vXA2UtZmRi079DIUUQiGyeENOJXp8Bh7j8LsLRbvDTEkupWEN77LRjU7nyj3zZG7t4lsBLTzvAeZb6slPFVjpEWdx/Epbfkfp/L3PiqT95JBO7OKWneN1wLW1bydImPv9OmFpyBIgyRsmlF9rljzzPjEdCvfVaWJDoqcqftK+00+/h/zFx/sjgIGSiO1PnaFLM4cUmFypGEGmqKyMZaAiSSyQJThZez7svIfiQCABdHBUJTojugG6eCwnh2mnYN6jLXtu/G8tzSsk70NhEev6QPqnUhx8Q0Vc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(336012)(426003)(6666004)(26005)(478600001)(2616005)(82740400003)(81166007)(36756003)(41300700001)(921011)(356005)(86362001)(2906002)(47076005)(36860700001)(110136005)(316002)(5660300002)(83380400001)(7416002)(70206006)(4326008)(44832011)(8936002)(54906003)(70586007)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 11:41:00.6906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 518bd8f8-4aab-450b-9a4e-08dc136359b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112

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


