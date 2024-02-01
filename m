Return-Path: <linux-kernel+bounces-47508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 205DB844EC8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5D128BD7B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F458D281;
	Thu,  1 Feb 2024 01:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hv+ft3aY"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5195255;
	Thu,  1 Feb 2024 01:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706751736; cv=none; b=HrVu/gbVvO74T15ThLIowdFrCIQ8pKGl0NSfYHWSqq1JvVLG2IBF1w4mauCO5yVy//MUhq4hB2cBexA95/a/Mp0rOUGpsImz8gU+rHfgTsdU+892zvtRHm9ek/2jbCUFavDxNFLDndGTgyOmECQa0+urUMFihiazbY1ONlRIBoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706751736; c=relaxed/simple;
	bh=pSSj7EvIHKtcO8CNxnXkeBO80f/T+be+cHyUt2QsZkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNbExlc3auSM7UhfiIfLHe/Wt93ez3p3MwiTz+jcGVtbTUzcyPeS+PyJHJiuBADwJi0pf+oledVSvph08oHeFgoRTqnPHg+jF+2sYLRZdENNMYAowHfFP1gDuAxoAL6e0ff/mDfhovN2KhL3FkmjxYY3raHWSWEM9nhl8IcJwOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hv+ft3aY; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42a99f34cc8so2367231cf.2;
        Wed, 31 Jan 2024 17:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706751733; x=1707356533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p4HlLJA6ewOwBM3r/aagQRFX9+hzF0ZwosHf3q2R4gw=;
        b=hv+ft3aYUzIpq6tWxxvhor34MCO+ATd6ORApMYmwOMfN6IHrGPz9g+QGKQ0ibUUmWf
         aEnUvZYs4fkKFrsicTlHd6WW8nAuXVXbEdJ+qv0iAXj9+8i9K87jTMkpvGtH8YCCj7hk
         66byqc6tYj72H9mz9wYTz1+cWnuqWVK+mPVGOoT5JTB1RoKC3V+tPeQObG6Z8j49leIr
         Ir+II3ndh3TDfYY+4y5MafXPIhzA0nGT/kdFk9kiPHeiBPxfocNgJjsQ4xG8KBDmiDkI
         DP0qWUUiwceLl02pPB2LWG2Y63QmSZcyA6t9d734tr0++Xv1Jhx9Zw2wYjAahx586ji9
         kHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706751733; x=1707356533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p4HlLJA6ewOwBM3r/aagQRFX9+hzF0ZwosHf3q2R4gw=;
        b=EHsreN1XVT87/jeKPPqs4eRihJKB6tN+X8ewsJes/Qr5tuuwxB2QKvzhAiAbu3qsje
         fOMzHQNcpzwZj/7zuWCsC9ny5YyCpPEcHmzx/MXsVu/KRzO05TDvwtVFOI5jqaio90Rv
         +sNIAFBSVjahp9mA0dBONpOk5xPlAE0UevGwc3yGxOG52NziLjgYRX19aokKgDeclNkM
         ZiBgQKR15+iIU0ir63TrOHFvFSBQWIn9NF0bJbFgizI57V7qXLpvG9DW9TwVYqSxdC17
         kO4BDNurLHUfXeCYNMRVxTcsi22EdaG2nVXN6T1ynwaykl/1gVBefdhqpgGuYacCUWf6
         9mGw==
X-Gm-Message-State: AOJu0YwlHYab+2tivuV12uOILRNmLijDm8/u2cApb4TB8LOadAEruMFF
	HkPV64cHwAcWrNWczjYQKpoN5VIg0WIJgD3ELSQszwVkVrHxFkxA
X-Google-Smtp-Source: AGHT+IHR2I14AziyvzHaxK+XQyZBT4pd6y+PWW9W4yxucjAybiYJy8TRkriFTnLC2wJ0575mM3SFXw==
X-Received: by 2002:ac8:5795:0:b0:42a:a934:1f4c with SMTP id v21-20020ac85795000000b0042aa9341f4cmr1433192qta.2.1706751733703;
        Wed, 31 Jan 2024 17:42:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXD5i1//U9u8ubT2vzi0K2o+/GwzeSTAQDt4PPCY2iGVlZvaeJzwvA34bwkEtmcQoMOulFFSQdo9AD4Y/ZpmEHbfvf7mb9DFbXm5iGTLa+ZqJze9TZ87NASpoXm26/h30XAyDauZldtN8u51C0sdQe4lkp5HFIyiYP07OpR7boPbMxcPqxXbTORJ0tnPUgwZkZZ3WIl5SCBwjLCM0NEA8mKiKQZKcAiF+J6o3sX9SxmZ0Br0zS2qnpXJ/dt23lJtos2fRlTDlJDclZrhbr9PA7E+LmSYtBwJSyNV3wZYBV91/r/cYwcLJ1E4rIIpSl/YR24UWwstvBtpL6ZRdBAAqwE6a7QhL6qjAl+kadWlIlJdpZlXufQiME1Tg09ektM
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id fv6-20020a05622a4a0600b00429be14d3bbsm3638748qtb.13.2024.01.31.17.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 17:42:13 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailauth.nyi.internal (Postfix) with ESMTP id E295F27C005B;
	Wed, 31 Jan 2024 20:42:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 31 Jan 2024 20:42:12 -0500
X-ME-Sender: <xms:9Pa6ZSxnpnvs48JuwLqZfHLdFmNhIUsniDnUakCfUllj6OhYMqLmQQ>
    <xme:9Pa6ZeSREbNPSazECbf1hzlYtS4ommnd1Auh6EeuAXxrkEQp9xZ2JSH-9UgiBuqnr
    lg6Ri4AUuPM5V1yEA>
X-ME-Received: <xmr:9Pa6ZUVOHjXnsOFok4ymA3xIXBxpCccsD5egelcJliSVtkjDpaODk_QVMSLuMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:9Pa6ZYi9uBqzGVwm1NlrCswldozgdKFCYUCP2C_86zFJ6WgE0HETMw>
    <xmx:9Pa6ZUCnlECWbG4dY7jsjd1P320DDUXn6ylobJQ9VXpL_Z_5ovf4UQ>
    <xmx:9Pa6ZZJSdT1f1_itsFFNJt0VAqMP4Jb17JB7FplDfPM_pFggC3PpWA>
    <xmx:9Pa6ZdItLe50fRICCrN-Ug1O6yKAp6f55XBz174RCPauPow_V-IGLQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jan 2024 20:42:11 -0500 (EST)
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
Subject: [PATCH 2/6] rcu/nocb: Remove needless full barrier after callback advancing
Date: Wed, 31 Jan 2024 17:40:54 -0800
Message-ID: <20240201014100.3204532-3-boqun.feng@gmail.com>
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

A full barrier is issued from nocb_gp_wait() upon callbacks advancing
to order grace period completion with callbacks execution.

However these two events are already ordered by the
smp_mb__after_unlock_lock() barrier within the call to
raw_spin_lock_rcu_node() that is necessary for callbacks advancing to
happen.

The following litmus test shows the kind of guarantee that this barrier
provides:

	C smp_mb__after_unlock_lock

	{}

	// rcu_gp_cleanup()
	P0(spinlock_t *rnp_lock, int *gpnum)
	{
		// Grace period cleanup increase gp sequence number
		spin_lock(rnp_lock);
		WRITE_ONCE(*gpnum, 1);
		spin_unlock(rnp_lock);
	}

	// nocb_gp_wait()
	P1(spinlock_t *rnp_lock, spinlock_t *nocb_lock, int *gpnum, int *cb_ready)
	{
		int r1;

		// Call rcu_advance_cbs() from nocb_gp_wait()
		spin_lock(nocb_lock);
		spin_lock(rnp_lock);
		smp_mb__after_unlock_lock();
		r1 = READ_ONCE(*gpnum);
		WRITE_ONCE(*cb_ready, 1);
		spin_unlock(rnp_lock);
		spin_unlock(nocb_lock);
	}

	// nocb_cb_wait()
	P2(spinlock_t *nocb_lock, int *cb_ready, int *cb_executed)
	{
		int r2;

		// rcu_do_batch() -> rcu_segcblist_extract_done_cbs()
		spin_lock(nocb_lock);
		r2 = READ_ONCE(*cb_ready);
		spin_unlock(nocb_lock);

		// Actual callback execution
		WRITE_ONCE(*cb_executed, 1);
	}

	P3(int *cb_executed, int *gpnum)
	{
		int r3;

		WRITE_ONCE(*cb_executed, 2);
		smp_mb();
		r3 = READ_ONCE(*gpnum);
	}

	exists (1:r1=1 /\ 2:r2=1 /\ cb_executed=2 /\ 3:r3=0) (* Bad outcome. *)

Here the bad outcome only occurs if the smp_mb__after_unlock_lock() is
removed. This barrier orders the grace period completion against
callbacks advancing and even later callbacks invocation, thanks to the
opportunistic propagation via the ->nocb_lock to nocb_cb_wait().

Therefore the smp_mb() placed after callbacks advancing can be safely
removed.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree.c      | 6 ++++++
 kernel/rcu/tree_nocb.h | 1 -
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b2bccfd37c38..d540d210e5c7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2145,6 +2145,12 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	 * Extract the list of ready callbacks, disabling IRQs to prevent
 	 * races with call_rcu() from interrupt handlers.  Leave the
 	 * callback counts, as rcu_barrier() needs to be conservative.
+	 *
+	 * Callbacks execution is fully ordered against preceding grace period
+	 * completion (materialized by rnp->gp_seq update) thanks to the
+	 * smp_mb__after_unlock_lock() upon node locking required for callbacks
+	 * advancing. In NOCB mode this ordering is then further relayed through
+	 * the nocb locking that protects both callbacks advancing and extraction.
 	 */
 	rcu_nocb_lock_irqsave(rdp, flags);
 	WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 785946834c6b..b2c3145c4c13 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -779,7 +779,6 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		if (rcu_segcblist_ready_cbs(&rdp->cblist)) {
 			needwake = rdp->nocb_cb_sleep;
 			WRITE_ONCE(rdp->nocb_cb_sleep, false);
-			smp_mb(); /* CB invocation -after- GP end. */
 		} else {
 			needwake = false;
 		}
-- 
2.43.0


