Return-Path: <linux-kernel+bounces-139425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAB98A032E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A175A1C22F78
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F28184121;
	Wed, 10 Apr 2024 22:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="qgKpmmpA"
Received: from rn-mailsvcp-mx-lapp03.apple.com (rn-mailsvcp-mx-lapp03.apple.com [17.179.253.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C07F12FF7C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.179.253.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712787465; cv=none; b=ar6PxCLUl2LNFpiQ2kfDyAp0lK80LLadbjv/We45pYKbxQ1+3N0K4XaBKFl6mJdvToxkzM7V+h5QX2nJ9TCcL7YRFZ22JXKTv9f7VGLizmIvbuLYbP/EuZvvBDqjermVSrHbxmbWbNStraJmzhNOGASL3GmXSsxMofAvmEq4HvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712787465; c=relaxed/simple;
	bh=r47L1NedklpuX1XImx5JySpc+Rl88sWe0DMotwLCyh8=;
	h=MIME-version:Content-type:From:To:Cc:Subject:Date:Message-id:
	 In-reply-to:References; b=ivR5bd6rV3E+83UnFMsvcx8/Y1I+weJHKyy5UZBGL0MBsTzQxTJBlekkhMNF20nuyM/byFEPa30jmPf97qDWWZrKSqxgHb84/7+dksBgx/LG7e+Ar5wb2QbmtT+FGsQWhncYF6vC7/Nib6xgI0sOZY6FS4pGs/+pLZWsXImXyQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com; spf=pass smtp.mailfrom=apple.com; dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b=qgKpmmpA; arc=none smtp.client-ip=17.179.253.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apple.com
Received: from rn-mailsvcp-mta-lapp01.rno.apple.com
 (rn-mailsvcp-mta-lapp01.rno.apple.com [10.225.203.149])
 by rn-mailsvcp-mx-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SBQ00X97WHEI400@rn-mailsvcp-mx-lapp03.rno.apple.com>
 for linux-kernel@vger.kernel.org; Wed, 10 Apr 2024 14:17:38 -0700 (PDT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_06,2024-04-09_01,2023-05-22_02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=mime-version : content-transfer-encoding : content-type : from : to : cc :
 subject : date : message-id : in-reply-to : references; s=20180706;
 bh=yzD0ErWek+Kci1kOFzlZLxyZ6zVoRSpOz95glDxGso4=;
 b=qgKpmmpAJ/66ridmFWQPwV2IUGlC9Ows9jpLZy0y6MmMMmgSU16hY84Vkt7J+BcO3Bvm
 xDLoKzfABl0kXaPoSGfoherxprkg7Fo6dVUSrjAdzG93GBhBu8glRwFznzcC5QywP0ln
 3mWqA5utC5PbX3hULgEaxvWZ7d4yrL3bfI5jtfF82TvOLf/0RAArykM49XXRZ/7rZGDc
 UkTFW9shVT4uTJ3YJ81Xbb4Kl4bt32PjI5HlE6bFiQbCgI7RoczIP8XiEUNIswZntuEZ
 ShYtFKk5MaRsMoGeQq869a79YH2IJW+lUXhKYUATd+B3yV+fTEJxSdzrAgI8rqwfdIZ9 FA==
Received: from rn-mailsvcp-mmp-lapp03.rno.apple.com
 (rn-mailsvcp-mmp-lapp03.rno.apple.com [17.179.253.16])
 by rn-mailsvcp-mta-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SBQ00NUQWHDMA70@rn-mailsvcp-mta-lapp01.rno.apple.com>;
 Wed, 10 Apr 2024 14:17:38 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp03.rno.apple.com by
 rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0SBQ00E00WFDM000@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Wed,
 10 Apr 2024 14:17:37 -0700 (PDT)
X-Va-A:
X-Va-T-CD: 062083411fbdfe5b9668648d0dddd4c2
X-Va-E-CD: f3c2317b02a88aa95672709c69356e59
X-Va-R-CD: 6aad3c1627c1e0a6bc0b0b7f2d563a90
X-Va-ID: 23fe65f4-aacf-4ef8-b6f1-67da1169e2ad
X-Va-CD: 0
X-V-A:
X-V-T-CD: 062083411fbdfe5b9668648d0dddd4c2
X-V-E-CD: f3c2317b02a88aa95672709c69356e59
X-V-R-CD: 6aad3c1627c1e0a6bc0b0b7f2d563a90
X-V-ID: e7e58af7-afe6-492d-ab35-4c1671d6e139
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_06,2024-04-09_01,2023-05-22_02
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset=UTF-8
Received: from mr41p01nt-relayp01.apple.com ([17.115.0.54])
 by rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023))
 with ESMTPSA id <0SBQ00HCRWGK4E00@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Wed,
 10 Apr 2024 14:17:36 -0700 (PDT)
From: Zayd Qumsieh <zayd_qumsieh@apple.com>
To: zayd_qumsieh@apple.com
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mateusz Guzik <mjguzik@gmail.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Miguel Luis <miguel.luis@oracle.com>,
 Joey Gouly <joey.gouly@arm.com>, Christoph Paasch <cpaasch@apple.com>,
 Kees Cook <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>,
 Baoquan He <bhe@redhat.com>, Lecopzer Chen <lecopzer.chen@mediatek.com>,
 Joel Granados <j.granados@samsung.com>, Dawei Li <dawei.li@shingroup.cn>,
 Andrew Morton <akpm@linux-foundation.org>,
 Florent Revest <revest@chromium.org>, David Hildenbrand <david@redhat.com>,
 Stefan Roesch <shr@devkernel.io>, Andy Chiu <andy.chiu@sifive.com>,
 Josh Triplett <josh@joshtriplett.org>, Oleg Nesterov <oleg@redhat.com>,
 Helge Deller <deller@gmx.de>, Zev Weiss <zev@bewilderbeest.net>,
 Ondrej Mosnacek <omosnace@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] tso: aarch64: context-switch tso bit on thread switch
Date: Wed, 10 Apr 2024 14:16:40 -0700
Message-id: <20240410211652.16640-3-zayd_qumsieh@apple.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-reply-to: <20240410211652.16640-1-zayd_qumsieh@apple.com>
References: <20240410211652.16640-1-zayd_qumsieh@apple.com>

Add support for context-switching the tso bit when the thread
switches. This allows per-thread setting of the tso bit, and prepares
future work to allow userspace to set the tso bit of their thread
at will.

Signed-off-by: Zayd Qumsieh <zayd_qumsieh@apple.com>
---
 arch/arm64/include/asm/processor.h | 4 ++++
 arch/arm64/include/asm/tso.h       | 1 +
 arch/arm64/kernel/process.c        | 9 +++++++++
 arch/arm64/kernel/tso.c            | 9 +++++++++
 4 files changed, 23 insertions(+)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index f77371232d8c..a247bee24c73 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 1995-1999 Russell King
  * Copyright (C) 2012 ARM Ltd.
+ * Copyright © 2024 Apple Inc. All rights reserved.
  */
 #ifndef __ASM_PROCESSOR_H
 #define __ASM_PROCESSOR_H
@@ -184,6 +185,9 @@ struct thread_struct {
 	u64			sctlr_user;
 	u64			svcr;
 	u64			tpidr2_el0;
+#ifdef CONFIG_ARM64_TSO
+	bool        tso;
+#endif
 };
 
 static inline unsigned int thread_get_vl(struct thread_struct *thread,
diff --git a/arch/arm64/include/asm/tso.h b/arch/arm64/include/asm/tso.h
index d9e1a7602c44..405e9a5efdf5 100644
--- a/arch/arm64/include/asm/tso.h
+++ b/arch/arm64/include/asm/tso.h
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 
 int modify_tso_enable(bool tso_enable);
+void tso_thread_switch(struct task_struct *next);
 
 #endif /* CONFIG_ARM64_TSO */
 #endif /* __ASM_TSO_H */
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 4ae31b7af6c3..3831c1a97f79 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -5,6 +5,7 @@
  * Original Copyright (C) 1995  Linus Torvalds
  * Copyright (C) 1996-2000 Russell King - Converted to ARM.
  * Copyright (C) 2012 ARM Ltd.
+ * Copyright © 2024 Apple Inc. All rights reserved.
  */
 #include <linux/compat.h>
 #include <linux/efi.h>
@@ -55,6 +56,7 @@
 #include <asm/stacktrace.h>
 #include <asm/switch_to.h>
 #include <asm/system_misc.h>
+#include <asm/tso.h>
 
 #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
 #include <linux/stackprotector.h>
@@ -530,6 +532,9 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	ssbs_thread_switch(next);
 	erratum_1418040_thread_switch(next);
 	ptrauth_thread_switch_user(next);
+#ifdef CONFIG_ARM64_TSO
+	tso_thread_switch(next);
+#endif
 
 	/*
 	 * Complete any pending TLB or cache maintenance on this CPU in case
@@ -651,6 +656,10 @@ void arch_setup_new_exec(void)
 		arch_prctl_spec_ctrl_set(current, PR_SPEC_STORE_BYPASS,
 					 PR_SPEC_ENABLE);
 	}
+
+#ifdef CONFIG_ARM64_TSO
+	modify_tso_enable(false);
+#endif
 }
 
 #ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
diff --git a/arch/arm64/kernel/tso.c b/arch/arm64/kernel/tso.c
index b3964db7aa66..9a15d825943f 100644
--- a/arch/arm64/kernel/tso.c
+++ b/arch/arm64/kernel/tso.c
@@ -3,6 +3,7 @@
  * Copyright © 2024 Apple Inc. All rights reserved.
  */
 
+#include <linux/sched.h>
 #include <linux/types.h>
 
 #include <asm/cputype.h>
@@ -49,4 +50,12 @@ int modify_tso_enable(bool tso_enable)
 	return 0;
 }
 
+void tso_thread_switch(struct task_struct *next)
+{
+	if (tso_supported()) {
+		current->thread.tso = tso_enabled();
+		modify_tso_enable(next->thread.tso);
+	}
+}
+
 #endif /* CONFIG_ARM64_TSO */
-- 
2.39.3 (Apple Git-146)


