Return-Path: <linux-kernel+bounces-120985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F9D88E13B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDF21F2C906
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CCE15667A;
	Wed, 27 Mar 2024 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyhaN+Lz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6250D15666B;
	Wed, 27 Mar 2024 12:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541767; cv=none; b=WwSz0gOCQSfypnn5zZXCq4WC011VOsrh+/XqUlMPolFJuUWL8Hak5itUL8ieOALOM53Tog16DzDTbyui+52xc0AXmx+eW9Ong0uudwmJ3qTKefW8MJ56Z7eI5flMapCLxxcVLwRJTAGfvZzQnpS+HNT1RA1+imgiejc91P3lYMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541767; c=relaxed/simple;
	bh=fe6XZGzRKfy7XqVYnGt6KUez//5L8jzE9WJfPWrvDd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oYOSxe/AC3aW6JZKHXa4K67dyfWnfgMSZ4r6cuEL1FFnotNHquZ5rZXcPw/Fe0e69YL1NFXugTp4hOpoxhLv0yxLPjlT4dTCXHVElIn9fqx/XHuL3vlPbiSjEbySJIn23IZDuwqos2wjLODmNwv06SqdKnAPynqgov7MNvs9lBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyhaN+Lz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C081C433C7;
	Wed, 27 Mar 2024 12:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541767;
	bh=fe6XZGzRKfy7XqVYnGt6KUez//5L8jzE9WJfPWrvDd4=;
	h=From:To:Cc:Subject:Date:From;
	b=TyhaN+Lz2Ohpg3Qvw9JqCt9Z22LdFHeTNSRqXlLa1vUjDYjsqCcddOui3wLVXjEN7
	 lHnyO1KZNWzE2Or/4/K0vcGk7DIx2/bB40AvFT5wWeGnYK3Z1ezgWnFSCSwtRJusT8
	 vd2LOshoKmAZFey2jJYR7+6+NR4lMgnXgw76Juf4NWes+fEndQVbFZDAFDc2crj63l
	 b/MUCIA0eHPK/zZhD7LFLADbPMr4YS7ymGBoIpEvJVGkLI6nN4yiRvKFvkq/8OiBum
	 H3Uh7JTOncrzNM+Dbb6Jr6YA2QhTOORCT5y5OMv4oduO43tuGUCLz2yl7M0EQqQ7Zc
	 S9c1loe/Vv0Pg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "powerpc/smp: Adjust nr_cpu_ids to cover all threads of a core" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:16:05 -0400
Message-ID: <20240327121605.2832425-1-sashal@kernel.org>
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





