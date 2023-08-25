Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07F1789263
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjHYXdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjHYXcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:32:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D1E210D;
        Fri, 25 Aug 2023 16:32:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RulkMzR+aOWcngkFbnUWD6g3Runstjdq+Edi4U11k2FrNa7Aeo+NWSO33xLKU2jq9xE8jB2FIjH9nRNnjhFqB0V5QbDswHLk7SSsEef5MUrel43OVD3D0sF1MXzltvtqQd9AOTqdmy7IRK/NKMITwRWAS7nxXrw9r8b525nnMm7FHgRaPivBVvu8kFTMIUyNj+2Ir8MaiRikmdPw28I8oBGwvK2GIij9WHXdEFJbNqZd/f+At4Dfzv1T/QsaiTrEiQCIsicNlsYPQoz8cWjRWp10CdaiQQ1X/mgy/Q/ekbqHfTg9uWpv6HZFp+oFnAKeQkYzGJiWnWq4WJuIV5NsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56RYeX9FEUbjjvfF0XQyGJKCuOAJ9jsg5sVDPyKjJzg=;
 b=XQdvz1ecqe6VHBkve5+RIexJ2wUzk2CNXjJgBrE0MIEpYLJyhlJ7VavsDyy9bMUl4gyh2ZohKRvo30PSehsAF20YD2HpXbSRGnP/a+zeZM/XlnCBeIphFw5n9BboPlzd4rLIFoCZzfc/bbncelXcqAqAOsRBIyKubN40j0rOm2milz6CcVZStXnJ2dinsTUrqxzTlUBQvdkauGIyiDSYOkLGs1MQXmTE5/lCyy5OFhX92PRh8BV/KSogveeFJBvM4/UtZEcFusXcxvEJOD7UhqMTPcNLxp9/Fjxs9hcKpoE6Cc9PfFSzDOQDjwXCX+9CCRcqSuS4fLYF64voD1P+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56RYeX9FEUbjjvfF0XQyGJKCuOAJ9jsg5sVDPyKjJzg=;
 b=0ELkmF/KVv/oHJMibx8apZhUlB5u5MKtoVJydUMomLk856sFl5Olf9IL9CdS/wviCIkaUE5oUKCOsd9k6oK1bUcu+zWUczGJF43Iqd/uSAZkuT/q33CKBlXi3LR4P4LY06fzFXOWzatqk4eCGdxw4YWWDukuiigaYnmMtZqF0RQ=
Received: from CY5PR15CA0016.namprd15.prod.outlook.com (2603:10b6:930:14::11)
 by MN0PR12MB6296.namprd12.prod.outlook.com (2603:10b6:208:3d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 23:32:43 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:14:cafe::97) by CY5PR15CA0016.outlook.office365.com
 (2603:10b6:930:14::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Fri, 25 Aug 2023 23:32:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 25 Aug 2023 23:32:42 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 18:32:41 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v9 01/15] cxl/port: Pre-initialize component register mappings
Date:   Fri, 25 Aug 2023 18:31:57 -0500
Message-ID: <20230825233211.3029825-2-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825233211.3029825-1-terry.bowman@amd.com>
References: <20230825233211.3029825-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|MN0PR12MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: f115d1ae-a1ca-4dd5-9b94-08dba5c3945b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yEITG7zDfJitDyIREunCG8Co5FynZ67U/C2tNhdWC0eGwvZc9ANgzrNmLISxQ8fi0HCjrfk5MCynOuc59ypG+Tpz98y4TY+IB2O0Mz6v1YguwX0nYpe8Dk0wzFZXFeswhYoLzZVfmD0f5F6BfftWIFHff1JEmFtyoeAmH4Kk3X8/Niql9/lF8nNRPLzJuPfZJMxhPpVc8JhbY+xpHNHWByxD8SPSxSvVruEwadhfONH99z+eVr7cyWuaLG9ffbGPlkHY/3u9VnD+vDQ7d3uA2fd5epVxMt1YuhE0EisoMBBh4+4GWwSuDs0cn00wNZa/0LI1325QsKSsR4YbqlDH0PsDWwJX8oYpjqd3kvChHLVNqbUOg9WvjJ1bc+lgoWWrLvRAjHnh8M3CwzNK11xRi2HuEzu2I0qxQFTUGRcEV4p3Da3/g2w2fcFJkwvlX0svZzJ+MSmiacSclF2MdSojg2GOtYK7Q8/fv1gYBLAdN/HpNzxInz/2E9TWqy0VLEmI/owQtPYlGGAR30tfgNKknM1MzrACOXH/EctpR8H8Sj99MM7Pc4q3H33U03zWTJKkp+EGK5DWenEPOnrAA6BRCGDj58xRxkcrOaB8ZCUSBmXRsLx2I2HqaYGJpicqK9t6pQld5RNhyk9DyrS1hyftNzRAtKe9P+rBPxxXWR2R094twmqXE5hAVE6v0Bvhja2dccfgGi0b47iBiwekMvkBU7YM5rzk2lUsyPhMflEZhyAGvZvPGyxQvOVsR3byXnUsI7Nxnf0LzTMbOqpGDFMb4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199024)(1800799009)(186009)(82310400011)(46966006)(36840700001)(40470700004)(54906003)(7696005)(70586007)(316002)(70206006)(81166007)(478600001)(110136005)(26005)(36860700001)(44832011)(356005)(6666004)(16526019)(40480700001)(82740400003)(41300700001)(86362001)(2906002)(8676002)(8936002)(4326008)(1076003)(40460700003)(2616005)(5660300002)(7416002)(83380400001)(36756003)(336012)(426003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 23:32:42.8044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f115d1ae-a1ca-4dd5-9b94-08dba5c3945b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6296
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Richter <rrichter@amd.com>

The component registers of a component may not exist or are not
needed. The setup may fail for that reason. In some cases the
initialization should continue anyway. Thus, always initialize struct
cxl_register_map with valid values. In case of errors, zero it, set a
value for @dev and make @resource a the valid value using
CXL_RESOURCE_NONE.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/port.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 724be8448eb4..2d22e7a5629b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -693,16 +693,17 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 static int cxl_setup_comp_regs(struct device *dev, struct cxl_register_map *map,
 			       resource_size_t component_reg_phys)
 {
-	if (component_reg_phys == CXL_RESOURCE_NONE)
-		return 0;
-
 	*map = (struct cxl_register_map) {
 		.dev = dev,
-		.reg_type = CXL_REGLOC_RBI_COMPONENT,
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
2.34.1

