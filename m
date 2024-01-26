Return-Path: <linux-kernel+bounces-39580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A013E83D32C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199851F227BF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E337D510;
	Fri, 26 Jan 2024 03:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlNXMtTT"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8908AAD49;
	Fri, 26 Jan 2024 03:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706241555; cv=none; b=ul17LFdbx7ZV8iXmWTAX8QJClH0aoAKeVEfFTs73xCFm7mSCHJ5/fBjW0QJnbjWad418pl9Ixr0btD816eqUftnKcM+HfQD7u3+Z/w18vVha8JNZm4b7D4Qgfa1mlVf83GR9G33MDBr82GFZR5/nyIxMlO3OFDbRt5poAlHaJ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706241555; c=relaxed/simple;
	bh=hBCPkGjJ65HjQ3LsOgoo8bdn4EIv0ynlbU+AtvI1bdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWnxTcEU5mnUG9xTQfrOaR78rOhOQ6ZiDlHDIj3dK1kruFGMcbKrMacc9aCECt6KnpAXv06D7aMz9P3mNBiSQUSaTIqFXTuSL1tHMr/j/Pj3r2DCNH6zlGFO6U/uPDAo5E94myJ9tTmK1DTLdTAI0I4lvaVFEUqpVCvUI5/9pdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlNXMtTT; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7838af983c1so523019385a.3;
        Thu, 25 Jan 2024 19:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706241552; x=1706846352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MbVKZWY0Os5TUBZhFF56CwDVQ/x7CYcV1lUJHwb+gTw=;
        b=mlNXMtTTcDOPrzvPyPFzs7V0OQ8b51fs/LfgxtzgolFtUJANdRNflg3Zal2JE42j2x
         S/AwMC2rs7BN5byGPBXD+V0KtgDCppTo1EPAddWSXxwUYun2h4N0+6Ikhzw48TRNlNu4
         B0DNyIgEyCwAEGFTZyejgii5LPyGAqLptJliUTnVoOOXIupoTuiIM3WkNOePzbUD2TGr
         d92Li+G4D+CA5iJyFU8Z5QWQwInzd4IvXAGsMiCVGko1q5HNymDHJF+L+MERhwKQ8XyI
         rbm7pdJXzUuruLpaPIxBTp394MFL7yLSoP+YwcWKi4tLUjUmyu8B2d6nRY7hdFOe19Mh
         FHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706241552; x=1706846352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MbVKZWY0Os5TUBZhFF56CwDVQ/x7CYcV1lUJHwb+gTw=;
        b=i0HqlY24cl8bGSxchMeQYt07eRUKceixMgjKOlpWVs59qAmeJPUPkrMdNVKD/AdyT8
         KM6ZX8HiQp/Pa41I4CYkgyeXH3VHy8aoydnFtr+cSFsXOoY1Ujkqckfk8YYH9iFYXQbG
         M6P4MGwsRh5fqL111rQ969fkFBdUHwpHMoNbzIdck0WpNpry5ipiIPz78rlNXBBmUGQ5
         gXk+wJdDeBE2psVDxS8JBNrJw2QlMJczYrBGwwXyIatI0tEsG9FcOnLyoZ9boXQWRYtE
         CnTwuigXix/YoLWedSdmeBU5sbhRhUX0qYtgmxghYpX8TkpnJwx9V2XjHg892RfUIYpX
         NmOQ==
X-Gm-Message-State: AOJu0YxQocYpqZTH9DzTxvoL6OmXu5H7/Xp4ROM1jmz+s6tiKKhjBQh9
	R1ZFEjo0XDayHm/kSSrDs/z5d9xKGbVwhWWqXFYBQx6p+9Ek+ijh
X-Google-Smtp-Source: AGHT+IF2/H30FdZFYaNgUrshgbF1cza636jY3HAVqhz98hVTJmn6+UE0t3uF32TizGh7WE0MWW6Ytw==
X-Received: by 2002:a05:620a:849:b0:783:bb1a:613a with SMTP id u9-20020a05620a084900b00783bb1a613amr1099532qku.60.1706241552499;
        Thu, 25 Jan 2024 19:59:12 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id o6-20020a05620a22c600b0077f435ed844sm206011qki.112.2024.01.25.19.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 19:59:12 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailauth.nyi.internal (Postfix) with ESMTP id CC30A27C0060;
	Thu, 25 Jan 2024 22:59:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 25 Jan 2024 22:59:11 -0500
X-ME-Sender: <xms:Dy6zZaz-ywobFKCqOmMRAchuLvGLp2seBxScOJTF42rmCBsjpiI9Rg>
    <xme:Dy6zZWQTMBbX3jYfG4bGfSMLgQgJ0-I2IDYYbxDMm6VmT4c5YzwAUdLQe6ex9PG96
    ypy1MeK9Yx-f4fB8A>
X-ME-Received: <xmr:Dy6zZcVxdDPw7Re3VHz6g4Yn9urrq1vxnXh1uQNNmowkvahgNuAnH1rNO-o>
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
X-ME-Proxy: <xmx:Dy6zZQjbSoOVmZyg74M4xPialsBgPMfhu_k4u1cveTU2byBdoMfGKw>
    <xmx:Dy6zZcA2TD_UB2tnbx2BZRMvEx4oSgCgD5DooaefYC2vYHj0fuMP0A>
    <xmx:Dy6zZRJsiuYTAtl7BFdPu2zybo6yKq9-fKmfWWykIcox6CGrK_mN4Q>
    <xmx:Dy6zZQy1UcrvW9jYs3TkWHHHLyYqStgO7D1YOGVadfmzuKtkS2xrmQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jan 2024 22:59:10 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH 1/8] doc: Spinlocks are implied RCU readers
Date: Thu, 25 Jan 2024 19:58:04 -0800
Message-ID: <20240126035816.3129296-2-boqun.feng@gmail.com>
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
RCU readers in CONFIG_PREEMPT_RT=y because the -rt locking primitives
contain rcu_read_lock() and rcu_read_unlock().  Therefore, upgrade
rcu_dereference.rst to document this non-obvious case.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/lkml/CAHk-=whGKvjHCtJ6W4pQ0_h_k9fiFQ8V2GpM=BqYnB2X=SJ+XQ@mail.gmail.com/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/rcu_dereference.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/RCU/rcu_dereference.rst b/Documentation/RCU/rcu_dereference.rst
index 659d5913784d..2524dcdadde2 100644
--- a/Documentation/RCU/rcu_dereference.rst
+++ b/Documentation/RCU/rcu_dereference.rst
@@ -408,7 +408,10 @@ member of the rcu_dereference() to use in various situations:
 	RCU flavors, an RCU read-side critical section is entered
 	using rcu_read_lock(), anything that disables bottom halves,
 	anything that disables interrupts, or anything that disables
-	preemption.
+	preemption.  Please note that spinlock critical sections
+	are also implied RCU read-side critical sections, even when
+	they are preemptible, as they are in kernels built with
+	CONFIG_PREEMPT_RT=y.
 
 2.	If the access might be within an RCU read-side critical section
 	on the one hand, or protected by (say) my_lock on the other,
-- 
2.43.0


