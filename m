Return-Path: <linux-kernel+bounces-112884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93308887F7D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69F51C210CF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724C044C87;
	Sun, 24 Mar 2024 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1R+xqfN"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01E04085A;
	Sun, 24 Mar 2024 22:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319663; cv=none; b=nFfhwQ6Dr+YAkBBekHrvhXMDt5N4K/TAh47FdTqpvjYnY4wDT+9w6YHbhks7NR7Wa15Ixrnei8N329aOLKv0KD9aByhyAUmFxyDpjlS/wAlY7ZrWCHK5/n9vxlXGdxqCHAtSMfUrTtQTXsNQ5Z5YaR+IncGUJBLezaG8/MH/sp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319663; c=relaxed/simple;
	bh=rblbZbeUNDFkN6Ya4j5DhEAFl/f3CnZ68qMOk7KGkcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=do07k7R1K4fd7YNZISi2Ml+KTx6asdgQlYOiWqbM1Kp52lEwL0cz30CEdGJDIdt57wI9eQIQwOqczhDBJDTUjXIgC9uKCtaAyqk2f97N3kzG57h7veNfKoK+edsefIK5sxOjmBX5dLFafPRsiR8pIcpDWx0+JsFgSDuR5FwY+HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1R+xqfN; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78a5580324eso26510285a.3;
        Sun, 24 Mar 2024 15:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711319661; x=1711924461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r4dkugQkcRSjLN47IMqLis/1vAo+zF2RZMH9C3fgvJ4=;
        b=K1R+xqfNaBFKjCbU9RZeZ0xAtQSzd42QwsQfJugTXogkO90NBOpeaS4f7Mmxd9onrd
         1DegnjrAyUHhJJewfdunuxei7Icv6gp/uIg8NLYLuH1S+AriQLqyvgCzNgMS9fK9D2HK
         Oxm0hISab4cZQ9GMhZ7dbAXfnwRdIcat0Fzu5OwzZCFT7tP3j4JNytvWIPqCyd6ivruh
         NgZ96mDTw7ik+RcAETTWxJ4CmcDyW3TkNCXO/Ki+2v61dUUa6nx0JnIU2kafnbKwPH53
         jyjj+K6Rvdz7AnopH3Oz/rEvw4GPLl6h10uREmG3DXPZ19H8F1RmzZWkf/HFxQZ682aJ
         pvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711319661; x=1711924461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r4dkugQkcRSjLN47IMqLis/1vAo+zF2RZMH9C3fgvJ4=;
        b=B3s9q7UjGnU8wR2D/T5a1nj4Nk5Z/rbMHIMc0TXAJCIdte9PflzDS055fPhvB+Cdte
         nG6LPL4Tys5O2A/VGKFwdec4HrC9U12RcgS0irT4FE58zGysS7E8dXHC4vcF0jZdyJZH
         hUTu4H7C2oDYNEFegUhcr74APwARTpfAXd/S9yFN2bqp/1Ha+AJrmLEiLDjuNKBNefBX
         SF02lRmeDDPSNuLD7xk1V2V3dO/pM8Ln27H/Lor9ssMi9MDNZ7X7nfBmQV0mzOcbBCg9
         /9pEKbXSOvZSm6U/F3K1RwHyw0eavy12PZ9lmqvTC1sUHYw0SpGgWRBGd7/k/FP/UxHs
         VDWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN24RQHCtg63cJfLGciRJ/6ZjHY2bJcKMIFaewa43oztLZH/XeIJA0TCG906OowQu+vN8tjZw81Q7L27UfeoulQWvvoDUcsypacldr
X-Gm-Message-State: AOJu0YwuzN8SN74P0l7iyqH4CmQANBfHctXW7NcreUctEkf1utxdyRk6
	7RcA1ba9rduAspjl/sZMsCTu4cwZ7BNXJD9OpfDVnyyKfKMXgF65McvrILz8
X-Google-Smtp-Source: AGHT+IEGXwFi4OApdpQX0xAGF4IQqEMsHc2HieH20JpsoDEe2F+hszVBR1E3kHFAFNt1xADcoOjI+g==
X-Received: by 2002:a05:620a:5d82:b0:78a:2b1b:e56b with SMTP id xx2-20020a05620a5d8200b0078a2b1be56bmr5899720qkn.68.1711319660903;
        Sun, 24 Mar 2024 15:34:20 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id q3-20020ae9e403000000b0078a48172335sm1356193qkc.24.2024.03.24.15.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 15:34:20 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailauth.nyi.internal (Postfix) with ESMTP id EAE1D27C005B;
	Sun, 24 Mar 2024 18:34:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sun, 24 Mar 2024 18:34:19 -0400
X-ME-Sender: <xms:a6oAZp5zQput8PTUkfkglQ-44m1TzYe8VaA-Ze6qviqyVBZFPKFnIQ>
    <xme:a6oAZm5KybByycoyXrMS-NPSIwkb_eoli4CnYVDShobTVzaCc74WQSfnnTLFhCXqu
    y1uKhKt-AkQYkYa3g>
X-ME-Received: <xmr:a6oAZgfdWxfVuAYh3clpSbjZ1vNmhPVKJ1kgp5xZncd2c1PAk0O00qCz9cA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtjedgudeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfevffeiueejhfeuiefggeeu
    heeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:a6oAZiLSCJTVAK3qxVMl1V9DA5Tt8Vax52T3LG-I0Nf4ZiWT53zeaw>
    <xmx:a6oAZtLIJ2StmFQjg9fybjgeDx1a7GhpSE-y6tEkHeiM7sA_1UbdjQ>
    <xmx:a6oAZrzJ2yFWVPYzHOnDtzUYWOktwohkSbc251lSkkYwPpYpQrRZrA>
    <xmx:a6oAZpJewVVPv0lu_zWHT3CoxI05dG3oCLDgTncjCeZ3AGHXFRuPpQ>
    <xmx:a6oAZqfCwaF7xOH_w-9qGjY5UdxRpTIncgJ2n3hNFDUobk0-6Z-ETQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Mar 2024 18:34:19 -0400 (EDT)
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
Subject: [PATCH 3/5] rust: time: Introduce clock reading framework
Date: Sun, 24 Mar 2024 15:33:37 -0700
Message-ID: <20240324223339.971934-4-boqun.feng@gmail.com>
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

To make sure Rust code doesn't mix timestamps from different clocks, a
type safe clock reading framework is introduced. It includes:

* A `Clock` trait that represents different clocks, to read a particular
  clock, one needs implement the `Clock::now()` function.

* A `Instant<Clock>` type that represents timestamps of different
  clocks, whose implementation is just a `ktime_t`, so all the
  calculation on `ktime_t` should apply to it as well.

Co-developed-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
Signed-off-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
Co-developed-by: Asahi Lina <lina@asahilina.net>
Signed-off-by: Asahi Lina <lina@asahilina.net>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/time.rs | 49 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index b238b3a4e899..0f9f5605ed48 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -6,6 +6,9 @@
 //! have been ported or wrapped for usage by Rust code in the kernel.
 //!
 //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
+//! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
+
+use core::marker::PhantomData;
 
 /// The number of nanoseconds per millisecond.
 pub const NSEC_PER_MSEC: i64 = bindings::NSEC_PER_MSEC as i64;
@@ -64,3 +67,49 @@ pub fn to_ns(self) -> i64 {
         self.inner
     }
 }
+
+/// Represents a clock, that is, a unique time source and it can be queried for the current time.
+pub trait Clock: Sized {
+    /// Returns the current time for this clock.
+    fn now() -> Instant<Self>;
+}
+
+/// Marker trait for clock sources that are guaranteed to be monotonic.
+pub trait Monotonic {}
+
+/// A timestamp of a given [`Clock`]
+#[repr(transparent)]
+#[derive(Debug)]
+pub struct Instant<T: Clock> {
+    inner: bindings::ktime_t,
+    clock: PhantomData<T>,
+}
+
+impl<T: Clock> Clone for Instant<T> {
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+impl<T: Clock> Copy for Instant<T> {}
+
+impl<T: Clock> Instant<T> {
+    fn new(ktime: bindings::ktime_t) -> Self {
+        Self {
+            inner: ktime,
+            clock: PhantomData,
+        }
+    }
+}
+
+impl<T: Clock> core::ops::Sub for Instant<T> {
+    type Output = Duration;
+
+    /// Returns the difference of two timestamps.
+    #[inline]
+    fn sub(self, other: Self) -> Self::Output {
+        // `ktime_t` is an `i64` value of nanoseconds, and kernel defines signed overflow to behave
+        // like 2s-complement, hence `wrapping_sub()` is used here to mirror `ktime_sub()`.
+        Duration::new(self.inner.wrapping_sub(other.inner))
+    }
+}
-- 
2.44.0


