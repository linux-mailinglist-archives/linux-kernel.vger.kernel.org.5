Return-Path: <linux-kernel+bounces-117866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DF888B09B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23F51F23F27
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22545644F;
	Mon, 25 Mar 2024 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wio0193K"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6633954BF5;
	Mon, 25 Mar 2024 19:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396518; cv=none; b=d+im4W9G/jnkjaKR6bfDY2E5Mg8wIKV2yGFQTkmPguqTKks9tpsOwh5tF9nl9BjqrlAGjEIVm3q9q8i39mk36IdZyblBQ4sZFf8sx/I90DtbXmzcYJUCxhUsSzpExD+TODcTfK8Yw6dJyHPaCA5PvAHsYolA0PSDx226SyfH4pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396518; c=relaxed/simple;
	bh=/QTypASE8D93iYLvREHDwsB5dHZ8V87dnuUHykxExTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IbCXhFb+gJeeJcDF9C5QVDD4KnSq4Qb8+XIDlEQNmsziix3gqX6/eNTfmw8gwI+FRCVAiHpXgUloHwuSCqJADR/biAHzKxnC4PuTRBilTON05Nd0RJduGcuGgUW4kZ7km/b99iTtHHNwv8rfJiycupvjSyjLUMCyK9ymxBahY5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wio0193K; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e0d82c529fso5206815ad.2;
        Mon, 25 Mar 2024 12:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711396516; x=1712001316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21P3jOn14ZtLRVVWjd/aZah81bx8Fq/6mZQF26h4i3s=;
        b=Wio0193KwilUmo0sOPuKthcv4ZMDfprGQnA4vWh7McVb7DOQoJxK8bPGaHaDt56Zes
         wWKcYp5wTfxaeFf1ZW5PuBTSFJeRW+VysJ1pkIxIzpOs1zPI9mqijPnnfbSoqU/S30Gf
         aIhmHu/vnqKIPjbi/m4GTUUTeRfWUWbus44jv9V2sJfppQsn9wrzfglum7Tt7yCjY8lI
         ogBuAQrRGDrkn8vizuYrBwn5nhpIhjO3K367CRkgOMrxeo9pKCrujEzmFMGJscEaJJuq
         ZGTRLPRQOwZu4gj41HsoHZ8wbhDLspV1ypraAKMgRSDUkLv7fj3gymwyOAfBTz/o5NBs
         zrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711396516; x=1712001316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21P3jOn14ZtLRVVWjd/aZah81bx8Fq/6mZQF26h4i3s=;
        b=Pg8+9Rb4fZzNsAay7CK4eWETg/4NkCeWEqnXrh+AjgTGLGMcdTGwxYi7TWf8yT9BC9
         m9EFDjBFr/4yzABBUJtu5Ifsebhyykld+NS1QjVu16Tr5G9XcArtrNYpC0Hl/k03aaaL
         qbpVvCa+0UKKa8sVli5cLkhoHFwz7uDLyi4YTPhuoZVhZ7SMExLe1Bd+L6wy6na3q+1h
         okMhFvgmTcbAVaIT+tRu07G1r3jp7K5xhIRbPE6+U0a3ZBh7HI3Q0WmGP7hwalDlF7g6
         DxPck5xaJLSGq/Chf/EN7hUDEPMCehuRzJ1HRDdIL4a3AHDMSNYPvijZcDZztARC4d5t
         jSDA==
X-Forwarded-Encrypted: i=1; AJvYcCXJYX4HXLesAh7yC5ktIkcZd6RvgxEQ2WCbpFJ2i1clrCaSa0/aPVe31Q6DG6JKY9sSkaY6v7n7Mod0H8/B80bNEg9iBRSIwYG0lpQQ
X-Gm-Message-State: AOJu0YzyK7/5JIkWwRYXIY9aSsgPRTAY+PP1xa1XulwZu2rl8KqirqZX
	LG1GNT5lahdAggtp+GK41uGpUySnwcY5837Bhk7qHi0Ii01dWaifoj/NV4NM
X-Google-Smtp-Source: AGHT+IHmg5BAB14bCIyxrtOHYGqevTlr19nVDbmblsn8Et3gebqOQcJzsvDqu6//UMtqYHH+1quINQ==
X-Received: by 2002:a17:902:e80d:b0:1e0:afa0:d515 with SMTP id u13-20020a170902e80d00b001e0afa0d515mr5664995plg.29.1711396516462;
        Mon, 25 Mar 2024 12:55:16 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id q1-20020a170902dac100b001e06c1eee22sm5099585plx.74.2024.03.25.12.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:55:16 -0700 (PDT)
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
Subject: [PATCH 05/10] rust: alloc: introduce allocation flags
Date: Mon, 25 Mar 2024 16:54:13 -0300
Message-Id: <20240325195418.166013-6-wedsonaf@gmail.com>
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

We'll use them when allocating `Box`, `Arc`, and `UniqueArc` instances,
as well as when allocating memory for `Vec` elements. These changes will
come in subsequent patches.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/bindings/bindings_helper.h |  3 ++
 rust/kernel/alloc.rs            | 56 +++++++++++++++++++++++++++++++++
 rust/kernel/prelude.rs          |  2 +-
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 65b98831b975..ddb5644d4fd9 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -20,5 +20,8 @@
 
 /* `bindgen` gets confused at certain things. */
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
+const gfp_t RUST_CONST_HELPER_GFP_ATOMIC = GFP_ATOMIC;
 const gfp_t RUST_CONST_HELPER_GFP_KERNEL = GFP_KERNEL;
+const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT = GFP_KERNEL_ACCOUNT;
+const gfp_t RUST_CONST_HELPER_GFP_NOWAIT = GFP_NOWAIT;
 const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 8ad57a2e693e..ad48ac8dc13d 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -6,3 +6,59 @@
 #[cfg(not(testlib))]
 mod allocator;
 pub mod vecext;
+
+/// Flags to be used when allocating memory.
+///
+/// They can be combined with the operators `|`, `&`, and `!`.
+///
+/// Values can be used from the [`flags`] module.
+#[derive(Clone, Copy)]
+pub struct Flags(u32);
+
+impl core::ops::BitOr for Flags {
+    type Output = Self;
+    fn bitor(self, rhs: Self) -> Self::Output {
+        Self(self.0 | rhs.0)
+    }
+}
+
+impl core::ops::BitAnd for Flags {
+    type Output = Self;
+    fn bitand(self, rhs: Self) -> Self::Output {
+        Self(self.0 & rhs.0)
+    }
+}
+
+impl core::ops::Not for Flags {
+    type Output = Self;
+    fn not(self) -> Self::Output {
+        Self(!self.0)
+    }
+}
+
+/// Allocation flags.
+///
+/// These are meant to be used in functions that can allocate memory.
+pub mod flags {
+    use super::Flags;
+    use crate::bindings;
+
+    /// Users can not sleep and need the allocation to succeed.
+    ///
+    /// A lower watermark is applied to allow access to "atomic reserves". The current
+    /// implementation doesn't support NMI and few other strict non-preemptive contexts (e.g.
+    /// raw_spin_lock). The same applies to [`GFP_NOWAIT`].
+    pub const GFP_ATOMIC: Flags = Flags(bindings::GFP_ATOMIC);
+
+    /// Typical for kernel-internal allocations. The caller requires ZONE_NORMAL or a lower zone
+    /// for direct access but can direct reclaim.
+    pub const GFP_KERNEL: Flags = Flags(bindings::GFP_KERNEL);
+
+    /// The same as [`GFP_KERNEL`], except the allocation is accounted to kmemcg.
+    pub const GFP_KERNEL_ACCOUNT: Flags = Flags(bindings::GFP_KERNEL_ACCOUNT);
+
+    /// Ror kernel allocations that should not stall for direct reclaim, start physical IO or
+    /// use any filesystem callback.  It is very likely to fail to allocate memory, even for very
+    /// small allocations.
+    pub const GFP_NOWAIT: Flags = Flags(bindings::GFP_NOWAIT);
+}
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index a0177f195dec..a7b203f87aa1 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -14,7 +14,7 @@
 #[doc(no_inline)]
 pub use core::pin::Pin;
 
-pub use crate::alloc::vecext::VecExt;
+pub use crate::alloc::{flags::*, vecext::VecExt};
 
 #[doc(no_inline)]
 pub use alloc::{boxed::Box, vec::Vec};
-- 
2.34.1


