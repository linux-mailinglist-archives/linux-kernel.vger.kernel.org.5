Return-Path: <linux-kernel+bounces-10208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1945E81D13D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB3F1C227D3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D4C10F4;
	Sat, 23 Dec 2023 02:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/HOGkQR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D40A5D;
	Sat, 23 Dec 2023 02:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6da4893142aso1624312a34.0;
        Fri, 22 Dec 2023 18:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703297680; x=1703902480; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDoasEUWLnkjnWJK/jt2Zzxrewc0//8PjRqnoVoBd04=;
        b=j/HOGkQRAfnbIYA/4HVhwHpGeFf1B3/dDsjcENe0bz0WFSgM0SoL0SXq10Rsr1Nels
         /f9OrNWC+VwQKDQFALOPyOrUWmbIRTnk8Pgj0hMe+kUPnodZaU+8bkjL8bzYE+yprddh
         l2Gi6+sm8nL7ayg/7nkpKaovo0D9QHi+7Fzhoyl21jdufqG0/Slmg19doMQgGELAfzVg
         F8rgLHjxXwJOJI2GKnr9qK0sQQdLZWSXHgo75pxahk6Zuqz6SF2BXU8UIRgJ1oiZc7Ht
         75vc6w9h0Vd9FOn5GLRbMDj/EskGDVfSY8L8jH4rUPtIMkVpHVvfVRmWpBTWx0eawYif
         XUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703297680; x=1703902480;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDoasEUWLnkjnWJK/jt2Zzxrewc0//8PjRqnoVoBd04=;
        b=hqoMNMWMdI+YpKSzyyOxcDkclhQwzX1bpze8DGfl57L28q4z2Gk0CQNbrAqqSUycF9
         iBYNGbbX+iS6cUxJNi9219wF32ccNsyRQh2J1t7ZtyDdwexYxVzyE3Jtds/8XjIlE6gs
         e8WExjkAQmoBKMf1VdyCR959ttm+nVkMgjP794zgbz0AvGf1xbZUvdW+WB7JPxwt5JgN
         6SLjwPT0zkMi3YrjTKN0z5ksWc/wCaeRfWDUJ9T7+RZZhSW2srNKoVJBaRY1jyrKHfdA
         NymcNVf5QfGPZNNHxYuaC1+fyECaQ0f8rzpyO5Yqj6FfvcM+7m3LOImd/pcAhC1PcjQZ
         Hjjw==
X-Gm-Message-State: AOJu0YxNuR0XLOTkZ0locT6Z5/TFBgUOVA0lbc3eeYGS1GT2+SWbxj6O
	eqJjko+FR2wOA+WwngvWl7crRAymuvTbUuAe
X-Google-Smtp-Source: AGHT+IGsP+Dx5US+YyGZ8FehEhE5qH8Z+70E3egeddHxCl8zPtRDEUfakBpe+vJB0nuVXeatFA12lw==
X-Received: by 2002:a05:6830:1055:b0:6da:5c20:f8ad with SMTP id b21-20020a056830105500b006da5c20f8admr2135202otp.60.1703297679756;
        Fri, 22 Dec 2023 18:14:39 -0800 (PST)
Received: from neeraj.linux ([101.0.62.128])
        by smtp.gmail.com with ESMTPSA id h19-20020a62b413000000b006d7d454e58asm765266pfn.117.2023.12.22.18.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 18:14:39 -0800 (PST)
Date: Sat, 23 Dec 2023 07:44:34 +0530
From: "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, paulmck@kernel.org,
	frederic@kernel.org, mingo@kernel.org, tglx@linutronix.de,
	rcu@vger.kernel.org, boqun.feng@gmail.com, joel@joelfernandes.org,
	neeraj.upadhyay@amd.com, urezki@gmail.com,
	qiang.zhang1211@gmail.com
Subject: [GIT PULL] RCU changes for v6.8
Message-ID: <20231223021434.GA2714@neeraj.linux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

Once the merge window opens, please pull the latest RCU git tree from:

  https://github.com/neeraju/linux.git tags/rcu.release.v6.8

# HEAD: 7dfb03dd24d43b9e7a725e70d2e8a83bb29df294:

  Merge branches 'doc.2023.12.13a', 'torture.2023.11.23a', 'fixes.2023.12.13a', 'rcu-tasks.2023.12.12b' and 'srcu.2023.12.13a' into rcu-merge.2023.12.13a (2023-12-14 01:21:31 +0530)

----------------------------------------------------------------
RCU pull request for v6.8

This pull request contains the following branches:

doc.2023.12.13a: Documentation and comment updates.

torture.2023.11.23a: RCU torture, locktorture updates that include
        cleanups; nolibc init build support for mips, ppc and rv64;
        testing of mid stall duration scenario and fixing fqs task
        creation conditions.

fixes.2023.12.13a: Misc fixes, most notably restricting usage of
        RCU CPU stall notifiers, to confine their usage primarily
        to debug kernels.

rcu-tasks.2023.12.12b: RCU tasks minor fixes.

srcu.2023.12.13a: lockdep annotation fix for NMI-safe accesses,
        callback advancing/acceleration cleanup and documentation
        improvements.

----------------------------------------------------------------
Charles Han (1):
      Documentation: RCU: Remove repeated word in comments

Frederic Weisbecker (3):
      srcu: Remove superfluous callbacks advancing from srcu_gp_start()
      srcu: No need to advance/accelerate if no callback enqueued
      srcu: Explain why callbacks invocations can't run concurrently

Neeraj Upadhyay (AMD) (1):
      Merge branches 'doc.2023.12.13a', 'torture.2023.11.23a', 'fixes.2023.12.13a', 'rcu-tasks.2023.12.12b' and 'srcu.2023.12.13a' into rcu-merge.2023.12.13a

Paul E. McKenney (7):
      locktorture: Increase Hamming distance between call_rcu_chain and rcu_call_chains
      rcutorture: Add mid-sized stall to TREE07
      rcu-tasks: Mark RCU Tasks accesses to current->rcu_tasks_idle_cpu
      rcu: Restrict access to RCU CPU stall notifiers
      doc: Clarify RCU Tasks reader/updater checklist
      doc: Mention address and data dependencies in rcu_dereference.rst
      doc: Clarify historical disclaimers in memory-barriers.txt

Pedro Falcato (1):
      rcu: Remove unused macros from rcupdate.h

Philipp Stanner (1):
      rculist.h: docs: Fix wrong function summary

Sebastian Andrzej Siewior (1):
      srcu: Use try-lock lockdep annotation for NMI-safe access.

Thomas Weiﬂschuh (1):
      rcutorture: add nolibc init support for mips, ppc and rv64

Zqiang (2):
      rcutorture: Add fqs_holdoff check before fqs_task is created
      rcu: Force quiescent states only for ongoing grace period

 Documentation/RCU/checklist.rst                            | 25 ++++++++++++++++---------
 Documentation/RCU/rcu_dereference.rst                      | 27 ++++++++++++++++++++-------
 Documentation/RCU/torture.rst                              |  2 +-
 Documentation/admin-guide/kernel-parameters.txt            |  6 ++++++
 Documentation/memory-barriers.txt                          | 17 ++++++++++-------
 include/linux/rcu_notifier.h                               |  6 +++---
 include/linux/rculist.h                                    |  2 +-
 include/linux/rcupdate.h                                   |  9 ++++++---
 include/linux/srcu.h                                       |  2 +-
 kernel/locking/locktorture.c                               | 18 +++++++++---------
 kernel/rcu/Kconfig.debug                                   | 25 +++++++++++++++++++++++++
 kernel/rcu/rcu.h                                           |  8 +++++---
 kernel/rcu/rcutorture.c                                    | 16 ++++++++++------
 kernel/rcu/srcutree.c                                      | 24 +++++++++++-------------
 kernel/rcu/tasks.h                                         |  4 ++--
 kernel/rcu/tree.c                                          |  2 ++
 kernel/rcu/tree_stall.h                                    | 11 ++++++++++-
 kernel/rcu/update.c                                        |  6 ++++++
 tools/testing/selftests/rcutorture/bin/mkinitrd.sh         |  5 ++++-
 tools/testing/selftests/rcutorture/configs/rcu/TREE07.boot |  3 +++
 20 files changed, 151 insertions(+), 67 deletions(-)

