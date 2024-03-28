Return-Path: <linux-kernel+bounces-122236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C9888F3B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E813C1C32629
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D565763B9;
	Thu, 28 Mar 2024 00:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b="ZubMQQYX"
Received: from sender-of-o51.zoho.eu (sender-of-o51.zoho.eu [136.143.169.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A815B33CA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 00:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711585888; cv=pass; b=lz3KxCY1t0cCDVefY+nY935NCNSC4CPqtNjiBdi3MsDiRgxq6zuWrm4COc5Uym51e6UI403PySMQ/1exWw06gyFV/mKvv75oyDpgbtNX4Y8XezTcL3fL41rMcFa5skxgyQq4zd45fsPgas70ZCIUYim0FkHSih7iGLmEDntSDws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711585888; c=relaxed/simple;
	bh=oBTh3Xz9F6M+SxEIJ9+s4QhP5nM3HwynD1A58Y3XOUQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W9PBDq37e+7jRFWznBlBA+FPXiTGJo5S/pUaZZBNGVQ/764iSpk2PBJKxaZobDnJYfVLZoq6zr2diPAUCTjvWFmHAUtrCgfLJUNqRsz09q9h67aQH5bIV5oXLZBq2E/GANr/iYzVsj17c58NSxBkLAYDwl7XVN8PHNRKZ6MF+L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com; spf=pass smtp.mailfrom=bursov.com; dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b=ZubMQQYX; arc=pass smtp.client-ip=136.143.169.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bursov.com
Delivered-To: vitaly@bursov.com
ARC-Seal: i=1; a=rsa-sha256; t=1711585857; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=UrGaE8TvJFAseBPEJvss4ABKz/aOlGZqM1tjAv2/iwhVk1S+KmUTyZsaOOrSqHC7BivfHzK9S77I6ZFEUpYfKjMlh8UpHyNFIIuPcDzt0PS0QXgMYEWor5EnGJ2+DTSQaPvm38WHYDAh3nMznEl79M2upcKC9DWTARVxsZd4Ljg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1711585857; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=E2b9RGhWczqDUraiy24cZKo+t1EYmOKgcTdEgZLcjD8=; 
	b=M3b1+uJaLuEDiFZa2afsKaZ3I2Mlwr3hHprSxBNkLe1468F1TY6yJPGniAUW0swzfenXlv8UtNEMl2A1Qr2CGDIijF6kRcwy4Fpxr1SAtAis7oeCyncAYaVOT2fExTJVjNi4DCydu7iz3U3YDuWP59W2C83f7scmijzc9Hl+U+4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=bursov.com;
	spf=pass  smtp.mailfrom=vitaly@bursov.com;
	dmarc=pass header.from=<vitaly@bursov.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1711585857;
	s=zoho; d=bursov.com; i=vitaly@bursov.com;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To:Cc;
	bh=E2b9RGhWczqDUraiy24cZKo+t1EYmOKgcTdEgZLcjD8=;
	b=ZubMQQYXdeSaq4c/9S+oNHDLZPeS9k2O5rgNJhxJCKIdvrH1C35CqDHM3R+KGmY9
	o2jb92y15PY/1oaL6VyOFaryTpJVvNKiN/X63noawm4cx45cN+RDs+Z0S9Po6N6ATQu
	+7hF1EGYRlQwb2FKQsR2uoRiAKH0NNU8dQMHXqvk=
Received: from localhost.localdomain (217.20.170.230 [217.20.170.230]) by mx.zoho.eu
	with SMTPS id 1711585855910377.043696657845; Thu, 28 Mar 2024 01:30:55 +0100 (CET)
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
Subject: [PATCH 1/1] sched/fair: allow disabling newidle_balance with sched_relax_domain_level
Date: Thu, 28 Mar 2024 02:30:18 +0200
Message-Id: <da4454bf368e51369c74e4574d22e8f0bfd9d368.1711584739.git.vitaly@bursov.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1711584739.git.vitaly@bursov.com>
References: <cover.1711584739.git.vitaly@bursov.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Change relax_domain_level checks so that it would be possible
to exclude all domains from newidle balancing.

This matches the behavior described in the documentation:
  -1   no request. use system default or follow request of others.
   0   no search.
   1   search siblings (hyperthreads in a core).

"2" enables levels 0 and 1, level_max excludes the last (level_max)
level, and level_max+1 includes all levels.

Signed-off-by: Vitalii Bursov <vitaly@bursov.com>
---
 kernel/cgroup/cpuset.c  | 2 +-
 kernel/sched/debug.c    | 1 +
 kernel/sched/topology.c | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 4237c874871..da24187c4e0 100644
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
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8d5d98a5834..8454cd4e5e1 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -423,6 +423,7 @@ static void register_sd(struct sched_domain *sd, struct dentry *parent)
 
 #undef SDM
 
+	debugfs_create_u32("level", 0444, parent, (u32 *)&sd->level);
 	debugfs_create_file("flags", 0444, parent, &sd->flags, &sd_flags_fops);
 	debugfs_create_file("groups_flags", 0444, parent, &sd->groups->flags, &sd_flags_fops);
 }
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 99ea5986038..3127c9b30af 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1468,7 +1468,7 @@ static void set_domain_attribute(struct sched_domain *sd,
 	} else
 		request = attr->relax_domain_level;
 
-	if (sd->level > request) {
+	if (sd->level >= request) {
 		/* Turn off idle balance on this domain: */
 		sd->flags &= ~(SD_BALANCE_WAKE|SD_BALANCE_NEWIDLE);
 	}
-- 
2.20.1


