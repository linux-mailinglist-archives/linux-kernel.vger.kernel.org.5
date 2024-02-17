Return-Path: <linux-kernel+bounces-69646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3579858CBF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E481C21B7E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D40F1D522;
	Sat, 17 Feb 2024 01:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+stnbu8"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930521CD1F;
	Sat, 17 Feb 2024 01:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708133291; cv=none; b=cb3qYWaFTahpJxShmiELn/k1Q50AEN+QgH8aywRU+cZ2WyXG/yjJXU8KZJEJ6gyjZpzVisPtAVg6lmLfq14mLp3zWqlPxgymHAB/Pia5FMLhcjCEgi7hlviz13M1mhvViR8okgGSq5X9aUoE7LTyjehklsbx6uGM7AV9WLfBXko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708133291; c=relaxed/simple;
	bh=KLY1+2mGq3H9diWHchRwxDC5ACzJHAgMPqkliWw0HYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeFsxln59LthlOtK5mn2FHdwSCGtg/1zVmajFkWNnB376sNRq/zij2BlgJk93hpVAyNrHb7+vMbF28sQPdfewp5MvlCH3A0HbaV22kk1t5ZPFqQ3bd2WSGpJMLINheVv7a3lPkIBK74kq5hHVjjT4kEck+qfOOe9Sqc0S28LLW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+stnbu8; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso1353037276.0;
        Fri, 16 Feb 2024 17:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708133288; x=1708738088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T5Wf+uCUWSLEUPm4v8/DfTpOrC7IR1g418bIMiGKo4M=;
        b=T+stnbu8W7xsXBaJXXb5IZCo+ZKzT0/hgW2KW/n0IXmzvJTlvXAt4tbeItEsPJ5lQl
         CnwoLlKGDIt4tY3nXQW4TeZAl17otodsn8hZpe99QJVNcBScvghsVPk86kClrMX7/Lh1
         rzFVrnHjZViROBcdKs53jVj8h31pX1mhM29IfBC5LSgYQryCBFy1TZGop/NOcdplQD1u
         jNl5jB9n0VtFZNAyQGJE4owG5XTO4IsVMBKgSJQaAKQCdqH/RTqEAbzGuU4s4H70llyK
         ZDt581xJ9k0Vy+ZecbMkOzmI9Pjh55bLwb6TfSG/Y5yQk2m1JNk3ys9XbFNZ+7Vz7ytk
         NGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708133288; x=1708738088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T5Wf+uCUWSLEUPm4v8/DfTpOrC7IR1g418bIMiGKo4M=;
        b=H2/eyaXay2yfiCOf+fKt66L3wwUlQl/1S9lF47ZPVEkDs2amuOCSEAyRnOCjsRQ1hX
         KDmnbOcAfQghDqWAdzE098ZtnLh4oQLuRl2GlgqWsk8sqxGWjauTUO+mfZ+KWzoCVQ4R
         L/6u6gM4HOtcDKcep8JSl0wKcfgt0ryHw5INqvQ+HaG3ci/eZHCaUN5uvHf9AEtJnfF8
         v3SMyLdxkjuuStvuiSX1xDT/UDBHrakDNxUFflhbXgApKDB57xEbkg184/VggcVxVM/h
         DTwd15Q9owOhinp5VsCuW/peuwmN0KQCRdIrYIxEKYEUeLCCtp9yj3kyT5W+Wdk2l3u3
         VTSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWOrXkpdP2sFHkBKnIPnst0rCIGJ4B81h4D9roQ7bkkvnPzb3gGggAQ2N9dxqVuvLZSBHY1LWGhiQpw5/BBrGq7IyR
X-Gm-Message-State: AOJu0Yy9x9esI6FGLGIL58KYTcpM3R4RAm/6DChjHw75JKB2VI5DMvSQ
	5L0z4Ss6mdpfl6GIHnfKA5nqs9OrIyjpgJoDxwGUQCVSh4vZl1o/
X-Google-Smtp-Source: AGHT+IHvCIAW1gUWuC6BiNrjm09BPqEzDCK19XkJ9Kl/trYg2RlHpnciPFlp4sSmM9ye2ba4YkOZig==
X-Received: by 2002:a5b:708:0:b0:dc6:cc35:35e9 with SMTP id g8-20020a5b0708000000b00dc6cc3535e9mr6286134ybq.35.1708133288319;
        Fri, 16 Feb 2024 17:28:08 -0800 (PST)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id y23-20020a37e317000000b00785e016ec39sm442118qki.42.2024.02.16.17.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 17:28:07 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 849BE1200043;
	Fri, 16 Feb 2024 20:28:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 16 Feb 2024 20:28:07 -0500
X-ME-Sender: <xms:pwvQZR3TU7NX90Escm2Wc81OnPAVBmPtY17kLpb9sqQyUzuPlxXTAQ>
    <xme:pwvQZYEND7eoElyELQWacULDsW_IdItKrmCLKb-PZs9gNoD73fgBb3q2VuIi_yq8n
    QlNl4iEzRX-d9J4Pw>
X-ME-Received: <xmr:pwvQZR7-1r9Pp5i15pt3p35dH-XGn_EuUe73LXRf5pEKzS1ob30WpA0iloU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfevffeiueejhfeuiefggeeuheeg
    gefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:pwvQZe2SZGNfVOGlbIKPm07fh9SxzwgbYllrC5wJOBD8042eVAtw7Q>
    <xmx:pwvQZUFBk-KS6ck-wbYemB2kETPrPC7xSbaC4E_wwb1oJZon-w32-Q>
    <xmx:pwvQZf_KJcwlLfLjx4LH1THNpg8K1JOEGaMfKjRpalDO9PQPIz-vLQ>
    <xmx:pwvQZaFo3aA0PbOxASC96s6nG54heAFL3BRH6YLeYkd8ccLSP5QiMgDYk3w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Feb 2024 20:28:07 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v2 6/6] rcu-tasks: Maintain real-time response in rcu_tasks_postscan()
Date: Fri, 16 Feb 2024 17:27:41 -0800
Message-ID: <20240217012745.3446231-7-boqun.feng@gmail.com>
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

The current code will scan the entirety of each per-CPU list of exiting
tasks in ->rtp_exit_list with interrupts disabled.  This is normally just
fine, because each CPU typically won't have very many tasks in this state.
However, if a large number of tasks block late in do_exit(), these lists
could be arbitrarily long.  Low probability, perhaps, but it really
could happen.

This commit therefore occasionally re-enables interrupts while traversing
these lists, inserting a dummy element to hold the current place in the
list.  In kernels built with CONFIG_PREEMPT_RT=y, this re-enabling happens
after each list element is processed, otherwise every one-to-two jiffies.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tasks.h | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 4dc355b2ac22..866743e0796f 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -971,13 +971,32 @@ static void rcu_tasks_postscan(struct list_head *hop)
 	 */
 
 	for_each_possible_cpu(cpu) {
+		unsigned long j = jiffies + 1;
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
 		struct task_struct *t;
+		struct task_struct *t1;
+		struct list_head tmp;
 
 		raw_spin_lock_irq_rcu_node(rtpcp);
-		list_for_each_entry(t, &rtpcp->rtp_exit_list, rcu_tasks_exit_list)
+		list_for_each_entry_safe(t, t1, &rtpcp->rtp_exit_list, rcu_tasks_exit_list) {
 			if (list_empty(&t->rcu_tasks_holdout_list))
 				rcu_tasks_pertask(t, hop);
+
+			// RT kernels need frequent pauses, otherwise
+			// pause at least once per pair of jiffies.
+			if (!IS_ENABLED(CONFIG_PREEMPT_RT) && time_before(jiffies, j))
+				continue;
+
+			// Keep our place in the list while pausing.
+			// Nothing else traverses this list, so adding a
+			// bare list_head is OK.
+			list_add(&tmp, &t->rcu_tasks_exit_list);
+			raw_spin_unlock_irq_rcu_node(rtpcp);
+			cond_resched(); // For CONFIG_PREEMPT=n kernels
+			raw_spin_lock_irq_rcu_node(rtpcp);
+			list_del(&tmp);
+			j = jiffies + 1;
+		}
 		raw_spin_unlock_irq_rcu_node(rtpcp);
 	}
 
-- 
2.43.0


