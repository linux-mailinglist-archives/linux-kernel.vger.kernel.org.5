Return-Path: <linux-kernel+bounces-104479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C408A87CE7A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A997282189
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9EF36AF0;
	Fri, 15 Mar 2024 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqJBuRNF"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A0328E3C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710511497; cv=none; b=H9IyYrmU/UP+Jt7RYSPrueUGFYImUXNn4XXxmXY3PQ8iJNxh97sA0sBFDCmCnCaEU6i90UgoqaV7AfE45NqeDNO7jx179ViwuuMGcO8p66fEprJmFCz/nuNzSrZIXCEjGpdfpV5qin+AeptVh/Z89gUcMxQp4gbhx43jRTYlYRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710511497; c=relaxed/simple;
	bh=xpVHja1Gl/vSjiNwdPui/lZWoKGYHGfBo8HaZ00hbso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MWCbeokBqlfISTLXOtE5ySvysqdYwvc+9+qCuP+m6nhcIHqobn+tdkAHKpDBdjBcHOYa9PTW6Z2AdJgYBOOQ3Lsw9fladYTiyS1+HS/gy2+ngVlyt0sJFZk+PkgwB8p0Y6Rqu1WwQ0Wv7cnxN/RA/Sct9M2zFCNFEhz3CA16LUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqJBuRNF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6cadfffdbso1865493b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 07:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710511496; x=1711116296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hp8hpHq4FUWj9bHt9euKC/gRJiJ20RTqRC6iqHY4SXE=;
        b=PqJBuRNFGybw6pRZpMduoGna99iqgRqFv4QJr8+j2GL2gar96ZOsNK268Q4/B/dtBf
         M7QHNQHIMgxaL8bIYcyKcOMZTXjx+GklPCsapOC5aKzwZX2cknXylXiorgyD9I1zoZsJ
         rlrmgEo7qVY1zWBrQi4OjGGaFo1Gq9Q6F7UXLclhcesGqpsmn1Qv8xZDwWCEm4wYZodA
         s+FvZCBXEBcnHg5MjCvveBsD0RxyaNq07btuVu3/BIYyKhBIpAhizz2br4BptRP/RBBU
         arLQy7j6+S3fe4vQq5LoylBXpoc3PKmilqKuwOkeaLNj5F/sVw72WZKjbctuJEQvn4hH
         SKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710511496; x=1711116296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hp8hpHq4FUWj9bHt9euKC/gRJiJ20RTqRC6iqHY4SXE=;
        b=gf5ZyxhIdA0LPibOLP5woMhTvOwtsnhKyDqp6Q/ueA5ekFnfmrGNKEx/+kmgbE4Jrn
         jaDS7FK9H2FRHuhxq2dgLFtbLGN6Q8SYgPX2OxQ2Mnx1J7V9UVL2EplyE6obDVHASNF0
         JbfcxmvF74vePdwA3fEIrwzsRUWkOXSPjfKoH8U3GRxUUm4CA+GlMPvFRDdqPHOQentT
         KpizwZMhPGZ0S9wVdB9yVlIrKOB89fZ+zy+r6KX9LtAncq/6c4NCniz2al91rtcIQmlp
         2YKjNrh3lq0GbTSF4zjO4Dcw5xitSVsTxIitv1kuZ+/yV9s+TC2HClg90kr3sE5HHW3m
         QYVQ==
X-Gm-Message-State: AOJu0YxVhA0GCfOI0jlqQ8/0aFHNv5R3NM8ztxuRklbCSJftvoAvD8Mn
	zHr21ThRT4nvkVwfQhL3bdhKQFquCJHTOganvE8I2O/Pa8XeUqanJxaYaV6/
X-Google-Smtp-Source: AGHT+IFHOP4EmKlqaIrrsbvc+pT/fEV3RnkBQcfhUSrX7rPQE7LM0+h8+jSumKyH3rjxpR27Bcc6Hg==
X-Received: by 2002:a05:6a20:7d8d:b0:1a3:539a:f532 with SMTP id v13-20020a056a207d8d00b001a3539af532mr177230pzj.14.1710511495674;
        Fri, 15 Mar 2024 07:04:55 -0700 (PDT)
Received: from gnu-cfl-3.localdomain ([172.58.89.72])
        by smtp.gmail.com with ESMTPSA id lb8-20020a056a004f0800b006e5360f1cffsm3431042pfb.180.2024.03.15.07.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 07:04:55 -0700 (PDT)
Received: from gnu-cfl-3.. (localhost [IPv6:::1])
	by gnu-cfl-3.localdomain (Postfix) with ESMTP id A00AD7401F8;
	Fri, 15 Mar 2024 07:04:53 -0700 (PDT)
From: "H.J. Lu" <hjl.tools@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH] x86/shstk: Enable shadow stack for x32
Date: Fri, 15 Mar 2024 07:04:33 -0700
Message-ID: <20240315140433.1966543-1-hjl.tools@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. Add shadow stack support to x32 signal.
2. Use the 64-bit map_shadow_stack syscall for x32.
3. Set up shadow stack for x32.

Tested with shadow stack enabled x32 glibc on Intel Tiger Lake.

Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Tested-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
---
 arch/x86/entry/syscalls/syscall_64.tbl | 2 +-
 arch/x86/kernel/shstk.c                | 4 ++--
 arch/x86/kernel/signal_64.c            | 6 ++++++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 7e8d46f4147f..cc78226ffc35 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -374,7 +374,7 @@
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
 451	common	cachestat		sys_cachestat
 452	common	fchmodat2		sys_fchmodat2
-453	64	map_shadow_stack	sys_map_shadow_stack
+453	common	map_shadow_stack	sys_map_shadow_stack
 454	common	futex_wake		sys_futex_wake
 455	common	futex_wait		sys_futex_wait
 456	common	futex_requeue		sys_futex_requeue
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 59e15dd8d0f8..6f1e9883f074 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -163,8 +163,8 @@ static int shstk_setup(void)
 	if (features_enabled(ARCH_SHSTK_SHSTK))
 		return 0;
 
-	/* Also not supported for 32 bit and x32 */
-	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) || in_32bit_syscall())
+	/* Also not supported for 32 bit */
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) || in_ia32_syscall())
 		return -EOPNOTSUPP;
 
 	size = adjust_shstk_size(0);
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index 23d8aaf8d9fd..8a94053c5444 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -315,6 +315,9 @@ int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 
 	uc_flags = frame_uc_flags(regs);
 
+	if (setup_signal_shadow_stack(ksig))
+		return -EFAULT;
+
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
@@ -377,6 +380,9 @@ COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
 	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
 		goto badframe;
 
+	if (restore_signal_shadow_stack())
+		goto badframe;
+
 	if (compat_restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
-- 
2.44.0


