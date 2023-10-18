Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78517CE492
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjJRRac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjJRR3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:29:53 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C91F1707;
        Wed, 18 Oct 2023 10:19:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYKaffwjcw1jDK/V7/5Nh/XRUhjrc+lVqGWV9FE1WNb/VR05AN20gChbSn34/WzWlB531s+lVv+nZ0YWZ4+zeS+HpI/ONhgX77ozBP7CdkDOHeazekJmZ/wRmGHC95WLWIplPDLjxZ/BUDGvMZfux1+qN+MavJAAEFHPgMvBtniBil8TGsB93RQwiWLYHbloyp9P3KyE6OIHAFs+UiN9OYbp9bxEOxWbqQXrPr+gzTrRYtfm3hvmS9QINxg+9C8dU44NE+ji9JqPohGIv6kUb26/X4tDt9+y6uQYihP30sOXMcE2Q3kYmRKkR68MFwn4+V7h6VvQOBnEi3DiklLjqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZFzthQVdwIAg5t3M6GAN24TFpEVTAgqZ/bQ8wGg+y0=;
 b=BvSus1SVJNpqd3Nn3Yv64SQ0FRLt9N+Ume67IMv6A8pcgVrk9QRVT4p4WUa4Mfbp1xiL9EbMx9/o/nhwfFUb0qiRuRlv9jodaqLVvB8VE5Wf09qC46Rfhtnu93M3TATdU6dFsblUEFz6ABewgQS0snTXbvnbxe4eCFwLuPvHFKRRm4GefhZnF6z3cL9L6Uy3lzK8lP1URbXMzu2cfKHNkFk75x70r38nIpjk4OUr6YDaSCr87IrH/dH6e3ipoDgTcBcczS97UYFj2QjWqazswtH3TU002oqrkFydEbFhPkWhIg1stAnH1Iv6ZVA7P4h9hng7wxgOvu8LLAt4VO76kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZFzthQVdwIAg5t3M6GAN24TFpEVTAgqZ/bQ8wGg+y0=;
 b=zWvkaSg8jONT305nB5NML5FLUsL+AURgLb4dLU+75CZKPpjRO/AWqywVSARY8vu35dkyFYjt6xT91r9ftarhxoa8eYj4QwKV9DDsDqb2Zb6NdrNnTF/p3xtycUFQ1DFFtA5xs95HBSseWfZEoOsTkOgyOCy/uo+2tfn2dXJuSL4=
Received: from PR1P264CA0041.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cb::6)
 by SJ2PR12MB8830.namprd12.prod.outlook.com (2603:10b6:a03:4d0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 17:18:57 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10a6:102:2cb:cafe::8) by PR1P264CA0041.outlook.office365.com
 (2603:10a6:102:2cb::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Wed, 18 Oct 2023 17:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:18:56 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:18:49 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v12 05/20] cxl/port: Pre-initialize component register mappings
Date:   Wed, 18 Oct 2023 19:16:58 +0200
Message-ID: <20231018171713.1883517-6-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231018171713.1883517-1-rrichter@amd.com>
References: <20231018171713.1883517-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SJ2PR12MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f8ef16f-e15c-4768-5639-08dbcffe4f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7a6d9m5yjVeC09j/H9MCcGhLoWuXCrFh6v/YAtbzFD9fGrzM+OrE8RfycxVLRUAwdXW3z4ozw77pGXFrnGvpsDED/UKpV84YyE2Mzvp+4o7HQmZh4woI0TyqLdJrwncyljYTCSUCDoykF88WQeDVwP7bMn/I1/zWuO6f4FxKX4Fw3J5sMQd97XscZB3niQ/lkRoNMwtCCSYn4kU/iuzbUZmgc+lSV8aK+OZwWhEQPKfhbJ/oVBO7ctUC755+k9JELdstoPWC8IgFJu+PSEO6HqLX9+8vrZNBM1exb1nSz+clhHM153OwjE/iCpRlNjQ9ItaRAQz47Kz560qnLZrBn8VnWVBZI4Ew5N9VC1GC4x266kHfMz+1aIV9FFMmM63HKh9I7RT0R+fDxuwp1nEV5byadSR6ceZPaG7bT/7+sX2O+rf4+qto+O0IkukuMOnygKUMBFraufDA1tAeamaqfJr2DjQ7MyacYCxfZipx27Ptt1gpNxWy+a2IdmAvtNFWz2PS4SWmdNIhmjx+V6mDEr8sdUs6zfw+xFJ7wc6oTkFNbnQ/pChti5D2u+mU1ftIWT56zZjOOlV4cBlXjzQb3x86gcrMrhvMX5wxeqawwVN1AtZl9oC+hKo6Xdz+pD6L6A6cfwC+stUcDkjfzy6cdWBRAf8m4TPgonij7HuKjK6mT+3lFSnvgD+KmI9aAu+5P4HLSyE7Mepxpfat+KNJqkSQxC8ZntlO1oppcwL4Pij07gMV6ccGqemtYb6MVIkXLoVZmLQmm+K1JZ16y0RNng==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(451199024)(1800799009)(82310400011)(186009)(64100799003)(46966006)(40470700004)(36840700001)(36860700001)(40460700003)(478600001)(5660300002)(70586007)(110136005)(70206006)(83380400001)(8936002)(8676002)(7416002)(2906002)(41300700001)(6666004)(54906003)(316002)(4326008)(336012)(40480700001)(47076005)(81166007)(1076003)(26005)(2616005)(16526019)(356005)(426003)(82740400003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:18:56.2591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8ef16f-e15c-4768-5639-08dbcffe4f5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8830
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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

