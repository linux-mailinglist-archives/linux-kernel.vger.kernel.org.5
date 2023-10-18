Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50FF7CE487
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjJRR3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjJRR3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:29:04 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3F5125;
        Wed, 18 Oct 2023 10:18:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klc5xN+z16UErMyr6tlekb7YVhicpJobOqc3RFLZlPX2azczkPau4cqRvXqzsbJuz8xB/JRm4a2GCAN/k8erNaFHX8M/h3X7ZboXw33atqkxkxRwsxnDHrlTFKH38372EP/eO0A3TODcRAlM5N9BH+UFt6yA0+6aXAQjyiQ0vchQdHgPgMMALywFiBKNThXysWudsilUQlIJYnCH21j8Vqeow/K44uus4PBLTyoJDHDWHjVbq+pTUB72RljNisVPfa8QvKtS5h7Ws8p/T1PSj5NbJ+gf5nyOHlZhggXibKF55Vb9M83LGJVH70AJmCqHX4r9qTlyQjorVIcRV60s/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zofwanr9EnIyAP+3VCdaF9SXvWA2UyDJmk18Yhfzufs=;
 b=mR/ofD2Az+LPBZcWwuq+4u0jlog2g06pXMan+eAdDsZCgcRWCQVL7eltgAuG5RFVHRj7nYZWIcbQ4KFF4d8Rxp0nHFUw79+uclcgVgCcSaLDQpBQKLMAP8SxZj1D2AbR7oKi1LPl6O4QZfQCO48KmnsE7Uryz5YEzmto2re84Bx//3DIvlVHbTV+kUlNg7sthl4D/xwX9S3h0+EVuGhCESJ+709P4zZfdKHkoKB9wqtDvYuMNUle93mJeH7n8e/MmT+Uz8mr1FfBrQjHi0mg3AJ3NSx5wfHwHwdhdm3SCNB8ca7+tm+s5aYd3QkfBayz6rJm9HQsTWwqpQFvSYFzXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zofwanr9EnIyAP+3VCdaF9SXvWA2UyDJmk18Yhfzufs=;
 b=djHaFSO33Gsq+ULsuK1tjsG2u0Q76ERpMHO1za7vDjqpqHLFULSgN9dlgRXBiMD6mbeOPnfrP6oZVmmqgkydH5mNA2r7/z6I20f1WuxQQQiUc3PVLuBqdLbcHTrBERhOf1IHFSjjawpVY62DnUi0tqfl8aELRvmprijosrUWrgQ=
Received: from PR1P264CA0048.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cb::14)
 by DM3PR12MB9286.namprd12.prod.outlook.com (2603:10b6:8:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 17:18:53 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10a6:102:2cb:cafe::c1) by PR1P264CA0048.outlook.office365.com
 (2603:10a6:102:2cb::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 17:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:18:51 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:18:15 -0500
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
Subject: [PATCH v12 04/20] cxl/port: Rename @comp_map to @reg_map in struct cxl_register_map
Date:   Wed, 18 Oct 2023 19:16:57 +0200
Message-ID: <20231018171713.1883517-5-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DM3PR12MB9286:EE_
X-MS-Office365-Filtering-Correlation-Id: 087203ed-b6d1-4f61-fe82-08dbcffe4cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pe35DhKpgQq0bevfDC+089O9R3X8Wfnl/XH0GEwlQLmjkcLWNPM6AS4FC4oRJxGDtkyy+bvc9HYrnM+U5CMWhlmYRg+eIJZxaIw8eM4KWXfwlUaeJ1zODoMc/QCaTmwwnaf2TKVg3aEMLHH73vPDqbtaXWy5IMYUiVLKmMrqSFLM2zAb0uy/LA9v2FWf0On0OI9Wj+i7pb8rrt4+E7UeX5oXDJQfxaEgTnotn/hPBS4/aCf2WeIdMlJGv7xBEUcQQDVXy9W3x1EZc/ccbTGb+PoZkqSKPvkHM7x1O8ZbDPNG8e1jp9ONn5yE7xpXQey+B9pDFLUJX98u0ZC6evuMXxPzhKKaSMRfAujaPKrCP9slCx3qPz0qmw3PRVcUmH9XR9QUyJSfz9Z+Id8ZtbD5Xd74RBCKml0Qa0XwB57nBe2WVG3QIZmBN7K51w46Ho46feQ8Gtl6ys4WUsWnxo2eXcy5rtXTIBC3wNgw7837QXfiFxRVhe0xkAO248CwAIgSuoY0dq+RuysSWIP4WJsttN8e7rjFHNuN6fNxVwBbkGTbExfpJP247pa1NpaaZPZ0s/loIA9yfk3ntbyzDYiTDxQubYt0Rx/or7NlvghY9nCU8BN1j5NTe3yzq4a51JCPV4cs8bvjMzEz9AkLUbMrBtmRW7FzxoONwTQY/4Bq1AxyzaEVzZaehqNInIVIpJ3pt54Oq/ZFI7HK8eoYhahLm9ZrHuB2wTvZrVMlOtaRXunaus3vopurS8PB9ytn1jGNXzAHOYYAJ5P1kh3phQcPGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799009)(36840700001)(46966006)(40470700004)(54906003)(478600001)(70586007)(70206006)(110136005)(82740400003)(47076005)(6666004)(316002)(5660300002)(8676002)(1076003)(8936002)(426003)(16526019)(26005)(336012)(2616005)(4326008)(40460700003)(40480700001)(2906002)(7416002)(83380400001)(36756003)(36860700001)(81166007)(356005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:18:51.8529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 087203ed-b6d1-4f61-fe82-08dbcffe4cbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9286
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Name the field @reg_map, because @reg_map->host will be used for
mapping operations beyond component registers (i.e. AER registers).
This is valid for all occurrences of @comp_map. Change them all.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/port.c | 6 +++---
 drivers/cxl/cxl.h       | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 9b1136018f18..b993dea61436 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -712,7 +712,7 @@ static int cxl_port_setup_regs(struct cxl_port *port,
 {
 	if (dev_is_platform(port->uport_dev))
 		return 0;
-	return cxl_setup_comp_regs(&port->dev, &port->comp_map,
+	return cxl_setup_comp_regs(&port->dev, &port->reg_map,
 				   component_reg_phys);
 }
 
@@ -729,9 +729,9 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
 	 * register probing, and fixup @host after the fact, since @host may be
 	 * NULL.
 	 */
-	rc = cxl_setup_comp_regs(dport->dport_dev, &dport->comp_map,
+	rc = cxl_setup_comp_regs(dport->dport_dev, &dport->reg_map,
 				 component_reg_phys);
-	dport->comp_map.host = host;
+	dport->reg_map.host = host;
 	return rc;
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b5b015b661ea..3a51b58a66d0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -572,7 +572,7 @@ struct cxl_dax_region {
  * @regions: cxl_region_ref instances, regions mapped by this port
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
- * @comp_map: component register capability mappings
+ * @reg_map: component and ras register mapping parameters
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -592,7 +592,7 @@ struct cxl_port {
 	struct xarray regions;
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
-	struct cxl_register_map comp_map;
+	struct cxl_register_map reg_map;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
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

