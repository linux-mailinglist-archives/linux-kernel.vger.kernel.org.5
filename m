Return-Path: <linux-kernel+bounces-149991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEF18A98D8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F267B2254A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7006E15E803;
	Thu, 18 Apr 2024 11:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="TLiNkAyj"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBA015E5BC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440544; cv=none; b=DT+RcdE3NnOCTVE5MMZMViWWJTJpRiAWVDQ8HNoYG8aLOf2Yw1K3JiWQwA+uy8hGqyXfaeFBR7x0wPh82hWq3p1i6lBiJVmLaoVs2U9tweFRzVZnE2L7VzBetSpFDcUF0aVwhAllzzFWslP2PHxyaAICWLPMkOcQSdIBLSnwkFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440544; c=relaxed/simple;
	bh=ytMaJqyg9zf7adMfPzz8lLdVsAjH7idIhqxx16pyfVk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iw86TmXxNmGSg2Ah164uAjgKmKrjuvuV5U7Om7EPOvG5d0gfg0Q0eI9WjELCs8cWvxTQunDOUW+r8x8j5xVKQVmp+w7cB0wpz1uB3wIMeL4vz3spKH0If56sWshiOuoDdzilxGzh+mZH8ljrvP54eNeU+EpKwGVikuoi+6czlsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=TLiNkAyj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e2c725e234so14788995ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 04:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1713440542; x=1714045342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+0fSMosEc0GfSuz2R1ztbj1Ka0piZP84Pfqpm8EYeOw=;
        b=TLiNkAyjKlBpzFIV6gIMIlMApi0JvdXxnLEjUOT/IExPVHoDfRj/G8jdXvDrtm8Um4
         gewYLLtF7g+WbOs0hR8HAevH5Ebe1tu2+wjMtZOmx0uA28Y/WTAEpIbcEyQ5gPKWt4Aq
         SIkOxRHF9wUfhGXjKCHW76TqLmRFU7b5mO1U+yb36IwpKahtQGCtxiDTkHe4NAiMhsfQ
         XLMU+j+yPtgFQUoHHUqOQTCglSl8/6nR2Im8NJ9dAaf8hmYDerbrQdFHxq9ndxXMD+UT
         nn4vxKsFbGkVMYcJYHt8U2q2Zrt14CrvJvolnTevXZ9TIRKc6SSr6+1tALaxEp82u5OB
         xBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713440542; x=1714045342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0fSMosEc0GfSuz2R1ztbj1Ka0piZP84Pfqpm8EYeOw=;
        b=DtmJSzcqnpyPY0IOvT3pd6dInfdaNFsI1W9kn1DzTAZF4CFJTuRxfB0Fz/uCNAG6D0
         WQq2ynyyVuh9W0OCG0PaWBFI/d5VFytb/MGR0jsvvnZ+JvuIjxATF42TZLfgNQJykKBG
         psVnpAXaJJOstE/nH50q32YV+BSKgpLGRnWI3EM+RMkVIg2lj6TOer0tuYrwygXyMcL+
         oeV0rcL5akJK+eNgTCaZEcnbKtnHdFRG7eGUD3o1HJ1PUd8+fWiiggpHx1+kgjRZv4tt
         KV42zyLq7DKkk1Behmi02dK2hA8qAN6zgSL7zImhl7o0ZvGynKIqCaNLpRFD7KrJjRAv
         8kjw==
X-Forwarded-Encrypted: i=1; AJvYcCW8BN1HHjvixbabReXrEYR8ZZ4bpoXs+1Y7YE6Cb2K5cETGR0SxS567YDIuAO9dk3jvtjYtqZwHF6PIjLC/h7LhaciopJnXs5skQ7BY
X-Gm-Message-State: AOJu0YyCdZSQX5We12TWeJiLvSqCV8DncNSkiXOJf1Xc3+oFwGurYsLT
	qbEEMIXlav5jBNa7wDOmhPLRSOwSjKsRiw+upcaMGEjRmFTw/Z1zTD+H02kuZm8=
X-Google-Smtp-Source: AGHT+IEGhLzO8tdC2RFtIqL97YSISRu4T45ilDZUX0jzJBPVbnIACyD61LrVqqnY/2ZWl38G615JaA==
X-Received: by 2002:a17:902:ce91:b0:1e0:ab65:85e5 with SMTP id f17-20020a170902ce9100b001e0ab6585e5mr3435636plg.1.1713440542651;
        Thu, 18 Apr 2024 04:42:22 -0700 (PDT)
Received: from localhost.localdomain ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id bi2-20020a170902bf0200b001e27ad5199csm1309945plb.281.2024.04.18.04.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 04:42:22 -0700 (PDT)
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
Subject: [PATCH v3] perf/core: Fix missing wakeup when waiting for context reference
Date: Thu, 18 Apr 2024 11:42:09 +0000
Message-Id: <20240418114209.22233-1-haifeng.xu@shopee.com>
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
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
Changes since v1:
- Add the fixed tag.
- Simplify v1's patch. (Frederic)

Changes since v2:
- Use Reviewed-by tag instead of Signed-off-by tag.
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


