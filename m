Return-Path: <linux-kernel+bounces-117501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F1D88AC03
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD54B1C3EA56
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048EA14A4F8;
	Mon, 25 Mar 2024 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y4mzA6CP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T/RCpfZb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222CE14A099;
	Mon, 25 Mar 2024 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385214; cv=none; b=FkjdIncamZL6wrFso4UZ4EG20UD2In35qHacQFXxEsFlhulxXhcZdHwVlURWgT/pNK+jrbRRRW5LraPmEJ5yGIqg3r6HxU8gNxnZ+EmDK/ONMIvDvKw3k7kgsaPtAX5bhbEVWlZ0svEaN/1kW05MHjj+0DZn+J+i/WUSPREnoh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385214; c=relaxed/simple;
	bh=WDpxRazuUKQ8mEf8henixJR8aCVxNJWAaDiTm3Quqxw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Q3L+5y0kKBmEobfRnIFCAaHumBC03ByiWnh3YOtgNZ61nPF4BMYXltx18s3vxBjHTsNUxWIWDu2DFl6hHZttrVThsXHTxK3+JiyBL0tHxj0KrjjIkokfDSoMvKBhk0MvojlVizO7mVt6bzG0UpBtICGkwMOknR06W+KfJWc3j14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y4mzA6CP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T/RCpfZb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Mar 2024 16:46:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711385210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gG9WJ+Qu13SYZKLktUGFXGOk5sKBElmuj4Ri68e1Hnk=;
	b=Y4mzA6CPbVm8PmHMwilyaG3vmzhDHC97mqFD9cGjiUaL4ZqicgesvKKHH0HV4iDKjr1hpZ
	5vuIipRQjEgOi1rqeNNWTkqb+rtwNztqtz5+JT8swyznhHsmqBl8zGagkPadqBVG+eODi3
	sfiE7tjlpS1LWkYiS3WBPUrBqJEgyInX2ODYLTk1FicEV+wHjSh4afoyJ9kyLTx4Aqatpc
	dKCQy72u9+2N1gy+y84mIM0ycZiWPmn5Reqh3VDUtoz4SJMRQgOhrK+wC3QBGhOpSwKk9Q
	mIc9hcoJJkubzPbgsaLMBzmn/3o3UdSdJpT2BKwjz3eiZhWc2XshYk5jKCeXxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711385210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gG9WJ+Qu13SYZKLktUGFXGOk5sKBElmuj4Ri68e1Hnk=;
	b=T/RCpfZbqxbsbRT6hI8+U5TC4lh7B9Sxm4ysr6ptzIFe6Cp2kWLF3D+u7xDxfiKVxmbwo+
	k5bDyL6deqIXdGAQ==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/riscv-imsic: Add device MSI domain support
 for PCI devices
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 bjorn@rivosinc.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20240307140307.646078-5-apatel@ventanamicro.com>
References: <20240307140307.646078-5-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171138520983.10875.5030487817825650284.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5c5a71d0434093cd42d09afd4e2032c0b16a7da8
Gitweb:        https://git.kernel.org/tip/5c5a71d0434093cd42d09afd4e2032c0b16=
a7da8
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Thu, 07 Mar 2024 19:33:02 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 25 Mar 2024 17:38:28 +01:00

irqchip/riscv-imsic: Add device MSI domain support for PCI devices

The Linux PCI framework supports per-device MSI domains for PCI devices
so extend the IMSIC driver to allow PCI per-device MSI domains.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Link: https://lore.kernel.org/r/20240307140307.646078-5-apatel@ventanamicro.c=
om

---
 drivers/irqchip/Kconfig                    |  7 ++++-
 drivers/irqchip/irq-riscv-imsic-platform.c | 35 +++++++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 8610810..8f6ce41 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -547,6 +547,13 @@ config RISCV_IMSIC
 	select GENERIC_IRQ_MATRIX_ALLOCATOR
 	select GENERIC_MSI_IRQ
=20
+config RISCV_IMSIC_PCI
+	bool
+	depends on RISCV_IMSIC
+	depends on PCI
+	depends on PCI_MSI
+	default RISCV_IMSIC
+
 config SIFIVE_PLIC
 	bool
 	depends on RISCV
diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq=
-riscv-imsic-platform.c
index 35291bf..1e6dddf 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -14,6 +14,7 @@
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/msi.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/smp.h>
@@ -207,6 +208,28 @@ static const struct irq_domain_ops imsic_base_domain_ops=
 =3D {
 #endif
 };
=20
+#ifdef CONFIG_RISCV_IMSIC_PCI
+
+static void imsic_pci_mask_irq(struct irq_data *d)
+{
+	pci_msi_mask_irq(d);
+	irq_chip_mask_parent(d);
+}
+
+static void imsic_pci_unmask_irq(struct irq_data *d)
+{
+	irq_chip_unmask_parent(d);
+	pci_msi_unmask_irq(d);
+}
+
+#define MATCH_PCI_MSI		BIT(DOMAIN_BUS_PCI_MSI)
+
+#else
+
+#define MATCH_PCI_MSI		0
+
+#endif
+
 static bool imsic_init_dev_msi_info(struct device *dev,
 				    struct irq_domain *domain,
 				    struct irq_domain *real_parent,
@@ -230,6 +253,13 @@ static bool imsic_init_dev_msi_info(struct device *dev,
=20
 	/* Is the target supported? */
 	switch (info->bus_token) {
+#ifdef CONFIG_RISCV_IMSIC_PCI
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		info->chip->irq_mask =3D imsic_pci_mask_irq;
+		info->chip->irq_unmask =3D imsic_pci_unmask_irq;
+		break;
+#endif
 	case DOMAIN_BUS_DEVICE_MSI:
 		/*
 		 * Per-device MSI should never have any MSI feature bits
@@ -269,11 +299,12 @@ static bool imsic_init_dev_msi_info(struct device *dev,
 #define MATCH_PLATFORM_MSI		BIT(DOMAIN_BUS_PLATFORM_MSI)
=20
 static const struct msi_parent_ops imsic_msi_parent_ops =3D {
-	.supported_flags	=3D MSI_GENERIC_FLAGS_MASK,
+	.supported_flags	=3D MSI_GENERIC_FLAGS_MASK |
+				  MSI_FLAG_PCI_MSIX,
 	.required_flags		=3D MSI_FLAG_USE_DEF_DOM_OPS |
 				  MSI_FLAG_USE_DEF_CHIP_OPS,
 	.bus_select_token	=3D DOMAIN_BUS_NEXUS,
-	.bus_select_mask	=3D MATCH_PLATFORM_MSI,
+	.bus_select_mask	=3D MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
 	.init_dev_msi_info	=3D imsic_init_dev_msi_info,
 };
=20

