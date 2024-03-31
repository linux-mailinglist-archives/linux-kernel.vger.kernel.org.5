Return-Path: <linux-kernel+bounces-126115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E243C89325D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4871C21C74
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFBC14885E;
	Sun, 31 Mar 2024 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b="uchmRoTk"
Received: from sender-of-o51.zoho.eu (sender-of-o51.zoho.eu [136.143.169.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F8B148FF5
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711900954; cv=pass; b=T9FamtZOJXTiAliY59sR5XIAOa5QNwaXlDWuu99P4JbxXBXrjYAj9H8qXypuMIhVpngBlLvP63xDQGoR2QQE4U2sNXzZiLD/iu3q92EsBadESxU4EyDs6XLn3rEodPFuCi7jSZO5/4ZBoQYHUbq4OqTi544k8Sh9g4OjzemNHoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711900954; c=relaxed/simple;
	bh=avuhYgLWVdEz3QPjIiNeZFxgxLHoyXJgRiOZcBkekdw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jtPdSNpfA82MVn2HKdC/11tNo8r3jglt8FZmlKZZZqqjqolLaBi7tuIUdFvLK9P8mhBOjQ2WE50EPT2aj0YFfNMuJzy4H7oU5FwPe5Tc8TygQAezVXsuGMjebmMp7jnTyFCcpVCO55ETn+BLOXxSbgb3sy8u9JGyTIa14F49u+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com; spf=pass smtp.mailfrom=bursov.com; dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b=uchmRoTk; arc=pass smtp.client-ip=136.143.169.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bursov.com
Delivered-To: vitaly@bursov.com
ARC-Seal: i=1; a=rsa-sha256; t=1711900922; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=PsvDzgAZjqv/CGOdUo7+sNE76xXHYRqnRVS2yZF/m5tTlKa0ZDz1nEQl4ikI7hvfixnXO3zg13zcp+twDOgw1fpmpbjFhDpz3TcFjFQj/b7EDSfLzj6/Ed7lf7+MnfjRL8BcSWbbizkOrN9Okb5GbN/p7nlXIHVvrI8Xa0Ng7N0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1711900922; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=dFZ+Th39mFALLRRNFXdhDn/IaGd1DyCaJm+9g0YLcTE=; 
	b=ATRz63owEmLA2j5An83ZBB8Ie2qE+YpTEJZ2rxuyN1RjLM/VIjtyIiSF3jBJIq8GDe49Rl2JKkw1AqAR8Q1asLfuEtIkXeZNdho94piVknOz2rOE2B4GOYMuGjurT6qgeiaFq1kTARwckIOSYTU3JKb7JKQ2MjncYrWlj2ZHc1U=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=bursov.com;
	spf=pass  smtp.mailfrom=vitaly@bursov.com;
	dmarc=pass header.from=<vitaly@bursov.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1711900922;
	s=zoho; d=bursov.com; i=vitaly@bursov.com;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To:Cc;
	bh=dFZ+Th39mFALLRRNFXdhDn/IaGd1DyCaJm+9g0YLcTE=;
	b=uchmRoTkP9LYdMA/S+sP/onU+WdnM2ASKLPkH5aCJgTmaiui0CWY7OsjXVPEW52u
	8fnogrOj15IRRfNUNX102nsqYKTu35wHyglaQgjiOTgqa5XpA1hvhdaFUqI2jmPCBEz
	0YSWeBn3XLNdK3gTa0OfUTvGM9Hs06qk/u2AFKlI=
Received: from localhost.localdomain (217.20.170.230 [217.20.170.230]) by mx.zoho.eu
	with SMTPS id 1711900922174361.44191369435737; Sun, 31 Mar 2024 18:02:02 +0200 (CEST)
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
	Vitalii Bursov <vitaly@bursov.com>
Subject: [PATCH v2 3/3] docs: cgroup-v1: clarify that domain levels are system-specific
Date: Sun, 31 Mar 2024 19:01:49 +0300
Message-Id: <af9562aac2e9208029aef1dd19c3b0e096dd42c7.1711900396.git.vitaly@bursov.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1711900396.git.vitaly@bursov.com>
References: <cover.1711900396.git.vitaly@bursov.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add a clarification that domain levels are system-specific
and where to check for system details.

Add CPU clusters to the scheduler domain levels table.

Signed-off-by: Vitalii Bursov <vitaly@bursov.com>
---
 Documentation/admin-guide/cgroup-v1/cpusets.rst | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/cpusets.rst b/Documentation/admin-guide/cgroup-v1/cpusets.rst
index 7d3415eea..d16a3967d 100644
--- a/Documentation/admin-guide/cgroup-v1/cpusets.rst
+++ b/Documentation/admin-guide/cgroup-v1/cpusets.rst
@@ -568,19 +568,25 @@ on the next tick.  For some applications in special situation, waiting
 
 The 'cpuset.sched_relax_domain_level' file allows you to request changing
 this searching range as you like.  This file takes int value which
-indicates size of searching range in levels ideally as follows,
+indicates size of searching range in levels approximately as follows,
 otherwise initial value -1 that indicates the cpuset has no request.
 
 ====== ===========================================================
   -1   no request. use system default or follow request of others.
    0   no search.
    1   search siblings (hyperthreads in a core).
-   2   search cores in a package.
-   3   search cpus in a node [= system wide on non-NUMA system]
-   4   search nodes in a chunk of node [on NUMA system]
-   5   search system wide [on NUMA system]
+   2   search cpu clusters
+   3   search cores in a package.
+   4   search cpus in a node [= system wide on non-NUMA system]
+   5   search nodes in a chunk of node [on NUMA system]
+   6   search system wide [on NUMA system]
 ====== ===========================================================
 
+Not all levels can be present and values can change depending on the
+system architecture and kernel configuration. Check
+/sys/kernel/debug/sched/domains/cpu*/domain*/ for system-specific
+details.
+
 The system default is architecture dependent.  The system default
 can be changed using the relax_domain_level= boot parameter.
 
-- 
2.20.1


