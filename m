Return-Path: <linux-kernel+bounces-48036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D1B845689
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31EF6B21D55
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDAA15D5AA;
	Thu,  1 Feb 2024 11:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdyQcwWQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36614D9FF
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788316; cv=none; b=uP0ztEszZZxKnW9iS4J1t9AAHm90zkpeCxw8fF0ittsUJ1L9yUyA6PG5u5ahpfqXueJJyWbBW4r4km384elLHzPYFSH/qYuBT31YmcTT0ZWhxZvLd4Yw/56fyrhnHaYKj/uOLexaTgso0Cjfakthi2tFmgHl9rFC2WEEDflg2zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788316; c=relaxed/simple;
	bh=O9lJmDiBxnZNyye1euS5klV+iMTllHBMyaYWSuHg2Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OzXGO805Yl5/PVWpFnSkDMCtLTujk5QpjTd9wHSGgmSdfmPzRBlg7JPofJJLRMTYuNoQUDKOvCDY1NrYAsZZ3HonLoIayxRk1yPNVfB9ZPx6l2w3Y7iz/ZRbsVeey8fn4spFbvOv+zbgudpNqOW2bCJx4DbrGCxyDFQHQuKSxe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdyQcwWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E630C433C7;
	Thu,  1 Feb 2024 11:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706788316;
	bh=O9lJmDiBxnZNyye1euS5klV+iMTllHBMyaYWSuHg2Sk=;
	h=From:To:Cc:Subject:Date:From;
	b=sdyQcwWQsCVyIqopa1k1f2BgcYqWMHQ5QtzFEJaeydc6127IZ3AxgVg3a9mhAoaQt
	 WFvLMAHHQ5yg3szW4KTgDA9qZHo8mk5yC+el57i3+iGpSpyjGTilwbQGdGK4sqDmuA
	 DulQ26fkpoUvsIVlQagwTlgVnmlx+HD5q8ZEvMuHS3lGCYJ9W46WPVxRhfJB8Q/TEg
	 cILS689+hLoB6R5l/lDhNxALL8Vp+ujQLTXEGucse1pjX9v1onPuZEThHd7TwoJYx+
	 VsTEmX3I2jyglZpw5GfvJhdAtQ/LO4Z/mjHdCN+yBuQHXz1e5E+yGsqwhmuBP4kYok
	 xpZh/tgXaz5Ew==
From: alexs@kernel.org
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	ricardo.neri-calderon@linux.intel.com,
	sshegde@linux.ibm.com
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH v3 1/4] sched/fair: add SD_CLUSTER in comments
Date: Thu,  1 Feb 2024 19:54:44 +0800
Message-ID: <20240201115447.522627-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

The description of SD_CLUSTER is missing. Add it.

Signed-off-by: Alex Shi <alexs@kernel.org>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Valentin Schneider <vschneid@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
To: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
---
 kernel/sched/topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 10d1391e7416..8b45f16a1890 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1554,6 +1554,7 @@ static struct cpumask		***sched_domains_numa_masks;
  * function:
  *
  *   SD_SHARE_CPUCAPACITY   - describes SMT topologies
+ *   SD_CLUSTER             - describes CPU Cluster topologies
  *   SD_SHARE_PKG_RESOURCES - describes shared caches
  *   SD_NUMA                - describes NUMA topologies
  *
-- 
2.43.0


