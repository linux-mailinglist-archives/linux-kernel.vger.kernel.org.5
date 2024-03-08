Return-Path: <linux-kernel+bounces-96919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CA2876312
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772041F21997
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EF25E070;
	Fri,  8 Mar 2024 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3Re3A8A"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CE45CDC9
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896727; cv=none; b=fZnMBwucGD+phhab3zPL3WmDJ1gj+Ip78FEahNS0DCcYvjzgwKwsVdj8k7TtpxaeO26zDVQEGmAdNp1hoP5p86uWFCa3bW/E+yKHkOUzLOYLL2FUumzvxHsJWJKqu7NZDT1wGur73xQHk8enc2e0sSROwzEzZkdUF9zMVAp4OhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896727; c=relaxed/simple;
	bh=nFc6H2LARbAQKvySIdNn59YzkG9s6blD8CUVxFU9/GY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cSRz1TNzGHjZOftuDFn0S2Je+6uWhU5KfwTtRRSU5iE1u2sC5aLTAxbvIIQrelMRUMjR8OiDAU6TPwNdTxyhJb2tds+Nag0ZqK9swTJvCTcv1mDU7e5cgh5IglnOS48SXkzx0oJfyBMjIbSgSXRLLxkoKIPda/Sxa6gIgai75Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3Re3A8A; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33e285a33bdso1105740f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 03:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709896724; x=1710501524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9br3RKNBjSYu+KVu9Dy6exTj0eK3ABqPcmihkUiY/s=;
        b=Q3Re3A8AU6orRCQOTAIyIM7jDklw3lrI58pZ5PR4NcuTF/RUOEm5YkKtXejlM8r+/P
         d6LBJqSU07W37Cz/2cSkm206Ogz558kLbZp8A/EOORgMmlzAh/jZqCGqUVl25VT7zOop
         r42uaZriUyxY0tqg/LuN3awHqLYrH8J/g7rVv5OJYaSTo7Sv4oIdDCFLnclkpsZQWQfG
         AELkVmediC+wQoND1x2t5+IY7Zu1BRsNlE64VVchEqg9QQpn/c87k3pvYy0LKvXJjwRn
         8f27TWp2xXvELH19SHNnUk+g0AQEHcxZ8lxrzboJk/4w935vwEmVsBsFhx4bX2iH+1dA
         /HuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709896724; x=1710501524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+9br3RKNBjSYu+KVu9Dy6exTj0eK3ABqPcmihkUiY/s=;
        b=BES0llpPFC4y22oBixU0AXjZiVWG/TfSORkD8+8iS59qxeW0RHdoP9uxfWDs6m9r4x
         x/GyC4KxH6p5nJwEk9anOi1Oj0u+ZXSgMhPYBgbXGmx85tocaX+64l1wFTHzmMLPMLGl
         uZvAEXWNv9vdr2YEhpDAbmPGFE2y6ENH5PUSXQFhROgEsuFvD6ehiIaKZkramYEuEHsq
         3uXwKDEnysZniWZHxb7SM00kyjmstLvlD9VPAvvv4RoX4LFQZyE5rGyfhTQ6eTfgNs2q
         hamybpCHktGCKiFnQTmf+p/3K9+HNPPi8LlDm4lSg/wIcf2TSbi7rl/BAPzpyZ7kR1sf
         R8zg==
X-Gm-Message-State: AOJu0Yx9eAxuf2bF58762xN9ceoF4bBOX58/pwvedo89KQKRKb1BFtkY
	DHGZpXICViJ+zCCvzPzla3pIFQcs1oY9HYZtN8tA/pqJW/J9FBw2k+vDj9pbaVs=
X-Google-Smtp-Source: AGHT+IGcF28p92A8DRlDGAVRCdFfvRrfDEBQssqa2PgWBghX4EByUoYPEF4vuErrTQidtPhoZS37LQ==
X-Received: by 2002:adf:9c92:0:b0:33e:1df1:b76d with SMTP id d18-20020adf9c92000000b0033e1df1b76dmr14697595wre.44.1709896723539;
        Fri, 08 Mar 2024 03:18:43 -0800 (PST)
Received: from kepler.redhat.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id v9-20020adfedc9000000b0033e712b1d9bsm2523884wro.77.2024.03.08.03.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:18:43 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 11/13] sched/balancing: Rename find_idlest_group_cpu() => sched_balance_find_dst_group_cpu()
Date: Fri,  8 Mar 2024 12:18:17 +0100
Message-Id: <20240308111819.1101550-12-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240308111819.1101550-1-mingo@kernel.org>
References: <20240308111819.1101550-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Standardize scheduler load-balancing function names on the
sched_balance_() prefix.

Also use 'dst' instead of 'idlest': while historically correct,
today it's not really true anymore that we return the 'idlest'
group or CPU, we sort by idle-exit latency and only return the
idlest CPUs from the lowest-latency set of CPUs.

The true 'idlest' CPUs often remain idle for a long time
and are never returned as long as the system is under-loaded.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aa5ff0efcca8..02ff0272b2e4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7101,10 +7101,10 @@ static struct sched_group *
 find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu);
 
 /*
- * find_idlest_group_cpu - find the idlest CPU among the CPUs in the group.
+ * sched_balance_find_dst_group_cpu - find the idlest CPU among the CPUs in the group.
  */
 static int
-find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this_cpu)
+sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *p, int this_cpu)
 {
 	unsigned long load, min_load = ULONG_MAX;
 	unsigned int min_exit_latency = UINT_MAX;
@@ -7191,7 +7191,7 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 			continue;
 		}
 
-		new_cpu = find_idlest_group_cpu(group, p, cpu);
+		new_cpu = sched_balance_find_dst_group_cpu(group, p, cpu);
 		if (new_cpu == cpu) {
 			/* Now try balancing at a lower domain level of 'cpu': */
 			sd = sd->child;
-- 
2.40.1


