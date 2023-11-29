Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03837FD722
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjK2Mva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbjK2Mv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:51:27 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBB110E6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:51:30 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da07b5e6f75so726269276.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701262290; x=1701867090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0wY83LCwqUfV5ZLdik3LbhCAbciT8Y3UyW5tGMN6GUE=;
        b=Wcql7DDkgMdcdjkmgGWgDrpdZeIw6QZLYIHx96qCZTQActcqYuuGBYFdRBeq/whyTi
         r79HNJSXDIp4LDAh0ngTOJNS5ygf6BUkirzPYbPOvtCsrXS/b59B62S/D/PqrDzajnch
         gnlhRgBvanZmsKta6rQEh0rFPF1HEEurswBafYg/UGkFSyfPtw4u36b4vfqulUjtW/aW
         B4YED2SvLROYBeO7j7bkmHR+BDqK+EjH4QeRrKVg9e8O+8+wITibLSciYy3iVVT4gSf5
         NDSot6JAkMrzXGx65qo+/Z6QHm8Ct21HV/Zk51vcfHKdPERQSfoabwsCAkU92tO9zbQj
         zDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701262290; x=1701867090;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wY83LCwqUfV5ZLdik3LbhCAbciT8Y3UyW5tGMN6GUE=;
        b=RUr4Nevyk2AIDclSkevIo5zzv20Z6GsR2Ph3mg9GYFTbENUbNEI05gYx8zcPL+kZ75
         bld9hO3kbfvRSJsLNEHUasv15mrUqaBIVYruF2c2yktzkdPvoDIaEp+hcBF4aMsWDmSf
         fmaT5S6793H1YswYTBuLmUQ+tAv/m6X/oBbLGyfeabGpipS+N52mCQ5Y7JEp2cu6jUr7
         dSHeHkfWqkMGaafOpWCyQ6fxm4ulrzpDwaz3Bkg06Gb9ZhSM9QfY3NE1sAlsNqLTtgdd
         V8HbMlfoC3dVJREnTiU/BxPO6iqx+bzVimSvA9l6iC289TyDlEWf0pohZt6OqY4rF31F
         x1SA==
X-Gm-Message-State: AOJu0YyLoVfECHUvZC3HHEAKdlzkgWF/u2OeTeewyHrNgf+iUekdiTpe
        EFN10z92B+vqD920HEJocJhnkVHYFWfutew=
X-Google-Smtp-Source: AGHT+IG+UrMdVUxy6jruyHm5ZYnAeYayISK74kY3bjF/4Q8xH2zgmfstVYGpsFfZCZvasquhbqo2bhBcnaCfsIw=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:aa49:0:b0:d89:42d7:e72d with SMTP id
 s67-20020a25aa49000000b00d8942d7e72dmr690263ybi.3.1701262290111; Wed, 29 Nov
 2023 04:51:30 -0800 (PST)
Date:   Wed, 29 Nov 2023 12:51:07 +0000
In-Reply-To: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
Mime-Version: 1.0
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=10762; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Z4lADjotaTuRSVc0fj+8hkjF0ER41DwitA1BNgPnHsM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlZzMxGPEnDhSL0gZ3T/QIiTXSSYiHUkIJ8K5UL
 19ZFVCPb4uJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZWczMQAKCRAEWL7uWMY5
 Rp5GD/9JDpxEHYcsLzT4LRf9umPIlT7KnoDaZw1OabNAZnDmAUszALaVDXOmD2h5vsrvYDk3+fm
 bUFM1IeOAHlF5yEEhT7K6XlyAkM9p1Y6kzHckQKg1IDj5eO3M6T9sqF62uTj5bezT1sDL5EXeh7
 shpvppZ4NfeEpxX7eDgLkBvsFKDKBl4uHgOtNg4zbe324rYGch5dT4KeUJT3eQTQqQ0wS3DZJre
 M1FYPv9msoe+w0uCXNxy5x8J52BMPUcbpiCFfxYHZ15EAiTNy4uwJ1kPnH2SZUsowQWWBqRSOcf
 qX626iitC9uKIPZhd6hi9kFNgLH5H48RcuG5I+HGbb3b/Sy8QHdNChRK+jMAzVtfz760Iowi2Uk
 1zgPgDnUXYrkNk8pOFBBeaQxYCcIXYgPY4XRCFFkG7H4pgIrLnfbUuhFx+WjuYPVk8Xc0gv4R4N
 PNTQcHJIDqrmqMBDxCIvpwcZ9hCtLa1uSv5gMxvOhqyPv2kggsFhFpT8NfBs4dECkHJn9LpCqdr
 njsdmAeSQjZJwspVc+P0idfRtiQfKxWWBqqT53EufW8QItIBqKxpWThM/ZUGfieJZC0D6cQAT0w
 ntLeafzej8pvAHIUlzOud0/aBU2taZQT66cDtQSKGp5tKosgT0I8ahmUyiOkZ4CZ2ffJ4Gp6MqF Ao6ZWllviVYQV/Q==
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129-alice-file-v1-1-f81afe8c7261@google.com>
Subject: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
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

This abstraction makes it possible to manipulate the open files for a
process. The new `File` struct wraps the C `struct file`. When accessing
it using the smart pointer `ARef<File>`, the pointer will own a
reference count to the file. When accessing it as `&File`, then the
reference does not own a refcount, but the borrow checker will ensure
that the reference count does not hit zero while the `&File` is live.

Since this is intended to manipulate the open files of a process, we
introduce a `from_fd` constructor that corresponds to the C `fget`
method. In future patches, it will become possible to create a new fd in
a process and bind it to a `File`. Rust Binder will use these to send
fds from one process to another.

We also provide a method for accessing the file's flags. Rust Binder
will use this to access the flags of the Binder fd to check whether the
non-blocking flag is set, which affects what the Binder ioctl does.

This introduces a struct for the EBADF error type, rather than just
using the Error type directly. This has two advantages:
* `File::from_fd` returns a `Result<ARef<File>, BadFdError>`, which the
  compiler will represent as a single pointer, with null being an error.
  This is possible because the compiler understands that `BadFdError`
  has only one possible value, and it also understands that the
  `ARef<File>` smart pointer is guaranteed non-null.
* Additionally, we promise to users of the method that the method can
  only fail with EBADF, which means that they can rely on this promise
  without having to inspect its implementation.
That said, there are also two disadvantages:
* Defining additional error types involves boilerplate.
* The question mark operator will only utilize the `From` trait once,
  which prevents you from using the question mark operator on
  `BadFdError` in methods that return some third error type that the
  kernel `Error` is convertible into. (However, it works fine in methods
  that return `Error`.)

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Daniel Xu <dxu@dxuuu.xyz>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |   2 +
 rust/helpers.c                  |   7 ++
 rust/kernel/file.rs             | 182 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 4 files changed, 192 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 85f013ed4ca4..beed3ef1fbc3 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -8,6 +8,8 @@
 
 #include <kunit/test.h>
 #include <linux/errname.h>
+#include <linux/file.h>
+#include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
 #include <linux/wait.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index 70e59efd92bc..03141a3608a4 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -25,6 +25,7 @@
 #include <linux/build_bug.h>
 #include <linux/err.h>
 #include <linux/errname.h>
+#include <linux/fs.h>
 #include <linux/mutex.h>
 #include <linux/refcount.h>
 #include <linux/sched/signal.h>
@@ -157,6 +158,12 @@ void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,
 }
 EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
 
+struct file *rust_helper_get_file(struct file *f)
+{
+	return get_file(f);
+}
+EXPORT_SYMBOL_GPL(rust_helper_get_file);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
new file mode 100644
index 000000000000..ee4ec8b919af
--- /dev/null
+++ b/rust/kernel/file.rs
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Files and file descriptors.
+//!
+//! C headers: [`include/linux/fs.h`](../../../../include/linux/fs.h) and
+//! [`include/linux/file.h`](../../../../include/linux/file.h)
+
+use crate::{
+    bindings,
+    error::{code::*, Error, Result},
+    types::{ARef, AlwaysRefCounted, Opaque},
+};
+use core::ptr;
+
+/// Flags associated with a [`File`].
+pub mod flags {
+    /// File is opened in append mode.
+    pub const O_APPEND: u32 = bindings::O_APPEND;
+
+    /// Signal-driven I/O is enabled.
+    pub const O_ASYNC: u32 = bindings::FASYNC;
+
+    /// Close-on-exec flag is set.
+    pub const O_CLOEXEC: u32 = bindings::O_CLOEXEC;
+
+    /// File was created if it didn't already exist.
+    pub const O_CREAT: u32 = bindings::O_CREAT;
+
+    /// Direct I/O is enabled for this file.
+    pub const O_DIRECT: u32 = bindings::O_DIRECT;
+
+    /// File must be a directory.
+    pub const O_DIRECTORY: u32 = bindings::O_DIRECTORY;
+
+    /// Like [`O_SYNC`] except metadata is not synced.
+    pub const O_DSYNC: u32 = bindings::O_DSYNC;
+
+    /// Ensure that this file is created with the `open(2)` call.
+    pub const O_EXCL: u32 = bindings::O_EXCL;
+
+    /// Large file size enabled (`off64_t` over `off_t`).
+    pub const O_LARGEFILE: u32 = bindings::O_LARGEFILE;
+
+    /// Do not update the file last access time.
+    pub const O_NOATIME: u32 = bindings::O_NOATIME;
+
+    /// File should not be used as process's controlling terminal.
+    pub const O_NOCTTY: u32 = bindings::O_NOCTTY;
+
+    /// If basename of path is a symbolic link, fail open.
+    pub const O_NOFOLLOW: u32 = bindings::O_NOFOLLOW;
+
+    /// File is using nonblocking I/O.
+    pub const O_NONBLOCK: u32 = bindings::O_NONBLOCK;
+
+    /// Also known as `O_NDELAY`.
+    ///
+    /// This is effectively the same flag as [`O_NONBLOCK`] on all architectures
+    /// except SPARC64.
+    pub const O_NDELAY: u32 = bindings::O_NDELAY;
+
+    /// Used to obtain a path file descriptor.
+    pub const O_PATH: u32 = bindings::O_PATH;
+
+    /// Write operations on this file will flush data and metadata.
+    pub const O_SYNC: u32 = bindings::O_SYNC;
+
+    /// This file is an unnamed temporary regular file.
+    pub const O_TMPFILE: u32 = bindings::O_TMPFILE;
+
+    /// File should be truncated to length 0.
+    pub const O_TRUNC: u32 = bindings::O_TRUNC;
+
+    /// Bitmask for access mode flags.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::file;
+    /// # fn do_something() {}
+    /// # let flags = 0;
+    /// if (flags & file::flags::O_ACCMODE) == file::flags::O_RDONLY {
+    ///     do_something();
+    /// }
+    /// ```
+    pub const O_ACCMODE: u32 = bindings::O_ACCMODE;
+
+    /// File is read only.
+    pub const O_RDONLY: u32 = bindings::O_RDONLY;
+
+    /// File is write only.
+    pub const O_WRONLY: u32 = bindings::O_WRONLY;
+
+    /// File can be both read and written.
+    pub const O_RDWR: u32 = bindings::O_RDWR;
+}
+
+/// Wraps the kernel's `struct file`.
+///
+/// # Invariants
+///
+/// Instances of this type are always ref-counted, that is, a call to `get_file` ensures that the
+/// allocation remains valid at least until the matching call to `fput`.
+#[repr(transparent)]
+pub struct File(Opaque<bindings::file>);
+
+// SAFETY: By design, the only way to access a `File` is via an immutable reference or an `ARef`.
+// This means that the only situation in which a `File` can be accessed mutably is when the
+// refcount drops to zero and the destructor runs. It is safe for that to happen on any thread, so
+// it is ok for this type to be `Send`.
+unsafe impl Send for File {}
+
+// SAFETY: It's OK to access `File` through shared references from other threads because we're
+// either accessing properties that don't change or that are properly synchronised by C code.
+unsafe impl Sync for File {}
+
+impl File {
+    /// Constructs a new `struct file` wrapper from a file descriptor.
+    ///
+    /// The file descriptor belongs to the current process.
+    pub fn from_fd(fd: u32) -> Result<ARef<Self>, BadFdError> {
+        // SAFETY: FFI call, there are no requirements on `fd`.
+        let ptr = ptr::NonNull::new(unsafe { bindings::fget(fd) }).ok_or(BadFdError)?;
+
+        // INVARIANT: `fget` increments the refcount before returning.
+        Ok(unsafe { ARef::from_raw(ptr.cast()) })
+    }
+
+    /// Creates a reference to a [`File`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` points at a valid file and that its refcount does not
+    /// reach zero during the lifetime 'a.
+    pub unsafe fn from_ptr<'a>(ptr: *const bindings::file) -> &'a File {
+        // INVARIANT: The safety requirements guarantee that the refcount does not hit zero during
+        // 'a. The cast is okay because `File` is `repr(transparent)`.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Returns the flags associated with the file.
+    ///
+    /// The flags are a combination of the constants in [`flags`].
+    pub fn flags(&self) -> u32 {
+        // This `read_volatile` is intended to correspond to a READ_ONCE call.
+        //
+        // SAFETY: The file is valid because the shared reference guarantees a nonzero refcount.
+        //
+        // TODO: Replace with `read_once` when available on the Rust side.
+        unsafe { core::ptr::addr_of!((*self.0.get()).f_flags).read_volatile() }
+    }
+}
+
+// SAFETY: The type invariants guarantee that `File` is always ref-counted.
+unsafe impl AlwaysRefCounted for File {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
+        unsafe { bindings::get_file(self.0.get()) };
+    }
+
+    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
+        unsafe { bindings::fput(obj.cast().as_ptr()) }
+    }
+}
+
+/// Represents the `EBADF` error code.
+///
+/// Used for methods that can only fail with `EBADF`.
+pub struct BadFdError;
+
+impl From<BadFdError> for Error {
+    fn from(_: BadFdError) -> Error {
+        EBADF
+    }
+}
+
+impl core::fmt::Debug for BadFdError {
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        f.pad("EBADF")
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index e6aff80b521f..ce9abceab784 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -34,6 +34,7 @@
 mod allocator;
 mod build_assert;
 pub mod error;
+pub mod file;
 pub mod init;
 pub mod ioctl;
 #[cfg(CONFIG_KUNIT)]

-- 
2.43.0.rc1.413.gea7ed67945-goog

