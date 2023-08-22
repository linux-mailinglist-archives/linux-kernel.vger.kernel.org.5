Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF63783E37
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjHVKqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbjHVKqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:46:17 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A895CCD;
        Tue, 22 Aug 2023 03:46:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7RE4LXterH/mhWrs9noXKOD/A84/MAg5V4M5ehCEtwoW4fYinTb6Ch3kNUfrxzvNBODiqGSmXjxlErfA7wv+a7qCM/dVTUMTP6kdYhC4VgkynxS1aRzYSbFZZZ+0eUfJo2sfJ4/Vr03hH/hUT3vxJWXvxUzMGbE0actvw8FfM5Uls698xdTew2IZ+bcFGk0cXzjFEsgXG0aYUeNPnEoequk1KJW7CapdeT2URWM7T4G2u4bQF8M8v07sMv3qJ2HKbuxOAGDWv4KhNmc1kfTYwjRwsvc1NAVE8RZEiW1LeE1A63NJmelhonj+zhPKGdamooVoV0Gw4a4hXYnTGybKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIBS4hqvqg1D+srj+7KC+ddOxjvmaFyfZLp3JtIB1JU=;
 b=FIesdRcXrftv860LcCSpKX6gooZiDChZEmGXT3RF0KvF9G3EpCMM26RDFxujw3d4KAAiLOFd/x+AeKDDhM35lpsppritK8juip4a52VnSGVvOZAKvhIp4IwJgRPZ6++5QByhImQ6btfeWAcMZ+1zVYaY5AkKyWy/vSSBlo3SV4ohvwizNXoc1yadaD1r5+0xFs9Cqb2IAdfdNwTmA4VdwzBz2yzFJsFYhZldq8L0sti5jf3SPgnpk9QoC9SfaJ0fvRxykqcnc2d5GibKCkgtASz5Rhif8cph1GRQ/X487FTwAGxnDvqFH/UYkfZH7yyqWlC0Za+IL8+ilU/lvT0vyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIBS4hqvqg1D+srj+7KC+ddOxjvmaFyfZLp3JtIB1JU=;
 b=OB450imWkkk3n0L/ZdoYO8T5Al884D2dtIzPJdbJurNseK/shuImhSWbD7vqIKi71Qte7lfi423+AbeTuHDzyQeFbeA3oBLVxKGe2UNcCY0yT2/2uAdziQLeNf8NS8t8+Kl24TOHJtV4nxDEHdWIEeO0GlooK5OJUKD8ZHD+0Dw=
Received: from CY5PR15CA0105.namprd15.prod.outlook.com (2603:10b6:930:7::13)
 by SJ2PR12MB8011.namprd12.prod.outlook.com (2603:10b6:a03:4c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 10:46:04 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:7:cafe::f2) by CY5PR15CA0105.outlook.office365.com
 (2603:10b6:930:7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Tue, 22 Aug 2023 10:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 22 Aug 2023 10:46:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 22 Aug
 2023 05:46:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 22 Aug
 2023 05:46:02 -0500
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 22 Aug 2023 05:45:58 -0500
From:   Srinivas Goud <srinivas.goud@amd.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <p.zabel@pengutronix.de>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-can@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <gcnu.goud@gmail.com>,
        Srinivas Goud <srinivas.goud@amd.com>
Subject: [PATCH v2 3/3] can: xilinx_can: Add ethtool stats interface for ECC errors
Date:   Tue, 22 Aug 2023 16:15:36 +0530
Message-ID: <1692701136-1422086-4-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1692701136-1422086-1-git-send-email-srinivas.goud@amd.com>
References: <1692701136-1422086-1-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SJ2PR12MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: d893352a-dbbb-4e01-aa55-08dba2fcfb9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q5AKvmDQUfcGJ5+2AKDo5ize/YJbaqNnwMqXacLRfevOGByM9io6aFQIuYbUeJN3OKWdCcbYkIDYrf5OGkiYh4SWd2v8GvILqkcua9uo5jyj8nZOY+xP0BwDGbW8Nqmllx0hDkXso066Rai97L87moMJRv4D0tvDh729mcjHcC858Ey+S8GEZGvVgSzG0uDEx4oZDLY52Wwqszw9qo7AxfSmToxNxS39hg98EAPxEuqt8mxxywpKI5n8s2rchiixQJfraVuB194i/GxQIcEwVW7o2ZlIFaBRY5kconDq0HvrfVCAxOLGjQVk3gHwND9MfwgjGWSv1/v6ngm1n/WMYl1IHKERNGy71GYCZVZKZG6cJJtpTZg1plVE1gP+LRwq4ZCz0fsQEEV01YVC9LeTZ/LwZSRVSQDMtwpVLcshdyQSJpiErAANqq1qwZgBsh8bVxBYFZX7WwQXNio/yypxW/CwXlOaEG/43vO7TNsg3zj3awTMWzV+IvgsdMRGfXPYGzw77a4pQF4xKbw1w6FTYoej/PvVTiIcsJMJTBo61PwaDDSEb+IoL3jwqs9f/rSjbnl4SvoTgg2ikggIHUe88rmp6aimop657x5o7spWEh0ktsoegeUWfOOySP5DU8ZA9Y1S5E4vQkPl9WD/DnykhiP2r0suhsT9irSknp8gAhO5U+JdrqcF3eK0T/WHlPZlF1kxwyO5V1QkOrkLIe+8Xu41LYPJaKKaiHdLQcCGxkQ6rGA5FwhgUem5cgcSvpjxtIv6o0K1xzwHlRDR+/gdcXHg1pNuMT0L2xnUB0lovPI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(82310400011)(451199024)(1800799009)(186009)(40470700004)(46966006)(36840700001)(356005)(40460700003)(921005)(316002)(478600001)(70206006)(47076005)(36860700001)(426003)(336012)(26005)(6666004)(2906002)(44832011)(4326008)(2616005)(83380400001)(5660300002)(8936002)(8676002)(7416002)(110136005)(70586007)(41300700001)(54906003)(82740400003)(36756003)(86362001)(81166007)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 10:46:03.9057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d893352a-dbbb-4e01-aa55-08dba2fcfb9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8011
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ethtool stats interface for reading FIFO 1bit/2bit
ECC errors information.

Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
---
 drivers/net/can/xilinx_can.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 798b32b..50e0c9d 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -219,6 +219,7 @@ struct xcan_devtype_data {
  * @transceiver:		Optional pointer to associated CAN transceiver
  * @rstc:			Pointer to reset control
  * @ecc_enable:			ECC enable flag
+ * @stats_lock:			Lock for synchronizing hardware stats
  * @ecc_2bit_rxfifo_cnt:	RXFIFO 2bit ECC count
  * @ecc_1bit_rxfifo_cnt:	RXFIFO 1bit ECC count
  * @ecc_2bit_txolfifo_cnt:	TXOLFIFO 2bit ECC count
@@ -245,6 +246,7 @@ struct xcan_priv {
 	struct phy *transceiver;
 	struct reset_control *rstc;
 	bool ecc_enable;
+	spinlock_t stats_lock; /* Lock for synchronizing hardware stats */
 	u64 ecc_2bit_rxfifo_cnt;
 	u64 ecc_1bit_rxfifo_cnt;
 	u64 ecc_2bit_txolfifo_cnt;
@@ -1164,6 +1166,9 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 
 	if (priv->ecc_enable) {
 		u32 reg_ecc;
+		unsigned long flags;
+
+		spin_lock_irqsave(&priv->stats_lock, flags);
 
 		reg_ecc = priv->read_reg(priv, XCAN_RXFIFO_ECC_OFFSET);
 		if (isr & XCAN_IXR_E2BERX_MASK) {
@@ -1212,6 +1217,8 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 		 */
 		priv->write_reg(priv, XCAN_ECC_CFG_OFFSET, XCAN_ECC_CFG_REECRX_MASK |
 				XCAN_ECC_CFG_REECTXOL_MASK | XCAN_ECC_CFG_REECTXTL_MASK);
+
+		spin_unlock_irqrestore(&priv->stats_lock, flags);
 	}
 
 	if (cf.can_id) {
@@ -1639,6 +1646,23 @@ static int xcan_get_auto_tdcv(const struct net_device *ndev, u32 *tdcv)
 	return 0;
 }
 
+static void ethtool_get_ethtool_stats(struct net_device *ndev,
+				      struct ethtool_stats *stats, u64 *data)
+{
+	struct xcan_priv *priv = netdev_priv(ndev);
+	unsigned long flags;
+	int i = 0;
+
+	spin_lock_irqsave(&priv->stats_lock, flags);
+	data[i++] = priv->ecc_2bit_rxfifo_cnt;
+	data[i++] = priv->ecc_1bit_rxfifo_cnt;
+	data[i++] = priv->ecc_2bit_txolfifo_cnt;
+	data[i++] = priv->ecc_1bit_txolfifo_cnt;
+	data[i++] = priv->ecc_2bit_txtlfifo_cnt;
+	data[i++] = priv->ecc_1bit_txtlfifo_cnt;
+	spin_unlock_irqrestore(&priv->stats_lock, flags);
+}
+
 static const struct net_device_ops xcan_netdev_ops = {
 	.ndo_open	= xcan_open,
 	.ndo_stop	= xcan_close,
@@ -1648,6 +1672,7 @@ static const struct net_device_ops xcan_netdev_ops = {
 
 static const struct ethtool_ops xcan_ethtool_ops = {
 	.get_ts_info = ethtool_op_get_ts_info,
+	.get_ethtool_stats = ethtool_get_ethtool_stats,
 };
 
 /**
-- 
2.1.1

