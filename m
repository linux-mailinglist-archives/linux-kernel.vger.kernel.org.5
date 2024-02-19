Return-Path: <linux-kernel+bounces-71244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C947285A26C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F68A285A48
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA842E84F;
	Mon, 19 Feb 2024 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cvsqMMEk"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A651B2E400
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343321; cv=none; b=EdKh5dJqgiQde4JbTXmtiuXPpl+oeFuFg77TfYRBaqH0VthO5wjnJgP5s4TvvZ9Aj5HsEVhcT1VPTJGF8Ql7LxV1mc0oCfpn8H41EuZLykcWNljE+6gdPZ1utKZuXRMT/ZQ0LZvRHQjd0K6a1dHI4FFIrX4NhercrB9JCXDUKZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343321; c=relaxed/simple;
	bh=qAEzaqvyHsbGb2Xo/aEXETVIQv22OgH/DTmjxPoN4uE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K9cIpZhNDcHE0JmqHIdIKeGx5wwdpqrHSPMYuLwBzdUuCyBGLk2PkXn+X1U3FIwTsMKcedb8RLp47Is867Euz/dbyBQminvvDJWIYB4HSx2jg2A976EvxqaIvSsQtM+idTmpRpSUE1AOAtgXWXF8R8NFo+51OsDSZdjyH0tjv2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cvsqMMEk; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so5875289276.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708343318; x=1708948118; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HB90XMvSMsoYLDGPsOGvbe6aP04mVYyG6I4g2jRdUgY=;
        b=cvsqMMEkSny5JvAufSXCKUJlYIq1T5Ws/TjioMMB2SznFA0czONrYEdwxesebqW4NS
         hAZsKCOBALhH37zQ/wYegZxpDmTWV+ybbF2WvyfrsOT4Z0AoVkNySwdeeaDUFtTTm5DL
         31OlNLFshvgKUQ9pRZuTc+RGiJsb09zV+5Tq3NGqCZklN5yd6sk+9vCrKAKQ2+wCYsbB
         qwBQvLknQra+q/Q2ZqUXzRCQTuEYlcU5UAzS4NSitVkpTuEeMLkykwpLAk088a7yZ31t
         t5uUZmHJ2n8vrjmaEu12y6FZAWxEf6OYZjb1JT6vXTuBCrfDVm2jEb1oAm7gXTwQqt9W
         KJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708343318; x=1708948118;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HB90XMvSMsoYLDGPsOGvbe6aP04mVYyG6I4g2jRdUgY=;
        b=Uq7khSdT/RW2hXPT8SiedUnWgfI/BfFqjykWtsSZ1upm2pDKEvSvCxdNGZ0jhzBxRN
         CivwICriG6P2fwtrGQ3m3tgjdQqjxRdzembnmp4GWdJX+fHbTQGzXr9DH0CjyHPIqhoB
         PZ8W+/w8Hwdwb3rXbYygSp9sVKjU5FrKUE3aVVRRXN9sOFCXusH12zVR4Jne0i9MUQz3
         HvkT62S5WKksMi9+L7nigQTa2VQjkzB+Xmp1cRBOxfPS5FL+aG1IW/HnEcYIBeqUkdNw
         6ITWljCX97Wv98uANEdhDw7gtEarI9V1rxR3kIHpvVRv4EI6HMUUrcEymZu0AK2zp3/F
         ZLqg==
X-Forwarded-Encrypted: i=1; AJvYcCUOfg1lnbPQAjuPg7PmBOiQyE6FVxrp4HDCtM32HXYVf95U0LqEPwxwXQErQmRhAfpMB3pDPgtw9YiQoysNoLMmOrb2e8W6tMFgYXK/
X-Gm-Message-State: AOJu0Yy6IY+O3lnRvSpE1baPZpiAhVAXz3i0cGX5E3S8d57qo7OPcyLU
	wqpGIDIHiTJ5wHfDMk9pdpBW9wH/vygErS+kUnkBzYslP45EhjZ6RljHBdQx9uJJYxE7hVZQNx+
	jix4cNQ7MtCEFrceoMMWCYWWy8g==
X-Google-Smtp-Source: AGHT+IFtBFskYTePePimnTBWUC32nwSU5YwRcSrVXh0i8G897LwT25jh6pyp+pZD/n4BlBjHXmLX05XSVQ2guApoZ4A=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:6902:1001:b0:dcc:79ab:e522 with
 SMTP id w1-20020a056902100100b00dcc79abe522mr480849ybt.11.1708343318765; Mon,
 19 Feb 2024 03:48:38 -0800 (PST)
Date: Mon, 19 Feb 2024 11:48:11 +0000
In-Reply-To: <20240219-b4-rbtree-v2-0-0b113aab330d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219-b4-rbtree-v2-0-0b113aab330d@google.com>
X-Mailer: b4 0.12.4
Message-ID: <20240219-b4-rbtree-v2-4-0b113aab330d@google.com>
Subject: [PATCH v2 4/6] rust: rbtree: add `RBTreeIteratorMut`
From: Matt Gilbride <mattgilbride@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>
Cc: Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, 
	Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Gilbride <mattgilbride@google.com>
Content-Type: text/plain; charset="utf-8"

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Add mutable Iterator implementation (`RBTreeIteratorMut`) for `RBTree`,
allowing iteration over (key, value) pairs in key order. Only values are
mutable, as mutating keys implies modifying a node's position in the tree.

Mutable iteration is used by the binder driver during shutdown to
clean up the tree maintained by the "range allocator" [1].

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-6-08ba9197f637@google.com/ [1]
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/rbtree.rs | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index b1faac831cfc..ccf74e0dc3ec 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -222,6 +222,15 @@ pub fn iter(&self) -> RBTreeIterator<'_, K, V> {
         }
     }
 
+    /// Returns a mutable iterator over the tree nodes, sorted by key.
+    pub fn iter_mut(&mut self) -> RBTreeIteratorMut<'_, K, V> {
+        RBTreeIteratorMut {
+            _tree: PhantomData,
+            // SAFETY: `root` is valid as it's embedded in `self` and we have a valid `self`.
+            next: unsafe { bindings::rb_first(&self.root) },
+        }
+    }
+
     /// Returns an iterator over the keys of the nodes in the tree, in sorted order.
     pub fn keys(&self) -> impl Iterator<Item = &'_ K> {
         self.iter().map(|(k, _)| k)
@@ -231,6 +240,11 @@ pub fn keys(&self) -> impl Iterator<Item = &'_ K> {
     pub fn values(&self) -> impl Iterator<Item = &'_ V> {
         self.iter().map(|(_, v)| v)
     }
+
+    /// Returns a mutable iterator over the values of the nodes in the tree, sorted by key.
+    pub fn values_mut(&mut self) -> impl Iterator<Item = &'_ mut V> {
+        self.iter_mut().map(|(_, v)| v)
+    }
 }
 
 impl<K, V> RBTree<K, V>
@@ -439,6 +453,53 @@ fn next(&mut self) -> Option<Self::Item> {
     }
 }
 
+impl<'a, K, V> IntoIterator for &'a mut RBTree<K, V> {
+    type Item = (&'a K, &'a mut V);
+    type IntoIter = RBTreeIteratorMut<'a, K, V>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter_mut()
+    }
+}
+
+/// A mutable iterator over the nodes of a [`RBTree`].
+///
+/// Instances are created by calling [`RBTree::iter_mut`].
+pub struct RBTreeIteratorMut<'a, K, V> {
+    _tree: PhantomData<&'a RBTree<K, V>>,
+    next: *mut bindings::rb_node,
+}
+
+// SAFETY: An [`RBTree`] allows the same kinds of access to its values that a struct allows to its
+// fields, so we use the same Send condition as would be used for a struct with K and V fields.
+unsafe impl<'a, K: Send, V: Send> Send for RBTreeIteratorMut<'a, K, V> {}
+
+// SAFETY: An [`RBTree`] allows the same kinds of access to its values that a struct allows to its
+// fields, so we use the same Sync condition as would be used for a struct with K and V fields.
+unsafe impl<'a, K: Sync, V: Sync> Sync for RBTreeIteratorMut<'a, K, V> {}
+
+impl<'a, K, V> Iterator for RBTreeIteratorMut<'a, K, V> {
+    type Item = (&'a K, &'a mut V);
+
+    fn next(&mut self) -> Option<Self::Item> {
+        if self.next.is_null() {
+            return None;
+        }
+
+        // SAFETY: All links fields we create are in a `Node<K, V>`.
+        let cur = unsafe { crate::container_of!(self.next, Node<K, V>, links) }.cast_mut();
+
+        // SAFETY: The reference to the tree used to create the iterator outlives the iterator, so
+        // the tree cannot change (except for the value of previous nodes, but those don't affect
+        // the iteration process). By the tree invariant, all nodes are valid.
+        self.next = unsafe { bindings::rb_next(self.next) };
+
+        // SAFETY: By the same reasoning above, it is safe to dereference the node. Additionally,
+        // it is ok to return a reference to members because the iterator must outlive it.
+        Some(unsafe { (&(*cur).key, &mut (*cur).value) })
+    }
+}
+
 /// A memory reservation for a red-black tree node.
 ///
 /// It contains the memory needed to hold a node that can be inserted into a red-black tree. One

-- 
2.44.0.rc0.258.g7320e95886-goog


