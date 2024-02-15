Return-Path: <linux-kernel+bounces-67625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A33856E26
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD0F285EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F5A13DBBD;
	Thu, 15 Feb 2024 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="snFJqbv4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cI7BUHGV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3861A13AA50;
	Thu, 15 Feb 2024 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027024; cv=none; b=A/F40R4nLE1kA+9kpGpQwfgP0lAyULOKPZRc7iK/0OY9R8UU67T14pnaqtuiLR161uSTys08vzLTO5+mXElSlsQxzcslzPyuPowry93CxrUQVJtYmK9Q09nkc27OQW/uIU1Lc4BnJxkVjR2Vy47uaeRpr4Wy8hZTAbtSx1ttg4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027024; c=relaxed/simple;
	bh=FPqnHmJFsKLimOsWnA+dHbHzCniAsnCLgjpuMnn5MPw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Aulb0kXOtPeyAAHuYfMMvsCmk0RlEzqJ/vi3aUZb/kk1oX4Mh1NqXWnsNSn7ZZYryxiSjeI86ND598t7EcgNHiGyEM5OZ1anZbeWq1+/8fn2A6nefi1ueVyfp0q5ee6vLZUO57AHFnHcf1kZf7pluSIglPRZKCuLf+qgFRhEZpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=snFJqbv4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cI7BUHGV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Feb 2024 19:57:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708027021;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=AI3hsuLUVavlaaszlq83CucsGXkpH9S2krMw0wOgMp8=;
	b=snFJqbv4UPGMqo/ARpoq8Va+tN6KXUWoM68++xc3QFUJ4pNsH2soucOTHd2W6782VyOLt1
	grVTItT9SuUCb+KB1xw0uuJaz8Ys/Z9XKuYpqbj4FYiCZDjFKrLh/v6N8RavpS1mH5mwN/
	EY3s6xPBSQB4UIPhpU5TSB2ZecEonONlv7qrYeCtmuh8SkCmXizLfucmRLnDQ5wllrIQ3n
	AiPI1EDfO1YmLkAqlocMsd7kyFO6c64VqgX8FPilotBAbCfkqe/iw0hzNcERJcc9TnW+5d
	xkFFsRBeTNs1k3Mp0iBXW/b7m6Oux3HtI+j73MnlKg60SfjOxuwqBNzu50jnEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708027021;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=AI3hsuLUVavlaaszlq83CucsGXkpH9S2krMw0wOgMp8=;
	b=cI7BUHGV1T2bMWzXl5PoG2WualLeL2uwtq14NZTaWc++PAuHFDfa39lwWhzigR9Vrx+9o4
	9tWYt24fnnfVayAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] platform-msi: Remove unused interfaces
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170802702109.398.16219125857644382762.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     1a4671ff7a903e87e4e76213e200bb8bcfa942e4
Gitweb:        https://git.kernel.org/tip/1a4671ff7a903e87e4e76213e200bb8bcfa942e4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Feb 2024 16:35:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 17:55:40 +01:00

platform-msi: Remove unused interfaces

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/base/platform-msi.c | 16 ++--------------
 include/linux/msi.h         |  3 ---
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index b56e919..0d01890 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -206,8 +206,8 @@ static void platform_msi_free_priv_data(struct device *dev)
  * Returns:
  * Zero for success, or an error code in case of failure
  */
-int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
-				   irq_write_msi_msg_t write_msi_msg)
+static int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
+					  irq_write_msi_msg_t write_msi_msg)
 {
 	int err;
 
@@ -221,18 +221,6 @@ int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(platform_msi_domain_alloc_irqs);
-
-/**
- * platform_msi_domain_free_irqs - Free MSI interrupts for @dev
- * @dev:	The device for which to free interrupts
- */
-void platform_msi_domain_free_irqs(struct device *dev)
-{
-	msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
-	platform_msi_free_priv_data(dev);
-}
-EXPORT_SYMBOL_GPL(platform_msi_domain_free_irqs);
 
 /**
  * platform_msi_get_host_data - Query the private data associated with
diff --git a/include/linux/msi.h b/include/linux/msi.h
index ef16796..b0842ea 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -635,9 +635,6 @@ struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
 struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwnode,
 						  struct msi_domain_info *info,
 						  struct irq_domain *parent);
-int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
-				   irq_write_msi_msg_t write_msi_msg);
-void platform_msi_domain_free_irqs(struct device *dev);
 
 /* When an MSI domain is used as an intermediate domain */
 int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,

