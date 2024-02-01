Return-Path: <linux-kernel+bounces-47512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CFB844ECC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4AA91F2E2FA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADB433CD2;
	Thu,  1 Feb 2024 01:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuLWh71B"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B3F4C7B;
	Thu,  1 Feb 2024 01:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706751743; cv=none; b=NVJGuMpcfFDwA6F7NnNYay3crQGsqyTHpDXLi3JkZW/EBFYrT7eO1aHCi5jULXv9zaDEZq5Pr80qeOJMmQfA9I92BGGHQxIvePfVjpX59vcyIYu5Jxm2QhPxHK8iKPDH+PkYu37BciMNYD47EfrMTOdWPjnbElKrJLgk+WOylRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706751743; c=relaxed/simple;
	bh=6oMVGx/JwGgsizKVfPO1lHIPkL1xgjV9NuMQhjvciWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tudURNa+bwSd/RYoc8m1Aer1fBOD6WtfD9FARAGJ32yVWeR2HYTbEG/RTACr+yteeqP7ZpC8ZgXD860HTyn5mpQaOf43jifIw0o3utbzPpKMQUb3Lnzf+wi6Ve2LGrcndr9tFPi9tRBvFrpVgZlmXuZtsD7mr+3jnKrBV0vqff8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuLWh71B; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-783ced12f9bso19792585a.3;
        Wed, 31 Jan 2024 17:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706751740; x=1707356540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4WRKA+8oB7qFwtR1n75bKmIl1ybu1sGsFv65Z7DNMuk=;
        b=ZuLWh71BL1EJNOFSk/gid87c2vx7R3bxoiGdyL8PffH0ma/Utl7wwCbs0PoXeed9X5
         +wE0iMkAyMv2A7yysekrh88dGErbyN7rlV9/UZc868cRe74aYPxKswDl+LsvMU4FY62+
         MzcIlBLHbwuK0KcWOpWqbGle/qniXSoNZfQNX+8Rxw8yRADYaLNxbSWjN9yi38euSb0E
         MTgqxvu5Y9GTu3y31KssoK3YBqQLnSLVZtKTdC2jH2ORUl7Bs0wfAD6IjACaOUh8G7bo
         TsoUZjC50SHX66/JE82hoZZA4UKSiWJCOOKwt29gqdECLI0KQDh/7sWNEaEXkR7RlTHT
         R34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706751740; x=1707356540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4WRKA+8oB7qFwtR1n75bKmIl1ybu1sGsFv65Z7DNMuk=;
        b=U8fb9UNf1hCOxXDd5X2KDpAoZJT2WaRcY8QJYIKyhaUQLJshAzgSraDz+86URiMvF4
         ffZRCsA+thjJUr+n0si6AIOsy0pbk5haI6x/2koXaYSdB8f8z8Pgh70K14YRGXb6LBtl
         6JWiiMlHakn03rV9CHbnJY8bgqTndXeApNmF6A9o1zUrYkqw3GdRdV0To4Pm/dZEEZgy
         gRh6FykbyNvPzJhwcntBl/fXrI3Tn8rMFEzG9c+jdm2DWGScd0U19eCf3l56tYMs7JEF
         kvBZJJL7BJYIgh4M91U0WUgVhUM8z/3tMKTC9oB6OX0+ddriUEC+O/xpanaqhLHP4vVj
         9HXg==
X-Gm-Message-State: AOJu0Yzltku3mK5WOrUL2olSJmBK50Ed1ah8qEFzxEKbdAnccuVF4NQM
	HxLp2p9cRRrYGMCVtsdgmPEq2TrizdsoAGrSYcegbYfCBOr2JVPuy2qOXRpn
X-Google-Smtp-Source: AGHT+IH7gXEnhRV6dQ/hlBl1ymm90ftsMLEZXl2lXUDTf5mMK0KACFhC6A6WDgvulzQq3n9XQg8mjw==
X-Received: by 2002:a05:620a:124c:b0:783:4a89:f1d9 with SMTP id a12-20020a05620a124c00b007834a89f1d9mr1233836qkl.59.1706751740697;
        Wed, 31 Jan 2024 17:42:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWHG9KQtwYecuVAw3zxj3CBVPr63QVPiot25Ti3U39+yLxoXmX2tiyTEzAMYm2wos+U1uG/a36SWyhSXx0T+NMz0XuoixOz4zXYn5QMYtMo8DQ4xhy1OYv1U2EyWVgWItmvawjkFZMDd822hmOW/ZBcZ/Jho9XnKLij7ig8pGhCnA0BVGlqKr9bF/LAEq7cffAh1q4siV6BVIttYaBaO3yGpyLnd92oFQ1z3rwwN5OXA5erZ8afTzxG+DS9KoWAplGRveeVz2MY4/p1XQ7w6RHbfPMZKlkRwpS1ktIiWZeMThX0t10Mp4k3K8fC/AMFVHncaHXI6k+ApnZkS7nXhRyYiccemfoIxRslq0PxKIwc5kJvDFNf8L4q
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id qp15-20020a05620a388f00b007840843f3b2sm2079154qkn.18.2024.01.31.17.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 17:42:20 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id E1BC627C005B;
	Wed, 31 Jan 2024 20:42:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 31 Jan 2024 20:42:19 -0500
X-ME-Sender: <xms:-_a6ZTyunmMp5e08Hf8LadfDVCQLdRrvUlxBOxCRTbySy_DXySaVmA>
    <xme:-_a6ZbQzYOqNvPN7I1Vqu1EIwvJUWIsfDkS8FJtgRG68aJ86f8V9Sv4KvpMaFMBK7
    rzRhICL_aPr_9rp-g>
X-ME-Received: <xmr:-_a6ZdUTuvKRA0CNcsZPiRr1qJ31YqWSfQIEt1tJCvd8tVz9-6PlBEbcgtgVkA>
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
X-ME-Proxy: <xmx:-_a6Zdg7S8pGxEosGJb_EvN7056T2qoi79vujCfAV1Bx4Pl3mN1l5A>
    <xmx:-_a6ZVBPMHHLG0AMgakkTFCJ40FO56HrFq7DLoP4OwveBDcDYPpcCg>
    <xmx:-_a6ZWJBepdoeyf33FADW32vZFjKIWnvHvZvbiY-lqpq1hJAgAxk3g>
    <xmx:-_a6ZaJwiwlPuyGFbBDN4Qnq3jWhBhXBta6xgytUXv6H4j-wIPTTUQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jan 2024 20:42:19 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Zqiang <qiang.zhang1211@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 6/6] rcu/nocb: Check rdp_gp->nocb_timer in __call_rcu_nocb_wake()
Date: Wed, 31 Jan 2024 17:40:58 -0800
Message-ID: <20240201014100.3204532-7-boqun.feng@gmail.com>
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

From: Zqiang <qiang.zhang1211@gmail.com>

Currently, only rdp_gp->nocb_timer is used, for nocb_timer of
no-rdp_gp structure, the timer_pending() is always return false,
this commit therefore need to check rdp_gp->nocb_timer in
__call_rcu_nocb_wake().

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree_nocb.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index ffa69a5e18f4..f124d4d45ce6 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -564,6 +564,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	long lazy_len;
 	long len;
 	struct task_struct *t;
+	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
 	// If we are being polled or there is no kthread, just leave.
 	t = READ_ONCE(rdp->nocb_gp_kthread);
@@ -608,7 +609,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 		smp_mb(); /* Enqueue before timer_pending(). */
 		if ((rdp->nocb_cb_sleep ||
 		     !rcu_segcblist_ready_cbs(&rdp->cblist)) &&
-		    !timer_pending(&rdp->nocb_timer)) {
+		    !timer_pending(&rdp_gp->nocb_timer)) {
 			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_FORCE,
 					   TPS("WakeOvfIsDeferred"));
-- 
2.43.0


