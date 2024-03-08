Return-Path: <linux-kernel+bounces-96918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C951B876311
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F24A282B19
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057135D905;
	Fri,  8 Mar 2024 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVZP88vr"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694A95B5C1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896726; cv=none; b=g4K022Tj5smcMNWe+LEITupuBXTS743/ecuBmXhQ6mfdwTanQcJOL/FY0JjomaulDEJwota/GKeYLduBMjxsVTn2C/2+erygRJgJAVcgIpnJZl/k8JWuidkKYvOoXvaT43zu5JG6jvhPVi/nFNv+wvEbUmN0D1AWqE/4kF6jV24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896726; c=relaxed/simple;
	bh=NedhpULzZYZ8ME39VE5CA7FZTCBqwKEANbkZH0WTMm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FFRSHuVHiBRjOfeDZqU7Jq12KIbOBmbfPgZMSFRvLizbucC0UEq9wD2AVMrLDnhljVIL+Q5Vt+unAavLxiQmi009CUDY9Qpm/FE6y5ifrgmaqEXgYi7riisG53x9eVf6UzmpSJD/BqRuT2ir1GTFh42I98LwAH5mMECylHteQ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVZP88vr; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33e742ca96bso845929f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 03:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709896723; x=1710501523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwlzocWJiHgoQscu/IevEQ9ciKsE6ki7xCF7izVWXbo=;
        b=KVZP88vrlEQPp2sORyjXtpoxv3vPAYVT/XTUBbtV47ovwTp0YHqdpgLrGhUlg82eD7
         PFP6zQGcv5CzFtWNJqskL1nTWZHfro6TGGx1MYNfFxKF8DLq3Ha3v9ELtEMB4LXiQN09
         t7Xqyfpo577eridg4OyzsNBjtC1wzLDGHEy9Bg9ky2c6DlCEk1/CEU7bk9QVnrJZUn6y
         51tLNTeLGKICSuX+9vD3ol7Ms5VdgcexpqTjphvlF+joYiBXG0sJZFzMVQXvGJOQQ98O
         gy5PkiFpCFdeXGwdH2Oj1oTOsvCay1aW7z5DbKPrnCjpoYG3lkBghRbk/Z0wniBVdGw8
         CrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709896723; x=1710501523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uwlzocWJiHgoQscu/IevEQ9ciKsE6ki7xCF7izVWXbo=;
        b=qrlai4TYN5zfoRudywvKyStR6QVybprfqnlxDv92+DqV6NntLPa5TRG5uB0kGQ09f5
         4Fv5AVhAvCLLRoT8d2SucJQMAN0r8YyvgOVlEikiiV7IluOeuRxoWeD1IuqmF4LmqD+E
         kzC5kA5kdrtRvqVAi0Mcoz7PPaE7uEa5n9ktji41M4K7N2TCivXb/XaGR7GgR2IY9BCi
         UeiTKOlnyyTcJdCwUTtRKNI1L6xl71RHlnx+QNRU9VY12CXf/4ge24q+aopsqdnEM1El
         M1pB3Ds6fW2KkymnAgatskXi0ImFXRa/zTNaVLv0RY+TTlZlZAgp8DJ9pBqdN3thOrRf
         2wpQ==
X-Gm-Message-State: AOJu0YzXyBTS+CwYPwXRTzDBKGMQ0ZROzM37bZsDBXiqXD4eCJX9R9ik
	O76dFtdhLMTUlvn0FDGNZc2zRLw0cBb1sFnWokcOpmv1oInMYiJaYJpNpX86kwo=
X-Google-Smtp-Source: AGHT+IGo7P28Gp2ufYx6Crbr7Ra3EzTo31RpNymsqZjiR16YHYN//fNVyrBJeMMOL9iDk6VqD2zWrQ==
X-Received: by 2002:adf:cc06:0:b0:33e:6ac:691b with SMTP id x6-20020adfcc06000000b0033e06ac691bmr15139647wrh.9.1709896722553;
        Fri, 08 Mar 2024 03:18:42 -0800 (PST)
Received: from kepler.redhat.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id v9-20020adfedc9000000b0033e712b1d9bsm2523884wro.77.2024.03.08.03.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:18:42 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 10/13] sched/balancing: Rename newidle_balance() => sched_balance_newidle()
Date: Fri,  8 Mar 2024 12:18:16 +0100
Message-Id: <20240308111819.1101550-11-mingo@kernel.org>
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

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 95f7092043f3..aa5ff0efcca8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4816,7 +4816,7 @@ static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq)
 	return cfs_rq->avg.load_avg;
 }
 
-static int newidle_balance(struct rq *this_rq, struct rq_flags *rf);
+static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf);
 
 static inline unsigned long task_util(struct task_struct *p)
 {
@@ -5136,7 +5136,7 @@ attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 static inline void
 detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 
-static inline int newidle_balance(struct rq *rq, struct rq_flags *rf)
+static inline int sched_balance_newidle(struct rq *rq, struct rq_flags *rf)
 {
 	return 0;
 }
@@ -8253,7 +8253,7 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	if (rq->nr_running)
 		return 1;
 
-	return newidle_balance(rq, rf) != 0;
+	return sched_balance_newidle(rq, rf) != 0;
 }
 #endif /* CONFIG_SMP */
 
@@ -8505,10 +8505,10 @@ done: __maybe_unused;
 	if (!rf)
 		return NULL;
 
-	new_tasks = newidle_balance(rq, rf);
+	new_tasks = sched_balance_newidle(rq, rf);
 
 	/*
-	 * Because newidle_balance() releases (and re-acquires) rq->lock, it is
+	 * Because sched_balance_newidle() releases (and re-acquires) rq->lock, it is
 	 * possible for any higher priority task to appear. In that case we
 	 * must re-start the pick_next_entity() loop.
 	 */
@@ -11493,7 +11493,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 	ld_moved = 0;
 
 	/*
-	 * newidle_balance() disregards balance intervals, so we could
+	 * sched_balance_newidle() disregards balance intervals, so we could
 	 * repeatedly reach this code, which would lead to balance_interval
 	 * skyrocketing in a short amount of time. Skip the balance_interval
 	 * increase logic to avoid that.
@@ -12277,7 +12277,7 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
 #endif /* CONFIG_NO_HZ_COMMON */
 
 /*
- * newidle_balance is called by schedule() if this_cpu is about to become
+ * sched_balance_newidle is called by schedule() if this_cpu is about to become
  * idle. Attempts to pull tasks from other CPUs.
  *
  * Returns:
@@ -12285,7 +12285,7 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
  *     0 - failed, no new tasks
  *   > 0 - success, new (fair) tasks present
  */
-static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
+static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 {
 	unsigned long next_balance = jiffies + HZ;
 	int this_cpu = this_rq->cpu;
-- 
2.40.1


