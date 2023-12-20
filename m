Return-Path: <linux-kernel+bounces-6372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 761648197CF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93E61F2624A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ED0C2D0;
	Wed, 20 Dec 2023 04:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f0HXfO8n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8029FC121
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgQObloSsCFeWxdHHirxv1IEyblWKjfsy9cfNxE7Ufn7QwwoskWbPux8yT8w/FKXZpErgnPxb/HQCDGnQ32kY0jXdjzMVoQ9XZDxQCwUKFlw4BQAEETnQTgxxfVwXODyOFQ9SdQ7vjj6bujR7yYhf3pCQnCtAoU9Pn27Zaxp1P6Qr7cYJ/LtxKJp2dEBExd/wpFfIrSyUzk9iBdwo92onvS58DX9vipO3eq+xrPTXgOmmW1DdIqD66xIxXS/DbCY5BdDNmvEhKya2mqYMmDxBxbnTLjw3RNka6ZmuPLSZ8F/gDTdMrsg6d+QZBGQBvrmJuaUB7TDJ0Qx+u/0Y0ryeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DIz5vHHztIymnavqMOcKh4reC/VzYWxjHURYpRndxM=;
 b=cCBAAJYdas+tm3T3yX6rT0klT1LKEMYhqkRPHAYqtZDBkcKiHoUQzIlukJOovbaP22ia8BNUw8EKyWHlzontUd8pUL7G6A97ZCIYEWft8taT7OA9p7LFjzignW6gS/aCNbEHzkKTZVuw92VdMpRWSl0Qjtz6pKIZOaZ1d1cbkj6UOlKHP6Q92rmBNLCq1x+9skwvBC19vgPUWRykbluZLUfrDe70Ge5YYwyZUbomIUX00h8riidLxvcZd9Jn2rn7UYEjUFH9pqnA/VSyIUHZmqTlr6IscAT6IFVgy5Hua5rEih8J/wKYYo4grsJBuciY/CgkLrDOK+O/A5SuwHIcEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.or smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DIz5vHHztIymnavqMOcKh4reC/VzYWxjHURYpRndxM=;
 b=f0HXfO8naT0nne9a+MocrWjbm/MMILIam31nha9pO1SW3HMxYtxhfEQEloC+u6TtgNxImbtxwokyOxOPugemouEoaYCtjUiDhKBOwQ11lhQkeIx+p3mpWhIxwiPF7rQbwlT5ePuKDLU6PdfL9CA5YQ/bUgUF9VaMUZ2p7ZBw14o=
Received: from SJ0PR13CA0028.namprd13.prod.outlook.com (2603:10b6:a03:2c0::33)
 by PH0PR12MB7095.namprd12.prod.outlook.com (2603:10b6:510:21d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 04:29:17 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::dc) by SJ0PR13CA0028.outlook.office365.com
 (2603:10b6:a03:2c0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 04:29:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 04:29:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 19 Dec
 2023 22:29:08 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 19 Dec
 2023 22:28:35 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 19 Dec 2023 22:28:32 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-edac@vger.kernel.or>
CC: <git@amd.com>, <linux-kernel@vger.kernel.org>, <rric@kernel.org>,
	<mchehab@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>, <sai.krishna.potthuri@amd.com>,
	<shubhrajyoti.datta@gmail.com>
Subject: [PATCH] EDAC/versal: Make the bits in error injection configurable
Date: Wed, 20 Dec 2023 09:58:32 +0530
Message-ID: <20231220042832.29795-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|PH0PR12MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: da456204-70c0-4557-fb71-08dc01143a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K0GFVMCQv+ZT9VdyWS69mp88sACm1NjDIxnpcTRiHNbf3VYvk22X3lpSN9s8obRAvmZK2kUL7Q2cDPwtDfBfnHXqHz2x5Zk8/Fun8kIjRDpNMeKGsgPA+tgqEL5o7559Yq0+wCxg5vRfnYpxJSxEh6d0870vhNikxh0TFxPX7qUf9j+UtYamYj1F36IIduuG5t4Pp/e1j4er/Tz529B2BjwRrttHj5mSV23OIsienEy2dNbU00nRUz7IjaA+0gCAYPsEEQSWhrs9t1mWP3TPJ23k0kfULwxSPdbOP4sS7ABRbLIqqIsNse+asbeDhT5Wv65hiIa3TPbTUEh/+d+oUl3NTB8ywNthRklEKFIwYbtmpi6ug45ZVWLsimwMFgDYA3NToBcGeGYCybA9ha2LpIfNciB0hj3O43NHNIOrO572P972koXK4MHF6UEn/yfmhFXfOXgnBaiz94uunVNWdYGesLdQzontRDrYvoPe6Git64yW9PYcuZuQTX/KPLxioZpOR78JdqL7XIrCBV2IWf1+2fhgCXJUn3QKgxpVb0vVI79gEmpM1GFo5417s8e0nklwUJUtrku4QFLAf0l0yfdXsrJhlvM+sPR+O2HGWJVDCKI8kI0/jsr3E1tzwti4jo78d7B5BS2vgl9/NUyzIMh1m6G80BEiQHXL98ieHy9b0aVn2XKO6G0jDY1kVsE1pwSoMUQzDIY8r2ClFegJ7yMZNkBLdYvInUa2fXomKDTsOr2gQcT1+UFalipVWfrivDAaQUMaSuDUShsl1CFZHg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799012)(36840700001)(46966006)(40470700004)(70206006)(47076005)(41300700001)(36756003)(4326008)(70586007)(36860700001)(316002)(54906003)(6916009)(86362001)(2616005)(478600001)(336012)(26005)(5660300002)(1076003)(2906002)(8676002)(83380400001)(44832011)(8936002)(426003)(40460700003)(82740400003)(356005)(81166007)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 04:29:16.7695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da456204-70c0-4557-fb71-08dc01143a52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7095

Currently the error injection bits are hardcoded.
Make them configurable. We have separate entries to configure the
bits to inject errors.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

 drivers/edac/versal_edac.c | 122 ++++++++++++++++++++++++++++++++-----
 1 file changed, 106 insertions(+), 16 deletions(-)

diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index a200e7bf3535..c20ed798d693 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -42,8 +42,10 @@
 
 #define ECCW0_FLIP_CTRL				0x109C
 #define ECCW0_FLIP0_OFFSET			0x10A0
+#define ECCW0_FLIP1_OFFSET			0x10A4
 #define ECCW1_FLIP_CTRL				0x10AC
 #define ECCW1_FLIP0_OFFSET			0x10B0
+#define ECCW1_FLIP1_OFFSET			0x10B4
 #define ECCR0_CERR_STAT_OFFSET			0x10BC
 #define ECCR0_CE_ADDR_LO_OFFSET			0x10C0
 #define ECCR0_CE_ADDR_HI_OFFSET			0x10C4
@@ -821,24 +823,24 @@ static void poison_setup(struct edac_priv *priv)
 	writel(regval, priv->ddrmc_noc_baseaddr + XDDR_NOC_REG_ADEC15_OFFSET);
 }
 
-static ssize_t xddr_inject_data_poison_store(struct mem_ctl_info *mci,
-					     const char __user *data)
+static int xddr_inject_data_ce_store(struct mem_ctl_info *mci, int ce_bitpos)
 {
 	struct edac_priv *priv = mci->pvt_info;
 
 	writel(0, priv->ddrmc_baseaddr + ECCW0_FLIP0_OFFSET);
 	writel(0, priv->ddrmc_baseaddr + ECCW1_FLIP0_OFFSET);
 
-	if (strncmp(data, "CE", 2) == 0) {
-		writel(ECC_CEPOISON_MASK, priv->ddrmc_baseaddr +
+	if (ce_bitpos < 31) {
+		writel(BIT(ce_bitpos), priv->ddrmc_baseaddr +
 		       ECCW0_FLIP0_OFFSET);
-		writel(ECC_CEPOISON_MASK, priv->ddrmc_baseaddr +
+		writel(BIT(ce_bitpos), priv->ddrmc_baseaddr +
 		       ECCW1_FLIP0_OFFSET);
 	} else {
-		writel(ECC_UEPOISON_MASK, priv->ddrmc_baseaddr +
-		       ECCW0_FLIP0_OFFSET);
-		writel(ECC_UEPOISON_MASK, priv->ddrmc_baseaddr +
-		       ECCW1_FLIP0_OFFSET);
+		ce_bitpos = ce_bitpos - 31;
+		writel(BIT(ce_bitpos), priv->ddrmc_baseaddr +
+		       ECCW0_FLIP1_OFFSET);
+		writel(BIT(ce_bitpos), priv->ddrmc_baseaddr +
+		       ECCW1_FLIP1_OFFSET);
 	}
 
 	/* Lock the PCSR registers */
@@ -847,12 +849,14 @@ static ssize_t xddr_inject_data_poison_store(struct mem_ctl_info *mci,
 	return 0;
 }
 
-static ssize_t inject_data_poison_store(struct file *file, const char __user *data,
-					size_t count, loff_t *ppos)
+static ssize_t inject_data_ce_store(struct file *file, const char __user *data,
+				    size_t count, loff_t *ppos)
 {
 	struct device *dev = file->private_data;
 	struct mem_ctl_info *mci = to_mci(dev);
 	struct edac_priv *priv = mci->pvt_info;
+	u8 ce_bitpos;
+	int ret;
 
 	/* Unlock the PCSR registers */
 	writel(PCSR_UNLOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
@@ -863,14 +867,98 @@ static ssize_t inject_data_poison_store(struct file *file, const char __user *da
 	/* Lock the PCSR registers */
 	writel(1, priv->ddrmc_noc_baseaddr + XDDR_PCSR_OFFSET);
 
-	xddr_inject_data_poison_store(mci, data);
+	ret = kstrtou8_from_user(data, count, 0, &ce_bitpos);
+	if (ret)
+		return ret;
+	ret = xddr_inject_data_ce_store(mci, ce_bitpos);
 
 	return count;
 }
 
-static const struct file_operations xddr_inject_enable_fops = {
+static void xddr_inject_data_ue_store(struct mem_ctl_info *mci, u32 val0, u32 val1)
+{
+	struct edac_priv *priv = mci->pvt_info;
+
+	writel(val0, priv->ddrmc_baseaddr + ECCW0_FLIP0_OFFSET);
+	writel(val0, priv->ddrmc_baseaddr + ECCW0_FLIP1_OFFSET);
+	writel(val1, priv->ddrmc_baseaddr + ECCW1_FLIP1_OFFSET);
+	writel(val1, priv->ddrmc_baseaddr + ECCW1_FLIP1_OFFSET);
+}
+
+static ssize_t inject_data_ue_store(struct file *file, const char __user *data,
+				    size_t count, loff_t *ppos)
+{
+	struct device *dev = file->private_data;
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct edac_priv *priv = mci->pvt_info;
+	u8 pos0, pos1, len;
+	u32 val0 = 0;
+	u32 val1 = 0;
+	u8 ue0, ue1;
+	char buf[6];
+	int ret;
+
+	len = min_t(size_t, count, sizeof(buf));
+	if (copy_from_user(buf, data, len))
+		return -EFAULT;
+
+	for (pos0 = 0; buf[pos0] != ' ' && pos0 <= len; pos0++)
+		;
+
+	if (pos0 > len)
+		return -EINVAL;
+
+	ret = kstrtou8_from_user(data, pos0, 0, &ue0);
+	if (ret)
+		return ret;
+
+	for (pos1 = pos0 + 1; buf[pos1] != '\n' && pos1 <= len; pos1++)
+		;
+
+	if (pos1 > count)
+		return -EINVAL;
+
+	ret = kstrtou8_from_user(&data[pos0 + 1], pos1 - pos0 - 1, 0,
+				 &ue1);
+	if (ret)
+		return ret;
+
+	if (ue0 < 31) {
+		val0 = BIT(ue0);
+	} else {
+		ue0 = ue0 - 31;
+		val1 = BIT(ue0);
+	}
+	if (ue1 < 31) {
+		val0 |= BIT(ue1);
+	} else {
+		ue1 = ue1 - 31;
+		val1 |= BIT(ue1);
+	}
+
+	/* Unlock the PCSR registers */
+	writel(PCSR_UNLOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
+	writel(PCSR_UNLOCK_VAL, priv->ddrmc_noc_baseaddr + XDDR_PCSR_OFFSET);
+
+	poison_setup(priv);
+
+	/* Lock the PCSR registers */
+	writel(1, priv->ddrmc_noc_baseaddr + XDDR_PCSR_OFFSET);
+
+	xddr_inject_data_ue_store(mci, val0, val1);
+
+	return count;
+}
+
+static const struct file_operations xddr_inject_ue_fops = {
+	.open = simple_open,
+	.write = inject_data_ue_store,
+	.llseek = generic_file_llseek,
+};
+
+static const struct file_operations xddr_inject_ce_fops = {
 	.open = simple_open,
-	.write = inject_data_poison_store,
+	.write = inject_data_ce_store,
 	.llseek = generic_file_llseek,
 };
 
@@ -882,8 +970,10 @@ static void create_debugfs_attributes(struct mem_ctl_info *mci)
 	if (!priv->debugfs)
 		return;
 
-	edac_debugfs_create_file("inject_error", 0200, priv->debugfs,
-				 &mci->dev, &xddr_inject_enable_fops);
+	edac_debugfs_create_file("inject_ce", 0200, priv->debugfs,
+				 &mci->dev, &xddr_inject_ce_fops);
+	edac_debugfs_create_file("inject_ue", 0200, priv->debugfs,
+				 &mci->dev, &xddr_inject_ue_fops);
 	debugfs_create_x64("address", 0600, priv->debugfs,
 			   &priv->err_inject_addr);
 	mci->debugfs = priv->debugfs;
-- 
2.17.1


