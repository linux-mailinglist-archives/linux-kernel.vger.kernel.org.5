Return-Path: <linux-kernel+bounces-157649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CE18B1406
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1B21C22FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAA5144D3E;
	Wed, 24 Apr 2024 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UZDFQr/J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D3Ajg9DV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8A913D25E;
	Wed, 24 Apr 2024 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989056; cv=none; b=mx5lpe9byrcxEf/Z9TlUtZOapMiOVw96tvcTEIFv/HLE2zlhJta9Oyq838wOdAc27Eqwa207fLHA+oX7yNxE4u5ukuoaSBrfmtCQGkGmERt8V8eQghPipK4jpk/xl7W3MEq+FaUvOeyazFqjcT5bW/r7q+ATmS4nL1R7jCWLBNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989056; c=relaxed/simple;
	bh=hb6SpCxARZzBI/N7bpgQo/g8MGCD13PYeig3zaU+810=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bascKo7cuJIYGAPB6J5G39VqD5aq7OaA4CoH277wdsPLcSsTCxDVSuaLGMIUYs8oktNTrOwXbs8L9ay32+g30I+524r5P+bTtaZNhC0oBNowaBjWLc2hvTlyLGSOxwx67Gy5fbcHQm2G0WbnlHmKmUq84D+WZjJD/8zJp2YoVXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UZDFQr/J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D3Ajg9DV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Apr 2024 20:04:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713989047;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVwWSLhbRoOnuuWBkaJtekqTzP7WA7b954lGwNcHPtg=;
	b=UZDFQr/JaWLDvXKpHg6rRKWPrQ7W2DlLdAuqjULJKaDJPwihRzqCUis1yOM6DbZiSzY90e
	l/io4jQ5Yah65fVbKCNbrXdnuanDNWucinDe26uxZzwCDoGtFc9VTFPk3AJGBDBaAwcaZD
	28vj/TVXNhUm1ZVnj47Flg1OreEol+PKEhBo+lXf5tjbI2TkEX/j2wEbhcTFi6QCJJtUcd
	/37r/jj4FjRxdlGv9uG+J4GpOFXOogBKHx2cDUU1F7TMpMmEwD++apr+DRivyQFdFvRJFP
	l3HoKyx0X3KV/gCDq5/9iaW2jwTZDkt4dUW+AFEX0k2YcArZEPByDLAPKW5LvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713989047;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVwWSLhbRoOnuuWBkaJtekqTzP7WA7b954lGwNcHPtg=;
	b=D3Ajg9DVT7hh0eHq6YVLMseJKnekBDtQ7T0ssZt/X5Nvyug7i8ZIWGnHI2a1ruDqJLhFKn
	BFzmwJkGCZXe89Bw==
From: "tip-bot2 for Dawei Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] cpumask: Introduce cpumask_first_and_and()
Cc: Dawei Li <dawei.li@shingroup.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Yury Norov <yury.norov@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240416085454.3547175-2-dawei.li@shingroup.cn>
References: <20240416085454.3547175-2-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171398904742.10875.2505859737865866065.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     cdc66553c4130735f0a2db943a5259e54ff1597a
Gitweb:        https://git.kernel.org/tip/cdc66553c4130735f0a2db943a5259e54ff1597a
Author:        Dawei Li <dawei.li@shingroup.cn>
AuthorDate:    Tue, 16 Apr 2024 16:54:48 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 24 Apr 2024 21:23:49 +02:00

cpumask: Introduce cpumask_first_and_and()

Introduce cpumask_first_and_and() to get intersection between 3 cpumasks,
free of any intermediate cpumask variable. Instead, cpumask_first_and_and()
works in-place with all inputs and produces desired output directly.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Yury Norov <yury.norov@gmail.com>
Link: https://lore.kernel.org/r/20240416085454.3547175-2-dawei.li@shingroup.cn

---
 include/linux/cpumask.h | 17 +++++++++++++++++
 include/linux/find.h    | 27 +++++++++++++++++++++++++++
 lib/find_bit.c          | 12 ++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 1c29947..c46f9e9 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -188,6 +188,23 @@ unsigned int cpumask_first_and(const struct cpumask *srcp1, const struct cpumask
 }
 
 /**
+ * cpumask_first_and_and - return the first cpu from *srcp1 & *srcp2 & *srcp3
+ * @srcp1: the first input
+ * @srcp2: the second input
+ * @srcp3: the third input
+ *
+ * Return: >= nr_cpu_ids if no cpus set in all.
+ */
+static inline
+unsigned int cpumask_first_and_and(const struct cpumask *srcp1,
+				   const struct cpumask *srcp2,
+				   const struct cpumask *srcp3)
+{
+	return find_first_and_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2),
+				      cpumask_bits(srcp3), small_cpumask_bits);
+}
+
+/**
  * cpumask_last - get the last CPU in a cpumask
  * @srcp:	- the cpumask pointer
  *
diff --git a/include/linux/find.h b/include/linux/find.h
index c69598e..28ec5a0 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -29,6 +29,8 @@ unsigned long __find_nth_and_andnot_bit(const unsigned long *addr1, const unsign
 					unsigned long n);
 extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 					 const unsigned long *addr2, unsigned long size);
+unsigned long _find_first_and_and_bit(const unsigned long *addr1, const unsigned long *addr2,
+				      const unsigned long *addr3, unsigned long size);
 extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
 extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long size);
 
@@ -345,6 +347,31 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
 }
 #endif
 
+/**
+ * find_first_and_and_bit - find the first set bit in 3 memory regions
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @addr3: The third address to base the search on
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the first set bit
+ * If no bits are set, returns @size.
+ */
+static inline
+unsigned long find_first_and_and_bit(const unsigned long *addr1,
+				     const unsigned long *addr2,
+				     const unsigned long *addr3,
+				     unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = *addr1 & *addr2 & *addr3 & GENMASK(size - 1, 0);
+
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_first_and_and_bit(addr1, addr2, addr3, size);
+}
+
 #ifndef find_first_zero_bit
 /**
  * find_first_zero_bit - find the first cleared bit in a memory region
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 32f99e9..dacadd9 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -116,6 +116,18 @@ unsigned long _find_first_and_bit(const unsigned long *addr1,
 EXPORT_SYMBOL(_find_first_and_bit);
 #endif
 
+/*
+ * Find the first set bit in three memory regions.
+ */
+unsigned long _find_first_and_and_bit(const unsigned long *addr1,
+				      const unsigned long *addr2,
+				      const unsigned long *addr3,
+				      unsigned long size)
+{
+	return FIND_FIRST_BIT(addr1[idx] & addr2[idx] & addr3[idx], /* nop */, size);
+}
+EXPORT_SYMBOL(_find_first_and_and_bit);
+
 #ifndef find_first_zero_bit
 /*
  * Find the first cleared bit in a memory region.

