Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3AB7B0944
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjI0PtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjI0Psm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:48:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617B527E5B;
        Wed, 27 Sep 2023 08:48:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=delTbURlZ9xqDHvmxQj8qzFYyvcJXE8Nx4hl7+ZC0U9A6y5LmVowfyd2dnnysLYnQ2xMs40EED8B+b2Hmo1ObbGsrOxBXHRT48I58VgBa2d/pBqA09sL8Gbu57rCS/fETC/eBQKUtqwzszvq1Nkwrn0G/3Bho5hEBfSeFwG8KxR8gHv762T6y6DRVwYqNgZR5StA1ulRLM4MJ2jPigztAcCxS8f0aLGzfwCHSL432BgH3oleLTAICFwxyViSMeTfqD5ge4mQEPWq8mMcgOt3yRRY7SlbuKnvUjPWlOPe13d9kvRhDi459pn9htG+WM+odVHOokWuSD46THpyjH0W4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oO7WNPE9oyPXsuzcT4aIbJpCnOpTTJbT+4kzFv6wLZI=;
 b=hNCWe5Ozy0GIYPqMvxt6itesH4PJezWaDff7CQQFmHDCVNBbvrlU7CtXpDlgq1ZFoDrCiPuMfVZyd57P0qiHEWxVM7hc7WhrNlfU1ObLGNvgN0VGBdv7aB9pq0CrPgOHWTYi3riqs6DKMxJTIOnaP2hqQ4W7Q4H7HYwq0f9r8Y5huX5hIosLn2Q6ot2eNA4Xz/kVAguUurBwr9IdgIbrSSK/V+0tZPS4aG3368N58PdXgZB7Tka6BRu3gN2UPY03ZxjZ5/CA97nokuJUUNwTXZ8HGfo8nCEI4PfwCllcSVXJkgWvkEZlqG/nNlXhjJK7zVdIjxVogM0KRJ9dySzt1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oO7WNPE9oyPXsuzcT4aIbJpCnOpTTJbT+4kzFv6wLZI=;
 b=YqEfeDAEa56l8VCNDBwp9JIjmz6fa7/t5NFYv+Bll2u0q8330f4jDHuEJ6r0yok4bQLZjMqoKMqtAIePE5R0cA0czaHHmyi+vgGM+GRrGnYA1nGNdJMtWvnBFAG3fmiAOHbvPJCjkcslr9cx6a544piRBNiKVKCVsRcKaJ4KR1M=
Received: from BLAP220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::12)
 by PH0PR12MB8173.namprd12.prod.outlook.com (2603:10b6:510:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 15:48:04 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::b7) by BLAP220CA0007.outlook.office365.com
 (2603:10b6:208:32c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 15:48:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 15:48:04 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 10:48:01 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>
Subject: [PATCH v11 20/20] cxl/core/regs: Rework cxl_map_pmu_regs() to use map->dev for devm
Date:   Wed, 27 Sep 2023 17:43:39 +0200
Message-ID: <20230927154339.1600738-21-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230927154339.1600738-1-rrichter@amd.com>
References: <20230927154339.1600738-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|PH0PR12MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: a2628563-68d5-48f5-9569-08dbbf71231a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fDysIEfNUQ03FrTcp1qWYXQNS9obDNLm8tEwQ1tq70U5TbI6XMPs1Jzt56ZYrPrzCzF6h/g6a4dEqPkgCHl7WdRjrIcsqyTbG5ox9TNELmdyozylpYtrg2Txlj1I9bvoBFUupFFyu+AM2nRWTq45np/VPs85PnUUh6HAGj3jtP8aHX/XaMWZCTveUNPlVrDdVjpO5rxut5q03Xzq7Um3zueU6HzfbEMcyHITclm8/SbFZ5+o5P+Stm7yq+vnfYYUGhFPMEwlPFPYoDH/BpI3xJiAb1zScdSE9cDKRyBgzLen4CJ6UiZi5AOaIN2g4NPzA8970/h57b9TiNRNrg9NnO02V8J7ZaZE5IgAAYdwH5eUNleKdtqWft19uvIzL+YzLopcfS+NJdProKMK00jrx24ou5901MdsDX92WjMP9wrhN07DU6jbfqOtPMKlw0AGpEaB89CMvS7p8Vl/6lri0eYDYfRCqtZXYWD4btFCXlWQtaM61rCQOVTEaMfww/QgJlTZUhkxjJ0PAMmTbncX3DasCl7dX2BU7mrAwM/8gcJPahwxAgcOz+R1DOku2oXjwzF1QRw/yqvUREm5+yDQRF6vJ26AqUHMWKst5MlONDjiasx03bjtpivnWaktji3dL/+6hr64md8g/JaUEgMBbBSC0FoiIOXx1BwnaVudi7zbIYN16Dg3nLY0/YrJqfC5tXTzMbNvgfgTw+rekQgO3y1l0jIqCAYXCS/cGBm4BQWg4i8iRo+05OvPfEQvSzdrbZMheQobKKI7yFUCyaHo0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(451199024)(82310400011)(186009)(1800799009)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(6666004)(478600001)(336012)(36860700001)(356005)(47076005)(81166007)(82740400003)(2906002)(2616005)(7416002)(41300700001)(83380400001)(426003)(16526019)(26005)(1076003)(36756003)(5660300002)(8936002)(110136005)(70586007)(316002)(54906003)(70206006)(4326008)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:48:04.3899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2628563-68d5-48f5-9569-08dbbf71231a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct cxl_register_map carries a @dev parameter for devm operations.
Simplify the function interface to use that instead of a separate @dev
argument.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/regs.c | 5 ++---
 drivers/cxl/cxl.h       | 3 +--
 drivers/cxl/pci.c       | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 7b56f6f28ab1..b668be617fd7 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -386,10 +386,9 @@ int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_count_regblock, CXL);
 
-int cxl_map_pmu_regs(struct pci_dev *pdev, struct cxl_pmu_regs *regs,
-		     struct cxl_register_map *map)
+int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs)
 {
-	struct device *dev = &pdev->dev;
+	struct device *dev = map->host;
 	resource_size_t phys_addr;
 
 	phys_addr = map->resource;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 7c2c195592d6..ed90ca8ed79e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -286,8 +286,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 			   unsigned long map_mask);
 int cxl_map_device_regs(const struct cxl_register_map *map,
 			struct cxl_device_regs *regs);
-int cxl_map_pmu_regs(struct pci_dev *pdev, struct cxl_pmu_regs *regs,
-		     struct cxl_register_map *map);
+int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs);
 
 enum cxl_regloc_type;
 int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 037792e941f2..fa94bc61af25 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -898,7 +898,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			break;
 		}
 
-		rc = cxl_map_pmu_regs(pdev, &pmu_regs, &map);
+		rc = cxl_map_pmu_regs(&map, &pmu_regs);
 		if (rc) {
 			dev_dbg(&pdev->dev, "Could not map PMU regs\n");
 			break;
-- 
2.30.2

