Return-Path: <linux-kernel+bounces-25129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 889C882C852
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14DE91F236EF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1851E376;
	Sat, 13 Jan 2024 00:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a40PLkwe"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E35364
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 00:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ddeb7b4366so2458009a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 16:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705105754; x=1705710554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=eSG5ztmcIaHot7lAtpsgHB4EezOFFUn1/h9jzxA+QYE=;
        b=a40PLkweHsIubsq2jPc0APtm5F4istQjqngzFEmVQb7qmM5INDghHdT6p44nRWt+JS
         jCD3hm4cn8gpOOZDiNIAa538Y3LJqKv1slGhfkjM3XHWK2A3LYlLJoVjvCquNhwZUGzg
         pnCqVtokLJeKM2/PM0RM/all5dr9rdVhVySf1EKmR41UTOqUJezEkykrIeZc684PI24a
         0Yydf0XC/ESnl8J8cMETzbRdb0rYpR7bX6xIIDBWTI8qihAlTMRf8blvHIz43aPOlYpN
         2u6W2nHMygU+Qtfxx0FC/T5fMG3gMv6laU2qMLdIgGx73MOLCunGcnXSIYYDMnX55b1d
         o2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705105754; x=1705710554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSG5ztmcIaHot7lAtpsgHB4EezOFFUn1/h9jzxA+QYE=;
        b=SJlDIdeZ+V6+o0HMFJMzq8ieHhhcofZCm7mlzkQei6jKNaBRc+sQ60jZBzKmewFRjL
         WL/KGGDSS++mduIffsp3WGdYZKbGFgmRm/4okXBU3ygNO8JCj/VH03m76Hcp8Qs8utbn
         aSFwTmAKmfPgnjmZWZcz0PVYKssdtolEnIO1X98Qqe20NJ0miWmrQB7oXUV/jJEc4jXV
         Hmc/tAdsCsrQQjlWBxTrADtf8GE5IsSAry6Xxg8l8Q63SoyJrYdvc0RpwFpjGG/n4aSg
         wBMrO+9gFXwGkguT3P4Kr1cHwL6YR507Qre2mCeJ7X5s9E60IPIEOXFQwQs15UiiSLh7
         9u0A==
X-Gm-Message-State: AOJu0Yxe0W5rd1Ps2DTQhTxiIWTvg7LJj9ERe2jZANepIjvrA1UtZ8EK
	WSh0mvtCLR+IdFRlffkkvAw=
X-Google-Smtp-Source: AGHT+IGKkykmK2v9uX/+XFjR2c1sdlkgHaS/ANv/GEwJUpurH0dMI49JsWQZWl26fkhMgvKe+qRH1A==
X-Received: by 2002:a05:6808:3a0e:b0:3bd:4bcf:42bb with SMTP id gr14-20020a0568083a0e00b003bd4bcf42bbmr2511334oib.4.1705105754389;
        Fri, 12 Jan 2024 16:29:14 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id pl9-20020a17090b268900b0028e027c13edsm2859295pjb.7.2024.01.12.16.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 16:29:13 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: [PATCHSET v2 wq/for-6.8] workqueue: Implement system-wide max_active for unbound workqueues
Date: Fri, 12 Jan 2024 14:28:44 -1000
Message-ID: <20240113002911.406791-1-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is v2. Changes from v1
(http://lkml.kernel.org/r/20231220072529.1036099-1-tj@kernel.org):

- wq->max_active now uses WRITE/READ_ONCE() as suggested by Lai.

- __queue_work() is updated to alwyas delay the work item if there already
  are inactive work items on the pwq. This prevents work item reordering
  inside the pwq when max_active is increased thus maintaining execution
  order for ordered workqueues. This issue was noticed by Lai.

- In 0008-workqueue-Introduce-struct-wq_node_nr_active.patch, Lai pointed
  out that pwq_tryinc_nr_active() incorrectly dropped pwq->max_active check.
  Restored. As the next patch replaces the max_active enforcement mechanism,
  this doesn't change the end result.

- 0010-workqueue-Reimplement-ordered-workqueue-using-shared.patch was broken
  and could reorder work items in ordered workqueues leading to severe perf
  regressions and hangs with certain workloads. Dropped.

A pool_workqueue (pwq) represents the connection between a workqueue and a
worker_pool. One of the roles that a pwq plays is enforcement of the
max_active concurrency limit. Before 636b927eba5b ("workqueue: Make unbound
workqueues to use per-cpu pool_workqueues"), there was one pwq per each CPU
for per-cpu workqueues and per each NUMA node for unbound workqueues, which
was a natural result of per-cpu workqueues being served by per-cpu pools and
unbound by per-NUMA pools.

In terms of max_active enforcement, this was, while not perfect, workable.
For per-cpu workqueues, it was fine. For unbound, it wasn't great in that
NUMA machines would get max_active that's multiplied by the number of nodes
but didn't cause huge problems because NUMA machines are relatively rare and
the node count is usually pretty low.

However, cache layouts are more complex now and sharing a worker pool across
a whole node didn't really work well for unbound workqueues. Thus, a series
of commits culminating on 8639ecebc9b1 ("workqueue: Make unbound workqueues
to use per-cpu pool_workqueues") implemented more flexible affinity
mechanism for unbound workqueues which enables using e.g. last-level-cache
aligned pools. In the process, 636b927eba5b ("workqueue: Make unbound
workqueues to use per-cpu pool_workqueues") made unbound workqueues use
per-cpu pwqs like per-cpu workqueues.

While the change was necessary to enable more flexible affinity scopes, this
came with the side effect of blowing up the effective max_active for unbound
workqueues. Before, the effective max_active for unbound workqueues was
multiplied by the number of nodes. After, by the number of CPUs.

636b927eba5b ("workqueue: Make unbound workqueues to use per-cpu
pool_workqueues") claims that this should generally be okay. It is okay for
users which self-regulates concurrency level which are the vast majority;
however, there are enough use cases which actually depend on max_active to
prevent the level of concurrency from going bonkers including several IO
handling workqueues that can issue a work item for each in-flight IO. With
targeted benchmarks, the misbehavior can easily be exposed as reported in
http://lkml.kernel.org/r/dbu6wiwu3sdhmhikb2w6lns7b27gbobfavhjj57kwi2quafgwl@htjcc5oikcr3.

Unfortunately, there is no way to express what these use cases need using
per-cpu max_active. A CPU may issue most of in-flight IOs, so we don't want
to set max_active too low but as soon as we increase max_active a bit, we
can end up with unreasonable number of in-flight work items when many CPUs
issue IOs at the same time. ie. The acceptable lowest max_active is higher
than the acceptable highest max_active.

Ideally, max_active for an unbound workqueue should be system-wide so that
the users can regulate the total level of concurrency regardless of node and
cache layout. The reasons workqueue hasn't implemented that yet are:

- One max_active enforcement decouples from pool boundaires, chaining
  execution after a work item finishes requires inter-pool operations which
  would require lock dancing, which is nasty.

- Sharing a single nr_active count across the whole system can be pretty
  expensive on NUMA machines.

- Per-pwq enforcement had been more or less okay while we were using
  per-node pools.

It looks like we no longer can avoid decoupling max_active enforcement from
pool boundaries. This patchset implements system-wide nr_active mechanism
with the following design characteristics:

- To avoid sharing a single counter across multiple nodes, the configured
  max_active is split across nodes according to the proportion of online
  CPUs per node. e.g. A node with twice more online CPUs will get twice
  higher portion of max_active.

- Workqueue used to be able to process a chain of interdependent work items
  which is as long as max_active. We can't do this anymore as max_active is
  distributed across the nodes. Instead, a new parameter min_active is
  introduced which determines the minimum level of concurrency within a node
  regardless of how max_active distribution comes out to be.

  It is set to the smaller of max_active and WQ_DFL_MIN_ACTIVE which is 8.
  This can lead to higher effective max_weight than configured and also
  deadlocks if a workqueue was depending on being able to handle chains of
  interdependent work items that are longer than 8.

  I believe these should be fine given that the number of CPUs in each NUMA
  node is usually higher than 8 and work item chain longer than 8 is pretty
  unlikely. However, if these assumptions turn out to be wrong, we'll need
  to add an interface to adjust min_active.

- Each unbound wq has an array of struct wq_node_nr_active which tracks
  per-node nr_active. When its pwq wants to run a work item, it has to
  obtain the matching node's nr_active. If over the node's max_active, the
  pwq is queued on wq_node_nr_active->pending_pwqs. As work items finish,
  the completion path round-robins the pending pwqs activating the first
  inactive work item of each, which involves some pool lock dancing and
  kicking other pools. It's not the simplest code but doesn't look too bad.

This patchset includes the following patches:

 0001-workqueue-Move-pwq-max_active-to-wq-max_active.patch
 0002-workqueue-Factor-out-pwq_is_empty.patch
 0003-workqueue-Replace-pwq_activate_inactive_work-with-__.patch
 0004-workqueue-Move-nr_active-handling-into-helpers.patch
 0005-workqueue-Make-wq_adjust_max_active-round-robin-pwqs.patch
 0006-workqueue-Add-first_possible_node-and-node_nr_cpus.patch
 0007-workqueue-Move-pwq_dec_nr_in_flight-to-the-end-of-wo.patch
 0008-workqueue-Introduce-struct-wq_node_nr_active.patch
 0009-workqueue-Implement-system-wide-nr_active-enforcemen.patch

This pachset is also available in the following git branch.

 https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git unbound-system-wide-max_active-v2

diffstat follows.

 include/linux/workqueue.h |   35 ++
 kernel/workqueue.c        |  644 ++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 576 insertions(+), 103 deletions(-)

--
tejun

