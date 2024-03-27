Return-Path: <linux-kernel+bounces-121121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AA788E291
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066831F2816F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BA4173339;
	Wed, 27 Mar 2024 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyKNWJWI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABC1173325;
	Wed, 27 Mar 2024 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542132; cv=none; b=V25dVImInTlufhO6oJRWIbu9FizTSVMNqlpydowi2GiEC13TvEB+GQhD/0JzVKW3xd+2BeLVea0OPyv62FJ6u4pRZOowuqAaMz+z6PL3EFqvnz2Cntin6oPbpGb/p8pzXKXYet4HKNzT+uApMtLsCgb5augRWyTfnMELU98jqyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542132; c=relaxed/simple;
	bh=xKwE2INfWzRggp/kxSxXal9blj+vpWlWTqyI0zRLyl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jdZhFneFkqfGJgWTAQfdt1Y2Uk77XRFhwNDXKEL6nuep5i57ly7F3LPR8naoFqlT4AKY9rsLQIknW6FEeL4PV38xWesghdN3wuFa9J5SWgY4+KYrzE3HIyPfNrE7FL4+RWvjTayb+rR/dOhbz9rRUjWcb63EQcsLCDRR3pZbQFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyKNWJWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A4DC433C7;
	Wed, 27 Mar 2024 12:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542132;
	bh=xKwE2INfWzRggp/kxSxXal9blj+vpWlWTqyI0zRLyl0=;
	h=From:To:Cc:Subject:Date:From;
	b=IyKNWJWIlnnugQvpgVATmIqiPrEA8tV6QJpPNzAgUx9dbs16fukw9ah/I76irlgIk
	 GL9fc6/3CCT8oYMK4xnI0wIStYHutNCxAWQKMMjdJc5MbWXD1tzq82iUuEUkbnxvI2
	 e2ttWlClhCs/aSJv++M7TToS5QknmRybvEJULMu8+9NyY2TZ57iSUa0bNLkwrE4Lby
	 8bCOl1oOwtyoPcIbar4kYjXu3wlAZSUg2R3LLoiujFwdvRACaMvWbUQAQATXYZvjqd
	 CEu+pwLJUL/h7Vq2xhJTS28dYPmFgJ/f+TvllsR+/lUOichs51BzWyyrEqpLwI9RdV
	 HeyKNUtvr7Aog==
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
Subject: FAILED: Patch "LoongArch: Change __my_cpu_offset definition to avoid mis-optimization" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:22:10 -0400
Message-ID: <20240327122210.2837487-1-sashal@kernel.org>
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

The patch below does not apply to the 5.4-stable tree.
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





