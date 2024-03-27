Return-Path: <linux-kernel+bounces-121215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D6588E404
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72EEB1C26756
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFE1188A92;
	Wed, 27 Mar 2024 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pndfjFgI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51973189230;
	Wed, 27 Mar 2024 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542368; cv=none; b=axeCa3I7HcCH5JDX/MtZ4os2qg3r1qUm/DciJHegdeSp14bYSTr/rvoGFkzKMdTxEnsMxzTQY1FXe5EtXE/cTLQk4H2Nhjs9HWzSXPe2nvgKXF1J93F8RX+jGgKid8TRkK0cbGJihMva2WMnWsz44lKAguGBsoqjo7gZvPoj06E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542368; c=relaxed/simple;
	bh=qvXQSEn5whP5t5iuOJVE8A2AEXm8u2LzZ9Zug0KkhLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VMrI5AyWoUvlbEpmVHTEUXTIT1i5UmGXwx/iDLfS+NXeez8RB2ZOf8NiS0p2NRe8itLjT4CsNuZZGjBNUetXKpTPHx4MhgcD7sH2j3+QrZxAaXV3cry0WEk+FlLyLMeUVKd73TwVX7+dZPbgEm6iPb0RNeQOLGuGLPk9IHaSu60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pndfjFgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E0FC433F1;
	Wed, 27 Mar 2024 12:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542367;
	bh=qvXQSEn5whP5t5iuOJVE8A2AEXm8u2LzZ9Zug0KkhLo=;
	h=From:To:Cc:Subject:Date:From;
	b=pndfjFgId/M/IRVVCWuIQXbNEGJPMKOTyCHXn42eAtAGn3cARUzH1MdpCzmXavHMZ
	 jJVLyaSK5JkNlyYvDBYm3zWGOZgf7j1Llk2Tz+1TvutY8B/pBDeYiMFbsI1z/zhuGT
	 Lhc5Wd35Snr9YEGpvWaYxGicXavVaUC2y1m4kFc/Lt8aZlrBOXTk4VZoooFjz+H5r2
	 gR/XpbXYiNALT9xwmS1DzXUYvAJ8UXMiruKCspdqOjC245RnZFn508oLDrTHlO4cIJ
	 /2xQcUoFltzxvUf4xnzKDUc/xQwKtEl5gPjcUheTU5i/41TmkSrrHIWAp2NOLcjnCJ
	 OGZTXcn+6QqZQ==
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
Subject: FAILED: Patch "LoongArch: Change __my_cpu_offset definition to avoid mis-optimization" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:26:05 -0400
Message-ID: <20240327122605.2840815-1-sashal@kernel.org>
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





