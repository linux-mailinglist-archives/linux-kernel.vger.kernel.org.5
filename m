Return-Path: <linux-kernel+bounces-164247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD3C8B7B5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238791F221D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A840917333A;
	Tue, 30 Apr 2024 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b="I/pPWhUY"
Received: from sender-of-o51.zoho.eu (sender-of-o51.zoho.eu [136.143.169.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B71173323
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490504; cv=pass; b=gKfUrZX33XIC2GoPnUZAuxUGcoXBpeIV8s8mI5BRrR4hqzLHAHNMR4sKdJjQOxhRTmYv3r4xk76GmNq4Do86MHU4tnKcd6x275DPSHkDDdDSAjIBWmHgWgvMNhpiJYnLt9d0RWbi13GzJiwg7F0o5jXjqyZPnvO2kuWa6n7wAgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490504; c=relaxed/simple;
	bh=9q2UvKi721zzwlCIz7yMKaYvq9MajS5wHDLVQtcgWfM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=enyHUNrwWUYBN/v0elKW9qqvISQiVHzE9/iwId/e3PyOfFsB+EO65czJbh+qlWEaJThOrVhh++WsHIDp+z6jPlRQWok9ZZCsQAGrj4SzneI5mQN6TAuBFeTI4c5lvRJAtR2vNSrOpaWwn3tMS+P5Qt7OZw1Dg+6BgmW+UGdncy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com; spf=pass smtp.mailfrom=bursov.com; dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b=I/pPWhUY; arc=pass smtp.client-ip=136.143.169.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bursov.com
Delivered-To: vitaly@bursov.com
ARC-Seal: i=1; a=rsa-sha256; t=1714489541; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ftCcWbRZB+5Pd5j2RQCBqODutTgVIuYFx6JyH9VNAN+QBLlOdvZc+yBNO04bTUotSBm3fv2o7FhcyjmICxqcgZhd18Dm4YG54j1M61H57whYgSybZ6CzrV3WeNkKOPzoQkuw+IJwVKd6rqsgoNPcuqnPoOtZ1zGHD1WWcdxHk/s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1714489541; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=TSjs4VO1uQlNJFwZ2OnHqukx8VVY7fpZFiPQ8x91S4Q=; 
	b=JMTGvgdDejnWpnlIkgnjVNW4EyqkHCDWSyUo9POJawwDiYy7DQUsof1B8Lrp8zRn4N1Rld1cQksbC64jG89wm7vjfqNWlFdsy9DNXkogEn/MfZTwpl4z3Nw5vgCjVsQb5efQovn3PZBj7Q95uQlp5W5WnProOQPiYJE0fSZ+m7M=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=bursov.com;
	spf=pass  smtp.mailfrom=vitaly@bursov.com;
	dmarc=pass header.from=<vitaly@bursov.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1714489541;
	s=zoho; d=bursov.com; i=vitaly@bursov.com;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To:Cc;
	bh=TSjs4VO1uQlNJFwZ2OnHqukx8VVY7fpZFiPQ8x91S4Q=;
	b=I/pPWhUYjvOxZ1P+05Cw4JrU/KMKYmt0FoilYd/idmkt3e2rHkaNsFxIZpHMqLt+
	/YS8aYyIkyvEsAYpgBTGDEAZsuscwjG5P/5lk4Dw3Ahl4pP/B9x2XQsM5W53U4XR8Lj
	tZD6hwU6sSmuuDhUTGAhV7FHWYQ09mKZhjvha3ak=
Received: by mx.zoho.eu with SMTPS id 1714489538296462.0323309715968;
	Tue, 30 Apr 2024 17:05:38 +0200 (CEST)
From: Vitalii Bursov <vitaly@bursov.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Vitalii Bursov <vitaly@bursov.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH v4 1/3] sched/fair: allow disabling sched_balance_newidle with sched_relax_domain_level
Date: Tue, 30 Apr 2024 18:05:23 +0300
Message-Id: <bd6de28e80073c79466ec6401cdeae78f0d4423d.1714488502.git.vitaly@bursov.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1714488502.git.vitaly@bursov.com>
References: <cover.1714488502.git.vitaly@bursov.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Change relax_domain_level checks so that it would be possible
to include or exclude all domains from newidle balancing.

This matches the behavior described in the documentation:
  -1   no request. use system default or follow request of others.
   0   no search.
   1   search siblings (hyperthreads in a core).

"2" enables levels 0 and 1, level_max excludes the last (level_max)
level, and level_max+1 includes all levels.

Fixes: 1d3504fcf560 ("sched, cpuset: customize sched domains, core")
Signed-off-by: Vitalii Bursov <vitaly@bursov.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/cgroup/cpuset.c  | 2 +-
 kernel/sched/topology.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 4237c8748715..da24187c4e02 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2948,7 +2948,7 @@ bool current_cpuset_is_being_rebound(void)
 static int update_relax_domain_level(struct cpuset *cs, s64 val)
 {
 #ifdef CONFIG_SMP
-	if (val < -1 || val >= sched_domain_level_max)
+	if (val < -1 || val > sched_domain_level_max + 1)
 		return -EINVAL;
 #endif
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 63aecd2a7a9f..67a777b31743 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1475,7 +1475,7 @@ static void set_domain_attribute(struct sched_domain *sd,
 	} else
 		request = attr->relax_domain_level;
 
-	if (sd->level > request) {
+	if (sd->level >= request) {
 		/* Turn off idle balance on this domain: */
 		sd->flags &= ~(SD_BALANCE_WAKE|SD_BALANCE_NEWIDLE);
 	}
-- 
2.20.1


