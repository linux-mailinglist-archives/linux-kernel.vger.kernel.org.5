Return-Path: <linux-kernel+bounces-164246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D82708B7B59
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD1F1F22827
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11909143737;
	Tue, 30 Apr 2024 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b="I8Dq12qz"
Received: from sender-of-o59.zoho.eu (sender11.zoho.eu [31.186.226.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A7914375B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=31.186.226.224
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490499; cv=pass; b=HM0Hfsjya5eyWyH51qJJSfxlWLcQjUru8f3giOAmSoM32ixv3bQzlFhYWZnwoK+3UH1/28Ym+hEjvq1kV7kKj89XL6er3cXe3kVdvMbE46N4KwsOlSXQPDe/d3kmt1Sn1yjTBJ3LrXOT58gdz8/h9FC5FRE1KJ2ClTDJBIPEU/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490499; c=relaxed/simple;
	bh=UNytWRjy0n4ufLE4F4bgxm6zk7gEYUpI72DLf8Lh5nI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Am04SKTtsITdR1IDyURVcW2GJ+8tLZ6Pd+q5RYyS5/zd7NWgYiFvMdKKR/WkOb8OEPPqb4/oo+S1jCvhjAF2N552Sk1+8nQ9r98ONpucCgBotCvhP+JMT/gLYKcUBcXJyOPoGrGiL0iUxEF6Qf/OiItEf2L7Ukg7AT5oLjFS8DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com; spf=pass smtp.mailfrom=bursov.com; dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b=I8Dq12qz; arc=pass smtp.client-ip=31.186.226.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bursov.com
Delivered-To: vitaly@bursov.com
ARC-Seal: i=1; a=rsa-sha256; t=1714489544; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=GAR+MO0G1SSg6TNipsrxYMopQvHPfaXiH8qxyZXcu+MM2gBFJfpVXsEBOv7RYMHXK32yiIEFqoZF8lj6xrexHD2DI07xjz/kv6oRoqfanTffGDlIcXZKNl2PiCjFCM7peNUmS7z5eYxjrgziaAiAazJ0hF4WD1BVMO4fCQRQZdc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1714489544; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=ztyWG1tL5SLCHcSqhDRsGp0b5KZvYGYaxjeAuQmObZI=; 
	b=D6mMnF4JWji1XCjxMh0wKFs4hPXLFJSfRoZOnxHohMrfHPLroWXjIkV8Ip2ffOchYczlv1asKdo6BNRQHp/nenoh0DE0D0jWK2ea7RN4N9ehRtx/RQ0hK3f9RZhKM1kM1YbeX05RktWXdFYyYb3jGMSHh829seWrMxF/E2Jg274=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=bursov.com;
	spf=pass  smtp.mailfrom=vitaly@bursov.com;
	dmarc=pass header.from=<vitaly@bursov.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1714489544;
	s=zoho; d=bursov.com; i=vitaly@bursov.com;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To:Cc;
	bh=ztyWG1tL5SLCHcSqhDRsGp0b5KZvYGYaxjeAuQmObZI=;
	b=I8Dq12qzCvFFqZb5/acgvMW1eFFDEsAd1iMdYmymV+AJnHDSF2lQE7jprjud+EDb
	sE4ezQ/msEkv4GoTZBkiro/1Y2LmS3qtuOxefgn6gjeWuH5HyGttspbUDrIgl33dzaZ
	MzJPe1O/3JzjK7NFlK7FuU6EfB3Wy29PvKdSUw0c=
Received: by mx.zoho.eu with SMTPS id 1714489542370188.36636328634086;
	Tue, 30 Apr 2024 17:05:42 +0200 (CEST)
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
Subject: [PATCH v4 3/3] docs: cgroup-v1: clarify that domain levels are system-specific
Date: Tue, 30 Apr 2024 18:05:25 +0300
Message-Id: <42b177a2e897cdf880caf9c2025f5b609e820334.1714488502.git.vitaly@bursov.com>
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

Add a clarification that domain levels are system-specific
and where to check for system details.

Signed-off-by: Vitalii Bursov <vitaly@bursov.com>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
---
 Documentation/admin-guide/cgroup-v1/cpusets.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v1/cpusets.rst b/Documentation/admin-guide/cgroup-v1/cpusets.rst
index 7d3415eea05d..f401af5e2f09 100644
--- a/Documentation/admin-guide/cgroup-v1/cpusets.rst
+++ b/Documentation/admin-guide/cgroup-v1/cpusets.rst
@@ -568,7 +568,7 @@ on the next tick.  For some applications in special situation, waiting
 
 The 'cpuset.sched_relax_domain_level' file allows you to request changing
 this searching range as you like.  This file takes int value which
-indicates size of searching range in levels ideally as follows,
+indicates size of searching range in levels approximately as follows,
 otherwise initial value -1 that indicates the cpuset has no request.
 
 ====== ===========================================================
@@ -581,6 +581,11 @@ otherwise initial value -1 that indicates the cpuset has no request.
    5   search system wide [on NUMA system]
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


