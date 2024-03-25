Return-Path: <linux-kernel+bounces-117863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AB288B097
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8333E1FA65E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1955C52F74;
	Mon, 25 Mar 2024 19:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5t/psbO"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E080B4AED8;
	Mon, 25 Mar 2024 19:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396499; cv=none; b=uJ8foeTMHgrUoBk62G6QRzMdJGZ8P7ZlBYyu0Oz54hYN9YEdVlPwmnLUHS5vmKDRYcvZRU5zCatBBqjOVCs/GlvPd0QWrBJyTIDALy+0lmoa2hBleDYFni8SRn60TukwoUZruzTi3iIcLEATrP0aLsAbOuXxAMx6/oh4gj99IsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396499; c=relaxed/simple;
	bh=GpvTAhqfJsdWxTHJcyLn592rRU+7rJcIUsEbCsvcXt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gvuVooZCAGSk8yQDKqZ7RYrWKEczedEvqJhajJgBCH0z8QJnbbQ/ZmYwwbMpeaGCjRbTgONW5Iluh9nTWytKw6NcuJ5DaOSbwOCfJvZvSrg1tRV3ThTMPQcWd7Lma69i+HlW1cfHZ1tQmYj17RAGPrXbAnRWrOcur96N31K/sgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5t/psbO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1df01161b39so37137015ad.3;
        Mon, 25 Mar 2024 12:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711396497; x=1712001297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfAqoR8fGqIvWyJtLhGuGzpKHZ3UCvocy5kc8JQKQzo=;
        b=c5t/psbOuHKwEE7l63yWZC0MC7I2adp6DZKSN/hXZWpDBxa16CvJPdvgVKW4K1k4aE
         Gi4GF24KVg/KY57RMsaak0AqHLK+/aXgfea7VCcprRqRwHwsrjO2uL8XOWvQYeu+Y8tM
         z9APACrV8fGZelRFiS0nUyiQ7gG2RFwisJ9LQIjvBky9F/ychpnTsvMk1ezbAKs0O4/I
         iKRTxKpw4QPs8RX16uJIGq6G+utYt96gXRzkejVz84x0bxGjv64arAdoySw5OLGrY4da
         +N8pA6Pa85DKUSdF3SJ6bNPW15Ycqn3rTLMm9AgWvOztp+Zg+nOi0egvk6s6JTevNzE8
         SZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711396497; x=1712001297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AfAqoR8fGqIvWyJtLhGuGzpKHZ3UCvocy5kc8JQKQzo=;
        b=b3LICB9HBh0mIXDYhE1XoF6iUUyOhDM00ky+NiZ+uP5OIfjq0AHRcSfSDKrwMbI1Zv
         mMAV+EL/gBaLOggyFjDLAe3b/1dgwR0JNn42ty4aJWjzCIwfFbPtIQdhF3ZVubl/BvQd
         GcozZwzX+673P1JUBqLkFvui5nBN+SoRFcc5/kZFNWGiyosL2X4ScQjcjQF7C8brCnWD
         4WwCaIFZb6wzRnOroIX5smv9Mb9mXsNuB+O3YTXNup88/JbpvfQXr6GLZKdbKzfMFHcD
         QsiFdojJCzQEChFLAJnALxJDpD4NAq2LFtJgbuTp75ISez3M8iHQ4Nhmxt5uGdWQ9giz
         ljUA==
X-Forwarded-Encrypted: i=1; AJvYcCXgLgrZyKtqqbmQD09SAg7cv/OTMH20v67CNed6PRwTTxkg/YTuacBVIZxTnc9Wpt9++cOeYKBzcSrFHpBFxhrEfq3eZ4SR1CYfj95t
X-Gm-Message-State: AOJu0Yzz+O9R5y4Zii2PNTtIjr8DXIF+54mK/E0ChFHdte6FKsR1vmRv
	c5m8mjnnBaiZ0i+Ck1ZUGlkzbiaCDMRm9nX033zF2dK5TCevGAVFwy9lWrKz
X-Google-Smtp-Source: AGHT+IHOiyhJJ4qyKneXyk7lGnxlRSJ64KsqRgdVd50UmrPNCL5kylHVz9o5x+4UbqA3cJGoeac02A==
X-Received: by 2002:a17:902:f70e:b0:1e0:e56e:eddd with SMTP id h14-20020a170902f70e00b001e0e56eedddmr451549plo.32.1711396497016;
        Mon, 25 Mar 2024 12:54:57 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id q1-20020a170902dac100b001e06c1eee22sm5099585plx.74.2024.03.25.12.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:54:56 -0700 (PDT)
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
Subject: [PATCH 02/10] rust: alloc: introduce the `VecExt` trait
Date: Mon, 25 Mar 2024 16:54:10 -0300
Message-Id: <20240325195418.166013-3-wedsonaf@gmail.com>
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

Make `try_with_capacity`, `try_push`, and `try_extend_from_slice`
methods available in `Vec` even though it doesn't implement them. It is
implemented with `try_reserve` and `push_within_capacity`.

This is in preparation for switching to the upstream `alloc` crate.

Suggested-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/alloc.rs        |  1 +
 rust/kernel/alloc/vecext.rs | 52 +++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs          |  1 +
 rust/kernel/prelude.rs      |  2 ++
 4 files changed, 56 insertions(+)
 create mode 100644 rust/kernel/alloc/vecext.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index ccd4149932c3..8ad57a2e693e 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -5,3 +5,4 @@
 #[cfg(not(test))]
 #[cfg(not(testlib))]
 mod allocator;
+pub mod vecext;
diff --git a/rust/kernel/alloc/vecext.rs b/rust/kernel/alloc/vecext.rs
new file mode 100644
index 000000000000..59e92bab534e
--- /dev/null
+++ b/rust/kernel/alloc/vecext.rs
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Extensions to [`Vec`] for fallible allocations.
+
+use alloc::{collections::TryReserveError, vec::Vec};
+use core::result::Result;
+
+/// Extensions to [`Vec`].
+pub trait VecExt<T>: Sized {
+    /// Creates a new [`Vec`] instance with at least the given capacity.
+    fn try_with_capacity(capacity: usize) -> Result<Self, TryReserveError>;
+
+    /// Appends an element to the back of the [`Vec`] instance.
+    fn try_push(&mut self, v: T) -> Result<(), TryReserveError>;
+
+    /// Pushes clones of the elements of slice into the [`Vec`] instance.
+    fn try_extend_from_slice(&mut self, other: &[T]) -> Result<(), TryReserveError>
+    where
+        T: Clone;
+}
+
+impl<T> VecExt<T> for Vec<T> {
+    fn try_with_capacity(capacity: usize) -> Result<Self, TryReserveError> {
+        let mut v = Vec::new();
+        v.try_reserve(capacity)?;
+        Ok(v)
+    }
+
+    fn try_push(&mut self, v: T) -> Result<(), TryReserveError> {
+        if let Err(retry) = self.push_within_capacity(v) {
+            self.try_reserve(1)?;
+            let _ = self.push_within_capacity(retry);
+        }
+        Ok(())
+    }
+
+    fn try_extend_from_slice(&mut self, other: &[T]) -> Result<(), TryReserveError>
+    where
+        T: Clone,
+    {
+        let extra_cap = self.capacity() - self.len();
+        if extra_cap > 0 {
+            self.try_reserve(extra_cap)?;
+        }
+
+        for item in other {
+            self.try_push(item.clone())?;
+        }
+
+        Ok(())
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 51f30e55bd00..7f2841a18d05 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -19,6 +19,7 @@
 #![feature(offset_of)]
 #![feature(receiver_trait)]
 #![feature(unsize)]
+#![feature(vec_push_within_capacity)]
 
 // Ensure conditional compilation based on the kernel configuration works;
 // otherwise we may silently break things like initcall handling.
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index ae21600970b3..a0177f195dec 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -14,6 +14,8 @@
 #[doc(no_inline)]
 pub use core::pin::Pin;
 
+pub use crate::alloc::vecext::VecExt;
+
 #[doc(no_inline)]
 pub use alloc::{boxed::Box, vec::Vec};
 
-- 
2.34.1


