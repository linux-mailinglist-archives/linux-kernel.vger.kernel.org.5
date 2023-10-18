Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153BD7CE491
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjJRRaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjJRR3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:29:50 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55630324B;
        Wed, 18 Oct 2023 10:19:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7hgNMDo/E/SzLArtt2/3jeMzuGzGL2Y8Ko0d+zoqD8zoKed+7hg6YW+8QgZWC7CdCgXQtAjplIZgCKlOUMaqOe7VDheNJHowob5PlMxEX7ro0dBd37XYbC4pmIwXxwSPb+d+vk2Iv0rvQYwIo2KKimD3V51UsTd5VthS522/t3AqThX7ugdFql9IMdcJd5Nob30762yns5DpIkM3jhXVDW1BHk6np4WmhsQGcGPuwzosV3H2bw3Xni3KiV3qSu6mbQu4p7EjvRzflr7hfvPONJbzTduxYn9wYy92f5NPxEQGdoRJx1VmvhH4vGQ9yuvzMUL0Cw9NmLAWozxXonaBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HBEJ0Wnnrej7ZFG4v4zI4otawjUFMMAynClT7d6q2I=;
 b=MeH0BjSpwUsuy0zrfUSsX36eiXnKx+aIHF+rF4jDWa77yW9qKI4BQSBKTOmSW2a3TDUTr9QJtvpgwdAs1NCFh4ZcMM/pQeMZ0uo8yUnG+m6JtRCuaNgW5xrgaaA1AF5VTS4HzX1KhbYh5tXVCYpDNlj5RKwkkiR0oRmX+YaThL1PB1DPuaiUPMfzPwXA1FUPZ452rFqWB8gfDtPVCLl7istlkjse92c0tEgoDIeyy0bqIDAuyIIv8o65g1TnQyQ4IVNZ791o33D1320dJOS5SHXyGZNNX12DQad1a3tJiFuWzPSKZ1u0hAtqv/wRVAYf6uocEdRyXXgpbxxvzAJvjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HBEJ0Wnnrej7ZFG4v4zI4otawjUFMMAynClT7d6q2I=;
 b=2zcRQhfHWTSu4+PnaMsCINsGyaQwbNlhtHUOcWyme4mV3+hJeCke8uKtPGq+mmZV9PKsoZmrt5efbziU0FGUi3qeByxr0Cu8ieFeBuP/OK4tq3PCYZ6zpSg4Qgr6kR0neNsE8/eyETzlhx0sJjz26hjWuMr5YAcb40zXtGO+67U=
Received: from PR0P264CA0176.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::20)
 by IA1PR12MB6329.namprd12.prod.outlook.com (2603:10b6:208:3e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 17:19:51 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10a6:100:1c:cafe::bd) by PR0P264CA0176.outlook.office365.com
 (2603:10a6:100:1c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 17:19:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:19:48 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:19:07 -0500
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
Subject: [PATCH v12 10/20] cxl/pci: Introduce config option PCIEAER_CXL
Date:   Wed, 18 Oct 2023 19:17:03 +0200
Message-ID: <20231018171713.1883517-11-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|IA1PR12MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: acdd0be0-b800-46e7-c82e-08dbcffe6ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /OigQgQc2/+zG/U+E0iQfHzFcOXLo+3owwYu/cCXcUl6Pg3z+6RccBssxFbbV0BsJt6mL4O3TtSJOkqLIjibnYnIZnpGorYMdBXurXfZS+/tjEhE1iS3NjyKxmolwaawfrZJmM6g4MSuilBuFxfC7cinpr7t3XIJU1aXZz7QwmC2pOGQhbBv2g+zpOdBzuhURUQgNoiY8MD7ZgrSjEpdXs6o2sBLfxS7ulDTR0UbCjW6bg9DG51D5wWO1ytvbo/FEZPGbsfHeZgLziZ/+h1NSLQtnAwI3Cjk4xQXlHCb4u/j2Zmmik5rTaU7yLxJ3JvN+iqzDHL49smzAFXQpmaDWJ40GCTGvY+0TSCC/4T7c5AdpqYHk7M2KwqKZj5xoGCmnDssZzcmM2MXgIx4XmIp/2f2faE8X/uIyE9tfrOWX1GqtZRvpQeFBmikY2z/uU7jZsnzzAk6UweL2jBSFBrANzBx1HJiNISZTaoDPK5re3LIEWssmoRGQZNSIotynBx9wdjSaqC5Htulu96fwCPHP+InRfWaF7dzcKHPJyMjzbzY722naH3cqiq1EjVUBpIYPbMN01OjF7rvoLz3flUkE/QoJFBKw4Rv1Aqhf7rp6EaSCUd78+ynkpZjwqsJBVZ+3gYksd96R0dHanOOsPbiO4Gdv5mYH/9mGrbxcqXTV3KSptDsstIq0AfDjq8xyt45X42oV+NrsSMSxUHCec/O3UGV+f9sk56REbWppocvE36VXPqqcMa2+ZpUMVvdGOpcNHxKPhGSOk8K4oqEuM5FGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(478600001)(16526019)(2616005)(1076003)(6666004)(41300700001)(336012)(426003)(26005)(316002)(5660300002)(54906003)(70206006)(70586007)(356005)(110136005)(82740400003)(36756003)(83380400001)(36860700001)(81166007)(47076005)(8676002)(8936002)(4326008)(2906002)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:19:48.9112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acdd0be0-b800-46e7-c82e-08dbcffe6ec1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6329
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
index c7a7887ebdcf..7c3fbf9815e9 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -718,6 +718,15 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
 	return true;
 }
 
+#ifdef CONFIG_PCIEAER_CXL
+
+void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
+{
+}
+EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_dport, CXL);
+
+#endif
+
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c07064e0c136..cdb2ade6ba29 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -704,6 +704,13 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 					 struct device *dport_dev, int port_id,
 					 resource_size_t rcrb);
 
+#ifdef CONFIG_PCIEAER_CXL
+void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
+#else
+static inline void cxl_setup_parent_dport(struct device *host,
+					  struct cxl_dport *dport) { }
+#endif
+
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
 struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 04107058739b..e087febf9af0 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -157,6 +157,8 @@ static int cxl_mem_probe(struct device *dev)
 	else
 		endpoint_parent = &parent_port->dev;
 
+	cxl_setup_parent_dport(dev, dport);
+
 	device_lock(endpoint_parent);
 	if (!endpoint_parent->driver) {
 		dev_err(dev, "CXL port topology %s not enabled\n",
-- 
2.30.2

