Return-Path: <linux-kernel+bounces-67624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23D3856E27
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18743B2645A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B4313DBBF;
	Thu, 15 Feb 2024 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yghoDwAN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/P0SdQLx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD80113AA43;
	Thu, 15 Feb 2024 19:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027024; cv=none; b=q7IjM9Yko3kBPWEcICtRfFevs6jRLNE+cUUIwkmM5hQ7XOjUZHOz71EwTyf+t5gf+Lb0Y8IfUirlYg7ZE7IjWVE0/c2rpaz2cphWtvM9K6YMVVA4AWM8PWTnQH8vA/aL/4fHWGQo10vkr6IEQvOJFGskydfp5u6eY28S9PK7khM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027024; c=relaxed/simple;
	bh=J8itKEG6VZgiw2v6brKzejWeia5Ls5V1ZO6GdHoOFcM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GD5eB9CySwHBElcULha4XEZK9d6NtxL+qXP302+oS36FV766CCKZOMiqH5JdPYTkp17RutsEQolQ1dn5MQPvGX41gttWDhCZlFO2SoObqvlwuYd9ljr0aypNuvyMsr8Q562a5zqTgEBs+IrBJrO1A2FFu9nVKZVrxHctFvJt+sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yghoDwAN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/P0SdQLx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Feb 2024 19:57:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708027021;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FTsx0KlMppJQ9egWgtBE3u5KUNaebJ8poL2TRXx9bpo=;
	b=yghoDwAN+XpmDWz+vgdAobO4k1NZpeN+cmrtlYqmjGkgum5JvlfvMhWUdg5w++GIHfGf9O
	4jncWb3E0QIIhEIxgOmf0UPgGjG1RxCVpq9k7z1GUqFxcU9gjGQDJQm21CszwPC9pizgxI
	ez4+HXXowKjpgYtD2H6BrxdQSmorHjCvGZlq3MaxW6m7I5tB2rSCvNhwGh/D/HUFiwtEfG
	Rke67P3Lnioi8FQ85+e7h817LQOY3ihtKyJ0x8YJtVE6fPU8mzxVGBaOMj94eGCR+xeva3
	ukPOL5ecCb7Vjmfe8f7PKzIWD1hecqm1CpOFwpwy/GrNixXkUL87SC6QPFtdaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708027021;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FTsx0KlMppJQ9egWgtBE3u5KUNaebJ8poL2TRXx9bpo=;
	b=/P0SdQLx491ZBqKtrTIBv1wyLPLbualFOaZlb0uvaFpJOrAjMlhPt+WNg1Bol61f8YDmu3
	LZODirqqMuILuaDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Provide optional translation op
Cc: Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240127161753.114685-8-apatel@ventanamicro.com>
References: <20240127161753.114685-8-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170802702048.398.11225153893259740520.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     9c78c1a85c04bdfbccc5a50588e001087d942b08
Gitweb:        https://git.kernel.org/tip/9c78c1a85c04bdfbccc5a50588e001087d942b08
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 27 Jan 2024 21:47:35 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 17:55:40 +01:00

genirq/msi: Provide optional translation op

irq_create_fwspec_mapping() requires translation of the firmware spec to a
hardware interrupt number and the trigger type information.

Wired interrupts which are connected to a wire to MSI bridge, like MBIGEN
are allocated that way. So far MBIGEN provides a regular irqdomain which
then hooks backwards into the MSI infrastructure. That's an unholy mess and
will be replaced with per device MSI domains which are regular MSI domains.

Interrupts on MSI domains are not supported by irq_create_fwspec_mapping(),
but for making the wire to MSI bridges sane it makes sense to provide a
special allocation/free interface in the MSI infrastructure. That avoids
the backdoors into the core MSI allocation code and just shares all the
regular MSI infrastructure.

Provide an optional translation callback in msi_domain_ops which can be
utilized by these wire to MSI bridges. No other MSI domain should provide a
translation callback. The default translation callback of the MSI
irqdomains will warn when it is invoked on a non-prepared MSI domain.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240127161753.114685-8-apatel@ventanamicro.com

---
 include/linux/msi.h |  5 +++++
 kernel/irq/msi.c    | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index b0842ea..24a5424 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -412,6 +412,7 @@ bool arch_restore_msi_irqs(struct pci_dev *dev);
 struct irq_domain;
 struct irq_domain_ops;
 struct irq_chip;
+struct irq_fwspec;
 struct device_node;
 struct fwnode_handle;
 struct msi_domain_info;
@@ -431,6 +432,8 @@ struct msi_domain_info;
  *			function.
  * @msi_post_free:	Optional function which is invoked after freeing
  *			all interrupts.
+ * @msi_translate:	Optional translate callback to support the odd wire to
+ *			MSI bridges, e.g. MBIGEN
  *
  * @get_hwirq, @msi_init and @msi_free are callbacks used by the underlying
  * irqdomain.
@@ -468,6 +471,8 @@ struct msi_domain_ops {
 					    struct device *dev);
 	void		(*msi_post_free)(struct irq_domain *domain,
 					 struct device *dev);
+	int		(*msi_translate)(struct irq_domain *domain, struct irq_fwspec *fwspec,
+					 irq_hw_number_t *hwirq, unsigned int *type);
 };
 
 /**
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 79b4a58..c0e7378 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -726,11 +726,26 @@ static void msi_domain_free(struct irq_domain *domain, unsigned int virq,
 	irq_domain_free_irqs_top(domain, virq, nr_irqs);
 }
 
+static int msi_domain_translate(struct irq_domain *domain, struct irq_fwspec *fwspec,
+				irq_hw_number_t *hwirq, unsigned int *type)
+{
+	struct msi_domain_info *info = domain->host_data;
+
+	/*
+	 * This will catch allocations through the regular irqdomain path except
+	 * for MSI domains which really support this, e.g. MBIGEN.
+	 */
+	if (!info->ops->msi_translate)
+		return -ENOTSUPP;
+	return info->ops->msi_translate(domain, fwspec, hwirq, type);
+}
+
 static const struct irq_domain_ops msi_domain_ops = {
 	.alloc		= msi_domain_alloc,
 	.free		= msi_domain_free,
 	.activate	= msi_domain_activate,
 	.deactivate	= msi_domain_deactivate,
+	.translate	= msi_domain_translate,
 };
 
 static irq_hw_number_t msi_domain_ops_get_hwirq(struct msi_domain_info *info,

