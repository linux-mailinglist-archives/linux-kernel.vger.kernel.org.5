Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A116789273
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjHYXgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjHYXgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:36:15 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314F82D4B;
        Fri, 25 Aug 2023 16:35:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBFr3ed7ZBreEju8v5IdJmT2ttXuMo+LTqC8oMn4ufl3FRSunuExroLrCJ79qZYh9sNgNQLA13BoIuNj65tvKKFpQxe24kMF6xy8Oj8xadiJQ40uCYY7xp4oEbE8ek99vuLz1TzRi339DcDluP1q+0sM0y4BX8aG4IVAzejZUsKgEZkdAQ942Hc81pjwV4Lp05jRniQ9bHsDS70yWDwvxT6QU2F3MXgLpZSG1+MeXiYWwjyEU1YkvX00/otPJLNWayXuWwItT7eU3MrNhjHaj25AMMI90szPx089r53KpatlpCh0KyfA/ccHuuEUEPiNIgiY051z8LQn/0IjQNSmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LURjg1NMzLqOEURxypN/s/jAS9t6lum4/XDI3Mnb0ms=;
 b=U5KxDPOXK7WHoMBmbMvxryF2OYkLZO4xoVeavJ+Xf7ESUjpwa/WTcQUCIceRGv2ZZFp5xbmvsO6Z5YhZ500KhxUhr/zzDXw86U8fOmnVv8l18/KQEhAZHfi8YRY/vBTUp/U93v3kZk7AiX4zoYM+chmkQ4ncE4rPdbZVNW1LsBlWYDcgJ9uZvc40+ArKtKxtO0NaJDxG77BHNOeY8sGH9GcA57rOmsPNyAG7OhmTIB6MS4FgzYeSUTtyAafTedOpnepdeCl3zkE+mddemjtaRnMZK5vufA1MY37spJcDOxcYdQOmpnKBJKwLJzA9RJwPBZOeXB6aqHPYeV6yF8FGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LURjg1NMzLqOEURxypN/s/jAS9t6lum4/XDI3Mnb0ms=;
 b=0KxUPfOLz4UuCvBNtfqC+dwjiwhyPfl6cKZ2m5Pf7GquzxFhVbqmyG8+FA/MQyoRIf/Bxhn5mjpAGVzeqtZLMuFlJ03GQyDXZS4ndSV3zCW9r4FHdyytUXoT2moNIPvTPCgHL0bTqZia7ZKVT3bOHqjHhD9vkgCr0cqP6/asRrw=
Received: from SA9PR10CA0017.namprd10.prod.outlook.com (2603:10b6:806:a7::22)
 by MW6PR12MB8759.namprd12.prod.outlook.com (2603:10b6:303:243::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 23:34:45 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::2d) by SA9PR10CA0017.outlook.office365.com
 (2603:10b6:806:a7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Fri, 25 Aug 2023 23:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 23:34:44 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 18:34:43 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v9 12/15] cxl/pci: Disable root port interrupts in RCH mode
Date:   Fri, 25 Aug 2023 18:32:08 -0500
Message-ID: <20230825233211.3029825-13-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825233211.3029825-1-terry.bowman@amd.com>
References: <20230825233211.3029825-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|MW6PR12MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3eefd4-ad4e-4bca-d288-08dba5c3dd09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GqBuROiruQIqQP/Toir9ux5vRnYDkNrgqnISsJ9IQcaqohErSbRnrl8QfXnOKhT1Zc3swr8e44eM+bHa7XHGKDrBC8a/9ZfpmSTfjQkizT8xQXnV/KKBs5gDLPAj0C9tlMGh+OPdt4ofa9xiy2LKOJAQpNuL0e0f6X4JWrAkNhcvR2J5sGgJTCZqRzQBpWRFKpmMvQfuqV2CSg9p3Mm7RLH3yUf2liiI/InDT2OQlOzw/Q2ZmaLYgD0dGkdKGs3gCsBUfLQ5UedU/KV8d38qWsnl/CedyilRddwXH3cVoRPqSByNG+psDUCotBdqjIh2xLsgE2U1occ7ZiJBsDA6vbWDjuN8SEqoSDFIxIL57PXiO6Hs8bxnPuAI3VUdocvt1D0DffnAhdUjT9iEGu3TjD0tkkVGbALOmzfT3PMJYcEkj1NLFeGgHGBsSHGhoaB5Y7Na9vvU585DfQAVLdFtvyl7RHuJ4Y57RNLQYz+2RIg7ME8s1EyPkfJrS20HaZ5Me7DuUp20F3iQhUCMOXw6fvCpJjAQR286hYUeiMwSKl8kM1CFj5XkJP7LKImuLUUME1rWzggJGaj/WPSUirEGHcYvZXsGkRDsV0vF+wUioYljfIMwEgUjj9kIp6qGkBNcp6mstWAByZGI6v5wsl6UmOFF8QBw0daAwlraEPNXvLTZX6RNBjsX3jjxc13MtudgyIKDj5ZYpTSOIIiYHDZeZ3CGJFp/xjobk5KUMNZmAoqOK4Tbn37o0US+Q3vlSQ2orPsam61WT8zuxt1j8XL0Eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(186009)(82310400011)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(54906003)(70206006)(70586007)(316002)(81166007)(478600001)(110136005)(40480700001)(26005)(16526019)(6666004)(82740400003)(41300700001)(7696005)(86362001)(2906002)(356005)(8936002)(4326008)(8676002)(83380400001)(40460700003)(2616005)(5660300002)(47076005)(7416002)(44832011)(1076003)(426003)(336012)(36756003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 23:34:44.8046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3eefd4-ad4e-4bca-d288-08dba5c3dd09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8759
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RCH root port contains root command AER registers that should not be
enabled.[1] Disable these to prevent root port interrupts.

[1] CXL 3.0 - 12.2.1.1 RCH Downstream Port-detected Errors

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/core.h |  6 ++++++
 drivers/cxl/core/pci.c  | 29 +++++++++++++++++++++++++++++
 drivers/cxl/core/port.c |  3 +++
 3 files changed, 38 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index f470ef5c0a6a..6b037030b936 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -87,4 +87,10 @@ enum cxl_poison_trace_type {
 	CXL_POISON_TRACE_CLEAR,
 };
 
+#ifdef CONFIG_PCIEAER_CXL
+void cxl_disable_rch_root_ints(struct cxl_dport *dport);
+#else
+static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { };
+#endif
+
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 1c40270968b6..e306d3c9638b 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -819,6 +819,35 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 		cxl_handle_rdport_ras(cxlds, dport);
 }
 
+void cxl_disable_rch_root_ints(struct cxl_dport *dport)
+{
+	void __iomem *aer_base = dport->regs.dport_aer;
+	struct pci_host_bridge *bridge;
+	u32 aer_cmd_mask, aer_cmd;
+
+	if (!aer_base)
+		return;
+
+	bridge = to_pci_host_bridge(dport->dport_dev);
+
+	/*
+	 * Disable RCH root port command interrupts.
+	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
+	 *
+	 * This sequence may not be necessary. CXL spec states disabling
+	 * the root cmd register's interrupts is required. But, PCI spec
+	 * shows these are disabled by default on reset.
+	 */
+	if (bridge->native_cxl_error) {
+		aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
+				PCI_ERR_ROOT_CMD_NONFATAL_EN |
+				PCI_ERR_ROOT_CMD_FATAL_EN);
+		aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
+		aer_cmd &= ~aer_cmd_mask;
+		writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
+	}
+}
+
 #else
 static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
 #endif
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 5fae1c06de22..11495dbc5fbd 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1041,6 +1041,9 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 
 	cxl_dport_map_regs(dport);
 
+	if (dport->rch)
+		cxl_disable_rch_root_ints(dport);
+
 	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
 	cond_cxl_root_unlock(port);
-- 
2.34.1

