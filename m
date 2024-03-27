Return-Path: <linux-kernel+bounces-121237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C0C88E442
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3703C1F2EF45
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EE9194C8A;
	Wed, 27 Mar 2024 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwRuBxtI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB7F194C7F;
	Wed, 27 Mar 2024 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542427; cv=none; b=MeNo5mmvXhrXNTTC9wbQ+zig6BgqX96/siKTwkQY3OKGQGtP5MD8YP9cqbk5qFJf83QvJjUzInVnq7yChzNGon36PjOeiGgLb1djXuNUI5KfvE2nTUMpaTLEbhVxXvTooVWnCyb33N1Y092g7aX50I+C1ExPcId7H/kN20vuKSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542427; c=relaxed/simple;
	bh=4sDGNKX5Hp0TePoMEyx9m/KMj7fFOesGUA2YYjKPB2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y4m1U/IkmdasSt0k4CDoY3LNj/6Q4EnT3H/e5Dq5B1q9gVYTt8cLeM7uB/iEQm9wYNw4V0u/TcEN3NGsyat2hYILFwAJU93/YGFdBk5HeKh2jTLrUVyH4gXoQoYGXTKg461ITefORj9R8TMX6TKicQWpnXfvdoWY7uP4H2gRJVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwRuBxtI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF97C433F1;
	Wed, 27 Mar 2024 12:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542426;
	bh=4sDGNKX5Hp0TePoMEyx9m/KMj7fFOesGUA2YYjKPB2A=;
	h=From:To:Cc:Subject:Date:From;
	b=YwRuBxtI41KTA8zE94rt5bGJlNmqNDO8bWtDXBrFOGIzO0ZxR5zf1NFLfM5MrLppP
	 Yfr9RM+kiunJErfOOHnNQV/jD8xhE+Lkifn324sen+D5AmndsARuKgnKqK0sJ0MX/B
	 rQAHCuAGQxuFHfBhmSe7uxKbXukaJdgv/OWiyvb1FegRvHAPOR4kRT1gu51oIujNuZ
	 7bK2yWabr0miAYtTs9Vb/bC+vHlcbeP89ZPRSoUn+xtNgwlJQaw9JEzz6NcoPtbEUz
	 vdpgggaY7SXCumKCPhDuI00LB2eEf1hsZ1W8hd3a2LQ8uVzTXL/GNC5W7mbp0bZH1u
	 ZtS4M8TQlgHcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "powerpc/smp: Increase nr_cpu_ids to include the boot CPU" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:27:05 -0400
Message-ID: <20240327122705.2841610-1-sashal@kernel.org>
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





