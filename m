Return-Path: <linux-kernel+bounces-97361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA5A87696A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB843B2201E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9341728DA4;
	Fri,  8 Mar 2024 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrzyg+dP"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD4825570;
	Fri,  8 Mar 2024 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918158; cv=none; b=dL07VAHBXsC2CvjHhT0Z9ilo1Syb4KXMfWSmMWKiszWzFAm564ShQPRBlPwLvl1yr+l0Ae7wEkwIwQwHT6XpbopIyNF2O2Dmee0jJ5MxdFBsfMIcnlnLZvYUKl0B+wbUN0UcsnW9wbo+LjldaUwPq8uHLoCxIzLASX0aBxVnpZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918158; c=relaxed/simple;
	bh=6GuBU2MDif7sF819XGqAwoGuMINRtFdixtdfEd3c6P8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Skf7uvgdrzlARbuLN4ietDIy1L9r8zVlMAiiYZ36tkFiC+y4o8aCZ6rH0bk+lso3kgsULAH0HXcO9KB6zJELoa7dTZPGg4PRNLMp/pd0+cIANDDlYfClC1dCFgBQm911VGu7nvC/fo0mI3/tyxgiKy1wkSLHV9Ofl48PVB37Is8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrzyg+dP; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78851160a10so72779285a.1;
        Fri, 08 Mar 2024 09:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709918156; x=1710522956; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eg/6ZiZ+BqYM2RugqdnytHz98Dd7p5sKblhsba++MaY=;
        b=lrzyg+dPX9qb7suyqzAgQH6rTDecmA258FQE91g27xXPIXobMD0y904ynoYRfQJ25k
         eH/yXMogCstQrnXQ6GG1ZaIQi6t0Oxo8k+83vVToSgQUlLAICjLnwLEdGrpxZTQ1Ce82
         YX99O62OsOd7Pjs3Xa03WnuD83hctENaoSC+PMVwpUalrK3zfXglTml0Dx2Yz+1AZ593
         A70IW3dSOkzEBZA9z5WDoKo16h6wiS/4d7LmyOLsgWnDGMGDhzhrMn2u+/EukX9+dj7Y
         lj3r282zu6OQaAmFADhN8FDKEvnLzDhLLLG71KLmrtOZYLtCeigHfWSNhgImqaWWAIju
         bUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709918156; x=1710522956;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eg/6ZiZ+BqYM2RugqdnytHz98Dd7p5sKblhsba++MaY=;
        b=J2Tu3Dyhl6UMIXbT/Cl1LfPCROC8EiNZnNSH7wm2MVf7PWiHuVlJl1lUyFFNpA+eKT
         Nymvx8S0WkHrEqAHGe2vJfAEfXZj2bZBkjIQce9FyibQA5CGiOv7PdtN3nF/sJz37YHV
         Qy7c0WlTyAvHDTDmiK1x+b43eavX7wiOJSYI8r2xBoKgcB5pCRRumZVC2GozNYOO56cV
         +H/XLtTsVdjoCzwp3MPucec2EsRIsg7MRMfOxexygXqh1bIvNDNAa8RBf647dIjqUIjL
         Cj/vEc87cPQpNwhIykuIX4QC4D6mIUHBrKuiOeNfKQogbX/9RTpl75blb65dMTbBNAGU
         oaog==
X-Forwarded-Encrypted: i=1; AJvYcCWkU0S1E3ey5Sit97ihPAEeXBbheTOq7wsn5kx4+6FXajk3NgfxfL7ugJwMtTOlrNtCEKJfGHCIgV6MXjxuYtsYSo44
X-Gm-Message-State: AOJu0YwFPTG6aZ0fDM+ZOD59iu+iXATdF/gxKQ06dNOKWtUrIZWjtFsl
	2BmsaX6/bR+Won6Y0/X23nZj8lt+FS94HhjcwywRnJYZY/OyZUA1
X-Google-Smtp-Source: AGHT+IG7d3scmZ1pnEvqmtpaYmtauh/0YkxCtyR6tNL/JC9w4GL0YnOeDyI1lZPm05SnEM9ax2e5Ng==
X-Received: by 2002:a0c:ef05:0:b0:690:9e6d:efe9 with SMTP id t5-20020a0cef05000000b006909e6defe9mr1716089qvr.27.1709918155910;
        Fri, 08 Mar 2024 09:15:55 -0800 (PST)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id o18-20020a056214181200b00690b43d39f0sm814547qvw.85.2024.03.08.09.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:15:55 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 69D231200068;
	Fri,  8 Mar 2024 12:15:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 08 Mar 2024 12:15:54 -0500
X-ME-Sender: <xms:yUfrZZypfgMBhKTxbtqVNubmCKG6mZXkwfRtUxBSA3jv-_w65Psbdg>
    <xme:yUfrZZR7FjVIYNZFucMiV8Og04d-1uoSt1ti6rQGU-l7-Eju9gjLyXC3kyk86vz77
    4PzWvXZyMgtn0AE_g>
X-ME-Received: <xmr:yUfrZTXuaQkmyYU9Unz8wr60QVKKn7iOs-fn2AgjWj7h-CqEX1xl-Sd-Xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieehgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkgggtugesthdtredttd
    dtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgr
    ihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeeltdefueegfefhuedtheefvdelhfefte
    dvhfdtveelueegtdejjedvieettedugfenucffohhmrghinhepkhgvrhhnvghlrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgv
X-ME-Proxy: <xmx:yUfrZbh23QHbWBreZfymiiwQedkjdkLAzq7Iwjf_svVzhR_flbTk8A>
    <xmx:yUfrZbCg2AFmKnSSAwy4Hj7OAdv1D6e8dh3KaIJURVg-gQSrEMsUBg>
    <xmx:yUfrZUInwazUw30ZhdFEkbMjO1t1U2NZRKOg-6-Jv-xFmDXK5defuw>
    <xmx:ykfrZT5Sm4JXaqO1d6DogFrDn7H9dyV_LkMfrNpKjZAm__A8pWqOuOR6TWw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Mar 2024 12:15:53 -0500 (EST)
Date: Fri, 8 Mar 2024 09:15:46 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, paulmck@kernel.org,
	mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org,
	boqun.feng@gmail.com, joel@joelfernandes.org,
	neeraj.upadhyay@amd.com, urezki@gmail.com,
	qiang.zhang1211@gmail.com, frederic@kernel.org,
	bigeasy@linutronix.de, anna-maria@linutronix.de,
	chenzhongjin@huawei.com, yangjihong1@huawei.com,
	rostedt@goodmis.org
Subject: [GIT PULL] RCU changes for v6.9
Message-ID: <ZetHwrCb0KXE0xFI@tardis>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull this for the RCU changes of v6.9:

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git tags/rcu.next.v6.9

for you to fetch changes up to 3add00be5fe5810d7aa5ec3af8b6a245ef33144b:

  Merge branches 'rcu-doc.2024.02.14a', 'rcu-nocb.2024.02.14a', 'rcu-exp.2024.02.14a', 'rcu-tasks.2024.02.26a' and 'rcu-misc.2024.02.14a' into rcu.2024.02.26a (2024-02-26 17:37:25 -0800)


Two merge conflicts were detected by linux-next:

* https://lore.kernel.org/lkml/20240226135745.12ac854d@canb.auug.org.au/
* https://lore.kernel.org/lkml/20240227125522.2bdbe6be@canb.auug.org.au/

These conflict resolutions from linux-next look good to me, plus I made
my own resolutions at branch merge/rcu.2024.02.27a for your reference.


Some highlights of the changes:

* Eliminates deadlocks involving do_exit() and RCU tasks, by Paul:
  Instead of SRCU read side critical sections, now a percpu list is used
  in do_exit() for scaning yet-to-exit tasks.

* Fixes a deadlock due to the dependency between workqueue and RCU
  expedited grace period, reported by Anna-Maria Behnsen and Thomas
  Gleixner and fixed by Frederic: Now RCU expedited always uses its own
  kthread worker instead of a workqueue.


Regards,
Boqun


----------------------------------------------------------------
RCU pull request for v6.9

This pull request contains the following branches:

rcu-doc.2024.02.14a: Documentation updates.

rcu-nocb.2024.02.14a: RCU NOCB updates, code cleanups, unnecessary
        barrier removals and minor bug fixes.

rcu-exp.2024.02.14a: RCU exp, fixing a circular dependency between
        workqueue and RCU expedited callback handling.

rcu-tasks.2024.02.26a: RCU tasks, avoiding deadlocks in do_exit() when
        calling synchronize_rcu_task() with a mutex hold, maintaining
	real-time response in rcu_tasks_postscan() and a minor
        fix for tasks trace quiescence check.

rcu-misc.2024.02.14a: Misc updates, comments and readibility
	improvement, boot time parameter for lazy RCU and rcutorture
	improvement.

----------------------------------------------------------------
Boqun Feng (1):
      Merge branches 'rcu-doc.2024.02.14a', 'rcu-nocb.2024.02.14a', 'rcu-exp.2024.02.14a', 'rcu-tasks.2024.02.26a' and 'rcu-misc.2024.02.14a' into rcu.2024.02.26a

Frederic Weisbecker (13):
      rcu/nocb: Remove needless LOAD-ACQUIRE
      rcu/nocb: Remove needless full barrier after callback advancing
      rcu/nocb: Make IRQs disablement symmetric
      rcu/nocb: Re-arrange call_rcu() NOCB specific code
      rcu/exp: Remove full barrier upon main thread wakeup
      rcu/exp: Fix RCU expedited parallel grace period kworker allocation failure recovery
      rcu/exp: Handle RCU expedited grace period kworker allocation failure
      rcu: s/boost_kthread_mutex/kthread_mutex
      rcu/exp: Move expedited kthread worker creation functions above rcutree_prepare_cpu()
      rcu/exp: Make parallel exp gp kworker per rcu node
      rcu/exp: Handle parallel exp gp kworkers affinity
      rcu/exp: Remove rcu_par_gp_wq
      rcu: Rename jiffies_till_flush to jiffies_lazy_flush

Joel Fernandes (Google) (1):
      srcu: Improve comments about acceleration leak

Onkarnath (1):
      rcu/sync: remove un-used rcu_sync_enter_start function

Paul E. McKenney (16):
      doc: Spinlocks are implied RCU readers
      doc: Make whatisRCU.rst note that spinlocks are RCU readers
      doc: Make checklist.rst note that spinlocks are implied RCU readers
      doc: Add CONFIG_RCU_STRICT_GRACE_PERIOD to checklist.rst
      doc: Add EARLY flag to early-parsed kernel boot parameters
      context_tracking: Fix kerneldoc headers for __ct_user_{enter,exit}()
      doc: Clarify use of slab constructors and SLAB_TYPESAFE_BY_RCU
      doc: Update checklist.rst discussion of callback execution
      rcutorture: Suppress rtort_pipe_count warnings until after stalls
      rcu-tasks: Repair RCU Tasks Trace quiescence check
      rcu-tasks: Add data to eliminate RCU-tasks/do_exit() deadlocks
      rcu-tasks: Initialize callback lists at rcu_init() time
      rcu-tasks: Initialize data to eliminate RCU-tasks/do_exit() deadlocks
      rcu-tasks: Maintain lists to eliminate RCU-tasks/do_exit() deadlocks
      rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks
      rcu-tasks: Maintain real-time response in rcu_tasks_postscan()

Qais Yousef (1):
      rcu: Provide a boot time parameter to control lazy RCU

Zqiang (2):
      rcu/nocb: Fix WARN_ON_ONCE() in the rcu_nocb_bypass_lock()
      rcu/nocb: Check rdp_gp->nocb_timer in __call_rcu_nocb_wake()

 Documentation/RCU/checklist.rst                 |  32 +-
 Documentation/RCU/rcu_dereference.rst           |   5 +-
 Documentation/RCU/whatisRCU.rst                 |  19 +-
 Documentation/admin-guide/kernel-parameters.rst |   1 +
 Documentation/admin-guide/kernel-parameters.txt | 489 ++++++++++++------------
 include/linux/rcu_sync.h                        |   1 -
 include/linux/rcupdate.h                        |   4 +-
 include/linux/sched.h                           |   2 +
 init/init_task.c                                |   1 +
 kernel/context_tracking.c                       |   4 +
 kernel/fork.c                                   |   1 +
 kernel/rcu/Kconfig                              |  13 +
 kernel/rcu/rcu.h                                |  19 +-
 kernel/rcu/rcuscale.c                           |   6 +-
 kernel/rcu/rcutorture.c                         |  13 +-
 kernel/rcu/srcutree.c                           |  24 +-
 kernel/rcu/sync.c                               |  16 -
 kernel/rcu/tasks.h                              | 135 +++++--
 kernel/rcu/tiny.c                               |   1 +
 kernel/rcu/tree.c                               | 237 ++++++++----
 kernel/rcu/tree.h                               |  20 +-
 kernel/rcu/tree_exp.h                           |  83 +---
 kernel/rcu/tree_nocb.h                          |  69 ++--
 kernel/rcu/tree_plugin.h                        |  52 +--
 24 files changed, 687 insertions(+), 560 deletions(-)

