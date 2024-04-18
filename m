Return-Path: <linux-kernel+bounces-150265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 130C68A9C84
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36AD01C23CFE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE3E16D335;
	Thu, 18 Apr 2024 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LnT9tITS"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDBD165FD8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449756; cv=none; b=ZkWCCF3vVrdLoym7vuMYS1yKTwjKyD1GsrNrPgr31hUaPlLcnY7F1UMr2+mAlWOke1664nvdJD0pvmuzZAsJWhed4Bhgu2palgu/cIPGOKejSxMi/7AkkcafOQMnCqOA7QT8+NR4rM5tt1+iV+hafwSXD9Xgam/4H8aVKOlBVGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449756; c=relaxed/simple;
	bh=FBCNdiEj+A0D8yYINrDwvCTiCL63Jq+X5eZW2pO7mtw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tgAzWpGcpHIz8MDgXkKODs4xUPJ0ZNuWr4PpYywgASPsbvpR3DLwkC9vixFslIbICGeyi2htHPqbVfGXXXyKJZ1H0aObFQ0CVkoKloGu/m5tPxo9GmFBuYiNe9isHPfyeCqItMNFAoqJKNYHwNasFvNxzViCMqX6pkKH00iyAf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LnT9tITS; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de45d510553so1667790276.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713449750; x=1714054550; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FM4hEqePImh5iV5+3UJD4A4a8jKpvu1mGuCtm7zmIag=;
        b=LnT9tITShwJFkEO2dxuLLiQEHtoz1pmeDMIb7eXwfMq4zksnNyv7G4UIbp3iGpDEJc
         +S6jdQjebywr9mP0S07zFhozcEwJ8CSWTJPYZN4B/qeTUIYmaOa5biUhTxFD0S83aWfc
         Im/jFVheuvbdBFfcCTPvuqY2a09SXDgeT0R9bBDCrQtyOrUx8v+um+sP2hM2fuAQTP0N
         iW0dfwhEQMhNuZI7Sw9aFdepMgCSVHEA10Hs9VQIwY5YCx0ZrPWsHwAsbwTWbrqvyEsd
         X+U9fDFsyuiskfMVYAKT0Hkxu1j4ebZnzho8JUZfj35g0Zqb46hzz6DoSVQZVfrk5LJp
         kYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713449750; x=1714054550;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FM4hEqePImh5iV5+3UJD4A4a8jKpvu1mGuCtm7zmIag=;
        b=AAHUBUKqtXvE86peCnRqm1ii1nEVyZKohuzUBH2SRDxJIpK8TLFXYhiAxrS2vJQnhG
         j7gaUQa3ViPiT6T5Lq5VainiZnrCT6z4+1qHhD3gvUoUlbPJ2nK+z5090CUMRXvc9GnA
         Ik3kVMH1dW8t5O9GVNUniWVqt81x9VOAuThclkgvXmXXqLZqcexWyL+9fUA4MPg4qNtV
         +1KOmVHVdR4d4W6Z2PWVdsNcHH383LImZflNb5r/HeSAfFQw1ZP2XELqyGvHs8mPSki6
         6KxNW4kuz+AUWkcHQ3GNnkthJlEvZpS6IKrGSfbcBgisDUI9uAgVL5e6BfQ+oDJ0rkI9
         cz2g==
X-Forwarded-Encrypted: i=1; AJvYcCXDg3ufDByb/d9tQ9YZFoAX4gyF/+PmjTII6o/mhM6L9cV3u1/22LVPL5JFPZMrTD6hdXSljPYB7lo1aTc0+TP3AcUSb/2t1hGPiNNm
X-Gm-Message-State: AOJu0YwORlhcqcEi+4HcSVdJm9XPhh7MgkvAVw5iumT5a3PBN7XDnMyg
	YljAaNPvk3NSK4DnVGuonIam1ADkHO9VUQ3sMVV8VdpzIsqj5MX+c9ids3ZvKmcY8+fJFweZagr
	o+TiIb2OCqhFFBrjHlLSgc/EuLA==
X-Google-Smtp-Source: AGHT+IFe6MeLS1rzJNaDGGx9bsvL4OmC15Tor/40iy+NTfO4lsvrfVReZJ36PTq7b1UbbuIegylbksvu2JcrctxTKZ8=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:6902:1005:b0:dcb:fb69:eadc with
 SMTP id w5-20020a056902100500b00dcbfb69eadcmr291683ybt.6.1713449750611; Thu,
 18 Apr 2024 07:15:50 -0700 (PDT)
Date: Thu, 18 Apr 2024 14:15:44 +0000
In-Reply-To: <20240418-b4-rbtree-v3-0-323e134390ce@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418-b4-rbtree-v3-0-323e134390ce@google.com>
X-Mailer: b4 0.12.4
Message-ID: <20240418-b4-rbtree-v3-5-323e134390ce@google.com>
Subject: [PATCH v3 5/5] rust: rbtree: add `RBTree::entry`
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

From: Alice Ryhl <aliceryhl@google.com>

This mirrors the entry API [1] from the Rust standard library on
`RBTree`. This API can be used to access the entry at a specific key and
make modifications depending on whether the key is vacant or occupied.
This API is useful because it can often be used to avoid traversing the
tree multiple times.

This is used by binder to look up and conditionally access or insert a
value, depending on whether it is there or not [2].

Link: https://doc.rust-lang.org/stable/std/collections/btree_map/enum.Entry.html [1]
Link: https://android-review.googlesource.com/c/kernel/common/+/2849906 [2]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
---
 rust/kernel/rbtree.rs | 304 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 229 insertions(+), 75 deletions(-)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index 606ff2f8c8de..c9bdbc5fd509 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -309,12 +309,18 @@ pub fn try_create_and_insert(&mut self, key: K, value: V) -> Result<Option<RBTre
     /// key/value pair). Returns [`None`] if a node with the same key didn't already exist.
     ///
     /// This function always succeeds.
-    pub fn insert(&mut self, RBTreeNode { node }: RBTreeNode<K, V>) -> Option<RBTreeNode<K, V>> {
-        let node = Box::into_raw(node);
-        // SAFETY: `node` is valid at least until we call `Box::from_raw`, which only happens when
-        // the node is removed or replaced.
-        let node_links = unsafe { addr_of_mut!((*node).links) };
+    pub fn insert(&mut self, node: RBTreeNode<K, V>) -> Option<RBTreeNode<K, V>> {
+        match self.raw_entry(&node.node.key) {
+            RawEntry::Occupied(entry) => Some(entry.replace(node)),
+            RawEntry::Vacant(entry) => {
+                entry.insert(node);
+                None
+            }
+        }
+    }
 
+    fn raw_entry(&mut self, key: &K) -> RawEntry<'_, K, V> {
+        // The returned `RawEntry` is used to call either `rb_link_node` or `rb_replace_node`.
         // The parameters of `rb_link_node` are as follows:
         // - `node`: A pointer to an uninitialized node being inserted.
         // - `parent`: A pointer to an existing node in the tree. One of its child pointers must be
@@ -332,63 +338,54 @@ pub fn insert(&mut self, RBTreeNode { node }: RBTreeNode<K, V>) -> Option<RBTree
         // we store `parent` and `child_field_of_parent`, and the new `node` will go somewhere
         // in the subtree of `parent` that `child_field_of_parent` points at. Once
         // we find an empty subtree, we can insert the new node using `rb_link_node`.
-        let mut parent = core::ptr::null_mut();
         let mut child_field_of_parent: &mut *mut bindings::rb_node = &mut self.root.rb_node;
-        while !child_field_of_parent.is_null() {
-            parent = *child_field_of_parent;
+        let mut parent = core::ptr::null_mut();
+        while !(*child_field_of_parent).is_null() {
+            let curr = *child_field_of_parent;
+            // SAFETY: All links fields we create are in a `Node<K, V>`.
+            let node = unsafe { container_of!(curr, Node<K, V>, links) };
 
-            // We need to determine whether `node` should be the left or right child of `parent`,
-            // so we will compare with the `key` field of `parent` a.k.a. `this` below.
-            //
-            // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
-            // point to the links field of `Node<K, V>` objects.
-            let this = unsafe { container_of!(parent, Node<K, V>, links) };
-
-            // SAFETY: `this` is a non-null node so it is valid by the type invariants. `node` is
-            // valid until the node is removed.
-            match unsafe { (*node).key.cmp(&(*this).key) } {
-                // We would like `node` to be the left child of `parent`.  Move to this child to check
-                // whether we can use it, or continue searching, at the next iteration.
-                //
-                // SAFETY: `parent` is a non-null node so it is valid by the type invariants.
-                Ordering::Less => child_field_of_parent = unsafe { &mut (*parent).rb_left },
-                // We would like `node` to be the right child of `parent`.  Move to this child to check
-                // whether we can use it, or continue searching, at the next iteration.
-                //
-                // SAFETY: `parent` is a non-null node so it is valid by the type invariants.
-                Ordering::Greater => child_field_of_parent = unsafe { &mut (*parent).rb_right },
+            // SAFETY: `node` is a non-null node so it is valid by the type invariants.
+            match key.cmp(unsafe { &(*node).key }) {
+                // SAFETY: `curr` is a non-null node so it is valid by the type invariants.
+                Ordering::Less => child_field_of_parent = unsafe { &mut (*curr).rb_left },
+                // SAFETY: `curr` is a non-null node so it is valid by the type invariants.
+                Ordering::Greater => child_field_of_parent = unsafe { &mut (*curr).rb_right },
                 Ordering::Equal => {
-                    // There is an existing node in the tree with this key, and that node is
-                    // parent.  Thus, we are replacing parent with a new node.
-                    //
-                    // INVARIANT: We are replacing an existing node with a new one, which is valid.
-                    // It remains valid because we "forgot" it with `Box::into_raw`.
-                    // SAFETY: All pointers are non-null and valid.
-                    unsafe { bindings::rb_replace_node(parent, node_links, &mut self.root) };
-
-                    // INVARIANT: The node is being returned and the caller may free it, however,
-                    // it was removed from the tree. So the invariants still hold.
-                    return Some(RBTreeNode {
-                        // SAFETY: `this` was a node in the tree, so it is valid.
-                        node: unsafe { Box::from_raw(this.cast_mut()) },
-                    });
+                    return RawEntry::Occupied(OccupiedEntry {
+                        rbtree: self,
+                        node_links: curr,
+                    })
                 }
             }
+            parent = curr;
         }
 
-        // INVARIANT: We are linking in a new node, which is valid. It remains valid because we
-        // "forgot" it with `Box::into_raw`.
-        // SAFETY: All pointers are non-null and valid (`*next_child` is null, but `next_child` is a
-        // mutable reference).
-        unsafe { bindings::rb_link_node(node_links, parent, child_field_of_parent) };
+        RawEntry::Vacant(RawVacantEntry {
+            parent,
+            child_field_of_parent,
+            rbtree: self,
+        })
+    }
 
-        // SAFETY: All pointers are valid. `node` has just been inserted into the tree.
-        unsafe { bindings::rb_insert_color(node_links, &mut self.root) };
-        None
+    /// Gets the given key's corresponding entry in the map for in-place manipulation.
+    pub fn entry(&mut self, key: K) -> Entry<'_, K, V> {
+        match self.raw_entry(&key) {
+            RawEntry::Occupied(entry) => Entry::Occupied(entry),
+            RawEntry::Vacant(entry) => Entry::Vacant(VacantEntry { raw: entry, key }),
+        }
     }
 
-    /// Returns a node with the given key, if one exists.
-    fn find(&self, key: &K) -> Option<NonNull<Node<K, V>>> {
+    /// Used for accessing the given node, if it exists.
+    pub fn find_mut(&mut self, key: &K) -> Option<OccupiedEntry<'_, K, V>> {
+        match self.raw_entry(key) {
+            RawEntry::Occupied(entry) => Some(entry),
+            RawEntry::Vacant(_entry) => None,
+        }
+    }
+
+    /// Returns a reference to the value corresponding to the key.
+    pub fn get(&self, key: &K) -> Option<&V> {
         let mut node = self.root.rb_node;
         while !node.is_null() {
             // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
@@ -400,47 +397,30 @@ fn find(&self, key: &K) -> Option<NonNull<Node<K, V>>> {
                 Ordering::Less => unsafe { (*node).rb_left },
                 // SAFETY: `node` is a non-null node so it is valid by the type invariants.
                 Ordering::Greater => unsafe { (*node).rb_right },
-                Ordering::Equal => return NonNull::new(this.cast_mut()),
+                // SAFETY: `node` is a non-null node so it is valid by the type invariants.
+                Ordering::Equal => return Some(unsafe { &(*this).value }),
             }
         }
         None
     }
 
-    /// Returns a reference to the value corresponding to the key.
-    pub fn get(&self, key: &K) -> Option<&V> {
-        // SAFETY: The `find` return value is a node in the tree, so it is valid.
-        self.find(key).map(|node| unsafe { &node.as_ref().value })
-    }
-
     /// Returns a mutable reference to the value corresponding to the key.
     pub fn get_mut(&mut self, key: &K) -> Option<&mut V> {
-        // SAFETY: The `find` return value is a node in the tree, so it is valid.
-        self.find(key)
-            .map(|mut node| unsafe { &mut node.as_mut().value })
+        self.find_mut(key).map(|node| node.into_mut())
     }
 
     /// Removes the node with the given key from the tree.
     ///
     /// It returns the node that was removed if one exists, or [`None`] otherwise.
-    fn remove_node(&mut self, key: &K) -> Option<RBTreeNode<K, V>> {
-        let mut node = self.find(key)?;
-
-        // SAFETY: The `find` return value is a node in the tree, so it is valid.
-        unsafe { bindings::rb_erase(&mut node.as_mut().links, &mut self.root) };
-
-        // INVARIANT: The node is being returned and the caller may free it, however, it was
-        // removed from the tree. So the invariants still hold.
-        Some(RBTreeNode {
-            // SAFETY: The `find` return value was a node in the tree, so it is valid.
-            node: unsafe { Box::from_raw(node.as_ptr()) },
-        })
+    pub fn remove_node(&mut self, key: &K) -> Option<RBTreeNode<K, V>> {
+        self.find_mut(key).map(OccupiedEntry::remove_node)
     }
 
     /// Removes the node with the given key from the tree.
     ///
     /// It returns the value that was removed if one exists, or [`None`] otherwise.
     pub fn remove(&mut self, key: &K) -> Option<V> {
-        self.remove_node(key).map(|node| node.node.value)
+        self.find_mut(key).map(OccupiedEntry::remove)
     }
 
     /// Returns a cursor over the tree nodes based on the given key.
@@ -1119,3 +1099,177 @@ unsafe impl<K: Send, V: Send> Send for RBTreeNode<K, V> {}
 // SAFETY: If K and V can be accessed without synchronization, then it's also okay to access
 // [`RBTreeNode`] without synchronization.
 unsafe impl<K: Sync, V: Sync> Sync for RBTreeNode<K, V> {}
+
+impl<K, V> RBTreeNode<K, V> {
+    /// Drop the key and value, but keep the allocation.
+    ///
+    /// It then becomes a reservation that can be re-initialised into a different node (i.e., with
+    /// a different key and/or value).
+    ///
+    /// The existing key and value are dropped in-place as part of this operation, that is, memory
+    /// may be freed (but only for the key/value; memory for the node itself is kept for reuse).
+    pub fn into_reservation(self) -> RBTreeNodeReservation<K, V> {
+        let raw = Box::into_raw(self.node);
+        let mut ret = RBTreeNodeReservation {
+            // SAFETY: The pointer came from a valid `Node`, which has the same layout as
+            // `MaybeUninit<Node>`.
+            node: unsafe { Box::from_raw(raw as _) },
+        };
+        // SAFETY: Although the type is `MaybeUninit<Node>`, we know it has been initialised
+        // because it came from a `Node`. So it is safe to drop it.
+        unsafe { core::ptr::drop_in_place::<Node<K, V>>(ret.node.as_mut_ptr()) };
+        ret
+    }
+}
+
+/// A view into a single entry in a map, which may either be vacant or occupied.
+///
+/// This enum is constructed from the [`entry`] method on [`RBTree`].
+///
+/// [`entry`]: fn@RBTree::entry
+pub enum Entry<'a, K, V> {
+    /// This [`RBTree`] does not have a node with this key.
+    Vacant(VacantEntry<'a, K, V>),
+    /// This [`RBTree`] already has a node with this key.
+    Occupied(OccupiedEntry<'a, K, V>),
+}
+
+/// Like [`Entry`], except that it doesn't have ownership of the key.
+enum RawEntry<'a, K, V> {
+    Vacant(RawVacantEntry<'a, K, V>),
+    Occupied(OccupiedEntry<'a, K, V>),
+}
+
+/// A view into a vacant entry in a [`RBTree`]. It is part of the [`Entry`] enum.
+pub struct VacantEntry<'a, K, V> {
+    key: K,
+    raw: RawVacantEntry<'a, K, V>,
+}
+
+/// Like [`VacantEntry`], but doesn't hold on to the key.a
+///
+/// # Invariants
+/// - `parent` may be null if the new node becomes the root.
+/// - `child_field_of_parent` is a valid pointer to the left-child or right-child of `parent`. If `parent` is
+///     null, it is a pointer to the root of the [`RBTree`].
+struct RawVacantEntry<'a, K, V> {
+    rbtree: &'a mut RBTree<K, V>,
+    /// The node that will become the parent of the new node if we insert one.
+    parent: *mut bindings::rb_node,
+    /// This points to the left-child or right-child field of `parent`, or `root` if `parent` is
+    /// null.
+    child_field_of_parent: *mut *mut bindings::rb_node,
+}
+
+impl<'a, K, V> RawVacantEntry<'a, K, V> {
+    /// Inserts the given node into the [`RBTree`] at this entry.
+    ///
+    /// The `node` must have a key such that inserting it here does not break the ordering of this
+    /// [`RBTree`].
+    fn insert(self, node: RBTreeNode<K, V>) -> &'a mut V {
+        let node = Box::into_raw(node.node);
+
+        // SAFETY: `node` is valid at least until we call `Box::from_raw`, which only happens when
+        // the node is removed or replaced.
+        let node_links = unsafe { addr_of_mut!((*node).links) };
+
+        // INVARIANT: We are linking in a new node, which is valid. It remains valid because we
+        // "forgot" it with `Box::into_raw`.
+        // SAFETY: All pointers are null or valid in an appropriate way.
+        unsafe { bindings::rb_link_node(node_links, self.parent, self.child_field_of_parent) };
+
+        // SAFETY: All pointers are valid. `node` has just been inserted into the tree.
+        unsafe { bindings::rb_insert_color(node_links, &mut self.rbtree.root) };
+
+        // SAFETY: The node is valid until we remove it from the tree.
+        unsafe { &mut (*node).value }
+    }
+}
+
+impl<'a, K, V> VacantEntry<'a, K, V> {
+    /// Inserts the given node into the [`RBTree`] at this entry.
+    pub fn insert(self, value: V, reservation: RBTreeNodeReservation<K, V>) -> &'a mut V {
+        self.raw.insert(reservation.into_node(self.key, value))
+    }
+}
+
+/// A view into an occupied entry in a [`RBTree`]. It is part of the [`Entry`] enum.
+///
+/// # Invariants
+/// - `node_links` is a valid, non-null pointer to a tree node.
+pub struct OccupiedEntry<'a, K, V> {
+    rbtree: &'a mut RBTree<K, V>,
+    /// The node that this entry corresponds to.
+    node_links: *mut bindings::rb_node,
+}
+
+impl<'a, K, V> OccupiedEntry<'a, K, V> {
+    fn node_ptr(&self) -> *mut Node<K, V> {
+        // SAFETY: By the type invariant of `Self`, all `node_links` pointers stored in `self`
+        // point to the links field of `Node<K, V>` objects.
+        unsafe { container_of!(self.node_links, Node<K, V>, links) }.cast_mut()
+    }
+
+    /// Gets a reference to the value in the entry.
+    pub fn get(&self) -> &V {
+        // SAFETY: `self.node_ptr` produces a valid pointer to a node in the tree.
+        unsafe { &(*self.node_ptr()).value }
+    }
+
+    /// Gets a mutable reference to the value in the entry.
+    pub fn get_mut(&mut self) -> &mut V {
+        // SAFETY: `self.node_ptr` produces a valid pointer to a node in the tree.
+        unsafe { &mut (*self.node_ptr()).value }
+    }
+
+    /// Converts the entry into a mutable reference to its value.
+    ///
+    /// If you need multiple references to the `OccupiedEntry`, see [`self#get_mut`].
+    pub fn into_mut(self) -> &'a mut V {
+        // SAFETY: `self.node_ptr` produces a valid pointer to a node in the tree.
+        unsafe { &mut (*self.node_ptr()).value }
+    }
+
+    /// Remove this entry from the [`RBTree`].
+    pub fn remove_node(self) -> RBTreeNode<K, V> {
+        // SAFETY: The node is a node in the tree, so it is valid.
+        unsafe { bindings::rb_erase(self.node_links, &mut self.rbtree.root) };
+
+        // INVARIANT: The node is being returned and the caller may free it, however, it was
+        // removed from the tree. So the invariants still hold.
+        RBTreeNode {
+            // SAFETY: The node was a node in the tree, but we removed it, so we can convert it
+            // back into a box.
+            node: unsafe { Box::from_raw(self.node_ptr()) },
+        }
+    }
+
+    /// Takes the value of the entry out of the map, and returns it.
+    pub fn remove(self) -> V {
+        self.remove_node().node.value
+    }
+
+    /// Swap the current node for the provided node.
+    ///
+    /// The key of both nodes must be equal.
+    fn replace(self, node: RBTreeNode<K, V>) -> RBTreeNode<K, V> {
+        let node = Box::into_raw(node.node);
+
+        // SAFETY: `node` is valid at least until we call `Box::from_raw`, which only happens when
+        // the node is removed or replaced.
+        let new_node_links = unsafe { addr_of_mut!((*node).links) };
+
+        // SAFETY: This updates the pointers so that `new_node_links` is in the tree where
+        // `self.node_links` used to be.
+        unsafe {
+            bindings::rb_replace_node(self.node_links, new_node_links, &mut self.rbtree.root)
+        };
+
+        // SAFETY:
+        // - `self.node_ptr` produces a valid pointer to a node in the tree.
+        // - Now that we removed this entry from the tree, we can convert the node to a box.
+        let old_node = unsafe { Box::from_raw(self.node_ptr()) };
+
+        RBTreeNode { node: old_node }
+    }
+}

-- 
2.44.0.769.g3c40516874-goog


