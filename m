Return-Path: <linux-kernel+bounces-120966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE1588E10B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5701F2F6C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1837F15380E;
	Wed, 27 Mar 2024 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQiy30As"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBC2153830;
	Wed, 27 Mar 2024 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541719; cv=none; b=AjZytmSkJdjrW8wliqqcq4QWsa5oFPxGOcZezcC8eEQvrnG0wCTdZkcBYXP0JhwMy0hpoGY7PW5qHrKJufzWBXijIXT721dGpGKUuqsmJPN0e2KTbB51AK1xd7rahsS0cnxXehJ7Z8cjyMj9dOJ6CTDLsI2X98J1m9gYgaTnXNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541719; c=relaxed/simple;
	bh=4uVU4wn70eY5pwU3aJoqhGiWGcO4W6VpxdBgFZucCJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oXuxFwTdMlRayChk8aVb3o3YN1GqsBa121LZzNMGU/SnXDpOUmL/+n0JsecqwCcjXJ4AO6/8a1/eVqjOfC8Mi56C7vEMcnPhlIxNXBVVvH2HlQeMjySFFNVgPs0eVZjiCyTBzBuYeTPKULse6tq74XyJvjnfXATvEBlHQA500A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQiy30As; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE94C433F1;
	Wed, 27 Mar 2024 12:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541718;
	bh=4uVU4wn70eY5pwU3aJoqhGiWGcO4W6VpxdBgFZucCJc=;
	h=From:To:Cc:Subject:Date:From;
	b=hQiy30AsC0rVH+L+AwFPJyBV0uKaC3ziwvcd3OQUrlaDfIEZKbE3hyLtinM0Hf7hi
	 L6TdwkiVFbA7K78sQ4kihcsZk+s2Vs8bXVQ+pX9kYp74atNi9wiQLqgdA+/xcgBhEu
	 HzX2vQzXjOo3S7GR9Ee90wRzcS8zuKezV5NTryoDQGkCyyLf88KSACQLtnrpMBUOiU
	 NQen1FPyaPIC9Lbssw8Y6AXIKPkE1X6kvoGFxAaMHTCWw9NozhmFP+UB4Bf3hU2fZv
	 jKPyEgOKgVxcmfWk1GZxMzVF2Wa7ueLuUVy+IMY8c9zANLc+c59asuw2QugrEM9LQ2
	 DmBZTOvRmlTxg==
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
Subject: FAILED: Patch "LoongArch: Change __my_cpu_offset definition to avoid mis-optimization" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:15:16 -0400
Message-ID: <20240327121516.2831778-1-sashal@kernel.org>
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





