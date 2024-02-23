Return-Path: <linux-kernel+bounces-78095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78314860ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1C55B26D77
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7BC5CDE6;
	Fri, 23 Feb 2024 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="btYXqOsa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rXwzKxYR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F0114F8C;
	Fri, 23 Feb 2024 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708682435; cv=none; b=QWelwCLZP/RTaEb1zOw9BShkndK/2dOYrRwboK9T7vMYS7j803shUUG9DSbiQcxmcwRofxyo1TqUObie0GflcuXbA9m/kgyA5ME6nnBn6mclTgbFciloYhqR9LQ8nB2ie/9r3WNPvkNg7p1pp8iK+jOyOCiLLyXH9QcexodHFXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708682435; c=relaxed/simple;
	bh=PJVOkzXe0DimbsYAygivY2Gs99xqZqgLAqdREWMauhQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=H6a2f7vqw+39LZIlkx5slCqZPoExvWkWKnx6WJT6EelijinQcaeAs4djr4P20fOLofKr16hA4ogC9gQRbLV9mGJLn/aMu3gVeMaw3knuDvWRXLEJ7WoLlyUyChP9pc4GXJQ6/sKBA4ONM059jeySbjtVuZAqYBvXblRcJ42DED0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=btYXqOsa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rXwzKxYR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Feb 2024 10:00:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708682431;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QyryfZhhIz7LZUc7IMOTdMCHJp7Zhg9ojNf445AiaE=;
	b=btYXqOsay/ay9EXqBIwycP1VnAviuWaSKFe6XkZAuI+DP1pffOqkNeBDsql2KeQEnu3Ll0
	A5RQihd/gZsMSzTD1JTY1RYNqtqy2+0l402Up0u5xOzfgw+Zcg1kcRyQtWSPnUe9OH4hD4
	rBI6N9Pdqb2nOT6O+VPPda6JJZ+BmHcSHn54OPKtJ74ZarvJEgUjNFFMhjghevSLXfXf/B
	5hsiAb5TEE08B2v+c4jF0qcGrk5J2zD+C8IUcJLO0IyK+TFElMx3fbsk03XoYRZotglkts
	Mb60czIIVsrZ9uunca79SzL57F4ChUEeoDNpcdjiNivictDdJIo7ZLJfF4YJtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708682431;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QyryfZhhIz7LZUc7IMOTdMCHJp7Zhg9ojNf445AiaE=;
	b=rXwzKxYRYVfV56FcgNzNV0q9qz3PMicc3e8B+KLrQpHAZPKV/kayzxqLVJEE4ae73ya3eE
	ELwmPiIpffhQdNBw==
From: "tip-bot2 for Nipun Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Export MSI allocation/free functions and
 provide a conveniance wrapper
Cc: Nipun Gupta <nipun.gupta@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240223092447.65564-2-nipun.gupta@amd.com>
References: <20240223092447.65564-2-nipun.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170868243063.398.11626336213907609283.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     ae4debc7fd82e4612a7f4460394b4fb8e95f6ed2
Gitweb:        https://git.kernel.org/tip/ae4debc7fd82e4612a7f4460394b4fb8e95f6ed2
Author:        Nipun Gupta <nipun.gupta@amd.com>
AuthorDate:    Fri, 23 Feb 2024 14:54:47 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 23 Feb 2024 10:53:03 +01:00

genirq/msi: Export MSI allocation/free functions and provide a conveniance wrapper

MSI functions can be for allocation and free can be directly used by the
device drivers without any wrapper provided by bus drivers. So export these
MSI functions.

Also, add a wrapper API to allocate MSIs providing only the number of
interrupts rather than a range for simpler driver usage.

Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240223092447.65564-2-nipun.gupta@amd.com
---
 include/linux/msi.h | 6 ++++++
 kernel/irq/msi.c    | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 26d07e2..765a655 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -676,6 +676,12 @@ int platform_device_msi_init_and_alloc_irqs(struct device *dev, unsigned int nve
 void platform_device_msi_free_irqs_all(struct device *dev);
 
 bool msi_device_has_isolated_msi(struct device *dev);
+
+static inline int msi_domain_alloc_irqs(struct device *dev, unsigned int domid, int nirqs)
+{
+	return msi_domain_alloc_irqs_range(dev, domid, 0, nirqs - 1);
+}
+
 #else /* CONFIG_GENERIC_MSI_IRQ */
 static inline bool msi_device_has_isolated_msi(struct device *dev)
 {
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index f90952e..2024f89 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1434,6 +1434,7 @@ int msi_domain_alloc_irqs_range(struct device *dev, unsigned int domid,
 	msi_unlock_descs(dev);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(msi_domain_alloc_irqs_range);
 
 /**
  * msi_domain_alloc_irqs_all_locked - Allocate all interrupts from a MSI interrupt domain
@@ -1680,6 +1681,7 @@ void msi_domain_free_irqs_range(struct device *dev, unsigned int domid,
 	msi_domain_free_irqs_range_locked(dev, domid, first, last);
 	msi_unlock_descs(dev);
 }
+EXPORT_SYMBOL_GPL(msi_domain_free_irqs_all);
 
 /**
  * msi_domain_free_irqs_all_locked - Free all interrupts from a MSI interrupt domain

