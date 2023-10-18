Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33877CE4A1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjJRRby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjJRRb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:31:26 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B403AAB;
        Wed, 18 Oct 2023 10:20:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkZoxab54vQbnOAQKGIUzbuuv/k5pqVU2bThBS5mLm656mn+yCwxjFcsDAvRxsmkoH4rwlfN/JI2+g3iAG0W5RUH4ngbmLvF+t9fkqeaqrqxYLTgCppFwyROHBz8iMU4dMCuIHw4Kqi1LTMmCG+vMnJ27xfXVI4sRLg7gLfM/8lBtZJoonmGnXn1BaY7FH/jqBpbYA4ECZH7Tk5pEhbQBHwJ8bKb2yfXxlHNhRgsqAZSwJPuNKPy7lRW5ynqcCnWSsdadEmP79gK25jDUTgTwaCGXNn6D9mAUrdjbEV1Bbml1WynnXm7sD1cL8xjy39HBg+8TOD+ljMmoU1TKtrpyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sDEWl2jwqd1G2P3lOG6nRF+RXcG5Z8R7T0UdFKmmd8=;
 b=lkKrMC2NX9TYCb2DPCohkx7nIvHnHbt+z0IDplteih10s0YnpLOhajpkL3MSEWoz99fqHuBe9BdngP3Mqdj6s+zYJVsGoGkPZB3W3QFmh7CrL0+6sXy1YHkPzhhU+3r4WVfu56J7otCYhOCuPaEqxA6TXRO6MCBYa/ZpVovXGv9tTI9FGvbxWUolELhV3nSDQuR68zZVcWVgEXetn6HG2xgbOp/chr85weg0PCB6qXivshV+xBmtks2VTy9AoriYlZ/lWdbgO7cHAOqX1Z+dNWLdCN+2jq6DS8HCuSWraavqppdeLD5TcfyBUsky49lpIk8hjk1P+qVjM23VE51oAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sDEWl2jwqd1G2P3lOG6nRF+RXcG5Z8R7T0UdFKmmd8=;
 b=FwwgIzSH7947WaQwfV8On3ZjO1iUVpoC9rT2IBcvtB+sHC+AQUce1J4uyQ3T8z7dq6XwB4T6V6LO247TlRsN1zOPXWV+jY6NXZgvsAK3FdUA0L5Y+XE8zP5DjfuMH5/c7fGdmyYqCr5qtvCR9QyUQBwtVECK4DG8iXtzGZM6YjM=
Received: from PR0P264CA0185.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::29)
 by MW4PR12MB6801.namprd12.prod.outlook.com (2603:10b6:303:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 18 Oct
 2023 17:20:51 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10a6:100:1c:cafe::f3) by PR0P264CA0185.outlook.office365.com
 (2603:10a6:100:1c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 17:20:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:20:50 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:20:45 -0500
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
Subject: [PATCH v12 20/20] cxl/core/regs: Rework cxl_map_pmu_regs() to use map->dev for devm
Date:   Wed, 18 Oct 2023 19:17:13 +0200
Message-ID: <20231018171713.1883517-21-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|MW4PR12MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: c37b7886-d943-47ed-ddf6-08dbcffe9362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n4VbFb7QVSD/M5CFFraPyCgrovq80Mw1TaqD7dmjLRk0g69t4ilPQr7OzEbsuaMp7+8xbWKQQkMjVgpDjysFCQU4OE94oDAjt2xDLBLS0n9aOtU8kStwLn3XJicmUZpygmkXWNzxVBxzAZ2taE6OFOe/liT/brZxL38u/vmis3hvAAgcSr2tgT+ZQLiihzW3LmvEuOrnVVlmxkHye7GeFRcCYkR8catAOdBgR7rbu3P7j6DPrGKCOVtR1SbH1Usci+UcPn2YflHRZv0TOF5h/Kfh2eIpwXIk+ikU/BxfbU2fYxmJXTUNDVTyUpM5jb0BRYwTETP8GjsI1p9tNyNp2EcQRf4GtXbv9gXs9VdVuTfRMK1hjUqBRiFtuO/MpqvudsEnhB+XMrPv+3pvOWnralikJVkop/ehlc98Fr0fcL6FUUoIgPpHQPOkqEyg4iVCX8fH/qCOW9BumFV72DoVDO7BVD/DWCqQl3zgWy4rzL9tuc8XbAQpuy21qsmhSy0CMao0JsaLvJtAWvXfGaVT2mqAvxjIBIcVFxFAyoVm8QGzJ4xHdxncLTwAk76ctOC0ubSqxeTz6teHlgWAglvbi08AMW6Fh5k79ywZQgJoZwIpDpSXQkK15Y7+RTXQTj1/DY6YeNsLAGr9c1WLoX1UE5XRLqEFO/Q1dpugOXVhZDSoV8pZZLjI2yEKENXnyXw6f6zFpY93yyVpnPH7xaoy8rr/xD4QB56fpNVH7FxwGHMCtu/uVUbXZp+Mkn9LD1WFFLV6o6bDYnnLIX83Hv1Raw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(426003)(6666004)(41300700001)(2616005)(1076003)(2906002)(82740400003)(81166007)(36860700001)(40460700003)(40480700001)(70586007)(356005)(36756003)(83380400001)(7416002)(478600001)(16526019)(5660300002)(336012)(316002)(47076005)(8676002)(26005)(4326008)(110136005)(70206006)(8936002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:20:50.3804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c37b7886-d943-47ed-ddf6-08dbcffe9362
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6801
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct cxl_register_map carries a @dev parameter for devm operations.
Simplify the function interface to use that instead of a separate @dev
argument.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/regs.c | 5 ++---
 drivers/cxl/cxl.h       | 3 +--
 drivers/cxl/pci.c       | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index cac28a656cb8..372786f80955 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -386,10 +386,9 @@ int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_count_regblock, CXL);
 
-int cxl_map_pmu_regs(struct pci_dev *pdev, struct cxl_pmu_regs *regs,
-		     struct cxl_register_map *map)
+int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs)
 {
-	struct device *dev = &pdev->dev;
+	struct device *dev = map->host;
 	resource_size_t phys_addr;
 
 	phys_addr = map->resource;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3b09286d9d52..378fc96ff7ff 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -286,8 +286,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 			   unsigned long map_mask);
 int cxl_map_device_regs(const struct cxl_register_map *map,
 			struct cxl_device_regs *regs);
-int cxl_map_pmu_regs(struct pci_dev *pdev, struct cxl_pmu_regs *regs,
-		     struct cxl_register_map *map);
+int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs);
 
 enum cxl_regloc_type;
 int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 037792e941f2..fa94bc61af25 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -898,7 +898,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			break;
 		}
 
-		rc = cxl_map_pmu_regs(pdev, &pmu_regs, &map);
+		rc = cxl_map_pmu_regs(&map, &pmu_regs);
 		if (rc) {
 			dev_dbg(&pdev->dev, "Could not map PMU regs\n");
 			break;
-- 
2.30.2

