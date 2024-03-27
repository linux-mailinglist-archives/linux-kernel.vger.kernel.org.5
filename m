Return-Path: <linux-kernel+bounces-121234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CECA488E43A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0EA1C2B9F4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8FC190666;
	Wed, 27 Mar 2024 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HB97qICw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864BB18E0FA;
	Wed, 27 Mar 2024 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542419; cv=none; b=qtI9ZtJ0CvDrAPu/4q3X8pHwk16uiJlkG6wWj3O6/uOPKVkUNj0lWXnzCkqMnU4/J+iySFAy2n1tLeWPlgS69NPcwb37cNdx5x8GUet1oxv1qHb2KBvY3y77zMH83hKrvG/hr8W5bG4ET/rZnmLFcJPZErnorWzXWdqnYE5tpWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542419; c=relaxed/simple;
	bh=8NhS7JGHxVGwkgrVjypWptU1sVKwxSktK2N7rWjKNSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZBm148lecBWwA9fmG4OBoPrMXA0zjv6hjwBBXKTY0E8rdIQEVeUaMuqHRApjdhd06q2NnZ53v0PQXDZBJuCYOjDtU2VR548kZlGxOge5HEhiObNkwQH/iSbO4KuabXBACjzGe/j0iq3xCnaRUYsia70rbtZ/1d53dIHjwhHWVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HB97qICw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9C4C43390;
	Wed, 27 Mar 2024 12:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542419;
	bh=8NhS7JGHxVGwkgrVjypWptU1sVKwxSktK2N7rWjKNSg=;
	h=From:To:Cc:Subject:Date:From;
	b=HB97qICwofolrPISGA9xkKckVVYeQBGFT9D8SOiyit6jTp04QDrG5TXFYFjT23lvG
	 cX7oCG+2KtjmhFLX7FTsQW7mkgIROhI24AZnYY63Plesz3zt7ofL3APlEuWW4dhyuR
	 wBlcjR0LPSLhUZTthD51e5HSjj8wpV7ciJWQRNK5Su5epCbK3/YzFPQjUaLVffb2bz
	 sRuLDlXSdd+dk/DfYeWaVL1E42yKGT/9BqqMkDtzuFq7LLz++8OL2agAx4OwAuQhvo
	 cXksBzWjuNaabpqC//GxufUBRlTfxiXX4kgCVQb+ql02F/u+zK4+xQ4oEsxQpr5SoT
	 MURqRsqj8ying==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "powerpc/smp: Adjust nr_cpu_ids to cover all threads of a core" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:26:57 -0400
Message-ID: <20240327122657.2841493-1-sashal@kernel.org>
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

From 5580e96dad5a439d561d9648ffcbccb739c2a120 Mon Sep 17 00:00:00 2001
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 15 Feb 2024 00:14:04 +1100
Subject: [PATCH] powerpc/smp: Adjust nr_cpu_ids to cover all threads of a core

If nr_cpu_ids is too low to include at least all the threads of a single
core adjust nr_cpu_ids upwards. This avoids triggering odd bugs in code
that assumes all threads of a core are available.

Cc: stable@vger.kernel.org
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231229120107.2281153-1-mpe@ellerman.id.au
---
 arch/powerpc/kernel/prom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 0b5878c3125b1..58e80076bed5c 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -375,6 +375,12 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	if (IS_ENABLED(CONFIG_PPC64))
 		boot_cpu_hwid = be32_to_cpu(intserv[found_thread]);
 
+	if (nr_cpu_ids % nthreads != 0) {
+		set_nr_cpu_ids(ALIGN(nr_cpu_ids, nthreads));
+		pr_warn("nr_cpu_ids was not a multiple of threads_per_core, adjusted to %d\n",
+			nr_cpu_ids);
+	}
+
 	/*
 	 * PAPR defines "logical" PVR values for cpus that
 	 * meet various levels of the architecture:
-- 
2.43.0





