Return-Path: <linux-kernel+bounces-19720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E5E8271D6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146061F20FA2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5881251C3B;
	Mon,  8 Jan 2024 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t7nPoB6s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADEF51029
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbce2a8d700so1451672276.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 06:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704725412; x=1705330212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FC3zSuKOQJ4VOItAZMX3cy9K0P5EzH8kuQgbB61S/9A=;
        b=t7nPoB6svrrWC3fQ2I1b7eZJArLL61PnOiMz4LslVaUgo51ISuXU3Jbdaa7HwVkqIu
         naU3tT/vkeJnpBcVbHgpMGAr3LoxR4AQ/FIuS5cotZFO1UxO1LXelcA6ZGyPJlgyTasX
         D6g6AsllBmZYXXI5Wk5gb1GnTthO1unS7xNxgY2ELwVNKwm6pnLyTwEpg4yw5PAkaGiH
         SUyq/ClKcIVIhBji8l7PTJSpuhvA5/lUxQPw6jiSZKeC7KE01SIStGxVdyCJp6ys5EzO
         sGPm1MPv8janwu8tWfB9C1WTFoGV1CcbD5QGdKqqZsvMJA2WJthO7Ih0Lu59hY9tlhCA
         e/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704725412; x=1705330212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FC3zSuKOQJ4VOItAZMX3cy9K0P5EzH8kuQgbB61S/9A=;
        b=b3uGsyIoud9WjxJJAVAi7PoWl8ZMu5ihLrfI62UkwNswuif8+OqrFQ2GKaIaO0rzvH
         RcY1+08XUdgFNkx0sp3/f3cJN8SmcHlfRQoclsdW71i7rnrcK5Ej/n23kdH/CKXeJA8N
         hOrVi76F3v7Z16rjlGXL0+UZPrVfgpg8S05iOW5KjbjYchbHdgzv6pctyXvm408ntEKr
         alyQ24Jn4RfoiTPiD61/hdpyDPng38epd7jaKVcFtPAKH7leKMWirFPlIjSFywbVw4Dc
         fm6jySorGPdK1XiP7H007QHW/BKrHP8EhMAKWrW2sxa57lPF6QMiqb157luW+v2wYDcN
         dF0w==
X-Gm-Message-State: AOJu0Yy3NeUsOATU2jzQSsg/wTfodlISh5315MuzSb/+JN4cqSwokdT8
	W5cwdsHlqE6HEg9C2FpT/OlSpqwcV1d7onE7gQlC6Q==
X-Google-Smtp-Source: AGHT+IEPNTj5SK4xnk+K+oSPjZ+cukAEB9mSC2NTVZHULzc5WjngM80a5n1vbGdmDADDneDvpzWjcPGVUHwF17w=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:824d:0:b0:dbe:3087:1d22 with SMTP id
 d13-20020a25824d000000b00dbe30871d22mr116090ybn.13.1704725412185; Mon, 08 Jan
 2024 06:50:12 -0800 (PST)
Date: Mon, 08 Jan 2024 14:49:59 +0000
In-Reply-To: <20240108-rb-new-condvar-methods-v4-0-88e0c871cc05@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240108-rb-new-condvar-methods-v4-0-88e0c871cc05@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7424; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=7DhaZf4SIHmOZSumn+foJHl61MmWwbMVF8kY96krCxU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlnAuX2Bw76dgmwZsRUQv2BSOUeYFtlj/bnw3Mt
 qnMUZmjXuyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZZwLlwAKCRAEWL7uWMY5
 RrR7EACwCNPW0WeatnTjrXtcg5qPPDvC1cN6wsnV9Zpn5s5UGCcXQuXHILMAL2HtrV69KBbjvcF
 +RxYCnNShxHWfDYR0U0BYTWKcGIwMTEkbD1Kak/ardDFEf33OUb89Mu29tUw7TUyhKAJi3fi/P7
 nMzieT8KQAq8HC/LJpAS53ZkfH7pD6GLuVF8u9d+4zpwnL6DgclZ1pmRMkszsYzINjp8gKElO8C
 JDmnxmDQhw0fWXOS8ZYeuPq8RWGvqZPHD/xZEHyVVWnV6rcZQ1D9V6P31kKCV+han0X8Jrfxhk9
 MIOuw8sQXIvV3M8ekAVcX3hJ61wTdh+G5RdfOjIL04eCln+j7EYmNYOVMp2/HJBTNHIv89i4ZCb
 sbK9rGA5+SIEEVo5hlxOw3fXD1Uy/V0TptWIB8P3kpGlnsirteOKgf5axWCyv/aiJ+ZjEmClEUI
 HwXkFE5jWc8BptxfEgTU/g0506pgjXmlYZwAOA/yeXrqjQtvOJbNiJ3B9sc5+9LARJGihVMZeTS
 Jzr+ropsW+bs76K5Ahfr4xs0QdBpv5BdkytzlaBW+bL61Q4zoMNaG+y3JJ6jnlOwZC3x0ncjqFR
 DMzCokS4+yurF0+MFG+YKkAAOQ9JceBC1UwfbxQfzdLrpR4XpQoXLB0NPvNGbPdVmF2jcTdhWrX OXHRmN3fP+7m28Q==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240108-rb-new-condvar-methods-v4-3-88e0c871cc05@google.com>
Subject: [PATCH v4 3/4] rust: sync: add `CondVar::wait_timeout`
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Tiago Lam <tiagolam@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Martin Rodriguez Reboredo <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Sleep on a condition variable with a timeout.

This is used by Rust Binder for process freezing. There, we want to
sleep until the freeze operation completes, but we want to be able to
abort the process freezing if it doesn't complete within some timeout.

Note that it is not enough to avoid jiffies by introducing a variant of
`CondVar::wait_timeout` that takes the timeout in msecs because we need
to be able to restart the sleep with the remaining sleep duration if it
is interrupted, and if the API takes msecs rather than jiffies, then
that would require a conversion roundtrip jiffies->msecs->jiffies that
is best avoided.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Tiago Lam <tiagolam@gmail.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/condvar.rs | 60 ++++++++++++++++++++++++++++++++++++++++-----
 rust/kernel/sync/lock.rs    |  4 +--
 rust/kernel/task.rs         |  5 +++-
 3 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index b323a0c26513..fa38c095cbe0 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -6,7 +6,11 @@
 //! variable.
 
 use super::{lock::Backend, lock::Guard, LockClassKey};
-use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaque};
+use crate::{
+    bindings, init::PinInit, pin_init, str::CStr, task::MAX_SCHEDULE_TIMEOUT, time::Jiffies,
+    types::Opaque,
+};
+use core::ffi::c_long;
 use core::marker::PhantomPinned;
 use macros::pin_data;
 
@@ -102,7 +106,12 @@ pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self
         })
     }
 
-    fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, guard: &mut Guard<'_, T, B>) {
+    fn wait_internal<T: ?Sized, B: Backend>(
+        &self,
+        wait_state: u32,
+        guard: &mut Guard<'_, T, B>,
+        timeout_in_jiffies: c_long,
+    ) -> c_long {
         let wait = Opaque::<bindings::wait_queue_entry>::uninit();
 
         // SAFETY: `wait` points to valid memory.
@@ -113,11 +122,13 @@ fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, guard: &mut Guar
             bindings::prepare_to_wait_exclusive(self.wait_list.get(), wait.get(), wait_state as _)
         };
 
-        // SAFETY: No arguments, switches to another thread.
-        guard.do_unlocked(|| unsafe { bindings::schedule() });
+        // SAFETY: Switches to another thread. The timeout can be any number.
+        let ret = guard.do_unlocked(|| unsafe { bindings::schedule_timeout(timeout_in_jiffies) });
 
         // SAFETY: Both `wait` and `wait_list` point to valid memory.
         unsafe { bindings::finish_wait(self.wait_list.get(), wait.get()) };
+
+        ret
     }
 
     /// Releases the lock and waits for a notification in uninterruptible mode.
@@ -127,7 +138,7 @@ fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, guard: &mut Guar
     /// [`CondVar::notify_one`] or [`CondVar::notify_all`]. Note that it may also wake up
     /// spuriously.
     pub fn wait<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) {
-        self.wait_internal(bindings::TASK_UNINTERRUPTIBLE, guard);
+        self.wait_internal(bindings::TASK_UNINTERRUPTIBLE, guard, MAX_SCHEDULE_TIMEOUT);
     }
 
     /// Releases the lock and waits for a notification in interruptible mode.
@@ -138,10 +149,31 @@ pub fn wait<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) {
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
@@ -181,3 +213,19 @@ pub fn notify_all(&self) {
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
 
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 9451932d5d86..17f14ebb8f48 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -5,7 +5,10 @@
 //! C header: [`include/linux/sched.h`](srctree/include/linux/sched.h).
 
 use crate::{bindings, types::Opaque};
-use core::{marker::PhantomData, ops::Deref, ptr};
+use core::{ffi::c_long, marker::PhantomData, ops::Deref, ptr};
+
+/// A sentinal value used for infinite timeouts.
+pub const MAX_SCHEDULE_TIMEOUT: c_long = c_long::MAX;
 
 /// Returns the currently running task.
 #[macro_export]

-- 
2.43.0.472.g3155946c3a-goog


