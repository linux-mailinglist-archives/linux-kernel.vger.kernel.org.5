Return-Path: <linux-kernel+bounces-67621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 033C9856E20
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A624B285A68
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9576813B284;
	Thu, 15 Feb 2024 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R4d/5917";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LVlXZCl3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2574113A895;
	Thu, 15 Feb 2024 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027022; cv=none; b=Kd9TUjaomZQR+cz8Sx3rccOswFmLaINOwcZCfYU8cU/HSxxVAu8/kxieUI0b8YrmGT/Q7K3uF1XloWq/YYdBZUlwjRozTiCjf/IkRFOTPVD2OIYEWHkTKtTOlOf+eh9EI5LXiqihFsH9FZzo4mYIsmrJhhPiHsckUey+tu2fUps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027022; c=relaxed/simple;
	bh=3KeM7lfLDa4d6XxZlkuetJlr+Z0HQInto9qLhe1/Z+g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=srdYWcbCBg6aew6vYU80bZhwvwNUXK5Yft6sRE+Y5BBJbew3BW5i1F14o4GUk8Fw3VAhOAPTtDgABRiUROzsOJQ+DPrDT5jw3afOSG3vBaDAS6wsaAm7sdfVoQ6Lk2gaf4XKyEEoPsKKuxzHW47FDUbz9wP9RI8qQpsHk6yCTlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R4d/5917; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LVlXZCl3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Feb 2024 19:56:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708027019;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfuRlzFEb1d+9o0YAIYrks98Nq9LA7+QAmJ9V+D96To=;
	b=R4d/5917GbkM+GOB8ytnqCpp7nqUDrwVFx5MaqW3/+HLfKwkhs2HP3Tix4TWGc1KESrNJv
	NZ9pFhYmWgjZwY9zBbdoiWU0cx9d1uBDf7FPO1oEDjIWY4qYioyQOrVEtSNnQYG0hladxl
	DOuwyT2fiEKmkHzxj3GuWMksiIWI8oJLzcnInOgyVnQLTtb7Q2TO8b7WB3Vfe0kGPfCd31
	MGGATtCVoOWdjZ7317oaOk2lP/QSKKsNUrGyBEJOki0k5i9yj+thSfxsFNftLtLwncpQDH
	ePiWJcHYUXPZBhxC3CpQUZOSMFwjzKOL7//OCnlUtwBb6siO3R35P7eqoqiwPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708027019;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfuRlzFEb1d+9o0YAIYrks98Nq9LA7+QAmJ9V+D96To=;
	b=LVlXZCl3LDh8QYYb+SICl7Fq0LP67xWHI3Fd4XmCVtcYSxILz6eHPZvnmDJrLsUvhGBgOO
	aWGoh9DA8yZKlMCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/msi] genirq/msi: Optionally use dev->fwnode for device domain
Cc: Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240127161753.114685-11-apatel@ventanamicro.com>
References: <20240127161753.114685-11-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170802701865.398.5350588074359422240.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     9d1c58c8004653b37721dd7b16f4360216778c94
Gitweb:        https://git.kernel.org/tip/9d1c58c8004653b37721dd7b16f4360216778c94
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 27 Jan 2024 21:47:38 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 17:55:41 +01:00

genirq/msi: Optionally use dev->fwnode for device domain

To support wire to MSI domains via the MSI infrastructure it is required to
use the firmware node of the device which implements this for creating the
MSI domain. Otherwise the existing firmware match mechanisms to find the
correct irqdomain for a wired interrupt which is connected to a wire to MSI
bridge would fail.

This cannot be used for the general case because not all devices provide
firmware nodes and all regular per device MSI domains are directly
associated to the device and have not be searched for.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240127161753.114685-11-apatel@ventanamicro.com

---
 include/linux/msi.h |  2 ++
 kernel/irq/msi.c    | 20 ++++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 24a5424..36ba6a0 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -552,6 +552,8 @@ enum {
 	MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS	= (1 << 5),
 	/* Free MSI descriptors */
 	MSI_FLAG_FREE_MSI_DESCS		= (1 << 6),
+	/* Use dev->fwnode for MSI device domain creation */
+	MSI_FLAG_USE_DEV_FWNODE		= (1 << 7),
 
 	/* Mask for the generic functionality */
 	MSI_GENERIC_FLAGS_MASK		= GENMASK(15, 0),
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 8d46390..5289fc2 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -960,9 +960,9 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
 				  void *chip_data)
 {
 	struct irq_domain *domain, *parent = dev->msi.domain;
-	const struct msi_parent_ops *pops;
+	struct fwnode_handle *fwnode, *fwnalloced = NULL;
 	struct msi_domain_template *bundle;
-	struct fwnode_handle *fwnode;
+	const struct msi_parent_ops *pops;
 
 	if (!irq_domain_is_msi_parent(parent))
 		return false;
@@ -985,7 +985,19 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
 		 pops->prefix ? : "", bundle->chip.name, dev_name(dev));
 	bundle->chip.name = bundle->name;
 
-	fwnode = irq_domain_alloc_named_fwnode(bundle->name);
+	/*
+	 * Using the device firmware node is required for wire to MSI
+	 * device domains so that the existing firmware results in a domain
+	 * match.
+	 * All other device domains like PCI/MSI use the named firmware
+	 * node as they are not guaranteed to have a fwnode. They are never
+	 * looked up and always handled in the context of the device.
+	 */
+	if (bundle->info.flags & MSI_FLAG_USE_DEV_FWNODE)
+		fwnode = dev->fwnode;
+	else
+		fwnode = fwnalloced = irq_domain_alloc_named_fwnode(bundle->name);
+
 	if (!fwnode)
 		goto free_bundle;
 
@@ -1012,7 +1024,7 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
 fail:
 	msi_unlock_descs(dev);
 free_fwnode:
-	irq_domain_free_fwnode(fwnode);
+	irq_domain_free_fwnode(fwnalloced);
 free_bundle:
 	kfree(bundle);
 	return false;

