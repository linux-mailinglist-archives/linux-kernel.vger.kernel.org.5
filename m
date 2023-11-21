Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECB67F35A0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbjKUSFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbjKUSFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:05:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8DE1731;
        Tue, 21 Nov 2023 10:04:26 -0800 (PST)
Date:   Tue, 21 Nov 2023 18:04:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700589864;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1NZG0oxczvr2EgyPPyAUM9PczNu44SOnBJnmbRObbZ4=;
        b=tJLWkylBFobHtPjUcK4h4VSRnltP1SyiEN32xDKUBhyY3zQ+FiqwGqAkwPDfsvIfqTEOmW
        zxvVoG2qsR754DVfUAg6xPCUQvCbf/nhv4wvNsg7T5l8KTgIDDQlk3CkUao9V2G/37jv46
        SZIPImLxPOSinxX1Snlk8mSLiEoLTapFX+jh8gHO0w5TTXVRvhnw+CoCy05GB4hOzqaxAQ
        LuwUw7QAlTpjVAEYozrgVAQ/o9srQZLX2E30LeRZ8ViVYgDvAIO8Qpp8y9Emk4CfFdzdFX
        eV0wijoM52DbXU6nyQOCzbN0zHq/QuY0SfJOl4VOkq8etOzys9J6X+R+SSHdYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700589864;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1NZG0oxczvr2EgyPPyAUM9PczNu44SOnBJnmbRObbZ4=;
        b=CRHQHkpyz3EwQL8Rv+SP0HytTEwnt+SgFIyXsIoMv6702lIrzrLVjnlC4JcD0qQGzU1kiR
        HggPDrfoCxQ08lCQ==
From:   "tip-bot2 for Andrew Cooper" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Drop apic::delivery_mode
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231102-x86-apic-v1-1-bf049a2a0ed6@citrix.com>
References: <20231102-x86-apic-v1-1-bf049a2a0ed6@citrix.com>
MIME-Version: 1.0
Message-ID: <170058986413.398.14166594117480586557.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     07e8f88568f558fb0f9529f49b3ab120cbe750fe
Gitweb:        https://git.kernel.org/tip/07e8f88568f558fb0f9529f49b3ab120cbe750fe
Author:        Andrew Cooper <andrew.cooper3@citrix.com>
AuthorDate:    Thu, 02 Nov 2023 12:26:19 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 21 Nov 2023 16:58:54 +01:00

x86/apic: Drop apic::delivery_mode

This field is set to APIC_DELIVERY_MODE_FIXED in all cases, and is read
exactly once.  Fold the constant in uv_program_mmr() and drop the field.

Searching for the origin of the stale HyperV comment reveals commit
a31e58e129f7 ("x86/apic: Switch all APICs to Fixed delivery mode") which
notes:

  As a consequence of this change, the apic::irq_delivery_mode field is
  now pointless, but this needs to be cleaned up in a separate patch.

6 years is long enough for this technical debt to have survived.

  [ bp: Fold in
    https://lore.kernel.org/r/20231121123034.1442059-1-andrew.cooper3@citrix.com
  ]

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lore.kernel.org/r/20231102-x86-apic-v1-1-bf049a2a0ed6@citrix.com
---
 arch/x86/include/asm/apic.h           | 2 --
 arch/x86/kernel/apic/apic_flat_64.c   | 2 --
 arch/x86/kernel/apic/apic_noop.c      | 1 -
 arch/x86/kernel/apic/apic_numachip.c  | 2 --
 arch/x86/kernel/apic/bigsmp_32.c      | 1 -
 arch/x86/kernel/apic/probe_32.c       | 1 -
 arch/x86/kernel/apic/x2apic_cluster.c | 1 -
 arch/x86/kernel/apic/x2apic_phys.c    | 1 -
 arch/x86/kernel/apic/x2apic_uv_x.c    | 1 -
 arch/x86/platform/uv/uv_irq.c         | 2 +-
 drivers/iommu/amd/iommu.c             | 4 ++--
 drivers/iommu/intel/irq_remapping.c   | 2 +-
 drivers/pci/controller/pci-hyperv.c   | 7 -------
 13 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index d21f48f..9d159b7 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -272,8 +272,6 @@ struct apic {
 	void	(*send_IPI_all)(int vector);
 	void	(*send_IPI_self)(int vector);
 
-	enum apic_delivery_modes delivery_mode;
-
 	u32	disable_esr		: 1,
 		dest_mode_logical	: 1,
 		x2apic_set_max_apicid	: 1,
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 7139867..b295a05 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -82,7 +82,6 @@ static struct apic apic_flat __ro_after_init = {
 	.acpi_madt_oem_check		= flat_acpi_madt_oem_check,
 	.apic_id_registered		= default_apic_id_registered,
 
-	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= true,
 
 	.disable_esr			= 0,
@@ -154,7 +153,6 @@ static struct apic apic_physflat __ro_after_init = {
 	.acpi_madt_oem_check		= physflat_acpi_madt_oem_check,
 	.apic_id_registered		= default_apic_id_registered,
 
-	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
 
 	.disable_esr			= 0,
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index b00d52a..9f1d553 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -47,7 +47,6 @@ static void noop_apic_write(u32 reg, u32 val)
 struct apic apic_noop __ro_after_init = {
 	.name				= "noop",
 
-	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= true,
 
 	.disable_esr			= 0,
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 456a14c..7d0c51b 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -222,7 +222,6 @@ static const struct apic apic_numachip1 __refconst = {
 	.probe				= numachip1_probe,
 	.acpi_madt_oem_check		= numachip1_acpi_madt_oem_check,
 
-	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
 
 	.disable_esr			= 0,
@@ -259,7 +258,6 @@ static const struct apic apic_numachip2 __refconst = {
 	.probe				= numachip2_probe,
 	.acpi_madt_oem_check		= numachip2_acpi_madt_oem_check,
 
-	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
 
 	.disable_esr			= 0,
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index 7ee3c48..5a0d60b 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -80,7 +80,6 @@ static struct apic apic_bigsmp __ro_after_init = {
 	.name				= "bigsmp",
 	.probe				= probe_bigsmp,
 
-	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
 
 	.disable_esr			= 1,
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 5eb3fbe..c0f7805 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -45,7 +45,6 @@ static struct apic apic_default __ro_after_init = {
 	.probe				= probe_default,
 	.apic_id_registered		= default_apic_id_registered,
 
-	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= true,
 
 	.disable_esr			= 0,
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index a830608..28a7d3f 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -227,7 +227,6 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
 	.probe				= x2apic_cluster_probe,
 	.acpi_madt_oem_check		= x2apic_acpi_madt_oem_check,
 
-	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= true,
 
 	.disable_esr			= 0,
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 558a4a8..409815a 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -145,7 +145,6 @@ static struct apic apic_x2apic_phys __ro_after_init = {
 	.probe				= x2apic_phys_probe,
 	.acpi_madt_oem_check		= x2apic_acpi_madt_oem_check,
 
-	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
 
 	.disable_esr			= 0,
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 1b0d733..f1766b1 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -805,7 +805,6 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
 	.probe				= uv_probe,
 	.acpi_madt_oem_check		= uv_acpi_madt_oem_check,
 
-	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
 
 	.disable_esr			= 0,
diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
index 4221259..a379501 100644
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -35,7 +35,7 @@ static void uv_program_mmr(struct irq_cfg *cfg, struct uv_irq_2_mmr_pnode *info)
 	mmr_value = 0;
 	entry = (struct uv_IO_APIC_route_entry *)&mmr_value;
 	entry->vector		= cfg->vector;
-	entry->delivery_mode	= apic->delivery_mode;
+	entry->delivery_mode	= APIC_DELIVERY_MODE_FIXED;
 	entry->dest_mode	= apic->dest_mode_logical;
 	entry->polarity		= 0;
 	entry->trigger		= 0;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index fcc987f..b9a0523 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3357,7 +3357,7 @@ static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 
 	data->irq_2_irte.devid = devid;
 	data->irq_2_irte.index = index + sub_handle;
-	iommu->irte_ops->prepare(data->entry, apic->delivery_mode,
+	iommu->irte_ops->prepare(data->entry, APIC_DELIVERY_MODE_FIXED,
 				 apic->dest_mode_logical, irq_cfg->vector,
 				 irq_cfg->dest_apicid, devid);
 
@@ -3634,7 +3634,7 @@ int amd_iommu_deactivate_guest_mode(void *data)
 
 	entry->lo.fields_remap.valid       = valid;
 	entry->lo.fields_remap.dm          = apic->dest_mode_logical;
-	entry->lo.fields_remap.int_type    = apic->delivery_mode;
+	entry->lo.fields_remap.int_type    = APIC_DELIVERY_MODE_FIXED;
 	entry->hi.fields.vector            = cfg->vector;
 	entry->lo.fields_remap.destination =
 				APICID_TO_IRTE_DEST_LO(cfg->dest_apicid);
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 29b9e55..566297b 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1112,7 +1112,7 @@ static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 	 * irq migration in the presence of interrupt-remapping.
 	*/
 	irte->trigger_mode = 0;
-	irte->dlvry_mode = apic->delivery_mode;
+	irte->dlvry_mode = APIC_DELIVERY_MODE_FIXED;
 	irte->vector = vector;
 	irte->dest_id = IRTE_DEST(dest);
 	irte->redir_hint = 1;
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 30c7dfe..1eaffff 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -650,13 +650,6 @@ static void hv_arch_irq_unmask(struct irq_data *data)
 			   PCI_FUNC(pdev->devfn);
 	params->int_target.vector = hv_msi_get_int_vector(data);
 
-	/*
-	 * Honoring apic->delivery_mode set to APIC_DELIVERY_MODE_FIXED by
-	 * setting the HV_DEVICE_INTERRUPT_TARGET_MULTICAST flag results in a
-	 * spurious interrupt storm. Not doing so does not seem to have a
-	 * negative effect (yet?).
-	 */
-
 	if (hbus->protocol_version >= PCI_PROTOCOL_VERSION_1_2) {
 		/*
 		 * PCI_PROTOCOL_VERSION_1_2 supports the VP_SET version of the
