Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9649B7B7C7C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242038AbjJDJnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242046AbjJDJnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:43:06 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364BAA7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:43:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uq0IK4KlJcyVGS+pIkw/+KlOwhR8fqMKE0IGOehBmdabsz85JP+NzfYCS3tY1RR2qb4UQdz5ZA2aCKRQviixBsXG/g7cTJkSyuN2sZV7FVSqhpgGECub91kj/ozz2JyJOyw05NdKCI02GOGA4Jy/R67oWNkd0Q5Joe1MukvqLvstVnkx4jRPQfEzeQFMGfeUvZvRiPdO27IqBFF3ZYK+WydP/j5AouhiOe8Ojgii3f22OmgA9qgj1A3BbwIATEyPsssYwljbgZtHuHoTYkQbiB11nMaUiPijKLhqs8AEJ8TgWrBlaXdwHGQWTEvEEMhg+mhN1GW7QTTYxbvmK9LMvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wY+XKMOzMftdW+wGm79wKtIRAsDu0sgkE4NmaF2aPc=;
 b=Epf3Z+KyDSg+QjCQdgZBdqMtL1Gq5oH86rIFI7CpFaqoeLFy+udvGkpE++h/xVpJSIC6h8A59GbTVCWGdxTx6IIicAwPiNZH3yRNXk0oSGSGrxFOtQ5wAgT+TnMv7P9aXTn5EKdXlsaH3dzfIZH/14TZNDG3y8fCT+KSz/FegRYILrfEjcbnP20b5rxR+Xv3xx1+Svu4B+Jb/RRCO7yrfdSz4sXSZysuV0wgLcqnyE+Xlwd/h43rrXTqasurbGubyqpEaxida9RRlYxb7VvS/A9YO8lmYlSkV3TMczvm8SDkjrhrddEb476uRX7ZRJhqGJ1V9/2PrLizVdcJfuVxqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wY+XKMOzMftdW+wGm79wKtIRAsDu0sgkE4NmaF2aPc=;
 b=SARugKS3Ji9wTl4Y60iXBvm8WNN+S/B99ppxiJFsiclk31Y2FGa0LHWvaoBm4E5AOPyjJK3fTrWD8ZGuFr09wJQWkLy85FwhZHFmX8ZhxkDWU5jpHxG4ffOg9sqt5f7xUDigbhKumc1ipcyq1Aiu+qnSf5QnaxBvRz/CRvmHlf8=
Received: from BL1PR13CA0248.namprd13.prod.outlook.com (2603:10b6:208:2ba::13)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 09:43:00 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2ba:cafe::cd) by BL1PR13CA0248.outlook.office365.com
 (2603:10b6:208:2ba::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Wed, 4 Oct 2023 09:43:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 09:42:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:42:57 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:42:57 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 04:42:56 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <tanmay.shah@amd.com>,
        <gregkh@linuxfoundation.org>, <nava.kishore.manne@amd.com>,
        <ben.levinsky@amd.com>, <robh@kernel.org>, <dhaval.r.shah@amd.com>,
        <marex@denx.de>, <izhar.ameer.shaikh@amd.com>, <arnd@arndb.de>,
        <ruanjinjie@huawei.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH v2 3/6] firmware: xilinx: Register event manager driver
Date:   Wed, 4 Oct 2023 02:41:13 -0700
Message-ID: <20231004094116.27128-4-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231004094116.27128-1-jay.buddhabhatti@amd.com>
References: <20231004094116.27128-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c9f2c04-7ae5-449b-590e-08dbc4be4bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bo8OYgmZYAx5pR764qMAXPKuILQik+JviCQseHZ4kWOesAcZf+7NeKEUYjKgy7qx08PoUzb+ZL4DmWAlWLz0M9P951Xx//mp+rkcAjghvR1UbYLrWMCPqTCnRyXuJWZOJZQZcoZI5fRrhmnz4adXaGjcWLYjChiLKC+suZW9JumWGoDZMn6fuU2vUa2nw3rrSflVC1V0nrAJSY6kR19O76VRLiDhL8c3S/TS6ncbSUujVOUvljD5+i66ZMQYfOkbcvf1sPNfZf7tG4pKach8l9aBkG6ybVUaXMBmBnWxoDcFsbwsAHvcnKBwC7tVuXp2KCLmKHksQGUp1vLCaWziaIPYP6LdEFS+H5PxbrRqMCOFGnZ2X+18b5NuIGRKKjNnG+00n8+wW8YwjcpUGZIQZcTVvGAkWgb4KcQ+AgfvY/6s8s4Mpt5P7S0AWlPENgtolPJFGXXSHmY85JOwr0ZbGuUZTo8Gsgqw+sn6qvQ5RFNgIFM4KeL1mD7yJD/quNc9qXQJac2ZYMtft9Q4QWircrOb2VRUkEf+dqZZw9nZV9CMRHu+2twvrbSM/0BiGk512gtIfK2GGahcDU6cpdCNUY3cxlqWqPo62G24DqZNOuCkgdmplZgd1gW3tnb18pDgTDMF6t42U9P5cU0mmwvOyupkotgnOCF2VmiZAFP9LlolBOn8CwvXGPlof39/PV2HjYZuJuojmHBbD7oLAbbox92Q64DUAG1yI4RFvGOKX6BsEY4bT//8KKBC97oZhdsvUOBow/fZUESLfhOcoLr3drx1Api4dDPOsot27nhU0ac=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(1800799009)(64100799003)(82310400011)(186009)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(336012)(40480700001)(86362001)(70586007)(54906003)(41300700001)(110136005)(70206006)(316002)(478600001)(2906002)(8936002)(8676002)(4326008)(5660300002)(44832011)(83380400001)(36860700001)(921005)(47076005)(81166007)(82740400003)(6666004)(356005)(2616005)(426003)(1076003)(26005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:42:59.8044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9f2c04-7ae5-449b-590e-08dbc4be4bd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use family code in order to register event manager
driver for Versal and Versal NET platforms, instead
of using compatible string.

Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 5f40288f69a9..00ea2508f692 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1953,7 +1953,6 @@ ATTRIBUTE_GROUPS(zynqmp_firmware);
 static int zynqmp_firmware_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np;
 	struct zynqmp_devinfo *devinfo;
 	int ret;
 
@@ -2016,14 +2015,12 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 
 	zynqmp_pm_api_debugfs_init();
 
-	np = of_find_compatible_node(NULL, NULL, "xlnx,versal");
-	if (np) {
+	if (pm_family_code == VERSAL_FAMILY_CODE) {
 		em_dev = platform_device_register_data(&pdev->dev, "xlnx_event_manager",
 						       -1, NULL, 0);
 		if (IS_ERR(em_dev))
 			dev_err_probe(&pdev->dev, PTR_ERR(em_dev), "EM register fail with error\n");
 	}
-	of_node_put(np);
 
 	return of_platform_populate(dev->of_node, NULL, NULL, dev);
 }
-- 
2.25.1

