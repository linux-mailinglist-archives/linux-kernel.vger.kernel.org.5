Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DE27B0929
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjI0PrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjI0PqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:46:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101C4272BF;
        Wed, 27 Sep 2023 08:46:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByulpbE6zfkMSreQnD3+Mv7o2MFcIhr3SvtM7LQSA2gwHm6K92ImzAMyaE25R6F1vIU14npUfzzW7UQq+E+7bQ2SjuoF1FmESL6uRiAiOEYxggSozqFmWy0/rkcCw+Q9cR8V/bkZDgU2qR2p2f3KQgcc9D+Es8QSTXNsq5prDA8qwz/kIAT/EzQT1wazVsCjQeJT7L1QHCrKCCutgrTGa+HBVdYY5wvuvY9M77Ez158hvgf6QUctVGZbhdQn7QOz5U/eg5xc/pQkKIDiw18KQ0TzSLFSDDqti7kqtw9DgQSpEzTGbjXE5g2jegS8QzKY1Fy1v5s/8dJNOv+CdOfaWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZFzthQVdwIAg5t3M6GAN24TFpEVTAgqZ/bQ8wGg+y0=;
 b=GtXNCsF4FbuQrLd13YpnkNb6r75mCkdmVvjq/+mxEMFN/QLQcW2d1apG1N9Yo8/psdYScOu9v/MTpCHbMs35AJrLUibiR5RVbGoXoWBByRgwMV8tRk9g3qDTl96yugAxwLR735aRPqxJ5IWkh0s1DECeb/CBIRFeNjFHrv+X/4czGDdEtY+MqGxDXRVkSlt9RzQEL8ngVuLZLUBSI/S1Nf6KWJW2BIauXsoCaR9Rv22s1vJpPIWUv7lifNcG9nIDDbbhYGIqWBweR1Ys4uBkAmlAZsr5JxvvB9gaBgkGy/3fJHPb0lKjuxiuLyKx3bl8kV/Mv7XYQe0iOYOvJcXO1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZFzthQVdwIAg5t3M6GAN24TFpEVTAgqZ/bQ8wGg+y0=;
 b=WlNV0H0E18uH82FK08tPCjeRGogy8zM6NT79iWZOkTGetAV5bnsC1EwFdJ2/PahPgCWuUC9GbriDriT9nS/BIG7znsFHt+B+o8hkmmllxStg3d1ktg/o9HDAMKSm/0fCnTRWqeLQKyxYRUmcX1fRb+ZSODABFNlzbCY6M2+CmIk=
Received: from BLAPR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:36e::23)
 by PH7PR12MB8039.namprd12.prod.outlook.com (2603:10b6:510:26a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.31; Wed, 27 Sep
 2023 15:46:17 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:36e:cafe::87) by BLAPR05CA0020.outlook.office365.com
 (2603:10b6:208:36e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 15:46:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 15:46:16 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 10:46:13 -0500
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
        Robert Richter <rrichter@amd.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v11 05/20] cxl/port: Pre-initialize component register mappings
Date:   Wed, 27 Sep 2023 17:43:24 +0200
Message-ID: <20230927154339.1600738-6-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|PH7PR12MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: fd4b178c-abde-406a-b193-08dbbf70e2d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D+gLtbyOLCXcppJO2Ri6B1p7VyGNu27pr1qe1Aib8sCh0X4lFc2bpnPgSM9rMhdO8JRFXtLclxRz76ciECOJ2LV93Z+8LcYStZVBraqiIScwx3CRZlIunM9hpR5Y8GsOEAnLmel9ojb7DsLJ8dD3bvbBmX7e7Z3wBhvg1ReYQAeLGxasGpK3PIm2C6clWZdstOZ/EZha94FMXW1ETKwnPf4rx0+4Ya00mQqvc9/5nvRwCAcSupSnUdlfWIsCtMrA4rCg5Oa/KQNjCtBzfBLjKp47ZjJN1vBa5l6+nZxcTBhfMZ7ceD50HBGoHPZVpXDItdFOX/zNzaKBwJbFH0inNHSsNKL36+VGUj4aw59LV99/rWpGp1rRiU1YWIx1/taeGgorI36ojXjeLS2GzlZa/Q2jURt0EOPeUPeHxpJX2QP5/yb4pc22kYBhM8zxRGTt6F36iqldpHETX4NQ8HB/ykT9IT5vbnNpNDkDL05TDyR7D2/aXTcJ6c+JgvV0q3ukDfcfVkfScKiq0iBGWL7cRjZcUO9jytfQUm6yZUwkgBKsAErLlNr+sV3D4RcjPtGEOHBjTpQqluhMjIrIZZf/92LlW2wqPc0k7+YSfZe8WPmGcocr40AigVCzxrQVQlMCj3IcDM4/2Tw4nHuhb+2cnRbKK1Mt3g5wvf0mzgf0aByHQ7v+dy9qmPFcUYsw/WlZozISIK/znOC1lXCyjhgV9xSx7qXjRJd8qAsqA/oPxJt8WpHhvx7okQQxuSfQ4tAhpYdL/CjqCIb9OsgqbKSXVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(186009)(82310400011)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(7416002)(2906002)(8936002)(4326008)(5660300002)(8676002)(41300700001)(47076005)(36860700001)(478600001)(83380400001)(336012)(426003)(6666004)(54906003)(36756003)(16526019)(40460700003)(26005)(316002)(70206006)(70586007)(110136005)(82740400003)(2616005)(356005)(1076003)(40480700001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:46:16.5486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4b178c-abde-406a-b193-08dbbf70e2d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8039
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The component registers of a component may not exist and
cxl_setup_comp_regs() will fail for that reason. In another case,
Software may not use and set those registers up. cxl_setup_comp_regs()
is then called with a base address of CXL_RESOURCE_NONE. Both are
valid cases, but the function returns without initializing the
register map.

Now, a missing component register block is not necessarily a reason to
fail (feature is optional or its existence checked later). Change
cxl_setup_comp_regs() to also use components with the component
register block missing. Thus, always initialize struct
cxl_register_map with valid values, set @dev and make @resource
CXL_RESOURCE_NONE.

The change is in preparation of follow-on patches.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/port.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b993dea61436..28ba8922d0a4 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -694,16 +694,18 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map,
 			       resource_size_t component_reg_phys)
 {
-	if (component_reg_phys == CXL_RESOURCE_NONE)
-		return 0;
-
 	*map = (struct cxl_register_map) {
 		.host = host,
-		.reg_type = CXL_REGLOC_RBI_COMPONENT,
+		.reg_type = CXL_REGLOC_RBI_EMPTY,
 		.resource = component_reg_phys,
-		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
 	};
 
+	if (component_reg_phys == CXL_RESOURCE_NONE)
+		return 0;
+
+	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
+	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
+
 	return cxl_setup_regs(map);
 }
 
-- 
2.30.2

