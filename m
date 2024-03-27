Return-Path: <linux-kernel+bounces-121198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD2088E3D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2595328D75D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC291836EF;
	Wed, 27 Mar 2024 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYKbZNc1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE4D1836E0;
	Wed, 27 Mar 2024 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542323; cv=none; b=p6gC08eN+UqkWNdFSdWa3w3uBV9ZpLK6BUYfvlaYCHPihwUScZTjlCRBAdyuSODnZs17XIutR4pZamNGlKn4kH1SZexgcSLTc6nJ+C/oTde3QSacGR07YFACrWl6ukRohv+ax9/cW+SSV2jWb9Tpx/SPSh86YQ7enYrk/xnKvIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542323; c=relaxed/simple;
	bh=fNuHaD+igTEh2V9ZsL9Jv5vHw8hQvqrYp0L7YbeWvnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YcYJKbQCiTPDBFtC4xZR5XEL8gEhsmhbmetQbRqIkyZIfIn4tct5U99BTrT1Pfg60oIbm+wXjfFzrMEAr298BJYrMyyDB7mQ39Xn+Bx6GoAi3kPASQiSY6IJm9uAkHklAa3trKeU+gDuVNaS+b0IfsRdS1S1GW4yzP5p1nPkSOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYKbZNc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DFDC43390;
	Wed, 27 Mar 2024 12:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542322;
	bh=fNuHaD+igTEh2V9ZsL9Jv5vHw8hQvqrYp0L7YbeWvnE=;
	h=From:To:Cc:Subject:Date:From;
	b=sYKbZNc1kwYDu2T69h1K1DgDiNh8LAm4lixj4EGqle28s4RGMPNAj2WbyZnEBBf+y
	 cAKsJoRP0caKO9GYA8ikSyvk0fvECNDsOJCphbz99M5D9HZhL9qJ+rokojp/wAxDoa
	 C+hV06GpRf2ca6wqg8V30dYsWBqLN7NqRP6NMpcktN5lsgZNCw0bq+HJeyEXswELQu
	 HlmwdpMN1E5QEAhONVEk6KlQlbFTpBggNk0A4igbzP/sXmMukXcAHKsjZSk1WXNdUw
	 glpENrBH8pGmCDX1zVueRsCKXk6C0ycD0YN0EwTD5MhpQ+OC2yGGYeEo5F0bfJ0rt0
	 plD0vaMC5bp9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	willy@infradead.org
Cc: Rik van Riel <riel@surriel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "bounds: support non-power-of-two CONFIG_NR_CPUS" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:25:20 -0400
Message-ID: <20240327122521.2840152-1-sashal@kernel.org>
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





