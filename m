Return-Path: <linux-kernel+bounces-16748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E527824342
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768281C21FA6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCD7224EB;
	Thu,  4 Jan 2024 14:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MpP3uNpy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B67F22EF6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 14:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbdb69bc114so809165276.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 06:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704377010; x=1704981810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t6X31kCDRUI3uFJo9bDSt6/FKb89NCMlltC27QfJIK4=;
        b=MpP3uNpySokGBerNjKuVTNbgmzid66IjEIqAmgXYitR3URei8WyDPFdekGf/h6zGP3
         2Og6+gtrZXot5nv5f6tOKHg2QgVQygLNxpiAW76LlHtNxIb0tIsVONPwrctTRrEj+pBG
         gd88G8jcKhf+6AtMBNT1KLGn9pbaW5gDH1CGP7zisJAkyvv2XNwqCSG57uAfQh0Ye4VA
         zhMjLWcNgF/+QpnB2Li37xpyuXFbCUA2jkNB7+MJFbRmkuWwJbYcS/T6CN4J7vXPltnq
         bv04UxivIRhppOlivykUP2fKTMImULOkp9bf87p55riqDQqB5TYJXUS21rbazv+VMfLI
         V0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704377010; x=1704981810;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6X31kCDRUI3uFJo9bDSt6/FKb89NCMlltC27QfJIK4=;
        b=ooZeX58AHF4+lFGYljIyRXI2qoCykHWezvoOnUHvkGGWHEFaig3m3ytDgcnC+TDZ07
         ym/I7UmbhbbkV2C21EdfIP7hluFMvkJqeK2XwKXBV9lMRrbXaImo15ktfZmaGNj1UDZR
         qRVCatueaCt6CDYjDIBzHyXU98WaxwjZx8yCNZ46cz4neDyCQiYWyr+pzihem+NfNPUb
         qslQyuiDbO+ebITrWFDUHtIDzFiN347zgvIwF8d66ty75wmYpvX64NsfgoB8JlEjX0aH
         rBRsZ4C/zxLEo/3pOL0kmiuWT8aZiv7lDCQvgypqvG3ZDiB0SHnbQrWMQGa7BA1OjN0X
         Bgug==
X-Gm-Message-State: AOJu0Yxsfx/0Io6BJK+m4NXoAFHDK5M9Z5LLU9Y9BButcNHmIK32EZPy
	B+8SbMuvPivdHlbYhdH5UAgdV3EawZTmQec0NuZcmw==
X-Google-Smtp-Source: AGHT+IFyREhyOLKDNIEFYR9igaI9vjoUzPvyJ2L6d+OthJuiM7QhSGYrkrRzSIJEAA6v0viMhrEctUiX3M8cfvw=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1364:b0:dbe:4fc2:d6ef with SMTP
 id bt4-20020a056902136400b00dbe4fc2d6efmr205897ybb.12.1704377010105; Thu, 04
 Jan 2024 06:03:30 -0800 (PST)
Date: Thu, 04 Jan 2024 14:02:44 +0000
In-Reply-To: <20240104-rb-new-condvar-methods-v3-0-70b514fcbe52@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240104-rb-new-condvar-methods-v3-0-70b514fcbe52@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7330; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=/7G4uhSpkApL3X8eWwX+diaXLDCkphXHPBdKHlkE0d8=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBllrqi/dK4HMDso4VA0cdG9aelE29vaXIPUyDtV
 j+q/4tnKcKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZZa6ogAKCRAEWL7uWMY5
 RgmtEACEy93s/x8XRXsLSAzoAyPzaFsQetb6R3p71mQveVzGmcM7fJxTfWxdwWvkuxZGCTq8biG
 Cfqv+9Rtdz9rwZ7CzoDRjFIkmjHEQTAXuovqmlkIOdB7+hoE+P+ZD49Ti5YWDJ973hchfmWwLHr
 oZw6UhdDVsNwtkn8rRc2jo/cqEcFXYyJSnno3EoUgFJ+kTcIsdJrsXBYaX0ef8hkVWzgrhQkliO
 ue409rw08E+4VjXSFP28IEF7+9ZsW9fgZAzugMRgk2bnWEDOwOIW3VJ7WYzhbfxD0xaTeqdgc8V
 NfOylH+Nue68iujCWh8naySF6ghRCWh5O2ImZOKb6eybgzuehis5fDfjkMg25WHxqtA4kg09SUY
 bty05vkJUFN7RxE3r9qdxS/Rijzcn9O97tJkqwV8o0ojwOrh75yZbTqXT/g737xnlcAfEoLVjA5
 nVTPavvDpQOkOwYAgxeYw79ugElPjmMU/6qr2xxOti8Qqe+JXmJZIouzmWm86Ba9/RGO1/ir7rI
 g5UHkD3hUIpTBQ5YtJgSmsXbbWNUcynADUfU+lzDtAlfk9bHCB682Bp3xId8wzdpmmTsgeGtpe6
 m64o8gvhvOT9g3x9sSjo3jehsfyRO9GoA65HoIJ6oDkiXVX1xtn2eCcDSrHIgrHjxni3smO4Ssr SxHJ5yP11+BkMaQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240104-rb-new-condvar-methods-v3-4-70b514fcbe52@google.com>
Subject: [PATCH v3 4/4] rust: sync: update integer types in CondVar
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

Reduce the chances of compilation failures due to integer type
mismatches in `CondVar`.

When an integer is defined using a #define in C, bindgen doesn't know
which integer type it is supposed to be, so it will just use `u32` by
default (if it fits in an u32). Whenever the right type is something
else, we insert a cast in Rust. However, this means that the code has a
lot of extra casts, and sometimes the code will be missing casts if u32
happens to be correct on the developer's machine, even though the type
might be something else on a different platform.

This patch updates all uses of such constants in
`rust/kernel/sync/condvar.rs` to use constants defined with the right
type. This allows us to remove various unnecessary casts, while also
future-proofing for the case where `unsigned int != u32`.

I wrote this patch at the suggestion of Benno in [1].

Link: https://lore.kernel.org/all/nAEg-6vbtX72ZY3oirDhrSEf06TBWmMiTt73EklMzEAzN4FD4mF3TPEyAOxBZgZtjzoiaBYtYr3s8sa9wp1uYH9vEWRf2M-Lf4I0BY9rAgk=@proton.me/ [1]
Suggested-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Tiago Lam <tiagolam@gmail.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/condvar.rs | 38 ++++++++++++++++++--------------------
 rust/kernel/task.rs         |  8 ++++++++
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 45ba57468717..d907b8cb29eb 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -7,10 +7,15 @@
 
 use super::{lock::Backend, lock::Guard, LockClassKey};
 use crate::{
-    bindings, init::PinInit, pin_init, str::CStr, task::MAX_SCHEDULE_TIMEOUT, time::Jiffies,
+    bindings,
+    init::PinInit,
+    pin_init,
+    str::CStr,
+    task::{MAX_SCHEDULE_TIMEOUT, TASK_INTERRUPTIBLE, TASK_NORMAL, TASK_UNINTERRUPTIBLE},
+    time::Jiffies,
     types::Opaque,
 };
-use core::ffi::c_long;
+use core::ffi::{c_int, c_long, c_uint};
 use core::marker::PhantomPinned;
 use macros::pin_data;
 
@@ -108,7 +113,7 @@ pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self
 
     fn wait_internal<T: ?Sized, B: Backend>(
         &self,
-        wait_state: u32,
+        wait_state: c_int,
         guard: &mut Guard<'_, T, B>,
         timeout_in_jiffies: c_long,
     ) -> c_long {
@@ -119,7 +124,7 @@ fn wait_internal<T: ?Sized, B: Backend>(
 
         // SAFETY: Both `wait` and `wait_list` point to valid memory.
         unsafe {
-            bindings::prepare_to_wait_exclusive(self.wait_list.get(), wait.get(), wait_state as _)
+            bindings::prepare_to_wait_exclusive(self.wait_list.get(), wait.get(), wait_state)
         };
 
         // SAFETY: Switches to another thread. The timeout can be any number.
@@ -138,7 +143,7 @@ fn wait_internal<T: ?Sized, B: Backend>(
     /// [`CondVar::notify_one`] or [`CondVar::notify_all`]. Note that it may also wake up
     /// spuriously.
     pub fn wait<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) {
-        self.wait_internal(bindings::TASK_UNINTERRUPTIBLE, guard, MAX_SCHEDULE_TIMEOUT);
+        self.wait_internal(TASK_UNINTERRUPTIBLE, guard, MAX_SCHEDULE_TIMEOUT);
     }
 
     /// Releases the lock and waits for a notification in interruptible mode.
@@ -149,7 +154,7 @@ pub fn wait<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) {
     /// Returns whether there is a signal pending.
     #[must_use = "wait_interruptible returns if a signal is pending, so the caller must check the return value"]
     pub fn wait_interruptible<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) -> bool {
-        self.wait_internal(bindings::TASK_INTERRUPTIBLE, guard, MAX_SCHEDULE_TIMEOUT);
+        self.wait_internal(TASK_INTERRUPTIBLE, guard, MAX_SCHEDULE_TIMEOUT);
         crate::current!().signal_pending()
     }
 
@@ -165,7 +170,7 @@ pub fn wait_interruptible_timeout<T: ?Sized, B: Backend>(
         jiffies: Jiffies,
     ) -> CondVarTimeoutResult {
         let jiffies = jiffies.try_into().unwrap_or(MAX_SCHEDULE_TIMEOUT);
-        let res = self.wait_internal(bindings::TASK_INTERRUPTIBLE, guard, jiffies);
+        let res = self.wait_internal(TASK_INTERRUPTIBLE, guard, jiffies);
 
         match (res as Jiffies, crate::current!().signal_pending()) {
             (jiffies, true) => CondVarTimeoutResult::Signal { jiffies },
@@ -174,23 +179,16 @@ pub fn wait_interruptible_timeout<T: ?Sized, B: Backend>(
         }
     }
 
-    /// Calls the kernel function to notify the appropriate number of threads with the given flags.
-    fn notify(&self, count: i32, flags: u32) {
+    /// Calls the kernel function to notify the appropriate number of threads.
+    fn notify(&self, count: c_int) {
         // SAFETY: `wait_list` points to valid memory.
-        unsafe {
-            bindings::__wake_up(
-                self.wait_list.get(),
-                bindings::TASK_NORMAL,
-                count,
-                flags as _,
-            )
-        };
+        unsafe { bindings::__wake_up(self.wait_list.get(), TASK_NORMAL, count, ptr::null_mut()) };
     }
 
     /// Calls the kernel function to notify one thread synchronously.
     pub fn notify_sync(&self) {
         // SAFETY: `wait_list` points to valid memory.
-        unsafe { bindings::__wake_up_sync(self.wait_list.get(), bindings::TASK_NORMAL) };
+        unsafe { bindings::__wake_up_sync(self.wait_list.get(), TASK_NORMAL) };
     }
 
     /// Wakes a single waiter up, if any.
@@ -198,7 +196,7 @@ pub fn notify_sync(&self) {
     /// This is not 'sticky' in the sense that if no thread is waiting, the notification is lost
     /// completely (as opposed to automatically waking up the next waiter).
     pub fn notify_one(&self) {
-        self.notify(1, 0);
+        self.notify(1);
     }
 
     /// Wakes all waiters up, if any.
@@ -206,7 +204,7 @@ pub fn notify_one(&self) {
     /// This is not 'sticky' in the sense that if no thread is waiting, the notification is lost
     /// completely (as opposed to automatically waking up the next waiter).
     pub fn notify_all(&self) {
-        self.notify(0, 0);
+        self.notify(0);
     }
 }
 
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index ffb4a51eb898..37468613ac0d 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -10,6 +10,14 @@
 /// A sentinal value used for infinite timeouts.
 pub const MAX_SCHEDULE_TIMEOUT: c_long = c_long::MAX;
 
+/// Bitmask for tasks that are sleeping in an interruptible state.
+pub const TASK_INTERRUPTIBLE: c_int = bindings::TASK_INTERRUPTIBLE as c_int;
+/// Bitmask for tasks that are sleeping in an uninterruptible state.
+pub const TASK_UNINTERRUPTIBLE: c_int = bindings::TASK_UNINTERRUPTIBLE as c_int;
+/// Convenience constant for waking up tasks regardless of whether they are in interruptible or
+/// uninterruptible sleep.
+pub const TASK_NORMAL: c_uint = bindings::TASK_NORMAL as c_uint;
+
 /// Returns the currently running task.
 #[macro_export]
 macro_rules! current {

-- 
2.43.0.472.g3155946c3a-goog


