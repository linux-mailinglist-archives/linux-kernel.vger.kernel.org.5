Return-Path: <linux-kernel+bounces-26090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF09082DB5A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7162CB21133
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA1B17596;
	Mon, 15 Jan 2024 14:34:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6760F1106
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCC772F4;
	Mon, 15 Jan 2024 06:35:23 -0800 (PST)
Received: from e126645.arm.com (e126645.nice.arm.com [10.34.100.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 594153F6C4;
	Mon, 15 Jan 2024 06:34:35 -0800 (PST)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Huang Ying <ying.huang@intel.com>
Subject: [PATCH v2 0/3] Small cleanup around sparse report
Date: Mon, 15 Jan 2024 15:34:23 +0100
Message-Id: <20240115143427.1820628-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- Added __rcu annotations to variabbles in sched_reset_numa(),
  and casts for calls to kfree().
- Renamed idle_cpu_without() to idle_rq_without()
- Added sched/fair: Use rq in update_blocked_averages()

While checking spare's tool report, some RCU pointers appeared
to be not annotated. In the same effort, idle_cpu_without() and
update_blocked_averages() seemed to be subject to a small
optimizations.

Pierre Gondois (3):
  sched/topology: Annotate RCU pointers properly
  sched/fair: Use rq in idle_cpu_without()
  sched/fair: Use rq in update_blocked_averages()

 kernel/sched/fair.c     | 25 +++++++++++--------------
 kernel/sched/topology.c | 12 ++++++------
 2 files changed, 17 insertions(+), 20 deletions(-)

-- 
2.25.1


