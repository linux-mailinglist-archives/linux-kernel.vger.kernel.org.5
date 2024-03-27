Return-Path: <linux-kernel+bounces-121010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C29AB88E176
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802AE28A731
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8396E158D71;
	Wed, 27 Mar 2024 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d06W+fJ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B227F12DDA1;
	Wed, 27 Mar 2024 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541831; cv=none; b=GpnhfoL8DR9z8ZY14QribOL3WcvIKhIjn13J2D7IfQfPSjGSzo4xCijcD3SmyrQHGQzV43KbDMOMoJSCAghtBJCZXsCp1D1LqePDgGhEpkgh3ytjEUEq/ZfOnBX5X9CfBvJCZ3nHCx+ArO4tmJoczlj3Y+cCAKwtlt/dlyT9SY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541831; c=relaxed/simple;
	bh=WSd8T2ifFyZYDFzcZ67QRybkRGLc0fBNuKH2nWng4Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lCN4eEcIrW0jCFQ8x3u1OGnn6eyx2efG4buy9TZKBbAasmdf84nVX4icXGh2PfT/yGwLL1kGdQMc91KyEojM7lWH2LFNr4YbF56/ffCPBVDxO5/zjit6bCDmLhIR7QkkOh59TaLIY8X6i3tT3Ej+h2H10CjSWHCupVeBl7e5SZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d06W+fJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25B8C43394;
	Wed, 27 Mar 2024 12:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541831;
	bh=WSd8T2ifFyZYDFzcZ67QRybkRGLc0fBNuKH2nWng4Ok=;
	h=From:To:Cc:Subject:Date:From;
	b=d06W+fJ45x2gHs05bU1Y2fGB1o8mZtS+cctzfz5z69eXkxJ88iOFl/7lN9i8B+v/b
	 h1VkrrsXccmczXB6s1360wq/hf9n+AZ0CzkNT+juK4t5q+zQ3W4Ou129HT8fDm67bu
	 cjIUIvI177Vy2gZ2lBrVCVpgrr5SCR/eSkBic2UWmJnxTMTVKADIBdEJCypErM685o
	 T5UXsMd7ujl0BtbDCRMcSm8Yb+l4NqTC7WL2eY83VVIWwF4//U3rc36v8w1o+KSgZb
	 NUztGovvJ/Qc5kX9npsz22BRdbiYzZR5LppuL6TWB2ebTPV4JNrw2xlUj9rc4ur/Pg
	 eqT79ezBZwZBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chenhuacai@kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "LoongArch: Define the __io_aw() hook as mmiowb()" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:17:09 -0400
Message-ID: <20240327121709.2833321-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9c68ece8b2a5c5ff9b2fcaea923dd73efeb174cd Mon Sep 17 00:00:00 2001
From: Huacai Chen <chenhuacai@loongson.cn>
Date: Tue, 19 Mar 2024 15:50:34 +0800
Subject: [PATCH] LoongArch: Define the __io_aw() hook as mmiowb()

Commit fb24ea52f78e0d595852e ("drivers: Remove explicit invocations of
mmiowb()") remove all mmiowb() in drivers, but it says:

"NOTE: mmiowb() has only ever guaranteed ordering in conjunction with
spin_unlock(). However, pairing each mmiowb() removal in this patch with
the corresponding call to spin_unlock() is not at all trivial, so there
is a small chance that this change may regress any drivers incorrectly
relying on mmiowb() to order MMIO writes between CPUs using lock-free
synchronisation."

The mmio in radeon_ring_commit() is protected by a mutex rather than a
spinlock, but in the mutex fastpath it behaves similar to spinlock. We
can add mmiowb() calls in the radeon driver but the maintainer says he
doesn't like such a workaround, and radeon is not the only example of
mutex protected mmio.

So we should extend the mmiowb tracking system from spinlock to mutex,
and maybe other locking primitives. This is not easy and error prone, so
we solve it in the architectural code, by simply defining the __io_aw()
hook as mmiowb(). And we no longer need to override queued_spin_unlock()
so use the generic definition.

Without this, we get such an error when run 'glxgears' on weak ordering
architectures such as LoongArch:

radeon 0000:04:00.0: ring 0 stalled for more than 10324msec
radeon 0000:04:00.0: ring 3 stalled for more than 10240msec
radeon 0000:04:00.0: GPU lockup (current fence id 0x000000000001f412 last fence id 0x000000000001f414 on ring 3)
radeon 0000:04:00.0: GPU lockup (current fence id 0x000000000000f940 last fence id 0x000000000000f941 on ring 0)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
radeon 0000:04:00.0: scheduling IB failed (-35).
[drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)

Link: https://lore.kernel.org/dri-devel/29df7e26-d7a8-4f67-b988-44353c4270ac@amd.com/T/#t
Link: https://lore.kernel.org/linux-arch/20240301130532.3953167-1-chenhuacai@loongson.cn/T/#t
Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/Kbuild      |  1 +
 arch/loongarch/include/asm/io.h        |  2 ++
 arch/loongarch/include/asm/qspinlock.h | 18 ------------------
 3 files changed, 3 insertions(+), 18 deletions(-)
 delete mode 100644 arch/loongarch/include/asm/qspinlock.h

diff --git a/arch/loongarch/include/asm/Kbuild b/arch/loongarch/include/asm/Kbuild
index a97c0edbb866a..2dbec7853ae86 100644
--- a/arch/loongarch/include/asm/Kbuild
+++ b/arch/loongarch/include/asm/Kbuild
@@ -6,6 +6,7 @@ generic-y += mcs_spinlock.h
 generic-y += parport.h
 generic-y += early_ioremap.h
 generic-y += qrwlock.h
+generic-y += qspinlock.h
 generic-y += rwsem.h
 generic-y += segment.h
 generic-y += user.h
diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm/io.h
index c486c2341b662..4a8adcca329b8 100644
--- a/arch/loongarch/include/asm/io.h
+++ b/arch/loongarch/include/asm/io.h
@@ -71,6 +71,8 @@ extern void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t
 #define memcpy_fromio(a, c, l) __memcpy_fromio((a), (c), (l))
 #define memcpy_toio(c, a, l)   __memcpy_toio((c), (a), (l))
 
+#define __io_aw() mmiowb()
+
 #include <asm-generic/io.h>
 
 #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
diff --git a/arch/loongarch/include/asm/qspinlock.h b/arch/loongarch/include/asm/qspinlock.h
deleted file mode 100644
index 34f43f8ad5912..0000000000000
--- a/arch/loongarch/include/asm/qspinlock.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_QSPINLOCK_H
-#define _ASM_QSPINLOCK_H
-
-#include <asm-generic/qspinlock_types.h>
-
-#define queued_spin_unlock queued_spin_unlock
-
-static inline void queued_spin_unlock(struct qspinlock *lock)
-{
-	compiletime_assert_atomic_type(lock->locked);
-	c_sync();
-	WRITE_ONCE(lock->locked, 0);
-}
-
-#include <asm-generic/qspinlock.h>
-
-#endif /* _ASM_QSPINLOCK_H */
-- 
2.43.0





