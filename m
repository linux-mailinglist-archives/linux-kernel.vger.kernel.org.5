Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B066E7F8A20
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 12:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjKYLQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 06:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKYLQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 06:16:25 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE3B127;
        Sat, 25 Nov 2023 03:16:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBO8pyYoRyP0+ZxJgUwpzZsRFjWfRz5QnOEBt5BauxEmiSX1rcZxcXOXzWiKZcFzisJNp2HjLRC/SJIVNcZ1dbs0zrZBOysat+eWipOf2dRDCG9IH2mkvfkvqGazqZVcleKXnZNW/UDfTb/x3OfFBvIOVsq9y13qCcmfMU8uSYbwbjCw4mSVFkK8MzLITJ2kg6SoqJguoJ/20HRULCpodwuWg/BJYWr5kPvPAKDg6B/OoborxLMg85igJdI83z2m76gy0QiS9w9tYe44UUG0xgV4sxTFX/Imv0O19nLC6Q/nWL60ksrOn2Imf4e7mgFHNFXtt89/JEq5fYBfj9jabQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pbT4ZOgsylpjPkTEAy/cWXXxCkJ1vfTTpeh4wDaPSM=;
 b=d2aLs2NBZbB/9e5dAcOkbq7O1Tp+DEVNsLb/IVg7QEe+FD3uoroeOtgi5Giyeaph2eqs4Jf/LKey9qHByHROf2uZbFMOEBlbMbX8fgoPbNfU4w7GxUoNeA/oHQbYzMU/SG3lwcxLIhMpRAJoLVADLCxAvEB+Fvx4Xs4+IJR83npnT/yQdyW4LVX1nzb7Z36vScTWZsN/0idam+xUZkD6PWkAX5WdlEuTeXt1Yy84R6xaj9wBTKRaYREvIXy3B0Gv3YVVG8ettyqJCRFqW/Wbs+M3TRuzND8Cyp1oVoqWJjiWwMDw8z/X6PxxC0t0ADwu7hVPtHwyBWkpE3GedCUZwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pbT4ZOgsylpjPkTEAy/cWXXxCkJ1vfTTpeh4wDaPSM=;
 b=4q0byuN28XqT3yBB3FDDfAjTLjuzufci7vxSxgucM6xRPMu8Kc3Sl66yYB2DGJO/r17qJAky881UhiER0eWAn5Bto8AgmgNUPDU5s7f2mFqaYc+ULtDJyo6PavJ8Zo5irhc0KuK/l6lWQbq2VO4H0qDpxWejnsQwdaeilv5ieY4=
Received: from SA0PR11CA0036.namprd11.prod.outlook.com (2603:10b6:806:d0::11)
 by PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.25; Sat, 25 Nov
 2023 11:16:25 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:d0:cafe::4b) by SA0PR11CA0036.outlook.office365.com
 (2603:10b6:806:d0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21 via Frontend
 Transport; Sat, 25 Nov 2023 11:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Sat, 25 Nov 2023 11:16:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 25 Nov
 2023 05:16:24 -0600
Received: from xhdvnc205.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Sat, 25 Nov 2023 05:16:19 -0600
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
Subject: [PATCH v6 3/3] can: xilinx_can: Add ethtool stats interface for ECC errors
Date:   Sat, 25 Nov 2023 16:45:33 +0530
Message-ID: <1700910933-23868-4-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1700910933-23868-1-git-send-email-srinivas.goud@amd.com>
References: <1700910933-23868-1-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|PH7PR12MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: 359d020a-e318-4d90-8e63-08dbeda7f658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I65ladfwgAjGwNvmk7YrNpwF+TulsAi5A9xlu94sLkByKjezbcmch0qI+4bDE+DhTzb9fKwxXKkbwmtXGKX108TshsPEjoAdW1EPQIyImVifzUI8nEny5EcMl3jrueAKneZzOaT2/OfRf1BoD9P8LoDWPXWGzjsNc8xjZkPin0j70aV0NVtxwjLIdMh4dFQ2ZctmipSbXof38q82EFns0ctFvzxgvA6tMVyt9YWdQWKwmfEXxg6TpO50EoKBmxSEQtxCYrQNGs+xnyiCen318Pdwj2lZ5AtvnMVGJ8TsX/43yHXlWYcQiVUkRX0SOQVFELMkyTdiLCt+O8RtZqpuHaQ9nmgEyAkllfpvOkXNyDDQ4+ZJ9GY3Cxb098RTs3Gqpk6cMf3BL+zsjEKhAEuPQz0Fq9xPj12KOweeR6eK5NXo6JvU3sT2swMcO6BM9i7nwM5BaIXH2pd7fwB+g2O5b42Od6O5nZyF1NsN0kLmFLZrpO5yeriFtVnz0Pje8SnwefMIvsGDPpxdagdAAyC/bd4Ye9tc39jeDjpZE+Vf3x2jZHfaJl9C6Ua6YcWJi2hYsbgL0hd+UqKyP1Q7FzZY1rVNnGhVRLzmSA5HEHFv0AKOk/ZOYDmosccu+4QM9hmT9YJIbf4kabhr8D5V1dGwDtk4QAsZDbQk/G65eHKC8TVMPdzpAuocRhhMRu5AMObeRHa57kvSH+FmL1gX6L+Md6UQ/6Mzs5yaLGvlj826ymv3aKbkn5vDNYHVixsACGOsUzoOby8ktQdzagFuwYf8Gt//nOR4PTRL7p+Qjir8p2A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(40480700001)(36860700001)(81166007)(83380400001)(2616005)(47076005)(356005)(4326008)(8936002)(8676002)(86362001)(44832011)(426003)(336012)(26005)(82740400003)(40460700003)(478600001)(6666004)(110136005)(70206006)(70586007)(54906003)(316002)(2906002)(921008)(41300700001)(36756003)(7416002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2023 11:16:25.0752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 359d020a-e318-4d90-8e63-08dbeda7f658
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5805
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ethtool stats interface for reading FIFO 1bit/2bit ECC errors information.

Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
---
Changes in v6:
None

Changes in v5:
Address review comments
Add get_strings and get_sset_count stats interface
Use u64 stats helper function

Changes in v4:
None

Changes in v3:
None

Changes in v2:
Add ethtool stats interface

 drivers/net/can/xilinx_can.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index c8691a1..40c912b 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -228,6 +228,7 @@ struct xcan_devtype_data {
  * @transceiver:		Optional pointer to associated CAN transceiver
  * @rstc:			Pointer to reset control
  * @ecc_enable:			ECC enable flag
+ * @stats_lock:			Lock for synchronizing ECC errors stats
  * @ecc_2bit_rxfifo_cnt:	RXFIFO 2bit ECC count
  * @ecc_1bit_rxfifo_cnt:	RXFIFO 1bit ECC count
  * @ecc_2bit_txolfifo_cnt:	TXOLFIFO 2bit ECC count
@@ -254,6 +255,7 @@ struct xcan_priv {
 	struct phy *transceiver;
 	struct reset_control *rstc;
 	bool ecc_enable;
+	spinlock_t stats_lock; /* Lock for synchronizing ECC errors stats */
 	u64_stats_t ecc_2bit_rxfifo_cnt;
 	u64_stats_t ecc_1bit_rxfifo_cnt;
 	u64_stats_t ecc_2bit_txolfifo_cnt;
@@ -347,6 +349,12 @@ static const struct can_tdc_const xcan_tdc_const_canfd2 = {
 	.tdcf_max = 0,
 };
 
+static const char xcan_priv_flags_strings[][ETH_GSTRING_LEN] = {
+	"err-ecc-rx-2-bit", "err-ecc-rx-1-bit",
+	"err-ecc-txol-2-bit", "err-ecc-txol-1-bit",
+	"err-ecc-txtl-2-bit", "err-ecc-txtl-1-bit",
+};
+
 /**
  * xcan_write_reg_le - Write a value to the device register little endian
  * @priv:	Driver private data structure
@@ -1171,6 +1179,9 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 
 	if (priv->ecc_enable && isr & XCAN_IXR_ECC_MASK) {
 		u32 reg_rx_ecc, reg_txol_ecc, reg_txtl_ecc;
+		unsigned long flags;
+
+		spin_lock_irqsave(&priv->stats_lock, flags);
 
 		reg_rx_ecc = priv->read_reg(priv, XCAN_RXFIFO_ECC_OFFSET);
 		reg_txol_ecc = priv->read_reg(priv, XCAN_TXOLFIFO_ECC_OFFSET);
@@ -1182,6 +1193,8 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 		priv->write_reg(priv, XCAN_ECC_CFG_OFFSET, XCAN_ECC_CFG_REECRX_MASK |
 				XCAN_ECC_CFG_REECTXOL_MASK | XCAN_ECC_CFG_REECTXTL_MASK);
 
+		spin_unlock_irqrestore(&priv->stats_lock, flags);
+
 		if (isr & XCAN_IXR_E2BERX_MASK) {
 			u64_stats_add(&priv->ecc_2bit_rxfifo_cnt,
 				      FIELD_GET(XCAN_ECC_2BIT_CNT_MASK, reg_rx_ecc));
@@ -1637,6 +1650,44 @@ static int xcan_get_auto_tdcv(const struct net_device *ndev, u32 *tdcv)
 	return 0;
 }
 
+static void xcan_get_strings(struct net_device *ndev, u32 stringset, u8 *buf)
+{
+	switch (stringset) {
+	case ETH_SS_STATS:
+		memcpy(buf, &xcan_priv_flags_strings,
+		       sizeof(xcan_priv_flags_strings));
+	}
+}
+
+static int xcan_get_sset_count(struct net_device *netdev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_STATS:
+		return ARRAY_SIZE(xcan_priv_flags_strings);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void xcan_get_ethtool_stats(struct net_device *ndev,
+				   struct ethtool_stats *stats, u64 *data)
+{
+	struct xcan_priv *priv = netdev_priv(ndev);
+	unsigned long flags;
+	int i = 0;
+
+	spin_lock_irqsave(&priv->stats_lock, flags);
+
+	data[i++] = u64_stats_read(&priv->ecc_2bit_rxfifo_cnt);
+	data[i++] = u64_stats_read(&priv->ecc_1bit_rxfifo_cnt);
+	data[i++] = u64_stats_read(&priv->ecc_2bit_txolfifo_cnt);
+	data[i++] = u64_stats_read(&priv->ecc_1bit_txolfifo_cnt);
+	data[i++] = u64_stats_read(&priv->ecc_2bit_txtlfifo_cnt);
+	data[i++] = u64_stats_read(&priv->ecc_1bit_txtlfifo_cnt);
+
+	spin_unlock_irqrestore(&priv->stats_lock, flags);
+}
+
 static const struct net_device_ops xcan_netdev_ops = {
 	.ndo_open	= xcan_open,
 	.ndo_stop	= xcan_close,
@@ -1646,6 +1697,9 @@ static const struct net_device_ops xcan_netdev_ops = {
 
 static const struct ethtool_ops xcan_ethtool_ops = {
 	.get_ts_info = ethtool_op_get_ts_info,
+	.get_strings = xcan_get_strings,
+	.get_sset_count = xcan_get_sset_count,
+	.get_ethtool_stats = xcan_get_ethtool_stats,
 };
 
 /**
-- 
2.1.1

