Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A52D806B58
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377435AbjLFKJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377427AbjLFKJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:09:46 -0500
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6469ED4D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:09:51 -0800 (PST)
Received: by mail-lj1-x249.google.com with SMTP id 38308e7fff4ca-2ca005e8de4so30800611fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 02:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701857389; x=1702462189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yyo/AOmj9zcd4Cgit94NCPm2Zi7Z6JIsUXb5F1cqXp4=;
        b=gvXVxW/F6Y3HWq4D3dGFCWtlGUZIcrxiJz8iAPXDOXnzu8ttJTKFPpMvKC3HQXTtcH
         YZ/I8LU14+aMVnMZ/D7VVdj9Uk03JDXhDtL9wiCeWdS9fkAcmBruOBho6vVgKOga7GZh
         GNB8+NJES9nUZGfP0TmPPtbACLCx9LFZCGagGW1d7fuRndoWVNf3dlnDEzlHJKWUS9uI
         NaBIjuRLtDYSQCCzdckOB18146TF20Hh6Sv4GobKr2mSwKSX/fFzmMB1LcxZHx2ecAyx
         9GlCJIRKo5Tiq6M03Bw2nYvEjQexn4MvydA54h5JqC0EEHLZ7ujeauv8sq39s6DYO3/l
         ySGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701857389; x=1702462189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yyo/AOmj9zcd4Cgit94NCPm2Zi7Z6JIsUXb5F1cqXp4=;
        b=Qfv6LjLAvLLpc9j0LkYOuNTE/1jENg6FaszyA4cHtrJDF3orl5nXuuokbh5E8DrcLE
         K46GH8RIRHtwJ6FaS65OVNge7e41kUAU3/TtZWE/vipR3EourUcWtK6ZLk9gKq8VAsMN
         BWO8+gXZA2KAA7fMWBFJtCiMypUGD46xvCyJDAYeVqoZTcEjNy9FWg/+7hKJN+S3qcXr
         KOjjAeiQXyolHaUeP8VAd2XXVQ7MVUMm2DVJZ/MKJqom+//fb2wlCP1RLBEnP9W13LOz
         c2zGdiezitFs95tLkGtL60jLrL5eiRIIOurx3KjngF/1lvRf7GEsM/T/kH/o1HBeMvmP
         OmKw==
X-Gm-Message-State: AOJu0Yzdu2RVYjjvcLF8n1mP0Tadf2/zP+qegj7ckWc42gMLATTXMzvD
        tN5gYzF6b7eBrGM9htDeiQgnGwtsvD38Qi8=
X-Google-Smtp-Source: AGHT+IH1Uagzh2FSTOxOXal+WK9kmP/Ye0opHqSolX3+vfEygg+gvZ9zNt/VWpUz/XQhWAKbn341Pxr4ciXG7Sw=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:39d6:b0:50b:f0f6:259d with SMTP
 id k22-20020a05651239d600b0050bf0f6259dmr6812lfu.11.1701857389217; Wed, 06
 Dec 2023 02:09:49 -0800 (PST)
Date:   Wed, 06 Dec 2023 10:09:24 +0000
In-Reply-To: <20231206-rb-new-condvar-methods-v1-0-33a4cab7fdaa@google.com>
Mime-Version: 1.0
References: <20231206-rb-new-condvar-methods-v1-0-33a4cab7fdaa@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5270; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=/VMhS2n7v+OrDjmNW0iMiPb1VnK9+s+caIt3RRCeoD0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlcEhkME2PSBggPDlUK+JjUepphkl7X+XwFkwnM
 3RoI5m0NtiJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZXBIZAAKCRAEWL7uWMY5
 RspjD/9yieSBoVrrLuRCIT7d3bnc3302+K9bE/cgtJckVgMlEnSX4oOE229OHdMZ0gsCXRVXeHg
 GqNZ8htlUk7d8wgt/7dNx2SH4TWYHEznDsS26uePexTkNOYVJX+ce+uREA9pc/J/Rwqx6um8UqR
 j4hv/M81LKuyptxs6WR0EyBY7fATbrgTIzgP6ajdRJ9FSjQVEfxKy06utISRfa2MwroT0TCx78X
 oaPaz943kPiB72dUCqAo5hGkYHQtHB8dGdbR5qapdEyN/XQ0GbWV5lp44/oje3wpi87jA/CASGS
 YcL2qnLJmz+M5WfVwNNWA4IECjePWyJajCFKzUWgMn8HDNjEx/vmLN70AajfhXxrwlK6indrGMT
 Ly1HSzCqZ9v/Kwg8qvHm54CqkWGv56yz7NDMlQNzByCrUQZ3R/mDyksBwZo6tDOMixnTakzyyTF
 ZXgqZNfaK+zHEKtoTiXd/xkrPyIVNv4+144VmtGG+8sbVBst9B+HprWXJV4J83J+aYTJIa/Ayyc
 UkfPKorryorYhJ+Rnvj66IDRZZMt40SvkTxVoBANWCdQm//fqdPckCs9V5ZTSo8WRLt2o9gPPWA
 oqwuFFLv4RzbZpb/bAMQKi2O0btVjRG6osyoYXr4VFQuf+Fnpii6u6S2kCHuW4kcLwq+VwmFa6x I3f8/hOBATRSRwQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231206-rb-new-condvar-methods-v1-2-33a4cab7fdaa@google.com>
Subject: [PATCH 2/2] rust: sync: add `CondVar::wait_timeout`
From:   Alice Ryhl <aliceryhl@google.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sleep on a condition variable with a timeout.

This is used by Rust Binder for process freezing. There, we want to
sleep until the freeze operation completes, but we want to be able to
abort the process freezing if it doesn't complete within some timeout.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync.rs         |  2 +-
 rust/kernel/sync/condvar.rs | 73 +++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/sync/lock.rs    |  4 +--
 3 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index d219ee518eff..c1fb10fc64f4 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -13,7 +13,7 @@
 mod locked_by;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
-pub use condvar::CondVar;
+pub use condvar::{CondVar, CondVarTimeoutResult};
 pub use lock::{mutex::Mutex, spinlock::SpinLock};
 pub use locked_by::LockedBy;
 
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 9861c6749ad0..a6a6b6ab0c39 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -120,6 +120,63 @@ fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, guard: &mut Guar
         unsafe { bindings::finish_wait(self.wait_list.get(), wait.get()) };
     }
 
+    /// Atomically releases the given lock (whose ownership is proven by the guard) and puts the
+    /// thread to sleep. It wakes up when notified by [`CondVar::notify_one`] or
+    /// [`CondVar::notify_all`], or when the thread receives a signal.
+    ///
+    /// Returns whether there is a signal pending.
+    fn wait_internal_timeout<T, B>(
+        &self,
+        wait_state: u32,
+        guard: &mut Guard<'_, T, B>,
+        timeout: u64,
+    ) -> u64
+    where
+        T: ?Sized,
+        B: Backend,
+    {
+        let wait = Opaque::<bindings::wait_queue_entry>::uninit();
+
+        // SAFETY: `wait` points to valid memory.
+        unsafe { bindings::init_wait(wait.get()) };
+
+        // SAFETY: Both `wait` and `wait_list` point to valid memory.
+        unsafe {
+            bindings::prepare_to_wait_exclusive(self.wait_list.get(), wait.get(), wait_state as _)
+        };
+
+        // SAFETY: Switches to another thread.
+        let timeout =
+            guard.do_unlocked(|| unsafe { bindings::schedule_timeout(timeout as _) as _ });
+
+        // SAFETY: Both `wait` and `wait_list` point to valid memory.
+        unsafe { bindings::finish_wait(self.wait_list.get(), wait.get()) };
+
+        timeout
+    }
+
+    /// Releases the lock and waits for a notification in interruptible mode.
+    ///
+    /// Atomically releases the given lock (whose ownership is proven by the guard) and puts the
+    /// thread to sleep. It wakes up when notified by [`CondVar::notify_one`] or
+    /// [`CondVar::notify_all`], or when a timeout occurs, or when the thread receives a signal.
+    ///
+    /// Returns whether there is a signal pending.
+    #[must_use = "wait_timeout returns if a signal is pending, so the caller must check the return value"]
+    pub fn wait_timeout<T: ?Sized, B: Backend>(
+        &self,
+        guard: &mut Guard<'_, T, B>,
+        jiffies: u64,
+    ) -> CondVarTimeoutResult {
+        let res = self.wait_internal_timeout(bindings::TASK_INTERRUPTIBLE, guard, jiffies);
+
+        match (res as _, crate::current!().signal_pending()) {
+            (jiffies, true) => CondVarTimeoutResult::Signal { jiffies },
+            (0, false) => CondVarTimeoutResult::Timeout,
+            (jiffies, false) => CondVarTimeoutResult::Woken { jiffies },
+        }
+    }
+
     /// Releases the lock and waits for a notification in interruptible mode.
     ///
     /// Atomically releases the given lock (whose ownership is proven by the guard) and puts the
@@ -177,3 +234,19 @@ pub fn notify_all(&self) {
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
+        jiffies: u64,
+    },
+    /// A signal occurred.
+    Signal {
+        /// Remaining sleep duration.
+        jiffies: u64,
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
2.43.0.rc2.451.g8631bc7472-goog

