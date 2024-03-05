Return-Path: <linux-kernel+bounces-92029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA598719F8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B851F1F21250
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E16535D6;
	Tue,  5 Mar 2024 09:51:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A465102F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632283; cv=none; b=WC8Z6VkR18QMM0Cq+8tj9NQ6Qp31zSFncWDSP0U1R4bQ2Dm/NfS24SnhPpTQfec63knBk3KJ88BnVbo42ldk1+kYCz1NTRma9tfuMuTCFtnj5r36KW+ufY2qee7oJ5IP1iDW/4CFeZLnML+LwcBgLuczDZmVY9Lz2y7ulPdthGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632283; c=relaxed/simple;
	bh=TLO69UVPVH5gIcomtjF0EdvwLPCmGeBYISDDUc/Eplg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j/iHbVgM6PQq5JKN0BZ1/45xdjDKQY2i2bDmBijgPmMXFXz5nwQVAPYxbEBPhEabIDxZBkhdky9xKoH9SXqvAVaBYqXZ1FObovPfJ7PprmQ55cdPzUCH1yWg1w1YEBWKOVlfk3VQMpNzKgl7BF7xl62Hu1oNrJZ3wDzztRuve7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 797141FB;
	Tue,  5 Mar 2024 01:51:56 -0800 (PST)
Received: from e133047.cambridge.arm.com (e133047.arm.com [10.1.29.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5EE813F762;
	Tue,  5 Mar 2024 01:51:18 -0800 (PST)
From: Christian Loehle <christian.loehle@arm.com>
To: linux-kernel@vger.kernel.org
Cc: vincent.guittot@linaro.org,
	mingo@redhat.com,
	peterz@infradead.org,
	dietmar.eggemann@arm.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] sched/fair: Remove stale FREQUENCY_UTIL comment
Date: Tue,  5 Mar 2024 09:51:11 +0000
Message-Id: <20240305095111.777525-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

effective_cpu_util() flags were removed, so remove the comment part
mentioning it.

commit 9c0b4bb7f6303 ("sched/cpufreq: Rework schedutil governor performance estimation")
reworked effective_cpu_util() removing enum cpu_util_type.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/fair.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 533547e3c90a..6b0c47d00fd3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7849,8 +7849,6 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 		 * Performance domain frequency: utilization clamping
 		 * must be considered since it affects the selection
 		 * of the performance domain frequency.
-		 * NOTE: in case RT tasks are running, by default the
-		 * FREQUENCY_UTIL's utilization can be max OPP.
 		 */
 		eff_util = effective_cpu_util(cpu, util, &min, &max);
 
-- 
2.34.1


