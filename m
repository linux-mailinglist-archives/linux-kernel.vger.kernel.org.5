Return-Path: <linux-kernel+bounces-97783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A18876F5D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 06:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8601C20CB5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 05:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A201F364C7;
	Sat,  9 Mar 2024 05:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fxkm1ZjY"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AD233CF1
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 05:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709963846; cv=none; b=Opo4EQU/IV8zwpm9xVKVeatrr5u1kzz50ePq51Xe/iBoMWK27wLFZuAsPw/xAHHKlL05ya+XShuufqMDElhOuU6+Xao2vEGEWfdlOA9t3FYSm1DNi25ly7V6anQh9xQojB/2Z0VOcRUb/zqEbKZlyhh1nJKnqR6C6RDyFJYL/OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709963846; c=relaxed/simple;
	bh=QNC6MLowYJQ7WrQiTaExvXyU7M4ZEOEd7qjVzVWX+FQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X+yEk+MpYgOiJwPlIFKPVJjiSjAoIDalaScfU2EHKHdcmVQFVHTUAzRwf9vMcO1zs7UYYChrNfFJ4KcRtHYhjJCGWMI7zWQxBaRt4eUSbppiMGFbrqKofjb4t9w9Nca77iAbVANelxrweJ+vlw/Rvo1y0YDcEDAFapRyRMgRX9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fxkm1ZjY; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-609fb447f55so22472307b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 21:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709963842; x=1710568642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ikzoZBuKoqEC94gAKswpz3yYXyOYx8dWrhoyNRyBiYk=;
        b=Fxkm1ZjYEo28OsvjEsMQVclDOHjOMsKOdNUush0wtqS8EbzS6Iamig8z9vZ/gBz86f
         GGh0Gl7XdRHZt5ZyQkyzp3lVXXCkdi1423v/fyd1jgunM/e9nhd8DpJWD1UgNyCBLbr5
         G4grJ6fKgZMQX/9kKaAbqdvIX5RhDTsfBTmeBScu1VetmNUl7U8ngsdkQZwuNgxDwDJu
         K1ZjKN3ZXBHuxlPtqWar0ddd8l2W/XQFnOIUod/bF26CHfU3nk2gPJPCGZk8CdU1I0HG
         AXArfHvDx4cITbZ6d+RqD/AUus02UhmIrZxbHNKu4kSphjLqWZglNLpidUWMFPcmsEbC
         JdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709963842; x=1710568642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikzoZBuKoqEC94gAKswpz3yYXyOYx8dWrhoyNRyBiYk=;
        b=CP9gr9zte4ryB4eYe6ti30gmroqa3sfgO+intPTmOXMdd1IJC2DrKA4x1FQUEJgXyf
         E+ojM6iTtrhKBXkQNh7PMmLAtYwA7DAbo9wy2ZL3UTEe8Fsc7OhOjiyBCH3/jX6VcCMG
         gm+f2QG0DFdRcx9iALx5xjq1rMtTiKa8UMJOYF1NQ00WfLDOYKHJsZ3CuPH0QWgS0p2q
         d9iS+uolLne6GhItKRDpCGEzC4klBJcoN+lKDpEAAMaR5GbA/OPojqE1zUeH4zvSgIZy
         qX/d3NlhLo+MvrI/JMj0zdWwEtjEGJmhygg/deyII9i8jENRgaK5SozXzj1sUD4nUaKK
         qUpQ==
X-Gm-Message-State: AOJu0Yw0jpBixftMoSSo0OcNdZCcbHEDWq9yXSkGWTbYI2HqofTmEqQJ
	ZTNlR/a6tTk0SD29WpRbF9xaWYUB43hVdVXzdr7vOZdbBeapH7A4/TYs8LpeSbQ=
X-Google-Smtp-Source: AGHT+IH03dg0jEy3qpc1hA3fIB8ySYDaS2MFsYVtkyzy86e3Yz2dd9snxIoM1x44m4PB3JFgpX58rA==
X-Received: by 2002:a0d:dd89:0:b0:60a:6f7:d5f2 with SMTP id g131-20020a0ddd89000000b0060a06f7d5f2mr1224269ywe.9.1709963842574;
        Fri, 08 Mar 2024 21:57:22 -0800 (PST)
Received: from blackforest.ics.uci.edu (blackforest.ics.uci.edu. [128.195.4.234])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902784800b001d8a93fa5b1sm591371pln.131.2024.03.08.21.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 21:57:22 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20R=C3=B6sti?= <an.roesti@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: an.roesti@gmail.com,
	tglx@linutronix.de,
	peterz@infradead.org,
	luto@kernel.org
Subject: [PATCH] Respect system call number changes by sys_enter probes
Date: Sat,  9 Mar 2024 05:53:12 +0000
Message-Id: <20240309055311.2144-1-an.roesti@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a probe  is registered at the `trace_sys_enter` tracepoint, and
that probe changes the system call number, the old system call still
gets executed on x86_64 (and potentially other architectures). This
is inconsistent with how ARM64 (and potentially other architectures)
handles this, and inconsistent with the tracepoint semantics prior to
change b6ec41346103 (core/entry: Report syscall correctly for trace
and audit).

With this patch, the semantics are restored to be the same as before
the aforementioned change (and thus made consistent with ARM64). The
change adds one line to re-read the system call number register into
the `syscall` variable. By reading twice, the benefits of the
aforementioned change b6ec41346103 are kept.

There should be no performance impact if no sys_enter tracepoints are
registered, since re-reading the system call number from `regs` is
only done conditonally if the tracepoint is in use. If a probe is
registered, the performance impact should still be minimal, since the
additional call to `syscall_get_nr` amounts to only an inlined read
of `regs->orig_ax` (on x86_64).

Signed-off-by: André Rösti <an.roesti@gmail.com>
---
@Thomas Gleixner: You may have received this e-mail twice. My apologies!
This is my first attempt to contribute, and I made a mistake using git
send-email. Thanks for your work maintaining this and sorry again.
---
 kernel/entry/common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 88cb3c88aaa5..89b14ba9ed14 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -57,8 +57,11 @@ long syscall_trace_enter(struct pt_regs *regs, long syscall,
 	/* Either of the above might have changed the syscall number */
 	syscall = syscall_get_nr(current, regs);
 
-	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
+	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT)) {
 		trace_sys_enter(regs, syscall);
+		/* Tracers may have changed system call number as well */
+		syscall = syscall_get_nr(current, regs);
+	}
 
 	syscall_enter_audit(regs, syscall);
 

base-commit: 221a164035fd8b554a44bd7c4bf8e7715a497561
-- 
2.34.1


