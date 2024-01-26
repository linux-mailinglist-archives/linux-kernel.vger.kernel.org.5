Return-Path: <linux-kernel+bounces-39586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D733783D339
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 05:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D4B1C227E8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ABB134B2;
	Fri, 26 Jan 2024 03:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RejISDg2"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53D5BE7D;
	Fri, 26 Jan 2024 03:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706241569; cv=none; b=myKDOks0dn/d8n/y9RMnR/Cjhru0Gt1PsMLy1MJD+pkchs8DpdRH8lSNll3YjfW1d5w82IUNDt00hLWFpD4IV4VyhCxVOTqA2Ml1P919pWy79EWmO6SpavOsYEMV7BZPCz9U5jz4Dh7QjhpfwpeS//lf47MXbvhm5RYOnp9TYfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706241569; c=relaxed/simple;
	bh=WrDRcgmLN8FYE1bEh/kSEtEYeR20GP5oA7YAlESBxuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWUbn2AyLzRBcPPINmWORMY99ZYVQtvKk0xC7RYnSJ5r9j7pivMSwmMDQw2fjxRRA8ucnt+wKpheqZ2pGnh0qJYKEP1UBz81IVt9q1mI8vQNF9zIy9ZfpIUEHqjVMX4gtRc+Mjxt+daEhSLSbXYOrlneAgOpVe3YuTHeD8HLhn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RejISDg2; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-429fc7a1eacso61135261cf.2;
        Thu, 25 Jan 2024 19:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706241567; x=1706846367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l9OeCrZN9N7atb9ofVz4/T9GOrOzsVAdW3jedBYP9VU=;
        b=RejISDg2HCAVvd5gT2r/mHdqG6YVhLK67Wzkig7CmTuokSIreiyl/h7JPHE0PaEsUA
         COZTqh91U4z1DtNEZaom3q7k2sXG0kULLBbVfwWs9S5GIhfaSe7ph2Vh1btsBa9vFemd
         vF0gPVtMcrU0wo4A5U5v1qruWSpYj+LLynicKr4eKigvsfyWhfd9CB6nA2sZ0UuWPik5
         6LPQ3hjLINchdTAEr+9CvGxmv1z2M+iHbLvPl/R8ybH01T5fgkXEWGLLuitrf2MpyRBf
         WM/yKZ9fBc0ARWg/wV4yTyok2O1XIBtBHJdRoHI1ZJGfD36H1o4qEjEB/cryMPz3sUyp
         8r/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706241567; x=1706846367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l9OeCrZN9N7atb9ofVz4/T9GOrOzsVAdW3jedBYP9VU=;
        b=s6/NRzhYIGxH0MJjCf2Jvhdz8ubDNJTj0er5XDTjVbgx4O5aM1oU9DzlgeFenLx+TP
         JnE84OuEspvjRetmR2W9vIHO3YCiuNFophwV9wIEYVkCOufSj8NdIXBuecmgmqH7sE6z
         2vX8B1182KMdOmKLOwUoJac2AYEEUdk65YNKsGb+M9BZItu0PwHi5jjYLPyj0g4EuW2x
         2oha2KoQsoNo6JEqR0kOeIzI+Qy7TtN0C8Rqzbj6y8hb6d0/P5uy0N4+8r2C3YyR5puQ
         SHg2K1ycXIpgmyUpsCmQSh0mehQGhg4tynVcGAUp2Q/N5BiAeElFY0NBbVdsgn0u9jvT
         GXWg==
X-Gm-Message-State: AOJu0YxFHdzn6z3XvPJX5FckJin+uPIxEjxXlIYZJVsmjANS5kYoUjNV
	lJalOMy9jCtJsBh/Lsaco5bDs+mFfyQkd0/9xxa9RneZ74hv4xR/o/X7dAcF
X-Google-Smtp-Source: AGHT+IFlfH/qFjflfH8QgKUnkJEf9/a6tNBiyKLH+QuE2B0RgGsrDGlb0BlmUIwt88h1DF7iojorgw==
X-Received: by 2002:a05:622a:1312:b0:42a:5a5b:82bb with SMTP id v18-20020a05622a131200b0042a5a5b82bbmr871658qtk.106.1706241566789;
        Thu, 25 Jan 2024 19:59:26 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id kb8-20020a05622a448800b004280cad48basm145312qtb.77.2024.01.25.19.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 19:59:26 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id F101627C0060;
	Thu, 25 Jan 2024 22:59:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 25 Jan 2024 22:59:25 -0500
X-ME-Sender: <xms:HS6zZbBf5voXnTyVVHk8vdoXOf-vobxvxfj51Qa6Iun8311OQxDlPA>
    <xme:HS6zZRj6ROzeH8DBvWdXUHEMp0bxiAsnKLb41XYuwdmVLB_zMRYCB4_XeDYOZLn6z
    YSWScByHT1TLAG2CA>
X-ME-Received: <xmr:HS6zZWlkkOdEYDWJki11vpj-eVYegYIWXMxNnHPB-kJnwD5jx2UomB_Ui9o>
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
X-ME-Proxy: <xmx:HS6zZdyCYDYaXhEffOrQPGN6w5FW3eqPqT_hlDWMfCzHSliCpaYr0w>
    <xmx:HS6zZQQkvYP95cImqo8YYKEJqUyquHO_0PVL-949fN6erRdx-AIljQ>
    <xmx:HS6zZQaKejLg4Xe9FGhpfgZOFhSTLG4aBnGRewOT158rCA-_h1Q-0Q>
    <xmx:HS6zZXJnci7PRKeHAy8WsocOVWhAPi7MtaEKnJHw1bXMcSShm2_L_w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jan 2024 22:59:25 -0500 (EST)
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
Subject: [PATCH 7/8] doc: Clarify use of slab constructors and SLAB_TYPESAFE_BY_RCU
Date: Thu, 25 Jan 2024 19:58:10 -0800
Message-ID: <20240126035816.3129296-8-boqun.feng@gmail.com>
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

This commit explicitly states that you should initialize any locks to
be used by readers in your SLAB_TYPESAFE_BY_RCU constructor.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/whatisRCU.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index 246ce0d0b4d1..872ac665223f 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -963,8 +963,8 @@ unfortunately any spinlock in a ``SLAB_TYPESAFE_BY_RCU`` object must be
 initialized after each and every call to kmem_cache_alloc(), which renders
 reference-free spinlock acquisition completely unsafe.  Therefore, when
 using ``SLAB_TYPESAFE_BY_RCU``, make proper use of a reference counter.
-(Those willing to use a kmem_cache constructor may also use locking,
-including cache-friendly sequence locking.)
+(Those willing to initialize their locks in a kmem_cache constructor
+may also use locking, including cache-friendly sequence locking.)
 
 With traditional reference counting -- such as that implemented by the
 kref library in Linux -- there is typically code that runs when the last
-- 
2.43.0


