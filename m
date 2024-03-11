Return-Path: <linux-kernel+bounces-98753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A04877ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E39C1F20EDC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C28F39AFE;
	Mon, 11 Mar 2024 11:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1pK8iGZ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2D438FA5
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710156018; cv=none; b=g3nkq8AZ6xLhMFz+Vpp/zZ/A5jeZ3GItO8KUxGYAuK3F+S9rwzHZTO0WysLGOAyh7OnSEzXgEWuXD3cD+GTMzokBLt0bn62EgQEw6LU3oYtZ9tQ5GnGuNn2CFqFqiScujyJkde42Usp+YuIOUcZEfiOuze2HPlRi4yhjrRRXKJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710156018; c=relaxed/simple;
	bh=7gR6nxk/AhMCyWhGFFMd+R2W12dLnV/8JFaUG3zDfNc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rmGZEdUE2iuAKEuco2ytDzzSm1ANLynlwdzzxP0PVx8+wAj1uX58f08b0sQT78HmvHnu89jimRyO6vG+J6XQkHwUjrn2QybIpz74S7Zpnp/CBinrl0DpA1+fuGAKJ4v1gJ6UnYWXTGsGQWgtNMvnVkP3F9RmvT0FaJkOHlP2ceM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1pK8iGZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412f55695d1so30566265e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 04:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710156015; x=1710760815; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=L3bqXKmt2bYlEp5BUzVnVe4DifTTWqBP9LykjAj8e3w=;
        b=P1pK8iGZDp6HsvhVENH1+e7t8ILLIGv1Ad5x6eQDdRV+RArWbU3rDPYQwPv2HIj7wU
         z+0uPFxxS8tfiNEna+e3na9E/2X+2I+VEI0WLE/On4l6gGVr7gtjXUtniZLXOqsunYXK
         8xpoyuVqqeVWV2uKUIUeCviGlsB0AQ7lRn/LRIaB0EHrDDJ8aD7uG/kZZXJKQIZjQ/CO
         2s55k0F+zMlya/ainx+rrxqvoS8c3zCRn9WoISMiRUIcui5QY0z9e5w3iUtDIy7zssmn
         xXDhS4HZBwZzJSxxzd7mFAkTtLN1SCUpIPQ7FI0UrQu8s3XQ6iVfNRTucvdafxJifYuD
         u1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710156015; x=1710760815;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3bqXKmt2bYlEp5BUzVnVe4DifTTWqBP9LykjAj8e3w=;
        b=faZVZr01z29DU7mpGIuG1ExLTUhqkdwbIA7WXHFGJx3S9LXpZ/CREgEN/xACeVEHrB
         huBFY/xhadGy9wc4tmU+0lIycUW9lbvzLpSZUCs+e3vA0tLKxHroOm5dr++kV/W0Z89c
         Inp6MkxiHbwIbq/Ba18v8h6hFpVk0NLB/pB85x9o5Ab5HdtD9YvWB8imjoqhIlfEObJZ
         W+aMN09VLbyGwDplLoyIWMEheBv17qFpwgTEtkNor9ycvTzo8+ewiK8TAt0lbgjoizyQ
         q7W9UNkQ/gQaDfOWTPBxw3aGalT2UbokkuiHYSnnTZLTCMnI8Kz7nIiq9xMC2R2W7xdX
         sFcw==
X-Gm-Message-State: AOJu0YxHuMw9Xe3K4/ew5FsahzQCYReWKdUf4dqI5h12Novo1A9cJUut
	WdC8k+6cbDaXry3tvLM4WqK2Q4TYPrBl71zrK1Ax6l4Z3aJCdrxV
X-Google-Smtp-Source: AGHT+IE9ersZtF9PKMXKLO3MROMxi0F0Rz0rWH05O5CXJ+mICTJhT5LkmTHruHCrXAsYakoj+8MhKA==
X-Received: by 2002:a05:600c:3584:b0:412:bcc1:44cc with SMTP id p4-20020a05600c358400b00412bcc144ccmr4532399wmq.3.1710156014618;
        Mon, 11 Mar 2024 04:20:14 -0700 (PDT)
Received: from gmail.com (1F2EF295.nat.pool.telekom.hu. [31.46.242.149])
        by smtp.gmail.com with ESMTPSA id fb7-20020a05600c520700b0041328d0440csm4168100wmb.31.2024.03.11.04.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 04:20:14 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 11 Mar 2024 12:20:12 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] locking changes for v6.9
Message-ID: <Ze7o7FAK8QkRLg7o@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest locking/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2024-03-11

   # HEAD: ce3576ebd62d99f79c1dc98824e2ef6d6ab68434 locking/rtmutex: Use try_cmpxchg_relaxed() in mark_rt_mutex_waiters()

Locking changes for v6.9:

- Micro-optimize local_xchg() and the rtmutex code on x86

- Fix percpu-rwsem contention tracepoints

- Simplify debugging Kconfig dependencies

- Update/clarify the documentation of atomic primitives

- Misc cleanups

Thanks,

	Ingo

------------------>
Mark Rutland (1):
      locking/atomic: scripts: Clarify ordering of conditional atomics

Namhyung Kim (1):
      locking/percpu-rwsem: Trigger contention tracepoints only if contended

Uros Bizjak (2):
      locking/x86: Implement local_xchg() using CMPXCHG without the LOCK prefix
      locking/rtmutex: Use try_cmpxchg_relaxed() in mark_rt_mutex_waiters()

Waiman Long (4):
      locking/qspinlock: Fix 'wait_early' set but not used warning
      locking/mutex: Simplify <linux/mutex.h>
      locking/rwsem: Clarify that RWSEM_READER_OWNED is just a hint
      locking/rwsem: Make DEBUG_RWSEMS and PREEMPT_RT mutually exclusive


 arch/x86/include/asm/local.h                 | 16 ++++++-
 include/linux/atomic/atomic-arch-fallback.h  | 46 +++++++++++++++----
 include/linux/atomic/atomic-instrumented.h   | 68 ++++++++++++++++++++++------
 include/linux/atomic/atomic-long.h           | 24 ++++++++--
 include/linux/mutex.h                        |  8 +---
 kernel/locking/percpu-rwsem.c                | 11 +++--
 kernel/locking/qspinlock_paravirt.h          |  2 +-
 kernel/locking/rtmutex.c                     |  9 ++--
 kernel/locking/rwsem.c                       |  6 +--
 lib/Kconfig.debug                            |  4 +-
 scripts/atomic/kerneldoc/add_unless          |  1 +
 scripts/atomic/kerneldoc/cmpxchg             |  1 +
 scripts/atomic/kerneldoc/dec_if_positive     |  1 +
 scripts/atomic/kerneldoc/dec_unless_positive |  1 +
 scripts/atomic/kerneldoc/inc_not_zero        |  1 +
 scripts/atomic/kerneldoc/inc_unless_negative |  1 +
 scripts/atomic/kerneldoc/try_cmpxchg         |  3 +-
 17 files changed, 154 insertions(+), 49 deletions(-)

