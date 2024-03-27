Return-Path: <linux-kernel+bounces-121141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CF588E2C3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D7F1F29C15
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CD01769F3;
	Wed, 27 Mar 2024 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEgwdRJI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DB313D240;
	Wed, 27 Mar 2024 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542187; cv=none; b=Fjqmivv0EAlDWtVKRzhjcPIo5xqH8abT+bhOJjtO7ALJFTYOKnXct3DIpjEZv//+vh8IgwF2h50/vwhLc96YO2mof7OmcPMoaSqJRDak87PqDa2sjwOUJZx1CJnvGdxE4YY2vA6ytMnqsEmIdzuH8XwSvoNN6bWOL09G62lXVLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542187; c=relaxed/simple;
	bh=7WUZ1d/ku/+h64bWNTnKi1virdbtMGAgWxKVamGW9Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qgivGbrwCUQdHLusIg01oAQiNDHYpgrjCsiZ7SQGtOFQIq86kgdU6bdHiqX/7pSWQUg50FR/6aWmfjWQ2+8tewMBLm2Btjra1e7OfBQ8T77+4NY84VkgR1BmGnRmH+bsv4HTpfh1DsqPX1/sdIfCK7F4VjI7Nzh0Jvpd7pG0Gco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEgwdRJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E06C43394;
	Wed, 27 Mar 2024 12:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542187;
	bh=7WUZ1d/ku/+h64bWNTnKi1virdbtMGAgWxKVamGW9Zs=;
	h=From:To:Cc:Subject:Date:From;
	b=bEgwdRJIxbGOZItywu5yB7VmJ9Y62xGigC1624f5YLXBMcEOQWXWWXzN9ILSzjqnx
	 C3CyEV/Uo1ZxnlmkJrqmu9GTTjkoSzc4+3NZI3qCj/zSlI2YoNECjkR1ydI6vaHxNE
	 TKSg35CO3Gk1+kewgz6aCThNF9msYeWZwQ1NMNg7UELffE9i2q23sdlrhO9x4RU9mj
	 PKO/14q+pR0U6sbNbN+2u7eHwIZW7l/w7JD8D8EG7Osqi81GiQX+PsFAzkPNwgGIDp
	 UuPCvyO4sQN/DRj+kK+WtEgO/WdSTLUDrO40k8RL8mL3/aGpGhIfXvX6JfpxckWOxY
	 QdANPpd43QuFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "powerpc/smp: Adjust nr_cpu_ids to cover all threads of a core" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:23:05 -0400
Message-ID: <20240327122305.2838208-1-sashal@kernel.org>
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





