Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CB37BD7FD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346090AbjJIKGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346067AbjJIKGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:06:34 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C869100;
        Mon,  9 Oct 2023 03:06:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpmYJ2yCNRo/a6zkS68ehf+Outn4LWowxP7Dx6/Ilm8katjOJubgcVL4u9ylDP5Ia1cZ1CsZB3XolzuQl+Vw1dlNsZJEh93mgfa18VQx+I6fx90Ctd1wxG/6Ojs6wsH1ktLl3F7Af4l76lBFnvYLu/yDumN6lxaETajTFE5BtgbL7xZV7HxjaLy7/Vpd24sj3iZ1OCG2eN79Nz/FqY7bUqyCAQKNb7LrKa+k8oeH8F2RUlL0aYdbFioMgxgsLZTExIfQhyyjsESlYRMM6dYTOX1Aie+v5OfXRgtjUEpeXQPaFiLUzyIVCJ87sWH+7X0dO2F152VQlCZviqAwC3/oXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAyZrQ+jo6RyAs6uhaLZoFpVuY2bEE01tn17f33UPTA=;
 b=c72DjYY9wjG1HirW5/QvdtwExbuYK6vW8GMiqFk7OfLxlqnzG9hqfTnH4vJ9pQOPJm3JqqAV9Xkv0PrpX+qI0XEWe1VNt1Z0vMy3MegCwnfSpLgSrXbhRttxtsDFdX8vn8t/vVnJmTahYnF3Xi00nWun+XzleuvAC5H2WHNEMyJXDP3bJVQ9X+u6rUfvmm0OSKPHo233OQqoJSrDvHQsuLh7Ln487dEqcIkKC1RVM8lPgoaeqcwnpNaCQp7liCurFaIXq7tAlhAEsIVTtrwK558699JrFEM9vG1QUL5GjdcpvTyRmmqstQlEPsx8L58frtDaZrGDbnE9v1mu8K+TtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAyZrQ+jo6RyAs6uhaLZoFpVuY2bEE01tn17f33UPTA=;
 b=fwfh0OGVrFvWyAs460G2fUq+CRSp4cYBTyPSjInQ2jZZqi81Y+mu5Z6GRJR23kY8BN67npqoCXl4FHJ8qXJp76g8EGPfYVsV5KrRxQfo3ciIuzvFIDA0bNdWyY5FsIAP5JOOaAFiJTEMesdDsq1p1poD8D9NWW2k+4HC66GI//BqMz2C/uyBBoa1q3UNsQbVcKN/9tq+ipIAPP8Wlm1tOhR3AaH7oupDrXWvqJBpIww6JHIc0amzM6xyuNVYy8kzk1GaknIh8YPdRYfqki0BWoEh/S82HguvUq3N1wTt2yOB8gZ8ads8nGDbA6dwXFN+gghf4jnHp/YMQDUmLI46Nw==
Received: from MW4PR03CA0300.namprd03.prod.outlook.com (2603:10b6:303:b5::35)
 by MN0PR12MB5929.namprd12.prod.outlook.com (2603:10b6:208:37c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 10:06:27 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:b5:cafe::72) by MW4PR03CA0300.outlook.office365.com
 (2603:10b6:303:b5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Mon, 9 Oct 2023 10:06:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.2 via Frontend Transport; Mon, 9 Oct 2023 10:06:25 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 03:06:16 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 9 Oct 2023 03:06:15 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 9 Oct 2023 03:06:13 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <krzysztof.kozlowski@linaro.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch v2 2/2] memory: tegra: set BPMP msg flags to reset IPC channels
Date:   Mon, 9 Oct 2023 15:35:57 +0530
Message-ID: <20231009100557.18224-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231009100557.18224-1-sumitg@nvidia.com>
References: <20231009100557.18224-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|MN0PR12MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: 84942fa8-638c-448b-6dcd-08dbc8af65c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ynyQB67M/lQi3wNOZKkVNfoqNFUaSZsDgfFm64/yxObyqzOSUcHH3EEcIQ+He/m03UIitM5opb5l3Rais2zxkAvjVVAR4Ft1DgCBeW6J9RAqEGmOJMz+NR9tZKxKUTdGGwgvVO1Wh2eLe77MIC0sLQlf72ax2W3GNcRJJbsfkO7UDe72NnORm56q41lwAa1AMvplCgUT1DNY9mNaTMfepuyw08G2tkZs6VpzlGMzAyxgYEpKg/ryMpfLDYEDc+sds1LpH+ciVMS+cJZjHZjhlWXyvLSvV2mo0NMgiGY6oj8mXz4eTlalkFuddIZVpq5L++WsesNTLoo7DQND5iirzLCu8NFrOq7mPIlU0F8Vm+KBEVae99tD/VXzyF7Vzxv4Mxo6UysKIws1eipvaSQXPaUwNqXSU+hSPSPa7NDQMfrQR0OGrZgMvfncRE/lxiQU597TW60HG9Ty5Dd1BpfdlgIcnKh0h2Yazj7i7sBhUki+Ymp3Hg9hT7paF5lfauHaEhvorC8AAs3FjAY6dS9GsxScRAk6OdDzPZFZxIWEty/s1EK80GvujNjhywBmKuM8J1PN2mGW6UVv9wdl7FKwikoq3SWQy2/uNaI/fIuljULT3GUsZHx9kOmPsJDFHZdNDxk24RtRwMPoAYc+4FkgmlrLXhmcWP28jTzk0DX7AQtCrXCsUnVsB+X9bVjNcFPGyP01WKXUMXPptTw6FdMQZREQuCpRSiij8OMmM289In/UuWTS/vIdnNQevbKO8nbH
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(83380400001)(1076003)(107886003)(2616005)(336012)(426003)(26005)(47076005)(316002)(36860700001)(110136005)(54906003)(70206006)(70586007)(8936002)(8676002)(4326008)(5660300002)(41300700001)(7696005)(6666004)(2906002)(82740400003)(478600001)(36756003)(356005)(7636003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 10:06:25.4389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84942fa8-638c-448b-6dcd-08dbc8af65c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5929
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Set the 'TEGRA_BPMP_MESSAGE_RESET' bit in newly added 'flags' field
of 'struct tegra_bpmp_message' to request for the reset of BPMP IPC
channels. This is used along with the 'suspended' check in BPMP driver
for handling early bandwidth requests due to the hotplug of CPU's
during system resume before the driver gets resumed.

Fixes: f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidth")
Signed-off-by: Thierry Reding <treding@nvidia.com>
Co-developed-by: Sumit Gupta <sumitg@nvidia.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/memory/tegra/tegra234.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index 9e5b5dbd9c8d..2845041f32d6 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -986,6 +986,10 @@ static int tegra234_mc_icc_set(struct icc_node *src, struct icc_node *dst)
 	msg.rx.data = &bwmgr_resp;
 	msg.rx.size = sizeof(bwmgr_resp);
 
+	if (pclient->bpmp_id >= TEGRA_ICC_BPMP_CPU_CLUSTER0 &&
+	    pclient->bpmp_id <= TEGRA_ICC_BPMP_CPU_CLUSTER2)
+		msg.flags = TEGRA_BPMP_MESSAGE_RESET;
+
 	ret = tegra_bpmp_transfer(mc->bpmp, &msg);
 	if (ret < 0) {
 		dev_err(mc->dev, "BPMP transfer failed: %d\n", ret);
-- 
2.17.1

