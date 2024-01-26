Return-Path: <linux-kernel+bounces-39584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2672C83D334
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 05:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C531F2255F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A493DC13C;
	Fri, 26 Jan 2024 03:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzI7buMW"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3FC125B7;
	Fri, 26 Jan 2024 03:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706241567; cv=none; b=BYcgrjGe6PAul5VtzxcMWjWgxhxU4grjR1X8Iuytw9u3nX7V8hdxywAIsmwt1ZfemXHGKrDA0Irvmpytb97C0Ddd4GtMCwt+yU58e47Lf65pM0MlHjgFTeXuAMiY1/5j8Pw2rYqzzOjvnO6vpCy+6zCYJSlg1RgqlYYzxAiUDmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706241567; c=relaxed/simple;
	bh=OHyp/cl0sesiDi46hrRKgERuCBPKSpZYjrfdlwIbLec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sip1KYhCPq8VCMxAD0Z27+hXuCANB6AUcNtrhg9LXm1vjJuMZwmqf3hJw3qaJ4L9W6Ng8wXnqU04rICWlv4eZwA3YvWs5wMyim+Y6ml4dKz4u+kenQkbnjbe2P848vCLS+93al3tzzw9kowuR6a6DBXnPoQDV2S0Z5Pt5YoJPO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzI7buMW; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7810827e54eso518531985a.2;
        Thu, 25 Jan 2024 19:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706241565; x=1706846365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EO+5jZxp/BmVN4zA1VzpAEG/sp+6XbEjMKC2KLtQ1pM=;
        b=NzI7buMWaZp/lneIZvoWGJWSevWa4emZMYiM6vlk1+5pWUwZGWLUFQ/cOygCE7iQya
         NLDC6Sg8HnefiUmoc4f1HTAWg0jrZ30R/oWnFFklEemr/ZEMjLOyttOkL0Q/vrxYKjEt
         Pf+a025JKuOOdjLOnRqIiztFB+81ywmeRbQdaGvZeiDSokY4uAAn9gVnaYdkgMcpH3vA
         FqZ8IEtuf1hQ5UHMJVLNIffacQT8vRJSpGUr3UlDeF8Od9U8Sjx/SVCnfY4Lk6/+AjF5
         Ddii6vWgvkMRGArqSOSsRpzoCkMDTelvZdSnf53ji4rmJ8UAdoYXvwjxwVfhEPQGWg+F
         gpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706241565; x=1706846365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EO+5jZxp/BmVN4zA1VzpAEG/sp+6XbEjMKC2KLtQ1pM=;
        b=b8UtpgryR3N2jxhlXYVNi1B0espYleNWFFFdwjjfCwXuYtpRh5GSFwwlsruoMHeiI1
         VK6C6yxt8CK2qwAR0pvC4ZXYoMlRL0qD1Hg00ZSEzOajUeHCLd5uggY7cAXk1BRP+5+T
         7eQcn3Mk+91wa6BxW9xzbRKMsbNdit1dv8a2lpRDXvkykKN/3h3xKaoLtlZzk5HzvMSZ
         GxhTRD/hth0cL7NHKmMkZrLZoSw5muizu59fuaqWC5NUuKpyiJPUzIXVOGKJfQYal7FU
         mH0BHz8MhuFNGGhk6Pvs3d5ISUWR2Hnx0HFIM2fpXtXCWRNzR8fwYSMvxaFon/KHSwd3
         kD4A==
X-Gm-Message-State: AOJu0YzGWZqBF+QkrYMEMegi570bYp+dI3w02V1UNlbgSc40ZyfePA6o
	jVQ39T4Pmu7APuR1NLHB8yAz6j3FZcB0vhLszcYMlqVUUfVZ1niByiK6PXk2
X-Google-Smtp-Source: AGHT+IF3l0KAt07QcOPCrsXfreAR1OrRUh8S5MhDX9ZEfIuFpr9D1SPgArDN3nf0I8sfIV5j4eUSbQ==
X-Received: by 2002:a05:620a:851f:b0:783:539a:f30e with SMTP id pe31-20020a05620a851f00b00783539af30emr853975qkn.83.1706241564932;
        Thu, 25 Jan 2024 19:59:24 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id s16-20020a05620a031000b0078329aeba24sm201485qkm.131.2024.01.25.19.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 19:59:24 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailauth.nyi.internal (Postfix) with ESMTP id 6428427C005B;
	Thu, 25 Jan 2024 22:59:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 25 Jan 2024 22:59:24 -0500
X-ME-Sender: <xms:HC6zZZIpptXDQw5DFVUjyuG7w4jBZK1uIAoaB-VZ2wTeRDohO4XrMA>
    <xme:HC6zZVL7pncSSg37VgLpj6idTXSuGrj3Z5BLXF5z5VvayVQPY6Y8bpLc1fTg53ltW
    wUs13K9dp3W5G74IA>
X-ME-Received: <xmr:HC6zZRsG3brrQlH3siNwrd6f8hOQHXD71ZhK8b40EuUsoJT98xgZTLuX3dY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeliedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefghfffvefhhfdvgfejgfekvdelgfekgeevueehlefhiedvgeffjefgteeu
    gfehieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:HC6zZaZHX3MVgVR17ZbmRPaKcnP6AKsrosZr7mCPSvEq4p-fS2stoQ>
    <xmx:HC6zZQZqPPfXnIZX8BX4aD6iMCYCFw-pEdXYdhYAiGtXIhNq1l4CCw>
    <xmx:HC6zZeAkaf6G2qngj1zSLy6QF6vygY4E2Kv9tKISRYezWyGx_w4xpw>
    <xmx:HC6zZVMXGc3e_WCHKWtlYeqYvH_qidlxk7wLfKk95Zn6nwha955zKw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jan 2024 22:59:23 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 6/8] context_tracking: Fix kerneldoc headers for __ct_user_{enter,exit}()
Date: Thu, 25 Jan 2024 19:58:09 -0800
Message-ID: <20240126035816.3129296-7-boqun.feng@gmail.com>
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

Document the "state" parameter of both of these functions.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312041922.YZCcEPYD-lkp@intel.com/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/context_tracking.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 6ef0b35fc28c..70ae70d03823 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -458,6 +458,8 @@ static __always_inline void context_tracking_recursion_exit(void)
  * __ct_user_enter - Inform the context tracking that the CPU is going
  *		     to enter user or guest space mode.
  *
+ * @state: userspace context-tracking state to enter.
+ *
  * This function must be called right before we switch from the kernel
  * to user or guest space, when it's guaranteed the remaining kernel
  * instructions to execute won't use any RCU read side critical section
@@ -595,6 +597,8 @@ NOKPROBE_SYMBOL(user_enter_callable);
  * __ct_user_exit - Inform the context tracking that the CPU is
  *		    exiting user or guest mode and entering the kernel.
  *
+ * @state: userspace context-tracking state being exited from.
+ *
  * This function must be called after we entered the kernel from user or
  * guest space before any use of RCU read side critical section. This
  * potentially include any high level kernel code like syscalls, exceptions,
-- 
2.43.0


