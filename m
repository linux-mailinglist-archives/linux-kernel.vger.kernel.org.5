Return-Path: <linux-kernel+bounces-121059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C200088E1F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0006B1C2A265
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA2315FA6E;
	Wed, 27 Mar 2024 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl10Rivr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A3513AD08;
	Wed, 27 Mar 2024 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541969; cv=none; b=MfpZXroBn5ReSDPiHWqilBJ6ETud5p4owrIASEYCt1br+qMyfpu316STOATeqddp97H5x1sv0XoKmlQEekDbfPI50i6fVPq8iMkQsxaXXyRLKuJtQy4SEgqehFw9sE5DxB58uo3K3ccgFpOZEToWiHYPLdYSKZ5Cq9Pg51j23SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541969; c=relaxed/simple;
	bh=tt8eU4VUfuIPZHdt++uGx7KknR4yhi/5oRxH0qFL6wU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=geplRtcsoYnEHDStbRBCPnvaCRCxmDTR/xy7GQs9A7Y8vw79KM+DRJ3LdyM/Q71Gq0bd/UdF/Y5ZEUvmvR9l8E9/vTf1uCMrhAiZ6fhz1ncGOXJwpwLPfsKhMlW02v7R6kVheUWEQKM4DHZknqNU+YcyDH5dKipDThI58Fy9Luc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hl10Rivr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A4AC433C7;
	Wed, 27 Mar 2024 12:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541969;
	bh=tt8eU4VUfuIPZHdt++uGx7KknR4yhi/5oRxH0qFL6wU=;
	h=From:To:Cc:Subject:Date:From;
	b=Hl10RivrK0UO2jNeUl8nyJCh28iKoyaj1ts6qaXETWi54G/fMYQF8bQIgXPFtc1w+
	 3tZak36C1vweMXoV8PYcGzfbADa50Ntd0Fzj0a0IEM8CJKe1T77YWzg4jxxbBbbSbX
	 qCqQU321dsH+RJVMYa1Tu25xfNGorjJK+MmI5UQ5E6FVIwlO/Jn6XjokQeM7DxggFp
	 bwarI25JRYIbYOxn+fdB5AyvM+as5k8TGRagm+ysKjQqfn8wmtH4NBVeLz/OWQp9qF
	 iWvd1SOCNUwSkvuq5QpzUD35PmMw2j+s7rbeevTHee517eLS+wvGo44GVVJDAMDXl4
	 PO4hITrit5nXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "powerpc/smp: Adjust nr_cpu_ids to cover all threads of a core" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:19:27 -0400
Message-ID: <20240327121927.2835195-1-sashal@kernel.org>
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





