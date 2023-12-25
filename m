Return-Path: <linux-kernel+bounces-10885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D29EA81DE09
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 05:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046FA1C215E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 04:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C67EA6;
	Mon, 25 Dec 2023 04:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="Ynm+KEeY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A58DA34
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 04:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-67f3f602bd5so29258856d6.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 20:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1703476957; x=1704081757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vgkto8kByXW7VWkGHNSr7+7oLApL/4XLRHDEPzxTHb4=;
        b=Ynm+KEeYBJyyFflotqs00yFsIllueCJLmb6sfBu4ASJibD1mEf7Vipq2fR9sRzheOU
         nUqcU1wzoNuIFk+8eo2YFIgG9r8QYkhAqiMQeY7uSgetlVz/cxRnHFaylCZKjC+PA7El
         LXcRrGluLcQ4AGs70h8bUlQvZjXvbkoiC4QyqnuMiWYT2REitRjE1pb162tEA/0JTE9V
         LBg3BntCP5u67XnfQ5O7dQiBwPO7s18EG1P8ninuogtLtjhSyNq/84d83rUYrdn+xu8R
         tfoYR9ldWWC/hipq89URpo/yd+UBAV+VuW4F7+1R6l+5jidKslP0YaQppiReFi1TGSmL
         IXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703476957; x=1704081757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vgkto8kByXW7VWkGHNSr7+7oLApL/4XLRHDEPzxTHb4=;
        b=wW6ygx+zE+cIyiIxA0bzUwWM560dMqQuR9yYA+85m4K5U6Iyd24RZov+dy1THJmCYy
         XJ5I9DjccrkHD2fSc+cRXgWvoDkOxdvXpSW9CaDsuOpOlnvqf0mkRfe6ocjHoTFJKJ7T
         oCP9HtRAkeHkjK3szt/QBX+ZMsBNzZFd9beNpCv9TNaJ3Ql3UbQIKsx5H2C57qncqOgk
         qIjy2eqQUNpXYXmSlcvQq/IYAx6Gcq7cVtgcHCJn8gbo+Zi1+NSZWWZmuJuNWJXMg3sO
         g1BQINIIZDLty30U5Ufvtn7Brjr3w18SZRTIMlan4AaRtTQRPxq79/Ea0y9xZC9g7DZr
         V+Hg==
X-Gm-Message-State: AOJu0YxV4VbwNDnwXZtJGvxnqhOXSYwwW4d2PpSEM1BYXxY3Psy7U6q0
	LqARr6HO2VoNZsMs8olEzxku0fjb/xcKRA==
X-Google-Smtp-Source: AGHT+IGUoqgi8xxLb4ll1iCLSlEbo9ksVFmClgkdbzXzaaRMMvSDubNHYo1fu4YTtah1F6rc1ZwH+Q==
X-Received: by 2002:ad4:574f:0:b0:67f:2f25:ae77 with SMTP id q15-20020ad4574f000000b0067f2f25ae77mr8848581qvx.14.1703476956942;
        Sun, 24 Dec 2023 20:02:36 -0800 (PST)
Received: from sjc-lab-t7002.local.tenstorrent.com ([38.142.247.251])
        by smtp.gmail.com with ESMTPSA id dr4-20020a05621408e400b0067f8953f78fsm3075883qvb.41.2023.12.24.20.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 20:02:36 -0800 (PST)
From: Anton Blanchard <antonb@tenstorrent.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anton Blanchard <antonb@tenstorrent.com>
Subject: [PATCH] riscv: Improve exception and system call latency
Date: Sun, 24 Dec 2023 20:00:18 -0800
Message-Id: <20231225040018.1660554-1-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many CPUs implement return address branch prediction as a stack. The
RISCV architecture refers to this as a return address stack (RAS). If
this gets corrupted then the CPU will mispredict at least one but
potentally many function returns.

There are two issues with the current RISCV exception code:

- We are using the alternate link stack (x5/t0) for the indirect branch
  which makes the hardware think this is a function return. This will
  corrupt the RAS.

- We modify the return address of handle_exception to point to
  ret_from_exception. This will also corrupt the RAS.

Testing the null system call latency before and after the patch:

Visionfive2 (StarFive JH7110 / U74)
baseline: 189.87 ns
patched:  176.76 ns

Lichee pi 4a (T-Head TH1520 / C910)
baseline: 666.58 ns
patched:  636.90 ns

Just over 7% on the U74 and just over 4% on the C910.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---

This introduces some complexity in the stackframe walk code. PowerPC
resolves the multiple exception exit paths issue by placing a value into
the exception stack frame (basically the word "REGS") that the stack frame
code can look for. Perhaps something to look at.

 arch/riscv/kernel/entry.S      | 21 ++++++++++++++-------
 arch/riscv/kernel/stacktrace.c | 14 +++++++++++++-
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 54ca4564a926..89af35edbf6c 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -84,7 +84,6 @@ SYM_CODE_START(handle_exception)
 	scs_load_current_if_task_changed s5
 
 	move a0, sp /* pt_regs */
-	la ra, ret_from_exception
 
 	/*
 	 * MSB of cause differentiates between
@@ -93,7 +92,10 @@ SYM_CODE_START(handle_exception)
 	bge s4, zero, 1f
 
 	/* Handle interrupts */
-	tail do_irq
+	call do_irq
+.globl ret_from_irq_exception
+ret_from_irq_exception:
+	j ret_from_exception
 1:
 	/* Handle other exceptions */
 	slli t0, s4, RISCV_LGPTR
@@ -101,11 +103,16 @@ SYM_CODE_START(handle_exception)
 	la t2, excp_vect_table_end
 	add t0, t1, t0
 	/* Check if exception code lies within bounds */
-	bgeu t0, t2, 1f
-	REG_L t0, 0(t0)
-	jr t0
-1:
-	tail do_trap_unknown
+	bgeu t0, t2, 3f
+	REG_L t1, 0(t0)
+2:	jalr ra,t1
+.globl ret_from_other_exception
+ret_from_other_exception:
+	j ret_from_exception
+3:
+
+	la t1, do_trap_unknown
+	j 2b
 SYM_CODE_END(handle_exception)
 
 /*
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 64a9c093aef9..b9cd131bbc4c 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -17,6 +17,18 @@
 #ifdef CONFIG_FRAME_POINTER
 
 extern asmlinkage void ret_from_exception(void);
+extern asmlinkage void ret_from_irq_exception(void);
+extern asmlinkage void ret_from_other_exception(void);
+
+static inline bool is_exception_frame(unsigned long pc)
+{
+	if ((pc == (unsigned long)ret_from_exception) ||
+	    (pc == (unsigned long)ret_from_irq_exception) ||
+	    (pc == (unsigned long)ret_from_other_exception))
+		return true;
+
+	return false;
+}
 
 void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			     bool (*fn)(void *, unsigned long), void *arg)
@@ -62,7 +74,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			fp = frame->fp;
 			pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
 						   &frame->ra);
-			if (pc == (unsigned long)ret_from_exception) {
+			if (is_exception_frame(pc)) {
 				if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
 					break;
 
-- 
2.25.1


