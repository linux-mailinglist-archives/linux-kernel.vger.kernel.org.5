Return-Path: <linux-kernel+bounces-67620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF540856E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F357A1C229F7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7844C13B280;
	Thu, 15 Feb 2024 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZfP0KVV5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dGpVmmF+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76E2138497;
	Thu, 15 Feb 2024 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027022; cv=none; b=bRNFml3whB3VEjXFdhnBkikh5pIRGIx1Jb2xE88Q8vvP6Qg+RokQx6QNDH227qp+RBeq88h9DG/34uue9PZx3bSs5GjP3/e8flMipwasmakbAOmVIPh8q4qP+T5gDla9EQAFShsGRDItNWpqUxRnsROYbEWwcgqOFiA5XscJ/GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027022; c=relaxed/simple;
	bh=v47pHAasn8MdjYA+f3l9jeSxWB4YEIsd1dzvoMOTMrs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KzeTTRKgDF4OwQ5n81V4C74i0WCxxqaQ8Am7zSGsHrLF1on4NOQeqsdHOGWrwAqZ64qUFUtGSwvQxCrBDjTKEJB3XiJGzF1cGvqiTOhb4kTKF/s40OdqRFPrG/WMNdgi9hswmZfQ3bYrWyO6nQ3zvHHmTqeC4caF+HS+lJ8kF2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZfP0KVV5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dGpVmmF+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Feb 2024 19:56:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708027018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ePc7duUErdFHn02Yhoblfga7WwrJ8JliqVSXzIVyRKU=;
	b=ZfP0KVV5Icv0+0mzzUd3Q+La/rwtXbIGfz7kxD3EPwkknDOKDWDDnra7yc2cLpZKhEbF2P
	jb0wOe6YPGMwsCOJ/DoprC30ZTu64TzAV72ShmQe4CxmkfsU28OazJhQfLlZczcapo2mBF
	nB+lknudKkEhkBXLs6ZgDQP6K+2C0wPWHLz6AwlKBky9qmdZPz2lEz5Q0izEpmz3RRBaA2
	0bt6fIe/1qPNhFcjsxEqCRNfXZTmttXALPqcyn/Jcf3QKO0RTyOXl8NKqGyoTptFj73l0K
	OEh7qdDYWwYx4k8aII5BeaOd3rkE/UTk3QBfcp5cEoOO92FkDKP/xRbs1672Rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708027018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ePc7duUErdFHn02Yhoblfga7WwrJ8JliqVSXzIVyRKU=;
	b=dGpVmmF+8oKWtI7RRlcA4hV/LqHKEFvfnR5FeNdJEYOwNxDaERjfa7Y2XxWvdise30bXjD
	SAT3f/ywUH7ZHcDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Provide allocation/free functions for
 "wired" MSI interrupts
Cc: Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240127161753.114685-12-apatel@ventanamicro.com>
References: <20240127161753.114685-12-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170802701803.398.1858299374515135823.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     0ee1578b00bcf5ef8e7955f0c6f02a624443eb29
Gitweb:        https://git.kernel.org/tip/0ee1578b00bcf5ef8e7955f0c6f02a624443eb29
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 27 Jan 2024 21:47:39 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 17:55:41 +01:00

genirq/msi: Provide allocation/free functions for "wired" MSI interrupts

To support wire to MSI bridges proper in the MSI core infrastructure it is
required to have separate allocation/free interfaces which can be invoked
from the regular irqdomain allocaton/free functions.

The mechanism for allocation is:
  - Allocate the next free MSI descriptor index in the domain
  - Store the hardware interrupt number and the trigger type
    which was extracted by the irqdomain core from the firmware spec
    in the MSI descriptor device cookie so it can be retrieved by
    the underlying interrupt domain and interrupt chip
  - Use the regular MSI allocation mechanism for the newly allocated
    index which returns a fully initialized Linux interrupt on succes

This works because:
  - the domains have a fixed size
  - each hardware interrupt is only allocated once
  - the underlying domain does not care about the MSI index it only cares
    about the hardware interrupt number and the trigger type

The free function looks up the MSI index in the MSI descriptor of the
provided Linux interrupt number and uses the regular index based free
functions of the MSI core.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240127161753.114685-12-apatel@ventanamicro.com

---
 include/linux/irqdomain.h | 17 ++++++++++-
 kernel/irq/msi.c          | 68 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 85 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index ee0a82c..21ecf58 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -619,6 +619,23 @@ static inline bool irq_domain_is_msi_device(struct irq_domain *domain)
 
 #endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 
+#ifdef CONFIG_GENERIC_MSI_IRQ
+int msi_device_domain_alloc_wired(struct irq_domain *domain, unsigned int hwirq,
+				  unsigned int type);
+void msi_device_domain_free_wired(struct irq_domain *domain, unsigned int virq);
+#else
+static inline int msi_device_domain_alloc_wired(struct irq_domain *domain, unsigned int hwirq,
+						unsigned int type)
+{
+	WARN_ON_ONCE(1);
+	return -EINVAL;
+}
+static inline void msi_device_domain_free_wired(struct irq_domain *domain, unsigned int virq)
+{
+	WARN_ON_ONCE(1);
+}
+#endif
+
 #else /* CONFIG_IRQ_DOMAIN */
 static inline void irq_dispose_mapping(unsigned int virq) { }
 static inline struct irq_domain *irq_find_matching_fwnode(
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 5289fc2..07e9daa 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1540,6 +1540,50 @@ struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, u
 	return map;
 }
 
+/**
+ * msi_device_domain_alloc_wired - Allocate a "wired" interrupt on @domain
+ * @domain:	The domain to allocate on
+ * @hwirq:	The hardware interrupt number to allocate for
+ * @type:	The interrupt type
+ *
+ * This weirdness supports wire to MSI controllers like MBIGEN.
+ *
+ * @hwirq is the hardware interrupt number which is handed in from
+ * irq_create_fwspec_mapping(). As the wire to MSI domain is sparse, but
+ * sized in firmware, the hardware interrupt number cannot be used as MSI
+ * index. For the underlying irq chip the MSI index is irrelevant and
+ * all it needs is the hardware interrupt number.
+ *
+ * To handle this the MSI index is allocated with MSI_ANY_INDEX and the
+ * hardware interrupt number is stored along with the type information in
+ * msi_desc::cookie so the underlying interrupt chip and domain code can
+ * retrieve it.
+ *
+ * Return: The Linux interrupt number (> 0) or an error code
+ */
+int msi_device_domain_alloc_wired(struct irq_domain *domain, unsigned int hwirq,
+				  unsigned int type)
+{
+	unsigned int domid = MSI_DEFAULT_DOMAIN;
+	union msi_instance_cookie icookie = { };
+	struct device *dev = domain->dev;
+	struct msi_map map = { };
+
+	if (WARN_ON_ONCE(!dev || domain->bus_token != DOMAIN_BUS_WIRED_TO_MSI))
+		return -EINVAL;
+
+	icookie.value = ((u64)type << 32) | hwirq;
+
+	msi_lock_descs(dev);
+	if (WARN_ON_ONCE(msi_get_device_domain(dev, domid) != domain))
+		map.index = -EINVAL;
+	else
+		map = __msi_domain_alloc_irq_at(dev, domid, MSI_ANY_INDEX, NULL, &icookie);
+	msi_unlock_descs(dev);
+
+	return map.index >= 0 ? map.virq : map.index;
+}
+
 static void __msi_domain_free_irqs(struct device *dev, struct irq_domain *domain,
 				   struct msi_ctrl *ctrl)
 {
@@ -1666,6 +1710,30 @@ void msi_domain_free_irqs_all(struct device *dev, unsigned int domid)
 }
 
 /**
+ * msi_device_domain_free_wired - Free a wired interrupt in @domain
+ * @domain:	The domain to free the interrupt on
+ * @virq:	The Linux interrupt number to free
+ *
+ * This is the counterpart of msi_device_domain_alloc_wired() for the
+ * weird wired to MSI converting domains.
+ */
+void msi_device_domain_free_wired(struct irq_domain *domain, unsigned int virq)
+{
+	struct msi_desc *desc = irq_get_msi_desc(virq);
+	struct device *dev = domain->dev;
+
+	if (WARN_ON_ONCE(!dev || !desc || domain->bus_token != DOMAIN_BUS_WIRED_TO_MSI))
+		return;
+
+	msi_lock_descs(dev);
+	if (!WARN_ON_ONCE(msi_get_device_domain(dev, MSI_DEFAULT_DOMAIN) != domain)) {
+		msi_domain_free_irqs_range_locked(dev, MSI_DEFAULT_DOMAIN, desc->msi_index,
+						  desc->msi_index);
+	}
+	msi_unlock_descs(dev);
+}
+
+/**
  * msi_get_domain_info - Get the MSI interrupt domain info for @domain
  * @domain:	The interrupt domain to retrieve data from
  *

