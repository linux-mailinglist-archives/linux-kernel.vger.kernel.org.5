Return-Path: <linux-kernel+bounces-48-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60228813B39
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12291F22582
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196C66A029;
	Thu, 14 Dec 2023 20:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuExpyrx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07EE6A014;
	Thu, 14 Dec 2023 20:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-77f50307a1fso430786785a.3;
        Thu, 14 Dec 2023 12:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702584272; x=1703189072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eS37CR7+TgFqv3CfKfPzO9kSVywAUrgFAe0aN8vgnU8=;
        b=GuExpyrxeZEriSoJjrkbKxkiKi/OrYWSTMmfeoguXjRULLcKflbiGcyLhg+J5zN5XE
         5HMrS3D1ucpzmuBAaAnmBFEdBI5HEnnWCwuRCFqU4qMRY2/OdYD7qDWaBNVkiuJ5Hpy4
         ux1ckwuX8tuM3RhLeVCfQ7GBfj+cPZOR6XmnCr2xEyaaLYQit90mzzZ+9KjNU8IwaB/3
         EUsn2JBUD4xqwizROElWNBk9dP6QrGzXh3E9OW7oS214jGDNSh8eFg2jx95rYRS9liPK
         tXoIV13Je0FBFKBTCr1ANYMttbcEAjjlsloiu0/v3uF6GlqW+Wi/PhTQMOsKG5/a12tZ
         0i0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702584272; x=1703189072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eS37CR7+TgFqv3CfKfPzO9kSVywAUrgFAe0aN8vgnU8=;
        b=XJJn0wIfIGuS/PPXvwhVEfEOAqyG28v9LAITjePiLQyOSDqnNsml941iL7v7GONrWW
         XpK9c0JtgmLho5P0ocUvXSuqHYq+pLOE71jmyavC0Fnx7hJwUr0gs4wNmX1p7lzewhTk
         5u7bVN/gX03TkJ7G6SlYYyuk+EiNvZvx5CL0k0kxhJRyWayQWgnbwtbv1klidoIXqzS5
         r3FYPC/DoQMvteBAEZaprGpc1dR0ZGesYWXvy9XssQf5UqCmKbSbmpcKkxaUHF8YsCDs
         GeAC69gsz+19ia4j5DctjGZmRRjV1rVz+DI/hn2iY2lA4eyTxw0xRccI+Kev9T5neS4W
         al+Q==
X-Gm-Message-State: AOJu0YzirAAAqGZAeoa7liy1gQra8vtopX4BKZQ4IPaWYATuF97hbRPy
	7cL74rDXVwXddaQVDnu/CsY=
X-Google-Smtp-Source: AGHT+IFztxz6kyHlFdsQ7JJ9iHn6YX4wlHV9Fm3nUlWYBdh/H4noSL8LLkfqR72Kx0US/1kQ8MpjsQ==
X-Received: by 2002:a37:e10c:0:b0:77f:2cad:7122 with SMTP id c12-20020a37e10c000000b0077f2cad7122mr11895872qkm.77.1702584272305;
        Thu, 14 Dec 2023 12:04:32 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id qg1-20020a05620a664100b0077f01c11e3bsm5567151qkn.61.2023.12.14.12.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:04:32 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailauth.nyi.internal (Postfix) with ESMTP id 84F3727C0054;
	Thu, 14 Dec 2023 15:04:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 14 Dec 2023 15:04:31 -0500
X-ME-Sender: <xms:zl97ZVTPbCK476-n_6TA4twJNvmCfvsWzbDCFhpi2CdzVEzO2a7Zcw>
    <xme:zl97Zeza_6vcAl_6OOAmZKBTFlPMaB5djVg7QzZ6gLzaJxLBDF-lnCRZPapGyJjTQ
    uXHpMZwo6S8s2UuvQ>
X-ME-Received: <xmr:zl97Za2WkIsyeKy8uq3xIDGi0NYKiQv0fdGniahGOaBoIYgW6cNP3o9LQKrkYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelledgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfevffeiueejhfeuiefggeeu
    heeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:z197ZdABT4Yrlxg1ufTDgirCma2ZkYQbVZk_8mQxQqOPRn79fCMXbA>
    <xmx:z197ZehpSHP3NYDpzJhBMCKPgO71purwu402O6oR6rck6Qz9kpAY2A>
    <xmx:z197ZRokwnfTExOU4S7OhD8f-4CnitAh5xmkYa8rkTgVuANB8sHtiA>
    <xmx:z197ZSzhi-QOWYpuiZPz4asVjA9WwfTT49vSW4I6r-_z1GsxBJ0Scg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 15:04:30 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tiago Lam <tiagolam@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH] rust: sync: Makes `CondVar::wait()` an uninterruptible wait
Date: Thu, 14 Dec 2023 12:04:21 -0800
Message-ID: <20231214200421.690629-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZXtebif2S1CyJRik@boqun-archlinux>
References: <ZXtebif2S1CyJRik@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, `CondVar::wait()` is an interruptible wait, and this is
different than `wait_event()` in include/linux/wait.h (which is an
uninterruptible wait). To avoid confusion between different APIs on the
interruptible/uninterruptible, make `CondVar::wait()` an uninterruptible
wait same as `wait_event()`, also rename the old `wait()` to
`CondVar::wait_interruptible()`.

Spotted-by: Tiago Lam <tiagolam@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/condvar.rs | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index b679b6f6dbeb..8630faa29b78 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -50,7 +50,7 @@ macro_rules! new_condvar {
 /// fn wait_for_value(e: &Example, v: u32) {
 ///     let mut guard = e.value.lock();
 ///     while *guard != v {
-///         e.value_changed.wait_uninterruptible(&mut guard);
+///         e.value_changed.wait(&mut guard);
 ///     }
 /// }
 ///
@@ -120,28 +120,28 @@ fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, guard: &mut Guar
         unsafe { bindings::finish_wait(self.wait_list.get(), wait.get()) };
     }
 
-    /// Releases the lock and waits for a notification in interruptible mode.
+    /// Releases the lock and waits for a notification in uninterruptible mode.
     ///
     /// Atomically releases the given lock (whose ownership is proven by the guard) and puts the
     /// thread to sleep, reacquiring the lock on wake up. It wakes up when notified by
-    /// [`CondVar::notify_one`] or [`CondVar::notify_all`], or when the thread receives a signal.
-    /// It may also wake up spuriously.
+    /// [`CondVar::notify_one`] or [`CondVar::notify_all`]. Note that it may also wake up
+    /// spuriously.
+    pub fn wait<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) {
+        self.wait_internal(bindings::TASK_UNINTERRUPTIBLE, guard);
+    }
+
+    /// Releases the lock and waits for a notification in interruptible mode.
+    ///
+    /// Similar to [`CondVar::wait`], except that the wait is interruptible. That is, the thread may
+    /// wake up due to signals. It may also wake up spuriously.
     ///
     /// Returns whether there is a signal pending.
-    #[must_use = "wait returns if a signal is pending, so the caller must check the return value"]
-    pub fn wait<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) -> bool {
+    #[must_use = "wait_interruptible returns if a signal is pending, so the caller must check the return value"]
+    pub fn wait_interruptible<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) -> bool {
         self.wait_internal(bindings::TASK_INTERRUPTIBLE, guard);
         crate::current!().signal_pending()
     }
 
-    /// Releases the lock and waits for a notification in uninterruptible mode.
-    ///
-    /// Similar to [`CondVar::wait`], except that the wait is not interruptible. That is, the
-    /// thread won't wake up due to signals. It may, however, wake up supirously.
-    pub fn wait_uninterruptible<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) {
-        self.wait_internal(bindings::TASK_UNINTERRUPTIBLE, guard)
-    }
-
     /// Calls the kernel function to notify the appropriate number of threads with the given flags.
     fn notify(&self, count: i32, flags: u32) {
         // SAFETY: `wait_list` points to valid memory.
-- 
2.43.0


