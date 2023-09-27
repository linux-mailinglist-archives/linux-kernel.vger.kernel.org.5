Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE437B0936
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjI0PrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjI0Pqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:46:49 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801A6272A8;
        Wed, 27 Sep 2023 08:46:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmDz+wCtgqb78oPCJDgtoPpw0XHVzKASqNvKsBnYSK7oIeiKLHqonMHX9dZD2dU5Dk7yTAoU9OzL3G0tv5rh4pV1AThlCXyCiIRD1rH4Rs0jkZuTYX1C8oxFX10e3k7KPm8tVrAvxHn7MZB/H7X1396dPxOxnb72HTAfZeHHiNEu7zBT79NWgwZS7fSL3wAVq2+9Fhy83zegQwF23VXIHUlCWaSMAO/iIzf8m4WjLCnVYjJidCLBp+O+9braLlGQ6s/GI6IX1fJY1mGnsZRZM8t0zm33pPFmCW0kGOstJMOX4n4GF/8tOZ9/XQLT9Z0/doCEHPoZcnx51VwRLl8+0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=px4409r6wH4IBLaO/0okdND7Zx1wNoGFuXLPiOws6TA=;
 b=Oe0LQhG6gqvq503j03qmyUj6948aHx+YxYCsZ/RdHA8cdLeonB/ZrLBQW+YScJfskd5gKtvXcqUL9yr4gkVTgCV7FkYhe45S51v6b5bzyI4iosxjYA3GKJ3SV7ranhQF0sflNNGZe7c4MtLBd7XGQrbi8+2w0uR2JOCWK5c/x02QNU8UYGOBiNliir3q8ucSK1PVDvKb8bOfvLjnvhP5Gr3NrmJD7hLNIJu6V/5znrFBwooaCSWM2UzMqANve9RMH2FR+tjiZNHdpEfrK0B/jI7Eb69fSGahcSM+GEPTg2ZwBzKZJOpafSt2fBbmXxgHEfAQQ6pQQmEl1M7HlI95gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=px4409r6wH4IBLaO/0okdND7Zx1wNoGFuXLPiOws6TA=;
 b=GVBwVemrSiCRxM649bD4FkZDawkcgjHp/rzfv7jY8VEUiS7fQ2rkIN5clSnA/cMVaSYw2FFxqiKkLDnv0nmr7X8J64hQy426KienQgYnuFbgAMurn9a1XN2e2jnkigV7LcKFwNCcfDc/akwFnDlmv2tIL/6R8gThYZWDekNo6ok=
Received: from BL0PR01CA0008.prod.exchangelabs.com (2603:10b6:208:71::21) by
 SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Wed, 27 Sep
 2023 15:46:41 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:71:cafe::29) by BL0PR01CA0008.outlook.office365.com
 (2603:10b6:208:71::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 15:46:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 15:46:40 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 10:46:32 -0500
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
Subject: [PATCH v11 10/20] cxl/pci: Introduce config option PCIEAER_CXL
Date:   Wed, 27 Sep 2023 17:43:29 +0200
Message-ID: <20230927154339.1600738-11-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: d784b6d0-dff8-4f77-ad82-08dbbf70f14c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /JOivBgTwJ3RNjkiDlFI6d86eQrp3W4gzlKp+WdrmLGdZNG1LuGRmUMhPuBp6sbQHChdHYpY9aXq2hbY3ySC/8Fj5Jb6bRSbGEyJn33SO8QquZyOgUQJJXnfS2D2zHE7hvEYJ57RhwZ1sq44ZygCYMAPOYi4Du8a2hi3PAIff0BT25TDAzTOnpwbQRU/qazt8xxzx+HPPiSXVZ0K3mH+RG2ggiwJ8qos25KjCkfr76YxPV0nzkiGBI++0bjt4v4dnavTD7KJZ1u8RDzsJosnz+0dC2PpZsKTRGoSWEGoNcy+WkKkypFchA7zvJZhqj1tcP0gHs47xdpPCgQt+kIdnQRC/MjL6/zzg2nkfbzi6y2X0Or72oitG/QA51UmTMKWYXlmzlXgM8j2Rmlj5PlZ1hqpQwz9iJ/y9vuAubN3/BaJl9k1ZXuqd+MsuKY9WslGSx4buNpXvpWspUs6bFv2DQVVNPXJXPkx8IqJBe9srse4B81DkP0uV9F/QTNxp5xOUWrC+w/WvbI5pNzqtTuAk0g5JGU7IIi2o7vFtWvX0JwLEHoxumh+9ryqgSeqQQTgWVpmTNIo98cvrq2xrfN8mHbeiY4tmSs8dIZkIRtb5ARF5tK0muxGn6BP88KRSH+Hh4Y+HLt3qes880BwlGx978K+JRt/NnoPWFDIJ7vQFF2rRLwR9OO2CFSLpg8C471GtNx+SP94JFE+Brir4AT/nIgiQD46jh7HnZvZ8h424GdDPHyyeXz85ay+VR7kn61YAjp9xcMj3ptvwcTkSw/F9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(46966006)(36840700001)(40470700004)(41300700001)(47076005)(36860700001)(54906003)(5660300002)(70206006)(70586007)(356005)(82740400003)(81166007)(7416002)(4326008)(8676002)(8936002)(110136005)(316002)(83380400001)(40460700003)(2906002)(336012)(478600001)(426003)(16526019)(40480700001)(26005)(1076003)(6666004)(2616005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:46:40.7383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d784b6d0-dff8-4f77-ad82-08dbbf70f14c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CXL error handling depends on AER.

Introduce config option PCIEAER_CXL in preparation of the AER dport
error handling. Also, introduce the stub function
devm_cxl_setup_parent_dport() to setup dports.

This is in preparation of follow on patches.

Note the Kconfg part of the option is added in a later patch to enable
it once coding of the feature is complete.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/pci.c | 9 +++++++++
 drivers/cxl/cxl.h      | 7 +++++++
 drivers/cxl/mem.c      | 2 ++
 3 files changed, 18 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c7a7887ebdcf..6ba3b7370816 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -718,6 +718,15 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
 	return true;
 }
 
+#ifdef CONFIG_PCIEAER_CXL
+
+void devm_cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
+{
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_parent_dport, CXL);
+
+#endif
+
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c07064e0c136..cfa2f6bede41 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -704,6 +704,13 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 					 struct device *dport_dev, int port_id,
 					 resource_size_t rcrb);
 
+#ifdef CONFIG_PCIEAER_CXL
+void devm_cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
+#else
+static inline void devm_cxl_setup_parent_dport(struct device *host,
+					       struct cxl_dport *dport) { }
+#endif
+
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
 struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 04107058739b..61ca21c020fa 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -157,6 +157,8 @@ static int cxl_mem_probe(struct device *dev)
 	else
 		endpoint_parent = &parent_port->dev;
 
+	devm_cxl_setup_parent_dport(dev, dport);
+
 	device_lock(endpoint_parent);
 	if (!endpoint_parent->driver) {
 		dev_err(dev, "CXL port topology %s not enabled\n",
-- 
2.30.2

