Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65C27B0A32
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjI0Pq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjI0PqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:46:15 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A33C272A7;
        Wed, 27 Sep 2023 08:46:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlrbyI6HbYF/V2Y6DlYofcdbW4aXcG0gYZUDmPc18SkOQ9psZIcE2bxfl5bpzEJaekOJox/tb7RK3cHE2Faljzz22/GVP52tIuwDdmg5iTrAbcygaUMSqtiCnBK+WlXduG9WWXlwUHbvDyIG6tlskggnsXCCJsUEfQFXMR9wvbAURnV6j99lU/ZBmev+SR/aJ+INlWs9cWeefpPyPFr+OlPhvVQImmOFgom2YtZwvH+J692x+OyvK1tifWZ1Nw9Jw3ehdMpSDfVA6zlFFWUzINdIEAdsZQ1qy9p3OxkhJAkHU+MATeOip7OjwP8Nh43x1yTL0osKIIUbw8l+d/vp8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvFEbzj3MHTJf3RlJ6bkRTvw4fI1+dLGKbfK5hFx+Yk=;
 b=MhdF0vlpXWw2I+IAgDq/+H/+BxGNgipi0rTQvk27Yb7nKlZ6lEroOZ9V4pEAqsvEPxJKsTtSTkXzs0xoFcqHj+Yi51omZw1Au8C46/Olb/H9nmfjidTPpNWjTsz/52gHkMmomVEArsNyha1jB+ptMYHwTkeYIWHID8pBuqNmVlnqsnXJAjhaXemU4HINd1tdFMBuQPApFuQjbDGKG7CBoenOVLLYwpiMkpnYLYbNHT6J/wG/PqyvQr7Z8LYYjHBJ3JYDzQkMew7SWDfPt+eWMTJt8bY7oVRH5iQL7TWZ83a1LSnxrZqqzxz4LUsAYo2u16mY2O3GXk6CMECwYuKK6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvFEbzj3MHTJf3RlJ6bkRTvw4fI1+dLGKbfK5hFx+Yk=;
 b=SQXH7Q7FSPR2G5ulUK4IsWg10WkBIFVF2XxiqzYvQ3vaDOCiDw2OeD0c+jeh0R7ZfdhDpiphvfQmuzlWR/rCF1jQKvweu8kSB4GTHX3k2MU6DKNSMRbUX0ImXBTyrQm+0wXdyshPGJ37XuGFHXJJizFQaYNrr5P+KMcJa+627vo=
Received: from BLAPR05CA0008.namprd05.prod.outlook.com (2603:10b6:208:36e::11)
 by BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 27 Sep
 2023 15:46:10 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:36e:cafe::43) by BLAPR05CA0008.outlook.office365.com
 (2603:10b6:208:36e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 15:46:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 15:46:09 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 10:46:06 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v11 03/20] cxl/port: Fix @host confusion in cxl_dport_setup_regs()
Date:   Wed, 27 Sep 2023 17:43:22 +0200
Message-ID: <20230927154339.1600738-4-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|BL1PR12MB5334:EE_
X-MS-Office365-Filtering-Correlation-Id: bc9a3a22-c3bd-4f9e-333a-08dbbf70dea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HuRII8p3ps6N7+JSBjqs5VDZQLwA2KlkfZ3rak/1p2qLUYRKGYo42zY4RGIDaywfsZnxZ5WfTu9PNPrLBuvW1yri3Scwp/4rscvtsNGxu2Um8a/JH6VNeGByhSVHux4YUetVSu/AsnrW12976gTLCAtz0xJU24it7vpTUCJRTwWLGxCFxwBj9L3QRb/feI9pmQx/COgoRuXMZ3FLCylT8u/Wp7sB6WqkDZL0pv8Z2bYCU/FI4Tr3eE0L+OpmevBdYHc4foCy1ii185ch/4l3vXaQHDrg+AbniB2KtszKtfz4pb/1rQKIsSEI66opVO9JKnj8Vrg7gu3QWgE1ZcIuGJkDsSgKQ+N3ck6MheEeoZDB465G2AUFpB9tfJ9Am1+NJ4Ww5zy/hVkWZ29caHTAQEL/hrKQF0OaOvR9uAHVQkhf1bkTO9UZgcWrEzljeo6qQOdz4EzcAj0t0yYe7h3L73rIJdXYDAVNmlg6g6MYm06OOU1Ug1DV3givkeHYYYkdvAxcJ2aHiLwoD6G0Qw6xMlkbgOGRrHhNLBt+YZQdonXEjfHgVjyNeV1ws9wFCsAVe5Ivsd4eoysdQkuKZ2ABUv0VHpvoRFS8yxctOmGIj82UpOn2FaaUqoMzCmNvSm/7nV+/y+qZYF6kUoM7j5oW6dBq1XMWpbhe8U/8dcjD2iS7yaYkLSwTA+jqyS2/cRM+RqqM/s5wI+3zWxw0TsYLAPk48PdRdoAhldlNRHBJtyvCB3KId+gWJ5j0Y6uzKByyuDc/sB/RneuI7LFThiXgSH0PgHpXto+0e2++/gg387M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(16526019)(6666004)(40480700001)(82740400003)(921005)(356005)(40460700003)(81166007)(2616005)(26005)(426003)(36756003)(1076003)(336012)(110136005)(83380400001)(41300700001)(7416002)(316002)(8936002)(70206006)(70586007)(54906003)(7049001)(2906002)(47076005)(478600001)(36860700001)(4326008)(8676002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:46:09.5174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9a3a22-c3bd-4f9e-333a-08dbbf70dea7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5334
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

commit 5d2ffbe4b81a ("cxl/port: Store the downstream port's Component Register mappings in struct cxl_dport")

...moved the dport component registers from a raw component_reg_phys
passed in at dport instantiation time to a 'struct cxl_register_map'
populated with both the component register data *and* the "host" device
for mapping operations.

While typical CXL switch dports are mapped by their associated 'struct
cxl_port', an RCH host bridge dport registered by cxl_acpi needs to wait
until the cxl_mem driver makes the attachment to map the registers. This
is because there are no intervening 'struct cxl_port' instances between
the root cxl_port and the endpoint port in an RCH topology.

For now just mark the host as NULL in the RCH dport case until code that
needs to map the dport registers arrives. Name the field @reg_map,
because @reg_map->host will be used for mapping operations beyond
component registers (i.e. AER registers).

This patch is not flagged for -stable since nothing in the current
driver uses the dport->reg_map.

Now, I am slightly uneasy that cxl_setup_comp_regs() sets map->host to a
wrong value and then cxl_dport_setup_regs() fixes it up, but the
alternatives I came up with are more messy. For example, adding an
@logdev to 'struct cxl_register_map' that the dev_printk()s can fall
back to when @host is NULL. I settled on "post-fixup+comment" since it
is only RCH dports that have this special case where register probing is
split between a host-bridge RCRB lookup and when cxl_mem_probe() does
the association of the cxl_memdev and endpoint port.

Fixes: 5d2ffbe4b81a ("cxl/port: Store the downstream port's Component Register mappings in struct cxl_dport")
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
[kept dev_dbg() message]
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/port.c | 43 +++++++++++++++++++++++++++++------------
 drivers/cxl/cxl.h       |  4 ++--
 2 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 033651a5da30..99df86d72dbc 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -716,13 +716,23 @@ static int cxl_port_setup_regs(struct cxl_port *port,
 				   component_reg_phys);
 }
 
-static int cxl_dport_setup_regs(struct cxl_dport *dport,
+static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
 				resource_size_t component_reg_phys)
 {
+	int rc;
+
 	if (dev_is_platform(dport->dport_dev))
 		return 0;
-	return cxl_setup_comp_regs(dport->dport_dev, &dport->comp_map,
-				   component_reg_phys);
+
+	/*
+	 * use @dport->dport_dev for the context for error messages during
+	 * register probing, and fixup @host after the fact, since @host may be
+	 * NULL.
+	 */
+	rc = cxl_setup_comp_regs(dport->dport_dev, &dport->reg_map,
+				 component_reg_phys);
+	dport->reg_map.host = host;
+	return rc;
 }
 
 static struct cxl_port *__devm_cxl_add_port(struct device *host,
@@ -983,7 +993,16 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (!dport)
 		return ERR_PTR(-ENOMEM);
 
-	if (rcrb != CXL_RESOURCE_NONE) {
+	dport->dport_dev = dport_dev;
+	dport->port_id = port_id;
+	dport->port = port;
+
+	if (rcrb == CXL_RESOURCE_NONE) {
+		rc = cxl_dport_setup_regs(&port->dev, dport,
+					  component_reg_phys);
+		if (rc)
+			return ERR_PTR(rc);
+	} else {
 		dport->rcrb.base = rcrb;
 		component_reg_phys = __rcrb_to_component(dport_dev, &dport->rcrb,
 							 CXL_RCRB_DOWNSTREAM);
@@ -992,6 +1011,14 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 			return ERR_PTR(-ENXIO);
 		}
 
+		/*
+		 * RCH @dport is not ready to map until associated with its
+		 * memdev
+		 */
+		rc = cxl_dport_setup_regs(NULL, dport, component_reg_phys);
+		if (rc)
+			return ERR_PTR(rc);
+
 		dport->rch = true;
 	}
 
@@ -999,14 +1026,6 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		dev_dbg(dport_dev, "Component Registers found for dport: %pa\n",
 			&component_reg_phys);
 
-	dport->dport_dev = dport_dev;
-	dport->port_id = port_id;
-	dport->port = port;
-
-	rc = cxl_dport_setup_regs(dport, component_reg_phys);
-	if (rc)
-		return ERR_PTR(rc);
-
 	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
 	cond_cxl_root_unlock(port);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b5b015b661ea..68abf9944383 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -620,7 +620,7 @@ struct cxl_rcrb_info {
 /**
  * struct cxl_dport - CXL downstream port
  * @dport_dev: PCI bridge or firmware device representing the downstream link
- * @comp_map: component register capability mappings
+ * @reg_map: component and ras register mapping parameters
  * @port_id: unique hardware identifier for dport in decoder target list
  * @rcrb: Data about the Root Complex Register Block layout
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
@@ -628,7 +628,7 @@ struct cxl_rcrb_info {
  */
 struct cxl_dport {
 	struct device *dport_dev;
-	struct cxl_register_map comp_map;
+	struct cxl_register_map reg_map;
 	int port_id;
 	struct cxl_rcrb_info rcrb;
 	bool rch;
-- 
2.30.2

