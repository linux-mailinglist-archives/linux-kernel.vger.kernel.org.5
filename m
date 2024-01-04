Return-Path: <linux-kernel+bounces-16747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B00824341
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E775287C47
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC8522F18;
	Thu,  4 Jan 2024 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="onSKsSN0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C225422EE7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2cd0f4797cdso2722561fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 06:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704377007; x=1704981807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o+8R7E0UuNwfrBBYP/dG/kUfPLmOpivCqqMG1y8N3o0=;
        b=onSKsSN0j/jWCfhTN7+v3yH5U4kReR2psLx5u/qTnMKiJo3n4kFoX7Xe0TeCOA01rh
         xUKVUVfZI+yNOKRm0z2TOSj6ylLYqKSqCTJ57M6cXhpo5VuyzugtMzzaJuUsECvzP2O3
         xPGu78OOoPSShqUv+hsFTgirwdoUiN8LVMU5fmelzjGH0Y0TCXKQDKJB3xjZlP6SQXmm
         dX6fANfX8bICw3f/m7UFj1j6Eb4cZthpL0lq6DWGc/sSVKX1urs/0nQLNQXD5zyBHPmI
         ShRMqUNDuRqjgO6yZzxU0Mb0LmqMi1NZ9RbrBsdhCGSLMJKHT6Os4RUbw3a7nGD0Me3J
         EbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704377007; x=1704981807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o+8R7E0UuNwfrBBYP/dG/kUfPLmOpivCqqMG1y8N3o0=;
        b=m6Xux0MzlB5UNKUhQU2cY3/nZyQYNTeEOsdjEVe0i8RDbYuszgeniVsapER85ioArH
         IoaMmqrGUQyx/PQVx+JepJ7puqXbrw/QqNrRoMGKWCy7IO6EWqqVru/THv4f2NBOBGTU
         KZQGUYh3o1HvMnMxiSNWt/UpqJrSQ2DPp9bHHjtDETaVRn+zWp27Ni1RJcpg5uzZexBd
         DEHlwbGcQTGPz3/hVfmJBYaoiSpfqi7eD/ie0FCATzgFxU0h6Bodc6MFKvveBvLqn0UB
         vbV4y27fi5IjlOJAXQM58wdRHgOgJebeqyExa7qTjefeQblhP4mO1Tr/2vzFFFaz5cGc
         NUQg==
X-Gm-Message-State: AOJu0YzNm9oGzDdbky3mNuMuK2PlwrFyksu3GuggTewadivTwAi5VYET
	xPiLLnwYAQ11K09t3j4CJjJZ401+GlNejmWYeEbpdA==
X-Google-Smtp-Source: AGHT+IGl8A1p6fQqCDJweCOEeVljqninDIWiz53o44skQh4YSsN808QlJ3heLl7DnPzqnm/Yltfo2k2a1PmmlNc=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:651c:b2c:b0:2cc:b7b8:6912 with SMTP
 id b44-20020a05651c0b2c00b002ccb7b86912mr1171ljr.5.1704377006845; Thu, 04 Jan
 2024 06:03:26 -0800 (PST)
Date: Thu, 04 Jan 2024 14:02:43 +0000
In-Reply-To: <20240104-rb-new-condvar-methods-v3-0-70b514fcbe52@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240104-rb-new-condvar-methods-v3-0-70b514fcbe52@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6876; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=+euJGe7tQyr0UpWz9qxwACBNwq68zsUCsYl+apHRTR8=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBllrqhRcxqCWg+sbH2Q+HwYBPYNNu6EQC9UX6Hj
 l27pWaBmlaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZZa6oQAKCRAEWL7uWMY5
 RnfYD/0ZGcdbch+1hwTs+W6fnN2Ly2KlTvkeaLl/vKw8Q0b0iqb5W5CceJ2DyMVQW9KFK3aWRLx
 d81P5BPtHyqHrNO8LPcDp+UIEz+aAcCrBWRNvn0mf2REz5u0+TJgNOOWoTATYes3Q9JuqXcAaS7
 bw+4qGu+YZJUHPnhcWpvZO0lRYwpGQDLF/38/VJAkRaU6AvP6Toal5MWhXlBj22EZW0VwUaBZJy
 fLUa5qRROXHnnc7zIeFlsuggUUaESUeV7Pyf5r7lb3qe0+Mi5t0HQxoPYOAXwUdMEHcI0BlaXmz
 iFYk/MTN5oWAEhurBpiRIOAciBWDHrYFeenEvCj+Oc5H5XB5gdkBO45saC6qI6WVCBpBbrxrX+t
 Xm1PPQZgDcwEUZFd0kI+t/TL0LQzJIQHiKUDJBUaFti0wtZDFNXHynOguAEFHlys6smx2spAYMR
 RI24PHwHyxeRdeCLH+oqI4GXY9Zahdi0B3sUB3im8MQdGHrynCjfV7sh8YXWfiGnxXjL49Fbl4P
 VCQNdAG98tUcKfvQsbFcq8uOEm3ED+8Yp/nwNYAOWq9jP+020p44079RVh4udTgqE4xED6Vt7ne
 Is7xNlup1fGOMMyvlhD3y+MGKMi4Zv7yuqXgNTuoSnjLYK6srSgpuFcC36dZRCqiyfophW/pjVE v9xwlWn6THL2gIw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240104-rb-new-condvar-methods-v3-3-70b514fcbe52@google.com>
Subject: [PATCH v3 3/4] rust: sync: add `CondVar::wait_timeout`
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

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Tiago Lam <tiagolam@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/condvar.rs | 60 ++++++++++++++++++++++++++++++++++++++++-----
 rust/kernel/sync/lock.rs    |  4 +--
 rust/kernel/task.rs         |  3 +++
 3 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 1a3f7b8e03dc..45ba57468717 100644
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
@@ -177,3 +209,19 @@ pub fn notify_all(&self) {
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
index 9451932d5d86..ffb4a51eb898 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -7,6 +7,9 @@
 use crate::{bindings, types::Opaque};
 use core::{marker::PhantomData, ops::Deref, ptr};
 
+/// A sentinal value used for infinite timeouts.
+pub const MAX_SCHEDULE_TIMEOUT: c_long = c_long::MAX;
+
 /// Returns the currently running task.
 #[macro_export]
 macro_rules! current {

-- 
2.43.0.472.g3155946c3a-goog


