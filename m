Return-Path: <linux-kernel+bounces-120230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38FF88D49E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DF01C249CA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A874E28E26;
	Wed, 27 Mar 2024 02:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYY9XVvD"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD9A28DC8;
	Wed, 27 Mar 2024 02:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711506991; cv=none; b=u8DWCrRcPYQT2zBg4qP5wQSasIBPrxAruvC7tNpgtRspHTyGuC9vBQ+yIeXOOF1OFGxAIdn533oZwVXS2sj8dRFBcMaDw15QYnPdfZpX3aI4PO9B6KV8z8NLUGCWKTriFkKmhwzpvybXhvsUZhzWTPQqT/Cib6DAyYsgIB/RRqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711506991; c=relaxed/simple;
	bh=OnxJM8MtT6hmngjXVSsX0B92HW9GjGkLdfZieFHBEZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dC68jv+x+9L8M/4LTT6Wf/3Uu/zieqIhqs7tjJjfkEGW57Hl/p4HCrxrIRBbGRDi0hF0QM5RS+5Zb9UB7PIieu9RLVaJgcqt5h01JfSTvbEuz8KuExLBTX2pyMnBIzWVZxHQIPhgW1l0hqNGZhDN5iwNi0v7DtTxyHpRNkptS6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYY9XVvD; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29df3333d30so4419059a91.1;
        Tue, 26 Mar 2024 19:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711506989; x=1712111789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiOTxVpWX5GSU2dn6Y9lba1ybxkK7QhwN/uNuJH9fCw=;
        b=HYY9XVvD6+0ndtE63KgXFUf5iq9OWEbFYYR6LZ1v8PfhiE6eke6z9oDRNAgH7ZJnDB
         Y7nsy1ikj5iVh57QX/AdLkQol+3/ljgarcJPnDsplP3NMFEf/BpU+DDOC/CgUo4iBSX7
         tWwLMrQUzA5paVQwLKKGT/MebcEAL2F+GxmwGUf6qHUobg5aK34piGveju4F05rOpw9E
         1Aa/lByXaVA1739kt1D+9N8BybXTSOX4nyL0SqIUOGZWmkXIbHJd0RL7ZLBkjMp3StPm
         Rk+3neFg2ihCl060bB78ykZjqLS7Z+WURVVvLM6YKMKaPN91czu+0ooT3Z3kYvvX/ClD
         QnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711506989; x=1712111789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiOTxVpWX5GSU2dn6Y9lba1ybxkK7QhwN/uNuJH9fCw=;
        b=QVgvVZ8U/PolAlyHecrHF8tZruHmnBztaLH/oSzEW4TjPPjT0wdlslsMTCHNXktokt
         4SpUB5qTgPCt6ncAURvT6VRkwoZJZCgIltNzzTdw4OYYZpJmAeMHAp658pT+diraU1xu
         /TyjIX39KOdTSzpCwTk2MgJvD69zM0jo6sJB4NdTzuNYROcAO+pPDZQh/aGNLzaTa6Jn
         whE4IrJa/7+4pdDHjURPtGheWhj7jQKTsOxMAnKh0NdMfHWWl7AkFlxdvJ+okJfQXypU
         OAuxINHHMAeiI/gAvV09PMcouL+yUAv+U/WBWcbCHM0n9f3wswtByq2X/+ImR8PXd/lN
         0o3w==
X-Forwarded-Encrypted: i=1; AJvYcCWNbbogYKg8zol41LBs09yDMaUd3VvsxiIXo8N02gBB/lekhk5QqlAmBc7OnO+MSTfELsz/lkX5S1xMwX4uGP70wTmfEQp1CaFXquXB
X-Gm-Message-State: AOJu0YxsIQAMeNXXKWhBZMBIWPt0X9QbZrWzy7hP8WMFX+b2/HqMTDms
	RiWoM4OgqfnCPR1fZfo4DTePPVa9l3WSD682Qa26fR9dBX0Ms2z0m5GKSMIv
X-Google-Smtp-Source: AGHT+IH+kP/Y8k1yZ43DmMLTxzGkzSTDl7vIb7SfQRbkXeffuQf6g0tnqkrkxQ5d8U9f6pE2ZpmS/A==
X-Received: by 2002:a17:90a:f3c2:b0:2a0:7601:d50a with SMTP id ha2-20020a17090af3c200b002a07601d50amr1775473pjb.0.1711506989157;
        Tue, 26 Mar 2024 19:36:29 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id l20-20020a17090a409400b0029b2e5bc1b9sm347441pjg.23.2024.03.26.19.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 19:36:28 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH v2 08/10] rust: sync: update `Arc` and `UniqueArc` to take allocation flags
Date: Tue, 26 Mar 2024 23:35:29 -0300
Message-Id: <20240327023531.187880-9-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327023531.187880-1-wedsonaf@gmail.com>
References: <20240327023531.187880-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

We also remove the `try_` prefix to align with how `Box` and `Vec` are
providing methods now.

`init` is temporarily updated with uses of GFP_KERNEL. These will be
updated in a subsequent patch to take flags as well.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/init.rs        |  4 ++--
 rust/kernel/sync/arc.rs    | 28 ++++++++++++++--------------
 samples/rust/rust_print.rs |  4 ++--
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 9c798cffc8e4..a5911fec428b 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -1189,7 +1189,7 @@ fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
     where
         E: From<AllocError>,
     {
-        let mut this = UniqueArc::try_new_uninit()?;
+        let mut this = UniqueArc::new_uninit(GFP_KERNEL)?;
         let slot = this.as_mut_ptr();
         // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
         // slot is valid and will not be moved, because we pin it later.
@@ -1203,7 +1203,7 @@ fn try_init<E>(init: impl Init<T, E>) -> Result<Self, E>
     where
         E: From<AllocError>,
     {
-        let mut this = UniqueArc::try_new_uninit()?;
+        let mut this = UniqueArc::new_uninit(GFP_KERNEL)?;
         let slot = this.as_mut_ptr();
         // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
         // slot is valid.
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 1252a1b630ed..b67bb876ddf7 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -16,7 +16,7 @@
 //! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
 
 use crate::{
-    alloc::{box_ext::BoxExt, flags::*},
+    alloc::{box_ext::BoxExt, Flags},
     bindings,
     error::{self, Error},
     init::{self, InPlaceInit, Init, PinInit},
@@ -58,7 +58,7 @@
 /// }
 ///
 /// // Create a refcounted instance of `Example`.
-/// let obj = Arc::try_new(Example { a: 10, b: 20 })?;
+/// let obj = Arc::new(Example { a: 10, b: 20 }, GFP_KERNEL)?;
 ///
 /// // Get a new pointer to `obj` and increment the refcount.
 /// let cloned = obj.clone();
@@ -97,7 +97,7 @@
 ///     }
 /// }
 ///
-/// let obj = Arc::try_new(Example { a: 10, b: 20 })?;
+/// let obj = Arc::new(Example { a: 10, b: 20 }, GFP_KERNEL)?;
 /// obj.use_reference();
 /// obj.take_over();
 /// # Ok::<(), Error>(())
@@ -120,7 +120,7 @@
 /// impl MyTrait for Example {}
 ///
 /// // `obj` has type `Arc<Example>`.
-/// let obj: Arc<Example> = Arc::try_new(Example)?;
+/// let obj: Arc<Example> = Arc::new(Example, GFP_KERNEL)?;
 ///
 /// // `coerced` has type `Arc<dyn MyTrait>`.
 /// let coerced: Arc<dyn MyTrait> = obj;
@@ -163,7 +163,7 @@ unsafe impl<T: ?Sized + Sync + Send> Sync for Arc<T> {}
 
 impl<T> Arc<T> {
     /// Constructs a new reference counted instance of `T`.
-    pub fn try_new(contents: T) -> Result<Self, AllocError> {
+    pub fn new(contents: T, flags: Flags) -> Result<Self, AllocError> {
         // INVARIANT: The refcount is initialised to a non-zero value.
         let value = ArcInner {
             // SAFETY: There are no safety requirements for this FFI call.
@@ -171,7 +171,7 @@ pub fn try_new(contents: T) -> Result<Self, AllocError> {
             data: contents,
         };
 
-        let inner = <Box<_> as BoxExt<_>>::new(value, GFP_KERNEL)?;
+        let inner = <Box<_> as BoxExt<_>>::new(value, flags)?;
 
         // SAFETY: We just created `inner` with a reference count of 1, which is owned by the new
         // `Arc` object.
@@ -388,7 +388,7 @@ fn from(item: Pin<UniqueArc<T>>) -> Self {
 ///     e.into()
 /// }
 ///
-/// let obj = Arc::try_new(Example)?;
+/// let obj = Arc::new(Example, GFP_KERNEL)?;
 /// let cloned = do_something(obj.as_arc_borrow());
 ///
 /// // Assert that both `obj` and `cloned` point to the same underlying object.
@@ -412,7 +412,7 @@ fn from(item: Pin<UniqueArc<T>>) -> Self {
 ///     }
 /// }
 ///
-/// let obj = Arc::try_new(Example { a: 10, b: 20 })?;
+/// let obj = Arc::new(Example { a: 10, b: 20 }, GFP_KERNEL)?;
 /// obj.as_arc_borrow().use_reference();
 /// # Ok::<(), Error>(())
 /// ```
@@ -500,7 +500,7 @@ fn deref(&self) -> &Self::Target {
 /// }
 ///
 /// fn test() -> Result<Arc<Example>> {
-///     let mut x = UniqueArc::try_new(Example { a: 10, b: 20 })?;
+///     let mut x = UniqueArc::new(Example { a: 10, b: 20 }, GFP_KERNEL)?;
 ///     x.a += 1;
 ///     x.b += 1;
 ///     Ok(x.into())
@@ -523,7 +523,7 @@ fn deref(&self) -> &Self::Target {
 /// }
 ///
 /// fn test() -> Result<Arc<Example>> {
-///     let x = UniqueArc::try_new_uninit()?;
+///     let x = UniqueArc::new_uninit(GFP_KERNEL)?;
 ///     Ok(x.write(Example { a: 10, b: 20 }).into())
 /// }
 ///
@@ -543,7 +543,7 @@ fn deref(&self) -> &Self::Target {
 /// }
 ///
 /// fn test() -> Result<Arc<Example>> {
-///     let mut pinned = Pin::from(UniqueArc::try_new(Example { a: 10, b: 20 })?);
+///     let mut pinned = Pin::from(UniqueArc::new(Example { a: 10, b: 20 }, GFP_KERNEL)?);
 ///     // We can modify `pinned` because it is `Unpin`.
 ///     pinned.as_mut().a += 1;
 ///     Ok(pinned.into())
@@ -557,15 +557,15 @@ pub struct UniqueArc<T: ?Sized> {
 
 impl<T> UniqueArc<T> {
     /// Tries to allocate a new [`UniqueArc`] instance.
-    pub fn try_new(value: T) -> Result<Self, AllocError> {
+    pub fn new(value: T, flags: Flags) -> Result<Self, AllocError> {
         Ok(Self {
             // INVARIANT: The newly-created object has a refcount of 1.
-            inner: Arc::try_new(value)?,
+            inner: Arc::new(value, flags)?,
         })
     }
 
     /// Tries to allocate a new [`UniqueArc`] instance whose contents are not initialised yet.
-    pub fn try_new_uninit() -> Result<UniqueArc<MaybeUninit<T>>, AllocError> {
+    pub fn new_uninit(_flags: Flags) -> Result<UniqueArc<MaybeUninit<T>>, AllocError> {
         // INVARIANT: The refcount is initialised to a non-zero value.
         let inner = Box::try_init::<AllocError>(try_init!(ArcInner {
             // SAFETY: There are no safety requirements for this FFI call.
diff --git a/samples/rust/rust_print.rs b/samples/rust/rust_print.rs
index 67ed8ebf8e8e..6eabb0d79ea3 100644
--- a/samples/rust/rust_print.rs
+++ b/samples/rust/rust_print.rs
@@ -18,8 +18,8 @@
 fn arc_print() -> Result {
     use kernel::sync::*;
 
-    let a = Arc::try_new(1)?;
-    let b = UniqueArc::try_new("hello, world")?;
+    let a = Arc::new(1, GFP_KERNEL)?;
+    let b = UniqueArc::new("hello, world", GFP_KERNEL)?;
 
     // Prints the value of data in `a`.
     pr_info!("{}", a);
-- 
2.34.1


