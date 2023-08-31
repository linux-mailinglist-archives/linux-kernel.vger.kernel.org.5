Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206D978F1A3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244161AbjHaRER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346855AbjHaREI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:04:08 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C351B2;
        Thu, 31 Aug 2023 10:03:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COxd/sVHYo97IgLi8okp0pPTwk6kuHgLB0LuPGObMmZuZMv6+t8LtL670KLnhsd3WfgsmvInnc7K8Ewuc9vFQkrl9GjTaUZE09u3pv91r9nkD/YBKSVrxlJSiPMh1yUC9VeoCa6VebAHanABP5/3j5VINKkm0jtXZMDem653cHTlVwYc4IrJ5HogXTRAC017rfdzlHqbv5QCUkqHt4wEXpEeTJ+WnHZyLVXDPANNTHn0WP+hjuFINsxW2I8DD8krPI14MwndyMZnw8QA06xS1SXDHrsmqfeLk/jhpEHX0hf/HQTvVuakN+mxNRv97jd8eMcwNdFpRThS/j+ND5HXwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTkkVGDXapof5hOE4XnqiEMQzlJecUOlAoRIEpC2gyg=;
 b=SbAHbMnk52umE5cbYZujr7j2E4lwwsgBZoVsb/zoqKqDFXOFBkjs26Uns3FrpnOTjEQm9A1o9ZrH2NtyPi2WyTYtigkB2jH5op/iNh+j2Qvsb+ihc2gbes5HJIPiodOlIqdmHYMOqJtTgU5ZT1/madvPoYT0Ho/yA+uSrUTAFau3jFvCoKHqPm+k1l1Etqt6dC+ZSdiO2eGTlhLI1W0GzctC0/LTXLywKQDH7woOHyP4WFSpuoNywMxLFuDimsRddl5UfHywmAlgE7+dfH/QyGeF20ocwnotV3hetnYNUKZitvgzYAAjSYGNWE8QHba7mMOncxZBwNd54lQv6Y5wDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTkkVGDXapof5hOE4XnqiEMQzlJecUOlAoRIEpC2gyg=;
 b=oarOe5YGaudOH1WwNUpJgKJ9Zo+si6sKpsjVSzZq/dyC6mG1ffjfwdLeANV3j5nQmI2Xq+6r8mTYmXBrtfe1CJxafmxOQpsKD6PPzm/y4uvgdCS+T/HMeFQ6Nhe9+XnEfzumDUx1zSUs5aXv6YmWvkNNuDrR+mrmqxAN0vcr8hc=
Received: from PH7PR13CA0005.namprd13.prod.outlook.com (2603:10b6:510:174::8)
 by SN7PR12MB7227.namprd12.prod.outlook.com (2603:10b6:806:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 17:03:41 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::61) by PH7PR13CA0005.outlook.office365.com
 (2603:10b6:510:174::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.13 via Frontend
 Transport; Thu, 31 Aug 2023 17:03:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 17:03:41 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 12:03:40 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v10 12/15] cxl/pci: Disable root port interrupts in RCH mode
Date:   Thu, 31 Aug 2023 12:02:45 -0500
Message-ID: <20230831170248.185078-5-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831170248.185078-1-terry.bowman@amd.com>
References: <20230831170248.185078-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|SN7PR12MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c07a26b-63f5-4d27-9343-08dbaa443a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRfVDS/GIMuv1uCnw5PODFlaLb4M3vjdfiezuG0184k8XNLTfloIjuN7BMfo1/IyRIEgK2brNC0R9UhhYBHriuoQlYT6QnEW7j9xdSUQnUnxYoBfHVhfZx5BYSlEgfj7zE3sn3j7PKcPyByvL27mWzGJOlanByoZLWDvQsS3suKgVNL0nD4pQP5tXqhlgLIBRhdPQbbk9tHDR4q6UqlOYm1ZV/YJHVZ32fbKMLx51RAjRO3uFaJjtAtrrbiVti21POWRgKMNoL3kPD/VFjy7+SpqYgF+SBUngK19JvW12RLu1tDX5+6RcxE4eSJuCVvWHb7iCPh/wQx+6c6wvn9P848VhJLe93YWXf+CQjWzMQaO2tc/erT71d3p+RqLuEFx9CTEHPUWTFp2+om0UhlK2cLjQYbimtZVDtYVmY969zHesVq2gg5r56wq4KfPa4Pb6r2do2CzqAIQy9YtZwR2upJo+57oH2lbS4f3U8XG4pGzPjPzYV29Xl9NqxVt9DlAeYn7+dFKJMnwS3mk07YHZl+hVmrWthsCnVQ/dgNHRU3B6AIfADKSJDpTf/hTKkB1UsNIKhOgBjCRKNF8EU7iFz+smBHxG8N50GU/jFrhqQ3g0FM+E2aTf41y6AuMxBoy+wksYBUo+/WaQ+BbxgCcr020aCdPswDsWGHhTZEAQeGsROsFadMy3LeVekZoYhfAFxiMhHtomm5lNX8/iY1DD3dVk6UgYis8VQu1NxWQuYyMES1YNEx/zcefuPI4Js6P16jbK2/IHKcbhQYT+rYtZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(1800799009)(186009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(41300700001)(7416002)(356005)(82740400003)(81166007)(86362001)(2616005)(478600001)(47076005)(83380400001)(336012)(26005)(16526019)(426003)(1076003)(7696005)(36860700001)(40480700001)(70586007)(70206006)(110136005)(36756003)(54906003)(316002)(2906002)(4326008)(8936002)(8676002)(5660300002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 17:03:41.3913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c07a26b-63f5-4d27-9343-08dbaa443a3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7227
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
index 2a22a7ed4704..d195af72ed65 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1042,6 +1042,9 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 
 	cxl_dport_map_regs(dport);
 
+	if (dport->rch)
+		cxl_disable_rch_root_ints(dport);
+
 	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
 	cond_cxl_root_unlock(port);
-- 
2.34.1

