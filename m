Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5624B7EEEA7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345827AbjKQJaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345806AbjKQJaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:30:16 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D71D72;
        Fri, 17 Nov 2023 01:30:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvB384MRywjKZnXklDYhrDoCHC2CnLbz2nkYAsCkyjLrfuX5U5k3RZrkM3kJSe1yJ2O0ojpbwlQzP8T+bF0ST2vtJVTAgvMGpUFtsxUvwWcI2dFz7OGxy3akKEoXRalhWi2WrsWGo79iGXeIxD9C/ST37oaYDgesyCQsG5jZR9D/5DzEsXKjwfuiJnESXCuPBw1hIeaN2YRkPsGmUs8gEPTTaTfWScOT6uBAMPmCz6n6MvhHojq2g/BumPcj7RlkCIBu8OBGFrWdNJmEV3a+8BaYHg5s/ZVqkCSvWqnCeWa0Ewelq246IfbGAQKcFqyskKN8CRNu5Lal8UULvFZsaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADYf81Hycw0btEuUqlS0DbgN0xoea1hWZrRYHuIyxfE=;
 b=BIsZw2nMvhFRt5Gmj78JDkfkHB7tBzy3JI0hjGe2ipAw143hi+roBXS5K8Cg5gVK7AIGaIzh8mDoujW0fjvTRLMj4dAIL8n+s3BiPGB5pgtodgtmTwSVFKcj9eu5AhSn7ZUYdrBd7rIzLbfTTCXbU8wg618qoT7Wcorv2iXyDu1kWEFan+lmAOpMMI3OKseE81TOmUlIsX12IA1+snqe6kVAPbUXtT9q83HBT9ZW9AKYBTpuj7HXSYHQ4RX/MiqVP6luvPOjYIBhHh/wZLNapVcAKd2xdc4jFC4c+l8E0YjwZ2RgsQqVdOYxDBidMI9LBJawkEciH6qK6W2VLrqc+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADYf81Hycw0btEuUqlS0DbgN0xoea1hWZrRYHuIyxfE=;
 b=r8M4t6tRZr2PFP8Z4B6ns7IvUuqc5/0W/NFjFGCTnm58LWBNCSDsmYYY5exmC9NnCv051Vx7VqJq0546nSONzodhEvhvlQYHBMKsxciPBWZDcsQIjnz9MRQV/0wwNYulv8Yy19Mppm/8YU9MMWH5bE6sSBqimTReFx8OTQ0NoB0=
Received: from CH0PR04CA0050.namprd04.prod.outlook.com (2603:10b6:610:77::25)
 by BL3PR12MB6619.namprd12.prod.outlook.com (2603:10b6:208:38e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 09:30:09 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:610:77:cafe::11) by CH0PR04CA0050.outlook.office365.com
 (2603:10b6:610:77::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Fri, 17 Nov 2023 09:30:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Fri, 17 Nov 2023 09:30:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 17 Nov
 2023 03:30:04 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 17 Nov
 2023 03:30:03 -0600
Received: from xhdvnc205.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Fri, 17 Nov 2023 03:29:59 -0600
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
Subject: [PATCH v5 3/3] can: xilinx_can: Add ethtool stats interface for ECC errors
Date:   Fri, 17 Nov 2023 14:58:56 +0530
Message-ID: <1700213336-652-4-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1700213336-652-1-git-send-email-srinivas.goud@amd.com>
References: <1700213336-652-1-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|BL3PR12MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a075f94-b650-4b82-72d8-08dbe74fca76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GUMDBJYBwDNCsU3pvkF0h1D15Q2al5FQizTTa4vynbJZoz+oFQEqU8GVNP20PjS/qBcQ4dJo9QCFwwQ17yll/xg48QG8+Wgnb5Fqjyhix10ka2vvppaeiL9yAlNNraGUhwLld+Q514Agei0WJZeMZFVzs+1Twaj3+VmvE6mVCWkFHipQlhz5eo0ptIZr4Rzq33fjOiiBGVeITYGn0Nc/3ierFop5AVWgkCGGQnfxJWMEoLsBeh31R8NmW4+nB2TWFc4OWBUXQcRyZwKftMTGejSvFBfT2+K5+6djNhSouGeWWD2xLS8eBfNuSliaCUWFziVm8kMnG3GdnMmfDfwb9wOTgxqKJS9tNmZj7ZQYM8K2T8KPTVQNjqd7IDqLlbVTY8zSv4crxUH7Dt1lHWuaq7NwrXDou3+l0MuzroxRlVqvBIzh2M7M7qwvfWBOjRE3gW+6Wj8ePsc13eYM7r5ri6miDxRXo67RN4ZYjH6suId0BYkJhqpZHWy1KqBzbpNNZmBNR4l5h6onyz2DUzA0jbf1cK8IFRmk6jKjttsCTV0czmReLMmusQ1RV1zcIqvvpQ2jZO4b5BOJD+/fB2YTWIZqYA2G4FSd9RqYCcOLVPZIbmFb7ZSG3EwASqDPcBCoVPdE7hPrxags4dFugqLsvFwiNTJlOXlgYq4jCItO0aZySdaB18JmGD5FatOV7M6gUTISLazC3jJrX7OL4vQrUrjscUWAr7cpQWYGIWi2gvLjP79IGsXeh9YBU5riRX2FSYytHoiRZbGpNrUAnNXV6uz3r/3PzAF3zlVv21VUyxk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(41300700001)(44832011)(36756003)(40460700003)(2906002)(7416002)(5660300002)(86362001)(921008)(2616005)(26005)(40480700001)(83380400001)(82740400003)(336012)(426003)(6666004)(478600001)(47076005)(81166007)(356005)(36860700001)(316002)(54906003)(4326008)(8676002)(8936002)(70206006)(70586007)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 09:30:08.7625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a075f94-b650-4b82-72d8-08dbe74fca76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6619
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

Add ethtool stats interface for reading FIFO 1bit/2bit ECC errors information.

Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
---
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

