Return-Path: <linux-kernel+bounces-149690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB348A9495
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9E628290E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7EF762DA;
	Thu, 18 Apr 2024 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="kw7fB9Wg"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D87B76037
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427468; cv=none; b=Lghf4ONqtaoRIQFGOrN9iwCwv+bt+A46+RMjaIIoD0+jQkhUu0hTs7wwB1M+KSd1O6qx9ki2Vd8fPjUGFkqYBhaTCtzoa9W5n+t6H54hZyGR1tYN9deyIG5GsFmk8ypIU3NGh1GT246eWo8HkD3E68Xm3XZvYyJmzUKEmZsJxHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427468; c=relaxed/simple;
	bh=1o9rk/9Y1uvF7bt2JH2DYucjT8lV3Z4x4ZAgLxPAtgA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jsIetqeePONiKZ9MynJjGY0rc4uPi/YM8i/JMmw93aY/FkcN2581Xthu5qYyNUaNqcTI4XXbd7P5EYDIqqb1y/91K0n0+bOE+NGp4DZpmxTvH8W4JysJ7rKd/UYr5C0UTsj3JcASbMJ9nItD9bI/fdEw9nT8lzNq5EspjVw8B1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=kw7fB9Wg; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so314081a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1713427461; x=1714032261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tdE+GDd+xVW4HcGRxvURM0o1zWYdLwzdL6kLxqb0OOE=;
        b=kw7fB9WgcPTGlwH1vRZz1dhlgAi9CMf8FB/hR2BYxGpxsTI+DKXBEssm6e9prgkzr2
         AxWDmJ6ouBhQuMiNQSATVi208veH2eS3GL5Sb1tiE3B7DrBl9DzR6p22p3rxB3EF7l/6
         mm5Du75YtfKYGH1Je0Jv+MR7QAV/93zQ5jkSZa+gv5BTBhUy5dVOWrH7lAUFwDcBf+CC
         ptZ2TlCwprAk/I3QhZXAwQrhB30wFth2Jd9xJzKBpZOlQGZ5vPv8yvsUK1kJ+4l5B0jd
         Zz6W+Oz4F1ei5xdaGk7AmF1cyLIHBJbF5FkgWu6R8uuWmUxcHEkH5Uw1mg6oH0tUZsjC
         v2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713427461; x=1714032261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdE+GDd+xVW4HcGRxvURM0o1zWYdLwzdL6kLxqb0OOE=;
        b=UzvouYkLnB07wZ2OJTOBgDDpRFQO7bqGyWqj09zFTE4lgGa9mRsU5SLCn4tQBaXwUc
         cZtxFt2n/vi78PH3Xnmz87cKDWrmw+yZtdnMGecL8Farqm1MpMBytBdn1hwbn93fq7Hp
         pblRRxczNIIddGXSHd//n4qtwxuPqqUV7VRwkvx0B2lPW2MUngolPnn+7jWhNFHrIYfZ
         AN67hp59Cf7SF4S+pL1jFbMAAJJ1IGF4y11cgadlgkXjwOJdPiV9n3CIU14pm6be9u13
         Mm1bWvnP/SD9pB+L1FJkN0wpeMbfWoSqYnwp3nrFvEnn37UofJg1XoYZBQ2htJGSwlPi
         SX/g==
X-Forwarded-Encrypted: i=1; AJvYcCWIW6SOb3m2OBW9VAP/Cl1P2vhL8NobMLJMsOXcuziM2PWYwZl84IwiVGQUYuEp3PlIIj8bhnQceEgIJ+4ER2KZY7uDbMtQuUx3CZN6
X-Gm-Message-State: AOJu0Yy0RP8+4/0XQEI4AD69rkUR9qEk4Ne88SzklKMDLMr7DIxUyyBE
	rPC/xAQQPoGtoyhrnf5xrcR0G8/OtnNUW4WrEpkws9KGfP4ORmIG0v/QFXBjq0Q=
X-Google-Smtp-Source: AGHT+IEVugnR4wQy3I7IsKSPqj56bRVcNeKJEd48cjBH9S/PJegBr7JV09EX4I1+mt3R1Ae7rPc3eQ==
X-Received: by 2002:a17:902:7683:b0:1e2:a9f2:2abc with SMTP id m3-20020a170902768300b001e2a9f22abcmr2138579pll.23.1713427461594;
        Thu, 18 Apr 2024 01:04:21 -0700 (PDT)
Received: from localhost.localdomain ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id kr15-20020a170903080f00b001db3361bc1dsm905627plb.102.2024.04.18.01.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 01:04:21 -0700 (PDT)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	frederic@kernel.org
Cc: acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v2] perf/core: Fix missing wakeup when waiting for context reference
Date: Thu, 18 Apr 2024 08:03:56 +0000
Message-Id: <20240418080356.21639-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In our production environment, we found many hung tasks which are
blocked for more than 18 hours. Their call traces are like this:

[346278.191038] __schedule+0x2d8/0x890
[346278.191046] schedule+0x4e/0xb0
[346278.191049] perf_event_free_task+0x220/0x270
[346278.191056] ? init_wait_var_entry+0x50/0x50
[346278.191060] copy_process+0x663/0x18d0
[346278.191068] kernel_clone+0x9d/0x3d0
[346278.191072] __do_sys_clone+0x5d/0x80
[346278.191076] __x64_sys_clone+0x25/0x30
[346278.191079] do_syscall_64+0x5c/0xc0
[346278.191083] ? syscall_exit_to_user_mode+0x27/0x50
[346278.191086] ? do_syscall_64+0x69/0xc0
[346278.191088] ? irqentry_exit_to_user_mode+0x9/0x20
[346278.191092] ? irqentry_exit+0x19/0x30
[346278.191095] ? exc_page_fault+0x89/0x160
[346278.191097] ? asm_exc_page_fault+0x8/0x30
[346278.191102] entry_SYSCALL_64_after_hwframe+0x44/0xae

The task was waiting for the refcount become to 1, but from the vmcore,
we found the refcount has already been 1. It seems that the task didn't
get woken up by perf_event_release_kernel() and got stuck forever. The
below scenario may cause the problem.

Thread A					Thread B
..						...
perf_event_free_task				perf_event_release_kernel
						   ...
						   acquire event->child_mutex
						   ...
						   get_ctx
   ...						   release event->child_mutex
   acquire ctx->mutex
   ...
   perf_free_event (acquire/release event->child_mutex)
   ...
   release ctx->mutex
   wait_var_event
						   acquire ctx->mutex
						   acquire event->child_mutex
						   # move existing events to free_list
						   release event->child_mutex
						   release ctx->mutex
						   put_ctx
..						...

In this case, all events of the ctx have been freed, so we couldn't
find the ctx in free_list and Thread A will miss the wakeup. It's thus
necessary to add a wakeup after dropping the reference.

Fixes: 1cf8dfe8a661 ("perf/core: Fix race between close() and fork()")
Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
Changes since v1
- Add the fixed tag.
- Simplify v1's patch. (Frederic)
---
 kernel/events/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4f0c45ab8d7d..15c35070db6a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5340,6 +5340,7 @@ int perf_event_release_kernel(struct perf_event *event)
 again:
 	mutex_lock(&event->child_mutex);
 	list_for_each_entry(child, &event->child_list, child_list) {
+		void *var = NULL;
 
 		/*
 		 * Cannot change, child events are not migrated, see the
@@ -5380,11 +5381,23 @@ int perf_event_release_kernel(struct perf_event *event)
 			 * this can't be the last reference.
 			 */
 			put_event(event);
+		} else {
+			var = &ctx->refcount;
 		}
 
 		mutex_unlock(&event->child_mutex);
 		mutex_unlock(&ctx->mutex);
 		put_ctx(ctx);
+
+		if (var) {
+			/*
+			 * If perf_event_free_task() has deleted all events from the
+			 * ctx while the child_mutex got released above, make sure to
+			 * notify about the preceding put_ctx().
+			 */
+			smp_mb(); /* pairs with wait_var_event() */
+			wake_up_var(var);
+		}
 		goto again;
 	}
 	mutex_unlock(&event->child_mutex);
-- 
2.25.1


