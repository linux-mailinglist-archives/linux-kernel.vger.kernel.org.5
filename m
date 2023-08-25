Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF690789267
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjHYXeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjHYXdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:33:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0526A2129;
        Fri, 25 Aug 2023 16:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLNOYmXf1mCAOvE6LfTltTVfm6uaYaDw2G8LmJJFEGx10sFMHGY0PIzPo6Rxmqvgyj3rap2EUrFBNggvNfDH1TwFYvX3Dq0jzUho8uoCx99pvsumjsEtvqRr9HbgZyyi+uB/mr/la8xENluC/xCMEeLvqGOVsrYs2C+g1eEazpjjGG6FxBfClsHjhncnBl7SCSzFcHQ6bgSVRZjhdp64f/iAXW6ruXjl39BEMU3bLBPM1j0A+pfhw5LCWO+mSjYBZ8DiQmDbfr3fcdzlHBBT/WcYb6+LBiUU1W9Hhuu8bnYXuzcPkNbNv2KfTrHm+2C1xMZfjk2EAI17v6Fu4kZcnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQrlvBOOh12RJZjvDBQHPgre4Unn8cO3Ogor/WzFBR4=;
 b=U1NrQOk1bu47qqAsT/LsQAISB4ohtTUHbnfC0FFZf7SdGxixJY58bzmytR827zXuhqBOAGhWrFuPmr07bUwtjRN7m2IwOcQtWTLoQfHBsKcBDqUI/0G8SR7+/TJcybz2Q7K4KsAd4m0jShFCF/dFmqyF5HvpWeTfIykDFLaNdGtrl2L9Bf/jlh0RPS+t8X5jD6jBcua7c850pPybmixsrecGgi/+aKQ0aYWruShRi4rLeHYlol1TKFCKPsqATJenoAfEPhb8zP+7p0Hy+0tyGbgw1A1zFHOyRgPCJU1aijZO+Jple348o/vdt8/PVutGC9SUR5ttdWrcAsg7IT9gyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQrlvBOOh12RJZjvDBQHPgre4Unn8cO3Ogor/WzFBR4=;
 b=Uv8J9drPJI2J9TzCyHEmhIh+MFUahj/C72rNpJczSGgTbMtTO3e8zRwBfAw+Zx/q0zo0vjx3qIDJrNHQirsxg8XtGxDflWzRUThR9qWV0658Ptz9WKTxjfgXSwWPHSRyfbidzYMbmImo7SwxAucWcTCz1bVO+YTFWtaJ2YLEtuE=
Received: from SA0PR11CA0189.namprd11.prod.outlook.com (2603:10b6:806:1bc::14)
 by DM4PR12MB5071.namprd12.prod.outlook.com (2603:10b6:5:38a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 23:33:37 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:1bc:cafe::56) by SA0PR11CA0189.outlook.office365.com
 (2603:10b6:806:1bc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24 via Frontend
 Transport; Fri, 25 Aug 2023 23:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 25 Aug 2023 23:33:37 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 18:33:36 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v9 06/15] cxl/port: Remove Component Register base address from struct cxl_port
Date:   Fri, 25 Aug 2023 18:32:02 -0500
Message-ID: <20230825233211.3029825-7-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|DM4PR12MB5071:EE_
X-MS-Office365-Filtering-Correlation-Id: 7005fac2-cd0c-4996-cb6b-08dba5c3b4fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Bq2fFKdJAMk96Y025YoP0WBfRhy4f6OydGIE0xJZ7vo/LwdQGFw4SEYdt3wqcE0W7ICvL1ztYXsUGC38w9Xp7gL8FHIJDpbFnlbcK/68aNJnkj43AYISmpFqwdxOIobKKMelwBSMTuPNlGGvnnUrYritdnGr+powMLXgU+JT2zsETcArytctlb4HAAXIFPBgfwWbF6wX61iZyv9sz2y86V62dCOp+YJ7bSSgcYm60aKMuxwCeTJ55Wpl6PSDvlddT8t8gtFh2+qHKGAdf+zI5mIA7SMnfuVU0x9IRfyxz3vSr7iPlTqXV21RaL7Qm5tA51VLL6Ls2mQnSTS8QEeZVvEuzxdNnRQpLRq5H5+lkUQMhLo73+eaquoCwf5QQC82rmEmZpnz4c+q1yq639fUa0cnpzHeBS6oqa1/rxP9ZktuNSjPjG09JslucjdaMSsYQTtIfa9UDAdVm5YhNLEet5p90XJmxneqkJuaNjILg/ebD3od4m/biwPjcQZrZ/9VYrGFslvbSNXBYgx6XIiFYRSNqy/E8YfKjMDhVMppSSqs6RmvqOerrSrZyxVn9sbfMWz4pWjQsGr46OjVNC15ZbkqtJk7jVfrpo56M8OPsgeCEqwS28KdQGyfchqTi+mr8gtT8OT7b5NpvRh8ScR0qj87V3LFDMhGHPOzsCfyBod4a1WyfU3JUi4JuSIY11Dpx8228ply09U/ixbNENUJlW0ky9AoISXwe3KVxlzG7jiIO+445ncHxhhUvkkoF8qwmoIH8L/e3iIIi8OwF+53Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(1800799009)(82310400011)(186009)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(1076003)(2616005)(5660300002)(8676002)(4326008)(8936002)(47076005)(426003)(36756003)(336012)(83380400001)(7416002)(44832011)(36860700001)(26005)(40480700001)(16526019)(82740400003)(6666004)(356005)(81166007)(70206006)(70586007)(54906003)(7696005)(316002)(110136005)(478600001)(41300700001)(2906002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 23:33:37.5972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7005fac2-cd0c-4996-cb6b-08dba5c3b4fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5071
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

The Component Register base address @component_reg_phys is no longer
used after the rework of the Component Register setup which now uses
struct member @comp_map instead. Remove the base address.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 4 +---
 drivers/cxl/cxl.h       | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 2d22e7a5629b..99cf5cfbbcb2 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -618,7 +618,6 @@ static int devm_cxl_link_parent_dport(struct device *host,
 static struct lock_class_key cxl_port_key;
 
 static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
-				       resource_size_t component_reg_phys,
 				       struct cxl_dport *parent_dport)
 {
 	struct cxl_port *port;
@@ -669,7 +668,6 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 	} else
 		dev->parent = uport_dev;
 
-	port->component_reg_phys = component_reg_phys;
 	ida_init(&port->decoder_ida);
 	port->hdm_end = -1;
 	port->commit_end = -1;
@@ -730,7 +728,7 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 	struct device *dev;
 	int rc;
 
-	port = cxl_port_alloc(uport_dev, component_reg_phys, parent_dport);
+	port = cxl_port_alloc(uport_dev, parent_dport);
 	if (IS_ERR(port))
 		return port;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ec8ba9ebcf64..b4383697180f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -578,7 +578,6 @@ struct cxl_dax_region {
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
- * @component_reg_phys: component register capability base address (optional)
  * @dead: last ep has been removed, force port re-creation
  * @depth: How deep this port is relative to the root. depth 0 is the root.
  * @cdat: Cached CDAT data
@@ -598,7 +597,6 @@ struct cxl_port {
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
-	resource_size_t component_reg_phys;
 	bool dead;
 	unsigned int depth;
 	struct cxl_cdat {
-- 
2.34.1

