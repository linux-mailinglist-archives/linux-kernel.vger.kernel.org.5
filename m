Return-Path: <linux-kernel+bounces-67618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC62856E1A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16239B211A5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA5613A89D;
	Thu, 15 Feb 2024 19:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Oi28e5F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ND6QAQo6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4513213A892;
	Thu, 15 Feb 2024 19:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027020; cv=none; b=ZfaXDKbNslo2sJX/RT9dHjQ3kAqKmg4KMcPcqOdkTVRijsN9/v8j4bg02vWIr27n7ZUH3yJvVekRKY31YckAHUbyKeyMTF+T6mIqT8tvTO1vHFbQCSwxnoOyJmmzEhwcZZqBB3TDKyOUMjARN64ePcFfYAD8JBT3wbSz1Rp4gkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027020; c=relaxed/simple;
	bh=wKptZ5+eJl5ci++NzOa9RSvAO6eRqLXG+XKGBuxEkrk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KzIPNAczIdS7yEACb8zJOw7Ub8SBBWt4HshlD/2SDVRoqNG0n1WiYpZ1d2BAzSdVKKYFBrOviLiCcaJziOm02VBb5qP871lNf15fYfMYYGLOZqRjEI+gcTLgevOI16T2atn3STAr4y7pkF/Kv8rbcVr3NNAGCGx6EHgD1vaaT1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4Oi28e5F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ND6QAQo6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Feb 2024 19:56:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708027017;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gp8pRjTfv1QNSZrrpl5DYHm5iswbLLmWrXHSIq3iwHU=;
	b=4Oi28e5FLkAQ0DmzENQvaXxtLWKqvpZLEeN7mBd4A00w1lVNCofdNrG/Ac4Eev1crsaDib
	Xgu/LSIQ7HEoDuY6XzSdtbHqE6cKBnsRPnMAxVpWhLaUFMXxRqf/3P60Zyj/wcHkdIN+X9
	3RyeYwiUoEnGmX1tMy536pTsYZvUtQ1/J3TNg6pOey6/8smDtagUUXXH0hQ84amC43lGbg
	st4R/HyygTWtVetgZPzDycy6HzeKrsmroJeB2FBPP3zyNj4Ptry3OLilQDP55uBMwg+COD
	ZgIjjRQVtsD6pj6ymH2WhPq1pD/3+yzl/Yly+yEABMq8oM1McQ1RrgChbocStA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708027017;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gp8pRjTfv1QNSZrrpl5DYHm5iswbLLmWrXHSIq3iwHU=;
	b=ND6QAQo645tw4wiL8wFvLGq6ti3GCvCAvJixR+G2glfA+4HuxioDCoE7Zv7Hn9uJPFGXJx
	g8GKH/sol8YwClBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Provide MSI_FLAG_PARENT_PM_DEV
Cc: Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240127161753.114685-14-apatel@ventanamicro.com>
References: <20240127161753.114685-14-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170802701641.398.9865476811780802677.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     9bbe13a5d414a7f8208dba64b54d2b6e4f7086bd
Gitweb:        https://git.kernel.org/tip/9bbe13a5d414a7f8208dba64b54d2b6e4f7086bd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 27 Jan 2024 21:47:41 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 17:55:41 +01:00

genirq/msi: Provide MSI_FLAG_PARENT_PM_DEV

Some platform-MSI implementations require that power management is
redirected to the underlying interrupt chip device. To make this work
with per device MSI domains provide a new feature flag and let the
core code handle the setup of dev->pm_dev when set during device MSI
domain creation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240127161753.114685-14-apatel@ventanamicro.com

---
 include/linux/msi.h | 2 ++
 kernel/irq/msi.c    | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 36ba6a0..26d07e2 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -554,6 +554,8 @@ enum {
 	MSI_FLAG_FREE_MSI_DESCS		= (1 << 6),
 	/* Use dev->fwnode for MSI device domain creation */
 	MSI_FLAG_USE_DEV_FWNODE		= (1 << 7),
+	/* Set parent->dev into domain->pm_dev on device domain creation */
+	MSI_FLAG_PARENT_PM_DEV		= (1 << 8),
 
 	/* Mask for the generic functionality */
 	MSI_GENERIC_FLAGS_MASK		= GENMASK(15, 0),
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 07e9daa..f90952e 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -845,8 +845,11 @@ static struct irq_domain *__msi_create_irq_domain(struct fwnode_handle *fwnode,
 	domain = irq_domain_create_hierarchy(parent, flags | IRQ_DOMAIN_FLAG_MSI, 0,
 					     fwnode, &msi_domain_ops, info);
 
-	if (domain)
+	if (domain) {
 		irq_domain_update_bus_token(domain, info->bus_token);
+		if (info->flags & MSI_FLAG_PARENT_PM_DEV)
+			domain->pm_dev = parent->pm_dev;
+	}
 
 	return domain;
 }

