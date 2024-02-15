Return-Path: <linux-kernel+bounces-67623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AFF856E25
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525911F239A5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C3113173A;
	Thu, 15 Feb 2024 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lp0w6lrM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RlUrRL3q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B46013AA33;
	Thu, 15 Feb 2024 19:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027024; cv=none; b=Q8fw8hciLLaQ3nSx4736j79Wm+WQTxLAqm2uYIYXlGvJCqA1hhn/5F4GzujjYdAukcWmkqTlz5RfvafubPdlkcam3cLcwZuJMhpNwtCA550gvfC++apS3JapB47AE25CLRtNy6s38qB2ktlYafjmecq3v8PisXRCXPV4+7s+zV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027024; c=relaxed/simple;
	bh=OeeVCG7RBhvuvjZKP7HNIOysols2HfH4S2+D9T2+rng=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aEI2rrhqjTInYggwsAuopk4ZKrVkOR3mDyMtP/T2j7Rab0K/11YtjZaUt157ngQhHS/2qq+rRgmKKM4/jIQgiJv1xZpkmJ2f24+wx1MmfnSviI8PAFkYV0SWdEARbmbuVFclp6MKXwZ0vjrmY6+PIexWOGQuXX+j38ZJ+KJkrQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lp0w6lrM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RlUrRL3q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Feb 2024 19:56:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708027020;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vO/Q4R91798ZSjWnDDPj5X6ClAHtJ/BpdVFjwAjrplk=;
	b=lp0w6lrMUDEi3u5ABBjTKVbomHoxuAPwAcXHKHNjVq8eSHcdqy5K0UPsuQAbo97VtcPc7E
	trP5/cJwwfBLZu1xP6kLCHHSBKM3XYnca2t7UWXYSHbq+fFWgGYtWVwtsIPUL/qMLx3h9r
	da8+pCTZm/SitKDl52RfF4fBt+Ow1KVfYCn0U2vae7bVgDXUUNG7ZQGMbprxBHyxe9LbC9
	GpcXRwr7OqZz19+AFhf4/F9Ynn/1Q34vcAATHzS4mOYusPtlUoIegUvwRQK0e735oe/zRm
	wfEwKhchRcaaKbHJRn+i9WoFicVjfaA+6Ragc+25mLhNAyD/BqZA6/UHKsjRiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708027020;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vO/Q4R91798ZSjWnDDPj5X6ClAHtJ/BpdVFjwAjrplk=;
	b=RlUrRL3qWOVX68Dxq77APt4mltNIu4iCytrsOynMORwZb+Y/JgrjZXsbQpsoUoTXbErUF0
	L6sXEgV06TQHndAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Split msi_domain_alloc_irq_at()
Cc: Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240127161753.114685-9-apatel@ventanamicro.com>
References: <20240127161753.114685-9-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170802701985.398.15192642606846193090.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     3095cc0d5b2c246ddfcb18f54ed5557640224b6a
Gitweb:        https://git.kernel.org/tip/3095cc0d5b2c246ddfcb18f54ed5557640224b6a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 27 Jan 2024 21:47:36 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 17:55:40 +01:00

genirq/msi: Split msi_domain_alloc_irq_at()

In preparation for providing a special allocation function for wired
interrupts which are connected to a wire to MSI bridge, split the inner
workings of msi_domain_alloc_irq_at() out into a helper function so the
code can be shared.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240127161753.114685-9-apatel@ventanamicro.com

---
 kernel/irq/msi.c | 76 ++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 33 deletions(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index c0e7378..8d46390 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1446,34 +1446,10 @@ int msi_domain_alloc_irqs_all_locked(struct device *dev, unsigned int domid, int
 	return msi_domain_alloc_locked(dev, &ctrl);
 }
 
-/**
- * msi_domain_alloc_irq_at - Allocate an interrupt from a MSI interrupt domain at
- *			     a given index - or at the next free index
- *
- * @dev:	Pointer to device struct of the device for which the interrupts
- *		are allocated
- * @domid:	Id of the interrupt domain to operate on
- * @index:	Index for allocation. If @index == %MSI_ANY_INDEX the allocation
- *		uses the next free index.
- * @affdesc:	Optional pointer to an interrupt affinity descriptor structure
- * @icookie:	Optional pointer to a domain specific per instance cookie. If
- *		non-NULL the content of the cookie is stored in msi_desc::data.
- *		Must be NULL for MSI-X allocations
- *
- * This requires a MSI interrupt domain which lets the core code manage the
- * MSI descriptors.
- *
- * Return: struct msi_map
- *
- *	On success msi_map::index contains the allocated index number and
- *	msi_map::virq the corresponding Linux interrupt number
- *
- *	On failure msi_map::index contains the error code and msi_map::virq
- *	is %0.
- */
-struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, unsigned int index,
-				       const struct irq_affinity_desc *affdesc,
-				       union msi_instance_cookie *icookie)
+static struct msi_map __msi_domain_alloc_irq_at(struct device *dev, unsigned int domid,
+						unsigned int index,
+						const struct irq_affinity_desc *affdesc,
+						union msi_instance_cookie *icookie)
 {
 	struct msi_ctrl ctrl = { .domid	= domid, .nirqs = 1, };
 	struct irq_domain *domain;
@@ -1481,17 +1457,16 @@ struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, u
 	struct msi_desc *desc;
 	int ret;
 
-	msi_lock_descs(dev);
 	domain = msi_get_device_domain(dev, domid);
 	if (!domain) {
 		map.index = -ENODEV;
-		goto unlock;
+		return map;
 	}
 
 	desc = msi_alloc_desc(dev, 1, affdesc);
 	if (!desc) {
 		map.index = -ENOMEM;
-		goto unlock;
+		return map;
 	}
 
 	if (icookie)
@@ -1500,7 +1475,7 @@ struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, u
 	ret = msi_insert_desc(dev, desc, domid, index);
 	if (ret) {
 		map.index = ret;
-		goto unlock;
+		return map;
 	}
 
 	ctrl.first = ctrl.last = desc->msi_index;
@@ -1513,7 +1488,42 @@ struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, u
 		map.index = desc->msi_index;
 		map.virq = desc->irq;
 	}
-unlock:
+	return map;
+}
+
+/**
+ * msi_domain_alloc_irq_at - Allocate an interrupt from a MSI interrupt domain at
+ *			     a given index - or at the next free index
+ *
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are allocated
+ * @domid:	Id of the interrupt domain to operate on
+ * @index:	Index for allocation. If @index == %MSI_ANY_INDEX the allocation
+ *		uses the next free index.
+ * @affdesc:	Optional pointer to an interrupt affinity descriptor structure
+ * @icookie:	Optional pointer to a domain specific per instance cookie. If
+ *		non-NULL the content of the cookie is stored in msi_desc::data.
+ *		Must be NULL for MSI-X allocations
+ *
+ * This requires a MSI interrupt domain which lets the core code manage the
+ * MSI descriptors.
+ *
+ * Return: struct msi_map
+ *
+ *	On success msi_map::index contains the allocated index number and
+ *	msi_map::virq the corresponding Linux interrupt number
+ *
+ *	On failure msi_map::index contains the error code and msi_map::virq
+ *	is %0.
+ */
+struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, unsigned int index,
+				       const struct irq_affinity_desc *affdesc,
+				       union msi_instance_cookie *icookie)
+{
+	struct msi_map map;
+
+	msi_lock_descs(dev);
+	map = __msi_domain_alloc_irq_at(dev, domid, index, affdesc, icookie);
 	msi_unlock_descs(dev);
 	return map;
 }

