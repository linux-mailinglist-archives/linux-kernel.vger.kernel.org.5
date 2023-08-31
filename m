Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC9578F02C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346551AbjHaPWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346541AbjHaPWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:22:17 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9157110D0;
        Thu, 31 Aug 2023 08:21:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3tMkNjI0IZGZ8xoIPncBtHJKYhR0WgyCfOVHL6IVMBfzdwQ7hQw6J5FxRnqbb/gs2FBt0jDzHL1l8BcXYx74wLaXHtbtTu2Rw7fTIrl5bnY+LtK81zJRFvBAOJRToaMfkOmdM+GiY1cfYL5KiuPffQvWDb4RK/QJMdv8G2l0pRiW3tQxl1LZOD49rzFmQhY+hCCz5449d5i6mO0Pj79I1HH56KNxXaqd7xKX8/W5uTqiiLaI6ICpESL0dvSGbyBDss9+KOwGD0iUt289iABIqrgeiQw2SH+k/am9pfj8hW4QP7nmHUdgiQemdLztHUN9CFnR301cskNcd8soL2hnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJgXFYZ9wbemLABODh/lNfldKXu+EY5UKueoeWpDyzg=;
 b=Y7n2VyHFYYDW05LHuP5ly2ldiVPA65bkm/xtK2+1vdW6Q4AhRIgJ/U/5OPStT9LfwXwGn5eZiYltNEswFQ8rkNCZ3PLW3luhcM5tSUYxUaMjujR3zRUvdpwkJtshJmWoHDg6KhDvSSuU3jLTov0Gh8zyPnbfAcGCCr2WNl1yhzREJf+nayzvgkXYTvOfmm8r+/LLyqCQ9qEokRpARoSQhPZywxqDvh68D7RPz44IySp3SKRZEBKy25iXyx5Uky7HyhGJF43qhQcuwQc4elQ0Ds8q5rlprx+mhPJhPR4jXEqISdELeGLMPvo39QMS9xiWmmHj7F4LA9Ah3nVn6EDpMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJgXFYZ9wbemLABODh/lNfldKXu+EY5UKueoeWpDyzg=;
 b=alQ0qOQzr5U0LEbBUPOsXT0WrnbLGC7TcepXZKMHiaq6Bndl6WhUMzkugEr9pBuQm0p9EG1QGbCextCn2gIEDXbVJ60yY7NtmoZPjwxYXjo4Ey8PHENrgIjBosPxcgMwXikwD4BCcNX0nZGLg+dYj92zyR8rLMbDC+re9zNnJJM=
Received: from MW4PR04CA0352.namprd04.prod.outlook.com (2603:10b6:303:8a::27)
 by DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Thu, 31 Aug
 2023 15:21:52 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:8a:cafe::43) by MW4PR04CA0352.outlook.office365.com
 (2603:10b6:303:8a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21 via Frontend
 Transport; Thu, 31 Aug 2023 15:21:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Thu, 31 Aug 2023 15:21:52 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 10:21:51 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v10 05/15] cxl/pci: Remove Component Register base address from struct cxl_dev_state
Date:   Thu, 31 Aug 2023 10:20:21 -0500
Message-ID: <20230831152031.184295-6-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|DM4PR12MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0fbafb-4fd8-422b-705a-08dbaa36011b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HRnv7UHe//IKxHTi+EmqhxcjwFa/tYtR6fYEy++r9zW1jy/32sady3aE/gYY2eQF+qJLMRnnyxdmw3eBbKvaiqHFziFS6sFJSO9rSgkYexTJHEqu62csVaywc3+vzpp+66sfC3siX3OiJsftuZCccQVYotLIFgNTto6Opt2Wp+OJ+yAbf1x61bexCRRfEo7uJuXpaxyMQAwraiRi+V5Yzyya8FT6sNKr2ie811qPT3q3vhs06FKn6me2h4jUyVU8RgCm5tZanySvGrepJ1LXP3XFl30U7YiRpP4yxaXbvWekw2lB/iOKwVEzQ9GpbidNQPZszzDY+p7vllNuvo1oYchCzdIKzO6GF8Cr0nIQnWj0G7OyweSelwN8GRnjlnV5VuD+YVFIx5pFpooUxAsPzgfoG20vUhMlZJi5Zpcxr5hp9WDmSD5Tbqkln0gl55eHEfEXa/q9dJcrAVoGp/JnNAKoOXTNlfErnsUXZmslOV1HJR7gR2C1mdb2WGdZelzByl7jqEWx0v+dR6vf28MOQSj8pNP8AcitKz8t90Vzr8kcNEgDARd0qv2V56+3tuKJAM43DvgbKYe81o0HPT8xaw3MtyRbF2sLhg4PWS8AFwpPUy4O2qU56W9kBzNeQZCEv5Lko4Bmw6e4P15tyKeAmIJ+NFYLWgeNfBgT2qWA7zsy7QB4BoAnsppa9pzGx9bdmRUyUFTB+B+yLIeKERqrOc8gYc+FXyiNDIuYocGiEGBrTWUl//O9+2DMDRc7iZW2JMqCpAZCvGlCf6rTaoBSFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199024)(82310400011)(1800799009)(186009)(46966006)(40470700004)(36840700001)(356005)(82740400003)(110136005)(54906003)(70586007)(70206006)(7416002)(426003)(6666004)(336012)(1076003)(81166007)(83380400001)(316002)(86362001)(7696005)(2616005)(2906002)(41300700001)(478600001)(4326008)(36756003)(8936002)(8676002)(47076005)(44832011)(16526019)(26005)(36860700001)(40460700003)(5660300002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 15:21:52.5026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0fbafb-4fd8-422b-705a-08dbaa36011b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
 drivers/cxl/cxlmem.h         | 2 --
 drivers/cxl/mem.c            | 4 ++--
 drivers/cxl/pci.c            | 3 ---
 tools/testing/cxl/test/mem.c | 1 -
 4 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 607ee34b0ce7..fdfa6e5dd739 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -390,7 +390,6 @@ enum cxl_devtype {
  * @dpa_res: Overall DPA resource tree for the device
  * @pmem_res: Active Persistent memory capacity configuration
  * @ram_res: Active Volatile memory capacity configuration
- * @component_reg_phys: register base of component registers
  * @serial: PCIe Device Serial Number
  * @type: Generic Memory Class device or Vendor Specific Memory device
  */
@@ -405,7 +404,6 @@ struct cxl_dev_state {
 	struct resource dpa_res;
 	struct resource pmem_res;
 	struct resource ram_res;
-	resource_size_t component_reg_phys;
 	u64 serial;
 	enum cxl_devtype type;
 };
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 317c7548e4e9..3af3218ebe0e 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -49,7 +49,6 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 				 struct cxl_dport *parent_dport)
 {
 	struct cxl_port *parent_port = parent_dport->port;
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_port *endpoint, *iter, *down;
 	int rc;
 
@@ -65,8 +64,9 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 		ep->next = down;
 	}
 
+	/* The Endpoint's component regs are located in cxlds. */
 	endpoint = devm_cxl_add_port(host, &cxlmd->dev,
-				     cxlds->component_reg_phys,
+				     CXL_RESOURCE_NONE,
 				     parent_dport);
 	if (IS_ERR(endpoint))
 		return PTR_ERR(endpoint);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index f8ad601b314e..b71f1c7d16ce 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -835,7 +835,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * If the component registers can't be found, the cxl_pci driver may
 	 * still be useful for management functions so don't return an error.
 	 */
-	cxlds->component_reg_phys = CXL_RESOURCE_NONE;
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
 				&cxlds->comp_map);
 	if (rc)
@@ -843,8 +842,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	else if (!cxlds->comp_map.component_map.ras.valid)
 		dev_dbg(&pdev->dev, "RAS registers not found\n");
 
-	cxlds->component_reg_phys = cxlds->comp_map.resource;
-
 	rc = cxl_map_component_regs(&cxlds->comp_map, cxlds->dev,
 				    &cxlds->regs.component,
 				    BIT(CXL_CM_CAP_CAP_ID_RAS));
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 464fc39ed277..aa44d111fd28 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1423,7 +1423,6 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	cxlds->serial = pdev->id;
 	if (is_rcd(pdev)) {
 		cxlds->rcd = true;
-		cxlds->component_reg_phys = CXL_RESOURCE_NONE;
 	}
 
 	rc = cxl_enumerate_cmds(mds);
-- 
2.34.1

