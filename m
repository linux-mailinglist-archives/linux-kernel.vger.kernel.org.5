Return-Path: <linux-kernel+bounces-136278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B60B589D22D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2DC282D83
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67ED7E777;
	Tue,  9 Apr 2024 06:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sUv0lF5p"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265307E564
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 06:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643137; cv=none; b=hI7e3hVA24Tji/shJei5Xv3wGreyAjk23tSwQr32vCAo7AK1ujfOzfK0VV+9/zANJHokyzdNR37FDIU8j/t+Y6kioxnOpOqRKp+gRA1/eS8qvWDvC6W9UrGjnhhr9XF+8E24IwcvOUtv2GiismVkwQNrwIW8uFfdzkiYNKBx/SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643137; c=relaxed/simple;
	bh=Hs9lg5qGOOwmGFesJpJkUKBoTukCuS9EqZHQvOWY1XM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nZO5CyyJLPUWYDGpN/R2l9nztMqDyZ22P0+kYU+kYH0V258/BI+DJ7kV7Q74RsemJEjnhT3iqxYxZLV7+76GPwiiwerI/sJ7kmNqQu9h35WPOfuCvJzsfLcrj2zK35NhHY3jmlo/meE0otifF/hiLAh+D/rYYnuzxIihv2gP3ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sUv0lF5p; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso4107934a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 23:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712643135; x=1713247935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjvFClKwy+BYaRIrausKimMcjFw1vT5hOqvdsQGe/rs=;
        b=sUv0lF5pxl3rp03mwDpN5aOqMrD1fuiMDjjtQX802u8X21kKQbA1Vso+8r4C5jtr5l
         yTAVwr70sLcHCE6xw4f/EaLMtJQj3/8vWSJAiHYOZdqjs+n05ik8MbEC/S/DE/0KJQ4K
         F+p0nM2ijjJ+wqPEiQ/6zOEriE3j4PwUI4cgBLZMnn92Uo4yadrly4VTk/T0f1JLwWpC
         OgLibOI9fkLc9cM++igyFgiAk04d68addn4qWMicohxe3RfJTdYVLnPC36nY/dPDz4S1
         TlRteLKGxohg4Ex07DYCQZGDYCfAreIEqWGvG1ktetg+N0f2jss3+ZCahKWwPTXE0c2t
         0uKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712643135; x=1713247935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjvFClKwy+BYaRIrausKimMcjFw1vT5hOqvdsQGe/rs=;
        b=i3Vw7gAEngUYdyftRJCCEMPQ6dCvfnX2wUW7Xhyk1X481gy8ZfofwBzn5wd03hyqOR
         DsBahAtpiAC9sVHZNV78xggrUeu2LpqfpI6+5PTXlQOZtFY5BrsDaupIqB5Nb5WX7fdA
         as6B8lrVhK/23PRwsLr2vIFnRA9dwrU5pDCC8dm54GBNjZAk6bNw/3+zmHTK1kGn5wfc
         2l13Cdi0uPR6+rILg9HM+TA4w/m7CyWQ7ZoaI4OeSlHqkpFj5uTvY8IzYGpbTFNN7A9C
         8dbUx6R/4/O6+ptWVTx/a7kGCjyfSQyIHvBXjFJXM74XtexuJfnQ9TbLc1yIJ1H00mwv
         x/IA==
X-Forwarded-Encrypted: i=1; AJvYcCW0yG1xh5oIRgyZcpsIMQRH3YI76m/49Po2Dzcqg0yX26J1xl26m4nDJy5njPUtuAHLyROBKda8h+YO9v0bVDwldbljuSTZfM4S5r9M
X-Gm-Message-State: AOJu0Yyb3B4EtCZDjNmGtAW+XJm2QZ5Jp+i/q0kKC8mR23osss6h2gTu
	v3AMUOw0MVUQSIJ5yZ+JQsY6n5ZsoYOnhz/8PD9Ck//NYfPuZO0q/qNDa9q0AXs=
X-Google-Smtp-Source: AGHT+IEp8MmTA8LKx3GHOoxHTg1gStAegDNh1X4uTEZe5dJSLPSECO/RehYfY7RXVVoYxf41UDsgzg==
X-Received: by 2002:a17:902:ecd0:b0:1e3:dfdc:6972 with SMTP id a16-20020a170902ecd000b001e3dfdc6972mr9975664plh.9.1712643135531;
        Mon, 08 Apr 2024 23:12:15 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001e3dd5972ccsm5775564plf.185.2024.04.08.23.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 23:12:15 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	andy.chiu@sifive.com,
	debug@rivosinc.com,
	hankuan.chen@sifive.com,
	guoren@kernel.org,
	greentime.hu@sifive.com,
	samitolvanen@google.com,
	cleger@rivosinc.com,
	apatel@ventanamicro.com,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com,
	waylingii@gmail.com,
	sameo@rivosinc.com,
	alexghiti@rivosinc.com,
	akpm@linux-foundation.org,
	shikemeng@huaweicloud.com,
	rppt@kernel.org,
	charlie@rivosinc.com,
	xiao.w.wang@intel.com,
	willy@infradead.org,
	jszhang@kernel.org,
	leobras@redhat.com,
	songshuaishuai@tinylab.org,
	haxel@fzi.de,
	samuel.holland@sifive.com,
	namcaov@gmail.com,
	bjorn@rivosinc.com,
	cuiyunhui@bytedance.com,
	wangkefeng.wang@huawei.com,
	falcon@tinylab.org,
	viro@zeniv.linux.org.uk,
	bhe@redhat.com,
	chenjiahao16@huawei.com,
	hca@linux.ibm.com,
	arnd@arndb.de,
	kent.overstreet@linux.dev,
	boqun.feng@gmail.com,
	oleg@redhat.com,
	paulmck@kernel.org,
	broonie@kernel.org,
	rick.p.edgecombe@intel.com
Subject: [RFC PATCH 09/12] scs: kernel shadow stack with hardware assistance
Date: Mon,  8 Apr 2024 23:10:40 -0700
Message-Id: <20240409061043.3269676-10-debug@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409061043.3269676-1-debug@rivosinc.com>
References: <20240409061043.3269676-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If shadow stack have memory protections from underlying cpu, use those
protections. RISCV uses PAGE_KERNEL_SHADOWSTACK to vmalloc such shadow
stack pages. Shadow stack pages on RISCV grows downwards like regular
stack. Clang based software shadow call stack grows low to high address.
Thus this patch addresses some of those needs due to opposite direction
of shadow stack. Furthermore, RISCV hw shadow stack can't be memset
because memset uses normal stores. Lastly to store magic word at base of
shadow stack, arch specific shadow stack store has to be performed.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/scs.h | 48 +++++++++++++++++++++++++++++++++------------
 kernel/scs.c        | 28 ++++++++++++++++++++++----
 2 files changed, 59 insertions(+), 17 deletions(-)

diff --git a/include/linux/scs.h b/include/linux/scs.h
index 4ab5bdc898cf..3a31433532d1 100644
--- a/include/linux/scs.h
+++ b/include/linux/scs.h
@@ -12,6 +12,7 @@
 #include <linux/poison.h>
 #include <linux/sched.h>
 #include <linux/sizes.h>
+#include <asm/scs.h>
 
 #ifdef CONFIG_SHADOW_CALL_STACK
 
@@ -31,6 +32,29 @@ void scs_init(void);
 int scs_prepare(struct task_struct *tsk, int node);
 void scs_release(struct task_struct *tsk);
 
+#ifdef CONFIG_DYNAMIC_SCS
+/* dynamic_scs_enabled set to true if RISCV dynamic SCS */
+#ifdef CONFIG_RISCV
+DECLARE_STATIC_KEY_TRUE(dynamic_scs_enabled);
+#else
+DECLARE_STATIC_KEY_FALSE(dynamic_scs_enabled);
+#endif
+#endif
+
+static inline bool scs_is_dynamic(void)
+{
+	if (!IS_ENABLED(CONFIG_DYNAMIC_SCS))
+		return false;
+	return static_branch_likely(&dynamic_scs_enabled);
+}
+
+static inline bool scs_is_enabled(void)
+{
+	if (!IS_ENABLED(CONFIG_DYNAMIC_SCS))
+		return true;
+	return scs_is_dynamic();
+}
+
 static inline void scs_task_reset(struct task_struct *tsk)
 {
 	/*
@@ -42,6 +66,9 @@ static inline void scs_task_reset(struct task_struct *tsk)
 
 static inline unsigned long *__scs_magic(void *s)
 {
+	if (scs_is_dynamic())
+		return (unsigned long *)(s);
+
 	return (unsigned long *)(s + SCS_SIZE) - 1;
 }
 
@@ -50,23 +77,18 @@ static inline bool task_scs_end_corrupted(struct task_struct *tsk)
 	unsigned long *magic = __scs_magic(task_scs(tsk));
 	unsigned long sz = task_scs_sp(tsk) - task_scs(tsk);
 
-	return sz >= SCS_SIZE - 1 || READ_ONCE_NOCHECK(*magic) != SCS_END_MAGIC;
-}
-
-DECLARE_STATIC_KEY_FALSE(dynamic_scs_enabled);
+	if (scs_is_dynamic())
+		sz = (task_scs(tsk) + SCS_SIZE) - task_scs_sp(tsk);
 
-static inline bool scs_is_dynamic(void)
-{
-	if (!IS_ENABLED(CONFIG_DYNAMIC_SCS))
-		return false;
-	return static_branch_likely(&dynamic_scs_enabled);
+	return sz >= SCS_SIZE - 1 || READ_ONCE_NOCHECK(*magic) != SCS_END_MAGIC;
 }
 
-static inline bool scs_is_enabled(void)
+static inline void __scs_store_magic(unsigned long *s, unsigned long magic_val)
 {
-	if (!IS_ENABLED(CONFIG_DYNAMIC_SCS))
-		return true;
-	return scs_is_dynamic();
+	if (scs_is_dynamic())
+		arch_scs_store(s, magic_val);
+	else
+		*__scs_magic(s) = SCS_END_MAGIC;
 }
 
 #else /* CONFIG_SHADOW_CALL_STACK */
diff --git a/kernel/scs.c b/kernel/scs.c
index d7809affe740..e447483fa9f4 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -13,8 +13,13 @@
 #include <linux/vmstat.h>
 
 #ifdef CONFIG_DYNAMIC_SCS
+/* dynamic_scs_enabled set to true if RISCV dynamic SCS */
+#ifdef CONFIG_RISCV
+DEFINE_STATIC_KEY_TRUE(dynamic_scs_enabled);
+#else
 DEFINE_STATIC_KEY_FALSE(dynamic_scs_enabled);
 #endif
+#endif
 
 static void __scs_account(void *s, int account)
 {
@@ -32,19 +37,29 @@ static void *__scs_alloc(int node)
 {
 	int i;
 	void *s;
+	pgprot_t prot = PAGE_KERNEL;
+
+	if (scs_is_dynamic())
+		prot = PAGE_KERNEL_SHADOWSTACK;
 
 	for (i = 0; i < NR_CACHED_SCS; i++) {
 		s = this_cpu_xchg(scs_cache[i], NULL);
 		if (s) {
 			s = kasan_unpoison_vmalloc(s, SCS_SIZE,
 						   KASAN_VMALLOC_PROT_NORMAL);
-			memset(s, 0, SCS_SIZE);
+/*
+ * If either of them undefined, its safe to memset. Else memset is not
+ * possible. memset constitutes stores and stores to shadow stack memory
+ * are disallowed and will fault.
+ */
+			if (!scs_is_dynamic())
+				memset(s, 0, SCS_SIZE);
 			goto out;
 		}
 	}
 
 	s = __vmalloc_node_range(SCS_SIZE, 1, VMALLOC_START, VMALLOC_END,
-				    GFP_SCS, PAGE_KERNEL, 0, node,
+				    GFP_SCS, prot, 0, node,
 				    __builtin_return_address(0));
 
 out:
@@ -59,7 +74,7 @@ void *scs_alloc(int node)
 	if (!s)
 		return NULL;
 
-	*__scs_magic(s) = SCS_END_MAGIC;
+	__scs_store_magic(__scs_magic(s), SCS_END_MAGIC);
 
 	/*
 	 * Poison the allocation to catch unintentional accesses to
@@ -122,7 +137,12 @@ int scs_prepare(struct task_struct *tsk, int node)
 	if (!s)
 		return -ENOMEM;
 
-	task_scs(tsk) = task_scs_sp(tsk) = s;
+	task_scs(tsk) = s;
+	if (scs_is_dynamic())
+		task_scs_sp(tsk) = s + SCS_SIZE;
+	else
+		task_scs_sp(tsk) = s;
+
 	return 0;
 }
 
-- 
2.43.2


