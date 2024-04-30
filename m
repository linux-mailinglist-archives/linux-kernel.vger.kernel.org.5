Return-Path: <linux-kernel+bounces-164004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B032B8B770C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661E71F228CA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671EE173333;
	Tue, 30 Apr 2024 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O6ay+xhz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BldPjh3F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46866172761;
	Tue, 30 Apr 2024 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483727; cv=none; b=d/W7Ir5eqMtfMdtWOv7+gFeo4a2a8otYPCB+V1JcZG+jj6heoXV/EDkrIoCr9idlif/+jRhiv8rW+/Bd8w4JF9qplvuN00ZtQnH+dN8Y0zAnPKzjpr6TLq+KlTPWUMuVEgXsKdG4itCBAMbSBkTvCrHzkPR/D/6WuszthhFp3ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483727; c=relaxed/simple;
	bh=kYjbKEEMkVwrFRhNGQ33voLjXhGXZblGrpkBGIelQXM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tkmILZV23c4SyaES2hS9ea1m8KdL5pz0yS8ywzxq4Kyz90gbwx2Ad+rBgfMFKeR3xPzQ0KFKsCCj8Me8cVK6E6fNw2uOpl2pKgC31Zb9INDKHgIz4FdEl2/lSLMNd6X7ZtIcBjDyg0ZdTIc8HdCJNhv5Miy7TwmCWV7phnJjjSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O6ay+xhz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BldPjh3F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Apr 2024 13:28:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714483722;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iwIQowP5NbIfhFJt4H8i3QS+QD1/Vwj+A6CcW0Y7kDU=;
	b=O6ay+xhzYnTEzevFe+3PTHbpTz8WN+G2xn0foLbsdByWydRNrEWFa+Mj4CXNckS1Hj1lon
	cs6gI+7x455n17wyGbLi16YLas33stTjtWoVWjNL6YyTRiWpubIPVH8h+aExAeXx/8BtSK
	jsV9DHNGLkoo4R48gvJNAXKmdQNd1CY6mMA13tqq5gEBU88Y3G32XVwYfD5qnR6dsWH67x
	jY9BRcm7hyooIEbaTv8dZG0QKmqP7wS7WlOoRvXsWhHKM3RwpyR6I3VHc06gLn5Dew57Wb
	sXyHeRpYLjGpx48M2i2UKb2UJKjuRqxKv5Nbh1l4nVgWWsAhWFe+k3o/STQVMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714483722;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iwIQowP5NbIfhFJt4H8i3QS+QD1/Vwj+A6CcW0Y7kDU=;
	b=BldPjh3FRW0NExtU17zTa4rYnXNCMjv670oK35iRqdnihwaazwUpiwKIdJz1tdpXVMJIj2
	5Ggez7U8ShDjOKAw==
From: "tip-bot2 for Jacob Pan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/irq: Reserve a per CPU IDT vector for posted MSIs
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240423174114.526704-6-jacob.jun.pan@linux.intel.com>
References: <20240423174114.526704-6-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171448372214.10875.5881265210964630345.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     f5a3562ec9dd29e61735ccf098d8ba05cf6c7c72
Gitweb:        https://git.kernel.org/tip/f5a3562ec9dd29e61735ccf098d8ba05cf6c7c72
Author:        Jacob Pan <jacob.jun.pan@linux.intel.com>
AuthorDate:    Tue, 23 Apr 2024 10:41:07 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Apr 2024 00:54:42 +02:00

x86/irq: Reserve a per CPU IDT vector for posted MSIs

When posted MSI is enabled, all device MSIs are multiplexed into a single
notification vector. MSI handlers will be de-multiplexed at run-time by
system software without IDT delivery.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240423174114.526704-6-jacob.jun.pan@linux.intel.com


---
 arch/x86/include/asm/irq_vectors.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index d18bfb2..13aea8f 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -97,10 +97,16 @@
 
 #define LOCAL_TIMER_VECTOR		0xec
 
+/*
+ * Posted interrupt notification vector for all device MSIs delivered to
+ * the host kernel.
+ */
+#define POSTED_MSI_NOTIFICATION_VECTOR	0xeb
+
 #define NR_VECTORS			 256
 
 #ifdef CONFIG_X86_LOCAL_APIC
-#define FIRST_SYSTEM_VECTOR		LOCAL_TIMER_VECTOR
+#define FIRST_SYSTEM_VECTOR		POSTED_MSI_NOTIFICATION_VECTOR
 #else
 #define FIRST_SYSTEM_VECTOR		NR_VECTORS
 #endif

