Return-Path: <linux-kernel+bounces-67627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E9D856E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE0528646C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8325D145350;
	Thu, 15 Feb 2024 19:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aOZfEZvQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RXvh6gmn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6C713B2AA;
	Thu, 15 Feb 2024 19:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027026; cv=none; b=FEgj4kztpgunz79o7kLa6ZgdGQwwJQzWehAPIdVdoqyh5VW2TGWNi/wYivP4BkK0QLOJDWaw0U+0cCONHZefVzyOUCfdX2eAkeFW1cXT+gW9e6OS1bPt37xFAS3Q65SZpPLjVWhmWjDAYgOAREC/9YR7hXIH186L0EOz/+DvW/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027026; c=relaxed/simple;
	bh=/41vpQj8FMziSsAkXaYM+JLk1YVeB8jJZKNE2Bw3t80=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=s6X95ZevWSKz4xK4EKkdK3LA/Tgz0zif+iCIySvCFYy6SSYF4Ng7h9/9S1fp6pEBvuX5gL9qpoSNlpj80LUMh4argKF5naiAccUBjaM0jjI/SD9W8jR6nCMUWNGYFyjTztrzsmB3D5h7WqPoDIlwdGRuGJ/yr6V3ngnCgrDQRqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aOZfEZvQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RXvh6gmn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Feb 2024 19:57:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708027023;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xO4TKOj4l/TFIPHoxDGJ8nW2VyhqJpfFCtIpQxCBYlA=;
	b=aOZfEZvQ7+z7+JNv++nM6NPrcI4Ross7Wv+J50GbgtCXdVnSn4N/LC4WRnK+FakOE9OBXy
	6oiF4QLXdhyuhXk6XWLnAo6eYfO74Mvxs0AJ0p3X/I5rfflRZ0ctnCjec7Cs6Gmtn+7LZk
	WeJMHGvxV0AZP3gZmFHYuSqx64KW6vXKHWTKOe0OP1yRJOItsDiXEY9B/lnBG1HmO/zut/
	k1qZUagjH5CR0QjjUQjHlo59EFN7IJ+mp/pTzYvYbXoRHTZwfZB4VfDalUHcw7QSt43GvH
	+5ye+XcYMnu5eveYcHKuPbfYyO8YJM9lPGGazFEBTIHKqGqe3lqyISXFDKp+SA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708027023;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xO4TKOj4l/TFIPHoxDGJ8nW2VyhqJpfFCtIpQxCBYlA=;
	b=RXvh6gmnyZv4tbCT0PW+iQ2/vLRCp8r3ToDM8ZXFjQ1xMDqUpLtTOho8aCq/V2rumsATq7
	fyyz8ISkviHQiVDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] platform-msi: Prepare for real per device domains
Cc: Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240127161753.114685-6-apatel@ventanamicro.com>
References: <20240127161753.114685-6-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170802702233.398.6450485103740869369.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     c88f9110bfbca5975a8dee4c9792ba12684c7bca
Gitweb:        https://git.kernel.org/tip/c88f9110bfbca5975a8dee4c9792ba12684c7bca
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 27 Jan 2024 21:47:33 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 17:55:40 +01:00

platform-msi: Prepare for real per device domains

Provide functions to create and remove per device MSI domains which replace
the platform-MSI domains. The new model is that each of the devices which
utilize platform-MSI gets now its private MSI domain which is "customized"
in size and with a device specific function to write the MSI message into
the device.

This is the same functionality as platform-MSI but it avoids all the down
sides of platform MSI, i.e. the extra ID book keeping, the special data
structure in the msi descriptor. Further the domains are only created when
the devices are really in use, so the burden is on the usage and not on the
infrastructure.

Fill in the domain template and provide two functions to init/allocate and
remove a per device MSI domain.

Until all users and parent domain providers are converted, the init/alloc
function invokes the original platform-MSI code when the irqdomain which is
associated to the device does not provide MSI parent functionality yet.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240127161753.114685-6-apatel@ventanamicro.com

---
 drivers/base/platform-msi.c | 103 +++++++++++++++++++++++++++++++++++-
 include/linux/msi.h         |   4 +-
 2 files changed, 107 insertions(+)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index f37ad34..b56e919 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -13,6 +13,8 @@
 #include <linux/msi.h>
 #include <linux/slab.h>
 
+/* Begin of removal area. Once everything is converted over. Cleanup the includes too! */
+
 #define DEV_ID_SHIFT	21
 #define MAX_DEV_MSIS	(1 << (32 - DEV_ID_SHIFT))
 
@@ -350,3 +352,104 @@ int platform_msi_device_domain_alloc(struct irq_domain *domain, unsigned int vir
 
 	return msi_domain_populate_irqs(domain->parent, dev, virq, nr_irqs, &data->arg);
 }
+
+/* End of removal area */
+
+/* Real per device domain interfaces */
+
+/*
+ * This indirection can go when platform_device_msi_init_and_alloc_irqs()
+ * is switched to a proper irq_chip::irq_write_msi_msg() callback. Keep it
+ * simple for now.
+ */
+static void platform_msi_write_msi_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	irq_write_msi_msg_t cb = d->chip_data;
+
+	cb(irq_data_get_msi_desc(d), msg);
+}
+
+static void platform_msi_set_desc_byindex(msi_alloc_info_t *arg, struct msi_desc *desc)
+{
+	arg->desc = desc;
+	arg->hwirq = desc->msi_index;
+}
+
+static const struct msi_domain_template platform_msi_template = {
+	.chip = {
+		.name			= "pMSI",
+		.irq_mask		= irq_chip_mask_parent,
+		.irq_unmask		= irq_chip_unmask_parent,
+		.irq_write_msi_msg	= platform_msi_write_msi_msg,
+		/* The rest is filled in by the platform MSI parent */
+	},
+
+	.ops = {
+		.set_desc		= platform_msi_set_desc_byindex,
+	},
+
+	.info = {
+		.bus_token		= DOMAIN_BUS_DEVICE_MSI,
+	},
+};
+
+/**
+ * platform_device_msi_init_and_alloc_irqs - Initialize platform device MSI
+ *					     and allocate interrupts for @dev
+ * @dev:		The device for which to allocate interrupts
+ * @nvec:		The number of interrupts to allocate
+ * @write_msi_msg:	Callback to write an interrupt message for @dev
+ *
+ * Returns:
+ * Zero for success, or an error code in case of failure
+ *
+ * This creates a MSI domain on @dev which has @dev->msi.domain as
+ * parent. The parent domain sets up the new domain. The domain has
+ * a fixed size of @nvec. The domain is managed by devres and will
+ * be removed when the device is removed.
+ *
+ * Note: For migration purposes this falls back to the original platform_msi code
+ *	 up to the point where all platforms have been converted to the MSI
+ *	 parent model.
+ */
+int platform_device_msi_init_and_alloc_irqs(struct device *dev, unsigned int nvec,
+					    irq_write_msi_msg_t write_msi_msg)
+{
+	struct irq_domain *domain = dev->msi.domain;
+
+	if (!domain || !write_msi_msg)
+		return -EINVAL;
+
+	/* Migration support. Will go away once everything is converted */
+	if (!irq_domain_is_msi_parent(domain))
+		return platform_msi_domain_alloc_irqs(dev, nvec, write_msi_msg);
+
+	/*
+	 * @write_msi_msg is stored in the resulting msi_domain_info::data.
+	 * The underlying domain creation mechanism will assign that
+	 * callback to the resulting irq chip.
+	 */
+	if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN,
+					  &platform_msi_template,
+					  nvec, NULL, write_msi_msg))
+		return -ENODEV;
+
+	return msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN, 0, nvec - 1);
+}
+EXPORT_SYMBOL_GPL(platform_device_msi_init_and_alloc_irqs);
+
+/**
+ * platform_device_msi_free_irqs_all - Free all interrupts for @dev
+ * @dev:	The device for which to free interrupts
+ */
+void platform_device_msi_free_irqs_all(struct device *dev)
+{
+	struct irq_domain *domain = dev->msi.domain;
+
+	msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
+
+	/* Migration support. Will go away once everything is converted */
+	if (!irq_domain_is_msi_parent(domain))
+		platform_msi_free_priv_data(dev);
+}
+EXPORT_SYMBOL_GPL(platform_device_msi_free_irqs_all);
diff --git a/include/linux/msi.h b/include/linux/msi.h
index d5d1513..ef16796 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -664,6 +664,10 @@ int platform_msi_device_domain_alloc(struct irq_domain *domain, unsigned int vir
 void platform_msi_device_domain_free(struct irq_domain *domain, unsigned int virq,
 				     unsigned int nvec);
 void *platform_msi_get_host_data(struct irq_domain *domain);
+/* Per device platform MSI */
+int platform_device_msi_init_and_alloc_irqs(struct device *dev, unsigned int nvec,
+					    irq_write_msi_msg_t write_msi_msg);
+void platform_device_msi_free_irqs_all(struct device *dev);
 
 bool msi_device_has_isolated_msi(struct device *dev);
 #else /* CONFIG_GENERIC_MSI_IRQ */

