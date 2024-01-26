Return-Path: <linux-kernel+bounces-39582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EF683D330
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 05:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27AC328CF22
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FB711184;
	Fri, 26 Jan 2024 03:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkZNRCJQ"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E873FD2FF;
	Fri, 26 Jan 2024 03:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706241563; cv=none; b=NN4/qS1eN7EqodSqlwYD8VIvxXxkKTQYLCrTS557rUnkKuIEFezI7s2BmjTI//91emauoltJfMOkbsJg74KA8fUuD/Dy2v24l/7KFP5bLQ5JvpAmXuKQiBC6k1GoxdENY4nG3vDxbTGNEwV8ldS9VUlj/kJNGC9z6pxqO7HBLuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706241563; c=relaxed/simple;
	bh=aCgqNjr3kyoCqt4weqgnVtWfnlpXYVdwZmyIsezpDcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQi0FKebZSWTn4zRnFzM5jOGxRXjEN6tQzwHNn//NGqtio8f/fX3xzNvc24cspJ8wZMNHeW8V5pxi8nMMU0bJdYa6C+1BKky4KgKes/X0bqumHN6qc52JtPOLHfWbLIiPLwcvhOgEUQetNmxdHSO9g3gWINgN2fAJm7/dwxnsBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkZNRCJQ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7835aea8012so21381085a.0;
        Thu, 25 Jan 2024 19:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706241557; x=1706846357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XQw3igpVtUqCTigEWdjGQcQAwe3+fTReKCynw3MlRDg=;
        b=YkZNRCJQcmBTBn1xigUmWaYsXy0U8YOwW+sHq8Ru/8A4URXjFwWSRJw7iGZGZ3ic7b
         IBAy/pkoHM+7h+7DeDcUS152vMn2cWGGN+MDp8HRRoymuLUCq8G9UZVAo7nV7QrquPb2
         p2CxmBF/Mi6U4uAxsGahJKKUUrl2P8gVKqdMdmnD0r9dzliH/7BUQH5xZlFeuAYEjjmZ
         IY6+j+QCenkfxzsqQdrHzOWAiylYKxBwSARD3sbYu3nNw24Qc8qRVtrtQbQYV+a/DB3P
         EJAQ8n3TSBjgkoIFoeoN7Jca5b8elWofk4myuavwHB8pObOuWCtmtC0B7A2tLP4gSlKq
         Whuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706241557; x=1706846357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XQw3igpVtUqCTigEWdjGQcQAwe3+fTReKCynw3MlRDg=;
        b=KIN+BlcMbK/Gw6/57Q1crshonRhVB7PR9vA2SAxf01c9fMJuyHzj4IM3ENs7HFDy2t
         PHcXs0mnXKb+5Uqf5RpPCkbgf6S0K0b4v1bbKWAWn4oCZ+thrQ+XQ3MGhnNxrHnw0T6T
         fM68qfu6bap8qP0K6v8bDR+Ct9p4vqYn/bx3DhGOZswCBlmN59lvcrjuTQvwD1bZIw2R
         Ga9MirRxIzLUkdWBHERp2OZPUaMunTW43fv73xgOnwhluQR2otx01G+lktVOm3p3WnW7
         wqh95qrg1pgxZQWNER4M4HUvjERAM0Jlj6uSVCgJX+7u05Yr2ZdfrbxTjknjcjafEBdn
         8HLw==
X-Gm-Message-State: AOJu0Yxk/IUUsSMYEEbXYU1eJbthIwnmZFHIfvRge+1matZs/5KX4anj
	D8Vs9Cf3CieulVDULNwGTVK4In/UrMK71yhgMWM4JLCLCsKBYo/T
X-Google-Smtp-Source: AGHT+IF2+pimWESHNxX0PY4bqjmXtA+DY3Csfgsl4J3G3FEnt6dfFsU9BfjC3WYsqB3rOodvcA0ojA==
X-Received: by 2002:a05:620a:2492:b0:783:6e66:4700 with SMTP id i18-20020a05620a249200b007836e664700mr918566qkn.66.1706241557473;
        Thu, 25 Jan 2024 19:59:17 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id s26-20020a05620a16ba00b007833301b5b6sm205936qkj.115.2024.01.25.19.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 19:59:17 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id C2BA527C005B;
	Thu, 25 Jan 2024 22:59:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 25 Jan 2024 22:59:16 -0500
X-ME-Sender: <xms:FC6zZf8IcRkPJgnM5zvcXL8HmeRPeKVvRI0K-NOFOaGpd9Bi3ydtmw>
    <xme:FC6zZbsKQBjPFiLpFe59ipeU0EbhuvbXKiWftdb4_NtVeskRZ4R6AbKKUwcYijIyo
    ap8O9kGlrjIdtXx9w>
X-ME-Received: <xmr:FC6zZdDrrOJDg4ixstveoG9RoSXrdCh-aShuLoMywmOHfHdOW0kbJxBB9lY>
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
X-ME-Proxy: <xmx:FC6zZbezIOjI6PHURfWg14BXEddo65zlgRhbOckLCf5PNE9fKklUAA>
    <xmx:FC6zZUOzWtKN4f6I7poinmhZQwdfI4JF_-nT3qCtg-a4A2HJBJRXcw>
    <xmx:FC6zZdkhV-rQslr57V0AbAa3Z-XL7uzbO9uhJlMl_n-_7-5zzVOJsg>
    <xmx:FC6zZQkCMjgXZgJKvYrXJcrRUgl6PN0NcVhlALGmtZZtHna2a981qw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jan 2024 22:59:16 -0500 (EST)
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
Subject: [PATCH 4/8] doc: Add CONFIG_RCU_STRICT_GRACE_PERIOD to checklist.rst
Date: Thu, 25 Jan 2024 19:58:07 -0800
Message-ID: <20240126035816.3129296-5-boqun.feng@gmail.com>
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

This commit adds CONFIG_RCU_STRICT_GRACE_PERIOD to the list of debugging
Kconfig options in checklist.rst.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/checklist.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index 98a622f77248..addd5c1547a4 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -491,6 +491,12 @@ over a rather long period of time, but improvements are always welcome!
 		since the last time that you passed that same object to
 		call_rcu() (or friends).
 
+	CONFIG_RCU_STRICT_GRACE_PERIOD:
+		combine with KASAN to check for pointers leaked out
+		of RCU read-side critical sections.  This Kconfig
+		option is tough on both performance and scalability,
+		and so is limited to four-CPU systems.
+
 	__rcu sparse checks:
 		tag the pointer to the RCU-protected data structure
 		with __rcu, and sparse will warn you if you access that
-- 
2.43.0


