Return-Path: <linux-kernel+bounces-88448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F030186E1BF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12968B2387B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3077369DFC;
	Fri,  1 Mar 2024 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TAYKSZ24"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC64C6EB77;
	Fri,  1 Mar 2024 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298947; cv=none; b=N2+3deTjvEb2IBiVxHyAgsQ9EL9IoT0St77STYmgaCGl9/JxVa89dWdl0rrddmzI5rar17mmHzZPGG4MJozu898rTy4NUIRxN7YyKnjbCwYwmpc7mCPtdhBZNejtD8nsrZLUjNSjrnYNREZ7Zha9aUATm9MijmZfIbFUhKaS9s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298947; c=relaxed/simple;
	bh=JK+6BPKaeQodHsdXAYPvDtLshbyEqafsyPc/aivBuw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4i61fW4dZqxpA+eYf1nh1tSEUra/a631pK+DPCBaUbsXm6sjupexHY5YWq0q5ODEwqVb5jxJ8HRBcGpcBCNwx4IwOhn6wPcEPOTWdKOGIhWMgfP4npd5Fl5KpM579SdrOnSrzwsSG0h3z7INbPhQ0Vq0z9R42xG55irFREN4zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TAYKSZ24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C37C43390;
	Fri,  1 Mar 2024 13:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709298947;
	bh=JK+6BPKaeQodHsdXAYPvDtLshbyEqafsyPc/aivBuw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAYKSZ244Mvel8WmoUsIF4N8Ga1wYS4E4w2jntlgkwZ/0dTJve7UGXrQ5QITMMOnC
	 nWVNhMYNzYVbsVntgbBCriOiN76763PvxzED330lS3jFkjLgWbI7V8eQueeuvnC+of
	 pNIDtTDLEbZzUTt9vSzNqOPQRNh12zBwgZ5jy/2U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.4.270
Date: Fri,  1 Mar 2024 14:15:35 +0100
Message-ID: <2024030134-chewy-expedited-a05f@gregkh>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024030134-wool-heave-1282@gregkh>
References: <2024030134-wool-heave-1282@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 03381e2a6da7..dc7f4a6ca4bf 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 269
+SUBLEVEL = 270
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 6fb19a393fd2..c06ae33dc53e 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -337,6 +337,7 @@ static struct gpiod_lookup_table ep93xx_i2c_gpiod_table = {
 				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 		GPIO_LOOKUP_IDX("G", 0, NULL, 1,
 				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
+		{ }
 	},
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index bf40500adef7..e1097ba6c948 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1097,8 +1097,8 @@
 			vddmx-supply = <&pm8916_l3>;
 			vddpx-supply = <&pm8916_l7>;
 
-			qcom,state = <&wcnss_smp2p_out 0>;
-			qcom,state-names = "stop";
+			qcom,smem-states = <&wcnss_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&wcnss_pin_a>;
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index b8ddacf1efe1..8d241f3c3b78 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -223,7 +223,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 /* combine single writes by using store-block insn */
 void __iowrite64_copy(void __iomem *to, const void *from, size_t count)
 {
-       zpci_memcpy_toio(to, from, count);
+	zpci_memcpy_toio(to, from, count * 8);
 }
 
 void __iomem *ioremap(unsigned long ioaddr, unsigned long size)
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 15bad8d59894..faae8a185670 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -374,6 +374,17 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	u8 insn_buff[MAX_PATCH_LEN];
 
 	DPRINTK("alt table %px, -> %px", start, end);
+
+	/*
+	 * In the case CONFIG_X86_5LEVEL=y, KASAN_SHADOW_START is defined using
+	 * cpu_feature_enabled(X86_FEATURE_LA57) and is therefore patched here.
+	 * During the process, KASAN becomes confused seeing partial LA57
+	 * conversion and triggers a false-positive out-of-bound report.
+	 *
+	 * Disable KASAN until the patching is complete.
+	 */
+	kasan_disable_current();
+
 	/*
 	 * The scan order should be from start to end. A later scanned
 	 * alternative code can overwrite previously scanned alternative code.
@@ -434,6 +445,8 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 
 		text_poke_early(instr, insn_buff, insn_buff_sz);
 	}
+
+	kasan_enable_current();
 }
 
 #ifdef CONFIG_SMP
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index aa35d1941d1f..84c7519dddb1 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -48,6 +48,7 @@ enum {
 enum board_ids {
 	/* board IDs by feature in alphabetical order */
 	board_ahci,
+	board_ahci_43bit_dma,
 	board_ahci_ign_iferr,
 	board_ahci_mobile,
 	board_ahci_nomsi,
@@ -126,6 +127,13 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
+	[board_ahci_43bit_dma] = {
+		AHCI_HFLAGS	(AHCI_HFLAG_43BIT_ONLY),
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 	[board_ahci_ign_iferr] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_IGN_IRQ_IF_ERR),
 		.flags		= AHCI_FLAG_COMMON,
@@ -561,11 +569,11 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(PROMISE, 0x3f20), board_ahci },	/* PDC42819 */
 	{ PCI_VDEVICE(PROMISE, 0x3781), board_ahci },   /* FastTrak TX8660 ahci-mode */
 
-	/* Asmedia */
+	/* ASMedia */
 	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci },	/* ASM1060 */
 	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci },	/* ASM1060 */
-	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci },	/* ASM1061 */
-	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci },	/* ASM1062 */
+	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci_43bit_dma },	/* ASM1061 */
+	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci_43bit_dma },	/* ASM1061/1062 */
 	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
 	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
 
@@ -618,6 +626,11 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
 static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 					 struct ahci_host_priv *hpriv)
 {
+	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA && pdev->device == 0x1166) {
+		dev_info(&pdev->dev, "ASM1166 has only six ports\n");
+		hpriv->saved_port_map = 0x3f;
+	}
+
 	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
 		dev_info(&pdev->dev, "JMB361 has only one port\n");
 		hpriv->force_port_map = 1;
@@ -911,11 +924,20 @@ static int ahci_pci_device_resume(struct device *dev)
 
 #endif /* CONFIG_PM */
 
-static int ahci_configure_dma_masks(struct pci_dev *pdev, int using_dac)
+static int ahci_configure_dma_masks(struct pci_dev *pdev,
+				    struct ahci_host_priv *hpriv)
 {
-	const int dma_bits = using_dac ? 64 : 32;
+	int dma_bits;
 	int rc;
 
+	if (hpriv->cap & HOST_CAP_64) {
+		dma_bits = 64;
+		if (hpriv->flags & AHCI_HFLAG_43BIT_ONLY)
+			dma_bits = 43;
+	} else {
+		dma_bits = 32;
+	}
+
 	/*
 	 * If the device fixup already set the dma_mask to some non-standard
 	 * value, don't extend it here. This happens on STA2X11, for example.
@@ -1875,7 +1897,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ahci_gtf_filter_workaround(host);
 
 	/* initialize adapter */
-	rc = ahci_configure_dma_masks(pdev, hpriv->cap & HOST_CAP_64);
+	rc = ahci_configure_dma_masks(pdev, hpriv);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 36dac58b5c41..bb1e52212f64 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -244,6 +244,7 @@ enum {
 	AHCI_HFLAG_IGN_NOTSUPP_POWER_ON	= BIT(27), /* ignore -EOPNOTSUPP
 						      from phy_power_on() */
 	AHCI_HFLAG_NO_SXS		= BIT(28), /* SXS not supported */
+	AHCI_HFLAG_43BIT_ONLY		= BIT(29), /* 43bit DMA addr limit */
 
 	/* ap->flags bits */
 
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 9b3ea86c20e5..3afc07b59477 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1063,14 +1063,15 @@ static int virtblk_freeze(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk = vdev->priv;
 
+	/* Ensure no requests in virtqueues before deleting vqs. */
+	blk_mq_freeze_queue(vblk->disk->queue);
+
 	/* Ensure we don't receive any more interrupts */
 	vdev->config->reset(vdev);
 
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vblk->config_work);
 
-	blk_mq_quiesce_queue(vblk->disk->queue);
-
 	vdev->config->del_vqs(vdev);
 	kfree(vblk->vqs);
 
@@ -1088,7 +1089,7 @@ static int virtblk_restore(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	blk_mq_unquiesce_queue(vblk->disk->queue);
+	blk_mq_unfreeze_queue(vblk->disk->queue);
 	return 0;
 }
 #endif
diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index ad5818c0ce22..f2f10aeeea31 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -754,7 +754,7 @@ fsl_qdma_irq_init(struct platform_device *pdev,
 	int i;
 	int cpu;
 	int ret;
-	char irq_name[20];
+	char irq_name[32];
 
 	fsl_qdma->error_irq =
 		platform_get_irq_byname(pdev, "qdma-error");
diff --git a/drivers/dma/sh/shdma.h b/drivers/dma/sh/shdma.h
index 9c121a4b33ad..f97d80343aea 100644
--- a/drivers/dma/sh/shdma.h
+++ b/drivers/dma/sh/shdma.h
@@ -25,7 +25,7 @@ struct sh_dmae_chan {
 	const struct sh_dmae_slave_config *config; /* Slave DMA configuration */
 	int xmit_shift;			/* log_2(bytes_per_xfer) */
 	void __iomem *base;
-	char dev_id[16];		/* unique name per DMAC of channel */
+	char dev_id[32];		/* unique name per DMAC of channel */
 	int pm_error;
 	dma_addr_t slave_addr;
 };
diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index f3b3953cac83..be195ba83463 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -429,7 +429,23 @@ static void bm_work(struct work_struct *work)
 	 */
 	card->bm_generation = generation;
 
-	if (root_device == NULL) {
+	if (card->gap_count == 0) {
+		/*
+		 * If self IDs have inconsistent gap counts, do a
+		 * bus reset ASAP. The config rom read might never
+		 * complete, so don't wait for it. However, still
+		 * send a PHY configuration packet prior to the
+		 * bus reset. The PHY configuration packet might
+		 * fail, but 1394-2008 8.4.5.2 explicitly permits
+		 * it in this case, so it should be safe to try.
+		 */
+		new_root_id = local_id;
+		/*
+		 * We must always send a bus reset if the gap count
+		 * is inconsistent, so bypass the 5-reset limit.
+		 */
+		card->bm_retries = 0;
+	} else if (root_device == NULL) {
 		/*
 		 * Either link_on is false, or we failed to read the
 		 * config rom.  In either case, pick another root.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 26a1173df958..1f4acb4c3efb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -650,6 +650,9 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
 		if (info->read_mmr_reg.count > 128)
 			return -EINVAL;
 
+		if (info->read_mmr_reg.count > 128)
+			return -EINVAL;
+
 		regs = kmalloc_array(info->read_mmr_reg.count, sizeof(*regs), GFP_KERNEL);
 		if (!regs)
 			return -ENOMEM;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index b0b2bdc750df..3e59b4e15023 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -48,6 +48,8 @@ struct amdgpu_vf_error_buffer {
 	uint64_t data[AMDGPU_VF_ERROR_ENTRY_SIZE];
 };
 
+enum idh_request;
+
 /**
  * struct amdgpu_virt_ops - amdgpu device virt operations
  */
@@ -56,7 +58,8 @@ struct amdgpu_virt_ops {
 	int (*rel_full_gpu)(struct amdgpu_device *adev, bool init);
 	int (*reset_gpu)(struct amdgpu_device *adev);
 	int (*wait_reset)(struct amdgpu_device *adev);
-	void (*trans_msg)(struct amdgpu_device *adev, u32 req, u32 data1, u32 data2, u32 data3);
+	void (*trans_msg)(struct amdgpu_device *adev, enum idh_request req,
+			  u32 data1, u32 data2, u32 data3);
 	int (*get_pp_clk)(struct amdgpu_device *adev, u32 type, char *buf);
 	int (*force_dpm_level)(struct amdgpu_device *adev, u32 level);
 };
diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 8b155e3377cf..9baf95a4fc9f 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -325,6 +325,15 @@ int drm_syncobj_find_fence(struct drm_file *file_private,
 	if (!syncobj)
 		return -ENOENT;
 
+	/* Waiting for userspace with locks help is illegal cause that can
+	 * trivial deadlock with page faults for example. Make lockdep complain
+	 * about it early on.
+	 */
+	if (flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {
+		might_sleep();
+		lockdep_assert_none_held_once();
+	}
+
 	*fence = drm_syncobj_fence_get(syncobj);
 
 	if (*fence) {
@@ -889,6 +898,10 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 	uint64_t *points;
 	uint32_t signaled_count, i;
 
+	if (flags & (DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
+		     DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE))
+		lockdep_assert_none_held_once();
+
 	points = kmalloc_array(count, sizeof(*points), GFP_KERNEL);
 	if (points == NULL)
 		return -ENOMEM;
@@ -955,7 +968,8 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 	 * fallthough and try a 0 timeout wait!
 	 */
 
-	if (flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {
+	if (flags & (DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
+		     DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE)) {
 		for (i = 0; i < count; ++i)
 			drm_syncobj_fence_add_wait(syncobjs[i], &entries[i]);
 	}
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
index 4b571cc6bc70..6597def18627 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
@@ -154,11 +154,17 @@ shadow_fw_init(struct nvkm_bios *bios, const char *name)
 	return (void *)fw;
 }
 
+static void
+shadow_fw_release(void *fw)
+{
+	release_firmware(fw);
+}
+
 static const struct nvbios_source
 shadow_fw = {
 	.name = "firmware",
 	.init = shadow_fw_init,
-	.fini = (void(*)(void *))release_firmware,
+	.fini = shadow_fw_release,
 	.read = shadow_fw_read,
 	.rw = false,
 };
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index f2b288037b90..a18efd305519 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -365,8 +365,7 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
 static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 					   struct drm_display_mode *mode)
 {
-	u16 start = clamp(mode->vtotal - mode->vdisplay - 10, 8, 100);
-	u16 delay = mode->vtotal - (mode->vsync_end - mode->vdisplay) + start;
+	u16 delay = mode->vtotal - (mode->vsync_end - mode->vdisplay) + 1;
 
 	if (delay > mode->vtotal)
 		delay = delay % mode->vtotal;
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index ecee12d0346b..04acb8274fdf 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -40,7 +40,7 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 
 #define PKG_SYSFS_ATTR_NO	1	/* Sysfs attribute for package temp */
 #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
-#define NUM_REAL_CORES		128	/* Number of Real cores per cpu */
+#define NUM_REAL_CORES		512	/* Number of Real cores per cpu */
 #define CORETEMP_NAME_LENGTH	28	/* String Length of attrs */
 #define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
 #define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 183f1c3c1f5e..c9a7c03403ac 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1623,7 +1623,7 @@ int bnxt_re_modify_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_attr,
 	switch (srq_attr_mask) {
 	case IB_SRQ_MAX_WR:
 		/* SRQ resize is not supported */
-		break;
+		return -EINVAL;
 	case IB_SRQ_LIMIT:
 		/* Change the SRQ threshold */
 		if (srq_attr->srq_limit > srq->qplib_srq.max_wqe)
@@ -1638,13 +1638,12 @@ int bnxt_re_modify_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_attr,
 		/* On success, update the shadow */
 		srq->srq_limit = srq_attr->srq_limit;
 		/* No need to Build and send response back to udata */
-		break;
+		return 0;
 	default:
 		dev_err(rdev_to_dev(rdev),
 			"Unsupported srq_attr_mask 0x%x", srq_attr_mask);
 		return -EINVAL;
 	}
-	return 0;
 }
 
 int bnxt_re_query_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_attr)
diff --git a/drivers/infiniband/hw/hfi1/pio.c b/drivers/infiniband/hw/hfi1/pio.c
index fa5de362010f..8303c506733c 100644
--- a/drivers/infiniband/hw/hfi1/pio.c
+++ b/drivers/infiniband/hw/hfi1/pio.c
@@ -2131,7 +2131,7 @@ int init_credit_return(struct hfi1_devdata *dd)
 				   "Unable to allocate credit return DMA range for NUMA %d\n",
 				   i);
 			ret = -ENOMEM;
-			goto done;
+			goto free_cr_base;
 		}
 	}
 	set_dev_node(&dd->pcidev->dev, dd->node);
@@ -2139,6 +2139,10 @@ int init_credit_return(struct hfi1_devdata *dd)
 	ret = 0;
 done:
 	return ret;
+
+free_cr_base:
+	free_credit_return(dd);
+	goto done;
 }
 
 void free_credit_return(struct hfi1_devdata *dd)
diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 057c9ffcd02e..e4d5c33baece 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -3203,7 +3203,7 @@ int _pad_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 {
 	int rval = 0;
 
-	if ((unlikely(tx->num_desc + 1 == tx->desc_limit))) {
+	if ((unlikely(tx->num_desc == tx->desc_limit))) {
 		rval = _extend_sdma_tx_descs(dd, tx);
 		if (rval) {
 			__sdma_txclean(dd, tx);
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 2822ca5e8277..d03a4f2e006f 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -213,12 +213,15 @@ static const char *get_ch_state_name(enum rdma_ch_state s)
 /**
  * srpt_qp_event - QP event callback function
  * @event: Description of the event that occurred.
- * @ch: SRPT RDMA channel.
+ * @ptr: SRPT RDMA channel.
  */
-static void srpt_qp_event(struct ib_event *event, struct srpt_rdma_ch *ch)
+static void srpt_qp_event(struct ib_event *event, void *ptr)
 {
-	pr_debug("QP event %d on ch=%p sess_name=%s state=%d\n",
-		 event->event, ch, ch->sess_name, ch->state);
+	struct srpt_rdma_ch *ch = ptr;
+
+	pr_debug("QP event %d on ch=%p sess_name=%s-%d state=%s\n",
+		 event->event, ch, ch->sess_name, ch->qp->qp_num,
+		 get_ch_state_name(ch->state));
 
 	switch (event->event) {
 	case IB_EVENT_COMM_EST:
@@ -1801,8 +1804,7 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 	}
 
 	qp_init->qp_context = (void *)ch;
-	qp_init->event_handler
-		= (void(*)(struct ib_event *, void*))srpt_qp_event;
+	qp_init->event_handler = srpt_qp_event;
 	qp_init->send_cq = ch->cq;
 	qp_init->recv_cq = ch->cq;
 	qp_init->sq_sig_type = IB_SIGNAL_REQ_WR;
@@ -2005,8 +2007,8 @@ static void __srpt_close_all_ch(struct srpt_port *sport)
 	list_for_each_entry(nexus, &sport->nexus_list, entry) {
 		list_for_each_entry(ch, &nexus->ch_list, list) {
 			if (srpt_disconnect_ch(ch) >= 0)
-				pr_info("Closing channel %s because target %s_%d has been disabled\n",
-					ch->sess_name,
+				pr_info("Closing channel %s-%d because target %s_%d has been disabled\n",
+					ch->sess_name, ch->qp->qp_num,
 					dev_name(&sport->sdev->device->dev),
 					sport->port);
 			srpt_close_ch(ch);
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 4301f22bbfa6..6b4fb4e7506f 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1627,6 +1627,12 @@ static void kcryptd_crypt_write_convert(struct dm_crypt_io *io)
 	io->ctx.bio_out = clone;
 	io->ctx.iter_out = clone->bi_iter;
 
+	if (crypt_integrity_aead(cc)) {
+		bio_copy_data(clone, io->base_bio);
+		io->ctx.bio_in = clone;
+		io->ctx.iter_in = clone->bi_iter;
+	}
+
 	sector += bio_sectors(clone);
 
 	crypt_inc_pending(io);
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 81157801a3dc..f3246f7407d6 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1582,11 +1582,12 @@ static void integrity_metadata(struct work_struct *w)
 		}
 
 		__bio_for_each_segment(bv, bio, iter, dio->bio_details.bi_iter) {
+			struct bio_vec bv_copy = bv;
 			unsigned pos;
 			char *mem, *checksums_ptr;
 
 again:
-			mem = (char *)kmap_atomic(bv.bv_page) + bv.bv_offset;
+			mem = (char *)kmap_atomic(bv_copy.bv_page) + bv_copy.bv_offset;
 			pos = 0;
 			checksums_ptr = checksums;
 			do {
@@ -1595,7 +1596,7 @@ static void integrity_metadata(struct work_struct *w)
 				sectors_to_process -= ic->sectors_per_block;
 				pos += ic->sectors_per_block << SECTOR_SHIFT;
 				sector += ic->sectors_per_block;
-			} while (pos < bv.bv_len && sectors_to_process && checksums != checksums_onstack);
+			} while (pos < bv_copy.bv_len && sectors_to_process && checksums != checksums_onstack);
 			kunmap_atomic(mem);
 
 			r = dm_integrity_rw_tag(ic, checksums, &dio->metadata_block, &dio->metadata_offset,
@@ -1615,9 +1616,9 @@ static void integrity_metadata(struct work_struct *w)
 			if (!sectors_to_process)
 				break;
 
-			if (unlikely(pos < bv.bv_len)) {
-				bv.bv_offset += pos;
-				bv.bv_len -= pos;
+			if (unlikely(pos < bv_copy.bv_len)) {
+				bv_copy.bv_offset += pos;
+				bv_copy.bv_len -= pos;
 				goto again;
 			}
 		}
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index c2e649a4f1bf..146053c272c9 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1381,20 +1381,20 @@ static int __init gtp_init(void)
 	if (err < 0)
 		goto error_out;
 
-	err = genl_register_family(&gtp_genl_family);
+	err = register_pernet_subsys(&gtp_net_ops);
 	if (err < 0)
 		goto unreg_rtnl_link;
 
-	err = register_pernet_subsys(&gtp_net_ops);
+	err = genl_register_family(&gtp_genl_family);
 	if (err < 0)
-		goto unreg_genl_family;
+		goto unreg_pernet_subsys;
 
 	pr_info("GTP module loaded (pdp ctx size %zd bytes)\n",
 		sizeof(struct pdp_ctx));
 	return 0;
 
-unreg_genl_family:
-	genl_unregister_family(&gtp_genl_family);
+unreg_pernet_subsys:
+	unregister_pernet_subsys(&gtp_net_ops);
 unreg_rtnl_link:
 	rtnl_link_unregister(&gtp_link_ops);
 error_out:
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index f74fc6481731..2dd39299fba0 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -796,6 +796,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport)
 	int idx;
 	bool needrandom = true;
 
+	if (!tgtport->pe)
+		return NULL;
+
 	assoc = kzalloc(sizeof(*assoc), GFP_KERNEL);
 	if (!assoc)
 		return NULL;
@@ -2180,8 +2183,9 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 
 	fod->req.cmd = &fod->cmdiubuf.sqe;
 	fod->req.cqe = &fod->rspiubuf.cqe;
-	if (tgtport->pe)
-		fod->req.port = tgtport->pe->port;
+	if (!tgtport->pe)
+		goto transport_error;
+	fod->req.port = tgtport->pe->port;
 
 	/* clear any response payload */
 	memset(&fod->rspiubuf, 0, sizeof(fod->rspiubuf));
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index be9e97657557..d40bd57537ba 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1817,6 +1817,7 @@ static void __exit nvmet_tcp_exit(void)
 	flush_scheduled_work();
 
 	destroy_workqueue(nvmet_tcp_wq);
+	ida_destroy(&nvmet_tcp_queue_ida);
 }
 
 module_init(nvmet_tcp_init);
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 99d505a85067..74c0ddd43381 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2267,13 +2267,15 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		rp->np = port;
 
 		rp->base = devm_pci_remap_cfg_resource(dev, &rp->regs);
-		if (IS_ERR(rp->base))
-			return PTR_ERR(rp->base);
+		if (IS_ERR(rp->base)) {
+			err = PTR_ERR(rp->base);
+			goto err_node_put;
+		}
 
 		label = devm_kasprintf(dev, GFP_KERNEL, "pex-reset-%u", index);
 		if (!label) {
-			dev_err(dev, "failed to create reset GPIO label\n");
-			return -ENOMEM;
+			err = -ENOMEM;
+			goto err_node_put;
 		}
 
 		/*
@@ -2289,9 +2291,10 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 			if (PTR_ERR(rp->reset_gpio) == -ENOENT) {
 				rp->reset_gpio = NULL;
 			} else {
-				dev_err(dev, "failed to get reset GPIO: %d\n",
-					err);
-				return PTR_ERR(rp->reset_gpio);
+				dev_err(dev, "failed to get reset GPIO: %ld\n",
+					PTR_ERR(rp->reset_gpio));
+				err = PTR_ERR(rp->reset_gpio);
+				goto err_node_put;
 			}
 		}
 
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index c4f4a8a3bf8f..1701d3de24da 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1428,7 +1428,7 @@ irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
 {
 	return (irq_hw_number_t)desc->msi_attrib.entry_nr |
 		pci_dev_id(dev) << 11 |
-		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
+		((irq_hw_number_t)(pci_domain_nr(dev->bus) & 0xFFFFFFFF)) << 27;
 }
 
 static inline bool pci_msi_desc_is_multi_msi(struct msi_desc *desc)
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 4b972be3487f..9388d6fac7d4 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -62,7 +62,7 @@ enum rockchip_pinctrl_type {
 	RK3399,
 };
 
-/**
+/*
  * Encode variants of iomux registers into a type variable
  */
 #define IOMUX_GPIO_ONLY		BIT(0)
@@ -72,6 +72,7 @@ enum rockchip_pinctrl_type {
 #define IOMUX_WIDTH_3BIT	BIT(4)
 
 /**
+ * struct rockchip_iomux
  * @type: iomux variant using IOMUX_* constants
  * @offset: if initialized to -1 it will be autocalculated, by specifying
  *	    an initial offset value the relevant source offset can be reset
@@ -82,7 +83,7 @@ struct rockchip_iomux {
 	int				offset;
 };
 
-/**
+/*
  * enum type index corresponding to rockchip_perpin_drv_list arrays index.
  */
 enum rockchip_pin_drv_type {
@@ -94,7 +95,7 @@ enum rockchip_pin_drv_type {
 	DRV_TYPE_MAX
 };
 
-/**
+/*
  * enum type index corresponding to rockchip_pull_list arrays index.
  */
 enum rockchip_pin_pull_type {
@@ -104,6 +105,7 @@ enum rockchip_pin_pull_type {
 };
 
 /**
+ * struct rockchip_drv
  * @drv_type: drive strength variant using rockchip_perpin_drv_type
  * @offset: if initialized to -1 it will be autocalculated, by specifying
  *	    an initial offset value the relevant source offset can be reset
@@ -117,8 +119,9 @@ struct rockchip_drv {
 };
 
 /**
+ * struct rockchip_pin_bank
  * @reg_base: register base of the gpio bank
- * @reg_pull: optional separate register for additional pull settings
+ * @regmap_pull: optional separate register for additional pull settings
  * @clk: clock of the gpio bank
  * @irq: interrupt of the gpio bank
  * @saved_masks: Saved content of GPIO_INTEN at suspend time.
@@ -136,6 +139,8 @@ struct rockchip_drv {
  * @gpio_chip: gpiolib chip
  * @grange: gpio range
  * @slock: spinlock for the gpio bank
+ * @toggle_edge_mode: bit mask to toggle (falling/rising) edge mode
+ * @recalced_mask: bit mask to indicate a need to recalulate the mask
  * @route_mask: bits describing the routing pins of per bank
  */
 struct rockchip_pin_bank {
@@ -310,6 +315,7 @@ enum rockchip_mux_route_location {
  * @bank_num: bank number.
  * @pin: index at register or used to calc index.
  * @func: the min pin.
+ * @route_location: the mux route location (same, pmu, grf).
  * @route_offset: the max pin.
  * @route_val: the register offset.
  */
@@ -322,8 +328,6 @@ struct rockchip_mux_route_data {
 	u32 route_val;
 };
 
-/**
- */
 struct rockchip_pin_ctrl {
 	struct rockchip_pin_bank	*pin_banks;
 	u32				nr_banks;
@@ -361,9 +365,7 @@ struct rockchip_pin_config {
  * @name: name of the pin group, used to lookup the group.
  * @pins: the pins included in this group.
  * @npins: number of pins included in this group.
- * @func: the mux function number to be programmed when selected.
- * @configs: the config values to be set for each pin
- * @nconfigs: number of configs for each pin
+ * @data: local pin configuration
  */
 struct rockchip_pin_group {
 	const char			*name;
@@ -376,7 +378,7 @@ struct rockchip_pin_group {
  * struct rockchip_pmx_func: represent a pin function.
  * @name: name of the pin function, used to lookup the function.
  * @groups: one or more names of pin groups that provide this function.
- * @num_groups: number of groups included in @groups.
+ * @ngroups: number of groups included in @groups.
  */
 struct rockchip_pmx_func {
 	const char		*name;
@@ -2534,6 +2536,7 @@ static int rockchip_pinctrl_parse_groups(struct device_node *np,
 		np_config = of_find_node_by_phandle(be32_to_cpup(phandle));
 		ret = pinconf_generic_parse_dt_config(np_config, NULL,
 				&grp->data[j].configs, &grp->data[j].nconfigs);
+		of_node_put(np_config);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 0a9d61a91f43..1b06aaaaf8b8 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -158,6 +158,9 @@ static int pwm_regulator_get_voltage(struct regulator_dev *rdev)
 	pwm_get_state(drvdata->pwm, &pstate);
 
 	voltage = pwm_get_relative_duty_cycle(&pstate, duty_unit);
+	if (voltage < min(max_uV_duty, min_uV_duty) ||
+	    voltage > max(max_uV_duty, min_uV_duty))
+		return -ENOTRECOVERABLE;
 
 	/*
 	 * The dutycycle for min_uV might be greater than the one for max_uV.
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 8dee16aca421..fe2bea240942 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -305,9 +305,10 @@ static void qeth_l3_clear_ip_htable(struct qeth_card *card, int recover)
 		if (!recover) {
 			hash_del(&addr->hnode);
 			kfree(addr);
-			continue;
+		} else {
+			/* prepare for recovery */
+			addr->disp_flag = QETH_DISP_ADDR_ADD;
 		}
-		addr->disp_flag = QETH_DISP_ADDR_ADD;
 	}
 
 	mutex_unlock(&card->ip_lock);
@@ -335,11 +336,13 @@ static void qeth_l3_recover_ip(struct qeth_card *card)
 			} else
 				rc = qeth_l3_register_addr_entry(card, addr);
 
-			if (!rc) {
+			if (!rc || rc == -EADDRINUSE || rc == -ENETDOWN) {
+				/* keep it in the records */
 				addr->disp_flag = QETH_DISP_ADDR_DO_NOTHING;
 				if (addr->ref_counter < 1)
 					qeth_l3_delete_ip(card, addr);
 			} else {
+				/* bad address */
 				hash_del(&addr->hnode);
 				kfree(addr);
 			}
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 51bbc858a944..cab6e67ea606 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -1286,7 +1286,7 @@ source "drivers/scsi/arm/Kconfig"
 
 config JAZZ_ESP
 	bool "MIPS JAZZ FAS216 SCSI support"
-	depends on MACH_JAZZ && SCSI
+	depends on MACH_JAZZ && SCSI=y
 	select SCSI_SPI_ATTRS
 	help
 	  This is the driver for the onboard SCSI host adapter of MIPS Magnum
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index cbab15d299ca..816235ccd299 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -1942,7 +1942,7 @@ lpfc_bg_setup_bpl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
  *
  * Returns the number of SGEs added to the SGL.
  **/
-static int
+static uint32_t
 lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 		struct sli4_sge *sgl, int datasegcnt,
 		struct lpfc_io_buf *lpfc_cmd)
@@ -1950,8 +1950,8 @@ lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 	struct scatterlist *sgde = NULL; /* s/g data entry */
 	struct sli4_sge_diseed *diseed = NULL;
 	dma_addr_t physaddr;
-	int i = 0, num_sge = 0, status;
-	uint32_t reftag;
+	int i = 0, status;
+	uint32_t reftag, num_sge = 0;
 	uint8_t txop, rxop;
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	uint32_t rc;
@@ -2122,7 +2122,7 @@ lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
  *
  * Returns the number of SGEs added to the SGL.
  **/
-static int
+static uint32_t
 lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 		struct sli4_sge *sgl, int datacnt, int protcnt,
 		struct lpfc_io_buf *lpfc_cmd)
@@ -2146,8 +2146,8 @@ lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 	uint32_t rc;
 #endif
 	uint32_t checking = 1;
-	uint32_t dma_offset = 0;
-	int num_sge = 0, j = 2;
+	uint32_t dma_offset = 0, num_sge = 0;
+	int j = 2;
 	struct sli4_hybrid_sgl *sgl_xtra = NULL;
 
 	sgpe = scsi_prot_sglist(sc);
diff --git a/drivers/soc/renesas/r8a77980-sysc.c b/drivers/soc/renesas/r8a77980-sysc.c
index a8dbe55e8ba8..3d1ea245681b 100644
--- a/drivers/soc/renesas/r8a77980-sysc.c
+++ b/drivers/soc/renesas/r8a77980-sysc.c
@@ -25,7 +25,8 @@ static const struct rcar_sysc_area r8a77980_areas[] __initconst = {
 	  PD_CPU_NOCR },
 	{ "ca53-cpu3",	0x200, 3, R8A77980_PD_CA53_CPU3, R8A77980_PD_CA53_SCU,
 	  PD_CPU_NOCR },
-	{ "cr7",	0x240, 0, R8A77980_PD_CR7,	R8A77980_PD_ALWAYS_ON },
+	{ "cr7",	0x240, 0, R8A77980_PD_CR7,	R8A77980_PD_ALWAYS_ON,
+	  PD_CPU_NOCR },
 	{ "a3ir",	0x180, 0, R8A77980_PD_A3IR,	R8A77980_PD_ALWAYS_ON },
 	{ "a2ir0",	0x400, 0, R8A77980_PD_A2IR0,	R8A77980_PD_A3IR },
 	{ "a2ir1",	0x400, 1, R8A77980_PD_A2IR1,	R8A77980_PD_A3IR },
diff --git a/drivers/spi/spi-mt7621.c b/drivers/spi/spi-mt7621.c
index b4b9b7309b5e..351b0ef52bbc 100644
--- a/drivers/spi/spi-mt7621.c
+++ b/drivers/spi/spi-mt7621.c
@@ -340,11 +340,9 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(clk)) {
-		dev_err(&pdev->dev, "unable to get SYS clock, err=%d\n",
-			status);
-		return PTR_ERR(clk);
-	}
+	if (IS_ERR(clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
+				     "unable to get SYS clock\n");
 
 	status = clk_prepare_enable(clk);
 	if (status)
diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 8ba134ccd3b9..edddc66ad133 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -151,7 +151,6 @@ int transport_lookup_tmr_lun(struct se_cmd *se_cmd, u64 unpacked_lun)
 	struct se_session *se_sess = se_cmd->se_sess;
 	struct se_node_acl *nacl = se_sess->se_node_acl;
 	struct se_tmr_req *se_tmr = se_cmd->se_tmr_req;
-	unsigned long flags;
 
 	rcu_read_lock();
 	deve = target_nacl_find_deve(nacl, unpacked_lun);
@@ -182,10 +181,6 @@ int transport_lookup_tmr_lun(struct se_cmd *se_cmd, u64 unpacked_lun)
 	se_cmd->se_dev = rcu_dereference_raw(se_lun->lun_se_dev);
 	se_tmr->tmr_dev = rcu_dereference_raw(se_lun->lun_se_dev);
 
-	spin_lock_irqsave(&se_tmr->tmr_dev->se_tmr_lock, flags);
-	list_add_tail(&se_tmr->tmr_list, &se_tmr->tmr_dev->dev_tmr_list);
-	spin_unlock_irqrestore(&se_tmr->tmr_dev->se_tmr_lock, flags);
-
 	return 0;
 }
 EXPORT_SYMBOL(transport_lookup_tmr_lun);
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index f52fe4000225..82d9e2659abe 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -3392,6 +3392,10 @@ int transport_generic_handle_tmr(
 	unsigned long flags;
 	bool aborted = false;
 
+	spin_lock_irqsave(&cmd->se_dev->se_tmr_lock, flags);
+	list_add_tail(&cmd->se_tmr_req->tmr_list, &cmd->se_dev->dev_tmr_list);
+	spin_unlock_irqrestore(&cmd->se_dev->se_tmr_lock, flags);
+
 	spin_lock_irqsave(&cmd->t_state_lock, flags);
 	if (cmd->transport_state & CMD_T_ABORTED) {
 		aborted = true;
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index d111cf81cece..61283e7e602a 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -661,7 +661,11 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
 			return;
 	}
 
-	if (request->complete) {
+	/*
+	 * zlp request is appended by driver, needn't call usb_gadget_giveback_request() to notify
+	 * gadget composite driver.
+	 */
+	if (request->complete && request->buf != priv_dev->zlp_buf) {
 		spin_unlock(&priv_dev->lock);
 		usb_gadget_giveback_request(&priv_ep->endpoint,
 					    request);
@@ -1951,11 +1955,11 @@ static int cdns3_gadget_ep_disable(struct usb_ep *ep)
 
 	while (!list_empty(&priv_ep->wa2_descmiss_req_list)) {
 		priv_req = cdns3_next_priv_request(&priv_ep->wa2_descmiss_req_list);
+		list_del_init(&priv_req->list);
 
 		kfree(priv_req->request.buf);
 		cdns3_gadget_ep_free_request(&priv_ep->endpoint,
 					     &priv_req->request);
-		list_del_init(&priv_req->list);
 		--priv_ep->wa2_counter;
 	}
 
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 2ef2464a5043..b8597d4a4864 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1349,7 +1349,15 @@ static int ncm_unwrap_ntb(struct gether *port,
 	     "Parsed NTB with %d frames\n", dgram_counter);
 
 	to_process -= block_len;
-	if (to_process != 0) {
+
+	/*
+	 * Windows NCM driver avoids USB ZLPs by adding a 1-byte
+	 * zero pad as needed.
+	 */
+	if (to_process == 1 &&
+	    (*(unsigned char *)(ntb_ptr + block_len) == 0x00)) {
+		to_process--;
+	} else if (to_process > 0) {
 		ntb_ptr = (unsigned char *)(ntb_ptr + block_len);
 		goto parse_ntb;
 	}
diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index 873d89823f5b..aa4fb7a66dce 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -20,6 +20,7 @@ struct usb_role_switch {
 	struct device dev;
 	struct mutex lock; /* device lock*/
 	enum usb_role role;
+	bool registered;
 
 	/* From descriptor */
 	struct device *usb2_port;
@@ -46,6 +47,9 @@ int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role)
 	if (IS_ERR_OR_NULL(sw))
 		return 0;
 
+	if (!sw->registered)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&sw->lock);
 
 	ret = sw->set(sw->dev.parent, role);
@@ -69,7 +73,7 @@ enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw)
 {
 	enum usb_role role;
 
-	if (IS_ERR_OR_NULL(sw))
+	if (IS_ERR_OR_NULL(sw) || !sw->registered)
 		return USB_ROLE_NONE;
 
 	mutex_lock(&sw->lock);
@@ -319,6 +323,8 @@ usb_role_switch_register(struct device *parent,
 		return ERR_PTR(ret);
 	}
 
+	sw->registered = true;
+
 	/* TODO: Symlinks for the host port and the device controller. */
 
 	return sw;
@@ -333,8 +339,10 @@ EXPORT_SYMBOL_GPL(usb_role_switch_register);
  */
 void usb_role_switch_unregister(struct usb_role_switch *sw)
 {
-	if (!IS_ERR_OR_NULL(sw))
+	if (!IS_ERR_OR_NULL(sw)) {
+		sw->registered = false;
 		device_unregister(&sw->dev);
+	}
 }
 EXPORT_SYMBOL_GPL(usb_role_switch_unregister);
 
diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index d5d22d9c0f56..368500c40140 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -869,6 +869,9 @@ static int savagefb_check_var(struct fb_var_screeninfo   *var,
 
 	DBG("savagefb_check_var");
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	var->transp.offset = 0;
 	var->transp.length = 0;
 	switch (var->bits_per_pixel) {
diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index b443a8ed4600..2fdd02e51f5f 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -1474,6 +1474,8 @@ sisfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 
 	vtotal = var->upper_margin + var->lower_margin + var->vsync_len;
 
+	if (!var->pixclock)
+		return -EINVAL;
 	pixclock = var->pixclock;
 
 	if((var->vmode & FB_VMODE_MASK) == FB_VMODE_NONINTERLACED) {
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 4310336b9bb8..4225bc766d46 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -221,7 +221,7 @@ static int afs_update_volume_status(struct afs_volume *volume, struct key *key)
 {
 	struct afs_server_list *new, *old, *discard;
 	struct afs_vldb_entry *vldb;
-	char idbuf[16];
+	char idbuf[24];
 	int ret, idsz;
 
 	_enter("");
@@ -229,7 +229,7 @@ static int afs_update_volume_status(struct afs_volume *volume, struct key *key)
 	/* We look up an ID by passing it as a decimal string in the
 	 * operation's name parameter.
 	 */
-	idsz = sprintf(idbuf, "%llu", volume->vid);
+	idsz = snprintf(idbuf, sizeof(idbuf), "%llu", volume->vid);
 
 	vldb = afs_vl_lookup_vldb(volume->cell, key, idbuf, idsz);
 	if (IS_ERR(vldb)) {
diff --git a/fs/aio.c b/fs/aio.c
index 1ec5a773d09c..7a50c97cffc0 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -570,6 +570,13 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 	struct kioctx *ctx = req->ki_ctx;
 	unsigned long flags;
 
+	/*
+	 * kiocb didn't come from aio or is neither a read nor a write, hence
+	 * ignore it.
+	 */
+	if (!(iocb->ki_flags & IOCB_AIO_RW))
+		return;
+
 	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
 		return;
 
@@ -1455,7 +1462,7 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 	req->ki_complete = aio_complete_rw;
 	req->private = NULL;
 	req->ki_pos = iocb->aio_offset;
-	req->ki_flags = iocb_flags(req->ki_filp);
+	req->ki_flags = iocb_flags(req->ki_filp) | IOCB_AIO_RW;
 	if (iocb->aio_flags & IOCB_FLAG_RESFD)
 		req->ki_flags |= IOCB_EVENTFD;
 	req->ki_hint = ki_hint_validate(file_write_hint(req->ki_filp));
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 0745330228cf..e823731110e3 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1802,6 +1802,9 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 		return err;
 
 	ext4_lock_group(ac->ac_sb, group);
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
+		goto out;
+
 	max = mb_find_extent(e4b, ex.fe_start, ex.fe_len, &ex);
 
 	if (max > 0) {
@@ -1809,6 +1812,7 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 		ext4_mb_use_best_found(ac, e4b);
 	}
 
+out:
 	ext4_unlock_group(ac->ac_sb, group);
 	ext4_mb_unload_buddy(e4b);
 
@@ -1835,12 +1839,10 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 	if (err)
 		return err;
 
-	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info))) {
-		ext4_mb_unload_buddy(e4b);
-		return 0;
-	}
-
 	ext4_lock_group(ac->ac_sb, group);
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
+		goto out;
+
 	max = mb_find_extent(e4b, ac->ac_g_ex.fe_start,
 			     ac->ac_g_ex.fe_len, &ex);
 	ex.fe_logical = 0xDEADFA11; /* debug value */
@@ -1873,6 +1875,7 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 		ac->ac_b_ex = ex;
 		ext4_mb_use_best_found(ac, e4b);
 	}
+out:
 	ext4_unlock_group(ac->ac_sb, group);
 	ext4_mb_unload_buddy(e4b);
 
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 53cd7b2bb580..c28ba474a25e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -23,6 +23,7 @@ static struct iomap_page *
 iomap_page_create(struct inode *inode, struct page *page)
 {
 	struct iomap_page *iop = to_iomap_page(page);
+	unsigned int nr_blocks = PAGE_SIZE / i_blocksize(inode);
 
 	if (iop || i_blocksize(inode) == PAGE_SIZE)
 		return iop;
@@ -32,6 +33,8 @@ iomap_page_create(struct inode *inode, struct page *page)
 	atomic_set(&iop->write_count, 0);
 	spin_lock_init(&iop->uptodate_lock);
 	bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
+	if (PageUptodate(page))
+		bitmap_fill(iop->uptodate, nr_blocks);
 
 	/*
 	 * migrate_page_move_mapping() assumes that pages with private data have
diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index e2a5320f2718..b9c759addd50 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -40,8 +40,21 @@ static inline struct nilfs_dat_info *NILFS_DAT_I(struct inode *dat)
 static int nilfs_dat_prepare_entry(struct inode *dat,
 				   struct nilfs_palloc_req *req, int create)
 {
-	return nilfs_palloc_get_entry_block(dat, req->pr_entry_nr,
-					    create, &req->pr_entry_bh);
+	int ret;
+
+	ret = nilfs_palloc_get_entry_block(dat, req->pr_entry_nr,
+					   create, &req->pr_entry_bh);
+	if (unlikely(ret == -ENOENT)) {
+		nilfs_msg(dat->i_sb, KERN_ERR,
+			  "DAT doesn't have a block to manage vblocknr = %llu",
+			  (unsigned long long)req->pr_entry_nr);
+		/*
+		 * Return internal code -EINVAL to notify bmap layer of
+		 * metadata corruption.
+		 */
+		ret = -EINVAL;
+	}
+	return ret;
 }
 
 static void nilfs_dat_commit_entry(struct inode *dat,
@@ -123,11 +136,7 @@ static void nilfs_dat_commit_free(struct inode *dat,
 
 int nilfs_dat_prepare_start(struct inode *dat, struct nilfs_palloc_req *req)
 {
-	int ret;
-
-	ret = nilfs_dat_prepare_entry(dat, req, 0);
-	WARN_ON(ret == -ENOENT);
-	return ret;
+	return nilfs_dat_prepare_entry(dat, req, 0);
 }
 
 void nilfs_dat_commit_start(struct inode *dat, struct nilfs_palloc_req *req,
@@ -154,10 +163,8 @@ int nilfs_dat_prepare_end(struct inode *dat, struct nilfs_palloc_req *req)
 	int ret;
 
 	ret = nilfs_dat_prepare_entry(dat, req, 0);
-	if (ret < 0) {
-		WARN_ON(ret == -ENOENT);
+	if (ret < 0)
 		return ret;
-	}
 
 	kaddr = kmap_atomic(req->pr_entry_bh->b_page);
 	entry = nilfs_palloc_block_get_entry(dat, req->pr_entry_nr,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d9b97ccd65e5..e009b52ab6b0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -314,6 +314,8 @@ enum rw_hint {
 #define IOCB_SYNC		(1 << 5)
 #define IOCB_WRITE		(1 << 6)
 #define IOCB_NOWAIT		(1 << 7)
+/* kiocb is a read or write operation submitted by fs/aio.c. */
+#define IOCB_AIO_RW		(1 << 23)
 
 struct kiocb {
 	struct file		*ki_filp;
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index b8a835fd611b..15d92abb3f2d 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -403,6 +403,10 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 		WARN_ON_ONCE(debug_locks && !lockdep_is_held(l));	\
 	} while (0)
 
+#define lockdep_assert_none_held_once()	do {				\
+		WARN_ON_ONCE(debug_locks && current->lockdep_depth);	\
+	} while (0)
+
 #define lockdep_recursing(tsk)	((tsk)->lockdep_recursion)
 
 #define lockdep_pin_lock(l)	lock_pin_lock(&(l)->dep_map)
@@ -479,6 +483,7 @@ struct lockdep_map { };
 #define lockdep_assert_held_write(l)	do { (void)(l); } while (0)
 #define lockdep_assert_held_read(l)		do { (void)(l); } while (0)
 #define lockdep_assert_held_once(l)		do { (void)(l); } while (0)
+#define lockdep_assert_none_held_once()	do { } while (0)
 
 #define lockdep_recursing(tsk)			(0)
 
diff --git a/include/net/tcp.h b/include/net/tcp.h
index af67e19eba39..164ba7b77bd9 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -391,6 +391,7 @@ void tcp_update_metrics(struct sock *sk);
 void tcp_init_metrics(struct sock *sk);
 void tcp_metrics_init(void);
 bool tcp_peer_is_proven(struct request_sock *req, struct dst_entry *dst);
+void __tcp_close(struct sock *sk, long timeout);
 void tcp_close(struct sock *sk, long timeout);
 void tcp_init_sock(struct sock *sk);
 void tcp_init_transfer(struct sock *sk, int bpf_op);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 186e7d78ded5..873f364cb3c6 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -8,7 +8,7 @@
 #include "pelt.h"
 
 int sched_rr_timeslice = RR_TIMESLICE;
-int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
+int sysctl_sched_rr_timeslice = (MSEC_PER_SEC * RR_TIMESLICE) / HZ;
 /* More than 4 hours if BW_SHIFT equals 20. */
 static const u64 max_rt_runtime = MAX_BW;
 
@@ -2659,9 +2659,6 @@ static int sched_rt_global_constraints(void)
 
 static int sched_rt_global_validate(void)
 {
-	if (sysctl_sched_rt_period <= 0)
-		return -EINVAL;
-
 	if ((sysctl_sched_rt_runtime != RUNTIME_INF) &&
 		((sysctl_sched_rt_runtime > sysctl_sched_rt_period) ||
 		 ((u64)sysctl_sched_rt_runtime *
@@ -2693,7 +2690,7 @@ int sched_rt_handler(struct ctl_table *table, int write,
 	old_period = sysctl_sched_rt_period;
 	old_runtime = sysctl_sched_rt_runtime;
 
-	ret = proc_dointvec(table, write, buffer, lenp, ppos);
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
 	if (!ret && write) {
 		ret = sched_rt_global_validate();
@@ -2738,6 +2735,9 @@ int sched_rr_handler(struct ctl_table *table, int write,
 		sched_rr_timeslice =
 			sysctl_sched_rr_timeslice <= 0 ? RR_TIMESLICE :
 			msecs_to_jiffies(sysctl_sched_rr_timeslice);
+
+		if (sysctl_sched_rr_timeslice <= 0)
+			sysctl_sched_rr_timeslice = jiffies_to_msecs(RR_TIMESLICE);
 	}
 	mutex_unlock(&mutex);
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 4f85f7ed42fc..865e539c7354 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -465,6 +465,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= sched_rt_handler,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "sched_rt_runtime_us",
@@ -472,6 +474,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= sched_rt_handler,
+		.extra1		= &neg_one,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "sched_rr_timeslice_ms",
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0140629b7cb2..0cc7ee52d6bd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2214,6 +2214,9 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 {
 	struct mem_cgroup *old = stock->cached;
 
+	if (!old)
+		return;
+
 	if (stock->nr_pages) {
 		page_counter_uncharge(&old->memory, stock->nr_pages);
 		if (do_memsw_account())
@@ -2221,6 +2224,8 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 		css_put_many(&old->css, stock->nr_pages);
 		stock->nr_pages = 0;
 	}
+
+	css_put(&old->css);
 	stock->cached = NULL;
 }
 
@@ -2256,6 +2261,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	stock = this_cpu_ptr(&memcg_stock);
 	if (stock->cached != memcg) { /* reset if necessary */
 		drain_stock(stock);
+		css_get(&memcg->css);
 		stock->cached = memcg;
 	}
 	stock->nr_pages += nr_pages;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 6fa66e2111ea..e8758304a9f3 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -177,6 +177,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
+					      bool *mmap_changing,
 					      bool zeropage)
 {
 	int vm_alloc_shared = dst_vma->vm_flags & VM_SHARED;
@@ -308,6 +309,15 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 				goto out;
 			}
 			down_read(&dst_mm->mmap_sem);
+			/*
+			 * If memory mappings are changing because of non-cooperative
+			 * operation (e.g. mremap) running in parallel, bail out and
+			 * request the user to retry later
+			 */
+			if (mmap_changing && READ_ONCE(*mmap_changing)) {
+				err = -EAGAIN;
+				break;
+			}
 
 			dst_vma = NULL;
 			goto retry;
@@ -389,6 +399,7 @@ extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 				      unsigned long dst_start,
 				      unsigned long src_start,
 				      unsigned long len,
+				      bool *mmap_changing,
 				      bool zeropage);
 #endif /* CONFIG_HUGETLB_PAGE */
 
@@ -506,7 +517,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
 		return  __mcopy_atomic_hugetlb(dst_mm, dst_vma, dst_start,
-						src_start, len, zeropage);
+					       src_start, len, mmap_changing,
+					       zeropage);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index f085b1648e66..501f77f0f480 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -35,6 +35,8 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	const unsigned char *dest;
 	u16 vid = 0;
 
+	memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
+
 	rcu_read_lock();
 	nf_ops = rcu_dereference(nf_br_ops);
 	if (nf_ops && nf_ops->br_dev_xmit_hook(skb)) {
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index e05cdc608850..d7ebee3c048d 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -876,7 +876,7 @@ int inet_shutdown(struct socket *sock, int how)
 		   EPOLLHUP, even on eg. unconnected UDP sockets -- RR */
 		/* fall through */
 	default:
-		sk->sk_shutdown |= how;
+		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | how);
 		if (sk->sk_prot->shutdown)
 			sk->sk_prot->shutdown(sk, how);
 		break;
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 4c013f8800f0..ed00b233cee2 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1798,6 +1798,21 @@ static int in_dev_dump_addr(struct in_device *in_dev, struct sk_buff *skb,
 	return err;
 }
 
+/* Combine dev_addr_genid and dev_base_seq to detect changes.
+ */
+static u32 inet_base_seq(const struct net *net)
+{
+	u32 res = atomic_read(&net->ipv4.dev_addr_genid) +
+		  net->dev_base_seq;
+
+	/* Must not return 0 (see nl_dump_check_consistent()).
+	 * Chose a value far away from 0.
+	 */
+	if (!res)
+		res = 0x80000000;
+	return res;
+}
+
 static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	const struct nlmsghdr *nlh = cb->nlh;
@@ -1849,8 +1864,7 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 		idx = 0;
 		head = &tgt_net->dev_index_head[h];
 		rcu_read_lock();
-		cb->seq = atomic_read(&tgt_net->ipv4.dev_addr_genid) ^
-			  tgt_net->dev_base_seq;
+		cb->seq = inet_base_seq(tgt_net);
 		hlist_for_each_entry_rcu(dev, head, index_hlist) {
 			if (idx < s_idx)
 				goto cont;
@@ -2249,8 +2263,7 @@ static int inet_netconf_dump_devconf(struct sk_buff *skb,
 		idx = 0;
 		head = &net->dev_index_head[h];
 		rcu_read_lock();
-		cb->seq = atomic_read(&net->ipv4.dev_addr_genid) ^
-			  net->dev_base_seq;
+		cb->seq = inet_base_seq(net);
 		hlist_for_each_entry_rcu(dev, head, index_hlist) {
 			if (idx < s_idx)
 				goto cont;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 53a8522adf68..8d7933989de0 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -505,6 +505,7 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 	__poll_t mask;
 	struct sock *sk = sock->sk;
 	const struct tcp_sock *tp = tcp_sk(sk);
+	u8 shutdown;
 	int state;
 
 	sock_poll_wait(file, sock, wait);
@@ -547,9 +548,10 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 	 * NOTE. Check for TCP_CLOSE is added. The goal is to prevent
 	 * blocking on fresh not-connected or disconnected socket. --ANK
 	 */
-	if (sk->sk_shutdown == SHUTDOWN_MASK || state == TCP_CLOSE)
+	shutdown = READ_ONCE(sk->sk_shutdown);
+	if (shutdown == SHUTDOWN_MASK || state == TCP_CLOSE)
 		mask |= EPOLLHUP;
-	if (sk->sk_shutdown & RCV_SHUTDOWN)
+	if (shutdown & RCV_SHUTDOWN)
 		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 
 	/* Connected or passive Fast Open socket? */
@@ -565,8 +567,8 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 		if (tcp_stream_is_readable(tp, target, sk))
 			mask |= EPOLLIN | EPOLLRDNORM;
 
-		if (!(sk->sk_shutdown & SEND_SHUTDOWN)) {
-			if (sk_stream_is_writeable(sk)) {
+		if (!(shutdown & SEND_SHUTDOWN)) {
+			if (__sk_stream_is_writeable(sk, 1)) {
 				mask |= EPOLLOUT | EPOLLWRNORM;
 			} else {  /* send SIGIO later */
 				sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
@@ -578,7 +580,7 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 				 * pairs with the input side.
 				 */
 				smp_mb__after_atomic();
-				if (sk_stream_is_writeable(sk))
+				if (__sk_stream_is_writeable(sk, 1))
 					mask |= EPOLLOUT | EPOLLWRNORM;
 			}
 		} else
@@ -2351,14 +2353,13 @@ bool tcp_check_oom(struct sock *sk, int shift)
 	return too_many_orphans || out_of_socket_memory;
 }
 
-void tcp_close(struct sock *sk, long timeout)
+void __tcp_close(struct sock *sk, long timeout)
 {
 	struct sk_buff *skb;
 	int data_was_unread = 0;
 	int state;
 
-	lock_sock(sk);
-	sk->sk_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 
 	if (sk->sk_state == TCP_LISTEN) {
 		tcp_set_state(sk, TCP_CLOSE);
@@ -2521,6 +2522,12 @@ void tcp_close(struct sock *sk, long timeout)
 out:
 	bh_unlock_sock(sk);
 	local_bh_enable();
+}
+
+void tcp_close(struct sock *sk, long timeout)
+{
+	lock_sock(sk);
+	__tcp_close(sk, timeout);
 	release_sock(sk);
 	sock_put(sk);
 }
@@ -2624,7 +2631,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK))
 		inet_reset_saddr(sk);
 
-	sk->sk_shutdown = 0;
+	WRITE_ONCE(sk->sk_shutdown, 0);
 	sock_reset_flag(sk, SOCK_DONE);
 	tp->srtt_us = 0;
 	tp->mdev_us = jiffies_to_usecs(TCP_TIMEOUT_INIT);
@@ -3900,7 +3907,7 @@ void tcp_done(struct sock *sk)
 	if (req)
 		reqsk_fastopen_remove(sk, req, false);
 
-	sk->sk_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 
 	if (!sock_flag(sk, SOCK_DEAD))
 		sk->sk_state_change(sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 982fe464156a..61243531a7f4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4216,7 +4216,7 @@ void tcp_fin(struct sock *sk)
 
 	inet_csk_schedule_ack(sk);
 
-	sk->sk_shutdown |= RCV_SHUTDOWN;
+	WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
 	sock_set_flag(sk, SOCK_DONE);
 
 	switch (sk->sk_state) {
@@ -6354,7 +6354,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 			break;
 
 		tcp_set_state(sk, TCP_FIN_WAIT2);
-		sk->sk_shutdown |= SEND_SHUTDOWN;
+		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | SEND_SHUTDOWN);
 
 		sk_dst_confirm(sk);
 
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 4bec4c061741..6fcbe8912b43 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -696,6 +696,22 @@ static int inet6_netconf_get_devconf(struct sk_buff *in_skb,
 	return err;
 }
 
+/* Combine dev_addr_genid and dev_base_seq to detect changes.
+ */
+static u32 inet6_base_seq(const struct net *net)
+{
+	u32 res = atomic_read(&net->ipv6.dev_addr_genid) +
+		  net->dev_base_seq;
+
+	/* Must not return 0 (see nl_dump_check_consistent()).
+	 * Chose a value far away from 0.
+	 */
+	if (!res)
+		res = 0x80000000;
+	return res;
+}
+
+
 static int inet6_netconf_dump_devconf(struct sk_buff *skb,
 				      struct netlink_callback *cb)
 {
@@ -729,8 +745,7 @@ static int inet6_netconf_dump_devconf(struct sk_buff *skb,
 		idx = 0;
 		head = &net->dev_index_head[h];
 		rcu_read_lock();
-		cb->seq = atomic_read(&net->ipv6.dev_addr_genid) ^
-			  net->dev_base_seq;
+		cb->seq = inet6_base_seq(net);
 		hlist_for_each_entry_rcu(dev, head, index_hlist) {
 			if (idx < s_idx)
 				goto cont;
@@ -5232,7 +5247,7 @@ static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
 	}
 
 	rcu_read_lock();
-	cb->seq = atomic_read(&tgt_net->ipv6.dev_addr_genid) ^ tgt_net->dev_base_seq;
+	cb->seq = inet6_base_seq(tgt_net);
 	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
 		idx = 0;
 		head = &tgt_net->dev_index_head[h];
diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index f5c448c276fe..7094f8691ac6 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -441,22 +441,24 @@ int __init seg6_init(void)
 {
 	int err = -ENOMEM;
 
-	err = genl_register_family(&seg6_genl_family);
+	err = register_pernet_subsys(&ip6_segments_ops);
 	if (err)
 		goto out;
 
-	err = register_pernet_subsys(&ip6_segments_ops);
+	err = genl_register_family(&seg6_genl_family);
 	if (err)
-		goto out_unregister_genl;
+		goto out_unregister_pernet;
 
 #ifdef CONFIG_IPV6_SEG6_LWTUNNEL
 	err = seg6_iptunnel_init();
 	if (err)
-		goto out_unregister_pernet;
+		goto out_unregister_genl;
 
 	err = seg6_local_init();
-	if (err)
-		goto out_unregister_pernet;
+	if (err) {
+		seg6_iptunnel_exit();
+		goto out_unregister_genl;
+	}
 #endif
 
 #ifdef CONFIG_IPV6_SEG6_HMAC
@@ -477,11 +479,11 @@ int __init seg6_init(void)
 #endif
 #endif
 #ifdef CONFIG_IPV6_SEG6_LWTUNNEL
-out_unregister_pernet:
-	unregister_pernet_subsys(&ip6_segments_ops);
-#endif
 out_unregister_genl:
 	genl_unregister_family(&seg6_genl_family);
+#endif
+out_unregister_pernet:
+	unregister_pernet_subsys(&ip6_segments_ops);
 	goto out;
 }
 
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index f91542e2f679..3a24614f37be 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -644,7 +644,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 back_from_confirm:
 	lock_sock(sk);
-	ulen = len + skb_queue_empty(&sk->sk_write_queue) ? transhdrlen : 0;
+	ulen = len + (skb_queue_empty(&sk->sk_write_queue) ? transhdrlen : 0);
 	err = ip6_append_data(sk, ip_generic_getfrag, msg,
 			      ulen, transhdrlen, &ipc6,
 			      &fl6, (struct rt6_info *)dst,
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 0f97c6fcec17..e330036e02ea 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -683,6 +683,8 @@ static int sta_info_insert_finish(struct sta_info *sta) __acquires(RCU)
 	if (ieee80211_vif_is_mesh(&sdata->vif))
 		mesh_accept_plinks_update(sdata);
 
+	ieee80211_check_fast_xmit(sta);
+
 	return 0;
  out_remove:
 	sta_info_hash_del(local, sta);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 8bd01dfa75cb..5fd9a6f752a1 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2919,7 +2919,7 @@ void ieee80211_check_fast_xmit(struct sta_info *sta)
 	    sdata->vif.type == NL80211_IFTYPE_STATION)
 		goto out;
 
-	if (!test_sta_flag(sta, WLAN_STA_AUTHORIZED))
+	if (!test_sta_flag(sta, WLAN_STA_AUTHORIZED) || !sta->uploaded)
 		goto out;
 
 	if (test_sta_flag(sta, WLAN_STA_PS_STA) ||
diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index e7545bcca805..6b2a215b2786 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -299,7 +299,7 @@ sctp_new(struct nf_conn *ct, const struct sk_buff *skb,
 			pr_debug("Setting vtag %x for secondary conntrack\n",
 				 sh->vtag);
 			ct->proto.sctp.vtag[IP_CT_DIR_ORIGINAL] = sh->vtag;
-		} else {
+		} else if (sch->type == SCTP_CID_SHUTDOWN_ACK) {
 		/* If it is a shutdown ack OOTB packet, we expect a return
 		   shutdown complete, otherwise an ABORT Sec 8.4 (5) and (8) */
 			pr_debug("Setting vtag %x for new conn OOTB\n",
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 6c83d3e169c9..c5dbb950822f 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -951,6 +951,7 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
 	return 0;
 
 err_register_hooks:
+	ctx->table->flags |= NFT_TABLE_F_DORMANT;
 	nft_trans_destroy(trans);
 	return ret;
 }
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 600a84a5c582..451f9c43b34b 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1850,7 +1850,7 @@ static int packet_rcv_spkt(struct sk_buff *skb, struct net_device *dev,
 	 */
 
 	spkt->spkt_family = dev->type;
-	strlcpy(spkt->spkt_device, dev->name, sizeof(spkt->spkt_device));
+	strscpy(spkt->spkt_device, dev->name, sizeof(spkt->spkt_device));
 	spkt->spkt_protocol = skb->protocol;
 
 	/*
@@ -3511,7 +3511,7 @@ static int packet_getname_spkt(struct socket *sock, struct sockaddr *uaddr,
 	rcu_read_lock();
 	dev = dev_get_by_index_rcu(sock_net(sk), READ_ONCE(pkt_sk(sk)->ifindex));
 	if (dev)
-		strlcpy(uaddr->sa_data, dev->name, sizeof(uaddr->sa_data));
+		strscpy(uaddr->sa_data, dev->name, sizeof(uaddr->sa_data));
 	rcu_read_unlock();
 
 	return sizeof(*uaddr);
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 46f2847a071e..49521aa33ab9 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -45,23 +45,6 @@ if NET_SCHED
 
 comment "Queueing/Scheduling"
 
-config NET_SCH_CBQ
-	tristate "Class Based Queueing (CBQ)"
-	---help---
-	  Say Y here if you want to use the Class-Based Queueing (CBQ) packet
-	  scheduling algorithm. This algorithm classifies the waiting packets
-	  into a tree-like hierarchy of classes; the leaves of this tree are
-	  in turn scheduled by separate algorithms.
-
-	  See the top of <file:net/sched/sch_cbq.c> for more details.
-
-	  CBQ is a commonly used scheduler, so if you're unsure, you should
-	  say Y here. Then say Y to all the queueing algorithms below that you
-	  want to use as leaf disciplines.
-
-	  To compile this code as a module, choose M here: the
-	  module will be called sch_cbq.
-
 config NET_SCH_HTB
 	tristate "Hierarchical Token Bucket (HTB)"
 	---help---
@@ -85,20 +68,6 @@ config NET_SCH_HFSC
 	  To compile this code as a module, choose M here: the
 	  module will be called sch_hfsc.
 
-config NET_SCH_ATM
-	tristate "ATM Virtual Circuits (ATM)"
-	depends on ATM
-	---help---
-	  Say Y here if you want to use the ATM pseudo-scheduler.  This
-	  provides a framework for invoking classifiers, which in turn
-	  select classes of this queuing discipline.  Each class maps
-	  the flow(s) it is handling to a given virtual circuit.
-
-	  See the top of <file:net/sched/sch_atm.c> for more details.
-
-	  To compile this code as a module, choose M here: the
-	  module will be called sch_atm.
-
 config NET_SCH_PRIO
 	tristate "Multi Band Priority Queueing (PRIO)"
 	---help---
@@ -217,17 +186,6 @@ config NET_SCH_GRED
 	  To compile this code as a module, choose M here: the
 	  module will be called sch_gred.
 
-config NET_SCH_DSMARK
-	tristate "Differentiated Services marker (DSMARK)"
-	---help---
-	  Say Y if you want to schedule packets according to the
-	  Differentiated Services architecture proposed in RFC 2475.
-	  Technical information on this method, with pointers to associated
-	  RFCs, is available at <http://www.gta.ufrj.br/diffserv/>.
-
-	  To compile this code as a module, choose M here: the
-	  module will be called sch_dsmark.
-
 config NET_SCH_NETEM
 	tristate "Network emulator (NETEM)"
 	---help---
diff --git a/net/sched/Makefile b/net/sched/Makefile
index fb2b90648a20..e5ea44ec13c5 100644
--- a/net/sched/Makefile
+++ b/net/sched/Makefile
@@ -31,20 +31,17 @@ obj-$(CONFIG_NET_IFE_SKBTCINDEX)	+= act_meta_skbtcindex.o
 obj-$(CONFIG_NET_ACT_TUNNEL_KEY)+= act_tunnel_key.o
 obj-$(CONFIG_NET_ACT_CT)	+= act_ct.o
 obj-$(CONFIG_NET_SCH_FIFO)	+= sch_fifo.o
-obj-$(CONFIG_NET_SCH_CBQ)	+= sch_cbq.o
 obj-$(CONFIG_NET_SCH_HTB)	+= sch_htb.o
 obj-$(CONFIG_NET_SCH_HFSC)	+= sch_hfsc.o
 obj-$(CONFIG_NET_SCH_RED)	+= sch_red.o
 obj-$(CONFIG_NET_SCH_GRED)	+= sch_gred.o
 obj-$(CONFIG_NET_SCH_INGRESS)	+= sch_ingress.o
-obj-$(CONFIG_NET_SCH_DSMARK)	+= sch_dsmark.o
 obj-$(CONFIG_NET_SCH_SFB)	+= sch_sfb.o
 obj-$(CONFIG_NET_SCH_SFQ)	+= sch_sfq.o
 obj-$(CONFIG_NET_SCH_TBF)	+= sch_tbf.o
 obj-$(CONFIG_NET_SCH_TEQL)	+= sch_teql.o
 obj-$(CONFIG_NET_SCH_PRIO)	+= sch_prio.o
 obj-$(CONFIG_NET_SCH_MULTIQ)	+= sch_multiq.o
-obj-$(CONFIG_NET_SCH_ATM)	+= sch_atm.o
 obj-$(CONFIG_NET_SCH_NETEM)	+= sch_netem.o
 obj-$(CONFIG_NET_SCH_DRR)	+= sch_drr.o
 obj-$(CONFIG_NET_SCH_PLUG)	+= sch_plug.o
diff --git a/net/sched/sch_atm.c b/net/sched/sch_atm.c
deleted file mode 100644
index 34dd0434d99d..000000000000
--- a/net/sched/sch_atm.c
+++ /dev/null
@@ -1,710 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* net/sched/sch_atm.c - ATM VC selection "queueing discipline" */
-
-/* Written 1998-2000 by Werner Almesberger, EPFL ICA */
-
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/skbuff.h>
-#include <linux/atmdev.h>
-#include <linux/atmclip.h>
-#include <linux/rtnetlink.h>
-#include <linux/file.h>		/* for fput */
-#include <net/netlink.h>
-#include <net/pkt_sched.h>
-#include <net/pkt_cls.h>
-
-/*
- * The ATM queuing discipline provides a framework for invoking classifiers
- * (aka "filters"), which in turn select classes of this queuing discipline.
- * Each class maps the flow(s) it is handling to a given VC. Multiple classes
- * may share the same VC.
- *
- * When creating a class, VCs are specified by passing the number of the open
- * socket descriptor by which the calling process references the VC. The kernel
- * keeps the VC open at least until all classes using it are removed.
- *
- * In this file, most functions are named atm_tc_* to avoid confusion with all
- * the atm_* in net/atm. This naming convention differs from what's used in the
- * rest of net/sched.
- *
- * Known bugs:
- *  - sometimes messes up the IP stack
- *  - any manipulations besides the few operations described in the README, are
- *    untested and likely to crash the system
- *  - should lock the flow while there is data in the queue (?)
- */
-
-#define VCC2FLOW(vcc) ((struct atm_flow_data *) ((vcc)->user_back))
-
-struct atm_flow_data {
-	struct Qdisc_class_common common;
-	struct Qdisc		*q;	/* FIFO, TBF, etc. */
-	struct tcf_proto __rcu	*filter_list;
-	struct tcf_block	*block;
-	struct atm_vcc		*vcc;	/* VCC; NULL if VCC is closed */
-	void			(*old_pop)(struct atm_vcc *vcc,
-					   struct sk_buff *skb); /* chaining */
-	struct atm_qdisc_data	*parent;	/* parent qdisc */
-	struct socket		*sock;		/* for closing */
-	int			ref;		/* reference count */
-	struct gnet_stats_basic_packed	bstats;
-	struct gnet_stats_queue	qstats;
-	struct list_head	list;
-	struct atm_flow_data	*excess;	/* flow for excess traffic;
-						   NULL to set CLP instead */
-	int			hdr_len;
-	unsigned char		hdr[0];		/* header data; MUST BE LAST */
-};
-
-struct atm_qdisc_data {
-	struct atm_flow_data	link;		/* unclassified skbs go here */
-	struct list_head	flows;		/* NB: "link" is also on this
-						   list */
-	struct tasklet_struct	task;		/* dequeue tasklet */
-};
-
-/* ------------------------- Class/flow operations ------------------------- */
-
-static inline struct atm_flow_data *lookup_flow(struct Qdisc *sch, u32 classid)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-
-	list_for_each_entry(flow, &p->flows, list) {
-		if (flow->common.classid == classid)
-			return flow;
-	}
-	return NULL;
-}
-
-static int atm_tc_graft(struct Qdisc *sch, unsigned long arg,
-			struct Qdisc *new, struct Qdisc **old,
-			struct netlink_ext_ack *extack)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow = (struct atm_flow_data *)arg;
-
-	pr_debug("atm_tc_graft(sch %p,[qdisc %p],flow %p,new %p,old %p)\n",
-		sch, p, flow, new, old);
-	if (list_empty(&flow->list))
-		return -EINVAL;
-	if (!new)
-		new = &noop_qdisc;
-	*old = flow->q;
-	flow->q = new;
-	if (*old)
-		qdisc_reset(*old);
-	return 0;
-}
-
-static struct Qdisc *atm_tc_leaf(struct Qdisc *sch, unsigned long cl)
-{
-	struct atm_flow_data *flow = (struct atm_flow_data *)cl;
-
-	pr_debug("atm_tc_leaf(sch %p,flow %p)\n", sch, flow);
-	return flow ? flow->q : NULL;
-}
-
-static unsigned long atm_tc_find(struct Qdisc *sch, u32 classid)
-{
-	struct atm_qdisc_data *p __maybe_unused = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-
-	pr_debug("%s(sch %p,[qdisc %p],classid %x)\n", __func__, sch, p, classid);
-	flow = lookup_flow(sch, classid);
-	pr_debug("%s: flow %p\n", __func__, flow);
-	return (unsigned long)flow;
-}
-
-static unsigned long atm_tc_bind_filter(struct Qdisc *sch,
-					unsigned long parent, u32 classid)
-{
-	struct atm_qdisc_data *p __maybe_unused = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-
-	pr_debug("%s(sch %p,[qdisc %p],classid %x)\n", __func__, sch, p, classid);
-	flow = lookup_flow(sch, classid);
-	if (flow)
-		flow->ref++;
-	pr_debug("%s: flow %p\n", __func__, flow);
-	return (unsigned long)flow;
-}
-
-/*
- * atm_tc_put handles all destructions, including the ones that are explicitly
- * requested (atm_tc_destroy, etc.). The assumption here is that we never drop
- * anything that still seems to be in use.
- */
-static void atm_tc_put(struct Qdisc *sch, unsigned long cl)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow = (struct atm_flow_data *)cl;
-
-	pr_debug("atm_tc_put(sch %p,[qdisc %p],flow %p)\n", sch, p, flow);
-	if (--flow->ref)
-		return;
-	pr_debug("atm_tc_put: destroying\n");
-	list_del_init(&flow->list);
-	pr_debug("atm_tc_put: qdisc %p\n", flow->q);
-	qdisc_put(flow->q);
-	tcf_block_put(flow->block);
-	if (flow->sock) {
-		pr_debug("atm_tc_put: f_count %ld\n",
-			file_count(flow->sock->file));
-		flow->vcc->pop = flow->old_pop;
-		sockfd_put(flow->sock);
-	}
-	if (flow->excess)
-		atm_tc_put(sch, (unsigned long)flow->excess);
-	if (flow != &p->link)
-		kfree(flow);
-	/*
-	 * If flow == &p->link, the qdisc no longer works at this point and
-	 * needs to be removed. (By the caller of atm_tc_put.)
-	 */
-}
-
-static void sch_atm_pop(struct atm_vcc *vcc, struct sk_buff *skb)
-{
-	struct atm_qdisc_data *p = VCC2FLOW(vcc)->parent;
-
-	pr_debug("sch_atm_pop(vcc %p,skb %p,[qdisc %p])\n", vcc, skb, p);
-	VCC2FLOW(vcc)->old_pop(vcc, skb);
-	tasklet_schedule(&p->task);
-}
-
-static const u8 llc_oui_ip[] = {
-	0xaa,			/* DSAP: non-ISO */
-	0xaa,			/* SSAP: non-ISO */
-	0x03,			/* Ctrl: Unnumbered Information Command PDU */
-	0x00,			/* OUI: EtherType */
-	0x00, 0x00,
-	0x08, 0x00
-};				/* Ethertype IP (0800) */
-
-static const struct nla_policy atm_policy[TCA_ATM_MAX + 1] = {
-	[TCA_ATM_FD]		= { .type = NLA_U32 },
-	[TCA_ATM_EXCESS]	= { .type = NLA_U32 },
-};
-
-static int atm_tc_change(struct Qdisc *sch, u32 classid, u32 parent,
-			 struct nlattr **tca, unsigned long *arg,
-			 struct netlink_ext_ack *extack)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow = (struct atm_flow_data *)*arg;
-	struct atm_flow_data *excess = NULL;
-	struct nlattr *opt = tca[TCA_OPTIONS];
-	struct nlattr *tb[TCA_ATM_MAX + 1];
-	struct socket *sock;
-	int fd, error, hdr_len;
-	void *hdr;
-
-	pr_debug("atm_tc_change(sch %p,[qdisc %p],classid %x,parent %x,"
-		"flow %p,opt %p)\n", sch, p, classid, parent, flow, opt);
-	/*
-	 * The concept of parents doesn't apply for this qdisc.
-	 */
-	if (parent && parent != TC_H_ROOT && parent != sch->handle)
-		return -EINVAL;
-	/*
-	 * ATM classes cannot be changed. In order to change properties of the
-	 * ATM connection, that socket needs to be modified directly (via the
-	 * native ATM API. In order to send a flow to a different VC, the old
-	 * class needs to be removed and a new one added. (This may be changed
-	 * later.)
-	 */
-	if (flow)
-		return -EBUSY;
-	if (opt == NULL)
-		return -EINVAL;
-
-	error = nla_parse_nested_deprecated(tb, TCA_ATM_MAX, opt, atm_policy,
-					    NULL);
-	if (error < 0)
-		return error;
-
-	if (!tb[TCA_ATM_FD])
-		return -EINVAL;
-	fd = nla_get_u32(tb[TCA_ATM_FD]);
-	pr_debug("atm_tc_change: fd %d\n", fd);
-	if (tb[TCA_ATM_HDR]) {
-		hdr_len = nla_len(tb[TCA_ATM_HDR]);
-		hdr = nla_data(tb[TCA_ATM_HDR]);
-	} else {
-		hdr_len = RFC1483LLC_LEN;
-		hdr = NULL;	/* default LLC/SNAP for IP */
-	}
-	if (!tb[TCA_ATM_EXCESS])
-		excess = NULL;
-	else {
-		excess = (struct atm_flow_data *)
-			atm_tc_find(sch, nla_get_u32(tb[TCA_ATM_EXCESS]));
-		if (!excess)
-			return -ENOENT;
-	}
-	pr_debug("atm_tc_change: type %d, payload %d, hdr_len %d\n",
-		 opt->nla_type, nla_len(opt), hdr_len);
-	sock = sockfd_lookup(fd, &error);
-	if (!sock)
-		return error;	/* f_count++ */
-	pr_debug("atm_tc_change: f_count %ld\n", file_count(sock->file));
-	if (sock->ops->family != PF_ATMSVC && sock->ops->family != PF_ATMPVC) {
-		error = -EPROTOTYPE;
-		goto err_out;
-	}
-	/* @@@ should check if the socket is really operational or we'll crash
-	   on vcc->send */
-	if (classid) {
-		if (TC_H_MAJ(classid ^ sch->handle)) {
-			pr_debug("atm_tc_change: classid mismatch\n");
-			error = -EINVAL;
-			goto err_out;
-		}
-	} else {
-		int i;
-		unsigned long cl;
-
-		for (i = 1; i < 0x8000; i++) {
-			classid = TC_H_MAKE(sch->handle, 0x8000 | i);
-			cl = atm_tc_find(sch, classid);
-			if (!cl)
-				break;
-		}
-	}
-	pr_debug("atm_tc_change: new id %x\n", classid);
-	flow = kzalloc(sizeof(struct atm_flow_data) + hdr_len, GFP_KERNEL);
-	pr_debug("atm_tc_change: flow %p\n", flow);
-	if (!flow) {
-		error = -ENOBUFS;
-		goto err_out;
-	}
-
-	error = tcf_block_get(&flow->block, &flow->filter_list, sch,
-			      extack);
-	if (error) {
-		kfree(flow);
-		goto err_out;
-	}
-
-	flow->q = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops, classid,
-				    extack);
-	if (!flow->q)
-		flow->q = &noop_qdisc;
-	pr_debug("atm_tc_change: qdisc %p\n", flow->q);
-	flow->sock = sock;
-	flow->vcc = ATM_SD(sock);	/* speedup */
-	flow->vcc->user_back = flow;
-	pr_debug("atm_tc_change: vcc %p\n", flow->vcc);
-	flow->old_pop = flow->vcc->pop;
-	flow->parent = p;
-	flow->vcc->pop = sch_atm_pop;
-	flow->common.classid = classid;
-	flow->ref = 1;
-	flow->excess = excess;
-	list_add(&flow->list, &p->link.list);
-	flow->hdr_len = hdr_len;
-	if (hdr)
-		memcpy(flow->hdr, hdr, hdr_len);
-	else
-		memcpy(flow->hdr, llc_oui_ip, sizeof(llc_oui_ip));
-	*arg = (unsigned long)flow;
-	return 0;
-err_out:
-	sockfd_put(sock);
-	return error;
-}
-
-static int atm_tc_delete(struct Qdisc *sch, unsigned long arg)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow = (struct atm_flow_data *)arg;
-
-	pr_debug("atm_tc_delete(sch %p,[qdisc %p],flow %p)\n", sch, p, flow);
-	if (list_empty(&flow->list))
-		return -EINVAL;
-	if (rcu_access_pointer(flow->filter_list) || flow == &p->link)
-		return -EBUSY;
-	/*
-	 * Reference count must be 2: one for "keepalive" (set at class
-	 * creation), and one for the reference held when calling delete.
-	 */
-	if (flow->ref < 2) {
-		pr_err("atm_tc_delete: flow->ref == %d\n", flow->ref);
-		return -EINVAL;
-	}
-	if (flow->ref > 2)
-		return -EBUSY;	/* catch references via excess, etc. */
-	atm_tc_put(sch, arg);
-	return 0;
-}
-
-static void atm_tc_walk(struct Qdisc *sch, struct qdisc_walker *walker)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-
-	pr_debug("atm_tc_walk(sch %p,[qdisc %p],walker %p)\n", sch, p, walker);
-	if (walker->stop)
-		return;
-	list_for_each_entry(flow, &p->flows, list) {
-		if (walker->count >= walker->skip &&
-		    walker->fn(sch, (unsigned long)flow, walker) < 0) {
-			walker->stop = 1;
-			break;
-		}
-		walker->count++;
-	}
-}
-
-static struct tcf_block *atm_tc_tcf_block(struct Qdisc *sch, unsigned long cl,
-					  struct netlink_ext_ack *extack)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow = (struct atm_flow_data *)cl;
-
-	pr_debug("atm_tc_find_tcf(sch %p,[qdisc %p],flow %p)\n", sch, p, flow);
-	return flow ? flow->block : p->link.block;
-}
-
-/* --------------------------- Qdisc operations ---------------------------- */
-
-static int atm_tc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
-			  struct sk_buff **to_free)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-	struct tcf_result res;
-	int result;
-	int ret = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-
-	pr_debug("atm_tc_enqueue(skb %p,sch %p,[qdisc %p])\n", skb, sch, p);
-	result = TC_ACT_OK;	/* be nice to gcc */
-	flow = NULL;
-	if (TC_H_MAJ(skb->priority) != sch->handle ||
-	    !(flow = (struct atm_flow_data *)atm_tc_find(sch, skb->priority))) {
-		struct tcf_proto *fl;
-
-		list_for_each_entry(flow, &p->flows, list) {
-			fl = rcu_dereference_bh(flow->filter_list);
-			if (fl) {
-				result = tcf_classify(skb, fl, &res, true);
-				if (result < 0)
-					continue;
-				if (result == TC_ACT_SHOT)
-					goto done;
-
-				flow = (struct atm_flow_data *)res.class;
-				if (!flow)
-					flow = lookup_flow(sch, res.classid);
-				goto drop;
-			}
-		}
-		flow = NULL;
-done:
-		;
-	}
-	if (!flow) {
-		flow = &p->link;
-	} else {
-		if (flow->vcc)
-			ATM_SKB(skb)->atm_options = flow->vcc->atm_options;
-		/*@@@ looks good ... but it's not supposed to work :-) */
-#ifdef CONFIG_NET_CLS_ACT
-		switch (result) {
-		case TC_ACT_QUEUED:
-		case TC_ACT_STOLEN:
-		case TC_ACT_TRAP:
-			__qdisc_drop(skb, to_free);
-			return NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
-		case TC_ACT_SHOT:
-			__qdisc_drop(skb, to_free);
-			goto drop;
-		case TC_ACT_RECLASSIFY:
-			if (flow->excess)
-				flow = flow->excess;
-			else
-				ATM_SKB(skb)->atm_options |= ATM_ATMOPT_CLP;
-			break;
-		}
-#endif
-	}
-
-	ret = qdisc_enqueue(skb, flow->q, to_free);
-	if (ret != NET_XMIT_SUCCESS) {
-drop: __maybe_unused
-		if (net_xmit_drop_count(ret)) {
-			qdisc_qstats_drop(sch);
-			if (flow)
-				flow->qstats.drops++;
-		}
-		return ret;
-	}
-	/*
-	 * Okay, this may seem weird. We pretend we've dropped the packet if
-	 * it goes via ATM. The reason for this is that the outer qdisc
-	 * expects to be able to q->dequeue the packet later on if we return
-	 * success at this place. Also, sch->q.qdisc needs to reflect whether
-	 * there is a packet egligible for dequeuing or not. Note that the
-	 * statistics of the outer qdisc are necessarily wrong because of all
-	 * this. There's currently no correct solution for this.
-	 */
-	if (flow == &p->link) {
-		sch->q.qlen++;
-		return NET_XMIT_SUCCESS;
-	}
-	tasklet_schedule(&p->task);
-	return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-}
-
-/*
- * Dequeue packets and send them over ATM. Note that we quite deliberately
- * avoid checking net_device's flow control here, simply because sch_atm
- * uses its own channels, which have nothing to do with any CLIP/LANE/or
- * non-ATM interfaces.
- */
-
-static void sch_atm_dequeue(unsigned long data)
-{
-	struct Qdisc *sch = (struct Qdisc *)data;
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-	struct sk_buff *skb;
-
-	pr_debug("sch_atm_dequeue(sch %p,[qdisc %p])\n", sch, p);
-	list_for_each_entry(flow, &p->flows, list) {
-		if (flow == &p->link)
-			continue;
-		/*
-		 * If traffic is properly shaped, this won't generate nasty
-		 * little bursts. Otherwise, it may ... (but that's okay)
-		 */
-		while ((skb = flow->q->ops->peek(flow->q))) {
-			if (!atm_may_send(flow->vcc, skb->truesize))
-				break;
-
-			skb = qdisc_dequeue_peeked(flow->q);
-			if (unlikely(!skb))
-				break;
-
-			qdisc_bstats_update(sch, skb);
-			bstats_update(&flow->bstats, skb);
-			pr_debug("atm_tc_dequeue: sending on class %p\n", flow);
-			/* remove any LL header somebody else has attached */
-			skb_pull(skb, skb_network_offset(skb));
-			if (skb_headroom(skb) < flow->hdr_len) {
-				struct sk_buff *new;
-
-				new = skb_realloc_headroom(skb, flow->hdr_len);
-				dev_kfree_skb(skb);
-				if (!new)
-					continue;
-				skb = new;
-			}
-			pr_debug("sch_atm_dequeue: ip %p, data %p\n",
-				 skb_network_header(skb), skb->data);
-			ATM_SKB(skb)->vcc = flow->vcc;
-			memcpy(skb_push(skb, flow->hdr_len), flow->hdr,
-			       flow->hdr_len);
-			refcount_add(skb->truesize,
-				   &sk_atm(flow->vcc)->sk_wmem_alloc);
-			/* atm.atm_options are already set by atm_tc_enqueue */
-			flow->vcc->send(flow->vcc, skb);
-		}
-	}
-}
-
-static struct sk_buff *atm_tc_dequeue(struct Qdisc *sch)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct sk_buff *skb;
-
-	pr_debug("atm_tc_dequeue(sch %p,[qdisc %p])\n", sch, p);
-	tasklet_schedule(&p->task);
-	skb = qdisc_dequeue_peeked(p->link.q);
-	if (skb)
-		sch->q.qlen--;
-	return skb;
-}
-
-static struct sk_buff *atm_tc_peek(struct Qdisc *sch)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-
-	pr_debug("atm_tc_peek(sch %p,[qdisc %p])\n", sch, p);
-
-	return p->link.q->ops->peek(p->link.q);
-}
-
-static int atm_tc_init(struct Qdisc *sch, struct nlattr *opt,
-		       struct netlink_ext_ack *extack)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	int err;
-
-	pr_debug("atm_tc_init(sch %p,[qdisc %p],opt %p)\n", sch, p, opt);
-	INIT_LIST_HEAD(&p->flows);
-	INIT_LIST_HEAD(&p->link.list);
-	list_add(&p->link.list, &p->flows);
-	p->link.q = qdisc_create_dflt(sch->dev_queue,
-				      &pfifo_qdisc_ops, sch->handle, extack);
-	if (!p->link.q)
-		p->link.q = &noop_qdisc;
-	pr_debug("atm_tc_init: link (%p) qdisc %p\n", &p->link, p->link.q);
-	p->link.vcc = NULL;
-	p->link.sock = NULL;
-	p->link.common.classid = sch->handle;
-	p->link.ref = 1;
-
-	err = tcf_block_get(&p->link.block, &p->link.filter_list, sch,
-			    extack);
-	if (err)
-		return err;
-
-	tasklet_init(&p->task, sch_atm_dequeue, (unsigned long)sch);
-	return 0;
-}
-
-static void atm_tc_reset(struct Qdisc *sch)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-
-	pr_debug("atm_tc_reset(sch %p,[qdisc %p])\n", sch, p);
-	list_for_each_entry(flow, &p->flows, list)
-		qdisc_reset(flow->q);
-	sch->q.qlen = 0;
-}
-
-static void atm_tc_destroy(struct Qdisc *sch)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow, *tmp;
-
-	pr_debug("atm_tc_destroy(sch %p,[qdisc %p])\n", sch, p);
-	list_for_each_entry(flow, &p->flows, list) {
-		tcf_block_put(flow->block);
-		flow->block = NULL;
-	}
-
-	list_for_each_entry_safe(flow, tmp, &p->flows, list) {
-		if (flow->ref > 1)
-			pr_err("atm_destroy: %p->ref = %d\n", flow, flow->ref);
-		atm_tc_put(sch, (unsigned long)flow);
-	}
-	tasklet_kill(&p->task);
-}
-
-static int atm_tc_dump_class(struct Qdisc *sch, unsigned long cl,
-			     struct sk_buff *skb, struct tcmsg *tcm)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow = (struct atm_flow_data *)cl;
-	struct nlattr *nest;
-
-	pr_debug("atm_tc_dump_class(sch %p,[qdisc %p],flow %p,skb %p,tcm %p)\n",
-		sch, p, flow, skb, tcm);
-	if (list_empty(&flow->list))
-		return -EINVAL;
-	tcm->tcm_handle = flow->common.classid;
-	tcm->tcm_info = flow->q->handle;
-
-	nest = nla_nest_start_noflag(skb, TCA_OPTIONS);
-	if (nest == NULL)
-		goto nla_put_failure;
-
-	if (nla_put(skb, TCA_ATM_HDR, flow->hdr_len, flow->hdr))
-		goto nla_put_failure;
-	if (flow->vcc) {
-		struct sockaddr_atmpvc pvc;
-		int state;
-
-		memset(&pvc, 0, sizeof(pvc));
-		pvc.sap_family = AF_ATMPVC;
-		pvc.sap_addr.itf = flow->vcc->dev ? flow->vcc->dev->number : -1;
-		pvc.sap_addr.vpi = flow->vcc->vpi;
-		pvc.sap_addr.vci = flow->vcc->vci;
-		if (nla_put(skb, TCA_ATM_ADDR, sizeof(pvc), &pvc))
-			goto nla_put_failure;
-		state = ATM_VF2VS(flow->vcc->flags);
-		if (nla_put_u32(skb, TCA_ATM_STATE, state))
-			goto nla_put_failure;
-	}
-	if (flow->excess) {
-		if (nla_put_u32(skb, TCA_ATM_EXCESS, flow->common.classid))
-			goto nla_put_failure;
-	} else {
-		if (nla_put_u32(skb, TCA_ATM_EXCESS, 0))
-			goto nla_put_failure;
-	}
-	return nla_nest_end(skb, nest);
-
-nla_put_failure:
-	nla_nest_cancel(skb, nest);
-	return -1;
-}
-static int
-atm_tc_dump_class_stats(struct Qdisc *sch, unsigned long arg,
-			struct gnet_dump *d)
-{
-	struct atm_flow_data *flow = (struct atm_flow_data *)arg;
-
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
-				  d, NULL, &flow->bstats) < 0 ||
-	    gnet_stats_copy_queue(d, NULL, &flow->qstats, flow->q->q.qlen) < 0)
-		return -1;
-
-	return 0;
-}
-
-static int atm_tc_dump(struct Qdisc *sch, struct sk_buff *skb)
-{
-	return 0;
-}
-
-static const struct Qdisc_class_ops atm_class_ops = {
-	.graft		= atm_tc_graft,
-	.leaf		= atm_tc_leaf,
-	.find		= atm_tc_find,
-	.change		= atm_tc_change,
-	.delete		= atm_tc_delete,
-	.walk		= atm_tc_walk,
-	.tcf_block	= atm_tc_tcf_block,
-	.bind_tcf	= atm_tc_bind_filter,
-	.unbind_tcf	= atm_tc_put,
-	.dump		= atm_tc_dump_class,
-	.dump_stats	= atm_tc_dump_class_stats,
-};
-
-static struct Qdisc_ops atm_qdisc_ops __read_mostly = {
-	.cl_ops		= &atm_class_ops,
-	.id		= "atm",
-	.priv_size	= sizeof(struct atm_qdisc_data),
-	.enqueue	= atm_tc_enqueue,
-	.dequeue	= atm_tc_dequeue,
-	.peek		= atm_tc_peek,
-	.init		= atm_tc_init,
-	.reset		= atm_tc_reset,
-	.destroy	= atm_tc_destroy,
-	.dump		= atm_tc_dump,
-	.owner		= THIS_MODULE,
-};
-
-static int __init atm_init(void)
-{
-	return register_qdisc(&atm_qdisc_ops);
-}
-
-static void __exit atm_exit(void)
-{
-	unregister_qdisc(&atm_qdisc_ops);
-}
-
-module_init(atm_init)
-module_exit(atm_exit)
-MODULE_LICENSE("GPL");
diff --git a/net/sched/sch_cbq.c b/net/sched/sch_cbq.c
deleted file mode 100644
index e6b84de41861..000000000000
--- a/net/sched/sch_cbq.c
+++ /dev/null
@@ -1,1818 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * net/sched/sch_cbq.c	Class-Based Queueing discipline.
- *
- * Authors:	Alexey Kuznetsov, <kuznet@ms2.inr.ac.ru>
- */
-
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/skbuff.h>
-#include <net/netlink.h>
-#include <net/pkt_sched.h>
-#include <net/pkt_cls.h>
-
-
-/*	Class-Based Queueing (CBQ) algorithm.
-	=======================================
-
-	Sources: [1] Sally Floyd and Van Jacobson, "Link-sharing and Resource
-		 Management Models for Packet Networks",
-		 IEEE/ACM Transactions on Networking, Vol.3, No.4, 1995
-
-		 [2] Sally Floyd, "Notes on CBQ and Guaranteed Service", 1995
-
-		 [3] Sally Floyd, "Notes on Class-Based Queueing: Setting
-		 Parameters", 1996
-
-		 [4] Sally Floyd and Michael Speer, "Experimental Results
-		 for Class-Based Queueing", 1998, not published.
-
-	-----------------------------------------------------------------------
-
-	Algorithm skeleton was taken from NS simulator cbq.cc.
-	If someone wants to check this code against the LBL version,
-	he should take into account that ONLY the skeleton was borrowed,
-	the implementation is different. Particularly:
-
-	--- The WRR algorithm is different. Our version looks more
-	reasonable (I hope) and works when quanta are allowed to be
-	less than MTU, which is always the case when real time classes
-	have small rates. Note, that the statement of [3] is
-	incomplete, delay may actually be estimated even if class
-	per-round allotment is less than MTU. Namely, if per-round
-	allotment is W*r_i, and r_1+...+r_k = r < 1
-
-	delay_i <= ([MTU/(W*r_i)]*W*r + W*r + k*MTU)/B
-
-	In the worst case we have IntServ estimate with D = W*r+k*MTU
-	and C = MTU*r. The proof (if correct at all) is trivial.
-
-
-	--- It seems that cbq-2.0 is not very accurate. At least, I cannot
-	interpret some places, which look like wrong translations
-	from NS. Anyone is advised to find these differences
-	and explain to me, why I am wrong 8).
-
-	--- Linux has no EOI event, so that we cannot estimate true class
-	idle time. Workaround is to consider the next dequeue event
-	as sign that previous packet is finished. This is wrong because of
-	internal device queueing, but on a permanently loaded link it is true.
-	Moreover, combined with clock integrator, this scheme looks
-	very close to an ideal solution.  */
-
-struct cbq_sched_data;
-
-
-struct cbq_class {
-	struct Qdisc_class_common common;
-	struct cbq_class	*next_alive;	/* next class with backlog in this priority band */
-
-/* Parameters */
-	unsigned char		priority;	/* class priority */
-	unsigned char		priority2;	/* priority to be used after overlimit */
-	unsigned char		ewma_log;	/* time constant for idle time calculation */
-
-	u32			defmap;
-
-	/* Link-sharing scheduler parameters */
-	long			maxidle;	/* Class parameters: see below. */
-	long			offtime;
-	long			minidle;
-	u32			avpkt;
-	struct qdisc_rate_table	*R_tab;
-
-	/* General scheduler (WRR) parameters */
-	long			allot;
-	long			quantum;	/* Allotment per WRR round */
-	long			weight;		/* Relative allotment: see below */
-
-	struct Qdisc		*qdisc;		/* Ptr to CBQ discipline */
-	struct cbq_class	*split;		/* Ptr to split node */
-	struct cbq_class	*share;		/* Ptr to LS parent in the class tree */
-	struct cbq_class	*tparent;	/* Ptr to tree parent in the class tree */
-	struct cbq_class	*borrow;	/* NULL if class is bandwidth limited;
-						   parent otherwise */
-	struct cbq_class	*sibling;	/* Sibling chain */
-	struct cbq_class	*children;	/* Pointer to children chain */
-
-	struct Qdisc		*q;		/* Elementary queueing discipline */
-
-
-/* Variables */
-	unsigned char		cpriority;	/* Effective priority */
-	unsigned char		delayed;
-	unsigned char		level;		/* level of the class in hierarchy:
-						   0 for leaf classes, and maximal
-						   level of children + 1 for nodes.
-						 */
-
-	psched_time_t		last;		/* Last end of service */
-	psched_time_t		undertime;
-	long			avgidle;
-	long			deficit;	/* Saved deficit for WRR */
-	psched_time_t		penalized;
-	struct gnet_stats_basic_packed bstats;
-	struct gnet_stats_queue qstats;
-	struct net_rate_estimator __rcu *rate_est;
-	struct tc_cbq_xstats	xstats;
-
-	struct tcf_proto __rcu	*filter_list;
-	struct tcf_block	*block;
-
-	int			filters;
-
-	struct cbq_class	*defaults[TC_PRIO_MAX + 1];
-};
-
-struct cbq_sched_data {
-	struct Qdisc_class_hash	clhash;			/* Hash table of all classes */
-	int			nclasses[TC_CBQ_MAXPRIO + 1];
-	unsigned int		quanta[TC_CBQ_MAXPRIO + 1];
-
-	struct cbq_class	link;
-
-	unsigned int		activemask;
-	struct cbq_class	*active[TC_CBQ_MAXPRIO + 1];	/* List of all classes
-								   with backlog */
-
-#ifdef CONFIG_NET_CLS_ACT
-	struct cbq_class	*rx_class;
-#endif
-	struct cbq_class	*tx_class;
-	struct cbq_class	*tx_borrowed;
-	int			tx_len;
-	psched_time_t		now;		/* Cached timestamp */
-	unsigned int		pmask;
-
-	struct hrtimer		delay_timer;
-	struct qdisc_watchdog	watchdog;	/* Watchdog timer,
-						   started when CBQ has
-						   backlog, but cannot
-						   transmit just now */
-	psched_tdiff_t		wd_expires;
-	int			toplevel;
-	u32			hgenerator;
-};
-
-
-#define L2T(cl, len)	qdisc_l2t((cl)->R_tab, len)
-
-static inline struct cbq_class *
-cbq_class_lookup(struct cbq_sched_data *q, u32 classid)
-{
-	struct Qdisc_class_common *clc;
-
-	clc = qdisc_class_find(&q->clhash, classid);
-	if (clc == NULL)
-		return NULL;
-	return container_of(clc, struct cbq_class, common);
-}
-
-#ifdef CONFIG_NET_CLS_ACT
-
-static struct cbq_class *
-cbq_reclassify(struct sk_buff *skb, struct cbq_class *this)
-{
-	struct cbq_class *cl;
-
-	for (cl = this->tparent; cl; cl = cl->tparent) {
-		struct cbq_class *new = cl->defaults[TC_PRIO_BESTEFFORT];
-
-		if (new != NULL && new != this)
-			return new;
-	}
-	return NULL;
-}
-
-#endif
-
-/* Classify packet. The procedure is pretty complicated, but
- * it allows us to combine link sharing and priority scheduling
- * transparently.
- *
- * Namely, you can put link sharing rules (f.e. route based) at root of CBQ,
- * so that it resolves to split nodes. Then packets are classified
- * by logical priority, or a more specific classifier may be attached
- * to the split node.
- */
-
-static struct cbq_class *
-cbq_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *head = &q->link;
-	struct cbq_class **defmap;
-	struct cbq_class *cl = NULL;
-	u32 prio = skb->priority;
-	struct tcf_proto *fl;
-	struct tcf_result res;
-
-	/*
-	 *  Step 1. If skb->priority points to one of our classes, use it.
-	 */
-	if (TC_H_MAJ(prio ^ sch->handle) == 0 &&
-	    (cl = cbq_class_lookup(q, prio)) != NULL)
-		return cl;
-
-	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-	for (;;) {
-		int result = 0;
-		defmap = head->defaults;
-
-		fl = rcu_dereference_bh(head->filter_list);
-		/*
-		 * Step 2+n. Apply classifier.
-		 */
-		result = tcf_classify(skb, fl, &res, true);
-		if (!fl || result < 0)
-			goto fallback;
-		if (result == TC_ACT_SHOT)
-			return NULL;
-
-		cl = (void *)res.class;
-		if (!cl) {
-			if (TC_H_MAJ(res.classid))
-				cl = cbq_class_lookup(q, res.classid);
-			else if ((cl = defmap[res.classid & TC_PRIO_MAX]) == NULL)
-				cl = defmap[TC_PRIO_BESTEFFORT];
-
-			if (cl == NULL)
-				goto fallback;
-		}
-		if (cl->level >= head->level)
-			goto fallback;
-#ifdef CONFIG_NET_CLS_ACT
-		switch (result) {
-		case TC_ACT_QUEUED:
-		case TC_ACT_STOLEN:
-		case TC_ACT_TRAP:
-			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
-			/* fall through */
-			fallthrough;
-		case TC_ACT_RECLASSIFY:
-			return cbq_reclassify(skb, cl);
-		}
-#endif
-		if (cl->level == 0)
-			return cl;
-
-		/*
-		 * Step 3+n. If classifier selected a link sharing class,
-		 *	   apply agency specific classifier.
-		 *	   Repeat this procdure until we hit a leaf node.
-		 */
-		head = cl;
-	}
-
-fallback:
-	cl = head;
-
-	/*
-	 * Step 4. No success...
-	 */
-	if (TC_H_MAJ(prio) == 0 &&
-	    !(cl = head->defaults[prio & TC_PRIO_MAX]) &&
-	    !(cl = head->defaults[TC_PRIO_BESTEFFORT]))
-		return head;
-
-	return cl;
-}
-
-/*
- * A packet has just been enqueued on the empty class.
- * cbq_activate_class adds it to the tail of active class list
- * of its priority band.
- */
-
-static inline void cbq_activate_class(struct cbq_class *cl)
-{
-	struct cbq_sched_data *q = qdisc_priv(cl->qdisc);
-	int prio = cl->cpriority;
-	struct cbq_class *cl_tail;
-
-	cl_tail = q->active[prio];
-	q->active[prio] = cl;
-
-	if (cl_tail != NULL) {
-		cl->next_alive = cl_tail->next_alive;
-		cl_tail->next_alive = cl;
-	} else {
-		cl->next_alive = cl;
-		q->activemask |= (1<<prio);
-	}
-}
-
-/*
- * Unlink class from active chain.
- * Note that this same procedure is done directly in cbq_dequeue*
- * during round-robin procedure.
- */
-
-static void cbq_deactivate_class(struct cbq_class *this)
-{
-	struct cbq_sched_data *q = qdisc_priv(this->qdisc);
-	int prio = this->cpriority;
-	struct cbq_class *cl;
-	struct cbq_class *cl_prev = q->active[prio];
-
-	do {
-		cl = cl_prev->next_alive;
-		if (cl == this) {
-			cl_prev->next_alive = cl->next_alive;
-			cl->next_alive = NULL;
-
-			if (cl == q->active[prio]) {
-				q->active[prio] = cl_prev;
-				if (cl == q->active[prio]) {
-					q->active[prio] = NULL;
-					q->activemask &= ~(1<<prio);
-					return;
-				}
-			}
-			return;
-		}
-	} while ((cl_prev = cl) != q->active[prio]);
-}
-
-static void
-cbq_mark_toplevel(struct cbq_sched_data *q, struct cbq_class *cl)
-{
-	int toplevel = q->toplevel;
-
-	if (toplevel > cl->level) {
-		psched_time_t now = psched_get_time();
-
-		do {
-			if (cl->undertime < now) {
-				q->toplevel = cl->level;
-				return;
-			}
-		} while ((cl = cl->borrow) != NULL && toplevel > cl->level);
-	}
-}
-
-static int
-cbq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
-	    struct sk_buff **to_free)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	int ret;
-	struct cbq_class *cl = cbq_classify(skb, sch, &ret);
-
-#ifdef CONFIG_NET_CLS_ACT
-	q->rx_class = cl;
-#endif
-	if (cl == NULL) {
-		if (ret & __NET_XMIT_BYPASS)
-			qdisc_qstats_drop(sch);
-		__qdisc_drop(skb, to_free);
-		return ret;
-	}
-
-	ret = qdisc_enqueue(skb, cl->q, to_free);
-	if (ret == NET_XMIT_SUCCESS) {
-		sch->q.qlen++;
-		cbq_mark_toplevel(q, cl);
-		if (!cl->next_alive)
-			cbq_activate_class(cl);
-		return ret;
-	}
-
-	if (net_xmit_drop_count(ret)) {
-		qdisc_qstats_drop(sch);
-		cbq_mark_toplevel(q, cl);
-		cl->qstats.drops++;
-	}
-	return ret;
-}
-
-/* Overlimit action: penalize leaf class by adding offtime */
-static void cbq_overlimit(struct cbq_class *cl)
-{
-	struct cbq_sched_data *q = qdisc_priv(cl->qdisc);
-	psched_tdiff_t delay = cl->undertime - q->now;
-
-	if (!cl->delayed) {
-		delay += cl->offtime;
-
-		/*
-		 * Class goes to sleep, so that it will have no
-		 * chance to work avgidle. Let's forgive it 8)
-		 *
-		 * BTW cbq-2.0 has a crap in this
-		 * place, apparently they forgot to shift it by cl->ewma_log.
-		 */
-		if (cl->avgidle < 0)
-			delay -= (-cl->avgidle) - ((-cl->avgidle) >> cl->ewma_log);
-		if (cl->avgidle < cl->minidle)
-			cl->avgidle = cl->minidle;
-		if (delay <= 0)
-			delay = 1;
-		cl->undertime = q->now + delay;
-
-		cl->xstats.overactions++;
-		cl->delayed = 1;
-	}
-	if (q->wd_expires == 0 || q->wd_expires > delay)
-		q->wd_expires = delay;
-
-	/* Dirty work! We must schedule wakeups based on
-	 * real available rate, rather than leaf rate,
-	 * which may be tiny (even zero).
-	 */
-	if (q->toplevel == TC_CBQ_MAXLEVEL) {
-		struct cbq_class *b;
-		psched_tdiff_t base_delay = q->wd_expires;
-
-		for (b = cl->borrow; b; b = b->borrow) {
-			delay = b->undertime - q->now;
-			if (delay < base_delay) {
-				if (delay <= 0)
-					delay = 1;
-				base_delay = delay;
-			}
-		}
-
-		q->wd_expires = base_delay;
-	}
-}
-
-static psched_tdiff_t cbq_undelay_prio(struct cbq_sched_data *q, int prio,
-				       psched_time_t now)
-{
-	struct cbq_class *cl;
-	struct cbq_class *cl_prev = q->active[prio];
-	psched_time_t sched = now;
-
-	if (cl_prev == NULL)
-		return 0;
-
-	do {
-		cl = cl_prev->next_alive;
-		if (now - cl->penalized > 0) {
-			cl_prev->next_alive = cl->next_alive;
-			cl->next_alive = NULL;
-			cl->cpriority = cl->priority;
-			cl->delayed = 0;
-			cbq_activate_class(cl);
-
-			if (cl == q->active[prio]) {
-				q->active[prio] = cl_prev;
-				if (cl == q->active[prio]) {
-					q->active[prio] = NULL;
-					return 0;
-				}
-			}
-
-			cl = cl_prev->next_alive;
-		} else if (sched - cl->penalized > 0)
-			sched = cl->penalized;
-	} while ((cl_prev = cl) != q->active[prio]);
-
-	return sched - now;
-}
-
-static enum hrtimer_restart cbq_undelay(struct hrtimer *timer)
-{
-	struct cbq_sched_data *q = container_of(timer, struct cbq_sched_data,
-						delay_timer);
-	struct Qdisc *sch = q->watchdog.qdisc;
-	psched_time_t now;
-	psched_tdiff_t delay = 0;
-	unsigned int pmask;
-
-	now = psched_get_time();
-
-	pmask = q->pmask;
-	q->pmask = 0;
-
-	while (pmask) {
-		int prio = ffz(~pmask);
-		psched_tdiff_t tmp;
-
-		pmask &= ~(1<<prio);
-
-		tmp = cbq_undelay_prio(q, prio, now);
-		if (tmp > 0) {
-			q->pmask |= 1<<prio;
-			if (tmp < delay || delay == 0)
-				delay = tmp;
-		}
-	}
-
-	if (delay) {
-		ktime_t time;
-
-		time = 0;
-		time = ktime_add_ns(time, PSCHED_TICKS2NS(now + delay));
-		hrtimer_start(&q->delay_timer, time, HRTIMER_MODE_ABS_PINNED);
-	}
-
-	__netif_schedule(qdisc_root(sch));
-	return HRTIMER_NORESTART;
-}
-
-/*
- * It is mission critical procedure.
- *
- * We "regenerate" toplevel cutoff, if transmitting class
- * has backlog and it is not regulated. It is not part of
- * original CBQ description, but looks more reasonable.
- * Probably, it is wrong. This question needs further investigation.
- */
-
-static inline void
-cbq_update_toplevel(struct cbq_sched_data *q, struct cbq_class *cl,
-		    struct cbq_class *borrowed)
-{
-	if (cl && q->toplevel >= borrowed->level) {
-		if (cl->q->q.qlen > 1) {
-			do {
-				if (borrowed->undertime == PSCHED_PASTPERFECT) {
-					q->toplevel = borrowed->level;
-					return;
-				}
-			} while ((borrowed = borrowed->borrow) != NULL);
-		}
-#if 0
-	/* It is not necessary now. Uncommenting it
-	   will save CPU cycles, but decrease fairness.
-	 */
-		q->toplevel = TC_CBQ_MAXLEVEL;
-#endif
-	}
-}
-
-static void
-cbq_update(struct cbq_sched_data *q)
-{
-	struct cbq_class *this = q->tx_class;
-	struct cbq_class *cl = this;
-	int len = q->tx_len;
-	psched_time_t now;
-
-	q->tx_class = NULL;
-	/* Time integrator. We calculate EOS time
-	 * by adding expected packet transmission time.
-	 */
-	now = q->now + L2T(&q->link, len);
-
-	for ( ; cl; cl = cl->share) {
-		long avgidle = cl->avgidle;
-		long idle;
-
-		cl->bstats.packets++;
-		cl->bstats.bytes += len;
-
-		/*
-		 * (now - last) is total time between packet right edges.
-		 * (last_pktlen/rate) is "virtual" busy time, so that
-		 *
-		 *	idle = (now - last) - last_pktlen/rate
-		 */
-
-		idle = now - cl->last;
-		if ((unsigned long)idle > 128*1024*1024) {
-			avgidle = cl->maxidle;
-		} else {
-			idle -= L2T(cl, len);
-
-		/* true_avgidle := (1-W)*true_avgidle + W*idle,
-		 * where W=2^{-ewma_log}. But cl->avgidle is scaled:
-		 * cl->avgidle == true_avgidle/W,
-		 * hence:
-		 */
-			avgidle += idle - (avgidle>>cl->ewma_log);
-		}
-
-		if (avgidle <= 0) {
-			/* Overlimit or at-limit */
-
-			if (avgidle < cl->minidle)
-				avgidle = cl->minidle;
-
-			cl->avgidle = avgidle;
-
-			/* Calculate expected time, when this class
-			 * will be allowed to send.
-			 * It will occur, when:
-			 * (1-W)*true_avgidle + W*delay = 0, i.e.
-			 * idle = (1/W - 1)*(-true_avgidle)
-			 * or
-			 * idle = (1 - W)*(-cl->avgidle);
-			 */
-			idle = (-avgidle) - ((-avgidle) >> cl->ewma_log);
-
-			/*
-			 * That is not all.
-			 * To maintain the rate allocated to the class,
-			 * we add to undertime virtual clock,
-			 * necessary to complete transmitted packet.
-			 * (len/phys_bandwidth has been already passed
-			 * to the moment of cbq_update)
-			 */
-
-			idle -= L2T(&q->link, len);
-			idle += L2T(cl, len);
-
-			cl->undertime = now + idle;
-		} else {
-			/* Underlimit */
-
-			cl->undertime = PSCHED_PASTPERFECT;
-			if (avgidle > cl->maxidle)
-				cl->avgidle = cl->maxidle;
-			else
-				cl->avgidle = avgidle;
-		}
-		if ((s64)(now - cl->last) > 0)
-			cl->last = now;
-	}
-
-	cbq_update_toplevel(q, this, q->tx_borrowed);
-}
-
-static inline struct cbq_class *
-cbq_under_limit(struct cbq_class *cl)
-{
-	struct cbq_sched_data *q = qdisc_priv(cl->qdisc);
-	struct cbq_class *this_cl = cl;
-
-	if (cl->tparent == NULL)
-		return cl;
-
-	if (cl->undertime == PSCHED_PASTPERFECT || q->now >= cl->undertime) {
-		cl->delayed = 0;
-		return cl;
-	}
-
-	do {
-		/* It is very suspicious place. Now overlimit
-		 * action is generated for not bounded classes
-		 * only if link is completely congested.
-		 * Though it is in agree with ancestor-only paradigm,
-		 * it looks very stupid. Particularly,
-		 * it means that this chunk of code will either
-		 * never be called or result in strong amplification
-		 * of burstiness. Dangerous, silly, and, however,
-		 * no another solution exists.
-		 */
-		cl = cl->borrow;
-		if (!cl) {
-			this_cl->qstats.overlimits++;
-			cbq_overlimit(this_cl);
-			return NULL;
-		}
-		if (cl->level > q->toplevel)
-			return NULL;
-	} while (cl->undertime != PSCHED_PASTPERFECT && q->now < cl->undertime);
-
-	cl->delayed = 0;
-	return cl;
-}
-
-static inline struct sk_buff *
-cbq_dequeue_prio(struct Qdisc *sch, int prio)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *cl_tail, *cl_prev, *cl;
-	struct sk_buff *skb;
-	int deficit;
-
-	cl_tail = cl_prev = q->active[prio];
-	cl = cl_prev->next_alive;
-
-	do {
-		deficit = 0;
-
-		/* Start round */
-		do {
-			struct cbq_class *borrow = cl;
-
-			if (cl->q->q.qlen &&
-			    (borrow = cbq_under_limit(cl)) == NULL)
-				goto skip_class;
-
-			if (cl->deficit <= 0) {
-				/* Class exhausted its allotment per
-				 * this round. Switch to the next one.
-				 */
-				deficit = 1;
-				cl->deficit += cl->quantum;
-				goto next_class;
-			}
-
-			skb = cl->q->dequeue(cl->q);
-
-			/* Class did not give us any skb :-(
-			 * It could occur even if cl->q->q.qlen != 0
-			 * f.e. if cl->q == "tbf"
-			 */
-			if (skb == NULL)
-				goto skip_class;
-
-			cl->deficit -= qdisc_pkt_len(skb);
-			q->tx_class = cl;
-			q->tx_borrowed = borrow;
-			if (borrow != cl) {
-#ifndef CBQ_XSTATS_BORROWS_BYTES
-				borrow->xstats.borrows++;
-				cl->xstats.borrows++;
-#else
-				borrow->xstats.borrows += qdisc_pkt_len(skb);
-				cl->xstats.borrows += qdisc_pkt_len(skb);
-#endif
-			}
-			q->tx_len = qdisc_pkt_len(skb);
-
-			if (cl->deficit <= 0) {
-				q->active[prio] = cl;
-				cl = cl->next_alive;
-				cl->deficit += cl->quantum;
-			}
-			return skb;
-
-skip_class:
-			if (cl->q->q.qlen == 0 || prio != cl->cpriority) {
-				/* Class is empty or penalized.
-				 * Unlink it from active chain.
-				 */
-				cl_prev->next_alive = cl->next_alive;
-				cl->next_alive = NULL;
-
-				/* Did cl_tail point to it? */
-				if (cl == cl_tail) {
-					/* Repair it! */
-					cl_tail = cl_prev;
-
-					/* Was it the last class in this band? */
-					if (cl == cl_tail) {
-						/* Kill the band! */
-						q->active[prio] = NULL;
-						q->activemask &= ~(1<<prio);
-						if (cl->q->q.qlen)
-							cbq_activate_class(cl);
-						return NULL;
-					}
-
-					q->active[prio] = cl_tail;
-				}
-				if (cl->q->q.qlen)
-					cbq_activate_class(cl);
-
-				cl = cl_prev;
-			}
-
-next_class:
-			cl_prev = cl;
-			cl = cl->next_alive;
-		} while (cl_prev != cl_tail);
-	} while (deficit);
-
-	q->active[prio] = cl_prev;
-
-	return NULL;
-}
-
-static inline struct sk_buff *
-cbq_dequeue_1(struct Qdisc *sch)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct sk_buff *skb;
-	unsigned int activemask;
-
-	activemask = q->activemask & 0xFF;
-	while (activemask) {
-		int prio = ffz(~activemask);
-		activemask &= ~(1<<prio);
-		skb = cbq_dequeue_prio(sch, prio);
-		if (skb)
-			return skb;
-	}
-	return NULL;
-}
-
-static struct sk_buff *
-cbq_dequeue(struct Qdisc *sch)
-{
-	struct sk_buff *skb;
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	psched_time_t now;
-
-	now = psched_get_time();
-
-	if (q->tx_class)
-		cbq_update(q);
-
-	q->now = now;
-
-	for (;;) {
-		q->wd_expires = 0;
-
-		skb = cbq_dequeue_1(sch);
-		if (skb) {
-			qdisc_bstats_update(sch, skb);
-			sch->q.qlen--;
-			return skb;
-		}
-
-		/* All the classes are overlimit.
-		 *
-		 * It is possible, if:
-		 *
-		 * 1. Scheduler is empty.
-		 * 2. Toplevel cutoff inhibited borrowing.
-		 * 3. Root class is overlimit.
-		 *
-		 * Reset 2d and 3d conditions and retry.
-		 *
-		 * Note, that NS and cbq-2.0 are buggy, peeking
-		 * an arbitrary class is appropriate for ancestor-only
-		 * sharing, but not for toplevel algorithm.
-		 *
-		 * Our version is better, but slower, because it requires
-		 * two passes, but it is unavoidable with top-level sharing.
-		 */
-
-		if (q->toplevel == TC_CBQ_MAXLEVEL &&
-		    q->link.undertime == PSCHED_PASTPERFECT)
-			break;
-
-		q->toplevel = TC_CBQ_MAXLEVEL;
-		q->link.undertime = PSCHED_PASTPERFECT;
-	}
-
-	/* No packets in scheduler or nobody wants to give them to us :-(
-	 * Sigh... start watchdog timer in the last case.
-	 */
-
-	if (sch->q.qlen) {
-		qdisc_qstats_overlimit(sch);
-		if (q->wd_expires)
-			qdisc_watchdog_schedule(&q->watchdog,
-						now + q->wd_expires);
-	}
-	return NULL;
-}
-
-/* CBQ class maintanance routines */
-
-static void cbq_adjust_levels(struct cbq_class *this)
-{
-	if (this == NULL)
-		return;
-
-	do {
-		int level = 0;
-		struct cbq_class *cl;
-
-		cl = this->children;
-		if (cl) {
-			do {
-				if (cl->level > level)
-					level = cl->level;
-			} while ((cl = cl->sibling) != this->children);
-		}
-		this->level = level + 1;
-	} while ((this = this->tparent) != NULL);
-}
-
-static void cbq_normalize_quanta(struct cbq_sched_data *q, int prio)
-{
-	struct cbq_class *cl;
-	unsigned int h;
-
-	if (q->quanta[prio] == 0)
-		return;
-
-	for (h = 0; h < q->clhash.hashsize; h++) {
-		hlist_for_each_entry(cl, &q->clhash.hash[h], common.hnode) {
-			/* BUGGGG... Beware! This expression suffer of
-			 * arithmetic overflows!
-			 */
-			if (cl->priority == prio) {
-				cl->quantum = (cl->weight*cl->allot*q->nclasses[prio])/
-					q->quanta[prio];
-			}
-			if (cl->quantum <= 0 ||
-			    cl->quantum > 32*qdisc_dev(cl->qdisc)->mtu) {
-				pr_warn("CBQ: class %08x has bad quantum==%ld, repaired.\n",
-					cl->common.classid, cl->quantum);
-				cl->quantum = qdisc_dev(cl->qdisc)->mtu/2 + 1;
-			}
-		}
-	}
-}
-
-static void cbq_sync_defmap(struct cbq_class *cl)
-{
-	struct cbq_sched_data *q = qdisc_priv(cl->qdisc);
-	struct cbq_class *split = cl->split;
-	unsigned int h;
-	int i;
-
-	if (split == NULL)
-		return;
-
-	for (i = 0; i <= TC_PRIO_MAX; i++) {
-		if (split->defaults[i] == cl && !(cl->defmap & (1<<i)))
-			split->defaults[i] = NULL;
-	}
-
-	for (i = 0; i <= TC_PRIO_MAX; i++) {
-		int level = split->level;
-
-		if (split->defaults[i])
-			continue;
-
-		for (h = 0; h < q->clhash.hashsize; h++) {
-			struct cbq_class *c;
-
-			hlist_for_each_entry(c, &q->clhash.hash[h],
-					     common.hnode) {
-				if (c->split == split && c->level < level &&
-				    c->defmap & (1<<i)) {
-					split->defaults[i] = c;
-					level = c->level;
-				}
-			}
-		}
-	}
-}
-
-static void cbq_change_defmap(struct cbq_class *cl, u32 splitid, u32 def, u32 mask)
-{
-	struct cbq_class *split = NULL;
-
-	if (splitid == 0) {
-		split = cl->split;
-		if (!split)
-			return;
-		splitid = split->common.classid;
-	}
-
-	if (split == NULL || split->common.classid != splitid) {
-		for (split = cl->tparent; split; split = split->tparent)
-			if (split->common.classid == splitid)
-				break;
-	}
-
-	if (split == NULL)
-		return;
-
-	if (cl->split != split) {
-		cl->defmap = 0;
-		cbq_sync_defmap(cl);
-		cl->split = split;
-		cl->defmap = def & mask;
-	} else
-		cl->defmap = (cl->defmap & ~mask) | (def & mask);
-
-	cbq_sync_defmap(cl);
-}
-
-static void cbq_unlink_class(struct cbq_class *this)
-{
-	struct cbq_class *cl, **clp;
-	struct cbq_sched_data *q = qdisc_priv(this->qdisc);
-
-	qdisc_class_hash_remove(&q->clhash, &this->common);
-
-	if (this->tparent) {
-		clp = &this->sibling;
-		cl = *clp;
-		do {
-			if (cl == this) {
-				*clp = cl->sibling;
-				break;
-			}
-			clp = &cl->sibling;
-		} while ((cl = *clp) != this->sibling);
-
-		if (this->tparent->children == this) {
-			this->tparent->children = this->sibling;
-			if (this->sibling == this)
-				this->tparent->children = NULL;
-		}
-	} else {
-		WARN_ON(this->sibling != this);
-	}
-}
-
-static void cbq_link_class(struct cbq_class *this)
-{
-	struct cbq_sched_data *q = qdisc_priv(this->qdisc);
-	struct cbq_class *parent = this->tparent;
-
-	this->sibling = this;
-	qdisc_class_hash_insert(&q->clhash, &this->common);
-
-	if (parent == NULL)
-		return;
-
-	if (parent->children == NULL) {
-		parent->children = this;
-	} else {
-		this->sibling = parent->children->sibling;
-		parent->children->sibling = this;
-	}
-}
-
-static void
-cbq_reset(struct Qdisc *sch)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *cl;
-	int prio;
-	unsigned int h;
-
-	q->activemask = 0;
-	q->pmask = 0;
-	q->tx_class = NULL;
-	q->tx_borrowed = NULL;
-	qdisc_watchdog_cancel(&q->watchdog);
-	hrtimer_cancel(&q->delay_timer);
-	q->toplevel = TC_CBQ_MAXLEVEL;
-	q->now = psched_get_time();
-
-	for (prio = 0; prio <= TC_CBQ_MAXPRIO; prio++)
-		q->active[prio] = NULL;
-
-	for (h = 0; h < q->clhash.hashsize; h++) {
-		hlist_for_each_entry(cl, &q->clhash.hash[h], common.hnode) {
-			qdisc_reset(cl->q);
-
-			cl->next_alive = NULL;
-			cl->undertime = PSCHED_PASTPERFECT;
-			cl->avgidle = cl->maxidle;
-			cl->deficit = cl->quantum;
-			cl->cpriority = cl->priority;
-		}
-	}
-	sch->q.qlen = 0;
-}
-
-
-static int cbq_set_lss(struct cbq_class *cl, struct tc_cbq_lssopt *lss)
-{
-	if (lss->change & TCF_CBQ_LSS_FLAGS) {
-		cl->share = (lss->flags & TCF_CBQ_LSS_ISOLATED) ? NULL : cl->tparent;
-		cl->borrow = (lss->flags & TCF_CBQ_LSS_BOUNDED) ? NULL : cl->tparent;
-	}
-	if (lss->change & TCF_CBQ_LSS_EWMA)
-		cl->ewma_log = lss->ewma_log;
-	if (lss->change & TCF_CBQ_LSS_AVPKT)
-		cl->avpkt = lss->avpkt;
-	if (lss->change & TCF_CBQ_LSS_MINIDLE)
-		cl->minidle = -(long)lss->minidle;
-	if (lss->change & TCF_CBQ_LSS_MAXIDLE) {
-		cl->maxidle = lss->maxidle;
-		cl->avgidle = lss->maxidle;
-	}
-	if (lss->change & TCF_CBQ_LSS_OFFTIME)
-		cl->offtime = lss->offtime;
-	return 0;
-}
-
-static void cbq_rmprio(struct cbq_sched_data *q, struct cbq_class *cl)
-{
-	q->nclasses[cl->priority]--;
-	q->quanta[cl->priority] -= cl->weight;
-	cbq_normalize_quanta(q, cl->priority);
-}
-
-static void cbq_addprio(struct cbq_sched_data *q, struct cbq_class *cl)
-{
-	q->nclasses[cl->priority]++;
-	q->quanta[cl->priority] += cl->weight;
-	cbq_normalize_quanta(q, cl->priority);
-}
-
-static int cbq_set_wrr(struct cbq_class *cl, struct tc_cbq_wrropt *wrr)
-{
-	struct cbq_sched_data *q = qdisc_priv(cl->qdisc);
-
-	if (wrr->allot)
-		cl->allot = wrr->allot;
-	if (wrr->weight)
-		cl->weight = wrr->weight;
-	if (wrr->priority) {
-		cl->priority = wrr->priority - 1;
-		cl->cpriority = cl->priority;
-		if (cl->priority >= cl->priority2)
-			cl->priority2 = TC_CBQ_MAXPRIO - 1;
-	}
-
-	cbq_addprio(q, cl);
-	return 0;
-}
-
-static int cbq_set_fopt(struct cbq_class *cl, struct tc_cbq_fopt *fopt)
-{
-	cbq_change_defmap(cl, fopt->split, fopt->defmap, fopt->defchange);
-	return 0;
-}
-
-static const struct nla_policy cbq_policy[TCA_CBQ_MAX + 1] = {
-	[TCA_CBQ_LSSOPT]	= { .len = sizeof(struct tc_cbq_lssopt) },
-	[TCA_CBQ_WRROPT]	= { .len = sizeof(struct tc_cbq_wrropt) },
-	[TCA_CBQ_FOPT]		= { .len = sizeof(struct tc_cbq_fopt) },
-	[TCA_CBQ_OVL_STRATEGY]	= { .len = sizeof(struct tc_cbq_ovl) },
-	[TCA_CBQ_RATE]		= { .len = sizeof(struct tc_ratespec) },
-	[TCA_CBQ_RTAB]		= { .type = NLA_BINARY, .len = TC_RTAB_SIZE },
-	[TCA_CBQ_POLICE]	= { .len = sizeof(struct tc_cbq_police) },
-};
-
-static int cbq_opt_parse(struct nlattr *tb[TCA_CBQ_MAX + 1],
-			 struct nlattr *opt,
-			 struct netlink_ext_ack *extack)
-{
-	int err;
-
-	if (!opt) {
-		NL_SET_ERR_MSG(extack, "CBQ options are required for this operation");
-		return -EINVAL;
-	}
-
-	err = nla_parse_nested_deprecated(tb, TCA_CBQ_MAX, opt,
-					  cbq_policy, extack);
-	if (err < 0)
-		return err;
-
-	if (tb[TCA_CBQ_WRROPT]) {
-		const struct tc_cbq_wrropt *wrr = nla_data(tb[TCA_CBQ_WRROPT]);
-
-		if (wrr->priority > TC_CBQ_MAXPRIO) {
-			NL_SET_ERR_MSG(extack, "priority is bigger than TC_CBQ_MAXPRIO");
-			err = -EINVAL;
-		}
-	}
-	return err;
-}
-
-static int cbq_init(struct Qdisc *sch, struct nlattr *opt,
-		    struct netlink_ext_ack *extack)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct nlattr *tb[TCA_CBQ_MAX + 1];
-	struct tc_ratespec *r;
-	int err;
-
-	qdisc_watchdog_init(&q->watchdog, sch);
-	hrtimer_init(&q->delay_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
-	q->delay_timer.function = cbq_undelay;
-
-	err = cbq_opt_parse(tb, opt, extack);
-	if (err < 0)
-		return err;
-
-	if (!tb[TCA_CBQ_RTAB] || !tb[TCA_CBQ_RATE]) {
-		NL_SET_ERR_MSG(extack, "Rate specification missing or incomplete");
-		return -EINVAL;
-	}
-
-	r = nla_data(tb[TCA_CBQ_RATE]);
-
-	q->link.R_tab = qdisc_get_rtab(r, tb[TCA_CBQ_RTAB], extack);
-	if (!q->link.R_tab)
-		return -EINVAL;
-
-	err = tcf_block_get(&q->link.block, &q->link.filter_list, sch, extack);
-	if (err)
-		goto put_rtab;
-
-	err = qdisc_class_hash_init(&q->clhash);
-	if (err < 0)
-		goto put_block;
-
-	q->link.sibling = &q->link;
-	q->link.common.classid = sch->handle;
-	q->link.qdisc = sch;
-	q->link.q = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
-				      sch->handle, NULL);
-	if (!q->link.q)
-		q->link.q = &noop_qdisc;
-	else
-		qdisc_hash_add(q->link.q, true);
-
-	q->link.priority = TC_CBQ_MAXPRIO - 1;
-	q->link.priority2 = TC_CBQ_MAXPRIO - 1;
-	q->link.cpriority = TC_CBQ_MAXPRIO - 1;
-	q->link.allot = psched_mtu(qdisc_dev(sch));
-	q->link.quantum = q->link.allot;
-	q->link.weight = q->link.R_tab->rate.rate;
-
-	q->link.ewma_log = TC_CBQ_DEF_EWMA;
-	q->link.avpkt = q->link.allot/2;
-	q->link.minidle = -0x7FFFFFFF;
-
-	q->toplevel = TC_CBQ_MAXLEVEL;
-	q->now = psched_get_time();
-
-	cbq_link_class(&q->link);
-
-	if (tb[TCA_CBQ_LSSOPT])
-		cbq_set_lss(&q->link, nla_data(tb[TCA_CBQ_LSSOPT]));
-
-	cbq_addprio(q, &q->link);
-	return 0;
-
-put_block:
-	tcf_block_put(q->link.block);
-
-put_rtab:
-	qdisc_put_rtab(q->link.R_tab);
-	return err;
-}
-
-static int cbq_dump_rate(struct sk_buff *skb, struct cbq_class *cl)
-{
-	unsigned char *b = skb_tail_pointer(skb);
-
-	if (nla_put(skb, TCA_CBQ_RATE, sizeof(cl->R_tab->rate), &cl->R_tab->rate))
-		goto nla_put_failure;
-	return skb->len;
-
-nla_put_failure:
-	nlmsg_trim(skb, b);
-	return -1;
-}
-
-static int cbq_dump_lss(struct sk_buff *skb, struct cbq_class *cl)
-{
-	unsigned char *b = skb_tail_pointer(skb);
-	struct tc_cbq_lssopt opt;
-
-	opt.flags = 0;
-	if (cl->borrow == NULL)
-		opt.flags |= TCF_CBQ_LSS_BOUNDED;
-	if (cl->share == NULL)
-		opt.flags |= TCF_CBQ_LSS_ISOLATED;
-	opt.ewma_log = cl->ewma_log;
-	opt.level = cl->level;
-	opt.avpkt = cl->avpkt;
-	opt.maxidle = cl->maxidle;
-	opt.minidle = (u32)(-cl->minidle);
-	opt.offtime = cl->offtime;
-	opt.change = ~0;
-	if (nla_put(skb, TCA_CBQ_LSSOPT, sizeof(opt), &opt))
-		goto nla_put_failure;
-	return skb->len;
-
-nla_put_failure:
-	nlmsg_trim(skb, b);
-	return -1;
-}
-
-static int cbq_dump_wrr(struct sk_buff *skb, struct cbq_class *cl)
-{
-	unsigned char *b = skb_tail_pointer(skb);
-	struct tc_cbq_wrropt opt;
-
-	memset(&opt, 0, sizeof(opt));
-	opt.flags = 0;
-	opt.allot = cl->allot;
-	opt.priority = cl->priority + 1;
-	opt.cpriority = cl->cpriority + 1;
-	opt.weight = cl->weight;
-	if (nla_put(skb, TCA_CBQ_WRROPT, sizeof(opt), &opt))
-		goto nla_put_failure;
-	return skb->len;
-
-nla_put_failure:
-	nlmsg_trim(skb, b);
-	return -1;
-}
-
-static int cbq_dump_fopt(struct sk_buff *skb, struct cbq_class *cl)
-{
-	unsigned char *b = skb_tail_pointer(skb);
-	struct tc_cbq_fopt opt;
-
-	if (cl->split || cl->defmap) {
-		opt.split = cl->split ? cl->split->common.classid : 0;
-		opt.defmap = cl->defmap;
-		opt.defchange = ~0;
-		if (nla_put(skb, TCA_CBQ_FOPT, sizeof(opt), &opt))
-			goto nla_put_failure;
-	}
-	return skb->len;
-
-nla_put_failure:
-	nlmsg_trim(skb, b);
-	return -1;
-}
-
-static int cbq_dump_attr(struct sk_buff *skb, struct cbq_class *cl)
-{
-	if (cbq_dump_lss(skb, cl) < 0 ||
-	    cbq_dump_rate(skb, cl) < 0 ||
-	    cbq_dump_wrr(skb, cl) < 0 ||
-	    cbq_dump_fopt(skb, cl) < 0)
-		return -1;
-	return 0;
-}
-
-static int cbq_dump(struct Qdisc *sch, struct sk_buff *skb)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct nlattr *nest;
-
-	nest = nla_nest_start_noflag(skb, TCA_OPTIONS);
-	if (nest == NULL)
-		goto nla_put_failure;
-	if (cbq_dump_attr(skb, &q->link) < 0)
-		goto nla_put_failure;
-	return nla_nest_end(skb, nest);
-
-nla_put_failure:
-	nla_nest_cancel(skb, nest);
-	return -1;
-}
-
-static int
-cbq_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-
-	q->link.xstats.avgidle = q->link.avgidle;
-	return gnet_stats_copy_app(d, &q->link.xstats, sizeof(q->link.xstats));
-}
-
-static int
-cbq_dump_class(struct Qdisc *sch, unsigned long arg,
-	       struct sk_buff *skb, struct tcmsg *tcm)
-{
-	struct cbq_class *cl = (struct cbq_class *)arg;
-	struct nlattr *nest;
-
-	if (cl->tparent)
-		tcm->tcm_parent = cl->tparent->common.classid;
-	else
-		tcm->tcm_parent = TC_H_ROOT;
-	tcm->tcm_handle = cl->common.classid;
-	tcm->tcm_info = cl->q->handle;
-
-	nest = nla_nest_start_noflag(skb, TCA_OPTIONS);
-	if (nest == NULL)
-		goto nla_put_failure;
-	if (cbq_dump_attr(skb, cl) < 0)
-		goto nla_put_failure;
-	return nla_nest_end(skb, nest);
-
-nla_put_failure:
-	nla_nest_cancel(skb, nest);
-	return -1;
-}
-
-static int
-cbq_dump_class_stats(struct Qdisc *sch, unsigned long arg,
-	struct gnet_dump *d)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *cl = (struct cbq_class *)arg;
-	__u32 qlen;
-
-	cl->xstats.avgidle = cl->avgidle;
-	cl->xstats.undertime = 0;
-	qdisc_qstats_qlen_backlog(cl->q, &qlen, &cl->qstats.backlog);
-
-	if (cl->undertime != PSCHED_PASTPERFECT)
-		cl->xstats.undertime = cl->undertime - q->now;
-
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
-				  d, NULL, &cl->bstats) < 0 ||
-	    gnet_stats_copy_rate_est(d, &cl->rate_est) < 0 ||
-	    gnet_stats_copy_queue(d, NULL, &cl->qstats, qlen) < 0)
-		return -1;
-
-	return gnet_stats_copy_app(d, &cl->xstats, sizeof(cl->xstats));
-}
-
-static int cbq_graft(struct Qdisc *sch, unsigned long arg, struct Qdisc *new,
-		     struct Qdisc **old, struct netlink_ext_ack *extack)
-{
-	struct cbq_class *cl = (struct cbq_class *)arg;
-
-	if (new == NULL) {
-		new = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
-					cl->common.classid, extack);
-		if (new == NULL)
-			return -ENOBUFS;
-	}
-
-	*old = qdisc_replace(sch, new, &cl->q);
-	return 0;
-}
-
-static struct Qdisc *cbq_leaf(struct Qdisc *sch, unsigned long arg)
-{
-	struct cbq_class *cl = (struct cbq_class *)arg;
-
-	return cl->q;
-}
-
-static void cbq_qlen_notify(struct Qdisc *sch, unsigned long arg)
-{
-	struct cbq_class *cl = (struct cbq_class *)arg;
-
-	cbq_deactivate_class(cl);
-}
-
-static unsigned long cbq_find(struct Qdisc *sch, u32 classid)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-
-	return (unsigned long)cbq_class_lookup(q, classid);
-}
-
-static void cbq_destroy_class(struct Qdisc *sch, struct cbq_class *cl)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-
-	WARN_ON(cl->filters);
-
-	tcf_block_put(cl->block);
-	qdisc_put(cl->q);
-	qdisc_put_rtab(cl->R_tab);
-	gen_kill_estimator(&cl->rate_est);
-	if (cl != &q->link)
-		kfree(cl);
-}
-
-static void cbq_destroy(struct Qdisc *sch)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct hlist_node *next;
-	struct cbq_class *cl;
-	unsigned int h;
-
-#ifdef CONFIG_NET_CLS_ACT
-	q->rx_class = NULL;
-#endif
-	/*
-	 * Filters must be destroyed first because we don't destroy the
-	 * classes from root to leafs which means that filters can still
-	 * be bound to classes which have been destroyed already. --TGR '04
-	 */
-	for (h = 0; h < q->clhash.hashsize; h++) {
-		hlist_for_each_entry(cl, &q->clhash.hash[h], common.hnode) {
-			tcf_block_put(cl->block);
-			cl->block = NULL;
-		}
-	}
-	for (h = 0; h < q->clhash.hashsize; h++) {
-		hlist_for_each_entry_safe(cl, next, &q->clhash.hash[h],
-					  common.hnode)
-			cbq_destroy_class(sch, cl);
-	}
-	qdisc_class_hash_destroy(&q->clhash);
-}
-
-static int
-cbq_change_class(struct Qdisc *sch, u32 classid, u32 parentid, struct nlattr **tca,
-		 unsigned long *arg, struct netlink_ext_ack *extack)
-{
-	int err;
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *cl = (struct cbq_class *)*arg;
-	struct nlattr *opt = tca[TCA_OPTIONS];
-	struct nlattr *tb[TCA_CBQ_MAX + 1];
-	struct cbq_class *parent;
-	struct qdisc_rate_table *rtab = NULL;
-
-	err = cbq_opt_parse(tb, opt, extack);
-	if (err < 0)
-		return err;
-
-	if (tb[TCA_CBQ_OVL_STRATEGY] || tb[TCA_CBQ_POLICE]) {
-		NL_SET_ERR_MSG(extack, "Neither overlimit strategy nor policing attributes can be used for changing class params");
-		return -EOPNOTSUPP;
-	}
-
-	if (cl) {
-		/* Check parent */
-		if (parentid) {
-			if (cl->tparent &&
-			    cl->tparent->common.classid != parentid) {
-				NL_SET_ERR_MSG(extack, "Invalid parent id");
-				return -EINVAL;
-			}
-			if (!cl->tparent && parentid != TC_H_ROOT) {
-				NL_SET_ERR_MSG(extack, "Parent must be root");
-				return -EINVAL;
-			}
-		}
-
-		if (tb[TCA_CBQ_RATE]) {
-			rtab = qdisc_get_rtab(nla_data(tb[TCA_CBQ_RATE]),
-					      tb[TCA_CBQ_RTAB], extack);
-			if (rtab == NULL)
-				return -EINVAL;
-		}
-
-		if (tca[TCA_RATE]) {
-			err = gen_replace_estimator(&cl->bstats, NULL,
-						    &cl->rate_est,
-						    NULL,
-						    qdisc_root_sleeping_running(sch),
-						    tca[TCA_RATE]);
-			if (err) {
-				NL_SET_ERR_MSG(extack, "Failed to replace specified rate estimator");
-				qdisc_put_rtab(rtab);
-				return err;
-			}
-		}
-
-		/* Change class parameters */
-		sch_tree_lock(sch);
-
-		if (cl->next_alive != NULL)
-			cbq_deactivate_class(cl);
-
-		if (rtab) {
-			qdisc_put_rtab(cl->R_tab);
-			cl->R_tab = rtab;
-		}
-
-		if (tb[TCA_CBQ_LSSOPT])
-			cbq_set_lss(cl, nla_data(tb[TCA_CBQ_LSSOPT]));
-
-		if (tb[TCA_CBQ_WRROPT]) {
-			cbq_rmprio(q, cl);
-			cbq_set_wrr(cl, nla_data(tb[TCA_CBQ_WRROPT]));
-		}
-
-		if (tb[TCA_CBQ_FOPT])
-			cbq_set_fopt(cl, nla_data(tb[TCA_CBQ_FOPT]));
-
-		if (cl->q->q.qlen)
-			cbq_activate_class(cl);
-
-		sch_tree_unlock(sch);
-
-		return 0;
-	}
-
-	if (parentid == TC_H_ROOT)
-		return -EINVAL;
-
-	if (!tb[TCA_CBQ_WRROPT] || !tb[TCA_CBQ_RATE] || !tb[TCA_CBQ_LSSOPT]) {
-		NL_SET_ERR_MSG(extack, "One of the following attributes MUST be specified: WRR, rate or link sharing");
-		return -EINVAL;
-	}
-
-	rtab = qdisc_get_rtab(nla_data(tb[TCA_CBQ_RATE]), tb[TCA_CBQ_RTAB],
-			      extack);
-	if (rtab == NULL)
-		return -EINVAL;
-
-	if (classid) {
-		err = -EINVAL;
-		if (TC_H_MAJ(classid ^ sch->handle) ||
-		    cbq_class_lookup(q, classid)) {
-			NL_SET_ERR_MSG(extack, "Specified class not found");
-			goto failure;
-		}
-	} else {
-		int i;
-		classid = TC_H_MAKE(sch->handle, 0x8000);
-
-		for (i = 0; i < 0x8000; i++) {
-			if (++q->hgenerator >= 0x8000)
-				q->hgenerator = 1;
-			if (cbq_class_lookup(q, classid|q->hgenerator) == NULL)
-				break;
-		}
-		err = -ENOSR;
-		if (i >= 0x8000) {
-			NL_SET_ERR_MSG(extack, "Unable to generate classid");
-			goto failure;
-		}
-		classid = classid|q->hgenerator;
-	}
-
-	parent = &q->link;
-	if (parentid) {
-		parent = cbq_class_lookup(q, parentid);
-		err = -EINVAL;
-		if (!parent) {
-			NL_SET_ERR_MSG(extack, "Failed to find parentid");
-			goto failure;
-		}
-	}
-
-	err = -ENOBUFS;
-	cl = kzalloc(sizeof(*cl), GFP_KERNEL);
-	if (cl == NULL)
-		goto failure;
-
-	err = tcf_block_get(&cl->block, &cl->filter_list, sch, extack);
-	if (err) {
-		kfree(cl);
-		goto failure;
-	}
-
-	if (tca[TCA_RATE]) {
-		err = gen_new_estimator(&cl->bstats, NULL, &cl->rate_est,
-					NULL,
-					qdisc_root_sleeping_running(sch),
-					tca[TCA_RATE]);
-		if (err) {
-			NL_SET_ERR_MSG(extack, "Couldn't create new estimator");
-			tcf_block_put(cl->block);
-			kfree(cl);
-			goto failure;
-		}
-	}
-
-	cl->R_tab = rtab;
-	rtab = NULL;
-	cl->q = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops, classid,
-				  NULL);
-	if (!cl->q)
-		cl->q = &noop_qdisc;
-	else
-		qdisc_hash_add(cl->q, true);
-
-	cl->common.classid = classid;
-	cl->tparent = parent;
-	cl->qdisc = sch;
-	cl->allot = parent->allot;
-	cl->quantum = cl->allot;
-	cl->weight = cl->R_tab->rate.rate;
-
-	sch_tree_lock(sch);
-	cbq_link_class(cl);
-	cl->borrow = cl->tparent;
-	if (cl->tparent != &q->link)
-		cl->share = cl->tparent;
-	cbq_adjust_levels(parent);
-	cl->minidle = -0x7FFFFFFF;
-	cbq_set_lss(cl, nla_data(tb[TCA_CBQ_LSSOPT]));
-	cbq_set_wrr(cl, nla_data(tb[TCA_CBQ_WRROPT]));
-	if (cl->ewma_log == 0)
-		cl->ewma_log = q->link.ewma_log;
-	if (cl->maxidle == 0)
-		cl->maxidle = q->link.maxidle;
-	if (cl->avpkt == 0)
-		cl->avpkt = q->link.avpkt;
-	if (tb[TCA_CBQ_FOPT])
-		cbq_set_fopt(cl, nla_data(tb[TCA_CBQ_FOPT]));
-	sch_tree_unlock(sch);
-
-	qdisc_class_hash_grow(sch, &q->clhash);
-
-	*arg = (unsigned long)cl;
-	return 0;
-
-failure:
-	qdisc_put_rtab(rtab);
-	return err;
-}
-
-static int cbq_delete(struct Qdisc *sch, unsigned long arg)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *cl = (struct cbq_class *)arg;
-
-	if (cl->filters || cl->children || cl == &q->link)
-		return -EBUSY;
-
-	sch_tree_lock(sch);
-
-	qdisc_purge_queue(cl->q);
-
-	if (cl->next_alive)
-		cbq_deactivate_class(cl);
-
-	if (q->tx_borrowed == cl)
-		q->tx_borrowed = q->tx_class;
-	if (q->tx_class == cl) {
-		q->tx_class = NULL;
-		q->tx_borrowed = NULL;
-	}
-#ifdef CONFIG_NET_CLS_ACT
-	if (q->rx_class == cl)
-		q->rx_class = NULL;
-#endif
-
-	cbq_unlink_class(cl);
-	cbq_adjust_levels(cl->tparent);
-	cl->defmap = 0;
-	cbq_sync_defmap(cl);
-
-	cbq_rmprio(q, cl);
-	sch_tree_unlock(sch);
-
-	cbq_destroy_class(sch, cl);
-	return 0;
-}
-
-static struct tcf_block *cbq_tcf_block(struct Qdisc *sch, unsigned long arg,
-				       struct netlink_ext_ack *extack)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *cl = (struct cbq_class *)arg;
-
-	if (cl == NULL)
-		cl = &q->link;
-
-	return cl->block;
-}
-
-static unsigned long cbq_bind_filter(struct Qdisc *sch, unsigned long parent,
-				     u32 classid)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *p = (struct cbq_class *)parent;
-	struct cbq_class *cl = cbq_class_lookup(q, classid);
-
-	if (cl) {
-		if (p && p->level <= cl->level)
-			return 0;
-		cl->filters++;
-		return (unsigned long)cl;
-	}
-	return 0;
-}
-
-static void cbq_unbind_filter(struct Qdisc *sch, unsigned long arg)
-{
-	struct cbq_class *cl = (struct cbq_class *)arg;
-
-	cl->filters--;
-}
-
-static void cbq_walk(struct Qdisc *sch, struct qdisc_walker *arg)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *cl;
-	unsigned int h;
-
-	if (arg->stop)
-		return;
-
-	for (h = 0; h < q->clhash.hashsize; h++) {
-		hlist_for_each_entry(cl, &q->clhash.hash[h], common.hnode) {
-			if (arg->count < arg->skip) {
-				arg->count++;
-				continue;
-			}
-			if (arg->fn(sch, (unsigned long)cl, arg) < 0) {
-				arg->stop = 1;
-				return;
-			}
-			arg->count++;
-		}
-	}
-}
-
-static const struct Qdisc_class_ops cbq_class_ops = {
-	.graft		=	cbq_graft,
-	.leaf		=	cbq_leaf,
-	.qlen_notify	=	cbq_qlen_notify,
-	.find		=	cbq_find,
-	.change		=	cbq_change_class,
-	.delete		=	cbq_delete,
-	.walk		=	cbq_walk,
-	.tcf_block	=	cbq_tcf_block,
-	.bind_tcf	=	cbq_bind_filter,
-	.unbind_tcf	=	cbq_unbind_filter,
-	.dump		=	cbq_dump_class,
-	.dump_stats	=	cbq_dump_class_stats,
-};
-
-static struct Qdisc_ops cbq_qdisc_ops __read_mostly = {
-	.next		=	NULL,
-	.cl_ops		=	&cbq_class_ops,
-	.id		=	"cbq",
-	.priv_size	=	sizeof(struct cbq_sched_data),
-	.enqueue	=	cbq_enqueue,
-	.dequeue	=	cbq_dequeue,
-	.peek		=	qdisc_peek_dequeued,
-	.init		=	cbq_init,
-	.reset		=	cbq_reset,
-	.destroy	=	cbq_destroy,
-	.change		=	NULL,
-	.dump		=	cbq_dump,
-	.dump_stats	=	cbq_dump_stats,
-	.owner		=	THIS_MODULE,
-};
-
-static int __init cbq_module_init(void)
-{
-	return register_qdisc(&cbq_qdisc_ops);
-}
-static void __exit cbq_module_exit(void)
-{
-	unregister_qdisc(&cbq_qdisc_ops);
-}
-module_init(cbq_module_init)
-module_exit(cbq_module_exit)
-MODULE_LICENSE("GPL");
diff --git a/net/sched/sch_dsmark.c b/net/sched/sch_dsmark.c
deleted file mode 100644
index 76ed1a05ded2..000000000000
--- a/net/sched/sch_dsmark.c
+++ /dev/null
@@ -1,523 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* net/sched/sch_dsmark.c - Differentiated Services field marker */
-
-/* Written 1998-2000 by Werner Almesberger, EPFL ICA */
-
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/skbuff.h>
-#include <linux/rtnetlink.h>
-#include <linux/bitops.h>
-#include <net/pkt_sched.h>
-#include <net/pkt_cls.h>
-#include <net/dsfield.h>
-#include <net/inet_ecn.h>
-#include <asm/byteorder.h>
-
-/*
- * classid	class		marking
- * -------	-----		-------
- *   n/a	  0		n/a
- *   x:0	  1		use entry [0]
- *   ...	 ...		...
- *   x:y y>0	 y+1		use entry [y]
- *   ...	 ...		...
- * x:indices-1	indices		use entry [indices-1]
- *   ...	 ...		...
- *   x:y	 y+1		use entry [y & (indices-1)]
- *   ...	 ...		...
- * 0xffff	0x10000		use entry [indices-1]
- */
-
-
-#define NO_DEFAULT_INDEX	(1 << 16)
-
-struct mask_value {
-	u8			mask;
-	u8			value;
-};
-
-struct dsmark_qdisc_data {
-	struct Qdisc		*q;
-	struct tcf_proto __rcu	*filter_list;
-	struct tcf_block	*block;
-	struct mask_value	*mv;
-	u16			indices;
-	u8			set_tc_index;
-	u32			default_index;	/* index range is 0...0xffff */
-#define DSMARK_EMBEDDED_SZ	16
-	struct mask_value	embedded[DSMARK_EMBEDDED_SZ];
-};
-
-static inline int dsmark_valid_index(struct dsmark_qdisc_data *p, u16 index)
-{
-	return index <= p->indices && index > 0;
-}
-
-/* ------------------------- Class/flow operations ------------------------- */
-
-static int dsmark_graft(struct Qdisc *sch, unsigned long arg,
-			struct Qdisc *new, struct Qdisc **old,
-			struct netlink_ext_ack *extack)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-
-	pr_debug("%s(sch %p,[qdisc %p],new %p,old %p)\n",
-		 __func__, sch, p, new, old);
-
-	if (new == NULL) {
-		new = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
-					sch->handle, NULL);
-		if (new == NULL)
-			new = &noop_qdisc;
-	}
-
-	*old = qdisc_replace(sch, new, &p->q);
-	return 0;
-}
-
-static struct Qdisc *dsmark_leaf(struct Qdisc *sch, unsigned long arg)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	return p->q;
-}
-
-static unsigned long dsmark_find(struct Qdisc *sch, u32 classid)
-{
-	return TC_H_MIN(classid) + 1;
-}
-
-static unsigned long dsmark_bind_filter(struct Qdisc *sch,
-					unsigned long parent, u32 classid)
-{
-	pr_debug("%s(sch %p,[qdisc %p],classid %x)\n",
-		 __func__, sch, qdisc_priv(sch), classid);
-
-	return dsmark_find(sch, classid);
-}
-
-static void dsmark_unbind_filter(struct Qdisc *sch, unsigned long cl)
-{
-}
-
-static const struct nla_policy dsmark_policy[TCA_DSMARK_MAX + 1] = {
-	[TCA_DSMARK_INDICES]		= { .type = NLA_U16 },
-	[TCA_DSMARK_DEFAULT_INDEX]	= { .type = NLA_U16 },
-	[TCA_DSMARK_SET_TC_INDEX]	= { .type = NLA_FLAG },
-	[TCA_DSMARK_MASK]		= { .type = NLA_U8 },
-	[TCA_DSMARK_VALUE]		= { .type = NLA_U8 },
-};
-
-static int dsmark_change(struct Qdisc *sch, u32 classid, u32 parent,
-			 struct nlattr **tca, unsigned long *arg,
-			 struct netlink_ext_ack *extack)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	struct nlattr *opt = tca[TCA_OPTIONS];
-	struct nlattr *tb[TCA_DSMARK_MAX + 1];
-	int err = -EINVAL;
-
-	pr_debug("%s(sch %p,[qdisc %p],classid %x,parent %x), arg 0x%lx\n",
-		 __func__, sch, p, classid, parent, *arg);
-
-	if (!dsmark_valid_index(p, *arg)) {
-		err = -ENOENT;
-		goto errout;
-	}
-
-	if (!opt)
-		goto errout;
-
-	err = nla_parse_nested_deprecated(tb, TCA_DSMARK_MAX, opt,
-					  dsmark_policy, NULL);
-	if (err < 0)
-		goto errout;
-
-	if (tb[TCA_DSMARK_VALUE])
-		p->mv[*arg - 1].value = nla_get_u8(tb[TCA_DSMARK_VALUE]);
-
-	if (tb[TCA_DSMARK_MASK])
-		p->mv[*arg - 1].mask = nla_get_u8(tb[TCA_DSMARK_MASK]);
-
-	err = 0;
-
-errout:
-	return err;
-}
-
-static int dsmark_delete(struct Qdisc *sch, unsigned long arg)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-
-	if (!dsmark_valid_index(p, arg))
-		return -EINVAL;
-
-	p->mv[arg - 1].mask = 0xff;
-	p->mv[arg - 1].value = 0;
-
-	return 0;
-}
-
-static void dsmark_walk(struct Qdisc *sch, struct qdisc_walker *walker)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	int i;
-
-	pr_debug("%s(sch %p,[qdisc %p],walker %p)\n",
-		 __func__, sch, p, walker);
-
-	if (walker->stop)
-		return;
-
-	for (i = 0; i < p->indices; i++) {
-		if (p->mv[i].mask == 0xff && !p->mv[i].value)
-			goto ignore;
-		if (walker->count >= walker->skip) {
-			if (walker->fn(sch, i + 1, walker) < 0) {
-				walker->stop = 1;
-				break;
-			}
-		}
-ignore:
-		walker->count++;
-	}
-}
-
-static struct tcf_block *dsmark_tcf_block(struct Qdisc *sch, unsigned long cl,
-					  struct netlink_ext_ack *extack)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-
-	return p->block;
-}
-
-/* --------------------------- Qdisc operations ---------------------------- */
-
-static int dsmark_enqueue(struct sk_buff *skb, struct Qdisc *sch,
-			  struct sk_buff **to_free)
-{
-	unsigned int len = qdisc_pkt_len(skb);
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	int err;
-
-	pr_debug("%s(skb %p,sch %p,[qdisc %p])\n", __func__, skb, sch, p);
-
-	if (p->set_tc_index) {
-		int wlen = skb_network_offset(skb);
-
-		switch (skb_protocol(skb, true)) {
-		case htons(ETH_P_IP):
-			wlen += sizeof(struct iphdr);
-			if (!pskb_may_pull(skb, wlen) ||
-			    skb_try_make_writable(skb, wlen))
-				goto drop;
-
-			skb->tc_index = ipv4_get_dsfield(ip_hdr(skb))
-				& ~INET_ECN_MASK;
-			break;
-
-		case htons(ETH_P_IPV6):
-			wlen += sizeof(struct ipv6hdr);
-			if (!pskb_may_pull(skb, wlen) ||
-			    skb_try_make_writable(skb, wlen))
-				goto drop;
-
-			skb->tc_index = ipv6_get_dsfield(ipv6_hdr(skb))
-				& ~INET_ECN_MASK;
-			break;
-		default:
-			skb->tc_index = 0;
-			break;
-		}
-	}
-
-	if (TC_H_MAJ(skb->priority) == sch->handle)
-		skb->tc_index = TC_H_MIN(skb->priority);
-	else {
-		struct tcf_result res;
-		struct tcf_proto *fl = rcu_dereference_bh(p->filter_list);
-		int result = tcf_classify(skb, fl, &res, false);
-
-		pr_debug("result %d class 0x%04x\n", result, res.classid);
-
-		switch (result) {
-#ifdef CONFIG_NET_CLS_ACT
-		case TC_ACT_QUEUED:
-		case TC_ACT_STOLEN:
-		case TC_ACT_TRAP:
-			__qdisc_drop(skb, to_free);
-			return NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
-
-		case TC_ACT_SHOT:
-			goto drop;
-#endif
-		case TC_ACT_OK:
-			skb->tc_index = TC_H_MIN(res.classid);
-			break;
-
-		default:
-			if (p->default_index != NO_DEFAULT_INDEX)
-				skb->tc_index = p->default_index;
-			break;
-		}
-	}
-
-	err = qdisc_enqueue(skb, p->q, to_free);
-	if (err != NET_XMIT_SUCCESS) {
-		if (net_xmit_drop_count(err))
-			qdisc_qstats_drop(sch);
-		return err;
-	}
-
-	sch->qstats.backlog += len;
-	sch->q.qlen++;
-
-	return NET_XMIT_SUCCESS;
-
-drop:
-	qdisc_drop(skb, sch, to_free);
-	return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-}
-
-static struct sk_buff *dsmark_dequeue(struct Qdisc *sch)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	struct sk_buff *skb;
-	u32 index;
-
-	pr_debug("%s(sch %p,[qdisc %p])\n", __func__, sch, p);
-
-	skb = qdisc_dequeue_peeked(p->q);
-	if (skb == NULL)
-		return NULL;
-
-	qdisc_bstats_update(sch, skb);
-	qdisc_qstats_backlog_dec(sch, skb);
-	sch->q.qlen--;
-
-	index = skb->tc_index & (p->indices - 1);
-	pr_debug("index %d->%d\n", skb->tc_index, index);
-
-	switch (skb_protocol(skb, true)) {
-	case htons(ETH_P_IP):
-		ipv4_change_dsfield(ip_hdr(skb), p->mv[index].mask,
-				    p->mv[index].value);
-			break;
-	case htons(ETH_P_IPV6):
-		ipv6_change_dsfield(ipv6_hdr(skb), p->mv[index].mask,
-				    p->mv[index].value);
-			break;
-	default:
-		/*
-		 * Only complain if a change was actually attempted.
-		 * This way, we can send non-IP traffic through dsmark
-		 * and don't need yet another qdisc as a bypass.
-		 */
-		if (p->mv[index].mask != 0xff || p->mv[index].value)
-			pr_warn("%s: unsupported protocol %d\n",
-				__func__, ntohs(skb_protocol(skb, true)));
-		break;
-	}
-
-	return skb;
-}
-
-static struct sk_buff *dsmark_peek(struct Qdisc *sch)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-
-	pr_debug("%s(sch %p,[qdisc %p])\n", __func__, sch, p);
-
-	return p->q->ops->peek(p->q);
-}
-
-static int dsmark_init(struct Qdisc *sch, struct nlattr *opt,
-		       struct netlink_ext_ack *extack)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	struct nlattr *tb[TCA_DSMARK_MAX + 1];
-	int err = -EINVAL;
-	u32 default_index = NO_DEFAULT_INDEX;
-	u16 indices;
-	int i;
-
-	pr_debug("%s(sch %p,[qdisc %p],opt %p)\n", __func__, sch, p, opt);
-
-	if (!opt)
-		goto errout;
-
-	err = tcf_block_get(&p->block, &p->filter_list, sch, extack);
-	if (err)
-		return err;
-
-	err = nla_parse_nested_deprecated(tb, TCA_DSMARK_MAX, opt,
-					  dsmark_policy, NULL);
-	if (err < 0)
-		goto errout;
-
-	err = -EINVAL;
-	if (!tb[TCA_DSMARK_INDICES])
-		goto errout;
-	indices = nla_get_u16(tb[TCA_DSMARK_INDICES]);
-
-	if (hweight32(indices) != 1)
-		goto errout;
-
-	if (tb[TCA_DSMARK_DEFAULT_INDEX])
-		default_index = nla_get_u16(tb[TCA_DSMARK_DEFAULT_INDEX]);
-
-	if (indices <= DSMARK_EMBEDDED_SZ)
-		p->mv = p->embedded;
-	else
-		p->mv = kmalloc_array(indices, sizeof(*p->mv), GFP_KERNEL);
-	if (!p->mv) {
-		err = -ENOMEM;
-		goto errout;
-	}
-	for (i = 0; i < indices; i++) {
-		p->mv[i].mask = 0xff;
-		p->mv[i].value = 0;
-	}
-	p->indices = indices;
-	p->default_index = default_index;
-	p->set_tc_index = nla_get_flag(tb[TCA_DSMARK_SET_TC_INDEX]);
-
-	p->q = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops, sch->handle,
-				 NULL);
-	if (p->q == NULL)
-		p->q = &noop_qdisc;
-	else
-		qdisc_hash_add(p->q, true);
-
-	pr_debug("%s: qdisc %p\n", __func__, p->q);
-
-	err = 0;
-errout:
-	return err;
-}
-
-static void dsmark_reset(struct Qdisc *sch)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-
-	pr_debug("%s(sch %p,[qdisc %p])\n", __func__, sch, p);
-	if (p->q)
-		qdisc_reset(p->q);
-	sch->qstats.backlog = 0;
-	sch->q.qlen = 0;
-}
-
-static void dsmark_destroy(struct Qdisc *sch)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-
-	pr_debug("%s(sch %p,[qdisc %p])\n", __func__, sch, p);
-
-	tcf_block_put(p->block);
-	qdisc_put(p->q);
-	if (p->mv != p->embedded)
-		kfree(p->mv);
-}
-
-static int dsmark_dump_class(struct Qdisc *sch, unsigned long cl,
-			     struct sk_buff *skb, struct tcmsg *tcm)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	struct nlattr *opts = NULL;
-
-	pr_debug("%s(sch %p,[qdisc %p],class %ld\n", __func__, sch, p, cl);
-
-	if (!dsmark_valid_index(p, cl))
-		return -EINVAL;
-
-	tcm->tcm_handle = TC_H_MAKE(TC_H_MAJ(sch->handle), cl - 1);
-	tcm->tcm_info = p->q->handle;
-
-	opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
-	if (opts == NULL)
-		goto nla_put_failure;
-	if (nla_put_u8(skb, TCA_DSMARK_MASK, p->mv[cl - 1].mask) ||
-	    nla_put_u8(skb, TCA_DSMARK_VALUE, p->mv[cl - 1].value))
-		goto nla_put_failure;
-
-	return nla_nest_end(skb, opts);
-
-nla_put_failure:
-	nla_nest_cancel(skb, opts);
-	return -EMSGSIZE;
-}
-
-static int dsmark_dump(struct Qdisc *sch, struct sk_buff *skb)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	struct nlattr *opts = NULL;
-
-	opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
-	if (opts == NULL)
-		goto nla_put_failure;
-	if (nla_put_u16(skb, TCA_DSMARK_INDICES, p->indices))
-		goto nla_put_failure;
-
-	if (p->default_index != NO_DEFAULT_INDEX &&
-	    nla_put_u16(skb, TCA_DSMARK_DEFAULT_INDEX, p->default_index))
-		goto nla_put_failure;
-
-	if (p->set_tc_index &&
-	    nla_put_flag(skb, TCA_DSMARK_SET_TC_INDEX))
-		goto nla_put_failure;
-
-	return nla_nest_end(skb, opts);
-
-nla_put_failure:
-	nla_nest_cancel(skb, opts);
-	return -EMSGSIZE;
-}
-
-static const struct Qdisc_class_ops dsmark_class_ops = {
-	.graft		=	dsmark_graft,
-	.leaf		=	dsmark_leaf,
-	.find		=	dsmark_find,
-	.change		=	dsmark_change,
-	.delete		=	dsmark_delete,
-	.walk		=	dsmark_walk,
-	.tcf_block	=	dsmark_tcf_block,
-	.bind_tcf	=	dsmark_bind_filter,
-	.unbind_tcf	=	dsmark_unbind_filter,
-	.dump		=	dsmark_dump_class,
-};
-
-static struct Qdisc_ops dsmark_qdisc_ops __read_mostly = {
-	.next		=	NULL,
-	.cl_ops		=	&dsmark_class_ops,
-	.id		=	"dsmark",
-	.priv_size	=	sizeof(struct dsmark_qdisc_data),
-	.enqueue	=	dsmark_enqueue,
-	.dequeue	=	dsmark_dequeue,
-	.peek		=	dsmark_peek,
-	.init		=	dsmark_init,
-	.reset		=	dsmark_reset,
-	.destroy	=	dsmark_destroy,
-	.change		=	NULL,
-	.dump		=	dsmark_dump,
-	.owner		=	THIS_MODULE,
-};
-
-static int __init dsmark_module_init(void)
-{
-	return register_qdisc(&dsmark_qdisc_ops);
-}
-
-static void __exit dsmark_module_exit(void)
-{
-	unregister_qdisc(&dsmark_qdisc_ops);
-}
-
-module_init(dsmark_module_init)
-module_exit(dsmark_module_exit)
-
-MODULE_LICENSE("GPL");
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 38592d0871a3..910da98d6bfb 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1748,6 +1748,7 @@ int tls_sw_recvmsg(struct sock *sk,
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
 	struct tls_prot_info *prot = &tls_ctx->prot_info;
 	struct sk_psock *psock;
+	int num_async, pending;
 	unsigned char control = 0;
 	ssize_t decrypted = 0;
 	struct strp_msg *rxm;
@@ -1760,8 +1761,6 @@ int tls_sw_recvmsg(struct sock *sk,
 	bool is_kvec = iov_iter_is_kvec(&msg->msg_iter);
 	bool is_peek = flags & MSG_PEEK;
 	bool bpf_strp_enabled;
-	int num_async = 0;
-	int pending;
 
 	flags |= nonblock;
 
@@ -1778,17 +1777,18 @@ int tls_sw_recvmsg(struct sock *sk,
 	if (err < 0) {
 		tls_err_abort(sk, err);
 		goto end;
-	} else {
-		copied = err;
 	}
 
-	if (len <= copied)
-		goto recv_end;
+	copied = err;
+	if (len <= copied || (copied && control != TLS_RECORD_TYPE_DATA))
+		goto end;
 
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
 	len = len - copied;
 	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
 
+	decrypted = 0;
+	num_async = 0;
 	while (len && (decrypted + copied < target || ctx->recv_pkt)) {
 		bool retain_skb = false;
 		bool zc = false;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0926a30bc739..494de0161d2f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3350,6 +3350,7 @@ static int nl80211_dump_interface(struct sk_buff *skb, struct netlink_callback *
 			if_idx++;
 		}
 
+		if_start = 0;
 		wp_idx++;
 	}
  out:
diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
index 894cc58c1a03..030a843a4794 100755
--- a/scripts/bpf_helpers_doc.py
+++ b/scripts/bpf_helpers_doc.py
@@ -286,7 +286,7 @@ eBPF programs can have an associated license, passed along with the bytecode
 instructions to the kernel when the programs are loaded. The format for that
 string is identical to the one in use for kernel modules (Dual licenses, such
 as "Dual BSD/GPL", may be used). Some helper functions are only accessible to
-programs that are compatible with the GNU Privacy License (GPL).
+programs that are compatible with the GNU General Public License (GNU GPL).
 
 In order to use such helpers, the eBPF program must be loaded with the correct
 license string passed (via **attr**) to the **bpf**\ () system call, and this
@@ -391,6 +391,154 @@ SEE ALSO
 
         print('')
 
+class PrinterHelpers(Printer):
+    """
+    A printer for dumping collected information about helpers as C header to
+    be included from BPF program.
+    @helpers: array of Helper objects to print to standard output
+    """
+
+    type_fwds = [
+            'struct bpf_fib_lookup',
+            'struct bpf_perf_event_data',
+            'struct bpf_perf_event_value',
+            'struct bpf_sock',
+            'struct bpf_sock_addr',
+            'struct bpf_sock_ops',
+            'struct bpf_sock_tuple',
+            'struct bpf_spin_lock',
+            'struct bpf_sysctl',
+            'struct bpf_tcp_sock',
+            'struct bpf_tunnel_key',
+            'struct bpf_xfrm_state',
+            'struct pt_regs',
+            'struct sk_reuseport_md',
+            'struct sockaddr',
+            'struct tcphdr',
+
+            'struct __sk_buff',
+            'struct sk_msg_md',
+            'struct xdp_md',
+    ]
+    known_types = {
+            '...',
+            'void',
+            'const void',
+            'char',
+            'const char',
+            'int',
+            'long',
+            'unsigned long',
+
+            '__be16',
+            '__be32',
+            '__wsum',
+
+            'struct bpf_fib_lookup',
+            'struct bpf_perf_event_data',
+            'struct bpf_perf_event_value',
+            'struct bpf_sock',
+            'struct bpf_sock_addr',
+            'struct bpf_sock_ops',
+            'struct bpf_sock_tuple',
+            'struct bpf_spin_lock',
+            'struct bpf_sysctl',
+            'struct bpf_tcp_sock',
+            'struct bpf_tunnel_key',
+            'struct bpf_xfrm_state',
+            'struct pt_regs',
+            'struct sk_reuseport_md',
+            'struct sockaddr',
+            'struct tcphdr',
+    }
+    mapped_types = {
+            'u8': '__u8',
+            'u16': '__u16',
+            'u32': '__u32',
+            'u64': '__u64',
+            's8': '__s8',
+            's16': '__s16',
+            's32': '__s32',
+            's64': '__s64',
+            'size_t': 'unsigned long',
+            'struct bpf_map': 'void',
+            'struct sk_buff': 'struct __sk_buff',
+            'const struct sk_buff': 'const struct __sk_buff',
+            'struct sk_msg_buff': 'struct sk_msg_md',
+            'struct xdp_buff': 'struct xdp_md',
+    }
+
+    def print_header(self):
+        header = '''\
+/* This is auto-generated file. See bpf_helpers_doc.py for details. */
+
+/* Forward declarations of BPF structs */'''
+
+        print(header)
+        for fwd in self.type_fwds:
+            print('%s;' % fwd)
+        print('')
+
+    def print_footer(self):
+        footer = ''
+        print(footer)
+
+    def map_type(self, t):
+        if t in self.known_types:
+            return t
+        if t in self.mapped_types:
+            return self.mapped_types[t]
+        print("")
+        print("Unrecognized type '%s', please add it to known types!" % t)
+        sys.exit(1)
+
+    seen_helpers = set()
+
+    def print_one(self, helper):
+        proto = helper.proto_break_down()
+
+        if proto['name'] in self.seen_helpers:
+            return
+        self.seen_helpers.add(proto['name'])
+
+        print('/*')
+        print(" * %s" % proto['name'])
+        print(" *")
+        if (helper.desc):
+            # Do not strip all newline characters: formatted code at the end of
+            # a section must be followed by a blank line.
+            for line in re.sub('\n$', '', helper.desc, count=1).split('\n'):
+                print(' *{}{}'.format(' \t' if line else '', line))
+
+        if (helper.ret):
+            print(' *')
+            print(' * Returns')
+            for line in helper.ret.rstrip().split('\n'):
+                print(' *{}{}'.format(' \t' if line else '', line))
+
+        print(' */')
+        print('static %s %s(*%s)(' % (self.map_type(proto['ret_type']),
+                                      proto['ret_star'], proto['name']), end='')
+        comma = ''
+        for i, a in enumerate(proto['args']):
+            t = a['type']
+            n = a['name']
+            if proto['name'] == 'bpf_get_socket_cookie' and i == 0:
+                    t = 'void'
+                    n = 'ctx'
+            one_arg = '{}{}'.format(comma, self.map_type(t))
+            if n:
+                if a['star']:
+                    one_arg += ' {}'.format(a['star'])
+                else:
+                    one_arg += ' '
+                one_arg += '{}'.format(n)
+            comma = ', '
+            print(one_arg, end='')
+
+        print(') = (void *) %d;' % len(self.seen_helpers))
+        print('')
+
 ###############################################################################
 
 # If script is launched from scripts/ from kernel tree and can access
@@ -405,6 +553,8 @@ Parse eBPF header file and generate documentation for eBPF helper functions.
 The RST-formatted output produced can be turned into a manual page with the
 rst2man utility.
 """)
+argParser.add_argument('--header', action='store_true',
+                       help='generate C header file')
 if (os.path.isfile(bpfh)):
     argParser.add_argument('--filename', help='path to include/uapi/linux/bpf.h',
                            default=bpfh)
@@ -417,5 +567,8 @@ headerParser = HeaderParser(args.filename)
 headerParser.run()
 
 # Print formatted output to standard output.
-printer = PrinterRST(headerParser.helpers)
+if args.header:
+    printer = PrinterHelpers(headerParser.helpers)
+else:
+    printer = PrinterRST(headerParser.helpers)
 printer.print_all()
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d8ee1b1ee7e3..893b9fde59ac 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4326,7 +4326,11 @@ static void alc269_fixup_hp_gpio_led(struct hda_codec *codec,
 static void alc285_fixup_hp_gpio_led(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
-	alc_fixup_hp_gpio_led(codec, action, 0x04, 0x00);
+	struct alc_spec *spec = codec->spec;
+
+	spec->micmute_led_polarity = 1;
+
+	alc_fixup_hp_gpio_led(codec, action, 0x04, 0x01);
 }
 
 static void alc286_fixup_hp_gpio_led(struct hda_codec *codec,
diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index cbe598b0fb10..680d64e0d69f 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -464,6 +464,11 @@ static const struct of_device_id sun4i_spdif_of_match[] = {
 		.compatible = "allwinner,sun50i-h6-spdif",
 		.data = &sun50i_h6_spdif_quirks,
 	},
+	{
+		.compatible = "allwinner,sun50i-h616-spdif",
+		/* Essentially the same as the H6, but without RX */
+		.data = &sun50i_h6_spdif_quirks,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_spdif_of_match);
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 43224c5ec1e9..1bd285dc55e9 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1091,6 +1091,19 @@ static void get_unpriv_disabled()
 
 static bool test_as_unpriv(struct bpf_test *test)
 {
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+	/* Some architectures have strict alignment requirements. In
+	 * that case, the BPF verifier detects if a program has
+	 * unaligned accesses and rejects them. A user can pass
+	 * BPF_F_ANY_ALIGNMENT to a program to override this
+	 * check. That, however, will only work when a privileged user
+	 * loads a program. An unprivileged user loading a program
+	 * with this flag will be rejected prior entering the
+	 * verifier.
+	 */
+	if (test->flags & F_NEEDS_EFFICIENT_UNALIGNED_ACCESS)
+		return false;
+#endif
 	return !test->prog_type ||
 	       test->prog_type == BPF_PROG_TYPE_SOCKET_FILTER ||
 	       test->prog_type == BPF_PROG_TYPE_CGROUP_SKB;
diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 0533881bd2ab..f4ce08c0d0be 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -459,6 +459,9 @@ static int its_sync_lpi_pending_table(struct kvm_vcpu *vcpu)
 		}
 
 		irq = vgic_get_irq(vcpu->kvm, NULL, intids[i]);
+		if (!irq)
+			continue;
+
 		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 		irq->pending_latch = pendmask & (1U << bit_nr);
 		vgic_queue_irq_unlock(vcpu->kvm, irq, flags);
@@ -1373,6 +1376,8 @@ static int vgic_its_cmd_handle_movall(struct kvm *kvm, struct vgic_its *its,
 
 	for (i = 0; i < irq_count; i++) {
 		irq = vgic_get_irq(kvm, NULL, intids[i]);
+		if (!irq)
+			continue;
 
 		update_affinity(irq, vcpu2);
 

