Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C76C7B092F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjI0PrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbjI0Pqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:46:45 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE34327E69;
        Wed, 27 Sep 2023 08:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlrIjCaF05MS8xa9+C9lSRihP4W34BMV5Ggw8ffQpC27eBnnSBwn4bP5zqVLP17aW9FDsH1dlaSq0TSTLykYPtmNznbgyYCbgiQghudUpTA5F6wq/dmT3MYoMvq9TT9G6IWChGNv8ztuI07tzsmKWq2pSNuOyMRcAza3TG/iYOA4R/b4i+zjYPVfXX0owckLCwxpkvOkqRnCTIEI+OO0l7hK3hwb9FR6tMXz9EXeiEM3+P2StQ+GIZipIEsiGxKyP51X04/YpGdHhqpDiHJa2uLuPwZmcYrt6cEDUihgh3Cw6HbiUutFo8I4YyLvknf24PsRuXl18AqVChc3zsc5Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSvQupq1zPeqA9EIKfhGUCfDPjvZA5Z8vWp/24P1mRE=;
 b=EshqzMuKxUwEq5ndtaFQQfPUXxaarIdX+5ZjDYLSZdw1pUp2Z/4+a26g5FSBvvEifapCy4lb1A3rokU+QO+6YLwF7uaFQRc4D4JQZA7W/kkaeL4tLWWyAsVXAG2WtvibzREs1Q0apsq+iFBBZaBb1JCg4vxzhyURySYaYikEe6yV+HN9qi6mxPadKTwgy0nBBC+UQhHnE1HOHQdnL6xFykjHVgbgbFL/V/MLXw1n+crYCMmHybdsohDg8qTgYegToKaKqlREk0xUtyoOed/aSFkdiDUD99+y3h00DuxNxK/1bhkROiLx22cArq8JnPjPcXYgERWGBGi7cgAeVkFydQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSvQupq1zPeqA9EIKfhGUCfDPjvZA5Z8vWp/24P1mRE=;
 b=OGApwNR8NmCpcYTYahYKsBjSjT/Fk5lZcKM3JuhwBDsd0Bi1GFvCCIx0KiNBC0uyVwBXHpeky5E5ZaUGuW5TiIFQgq4mj8L9LRCsH3+/ZEfdY52LeoGL/HsZRiEMVICFq7I8YUr188DCyHrkXlsqusVqy2X6w+Fdgq0LC+QP7Yk=
Received: from BL1P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::29)
 by DM4PR12MB8473.namprd12.prod.outlook.com (2603:10b6:8:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31; Wed, 27 Sep
 2023 15:46:33 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::72) by BL1P221CA0016.outlook.office365.com
 (2603:10b6:208:2c5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 15:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 15:46:32 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 10:46:24 -0500
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
Subject: [PATCH v11 08/20] cxl/pci: Remove Component Register base address from struct cxl_dev_state
Date:   Wed, 27 Sep 2023 17:43:27 +0200
Message-ID: <20230927154339.1600738-9-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DM4PR12MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a55cd0-b1f7-4ab1-183c-08dbbf70ec86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rkIQ0wzEAGE5vcikJ1GTdJ8zLimFE11B7w1CLwQcxmv2qTkrr2sQr6zTw6EXH58VpheUVvnwN3y2Mb9iK89G/clOwoFmGz5XqjNuq/PyQy8SWvfcQwIN7u1/7YqV553NM31MS6/dTjQr02S2lzi5Sd5tljFU83GxG9KRUujQ7cuKDBjrbE84IYyzMqB/snC/NVmvyhZXvB+IIY6izsGAuaRt6TZ9u0mpGyP3xB0PvdRi2VF34zcVf5sib1vrsFQTMSaCWO4nokXF5APoCAPkZqY84Tp3mI1AW7GmQFB6oSp3YqYYlm2ZI3x8IgfOd6lILquxg81cryStIzbRqppaa4DUIcSC2kRfYqTqqP5s9LC8aA2nfM+P51QkVSrI+iwhwpjguXRlYIdaWB3UbHJUik4GIkSW0QV6lQX1Wjvm7lN5lsoEZk354lO8Xk201GTy12V3dZ2Yt3ZPnTfLpQbG3fXNfcgIZ/s2TbAWxzdDklaBG8RytBlC2SdIVE4GJBz9aP2fDhC4mkYcOmqbFMlTSvxsIRFQX0z74dRdw9vKACGLxrItIKUzG8kCGNgxKss79NZiuGhCbW0yFrdqXAHbzeH1yc7DLZBv1ofsGMe6HXDO/TMdg3azVxbvS9huJMzXJSOLaa02KAf4vluVwAyH9XY6dgrc9z+RZCmB2P8Pjx1O27TCBth2M9lurDT2SyHzwmzXKOYerUREwg2QQrbfYnbHWcC+J0jtMTeFfQIGwcqDMPOStvQRu9ggqI1UqKG/irvgf9cyGlQVeU1mOvISbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799009)(82310400011)(186009)(46966006)(40470700004)(36840700001)(356005)(40480700001)(82740400003)(81166007)(16526019)(1076003)(336012)(2616005)(26005)(426003)(8936002)(5660300002)(4326008)(7416002)(8676002)(2906002)(70586007)(41300700001)(54906003)(316002)(110136005)(478600001)(70206006)(36756003)(40460700003)(83380400001)(47076005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:46:32.8041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a55cd0-b1f7-4ab1-183c-08dbbf70ec86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8473
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Component Register base address @component_reg_phys is no longer
used after the rework of the Component Register setup which now uses
struct member @reg_map instead. Remove the base address.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/cxlmem.h         | 2 --
 drivers/cxl/pci.c            | 3 ---
 tools/testing/cxl/test/mem.c | 1 -
 3 files changed, 6 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 8fb8db47c3b7..cfd287466fa8 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -405,7 +405,6 @@ enum cxl_devtype {
  * @dpa_res: Overall DPA resource tree for the device
  * @pmem_res: Active Persistent memory capacity configuration
  * @ram_res: Active Volatile memory capacity configuration
- * @component_reg_phys: register base of component registers
  * @serial: PCIe Device Serial Number
  * @type: Generic Memory Class device or Vendor Specific Memory device
  */
@@ -420,7 +419,6 @@ struct cxl_dev_state {
 	struct resource dpa_res;
 	struct resource pmem_res;
 	struct resource ram_res;
-	resource_size_t component_reg_phys;
 	u64 serial;
 	enum cxl_devtype type;
 };
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index a6ad9bcb96b4..037792e941f2 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -834,7 +834,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * If the component registers can't be found, the cxl_pci driver may
 	 * still be useful for management functions so don't return an error.
 	 */
-	cxlds->component_reg_phys = CXL_RESOURCE_NONE;
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
 				&cxlds->reg_map);
 	if (rc)
@@ -842,8 +841,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	else if (!cxlds->reg_map.component_map.ras.valid)
 		dev_dbg(&pdev->dev, "RAS registers not found\n");
 
-	cxlds->component_reg_phys = cxlds->reg_map.resource;
-
 	rc = cxl_map_component_regs(&cxlds->reg_map, &cxlds->regs.component,
 				    BIT(CXL_CM_CAP_CAP_ID_RAS));
 	if (rc)
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
2.30.2

