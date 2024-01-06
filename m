Return-Path: <linux-kernel+bounces-18669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 763068260CA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E10B1B21F76
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFEBF4E9;
	Sat,  6 Jan 2024 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ttQe58qG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04940E55E;
	Sat,  6 Jan 2024 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRlwyiMbzIHMdB6/xA9QRJQOAM6U43+Ge/g689hwFD27Lgi1rTfsgF9MWIl9VYkKPfgPfrBd2oARV1fHIpiFqNLNEZd9WB7JfD58hfCYszBSRfk9FHJLqbUe68K1T6vHzFHrKQfkDI4asmjfLBK5Th+MHtedX+eloFWpj1mf3Umo5rg9+rcUEuNrQyxxPjPHc+WofEfJlAuCWP8kqTr7UVnAJ6v8QUyAvWYHbQltPKRTqZ4/RTd8MDq8jlwpe6940aJaoxLLlBO4RltEsh0OM+r9rtnR5NomQ6AuwzIBEdbWJwaeY016piLDwce8/ZPPl37gBeNVdxyh6nUiWPV7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+zZc+PhOYA3CJLWvxjwWCG4Fg4tGvuqxE2rVF0ZrhE=;
 b=kzdxQmRbl9EITcVpMcWe8xhCgvUlEl53ox3wmpRAi5V50wmO/+P99atkiqi1rjQHTmHQaaBtJihZiqrJrp+VckgIs33xLALulpstKcHJiZMqAEyGCJy0PYb9y8/n6kckDkuzU5iTfYWPUfg3OWJdRY2Tze6XoRU7h+Z0NtGsWHGXkBfdl4oHtJ+Zuz+bZfc7s9jjiI7L7TznwWKuY5RLzwcO7L00TIiTxjTMTZMl0P0JdyniVPek+of4hPxanxU3NMMIfNck8NJbHloGcLWxhPV7ATWMcRs7zgqIhxXM4zILd5aT2pHeoSXWNHE4OYHfg/FB5aZ7caiGa2HZgl8Kog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+zZc+PhOYA3CJLWvxjwWCG4Fg4tGvuqxE2rVF0ZrhE=;
 b=ttQe58qG51kw9uvTZEJuI2RitWW2gj6tgn/vdtfN76lBN5gjFawkyOeb9jkKz4jJjYJ+fbsqlD21ORYHYyyFRqpxDXef1Jf6o5oO7cQXKFe8Vh2wXHJaMkIxzWiHgZt1dnesl35bc2GDuvVH8tGw9vIAh1SGPYWfbSGg0lEMXtM=
Received: from MW4P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::11)
 by SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.19; Sat, 6 Jan
 2024 16:58:09 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::28) by MW4P222CA0006.outlook.office365.com
 (2603:10b6:303:114::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17 via Frontend
 Transport; Sat, 6 Jan 2024 16:58:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.3 via Frontend Transport; Sat, 6 Jan 2024 16:58:09 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 6 Jan
 2024 10:58:06 -0600
From: Sanath S <Sanath.S@amd.com>
To: <mario.limonciello@amd.com>, <andreas.noever@gmail.com>,
	<michael.jamet@intel.com>, <mika.westerberg@linux.intel.com>,
	<YehezkelShB@gmail.com>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Sanath S <Sanath.S@amd.com>
Subject: [Patch v3 3/4] thunderbolt: Store host router reset status in nhi_probe()
Date: Sat, 6 Jan 2024 22:27:22 +0530
Message-ID: <20240106165723.3377789-4-Sanath.S@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240106165723.3377789-1-Sanath.S@amd.com>
References: <20240106165723.3377789-1-Sanath.S@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 759b0b4a-7e84-4c4d-1684-08dc0ed8a93e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S2JXou7FrLkkZNurojzZliUsQenMxfsrBpXNVcNzsZt6+1CVwAW3kA5RFDEQf9pNbMcz4CDb0b3XY11q+IvEh1Hg3ChNeiJXqVC8vC1lPC65xx+yqq/ASM2O80sjW84eANJHZZ8TH8Nrm30B7dQoD3yDSCrQRlc1ylyhq2RZw8Gj1h4xb76CNkfe34srZnZvp1zmUV5ddZASS6grcpsj269rUwUtU895LuHmt6qXbpI5Bg9hCLE18g1hdwZM82iS6mSJXFwlnmY7qkyHBRC0mJbd9c/0rRSuheCYbLRpo/TKuhmu5WCVCYIC0lJarHus16RasS8goPwlc2wmeEne0XJ2MMPADEe8uO8I4IZ8xALgb7ER34NkAE8x5guHF6IsTHVSShwqmSrHaW5nrymfKlDwDTXBu9JH8md8dFR75bgPXr76bL3VWRgdXGLeQYwJbwz7WzROj97Heyfwd9bh3G+vnjrh9Mrk1bnRknXHKQ7l23lqu77Z1cRMvUgVoDlaM5V2Sy3EHm2TLV+wGtWYkjbeqpauX3opo5bNaR48pHH2Fk5yYClPhH00UYY5Mkl5ZkTfzomh7MOA4ba3Wdgr29cMRppJNoVhJZ4JWRXKz6dJaeCQ5gzVxCkVL9nAn3t1MtSjGz2f8sTPCDJtPbM4qAbjvdqIEBuagA4aZun+8zSkrjsCZi0Dao4ka+BDGiEJocKMtOJLOUpiSEahVyF0Z02SHTMmhf2v42PJBWlXSoR2awt//JlkR3RFc8RPg3Zifi0c3coXcqUQxo4ieqal7t4WxrJFH/7Da3CJ2gOHlRM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(1800799012)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(1076003)(26005)(426003)(336012)(2616005)(478600001)(6666004)(7696005)(16526019)(47076005)(36860700001)(83380400001)(66574015)(5660300002)(2906002)(41300700001)(70586007)(316002)(70206006)(110136005)(4326008)(8936002)(8676002)(82740400003)(36756003)(86362001)(356005)(81166007)(40460700003)(40480700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 16:58:09.2254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 759b0b4a-7e84-4c4d-1684-08dc0ed8a93e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997

Currently we do host reset of USB4 v2 in nhi_reset().
In prepration to introduce host rest for USB4 v1, pass on the
reset status to tb_domain_add() to avoid resetting the USB4 v2
routers again.

This boolean helps in resetting only USB4 v1 host routers and
skips resetting v2 routers when reset is introduced for v1 routers.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sanath S <Sanath.S@amd.com>
---
 drivers/thunderbolt/domain.c |  5 +++--
 drivers/thunderbolt/icm.c    |  2 +-
 drivers/thunderbolt/nhi.c    | 19 +++++++++++++------
 drivers/thunderbolt/tb.c     |  2 +-
 drivers/thunderbolt/tb.h     |  4 ++--
 5 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index ec7b5f65804e..31f3da4e6a08 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -423,6 +423,7 @@ struct tb *tb_domain_alloc(struct tb_nhi *nhi, int timeout_msec, size_t privsize
 /**
  * tb_domain_add() - Add domain to the system
  * @tb: Domain to add
+ * @reset: Issue reset to the host router
  *
  * Starts the domain and adds it to the system. Hotplugging devices will
  * work after this has been returned successfully. In order to remove
@@ -431,7 +432,7 @@ struct tb *tb_domain_alloc(struct tb_nhi *nhi, int timeout_msec, size_t privsize
  *
  * Return: %0 in case of success and negative errno in case of error
  */
-int tb_domain_add(struct tb *tb)
+int tb_domain_add(struct tb *tb, bool reset)
 {
 	int ret;
 
@@ -460,7 +461,7 @@ int tb_domain_add(struct tb *tb)
 
 	/* Start the domain */
 	if (tb->cm_ops->start) {
-		ret = tb->cm_ops->start(tb);
+		ret = tb->cm_ops->start(tb, reset);
 		if (ret)
 			goto err_domain_del;
 	}
diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index d8b9c734abd3..623aa81a8833 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -2144,7 +2144,7 @@ static int icm_runtime_resume(struct tb *tb)
 	return 0;
 }
 
-static int icm_start(struct tb *tb)
+static int icm_start(struct tb *tb, bool not_used)
 {
 	struct icm *icm = tb_priv(tb);
 	int ret;
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 4b7bec74e89f..1ec6f9c82aef 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -1221,7 +1221,7 @@ static void nhi_check_iommu(struct tb_nhi *nhi)
 		str_enabled_disabled(port_ok));
 }
 
-static void nhi_reset(struct tb_nhi *nhi)
+static bool nhi_reset(struct tb_nhi *nhi)
 {
 	ktime_t timeout;
 	u32 val;
@@ -1229,11 +1229,11 @@ static void nhi_reset(struct tb_nhi *nhi)
 	val = ioread32(nhi->iobase + REG_CAPS);
 	/* Reset only v2 and later routers */
 	if (FIELD_GET(REG_CAPS_VERSION_MASK, val) < REG_CAPS_VERSION_2)
-		return;
+		return false;
 
 	if (!host_reset) {
 		dev_dbg(&nhi->pdev->dev, "skipping host router reset\n");
-		return;
+		return false;
 	}
 
 	iowrite32(REG_RESET_HRR, nhi->iobase + REG_RESET);
@@ -1244,12 +1244,14 @@ static void nhi_reset(struct tb_nhi *nhi)
 		val = ioread32(nhi->iobase + REG_RESET);
 		if (!(val & REG_RESET_HRR)) {
 			dev_warn(&nhi->pdev->dev, "host router reset successful\n");
-			return;
+			return true;
 		}
 		usleep_range(10, 20);
 	} while (ktime_before(ktime_get(), timeout));
 
 	dev_warn(&nhi->pdev->dev, "timeout resetting host router\n");
+
+	return false;
 }
 
 static int nhi_init_msi(struct tb_nhi *nhi)
@@ -1331,6 +1333,7 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct device *dev = &pdev->dev;
 	struct tb_nhi *nhi;
 	struct tb *tb;
+	bool reset;
 	int res;
 
 	if (!nhi_imr_valid(pdev))
@@ -1365,7 +1368,11 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	nhi_check_quirks(nhi);
 	nhi_check_iommu(nhi);
 
-	nhi_reset(nhi);
+	/*
+	 * Only USB4 v2 hosts support host reset so if we already did
+	 * that then don't do it again when the domain is initialized.
+	 */
+	reset = nhi_reset(nhi) ? false : host_reset;
 
 	res = nhi_init_msi(nhi);
 	if (res)
@@ -1392,7 +1399,7 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	dev_dbg(dev, "NHI initialized, starting thunderbolt\n");
 
-	res = tb_domain_add(tb);
+	res = tb_domain_add(tb, reset);
 	if (res) {
 		/*
 		 * At this point the RX/TX rings might already have been
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index fd49f86e0353..740bf2ff1fcd 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -2555,7 +2555,7 @@ static int tb_scan_finalize_switch(struct device *dev, void *data)
 	return 0;
 }
 
-static int tb_start(struct tb *tb)
+static int tb_start(struct tb *tb, bool reset)
 {
 	struct tb_cm *tcm = tb_priv(tb);
 	int ret;
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 030d6525cbc9..be419fc87a21 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -481,7 +481,7 @@ struct tb_path {
  */
 struct tb_cm_ops {
 	int (*driver_ready)(struct tb *tb);
-	int (*start)(struct tb *tb);
+	int (*start)(struct tb *tb, bool reset);
 	void (*stop)(struct tb *tb);
 	int (*suspend_noirq)(struct tb *tb);
 	int (*resume_noirq)(struct tb *tb);
@@ -728,7 +728,7 @@ int tb_xdomain_init(void);
 void tb_xdomain_exit(void);
 
 struct tb *tb_domain_alloc(struct tb_nhi *nhi, int timeout_msec, size_t privsize);
-int tb_domain_add(struct tb *tb);
+int tb_domain_add(struct tb *tb, bool reset);
 void tb_domain_remove(struct tb *tb);
 int tb_domain_suspend_noirq(struct tb *tb);
 int tb_domain_resume_noirq(struct tb *tb);
-- 
2.34.1


