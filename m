Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991967FD723
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjK2Mvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbjK2Mv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:51:29 -0500
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840C010DD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:51:34 -0800 (PST)
Received: by mail-lj1-x24a.google.com with SMTP id 38308e7fff4ca-2c9c3782740so2193161fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701262293; x=1701867093; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p6QB4S7RjpON9iiRgYxSOKOTgG1ip8XyxblOChu7yx8=;
        b=F2LYWsE3riR6r3HRnnpGZd2moP8fkxLa0AlW7T8OLYVDPnc7jjYAxB8fF+P2P4+MTz
         HNo6Y9Lnw72MEH1kuNjY0U5zNGgyb8ERKmoVbz8YwCmwT+NDM478XYo6A64ovgZ9Yo1X
         CWejhgLwy45kR1pkQYUmluWoi5I4sRzEE/urp58hy1ajF+TOgVIapnxY4PMTTq0NJ2j3
         zIz4KvuUXXVO8pu6zSNBqCPcxivZNVoJGUPNnOkec4I7HzbvP8m8S8h0VL8++MsmKSyA
         taKQhb/3kxf8J2EWite6eVaD8KUVMe1ypvIkMlquvMeQCqplZEVbhdboFyO2eopK+KGV
         lwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701262293; x=1701867093;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6QB4S7RjpON9iiRgYxSOKOTgG1ip8XyxblOChu7yx8=;
        b=MsAmT6sFSG0PrvxiyxtuJbsFmn3rQX6rfNxqr0SGpmz/eLqvF9kRdNPQSNHEhtLj6z
         iBYJFLXk1TUT6/GVss5eDurzcowRdftQVXiqU7QAlqRTLSCAdK2J5PPPpJsA9y1YOsbq
         XGNFj7Iat1l9pEw+2WoFF2c1ocQeA+iQCDIjke/YcdEf4E8556bVoiluucMgWdz51jLt
         Y4tv9K6+nMoFyrDo4WAr4/dmsObTIDVywYg6x5Naa3vTp8U1miRRfsqSP/2K4OZ7wLqp
         qvSETm9fiwZD0Gds87ckvYNAIpEmsWhWzu32nWol4aCxPMWt5lViaQGDChshPN/jv1gt
         3gEA==
X-Gm-Message-State: AOJu0Yz5Vkh5Z/bdpBZbQPow68mHdo5EjEstQ8Zo4G9yjadkbU81dq3q
        NMRMYjP2DYhvl0Tma3HWzumjddcKFcN7aag=
X-Google-Smtp-Source: AGHT+IHS9AV6c+T1U8ggne7cDTOmDoVR3alPQBGekJkcrIMZ8l41L7D2dIg8QXwHUu1XELVu+8Dthc+cektvUCk=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:b5a7:0:b0:2c8:82f1:d5b1 with SMTP id
 f7-20020a2eb5a7000000b002c882f1d5b1mr289874ljn.10.1701262292697; Wed, 29 Nov
 2023 04:51:32 -0800 (PST)
Date:   Wed, 29 Nov 2023 12:51:08 +0000
In-Reply-To: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
Mime-Version: 1.0
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6667; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=t47S0WZDVMIoa027rtsW157b15A9bzwhfrZLuzcINm0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlZzMy43el8c2O94uLKsnTeu1ybBZWvATM7f0cf
 BISvhh54g2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZWczMgAKCRAEWL7uWMY5
 RufXD/9m/h8mCcP5EbfN4dPSygW7RpJ+QIus6e6EEUo4+to0xhSzDPAN6BNxGP3RpOkle5lLSQH
 ae5cbBUluG5xEuvmoxRsW7UoaAXDUWQubZBLiuUlKzC+90UHknLFMyYpPNCLEZ/KAFeuMZ9/hSO
 71ZhTJHZnge+O6bruAtFShQSQ5izfcldRce9WT7BDHamq54gf5arqb+d3IG5mQE6j5Nb3IargqR
 G2HMrlczL9/f5SXwLIsi3gGGC8U6EoPjBeoL/IX2SJ6oe9glgqc/8oKvrGdWNGc7of//TNAWyJU
 kjDZLiD2qymDZMW16Y9/gDvzA8nUYJ8yFucfDSGfl5J8CEbeG/t8MacJCEb4w3M23WzH5KzM/MX
 SxrXPUwWuuluYfvs76zIQp7VH6yg/zYpRSkcNHceWpDQBt5MneCv5lb/LDJyyUJj47jkC2Ey4Ya
 xBQIWr7RX7f63nU5D4ajNFQHvCVCpVSk/JJlMMGXR3/jocIUrbhW0eHraEX04qckruzE7wAwxaN
 kbiPyhThuCiyo9JtnKNoduMG5jyU87sIOM+b9Y7OWVOEeVKpDakGoPjP/84GvXIntuB759JPTxM
 /1wENIDAxy/KWM+31H70oQ94X6z9bRw7FWnBdevCF/ARG9Jk+KkvIck+nrSwYC1tUtBk9TeG824 sXUo65AMCEvaYHg==
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129-alice-file-v1-2-f81afe8c7261@google.com>
Subject: [PATCH 2/7] rust: cred: add Rust abstraction for `struct cred`
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
Cc:     Alice Ryhl <aliceryhl@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Add a wrapper around `struct cred` called `Credential`, and provide
functionality to get the `Credential` associated with a `File`.

Rust Binder must check the credentials of processes when they attempt to
perform various operations, and these checks usually take a
`&Credential` as parameter. The security_binder_set_context_mgr function
would be one example. This patch is necessary to access these security_*
methods from Rust.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers.c                  | 13 +++++++++
 rust/kernel/cred.rs             | 64 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/file.rs             | 16 +++++++++++
 rust/kernel/lib.rs              |  1 +
 5 files changed, 95 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index beed3ef1fbc3..6d1bd2229aab 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
+#include <linux/cred.h>
 #include <linux/errname.h>
 #include <linux/file.h>
 #include <linux/fs.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index 03141a3608a4..10ed69f76424 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -23,6 +23,7 @@
 #include <kunit/test-bug.h>
 #include <linux/bug.h>
 #include <linux/build_bug.h>
+#include <linux/cred.h>
 #include <linux/err.h>
 #include <linux/errname.h>
 #include <linux/fs.h>
@@ -164,6 +165,18 @@ struct file *rust_helper_get_file(struct file *f)
 }
 EXPORT_SYMBOL_GPL(rust_helper_get_file);
 
+const struct cred *rust_helper_get_cred(const struct cred *cred)
+{
+	return get_cred(cred);
+}
+EXPORT_SYMBOL_GPL(rust_helper_get_cred);
+
+void rust_helper_put_cred(const struct cred *cred)
+{
+	put_cred(cred);
+}
+EXPORT_SYMBOL_GPL(rust_helper_put_cred);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
new file mode 100644
index 000000000000..497058ec89bb
--- /dev/null
+++ b/rust/kernel/cred.rs
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Credentials management.
+//!
+//! C header: [`include/linux/cred.h`](../../../../include/linux/cred.h)
+//!
+//! Reference: <https://www.kernel.org/doc/html/latest/security/credentials.html>
+
+use crate::{
+    bindings,
+    types::{AlwaysRefCounted, Opaque},
+};
+
+/// Wraps the kernel's `struct cred`.
+///
+/// # Invariants
+///
+/// Instances of this type are always ref-counted, that is, a call to `get_cred` ensures that the
+/// allocation remains valid at least until the matching call to `put_cred`.
+#[repr(transparent)]
+pub struct Credential(pub(crate) Opaque<bindings::cred>);
+
+// SAFETY: By design, the only way to access a `Credential` is via an immutable reference or an
+// `ARef`. This means that the only situation in which a `Credential` can be accessed mutably is
+// when the refcount drops to zero and the destructor runs. It is safe for that to happen on any
+// thread, so it is ok for this type to be `Send`.
+unsafe impl Send for Credential {}
+
+// SAFETY: It's OK to access `Credential` through shared references from other threads because
+// we're either accessing properties that don't change or that are properly synchronised by C code.
+unsafe impl Sync for Credential {}
+
+impl Credential {
+    /// Creates a reference to a [`Credential`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`Credential`] reference.
+    pub unsafe fn from_ptr<'a>(ptr: *const bindings::cred) -> &'a Credential {
+        // SAFETY: The safety requirements guarantee the validity of the dereference, while the
+        // `Credential` type being transparent makes the cast ok.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Returns the effective UID of the given credential.
+    pub fn euid(&self) -> bindings::kuid_t {
+        // SAFETY: By the type invariant, we know that `self.0` is valid.
+        unsafe { (*self.0.get()).euid }
+    }
+}
+
+// SAFETY: The type invariants guarantee that `Credential` is always ref-counted.
+unsafe impl AlwaysRefCounted for Credential {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
+        unsafe { bindings::get_cred(self.0.get()) };
+    }
+
+    unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
+        unsafe { bindings::put_cred(obj.cast().as_ptr()) };
+    }
+}
diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
index ee4ec8b919af..f1f71c3d97e2 100644
--- a/rust/kernel/file.rs
+++ b/rust/kernel/file.rs
@@ -7,6 +7,7 @@
 
 use crate::{
     bindings,
+    cred::Credential,
     error::{code::*, Error, Result},
     types::{ARef, AlwaysRefCounted, Opaque},
 };
@@ -138,6 +139,21 @@ pub unsafe fn from_ptr<'a>(ptr: *const bindings::file) -> &'a File {
         unsafe { &*ptr.cast() }
     }
 
+    /// Returns the credentials of the task that originally opened the file.
+    pub fn cred(&self) -> &Credential {
+        // This `read_volatile` is intended to correspond to a READ_ONCE call.
+        //
+        // SAFETY: The file is valid because the shared reference guarantees a nonzero refcount.
+        //
+        // TODO: Replace with `read_once` when available on the Rust side.
+        let ptr = unsafe { core::ptr::addr_of!((*self.0.get()).f_cred).read_volatile() };
+
+        // SAFETY: The signature of this function ensures that the caller will only access the
+        // returned credential while the file is still valid, and the credential must stay valid
+        // while the file is valid.
+        unsafe { Credential::from_ptr(ptr) }
+    }
+
     /// Returns the flags associated with the file.
     ///
     /// The flags are a combination of the constants in [`flags`].
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ce9abceab784..097fe9bb93ed 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -33,6 +33,7 @@
 #[cfg(not(testlib))]
 mod allocator;
 mod build_assert;
+pub mod cred;
 pub mod error;
 pub mod file;
 pub mod init;

-- 
2.43.0.rc1.413.gea7ed67945-goog

