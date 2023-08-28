Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCE878B3DB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjH1O75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjH1O7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:59:44 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2BDDA;
        Mon, 28 Aug 2023 07:59:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtNLGZKlQMjoFqCUU8Sqebz00NHliHKy8i9wVKqklDkCO4vtIXqHJ0JoAM7+Gr/ly+Axp6vXGrIP9W2+FTnJMouYqnDbyFXRQXdkBobCyalGnV14K3LtqyaJaDYw2j59lQFiW3OIpvZlCp4tf8NIKGVWZU5bMKUIjML9TqgyEFg34YhlloIHhIxcVR1T4+/mg6d4svyQlFW0iKXRQ4By62JrVnjDMDamK4oRbiVIhKOEUsmzlnfxQdVu6IPawddPXeGgrxJO+OXBOMZwvW/ydn7RaaIku2xovqdkwv3AGm/1Clx0pFRERhaAZd1CI7VWwHP1b9W5OEOEYoaTwXSmpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBugEgpNHH5ptwZZ2ho/bpfMJLxu0ihTRy/HgnxvITg=;
 b=Ykq1aJ+PG7jeSUuQrDiT1uGoPLaBxWSrIMmznRGcXgo4yHcU1QO62q02GKtlzMFquuopX391UfFxiyMBk654WYyrv5DBg8Nrt5Z6xW3bWM5rGgVbqSmHR6zliLfpnivXJNHtfdG2ryD20n5P5mKVTM7j6Szzrce7eCTluqP2sqYtBDr42e3Tkar1UkvmABqy5/QJtEM7JRYwztGA5n1kNG85slJpzxxlsr1UkBrX8siUuOnF/gEqgwOCxJfpjYWtMbIzZY/sjUg20JHGLOng6+pOBxCGdKfuXPTuP1HhVbOvq+JPuB8FNss9u0g8KlueWNfI5Wf4tgm27fR7lR8pHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBugEgpNHH5ptwZZ2ho/bpfMJLxu0ihTRy/HgnxvITg=;
 b=O3OermqtpiZRcTjzmBRX8u3pX+vEfduh0fPbRVFcSsao7bahzzPKluhvyee6MsJRW4x8uPgnzXqL4l+3gNxhM5Kff5f4C8Ig2EPq2B7Sx+Qa7fDAju/2lD31zu2kv9/Z82TQAyvh02nrc5Fu/1+LMh8Sf0Eby996lYQj4PGO5jg=
Received: from MW4PR04CA0117.namprd04.prod.outlook.com (2603:10b6:303:83::32)
 by CY8PR12MB7146.namprd12.prod.outlook.com (2603:10b6:930:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 14:59:38 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::df) by MW4PR04CA0117.outlook.office365.com
 (2603:10b6:303:83::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Mon, 28 Aug 2023 14:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Mon, 28 Aug 2023 14:59:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 09:59:36 -0500
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 28 Aug 2023 09:59:31 -0500
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
Subject: [PATCH v3 3/3] can: xilinx_can: Add ethtool stats interface for ECC errors
Date:   Mon, 28 Aug 2023 20:28:45 +0530
Message-ID: <1693234725-3615719-4-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1693234725-3615719-1-git-send-email-srinivas.goud@amd.com>
References: <1693234725-3615719-1-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|CY8PR12MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b33c171-3a23-4235-286d-08dba7d766a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TkWQfWhKKCC4iGcw4RYigKuYEsOr8Pq+7XlKvpz0UhQFsofxhW3ojUiLbFsYjclALg31rVrjrgn0ZgTUk2v5jgmnIDfqqOceNxnuvGOTrWrDD2wskpU10JXBiEv3DkolIIZYHnDAdIfILR2fvaoxHqq6oDCdW+c9ejiDsTdY1WFAodE8k9H6paAf2WW2AwPBIXmKhm8eIy0rDEJXfR6sLwn8P7HY4lb3citK2kunz3gMkBUGeCDixPlIjA0VwTJ5XuPeKB7A47q/QVaq9dKMgKy6fGVV5eoWu6rJKhHWgT6Dq9J15toJjIZSM3ofEmzGflhD1pnV/NwXp+TDEJiwnB0cCumeYec77ba63dpxTwe3ZCgv3Z2ryxrloxWu+mCaGyiuIOr2hdwVF5crakHtAk7gSV+XGvLShBVzfobwN5q0XKF9u8gbmsbQeta6f0YFPUSYHzdiD1H41Tb/9PO7yanWbIpckdGl1hmchUPsbtwrpRT8UUMcbiavQc/LeJJG0J6pd7LbFmAjQYPuuM25XILiv1fWFpaylBDq6S7NxZhZjE2y9tt2gXr2dLvEVkxGry4rrgYYp2cuBQiSSHQ8kgGzuIyj014ksJHYqouY+hFRpnQKo1ucAjsByHRB3hqqbb1rpWGIfZuBFh90d8D73LsBu5BA27SjavBd4b/geNsbjq/gbHqUtvJPXHQc21LquxXqB/MR9aG8fmc6AK+NtPujbiUUq295tUHpINZOH9lY7ocLeR9S0EeGBxiSmaJKI9VOYgNZ6S7tcDUgXLwk0NJhWwKvTHTcd6yRj+UIuBI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199024)(1800799009)(82310400011)(186009)(36840700001)(40470700004)(46966006)(83380400001)(921005)(81166007)(356005)(478600001)(82740400003)(336012)(426003)(36860700001)(47076005)(26005)(2616005)(40480700001)(6666004)(86362001)(5660300002)(2906002)(8936002)(54906003)(7416002)(316002)(70586007)(8676002)(4326008)(41300700001)(36756003)(110136005)(70206006)(40460700003)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 14:59:38.3426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b33c171-3a23-4235-286d-08dba7d766a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7146
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ethtool stats interface for reading FIFO 1bit/2bit
ECC errors information.

Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
---
Changes in v3:
None

Changes in v2:
Add ethtool stats interface

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

