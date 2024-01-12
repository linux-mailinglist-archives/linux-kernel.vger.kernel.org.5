Return-Path: <linux-kernel+bounces-24627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC5282BF63
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E0D1C23DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5638D6BB23;
	Fri, 12 Jan 2024 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mf2grg7G"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79FF6A34A;
	Fri, 12 Jan 2024 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAvMU4DrXQlRAU8qtGmG3sjj6WMM8eGyMPpj1Xsx5kGpNcA7dHupbZf10GKRc0Un0Wg7/38o93G7Pxfr/WcLni5mssqZpN14PcwRfKu4DxwcicK9NdsylDo0s7gb4yzaIEkkR8hA5P2d4ws+pqEjEkbpaIyoIKNiKgRPFSrLL2REvtP65gW8IYhbYJ/UvxG44Ixw66WsBYydumYaZPIAVwdJvRC6PmdluQ/qeIadCduT6ClGVCasfr8SjM7eUzRZ+udNGX2ZhTb2YSC6fU16hX2hNJ7n8ZVfjyetTZ9GPPzzx6yxZwsvccnR2xUL15EA7XLEaD/wvG+dnxjSOiH1pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EIallbDZQqPnj4t5E2adbK7o25+8EmHC2146XW0dC8=;
 b=YahBcic4+ekFvfEdvXmgYazVs4qYTsfDclq5Tk/ckXRoQUaBTx3qWzBHlHoIsRFDi0xHB0F4pzqNBWC97FzPCAsrbGvdNIeopp2dW6oLop8PTPrXqulCWIqcU3j3b9X0EBB7GaQZLIKYGOiqikDn5lOedldkgb7e8TnCqG8bFl1RsyrnzmZ8WErlWAVL5aRlkwd52gd+1RV3l1gxIWCi48xBGeYRybIGw6vwpv5CMFLf2ZCwEFdVjGbM0/x7w305WELOAN4OaMKVkIV+ohIRkEHQORO75zOnwrlQqp7wPhdoAUfSdmTA/aQDpoWIUJ9nLsZGOfeHOFqRqRE9YPHEhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EIallbDZQqPnj4t5E2adbK7o25+8EmHC2146XW0dC8=;
 b=Mf2grg7GX8t7UKqaXSWfy1+vw9loy6C7+lJ4KLrN7gpn48KpSZep9phXZsh3o5EL2Gs6Zn57UFclBzOBwch3+hLCCK70HFxg07Sh0q0jTjU1Jgk5fO+Tgmfe0axNKQjZWwNazsW+Uuu1kF08KPL5zDz+9j5ZBPzlpIr+H3tKBYY=
Received: from DS7PR06CA0013.namprd06.prod.outlook.com (2603:10b6:8:2a::13) by
 DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.21; Fri, 12 Jan 2024 11:41:05 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::d5) by DS7PR06CA0013.outlook.office365.com
 (2603:10b6:8:2a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19 via Frontend
 Transport; Fri, 12 Jan 2024 11:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 11:41:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 12 Jan
 2024 05:41:04 -0600
Received: from xhdvnc205.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 12 Jan 2024 05:41:00 -0600
From: Srinivas Goud <srinivas.goud@amd.com>
To: <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <p.zabel@pengutronix.de>
CC: <git@amd.com>, <michal.simek@xilinx.com>, <linux-can@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Srinivas Goud <srinivas.goud@amd.com>
Subject: [PATCH RESEND v7 3/3] can: xilinx_can: Add ethtool stats interface for ECC errors
Date: Fri, 12 Jan 2024 17:07:33 +0530
Message-ID: <1705059453-29099-4-git-send-email-srinivas.goud@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb5ce60-6c16-4143-a33b-08dc13635c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3GZHnkRCEQ30i4/Odm2moTvnFDDYNF4Ttwv8j6QYrusKYLniJkZ5Rlpoh6CrF9ANdkAXNVPCmE2R2o9uNYy5h/5coJLq65dXCbAfBRuMK0LDWxc6CvrP2z5RGf4tSSzfk0Of+Rz69wS3EHeN/dwtXxlSBK9Ci90Ac9K/dKZ7HKaNirtDWYZVngbe9DNleF3zPSBEn8HYFVr/YXEc1eVzURRvqm2m35BYVCqdXG3BSLSrZSre3D6x5CHx6QQHg9fwFT/HBsawckorfFLC3Y+pWyhVBIrGVQNsk3ZIjRumtMO8ODhPSz/Fy9h0rY5zpB361XdID1zoGYki/hk399IzZUYPDVmYJvWtRfpMi/FpUdBcYXfZ7rdkahvUg5MBjmvJY+rouZ96Ug2zlJbghrvg23ZAVV4u20MW06L+ZnAOo3qnhvxHYb8DlD9zqjTRNNhxqwZX1Qn/fzRBypc+b5+hujkzYYdJl8euzWOx/K2nLbfd58R9vkaLz79XtJkLfKITglxwBjTRTfq5fwHxgvcBAgIGShfzb7jmvTILSnPQdEHVwps9WDsDC5Bu1e1J5ngT5mbm+mzqywJkwP6izfUCOt19MbltALINoFMd4h6fA6qhL/ExnR/3fNOlEQTPdXnkAjj/acyNCXtN3/qtOUJm++ERjhIueUJGC2EAxHseZ+4vrwRfABMTzrZ/q3JmEfVg9DDoNey4xfHSRFdusdMLhzWTDXdUZ2gfBkicqjfS3ulgAc5JXcdxMZuGc0FP6g2mma7Mcsxz5pg0Kw3huWNsAtDF9+do9yjUnV3T4V36ijc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(36840700001)(46966006)(40470700004)(83380400001)(336012)(2616005)(26005)(47076005)(36860700001)(6666004)(4326008)(8676002)(5660300002)(8936002)(44832011)(41300700001)(2906002)(7416002)(426003)(478600001)(54906003)(316002)(70586007)(70206006)(921011)(110136005)(36756003)(86362001)(81166007)(82740400003)(356005)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 11:41:05.1054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb5ce60-6c16-4143-a33b-08dc13635c59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630

Add ethtool stats interface for reading FIFO 1bit/2bit ECC errors information.

Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
---
Changes in v7:
Update with spinlock only for stats counters

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
index c8691a1..80b0586 100644
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
@@ -1171,6 +1179,7 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 
 	if (priv->ecc_enable && isr & XCAN_IXR_ECC_MASK) {
 		u32 reg_rx_ecc, reg_txol_ecc, reg_txtl_ecc;
+		unsigned long flags;
 
 		reg_rx_ecc = priv->read_reg(priv, XCAN_RXFIFO_ECC_OFFSET);
 		reg_txol_ecc = priv->read_reg(priv, XCAN_TXOLFIFO_ECC_OFFSET);
@@ -1182,6 +1191,8 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 		priv->write_reg(priv, XCAN_ECC_CFG_OFFSET, XCAN_ECC_CFG_REECRX_MASK |
 				XCAN_ECC_CFG_REECTXOL_MASK | XCAN_ECC_CFG_REECTXTL_MASK);
 
+		spin_lock_irqsave(&priv->stats_lock, flags);
+
 		if (isr & XCAN_IXR_E2BERX_MASK) {
 			u64_stats_add(&priv->ecc_2bit_rxfifo_cnt,
 				      FIELD_GET(XCAN_ECC_2BIT_CNT_MASK, reg_rx_ecc));
@@ -1211,6 +1222,8 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 			u64_stats_add(&priv->ecc_1bit_txtlfifo_cnt,
 				      FIELD_GET(XCAN_ECC_1BIT_CNT_MASK, reg_txtl_ecc));
 		}
+
+		spin_unlock_irqrestore(&priv->stats_lock, flags);
 	}
 
 	if (cf.can_id) {
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


