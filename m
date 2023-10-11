Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F94A7C517A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbjJKLSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbjJKLRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:17:51 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17471122;
        Wed, 11 Oct 2023 04:17:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYjFXyUG5aDfeK0SMyL5o8zPbJIBFke91vfwz+YbOYt9iCBiNAHRlMpXQ6h+71g5Rt3IApM0TCIdw7bSh0OHdYSRvGRBMrUOWp+uAZsXRFKslhJV9YuOI24fFPnw813vwmZvA7hxEm+eJOkeeuHWYHvk5NPQ3CXNtTkiFz7F3/QM97ahgfhKg0cfP5LRruWcboOsBhS5YACW0mT1FifOTn9MfetSe9H+JCx7m7Oy1X8+PyrQNQMAu6Y+LnXfQCqRAknQ2WAs5L0xCHVP+qVsX5eXKFh4KkeGYPqeDLkOC+fNS78BeRta95BGjaGUodXtU12HcEl7z43EcE0IOsHbCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLed6JcZomXG6gLdEjsQNrb493DfTzaL6Ns1USO9rNA=;
 b=LR0mhy3Mb2/rJ8cpbR+S9UH/cQLlyCeIRQswL0xBnEZ4zrnHFWyBmvjGhwgtOQDWeS8eaLTTeQWLu/XxrD0Cwu7p5HRGB092xasOAxTA4uTeZRGHrTZTttbZ3b+jil7EGmFSkzeLbaFr8BdbXqzKHuD1FybQ9ehCxDEsUzeLpuLbmBAR7Ir+NRyguuCimyKYdb8jrprQN9MnsYXPKqEy7e4WJWHgwrd8Ia1wXPiPP8+MTLRIBBMv11JACohBVDWC2jdKookIHIts8HaOjYfO8K+6GEsFrNaYGQpsDEt5CqU5zUaNHCRxjLAUeCbYkiAENIxPa7IY1i81ibp62HqnUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLed6JcZomXG6gLdEjsQNrb493DfTzaL6Ns1USO9rNA=;
 b=M5iRz3+3twHuzzPoHMjYEJrx6mhy727ZsDMqPnM+fdfcWPSxlZBGHID/tPPdYh5Sr2szm//099zqojzYYZUysYPEGNsYzOqtvRL3FbdcSKvS7XIGxCKMjzfded3dQyMEGt9j1r51rYJ7WOBrvgd43i+s0TaltzGrqyTpwksBNg/FJNJsuys2kyb29ECfLUJA8+Zb9zZJyO0jmoGqeIX9BrY9ZIQq8dfgGjizORygZvEydOqZiL9QgUpWYmXHRQYQfn+JOevVgmaVR3hvOtwcFp9y03DY79jdz5cdFyMmYrZATNBIkzi+ByDicDULM3vkkPLqoL7bm5tEttBDPMBErQ==
Received: from CH3P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::9)
 by CY8PR12MB7196.namprd12.prod.outlook.com (2603:10b6:930:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 11:17:44 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:610:1e7:cafe::23) by CH3P221CA0007.outlook.office365.com
 (2603:10b6:610:1e7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 11 Oct 2023 11:17:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 11:17:43 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 04:17:33 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 04:17:32 -0700
Received: from localhost.localdomain (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 11 Oct 2023 04:17:26 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <keescook@chromium.org>, <andy@kernel.org>,
        <akpm@linux-foundation.org>, <arnd@arndb.de>,
        <petlozup@nvidia.com>, <pshete@nvidia.com>, <kkartik@nvidia.com>,
        <ulf.hansson@linaro.org>, <frank.li@vivo.com>, <robh@kernel.org>,
        <stefank@nvidia.com>, <pdeschrijver@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v4 7/8] soc/tegra: fuse: Add ACPI support for Tegra194 and Tegra234
Date:   Wed, 11 Oct 2023 15:04:11 +0530
Message-ID: <20231011093412.7994-8-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011093412.7994-1-kkartik@nvidia.com>
References: <20231011093412.7994-1-kkartik@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|CY8PR12MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: ff9195ea-e6e5-4f8f-5a22-08dbca4bb08a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +SlSDC78sPwuULbX+Vy+bZs01tXAnTztfuFk674aIQm83CAqST7FY4zx1H9yt1O4Vzh5MepWNi0sAa4TAUSXC04Xog61kqTcXM/RCojJc1xJ9IO3cwxmgQS0RlQ0pLsn5/VrPa1QoAv+fCSQOqDmRKKx2iFOY+1dVRySG8W+CV+TlPHOqZ1leh9R/giBGappdOY453NsVuw6zeZ9ZpYHNSRLqOi57z5AyoiepUD9SLdGl5mVIEgmgkBHcc5kFdfnIa2yxi0DyXVC6QzWKhwLA5Xx+jZsKEs4er8wE0TljHN0r4HI4r14i2N7XB4fJG3gmVUoqa+PAc5xKC3DynUNhwUFhlhMEjMiQ3YavhqmAaAD3BPUGbJ6rCcVFVwJZ696aE8+b7P92U3aOPM0yC6+gr1W+UszLVl6syxQaiRDzTWjBE0cGgIyOH3ODbu5jNBR4noD0/xKTQJZDsWRNJQ5bdsHrsmrm+SgFOwSdIcpBmihjU2LcuqJJyshPy5Wc/95UHdmUlhZVO/rcjR0iXcAb20/KN6Hgr1SMzCZVoZ3DSX2t54kRynnGPxx5zVc4fCaqTxCk0BS6vyL5A/24g4s68yiTp2Cr9l/F4MVjVG+hpfzuw2t+FT4nVuVaXQLQu8uVgOFlbf5Uha/p3DaRksauorLZTMi9NWr6IPOEs0RYnEnWOtim5E0H5hLBOFqaG7PGlci5OUT/kPkQPbRDQ1Mstpl3zr1RreyliFt9qOWHy+XGshZ6fH+7nwBQTzzdZvBMWZ//aAfE9ZOatsN05if7on51B+pVRy9ogLbooCH+qOjIX3YAOv6jdeAeX628MbI
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(1076003)(478600001)(6666004)(2616005)(426003)(47076005)(26005)(2906002)(70586007)(7416002)(83380400001)(70206006)(5660300002)(316002)(110136005)(336012)(8936002)(41300700001)(8676002)(82740400003)(86362001)(921005)(356005)(36860700001)(7636003)(36756003)(40480700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 11:17:43.5022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9195ea-e6e5-4f8f-5a22-08dbca4bb08a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7196
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ACPI support for Tegra194 & Tegra243 SoC's. This requires
following modifications to the probe when ACPI boot is used:
 - Initialize soc data.
 - Add nvmem lookups.
 - Register soc device.
 - use devm_clk_get_optional() instead of devm_clk_get() to get
   fuse->clk, as fuse clocks are not required when using ACPI boot.

Also, drop '__init' keyword for tegra_soc_device_register() as this is also
used by tegra_fuse_probe() and use dev_err_probe() wherever applicable.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
v3 -> v4:
	* Use dev_fwnode() to dereference the fwnode.
	* Add MODULE_DEVICE_TABLE for tegra_fuse_acpi_match.
	* Moved tegra_fuse_acpi_match above tegra_fuse_driver i.e.,
	  close to the user of tegra_fuse_acpi_match.
	* Moved the improvements made to fuse clk/rst get error handling
	  to separate patch.
	* Moved ACPI related initialization after fuse->base is
	  initialized in tegra_fuse_probe(), as this triggers a warning
	  in tegra_fuse_read_early() which is called from
	  fuse->soc->init().
v2 -> v3:
	* Updated commit message to specify changes related to inclusion
	  of dev_err_probe().

v1 -> v2:
	* Updated ACPI ID table 'tegra_fuse_acpi_match'.
	* Removed ',' after "{ /* sentinel */ }" in
	  'tegra_fuse_acpi_match'.
	* Using same probe for ACPI and device-tree boot.
	* Added code for required initialization when ACPI boot is used.
	* Make clocks optional for ACPI.
	* Use dev_err_probe() wherever applicable.
	* Check if clock has been initialized only when device-tree
	  boot is used.
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 50 +++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 2ac9e7a03d05..167a6fe6c43d 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -3,11 +3,13 @@
  * Copyright (c) 2013-2023, NVIDIA CORPORATION.  All rights reserved.
  */
 
+#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/kobject.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/mod_devicetable.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
@@ -155,6 +157,37 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 		return PTR_ERR(fuse->base);
 	fuse->phys = res->start;
 
+	/* Initialize the soc data and lookups if using ACPI boot. */
+	if (is_acpi_node(dev_fwnode(&pdev->dev)) && !fuse->soc) {
+		u8 chip;
+
+		tegra_acpi_init_apbmisc();
+
+		chip = tegra_get_chip_id();
+		switch (chip) {
+#if defined(CONFIG_ARCH_TEGRA_194_SOC)
+		case TEGRA194:
+			fuse->soc = &tegra194_fuse_soc;
+			break;
+#endif
+#if defined(CONFIG_ARCH_TEGRA_234_SOC)
+		case TEGRA234:
+			fuse->soc = &tegra234_fuse_soc;
+			break;
+#endif
+		default:
+			return dev_err_probe(&pdev->dev, -EINVAL, "Unsupported SoC: %02x\n", chip);
+		}
+
+		fuse->soc->init(fuse);
+		tegra_fuse_print_sku_info(&tegra_sku_info);
+		tegra_soc_device_register();
+
+		err = tegra_fuse_add_lookups(fuse);
+		if (err)
+			return dev_err_probe(&pdev->dev, err, "failed to add FUSE lookups\n");
+	}
+
 	fuse->clk = devm_clk_get(&pdev->dev, "fuse");
 	if (IS_ERR(fuse->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(fuse->clk), "failed to get FUSE clock\n");
@@ -278,10 +311,17 @@ static const struct dev_pm_ops tegra_fuse_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(tegra_fuse_suspend, tegra_fuse_resume)
 };
 
+static const struct acpi_device_id tegra_fuse_acpi_match[] = {
+	{ "NVDA200F" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(acpi, tegra_fuse_acpi_match);
+
 static struct platform_driver tegra_fuse_driver = {
 	.driver = {
 		.name = "tegra-fuse",
 		.of_match_table = tegra_fuse_match,
+		.acpi_match_table = ACPI_PTR(tegra_fuse_acpi_match),
 		.pm = &tegra_fuse_pm,
 		.suppress_bind_attrs = true,
 	},
@@ -303,7 +343,13 @@ u32 __init tegra_fuse_read_early(unsigned int offset)
 
 int tegra_fuse_readl(unsigned long offset, u32 *value)
 {
-	if (!fuse->read || !fuse->clk)
+	/*
+	 * Wait for fuse->clk to be initialized if device-tree boot is used.
+	 */
+	if (is_of_node(dev_fwnode(fuse->dev)) && !fuse->clk)
+		return -EPROBE_DEFER;
+
+	if (!fuse->read)
 		return -EPROBE_DEFER;
 
 	if (IS_ERR(fuse->clk))
@@ -386,7 +432,7 @@ const struct attribute_group tegra194_soc_attr_group = {
 };
 #endif
 
-struct device * __init tegra_soc_device_register(void)
+struct device *tegra_soc_device_register(void)
 {
 	struct soc_device_attribute *attr;
 	struct soc_device *dev;
-- 
2.34.1

