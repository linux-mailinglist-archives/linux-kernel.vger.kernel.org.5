Return-Path: <linux-kernel+bounces-23981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C97382B4C4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34FC286DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E6333CED;
	Thu, 11 Jan 2024 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1rWro4L"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFF118E09;
	Thu, 11 Jan 2024 18:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9bc8939d0so3457976b3a.0;
        Thu, 11 Jan 2024 10:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704997985; x=1705602785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clygjkCoTo2186jMa/8ftqW73yo5bq7G0EyrifoYWFU=;
        b=K1rWro4LnG0zDzHbeVme4oIvd330b9EMxE2tS1EXIXHiSnl62IYx1yyNutk1ECFRkZ
         clPlYF+cK5jhgNPf7PdLkSqpqZ50yH5X3XckZOzNAywHWSIrAuta1qRoFYvV3p+3QkWL
         6wkSaeOcOZdsaIht/AgPDdpEkIC6CC5ZgKWx7dPu59o+bZLz2MmX9qM8GkOSpWsrm2ek
         eTttoz2/rD6R4nKsWZq6/6U8s1MoKfGyQy93jsWjdI73qqPX528cg+Y8DA6HmUsMuSNO
         +HHGMOnMaCpU4RU9EW0P+MOKqmQOvHxkP7qdtblgZjjCMgpIIghr3WoyfjzUUqY4xo3T
         EN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704997985; x=1705602785;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clygjkCoTo2186jMa/8ftqW73yo5bq7G0EyrifoYWFU=;
        b=NA2bGHZsXWk/xYoLEvsxvY/wPGRjxA+SiDlcMpQ2QaZ2G4DupTIw6oimLLWmLr8Ob1
         3m4tL6KVb75HH+jRUrQC/jOBQBr467gJrqAlUcFw1W4Bg1lULHk270fkQKfunD+G1d63
         B0FCQWpXHpZqPLxDb7OjS1t7QlxZXp+nIQSC6p4IHXTkNWtcN5GiO9KFwdJYwJSirnmL
         He1Ek3zgB4IEi3Vi/TbYV54eRu0LuWKs2fgTGeeOsKM9+m3EQwdtlqiaE0vPsfOpEeWa
         5MHbaAznHeCI4Ch84JMcbpDgD85D/YUYIQsIgohujRlAYE11zztBYfIwzO13JYkRO9hu
         ny7A==
X-Gm-Message-State: AOJu0Yw2hfwU0V+MtD121zPhFiPFYo04BxlNqa6UDFGoZp4uRUgnq8dq
	6PiJ7H2MEUOrIZcAjErrxuo=
X-Google-Smtp-Source: AGHT+IG6zakPh+83/qem2Kot/Q1YKrTG98cCGYi+le4KUadFheRW8Ww9ZrnzYYzfRKNEWhuJLiyAnw==
X-Received: by 2002:a05:6a00:3d46:b0:6d9:906d:f4c7 with SMTP id lp6-20020a056a003d4600b006d9906df4c7mr171966pfb.17.1704997984695;
        Thu, 11 Jan 2024 10:33:04 -0800 (PST)
Received: from neeraj.linux ([101.0.63.127])
        by smtp.gmail.com with ESMTPSA id ko20-20020a056a00461400b006da13bc46c0sm1549185pfb.171.2024.01.11.10.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 10:33:03 -0800 (PST)
Date: Fri, 12 Jan 2024 00:02:52 +0530
From: "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, paulmck@kernel.org,
	mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org,
	boqun.feng@gmail.com, joel@joelfernandes.org,
	neeraj.upadhyay@amd.com, urezki@gmail.com,
	qiang.zhang1211@gmail.com
Subject: [GIT PULL] RCU changes for v6.8
Message-ID: <20240111183252.GA797@neeraj.linux>
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

Please pull the latest RCU git tree from:

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

