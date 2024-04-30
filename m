Return-Path: <linux-kernel+bounces-163998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5428B7700
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33EA1C20E06
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC78A12CD90;
	Tue, 30 Apr 2024 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pkp8ul9m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L7fHkwyU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25315171678;
	Tue, 30 Apr 2024 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483724; cv=none; b=FRSkCnYwEeJzjOYSmBv/aclUwfL7Q9uH0nq13HwzT9t54fmq35oFkFqH8jl3IG4m5B7cpxRyXqe3Pf6hn0VXWFXntjYUXZAbTXSSRnga5tO2jgtoEIPNoCHDiTbXiNtqgbqnUPykfKvyj/TncbfVpye+1DpS3zJIlvqz/fujPOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483724; c=relaxed/simple;
	bh=El8uqzd9yfBAApCO2YKkgMvc4gGcYHzsnRBWxFEFPyo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jZ9Xb8RHv1Nql/x6JTNC0yC9lKxPk3nD8XLxBZLM8ACuUkVgAa736pFZSo6vWiqkCHrrAi/Wd8ooarJi1V9xNfmqCshPfMGX56FybCsQsM9w+Hqq/E15o5kH/bbZSDGKYC3LwBqwyRe36UNcNM45adzgwjONbEzy52JaqP1rEZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pkp8ul9m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L7fHkwyU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Apr 2024 13:28:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714483721;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uXDCHY7O/2qla6RJtoE2HY5kMHxKZdj4DTNs/8ZB2PE=;
	b=pkp8ul9m8AtW7q8BsbWQpPPc7v9HQ2GGmio4ec+W6+kNDwmJ2e5DITLQIq1ITHYHX+JG5V
	S+GU58Da+NLeQTUB4dClCFH1LRvDDhrnyzNbn0UP+g8udbzh2JUEPYqyDq8KbDf59+Qgvu
	K+r0YO+EGVMXPpwCo9ZBZUBlZdZaSZgNcHF974Fj+HGzP1xvC6uiVCoyBFtklw0/+rqrfB
	IYZ3S81UF729JVd4J6MkV3QproVQasK3lTvAZKzr8wmdxylCRM4qQ/wTGaKckfiE2Q/H9D
	xqauymkUI3ZlFCfBS1b2zWI/f7Yz+8i24ZP6jrGoTEfcrD9j+QcBah7KxA4L0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714483721;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uXDCHY7O/2qla6RJtoE2HY5kMHxKZdj4DTNs/8ZB2PE=;
	b=L7fHkwyUZuJ5xHmwxpdwgoKhuaduw5FxhtSzuA8nQNkZzaP2+M3Av269UCK3Bp7GCeai2O
	iW34pw21FbBPBiDg==
From: "tip-bot2 for Jacob Pan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] iommu/vt-d: Enable posted mode for device MSIs
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240423174114.526704-13-jacob.jun.pan@linux.intel.com>
References: <20240423174114.526704-13-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171448372075.10875.14030894984079233646.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     ed1e48ea43703002dc202ac7f3b0b0b9981ec2f0
Gitweb:        https://git.kernel.org/tip/ed1e48ea43703002dc202ac7f3b0b0b9981ec2f0
Author:        Jacob Pan <jacob.jun.pan@linux.intel.com>
AuthorDate:    Tue, 23 Apr 2024 10:41:14 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Apr 2024 00:54:43 +02:00

iommu/vt-d: Enable posted mode for device MSIs

With posted MSI feature enabled on the CPU side, iommu interrupt
remapping table entries (IRTEs) for device MSI/x can be allocated,
activated, and programed in posted mode. This means that IRTEs are
linked with their respective PIDs of the target CPU.

Handlers for the posted MSI notification vector will de-multiplex
device MSI handlers. CPU notifications are coalesced if interrupts
arrive at a high frequency.

Posted interrupts are only used for device MSI and not for legacy devices
(IO/APIC, HPET).

Introduce a new irq_chip for posted MSIs, which has a dummy irq_ack()
callback as EOI is performed in the notification handler once.

When posted MSI is enabled, MSI domain/chip hierarchy will look like
this example:

domain:  IR-PCI-MSIX-0000:50:00.0-12
 hwirq:   0x29
 chip:    IR-PCI-MSIX-0000:50:00.0
  flags:   0x430
             IRQCHIP_SKIP_SET_WAKE
             IRQCHIP_ONESHOT_SAFE
 parent:
    domain:  INTEL-IR-10-13
     hwirq:   0x2d0000
     chip:    INTEL-IR-POST
      flags:   0x0
     parent:
        domain:  VECTOR
         hwirq:   0x77
         chip:    APIC

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240423174114.526704-13-jacob.jun.pan@linux.intel.com
---
 drivers/iommu/intel/irq_remapping.c | 113 ++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 566297b..712ebfc 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -19,6 +19,7 @@
 #include <asm/cpu.h>
 #include <asm/irq_remapping.h>
 #include <asm/pci-direct.h>
+#include <asm/posted_intr.h>
 
 #include "iommu.h"
 #include "../irq_remapping.h"
@@ -49,6 +50,7 @@ struct irq_2_iommu {
 	u16 sub_handle;
 	u8  irte_mask;
 	enum irq_mode mode;
+	bool posted_msi;
 };
 
 struct intel_ir_data {
@@ -1118,6 +1120,14 @@ static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 	irte->redir_hint = 1;
 }
 
+static void prepare_irte_posted(struct irte *irte)
+{
+	memset(irte, 0, sizeof(*irte));
+
+	irte->present = 1;
+	irte->p_pst = 1;
+}
+
 struct irq_remap_ops intel_irq_remap_ops = {
 	.prepare		= intel_prepare_irq_remapping,
 	.enable			= intel_enable_irq_remapping,
@@ -1126,6 +1136,47 @@ struct irq_remap_ops intel_irq_remap_ops = {
 	.enable_faulting	= enable_drhd_fault_handling,
 };
 
+#ifdef CONFIG_X86_POSTED_MSI
+
+static phys_addr_t get_pi_desc_addr(struct irq_data *irqd)
+{
+	int cpu = cpumask_first(irq_data_get_effective_affinity_mask(irqd));
+
+	if (WARN_ON(cpu >= nr_cpu_ids))
+		return 0;
+
+	return __pa(per_cpu_ptr(&posted_msi_pi_desc, cpu));
+}
+
+static void intel_ir_reconfigure_irte_posted(struct irq_data *irqd)
+{
+	struct intel_ir_data *ir_data = irqd->chip_data;
+	struct irte *irte = &ir_data->irte_entry;
+	struct irte irte_pi;
+	u64 pid_addr;
+
+	pid_addr = get_pi_desc_addr(irqd);
+
+	if (!pid_addr) {
+		pr_warn("Failed to setup IRQ %d for posted mode", irqd->irq);
+		return;
+	}
+
+	memset(&irte_pi, 0, sizeof(irte_pi));
+
+	/* The shared IRTE already be set up as posted during alloc_irte */
+	dmar_copy_shared_irte(&irte_pi, irte);
+
+	irte_pi.pda_l = (pid_addr >> (32 - PDA_LOW_BIT)) & ~(-1UL << PDA_LOW_BIT);
+	irte_pi.pda_h = (pid_addr >> 32) & ~(-1UL << PDA_HIGH_BIT);
+
+	modify_irte(&ir_data->irq_2_iommu, &irte_pi);
+}
+
+#else
+static inline void intel_ir_reconfigure_irte_posted(struct irq_data *irqd) {}
+#endif
+
 static void intel_ir_reconfigure_irte(struct irq_data *irqd, bool force)
 {
 	struct intel_ir_data *ir_data = irqd->chip_data;
@@ -1139,8 +1190,9 @@ static void intel_ir_reconfigure_irte(struct irq_data *irqd, bool force)
 	irte->vector = cfg->vector;
 	irte->dest_id = IRTE_DEST(cfg->dest_apicid);
 
-	/* Update the hardware only if the interrupt is in remapped mode. */
-	if (force || ir_data->irq_2_iommu.mode == IRQ_REMAPPING)
+	if (ir_data->irq_2_iommu.posted_msi)
+		intel_ir_reconfigure_irte_posted(irqd);
+	else if (force || ir_data->irq_2_iommu.mode == IRQ_REMAPPING)
 		modify_irte(&ir_data->irq_2_iommu, irte);
 }
 
@@ -1194,7 +1246,7 @@ static int intel_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 	struct intel_ir_data *ir_data = data->chip_data;
 	struct vcpu_data *vcpu_pi_info = info;
 
-	/* stop posting interrupts, back to remapping mode */
+	/* stop posting interrupts, back to the default mode */
 	if (!vcpu_pi_info) {
 		modify_irte(&ir_data->irq_2_iommu, &ir_data->irte_entry);
 	} else {
@@ -1233,6 +1285,49 @@ static struct irq_chip intel_ir_chip = {
 	.irq_set_vcpu_affinity	= intel_ir_set_vcpu_affinity,
 };
 
+/*
+ * With posted MSIs, all vectors are multiplexed into a single notification
+ * vector. Devices MSIs are then dispatched in a demux loop where
+ * EOIs can be coalesced as well.
+ *
+ * "INTEL-IR-POST" IRQ chip does not do EOI on ACK, thus the dummy irq_ack()
+ * function. Instead EOI is performed by the posted interrupt notification
+ * handler.
+ *
+ * For the example below, 3 MSIs are coalesced into one CPU notification. Only
+ * one apic_eoi() is needed.
+ *
+ * __sysvec_posted_msi_notification()
+ *	irq_enter();
+ *		handle_edge_irq()
+ *			irq_chip_ack_parent()
+ *				dummy(); // No EOI
+ *			handle_irq_event()
+ *				driver_handler()
+ *		handle_edge_irq()
+ *			irq_chip_ack_parent()
+ *				dummy(); // No EOI
+ *			handle_irq_event()
+ *				driver_handler()
+ *		handle_edge_irq()
+ *			irq_chip_ack_parent()
+ *				dummy(); // No EOI
+ *			handle_irq_event()
+ *				driver_handler()
+ *	apic_eoi()
+ *	irq_exit()
+ */
+
+static void dummy_ack(struct irq_data *d) { }
+
+static struct irq_chip intel_ir_chip_post_msi = {
+	.name			= "INTEL-IR-POST",
+	.irq_ack		= dummy_ack,
+	.irq_set_affinity	= intel_ir_set_affinity,
+	.irq_compose_msi_msg	= intel_ir_compose_msi_msg,
+	.irq_set_vcpu_affinity	= intel_ir_set_vcpu_affinity,
+};
+
 static void fill_msi_msg(struct msi_msg *msg, u32 index, u32 subhandle)
 {
 	memset(msg, 0, sizeof(*msg));
@@ -1274,6 +1369,11 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 		break;
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
+		if (posted_msi_supported()) {
+			prepare_irte_posted(irte);
+			data->irq_2_iommu.posted_msi = 1;
+		}
+
 		set_msi_sid(irte,
 			    pci_real_dma_dev(msi_desc_to_pci_dev(info->desc)));
 		break;
@@ -1361,7 +1461,12 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
 
 		irq_data->hwirq = (index << 16) + i;
 		irq_data->chip_data = ird;
-		irq_data->chip = &intel_ir_chip;
+		if (posted_msi_supported() &&
+		    ((info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI) ||
+		     (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSIX)))
+			irq_data->chip = &intel_ir_chip_post_msi;
+		else
+			irq_data->chip = &intel_ir_chip;
 		intel_irq_remapping_prepare_irte(ird, irq_cfg, info, index, i);
 		irq_set_status_flags(virq + i, IRQ_MOVE_PCNTXT);
 	}

