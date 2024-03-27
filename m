Return-Path: <linux-kernel+bounces-121264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C31488E47E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E9329D988
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64B31B5DBC;
	Wed, 27 Mar 2024 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaniZI5H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFED142912;
	Wed, 27 Mar 2024 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542498; cv=none; b=pokh+LiDUCdehl6dMIYiKDqZtC1YnCH4onouMFmyQQGBeYmVyjQr1GWc0LmCiSbZN4nCKudleshx9TRIxwNzfNQHAVKwnsobdaQIUNIhDmiiGdru1W/+22N9yRRAQMMLxB1pLWvSE2R4jA180V6rhgTYQZI6mQq6VEpVl4KIdHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542498; c=relaxed/simple;
	bh=1TIZ04xxXd3QxJsNV+QvtBBGVWl6fjSqN/ETTdAfEWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L8MM8LueMj/AmaSFvCthJWNhU6Hdqldc9aSb7jqv/3xCrPlFP1NdCLmiVsmFZkNqAkdMnjeCUykeVOwS8Mhqpt6WHtNmbEClzF9rkyKwsFyUF8MLesme5o//YVU1Wd5zrEkSFr6dNojobUEGKAdB3rrTUibpyKcCH1xPwdezF5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaniZI5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171FDC433F1;
	Wed, 27 Mar 2024 12:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542497;
	bh=1TIZ04xxXd3QxJsNV+QvtBBGVWl6fjSqN/ETTdAfEWY=;
	h=From:To:Cc:Subject:Date:From;
	b=VaniZI5H9GszpAGYURzFuIIshj2A9lyzB5GpuSOaLn4IenzWGGyG7uT0LUiw3JPm2
	 S85JugwQ4ICAWLuj26cIsCkWKjBCU+9YD/kMI4a/2RgAO16l2xNRZ1Zyif+OXJY9Yl
	 2I5QcaOl+v13lAMtKCtGFHT+fSTaP6rbIpYGVS9ht0JMs/vj8+VkAzue/5S9VUd1rX
	 ceFfuJZs9w/mci1sRp/0At9fjR+rxJCZRglKa3hw3ddNOuNWfNeQBKEyt5thtU0poB
	 tXa76l/tUvCge30R5AQJg2llB8xN/s3rEZRle76QjkLojYtubCx+KFCtTes0fxP2CW
	 lSCXE1EbjL6yg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chenhuacai@kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "LoongArch: Define the __io_aw() hook as mmiowb()" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:28:15 -0400
Message-ID: <20240327122816.2842609-1-sashal@kernel.org>
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

The patch below does not apply to the 4.19-stable tree.
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





