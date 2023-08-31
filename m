Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0B478F555
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 00:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347657AbjHaWUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 18:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241654AbjHaWUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:20:00 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C069C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 15:19:57 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bee82fad0fso10560065ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 15:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693520397; x=1694125197; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WL1OlRhy0NdGZsgMXamAAmSAYVi0KD+OtQoBvLKcCEI=;
        b=nibL5F8rK+TDOXPQ2XMUSCI8LpvQSkTBB1ip2CdXP90pbsV4KtGe9Z6K0fIsfKJFfF
         w+Go3toEBtyo39lbIF+Np8J93rE1Z1UC/WpiK9CMsLGD6Pjw1aQDNJr9GHbxd7EY73yL
         Y9knxQTzFnH4PduuXNMZzSVD3sf8Q6FsKJ6rsSjsM22GgFtKa+7oqyc/1L+00GeOsnRC
         TyRg1pjiNqTSqFp5NUWVrrvu8+ExCmO2w9VAtQ08miXwjU/dBixFPaiioWkgQQva1kRE
         PMQ6bjvC6eZgqavcEI2ODaBIIfnjjz6N2QCeVty9sJfYHWrsNTbPvoJWbgveTGN6eJOz
         rzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693520397; x=1694125197;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WL1OlRhy0NdGZsgMXamAAmSAYVi0KD+OtQoBvLKcCEI=;
        b=gX6uZ/+ICjAnNw5GWNPcyYZeX0von6veQtHvLRQJl806PVO8IqsbVFYpox43DrTbFJ
         703IEDEnWF7o41Jb43yg84MTndTJNoG5ZCU2691r/98+8ie079s/WB8Iya30d5eI9aSw
         fgOsxHlp0l8NJZ2S45za+01fjBrbEmqvi1iHd/JjFkcR06rWUk9uwwKbX5/5J/Rl2fHj
         5SEd9DBESzD06VUjZbb1p4aUdFr/fDJOs21e6hOaneKIYtXICErpD7XjNBYihQcTYPyh
         LMFav7YBBoj/HT42cuXEH/MmqA8bpYBGzWwiToibmsZ7IsJL4nb/JxYTYMd75Y+kyJMa
         b2GQ==
X-Gm-Message-State: AOJu0Yw1ZdN/U41o9kEDi+dLfBjg7MwwH21hmL2wqrQlBVoTnJ8gZXu9
        7N1/pgD1eYLQZ4Nds5UyQRHmEDBRDJ0=
X-Google-Smtp-Source: AGHT+IGb645GXMN9LSDVQrAhRV8/ayyqkna2+hsdu7bgIBvD4UjGzM4Gu6N7dRTtqbMoBuTuiZ3Qvw==
X-Received: by 2002:a17:902:9a43:b0:1c0:ad3c:c723 with SMTP id x3-20020a1709029a4300b001c0ad3cc723mr1024424plv.10.1693520396637;
        Thu, 31 Aug 2023 15:19:56 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:eca7])
        by smtp.gmail.com with ESMTPSA id l18-20020a170902d35200b001bbf7fd354csm1683303plk.213.2023.08.31.15.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 15:19:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 31 Aug 2023 12:19:54 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue: Changes for v6.6
Message-ID: <ZPESClTTFQ0xo6ku@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit aa6fde93f3a49e42c0fe0490d7f3711bac0d162e:

  workqueue: Scale up wq_cpu_intensive_thresh_us if BogoMIPS is below 4000 (2023-07-25 11:49:57 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.6

for you to fetch changes up to fe48ba7daefe75bbbefa2426deddc05f2d530d2d:

  workqueue: fix data race with the pwq->stats[] increment (2023-08-29 09:52:16 -1000)

----------------------------------------------------------------
workqueue: Changes for v6.6

* Unbound workqueues now support more flexible affinity scopes. The default
  behavior is to soft-affine according to last level cache boundaries. A
  work item queued from a given LLC is executed by a worker running on the
  same LLC but the worker may be moved across cache boundaries as the
  scheduler sees fit. On machines which multiple L3 caches, which are
  becoming more popular along with chiplet designs, this improves cache
  locality while not harming work conservation too much.

  Unbound workqueues are now also a lot more flexible in terms of execution
  affinity. Differeing levels of affinity scopes are supported and both the
  default and per-workqueue affinity settings can be modified dynamically.
  This should help working around amny of sub-optimal behaviors observed
  recently with asymmetric ARM CPUs.

  This involved signficant restructuring of workqueue code. Nothing was
  reported yet but there's some risk of subtle regressions. Should keep an
  eye out.

* Rescuer workers now has more identifiable comms.

* workqueue.unbound_cpus added so that CPUs which can be used by workqueue
  can be constrained early during boot.

* Now that all the in-tree users have been flushed out, trigger warning if
  system-wide workqueues are flushed.

* One pull commit from for-6.5-fixes to avoid cascading conflicts in the
  affinity scope patchset.

----------------------------------------------------------------
Aaron Tomlin (1):
      workqueue: Rename rescuer kworker

Mirsad Goran Todorovac (1):
      workqueue: fix data race with the pwq->stats[] increment

Tejun Heo (27):
      workqueue: Merge branch 'for-6.5-fixes' into for-6.6
      workqueue: Drop the special locking rule for worker->flags and worker_pool->flags
      workqueue: Cleanups around process_scheduled_works()
      workqueue: Not all work insertion needs to wake up a worker
      workqueue: Rename wq->cpu_pwqs to wq->cpu_pwq
      workqueue: Relocate worker and work management functions
      workqueue: Remove module param disable_numa and sysfs knobs pool_ids and numa
      workqueue: Use a kthread_worker to release pool_workqueues
      workqueue: Make per-cpu pool_workqueues allocated and released like unbound ones
      workqueue: Call wq_update_unbound_numa() on all CPUs in NUMA node on CPU hotplug
      workqueue: Make unbound workqueues to use per-cpu pool_workqueues
      workqueue: Rename workqueue_attrs->no_numa to ->ordered
      workqueue: Rename NUMA related names to use pod instead
      workqueue: Move wq_pod_init() below workqueue_init()
      workqueue: Initialize unbound CPU pods later in the boot
      workqueue: Factor out actual cpumask calculation to reduce subtlety in wq_update_pod()
      workqueue: Factor out clearing of workqueue-only attrs fields
      workqueue: Generalize unbound CPU pods
      workqueue: Add tools/workqueue/wq_dump.py which prints out workqueue configuration
      workqueue: Modularize wq_pod_type initialization
      workqueue: Add multiple affinity scopes and interface to select them
      workqueue: Factor out work to worker assignment and collision handling
      workqueue: Factor out need_more_worker() check and worker wake-up
      workqueue: Add workqueue_attrs->__pod_cpumask
      workqueue: Implement non-strict affinity scope for unbound workqueues
      workqueue: Add "Affinity Scopes and Performance" section to documentation
      workqueue: Make default affinity_scope dynamically updatable

Tetsuo Handa (1):
      workqueue: Warn attempt to flush system-wide workqueues.

Yang Yingliang (1):
      workqueue: use LIST_HEAD to initialize cull_list

tiozhang (1):
      workqueue: add cmdline parameter `workqueue.unbound_cpus` to further constrain wq_unbound_cpumask at boot time

 Documentation/admin-guide/kernel-parameters.txt |   28 +-
 Documentation/core-api/workqueue.rst            |  356 ++++-
 include/linux/workqueue.h                       |  115 +-
 init/main.c                                     |    1 +
 kernel/workqueue.c                              | 1618 +++++++++++++----------
 kernel/workqueue_internal.h                     |    2 +-
 tools/workqueue/wq_dump.py                      |  177 +++
 tools/workqueue/wq_monitor.py                   |   21 +-
 8 files changed, 1513 insertions(+), 805 deletions(-)
 create mode 100644 tools/workqueue/wq_dump.py

-- 
tejun
