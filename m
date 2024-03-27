Return-Path: <linux-kernel+bounces-120224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D3788D499
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5084C1F2F405
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AC4225A8;
	Wed, 27 Mar 2024 02:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3bs4OtK"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7830722EFD;
	Wed, 27 Mar 2024 02:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711506961; cv=none; b=d8k7GQ5SBZ8Wx17dDR7DdpxTHxRl2Zg/GRXFM8uphJb8pfZc2/kV3hLGGQhndQeWcFqU+LxN7BzbGrpkQ23W1OYf9ABFjbobvoEJ2P5riq/QEX+cGLVNQz1g0WQY/k1hXZl0zFrgI0vawgNPmMPxFMQMFgJgXm0+TdI7hG4pVjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711506961; c=relaxed/simple;
	bh=IilFXnlIHDAkkessE/SpSvQi2ra6lRcyKZ3Q/fq1hX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V6Tu6qjfcNwBF6pUeF9zaJvr02s3prJFzNpXSFgrqixSy9oHEy8OaEE25Xb2Pgld7XgswfzyGmzSGtWEywIP//0DNaOE5MYt0vrWkSdysfGA9aHuYPnFSmGg/HbKAg2KLi2ufYcI6Jz/QwDtIQaSv26tDTIFaGXiP9oJ7TkPQPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3bs4OtK; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso4350095a12.3;
        Tue, 26 Mar 2024 19:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711506960; x=1712111760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=is4/ykqJO1ReAP6DDSEum2VHbIujlrPWTW7BeyLRLts=;
        b=R3bs4OtKpAtY8YI34qjEgzfPmLTEoNgygLf9r9OKRgphrUnHmrnjWiMV0t7NuWd5sw
         sfxMUHp5BUDWg42fguJYDgGUtS2xcQsk5aQgbBXf+WxHl1A+vBmr2fP+K8I7uvSMoZxl
         pOJG+d/honceI4D7P3ZAzHZmPrPTdxW9ERdTvHIT/aBccamIfTq/sDqwcWsRu6gbp9A3
         boYHnQulv/ldPMlFatoQWVRXdcopEYTx8AXT2ad/blakLIWCCUErO15TPFcta0+oZIvu
         khKV1qTFw5SgNi/Ztp5Zp/mTx1os2iDYTJaTpnmSm9jh+hLXCq6A2FvJlGYFcMPylbkY
         XR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711506960; x=1712111760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=is4/ykqJO1ReAP6DDSEum2VHbIujlrPWTW7BeyLRLts=;
        b=StOTSKXeH+EtgvBgHRGEeJXIOoa3Cm379jLiA2PoUnMMED/paVSbzIcyf/zFvNWY88
         qk1m35B6abY0s4j72fuOEEz+bjx7mkLrUrUguFHQflGJFUl7gS2YXzJrbVNID7UXwopK
         KMhLRu06MzSdeY8rcHZXGfyzES3cwNHXuTNWpq/rzttsy9bipn+hA6PcrLLYNxWmh/74
         OcRhqpwyF4vd5uk3xT1HAfrAbJQ9zvUKiGcwq/BTtGZdvG49Ub5zdzB+0v3I49p+93eJ
         1shsEGvkpUXWXTRCTsItjIsIEeisHeMcDjB8Djk0yJ85EU9ev6irlyMzo4aZc8iSbAq+
         VJVg==
X-Forwarded-Encrypted: i=1; AJvYcCW1lI16jvBU2/Bdg9XaD/w3ChULgO5M5LOkWbOiip+L3l9PGFy1PbrqNHYEb9ifTYLUFwkiN+kxacUxeFLbKysoBcmgQ5KkzoWljjok
X-Gm-Message-State: AOJu0YytC13MKnX46d2/AF0TZ2xIBm5dc5T1jmvPcCJhG8R+xLIa3+/N
	XNHphgNHn2NLrXnnrFat50sWM3GNZay+oLcGoknlCe4pi8javnWbrXmkReOx
X-Google-Smtp-Source: AGHT+IEJXNOeGrC8fG7Cyu7MnghCQVLD62lXIUCTJ9s6vTvre02JD899xlD345D1lqGBbelHHPI5Ng==
X-Received: by 2002:a05:6a20:548c:b0:1a3:c4c2:b016 with SMTP id i12-20020a056a20548c00b001a3c4c2b016mr1645069pzk.45.1711506959786;
        Tue, 26 Mar 2024 19:35:59 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id l20-20020a17090a409400b0029b2e5bc1b9sm347441pjg.23.2024.03.26.19.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 19:35:59 -0700 (PDT)
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
Subject: [PATCH v2 02/10] rust: alloc: introduce the `VecExt` trait
Date: Tue, 26 Mar 2024 23:35:23 -0300
Message-Id: <20240327023531.187880-3-wedsonaf@gmail.com>
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

Make `try_with_capacity`, `try_push`, and `try_extend_from_slice`
methods available in `Vec` even though it doesn't implement them. It is
implemented with `try_reserve` and `push_within_capacity`.

This is in preparation for switching to the upstream `alloc` crate.

Suggested-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/alloc.rs         |  1 +
 rust/kernel/alloc/vec_ext.rs | 48 ++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs           |  1 +
 rust/kernel/prelude.rs       |  2 ++
 4 files changed, 52 insertions(+)
 create mode 100644 rust/kernel/alloc/vec_ext.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 9aa5077d4a4c..2c99635f9fd3 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -5,3 +5,4 @@
 #[cfg(not(test))]
 #[cfg(not(testlib))]
 mod allocator;
+pub mod vec_ext;
diff --git a/rust/kernel/alloc/vec_ext.rs b/rust/kernel/alloc/vec_ext.rs
new file mode 100644
index 000000000000..311e62cc5784
--- /dev/null
+++ b/rust/kernel/alloc/vec_ext.rs
@@ -0,0 +1,48 @@
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
+        self.try_reserve(other.len())?;
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
index ae21600970b3..c85b5972c0d3 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -14,6 +14,8 @@
 #[doc(no_inline)]
 pub use core::pin::Pin;
 
+pub use crate::alloc::vec_ext::VecExt;
+
 #[doc(no_inline)]
 pub use alloc::{boxed::Box, vec::Vec};
 
-- 
2.34.1


