Return-Path: <linux-kernel+bounces-121041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3925D88E1C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23151F2CF14
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4143E15D5DE;
	Wed, 27 Mar 2024 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQ0/AQDV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D8315D5D2;
	Wed, 27 Mar 2024 12:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541918; cv=none; b=kBs0twqB3znAd2H0g66fCPKfZeoO92pQIPoqPdUgDn7SdgPxX8mCDnkXjgSOxXh3/L9cFG9quUz7oycux7QDE7eIkoc9D8egVu6Ld0ahAAmxIGWlpvFSIXbb94cTxVqZ6kIEeROW2q67/MBA0RaE9ShQZB4S646o+/uf/WXSdpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541918; c=relaxed/simple;
	bh=nyDkxAtoumz6NapNC3ssvGii4GjOv4f2Xhot8O07yaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P/S1BLZpiqlIqYQE22LVp90Peo7ks2TOoj6P4PgVpjSygo7CgBMtO4qvSZoTp+v5QtnWUbrM7NJwU2sIRc3wgXy+Zk1CIrAVn1Vhz/DRV/QCbamM8jRwBZ0Gzhu290C1UkSVjKzkLO6HCgfRECQPm40sia5eAKEUtCck+hcIcx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQ0/AQDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E269DC433F1;
	Wed, 27 Mar 2024 12:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541918;
	bh=nyDkxAtoumz6NapNC3ssvGii4GjOv4f2Xhot8O07yaE=;
	h=From:To:Cc:Subject:Date:From;
	b=MQ0/AQDVZpvUPIRzwLmMHUtIr9bqDDfn9P6vqdRqnICn5X+wPtNIVJ5twWoj+wGnR
	 qwEKRq8t52Amp2iHl0k+zqmHo6Ly0KDXKhTduHZWU1PMypLe0+OV2TqUun7LT+3Wvk
	 fPQ7chZb99nEj5/6LOJCwc/LzzJe5+MM9C4whH/034w66PM0kNPwvDf8L7T9qWWQBe
	 CsNY+qNBEu/bdVH0cDAe91q+e0QJ/v+O/7j8+PLvtTTIKZrt+ooc6BJtr3AVbzo4Co
	 igYJVKzeTQwj0vw7Jfs+8MyiqAM/qwMkpk64a8PkDyZAfpDUTv5cfivTQg2MVCLVRJ
	 sKqhE8gtt1pTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chenhuacai@kernel.org
Cc: Xiaotian Wu <wuxiaotian@loongson.cn>,
	Miao Wang <shankerwangmiao@gmail.com>,
	Xing Li <lixing@loongson.cn>,
	Hongchen Zhang <zhanghongchen@loongson.cn>,
	Rui Wang <wangrui@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	linux-mm@kvack.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "LoongArch: Change __my_cpu_offset definition to avoid mis-optimization" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:18:35 -0400
Message-ID: <20240327121836.2834515-1-sashal@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c87e12e0e8c1241410e758e181ca6bf23efa5b5b Mon Sep 17 00:00:00 2001
From: Huacai Chen <chenhuacai@loongson.cn>
Date: Tue, 19 Mar 2024 15:50:34 +0800
Subject: [PATCH] LoongArch: Change __my_cpu_offset definition to avoid
 mis-optimization

From GCC commit 3f13154553f8546a ("df-scan: remove ad-hoc handling of
global regs in asms"), global registers will no longer be forced to add
to the def-use chain. Then current_thread_info(), current_stack_pointer
and __my_cpu_offset may be lifted out of the loop because they are no
longer treated as "volatile variables".

This optimization is still correct for the current_thread_info() and
current_stack_pointer usages because they are associated to a thread.
However it is wrong for __my_cpu_offset because it is associated to a
CPU rather than a thread: if the thread migrates to a different CPU in
the loop, __my_cpu_offset should be changed.

Change __my_cpu_offset definition to treat it as a "volatile variable",
in order to avoid such a mis-optimization.

Cc: stable@vger.kernel.org
Reported-by: Xiaotian Wu <wuxiaotian@loongson.cn>
Reported-by: Miao Wang <shankerwangmiao@gmail.com>
Signed-off-by: Xing Li <lixing@loongson.cn>
Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
Signed-off-by: Rui Wang <wangrui@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/percpu.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include/asm/percpu.h
index 9b36ac003f890..8f290e5546cf7 100644
--- a/arch/loongarch/include/asm/percpu.h
+++ b/arch/loongarch/include/asm/percpu.h
@@ -29,7 +29,12 @@ static inline void set_my_cpu_offset(unsigned long off)
 	__my_cpu_offset = off;
 	csr_write64(off, PERCPU_BASE_KS);
 }
-#define __my_cpu_offset __my_cpu_offset
+
+#define __my_cpu_offset					\
+({							\
+	__asm__ __volatile__("":"+r"(__my_cpu_offset));	\
+	__my_cpu_offset;				\
+})
 
 #define PERCPU_OP(op, asm_op, c_op)					\
 static __always_inline unsigned long __percpu_##op(void *ptr,		\
-- 
2.43.0





