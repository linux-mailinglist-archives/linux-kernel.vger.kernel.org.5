Return-Path: <linux-kernel+bounces-150262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A4E8A9C6F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A77F1F23637
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D75816C847;
	Thu, 18 Apr 2024 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZbLHM7lM"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A6A165FDD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449749; cv=none; b=QYKqqRTgCYLg7ar0jcRsYGKpdE38v6j5V3EuonE6Tln/HGtWx1kGZuRsZYpqPcj6rQx9JNqH8Au1GmDcgyjpm4YjcPsrENHEltRPAX/7RXQxG/T1fPPyflWtXGVfbUJnKcHQYGNC969jR3lbceQ4v5WyNJn2pfhqx1qc2PjfwwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449749; c=relaxed/simple;
	bh=kJCtOlcfzg+uB/1UidTkdmnZFJUe6U3sgjxUQBxU0po=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gu8u7xsO+aeKb5DNbnT0BFn73CNQLV6fdMpyF4rN0eJK9HHIVca105cwaj1OaraXUrcsXOxGfPUl3NBJdpbHTcfTUKhcAQh5GYtyvcDALKXC6bz02CI0wiQw0z5ArSs7+XGNYn2vGH7R/Jjzx8pXeTtK6Io0ZZZ1ZxPh+BsMN34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZbLHM7lM; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6150e36ca0dso16719027b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713449746; x=1714054546; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hu+LfGtkbOjzs09VeFf/ruDPYvJAGLajKVasP3F8pQk=;
        b=ZbLHM7lMVo2Fs+WGBT3H5JiMDYJQ50PZ7PtPvuLy1GjsdLgxgCs4zp9dt1fL1PsuXd
         xI3DW3wGG+a4PxjyoNWrWe5H3XTVswhnvY/+OEWGj8vK2gwYdhoHyFcb4+NtTRbYM0s1
         +ZWPIYKrb05c3EDlMFLIz79f0kdc+J4XFlMianHcqUw6K1lFWsJ2iLVeRDjsbe+LNACn
         wO7x5996bJ8MiV94KsNqK1eOl1Bfx5lkY9nfoMyIT+qYs/FoPT06YEw06JoIzMC8QlCy
         uuXmvJEDMD/A2O1EY13Hrp8Vhw2aB8k9FgCgk6EKaPXO41P6d5VRizqGnoav1+TkDi1U
         dbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713449746; x=1714054546;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hu+LfGtkbOjzs09VeFf/ruDPYvJAGLajKVasP3F8pQk=;
        b=tezSW/vSA3vifqDfNhmNzBx51LE8Tk1sGn5Ux5wlexs93lBxU3Qo+U99pkXN4BbDP6
         lHMw/83y/OAsQF7lbqm5Ft+rTPFLkuNpEfdH+fqiFEdOe2bKDbE6uaSunbSKWqTwTDp/
         yJ0zqQY7lmj8V2l9R+J8WzGVF2D9uCNdktbU1alHe/r1IXmVpczR00Tcxzjhf1iAlXce
         g2MLRySML0SYNhpDxmmuoZVt+antRTBJJRW1Ad1c3VC3CS6E0o173RGT43ScnJyy2T2r
         8r0OIj5vfchGVZVJhKCV23SSpg6K90rCntRQiMVsw2AzQYQCO1JJxUgiq+IteGZDKUcU
         XEwg==
X-Forwarded-Encrypted: i=1; AJvYcCUXmxVPcjU5zQY4dHBDYSvi0xRf2jpmznmi4eRX4QNzs6RFuxw90rJOl6VOTHJvsZk5JAhaKak5ZBIghXxoQ7P7yatTJQorf5UYZwx/
X-Gm-Message-State: AOJu0YzuzpXcFv+5RKCnvVSxAt/uSuffvY8m4Bx/k/ig2O6X1QgrEi0z
	XvdeECR+CkvQ2SNe+Of+vXX2Db0kF9zdoZ2OqrIb//aTqzChV2LQ4iLYvadY5JgAyIK+921zHHN
	zhF8vGsuovSzow3nMuM+NPTPRMg==
X-Google-Smtp-Source: AGHT+IHkH7KTFtuaf8c6rczlLStQpQEMxJBHAycnEANyHKGoNLXUOprtYOl+EasiUtVVtW3/C4keT23FFJ5mZKq8c7o=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:6902:1205:b0:dc6:b813:5813 with
 SMTP id s5-20020a056902120500b00dc6b8135813mr215509ybu.9.1713449746304; Thu,
 18 Apr 2024 07:15:46 -0700 (PDT)
Date: Thu, 18 Apr 2024 14:15:41 +0000
In-Reply-To: <20240418-b4-rbtree-v3-0-323e134390ce@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418-b4-rbtree-v3-0-323e134390ce@google.com>
X-Mailer: b4 0.12.4
Message-ID: <20240418-b4-rbtree-v3-2-323e134390ce@google.com>
Subject: [PATCH v3 2/5] rust: rbtree: add `RBTreeIterator`
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

- Add Iterator implementation (`RBTreeIterator`) for `RBTree`, allowing
  iteration over (key, value) pairs in key order.
- Add individual `keys()` and `values()` functions to iterate over keys
  or values alone.
- Update doctests to use iteration instead of explicitly getting items.

Iteration is needed by the binder driver to enumerate all values in a
tree for oneway spam detection [1].

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-17-08ba9197f637@google.com/ [1]
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
---
 rust/kernel/rbtree.rs | 129 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 111 insertions(+), 18 deletions(-)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index ad406fc32d67..2f836be7bdbe 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -54,14 +54,30 @@ struct Node<K, V> {
 ///     assert_eq!(tree.get(&30).unwrap(), &300);
 /// }
 ///
+/// // Iterate over the nodes we just inserted.
+/// {
+///     let mut iter = tree.iter();
+///     assert_eq!(iter.next().unwrap(), (&10, &100));
+///     assert_eq!(iter.next().unwrap(), (&20, &200));
+///     assert_eq!(iter.next().unwrap(), (&30, &300));
+///     assert!(iter.next().is_none());
+/// }
+///
+/// // Print all elements.
+/// for (key, value) in &tree {
+///     pr_info!("{} = {}\n", key, value);
+/// }
+///
 /// // Replace one of the elements.
 /// tree.try_create_and_insert(10, 1000)?;
 ///
 /// // Check that the tree reflects the replacement.
 /// {
-///     assert_eq!(tree.get(&10).unwrap(), &1000);
-///     assert_eq!(tree.get(&20).unwrap(), &200);
-///     assert_eq!(tree.get(&30).unwrap(), &300);
+///     let mut iter = tree.iter();
+///     assert_eq!(iter.next().unwrap(), (&10, &1000));
+///     assert_eq!(iter.next().unwrap(), (&20, &200));
+///     assert_eq!(iter.next().unwrap(), (&30, &300));
+///     assert!(iter.next().is_none());
 /// }
 ///
 /// // Change the value of one of the elements.
@@ -69,9 +85,11 @@ struct Node<K, V> {
 ///
 /// // Check that the tree reflects the update.
 /// {
-///     assert_eq!(tree.get(&10).unwrap(), &1000);
-///     assert_eq!(tree.get(&20).unwrap(), &200);
-///     assert_eq!(tree.get(&30).unwrap(), &3000);
+///     let mut iter = tree.iter();
+///     assert_eq!(iter.next().unwrap(), (&10, &1000));
+///     assert_eq!(iter.next().unwrap(), (&20, &200));
+///     assert_eq!(iter.next().unwrap(), (&30, &3000));
+///     assert!(iter.next().is_none());
 /// }
 ///
 /// // Remove an element.
@@ -79,9 +97,10 @@ struct Node<K, V> {
 ///
 /// // Check that the tree reflects the removal.
 /// {
-///     assert_eq!(tree.get(&10), None);
-///     assert_eq!(tree.get(&20).unwrap(), &200);
-///     assert_eq!(tree.get(&30).unwrap(), &3000);
+///     let mut iter = tree.iter();
+///     assert_eq!(iter.next().unwrap(), (&20, &200));
+///     assert_eq!(iter.next().unwrap(), (&30, &3000));
+///     assert!(iter.next().is_none());
 /// }
 ///
 /// # Ok::<(), Error>(())
@@ -121,9 +140,11 @@ struct Node<K, V> {
 ///
 /// // Check the nodes we just inserted.
 /// {
-///     assert_eq!(tree.get(&10).unwrap(), &100);
-///     assert_eq!(tree.get(&20).unwrap(), &200);
-///     assert_eq!(tree.get(&30).unwrap(), &300);
+///     let mut iter = tree.iter();
+///     assert_eq!(iter.next().unwrap(), (&10, &100));
+///     assert_eq!(iter.next().unwrap(), (&20, &200));
+///     assert_eq!(iter.next().unwrap(), (&30, &300));
+///     assert!(iter.next().is_none());
 /// }
 ///
 /// // Remove a node, getting back ownership of it.
@@ -131,9 +152,10 @@ struct Node<K, V> {
 ///
 /// // Check that the tree reflects the removal.
 /// {
-///     assert_eq!(tree.get(&10).unwrap(), &100);
-///     assert_eq!(tree.get(&20).unwrap(), &200);
-///     assert_eq!(tree.get(&30), None);
+///     let mut iter = tree.iter();
+///     assert_eq!(iter.next().unwrap(), (&10, &100));
+///     assert_eq!(iter.next().unwrap(), (&20, &200));
+///     assert!(iter.next().is_none());
 /// }
 ///
 /// // Create a preallocated reservation that we can re-use later.
@@ -145,9 +167,11 @@ struct Node<K, V> {
 ///
 /// // Check that the tree reflect the new insertion.
 /// {
-///     assert_eq!(tree.get(&10).unwrap(), &100);
-///     assert_eq!(tree.get(&15).unwrap(), &150);
-///     assert_eq!(tree.get(&20).unwrap(), &200);
+///     let mut iter = tree.iter();
+///     assert_eq!(iter.next().unwrap(), (&10, &100));
+///     assert_eq!(iter.next().unwrap(), (&15, &150));
+///     assert_eq!(iter.next().unwrap(), (&20, &200));
+///     assert!(iter.next().is_none());
 /// }
 ///
 /// # Ok::<(), Error>(())
@@ -188,6 +212,25 @@ pub fn try_reserve_node() -> Result<RBTreeNodeReservation<K, V>> {
     pub fn try_allocate_node(key: K, value: V) -> Result<RBTreeNode<K, V>> {
         Ok(Self::try_reserve_node()?.into_node(key, value))
     }
+
+    /// Returns an iterator over the tree nodes, sorted by key.
+    pub fn iter(&self) -> RBTreeIterator<'_, K, V> {
+        RBTreeIterator {
+            _tree: PhantomData,
+            // SAFETY: `root` is valid as it's embedded in `self` and we have a valid `self`.
+            next: unsafe { bindings::rb_first(&self.root) },
+        }
+    }
+
+    /// Returns an iterator over the keys of the nodes in the tree, in sorted order.
+    pub fn keys(&self) -> impl Iterator<Item = &'_ K> {
+        self.iter().map(|(k, _)| k)
+    }
+
+    /// Returns an iterator over the values of the nodes in the tree, sorted by key.
+    pub fn values(&self) -> impl Iterator<Item = &'_ V> {
+        self.iter().map(|(_, v)| v)
+    }
 }
 
 impl<K, V> RBTree<K, V>
@@ -373,6 +416,56 @@ fn drop(&mut self) {
     }
 }
 
+impl<'a, K, V> IntoIterator for &'a RBTree<K, V> {
+    type Item = (&'a K, &'a V);
+    type IntoIter = RBTreeIterator<'a, K, V>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter()
+    }
+}
+
+/// An iterator over the nodes of a [`RBTree`].
+///
+/// Instances are created by calling [`RBTree::iter`].
+///
+/// # Invariants
+/// - `self.next` is a valid pointer.
+/// - `self.next` points to a node stored inside of a valid `RBTree`.
+pub struct RBTreeIterator<'a, K, V> {
+    _tree: PhantomData<&'a RBTree<K, V>>,
+    next: *mut bindings::rb_node,
+}
+
+// SAFETY: The [`RBTreeIterator`] gives out immutable references to K and V, so it has the same
+// thread safety requirements as immutable references.
+unsafe impl<'a, K: Sync, V: Sync> Send for RBTreeIterator<'a, K, V> {}
+
+// SAFETY: The [`RBTreeIterator`] gives out immutable references to K and V, so it has the same
+// thread safety requirements as immutable references.
+unsafe impl<'a, K: Sync, V: Sync> Sync for RBTreeIterator<'a, K, V> {}
+
+impl<'a, K, V> Iterator for RBTreeIterator<'a, K, V> {
+    type Item = (&'a K, &'a V);
+
+    fn next(&mut self) -> Option<Self::Item> {
+        if self.next.is_null() {
+            return None;
+        }
+
+        // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
+        // point to the links field of `Node<K, V>` objects.
+        let cur = unsafe { container_of!(self.next, Node<K, V>, links) };
+
+        // SAFETY: `self.next` is a valid tree node by the type invariants.
+        self.next = unsafe { bindings::rb_next(self.next) };
+
+        // SAFETY: By the same reasoning above, it is safe to dereference the node. Additionally,
+        // it is ok to return a reference to members because the iterator must outlive it.
+        Some(unsafe { (&(*cur).key, &(*cur).value) })
+    }
+}
+
 /// A memory reservation for a red-black tree node.
 ///
 /// It contains the memory needed to hold a node that can be inserted into a red-black tree. One

-- 
2.44.0.769.g3c40516874-goog


