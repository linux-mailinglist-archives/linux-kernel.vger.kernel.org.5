Return-Path: <linux-kernel+bounces-136476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A93489D477
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F320282B48
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA487F7CC;
	Tue,  9 Apr 2024 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e0JNA3/w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3SJWDAld"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E3913048D;
	Tue,  9 Apr 2024 08:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651268; cv=none; b=h2EWGFQctrdIl5fX2bwlcUro1Dvm6Y27WMElsFgfTraCHptT64NRQ/rsSDFpoa845Skm7rU9C4tGWqSkM7n14WuPnadFDvr2Z+c9MAaJhnhsIFoXdtQ24t25/Cqw1Y4CPfnQ+UUXsThbOIDd9G2OYzkuf9OKgCg7KhvEJtvby7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651268; c=relaxed/simple;
	bh=id3mSrhBH3QrzSWkxRPAbcYSsGZb9nlkgn0cxxvSCCw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HdddyUJ50DtTdABpp3HCvT9u2YOrO4x+wDkBGjCRKIsMQWSUH4+wBjoswQT4mrMLmhY9yk7ykYkorG8Hj3eiFPjkZCifDa7nsAHyUFPyQBKFuuDAlwFgL0EwXOLUpBHRn46dTAN6fkr2fTyxiWmNQXud3UH3vi9LBNO/EFJW7kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e0JNA3/w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3SJWDAld; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Apr 2024 08:27:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712651265;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sNklow3Psky9F5xsySs3TxcR+RYiRFH5qiPDjs8KeM0=;
	b=e0JNA3/wlz0jCtqKFbX9loIKjHVyGAg/ClCL1NIV3dcYy27LuVcZ5j7bOaa+LbrmJK5YsJ
	rVlt/yiaMLhOWGE26RAkEZKbNEn5D2Bh8BeoIxJsY/f9RUGryn+k5645awDiKJpUEBbtEc
	w3iYP97G5tj3MoqLu+zPFCyVN9jAWilZ9CKL8SZGPdO4azywN1gMGRyEGQcYRXgDKmOjyJ
	WWkhUXskgLG37yfiegs6sF5gdNGHmZaFc1wTlPJ9+UL5/n04ve75MPON/LZa5gxJVkjXG+
	b8aK5Irdg9VlDzGyZyOsAybxsiOeAfAx34h50VqBtJ4DjS0EZiH9T73/uDNp8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712651265;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sNklow3Psky9F5xsySs3TxcR+RYiRFH5qiPDjs8KeM0=;
	b=3SJWDAldma5KKACcvI/+GL1EgXGvF9S6NMiuGrW9MDRf+FYGCWrh1x532scOpzgHJVZjHQ
	DHDa1T9IwrLasVCw==
From: "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/entry] x86/entry: Merge thunk_64.S and thunk_32.S into thunk.S
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240407090558.3395-9-jiangshanlai@gmail.com>
References: <20240407090558.3395-9-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171265126458.10875.394998026353029663.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     b767fe5de0b4a5057b070d8cdefdcf6740733d6e
Gitweb:        https://git.kernel.org/tip/b767fe5de0b4a5057b070d8cdefdcf6740733d6e
Author:        Lai Jiangshan <jiangshan.ljs@antgroup.com>
AuthorDate:    Sun, 07 Apr 2024 17:05:55 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 09 Apr 2024 09:57:56 +02:00

x86/entry: Merge thunk_64.S and thunk_32.S into thunk.S

The code in thunk_64.S and thunk_32.S are exactly the same except for
the comments. Merge them in to thunk.S.

And since thunk_32.S was originated from thunk_64.S, the new merged
thunk.S is actually renamed from thunk_64.S.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240407090558.3395-9-jiangshanlai@gmail.com
---
 arch/x86/entry/Makefile   |  2 +-
 arch/x86/entry/thunk.S    | 15 +++++++++++++++
 arch/x86/entry/thunk_32.S | 18 ------------------
 arch/x86/entry/thunk_64.S | 15 ---------------
 4 files changed, 16 insertions(+), 34 deletions(-)
 create mode 100644 arch/x86/entry/thunk.S
 delete mode 100644 arch/x86/entry/thunk_32.S
 delete mode 100644 arch/x86/entry/thunk_64.S

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index c93e7f5..ce1cc16 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -17,7 +17,7 @@ obj-y				+= common.o
 obj-y				+= vdso/
 obj-y				+= vsyscall/
 
-obj-$(CONFIG_PREEMPTION)	+= thunk_$(BITS).o
+obj-$(CONFIG_PREEMPTION)	+= thunk.o
 CFLAGS_entry_fred.o		+= -fno-stack-protector
 CFLAGS_REMOVE_entry_fred.o	+= -pg $(CC_FLAGS_FTRACE)
 obj-$(CONFIG_X86_FRED)		+= entry_64_fred.o entry_fred.o
diff --git a/arch/x86/entry/thunk.S b/arch/x86/entry/thunk.S
new file mode 100644
index 0000000..119ebdc
--- /dev/null
+++ b/arch/x86/entry/thunk.S
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Save registers before calling assembly functions. This avoids
+ * disturbance of register allocation in some inline assembly constructs.
+ * Copyright 2001,2002 by Andi Kleen, SuSE Labs.
+ */
+#include <linux/export.h>
+#include <linux/linkage.h>
+#include "calling.h"
+#include <asm/asm.h>
+
+THUNK preempt_schedule_thunk, preempt_schedule
+THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
+EXPORT_SYMBOL(preempt_schedule_thunk)
+EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
diff --git a/arch/x86/entry/thunk_32.S b/arch/x86/entry/thunk_32.S
deleted file mode 100644
index da37f42..0000000
--- a/arch/x86/entry/thunk_32.S
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Trampoline to trace irqs off. (otherwise CALLER_ADDR1 might crash)
- * Copyright 2008 by Steven Rostedt, Red Hat, Inc
- *  (inspired by Andi Kleen's thunk_64.S)
- */
-
-#include <linux/export.h>
-#include <linux/linkage.h>
-#include <asm/asm.h>
-
-#include "calling.h"
-
-THUNK preempt_schedule_thunk, preempt_schedule
-THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
-EXPORT_SYMBOL(preempt_schedule_thunk)
-EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
-
diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
deleted file mode 100644
index 119ebdc..0000000
--- a/arch/x86/entry/thunk_64.S
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Save registers before calling assembly functions. This avoids
- * disturbance of register allocation in some inline assembly constructs.
- * Copyright 2001,2002 by Andi Kleen, SuSE Labs.
- */
-#include <linux/export.h>
-#include <linux/linkage.h>
-#include "calling.h"
-#include <asm/asm.h>
-
-THUNK preempt_schedule_thunk, preempt_schedule
-THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
-EXPORT_SYMBOL(preempt_schedule_thunk)
-EXPORT_SYMBOL(preempt_schedule_notrace_thunk)

