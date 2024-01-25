Return-Path: <linux-kernel+bounces-38018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F5E83B9CE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2361C24C6E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEBF11C92;
	Thu, 25 Jan 2024 06:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KvDEW+yH"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85BE18EB0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164177; cv=none; b=icB76Fg7VDDSzsFFkWWe8r2uYoIkw9P2k3hu9DTzqOYQVddxqn80lpqCb6SjTcf3p0oHHJ2VLmmXs9x23z7csBPBEnHplAxo9hT7eW/0Xk7celg8IEdToktux6hehTJdBZ8ib2HrnFWkuv8DfUW6bOjfDU99Jovo3EtUE+hTHbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164177; c=relaxed/simple;
	bh=XO448NH1Np7X5WlCzLn7L6Ma91lQbrB8oFTc1FKnHTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ld2cKmtgfD2Lf0A94ztat3MhE41mRz9e0X5EYoGq6Nctq4DdYVKHG2UykjtDsGh11MNDUKZFi2H1p+t6wEMAft0Ha9wubXlJLLS4BS7/vl1x72kQ1DuUnUwGZ5pODYsj7T2ahfNAozFPEq+MeIvjDDOVsdB1VnuivQa4n1MpJic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KvDEW+yH; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d46a378f74so1520821a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706164175; x=1706768975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEK0nLeeUyyEqPsucfbvDxvRRfgyRHV2ZwAZ0YdFTFk=;
        b=KvDEW+yHm6BpWt3goytVpONsPZNtA+7TV24pJwDF+m+PkRYwOeyY6RGgRtJF74kWWR
         9X2jmf21eGjElTZRiOsatB35F+1/nab5saLh3xgC+YliGXGHGXgxJg9IF+zpST7K8Vok
         ckY0tCDwJ8AYQwthspNmkseCm1/qjFFgNNB/uQ76yo3Pd+AxcFzYwBD6WTC39kvy9pyu
         97PQvrUdob8d8sdoU6PKq6E6cRqyDGAa26PU9aj8m8K/LelN8jwH3WdJ2Zpahy6fiuID
         mcwR6Hv315vPqhEqR9P0GfcvanABwJyewch0jF2GSuLArRkv2J//lCSLY8KG5Aa8hvTr
         CjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706164175; x=1706768975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEK0nLeeUyyEqPsucfbvDxvRRfgyRHV2ZwAZ0YdFTFk=;
        b=DnwuBT+EIiIdcqHrhfcojMKTkbmxz3E/Z5ZRg52xognUnKC7guheH97MZkZN1ZNGuU
         WokIhHIQTWOlmOSckvcZDYNVoOXh3fdmzV6ImhSDv8Iv4krNbt+zEVyzX57y3Kka1y4g
         wd7LAMg6k05jb6yo54DE6sWlCHn0DYHTM1L5kSt5WPRIX5f/O+y8h/h7YsBveJiso67d
         fM3Oul162tDUAP0Tbr9RlKEgos2e3dIjLZTgjSD/PEYqPbWpzXtn3WReeW33jWDrzHCu
         yTHUSeZLhHQX8+j+zmDOUGLj44I5bUcasqG5BK77t3b7dF6b4kmXU5M5E/gIJg+6LP6B
         wO3Q==
X-Gm-Message-State: AOJu0YyV0CaRS/+2y/7pmQJ2iOv0wCu/xqYqP6AuR4IOTc3gY5cvPPq0
	zX7uOsxb9TI/lYVNKzALgxtrz5qDNCFdlfC8Ahq84EktZxXhpQLQp0WbBMgGmvE=
X-Google-Smtp-Source: AGHT+IEuES+Nqzdr2BEz6j/Kl5wHqawKSI3UsPoKeKJE5bEvHyihgNT2hQgxZpIvSEF4VhLoqkQkuQ==
X-Received: by 2002:a05:6a20:2d25:b0:199:a43f:db4 with SMTP id g37-20020a056a202d2500b00199a43f0db4mr942290pzl.80.1706164175121;
        Wed, 24 Jan 2024 22:29:35 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a00139300b006dd870b51b8sm3201139pfg.126.2024.01.24.22.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:29:34 -0800 (PST)
From: debug@rivosinc.com
To: rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com
Cc: corbet@lwn.net,
	aou@eecs.berkeley.edu,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	waylingii@gmail.com,
	greentime.hu@sifive.com,
	heiko@sntech.de,
	jszhang@kernel.org,
	shikemeng@huaweicloud.com,
	david@redhat.com,
	charlie@rivosinc.com,
	panqinglin2020@iscas.ac.cn,
	willy@infradead.org,
	vincent.chen@sifive.com,
	andy.chiu@sifive.com,
	gerg@kernel.org,
	jeeheng.sia@starfivetech.com,
	mason.huo@starfivetech.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bhe@redhat.com,
	chenjiahao16@huawei.com,
	ruscur@russell.cc,
	bgray@linux.ibm.com,
	alx@kernel.org,
	baruch@tkos.co.il,
	zhangqing@loongson.cn,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	joey.gouly@arm.com,
	shr@devkernel.io,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v1 11/28] riscv: Implementing "PROT_SHADOWSTACK" on riscv
Date: Wed, 24 Jan 2024 22:21:36 -0800
Message-ID: <20240125062739.1339782-12-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125062739.1339782-1-debug@rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Deepak Gupta <debug@rivosinc.com>

This patch implements new risc-v specific protection flag
`PROT_SHADOWSTACK` (only for kernel) on riscv.

`PROT_SHADOWSTACK` protection flag is only limited to kernel and not exposed
to userspace. Shadow stack is a security construct to prevent against ROP attacks.
`map_shadow_stack` is a new syscall to manufacture shadow stack. In order to avoid
multiple methods to create shadow stack, `PROT_SHADOWSTACK` is not allowed for user
space `mmap` call. `mprotect` wouldn't allow because `arch_validate_prot` already
takes care of this for risc-v.

`arch_calc_vm_prot_bits` is implemented on risc-v to return VM_SHADOW_STACK (alias
for VM_WRITE) if PROT_SHADOWSTACK is supplied (such as call to `do_mmap` will) and
underlying CPU supports shadow stack. `PROT_WRITE` will be converted to `VM_READ |
`VM_WRITE` so that existing case where `PROT_WRITE` is specified keep working but
don't collide with `VM_WRITE` only encoding which now denotes a shadow stack.

risc-v `mmap` wrapper enforces if PROT_WRITE is specified and PROT_READ is left out
then PROT_READ is enforced.

Earlier `protection_map[VM_WRITE]` used to pick read-write (and copy on write) PTE
encodings. Now all non-shadow stack writeable mappings will pick `protection_map[VM_WRITE
| VM_READ] PTE encodings. `protection[VM_WRITE]` are programmed to pick PAGE_SHADOWSTACK
PTE encordings.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/mman.h    | 17 +++++++++++++++++
 arch/riscv/include/asm/pgtable.h |  1 +
 arch/riscv/kernel/sys_riscv.c    | 19 +++++++++++++++++++
 arch/riscv/mm/init.c             |  2 +-
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/mman.h b/arch/riscv/include/asm/mman.h
index 4902d837e93c..bc09a9c0e81f 100644
--- a/arch/riscv/include/asm/mman.h
+++ b/arch/riscv/include/asm/mman.h
@@ -22,4 +22,21 @@
  */
 #define PROT_SHADOWSTACK	0x40
 
+static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
+	unsigned long pkey __always_unused)
+{
+	unsigned long ret = 0;
+
+	if (cpu_supports_shadow_stack())
+		ret = (prot & PROT_SHADOWSTACK) ? VM_SHADOW_STACK : 0;
+	/*
+	 * If PROT_WRITE was specified, force it to VM_READ | VM_WRITE.
+	 * Only VM_WRITE means shadow stack.
+	 */
+	if (prot & PROT_WRITE)
+		ret = (VM_READ | VM_WRITE);
+	return ret;
+}
+#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
+
 #endif /* ! __ASM_MMAN_H__ */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 294044429e8e..54a8dde29504 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -184,6 +184,7 @@ extern struct pt_alloc_ops pt_ops __initdata;
 #define PAGE_READ_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
 #define PAGE_WRITE_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ |	\
 					 _PAGE_EXEC | _PAGE_WRITE)
+#define PAGE_SHADOWSTACK       __pgprot(_PAGE_BASE | _PAGE_WRITE)
 
 #define PAGE_COPY		PAGE_READ
 #define PAGE_COPY_EXEC		PAGE_READ_EXEC
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index a2ca5b7756a5..2a7cf28a6fe0 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -16,6 +16,7 @@
 #include <asm/unistd.h>
 #include <asm-generic/mman-common.h>
 #include <vdso/vsyscall.h>
+#include <asm/mman.h>
 
 static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 			   unsigned long prot, unsigned long flags,
@@ -25,6 +26,24 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
 		return -EINVAL;
 
+	/*
+	 * If only PROT_WRITE is specified then extend that to PROT_READ
+	 * protection_map[VM_WRITE] is now going to select shadow stack encodings.
+	 * So specifying PROT_WRITE actually should select protection_map [VM_WRITE | VM_READ]
+	 * If user wants to create shadow stack then they should use `map_shadow_stack` syscall.
+	 */
+	if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
+		prot |= PROT_READ;
+
+	/*
+	 * PROT_SHADOWSTACK is a kernel only protection flag on risc-v.
+	 * mmap doesn't expect PROT_SHADOWSTACK to be set by user space.
+	 * User space can rely on `map_shadow_stack` syscall to create
+	 * shadow stack pages.
+	 */
+	if (unlikely(prot & PROT_SHADOWSTACK))
+		return -EINVAL;
+
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
 			       offset >> (PAGE_SHIFT - page_shift_offset));
 }
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 2e011cbddf3a..f71c2d2c6cbf 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -296,7 +296,7 @@ pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 static const pgprot_t protection_map[16] = {
 	[VM_NONE]					= PAGE_NONE,
 	[VM_READ]					= PAGE_READ,
-	[VM_WRITE]					= PAGE_COPY,
+	[VM_WRITE]					= PAGE_SHADOWSTACK,
 	[VM_WRITE | VM_READ]				= PAGE_COPY,
 	[VM_EXEC]					= PAGE_EXEC,
 	[VM_EXEC | VM_READ]				= PAGE_READ_EXEC,
-- 
2.43.0


