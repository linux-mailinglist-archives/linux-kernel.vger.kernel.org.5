Return-Path: <linux-kernel+bounces-43648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26487841730
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903951F23B39
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E0F15705A;
	Mon, 29 Jan 2024 23:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWpA6BOe"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C091254670;
	Mon, 29 Jan 2024 23:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706572676; cv=none; b=MV5tlFlf19f2FOl5LrV/LwLspYVxKUpLg8j8EOw3+MeUUuGh8uS07jD71X92cgFus6gYwmoLWjc16lL5ExRplEVQ/MbZFF2fYnBlBlSx3rjlIQHNSJsnSvFhoPOjOsVJARfA1VAFUiMEuiMfQcXdC1yA3CFt4MSBUFpLmyy0JSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706572676; c=relaxed/simple;
	bh=W0XzN0qkMvIRBzxDSAsFx1Wj0qZvkVGIaHK8Ta6QP/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sH1nOGCCswMQZ6CCprr/g57o80NLKaqHOzelvoqb41d3TcUMAdqA9Pb/fFwf0kRcXYZB1RyH0pXSPUtk0RJvQ3CAsWPzi+hzCm12wCwP9n5sDSjZ8XclIQnIwOFzBCDjof4BMkifd9Pud6PHoUuNbrOgJlrF9mOaUsgEA1THaYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWpA6BOe; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-68c2f4c3282so26347106d6.3;
        Mon, 29 Jan 2024 15:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706572673; x=1707177473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X5SWUW+m7tI0wwKK9KxgCmfN7nKEUdz6H5ceQbRqNGY=;
        b=YWpA6BOeIHAGujCYlWfewlcJtJk4Kkz9L5inOAy2mYhoKc0IKL3HCkuMSltZ4kzVnl
         xmqjw9jLoZqhc9uvSFczYkXB8yEAgjcY+ihNLvgo857jjcGD/MHB16fU8K7pGibqg8R+
         +AN1rz+Kj06F2EcK7OZyiJLKir1qdzeT/nmOp4I3wPb4S9dzJ3bHgdeP5phroWbxGa0I
         uBxePzsHYUkmQm2iVU+PMgoU324ieOpwqpHIWdg/4kWx98RIiAbQ3Ou4XVxKFfgvLi3E
         p4WzHjHJhn6AQtXhqXL8d37naim4QT1RT8z81zK/cEWzMVGmZYWfckFrA05pCyfdDc1w
         e4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706572673; x=1707177473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X5SWUW+m7tI0wwKK9KxgCmfN7nKEUdz6H5ceQbRqNGY=;
        b=Hzp+elVqL5gLk8Ois7vac6WPipOpu58wiyZkn8oP+t2+zB3Czn7uFfaB2ywxexJbIK
         w2dm6bHy5p1WbhYNcRhlARvypRZK47TVl6TXA0nH6tCY2YHAfzeO2qKnNcbkyaACBxHo
         plgqR/KdmWQJUYV9p8gu3JWIuys4/mTii/kx1WKozCsL0EXMT33EUHZof4vrz5bGcDWB
         +EPq2+nS9Z9QvhdVDvOsymZmlqi1iE4x1q2AbctftJ21VXmAItCw1grvrBZcX3dtrGZX
         o3uzc2CYwAVD5DwUMEcOqj7ETLi6Y26Y8AuFlyrvZi+D5lEDFTYgU7LtB5bE8Aai+y+w
         AZvg==
X-Gm-Message-State: AOJu0Yxg3HaMvm4zAc5lVuESdPXXwHTXOmQ2b4PZ9UoByOD0JPSXMrMW
	4pkeihskz1AcEI0M4QXL0TjzxRmIOYCbmS/rUvoKQuXb5UUQSkgC
X-Google-Smtp-Source: AGHT+IFeSapqqsfg4gNLYGxYvmjlsKND48UUNQn6Qu5QGNLt+/l7ndRTv7hKbaJXXr4oaDtuz7eD3Q==
X-Received: by 2002:a05:6214:27c7:b0:68c:5f06:202c with SMTP id ge7-20020a05621427c700b0068c5f06202cmr342365qvb.96.1706572673627;
        Mon, 29 Jan 2024 15:57:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWjcVy5kC85qmp7+akcRl4wdVne8Jmt8ZCY2iBS2Ienx4dTMzxsmKwynI9NExnZwFguBkWLq8Wx6xxTd7MCkj+xWQveThFvGc+yNsREap7r4uEmM7A1pToIDDReDGzrbERsD5cHewBr6Iuieii4CUSFVKEqL9PfA6bvClHUaaoyUIqgu5ccpLBp8pJs3mPLIf2qaSng9ohL21lBq9CZcNvab6qkcXoKxSpRfLUyZDjtl2su16f7xyCJ4cUAz4qyDZOmnzG2v2XvE1TPzOowWiOrmCQjJTETAArChp+8C99NTfIFrBXR25J2j7L+n7PSm3Qs7vOtQC4DG2nIStO9Xcxu53w7xyjYLJ5gnUOL4R/kWACBuw2Is5XdeDnGGkR1DTCMCz5qtfT2Ff4I04TNOGOpENJClOnGEaPGQZcj4jNUKRqNBn9lbCANYFPm0NfkkyeLr5+m0iGmEDmr6vps/D/+4c3r5h4HiiiavIKWAhRClHQJyLM/HwxqJKW2dUKebU/6mlrJgLvEOcHF9+us+kQTtNfnaC7QmEZknc5txxLIdxNPqYtrJTamSJ4B6++2hTeW54WPjmZBhVOguD8uD/xZW7wwmPGXrol7jg==
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id lb9-20020a056214318900b006869c05a875sm472651qvb.32.2024.01.29.15.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 15:57:53 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 9CF6F27C0061;
	Mon, 29 Jan 2024 18:57:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 29 Jan 2024 18:57:52 -0500
X-ME-Sender: <xms:gDu4Za6dipyIpHwOjUlIMAlXz62k5A2aJtVicitVHfqVYte23BJ7-g>
    <xme:gDu4ZT6TDbkyUIhFoLVUI8KVFeePTb8gAbsTr0aqF7wsZzLgzbA2XebbrmxdxV7rL
    8mq8UbdFjVY503-bw>
X-ME-Received: <xmr:gDu4ZZe9mXWlWUueKAkkkzMTUsb9-LUHaTPbP1R6105H4yfXAoCTLrY_MGisxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedthedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:gDu4ZXLP4jAuKm3SZ2SL85Vd1S661_GDjSKrlI_ca1vx-enj_5sFzQ>
    <xmx:gDu4ZeKDTuz4rWYsyDa9lQXEsCkegXhyzGBtsf2Tl50kKgRbZgPWCg>
    <xmx:gDu4ZYzPKTmzblC6OJ0QzKsxbvRu9fv-kuxytbzE58XkokHYAhrfdA>
    <xmx:gDu4ZS-MZZDRva8w-_9gIyzInFyb5WFkNvvessV1bMEhxjU23T_GAw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 18:57:51 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Qais Yousef <qyousef@layalina.io>,
	Andrea Righi <andrea.righi@canonical.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Yan-Jie Wang <yanjiewtw@gmail.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH 2/8] rcu: Provide a boot time parameter to control lazy RCU
Date: Mon, 29 Jan 2024 15:56:35 -0800
Message-ID: <20240129235646.3171983-3-boqun.feng@gmail.com>
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

From: Qais Yousef <qyousef@layalina.io>

To allow more flexible arrangements while still provide a single kernel
for distros, provide a boot time parameter to enable/disable lazy RCU.

Specify:

	rcutree.enable_rcu_lazy=[y|1|n|0]

Which also requires

	rcu_nocbs=all

at boot time to enable/disable lazy RCU.

To disable it by default at build time when CONFIG_RCU_LAZY=y, the new
CONFIG_RCU_LAZY_DEFAULT_OFF can be used.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
Tested-by: Andrea Righi <andrea.righi@canonical.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 kernel/rcu/Kconfig                              | 13 +++++++++++++
 kernel/rcu/tree.c                               |  7 ++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31b3a25680d0..b6c848c29a53 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5034,6 +5034,11 @@
 			this kernel boot parameter, forcibly setting it
 			to zero.
 
+	rcutree.enable_rcu_lazy= [KNL]
+			To save power, batch RCU callbacks and flush after
+			delay, memory pressure or callback list growing too
+			big.
+
 	rcuscale.gp_async= [KNL]
 			Measure performance of asynchronous
 			grace-period primitives such as call_rcu().
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index bdd7eadb33d8..e7d2dd267593 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -314,6 +314,19 @@ config RCU_LAZY
 	  To save power, batch RCU callbacks and flush after delay, memory
 	  pressure, or callback list growing too big.
 
+	  Requires rcu_nocbs=all to be set.
+
+	  Use rcutree.enable_rcu_lazy=0 to turn it off at boot time.
+
+config RCU_LAZY_DEFAULT_OFF
+	bool "Turn RCU lazy invocation off by default"
+	depends on RCU_LAZY
+	default n
+	help
+	  Allows building the kernel with CONFIG_RCU_LAZY=y yet keep it default
+	  off. Boot time param rcutree.enable_rcu_lazy=1 can be used to switch
+	  it back on.
+
 config RCU_DOUBLE_CHECK_CB_TIME
 	bool "RCU callback-batch backup time check"
 	depends on RCU_EXPERT
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b2bccfd37c38..41c50a6c607e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2753,6 +2753,9 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 }
 
 #ifdef CONFIG_RCU_LAZY
+static bool enable_rcu_lazy __read_mostly = !IS_ENABLED(CONFIG_RCU_LAZY_DEFAULT_OFF);
+module_param(enable_rcu_lazy, bool, 0444);
+
 /**
  * call_rcu_hurry() - Queue RCU callback for invocation after grace period, and
  * flush all lazy callbacks (including the new one) to the main ->cblist while
@@ -2778,6 +2781,8 @@ void call_rcu_hurry(struct rcu_head *head, rcu_callback_t func)
 	__call_rcu_common(head, func, false);
 }
 EXPORT_SYMBOL_GPL(call_rcu_hurry);
+#else
+#define enable_rcu_lazy		false
 #endif
 
 /**
@@ -2826,7 +2831,7 @@ EXPORT_SYMBOL_GPL(call_rcu_hurry);
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-	__call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY));
+	__call_rcu_common(head, func, enable_rcu_lazy);
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
-- 
2.43.0


