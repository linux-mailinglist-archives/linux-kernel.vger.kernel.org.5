Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093AA7B092B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjI0PrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjI0Pqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:46:37 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943302848E;
        Wed, 27 Sep 2023 08:46:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sq1WovSZxxQjurFCuw2oaXTkxdpUTgAlXylrk/kNemtQBaDs75tw1RvTr7op/MdwaMya58qOgOu+iU3z6V8PBk/dHW7H803E1nUuy+on1rI0fh+VQfC9befcvQRKJziL5CqVkWmkYG1epFU2KGn3eBfDNaKxSiqX+7Sq36+1pN3PEcC8Bddd/WGinqwKIeCBsLvtbYxBoreaXC2kj0QWuPNKpIHZQDvxLVYBU1M+sQWPCDPzxiJu9ULo3dFsuK8xjZWU1fV0SKt0ny56XGOM3Dr6YuzI2AxaX7JSIMLoRuexmxr9/Wt3qBHU0VHcYe6J7prsWA3QRvn/6D8y3JMkEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppLaQzd9t4UmG0ch+d5uHu9w523reW2OkubTbdM4HZE=;
 b=MVXf3D0IVWamj0JMs25KeWai7oDid+7gC3FhJ0oysIm79uKoLc+IcnJfkWN5h8tXLX1sYH2r6yoD/dQLQ+dNHNDxCUbjdTDr/3ywq/9HccQyiTkBS1WzAJs0KnIDZxD0fwRIWGwsz6GJAoW7lOyUaA+O2h7R7XO6ZFNnDvAuioYORAowjUEe7olI7t5J0zEzpaFJP72tp9RO5yzKnS46NgFt/+2lOlaR9BKj+DveJOX7ZHzvT410fdCzyFT32AaVsXwmoH5Eu6rC7K3NvFQ0Ni60RzD1f9btasGB8mw2xacGc85FHnjvoZxKT+Iayl7ChKhs1Q+kYDthUSkx9Gz6NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppLaQzd9t4UmG0ch+d5uHu9w523reW2OkubTbdM4HZE=;
 b=SZP/QN+/rn+ttLY6zenllsDtRnsasNuogTwx75iBm/RMjXWyDSgMoDjqUk55bDfhqK9EWSid8q8DHyNWVLuARV+RJJj1USSwJMi+ntywlIAoVHjjTD2t9d+ClKJiGM1PygFylKKjK9GLCI72pFcLn8/kW5s9cCucr//FtlNQaYk=
Received: from MN2PR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:23a::32)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 15:46:25 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::a1) by MN2PR03CA0027.outlook.office365.com
 (2603:10b6:208:23a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 15:46:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 15:46:25 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 10:46:20 -0500
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
Subject: [PATCH v11 07/20] cxl/hdm: Use stored Component Register mappings to map HDM decoder capability
Date:   Wed, 27 Sep 2023 17:43:26 +0200
Message-ID: <20230927154339.1600738-8-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: c962113b-2ec3-4a39-bf9e-08dbbf70e7e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5RBdLvL90CTgtIawtAHHM5tYnNX0DDjIcCMA+2DOolKyP5E44dMs4ho3P87vN3akZjcAnUg0uqlotSQlz7X4tFjz1HeKPzLCr8wNYLgeX4yqUSgasvj8kuL8h7LS8Rzwt+i+Q8uDRtogoeyii01vReuUwERYFac6kgsD1oGY+3+ktoSq5KWeEwOLTtPXO5UEgNeU2ZPL/r+Vn+7aci1HhNEwpNNXaAwahoD2VWGEKFU0yOJ+4LSrL+4Gg+dN6D65EgZ3DtiBlfIFffU+kOJsP1UbZVU6DJnVGlqj5s9hL2dazHn9qOlnvsVnCy/1vDhWllVFhpHFVkMo3Ej8FeuywVGd2zxCGqsgwH5q3XrXzut1ABNyhN6c+LYVeMwfO6/+rtQgc8wYCnxXflDENTpmr791SNm9UTvOR6tgafWt3mLtmmURE0Zn8xLjwdAh1hXJ2j4GAIUCouabxGRaMSlSBw0RPKPtCW0HgwBflzhuhcezXsYvmTs9Z5aulg0sfl5MwkbU1J5zIt0IIbOEin31NCqa7hMDMoeDdfGd9XovjXWA13NJWAACb6z9STi/cuYeCOyWoVhsRJLfQ6h78Zh34XvtRAl+erhRdlRSdAXVhrgqTqDPSSOV1VOzH/cwoCyVokt+cipg0TOvKbD8V+DhSHKFWVmvpjbr063aeRNsv1+xwDUxZZemIAUzgGKP24Cj2MAQ2fKEpqGsBwHSmh178bcYXWLh2a7UuLjlmJpRfAqeu/dpI5iGJ/c1KhhQ3DDASkhfGyGSs5m58FTtwCdXVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(82310400011)(451199024)(186009)(1800799009)(46966006)(40470700004)(36840700001)(8676002)(4326008)(8936002)(426003)(40480700001)(336012)(26005)(110136005)(2906002)(16526019)(478600001)(41300700001)(316002)(70206006)(70586007)(7416002)(54906003)(5660300002)(40460700003)(1076003)(36860700001)(47076005)(2616005)(36756003)(83380400001)(81166007)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:46:25.0096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c962113b-2ec3-4a39-bf9e-08dbbf70e7e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
 drivers/cxl/core/hdm.c  | 48 ++++++++++++++++-------------------------
 drivers/cxl/core/port.c | 29 +++++++++++++++++++------
 drivers/cxl/mem.c       |  5 ++---
 3 files changed, 43 insertions(+), 39 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 11d9971f3e8c..14a0d0017df3 100644
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
@@ -155,7 +135,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 {
 	struct device *dev = &port->dev;
 	struct cxl_hdm *cxlhdm;
-	void __iomem *crb;
+	struct cxl_register_map *reg_map;
 	int rc;
 
 	cxlhdm = devm_kzalloc(dev, sizeof(*cxlhdm), GFP_KERNEL);
@@ -164,19 +144,29 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 	cxlhdm->port = port;
 	dev_set_drvdata(dev, cxlhdm);
 
-	crb = ioremap(port->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
-	if (!crb && info && info->mem_enabled) {
-		cxlhdm->decoder_count = info->ranges;
-		return cxlhdm;
-	} else if (!crb) {
+	reg_map = &port->reg_map;
+	if (reg_map->resource == CXL_RESOURCE_NONE) {
+		if (info && info->mem_enabled) {
+			cxlhdm->decoder_count = info->ranges;
+			return cxlhdm;
+		}
+		WARN_ON(1);
 		dev_err(dev, "No component registers mapped\n");
 		return ERR_PTR(-ENXIO);
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
+		dev_dbg(dev, "Failed to map HDM capability.\n");
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

