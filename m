Return-Path: <linux-kernel+bounces-2232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF2F8159FB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 241C7B241EA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 15:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D81315B6;
	Sat, 16 Dec 2023 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O4GYevy6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159D730F8F
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 15:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5cf4696e202so19858577b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 07:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702740718; x=1703345518; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T/ddlBRhTE0D+FYTRDCtGuJMObI89/Ad+6YQTmYW7YA=;
        b=O4GYevy65C8yLpH5APpvEknmJnjmCzn5uPsm6HRyvcXFutxrvG+DD3zjZkZJFwul/K
         MT8Q10Oy2QEaKCVt0VjmO/lJWJ+GPihxMjbOw78/hqscF8miJnL2NuCEjnhiZGND6gh1
         PvoxwtY7u2sFdDs2g0bHTCyF8zbQo2qmUTKHtIpaYgaeYy0SVGBNH5LGWgEHf4G32IAT
         JKlGQGOV1d+Ud60nYOonqGBLPwU9+bQYNLaLc6GLBtVMi6qBux5y+5Lt0XAcGSPoW8sR
         nxv5j+1sUNhL9dZWa/sJtlGTiJGe65V3Y+peLa7xUun412cqe1yEJjmze5ksk+uT/BpL
         HCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702740718; x=1703345518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/ddlBRhTE0D+FYTRDCtGuJMObI89/Ad+6YQTmYW7YA=;
        b=Fu7ksUgvk8AYFWJVAo+qGQ15WuZWxFDz6EXbjGlEJy0QmZUFE4lj9IND0toeSEJfWP
         v3YK7ZOazks3WWAGGJVzvvGSSQ8JtkkULMPhA0IznXIXJ8LFqy0Achrb2EvrQqvIBlO8
         RYmYhTEaJCytPLMQJ2sZfMxzTx05XSn8y1zI8RTI2MLJVaELfHoxIyuwx9NlYD98/9aV
         4+hJaK0MBQR4hHrTk31t/ZRETeo1mrFR83MUuGACtPdXA5Sv1MeHmYetld0h37Cu6U/5
         izHyZgs8ZU39Hb9BZ0YxgVwlnECfpj/lxj/EqR9D7YwXz+mQ14/uGU/0gh8sg9VKUKfC
         fQUA==
X-Gm-Message-State: AOJu0Yz92rXejU6i6MCcHj/ABOye3D+6VHxJfoOBgrNgWXrDrUFSAwiA
	yrAacR98O1t0B6J7YazgPaVJIWJn/tr+5Hs=
X-Google-Smtp-Source: AGHT+IGVKMCUskWZKxPFNRIG6Xo50mlBjoKSY7G0F4Z6hsa3Ztbi2UoKKWL4LxG+4j3srMjp3appHKyqifwdlX8=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:a8c:b0:5d7:8bf2:de42 with SMTP
 id ci12-20020a05690c0a8c00b005d78bf2de42mr772473ywb.9.1702740718105; Sat, 16
 Dec 2023 07:31:58 -0800 (PST)
Date: Sat, 16 Dec 2023 15:31:41 +0000
In-Reply-To: <20231216-rb-new-condvar-methods-v2-0-b05ab61e6d5b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231216-rb-new-condvar-methods-v2-0-b05ab61e6d5b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6461; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=uF4Q1+xxQjulRgS6F2spL0AmSmj4UawnBJX/beYz82U=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlfcLg/1Olosyur+zr0QwGGVAhRokjwG/43yx/u
 5HP8Eqs2T6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZX3C4AAKCRAEWL7uWMY5
 RpgkD/0VzqMF0pkgpx5FVS6mKRSKNy2iC81KBiuS3iCje6w1qE7cQUwVUzztbmbMKxUTot5eDeB
 GWkUEmNPv9wamZc6JOd9Qp/lE/IusUyh3KX+EjcI3uu2ez2WDSd0TpDxrZe6zYJUAlDWcIfLY/d
 Dt+pSdSF/kgbWFMugAapMON6+YIAjBwD++SogKtA7b85i7OgnwT6Zz73a71hD9IUa4GxznEX0VN
 WXKt8QclmH2JMbcXzn5OSYid9VmUh3ip61MXHMQYoKC6Kt9XYBfX2KVZJmIgxsIIW3OcUf9lArf
 wPsIUR65sh7J+p4xCiKGz+uEAGn9/Eqw1mZyq3L1/0Hze2+0S+ZmsWcVP5WeoRqEUbmQIyck36R
 F9qLgwehSaLY01SV7MVjzBK/78ViN2ficq8TrJZ2hPlJtvWOJ2Gf/MGXWexUuHTMOKUSqq5uZon
 r0ZqUQGhbqu6bcMuG+U04nWwSPrIpdWTIJ5HY+uDVs+pSHQtCDJA0CBapRW0/BjrpaJq1WQkj6x
 l4DvpAp28A7PeVcp3HDnyOHDg0pNmN16D4XdnC+lUD+EAOht3KIVHZ45JglrrkRVy7g2fxPzlsE
 xCc61pfs9BenRJBOHFuGaKersznboXJoZq5wJu+V6h9MHSuKUS3t/hZHgOopjVL9TfsfEZgJeHn wOQfQLCEr6hFYhg==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231216-rb-new-condvar-methods-v2-3-b05ab61e6d5b@google.com>
Subject: [PATCH v2 3/4] rust: sync: add `CondVar::wait_timeout`
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Tiago Lam <tiagolam@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Sleep on a condition variable with a timeout.

This is used by Rust Binder for process freezing. There, we want to
sleep until the freeze operation completes, but we want to be able to
abort the process freezing if it doesn't complete within some timeout.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/condvar.rs | 59 ++++++++++++++++++++++++++++++++++++++++-----
 rust/kernel/sync/lock.rs    |  4 +--
 2 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 9331eb606738..0176cdfced6c 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -6,7 +6,8 @@
 //! variable.
 
 use super::{lock::Backend, lock::Guard, LockClassKey};
-use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaque};
+use crate::{bindings, init::PinInit, pin_init, str::CStr, time::Jiffies, types::Opaque};
+use core::ffi::c_long;
 use core::marker::PhantomPinned;
 use macros::pin_data;
 
@@ -18,6 +19,8 @@ macro_rules! new_condvar {
     };
 }
 
+const MAX_SCHEDULE_TIMEOUT: c_long = c_long::MAX;
+
 /// A conditional variable.
 ///
 /// Exposes the kernel's [`struct wait_queue_head`] as a condition variable. It allows the caller to
@@ -102,7 +105,12 @@ pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self
         })
     }
 
-    fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, guard: &mut Guard<'_, T, B>) {
+    fn wait_internal<T: ?Sized, B: Backend>(
+        &self,
+        wait_state: u32,
+        guard: &mut Guard<'_, T, B>,
+        timeout: c_long,
+    ) -> c_long {
         let wait = Opaque::<bindings::wait_queue_entry>::uninit();
 
         // SAFETY: `wait` points to valid memory.
@@ -113,11 +121,13 @@ fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, guard: &mut Guar
             bindings::prepare_to_wait_exclusive(self.wait_list.get(), wait.get(), wait_state as _)
         };
 
-        // SAFETY: No arguments, switches to another thread.
-        guard.do_unlocked(|| unsafe { bindings::schedule() });
+        // SAFETY: Switches to another thread. The timeout can be any number.
+        let ret = guard.do_unlocked(|| unsafe { bindings::schedule_timeout(timeout) });
 
         // SAFETY: Both `wait` and `wait_list` point to valid memory.
         unsafe { bindings::finish_wait(self.wait_list.get(), wait.get()) };
+
+        ret
     }
 
     /// Releases the lock and waits for a notification in uninterruptible mode.
@@ -127,7 +137,7 @@ fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, guard: &mut Guar
     /// [`CondVar::notify_one`] or [`CondVar::notify_all`]. Note that it may also wake up
     /// spuriously.
     pub fn wait<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) {
-        self.wait_internal(bindings::TASK_UNINTERRUPTIBLE, guard);
+        self.wait_internal(bindings::TASK_UNINTERRUPTIBLE, guard, MAX_SCHEDULE_TIMEOUT);
     }
 
     /// Releases the lock and waits for a notification in interruptible mode.
@@ -138,10 +148,31 @@ pub fn wait<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) {
     /// Returns whether there is a signal pending.
     #[must_use = "wait_interruptible returns if a signal is pending, so the caller must check the return value"]
     pub fn wait_interruptible<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) -> bool {
-        self.wait_internal(bindings::TASK_INTERRUPTIBLE, guard);
+        self.wait_internal(bindings::TASK_INTERRUPTIBLE, guard, MAX_SCHEDULE_TIMEOUT);
         crate::current!().signal_pending()
     }
 
+    /// Releases the lock and waits for a notification in interruptible mode.
+    ///
+    /// Atomically releases the given lock (whose ownership is proven by the guard) and puts the
+    /// thread to sleep. It wakes up when notified by [`CondVar::notify_one`] or
+    /// [`CondVar::notify_all`], or when a timeout occurs, or when the thread receives a signal.
+    #[must_use = "wait_interruptible_timeout returns if a signal is pending, so the caller must check the return value"]
+    pub fn wait_interruptible_timeout<T: ?Sized, B: Backend>(
+        &self,
+        guard: &mut Guard<'_, T, B>,
+        jiffies: Jiffies,
+    ) -> CondVarTimeoutResult {
+        let jiffies = jiffies.try_into().unwrap_or(MAX_SCHEDULE_TIMEOUT);
+        let res = self.wait_internal(bindings::TASK_INTERRUPTIBLE, guard, jiffies);
+
+        match (res as Jiffies, crate::current!().signal_pending()) {
+            (jiffies, true) => CondVarTimeoutResult::Signal { jiffies },
+            (0, false) => CondVarTimeoutResult::Timeout,
+            (jiffies, false) => CondVarTimeoutResult::Woken { jiffies },
+        }
+    }
+
     /// Calls the kernel function to notify the appropriate number of threads with the given flags.
     fn notify(&self, count: i32, flags: u32) {
         // SAFETY: `wait_list` points to valid memory.
@@ -177,3 +208,19 @@ pub fn notify_all(&self) {
         self.notify(0, 0);
     }
 }
+
+/// The return type of `wait_timeout`.
+pub enum CondVarTimeoutResult {
+    /// The timeout was reached.
+    Timeout,
+    /// Somebody woke us up.
+    Woken {
+        /// Remaining sleep duration.
+        jiffies: Jiffies,
+    },
+    /// A signal occurred.
+    Signal {
+        /// Remaining sleep duration.
+        jiffies: Jiffies,
+    },
+}
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f12a684bc957..149a5259d431 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -139,7 +139,7 @@ pub struct Guard<'a, T: ?Sized, B: Backend> {
 unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
 
 impl<T: ?Sized, B: Backend> Guard<'_, T, B> {
-    pub(crate) fn do_unlocked(&mut self, cb: impl FnOnce()) {
+    pub(crate) fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
         // SAFETY: The caller owns the lock, so it is safe to unlock it.
         unsafe { B::unlock(self.lock.state.get(), &self.state) };
 
@@ -147,7 +147,7 @@ pub(crate) fn do_unlocked(&mut self, cb: impl FnOnce()) {
         let _relock =
             ScopeGuard::new(|| unsafe { B::relock(self.lock.state.get(), &mut self.state) });
 
-        cb();
+        cb()
     }
 }
 

-- 
2.43.0.472.g3155946c3a-goog


