Return-Path: <linux-kernel+bounces-112886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2082F887F7F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3BF51F21310
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF4B4654E;
	Sun, 24 Mar 2024 22:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnMexYax"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D666145027;
	Sun, 24 Mar 2024 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319666; cv=none; b=okneP21+0SEIkBYrJlKFIvuSyTVJ7y6rIfZOJCkbGO6DWv6fWgzUQjhS30suEDyXwEaDXhPhaw4qt/9NLYMsW7GHwjUye5CBbvZH6x+SOTMHcOQSGlNISE6nEI83pcmXpV1whIo8cwzLwXMvTltitpq81jFw/r1oofqCFA37kQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319666; c=relaxed/simple;
	bh=lTwVdmQCrScr7m5mI/A+ln2I0q5l4JBsQMRgmXUoJ3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyLRWzQmWC/Bk97TlZTnbmC9uJ2mn+eEHRs8g+rIMAWFVsKYX45Ap2LfGdeoDfTgyHdpKULXZHcK4xVhnZ+qEhThDMrkqqYMDuohMMoI4qVi/PUEiesmsiI55vz0+8AYsNMuaUu8/PTFld7oG8QOZHJzbW8i1C+uVPra23hH9U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnMexYax; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42a9c21f9ecso16186301cf.0;
        Sun, 24 Mar 2024 15:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711319664; x=1711924464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZEa8g/haIngtd9EpZwnZ7Ys0qyF84K/G4/YzTdjByEo=;
        b=KnMexYaxRUU0FeoWJcoYitFZWyJ1dMQ88xehbhuXXND3KT6/krUGhm7R+I5ZrKKz5C
         c50Sa7EBBe7S8HalDnDE6bLEtc9mWJ24LzsDQl1vaYIqDyFAMQAP5hj8ZFijQoEqi0iB
         zzZXCxH/eFsPaoVYkuVkvCEjE98PIBiDc/Rg5oipcsRFa1FQDYzSBAQsQ3Gc0bSnBN7b
         xuj8yM9Gh8R/vrUwhB0Zh10FBuHHMJTPF0F4lKGNzKcP84nfPMzXlBT0LxXv8jwkfHAe
         PQmWS3XucQNjrmGNoFutJaTXCLeKE8kvINsinu5BTppGcWsVZakwrjDETQuQlAXltgPf
         /+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711319664; x=1711924464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZEa8g/haIngtd9EpZwnZ7Ys0qyF84K/G4/YzTdjByEo=;
        b=Ah1uAFrddukajt6zuAN7ECjRsmhOUE1KjwtK9x00Rxh6fhupnpiAI+U2kzIlRIcE1Z
         clbBx522wmRFi1NS8f1b2ukxMfp69dXT/mEMYkA0Ad7pEvN3hPXaRkSF0a29WTdXsggp
         UD2IZVu66RmZfOuvq0IxaDrUwjWu9WJYStgpavw7bFInGXDN5L+Zy2j741G181wACgIs
         7qhCaEk8bE8k9ApX1xc8eZb7prfWk8GOuMsR9/4y3aX2GP9fcsiNEA6s9Sq/0yfVMHl7
         8r70mRvE0z6YE2ORzCNG9X1TomWpRo6ZA31SUNw0Q0ex9ieI1plJGzLAtj6LsJ2aStxT
         K7Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVeUH+RVmNSOyMkSsj6Qv8tPpZHDVsdKJMPgaW3wCgMPOVYhVW/dX54VkzKofj/T/gcUdwshA5xAchW4XH3tyajdrpPe+aoLtuCkDEM
X-Gm-Message-State: AOJu0YwLoJpKleGOazJu2PTAaobedEjv/EwVxnWmN8waS5GULl8ConEU
	1ymrDQREbtemKePP+A3Jlz1TMnudcOCLGSC860SSbtQHpGhO1rwH
X-Google-Smtp-Source: AGHT+IHTDI1JEoCUmChP9SyqwdtkgaX+JR845mvTO/Rmz18qw2TzjG+FQ3+khfqZhaaZOZ9wobjYgA==
X-Received: by 2002:a05:622a:4e85:b0:431:3df7:6fd4 with SMTP id dj5-20020a05622a4e8500b004313df76fd4mr6891381qtb.2.1711319663869;
        Sun, 24 Mar 2024 15:34:23 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id hg1-20020a05622a610100b00430b5dcac34sm1980354qtb.8.2024.03.24.15.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 15:34:23 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 052F21200043;
	Sun, 24 Mar 2024 18:34:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 24 Mar 2024 18:34:23 -0400
X-ME-Sender: <xms:bqoAZjzH91fseOcpxyUqnkOJaUCxxQ5d_PYCx41sxsIebXoG6WvMeg>
    <xme:bqoAZrTYxQzq1o-0E08galIBFp1gpwgATthEH9mT5F4KbPwBhyYfSO8MVn9yCBHqh
    9SNt-i_UwsAhH92ng>
X-ME-Received: <xmr:bqoAZtVUPwam5-ivfFZPRvzJ0fIN5bOEN4VbcbeayhjPI5tAym1AFgIWfOo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtjedgudeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnheptdehvdeivdfhieffgeegleetfefgjeefgfevvdfhteeljeehhfdtvdfg
    tdehfeetnecuffhomhgrihhnpegvlhgrphhsvggurdhtohenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:bqoAZtjobb75JV_rmbMOvzJdBAQkIwS_qeDMpVaXCFlOTGgBwXOpxA>
    <xmx:bqoAZlD4YQeo0HZjhyzI8Bu3__J9-3aHSAw3ohc5ThY2GKYm-iDuQQ>
    <xmx:bqoAZmI2dfTbWT6ecO_hI-UDMZ2q58BMgrJurie2P59ankTWshkXvA>
    <xmx:bqoAZkDFufUuHpVjmW2wiJRph1SpNVUrBE5brpQ8MFL2xHPdQ6fjjA>
    <xmx:b6oAZp2D1xOUuT11qoUJw_XseWiMlVPQUZDYsKqzmhY7S9zglGgVKXENNmc>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Mar 2024 18:34:22 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	benno.lossin@proton.me,
	Andreas Hindborg <a.hindborg@samsung.com>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	Heghedus Razvan <heghedus.razvan@protonmail.com>,
	Asahi Lina <lina@asahilina.net>
Subject: [PATCH 5/5] rust: time: Add Instant::elapsed() for monotonic clocks
Date: Sun, 24 Mar 2024 15:33:39 -0700
Message-ID: <20240324223339.971934-6-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240324223339.971934-1-boqun.feng@gmail.com>
References: <20240324223339.971934-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a convenient way to do:

	t1 = Clock::now();
	...
	delta =  Clock::now() - t1;

Hence add it.

Co-developed-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
Signed-off-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
Co-developed-by: Asahi Lina <lina@asahilina.net>
Signed-off-by: Asahi Lina <lina@asahilina.net>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/time.rs | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 5cd669cbea01..cd1e45169517 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -114,6 +114,31 @@ fn sub(self, other: Self) -> Self::Output {
     }
 }
 
+impl<T: Clock + Monotonic> Instant<T> {
+    /// Returns the time elapsed since this [`Instant`].
+    ///
+    /// This provides a convenient way to calculate time elapsed since a previous [`Clock::now`].
+    /// Note even though the function only exists for monotonic clocks, it could still return
+    /// negative [`Duration`] if the current time is earlier than the time of `&self`, and this
+    /// could happen if `&self` is a timestamp generated by a [`Instant`] + [`Duration`].
+    ///
+    /// But for typical usages, it should always return non-negative [`Duration`]:
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::time::{Clock, clock::KernelTime};
+    ///
+    /// let ts = KernelTime::now();
+    ///
+    /// // `KernelTime` is monotonic.
+    /// assert!(ts.elapsed().to_ns() >= 0);
+    /// ```
+    pub fn elapsed(&self) -> Duration {
+        T::now() - *self
+    }
+}
+
 /// Contains the various clock source types available to the kernel.
 pub mod clock {
     use super::*;
-- 
2.44.0


