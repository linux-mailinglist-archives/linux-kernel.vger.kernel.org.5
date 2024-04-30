Return-Path: <linux-kernel+bounces-164001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF408B7702
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32D11F22742
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC16172763;
	Tue, 30 Apr 2024 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3G365SOC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BaxmTeLQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2696917167B;
	Tue, 30 Apr 2024 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483725; cv=none; b=KSKJ76SmeQ/KyND9fzA94MaCJq8cwgXLlvHK7rAvD4Ljbpg9kJ76TzzjCeQBsQr0qcmTk52KxsKYbsS5+8dEMLBkGIsxvt2Cq31Lp/ea4mcQzr8PwRUGSIlWv42yBsxnbQqqAi3Fnbe5gC1ZdY/js3UBN2xUnYInefaS4caNbcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483725; c=relaxed/simple;
	bh=tLFWX7t/A/fiQh3OFL+nFAsakFf8aQgUCSh6ABUaEiU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OaQjR/p6MAlSv73S/XknCWlNEeMbFBa5eWXwRdL/9ZajCtZnkeB2CXEl4iaLc5vrp11KR4BRKeU3mTvb9zRbi+zZYQI48suSqj3kpDVRK8+T8PMP7VI8AnNRBnUGKSv2ZTgE9P5PjEmFua0B6flAwMeAWo3qoaVrd9hDLIldT6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3G365SOC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BaxmTeLQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Apr 2024 13:28:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714483721;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7zU5eaJp0wwbY0xMMfq6TY3Sx9Qd3GTQb8XToag6itQ=;
	b=3G365SOC4zpTHW9DKRypTwTbM8d8z2VhEh9TJuPc1FjfWkbGs+fl8XNDDwVF24yLhZFZYk
	YUZw8JHJMouwfpkHuTehEMophxgBp2vGu3HoAMjpdgBwNyiXib+4iLN7Pnzjbuic8/6kSU
	d9y3riZc1PA6cMEXQjvQ2jQ8igF8nkbWiYao3GB/f+rpDHcs+j5mFaLlPHpDJ9UKxfKQxM
	E9u9OlT228j4cq6Qk8lMtaOx6eDbJh6a9B8FP77EwFRhBMg3DEDlfwiopj3m7OHRDphSVJ
	BE24Qq056erDPX9yMql1REGJ9jwhnYJi60Z2yrWTZiWRCUPnmHpWajDBYruq7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714483721;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7zU5eaJp0wwbY0xMMfq6TY3Sx9Qd3GTQb8XToag6itQ=;
	b=BaxmTeLQlzY/lHMnLj6H4KTWw9Es+KkAaqje7UYQdLVabUcqXLTJKhbeDajul2PXUms8js
	3adVERDoeIKFMIBg==
From: "tip-bot2 for Jacob Pan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/irq] iommu/vt-d: Make posted MSI an opt-in command line option
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240423174114.526704-12-jacob.jun.pan@linux.intel.com>
References: <20240423174114.526704-12-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171448372107.10875.12692815650049599253.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     be9be07b22c96dc03d0ecc76b5a5f21c2dcb05a1
Gitweb:        https://git.kernel.org/tip/be9be07b22c96dc03d0ecc76b5a5f21c2dcb05a1
Author:        Jacob Pan <jacob.jun.pan@linux.intel.com>
AuthorDate:    Tue, 23 Apr 2024 10:41:13 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Apr 2024 00:54:43 +02:00

iommu/vt-d: Make posted MSI an opt-in command line option

Add a command line opt-in option for posted MSI if CONFIG_X86_POSTED_MSI=y.

Also introduce a helper function for testing if posted MSI is supported on
the platform.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240423174114.526704-12-jacob.jun.pan@linux.intel.com


---
 Documentation/admin-guide/kernel-parameters.txt | 2 ++
 arch/x86/include/asm/irq_remapping.h            | 7 +++++++
 drivers/iommu/irq_remapping.c                   | 5 ++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 902ecd9..dfbe9fd 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2251,6 +2251,8 @@
 			no_x2apic_optout
 				BIOS x2APIC opt-out request will be ignored
 			nopost	disable Interrupt Posting
+			posted_msi
+				enable MSIs delivered as posted interrupts
 
 	iomem=		Disable strict checking of access to MMIO memory
 		strict	regions from userspace.
diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 7a2ed15..5036f13 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -50,6 +50,13 @@ static inline struct irq_domain *arch_get_ir_parent_domain(void)
 	return x86_vector_domain;
 }
 
+extern bool enable_posted_msi;
+
+static inline bool posted_msi_supported(void)
+{
+	return enable_posted_msi && irq_remapping_cap(IRQ_POSTING_CAP);
+}
+
 #else  /* CONFIG_IRQ_REMAP */
 
 static inline bool irq_remapping_cap(enum irq_remap_cap cap) { return 0; }
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index ee59647..056fec6 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -24,6 +24,8 @@ int no_x2apic_optout;
 
 int disable_irq_post = 0;
 
+bool enable_posted_msi __ro_after_init;
+
 static int disable_irq_remap;
 static struct irq_remap_ops *remap_ops;
 
@@ -70,7 +72,8 @@ static __init int setup_irqremap(char *str)
 			no_x2apic_optout = 1;
 		else if (!strncmp(str, "nopost", 6))
 			disable_irq_post = 1;
-
+		else if (IS_ENABLED(CONFIG_X86_POSTED_MSI) && !strncmp(str, "posted_msi", 10))
+			enable_posted_msi = true;
 		str += strcspn(str, ",");
 		while (*str == ',')
 			str++;

