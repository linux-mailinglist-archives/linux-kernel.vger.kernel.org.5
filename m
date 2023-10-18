Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99F97CE496
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjJRRar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjJRR3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:29:55 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6054AD41;
        Wed, 18 Oct 2023 10:18:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEsSpy46ZNWUdIDd6Z3gvYEhF5HtkHjKe5SRjJSm4JaB3KO4d9A9GMk7S7MUHt4HR4bXvXY+keSMhq3iYOVYz2d7cqhuoo8viu30iSO17AOjExAIe9kFgeIfEErhgcgMzARbBaRpXuiEZci4evQEDlgzv5tiZwBcW0XYHWrecRNvmTqOjqvoJKH1TLINzjnPfuSk6esXWHWOkg5a+hAcZQo1MfzPALL2Z07HFirH7Dit7RNMQwLI324YixXi2bvH/Y+UQHT8Maa2M+//U1JZgbulEnQqCmJLVJYN7LVFVYI5Nj6psbLdMMJsHL4NDofedSF1/hjRzqz/kx8TZOuOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mpbMDvyRqMdfoxvXeGGWdCuDclZXRANG1e6m6hVK+I=;
 b=aNxxyV1K8gl1IgT9g1RsNZH1gRaJBSNTxf61Qo+Lov+8bmYeImZSYOKyoxZAGcn6zu0xHeJER0oABPVk3hxDzVm1UL0e6tkCSKXJfru88tFr5UbtEb86Vm0D7W7kLibkMS8EtdnThsdTri2wMhzd/jqqT5BkK2/8P4K574aXt3WE6m2oYQIOUsbBVT86ZeEUP4WLBh5jCv2Ue/bQbvY1AlQUDwn9oSjNCNEFs2yVUpCRelG8IEqnz0FFN8ol2/iRlcXsOfatk91DF6sK5RVSnFxylXn8gv2XLUytC/pS3LKz/2nQvsMS6cJwrQw2nBZ9RtVtq1i9RHDWQ91fufcHCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mpbMDvyRqMdfoxvXeGGWdCuDclZXRANG1e6m6hVK+I=;
 b=VwKB/JYTvyrdwyubj7h3P4GFGF/ybASE3Rywa37eGh6OjfUb/m5BbdFzzR4owM9LZ7WzF1ro0tbD9oYWhmbGdQkPM/ROqNwnt9r/41XdHmeb0MtGoCubO2t7hxl5JOS9gh1JicaULLC8lDxjd8Fy4pQsR3aABDk10FMRfOOUqNw=
Received: from PR1P264CA0040.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cb::19)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 17:18:18 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10a6:102:2cb:cafe::94) by PR1P264CA0040.outlook.office365.com
 (2603:10a6:102:2cb::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.22 via Frontend
 Transport; Wed, 18 Oct 2023 17:18:17 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:18:15 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:18:11 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v12 03/20] cxl/port: Fix @host confusion in cxl_dport_setup_regs()
Date:   Wed, 18 Oct 2023 19:16:56 +0200
Message-ID: <20231018171713.1883517-4-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 386cad41-ed44-46be-93e2-08dbcffe376b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gBPSwPm18cX/JugJH7sgL6Hzt+8iujRzg2usXq5QIY5GVeGw/TQyUQ1MdBLVa25Os5+ZFMBnIFFukaDCUuJADUSBb+BB3NoM8HNLeYoSnRUyzL6lRPZKWXLK6Jdc1LlmEqbvg3tZMfPXHb9QfWT7VV1aFtb7x6foiDBujH8FdkvpcrDeTlndpmAuEd26qevkjLSoqFdjrpjAAZz011Sa9YkHj+Ak0gWJzu+w8WPXnA28ZCUbG3FUuYaHs8qbji30LF2X7+qn+01sHgvJNGVZiOrV+jebeJV7YqjRmSATvB3gdGPWu9wyVJMYyHfmSKomr2A47kxFLsYNQWvRNTFxCjOifn1CgFYYArGzUClglHupEEWM62iMsu5qRD5qz4+VE7wKOetdkL2bawjVfcZ+nxxV4NROkatJfyNhy9WKO7tK5MCJeFjaxOasRRQzxP9bHlwhfZSQx2Hv2P04PtbBGoFhVAYp2u+vxPuQKIQmEUXPIUrDTzfE6z5lQiLgg65I3Q/fRnh9vaK+O3Psd19ilMMjzsopX7k4KsR0K5FNPLF3sR6R4KL9IZUlWr/8dj4lD1X6liUCRzVTzmvFe0v63y7cWaXatK05uDPRw4iE/6j9ewrgFQF1ztOu66jIhLyqjPS3GLXQqAoZEOy+UKBQY9Ko22fq7SB5yfyQxgVQ88ndev7zr/Or55uDsSXSjAbcSk/M5XCkBpQUE4/FsYkC1XdM+gvf0DGVCIWJqJrnwiq6sthhLLI1HR3gJTpO4EBzz13qwmx/0kELWQhAuRPwJ6FMxQp/UzWOr+07fLlIeDc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(82310400011)(1800799009)(64100799003)(451199024)(186009)(40470700004)(36840700001)(46966006)(7416002)(2906002)(63370400001)(356005)(63350400001)(921005)(110136005)(40480700001)(478600001)(81166007)(41300700001)(36756003)(54906003)(70206006)(70586007)(36860700001)(7049001)(6666004)(316002)(8676002)(1076003)(2616005)(26005)(16526019)(336012)(426003)(82740400003)(40460700003)(83380400001)(4326008)(47076005)(8936002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:18:15.5872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 386cad41-ed44-46be-93e2-08dbcffe376b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
needs to map the dport registers arrives.

This patch is not flagged for -stable since nothing in the current
driver uses the dport->comp_map.

Now, I am slightly uneasy that cxl_setup_comp_regs() sets map->host to a
wrong value and then cxl_dport_setup_regs() fixes it up, but the
alternatives I came up with are more messy. For example, adding an
@logdev to 'struct cxl_register_map' that the dev_printk()s can fall
back to when @host is NULL. I settled on "post-fixup+comment" since it
is only RCH dports that have this special case where register probing is
split between a host-bridge RCRB lookup and when cxl_mem_probe() does
the association of the cxl_memdev and endpoint port.

Fixes: 5d2ffbe4b81a ("cxl/port: Store the downstream port's Component Register mappings in struct cxl_dport")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
[kept dev_dbg() message]
[moved rename of @comp_map to @reg_map into next patch]
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/port.c | 43 +++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 033651a5da30..9b1136018f18 100644
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
+	rc = cxl_setup_comp_regs(dport->dport_dev, &dport->comp_map,
+				 component_reg_phys);
+	dport->comp_map.host = host;
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
-- 
2.30.2

