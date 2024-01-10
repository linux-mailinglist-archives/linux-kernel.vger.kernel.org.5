Return-Path: <linux-kernel+bounces-22830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BA182A389
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23ACE289652
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B214F61B;
	Wed, 10 Jan 2024 21:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r6DTsFSp"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72854F215
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 21:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e8d2c6903dso84443457b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 13:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704923246; x=1705528046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6p1hBmNml7DeDzdJa+1WobRgf/Iw6SsQVkEkIZa3BaE=;
        b=r6DTsFSpEcv8G6bSRwpZLFHmk5GBh0FithI/hNhrFNvl5lQ/tj37i6juxUz9A4Xhxq
         65DBnIoAty1fjHXoZuKjPyVhWvpqfL1R9mkexPH+xstNdGz1ULfIrtI/cJJbEQhR1oI2
         mUb5M1XkxE49z3TSpsmMgr6qgQA2goZBbCUQFk3aGjpInpSUiKAR8vfohgEQPhChQvO3
         cKgkcE4JgG20C3oohq59nSMnu12UG01v0DKVixz3urobIKUPOisnKuW/L2eSlY0tPHqe
         /gKJm+FDU96+82REoY2DXwyP+DaZXb+k+qAN6nZwxoNaF101boxw5lZFC7u2x6X4443l
         gc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704923246; x=1705528046;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6p1hBmNml7DeDzdJa+1WobRgf/Iw6SsQVkEkIZa3BaE=;
        b=fBehqejplhFC7Ymp00A8mpY1Al7a6WoDO0jIU7xicDeyX4NL5W9rCuYZXKlgf7okQA
         ndA5uLHWd2eKsDmH2nvhvP1SRYizLwzb6IimDBBAK8EMPZMNX4dxEHA4/sCAbBmR6W2F
         OkF9ksVXbJ8ht8lb2yXdiq1O9IOv6gtIp0ngxuwt9neB5hMo+GMTvDz3/5TitGBvm49r
         pWTVY8g1We0HfRP/k3jTDbTPz4Rs73V6+YBq0u37E/78qGU3/YS+wdTLue61x9x5iO/K
         jt1BqZyH1km6XLleFVFLWud2ogpl5a0e3sMz0BuHQyPaPpbeZy+o3dZHrKiKbGoznFXn
         Rgwg==
X-Gm-Message-State: AOJu0YxM04Eo7Ismpk/1vQ3D4cYmrw/dSV+1Ayx3quUUTlLTfFkUZmP8
	RdJ9JlrhW5v28lDpwvM/IpqU0GJGtB/hBnXYOQ==
X-Google-Smtp-Source: AGHT+IGA5EvoPwhd709VB9Qt9NhwFdsNPCdpzzC+ZCGDSgkR5dIAht+xU4zvLxL6DWThNVopzTKVguoOm6Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2488:b0:db5:3ce2:7977 with SMTP id
 ds8-20020a056902248800b00db53ce27977mr107975ybb.7.1704923246713; Wed, 10 Jan
 2024 13:47:26 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 10 Jan 2024 13:47:23 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240110214723.695930-1-seanjc@google.com>
Subject: [PATCH] sched/core: Drop spinlocks on contention iff kernel is preemptible
From: Sean Christopherson <seanjc@google.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, 
	Valentin Schneider <valentin.schneider@arm.com>, Marco Elver <elver@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, David Matlack <dmatlack@google.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Use preempt_model_preemptible() to detect a preemptible kernel when
deciding whether or not to reschedule in order to drop a contended
spinlock or rwlock.  Because PREEMPT_DYNAMIC selects PREEMPTION, kernels
built with PREEMPT_DYNAMIC=y will yield contended locks even if the live
preemption model is "none" or "voluntary".  In short, make kernels with
dynamically selected models behave the same as kernels with statically
selected models.

Somewhat counter-intuitively, NOT yielding a lock can provide better
latency for the relevant tasks/processes.  E.g. KVM x86's mmu_lock, a
rwlock, is often contended between an invalidation event (takes mmu_lock
for write) and a vCPU servicing a guest page fault (takes mmu_lock for
read).  For _some_ setups, letting the invalidation task complete even
if there is mmu_lock contention provides lower latency for *all* tasks,
i.e. the invalidation completes sooner *and* the vCPU services the guest
page fault sooner.

But even KVM's mmu_lock behavior isn't uniform, e.g. the "best" behavior
can vary depending on the host VMM, the guest workload, the number of
vCPUs, the number of pCPUs in the host, why there is lock contention, etc.

In other words, simply deleting the CONFIG_PREEMPTION guard (or doing the
opposite and removing contention yielding entirely) needs to come with a
big pile of data proving that changing the status quo is a net positive.

Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Marco Elver <elver@google.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: David Matlack <dmatlack@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/sched.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 03bfe9ab2951..51550e64ce14 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2229,11 +2229,10 @@ static inline bool preempt_model_preemptible(void)
  */
 static inline int spin_needbreak(spinlock_t *lock)
 {
-#ifdef CONFIG_PREEMPTION
+	if (!preempt_model_preemptible())
+		return 0;
+
 	return spin_is_contended(lock);
-#else
-	return 0;
-#endif
 }
 
 /*
@@ -2246,11 +2245,10 @@ static inline int spin_needbreak(spinlock_t *lock)
  */
 static inline int rwlock_needbreak(rwlock_t *lock)
 {
-#ifdef CONFIG_PREEMPTION
+	if (!preempt_model_preemptible())
+		return 0;
+
 	return rwlock_is_contended(lock);
-#else
-	return 0;
-#endif
 }
 
 static __always_inline bool need_resched(void)

base-commit: cdb3033e191fd03da2d7da23b9cd448dfa180a8e
-- 
2.43.0.275.g3460e3d667-goog


