Return-Path: <linux-kernel+bounces-67619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6A6856E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED811C2201E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F3413AA2A;
	Thu, 15 Feb 2024 19:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ur49WNr3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5kmDE60Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE30213173A;
	Thu, 15 Feb 2024 19:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027021; cv=none; b=ltwcu61pbzrsAHM4jtS515lXMfiaKlHWGGlXqJj5z0ZkuA0yvsIF7pSa2cv6K7C38Xkd/UBfnC+IQhX9zYEsZGIQrdJCjTE0eE4Ldy+C8kAS8qWJslXsWzEianUsSTNCfzaSp9tB6dVssIem35+ZQeluDUVlFi0mD1hKPYtpCJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027021; c=relaxed/simple;
	bh=MdkC8XE9kvkmc9XSw3q9ZgPGrZxIlfGqOovweariG3c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JP8ziPHNK9e3ik6ZtfKlPR7Pu6C4Q/H8jursQuFSEz/EL2PrkRjsi6Lb5oEKCRijzaec9n7G3tUIHx2p45lMCHn62QKrHA/Hr2mRsK3RgJyPi/aVHqFibr9VYWRMivbeI7MHaE+QDcBT4dGEoJyYhfXjQclx67dDOC0BHXqsK1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ur49WNr3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5kmDE60Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Feb 2024 19:56:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708027018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+WqI9nPtixyKncAra6ZweS8GANBLUa92oMGDlLFv3rc=;
	b=ur49WNr3upAjaNjQbGrUAsw6vBCWNJAg81hxfTW/umjAvwlFIFbDHFAfhfuFbArO2yGpug
	xLbUSEspRqTa0qSZDDDZvV3RQcSJbGaItSlPd6tONUNmcdFdC+THDmXkjPL+Z2tn5/c2Zq
	pa8BEVa9rqajT5Mcykb173sngWCz2+L9ud3fQcyAuUL2dMOu98mFhf8d+T3zX0kIMUdHkY
	OjkzIFbcwHhFfyJAsGtBw3tHkOnHG5aDshtPkTR3IaVbS+UPACQAN+jZ/XJyGiIK/iYsgV
	tYgN6aecuegNVFs+2gm42ZhWkckU7lomJSyMK6WP0Ir6vlsb0Wya3tJIOB+80g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708027018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+WqI9nPtixyKncAra6ZweS8GANBLUa92oMGDlLFv3rc=;
	b=5kmDE60Z9rJB1BLyE5jwsjoXe/mLelQ5D9zzG2W37r0O4cxOsVn1NjExws6JmFfiiZ4ceQ
	eNAewuWDDXnuHiDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/irqdomain: Reroute device MSI create_mapping
Cc: Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240127161753.114685-13-apatel@ventanamicro.com>
References: <20240127161753.114685-13-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170802701742.398.8367609943575258696.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     e49312fe09df36cc4eae0cd6e1b08b563a91e1bc
Gitweb:        https://git.kernel.org/tip/e49312fe09df36cc4eae0cd6e1b08b563a91e1bc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 27 Jan 2024 21:47:40 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 17:55:41 +01:00

genirq/irqdomain: Reroute device MSI create_mapping

Reroute interrupt allocation in irq_create_fwspec_mapping() if the domain
is a MSI device domain. This is required to convert the support for wire
to MSI bridges to per device MSI domains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240127161753.114685-13-apatel@ventanamicro.com

---
 kernel/irq/irqdomain.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 8fee379..aeb4165 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -29,6 +29,7 @@ static int irq_domain_alloc_irqs_locked(struct irq_domain *domain, int irq_base,
 					unsigned int nr_irqs, int node, void *arg,
 					bool realloc, const struct irq_affinity_desc *affinity);
 static void irq_domain_check_hierarchy(struct irq_domain *domain);
+static void irq_domain_free_one_irq(struct irq_domain *domain, unsigned int virq);
 
 struct irqchip_fwid {
 	struct fwnode_handle	fwnode;
@@ -858,8 +859,13 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 	}
 
 	if (irq_domain_is_hierarchy(domain)) {
-		virq = irq_domain_alloc_irqs_locked(domain, -1, 1, NUMA_NO_NODE,
-						    fwspec, false, NULL);
+		if (irq_domain_is_msi_device(domain)) {
+			mutex_unlock(&domain->root->mutex);
+			virq = msi_device_domain_alloc_wired(domain, hwirq, type);
+			mutex_lock(&domain->root->mutex);
+		} else
+			virq = irq_domain_alloc_irqs_locked(domain, -1, 1, NUMA_NO_NODE,
+							    fwspec, false, NULL);
 		if (virq <= 0) {
 			virq = 0;
 			goto out;
@@ -914,7 +920,7 @@ void irq_dispose_mapping(unsigned int virq)
 		return;
 
 	if (irq_domain_is_hierarchy(domain)) {
-		irq_domain_free_irqs(virq, 1);
+		irq_domain_free_one_irq(domain, virq);
 	} else {
 		irq_domain_disassociate(domain, virq);
 		irq_free_desc(virq);
@@ -1755,6 +1761,14 @@ void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs)
 	irq_free_descs(virq, nr_irqs);
 }
 
+static void irq_domain_free_one_irq(struct irq_domain *domain, unsigned int virq)
+{
+	if (irq_domain_is_msi_device(domain))
+		msi_device_domain_free_wired(domain, virq);
+	else
+		irq_domain_free_irqs(virq, 1);
+}
+
 /**
  * irq_domain_alloc_irqs_parent - Allocate interrupts from parent domain
  * @domain:	Domain below which interrupts must be allocated
@@ -1907,9 +1921,9 @@ static int irq_domain_alloc_irqs_locked(struct irq_domain *domain, int irq_base,
 	return -EINVAL;
 }
 
-static void irq_domain_check_hierarchy(struct irq_domain *domain)
-{
-}
+static void irq_domain_check_hierarchy(struct irq_domain *domain) { }
+static void irq_domain_free_one_irq(struct irq_domain *domain, unsigned int virq) { }
+
 #endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS

