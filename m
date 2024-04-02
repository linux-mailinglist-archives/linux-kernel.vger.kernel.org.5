Return-Path: <linux-kernel+bounces-127920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EB78952C4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5032E2820A3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A2C84A57;
	Tue,  2 Apr 2024 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WOn/ak45"
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C94A84037
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060259; cv=none; b=I2DxLaezplxtaAsWuju6Emz5WTJ4hSRuqjXzCMRCbUfkEdtyskYcgfnhh6xWyuCZEv9vVTI9njbDTb/EugFEIq7HLoCCypUP6h1/rbTkStV87ELBeVNex+yI8x4qNtLz8+8XPa6DMiEwXGTw4C4tDsjJfA52/IwRw/JX9oNqYpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060259; c=relaxed/simple;
	bh=tl0YF8G31hlpsx1yxv+0P/semrPgJkUCNi2Z3V8+6S4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IvZzgSVqZFZcJPVXI82QLNHToKeYgsk5P2EbkM1UZlVqYQYU/8c2osRdy/OS9/ixediowK60lyOUxGcRjd29EzpiDEEL/XqUuv3HrobdHaeJGkR+BZPBpNxSB1Vnl3Vrgcx6InAo/l48gBHo00wpFdANimesXW8RknUbE97/7FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WOn/ak45; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2d499513d62so43179791fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712060256; x=1712665056; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OHvJpyspEd5owonTerg9v2PB8rekG9Ag8roT35f7WSw=;
        b=WOn/ak45lBzd/cHmYziJ/GOz5+h6w1CFbWVfNMfMV2z97KS3pllw4K06tCmA5exlEI
         UR2l2IloYZ/Tg4YIuLsP5XXfqgtsXLm51gyJvp48wAJOUa1Ia5/mVKKG8NmA9eQ5R7sq
         xtOCYbnTrjFmLfQ2CDHHl8GhPxq6FAOMuKfXOtE1HK5xhvUdLkAuT8VIrtWx4JChaNJs
         XpmI2oOwOIVWYz+zqMmZnbq6LbWNhdBn1kdbyRfNj4IcNf9aILXrY1zjqJqazrsDjvG8
         9eJOiDuN3QOfrNtP7XvSlJhprM+J75XYmT2dKvN5NslMGiGEBAG5aKrl5TXk5JCt3Nge
         gxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712060256; x=1712665056;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHvJpyspEd5owonTerg9v2PB8rekG9Ag8roT35f7WSw=;
        b=oDf41KESSsRyvZBgmiYCpENlL4GL102Ol8rdtHXdWNt8DyfxHto7CJVKEbYQoY2Di8
         MdaqkZKnjtjH6aeCfjA3z0uwp8+28WWsk5JyzvBhLdjYGtiYwNkv2pl61RNf+uWfiJZr
         RZMG0GVYKfSP6bYu/Nq7Y1LWGRwWIP029xGvx/9nLuc8+6aVpXXd9/2y1OVY2VHboG8G
         DADE2RCFclvHnzKO8CFiPG9jVLh3OSoSeRdyU4O8PxVJuf9Fj4f+rMwX84/H8vvpWIWn
         Bw+/e2hmmhvYd0XZKavOFbVnVBvjLNmmWwcyljz33R0zfASekmzd4gMYfMA4Shgezv3w
         8tnA==
X-Forwarded-Encrypted: i=1; AJvYcCUJQFo9PQaYizV8gqcmidepC49MII8wxxnKv63hCspXfp7V/REh3jXVIMxx4uhc5pxWnDco7Pl6mL64uToNuvldtg8NfyW5U5aJCY7P
X-Gm-Message-State: AOJu0Yxo5FomkpdHvnuC37U1dTstzfKvTpRW3MY4pivHgqizXBK3mTCc
	VMwM9wN57qnneMa90xAdFmsf6AJ/gF4cb0uxvDpZATg81ToiDDUpef9oFfJPAbek87XBdGyIlIb
	OZ4tQpoX+ncLvxA==
X-Google-Smtp-Source: AGHT+IHQcweqPWnQDgxPlcTnQ03DbxUqb6QIzmGBYSz4zzRinM+vysej/8JddXLZidGUm8vCJq4wLA/avKwfIVw=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:b24f:0:b0:2d6:87ab:255d with SMTP id
 n15-20020a2eb24f000000b002d687ab255dmr11456ljm.3.1712060256408; Tue, 02 Apr
 2024 05:17:36 -0700 (PDT)
Date: Tue, 02 Apr 2024 12:17:03 +0000
In-Reply-To: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4960; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=tl0YF8G31hlpsx1yxv+0P/semrPgJkUCNi2Z3V8+6S4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmC/dKo5hvnIsyLPwPScT3d6UA+GaTaJPrAEJfb
 APdtc+EVZqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZgv3SgAKCRAEWL7uWMY5
 RtfXEACBrJXrx04vXmhwnOrt0jVRgCF7XbBsJXFj1oR0C/pOlQUV1z7UI/ucnWLz2HKH2mKDpVm
 9BXP6pisrxMfn+FjBnQ+y5Bau5Mn4SiRPNYVM9RW2wklu089c/9o6ikD9a3I8f1AS4D0uHk7FF7
 p43TxR4SJ3idVH0G2v9FZxZabL4TD4bzJ7GbWRmdnBNfn3LagCsbl2UPxqYEvaEt0y4U4m0/3+2
 yFQF1beR4eFMM4ezmH5g370N0oJ3WaEzccjKcSuML0e1+GJ4EhXBI8EpgH3OX+E0sO1DvM3TEoL
 5xaIbCklcq8gvmEKiv7vQJymwGhy9btsHD9ajUK5l9fnI/ka4IYLc0TbKiRIvnX+trNwW4OdShT
 5+uMj8mlJbvjXqaXEsiuEHjxqkJ61EkDTtkIycMxoa40vbs8SgyePX8rMCabw/xyXiAHKTV78kp
 QTCC9RgqEY47J77w7bUazzGzzqSoLF+8XyaoozaGcy0CA7jTnoAclkX6PWCUna4FcaZ7m+YuJrz
 v0tCJtedgslQZwqSw5TdX3iBPZ1XX0K8xzYEp0nd9nT0AC/1ix6kKYPMNG8cNYESC1ovZlLDAoc
 8H+0U1ZEeOVN/V+D+1klgmB9rdEV7ndcmOKTUGkqBEvDG5mvpkEterS1kNA5MJavzOBDDEOS7HE 7XG9bA/utGTRkTw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240402-linked-list-v1-6-b1c59ba7ae3b@google.com>
Subject: [PATCH 6/9] rust: list: add iterators
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

Rust Binder has lists containing stuff such as all contexts or all
processes, and sometimes need to iterate over them. This patch enables
Rust Binder to do that using a normal for loop.

The iterator returns the ArcBorrow type, so it is possible to grab a
refcount to values while iterating.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/list.rs | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index 7e9ed802b26b..892705dd0571 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -5,7 +5,9 @@
 //! A linked list implementation.
 
 use crate::init::PinInit;
+use crate::sync::ArcBorrow;
 use crate::types::Opaque;
+use core::iter::{DoubleEndedIterator, FusedIterator};
 use core::marker::PhantomData;
 use core::ptr;
 
@@ -405,6 +407,17 @@ pub fn push_all_back(&mut self, other: &mut List<T, ID>) {
         // INVARIANT: The other list is now empty, so update its pointer.
         other.first = ptr::null_mut();
     }
+
+    /// Creates an iterator over the list.
+    pub fn iter(&self) -> Iter<'_, T, ID> {
+        // INVARIANT: If the list is empty, both pointers are null. Otherwise, both pointers point
+        // at the first element of the same list.
+        Iter {
+            current: self.first,
+            stop: self.first,
+            _ty: PhantomData,
+        }
+    }
 }
 
 impl<T: ?Sized + ListItem<ID>, const ID: u64> Drop for List<T, ID> {
@@ -414,3 +427,92 @@ fn drop(&mut self) {
         }
     }
 }
+
+/// An iterator into a [`List`].
+///
+/// # Invariants
+///
+/// The `current` pointer points at a value in a list, or it is null if the iterator has reached
+/// the end of the list. The `stop` pointer points at the first value in the same list, or it is
+/// null if the list is empty.
+#[derive(Clone)]
+pub struct Iter<'a, T: ?Sized + ListItem<ID>, const ID: u64 = 0> {
+    current: *mut ListLinksFields,
+    stop: *mut ListLinksFields,
+    _ty: PhantomData<&'a ListArc<T, ID>>,
+}
+
+impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> Iterator for Iter<'a, T, ID> {
+    type Item = ArcBorrow<'a, T>;
+
+    fn next(&mut self) -> Option<ArcBorrow<'a, T>> {
+        if self.current.is_null() {
+            return None;
+        }
+
+        let current = self.current;
+
+        // SAFETY: We just checked that `current` is not null, so it is in a list, and hence not
+        // dangling. There's no race because the iterator holds an immutable borrow to the list.
+        let next = unsafe { (*current).next };
+        // INVARIANT: If `current` was the last element of the list, then this updates it to null.
+        // Otherwise, we update it to the next element.
+        self.current = if next != self.stop {
+            next
+        } else {
+            ptr::null_mut()
+        };
+
+        // SAFETY: The `current` pointer points a value in the list.
+        let item = unsafe { T::view_value(ListLinks::from_fields(current)) };
+        // SAFETY:
+        // * All values in a list are stored in an `Arc`.
+        // * The value cannot be removed from the list for the duration of the lifetime annotated
+        //   on the returned `ArcBorrow`, because removing it from the list would require mutable
+        //   access to the list. However, the `ArcBorrow` is annotated with the iterator's
+        //   lifetime, and the list is immutably borrowed for that lifetime.
+        // * Values in a list never have a `UniqueArc` reference.
+        Some(unsafe { ArcBorrow::from_raw(item) })
+    }
+}
+
+impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> FusedIterator for Iter<'a, T, ID> {}
+
+impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> IntoIterator for &'a List<T, ID> {
+    type IntoIter = Iter<'a, T, ID>;
+    type Item = ArcBorrow<'a, T>;
+
+    fn into_iter(self) -> Iter<'a, T, ID> {
+        self.iter()
+    }
+}
+
+/// An owning iterator into a [`List`].
+pub struct IntoIter<T: ?Sized + ListItem<ID>, const ID: u64 = 0> {
+    list: List<T, ID>,
+}
+
+impl<T: ?Sized + ListItem<ID>, const ID: u64> Iterator for IntoIter<T, ID> {
+    type Item = ListArc<T, ID>;
+
+    fn next(&mut self) -> Option<ListArc<T, ID>> {
+        self.list.pop_front()
+    }
+}
+
+impl<T: ?Sized + ListItem<ID>, const ID: u64> FusedIterator for IntoIter<T, ID> {}
+
+impl<T: ?Sized + ListItem<ID>, const ID: u64> DoubleEndedIterator for IntoIter<T, ID> {
+    fn next_back(&mut self) -> Option<ListArc<T, ID>> {
+        self.list.pop_back()
+    }
+}
+
+impl<T: ?Sized + ListItem<ID>, const ID: u64> IntoIterator for List<T, ID> {
+    type IntoIter = IntoIter<T, ID>;
+    type Item = ListArc<T, ID>;
+
+    fn into_iter(self) -> IntoIter<T, ID> {
+        IntoIter { list: self }
+    }
+}

-- 
2.44.0.478.gd926399ef9-goog


