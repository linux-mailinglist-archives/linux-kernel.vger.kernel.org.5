Return-Path: <linux-kernel+bounces-8502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 567D581B8B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB291F2481F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C397B3BB;
	Thu, 21 Dec 2023 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cnd5CQau"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B383E77626
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d93278bfbeso452629b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 05:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703165964; x=1703770764; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WRPtFKRbZo87GpoO95/PqPDiQIBNAfn361E91yU6k0=;
        b=Cnd5CQauM5XifTnZjzkJHqlSdWBnZTqdVnKLhJbVZAO3+47V7Li/bT1AqrV9zt370q
         7Iqj4WRNEBsWANctCPO87cpRXxY3L1mJdHRrMGwRJGpzjVK0zTpppBMbS3TizFlWP6Ud
         TcYUPBmX7XPGTYqSVCkt00hnH4Fw65S/m6VR6uXE1JWDV1Gp9YLHrqwK/ojWnLjKA+vA
         jbfFjC5lwYVjE/bWPGsveK2Uq+iylcG1Dp+Sm7y19qJaUYTy4w2ghar9d5Nf5v3rz6kC
         f9ZE6S5gdEvmZB0NFkf/Imb25Y0xkGeYodyrdpN+gt2KVF/le4TN6HIL3zUcuEX5sXk3
         m4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703165964; x=1703770764;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WRPtFKRbZo87GpoO95/PqPDiQIBNAfn361E91yU6k0=;
        b=iikLjytOxWQQMWUiTogJQHEzu0wdLwOQZl9l4ZLACW7HlTGbIVGY07A3cbgAqdXT2w
         m14FQB0wmZXCllmSTMROz9pciww2kQm5WTw+nAyA2ad1l+NVTtsuGi+xyR3vBvbumi2a
         KfjmJIyi5YlT/DxfYmaLgBdtaqrxT1Q1N6gLoUbqq48ZP7LPv1+bgg3ldqpAI/GVrvpR
         22Sbb9Xu5vr/ODFbX9dW5jvQBSbWWZsdiu9MggoWgJmfTLbB4+rOLP2BUF1HH+9cgJBn
         H6sHqyPOSNrW1bDZ2+U7xLOTlFD9V9dVv8b5ZDPbXG5R9U3Vh4dA72tk+Yxpu6LCvNuK
         iKMA==
X-Gm-Message-State: AOJu0YwVJU6vv6v55A6AlgKAWWd/CvBTT3faVp4Kgaf3O0uAAf6NVTI2
	WPga9wykgwkhFg3K0TlYPEw=
X-Google-Smtp-Source: AGHT+IHxfdkJAxzDBvmI1qMaJp2TBMZfApl1OaDz0gzCXOZ0Mr+F6FZ6MLMibhYF/Bxt/GKgPiiCyQ==
X-Received: by 2002:aa7:8dda:0:b0:6d8:174b:97f2 with SMTP id j26-20020aa78dda000000b006d8174b97f2mr3409846pfr.9.1703165963997;
        Thu, 21 Dec 2023 05:39:23 -0800 (PST)
Received: from ruipeng-ThinkCentre-M730e-N010.company.local (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id e7-20020aa78c47000000b006ce64ebd2a0sm1622340pfd.99.2023.12.21.05.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 05:39:23 -0800 (PST)
From: Ruipeng Qi <ruipengqi7@gmail.com>
To: akpm@linux-foundation.org,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	mingo@kernel.org
Cc: qiruipeng@lixiang.com,
	arnd@arndb.de,
	gpiccoli@igalia.com,
	ubizjak@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 7/7] panic: invoke osdump when panic
Date: Thu, 21 Dec 2023 21:39:17 +0800
Message-Id: <20231221133917.955-1-ruipengqi7@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: qiruipeng <qiruipeng@lixiang.com>

Invoke osdump upon a panic to generate a minidump, which can be analyzed
later with the crash utility.

Signed-off-by: qiruipeng <qiruipeng@lixiang.com>
---
 kernel/panic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 2807639aab51..b83e5caf8003 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -37,6 +37,9 @@
 #include <linux/context_tracking.h>
 #include <trace/events/error_report.h>
 #include <asm/sections.h>
+#ifdef CONFIG_OS_MINIDUMP
+#include <linux/osdump.h>
+#endif
 
 #define PANIC_TIMER_STEP 100
 #define PANIC_BLINK_SPD 18
@@ -326,6 +329,10 @@ void panic(const char *fmt, ...)
 	} else if (old_cpu != this_cpu)
 		panic_smp_self_stop();
 
+#ifdef CONFIG_OS_MINIDUMP
+	osdump();
+#endif
+
 	console_verbose();
 	bust_spinlocks(1);
 	va_start(args, fmt);
-- 
2.17.1


