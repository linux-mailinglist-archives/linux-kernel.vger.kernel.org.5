Return-Path: <linux-kernel+bounces-116671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD9088A250
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912912C6FE8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EA81B251D;
	Mon, 25 Mar 2024 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhrMsC80"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69529130AC7;
	Mon, 25 Mar 2024 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711353153; cv=none; b=TwFgFPsIaCk3FGOdRHNquyXGvvX5sSgrNIZaTFjVzO6JA9rY6QMg9icLyJu1TIFWiF13SvM8iIag7+wFPJ8CCNnBVYIJQ/T8vAcWf6aAyHJhMB0KIzyreNL0cxUZ1i+JMONP1iC3c9AjD740TTZ2xx9E6EkZJkLL/WWRqRK1EU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711353153; c=relaxed/simple;
	bh=MjfyfYcCyYAjuQHZD8oyWbkpOeFBIPh/wGU9UVWSSSU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=pMtsOGfaV/0IoJa3hxuuV2xGcwSdskNH1FWgRCCjTt97MxZg0+5Hsou7NVfq0QOMBzDwnq01/wVDmbOqGkVPLmAMepKHZ+RZ1hgn2nQUy4u6/hAkFVqMJYAVoFjvsdJg7zsrAEHFvQRyETcIeg6Cg0lJq5znMBjKO65rEwAGNxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhrMsC80; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e6c0098328so2618054b3a.3;
        Mon, 25 Mar 2024 00:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711353150; x=1711957950; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6D18ET4Nwdf+JrfEWu/83Vhj2wPqTp5eZxfyge+5nI=;
        b=bhrMsC80LZJoQ4cJxUkFiYIVczrhZPPm64c9b8pWJ74J5dgrmiw4yP57WTDUb8fGnM
         aNJ2CuObJSwqIujUWHopLLU+S8Yt6ND3nR0rS+0kiLohEBOpIt4IUaIiUyUk2QQnUXup
         Tn8vN4mTCovoRjFdKF1W1m6niLKYdFFnfX5o3TB25naPW8kDZakyeLPGlb/uVFS962rK
         V4ggbvj6pzhp6ihuxPgyFr5+AlVVUkud2Zddnr13mXIVnLXuqt89vnas2igjgLdZTDp/
         Z4+JYZ0yrF2G1vXKM6sq8S0C8WpKDGbB3X8thc5CR/UIkLnQn78A+7OLbRgSNn6jhRgb
         +USw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711353150; x=1711957950;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6D18ET4Nwdf+JrfEWu/83Vhj2wPqTp5eZxfyge+5nI=;
        b=Q3AwGBT7Oc0biCcR1YF0ugw/pw1L1ei07ysHCYRetXb3XYRUzXth7enMUuAIFlbyuv
         Wc1qGsgquuZqNpuJbQkYRYV/Rq3yRXFUIGi6o4pR6dZQh7p4+ghUSNEiletp42WHm8ne
         7WojlCjlO3EyLaJvxCrS1RX9WEUCb/YRLQkm5cBSpMDcTA5Gpl0njPzAqXj6fTutAWY3
         bCdtgFg6KOYU5i4ghx+1A5bbu35pkNSljS7yRLMlbpy4H6bswmNYEZjEC7PoR898Pn9u
         pCu5x/ledqhCkkIOqOTjzB8HT9V890iXb/T0joYm0g1hnx8xZBaP4jWgQGzpEeo10/u5
         kBUw==
X-Forwarded-Encrypted: i=1; AJvYcCWPvB18JmXCpCPYhhH6W9yJvxwyzMW5AMfFV4wLDs0D+QPVq2anOby1D43QWrjcqokEHnfMciAdcckvtiTdU04KPd3jp7JK5G8SCecnnJvm+WW+08C+HfCcU4Ce+Oe0URfH
X-Gm-Message-State: AOJu0Yy+Ag4MnOLJhpWeFS7CgZj5DkQJGA6JbUHuOFGXu5jaHuhB8kwI
	E/XUVFsy4LBUs4+HImdSYBVBn5sI/T/8GmttySh8qO3jTLt08l9kupVhOy7W
X-Google-Smtp-Source: AGHT+IF3CJotqbKpv4V45t7yaKnAUbuI7CPEEOrIddzTOvsHsmn6aa6uT1AdE2lxHos93bCSZOie4A==
X-Received: by 2002:a05:6a20:da85:b0:1a3:b625:7b0f with SMTP id iy5-20020a056a20da8500b001a3b6257b0fmr4621590pzb.57.1711353150456;
        Mon, 25 Mar 2024 00:52:30 -0700 (PDT)
Received: from localhost.localdomain ([120.244.140.47])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090ae00200b0029c693a1e6dsm6032550pjy.17.2024.03.25.00.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 00:52:30 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org
Cc: qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcutorture: Fix invalid context warning when enable srcu barrier testing
Date: Mon, 25 Mar 2024 15:52:19 +0800
Message-Id: <20240325075219.10367-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

When the torture_type is set srcu or srcud and cb_barrier is
non-zero, running the rcutorture test will trigger the
following warning:

[  163.910989][    C1] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[  163.910994][    C1] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
[  163.910999][    C1] preempt_count: 10001, expected: 0
[  163.911002][    C1] RCU nest depth: 0, expected: 0
[  163.911005][    C1] INFO: lockdep is turned off.
[  163.911007][    C1] irq event stamp: 30964
[  163.911010][    C1] hardirqs last  enabled at (30963): [<ffffffffabc7df52>] do_idle+0x362/0x500
[  163.911018][    C1] hardirqs last disabled at (30964): [<ffffffffae616eff>] sysvec_call_function_single+0xf/0xd0
[  163.911025][    C1] softirqs last  enabled at (0): [<ffffffffabb6475f>] copy_process+0x16ff/0x6580
[  163.911033][    C1] softirqs last disabled at (0): [<0000000000000000>] 0x0
[  163.911038][    C1] Preemption disabled at:
[  163.911039][    C1] [<ffffffffacf1964b>] stack_depot_save_flags+0x24b/0x6c0
[  163.911063][    C1] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W          6.8.0-rc4-rt4-yocto-preempt-rt+ #3 1e39aa9a737dd024a3275c4f835a872f673a7d3a
[  163.911071][    C1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[  163.911075][    C1] Call Trace:
[  163.911078][    C1]  <IRQ>
[  163.911080][    C1]  dump_stack_lvl+0x88/0xd0
[  163.911089][    C1]  dump_stack+0x10/0x20
[  163.911095][    C1]  __might_resched+0x36f/0x530
[  163.911105][    C1]  rt_spin_lock+0x82/0x1c0
[  163.911112][    C1]  spin_lock_irqsave_ssp_contention+0xb8/0x100
[  163.911121][    C1]  srcu_gp_start_if_needed+0x782/0xf00
[  163.911128][    C1]  ? _raw_spin_unlock_irqrestore+0x46/0x70
[  163.911136][    C1]  ? debug_object_active_state+0x336/0x470
[  163.911148][    C1]  ? __pfx_srcu_gp_start_if_needed+0x10/0x10
[  163.911156][    C1]  ? __pfx_lock_release+0x10/0x10
[  163.911165][    C1]  ? __pfx_rcu_torture_barrier_cbf+0x10/0x10
[  163.911188][    C1]  __call_srcu+0x9f/0xe0
[  163.911196][    C1]  call_srcu+0x13/0x20
[  163.911201][    C1]  srcu_torture_call+0x1b/0x30
[  163.911224][    C1]  rcu_torture_barrier1cb+0x4a/0x60
[  163.911247][    C1]  __flush_smp_call_function_queue+0x267/0xca0
[  163.911256][    C1]  ? __pfx_rcu_torture_barrier1cb+0x10/0x10
[  163.911281][    C1]  generic_smp_call_function_single_interrupt+0x13/0x20
[  163.911288][    C1]  __sysvec_call_function_single+0x7d/0x280
[  163.911295][    C1]  sysvec_call_function_single+0x93/0xd0
[  163.911302][    C1]  </IRQ>
[  163.911304][    C1]  <TASK>
[  163.911308][    C1]  asm_sysvec_call_function_single+0x1b/0x20
[  163.911313][    C1] RIP: 0010:default_idle+0x17/0x20
[  163.911326][    C1] RSP: 0018:ffff888001997dc8 EFLAGS: 00000246
[  163.911333][    C1] RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffffae618b51
[  163.911337][    C1] RDX: 0000000000000000 RSI: ffffffffaea80920 RDI: ffffffffaec2de80
[  163.911342][    C1] RBP: ffff888001997dc8 R08: 0000000000000001 R09: ffffed100d740cad
[  163.911346][    C1] R10: ffffed100d740cac R11: ffff88806ba06563 R12: 0000000000000001
[  163.911350][    C1] R13: ffffffffafe460c0 R14: ffffffffafe460c0 R15: 0000000000000000
[  163.911358][    C1]  ? ct_kernel_exit.constprop.3+0x121/0x160
[  163.911369][    C1]  ? lockdep_hardirqs_on+0xc4/0x150
[  163.911376][    C1]  arch_cpu_idle+0x9/0x10
[  163.911383][    C1]  default_idle_call+0x7a/0xb0
[  163.911390][    C1]  do_idle+0x362/0x500
[  163.911398][    C1]  ? __pfx_do_idle+0x10/0x10
[  163.911404][    C1]  ? complete_with_flags+0x8b/0xb0
[  163.911416][    C1]  cpu_startup_entry+0x58/0x70
[  163.911423][    C1]  start_secondary+0x221/0x280
[  163.911430][    C1]  ? __pfx_start_secondary+0x10/0x10
[  163.911440][    C1]  secondary_startup_64_no_verify+0x17f/0x18b
[  163.911455][    C1]  </TASK>

This commit therefore use smp_call_on_cpu() instead of
smp_call_function_single(), make rcu_torture_barrier1cb() invoked
happens on task-context.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/rcutorture.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 48a9d47ec90e..498aae52333e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3041,11 +3041,12 @@ static void rcu_torture_barrier_cbf(struct rcu_head *rcu)
 }
 
 /* IPI handler to get callback posted on desired CPU, if online. */
-static void rcu_torture_barrier1cb(void *rcu_void)
+static int rcu_torture_barrier1cb(void *rcu_void)
 {
 	struct rcu_head *rhp = rcu_void;
 
 	cur_ops->call(rhp, rcu_torture_barrier_cbf);
+	return 0;
 }
 
 /* kthread function to register callbacks used to test RCU barriers. */
@@ -3071,11 +3072,9 @@ static int rcu_torture_barrier_cbs(void *arg)
 		 * The above smp_load_acquire() ensures barrier_phase load
 		 * is ordered before the following ->call().
 		 */
-		if (smp_call_function_single(myid, rcu_torture_barrier1cb,
-					     &rcu, 1)) {
-			// IPI failed, so use direct call from current CPU.
+		if (smp_call_on_cpu(myid, rcu_torture_barrier1cb, &rcu, 1))
 			cur_ops->call(&rcu, rcu_torture_barrier_cbf);
-		}
+
 		if (atomic_dec_and_test(&barrier_cbs_count))
 			wake_up(&barrier_wq);
 	} while (!torture_must_stop());
-- 
2.17.1


