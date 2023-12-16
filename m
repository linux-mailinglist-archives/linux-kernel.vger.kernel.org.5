Return-Path: <linux-kernel+bounces-2233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E95F8159FC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05DD6B24299
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 15:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ADE31A90;
	Sat, 16 Dec 2023 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H1Z3UEkM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f74.google.com (mail-lf1-f74.google.com [209.85.167.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CD731A62
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f74.google.com with SMTP id 2adb3069b0e04-50e186d2e54so855161e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 07:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702740721; x=1703345521; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LT/VzEMQfjBunMwUHNaq3eIbr3dP2qdLLUarTDZYcms=;
        b=H1Z3UEkMZFREGggHV7ZQ0QIaHzNazUnLuhx1EwBokOoSEKK/SjxLiRxWY7wrYd9ij0
         yfLbWBml/KhASTzvK1RjwhwW2Z0QG+uZE+WjcXgbl2vaACOP24f6v5Foolp90Bpjz6yO
         wScuYmPwbnr9rAzschBJZuLx5NGWffScyJGRK6PH50LTQ6WcY+FV02OQa139S8JbXCX0
         Y/7be6hkO16OX1tkfngfxta1gcMvxJRRziHDGtgzBBZ/MvGqnqZ03gIfnbQTFFbIFipl
         C4HiTWWukjZoqdvG76+ofzQCTiChbsJl0dxiG/bCKEklHeCgXvIDftJxadmWskCCsxjx
         e1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702740721; x=1703345521;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LT/VzEMQfjBunMwUHNaq3eIbr3dP2qdLLUarTDZYcms=;
        b=qAN0LwQ6g7dsuWLKXbk2eVcZQHpNc9UI+VgrS9NXoyY5kOtS+1fRHw+2yMmeLFej/a
         lIoili/4UWOethKU+Ezsxa3XoipR/vSNxrx2FIOezonAf0AQUudMgFbQGv4dZeSZmEd6
         t92Srez2IZhozDwaL/YG242Uzo5G/bL6yU9VlIJnEFK1w/S1Q//4fDd4pAbMq1y40TlO
         0WLwSlf/HOPhV0iZKCKVqkyKEC4SQInhskq1sMtyNEuEiAUpNMAgnDCA4BNBIkToaPMF
         6XdAuqi/pl2Xjt3rufRjUISCpAGr1p+WDdgHWpjqDR/NQRnF8uM7golgFm943bVI34s1
         chXw==
X-Gm-Message-State: AOJu0YwtfV7vv4ByiarZR82qnvyKi4vhwWICne6uynyEsSJhzhYsm5X4
	bcEjxaKTvGWW2Y+/PD79h4VJOe1D31Y2R+U=
X-Google-Smtp-Source: AGHT+IEeQkujUyn7byhfH//rFftMEYy8PmIQJoAfSRVwDhH+9P8dJYHuhDG6N2lAzW2iKGo8kQoZ2mdSjHFCJ8c=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:3d26:b0:50e:d49:156b with SMTP
 id d38-20020a0565123d2600b0050e0d49156bmr157415lfv.4.1702740720972; Sat, 16
 Dec 2023 07:32:00 -0800 (PST)
Date: Sat, 16 Dec 2023 15:31:42 +0000
In-Reply-To: <20231216-rb-new-condvar-methods-v2-0-b05ab61e6d5b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231216-rb-new-condvar-methods-v2-0-b05ab61e6d5b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6401; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=KG/slwqGOF9oUMO0B4L9hVCJ3TxK7vKmJVhXl8LrvtA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlfcLhMVsGyqik/ZrsWXlhk/NLtw/iwmomeJiSF
 M9Y9/WNHquJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZX3C4QAKCRAEWL7uWMY5
 RtqyD/4lcnppEcnJRpQ1qOnneQhj2yuOzr8/sqfKCZHmi9EULNaKY8oViaX769lgBQw3xoFs0rA
 qkmUcCCExApGShw3/uhfkrDxmnmph14066YT95tCVqgF9nRu+Y7ZtLQcUM2rDqh8LVnIHwTkff9
 iQDMIV03bTXVeE5WSJ+Ccpvu2hM0EHWFFwETNtwGYEzXObSyL3Wi+nPxrj1ZYn6+/smCeF1iGTn
 CqV5NVg4pNjaKRtJU+taWKyZ8Nd9zgAeu4HX8MVDeqT4oklz1aMqmyg0vNwbYMYM5bmKWHEB0KM
 qEg9PEMZaKVd10f+g3Uf6LMlipdZcDxuAnoIrAAz0veeA228JLqm+SZS/kOFwymH9dNq5uqi50j
 5osHDO1X7ONdB4+B/YhJAqRVvTSV9t25NXlwOxY9fqwk26hT2YDkLLRsyXhM314P0a6pADYPgvj
 ZRMRJ85+b2NL4CMo0l9XzYs7j5nFs5avS2VILaaBUflkYfItkMLEuvjbhfBuGTQ+auF+Ac8HFPs
 VMyAjRP8csGxJXL/2q29Rem472/mYn23SKlcvBmqwTNUiLV2G/qcTaxvPZ6SOZhgixarjUz9ZMb
 lEoPCvfNVnpcRTyEHlwFHcwXQOwvjbUzTGGqLWYIROztiXE4VbyC4q/eDSJiHiolB2eejS3U2Gv s2KVDfd4Qpn6ZaA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231216-rb-new-condvar-methods-v2-4-b05ab61e6d5b@google.com>
Subject: [PATCH v2 4/4] rust: sync: update integer types in CondVar
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
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/condvar.rs | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 0176cdfced6c..a0d45dc97661 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -7,7 +7,7 @@
 
 use super::{lock::Backend, lock::Guard, LockClassKey};
 use crate::{bindings, init::PinInit, pin_init, str::CStr, time::Jiffies, types::Opaque};
-use core::ffi::c_long;
+use core::ffi::{c_int, c_long, c_uint};
 use core::marker::PhantomPinned;
 use macros::pin_data;
 
@@ -21,6 +21,10 @@ macro_rules! new_condvar {
 
 const MAX_SCHEDULE_TIMEOUT: c_long = c_long::MAX;
 
+const TASK_NORMAL: c_uint = bindings::TASK_NORMAL as c_uint;
+const TASK_INTERRUPTIBLE: c_int = bindings::TASK_INTERRUPTIBLE as c_int;
+const TASK_UNINTERRUPTIBLE: c_int = bindings::TASK_UNINTERRUPTIBLE as c_int;
+
 /// A conditional variable.
 ///
 /// Exposes the kernel's [`struct wait_queue_head`] as a condition variable. It allows the caller to
@@ -107,7 +111,7 @@ pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self
 
     fn wait_internal<T: ?Sized, B: Backend>(
         &self,
-        wait_state: u32,
+        wait_state: c_int,
         guard: &mut Guard<'_, T, B>,
         timeout: c_long,
     ) -> c_long {
@@ -118,7 +122,7 @@ fn wait_internal<T: ?Sized, B: Backend>(
 
         // SAFETY: Both `wait` and `wait_list` point to valid memory.
         unsafe {
-            bindings::prepare_to_wait_exclusive(self.wait_list.get(), wait.get(), wait_state as _)
+            bindings::prepare_to_wait_exclusive(self.wait_list.get(), wait.get(), wait_state)
         };
 
         // SAFETY: Switches to another thread. The timeout can be any number.
@@ -137,7 +141,7 @@ fn wait_internal<T: ?Sized, B: Backend>(
     /// [`CondVar::notify_one`] or [`CondVar::notify_all`]. Note that it may also wake up
     /// spuriously.
     pub fn wait<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) {
-        self.wait_internal(bindings::TASK_UNINTERRUPTIBLE, guard, MAX_SCHEDULE_TIMEOUT);
+        self.wait_internal(TASK_UNINTERRUPTIBLE, guard, MAX_SCHEDULE_TIMEOUT);
     }
 
     /// Releases the lock and waits for a notification in interruptible mode.
@@ -148,7 +152,7 @@ pub fn wait<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) {
     /// Returns whether there is a signal pending.
     #[must_use = "wait_interruptible returns if a signal is pending, so the caller must check the return value"]
     pub fn wait_interruptible<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) -> bool {
-        self.wait_internal(bindings::TASK_INTERRUPTIBLE, guard, MAX_SCHEDULE_TIMEOUT);
+        self.wait_internal(TASK_INTERRUPTIBLE, guard, MAX_SCHEDULE_TIMEOUT);
         crate::current!().signal_pending()
     }
 
@@ -164,7 +168,7 @@ pub fn wait_interruptible_timeout<T: ?Sized, B: Backend>(
         jiffies: Jiffies,
     ) -> CondVarTimeoutResult {
         let jiffies = jiffies.try_into().unwrap_or(MAX_SCHEDULE_TIMEOUT);
-        let res = self.wait_internal(bindings::TASK_INTERRUPTIBLE, guard, jiffies);
+        let res = self.wait_internal(TASK_INTERRUPTIBLE, guard, jiffies);
 
         match (res as Jiffies, crate::current!().signal_pending()) {
             (jiffies, true) => CondVarTimeoutResult::Signal { jiffies },
@@ -174,22 +178,15 @@ pub fn wait_interruptible_timeout<T: ?Sized, B: Backend>(
     }
 
     /// Calls the kernel function to notify the appropriate number of threads with the given flags.
-    fn notify(&self, count: i32, flags: u32) {
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
@@ -197,7 +194,7 @@ pub fn notify_sync(&self) {
     /// This is not 'sticky' in the sense that if no thread is waiting, the notification is lost
     /// completely (as opposed to automatically waking up the next waiter).
     pub fn notify_one(&self) {
-        self.notify(1, 0);
+        self.notify(1);
     }
 
     /// Wakes all waiters up, if any.
@@ -205,7 +202,7 @@ pub fn notify_one(&self) {
     /// This is not 'sticky' in the sense that if no thread is waiting, the notification is lost
     /// completely (as opposed to automatically waking up the next waiter).
     pub fn notify_all(&self) {
-        self.notify(0, 0);
+        self.notify(0);
     }
 }
 

-- 
2.43.0.472.g3155946c3a-goog


