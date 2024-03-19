Return-Path: <linux-kernel+bounces-107852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB3488027B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9101284F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC6120B21;
	Tue, 19 Mar 2024 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oRPfHOnE"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1235B14295
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866229; cv=none; b=SKgl8KThBET/ORbNbe9qSV7UoGWUzHyGp21s39NybX3mRJjtknEnAFk+/efaFjr6j5Gn3Tjz8wNERcK4ePtphGNqoMaIbAa7KCF8afzx3GmqT3xaz5W6WM7ZwJ7UL83uH4uCYkBHmn53NO//5RPp7Z408Qbr9fPVEtR+9+hVi8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866229; c=relaxed/simple;
	bh=6qxYl7dzL8qY7MB9jBMAIxCXW/XfykIUEndOQHX7yw4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WOw/m13NAKpXUgWXN8cjKS53EbCJHWskw5FOJ93BUlCgcgJYIg9CCg/Yl3bV+ByuY30PK1a2EH55hVvOmIq8KyMKde5tM2cgGBLCvqqcCIn6tk2GwEYxh8KNbD2Ov3ifApq5UxCGfY55BpMv88GPomiPBI6LtP/VrrhnSmfn0qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oRPfHOnE; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a0b18e52dso296097b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710866227; x=1711471027; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DNX90sT1lUbl5lD9B0qqgx+siiIHXGud0HrlrLB6kTU=;
        b=oRPfHOnEtDxb6dAyHJzjUSV0Ph/BiYL0iE0a5zItg+tgPYf/uIxoHtRlms9sHiVwHz
         Jn0DTnv8IoAysvQdjxMYzPgk0W/+zJ+jU6P0QrWcI7qLio//uFtSQpw0uMfUECC/5+gd
         Wj7X+Iv+gO2tBxevHTcBab2vTQE1qznfSrSZkiw5Q14h493TuGQPPAopFVyUpZDRaLOd
         gcPzoolNyvzieV7hVkTLWZKPRqwm525/ePtoW/X3CXdCIu4GduSLE5E9wCaEdxAHDtq/
         0bdIi8TLTQb2a4cGNioNyxwr0N/fXuDyPahvBporysXVDyKFZqE+ggrrH0ZKPVHQ5TPM
         seaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866227; x=1711471027;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNX90sT1lUbl5lD9B0qqgx+siiIHXGud0HrlrLB6kTU=;
        b=H81lNWDYa5hEKtsZE+9+vsg1uPTPB0AMF1bSOHS+VUjbtpJAvBauxo8+1/uOhGXVmf
         OEFAXVK/8RLb3UNFhvn0S1s7WE+kKYv4CgeL2hqig4+cuDZVmP3Vu0DfRcRwJsdFJz+X
         YK6LEo2iHBjpWYaIdLoB187MEelTY1NQDPgamofjDDo7alxWhZ3Eke9ZF2hmAQ/+Vze8
         UlKkQxTVHS/BMjuNqE1Q9AUQUMvUWqf86PyBuU87Ypr+RBCaFMjDTXAUrGh1I5+9t5Ym
         ivSXIKC4gBXP4CvWjjXofeE9RjuNeWCXXX3Oe/g7c2edAT1+ie8zJWGFQ/z5KeSEsX7w
         mocw==
X-Gm-Message-State: AOJu0Yw4MrYf5TkI4jggc/ryc5CUFVe2DGdqzoThVzLvGKCNnr48LzXE
	cwRRHo4f3pfaXdX89BQFxJ5GNkuf3lcPQ5L9qpxAzDgKg+IwhXdVO/zYGNnjcjTZMirhXXDN4r5
	vZQ==
X-Google-Smtp-Source: AGHT+IEuFUPrKGZNxAUQCkAZHdAFv9OY/U9m9EfSTuCmaxi85ZlQiw/125AE2F106cBa+RSZ0S9g4AMYkZ4=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:2234:4e4b:bcf0:406e])
 (user=glider job=sendgmr) by 2002:a0d:d950:0:b0:60a:1844:74ef with SMTP id
 b77-20020a0dd950000000b0060a184474efmr742423ywe.1.1710866227040; Tue, 19 Mar
 2024 09:37:07 -0700 (PDT)
Date: Tue, 19 Mar 2024 17:36:56 +0100
In-Reply-To: <20240319163656.2100766-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240319163656.2100766-1-glider@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240319163656.2100766-3-glider@google.com>
Subject: [PATCH v1 3/3] x86: call instrumentation hooks from copy_mc.c
From: Alexander Potapenko <glider@google.com>
To: glider@google.com, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kasan-dev@googlegroups.com, tglx@linutronix.de, x86@kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Marco Elver <elver@google.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="UTF-8"

Memory accesses in copy_mc_to_kernel() and copy_mc_to_user() are performed
by assembly routines and are invisible to KASAN, KCSAN, and KMSAN.
Add hooks from instrumentation.h to tell the tools these functions have
memcpy/copy_from_user semantics.

The call to copy_mc_fragile() in copy_mc_fragile_handle_tail() is left
intact, because the latter is only called from the assembly implementation
of copy_mc_fragile(), so the memory accesses in it are covered by the
instrumentation in copy_mc_to_kernel() and copy_mc_to_user().

Link: https://lore.kernel.org/all/3b7dbd88-0861-4638-b2d2-911c97a4cadf@I-love.SAKURA.ne.jp/
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 arch/x86/lib/copy_mc.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/copy_mc.c b/arch/x86/lib/copy_mc.c
index 6e8b7e600def5..e8aec0dbe6bcf 100644
--- a/arch/x86/lib/copy_mc.c
+++ b/arch/x86/lib/copy_mc.c
@@ -4,6 +4,7 @@
 #include <linux/jump_label.h>
 #include <linux/uaccess.h>
 #include <linux/export.h>
+#include <linux/instrumented.h>
 #include <linux/string.h>
 #include <linux/types.h>
 
@@ -61,10 +62,20 @@ unsigned long copy_mc_enhanced_fast_string(void *dst, const void *src, unsigned
  */
 unsigned long __must_check copy_mc_to_kernel(void *dst, const void *src, unsigned len)
 {
-	if (copy_mc_fragile_enabled)
-		return copy_mc_fragile(dst, src, len);
-	if (static_cpu_has(X86_FEATURE_ERMS))
-		return copy_mc_enhanced_fast_string(dst, src, len);
+	unsigned long ret;
+
+	if (copy_mc_fragile_enabled) {
+		instrument_memcpy_before(dst, src, len);
+		ret = copy_mc_fragile(dst, src, len);
+		instrument_memcpy_after(dst, src, len, ret);
+		return ret;
+	}
+	if (static_cpu_has(X86_FEATURE_ERMS)) {
+		instrument_memcpy_before(dst, src, len);
+		ret = copy_mc_enhanced_fast_string(dst, src, len);
+		instrument_memcpy_after(dst, src, len, ret);
+		return ret;
+	}
 	memcpy(dst, src, len);
 	return 0;
 }
@@ -76,6 +87,7 @@ unsigned long __must_check copy_mc_to_user(void __user *dst, const void *src, un
 
 	if (copy_mc_fragile_enabled) {
 		__uaccess_begin();
+		instrument_copy_to_user(dst, src, len);
 		ret = copy_mc_fragile((__force void *)dst, src, len);
 		__uaccess_end();
 		return ret;
@@ -83,6 +95,7 @@ unsigned long __must_check copy_mc_to_user(void __user *dst, const void *src, un
 
 	if (static_cpu_has(X86_FEATURE_ERMS)) {
 		__uaccess_begin();
+		instrument_copy_to_user(dst, src, len);
 		ret = copy_mc_enhanced_fast_string((__force void *)dst, src, len);
 		__uaccess_end();
 		return ret;
-- 
2.44.0.291.gc1ea87d7ee-goog


