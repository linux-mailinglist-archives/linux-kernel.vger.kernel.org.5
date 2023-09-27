Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6EE7B0A45
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjI0Qc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjI0Pq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:46:27 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20AC272B2;
        Wed, 27 Sep 2023 08:46:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxYdD+sHgkVKWhgtwNGbOsd30IuKiUol566V9+iCA5p44Y/nxUajnhQpDz0MvnwWNfqeyhtpHUIV+Xh738/q1w3MqJLRDSQKcV8WMlGXB5jQqlVLCfoN2qo6tA2Fpl9Z5XWYbRw5VZRIyuDXcbzAMdnGBwQZlFozHuyQEf0ghZHfcfPDQUO4RR9meoharNhUQ/PGILL+hrEEZPjGn2o941vmVg/cEb03xHLGHhtti/19zIsMxP3o8WZ65Q88gy2WJ6m8XtCSjMTrweCM5mmEZV9Hxxjo+EMPD9zfbtMwl3tlbB+dDzDfP6MAJ+UyXxRmrng6I9dsMROvmHu8vvGY3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeD0TqmjlVXjKVielApkR5g5JE+54c6o6acRDdh6RsY=;
 b=ZBv8a7mGtM4favqv7rjGzbuf9Jfrf7aBgR3vmkf5SvLVT1KWnl4/6UP+oxVVWRgqXZ7a72iS7c49mtr+99n9C71eEhNOJMKvGj4mCXxSKedb5EbzQfRkmux91yGeCYvoNruccMsxcFtqMoP7YNP8aFm+fCLeuojTuADobjMijRoIxZaqBR89iCR1AuzIO8TsEd9RUZlDoxS5GxPkUbtU6MrIn9lwasuxq58FfYYdiQ4N6sKkNb6hDjlLEGsxVMe1sOBQNhmIiMloYA/OyaDviwOIXyeOwVs3wKkC+OnOFuESrITZb0QE0ind+1gyj08BHLx8oBLBCWwtMt112OpUxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeD0TqmjlVXjKVielApkR5g5JE+54c6o6acRDdh6RsY=;
 b=4+LdzF3HKdoTTYAr6KsYKDcjhwjC9s2BsZJ+1rFRX7lpQYohte+VXW7p84JZlFbaqg+qOjEVgd3QBKwWQssHovRbCm+334W+vwmRy7aBjWD76Lsro+MNWjsd7bWBwFTm+kEC22aIEy8j/lmzQwtDqhwiO2OHmMuxyIZiUps+3gE=
Received: from BL0PR0102CA0049.prod.exchangelabs.com (2603:10b6:208:25::26) by
 MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Wed, 27 Sep
 2023 15:46:20 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:25:cafe::9e) by BL0PR0102CA0049.outlook.office365.com
 (2603:10b6:208:25::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 15:46:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 15:46:19 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 10:46:16 -0500
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
Subject: [PATCH v11 06/20] cxl/pci: Store the endpoint's Component Register mappings in struct cxl_dev_state
Date:   Wed, 27 Sep 2023 17:43:25 +0200
Message-ID: <20230927154339.1600738-7-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|MN2PR12MB4255:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d32f5b-2662-409e-3a33-08dbbf70e4df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xbdk+P28Rz5Ld7UZ8aL/3rPJoU4E9gZrFJtodjkytVaLSk+vAh4S5LWBASCR0tojU78OQCPEpQZDndAdweyBxI4ggcMt463FuVM7HX1aVEpDeVhZPu760LYNOaSTMd3qa9i+/aUsg3+Kdic6GRK1foZfsOlmbNCB7o9Soe+A0oWBMeD0v4OV7y0zUoK+clpbC2vm9WS129YT+3To2aZVkim7ykqZwCoHHYdGTz+n860fm6RchyeAQ5RMbpXQBWIJvuzvwdVzPhgjwnR7fzzKa5Gh3EULvzNdUtLWgF4Kwc+2/cH6UbO1kMlqnWdic+4HAep66va6vH1XDqSLCNlcdJ9trNjfpKKjlWDCsEVrRaVHAHsPlnT6Yi+KsDfeLg4xlC2kNMSW6D4UKbf3hbqdQ4m/6QkhWSXYE1+Y5mYFHF5vz7hTsY4UU4ddepAp+z3Ez3pqczG6DEHmbFqBL5+ZikHwm+4i7GfGWb8+OYNzdz0r+7WvcZTl5HjAhW7zEB716hS3fBdepu60kxCge16e6LLMTHUqNgDxHaUnlb+axBNvprxwcswetLHicfjo3yqJaCX78oSalPJ5Ic0NqyY6Sev+N80qUc8AhQpQiSFfr5iWv06Pf0i5f2ahV8BZrkqD2sA+C9uMsSPEDDXHfKoDuO7i4NvZAuf+HD98FySMo6naN3DtVk+TQwFvjwPnwwuPcEK6GAVcNbqj5eQff8YAw1+Yca1wIR4Hi6u15XUOZ2JhawT72ZkCmF515ik0FQt+2X8YKmKu+KeYKvdXFTSypQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(451199024)(82310400011)(186009)(1800799009)(40470700004)(36840700001)(46966006)(2616005)(26005)(16526019)(1076003)(356005)(83380400001)(36756003)(81166007)(82740400003)(40480700001)(36860700001)(47076005)(40460700003)(336012)(426003)(316002)(54906003)(70206006)(70586007)(8936002)(4326008)(8676002)(5660300002)(41300700001)(110136005)(7416002)(2906002)(478600001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:46:19.9665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d32f5b-2662-409e-3a33-08dbbf70e4df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same as for ports and dports, also store the endpoint's Component
Register mappings, use struct cxl_dev_state for that.

Keep the Component Register base address @component_reg_phys a bit to
not break functionality. It will be removed after the transition in a
later patch.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mbox.c | 2 ++
 drivers/cxl/cxlmem.h    | 2 ++
 drivers/cxl/pci.c       | 9 +++++----
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 4df4f614f490..7e1c4d6f2e39 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1377,6 +1377,8 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mutex_init(&mds->mbox_mutex);
 	mutex_init(&mds->event.log_lock);
 	mds->cxlds.dev = dev;
+	mds->cxlds.reg_map.host = dev;
+	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
 	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
 
 	return mds;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 706f8a6d1ef4..8fb8db47c3b7 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -397,6 +397,7 @@ enum cxl_devtype {
  *
  * @dev: The device associated with this CXL state
  * @cxlmd: The device representing the CXL.mem capabilities of @dev
+ * @reg_map: component and ras register mapping parameters
  * @regs: Parsed register blocks
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
@@ -411,6 +412,7 @@ enum cxl_devtype {
 struct cxl_dev_state {
 	struct device *dev;
 	struct cxl_memdev *cxlmd;
+	struct cxl_register_map reg_map;
 	struct cxl_regs regs;
 	int cxl_dvsec;
 	bool rcd;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index f9d852957809..a6ad9bcb96b4 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -835,15 +835,16 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * still be useful for management functions so don't return an error.
 	 */
 	cxlds->component_reg_phys = CXL_RESOURCE_NONE;
-	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
+				&cxlds->reg_map);
 	if (rc)
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
-	else if (!map.component_map.ras.valid)
+	else if (!cxlds->reg_map.component_map.ras.valid)
 		dev_dbg(&pdev->dev, "RAS registers not found\n");
 
-	cxlds->component_reg_phys = map.resource;
+	cxlds->component_reg_phys = cxlds->reg_map.resource;
 
-	rc = cxl_map_component_regs(&map, &cxlds->regs.component,
+	rc = cxl_map_component_regs(&cxlds->reg_map, &cxlds->regs.component,
 				    BIT(CXL_CM_CAP_CAP_ID_RAS));
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
-- 
2.30.2

