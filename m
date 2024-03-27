Return-Path: <linux-kernel+bounces-120988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BD088E145
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088151F27397
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C1915697A;
	Wed, 27 Mar 2024 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSje7bpY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797B715696A;
	Wed, 27 Mar 2024 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541775; cv=none; b=dsiFQpz0hbqzcSiBCTMTeppnnKjYVVLgF3lwVS3nKN47hsHp8jd3yGGmL9Bo587McqHWqfOLAuoPnjMZAi5lb+dIFeShsbW5wLEr4lCFAodkOA7/fjxI7n9kn8gyXnj75vM8wD9/BHBLWM2elRlBNtp6khx1srjto/OktiF2tDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541775; c=relaxed/simple;
	bh=RpBJig541+cUy7MA1hFz4xdyhriuScmF/9i/Y04N+nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EqU5DSZQSoQINAXd5mJPl+7XcXZgTyWQBo/mF9ACszXaLXrip91+kUmS+wfVNVYQ9JVM5CkGUE9GskoRMjPm5cRPUVWQwDXThcP3DBS+SLM+fJ2xoTRzr7Zh/3ezCHqYyg+u+xjH3/rJGjlR5y3oj45MrP0EEl4orstY2/AOTNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSje7bpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACA1C433C7;
	Wed, 27 Mar 2024 12:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541775;
	bh=RpBJig541+cUy7MA1hFz4xdyhriuScmF/9i/Y04N+nQ=;
	h=From:To:Cc:Subject:Date:From;
	b=HSje7bpY2dRJVvhp8l5Vi++NdPelwxmZlD4A5ys/NxwEOIzkjM4P6o9FbtiMVzcjh
	 kUiqF8Fjn+z9HVFRt8GkXLpvUTraqdO+kOT8MHY9CNoUUXZJ/aGcobKZ7PNWQyF024
	 JRE0mGBXe4FSTqm07aoOHgxxSG2jeEa6rx6sj7LgxQ8A1geOPh/or+LvYx4V4X1CfZ
	 scZ3/vQCMqCWURv8tkZJPXCiIa6ojFwvd78jP8Mx9nO61jd9PmCcEPiOwUR0GsS99D
	 kO2pcivt2EzTvJeBGK0leGk+yTBtMAhBoMM+Zx7CvKN5N8mfHTLR3ar/kT2l9CzWXP
	 EpfeCn00SmA8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "powerpc/smp: Increase nr_cpu_ids to include the boot CPU" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:16:13 -0400
Message-ID: <20240327121613.2832541-1-sashal@kernel.org>
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





