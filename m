Return-Path: <linux-kernel+bounces-43647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB8084172E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC0D1C22833
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBC154659;
	Mon, 29 Jan 2024 23:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdrtcQ/b"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337045380F;
	Mon, 29 Jan 2024 23:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706572672; cv=none; b=pal0A27vQNhlqBvp8NY7xyWIrYLRBfnuM6WgzNNQl+v+1IGOpZcrNNMPTwmfOceEjhvCgV6VShKR3ciKye08vFEKvUTnyj1srwInRy8jIndb6RzjzostOs0YNFcpJtERu9kz/QhxLmJ68+Y6ff+AGyaLT5AnFh7nfnugFarFh1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706572672; c=relaxed/simple;
	bh=8wqE5rf9UxhPmmiVtHpD8CarsI0v9KgYGp0MYzOQlBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjraanEKkw1Azcwq4tKi/RCGRx/TOgINiiL3q0YMa75RkGaSnTQmB2vy4ioNkESHONBYG8dWJ7LdDwFXbYB/bKsy7G/Op3w/t2oSXX+tK+/FptEXUt+N3MFZttULIBj5CHtgrszmFoMH8unXHKCcqvr4dNLD+qk/qob5k9/Ki0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdrtcQ/b; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42a4516ec46so28753011cf.0;
        Mon, 29 Jan 2024 15:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706572670; x=1707177470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kb0IeKP4KjdN91MnFOwXJ+hR32foD6IhOMX4SQFbYRw=;
        b=QdrtcQ/brQzWACFOSrBTbDXtv7xHKk8vwy/g67eqCCn/w/z7qc8UNRboW+QH7r5yd6
         U3z8qqTGNQbbzC0T2nHHSx+vrq2swkPgs5gGfTF6BQ0xDBtaTpwCDsdSiIjmyiei3/j8
         T7BMLnrYfKlZJS00eHrBUy7sAjhu7QyMx3gLoDwNQhmfKO5EfUHMs1BHnOxRHBt68HRe
         on4h/Jc54oTCHPkUI4CkzAlsyB9zXDxbQW6xoJRUEWt12ycmpsc8uwz5aVKBq/czY85E
         swtEtAlKS3/r/RAjoIMpAs7Bc9x4qInL2G7EqOQOfwIGKOXHf6YfiL8DCBoyXpgKqQ2t
         wYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706572670; x=1707177470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kb0IeKP4KjdN91MnFOwXJ+hR32foD6IhOMX4SQFbYRw=;
        b=PVTCcDXieM56a3BryQF08PRHAhv/zXCZUW9r3Zta1UwhqXXwv5Xx326GS3zm3JHyD8
         AzJzpiE7YLmC92xCxLzztS67+Xt4gmsoqekbwBs+jaLbr9zsCUkdfFEqj04PAiuA1A/Y
         oLRwSyu6aF7AzUvEO00TawGpr1A7NIB6u7y7NXzSs3SIQHl3dhhCSN9DoiC/usdUJscG
         qpAq+qf0wNeSGGQs0FyjNNe2bA823LUiXYJm6PWBd3szZQNXp7mLiqcOIRYyIramgDJb
         vobhGiFyLjySdejcF8QUrvHapZS//Jl1vR04r5mMrfRBTvg5lenkZfDb1LJXYuxnoytb
         WhlQ==
X-Gm-Message-State: AOJu0YzwM4qQtgpN3xe3JAB7E/GDcayYEeBJaOorFCgEfGyM/XRl6TEU
	kxPEjVNujnBohrdnyABH+3mkmME0KyH/uqVwJLU3mZ9djwZCJOd8
X-Google-Smtp-Source: AGHT+IGhN8klhm/WpPphfEZ/okJyUgUeg/JXdz1RBe8k0av97p37nBsdiyM7KVoStWqnabLLlQA27A==
X-Received: by 2002:a05:622a:1492:b0:42a:b06e:84db with SMTP id t18-20020a05622a149200b0042ab06e84dbmr141342qtx.12.1706572669990;
        Mon, 29 Jan 2024 15:57:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWElj/lKfHU0n6yMFY5LQt1Kbf5Z0a5m8u+G/UPOJRBwPvN0k68wZ6v1PrirsmxjOvvieMXlE0OK23pkaEJ4YTiaf2QmhVIIcILiGRmYBAEwftVQeGB64AObcj0lx1y3tHX0XNp8WVVMsjFa7lD404HEzNhtWfxHB2O8XCw/GfOhDBSd9y/Rkuge0DVDEgTYx6NM5myBWXQ2LlO/Od8rZcFaAYqtwctpm9wubV+2Fh4Y+r+BjqLsiRGEfl/WNm+vOmUUo3uBCLmlQOTXjX4lGBn1OPy/Fji8/myfOkndg1oxe0oKH/N6n4wPXu38+g4E7/hDQCOAesF+dGx7i4XFufn7HpGKJtQ2MGpRPThmYjFDyperzBz9U/R6YjB5sI7s2bSM8f84+zFdH3WpXtlDOpm
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id kb8-20020a05622a448800b004280cad48basm4002476qtb.77.2024.01.29.15.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 15:57:49 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 0E2C527C0061;
	Mon, 29 Jan 2024 18:57:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 29 Jan 2024 18:57:49 -0500
X-ME-Sender: <xms:fDu4Zb6kXz9aBmPwnoNeZzH9Mru19-PnapM_SVCWal9EvNVT-QU1IQ>
    <xme:fDu4ZQ712dRvn8vvj4UGbw8Qe4sTyQ9g2ulFkHn95t4RkM4_Z6bi8_NoFze_yBKv5
    8vt_aoi1l01fGV5vg>
X-ME-Received: <xmr:fDu4ZSdDQHf6Yi768x7ua4IlLqEoX9xYHN45FpyiV5CJfpaujiCTxyFdz2Tq0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedthedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:fDu4ZcINiYFeMhv64Cm2-pIrfUlKvG5ar4X4OlyBlAw1BHbq5mwHgA>
    <xmx:fDu4ZfLr0nBcEM3Qq9Tku9pZKzimlMOcfMunm-HdTFt1Nvn0z5UTaw>
    <xmx:fDu4ZVx-yGlR2rNM-N5MQiT9bgC4VBk403ceBCGDfbmawKgLb80s2A>
    <xmx:fTu4ZZAXNctR7Axcgm2Byf-cmLRFsy2jvEOrpLfnWqDx4_3p6j81cg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 18:57:48 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 1/8] rcu: Rename jiffies_till_flush to jiffies_lazy_flush
Date: Mon, 29 Jan 2024 15:56:34 -0800
Message-ID: <20240129235646.3171983-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129235646.3171983-1-boqun.feng@gmail.com>
References: <20240129235646.3171983-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

The variable name jiffies_till_flush is too generic and therefore:

* It may shadow a global variable
* It doesn't tell on what it operates

Make the name more precise, along with the related APIs.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h       |  8 ++++----
 kernel/rcu/rcuscale.c  |  6 +++---
 kernel/rcu/tree_nocb.h | 22 +++++++++++-----------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index f94f65877f2b..dcfb666f2499 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -543,11 +543,11 @@ enum rcutorture_type {
 };
 
 #if defined(CONFIG_RCU_LAZY)
-unsigned long rcu_lazy_get_jiffies_till_flush(void);
-void rcu_lazy_set_jiffies_till_flush(unsigned long j);
+unsigned long rcu_get_jiffies_lazy_flush(void);
+void rcu_set_jiffies_lazy_flush(unsigned long j);
 #else
-static inline unsigned long rcu_lazy_get_jiffies_till_flush(void) { return 0; }
-static inline void rcu_lazy_set_jiffies_till_flush(unsigned long j) { }
+static inline unsigned long rcu_get_jiffies_lazy_flush(void) { return 0; }
+static inline void rcu_set_jiffies_lazy_flush(unsigned long j) { }
 #endif
 
 #if defined(CONFIG_TREE_RCU)
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index ffdb30495e3c..8db4fedaaa1e 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -764,9 +764,9 @@ kfree_scale_init(void)
 
 	if (kfree_by_call_rcu) {
 		/* do a test to check the timeout. */
-		orig_jif = rcu_lazy_get_jiffies_till_flush();
+		orig_jif = rcu_get_jiffies_lazy_flush();
 
-		rcu_lazy_set_jiffies_till_flush(2 * HZ);
+		rcu_set_jiffies_lazy_flush(2 * HZ);
 		rcu_barrier();
 
 		jif_start = jiffies;
@@ -775,7 +775,7 @@ kfree_scale_init(void)
 
 		smp_cond_load_relaxed(&rcu_lazy_test1_cb_called, VAL == 1);
 
-		rcu_lazy_set_jiffies_till_flush(orig_jif);
+		rcu_set_jiffies_lazy_flush(orig_jif);
 
 		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
 			pr_alert("ERROR: call_rcu() CBs are not being lazy as expected!\n");
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 4efbf7333d4e..aecef51166c7 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -256,6 +256,7 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
 	return __wake_nocb_gp(rdp_gp, rdp, force, flags);
 }
 
+#ifdef CONFIG_RCU_LAZY
 /*
  * LAZY_FLUSH_JIFFIES decides the maximum amount of time that
  * can elapse before lazy callbacks are flushed. Lazy callbacks
@@ -264,21 +265,20 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
  * left unsubmitted to RCU after those many jiffies.
  */
 #define LAZY_FLUSH_JIFFIES (10 * HZ)
-static unsigned long jiffies_till_flush = LAZY_FLUSH_JIFFIES;
+static unsigned long jiffies_lazy_flush = LAZY_FLUSH_JIFFIES;
 
-#ifdef CONFIG_RCU_LAZY
 // To be called only from test code.
-void rcu_lazy_set_jiffies_till_flush(unsigned long jif)
+void rcu_set_jiffies_lazy_flush(unsigned long jif)
 {
-	jiffies_till_flush = jif;
+	jiffies_lazy_flush = jif;
 }
-EXPORT_SYMBOL(rcu_lazy_set_jiffies_till_flush);
+EXPORT_SYMBOL(rcu_set_jiffies_lazy_flush);
 
-unsigned long rcu_lazy_get_jiffies_till_flush(void)
+unsigned long rcu_get_jiffies_lazy_flush(void)
 {
-	return jiffies_till_flush;
+	return jiffies_lazy_flush;
 }
-EXPORT_SYMBOL(rcu_lazy_get_jiffies_till_flush);
+EXPORT_SYMBOL(rcu_get_jiffies_lazy_flush);
 #endif
 
 /*
@@ -299,7 +299,7 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
 	 */
 	if (waketype == RCU_NOCB_WAKE_LAZY &&
 	    rdp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT) {
-		mod_timer(&rdp_gp->nocb_timer, jiffies + jiffies_till_flush);
+		mod_timer(&rdp_gp->nocb_timer, jiffies + rcu_get_jiffies_lazy_flush());
 		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
 	} else if (waketype == RCU_NOCB_WAKE_BYPASS) {
 		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
@@ -482,7 +482,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	// flush ->nocb_bypass to ->cblist.
 	if ((ncbs && !bypass_is_lazy && j != READ_ONCE(rdp->nocb_bypass_first)) ||
 	    (ncbs &&  bypass_is_lazy &&
-	     (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_till_flush))) ||
+	     (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + rcu_get_jiffies_lazy_flush()))) ||
 	    ncbs >= qhimark) {
 		rcu_nocb_lock(rdp);
 		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
@@ -723,7 +723,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		lazy_ncbs = READ_ONCE(rdp->lazy_len);
 
 		if (bypass_ncbs && (lazy_ncbs == bypass_ncbs) &&
-		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_till_flush) ||
+		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + rcu_get_jiffies_lazy_flush()) ||
 		     bypass_ncbs > 2 * qhimark)) {
 			flush_bypass = true;
 		} else if (bypass_ncbs && (lazy_ncbs != bypass_ncbs) &&
-- 
2.43.0


