Return-Path: <linux-kernel+bounces-103977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D74387C75A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757222835D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D02E6FD1;
	Fri, 15 Mar 2024 01:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fx7HCM5R"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6F86FA9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 01:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710467982; cv=none; b=G4ImnaOXOce69Jvky2aM0cyLQofasC+uGHUHAhhsa2dC+DQZ72I9tMyZzFUyg87pzqEWxV/NOUwM+xsvq0jxCKP/hfGBTO6lBoIsqqDuD8KoEvQsomuTSZCBnbCCv5VaaDhu7MJLiw+/RN69MrZIiVTgn/B7Gyr+3icASLBuhF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710467982; c=relaxed/simple;
	bh=MbNgZ46a4w6dGK4rz5hedwYJCosUFMkEU495Sftkeg8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hFKpZJ2nQdhgLMW2/3BHwM6va2oFJ5u0npa4uIEupUaeHkwp9TXOHEhwB1xH3YIXNhtLV9T9Ru6KqaAUtCn7YdIPL20AjLuVQFhStlyFHNUGksE9odJCd29J16JRlQF40w64Ks8Mr9T89NFiqzqz/nvmRUZmL46QzyypnJY1DqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fx7HCM5R; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e6a9fafacdso1392482b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710467980; x=1711072780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=01D4Shz91ZXQp0AsK5UAAqfBWEt2jNNLBzet4PYM1dM=;
        b=Fx7HCM5RClY5jZri7Iuj2G/VvMM9Bu20jyorfLsDlwniMbpWDuYGaAW41B9n4WeMJQ
         B2h/5eYfOiquX5siD/bUTVcZVVRwayhOu4P3/2jzhWJVr+cUI8Etg8NOY9BShdZT3uRT
         /MdiefQBgVq8+pGNgD0VechjOlMlOmIKV9MjKB1Aofb3PehKQLPXF0+kw5JjeHqlMFxh
         r4jdqzIoQ63TPeSab2M+aSYXW6qXRN4TDcyDpw3M9+4eskBWjU+tleKF2La6D8qbA71g
         5M1M+T5nLQu9Tl9my7hwHjg2Na5FaVlRV0UAVYAvzsWbP3SO/NmQzJY/lLPKeGZfTGMp
         dtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710467980; x=1711072780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01D4Shz91ZXQp0AsK5UAAqfBWEt2jNNLBzet4PYM1dM=;
        b=OvpxFSlO8d/slMAJB0Njz8Udevlpb8XX+RgtEU2dol7MhlLTLEMfM52BQheiH7ul5x
         gyjYGK0P7nMiOLvt+aWEZ9hFTjLmQ4gYg2Q6w5F89zCs9R4H85saXatQWFMeVNj1dYXp
         GUTVasIs3+6OKqNFb5NhVMgusjSJcuiwW8fJSTmccNBjMHWN7ck3dBV0b5YHEMc7XSXh
         zNWnab+tzXWT8KxPCEn/vVlSE/dpajoLetTQsoi/Pa/ikw8qbUovmm2MsclfZyLSo4su
         WXB2ccwPJLsiV+0MZhiKYMUu671IS0svMuGk0WF+sZHNRB2e0wG9DtYlebYpXI0grNcp
         4MCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKpbL22eDYxFDt0fdfH6FTxxdpMxIgNHJLZTsfoRfRj3htlNYgZyCkNzDA2w71M4Lve60QsSnyQgxGPjviYU75KMjFdV/DLnz+a8h7
X-Gm-Message-State: AOJu0YyFiAi1Z4NbH8EniUdSfoqxoLWgiEzq9by4dZ5+9DPAzNAzG6zV
	Yin71zkP2OGfqowi0/j/0hT9iw42pNW9Jl7Ljd+5V0tcAPl7WqVA
X-Google-Smtp-Source: AGHT+IEVEs/hSbJPnkfjE2yqPiXC3wUh6sBk44e86c6icmlhdrLwaOBvdGoBUAvIzFf0P6xlhurdqw==
X-Received: by 2002:a05:6a20:9381:b0:1a3:4777:7941 with SMTP id x1-20020a056a20938100b001a347777941mr2107593pzh.33.1710467980429;
        Thu, 14 Mar 2024 18:59:40 -0700 (PDT)
Received: from ub23.localdomain (c-24-16-118-101.hsd1.wa.comcast.net. [24.16.118.101])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b001d949393c50sm2451086plr.187.2024.03.14.18.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 18:59:40 -0700 (PDT)
From: Dawei Li <daweilics@gmail.com>
To: 
Cc: Dawei Li <daweilics@gmail.com>,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched/fair: fix initial util_avg calculation
Date: Thu, 14 Mar 2024 18:59:16 -0700
Message-Id: <20240315015916.21545-1-daweilics@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change se->load.weight to se_weight(se) in the calculation for the
initial util_avg to avoid unnecessarily inflating the util_avg by 1024
times.

The reason is that se->load.weight has the unit/scale as the scaled-up
load, while cfs_rg->avg.load_avg has the unit/scale as the true task
weight (as mapped directly from the task's nice/priority value). With
CONFIG_32BIT, the scaled-up load is equal to the true task weight. With
CONFIG_64BIT, the scaled-up load is 1024 times the true task weight.
Thus, the current code may inflate the util_avg by 1024 times. The
follow-up capping will not allow the util_avg value to go wild. But the
calculation should have the correct logic.

Signed-off-by: Dawei Li <daweilics@gmail.com>
---
Changes in v2:
- update the commit message
---
 kernel/sched/fair.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a19ea290b790..5f98f639bdb9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1031,7 +1031,8 @@ void init_entity_runnable_average(struct sched_entity *se)
  * With new tasks being created, their initial util_avgs are extrapolated
  * based on the cfs_rq's current util_avg:
  *
- *   util_avg = cfs_rq->util_avg / (cfs_rq->load_avg + 1) * se.load.weight
+ *   util_avg = cfs_rq->avg.util_avg / (cfs_rq->avg.load_avg + 1)
+ *		* se_weight(se)
  *
  * However, in many cases, the above util_avg does not give a desired
  * value. Moreover, the sum of the util_avgs may be divergent, such
@@ -1078,7 +1079,7 @@ void post_init_entity_util_avg(struct task_struct *p)
 
 	if (cap > 0) {
 		if (cfs_rq->avg.util_avg != 0) {
-			sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
+			sa->util_avg  = cfs_rq->avg.util_avg * se_weight(se);
 			sa->util_avg /= (cfs_rq->avg.load_avg + 1);
 
 			if (sa->util_avg > cap)
-- 
2.40.1


