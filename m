Return-Path: <linux-kernel+bounces-129836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22678897113
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F7B1F29298
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18032149018;
	Wed,  3 Apr 2024 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b="pVzb4WxW"
Received: from sender-of-o51.zoho.eu (sender-of-o51.zoho.eu [136.143.169.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAB9147C6C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150939; cv=pass; b=EUcrrlJSuIs/jUYnf7D7D1ieMFVZLOmtJoti2L2ACssqoV8y4AwZLnRTI8i5e5trbiTfR0Yemqo9KtxGxbw2F3Fd6NR6GB/rCfwu10/woo6XdrkikP6k2R7OYZeM82rZEa7QYaY5XhSR4G7CowRzF/HOScbwuT+Kugu2nytawVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150939; c=relaxed/simple;
	bh=ep/aM4UQ3Rc0khxGhp+4Y6RB4Pmta9qCzL1Sw7BBg58=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oQgiKs18xQdzcvRQrMIJHSMG8HN7+U/M0bvwy0i1EJ5fkZzMZPoE4X6fFNNG8NKxZ06ooTVLpVTVz14X1ZM6+BUSW6aUGimT5ZN4+JYicLvAd/L6XH7hl1APuor9MMOxCmBXQ9+9emB6khJd5zekOMlsVdMUpcVnlmfnBm0LtSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com; spf=pass smtp.mailfrom=bursov.com; dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b=pVzb4WxW; arc=pass smtp.client-ip=136.143.169.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bursov.com
Delivered-To: vitaly@bursov.com
ARC-Seal: i=1; a=rsa-sha256; t=1712150904; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=YCKW4ozBe+xoPJkaMBl33Oj47iCQ+t/fIVOyJwgc0uM8krcOSGvl1Ecq/rjopIivL+CAmkEt4NYFavrRJ2MIbzX2Y5WTez58srTlsv8g+MtgfYHyAtIzQ7P+HgKgqNuwCPRH3Quclj6hhyCf2kJNkgnEfbTlgjh1pEKlCK2m4zw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1712150904; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=9bXuIj+PDKqj9scGTWjOC6w1rao7BU1VlWs7XoTLDO4=; 
	b=SCw5CPb1LGYOBadJ+eXpoftbvwjHOZO+5ZyfrlloX3sgc7f+54vAlFDHtiMMVCE3NYLcJiGTTJfrHj96hR+FPCSiD43iM9kZWFz3ZyK1SMRzWyUSTgujmhcksM9pSAYVH3bOlgezCsInbBpvnw7H7G3UxIIynoJFG9egkW3/wZE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=bursov.com;
	spf=pass  smtp.mailfrom=vitaly@bursov.com;
	dmarc=pass header.from=<vitaly@bursov.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1712150904;
	s=zoho; d=bursov.com; i=vitaly@bursov.com;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To:Cc;
	bh=9bXuIj+PDKqj9scGTWjOC6w1rao7BU1VlWs7XoTLDO4=;
	b=pVzb4WxWijJ9GMxajmDOadze1n5ulI/o2i4dJEj8yskoVWS0+vES3rDa//L6Qk+3
	wWqpmF8VJ/X3/8//zI5rnSn1nllD/WSLQSMWB3J5zDGNMCtwrkXyWmM8vDhlKpCmbvj
	BsguMiQAr3cfhcSVTCqqjFHamEwLTO4chxSSE6/0=
Received: from localhost.localdomain (217.20.170.230 [217.20.170.230]) by mx.zoho.eu
	with SMTPS id 1712150903173220.99083567666742; Wed, 3 Apr 2024 15:28:23 +0200 (CEST)
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
Subject: [PATCH v3 3/3] docs: cgroup-v1: clarify that domain levels are system-specific
Date: Wed,  3 Apr 2024 16:28:06 +0300
Message-Id: <03b7979666088f8d55db301c6649e0c75c727d6e.1712147341.git.vitaly@bursov.com>
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

Add a clarification that domain levels are system-specific
and where to check for system details.

Signed-off-by: Vitalii Bursov <vitaly@bursov.com>
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


