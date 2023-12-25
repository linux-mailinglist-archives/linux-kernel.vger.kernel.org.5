Return-Path: <linux-kernel+bounces-11169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B5181E265
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 22:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5D21C20B90
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 21:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609F353E0A;
	Mon, 25 Dec 2023 21:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0J6IvU0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB095381E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 21:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dbd7f4db43so1109418a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 13:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703538570; x=1704143370; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=L2TPGzqU1I9Vl3dStjUW5b3XHAolNTrY8ZXwUKWwD5w=;
        b=G0J6IvU0EVERn5JYfPj7Ten2ut3YFSWnH8a1/I0TH/dVfohEC2JX6Y+YpOM/XBBybp
         0WwXQEDnil63qxZXrdO0iQcVmAJmKkC3VwkrVD6o6ttIPv7WJHHRdoXFe2N3W9A1l609
         XK0nMIFgDbR+Y2fhZXsY8EDkrrnAs6LNSqh+VRntkGis7b824GyOIZuxtvInjDsnkm6B
         lrxNP54qEXJT5QBUBB/Cp7B+IX2YTjeKCDYHhPzBW9lhcJ51vmIFwmxTqmdiM8WzuN3V
         qgEg+PfyVCD/AN+4wNPxniyVQWw5akS8O+INnKt0fV/IWykmei85YevfU/6YFRUoO1+I
         Iq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703538570; x=1704143370;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2TPGzqU1I9Vl3dStjUW5b3XHAolNTrY8ZXwUKWwD5w=;
        b=PN/x/pj/ONkXhNHIuM69XTXwyzzZjugx57LdOPeCcGKlxHIAxg4UQdYA4Fbg+mOmVq
         scSg498psUYAPdY9aAyt8syk1vLsYkFOBH1SynvYUuW+mgBHinfqZcUnosQQhS9PUFTz
         6WMBpkaouOanlR+lASoL4kKpBR/s070h5lFEo2WOvpqlQKocLcyow2RSxY75ZZWiKx+P
         BLi3db14Z9wxUSaqbd2f6gvVymwAEXKYOJZ/1s7SXLfd+hyfuj74NYT/wZqSWS4myUfr
         dAYukO/EtuRMi2F7coyiC9BkR+/sZzULb7x5GESDF7cGwqW5jQ05YAEmewWzzFNIiUPo
         PI2g==
X-Gm-Message-State: AOJu0Yys00YtgG6Q2/BBcq0VUnoFkH7WZMcQii53OB+2vy0MwrY1wCbp
	OBSzViPyD3XkaLNVdH8C4hQ=
X-Google-Smtp-Source: AGHT+IHBhj3leqnhCweRs5Zc85V8nkuxjeRd2mMyugeRGYOMq+EqR+m7p4Q6Nu9BcXYVMW8qBsqHCQ==
X-Received: by 2002:a9d:61cb:0:b0:6d9:e7db:7b60 with SMTP id h11-20020a9d61cb000000b006d9e7db7b60mr3728676otk.12.1703538569750;
        Mon, 25 Dec 2023 13:09:29 -0800 (PST)
Received: from localhost ([166.198.201.166])
        by smtp.gmail.com with ESMTPSA id m19-20020a0568301e7300b006dbaee79afcsm1679387otr.36.2023.12.25.13.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 13:09:28 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 26 Dec 2023 06:09:21 +0900
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [GIT PULL] cgroup: Changes for v6.8
Message-ID: <ZYnvgTc22Exn7Z4C@mtj.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Merry Christmas and happy new year!

The following changes since commit 4a6c5607d4502ccd1b15b57d57f17d12b6f257a7:

  workqueue: Make sure that wq_unbound_cpumask is never empty (2023-11-22 06:17:26 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.8

for you to fetch changes up to a7fb0423c201ba12815877a0b5a68a6a1710b23a:

  cgroup: Move rcu_head up near the top of cgroup_root (2023-12-07 12:54:59 -1000)

----------------------------------------------------------------
cgroup: Changes for v6.8

- Yafang Shao added task_get_cgroup1() helper to enable a similar BPF helper
  so that BPF progs can be more useful on cgroup1 hierarchies. While cgroup1
  is mostly in maintenance mode, this addition is very small while having an
  outsized usefulness for users who are still on cgroup1. Yafang also
  optimized root cgroup list access by making it RCU protected in the
  process.

- Waiman Long optimized rstat operation leading to substantially lower and
  more consistent lock hold time while flushing the hierarchical statistics.
  As the lock can be acquired briefly in various hot paths, this reduction
  has cascading benefits.

- Waiman also improved the quality of isolation for cpuset's isolated
  partitions. CPUs which are allocated to isolated partitions are now
  excluded from running unbound work items and cpu_is_isolated() test which
  is used by vmstat and memcg to reduce interference now includes cpuset
  isolated CPUs. While it isn't there yet, the hope is eventually reaching
  parity with the isolation level provided by the `isolcpus` boot param but
  in a dynamic manner.

  This involved a couple workqueue patches which were applied directly to
  cgroup/for-6.8 rather than ping-ponged through the wq tree. This was
  because the wq code change was small and the area is usually very static
  and unlikely to cause conflicts. However, luck had it that there was a wq
  bug fix in the area during the 6.7 cycle which caused a conflict. The
  conflict is contextual but can be a bit confusing to resolve, so there is
  one merge from wq/for-6.7-fixes.

----------------------------------------------------------------
Atul Kumar Pant (1):
      selftests: cgroup: Fixes a typo in a comment

Josh Don (1):
      cgroup: Fix documentation for cpu.idle

Tejun Heo (1):
      Merge branch 'for-6.7-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq into for-6.8

Waiman Long (11):
      workqueue: Add workqueue_unbound_exclude_cpumask() to exclude CPUs from wq_unbound_cpumask
      selftests/cgroup: Minor code cleanup and reorganization of test_cpuset_prs.sh
      cgroup/cpuset: Keep track of CPUs in isolated partitions
      cgroup/cpuset: Take isolated CPUs out of workqueue unbound cpumask
      cgroup/rstat: Reduce cpu_lock hold time in cgroup_rstat_flush_locked()
      workqueue: Move workqueue_set_unbound_cpumask() and its helpers inside CONFIG_SYSFS
      cgroup/cpuset: Expose cpuset.cpus.isolated
      cgroup/rstat: Optimize cgroup_rstat_updated_list()
      cgroup: Avoid false cacheline sharing of read mostly rstat_cpu
      cgroup/cpuset: Include isolated cpuset CPUs in cpu_is_isolated() check
      cgroup: Move rcu_head up near the top of cgroup_root

Yafang Shao (5):
      cgroup: Remove unnecessary list_empty()
      cgroup: Make operations on the cgroup root_list RCU safe
      cgroup: Eliminate the need for cgroup_mutex in proc_cgroup_show()
      cgroup: Add annotation for holding namespace_sem in current_cgns_cgroup_from_root()
      cgroup: Add a new helper for cgroup1 hierarchy

 Documentation/admin-guide/cgroup-v2.rst           |  33 ++-
 include/linux/cgroup-defs.h                       |  21 +-
 include/linux/cgroup.h                            |   4 +-
 include/linux/cpuset.h                            |   6 +
 include/linux/sched/isolation.h                   |   4 +-
 include/linux/workqueue.h                         |   2 +-
 kernel/cgroup/cgroup-internal.h                   |   4 +-
 kernel/cgroup/cgroup-v1.c                         |  34 +++
 kernel/cgroup/cgroup.c                            |  45 ++--
 kernel/cgroup/cpuset.c                            | 297 ++++++++++++++++------
 kernel/cgroup/rstat.c                             | 150 +++++++----
 kernel/workqueue.c                                | 167 ++++++++----
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 222 ++++++++++------
 tools/testing/selftests/cgroup/test_freezer.c     |   2 +-
 14 files changed, 708 insertions(+), 283 deletions(-)

-- 
tejun

