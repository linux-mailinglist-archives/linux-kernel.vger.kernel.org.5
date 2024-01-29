Return-Path: <linux-kernel+bounces-43650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84477841732
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD2A1F23A23
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358A315A4A8;
	Mon, 29 Jan 2024 23:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6pR7WPz"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C59158D94;
	Mon, 29 Jan 2024 23:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706572680; cv=none; b=Jymk7o51BRpSAK13APkRroXrKibgjoOXzQ7wII4vnMM6b5tmsfM1ZcgjYuuqF0EDJbYgqqLMMoSaNkO5sCUAOpGAhu88a2cHqtpvbWiMn9zgEzf2vV6Ipg7sr4PQQ0hT/PJJJ0gZkNksC4MdIp6qz3+OeA2Z2aaE1lEhITcpbsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706572680; c=relaxed/simple;
	bh=x4rWy8OUETkNlzFEzr6NIkNqmDoTQCdrQZsaAqoy+zU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpFqKb267RAIFD82t/2FflPAARO30lY6k9yxSI2+4MUNPgiucj91KYkYBn9FXpiPJhaaX5C5NcbSBIm6uompKXB8m8A9ae9aJucLdkpGPjbaNmm9HjhGF6UNzTjqjJnfCQPiSiS4mLf0LGxToFBSW4qEo32R7U3hm6LSrCng1WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6pR7WPz; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6869233d472so24254216d6.2;
        Mon, 29 Jan 2024 15:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706572677; x=1707177477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XfL5WwGMhj/ImvO6wNigXH+D8VkwvyNFv3VgYG/ds+o=;
        b=A6pR7WPzlck1pspgVv1drpRNfspLOEwl5p2HnePu/AuGgzpLc//drMrvqz7tbYtaQk
         3pSx4VrLm6oN26D5gHZdzgSrnhGKSGwkD7QP06gKb1aurL9XfVl9bJCaeHXrmeSoIk3s
         YK/SOdTJBNU/d0KXsjNIRryFdWyffNw/Id46tkF2EAURmT1LOuMnrMzQlBtgLyejnvxr
         qQizVUAkrHFWjSBPGT9p2hlSDiVscLagckHagvaIztkJDXQb3TKfjjxz9pzX7+GuuNPl
         vMQK5pZkCr598idAljr3Hzkj2onuxwXDp71mlDMTEc37EiBF5GRwzBD6z/aTeZbriLgP
         ejNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706572677; x=1707177477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XfL5WwGMhj/ImvO6wNigXH+D8VkwvyNFv3VgYG/ds+o=;
        b=ZUOi5YFH/Kul/r2ILu03UotJ7Y+CmcxJdyJGWY/9WtBHTL3NSMgmVtrZL2eCJd//bF
         2CzBGYlPgeD5TbQ0oulFUYFwYki22uBQw9EfxOEO3p5rZd5Cl/+D6nrF4SS7c9BRrx8U
         959fiWKYytncA8xeDXtFUqbwv0OSNwP3d55FfQgpSpfh+flk0K0DR639NtYZ55sQwWhA
         Xo0RtvpdnZfwDOdtXUYwdpgS/ZjRGATIwstKbDh7p5ndstWMG0H6v5H/JU2LOVzGUX4J
         17HFjYP8m5fBAMlXPJjLlulDXBmvy9B0SICigyxuIw8d98gm0oNUKp5WnqOMRFeNntFJ
         8wEQ==
X-Gm-Message-State: AOJu0YxDd2s+somAeuRukhn1uSpCxHOI5WEkBnYsDsS2VjVtBfvS+hR8
	2krhiphlE6lArnJ4OmkiuunoJ+iji8TbDF1LM2eoOmr/NLI2Qqzq
X-Google-Smtp-Source: AGHT+IH6T12QbtD4JChvjXOCma+XKYGlX2o9MPQ4OL0uyG0v1+0eyFixIIx0uIM4n3aRpjG5oocj/A==
X-Received: by 2002:a05:6214:21c4:b0:68c:4655:4286 with SMTP id d4-20020a05621421c400b0068c46554286mr5777799qvh.113.1706572677489;
        Mon, 29 Jan 2024 15:57:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWHTr8dzq3U9iBHAWluTgHSGNA+h9hOjNbIu//OhRipmK/iFc9+7II4FBC+Tya/K+9BXVFHGmmNZ24wlRxD7fF8ogQyE66rKQubcgSYzqhjuMepWjAfj8BXx8qWq6tA96c8npVchyMZBf+K9+nZlGeTazKBuGa/X8gZFI7TDLokvLcl7KC+4AOiYW9dXmhotFMHsdkJCcdh252Qvm20MgDrOYnfgftPxaUhKhrGGKG/LnN9eZ3j34mMK400ijtST/TgoSz6JusOPPr1m6Rq8Q5GZBNLcQTd7lxCFbf06kFTa/uDlgbpW8mDCw==
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id h6-20020ad45446000000b00686a51526fbsm3882471qvt.110.2024.01.29.15.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 15:57:57 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailauth.nyi.internal (Postfix) with ESMTP id CBAE227C0061;
	Mon, 29 Jan 2024 18:57:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 29 Jan 2024 18:57:56 -0500
X-ME-Sender: <xms:hDu4ZVJ-EuZ4uHm12DSW4OFChaPHX_X0pi-0VGSqmyLMZK-dkWnHaA>
    <xme:hDu4ZRKR62okQBHetC3JNM1zygqS0sPHF0Dc-vrOPDCMzM5PipfBJWVF7auw09vB0
    ZGwtjPjq1Ju2JoUdA>
X-ME-Received: <xmr:hDu4ZdtIm3rKMkRP4gUUkUgR4483xjMZTlpidS7akd8QiCch09-Qk2VNh5XTjA>
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
X-ME-Proxy: <xmx:hDu4ZWYzWhDtm-Rn3UyKk5uLSw6TnEzveHfdfxstyMKT0f023-KPQw>
    <xmx:hDu4ZcZK4RJD_N_fvBTishfiAmnIK9YWP-lWGss-GgHyjgv7c7Rmmg>
    <xmx:hDu4ZaBWiZbrGPrLO05T_IUgPsvRQ1cEquqBCI4QU3LUqVyfQYQ1AA>
    <xmx:hDu4Zan5moJc9eJ3hHiIwcnECS-z6cz4-96VNeEr_sfWfKLHg-bWdA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 18:57:56 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 4/8] srcu: Improve comments about acceleration leak
Date: Mon, 29 Jan 2024 15:56:37 -0800
Message-ID: <20240129235646.3171983-5-boqun.feng@gmail.com>
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

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

The comments added in commit 1ef990c4b36b ("srcu: No need to
advance/accelerate if no callback enqueued") are a bit confusing.
The comments are describing a scenario for code that was moved and is
no longer the way it was (snapshot after advancing). Improve the code
comments to reflect this and also document why acceleration can never
fail.

Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 0351a4e83529..e4d673fc30f4 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1234,11 +1234,20 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	if (rhp)
 		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
 	/*
-	 * The snapshot for acceleration must be taken _before_ the read of the
-	 * current gp sequence used for advancing, otherwise advancing may fail
-	 * and acceleration may then fail too.
+	 * It's crucial to capture the snapshot 's' for acceleration before
+	 * reading the current gp_seq that is used for advancing. This is
+	 * essential because if the acceleration snapshot is taken after a
+	 * failed advancement attempt, there's a risk that a grace period may
+	 * conclude and a new one may start in the interim. If the snapshot is
+	 * captured after this sequence of events, the acceleration snapshot 's'
+	 * could be excessively advanced, leading to acceleration failure.
+	 * In such a scenario, an 'acceleration leak' can occur, where new
+	 * callbacks become indefinitely stuck in the RCU_NEXT_TAIL segment.
+	 * Also note that encountering advancing failures is a normal
+	 * occurrence when the grace period for RCU_WAIT_TAIL is in progress.
 	 *
-	 * This could happen if:
+	 * To see this, consider the following events which occur if
+	 * rcu_seq_snap() were to be called after advance:
 	 *
 	 *  1) The RCU_WAIT_TAIL segment has callbacks (gp_num = X + 4) and the
 	 *     RCU_NEXT_READY_TAIL also has callbacks (gp_num = X + 8).
@@ -1264,6 +1273,13 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	if (rhp) {
 		rcu_segcblist_advance(&sdp->srcu_cblist,
 				      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
+		/*
+		 * Acceleration can never fail because the base current gp_seq
+		 * used for acceleration is <= the value of gp_seq used for
+		 * advancing. This means that RCU_NEXT_TAIL segment will
+		 * always be able to be emptied by the acceleration into the
+		 * RCU_NEXT_READY_TAIL or RCU_WAIT_TAIL segments.
+		 */
 		WARN_ON_ONCE(!rcu_segcblist_accelerate(&sdp->srcu_cblist, s));
 	}
 	if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
-- 
2.43.0


