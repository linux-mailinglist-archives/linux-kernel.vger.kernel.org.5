Return-Path: <linux-kernel+bounces-134355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA7189B09C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 089D1B21704
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728D020DCB;
	Sun,  7 Apr 2024 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mr7M1T8s"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A13814A82;
	Sun,  7 Apr 2024 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712489247; cv=none; b=ESfe7OPxgRJobe6u/4d8ucEonds8UWNx+5YtyxrE1TZSmCYA0FVy7FBlL/bGmDh70407Q8lsFvlfqagMgxVJdTfb81a0Eb3MQEuEOQ3wZgzFh9ECblTjn7F4F4kM6lwtZSIKx0mE7iYeRZ8lqTkjcCbXy3Mxzs5D+THY09BcYj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712489247; c=relaxed/simple;
	bh=mPjOByGRdi9tYDvVfm20AWGDd+BjqGuOOOEihcaV7PA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=pK8X3XDXQ8+kh6QjB2/E4K4eGWm64X6291kPDiAPv5NkhqbeX4NXmrhErcB8/UNbOr87uV9n1DnwPVA5dOvhB0xCEJQ7rSMpbLa8pjp1EjaVwWfQkqz4xr5lozW3A5TUKQYsDSiw8Gkmf591+2z9CIA8bxQb1HdZVZ3gXy/d1mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mr7M1T8s; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5aa17c29ba0so610343eaf.3;
        Sun, 07 Apr 2024 04:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712489245; x=1713094045; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlkcO0tcpZOYyrbltcj7aRutmJ90AlpBlkqeAVYv7Po=;
        b=Mr7M1T8sTlZATXFKEuauLUSDKEHObxsjHSyNUbeyYuPnyZ+wBv6T/Xt6FqQKdo8Xcp
         52W5113AutPgKeWHaUypEmKOznRybvFd9tVtLc9Bfa/hv6830/SUVikhNkHGBCG9VzSO
         agWAG3pO3RsRqEKTc4hcwfawmTpPUhJQh6w4aHwO1BRdrhnB1ZOhJz0j9qkAOCzzm8pN
         STdfUEwdF6hS8T8ay2WWXSFTWjVQx7pOiRfQ7cQ5BAvgkfndRgy+p0DdVv1vquE5lfo0
         63GJ0x+5+/3ABNDkF8//4STCANGdGoxsZONCVaQ25dqa09BWlDBym53JIrXqKC/qj5mp
         xvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712489245; x=1713094045;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlkcO0tcpZOYyrbltcj7aRutmJ90AlpBlkqeAVYv7Po=;
        b=ekYZV0YefPb2mNKJYTKHtu7jItlQX2yJ6GGuVlly9OIgJVeGRv0h9FYiKhE85LFsnV
         RoRLl8dbK3DqYG5ylrD8C/kRL9pFEjVaZZ7aGr4Up3R1roUVp0usU/ygUy2h3OfxUT0T
         LZcMuuRIEry08kQ8jn2S8lPBbKlQYAlCUqPiERkKW7VsEJgyacqp8tkQtpI18BWL390o
         EUt0eWbB6HZ4Q760AXvh6vWtZLoryRG0AGg3dZrIgpSec7Y7oub8CQ5IVqXgEdxFnPak
         WVdYtMfSiQ8V4ZXQMcer839U9JSgfWd6PmkE0/OxEZ3NQ6ktu8DL4hG2VmgN+3B7NQoT
         We6w==
X-Forwarded-Encrypted: i=1; AJvYcCVd+4lJWqh5JPol2W8lnbU8IE2Ycyu3ivasSu1vQwllVEf4soBVtBTgK14xwGWZpZ6nEnzWI+0Fw+zNhT29Nd7lLw4jDrXG0j5HZe0DCGge9nuVwdKBeRj284C1BgiiO4SF
X-Gm-Message-State: AOJu0YzhWKIPZaarB21pgcxhJXFVJmRk6qsmx5SmMkiCA6qdgYkKwkIL
	327WJf44KESt1AQTYQKK3zCcnAyGVwrZIKnHVrrzdkwqPS55E0RW
X-Google-Smtp-Source: AGHT+IHb4DOS0Opv4WTmm45i3ajFrJNhmIpL+o4BTFEcJ0nvcu+ikSNaPDNprd24dAJgw0M5EJz7wg==
X-Received: by 2002:a05:6359:5148:b0:17f:5797:b0ee with SMTP id oc8-20020a056359514800b0017f5797b0eemr7252910rwb.10.1712489245159;
        Sun, 07 Apr 2024 04:27:25 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id z187-20020a6333c4000000b005e438ea2a5asm4411336pgz.53.2024.04.07.04.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 04:27:24 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org
Cc: qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcutorture: Make rcutorture support srcu double call test
Date: Sun,  7 Apr 2024 19:27:14 +0800
Message-Id: <20240407112714.24460-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This commit also allows rcutorture to support srcu double call test
with CONFIG_DEBUG_OBJECTS_RCU_HEAD option enabled. the non-raw sdp
structure's->spinlock will be acquired in call_srcu(), in Preempt-RT
kernels, this spinlock is sleepable, therefore remove disable-irq and
disable-preempt protection.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/rcutorture.c | 46 +++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 807fbf6123a7..44cc455e1b61 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -390,6 +390,7 @@ struct rcu_torture_ops {
 	int extendables;
 	int slow_gps;
 	int no_pi_lock;
+	int debug_objects;
 	const char *name;
 };
 
@@ -577,6 +578,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.irq_capable		= 1,
 	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
 	.extendables		= RCUTORTURE_MAX_EXTEND,
+	.debug_objects		= 1,
 	.name			= "rcu"
 };
 
@@ -747,6 +749,7 @@ static struct rcu_torture_ops srcu_ops = {
 	.cbflood_max	= 50000,
 	.irq_capable	= 1,
 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
+	.debug_objects	= 1,
 	.name		= "srcu"
 };
 
@@ -786,6 +789,7 @@ static struct rcu_torture_ops srcud_ops = {
 	.cbflood_max	= 50000,
 	.irq_capable	= 1,
 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
+	.debug_objects	= 1,
 	.name		= "srcud"
 };
 
@@ -3455,7 +3459,6 @@ rcu_torture_cleanup(void)
 		cur_ops->gp_slow_unregister(NULL);
 }
 
-#ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
 static void rcu_torture_leak_cb(struct rcu_head *rhp)
 {
 }
@@ -3473,7 +3476,6 @@ static void rcu_torture_err_cb(struct rcu_head *rhp)
 	 */
 	pr_alert("%s: duplicated callback was invoked.\n", KBUILD_MODNAME);
 }
-#endif /* #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
 
 /*
  * Verify that double-free causes debug-objects to complain, but only
@@ -3482,39 +3484,43 @@ static void rcu_torture_err_cb(struct rcu_head *rhp)
  */
 static void rcu_test_debug_objects(void)
 {
-#ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
 	struct rcu_head rh1;
 	struct rcu_head rh2;
+	int idx;
+
+	if (!IS_ENABLED(CONFIG_DEBUG_OBJECTS_RCU_HEAD)) {
+		pr_alert("%s: !CONFIG_DEBUG_OBJECTS_RCU_HEAD, not testing duplicate call_%s()\n",
+					KBUILD_MODNAME, cur_ops->name);
+		return;
+	}
+
+	if (WARN_ON_ONCE(cur_ops->debug_objects &&
+			(!cur_ops->call || !cur_ops->cb_barrier)))
+		return;
+
 	struct rcu_head *rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
 
 	init_rcu_head_on_stack(&rh1);
 	init_rcu_head_on_stack(&rh2);
-	pr_alert("%s: WARN: Duplicate call_rcu() test starting.\n", KBUILD_MODNAME);
+	pr_alert("%s: WARN: Duplicate call_%s() test starting.\n", KBUILD_MODNAME, cur_ops->name);
 
 	/* Try to queue the rh2 pair of callbacks for the same grace period. */
-	preempt_disable(); /* Prevent preemption from interrupting test. */
-	rcu_read_lock(); /* Make it impossible to finish a grace period. */
-	call_rcu_hurry(&rh1, rcu_torture_leak_cb); /* Start grace period. */
-	local_irq_disable(); /* Make it harder to start a new grace period. */
-	call_rcu_hurry(&rh2, rcu_torture_leak_cb);
-	call_rcu_hurry(&rh2, rcu_torture_err_cb); /* Duplicate callback. */
+	idx = cur_ops->readlock(); /* Make it impossible to finish a grace period. */
+	cur_ops->call(&rh1, rcu_torture_leak_cb); /* Start grace period. */
+	cur_ops->call(&rh2, rcu_torture_leak_cb);
+	cur_ops->call(&rh2, rcu_torture_err_cb); /* Duplicate callback. */
 	if (rhp) {
-		call_rcu_hurry(rhp, rcu_torture_leak_cb);
-		call_rcu_hurry(rhp, rcu_torture_err_cb); /* Another duplicate callback. */
+		cur_ops->call(rhp, rcu_torture_leak_cb);
+		cur_ops->call(rhp, rcu_torture_err_cb); /* Another duplicate callback. */
 	}
-	local_irq_enable();
-	rcu_read_unlock();
-	preempt_enable();
+	cur_ops->readunlock(idx);
 
 	/* Wait for them all to get done so we can safely return. */
-	rcu_barrier();
-	pr_alert("%s: WARN: Duplicate call_rcu() test complete.\n", KBUILD_MODNAME);
+	cur_ops->cb_barrier();
+	pr_alert("%s: WARN: Duplicate call_%s() test complete.\n", KBUILD_MODNAME, cur_ops->name);
 	destroy_rcu_head_on_stack(&rh1);
 	destroy_rcu_head_on_stack(&rh2);
 	kfree(rhp);
-#else /* #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
-	pr_alert("%s: !CONFIG_DEBUG_OBJECTS_RCU_HEAD, not testing duplicate call_rcu()\n", KBUILD_MODNAME);
-#endif /* #else #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
 }
 
 static void rcutorture_sync(void)
-- 
2.17.1


