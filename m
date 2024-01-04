Return-Path: <linux-kernel+bounces-17155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4F88248FD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7508F2839F4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF312C1A9;
	Thu,  4 Jan 2024 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFVxLx6x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DE82C190
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704396414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LU9xUiegOmOumXh+8uek9l0bXHiL/GZWlaOpQEk79Lc=;
	b=JFVxLx6xGmn0TqlW/d56VpC3ga7n0zB/wxeEYDE4eLCfQZr9bMcNe8cShkx/muwqWmQivi
	eDsSSJdprZDHL0Er0iY+uQHCaOadtuipie4sVXLy0saJVMI5Gm77MV/EbNTRj4z4sIKhfO
	P7hC4Pw4MwurIxlVK5YclTOo9Daqkac=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-iKlctu1nOYqfr1YzwgWGZA-1; Thu, 04 Jan 2024 14:26:53 -0500
X-MC-Unique: iKlctu1nOYqfr1YzwgWGZA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-28cb44ab1cbso683788a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704396412; x=1705001212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LU9xUiegOmOumXh+8uek9l0bXHiL/GZWlaOpQEk79Lc=;
        b=fKaPzCXgdpbjBOB/jt/LC6QRe0WK1HIaYl2uYsXnCvU2tz8vixFcfTSwz51bQvfBbA
         etxL66UR6hP12cSYStHYoCaXZGxBACdCoqw2Tdxd97UjePIpKi7m6Y4OLRKmacvjfL8C
         xKXnwQ+BTtwjJ+qhJo/WaRdT7WsNI/xKMVFNWDL+L8aDvFz/Mx0JHa5PerlZRzA51U45
         KB5KsEEgwUM8wPeCwzyYouK8gwkACfgyf43++sqYyAM5WmqDrJnXWTQPB1C/6zgtWbyY
         xyaqH0NElWOR2Dpy8qbwZkUHX9WDl09XsxORRWzrDG1d5F2fiD/mCB8hVNhjA57WWTmW
         yykg==
X-Gm-Message-State: AOJu0YwVwBbBb60j9VIGpB4W6kEO1oU2DUX/MLoic0A7iCGkhiQpXUAZ
	tkneBGynvHX3THrTPUor1UDsFncje280W3KW7mQkBYUPosUcbYPYuD6Tx9e9auyA1qD9U+AwtGV
	9qS/cKAueYb/xl6JkXKHeM/+zf0CTMY+M
X-Received: by 2002:a17:90a:4708:b0:28b:201f:c2be with SMTP id h8-20020a17090a470800b0028b201fc2bemr847141pjg.62.1704396412251;
        Thu, 04 Jan 2024 11:26:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJpreyuJq8dxKbbb/Wzl6SoxUvTxzqpMMpKEY+xBSplOYzaauEFvo9gxkx+SWJIbNue18+FA==
X-Received: by 2002:a17:90a:4708:b0:28b:201f:c2be with SMTP id h8-20020a17090a470800b0028b201fc2bemr847133pjg.62.1704396411916;
        Thu, 04 Jan 2024 11:26:51 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:431:c7ec:3c39:8a36:75f0:8b6e:b898])
        by smtp.gmail.com with ESMTPSA id z7-20020a17090ab10700b0028c9349c79esm70063pjq.36.2024.01.04.11.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 11:26:51 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Teo Couprie Diaz <teo.coupriediaz@arm.com>,
	Leonardo Bras <leobras@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Guo Hui <guohui@uniontech.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 1/1] arm64: add compile-time test into is_compat_task()
Date: Thu,  4 Jan 2024 16:24:33 -0300
Message-ID: <20240104192433.109983-2-leobras@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently some parts of the codebase will test for CONFIG_COMPAT before
testing is_compat_task(), probably in order to avoid a run-time test into
the task structure, while other parts of codebase will just test even when
the option is not compiled in.

Since is_compat_task() is an inlined function, it would be helpful to add a
!CONFIG_COMPAT version of the helper, allowing compile-time optimization.

With this, the compiler is able to understand in build-time that
is_compat_task() will always return 0, and optimize-out some of the extra
code introduced by the option.

This allows optimizing-out code when the option is not selected, and
otherwise removing a lot #ifdefs that were introduced, making the code
more clean.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 arch/arm64/include/asm/compat.h | 5 +++++
 arch/arm64/kernel/ptrace.c      | 6 ++----
 arch/arm64/kernel/syscall.c     | 5 +----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index ae904a1ad5293..3cc61cbbb9062 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -100,6 +100,11 @@ long compat_arm_syscall(struct pt_regs *regs, int scno);
 
 #else /* !CONFIG_COMPAT */
 
+static inline int is_compat_task(void)
+{
+	return 0;
+}
+
 static inline int is_compat_thread(struct thread_info *thread)
 {
 	return 0;
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 20d7ef82de90a..9f8781f1fdfda 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -173,7 +173,6 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 	struct arch_hw_breakpoint *bkpt = counter_arch_bp(bp);
 	const char *desc = "Hardware breakpoint trap (ptrace)";
 
-#ifdef CONFIG_COMPAT
 	if (is_compat_task()) {
 		int si_errno = 0;
 		int i;
@@ -195,7 +194,7 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 						  desc);
 		return;
 	}
-#endif
+
 	arm64_force_sig_fault(SIGTRAP, TRAP_HWBKPT, bkpt->trigger, desc);
 }
 
@@ -2112,7 +2111,6 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 {
-#ifdef CONFIG_COMPAT
 	/*
 	 * Core dumping of 32-bit tasks or compat ptrace requests must use the
 	 * user_aarch32_view compatible with arm32. Native ptrace requests on
@@ -2123,7 +2121,7 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 		return &user_aarch32_view;
 	else if (is_compat_thread(task_thread_info(task)))
 		return &user_aarch32_ptrace_view;
-#endif
+
 	return &user_aarch64_view;
 }
 
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 9a70d9746b661..ad198262b9817 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -20,14 +20,11 @@ long sys_ni_syscall(void);
 
 static long do_ni_syscall(struct pt_regs *regs, int scno)
 {
-#ifdef CONFIG_COMPAT
-	long ret;
 	if (is_compat_task()) {
-		ret = compat_arm_syscall(regs, scno);
+		long ret = compat_arm_syscall(regs, scno);
 		if (ret != -ENOSYS)
 			return ret;
 	}
-#endif
 
 	return sys_ni_syscall();
 }
-- 
2.43.0


