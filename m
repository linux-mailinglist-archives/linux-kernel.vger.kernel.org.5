Return-Path: <linux-kernel+bounces-121103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80B488E260
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A8B298D81
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0322A1703AB;
	Wed, 27 Mar 2024 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHq9L0O5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477B613B7A4;
	Wed, 27 Mar 2024 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542087; cv=none; b=RgyREQ/nopiTfIO/uXCCX+lustPy8K5VcD8a58fpWdMx//tRImO3GuVgzkp0DX2ikb0V8gvzzgLbOQd+gqatEvUaVFdKCNa07XyTabsNK7episY0aEvBazcSWFTQysCKXKW9LQb7cNCluibWRQYHqe3gbLE3bWVUcTphWcUYrFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542087; c=relaxed/simple;
	bh=i7LxVuQ3soT04MoMpPwzwpi44u034c9RglpD/f//odk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QQ1t3yCQ0IEqD+S/Wo+S6vAPnTdx7XCk1J0R2rmSfZQFpod/M+m7ifsqCm8LDDPOGHwUIusGfg4MpCbf40RhZX901L+WflROiJesiCZ7vVJI/U+/qyCuoH9+B15ml/Z9raRj+wgISlycvU1ybxWUZSdJZdrIDHM5Hux04yoUmeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHq9L0O5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D15C433F1;
	Wed, 27 Mar 2024 12:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542087;
	bh=i7LxVuQ3soT04MoMpPwzwpi44u034c9RglpD/f//odk=;
	h=From:To:Cc:Subject:Date:From;
	b=PHq9L0O5eBNyyzS646Y26GghhTVKZJLS56b9O5cqJcKekMKBJELfSgWolXPjw2siu
	 RpPGhetEzOUhYuZp2rc3CIEukJ9baX2qjtDhroUc+CeQ1Fedmo18Aw08ucS6PyAVBQ
	 h2fOVtEoeldvgh1vCRydsJoiIeyePOTU1L6bvxcs65K0n8IZmmqy2ZuFjBA5JNSwG0
	 PaH0RpFj27Bs3zvsPQ+8oNDW2FUSbutlYqoVyf2sfwz+6nlVg8t9yVo1v+wKW6cgcf
	 wyZuIXgfGfzvgo/PVLWyFbe3VyYY/l/V3LDgDyxXDMVulIF7HrYtKXzzZ9xn+rYaBj
	 UAgxTVx8WvwOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	willy@infradead.org
Cc: Rik van Riel <riel@surriel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "bounds: support non-power-of-two CONFIG_NR_CPUS" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:21:25 -0400
Message-ID: <20240327122125.2836828-1-sashal@kernel.org>
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

From f2d5dcb48f7ba9e3ff249d58fc1fa963d374e66a Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Tue, 10 Oct 2023 15:55:49 +0100
Subject: [PATCH] bounds: support non-power-of-two CONFIG_NR_CPUS

ilog2() rounds down, so for example when PowerPC 85xx sets CONFIG_NR_CPUS
to 24, we will only allocate 4 bits to store the number of CPUs instead of
5.  Use bits_per() instead, which rounds up.  Found by code inspection.
The effect of this would probably be a misaccounting when doing NUMA
balancing, so to a user, it would only be a performance penalty.  The
effects may be more wide-spread; it's hard to tell.

Link: https://lkml.kernel.org/r/20231010145549.1244748-1-willy@infradead.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Fixes: 90572890d202 ("mm: numa: Change page last {nid,pid} into {cpu,pid}")
Reviewed-by: Rik van Riel <riel@surriel.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 kernel/bounds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bounds.c b/kernel/bounds.c
index b529182e8b04f..c5a9fcd2d6228 100644
--- a/kernel/bounds.c
+++ b/kernel/bounds.c
@@ -19,7 +19,7 @@ int main(void)
 	DEFINE(NR_PAGEFLAGS, __NR_PAGEFLAGS);
 	DEFINE(MAX_NR_ZONES, __MAX_NR_ZONES);
 #ifdef CONFIG_SMP
-	DEFINE(NR_CPUS_BITS, ilog2(CONFIG_NR_CPUS));
+	DEFINE(NR_CPUS_BITS, bits_per(CONFIG_NR_CPUS));
 #endif
 	DEFINE(SPINLOCK_SIZE, sizeof(spinlock_t));
 #ifdef CONFIG_LRU_GEN
-- 
2.43.0





