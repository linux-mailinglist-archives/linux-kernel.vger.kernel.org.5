Return-Path: <linux-kernel+bounces-98579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E18877C44
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2543F1F210CD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F7213AC0;
	Mon, 11 Mar 2024 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kejk8P3p"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B2D12B9F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148052; cv=none; b=cDyojz/dbQlYoVJFFpx2nLDNU8iAOVhDFuBNlJ40Bvq5iPwVijEZIxvRMtMF+unFQOkpRielbwP/r0mKi7MPKvkQyWMeGPwk05xUTh2KFI0ELWBW1uxRCF7G9Mzz6NehJCdn3pGXPn909HTLHtpxVRkRHJWfLF4TO2+KyUOtCTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148052; c=relaxed/simple;
	bh=7plRSAhW9PVAGpDLxKsTlu8IkcSx+fLXmjVmhGULfrA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JMbpTFogPOOrtrOzfwFh3dMM7sJ0Rway9QYATHpIDClBT8WorJOOSYzsujT8hIGfDlSoJICcwGEGDkpgzeIo7lD9hCVKZgoStpiLyHmNqaZto0l97JdbhZovPRhhjTqPGL2GEuqtOyg+oJwg+AWhA0fhBHkSlozbYxM+GXMjWgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kejk8P3p; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc1ff3ba1aso30142645ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 02:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710148050; x=1710752850; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3DlyjWGIITx2VH8cD/6MnPUPaf/4SRE3uVuhE1pwquY=;
        b=Kejk8P3pp0ZqG7eru3iEOO0N14kZxYl3nPTfRSfKAvlSTmyUmMBuE5159pybcOWTkX
         N+gOY7MxLKH3dHhuh9mPEDvN5T84ag7ocDo+AMU9Wp47+o5HYevScThhLxpzvFD/pST8
         n2POP2oh2aAsFa3cWnVq1IEFoa4Ckz2F54dsKBNjhZydjOvYt2k+RKu2O83GpiW22SXv
         gJa97qABiJSS0ZIsGCY2724l3va+mumIIr+QXnQCW6jrQNLE4GJfLEAJQ2dP58tR2k4r
         7iNuCmuRbD2Ilk4p8kOvYjXXPkL7g+J3ZCgx27KcXsrWhjmA+iaF6K14jEKVaiC8K4iR
         9U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710148050; x=1710752850;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DlyjWGIITx2VH8cD/6MnPUPaf/4SRE3uVuhE1pwquY=;
        b=n8nvT8s2P5JCMlyUBBbGV3TZWB+aA7pn1mRF5e1/SDm8ldUV/x0SHZRNQ3wzpLWmVN
         3x4L0XQjFk7wd/JlW96MErlvAEuVDxD+FQayO/P6eZa+xXmt8Ui+OYgAjR6uiI77u+PB
         pnyjnOp0yAvMSvhu0PMZDs1XazP80KA+hApY1Py+SRhW3dC+S3Z37JiBCZ7FJWO5+lmN
         h21m7kExfeOqBUFRp7i1cobUsRIoWRbCcqsqEsFpXqGaYSfAoJazrOKo4wVAvx77v1nm
         dk+VyLjg2UKeU8zx8EtSmIbGlGZj7TkrxHTxgdbrRpt/p6+agoZWzJ+mNmvFNQ3jvNJA
         cijw==
X-Gm-Message-State: AOJu0Yys3V9ME/Xy+whE7W1RhvwPzI/3E9PHayXxQVHtk2oW3hBjm09Z
	skYinf7EN64XIKd1KAYqrH9QXw6IlP536t+ZTnwRsxwYXFWl/J2OQO8Jnb+v
X-Google-Smtp-Source: AGHT+IFzT85MOcW4gsDVn3XJukLBS25ZM9BoSbau80wLtQdxrhS0YErZFrWXwXt0BA2cJnyih2Yhvw==
X-Received: by 2002:a17:903:182:b0:1dc:2120:2467 with SMTP id z2-20020a170903018200b001dc21202467mr6685371plg.44.1710148049479;
        Mon, 11 Mar 2024 02:07:29 -0700 (PDT)
Received: from localhost ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id n6-20020a170903110600b001db717ed294sm4173857plh.120.2024.03.11.02.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 02:07:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 10 Mar 2024 23:07:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue changes for v6.9
Message-ID: <Ze7Jz9cQcUMtCqfk@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit aac8a59537dfc704ff344f1aacfd143c089ee20f:

  Revert "workqueue: Override implicit ordered attribute in workqueue_apply_unbound_cpumask()" (2024-02-05 15:49:06 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.9

for you to fetch changes up to 1acd92d95fa24edca8f0292b21870025da93e24f:

  workqueue: Drain BH work items on hot-unplugged CPUs (2024-02-29 11:51:24 -1000)

----------------------------------------------------------------
workqueue: Changes for v6.9

This cycle, a lot of workqueue changes including some that are significant
and invasive.

- During v6.6 cycle, unbound workqueues were updated so that they are more
  topology aware and flexible, which among other things improved workqueue
  behavior on modern multi-L3 CPUs. In the process, 636b927eba5b
  ("workqueue: Make unbound workqueues to use per-cpu pool_workqueues")
  switched unbound workqueues to use per-CPU frontend pool_workqueues as a
  part of increasing front-back mapping flexibility.

  An unwelcome side effect of this change was that this made max concurrency
  enforcement per-CPU blowing up the maximum number of allowed concurrent
  executions. I incorrectly assumed that this wouldn't cause practical
  problems as most unbound workqueue users are self-regulate max
  concurrency; however, there definitely are which don't (e.g. on IO paths)
  and the drastic increase in the allowed max concurrency led to noticeable
  perf regressions in some use cases.

  This is now addressed by separating out max concurrency enforcement to a
  separate struct - wq_node_nr_active - which makes @max_active consistently
  mean system-wide max concurrency regardless of the number of CPUs or
  (finally) NUMA nodes. This is a rather invasive and, in places, a bit
  clunky; however, the clunkiness rises from the the inherent requirement to
  handle the disagreement between the execution locality domain and max
  concurrency enforcement domain on some modern machines. See 5797b1c18919
  ("workqueue: Implement system-wide nr_active enforcement for unbound
  workqueues") for more details.

- BH workqueue support is added. They are similar to per-CPU workqueues but
  execute work items in the softirq context. This is expected to replace
  tasklet. However, currently, it's missing the ability to disable and
  enable work items which is needed to convert many tasklet users. To avoid
  crowding this merge window too much, this will be included in the next
  merge window. A separate pull request will be sent for the couple
  conversion patches that are currently pending.

- Waiman plugged a long-standing hole in workqueue CPU isolation where
  ordered workqueues didn't follow wq_unbound_cpumask updates. Ordered
  workqueues now follow the same rules as other unbound workqueues.

- More CPU isolation improvements: Juri fixed another deficit in workqueue
  isolation where unbound rescuers don't respect wq_unbound_cpumask.
  Leonardo fixed delayed_work timers firing on isolated CPUs.

- Other misc changes.

----------------------------------------------------------------
Allen Pais (1):
      workqueue: Introduce from_work() helper for cleaner callback declarations

Audra Mitchell (2):
      workqueue.c: Increase workqueue name length
      workqueue: Shorten events_freezable_power_efficient name

Juri Lelli (3):
      tools/workqueue: Add rescuers printing to wq_dump.py
      kernel/workqueue: Bind rescuer to unbound cpumask for WQ_UNBOUND
      kernel/workqueue: Let rescuers follow unbound wq cpumask changes

Leonardo Bras (1):
      workqueue: Avoid using isolated cpus' timers on queue_delayed_work

Marcelo Tosatti (1):
      workqueue: mark power efficient workqueue as unbounded if nohz_full enabled

Miguel Ojeda (1):
      workqueue: rust: sync with `WORK_CPU_UNBOUND` change

Ricardo B. Marliere (1):
      workqueue: make wq_subsys const

Tejun Heo (37):
      tools/workqueue/wq_dump.py: Clean up code and drop duplicate information
      workqueue: Drop unnecessary kick_pool() in create_worker()
      workqueue: Break up enum definitions and give names to the types
      workqueue: Move pwq->max_active to wq->max_active
      workqueue: Factor out pwq_is_empty()
      workqueue: Replace pwq_activate_inactive_work() with [__]pwq_activate_work()
      workqueue: Move nr_active handling into helpers
      workqueue: Make wq_adjust_max_active() round-robin pwqs while activating
      workqueue: RCU protect wq->dfl_pwq and implement accessors for it
      workqueue: Move pwq_dec_nr_in_flight() to the end of work item handling
      workqueue: Introduce struct wq_node_nr_active
      workqueue: Implement system-wide nr_active enforcement for unbound workqueues
      tools/workqueue/wq_dump.py: Add node_nr/max_active dump
      workqueue: Don't call cpumask_test_cpu() with -1 CPU in wq_update_node_max_active()
      workqueue: Avoid premature init of wq->node_nr_active[].max
      workqueue: Fix pwq->nr_in_flight corruption in try_to_grab_pending()
      workqueue: Update lock debugging code
      workqueue: Factor out init_cpu_worker_pool()
      workqueue: Implement BH workqueues to eventually replace tasklets
      Revert "workqueue: make wq_subsys const"
      workqueue: Don't implicitly make UNBOUND workqueues w/ @max_active==1 ordered
      Merge branch 'for-6.8-fixes' into for-6.9
      workqueue: Implement workqueue_set_min_active()
      async: Use a dedicated unbound workqueue with raised min_active
      workqueue: Fix queue_work_on() with BH workqueues
      workqueue, irq_work: Build fix for !CONFIG_IRQ_WORK
      workqueue: Cosmetic changes
      workqueue: Use rcu_read_lock_any_held() instead of rcu_read_lock_held()
      workqueue: Rename __cancel_work_timer() to __cancel_timer_sync()
      workqueue: Reorganize flush and cancel[_sync] functions
      workqueue: Use variable name irq_flags for saving local irq flags
      workqueue: Introduce work_cancel_flags
      workqueue: Clean up enum work_bits and related constants
      workqueue: Factor out work_grab_pending() from __cancel_work_sync()
      workqueue: Remove clear_work_data()
      workqueue: Make @flags handling consistent across set_work_data() and friends
      workqueue: Drain BH work items on hot-unplugged CPUs

Waiman Long (5):
      workqueue: Skip __WQ_DESTROYING workqueues when updating global unbound cpumask
      workqueue: Link pwq's into wq->pwqs from oldest to newest
      workqueue: Enable unbound cpumask update on ordered workqueues
      workqueue: Bind unbound workqueue rescuer to wq_unbound_cpumask
      workqueue: Fix kernel-doc comment of unplug_oldest_pwq()

Wang Jinchao (1):
      workqueue: fix a typo in comment

Xuewen Yan (2):
      workqueue: Add rcu lock check at the end of work item execution
      workqueue: Control intensive warning threshold through cmdline

 Documentation/admin-guide/kernel-parameters.txt |    9 +
 Documentation/core-api/workqueue.rst            |   43 +-
 include/linux/async.h                           |    1 +
 include/linux/workqueue.h                       |  141 +-
 init/Kconfig                                    |    2 +-
 init/main.c                                     |    1 +
 kernel/async.c                                  |   17 +-
 kernel/softirq.c                                |    5 +
 kernel/workqueue.c                              | 1891 +++++++++++++++++------
 rust/kernel/workqueue.rs                        |    6 +-
 tools/workqueue/wq_dump.py                      |  104 +-
 11 files changed, 1690 insertions(+), 530 deletions(-)

-- 
tejun

