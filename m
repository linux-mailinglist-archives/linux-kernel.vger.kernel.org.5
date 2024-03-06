Return-Path: <linux-kernel+bounces-94657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 836AC8742C5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385492863EA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E971BC53;
	Wed,  6 Mar 2024 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpEUo+41"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6DA14276
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709764179; cv=none; b=d+cWew4j2OcNXvU34uZfJaoGl0m7Ie4Hppfwsng4cLapT0SlBsfPqY/9tXVMG3G0uHAy1WsuFB0/4JdYMXwK5+ZLN5xZWxWLj4SvLzfRA5hpNG5TL/Ea2+plRQjxvHMBeciU41vtRu9amkKjC/D5dfUNG/lNXbWcNIZRMW4/px4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709764179; c=relaxed/simple;
	bh=nfP4HpGNkJV7s1vErNFkemgrvK2LJnhE+5pQrmQiQyg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AXB+JgNAKIumYwiHY6E8A7E0u3PYIligotCEimrv+KNUxpoTgGpIXP7wSyXFFx+PrQNc8AVYNx/D5s8DESLhyiCNREsAFQ5dyeOh4aDpnUuKNUaV7YrRxUgJRx/eySKZ9KEB+KpX/11TysV3/3jEzaUxhq1QLL+rSmz3gxNn8K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpEUo+41; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc49afb495so2002885ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 14:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709764177; x=1710368977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EjBcB2hHrnmuukqTrYM7z9KDV2woHsk649HcWXaHWDc=;
        b=QpEUo+41fswfZtIq/+B8vog8MNXUjWBtw5IFtWDX83iMJgQNn5g+jkFUu9i0FW96pf
         uiD0458cjw6wuJX7tLbtgBBaZenF7O9+ylbuCSV6PDSIoflBEtqrh6Z+37T8WUPRe/K/
         IuZ+2DhYDsiH0VnM5ArnDC839pI1wTEuNgEuDH3wvZp/longRDcZV0EKX5AENHmdwcyB
         9RYuSoKbYQgPl/SSTKc0uI1mdblJaYjutgTzQQQdkI2cGVZgfDyT8nmH1sUSYbh4CvqP
         K+Os/yG9uhQn1jhsRIGbYErpaSBBPe0TCle0pjhvY086QKIfsXxThTPGr99Serc83zLo
         TN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709764177; x=1710368977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjBcB2hHrnmuukqTrYM7z9KDV2woHsk649HcWXaHWDc=;
        b=cvOYqLVtyMWfvpZqrqg7CgmTb1NUKD3vKr/JnR+R8s5qw7N+859wuFWkrWaujg8YHF
         Q+w2FZXi4Cgjc8lGfT9r4hnY2/mxbFR92vfGmZsT67cmIbzlHBf6y3rwWTHvmC88FB24
         ILcSFe8YmAuLVR1dIu46q81QCg0LDEv/iJA0CDBzuy7lBf/4mIX+yqWJ2b+VMOGNtp+s
         f2YfRwrOKL5KEE+C/+9Ldg9UiYmegjGvRxJznI1oUA5gdQLSgDZrtorxDeqaRFanP8k3
         EUbF+KICJ7qinmEpSTjayioSEwbR4M8PgsPxzgvl2YcmeMiygPOFlrJJgtvkhjCOFOBb
         U55w==
X-Forwarded-Encrypted: i=1; AJvYcCVEZyF+noow8+h4KK2SMd3RmzdttIsHcyY9mqPyZNM+k3JaxWlJLbw4V7Vq/l7hIjOB3IdPCTh+7Hv5rctTBFr8yUGD2K/DAY4FKt70
X-Gm-Message-State: AOJu0Yz39tGdBuyGDMtWyS2opu9412jaNRkGOgKz4zzcpuqPXaDwAw92
	rZ15BpQvJcQE6q1xooK4yVAK06D34p8xwqqkPPcFLv49lvNAbos0x8+++zm1kuPjWA==
X-Google-Smtp-Source: AGHT+IEECA8/AoDfWJ9atsGYh8CUiK9veuYUQbr58TU0uhFzyPCecFdebD2QSBteJAqjXWw0EJpqGg==
X-Received: by 2002:a17:903:1c4:b0:1dc:1379:213b with SMTP id e4-20020a17090301c400b001dc1379213bmr8997275plh.35.1709764176693;
        Wed, 06 Mar 2024 14:29:36 -0800 (PST)
Received: from ub23 (c-24-16-118-101.hsd1.wa.comcast.net. [24.16.118.101])
        by smtp.gmail.com with ESMTPSA id i9-20020a170902c94900b001dcc09487e8sm13114357pla.50.2024.03.06.14.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 14:29:36 -0800 (PST)
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
Subject: [PATCH] sched/fair: simplify __calc_delta()
Date: Wed,  6 Mar 2024 14:28:37 -0800
Message-Id: <20240306222838.15087-1-daweilics@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on how __calc_delta() is called now, the input parameter, weight
is always NICE_0_LOAD. I think we don't need it as an input parameter
now?

Also, when weight is always NICE_0_LOAD, the initial fact value is
always 2^10, and the first fact_hi will always be 0. Thus, we can get
rid of the first if bock.

The previous comment "(delta_exec * (weight * lw->inv_weight)) >>
WMULT_SHIFT" seems to be assuming that lw->weight * lw->inv_weight is
always (approximately) equal to 2^WMULT_SHIFT. However, when
CONFIG_64BIT is set, lw->weight * lw->inv_weight is (approximately)
equal to 2^WMULT_SHIFT * 2^10. What remains true for both CONFIG_32BIT
and CONFIG_64BIT is: scale_load_down(lw->weight) * lw->inv_weight is
(approximately) equal to 2^WMULT_SHIFT. (Correct me if I am wrong.)

Also updated the comment for calc_delta_fair() to make it more
accurate.

Signed-off-by: Dawei Li <daweilics@gmail.com>
---
 kernel/sched/fair.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6a16129f9a5c..c5cdb15f7d62 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -252,32 +252,23 @@ static void __update_inv_weight(struct load_weight *lw)
 }
 
 /*
- * delta_exec * weight / lw.weight
+ * delta_exec * NICE_0_LOAD / lw->weight
  *   OR
- * (delta_exec * (weight * lw->inv_weight)) >> WMULT_SHIFT
+ * (delta_exec * scale_load_down(NICE_0_LOAD) * lw->inv_weight) >> WMULT_SHIFT
  *
- * Either weight := NICE_0_LOAD and lw \e sched_prio_to_wmult[], in which case
- * we're guaranteed shift stays positive because inv_weight is guaranteed to
- * fit 32 bits, and NICE_0_LOAD gives another 10 bits; therefore shift >= 22.
- *
- * Or, weight =< lw.weight (because lw.weight is the runqueue weight), thus
- * weight/lw.weight <= 1, and therefore our shift will also be positive.
+ * We're guaranteed shift stays positive because inv_weight is guaranteed to
+ * fit 32 bits, and scale_load_down(NICE_0_LOAD) gives another 10 bits;
+ * therefore shift >= 22.
  */
-static u64 __calc_delta(u64 delta_exec, unsigned long weight, struct load_weight *lw)
+static u64 __calc_delta(u64 delta_exec, struct load_weight *lw)
 {
-	u64 fact = scale_load_down(weight);
-	u32 fact_hi = (u32)(fact >> 32);
+	u64 fact = scale_load_down(NICE_0_LOAD);
+	int fact_hi;
 	int shift = WMULT_SHIFT;
 	int fs;
 
 	__update_inv_weight(lw);
 
-	if (unlikely(fact_hi)) {
-		fs = fls(fact_hi);
-		shift -= fs;
-		fact >>= fs;
-	}
-
 	fact = mul_u32_u32(fact, lw->inv_weight);
 
 	fact_hi = (u32)(fact >> 32);
@@ -291,12 +282,12 @@ static u64 __calc_delta(u64 delta_exec, unsigned long weight, struct load_weight
 }
 
 /*
- * delta /= w
+ * delta *= NICE_0_LOAD / se->load.weight
  */
 static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
 {
 	if (unlikely(se->load.weight != NICE_0_LOAD))
-		delta = __calc_delta(delta, NICE_0_LOAD, &se->load);
+		delta = __calc_delta(delta, &se->load);
 
 	return delta;
 }
-- 
2.40.1


