Return-Path: <linux-kernel+bounces-121062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B7D88E1FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013BE1F2E00A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54C915FD0F;
	Wed, 27 Mar 2024 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fspxh4aX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D765715FD00;
	Wed, 27 Mar 2024 12:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541977; cv=none; b=LXtXIVMdiyNGbLOUYlOq96n4guQ1BnsFkktd1G3m5vMDNP0um2llkdIFfWOfv8QPE9IqvPwj431I4I0nQsEjVI5MUXdyG3f3EhvxqU9nsQCtuZSbZkBirbA0g9EUYiXxCOgW66jvwnTugxkjFYGrmBShNIem29/C3p6eND9LhlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541977; c=relaxed/simple;
	bh=GsRPpKxOMToQRVoKkukbsS+8ZQPqObxQNquJ7NUTJZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JSgqQ0rTCG9Ais/KS+Vf+2f79QZoWISh7Ewa4Taqy3FH2tZ6t7z4PMH8w517c1jupjG69x0OxPF7vzsJsVOfP6ddCR0KDx4AdtM26TJfDjEKruY/X7J3oONLlL0dHAgIrC/E4f0j26/pRvptMYok72hzKZBNlbkh4daQSbVYxUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fspxh4aX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99BFC433C7;
	Wed, 27 Mar 2024 12:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541977;
	bh=GsRPpKxOMToQRVoKkukbsS+8ZQPqObxQNquJ7NUTJZQ=;
	h=From:To:Cc:Subject:Date:From;
	b=fspxh4aX3gB8rtjCugJSAfa3WChKIGp1u4UI3WKLNs/glbk34ete6FAia7AiTjhOZ
	 sPY00ZQqR92hXPWWpMag6VyXQeqGvWa2BWRQ3LY6kkVHu4CrMhEHpRKCKHftXJ9ghe
	 jjEDNcnj3Sk59eN36gqv/KJ0WBIgrlwBzFjZlyVKmmL3KOLAWZqJGvzNWhrCXNLaf0
	 omptx3MM01khJ0RuWsy7UwOKLxrtNnuXoci2g7y7472BR+4XoxAZNstsdmYYA4sBGA
	 v6g945B8xyFb5i3cZQs7Qgm0rEbKBhfL+oePRYgxm/yCieVfOjJ5qj2mqhIF4++4ur
	 ncX+ZQJH6JW4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "powerpc/smp: Increase nr_cpu_ids to include the boot CPU" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:19:35 -0400
Message-ID: <20240327121936.2835310-1-sashal@kernel.org>
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

From 777f81f0a9c780a6443bcf2c7785f0cc2e87c1ef Mon Sep 17 00:00:00 2001
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 15 Feb 2024 00:14:04 +1100
Subject: [PATCH] powerpc/smp: Increase nr_cpu_ids to include the boot CPU

If nr_cpu_ids is too low to include the boot CPU adjust nr_cpu_ids
upward. Otherwise the kernel will BUG when trying to allocate a paca
for the boot CPU and fail to boot.

Cc: stable@vger.kernel.org
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231229120107.2281153-2-mpe@ellerman.id.au
---
 arch/powerpc/kernel/prom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 58e80076bed5c..77364729a1b61 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -381,6 +381,12 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 			nr_cpu_ids);
 	}
 
+	if (boot_cpuid >= nr_cpu_ids) {
+		set_nr_cpu_ids(min(CONFIG_NR_CPUS, ALIGN(boot_cpuid + 1, nthreads)));
+		pr_warn("Boot CPU %d >= nr_cpu_ids, adjusted nr_cpu_ids to %d\n",
+			boot_cpuid, nr_cpu_ids);
+	}
+
 	/*
 	 * PAPR defines "logical" PVR values for cpus that
 	 * meet various levels of the architecture:
-- 
2.43.0





