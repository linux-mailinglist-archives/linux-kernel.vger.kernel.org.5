Return-Path: <linux-kernel+bounces-134284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E4489AFEB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D22F1F22BCB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9E23612C;
	Sun,  7 Apr 2024 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VB6XghBs"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F9133CF5;
	Sun,  7 Apr 2024 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712480645; cv=none; b=HNlxf5EX0LqkmnBEpwD/elOlcKSyXKaj2PhrfD+vi28sYNkcqZbzsuOT8UKGRiKKAkfAA4LQbJthF7418KaranIVw7EMH7bG+oO/exb9nEvztKo6kwv1aB3lNhdwwksVlsz6z5YFb7IykKiNNvG206v2U6RRdGwDgzu7Y+SqqCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712480645; c=relaxed/simple;
	bh=FJ4sCFu41FqELkYNcQeO9GHd0HS+4qyW6t8CF+WAzbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UT473uI7wRtiNuaJQDd/LCP0NpYUH7s+I5ssCHlT1zNoopMFVhB70g4GXfamISfNKAI56E6pb97RUfw8b7tPa3caVWNEpWqw2ISbiyP+DdZCbP2GdNkgP6cz+cl44vr9PaW1+q2KAFdHr+qcmCeFmhXfaapp9YSa55DDzDIM8M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VB6XghBs; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e2bbc2048eso28541015ad.3;
        Sun, 07 Apr 2024 02:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712480643; x=1713085443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6Ao7lt8bYptuXYSouvezeqYjGeG+t4ZB0d0AMHEq3o=;
        b=VB6XghBs0CEh3lGFxzG0vfzU8XnskjjBc28EmlAfLDDEXxW3PeFMTJ+gpys3sCptsc
         vfp9QKaa97BQQKS5ZtxeZzl+89HYuRz4bCQZLOQHvKrAGRF4CpfaLBg6dl7Yy6TgN+Fv
         J4x2RBEjhVrfeWZTnVpLLcRB3Qd+DuLleDAOlrP0i6stfWXf3TqCo3UoV4ugpC3t8YiM
         VSnjiaQpuhx4owipL6RIFc1kOlN8Yi1xgiE3dxwHC16TrJmtzgL/7lD1El3DPOBB+bT9
         jBlAXVqp4opNQkk+LQaVbgfAU0tnAFew5TMtpCeyXVNrNwlhXKIwyljCxIH4wNbf9jQr
         62Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712480643; x=1713085443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6Ao7lt8bYptuXYSouvezeqYjGeG+t4ZB0d0AMHEq3o=;
        b=qxgggXfNMe9YSzqoc/toYMzeDM3YhZWATbGUBy97kTWDs8kaIQpkaaOw1t3Akkd2+p
         yEBl6V8wOEyyMeDWSOLFlqLrya4Cep9VWtHHPV9aAcz5LP5dwPiF5pUrUHX+Ahp12Ixc
         +fvodOIDsxWnfWdhMsPOec4P7JBsNt/F/BcGd5kG4fQhR7fJ6w0O55ISXYN+p9Yb0h+g
         hnSSzWqM74IYKxMx6gyo556c6pAagvP8vePEJKvLocxr/aLPZ0BofSDbLAvYJSSRZ9EB
         mmUk1tTETnRVoaTB6AF09FqBEKNDmvAZtUtg12PWXnzu0EPSZLhMCucuTaQTXToRs26Y
         ewMg==
X-Gm-Message-State: AOJu0YwMgvjVJjkLtcqqYpazOumXYBQqEOF/jOD7JMPG6sGjzY+8laR0
	Uo/jdnAXNc6M7rRw8sI/qoUKmKqB9Gqk/75I3m84r8Dj3CfEztqzeRD/P8yK
X-Google-Smtp-Source: AGHT+IFkaG5AT1Vcbcxhl+vZNr+Yss32Phiw8WSKNjNbCK2mZPlpEBzEAmEdTwic4cfsu/0SJkgRvw==
X-Received: by 2002:a17:902:ce03:b0:1e4:43f:64d4 with SMTP id k3-20020a170902ce0300b001e4043f64d4mr940632plg.49.1712480643183;
        Sun, 07 Apr 2024 02:04:03 -0700 (PDT)
Received: from localhost ([47.254.32.37])
        by smtp.gmail.com with ESMTPSA id w26-20020a63161a000000b005f0a1a46f08sm3743660pgl.11.2024.04.07.02.04.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2024 02:04:02 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org,
	x86@kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 08/11] x86/entry: Merge thunk_64.S and thunk_32.S into thunk.S
Date: Sun,  7 Apr 2024 17:05:55 +0800
Message-Id: <20240407090558.3395-9-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240407090558.3395-1-jiangshanlai@gmail.com>
References: <20240407090558.3395-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

The code in thunk_64.S and thunk_32.S are exactly the same except for
the comments. Merge them in to thunk.S.

And since thunk_32.S was originated from thunk_64.S, the new merged
thunk.S is actually renamed from thunk_64.S.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/Makefile                |  2 +-
 arch/x86/entry/{thunk_64.S => thunk.S} |  0
 arch/x86/entry/thunk_32.S              | 18 ------------------
 3 files changed, 1 insertion(+), 19 deletions(-)
 rename arch/x86/entry/{thunk_64.S => thunk.S} (100%)
 delete mode 100644 arch/x86/entry/thunk_32.S

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index c93e7f5c2a06..ce1cc1622385 100644
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
diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk.S
similarity index 100%
rename from arch/x86/entry/thunk_64.S
rename to arch/x86/entry/thunk.S
diff --git a/arch/x86/entry/thunk_32.S b/arch/x86/entry/thunk_32.S
deleted file mode 100644
index da37f42f4549..000000000000
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
-- 
2.19.1.6.gb485710b


