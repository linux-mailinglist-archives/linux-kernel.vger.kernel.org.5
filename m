Return-Path: <linux-kernel+bounces-39581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F6A83D32E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6CD1C234B4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEFD10A19;
	Fri, 26 Jan 2024 03:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FL+xRFuk"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A298C148;
	Fri, 26 Jan 2024 03:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706241561; cv=none; b=hmV3vQSfXxigq3LVwnsIayemD5VMfpTkDE6sOLNp6Nx7jKR13C09tEwg0XxtJ6gqt3KeAqaS2lKfEvyan7ZhIlx/NC2Q7Vs9plYrP68pqq+VkyUcYxU+0gEzDrhSq25Kp05L5NHcM4SSSex6HJwEkh7IKD5ENTp7GPsSVA134F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706241561; c=relaxed/simple;
	bh=h1Y/gwFxOJFXt01gnNFKLO6v78F6N7Su/jOY8g6xKP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBsYlwLdIfM2j4o+zaCHiU3LduC6AZkqRaGIIXRX4COhWh94GazyjNZt0dT/3tcKnqHoCjziruEH8IB1GznPVy0bLxgDEPQw6ydkfvGvT2zMHKOXoqlk+LPyzq/betlpm+BY2H+zuSxgHpHrwJUEinP4EmYtzPteFAlMcDCVfO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FL+xRFuk; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-783045e88a6so33971785a.0;
        Thu, 25 Jan 2024 19:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706241554; x=1706846354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mN9urTWgOs5yxGqYWGcDWpJNj/mjOSJkCC13yHHIGOY=;
        b=FL+xRFukscp+HWqcrFUT+7STUBnnfJzJE3/xHNQlmrKYzUOsRusGi/3WRo3nWz6P/I
         wcJbmOnLpl/EHy6mLoDX9DTvbVA1yevZF7k0XiwsD9t19TBQ0TjWnmzRKKTDocq+gN9b
         y0ZW4qHApkGLW7dFRHwJn6jWPXdTufii/vGI6s4VllmQrjgHLKGK5etyPdmSceKh3yiE
         YoiUv+kZ7lHFunvfqqQJxOigbNWRjsFM98FZ5x4faDBBw4St609cOj1p/xCih8q72nVD
         5pTB6qIIkguhfWrHOWO6fYiWt3jQKcqp2eWh9b0UXOMadfCOgtPcK1HLo/4tXZFLABpB
         CHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706241554; x=1706846354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mN9urTWgOs5yxGqYWGcDWpJNj/mjOSJkCC13yHHIGOY=;
        b=XUGkcO2GndY0BbhyBu4ZonTR+J6ovjTGCQhJ//iiTENzCL9qlfdiiLLNXbA3142UZv
         jICJ2/llKy7JXdL3jTClQ/GwPr4bM0MFjZT721VAdDBb9rNE9wO2Pvm0fNagaJorvbpM
         8BSm5tWdR2g5H2ccRpB+wysGa5WY4BjGwGbSAU4AVnPdY7SLmoD9SniAlBjlcRdVv1ng
         OPTZBT6jHlSOP3h+8bzsdL7rM419ceqNMMwsbytl1aLXr5uLq6ehdIDNzq4Ak+5BuA3U
         JhorNKqOdPqHAPzl6zqPrjFSMYcQo0zrppMggmlLTWVXtSD98jJn1L0YFpesgndcCRlu
         xdQA==
X-Gm-Message-State: AOJu0Yz1BZSNXSipHVfoYHeNGeKolumytZ//8W21de/UViMQQJCCS/c1
	SBkX3tZDPY0E8qBc0OpYAsszHJnEhcueylhwNBwPfhh0XCiWE6Rr
X-Google-Smtp-Source: AGHT+IEr5lwYyeK+DAlCMywYxD/dVhVnliPCsQ1+/5GTanEYCSEwv958X2LO0qsdK5nBmhofDuhU+A==
X-Received: by 2002:a05:620a:29c7:b0:783:1f5b:9c5 with SMTP id s7-20020a05620a29c700b007831f5b09c5mr1185613qkp.80.1706241554190;
        Thu, 25 Jan 2024 19:59:14 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id m25-20020a05620a215900b0078325452a32sm212464qkm.28.2024.01.25.19.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 19:59:13 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailauth.nyi.internal (Postfix) with ESMTP id 6FD3F27C0060;
	Thu, 25 Jan 2024 22:59:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 25 Jan 2024 22:59:13 -0500
X-ME-Sender: <xms:ES6zZV40ASohajaSOhP5Z9FXMA4On_jsA73SoHWHSiiAAspDf58wgA>
    <xme:ES6zZS7cLQrmuRAVpt-_nWkdgEPYbpa4tw9nTIzfGooZ2d--2Ku3QaZzN9pt8OYRU
    ZM7cNGNzkoD-f75zA>
X-ME-Received: <xmr:ES6zZcdrIF88p7InAovlZvhxCJM0Lh2D4QGT479uEkH9p076BicsQTppnXU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeliedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:ES6zZeIZ-tMlfGgeI7nvonQp53Cyg_KuYClT-_IP5ZGPoaeMGRHf5w>
    <xmx:ES6zZZLVWQkibapkpu7Zu2lIcIpNQVG4DdxkAjTEDUB5i4FmKJcWSQ>
    <xmx:ES6zZXy3n7B0rcUr3YDxdVEqIymIwnVHEP53bJ7mgzEC67VCLC1xlw>
    <xmx:ES6zZTAS1TVLbVFGyeTYW8oqpU0jr7KRQGTM1Ay4l4JgMt36UN21xg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jan 2024 22:59:12 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH 2/8] doc: Make whatisRCU.rst note that spinlocks are RCU readers
Date: Thu, 25 Jan 2024 19:58:05 -0800
Message-ID: <20240126035816.3129296-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126035816.3129296-1-boqun.feng@gmail.com>
References: <20240126035816.3129296-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

In kernels built with CONFIG_PREEMPT_RT=n, spinlock critical sections
are RCU readers because they disable preemption.  However, they are also
RCU readers in CONFIG_PREEMPT_RT=y because in that case the locking
primitives contain rcu_read_lock() and rcu_read_unlock().  Therefore,
upgrade whatisRCU.rst to document this non-obvious case.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/whatisRCU.rst | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index 60ce02475142..246ce0d0b4d1 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -172,14 +172,25 @@ rcu_read_lock()
 	critical section.  Reference counts may be used in conjunction
 	with RCU to maintain longer-term references to data structures.
 
+	Note that anything that disables bottom halves, preemption,
+	or interrupts also enters an RCU read-side critical section.
+	Acquiring a spinlock also enters an RCU read-side critical
+	sections, even for spinlocks that do not disable preemption,
+	as is the case in kernels built with CONFIG_PREEMPT_RT=y.
+	Sleeplocks do *not* enter RCU read-side critical sections.
+
 rcu_read_unlock()
 ^^^^^^^^^^^^^^^^^
 	void rcu_read_unlock(void);
 
 	This temporal primitives is used by a reader to inform the
 	reclaimer that the reader is exiting an RCU read-side critical
-	section.  Note that RCU read-side critical sections may be nested
-	and/or overlapping.
+	section.  Anything that enables bottom halves, preemption,
+	or interrupts also exits an RCU read-side critical section.
+	Releasing a spinlock also exits an RCU read-side critical section.
+
+	Note that RCU read-side critical sections may be nested and/or
+	overlapping.
 
 synchronize_rcu()
 ^^^^^^^^^^^^^^^^^
-- 
2.43.0


