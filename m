Return-Path: <linux-kernel+bounces-69642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4A6858CBB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8FB91C21721
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DBA1BDF4;
	Sat, 17 Feb 2024 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoWXBY72"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F93217745;
	Sat, 17 Feb 2024 01:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708133283; cv=none; b=J0pScchgqqM5G3gxZGBIJk6GrtCXzrq4dk+t/fthw5eR8oNWWblZBpIb4PdmmdnqghLY6epm5Z1hFLd/2a5585R+tJQxjpal+WHtK5UjszOGWULIG5RQ+LYpLo8nuiQQPRbcZtMmgv+rNr/d6nnJ0sfEcaZibS1RBHATqqxMnCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708133283; c=relaxed/simple;
	bh=T+CUzhbVEdJ9yuhSl92mWeUi9ua4EdFF8tCRqQ8HMkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0Bied3p/OZfueqLIBUVd+KWHpkDUKPcMnHxKs6BD+cu930RY3f8WFsEgTJgmWzKWZkecOzrvEoHnHPof5rBuTTwwz2m6PAAxSbS5TD0ZdgO+KfsDZT8LWMgGrc0fPB2U9n3Yemld3aiNlKV/7rtjbVYtZZ55UPqFAMfeG0a5z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoWXBY72; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6868823be58so5007756d6.0;
        Fri, 16 Feb 2024 17:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708133280; x=1708738080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iO0FGo+JHvvXIFJUwYJqm/v2xV/l0hzo3O16zP5UEz0=;
        b=VoWXBY72iTUwW5E9/gDaellDfrbbDTP0Wu8Upy2H3OPRSzdrpKMTjTZkVUcI8o8wXu
         dfrhnmtdllVNzP2UVTkrTfA45+DBxNJS/DAzByREtFSHCBtRY0ToCJabjr5OrmCCSIrL
         953lDekAyucvqe4SJ+IRh+GEjxFKbsfu3EkulYGa/QjHL2JTKf23gFdl6lm6Yc3WG8DS
         UiDe+nPGTqjJBaqjyE9Yo55GDCN4EotUV+XNUHmnCBsQiHv84PCN4rEVB83qjnw6R0NC
         Le9vc+P2kNLTn95/T3/4+dKSR/UK2+qbRkdGDuLz3x6z7IY2eu8NnrxFNB64I8ShilJF
         TvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708133280; x=1708738080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iO0FGo+JHvvXIFJUwYJqm/v2xV/l0hzo3O16zP5UEz0=;
        b=AxnUMla2alhS1FF+ubw9CYZlsY/cyaODm4jFdiEW65SrZGoqTkAkph9Tie7rMOkVga
         nrZwsmRZP3xmj4BOugA3orONCKmQ6xYaAD10cBajOAoVYXa8b/ei5yCwQvPf68WS0kg/
         r/QiYE3a6uZ1ezjabv0M4YWTEc3UyFLJ7IspzGg6nNikMfAKuIWm1zknEEn/SOirlM9v
         glhMRspBv0PQC/2NxzNa1LmNH0fKJFXm2zYm+81GFQ4ZOU9mjbOQMlWU9Mjh5eN57L++
         eFjA+uQfjGwfRLwQBQPhMT8YtoLvyrUtNs0hJhAodrNGFDnMY/02y5PbLV25rwKwH9wz
         XWPg==
X-Forwarded-Encrypted: i=1; AJvYcCU9N30kzAOX2QNNNJ0Uu/ThywrocX6uGrVXXrvxjxjOI+gFl9FApHhSka0aeQD8C/N+Q1rTPgJ/tLYMjWXjdCzeVPmg
X-Gm-Message-State: AOJu0Yw0yL4eCm3VvWBvRhSms0ySzNsSPyXRA9Uvf7llU+E5w61T3yAI
	zpQEO+Nb5+UnynnQM4axZ/nX/HwXNmZNWwmxE7VAU+z0O6onUBYI
X-Google-Smtp-Source: AGHT+IGC1GkSa+QVtwZVwm+spgZJJ5kmUO8WralKhawMtkJP6DDqbyFzgmrfIFMD2KQBToJtrOUnoQ==
X-Received: by 2002:a0c:e24b:0:b0:68c:a4a8:b134 with SMTP id x11-20020a0ce24b000000b0068ca4a8b134mr5789764qvl.45.1708133280142;
        Fri, 16 Feb 2024 17:28:00 -0800 (PST)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id er19-20020a056214191300b0068f304336f5sm487340qvb.36.2024.02.16.17.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 17:27:59 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id AC5FC1200064;
	Fri, 16 Feb 2024 20:27:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 16 Feb 2024 20:27:58 -0500
X-ME-Sender: <xms:nQvQZaockOGs-NGvei3TTXie90XDn8WnuTMg4ZYaas2WX4Xf1sWJbg>
    <xme:nQvQZYoMy6QUPwq8w1n05WeMsjTatYQ3BuvpLlv1YGL-oNAH5f3pCsfsZegPddgLC
    HOJTPh9BBLvFMv53Q>
X-ME-Received: <xmr:nQvQZfOqUMre4ReHkRC9ZbiT191Im1fRg78aP1oQ-qJE0i9JhBdnsuPYDgE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepgffhffevhffhvdfgjefgkedvlefgkeegveeuheelhfeivdegffejgfetuefg
    heeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:ngvQZZ6H1jQwY1AtSBKQv15OLNJcQmzeijtTCqhqLOE8j6CXynkLkA>
    <xmx:ngvQZZ52G4PQq3zVkJz6CCrDk1bWzr47ubl0P9EopwnEkt1VypvvLQ>
    <xmx:ngvQZZgR0l3MtiMvcks2vmxHg2xwX91wHapBYXvFm30z6GH-aTkVTg>
    <xmx:ngvQZYIJ02vc99gyAntu5dt0WRQDgapNctl0fn7sGAManFk23AnAIom-qJ0>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Feb 2024 20:27:57 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Boqun Feng <boqun.feng@gmail.com>,
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
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v2 2/6] rcu-tasks: Add data to eliminate RCU-tasks/do_exit() deadlocks
Date: Fri, 16 Feb 2024 17:27:37 -0800
Message-ID: <20240217012745.3446231-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217012745.3446231-1-boqun.feng@gmail.com>
References: <20240217012745.3446231-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Holding a mutex across synchronize_rcu_tasks() and acquiring
that same mutex in code called from do_exit() after its call to
exit_tasks_rcu_start() but before its call to exit_tasks_rcu_stop()
results in deadlock.  This is by design, because tasks that are far
enough into do_exit() are no longer present on the tasks list, making
it a bit difficult for RCU Tasks to find them, let alone wait on them
to do a voluntary context switch.  However, such deadlocks are becoming
more frequent.  In addition, lockdep currently does not detect such
deadlocks and they can be difficult to reproduce.

In addition, if a task voluntarily context switches during that time
(for example, if it blocks acquiring a mutex), then this task is in an
RCU Tasks quiescent state.  And with some adjustments, RCU Tasks could
just as well take advantage of that fact.

This commit therefore adds the data structures that will be needed
to rely on these quiescent states and to eliminate these deadlocks.

Link: https://lore.kernel.org/all/20240118021842.290665-1-chenzhongjin@huawei.com/

Reported-by: Chen Zhongjin <chenzhongjin@huawei.com>
Reported-by: Yang Jihong <yangjihong1@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Yang Jihong <yangjihong1@huawei.com>
Tested-by: Chen Zhongjin <chenzhongjin@huawei.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/sched.h | 2 ++
 kernel/rcu/tasks.h    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffe8f618ab86..5eeebed2dd9b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -858,6 +858,8 @@ struct task_struct {
 	u8				rcu_tasks_idx;
 	int				rcu_tasks_idle_cpu;
 	struct list_head		rcu_tasks_holdout_list;
+	int				rcu_tasks_exit_cpu;
+	struct list_head		rcu_tasks_exit_list;
 #endif /* #ifdef CONFIG_TASKS_RCU */
 
 #ifdef CONFIG_TASKS_TRACE_RCU
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 732ad5b39946..b7d5f2757053 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -32,6 +32,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @rtp_irq_work: IRQ work queue for deferred wakeups.
  * @barrier_q_head: RCU callback for barrier operation.
  * @rtp_blkd_tasks: List of tasks blocked as readers.
+ * @rtp_exit_list: List of tasks in the latter portion of do_exit().
  * @cpu: CPU number corresponding to this entry.
  * @rtpp: Pointer to the rcu_tasks structure.
  */
@@ -46,6 +47,7 @@ struct rcu_tasks_percpu {
 	struct irq_work rtp_irq_work;
 	struct rcu_head barrier_q_head;
 	struct list_head rtp_blkd_tasks;
+	struct list_head rtp_exit_list;
 	int cpu;
 	struct rcu_tasks *rtpp;
 };
-- 
2.43.0


