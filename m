Return-Path: <linux-kernel+bounces-69643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4D4858CBC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CF5F1F232CD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BECF1CAB1;
	Sat, 17 Feb 2024 01:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hl2soOzW"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EA11C2B2;
	Sat, 17 Feb 2024 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708133286; cv=none; b=bSs05HGZRnjViVIaoIkkl5AoEoJguRbI18nm1hdcSLuhZwjr8Lz3YZwePgAq00PQ11x0Qb14uTdj9/vow7Z9X8oo/LJedT0Mikxzm0Q8dCWX316ptXVKbgUwpa/joViqOtuJ0deQoM7iJ7gfx5sLBiCb6PvSCP4lnXQ+ZGJpIew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708133286; c=relaxed/simple;
	bh=2d1ogzLrDb9BJTG1ntCaJltOgc+YNgTsi3wE71ajevA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1FAmyXhihioosK35fp2Fvcp3IlNKTzzj/qU5M75CKK0cNbPFBRUB1AS4HmyfwfcgS3NFJICrz3wm8w9T/H15K5aIF4Yjo16p6pWmLVeDul4eqMwwI9g2aNMm06RG/U7odu9IBj5n/tPpYTD9xnmhRI/uN10sD0Pz6AuFh2NO0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hl2soOzW; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c04535b706so1493106b6e.0;
        Fri, 16 Feb 2024 17:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708133284; x=1708738084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EqWJLzhbN2hPYk8CsSuDuGTVd75xnF2oMWP55z7qdX0=;
        b=hl2soOzWS2ODFCHneH2gN0rdc3gRIrQTduxh6JzAfH8xo8ZNAFtfdWJH6RvvejT2zN
         IZQFnh+wgvbS+F5NUo9bRb2RI9uuxcfxbXG3xENhoHUCb5J5ob/eJjEL/DjReJoSBhdz
         bSJWlvgipgR9fYQjYHU7hVIHTeYTmnn/apvK7ueYkOfPbpC49F738M8Ms/BzatYDa3uR
         odfllwqXbhkGcnKQcc0IQzOtCJi7Q2tSA+U/A5AIsKkwvnfGU5ohbLXV1KryeKtdIU1V
         IkZPsr7T8KTLCdDXdPadYwAiRcyjiXIuQJ/w+gHKwqBqQgESLd1+0qBr9DOYQgB5umqp
         L8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708133284; x=1708738084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EqWJLzhbN2hPYk8CsSuDuGTVd75xnF2oMWP55z7qdX0=;
        b=Vyjuu5NN7im8NcnGuP5TGNYcgJuQItf0Cfg5L4dUt3DCo6wpxClwWUGKvEU5oZaaNq
         KnWq2CapsYAqOoXbY2wgxNWEhqHrgTgjt6IN3EQGHc5NWdrrkPrWUKE6cLkz1aUEPWv2
         9TDY13vwmQYmp3yWNZQUySHXuqMmIsuFgfGwgCxDagNgKYFWE3VjvgU9Zt13CTYs+dpS
         JXgFemOfZ+eQo75ruxzHsD6m/R2tvfzVmx/CW7WFzO1UZbOC7tms2gsUR8Q0VOt6DtOF
         jtbwjWG0tys8fyky3Gsl3qauBDR8vL1Qht5cg1oTKFl13R24z7a+nfHgoeypoHRtA3n9
         bAdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbF6IUXh0YupEUbneFkwB+dz3cVObJ5VQjhU3KEAa4E02mhnMAxs4/6OhtCvsZoTi3MIBHYxsW7HZqzSw77kxLxWb8
X-Gm-Message-State: AOJu0Yz5URBLvI8D2wThcsPZ9J/JyEN8Lka606AfEjCAUNnYfZP4QdQz
	yGnf3cjcsrW7HG8iabUMPgSex0JrrTH1upFKNPf6xTDy57c2Vjt2
X-Google-Smtp-Source: AGHT+IH48b7T3miuKN0iCgUbGAVZ8x1IJGfk/WXSXV4CS4/oOGKTFlKopuPj7tt0ztY1XpcGRn73Kw==
X-Received: by 2002:aca:1a0c:0:b0:3bf:f452:651a with SMTP id a12-20020aca1a0c000000b003bff452651amr5780521oia.52.1708133283981;
        Fri, 16 Feb 2024 17:28:03 -0800 (PST)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id bk36-20020a05620a1a2400b007873d8734cfsm423907qkb.132.2024.02.16.17.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 17:28:03 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id A571F1200043;
	Fri, 16 Feb 2024 20:28:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 16 Feb 2024 20:28:02 -0500
X-ME-Sender: <xms:oQvQZWpPPcf37E-FrOYYIBwlynXGHcz8eGY3KafMs9RPc9WbJ7G-RQ>
    <xme:oQvQZUooIlQre7GZ35B1JZ8RLsfjM3Gi6CkB9CJ8WH9wCp3meI2B0LshLWKjEl57i
    KvAESISA6LzjyN-pg>
X-ME-Received: <xmr:oQvQZbP7Vcqn-jQ8o9clR6fXuz31TBUFHOp4H7m0sqFr82ZadCPZrap7kr4>
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
X-ME-Proxy: <xmx:ogvQZV5ppu6MulSi_mmHmZF2WrMbqTfHViV1lJHq5v4e2Oz6Qzwtgw>
    <xmx:ogvQZV4VcQKgQyt-SOU9HPDGqkhauPPzLU9joFNUYuYg4UCNaoUdzQ>
    <xmx:ogvQZVgp51qd357oHSDy5MWy2wkXJRp5X1i9ssSjyGb9exF67Gi9Cw>
    <xmx:ogvQZUz2eyi_9JgpG4fH2dNZqeLlQ7MFbZPnmnrEguuvYYKo8l3tCeeOyk0>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Feb 2024 20:28:01 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Yang Jihong <yangjihong1@huawei.com>,	Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Oleg Nesterov <oleg@redhat.com>,	Heiko Carstens <hca@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	Mateusz Guzik <mjguzik@gmail.com>,	Nicholas Piggin <npiggin@gmail.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 3/6] rcu-tasks: Initialize data to eliminate RCU-tasks/do_exit() deadlocks
Date: Fri, 16 Feb 2024 17:27:38 -0800
Message-ID: <20240217012745.3446231-4-boqun.feng@gmail.com>
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

This commit therefore initializes the data structures that will be needed
to rely on these quiescent states and to eliminate these deadlocks.

Link: https://lore.kernel.org/all/20240118021842.290665-1-chenzhongjin@huawei.com/

Reported-by: Chen Zhongjin <chenzhongjin@huawei.com>
Reported-by: Yang Jihong <yangjihong1@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Yang Jihong <yangjihong1@huawei.com>
Tested-by: Chen Zhongjin <chenzhongjin@huawei.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 init/init_task.c   | 1 +
 kernel/fork.c      | 1 +
 kernel/rcu/tasks.h | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/init/init_task.c b/init/init_task.c
index 7ecb458eb3da..4daee6d761c8 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -147,6 +147,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.rcu_tasks_holdout = false,
 	.rcu_tasks_holdout_list = LIST_HEAD_INIT(init_task.rcu_tasks_holdout_list),
 	.rcu_tasks_idle_cpu = -1,
+	.rcu_tasks_exit_list = LIST_HEAD_INIT(init_task.rcu_tasks_exit_list),
 #endif
 #ifdef CONFIG_TASKS_TRACE_RCU
 	.trc_reader_nesting = 0,
diff --git a/kernel/fork.c b/kernel/fork.c
index 0d944e92a43f..af7203be1d2d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1976,6 +1976,7 @@ static inline void rcu_copy_process(struct task_struct *p)
 	p->rcu_tasks_holdout = false;
 	INIT_LIST_HEAD(&p->rcu_tasks_holdout_list);
 	p->rcu_tasks_idle_cpu = -1;
+	INIT_LIST_HEAD(&p->rcu_tasks_exit_list);
 #endif /* #ifdef CONFIG_TASKS_RCU */
 #ifdef CONFIG_TASKS_TRACE_RCU
 	p->trc_reader_nesting = 0;
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index b7d5f2757053..4a5d562e3189 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -277,6 +277,8 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 		rtpcp->rtpp = rtp;
 		if (!rtpcp->rtp_blkd_tasks.next)
 			INIT_LIST_HEAD(&rtpcp->rtp_blkd_tasks);
+		if (!rtpcp->rtp_exit_list.next)
+			INIT_LIST_HEAD(&rtpcp->rtp_exit_list);
 	}
 
 	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d.\n", rtp->name,
-- 
2.43.0


