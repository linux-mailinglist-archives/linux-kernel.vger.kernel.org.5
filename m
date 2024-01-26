Return-Path: <linux-kernel+bounces-39432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B00D483D11F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959741F22F53
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B358517BCC;
	Thu, 25 Jan 2024 23:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RYbWbA42"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F62F1B7F8;
	Thu, 25 Jan 2024 23:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706227060; cv=none; b=JoXmyWUlnLhCLG0mM2ow6ZiAu/TaWWnWxqZz/+7MWCXMTomHvcKJQdjCCNtZ2m8QickGioPuOKfYTofHIRS3zWs53ObVnsdisGElAgY5XpPz+Mq1NRiXNHciAflEtSJ2lpByWXH+abJ3bx0ucJxwNFZwaj0E7PVxPsNpkEchZzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706227060; c=relaxed/simple;
	bh=3ljUmeWo/INlagKfSbobzCIoX1I1hYfBmw0SDsik2XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nONTrJbmesbw4n65bnB7d3Vz8+6g/NveCxnm/hhnWhNgvodfl8EcSHZs0rwv0n1ZnfB/71NP6bKnDlsLP6y6Quwt0yV/75SKfiELVxI195aloBN2YftDZWi5z+d5+bVDLcH58sSwlwY4jt51CiTAbXZ6c9i8ankK5tA1H0HVrqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RYbWbA42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60B9C433B1;
	Thu, 25 Jan 2024 23:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706227060;
	bh=3ljUmeWo/INlagKfSbobzCIoX1I1hYfBmw0SDsik2XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RYbWbA42p44v+BeHraYvh6toTJ20zpoFAJ+aMrJtmJieETM3/p9zTohpbAyGcg8dq
	 oUbAzWAsiuJ2hTi0En8/VDs0jXMggM48w82/iD/xgKXAEqa5oZQeHvx50EIZBawiCk
	 5/ttpPXF7cBjLvya35EQNbWhd/E01LtNTS8vthm8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.209
Date: Thu, 25 Jan 2024 15:57:30 -0800
Message-ID: <2024012530-mummify-overcook-abbc@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024012529-overkill-wool-a60f@gregkh>
References: <2024012529-overkill-wool-a60f@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index a4b42141ba1b..613b25d330b0 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 208
+SUBLEVEL = 209
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arc/kernel/signal.c b/arch/arc/kernel/signal.c
index 4868bdebf586..c43d323bcb59 100644
--- a/arch/arc/kernel/signal.c
+++ b/arch/arc/kernel/signal.c
@@ -61,7 +61,7 @@ struct rt_sigframe {
 	unsigned int sigret_magic;
 };
 
-static int save_arcv2_regs(struct sigcontext *mctx, struct pt_regs *regs)
+static int save_arcv2_regs(struct sigcontext __user *mctx, struct pt_regs *regs)
 {
 	int err = 0;
 #ifndef CONFIG_ISA_ARCOMPACT
@@ -74,12 +74,12 @@ static int save_arcv2_regs(struct sigcontext *mctx, struct pt_regs *regs)
 #else
 	v2abi.r58 = v2abi.r59 = 0;
 #endif
-	err = __copy_to_user(&mctx->v2abi, &v2abi, sizeof(v2abi));
+	err = __copy_to_user(&mctx->v2abi, (void const *)&v2abi, sizeof(v2abi));
 #endif
 	return err;
 }
 
-static int restore_arcv2_regs(struct sigcontext *mctx, struct pt_regs *regs)
+static int restore_arcv2_regs(struct sigcontext __user *mctx, struct pt_regs *regs)
 {
 	int err = 0;
 #ifndef CONFIG_ISA_ARCOMPACT
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index fb25ede1ce9f..3f1002c34446 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -760,7 +760,7 @@ pwrkey@1c {
 
 				xoadc: xoadc@197 {
 					compatible = "qcom,pm8921-adc";
-					reg = <197>;
+					reg = <0x197>;
 					interrupts-extended = <&pmicintc 78 IRQ_TYPE_EDGE_RISING>;
 					#address-cells = <2>;
 					#size-cells = <0>;
diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index de11030748d0..b30221f7dfa4 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -3,6 +3,7 @@
 menuconfig ARCH_DAVINCI
 	bool "TI DaVinci"
 	depends on ARCH_MULTI_V5
+	select CPU_ARM926T
 	select DAVINCI_TIMER
 	select ZONE_DMA
 	select PM_GENERIC_DOMAINS if PM
diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index b2f5f4f28705..f779e386b6e7 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -804,12 +804,12 @@ static int __init sunxi_mc_smp_init(void)
 	for (i = 0; i < ARRAY_SIZE(sunxi_mc_smp_data); i++) {
 		ret = of_property_match_string(node, "enable-method",
 					       sunxi_mc_smp_data[i].enable_method);
-		if (!ret)
+		if (ret >= 0)
 			break;
 	}
 
 	of_node_put(node);
-	if (ret)
+	if (ret < 0)
 		return -ENODEV;
 
 	is_a83t = sunxi_mc_smp_data[i].is_a83t;
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index eea8d23683dc..39e9b3875761 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -129,7 +129,7 @@ rtc@6f {
 		compatible = "microchip,mcp7940x";
 		reg = <0x6f>;
 		interrupt-parent = <&gpiosb>;
-		interrupts = <5 0>; /* GPIO2_5 */
+		interrupts = <5 IRQ_TYPE_EDGE_FALLING>; /* GPIO2_5 */
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 949fee6949e6..5516d2067c82 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -38,8 +38,8 @@ leds {
 		user4 {
 			label = "green:user4";
 			gpios = <&pm8150_gpios 10 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "panic-indicator";
 			default-state = "off";
+			panic-indicator;
 		};
 
 		wlan {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 1e889ca932e4..31f4f0575094 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -55,8 +55,8 @@ leds {
 		user4 {
 			label = "green:user4";
 			gpios = <&pm8998_gpio 13 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "panic-indicator";
 			default-state = "off";
+			panic-indicator;
 		};
 
 		wlan {
diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 4265f627ca16..a3538279d710 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -865,7 +865,7 @@ dss: dss@4a00000 {
 		assigned-clocks = <&k3_clks 67 2>;
 		assigned-clock-parents = <&k3_clks 67 5>;
 
-		interrupts = <GIC_SPI 166 IRQ_TYPE_EDGE_RISING>;
+		interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
 
 		status = "disabled";
 
diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 23710bf5a86b..62f261b8eb62 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -584,7 +584,11 @@ static struct vgic_irq *vgic_its_check_cache(struct kvm *kvm, phys_addr_t db,
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&dist->lpi_list_lock, flags);
+
 	irq = __vgic_its_check_cache(dist, db, devid, eventid);
+	if (irq)
+		vgic_get_irq_kref(irq);
+
 	raw_spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
 
 	return irq;
@@ -763,6 +767,7 @@ int vgic_its_inject_cached_translation(struct kvm *kvm, struct kvm_msi *msi)
 	raw_spin_lock_irqsave(&irq->irq_lock, flags);
 	irq->pending_latch = true;
 	vgic_queue_irq_unlock(kvm, irq, flags);
+	vgic_put_irq(kvm, irq);
 
 	return 0;
 }
diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 15a6c98ee92f..7a6360eba321 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -356,19 +356,26 @@ static int vgic_v3_uaccess_write_pending(struct kvm_vcpu *vcpu,
 		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
 
 		raw_spin_lock_irqsave(&irq->irq_lock, flags);
-		if (test_bit(i, &val)) {
-			/*
-			 * pending_latch is set irrespective of irq type
-			 * (level or edge) to avoid dependency that VM should
-			 * restore irq config before pending info.
-			 */
-			irq->pending_latch = true;
-			vgic_queue_irq_unlock(vcpu->kvm, irq, flags);
-		} else {
+
+		/*
+		 * pending_latch is set irrespective of irq type
+		 * (level or edge) to avoid dependency that VM should
+		 * restore irq config before pending info.
+		 */
+		irq->pending_latch = test_bit(i, &val);
+
+		if (irq->hw && vgic_irq_is_sgi(irq->intid)) {
+			irq_set_irqchip_state(irq->host_irq,
+					      IRQCHIP_STATE_PENDING,
+					      irq->pending_latch);
 			irq->pending_latch = false;
-			raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 		}
 
+		if (irq->pending_latch)
+			vgic_queue_irq_unlock(vcpu->kvm, irq, flags);
+		else
+			raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
+
 		vgic_put_irq(vcpu->kvm, irq);
 	}
 
diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index 414f92eacb5e..9ad26215b004 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -847,7 +847,7 @@ int __init db1200_dev_setup(void)
 	i2c_register_board_info(0, db1200_i2c_devs,
 				ARRAY_SIZE(db1200_i2c_devs));
 	spi_register_board_info(db1200_spi_devs,
-				ARRAY_SIZE(db1200_i2c_devs));
+				ARRAY_SIZE(db1200_spi_devs));
 
 	/* SWITCHES:	S6.8 I2C/SPI selector  (OFF=I2C	 ON=SPI)
 	 *		S6.7 AC97/I2S selector (OFF=AC97 ON=I2S)
diff --git a/arch/mips/alchemy/devboards/db1550.c b/arch/mips/alchemy/devboards/db1550.c
index 752b93d91ac9..06811a5db71d 100644
--- a/arch/mips/alchemy/devboards/db1550.c
+++ b/arch/mips/alchemy/devboards/db1550.c
@@ -588,7 +588,7 @@ int __init db1550_dev_setup(void)
 	i2c_register_board_info(0, db1550_i2c_devs,
 				ARRAY_SIZE(db1550_i2c_devs));
 	spi_register_board_info(db1550_spi_devs,
-				ARRAY_SIZE(db1550_i2c_devs));
+				ARRAY_SIZE(db1550_spi_devs));
 
 	c = clk_get(NULL, "psc0_intclk");
 	if (!IS_ERR(c)) {
diff --git a/arch/mips/include/asm/dmi.h b/arch/mips/include/asm/dmi.h
index 27415a288adf..dc397f630c66 100644
--- a/arch/mips/include/asm/dmi.h
+++ b/arch/mips/include/asm/dmi.h
@@ -5,7 +5,7 @@
 #include <linux/io.h>
 #include <linux/memblock.h>
 
-#define dmi_early_remap(x, l)		ioremap_cache(x, l)
+#define dmi_early_remap(x, l)		ioremap(x, l)
 #define dmi_early_unmap(x, l)		iounmap(x)
 #define dmi_remap(x, l)			ioremap_cache(x, l)
 #define dmi_unmap(x)			iounmap(x)
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index b7eb7dd96e17..66643cb65963 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -322,11 +322,11 @@ static void __init bootmem_init(void)
 		panic("Incorrect memory mapping !!!");
 
 	if (max_pfn > PFN_DOWN(HIGHMEM_START)) {
+		max_low_pfn = PFN_DOWN(HIGHMEM_START);
 #ifdef CONFIG_HIGHMEM
-		highstart_pfn = PFN_DOWN(HIGHMEM_START);
+		highstart_pfn = max_low_pfn;
 		highend_pfn = max_pfn;
 #else
-		max_low_pfn = PFN_DOWN(HIGHMEM_START);
 		max_pfn = max_low_pfn;
 #endif
 	}
diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index 324d7b298ec3..6e4af4492a14 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -38,14 +38,6 @@ extern char start_virt_trampolines[];
 extern char end_virt_trampolines[];
 #endif
 
-static inline int in_kernel_text(unsigned long addr)
-{
-	if (addr >= (unsigned long)_stext && addr < (unsigned long)__init_end)
-		return 1;
-
-	return 0;
-}
-
 static inline unsigned long kernel_toc_addr(void)
 {
 	/* Defined by the linker, see vmlinux.lds.S */
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 0697a0e014ae..321cab5c3ea0 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -38,7 +38,7 @@ obj-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
 # so it is only needed for modules, and only for older linkers which
 # do not support --save-restore-funcs
 ifeq ($(call ld-ifversion, -lt, 225000000, y),y)
-extra-$(CONFIG_PPC64)	+= crtsavres.o
+always-$(CONFIG_PPC64)	+= crtsavres.o
 endif
 
 obj-$(CONFIG_PPC_BOOK3S_64) += copyuser_power7.o copypage_power7.o \
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 3e15d0d054b2..5464c87511fa 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -292,6 +292,8 @@ static int update_events_in_group(struct device_node *node, struct imc_pmu *pmu)
 	attr_group->attrs = attrs;
 	do {
 		ev_val_str = kasprintf(GFP_KERNEL, "event=0x%x", pmu->events[i].value);
+		if (!ev_val_str)
+			continue;
 		dev_str = device_str_attr_create(pmu->events[i].name, ev_val_str);
 		if (!dev_str)
 			continue;
@@ -299,6 +301,8 @@ static int update_events_in_group(struct device_node *node, struct imc_pmu *pmu)
 		attrs[j++] = dev_str;
 		if (pmu->events[i].scale) {
 			ev_scale_str = kasprintf(GFP_KERNEL, "%s.scale", pmu->events[i].name);
+			if (!ev_scale_str)
+				continue;
 			dev_str = device_str_attr_create(ev_scale_str, pmu->events[i].scale);
 			if (!dev_str)
 				continue;
@@ -308,6 +312,8 @@ static int update_events_in_group(struct device_node *node, struct imc_pmu *pmu)
 
 		if (pmu->events[i].unit) {
 			ev_unit_str = kasprintf(GFP_KERNEL, "%s.unit", pmu->events[i].name);
+			if (!ev_unit_str)
+				continue;
 			dev_str = device_str_attr_create(ev_unit_str, pmu->events[i].unit);
 			if (!dev_str)
 				continue;
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 78ac6d67a935..9bc852c7e92f 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -177,6 +177,7 @@ config ISS4xx
 config CURRITUCK
 	bool "IBM Currituck (476fpe) Support"
 	depends on PPC_47x
+	select I2C
 	select SWIOTLB
 	select 476FPE
 	select FORCE_PCI
diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index c164419e254d..dcec0f760c8f 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -278,6 +278,8 @@ int __init opal_event_init(void)
 		else
 			name = kasprintf(GFP_KERNEL, "opal");
 
+		if (!name)
+			continue;
 		/* Install interrupt handler */
 		rc = request_irq(r->start, opal_interrupt, r->flags & IRQD_TRIGGER_MASK,
 				 name, NULL);
diff --git a/arch/powerpc/platforms/powernv/opal-powercap.c b/arch/powerpc/platforms/powernv/opal-powercap.c
index c16d44f6f1d1..ce9ec3962cef 100644
--- a/arch/powerpc/platforms/powernv/opal-powercap.c
+++ b/arch/powerpc/platforms/powernv/opal-powercap.c
@@ -196,6 +196,12 @@ void __init opal_powercap_init(void)
 
 		j = 0;
 		pcaps[i].pg.name = kasprintf(GFP_KERNEL, "%pOFn", node);
+		if (!pcaps[i].pg.name) {
+			kfree(pcaps[i].pattrs);
+			kfree(pcaps[i].pg.attrs);
+			goto out_pcaps_pattrs;
+		}
+
 		if (has_min) {
 			powercap_add_attr(min, "powercap-min",
 					  &pcaps[i].pattrs[j]);
diff --git a/arch/powerpc/platforms/powernv/opal-xscom.c b/arch/powerpc/platforms/powernv/opal-xscom.c
index fd510d961b8c..d5814c5046ba 100644
--- a/arch/powerpc/platforms/powernv/opal-xscom.c
+++ b/arch/powerpc/platforms/powernv/opal-xscom.c
@@ -165,6 +165,11 @@ static int scom_debug_init_one(struct dentry *root, struct device_node *dn,
 	ent->chip = chip;
 	snprintf(ent->name, 16, "%08x", chip);
 	ent->path.data = (void *)kasprintf(GFP_KERNEL, "%pOF", dn);
+	if (!ent->path.data) {
+		kfree(ent);
+		return -ENOMEM;
+	}
+
 	ent->path.size = strlen((char *)ent->path.data);
 
 	dir = debugfs_create_dir(ent->name, root);
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index a5f968b5fa3a..96dd82d63e98 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -481,7 +481,7 @@ static int dlpar_memory_remove_by_index(u32 drc_index)
 	int lmb_found;
 	int rc;
 
-	pr_info("Attempting to hot-remove LMB, drc index %x\n", drc_index);
+	pr_debug("Attempting to hot-remove LMB, drc index %x\n", drc_index);
 
 	lmb_found = 0;
 	for_each_drmem_lmb(lmb) {
@@ -495,14 +495,15 @@ static int dlpar_memory_remove_by_index(u32 drc_index)
 		}
 	}
 
-	if (!lmb_found)
+	if (!lmb_found) {
+		pr_debug("Failed to look up LMB for drc index %x\n", drc_index);
 		rc = -EINVAL;
-
-	if (rc)
-		pr_info("Failed to hot-remove memory at %llx\n",
-			lmb->base_addr);
-	else
-		pr_info("Memory at %llx was hot-removed\n", lmb->base_addr);
+	} else if (rc) {
+		pr_debug("Failed to hot-remove memory at %llx\n",
+			 lmb->base_addr);
+	} else {
+		pr_debug("Memory at %llx was hot-removed\n", lmb->base_addr);
+	}
 
 	return rc;
 }
@@ -719,8 +720,8 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add)
 			if (!drmem_lmb_reserved(lmb))
 				continue;
 
-			pr_info("Memory at %llx (drc index %x) was hot-added\n",
-				lmb->base_addr, lmb->drc_index);
+			pr_debug("Memory at %llx (drc index %x) was hot-added\n",
+				 lmb->base_addr, lmb->drc_index);
 			drmem_remove_lmb_reservation(lmb);
 		}
 		rc = 0;
diff --git a/arch/s390/include/asm/pci_io.h b/arch/s390/include/asm/pci_io.h
index 287bb88f7698..2686bee800e3 100644
--- a/arch/s390/include/asm/pci_io.h
+++ b/arch/s390/include/asm/pci_io.h
@@ -11,6 +11,8 @@
 /* I/O size constraints */
 #define ZPCI_MAX_READ_SIZE	8
 #define ZPCI_MAX_WRITE_SIZE	128
+#define ZPCI_BOUNDARY_SIZE	(1 << 12)
+#define ZPCI_BOUNDARY_MASK	(ZPCI_BOUNDARY_SIZE - 1)
 
 /* I/O Map */
 #define ZPCI_IOMAP_SHIFT		48
@@ -125,16 +127,18 @@ static inline int zpci_read_single(void *dst, const volatile void __iomem *src,
 int zpci_write_block(volatile void __iomem *dst, const void *src,
 		     unsigned long len);
 
-static inline u8 zpci_get_max_write_size(u64 src, u64 dst, int len, int max)
+static inline int zpci_get_max_io_size(u64 src, u64 dst, int len, int max)
 {
-	int count = len > max ? max : len, size = 1;
+	int offset = dst & ZPCI_BOUNDARY_MASK;
+	int size;
 
-	while (!(src & 0x1) && !(dst & 0x1) && ((size << 1) <= count)) {
-		dst = dst >> 1;
-		src = src >> 1;
-		size = size << 1;
-	}
-	return size;
+	size = min3(len, ZPCI_BOUNDARY_SIZE - offset, max);
+	if (IS_ALIGNED(src, 8) && IS_ALIGNED(dst, 8) && IS_ALIGNED(size, 8))
+		return size;
+
+	if (size >= 8)
+		return 8;
+	return rounddown_pow_of_two(size);
 }
 
 static inline int zpci_memcpy_fromio(void *dst,
@@ -144,9 +148,9 @@ static inline int zpci_memcpy_fromio(void *dst,
 	int size, rc = 0;
 
 	while (n > 0) {
-		size = zpci_get_max_write_size((u64 __force) src,
-					       (u64) dst, n,
-					       ZPCI_MAX_READ_SIZE);
+		size = zpci_get_max_io_size((u64 __force) src,
+					    (u64) dst, n,
+					    ZPCI_MAX_READ_SIZE);
 		rc = zpci_read_single(dst, src, size);
 		if (rc)
 			break;
@@ -166,9 +170,9 @@ static inline int zpci_memcpy_toio(volatile void __iomem *dst,
 		return -EINVAL;
 
 	while (n > 0) {
-		size = zpci_get_max_write_size((u64 __force) dst,
-					       (u64) src, n,
-					       ZPCI_MAX_WRITE_SIZE);
+		size = zpci_get_max_io_size((u64 __force) dst,
+					    (u64) src, n,
+					    ZPCI_MAX_WRITE_SIZE);
 		if (size > 8) /* main path */
 			rc = zpci_write_block(dst, src, size);
 		else
diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
index 1ec8076209ca..6e7c4762bd23 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -100,9 +100,9 @@ static inline int __memcpy_toio_inuser(void __iomem *dst,
 
 	old_fs = enable_sacf_uaccess();
 	while (n > 0) {
-		size = zpci_get_max_write_size((u64 __force) dst,
-					       (u64 __force) src, n,
-					       ZPCI_MAX_WRITE_SIZE);
+		size = zpci_get_max_io_size((u64 __force) dst,
+					    (u64 __force) src, n,
+					    ZPCI_MAX_WRITE_SIZE);
 		if (size > 8) /* main path */
 			rc = __pcistb_mio_inuser(dst, src, size, &status);
 		else
@@ -252,9 +252,9 @@ static inline int __memcpy_fromio_inuser(void __user *dst,
 
 	old_fs = enable_sacf_uaccess();
 	while (n > 0) {
-		size = zpci_get_max_write_size((u64 __force) src,
-					       (u64 __force) dst, n,
-					       ZPCI_MAX_READ_SIZE);
+		size = zpci_get_max_io_size((u64 __force) src,
+					    (u64 __force) dst, n,
+					    ZPCI_MAX_READ_SIZE);
 		rc = __pcilg_mio_inuser(dst, src, size, &status);
 		if (rc)
 			break;
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index bb657e2e6c68..b79b4ee49fbd 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -24,8 +24,8 @@
 
 static int kvmclock __initdata = 1;
 static int kvmclock_vsyscall __initdata = 1;
-static int msr_kvm_system_time __ro_after_init = MSR_KVM_SYSTEM_TIME;
-static int msr_kvm_wall_clock __ro_after_init = MSR_KVM_WALL_CLOCK;
+static int msr_kvm_system_time __ro_after_init;
+static int msr_kvm_wall_clock __ro_after_init;
 static u64 kvm_sched_clock_offset __ro_after_init;
 
 static int __init parse_no_kvmclock(char *arg)
@@ -196,7 +196,8 @@ static void kvm_setup_secondary_clock(void)
 
 void kvmclock_disable(void)
 {
-	native_write_msr(msr_kvm_system_time, 0, 0);
+	if (msr_kvm_system_time)
+		native_write_msr(msr_kvm_system_time, 0, 0);
 }
 
 static void __init kvmclock_init_mem(void)
@@ -292,7 +293,10 @@ void __init kvmclock_init(void)
 	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2)) {
 		msr_kvm_system_time = MSR_KVM_SYSTEM_TIME_NEW;
 		msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK_NEW;
-	} else if (!kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)) {
+	} else if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)) {
+		msr_kvm_system_time = MSR_KVM_SYSTEM_TIME;
+		msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK;
+	} else {
 		return;
 	}
 
diff --git a/arch/x86/lib/misc.c b/arch/x86/lib/misc.c
index a018ec4fba53..c97be9a1430a 100644
--- a/arch/x86/lib/misc.c
+++ b/arch/x86/lib/misc.c
@@ -6,7 +6,7 @@
  */
 int num_digits(int val)
 {
-	int m = 10;
+	long long m = 10;
 	int d = 1;
 
 	if (val < 0) {
diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 9acb9d2c4bcf..755e6caf18d2 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1039,9 +1039,13 @@ EXPORT_SYMBOL_GPL(af_alg_sendpage);
 void af_alg_free_resources(struct af_alg_async_req *areq)
 {
 	struct sock *sk = areq->sk;
+	struct af_alg_ctx *ctx;
 
 	af_alg_free_areq_sgls(areq);
 	sock_kfree_s(sk, areq, areq->areqlen);
+
+	ctx = alg_sk(sk)->private;
+	ctx->inflight = false;
 }
 EXPORT_SYMBOL_GPL(af_alg_free_resources);
 
@@ -1105,11 +1109,19 @@ EXPORT_SYMBOL_GPL(af_alg_poll);
 struct af_alg_async_req *af_alg_alloc_areq(struct sock *sk,
 					   unsigned int areqlen)
 {
-	struct af_alg_async_req *areq = sock_kmalloc(sk, areqlen, GFP_KERNEL);
+	struct af_alg_ctx *ctx = alg_sk(sk)->private;
+	struct af_alg_async_req *areq;
+
+	/* Only one AIO request can be in flight. */
+	if (ctx->inflight)
+		return ERR_PTR(-EBUSY);
 
+	areq = sock_kmalloc(sk, areqlen, GFP_KERNEL);
 	if (unlikely(!areq))
 		return ERR_PTR(-ENOMEM);
 
+	ctx->inflight = true;
+
 	areq->areqlen = areqlen;
 	areq->sk = sk;
 	areq->last_rsgl = NULL;
diff --git a/crypto/scompress.c b/crypto/scompress.c
index 738f4f8f0f41..4d6366a44400 100644
--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -124,6 +124,7 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 	struct crypto_scomp *scomp = *tfm_ctx;
 	void **ctx = acomp_request_ctx(req);
 	struct scomp_scratch *scratch;
+	unsigned int dlen;
 	int ret;
 
 	if (!req->src || !req->slen || req->slen > SCOMP_SCRATCH_SIZE)
@@ -135,6 +136,8 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 	if (!req->dlen || req->dlen > SCOMP_SCRATCH_SIZE)
 		req->dlen = SCOMP_SCRATCH_SIZE;
 
+	dlen = req->dlen;
+
 	scratch = raw_cpu_ptr(&scomp_scratch);
 	spin_lock(&scratch->lock);
 
@@ -152,6 +155,9 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 				ret = -ENOMEM;
 				goto out;
 			}
+		} else if (req->dlen > dlen) {
+			ret = -ENOSPC;
+			goto out;
 		}
 		scatterwalk_map_and_copy(scratch->dst, req->dst, 0, req->dlen,
 					 1);
diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index e648158368a7..088db2356998 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -145,9 +145,14 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 	static u32 err_seq;
 
 	estatus = extlog_elog_entry_check(cpu, bank);
-	if (estatus == NULL || (mce->kflags & MCE_HANDLED_CEC))
+	if (!estatus)
 		return NOTIFY_DONE;
 
+	if (mce->kflags & MCE_HANDLED_CEC) {
+		estatus->block_status = 0;
+		return NOTIFY_DONE;
+	}
+
 	memcpy(elog_buf, (void *)estatus, ELOG_ENTRY_LEN);
 	/* clear record status to enable BIOS to update it again */
 	estatus->block_status = 0;
diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
index 48e5059d67ca..7de59730030c 100644
--- a/drivers/acpi/acpi_lpit.c
+++ b/drivers/acpi/acpi_lpit.c
@@ -98,7 +98,7 @@ static void lpit_update_residency(struct lpit_residency_info *info,
 				 struct acpi_lpit_native *lpit_native)
 {
 	info->frequency = lpit_native->counter_frequency ?
-				lpit_native->counter_frequency : tsc_khz * 1000;
+				lpit_native->counter_frequency : mul_u32_u32(tsc_khz, 1000U);
 	if (!info->frequency)
 		info->frequency = 1;
 
diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index cf6c9ffe04a2..9d384656323a 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1788,12 +1788,12 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
 		return;
 	count++;
 
-	acpi_get_parent(device->dev->handle, &acpi_parent);
-
-	pdev = acpi_get_pci_dev(acpi_parent);
-	if (pdev) {
-		parent = &pdev->dev;
-		pci_dev_put(pdev);
+	if (ACPI_SUCCESS(acpi_get_parent(device->dev->handle, &acpi_parent))) {
+		pdev = acpi_get_pci_dev(acpi_parent);
+		if (pdev) {
+			parent = &pdev->dev;
+			pci_dev_put(pdev);
+		}
 	}
 
 	memset(&props, 0, sizeof(struct backlight_properties));
diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 80e92c298055..cf872dc5b07a 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -639,6 +639,7 @@ acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
  * @index: Index of the reference to return
  * @num_args: Maximum number of arguments after each reference
  * @args: Location to store the returned reference with optional arguments
+ *	  (may be NULL)
  *
  * Find property with @name, verifify that it is a package containing at least
  * one object reference and if so, store the ACPI device object pointer to the
@@ -697,6 +698,9 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 		if (ret)
 			return ret == -ENODEV ? -EINVAL : ret;
 
+		if (!args)
+			return 0;
+
 		args->fwnode = acpi_fwnode_handle(device);
 		args->nargs = 0;
 		return 0;
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 508d22728ce8..42b1b06efda6 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -455,6 +455,13 @@ static const struct dmi_system_id asus_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B1402CVA"),
 		},
 	},
+	{
+		/* TongFang GMxXGxx sold as Eluktronics Inc. RP-15 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Eluktronics Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "RP-15"),
+		},
+	},
 	{
 		/* TongFang GM6XGxX/TUXEDO Stellaris 16 Gen5 AMD */
 		.matches = {
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 2aaccb78235b..7db748cfcbc6 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5173,7 +5173,7 @@ static __poll_t binder_poll(struct file *filp,
 
 	thread = binder_get_thread(proc);
 	if (!thread)
-		return POLLERR;
+		return EPOLLERR;
 
 	binder_inner_proc_lock(thread->proc);
 	thread->looper |= BINDER_LOOPER_STATE_POLL;
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index b6bf9caaf1d1..b655bc3956c7 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -271,7 +271,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 	}
 	if (mm) {
 		mmap_write_unlock(mm);
-		mmput(mm);
+		mmput_async(mm);
 	}
 	return 0;
 
@@ -304,7 +304,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 err_no_vma:
 	if (mm) {
 		mmap_write_unlock(mm);
-		mmput(mm);
+		mmput_async(mm);
 	}
 	return vma ? -ENOMEM : -ESRCH;
 }
@@ -359,8 +359,7 @@ static void debug_low_async_space_locked(struct binder_alloc *alloc, int pid)
 			continue;
 		if (!buffer->async_transaction)
 			continue;
-		total_alloc_size += binder_alloc_buffer_size(alloc, buffer)
-			+ sizeof(struct binder_buffer);
+		total_alloc_size += binder_alloc_buffer_size(alloc, buffer);
 		num_buffers++;
 	}
 
@@ -415,17 +414,17 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 				alloc->pid, extra_buffers_size);
 		return ERR_PTR(-EINVAL);
 	}
-	if (is_async &&
-	    alloc->free_async_space < size + sizeof(struct binder_buffer)) {
+
+	/* Pad 0-size buffers so they get assigned unique addresses */
+	size = max(size, sizeof(void *));
+
+	if (is_async && alloc->free_async_space < size) {
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 			     "%d: binder_alloc_buf size %zd failed, no async space left\n",
 			      alloc->pid, size);
 		return ERR_PTR(-ENOSPC);
 	}
 
-	/* Pad 0-size buffers so they get assigned unique addresses */
-	size = max(size, sizeof(void *));
-
 	while (n) {
 		buffer = rb_entry(n, struct binder_buffer, rb_node);
 		BUG_ON(!buffer->free);
@@ -526,7 +525,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	buffer->extra_buffers_size = extra_buffers_size;
 	buffer->pid = pid;
 	if (is_async) {
-		alloc->free_async_space -= size + sizeof(struct binder_buffer);
+		alloc->free_async_space -= size;
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC_ASYNC,
 			     "%d: binder_alloc_buf size %zd async free %zd\n",
 			      alloc->pid, size, alloc->free_async_space);
@@ -562,7 +561,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
  * is the sum of the three given sizes (each rounded up to
  * pointer-sized boundary)
  *
- * Return:	The allocated buffer or %NULL if error
+ * Return:	The allocated buffer or %ERR_PTR(-errno) if error
  */
 struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 					   size_t data_size,
@@ -662,8 +661,7 @@ static void binder_free_buf_locked(struct binder_alloc *alloc,
 	BUG_ON(buffer->user_data > alloc->buffer + alloc->buffer_size);
 
 	if (buffer->async_transaction) {
-		alloc->free_async_space += buffer_size + sizeof(struct binder_buffer);
-
+		alloc->free_async_space += buffer_size;
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC_ASYNC,
 			     "%d: binder_free_buf size %zd async free %zd\n",
 			      alloc->pid, size, alloc->free_async_space);
@@ -711,7 +709,7 @@ void binder_alloc_free_buf(struct binder_alloc *alloc,
 	/*
 	 * We could eliminate the call to binder_alloc_clear_buf()
 	 * from binder_alloc_deferred_release() by moving this to
-	 * binder_alloc_free_buf_locked(). However, that could
+	 * binder_free_buf_locked(). However, that could
 	 * increase contention for the alloc mutex if clear_on_free
 	 * is used frequently for large buffers. The mutex is not
 	 * needed for correctness here.
@@ -1002,7 +1000,9 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 		goto err_mmget;
 	if (!mmap_read_trylock(mm))
 		goto err_mmap_read_lock_failed;
-	vma = binder_alloc_get_vma(alloc);
+	vma = find_vma(mm, page_addr);
+	if (vma && vma != binder_alloc_get_vma(alloc))
+		goto err_invalid_vma;
 
 	list_lru_isolate(lru, item);
 	spin_unlock(lock);
@@ -1028,6 +1028,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	mutex_unlock(&alloc->mutex);
 	return LRU_REMOVED_RETRY;
 
+err_invalid_vma:
+	mmap_read_unlock(mm);
 err_mmap_read_lock_failed:
 	mmput_async(mm);
 err_mmget:
diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index d2fb3eb5816c..b664c36388e2 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -531,6 +531,9 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	if (nargs > NR_FWNODE_REFERENCE_ARGS)
 		return -EINVAL;
 
+	if (!args)
+		return 0;
+
 	args->fwnode = software_node_get(refnode);
 	args->nargs = nargs;
 
diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index 719d4685a2dd..1a908827b1f2 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -471,7 +471,7 @@ mtk_stp_split(struct btmtkuart_dev *bdev, const unsigned char *data, int count,
 	return data;
 }
 
-static int btmtkuart_recv(struct hci_dev *hdev, const u8 *data, size_t count)
+static void btmtkuart_recv(struct hci_dev *hdev, const u8 *data, size_t count)
 {
 	struct btmtkuart_dev *bdev = hci_get_drvdata(hdev);
 	const unsigned char *p_left = data, *p_h4;
@@ -510,25 +510,20 @@ static int btmtkuart_recv(struct hci_dev *hdev, const u8 *data, size_t count)
 			bt_dev_err(bdev->hdev,
 				   "Frame reassembly failed (%d)", err);
 			bdev->rx_skb = NULL;
-			return err;
+			return;
 		}
 
 		sz_left -= sz_h4;
 		p_left += sz_h4;
 	}
-
-	return 0;
 }
 
 static int btmtkuart_receive_buf(struct serdev_device *serdev, const u8 *data,
 				 size_t count)
 {
 	struct btmtkuart_dev *bdev = serdev_device_get_drvdata(serdev);
-	int err;
 
-	err = btmtkuart_recv(bdev->hdev, data, count);
-	if (err < 0)
-		return err;
+	btmtkuart_recv(bdev->hdev, data, count);
 
 	bdev->hdev->stat.byte_rx += count;
 
diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index 45501637705c..62e994d18fe2 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -49,12 +49,24 @@ const struct clk_ops clk_fixed_rate_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_fixed_rate_ops);
 
+static void devm_clk_hw_register_fixed_rate_release(struct device *dev, void *res)
+{
+	struct clk_fixed_rate *fix = res;
+
+	/*
+	 * We can not use clk_hw_unregister_fixed_rate, since it will kfree()
+	 * the hw, resulting in double free. Just unregister the hw and let
+	 * devres code kfree() it.
+	 */
+	clk_hw_unregister(&fix->hw);
+}
+
 struct clk_hw *__clk_hw_register_fixed_rate(struct device *dev,
 		struct device_node *np, const char *name,
 		const char *parent_name, const struct clk_hw *parent_hw,
 		const struct clk_parent_data *parent_data, unsigned long flags,
 		unsigned long fixed_rate, unsigned long fixed_accuracy,
-		unsigned long clk_fixed_flags)
+		unsigned long clk_fixed_flags, bool devm)
 {
 	struct clk_fixed_rate *fixed;
 	struct clk_hw *hw;
@@ -62,7 +74,11 @@ struct clk_hw *__clk_hw_register_fixed_rate(struct device *dev,
 	int ret = -EINVAL;
 
 	/* allocate fixed-rate clock */
-	fixed = kzalloc(sizeof(*fixed), GFP_KERNEL);
+	if (devm)
+		fixed = devres_alloc(devm_clk_hw_register_fixed_rate_release,
+				     sizeof(*fixed), GFP_KERNEL);
+	else
+		fixed = kzalloc(sizeof(*fixed), GFP_KERNEL);
 	if (!fixed)
 		return ERR_PTR(-ENOMEM);
 
@@ -90,9 +106,13 @@ struct clk_hw *__clk_hw_register_fixed_rate(struct device *dev,
 	else if (np)
 		ret = of_clk_hw_register(np, hw);
 	if (ret) {
-		kfree(fixed);
+		if (devm)
+			devres_free(fixed);
+		else
+			kfree(fixed);
 		hw = ERR_PTR(ret);
-	}
+	} else if (devm)
+		devres_add(dev, fixed);
 
 	return hw;
 }
diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
index 4dea29fa901d..d6515661580c 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -888,10 +888,8 @@ static int si5341_output_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	r[0] = r_div ? (r_div & 0xff) : 1;
 	r[1] = (r_div >> 8) & 0xff;
 	r[2] = (r_div >> 16) & 0xff;
-	err = regmap_bulk_write(output->data->regmap,
+	return regmap_bulk_write(output->data->regmap,
 			SI5341_OUT_R_REG(output), r, 3);
-
-	return 0;
 }
 
 static int si5341_output_reparent(struct clk_si5341_output *output, u8 index)
diff --git a/drivers/clk/qcom/gpucc-sm8150.c b/drivers/clk/qcom/gpucc-sm8150.c
index 27c40754b2c7..3d9b296a6e4a 100644
--- a/drivers/clk/qcom/gpucc-sm8150.c
+++ b/drivers/clk/qcom/gpucc-sm8150.c
@@ -38,8 +38,8 @@ static struct alpha_pll_config gpu_cc_pll1_config = {
 	.config_ctl_hi_val = 0x00002267,
 	.config_ctl_hi1_val = 0x00000024,
 	.test_ctl_val = 0x00000000,
-	.test_ctl_hi_val = 0x00000002,
-	.test_ctl_hi1_val = 0x00000000,
+	.test_ctl_hi_val = 0x00000000,
+	.test_ctl_hi1_val = 0x00000020,
 	.user_ctl_val = 0x00000000,
 	.user_ctl_hi_val = 0x00000805,
 	.user_ctl_hi1_val = 0x000000d0,
diff --git a/drivers/clk/qcom/videocc-sm8150.c b/drivers/clk/qcom/videocc-sm8150.c
index 3087e2ec8fd4..61089cde4222 100644
--- a/drivers/clk/qcom/videocc-sm8150.c
+++ b/drivers/clk/qcom/videocc-sm8150.c
@@ -37,6 +37,7 @@ static struct alpha_pll_config video_pll0_config = {
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00002267,
 	.config_ctl_hi1_val = 0x00000024,
+	.test_ctl_hi1_val = 0x00000020,
 	.user_ctl_val = 0x00000000,
 	.user_ctl_hi_val = 0x00000805,
 	.user_ctl_hi1_val = 0x000000D0,
@@ -218,6 +219,10 @@ static const struct regmap_config video_cc_sm8150_regmap_config = {
 
 static const struct qcom_reset_map video_cc_sm8150_resets[] = {
 	[VIDEO_CC_MVSC_CORE_CLK_BCR] = { 0x850, 2 },
+	[VIDEO_CC_INTERFACE_BCR] = { 0x8f0 },
+	[VIDEO_CC_MVS0_BCR] = { 0x870 },
+	[VIDEO_CC_MVS1_BCR] = { 0x8b0 },
+	[VIDEO_CC_MVSC_BCR] = { 0x810 },
 };
 
 static const struct qcom_cc_desc video_cc_sm8150_desc = {
diff --git a/drivers/clk/rockchip/clk-rk3128.c b/drivers/clk/rockchip/clk-rk3128.c
index 4b1122e98e16..ddfe1c402e80 100644
--- a/drivers/clk/rockchip/clk-rk3128.c
+++ b/drivers/clk/rockchip/clk-rk3128.c
@@ -489,7 +489,7 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 	GATE(HCLK_I2S_2CH, "hclk_i2s_2ch", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 2, GFLAGS),
 	GATE(0, "hclk_usb_peri", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(9), 13, GFLAGS),
 	GATE(HCLK_HOST2, "hclk_host2", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 3, GFLAGS),
-	GATE(HCLK_OTG, "hclk_otg", "hclk_peri", 0, RK2928_CLKGATE_CON(3), 13, GFLAGS),
+	GATE(HCLK_OTG, "hclk_otg", "hclk_peri", 0, RK2928_CLKGATE_CON(5), 13, GFLAGS),
 	GATE(0, "hclk_peri_ahb", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(9), 14, GFLAGS),
 	GATE(HCLK_SPDIF, "hclk_spdif", "hclk_peri", 0, RK2928_CLKGATE_CON(10), 9, GFLAGS),
 	GATE(HCLK_TSP, "hclk_tsp", "hclk_peri", 0, RK2928_CLKGATE_CON(10), 12, GFLAGS),
diff --git a/drivers/clk/zynqmp/clk-mux-zynqmp.c b/drivers/clk/zynqmp/clk-mux-zynqmp.c
index 06194149be83..46ff5cb733ee 100644
--- a/drivers/clk/zynqmp/clk-mux-zynqmp.c
+++ b/drivers/clk/zynqmp/clk-mux-zynqmp.c
@@ -83,7 +83,7 @@ static int zynqmp_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 static const struct clk_ops zynqmp_clk_mux_ops = {
 	.get_parent = zynqmp_clk_mux_get_parent,
 	.set_parent = zynqmp_clk_mux_set_parent,
-	.determine_rate = __clk_mux_determine_rate,
+	.determine_rate = __clk_mux_determine_rate_closest,
 };
 
 static const struct clk_ops zynqmp_clk_mux_ro_ops = {
diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 66da02b83d39..acfd4878cce2 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -109,49 +109,6 @@ static unsigned long zynqmp_clk_divider_recalc_rate(struct clk_hw *hw,
 	return DIV_ROUND_UP_ULL(parent_rate, value);
 }
 
-static void zynqmp_get_divider2_val(struct clk_hw *hw,
-				    unsigned long rate,
-				    struct zynqmp_clk_divider *divider,
-				    int *bestdiv)
-{
-	int div1;
-	int div2;
-	long error = LONG_MAX;
-	unsigned long div1_prate;
-	struct clk_hw *div1_parent_hw;
-	struct clk_hw *div2_parent_hw = clk_hw_get_parent(hw);
-	struct zynqmp_clk_divider *pdivider =
-				to_zynqmp_clk_divider(div2_parent_hw);
-
-	if (!pdivider)
-		return;
-
-	div1_parent_hw = clk_hw_get_parent(div2_parent_hw);
-	if (!div1_parent_hw)
-		return;
-
-	div1_prate = clk_hw_get_rate(div1_parent_hw);
-	*bestdiv = 1;
-	for (div1 = 1; div1 <= pdivider->max_div;) {
-		for (div2 = 1; div2 <= divider->max_div;) {
-			long new_error = ((div1_prate / div1) / div2) - rate;
-
-			if (abs(new_error) < abs(error)) {
-				*bestdiv = div2;
-				error = new_error;
-			}
-			if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
-				div2 = div2 << 1;
-			else
-				div2++;
-		}
-		if (pdivider->flags & CLK_DIVIDER_POWER_OF_TWO)
-			div1 = div1 << 1;
-		else
-			div1++;
-	}
-}
-
 /**
  * zynqmp_clk_divider_round_rate() - Round rate of divider clock
  * @hw:			handle between common and hardware-specific interfaces
@@ -170,6 +127,7 @@ static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
 	u32 div_type = divider->div_type;
 	u32 bestdiv;
 	int ret;
+	u8 width;
 
 	/* if read only, just return current value */
 	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
@@ -189,23 +147,12 @@ static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
 		return DIV_ROUND_UP_ULL((u64)*prate, bestdiv);
 	}
 
-	bestdiv = zynqmp_divider_get_val(*prate, rate, divider->flags);
-
-	/*
-	 * In case of two divisors, compute best divider values and return
-	 * divider2 value based on compute value. div1 will  be automatically
-	 * set to optimum based on required total divider value.
-	 */
-	if (div_type == TYPE_DIV2 &&
-	    (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
-		zynqmp_get_divider2_val(hw, rate, divider, &bestdiv);
-	}
+	width = fls(divider->max_div);
 
-	if ((clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) && divider->is_frac)
-		bestdiv = rate % *prate ? 1 : bestdiv;
+	rate = divider_round_rate(hw, rate, prate, NULL, width, divider->flags);
 
-	bestdiv = min_t(u32, bestdiv, divider->max_div);
-	*prate = rate * bestdiv;
+	if (divider->is_frac && (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) && (rate % *prate))
+		*prate = rate;
 
 	return rate;
 }
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index aea285651fba..e1dcdb0ea1c4 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -163,7 +163,7 @@ static bool __init cpu0_node_has_opp_v2_prop(void)
 	struct device_node *np = of_cpu_device_node_get(0);
 	bool ret = false;
 
-	if (of_get_property(np, "operating-points-v2", NULL))
+	if (of_property_present(np, "operating-points-v2"))
 		ret = true;
 
 	of_node_put(np);
diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
index 3fe9125156b4..0942498b348c 100644
--- a/drivers/cpufreq/imx-cpufreq-dt.c
+++ b/drivers/cpufreq/imx-cpufreq-dt.c
@@ -89,7 +89,7 @@ static int imx_cpufreq_dt_probe(struct platform_device *pdev)
 
 	cpu_dev = get_cpu_device(0);
 
-	if (!of_find_property(cpu_dev->of_node, "cpu-supply", NULL))
+	if (!of_property_present(cpu_dev->of_node, "cpu-supply"))
 		return -ENODEV;
 
 	if (of_machine_is_compatible("fsl,imx7ulp")) {
diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 00f7ad746668..49cbc43f1fa9 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -230,7 +230,7 @@ static int imx6q_opp_check_speed_grading(struct device *dev)
 	u32 val;
 	int ret;
 
-	if (of_find_property(dev->of_node, "nvmem-cells", NULL)) {
+	if (of_property_present(dev->of_node, "nvmem-cells")) {
 		ret = nvmem_cell_read_u32(dev, "speed_grade", &val);
 		if (ret)
 			return ret;
@@ -285,7 +285,7 @@ static int imx6ul_opp_check_speed_grading(struct device *dev)
 	u32 val;
 	int ret = 0;
 
-	if (of_find_property(dev->of_node, "nvmem-cells", NULL)) {
+	if (of_property_present(dev->of_node, "nvmem-cells")) {
 		ret = nvmem_cell_read_u32(dev, "speed_grade", &val);
 		if (ret)
 			return ret;
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 8286205c7165..bb1389f276d7 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -238,8 +238,11 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
 
 #ifdef CONFIG_COMMON_CLK
 	/* dummy clock provider as needed by OPP if clocks property is used */
-	if (of_find_property(dev->of_node, "#clock-cells", NULL))
-		devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, NULL);
+	if (of_property_present(dev->of_node, "#clock-cells")) {
+		ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, NULL);
+		if (ret)
+			return dev_err_probe(dev, ret, "%s: registering clock provider failed\n", __func__);
+	}
 #endif
 
 	ret = cpufreq_register_driver(&scmi_cpufreq_driver);
diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index 8c893043953e..111d4ff6fe86 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -25,7 +25,7 @@ static bool cpu0_node_has_opp_v2_prop(void)
 	struct device_node *np = of_cpu_device_node_get(0);
 	bool ret = false;
 
-	if (of_get_property(np, "operating-points-v2", NULL))
+	if (of_property_present(np, "operating-points-v2"))
 		ret = true;
 
 	of_node_put(np);
diff --git a/drivers/crypto/ccp/ccp-ops.c b/drivers/crypto/ccp/ccp-ops.c
index c15625e8ff66..7e2fbba945cd 100644
--- a/drivers/crypto/ccp/ccp-ops.c
+++ b/drivers/crypto/ccp/ccp-ops.c
@@ -179,8 +179,11 @@ static int ccp_init_dm_workarea(struct ccp_dm_workarea *wa,
 
 		wa->dma.address = dma_map_single(wa->dev, wa->address, len,
 						 dir);
-		if (dma_mapping_error(wa->dev, wa->dma.address))
+		if (dma_mapping_error(wa->dev, wa->dma.address)) {
+			kfree(wa->address);
+			wa->address = NULL;
 			return -ENOMEM;
+		}
 
 		wa->dma.length = len;
 	}
diff --git a/drivers/crypto/sa2ul.c b/drivers/crypto/sa2ul.c
index f15fc1fb3707..0888f4489a76 100644
--- a/drivers/crypto/sa2ul.c
+++ b/drivers/crypto/sa2ul.c
@@ -1848,9 +1848,8 @@ static int sa_aead_setkey(struct crypto_aead *authenc,
 	crypto_aead_set_flags(ctx->fallback.aead,
 			      crypto_aead_get_flags(authenc) &
 			      CRYPTO_TFM_REQ_MASK);
-	crypto_aead_setkey(ctx->fallback.aead, key, keylen);
 
-	return 0;
+	return crypto_aead_setkey(ctx->fallback.aead, key, keylen);
 }
 
 static int sa_aead_setauthsize(struct crypto_aead *tfm, unsigned int authsize)
diff --git a/drivers/crypto/sahara.c b/drivers/crypto/sahara.c
index 2043dd061121..c2a3a10c3484 100644
--- a/drivers/crypto/sahara.c
+++ b/drivers/crypto/sahara.c
@@ -43,7 +43,6 @@
 #define FLAGS_MODE_MASK		0x000f
 #define FLAGS_ENCRYPT		BIT(0)
 #define FLAGS_CBC		BIT(1)
-#define FLAGS_NEW_KEY		BIT(3)
 
 #define SAHARA_HDR_BASE			0x00800000
 #define SAHARA_HDR_SKHA_ALG_AES	0
@@ -141,8 +140,6 @@ struct sahara_hw_link {
 };
 
 struct sahara_ctx {
-	unsigned long flags;
-
 	/* AES-specific context */
 	int keylen;
 	u8 key[AES_KEYSIZE_128];
@@ -151,6 +148,7 @@ struct sahara_ctx {
 
 struct sahara_aes_reqctx {
 	unsigned long mode;
+	u8 iv_out[AES_BLOCK_SIZE];
 	struct skcipher_request fallback_req;	// keep at the end
 };
 
@@ -446,27 +444,24 @@ static int sahara_hw_descriptor_create(struct sahara_dev *dev)
 	int ret;
 	int i, j;
 	int idx = 0;
+	u32 len;
 
-	/* Copy new key if necessary */
-	if (ctx->flags & FLAGS_NEW_KEY) {
-		memcpy(dev->key_base, ctx->key, ctx->keylen);
-		ctx->flags &= ~FLAGS_NEW_KEY;
+	memcpy(dev->key_base, ctx->key, ctx->keylen);
 
-		if (dev->flags & FLAGS_CBC) {
-			dev->hw_desc[idx]->len1 = AES_BLOCK_SIZE;
-			dev->hw_desc[idx]->p1 = dev->iv_phys_base;
-		} else {
-			dev->hw_desc[idx]->len1 = 0;
-			dev->hw_desc[idx]->p1 = 0;
-		}
-		dev->hw_desc[idx]->len2 = ctx->keylen;
-		dev->hw_desc[idx]->p2 = dev->key_phys_base;
-		dev->hw_desc[idx]->next = dev->hw_phys_desc[1];
+	if (dev->flags & FLAGS_CBC) {
+		dev->hw_desc[idx]->len1 = AES_BLOCK_SIZE;
+		dev->hw_desc[idx]->p1 = dev->iv_phys_base;
+	} else {
+		dev->hw_desc[idx]->len1 = 0;
+		dev->hw_desc[idx]->p1 = 0;
+	}
+	dev->hw_desc[idx]->len2 = ctx->keylen;
+	dev->hw_desc[idx]->p2 = dev->key_phys_base;
+	dev->hw_desc[idx]->next = dev->hw_phys_desc[1];
+	dev->hw_desc[idx]->hdr = sahara_aes_key_hdr(dev);
 
-		dev->hw_desc[idx]->hdr = sahara_aes_key_hdr(dev);
+	idx++;
 
-		idx++;
-	}
 
 	dev->nb_in_sg = sg_nents_for_len(dev->in_sg, dev->total);
 	if (dev->nb_in_sg < 0) {
@@ -488,24 +483,27 @@ static int sahara_hw_descriptor_create(struct sahara_dev *dev)
 			 DMA_TO_DEVICE);
 	if (ret != dev->nb_in_sg) {
 		dev_err(dev->device, "couldn't map in sg\n");
-		goto unmap_in;
+		return -EINVAL;
 	}
+
 	ret = dma_map_sg(dev->device, dev->out_sg, dev->nb_out_sg,
 			 DMA_FROM_DEVICE);
 	if (ret != dev->nb_out_sg) {
 		dev_err(dev->device, "couldn't map out sg\n");
-		goto unmap_out;
+		goto unmap_in;
 	}
 
 	/* Create input links */
 	dev->hw_desc[idx]->p1 = dev->hw_phys_link[0];
 	sg = dev->in_sg;
+	len = dev->total;
 	for (i = 0; i < dev->nb_in_sg; i++) {
-		dev->hw_link[i]->len = sg->length;
+		dev->hw_link[i]->len = min(len, sg->length);
 		dev->hw_link[i]->p = sg->dma_address;
 		if (i == (dev->nb_in_sg - 1)) {
 			dev->hw_link[i]->next = 0;
 		} else {
+			len -= min(len, sg->length);
 			dev->hw_link[i]->next = dev->hw_phys_link[i + 1];
 			sg = sg_next(sg);
 		}
@@ -514,12 +512,14 @@ static int sahara_hw_descriptor_create(struct sahara_dev *dev)
 	/* Create output links */
 	dev->hw_desc[idx]->p2 = dev->hw_phys_link[i];
 	sg = dev->out_sg;
+	len = dev->total;
 	for (j = i; j < dev->nb_out_sg + i; j++) {
-		dev->hw_link[j]->len = sg->length;
+		dev->hw_link[j]->len = min(len, sg->length);
 		dev->hw_link[j]->p = sg->dma_address;
 		if (j == (dev->nb_out_sg + i - 1)) {
 			dev->hw_link[j]->next = 0;
 		} else {
+			len -= min(len, sg->length);
 			dev->hw_link[j]->next = dev->hw_phys_link[j + 1];
 			sg = sg_next(sg);
 		}
@@ -538,9 +538,6 @@ static int sahara_hw_descriptor_create(struct sahara_dev *dev)
 
 	return 0;
 
-unmap_out:
-	dma_unmap_sg(dev->device, dev->out_sg, dev->nb_out_sg,
-		DMA_FROM_DEVICE);
 unmap_in:
 	dma_unmap_sg(dev->device, dev->in_sg, dev->nb_in_sg,
 		DMA_TO_DEVICE);
@@ -548,8 +545,24 @@ static int sahara_hw_descriptor_create(struct sahara_dev *dev)
 	return -EINVAL;
 }
 
+static void sahara_aes_cbc_update_iv(struct skcipher_request *req)
+{
+	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
+	struct sahara_aes_reqctx *rctx = skcipher_request_ctx(req);
+	unsigned int ivsize = crypto_skcipher_ivsize(skcipher);
+
+	/* Update IV buffer to contain the last ciphertext block */
+	if (rctx->mode & FLAGS_ENCRYPT) {
+		sg_pcopy_to_buffer(req->dst, sg_nents(req->dst), req->iv,
+				   ivsize, req->cryptlen - ivsize);
+	} else {
+		memcpy(req->iv, rctx->iv_out, ivsize);
+	}
+}
+
 static int sahara_aes_process(struct skcipher_request *req)
 {
+	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
 	struct sahara_dev *dev = dev_ptr;
 	struct sahara_ctx *ctx;
 	struct sahara_aes_reqctx *rctx;
@@ -571,8 +584,17 @@ static int sahara_aes_process(struct skcipher_request *req)
 	rctx->mode &= FLAGS_MODE_MASK;
 	dev->flags = (dev->flags & ~FLAGS_MODE_MASK) | rctx->mode;
 
-	if ((dev->flags & FLAGS_CBC) && req->iv)
-		memcpy(dev->iv_base, req->iv, AES_KEYSIZE_128);
+	if ((dev->flags & FLAGS_CBC) && req->iv) {
+		unsigned int ivsize = crypto_skcipher_ivsize(skcipher);
+
+		memcpy(dev->iv_base, req->iv, ivsize);
+
+		if (!(dev->flags & FLAGS_ENCRYPT)) {
+			sg_pcopy_to_buffer(req->src, sg_nents(req->src),
+					   rctx->iv_out, ivsize,
+					   req->cryptlen - ivsize);
+		}
+	}
 
 	/* assign new context to device */
 	dev->ctx = ctx;
@@ -585,16 +607,20 @@ static int sahara_aes_process(struct skcipher_request *req)
 
 	timeout = wait_for_completion_timeout(&dev->dma_completion,
 				msecs_to_jiffies(SAHARA_TIMEOUT_MS));
-	if (!timeout) {
-		dev_err(dev->device, "AES timeout\n");
-		return -ETIMEDOUT;
-	}
 
 	dma_unmap_sg(dev->device, dev->out_sg, dev->nb_out_sg,
 		DMA_FROM_DEVICE);
 	dma_unmap_sg(dev->device, dev->in_sg, dev->nb_in_sg,
 		DMA_TO_DEVICE);
 
+	if (!timeout) {
+		dev_err(dev->device, "AES timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	if ((dev->flags & FLAGS_CBC) && req->iv)
+		sahara_aes_cbc_update_iv(req);
+
 	return 0;
 }
 
@@ -608,7 +634,6 @@ static int sahara_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	/* SAHARA only supports 128bit keys */
 	if (keylen == AES_KEYSIZE_128) {
 		memcpy(ctx->key, key, keylen);
-		ctx->flags |= FLAGS_NEW_KEY;
 		return 0;
 	}
 
@@ -624,12 +649,40 @@ static int sahara_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	return crypto_skcipher_setkey(ctx->fallback, key, keylen);
 }
 
+static int sahara_aes_fallback(struct skcipher_request *req, unsigned long mode)
+{
+	struct sahara_aes_reqctx *rctx = skcipher_request_ctx(req);
+	struct sahara_ctx *ctx = crypto_skcipher_ctx(
+		crypto_skcipher_reqtfm(req));
+
+	skcipher_request_set_tfm(&rctx->fallback_req, ctx->fallback);
+	skcipher_request_set_callback(&rctx->fallback_req,
+				      req->base.flags,
+				      req->base.complete,
+				      req->base.data);
+	skcipher_request_set_crypt(&rctx->fallback_req, req->src,
+				   req->dst, req->cryptlen, req->iv);
+
+	if (mode & FLAGS_ENCRYPT)
+		return crypto_skcipher_encrypt(&rctx->fallback_req);
+
+	return crypto_skcipher_decrypt(&rctx->fallback_req);
+}
+
 static int sahara_aes_crypt(struct skcipher_request *req, unsigned long mode)
 {
 	struct sahara_aes_reqctx *rctx = skcipher_request_ctx(req);
+	struct sahara_ctx *ctx = crypto_skcipher_ctx(
+		crypto_skcipher_reqtfm(req));
 	struct sahara_dev *dev = dev_ptr;
 	int err = 0;
 
+	if (!req->cryptlen)
+		return 0;
+
+	if (unlikely(ctx->keylen != AES_KEYSIZE_128))
+		return sahara_aes_fallback(req, mode);
+
 	dev_dbg(dev->device, "nbytes: %d, enc: %d, cbc: %d\n",
 		req->cryptlen, !!(mode & FLAGS_ENCRYPT), !!(mode & FLAGS_CBC));
 
@@ -652,81 +705,21 @@ static int sahara_aes_crypt(struct skcipher_request *req, unsigned long mode)
 
 static int sahara_aes_ecb_encrypt(struct skcipher_request *req)
 {
-	struct sahara_aes_reqctx *rctx = skcipher_request_ctx(req);
-	struct sahara_ctx *ctx = crypto_skcipher_ctx(
-		crypto_skcipher_reqtfm(req));
-
-	if (unlikely(ctx->keylen != AES_KEYSIZE_128)) {
-		skcipher_request_set_tfm(&rctx->fallback_req, ctx->fallback);
-		skcipher_request_set_callback(&rctx->fallback_req,
-					      req->base.flags,
-					      req->base.complete,
-					      req->base.data);
-		skcipher_request_set_crypt(&rctx->fallback_req, req->src,
-					   req->dst, req->cryptlen, req->iv);
-		return crypto_skcipher_encrypt(&rctx->fallback_req);
-	}
-
 	return sahara_aes_crypt(req, FLAGS_ENCRYPT);
 }
 
 static int sahara_aes_ecb_decrypt(struct skcipher_request *req)
 {
-	struct sahara_aes_reqctx *rctx = skcipher_request_ctx(req);
-	struct sahara_ctx *ctx = crypto_skcipher_ctx(
-		crypto_skcipher_reqtfm(req));
-
-	if (unlikely(ctx->keylen != AES_KEYSIZE_128)) {
-		skcipher_request_set_tfm(&rctx->fallback_req, ctx->fallback);
-		skcipher_request_set_callback(&rctx->fallback_req,
-					      req->base.flags,
-					      req->base.complete,
-					      req->base.data);
-		skcipher_request_set_crypt(&rctx->fallback_req, req->src,
-					   req->dst, req->cryptlen, req->iv);
-		return crypto_skcipher_decrypt(&rctx->fallback_req);
-	}
-
 	return sahara_aes_crypt(req, 0);
 }
 
 static int sahara_aes_cbc_encrypt(struct skcipher_request *req)
 {
-	struct sahara_aes_reqctx *rctx = skcipher_request_ctx(req);
-	struct sahara_ctx *ctx = crypto_skcipher_ctx(
-		crypto_skcipher_reqtfm(req));
-
-	if (unlikely(ctx->keylen != AES_KEYSIZE_128)) {
-		skcipher_request_set_tfm(&rctx->fallback_req, ctx->fallback);
-		skcipher_request_set_callback(&rctx->fallback_req,
-					      req->base.flags,
-					      req->base.complete,
-					      req->base.data);
-		skcipher_request_set_crypt(&rctx->fallback_req, req->src,
-					   req->dst, req->cryptlen, req->iv);
-		return crypto_skcipher_encrypt(&rctx->fallback_req);
-	}
-
 	return sahara_aes_crypt(req, FLAGS_ENCRYPT | FLAGS_CBC);
 }
 
 static int sahara_aes_cbc_decrypt(struct skcipher_request *req)
 {
-	struct sahara_aes_reqctx *rctx = skcipher_request_ctx(req);
-	struct sahara_ctx *ctx = crypto_skcipher_ctx(
-		crypto_skcipher_reqtfm(req));
-
-	if (unlikely(ctx->keylen != AES_KEYSIZE_128)) {
-		skcipher_request_set_tfm(&rctx->fallback_req, ctx->fallback);
-		skcipher_request_set_callback(&rctx->fallback_req,
-					      req->base.flags,
-					      req->base.complete,
-					      req->base.data);
-		skcipher_request_set_crypt(&rctx->fallback_req, req->src,
-					   req->dst, req->cryptlen, req->iv);
-		return crypto_skcipher_decrypt(&rctx->fallback_req);
-	}
-
 	return sahara_aes_crypt(req, FLAGS_CBC);
 }
 
@@ -783,6 +776,7 @@ static int sahara_sha_hw_links_create(struct sahara_dev *dev,
 				       int start)
 {
 	struct scatterlist *sg;
+	unsigned int len;
 	unsigned int i;
 	int ret;
 
@@ -804,12 +798,14 @@ static int sahara_sha_hw_links_create(struct sahara_dev *dev,
 	if (!ret)
 		return -EFAULT;
 
+	len = rctx->total;
 	for (i = start; i < dev->nb_in_sg + start; i++) {
-		dev->hw_link[i]->len = sg->length;
+		dev->hw_link[i]->len = min(len, sg->length);
 		dev->hw_link[i]->p = sg->dma_address;
 		if (i == (dev->nb_in_sg + start - 1)) {
 			dev->hw_link[i]->next = 0;
 		} else {
+			len -= min(len, sg->length);
 			dev->hw_link[i]->next = dev->hw_phys_link[i + 1];
 			sg = sg_next(sg);
 		}
@@ -890,24 +886,6 @@ static int sahara_sha_hw_context_descriptor_create(struct sahara_dev *dev,
 	return 0;
 }
 
-static int sahara_walk_and_recalc(struct scatterlist *sg, unsigned int nbytes)
-{
-	if (!sg || !sg->length)
-		return nbytes;
-
-	while (nbytes && sg) {
-		if (nbytes <= sg->length) {
-			sg->length = nbytes;
-			sg_mark_end(sg);
-			break;
-		}
-		nbytes -= sg->length;
-		sg = sg_next(sg);
-	}
-
-	return nbytes;
-}
-
 static int sahara_sha_prepare_request(struct ahash_request *req)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
@@ -944,36 +922,20 @@ static int sahara_sha_prepare_request(struct ahash_request *req)
 					hash_later, 0);
 	}
 
-	/* nbytes should now be multiple of blocksize */
-	req->nbytes = req->nbytes - hash_later;
-
-	sahara_walk_and_recalc(req->src, req->nbytes);
-
+	rctx->total = len - hash_later;
 	/* have data from previous operation and current */
 	if (rctx->buf_cnt && req->nbytes) {
 		sg_init_table(rctx->in_sg_chain, 2);
 		sg_set_buf(rctx->in_sg_chain, rctx->rembuf, rctx->buf_cnt);
-
 		sg_chain(rctx->in_sg_chain, 2, req->src);
-
-		rctx->total = req->nbytes + rctx->buf_cnt;
 		rctx->in_sg = rctx->in_sg_chain;
-
-		req->src = rctx->in_sg_chain;
 	/* only data from previous operation */
 	} else if (rctx->buf_cnt) {
-		if (req->src)
-			rctx->in_sg = req->src;
-		else
-			rctx->in_sg = rctx->in_sg_chain;
-		/* buf was copied into rembuf above */
+		rctx->in_sg = rctx->in_sg_chain;
 		sg_init_one(rctx->in_sg, rctx->rembuf, rctx->buf_cnt);
-		rctx->total = rctx->buf_cnt;
 	/* no data from previous operation */
 	} else {
 		rctx->in_sg = req->src;
-		rctx->total = req->nbytes;
-		req->src = rctx->in_sg;
 	}
 
 	/* on next call, we only have the remaining data in the buffer */
@@ -994,7 +956,10 @@ static int sahara_sha_process(struct ahash_request *req)
 		return ret;
 
 	if (rctx->first) {
-		sahara_sha_hw_data_descriptor_create(dev, rctx, req, 0);
+		ret = sahara_sha_hw_data_descriptor_create(dev, rctx, req, 0);
+		if (ret)
+			return ret;
+
 		dev->hw_desc[0]->next = 0;
 		rctx->first = 0;
 	} else {
@@ -1002,7 +967,10 @@ static int sahara_sha_process(struct ahash_request *req)
 
 		sahara_sha_hw_context_descriptor_create(dev, rctx, req, 0);
 		dev->hw_desc[0]->next = dev->hw_phys_desc[1];
-		sahara_sha_hw_data_descriptor_create(dev, rctx, req, 1);
+		ret = sahara_sha_hw_data_descriptor_create(dev, rctx, req, 1);
+		if (ret)
+			return ret;
+
 		dev->hw_desc[1]->next = 0;
 	}
 
@@ -1015,18 +983,19 @@ static int sahara_sha_process(struct ahash_request *req)
 
 	timeout = wait_for_completion_timeout(&dev->dma_completion,
 				msecs_to_jiffies(SAHARA_TIMEOUT_MS));
-	if (!timeout) {
-		dev_err(dev->device, "SHA timeout\n");
-		return -ETIMEDOUT;
-	}
 
 	if (rctx->sg_in_idx)
 		dma_unmap_sg(dev->device, dev->in_sg, dev->nb_in_sg,
 			     DMA_TO_DEVICE);
 
+	if (!timeout) {
+		dev_err(dev->device, "SHA timeout\n");
+		return -ETIMEDOUT;
+	}
+
 	memcpy(rctx->context, dev->context_base, rctx->context_size);
 
-	if (req->result)
+	if (req->result && rctx->last)
 		memcpy(req->result, rctx->context, rctx->digest_size);
 
 	return 0;
@@ -1170,8 +1139,7 @@ static int sahara_sha_import(struct ahash_request *req, const void *in)
 static int sahara_sha_cra_init(struct crypto_tfm *tfm)
 {
 	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
-				 sizeof(struct sahara_sha_reqctx) +
-				 SHA_BUFFER_LEN + SHA256_BLOCK_SIZE);
+				 sizeof(struct sahara_sha_reqctx));
 
 	return 0;
 }
diff --git a/drivers/crypto/virtio/Kconfig b/drivers/crypto/virtio/Kconfig
index b894e3a8be4f..5f8915f4a9ff 100644
--- a/drivers/crypto/virtio/Kconfig
+++ b/drivers/crypto/virtio/Kconfig
@@ -3,8 +3,11 @@ config CRYPTO_DEV_VIRTIO
 	tristate "VirtIO crypto driver"
 	depends on VIRTIO
 	select CRYPTO_AEAD
+	select CRYPTO_AKCIPHER2
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ENGINE
+	select CRYPTO_RSA
+	select MPILIB
 	help
 	  This driver provides support for virtio crypto device. If you
 	  choose 'M' here, this module will be called virtio_crypto.
diff --git a/drivers/crypto/virtio/Makefile b/drivers/crypto/virtio/Makefile
index cbfccccfa135..f2b839473d61 100644
--- a/drivers/crypto/virtio/Makefile
+++ b/drivers/crypto/virtio/Makefile
@@ -2,5 +2,6 @@
 obj-$(CONFIG_CRYPTO_DEV_VIRTIO) += virtio_crypto.o
 virtio_crypto-objs := \
 	virtio_crypto_algs.o \
+	virtio_crypto_akcipher_algs.o \
 	virtio_crypto_mgr.o \
 	virtio_crypto_core.o
diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
new file mode 100644
index 000000000000..2cfc36d141c0
--- /dev/null
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -0,0 +1,591 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+ /* Asymmetric algorithms supported by virtio crypto device
+  *
+  * Authors: zhenwei pi <pizhenwei@bytedance.com>
+  *          lei he <helei.sig11@bytedance.com>
+  *
+  * Copyright 2022 Bytedance CO., LTD.
+  */
+
+#include <linux/mpi.h>
+#include <linux/scatterlist.h>
+#include <crypto/algapi.h>
+#include <crypto/internal/akcipher.h>
+#include <crypto/internal/rsa.h>
+#include <linux/err.h>
+#include <crypto/scatterwalk.h>
+#include <linux/atomic.h>
+
+#include <uapi/linux/virtio_crypto.h>
+#include "virtio_crypto_common.h"
+
+struct virtio_crypto_rsa_ctx {
+	MPI n;
+};
+
+struct virtio_crypto_akcipher_ctx {
+	struct crypto_engine_ctx enginectx;
+	struct virtio_crypto *vcrypto;
+	struct crypto_akcipher *tfm;
+	bool session_valid;
+	__u64 session_id;
+	union {
+		struct virtio_crypto_rsa_ctx rsa_ctx;
+	};
+};
+
+struct virtio_crypto_akcipher_request {
+	struct virtio_crypto_request base;
+	struct virtio_crypto_akcipher_ctx *akcipher_ctx;
+	struct akcipher_request *akcipher_req;
+	void *src_buf;
+	void *dst_buf;
+	uint32_t opcode;
+};
+
+struct virtio_crypto_akcipher_algo {
+	uint32_t algonum;
+	uint32_t service;
+	unsigned int active_devs;
+	struct akcipher_alg algo;
+};
+
+static DEFINE_MUTEX(algs_lock);
+
+static void virtio_crypto_akcipher_finalize_req(
+	struct virtio_crypto_akcipher_request *vc_akcipher_req,
+	struct akcipher_request *req, int err)
+{
+	kfree(vc_akcipher_req->src_buf);
+	kfree(vc_akcipher_req->dst_buf);
+	vc_akcipher_req->src_buf = NULL;
+	vc_akcipher_req->dst_buf = NULL;
+	virtcrypto_clear_request(&vc_akcipher_req->base);
+
+	crypto_finalize_akcipher_request(vc_akcipher_req->base.dataq->engine, req, err);
+}
+
+static void virtio_crypto_dataq_akcipher_callback(struct virtio_crypto_request *vc_req, int len)
+{
+	struct virtio_crypto_akcipher_request *vc_akcipher_req =
+		container_of(vc_req, struct virtio_crypto_akcipher_request, base);
+	struct akcipher_request *akcipher_req;
+	int error;
+
+	switch (vc_req->status) {
+	case VIRTIO_CRYPTO_OK:
+		error = 0;
+		break;
+	case VIRTIO_CRYPTO_INVSESS:
+	case VIRTIO_CRYPTO_ERR:
+		error = -EINVAL;
+		break;
+	case VIRTIO_CRYPTO_BADMSG:
+		error = -EBADMSG;
+		break;
+
+	case VIRTIO_CRYPTO_KEY_REJECTED:
+		error = -EKEYREJECTED;
+		break;
+
+	default:
+		error = -EIO;
+		break;
+	}
+
+	akcipher_req = vc_akcipher_req->akcipher_req;
+	if (vc_akcipher_req->opcode != VIRTIO_CRYPTO_AKCIPHER_VERIFY)
+		sg_copy_from_buffer(akcipher_req->dst, sg_nents(akcipher_req->dst),
+				    vc_akcipher_req->dst_buf, akcipher_req->dst_len);
+	virtio_crypto_akcipher_finalize_req(vc_akcipher_req, akcipher_req, error);
+}
+
+static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher_ctx *ctx,
+		struct virtio_crypto_ctrl_header *header, void *para,
+		const uint8_t *key, unsigned int keylen)
+{
+	struct scatterlist outhdr_sg, key_sg, inhdr_sg, *sgs[3];
+	struct virtio_crypto *vcrypto = ctx->vcrypto;
+	uint8_t *pkey;
+	int err;
+	unsigned int num_out = 0, num_in = 0;
+	struct virtio_crypto_op_ctrl_req *ctrl;
+	struct virtio_crypto_session_input *input;
+	struct virtio_crypto_ctrl_request *vc_ctrl_req;
+
+	pkey = kmemdup(key, keylen, GFP_ATOMIC);
+	if (!pkey)
+		return -ENOMEM;
+
+	vc_ctrl_req = kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
+	if (!vc_ctrl_req) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	ctrl = &vc_ctrl_req->ctrl;
+	memcpy(&ctrl->header, header, sizeof(ctrl->header));
+	memcpy(&ctrl->u, para, sizeof(ctrl->u));
+	input = &vc_ctrl_req->input;
+	input->status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
+
+	sg_init_one(&outhdr_sg, ctrl, sizeof(*ctrl));
+	sgs[num_out++] = &outhdr_sg;
+
+	sg_init_one(&key_sg, pkey, keylen);
+	sgs[num_out++] = &key_sg;
+
+	sg_init_one(&inhdr_sg, input, sizeof(*input));
+	sgs[num_out + num_in++] = &inhdr_sg;
+
+	err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out, num_in, vc_ctrl_req);
+	if (err < 0)
+		goto out;
+
+	if (le32_to_cpu(input->status) != VIRTIO_CRYPTO_OK) {
+		pr_err("virtio_crypto: Create session failed status: %u\n",
+			le32_to_cpu(input->status));
+		err = -EINVAL;
+		goto out;
+	}
+
+	ctx->session_id = le64_to_cpu(input->session_id);
+	ctx->session_valid = true;
+	err = 0;
+
+out:
+	kfree(vc_ctrl_req);
+	kfree_sensitive(pkey);
+
+	return err;
+}
+
+static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akcipher_ctx *ctx)
+{
+	struct scatterlist outhdr_sg, inhdr_sg, *sgs[2];
+	struct virtio_crypto_destroy_session_req *destroy_session;
+	struct virtio_crypto *vcrypto = ctx->vcrypto;
+	unsigned int num_out = 0, num_in = 0;
+	int err;
+	struct virtio_crypto_op_ctrl_req *ctrl;
+	struct virtio_crypto_inhdr *ctrl_status;
+	struct virtio_crypto_ctrl_request *vc_ctrl_req;
+
+	if (!ctx->session_valid)
+		return 0;
+
+	vc_ctrl_req = kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
+	if (!vc_ctrl_req)
+		return -ENOMEM;
+
+	ctrl_status = &vc_ctrl_req->ctrl_status;
+	ctrl_status->status = VIRTIO_CRYPTO_ERR;
+	ctrl = &vc_ctrl_req->ctrl;
+	ctrl->header.opcode = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
+	ctrl->header.queue_id = 0;
+
+	destroy_session = &ctrl->u.destroy_session;
+	destroy_session->session_id = cpu_to_le64(ctx->session_id);
+
+	sg_init_one(&outhdr_sg, ctrl, sizeof(*ctrl));
+	sgs[num_out++] = &outhdr_sg;
+
+	sg_init_one(&inhdr_sg, &ctrl_status->status, sizeof(ctrl_status->status));
+	sgs[num_out + num_in++] = &inhdr_sg;
+
+	err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out, num_in, vc_ctrl_req);
+	if (err < 0)
+		goto out;
+
+	if (ctrl_status->status != VIRTIO_CRYPTO_OK) {
+		pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
+			ctrl_status->status, destroy_session->session_id);
+		err = -EINVAL;
+		goto out;
+	}
+
+	err = 0;
+	ctx->session_valid = false;
+
+out:
+	kfree(vc_ctrl_req);
+
+	return err;
+}
+
+static int __virtio_crypto_akcipher_do_req(struct virtio_crypto_akcipher_request *vc_akcipher_req,
+		struct akcipher_request *req, struct data_queue *data_vq)
+{
+	struct virtio_crypto_akcipher_ctx *ctx = vc_akcipher_req->akcipher_ctx;
+	struct virtio_crypto_request *vc_req = &vc_akcipher_req->base;
+	struct virtio_crypto *vcrypto = ctx->vcrypto;
+	struct virtio_crypto_op_data_req *req_data = vc_req->req_data;
+	struct scatterlist *sgs[4], outhdr_sg, inhdr_sg, srcdata_sg, dstdata_sg;
+	void *src_buf = NULL, *dst_buf = NULL;
+	unsigned int num_out = 0, num_in = 0;
+	int node = dev_to_node(&vcrypto->vdev->dev);
+	unsigned long flags;
+	int ret = -ENOMEM;
+	bool verify = vc_akcipher_req->opcode == VIRTIO_CRYPTO_AKCIPHER_VERIFY;
+	unsigned int src_len = verify ? req->src_len + req->dst_len : req->src_len;
+
+	/* out header */
+	sg_init_one(&outhdr_sg, req_data, sizeof(*req_data));
+	sgs[num_out++] = &outhdr_sg;
+
+	/* src data */
+	src_buf = kcalloc_node(src_len, 1, GFP_KERNEL, node);
+	if (!src_buf)
+		goto err;
+
+	if (verify) {
+		/* for verify operation, both src and dst data work as OUT direction */
+		sg_copy_to_buffer(req->src, sg_nents(req->src), src_buf, src_len);
+		sg_init_one(&srcdata_sg, src_buf, src_len);
+		sgs[num_out++] = &srcdata_sg;
+	} else {
+		sg_copy_to_buffer(req->src, sg_nents(req->src), src_buf, src_len);
+		sg_init_one(&srcdata_sg, src_buf, src_len);
+		sgs[num_out++] = &srcdata_sg;
+
+		/* dst data */
+		dst_buf = kcalloc_node(req->dst_len, 1, GFP_KERNEL, node);
+		if (!dst_buf)
+			goto err;
+
+		sg_init_one(&dstdata_sg, dst_buf, req->dst_len);
+		sgs[num_out + num_in++] = &dstdata_sg;
+	}
+
+	vc_akcipher_req->src_buf = src_buf;
+	vc_akcipher_req->dst_buf = dst_buf;
+
+	/* in header */
+	sg_init_one(&inhdr_sg, &vc_req->status, sizeof(vc_req->status));
+	sgs[num_out + num_in++] = &inhdr_sg;
+
+	spin_lock_irqsave(&data_vq->lock, flags);
+	ret = virtqueue_add_sgs(data_vq->vq, sgs, num_out, num_in, vc_req, GFP_ATOMIC);
+	virtqueue_kick(data_vq->vq);
+	spin_unlock_irqrestore(&data_vq->lock, flags);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	kfree(src_buf);
+	kfree(dst_buf);
+
+	return -ENOMEM;
+}
+
+static int virtio_crypto_rsa_do_req(struct crypto_engine *engine, void *vreq)
+{
+	struct akcipher_request *req = container_of(vreq, struct akcipher_request, base);
+	struct virtio_crypto_akcipher_request *vc_akcipher_req = akcipher_request_ctx(req);
+	struct virtio_crypto_request *vc_req = &vc_akcipher_req->base;
+	struct virtio_crypto_akcipher_ctx *ctx = vc_akcipher_req->akcipher_ctx;
+	struct virtio_crypto *vcrypto = ctx->vcrypto;
+	struct data_queue *data_vq = vc_req->dataq;
+	struct virtio_crypto_op_header *header;
+	struct virtio_crypto_akcipher_data_req *akcipher_req;
+	int ret;
+
+	vc_req->sgs = NULL;
+	vc_req->req_data = kzalloc_node(sizeof(*vc_req->req_data),
+		GFP_KERNEL, dev_to_node(&vcrypto->vdev->dev));
+	if (!vc_req->req_data)
+		return -ENOMEM;
+
+	/* build request header */
+	header = &vc_req->req_data->header;
+	header->opcode = cpu_to_le32(vc_akcipher_req->opcode);
+	header->algo = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_RSA);
+	header->session_id = cpu_to_le64(ctx->session_id);
+
+	/* build request akcipher data */
+	akcipher_req = &vc_req->req_data->u.akcipher_req;
+	akcipher_req->para.src_data_len = cpu_to_le32(req->src_len);
+	akcipher_req->para.dst_data_len = cpu_to_le32(req->dst_len);
+
+	ret = __virtio_crypto_akcipher_do_req(vc_akcipher_req, req, data_vq);
+	if (ret < 0) {
+		kfree_sensitive(vc_req->req_data);
+		vc_req->req_data = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static int virtio_crypto_rsa_req(struct akcipher_request *req, uint32_t opcode)
+{
+	struct crypto_akcipher *atfm = crypto_akcipher_reqtfm(req);
+	struct virtio_crypto_akcipher_ctx *ctx = akcipher_tfm_ctx(atfm);
+	struct virtio_crypto_akcipher_request *vc_akcipher_req = akcipher_request_ctx(req);
+	struct virtio_crypto_request *vc_req = &vc_akcipher_req->base;
+	struct virtio_crypto *vcrypto = ctx->vcrypto;
+	/* Use the first data virtqueue as default */
+	struct data_queue *data_vq = &vcrypto->data_vq[0];
+
+	vc_req->dataq = data_vq;
+	vc_req->alg_cb = virtio_crypto_dataq_akcipher_callback;
+	vc_akcipher_req->akcipher_ctx = ctx;
+	vc_akcipher_req->akcipher_req = req;
+	vc_akcipher_req->opcode = opcode;
+
+	return crypto_transfer_akcipher_request_to_engine(data_vq->engine, req);
+}
+
+static int virtio_crypto_rsa_encrypt(struct akcipher_request *req)
+{
+	return virtio_crypto_rsa_req(req, VIRTIO_CRYPTO_AKCIPHER_ENCRYPT);
+}
+
+static int virtio_crypto_rsa_decrypt(struct akcipher_request *req)
+{
+	return virtio_crypto_rsa_req(req, VIRTIO_CRYPTO_AKCIPHER_DECRYPT);
+}
+
+static int virtio_crypto_rsa_sign(struct akcipher_request *req)
+{
+	return virtio_crypto_rsa_req(req, VIRTIO_CRYPTO_AKCIPHER_SIGN);
+}
+
+static int virtio_crypto_rsa_verify(struct akcipher_request *req)
+{
+	return virtio_crypto_rsa_req(req, VIRTIO_CRYPTO_AKCIPHER_VERIFY);
+}
+
+static int virtio_crypto_rsa_set_key(struct crypto_akcipher *tfm,
+				     const void *key,
+				     unsigned int keylen,
+				     bool private,
+				     int padding_algo,
+				     int hash_algo)
+{
+	struct virtio_crypto_akcipher_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct virtio_crypto_rsa_ctx *rsa_ctx = &ctx->rsa_ctx;
+	struct virtio_crypto *vcrypto;
+	struct virtio_crypto_ctrl_header header;
+	struct virtio_crypto_akcipher_session_para para;
+	struct rsa_key rsa_key = {0};
+	int node = virtio_crypto_get_current_node();
+	uint32_t keytype;
+	int ret;
+
+	/* mpi_free will test n, just free it. */
+	mpi_free(rsa_ctx->n);
+	rsa_ctx->n = NULL;
+
+	if (private) {
+		keytype = VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PRIVATE;
+		ret = rsa_parse_priv_key(&rsa_key, key, keylen);
+	} else {
+		keytype = VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PUBLIC;
+		ret = rsa_parse_pub_key(&rsa_key, key, keylen);
+	}
+
+	if (ret)
+		return ret;
+
+	rsa_ctx->n = mpi_read_raw_data(rsa_key.n, rsa_key.n_sz);
+	if (!rsa_ctx->n)
+		return -ENOMEM;
+
+	if (!ctx->vcrypto) {
+		vcrypto = virtcrypto_get_dev_node(node, VIRTIO_CRYPTO_SERVICE_AKCIPHER,
+						VIRTIO_CRYPTO_AKCIPHER_RSA);
+		if (!vcrypto) {
+			pr_err("virtio_crypto: Could not find a virtio device in the system or unsupported algo\n");
+			return -ENODEV;
+		}
+
+		ctx->vcrypto = vcrypto;
+	} else {
+		virtio_crypto_alg_akcipher_close_session(ctx);
+	}
+
+	/* set ctrl header */
+	header.opcode =	cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_CREATE_SESSION);
+	header.algo = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_RSA);
+	header.queue_id = 0;
+
+	/* set RSA para */
+	para.algo = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_RSA);
+	para.keytype = cpu_to_le32(keytype);
+	para.keylen = cpu_to_le32(keylen);
+	para.u.rsa.padding_algo = cpu_to_le32(padding_algo);
+	para.u.rsa.hash_algo = cpu_to_le32(hash_algo);
+
+	return virtio_crypto_alg_akcipher_init_session(ctx, &header, &para, key, keylen);
+}
+
+static int virtio_crypto_rsa_raw_set_priv_key(struct crypto_akcipher *tfm,
+					      const void *key,
+					      unsigned int keylen)
+{
+	return virtio_crypto_rsa_set_key(tfm, key, keylen, 1,
+					 VIRTIO_CRYPTO_RSA_RAW_PADDING,
+					 VIRTIO_CRYPTO_RSA_NO_HASH);
+}
+
+
+static int virtio_crypto_p1pad_rsa_sha1_set_priv_key(struct crypto_akcipher *tfm,
+						     const void *key,
+						     unsigned int keylen)
+{
+	return virtio_crypto_rsa_set_key(tfm, key, keylen, 1,
+					 VIRTIO_CRYPTO_RSA_PKCS1_PADDING,
+					 VIRTIO_CRYPTO_RSA_SHA1);
+}
+
+static int virtio_crypto_rsa_raw_set_pub_key(struct crypto_akcipher *tfm,
+					     const void *key,
+					     unsigned int keylen)
+{
+	return virtio_crypto_rsa_set_key(tfm, key, keylen, 0,
+					 VIRTIO_CRYPTO_RSA_RAW_PADDING,
+					 VIRTIO_CRYPTO_RSA_NO_HASH);
+}
+
+static int virtio_crypto_p1pad_rsa_sha1_set_pub_key(struct crypto_akcipher *tfm,
+						    const void *key,
+						    unsigned int keylen)
+{
+	return virtio_crypto_rsa_set_key(tfm, key, keylen, 0,
+					 VIRTIO_CRYPTO_RSA_PKCS1_PADDING,
+					 VIRTIO_CRYPTO_RSA_SHA1);
+}
+
+static unsigned int virtio_crypto_rsa_max_size(struct crypto_akcipher *tfm)
+{
+	struct virtio_crypto_akcipher_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct virtio_crypto_rsa_ctx *rsa_ctx = &ctx->rsa_ctx;
+
+	return mpi_get_size(rsa_ctx->n);
+}
+
+static int virtio_crypto_rsa_init_tfm(struct crypto_akcipher *tfm)
+{
+	struct virtio_crypto_akcipher_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	ctx->tfm = tfm;
+	ctx->enginectx.op.do_one_request = virtio_crypto_rsa_do_req;
+	ctx->enginectx.op.prepare_request = NULL;
+	ctx->enginectx.op.unprepare_request = NULL;
+
+	return 0;
+}
+
+static void virtio_crypto_rsa_exit_tfm(struct crypto_akcipher *tfm)
+{
+	struct virtio_crypto_akcipher_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct virtio_crypto_rsa_ctx *rsa_ctx = &ctx->rsa_ctx;
+
+	virtio_crypto_alg_akcipher_close_session(ctx);
+	virtcrypto_dev_put(ctx->vcrypto);
+	mpi_free(rsa_ctx->n);
+	rsa_ctx->n = NULL;
+}
+
+static struct virtio_crypto_akcipher_algo virtio_crypto_akcipher_algs[] = {
+	{
+		.algonum = VIRTIO_CRYPTO_AKCIPHER_RSA,
+		.service = VIRTIO_CRYPTO_SERVICE_AKCIPHER,
+		.algo = {
+			.encrypt = virtio_crypto_rsa_encrypt,
+			.decrypt = virtio_crypto_rsa_decrypt,
+			.set_pub_key = virtio_crypto_rsa_raw_set_pub_key,
+			.set_priv_key = virtio_crypto_rsa_raw_set_priv_key,
+			.max_size = virtio_crypto_rsa_max_size,
+			.init = virtio_crypto_rsa_init_tfm,
+			.exit = virtio_crypto_rsa_exit_tfm,
+			.reqsize = sizeof(struct virtio_crypto_akcipher_request),
+			.base = {
+				.cra_name = "rsa",
+				.cra_driver_name = "virtio-crypto-rsa",
+				.cra_priority = 150,
+				.cra_module = THIS_MODULE,
+				.cra_ctxsize = sizeof(struct virtio_crypto_akcipher_ctx),
+			},
+		},
+	},
+	{
+		.algonum = VIRTIO_CRYPTO_AKCIPHER_RSA,
+		.service = VIRTIO_CRYPTO_SERVICE_AKCIPHER,
+		.algo = {
+			.encrypt = virtio_crypto_rsa_encrypt,
+			.decrypt = virtio_crypto_rsa_decrypt,
+			.sign = virtio_crypto_rsa_sign,
+			.verify = virtio_crypto_rsa_verify,
+			.set_pub_key = virtio_crypto_p1pad_rsa_sha1_set_pub_key,
+			.set_priv_key = virtio_crypto_p1pad_rsa_sha1_set_priv_key,
+			.max_size = virtio_crypto_rsa_max_size,
+			.init = virtio_crypto_rsa_init_tfm,
+			.exit = virtio_crypto_rsa_exit_tfm,
+			.reqsize = sizeof(struct virtio_crypto_akcipher_request),
+			.base = {
+				.cra_name = "pkcs1pad(rsa,sha1)",
+				.cra_driver_name = "virtio-pkcs1-rsa-with-sha1",
+				.cra_priority = 150,
+				.cra_module = THIS_MODULE,
+				.cra_ctxsize = sizeof(struct virtio_crypto_akcipher_ctx),
+			},
+		},
+	},
+};
+
+int virtio_crypto_akcipher_algs_register(struct virtio_crypto *vcrypto)
+{
+	int ret = 0;
+	int i = 0;
+
+	mutex_lock(&algs_lock);
+
+	for (i = 0; i < ARRAY_SIZE(virtio_crypto_akcipher_algs); i++) {
+		uint32_t service = virtio_crypto_akcipher_algs[i].service;
+		uint32_t algonum = virtio_crypto_akcipher_algs[i].algonum;
+
+		if (!virtcrypto_algo_is_supported(vcrypto, service, algonum))
+			continue;
+
+		if (virtio_crypto_akcipher_algs[i].active_devs == 0) {
+			ret = crypto_register_akcipher(&virtio_crypto_akcipher_algs[i].algo);
+			if (ret)
+				goto unlock;
+		}
+
+		virtio_crypto_akcipher_algs[i].active_devs++;
+		dev_info(&vcrypto->vdev->dev, "Registered akcipher algo %s\n",
+			 virtio_crypto_akcipher_algs[i].algo.base.cra_name);
+	}
+
+unlock:
+	mutex_unlock(&algs_lock);
+	return ret;
+}
+
+void virtio_crypto_akcipher_algs_unregister(struct virtio_crypto *vcrypto)
+{
+	int i = 0;
+
+	mutex_lock(&algs_lock);
+
+	for (i = 0; i < ARRAY_SIZE(virtio_crypto_akcipher_algs); i++) {
+		uint32_t service = virtio_crypto_akcipher_algs[i].service;
+		uint32_t algonum = virtio_crypto_akcipher_algs[i].algonum;
+
+		if (virtio_crypto_akcipher_algs[i].active_devs == 0 ||
+		    !virtcrypto_algo_is_supported(vcrypto, service, algonum))
+			continue;
+
+		if (virtio_crypto_akcipher_algs[i].active_devs == 1)
+			crypto_unregister_akcipher(&virtio_crypto_akcipher_algs[i].algo);
+
+		virtio_crypto_akcipher_algs[i].active_devs--;
+	}
+
+	mutex_unlock(&algs_lock);
+}
diff --git a/drivers/crypto/virtio/virtio_crypto_algs.c b/drivers/crypto/virtio/virtio_crypto_algs.c
index 583c0b535d13..ae645c9d47a7 100644
--- a/drivers/crypto/virtio/virtio_crypto_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_algs.c
@@ -118,11 +118,14 @@ static int virtio_crypto_alg_skcipher_init_session(
 		int encrypt)
 {
 	struct scatterlist outhdr, key_sg, inhdr, *sgs[3];
-	unsigned int tmp;
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
 	int op = encrypt ? VIRTIO_CRYPTO_OP_ENCRYPT : VIRTIO_CRYPTO_OP_DECRYPT;
 	int err;
 	unsigned int num_out = 0, num_in = 0;
+	struct virtio_crypto_op_ctrl_req *ctrl;
+	struct virtio_crypto_session_input *input;
+	struct virtio_crypto_sym_create_session_req *sym_create_session;
+	struct virtio_crypto_ctrl_request *vc_ctrl_req;
 
 	/*
 	 * Avoid to do DMA from the stack, switch to using
@@ -133,26 +136,29 @@ static int virtio_crypto_alg_skcipher_init_session(
 	if (!cipher_key)
 		return -ENOMEM;
 
-	spin_lock(&vcrypto->ctrl_lock);
+	vc_ctrl_req = kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
+	if (!vc_ctrl_req) {
+		err = -ENOMEM;
+		goto out;
+	}
+
 	/* Pad ctrl header */
-	vcrypto->ctrl.header.opcode =
-		cpu_to_le32(VIRTIO_CRYPTO_CIPHER_CREATE_SESSION);
-	vcrypto->ctrl.header.algo = cpu_to_le32(alg);
+	ctrl = &vc_ctrl_req->ctrl;
+	ctrl->header.opcode = cpu_to_le32(VIRTIO_CRYPTO_CIPHER_CREATE_SESSION);
+	ctrl->header.algo = cpu_to_le32(alg);
 	/* Set the default dataqueue id to 0 */
-	vcrypto->ctrl.header.queue_id = 0;
+	ctrl->header.queue_id = 0;
 
-	vcrypto->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
+	input = &vc_ctrl_req->input;
+	input->status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
 	/* Pad cipher's parameters */
-	vcrypto->ctrl.u.sym_create_session.op_type =
-		cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
-	vcrypto->ctrl.u.sym_create_session.u.cipher.para.algo =
-		vcrypto->ctrl.header.algo;
-	vcrypto->ctrl.u.sym_create_session.u.cipher.para.keylen =
-		cpu_to_le32(keylen);
-	vcrypto->ctrl.u.sym_create_session.u.cipher.para.op =
-		cpu_to_le32(op);
-
-	sg_init_one(&outhdr, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
+	sym_create_session = &ctrl->u.sym_create_session;
+	sym_create_session->op_type = cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
+	sym_create_session->u.cipher.para.algo = ctrl->header.algo;
+	sym_create_session->u.cipher.para.keylen = cpu_to_le32(keylen);
+	sym_create_session->u.cipher.para.op = cpu_to_le32(op);
+
+	sg_init_one(&outhdr, ctrl, sizeof(*ctrl));
 	sgs[num_out++] = &outhdr;
 
 	/* Set key */
@@ -160,45 +166,30 @@ static int virtio_crypto_alg_skcipher_init_session(
 	sgs[num_out++] = &key_sg;
 
 	/* Return status and session id back */
-	sg_init_one(&inhdr, &vcrypto->input, sizeof(vcrypto->input));
+	sg_init_one(&inhdr, input, sizeof(*input));
 	sgs[num_out + num_in++] = &inhdr;
 
-	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
-				num_in, vcrypto, GFP_ATOMIC);
-	if (err < 0) {
-		spin_unlock(&vcrypto->ctrl_lock);
-		kfree_sensitive(cipher_key);
-		return err;
-	}
-	virtqueue_kick(vcrypto->ctrl_vq);
-
-	/*
-	 * Trapping into the hypervisor, so the request should be
-	 * handled immediately.
-	 */
-	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &tmp) &&
-	       !virtqueue_is_broken(vcrypto->ctrl_vq))
-		cpu_relax();
+	err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out, num_in, vc_ctrl_req);
+	if (err < 0)
+		goto out;
 
-	if (le32_to_cpu(vcrypto->input.status) != VIRTIO_CRYPTO_OK) {
-		spin_unlock(&vcrypto->ctrl_lock);
+	if (le32_to_cpu(input->status) != VIRTIO_CRYPTO_OK) {
 		pr_err("virtio_crypto: Create session failed status: %u\n",
-			le32_to_cpu(vcrypto->input.status));
-		kfree_sensitive(cipher_key);
-		return -EINVAL;
+			le32_to_cpu(input->status));
+		err = -EINVAL;
+		goto out;
 	}
 
 	if (encrypt)
-		ctx->enc_sess_info.session_id =
-			le64_to_cpu(vcrypto->input.session_id);
+		ctx->enc_sess_info.session_id = le64_to_cpu(input->session_id);
 	else
-		ctx->dec_sess_info.session_id =
-			le64_to_cpu(vcrypto->input.session_id);
-
-	spin_unlock(&vcrypto->ctrl_lock);
+		ctx->dec_sess_info.session_id = le64_to_cpu(input->session_id);
 
+	err = 0;
+out:
+	kfree(vc_ctrl_req);
 	kfree_sensitive(cipher_key);
-	return 0;
+	return err;
 }
 
 static int virtio_crypto_alg_skcipher_close_session(
@@ -206,60 +197,56 @@ static int virtio_crypto_alg_skcipher_close_session(
 		int encrypt)
 {
 	struct scatterlist outhdr, status_sg, *sgs[2];
-	unsigned int tmp;
 	struct virtio_crypto_destroy_session_req *destroy_session;
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
 	int err;
 	unsigned int num_out = 0, num_in = 0;
+	struct virtio_crypto_op_ctrl_req *ctrl;
+	struct virtio_crypto_inhdr *ctrl_status;
+	struct virtio_crypto_ctrl_request *vc_ctrl_req;
+
+	vc_ctrl_req = kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
+	if (!vc_ctrl_req)
+		return -ENOMEM;
 
-	spin_lock(&vcrypto->ctrl_lock);
-	vcrypto->ctrl_status.status = VIRTIO_CRYPTO_ERR;
+	ctrl_status = &vc_ctrl_req->ctrl_status;
+	ctrl_status->status = VIRTIO_CRYPTO_ERR;
 	/* Pad ctrl header */
-	vcrypto->ctrl.header.opcode =
-		cpu_to_le32(VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION);
+	ctrl = &vc_ctrl_req->ctrl;
+	ctrl->header.opcode = cpu_to_le32(VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION);
 	/* Set the default virtqueue id to 0 */
-	vcrypto->ctrl.header.queue_id = 0;
+	ctrl->header.queue_id = 0;
 
-	destroy_session = &vcrypto->ctrl.u.destroy_session;
+	destroy_session = &ctrl->u.destroy_session;
 
 	if (encrypt)
-		destroy_session->session_id =
-			cpu_to_le64(ctx->enc_sess_info.session_id);
+		destroy_session->session_id = cpu_to_le64(ctx->enc_sess_info.session_id);
 	else
-		destroy_session->session_id =
-			cpu_to_le64(ctx->dec_sess_info.session_id);
+		destroy_session->session_id = cpu_to_le64(ctx->dec_sess_info.session_id);
 
-	sg_init_one(&outhdr, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
+	sg_init_one(&outhdr, ctrl, sizeof(*ctrl));
 	sgs[num_out++] = &outhdr;
 
 	/* Return status and session id back */
-	sg_init_one(&status_sg, &vcrypto->ctrl_status.status,
-		sizeof(vcrypto->ctrl_status.status));
+	sg_init_one(&status_sg, &ctrl_status->status, sizeof(ctrl_status->status));
 	sgs[num_out + num_in++] = &status_sg;
 
-	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
-			num_in, vcrypto, GFP_ATOMIC);
-	if (err < 0) {
-		spin_unlock(&vcrypto->ctrl_lock);
-		return err;
-	}
-	virtqueue_kick(vcrypto->ctrl_vq);
+	err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out, num_in, vc_ctrl_req);
+	if (err < 0)
+		goto out;
 
-	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &tmp) &&
-	       !virtqueue_is_broken(vcrypto->ctrl_vq))
-		cpu_relax();
-
-	if (vcrypto->ctrl_status.status != VIRTIO_CRYPTO_OK) {
-		spin_unlock(&vcrypto->ctrl_lock);
+	if (ctrl_status->status != VIRTIO_CRYPTO_OK) {
 		pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
-			vcrypto->ctrl_status.status,
-			destroy_session->session_id);
+			ctrl_status->status, destroy_session->session_id);
 
-		return -EINVAL;
+		err = -EINVAL;
+		goto out;
 	}
-	spin_unlock(&vcrypto->ctrl_lock);
 
-	return 0;
+	err = 0;
+out:
+	kfree(vc_ctrl_req);
+	return err;
 }
 
 static int virtio_crypto_alg_skcipher_init_sessions(
diff --git a/drivers/crypto/virtio/virtio_crypto_common.h b/drivers/crypto/virtio/virtio_crypto_common.h
index a24f85c589e7..d61c991d7773 100644
--- a/drivers/crypto/virtio/virtio_crypto_common.h
+++ b/drivers/crypto/virtio/virtio_crypto_common.h
@@ -10,9 +10,11 @@
 #include <linux/virtio.h>
 #include <linux/crypto.h>
 #include <linux/spinlock.h>
+#include <linux/interrupt.h>
 #include <crypto/aead.h>
 #include <crypto/aes.h>
 #include <crypto/engine.h>
+#include <uapi/linux/virtio_crypto.h>
 
 
 /* Internal representation of a data virtqueue */
@@ -27,6 +29,7 @@ struct data_queue {
 	char name[32];
 
 	struct crypto_engine *engine;
+	struct tasklet_struct done_task;
 };
 
 struct virtio_crypto {
@@ -56,6 +59,7 @@ struct virtio_crypto {
 	u32 mac_algo_l;
 	u32 mac_algo_h;
 	u32 aead_algo;
+	u32 akcipher_algo;
 
 	/* Maximum length of cipher key */
 	u32 max_cipher_key_len;
@@ -64,11 +68,6 @@ struct virtio_crypto {
 	/* Maximum size of per request */
 	u64 max_size;
 
-	/* Control VQ buffers: protected by the ctrl_lock */
-	struct virtio_crypto_op_ctrl_req ctrl;
-	struct virtio_crypto_session_input input;
-	struct virtio_crypto_inhdr ctrl_status;
-
 	unsigned long status;
 	atomic_t ref_count;
 	struct list_head list;
@@ -84,6 +83,18 @@ struct virtio_crypto_sym_session_info {
 	__u64 session_id;
 };
 
+/*
+ * Note: there are padding fields in request, clear them to zero before
+ *       sending to host to avoid to divulge any information.
+ * Ex, virtio_crypto_ctrl_request::ctrl::u::destroy_session::padding[48]
+ */
+struct virtio_crypto_ctrl_request {
+	struct virtio_crypto_op_ctrl_req ctrl;
+	struct virtio_crypto_session_input input;
+	struct virtio_crypto_inhdr ctrl_status;
+	struct completion compl;
+};
+
 struct virtio_crypto_request;
 typedef void (*virtio_crypto_data_callback)
 		(struct virtio_crypto_request *vc_req, int len);
@@ -131,5 +142,10 @@ static inline int virtio_crypto_get_current_node(void)
 
 int virtio_crypto_algs_register(struct virtio_crypto *vcrypto);
 void virtio_crypto_algs_unregister(struct virtio_crypto *vcrypto);
+int virtio_crypto_akcipher_algs_register(struct virtio_crypto *vcrypto);
+void virtio_crypto_akcipher_algs_unregister(struct virtio_crypto *vcrypto);
+int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto, struct scatterlist *sgs[],
+				  unsigned int out_sgs, unsigned int in_sgs,
+				  struct virtio_crypto_ctrl_request *vc_ctrl_req);
 
 #endif /* _VIRTIO_CRYPTO_COMMON_H */
diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index 080955a1dd9c..3da956145892 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -22,27 +22,78 @@ virtcrypto_clear_request(struct virtio_crypto_request *vc_req)
 	}
 }
 
-static void virtcrypto_dataq_callback(struct virtqueue *vq)
+static void virtio_crypto_ctrlq_callback(struct virtio_crypto_ctrl_request *vc_ctrl_req)
+{
+	complete(&vc_ctrl_req->compl);
+}
+
+static void virtcrypto_ctrlq_callback(struct virtqueue *vq)
 {
 	struct virtio_crypto *vcrypto = vq->vdev->priv;
-	struct virtio_crypto_request *vc_req;
+	struct virtio_crypto_ctrl_request *vc_ctrl_req;
 	unsigned long flags;
 	unsigned int len;
-	unsigned int qid = vq->index;
 
-	spin_lock_irqsave(&vcrypto->data_vq[qid].lock, flags);
+	spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
+	do {
+		virtqueue_disable_cb(vq);
+		while ((vc_ctrl_req = virtqueue_get_buf(vq, &len)) != NULL) {
+			spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
+			virtio_crypto_ctrlq_callback(vc_ctrl_req);
+			spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
+		}
+		if (unlikely(virtqueue_is_broken(vq)))
+			break;
+	} while (!virtqueue_enable_cb(vq));
+	spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
+}
+
+int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto, struct scatterlist *sgs[],
+		unsigned int out_sgs, unsigned int in_sgs,
+		struct virtio_crypto_ctrl_request *vc_ctrl_req)
+{
+	int err;
+	unsigned long flags;
+
+	init_completion(&vc_ctrl_req->compl);
+
+	spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
+	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, out_sgs, in_sgs, vc_ctrl_req, GFP_ATOMIC);
+	if (err < 0) {
+		spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
+		return err;
+	}
+
+	virtqueue_kick(vcrypto->ctrl_vq);
+	spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
+
+	wait_for_completion(&vc_ctrl_req->compl);
+
+	return 0;
+}
+
+static void virtcrypto_done_task(unsigned long data)
+{
+	struct data_queue *data_vq = (struct data_queue *)data;
+	struct virtqueue *vq = data_vq->vq;
+	struct virtio_crypto_request *vc_req;
+	unsigned int len;
+
 	do {
 		virtqueue_disable_cb(vq);
 		while ((vc_req = virtqueue_get_buf(vq, &len)) != NULL) {
-			spin_unlock_irqrestore(
-				&vcrypto->data_vq[qid].lock, flags);
 			if (vc_req->alg_cb)
 				vc_req->alg_cb(vc_req, len);
-			spin_lock_irqsave(
-				&vcrypto->data_vq[qid].lock, flags);
 		}
 	} while (!virtqueue_enable_cb(vq));
-	spin_unlock_irqrestore(&vcrypto->data_vq[qid].lock, flags);
+}
+
+static void virtcrypto_dataq_callback(struct virtqueue *vq)
+{
+	struct virtio_crypto *vcrypto = vq->vdev->priv;
+	struct data_queue *dq = &vcrypto->data_vq[vq->index];
+
+	tasklet_schedule(&dq->done_task);
 }
 
 static int virtcrypto_find_vqs(struct virtio_crypto *vi)
@@ -73,7 +124,7 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
 		goto err_names;
 
 	/* Parameters for control virtqueue */
-	callbacks[total_vqs - 1] = NULL;
+	callbacks[total_vqs - 1] = virtcrypto_ctrlq_callback;
 	names[total_vqs - 1] = "controlq";
 
 	/* Allocate/initialize parameters for data virtqueues */
@@ -99,6 +150,8 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
 			ret = -ENOMEM;
 			goto err_engine;
 		}
+		tasklet_init(&vi->data_vq[i].done_task, virtcrypto_done_task,
+				(unsigned long)&vi->data_vq[i]);
 	}
 
 	kfree(names);
@@ -297,6 +350,7 @@ static int virtcrypto_probe(struct virtio_device *vdev)
 	u32 mac_algo_l = 0;
 	u32 mac_algo_h = 0;
 	u32 aead_algo = 0;
+	u32 akcipher_algo = 0;
 	u32 crypto_services = 0;
 
 	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
@@ -348,6 +402,9 @@ static int virtcrypto_probe(struct virtio_device *vdev)
 			mac_algo_h, &mac_algo_h);
 	virtio_cread_le(vdev, struct virtio_crypto_config,
 			aead_algo, &aead_algo);
+	if (crypto_services & (1 << VIRTIO_CRYPTO_SERVICE_AKCIPHER))
+		virtio_cread_le(vdev, struct virtio_crypto_config,
+				akcipher_algo, &akcipher_algo);
 
 	/* Add virtio crypto device to global table */
 	err = virtcrypto_devmgr_add_dev(vcrypto);
@@ -374,7 +431,7 @@ static int virtcrypto_probe(struct virtio_device *vdev)
 	vcrypto->mac_algo_h = mac_algo_h;
 	vcrypto->hash_algo = hash_algo;
 	vcrypto->aead_algo = aead_algo;
-
+	vcrypto->akcipher_algo = akcipher_algo;
 
 	dev_info(&vdev->dev,
 		"max_queues: %u, max_cipher_key_len: %u, max_auth_key_len: %u, max_size 0x%llx\n",
@@ -431,11 +488,14 @@ static void virtcrypto_free_unused_reqs(struct virtio_crypto *vcrypto)
 static void virtcrypto_remove(struct virtio_device *vdev)
 {
 	struct virtio_crypto *vcrypto = vdev->priv;
+	int i;
 
 	dev_info(&vdev->dev, "Start virtcrypto_remove.\n");
 
 	if (virtcrypto_dev_started(vcrypto))
 		virtcrypto_dev_stop(vcrypto);
+	for (i = 0; i < vcrypto->max_data_queues; i++)
+		tasklet_kill(&vcrypto->data_vq[i].done_task);
 	vdev->config->reset(vdev);
 	virtcrypto_free_unused_reqs(vcrypto);
 	virtcrypto_clear_crypto_engines(vcrypto);
diff --git a/drivers/crypto/virtio/virtio_crypto_mgr.c b/drivers/crypto/virtio/virtio_crypto_mgr.c
index 6860f8180c7c..1cb92418b321 100644
--- a/drivers/crypto/virtio/virtio_crypto_mgr.c
+++ b/drivers/crypto/virtio/virtio_crypto_mgr.c
@@ -242,6 +242,12 @@ int virtcrypto_dev_start(struct virtio_crypto *vcrypto)
 		return -EFAULT;
 	}
 
+	if (virtio_crypto_akcipher_algs_register(vcrypto)) {
+		pr_err("virtio_crypto: Failed to register crypto akcipher algs\n");
+		virtio_crypto_algs_unregister(vcrypto);
+		return -EFAULT;
+	}
+
 	return 0;
 }
 
@@ -258,6 +264,7 @@ int virtcrypto_dev_start(struct virtio_crypto *vcrypto)
 void virtcrypto_dev_stop(struct virtio_crypto *vcrypto)
 {
 	virtio_crypto_algs_unregister(vcrypto);
+	virtio_crypto_akcipher_algs_unregister(vcrypto);
 }
 
 /*
@@ -312,6 +319,10 @@ bool virtcrypto_algo_is_supported(struct virtio_crypto *vcrypto,
 	case VIRTIO_CRYPTO_SERVICE_AEAD:
 		algo_mask = vcrypto->aead_algo;
 		break;
+
+	case VIRTIO_CRYPTO_SERVICE_AKCIPHER:
+		algo_mask = vcrypto->akcipher_algo;
+		break;
 	}
 
 	if (!(algo_mask & (1u << algo)))
diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index 0eb5eb97fd74..3b0e1fe27d93 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -1133,7 +1133,7 @@ static irqreturn_t thunderx_ocx_com_threaded_isr(int irq, void *irq_id)
 		decode_register(other, OCX_OTHER_SIZE,
 				ocx_com_errors, ctx->reg_com_int);
 
-		strncat(msg, other, OCX_MESSAGE_SIZE);
+		strlcat(msg, other, OCX_MESSAGE_SIZE);
 
 		for (lane = 0; lane < OCX_RX_LANES; lane++)
 			if (ctx->reg_com_int & BIT(lane)) {
@@ -1142,12 +1142,12 @@ static irqreturn_t thunderx_ocx_com_threaded_isr(int irq, void *irq_id)
 					 lane, ctx->reg_lane_int[lane],
 					 lane, ctx->reg_lane_stat11[lane]);
 
-				strncat(msg, other, OCX_MESSAGE_SIZE);
+				strlcat(msg, other, OCX_MESSAGE_SIZE);
 
 				decode_register(other, OCX_OTHER_SIZE,
 						ocx_lane_errors,
 						ctx->reg_lane_int[lane]);
-				strncat(msg, other, OCX_MESSAGE_SIZE);
+				strlcat(msg, other, OCX_MESSAGE_SIZE);
 			}
 
 		if (ctx->reg_com_int & OCX_COM_INT_CE)
@@ -1217,7 +1217,7 @@ static irqreturn_t thunderx_ocx_lnk_threaded_isr(int irq, void *irq_id)
 		decode_register(other, OCX_OTHER_SIZE,
 				ocx_com_link_errors, ctx->reg_com_link_int);
 
-		strncat(msg, other, OCX_MESSAGE_SIZE);
+		strlcat(msg, other, OCX_MESSAGE_SIZE);
 
 		if (ctx->reg_com_link_int & OCX_COM_LINK_INT_UE)
 			edac_device_handle_ue(ocx->edac_dev, 0, 0, msg);
@@ -1896,7 +1896,7 @@ static irqreturn_t thunderx_l2c_threaded_isr(int irq, void *irq_id)
 
 		decode_register(other, L2C_OTHER_SIZE, l2_errors, ctx->reg_int);
 
-		strncat(msg, other, L2C_MESSAGE_SIZE);
+		strlcat(msg, other, L2C_MESSAGE_SIZE);
 
 		if (ctx->reg_int & mask_ue)
 			edac_device_handle_ue(l2c->edac_dev, 0, 0, msg);
diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index ed27ff2e503e..7dff8833132d 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -313,11 +313,14 @@ static int __init meson_sm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, fw);
 
-	pr_info("secure-monitor enabled\n");
+	if (devm_of_platform_populate(dev))
+		goto out_in_base;
 
 	if (sysfs_create_group(&pdev->dev.kobj, &meson_sm_sysfs_attr_group))
 		goto out_in_base;
 
+	pr_info("secure-monitor enabled\n");
+
 	return 0;
 
 out_in_base:
diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index fe6be0771a07..b0576cec263b 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -161,7 +161,7 @@ static int ti_sci_debugfs_create(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct resource *res;
-	char debug_name[50] = "ti_sci_debug@";
+	char debug_name[50];
 
 	/* Debug region is optional */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
@@ -178,10 +178,10 @@ static int ti_sci_debugfs_create(struct platform_device *pdev,
 	/* Setup NULL termination */
 	info->debug_buffer[info->debug_region_size] = 0;
 
-	info->d = debugfs_create_file(strncat(debug_name, dev_name(dev),
-					      sizeof(debug_name) -
-					      sizeof("ti_sci_debug@")),
-				      0444, NULL, info, &ti_sci_debug_fops);
+	snprintf(debug_name, sizeof(debug_name), "ti_sci_debug@%s",
+		 dev_name(dev));
+	info->d = debugfs_create_file(debug_name, 0444, NULL, info,
+				      &ti_sci_debug_fops);
 	if (IS_ERR(info->d))
 		return PTR_ERR(info->d);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 48df32dd352e..8a1cb1de2b13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -459,6 +459,9 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	if (!adev->didt_rreg)
+		return -EOPNOTSUPP;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -518,6 +521,9 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	if (!adev->didt_wreg)
+		return -EOPNOTSUPP;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -576,7 +582,7 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
 	int r;
 
 	if (!adev->smc_rreg)
-		return -EPERM;
+		return -EOPNOTSUPP;
 
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
@@ -638,7 +644,7 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
 	int r;
 
 	if (!adev->smc_wreg)
-		return -EPERM;
+		return -EOPNOTSUPP;
 
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
index c8a5a5698edd..6eb6f05c1136 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
@@ -2733,10 +2733,8 @@ static int kv_parse_power_table(struct amdgpu_device *adev)
 		non_clock_info = (struct _ATOM_PPLIB_NONCLOCK_INFO *)
 			&non_clock_info_array->nonClockInfo[non_clock_array_index];
 		ps = kzalloc(sizeof(struct kv_ps), GFP_KERNEL);
-		if (ps == NULL) {
-			kfree(adev->pm.dpm.ps);
+		if (ps == NULL)
 			return -ENOMEM;
-		}
 		adev->pm.dpm.ps[i].ps_priv = ps;
 		k = 0;
 		idx = (u8 *)&power_state->v2.clockInfoIndex[0];
diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
index d6544a6dabc7..6f0653c81f8f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
@@ -7349,10 +7349,9 @@ static int si_dpm_init(struct amdgpu_device *adev)
 		kcalloc(4,
 			sizeof(struct amdgpu_clock_voltage_dependency_entry),
 			GFP_KERNEL);
-	if (!adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries) {
-		amdgpu_free_extended_power_table(adev);
+	if (!adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries)
 		return -ENOMEM;
-	}
+
 	adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.count = 4;
 	adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[0].clk = 0;
 	adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[0].v = 0;
diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index b4f7e7a7f7c5..9c905634fec7 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1637,7 +1637,7 @@ static int tc_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	} else {
 		if (tc->hpd_pin < 0 || tc->hpd_pin > 1) {
 			dev_err(dev, "failed to parse HPD number\n");
-			return ret;
+			return -EINVAL;
 		}
 	}
 
diff --git a/drivers/gpu/drm/bridge/ti-tpd12s015.c b/drivers/gpu/drm/bridge/ti-tpd12s015.c
index e0e015243a60..b588fea12502 100644
--- a/drivers/gpu/drm/bridge/ti-tpd12s015.c
+++ b/drivers/gpu/drm/bridge/ti-tpd12s015.c
@@ -179,7 +179,7 @@ static int tpd12s015_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __exit tpd12s015_remove(struct platform_device *pdev)
+static int tpd12s015_remove(struct platform_device *pdev)
 {
 	struct tpd12s015_device *tpd = platform_get_drvdata(pdev);
 
@@ -197,7 +197,7 @@ MODULE_DEVICE_TABLE(of, tpd12s015_of_match);
 
 static struct platform_driver tpd12s015_driver = {
 	.probe	= tpd12s015_probe,
-	.remove	= __exit_p(tpd12s015_remove),
+	.remove = tpd12s015_remove,
 	.driver	= {
 		.name	= "tpd12s015",
 		.of_match_table = tpd12s015_of_match,
diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index aecdd7ea26dc..4ed3fc28d4da 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -562,8 +562,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 	struct drm_mode_set set;
 	uint32_t __user *set_connectors_ptr;
 	struct drm_modeset_acquire_ctx ctx;
-	int ret;
-	int i;
+	int ret, i, num_connectors = 0;
 
 	if (!drm_core_check_feature(dev, DRIVER_MODESET))
 		return -EOPNOTSUPP;
@@ -721,6 +720,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 					connector->name);
 
 			connector_set[i] = connector;
+			num_connectors++;
 		}
 	}
 
@@ -729,7 +729,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 	set.y = crtc_req->y;
 	set.mode = mode;
 	set.connectors = connector_set;
-	set.num_connectors = crtc_req->count_connectors;
+	set.num_connectors = num_connectors;
 	set.fb = fb;
 
 	if (drm_drv_uses_atomic_modeset(dev))
@@ -742,7 +742,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 		drm_framebuffer_put(fb);
 
 	if (connector_set) {
-		for (i = 0; i < crtc_req->count_connectors; i++) {
+		for (i = 0; i < num_connectors; i++) {
 			if (connector_set[i])
 				drm_connector_put(connector_set[i]);
 		}
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 4ca995ce19af..10831d8d7148 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -892,8 +892,11 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
 			goto err_minors;
 	}
 
-	if (drm_core_check_feature(dev, DRIVER_MODESET))
-		drm_modeset_register_all(dev);
+	if (drm_core_check_feature(dev, DRIVER_MODESET)) {
+		ret = drm_modeset_register_all(dev);
+		if (ret)
+			goto err_unload;
+	}
 
 	ret = 0;
 
@@ -905,6 +908,9 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
 
 	goto out_unlock;
 
+err_unload:
+	if (dev->driver->unload)
+		dev->driver->unload(dev);
 err_minors:
 	remove_compat_control_link(dev);
 	drm_minor_unregister(dev, DRM_MINOR_PRIMARY);
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dma.c b/drivers/gpu/drm/exynos/exynos_drm_dma.c
index bf33c3084cb4..6b4d6da3b1f4 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dma.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dma.c
@@ -108,18 +108,16 @@ int exynos_drm_register_dma(struct drm_device *drm, struct device *dev,
 		return 0;
 
 	if (!priv->mapping) {
-		void *mapping;
+		void *mapping = NULL;
 
 		if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU))
 			mapping = arm_iommu_create_mapping(&platform_bus_type,
 				EXYNOS_DEV_ADDR_START, EXYNOS_DEV_ADDR_SIZE);
 		else if (IS_ENABLED(CONFIG_IOMMU_DMA))
 			mapping = iommu_get_domain_for_dev(priv->dma_dev);
-		else
-			mapping = ERR_PTR(-ENODEV);
 
-		if (IS_ERR(mapping))
-			return PTR_ERR(mapping);
+		if (!mapping)
+			return -ENODEV;
 		priv->mapping = mapping;
 	}
 
diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index dc01c188c0e0..981bffacda24 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1849,6 +1849,8 @@ static int hdmi_bind(struct device *dev, struct device *master, void *data)
 		return ret;
 
 	crtc = exynos_drm_crtc_get_by_type(drm_dev, EXYNOS_DISPLAY_TYPE_HDMI);
+	if (IS_ERR(crtc))
+		return PTR_ERR(crtc);
 	crtc->pipe_clk = &hdata->phy_clk;
 
 	ret = hdmi_create_connector(encoder);
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
index a0253297bc76..bf54b9e4fd61 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
@@ -268,6 +268,7 @@ static void mdp4_crtc_atomic_disable(struct drm_crtc *crtc,
 {
 	struct mdp4_crtc *mdp4_crtc = to_mdp4_crtc(crtc);
 	struct mdp4_kms *mdp4_kms = get_kms(crtc);
+	unsigned long flags;
 
 	DBG("%s", mdp4_crtc->name);
 
@@ -280,6 +281,14 @@ static void mdp4_crtc_atomic_disable(struct drm_crtc *crtc,
 	mdp_irq_unregister(&mdp4_kms->base, &mdp4_crtc->err);
 	mdp4_disable(mdp4_kms);
 
+	if (crtc->state->event && !crtc->state->active) {
+		WARN_ON(mdp4_crtc->event);
+		spin_lock_irqsave(&mdp4_kms->dev->event_lock, flags);
+		drm_crtc_send_vblank_event(crtc, crtc->state->event);
+		crtc->state->event = NULL;
+		spin_unlock_irqrestore(&mdp4_kms->dev->event_lock, flags);
+	}
+
 	mdp4_crtc->enabled = false;
 }
 
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index 2e0be85ec394..10eacfd95fb1 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -558,7 +558,9 @@ static int dsi_phy_enable_resource(struct msm_dsi_phy *phy)
 	struct device *dev = &phy->pdev->dev;
 	int ret;
 
-	pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
 
 	ret = clk_prepare_enable(phy->ahb_clk);
 	if (ret) {
diff --git a/drivers/gpu/drm/nouveau/nv04_fence.c b/drivers/gpu/drm/nouveau/nv04_fence.c
index 5b71a5a5cd85..cdbc75e3d1f6 100644
--- a/drivers/gpu/drm/nouveau/nv04_fence.c
+++ b/drivers/gpu/drm/nouveau/nv04_fence.c
@@ -39,7 +39,7 @@ struct nv04_fence_priv {
 static int
 nv04_fence_emit(struct nouveau_fence *fence)
 {
-	struct nvif_push *push = fence->channel->chan.push;
+	struct nvif_push *push = unrcu_pointer(fence->channel)->chan.push;
 	int ret = PUSH_WAIT(push, 2);
 	if (ret == 0) {
 		PUSH_NVSQ(push, NV_SW, 0x0150, fence->base.seqno);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c
index b1294d0076c0..72449bf613bf 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c
@@ -32,7 +32,7 @@ tu102_vmm_flush(struct nvkm_vmm *vmm, int depth)
 
 	type |= 0x00000001; /* PAGE_ALL */
 	if (atomic_read(&vmm->engref[NVKM_SUBDEV_BAR]))
-		type |= 0x00000004; /* HUB_ONLY */
+		type |= 0x00000006; /* HUB_ONLY | ALL PDB (hack) */
 
 	mutex_lock(&subdev->mutex);
 
diff --git a/drivers/gpu/drm/panel/panel-elida-kd35t133.c b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
index fe5ac3ef9018..9c1591f2920c 100644
--- a/drivers/gpu/drm/panel/panel-elida-kd35t133.c
+++ b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
@@ -111,6 +111,8 @@ static int kd35t133_unprepare(struct drm_panel *panel)
 		return ret;
 	}
 
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+
 	regulator_disable(ctx->iovcc);
 	regulator_disable(ctx->vdd);
 
diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index 24c8db673931..6e4600c21697 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -2313,7 +2313,7 @@ int r100_cs_track_check(struct radeon_device *rdev, struct r100_cs_track *track)
 	switch (prim_walk) {
 	case 1:
 		for (i = 0; i < track->num_arrays; i++) {
-			size = track->arrays[i].esize * track->max_indx * 4;
+			size = track->arrays[i].esize * track->max_indx * 4UL;
 			if (track->arrays[i].robj == NULL) {
 				DRM_ERROR("(PW %u) Vertex array %u no buffer "
 					  "bound\n", prim_walk, i);
@@ -2332,7 +2332,7 @@ int r100_cs_track_check(struct radeon_device *rdev, struct r100_cs_track *track)
 		break;
 	case 2:
 		for (i = 0; i < track->num_arrays; i++) {
-			size = track->arrays[i].esize * (nverts - 1) * 4;
+			size = track->arrays[i].esize * (nverts - 1) * 4UL;
 			if (track->arrays[i].robj == NULL) {
 				DRM_ERROR("(PW %u) Vertex array %u no buffer "
 					  "bound\n", prim_walk, i);
diff --git a/drivers/gpu/drm/radeon/r600_cs.c b/drivers/gpu/drm/radeon/r600_cs.c
index 390a9621604a..1e6ad9daff53 100644
--- a/drivers/gpu/drm/radeon/r600_cs.c
+++ b/drivers/gpu/drm/radeon/r600_cs.c
@@ -1276,7 +1276,7 @@ static int r600_cs_check_reg(struct radeon_cs_parser *p, u32 reg, u32 idx)
 			return -EINVAL;
 		}
 		tmp = (reg - CB_COLOR0_BASE) / 4;
-		track->cb_color_bo_offset[tmp] = radeon_get_ib_value(p, idx) << 8;
+		track->cb_color_bo_offset[tmp] = (u64)radeon_get_ib_value(p, idx) << 8;
 		ib[idx] += (u32)((reloc->gpu_offset >> 8) & 0xffffffff);
 		track->cb_color_base_last[tmp] = ib[idx];
 		track->cb_color_bo[tmp] = reloc->robj;
@@ -1303,7 +1303,7 @@ static int r600_cs_check_reg(struct radeon_cs_parser *p, u32 reg, u32 idx)
 					"0x%04X\n", reg);
 			return -EINVAL;
 		}
-		track->htile_offset = radeon_get_ib_value(p, idx) << 8;
+		track->htile_offset = (u64)radeon_get_ib_value(p, idx) << 8;
 		ib[idx] += (u32)((reloc->gpu_offset >> 8) & 0xffffffff);
 		track->htile_bo = reloc->robj;
 		track->db_dirty = true;
diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 71bdafac9210..07d23a1e62a0 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -689,11 +689,16 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 	if (radeon_crtc == NULL)
 		return;
 
+	radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc", WQ_HIGHPRI, 0);
+	if (!radeon_crtc->flip_queue) {
+		kfree(radeon_crtc);
+		return;
+	}
+
 	drm_crtc_init(dev, &radeon_crtc->base, &radeon_crtc_funcs);
 
 	drm_mode_crtc_set_gamma_size(&radeon_crtc->base, 256);
 	radeon_crtc->crtc_id = index;
-	radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc", WQ_HIGHPRI, 0);
 	rdev->mode_info.crtcs[index] = radeon_crtc;
 
 	if (rdev->family >= CHIP_BONAIRE) {
diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/radeon_vm.c
index 27b14eff532c..cb75ff1f6f2c 100644
--- a/drivers/gpu/drm/radeon/radeon_vm.c
+++ b/drivers/gpu/drm/radeon/radeon_vm.c
@@ -1206,13 +1206,17 @@ int radeon_vm_init(struct radeon_device *rdev, struct radeon_vm *vm)
 	r = radeon_bo_create(rdev, pd_size, align, true,
 			     RADEON_GEM_DOMAIN_VRAM, 0, NULL,
 			     NULL, &vm->page_directory);
-	if (r)
+	if (r) {
+		kfree(vm->page_tables);
+		vm->page_tables = NULL;
 		return r;
-
+	}
 	r = radeon_vm_clear_bo(rdev, vm->page_directory);
 	if (r) {
 		radeon_bo_unref(&vm->page_directory);
 		vm->page_directory = NULL;
+		kfree(vm->page_tables);
+		vm->page_tables = NULL;
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index 31e2c1083b08..e2eac766666e 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -3616,6 +3616,10 @@ static int si_cp_start(struct radeon_device *rdev)
 	for (i = RADEON_RING_TYPE_GFX_INDEX; i <= CAYMAN_RING_TYPE_CP2_INDEX; ++i) {
 		ring = &rdev->ring[i];
 		r = radeon_ring_lock(rdev, ring, 2);
+		if (r) {
+			DRM_ERROR("radeon: cp failed to lock ring (%d).\n", r);
+			return r;
+		}
 
 		/* clear the compute context state */
 		radeon_ring_write(ring, PACKET3_COMPUTE(PACKET3_CLEAR_STATE, 0));
diff --git a/drivers/gpu/drm/radeon/sumo_dpm.c b/drivers/gpu/drm/radeon/sumo_dpm.c
index b95d5d390caf..45d04996adf5 100644
--- a/drivers/gpu/drm/radeon/sumo_dpm.c
+++ b/drivers/gpu/drm/radeon/sumo_dpm.c
@@ -1493,8 +1493,10 @@ static int sumo_parse_power_table(struct radeon_device *rdev)
 		non_clock_array_index = power_state->v2.nonClockInfoIndex;
 		non_clock_info = (struct _ATOM_PPLIB_NONCLOCK_INFO *)
 			&non_clock_info_array->nonClockInfo[non_clock_array_index];
-		if (!rdev->pm.power_state[i].clock_info)
+		if (!rdev->pm.power_state[i].clock_info) {
+			kfree(rdev->pm.dpm.ps);
 			return -EINVAL;
+		}
 		ps = kzalloc(sizeof(struct sumo_ps), GFP_KERNEL);
 		if (ps == NULL) {
 			kfree(rdev->pm.dpm.ps);
diff --git a/drivers/gpu/drm/radeon/trinity_dpm.c b/drivers/gpu/drm/radeon/trinity_dpm.c
index 4d93b84aa739..49c28fbe366e 100644
--- a/drivers/gpu/drm/radeon/trinity_dpm.c
+++ b/drivers/gpu/drm/radeon/trinity_dpm.c
@@ -1770,8 +1770,10 @@ static int trinity_parse_power_table(struct radeon_device *rdev)
 		non_clock_array_index = power_state->v2.nonClockInfoIndex;
 		non_clock_info = (struct _ATOM_PPLIB_NONCLOCK_INFO *)
 			&non_clock_info_array->nonClockInfo[non_clock_array_index];
-		if (!rdev->pm.power_state[i].clock_info)
+		if (!rdev->pm.power_state[i].clock_info) {
+			kfree(rdev->pm.dpm.ps);
 			return -EINVAL;
+		}
 		ps = kzalloc(sizeof(struct sumo_ps), GFP_KERNEL);
 		if (ps == NULL) {
 			kfree(rdev->pm.dpm.ps);
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 1b5e5e9f577d..726a5d76615d 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2612,8 +2612,8 @@ static void wacom_wac_finger_slot(struct wacom_wac *wacom_wac,
 {
 	struct hid_data *hid_data = &wacom_wac->hid_data;
 	bool mt = wacom_wac->features.touch_max > 1;
-	bool prox = hid_data->tipswitch &&
-		    report_touch_events(wacom_wac);
+	bool touch_down = hid_data->tipswitch && hid_data->confidence;
+	bool prox = touch_down && report_touch_events(wacom_wac);
 
 	if (wacom_wac->shared->has_mute_touch_switch &&
 	    !wacom_wac->shared->is_touch_on) {
@@ -2652,24 +2652,6 @@ static void wacom_wac_finger_slot(struct wacom_wac *wacom_wac,
 	}
 }
 
-static bool wacom_wac_slot_is_active(struct input_dev *dev, int key)
-{
-	struct input_mt *mt = dev->mt;
-	struct input_mt_slot *s;
-
-	if (!mt)
-		return false;
-
-	for (s = mt->slots; s != mt->slots + mt->num_slots; s++) {
-		if (s->key == key &&
-			input_mt_get_value(s, ABS_MT_TRACKING_ID) >= 0) {
-			return true;
-		}
-	}
-
-	return false;
-}
-
 static void wacom_wac_finger_event(struct hid_device *hdev,
 		struct hid_field *field, struct hid_usage *usage, __s32 value)
 {
@@ -2717,14 +2699,8 @@ static void wacom_wac_finger_event(struct hid_device *hdev,
 	}
 
 	if (usage->usage_index + 1 == field->report_count) {
-		if (equivalent_usage == wacom_wac->hid_data.last_slot_field) {
-			bool touch_removed = wacom_wac_slot_is_active(wacom_wac->touch_input,
-				wacom_wac->hid_data.id) && !wacom_wac->hid_data.tipswitch;
-
-			if (wacom_wac->hid_data.confidence || touch_removed) {
-				wacom_wac_finger_slot(wacom_wac, wacom_wac->touch_input);
-			}
-		}
+		if (equivalent_usage == wacom_wac->hid_data.last_slot_field)
+			wacom_wac_finger_slot(wacom_wac, wacom_wac->touch_input);
 	}
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index eefc7371c6c4..2c994a8c4a76 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -440,7 +440,7 @@ struct etmv4_drvdata {
 	u8				ctxid_size;
 	u8				vmid_size;
 	u8				ccsize;
-	u8				ccitmin;
+	u16				ccitmin;
 	u8				s_ex_level;
 	u8				ns_ex_level;
 	u8				q_support;
diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 13c14eb175e9..6abcf975a2db 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -178,6 +178,7 @@ struct rk3x_i2c_soc_data {
  * @clk: function clk for rk3399 or function & Bus clks for others
  * @pclk: Bus clk for rk3399
  * @clk_rate_nb: i2c clk rate change notify
+ * @irq: irq number
  * @t: I2C known timing information
  * @lock: spinlock for the i2c bus
  * @wait: the waitqueue to wait for i2c transfer
@@ -200,6 +201,7 @@ struct rk3x_i2c {
 	struct clk *clk;
 	struct clk *pclk;
 	struct notifier_block clk_rate_nb;
+	int irq;
 
 	/* Settings */
 	struct i2c_timings t;
@@ -1087,13 +1089,18 @@ static int rk3x_i2c_xfer_common(struct i2c_adapter *adap,
 
 		spin_unlock_irqrestore(&i2c->lock, flags);
 
-		rk3x_i2c_start(i2c);
-
 		if (!polling) {
+			rk3x_i2c_start(i2c);
+
 			timeout = wait_event_timeout(i2c->wait, !i2c->busy,
 						     msecs_to_jiffies(WAIT_TIMEOUT));
 		} else {
+			disable_irq(i2c->irq);
+			rk3x_i2c_start(i2c);
+
 			timeout = rk3x_i2c_wait_xfer_poll(i2c);
+
+			enable_irq(i2c->irq);
 		}
 
 		spin_lock_irqsave(&i2c->lock, flags);
@@ -1301,6 +1308,8 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	i2c->irq = irq;
+
 	platform_set_drvdata(pdev, i2c);
 
 	if (i2c->soc_data->calc_timings == rk3x_i2c_v0_calc_timings) {
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 05831848b7bf..fd0969cd7dc6 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -223,8 +223,17 @@ static bool is_ack(struct s3c24xx_i2c *i2c)
 	int tries;
 
 	for (tries = 50; tries; --tries) {
-		if (readl(i2c->regs + S3C2410_IICCON)
-			& S3C2410_IICCON_IRQPEND) {
+		unsigned long tmp = readl(i2c->regs + S3C2410_IICCON);
+
+		if (!(tmp & S3C2410_IICCON_ACKEN)) {
+			/*
+			 * Wait a bit for the bus to stabilize,
+			 * delay estimated experimentally.
+			 */
+			usleep_range(100, 200);
+			return true;
+		}
+		if (tmp & S3C2410_IICCON_IRQPEND) {
 			if (!(readl(i2c->regs + S3C2410_IICSTAT)
 				& S3C2410_IICSTAT_LASTBIT))
 				return true;
@@ -277,16 +286,6 @@ static void s3c24xx_i2c_message_start(struct s3c24xx_i2c *i2c,
 
 	stat |= S3C2410_IICSTAT_START;
 	writel(stat, i2c->regs + S3C2410_IICSTAT);
-
-	if (i2c->quirks & QUIRK_POLL) {
-		while ((i2c->msg_num != 0) && is_ack(i2c)) {
-			i2c_s3c_irq_nextbyte(i2c, stat);
-			stat = readl(i2c->regs + S3C2410_IICSTAT);
-
-			if (stat & S3C2410_IICSTAT_ARBITR)
-				dev_err(i2c->dev, "deal with arbitration loss\n");
-		}
-	}
 }
 
 static inline void s3c24xx_i2c_stop(struct s3c24xx_i2c *i2c, int ret)
@@ -693,7 +692,7 @@ static void s3c24xx_i2c_wait_idle(struct s3c24xx_i2c *i2c)
 static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
 			      struct i2c_msg *msgs, int num)
 {
-	unsigned long timeout;
+	unsigned long timeout = 0;
 	int ret;
 
 	ret = s3c24xx_i2c_set_master(i2c);
@@ -713,16 +712,19 @@ static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
 	s3c24xx_i2c_message_start(i2c, msgs);
 
 	if (i2c->quirks & QUIRK_POLL) {
-		ret = i2c->msg_idx;
+		while ((i2c->msg_num != 0) && is_ack(i2c)) {
+			unsigned long stat = readl(i2c->regs + S3C2410_IICSTAT);
 
-		if (ret != num)
-			dev_dbg(i2c->dev, "incomplete xfer (%d)\n", ret);
+			i2c_s3c_irq_nextbyte(i2c, stat);
 
-		goto out;
+			stat = readl(i2c->regs + S3C2410_IICSTAT);
+			if (stat & S3C2410_IICSTAT_ARBITR)
+				dev_err(i2c->dev, "deal with arbitration loss\n");
+		}
+	} else {
+		timeout = wait_event_timeout(i2c->wait, i2c->msg_num == 0, HZ * 5);
 	}
 
-	timeout = wait_event_timeout(i2c->wait, i2c->msg_num == 0, HZ * 5);
-
 	ret = i2c->msg_idx;
 
 	/*
diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 63b4d6ea4566..811f04448d8d 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -174,8 +174,8 @@ static const struct iio_info ad7091r_info = {
 
 static irqreturn_t ad7091r_event_handler(int irq, void *private)
 {
-	struct ad7091r_state *st = (struct ad7091r_state *) private;
-	struct iio_dev *iio_dev = dev_get_drvdata(st->dev);
+	struct iio_dev *iio_dev = private;
+	struct ad7091r_state *st = iio_priv(iio_dev);
 	unsigned int i, read_val;
 	int ret;
 	s64 timestamp = iio_get_time_ns(iio_dev);
@@ -234,7 +234,7 @@ int ad7091r_probe(struct device *dev, const char *name,
 	if (irq) {
 		ret = devm_request_threaded_irq(dev, irq, NULL,
 				ad7091r_event_handler,
-				IRQF_TRIGGER_FALLING | IRQF_ONESHOT, name, st);
+				IRQF_TRIGGER_FALLING | IRQF_ONESHOT, name, iio_dev);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 19a45dd43796..6b9627bfebb0 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -119,9 +119,9 @@ struct ad9467_state {
 	struct spi_device		*spi;
 	struct clk			*clk;
 	unsigned int			output_mode;
+	unsigned int                    (*scales)[2];
 
 	struct gpio_desc		*pwrdown_gpio;
-	struct gpio_desc		*reset_gpio;
 };
 
 static int ad9467_spi_read(struct spi_device *spi, unsigned int reg)
@@ -163,9 +163,10 @@ static int ad9467_reg_access(struct adi_axi_adc_conv *conv, unsigned int reg,
 
 	if (readval == NULL) {
 		ret = ad9467_spi_write(spi, reg, writeval);
-		ad9467_spi_write(spi, AN877_ADC_REG_TRANSFER,
-				 AN877_ADC_TRANSFER_SYNC);
-		return ret;
+		if (ret)
+			return ret;
+		return ad9467_spi_write(spi, AN877_ADC_REG_TRANSFER,
+					AN877_ADC_TRANSFER_SYNC);
 	}
 
 	ret = ad9467_spi_read(spi, reg);
@@ -212,6 +213,7 @@ static void __ad9467_get_scale(struct adi_axi_adc_conv *conv, int index,
 	.channel = _chan,						\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE), \
 	.scan_index = _si,						\
 	.scan_type = {							\
 		.sign = _sign,						\
@@ -273,10 +275,13 @@ static int ad9467_get_scale(struct adi_axi_adc_conv *conv, int *val, int *val2)
 	const struct ad9467_chip_info *info1 = to_ad9467_chip_info(info);
 	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
 	unsigned int i, vref_val;
+	int ret;
 
-	vref_val = ad9467_spi_read(st->spi, AN877_ADC_REG_VREF);
+	ret = ad9467_spi_read(st->spi, AN877_ADC_REG_VREF);
+	if (ret < 0)
+		return ret;
 
-	vref_val &= info1->vref_mask;
+	vref_val = ret & info1->vref_mask;
 
 	for (i = 0; i < info->num_scales; i++) {
 		if (vref_val == info->scale_table[i][1])
@@ -297,6 +302,7 @@ static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
 	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
 	unsigned int scale_val[2];
 	unsigned int i;
+	int ret;
 
 	if (val != 0)
 		return -EINVAL;
@@ -306,11 +312,13 @@ static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
 		if (scale_val[0] != val || scale_val[1] != val2)
 			continue;
 
-		ad9467_spi_write(st->spi, AN877_ADC_REG_VREF,
-				 info->scale_table[i][1]);
-		ad9467_spi_write(st->spi, AN877_ADC_REG_TRANSFER,
-				 AN877_ADC_TRANSFER_SYNC);
-		return 0;
+		ret = ad9467_spi_write(st->spi, AN877_ADC_REG_VREF,
+				       info->scale_table[i][1]);
+		if (ret < 0)
+			return ret;
+
+		return ad9467_spi_write(st->spi, AN877_ADC_REG_TRANSFER,
+					AN877_ADC_TRANSFER_SYNC);
 	}
 
 	return -EINVAL;
@@ -359,6 +367,26 @@ static int ad9467_write_raw(struct adi_axi_adc_conv *conv,
 	}
 }
 
+static int ad9467_read_avail(struct adi_axi_adc_conv *conv,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
+{
+	const struct adi_axi_adc_chip_info *info = conv->chip_info;
+	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (const int *)st->scales;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		/* Values are stored in a 2D matrix */
+		*length = info->num_scales * 2;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int ad9467_outputmode_set(struct spi_device *spi, unsigned int mode)
 {
 	int ret;
@@ -371,6 +399,26 @@ static int ad9467_outputmode_set(struct spi_device *spi, unsigned int mode)
 				AN877_ADC_TRANSFER_SYNC);
 }
 
+static int ad9467_scale_fill(struct adi_axi_adc_conv *conv)
+{
+	const struct adi_axi_adc_chip_info *info = conv->chip_info;
+	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
+	unsigned int i, val1, val2;
+
+	st->scales = devm_kmalloc_array(&st->spi->dev, info->num_scales,
+					sizeof(*st->scales), GFP_KERNEL);
+	if (!st->scales)
+		return -ENOMEM;
+
+	for (i = 0; i < info->num_scales; i++) {
+		__ad9467_get_scale(conv, i, &val1, &val2);
+		st->scales[i][0] = val1;
+		st->scales[i][1] = val2;
+	}
+
+	return 0;
+}
+
 static int ad9467_preenable_setup(struct adi_axi_adc_conv *conv)
 {
 	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
@@ -378,11 +426,19 @@ static int ad9467_preenable_setup(struct adi_axi_adc_conv *conv)
 	return ad9467_outputmode_set(st->spi, st->output_mode);
 }
 
-static void ad9467_clk_disable(void *data)
+static int ad9467_reset(struct device *dev)
 {
-	struct ad9467_state *st = data;
+	struct gpio_desc *gpio;
 
-	clk_disable_unprepare(st->clk);
+	gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR_OR_NULL(gpio))
+		return PTR_ERR_OR_ZERO(gpio);
+
+	fsleep(1);
+	gpiod_set_value_cansleep(gpio, 0);
+	fsleep(10 * USEC_PER_MSEC);
+
+	return 0;
 }
 
 static int ad9467_probe(struct spi_device *spi)
@@ -404,40 +460,27 @@ static int ad9467_probe(struct spi_device *spi)
 	st = adi_axi_adc_conv_priv(conv);
 	st->spi = spi;
 
-	st->clk = devm_clk_get(&spi->dev, "adc-clk");
+	st->clk = devm_clk_get_enabled(&spi->dev, "adc-clk");
 	if (IS_ERR(st->clk))
 		return PTR_ERR(st->clk);
 
-	ret = clk_prepare_enable(st->clk);
-	if (ret < 0)
-		return ret;
-
-	ret = devm_add_action_or_reset(&spi->dev, ad9467_clk_disable, st);
-	if (ret)
-		return ret;
-
 	st->pwrdown_gpio = devm_gpiod_get_optional(&spi->dev, "powerdown",
 						   GPIOD_OUT_LOW);
 	if (IS_ERR(st->pwrdown_gpio))
 		return PTR_ERR(st->pwrdown_gpio);
 
-	st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
-						 GPIOD_OUT_LOW);
-	if (IS_ERR(st->reset_gpio))
-		return PTR_ERR(st->reset_gpio);
-
-	if (st->reset_gpio) {
-		udelay(1);
-		ret = gpiod_direction_output(st->reset_gpio, 1);
-		if (ret)
-			return ret;
-		mdelay(10);
-	}
+	ret = ad9467_reset(&spi->dev);
+	if (ret)
+		return ret;
 
 	spi_set_drvdata(spi, st);
 
 	conv->chip_info = &info->axi_adc_info;
 
+	ret = ad9467_scale_fill(conv);
+	if (ret)
+		return ret;
+
 	id = ad9467_spi_read(spi, AN877_ADC_REG_CHIP_ID);
 	if (id != conv->chip_info->id) {
 		dev_err(&spi->dev, "Mismatch CHIP_ID, got 0x%X, expected 0x%X\n",
@@ -448,6 +491,7 @@ static int ad9467_probe(struct spi_device *spi)
 	conv->reg_access = ad9467_reg_access;
 	conv->write_raw = ad9467_write_raw;
 	conv->read_raw = ad9467_read_raw;
+	conv->read_avail = ad9467_read_avail;
 	conv->preenable_setup = ad9467_preenable_setup;
 
 	st->output_mode = info->default_output_mode |
diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index cbe1011a2408..d721fb1bcae7 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -150,6 +150,20 @@ static int adi_axi_adc_write_raw(struct iio_dev *indio_dev,
 	return conv->write_raw(conv, chan, val, val2, mask);
 }
 
+static int adi_axi_adc_read_avail(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  const int **vals, int *type, int *length,
+				  long mask)
+{
+	struct adi_axi_adc_state *st = iio_priv(indio_dev);
+	struct adi_axi_adc_conv *conv = &st->client->conv;
+
+	if (!conv->read_avail)
+		return -EOPNOTSUPP;
+
+	return conv->read_avail(conv, chan, vals, type, length, mask);
+}
+
 static int adi_axi_adc_update_scan_mode(struct iio_dev *indio_dev,
 					const unsigned long *scan_mask)
 {
@@ -238,69 +252,11 @@ struct adi_axi_adc_conv *devm_adi_axi_adc_conv_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_adi_axi_adc_conv_register);
 
-static ssize_t in_voltage_scale_available_show(struct device *dev,
-					       struct device_attribute *attr,
-					       char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct adi_axi_adc_state *st = iio_priv(indio_dev);
-	struct adi_axi_adc_conv *conv = &st->client->conv;
-	size_t len = 0;
-	int i;
-
-	for (i = 0; i < conv->chip_info->num_scales; i++) {
-		const unsigned int *s = conv->chip_info->scale_table[i];
-
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-				 "%u.%06u ", s[0], s[1]);
-	}
-	buf[len - 1] = '\n';
-
-	return len;
-}
-
-static IIO_DEVICE_ATTR_RO(in_voltage_scale_available, 0);
-
-enum {
-	ADI_AXI_ATTR_SCALE_AVAIL,
-};
-
-#define ADI_AXI_ATTR(_en_, _file_)			\
-	[ADI_AXI_ATTR_##_en_] = &iio_dev_attr_##_file_.dev_attr.attr
-
-static struct attribute *adi_axi_adc_attributes[] = {
-	ADI_AXI_ATTR(SCALE_AVAIL, in_voltage_scale_available),
-	NULL
-};
-
-static umode_t axi_adc_attr_is_visible(struct kobject *kobj,
-				       struct attribute *attr, int n)
-{
-	struct device *dev = kobj_to_dev(kobj);
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct adi_axi_adc_state *st = iio_priv(indio_dev);
-	struct adi_axi_adc_conv *conv = &st->client->conv;
-
-	switch (n) {
-	case ADI_AXI_ATTR_SCALE_AVAIL:
-		if (!conv->chip_info->num_scales)
-			return 0;
-		return attr->mode;
-	default:
-		return attr->mode;
-	}
-}
-
-static const struct attribute_group adi_axi_adc_attribute_group = {
-	.attrs = adi_axi_adc_attributes,
-	.is_visible = axi_adc_attr_is_visible,
-};
-
 static const struct iio_info adi_axi_adc_info = {
 	.read_raw = &adi_axi_adc_read_raw,
 	.write_raw = &adi_axi_adc_write_raw,
-	.attrs = &adi_axi_adc_attribute_group,
 	.update_scan_mode = &adi_axi_adc_update_scan_mode,
+	.read_avail = &adi_axi_adc_read_avail,
 };
 
 static const struct adi_axi_adc_core_info adi_axi_adc_10_0_a_info = {
diff --git a/drivers/infiniband/hw/mthca/mthca_cmd.c b/drivers/infiniband/hw/mthca/mthca_cmd.c
index bdf5ed38de22..0307c45aa6d3 100644
--- a/drivers/infiniband/hw/mthca/mthca_cmd.c
+++ b/drivers/infiniband/hw/mthca/mthca_cmd.c
@@ -635,7 +635,7 @@ void mthca_free_mailbox(struct mthca_dev *dev, struct mthca_mailbox *mailbox)
 
 int mthca_SYS_EN(struct mthca_dev *dev)
 {
-	u64 out;
+	u64 out = 0;
 	int ret;
 
 	ret = mthca_cmd_imm(dev, 0, &out, 0, 0, CMD_SYS_EN, CMD_TIME_CLASS_D);
@@ -1955,7 +1955,7 @@ int mthca_WRITE_MGM(struct mthca_dev *dev, int index,
 int mthca_MGID_HASH(struct mthca_dev *dev, struct mthca_mailbox *mailbox,
 		    u16 *hash)
 {
-	u64 imm;
+	u64 imm = 0;
 	int err;
 
 	err = mthca_cmd_imm(dev, mailbox->dma, &imm, 0, 0, CMD_MGID_HASH,
diff --git a/drivers/infiniband/hw/mthca/mthca_main.c b/drivers/infiniband/hw/mthca/mthca_main.c
index fe9654a7af71..3acd1372c814 100644
--- a/drivers/infiniband/hw/mthca/mthca_main.c
+++ b/drivers/infiniband/hw/mthca/mthca_main.c
@@ -382,7 +382,7 @@ static int mthca_init_icm(struct mthca_dev *mdev,
 			  struct mthca_init_hca_param *init_hca,
 			  u64 icm_size)
 {
-	u64 aux_pages;
+	u64 aux_pages = 0;
 	int err;
 
 	err = mthca_SET_ICM_SIZE(mdev, icm_size, &aux_pages);
diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
index 78ee9445f801..45a2d2b82b09 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.h
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
@@ -322,12 +322,10 @@ struct iser_device {
  *
  * @mr:         memory region
  * @sig_mr:     signature memory region
- * @mr_valid:   is mr valid indicator
  */
 struct iser_reg_resources {
 	struct ib_mr                     *mr;
 	struct ib_mr                     *sig_mr;
-	u8				  mr_valid:1;
 };
 
 /**
diff --git a/drivers/infiniband/ulp/iser/iser_initiator.c b/drivers/infiniband/ulp/iser/iser_initiator.c
index 27a6f75a9912..9ea88dd6a414 100644
--- a/drivers/infiniband/ulp/iser/iser_initiator.c
+++ b/drivers/infiniband/ulp/iser/iser_initiator.c
@@ -602,7 +602,10 @@ iser_inv_desc(struct iser_fr_desc *desc, u32 rkey)
 		return -EINVAL;
 	}
 
-	desc->rsc.mr_valid = 0;
+	if (desc->sig_protected)
+		desc->rsc.sig_mr->need_inval = false;
+	else
+		desc->rsc.mr->need_inval = false;
 
 	return 0;
 }
diff --git a/drivers/infiniband/ulp/iser/iser_memory.c b/drivers/infiniband/ulp/iser/iser_memory.c
index d4e057fac219..519fea5ec3a1 100644
--- a/drivers/infiniband/ulp/iser/iser_memory.c
+++ b/drivers/infiniband/ulp/iser/iser_memory.c
@@ -250,7 +250,7 @@ iser_reg_sig_mr(struct iscsi_iser_task *iser_task,
 
 	iser_set_prot_checks(iser_task->sc, &sig_attrs->check_mask);
 
-	if (rsc->mr_valid)
+	if (rsc->sig_mr->need_inval)
 		iser_inv_rkey(&tx_desc->inv_wr, mr, cqe, &wr->wr);
 
 	ib_update_fast_reg_key(mr, ib_inc_rkey(mr->rkey));
@@ -274,7 +274,7 @@ iser_reg_sig_mr(struct iscsi_iser_task *iser_task,
 	wr->access = IB_ACCESS_LOCAL_WRITE |
 		     IB_ACCESS_REMOTE_READ |
 		     IB_ACCESS_REMOTE_WRITE;
-	rsc->mr_valid = 1;
+	rsc->sig_mr->need_inval = true;
 
 	sig_reg->sge.lkey = mr->lkey;
 	sig_reg->rkey = mr->rkey;
@@ -299,7 +299,7 @@ static int iser_fast_reg_mr(struct iscsi_iser_task *iser_task,
 	struct ib_reg_wr *wr = &tx_desc->reg_wr;
 	int n;
 
-	if (rsc->mr_valid)
+	if (rsc->mr->need_inval)
 		iser_inv_rkey(&tx_desc->inv_wr, mr, cqe, &wr->wr);
 
 	ib_update_fast_reg_key(mr, ib_inc_rkey(mr->rkey));
@@ -322,7 +322,7 @@ static int iser_fast_reg_mr(struct iscsi_iser_task *iser_task,
 		     IB_ACCESS_REMOTE_WRITE |
 		     IB_ACCESS_REMOTE_READ;
 
-	rsc->mr_valid = 1;
+	rsc->mr->need_inval = true;
 
 	reg->sge.lkey = mr->lkey;
 	reg->rkey = mr->rkey;
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index 2bd18b006893..b5127479860d 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -136,7 +136,6 @@ iser_create_fastreg_desc(struct iser_device *device,
 			goto err_alloc_mr_integrity;
 		}
 	}
-	desc->rsc.mr_valid = 0;
 
 	return desc;
 
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index beedad0fe09a..239471cf7e4c 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -266,6 +266,7 @@ static const struct xpad_device {
 	{ 0x146b, 0x0604, "Bigben Interactive DAIJA Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x1532, 0x0a00, "Razer Atrox Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x1532, 0x0a03, "Razer Wildcat", 0, XTYPE_XBOXONE },
+	{ 0x1532, 0x0a29, "Razer Wolverine V2", 0, XTYPE_XBOXONE },
 	{ 0x15e4, 0x3f00, "Power A Mini Pro Elite", 0, XTYPE_XBOX360 },
 	{ 0x15e4, 0x3f0a, "Xbox Airflo wired controller", 0, XTYPE_XBOX360 },
 	{ 0x15e4, 0x3f10, "Batarang Xbox 360 controller", 0, XTYPE_XBOX360 },
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index edc613efc158..4912582c54da 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -756,6 +756,44 @@ static void atkbd_deactivate(struct atkbd *atkbd)
 			ps2dev->serio->phys);
 }
 
+#ifdef CONFIG_X86
+static bool atkbd_is_portable_device(void)
+{
+	static const char * const chassis_types[] = {
+		"8",	/* Portable */
+		"9",	/* Laptop */
+		"10",	/* Notebook */
+		"14",	/* Sub-Notebook */
+		"31",	/* Convertible */
+		"32",	/* Detachable */
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(chassis_types); i++)
+		if (dmi_match(DMI_CHASSIS_TYPE, chassis_types[i]))
+			return true;
+
+	return false;
+}
+
+/*
+ * On many modern laptops ATKBD_CMD_GETID may cause problems, on these laptops
+ * the controller is always in translated mode. In this mode mice/touchpads will
+ * not work. So in this case simply assume a keyboard is connected to avoid
+ * confusing some laptop keyboards.
+ *
+ * Skipping ATKBD_CMD_GETID ends up using a fake keyboard id. Using the standard
+ * 0xab83 id is ok in translated mode, only atkbd_select_set() checks atkbd->id
+ * and in translated mode that is a no-op.
+ */
+static bool atkbd_skip_getid(struct atkbd *atkbd)
+{
+	return atkbd->translated && atkbd_is_portable_device();
+}
+#else
+static inline bool atkbd_skip_getid(struct atkbd *atkbd) { return false; }
+#endif
+
 /*
  * atkbd_probe() probes for an AT keyboard on a serio port.
  */
@@ -764,6 +802,7 @@ static int atkbd_probe(struct atkbd *atkbd)
 {
 	struct ps2dev *ps2dev = &atkbd->ps2dev;
 	unsigned char param[2];
+	bool skip_getid;
 
 /*
  * Some systems, where the bit-twiddling when testing the io-lines of the
@@ -785,17 +824,18 @@ static int atkbd_probe(struct atkbd *atkbd)
  */
 
 	param[0] = param[1] = 0xa5;	/* initialize with invalid values */
-	if (ps2_command(ps2dev, param, ATKBD_CMD_GETID)) {
+	skip_getid = atkbd_skip_getid(atkbd);
+	if (skip_getid || ps2_command(ps2dev, param, ATKBD_CMD_GETID)) {
 
 /*
- * If the get ID command failed, we check if we can at least set the LEDs on
- * the keyboard. This should work on every keyboard out there. It also turns
- * the LEDs off, which we want anyway.
+ * If the get ID command was skipped or failed, we check if we can at least set
+ * the LEDs on the keyboard. This should work on every keyboard out there.
+ * It also turns the LEDs off, which we want anyway.
  */
 		param[0] = 0;
 		if (ps2_command(ps2dev, param, ATKBD_CMD_SETLEDS))
 			return -1;
-		atkbd->id = 0xabba;
+		atkbd->id = skip_getid ? 0xab83 : 0xabba;
 		return 0;
 	}
 
diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 09528c0a8a34..124ab98ea43a 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -351,6 +351,14 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		},
 		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
 	},
+	{
+		/* Acer TravelMate P459-G2-M */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate P459-G2-M"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
 	{
 		/* Amoi M636/A737 */
 		.matches = {
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 1598a1ddbf69..a5164d5cb6a3 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -21,6 +21,7 @@ static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
 
 static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,adreno" },
+	{ .compatible = "qcom,adreno-gmu" },
 	{ .compatible = "qcom,mdp4" },
 	{ .compatible = "qcom,mdss" },
 	{ .compatible = "qcom,sc7180-mdss" },
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index ad84be4f6817..03c4c5e4d35c 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -116,6 +116,7 @@ config LEDS_AS3645A
 config LEDS_AW2013
 	tristate "LED support for Awinic AW2013"
 	depends on LEDS_CLASS && I2C && OF
+	select REGMAP_I2C
 	help
 	  This option enables support for the AW2013 3-channel
 	  LED driver.
diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index 2ff8a1b776fb..3a83e8e09256 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -114,6 +114,8 @@ static int dvb_device_open(struct inode *inode, struct file *file)
 			err = file->f_op->open(inode, file);
 		up_read(&minor_rwsem);
 		mutex_unlock(&dvbdev_mutex);
+		if (err)
+			dvb_device_put(dvbdev);
 		return err;
 	}
 fail:
diff --git a/drivers/media/dvb-frontends/m88ds3103.c b/drivers/media/dvb-frontends/m88ds3103.c
index ff106d6ece68..94c6cc59372c 100644
--- a/drivers/media/dvb-frontends/m88ds3103.c
+++ b/drivers/media/dvb-frontends/m88ds3103.c
@@ -1898,7 +1898,7 @@ static int m88ds3103_probe(struct i2c_client *client,
 		/* get frontend address */
 		ret = regmap_read(dev->regmap, 0x29, &utmp);
 		if (ret)
-			goto err_kfree;
+			goto err_del_adapters;
 		dev->dt_addr = ((utmp & 0x80) == 0) ? 0x42 >> 1 : 0x40 >> 1;
 		dev_dbg(&client->dev, "dt addr is 0x%02x\n", dev->dt_addr);
 
@@ -1906,11 +1906,14 @@ static int m88ds3103_probe(struct i2c_client *client,
 						      dev->dt_addr);
 		if (IS_ERR(dev->dt_client)) {
 			ret = PTR_ERR(dev->dt_client);
-			goto err_kfree;
+			goto err_del_adapters;
 		}
 	}
 
 	return 0;
+
+err_del_adapters:
+	i2c_mux_del_adapters(dev->muxc);
 err_kfree:
 	kfree(dev);
 err:
diff --git a/drivers/media/usb/cx231xx/cx231xx-core.c b/drivers/media/usb/cx231xx/cx231xx-core.c
index 05d91caaed0c..46e34225b45c 100644
--- a/drivers/media/usb/cx231xx/cx231xx-core.c
+++ b/drivers/media/usb/cx231xx/cx231xx-core.c
@@ -1024,6 +1024,7 @@ int cx231xx_init_isoc(struct cx231xx *dev, int max_packets,
 	if (!dev->video_mode.isoc_ctl.urb) {
 		dev_err(dev->dev,
 			"cannot alloc memory for usb buffers\n");
+		kfree(dma_q->p_left_data);
 		return -ENOMEM;
 	}
 
@@ -1033,6 +1034,7 @@ int cx231xx_init_isoc(struct cx231xx *dev, int max_packets,
 		dev_err(dev->dev,
 			"cannot allocate memory for usbtransfer\n");
 		kfree(dev->video_mode.isoc_ctl.urb);
+		kfree(dma_q->p_left_data);
 		return -ENOMEM;
 	}
 
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-context.c b/drivers/media/usb/pvrusb2/pvrusb2-context.c
index 14170a5d72b3..1764674de98b 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-context.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-context.c
@@ -268,7 +268,8 @@ void pvr2_context_disconnect(struct pvr2_context *mp)
 {
 	pvr2_hdw_disconnect(mp->hdw);
 	mp->disconnect_flag = !0;
-	pvr2_context_notify(mp);
+	if (!pvr2_context_shutok())
+		pvr2_context_notify(mp);
 }
 
 
diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index df5cebb372a5..60f74144a4f8 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -103,6 +103,10 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 
 	syscon_config.name = kasprintf(GFP_KERNEL, "%pOFn@%llx", np,
 				       (u64)res.start);
+	if (!syscon_config.name) {
+		ret = -ENOMEM;
+		goto err_regmap;
+	}
 	syscon_config.reg_stride = reg_io_width;
 	syscon_config.val_bits = reg_io_width * 8;
 	syscon_config.max_register = resource_size(&res) - reg_io_width;
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index a5b2bf0e40cc..8fe4a0fd6ef1 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -1065,14 +1065,15 @@ config MMC_SDHCI_XENON
 
 config MMC_SDHCI_OMAP
 	tristate "TI SDHCI Controller Support"
+	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM && OF
 	select THERMAL
 	imply TI_SOC_THERMAL
 	select MMC_SDHCI_EXTERNAL_DMA if DMA_ENGINE
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
-	  support present in TI's DRA7 SOCs. The controller supports
-	  SD/MMC/SDIO devices.
+	  support present in TI's Keystone/OMAP2+/DRA7 SOCs. The controller
+	  supports SD/MMC/SDIO devices.
 
 	  If you have a controller with this interface, say Y or M here.
 
@@ -1080,14 +1081,15 @@ config MMC_SDHCI_OMAP
 
 config MMC_SDHCI_AM654
 	tristate "Support for the SDHCI Controller in TI's AM654 SOCs"
+	depends on ARCH_K3 || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM && OF
 	select MMC_SDHCI_IO_ACCESSORS
 	select MMC_CQHCI
 	select REGMAP_MMIO
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
-	  support present in TI's AM654 SOCs. The controller supports
-	  SD/MMC/SDIO devices.
+	  support present in TI's AM65x/AM64x/AM62x/J721E SOCs. The controller
+	  supports SD/MMC/SDIO devices.
 
 	  If you have a controller with this interface, say Y or M here.
 
diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 0c05f77f9b21..dd0d0bf5f57f 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -533,7 +533,7 @@ static void blktrans_notify_add(struct mtd_info *mtd)
 {
 	struct mtd_blktrans_ops *tr;
 
-	if (mtd->type == MTD_ABSENT)
+	if (mtd->type == MTD_ABSENT || mtd->type == MTD_UBIVOLUME)
 		return;
 
 	list_for_each_entry(tr, &blktrans_majors, list)
@@ -576,7 +576,7 @@ int register_mtd_blktrans(struct mtd_blktrans_ops *tr)
 	list_add(&tr->list, &blktrans_majors);
 
 	mtd_for_each_device(mtd)
-		if (mtd->type != MTD_ABSENT)
+		if (mtd->type != MTD_ABSENT && mtd->type != MTD_UBIVOLUME)
 			tr->add_mtd(tr, mtd);
 
 	mutex_unlock(&mtd_table_mutex);
diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index e345f9d9f8e8..fcda744e8a40 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -21,7 +21,7 @@
 
 #define ERR_BYTE		0xFF /* Value returned for read
 					bytes when read failed	*/
-#define IFC_TIMEOUT_MSECS	500  /* Maximum number of mSecs to wait
+#define IFC_TIMEOUT_MSECS	1000 /* Maximum timeout to wait
 					for IFC NAND Machine	*/
 
 struct fsl_ifc_ctrl;
diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 80eadf509c0a..018988b95035 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1119,6 +1119,8 @@ static int vsc73xx_gpio_probe(struct vsc73xx *vsc)
 
 	vsc->gc.label = devm_kasprintf(vsc->dev, GFP_KERNEL, "VSC%04x",
 				       vsc->chipid);
+	if (!vsc->gc.label)
+		return -ENOMEM;
 	vsc->gc.ngpio = 4;
 	vsc->gc.owner = THIS_MODULE;
 	vsc->gc.parent = vsc->dev;
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index b010f28b0abf..fe2c9b110e60 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -6454,6 +6454,14 @@ static void tg3_dump_state(struct tg3 *tp)
 	int i;
 	u32 *regs;
 
+	/* If it is a PCI error, all registers will be 0xffff,
+	 * we don't dump them out, just report the error and return
+	 */
+	if (tp->pdev->error_state != pci_channel_io_normal) {
+		netdev_err(tp->dev, "PCI channel ERROR!\n");
+		return;
+	}
+
 	regs = kzalloc(TG3_REG_BLK_SIZE, GFP_ATOMIC);
 	if (!regs)
 		return;
@@ -11195,7 +11203,8 @@ static void tg3_reset_task(struct work_struct *work)
 	rtnl_lock();
 	tg3_full_lock(tp, 0);
 
-	if (tp->pcierr_recovery || !netif_running(tp->dev)) {
+	if (tp->pcierr_recovery || !netif_running(tp->dev) ||
+	    tp->pdev->error_state != pci_channel_io_normal) {
 		tg3_flag_clear(tp, RESET_TASK_PENDING);
 		tg3_full_unlock(tp);
 		rtnl_unlock();
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index aa9e616cc1d5..011210e6842d 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2302,7 +2302,6 @@ static int mtk_open(struct net_device *dev)
 	if (!refcount_read(&eth->dma_refcnt)) {
 		int err = mtk_start_dma(eth);
 
-		if (err)
 		if (err) {
 			phylink_disconnect_phy(mac->phylink);
 			return err;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c
index ded4cf658680..4b713832fdd5 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c
@@ -119,7 +119,6 @@ mlxsw_sp_acl_atcam_region_12kb_init(struct mlxsw_sp_acl_atcam_region *aregion)
 {
 	struct mlxsw_sp *mlxsw_sp = aregion->region->mlxsw_sp;
 	struct mlxsw_sp_acl_atcam_region_12kb *region_12kb;
-	size_t alloc_size;
 	u64 max_lkey_id;
 	int err;
 
@@ -131,8 +130,7 @@ mlxsw_sp_acl_atcam_region_12kb_init(struct mlxsw_sp_acl_atcam_region *aregion)
 	if (!region_12kb)
 		return -ENOMEM;
 
-	alloc_size = BITS_TO_LONGS(max_lkey_id) * sizeof(unsigned long);
-	region_12kb->used_lkey_id = kzalloc(alloc_size, GFP_KERNEL);
+	region_12kb->used_lkey_id = bitmap_zalloc(max_lkey_id, GFP_KERNEL);
 	if (!region_12kb->used_lkey_id) {
 		err = -ENOMEM;
 		goto err_used_lkey_id_alloc;
@@ -149,7 +147,7 @@ mlxsw_sp_acl_atcam_region_12kb_init(struct mlxsw_sp_acl_atcam_region *aregion)
 	return 0;
 
 err_rhashtable_init:
-	kfree(region_12kb->used_lkey_id);
+	bitmap_free(region_12kb->used_lkey_id);
 err_used_lkey_id_alloc:
 	kfree(region_12kb);
 	return err;
@@ -161,7 +159,7 @@ mlxsw_sp_acl_atcam_region_12kb_fini(struct mlxsw_sp_acl_atcam_region *aregion)
 	struct mlxsw_sp_acl_atcam_region_12kb *region_12kb = aregion->priv;
 
 	rhashtable_destroy(&region_12kb->lkey_ht);
-	kfree(region_12kb->used_lkey_id);
+	bitmap_free(region_12kb->used_lkey_id);
 	kfree(region_12kb);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c
index 4c98950380d5..d231f4d2888b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c
@@ -301,6 +301,7 @@ mlxsw_sp_acl_erp_table_alloc(struct mlxsw_sp_acl_erp_core *erp_core,
 			     unsigned long *p_index)
 {
 	unsigned int num_rows, entry_size;
+	unsigned long index;
 
 	/* We only allow allocations of entire rows */
 	if (num_erps % erp_core->num_erp_banks != 0)
@@ -309,10 +310,11 @@ mlxsw_sp_acl_erp_table_alloc(struct mlxsw_sp_acl_erp_core *erp_core,
 	entry_size = erp_core->erpt_entries_size[region_type];
 	num_rows = num_erps / erp_core->num_erp_banks;
 
-	*p_index = gen_pool_alloc(erp_core->erp_tables, num_rows * entry_size);
-	if (*p_index == 0)
+	index = gen_pool_alloc(erp_core->erp_tables, num_rows * entry_size);
+	if (!index)
 		return -ENOBUFS;
-	*p_index -= MLXSW_SP_ACL_ERP_GENALLOC_OFFSET;
+
+	*p_index = index - MLXSW_SP_ACL_ERP_GENALLOC_OFFSET;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index 7cccc41dd69c..483c8b75bebb 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -29,70 +29,6 @@ size_t mlxsw_sp_acl_tcam_priv_size(struct mlxsw_sp *mlxsw_sp)
 #define MLXSW_SP_ACL_TCAM_VREGION_REHASH_INTRVL_MIN 3000 /* ms */
 #define MLXSW_SP_ACL_TCAM_VREGION_REHASH_CREDITS 100 /* number of entries */
 
-int mlxsw_sp_acl_tcam_init(struct mlxsw_sp *mlxsw_sp,
-			   struct mlxsw_sp_acl_tcam *tcam)
-{
-	const struct mlxsw_sp_acl_tcam_ops *ops = mlxsw_sp->acl_tcam_ops;
-	u64 max_tcam_regions;
-	u64 max_regions;
-	u64 max_groups;
-	size_t alloc_size;
-	int err;
-
-	mutex_init(&tcam->lock);
-	tcam->vregion_rehash_intrvl =
-			MLXSW_SP_ACL_TCAM_VREGION_REHASH_INTRVL_DFLT;
-	INIT_LIST_HEAD(&tcam->vregion_list);
-
-	max_tcam_regions = MLXSW_CORE_RES_GET(mlxsw_sp->core,
-					      ACL_MAX_TCAM_REGIONS);
-	max_regions = MLXSW_CORE_RES_GET(mlxsw_sp->core, ACL_MAX_REGIONS);
-
-	/* Use 1:1 mapping between ACL region and TCAM region */
-	if (max_tcam_regions < max_regions)
-		max_regions = max_tcam_regions;
-
-	alloc_size = sizeof(tcam->used_regions[0]) * BITS_TO_LONGS(max_regions);
-	tcam->used_regions = kzalloc(alloc_size, GFP_KERNEL);
-	if (!tcam->used_regions)
-		return -ENOMEM;
-	tcam->max_regions = max_regions;
-
-	max_groups = MLXSW_CORE_RES_GET(mlxsw_sp->core, ACL_MAX_GROUPS);
-	alloc_size = sizeof(tcam->used_groups[0]) * BITS_TO_LONGS(max_groups);
-	tcam->used_groups = kzalloc(alloc_size, GFP_KERNEL);
-	if (!tcam->used_groups) {
-		err = -ENOMEM;
-		goto err_alloc_used_groups;
-	}
-	tcam->max_groups = max_groups;
-	tcam->max_group_size = MLXSW_CORE_RES_GET(mlxsw_sp->core,
-						 ACL_MAX_GROUP_SIZE);
-
-	err = ops->init(mlxsw_sp, tcam->priv, tcam);
-	if (err)
-		goto err_tcam_init;
-
-	return 0;
-
-err_tcam_init:
-	kfree(tcam->used_groups);
-err_alloc_used_groups:
-	kfree(tcam->used_regions);
-	return err;
-}
-
-void mlxsw_sp_acl_tcam_fini(struct mlxsw_sp *mlxsw_sp,
-			    struct mlxsw_sp_acl_tcam *tcam)
-{
-	const struct mlxsw_sp_acl_tcam_ops *ops = mlxsw_sp->acl_tcam_ops;
-
-	mutex_destroy(&tcam->lock);
-	ops->fini(mlxsw_sp, tcam->priv);
-	kfree(tcam->used_groups);
-	kfree(tcam->used_regions);
-}
-
 int mlxsw_sp_acl_tcam_priority_get(struct mlxsw_sp *mlxsw_sp,
 				   struct mlxsw_sp_acl_rule_info *rulei,
 				   u32 *priority, bool fillup_priority)
@@ -1545,6 +1481,73 @@ mlxsw_sp_acl_tcam_vregion_rehash(struct mlxsw_sp *mlxsw_sp,
 		mlxsw_sp_acl_tcam_vregion_rehash_end(mlxsw_sp, vregion, ctx);
 }
 
+int mlxsw_sp_acl_tcam_init(struct mlxsw_sp *mlxsw_sp,
+			   struct mlxsw_sp_acl_tcam *tcam)
+{
+	const struct mlxsw_sp_acl_tcam_ops *ops = mlxsw_sp->acl_tcam_ops;
+	u64 max_tcam_regions;
+	u64 max_regions;
+	u64 max_groups;
+	int err;
+
+	mutex_init(&tcam->lock);
+	tcam->vregion_rehash_intrvl =
+			MLXSW_SP_ACL_TCAM_VREGION_REHASH_INTRVL_DFLT;
+	INIT_LIST_HEAD(&tcam->vregion_list);
+
+	max_tcam_regions = MLXSW_CORE_RES_GET(mlxsw_sp->core,
+					      ACL_MAX_TCAM_REGIONS);
+	max_regions = MLXSW_CORE_RES_GET(mlxsw_sp->core, ACL_MAX_REGIONS);
+
+	/* Use 1:1 mapping between ACL region and TCAM region */
+	if (max_tcam_regions < max_regions)
+		max_regions = max_tcam_regions;
+
+	tcam->used_regions = bitmap_zalloc(max_regions, GFP_KERNEL);
+	if (!tcam->used_regions) {
+		err = -ENOMEM;
+		goto err_alloc_used_regions;
+	}
+	tcam->max_regions = max_regions;
+
+	max_groups = MLXSW_CORE_RES_GET(mlxsw_sp->core, ACL_MAX_GROUPS);
+	tcam->used_groups = bitmap_zalloc(max_groups, GFP_KERNEL);
+	if (!tcam->used_groups) {
+		err = -ENOMEM;
+		goto err_alloc_used_groups;
+	}
+	tcam->max_groups = max_groups;
+	tcam->max_group_size = MLXSW_CORE_RES_GET(mlxsw_sp->core,
+						  ACL_MAX_GROUP_SIZE);
+	tcam->max_group_size = min_t(unsigned int, tcam->max_group_size,
+				     MLXSW_REG_PAGT_ACL_MAX_NUM);
+
+	err = ops->init(mlxsw_sp, tcam->priv, tcam);
+	if (err)
+		goto err_tcam_init;
+
+	return 0;
+
+err_tcam_init:
+	bitmap_free(tcam->used_groups);
+err_alloc_used_groups:
+	bitmap_free(tcam->used_regions);
+err_alloc_used_regions:
+	mutex_destroy(&tcam->lock);
+	return err;
+}
+
+void mlxsw_sp_acl_tcam_fini(struct mlxsw_sp *mlxsw_sp,
+			    struct mlxsw_sp_acl_tcam *tcam)
+{
+	const struct mlxsw_sp_acl_tcam_ops *ops = mlxsw_sp->acl_tcam_ops;
+
+	ops->fini(mlxsw_sp, tcam->priv);
+	bitmap_free(tcam->used_groups);
+	bitmap_free(tcam->used_regions);
+	mutex_destroy(&tcam->lock);
+}
+
 static const enum mlxsw_afk_element mlxsw_sp_acl_tcam_pattern_ipv4[] = {
 	MLXSW_AFK_ELEMENT_SRC_SYS_PORT,
 	MLXSW_AFK_ELEMENT_DMAC_32_47,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c
index b65b93a2b9bc..fc2257753b9b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c
@@ -122,7 +122,6 @@ int mlxsw_sp_counter_pool_init(struct mlxsw_sp *mlxsw_sp)
 	unsigned int sub_pools_count = ARRAY_SIZE(mlxsw_sp_counter_sub_pools);
 	struct devlink *devlink = priv_to_devlink(mlxsw_sp->core);
 	struct mlxsw_sp_counter_pool *pool;
-	unsigned int map_size;
 	int err;
 
 	pool = kzalloc(struct_size(pool, sub_pools, sub_pools_count),
@@ -143,9 +142,7 @@ int mlxsw_sp_counter_pool_init(struct mlxsw_sp *mlxsw_sp)
 	devlink_resource_occ_get_register(devlink, MLXSW_SP_RESOURCE_COUNTERS,
 					  mlxsw_sp_counter_pool_occ_get, pool);
 
-	map_size = BITS_TO_LONGS(pool->pool_size) * sizeof(unsigned long);
-
-	pool->usage = kzalloc(map_size, GFP_KERNEL);
+	pool->usage = bitmap_zalloc(pool->pool_size, GFP_KERNEL);
 	if (!pool->usage) {
 		err = -ENOMEM;
 		goto err_usage_alloc;
@@ -158,7 +155,7 @@ int mlxsw_sp_counter_pool_init(struct mlxsw_sp *mlxsw_sp)
 	return 0;
 
 err_sub_pools_init:
-	kfree(pool->usage);
+	bitmap_free(pool->usage);
 err_usage_alloc:
 	devlink_resource_occ_get_unregister(devlink,
 					    MLXSW_SP_RESOURCE_COUNTERS);
@@ -176,7 +173,7 @@ void mlxsw_sp_counter_pool_fini(struct mlxsw_sp *mlxsw_sp)
 	WARN_ON(find_first_bit(pool->usage, pool->pool_size) !=
 			       pool->pool_size);
 	WARN_ON(atomic_read(&pool->active_entries_count));
-	kfree(pool->usage);
+	bitmap_free(pool->usage);
 	devlink_resource_occ_get_unregister(devlink,
 					    MLXSW_SP_RESOURCE_COUNTERS);
 	kfree(pool);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 368fa0e5ad31..ea37f5000caa 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -1631,16 +1631,13 @@ mlxsw_sp_mid *__mlxsw_sp_mc_alloc(struct mlxsw_sp *mlxsw_sp,
 				  u16 fid)
 {
 	struct mlxsw_sp_mid *mid;
-	size_t alloc_size;
 
 	mid = kzalloc(sizeof(*mid), GFP_KERNEL);
 	if (!mid)
 		return NULL;
 
-	alloc_size = sizeof(unsigned long) *
-		     BITS_TO_LONGS(mlxsw_core_max_ports(mlxsw_sp->core));
-
-	mid->ports_in_mid = kzalloc(alloc_size, GFP_KERNEL);
+	mid->ports_in_mid = bitmap_zalloc(mlxsw_core_max_ports(mlxsw_sp->core),
+					  GFP_KERNEL);
 	if (!mid->ports_in_mid)
 		goto err_ports_in_mid_alloc;
 
@@ -1659,7 +1656,7 @@ mlxsw_sp_mid *__mlxsw_sp_mc_alloc(struct mlxsw_sp *mlxsw_sp,
 	return mid;
 
 err_write_mdb_entry:
-	kfree(mid->ports_in_mid);
+	bitmap_free(mid->ports_in_mid);
 err_ports_in_mid_alloc:
 	kfree(mid);
 	return NULL;
@@ -1676,7 +1673,7 @@ static int mlxsw_sp_port_remove_from_mid(struct mlxsw_sp_port *mlxsw_sp_port,
 			 mlxsw_core_max_ports(mlxsw_sp->core))) {
 		err = mlxsw_sp_mc_remove_mdb_entry(mlxsw_sp, mid);
 		list_del(&mid->list);
-		kfree(mid->ports_in_mid);
+		bitmap_free(mid->ports_in_mid);
 		kfree(mid);
 	}
 	return err;
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index 8d51b0cb545c..93fa10ad08a0 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -389,7 +389,7 @@ static int rmnet_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 struct rtnl_link_ops rmnet_link_ops __read_mostly = {
 	.kind		= "rmnet",
-	.maxtype	= __IFLA_RMNET_MAX,
+	.maxtype	= IFLA_RMNET_MAX,
 	.priv_size	= sizeof(struct rmnet_priv),
 	.setup		= rmnet_vnd_setup,
 	.validate	= rmnet_rtnl_validate,
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index f092f468016b..8a4dff0566f7 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1500,7 +1500,7 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	struct ravb_tstamp_skb *ts_skb;
 	struct ravb_tx_desc *desc;
 	unsigned long flags;
-	u32 dma_addr;
+	dma_addr_t dma_addr;
 	void *buffer;
 	u32 entry;
 	u32 len;
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index d10324431354..94e36deefe88 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -51,7 +51,7 @@
 #define AM65_CPSW_MAX_PORTS	8
 
 #define AM65_CPSW_MIN_PACKET_SIZE	VLAN_ETH_ZLEN
-#define AM65_CPSW_MAX_PACKET_SIZE	(VLAN_ETH_FRAME_LEN + ETH_FCS_LEN)
+#define AM65_CPSW_MAX_PACKET_SIZE	2024
 
 #define AM65_CPSW_REG_CTL		0x004
 #define AM65_CPSW_REG_STAT_PORT_EN	0x014
@@ -1853,7 +1853,8 @@ static int am65_cpsw_nuss_init_ndev_2g(struct am65_cpsw_common *common)
 	ether_addr_copy(port->ndev->dev_addr, port->slave.mac_addr);
 
 	port->ndev->min_mtu = AM65_CPSW_MIN_PACKET_SIZE;
-	port->ndev->max_mtu = AM65_CPSW_MAX_PACKET_SIZE;
+	port->ndev->max_mtu = AM65_CPSW_MAX_PACKET_SIZE -
+			      (VLAN_ETH_HLEN + ETH_FCS_LEN);
 	port->ndev->hw_features = NETIF_F_SG |
 				  NETIF_F_RXCSUM |
 				  NETIF_F_HW_CSUM |
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index bbbe198f83e8..2b7616f161d6 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1345,6 +1345,7 @@ static struct phy_driver ksphy_driver[] = {
 	/* PHY_GBIT_FEATURES */
 	.driver_data	= &ksz9021_type,
 	.probe		= kszphy_probe,
+	.soft_reset	= genphy_soft_reset,
 	.config_init	= ksz9131_config_init,
 	.read_status	= genphy_read_status,
 	.ack_interrupt	= kszphy_ack_interrupt,
diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 190bc5712e96..24006ddfba89 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -625,8 +625,8 @@ static int ath11k_core_get_rproc(struct ath11k_base *ab)
 
 	prproc = rproc_get_by_phandle(rproc_phandle);
 	if (!prproc) {
-		ath11k_err(ab, "failed to get rproc\n");
-		return -EINVAL;
+		ath11k_dbg(ab, ATH11K_DBG_AHB, "failed to get rproc, deferring\n");
+		return -EPROBE_DEFER;
 	}
 	ab_ahb->tgt_rproc = prproc;
 
diff --git a/drivers/net/wireless/marvell/libertas/Kconfig b/drivers/net/wireless/marvell/libertas/Kconfig
index 6d62ab49aa8d..c7d02adb3eea 100644
--- a/drivers/net/wireless/marvell/libertas/Kconfig
+++ b/drivers/net/wireless/marvell/libertas/Kconfig
@@ -2,8 +2,6 @@
 config LIBERTAS
 	tristate "Marvell 8xxx Libertas WLAN driver support"
 	depends on CFG80211
-	select WIRELESS_EXT
-	select WEXT_SPY
 	select LIB80211
 	select FW_LOADER
 	help
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 3d1b5d3d295a..2f5f1ff22a60 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -1980,6 +1980,8 @@ static int mwifiex_cfg80211_start_ap(struct wiphy *wiphy,
 
 	mwifiex_set_sys_config_invalid_data(bss_cfg);
 
+	memcpy(bss_cfg->mac_addr, priv->curr_addr, ETH_ALEN);
+
 	if (params->beacon_interval)
 		bss_cfg->beacon_period = params->beacon_interval;
 	if (params->dtim_period)
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 470d669c7f14..96c42b979e9b 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -177,6 +177,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
 #define TLV_TYPE_STA_MAC_ADDR       (PROPRIETARY_TLV_BASE_ID + 32)
 #define TLV_TYPE_BSSID              (PROPRIETARY_TLV_BASE_ID + 35)
 #define TLV_TYPE_CHANNELBANDLIST    (PROPRIETARY_TLV_BASE_ID + 42)
+#define TLV_TYPE_UAP_MAC_ADDRESS    (PROPRIETARY_TLV_BASE_ID + 43)
 #define TLV_TYPE_UAP_BEACON_PERIOD  (PROPRIETARY_TLV_BASE_ID + 44)
 #define TLV_TYPE_UAP_DTIM_PERIOD    (PROPRIETARY_TLV_BASE_ID + 45)
 #define TLV_TYPE_UAP_BCAST_SSID     (PROPRIETARY_TLV_BASE_ID + 48)
diff --git a/drivers/net/wireless/marvell/mwifiex/ioctl.h b/drivers/net/wireless/marvell/mwifiex/ioctl.h
index 3db449efa167..cdb5b3881782 100644
--- a/drivers/net/wireless/marvell/mwifiex/ioctl.h
+++ b/drivers/net/wireless/marvell/mwifiex/ioctl.h
@@ -119,6 +119,7 @@ struct mwifiex_uap_bss_param {
 	u8 qos_info;
 	u8 power_constraint;
 	struct mwifiex_types_wmm_info wmm_info;
+	u8 mac_addr[ETH_ALEN];
 };
 
 enum {
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
index b48a85d791f6..2d444e660ac5 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -479,6 +479,7 @@ void mwifiex_config_uap_11d(struct mwifiex_private *priv,
 static int
 mwifiex_uap_bss_param_prepare(u8 *tlv, void *cmd_buf, u16 *param_size)
 {
+	struct host_cmd_tlv_mac_addr *mac_tlv;
 	struct host_cmd_tlv_dtim_period *dtim_period;
 	struct host_cmd_tlv_beacon_period *beacon_period;
 	struct host_cmd_tlv_ssid *ssid;
@@ -498,6 +499,13 @@ mwifiex_uap_bss_param_prepare(u8 *tlv, void *cmd_buf, u16 *param_size)
 	int i;
 	u16 cmd_size = *param_size;
 
+	mac_tlv = (struct host_cmd_tlv_mac_addr *)tlv;
+	mac_tlv->header.type = cpu_to_le16(TLV_TYPE_UAP_MAC_ADDRESS);
+	mac_tlv->header.len = cpu_to_le16(ETH_ALEN);
+	memcpy(mac_tlv->mac_addr, bss_cfg->mac_addr, ETH_ALEN);
+	cmd_size += sizeof(struct host_cmd_tlv_mac_addr);
+	tlv += sizeof(struct host_cmd_tlv_mac_addr);
+
 	if (bss_cfg->ssid.ssid_len) {
 		ssid = (struct host_cmd_tlv_ssid *)tlv;
 		ssid->header.type = cpu_to_le16(TLV_TYPE_UAP_SSID);
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 3776495fd9d0..679ae786cf45 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -164,21 +164,29 @@ static bool _rtl_pci_platform_switch_device_pci_aspm(
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 
+	value &= PCI_EXP_LNKCTL_ASPMC;
+
 	if (rtlhal->hw_type != HARDWARE_TYPE_RTL8192SE)
-		value |= 0x40;
+		value |= PCI_EXP_LNKCTL_CCC;
 
-	pci_write_config_byte(rtlpci->pdev, 0x80, value);
+	pcie_capability_clear_and_set_word(rtlpci->pdev, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC | value,
+					   value);
 
 	return false;
 }
 
-/*When we set 0x01 to enable clk request. Set 0x0 to disable clk req.*/
-static void _rtl_pci_switch_clk_req(struct ieee80211_hw *hw, u8 value)
+/* @value is PCI_EXP_LNKCTL_CLKREQ_EN or 0 to enable/disable clk request. */
+static void _rtl_pci_switch_clk_req(struct ieee80211_hw *hw, u16 value)
 {
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 
-	pci_write_config_byte(rtlpci->pdev, 0x81, value);
+	value &= PCI_EXP_LNKCTL_CLKREQ_EN;
+
+	pcie_capability_clear_and_set_word(rtlpci->pdev, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_CLKREQ_EN,
+					   value);
 
 	if (rtlhal->hw_type == HARDWARE_TYPE_RTL8192SE)
 		udelay(100);
@@ -192,11 +200,8 @@ static void rtl_pci_disable_aspm(struct ieee80211_hw *hw)
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	u8 pcibridge_vendor = pcipriv->ndis_adapter.pcibridge_vendor;
-	u8 num4bytes = pcipriv->ndis_adapter.num4bytes;
 	/*Retrieve original configuration settings. */
 	u8 linkctrl_reg = pcipriv->ndis_adapter.linkctrl_reg;
-	u16 pcibridge_linkctrlreg = pcipriv->ndis_adapter.
-				pcibridge_linkctrlreg;
 	u16 aspmlevel = 0;
 	u8 tmp_u1b = 0;
 
@@ -221,16 +226,8 @@ static void rtl_pci_disable_aspm(struct ieee80211_hw *hw)
 	/*Set corresponding value. */
 	aspmlevel |= BIT(0) | BIT(1);
 	linkctrl_reg &= ~aspmlevel;
-	pcibridge_linkctrlreg &= ~(BIT(0) | BIT(1));
 
 	_rtl_pci_platform_switch_device_pci_aspm(hw, linkctrl_reg);
-	udelay(50);
-
-	/*4 Disable Pci Bridge ASPM */
-	pci_write_config_byte(rtlpci->pdev, (num4bytes << 2),
-			      pcibridge_linkctrlreg);
-
-	udelay(50);
 }
 
 /*Enable RTL8192SE ASPM & Enable Pci Bridge ASPM for
@@ -245,9 +242,7 @@ static void rtl_pci_enable_aspm(struct ieee80211_hw *hw)
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	u8 pcibridge_vendor = pcipriv->ndis_adapter.pcibridge_vendor;
-	u8 num4bytes = pcipriv->ndis_adapter.num4bytes;
 	u16 aspmlevel;
-	u8 u_pcibridge_aspmsetting;
 	u8 u_device_aspmsetting;
 
 	if (!ppsc->support_aspm)
@@ -259,25 +254,6 @@ static void rtl_pci_enable_aspm(struct ieee80211_hw *hw)
 		return;
 	}
 
-	/*4 Enable Pci Bridge ASPM */
-
-	u_pcibridge_aspmsetting =
-	    pcipriv->ndis_adapter.pcibridge_linkctrlreg |
-	    rtlpci->const_hostpci_aspm_setting;
-
-	if (pcibridge_vendor == PCI_BRIDGE_VENDOR_INTEL)
-		u_pcibridge_aspmsetting &= ~BIT(0);
-
-	pci_write_config_byte(rtlpci->pdev, (num4bytes << 2),
-			      u_pcibridge_aspmsetting);
-
-	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
-		"PlatformEnableASPM(): Write reg[%x] = %x\n",
-		(pcipriv->ndis_adapter.pcibridge_pciehdr_offset + 0x10),
-		u_pcibridge_aspmsetting);
-
-	udelay(50);
-
 	/*Get ASPM level (with/without Clock Req) */
 	aspmlevel = rtlpci->const_devicepci_aspm_setting;
 	u_device_aspmsetting = pcipriv->ndis_adapter.linkctrl_reg;
@@ -291,7 +267,8 @@ static void rtl_pci_enable_aspm(struct ieee80211_hw *hw)
 
 	if (ppsc->reg_rfps_level & RT_RF_OFF_LEVL_CLK_REQ) {
 		_rtl_pci_switch_clk_req(hw, (ppsc->reg_rfps_level &
-					     RT_RF_OFF_LEVL_CLK_REQ) ? 1 : 0);
+					     RT_RF_OFF_LEVL_CLK_REQ) ?
+					     PCI_EXP_LNKCTL_CLKREQ_EN : 0);
 		RT_SET_PS_LEVEL(ppsc, RT_RF_OFF_LEVL_CLK_REQ);
 	}
 	udelay(100);
@@ -359,22 +336,6 @@ static bool rtl_pci_check_buddy_priv(struct ieee80211_hw *hw,
 	return find_buddy_priv;
 }
 
-static void rtl_pci_get_linkcontrol_field(struct ieee80211_hw *hw)
-{
-	struct rtl_pci_priv *pcipriv = rtl_pcipriv(hw);
-	struct rtl_pci *rtlpci = rtl_pcidev(pcipriv);
-	u8 capabilityoffset = pcipriv->ndis_adapter.pcibridge_pciehdr_offset;
-	u8 linkctrl_reg;
-	u8 num4bbytes;
-
-	num4bbytes = (capabilityoffset + 0x10) / 4;
-
-	/*Read  Link Control Register */
-	pci_read_config_byte(rtlpci->pdev, (num4bbytes << 2), &linkctrl_reg);
-
-	pcipriv->ndis_adapter.pcibridge_linkctrlreg = linkctrl_reg;
-}
-
 static void rtl_pci_parse_configuration(struct pci_dev *pdev,
 					struct ieee80211_hw *hw)
 {
@@ -2035,12 +1996,6 @@ static bool _rtl_pci_find_adapter(struct pci_dev *pdev,
 		    PCI_SLOT(bridge_pdev->devfn);
 		pcipriv->ndis_adapter.pcibridge_funcnum =
 		    PCI_FUNC(bridge_pdev->devfn);
-		pcipriv->ndis_adapter.pcibridge_pciehdr_offset =
-		    pci_pcie_cap(bridge_pdev);
-		pcipriv->ndis_adapter.num4bytes =
-		    (pcipriv->ndis_adapter.pcibridge_pciehdr_offset + 0x10) / 4;
-
-		rtl_pci_get_linkcontrol_field(hw);
 
 		if (pcipriv->ndis_adapter.pcibridge_vendor ==
 		    PCI_BRIDGE_VENDOR_AMD) {
@@ -2057,13 +2012,11 @@ static bool _rtl_pci_find_adapter(struct pci_dev *pdev,
 		pdev->vendor, pcipriv->ndis_adapter.linkctrl_reg);
 
 	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
-		"pci_bridge busnumber:devnumber:funcnumber:vendor:pcie_cap:link_ctl_reg:amd %d:%d:%d:%x:%x:%x:%x\n",
+		"pci_bridge busnumber:devnumber:funcnumber:vendor:amd %d:%d:%d:%x:%x\n",
 		pcipriv->ndis_adapter.pcibridge_busnum,
 		pcipriv->ndis_adapter.pcibridge_devnum,
 		pcipriv->ndis_adapter.pcibridge_funcnum,
 		pcibridge_vendors[pcipriv->ndis_adapter.pcibridge_vendor],
-		pcipriv->ndis_adapter.pcibridge_pciehdr_offset,
-		pcipriv->ndis_adapter.pcibridge_linkctrlreg,
 		pcipriv->ndis_adapter.amd_l1_patch);
 
 	rtl_pci_parse_configuration(pdev, hw);
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.h b/drivers/net/wireless/realtek/rtlwifi/pci.h
index 866861626a0a..d6307197dfea 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.h
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.h
@@ -236,11 +236,6 @@ struct mp_adapter {
 	u16 pcibridge_vendorid;
 	u16 pcibridge_deviceid;
 
-	u8 num4bytes;
-
-	u8 pcibridge_pciehdr_offset;
-	u8 pcibridge_linkctrlreg;
-
 	bool amd_l1_patch;
 };
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
index 9be032e8ec95..3395601eaa59 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
@@ -16,12 +16,6 @@ static u32 _rtl88e_phy_rf_serial_read(struct ieee80211_hw *hw,
 static void _rtl88e_phy_rf_serial_write(struct ieee80211_hw *hw,
 					enum radio_path rfpath, u32 offset,
 					u32 data);
-static u32 _rtl88e_phy_calculate_bit_shift(u32 bitmask)
-{
-	u32 i = ffs(bitmask);
-
-	return i ? i - 1 : 32;
-}
 static bool _rtl88e_phy_bb8188e_config_parafile(struct ieee80211_hw *hw);
 static bool _rtl88e_phy_config_mac_with_headerfile(struct ieee80211_hw *hw);
 static bool phy_config_bb_with_headerfile(struct ieee80211_hw *hw,
@@ -51,7 +45,7 @@ u32 rtl88e_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
 	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
 		"regaddr(%#x), bitmask(%#x)\n", regaddr, bitmask);
 	originalvalue = rtl_read_dword(rtlpriv, regaddr);
-	bitshift = _rtl88e_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	returnvalue = (originalvalue & bitmask) >> bitshift;
 
 	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
@@ -74,7 +68,7 @@ void rtl88e_phy_set_bb_reg(struct ieee80211_hw *hw,
 
 	if (bitmask != MASKDWORD) {
 		originalvalue = rtl_read_dword(rtlpriv, regaddr);
-		bitshift = _rtl88e_phy_calculate_bit_shift(bitmask);
+		bitshift = calculate_bit_shift(bitmask);
 		data = ((originalvalue & (~bitmask)) | (data << bitshift));
 	}
 
@@ -99,7 +93,7 @@ u32 rtl88e_phy_query_rf_reg(struct ieee80211_hw *hw,
 
 
 	original_value = _rtl88e_phy_rf_serial_read(hw, rfpath, regaddr);
-	bitshift = _rtl88e_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
@@ -127,7 +121,7 @@ void rtl88e_phy_set_rf_reg(struct ieee80211_hw *hw,
 			original_value = _rtl88e_phy_rf_serial_read(hw,
 								    rfpath,
 								    regaddr);
-			bitshift = _rtl88e_phy_calculate_bit_shift(bitmask);
+			bitshift = calculate_bit_shift(bitmask);
 			data =
 			    ((original_value & (~bitmask)) |
 			     (data << bitshift));
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c
index 3d29c8dbb255..144ee780e1b6 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c
@@ -17,7 +17,7 @@ u32 rtl92c_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
 	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE, "regaddr(%#x), bitmask(%#x)\n",
 		regaddr, bitmask);
 	originalvalue = rtl_read_dword(rtlpriv, regaddr);
-	bitshift = _rtl92c_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	returnvalue = (originalvalue & bitmask) >> bitshift;
 
 	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
@@ -40,7 +40,7 @@ void rtl92c_phy_set_bb_reg(struct ieee80211_hw *hw,
 
 	if (bitmask != MASKDWORD) {
 		originalvalue = rtl_read_dword(rtlpriv, regaddr);
-		bitshift = _rtl92c_phy_calculate_bit_shift(bitmask);
+		bitshift = calculate_bit_shift(bitmask);
 		data = ((originalvalue & (~bitmask)) | (data << bitshift));
 	}
 
@@ -143,14 +143,6 @@ void _rtl92c_phy_rf_serial_write(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(_rtl92c_phy_rf_serial_write);
 
-u32 _rtl92c_phy_calculate_bit_shift(u32 bitmask)
-{
-	u32 i = ffs(bitmask);
-
-	return i ? i - 1 : 32;
-}
-EXPORT_SYMBOL(_rtl92c_phy_calculate_bit_shift);
-
 static void _rtl92c_phy_bb_config_1t(struct ieee80211_hw *hw)
 {
 	rtl_set_bbreg(hw, RFPGA0_TXINFO, 0x3, 0x2);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.h
index 75afa6253ad0..e64d377dfe9e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.h
@@ -196,7 +196,6 @@ bool rtl92c_phy_set_rf_power_state(struct ieee80211_hw *hw,
 void rtl92ce_phy_set_rf_on(struct ieee80211_hw *hw);
 void rtl92c_phy_set_io(struct ieee80211_hw *hw);
 void rtl92c_bb_block_on(struct ieee80211_hw *hw);
-u32 _rtl92c_phy_calculate_bit_shift(u32 bitmask);
 long _rtl92c_phy_txpwr_idx_to_dbm(struct ieee80211_hw *hw,
 				  enum wireless_mode wirelessmode,
 				  u8 txpwridx);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/phy.c
index 04735da11168..6b98e77768e9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/phy.c
@@ -39,7 +39,7 @@ u32 rtl92c_phy_query_rf_reg(struct ieee80211_hw *hw,
 							       rfpath, regaddr);
 	}
 
-	bitshift = _rtl92c_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
@@ -110,7 +110,7 @@ void rtl92ce_phy_set_rf_reg(struct ieee80211_hw *hw,
 			original_value = _rtl92c_phy_rf_serial_read(hw,
 								    rfpath,
 								    regaddr);
-			bitshift = _rtl92c_phy_calculate_bit_shift(bitmask);
+			bitshift = calculate_bit_shift(bitmask);
 			data =
 			    ((original_value & (~bitmask)) |
 			     (data << bitshift));
@@ -122,7 +122,7 @@ void rtl92ce_phy_set_rf_reg(struct ieee80211_hw *hw,
 			original_value = _rtl92c_phy_fw_rf_serial_read(hw,
 								       rfpath,
 								       regaddr);
-			bitshift = _rtl92c_phy_calculate_bit_shift(bitmask);
+			bitshift = calculate_bit_shift(bitmask);
 			data =
 			    ((original_value & (~bitmask)) |
 			     (data << bitshift));
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/phy.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/phy.h
index 7582a162bd11..c7a0d4c776f0 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/phy.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/phy.h
@@ -94,7 +94,6 @@ u32 _rtl92c_phy_rf_serial_read(struct ieee80211_hw *hw, enum radio_path rfpath,
 			       u32 offset);
 u32 _rtl92c_phy_fw_rf_serial_read(struct ieee80211_hw *hw,
 				  enum radio_path rfpath, u32 offset);
-u32 _rtl92c_phy_calculate_bit_shift(u32 bitmask);
 void _rtl92c_phy_rf_serial_write(struct ieee80211_hw *hw,
 				 enum radio_path rfpath, u32 offset, u32 data);
 void _rtl92c_phy_fw_rf_serial_write(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/phy.c
index a8d9fe269f31..0b8cb7e61fd8 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/phy.c
@@ -32,7 +32,7 @@ u32 rtl92cu_phy_query_rf_reg(struct ieee80211_hw *hw,
 		original_value = _rtl92c_phy_fw_rf_serial_read(hw,
 							       rfpath, regaddr);
 	}
-	bitshift = _rtl92c_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
 		"regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
@@ -56,7 +56,7 @@ void rtl92cu_phy_set_rf_reg(struct ieee80211_hw *hw,
 			original_value = _rtl92c_phy_rf_serial_read(hw,
 								    rfpath,
 								    regaddr);
-			bitshift = _rtl92c_phy_calculate_bit_shift(bitmask);
+			bitshift = calculate_bit_shift(bitmask);
 			data =
 			    ((original_value & (~bitmask)) |
 			     (data << bitshift));
@@ -67,7 +67,7 @@ void rtl92cu_phy_set_rf_reg(struct ieee80211_hw *hw,
 			original_value = _rtl92c_phy_fw_rf_serial_read(hw,
 								       rfpath,
 								       regaddr);
-			bitshift = _rtl92c_phy_calculate_bit_shift(bitmask);
+			bitshift = calculate_bit_shift(bitmask);
 			data =
 			    ((original_value & (~bitmask)) |
 			     (data << bitshift));
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
index d3027f8fbd38..af0c7d74b3f5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
@@ -160,12 +160,14 @@ static u32 targetchnl_2g[TARGET_CHNL_NUM_2G] = {
 	25711, 25658, 25606, 25554, 25502, 25451, 25328
 };
 
-static u32 _rtl92d_phy_calculate_bit_shift(u32 bitmask)
-{
-	u32 i = ffs(bitmask);
-
-	return i ? i - 1 : 32;
-}
+static const u8 channel_all[59] = {
+	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
+	36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58,
+	60, 62, 64, 100, 102, 104, 106, 108, 110, 112,
+	114, 116, 118, 120, 122, 124, 126, 128,	130,
+	132, 134, 136, 138, 140, 149, 151, 153, 155,
+	157, 159, 161, 163, 165
+};
 
 u32 rtl92d_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
 {
@@ -189,7 +191,7 @@ u32 rtl92d_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
 	} else {
 		originalvalue = rtl_read_dword(rtlpriv, regaddr);
 	}
-	bitshift = _rtl92d_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	returnvalue = (originalvalue & bitmask) >> bitshift;
 	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
 		"BBR MASK=0x%x Addr[0x%x]=0x%x\n",
@@ -221,7 +223,7 @@ void rtl92d_phy_set_bb_reg(struct ieee80211_hw *hw,
 					dbi_direct);
 		else
 			originalvalue = rtl_read_dword(rtlpriv, regaddr);
-		bitshift = _rtl92d_phy_calculate_bit_shift(bitmask);
+		bitshift = calculate_bit_shift(bitmask);
 		data = ((originalvalue & (~bitmask)) | (data << bitshift));
 	}
 	if (rtlhal->during_mac1init_radioa || rtlhal->during_mac0init_radiob)
@@ -308,7 +310,7 @@ u32 rtl92d_phy_query_rf_reg(struct ieee80211_hw *hw,
 		regaddr, rfpath, bitmask);
 	spin_lock(&rtlpriv->locks.rf_lock);
 	original_value = _rtl92d_phy_rf_serial_read(hw, rfpath, regaddr);
-	bitshift = _rtl92d_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 	spin_unlock(&rtlpriv->locks.rf_lock);
 	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
@@ -334,7 +336,7 @@ void rtl92d_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 		if (bitmask != RFREG_OFFSET_MASK) {
 			original_value = _rtl92d_phy_rf_serial_read(hw,
 				rfpath, regaddr);
-			bitshift = _rtl92d_phy_calculate_bit_shift(bitmask);
+			bitshift = calculate_bit_shift(bitmask);
 			data = ((original_value & (~bitmask)) |
 				(data << bitshift));
 		}
@@ -1354,14 +1356,6 @@ static void _rtl92d_phy_switch_rf_setting(struct ieee80211_hw *hw, u8 channel)
 
 u8 rtl92d_get_rightchnlplace_for_iqk(u8 chnl)
 {
-	u8 channel_all[59] = {
-		1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
-		36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58,
-		60, 62, 64, 100, 102, 104, 106, 108, 110, 112,
-		114, 116, 118, 120, 122, 124, 126, 128,	130,
-		132, 134, 136, 138, 140, 149, 151, 153, 155,
-		157, 159, 161, 163, 165
-	};
 	u8 place = chnl;
 
 	if (chnl > 14) {
@@ -3216,37 +3210,28 @@ void rtl92d_phy_config_macphymode_info(struct ieee80211_hw *hw)
 u8 rtl92d_get_chnlgroup_fromarray(u8 chnl)
 {
 	u8 group;
-	u8 channel_info[59] = {
-		1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
-		36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56,
-		58, 60, 62, 64, 100, 102, 104, 106, 108,
-		110, 112, 114, 116, 118, 120, 122, 124,
-		126, 128, 130, 132, 134, 136, 138, 140,
-		149, 151, 153, 155, 157, 159, 161, 163,
-		165
-	};
 
-	if (channel_info[chnl] <= 3)
+	if (channel_all[chnl] <= 3)
 		group = 0;
-	else if (channel_info[chnl] <= 9)
+	else if (channel_all[chnl] <= 9)
 		group = 1;
-	else if (channel_info[chnl] <= 14)
+	else if (channel_all[chnl] <= 14)
 		group = 2;
-	else if (channel_info[chnl] <= 44)
+	else if (channel_all[chnl] <= 44)
 		group = 3;
-	else if (channel_info[chnl] <= 54)
+	else if (channel_all[chnl] <= 54)
 		group = 4;
-	else if (channel_info[chnl] <= 64)
+	else if (channel_all[chnl] <= 64)
 		group = 5;
-	else if (channel_info[chnl] <= 112)
+	else if (channel_all[chnl] <= 112)
 		group = 6;
-	else if (channel_info[chnl] <= 126)
+	else if (channel_all[chnl] <= 126)
 		group = 7;
-	else if (channel_info[chnl] <= 140)
+	else if (channel_all[chnl] <= 140)
 		group = 8;
-	else if (channel_info[chnl] <= 153)
+	else if (channel_all[chnl] <= 153)
 		group = 9;
-	else if (channel_info[chnl] <= 159)
+	else if (channel_all[chnl] <= 159)
 		group = 10;
 	else
 		group = 11;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c
index cc0bcaf13e96..73ef602bfb01 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c
@@ -16,7 +16,6 @@ static u32 _rtl92ee_phy_rf_serial_read(struct ieee80211_hw *hw,
 static void _rtl92ee_phy_rf_serial_write(struct ieee80211_hw *hw,
 					 enum radio_path rfpath, u32 offset,
 					 u32 data);
-static u32 _rtl92ee_phy_calculate_bit_shift(u32 bitmask);
 static bool _rtl92ee_phy_bb8192ee_config_parafile(struct ieee80211_hw *hw);
 static bool _rtl92ee_phy_config_mac_with_headerfile(struct ieee80211_hw *hw);
 static bool phy_config_bb_with_hdr_file(struct ieee80211_hw *hw,
@@ -46,7 +45,7 @@ u32 rtl92ee_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
 	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
 		"regaddr(%#x), bitmask(%#x)\n", regaddr, bitmask);
 	originalvalue = rtl_read_dword(rtlpriv, regaddr);
-	bitshift = _rtl92ee_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	returnvalue = (originalvalue & bitmask) >> bitshift;
 
 	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
@@ -68,7 +67,7 @@ void rtl92ee_phy_set_bb_reg(struct ieee80211_hw *hw, u32 regaddr,
 
 	if (bitmask != MASKDWORD) {
 		originalvalue = rtl_read_dword(rtlpriv, regaddr);
-		bitshift = _rtl92ee_phy_calculate_bit_shift(bitmask);
+		bitshift = calculate_bit_shift(bitmask);
 		data = ((originalvalue & (~bitmask)) | (data << bitshift));
 	}
 
@@ -92,7 +91,7 @@ u32 rtl92ee_phy_query_rf_reg(struct ieee80211_hw *hw,
 	spin_lock(&rtlpriv->locks.rf_lock);
 
 	original_value = _rtl92ee_phy_rf_serial_read(hw , rfpath, regaddr);
-	bitshift = _rtl92ee_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
@@ -119,7 +118,7 @@ void rtl92ee_phy_set_rf_reg(struct ieee80211_hw *hw,
 
 	if (bitmask != RFREG_OFFSET_MASK) {
 		original_value = _rtl92ee_phy_rf_serial_read(hw, rfpath, addr);
-		bitshift = _rtl92ee_phy_calculate_bit_shift(bitmask);
+		bitshift = calculate_bit_shift(bitmask);
 		data = (original_value & (~bitmask)) | (data << bitshift);
 	}
 
@@ -201,13 +200,6 @@ static void _rtl92ee_phy_rf_serial_write(struct ieee80211_hw *hw,
 		pphyreg->rf3wire_offset, data_and_addr);
 }
 
-static u32 _rtl92ee_phy_calculate_bit_shift(u32 bitmask)
-{
-	u32 i = ffs(bitmask);
-
-	return i ? i - 1 : 32;
-}
-
 bool rtl92ee_phy_mac_config(struct ieee80211_hw *hw)
 {
 	return _rtl92ee_phy_config_mac_with_headerfile(hw);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c
index 63283d9e7485..cd735d61f630 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c
@@ -14,13 +14,6 @@
 #include "hw.h"
 #include "table.h"
 
-static u32 _rtl92s_phy_calculate_bit_shift(u32 bitmask)
-{
-	u32 i = ffs(bitmask);
-
-	return i ? i - 1 : 32;
-}
-
 u32 rtl92s_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
@@ -30,7 +23,7 @@ u32 rtl92s_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
 		regaddr, bitmask);
 
 	originalvalue = rtl_read_dword(rtlpriv, regaddr);
-	bitshift = _rtl92s_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	returnvalue = (originalvalue & bitmask) >> bitshift;
 
 	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE, "BBR MASK=0x%x Addr[0x%x]=0x%x\n",
@@ -52,7 +45,7 @@ void rtl92s_phy_set_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask,
 
 	if (bitmask != MASKDWORD) {
 		originalvalue = rtl_read_dword(rtlpriv, regaddr);
-		bitshift = _rtl92s_phy_calculate_bit_shift(bitmask);
+		bitshift = calculate_bit_shift(bitmask);
 		data = ((originalvalue & (~bitmask)) | (data << bitshift));
 	}
 
@@ -160,7 +153,7 @@ u32 rtl92s_phy_query_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 
 	original_value = _rtl92s_phy_rf_serial_read(hw, rfpath, regaddr);
 
-	bitshift = _rtl92s_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
@@ -191,7 +184,7 @@ void rtl92s_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 	if (bitmask != RFREG_OFFSET_MASK) {
 		original_value = _rtl92s_phy_rf_serial_read(hw, rfpath,
 							    regaddr);
-		bitshift = _rtl92s_phy_calculate_bit_shift(bitmask);
+		bitshift = calculate_bit_shift(bitmask);
 		data = ((original_value & (~bitmask)) | (data << bitshift));
 	}
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
index c0c06ab6d3e7..fb143a5f9cc3 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
@@ -29,9 +29,10 @@ static void _rtl8821ae_phy_rf_serial_write(struct ieee80211_hw *hw,
 					   u32 data);
 static u32 _rtl8821ae_phy_calculate_bit_shift(u32 bitmask)
 {
-	u32 i = ffs(bitmask);
+	if (WARN_ON_ONCE(!bitmask))
+		return 0;
 
-	return i ? i - 1 : 32;
+	return __ffs(bitmask);
 }
 static bool _rtl8821ae_phy_bb8821a_config_parafile(struct ieee80211_hw *hw);
 /*static bool _rtl8812ae_phy_config_mac_with_headerfile(struct ieee80211_hw *hw);*/
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index fdccfd29fd61..a89e232d6963 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -3111,4 +3111,11 @@ static inline struct ieee80211_sta *rtl_find_sta(struct ieee80211_hw *hw,
 	return ieee80211_find_sta(mac->vif, mac_addr);
 }
 
+static inline u32 calculate_bit_shift(u32 bitmask)
+{
+	if (WARN_ON_ONCE(!bitmask))
+		return 0;
+
+	return __ffs(bitmask);
+}
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index c92fba2fa480..0a3766781347 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -264,9 +264,9 @@ static void rtw_ops_configure_filter(struct ieee80211_hw *hw,
 
 	if (changed_flags & FIF_ALLMULTI) {
 		if (*new_flags & FIF_ALLMULTI)
-			rtwdev->hal.rcr |= BIT_AM | BIT_AB;
+			rtwdev->hal.rcr |= BIT_AM;
 		else
-			rtwdev->hal.rcr &= ~(BIT_AM | BIT_AB);
+			rtwdev->hal.rcr &= ~(BIT_AM);
 	}
 	if (changed_flags & FIF_FCSFAIL) {
 		if (*new_flags & FIF_FCSFAIL)
diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index 1c366ddf62bc..d25bb5b9a54c 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -463,12 +463,25 @@ static void xenvif_get_requests(struct xenvif_queue *queue,
 	}
 
 	for (shinfo->nr_frags = 0; nr_slots > 0 && shinfo->nr_frags < MAX_SKB_FRAGS;
-	     shinfo->nr_frags++, gop++, nr_slots--) {
+	     nr_slots--) {
+		if (unlikely(!txp->size)) {
+			unsigned long flags;
+
+			spin_lock_irqsave(&queue->response_lock, flags);
+			make_tx_response(queue, txp, 0, XEN_NETIF_RSP_OKAY);
+			push_tx_responses(queue);
+			spin_unlock_irqrestore(&queue->response_lock, flags);
+			++txp;
+			continue;
+		}
+
 		index = pending_index(queue->pending_cons++);
 		pending_idx = queue->pending_ring[index];
 		xenvif_tx_create_map_op(queue, pending_idx, txp,
 				        txp == first ? extra_count : 0, gop);
 		frag_set_pending_idx(&frags[shinfo->nr_frags], pending_idx);
+		++shinfo->nr_frags;
+		++gop;
 
 		if (txp == first)
 			txp = txfrags;
@@ -481,20 +494,39 @@ static void xenvif_get_requests(struct xenvif_queue *queue,
 		shinfo = skb_shinfo(nskb);
 		frags = shinfo->frags;
 
-		for (shinfo->nr_frags = 0; shinfo->nr_frags < nr_slots;
-		     shinfo->nr_frags++, txp++, gop++) {
+		for (shinfo->nr_frags = 0; shinfo->nr_frags < nr_slots; ++txp) {
+			if (unlikely(!txp->size)) {
+				unsigned long flags;
+
+				spin_lock_irqsave(&queue->response_lock, flags);
+				make_tx_response(queue, txp, 0,
+						 XEN_NETIF_RSP_OKAY);
+				push_tx_responses(queue);
+				spin_unlock_irqrestore(&queue->response_lock,
+						       flags);
+				continue;
+			}
+
 			index = pending_index(queue->pending_cons++);
 			pending_idx = queue->pending_ring[index];
 			xenvif_tx_create_map_op(queue, pending_idx, txp, 0,
 						gop);
 			frag_set_pending_idx(&frags[shinfo->nr_frags],
 					     pending_idx);
+			++shinfo->nr_frags;
+			++gop;
 		}
 
-		skb_shinfo(skb)->frag_list = nskb;
-	} else if (nskb) {
+		if (shinfo->nr_frags) {
+			skb_shinfo(skb)->frag_list = nskb;
+			nskb = NULL;
+		}
+	}
+
+	if (nskb) {
 		/* A frag_list skb was allocated but it is no longer needed
-		 * because enough slots were converted to copy ops above.
+		 * because enough slots were converted to copy ops above or some
+		 * were empty.
 		 */
 		kfree_skb(nskb);
 	}
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 07c41a149328..30a642c8f537 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2071,9 +2071,10 @@ static void nvme_update_disk_info(struct gendisk *disk,
 
 	/*
 	 * The block layer can't support LBA sizes larger than the page size
-	 * yet, so catch this early and don't allow block I/O.
+	 * or smaller than a sector size yet, so catch this early and don't
+	 * allow block I/O.
 	 */
-	if (ns->lba_shift > PAGE_SHIFT) {
+	if (ns->lba_shift > PAGE_SHIFT || ns->lba_shift < SECTOR_SHIFT) {
 		capacity = 0;
 		bs = (1 << 9);
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c3e4d9b6f9c0..1e56fe8e8157 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -354,6 +354,11 @@ struct nvme_ctrl {
 	struct nvme_fault_inject fault_inject;
 };
 
+static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
+{
+	return READ_ONCE(ctrl->state);
+}
+
 enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7ce22d173fc7..116ae6fd35e2 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -18,6 +18,7 @@
 #include "nvmet.h"
 
 #define NVMET_TCP_DEF_INLINE_DATA_SIZE	(4 * PAGE_SIZE)
+#define NVMET_TCP_MAXH2CDATA		0x400000 /* 16M arbitrary limit */
 
 /* Define the socket priority to use for connections were it is desirable
  * that the NIC consider performing optimized packet processing or filtering.
@@ -872,7 +873,7 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 	icresp->hdr.pdo = 0;
 	icresp->hdr.plen = cpu_to_le32(icresp->hdr.hlen);
 	icresp->pfv = cpu_to_le16(NVME_TCP_PFV_1_0);
-	icresp->maxdata = cpu_to_le32(0x400000); /* 16M arbitrary limit */
+	icresp->maxdata = cpu_to_le32(NVMET_TCP_MAXH2CDATA);
 	icresp->cpda = 0;
 	if (queue->hdr_digest)
 		icresp->digest |= NVME_TCP_HDR_DIGEST_ENABLE;
@@ -918,6 +919,7 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 {
 	struct nvme_tcp_data_pdu *data = &queue->pdu.data;
 	struct nvmet_tcp_cmd *cmd;
+	unsigned int exp_data_len;
 
 	if (likely(queue->nr_cmds)) {
 		if (unlikely(data->ttag >= queue->nr_cmds)) {
@@ -936,12 +938,24 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 			data->ttag, le32_to_cpu(data->data_offset),
 			cmd->rbytes_done);
 		/* FIXME: use path and transport errors */
-		nvmet_req_complete(&cmd->req,
-			NVME_SC_INVALID_FIELD | NVME_SC_DNR);
+		nvmet_tcp_fatal_error(queue);
 		return -EPROTO;
 	}
 
+	exp_data_len = le32_to_cpu(data->hdr.plen) -
+			nvmet_tcp_hdgst_len(queue) -
+			nvmet_tcp_ddgst_len(queue) -
+			sizeof(*data);
+
 	cmd->pdu_len = le32_to_cpu(data->data_length);
+	if (unlikely(cmd->pdu_len != exp_data_len ||
+		     cmd->pdu_len == 0 ||
+		     cmd->pdu_len > NVMET_TCP_MAXH2CDATA)) {
+		pr_err("H2CData PDU len %u is invalid\n", cmd->pdu_len);
+		/* FIXME: use proper transport errors */
+		nvmet_tcp_fatal_error(queue);
+		return -EPROTO;
+	}
 	cmd->pdu_recv = 0;
 	nvmet_tcp_map_pdu_iovec(cmd);
 	queue->cmd = cmd;
diff --git a/drivers/of/base.c b/drivers/of/base.c
index eb02974f36bd..0e428880d88b 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1670,6 +1670,7 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 		out_args->np = new;
 		of_node_put(cur);
 		cur = new;
+		new = NULL;
 	}
 put:
 	of_node_put(cur);
diff --git a/drivers/of/unittest-data/tests-phandle.dtsi b/drivers/of/unittest-data/tests-phandle.dtsi
index 6b33be4c4416..aa0d7027ffa6 100644
--- a/drivers/of/unittest-data/tests-phandle.dtsi
+++ b/drivers/of/unittest-data/tests-phandle.dtsi
@@ -38,6 +38,13 @@ provider4: provider4 {
 				phandle-map-pass-thru = <0x0 0xf0>;
 			};
 
+			provider5: provider5 {
+				#phandle-cells = <2>;
+				phandle-map = <2 7 &provider4 2 3>;
+				phandle-map-mask = <0xff 0xf>;
+				phandle-map-pass-thru = <0x0 0xf0>;
+			};
+
 			consumer-a {
 				phandle-list =	<&provider1 1>,
 						<&provider2 2 0>,
@@ -64,7 +71,8 @@ consumer-b {
 						<&provider4 4 0x100>,
 						<&provider4 0 0x61>,
 						<&provider0>,
-						<&provider4 19 0x20>;
+						<&provider4 19 0x20>,
+						<&provider5 2 7>;
 				phandle-list-bad-phandle = <12345678 0 0>;
 				phandle-list-bad-args = <&provider2 1 0>,
 							<&provider4 0>;
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 412d7ddb3b8b..f9083c868a36 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -447,6 +447,9 @@ static void __init of_unittest_parse_phandle_with_args(void)
 
 		unittest(passed, "index %i - data error on node %pOF rc=%i\n",
 			 i, args.np, rc);
+
+		if (rc == 0)
+			of_node_put(args.np);
 	}
 
 	/* Check for missing list property */
@@ -536,8 +539,9 @@ static void __init of_unittest_parse_phandle_with_args(void)
 
 static void __init of_unittest_parse_phandle_with_args_map(void)
 {
-	struct device_node *np, *p0, *p1, *p2, *p3;
+	struct device_node *np, *p[6] = {};
 	struct of_phandle_args args;
+	unsigned int prefs[6];
 	int i, rc;
 
 	np = of_find_node_by_path("/testcase-data/phandle-tests/consumer-b");
@@ -546,34 +550,24 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 		return;
 	}
 
-	p0 = of_find_node_by_path("/testcase-data/phandle-tests/provider0");
-	if (!p0) {
-		pr_err("missing testcase data\n");
-		return;
-	}
-
-	p1 = of_find_node_by_path("/testcase-data/phandle-tests/provider1");
-	if (!p1) {
-		pr_err("missing testcase data\n");
-		return;
-	}
-
-	p2 = of_find_node_by_path("/testcase-data/phandle-tests/provider2");
-	if (!p2) {
-		pr_err("missing testcase data\n");
-		return;
-	}
-
-	p3 = of_find_node_by_path("/testcase-data/phandle-tests/provider3");
-	if (!p3) {
-		pr_err("missing testcase data\n");
-		return;
+	p[0] = of_find_node_by_path("/testcase-data/phandle-tests/provider0");
+	p[1] = of_find_node_by_path("/testcase-data/phandle-tests/provider1");
+	p[2] = of_find_node_by_path("/testcase-data/phandle-tests/provider2");
+	p[3] = of_find_node_by_path("/testcase-data/phandle-tests/provider3");
+	p[4] = of_find_node_by_path("/testcase-data/phandle-tests/provider4");
+	p[5] = of_find_node_by_path("/testcase-data/phandle-tests/provider5");
+	for (i = 0; i < ARRAY_SIZE(p); ++i) {
+		if (!p[i]) {
+			pr_err("missing testcase data\n");
+			return;
+		}
+		prefs[i] = kref_read(&p[i]->kobj.kref);
 	}
 
 	rc = of_count_phandle_with_args(np, "phandle-list", "#phandle-cells");
-	unittest(rc == 7, "of_count_phandle_with_args() returned %i, expected 7\n", rc);
+	unittest(rc == 8, "of_count_phandle_with_args() returned %i, expected 8\n", rc);
 
-	for (i = 0; i < 8; i++) {
+	for (i = 0; i < 9; i++) {
 		bool passed = true;
 
 		memset(&args, 0, sizeof(args));
@@ -584,13 +578,13 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 		switch (i) {
 		case 0:
 			passed &= !rc;
-			passed &= (args.np == p1);
+			passed &= (args.np == p[1]);
 			passed &= (args.args_count == 1);
 			passed &= (args.args[0] == 1);
 			break;
 		case 1:
 			passed &= !rc;
-			passed &= (args.np == p3);
+			passed &= (args.np == p[3]);
 			passed &= (args.args_count == 3);
 			passed &= (args.args[0] == 2);
 			passed &= (args.args[1] == 5);
@@ -601,28 +595,36 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 			break;
 		case 3:
 			passed &= !rc;
-			passed &= (args.np == p0);
+			passed &= (args.np == p[0]);
 			passed &= (args.args_count == 0);
 			break;
 		case 4:
 			passed &= !rc;
-			passed &= (args.np == p1);
+			passed &= (args.np == p[1]);
 			passed &= (args.args_count == 1);
 			passed &= (args.args[0] == 3);
 			break;
 		case 5:
 			passed &= !rc;
-			passed &= (args.np == p0);
+			passed &= (args.np == p[0]);
 			passed &= (args.args_count == 0);
 			break;
 		case 6:
 			passed &= !rc;
-			passed &= (args.np == p2);
+			passed &= (args.np == p[2]);
 			passed &= (args.args_count == 2);
 			passed &= (args.args[0] == 15);
 			passed &= (args.args[1] == 0x20);
 			break;
 		case 7:
+			passed &= !rc;
+			passed &= (args.np == p[3]);
+			passed &= (args.args_count == 3);
+			passed &= (args.args[0] == 2);
+			passed &= (args.args[1] == 5);
+			passed &= (args.args[2] == 3);
+			break;
+		case 8:
 			passed &= (rc == -ENOENT);
 			break;
 		default:
@@ -631,6 +633,9 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 
 		unittest(passed, "index %i - data error on node %s rc=%i\n",
 			 i, args.np->full_name, rc);
+
+		if (rc == 0)
+			of_node_put(args.np);
 	}
 
 	/* Check for missing list property */
@@ -677,6 +682,13 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 		   "OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found -1");
 
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
+
+	for (i = 0; i < ARRAY_SIZE(p); ++i) {
+		unittest(prefs[i] == kref_read(&p[i]->kobj.kref),
+			 "provider%d: expected:%d got:%d\n",
+			 i, prefs[i], kref_read(&p[i]->kobj.kref));
+		of_node_put(p[i]);
+	}
 }
 
 static void __init of_unittest_property_string(void)
diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index 96b888bb49c6..46f213270689 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -65,6 +65,10 @@ enum parport_pc_pci_cards {
 	sunix_5069a,
 	sunix_5079a,
 	sunix_5099a,
+	brainboxes_uc257,
+	brainboxes_is300,
+	brainboxes_uc414,
+	brainboxes_px263,
 };
 
 /* each element directly indexed from enum list, above */
@@ -158,6 +162,10 @@ static struct parport_pc_pci cards[] = {
 	/* sunix_5069a */		{ 1, { { 1, 2 }, } },
 	/* sunix_5079a */		{ 1, { { 1, 2 }, } },
 	/* sunix_5099a */		{ 1, { { 1, 2 }, } },
+	/* brainboxes_uc257 */	{ 1, { { 3, -1 }, } },
+	/* brainboxes_is300 */	{ 1, { { 3, -1 }, } },
+	/* brainboxes_uc414 */  { 1, { { 3, -1 }, } },
+	/* brainboxes_px263 */	{ 1, { { 3, -1 }, } },
 };
 
 static struct pci_device_id parport_serial_pci_tbl[] = {
@@ -277,6 +285,38 @@ static struct pci_device_id parport_serial_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999, PCI_VENDOR_ID_SUNIX,
 	  0x0104, 0, 0, sunix_5099a },
 
+	/* Brainboxes UC-203 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0bc1,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0bc2,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+
+	/* Brainboxes UC-257 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0861,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0862,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0863,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+
+	/* Brainboxes UC-414 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0e61,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc414 },
+
+	/* Brainboxes UC-475 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0981,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0982,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+
+	/* Brainboxes IS-300/IS-500 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0da0,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_is300 },
+
+	/* Brainboxes PX-263/PX-295 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x402c,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_px263 },
+
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci,parport_serial_pci_tbl);
@@ -542,6 +582,30 @@ static struct pciserial_board pci_parport_serial_boards[] = {
 		.base_baud      = 921600,
 		.uart_offset	= 0x8,
 	},
+	[brainboxes_uc257] = {
+		.flags		= FL_BASE2,
+		.num_ports	= 2,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[brainboxes_is300] = {
+		.flags		= FL_BASE2,
+		.num_ports	= 1,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[brainboxes_uc414] = {
+		.flags		= FL_BASE2,
+		.num_ports	= 4,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[brainboxes_px263] = {
+		.flags		= FL_BASE2,
+		.num_ports	= 4,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
 };
 
 struct parport_serial_private {
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index afaea201a5af..d3c3ca3ef4ba 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1261,7 +1261,16 @@ static int ks_pcie_probe(struct platform_device *pdev)
 		goto err_link;
 	}
 
+	/* Obtain references to the PHYs */
+	for (i = 0; i < num_lanes; i++)
+		phy_pm_runtime_get_sync(ks_pcie->phy[i]);
+
 	ret = ks_pcie_enable_phy(ks_pcie);
+
+	/* Release references to the PHYs */
+	for (i = 0; i < num_lanes; i++)
+		phy_pm_runtime_put_sync(ks_pcie->phy[i]);
+
 	if (ret) {
 		dev_err(dev, "failed to enable phy\n");
 		goto err_link;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 500905dad643..21661feeeeb6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4551,17 +4551,21 @@ static int pci_quirk_xgene_acs(struct pci_dev *dev, u16 acs_flags)
  * But the implementation could block peer-to-peer transactions between them
  * and provide ACS-like functionality.
  */
-static int  pci_quirk_zhaoxin_pcie_ports_acs(struct pci_dev *dev, u16 acs_flags)
+static int pci_quirk_zhaoxin_pcie_ports_acs(struct pci_dev *dev, u16 acs_flags)
 {
 	if (!pci_is_pcie(dev) ||
 	    ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
 	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)))
 		return -ENOTTY;
 
+	/*
+	 * Future Zhaoxin Root Ports and Switch Downstream Ports will
+	 * implement ACS capability in accordance with the PCIe Spec.
+	 */
 	switch (dev->device) {
 	case 0x0710 ... 0x071e:
 	case 0x0721:
-	case 0x0723 ... 0x0732:
+	case 0x0723 ... 0x0752:
 		return pci_acs_ctrl_enabled(acs_flags,
 			PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
 	}
diff --git a/drivers/pinctrl/cirrus/Kconfig b/drivers/pinctrl/cirrus/Kconfig
index 530426a74f75..b3cea8d56c4f 100644
--- a/drivers/pinctrl/cirrus/Kconfig
+++ b/drivers/pinctrl/cirrus/Kconfig
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config PINCTRL_LOCHNAGAR
 	tristate "Cirrus Logic Lochnagar pinctrl driver"
-	depends on MFD_LOCHNAGAR
+	# Avoid clash caused by MIPS defining RST, which is used in the driver
+	depends on MFD_LOCHNAGAR && !MIPS
 	select GPIOLIB
 	select PINMUX
 	select PINCONF
diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index de1fa71be1e8..d1071dbb904e 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -490,7 +490,7 @@ static int cw_battery_get_property(struct power_supply *psy,
 
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
 		if (cw_battery_valid_time_to_empty(cw_bat))
-			val->intval = cw_bat->time_to_empty;
+			val->intval = cw_bat->time_to_empty * 60;
 		else
 			val->intval = 0;
 		break;
diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 00c642fa2eed..db951a37c048 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -60,9 +60,10 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	snprintf(name, sizeof(name), "timer%u", pwm->hwpwm);
 
 	clk = clk_get(chip->dev, name);
-	if (IS_ERR(clk))
-		return dev_err_probe(chip->dev, PTR_ERR(clk),
-				     "Failed to get clock\n");
+	if (IS_ERR(clk)) {
+		dev_err(chip->dev, "error %pe: Failed to get clock\n", clk);
+		return PTR_ERR(clk);
+	}
 
 	err = clk_prepare_enable(clk);
 	if (err < 0) {
diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index d3be944f2ae9..69b7bc604946 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -115,14 +115,14 @@ static int stm32_pwm_raw_capture(struct stm32_pwm *priv, struct pwm_device *pwm,
 	int ret;
 
 	/* Ensure registers have been updated, enable counter and capture */
-	regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
-	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, TIM_CR1_CEN);
+	regmap_set_bits(priv->regmap, TIM_EGR, TIM_EGR_UG);
+	regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
 
 	/* Use cc1 or cc3 DMA resp for PWM input channels 1 & 2 or 3 & 4 */
 	dma_id = pwm->hwpwm < 2 ? STM32_TIMERS_DMA_CH1 : STM32_TIMERS_DMA_CH3;
 	ccen = pwm->hwpwm < 2 ? TIM_CCER_CC12E : TIM_CCER_CC34E;
 	ccr = pwm->hwpwm < 2 ? TIM_CCR1 : TIM_CCR3;
-	regmap_update_bits(priv->regmap, TIM_CCER, ccen, ccen);
+	regmap_set_bits(priv->regmap, TIM_CCER, ccen);
 
 	/*
 	 * Timer DMA burst mode. Request 2 registers, 2 bursts, to get both
@@ -160,8 +160,8 @@ static int stm32_pwm_raw_capture(struct stm32_pwm *priv, struct pwm_device *pwm,
 	}
 
 stop:
-	regmap_update_bits(priv->regmap, TIM_CCER, ccen, 0);
-	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
+	regmap_clear_bits(priv->regmap, TIM_CCER, ccen);
+	regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
 
 	return ret;
 }
@@ -359,7 +359,7 @@ static int stm32_pwm_config(struct stm32_pwm *priv, int ch,
 
 	regmap_write(priv->regmap, TIM_PSC, prescaler);
 	regmap_write(priv->regmap, TIM_ARR, prd - 1);
-	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, TIM_CR1_ARPE);
+	regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE);
 
 	/* Calculate the duty cycles */
 	dty = prd * duty_ns;
@@ -377,7 +377,7 @@ static int stm32_pwm_config(struct stm32_pwm *priv, int ch,
 	else
 		regmap_update_bits(priv->regmap, TIM_CCMR2, mask, ccmr);
 
-	regmap_update_bits(priv->regmap, TIM_BDTR, TIM_BDTR_MOE, TIM_BDTR_MOE);
+	regmap_set_bits(priv->regmap, TIM_BDTR, TIM_BDTR_MOE);
 
 	return 0;
 }
@@ -411,13 +411,13 @@ static int stm32_pwm_enable(struct stm32_pwm *priv, int ch)
 	if (priv->have_complementary_output)
 		mask |= TIM_CCER_CC1NE << (ch * 4);
 
-	regmap_update_bits(priv->regmap, TIM_CCER, mask, mask);
+	regmap_set_bits(priv->regmap, TIM_CCER, mask);
 
 	/* Make sure that registers are updated */
-	regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
+	regmap_set_bits(priv->regmap, TIM_EGR, TIM_EGR_UG);
 
 	/* Enable controller */
-	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, TIM_CR1_CEN);
+	regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
 
 	return 0;
 }
@@ -431,11 +431,11 @@ static void stm32_pwm_disable(struct stm32_pwm *priv, int ch)
 	if (priv->have_complementary_output)
 		mask |= TIM_CCER_CC1NE << (ch * 4);
 
-	regmap_update_bits(priv->regmap, TIM_CCER, mask, 0);
+	regmap_clear_bits(priv->regmap, TIM_CCER, mask);
 
 	/* When all channels are disabled, we can disable the controller */
 	if (!active_channels(priv))
-		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
+		regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
 
 	clk_disable(priv->clk);
 }
@@ -568,41 +568,30 @@ static void stm32_pwm_detect_complementary(struct stm32_pwm *priv)
 	 * If complementary bit doesn't exist writing 1 will have no
 	 * effect so we can detect it.
 	 */
-	regmap_update_bits(priv->regmap,
-			   TIM_CCER, TIM_CCER_CC1NE, TIM_CCER_CC1NE);
+	regmap_set_bits(priv->regmap, TIM_CCER, TIM_CCER_CC1NE);
 	regmap_read(priv->regmap, TIM_CCER, &ccer);
-	regmap_update_bits(priv->regmap, TIM_CCER, TIM_CCER_CC1NE, 0);
+	regmap_clear_bits(priv->regmap, TIM_CCER, TIM_CCER_CC1NE);
 
 	priv->have_complementary_output = (ccer != 0);
 }
 
-static int stm32_pwm_detect_channels(struct stm32_pwm *priv)
+static unsigned int stm32_pwm_detect_channels(struct stm32_pwm *priv,
+					      unsigned int *num_enabled)
 {
-	u32 ccer;
-	int npwm = 0;
+	u32 ccer, ccer_backup;
 
 	/*
 	 * If channels enable bits don't exist writing 1 will have no
 	 * effect so we can detect and count them.
 	 */
-	regmap_update_bits(priv->regmap,
-			   TIM_CCER, TIM_CCER_CCXE, TIM_CCER_CCXE);
+	regmap_read(priv->regmap, TIM_CCER, &ccer_backup);
+	regmap_set_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE);
 	regmap_read(priv->regmap, TIM_CCER, &ccer);
-	regmap_update_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE, 0);
-
-	if (ccer & TIM_CCER_CC1E)
-		npwm++;
+	regmap_write(priv->regmap, TIM_CCER, ccer_backup);
 
-	if (ccer & TIM_CCER_CC2E)
-		npwm++;
+	*num_enabled = hweight32(ccer_backup & TIM_CCER_CCXE);
 
-	if (ccer & TIM_CCER_CC3E)
-		npwm++;
-
-	if (ccer & TIM_CCER_CC4E)
-		npwm++;
-
-	return npwm;
+	return hweight32(ccer & TIM_CCER_CCXE);
 }
 
 static int stm32_pwm_probe(struct platform_device *pdev)
@@ -611,6 +600,8 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct stm32_timers *ddata = dev_get_drvdata(pdev->dev.parent);
 	struct stm32_pwm *priv;
+	unsigned int num_enabled;
+	unsigned int i;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -636,7 +627,11 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	priv->chip.base = -1;
 	priv->chip.dev = dev;
 	priv->chip.ops = &stm32pwm_ops;
-	priv->chip.npwm = stm32_pwm_detect_channels(priv);
+	priv->chip.npwm = stm32_pwm_detect_channels(priv, &num_enabled);
+
+	/* Initialize clock refcount to number of enabled PWM channels. */
+	for (i = 0; i < num_enabled; i++)
+		clk_enable(priv->clk);
 
 	ret = pwmchip_add(&priv->chip);
 	if (ret < 0)
diff --git a/drivers/reset/hisilicon/hi6220_reset.c b/drivers/reset/hisilicon/hi6220_reset.c
index 19926506d033..2a7688fa9b9b 100644
--- a/drivers/reset/hisilicon/hi6220_reset.c
+++ b/drivers/reset/hisilicon/hi6220_reset.c
@@ -164,7 +164,7 @@ static int hi6220_reset_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	type = (enum hi6220_reset_ctrl_type)of_device_get_match_data(dev);
+	type = (uintptr_t)of_device_get_match_data(dev);
 
 	regmap = syscon_node_to_regmap(np);
 	if (IS_ERR(regmap)) {
diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
index a4f6f2e62b1d..b5b36217b15e 100644
--- a/drivers/s390/block/scm_blk.c
+++ b/drivers/s390/block/scm_blk.c
@@ -18,6 +18,7 @@
 #include <linux/genhd.h>
 #include <linux/slab.h>
 #include <linux/list.h>
+#include <linux/io.h>
 #include <asm/eadm.h>
 #include "scm_blk.h"
 
@@ -131,7 +132,7 @@ static void scm_request_done(struct scm_request *scmrq)
 
 	for (i = 0; i < nr_requests_per_io && scmrq->request[i]; i++) {
 		msb = &scmrq->aob->msb[i];
-		aidaw = msb->data_addr;
+		aidaw = (u64)phys_to_virt(msb->data_addr);
 
 		if ((msb->flags & MSB_FLAG_IDA) && aidaw &&
 		    IS_ALIGNED(aidaw, PAGE_SIZE))
@@ -196,12 +197,12 @@ static int scm_request_prepare(struct scm_request *scmrq)
 	msb->scm_addr = scmdev->address + ((u64) blk_rq_pos(req) << 9);
 	msb->oc = (rq_data_dir(req) == READ) ? MSB_OC_READ : MSB_OC_WRITE;
 	msb->flags |= MSB_FLAG_IDA;
-	msb->data_addr = (u64) aidaw;
+	msb->data_addr = (u64)virt_to_phys(aidaw);
 
 	rq_for_each_segment(bv, req, iter) {
 		WARN_ON(bv.bv_offset);
 		msb->blk_count += bv.bv_len >> 12;
-		aidaw->data_addr = (u64) page_address(bv.bv_page);
+		aidaw->data_addr = virt_to_phys(page_address(bv.bv_page));
 		aidaw++;
 	}
 
diff --git a/drivers/scsi/fnic/fnic_debugfs.c b/drivers/scsi/fnic/fnic_debugfs.c
index 6c049360f136..56d52efc7314 100644
--- a/drivers/scsi/fnic/fnic_debugfs.c
+++ b/drivers/scsi/fnic/fnic_debugfs.c
@@ -67,9 +67,10 @@ int fnic_debugfs_init(void)
 		fc_trc_flag->fnic_trace = 2;
 		fc_trc_flag->fc_trace = 3;
 		fc_trc_flag->fc_clear = 4;
+		return 0;
 	}
 
-	return 0;
+	return -ENOMEM;
 }
 
 /*
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index e5b9229310a0..8e5d23c6b8de 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1584,10 +1584,10 @@ static int hisi_sas_controller_reset(struct hisi_hba *hisi_hba)
 		queue_work(hisi_hba->wq, &hisi_hba->debugfs_work);
 
 	if (!hisi_hba->hw->soft_reset)
-		return -1;
+		return -ENOENT;
 
 	if (test_and_set_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags))
-		return -1;
+		return -EPERM;
 
 	dev_info(dev, "controller resetting...\n");
 	hisi_sas_controller_reset_prepare(hisi_hba);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 0d21c64efa81..f03a09c9e865 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3479,7 +3479,7 @@ static int _suspend_v3_hw(struct device *device)
 	}
 
 	if (test_and_set_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags))
-		return -1;
+		return -EPERM;
 
 	scsi_block_requests(shost);
 	set_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 5fd9b515f6f1..74ea6b6b5f74 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -957,9 +957,10 @@ config SPI_ZYNQ_QSPI
 
 config SPI_ZYNQMP_GQSPI
 	tristate "Xilinx ZynqMP GQSPI controller"
-	depends on (SPI_MASTER && HAS_DMA) || COMPILE_TEST
+	depends on (SPI_MEM && HAS_DMA) || COMPILE_TEST
 	help
 	  Enables Xilinx GQSPI controller driver for Zynq UltraScale+ MPSoC.
+	  This controller only supports SPI memory interface.
 
 config SPI_AMD
 	tristate "AMD SPI controller"
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index b2579af0e3eb..35d30378256f 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -30,12 +30,15 @@
 
 #include <asm/unaligned.h>
 
+#define SH_MSIOF_FLAG_FIXED_DTDL_200	BIT(0)
+
 struct sh_msiof_chipdata {
 	u32 bits_per_word_mask;
 	u16 tx_fifo_size;
 	u16 rx_fifo_size;
 	u16 ctlr_flags;
 	u16 min_div_pow;
+	u32 flags;
 };
 
 struct sh_msiof_spi_priv {
@@ -1069,6 +1072,16 @@ static const struct sh_msiof_chipdata rcar_gen3_data = {
 	.min_div_pow = 1,
 };
 
+static const struct sh_msiof_chipdata rcar_r8a7795_data = {
+	.bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16) |
+			      SPI_BPW_MASK(24) | SPI_BPW_MASK(32),
+	.tx_fifo_size = 64,
+	.rx_fifo_size = 64,
+	.ctlr_flags = SPI_CONTROLLER_MUST_TX,
+	.min_div_pow = 1,
+	.flags = SH_MSIOF_FLAG_FIXED_DTDL_200,
+};
+
 static const struct of_device_id sh_msiof_match[] = {
 	{ .compatible = "renesas,sh-mobile-msiof", .data = &sh_data },
 	{ .compatible = "renesas,msiof-r8a7743",   .data = &rcar_gen2_data },
@@ -1079,6 +1092,7 @@ static const struct of_device_id sh_msiof_match[] = {
 	{ .compatible = "renesas,msiof-r8a7793",   .data = &rcar_gen2_data },
 	{ .compatible = "renesas,msiof-r8a7794",   .data = &rcar_gen2_data },
 	{ .compatible = "renesas,rcar-gen2-msiof", .data = &rcar_gen2_data },
+	{ .compatible = "renesas,msiof-r8a7795",   .data = &rcar_r8a7795_data },
 	{ .compatible = "renesas,msiof-r8a7796",   .data = &rcar_gen3_data },
 	{ .compatible = "renesas,rcar-gen3-msiof", .data = &rcar_gen3_data },
 	{ .compatible = "renesas,sh-msiof",        .data = &sh_data }, /* Deprecated */
@@ -1274,6 +1288,9 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	if (chipdata->flags & SH_MSIOF_FLAG_FIXED_DTDL_200)
+		info->dtdl = 200;
+
 	if (info->mode == MSIOF_SPI_SLAVE)
 		ctlr = spi_alloc_slave(&pdev->dev,
 				       sizeof(struct sh_msiof_spi_priv));
diff --git a/drivers/staging/media/rkisp1/rkisp1-dev.c b/drivers/staging/media/rkisp1/rkisp1-dev.c
index 06de5540c8af..663b2efec9b0 100644
--- a/drivers/staging/media/rkisp1/rkisp1-dev.c
+++ b/drivers/staging/media/rkisp1/rkisp1-dev.c
@@ -518,7 +518,7 @@ static int rkisp1_probe(struct platform_device *pdev)
 
 	ret = v4l2_device_register(rkisp1->dev, &rkisp1->v4l2_dev);
 	if (ret)
-		return ret;
+		goto err_pm_runtime_disable;
 
 	ret = media_device_register(&rkisp1->media_dev);
 	if (ret) {
@@ -538,6 +538,7 @@ static int rkisp1_probe(struct platform_device *pdev)
 	media_device_unregister(&rkisp1->media_dev);
 err_unreg_v4l2_dev:
 	v4l2_device_unregister(&rkisp1->v4l2_dev);
+err_pm_runtime_disable:
 	pm_runtime_disable(&pdev->dev);
 	return ret;
 }
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index bd4118f1b694..25765ebb756a 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1497,7 +1497,7 @@ static int omap8250_remove(struct platform_device *pdev)
 
 	err = pm_runtime_resume_and_get(&pdev->dev);
 	if (err)
-		return err;
+		dev_err(&pdev->dev, "Failed to resume hardware\n");
 
 	serial8250_unregister_port(priv->line);
 	priv->line = -ENODEV;
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 164597e2e004..6e49928bb864 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -461,13 +461,13 @@ static void imx_uart_stop_tx(struct uart_port *port)
 	ucr1 = imx_uart_readl(sport, UCR1);
 	imx_uart_writel(sport, ucr1 & ~UCR1_TRDYEN, UCR1);
 
+	ucr4 = imx_uart_readl(sport, UCR4);
 	usr2 = imx_uart_readl(sport, USR2);
-	if (!(usr2 & USR2_TXDC)) {
+	if ((!(usr2 & USR2_TXDC)) && (ucr4 & UCR4_TCEN)) {
 		/* The shifter is still busy, so retry once TC triggers */
 		return;
 	}
 
-	ucr4 = imx_uart_readl(sport, UCR4);
 	ucr4 &= ~UCR4_TCEN;
 	imx_uart_writel(sport, ucr4, UCR4);
 
@@ -2346,7 +2346,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 	/* For register access, we only need to enable the ipg clock. */
 	ret = clk_prepare_enable(sport->clk_ipg);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to enable per clk: %d\n", ret);
+		dev_err(&pdev->dev, "failed to enable ipg clk: %d\n", ret);
 		return ret;
 	}
 
@@ -2358,10 +2358,8 @@ static int imx_uart_probe(struct platform_device *pdev)
 	sport->ufcr = readl(sport->port.membase + UFCR);
 
 	ret = uart_get_rs485_mode(&sport->port);
-	if (ret) {
-		clk_disable_unprepare(sport->clk_ipg);
-		return ret;
-	}
+	if (ret)
+		goto err_clk;
 
 	if (sport->port.rs485.flags & SER_RS485_ENABLED &&
 	    (!sport->have_rtscts && !sport->have_rtsgpio))
@@ -2415,8 +2413,6 @@ static int imx_uart_probe(struct platform_device *pdev)
 		imx_uart_writel(sport, ucr3, UCR3);
 	}
 
-	clk_disable_unprepare(sport->clk_ipg);
-
 	hrtimer_init(&sport->trigger_start_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	hrtimer_init(&sport->trigger_stop_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	sport->trigger_start_tx.function = imx_trigger_start_tx;
@@ -2432,7 +2428,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request rx irq: %d\n",
 				ret);
-			return ret;
+			goto err_clk;
 		}
 
 		ret = devm_request_irq(&pdev->dev, txirq, imx_uart_txint, 0,
@@ -2440,7 +2436,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request tx irq: %d\n",
 				ret);
-			return ret;
+			goto err_clk;
 		}
 
 		ret = devm_request_irq(&pdev->dev, rtsirq, imx_uart_rtsint, 0,
@@ -2448,14 +2444,14 @@ static int imx_uart_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request rts irq: %d\n",
 				ret);
-			return ret;
+			goto err_clk;
 		}
 	} else {
 		ret = devm_request_irq(&pdev->dev, rxirq, imx_uart_int, 0,
 				       dev_name(&pdev->dev), sport);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request irq: %d\n", ret);
-			return ret;
+			goto err_clk;
 		}
 	}
 
@@ -2463,7 +2459,12 @@ static int imx_uart_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sport);
 
-	return uart_add_one_port(&imx_uart_uart_driver, &sport->port);
+	ret = uart_add_one_port(&imx_uart_uart_driver, &sport->port);
+
+err_clk:
+	clk_disable_unprepare(sport->clk_ipg);
+
+	return ret;
 }
 
 static int imx_uart_remove(struct platform_device *pdev)
diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
index 1908f27a795a..3d2d82ff6a03 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -64,7 +64,7 @@ int tty_check_change(struct tty_struct *tty);
 void __stop_tty(struct tty_struct *tty);
 void __start_tty(struct tty_struct *tty);
 void tty_write_unlock(struct tty_struct *tty);
-int tty_write_lock(struct tty_struct *tty, int ndelay);
+int tty_write_lock(struct tty_struct *tty, bool ndelay);
 void tty_vhangup_session(struct tty_struct *tty);
 void tty_open_proc_set_tty(struct file *filp, struct tty_struct *tty);
 int tty_signal_session_leader(struct tty_struct *tty, int exit_session);
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 094e82a12d29..984e3098e631 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -948,7 +948,7 @@ void tty_write_unlock(struct tty_struct *tty)
 	wake_up_interruptible_poll(&tty->write_wait, EPOLLOUT);
 }
 
-int tty_write_lock(struct tty_struct *tty, int ndelay)
+int tty_write_lock(struct tty_struct *tty, bool ndelay)
 {
 	if (!mutex_trylock(&tty->atomic_write_lock)) {
 		if (ndelay)
@@ -1167,7 +1167,7 @@ int tty_send_xchar(struct tty_struct *tty, char ch)
 		return 0;
 	}
 
-	if (tty_write_lock(tty, 0) < 0)
+	if (tty_write_lock(tty, false) < 0)
 		return -ERESTARTSYS;
 
 	down_read(&tty->termios_rwsem);
@@ -2470,22 +2470,25 @@ static int send_break(struct tty_struct *tty, unsigned int duration)
 		return 0;
 
 	if (tty->driver->flags & TTY_DRIVER_HARDWARE_BREAK)
-		retval = tty->ops->break_ctl(tty, duration);
-	else {
-		/* Do the work ourselves */
-		if (tty_write_lock(tty, 0) < 0)
-			return -EINTR;
-		retval = tty->ops->break_ctl(tty, -1);
-		if (retval)
-			goto out;
-		if (!signal_pending(current))
-			msleep_interruptible(duration);
+		return tty->ops->break_ctl(tty, duration);
+
+	/* Do the work ourselves */
+	if (tty_write_lock(tty, false) < 0)
+		return -EINTR;
+
+	retval = tty->ops->break_ctl(tty, -1);
+	if (!retval) {
+		msleep_interruptible(duration);
 		retval = tty->ops->break_ctl(tty, 0);
-out:
-		tty_write_unlock(tty);
-		if (signal_pending(current))
-			retval = -EINTR;
+	} else if (retval == -EOPNOTSUPP) {
+		/* some drivers can tell only dynamically */
+		retval = 0;
 	}
+	tty_write_unlock(tty);
+
+	if (signal_pending(current))
+		retval = -EINTR;
+
 	return retval;
 }
 
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 68b07250dcb6..12a30329abdb 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -404,7 +404,7 @@ static int set_termios(struct tty_struct *tty, void __user *arg, int opt)
 		if (retval < 0)
 			return retval;
 
-		if (tty_write_lock(tty, 0) < 0)
+		if (tty_write_lock(tty, false) < 0)
 			goto retry_write_wait;
 
 		/* Racing writer? */
diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index be06f1a961c2..f453b3c7ee42 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -464,13 +464,13 @@ static int uio_open(struct inode *inode, struct file *filep)
 
 	mutex_lock(&minor_lock);
 	idev = idr_find(&uio_idr, iminor(inode));
-	mutex_unlock(&minor_lock);
 	if (!idev) {
 		ret = -ENODEV;
+		mutex_unlock(&minor_lock);
 		goto out;
 	}
-
 	get_device(&idev->dev);
+	mutex_unlock(&minor_lock);
 
 	if (!try_module_get(idev->owner)) {
 		ret = -ENODEV;
@@ -1062,9 +1062,8 @@ void uio_unregister_device(struct uio_info *info)
 	wake_up_interruptible(&idev->wait);
 	kill_fasync(&idev->async_queue, SIGIO, POLL_HUP);
 
-	device_unregister(&idev->dev);
-
 	uio_free_minor(minor);
+	device_unregister(&idev->dev);
 
 	return;
 }
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 3d18599c5b9e..b8bb4cdadff8 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -516,6 +516,13 @@ static irqreturn_t ci_irq_handler(int irq, void *data)
 	u32 otgsc = 0;
 
 	if (ci->in_lpm) {
+		/*
+		 * If we already have a wakeup irq pending there,
+		 * let's just return to wait resume finished firstly.
+		 */
+		if (ci->wakeup_int)
+			return IRQ_HANDLED;
+
 		disable_irq_nosync(irq);
 		ci->wakeup_int = true;
 		pm_runtime_get(ci->dev);
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 070b838c7da9..4e4a71307d63 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -896,6 +896,9 @@ static int acm_tty_break_ctl(struct tty_struct *tty, int state)
 	struct acm *acm = tty->driver_data;
 	int retval;
 
+	if (!(acm->ctrl_caps & USB_CDC_CAP_BRK))
+		return -EOPNOTSUPP;
+
 	retval = acm_send_break(acm, state ? 0xffff : 0);
 	if (retval < 0)
 		dev_dbg(&acm->control->dev,
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 214a8ff2d69c..26f9928b972c 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -275,48 +275,11 @@ int dwc3_core_soft_reset(struct dwc3 *dwc)
 	/*
 	 * We're resetting only the device side because, if we're in host mode,
 	 * XHCI driver will reset the host block. If dwc3 was configured for
-	 * host-only mode or current role is host, then we can return early.
+	 * host-only mode, then we can return early.
 	 */
 	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
 		return 0;
 
-	/*
-	 * If the dr_mode is host and the dwc->current_dr_role is not the
-	 * corresponding DWC3_GCTL_PRTCAP_HOST, then the dwc3_core_init_mode
-	 * isn't executed yet. Ensure the phy is ready before the controller
-	 * updates the GCTL.PRTCAPDIR or other settings by soft-resetting
-	 * the phy.
-	 *
-	 * Note: GUSB3PIPECTL[n] and GUSB2PHYCFG[n] are port settings where n
-	 * is port index. If this is a multiport host, then we need to reset
-	 * all active ports.
-	 */
-	if (dwc->dr_mode == USB_DR_MODE_HOST) {
-		u32 usb3_port;
-		u32 usb2_port;
-
-		usb3_port = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
-		usb3_port |= DWC3_GUSB3PIPECTL_PHYSOFTRST;
-		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), usb3_port);
-
-		usb2_port = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-		usb2_port |= DWC3_GUSB2PHYCFG_PHYSOFTRST;
-		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), usb2_port);
-
-		/* Small delay for phy reset assertion */
-		usleep_range(1000, 2000);
-
-		usb3_port &= ~DWC3_GUSB3PIPECTL_PHYSOFTRST;
-		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), usb3_port);
-
-		usb2_port &= ~DWC3_GUSB2PHYCFG_PHYSOFTRST;
-		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), usb2_port);
-
-		/* Wait for clock synchronization */
-		msleep(50);
-		return 0;
-	}
-
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg |= DWC3_DCTL_CSFTRST;
 	reg &= ~DWC3_DCTL_RUN_STOP;
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 3cd294264372..14bdef97090b 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -236,7 +236,10 @@ static void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 		struct dwc3_request	*req;
 
 		req = next_request(&dep->pending_list);
-		dwc3_gadget_giveback(dep, req, -ECONNRESET);
+		if (!dwc->connected)
+			dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
+		else
+			dwc3_gadget_giveback(dep, req, -ECONNRESET);
 	}
 
 	dwc->ep0state = EP0_SETUP_PHASE;
diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
index 094e812e9e69..35483217b1f6 100644
--- a/drivers/usb/mon/mon_bin.c
+++ b/drivers/usb/mon/mon_bin.c
@@ -1247,14 +1247,19 @@ static vm_fault_t mon_bin_vma_fault(struct vm_fault *vmf)
 	struct mon_reader_bin *rp = vmf->vma->vm_private_data;
 	unsigned long offset, chunk_idx;
 	struct page *pageptr;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rp->b_lock, flags);
 	offset = vmf->pgoff << PAGE_SHIFT;
-	if (offset >= rp->b_size)
+	if (offset >= rp->b_size) {
+		spin_unlock_irqrestore(&rp->b_lock, flags);
 		return VM_FAULT_SIGBUS;
+	}
 	chunk_idx = offset / CHUNK_SIZE;
 	pageptr = rp->b_vec[chunk_idx].pg;
 	get_page(pageptr);
 	vmf->page = pageptr;
+	spin_unlock_irqrestore(&rp->b_lock, flags);
 	return 0;
 }
 
diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 70e23334b27f..e3cddcac3252 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -388,8 +388,7 @@ static void __mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool disconnect)
 
 static bool mxs_phy_is_otg_host(struct mxs_phy *mxs_phy)
 {
-	return IS_ENABLED(CONFIG_USB_OTG) &&
-		mxs_phy->phy.last_event == USB_EVENT_ID;
+	return mxs_phy->phy.last_event == USB_EVENT_ID;
 }
 
 static void mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool on)
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 18b35e817361..7fa95e701244 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -190,11 +190,13 @@ static void typec_altmode_put_partner(struct altmode *altmode)
 {
 	struct altmode *partner = altmode->partner;
 	struct typec_altmode *adev;
+	struct typec_altmode *partner_adev;
 
 	if (!partner)
 		return;
 
 	adev = &altmode->adev;
+	partner_adev = &partner->adev;
 
 	if (is_typec_plug(adev->dev.parent)) {
 		struct typec_plug *plug = to_typec_plug(adev->dev.parent);
@@ -203,7 +205,7 @@ static void typec_altmode_put_partner(struct altmode *altmode)
 	} else {
 		partner->partner = NULL;
 	}
-	put_device(&adev->dev);
+	put_device(&partner_adev->dev);
 }
 
 /**
diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index a591d291b231..0708e214c5a3 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -78,11 +78,7 @@ int fb_deferred_io_fsync(struct file *file, loff_t start, loff_t end, int datasy
 		return 0;
 
 	inode_lock(inode);
-	/* Kill off the delayed work */
-	cancel_delayed_work_sync(&info->deferred_work);
-
-	/* Run it immediately */
-	schedule_delayed_work(&info->deferred_work, 0);
+	flush_delayed_work(&info->deferred_work);
 	inode_unlock(inode);
 
 	return 0;
diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index dec6ca019bea..3a8dec05b591 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -42,6 +42,7 @@
 
 #define SECS_TO_WDOG_TICKS(x) ((x) << 16)
 #define WDOG_TICKS_TO_SECS(x) ((x) >> 16)
+#define WDOG_TICKS_TO_MSECS(x) ((x) * 1000 >> 16)
 
 struct bcm2835_wdt {
 	void __iomem		*base;
@@ -140,7 +141,7 @@ static struct watchdog_device bcm2835_wdt_wdd = {
 	.info =		&bcm2835_wdt_info,
 	.ops =		&bcm2835_wdt_ops,
 	.min_timeout =	1,
-	.max_timeout =	WDOG_TICKS_TO_SECS(PM_WDOG_TIME_SET),
+	.max_hw_heartbeat_ms =	WDOG_TICKS_TO_MSECS(PM_WDOG_TIME_SET),
 	.timeout =	WDOG_TICKS_TO_SECS(PM_WDOG_TIME_SET),
 };
 
diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 7d34bcf1c45b..53573c3ddd1a 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -174,7 +174,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 		"3. OA Forward Progress Log\n"
 		"4. iLO Event Log";
 
-	if (ilo5 && ulReason == NMI_UNKNOWN && !mynmi)
+	if (ulReason == NMI_UNKNOWN && !mynmi)
 		return NMI_DONE;
 
 	if (ilo5 && !pretimeout && !mynmi)
diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
index 46c2a4bd9ebe..daa00f3c5a6a 100644
--- a/drivers/watchdog/rti_wdt.c
+++ b/drivers/watchdog/rti_wdt.c
@@ -70,6 +70,11 @@ static int rti_wdt_start(struct watchdog_device *wdd)
 {
 	u32 timer_margin;
 	struct rti_wdt_device *wdt = watchdog_get_drvdata(wdd);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(wdd->parent);
+	if (ret)
+		return ret;
 
 	/* set timeout period */
 	timer_margin = (u64)wdd->timeout * wdt->freq;
@@ -296,6 +301,9 @@ static int rti_wdt_probe(struct platform_device *pdev)
 	if (last_ping)
 		watchdog_set_last_hw_keepalive(wdd, last_ping);
 
+	if (!watchdog_hw_running(wdd))
+		pm_runtime_put_sync(&pdev->dev);
+
 	return 0;
 
 err_iomap:
@@ -310,7 +318,10 @@ static int rti_wdt_remove(struct platform_device *pdev)
 	struct rti_wdt_device *wdt = platform_get_drvdata(pdev);
 
 	watchdog_unregister_device(&wdt->wdd);
-	pm_runtime_put(&pdev->dev);
+
+	if (!pm_runtime_suspended(&pdev->dev))
+		pm_runtime_put(&pdev->dev);
+
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index f37255cd75fd..24d0470af81c 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -1028,6 +1028,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd)
 
 	/* Fill in the data structures */
 	cdev_init(&wd_data->cdev, &watchdog_fops);
+	wd_data->cdev.owner = wdd->ops->owner;
 
 	/* Add the device */
 	err = cdev_device_add(&wd_data->cdev, &wd_data->dev);
@@ -1042,8 +1043,6 @@ static int watchdog_cdev_register(struct watchdog_device *wdd)
 		return err;
 	}
 
-	wd_data->cdev.owner = wdd->ops->owner;
-
 	/* Record time of most recent heartbeat as 'just before now'. */
 	wd_data->last_hw_keepalive = ktime_sub(ktime_get(), 1);
 	watchdog_set_open_deadline(wd_data);
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 42bab9270e7d..9c0aadedfbff 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -84,6 +84,14 @@ int debugfs_file_get(struct dentry *dentry)
 	struct debugfs_fsdata *fsd;
 	void *d_fsd;
 
+	/*
+	 * This could only happen if some debugfs user erroneously calls
+	 * debugfs_file_get() on a dentry that isn't even a file, let
+	 * them know about it.
+	 */
+	if (WARN_ON(!d_is_reg(dentry)))
+		return -EINVAL;
+
 	d_fsd = READ_ONCE(dentry->d_fsdata);
 	if (!((unsigned long)d_fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)) {
 		fsd = d_fsd;
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index f47f0a7d2c3b..d04930c199cb 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -210,17 +210,19 @@ static const struct super_operations debugfs_super_operations = {
 
 static void debugfs_release_dentry(struct dentry *dentry)
 {
-	void *fsd = dentry->d_fsdata;
+	struct debugfs_fsdata *fsd = dentry->d_fsdata;
 
-	if (!((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT))
-		kfree(dentry->d_fsdata);
+	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
+		return;
+
+	kfree(fsd);
 }
 
 static struct vfsmount *debugfs_automount(struct path *path)
 {
-	debugfs_automount_t f;
-	f = (debugfs_automount_t)path->dentry->d_fsdata;
-	return f(path->dentry, d_inode(path->dentry)->i_private);
+	struct debugfs_fsdata *fsd = path->dentry->d_fsdata;
+
+	return fsd->automount(path->dentry, d_inode(path->dentry)->i_private);
 }
 
 static const struct dentry_operations debugfs_dops = {
@@ -598,13 +600,23 @@ struct dentry *debugfs_create_automount(const char *name,
 					void *data)
 {
 	struct dentry *dentry = start_creating(name, parent);
+	struct debugfs_fsdata *fsd;
 	struct inode *inode;
 
 	if (IS_ERR(dentry))
 		return dentry;
 
+	fsd = kzalloc(sizeof(*fsd), GFP_KERNEL);
+	if (!fsd) {
+		failed_creating(dentry);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	fsd->automount = f;
+
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
 		failed_creating(dentry);
+		kfree(fsd);
 		return ERR_PTR(-EPERM);
 	}
 
@@ -612,13 +624,14 @@ struct dentry *debugfs_create_automount(const char *name,
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create automount '%s'\n",
 		       name);
+		kfree(fsd);
 		return failed_creating(dentry);
 	}
 
 	make_empty_dir_inode(inode);
 	inode->i_flags |= S_AUTOMOUNT;
 	inode->i_private = data;
-	dentry->d_fsdata = (void *)f;
+	dentry->d_fsdata = fsd;
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
 	d_instantiate(dentry, inode);
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index 92af8ae31313..f7c489b5a368 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -17,8 +17,14 @@ extern const struct file_operations debugfs_full_proxy_file_operations;
 
 struct debugfs_fsdata {
 	const struct file_operations *real_fops;
-	refcount_t active_users;
-	struct completion active_users_drained;
+	union {
+		/* automount_fn is used when real_fops is NULL */
+		debugfs_automount_t automount;
+		struct {
+			refcount_t active_users;
+			struct completion active_users_drained;
+		};
+	};
 };
 
 /*
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 15880a68faad..3626816b174a 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -13,6 +13,7 @@
 #include <linux/ucs2_string.h>
 #include <linux/slab.h>
 #include <linux/magic.h>
+#include <linux/printk.h>
 
 #include "internal.h"
 
@@ -231,8 +232,19 @@ static int efivarfs_get_tree(struct fs_context *fc)
 	return get_tree_single(fc, efivarfs_fill_super);
 }
 
+static int efivarfs_reconfigure(struct fs_context *fc)
+{
+	if (!efivar_supports_writes() && !(fc->sb_flags & SB_RDONLY)) {
+		pr_err("Firmware does not support SetVariableRT. Can not remount with rw\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct fs_context_operations efivarfs_context_ops = {
 	.get_tree	= efivarfs_get_tree,
+	.reconfigure	= efivarfs_reconfigure,
 };
 
 static int efivarfs_init_fs_context(struct fs_context *fc)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4e6b93f16758..55818bd510fb 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -42,7 +42,7 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 	ret = filemap_fault(vmf);
 	up_read(&F2FS_I(inode)->i_mmap_sem);
 
-	if (!ret)
+	if (ret & VM_FAULT_LOCKED)
 		f2fs_update_iostat(F2FS_I_SB(inode), APP_MAPPED_READ_IO,
 							F2FS_BLKSIZE);
 
@@ -2816,6 +2816,11 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 			goto out;
 	}
 
+	if (f2fs_compressed_file(src) || f2fs_compressed_file(dst)) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
 	ret = -EINVAL;
 	if (pos_in + len > src->i_size || pos_in + len < pos_in)
 		goto out_unlock;
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 72b109685db4..99e4ec48d2a4 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1066,7 +1066,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	}
 
 	if (old_dir_entry) {
-		if (old_dir != new_dir && !whiteout)
+		if (old_dir != new_dir)
 			f2fs_set_link(old_inode, old_dir_entry,
 						old_dir_page, new_dir);
 		else
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index f44c60114379..dd50b747b671 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -741,6 +741,12 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 		memcpy(pval, value, size);
 		last->e_value_size = cpu_to_le16(size);
 		new_hsize += newsize;
+		/*
+		 * Explicitly add the null terminator.  The unused xattr space
+		 * is supposed to always be zeroed, which would make this
+		 * unnecessary, but don't depend on that.
+		 */
+		*(u32 *)((u8 *)last + newsize) = 0;
 	}
 
 	error = write_all_xattrs(inode, new_hsize, base_addr, ipage);
diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index c5bde789a16d..1ffdc4ad6246 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -1247,6 +1247,8 @@ static int update_rgrp_lvb(struct gfs2_rgrpd *rgd)
 		rgd->rd_flags &= ~GFS2_RDF_CHECK;
 	rgd->rd_free = be32_to_cpu(rgd->rd_rgl->rl_free);
 	rgd->rd_free_clone = rgd->rd_free;
+	/* max out the rgrp allocation failure point */
+	rgd->rd_extfail_pt = rgd->rd_free;
 	rgd->rd_dinodes = be32_to_cpu(rgd->rd_rgl->rl_dinodes);
 	rgd->rd_igeneration = be64_to_cpu(rgd->rd_rgl->rl_igeneration);
 	return 0;
@@ -1648,7 +1650,7 @@ static int gfs2_reservation_check_and_update(struct gfs2_rbm *rbm,
 	 * If we have a minimum extent length, then skip over any extent
 	 * which is less than the min extent length in size.
 	 */
-	if (minext) {
+	if (minext > 1) {
 		extlen = gfs2_free_extlen(rbm, minext);
 		if (extlen <= maxext->len)
 			goto fail;
@@ -1680,7 +1682,7 @@ static int gfs2_reservation_check_and_update(struct gfs2_rbm *rbm,
  * gfs2_rbm_find - Look for blocks of a particular state
  * @rbm: Value/result starting position and final position
  * @state: The state which we want to find
- * @minext: Pointer to the requested extent length (NULL for a single block)
+ * @minext: Pointer to the requested extent length
  *          This is updated to be the actual reservation size.
  * @ip: If set, check for reservations
  * @nowrap: Stop looking at the end of the rgrp, rather than wrapping
@@ -1717,8 +1719,7 @@ static int gfs2_rbm_find(struct gfs2_rbm *rbm, u8 state, u32 *minext,
 
 	while(1) {
 		bi = rbm_bi(rbm);
-		if ((ip == NULL || !gfs2_rs_active(&ip->i_res)) &&
-		    test_bit(GBF_FULL, &bi->bi_flags) &&
+		if (test_bit(GBF_FULL, &bi->bi_flags) &&
 		    (state == GFS2_BLKST_FREE))
 			goto next_bitmap;
 
@@ -1737,8 +1738,7 @@ static int gfs2_rbm_find(struct gfs2_rbm *rbm, u8 state, u32 *minext,
 		if (ip == NULL)
 			return 0;
 
-		ret = gfs2_reservation_check_and_update(rbm, ip,
-							minext ? *minext : 0,
+		ret = gfs2_reservation_check_and_update(rbm, ip, *minext,
 							&maxext);
 		if (ret == 0)
 			return 0;
@@ -1770,7 +1770,7 @@ static int gfs2_rbm_find(struct gfs2_rbm *rbm, u8 state, u32 *minext,
 			break;
 	}
 
-	if (minext == NULL || state != GFS2_BLKST_FREE)
+	if (state != GFS2_BLKST_FREE)
 		return -ENOSPC;
 
 	/* If the extent was too small, and it's smaller than the smallest
@@ -1778,7 +1778,7 @@ static int gfs2_rbm_find(struct gfs2_rbm *rbm, u8 state, u32 *minext,
 	   useless to search this rgrp again for this amount or more. */
 	if (wrapped && (scan_from_start || rbm->bii > last_bii) &&
 	    *minext < rbm->rgd->rd_extfail_pt)
-		rbm->rgd->rd_extfail_pt = *minext;
+		rbm->rgd->rd_extfail_pt = *minext - 1;
 
 	/* If the maximum extent we found is big enough to fulfill the
 	   minimum requirements, use it anyway. */
@@ -2231,7 +2231,7 @@ void gfs2_rgrp_dump(struct seq_file *seq, struct gfs2_rgrpd *rgd,
 		       (unsigned long long)rgd->rd_addr, rgd->rd_flags,
 		       rgd->rd_free, rgd->rd_free_clone, rgd->rd_dinodes,
 		       rgd->rd_reserved, rgd->rd_extfail_pt);
-	if (rgd->rd_sbd->sd_args.ar_rgrplvb) {
+	if (rgd->rd_sbd->sd_args.ar_rgrplvb && rgd->rd_rgl) {
 		struct gfs2_rgrp_lvb *rgl = rgd->rd_rgl;
 
 		gfs2_print_dbg(seq, "%s  L: f:%02x b:%u i:%u\n", fs_id_buf,
@@ -2352,14 +2352,15 @@ int gfs2_alloc_blocks(struct gfs2_inode *ip, u64 *bn, unsigned int *nblocks,
 	struct gfs2_rbm rbm = { .rgd = ip->i_res.rs_rbm.rgd, };
 	unsigned int ndata;
 	u64 block; /* block, within the file system scope */
+	u32 minext = 1;
 	int error;
 
 	gfs2_set_alloc_start(&rbm, ip, dinode);
-	error = gfs2_rbm_find(&rbm, GFS2_BLKST_FREE, NULL, ip, false);
+	error = gfs2_rbm_find(&rbm, GFS2_BLKST_FREE, &minext, ip, false);
 
 	if (error == -ENOSPC) {
 		gfs2_set_alloc_start(&rbm, ip, dinode);
-		error = gfs2_rbm_find(&rbm, GFS2_BLKST_FREE, NULL, NULL, false);
+		error = gfs2_rbm_find(&rbm, GFS2_BLKST_FREE, &minext, NULL, false);
 	}
 
 	/* Since all blocks are reserved in advance, this shouldn't happen */
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index fa24b407a9dc..db137671a41f 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -300,6 +300,7 @@ static int journal_finish_inode_data_buffers(journal_t *journal,
 			if (!ret)
 				ret = err;
 		}
+		cond_resched();
 		spin_lock(&journal->j_list_lock);
 		jinode->i_flags &= ~JI_COMMIT_RUNNING;
 		smp_mb();
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index fee325d62bfd..effd837b8c1f 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1568,9 +1568,11 @@ static int jbd2_write_superblock(journal_t *journal, int write_flags)
 		return -EIO;
 	}
 
-	trace_jbd2_write_superblock(journal, write_flags);
 	if (!(journal->j_flags & JBD2_BARRIER))
 		write_flags &= ~(REQ_FUA | REQ_PREFLUSH);
+
+	trace_jbd2_write_superblock(journal, write_flags);
+
 	if (buffer_write_io_error(bh)) {
 		/*
 		 * Oh, dear.  A previous attempt to write the journal
diff --git a/fs/namespace.c b/fs/namespace.c
index 046b084136c5..b020a12c53a2 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2627,7 +2627,12 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
 	if (IS_ERR(fc))
 		return PTR_ERR(fc);
 
+	/*
+	 * Indicate to the filesystem that the remount request is coming
+	 * from the legacy mount system call.
+	 */
 	fc->oldapi = true;
+
 	err = parse_monolithic_mount_data(fc, data);
 	if (!err) {
 		down_write(&sb->s_umount);
@@ -2886,6 +2891,12 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 	if (IS_ERR(fc))
 		return PTR_ERR(fc);
 
+	/*
+	 * Indicate to the filesystem that the mount request is coming
+	 * from the legacy mount system call.
+	 */
+	fc->oldapi = true;
+
 	if (subtype)
 		err = vfs_parse_fs_string(fc, "subtype",
 					  subtype, strlen(subtype));
diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index 08108b6d2fa1..73000aa2d220 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -604,6 +604,8 @@ bl_find_get_deviceid(struct nfs_server *server,
 		nfs4_delete_deviceid(node->ld, node->nfs_client, id);
 		goto retry;
 	}
+
+	nfs4_put_deviceid_node(node);
 	return ERR_PTR(-ENODEV);
 }
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index f3f41027f697..7c3c96ed6085 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -177,6 +177,7 @@ static int nfs4_map_errors(int err)
 	case -NFS4ERR_RESOURCE:
 	case -NFS4ERR_LAYOUTTRYLATER:
 	case -NFS4ERR_RECALLCONFLICT:
+	case -NFS4ERR_RETURNCONFLICT:
 		return -EREMOTEIO;
 	case -NFS4ERR_WRONGSEC:
 	case -NFS4ERR_WRONG_CRED:
@@ -563,6 +564,7 @@ static int nfs4_do_handle_exception(struct nfs_server *server,
 		case -NFS4ERR_GRACE:
 		case -NFS4ERR_LAYOUTTRYLATER:
 		case -NFS4ERR_RECALLCONFLICT:
+		case -NFS4ERR_RETURNCONFLICT:
 			exception->delay = 1;
 			return 0;
 
@@ -9445,6 +9447,7 @@ nfs4_layoutget_handle_exception(struct rpc_task *task,
 		status = -EBUSY;
 		break;
 	case -NFS4ERR_RECALLCONFLICT:
+	case -NFS4ERR_RETURNCONFLICT:
 		status = -ERECALLCONFLICT;
 		break;
 	case -NFS4ERR_DELEG_REVOKED:
diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index a0fa3820ef2a..5ac9b1f155a8 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -190,7 +190,7 @@ static int persistent_ram_init_ecc(struct persistent_ram_zone *prz,
 {
 	int numerr;
 	struct persistent_ram_buffer *buffer = prz->buffer;
-	int ecc_blocks;
+	size_t ecc_blocks;
 	size_t ecc_total;
 
 	if (!ecc_info || !ecc_info->ecc_size)
diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index a5db86670bdf..a406e281ae57 100644
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -138,6 +138,7 @@ struct af_alg_async_req {
  *			recvmsg is invoked.
  * @init:		True if metadata has been sent.
  * @len:		Length of memory allocated for this data structure.
+ * @inflight:		Non-zero when AIO requests are in flight.
  */
 struct af_alg_ctx {
 	struct list_head tsgl_list;
@@ -156,6 +157,8 @@ struct af_alg_ctx {
 	bool init;
 
 	unsigned int len;
+
+	unsigned int inflight;
 };
 
 int af_alg_register_type(const struct af_alg_type *type);
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 055486e35e68..3826cf9553c0 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -186,7 +186,7 @@ struct drm_bridge_funcs {
 	 * or &drm_encoder_helper_funcs.dpms hook.
 	 *
 	 * The bridge must assume that the display pipe (i.e. clocks and timing
-	 * singals) feeding it is no longer running when this callback is
+	 * signals) feeding it is no longer running when this callback is
 	 * called.
 	 *
 	 * The @post_disable callback is optional.
diff --git a/include/dt-bindings/clock/qcom,videocc-sm8150.h b/include/dt-bindings/clock/qcom,videocc-sm8150.h
index e24ee840cfdb..c557b78dc572 100644
--- a/include/dt-bindings/clock/qcom,videocc-sm8150.h
+++ b/include/dt-bindings/clock/qcom,videocc-sm8150.h
@@ -16,6 +16,10 @@
 
 /* VIDEO_CC Resets */
 #define VIDEO_CC_MVSC_CORE_CLK_BCR	0
+#define VIDEO_CC_INTERFACE_BCR		1
+#define VIDEO_CC_MVS0_BCR		2
+#define VIDEO_CC_MVS1_BCR		3
+#define VIDEO_CC_MVSC_BCR		4
 
 /* VIDEO_CC GDSCRs */
 #define VENUS_GDSC			0
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index aa8cbf882914..6fa85be64b89 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -350,7 +350,7 @@ struct clk_hw *__clk_hw_register_fixed_rate(struct device *dev,
 		const char *parent_name, const struct clk_hw *parent_hw,
 		const struct clk_parent_data *parent_data, unsigned long flags,
 		unsigned long fixed_rate, unsigned long fixed_accuracy,
-		unsigned long clk_fixed_flags);
+		unsigned long clk_fixed_flags, bool devm);
 struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned long fixed_rate);
@@ -365,7 +365,20 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
  */
 #define clk_hw_register_fixed_rate(dev, name, parent_name, flags, fixed_rate)  \
 	__clk_hw_register_fixed_rate((dev), NULL, (name), (parent_name), NULL, \
-				     NULL, (flags), (fixed_rate), 0, 0)
+				     NULL, (flags), (fixed_rate), 0, 0, false)
+
+/**
+ * devm_clk_hw_register_fixed_rate - register fixed-rate clock with the clock
+ * framework
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @parent_name: name of clock's parent
+ * @flags: framework-specific flags
+ * @fixed_rate: non-adjustable clock rate
+ */
+#define devm_clk_hw_register_fixed_rate(dev, name, parent_name, flags, fixed_rate)  \
+	__clk_hw_register_fixed_rate((dev), NULL, (name), (parent_name), NULL, \
+				     NULL, (flags), (fixed_rate), 0, 0, true)
 /**
  * clk_hw_register_fixed_rate_parent_hw - register fixed-rate clock with
  * the clock framework
@@ -378,7 +391,7 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 #define clk_hw_register_fixed_rate_parent_hw(dev, name, parent_hw, flags,     \
 					     fixed_rate)		      \
 	__clk_hw_register_fixed_rate((dev), NULL, (name), NULL, (parent_hw),  \
-				     NULL, (flags), (fixed_rate), 0, 0)
+				     NULL, (flags), (fixed_rate), 0, 0, false)
 /**
  * clk_hw_register_fixed_rate_parent_data - register fixed-rate clock with
  * the clock framework
@@ -392,7 +405,7 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 					     fixed_rate)		      \
 	__clk_hw_register_fixed_rate((dev), NULL, (name), NULL, NULL,	      \
 				     (parent_data), (flags), (fixed_rate), 0, \
-				     0)
+				     0, false)
 /**
  * clk_hw_register_fixed_rate_with_accuracy - register fixed-rate clock with
  * the clock framework
@@ -408,7 +421,7 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 						 fixed_accuracy)	      \
 	__clk_hw_register_fixed_rate((dev), NULL, (name), (parent_name),      \
 				     NULL, NULL, (flags), (fixed_rate),       \
-				     (fixed_accuracy), 0)
+				     (fixed_accuracy), 0, false)
 /**
  * clk_hw_register_fixed_rate_with_accuracy_parent_hw - register fixed-rate
  * clock with the clock framework
@@ -421,9 +434,9 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
  */
 #define clk_hw_register_fixed_rate_with_accuracy_parent_hw(dev, name,	      \
 		parent_hw, flags, fixed_rate, fixed_accuracy)		      \
-	__clk_hw_register_fixed_rate((dev), NULL, (name), NULL, (parent_hw)   \
-				     NULL, NULL, (flags), (fixed_rate),	      \
-				     (fixed_accuracy), 0)
+	__clk_hw_register_fixed_rate((dev), NULL, (name), NULL, (parent_hw),  \
+				     NULL, (flags), (fixed_rate),	      \
+				     (fixed_accuracy), 0, false)
 /**
  * clk_hw_register_fixed_rate_with_accuracy_parent_data - register fixed-rate
  * clock with the clock framework
@@ -438,7 +451,7 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 		parent_data, flags, fixed_rate, fixed_accuracy)		      \
 	__clk_hw_register_fixed_rate((dev), NULL, (name), NULL, NULL,	      \
 				     (parent_data), NULL, (flags),	      \
-				     (fixed_rate), (fixed_accuracy), 0)
+				     (fixed_rate), (fixed_accuracy), 0, false)
 /**
  * clk_hw_register_fixed_rate_parent_accuracy - register fixed-rate clock with
  * the clock framework
@@ -452,7 +465,7 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 						   flags, fixed_rate)	      \
 	__clk_hw_register_fixed_rate((dev), NULL, (name), NULL, NULL,      \
 				     (parent_data), (flags), (fixed_rate), 0,    \
-				     CLK_FIXED_RATE_PARENT_ACCURACY)
+				     CLK_FIXED_RATE_PARENT_ACCURACY, false)
 
 void clk_unregister_fixed_rate(struct clk *clk);
 void clk_hw_unregister_fixed_rate(struct clk_hw *hw);
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index a5f89fc4d6df..ba1d93c662c6 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -165,6 +165,7 @@ static inline void dma_pernuma_cma_reserve(void) { }
 #ifdef CONFIG_DMA_DECLARE_COHERENT
 int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 		dma_addr_t device_addr, size_t size);
+void dma_release_coherent_memory(struct device *dev);
 int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
 		dma_addr_t *dma_handle, void **ret);
 int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr);
@@ -183,9 +184,11 @@ static inline int dma_declare_coherent_memory(struct device *dev,
 {
 	return -ENOSYS;
 }
+
 #define dma_alloc_from_dev_coherent(dev, size, handle, ret) (0)
 #define dma_release_from_dev_coherent(dev, order, vaddr) (0)
 #define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
+static inline void dma_release_coherent_memory(struct device *dev) { }
 
 static inline void *dma_alloc_from_global_coherent(struct device *dev,
 		ssize_t size, dma_addr_t *dma_handle)
diff --git a/include/linux/iio/adc/adi-axi-adc.h b/include/linux/iio/adc/adi-axi-adc.h
index c5d48e1c2d36..77b7f66e6fa8 100644
--- a/include/linux/iio/adc/adi-axi-adc.h
+++ b/include/linux/iio/adc/adi-axi-adc.h
@@ -41,6 +41,7 @@ struct adi_axi_adc_chip_info {
  * @reg_access		IIO debugfs_reg_access hook for the client ADC
  * @read_raw		IIO read_raw hook for the client ADC
  * @write_raw		IIO write_raw hook for the client ADC
+ * @read_avail		IIO read_avail hook for the client ADC
  */
 struct adi_axi_adc_conv {
 	const struct adi_axi_adc_chip_info		*chip_info;
@@ -54,6 +55,9 @@ struct adi_axi_adc_conv {
 	int (*write_raw)(struct adi_axi_adc_conv *conv,
 			 struct iio_chan_spec const *chan,
 			 int val, int val2, long mask);
+	int (*read_avail)(struct adi_axi_adc_conv *conv,
+			  struct iio_chan_spec const *chan,
+			  const int **val, int *type, int *length, long mask);
 };
 
 struct adi_axi_adc_conv *devm_adi_axi_adc_conv_register(struct device *dev,
diff --git a/include/linux/of.h b/include/linux/of.h
index 57f2d3dddc0c..4ed8dce624e7 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -415,130 +415,6 @@ extern int of_detach_node(struct device_node *);
 
 #define of_match_ptr(_ptr)	(_ptr)
 
-/**
- * of_property_read_u8_array - Find and read an array of u8 from a property.
- *
- * @np:		device node from which the property value is to be read.
- * @propname:	name of the property to be searched.
- * @out_values:	pointer to return value, modified only if return value is 0.
- * @sz:		number of array elements to read
- *
- * Search for a property in a device node and read 8-bit value(s) from
- * it.
- *
- * dts entry of array should be like:
- *  ``property = /bits/ 8 <0x50 0x60 0x70>;``
- *
- * Return: 0 on success, -EINVAL if the property does not exist,
- * -ENODATA if property does not have a value, and -EOVERFLOW if the
- * property data isn't large enough.
- *
- * The out_values is modified only if a valid u8 value can be decoded.
- */
-static inline int of_property_read_u8_array(const struct device_node *np,
-					    const char *propname,
-					    u8 *out_values, size_t sz)
-{
-	int ret = of_property_read_variable_u8_array(np, propname, out_values,
-						     sz, 0);
-	if (ret >= 0)
-		return 0;
-	else
-		return ret;
-}
-
-/**
- * of_property_read_u16_array - Find and read an array of u16 from a property.
- *
- * @np:		device node from which the property value is to be read.
- * @propname:	name of the property to be searched.
- * @out_values:	pointer to return value, modified only if return value is 0.
- * @sz:		number of array elements to read
- *
- * Search for a property in a device node and read 16-bit value(s) from
- * it.
- *
- * dts entry of array should be like:
- *  ``property = /bits/ 16 <0x5000 0x6000 0x7000>;``
- *
- * Return: 0 on success, -EINVAL if the property does not exist,
- * -ENODATA if property does not have a value, and -EOVERFLOW if the
- * property data isn't large enough.
- *
- * The out_values is modified only if a valid u16 value can be decoded.
- */
-static inline int of_property_read_u16_array(const struct device_node *np,
-					     const char *propname,
-					     u16 *out_values, size_t sz)
-{
-	int ret = of_property_read_variable_u16_array(np, propname, out_values,
-						      sz, 0);
-	if (ret >= 0)
-		return 0;
-	else
-		return ret;
-}
-
-/**
- * of_property_read_u32_array - Find and read an array of 32 bit integers
- * from a property.
- *
- * @np:		device node from which the property value is to be read.
- * @propname:	name of the property to be searched.
- * @out_values:	pointer to return value, modified only if return value is 0.
- * @sz:		number of array elements to read
- *
- * Search for a property in a device node and read 32-bit value(s) from
- * it.
- *
- * Return: 0 on success, -EINVAL if the property does not exist,
- * -ENODATA if property does not have a value, and -EOVERFLOW if the
- * property data isn't large enough.
- *
- * The out_values is modified only if a valid u32 value can be decoded.
- */
-static inline int of_property_read_u32_array(const struct device_node *np,
-					     const char *propname,
-					     u32 *out_values, size_t sz)
-{
-	int ret = of_property_read_variable_u32_array(np, propname, out_values,
-						      sz, 0);
-	if (ret >= 0)
-		return 0;
-	else
-		return ret;
-}
-
-/**
- * of_property_read_u64_array - Find and read an array of 64 bit integers
- * from a property.
- *
- * @np:		device node from which the property value is to be read.
- * @propname:	name of the property to be searched.
- * @out_values:	pointer to return value, modified only if return value is 0.
- * @sz:		number of array elements to read
- *
- * Search for a property in a device node and read 64-bit value(s) from
- * it.
- *
- * Return: 0 on success, -EINVAL if the property does not exist,
- * -ENODATA if property does not have a value, and -EOVERFLOW if the
- * property data isn't large enough.
- *
- * The out_values is modified only if a valid u64 value can be decoded.
- */
-static inline int of_property_read_u64_array(const struct device_node *np,
-					     const char *propname,
-					     u64 *out_values, size_t sz)
-{
-	int ret = of_property_read_variable_u64_array(np, propname, out_values,
-						      sz, 0);
-	if (ret >= 0)
-		return 0;
-	else
-		return ret;
-}
-
 /*
  * struct property *prop;
  * const __be32 *p;
@@ -726,32 +602,6 @@ static inline int of_property_count_elems_of_size(const struct device_node *np,
 	return -ENOSYS;
 }
 
-static inline int of_property_read_u8_array(const struct device_node *np,
-			const char *propname, u8 *out_values, size_t sz)
-{
-	return -ENOSYS;
-}
-
-static inline int of_property_read_u16_array(const struct device_node *np,
-			const char *propname, u16 *out_values, size_t sz)
-{
-	return -ENOSYS;
-}
-
-static inline int of_property_read_u32_array(const struct device_node *np,
-					     const char *propname,
-					     u32 *out_values, size_t sz)
-{
-	return -ENOSYS;
-}
-
-static inline int of_property_read_u64_array(const struct device_node *np,
-					     const char *propname,
-					     u64 *out_values, size_t sz)
-{
-	return -ENOSYS;
-}
-
 static inline int of_property_read_u32_index(const struct device_node *np,
 			const char *propname, u32 index, u32 *out_value)
 {
@@ -1211,7 +1061,8 @@ static inline int of_property_read_string_index(const struct device_node *np,
  * @np:		device node from which the property value is to be read.
  * @propname:	name of the property to be searched.
  *
- * Search for a property in a device node.
+ * Search for a boolean property in a device node. Usage on non-boolean
+ * property types is deprecated.
  *
  * Return: true if the property exists false otherwise.
  */
@@ -1223,6 +1074,144 @@ static inline bool of_property_read_bool(const struct device_node *np,
 	return prop ? true : false;
 }
 
+/**
+ * of_property_present - Test if a property is present in a node
+ * @np:		device node to search for the property.
+ * @propname:	name of the property to be searched.
+ *
+ * Test for a property present in a device node.
+ *
+ * Return: true if the property exists false otherwise.
+ */
+static inline bool of_property_present(const struct device_node *np, const char *propname)
+{
+	return of_property_read_bool(np, propname);
+}
+
+/**
+ * of_property_read_u8_array - Find and read an array of u8 from a property.
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @out_values:	pointer to return value, modified only if return value is 0.
+ * @sz:		number of array elements to read
+ *
+ * Search for a property in a device node and read 8-bit value(s) from
+ * it.
+ *
+ * dts entry of array should be like:
+ *  ``property = /bits/ 8 <0x50 0x60 0x70>;``
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
+ *
+ * The out_values is modified only if a valid u8 value can be decoded.
+ */
+static inline int of_property_read_u8_array(const struct device_node *np,
+					    const char *propname,
+					    u8 *out_values, size_t sz)
+{
+	int ret = of_property_read_variable_u8_array(np, propname, out_values,
+						     sz, 0);
+	if (ret >= 0)
+		return 0;
+	else
+		return ret;
+}
+
+/**
+ * of_property_read_u16_array - Find and read an array of u16 from a property.
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @out_values:	pointer to return value, modified only if return value is 0.
+ * @sz:		number of array elements to read
+ *
+ * Search for a property in a device node and read 16-bit value(s) from
+ * it.
+ *
+ * dts entry of array should be like:
+ *  ``property = /bits/ 16 <0x5000 0x6000 0x7000>;``
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
+ *
+ * The out_values is modified only if a valid u16 value can be decoded.
+ */
+static inline int of_property_read_u16_array(const struct device_node *np,
+					     const char *propname,
+					     u16 *out_values, size_t sz)
+{
+	int ret = of_property_read_variable_u16_array(np, propname, out_values,
+						      sz, 0);
+	if (ret >= 0)
+		return 0;
+	else
+		return ret;
+}
+
+/**
+ * of_property_read_u32_array - Find and read an array of 32 bit integers
+ * from a property.
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @out_values:	pointer to return value, modified only if return value is 0.
+ * @sz:		number of array elements to read
+ *
+ * Search for a property in a device node and read 32-bit value(s) from
+ * it.
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
+ *
+ * The out_values is modified only if a valid u32 value can be decoded.
+ */
+static inline int of_property_read_u32_array(const struct device_node *np,
+					     const char *propname,
+					     u32 *out_values, size_t sz)
+{
+	int ret = of_property_read_variable_u32_array(np, propname, out_values,
+						      sz, 0);
+	if (ret >= 0)
+		return 0;
+	else
+		return ret;
+}
+
+/**
+ * of_property_read_u64_array - Find and read an array of 64 bit integers
+ * from a property.
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @out_values:	pointer to return value, modified only if return value is 0.
+ * @sz:		number of array elements to read
+ *
+ * Search for a property in a device node and read 64-bit value(s) from
+ * it.
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
+ *
+ * The out_values is modified only if a valid u64 value can be decoded.
+ */
+static inline int of_property_read_u64_array(const struct device_node *np,
+					     const char *propname,
+					     u64 *out_values, size_t sz)
+{
+	int ret = of_property_read_variable_u64_array(np, propname, out_values,
+						      sz, 0);
+	if (ret >= 0)
+		return 0;
+	else
+		return ret;
+}
+
 static inline int of_property_read_u8(const struct device_node *np,
 				       const char *propname,
 				       u8 *out_value)
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index ef8d56b18da6..8716a1706351 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -366,6 +366,20 @@ static inline void rcu_preempt_sleep_check(void) { }
 #define rcu_check_sparse(p, space)
 #endif /* #else #ifdef __CHECKER__ */
 
+/**
+ * unrcu_pointer - mark a pointer as not being RCU protected
+ * @p: pointer needing to lose its __rcu property
+ *
+ * Converts @p from an __rcu pointer to a __kernel pointer.
+ * This allows an __rcu pointer to be used with xchg() and friends.
+ */
+#define unrcu_pointer(p)						\
+({									\
+	typeof(*p) *_________p1 = (typeof(*p) *__force)(p);		\
+	rcu_check_sparse(p, __rcu); 					\
+	((typeof(*p) __force __kernel *)(_________p1)); 		\
+})
+
 #define __rcu_access_pointer(p, space) \
 ({ \
 	typeof(*p) *_________p1 = (typeof(*p) *__force)READ_ONCE(p); \
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a168a64696b6..33873266b2bc 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -819,7 +819,6 @@ void hci_inquiry_cache_flush(struct hci_dev *hdev);
 /* ----- HCI Connections ----- */
 enum {
 	HCI_CONN_AUTH_PEND,
-	HCI_CONN_REAUTH_PEND,
 	HCI_CONN_ENCRYPT_PEND,
 	HCI_CONN_RSWITCH_PEND,
 	HCI_CONN_MODE_CHANGE_PEND,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 36ddfb98b70e..29cc0eb2e488 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3424,6 +3424,8 @@ union bpf_attr {
  * long bpf_get_task_stack(struct task_struct *task, void *buf, u32 size, u64 flags)
  *	Description
  *		Return a user or a kernel stack in bpf program provided buffer.
+ *		Note: the user stack will only be populated if the *task* is
+ *		the current task; all other tasks will return -EOPNOTSUPP.
  *		To achieve this, the helper needs *task*, which is a valid
  *		pointer to **struct task_struct**. To store the stacktrace, the
  *		bpf program provides *buf* with a nonnegative *size*.
@@ -3435,6 +3437,7 @@ union bpf_attr {
  *
  *		**BPF_F_USER_STACK**
  *			Collect a user space stack instead of a kernel stack.
+ *			The *task* must be the current task.
  *		**BPF_F_USER_BUILD_ID**
  *			Collect buildid+offset instead of ips for user stack,
  *			only valid if **BPF_F_USER_STACK** is also specified.
diff --git a/include/uapi/linux/virtio_crypto.h b/include/uapi/linux/virtio_crypto.h
index a03932f10565..71a54a6849ca 100644
--- a/include/uapi/linux/virtio_crypto.h
+++ b/include/uapi/linux/virtio_crypto.h
@@ -37,6 +37,7 @@
 #define VIRTIO_CRYPTO_SERVICE_HASH   1
 #define VIRTIO_CRYPTO_SERVICE_MAC    2
 #define VIRTIO_CRYPTO_SERVICE_AEAD   3
+#define VIRTIO_CRYPTO_SERVICE_AKCIPHER 4
 
 #define VIRTIO_CRYPTO_OPCODE(service, op)   (((service) << 8) | (op))
 
@@ -57,6 +58,10 @@ struct virtio_crypto_ctrl_header {
 	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x02)
 #define VIRTIO_CRYPTO_AEAD_DESTROY_SESSION \
 	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x03)
+#define VIRTIO_CRYPTO_AKCIPHER_CREATE_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x04)
+#define VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x05)
 	__le32 opcode;
 	__le32 algo;
 	__le32 flag;
@@ -180,6 +185,58 @@ struct virtio_crypto_aead_create_session_req {
 	__u8 padding[32];
 };
 
+struct virtio_crypto_rsa_session_para {
+#define VIRTIO_CRYPTO_RSA_RAW_PADDING   0
+#define VIRTIO_CRYPTO_RSA_PKCS1_PADDING 1
+	__le32 padding_algo;
+
+#define VIRTIO_CRYPTO_RSA_NO_HASH   0
+#define VIRTIO_CRYPTO_RSA_MD2       1
+#define VIRTIO_CRYPTO_RSA_MD3       2
+#define VIRTIO_CRYPTO_RSA_MD4       3
+#define VIRTIO_CRYPTO_RSA_MD5       4
+#define VIRTIO_CRYPTO_RSA_SHA1      5
+#define VIRTIO_CRYPTO_RSA_SHA256    6
+#define VIRTIO_CRYPTO_RSA_SHA384    7
+#define VIRTIO_CRYPTO_RSA_SHA512    8
+#define VIRTIO_CRYPTO_RSA_SHA224    9
+	__le32 hash_algo;
+};
+
+struct virtio_crypto_ecdsa_session_para {
+#define VIRTIO_CRYPTO_CURVE_UNKNOWN   0
+#define VIRTIO_CRYPTO_CURVE_NIST_P192 1
+#define VIRTIO_CRYPTO_CURVE_NIST_P224 2
+#define VIRTIO_CRYPTO_CURVE_NIST_P256 3
+#define VIRTIO_CRYPTO_CURVE_NIST_P384 4
+#define VIRTIO_CRYPTO_CURVE_NIST_P521 5
+	__le32 curve_id;
+	__le32 padding;
+};
+
+struct virtio_crypto_akcipher_session_para {
+#define VIRTIO_CRYPTO_NO_AKCIPHER    0
+#define VIRTIO_CRYPTO_AKCIPHER_RSA   1
+#define VIRTIO_CRYPTO_AKCIPHER_DSA   2
+#define VIRTIO_CRYPTO_AKCIPHER_ECDSA 3
+	__le32 algo;
+
+#define VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PUBLIC  1
+#define VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PRIVATE 2
+	__le32 keytype;
+	__le32 keylen;
+
+	union {
+		struct virtio_crypto_rsa_session_para rsa;
+		struct virtio_crypto_ecdsa_session_para ecdsa;
+	} u;
+};
+
+struct virtio_crypto_akcipher_create_session_req {
+	struct virtio_crypto_akcipher_session_para para;
+	__u8 padding[36];
+};
+
 struct virtio_crypto_alg_chain_session_para {
 #define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_HASH_THEN_CIPHER  1
 #define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_CIPHER_THEN_HASH  2
@@ -247,6 +304,8 @@ struct virtio_crypto_op_ctrl_req {
 			mac_create_session;
 		struct virtio_crypto_aead_create_session_req
 			aead_create_session;
+		struct virtio_crypto_akcipher_create_session_req
+			akcipher_create_session;
 		struct virtio_crypto_destroy_session_req
 			destroy_session;
 		__u8 padding[56];
@@ -266,6 +325,14 @@ struct virtio_crypto_op_header {
 	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x00)
 #define VIRTIO_CRYPTO_AEAD_DECRYPT \
 	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x01)
+#define VIRTIO_CRYPTO_AKCIPHER_ENCRYPT \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x00)
+#define VIRTIO_CRYPTO_AKCIPHER_DECRYPT \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x01)
+#define VIRTIO_CRYPTO_AKCIPHER_SIGN \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x02)
+#define VIRTIO_CRYPTO_AKCIPHER_VERIFY \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x03)
 	__le32 opcode;
 	/* algo should be service-specific algorithms */
 	__le32 algo;
@@ -390,6 +457,16 @@ struct virtio_crypto_aead_data_req {
 	__u8 padding[32];
 };
 
+struct virtio_crypto_akcipher_para {
+	__le32 src_data_len;
+	__le32 dst_data_len;
+};
+
+struct virtio_crypto_akcipher_data_req {
+	struct virtio_crypto_akcipher_para para;
+	__u8 padding[40];
+};
+
 /* The request of the data virtqueue's packet */
 struct virtio_crypto_op_data_req {
 	struct virtio_crypto_op_header header;
@@ -399,6 +476,7 @@ struct virtio_crypto_op_data_req {
 		struct virtio_crypto_hash_data_req hash_req;
 		struct virtio_crypto_mac_data_req mac_req;
 		struct virtio_crypto_aead_data_req aead_req;
+		struct virtio_crypto_akcipher_data_req akcipher_req;
 		__u8 padding[48];
 	} u;
 };
@@ -408,6 +486,8 @@ struct virtio_crypto_op_data_req {
 #define VIRTIO_CRYPTO_BADMSG    2
 #define VIRTIO_CRYPTO_NOTSUPP   3
 #define VIRTIO_CRYPTO_INVSESS   4 /* Invalid session id */
+#define VIRTIO_CRYPTO_NOSPC     5 /* no free session ID */
+#define VIRTIO_CRYPTO_KEY_REJECTED 6 /* Signature verification failed */
 
 /* The accelerator hardware is ready */
 #define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
@@ -438,7 +518,7 @@ struct virtio_crypto_config {
 	__le32 max_cipher_key_len;
 	/* Maximum length of authenticated key */
 	__le32 max_auth_key_len;
-	__le32 reserve;
+	__le32 akcipher_algo;
 	/* Maximum size of each crypto request's content */
 	__le64 max_size;
 };
diff --git a/init/do_mounts.c b/init/do_mounts.c
index b5f9604d0c98..8ef154fb418c 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -649,7 +649,10 @@ struct file_system_type rootfs_fs_type = {
 
 void __init init_rootfs(void)
 {
-	if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
-		(!root_fs_names || strstr(root_fs_names, "tmpfs")))
-		is_tmpfs = true;
+	if (IS_ENABLED(CONFIG_TMPFS)) {
+		if (!saved_root_name[0] && !root_fs_names)
+			is_tmpfs = true;
+		else if (root_fs_names && !!strstr(root_fs_names, "tmpfs"))
+			is_tmpfs = true;
+	}
 }
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index aa15e8d878a9..936abc6ee450 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3485,14 +3485,17 @@ static inline int io_rw_prep_async(struct io_kiocb *req, int rw)
 	struct iovec *iov = iorw->fast_iov;
 	int ret;
 
+	iorw->bytes_done = 0;
+	iorw->free_iovec = NULL;
+
 	ret = io_import_iovec(rw, req, &iov, &iorw->iter, false);
 	if (unlikely(ret < 0))
 		return ret;
 
-	iorw->bytes_done = 0;
-	iorw->free_iovec = iov;
-	if (iov)
+	if (iov) {
+		iorw->free_iovec = iov;
 		req->flags |= REQ_F_NEED_CLEANUP;
+	}
 	iov_iter_save_state(&iorw->iter, &iorw->iter_state);
 	return 0;
 }
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 00e32f2ec3e6..3c2d8722d45b 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -230,6 +230,9 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
 	struct lpm_trie_node *node, *found = NULL;
 	struct bpf_lpm_trie_key *key = _key;
 
+	if (key->prefixlen > trie->max_prefixlen)
+		return NULL;
+
 	/* Start walking the trie from the root node ... */
 
 	for (node = rcu_dereference(trie->root); node;) {
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 0c5bf98d5576..b8afea2ceeeb 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -575,6 +575,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 {
 	u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
 	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
+	bool crosstask = task && task != current;
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
 	bool user = flags & BPF_F_USER_STACK;
 	struct perf_callchain_entry *trace;
@@ -597,6 +598,14 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	if (task && user && !user_mode(regs))
 		goto err_fault;
 
+	/* get_perf_callchain does not support crosstask user stack walking
+	 * but returns an empty stack instead of NULL.
+	 */
+	if (crosstask && user) {
+		err = -EOPNOTSUPP;
+		goto clear;
+	}
+
 	num_elem = size / elem_size;
 	max_depth = num_elem + skip;
 	if (sysctl_perf_event_max_stack < max_depth)
@@ -608,7 +617,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		trace = get_callchain_entry_for_task(task, max_depth);
 	else
 		trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
-					   false, false);
+					   crosstask, false);
 	if (unlikely(!trace))
 		goto err_fault;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 45c50ee9b037..fce2345f600f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2493,7 +2493,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	 * so it's aligned access and [off, off + size) are within stack limits
 	 */
 	if (!env->allow_ptr_leaks &&
-	    state->stack[spi].slot_type[0] == STACK_SPILL &&
+	    is_spilled_reg(&state->stack[spi]) &&
 	    size != BPF_REG_SIZE) {
 		verbose(env, "attempt to corrupt spilled pointer on stack\n");
 		return -EACCES;
@@ -3926,10 +3926,7 @@ static int check_stack_access_within_bounds(
 
 	if (tnum_is_const(reg->var_off)) {
 		min_off = reg->var_off.value + off;
-		if (access_size > 0)
-			max_off = min_off + access_size - 1;
-		else
-			max_off = min_off;
+		max_off = min_off + access_size;
 	} else {
 		if (reg->smax_value >= BPF_MAX_VAR_OFF ||
 		    reg->smin_value <= -BPF_MAX_VAR_OFF) {
@@ -3938,15 +3935,12 @@ static int check_stack_access_within_bounds(
 			return -EACCES;
 		}
 		min_off = reg->smin_value + off;
-		if (access_size > 0)
-			max_off = reg->smax_value + off + access_size - 1;
-		else
-			max_off = min_off;
+		max_off = reg->smax_value + off + access_size;
 	}
 
 	err = check_stack_slot_within_bounds(min_off, state, type);
-	if (!err)
-		err = check_stack_slot_within_bounds(max_off, state, type);
+	if (!err && max_off > 0)
+		err = -EINVAL; /* out of stack access into non-negative offsets */
 
 	if (err) {
 		if (tnum_is_const(reg->var_off)) {
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 4e09fab52faf..c27b3dfa1921 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1364,8 +1364,6 @@ static int kdb_local(kdb_reason_t reason, int error, struct pt_regs *regs,
 		/* PROMPT can only be set if we have MEM_READ permission. */
 		snprintf(kdb_prompt_str, CMD_BUFLEN, kdbgetenv("PROMPT"),
 			 raw_smp_processor_id());
-		if (defcmd_in_progress)
-			strncat(kdb_prompt_str, "[defcmd]", CMD_BUFLEN);
 
 		/*
 		 * Fetch command from keyboard
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 5b5b6c7ec7f2..49aaad3936f1 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -84,7 +84,7 @@ static int dma_init_coherent_memory(phys_addr_t phys_addr,
 	return ret;
 }
 
-static void dma_release_coherent_memory(struct dma_coherent_mem *mem)
+static void _dma_release_coherent_memory(struct dma_coherent_mem *mem)
 {
 	if (!mem)
 		return;
@@ -136,10 +136,18 @@ int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 
 	ret = dma_assign_coherent_memory(dev, mem);
 	if (ret)
-		dma_release_coherent_memory(mem);
+		_dma_release_coherent_memory(mem);
 	return ret;
 }
 
+void dma_release_coherent_memory(struct device *dev)
+{
+	if (dev) {
+		_dma_release_coherent_memory(dev->dma_mem);
+		dev->dma_mem = NULL;
+	}
+}
+
 static void *__dma_alloc_from_coherent(struct device *dev,
 				       struct dma_coherent_mem *mem,
 				       ssize_t size, dma_addr_t *dma_handle)
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f1ea3123f383..05d3e156a7d6 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -545,17 +545,15 @@ static void do_unoptimize_kprobes(void)
 	/* See comment in do_optimize_kprobes() */
 	lockdep_assert_cpus_held();
 
-	/* Unoptimization must be done anytime */
-	if (list_empty(&unoptimizing_list))
-		return;
+	if (!list_empty(&unoptimizing_list))
+		arch_unoptimize_kprobes(&unoptimizing_list, &freeing_list);
 
-	arch_unoptimize_kprobes(&unoptimizing_list, &freeing_list);
-	/* Loop free_list for disarming */
+	/* Loop on 'freeing_list' for disarming and removing from kprobe hash list */
 	list_for_each_entry_safe(op, tmp, &freeing_list, list) {
 		/* Switching from detour code to origin */
 		op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
-		/* Disarm probes if marked disabled */
-		if (kprobe_disabled(&op->kp))
+		/* Disarm probes if marked disabled and not gone */
+		if (kprobe_disabled(&op->kp) && !kprobe_gone(&op->kp))
 			arch_disarm_kprobe(&op->kp);
 		if (kprobe_unused(&op->kp)) {
 			/*
@@ -784,14 +782,13 @@ static void kill_optimized_kprobe(struct kprobe *p)
 	op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
 
 	if (kprobe_unused(p)) {
-		/* Enqueue if it is unused */
-		list_add(&op->list, &freeing_list);
 		/*
-		 * Remove unused probes from the hash list. After waiting
-		 * for synchronization, this probe is reclaimed.
-		 * (reclaiming is done by do_free_cleaned_kprobes().)
+		 * Unused kprobe is on unoptimizing or freeing list. We move it
+		 * to freeing_list and let the kprobe_optimizer() remove it from
+		 * the kprobe hash list and free it.
 		 */
-		hlist_del_rcu(&op->kp.hlist);
+		if (optprobe_queued_unopt(op))
+			list_move(&op->list, &freeing_list);
 	}
 
 	/* Don't touch the code, because it is already freed. */
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index fc79b04b5947..bc00ab0118e6 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1439,13 +1439,18 @@ void tick_setup_sched_timer(void)
 void tick_cancel_sched_timer(int cpu)
 {
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
+	ktime_t idle_sleeptime, iowait_sleeptime;
 
 # ifdef CONFIG_HIGH_RES_TIMERS
 	if (ts->sched_timer.base)
 		hrtimer_cancel(&ts->sched_timer);
 # endif
 
+	idle_sleeptime = ts->idle_sleeptime;
+	iowait_sleeptime = ts->iowait_sleeptime;
 	memset(ts, 0, sizeof(*ts));
+	ts->idle_sleeptime = idle_sleeptime;
+	ts->iowait_sleeptime = iowait_sleeptime;
 }
 #endif
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 5abe88091803..041b91c2ba10 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3444,6 +3444,12 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	int nr_loops = 0;
 	int add_ts_default;
 
+	/* ring buffer does cmpxchg, make sure it is safe in NMI context */
+	if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) &&
+	    (unlikely(in_nmi()))) {
+		return NULL;
+	}
+
 	rb_start_commit(cpu_buffer);
 	/* The commit page can not change after this */
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0cbf833bebcc..548f694fc857 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4339,7 +4339,11 @@ static int s_show(struct seq_file *m, void *v)
 		iter->leftover = ret;
 
 	} else {
-		print_trace_line(iter);
+		ret = print_trace_line(iter);
+		if (ret == TRACE_TYPE_PARTIAL_LINE) {
+			iter->seq.full = 0;
+			trace_seq_puts(&iter->seq, "[LINE TOO BIG]\n");
+		}
 		ret = trace_print_seq(m, &iter->seq);
 		/*
 		 * If we overflow the seq_file buffer, then it will
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 94b0991717b6..753b84c50848 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1313,11 +1313,12 @@ static enum print_line_t trace_print_print(struct trace_iterator *iter,
 {
 	struct print_entry *field;
 	struct trace_seq *s = &iter->seq;
+	int max = iter->ent_size - offsetof(struct print_entry, buf);
 
 	trace_assign_type(field, iter->ent);
 
 	seq_print_ip_sym(s, field->ip, flags);
-	trace_seq_printf(s, ": %s", field->buf);
+	trace_seq_printf(s, ": %.*s", max, field->buf);
 
 	return trace_handle_return(s);
 }
@@ -1326,10 +1327,11 @@ static enum print_line_t trace_print_raw(struct trace_iterator *iter, int flags,
 					 struct trace_event *event)
 {
 	struct print_entry *field;
+	int max = iter->ent_size - offsetof(struct print_entry, buf);
 
 	trace_assign_type(field, iter->ent);
 
-	trace_seq_printf(&iter->seq, "# %lx %s", field->ip, field->buf);
+	trace_seq_printf(&iter->seq, "# %lx %.*s", field->ip, max, field->buf);
 
 	return trace_handle_return(&iter->seq);
 }
diff --git a/lib/idr.c b/lib/idr.c
index 13f2758c2377..da36054c3ca0 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -508,7 +508,7 @@ void ida_free(struct ida *ida, unsigned int id)
 			goto delete;
 		xas_store(&xas, xa_mk_value(v));
 	} else {
-		if (!test_bit(bit, bitmap->bitmap))
+		if (!bitmap || !test_bit(bit, bitmap->bitmap))
 			goto err;
 		__clear_bit(bit, bitmap->bitmap);
 		xas_set_mark(&xas, XA_FREE_MARK);
diff --git a/lib/test_ida.c b/lib/test_ida.c
index b06880625961..55105baa19da 100644
--- a/lib/test_ida.c
+++ b/lib/test_ida.c
@@ -150,6 +150,45 @@ static void ida_check_conv(struct ida *ida)
 	IDA_BUG_ON(ida, !ida_is_empty(ida));
 }
 
+/*
+ * Check various situations where we attempt to free an ID we don't own.
+ */
+static void ida_check_bad_free(struct ida *ida)
+{
+	unsigned long i;
+
+	printk("vvv Ignore \"not allocated\" warnings\n");
+	/* IDA is empty; all of these will fail */
+	ida_free(ida, 0);
+	for (i = 0; i < 31; i++)
+		ida_free(ida, 1 << i);
+
+	/* IDA contains a single value entry */
+	IDA_BUG_ON(ida, ida_alloc_min(ida, 3, GFP_KERNEL) != 3);
+	ida_free(ida, 0);
+	for (i = 0; i < 31; i++)
+		ida_free(ida, 1 << i);
+
+	/* IDA contains a single bitmap */
+	IDA_BUG_ON(ida, ida_alloc_min(ida, 1023, GFP_KERNEL) != 1023);
+	ida_free(ida, 0);
+	for (i = 0; i < 31; i++)
+		ida_free(ida, 1 << i);
+
+	/* IDA contains a tree */
+	IDA_BUG_ON(ida, ida_alloc_min(ida, (1 << 20) - 1, GFP_KERNEL) != (1 << 20) - 1);
+	ida_free(ida, 0);
+	for (i = 0; i < 31; i++)
+		ida_free(ida, 1 << i);
+	printk("^^^ \"not allocated\" warnings over\n");
+
+	ida_free(ida, 3);
+	ida_free(ida, 1023);
+	ida_free(ida, (1 << 20) - 1);
+
+	IDA_BUG_ON(ida, !ida_is_empty(ida));
+}
+
 static DEFINE_IDA(ida);
 
 static int ida_checks(void)
@@ -162,6 +201,7 @@ static int ida_checks(void)
 	ida_check_leaf(&ida, 1024 * 64);
 	ida_check_max(&ida);
 	ida_check_conv(&ida);
+	ida_check_bad_free(&ida);
 
 	printk("IDA: %u of %u tests passed\n", tests_passed, tests_run);
 	return (tests_run != tests_passed) ? 0 : -EINVAL;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 74721c3e49b3..52e512f41da3 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1385,12 +1385,10 @@ static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 		hci_send_cmd(conn->hdev, HCI_OP_AUTH_REQUESTED,
 			     sizeof(cp), &cp);
 
-		/* If we're already encrypted set the REAUTH_PEND flag,
-		 * otherwise set the ENCRYPT_PEND.
+		/* Set the ENCRYPT_PEND to trigger encryption after
+		 * authentication.
 		 */
-		if (test_bit(HCI_CONN_ENCRYPT, &conn->flags))
-			set_bit(HCI_CONN_REAUTH_PEND, &conn->flags);
-		else
+		if (!test_bit(HCI_CONN_ENCRYPT, &conn->flags))
 			set_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
 	}
 
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 338833f12365..d4efc4aa55af 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -994,10 +994,12 @@ static int min_key_size_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val > hdev->le_max_key_size || val < SMP_MIN_ENC_KEY_SIZE)
+	hci_dev_lock(hdev);
+	if (val > hdev->le_max_key_size || val < SMP_MIN_ENC_KEY_SIZE) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->le_min_key_size = val;
 	hci_dev_unlock(hdev);
 
@@ -1022,10 +1024,12 @@ static int max_key_size_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val > SMP_MAX_ENC_KEY_SIZE || val < hdev->le_min_key_size)
+	hci_dev_lock(hdev);
+	if (val > SMP_MAX_ENC_KEY_SIZE || val < hdev->le_min_key_size) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->le_max_key_size = val;
 	hci_dev_unlock(hdev);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ee2c1a17366a..4027c79786fd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2924,14 +2924,8 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (!ev->status) {
 		clear_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
-
-		if (!hci_conn_ssp_enabled(conn) &&
-		    test_bit(HCI_CONN_REAUTH_PEND, &conn->flags)) {
-			bt_dev_info(hdev, "re-auth of legacy device is not possible.");
-		} else {
-			set_bit(HCI_CONN_AUTH, &conn->flags);
-			conn->sec_level = conn->pending_sec_level;
-		}
+		set_bit(HCI_CONN_AUTH, &conn->flags);
+		conn->sec_level = conn->pending_sec_level;
 	} else {
 		if (ev->status == HCI_ERROR_PIN_OR_KEY_MISSING)
 			set_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
@@ -2940,7 +2934,6 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	clear_bit(HCI_CONN_AUTH_PEND, &conn->flags);
-	clear_bit(HCI_CONN_REAUTH_PEND, &conn->flags);
 
 	if (conn->state == BT_CONFIG) {
 		if (!ev->status && hci_conn_ssp_enabled(conn)) {
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 4c43183a8d93..432e3a64dc4a 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -226,9 +226,11 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 {
 	int max_clean = atomic_read(&tbl->gc_entries) -
 			READ_ONCE(tbl->gc_thresh2);
+	u64 tmax = ktime_get_ns() + NSEC_PER_MSEC;
 	unsigned long tref = jiffies - 5 * HZ;
 	struct neighbour *n, *tmp;
 	int shrunk = 0;
+	int loop = 0;
 
 	NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
 
@@ -251,11 +253,16 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 				shrunk++;
 			if (shrunk >= max_clean)
 				break;
+			if (++loop == 16) {
+				if (ktime_get_ns() > tmax)
+					goto unlock;
+				loop = 0;
+			}
 		}
 	}
 
 	WRITE_ONCE(tbl->last_flush, jiffies);
-
+unlock:
 	write_unlock_bh(&tbl->lock);
 
 	return shrunk;
diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index 8324e9f97066..26a9d8434c23 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -104,7 +104,7 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
 		const struct dns_server_list_v1_header *v1;
 
 		/* It may be a server list. */
-		if (datalen <= sizeof(*v1))
+		if (datalen < sizeof(*v1))
 			return -EINVAL;
 
 		v1 = (const struct dns_server_list_v1_header *)data;
diff --git a/net/ethtool/features.c b/net/ethtool/features.c
index 1c9f4df273bd..faccab84d865 100644
--- a/net/ethtool/features.c
+++ b/net/ethtool/features.c
@@ -235,17 +235,20 @@ int ethnl_set_features(struct sk_buff *skb, struct genl_info *info)
 	dev = req_info.dev;
 
 	rtnl_lock();
+	ret = ethnl_ops_begin(dev);
+	if (ret < 0)
+		goto out_rtnl;
 	ethnl_features_to_bitmap(old_active, dev->features);
 	ethnl_features_to_bitmap(old_wanted, dev->wanted_features);
 	ret = ethnl_parse_bitset(req_wanted, req_mask, NETDEV_FEATURE_COUNT,
 				 tb[ETHTOOL_A_FEATURES_WANTED],
 				 netdev_features_strings, info->extack);
 	if (ret < 0)
-		goto out_rtnl;
+		goto out_ops;
 	if (ethnl_bitmap_to_features(req_mask) & ~NETIF_F_ETHTOOL_BITS) {
 		GENL_SET_ERR_MSG(info, "attempt to change non-ethtool features");
 		ret = -EINVAL;
-		goto out_rtnl;
+		goto out_ops;
 	}
 
 	/* set req_wanted bits not in req_mask from old_wanted */
@@ -282,6 +285,8 @@ int ethnl_set_features(struct sk_buff *skb, struct genl_info *info)
 	if (mod)
 		netdev_features_change(dev);
 
+out_ops:
+	ethnl_ops_complete(dev);
 out_rtnl:
 	rtnl_unlock();
 	dev_put(dev);
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index a03a322e0cc1..edf4a842506f 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -427,7 +427,7 @@ __u16 ip6_tnl_parse_tlv_enc_lim(struct sk_buff *skb, __u8 *raw)
 	const struct ipv6hdr *ipv6h = (const struct ipv6hdr *)raw;
 	unsigned int nhoff = raw - skb->data;
 	unsigned int off = nhoff + sizeof(*ipv6h);
-	u8 next, nexthdr = ipv6h->nexthdr;
+	u8 nexthdr = ipv6h->nexthdr;
 
 	while (ipv6_ext_hdr(nexthdr) && nexthdr != NEXTHDR_NONE) {
 		struct ipv6_opt_hdr *hdr;
@@ -438,25 +438,25 @@ __u16 ip6_tnl_parse_tlv_enc_lim(struct sk_buff *skb, __u8 *raw)
 
 		hdr = (struct ipv6_opt_hdr *)(skb->data + off);
 		if (nexthdr == NEXTHDR_FRAGMENT) {
-			struct frag_hdr *frag_hdr = (struct frag_hdr *) hdr;
-			if (frag_hdr->frag_off)
-				break;
 			optlen = 8;
 		} else if (nexthdr == NEXTHDR_AUTH) {
 			optlen = ipv6_authlen(hdr);
 		} else {
 			optlen = ipv6_optlen(hdr);
 		}
-		/* cache hdr->nexthdr, since pskb_may_pull() might
-		 * invalidate hdr
-		 */
-		next = hdr->nexthdr;
-		if (nexthdr == NEXTHDR_DEST) {
-			u16 i = 2;
 
-			/* Remember : hdr is no longer valid at this point. */
-			if (!pskb_may_pull(skb, off + optlen))
+		if (!pskb_may_pull(skb, off + optlen))
+			break;
+
+		hdr = (struct ipv6_opt_hdr *)(skb->data + off);
+		if (nexthdr == NEXTHDR_FRAGMENT) {
+			struct frag_hdr *frag_hdr = (struct frag_hdr *)hdr;
+
+			if (frag_hdr->frag_off)
 				break;
+		}
+		if (nexthdr == NEXTHDR_DEST) {
+			u16 i = 2;
 
 			while (1) {
 				struct ipv6_tlv_tnl_enc_lim *tel;
@@ -477,7 +477,7 @@ __u16 ip6_tnl_parse_tlv_enc_lim(struct sk_buff *skb, __u8 *raw)
 					i++;
 			}
 		}
-		nexthdr = next;
+		nexthdr = hdr->nexthdr;
 		off += optlen;
 	}
 	return 0;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 64afe71e2129..c389d7e47135 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -92,6 +92,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->dss = 1;
 			mp_opt->use_map = 1;
 			mp_opt->mpc_map = 1;
+			mp_opt->use_ack = 0;
 			mp_opt->data_len = get_unaligned_be16(ptr);
 			ptr += 2;
 		}
diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index e37102546be6..ec765f2a7569 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -98,9 +98,12 @@ enum {
 
 
 struct ncsi_channel_version {
-	u32 version;		/* Supported BCD encoded NCSI version */
-	u32 alpha2;		/* Supported BCD encoded NCSI version */
-	u8  fw_name[12];	/* Firware name string                */
+	u8   major;		/* NCSI version major */
+	u8   minor;		/* NCSI version minor */
+	u8   update;		/* NCSI version update */
+	char alpha1;		/* NCSI version alpha1 */
+	char alpha2;		/* NCSI version alpha2 */
+	u8  fw_name[12];	/* Firmware name string                */
 	u32 fw_version;		/* Firmware version                   */
 	u16 pci_ids[4];		/* PCI identification                 */
 	u32 mf_id;		/* Manufacture ID                     */
diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
index c189b4c8a182..db350b8f5d88 100644
--- a/net/ncsi/ncsi-netlink.c
+++ b/net/ncsi/ncsi-netlink.c
@@ -71,8 +71,8 @@ static int ncsi_write_channel_info(struct sk_buff *skb,
 	if (nc == nc->package->preferred_channel)
 		nla_put_flag(skb, NCSI_CHANNEL_ATTR_FORCED);
 
-	nla_put_u32(skb, NCSI_CHANNEL_ATTR_VERSION_MAJOR, nc->version.version);
-	nla_put_u32(skb, NCSI_CHANNEL_ATTR_VERSION_MINOR, nc->version.alpha2);
+	nla_put_u32(skb, NCSI_CHANNEL_ATTR_VERSION_MAJOR, nc->version.major);
+	nla_put_u32(skb, NCSI_CHANNEL_ATTR_VERSION_MINOR, nc->version.minor);
 	nla_put_string(skb, NCSI_CHANNEL_ATTR_VERSION_STR, nc->version.fw_name);
 
 	vid_nest = nla_nest_start_noflag(skb, NCSI_CHANNEL_ATTR_VLAN_LIST);
diff --git a/net/ncsi/ncsi-pkt.h b/net/ncsi/ncsi-pkt.h
index 80938b338fee..3fbea7e74fb1 100644
--- a/net/ncsi/ncsi-pkt.h
+++ b/net/ncsi/ncsi-pkt.h
@@ -191,9 +191,12 @@ struct ncsi_rsp_gls_pkt {
 /* Get Version ID */
 struct ncsi_rsp_gvi_pkt {
 	struct ncsi_rsp_pkt_hdr rsp;          /* Response header */
-	__be32                  ncsi_version; /* NCSI version    */
+	unsigned char           major;        /* NCSI version major */
+	unsigned char           minor;        /* NCSI version minor */
+	unsigned char           update;       /* NCSI version update */
+	unsigned char           alpha1;       /* NCSI version alpha1 */
 	unsigned char           reserved[3];  /* Reserved        */
-	unsigned char           alpha2;       /* NCSI version    */
+	unsigned char           alpha2;       /* NCSI version alpha2 */
 	unsigned char           fw_name[12];  /* f/w name string */
 	__be32                  fw_version;   /* f/w version     */
 	__be16                  pci_ids[4];   /* PCI IDs         */
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 888ccc2d4e34..6a4638811660 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -19,6 +19,19 @@
 #include "ncsi-pkt.h"
 #include "ncsi-netlink.h"
 
+/* Nibbles within [0xA, 0xF] add zero "0" to the returned value.
+ * Optional fields (encoded as 0xFF) will default to zero.
+ */
+static u8 decode_bcd_u8(u8 x)
+{
+	int lo = x & 0xF;
+	int hi = x >> 4;
+
+	lo = lo < 0xA ? lo : 0;
+	hi = hi < 0xA ? hi : 0;
+	return lo + hi * 10;
+}
+
 static int ncsi_validate_rsp_pkt(struct ncsi_request *nr,
 				 unsigned short payload)
 {
@@ -755,9 +768,18 @@ static int ncsi_rsp_handler_gvi(struct ncsi_request *nr)
 	if (!nc)
 		return -ENODEV;
 
-	/* Update to channel's version info */
+	/* Update channel's version info
+	 *
+	 * Major, minor, and update fields are supposed to be
+	 * unsigned integers encoded as packed BCD.
+	 *
+	 * Alpha1 and alpha2 are ISO/IEC 8859-1 characters.
+	 */
 	ncv = &nc->version;
-	ncv->version = ntohl(rsp->ncsi_version);
+	ncv->major = decode_bcd_u8(rsp->major);
+	ncv->minor = decode_bcd_u8(rsp->minor);
+	ncv->update = decode_bcd_u8(rsp->update);
+	ncv->alpha1 = rsp->alpha1;
 	ncv->alpha2 = rsp->alpha2;
 	memcpy(ncv->fw_name, rsp->fw_name, 12);
 	ncv->fw_version = ntohl(rsp->fw_version);
diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index cd2130e98836..c87dbc897002 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -271,7 +271,7 @@ static inline bool decrement_ttl(struct netns_ipvs *ipvs,
 			skb->dev = dst->dev;
 			icmpv6_send(skb, ICMPV6_TIME_EXCEED,
 				    ICMPV6_EXC_HOPLIMIT, 0);
-			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
+			IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
 
 			return false;
 		}
@@ -286,7 +286,7 @@ static inline bool decrement_ttl(struct netns_ipvs *ipvs,
 	{
 		if (ip_hdr(skb)->ttl <= 1) {
 			/* Tell the sender its packet died... */
-			__IP_INC_STATS(net, IPSTATS_MIB_INHDRERRORS);
+			IP_INC_STATS(net, IPSTATS_MIB_INHDRERRORS);
 			icmp_send(skb, ICMP_TIME_EXCEEDED, ICMP_EXC_TTL, 0);
 			return false;
 		}
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 4d1a009dab45..fca8f9a36063 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4302,8 +4302,8 @@ static int nft_set_desc_concat_parse(const struct nlattr *attr,
 static int nft_set_desc_concat(struct nft_set_desc *desc,
 			       const struct nlattr *nla)
 {
+	u32 num_regs = 0, key_num_regs = 0;
 	struct nlattr *attr;
-	u32 num_regs = 0;
 	int rem, err, i;
 
 	nla_for_each_nested(attr, nla, rem) {
@@ -4318,6 +4318,10 @@ static int nft_set_desc_concat(struct nft_set_desc *desc,
 	for (i = 0; i < desc->field_count; i++)
 		num_regs += DIV_ROUND_UP(desc->field_len[i], sizeof(u32));
 
+	key_num_regs = DIV_ROUND_UP(desc->klen, sizeof(u32));
+	if (key_num_regs != num_regs)
+		return -EINVAL;
+
 	if (num_regs > NFT_REG32_COUNT)
 		return -E2BIG;
 
@@ -4462,8 +4466,12 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 		if (err < 0)
 			return err;
 
-		if (desc.field_count > 1 && !(flags & NFT_SET_CONCAT))
+		if (desc.field_count > 1) {
+			if (!(flags & NFT_SET_CONCAT))
+				return -EINVAL;
+		} else if (flags & NFT_SET_CONCAT) {
 			return -EINVAL;
+		}
 	} else if (flags & NFT_SET_CONCAT) {
 		return -EINVAL;
 	}
@@ -5007,7 +5015,7 @@ static int nf_tables_dump_setelem(const struct nft_ctx *ctx,
 	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
 	struct nft_set_dump_args *args;
 
-	if (nft_set_elem_expired(ext))
+	if (nft_set_elem_expired(ext) || nft_set_elem_is_dead(ext))
 		return 0;
 
 	args = container_of(iter, struct nft_set_dump_args, iter);
@@ -8840,6 +8848,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 				nft_trans_destroy(trans);
 				break;
 			}
+			nft_trans_set(trans)->dead = 1;
 			list_del_rcu(&nft_trans_set(trans)->list);
 			break;
 		case NFT_MSG_DELSET:
diff --git a/net/netlabel/netlabel_calipso.c b/net/netlabel/netlabel_calipso.c
index 4e62f2ad3575..84ef4a29864b 100644
--- a/net/netlabel/netlabel_calipso.c
+++ b/net/netlabel/netlabel_calipso.c
@@ -54,6 +54,28 @@ static const struct nla_policy calipso_genl_policy[NLBL_CALIPSO_A_MAX + 1] = {
 	[NLBL_CALIPSO_A_MTYPE] = { .type = NLA_U32 },
 };
 
+static const struct netlbl_calipso_ops *calipso_ops;
+
+/**
+ * netlbl_calipso_ops_register - Register the CALIPSO operations
+ * @ops: ops to register
+ *
+ * Description:
+ * Register the CALIPSO packet engine operations.
+ *
+ */
+const struct netlbl_calipso_ops *
+netlbl_calipso_ops_register(const struct netlbl_calipso_ops *ops)
+{
+	return xchg(&calipso_ops, ops);
+}
+EXPORT_SYMBOL(netlbl_calipso_ops_register);
+
+static const struct netlbl_calipso_ops *netlbl_calipso_ops_get(void)
+{
+	return READ_ONCE(calipso_ops);
+}
+
 /* NetLabel Command Handlers
  */
 /**
@@ -96,16 +118,19 @@ static int netlbl_calipso_add_pass(struct genl_info *info,
  *
  */
 static int netlbl_calipso_add(struct sk_buff *skb, struct genl_info *info)
-
 {
 	int ret_val = -EINVAL;
 	struct netlbl_audit audit_info;
+	const struct netlbl_calipso_ops *ops = netlbl_calipso_ops_get();
 
 	if (!info->attrs[NLBL_CALIPSO_A_DOI] ||
 	    !info->attrs[NLBL_CALIPSO_A_MTYPE])
 		return -EINVAL;
 
-	netlbl_netlink_auditinfo(skb, &audit_info);
+	if (!ops)
+		return -EOPNOTSUPP;
+
+	netlbl_netlink_auditinfo(&audit_info);
 	switch (nla_get_u32(info->attrs[NLBL_CALIPSO_A_MTYPE])) {
 	case CALIPSO_MAP_PASS:
 		ret_val = netlbl_calipso_add_pass(info, &audit_info);
@@ -287,7 +312,7 @@ static int netlbl_calipso_remove(struct sk_buff *skb, struct genl_info *info)
 	if (!info->attrs[NLBL_CALIPSO_A_DOI])
 		return -EINVAL;
 
-	netlbl_netlink_auditinfo(skb, &audit_info);
+	netlbl_netlink_auditinfo(&audit_info);
 	cb_arg.doi = nla_get_u32(info->attrs[NLBL_CALIPSO_A_DOI]);
 	cb_arg.audit_info = &audit_info;
 	ret_val = netlbl_domhsh_walk(&skip_bkt, &skip_chain,
@@ -362,27 +387,6 @@ int __init netlbl_calipso_genl_init(void)
 	return genl_register_family(&netlbl_calipso_gnl_family);
 }
 
-static const struct netlbl_calipso_ops *calipso_ops;
-
-/**
- * netlbl_calipso_ops_register - Register the CALIPSO operations
- *
- * Description:
- * Register the CALIPSO packet engine operations.
- *
- */
-const struct netlbl_calipso_ops *
-netlbl_calipso_ops_register(const struct netlbl_calipso_ops *ops)
-{
-	return xchg(&calipso_ops, ops);
-}
-EXPORT_SYMBOL(netlbl_calipso_ops_register);
-
-static const struct netlbl_calipso_ops *netlbl_calipso_ops_get(void)
-{
-	return READ_ONCE(calipso_ops);
-}
-
 /**
  * calipso_doi_add - Add a new DOI to the CALIPSO protocol engine
  * @doi_def: the DOI structure
diff --git a/net/netlabel/netlabel_cipso_v4.c b/net/netlabel/netlabel_cipso_v4.c
index f3f1df1b0f8e..894e6b8f1a86 100644
--- a/net/netlabel/netlabel_cipso_v4.c
+++ b/net/netlabel/netlabel_cipso_v4.c
@@ -410,7 +410,7 @@ static int netlbl_cipsov4_add(struct sk_buff *skb, struct genl_info *info)
 	    !info->attrs[NLBL_CIPSOV4_A_MTYPE])
 		return -EINVAL;
 
-	netlbl_netlink_auditinfo(skb, &audit_info);
+	netlbl_netlink_auditinfo(&audit_info);
 	switch (nla_get_u32(info->attrs[NLBL_CIPSOV4_A_MTYPE])) {
 	case CIPSO_V4_MAP_TRANS:
 		ret_val = netlbl_cipsov4_add_std(info, &audit_info);
@@ -709,7 +709,7 @@ static int netlbl_cipsov4_remove(struct sk_buff *skb, struct genl_info *info)
 	if (!info->attrs[NLBL_CIPSOV4_A_DOI])
 		return -EINVAL;
 
-	netlbl_netlink_auditinfo(skb, &audit_info);
+	netlbl_netlink_auditinfo(&audit_info);
 	cb_arg.doi = nla_get_u32(info->attrs[NLBL_CIPSOV4_A_DOI]);
 	cb_arg.audit_info = &audit_info;
 	ret_val = netlbl_domhsh_walk(&skip_bkt, &skip_chain,
diff --git a/net/netlabel/netlabel_mgmt.c b/net/netlabel/netlabel_mgmt.c
index 02a97bca1a1a..750a7a842ab9 100644
--- a/net/netlabel/netlabel_mgmt.c
+++ b/net/netlabel/netlabel_mgmt.c
@@ -435,7 +435,7 @@ static int netlbl_mgmt_add(struct sk_buff *skb, struct genl_info *info)
 	     (info->attrs[NLBL_MGMT_A_IPV6MASK] != NULL)))
 		return -EINVAL;
 
-	netlbl_netlink_auditinfo(skb, &audit_info);
+	netlbl_netlink_auditinfo(&audit_info);
 
 	return netlbl_mgmt_add_common(info, &audit_info);
 }
@@ -458,7 +458,7 @@ static int netlbl_mgmt_remove(struct sk_buff *skb, struct genl_info *info)
 	if (!info->attrs[NLBL_MGMT_A_DOMAIN])
 		return -EINVAL;
 
-	netlbl_netlink_auditinfo(skb, &audit_info);
+	netlbl_netlink_auditinfo(&audit_info);
 
 	domain = nla_data(info->attrs[NLBL_MGMT_A_DOMAIN]);
 	return netlbl_domhsh_remove(domain, AF_UNSPEC, &audit_info);
@@ -558,7 +558,7 @@ static int netlbl_mgmt_adddef(struct sk_buff *skb, struct genl_info *info)
 	     (info->attrs[NLBL_MGMT_A_IPV6MASK] != NULL)))
 		return -EINVAL;
 
-	netlbl_netlink_auditinfo(skb, &audit_info);
+	netlbl_netlink_auditinfo(&audit_info);
 
 	return netlbl_mgmt_add_common(info, &audit_info);
 }
@@ -577,7 +577,7 @@ static int netlbl_mgmt_removedef(struct sk_buff *skb, struct genl_info *info)
 {
 	struct netlbl_audit audit_info;
 
-	netlbl_netlink_auditinfo(skb, &audit_info);
+	netlbl_netlink_auditinfo(&audit_info);
 
 	return netlbl_domhsh_remove_default(AF_UNSPEC, &audit_info);
 }
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index ccb491642811..3049fff0b7f8 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -814,7 +814,7 @@ static int netlbl_unlabel_accept(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NLBL_UNLABEL_A_ACPTFLG]) {
 		value = nla_get_u8(info->attrs[NLBL_UNLABEL_A_ACPTFLG]);
 		if (value == 1 || value == 0) {
-			netlbl_netlink_auditinfo(skb, &audit_info);
+			netlbl_netlink_auditinfo(&audit_info);
 			netlbl_unlabel_acceptflg_set(value, &audit_info);
 			return 0;
 		}
@@ -897,7 +897,7 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	       !info->attrs[NLBL_UNLABEL_A_IPV6MASK])))
 		return -EINVAL;
 
-	netlbl_netlink_auditinfo(skb, &audit_info);
+	netlbl_netlink_auditinfo(&audit_info);
 
 	ret_val = netlbl_unlabel_addrinfo_get(info, &addr, &mask, &addr_len);
 	if (ret_val != 0)
@@ -947,7 +947,7 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	       !info->attrs[NLBL_UNLABEL_A_IPV6MASK])))
 		return -EINVAL;
 
-	netlbl_netlink_auditinfo(skb, &audit_info);
+	netlbl_netlink_auditinfo(&audit_info);
 
 	ret_val = netlbl_unlabel_addrinfo_get(info, &addr, &mask, &addr_len);
 	if (ret_val != 0)
@@ -994,7 +994,7 @@ static int netlbl_unlabel_staticremove(struct sk_buff *skb,
 	       !info->attrs[NLBL_UNLABEL_A_IPV6MASK])))
 		return -EINVAL;
 
-	netlbl_netlink_auditinfo(skb, &audit_info);
+	netlbl_netlink_auditinfo(&audit_info);
 
 	ret_val = netlbl_unlabel_addrinfo_get(info, &addr, &mask, &addr_len);
 	if (ret_val != 0)
@@ -1034,7 +1034,7 @@ static int netlbl_unlabel_staticremovedef(struct sk_buff *skb,
 	       !info->attrs[NLBL_UNLABEL_A_IPV6MASK])))
 		return -EINVAL;
 
-	netlbl_netlink_auditinfo(skb, &audit_info);
+	netlbl_netlink_auditinfo(&audit_info);
 
 	ret_val = netlbl_unlabel_addrinfo_get(info, &addr, &mask, &addr_len);
 	if (ret_val != 0)
diff --git a/net/netlabel/netlabel_user.h b/net/netlabel/netlabel_user.h
index 3c67afce64f1..32d8f92c9a20 100644
--- a/net/netlabel/netlabel_user.h
+++ b/net/netlabel/netlabel_user.h
@@ -28,11 +28,9 @@
 
 /**
  * netlbl_netlink_auditinfo - Fetch the audit information from a NETLINK msg
- * @skb: the packet
  * @audit_info: NetLabel audit information
  */
-static inline void netlbl_netlink_auditinfo(struct sk_buff *skb,
-					    struct netlbl_audit *audit_info)
+static inline void netlbl_netlink_auditinfo(struct netlbl_audit *audit_info)
 {
 	security_task_getsecid(current, &audit_info->secid);
 	audit_info->loginuid = audit_get_loginuid(current);
diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index 713e9940d88b..c92dd960bfef 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -577,7 +577,9 @@ static int ctrl_cmd_del_server(struct sockaddr_qrtr *from,
 	if (!node)
 		return -ENOENT;
 
-	return server_del(node, port, true);
+	server_del(node, port, true);
+
+	return 0;
 }
 
 static int ctrl_cmd_new_lookup(struct sockaddr_qrtr *from,
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 080e8f2bf985..4102689b3348 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -340,6 +340,8 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 	struct virtio_vsock_pkt *pkt;
 	size_t bytes, total = 0;
 	u32 free_space;
+	u32 fwd_cnt_delta;
+	bool low_rx_bytes;
 	int err = -EFAULT;
 
 	spin_lock_bh(&vvs->rx_lock);
@@ -371,7 +373,10 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 		}
 	}
 
-	free_space = vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);
+	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;
+	free_space = vvs->buf_alloc - fwd_cnt_delta;
+	low_rx_bytes = (vvs->rx_bytes <
+			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));
 
 	spin_unlock_bh(&vvs->rx_lock);
 
@@ -381,9 +386,11 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 	 * too high causes extra messages. Too low causes transmitter
 	 * stalls. As stalls are in theory more expensive than extra
 	 * messages, we set the limit to a high value. TODO: experiment
-	 * with different values.
+	 * with different values. Also send credit update message when
+	 * number of bytes in rx queue is not enough to wake up reader.
 	 */
-	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE) {
+	if (fwd_cnt_delta &&
+	    (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE || low_rx_bytes)) {
 		virtio_transport_send_credit_update(vsk,
 						    VIRTIO_VSOCK_TYPE_STREAM,
 						    NULL);
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 10896d69c442..6c2a536173b5 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -696,6 +696,10 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 
 	tmpname = aa_splitn_fqname(name, strlen(name), &tmpns, &ns_len);
 	if (tmpns) {
+		if (!tmpname) {
+			info = "empty profile name";
+			goto fail;
+		}
 		*ns_name = kstrndup(tmpns, ns_len, GFP_KERNEL);
 		if (!*ns_name) {
 			info = "out of memory";
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ee37ce2e2619..f545321d96dc 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4620,6 +4620,13 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 				return -EINVAL;
 			addr4 = (struct sockaddr_in *)address;
 			if (family_sa == AF_UNSPEC) {
+				if (family == PF_INET6) {
+					/* Length check from inet6_bind_sk() */
+					if (addrlen < SIN6_LEN_RFC2133)
+						return -EINVAL;
+					/* Family check from __inet6_bind() */
+					goto err_af;
+				}
 				/* see __inet_bind(), we only want to allow
 				 * AF_UNSPEC if the address is INADDR_ANY
 				 */
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 99ba89723cd3..412fbe098e0c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6797,6 +6797,7 @@ enum {
 	ALC290_FIXUP_SUBWOOFER_HSJACK,
 	ALC269_FIXUP_THINKPAD_ACPI,
 	ALC269_FIXUP_DMIC_THINKPAD_ACPI,
+	ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO,
 	ALC255_FIXUP_ACER_MIC_NO_PRESENCE,
 	ALC255_FIXUP_ASUS_MIC_NO_PRESENCE,
 	ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
@@ -7094,6 +7095,14 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_pincfg_U7x7_headset_mic,
 	},
+	[ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x18, 0x03a19020 }, /* headset mic */
+			{ 0x1b, 0x90170150 }, /* speaker */
+			{ }
+		},
+	},
 	[ALC269_FIXUP_AMIC] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -9025,6 +9034,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x87f5, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f6, "HP Spectre x360 14", ALC245_FIXUP_HP_X360_AMP),
 	SND_PCI_QUIRK(0x103c, 0x87f7, "HP Spectre x360 14", ALC245_FIXUP_HP_X360_AMP),
+	SND_PCI_QUIRK(0x103c, 0x87fe, "HP Laptop 15s-fq2xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8805, "HP ProBook 650 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x880d, "HP EliteBook 830 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8811, "HP Spectre x360 15-eb1xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
@@ -9320,6 +9330,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
+	SND_PCI_QUIRK(0x2782, 0x0232, "CHUWI CoreBook XPro", ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO),
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
 	SND_PCI_QUIRK(0x8086, 0x2080, "Intel NUC 8 Rugged", ALC256_FIXUP_INTEL_NUC8_RUGGED),
 	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", ALC256_FIXUP_INTEL_NUC10),
diff --git a/sound/pci/oxygen/oxygen_mixer.c b/sound/pci/oxygen/oxygen_mixer.c
index 46705ec77b48..eb3aca16359c 100644
--- a/sound/pci/oxygen/oxygen_mixer.c
+++ b/sound/pci/oxygen/oxygen_mixer.c
@@ -718,7 +718,7 @@ static int ac97_fp_rec_volume_put(struct snd_kcontrol *ctl,
 	oldreg = oxygen_read_ac97(chip, 1, AC97_REC_GAIN);
 	newreg = oldreg & ~0x0707;
 	newreg = newreg | (value->value.integer.value[0] & 7);
-	newreg = newreg | ((value->value.integer.value[0] & 7) << 8);
+	newreg = newreg | ((value->value.integer.value[1] & 7) << 8);
 	change = newreg != oldreg;
 	if (change)
 		oxygen_write_ac97(chip, 1, AC97_REC_GAIN, newreg);
diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index d243de5f23dc..8a55d59a6c2a 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -46,6 +46,35 @@
  */
 #undef ENABLE_MIC_INPUT
 
+static struct clk *mclk;
+
+static int at91sam9g20ek_set_bias_level(struct snd_soc_card *card,
+					struct snd_soc_dapm_context *dapm,
+					enum snd_soc_bias_level level)
+{
+	static int mclk_on;
+	int ret = 0;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+	case SND_SOC_BIAS_PREPARE:
+		if (!mclk_on)
+			ret = clk_enable(mclk);
+		if (ret == 0)
+			mclk_on = 1;
+		break;
+
+	case SND_SOC_BIAS_OFF:
+	case SND_SOC_BIAS_STANDBY:
+		if (mclk_on)
+			clk_disable(mclk);
+		mclk_on = 0;
+		break;
+	}
+
+	return ret;
+}
+
 static const struct snd_soc_dapm_widget at91sam9g20ek_dapm_widgets[] = {
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
 	SND_SOC_DAPM_SPK("Ext Spk", NULL),
@@ -106,6 +135,7 @@ static struct snd_soc_card snd_soc_at91sam9g20ek = {
 	.owner = THIS_MODULE,
 	.dai_link = &at91sam9g20ek_dai,
 	.num_links = 1,
+	.set_bias_level = at91sam9g20ek_set_bias_level,
 
 	.dapm_widgets = at91sam9g20ek_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(at91sam9g20ek_dapm_widgets),
@@ -118,6 +148,7 @@ static int at91sam9g20ek_audio_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *codec_np, *cpu_np;
+	struct clk *pllb;
 	struct snd_soc_card *card = &snd_soc_at91sam9g20ek;
 	int ret;
 
@@ -131,6 +162,31 @@ static int at91sam9g20ek_audio_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	/*
+	 * Codec MCLK is supplied by PCK0 - set it up.
+	 */
+	mclk = clk_get(NULL, "pck0");
+	if (IS_ERR(mclk)) {
+		dev_err(&pdev->dev, "Failed to get MCLK\n");
+		ret = PTR_ERR(mclk);
+		goto err;
+	}
+
+	pllb = clk_get(NULL, "pllb");
+	if (IS_ERR(pllb)) {
+		dev_err(&pdev->dev, "Failed to get PLLB\n");
+		ret = PTR_ERR(pllb);
+		goto err_mclk;
+	}
+	ret = clk_set_parent(mclk, pllb);
+	clk_put(pllb);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "Failed to set MCLK parent\n");
+		goto err_mclk;
+	}
+
+	clk_set_rate(mclk, MCLK_RATE);
+
 	card->dev = &pdev->dev;
 
 	/* Parse device node info */
@@ -174,6 +230,9 @@ static int at91sam9g20ek_audio_probe(struct platform_device *pdev)
 
 	return ret;
 
+err_mclk:
+	clk_put(mclk);
+	mclk = NULL;
 err:
 	atmel_ssc_put_audio(0);
 	return ret;
@@ -183,6 +242,8 @@ static int at91sam9g20ek_audio_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
+	clk_disable(mclk);
+	mclk = NULL;
 	snd_soc_unregister_card(card);
 	atmel_ssc_put_audio(0);
 
diff --git a/sound/soc/codecs/cs35l33.c b/sound/soc/codecs/cs35l33.c
index 8894369e329a..87b299d24bd8 100644
--- a/sound/soc/codecs/cs35l33.c
+++ b/sound/soc/codecs/cs35l33.c
@@ -22,13 +22,11 @@
 #include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <sound/cs35l33.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/machine.h>
-#include <linux/of_gpio.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
@@ -1168,7 +1166,7 @@ static int cs35l33_i2c_probe(struct i2c_client *i2c_client,
 
 	/* We could issue !RST or skip it based on AMP topology */
 	cs35l33->reset_gpio = devm_gpiod_get_optional(&i2c_client->dev,
-			"reset-gpios", GPIOD_OUT_HIGH);
+			"reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(cs35l33->reset_gpio)) {
 		dev_err(&i2c_client->dev, "%s ERROR: Can't get reset GPIO\n",
 			__func__);
diff --git a/sound/soc/codecs/cs35l34.c b/sound/soc/codecs/cs35l34.c
index b792c006e530..d9f975b52b21 100644
--- a/sound/soc/codecs/cs35l34.c
+++ b/sound/soc/codecs/cs35l34.c
@@ -20,14 +20,12 @@
 #include <linux/regulator/machine.h>
 #include <linux/pm_runtime.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
@@ -1058,7 +1056,7 @@ static int cs35l34_i2c_probe(struct i2c_client *i2c_client,
 		dev_err(&i2c_client->dev, "Failed to request IRQ: %d\n", ret);
 
 	cs35l34->reset_gpio = devm_gpiod_get_optional(&i2c_client->dev,
-				"reset-gpios", GPIOD_OUT_LOW);
+				"reset", GPIOD_OUT_LOW);
 	if (IS_ERR(cs35l34->reset_gpio))
 		return PTR_ERR(cs35l34->reset_gpio);
 
diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 8f70dee95878..02fb9317b697 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -578,7 +578,7 @@ static int cs43130_set_sp_fmt(int dai_id, unsigned int bitwidth_sclk,
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		hi_size = bitwidth_sclk;
-		frm_delay = 2;
+		frm_delay = 0;
 		frm_phase = 1;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
@@ -1683,7 +1683,7 @@ static ssize_t cs43130_show_dc_r(struct device *dev,
 	return cs43130_show_dc(dev, buf, HP_RIGHT);
 }
 
-static u16 const cs43130_ac_freq[CS43130_AC_FREQ] = {
+static const u16 cs43130_ac_freq[CS43130_AC_FREQ] = {
 	24,
 	43,
 	93,
@@ -2364,7 +2364,7 @@ static const struct regmap_config cs43130_regmap = {
 	.use_single_write	= true,
 };
 
-static u16 const cs43130_dc_threshold[CS43130_DC_THRESHOLD] = {
+static const u16 cs43130_dc_threshold[CS43130_DC_THRESHOLD] = {
 	50,
 	120,
 };
diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index b316d613a709..b6030709b6b6 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -654,7 +654,7 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct device *dev)
 		aad_pdata->mic_det_thr =
 			da7219_aad_fw_mic_det_thr(dev, fw_val32);
 	else
-		aad_pdata->mic_det_thr = DA7219_AAD_MIC_DET_THR_500_OHMS;
+		aad_pdata->mic_det_thr = DA7219_AAD_MIC_DET_THR_200_OHMS;
 
 	if (fwnode_property_read_u32(aad_np, "dlg,jack-ins-deb", &fw_val32) >= 0)
 		aad_pdata->jack_ins_deb =
diff --git a/sound/soc/codecs/nau8822.c b/sound/soc/codecs/nau8822.c
index d831959d8ff7..4ce15cd9ed02 100644
--- a/sound/soc/codecs/nau8822.c
+++ b/sound/soc/codecs/nau8822.c
@@ -184,6 +184,7 @@ static int nau8822_eq_get(struct snd_kcontrol *kcontrol,
 	struct soc_bytes_ext *params = (void *)kcontrol->private_value;
 	int i, reg;
 	u16 reg_val, *val;
+	__be16 tmp;
 
 	val = (u16 *)ucontrol->value.bytes.data;
 	reg = NAU8822_REG_EQ1;
@@ -192,8 +193,8 @@ static int nau8822_eq_get(struct snd_kcontrol *kcontrol,
 		/* conversion of 16-bit integers between native CPU format
 		 * and big endian format
 		 */
-		reg_val = cpu_to_be16(reg_val);
-		memcpy(val + i, &reg_val, sizeof(reg_val));
+		tmp = cpu_to_be16(reg_val);
+		memcpy(val + i, &tmp, sizeof(tmp));
 	}
 
 	return 0;
@@ -216,6 +217,7 @@ static int nau8822_eq_put(struct snd_kcontrol *kcontrol,
 	void *data;
 	u16 *val, value;
 	int i, reg, ret;
+	__be16 *tmp;
 
 	data = kmemdup(ucontrol->value.bytes.data,
 		params->max, GFP_KERNEL | GFP_DMA);
@@ -228,7 +230,8 @@ static int nau8822_eq_put(struct snd_kcontrol *kcontrol,
 		/* conversion of 16-bit integers between native CPU format
 		 * and big endian format
 		 */
-		value = be16_to_cpu(*(val + i));
+		tmp = (__be16 *)(val + i);
+		value = be16_to_cpup(tmp);
 		ret = snd_soc_component_write(component, reg + i, value);
 		if (ret) {
 			dev_err(component->dev,
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 99d91bfb8812..7dc80183921e 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -421,6 +421,7 @@ struct rt5645_priv {
 	struct regulator_bulk_data supplies[ARRAY_SIZE(rt5645_supply_names)];
 	struct rt5645_eq_param_s *eq_param;
 	struct timer_list btn_check_timer;
+	struct mutex jd_mutex;
 
 	int codec_type;
 	int sysclk;
@@ -3179,6 +3180,8 @@ static int rt5645_jack_detect(struct snd_soc_component *component, int jack_inse
 				rt5645_enable_push_button_irq(component, true);
 			}
 		} else {
+			if (rt5645->en_button_func)
+				rt5645_enable_push_button_irq(component, false);
 			snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
 			snd_soc_dapm_sync(dapm);
 			rt5645->jack_type = SND_JACK_HEADPHONE;
@@ -3259,6 +3262,8 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 	if (!rt5645->component)
 		return;
 
+	mutex_lock(&rt5645->jd_mutex);
+
 	switch (rt5645->pdata.jd_mode) {
 	case 0: /* Not using rt5645 JD */
 		if (rt5645->gpiod_hp_det) {
@@ -3283,7 +3288,7 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 
 	if (!val && (rt5645->jack_type == 0)) { /* jack in */
 		report = rt5645_jack_detect(rt5645->component, 1);
-	} else if (!val && rt5645->jack_type != 0) {
+	} else if (!val && rt5645->jack_type == SND_JACK_HEADSET) {
 		/* for push button and jack out */
 		btn_type = 0;
 		if (snd_soc_component_read(rt5645->component, RT5645_INT_IRQ_ST) & 0x4) {
@@ -3339,6 +3344,8 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 		rt5645_jack_detect(rt5645->component, 0);
 	}
 
+	mutex_unlock(&rt5645->jd_mutex);
+
 	snd_soc_jack_report(rt5645->hp_jack, report, SND_JACK_HEADPHONE);
 	snd_soc_jack_report(rt5645->mic_jack, report, SND_JACK_MICROPHONE);
 	if (rt5645->en_button_func)
@@ -4062,6 +4069,7 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 	}
 	timer_setup(&rt5645->btn_check_timer, rt5645_btn_check_callback, 0);
 
+	mutex_init(&rt5645->jd_mutex);
 	INIT_DELAYED_WORK(&rt5645->jack_detect_work, rt5645_jack_detect_work);
 	INIT_DELAYED_WORK(&rt5645->rcclock_work, rt5645_rcclock_work);
 
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index c86231dfcf4f..600e93d61a90 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -186,7 +186,7 @@ SOC_DAPM_SINGLE("PCM Playback Switch", WM8974_MONOMIX, 0, 1, 0),
 
 /* Boost mixer */
 static const struct snd_kcontrol_new wm8974_boost_mixer[] = {
-SOC_DAPM_SINGLE("Aux Switch", WM8974_INPPGA, 6, 1, 1),
+SOC_DAPM_SINGLE("PGA Switch", WM8974_INPPGA, 6, 1, 1),
 };
 
 /* Input PGA */
@@ -246,8 +246,8 @@ static const struct snd_soc_dapm_route wm8974_dapm_routes[] = {
 
 	/* Boost Mixer */
 	{"ADC", NULL, "Boost Mixer"},
-	{"Boost Mixer", "Aux Switch", "Aux Input"},
-	{"Boost Mixer", NULL, "Input PGA"},
+	{"Boost Mixer", NULL, "Aux Input"},
+	{"Boost Mixer", "PGA Switch", "Input PGA"},
 	{"Boost Mixer", NULL, "MICP"},
 
 	/* Input PGA */
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index b531d9dfc2d6..935c871abdaa 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -251,8 +251,10 @@ static int skl_pcm_open(struct snd_pcm_substream *substream,
 	snd_pcm_set_sync(substream);
 
 	mconfig = skl_tplg_fe_get_cpr_module(dai, substream->stream);
-	if (!mconfig)
+	if (!mconfig) {
+		kfree(dma_params);
 		return -EINVAL;
+	}
 
 	skl_tplg_d0i3_get(skl, mconfig->d0i3_caps);
 
@@ -1475,6 +1477,7 @@ int skl_platform_register(struct device *dev)
 		dais = krealloc(skl->dais, sizeof(skl_fe_dai) +
 				sizeof(skl_platform_dai), GFP_KERNEL);
 		if (!dais) {
+			kfree(skl->dais);
 			ret = -ENOMEM;
 			goto err;
 		}
@@ -1487,8 +1490,10 @@ int skl_platform_register(struct device *dev)
 
 	ret = devm_snd_soc_register_component(dev, &skl_component,
 					 skl->dais, num_dais);
-	if (ret)
+	if (ret) {
+		kfree(skl->dais);
 		dev_err(dev, "soc component registration failed %d\n", ret);
+	}
 err:
 	return ret;
 }
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 7a425271b08b..fd9624ad5f72 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -1003,8 +1003,10 @@ int skl_ipc_get_large_config(struct sst_generic_ipc *ipc,
 
 	reply.size = (reply.header >> 32) & IPC_DATA_OFFSET_SZ_MASK;
 	buf = krealloc(reply.data, reply.size, GFP_KERNEL);
-	if (!buf)
+	if (!buf) {
+		kfree(reply.data);
 		return -ENOMEM;
+	}
 	*payload = buf;
 	*bytes = reply.size;
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index fd1a4d843e6f..63ea5bc6f1c4 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3424,6 +3424,8 @@ union bpf_attr {
  * long bpf_get_task_stack(struct task_struct *task, void *buf, u32 size, u64 flags)
  *	Description
  *		Return a user or a kernel stack in bpf program provided buffer.
+ *		Note: the user stack will only be populated if the *task* is
+ *		the current task; all other tasks will return -EOPNOTSUPP.
  *		To achieve this, the helper needs *task*, which is a valid
  *		pointer to **struct task_struct**. To store the stacktrace, the
  *		bpf program provides *buf* with a nonnegative *size*.
@@ -3435,6 +3437,7 @@ union bpf_attr {
  *
  *		**BPF_F_USER_STACK**
  *			Collect a user space stack instead of a kernel stack.
+ *			The *task* must be the current task.
  *		**BPF_F_USER_BUILD_ID**
  *			Collect buildid+offset instead of ips for user stack,
  *			only valid if **BPF_F_USER_STACK** is also specified.
diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
index 777c20f6b604..458acd294237 100644
--- a/tools/lib/api/io.h
+++ b/tools/lib/api/io.h
@@ -9,6 +9,7 @@
 
 #include <stdlib.h>
 #include <unistd.h>
+#include <linux/types.h>
 
 struct io {
 	/* File descriptor being read/ */
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 4eb02762104b..c50d2c7a264f 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -533,9 +533,9 @@ int evlist__add_bpf_sb_event(struct evlist *evlist, struct perf_env *env)
 	return perf_evlist__add_sb_event(evlist, &attr, bpf_event__sb_cb, env);
 }
 
-void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
-				    struct perf_env *env,
-				    FILE *fp)
+void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
+				      struct perf_env *env,
+				      FILE *fp)
 {
 	__u32 *prog_lens = (__u32 *)(uintptr_t)(info->jited_func_lens);
 	__u64 *prog_addrs = (__u64 *)(uintptr_t)(info->jited_ksyms);
@@ -551,7 +551,7 @@ void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
 	if (info->btf_id) {
 		struct btf_node *node;
 
-		node = perf_env__find_btf(env, info->btf_id);
+		node = __perf_env__find_btf(env, info->btf_id);
 		if (node)
 			btf = btf__new((__u8 *)(node->data),
 				       node->data_size);
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 68f315c3df5b..50f7412464df 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -34,9 +34,9 @@ struct btf_node {
 int machine__process_bpf(struct machine *machine, union perf_event *event,
 			 struct perf_sample *sample);
 int evlist__add_bpf_sb_event(struct evlist *evlist, struct perf_env *env);
-void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
-				    struct perf_env *env,
-				    FILE *fp);
+void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
+				      struct perf_env *env,
+				      FILE *fp);
 #else
 static inline int machine__process_bpf(struct machine *machine __maybe_unused,
 				       union perf_event *event __maybe_unused,
@@ -51,9 +51,9 @@ static inline int evlist__add_bpf_sb_event(struct evlist *evlist __maybe_unused,
 	return 0;
 }
 
-static inline void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info __maybe_unused,
-						  struct perf_env *env __maybe_unused,
-						  FILE *fp __maybe_unused)
+static inline void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info __maybe_unused,
+						    struct perf_env *env __maybe_unused,
+						    FILE *fp __maybe_unused)
 {
 
 }
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index d81ed1bc14bd..ed2a42abe127 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -17,13 +17,19 @@ struct perf_env perf_env;
 
 void perf_env__insert_bpf_prog_info(struct perf_env *env,
 				    struct bpf_prog_info_node *info_node)
+{
+	down_write(&env->bpf_progs.lock);
+	__perf_env__insert_bpf_prog_info(env, info_node);
+	up_write(&env->bpf_progs.lock);
+}
+
+void __perf_env__insert_bpf_prog_info(struct perf_env *env, struct bpf_prog_info_node *info_node)
 {
 	__u32 prog_id = info_node->info_linear->info.id;
 	struct bpf_prog_info_node *node;
 	struct rb_node *parent = NULL;
 	struct rb_node **p;
 
-	down_write(&env->bpf_progs.lock);
 	p = &env->bpf_progs.infos.rb_node;
 
 	while (*p != NULL) {
@@ -35,15 +41,13 @@ void perf_env__insert_bpf_prog_info(struct perf_env *env,
 			p = &(*p)->rb_right;
 		} else {
 			pr_debug("duplicated bpf prog info %u\n", prog_id);
-			goto out;
+			return;
 		}
 	}
 
 	rb_link_node(&info_node->rb_node, parent, p);
 	rb_insert_color(&info_node->rb_node, &env->bpf_progs.infos);
 	env->bpf_progs.infos_cnt++;
-out:
-	up_write(&env->bpf_progs.lock);
 }
 
 struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
@@ -72,14 +76,22 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 }
 
 bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node)
+{
+	bool ret;
+
+	down_write(&env->bpf_progs.lock);
+	ret = __perf_env__insert_btf(env, btf_node);
+	up_write(&env->bpf_progs.lock);
+	return ret;
+}
+
+bool __perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node)
 {
 	struct rb_node *parent = NULL;
 	__u32 btf_id = btf_node->id;
 	struct btf_node *node;
 	struct rb_node **p;
-	bool ret = true;
 
-	down_write(&env->bpf_progs.lock);
 	p = &env->bpf_progs.btfs.rb_node;
 
 	while (*p != NULL) {
@@ -91,25 +103,31 @@ bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node)
 			p = &(*p)->rb_right;
 		} else {
 			pr_debug("duplicated btf %u\n", btf_id);
-			ret = false;
-			goto out;
+			return false;
 		}
 	}
 
 	rb_link_node(&btf_node->rb_node, parent, p);
 	rb_insert_color(&btf_node->rb_node, &env->bpf_progs.btfs);
 	env->bpf_progs.btfs_cnt++;
-out:
-	up_write(&env->bpf_progs.lock);
-	return ret;
+	return true;
 }
 
 struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
+{
+	struct btf_node *res;
+
+	down_read(&env->bpf_progs.lock);
+	res = __perf_env__find_btf(env, btf_id);
+	up_read(&env->bpf_progs.lock);
+	return res;
+}
+
+struct btf_node *__perf_env__find_btf(struct perf_env *env, __u32 btf_id)
 {
 	struct btf_node *node = NULL;
 	struct rb_node *n;
 
-	down_read(&env->bpf_progs.lock);
 	n = env->bpf_progs.btfs.rb_node;
 
 	while (n) {
@@ -119,13 +137,9 @@ struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
 		else if (btf_id > node->id)
 			n = n->rb_right;
 		else
-			goto out;
+			return node;
 	}
-	node = NULL;
-
-out:
-	up_read(&env->bpf_progs.lock);
-	return node;
+	return NULL;
 }
 
 /* purge data in bpf_progs.infos tree */
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 01378a955dd5..ef0fd544cd67 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -139,12 +139,16 @@ const char *perf_env__raw_arch(struct perf_env *env);
 int perf_env__nr_cpus_avail(struct perf_env *env);
 
 void perf_env__init(struct perf_env *env);
+void __perf_env__insert_bpf_prog_info(struct perf_env *env,
+				      struct bpf_prog_info_node *info_node);
 void perf_env__insert_bpf_prog_info(struct perf_env *env,
 				    struct bpf_prog_info_node *info_node);
 struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 							__u32 prog_id);
 bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
+bool __perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
 struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
+struct btf_node *__perf_env__find_btf(struct perf_env *env, __u32 btf_id);
 
 int perf_env__numa_node(struct perf_env *env, int cpu);
 #endif /* __PERF_ENV_H */
diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
index 02cd9f75e3d2..89a85601485d 100644
--- a/tools/perf/util/genelf.c
+++ b/tools/perf/util/genelf.c
@@ -291,9 +291,9 @@ jit_write_elf(int fd, uint64_t load_addr, const char *sym,
 	 */
 	phdr = elf_newphdr(e, 1);
 	phdr[0].p_type = PT_LOAD;
-	phdr[0].p_offset = 0;
-	phdr[0].p_vaddr = 0;
-	phdr[0].p_paddr = 0;
+	phdr[0].p_offset = GEN_ELF_TEXT_OFFSET;
+	phdr[0].p_vaddr = GEN_ELF_TEXT_OFFSET;
+	phdr[0].p_paddr = GEN_ELF_TEXT_OFFSET;
 	phdr[0].p_filesz = csize;
 	phdr[0].p_memsz = csize;
 	phdr[0].p_flags = PF_X | PF_R;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index dd06770b43f1..d2812d98968d 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1655,8 +1655,8 @@ static void print_bpf_prog_info(struct feat_fd *ff, FILE *fp)
 		node = rb_entry(next, struct bpf_prog_info_node, rb_node);
 		next = rb_next(&node->rb_node);
 
-		bpf_event__print_bpf_prog_info(&node->info_linear->info,
-					       env, fp);
+		__bpf_event__print_bpf_prog_info(&node->info_linear->info,
+						 env, fp);
 	}
 
 	up_read(&env->bpf_progs.lock);
@@ -2927,7 +2927,7 @@ static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
 		/* after reading from file, translate offset to address */
 		bpf_program__bpil_offs_to_addr(info_linear);
 		info_node->info_linear = info_linear;
-		perf_env__insert_bpf_prog_info(env, info_node);
+		__perf_env__insert_bpf_prog_info(env, info_node);
 	}
 
 	up_write(&env->bpf_progs.lock);
@@ -2980,7 +2980,7 @@ static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
 		if (__do_read(ff, node->data, data_size))
 			goto out;
 
-		perf_env__insert_btf(env, node);
+		__perf_env__insert_btf(env, node);
 		node = NULL;
 	}
 
diff --git a/tools/testing/selftests/drivers/net/mlxsw/qos_pfc.sh b/tools/testing/selftests/drivers/net/mlxsw/qos_pfc.sh
index 5c7700212f75..56761de1ca3b 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/qos_pfc.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/qos_pfc.sh
@@ -121,6 +121,9 @@ h2_destroy()
 
 switch_create()
 {
+	local lanes_swp4
+	local pg1_size
+
 	# pools
 	# -----
 
@@ -171,7 +174,7 @@ switch_create()
 	# assignment.
 	tc qdisc replace dev $swp1 root handle 1: \
 	   ets bands 8 strict 8 priomap 7 6
-	__mlnx_qos -i $swp1 --prio2buffer=0,1,0,0,0,0,0,0 >/dev/null
+	dcb buffer set dev $swp1 prio-buffer all:0 1:1
 
 	# $swp2
 	# -----
@@ -209,8 +212,8 @@ switch_create()
 	# the lossless prio into a buffer of its own. Don't bother with buffer
 	# sizes though, there is not going to be any pressure in the "backward"
 	# direction.
-	__mlnx_qos -i $swp3 --prio2buffer=0,1,0,0,0,0,0,0 >/dev/null
-	__mlnx_qos -i $swp3 --pfc=0,1,0,0,0,0,0,0 >/dev/null
+	dcb buffer set dev $swp3 prio-buffer all:0 1:1
+	dcb pfc set dev $swp3 prio-pfc all:off 1:on
 
 	# $swp4
 	# -----
@@ -226,11 +229,24 @@ switch_create()
 	# Configure qdisc so that we can hand-tune headroom.
 	tc qdisc replace dev $swp4 root handle 1: \
 	   ets bands 8 strict 8 priomap 7 6
-	__mlnx_qos -i $swp4 --prio2buffer=0,1,0,0,0,0,0,0 >/dev/null
-	__mlnx_qos -i $swp4 --pfc=0,1,0,0,0,0,0,0 >/dev/null
+	dcb buffer set dev $swp4 prio-buffer all:0 1:1
+	dcb pfc set dev $swp4 prio-pfc all:off 1:on
 	# PG0 will get autoconfigured to Xoff, give PG1 arbitrarily 100K, which
 	# is (-2*MTU) about 80K of delay provision.
-	__mlnx_qos -i $swp4 --buffer_size=0,$_100KB,0,0,0,0,0,0 >/dev/null
+	pg1_size=$_100KB
+
+	setup_wait_dev_with_timeout $swp4
+
+	lanes_swp4=$(ethtool $swp4 | grep 'Lanes:')
+	lanes_swp4=${lanes_swp4#*"Lanes: "}
+
+	# 8-lane ports use two buffers among which the configured buffer
+	# is split, so double the size to get twice (20K + 80K).
+	if [[ $lanes_swp4 -eq 8 ]]; then
+		pg1_size=$((pg1_size * 2))
+	fi
+
+	dcb buffer set dev $swp4 buffer-size all:0 1:$pg1_size
 
 	# bridges
 	# -------
@@ -273,9 +289,9 @@ switch_destroy()
 	# $swp4
 	# -----
 
-	__mlnx_qos -i $swp4 --buffer_size=0,0,0,0,0,0,0,0 >/dev/null
-	__mlnx_qos -i $swp4 --pfc=0,0,0,0,0,0,0,0 >/dev/null
-	__mlnx_qos -i $swp4 --prio2buffer=0,0,0,0,0,0,0,0 >/dev/null
+	dcb buffer set dev $swp4 buffer-size all:0
+	dcb pfc set dev $swp4 prio-pfc all:off
+	dcb buffer set dev $swp4 prio-buffer all:0
 	tc qdisc del dev $swp4 root
 
 	devlink_tc_bind_pool_th_restore $swp4 1 ingress
@@ -288,8 +304,8 @@ switch_destroy()
 	# $swp3
 	# -----
 
-	__mlnx_qos -i $swp3 --pfc=0,0,0,0,0,0,0,0 >/dev/null
-	__mlnx_qos -i $swp3 --prio2buffer=0,0,0,0,0,0,0,0 >/dev/null
+	dcb pfc set dev $swp3 prio-pfc all:off
+	dcb buffer set dev $swp3 prio-buffer all:0
 	tc qdisc del dev $swp3 root
 
 	devlink_tc_bind_pool_th_restore $swp3 1 egress
@@ -315,7 +331,7 @@ switch_destroy()
 	# $swp1
 	# -----
 
-	__mlnx_qos -i $swp1 --prio2buffer=0,0,0,0,0,0,0,0 >/dev/null
+	dcb buffer set dev $swp1 prio-buffer all:0
 	tc qdisc del dev $swp1 root
 
 	devlink_tc_bind_pool_th_restore $swp1 1 ingress
diff --git a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
index fb850e0ec837..616d3581419c 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
@@ -10,7 +10,8 @@ lib_dir=$(dirname $0)/../../../../net/forwarding
 ALL_TESTS="single_mask_test identical_filters_test two_masks_test \
 	multiple_masks_test ctcam_edge_cases_test delta_simple_test \
 	delta_two_masks_one_key_test delta_simple_rehash_test \
-	bloom_simple_test bloom_complex_test bloom_delta_test"
+	bloom_simple_test bloom_complex_test bloom_delta_test \
+	max_erp_entries_test max_group_size_test"
 NUM_NETIFS=2
 source $lib_dir/lib.sh
 source $lib_dir/tc_common.sh
@@ -983,6 +984,109 @@ bloom_delta_test()
 	log_test "bloom delta test ($tcflags)"
 }
 
+max_erp_entries_test()
+{
+	# The number of eRP entries is limited. Once the maximum number of eRPs
+	# has been reached, filters cannot be added. This test verifies that
+	# when this limit is reached, inserstion fails without crashing.
+
+	RET=0
+
+	local num_masks=32
+	local num_regions=15
+	local chain_failed
+	local mask_failed
+	local ret
+
+	if [[ "$tcflags" != "skip_sw" ]]; then
+		return 0;
+	fi
+
+	for ((i=1; i < $num_regions; i++)); do
+		for ((j=$num_masks; j >= 0; j--)); do
+			tc filter add dev $h2 ingress chain $i protocol ip \
+				pref $i	handle $j flower $tcflags \
+				dst_ip 192.1.0.0/$j &> /dev/null
+			ret=$?
+
+			if [ $ret -ne 0 ]; then
+				chain_failed=$i
+				mask_failed=$j
+				break 2
+			fi
+		done
+	done
+
+	# We expect to exceed the maximum number of eRP entries, so that
+	# insertion eventually fails. Otherwise, the test should be adjusted to
+	# add more filters.
+	check_fail $ret "expected to exceed number of eRP entries"
+
+	for ((; i >= 1; i--)); do
+		for ((j=0; j <= $num_masks; j++)); do
+			tc filter del dev $h2 ingress chain $i protocol ip \
+				pref $i handle $j flower &> /dev/null
+		done
+	done
+
+	log_test "max eRP entries test ($tcflags). " \
+		"max chain $chain_failed, mask $mask_failed"
+}
+
+max_group_size_test()
+{
+	# The number of ACLs in an ACL group is limited. Once the maximum
+	# number of ACLs has been reached, filters cannot be added. This test
+	# verifies that when this limit is reached, insertion fails without
+	# crashing.
+
+	RET=0
+
+	local num_acls=32
+	local max_size
+	local ret
+
+	if [[ "$tcflags" != "skip_sw" ]]; then
+		return 0;
+	fi
+
+	for ((i=1; i < $num_acls; i++)); do
+		if [[ $(( i % 2 )) == 1 ]]; then
+			tc filter add dev $h2 ingress pref $i proto ipv4 \
+				flower $tcflags dst_ip 198.51.100.1/32 \
+				ip_proto tcp tcp_flags 0x01/0x01 \
+				action drop &> /dev/null
+		else
+			tc filter add dev $h2 ingress pref $i proto ipv6 \
+				flower $tcflags dst_ip 2001:db8:1::1/128 \
+				action drop &> /dev/null
+		fi
+
+		ret=$?
+		[[ $ret -ne 0 ]] && max_size=$((i - 1)) && break
+	done
+
+	# We expect to exceed the maximum number of ACLs in a group, so that
+	# insertion eventually fails. Otherwise, the test should be adjusted to
+	# add more filters.
+	check_fail $ret "expected to exceed number of ACLs in a group"
+
+	for ((; i >= 1; i--)); do
+		if [[ $(( i % 2 )) == 1 ]]; then
+			tc filter del dev $h2 ingress pref $i proto ipv4 \
+				flower $tcflags dst_ip 198.51.100.1/32 \
+				ip_proto tcp tcp_flags 0x01/0x01 \
+				action drop &> /dev/null
+		else
+			tc filter del dev $h2 ingress pref $i proto ipv6 \
+				flower $tcflags dst_ip 2001:db8:1::1/128 \
+				action drop &> /dev/null
+		fi
+	done
+
+	log_test "max ACL group size test ($tcflags). max size $max_size"
+}
+
 setup_prepare()
 {
 	h1=${NETIFS[p1]}
diff --git a/tools/testing/selftests/net/fib_nexthop_multiprefix.sh b/tools/testing/selftests/net/fib_nexthop_multiprefix.sh
index 51df5e305855..b52d59547fc5 100755
--- a/tools/testing/selftests/net/fib_nexthop_multiprefix.sh
+++ b/tools/testing/selftests/net/fib_nexthop_multiprefix.sh
@@ -209,12 +209,12 @@ validate_v6_exception()
 		echo "Route get"
 		ip -netns h0 -6 ro get ${dst}
 		echo "Searching for:"
-		echo "    ${dst} from :: via ${r1} dev eth0 src ${h0} .* mtu ${mtu}"
+		echo "    ${dst}.* via ${r1} dev eth0 src ${h0} .* mtu ${mtu}"
 		echo
 	fi
 
 	ip -netns h0 -6 ro get ${dst} | \
-	grep -q "${dst} from :: via ${r1} dev eth0 src ${h0} .* mtu ${mtu}"
+	grep -q "${dst}.* via ${r1} dev eth0 src ${h0} .* mtu ${mtu}"
 	rc=$?
 
 	log_test $rc 0 "IPv6: host 0 to host ${i}, mtu ${mtu}"
diff --git a/tools/testing/selftests/powerpc/math/fpu_preempt.c b/tools/testing/selftests/powerpc/math/fpu_preempt.c
index 5235bdc8c0b1..3e5b5663d244 100644
--- a/tools/testing/selftests/powerpc/math/fpu_preempt.c
+++ b/tools/testing/selftests/powerpc/math/fpu_preempt.c
@@ -37,19 +37,20 @@ __thread double darray[] = {0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0,
 int threads_starting;
 int running;
 
-extern void preempt_fpu(double *darray, int *threads_starting, int *running);
+extern int preempt_fpu(double *darray, int *threads_starting, int *running);
 
 void *preempt_fpu_c(void *p)
 {
+	long rc;
 	int i;
+
 	srand(pthread_self());
 	for (i = 0; i < 21; i++)
 		darray[i] = rand();
 
-	/* Test failed if it ever returns */
-	preempt_fpu(darray, &threads_starting, &running);
+	rc = preempt_fpu(darray, &threads_starting, &running);
 
-	return p;
+	return (void *)rc;
 }
 
 int test_preempt_fpu(void)
diff --git a/tools/testing/selftests/powerpc/math/vmx_preempt.c b/tools/testing/selftests/powerpc/math/vmx_preempt.c
index 6761d6ce30ec..6f7cf400c687 100644
--- a/tools/testing/selftests/powerpc/math/vmx_preempt.c
+++ b/tools/testing/selftests/powerpc/math/vmx_preempt.c
@@ -37,19 +37,21 @@ __thread vector int varray[] = {{1, 2, 3, 4}, {5, 6, 7, 8}, {9, 10,11,12},
 int threads_starting;
 int running;
 
-extern void preempt_vmx(vector int *varray, int *threads_starting, int *running);
+extern int preempt_vmx(vector int *varray, int *threads_starting, int *running);
 
 void *preempt_vmx_c(void *p)
 {
 	int i, j;
+	long rc;
+
 	srand(pthread_self());
 	for (i = 0; i < 12; i++)
 		for (j = 0; j < 4; j++)
 			varray[i][j] = rand();
 
-	/* Test fails if it ever returns */
-	preempt_vmx(varray, &threads_starting, &running);
-	return p;
+	rc = preempt_vmx(varray, &threads_starting, &running);
+
+	return (void *)rc;
 }
 
 int test_preempt_vmx(void)

