Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8698806F57
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378328AbjLFMA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378269AbjLFMAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:00:18 -0500
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4BFD45
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:00:17 -0800 (PST)
Received: by mail-lf1-x149.google.com with SMTP id 2adb3069b0e04-50becd7229aso3655677e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 04:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701864015; x=1702468815; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ex3XFDrwLoR/nkrJxHEDseFTPk4W5eJ7YuU+mGVpLsc=;
        b=No3XEkcta1a6FXzlMWKhKCqGE75LE+SEfRNsTmERIWjCzRa7NuaHpzxJrdR7vbZjtf
         GqyMHe4CmEsqr4z38KG1OMOBqBlneNmRNACrobnjHXxJWm/2+SE67uVDCQrSdbSV5oqp
         +ekkN9btKDV6bax6xMnx0a/Er+9Wfsk+a1U7h5Nje7wumV35TTaRs54FL51N76dGsapz
         2Cq/+COiZHGKyNN940AHyvwqQLI33YrqOu5T0Qe16h5NR9DtfnND3gC6e6INkCf/0vQp
         VK4LIV9vYGl9rS5/SwVo/25dobAq2fry7F4AwBCyGZ0IkJfsNTBWNDhniVRhFLRUOc+o
         BHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701864015; x=1702468815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ex3XFDrwLoR/nkrJxHEDseFTPk4W5eJ7YuU+mGVpLsc=;
        b=aFJKrycCQd4hVjuqXbNbio6dzehT0KnevpnL75K79WDo9qdpxK894NWwB8uBcgJRhX
         kEjOnGIUlwTirb0I3oUaosMEJH1Bk/MDWSaTIxNKm5ULJEHf7MrPrVxEVsmRsdV+PvIz
         yXyjABqMiBiw9+rpEuJXfRFEGWJgTn5LuWe8UH0ybsCX5rkAlV5xcnhTeadP9HneqZ7S
         gSp2bwCRe4b1Y1hAjiEbHz/zff32X+OBHVdt2ue35gx268Suf4tof32Tgrpv7V4yiv7u
         NodV4ysRgVvo7hNpnkKtXl5HOB+gXD3tjROluCB+zJiNXdj2BI+RlCxNyQjdfgWSy5gQ
         rHbg==
X-Gm-Message-State: AOJu0Ywg6as/qPcDb65w2NGtuQnSh9d0Bxjhovzw5giNGdBInoHSK90J
        dbXN3VwA07njU/4BvDsyaBGOFTLP6QB8MGs=
X-Google-Smtp-Source: AGHT+IFV2wNOA6+gAb0Zk05c7RUksRnkiW/1TaPoCAbGzoANtA5hmVSDV1Q71yj0+RCjgkjL6+0iRrX3nAhgc10=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:ac2:519c:0:b0:50c:60:eedf with SMTP id
 u28-20020ac2519c000000b0050c0060eedfmr8111lfi.9.1701864015140; Wed, 06 Dec
 2023 04:00:15 -0800 (PST)
Date:   Wed, 06 Dec 2023 11:59:50 +0000
In-Reply-To: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
Mime-Version: 1.0
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6837; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=nSD1RHFiSgmdte3sXm2CuEd4KKb3h+aVVxb/9ER4D6k=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlcGI7qpjyrfDIi3Px1DbLbn4cXTm32iM/TT6P/
 Aa9cVXYk7WJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZXBiOwAKCRAEWL7uWMY5
 Rt4KD/9zI0mvZ5UC1bcQXnp4cBkKv2N4XTt6BO7BMq1naJpgTEJaDGfTzxV2Uq5619DVuFsz4Sr
 HrLo0Z0UYqnhHmh82PAB5Mc1RnUbdqddzLYfUqyCsMDBqvmYpsXbAVzgdF9aciAp+yKxPTBKYs7
 M635Y+sq6M/6b9v4n1mDfJfqBmGj4ER9HNRZiBohtTTEzQz+JdN/Di9ZfJ4qZOo89TCHtIBIj61
 ntGx31Lp1q+HoiWDkBBFPmtAhlmOm2A66Yoag51GLHyZuDqMMaem6cbo87Yzi+GIOFD0UbeW+Ka
 pGcPxh/4oDKqET+P0BfLbPLPQ+39M5uVpvaYFJSbEJzgnCyf4OlXlVzeH2vJhepZWZr1XHeeL4b
 c3saxXMSctJbBcwc6VMW7Hyzb3ysaVkJJeKw06UPfOtbmgDzYbBTHJHkizhEAR0GjaKDhMhqpT3
 aJlQmEvcxFMgkFzkb1J9YFRD+rrbg7v0cysTGlWfXLUFAL6W99Sj28iIgGWrLkq/fcrOcRI24Oj
 u/9cbTDF1NGsMxCHCTYys/pWCmUq6VBgXXCq3bR0CKhnwZsHqgKE9Qgp3Dt6xlg2RPfrr2gpdPD
 JpktRE/UEIRg5n/cozS8rnvaiCtyl00XSSDcaDx8jX9peeQZ31LKgLNQifkTGvhNoEEwngfmVFo 4YilCXYXvA4/Mag==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231206-alice-file-v2-5-af617c0d9d94@google.com>
Subject: [PATCH v2 5/7] rust: file: add `Kuid` wrapper
From:   Alice Ryhl <aliceryhl@google.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a wrapper around `kuid_t` called `Kuid`. This allows us to define
various operations on kuids such as equality and current_euid. It also
lets us provide conversions from kuid into userspace values.

Rust Binder needs these operations because it needs to compare kuids for
equality, and it needs to tell userspace about the pid and uid of
incoming transactions.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers.c                  | 45 +++++++++++++++++++++++++++
 rust/kernel/cred.rs             |  5 +--
 rust/kernel/task.rs             | 68 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 116 insertions(+), 3 deletions(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 81b13a953eae..700f01840188 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -11,6 +11,7 @@
 #include <linux/errname.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/pid_namespace.h>
 #include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index fd633d9db79a..58e3a9dff349 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -142,6 +142,51 @@ void rust_helper_put_task_struct(struct task_struct *t)
 }
 EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
 
+kuid_t rust_helper_task_uid(struct task_struct *task)
+{
+	return task_uid(task);
+}
+EXPORT_SYMBOL_GPL(rust_helper_task_uid);
+
+kuid_t rust_helper_task_euid(struct task_struct *task)
+{
+	return task_euid(task);
+}
+EXPORT_SYMBOL_GPL(rust_helper_task_euid);
+
+#ifndef CONFIG_USER_NS
+uid_t rust_helper_from_kuid(struct user_namespace *to, kuid_t uid)
+{
+	return from_kuid(to, uid);
+}
+EXPORT_SYMBOL_GPL(rust_helper_from_kuid);
+#endif /* CONFIG_USER_NS */
+
+bool rust_helper_uid_eq(kuid_t left, kuid_t right)
+{
+	return uid_eq(left, right);
+}
+EXPORT_SYMBOL_GPL(rust_helper_uid_eq);
+
+kuid_t rust_helper_current_euid(void)
+{
+	return current_euid();
+}
+EXPORT_SYMBOL_GPL(rust_helper_current_euid);
+
+struct user_namespace *rust_helper_current_user_ns(void)
+{
+	return current_user_ns();
+}
+EXPORT_SYMBOL_GPL(rust_helper_current_user_ns);
+
+pid_t rust_helper_task_tgid_nr_ns(struct task_struct *tsk,
+				  struct pid_namespace *ns)
+{
+	return task_tgid_nr_ns(tsk, ns);
+}
+EXPORT_SYMBOL_GPL(rust_helper_task_tgid_nr_ns);
+
 struct kunit *rust_helper_kunit_get_current_test(void)
 {
 	return kunit_get_current_test();
diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
index 3794937b5294..fbc749788bfa 100644
--- a/rust/kernel/cred.rs
+++ b/rust/kernel/cred.rs
@@ -8,6 +8,7 @@
 
 use crate::{
     bindings,
+    task::Kuid,
     types::{AlwaysRefCounted, Opaque},
 };
 
@@ -52,9 +53,9 @@ pub fn get_secid(&self) -> u32 {
     }
 
     /// Returns the effective UID of the given credential.
-    pub fn euid(&self) -> bindings::kuid_t {
+    pub fn euid(&self) -> Kuid {
         // SAFETY: By the type invariant, we know that `self.0` is valid.
-        unsafe { (*self.0.get()).euid }
+        Kuid::from_raw(unsafe { (*self.0.get()).euid })
     }
 }
 
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index b2299bc7ac1f..7a3a07660af7 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -5,7 +5,12 @@
 //! C header: [`include/linux/sched.h`](../../../../include/linux/sched.h).
 
 use crate::{bindings, types::Opaque};
-use core::{marker::PhantomData, ops::Deref, ptr};
+use core::{
+    cmp::{Eq, PartialEq},
+    marker::PhantomData,
+    ops::Deref,
+    ptr,
+};
 
 /// Returns the currently running task.
 #[macro_export]
@@ -78,6 +83,12 @@ unsafe impl Sync for Task {}
 /// The type of process identifiers (PIDs).
 type Pid = bindings::pid_t;
 
+/// The type of user identifiers (UIDs).
+#[derive(Copy, Clone)]
+pub struct Kuid {
+    kuid: bindings::kuid_t,
+}
+
 impl Task {
     /// Returns a task reference for the currently executing task/thread.
     ///
@@ -132,12 +143,32 @@ pub fn pid(&self) -> Pid {
         unsafe { *ptr::addr_of!((*self.0.get()).pid) }
     }
 
+    /// Returns the UID of the given task.
+    pub fn uid(&self) -> Kuid {
+        // SAFETY: By the type invariant, we know that `self.0` is valid.
+        Kuid::from_raw(unsafe { bindings::task_uid(self.0.get()) })
+    }
+
+    /// Returns the effective UID of the given task.
+    pub fn euid(&self) -> Kuid {
+        // SAFETY: By the type invariant, we know that `self.0` is valid.
+        Kuid::from_raw(unsafe { bindings::task_euid(self.0.get()) })
+    }
+
     /// Determines whether the given task has pending signals.
     pub fn signal_pending(&self) -> bool {
         // SAFETY: By the type invariant, we know that `self.0` is valid.
         unsafe { bindings::signal_pending(self.0.get()) != 0 }
     }
 
+    /// Returns the given task's pid in the current pid namespace.
+    pub fn pid_in_current_ns(&self) -> Pid {
+        // SAFETY: Calling `task_active_pid_ns` with the current task is always safe.
+        let namespace = unsafe { bindings::task_active_pid_ns(bindings::get_current()) };
+        // SAFETY: We know that `self.0.get()` is valid by the type invariant.
+        unsafe { bindings::task_tgid_nr_ns(self.0.get(), namespace) }
+    }
+
     /// Wakes up the task.
     pub fn wake_up(&self) {
         // SAFETY: By the type invariant, we know that `self.0.get()` is non-null and valid.
@@ -147,6 +178,41 @@ pub fn wake_up(&self) {
     }
 }
 
+impl Kuid {
+    /// Get the current euid.
+    pub fn current_euid() -> Kuid {
+        // SAFETY: Just an FFI call.
+        Self::from_raw(unsafe { bindings::current_euid() })
+    }
+
+    /// Create a `Kuid` given the raw C type.
+    pub fn from_raw(kuid: bindings::kuid_t) -> Self {
+        Self { kuid }
+    }
+
+    /// Turn this kuid into the raw C type.
+    pub fn into_raw(self) -> bindings::kuid_t {
+        self.kuid
+    }
+
+    /// Converts this kernel UID into a userspace UID.
+    ///
+    /// Uses the namespace of the current task.
+    pub fn into_uid_in_current_ns(self) -> bindings::uid_t {
+        // SAFETY: Just an FFI call.
+        unsafe { bindings::from_kuid(bindings::current_user_ns(), self.kuid) }
+    }
+}
+
+impl PartialEq for Kuid {
+    fn eq(&self, other: &Kuid) -> bool {
+        // SAFETY: Just an FFI call.
+        unsafe { bindings::uid_eq(self.kuid, other.kuid) }
+    }
+}
+
+impl Eq for Kuid {}
+
 // SAFETY: The type invariants guarantee that `Task` is always ref-counted.
 unsafe impl crate::types::AlwaysRefCounted for Task {
     fn inc_ref(&self) {

-- 
2.43.0.rc2.451.g8631bc7472-goog

