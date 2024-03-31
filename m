Return-Path: <linux-kernel+bounces-126111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A27AA893259
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546CC1F227F8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F002A148315;
	Sun, 31 Mar 2024 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b="cgdXFN2b"
Received: from sender-of-o51.zoho.eu (sender-of-o51.zoho.eu [136.143.169.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0988145B1E
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711900949; cv=pass; b=RAuAxJWdl+gbeiiTCsHZ5WVSmQZ78ugYRms9WGIikFubJFvv8SD1AEzd2xe9Pkj23QeeMI7JaWTeKbxaxYvzulp65PJyR8fGhAFpbaVHrv00hFAmTBm3qoOPcAil22YG+oDRPT2z8ruAQ35F5ayMWbrGb9GJ/prdgYP0lDg0V/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711900949; c=relaxed/simple;
	bh=7UriqIK5rF+laeCwYFZ6FEfSLpeqjqBoWq+9Dbpj8RE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H21a7/GUFQyQCsd4Fjf3HXPHi7LmaQV3nQNMDvI26RHaa34sv79ZzB8CKuA4sfwm1BhqurYfssttwMbnXMZBmEdo/YzEInDFlxvmDYwOYcIIAsrL0TmybhdXioAx2baoIdl2qgf7L57Lfi/jBb1ChSJb5xVJc9Jbhm92g0q+RFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com; spf=pass smtp.mailfrom=bursov.com; dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b=cgdXFN2b; arc=pass smtp.client-ip=136.143.169.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bursov.com
Delivered-To: vitaly@bursov.com
ARC-Seal: i=1; a=rsa-sha256; t=1711900922; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=BtVoi6YDJhPfA0QR3VMk8rTo/NyjF0EHmIVw7hKKEZZmzS0UqS5F/gmcdghvMC5msm5qiBXgtqH56DFJ2Wpjk1zY9KxhHCT4rqqARukhH8oALHrQ3yGHRuC65Q9fn1xSmYiJVoQNj8yu8ZNDImiKfrW/q+9IaDJtl5MyQII3vz8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1711900922; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=NUqGMZkK65kGj/RodGIbLreaTB54XBuS98+nAYke6Zk=; 
	b=BmSdmxBQrUTW+fiWkkvmJZjM3pukz0uHYBiOAp56Jkl9vNv16lZRY1JZES7Xct8E0eSa1shu7dz0MXs9ePImUMgSXjELRgb2W4pLSly/wZ/I7qfRrjqQbGFCi2aTOUdwW7gqQaqoNaGlRMhJGC255tnJNSWrNWvReCzzseH3mVI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=bursov.com;
	spf=pass  smtp.mailfrom=vitaly@bursov.com;
	dmarc=pass header.from=<vitaly@bursov.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1711900922;
	s=zoho; d=bursov.com; i=vitaly@bursov.com;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To:Cc;
	bh=NUqGMZkK65kGj/RodGIbLreaTB54XBuS98+nAYke6Zk=;
	b=cgdXFN2bdwUwcxvRZPtnRVFPokwYLVYzaFIVaDvcidAtxJJ63Y1hsIeOF1L4+caB
	mmxT82ikSSl+lZGFyKZVoDIiskbwK3fFAfRYxC2yPhKdAd08EDcF8dPATFdsQs7Cp9z
	7U+9WBunfZ3BAMT80UUrmo+vaTx6S9MG5mk8C5XE=
Received: from localhost.localdomain (217.20.170.230 [217.20.170.230]) by mx.zoho.eu
	with SMTPS id 1711900920516823.7166383685085; Sun, 31 Mar 2024 18:02:00 +0200 (CEST)
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
Subject: [PATCH v2 1/3] sched/fair: allow disabling sched_balance_newidle with sched_relax_domain_level
Date: Sun, 31 Mar 2024 19:01:47 +0300
Message-Id: <cf9955e3ea02f224a6e4bea490ba2b42bee278bb.1711900396.git.vitaly@bursov.com>
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

Change relax_domain_level checks so that it would be possible
to include or exclude all domains from newidle balancing.

This matches the behavior described in the documentation:
  -1   no request. use system default or follow request of others.
   0   no search.
   1   search siblings (hyperthreads in a core).

"2" enables levels 0 and 1, level_max excludes the last (level_max)
level, and level_max+1 includes all levels.

Fixes: 9ae7ab20b483 ("sched/topology: Don't set SD_BALANCE_WAKE on cpuset domain relax")
Signed-off-by: Vitalii Bursov <vitaly@bursov.com>
---
 kernel/cgroup/cpuset.c  | 2 +-
 kernel/sched/topology.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 4237c8748..da24187c4 100644
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
index 63aecd2a7..67a777b31 100644
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


