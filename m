Return-Path: <linux-kernel+bounces-94114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE474873A2D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2CB1C2284E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DE8134CE3;
	Wed,  6 Mar 2024 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BwUHlyBM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D7F1369BA;
	Wed,  6 Mar 2024 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737538; cv=none; b=L6ZII2kfD58Jif43/e5F7TruvHZ1hFveGgmiZUVEisfDczUKqObZFJxTlvyzfD1M59zscdKdDq4+GVPSURreBLiVBu3qfs7oTXlhdQqgHs34ES5wQhvu7BE9fjwzCOjEIqI88dfI4y7QMsxiAaNf9I3fCUCUP50fZpyurOSB6Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737538; c=relaxed/simple;
	bh=1uS8Rby+otena4nAzgvuAffdJPn/doTo7Im5+z222A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pu8WdLymOgXupZLQRnp2rz6Wje55rDETW2cIp98Yn9ucqGH8tsV8/KxNEoyCwrcUX3KhZzIvQFnBSp3IPgkCGUjK5lrOQumr5jPj1a969zxmDYOOTlRHa5ATjti5gyxnqLuKTF8nBPBuHtf0aSrQDPjBlm/vddaDmGO3gOk0P6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BwUHlyBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C68C43399;
	Wed,  6 Mar 2024 15:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709737538;
	bh=1uS8Rby+otena4nAzgvuAffdJPn/doTo7Im5+z222A8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BwUHlyBMQGGuAl1T9pJLQg/n5Fq20PXpBa2RKfD+8LXQfb28Tbx46J3AOQlx+3VD+
	 rq6iXvyaakRAklQrnqWSKlhi5jNrA6niH5NysScR91++Hgsyi7Uu8mUS4muc+fmKdG
	 /8/toh6GjGbVVlYqnRl19VJlHYAX8rZDv/0RytXU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.4.271
Date: Wed,  6 Mar 2024 15:05:29 +0000
Message-ID: <2024030629-skeletal-washing-dc0c@gregkh>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024030629-bunkbed-stabilize-1cdd@gregkh>
References: <2024030629-bunkbed-stabilize-1cdd@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index dc7f4a6ca4bf..56e53f77c037 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 270
+SUBLEVEL = 271
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 44688917d51f..0418606ec3c0 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -187,6 +187,90 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
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
@@ -339,6 +423,13 @@ static void early_init_intel(struct cpuinfo_x86 *c)
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
 
 #ifdef CONFIG_X86_32
@@ -540,90 +631,6 @@ static void detect_vmx_virtcap(struct cpuinfo_x86 *c)
 	}
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
@@ -758,9 +765,6 @@ static void init_intel(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_VMX))
 		detect_vmx_virtcap(c);
 
-	if (cpu_has(c, X86_FEATURE_TME))
-		detect_tme(c);
-
 	init_intel_misc_features(c);
 
 	if (tsx_ctrl_state == TSX_CTRL_ENABLE)
diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index f2f10aeeea31..bd9b68e21ba7 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -109,6 +109,7 @@
 #define FSL_QDMA_CMD_WTHROTL_OFFSET	20
 #define FSL_QDMA_CMD_DSEN_OFFSET	19
 #define FSL_QDMA_CMD_LWC_OFFSET		16
+#define FSL_QDMA_CMD_PF			BIT(17)
 
 /* Field definition for Descriptor offset */
 #define QDMA_CCDF_STATUS		20
@@ -372,7 +373,8 @@ static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
 	qdma_csgf_set_f(csgf_dest, len);
 	/* Descriptor Buffer */
 	cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
-			  FSL_QDMA_CMD_RWTTYPE_OFFSET);
+			  FSL_QDMA_CMD_RWTTYPE_OFFSET) |
+			  FSL_QDMA_CMD_PF;
 	sdf->data = QDMA_SDDF_CMD(cmd);
 
 	cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
@@ -1150,10 +1152,6 @@ static int fsl_qdma_probe(struct platform_device *pdev)
 	if (!fsl_qdma->queue)
 		return -ENOMEM;
 
-	ret = fsl_qdma_irq_init(pdev, fsl_qdma);
-	if (ret)
-		return ret;
-
 	fsl_qdma->irq_base = platform_get_irq_byname(pdev, "qdma-queue0");
 	if (fsl_qdma->irq_base < 0)
 		return fsl_qdma->irq_base;
@@ -1192,16 +1190,19 @@ static int fsl_qdma_probe(struct platform_device *pdev)
 
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
 
diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
index b82cc8beac67..78c02717c368 100644
--- a/drivers/firmware/efi/capsule-loader.c
+++ b/drivers/firmware/efi/capsule-loader.c
@@ -291,7 +291,7 @@ static int efi_capsule_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 	}
 
-	cap_info->phys = kzalloc(sizeof(void *), GFP_KERNEL);
+	cap_info->phys = kzalloc(sizeof(phys_addr_t), GFP_KERNEL);
 	if (!cap_info->phys) {
 		kfree(cap_info->pages);
 		kfree(cap_info);
diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index e81307f9754e..30aa7f82fc5b 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -128,8 +128,6 @@ static int gen_74x164_probe(struct spi_device *spi)
 	if (IS_ERR(chip->gpiod_oe))
 		return PTR_ERR(chip->gpiod_oe);
 
-	gpiod_set_value_cansleep(chip->gpiod_oe, 1);
-
 	spi_set_drvdata(spi, chip);
 
 	chip->gpio_chip.label = spi->modalias;
@@ -154,6 +152,8 @@ static int gen_74x164_probe(struct spi_device *spi)
 		goto exit_destroy;
 	}
 
+	gpiod_set_value_cansleep(chip->gpiod_oe, 1);
+
 	ret = gpiochip_add_data(&chip->gpio_chip, chip);
 	if (!ret)
 		return 0;
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index ed939bb2f700..8433af39c27e 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -991,10 +991,12 @@ static int mmc_select_bus_width(struct mmc_card *card)
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
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 146053c272c9..e5961082a4af 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1377,26 +1377,26 @@ static int __init gtp_init(void)
 
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
index c595262c109a..47958e6bd77f 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -715,6 +715,7 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
 				   tun->tfiles[tun->numqueues - 1]);
 		ntfile = rtnl_dereference(tun->tfiles[index]);
 		ntfile->queue_index = index;
+		ntfile->xdp_rxq.queue_index = index;
 		rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
 				   NULL);
 
diff --git a/drivers/net/usb/dm9601.c b/drivers/net/usb/dm9601.c
index 5aad26600b03..9b7db5fd9e08 100644
--- a/drivers/net/usb/dm9601.c
+++ b/drivers/net/usb/dm9601.c
@@ -231,7 +231,7 @@ static int dm9601_mdio_read(struct net_device *netdev, int phy_id, int loc)
 	err = dm_read_shared_word(dev, 1, loc, &res);
 	if (err < 0) {
 		netdev_err(dev->net, "MDIO read error: %d\n", err);
-		return err;
+		return 0;
 	}
 
 	netdev_dbg(dev->net,
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index b51017966bb3..454a03f0bc69 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2535,7 +2535,8 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 	if (dev->chipid == ID_REV_CHIP_ID_7801_)
 		buf &= ~MAC_CR_GMII_EN_;
 
-	if (dev->chipid == ID_REV_CHIP_ID_7800_) {
+	if (dev->chipid == ID_REV_CHIP_ID_7800_ ||
+	    dev->chipid == ID_REV_CHIP_ID_7850_) {
 		ret = lan78xx_read_raw_eeprom(dev, 0, 1, &sig);
 		if (!ret && sig != EEPROM_INDICATOR) {
 			/* Implies there is no external eeprom. Set mac speed */
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 01800cd97e3a..08c7e2b4155a 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -217,7 +217,9 @@ static int bq27xxx_battery_i2c_remove(struct i2c_client *client)
 {
 	struct bq27xxx_device_info *di = i2c_get_clientdata(client);
 
-	free_irq(client->irq, di);
+	if (client->irq)
+		free_irq(client->irq, di);
+
 	bq27xxx_battery_teardown(di);
 
 	mutex_lock(&battery_mutex);
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 8bed9df09230..1ada9b9cb21e 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -426,8 +426,10 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
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
index 444e1e5d012e..4abc0db6527e 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -535,6 +535,23 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
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
@@ -547,10 +564,9 @@ int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
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
index dfb14dbddf51..3b39552c2365 100644
--- a/fs/cachefiles/bind.c
+++ b/fs/cachefiles/bind.c
@@ -245,6 +245,8 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 	kmem_cache_free(cachefiles_object_jar, fsdef);
 error_root_object:
 	cachefiles_end_secure(cache, saved_cred);
+	put_cred(cache->cache_cred);
+	cache->cache_cred = NULL;
 	pr_err("Failed to register: %d\n", ret);
 	return ret;
 }
@@ -265,6 +267,7 @@ void cachefiles_daemon_unbind(struct cachefiles_cache *cache)
 
 	dput(cache->graveyard);
 	mntput(cache->mnt);
+	put_cred(cache->cache_cred);
 
 	kfree(cache->rootdirname);
 	kfree(cache->secctx);
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index b1d31c78fc9d..47b292f9b4f8 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1205,6 +1205,7 @@ static int hugetlbfs_parse_param(struct fs_context *fc, struct fs_parameter *par
 {
 	struct hugetlbfs_fs_context *ctx = fc->fs_private;
 	struct fs_parse_result result;
+	struct hstate *h;
 	char *rest;
 	unsigned long ps;
 	int opt;
@@ -1249,11 +1250,12 @@ static int hugetlbfs_parse_param(struct fs_context *fc, struct fs_parameter *par
 
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
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 54c55c30db17..289fb28529f8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2272,6 +2272,7 @@ static void hci_error_reset(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev, error_reset);
 
+	hci_dev_hold(hdev);
 	BT_DBG("%s", hdev->name);
 
 	if (hdev->hw_error)
@@ -2279,10 +2280,10 @@ static void hci_error_reset(struct work_struct *work)
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
index f5b46ea9d4c4..32793d22ba61 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4469,9 +4469,12 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -5766,6 +5769,10 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 		return send_conn_param_neg_reply(hdev, handle,
 						 HCI_ERROR_UNKNOWN_CONN_ID);
 
+	if (max > hcon->le_conn_max_interval)
+		return send_conn_param_neg_reply(hdev, handle,
+						 HCI_ERROR_INVALID_LL_PARAMS);
+
 	if (hci_check_conn_params(min, max, latency, timeout))
 		return send_conn_param_neg_reply(hdev, handle,
 						 HCI_ERROR_INVALID_LL_PARAMS);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 61bf48926550..9c06f5ffd1b5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5331,7 +5331,13 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 
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
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index bb1a27384077..ee599636f817 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4586,10 +4586,9 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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
@@ -4607,11 +4606,11 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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
 
@@ -4655,8 +4654,8 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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
index 4559edad8cec..ba1decf81fe3 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -547,6 +547,20 @@ static int tnl_update_pmtu(struct net_device *dev, struct sk_buff *skb,
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
@@ -620,13 +634,13 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
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
@@ -804,16 +818,16 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
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
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 6fcbe8912b43..974e650e749e 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5380,9 +5380,10 @@ static int inet6_rtm_getaddr(struct sk_buff *in_skb, struct nlmsghdr *nlh,
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
diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index 2372f0bbb133..fdce5012a4f3 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -336,10 +336,20 @@ static int nft_target_validate(const struct nft_ctx *ctx,
 
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
@@ -584,10 +594,20 @@ static int nft_match_validate(const struct nft_ctx *ctx,
 
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
index bd9b3cd25a76..3808b12da7f6 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -156,7 +156,7 @@ static inline u32 netlink_group_mask(u32 group)
 static struct sk_buff *netlink_to_full_skb(const struct sk_buff *skb,
 					   gfp_t gfp_mask)
 {
-	unsigned int len = skb_end_offset(skb);
+	unsigned int len = skb->len;
 	struct sk_buff *new;
 
 	new = alloc_skb(len, gfp_mask);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 494de0161d2f..c698fc458f5f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3527,6 +3527,8 @@ static int nl80211_set_interface(struct sk_buff *skb, struct genl_info *info)
 
 		if (ntype != NL80211_IFTYPE_MESH_POINT)
 			return -EINVAL;
+		if (otype != NL80211_IFTYPE_MESH_POINT)
+			return -EINVAL;
 		if (netif_running(dev))
 			return -EBUSY;
 
diff --git a/sound/core/Makefile b/sound/core/Makefile
index d123587c0fd8..bc04acf4a45c 100644
--- a/sound/core/Makefile
+++ b/sound/core/Makefile
@@ -32,7 +32,6 @@ snd-pcm-dmaengine-objs := pcm_dmaengine.o
 snd-rawmidi-objs  := rawmidi.o
 snd-timer-objs    := timer.o
 snd-hrtimer-objs  := hrtimer.o
-snd-rtctimer-objs := rtctimer.o
 snd-hwdep-objs    := hwdep.o
 snd-seq-device-objs := seq_device.o
 

