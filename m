Return-Path: <linux-kernel+bounces-127918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1928952C2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78128B26AE2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060FD82899;
	Tue,  2 Apr 2024 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cyyOvmnG"
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A118289C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060254; cv=none; b=f4YmDxRNOC7tuup0N1DPWTHFdSxEpYiZh3pzCM+ezc/3QNAYH9Ic+cTwbGMq7G9VnGz3RitbtxNa4kvuGjywvVTlRJhujBNUGqmGppKcunJRTtB/swuy5AoZvQmw449fm3BDMUZEk7K775XjBmcjZPH1Ou8r86+TM275GrgEuGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060254; c=relaxed/simple;
	bh=HqTvdg8fzcYf4HPXuYAv/EzwRzpXiMamY7vxsIqyqQI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZOoTWRYuDI/AhxiqvjNLDkX4PFxpTOTZoe9xCwHQr4Pc8ruZzurSLxKgq6PByw4AZ0WLMNI0GLe+21juEyb7KjpnkEyMBFm/NkBGrCCOs9NUm98bVJVqvA/pl7EBrlPyrutXnndmhTYEZkbHcMkmOL5Z8ZMHcuBEz4XNWB36KaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cyyOvmnG; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-2d45c064742so51849351fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712060250; x=1712665050; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VJ5h910JMlBSC/fYAKRLARZ1uSxij9BJ97PB2fg4buc=;
        b=cyyOvmnGpPASiGWAdjt9Gbavog2RXcsEkEJUtZ6yGwAIZrxQYl4gZ+pA765qa9WkGW
         3lvrbTdhwsKgxo3RRSqgAFd9i9Do4mynWhqmfC0bwQ0PcvrRyRO1uu9csWsJ9xu/NK7i
         nEyNoWlyQQxl2diCEiNSb0cE/DiU4yKTDN/Rg1umsVNyMIhDCzF8bewSH+phtYU3SREX
         xPaGlwwvqSUD7+sW/UJosKK8ob9uabhjuANsBK6KH9umy1ULF8DMPZUtGrO0lCgjJNBO
         5jJ3E9xEs9YGr4Xvuikrnlze1PgcAsOvLDohdXnMNhkPVST6w5G+N/9VmWPyaCElxL3/
         7nbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712060250; x=1712665050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJ5h910JMlBSC/fYAKRLARZ1uSxij9BJ97PB2fg4buc=;
        b=Is2SiWI/qGmEYWnmpxvMIZy01yYXJl6W/+eHl5ji8ng4C0UiKvyuVxR9H1VLPUJe6r
         4Kep2G7KFOnJztzbo0Up+5QqnhNbQa2Acd5vedkRvvff/Cw//ymd6Mg1eZU1hLxNb2RF
         Yx+fonJ0/iwr0IAs1cH7AR6UFmijOMD64SAb8aKFz3SmzXQ5ta3yfF9KlW303DNjtBkn
         egPlP082mFHH68wfWWMT2HTswnHAItlF77hU3bgk0SmWhWC3oiUqlFpTkI10v8DYekL0
         LKHgqBPCrAgxvU4wvLrhHxqINpGOVmrc92rdRtfYabEgU2omkiMRRZUxzH01jMeInAXv
         FxVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0Flf9xflca0Tab/rIXZV0+xa39XyGb7quhuVhEdCfu5RI4/gb130R7T3SQvtNxjqbMDgsDF5fSLzqO/KlPwCFp5gVLhXVoCQoCoPS
X-Gm-Message-State: AOJu0YziP3X7GzG95VHsQDVIi7I0I5KY66Mh4KYbsrYBnoPw4OcJkzNh
	004nMJQUSBRCgEymdfXlnWJ8Y+gBlK2ZI+dGeP3vfngLC8MsxJ4qfV/qE9B3oim6tmQ25SHmmOA
	Wkj1uWrAlMUewQQ==
X-Google-Smtp-Source: AGHT+IGY135rOcGmNuA3jaXeb+vBROjCWlk+6yRzcegrd3BpG/SUap9iAg9KrrmEOxSrp+41hlvbyzovOg7VJTs=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:3814:0:b0:2d4:2b6a:bcd with SMTP id
 f20-20020a2e3814000000b002d42b6a0bcdmr10846lja.6.1712060250553; Tue, 02 Apr
 2024 05:17:30 -0700 (PDT)
Date: Tue, 02 Apr 2024 12:17:01 +0000
In-Reply-To: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4778; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=HqTvdg8fzcYf4HPXuYAv/EzwRzpXiMamY7vxsIqyqQI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmC/dJ7YNemYzY7yvbSfEA1iHpsFzU7rZlstsYb
 O9jWvygNSyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZgv3SQAKCRAEWL7uWMY5
 RhjvD/9y5D0AUnLuHOcIgpU790uliJQsxlpZJLrGzlPmYkLNNuCTCPmM5Oj7PsKZ1rPF2fXHpxH
 dEuiscwI6rhP7+TapPrgvNR9ACM7Liz9eyy/XrdZ1v+tHxjoOoNlfUHm++gw0Dfonrp/h7mYVPi
 4EJZlCiHjLWr8R+AIAhi7zUAx4MVm7l0ANjQp/7UbiQeBLHuDtVD/bwsXokLscxubGUYdw5rXe+
 blZu9Ue3m4ew7Mi6V4iEMMwtIpEEOGs+5LbJ+ii74ORiNJktmHpX6tUqeuMdgfXrukTLUed5A9F
 8FO1OTFJf9wWM1vDV4+a19o+e/JkQQkfPYg2jDjugaxKLROHdtgwY+pe2FoWLVVoTDy16KLsN3X
 iRAI3nlCQGMCRSTcTJ1dPftYGPR0g/b9Ln+UrGaYCo5rEaGC3KSB+ZCvqgBmT2DUe9Lya4DV2gE
 wRuAY8kOnoPbM5sNejk2Bk9nCoHjMtC0RcfMm8uUdWciD6zxKoGAprKnOq8GokXxpvPx4fYSuFA
 t7VdCQTNgef3cJadOmWGRi+kT1qCtQ4MWpZ51m8r6F45jbI4cesuQ1ASgql+55mgP1lCnTdyEX3
 X5/dvzc/jhYR1OoJauw9uyRkST6aONgOPDxW13pAQ8E8KbPvnRJQLH7gx04x8vHnnHDl0hSkUDB Sj4Fawr81lUDTlQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240402-linked-list-v1-4-b1c59ba7ae3b@google.com>
Subject: [PATCH 4/9] rust: list: add macro for implementing ListItem
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, 
	Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Adds a macro for safely implementing the ListItem trait. As part of the
implementation of the macro, we also provide a HasListLinks trait
similar to the workqueue's HasWorkItem trait.

The HasListLinks trait is only necessary if you are implementing
ListItem using the impl_list_item macro.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/list.rs                    |  3 ++
 rust/kernel/list/impl_list_item_mod.rs | 98 ++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index 76597c49fa56..7af5109500f2 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -8,6 +8,9 @@
 use crate::types::Opaque;
 use core::ptr;
 
+mod impl_list_item_mod;
+pub use self::impl_list_item_mod::{impl_has_list_links, impl_list_item, HasListLinks};
+
 mod arc;
 pub use self::arc::{
     impl_list_arc_safe, AtomicListArcTracker, ListArc, ListArcSafe, TryNewListArc,
diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
new file mode 100644
index 000000000000..9e2f6d6d4786
--- /dev/null
+++ b/rust/kernel/list/impl_list_item_mod.rs
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Helpers for implementing list traits safely.
+
+use crate::list::ListLinks;
+
+/// Declares that this type has a `ListLinks<ID>` field at a fixed offset.
+///
+/// This trait is only used to help implement `ListItem` safely. If `ListItem` is implemented
+/// manually, then this trait is not needed.
+///
+/// # Safety
+///
+/// All values of this type must have a `ListLinks<ID>` field at the given offset.
+pub unsafe trait HasListLinks<const ID: u64 = 0> {
+    /// The offset of the `ListLinks` field.
+    const OFFSET: usize;
+
+    /// Returns a pointer to the [`ListLinks<T, ID>`] field.
+    ///
+    /// # Safety
+    ///
+    /// The provided pointer must point at a valid struct of type `Self`.
+    ///
+    /// [`ListLinks<T, ID>`]: ListLinks
+    // We don't really need this method, but it's necessary for the implementation of
+    // `impl_has_work!` to be correct.
+    #[inline]
+    unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut ListLinks<ID> {
+        // SAFETY: The caller promises that the pointer is valid.
+        unsafe { (ptr as *mut u8).add(Self::OFFSET) as *mut ListLinks<ID> }
+    }
+}
+
+/// Implements the [`HasListLinks`] trait for the given type.
+#[macro_export]
+macro_rules! impl_has_list_links {
+    ($(impl$(<$($implarg:ident),*>)?
+       HasListLinks$(<$id:tt>)?
+       for $self:ident $(<$($selfarg:ty),*>)?
+       { self$(.$field:ident)* }
+    )*) => {$(
+        // SAFETY: The implementation of `raw_get_list_links` only compiles if the field has the
+        // right type.
+        unsafe impl$(<$($implarg),*>)? $crate::list::HasListLinks$(<$id>)? for
+            $self $(<$($selfarg),*>)?
+        {
+            const OFFSET: usize = ::core::mem::offset_of!(Self, $($field).*) as usize;
+
+            #[inline]
+            unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$id>)? {
+                // SAFETY: The caller promises that the pointer is not dangling.
+                unsafe {
+                    ::core::ptr::addr_of_mut!((*ptr)$(.$field)*)
+                }
+            }
+        }
+    )*};
+}
+pub use impl_has_list_links;
+
+/// Implements the [`ListItem`] trait for the given type.
+///
+/// Assumes that the type implements [`HasListLinks`].
+///
+/// [`ListItem`]: crate::list::ListItem
+#[macro_export]
+macro_rules! impl_list_item {
+    (
+        impl$({$($generics:tt)*})? ListItem<$num:tt> for $t:ty {
+            using ListLinks;
+        } $($rest:tt)*
+    ) => {
+        unsafe impl$(<$($generics)*>)? ListItem<$num> for $t {
+            unsafe fn view_links(me: *const Self) -> *mut ListLinks<$num> {
+                unsafe {
+                    <Self as HasListLinks<$num>>::raw_get_list_links(me.cast_mut())
+                }
+            }
+
+            unsafe fn view_value(me: *mut ListLinks<$num>) -> *const Self {
+                let offset = <Self as HasListLinks<$num>>::OFFSET;
+                unsafe { (me as *const u8).sub(offset) as *const Self }
+            }
+
+            unsafe fn prepare_to_insert(me: *const Self) -> *mut ListLinks<$num> {
+                unsafe { Self::view_links(me) }
+            }
+
+            unsafe fn post_remove(me: *mut ListLinks<$num>) -> *const Self {
+                unsafe { Self::view_value(me) }
+            }
+        }
+    };
+}
+pub use impl_list_item;

-- 
2.44.0.478.gd926399ef9-goog


