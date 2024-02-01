Return-Path: <linux-kernel+bounces-47509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F75E844EC9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D861F2E3A5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFEA12E5F;
	Thu,  1 Feb 2024 01:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZQUa7Mh"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8247463A0;
	Thu,  1 Feb 2024 01:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706751738; cv=none; b=WTTEMcTbp2/WHaBh3yj9NKgmuqdF1grpd9AoljSbUSnNXlCy6dwuoga4twi+rEHGRlvxUL+WiDYtLabD4M/hYUeWfpbTU4b4JeZesBR1JfwN6ta2Y5b2M/pMJod4D8G/aHy11e1MA0aFvKwiFGj50mglnMU9R0sswdrcRLgjyEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706751738; c=relaxed/simple;
	bh=URsVmEp6Jr873vr5jenxJaWo72Ku3rabQQ+gAmu0f1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXGpFfytrlHZ4wevifCyEUNggv6h7755Jp9lQpPszX3R7zB26QBv7/9/J1xeqFgsh3azPkHe3ypVsxDlT+vJPeyw8RwoCN3PAeJmEa3r8RCYXNbGAEEmO9Ebd//95M2e+os9sMnnWjChiBUFhWCaIlEkIsGB173lGOBvDddf/t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZQUa7Mh; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68c44100327so2017606d6.2;
        Wed, 31 Jan 2024 17:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706751735; x=1707356535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=98uYtdjZqt8mPN8u771GmaA9N12/7R+F5RUUjJgYUPQ=;
        b=LZQUa7MhUF0BNfXRKevudcd1zOzldfHlWvlQbbyG94tvN4k+wYl1veVoII+0e/Yo8g
         HMYRv0PEFk6NEyPDcp1XWYHRIjggnCGXunk1E8Sc5xAMy2zZgVjnA21BHVHWFcQQXmhK
         dTDxePnOo1zHb982AgdeqK2zga4Ixc33cSGAKXspn6gz5tntGnqfLshVYxnYg1HAL2SJ
         6jw9kWK2y/638TNb+IA8Qy3arkGXLf8L0ekD3l7QfjHhKkTWx6uPUO0KyMI/0eNT+fox
         Qwc+Bhe1tpd7LMURQMoKOjeXuKPoLtXUyIIWzbcIhfIqhT6Bdxj6eVNeExqqiijXNc8z
         TgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706751735; x=1707356535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=98uYtdjZqt8mPN8u771GmaA9N12/7R+F5RUUjJgYUPQ=;
        b=lOpcmiQgWDgf2rQ1fU0jywC3TFB/0CnokAN3nN1L2P2rnI9lIjItS/eQOJU9y5sU+8
         KDQbuIScdXrNYppvZyTsUWReP+7LOSkqblhHaofaXdL0vFYu913RpY8CqJkd4lUYgkZy
         /oiaUszXWTch5u4sKFZUh2ZP+4tKscyM5fURFVpD/pilqOjY2n+lYzGSr3SDIDYfr7x+
         QR2AbegCpMcqpF6zg6Z74cLYYXkOPa/ZPTSv8henDp0Nk3geFVOtgXFhJXPOmgCxLTWb
         QAPLHQQLO9yRcpPjYILrXrgzSNTtJtyuY1yPq/CBXW+x4az/EMegpY7aGOG0IOpKrT9g
         1QdQ==
X-Gm-Message-State: AOJu0YyxIrOgtmw5bVghEZLpt4rkJbEDwsi++/S3woE2qcL/f1ncUSV2
	hkYMR/5L04X1zUFaouEeyhwImNby1QaiJC/YrLmZgk0coMjQKKFo
X-Google-Smtp-Source: AGHT+IGmZu+egkcf1f6ysn8wFESXHeVIjltXqOdkSszNHlpulRGuA1ijCixLr+Ou66HSNAkuYpV4eQ==
X-Received: by 2002:a05:6214:20e6:b0:68c:4caa:dd17 with SMTP id 6-20020a05621420e600b0068c4caadd17mr4015452qvk.6.1706751735429;
        Wed, 31 Jan 2024 17:42:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV5H58O5j3sQdOL+vJNGvEAGH3Se5j3EHzm0jbl5Emvk7HuvTTSdqJiI8P12gEB7VHZI0tMOi+oHbFCB8tcfbHWoqSr8eVDiLAz+Nd1kH7UNxPM7BHiMTLWibDtND+WY1s2/dkmpcbkiSfKmfPxhMAehNYm3ygbG6ahESqeKE4zHyPaWiAuEUaNs/jnIT5MUD16IcTUJIpCgFIkaRQzsXPy7rqnG/kNrzZv0WiwgmNvEyS4fcO0d+4c5AUReRm4cgeacFQueuIrzyC/+iBOzlMV4Gubck2GXuZ44mIvqVIujzNMIJdyoFJQChJh0gpSVfn+E3Kvcv5Gyn3BCxOBeg0uJ9O73QE/G27CDzlpDLfnFTMQcJIEvV5WwYdV5Zl9f+J/jaG9DSbD+g/+o4xRXKXUMxr6moZVUw==
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id on6-20020a056214448600b00685ad9090basm2453293qvb.97.2024.01.31.17.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 17:42:15 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id A91B027C005B;
	Wed, 31 Jan 2024 20:42:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 31 Jan 2024 20:42:14 -0500
X-ME-Sender: <xms:9va6ZfyYk1kwFLmjXqJeV6qvM-AdogH0awuimlMUuFx1qpn2eSvH8g>
    <xme:9va6ZXSnkJcV4DPbtjiJzgCcUwlBVnPHfGpIJRCdnsMzfwitqdxL5PUaHCj3zu026
    pG6IbPeadLb2otnnA>
X-ME-Received: <xmr:9va6ZZXcWW1bl2lbb1go2NlxcWtGU7TJivZEnMR6mcfgh8VafOTrEcDAFCXb2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:9va6ZZg1sB8NK09nr1VGDmZTApBGHU0umaSRuDvi9KG5LS29gD5uKQ>
    <xmx:9va6ZRAmkUJYbEBxQIsZ6cRqD1RFLivZROb1lNOmi7dYSZKBVW4wgQ>
    <xmx:9va6ZSIxpjfKjUltWnWfTKx8AZAkrOBFdKP3OeUGTQAdDR1kxqkL3w>
    <xmx:9va6ZV5J3aeGF-Mkt8D4mLlIPGOIr0hp1PlHBmXwjAtn51t_Y4rTrg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jan 2024 20:42:14 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH 3/6] rcu/nocb: Make IRQs disablement symmetric
Date: Wed, 31 Jan 2024 17:40:55 -0800
Message-ID: <20240201014100.3204532-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201014100.3204532-1-boqun.feng@gmail.com>
References: <20240201014100.3204532-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

Currently IRQs are disabled on call_rcu() and then depending on the
context:

* If the CPU is in nocb mode:

   - If the callback is enqueued in the bypass list, IRQs are re-enabled
     implictly by rcu_nocb_try_bypass()

   - If the callback is enqueued in the normal list, IRQs are re-enabled
     implicitly by __call_rcu_nocb_wake()

* If the CPU is NOT in nocb mode, IRQs are reenabled explicitly from call_rcu()

This makes the code a bit hard to follow, especially as it interleaves
with nocb locking.

To make the IRQ flags coverage clearer and also in order to prepare for
moving all the nocb enqueue code to its own function, always re-enable
the IRQ flags explicitly from call_rcu().

Reviewed-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree.c      |  9 ++++++---
 kernel/rcu/tree_nocb.h | 20 +++++++++-----------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d540d210e5c7..a402dc4e9a9c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2735,8 +2735,10 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 	}
 
 	check_cb_ovld(rdp);
-	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
+	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy)) {
+		local_irq_restore(flags);
 		return; // Enqueued onto ->nocb_bypass, so just leave.
+	}
 	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
 	rcu_segcblist_enqueue(&rdp->cblist, head);
 	if (__is_kvfree_rcu_offset((unsigned long)func))
@@ -2754,8 +2756,8 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
 	} else {
 		__call_rcu_core(rdp, head, flags);
-		local_irq_restore(flags);
 	}
+	local_irq_restore(flags);
 }
 
 #ifdef CONFIG_RCU_LAZY
@@ -4646,8 +4648,9 @@ void rcutree_migrate_callbacks(int cpu)
 		__call_rcu_nocb_wake(my_rdp, true, flags);
 	} else {
 		rcu_nocb_unlock(my_rdp); /* irqs remain disabled. */
-		raw_spin_unlock_irqrestore_rcu_node(my_rnp, flags);
+		raw_spin_unlock_rcu_node(my_rnp); /* irqs remain disabled. */
 	}
+	local_irq_restore(flags);
 	if (needwake)
 		rcu_gp_kthread_wake();
 	lockdep_assert_irqs_enabled();
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index b2c3145c4c13..1d5c03c5c702 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -532,9 +532,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	// 2. Both of these conditions are met:
 	//    a. The bypass list previously had only lazy CBs, and:
 	//    b. The new CB is non-lazy.
-	if (ncbs && (!bypass_is_lazy || lazy)) {
-		local_irq_restore(flags);
-	} else {
+	if (!ncbs || (bypass_is_lazy && !lazy)) {
 		// No-CBs GP kthread might be indefinitely asleep, if so, wake.
 		rcu_nocb_lock(rdp); // Rare during call_rcu() flood.
 		if (!rcu_segcblist_pend_cbs(&rdp->cblist)) {
@@ -544,7 +542,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 		} else {
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("FirstBQnoWake"));
-			rcu_nocb_unlock_irqrestore(rdp, flags);
+			rcu_nocb_unlock(rdp);
 		}
 	}
 	return true; // Callback already enqueued.
@@ -570,7 +568,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	// If we are being polled or there is no kthread, just leave.
 	t = READ_ONCE(rdp->nocb_gp_kthread);
 	if (rcu_nocb_poll || !t) {
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+		rcu_nocb_unlock(rdp);
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 				    TPS("WakeNotPoll"));
 		return;
@@ -583,17 +581,17 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 		rdp->qlen_last_fqs_check = len;
 		// Only lazy CBs in bypass list
 		if (lazy_len && bypass_len == lazy_len) {
-			rcu_nocb_unlock_irqrestore(rdp, flags);
+			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
 					   TPS("WakeLazy"));
 		} else if (!irqs_disabled_flags(flags)) {
 			/* ... if queue was empty ... */
-			rcu_nocb_unlock_irqrestore(rdp, flags);
+			rcu_nocb_unlock(rdp);
 			wake_nocb_gp(rdp, false);
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("WakeEmpty"));
 		} else {
-			rcu_nocb_unlock_irqrestore(rdp, flags);
+			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE,
 					   TPS("WakeEmptyIsDeferred"));
 		}
@@ -611,15 +609,15 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 		if ((rdp->nocb_cb_sleep ||
 		     !rcu_segcblist_ready_cbs(&rdp->cblist)) &&
 		    !timer_pending(&rdp->nocb_timer)) {
-			rcu_nocb_unlock_irqrestore(rdp, flags);
+			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_FORCE,
 					   TPS("WakeOvfIsDeferred"));
 		} else {
-			rcu_nocb_unlock_irqrestore(rdp, flags);
+			rcu_nocb_unlock(rdp);
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
 		}
 	} else {
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+		rcu_nocb_unlock(rdp);
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
 	}
 }
-- 
2.43.0


