Return-Path: <linux-kernel+bounces-94118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E532873A3A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD89D1F2754C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3238B13AA48;
	Wed,  6 Mar 2024 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GQG8fi4R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56730139571;
	Wed,  6 Mar 2024 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737549; cv=none; b=toz+9DVHVmnIwevJdmpjMYb/9RMpXANRS/ep4utpBaJKK2q2cMDWNNsOTDUU1ewEr3u6AZpzInVxVxyG9KxrCPc9EZJ0m7lsBeNJAuGktA1YW0Nt1eYMspEoIZ5q/faj/DkSXPHb2Ytw25F/bRCiZyWqZn4GV/j7i9+kCrG3tKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737549; c=relaxed/simple;
	bh=vEhFu+oUYd0rn+Q4zLLsTsKI3GmsoDMcQrdYGtE3p5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAY+UwXcg0brRQqznUQtDPTIahCUxiuc48RIfbTneB3u/AmceRTGD+fsae/Op6vT1C9/01HI4uxsK7OjLJ8zBHZUiw+nrSN7w4vgYK+55IwtPICcZywZEw8EpmhrjEaSdE6AGSeaKuI3ZmRun/Y2Pc6Xe0wkWNAMr8rcVGPV4FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GQG8fi4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47285C43394;
	Wed,  6 Mar 2024 15:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709737548;
	bh=vEhFu+oUYd0rn+Q4zLLsTsKI3GmsoDMcQrdYGtE3p5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GQG8fi4RZf8FcH6vtv/1sl1O8GIu09k0CBYbwrEq4ZzDRJSgWYXrAtFucR3gY2VC4
	 YDoFiHknhbdYi1+0iF7UubzcgPFMoI32ohGrBBLjkKnufF2lE3x1mkg9qJOvIyj0RL
	 iaD+2kCUulwC7H2Jwyl0IoluHCJtEnkPqsWCR+Ew=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.151
Date: Wed,  6 Mar 2024 15:05:40 +0000
Message-ID: <2024030640-theatrics-strung-dc43@gregkh>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024030640-stilt-carrot-f6cd@gregkh>
References: <2024030640-stilt-carrot-f6cd@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 9f13ca515fd2..bb73dba0e505 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 150
+SUBLEVEL = 151
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 397cb945b16e..9a3d9b68f2ff 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -58,7 +58,7 @@
  * Define vmemmap for pfn_to_page & page_to_pfn calls. Needed if kernel
  * is configured with CONFIG_SPARSEMEM_VMEMMAP enabled.
  */
-#define vmemmap		((struct page *)VMEMMAP_START)
+#define vmemmap		((struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_SHIFT))
 
 #define PCI_IO_SIZE      SZ_16M
 #define PCI_IO_END       VMEMMAP_START
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index ae7d4c85f4f4..2b1cd4202e75 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -181,6 +181,90 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
 	return false;
 }
 
+#define MSR_IA32_TME_ACTIVATE		0x982
+
+/* Helpers to access TME_ACTIVATE MSR */
+#define TME_ACTIVATE_LOCKED(x)		(x & 0x1)
+#define TME_ACTIVATE_ENABLED(x)		(x & 0x2)
+
+#define TME_ACTIVATE_POLICY(x)		((x >> 4) & 0xf)	/* Bits 7:4 */
+#define TME_ACTIVATE_POLICY_AES_XTS_128	0
+
+#define TME_ACTIVATE_KEYID_BITS(x)	((x >> 32) & 0xf)	/* Bits 35:32 */
+
+#define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	/* Bits 63:48 */
+#define TME_ACTIVATE_CRYPTO_AES_XTS_128	1
+
+/* Values for mktme_status (SW only construct) */
+#define MKTME_ENABLED			0
+#define MKTME_DISABLED			1
+#define MKTME_UNINITIALIZED		2
+static int mktme_status = MKTME_UNINITIALIZED;
+
+static void detect_tme_early(struct cpuinfo_x86 *c)
+{
+	u64 tme_activate, tme_policy, tme_crypto_algs;
+	int keyid_bits = 0, nr_keyids = 0;
+	static u64 tme_activate_cpu0 = 0;
+
+	rdmsrl(MSR_IA32_TME_ACTIVATE, tme_activate);
+
+	if (mktme_status != MKTME_UNINITIALIZED) {
+		if (tme_activate != tme_activate_cpu0) {
+			/* Broken BIOS? */
+			pr_err_once("x86/tme: configuration is inconsistent between CPUs\n");
+			pr_err_once("x86/tme: MKTME is not usable\n");
+			mktme_status = MKTME_DISABLED;
+
+			/* Proceed. We may need to exclude bits from x86_phys_bits. */
+		}
+	} else {
+		tme_activate_cpu0 = tme_activate;
+	}
+
+	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
+		pr_info_once("x86/tme: not enabled by BIOS\n");
+		mktme_status = MKTME_DISABLED;
+		return;
+	}
+
+	if (mktme_status != MKTME_UNINITIALIZED)
+		goto detect_keyid_bits;
+
+	pr_info("x86/tme: enabled by BIOS\n");
+
+	tme_policy = TME_ACTIVATE_POLICY(tme_activate);
+	if (tme_policy != TME_ACTIVATE_POLICY_AES_XTS_128)
+		pr_warn("x86/tme: Unknown policy is active: %#llx\n", tme_policy);
+
+	tme_crypto_algs = TME_ACTIVATE_CRYPTO_ALGS(tme_activate);
+	if (!(tme_crypto_algs & TME_ACTIVATE_CRYPTO_AES_XTS_128)) {
+		pr_err("x86/mktme: No known encryption algorithm is supported: %#llx\n",
+				tme_crypto_algs);
+		mktme_status = MKTME_DISABLED;
+	}
+detect_keyid_bits:
+	keyid_bits = TME_ACTIVATE_KEYID_BITS(tme_activate);
+	nr_keyids = (1UL << keyid_bits) - 1;
+	if (nr_keyids) {
+		pr_info_once("x86/mktme: enabled by BIOS\n");
+		pr_info_once("x86/mktme: %d KeyIDs available\n", nr_keyids);
+	} else {
+		pr_info_once("x86/mktme: disabled by BIOS\n");
+	}
+
+	if (mktme_status == MKTME_UNINITIALIZED) {
+		/* MKTME is usable */
+		mktme_status = MKTME_ENABLED;
+	}
+
+	/*
+	 * KeyID bits effectively lower the number of physical address
+	 * bits.  Update cpuinfo_x86::x86_phys_bits accordingly.
+	 */
+	c->x86_phys_bits -= keyid_bits;
+}
+
 static void early_init_intel(struct cpuinfo_x86 *c)
 {
 	u64 misc_enable;
@@ -332,6 +416,13 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	 */
 	if (detect_extended_topology_early(c) < 0)
 		detect_ht_early(c);
+
+	/*
+	 * Adjust the number of physical bits early because it affects the
+	 * valid bits of the MTRR mask registers.
+	 */
+	if (cpu_has(c, X86_FEATURE_TME))
+		detect_tme_early(c);
 }
 
 static void bsp_init_intel(struct cpuinfo_x86 *c)
@@ -492,90 +583,6 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 #endif
 }
 
-#define MSR_IA32_TME_ACTIVATE		0x982
-
-/* Helpers to access TME_ACTIVATE MSR */
-#define TME_ACTIVATE_LOCKED(x)		(x & 0x1)
-#define TME_ACTIVATE_ENABLED(x)		(x & 0x2)
-
-#define TME_ACTIVATE_POLICY(x)		((x >> 4) & 0xf)	/* Bits 7:4 */
-#define TME_ACTIVATE_POLICY_AES_XTS_128	0
-
-#define TME_ACTIVATE_KEYID_BITS(x)	((x >> 32) & 0xf)	/* Bits 35:32 */
-
-#define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	/* Bits 63:48 */
-#define TME_ACTIVATE_CRYPTO_AES_XTS_128	1
-
-/* Values for mktme_status (SW only construct) */
-#define MKTME_ENABLED			0
-#define MKTME_DISABLED			1
-#define MKTME_UNINITIALIZED		2
-static int mktme_status = MKTME_UNINITIALIZED;
-
-static void detect_tme(struct cpuinfo_x86 *c)
-{
-	u64 tme_activate, tme_policy, tme_crypto_algs;
-	int keyid_bits = 0, nr_keyids = 0;
-	static u64 tme_activate_cpu0 = 0;
-
-	rdmsrl(MSR_IA32_TME_ACTIVATE, tme_activate);
-
-	if (mktme_status != MKTME_UNINITIALIZED) {
-		if (tme_activate != tme_activate_cpu0) {
-			/* Broken BIOS? */
-			pr_err_once("x86/tme: configuration is inconsistent between CPUs\n");
-			pr_err_once("x86/tme: MKTME is not usable\n");
-			mktme_status = MKTME_DISABLED;
-
-			/* Proceed. We may need to exclude bits from x86_phys_bits. */
-		}
-	} else {
-		tme_activate_cpu0 = tme_activate;
-	}
-
-	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
-		pr_info_once("x86/tme: not enabled by BIOS\n");
-		mktme_status = MKTME_DISABLED;
-		return;
-	}
-
-	if (mktme_status != MKTME_UNINITIALIZED)
-		goto detect_keyid_bits;
-
-	pr_info("x86/tme: enabled by BIOS\n");
-
-	tme_policy = TME_ACTIVATE_POLICY(tme_activate);
-	if (tme_policy != TME_ACTIVATE_POLICY_AES_XTS_128)
-		pr_warn("x86/tme: Unknown policy is active: %#llx\n", tme_policy);
-
-	tme_crypto_algs = TME_ACTIVATE_CRYPTO_ALGS(tme_activate);
-	if (!(tme_crypto_algs & TME_ACTIVATE_CRYPTO_AES_XTS_128)) {
-		pr_err("x86/mktme: No known encryption algorithm is supported: %#llx\n",
-				tme_crypto_algs);
-		mktme_status = MKTME_DISABLED;
-	}
-detect_keyid_bits:
-	keyid_bits = TME_ACTIVATE_KEYID_BITS(tme_activate);
-	nr_keyids = (1UL << keyid_bits) - 1;
-	if (nr_keyids) {
-		pr_info_once("x86/mktme: enabled by BIOS\n");
-		pr_info_once("x86/mktme: %d KeyIDs available\n", nr_keyids);
-	} else {
-		pr_info_once("x86/mktme: disabled by BIOS\n");
-	}
-
-	if (mktme_status == MKTME_UNINITIALIZED) {
-		/* MKTME is usable */
-		mktme_status = MKTME_ENABLED;
-	}
-
-	/*
-	 * KeyID bits effectively lower the number of physical address
-	 * bits.  Update cpuinfo_x86::x86_phys_bits accordingly.
-	 */
-	c->x86_phys_bits -= keyid_bits;
-}
-
 static void init_cpuid_fault(struct cpuinfo_x86 *c)
 {
 	u64 msr;
@@ -712,9 +719,6 @@ static void init_intel(struct cpuinfo_x86 *c)
 
 	init_ia32_feat_ctl(c);
 
-	if (cpu_has(c, X86_FEATURE_TME))
-		detect_tme(c);
-
 	init_intel_misc_features(c);
 
 	split_lock_init();
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index dd5f4eee9ffb..4de71e772f51 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2787,6 +2787,9 @@ static void intel_cpufreq_adjust_perf(unsigned int cpunum,
 	if (min_pstate < cpu->min_perf_ratio)
 		min_pstate = cpu->min_perf_ratio;
 
+	if (min_pstate > cpu->max_perf_ratio)
+		min_pstate = cpu->max_perf_ratio;
+
 	max_pstate = min(cap_pstate, cpu->max_perf_ratio);
 	if (max_pstate < min_pstate)
 		max_pstate = min_pstate;
diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index f383f219ed00..7082a5a6814a 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -109,6 +109,7 @@
 #define FSL_QDMA_CMD_WTHROTL_OFFSET	20
 #define FSL_QDMA_CMD_DSEN_OFFSET	19
 #define FSL_QDMA_CMD_LWC_OFFSET		16
+#define FSL_QDMA_CMD_PF			BIT(17)
 
 /* Field definition for Descriptor status */
 #define QDMA_CCDF_STATUS_RTE		BIT(5)
@@ -384,7 +385,8 @@ static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
 	qdma_csgf_set_f(csgf_dest, len);
 	/* Descriptor Buffer */
 	cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
-			  FSL_QDMA_CMD_RWTTYPE_OFFSET);
+			  FSL_QDMA_CMD_RWTTYPE_OFFSET) |
+			  FSL_QDMA_CMD_PF;
 	sdf->data = QDMA_SDDF_CMD(cmd);
 
 	cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
@@ -1201,10 +1203,6 @@ static int fsl_qdma_probe(struct platform_device *pdev)
 	if (!fsl_qdma->queue)
 		return -ENOMEM;
 
-	ret = fsl_qdma_irq_init(pdev, fsl_qdma);
-	if (ret)
-		return ret;
-
 	fsl_qdma->irq_base = platform_get_irq_byname(pdev, "qdma-queue0");
 	if (fsl_qdma->irq_base < 0)
 		return fsl_qdma->irq_base;
@@ -1243,16 +1241,19 @@ static int fsl_qdma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, fsl_qdma);
 
-	ret = dma_async_device_register(&fsl_qdma->dma_dev);
+	ret = fsl_qdma_reg_init(fsl_qdma);
 	if (ret) {
-		dev_err(&pdev->dev,
-			"Can't register NXP Layerscape qDMA engine.\n");
+		dev_err(&pdev->dev, "Can't Initialize the qDMA engine.\n");
 		return ret;
 	}
 
-	ret = fsl_qdma_reg_init(fsl_qdma);
+	ret = fsl_qdma_irq_init(pdev, fsl_qdma);
+	if (ret)
+		return ret;
+
+	ret = dma_async_device_register(&fsl_qdma->dma_dev);
 	if (ret) {
-		dev_err(&pdev->dev, "Can't Initialize the qDMA engine.\n");
+		dev_err(&pdev->dev, "Can't register NXP Layerscape qDMA engine.\n");
 		return ret;
 	}
 
diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
index c9e52f6f2f50..60d48e0788f7 100644
--- a/drivers/dma/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/ptdma/ptdma-dmaengine.c
@@ -361,8 +361,6 @@ int pt_dmaengine_register(struct pt_device *pt)
 	chan->vc.desc_free = pt_do_cleanup;
 	vchan_init(&chan->vc, dma_dev);
 
-	dma_set_mask_and_coherent(pt->dev, DMA_BIT_MASK(64));
-
 	ret = dma_async_device_register(dma_dev);
 	if (ret)
 		goto err_reg;
diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
index 3e8d4b51a814..97bafb5f7038 100644
--- a/drivers/firmware/efi/capsule-loader.c
+++ b/drivers/firmware/efi/capsule-loader.c
@@ -292,7 +292,7 @@ static int efi_capsule_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 	}
 
-	cap_info->phys = kzalloc(sizeof(void *), GFP_KERNEL);
+	cap_info->phys = kzalloc(sizeof(phys_addr_t), GFP_KERNEL);
 	if (!cap_info->phys) {
 		kfree(cap_info->pages);
 		kfree(cap_info);
diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index 4a55cdf089d6..ebfa0a8e57de 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -127,8 +127,6 @@ static int gen_74x164_probe(struct spi_device *spi)
 	if (IS_ERR(chip->gpiod_oe))
 		return PTR_ERR(chip->gpiod_oe);
 
-	gpiod_set_value_cansleep(chip->gpiod_oe, 1);
-
 	spi_set_drvdata(spi, chip);
 
 	chip->gpio_chip.label = spi->modalias;
@@ -153,6 +151,8 @@ static int gen_74x164_probe(struct spi_device *spi)
 		goto exit_destroy;
 	}
 
+	gpiod_set_value_cansleep(chip->gpiod_oe, 1);
+
 	ret = gpiochip_add_data(&chip->gpio_chip, chip);
 	if (!ret)
 		return 0;
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index f9fdd117c654..34a061b4becd 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -774,11 +774,11 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 
 	ret = gpiochip_irqchip_init_valid_mask(gc);
 	if (ret)
-		goto err_remove_acpi_chip;
+		goto err_free_hogs;
 
 	ret = gpiochip_irqchip_init_hw(gc);
 	if (ret)
-		goto err_remove_acpi_chip;
+		goto err_remove_irqchip_mask;
 
 	ret = gpiochip_add_irqchip(gc, lock_key, request_key);
 	if (ret)
@@ -803,13 +803,13 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	gpiochip_irqchip_remove(gc);
 err_remove_irqchip_mask:
 	gpiochip_irqchip_free_valid_mask(gc);
-err_remove_acpi_chip:
+err_free_hogs:
+	gpiochip_free_hogs(gc);
 	acpi_gpiochip_remove(gc);
+	gpiochip_remove_pin_ranges(gc);
 err_remove_of_chip:
-	gpiochip_free_hogs(gc);
 	of_gpiochip_remove(gc);
 err_free_gpiochip_mask:
-	gpiochip_remove_pin_ranges(gc);
 	gpiochip_free_valid_mask(gc);
 	if (gdev->dev.release) {
 		/* release() has been registered by gpiochip_setup_dev() */
diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 6891863ed510..e16b0fc0cda0 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -571,6 +571,10 @@ static int lt8912_bridge_attach(struct drm_bridge *bridge,
 	if (ret)
 		goto error;
 
+	ret = lt8912_attach_dsi(lt);
+	if (ret)
+		goto error;
+
 	return 0;
 
 error:
@@ -726,15 +730,8 @@ static int lt8912_probe(struct i2c_client *client,
 
 	drm_bridge_add(&lt->bridge);
 
-	ret = lt8912_attach_dsi(lt);
-	if (ret)
-		goto err_attach;
-
 	return 0;
 
-err_attach:
-	drm_bridge_remove(&lt->bridge);
-	lt8912_free_i2c(lt);
 err_i2c:
 	lt8912_put_dt(lt);
 err_dt_parse:
diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index aadb2b97498a..78315cb64add 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -30,7 +30,6 @@ static LIST_HEAD(icc_providers);
 static int providers_count;
 static bool synced_state;
 static DEFINE_MUTEX(icc_lock);
-static DEFINE_MUTEX(icc_bw_lock);
 static struct dentry *icc_debugfs_dir;
 
 static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
@@ -637,7 +636,7 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
 		return -EINVAL;
 
-	mutex_lock(&icc_bw_lock);
+	mutex_lock(&icc_lock);
 
 	old_avg = path->reqs[0].avg_bw;
 	old_peak = path->reqs[0].peak_bw;
@@ -669,7 +668,7 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 		apply_constraints(path);
 	}
 
-	mutex_unlock(&icc_bw_lock);
+	mutex_unlock(&icc_lock);
 
 	trace_icc_set_bw_end(path, ret);
 
@@ -972,7 +971,6 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 		return;
 
 	mutex_lock(&icc_lock);
-	mutex_lock(&icc_bw_lock);
 
 	node->provider = provider;
 	list_add_tail(&node->node_list, &provider->nodes);
@@ -998,7 +996,6 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 	node->avg_bw = 0;
 	node->peak_bw = 0;
 
-	mutex_unlock(&icc_bw_lock);
 	mutex_unlock(&icc_lock);
 }
 EXPORT_SYMBOL_GPL(icc_node_add);
@@ -1126,7 +1123,6 @@ void icc_sync_state(struct device *dev)
 		return;
 
 	mutex_lock(&icc_lock);
-	mutex_lock(&icc_bw_lock);
 	synced_state = true;
 	list_for_each_entry(p, &icc_providers, provider_list) {
 		dev_dbg(p->dev, "interconnect provider is in synced state\n");
@@ -1139,21 +1135,13 @@ void icc_sync_state(struct device *dev)
 			}
 		}
 	}
-	mutex_unlock(&icc_bw_lock);
 	mutex_unlock(&icc_lock);
 }
 EXPORT_SYMBOL_GPL(icc_sync_state);
 
 static int __init icc_init(void)
 {
-	struct device_node *root;
-
-	/* Teach lockdep about lock ordering wrt. shrinker: */
-	fs_reclaim_acquire(GFP_KERNEL);
-	might_lock(&icc_bw_lock);
-	fs_reclaim_release(GFP_KERNEL);
-
-	root = of_find_node_by_path("/");
+	struct device_node *root = of_find_node_by_path("/");
 
 	providers_count = of_count_icc_providers(root);
 	of_node_put(root);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index d805f8450719..a56906633ddf 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1000,10 +1000,12 @@ static int mmc_select_bus_width(struct mmc_card *card)
 	static unsigned ext_csd_bits[] = {
 		EXT_CSD_BUS_WIDTH_8,
 		EXT_CSD_BUS_WIDTH_4,
+		EXT_CSD_BUS_WIDTH_1,
 	};
 	static unsigned bus_widths[] = {
 		MMC_BUS_WIDTH_8,
 		MMC_BUS_WIDTH_4,
+		MMC_BUS_WIDTH_1,
 	};
 	struct mmc_host *host = card->host;
 	unsigned idx, bus_width = 0;
diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
index 8cf3a375de65..cc9d28b75eb9 100644
--- a/drivers/mmc/host/sdhci-xenon-phy.c
+++ b/drivers/mmc/host/sdhci-xenon-phy.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/ktime.h>
+#include <linux/iopoll.h>
 #include <linux/of_address.h>
 
 #include "sdhci-pltfm.h"
@@ -109,6 +110,8 @@
 #define XENON_EMMC_PHY_LOGIC_TIMING_ADJUST	(XENON_EMMC_PHY_REG_BASE + 0x18)
 #define XENON_LOGIC_TIMING_VALUE		0x00AA8977
 
+#define XENON_MAX_PHY_TIMEOUT_LOOPS		100
+
 /*
  * List offset of PHY registers and some special register values
  * in eMMC PHY 5.0 or eMMC PHY 5.1
@@ -216,6 +219,19 @@ static int xenon_alloc_emmc_phy(struct sdhci_host *host)
 	return 0;
 }
 
+static int xenon_check_stability_internal_clk(struct sdhci_host *host)
+{
+	u32 reg;
+	int err;
+
+	err = read_poll_timeout(sdhci_readw, reg, reg & SDHCI_CLOCK_INT_STABLE,
+				1100, 20000, false, host, SDHCI_CLOCK_CONTROL);
+	if (err)
+		dev_err(mmc_dev(host->mmc), "phy_init: Internal clock never stabilized.\n");
+
+	return err;
+}
+
 /*
  * eMMC 5.0/5.1 PHY init/re-init.
  * eMMC PHY init should be executed after:
@@ -232,6 +248,11 @@ static int xenon_emmc_phy_init(struct sdhci_host *host)
 	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	struct xenon_emmc_phy_regs *phy_regs = priv->emmc_phy_regs;
 
+	int ret = xenon_check_stability_internal_clk(host);
+
+	if (ret)
+		return ret;
+
 	reg = sdhci_readl(host, phy_regs->timing_adj);
 	reg |= XENON_PHY_INITIALIZAION;
 	sdhci_writel(host, reg, phy_regs->timing_adj);
@@ -259,18 +280,27 @@ static int xenon_emmc_phy_init(struct sdhci_host *host)
 	/* get the wait time */
 	wait /= clock;
 	wait++;
-	/* wait for host eMMC PHY init completes */
-	udelay(wait);
 
-	reg = sdhci_readl(host, phy_regs->timing_adj);
-	reg &= XENON_PHY_INITIALIZAION;
-	if (reg) {
+	/*
+	 * AC5X spec says bit must be polled until zero.
+	 * We see cases in which timeout can take longer
+	 * than the standard calculation on AC5X, which is
+	 * expected following the spec comment above.
+	 * According to the spec, we must wait as long as
+	 * it takes for that bit to toggle on AC5X.
+	 * Cap that with 100 delay loops so we won't get
+	 * stuck here forever:
+	 */
+
+	ret = read_poll_timeout(sdhci_readl, reg,
+				!(reg & XENON_PHY_INITIALIZAION),
+				wait, XENON_MAX_PHY_TIMEOUT_LOOPS * wait,
+				false, host, phy_regs->timing_adj);
+	if (ret)
 		dev_err(mmc_dev(host->mmc), "eMMC PHY init cannot complete after %d us\n",
-			wait);
-		return -ETIMEDOUT;
-	}
+			wait * XENON_MAX_PHY_TIMEOUT_LOOPS);
 
-	return 0;
+	return ret;
 }
 
 #define ARMADA_3700_SOC_PAD_1_8V	0x1
diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index da77ab20296e..56d1b56615f9 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -178,7 +178,7 @@ static int gd5fxgq4uexxg_ecc_get_status(struct spinand_device *spinand,
 {
 	u8 status2;
 	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(GD5FXGQXXEXXG_REG_STATUS2,
-						      &status2);
+						      spinand->scratchbuf);
 	int ret;
 
 	switch (status & STATUS_ECC_MASK) {
@@ -199,6 +199,7 @@ static int gd5fxgq4uexxg_ecc_get_status(struct spinand_device *spinand,
 		 * report the maximum of 4 in this case
 		 */
 		/* bits sorted this way (3...0): ECCS1,ECCS0,ECCSE1,ECCSE0 */
+		status2 = *(spinand->scratchbuf);
 		return ((status & STATUS_ECC_MASK) >> 2) |
 			((status2 & STATUS_ECC_MASK) >> 4);
 
@@ -220,7 +221,7 @@ static int gd5fxgq5xexxg_ecc_get_status(struct spinand_device *spinand,
 {
 	u8 status2;
 	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(GD5FXGQXXEXXG_REG_STATUS2,
-						      &status2);
+						      spinand->scratchbuf);
 	int ret;
 
 	switch (status & STATUS_ECC_MASK) {
@@ -240,6 +241,7 @@ static int gd5fxgq5xexxg_ecc_get_status(struct spinand_device *spinand,
 		 * 1 ... 4 bits are flipped (and corrected)
 		 */
 		/* bits sorted this way (1...0): ECCSE1, ECCSE0 */
+		status2 = *(spinand->scratchbuf);
 		return ((status2 & STATUS_ECC_MASK) >> 4) + 1;
 
 	case STATUS_ECC_UNCOR_ERROR:
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 9cdb7a856ab6..1a1575e8577a 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -826,7 +826,7 @@ static void igb_ptp_tx_hwtstamp(struct igb_adapter *adapter)
 
 	igb_ptp_systim_to_hwtstamp(adapter, &shhwtstamps, regval);
 	/* adjust timestamp for the TX latency based on link speed */
-	if (adapter->hw.mac.type == e1000_i210) {
+	if (hw->mac.type == e1000_i210 || hw->mac.type == e1000_i211) {
 		switch (adapter->link_speed) {
 		case SPEED_10:
 			adjust = IGB_I210_TX_LATENCY_10;
@@ -872,6 +872,7 @@ int igb_ptp_rx_pktstamp(struct igb_q_vector *q_vector, void *va,
 			ktime_t *timestamp)
 {
 	struct igb_adapter *adapter = q_vector->adapter;
+	struct e1000_hw *hw = &adapter->hw;
 	struct skb_shared_hwtstamps ts;
 	__le64 *regval = (__le64 *)va;
 	int adjust = 0;
@@ -891,7 +892,7 @@ int igb_ptp_rx_pktstamp(struct igb_q_vector *q_vector, void *va,
 	igb_ptp_systim_to_hwtstamp(adapter, &ts, le64_to_cpu(regval[1]));
 
 	/* adjust timestamp for the RX latency based on link speed */
-	if (adapter->hw.mac.type == e1000_i210) {
+	if (hw->mac.type == e1000_i210 || hw->mac.type == e1000_i211) {
 		switch (adapter->link_speed) {
 		case SPEED_10:
 			adjust = IGB_I210_RX_LATENCY_10;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a1c1e353ca07..b0ab8f6986f8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3825,8 +3825,10 @@ static void stmmac_fpe_stop_wq(struct stmmac_priv *priv)
 {
 	set_bit(__FPE_REMOVING, &priv->fpe_task_state);
 
-	if (priv->fpe_wq)
+	if (priv->fpe_wq) {
 		destroy_workqueue(priv->fpe_wq);
+		priv->fpe_wq = NULL;
+	}
 
 	netdev_info(priv->dev, "FPE workqueue stop");
 }
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index b656fbb5ba54..ce93316f5f11 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1422,26 +1422,26 @@ static int __init gtp_init(void)
 
 	get_random_bytes(&gtp_h_initval, sizeof(gtp_h_initval));
 
-	err = rtnl_link_register(&gtp_link_ops);
+	err = register_pernet_subsys(&gtp_net_ops);
 	if (err < 0)
 		goto error_out;
 
-	err = register_pernet_subsys(&gtp_net_ops);
+	err = rtnl_link_register(&gtp_link_ops);
 	if (err < 0)
-		goto unreg_rtnl_link;
+		goto unreg_pernet_subsys;
 
 	err = genl_register_family(&gtp_genl_family);
 	if (err < 0)
-		goto unreg_pernet_subsys;
+		goto unreg_rtnl_link;
 
 	pr_info("GTP module loaded (pdp ctx size %zd bytes)\n",
 		sizeof(struct pdp_ctx));
 	return 0;
 
-unreg_pernet_subsys:
-	unregister_pernet_subsys(&gtp_net_ops);
 unreg_rtnl_link:
 	rtnl_link_unregister(&gtp_link_ops);
+unreg_pernet_subsys:
+	unregister_pernet_subsys(&gtp_net_ops);
 error_out:
 	pr_err("error loading GTP module loaded\n");
 	return err;
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 603530e6cd7b..42bf0a3ec632 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -654,6 +654,7 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
 				   tun->tfiles[tun->numqueues - 1]);
 		ntfile = rtnl_dereference(tun->tfiles[index]);
 		ntfile->queue_index = index;
+		ntfile->xdp_rxq.queue_index = index;
 		rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
 				   NULL);
 
diff --git a/drivers/net/usb/dm9601.c b/drivers/net/usb/dm9601.c
index 1959e12a3ff8..f7357d884d6a 100644
--- a/drivers/net/usb/dm9601.c
+++ b/drivers/net/usb/dm9601.c
@@ -232,7 +232,7 @@ static int dm9601_mdio_read(struct net_device *netdev, int phy_id, int loc)
 	err = dm_read_shared_word(dev, 1, loc, &res);
 	if (err < 0) {
 		netdev_err(dev->net, "MDIO read error: %d\n", err);
-		return err;
+		return 0;
 	}
 
 	netdev_dbg(dev->net,
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 5700c9d20a3e..c8b42892655a 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2862,7 +2862,8 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 	if (dev->chipid == ID_REV_CHIP_ID_7801_)
 		buf &= ~MAC_CR_GMII_EN_;
 
-	if (dev->chipid == ID_REV_CHIP_ID_7800_) {
+	if (dev->chipid == ID_REV_CHIP_ID_7800_ ||
+	    dev->chipid == ID_REV_CHIP_ID_7850_) {
 		ret = lan78xx_read_raw_eeprom(dev, 0, 1, &sig);
 		if (!ret && sig != EEPROM_INDICATOR) {
 			/* Implies there is no external eeprom. Set mac speed */
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 984a15380409..0102f86d4867 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1079,14 +1079,6 @@ static int veth_enable_xdp(struct net_device *dev)
 				veth_disable_xdp_range(dev, 0, dev->real_num_rx_queues, true);
 				return err;
 			}
-
-			if (!veth_gro_requested(dev)) {
-				/* user-space did not require GRO, but adding XDP
-				 * is supposed to get GRO working
-				 */
-				dev->features |= NETIF_F_GRO;
-				netdev_features_change(dev);
-			}
 		}
 	}
 
@@ -1106,18 +1098,9 @@ static void veth_disable_xdp(struct net_device *dev)
 	for (i = 0; i < dev->real_num_rx_queues; i++)
 		rcu_assign_pointer(priv->rq[i].xdp_prog, NULL);
 
-	if (!netif_running(dev) || !veth_gro_requested(dev)) {
+	if (!netif_running(dev) || !veth_gro_requested(dev))
 		veth_napi_del(dev);
 
-		/* if user-space did not require GRO, since adding XDP
-		 * enabled it, clear it now
-		 */
-		if (!veth_gro_requested(dev) && netif_running(dev)) {
-			dev->features &= ~NETIF_F_GRO;
-			netdev_features_change(dev);
-		}
-	}
-
 	veth_disable_xdp_range(dev, 0, dev->real_num_rx_queues, false);
 }
 
@@ -1320,7 +1303,8 @@ static int veth_alloc_queues(struct net_device *dev)
 	struct veth_priv *priv = netdev_priv(dev);
 	int i;
 
-	priv->rq = kcalloc(dev->num_rx_queues, sizeof(*priv->rq), GFP_KERNEL);
+	priv->rq = kvcalloc(dev->num_rx_queues, sizeof(*priv->rq),
+			    GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
 	if (!priv->rq)
 		return -ENOMEM;
 
@@ -1336,7 +1320,7 @@ static void veth_free_queues(struct net_device *dev)
 {
 	struct veth_priv *priv = netdev_priv(dev);
 
-	kfree(priv->rq);
+	kvfree(priv->rq);
 }
 
 static int veth_dev_init(struct net_device *dev)
@@ -1497,6 +1481,14 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		}
 
 		if (!old_prog) {
+			if (!veth_gro_requested(dev)) {
+				/* user-space did not require GRO, but adding
+				 * XDP is supposed to get GRO working
+				 */
+				dev->features |= NETIF_F_GRO;
+				netdev_features_change(dev);
+			}
+
 			peer->hw_features &= ~NETIF_F_GSO_SOFTWARE;
 			peer->max_mtu = max_mtu;
 		}
@@ -1507,6 +1499,14 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			if (dev->flags & IFF_UP)
 				veth_disable_xdp(dev);
 
+			/* if user-space did not require GRO, since adding XDP
+			 * enabled it, clear it now
+			 */
+			if (!veth_gro_requested(dev)) {
+				dev->features &= ~NETIF_F_GRO;
+				netdev_features_change(dev);
+			}
+
 			if (peer) {
 				peer->hw_features |= NETIF_F_GSO_SOFTWARE;
 				peer->max_mtu = ETH_MAX_MTU;
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index b722ee2d7e14..4e5d773b3bf8 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -209,7 +209,9 @@ static int bq27xxx_battery_i2c_remove(struct i2c_client *client)
 {
 	struct bq27xxx_device_info *di = i2c_get_clientdata(client);
 
-	free_irq(client->irq, di);
+	if (client->irq)
+		free_irq(client->irq, di);
+
 	bq27xxx_battery_teardown(di);
 
 	mutex_lock(&battery_mutex);
diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index d98cc8c2e5d5..c44876a675dc 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -351,12 +351,15 @@ static int rpmhpd_aggregate_corner(struct rpmhpd *pd, unsigned int corner)
 	unsigned int active_corner, sleep_corner;
 	unsigned int this_active_corner = 0, this_sleep_corner = 0;
 	unsigned int peer_active_corner = 0, peer_sleep_corner = 0;
+	unsigned int peer_enabled_corner;
 
 	to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
 
-	if (peer && peer->enabled)
-		to_active_sleep(peer, peer->corner, &peer_active_corner,
+	if (peer && peer->enabled) {
+		peer_enabled_corner = max(peer->corner, peer->enable_corner);
+		to_active_sleep(peer, peer_enabled_corner, &peer_active_corner,
 				&peer_sleep_corner);
+	}
 
 	active_corner = max(this_active_corner, peer_active_corner);
 
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index b6712655ec1f..b163b54b868e 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2409,11 +2409,9 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	int resize, ret, old_userfont, old_width, old_height, old_charcount;
-	char *old_data = NULL;
+	u8 *old_data = vc->vc_font.data;
 
 	resize = (w != vc->vc_font.width) || (h != vc->vc_font.height);
-	if (p->userfont)
-		old_data = vc->vc_font.data;
 	vc->vc_font.data = (void *)(p->fontdata = data);
 	old_userfont = p->userfont;
 	if ((p->userfont = userfont))
@@ -2447,13 +2445,13 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 		update_screen(vc);
 	}
 
-	if (old_data && (--REFCOUNT(old_data) == 0))
+	if (old_userfont && (--REFCOUNT(old_data) == 0))
 		kfree(old_data - FONT_EXTRA_WORDS * sizeof(int));
 	return 0;
 
 err_out:
 	p->fontdata = old_data;
-	vc->vc_font.data = (void *)old_data;
+	vc->vc_font.data = old_data;
 
 	if (userfont) {
 		p->userfont = old_userfont;
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 106426de5027..c4e22e9f7a66 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -497,8 +497,10 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
 		    dire->u.name[0] == '.' &&
 		    ctx->actor != afs_lookup_filldir &&
 		    ctx->actor != afs_lookup_one_filldir &&
-		    memcmp(dire->u.name, ".__afs", 6) == 0)
+		    memcmp(dire->u.name, ".__afs", 6) == 0) {
+			ctx->pos = blkoff + next * sizeof(union afs_xdr_dirent);
 			continue;
+		}
 
 		/* found the next entry */
 		if (!dir_emit(ctx, dire->u.name, nlen,
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 03d8a2d49bf4..aa03f2bbcc11 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -763,6 +763,23 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+static int btrfs_check_replace_dev_names(struct btrfs_ioctl_dev_replace_args *args)
+{
+	if (args->start.srcdevid == 0) {
+		if (memchr(args->start.srcdev_name, 0,
+			   sizeof(args->start.srcdev_name)) == NULL)
+			return -ENAMETOOLONG;
+	} else {
+		args->start.srcdev_name[0] = 0;
+	}
+
+	if (memchr(args->start.tgtdev_name, 0,
+		   sizeof(args->start.tgtdev_name)) == NULL)
+	    return -ENAMETOOLONG;
+
+	return 0;
+}
+
 int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
 			    struct btrfs_ioctl_dev_replace_args *args)
 {
@@ -775,10 +792,9 @@ int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
 	default:
 		return -EINVAL;
 	}
-
-	if ((args->start.srcdevid == 0 && args->start.srcdev_name[0] == '\0') ||
-	    args->start.tgtdev_name[0] == '\0')
-		return -EINVAL;
+	ret = btrfs_check_replace_dev_names(args);
+	if (ret < 0)
+		return ret;
 
 	ret = btrfs_dev_replace_start(fs_info, args->start.tgtdev_name,
 					args->start.srcdevid,
diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
index 146291be6263..8609a94639c8 100644
--- a/fs/cachefiles/bind.c
+++ b/fs/cachefiles/bind.c
@@ -249,6 +249,8 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 	kmem_cache_free(cachefiles_object_jar, fsdef);
 error_root_object:
 	cachefiles_end_secure(cache, saved_cred);
+	put_cred(cache->cache_cred);
+	cache->cache_cred = NULL;
 	pr_err("Failed to register: %d\n", ret);
 	return ret;
 }
@@ -269,6 +271,7 @@ void cachefiles_daemon_unbind(struct cachefiles_cache *cache)
 
 	dput(cache->graveyard);
 	mntput(cache->mnt);
+	put_cred(cache->cache_cred);
 
 	kfree(cache->rootdirname);
 	kfree(cache->secctx);
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 54379ee573b1..9b6004bc96de 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1234,6 +1234,7 @@ static int hugetlbfs_parse_param(struct fs_context *fc, struct fs_parameter *par
 {
 	struct hugetlbfs_fs_context *ctx = fc->fs_private;
 	struct fs_parse_result result;
+	struct hstate *h;
 	char *rest;
 	unsigned long ps;
 	int opt;
@@ -1278,11 +1279,12 @@ static int hugetlbfs_parse_param(struct fs_context *fc, struct fs_parameter *par
 
 	case Opt_pagesize:
 		ps = memparse(param->string, &rest);
-		ctx->hstate = size_to_hstate(ps);
-		if (!ctx->hstate) {
+		h = size_to_hstate(ps);
+		if (!h) {
 			pr_err("Unsupported page size %lu MB\n", ps >> 20);
 			return -EINVAL;
 		}
+		ctx->hstate = h;
 		return 0;
 
 	case Opt_min_size:
diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index e20c2db0f2c1..c69cbd64b5b4 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -376,13 +376,13 @@ struct nf_nat_hook {
 				  enum ip_conntrack_dir dir);
 };
 
-extern struct nf_nat_hook __rcu *nf_nat_hook;
+extern const struct nf_nat_hook __rcu *nf_nat_hook;
 
 static inline void
 nf_nat_decode_session(struct sk_buff *skb, struct flowi *fl, u_int8_t family)
 {
 #if IS_ENABLED(CONFIG_NF_NAT)
-	struct nf_nat_hook *nat_hook;
+	const struct nf_nat_hook *nat_hook;
 
 	rcu_read_lock();
 	nat_hook = rcu_dereference(nf_nat_hook);
@@ -435,13 +435,14 @@ nf_nat_decode_session(struct sk_buff *skb, struct flowi *fl, u_int8_t family)
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 #include <linux/netfilter/nf_conntrack_zones_common.h>
 
-extern void (*ip_ct_attach)(struct sk_buff *, const struct sk_buff *) __rcu;
 void nf_ct_attach(struct sk_buff *, const struct sk_buff *);
+void nf_ct_set_closing(struct nf_conntrack *nfct);
 struct nf_conntrack_tuple;
 bool nf_ct_get_tuple_skb(struct nf_conntrack_tuple *dst_tuple,
 			 const struct sk_buff *skb);
 #else
 static inline void nf_ct_attach(struct sk_buff *new, struct sk_buff *skb) {}
+static inline void nf_ct_set_closing(struct nf_conntrack *nfct) {}
 struct nf_conntrack_tuple;
 static inline bool nf_ct_get_tuple_skb(struct nf_conntrack_tuple *dst_tuple,
 				       const struct sk_buff *skb)
@@ -458,8 +459,11 @@ struct nf_ct_hook {
 	void (*destroy)(struct nf_conntrack *);
 	bool (*get_tuple_skb)(struct nf_conntrack_tuple *,
 			      const struct sk_buff *);
+	void (*attach)(struct sk_buff *nskb, const struct sk_buff *skb);
+	void (*set_closing)(struct nf_conntrack *nfct);
+	int (*confirm)(struct sk_buff *skb);
 };
-extern struct nf_ct_hook __rcu *nf_ct_hook;
+extern const struct nf_ct_hook __rcu *nf_ct_hook;
 
 struct nlattr;
 
@@ -474,7 +478,7 @@ struct nfnl_ct_hook {
 	void (*seq_adjust)(struct sk_buff *skb, struct nf_conn *ct,
 			   enum ip_conntrack_info ctinfo, s32 off);
 };
-extern struct nfnl_ct_hook __rcu *nfnl_ct_hook;
+extern const struct nfnl_ct_hook __rcu *nfnl_ct_hook;
 
 /**
  * nf_skb_duplicated - TEE target has sent a packet
diff --git a/include/net/ipv6_stubs.h b/include/net/ipv6_stubs.h
index 45e0339be6fa..4e838636dd34 100644
--- a/include/net/ipv6_stubs.h
+++ b/include/net/ipv6_stubs.h
@@ -81,6 +81,11 @@ struct ipv6_bpf_stub {
 				     const struct in6_addr *daddr, __be16 dport,
 				     int dif, int sdif, struct udp_table *tbl,
 				     struct sk_buff *skb);
+	int (*ipv6_dev_get_saddr)(struct net *net,
+				  const struct net_device *dst_dev,
+				  const struct in6_addr *daddr,
+				  unsigned int prefs,
+				  struct in6_addr *saddr);
 };
 extern const struct ipv6_bpf_stub *ipv6_bpf_stub __read_mostly;
 
diff --git a/include/net/netfilter/nf_conntrack.h b/include/net/netfilter/nf_conntrack.h
index 34c266502a50..39541ab912a1 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -123,6 +123,12 @@ struct nf_conn {
 	union nf_conntrack_proto proto;
 };
 
+static inline struct nf_conn *
+nf_ct_to_nf_conn(const struct nf_conntrack *nfct)
+{
+	return container_of(nfct, struct nf_conn, ct_general);
+}
+
 static inline struct nf_conn *
 nf_ct_tuplehash_to_ctrack(const struct nf_conntrack_tuple_hash *hash)
 {
@@ -173,6 +179,8 @@ nf_ct_get(const struct sk_buff *skb, enum ip_conntrack_info *ctinfo)
 
 void nf_ct_destroy(struct nf_conntrack *nfct);
 
+void nf_conntrack_tcp_set_closing(struct nf_conn *ct);
+
 /* decrement reference count on a conntrack */
 static inline void nf_ct_put(struct nf_conn *ct)
 {
diff --git a/include/net/strparser.h b/include/net/strparser.h
index 732b7097d78e..a191486eb1e4 100644
--- a/include/net/strparser.h
+++ b/include/net/strparser.h
@@ -70,6 +70,10 @@ struct sk_skb_cb {
 	 * when dst_reg == src_reg.
 	 */
 	u64 temp_reg;
+	struct tls_msg {
+		u8 control;
+		u8 decrypted;
+	} tls;
 };
 
 static inline struct strp_msg *strp_msg(struct sk_buff *skb)
diff --git a/include/net/tls.h b/include/net/tls.h
index eda0015c5c59..ea0aeae26cf7 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -116,11 +116,6 @@ struct tls_rec {
 	u8 aead_req_ctx[];
 };
 
-struct tls_msg {
-	struct strp_msg rxm;
-	u8 control;
-};
-
 struct tx_work {
 	struct delayed_work work;
 	struct sock *sk;
@@ -151,9 +146,7 @@ struct tls_sw_context_rx {
 	void (*saved_data_ready)(struct sock *sk);
 
 	struct sk_buff *recv_pkt;
-	u8 control;
 	u8 async_capable:1;
-	u8 decrypted:1;
 	atomic_t decrypt_pending;
 	/* protect crypto_wait with decrypt_pending*/
 	spinlock_t decrypt_compl_lock;
@@ -410,7 +403,9 @@ void tls_free_partial_record(struct sock *sk, struct tls_context *ctx);
 
 static inline struct tls_msg *tls_msg(struct sk_buff *skb)
 {
-	return (struct tls_msg *)strp_msg(skb);
+	struct sk_skb_cb *scb = (struct sk_skb_cb *)skb->cb;
+
+	return &scb->tls;
 }
 
 static inline bool tls_is_partially_sent_record(struct tls_context *ctx)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 1da082a8c4ec..bdb5f2ba769d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3011,9 +3011,23 @@ union bpf_attr {
  *		**BPF_FIB_LOOKUP_DIRECT**
  *			Do a direct table lookup vs full lookup using FIB
  *			rules.
+ *		**BPF_FIB_LOOKUP_TBID**
+ *			Used with BPF_FIB_LOOKUP_DIRECT.
+ *			Use the routing table ID present in *params*->tbid
+ *			for the fib lookup.
  *		**BPF_FIB_LOOKUP_OUTPUT**
  *			Perform lookup from an egress perspective (default is
  *			ingress).
+ *		**BPF_FIB_LOOKUP_SKIP_NEIGH**
+ *			Skip the neighbour table lookup. *params*->dmac
+ *			and *params*->smac will not be set as output. A common
+ *			use case is to call **bpf_redirect_neigh**\ () after
+ *			doing **bpf_fib_lookup**\ ().
+ *		**BPF_FIB_LOOKUP_SRC**
+ *			Derive and set source IP addr in *params*->ipv{4,6}_src
+ *			for the nexthop. If the src addr cannot be derived,
+ *			**BPF_FIB_LKUP_RET_NO_SRC_ADDR** is returned. In this
+ *			case, *params*->dmac and *params*->smac are not set either.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -6040,6 +6054,9 @@ struct bpf_raw_tracepoint_args {
 enum {
 	BPF_FIB_LOOKUP_DIRECT  = (1U << 0),
 	BPF_FIB_LOOKUP_OUTPUT  = (1U << 1),
+	BPF_FIB_LOOKUP_SKIP_NEIGH = (1U << 2),
+	BPF_FIB_LOOKUP_TBID    = (1U << 3),
+	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 };
 
 enum {
@@ -6052,6 +6069,7 @@ enum {
 	BPF_FIB_LKUP_RET_UNSUPP_LWT,   /* fwd requires encapsulation */
 	BPF_FIB_LKUP_RET_NO_NEIGH,     /* no neighbor entry for nh */
 	BPF_FIB_LKUP_RET_FRAG_NEEDED,  /* fragmentation required to fwd */
+	BPF_FIB_LKUP_RET_NO_SRC_ADDR,  /* failed to derive IP src addr */
 };
 
 struct bpf_fib_lookup {
@@ -6086,6 +6104,9 @@ struct bpf_fib_lookup {
 		__u32	rt_metric;
 	};
 
+	/* input: source address to consider for lookup
+	 * output: source address result from lookup
+	 */
 	union {
 		__be32		ipv4_src;
 		__u32		ipv6_src[4];  /* in6_addr; network order */
@@ -6100,9 +6121,19 @@ struct bpf_fib_lookup {
 		__u32		ipv6_dst[4];  /* in6_addr; network order */
 	};
 
-	/* output */
-	__be16	h_vlan_proto;
-	__be16	h_vlan_TCI;
+	union {
+		struct {
+			/* output */
+			__be16	h_vlan_proto;
+			__be16	h_vlan_TCI;
+		};
+		/* input: when accompanied with the
+		 * 'BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_TBID` flags, a
+		 * specific routing table to use for the fib lookup.
+		 */
+		__u32	tbid;
+	};
+
 	__u8	smac[6];     /* ETH_ALEN */
 	__u8	dmac[6];     /* ETH_ALEN */
 };
diff --git a/include/uapi/linux/in6.h b/include/uapi/linux/in6.h
index c4c53a9ab959..ff8d21f9e95b 100644
--- a/include/uapi/linux/in6.h
+++ b/include/uapi/linux/in6.h
@@ -145,7 +145,7 @@ struct in6_flowlabel_req {
 #define IPV6_TLV_PADN		1
 #define IPV6_TLV_ROUTERALERT	5
 #define IPV6_TLV_CALIPSO	7	/* RFC 5570 */
-#define IPV6_TLV_IOAM		49	/* TEMPORARY IANA allocation for IOAM */
+#define IPV6_TLV_IOAM		49	/* RFC 9486 */
 #define IPV6_TLV_JUMBO		194
 #define IPV6_TLV_HAO		201	/* home address option */
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b3b597960c56..a8854b24f4cf 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2330,6 +2330,7 @@ static void hci_error_reset(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev, error_reset);
 
+	hci_dev_hold(hdev);
 	BT_DBG("%s", hdev->name);
 
 	if (hdev->hw_error)
@@ -2337,10 +2338,10 @@ static void hci_error_reset(struct work_struct *work)
 	else
 		bt_dev_err(hdev, "hardware error 0x%2.2x", hdev->hw_error_code);
 
-	if (hci_dev_do_close(hdev))
-		return;
+	if (!hci_dev_do_close(hdev))
+		hci_dev_do_open(hdev);
 
-	hci_dev_do_open(hdev);
+	hci_dev_put(hdev);
 }
 
 void hci_uuids_clear(struct hci_dev *hdev)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2ad2f4647847..ba7242729a8f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4720,9 +4720,12 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-	if (!conn || !hci_conn_ssp_enabled(conn))
+	if (!conn || !hci_dev_test_flag(hdev, HCI_SSP_ENABLED))
 		goto unlock;
 
+	/* Assume remote supports SSP since it has triggered this event */
+	set_bit(HCI_CONN_SSP_ENABLED, &conn->flags);
+
 	hci_conn_hold(conn);
 
 	if (!hci_dev_test_flag(hdev, HCI_MGMT))
@@ -6055,6 +6058,10 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 		return send_conn_param_neg_reply(hdev, handle,
 						 HCI_ERROR_UNKNOWN_CONN_ID);
 
+	if (max > hcon->le_conn_max_interval)
+		return send_conn_param_neg_reply(hdev, handle,
+						 HCI_ERROR_INVALID_LL_PARAMS);
+
 	if (hci_check_conn_params(min, max, latency, timeout))
 		return send_conn_param_neg_reply(hdev, handle,
 						 HCI_ERROR_INVALID_LL_PARAMS);
@@ -6272,10 +6279,10 @@ static void hci_store_wake_reason(struct hci_dev *hdev, u8 event,
 	 * keep track of the bdaddr of the connection event that woke us up.
 	 */
 	if (event == HCI_EV_CONN_REQUEST) {
-		bacpy(&hdev->wake_addr, &conn_complete->bdaddr);
+		bacpy(&hdev->wake_addr, &conn_request->bdaddr);
 		hdev->wake_addr_type = BDADDR_BREDR;
 	} else if (event == HCI_EV_CONN_COMPLETE) {
-		bacpy(&hdev->wake_addr, &conn_request->bdaddr);
+		bacpy(&hdev->wake_addr, &conn_complete->bdaddr);
 		hdev->wake_addr_type = BDADDR_BREDR;
 	} else if (event == HCI_EV_LE_META) {
 		struct hci_ev_le_meta *le_ev = (void *)skb->data;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 850b6aab7377..11bfc8737e6c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5614,7 +5614,13 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 
 	memset(&rsp, 0, sizeof(rsp));
 
-	err = hci_check_conn_params(min, max, latency, to_multiplier);
+	if (max > hcon->le_conn_max_interval) {
+		BT_DBG("requested connection interval exceeds current bounds.");
+		err = -EINVAL;
+	} else {
+		err = hci_check_conn_params(min, max, latency, to_multiplier);
+	}
+
 	if (err)
 		rsp.result = cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
 	else
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index f14beb9a62ed..8a114a500046 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -43,6 +43,10 @@
 #include <linux/sysctl.h>
 #endif
 
+#if IS_ENABLED(CONFIG_NF_CONNTRACK)
+#include <net/netfilter/nf_conntrack_core.h>
+#endif
+
 static unsigned int brnf_net_id __read_mostly;
 
 struct brnf_net {
@@ -537,6 +541,90 @@ static unsigned int br_nf_pre_routing(void *priv,
 	return NF_STOLEN;
 }
 
+#if IS_ENABLED(CONFIG_NF_CONNTRACK)
+/* conntracks' nf_confirm logic cannot handle cloned skbs referencing
+ * the same nf_conn entry, which will happen for multicast (broadcast)
+ * Frames on bridges.
+ *
+ * Example:
+ *      macvlan0
+ *      br0
+ *  ethX  ethY
+ *
+ * ethX (or Y) receives multicast or broadcast packet containing
+ * an IP packet, not yet in conntrack table.
+ *
+ * 1. skb passes through bridge and fake-ip (br_netfilter)Prerouting.
+ *    -> skb->_nfct now references a unconfirmed entry
+ * 2. skb is broad/mcast packet. bridge now passes clones out on each bridge
+ *    interface.
+ * 3. skb gets passed up the stack.
+ * 4. In macvlan case, macvlan driver retains clone(s) of the mcast skb
+ *    and schedules a work queue to send them out on the lower devices.
+ *
+ *    The clone skb->_nfct is not a copy, it is the same entry as the
+ *    original skb.  The macvlan rx handler then returns RX_HANDLER_PASS.
+ * 5. Normal conntrack hooks (in NF_INET_LOCAL_IN) confirm the orig skb.
+ *
+ * The Macvlan broadcast worker and normal confirm path will race.
+ *
+ * This race will not happen if step 2 already confirmed a clone. In that
+ * case later steps perform skb_clone() with skb->_nfct already confirmed (in
+ * hash table).  This works fine.
+ *
+ * But such confirmation won't happen when eb/ip/nftables rules dropped the
+ * packets before they reached the nf_confirm step in postrouting.
+ *
+ * Work around this problem by explicit confirmation of the entry at
+ * LOCAL_IN time, before upper layer has a chance to clone the unconfirmed
+ * entry.
+ *
+ */
+static unsigned int br_nf_local_in(void *priv,
+				   struct sk_buff *skb,
+				   const struct nf_hook_state *state)
+{
+	struct nf_conntrack *nfct = skb_nfct(skb);
+	const struct nf_ct_hook *ct_hook;
+	struct nf_conn *ct;
+	int ret;
+
+	if (!nfct || skb->pkt_type == PACKET_HOST)
+		return NF_ACCEPT;
+
+	ct = container_of(nfct, struct nf_conn, ct_general);
+	if (likely(nf_ct_is_confirmed(ct)))
+		return NF_ACCEPT;
+
+	WARN_ON_ONCE(skb_shared(skb));
+	WARN_ON_ONCE(refcount_read(&nfct->use) != 1);
+
+	/* We can't call nf_confirm here, it would create a dependency
+	 * on nf_conntrack module.
+	 */
+	ct_hook = rcu_dereference(nf_ct_hook);
+	if (!ct_hook) {
+		skb->_nfct = 0ul;
+		nf_conntrack_put(nfct);
+		return NF_ACCEPT;
+	}
+
+	nf_bridge_pull_encap_header(skb);
+	ret = ct_hook->confirm(skb);
+	switch (ret & NF_VERDICT_MASK) {
+	case NF_STOLEN:
+		return NF_STOLEN;
+	default:
+		nf_bridge_push_encap_header(skb);
+		break;
+	}
+
+	ct = container_of(nfct, struct nf_conn, ct_general);
+	WARN_ON_ONCE(!nf_ct_is_confirmed(ct));
+
+	return ret;
+}
+#endif
 
 /* PF_BRIDGE/FORWARD *************************************************/
 static int br_nf_forward_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
@@ -935,6 +1023,14 @@ static const struct nf_hook_ops br_nf_ops[] = {
 		.hooknum = NF_BR_PRE_ROUTING,
 		.priority = NF_BR_PRI_BRNF,
 	},
+#if IS_ENABLED(CONFIG_NF_CONNTRACK)
+	{
+		.hook = br_nf_local_in,
+		.pf = NFPROTO_BRIDGE,
+		.hooknum = NF_BR_LOCAL_IN,
+		.priority = NF_BR_PRI_LAST,
+	},
+#endif
 	{
 		.hook = br_nf_forward_ip,
 		.pf = NFPROTO_BRIDGE,
diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index d14b2dbbd1df..83743e95939b 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -290,6 +290,30 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 	return nf_conntrack_in(skb, &bridge_state);
 }
 
+static unsigned int nf_ct_bridge_in(void *priv, struct sk_buff *skb,
+				    const struct nf_hook_state *state)
+{
+	enum ip_conntrack_info ctinfo;
+	struct nf_conn *ct;
+
+	if (skb->pkt_type == PACKET_HOST)
+		return NF_ACCEPT;
+
+	/* nf_conntrack_confirm() cannot handle concurrent clones,
+	 * this happens for broad/multicast frames with e.g. macvlan on top
+	 * of the bridge device.
+	 */
+	ct = nf_ct_get(skb, &ctinfo);
+	if (!ct || nf_ct_is_confirmed(ct) || nf_ct_is_template(ct))
+		return NF_ACCEPT;
+
+	/* let inet prerouting call conntrack again */
+	skb->_nfct = 0;
+	nf_ct_put(ct);
+
+	return NF_ACCEPT;
+}
+
 static void nf_ct_bridge_frag_save(struct sk_buff *skb,
 				   struct nf_bridge_frag_data *data)
 {
@@ -414,6 +438,12 @@ static struct nf_hook_ops nf_ct_bridge_hook_ops[] __read_mostly = {
 		.hooknum	= NF_BR_PRE_ROUTING,
 		.priority	= NF_IP_PRI_CONNTRACK,
 	},
+	{
+		.hook		= nf_ct_bridge_in,
+		.pf		= NFPROTO_BRIDGE,
+		.hooknum	= NF_BR_LOCAL_IN,
+		.priority	= NF_IP_PRI_CONNTRACK_CONFIRM,
+	},
 	{
 		.hook		= nf_ct_bridge_post,
 		.pf		= NFPROTO_BRIDGE,
diff --git a/net/core/filter.c b/net/core/filter.c
index 0f5faa876fd1..f0a3cdc4d496 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5392,12 +5392,8 @@ static const struct bpf_func_proto bpf_skb_get_xfrm_state_proto = {
 #endif
 
 #if IS_ENABLED(CONFIG_INET) || IS_ENABLED(CONFIG_IPV6)
-static int bpf_fib_set_fwd_params(struct bpf_fib_lookup *params,
-				  const struct neighbour *neigh,
-				  const struct net_device *dev, u32 mtu)
+static int bpf_fib_set_fwd_params(struct bpf_fib_lookup *params, u32 mtu)
 {
-	memcpy(params->dmac, neigh->ha, ETH_ALEN);
-	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
 	params->h_vlan_TCI = 0;
 	params->h_vlan_proto = 0;
 	if (mtu)
@@ -5451,6 +5447,12 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 		u32 tbid = l3mdev_fib_table_rcu(dev) ? : RT_TABLE_MAIN;
 		struct fib_table *tb;
 
+		if (flags & BPF_FIB_LOOKUP_TBID) {
+			tbid = params->tbid;
+			/* zero out for vlan output */
+			params->tbid = 0;
+		}
+
 		tb = fib_get_table(net, tbid);
 		if (unlikely(!tb))
 			return BPF_FIB_LKUP_RET_NOT_FWDED;
@@ -5502,27 +5504,38 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	params->rt_metric = res.fi->fib_priority;
 	params->ifindex = dev->ifindex;
 
+	if (flags & BPF_FIB_LOOKUP_SRC)
+		params->ipv4_src = fib_result_prefsrc(net, &res);
+
 	/* xdp and cls_bpf programs are run in RCU-bh so
 	 * rcu_read_lock_bh is not needed here
 	 */
 	if (likely(nhc->nhc_gw_family != AF_INET6)) {
 		if (nhc->nhc_gw_family)
 			params->ipv4_dst = nhc->nhc_gw.ipv4;
-
-		neigh = __ipv4_neigh_lookup_noref(dev,
-						 (__force u32)params->ipv4_dst);
 	} else {
 		struct in6_addr *dst = (struct in6_addr *)params->ipv6_dst;
 
 		params->family = AF_INET6;
 		*dst = nhc->nhc_gw.ipv6;
-		neigh = __ipv6_neigh_lookup_noref_stub(dev, dst);
 	}
 
+	if (flags & BPF_FIB_LOOKUP_SKIP_NEIGH)
+		goto set_fwd_params;
+
+	if (likely(nhc->nhc_gw_family != AF_INET6))
+		neigh = __ipv4_neigh_lookup_noref(dev,
+						  (__force u32)params->ipv4_dst);
+	else
+		neigh = __ipv6_neigh_lookup_noref_stub(dev, params->ipv6_dst);
+
 	if (!neigh || !(neigh->nud_state & NUD_VALID))
 		return BPF_FIB_LKUP_RET_NO_NEIGH;
+	memcpy(params->dmac, neigh->ha, ETH_ALEN);
+	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
 
-	return bpf_fib_set_fwd_params(params, neigh, dev, mtu);
+set_fwd_params:
+	return bpf_fib_set_fwd_params(params, mtu);
 }
 #endif
 
@@ -5576,6 +5589,12 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 		u32 tbid = l3mdev_fib_table_rcu(dev) ? : RT_TABLE_MAIN;
 		struct fib6_table *tb;
 
+		if (flags & BPF_FIB_LOOKUP_TBID) {
+			tbid = params->tbid;
+			/* zero out for vlan output */
+			params->tbid = 0;
+		}
+
 		tb = ipv6_stub->fib6_get_table(net, tbid);
 		if (unlikely(!tb))
 			return BPF_FIB_LKUP_RET_NOT_FWDED;
@@ -5630,24 +5649,46 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	params->rt_metric = res.f6i->fib6_metric;
 	params->ifindex = dev->ifindex;
 
+	if (flags & BPF_FIB_LOOKUP_SRC) {
+		if (res.f6i->fib6_prefsrc.plen) {
+			*src = res.f6i->fib6_prefsrc.addr;
+		} else {
+			err = ipv6_bpf_stub->ipv6_dev_get_saddr(net, dev,
+								&fl6.daddr, 0,
+								src);
+			if (err)
+				return BPF_FIB_LKUP_RET_NO_SRC_ADDR;
+		}
+	}
+
+	if (flags & BPF_FIB_LOOKUP_SKIP_NEIGH)
+		goto set_fwd_params;
+
 	/* xdp and cls_bpf programs are run in RCU-bh so rcu_read_lock_bh is
 	 * not needed here.
 	 */
 	neigh = __ipv6_neigh_lookup_noref_stub(dev, dst);
 	if (!neigh || !(neigh->nud_state & NUD_VALID))
 		return BPF_FIB_LKUP_RET_NO_NEIGH;
+	memcpy(params->dmac, neigh->ha, ETH_ALEN);
+	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
 
-	return bpf_fib_set_fwd_params(params, neigh, dev, mtu);
+set_fwd_params:
+	return bpf_fib_set_fwd_params(params, mtu);
 }
 #endif
 
+#define BPF_FIB_LOOKUP_MASK (BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTPUT | \
+			     BPF_FIB_LOOKUP_SKIP_NEIGH | BPF_FIB_LOOKUP_TBID | \
+			     BPF_FIB_LOOKUP_SRC)
+
 BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
 	   struct bpf_fib_lookup *, params, int, plen, u32, flags)
 {
 	if (plen < sizeof(*params))
 		return -EINVAL;
 
-	if (flags & ~(BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTPUT))
+	if (flags & ~BPF_FIB_LOOKUP_MASK)
 		return -EINVAL;
 
 	switch (params->family) {
@@ -5685,7 +5726,7 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
 	if (plen < sizeof(*params))
 		return -EINVAL;
 
-	if (flags & ~(BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTPUT))
+	if (flags & ~BPF_FIB_LOOKUP_MASK)
 		return -EINVAL;
 
 	if (params->tot_len)
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 1b71e5c582bb..ef218e290dfb 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4925,10 +4925,9 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net *net = sock_net(skb->sk);
 	struct ifinfomsg *ifm;
 	struct net_device *dev;
-	struct nlattr *br_spec, *attr = NULL;
+	struct nlattr *br_spec, *attr, *br_flags_attr = NULL;
 	int rem, err = -EOPNOTSUPP;
 	u16 flags = 0;
-	bool have_flags = false;
 
 	if (nlmsg_len(nlh) < sizeof(*ifm))
 		return -EINVAL;
@@ -4946,11 +4945,11 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
 	if (br_spec) {
 		nla_for_each_nested(attr, br_spec, rem) {
-			if (nla_type(attr) == IFLA_BRIDGE_FLAGS && !have_flags) {
+			if (nla_type(attr) == IFLA_BRIDGE_FLAGS && !br_flags_attr) {
 				if (nla_len(attr) < sizeof(flags))
 					return -EINVAL;
 
-				have_flags = true;
+				br_flags_attr = attr;
 				flags = nla_get_u16(attr);
 			}
 
@@ -4994,8 +4993,8 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	if (have_flags)
-		memcpy(nla_data(attr), &flags, sizeof(flags));
+	if (br_flags_attr)
+		memcpy(nla_data(br_flags_attr), &flags, sizeof(flags));
 out:
 	return err;
 }
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 426dc910aaf8..96b7cd3049a3 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -540,6 +540,20 @@ static int tnl_update_pmtu(struct net_device *dev, struct sk_buff *skb,
 	return 0;
 }
 
+static void ip_tunnel_adj_headroom(struct net_device *dev, unsigned int headroom)
+{
+	/* we must cap headroom to some upperlimit, else pskb_expand_head
+	 * will overflow header offsets in skb_headers_offset_update().
+	 */
+	static const unsigned int max_allowed = 512;
+
+	if (headroom > max_allowed)
+		headroom = max_allowed;
+
+	if (headroom > READ_ONCE(dev->needed_headroom))
+		WRITE_ONCE(dev->needed_headroom, headroom);
+}
+
 void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		       u8 proto, int tunnel_hlen)
 {
@@ -613,13 +627,13 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	headroom += LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len;
-	if (headroom > READ_ONCE(dev->needed_headroom))
-		WRITE_ONCE(dev->needed_headroom, headroom);
-
-	if (skb_cow_head(skb, READ_ONCE(dev->needed_headroom))) {
+	if (skb_cow_head(skb, headroom)) {
 		ip_rt_put(rt);
 		goto tx_dropped;
 	}
+
+	ip_tunnel_adj_headroom(dev, headroom);
+
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, proto, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)));
 	return;
@@ -797,16 +811,16 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	max_headroom = LL_RESERVED_SPACE(rt->dst.dev) + sizeof(struct iphdr)
 			+ rt->dst.header_len + ip_encap_hlen(&tunnel->encap);
-	if (max_headroom > READ_ONCE(dev->needed_headroom))
-		WRITE_ONCE(dev->needed_headroom, max_headroom);
 
-	if (skb_cow_head(skb, READ_ONCE(dev->needed_headroom))) {
+	if (skb_cow_head(skb, max_headroom)) {
 		ip_rt_put(rt);
 		dev->stats.tx_dropped++;
 		kfree_skb(skb);
 		return;
 	}
 
+	ip_tunnel_adj_headroom(dev, max_headroom);
+
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)));
 	return;
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index f2edb40c0db0..350aaca12618 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -278,6 +278,7 @@ void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		goto free_nskb;
 
 	nf_ct_attach(nskb, oldskb);
+	nf_ct_set_closing(skb_nfct(oldskb));
 
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	/* If we use ip_local_out for bridged traffic, the MAC source on
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c52317184e3e..968ca078191c 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5463,9 +5463,10 @@ static int inet6_rtm_getaddr(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	}
 
 	addr = extract_addr(tb[IFA_ADDRESS], tb[IFA_LOCAL], &peer);
-	if (!addr)
-		return -EINVAL;
-
+	if (!addr) {
+		err = -EINVAL;
+		goto errout;
+	}
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifa_index)
 		dev = dev_get_by_index(tgt_net, ifm->ifa_index);
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 1da7fa58f714..8e0c33b68301 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -1061,6 +1061,7 @@ static const struct ipv6_stub ipv6_stub_impl = {
 static const struct ipv6_bpf_stub ipv6_bpf_stub_impl = {
 	.inet6_bind = __inet6_bind,
 	.udp6_lib_lookup = __udp6_lib_lookup,
+	.ipv6_dev_get_saddr = ipv6_dev_get_saddr,
 };
 
 static int __init inet6_init(void)
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index dffeaaaadcde..c0057edd84cf 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -345,6 +345,7 @@ void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 	nf_reject_ip6_tcphdr_put(nskb, oldskb, otcph, otcplen);
 
 	nf_ct_attach(nskb, oldskb);
+	nf_ct_set_closing(skb_nfct(oldskb));
 
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	/* If we use ip6_local_out for bridged traffic, the MAC source on
diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index e57c5f47f035..d7ca71c59754 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -21,6 +21,9 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
 	bool slow;
 	int err;
 
+	if (inet_sk_state_load(sk) == TCP_LISTEN)
+		return 0;
+
 	start = nla_nest_start_noflag(skb, INET_ULP_INFO_MPTCP);
 	if (!start)
 		return -EMSGSIZE;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 935f35175174..651f2c158637 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -38,7 +38,8 @@ struct mptcp_pm_add_entry {
 	u8			retrans_times;
 };
 
-#define MAX_ADDR_ID		255
+/* max value of mptcp_addr_info.id */
+#define MAX_ADDR_ID		U8_MAX
 #define BITMAP_SZ DIV_ROUND_UP(MAX_ADDR_ID + 1, BITS_PER_LONG)
 
 struct pm_nl_pernet {
@@ -822,7 +823,8 @@ static bool address_use_port(struct mptcp_pm_addr_entry *entry)
 }
 
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
-					     struct mptcp_pm_addr_entry *entry)
+					     struct mptcp_pm_addr_entry *entry,
+					     bool needs_id)
 {
 	struct mptcp_pm_addr_entry *cur;
 	unsigned int addr_max;
@@ -849,19 +851,18 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 			goto out;
 	}
 
-	if (!entry->addr.id) {
+	if (!entry->addr.id && needs_id) {
 find_next:
 		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
 						    MAX_ADDR_ID + 1,
 						    pernet->next_id);
-		if ((!entry->addr.id || entry->addr.id > MAX_ADDR_ID) &&
-		    pernet->next_id != 1) {
+		if (!entry->addr.id && pernet->next_id != 1) {
 			pernet->next_id = 1;
 			goto find_next;
 		}
 	}
 
-	if (!entry->addr.id || entry->addr.id > MAX_ADDR_ID)
+	if (!entry->addr.id && needs_id)
 		goto out;
 
 	__set_bit(entry->addr.id, pernet->id_bitmap);
@@ -1001,7 +1002,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	entry->ifindex = 0;
 	entry->flags = 0;
 	entry->lsk = NULL;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
 	if (ret < 0)
 		kfree(entry);
 
@@ -1202,6 +1203,18 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
 	return 0;
 }
 
+static bool mptcp_pm_has_addr_attr_id(const struct nlattr *attr,
+				      struct genl_info *info)
+{
+	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
+
+	if (!nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
+					 mptcp_pm_addr_policy, info->extack) &&
+	    tb[MPTCP_PM_ADDR_ATTR_ID])
+		return true;
+	return false;
+}
+
 static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
@@ -1228,7 +1241,8 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 			return ret;
 		}
 	}
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
+						!mptcp_pm_has_addr_attr_id(attr, info));
 	if (ret < 0) {
 		GENL_SET_ERR_MSG(info, "too many addresses or duplicate one");
 		if (entry->lsk)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8d3afa99ef65..5db1c0142abb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -330,7 +330,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	return false;
 }
 
-static void mptcp_stop_timer(struct sock *sk)
+static void mptcp_stop_rtx_timer(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
@@ -688,6 +688,46 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 	return moved;
 }
 
+static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
+{
+	int err = sock_error(ssk);
+	int ssk_state;
+
+	if (!err)
+		return false;
+
+	/* only propagate errors on fallen-back sockets or
+	 * on MPC connect
+	 */
+	if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(mptcp_sk(sk)))
+		return false;
+
+	/* We need to propagate only transition to CLOSE state.
+	 * Orphaned socket will see such state change via
+	 * subflow_sched_work_if_closed() and that path will properly
+	 * destroy the msk as needed.
+	 */
+	ssk_state = inet_sk_state_load(ssk);
+	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
+		inet_sk_state_store(sk, ssk_state);
+	WRITE_ONCE(sk->sk_err, -err);
+
+	/* This barrier is coupled with smp_rmb() in mptcp_poll() */
+	smp_wmb();
+	sk_error_report(sk);
+	return true;
+}
+
+void __mptcp_error_report(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	mptcp_for_each_subflow(msk, subflow)
+		if (__mptcp_subflow_error_report(sk, mptcp_subflow_tcp_sock(subflow)))
+			break;
+}
+
 /* In most cases we will be able to lock the mptcp socket.  If its already
  * owned, we need to defer to the work queue to avoid ABBA deadlock.
  */
@@ -790,12 +830,12 @@ static void mptcp_flush_join_list(struct mptcp_sock *msk)
 	mptcp_sockopt_sync_all(msk);
 }
 
-static bool mptcp_timer_pending(struct sock *sk)
+static bool mptcp_rtx_timer_pending(struct sock *sk)
 {
 	return timer_pending(&inet_csk(sk)->icsk_retransmit_timer);
 }
 
-static void mptcp_reset_timer(struct sock *sk)
+static void mptcp_reset_rtx_timer(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	unsigned long tout;
@@ -1105,10 +1145,10 @@ static void __mptcp_clean_una(struct sock *sk)
 		__mptcp_mem_reclaim_partial(sk);
 
 	if (snd_una == READ_ONCE(msk->snd_nxt) && !msk->recovery) {
-		if (mptcp_timer_pending(sk) && !mptcp_data_fin_enabled(msk))
-			mptcp_stop_timer(sk);
+		if (mptcp_rtx_timer_pending(sk) && !mptcp_data_fin_enabled(msk))
+			mptcp_stop_rtx_timer(sk);
 	} else {
-		mptcp_reset_timer(sk);
+		mptcp_reset_rtx_timer(sk);
 	}
 }
 
@@ -1310,6 +1350,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		mpext = skb_ext_find(skb, SKB_EXT_MPTCP);
 		if (!mptcp_skb_can_collapse_to(data_seq, skb, mpext)) {
 			TCP_SKB_CB(skb)->eor = 1;
+			tcp_mark_push(tcp_sk(ssk), skb);
 			goto alloc_skb;
 		}
 
@@ -1600,8 +1641,8 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 out:
 	/* ensure the rtx timer is running */
-	if (!mptcp_timer_pending(sk))
-		mptcp_reset_timer(sk);
+	if (!mptcp_rtx_timer_pending(sk))
+		mptcp_reset_rtx_timer(sk);
 	if (copied)
 		mptcp_check_send_data_fin(sk);
 }
@@ -1660,8 +1701,8 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 	if (copied) {
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
-		if (!mptcp_timer_pending(sk))
-			mptcp_reset_timer(sk);
+		if (!mptcp_rtx_timer_pending(sk))
+			mptcp_reset_rtx_timer(sk);
 
 		if (msk->snd_data_fin_enable &&
 		    msk->snd_nxt + 1 == msk->write_seq)
@@ -2133,7 +2174,7 @@ static void mptcp_retransmit_timer(struct timer_list *t)
 	sock_put(sk);
 }
 
-static void mptcp_timeout_timer(struct timer_list *t)
+static void mptcp_tout_timer(struct timer_list *t)
 {
 	struct sock *sk = from_timer(sk, t, sk_timer);
 
@@ -2273,6 +2314,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		/* close acquired an extra ref */
 		__sock_put(ssk);
 	}
+	__mptcp_subflow_error_report(sk, ssk);
 	release_sock(ssk);
 
 	sock_put(ssk);
@@ -2424,8 +2466,8 @@ static void __mptcp_retrans(struct sock *sk)
 	release_sock(ssk);
 
 reset_timer:
-	if (!mptcp_timer_pending(sk))
-		mptcp_reset_timer(sk);
+	if (!mptcp_rtx_timer_pending(sk))
+		mptcp_reset_rtx_timer(sk);
 }
 
 static void mptcp_worker(struct work_struct *work)
@@ -2502,7 +2544,7 @@ static int __mptcp_init_sock(struct sock *sk)
 
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
-	timer_setup(&sk->sk_timer, mptcp_timeout_timer, 0);
+	timer_setup(&sk->sk_timer, mptcp_tout_timer, 0);
 
 	return 0;
 }
@@ -2588,8 +2630,8 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 		} else {
 			pr_debug("Sending DATA_FIN on subflow %p", ssk);
 			tcp_send_ack(ssk);
-			if (!mptcp_timer_pending(sk))
-				mptcp_reset_timer(sk);
+			if (!mptcp_rtx_timer_pending(sk))
+				mptcp_reset_rtx_timer(sk);
 		}
 		break;
 	}
@@ -2814,8 +2856,50 @@ static struct ipv6_pinfo *mptcp_inet6_sk(const struct sock *sk)
 
 	return (struct ipv6_pinfo *)(((u8 *)sk) + offset);
 }
+
+static void mptcp_copy_ip6_options(struct sock *newsk, const struct sock *sk)
+{
+	const struct ipv6_pinfo *np = inet6_sk(sk);
+	struct ipv6_txoptions *opt;
+	struct ipv6_pinfo *newnp;
+
+	newnp = inet6_sk(newsk);
+
+	rcu_read_lock();
+	opt = rcu_dereference(np->opt);
+	if (opt) {
+		opt = ipv6_dup_options(newsk, opt);
+		if (!opt)
+			net_warn_ratelimited("%s: Failed to copy ip6 options\n", __func__);
+	}
+	RCU_INIT_POINTER(newnp->opt, opt);
+	rcu_read_unlock();
+}
 #endif
 
+static void mptcp_copy_ip_options(struct sock *newsk, const struct sock *sk)
+{
+	struct ip_options_rcu *inet_opt, *newopt = NULL;
+	const struct inet_sock *inet = inet_sk(sk);
+	struct inet_sock *newinet;
+
+	newinet = inet_sk(newsk);
+
+	rcu_read_lock();
+	inet_opt = rcu_dereference(inet->inet_opt);
+	if (inet_opt) {
+		newopt = sock_kmalloc(newsk, sizeof(*inet_opt) +
+				      inet_opt->opt.optlen, GFP_ATOMIC);
+		if (newopt)
+			memcpy(newopt, inet_opt, sizeof(*inet_opt) +
+			       inet_opt->opt.optlen);
+		else
+			net_warn_ratelimited("%s: Failed to copy ip options\n", __func__);
+	}
+	RCU_INIT_POINTER(newinet->inet_opt, newopt);
+	rcu_read_unlock();
+}
+
 struct sock *mptcp_sk_clone(const struct sock *sk,
 			    const struct mptcp_options_received *mp_opt,
 			    struct request_sock *req)
@@ -2836,6 +2920,13 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	nsk->sk_wait_pending = 0;
 	__mptcp_init_sock(nsk);
 
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	if (nsk->sk_family == AF_INET6)
+		mptcp_copy_ip6_options(nsk, sk);
+	else
+#endif
+		mptcp_copy_ip_options(nsk, sk);
+
 	msk = mptcp_sk(nsk);
 	msk->local_key = subflow_req->local_key;
 	msk->token = subflow_req->token;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 099bdfc12da9..80230787554e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1269,42 +1269,6 @@ void mptcp_space(const struct sock *ssk, int *space, int *full_space)
 	*full_space = tcp_full_space(sk);
 }
 
-void __mptcp_error_report(struct sock *sk)
-{
-	struct mptcp_subflow_context *subflow;
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		int err = sock_error(ssk);
-		int ssk_state;
-
-		if (!err)
-			continue;
-
-		/* only propagate errors on fallen-back sockets or
-		 * on MPC connect
-		 */
-		if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(msk))
-			continue;
-
-		/* We need to propagate only transition to CLOSE state.
-		 * Orphaned socket will see such state change via
-		 * subflow_sched_work_if_closed() and that path will properly
-		 * destroy the msk as needed.
-		 */
-		ssk_state = inet_sk_state_load(ssk);
-		if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
-			inet_sk_state_store(sk, ssk_state);
-		sk->sk_err = -err;
-
-		/* This barrier is coupled with smp_rmb() in mptcp_poll() */
-		smp_wmb();
-		sk_error_report(sk);
-		break;
-	}
-}
-
 static void subflow_error_report(struct sock *ssk)
 {
 	struct sock *sk = mptcp_subflow_ctx(ssk)->conn;
diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index ffa84cafb746..fe81824799d9 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -632,32 +632,29 @@ EXPORT_SYMBOL(nf_hook_slow_list);
 /* This needs to be compiled in any case to avoid dependencies between the
  * nfnetlink_queue code and nf_conntrack.
  */
-struct nfnl_ct_hook __rcu *nfnl_ct_hook __read_mostly;
+const struct nfnl_ct_hook __rcu *nfnl_ct_hook __read_mostly;
 EXPORT_SYMBOL_GPL(nfnl_ct_hook);
 
-struct nf_ct_hook __rcu *nf_ct_hook __read_mostly;
+const struct nf_ct_hook __rcu *nf_ct_hook __read_mostly;
 EXPORT_SYMBOL_GPL(nf_ct_hook);
 
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
-/* This does not belong here, but locally generated errors need it if connection
-   tracking in use: without this, connection may not be in hash table, and hence
-   manufactured ICMP or RST packets will not be associated with it. */
-void (*ip_ct_attach)(struct sk_buff *, const struct sk_buff *)
-		__rcu __read_mostly;
-EXPORT_SYMBOL(ip_ct_attach);
-
-struct nf_nat_hook __rcu *nf_nat_hook __read_mostly;
+const struct nf_nat_hook __rcu *nf_nat_hook __read_mostly;
 EXPORT_SYMBOL_GPL(nf_nat_hook);
 
+/* This does not belong here, but locally generated errors need it if connection
+ * tracking in use: without this, connection may not be in hash table, and hence
+ * manufactured ICMP or RST packets will not be associated with it.
+ */
 void nf_ct_attach(struct sk_buff *new, const struct sk_buff *skb)
 {
-	void (*attach)(struct sk_buff *, const struct sk_buff *);
+	const struct nf_ct_hook *ct_hook;
 
 	if (skb->_nfct) {
 		rcu_read_lock();
-		attach = rcu_dereference(ip_ct_attach);
-		if (attach)
-			attach(new, skb);
+		ct_hook = rcu_dereference(nf_ct_hook);
+		if (ct_hook)
+			ct_hook->attach(new, skb);
 		rcu_read_unlock();
 	}
 }
@@ -665,7 +662,7 @@ EXPORT_SYMBOL(nf_ct_attach);
 
 void nf_conntrack_destroy(struct nf_conntrack *nfct)
 {
-	struct nf_ct_hook *ct_hook;
+	const struct nf_ct_hook *ct_hook;
 
 	rcu_read_lock();
 	ct_hook = rcu_dereference(nf_ct_hook);
@@ -677,10 +674,26 @@ void nf_conntrack_destroy(struct nf_conntrack *nfct)
 }
 EXPORT_SYMBOL(nf_conntrack_destroy);
 
+void nf_ct_set_closing(struct nf_conntrack *nfct)
+{
+	const struct nf_ct_hook *ct_hook;
+
+	if (!nfct)
+		return;
+
+	rcu_read_lock();
+	ct_hook = rcu_dereference(nf_ct_hook);
+	if (ct_hook)
+		ct_hook->set_closing(nfct);
+
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(nf_ct_set_closing);
+
 bool nf_ct_get_tuple_skb(struct nf_conntrack_tuple *dst_tuple,
 			 const struct sk_buff *skb)
 {
-	struct nf_ct_hook *ct_hook;
+	const struct nf_ct_hook *ct_hook;
 	bool ret = false;
 
 	rcu_read_lock();
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 10622760f894..be6031886f94 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2145,9 +2145,9 @@ static int __nf_conntrack_update(struct net *net, struct sk_buff *skb,
 				 struct nf_conn *ct,
 				 enum ip_conntrack_info ctinfo)
 {
+	const struct nf_nat_hook *nat_hook;
 	struct nf_conntrack_tuple_hash *h;
 	struct nf_conntrack_tuple tuple;
-	struct nf_nat_hook *nat_hook;
 	unsigned int status;
 	int dataoff;
 	u16 l3num;
@@ -2518,7 +2518,6 @@ static int kill_all(struct nf_conn *i, void *data)
 void nf_conntrack_cleanup_start(void)
 {
 	conntrack_gc_work.exiting = true;
-	RCU_INIT_POINTER(ip_ct_attach, NULL);
 }
 
 void nf_conntrack_cleanup_end(void)
@@ -2834,16 +2833,28 @@ int nf_conntrack_init_start(void)
 	return ret;
 }
 
-static struct nf_ct_hook nf_conntrack_hook = {
+static void nf_conntrack_set_closing(struct nf_conntrack *nfct)
+{
+	struct nf_conn *ct = nf_ct_to_nf_conn(nfct);
+
+	switch (nf_ct_protonum(ct)) {
+	case IPPROTO_TCP:
+		nf_conntrack_tcp_set_closing(ct);
+		break;
+	}
+}
+
+static const struct nf_ct_hook nf_conntrack_hook = {
 	.update		= nf_conntrack_update,
 	.destroy	= nf_ct_destroy,
 	.get_tuple_skb  = nf_conntrack_get_tuple_skb,
+	.attach		= nf_conntrack_attach,
+	.set_closing	= nf_conntrack_set_closing,
+	.confirm	= __nf_conntrack_confirm,
 };
 
 void nf_conntrack_init_end(void)
 {
-	/* For use by REJECT target */
-	RCU_INIT_POINTER(ip_ct_attach, nf_conntrack_attach);
 	RCU_INIT_POINTER(nf_ct_hook, &nf_conntrack_hook);
 }
 
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index c427f7625a3b..1466015bc56d 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -1816,7 +1816,7 @@ ctnetlink_parse_nat_setup(struct nf_conn *ct,
 			  const struct nlattr *attr)
 	__must_hold(RCU)
 {
-	struct nf_nat_hook *nat_hook;
+	const struct nf_nat_hook *nat_hook;
 	int err;
 
 	nat_hook = rcu_dereference(nf_nat_hook);
@@ -2922,7 +2922,7 @@ static void ctnetlink_glue_seqadj(struct sk_buff *skb, struct nf_conn *ct,
 	nf_ct_tcp_seqadj_set(skb, ct, ctinfo, diff);
 }
 
-static struct nfnl_ct_hook ctnetlink_glue_hook = {
+static const struct nfnl_ct_hook ctnetlink_glue_hook = {
 	.build_size	= ctnetlink_glue_build_size,
 	.build		= ctnetlink_glue_build,
 	.parse		= ctnetlink_glue_parse,
diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index 1ecfdc4f23be..f33e6aea7f4d 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -870,6 +870,41 @@ static bool tcp_can_early_drop(const struct nf_conn *ct)
 	return false;
 }
 
+void nf_conntrack_tcp_set_closing(struct nf_conn *ct)
+{
+	enum tcp_conntrack old_state;
+	const unsigned int *timeouts;
+	u32 timeout;
+
+	if (!nf_ct_is_confirmed(ct))
+		return;
+
+	spin_lock_bh(&ct->lock);
+	old_state = ct->proto.tcp.state;
+	ct->proto.tcp.state = TCP_CONNTRACK_CLOSE;
+
+	if (old_state == TCP_CONNTRACK_CLOSE ||
+	    test_bit(IPS_FIXED_TIMEOUT_BIT, &ct->status)) {
+		spin_unlock_bh(&ct->lock);
+		return;
+	}
+
+	timeouts = nf_ct_timeout_lookup(ct);
+	if (!timeouts) {
+		const struct nf_tcp_net *tn;
+
+		tn = nf_tcp_pernet(nf_ct_net(ct));
+		timeouts = tn->timeouts;
+	}
+
+	timeout = timeouts[TCP_CONNTRACK_CLOSE];
+	WRITE_ONCE(ct->timeout, timeout + nfct_time_stamp);
+
+	spin_unlock_bh(&ct->lock);
+
+	nf_conntrack_event_cache(IPCT_PROTOINFO, ct);
+}
+
 static void nf_ct_tcp_state_reset(struct ip_ct_tcp_state *state)
 {
 	state->td_end		= 0;
diff --git a/net/netfilter/nf_nat_core.c b/net/netfilter/nf_nat_core.c
index 273117683922..b776b3af78ca 100644
--- a/net/netfilter/nf_nat_core.c
+++ b/net/netfilter/nf_nat_core.c
@@ -1120,7 +1120,7 @@ static struct pernet_operations nat_net_ops = {
 	.size = sizeof(struct nat_net),
 };
 
-static struct nf_nat_hook nat_hook = {
+static const struct nf_nat_hook nat_hook = {
 	.parse_nat_setup	= nfnetlink_parse_nat_setup,
 #ifdef CONFIG_XFRM
 	.decode_session		= __nf_nat_decode_session,
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 40a831150cd8..a5e1468cac5e 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4682,6 +4682,9 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 		if (!(flags & NFT_SET_TIMEOUT))
 			return -EINVAL;
 
+		if (flags & NFT_SET_ANONYMOUS)
+			return -EOPNOTSUPP;
+
 		err = nf_msecs_to_jiffies64(nla[NFTA_SET_TIMEOUT], &desc.timeout);
 		if (err)
 			return err;
@@ -4690,6 +4693,10 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 	if (nla[NFTA_SET_GC_INTERVAL] != NULL) {
 		if (!(flags & NFT_SET_TIMEOUT))
 			return -EINVAL;
+
+		if (flags & NFT_SET_ANONYMOUS)
+			return -EOPNOTSUPP;
+
 		desc.gc_int = ntohl(nla_get_be32(nla[NFTA_SET_GC_INTERVAL]));
 	}
 
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 5329ebf19a18..8c96e01f6a02 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -225,7 +225,7 @@ find_dequeue_entry(struct nfqnl_instance *queue, unsigned int id)
 
 static void nfqnl_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 {
-	struct nf_ct_hook *ct_hook;
+	const struct nf_ct_hook *ct_hook;
 	int err;
 
 	if (verdict == NF_ACCEPT ||
@@ -387,8 +387,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	struct net_device *indev;
 	struct net_device *outdev;
 	struct nf_conn *ct = NULL;
-	enum ip_conntrack_info ctinfo;
-	struct nfnl_ct_hook *nfnl_ct;
+	enum ip_conntrack_info ctinfo = 0;
+	const struct nfnl_ct_hook *nfnl_ct;
 	bool csum_verify;
 	char *secdata = NULL;
 	u32 seclen = 0;
@@ -1115,7 +1115,7 @@ static int nfqnl_recv_verdict_batch(struct sk_buff *skb,
 	return 0;
 }
 
-static struct nf_conn *nfqnl_ct_parse(struct nfnl_ct_hook *nfnl_ct,
+static struct nf_conn *nfqnl_ct_parse(const struct nfnl_ct_hook *nfnl_ct,
 				      const struct nlmsghdr *nlh,
 				      const struct nlattr * const nfqa[],
 				      struct nf_queue_entry *entry,
@@ -1182,11 +1182,11 @@ static int nfqnl_recv_verdict(struct sk_buff *skb, const struct nfnl_info *info,
 {
 	struct nfnl_queue_net *q = nfnl_queue_pernet(info->net);
 	u_int16_t queue_num = ntohs(info->nfmsg->res_id);
+	const struct nfnl_ct_hook *nfnl_ct;
 	struct nfqnl_msg_verdict_hdr *vhdr;
 	enum ip_conntrack_info ctinfo;
 	struct nfqnl_instance *queue;
 	struct nf_queue_entry *entry;
-	struct nfnl_ct_hook *nfnl_ct;
 	struct nf_conn *ct = NULL;
 	unsigned int verdict;
 	int err;
diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index 64a2a5f19589..aee046e00bfa 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -358,10 +358,20 @@ static int nft_target_validate(const struct nft_ctx *ctx,
 
 	if (ctx->family != NFPROTO_IPV4 &&
 	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET &&
 	    ctx->family != NFPROTO_BRIDGE &&
 	    ctx->family != NFPROTO_ARP)
 		return -EOPNOTSUPP;
 
+	ret = nft_chain_validate_hooks(ctx->chain,
+				       (1 << NF_INET_PRE_ROUTING) |
+				       (1 << NF_INET_LOCAL_IN) |
+				       (1 << NF_INET_FORWARD) |
+				       (1 << NF_INET_LOCAL_OUT) |
+				       (1 << NF_INET_POST_ROUTING));
+	if (ret)
+		return ret;
+
 	if (nft_is_base_chain(ctx->chain)) {
 		const struct nft_base_chain *basechain =
 						nft_base_chain(ctx->chain);
@@ -607,10 +617,20 @@ static int nft_match_validate(const struct nft_ctx *ctx,
 
 	if (ctx->family != NFPROTO_IPV4 &&
 	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET &&
 	    ctx->family != NFPROTO_BRIDGE &&
 	    ctx->family != NFPROTO_ARP)
 		return -EOPNOTSUPP;
 
+	ret = nft_chain_validate_hooks(ctx->chain,
+				       (1 << NF_INET_PRE_ROUTING) |
+				       (1 << NF_INET_LOCAL_IN) |
+				       (1 << NF_INET_FORWARD) |
+				       (1 << NF_INET_LOCAL_OUT) |
+				       (1 << NF_INET_POST_ROUTING));
+	if (ret)
+		return ret;
+
 	if (nft_is_base_chain(ctx->chain)) {
 		const struct nft_base_chain *basechain =
 						nft_base_chain(ctx->chain);
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 2169a9c3da1c..82df02695bbd 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -165,7 +165,7 @@ static inline u32 netlink_group_mask(u32 group)
 static struct sk_buff *netlink_to_full_skb(const struct sk_buff *skb,
 					   gfp_t gfp_mask)
 {
-	unsigned int len = skb_end_offset(skb);
+	unsigned int len = skb->len;
 	struct sk_buff *new;
 
 	new = alloc_skb(len, gfp_mask);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 88785196a896..e7c361807590 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -950,11 +950,9 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx,
 				   tls_ctx->rx.rec_seq, rxm->full_len,
 				   is_encrypted, is_decrypted);
 
-	ctx->sw.decrypted |= is_decrypted;
-
 	if (unlikely(test_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags))) {
 		if (likely(is_encrypted || is_decrypted))
-			return 0;
+			return is_decrypted;
 
 		/* After tls_device_down disables the offload, the next SKB will
 		 * likely have initial fragments decrypted, and final ones not
@@ -969,7 +967,7 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx,
 	 */
 	if (is_decrypted) {
 		ctx->resync_nh_reset = 1;
-		return 0;
+		return is_decrypted;
 	}
 	if (is_encrypted) {
 		tls_device_core_ctrl_rx_resync(tls_ctx, ctx, sk, skb);
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index e6f700f67c01..fc55b65695e5 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -44,6 +44,11 @@
 #include <net/strparser.h>
 #include <net/tls.h>
 
+struct tls_decrypt_arg {
+	bool zc;
+	bool async;
+};
+
 noinline void tls_err_abort(struct sock *sk, int err)
 {
 	WARN_ON_ONCE(err >= 0);
@@ -128,10 +133,10 @@ static int skb_nsg(struct sk_buff *skb, int offset, int len)
         return __skb_nsg(skb, offset, len, 0);
 }
 
-static int padding_length(struct tls_sw_context_rx *ctx,
-			  struct tls_prot_info *prot, struct sk_buff *skb)
+static int padding_length(struct tls_prot_info *prot, struct sk_buff *skb)
 {
 	struct strp_msg *rxm = strp_msg(skb);
+	struct tls_msg *tlm = tls_msg(skb);
 	int sub = 0;
 
 	/* Determine zero-padding length */
@@ -153,7 +158,7 @@ static int padding_length(struct tls_sw_context_rx *ctx,
 			sub++;
 			back++;
 		}
-		ctx->control = content_type;
+		tlm->control = content_type;
 	}
 	return sub;
 }
@@ -187,7 +192,7 @@ static void tls_decrypt_done(struct crypto_async_request *req, int err)
 		struct strp_msg *rxm = strp_msg(skb);
 		int pad;
 
-		pad = padding_length(ctx, prot, skb);
+		pad = padding_length(prot, skb);
 		if (pad < 0) {
 			ctx->async_wait.err = pad;
 			tls_err_abort(skb->sk, pad);
@@ -231,7 +236,7 @@ static int tls_do_decryption(struct sock *sk,
 			     char *iv_recv,
 			     size_t data_len,
 			     struct aead_request *aead_req,
-			     bool async)
+			     struct tls_decrypt_arg *darg)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_prot_info *prot = &tls_ctx->prot_info;
@@ -244,7 +249,7 @@ static int tls_do_decryption(struct sock *sk,
 			       data_len + prot->tag_size,
 			       (u8 *)iv_recv);
 
-	if (async) {
+	if (darg->async) {
 		/* Using skb->sk to push sk through to crypto async callback
 		 * handler. This allows propagating errors up to the socket
 		 * if needed. It _must_ be cleared in the async handler
@@ -264,14 +269,14 @@ static int tls_do_decryption(struct sock *sk,
 
 	ret = crypto_aead_decrypt(aead_req);
 	if (ret == -EINPROGRESS) {
-		if (async)
-			return ret;
+		if (darg->async)
+			return 0;
 
 		ret = crypto_wait_req(ret, &ctx->async_wait);
-	}
-
-	if (async)
+	} else if (darg->async) {
 		atomic_dec(&ctx->decrypt_pending);
+	}
+	darg->async = false;
 
 	return ret;
 }
@@ -1348,15 +1353,14 @@ static struct sk_buff *tls_wait_data(struct sock *sk, struct sk_psock *psock,
 	return skb;
 }
 
-static int tls_setup_from_iter(struct sock *sk, struct iov_iter *from,
+static int tls_setup_from_iter(struct iov_iter *from,
 			       int length, int *pages_used,
-			       unsigned int *size_used,
 			       struct scatterlist *to,
 			       int to_max_pages)
 {
 	int rc = 0, i = 0, num_elem = *pages_used, maxpages;
 	struct page *pages[MAX_SKB_FRAGS];
-	unsigned int size = *size_used;
+	unsigned int size = 0;
 	ssize_t copied, use;
 	size_t offset;
 
@@ -1399,8 +1403,7 @@ static int tls_setup_from_iter(struct sock *sk, struct iov_iter *from,
 		sg_mark_end(&to[num_elem - 1]);
 out:
 	if (rc)
-		iov_iter_revert(from, size - *size_used);
-	*size_used = size;
+		iov_iter_revert(from, size);
 	*pages_used = num_elem;
 
 	return rc;
@@ -1417,12 +1420,13 @@ static int tls_setup_from_iter(struct sock *sk, struct iov_iter *from,
 static int decrypt_internal(struct sock *sk, struct sk_buff *skb,
 			    struct iov_iter *out_iov,
 			    struct scatterlist *out_sg,
-			    int *chunk, bool *zc, bool async)
+			    struct tls_decrypt_arg *darg)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
 	struct tls_prot_info *prot = &tls_ctx->prot_info;
 	struct strp_msg *rxm = strp_msg(skb);
+	struct tls_msg *tlm = tls_msg(skb);
 	int n_sgin, n_sgout, nsg, mem_size, aead_size, err, pages = 0;
 	struct aead_request *aead_req;
 	struct sk_buff *unused;
@@ -1433,7 +1437,7 @@ static int decrypt_internal(struct sock *sk, struct sk_buff *skb,
 			     prot->tail_size;
 	int iv_offset = 0;
 
-	if (*zc && (out_iov || out_sg)) {
+	if (darg->zc && (out_iov || out_sg)) {
 		if (out_iov)
 			n_sgout = iov_iter_npages(out_iov, INT_MAX) + 1;
 		else
@@ -1442,7 +1446,7 @@ static int decrypt_internal(struct sock *sk, struct sk_buff *skb,
 				 rxm->full_len - prot->prepend_size);
 	} else {
 		n_sgout = 0;
-		*zc = false;
+		darg->zc = false;
 		n_sgin = skb_cow_data(skb, 0, &unused);
 	}
 
@@ -1500,7 +1504,7 @@ static int decrypt_internal(struct sock *sk, struct sk_buff *skb,
 	/* Prepare AAD */
 	tls_make_aad(aad, rxm->full_len - prot->overhead_size +
 		     prot->tail_size,
-		     tls_ctx->rx.rec_seq, ctx->control, prot);
+		     tls_ctx->rx.rec_seq, tlm->control, prot);
 
 	/* Prepare sgin */
 	sg_init_table(sgin, n_sgin);
@@ -1518,9 +1522,8 @@ static int decrypt_internal(struct sock *sk, struct sk_buff *skb,
 			sg_init_table(sgout, n_sgout);
 			sg_set_buf(&sgout[0], aad, prot->aad_size);
 
-			*chunk = 0;
-			err = tls_setup_from_iter(sk, out_iov, data_len,
-						  &pages, chunk, &sgout[1],
+			err = tls_setup_from_iter(out_iov, data_len,
+						  &pages, &sgout[1],
 						  (n_sgout - 1));
 			if (err < 0)
 				goto fallback_to_reg_recv;
@@ -1533,15 +1536,14 @@ static int decrypt_internal(struct sock *sk, struct sk_buff *skb,
 fallback_to_reg_recv:
 		sgout = sgin;
 		pages = 0;
-		*chunk = data_len;
-		*zc = false;
+		darg->zc = false;
 	}
 
 	/* Prepare and submit AEAD request */
 	err = tls_do_decryption(sk, skb, sgin, sgout, iv,
-				data_len, aead_req, async);
-	if (err == -EINPROGRESS)
-		return err;
+				data_len, aead_req, darg);
+	if (darg->async)
+		return 0;
 
 	/* Release the pages in case iov was mapped to pages */
 	for (; pages > 0; pages--)
@@ -1552,63 +1554,63 @@ static int decrypt_internal(struct sock *sk, struct sk_buff *skb,
 }
 
 static int decrypt_skb_update(struct sock *sk, struct sk_buff *skb,
-			      struct iov_iter *dest, int *chunk, bool *zc,
-			      bool async)
+			      struct iov_iter *dest,
+			      struct tls_decrypt_arg *darg)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
-	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
 	struct tls_prot_info *prot = &tls_ctx->prot_info;
 	struct strp_msg *rxm = strp_msg(skb);
-	int pad, err = 0;
+	struct tls_msg *tlm = tls_msg(skb);
+	int pad, err;
 
-	if (!ctx->decrypted) {
-		if (tls_ctx->rx_conf == TLS_HW) {
-			err = tls_device_decrypted(sk, tls_ctx, skb, rxm);
-			if (err < 0)
-				return err;
-		}
+	if (tlm->decrypted) {
+		darg->zc = false;
+		darg->async = false;
+		return 0;
+	}
 
-		/* Still not decrypted after tls_device */
-		if (!ctx->decrypted) {
-			err = decrypt_internal(sk, skb, dest, NULL, chunk, zc,
-					       async);
-			if (err < 0) {
-				if (err == -EINPROGRESS)
-					tls_advance_record_sn(sk, prot,
-							      &tls_ctx->rx);
-				else if (err == -EBADMSG)
-					TLS_INC_STATS(sock_net(sk),
-						      LINUX_MIB_TLSDECRYPTERROR);
-				return err;
-			}
-		} else {
-			*zc = false;
+	if (tls_ctx->rx_conf == TLS_HW) {
+		err = tls_device_decrypted(sk, tls_ctx, skb, rxm);
+		if (err < 0)
+			return err;
+		if (err > 0) {
+			tlm->decrypted = 1;
+			darg->zc = false;
+			darg->async = false;
+			goto decrypt_done;
 		}
+	}
 
-		pad = padding_length(ctx, prot, skb);
-		if (pad < 0)
-			return pad;
-
-		rxm->full_len -= pad;
-		rxm->offset += prot->prepend_size;
-		rxm->full_len -= prot->overhead_size;
-		tls_advance_record_sn(sk, prot, &tls_ctx->rx);
-		ctx->decrypted = 1;
-		ctx->saved_data_ready(sk);
-	} else {
-		*zc = false;
+	err = decrypt_internal(sk, skb, dest, NULL, darg);
+	if (err < 0) {
+		if (err == -EBADMSG)
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSDECRYPTERROR);
+		return err;
 	}
+	if (darg->async)
+		goto decrypt_next;
 
-	return err;
+decrypt_done:
+	pad = padding_length(prot, skb);
+	if (pad < 0)
+		return pad;
+
+	rxm->full_len -= pad;
+	rxm->offset += prot->prepend_size;
+	rxm->full_len -= prot->overhead_size;
+	tlm->decrypted = 1;
+decrypt_next:
+	tls_advance_record_sn(sk, prot, &tls_ctx->rx);
+
+	return 0;
 }
 
 int decrypt_skb(struct sock *sk, struct sk_buff *skb,
 		struct scatterlist *sgout)
 {
-	bool zc = true;
-	int chunk;
+	struct tls_decrypt_arg darg = { .zc = true, };
 
-	return decrypt_internal(sk, skb, NULL, sgout, &chunk, &zc, false);
+	return decrypt_internal(sk, skb, NULL, sgout, &darg);
 }
 
 static bool tls_sw_advance_skb(struct sock *sk, struct sk_buff *skb,
@@ -1635,6 +1637,29 @@ static bool tls_sw_advance_skb(struct sock *sk, struct sk_buff *skb,
 	return true;
 }
 
+static int tls_record_content_type(struct msghdr *msg, struct tls_msg *tlm,
+				   u8 *control)
+{
+	int err;
+
+	if (!*control) {
+		*control = tlm->control;
+		if (!*control)
+			return -EBADMSG;
+
+		err = put_cmsg(msg, SOL_TLS, TLS_GET_RECORD_TYPE,
+			       sizeof(*control), control);
+		if (*control != TLS_RECORD_TYPE_DATA) {
+			if (err || msg->msg_flags & MSG_CTRUNC)
+				return -EIO;
+		}
+	} else if (*control != tlm->control) {
+		return 0;
+	}
+
+	return 1;
+}
+
 /* This function traverses the rx_list in tls receive context to copies the
  * decrypted records into the buffer provided by caller zero copy is not
  * true. Further, the records are removed from the rx_list if it is not a peek
@@ -1643,31 +1668,23 @@ static bool tls_sw_advance_skb(struct sock *sk, struct sk_buff *skb,
 static int process_rx_list(struct tls_sw_context_rx *ctx,
 			   struct msghdr *msg,
 			   u8 *control,
-			   bool *cmsg,
 			   size_t skip,
 			   size_t len,
 			   bool zc,
 			   bool is_peek)
 {
 	struct sk_buff *skb = skb_peek(&ctx->rx_list);
-	u8 ctrl = *control;
-	u8 msgc = *cmsg;
 	struct tls_msg *tlm;
 	ssize_t copied = 0;
-
-	/* Set the record type in 'control' if caller didn't pass it */
-	if (!ctrl && skb) {
-		tlm = tls_msg(skb);
-		ctrl = tlm->control;
-	}
+	int err;
 
 	while (skip && skb) {
 		struct strp_msg *rxm = strp_msg(skb);
 		tlm = tls_msg(skb);
 
-		/* Cannot process a record of different type */
-		if (ctrl != tlm->control)
-			return 0;
+		err = tls_record_content_type(msg, tlm, control);
+		if (err <= 0)
+			return err;
 
 		if (skip < rxm->full_len)
 			break;
@@ -1683,27 +1700,12 @@ static int process_rx_list(struct tls_sw_context_rx *ctx,
 
 		tlm = tls_msg(skb);
 
-		/* Cannot process a record of different type */
-		if (ctrl != tlm->control)
-			return 0;
-
-		/* Set record type if not already done. For a non-data record,
-		 * do not proceed if record type could not be copied.
-		 */
-		if (!msgc) {
-			int cerr = put_cmsg(msg, SOL_TLS, TLS_GET_RECORD_TYPE,
-					    sizeof(ctrl), &ctrl);
-			msgc = true;
-			if (ctrl != TLS_RECORD_TYPE_DATA) {
-				if (cerr || msg->msg_flags & MSG_CTRUNC)
-					return -EIO;
-
-				*cmsg = msgc;
-			}
-		}
+		err = tls_record_content_type(msg, tlm, control);
+		if (err <= 0)
+			return err;
 
 		if (!zc || (rxm->full_len - skip) > len) {
-			int err = skb_copy_datagram_msg(skb, rxm->offset + skip,
+			err = skb_copy_datagram_msg(skb, rxm->offset + skip,
 						    msg, chunk);
 			if (err < 0)
 				return err;
@@ -1740,7 +1742,6 @@ static int process_rx_list(struct tls_sw_context_rx *ctx,
 		skb = next_skb;
 	}
 
-	*control = ctrl;
 	return copied;
 }
 
@@ -1755,14 +1756,13 @@ int tls_sw_recvmsg(struct sock *sk,
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
 	struct tls_prot_info *prot = &tls_ctx->prot_info;
 	struct sk_psock *psock;
-	int num_async, pending;
 	unsigned char control = 0;
 	ssize_t decrypted = 0;
 	struct strp_msg *rxm;
 	struct tls_msg *tlm;
 	struct sk_buff *skb;
 	ssize_t copied = 0;
-	bool cmsg = false;
+	bool async = false;
 	int target, err = 0;
 	long timeo;
 	bool is_kvec = iov_iter_is_kvec(&msg->msg_iter);
@@ -1779,8 +1779,7 @@ int tls_sw_recvmsg(struct sock *sk,
 	bpf_strp_enabled = sk_psock_strp_enabled(psock);
 
 	/* Process pending decrypted records. It must be non-zero-copy */
-	err = process_rx_list(ctx, msg, &control, &cmsg, 0, len, false,
-			      is_peek);
+	err = process_rx_list(ctx, msg, &control, 0, len, false, is_peek);
 	if (err < 0) {
 		tls_err_abort(sk, err);
 		goto end;
@@ -1795,14 +1794,10 @@ int tls_sw_recvmsg(struct sock *sk,
 	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
 
 	decrypted = 0;
-	num_async = 0;
 	while (len && (decrypted + copied < target || ctx->recv_pkt)) {
+		struct tls_decrypt_arg darg = {};
 		bool retain_skb = false;
-		bool zc = false;
-		int to_decrypt;
-		int chunk = 0;
-		bool async_capable;
-		bool async = false;
+		int to_decrypt, chunk;
 
 		skb = tls_wait_data(sk, psock, flags & MSG_DONTWAIT, timeo, &err);
 		if (!skb) {
@@ -1817,43 +1812,32 @@ int tls_sw_recvmsg(struct sock *sk,
 				}
 			}
 			goto recv_end;
-		} else {
-			tlm = tls_msg(skb);
-			if (prot->version == TLS_1_3_VERSION)
-				tlm->control = 0;
-			else
-				tlm->control = ctx->control;
 		}
 
 		rxm = strp_msg(skb);
+		tlm = tls_msg(skb);
 
 		to_decrypt = rxm->full_len - prot->overhead_size;
 
 		if (to_decrypt <= len && !is_kvec && !is_peek &&
-		    ctx->control == TLS_RECORD_TYPE_DATA &&
+		    tlm->control == TLS_RECORD_TYPE_DATA &&
 		    prot->version != TLS_1_3_VERSION &&
 		    !bpf_strp_enabled)
-			zc = true;
+			darg.zc = true;
 
 		/* Do not use async mode if record is non-data */
-		if (ctx->control == TLS_RECORD_TYPE_DATA && !bpf_strp_enabled)
-			async_capable = ctx->async_capable;
+		if (tlm->control == TLS_RECORD_TYPE_DATA && !bpf_strp_enabled)
+			darg.async = ctx->async_capable;
 		else
-			async_capable = false;
+			darg.async = false;
 
-		err = decrypt_skb_update(sk, skb, &msg->msg_iter,
-					 &chunk, &zc, async_capable);
-		if (err < 0 && err != -EINPROGRESS) {
+		err = decrypt_skb_update(sk, skb, &msg->msg_iter, &darg);
+		if (err < 0) {
 			tls_err_abort(sk, -EBADMSG);
 			goto recv_end;
 		}
 
-		if (err == -EINPROGRESS) {
-			async = true;
-			num_async++;
-		} else if (prot->version == TLS_1_3_VERSION) {
-			tlm->control = ctx->control;
-		}
+		async |= darg.async;
 
 		/* If the type of records being processed is not known yet,
 		 * set it to record type just dequeued. If it is already known,
@@ -1862,30 +1846,19 @@ int tls_sw_recvmsg(struct sock *sk,
 		 * is known just after record is dequeued from stream parser.
 		 * For tls1.3, we disable async.
 		 */
-
-		if (!control)
-			control = tlm->control;
-		else if (control != tlm->control)
+		err = tls_record_content_type(msg, tlm, &control);
+		if (err <= 0)
 			goto recv_end;
 
-		if (!cmsg) {
-			int cerr;
-
-			cerr = put_cmsg(msg, SOL_TLS, TLS_GET_RECORD_TYPE,
-					sizeof(control), &control);
-			cmsg = true;
-			if (control != TLS_RECORD_TYPE_DATA) {
-				if (cerr || msg->msg_flags & MSG_CTRUNC) {
-					err = -EIO;
-					goto recv_end;
-				}
-			}
-		}
-
-		if (async)
+		if (async) {
+			/* TLS 1.2-only, to_decrypt must be text length */
+			chunk = min_t(int, to_decrypt, len);
 			goto pick_next_record;
+		}
+		/* TLS 1.3 may have updated the length by more than overhead */
+		chunk = rxm->full_len;
 
-		if (!zc) {
+		if (!darg.zc) {
 			if (bpf_strp_enabled) {
 				err = sk_psock_tls_strp_read(psock, skb);
 				if (err != __SK_PASS) {
@@ -1899,11 +1872,9 @@ int tls_sw_recvmsg(struct sock *sk,
 				}
 			}
 
-			if (rxm->full_len > len) {
+			if (chunk > len) {
 				retain_skb = true;
 				chunk = len;
-			} else {
-				chunk = rxm->full_len;
 			}
 
 			err = skb_copy_datagram_msg(skb, rxm->offset,
@@ -1918,9 +1889,6 @@ int tls_sw_recvmsg(struct sock *sk,
 		}
 
 pick_next_record:
-		if (chunk > len)
-			chunk = len;
-
 		decrypted += chunk;
 		len -= chunk;
 
@@ -1944,7 +1912,9 @@ int tls_sw_recvmsg(struct sock *sk,
 	}
 
 recv_end:
-	if (num_async) {
+	if (async) {
+		int pending;
+
 		/* Wait for all previously submitted records to be decrypted */
 		spin_lock_bh(&ctx->decrypt_compl_lock);
 		ctx->async_notify = true;
@@ -1970,10 +1940,10 @@ int tls_sw_recvmsg(struct sock *sk,
 
 		/* Drain records from the rx_list & copy if required */
 		if (is_peek || is_kvec)
-			err = process_rx_list(ctx, msg, &control, &cmsg, copied,
+			err = process_rx_list(ctx, msg, &control, copied,
 					      decrypted, false, is_peek);
 		else
-			err = process_rx_list(ctx, msg, &control, &cmsg, 0,
+			err = process_rx_list(ctx, msg, &control, 0,
 					      decrypted, true, is_peek);
 		if (err < 0) {
 			tls_err_abort(sk, err);
@@ -1999,13 +1969,13 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
 	struct strp_msg *rxm = NULL;
 	struct sock *sk = sock->sk;
+	struct tls_msg *tlm;
 	struct sk_buff *skb;
 	ssize_t copied = 0;
 	bool from_queue;
 	int err = 0;
 	long timeo;
 	int chunk;
-	bool zc = false;
 
 	lock_sock(sk);
 
@@ -2015,26 +1985,29 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 	if (from_queue) {
 		skb = __skb_dequeue(&ctx->rx_list);
 	} else {
+		struct tls_decrypt_arg darg = {};
+
 		skb = tls_wait_data(sk, NULL, flags & SPLICE_F_NONBLOCK, timeo,
 				    &err);
 		if (!skb)
 			goto splice_read_end;
 
-		err = decrypt_skb_update(sk, skb, NULL, &chunk, &zc, false);
+		err = decrypt_skb_update(sk, skb, NULL, &darg);
 		if (err < 0) {
 			tls_err_abort(sk, -EBADMSG);
 			goto splice_read_end;
 		}
 	}
 
+	rxm = strp_msg(skb);
+	tlm = tls_msg(skb);
+
 	/* splice does not support reading control messages */
-	if (ctx->control != TLS_RECORD_TYPE_DATA) {
+	if (tlm->control != TLS_RECORD_TYPE_DATA) {
 		err = -EINVAL;
 		goto splice_read_end;
 	}
 
-	rxm = strp_msg(skb);
-
 	chunk = min_t(unsigned int, rxm->full_len, len);
 	copied = skb_splice_bits(skb, sk, rxm->offset, pipe, chunk, flags);
 	if (copied < 0)
@@ -2077,10 +2050,10 @@ bool tls_sw_sock_is_readable(struct sock *sk)
 static int tls_read_size(struct strparser *strp, struct sk_buff *skb)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(strp->sk);
-	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
 	struct tls_prot_info *prot = &tls_ctx->prot_info;
 	char header[TLS_HEADER_SIZE + MAX_IV_SIZE];
 	struct strp_msg *rxm = strp_msg(skb);
+	struct tls_msg *tlm = tls_msg(skb);
 	size_t cipher_overhead;
 	size_t data_len = 0;
 	int ret;
@@ -2101,7 +2074,7 @@ static int tls_read_size(struct strparser *strp, struct sk_buff *skb)
 	if (ret < 0)
 		goto read_failure;
 
-	ctx->control = header[0];
+	tlm->control = header[0];
 
 	data_len = ((header[4] & 0xFF) | (header[3] << 8));
 
@@ -2141,8 +2114,9 @@ static void tls_queue(struct strparser *strp, struct sk_buff *skb)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(strp->sk);
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
+	struct tls_msg *tlm = tls_msg(skb);
 
-	ctx->decrypted = 0;
+	tlm->decrypted = 0;
 
 	ctx->recv_pkt = skb;
 	strp_pause(strp);
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 9e1bab97c05b..ab2c83d58b62 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -284,9 +284,17 @@ void unix_gc(void)
 	 * which are creating the cycle(s).
 	 */
 	skb_queue_head_init(&hitlist);
-	list_for_each_entry(u, &gc_candidates, link)
+	list_for_each_entry(u, &gc_candidates, link) {
 		scan_children(&u->sk, inc_inflight, &hitlist);
 
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+		if (u->oob_skb) {
+			kfree_skb(u->oob_skb);
+			u->oob_skb = NULL;
+		}
+#endif
+	}
+
 	/* not_cycle_list contains those sockets which do not make up a
 	 * cycle.  Restore these to the inflight list.
 	 */
@@ -314,18 +322,6 @@ void unix_gc(void)
 	/* Here we are. Hitlist is filled. Die. */
 	__skb_queue_purge(&hitlist);
 
-#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-	while (!list_empty(&gc_candidates)) {
-		u = list_entry(gc_candidates.next, struct unix_sock, link);
-		if (u->oob_skb) {
-			struct sk_buff *skb = u->oob_skb;
-
-			u->oob_skb = NULL;
-			kfree_skb(skb);
-		}
-	}
-#endif
-
 	spin_lock(&unix_gc_lock);
 
 	/* There could be io_uring registered files, just push them back to
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 4a8b701440eb..99149b10f86f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3914,6 +3914,8 @@ static int nl80211_set_interface(struct sk_buff *skb, struct genl_info *info)
 
 		if (ntype != NL80211_IFTYPE_MESH_POINT)
 			return -EINVAL;
+		if (otype != NL80211_IFTYPE_MESH_POINT)
+			return -EINVAL;
 		if (netif_running(dev))
 			return -EBUSY;
 
diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 5c64927bf2b3..9a66e5826f25 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -2657,13 +2657,14 @@ ssize_t tomoyo_write_control(struct tomoyo_io_buffer *head,
 {
 	int error = buffer_len;
 	size_t avail_len = buffer_len;
-	char *cp0 = head->write_buf;
+	char *cp0;
 	int idx;
 
 	if (!head->write)
 		return -EINVAL;
 	if (mutex_lock_interruptible(&head->io_sem))
 		return -EINTR;
+	cp0 = head->write_buf;
 	head->read_user_buf_avail = 0;
 	idx = tomoyo_read_lock();
 	/* Read a line and dispatch it to the policy handler. */
diff --git a/sound/core/Makefile b/sound/core/Makefile
index 79e1407cd0de..7da92e0383e1 100644
--- a/sound/core/Makefile
+++ b/sound/core/Makefile
@@ -33,7 +33,6 @@ snd-ctl-led-objs  := control_led.o
 snd-rawmidi-objs  := rawmidi.o
 snd-timer-objs    := timer.o
 snd-hrtimer-objs  := hrtimer.o
-snd-rtctimer-objs := rtctimer.o
 snd-hwdep-objs    := hwdep.o
 snd-seq-device-objs := seq_device.o
 
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 9be2260e4ca2..f8b644cb9157 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -934,7 +934,7 @@ static int generate_device_pkt_descs(struct amdtp_stream *s,
 				// to the reason.
 				unsigned int safe_cycle = increment_ohci_cycle_count(next_cycle,
 								IR_JUMBO_PAYLOAD_MAX_SKIP_CYCLES);
-				lost = (compare_ohci_cycle_count(safe_cycle, cycle) > 0);
+				lost = (compare_ohci_cycle_count(safe_cycle, cycle) < 0);
 			}
 			if (lost) {
 				dev_err(&s->unit->device, "Detect discontinuity of cycle: %d %d\n",
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d83eaa35c581..69d7f0d65b38 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3011,9 +3011,23 @@ union bpf_attr {
  *		**BPF_FIB_LOOKUP_DIRECT**
  *			Do a direct table lookup vs full lookup using FIB
  *			rules.
+ *		**BPF_FIB_LOOKUP_TBID**
+ *			Used with BPF_FIB_LOOKUP_DIRECT.
+ *			Use the routing table ID present in *params*->tbid
+ *			for the fib lookup.
  *		**BPF_FIB_LOOKUP_OUTPUT**
  *			Perform lookup from an egress perspective (default is
  *			ingress).
+ *		**BPF_FIB_LOOKUP_SKIP_NEIGH**
+ *			Skip the neighbour table lookup. *params*->dmac
+ *			and *params*->smac will not be set as output. A common
+ *			use case is to call **bpf_redirect_neigh**\ () after
+ *			doing **bpf_fib_lookup**\ ().
+ *		**BPF_FIB_LOOKUP_SRC**
+ *			Derive and set source IP addr in *params*->ipv{4,6}_src
+ *			for the nexthop. If the src addr cannot be derived,
+ *			**BPF_FIB_LKUP_RET_NO_SRC_ADDR** is returned. In this
+ *			case, *params*->dmac and *params*->smac are not set either.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -6040,6 +6054,9 @@ struct bpf_raw_tracepoint_args {
 enum {
 	BPF_FIB_LOOKUP_DIRECT  = (1U << 0),
 	BPF_FIB_LOOKUP_OUTPUT  = (1U << 1),
+	BPF_FIB_LOOKUP_SKIP_NEIGH = (1U << 2),
+	BPF_FIB_LOOKUP_TBID    = (1U << 3),
+	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 };
 
 enum {
@@ -6052,6 +6069,7 @@ enum {
 	BPF_FIB_LKUP_RET_UNSUPP_LWT,   /* fwd requires encapsulation */
 	BPF_FIB_LKUP_RET_NO_NEIGH,     /* no neighbor entry for nh */
 	BPF_FIB_LKUP_RET_FRAG_NEEDED,  /* fragmentation required to fwd */
+	BPF_FIB_LKUP_RET_NO_SRC_ADDR,  /* failed to derive IP src addr */
 };
 
 struct bpf_fib_lookup {
@@ -6086,6 +6104,9 @@ struct bpf_fib_lookup {
 		__u32	rt_metric;
 	};
 
+	/* input: source address to consider for lookup
+	 * output: source address result from lookup
+	 */
 	union {
 		__be32		ipv4_src;
 		__u32		ipv6_src[4];  /* in6_addr; network order */
@@ -6100,9 +6121,19 @@ struct bpf_fib_lookup {
 		__u32		ipv6_dst[4];  /* in6_addr; network order */
 	};
 
-	/* output */
-	__be16	h_vlan_proto;
-	__be16	h_vlan_TCI;
+	union {
+		struct {
+			/* output */
+			__be16	h_vlan_proto;
+			__be16	h_vlan_TCI;
+		};
+		/* input: when accompanied with the
+		 * 'BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_TBID` flags, a
+		 * specific routing table to use for the fib lookup.
+		 */
+		__u32	tbid;
+	};
+
 	__u8	smac[6];     /* ETH_ALEN */
 	__u8	dmac[6];     /* ETH_ALEN */
 };
diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 3f9e540fee57..2f38db59911e 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -17,3 +17,5 @@ CONFIG_NETFILTER_XTABLES=m
 CONFIG_NETFILTER_XT_MATCH_BPF=m
 CONFIG_NF_TABLES_IPV4=y
 CONFIG_NF_TABLES_IPV6=y
+CONFIG_IP_NF_FILTER=m
+CONFIG_IP6_NF_FILTER=m

