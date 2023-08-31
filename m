Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9975478F021
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346520AbjHaPVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjHaPVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:21:14 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E8FE5A;
        Thu, 31 Aug 2023 08:21:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rt2gjxQiAXkR+hO6D6XTzgy/jVGq/HFDi3SnN+oixWH8FGBu38OStd89ME0lyajHzUB+mzCeJKFP55fLU9A+6IhF9LMyfRIxySCwgkuGYlDOYYpwWo9vVHwp9YWG3XJ8ksIVVAk0G/Zzb1dGlwHnbigJ4ZHTyKgVglGXkLwKdmWR2ar6wh297hXWEvsFrY0WBnWw1X7hB/R9uEK94O+THNLlYkZn4vaSIsArEjqgPzL6GVOnk7imf22WfrXYzWRfN2tR6ZfvedX7BZdG/siKgeQcDC7rJXT8wN2Vw22xiTT80P1qEvTBJmrEMJZxRSgVHYOmuD2ZV0/VdMVmrM/mSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTWRHP2iB0XC+TH6ARURdFg69DtSOwvDtm+z57QfZdE=;
 b=Ipsqzp1d/T9hSpn90h/HTKR2WEyEfWSipNI6nD0OeJCNIhcQHvDOGG6Qkj0lj2rRnzFgMD6b4OzWrSnrhYF2Aand31KOi5prSeq5tiAPTOnsCsRe02RFOivmuZbfr36UbWmvjzYT/iwVsJMlcY3pFr4adk+IGzg/bBVlcgJNPFwZG3vpFLiJDXTqQgCIGU7jjX1MNqliVuNaRCVgrm3z6uoolXgoS3Cg631V876+Luev2NcY9vJ8XpWPw1V/of/TuJOGW0VfwTK6avuAe6svT4TMmGfxRHTFKUEgh52BmO0XkxOxj/eklaNE4xT/rVxNSo/pzRF7FHexgDwO7F/Drg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTWRHP2iB0XC+TH6ARURdFg69DtSOwvDtm+z57QfZdE=;
 b=rUGGdCpTUV0FmBVjP67UcmtBmdP0P4oRmW6HSeR2QLaHGxRlwd8Bc9lHkRGZoMlFDmF8x32+dW7kqOXBXj7RJVLrEJT3lxsqxCPyaS65xfaoUvV/C9kn3iVfaYQqnt+aXROw/X9+bTpibMhap6NaJWt6nQHcw+FiIpodFCovI2k=
Received: from MW3PR05CA0028.namprd05.prod.outlook.com (2603:10b6:303:2b::33)
 by CYYPR12MB8937.namprd12.prod.outlook.com (2603:10b6:930:cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Thu, 31 Aug
 2023 15:21:08 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:2b:cafe::8c) by MW3PR05CA0028.outlook.office365.com
 (2603:10b6:303:2b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.12 via Frontend
 Transport; Thu, 31 Aug 2023 15:21:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 15:21:08 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 10:21:07 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v10 01/15] cxl/port: Pre-initialize component register mappings
Date:   Thu, 31 Aug 2023 10:20:17 -0500
Message-ID: <20230831152031.184295-2-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831152031.184295-1-terry.bowman@amd.com>
References: <20230831152031.184295-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|CYYPR12MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: a31628c0-079a-4086-f204-08dbaa35e6d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GiI9kYnQJfkKwGY6DwJuilh7RNnIfbVa3QAK5pkbVK0Wv04OotqxsTpJgVbBEw9BwBkRdSFdr2RS73ryV4D0OSZ/B4mjGpiux3jeC/FLu6tLRRYoEYWd2x0ILwT0vhdVvGDWnV6Fc+FWDQ46FSXWxzzTOnM4U69uASXaSDZldZgo6kcZf+nWcgNhJdIAVm7b9hRAhDn+JR6Inv37by5uVVx9KWHs85RVVdglUez7YoSwPcY3gHWnlLOl5/fxotGR7VRuvGpc6VkMPY/Ypf6BBzDdDCc1v1gP/eXQf1BMb3h0teTA7rwsPJCZ+G8WB1E3h0HqnUEDoOtpaS4Km039T03odmTrxgGKo+CwlredcmJuSVskkYCJ7szruIKJIxR/FM2pts9dzVUq/mILqR6oG73unKSXlZQI3HDO7fnNcg0QSeTi/EMkde5rZovdWW1GP3aWLGiBPMe2+uAZlWgvO5PNQ/B9hnp7CKKKw7olw9xMNXVrd1Ugz439h7bBtVaiLKy2LmrVeWYrf5/UM7oPJ6iiYhFCGkchlX3Mg2ryQIqnXVTrX/Imrm78TmCfgdKJbuGNWe2RNLZsG8RXevkr1t2lW+Tr+nxNgyv1V1PTbivDjqqayhy3JCufN6maLxSgkn7Ci6lyL33q5+xVl7FabiQM9hrL+b88wBXzi5ibWy/Yjy6uJbpcrBVo+7hD+GMGRl40//PLG8XikF4YrhAyssG6tPaQ9V0vvV2r3DmkQ2jBloO98tTQBXE8ihqnBmJrFG/AkNoj2XJEs8oBrAVXig==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199024)(1800799009)(82310400011)(186009)(46966006)(36840700001)(40470700004)(6666004)(2906002)(5660300002)(86362001)(316002)(478600001)(7416002)(2616005)(4326008)(47076005)(8676002)(7696005)(36860700001)(44832011)(8936002)(40460700003)(26005)(1076003)(82740400003)(40480700001)(41300700001)(336012)(426003)(36756003)(356005)(83380400001)(81166007)(54906003)(70206006)(70586007)(110136005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 15:21:08.4354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a31628c0-079a-4086-f204-08dbaa35e6d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8937
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

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/port.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 724be8448eb4..6c06c36f8c7b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -693,16 +693,18 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 static int cxl_setup_comp_regs(struct device *dev, struct cxl_register_map *map,
 			       resource_size_t component_reg_phys)
 {
-	if (component_reg_phys == CXL_RESOURCE_NONE)
-		return 0;
-
 	*map = (struct cxl_register_map) {
 		.dev = dev,
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
2.34.1

