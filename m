Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139D37F9D85
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjK0K2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjK0K2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:28:47 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91DE18F;
        Mon, 27 Nov 2023 02:28:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4LKMGfu3vGb06v+qMKxpuoG3Cge/Rdbe2tiLHyGSpwAgnTtu+OWxjXUtTjtt+WTX1SnjHgUZzTFt7eV4S8Uga04KkjKAiTEbpQg2Aqk7V5hoXX2by3Vgm3l84K95/23tYXZjhzvlTfByIWuBEuB+8TZKXolTT44H3ph8C1QQf4WrkZvaTpXXt/9CCdI79dGRx5njgYyVKxDMB/bIKW0CBFYUK4dHIkZ0nVRiF6fMTm5Qea0/2BT+tJ4bn+hWPcpqL9yOqbyQCbpSCAISTtkARDPO5PyoKUaTSYUpnwp/kdf1Dbr8BMXFKoCD1bqpNECHBNNIMH6eq6lqnuxuvqyRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EIallbDZQqPnj4t5E2adbK7o25+8EmHC2146XW0dC8=;
 b=W0takx2sCeM1fWg1h+VvlAj1wsmnGM8TW/86fUS+1DL0uJo3WRclBPyhMibRnkqtmWvW4vy5wrQEbrE+pcX+kei6NTBlSSF92qQsVRZ2kTrxNVfmbyrr1tUGoG0I2pjg3u01BPeVDg6a58preF9AX02rG26Ol3d0O57SYV9gBLz2tCaJrDXpXRBdNmvNRIjVCux5Ck14aNU6oU8l3uQ1+RGceFVzmX7LYWX8OY/n4/LtmfQcDTgk/cVxMvTpZZnLgvlfoWS62323YbiyIljxaWpOqwpmkb8ftyWBFL0Mf7W7axW8tYn7ZmbFDjOxE/RL9XZ278HwJ70CsbN5l7Qh1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EIallbDZQqPnj4t5E2adbK7o25+8EmHC2146XW0dC8=;
 b=swBkuCWbOfDoN5qYtncOIpPjtmWq6KwrVnqnKShJlkW4H04ZcwQGG+rbPSDmLaTdZNaHSqq49B7tSM/fbE6F/7UecomCwU7bL2iFdWKecljciPyZ9hjwrrMExR8iIkxF5uEf23XmCzihqTzQMZ9qNYfcI44z0VyUeY2sKJhr2Bs=
Received: from SN4PR0501CA0002.namprd05.prod.outlook.com
 (2603:10b6:803:40::15) by DS0PR12MB7728.namprd12.prod.outlook.com
 (2603:10b6:8:13a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 10:28:47 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:803:40:cafe::60) by SN4PR0501CA0002.outlook.office365.com
 (2603:10b6:803:40::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21 via Frontend
 Transport; Mon, 27 Nov 2023 10:28:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 10:28:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 27 Nov
 2023 04:28:46 -0600
Received: from xhdvnc205.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Mon, 27 Nov 2023 04:28:42 -0600
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
Subject: [PATCH v7 3/3] can: xilinx_can: Add ethtool stats interface for ECC errors
Date:   Mon, 27 Nov 2023 15:58:15 +0530
Message-ID: <1701080895-1475-4-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1701080895-1475-1-git-send-email-srinivas.goud@amd.com>
References: <1701080895-1475-1-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DS0PR12MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: 56915305-e7d0-4fbc-1a16-08dbef33a3ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0HVssA89sIUbMIosQB87c4w8CGKtqJAa4LEKrIP/u63I43pU6aWdu+W4sqqV2rgZS4DQ0xNTvyNmmABXjPDgpxIQ70mUoYsvwv7vpsdcMJ4aMgD6N4hLVrPqSzYHf2G47fCfhUiFPqyolWGA6g1zUPV+GoAQWVtb4V09vfddk94UiwXu0XwdG3At4V746OiCJBpHG2BWTArvr2yMan9nDEwFVFz3/k2dRjVIqc226NzevckuWn5xsGxq59XMIkEsEKm3gC2hZ2HDasbFky3iPoGDWvnoHzGwA/4v3uqCnWUy08Njhp9U9GifVvPfz0JbUYTAI6ZDMUdw22E8c+evwR2K7MIhh8PX8C8NgOeuOyRuIc02VBWZjzBk+knljlZF/MU2XRasjAkH6Er8aO9RWoySx4LD+ZF7i87Y1d6hqZEdUAYCWIJ6iPor2xfux9nuVvLPHQg5a0VaCKyVzR16XP8yADpM73PDjGoq//87ENH4M7uFrQf66wXKoSLbKgxFAgVHB1Y0AC2+BVAlBEQUZYspCi1TGNCa0L2ZuTG1OvYyciDHslg43k65tN6Gmbpljg36GNieTKZ4sXB/FUezIdxVxunekuo4cFGg3UhZIvNpm+9cEx/hfe4Dw+5NKHoAkF1BUw6z/+sLL/I3EVwU8InXRZUd9p7Dl+Aw4sLjiWCeG39wK/e+WDws84jY8vAuC4r5k9kQn+v8D2zKJ53kueygV00+2uYPzmFyhdeGuiLkwkUGvR4AQ4+Q5kdgGqK6mywALgDRfg9Chx5SapA53Ls20+yQPAFbZBtJHMdGbvw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(41300700001)(36756003)(921008)(86362001)(81166007)(36860700001)(356005)(47076005)(2906002)(83380400001)(5660300002)(82740400003)(7416002)(426003)(336012)(26005)(44832011)(2616005)(40480700001)(6666004)(8676002)(4326008)(8936002)(40460700003)(478600001)(110136005)(70206006)(70586007)(54906003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 10:28:47.5093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56915305-e7d0-4fbc-1a16-08dbef33a3ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7728
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

