Return-Path: <linux-kernel+bounces-117872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD43888B0A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387BB1FA723D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB2247A6F;
	Mon, 25 Mar 2024 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELvCRGEB"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C863F5BACF;
	Mon, 25 Mar 2024 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396550; cv=none; b=MzeFiFGeFZb4RhrUK/t6Potx1IUz5/RXy6PH09SP9f+DF3XE0RjUVq+hfDLvK9fpHF8Lf4uMpuzl5fpMU3MsAMwKvsue0j4nHbjJwE2Ax3nal4cIiQ+itwlHaVG9Q3l+EHjJ83lAQ7Dw9EQizH24V5k0Axa6XymE0aNF74dMy64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396550; c=relaxed/simple;
	bh=BX9FzoS7qhCVVl8n6fqtlAkzsLIhXeeG0tvffqkFAlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=duoMhVKHt+7aq5RdYt78u52W1TrnEdSFuW/eUqgx7hHbqXx5VCopNiX6xNRIh4OLpNSC/KdzJd2zyc1hZlZtucmaY3elmD7ZBiueSw7fQT3k1avmyfTOswOeWQt1nMWTk6/qbN0rmYUSRpcHHjIWZS3w4YDXHcaq+vrPH0+WQ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELvCRGEB; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so2961549a12.0;
        Mon, 25 Mar 2024 12:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711396548; x=1712001348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyeFfBCWPfTKQyt80qj/ch3m4XR7ZP45aG5zhuNtICg=;
        b=ELvCRGEBQkGcmL1hlrod4huJWHDjR2T5wpMxg0MJKdHhHhKoymu2gVsqdfpvF/zt6m
         c5xN+ruV5ZMJV1NV3xsOsva/amj5/2n8vBBw98Jm8iUpuxdv8UuB24QiHDIzTMvl8d7m
         FqKzSf1oFLs7LGQzF1v3YFlRxgkT5FlxRxyhVZZRok7JLJEHvI2RoEw0OKJEeGdbDHjm
         fO/qZ+7HT3GuEBQZ+EcrUcPvuL3h3YfawbQD+Yo2ipRLLETh5Dhjfa0tEcXNys5tlsOh
         iKngv11JcgSLNubFpBiruUoO6iFyVaR+X8jCRV7ubuGdI78Sl4wtdjRwu5hZJItud9lD
         CNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711396548; x=1712001348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyeFfBCWPfTKQyt80qj/ch3m4XR7ZP45aG5zhuNtICg=;
        b=nGyjKOCzZLi83wbOPMPBdWbkxucSLEX/8lDoP385lKKaUiC1w5bdlHRiOVvup02Gw5
         3ydnXo2IVSbyVJlTTucVgNFCGS24ayJGT/pOZvs7PKmOcXIIqm+V1OmrO/p/p/FBolsw
         YT94NT8vYD1lB0DZp33xKKRnU9A2r1gsxM7KyK2C2WCR+6SmkEQ2tCtxorPtUXShREf7
         vQS8yAux1BxCVDRelZbVmd7kIJNxhUU/EhqQAZ606t+uZk5g250WJt5OdENKLhdMMGBf
         stha2EE9OxrymwbzjOv89qsl7jiPvMbIPFFWeereB6KvsEyKrl8qw+R2/Jr14kv3yFBD
         V5CA==
X-Forwarded-Encrypted: i=1; AJvYcCWUcqkwDSA3SNx31jXEhcSA3CQoq2usKO2Gx6suOc2XoFpwcdDQ1amJBUaBI/D4IuUOLIelFq4OfxIyrm51C+pp1IqJ5cnPTJa2JiY1
X-Gm-Message-State: AOJu0YySLsk6O2WvR5/ZCWrtKFO5/fcTRpSKMHQGxEshZs+k3W4icmNq
	hVu4g3xK47sRy0D4XjpftrfOeSYiY4Q2AXTZi2RfkABogPbu8fNNJSONVUUm
X-Google-Smtp-Source: AGHT+IEBepxK/J1lqX231yUahDcZijmyN2suG5/OY0YKr4Z7Te6+Vq7mSvOrJIk57N0G9lNFYv1q8A==
X-Received: by 2002:a17:903:2ad0:b0:1e0:188c:ad4f with SMTP id lw16-20020a1709032ad000b001e0188cad4fmr9853595plb.26.1711396547937;
        Mon, 25 Mar 2024 12:55:47 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id q1-20020a170902dac100b001e06c1eee22sm5099585plx.74.2024.03.25.12.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:55:47 -0700 (PDT)
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
Subject: [PATCH 10/10] rust: kernel: remove usage of `allocator_api` unstable feature
Date: Mon, 25 Mar 2024 16:54:18 -0300
Message-Id: <20240325195418.166013-11-wedsonaf@gmail.com>
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

With the adoption of `BoxExt` and `VecExt`, we don't need the functions
provided by this feature (namely the methods prefixed with `try_` and
different allocator per collection instance).

We do need `AllocError`, but we define our own as it is a trivial empty
struct.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/alloc.rs        |  3 +++
 rust/kernel/alloc/boxext.rs |  3 +--
 rust/kernel/alloc/vecext.rs |  4 ++--
 rust/kernel/error.rs        | 13 ++-----------
 rust/kernel/init.rs         |  3 +--
 rust/kernel/lib.rs          |  1 -
 rust/kernel/str.rs          |  3 +--
 rust/kernel/sync/arc.rs     |  4 ++--
 rust/kernel/workqueue.rs    |  3 +--
 9 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 5712c81b1308..f17f48130f13 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -8,6 +8,9 @@
 pub mod boxext;
 pub mod vecext;
 
+/// Indicates an allocation error.
+pub struct AllocError;
+
 /// Flags to be used when allocating memory.
 ///
 /// They can be combined with the operators `|`, `&`, and `!`.
diff --git a/rust/kernel/alloc/boxext.rs b/rust/kernel/alloc/boxext.rs
index 26a918df7acf..3cdda0f635a3 100644
--- a/rust/kernel/alloc/boxext.rs
+++ b/rust/kernel/alloc/boxext.rs
@@ -2,9 +2,8 @@
 
 //! Extensions to [`Box`] for fallible allocations.
 
-use super::Flags;
+use super::{AllocError, Flags};
 use alloc::boxed::Box;
-use core::alloc::AllocError;
 use core::mem::MaybeUninit;
 use core::result::Result;
 
diff --git a/rust/kernel/alloc/vecext.rs b/rust/kernel/alloc/vecext.rs
index 1d4d51b45a49..85ca6a6db6de 100644
--- a/rust/kernel/alloc/vecext.rs
+++ b/rust/kernel/alloc/vecext.rs
@@ -2,8 +2,8 @@
 
 //! Extensions to [`Vec`] for fallible allocations.
 
-use super::Flags;
-use alloc::{alloc::AllocError, vec::Vec};
+use super::{AllocError, Flags};
+use alloc::vec::Vec;
 use core::{mem::ManuallyDrop, result::Result};
 
 /// Extensions to [`Vec`].
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 4786d3ee1e92..fc986bc24c6d 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -4,12 +4,9 @@
 //!
 //! C header: [`include/uapi/asm-generic/errno-base.h`](srctree/include/uapi/asm-generic/errno-base.h)
 
-use crate::str::CStr;
+use crate::{alloc::AllocError, str::CStr};
 
-use alloc::{
-    alloc::{AllocError, LayoutError},
-    collections::TryReserveError,
-};
+use alloc::alloc::LayoutError;
 
 use core::convert::From;
 use core::fmt;
@@ -192,12 +189,6 @@ fn from(_: Utf8Error) -> Error {
     }
 }
 
-impl From<TryReserveError> for Error {
-    fn from(_: TryReserveError) -> Error {
-        code::ENOMEM
-    }
-}
-
 impl From<LayoutError> for Error {
     fn from(_: LayoutError) -> Error {
         code::ENOMEM
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 1a8b0464db0c..1f7a6b5892ac 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -211,14 +211,13 @@
 //! [`pin_init!`]: crate::pin_init!
 
 use crate::{
-    alloc::{boxext::BoxExt, Flags},
+    alloc::{boxext::BoxExt, AllocError, Flags},
     error::{self, Error},
     sync::UniqueArc,
     types::{Opaque, ScopeGuard},
 };
 use alloc::boxed::Box;
 use core::{
-    alloc::AllocError,
     cell::UnsafeCell,
     convert::Infallible,
     marker::PhantomData,
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 51f30e55bd00..5c641233e26d 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -12,7 +12,6 @@
 //! do so first instead of bypassing this crate.
 
 #![no_std]
-#![feature(allocator_api)]
 #![feature(coerce_unsized)]
 #![feature(dispatch_from_dyn)]
 #![feature(new_uninit)]
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 34dbc85b5220..5206b18f882b 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -2,8 +2,7 @@
 
 //! String representations.
 
-use crate::alloc::{flags::*, vecext::VecExt};
-use alloc::alloc::AllocError;
+use crate::alloc::{flags::*, vecext::VecExt, AllocError};
 use alloc::vec::Vec;
 use core::fmt::{self, Write};
 use core::ops::{self, Deref, Index};
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index af539c5eb4bc..8db25f73b37f 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -16,7 +16,7 @@
 //! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
 
 use crate::{
-    alloc::{boxext::BoxExt, Flags},
+    alloc::{boxext::BoxExt, AllocError, Flags},
     bindings,
     error::{self, Error},
     init::{self, InPlaceInit, Init, PinInit},
@@ -25,7 +25,7 @@
 };
 use alloc::boxed::Box;
 use core::{
-    alloc::{AllocError, Layout},
+    alloc::Layout,
     fmt,
     marker::{PhantomData, Unsize},
     mem::{ManuallyDrop, MaybeUninit},
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 09a0f158ff1b..50837e56efc7 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -132,9 +132,8 @@
 //!
 //! C header: [`include/linux/workqueue.h`](srctree/include/linux/workqueue.h)
 
-use crate::alloc::Flags;
+use crate::alloc::{AllocError, Flags};
 use crate::{bindings, prelude::*, sync::Arc, sync::LockClassKey, types::Opaque};
-use alloc::alloc::AllocError;
 use alloc::boxed::Box;
 use core::marker::PhantomData;
 use core::pin::Pin;
-- 
2.34.1


