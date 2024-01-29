Return-Path: <linux-kernel+bounces-43654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBA5841737
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E52E6B235DE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5448615B109;
	Mon, 29 Jan 2024 23:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKJfthmU"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D489515B0E4;
	Mon, 29 Jan 2024 23:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706572688; cv=none; b=unMUPPzaWNs8mK8yVCH5knHzt+bCpqAjsh+OsVzrwtB2bKeFrfjnr2ta695Zhj8VHS53Wpg9gPNgDzT8viUUI7pgOB9tDShzp97X+W1huezlfobjV6CJwMoDL+AR+k0Xbfik4x+8UE72oDHA/jjAgCW8XVv/BxkW7FGbhleaULY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706572688; c=relaxed/simple;
	bh=lMFvgqfN+kt6RoJPWB4o6w/nLUSSKF34aDlk2aqz1Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTTf3S2it5+7JwsCS4leOmbOZMmopdpN/ic4A2NsfOn7tW7ePxxPFISR99hAECk2A8vMIG/2oJKhugWPX4WbsSaqXlKamnd3MTaPc5mT8D5vnwQyKynSItTMHbzJY6llBSmYmDOFMnmfvmR6hOApTpiL5unvPfO9AbzG/b0sSBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKJfthmU; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68c420bf6e1so17031596d6.2;
        Mon, 29 Jan 2024 15:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706572686; x=1707177486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RSP3l2uIllosU/0jzT2mQWw4itLcaXh88Ph87j6nkH4=;
        b=WKJfthmUUy0jAde6bFnD9HEjgv8O4SjFeBEnX7g7Yh0TlHuhpeQJS7tw+fkweTQdZD
         P8uSXGneOhrVfaLbLx6aGB9zODfGSAUI00/dMilRrqdeUvkuryX9Rt/BZyq0t9XCmG9H
         aDTXbBHecIkbwdJ+zr5/C9SntPj+f0UYBdFKg3j6dzdil029TC7W4uNKwXDoZAUybSln
         f8/Y4X7xzIMlYC5974bGppgmqxzTSXQV2N7VgZwISvPuioMDldae1xWwgT99+5q0QEi4
         MQwL4EAt58ClTVkpH2m6IIAAA7YlttpmBMwbvnZ1d5Ss0yQ63xikheXaRZWCqkN5hdTT
         hP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706572686; x=1707177486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RSP3l2uIllosU/0jzT2mQWw4itLcaXh88Ph87j6nkH4=;
        b=bDkHCH0lY5qhUzse747n2PtLEWpmCE6FGbxqjDxKD4xEzaXPbmT5ohwukUvn4n13Gk
         EtStrW+aCEcUT8YrrAUfrCwoGHlwyEUJJWRVz1GBG8dIGslQIhogLkHwJXFGSfxMDd7y
         Db4hQ2+UBLj1B3oOqEXPTwRhRiEW82O4awJIRFjEXLHIHdmh8qKQg93lyhvVRvBwvtqX
         iFFfK3lcfgPTDaW8EzOKZaeoKO30qtIyl4J7/Jhqum+PwpoW6C5Zo8P+TukEosceJvef
         EzvE49MZ8tLfK+dercTtZd5LL16+Ew2jJfVrI0ZvoPfF8SRSFPkDw09lt5Vk4IbYuiLr
         lSRQ==
X-Gm-Message-State: AOJu0YyGL4b+E5CGU1JDIne9NBe61HN4fOWxJ5UR/G6EX26ZWzGlWqG5
	n/3lIf+D5M/8tqVR3CryLXkeLKU5ckmA8gSTijeVmGyxLomQLK3C
X-Google-Smtp-Source: AGHT+IEiw92L8fwJ+DiU1Yv1R5C6ChnKDGH8+BVs0Nen86LBxDIsUjlk8vV2UPtCAQxD79fn2+4qRg==
X-Received: by 2002:a05:6214:5192:b0:685:236a:c883 with SMTP id kl18-20020a056214519200b00685236ac883mr9677524qvb.22.1706572685729;
        Mon, 29 Jan 2024 15:58:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVCZnQf4jnUV5WAP2NM4CT2f7zfQ6iez/tfhcsZZs3SfBv7QfrF19bXB9OIiwrIltFpK/zRzBSrNmP+bMRfwg/oClS1e+jvf0GZIIuvNh2PvKwogO6S2eRUswbFB3YfQKreYhRBtWcdpHyGBDmdCSUVekQjCk9sNslTWwGD0gMU1SG4r9N6+Wmjhqf/F6on5pbO8BPgX/A3N/8fJ9OksxsuP2HuHRklmkssbdtx7Ih9OQS0rLhoxvLqEroDyp9wA1BMdiPGGFdI42mWn6R9EDgQkd0k+bAzjJZOUW9Sm81G+VsbAy5XWzs4BDagOUcCd/b0j+B5j6pMVMBDuD1e74oFReKQv/Uqon6x3YnRO5UWiUi2dKqi+3DtcLgyc0HnSGTAa7jHmC0blO1gWofz6SOEH2UP8Tt0E5V0MzJR0eeFljxB81ShUYp79qOBSHaK/moiD+85lBqXTO9lUlvnTNlVR4/KYNKcsMcfZOo=
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id op32-20020a05621445a000b0068c4917df76sm1979142qvb.130.2024.01.29.15.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 15:58:05 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id ECBE21200043;
	Mon, 29 Jan 2024 18:58:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 29 Jan 2024 18:58:04 -0500
X-ME-Sender: <xms:jDu4ZYeY0EJILzO135rnwLSwlrt6RQoy0RqhhwgR_wivFt4GwNe6Tg>
    <xme:jDu4ZaNXRNLO-yHJOtxNoVGbIbZsP3ikRH3dH9LTxBTxSSMvEnx6KsBjVzYLTSIEX
    xUzeYV_uded-AjiLA>
X-ME-Received: <xmr:jDu4ZZgaegljTP-_se3EZhOV6vWbuKgsgB6JA7xxmkAhYte9flvaNgImSNFZ5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedthedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefghfffvefhhfdvgfejgfekvdelgfekgeevueehlefhiedvgeffjefgteeu
    gfehieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:jDu4Zd9O5VWAfzTYItEFoNggNsvgaI9I4jUHgv5xvSBJt9o21yND3A>
    <xmx:jDu4ZUuzVuuK_1Wo8PxCFWqr4HWMq5rQoBpmQ8lF7yjhNuDFUKlNKA>
    <xmx:jDu4ZUFVCu0ie5DAQ0YixOOvs_xBHD4pdVG16zitnQdjmhKzbmrDrg>
    <xmx:jDu4ZYPxXInOVf5tV5RphU9A_Gh8Xn4ZQ4WAmzYhevpvwEL7omdKmg4975U>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 18:58:04 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Onkarnath <onkarnath.1@samsung.com>,
	Maninder Singh <maninder1.s@samsung.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH 8/8] rcu/sync: remove un-used rcu_sync_enter_start function
Date: Mon, 29 Jan 2024 15:56:41 -0800
Message-ID: <20240129235646.3171983-9-boqun.feng@gmail.com>
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

From: Onkarnath <onkarnath.1@samsung.com>

With commit '6a010a49b63a ("cgroup: Make !percpu threadgroup_rwsem
operations optional")' usage of rcu_sync_enter_start is removed.

So this function can also be removed.

In the words of Oleg Nesterov:

	__rcu_sync_enter(wait => false) is a better alternative if
	someone needs rcu_sync_enter_start() again.

Link: https://lore.kernel.org/all/20220725121208.GB28662@redhat.com/
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcu_sync.h |  1 -
 kernel/rcu/sync.c        | 16 ----------------
 2 files changed, 17 deletions(-)

diff --git a/include/linux/rcu_sync.h b/include/linux/rcu_sync.h
index 0027d4c8087c..3860dbb9107a 100644
--- a/include/linux/rcu_sync.h
+++ b/include/linux/rcu_sync.h
@@ -37,7 +37,6 @@ static inline bool rcu_sync_is_idle(struct rcu_sync *rsp)
 }
 
 extern void rcu_sync_init(struct rcu_sync *);
-extern void rcu_sync_enter_start(struct rcu_sync *);
 extern void rcu_sync_enter(struct rcu_sync *);
 extern void rcu_sync_exit(struct rcu_sync *);
 extern void rcu_sync_dtor(struct rcu_sync *);
diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index e550f97779b8..86df878a2fee 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -24,22 +24,6 @@ void rcu_sync_init(struct rcu_sync *rsp)
 	init_waitqueue_head(&rsp->gp_wait);
 }
 
-/**
- * rcu_sync_enter_start - Force readers onto slow path for multiple updates
- * @rsp: Pointer to rcu_sync structure to use for synchronization
- *
- * Must be called after rcu_sync_init() and before first use.
- *
- * Ensures rcu_sync_is_idle() returns false and rcu_sync_{enter,exit}()
- * pairs turn into NO-OPs.
- */
-void rcu_sync_enter_start(struct rcu_sync *rsp)
-{
-	rsp->gp_count++;
-	rsp->gp_state = GP_PASSED;
-}
-
-
 static void rcu_sync_func(struct rcu_head *rhp);
 
 static void rcu_sync_call(struct rcu_sync *rsp)
-- 
2.43.0


