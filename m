Return-Path: <linux-kernel+bounces-128001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DA58954BF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD55F289684
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42AB84FC4;
	Tue,  2 Apr 2024 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KSOwag+5"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE3F133293
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063278; cv=none; b=OfQksYEWm5ssldZAOCjWei1bRLCtboN3UqdPOdA3Mtbk2Zm+aS+7YOa7qRsGqP3ed+dzgiyEE4HsRyda1zUN+lv3YfJZmIwjXm5cf9s7hMQY9f4EHdvwHxWOZKF7+VxGV5Ir6OlCR83hYyeDdDUmy8l2JkExVuWQSdPQD0eRCTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063278; c=relaxed/simple;
	bh=PxWww9p0ux8jd+JTBng4iPUbmo/WqC7WSl9rYFjrBmE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sR5ivMe/A23FXF7vbZ/lRDiIMxRE6j6ebv8ix9FMobyux2/KlOG80XKpVF74IGGl0cyITJiz0dWWVgdfqWjsQwTGNY1RoSj3pWsl0jbS7FyhI8K+wtYjQluyJCDCf8sh/7kVjZIGjmUJgdJQ4LIrCDa0hELRMTkX8Gc7+qEGxEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KSOwag+5; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26ce0bbso9371077276.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 06:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712063276; x=1712668076; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YK0IVBzGw2YL7NaImcW2IKkPiMomILZlbIQFdtxNZRc=;
        b=KSOwag+5uEFIu8LnIUZz2zwJXh6m78qArTPnQjHSjlZx2PegFcPGLdSuEi7gCN3kDt
         CpnLFrI7p9sWNiKp830ksXN2Tqvyzc7h472mk8tDT/z6Wmx8ZtiuWPEWGpudTz8MH3sS
         veFRNB9Zkye+65IZCucmM+oSgQnFFaIPiISzCg2adb59/jULB2hSPqexeGIOiYCOJBBM
         yI3mzM4uCJBEZYBdVJM/gmNRI0bN8HqmNqoLKw9q2rQJoTbi/Lc9yXn0Ls/xNzmWvk2+
         dX5/5cUiVVpOVjpSWbSFa2T+FZvfcNHHjCWx6vVsUOrsU6g3CDxKpTeIO6ylFNTXehPU
         9wiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712063276; x=1712668076;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YK0IVBzGw2YL7NaImcW2IKkPiMomILZlbIQFdtxNZRc=;
        b=M5xcqR8mGzTrwFRYHvGPlGOZBvBaRRuKA40CPEBXpHOSVMUGjILiJJ5Ef6883nKSFs
         VqSshcWN2iE4acCpMRX8Z2eaLK1kl3QDTair77ichEU9PEyRvnSOy1RygDHL2mnGz8iA
         2pwYL8ZMVYeFimd2701sYq0GPf6wolU9fXSrT9eBiO2pGeRs8vUO0K2poijJH31FW5Is
         F5d/+3OpnWX5mF2UFnyzA33CsAawwvsPu88joGc++AQxTEaJMHmlcnaWj1LOuv/Rskcn
         2RSkPAsBbl8O8AFQxrlWkuMslqDsfNoStVwhAoCymz/QeBD7Acn8VDt9MVXavXKGbcFo
         Ss2w==
X-Forwarded-Encrypted: i=1; AJvYcCX9Y7Gr+AlyOPGITzOLWh+kz9EdWD0GQphurVwk1EU6vVGEdr1Fj1dxg9q85/F0EnTn3QwppfMZx0n1Tl5Wj0pcH4hSTFYACCGNtyLh
X-Gm-Message-State: AOJu0YxLq/LZxJapHdiQaTy4BmbG+PKb6IWbsI/z8maO+IFS46Q14z5a
	hmA7DsDWD4SbWqvEXbbuHRiEcDyNOf6VFXacdEvSsNgSAnadEmZw/xgJPQrq6vFS1yXx9f2mJox
	HYYRc0PANsL+DbQ==
X-Google-Smtp-Source: AGHT+IF/7TWz8RhJGovksUMInwr3/uIEtPnnFR2PdQlpU82yszqL3urfPIBkm64cCgKqtH8UZcQCTWDKraB9HAo=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1601:b0:dca:33b8:38d7 with SMTP
 id bw1-20020a056902160100b00dca33b838d7mr3956005ybb.11.1712063276019; Tue, 02
 Apr 2024 06:07:56 -0700 (PDT)
Date: Tue, 02 Apr 2024 13:07:43 +0000
In-Reply-To: <20240402-arc-for-list-v4-0-54db6440a9a9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240402-arc-for-list-v4-0-54db6440a9a9@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3818; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=PxWww9p0ux8jd+JTBng4iPUbmo/WqC7WSl9rYFjrBmE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmDAMjnQQUU7VFbOJ68s6w4F893DduCep4a6HWD
 eY5S2s02p2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZgwDIwAKCRAEWL7uWMY5
 RvnND/9Ou7OIhLaUM33tvAUZQnucWJkibYoGR+SICJqUOF/aoIOn71jr+11PoGT5XBaEdO+Yjg0
 zATsPm7VsQdy/BB7ioZzttGcd8FQjmWz7ZRotTagEUe3DEwwiPlHze58I9liXvEUrDtRMHkBbC+
 el4heWgkp2ESqynmTCsUT3xWACsjj6S7MheF2wPRBP3fRwcW/4DSxYd6RU6sAZ47k2TObo7jsFU
 3D7DDeXkjVGrpAowqAJWJ3BZaJYVcEha1vbkV8D8nWalHtqziHLTFl8CHskZKMsu5US1z657vhw
 INjmVLODp8jMrwwPA3LuUlDEepvBazpY5lc4vIy6Jo0n+zAkhssN7ji2wPCbggcUGiB96zBDTZK
 SEYm63rnKTCk8838Py+j6aQWvvM/moOLzR0PaFfJ6Iu81QOFkOA8p9qyRSdEaUOOi5/TFrTCiBo
 H1ATY8x0XsNbPk9/b8EJsw+s/Wuld2dxoV66Y5jeTSl+Piw+JLirBd3QIiQkPlYvZVXgVIidaMe
 BmITg4qDV4+AJrNziwLKTNNdwlFn+x5VYnk6nrx82nfAoC4uCSILMhfKEocL0O4XkTeiH9/vcVE
 TWQ0lRs/d7WffnS+Pe5uNRb4atWRcUBCz5yRGzJPf69qBh3BzPFqVU1u84zTxuwh1bYhn8dRhfh 79NYDU8wNjnqkTQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240402-arc-for-list-v4-2-54db6440a9a9@google.com>
Subject: [PATCH v4 2/2] rust: sync: add `Arc::into_unique_or_drop`
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Decrement the refcount of an `Arc`, but handle the case where it hits
zero by taking ownership of the now-unique `Arc`, instead of destroying
and deallocating it.

This is a dependency of the linked list that Rust Binder uses. The
linked list uses this method as part of its `ListArc` abstraction [1].

Boqun Feng has authored the examples.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20240402-linked-list-v1-1-b1c59ba7ae3b@google.com [1]
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/arc.rs | 62 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 53addb8876c2..30777241d8cf 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -290,6 +290,68 @@ pub fn as_arc_borrow(&self) -> ArcBorrow<'_, T> {
     pub fn ptr_eq(this: &Self, other: &Self) -> bool {
         core::ptr::eq(this.ptr.as_ptr(), other.ptr.as_ptr())
     }
+
+    /// Converts this [`Arc`] into a [`UniqueArc`], or destroys it if it is not unique.
+    ///
+    /// When this destroys the `Arc`, it does so while properly avoiding races. This means that
+    /// this method will never call the destructor of the value.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::sync::{Arc, UniqueArc};
+    ///
+    /// let arc = Arc::try_new(42)?;
+    /// let unique_arc = arc.into_unique_or_drop();
+    ///
+    /// // The above conversion should succeed since refcount of `arc` is 1.
+    /// assert!(unique_arc.is_some());
+    ///
+    /// assert_eq!(*(unique_arc.unwrap()), 42);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    ///
+    /// ```
+    /// use kernel::sync::{Arc, UniqueArc};
+    ///
+    /// let arc = Arc::try_new(42)?;
+    /// let another = arc.clone();
+    ///
+    /// let unique_arc = arc.into_unique_or_drop();
+    ///
+    /// // The above conversion should fail since refcount of `arc` is >1.
+    /// assert!(unique_arc.is_none());
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
+        // We will manually manage the refcount in this method, so we disable the destructor.
+        let me = ManuallyDrop::new(self);
+        // SAFETY: We own a refcount, so the pointer is still valid.
+        let refcount = unsafe { me.ptr.as_ref() }.refcount.get();
+
+        // If the refcount reaches a non-zero value, then we have destroyed this `Arc` and will
+        // return without further touching the `Arc`. If the refcount reaches zero, then there are
+        // no other arcs, and we can create a `UniqueArc`.
+        //
+        // SAFETY: We own a refcount, so the pointer is not dangling.
+        let is_zero = unsafe { bindings::refcount_dec_and_test(refcount) };
+        if is_zero {
+            // SAFETY: We have exclusive access to the arc, so we can perform unsynchronized
+            // accesses to the refcount.
+            unsafe { core::ptr::write(refcount, bindings::REFCOUNT_INIT(1)) };
+
+            // INVARIANT: We own the only refcount to this arc, so we may create a `UniqueArc`. We
+            // must pin the `UniqueArc` because the values was previously in an `Arc`, and they pin
+            // their values.
+            Some(Pin::from(UniqueArc {
+                inner: ManuallyDrop::into_inner(me),
+            }))
+        } else {
+            None
+        }
+    }
 }
 
 impl<T: 'static> ForeignOwnable for Arc<T> {

-- 
2.44.0.478.gd926399ef9-goog


