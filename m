Return-Path: <linux-kernel+bounces-7941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E0881AF7D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E271A28657D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B4316432;
	Thu, 21 Dec 2023 07:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BeB+wngG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE68156FE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxBLw8OmMR6Muk2mQkPXvwbqCG/yCJX+YlRx8OJbwQqnsPFrfZ4BIHYsTSb1ejklBig+xfl74zAQLeD1M0W3Q6PNPmGhijYcnRCAQV1zTBLWzm+qiAv7523CXYUFvYRY2DQ/1tk0qOFkgcikgGDGi6G7Ic2vUI78NwCmVw1+i/fuZ0FAI5CaOOdLFaYHRNtDbq7vtW8ZE/G+umtx8jr5xgmNy/DBhBvz5m6RC6t6T8NuPDR+cKWogFZKHdlkAm21tqSCX0z2irl2YO4eJjPm9fKcgkKEntZvz7SJh08pQwvf01WusNLqLNtD+w4bCQZy7225yqkkJxk7JPeHe1pOfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jHejUbx5Ovbg4p8oogFnHCki7XL5gTAqXfCeasFBH4=;
 b=gEBZcXrSwvFzNDkBaTk4xK5epY9lQMXkwI8T1iZhLZAF7LfSzIFnyLH4MuzGQZswI/d9PCE4aD2Cod5Mcascg8yrjXrC/KCRepZIujnvK1PswWq6gNtdRI/c2m8D81g/zVuLzui0poUfsjeD6xv4eH7BE26liH9wO+fcpKzB0vv0v/MofNwjB7j4cpUF4Y9o+RddaoT1kmVatxC6n9l22hAuuUwtXbLLagdP8NjPR58FFSw/j2e7pIXep/7j6R0GdekeuFZIbDJmcTTYs4k8GmCV+esagbmVWRBtgzSC4+DsXsV/SHwgWNQsYYtfQ31rqA338ooCKLtELv0MoMyT7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jHejUbx5Ovbg4p8oogFnHCki7XL5gTAqXfCeasFBH4=;
 b=BeB+wngGTHB3tTovpxiMv/xDeMQLom+dvCBNh0JLsQcyjV+0gDVzBRf/PLuHuR5VxbmXwfNGWNUGzOVm/bCNiEShSdad6uiNtbGot0M5sq8J7HzpVQd62LQ1YFwHqkk0g2FtxkuU7A+w4qcJ6opswwPozKHVF278CwR7pbHl1ZU=
Received: from MW4P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::25)
 by CY5PR12MB6035.namprd12.prod.outlook.com (2603:10b6:930:2d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 07:36:34 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::b6) by MW4P223CA0020.outlook.office365.com
 (2603:10b6:303:80::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Thu, 21 Dec 2023 07:36:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.18 via Frontend Transport; Thu, 21 Dec 2023 07:36:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 01:36:32 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 01:36:32 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Thu, 21 Dec 2023 01:36:29 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>
CC: <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <pierre-louis.bossart@linux.intel.com>,
	<vinod.koul@intel.com>, <venkataprasad.potturu@amd.com>, Vijendar Mukunda
	<Vijendar.Mukunda@amd.com>, Bard Liao <yung-chuan.liao@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 03/12] drivers: soundwire: implement function to extract slave information
Date: Thu, 21 Dec 2023 13:05:49 +0530
Message-ID: <20231221073558.3181911-4-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221073558.3181911-1-Vijendar.Mukunda@amd.com>
References: <20231221073558.3181911-1-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|CY5PR12MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: 46573ef6-dbf8-4b8e-74c9-08dc01f78e74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y1OdD4PVzGqEBNPBtlt7v5kdWjTXmSwMqXs1uN+3cyj8P8qyNKLzAIuZA2DsA4A171KCmgwaW0GOkUtWhooan8TVPGBZU7e2gS3j5UEQDk55EQOg51KhA7vCWg9ddjjvzrMxPFuOwQsOrThm9ljK5gd+P641Z46DlCxDYQD2e0tGnSfyXzZzPXrXnmbugCGfVsVoAm6BmCVVY/TDpOZ62wzFWGMjIkh49lf+PhE2iOVS7TF1WFXBo5SyWghyObNHpN+P98EIi7GEWdnIO5F8Wa5S6lvAg5C6TypYqcGUFrzvhcPpElMEf+7oZuKZgbNDv0zQlTCQDJvc++c9P0LijnqTE/zuqUEPscyEEcOkGfFMprI8vDz5Sp6b4khk0dhOo2LYWoi34BmbhftJLa0iMwkvhNNtSNF03uHhByUC0dDaxzRrp9a+4b1+Ja1VCvgiFlCpam39MLIrPZM5Enbtj7/arSVK8dJhu3chcbVn0izgLNDbGmRZnRh++jDf9S3WmBlbnGpCLBqOmTwEO1uni1xG5yycW2wX9YqAVg9T1j18NkwtUoFwItCZoPLiiG7ZVhSWYafqVCp1CTkAjryIhUhSfD/9+bDBlY/vQT8OnDzCTbKhQsjQMEUjWiHI0w7hYwDb5+1mBe/SjoUbiTFfAaMCBr9MUpK5RhtjkGpfm72UojNfFga9jV6P22kd1qNuXor3zhvDatqIimc2V6P5O85dzDlygXIWBZasrHgb0Ls2NFHJKY842vEWQOveE5id5zRii5Dd8ylwLornFCrZ/g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(110136005)(70206006)(70586007)(40480700001)(54906003)(316002)(8936002)(8676002)(4326008)(40460700003)(81166007)(336012)(426003)(47076005)(26005)(1076003)(82740400003)(2616005)(41300700001)(5660300002)(36756003)(86362001)(356005)(7696005)(6666004)(2906002)(36860700001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 07:36:33.6595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46573ef6-dbf8-4b8e-74c9-08dc01f78e74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6035

Implement function to extract slaves information connected on the bus.
This information is required during machine select logic.
This function will be called from machine select logic code.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_init.c      | 43 +++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw_amd.h |  2 ++
 2 files changed, 45 insertions(+)

diff --git a/drivers/soundwire/amd_init.c b/drivers/soundwire/amd_init.c
index d732ab0bfd59..5c9569d9ad01 100644
--- a/drivers/soundwire/amd_init.c
+++ b/drivers/soundwire/amd_init.c
@@ -142,6 +142,49 @@ void sdw_amd_exit(struct sdw_amd_ctx *ctx)
 }
 EXPORT_SYMBOL_NS(sdw_amd_exit, SOUNDWIRE_AMD_INIT);
 
+int sdw_amd_get_slave_info(struct sdw_amd_ctx *ctx)
+{
+	struct amd_sdw_manager *amd_manager;
+	struct sdw_bus *bus;
+	struct sdw_slave *slave;
+	struct list_head *node;
+	int index;
+	int i = 0;
+	int num_slaves = 0;
+
+	for (index = 0; index < ctx->count; index++) {
+		if (!(ctx->link_mask & BIT(index)))
+			continue;
+		amd_manager = dev_get_drvdata(&ctx->pdev[index]->dev);
+		if (!amd_manager)
+			return -ENODEV;
+		bus = &amd_manager->bus;
+		/* Calculate number of slaves */
+		list_for_each(node, &bus->slaves)
+			num_slaves++;
+	}
+
+	ctx->ids = kcalloc(num_slaves, sizeof(*ctx->ids), GFP_KERNEL);
+	if (!ctx->ids)
+		return -ENOMEM;
+	ctx->num_slaves = num_slaves;
+	for (index = 0; index < ctx->count; index++) {
+		if (!(ctx->link_mask & BIT(index)))
+			continue;
+		amd_manager = dev_get_drvdata(&ctx->pdev[index]->dev);
+		if (amd_manager) {
+			bus = &amd_manager->bus;
+			list_for_each_entry(slave, &bus->slaves, node) {
+				ctx->ids[i].id = slave->id;
+				ctx->ids[i].link_id = bus->link_id;
+				i++;
+			}
+		}
+	}
+	return 0;
+}
+EXPORT_SYMBOL_NS(sdw_amd_get_slave_info, SOUNDWIRE_AMD_INIT);
+
 MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
 MODULE_DESCRIPTION("AMD SoundWire Init Library");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
index 064174c2f401..47b6cea356ff 100644
--- a/include/linux/soundwire/sdw_amd.h
+++ b/include/linux/soundwire/sdw_amd.h
@@ -170,5 +170,7 @@ int sdw_amd_probe(struct sdw_amd_res *res, struct sdw_amd_ctx **ctx);
 
 void sdw_amd_exit(struct sdw_amd_ctx *ctx);
 
+int sdw_amd_get_slave_info(struct sdw_amd_ctx *ctx);
+
 int amd_sdw_scan_controller(struct sdw_amd_acpi_info *info);
 #endif
-- 
2.34.1


