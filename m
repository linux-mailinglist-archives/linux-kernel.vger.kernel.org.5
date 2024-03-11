Return-Path: <linux-kernel+bounces-99556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8FE8789EE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A989B212A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6849656B67;
	Mon, 11 Mar 2024 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ3O8eO1"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6088E6FBE
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 21:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710191863; cv=none; b=maTokZV1kSVteydDzuGZn0JSysLn7P32rHQtadRR0Ws8apYAfbzlhwC6YQqw+Md0pEZ90SP+tTUwkSWBfdeUEOeOXMcVEEWi92KxOr8a7Tw1VsHPsu14ZIqKRUU3tO40X6KvUUlFyA582+6AEZzlu/Z2UHqfvAeKzhacPYCgXOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710191863; c=relaxed/simple;
	bh=wj4Y1wrFfDeMIOfi5jjtBmO/jQSDCKe4tQkC44jCKRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ctfZ1gOmEYYmH+ySykTXOazS1CDv12vfmSqQcAc9mga8nBFSsmOUomk6caWSHy1+Yf1xs/5JdZ9VKynHGiEvkZZ87l2NwIH8sbVGOkVrkw2AAAL4cLhRW8biALUcuLwrY8MYZjDgIsbn4cuczfCIpanq0o8rb1ozUFQ0BS2XDwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQ3O8eO1; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5dc949f998fso4461803a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710191861; x=1710796661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rWrjIn8VqX1yLK5RmY2tARNudiN2LB2C+U5i0p8D36c=;
        b=eQ3O8eO1LFb483KXM5QkNaQAX+6D/4R0qVVzuqKdVRj7GHTh92KHhxYgXV8HS3lo3t
         1UxQga5rGNIttWgpEkKu9MFMW16/XKgqu/Y7X6guycFdQM41B6t9bIvjxqKseZpsHO16
         fdo1JaRmpWlMPhJRm1dm1MrLuaBGwi/HEjF5V5JfW/IOIOSSEqr2aduMt7n5m3hHF9q2
         UOf5UZcTlzr0iq01cZaRtfoWhHms7FPwBr3Mf3Ewkj8oZ15LAzK0xp0RHGHMV9IB+Fc0
         CiisI4XgwHaMRNSYW3TCs/6vmOp7Kkwlb6+hK5HwOoQ2n2xWkcyO1vJgm+OEivs/yUpY
         gWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710191861; x=1710796661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWrjIn8VqX1yLK5RmY2tARNudiN2LB2C+U5i0p8D36c=;
        b=KTya/tTUNhzmZinZ7cXij/Ouo03dKVMe+eutmILe4UkMFVUg5m3lllITctoACBbhBV
         T8NM/1mrmSDMUYyHWyF47/7M5OHklUiwKdirGWrK4VEIrHJqR0X+RrPV3ebRycbR3ehD
         ZQYS70gjUdBzITfldzM+ZKoJmZMlEbm8qb/ZNcl16bAcoiqf1VRv5iSnkXeQ3Rs8/QKS
         2GOa+gVkYQVcXfJJKQQribsavXefVrv4i0Ar7zYkFSvvTiaSy9RD3Qo3gHvV2kqrZODR
         EbcaZyLrICQL/DHkZlD9Ls4EqFen3xjeCIj6NvR/cwWD7orLCp5rUsfnKDaxberki/kF
         8u1g==
X-Gm-Message-State: AOJu0Ywj6gFDFoCWfXW7AO7sb412LOIdlHGIB9bW1ROl668Ss8aRQKJ+
	K0KnAXbN8sZqpGK6LtdtRZLZ8+TuGY3BoHE/VMQhLUcUSiU84M/hPmeCLYYN7AM=
X-Google-Smtp-Source: AGHT+IFvOmP+Z3s5BttRbh2i0vNtAp+hbZpblUvZiF501b4hhEnyzNreSB3KqGk8MmkS31NaKVtGtw==
X-Received: by 2002:a05:6a20:6a0d:b0:1a0:f2a4:40da with SMTP id p13-20020a056a206a0d00b001a0f2a440damr19022pzk.6.1710191860664;
        Mon, 11 Mar 2024 14:17:40 -0700 (PDT)
Received: from blackforest.ics.uci.edu (blackforest.ics.uci.edu. [128.195.4.234])
        by smtp.gmail.com with ESMTPSA id b125-20020a62cf83000000b006e34008d0c3sm5030844pfg.100.2024.03.11.14.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 14:17:40 -0700 (PDT)
From: =?UTF-8?q?Andr=C3=A9=20R=C3=B6sti?= <an.roesti@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: an.roesti@gmail.com,
	tglx@linutronix.de
Subject: [PATCH v2] entry: Respect changes to system call number at sys_enter tracepoint
Date: Mon, 11 Mar 2024 21:17:04 +0000
Message-Id: <20240311211704.7262-1-an.roesti@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When a probe  is registered at the trace_sys_enter() tracepoint, and that
probe changes the system call number, the old system call still gets
executed.  This worked correctly until commit b6ec41346103 ("core/entry:
Report syscall correctly for trace and audit"), which removed the
re-evaluation of the syscall number after the trace point.

Restore the original semantics by re-evaluating the system call number
after trace_sys_enter(). 

The performance impact of this re-evaluation is minimal because it only
takes place when a trace point is active, and compared to the actual trace
point overhead the read from a cache hot variable is negligible.

Fixes: b6ec41346103 ("core/entry: Report syscall correctly for trace and audit")
Signed-off-by: André Rösti <an.roesti@gmail.com>

---
v1 -> v2: Clarify comment; improve commit message

@Thomas Gleixner: Thank you for your very quick reply and helpful
comments. I copied and slightly reworded your suggestions for the commit
message which were much more concise and clear. 
---
 kernel/entry/common.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 88cb3c88aaa5..90843cc38588 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -57,8 +57,14 @@ long syscall_trace_enter(struct pt_regs *regs, long syscall,
 	/* Either of the above might have changed the syscall number */
 	syscall = syscall_get_nr(current, regs);
 
-	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
+	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT)) {
 		trace_sys_enter(regs, syscall);
+		/*
+		 * Probes or BPF hooks in the tracepoint may have changed the
+		 * system call number as well.
+		 */
+		syscall = syscall_get_nr(current, regs);
+	}
 
 	syscall_enter_audit(regs, syscall);
 

base-commit: 221a164035fd8b554a44bd7c4bf8e7715a497561
-- 
2.34.1


