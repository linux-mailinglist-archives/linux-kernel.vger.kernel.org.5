Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B3B7E3B1B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbjKGL1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjKGL1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:27:40 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD8DDF;
        Tue,  7 Nov 2023 03:27:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URcLZR8rSYxLcCH6zCQuQW1Sazj1r4olb2Y/cSNOPeajlS8d4SSD2o54mCsEz3wWPLB6tfs5MJz+RvTHcdMg2HK49VGgdeggfBZlK2o+ba++5dat3KARwIwL0nm5JeSv3CNn4Gt1Md5YGM6jkWoqQkNpMz/p3cOhj91G8s2/pO6TS7q2AGN9NQUGB9IsPrFeN/MtOjV7pdaZDGrSSWk0M4B7IC3JJkTUqLLFP83wKujEXmvJaAqOTWI+lZQ6UIPXs1SKlQx5g/y4WeEx7yPWeitQeWYQDwsSic5Rpyh72JH+ssYjw+u77avZ/+Eni651OnaGH+PSXaF/YKxuXlL4fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rPTrI4N6EiP01QE8/dQYzX7H4QBEz64YIafMXZMSjI=;
 b=XUgdcMwyFKP5v0d/lBLKs1bketsjPsQvqK9Ses09Lg+mG4MnK/pCnoDL/nGTu+C7c7TtccVqy6zUjU/ldPiwKU3TBF73/vG0vP1jUR0Unv40miLHcOdXDcVmhW64nnXF9w8AMcA31mcvnhgLKW37UrGh9ubvoOJIOPPejSPZGNBKkpbc4SwBO0pZijpt9d/E9C0Lcjvhd0m+MJc5gsWLjzvBN2lQPp8QIwQnBfJsvpLNz0N7dikJCvwS3YMR62PC8pDUNetELJn1DX1gNejSbipRJejSsNKmO+KDBPsVpAgtJcRtS2KuSx3qz/l1gO9XlJwLbPHs6qFxyGSlwgSuZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rPTrI4N6EiP01QE8/dQYzX7H4QBEz64YIafMXZMSjI=;
 b=Cx2Fo5Xki0jldVILYxCaBsvm8RyeSdMb42ekXuc/jGQZ7BEgCTPsRbko9xnQyYBNISgqqHGbn4tikLgFzBN7sSojFx+CMn9aAgx7/Narbap4bLZdelS4jMlXnG4JaHzCDQ8UbVgPwad9sFMKW/s3Ib1hbGAUii/W9NHr00P9zR5XZPe8P2IKXYuYy3poVwYRZObami6cI1IrD5sULNgKs42JMznNlgcs2JUu2x7bh6lRk5a+UZm0XwRMVP1jRNtNa0h1OHvNGxB4rl9kBgj0VEC8tiWOaO/EMBxxO0vdVA4a5wJ5T2SfyYl9FyU3XOZ3Zfqj7tXlw/QblxCc1F5MNw==
Received: from MW3PR06CA0010.namprd06.prod.outlook.com (2603:10b6:303:2a::15)
 by CO6PR12MB5458.namprd12.prod.outlook.com (2603:10b6:5:35b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 11:27:35 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::48) by MW3PR06CA0010.outlook.office365.com
 (2603:10b6:303:2a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28 via Frontend
 Transport; Tue, 7 Nov 2023 11:27:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 11:27:35 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Nov 2023
 03:27:18 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Nov 2023
 03:27:18 -0800
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 7 Nov 2023 03:27:16 -0800
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <dmitry.osipenko@collabora.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Ashish Mhetre" <amhetre@nvidia.com>
Subject: [Patch V2 1/2] memory: tegra: Add SID override programming for MC clients
Date:   Tue, 7 Nov 2023 16:57:12 +0530
Message-ID: <20231107112713.21399-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|CO6PR12MB5458:EE_
X-MS-Office365-Filtering-Correlation-Id: 98aa63bf-4b11-4be4-ee29-08dbdf848a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: avq4TTAHnU50OxbTTroOvOtGD0AcyjCXplec6CnjY+5tCcYsF4klDf9qLgAM7ALHzIgrCgv6OVdSXhdW0LTLLXotQ7+Hg0XiyhqXfsvQm0bEc3zSb+rJJhHvD5bQGHEcmWvDxx5Tom+3E8Vdr9uHpr/JtvnutecRsAxFgcojP8gbOVQ4zbUzpkce6ctqIMtAxr74EN9vXpn6pSVDgAYH57AmriBTCoucw04QEiAF07nWLPUR8ai5pzAAKP/xMI/JEZqpGpEODXoGRTvssZ8WcEeKdP6ocf11xR/s2c39ZK98Kf/bS/7LoM3PkYVFh2vJVbHxrwCSPlgtSRuEBSfGT2XH2rT7Mo9KPHUVTdCywZ9ASBGEmmIrB1d66mSshqiPkYU+EEx2zsTYG5jYTj8EwvvO5CqNN9pocZEQBoaxzeqMsPRA2OIZIIrGHqw18KUvrJJlhsiq2niDjFZUlzWhuMRmcPGpLP0Iv8WdUkJuqDqgh0n5SF2TvqEZ566q/FH2vEiTOQV7iabn5X8BxaT4c5j2ek/mHkqpcivqp2rQf3cxGcQBgb46Qwg0z1N7A0Gi+lXH5t4C9CdUWFJUhU/GDEVflzM3KShCRachhcRmpjhL+cQnY/cJyf0oSMdlUZ9O1fJKoV/SzZ4urMOLqhvYe2oXQiOG3BBCZWwBD9x8WHhXOZJMxzJ24KyTejEH10RoLSUG0wMEnxNAW8yMjmkemTHa17nhV4a4kVnenssnyUVz2p2yAS8RfbCybI1nZOaq
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(41300700001)(1076003)(478600001)(47076005)(7696005)(2616005)(6666004)(336012)(426003)(8676002)(8936002)(316002)(83380400001)(36860700001)(2906002)(5660300002)(70586007)(4326008)(110136005)(54906003)(70206006)(26005)(356005)(7636003)(107886003)(82740400003)(86362001)(36756003)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 11:27:35.1255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98aa63bf-4b11-4be4-ee29-08dbdf848a58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5458
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some devices the bootloader/firmware may set up the device in
bypass. Memory clients like display needs kernel to program SID after
resume because bootloader/firmware programs the SID of display device to
bypass. In order to make sure that kernel IOMMU mappings for these
devices work after resume, add SID override programming support for all
memory clients on memory controller resume.

This partially reverts 'commit ef86b2c2807f ("memory: tegra: Remove
clients SID override programming")'

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
Changes in v2:
- Fixed build issues reported by Kernel test robot from v1

 drivers/memory/tegra/tegra186.c | 14 ++++++++++++++
 include/soc/tegra/mc.h          |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 533f85a4b2bd..8203f0db1350 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -136,9 +136,23 @@ static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
 	return 0;
 }
 
+static int tegra186_mc_resume(struct tegra_mc *mc)
+{
+	unsigned int i;
+
+	for (i = 0; i < mc->soc->num_clients; i++) {
+		const struct tegra_mc_client *client = &mc->soc->clients[i];
+
+		tegra186_mc_client_sid_override(mc, client, client->sid);
+	}
+
+	return 0;
+}
+
 const struct tegra_mc_ops tegra186_mc_ops = {
 	.probe = tegra186_mc_probe,
 	.remove = tegra186_mc_remove,
+	.resume = tegra186_mc_resume,
 	.probe_device = tegra186_mc_probe_device,
 	.handle_irq = tegra30_mc_handle_irq,
 };
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 71ae37d3bedd..af1d73a7f0cd 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -162,6 +162,7 @@ struct tegra_mc_ops {
 	 */
 	int (*probe)(struct tegra_mc *mc);
 	void (*remove)(struct tegra_mc *mc);
+	int (*resume)(struct tegra_mc *mc);
 	irqreturn_t (*handle_irq)(int irq, void *data);
 	int (*probe_device)(struct tegra_mc *mc, struct device *dev);
 };
-- 
2.17.1

