Return-Path: <linux-kernel+bounces-117870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCC388B09D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411961C30D95
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C295A10F;
	Mon, 25 Mar 2024 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjy0GHxM"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302685A10E;
	Mon, 25 Mar 2024 19:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396537; cv=none; b=MrV0P+YJL01DdscB9rLhRj6roZtMGEdIenVwjGpDQYkW4QZZu/MUq9hhHn6PTDbj+/TfH7J7qPNUcpR2cX6VHi8cM3KdzC94UWbCcc9hm5z2fHsjXLg8tzfB1wNZUVLoeIEt1bFW5G8GeNCs+1WmJXtqtvM62gDU7d4Bkwd4eNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396537; c=relaxed/simple;
	bh=qfUvhVsZHDJuAIKHfXYcq+IDYASCux9eMwTY/29DVgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jhDaW6mQg7XxHDCqCBhhBSaS9zWFQyVMWm0mZsUQ0HMHeOcQX8q8GGTZIbjC3drPDQ4tNrELuhNo8KxGnAolzmh0mG4WfUWAxKRmTp0D55p+otjQukUcPqZ4h/5aXpjKi3jKTUUZSMAnKsr+HN6RAmqkB5yOoxdyPnDanmu9reM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjy0GHxM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e0411c0a52so34550535ad.0;
        Mon, 25 Mar 2024 12:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711396535; x=1712001335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gI2kRfLpfhjRGhNms5R9ytnJkN1V4VjwgCKV7cdzYX4=;
        b=gjy0GHxMnf9zOGRi1dwhd8Ae7P5RSpcm1DsV6VDqtTfLi9JZEyBCKngmQxtUvN96Fa
         aU1DgCAVkvvOuWYBPNr8mV+I3OyydkeEXLa/5H6J+UHrjYs0NwLO6mWaMwlecaaGu9+Q
         0jYFbkatwDvpMnMtGSwZdqtkrDPlD2fqIIirt5u/pr6fnxNJu6O/z60DX+QTD88KNSyh
         dxdEjIE2RmozRkO/T19bxXWScsJZRCEqR63RtrGMV3l/U+szKj1CWGZZ0N4pKgLkwzEQ
         J3XKjDb6pqwq6G9He2md4Ulo6oX5kizeG5p78L2M2DX0swoy+IoPf+hL9HvgAKIfpPRr
         FXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711396535; x=1712001335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gI2kRfLpfhjRGhNms5R9ytnJkN1V4VjwgCKV7cdzYX4=;
        b=gWDzZJAYaUX5zJOwtKWAzDCpsp0cK+xtATPUolaoStzPdbLxK30G2N0qnRN92lL5fl
         sSWAjC58YwKSA9UuRhNtOgqtrP/xNFljZw5aIGpSdhuekuSoKznLLrvvNO21ClPbHb14
         t7F3jMh5UVKB/YJluK0DbtK+6wJo8+bhHjE/3sFoJcl1v7frLBO7R1mAFijCUi8MwcIV
         N9NUulqNVpDBIyRjDDhHkoEpC6krX3hV+0flCeLdxMsggoGpGstbfVafMowTrErxbS0Y
         fncQDQe/p+WKUR5CzeSbPsqc9pkT/l50dlp+912riUHKmT5yOa4ScMeYG+tNbVmNystM
         yKWw==
X-Forwarded-Encrypted: i=1; AJvYcCXXOFozXOH14nWRt3/CHofLp4S+oU5ehlxAebRc1ib6tN7HIXHIj5RlyqFS8iHuGy36YWJWnsqCKuEW9BQ2J4P+ALfUlR+FjtbAndLF
X-Gm-Message-State: AOJu0YyENLReC6sWn8kB8f2ZXQ3nUybVXjhNa4utq916YbiITDKOqrRR
	jG+NbmfQE6IgW2opUzz74Ytd44DgKfoel0aTQ8CVDC4kDu37vL1ltOuoHhGA
X-Google-Smtp-Source: AGHT+IF0Q0gSH/jw64pDj9PcMzDY4vvHqL2ZaperkCg4fg4BoT6b8gbRNBj4/tf4EybZFUItzyTZfg==
X-Received: by 2002:a17:902:ce8a:b0:1e0:ca47:4d9b with SMTP id f10-20020a170902ce8a00b001e0ca474d9bmr2353838plg.29.1711396535344;
        Mon, 25 Mar 2024 12:55:35 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id q1-20020a170902dac100b001e06c1eee22sm5099585plx.74.2024.03.25.12.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:55:35 -0700 (PDT)
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
Subject: [PATCH 08/10] rust: sync: update `Arc` and `UniqueArc` to take allocation flags
Date: Mon, 25 Mar 2024 16:54:16 -0300
Message-Id: <20240325195418.166013-9-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325195418.166013-1-wedsonaf@gmail.com>
References: <20240325195418.166013-1-wedsonaf@gmail.com>
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

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/init.rs        |  4 ++--
 rust/kernel/sync/arc.rs    | 28 ++++++++++++++--------------
 samples/rust/rust_print.rs |  4 ++--
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 0d956934eaa4..c8b2f9774a39 100644
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
index f0a5aed69693..077200f5350b 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -16,7 +16,7 @@
 //! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
 
 use crate::{
-    alloc::{boxext::BoxExt, flags::*},
+    alloc::{boxext::BoxExt, Flags},
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


