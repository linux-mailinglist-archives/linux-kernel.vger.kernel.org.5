Return-Path: <linux-kernel+bounces-17466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B776D824D9A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 05:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B311F22674
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 04:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67D05243;
	Fri,  5 Jan 2024 04:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7LDz2On"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C595225
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 04:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704428276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3wBtvd8AcUa+3WyzFrFiVlLy0PPCAnv0pduZK21JO48=;
	b=D7LDz2OntocsgwDidf+YsLjGpfK3+qZHeIyU9OBoA4fNng9uQ0pxmdcA7EYi62an4iEzn+
	c20l9DlTCRMMGX45OfWZMjOt+NuefhJQtaAvw+m13uUeNhPLvEcoJje5q//v9fujGnfOEv
	E7Y3TSD3iwKSkN5OAlbTJxAuReNzWAo=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-D34ut3twO6GfGwE1G3ifDA-1; Thu, 04 Jan 2024 23:17:54 -0500
X-MC-Unique: D34ut3twO6GfGwE1G3ifDA-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6d9dfc1fc38so203427b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 20:17:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704428273; x=1705033073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wBtvd8AcUa+3WyzFrFiVlLy0PPCAnv0pduZK21JO48=;
        b=OsnNCaWMrEv1R2kkh94294tfedSpiE0fXbWMPjpwG4pW2a69iF6Yh9cznEcK8O3O4z
         2dekSziuZ+P06esmJTYN11UlnLr6rw1roR9Rh3fqNIk/8M/dRRqIpjYFLFrjBHcJg/51
         OQStJuL1wDJyYBlIWzVI/Ue7xZytBrA1sC/3fr8sHIDxAJsDod1EVPwfGdL6GCalZuCg
         aijDCpPU5oNbXK40hZpW1CWnUn2oB94X5G+iuoGGIqI06/252UCQr0j6qzfiZxQKdGsv
         srphhXYcRQL/FZZcq3qq/xg/IWSZRx1onfeDdyr9IGpkdbJ7vWDNm459QRrIuD4STPtF
         TDuQ==
X-Gm-Message-State: AOJu0YzUc5p6YNqAbUTI3wBSsS8PYjYqpGkZ2s2BRFh4lgP3Z28C47XD
	HWfkWjVFUADGGaT9A+3ySOFhXV4220kJ5RRT1371h/lzltZRyxRAj504VaMgWnVBZRiWuiZMw8F
	9rF9N1QBmgvVQHYDQu/sYYHUk+jyzxeMx713K5KyX
X-Received: by 2002:a05:6a20:e104:b0:197:78be:b5f6 with SMTP id kr4-20020a056a20e10400b0019778beb5f6mr1830571pzb.30.1704428272963;
        Thu, 04 Jan 2024 20:17:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEokiFCVyap5KJ89I1Q0gN7ZI5vIsHsS7JOPAzDv9bI+X0Kz7fuEisChZiKFaACtFiEjxUVXg==
X-Received: by 2002:a05:6a20:e104:b0:197:78be:b5f6 with SMTP id kr4-20020a056a20e10400b0019778beb5f6mr1830559pzb.30.1704428272620;
        Thu, 04 Jan 2024 20:17:52 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:3efd:1dbc:859f:ecb4:d775])
        by smtp.gmail.com with ESMTPSA id s11-20020a63f04b000000b005cdad153d84sm443222pgj.90.2024.01.04.20.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 20:17:51 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Oleg Nesterov <oleg@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Hui <guohui@uniontech.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] arm64: remove unnecessary ifdefs around is_compat_task()
Date: Fri,  5 Jan 2024 01:15:00 -0300
Message-ID: <20240105041458.126602-3-leobras@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently some parts of the codebase will test for CONFIG_COMPAT before
testing is_compat_task().

is_compat_task() is a inlined function only present on CONFIG_COMPAT.
On the other hand, for !CONFIG_COMPAT, we have in linux/compat.h:

#define is_compat_task() (0)

Since we have this define available in every usage of is_compat_task() for
!CONFIG_COMPAT, it's unnecessary to keep the ifdefs, since the compiler is
smart enough to optimize-out those snippets on CONFIG_COMPAT=n

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
Changes since RFCv1:
- Removed unnecessary new inlined is_compat_task() for arm64
- Adjusted commit text and title
Link: https://lore.kernel.org/all/20240104192433.109983-2-leobras@redhat.com/

 arch/arm64/kernel/ptrace.c  | 6 ++----
 arch/arm64/kernel/syscall.c | 5 +----
 2 files changed, 3 insertions(+), 8 deletions(-)

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


