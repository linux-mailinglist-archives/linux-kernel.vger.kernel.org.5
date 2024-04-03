Return-Path: <linux-kernel+bounces-129838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D65897117
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790E91C26606
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFF2147C8C;
	Wed,  3 Apr 2024 13:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b="OcfzIyBT"
Received: from sender-of-o51.zoho.eu (sender-of-o51.zoho.eu [136.143.169.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6538148304
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150942; cv=pass; b=FL46sHDkW1oxq9XrzOC9dAPMoztCxFdUcl4kimGS5I/qc2AS1xP5DFHxpFpXV1vcxET8YMn7XLbRQSFYDE+WgSNIQ4vdwPLLOIYJw4u3Mxgc3+eaSvZkGbvZm/+H0ExtNJDhA2EJxC9WlE5/UHaKU+Y9QvM6vAnh2bpg4blsnls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150942; c=relaxed/simple;
	bh=HcKHy8drIWWvkpQQVFm+9+fLns3UQuLQqoF0UVMhQIE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y537Xmiv9gT56fmh+Vj8lK20KFMuYL+Wc/2lmdufygU1brDjERf5A2ZYMbVm6OUNTY7QP3PYPkjKxH2vL3cHkqwzzobx/lMG7jqcmKQm3cal3BAYAoTdh8LbpHbuCmiBw2XbmtRgxQj+NWt76vDgbxnsYHujYUIdxxj+5Pvnf4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com; spf=pass smtp.mailfrom=bursov.com; dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b=OcfzIyBT; arc=pass smtp.client-ip=136.143.169.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bursov.com
Delivered-To: vitaly@bursov.com
ARC-Seal: i=1; a=rsa-sha256; t=1712150902; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=SPMB/Giio3mfF5QAJGU14AsrhM6oafxTQIJo4EFCqEu53BlnDVH0tFxLY3gXXucWgRXi9YlOZuHurfLtLP3Qhyq9o/GXH4ZbsYx6bc12Q+uOXA4BvvjIWaxxmYMGVazVBz7jeaVJ0POy9D9+8Eh3cZK74yPznmZeINsFLhisgRQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1712150902; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=qzgY0Cl/6ChalgCgdaGF+ngKcH92TjAXnthTIYJSWZQ=; 
	b=JyuZBSqHQCyJVNScg15n0/IHdKJ5FVOfNduwagIUNFs69RDDTFrtqRa8K0Qux9d19s4wlIQSimAEPV7cpB+qixVApOIA1soeiTwZwB7gMbPo/V8PCJ7iUnwxWecpRipaals3aIvk4cm89Go7opeYdpBJW2wh3i18esFohdvjGCk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=bursov.com;
	spf=pass  smtp.mailfrom=vitaly@bursov.com;
	dmarc=pass header.from=<vitaly@bursov.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1712150902;
	s=zoho; d=bursov.com; i=vitaly@bursov.com;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To:Cc;
	bh=qzgY0Cl/6ChalgCgdaGF+ngKcH92TjAXnthTIYJSWZQ=;
	b=OcfzIyBT9ePXxKkhfx4V2dSG/nD8IAdOKRgyHIY3QsGJTAqavBL/uqPHKUnSDeVN
	W4stnV4Hq13tNTC9sPnZWPrEfXyFxyTq94NliXcQXINwqQSZcyU4UTlWnrp2xZwMu6f
	i8dUttTdyM6QfwHkq1USekg3/1RCwUui9IVtMdI0=
Received: from localhost.localdomain (217.20.170.230 [217.20.170.230]) by mx.zoho.eu
	with SMTPS id 1712150900004593.1479613998665; Wed, 3 Apr 2024 15:28:20 +0200 (CEST)
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
Subject: [PATCH v3 1/3] sched/fair: allow disabling sched_balance_newidle with sched_relax_domain_level
Date: Wed,  3 Apr 2024 16:28:04 +0300
Message-Id: <e97fd467bbe1d7168bbd73b7c9d182f46bf47a90.1712147341.git.vitaly@bursov.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1712147341.git.vitaly@bursov.com>
References: <cover.1712147341.git.vitaly@bursov.com>
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
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
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


