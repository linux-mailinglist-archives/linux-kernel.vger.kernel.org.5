Return-Path: <linux-kernel+bounces-6471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0690581996A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82AA11F250F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C7E16406;
	Wed, 20 Dec 2023 07:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqxQGuso"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1AA15AD8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d741fb7c8eso2986503b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703057138; x=1703661938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=R5h4lTp5SH1LWWHdJcXtWzewa9a0adEXqrl9aAx0e+c=;
        b=SqxQGusoOemsBsaTDMUgoLEmvpiEWME6N+3tzECaVrmt4nbpwaXFZD60dr/r1m6fxq
         f8X8IjzQFf+Ypz1ikn53nYYkXm2WeI88It4dcb5J2Oh3ckRuWxmXCztRO9HDe3RQ7EG8
         SglQ5+3bIEf7i7Jr/1sOBoHguvw9CRVy2GDRVMoMEkHCfxcUneWCmqccSG+FRo/7EFQV
         WMC+tftre1BWBFCirIcPcBllVwYcZec+hLHwCy9BrwPyUkq3KH0mjSLlexjkeKRe4Vbg
         YvS8okIButqrFohL6blSWUXNKbKVUSzDMzCrJKpzC5oFWzsl1ENmpMZ3peMGduJZ5B5e
         01Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703057138; x=1703661938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5h4lTp5SH1LWWHdJcXtWzewa9a0adEXqrl9aAx0e+c=;
        b=iBeE9KAbGidfnnuW/5b/HFv6HK6f+8xSp8On3tPkIQuHEWZ8tzpuyc9f0W1dD5SNln
         tk6dnOob0HCpu4H9oC0DcOXcEpvRCVcYiyR4P1jSlIKL9gy/opNSim8A/zgXVOnFPica
         RveONmIe/CaSlfBBp1YbBxZ2/DGFMrK2W56tKE1531CDoyC5t3PtUe726/ksks/rxIJj
         cB4LMxqkoAzTmmC2Zj8yJan5CQjfHvdqDg1nButkVFRQbjSoVlRBQu//GjfdI/C3lEN1
         BJsdVoGEtL1fjmCtsN/YikkX7xYxVOTLmrDRh8GMBB9zBJhXLw/7Rk+gPo4OwXpyjHYv
         ZW3g==
X-Gm-Message-State: AOJu0YwZbHxRq0pX+7mBQ5v0OSx79Rel/1CHacelGCFLTA8Huzs04YiU
	KaJonO6kuqZJzWzlHDIGfBE=
X-Google-Smtp-Source: AGHT+IH0xE/zybhlYas+kNc2rUYJLN0EsIHAkU9CphLhl6v3wVF8cvzrOYBYI85UyUgdrQTmGF0MQA==
X-Received: by 2002:a05:6a00:179a:b0:6d8:a4cb:9f39 with SMTP id s26-20020a056a00179a00b006d8a4cb9f39mr4150744pfg.20.1703057137892;
        Tue, 19 Dec 2023 23:25:37 -0800 (PST)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id w17-20020aa78591000000b006d3b7f40292sm7399969pfn.19.2023.12.19.23.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 23:25:37 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: [PATCHSET wq/for-6.8] workqueue: Implement system-wide max_active for unbound workqueues
Date: Wed, 20 Dec 2023 16:24:31 +0900
Message-ID: <20231220072529.1036099-1-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

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
 0010-workqueue-Reimplement-ordered-workqueue-using-shared.patch

This pachset is also available in the following git branch.

 https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git unbound-system-wide-max_active

diffstat follows.

 include/linux/workqueue.h |   35 ++-
 kernel/workqueue.c        |  669 ++++++++++++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 565 insertions(+), 139 deletions(-)

--
tejun

