Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44907B0945
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjI0PtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjI0Pso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:48:44 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A33F27E66;
        Wed, 27 Sep 2023 08:48:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UViu3QhSA/9N7vsR+Oftl0m0ylfWmojz6vKhw5YrPYWM9ofwBfTK73z9EkaPylh7J9xg6ZteQ7EYNx/WpNsbQ0JAcbtbmSaGdyPmqiNfZwij8zGWf8AmvpuBsG9/7TjGgqKO4wrXnG3V60jslU6MFBlR+x6Dmz/yEfUlaW82rHlabWyws5xn+iR8N51dR7o+zUuJbqK9Y1Gvkx8IU1g1p/ufsFBWzn3VdCpHsUkcAPwX0zKyGDt2NCu2zkdBo9fMcN8ikV2GMzwSKw/Xtf6ggElijW3dS7A/q5mz/Iav2Nafmr9Tq3/dsoW7rf4ZwT44l+qom5By6vGShVnDppsGgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAqBGjLUmrdmMDv+JR7/V8e9voxqlLDzh1nO6fZWouE=;
 b=l49nTwt1FWd2bNrif58EgKRsXec393dXPmDA3EOLFfGWDSQompUSLdWLY6Yo3DzoiF63lpqiLj+PgVXdihnEwE53vB3ifPu8e4wxx99CQo1xMLhQQTsI+hLrHrL25GjqR2qlpyrY2HbTYIRq35I/I51IQiwjEZ8c0htGkY6sNjOeaj0jOgf/RZDScX+kXw5b32QItbcrNbovCde5NZeugJUwJdIZUUE2iDlDqpDVn8V817OR+2t86EDI3MCZbhOWKUTN2GaNT//D6Fn2ulcXsamGOl61B1DJi+qhZw07K8QAIkx64RDxqRcHNRdTN14OY+F2X5oeCuJxF/lSXo3bug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAqBGjLUmrdmMDv+JR7/V8e9voxqlLDzh1nO6fZWouE=;
 b=zUXwc8Ey4993ZShr2p4Qqc1MB2tCYr+uZigalqrEZcpqSlG/qtFurYf0WiRdd3xoJKFfWQ0Ylqlm/2Dh/FzhMY3MM29agKdODenpl33w7cfjwbq+RfVfFsxrSa8YyAPrnz1MtgC3+THp7Mm5HAUwvG6kM08AJqRX0fLs4eBgBXY=
Received: from BLAP220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::9)
 by DS0PR12MB8198.namprd12.prod.outlook.com (2603:10b6:8:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 15:48:04 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::cf) by BLAP220CA0004.outlook.office365.com
 (2603:10b6:208:32c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
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
 2023 10:47:45 -0500
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
Subject: [PATCH v11 19/20] cxl/core/regs: Rename phys_addr in cxl_map_component_regs()
Date:   Wed, 27 Sep 2023 17:43:38 +0200
Message-ID: <20230927154339.1600738-20-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|DS0PR12MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ec80ac-646f-40ce-e509-08dbbf712309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kWnbNCCDU1haH7wAn6ufipCU6VGyOADik7nxdGzP26ui4Q0zQw2q7FxTuEJKhBoAzrwuhqTkias18z6Vtp9VOvTENmF62y9IirJi1IrThDNZyADmW/klk240GybqHw2lGagOvOk7Y9viYVDYTp3MgQ9H+WLMV3tioonFB28wcstD/s0Svxt8zuSy0wHL1VITvc32Uk1oqKG2O3vLKaNyLFlXweRE3f6DPtHRf7c3q6S6eW5EXwnKmzcfnS4uc0fpj7KDRcwzRcJ0L1vVH2N/8WvHMkzblz9YWXvzL9Szoo9bmsJQEE369yl8ylDs6ckIFIwjZiASCkUkLCh77ufOl670w20FgULBXCvsEObdW42iL7jnzwSiZXEeC865l+crcNAPBMjzXtvhcAOjAiGNNbMW41FWS5N7EohE4X3S6ObT2FwWTKkgCCSOyOUicjiwxQqNkBlYdhPatj6V20ZVLP4spnpUi2cxTG0X3vZGLSL8RlvwR+630ZWjSzBk2mSEjMRgjC6/mGn6OoOyesHyMYYR6RpiOT/XjvtwipgRqIDXvEZd3vTPuN94KO0eaAlTB5BXtqwKuuYf0hGr84+3P6D9m8qL0o5QdVu0HiJxkzJqKM7MULlmsi8lCe+w5uhYaPhwPTj7K3kTPhBbgE1Er0cDTqL5et9qIkLgDMSmB8ihEjL/oebsmirZBFwE/LN1imAjDN7lfU7okFtQlL89usqSvG65aSdrjGUUxb0HawvhAcpu9Ye/thhxD/mAaw0Qb07xR3/vd3q2Aq38QRVGmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(40470700004)(46966006)(36840700001)(1076003)(16526019)(2616005)(26005)(81166007)(356005)(36756003)(82740400003)(36860700001)(47076005)(40480700001)(426003)(336012)(54906003)(40460700003)(83380400001)(316002)(4326008)(8676002)(8936002)(41300700001)(5660300002)(110136005)(70206006)(7416002)(2906002)(478600001)(70586007)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:48:04.2805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ec80ac-646f-40ce-e509-08dbbf712309
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial change that renames variable phys_addr in
cxl_map_component_regs() to shorten its length to keep the 80 char
size limit for the line and also for consistency between the different
paths.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/regs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 6e502f02899b..7b56f6f28ab1 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -216,16 +216,16 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 
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
-		*(mi->addr) = devm_cxl_iomap_block(host, phys_addr, length);
+		*(mi->addr) = devm_cxl_iomap_block(host, addr, length);
 		if (!*(mi->addr))
 			return -ENOMEM;
 	}
-- 
2.30.2

