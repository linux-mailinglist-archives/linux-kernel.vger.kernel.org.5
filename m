Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661A378FA23
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345900AbjIAIlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244599AbjIAIla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:41:30 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276981711;
        Fri,  1 Sep 2023 01:41:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpnOxZqNOskQTJRScI2DBt2xi5AiaHpwQRTgMSezum/uymWFN6xddS/+sVX6V0ngGCeYHVbiZwgvZkvOuUo11cXKC8SrwZ65hNYKIhLUtA+2wihywmUCOGJTyPB6osLM5c1AE1ij/OodONLU5MEEturAyTJjQXSgaRiz7Dixv9AD2TFz0A0Tvy2D09r7VrQC0xGI8uJu+1ucmS21M5wB28eZSKStuA159TnifVZRw8UZ1oW1TbiPEKVY/5DzWgbqEhzkTLjiItLuA7TZl/iuYmChgEhK0Sqe2eWgYJECDGSZTWwVI9m43tPdYgyMmgEuC/xId0dXmgneKzkwTsuDCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X94PzQWYOpgSPSAlhnLh7/f2hOE8FSsK9MDTEuRQfcM=;
 b=DSPEbsx0O9phi1jAZZuwGvoiOsvIVXZPAakdVnmdcHU8hwvaICKIiJZCNy3gPwDOVnkwZNnekAit6GQXMHNhN5FC5xBRaXdkZHHPKKNu1afGvoi1MdNQfa54IdkXEJsWUsmyBMSeHRpmtSUjSWfziB4TYlX9fhV3HqVuNHV1j7xXG3z8E2dXEshf6IZMJ9gUiHNrDMckvJvf7xqYMIsCrQLVgRpl5xvaKMqtwEKmiyC7ol5nNR8XXmLdE9dp4a2Tgp89NpwlMmv+nMBf34AXVfwCSDHxS34Wh7ehfTRZiQnNjHVDKzT5yEsd+hML3VoIG65R7kESzLuMHxOX4GqL4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X94PzQWYOpgSPSAlhnLh7/f2hOE8FSsK9MDTEuRQfcM=;
 b=bMNFrHKmJ8GgR6icW8Xv5eFWhlhQcKZ10C48HNwmu3OQ1g0wnyErf/PLaoCTE3z/t+qJzbrU9DnWN/HRRJyaHBvg2QDZDvWehPrb7MONMm3c1/Z78b9seWZwE8duQzZJ2cpBzNTrMTiwC1T/kti0p1JStyoMtC44SF9omj56oHQ=
Received: from MN2PR20CA0053.namprd20.prod.outlook.com (2603:10b6:208:235::22)
 by BL1PR12MB5064.namprd12.prod.outlook.com (2603:10b6:208:30a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Fri, 1 Sep
 2023 08:41:22 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::9f) by MN2PR20CA0053.outlook.office365.com
 (2603:10b6:208:235::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Fri, 1 Sep 2023 08:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.20 via Frontend Transport; Fri, 1 Sep 2023 08:41:21 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 1 Sep
 2023 03:41:19 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 1 Sep
 2023 01:41:18 -0700
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 1 Sep 2023 03:41:13 -0500
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
Subject: [PATCH v4 3/3] can: xilinx_can: Add ethtool stats interface for ECC errors
Date:   Fri, 1 Sep 2023 14:10:45 +0530
Message-ID: <1693557645-2728466-4-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1693557645-2728466-1-git-send-email-srinivas.goud@amd.com>
References: <1693557645-2728466-1-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|BL1PR12MB5064:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d71bc4e-fa2f-43f1-8f95-08dbaac73808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qJSfobMd8VePigfoiI5zFhH/JN2xv42mH/8VtHvrDecKWkVKolnvQHE+tg3hjfHCGFJba7bt4D8Lct95eXTeuFfxb/2+VGiniq82IDVl95yXUP85MCBQLPItFCdmBMPOPTXL/aO1BblfVwDvthbcVTdLh1ZnmfdFS0GmkKM6TJA3FKDG7ZM2uQSpDv7Ic2+n6tivH3YY2CrVl4101LtF12b2P0nbYNAp2djI6vSFccJ+OnzvjzkbwfHcLJHobxFPPoLemuV9Gsv5muayjn4z9ziPj8Tj6kUPanODWsY57IRHj3hMPBOI1CF5WW3zp3Q9bTf+as5tisAsxMMwNr0G3Ol2AAWK1GqF9QDFNvdlcFk5UGompkIjtZNcSYJ/J1ZpwFyJEqDx/sm0DJbi6aDJ86yCmczSOmK5WDyfL/W8HmeFGKAqWWSQuB7Sn2eNIx9accMEGHi1mun0XWrAEFs2vDYE92T6ZCN8Pz70jRhRZUTJC8nwuoXYMNuAjprZo8Jm62epJBrhElzO1e4fsk8AMu9EF+ofp14w9GWgY4nNoOhf3FFQ6jmTnwDv0ykUwuKdPfS7vwH5OQwPxP7E2s98u6wLrN8mOmhxVw7hysGr26AEyU1TzB/Jl5GSh9WZusSPbqG85njrs/PeBvwBzElfjtX5XDF+wuNJ8CbPbeqnOJ/vCBr9yViOJ8EtnLCIb+RQwXWb+v8SrNtVwO9eG7YVRPCN83/b1EdGPUnnI1uBREP1SCgmvArhr7ppO2MWh1lozvmcSQ4t5/YI6SES92I02+Fc56XQecZKGYyiMz+oF4M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(186009)(82310400011)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(6666004)(478600001)(83380400001)(2616005)(26005)(336012)(426003)(2906002)(7416002)(44832011)(54906003)(316002)(41300700001)(70206006)(70586007)(110136005)(5660300002)(8676002)(8936002)(4326008)(40460700003)(40480700001)(47076005)(36756003)(36860700001)(86362001)(82740400003)(81166007)(921005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 08:41:21.7887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d71bc4e-fa2f-43f1-8f95-08dbaac73808
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5064
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
Changes in v4:
None

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

