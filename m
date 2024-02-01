Return-Path: <linux-kernel+bounces-47507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 855F1844EC7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77EAF1C21712
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9425399;
	Thu,  1 Feb 2024 01:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoUBmB5/"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06AA443E;
	Thu,  1 Feb 2024 01:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706751734; cv=none; b=q/Vgdb62OOhhRPXen2cwqyMSwA33hNHO6dDT2ttt/izVBfMMJTHonFkx7rSTbFh5YqM7Dk35goRjryN98M6VBBJ36LhqHbyI/hs9E+rNtOm0IhMmucpqbd3+Xyw/xl0a1pMB5kRTXEf11CFXNWaG6wbmVFB2eS6q5VKI0xyJ0eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706751734; c=relaxed/simple;
	bh=JYMQcq8E1zGYMJ0i7nVikl7w2oNjNCpEj0nSc8NMMoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dm0FWI6r0KGjYGa1deE/wSgOfEWEMUM+po3Pg5tyE9CmVAf2ITqPeV4xPRMjTNDMv1DnX8tFsNkbOYqBumhwUChgNvna1v+wTkyNGFu5YSgMS//m9grFiQfGAtY0D37mOMJqwx4AlBSA0CEJc7UdIOZKwT/hmLrHeaZrwHJgBGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoUBmB5/; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6818a9fe380so2470446d6.2;
        Wed, 31 Jan 2024 17:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706751731; x=1707356531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zLJWc1KOEuIrLOS4qhIHcNcluYpoORRWU7wyfjkuepk=;
        b=VoUBmB5/NTIxGqwdwplE+GmmEsEDc2b4PLVocFyysIXCoTcVyuidpPnpUmJLuDS8rY
         KkEZpeM47JbigKSk1Z95LmgV/8xsbSI0GlfV9DGD2Gc66+LQwlo/8au/T6KepqOO56Lv
         vzlPzNo66u2vVMdCBXoQAqMwGuD1jBIlheBzchEjOJ9M2eOW7IZ9YotCAVrN0KpHrHmD
         koryuz7qn+g/OhMG/WOZfBi8XLmCiDkgWQhtIsnBT1PTwItossmRtbECoPNWZMHvsVFM
         ovT9ccqZvECnw73ughgvFQz47memrI0uUgaSroUKcCxMwcfoIURILB55/M/7MxllgnTg
         K6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706751731; x=1707356531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zLJWc1KOEuIrLOS4qhIHcNcluYpoORRWU7wyfjkuepk=;
        b=awoPAK5pSLUx81swMxemKimGPD3rWEo5xEf4n6vkCPc9eqm4lCf06a2nOAaH3FJ9XU
         eRNOy12SlcbOhimMD7DP11MeDNRE+owhupQAPeijg5gbMDvp37MBFU46ujIjRbLce2u9
         ugXq7Nmq7FSl06GTmjIkkhOWQT+oGngmMTDUhSYu8v8CE4vlfgE8dPurBY159aKapRmF
         nyKmOstW2PYY6hSwDUp9wOGTQvdVHJZzsXSPuORy1gmaHt6XMTEuAhOHyCQ340SFMfGB
         wdCpr5rljxU+VMNsAqOrXD/3s7JxCGepMAxHJtEANFciWCBEDp/uVos2nxvcKyhue/or
         ZlTg==
X-Gm-Message-State: AOJu0YwKS77FCzXQTFvI2aYDFnU+URRZ/esyLkAVEMV/eQKHdRfCwpp2
	AEBfK2P3Dsj8l06vPgHyfB5U44B+bfaoc7FoJFDvwQF6vBfXciBr
X-Google-Smtp-Source: AGHT+IFfdivcP9CfPPG+370KcqaFjtRQ/uxNHw9YiEyYwjl2DybCtI9N6qTerOdOTave++dQWIQJwg==
X-Received: by 2002:a0c:9a91:0:b0:68c:7a2f:1c0b with SMTP id y17-20020a0c9a91000000b0068c7a2f1c0bmr461906qvd.62.1706751731594;
        Wed, 31 Jan 2024 17:42:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUptm6AUOJltqfcS2AtCtlsJsb1yHlur08z+RnNtjG+RLixsXaPqKBfcIAfMkLUGEQRDMiOE+x5UtJKVII8pPqVKwzgwpxE4HpTJVl9f65F3Kvh+5puy/8pobwzkXOpTU+mE2IEu2YDSmhK2TSr4l3KcFwZ90Pj6nF/a50lL5X53tYcx3hCGl07UGR4dkvb22ZarKUiQaxOp/0civ0rzoFHo2hC+BCeL2K0w4aRuZhGkJV9fgvIzZxyqYLGeZweWkqkJSubiIJFhSfNWLOM6h8trZFPpTIoBRx7KzaigUXdXukNE3g3p8PYSeY96ZNz7hdrJqVkY75zerOko9dhV0GxE1iJr5Iza/r1fg11lxK2gtOqTnr+BNmTSjbtTP79
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id pc19-20020a056214489300b0068c6e9fa24asm1018586qvb.10.2024.01.31.17.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 17:42:11 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id D58CA27C005B;
	Wed, 31 Jan 2024 20:42:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 31 Jan 2024 20:42:10 -0500
X-ME-Sender: <xms:8va6ZZTgslyPnevGpS1HT2XqG9jUlcMJsBODriQ-48wWJ0q4CmPnCA>
    <xme:8va6ZSyzVNYzYJNJEn5lIB5Zoz5XccCxr0xOfI5kIDEdz5NV_BigKiFYtGzvT9Yff
    mx75R-Z3khbtzhVZw>
X-ME-Received: <xmr:8va6Ze0p-qZpOvLztvztWKxcZ_-NcK5RqriHbfkzgxSzHrVkuvdy6DrDRh31WQ>
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
X-ME-Proxy: <xmx:8va6ZRA0jkujjV8oYW4kkZuaNHFgZHSiotYZG0Eru4cT_6ynpX8NDg>
    <xmx:8va6ZShPVglAVowjo-TBt0qhAGBm0WHuv8m95EWliGCwldAaUQbSKQ>
    <xmx:8va6ZVpApK6EMMfPkuWmifRBsF4wY86yGbZVhuWBzJVfxJH_c38PeA>
    <xmx:8va6ZZodk8dwWR-zp-oDiBQHmgOOrta-xVfQUPWbkh8RafvDXM1OUw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jan 2024 20:42:10 -0500 (EST)
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
Subject: [PATCH 1/6] rcu/nocb: Remove needless LOAD-ACQUIRE
Date: Wed, 31 Jan 2024 17:40:53 -0800
Message-ID: <20240201014100.3204532-2-boqun.feng@gmail.com>
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

The LOAD-ACQUIRE access performed on rdp->nocb_cb_sleep advertizes
ordering callback execution against grace period completion. However
this is contradicted by the following:

* This LOAD-ACQUIRE doesn't pair with anything. The only counterpart
  barrier that can be found is the smp_mb() placed after callbacks
  advancing in nocb_gp_wait(). However the barrier is placed _after_
  ->nocb_cb_sleep write.

* Callbacks can be concurrently advanced between the LOAD-ACQUIRE on
  ->nocb_cb_sleep and the call to rcu_segcblist_extract_done_cbs() in
  rcu_do_batch(), making any ordering based on ->nocb_cb_sleep broken.

* Both rcu_segcblist_extract_done_cbs() and rcu_advance_cbs() are called
  under the nocb_lock, the latter hereby providing already the desired
  ACQUIRE semantics.

Therefore it is safe to access ->nocb_cb_sleep with a simple compiler
barrier.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree_nocb.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 4efbf7333d4e..785946834c6b 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -933,8 +933,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 		swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
 						    nocb_cb_wait_cond(rdp));
 
-		// VVV Ensure CB invocation follows _sleep test.
-		if (smp_load_acquire(&rdp->nocb_cb_sleep)) { // ^^^
+		if (READ_ONCE(rdp->nocb_cb_sleep)) {
 			WARN_ON(signal_pending(current));
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
 		}
-- 
2.43.0


