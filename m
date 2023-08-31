Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5965678F1A8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346872AbjHaREc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346860AbjHaRE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:04:29 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F20ACD6;
        Thu, 31 Aug 2023 10:04:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNhCh9B8Idkd9UiB8MdwSMKBDPN+R9UpyCkJVf10l4w0VRgTCDw1t84DWbuhovj2sHAtM9G2LhnGaqgd0Gp8KtYP6DPIQsV2wITubdVw9t2AJmHMtoGDHpftv4aLu5Tz4AEzD9/ulKEHcYIxC1kwYjHrb2ICEv4Kvcmj89G5SwtxlIiwiBMxUrYpPCRsdw1RRXtzBMj62ElPg5cRlgDLcOLgYKBDRerNvWfJEKtuCM3lX/zA2Bg2x+GWrMHyq+IfuGvQUpVMUw98bIhGe3f7QaBS/X7F26sOeLSYTZ0OdRumAsZ7knmtyizOwyEEeNcvkjBMBZAwyldXbTUIVb6d4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrvKsLLmcCbywLhMPwXf6Me1xobXx/KBZ7GQIIfi65U=;
 b=Gi6GsntDoJLuFC8QxnnzWDa1aIbbZ06gQTRa9qie16ze+rDAMtOQOGM+NJwq5gr3qvZDWC4L4owjRbdJKCoW8a0wH3RwStxg4Mv9NZSaER3KvHKCMG2Ujr5LD0NVzy/oQUhLYud6boUAXPPZwnGDG798t9aolQEnIOCf0Mh/u9Mlf2rpzl0bY4yGLc4w5fwvMO9XRtO7XLH5KGu4aqH3fRXjyV/wdDjM0GE3if1Re/sh9DiV2SR8mUf5Qidu31Xq5gei5xsqf0BhkrNswbo9F90qbQZyFRpCCsshqT1LXBA+mdWIb2N2UVm2xCUdV0GpLj6FSFvjl1n/jQHoYRFbJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrvKsLLmcCbywLhMPwXf6Me1xobXx/KBZ7GQIIfi65U=;
 b=QBtCrikXaBu7BdW8tYPdi5YwanxXdgFcFlON+245kO+hnG7WVGV9EnsAnhS3iTxaM9kPmOimY7Rbx+L7yV27ccYNuq3VT1AF0E64GPiXsRJYqcaPobSV2WdkkbbBsnVPlDH1xwRKCKcR50ReAgDamQdP2HT4MfzcnVrjOKOBXnQ=
Received: from PH8PR21CA0018.namprd21.prod.outlook.com (2603:10b6:510:2ce::8)
 by IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Thu, 31 Aug
 2023 17:04:15 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::e6) by PH8PR21CA0018.outlook.office365.com
 (2603:10b6:510:2ce::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.15 via Frontend
 Transport; Thu, 31 Aug 2023 17:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 17:04:14 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 12:04:13 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v10 15/15] cxl/core/regs: Rename phys_addr in cxl_map_component_regs()
Date:   Thu, 31 Aug 2023 12:02:48 -0500
Message-ID: <20230831170248.185078-8-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831170248.185078-1-terry.bowman@amd.com>
References: <20230831170248.185078-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|IA0PR12MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab71038-3508-4718-b7d6-08dbaa444e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yV8LAE3KWPMftisvgCakyMiGMQvgLdtDX9G1M3C+ZeaUoQhlB4wAbag8yOBdf371+F7Rr+j/yCSkpYL1ykN+KdhydwcFHdJOuKZXfuzBOIOHQWqpVoGPrG6aMy9ObwAuOTl9u4Jf57gt0M861xSXfHU3jTPl2KUlcDKl1zvttf3oX8NJfKBZKLbDYhT60Fpthji2UcFAoMInpLMmWQwjOt8JvISRel9bhQSSjZ/icvTklMWPddFMwKm5dVQ08IRDJuN+qO35NOCx6AXIMPxylE0E6cwSyoziunh6/HbWbBaPLEW/64jhRGSVh3kCHjaACq8IRe4jw6q1syc9Z3pFT1wWovkk8dk71Jfl44XdCJZAIFIvhTEM3Xo5a5p84B1X/cJrHqmPzyBJ0yvkjNUUJtvojfTY1kbu3RLSA0XZiDAj+P8VGthnPR0jCKqd5XnHs38GVBU4G+RSBqayAVlQMXQ/jTcX0TIgyCS9SiA4Tw250B9D+JvKRkeZYJhh3DjCETfPBvJ52/22pVhsPULuNa62igXErud5058UL/rEJMyLFHf/28KyOvtNWjWYI6PzcWr8vbHrtkmWDCSKxSJkhWv104wVpu1bGGo1LKG+vfs+u/p/vOzAT9ANBI4StHNjz92L6c2aSOX8GCCihmWBJyEzTAr008Pdk5UB8NbD2l0lvMkzVc77yfPC/8J15KleQT0Lldel1d7migSwscWLnz4t9C3e9SYhpMScAi5bWXpv+QpPuxK/2/CyHFTIJwH+RHCVtXMD5FXdaf9s8ECn1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(8936002)(6666004)(82740400003)(7696005)(47076005)(36756003)(40480700001)(86362001)(81166007)(356005)(36860700001)(40460700003)(2616005)(26005)(70206006)(336012)(426003)(5660300002)(16526019)(478600001)(1076003)(70586007)(110136005)(2906002)(41300700001)(4326008)(83380400001)(44832011)(7416002)(54906003)(316002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 17:04:14.8942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab71038-3508-4718-b7d6-08dbaa444e33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507
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

Trivial change that renames variable phys_addr in
cxl_map_component_regs() to shorten its length to keep the 80 char
size limit for the line and also for consistency between the different
paths.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/regs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 5cb78b76c757..f8f26fe80489 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -217,16 +217,16 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 
 	for (i = 0; i < ARRAY_SIZE(mapinfo); i++) {
 		struct mapinfo *mi = &mapinfo[i];
-		resource_size_t phys_addr;
+		resource_size_t addr;
 		resource_size_t length;
 
 		if (!mi->rmap->valid)
 			continue;
 		if (!test_bit(mi->rmap->id, &map_mask))
 			continue;
-		phys_addr = map->resource + mi->rmap->offset;
+		addr = map->resource + mi->rmap->offset;
 		length = mi->rmap->size;
-		*(mi->addr) = devm_cxl_iomap_block(dev, phys_addr, length);
+		*(mi->addr) = devm_cxl_iomap_block(dev, addr, length);
 		if (!*(mi->addr))
 			return -ENOMEM;
 	}
-- 
2.34.1

