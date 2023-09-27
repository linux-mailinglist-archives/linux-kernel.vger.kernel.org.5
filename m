Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BE47B093D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjI0PsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjI0PsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:48:04 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE3E2B312;
        Wed, 27 Sep 2023 08:47:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9A17spMj+J2h3cB5tcz3lkDIB1bO6tOIHQgDv2jgs5kYOiTq9+QiOkbhmFquARLSnyGDFJOh/aO4S7ZFTiVlTWxyiTrl5hmTVJgspa3Wq0ZHcA+wx0MO+tCfjrHSw00T9eZYEo9ZvN5tCBVjej364SMTQQ5Wo+4t7yCnRPDyW9OgdPeY/uXTxhdl/VaU0C+XvSS4ggQ2SPgb2tCFeiWrBM3NZT6fy1cPPbAOZfgPIrOyB73LDi/OGeJEQ8McT5NGSoFFwdP1MlNBY6j3XUsROn3i3n80Icwr2ahWhAKHUH8HIlgs5suuNd+4w2aRwkmALKe8cx9iq+99+PcrGuTpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJCgqCXRnE3695/mkqzsAL8eOCMk0Fa6LQI3xdKpZlk=;
 b=V42rj7MBlUs5Qp01yiTMxv8Ydhm0/GupciBg12Yd+C8QjaWgPplkPNIT81kOqdWyMgLmWPHazhieR28ywncP69I7ljZZNO/KkD5uZOb/ChtYyTCdL5P6YVJePbZD8exHXO3jIzUSjjZFkzx8pwdRo6zqCvs9YSHxX+XrjXhWKCdChrc2c4Qey5UlC1GaYXahQZ6fHzoXOG5o8BZYpuTLmys8JEC4bUZyPL3qPT5yyVvgzsZWDqq6GriBhpPryLAJnojuIEvrruqLxAicIOEFVt1j7B12vsRUn00iCC3/lni4KrcOQsViWtDbfM6wLvzf1bST0bFTTQPm2qzY+nSmPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJCgqCXRnE3695/mkqzsAL8eOCMk0Fa6LQI3xdKpZlk=;
 b=wXecRpOVrIxUSamW1imap30FDGOLB00nMSsE0tt5vO1E3ZygEqMT9nAcez55hcDCTG2x+aUB0am4t/b1ngcGyV4yqGMVDjTdiXi+FMHOW+BsKBy4xPRve0BjZlDzSZFgYM7g0fAiTkuT7Ai5aShAtrl+FYGH2V7WhFU8CFXpIe8=
Received: from BLAP220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::27)
 by DM4PR12MB6470.namprd12.prod.outlook.com (2603:10b6:8:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 27 Sep
 2023 15:47:31 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::68) by BLAP220CA0022.outlook.office365.com
 (2603:10b6:208:32c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 15:47:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 15:47:31 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 10:46:59 -0500
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
Subject: [PATCH v11 16/20] cxl/pci: Disable root port interrupts in RCH mode
Date:   Wed, 27 Sep 2023 17:43:35 +0200
Message-ID: <20230927154339.1600738-17-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|DM4PR12MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: d424e7bf-6ca2-447e-5734-08dbbf710f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JW8QFm/tPfy8rIiWueQI1JQqTvP6GiQ4xvicFpA83/gPBpE8wzxrXidyINqWGOAIaLxQmfhgZpvKiDHUcfugQ1G3kO1SFA9Iqh0hT4J9RhT0BpeabWcMCoPxrCnkLYJE6efCUd9I1WgZnScjOldlswEHRt88OJZl+bzd552gV8wRwEf5L67JX905dZkMZ66kMCrZU2ESagkz4hAZVAQcLcuCRpCKpZfBn/7jF+Bzfx1TuYNt16JhSOBo4Bg/x/CC81gMu1ntmASnQyEJ3LcSALH4mmgP1PHpJcdnynOL9wJ26vEUzKoMOp15g2KLCbjzk1VftO6ep26c6rLQJQC0xWQZUuZh1oXwQQ8DGceU0USpOqHxRv2bkTyeWd2uPsIiuF8UVGiHXAL0EwyGVEwRsSYYQpQ2EbXnV3HtDkAHNdWZRmZnCRjsS2XknDtyOwy6FwWpnrwMO5/nJP3bsiLctmlHxIhDb1biMrKFX0ol6hqLANUdT+f9F2Kfqsg3j5p5yHiGBTksP9dA4j7CafNC9JXhBXW54dYq6EbCveNjh4Sk3Dq8hLUxvDjwkooS8X1bONmY4uQgV/tyzSakNYy9OUms/fytlPEbOHZerXQnTkhg+V+L2RTy0a6au20jVu7YpAea9Mu5eh+HZ8jEm4xMhhmDt4rL3yJep4QL4KN6htmyP8Ft/lzyvJZJY9QY8t0/wSdFgWoMrmWAiTdt738N8LVipoAmJeIU5D0JnjdL+EnBZ7DV7WY1eyjZe72fAONjOwwVU46drGlS7YTOlgtHZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(2906002)(40460700003)(2616005)(40480700001)(6666004)(478600001)(36756003)(70586007)(4326008)(8936002)(82740400003)(47076005)(36860700001)(41300700001)(83380400001)(81166007)(5660300002)(356005)(54906003)(16526019)(1076003)(316002)(26005)(336012)(426003)(8676002)(70206006)(110136005)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:47:31.3425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d424e7bf-6ca2-447e-5734-08dbbf710f6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6470
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Terry Bowman <terry.bowman@amd.com>

The RCH root port contains root command AER registers that should not be
enabled.[1] Disable these to prevent root port interrupts.

[1] CXL 3.0 - 12.2.1.1 RCH Downstream Port-detected Errors

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 8d849c8bf8fb..61e443aff0eb 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -763,6 +763,35 @@ static void cxl_dport_map_regs(struct cxl_dport *dport)
 		cxl_dport_map_rch_aer(dport);
 }
 
+static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
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
 void devm_cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
 {
 	struct device *dport_dev = dport->dport_dev;
@@ -774,6 +803,9 @@ void devm_cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
 
 	dport->reg_map.host = host;
 	cxl_dport_map_regs(dport);
+
+	if (dport->rch)
+		cxl_disable_rch_root_ints(dport);
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_parent_dport, CXL);
 
-- 
2.30.2

