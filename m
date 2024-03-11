Return-Path: <linux-kernel+bounces-98815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A2E877FCC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A678CB21E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637CD3D54C;
	Mon, 11 Mar 2024 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rhgt84lg"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924573D0A1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710159475; cv=none; b=JWV9BoBYVrM4VbygMsLXdj6K9md8cfarnoMMGSFVoesLeAzCiFWPVveuC47Uh/2bFoQ5/toKR37EP/mHSWCZgdzOkJRqm3Z6NnkX1vzaLy02tawdhpPsS+yZq5jg13Poc6/2VYKDiaCtlpO70UTWcOtpsce4StXqGIQy0EMl36Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710159475; c=relaxed/simple;
	bh=J0mGCT5q41xi1p5t+lHJq+UooCCXXdohOtVa1/6aBDU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ORcBb+QiPV6x5Wi4EmLFSy4v32cw+LPBZ0CDdm5AeINL/pwh+OQZJYHfdz1Co1b4rE8tiHiOfmpCbp+v7YGgpBLTkBauXSbRSAD2vi7RFlMRn8zhwSkADWWOVSJSqU7+I1dFBnWcNOIQ4pfpBjgiMnDoTFjP/2IiKDvYKaZNAmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rhgt84lg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4132ab0eea9so4188915e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 05:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710159472; x=1710764272; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=U6fQa4zC1Vwu5wI6rtpeymNqoaanHUlROJ8tIgVYIgE=;
        b=Rhgt84lgBGsowFQKCFpuP38NMGl3ulqat5lk0niQcA4qM3SYouIuDUxeSUkCJGK7My
         /OTLDhzekVWXYbTPZ2KkIGB+ECPs3cMFX8+1DoJicJrA5gomncqgPBNv178FNephSHvJ
         1iC24N47IqL2siEa6zbu0Y8VXCrwNAB9Sz4ZH8NL0GSXezHvaZ94PWvoV+vwLS4K6PuN
         +vagsrQAdrsQGpOViJvkrBVVPkOGsckYyYiO+X3xprN4oCW9UaB9yEwSL7kiHuCoVNuD
         HloJXLFdhl6HjfYDgdfd+alihU3cEMWs0+Y4sfCxqpWb3hYTcsLsUN5CHgO2MekE8Kxf
         /z1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710159472; x=1710764272;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6fQa4zC1Vwu5wI6rtpeymNqoaanHUlROJ8tIgVYIgE=;
        b=EaHVEdJ6jEcroTVSmhk9EKWz9m6oTIfRC4mS0D6t+Xs+2cFlL1S5N/6msADokzitzo
         DT3+I/gdYryHcG7sxzXOCpSkH8MUg/O6/hnI118NwAibFR0RNzfBvV07bBpdsCEVYyg8
         TAjysUG648kjCGnygKoVUe1UljKBqCsWAazxVZSGjAVMAElHs6OV2tJvWnKvNRyggJS4
         T9ggKJvD+jBRlACmm7I8KQVXzsWbed0WyAbaztTY1QBj9Q9GPh9MbPVrXtRRH3UuS0mE
         O12Q53tP4S2pXjTYPIIrn6tXCOfI96U+b+ft3PSma7Ft08h2Od7SmAt4E6FPZP3bWcP0
         Tt8g==
X-Gm-Message-State: AOJu0YzquNm57csFDCx7taXWLJVjZNQSvdlt8ax82fYHbH3/tSLdYTlg
	BF3ca7KAv2EvY9Q4lPM8XrYvti19VRDadhRvyvxkaK032V7y9btL
X-Google-Smtp-Source: AGHT+IE/JC+x8BD3WkG5RPemyYe2fxsq98/NPNAPTWoJm7c5ZybT0DAVagK6W0pBdZutOD4604pz6g==
X-Received: by 2002:a5d:604f:0:b0:33e:798f:6d1e with SMTP id j15-20020a5d604f000000b0033e798f6d1emr4267468wrt.37.1710159471477;
        Mon, 11 Mar 2024 05:17:51 -0700 (PDT)
Received: from gmail.com (1F2EF295.nat.pool.telekom.hu. [31.46.242.149])
        by smtp.gmail.com with ESMTPSA id f15-20020adff58f000000b0033dd2c3131fsm6256681wro.65.2024.03.11.05.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 05:17:50 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 11 Mar 2024 13:17:48 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [GIT PULL] Scheduler changes for v6.9
Message-ID: <Ze72bF17UQpj7ZZy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest sched/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2024-03-11

   # HEAD: 54de442747037485da1fc4eca9636287a61e97e3 sched/topology: Rename SD_SHARE_PKG_RESOURCES to SD_SHARE_LLC

Scheduler changes for v6.9:

 - Fix inconsistency in misfit task load-balancing

 - Fix CPU isolation bugs in the task-wakeup logic

 - Rework & unify the sched_use_asym_prio() and sched_asym_prefer() logic

 - Clean up & simplify ->avg_* accesses

 - Misc cleanups & fixes

 Thanks,

	Ingo

------------------>
Alex Shi (5):
      sched/topology: Remove duplicate descriptions from TOPOLOGY_SD_FLAGS
      sched/fair: Remove unused parameter from sched_asym()
      sched/fair: Rework sched_use_asym_prio() and sched_asym_prefer()
      sched/fair: Check the SD_ASYM_PACKING flag in sched_use_asym_prio()
      sched/topology: Rename SD_SHARE_PKG_RESOURCES to SD_SHARE_LLC

David Vernet (3):
      sched/fair: Remove unnecessary goto in update_sd_lb_stats()
      sched/fair: Do strict inequality check for busiest misfit task group
      sched/fair: Simplify the update_sd_pick_busiest() logic

Keisuke Nishimura (2):
      sched/fair: Take the scheduling domain into account in select_idle_smt()
      sched/fair: Take the scheduling domain into account in select_idle_core()

Shrikanth Hegde (3):
      sched/core: Simplify code by removing duplicate #ifdefs
      sched/fair: Use existing helper functions to access ->avg_rt and ->avg_dl
      sched/fair: Add READ_ONCE() and use existing helper function to access ->avg_irq


 arch/powerpc/kernel/smp.c      |   6 +--
 include/linux/sched/sd_flags.h |   4 +-
 include/linux/sched/topology.h |   6 +--
 kernel/sched/core.c            |   4 +-
 kernel/sched/fair.c            | 110 +++++++++++++++++------------------------
 kernel/sched/sched.h           |   2 +-
 kernel/sched/topology.c        |  35 ++++++-------
 7 files changed, 74 insertions(+), 93 deletions(-)

