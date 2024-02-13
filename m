Return-Path: <linux-kernel+bounces-63862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFE58535A3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22C0CB27FE8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFD96025E;
	Tue, 13 Feb 2024 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola-com.20230601.gappssmtp.com header.i=@motorola-com.20230601.gappssmtp.com header.b="Ia9esmYW"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796665FB8D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840360; cv=none; b=LREvEabVpJNfmCwkbUvmEmZ1hF5MGH6Jr4TXkjTbsyjA5IcS80jdgrAdpuhgLzDgPw43EE07RY/Y8vYUmztjZaHZMrf0MD58+Pd5k3IsmJjiy5PsEaNOKQgW6AQKVIjA0GPczPzsl2F8wn214C9Sld2TrPFaTXgMuczKJUx4cK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840360; c=relaxed/simple;
	bh=j7L57yfDJOOv+ZUdMV9NCeFXUFzD3Nw58mseoOFjGSk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YpBcAamEntQLkKXFfNlQsJv/G2zzTEY36dHQ8z96NavR+xQ5NyXQTPSXB61gyN0zT3MktsgC+WcpiBS7w4a/k6+F+qmaK+URijtoUJBwbOGIL37v8ySDaPFnce2tSjhw86esUMw+j7zSAp98TYrtaZVTI9iar+ZWGKB/qv2qPr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola-com.20230601.gappssmtp.com header.i=@motorola-com.20230601.gappssmtp.com header.b=Ia9esmYW; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51147d0abd1so5169076e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=motorola-com.20230601.gappssmtp.com; s=20230601; t=1707840356; x=1708445156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CEDvSvYhyauFeH8HCgsVW9bjAlPcgBCfLAOG21KUOeA=;
        b=Ia9esmYWxK0VBMPHRamHIWkGOJs6MqccjC8mxs7G9g0MEepJTN997nGDr9nGOTcLJx
         ehRuI4zl1XdDUP1ZWc6DyivOl3xb/nQDWMGiSzZl3gPqvjwamWV1tL2Bb8dX2KBQ2eQ5
         qHDDnlybS73eJLRa67dEpPRNX5+MndcUzSqcfj5LqJzfX01EQ/GMlGO4r4ZC8Qjs7xjF
         7VO8NiIAUMnKoqVqMD8fEJhATP5DH3w44DjYqDldc0gMZ5wv4XsV8QSbqvk41HvRNqIc
         HPNyHHsuCgAd/L6DZOEwCdHPVoQhTcmn0MoRVoHXoJmFg0C9eczEj8DkC/AzDSyRp3aF
         o7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707840356; x=1708445156;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CEDvSvYhyauFeH8HCgsVW9bjAlPcgBCfLAOG21KUOeA=;
        b=Q2JidTsFf2zWISE0tAQ/fDL7m1kC+gICN/r+F2Do6Z42hMmfZTgfNUN+Tb8F4kWD1m
         NaQadgWakOgzvTbNd3QqCei38T8zb7ybIhPIKeNf0CzpI2qnxwxvHNK7cDE6IepyHDmG
         lKEpRFi6js+gWqQq09liC8kU0HmrokPAm4OpxXrhq5+KgJRfE/Ad3CqP81Fwc2QLyC+J
         35+9s/H0s6HqGN4TynyziNlvUqan4BhLUuGlXnLJ9bCiyfmF6fV5t8ODOJD/ZPu5iff7
         lhPKig76nha6VeIJSfR69+cUt3r9yqQrCRgqrmX9rTI7Jx6Zw1NNgpLp0GdFsMh2gMdC
         ppLQ==
X-Gm-Message-State: AOJu0YyRsFCg7PDmUPFMS23JzruQNsCU7Rv+05mijDhqeBjx61/xsIhA
	l3U64Ya7EuJUZCTm+aT90/Iy8O3wBvaCNg2eIkS4cdh9rNfsYEJJOTL+L7Pr5Ud6trOvGFC9Pcv
	+aLAAWCDm6FcKWQXO2DE9Vr2daIbRHJe0AFsI
X-Google-Smtp-Source: AGHT+IHYMpkxa2matGsJqOQHdcpvyUVrmAhdJnBDChaCNAXCjN5JzqoJXHX6E/S0U3nduZoXLj/LKbNruFUGLFN1u3c=
X-Received: by 2002:a05:6512:158f:b0:511:47f7:62e0 with SMTP id
 bp15-20020a056512158f00b0051147f762e0mr9204732lfb.21.1707840356309; Tue, 13
 Feb 2024 08:05:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Maxwell Bland <mbland@motorola.com>
Date: Tue, 13 Feb 2024 10:05:45 -0600
Message-ID: <CAP5Mv+ydhk=Ob4b40ZahGMgT-5+-VEHxtmA=-LkJiEOOU+K6hw@mail.gmail.com>
Subject: [PATCH] arm64: allow post-init vmalloc PXNTable
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, catalin.marinas@arm.com, 
	will@kernel.org, dennis@kernel.org, tj@kernel.org, cl@linux.com, 
	akpm@linux-foundation.org, shikemeng@huaweicloud.com, david@redhat.com, 
	rppt@kernel.org, anshuman.khandual@arm.com, willy@infradead.org, 
	ryan.roberts@arm.com, rick.p.edgecombe@intel.com, pcc@google.com, 
	mbland@motorola.com, mark.rutland@arm.com, rmk+kernel@armlinux.org.uk, 
	tglx@linutronix.de, gshan@redhat.com, gregkh@linuxfoundation.org, 
	Jonathan.Cameron@huawei.com, james.morse@arm.com, awheeler@motorola.com
Content-Type: text/plain; charset="UTF-8"

Apologies if this is a duplicate mail, it will be the last one. Moto's SMTP
server sucks!!

Ensures that PXNTable can be set on all table descriptors allocated
through vmalloc. Normally, PXNTable is set only during initial memory
mapping and does not apply thereafter, making it possible for attackers
to target post-init allocated writable PTEs as a staging region for
injection of their code into the kernel. Presently it is not possible to
efficiently prevent these attacks as VMALLOC_END overlaps with _text,
e.g.:

VMALLOC_START ffff800080000000 VMALLOC_END fffffbfff0000000
_text         ffffb6c0c1400000 _end        ffffb6c0c3e40000

Setting VMALLOC_END to _text in init would resolve this issue with the
caveat of a sizeable reduction in the size of available vmalloc memory
due to requirements on aslr randomness. However, there are circumstances
where this trade-off is necessary: in particular, hypervisor-level
security monitors where 1) the microarchitecture contains race
conditions on PTE level updates or 2) a per-PTE update verifier comes at
a significant hit to performance.

Because the address of _text is aslr-sensitive and this patch associates
this value with VMALLOC_END, we remove the use of VMALLOC_END in a print
statement in mm/percpu.c. However, only the format string is updated in
crash_core.c, since we are dead at that point regardless. VMALLOC_END is
updated in kernel/setup.c to associate the feature closely with aslr and
region allocation code.

Signed-off-by: Maxwell Bland <mbland@motorola.com>
---
 arch/arm64/Kconfig                   | 13 +++++++++++++
 arch/arm64/include/asm/pgtable.h     |  6 ++++++
 arch/arm64/include/asm/vmalloc-pxn.h | 10 ++++++++++
 arch/arm64/kernel/crash_core.c       |  2 +-
 arch/arm64/kernel/setup.c            |  9 +++++++++
 mm/percpu.c                          |  4 ++--
 6 files changed, 41 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/include/asm/vmalloc-pxn.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index aa7c1d435139..5f1e75d70e14 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2165,6 +2165,19 @@ config ARM64_DEBUG_PRIORITY_MASKING
    If unsure, say N
 endif # ARM64_PSEUDO_NMI

+config ARM64_VMALLOC_PXN
+ bool "Ensures table descriptors pointing to kernel data are PXNTable"
+ help
+   Reduces the range of the kernel data vmalloc region to remove any
+   overlap with kernel code, making it possible to enable the PXNTable
+   bit on table descriptors allocated after the kernel's initial memory
+   mapping.
+
+   This increases the performance of security monitors which protect
+   against malicious updates to page table entries.
+
+   If unsure, say N.
+
 config RELOCATABLE
  bool "Build a relocatable kernel image" if EXPERT
  select ARCH_HAS_RELR
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 79ce70fbb751..49f64ea77c81 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -22,7 +22,9 @@
  * and fixed mappings
  */
 #define VMALLOC_START (MODULES_END)
+#ifndef CONFIG_ARM64_VMALLOC_PXN
 #define VMALLOC_END (VMEMMAP_START - SZ_256M)
+#endif

 #define vmemmap ((struct page *)VMEMMAP_START - (memstart_addr >> PAGE_SHIFT))

@@ -35,6 +37,10 @@
 #include <linux/sched.h>
 #include <linux/page_table_check.h>

+#ifdef CONFIG_ARM64_VMALLOC_PXN
+#include <asm/vmalloc-pxn.h>
+#endif
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE

diff --git a/arch/arm64/include/asm/vmalloc-pxn.h
b/arch/arm64/include/asm/vmalloc-pxn.h
new file mode 100644
index 000000000000..c8c4f878eb62
--- /dev/null
+++ b/arch/arm64/include/asm/vmalloc-pxn.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM64_VMALLOC_PXN_H
+#define _ASM_ARM64_VMALLOC_PXN_H
+
+#ifdef CONFIG_ARM64_VMALLOC_PXN
+extern u64 __vmalloc_end __ro_after_init;
+#define VMALLOC_END (__vmalloc_end)
+#endif /* CONFIG_ARM64_VMALLOC_PXN */
+
+#endif /* _ASM_ARM64_VMALLOC_PXN_H */
diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
index 66cde752cd74..39dccae11a40 100644
--- a/arch/arm64/kernel/crash_core.c
+++ b/arch/arm64/kernel/crash_core.c
@@ -24,7 +24,7 @@ void arch_crash_save_vmcoreinfo(void)
  vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
  vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
  vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
- vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
+ vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%llx\n", VMALLOC_END);
  vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
  vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
  vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 42c690bb2d60..b7ccee672743 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -54,6 +54,11 @@
 #include <asm/xen/hypervisor.h>
 #include <asm/mmu_context.h>

+#ifdef CONFIG_ARM64_VMALLOC_PXN
+u64 __vmalloc_end __ro_after_init = VMEMMAP_START - SZ_256M;
+EXPORT_SYMBOL(__vmalloc_end);
+#endif /* CONFIG_ARM64_VMALLOC_PXN */
+
 static int num_standard_resources;
 static struct resource *standard_resources;

@@ -298,6 +303,10 @@ void __init __no_sanitize_address setup_arch(char
**cmdline_p)

  kaslr_init();

+#ifdef CONFIG_ARM64_VMALLOC_PXN
+ __vmalloc_end = ALIGN_DOWN((u64) _text, PMD_SIZE);
+#endif
+
  /*
  * If know now we are going to need KPTI then use non-global
  * mappings from the start, avoiding the cost of rewriting
diff --git a/mm/percpu.c b/mm/percpu.c
index 4e11fc1e6def..a902500ebfa0 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3128,8 +3128,8 @@ int __init pcpu_embed_first_chunk(size_t
reserved_size, size_t dyn_size,

  /* warn if maximum distance is further than 75% of vmalloc space */
  if (max_distance > VMALLOC_TOTAL * 3 / 4) {
- pr_warn("max_distance=0x%lx too large for vmalloc space 0x%lx\n",
- max_distance, VMALLOC_TOTAL);
+ pr_warn("max_distance=0x%lx too large for vmalloc space\n",
+ max_distance);
 #ifdef CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK
  /* and fail if we have fallback */
  rc = -EINVAL;

base-commit: 716f4aaa7b48a55c73d632d0657b35342b1fefd7
-- 
2.39.0

