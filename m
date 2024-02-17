Return-Path: <linux-kernel+bounces-69644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3BB858CBD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD1C28444A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB521CD13;
	Sat, 17 Feb 2024 01:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nq3WjxKR"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE0D1CA98;
	Sat, 17 Feb 2024 01:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708133288; cv=none; b=IdKVK64tK94YhYiA7HuibPttaLdipcbrbubGrERrQwsxgPkFTZSBd+Hg9WWmvwTxzko2kOzCdu4axaQVxIKN8DNF0sSDEW4XzNNOXDpDDFyAYEA9DPbu+HKAWCk11XkLrqEnfzrrySBIXaheT5HJF5/Z2Gn/wH7my3VOePSri8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708133288; c=relaxed/simple;
	bh=guwEaF/rDbBs7UTfGuQDT1thFEEvaDXW74LeCy5xw24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Th2l7A9GAGNKcisD+5G/3ztPHxXz4Fv38xwNxYDlbLpXk8Jp/jhka0HcBeJ9WVkFYD7Rg8Bb+Hqg9HL3+zv8dCznJbSBKzn8Epw9H9PfycLUAxjZ2dQeF8GzSjYaXOJFXsh75GjxH5tFF0oryQYuGe28Q0/UNETBQebJoQ564eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nq3WjxKR; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6869233d472so6436016d6.2;
        Fri, 16 Feb 2024 17:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708133285; x=1708738085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hviMEBDsjs4mPn8ckWbDhMJvstiAXO/xVzEmAIrjOf0=;
        b=Nq3WjxKR6mU7gcOf1RMVTeXpEGP2bL1Uguoao7B4FA1xQpubnhz8BepxH4+Up2OM9D
         1UCLLVz4JVgSV2mhR7xKJDN5T2ViXDJ6nZrY2FfZ+0QEu57ILCqnZma27ME7VdqsqIUg
         VGg5FrxqSrdlZO+tOKZN0KRpIxuYZaw59lXnASvxhCZZKs8xQiXU6EpaiTwYxud4VXJy
         nOurVsaIE0n0u7vixkYW9dLtbdJcHQzMT5kG4nTknqKgZMz8gtl8UxKIC08GgTmw0xIb
         KbwRBDD74S7AcLmrxver2KZoIEt51ma28cshOr6OmSdBzLWQEtmkJy1LXlPD4KMe5RGn
         Ij8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708133285; x=1708738085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hviMEBDsjs4mPn8ckWbDhMJvstiAXO/xVzEmAIrjOf0=;
        b=YY6ZpRPZa9LIvMVO/jEONU6yrO/cHx9mjHfkzjuyFq7wYddT//LqoKyy0LCiLeY3KI
         O5B/Oxtw1zw/pYWfri3bOtjEP4YaUn4LZ4Ez7YrQIxJlSyx2xJ148q9U5Dm+ZwT0SYs7
         iwUsLton7/SXG4XJdFnDxg8k3Q2s02j8/43M7/EsHV2MQfOd2JLgKd6YngQ5CzIwTpr4
         dziUliFnWZyJSqm//zlT3I2WK4Zop1ytPVrCCAHRcAXL1+wZ4ygIF9p/m3xWcpK4yQAz
         xOxhEKADcAOX1/D7TvjWkzGCUWl2JGMfP/KdktePN7EDfBTJLB0daJEb7WIoSAIH0JUT
         OAUw==
X-Forwarded-Encrypted: i=1; AJvYcCWIdoIzal5a7NVUe0LzlxWuvNPnggD7e/N8lyuwJK8KcakVJRBpq6MX7I87kOKhYxN1LG9Wf2GQQ/bstiUwmr02fhDw
X-Gm-Message-State: AOJu0Yx5o8IyLiD0eI5DELcgFUCMxmCC2Lpew91TmBR0ZberCfUbLaTT
	UDVPpbJLciw1J0KrW3NbPkUtwsFTSwtALJ2T4Z7EEs6X25YVywh2
X-Google-Smtp-Source: AGHT+IEkafaLH9w2EJ2stsIU2GX7WndqbdL8vvTK4s4HagsiEzJDOGjfjIxhIePnm9iXYtipNgEBCg==
X-Received: by 2002:a0c:ab17:0:b0:68f:ff3:299c with SMTP id h23-20020a0cab17000000b0068f0ff3299cmr6889855qvb.26.1708133285236;
        Fri, 16 Feb 2024 17:28:05 -0800 (PST)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id lg21-20020a056214549500b0068f1bc6c57asm481938qvb.69.2024.02.16.17.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 17:28:04 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 6EDA31200043;
	Fri, 16 Feb 2024 20:28:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 16 Feb 2024 20:28:04 -0500
X-ME-Sender: <xms:pAvQZWDDHSwrpCwddhDt4cAuzeViKwYppVv3AGEghFyjYlJtVZzbKA>
    <xme:pAvQZQiMqio8J8FmlYBVaVL5HxjsyspEZdYmIIjCxZ6mn45ceWOWy3Ng2b2tSeJzL
    ZG61fgLBkjcyguTGA>
X-ME-Received: <xmr:pAvQZZknLWN8t4drqlmx4JTt3Ox76VQQpMSx9uCocjpo4ojmzDiory2E7Sg>
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
X-ME-Proxy: <xmx:pAvQZUy-vD_Xnkm2_uNINWb6UMxfHLqJn2e6TdUGnMffjqDbP92tZA>
    <xmx:pAvQZbQSqUie2aqanYTA5D5hsx7H2MBe_2zAIX3DZFHpLCoP4eC93g>
    <xmx:pAvQZfZKoa25EB6HSFw5LxqXz3116R2qM3rRlTmtftP8M-hdnC1Wsw>
    <xmx:pAvQZXq7NpxoDLfR06385HKFccSUFhz0MidXEnFHx6maDbeLoaYlx7mjy5A>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Feb 2024 20:28:03 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v2 4/6] rcu-tasks: Maintain lists to eliminate RCU-tasks/do_exit() deadlocks
Date: Fri, 16 Feb 2024 17:27:39 -0800
Message-ID: <20240217012745.3446231-5-boqun.feng@gmail.com>
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

This commit continues the elimination of deadlocks involving do_exit()
and RCU tasks by causing exit_tasks_rcu_start() to add the current
task to a per-CPU list and causing exit_tasks_rcu_stop() to remove the
current task from whatever list it is on.  These lists will be used to
track tasks that are exiting, while still accounting for any RCU-tasks
quiescent states that these tasks pass though.

[ paulmck: Apply Frederic Weisbecker feedback. ]

Link: https://lore.kernel.org/all/20240118021842.290665-1-chenzhongjin@huawei.com/

Reported-by: Chen Zhongjin <chenzhongjin@huawei.com>
Reported-by: Yang Jihong <yangjihong1@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Yang Jihong <yangjihong1@huawei.com>
Tested-by: Chen Zhongjin <chenzhongjin@huawei.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tasks.h | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 4a5d562e3189..68a8adf7de8e 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1151,25 +1151,48 @@ struct task_struct *get_rcu_tasks_gp_kthread(void)
 EXPORT_SYMBOL_GPL(get_rcu_tasks_gp_kthread);
 
 /*
- * Contribute to protect against tasklist scan blind spot while the
- * task is exiting and may be removed from the tasklist. See
- * corresponding synchronize_srcu() for further details.
+ * Protect against tasklist scan blind spot while the task is exiting and
+ * may be removed from the tasklist.  Do this by adding the task to yet
+ * another list.
+ *
+ * Note that the task will remove itself from this list, so there is no
+ * need for get_task_struct(), except in the case where rcu_tasks_pertask()
+ * adds it to the holdout list, in which case rcu_tasks_pertask() supplies
+ * the needed get_task_struct().
  */
-void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
+void exit_tasks_rcu_start(void)
 {
-	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
+	unsigned long flags;
+	struct rcu_tasks_percpu *rtpcp;
+	struct task_struct *t = current;
+
+	WARN_ON_ONCE(!list_empty(&t->rcu_tasks_exit_list));
+	preempt_disable();
+	rtpcp = this_cpu_ptr(rcu_tasks.rtpcpu);
+	t->rcu_tasks_exit_cpu = smp_processor_id();
+	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
+	if (!rtpcp->rtp_exit_list.next)
+		INIT_LIST_HEAD(&rtpcp->rtp_exit_list);
+	list_add(&t->rcu_tasks_exit_list, &rtpcp->rtp_exit_list);
+	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
+	preempt_enable();
 }
 
 /*
- * Contribute to protect against tasklist scan blind spot while the
- * task is exiting and may be removed from the tasklist. See
- * corresponding synchronize_srcu() for further details.
+ * Remove the task from the "yet another list" because do_exit() is now
+ * non-preemptible, allowing synchronize_rcu() to wait beyond this point.
  */
-void exit_tasks_rcu_stop(void) __releases(&tasks_rcu_exit_srcu)
+void exit_tasks_rcu_stop(void)
 {
+	unsigned long flags;
+	struct rcu_tasks_percpu *rtpcp;
 	struct task_struct *t = current;
 
-	__srcu_read_unlock(&tasks_rcu_exit_srcu, t->rcu_tasks_idx);
+	WARN_ON_ONCE(list_empty(&t->rcu_tasks_exit_list));
+	rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, t->rcu_tasks_exit_cpu);
+	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
+	list_del_init(&t->rcu_tasks_exit_list);
+	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 }
 
 /*
-- 
2.43.0


