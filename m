Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EA67CE49A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjJRRbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjJRRa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:30:28 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0FA1FDE;
        Wed, 18 Oct 2023 10:19:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBkaf9K6TPaIOHNs/72Lgfiix9lVj8qPIiNGLcnUSkxCeYHK6xSydnmBCs2V89b9eRz8IVLNkAuGcK020DgeGxayfTsGsTf5yGMuLfR87Pr+Al9alzPMelmBbA/6HW8LV8OgSXVFvUQvtgip9JR5FBrrW6ocCqcxXReB/+vTgQ8pJIu+TomZWTrG+VC7UEowQKRgxUB/1EFub8g9oZKPcuzrfwB2yU5h8ZH6rfLjJ6iaFWWAk1ZGfLhRvf1b5kVArfFHutKs4HdThEO+qGa+qhUDQFOBjo5S3AMp1fw7EQzLYuPEF+WCvBk8AjNsYqMUdI/o9Tr6grJnfkxWxba9lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IJytDqcDaz8BkOf8njyNx1HVF5uxCq02rdnhyh9vXg=;
 b=dpVBO5no/WwmVe4ePJHbtHVDSz4YYmrpy/+NoHyJ7RA/HA4DHqnE5JUO6AZDMt6RL1754RNQYGtP8jgn2ZXdWri6SwJykzmcy+lvmdBHA9z/OSeV6AQ0ViqKhJ6ggTRRk79wp0pU1sKjkZSHnQhm5AymsyOCHobKQnTVNq5xJ73AVtKLAemKRzfyHcvozR8CoUnffQ9QKRaKl3Mjvf/plhFAyC+xR3bLBZKJSWGW5fqiz/xKuvqNZ6uCYMfPjlgj2hAriEshSDYui3XflDturJPkaGd2DdEy81lX8EH9i3jdsoq8sDibGUU/OAzXcs4eFJDSiG/58UyDzKs6av4qAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IJytDqcDaz8BkOf8njyNx1HVF5uxCq02rdnhyh9vXg=;
 b=ek7QfdeFyzd3aM12Mhs0mbFEBlOl6FgS+kasR02hkm2e6DsWGRm7LAGsut8Bx9IWNP9teVHAFoXYG4gF9/5X2zvia1C6/AKoMW5I6xiVHmgH9JvZVf6msfKsFs6Ft3GJaYKBHvRCCIHjVzX4M/a1zKjvDvL98Ha5QBFRx2f2av0=
Received: from PR1P264CA0039.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cb::15)
 by DM6PR12MB4895.namprd12.prod.outlook.com (2603:10b6:5:1bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.40; Wed, 18 Oct
 2023 17:19:03 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10a6:102:2cb:cafe::52) by PR1P264CA0039.outlook.office365.com
 (2603:10a6:102:2cb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Wed, 18 Oct 2023 17:19:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:19:02 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:18:56 -0500
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
        Robert Richter <rrichter@amd.com>
Subject: [PATCH v12 07/20] cxl/hdm: Use stored Component Register mappings to map HDM decoder capability
Date:   Wed, 18 Oct 2023 19:17:00 +0200
Message-ID: <20231018171713.1883517-8-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DM6PR12MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 538c3933-729e-4dde-68cd-08dbcffe52db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /I7XE+Qdd9V3kEU0K7Oon7dLGk0uGzhjzqj+fpQ3lmHcbEdbEB92+mjWpxd23jL3oWUo3HOynZAbCWDs3mzTZUaTg3S7TNZxLIxhCbHzG29fRWM3pctdrTBz34NuEcLLkzb4J/IVokzNIqjw1xvwhpOIA8dH+TsvBE/HPD6i5WysS9AuW61qWqlVE4zlawu/eANYN2GfypWaYNv2EXqOUzRNC5wvOtJd9SIf9h1x3kENQDjlk+Z6CW2Cy20Zeymg8aWyR8o086mlEjfjQKrwYkVTWjgbYKJOLLqYfq1sHsxdtX74NWAqdD20+GMkqozUlA0XLE01HeOgOCEDBc5pTt2ZQwE7tL3cebiOKX0HjxXsgTepg5D3DCJU9RFSPJ0Pg6PEdMSO4FKv8ZNTvnnEPlEauLlBrD4q8ou35p/i1tbqoqZjb7btDLgq6StXX7ZNdL+M+sLV5CXtFXQChJ2AM14cv/nPmwcAperOCtBfg02iQJD0x2abcFMKIPq4tZidj6MpufNtiv7F7FsZU8S1eiF9xPM6Z3fIykNs+LPfr8RQFO4aaRkQjpwMWeDlvUNluhu5o8Utg6FtmVd10YFK29oWTeFT7KPxCdCdqHo0CET452cWFjaFerlGBhd5J6ZCmalo3Mi0KK84hFZgk6/x9HDYQ9TA4ZhLLf4yCsepF6sXwwlv6WEAYTHRPM3AyjxNfB4LM/9JoPyEnhM+vabBoAMnxQz+nKX+eozE3FyrLg86aAWTedsgqP2aK0gp71RKoeIAlk6ijCjiRWrh98i//Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(82310400011)(186009)(1800799009)(64100799003)(40470700004)(36840700001)(46966006)(83380400001)(40480700001)(40460700003)(36756003)(2616005)(81166007)(316002)(1076003)(2906002)(110136005)(7416002)(70206006)(41300700001)(54906003)(5660300002)(4326008)(8676002)(8936002)(70586007)(478600001)(6666004)(336012)(426003)(356005)(26005)(16526019)(82740400003)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:19:02.1185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 538c3933-729e-4dde-68cd-08dbcffe52db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4895
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, that the Component Register mappings are stored, use them to
enable and map the HDM decoder capabilities. The Component Registers
do not need to be probed again for this, remove probing code.

The HDM capability applies to Endpoints, USPs and VH Host Bridges. The
Endpoint's component register mappings are located in the cxlds and
else in the port's structure. Duplicate the cxlds->reg_map in
port->reg_map for endpoint ports.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
[rework to drop cxl_port_get_comp_map()]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c  | 49 +++++++++++++++++------------------------
 drivers/cxl/core/port.c | 29 ++++++++++++++++++------
 drivers/cxl/mem.c       |  5 ++---
 3 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 11d9971f3e8c..c5f951658130 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -81,26 +81,6 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 		cxlhdm->interleave_mask |= GENMASK(14, 12);
 }
 
-static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
-				struct cxl_component_regs *regs)
-{
-	struct cxl_register_map map = {
-		.host = &port->dev,
-		.resource = port->component_reg_phys,
-		.base = crb,
-		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
-	};
-
-	cxl_probe_component_regs(&port->dev, crb, &map.component_map);
-	if (!map.component_map.hdm_decoder.valid) {
-		dev_dbg(&port->dev, "HDM decoder registers not implemented\n");
-		/* unique error code to indicate no HDM decoder capability */
-		return -ENODEV;
-	}
-
-	return cxl_map_component_regs(&map, regs, BIT(CXL_CM_CAP_CAP_ID_HDM));
-}
-
 static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 {
 	struct cxl_hdm *cxlhdm;
@@ -153,9 +133,9 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 				   struct cxl_endpoint_dvsec_info *info)
 {
+	struct cxl_register_map *reg_map = &port->reg_map;
 	struct device *dev = &port->dev;
 	struct cxl_hdm *cxlhdm;
-	void __iomem *crb;
 	int rc;
 
 	cxlhdm = devm_kzalloc(dev, sizeof(*cxlhdm), GFP_KERNEL);
@@ -164,19 +144,30 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 	cxlhdm->port = port;
 	dev_set_drvdata(dev, cxlhdm);
 
-	crb = ioremap(port->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
-	if (!crb && info && info->mem_enabled) {
+	/* Memory devices can configure device HDM using DVSEC range regs. */
+	if (reg_map->resource == CXL_RESOURCE_NONE) {
+		if (!info && !info->mem_enabled) {
+			WARN_ON(1);
+			dev_err(dev, "No component registers mapped\n");
+			return ERR_PTR(-ENXIO);
+		}
+
 		cxlhdm->decoder_count = info->ranges;
 		return cxlhdm;
-	} else if (!crb) {
-		dev_err(dev, "No component registers mapped\n");
-		return ERR_PTR(-ENXIO);
 	}
 
-	rc = map_hdm_decoder_regs(port, crb, &cxlhdm->regs);
-	iounmap(crb);
-	if (rc)
+	if (!reg_map->component_map.hdm_decoder.valid) {
+		dev_dbg(&port->dev, "HDM decoder registers not implemented\n");
+		/* unique error code to indicate no HDM decoder capability */
+		return ERR_PTR(-ENODEV);
+	}
+
+	rc = cxl_map_component_regs(reg_map, &cxlhdm->regs,
+				    BIT(CXL_CM_CAP_CAP_ID_HDM));
+	if (rc) {
+		dev_err(dev, "Failed to map HDM capability.\n");
 		return ERR_PTR(rc);
+	}
 
 	parse_hdm_decoder_caps(cxlhdm);
 	if (cxlhdm->decoder_count == 0) {
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 28ba8922d0a4..f69484d3c93c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -751,16 +751,31 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 		return port;
 
 	dev = &port->dev;
-	if (is_cxl_memdev(uport_dev))
+	if (is_cxl_memdev(uport_dev)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(uport_dev);
+		struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
 		rc = dev_set_name(dev, "endpoint%d", port->id);
-	else if (parent_dport)
+		if (rc)
+			goto err;
+
+		/*
+		 * The endpoint driver already enumerated the component and RAS
+		 * registers. Reuse that enumeration while prepping them to be
+		 * mapped by the cxl_port driver.
+		 */
+		port->reg_map = cxlds->reg_map;
+		port->reg_map.host = &port->dev;
+	} else if (parent_dport) {
 		rc = dev_set_name(dev, "port%d", port->id);
-	else
-		rc = dev_set_name(dev, "root%d", port->id);
-	if (rc)
-		goto err;
+		if (rc)
+			goto err;
 
-	rc = cxl_port_setup_regs(port, component_reg_phys);
+		rc = cxl_port_setup_regs(port, component_reg_phys);
+		if (rc)
+			goto err;
+	} else
+		rc = dev_set_name(dev, "root%d", port->id);
 	if (rc)
 		goto err;
 
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 317c7548e4e9..04107058739b 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -49,7 +49,6 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 				 struct cxl_dport *parent_dport)
 {
 	struct cxl_port *parent_port = parent_dport->port;
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_port *endpoint, *iter, *down;
 	int rc;
 
@@ -65,8 +64,8 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 		ep->next = down;
 	}
 
-	endpoint = devm_cxl_add_port(host, &cxlmd->dev,
-				     cxlds->component_reg_phys,
+	/* Note: endpoint port component registers are derived from @cxlds */
+	endpoint = devm_cxl_add_port(host, &cxlmd->dev, CXL_RESOURCE_NONE,
 				     parent_dport);
 	if (IS_ERR(endpoint))
 		return PTR_ERR(endpoint);
-- 
2.30.2

