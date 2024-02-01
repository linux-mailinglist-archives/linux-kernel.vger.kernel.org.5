Return-Path: <linux-kernel+bounces-47510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B708A844ECA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6711C203BD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D15F1F60F;
	Thu,  1 Feb 2024 01:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUvovgep"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8794FBE7;
	Thu,  1 Feb 2024 01:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706751740; cv=none; b=QPqyCbRroOYylcHDPSjL4+F6i7FiyHy6ZzMybEg6fsRVMeHmYpZsFN+8mfjpEnZeECdOh+qHdaazz8S4x+yss9p41Wp35EWXMQ1ZGNOK16UtKLBEcozYOOuy1Zmnhn2nBXqzxHBhtJd8XfbFJ4jiqFEIxtrmH19+3R+AHQrue1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706751740; c=relaxed/simple;
	bh=vN+b/ifMf2GpJznfNVNFzi7NjJGu81cMQy2PppVHW9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBV1ECOF8yKYSFv0/BxpOMbQRzxy46hUUMt/b1SrH9XkRKg5DZTVV4gSQr/Rlz/s1NLlN00iMa7Rvma43piwlda2ODSko/hPujz1Oa4o/UK82RpuPMGK+n7s41QEyrj7sVa8jltoeEiZgd1mTzEyP4E1M2PfnTzvu78Z/QVRZto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUvovgep; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-783f27300b1so25369385a.1;
        Wed, 31 Jan 2024 17:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706751737; x=1707356537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HkR3gzB832b3FW96NlBLB1xXylKJv2Axeh5KafyCU8E=;
        b=DUvovgep9E9pgBwh78jqlcgwESoSlQmrkW6esP7dXciXNMwMH+7oNhoL5dH6OoKm8O
         dNwG1rnje4peYgTqMtn/h3k2U4G8tQOykEoMSrZ4Km/GLWrvEd9KQS83GjYEa3cmS4/T
         VJEhvAETw5i6IFPkKosKSgvp1gsKC5s8d5bJHjIz3/4t4lw7qpzjA4agkcz2+9RnL8Uv
         G+xCZtiYWlQnlw4U9D+xXzwKWBaMCza/LeWYK5xEHfasBbTE8VTNWvHa5WlKJSOkWaBd
         ocCrntCV8pkZ/g5tsq/rF4RvKCvyZT2qqLVoYl/fRMXDa2gwUfvpf57wGrInI8W5iyZ7
         7ykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706751737; x=1707356537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HkR3gzB832b3FW96NlBLB1xXylKJv2Axeh5KafyCU8E=;
        b=Qrhzb4D7IGXlIPhWAG2K3FSEGn5zRY0mXyUeQr14odkhLPTWnqrDeBX+yhGauLF1Ij
         Kb3CSvGf7IVaWshj/JdJnYdnbdeSs1VTCvnFkeb87WKtpgjsctxMudJQNmNbcaKkh1Qz
         91PrZ5Ts2fGQR6QaxFSGu8lkjYmySe3amdeWonxRas9PF30JnR6mCN7ttjHDAA4qm9yf
         55R2UaOpZVXbsbkgU5CJLBquSzQbnE0SMfNc93bZ2kanQr3O4+pcm9yvS1kjBjvKI5sJ
         lPxtvcmOOdxKxZVJFqFVcBjmpjyr4iExisngzDNxABX3UjA0JqvyAhq+maHeZq4hKarQ
         yefQ==
X-Gm-Message-State: AOJu0YyLndnOdGRbwref6tAcFBVtAOmglcLCVtyY4+RlJsu3aUhvuXKL
	jPvjyXyZY+rvJjmo/Xouy3N5+xN23hi68ddLII3gO991vDSiLSP/
X-Google-Smtp-Source: AGHT+IHN0DKmr04jB8Sfqo23EfmK7Ir1HrkOhBMZpNw7emhEOlxsTJPat1oMsnvXTApc9asZZBrsvQ==
X-Received: by 2002:a05:6214:20ea:b0:68c:7aab:696f with SMTP id 10-20020a05621420ea00b0068c7aab696fmr637624qvk.56.1706751737591;
        Wed, 31 Jan 2024 17:42:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX3uAeKx2NmzGlq4BnurQEwL6ItQoP/F3SbwkDACvEGgNeBwQxAo/QKhyoFI2JF9X77wB3dAdO9A3VSv83pA7F1yVKeMe0wXdAYcd2PLRm+Qr+PCLG3AQHrT5d6AigUqPpX3UyTI6OvKEkqaSS5H9YoTcES8XCDZqcwop9PID5rNq9NKzIUPOII3c0vnnIWDtMATMFe4ymughYaqyIpqi9LAJbeV289cLo21MZuCnDvpvWVGiE5ICi3b8pkicsrBHAAQNw3tdK8+Q/S7B9rn2jpdmRf79mnUPCqoWzEfZCdaYBl4uzx/+LNgSWuS2IolvrynmESZvtL5ER0ZrpyudDO6rPBYcxz8vcU6KYrcZeopiahm+XO6V4z2p86dT5Q
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id eo10-20020ad4594a000000b0068179afede6sm3263621qvb.100.2024.01.31.17.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 17:42:17 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 84C091200043;
	Wed, 31 Jan 2024 20:42:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 31 Jan 2024 20:42:16 -0500
X-ME-Sender: <xms:-Pa6Ze27eoXbKGx3vCLQbiDHauN4R8AkKmjUgDLvgjxojSLT9Vu6Rw>
    <xme:-Pa6ZREOiybRwOgv93cTesQBM1kJyr6IIoEBlZwrvxhFC6AnwATXrQrjbED9xwsZ8
    PG3_9hJEvZXJuPKyg>
X-ME-Received: <xmr:-Pa6ZW6b5ATbjrPajYf8ZNfPRdOgIGsXvMeR_OV4WzNV4AGN4npKCzXXmxDDwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepheffieehhefhveehhfelfeejtdeitdejhfevkeefjeeiudegkeekueeu
    hfeiveeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:-Pa6Zf1tRmv3c1iY9x7YCAr_ipyW2FIl2qzc--pXEeBwigv8qEvssQ>
    <xmx:-Pa6ZRHnTfuFDFjguemNklxQRgxb5HKtEN2Hs3xnckz-Wv5f7xExpg>
    <xmx:-Pa6ZY9EV0BA386Hi3if94yihL1G5XBZxjgq7v4kPQSUDYQzSTOUHg>
    <xmx:-Pa6ZQ-ZE_TnBmEqWx_XAGL2NrPFkFAIOBKMZuGTL4swDmCWMi0qo5SvKhU>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jan 2024 20:42:15 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH 4/6] rcu/nocb: Re-arrange call_rcu() NOCB specific code
Date: Wed, 31 Jan 2024 17:40:56 -0800
Message-ID: <20240201014100.3204532-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201014100.3204532-1-boqun.feng@gmail.com>
References: <20240201014100.3204532-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

Currently the call_rcu() function interleaves NOCB and !NOCB enqueue
code in a complicated way such that:

* The bypass enqueue code may or may not have enqueued and may or may
  not have locked the ->nocb_lock. Everything that follows is in a
  Schrödinger locking state for the unwary reviewer's eyes.

* The was_alldone is always set but only used in NOCB related code.

* The NOCB wake up is distantly related to the locking hopefully
  performed by the bypass enqueue code that did not enqueue on the
  bypass list.

Unconfuse the whole and gather NOCB and !NOCB specific enqueue code to
their own functions.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree.c      | 44 +++++++++++++++++++-----------------------
 kernel/rcu/tree.h      |  9 ++++-----
 kernel/rcu/tree_nocb.h | 18 ++++++++++++++---
 3 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a402dc4e9a9c..cc0e169e299a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2597,12 +2597,26 @@ static int __init rcu_spawn_core_kthreads(void)
 	return 0;
 }
 
+static void rcutree_enqueue(struct rcu_data *rdp, struct rcu_head *head, rcu_callback_t func)
+{
+	rcu_segcblist_enqueue(&rdp->cblist, head);
+	if (__is_kvfree_rcu_offset((unsigned long)func))
+		trace_rcu_kvfree_callback(rcu_state.name, head,
+					 (unsigned long)func,
+					 rcu_segcblist_n_cbs(&rdp->cblist));
+	else
+		trace_rcu_callback(rcu_state.name, head,
+				   rcu_segcblist_n_cbs(&rdp->cblist));
+	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
+}
+
 /*
  * Handle any core-RCU processing required by a call_rcu() invocation.
  */
-static void __call_rcu_core(struct rcu_data *rdp, struct rcu_head *head,
-			    unsigned long flags)
+static void call_rcu_core(struct rcu_data *rdp, struct rcu_head *head,
+			  rcu_callback_t func, unsigned long flags)
 {
+	rcutree_enqueue(rdp, head, func);
 	/*
 	 * If called from an extended quiescent state, invoke the RCU
 	 * core in order to force a re-evaluation of RCU's idleness.
@@ -2698,7 +2712,6 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 	unsigned long flags;
 	bool lazy;
 	struct rcu_data *rdp;
-	bool was_alldone;
 
 	/* Misaligned rcu_head! */
 	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
@@ -2735,28 +2748,11 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 	}
 
 	check_cb_ovld(rdp);
-	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy)) {
-		local_irq_restore(flags);
-		return; // Enqueued onto ->nocb_bypass, so just leave.
-	}
-	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
-	rcu_segcblist_enqueue(&rdp->cblist, head);
-	if (__is_kvfree_rcu_offset((unsigned long)func))
-		trace_rcu_kvfree_callback(rcu_state.name, head,
-					 (unsigned long)func,
-					 rcu_segcblist_n_cbs(&rdp->cblist));
-	else
-		trace_rcu_callback(rcu_state.name, head,
-				   rcu_segcblist_n_cbs(&rdp->cblist));
-
-	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
 
-	/* Go handle any RCU core processing required. */
-	if (unlikely(rcu_rdp_is_offloaded(rdp))) {
-		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
-	} else {
-		__call_rcu_core(rdp, head, flags);
-	}
+	if (unlikely(rcu_rdp_is_offloaded(rdp)))
+		call_rcu_nocb(rdp, head, func, flags, lazy);
+	else
+		call_rcu_core(rdp, head, func, flags);
 	local_irq_restore(flags);
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index e9821a8422db..bf478da89a8f 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -467,11 +467,10 @@ static void rcu_init_one_nocb(struct rcu_node *rnp);
 static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j, bool lazy);
-static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				bool *was_alldone, unsigned long flags,
-				bool lazy);
-static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
-				 unsigned long flags);
+static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
+			  rcu_callback_t func, unsigned long flags, bool lazy);
+static void __maybe_unused __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
+						unsigned long flags);
 static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level);
 static bool do_nocb_deferred_wakeup(struct rcu_data *rdp);
 static void rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp);
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 1d5c03c5c702..9e8052ba14b9 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -622,6 +622,18 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	}
 }
 
+static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
+			  rcu_callback_t func, unsigned long flags, bool lazy)
+{
+	bool was_alldone;
+
+	if (!rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy)) {
+		/* Not enqueued on bypass but locked, do regular enqueue */
+		rcutree_enqueue(rdp, head, func);
+		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
+	}
+}
+
 static int nocb_gp_toggle_rdp(struct rcu_data *rdp,
 			       bool *wake_state)
 {
@@ -1764,10 +1776,10 @@ static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	return true;
 }
 
-static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				bool *was_alldone, unsigned long flags, bool lazy)
+static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
+			  rcu_callback_t func, unsigned long flags, bool lazy)
 {
-	return false;
+	WARN_ON_ONCE(1);  /* Should be dead code! */
 }
 
 static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
-- 
2.43.0


