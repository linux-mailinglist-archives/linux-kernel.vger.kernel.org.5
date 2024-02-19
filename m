Return-Path: <linux-kernel+bounces-71245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3966385A26E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4796286176
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5845533CC8;
	Mon, 19 Feb 2024 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PINxa/8u"
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF512E646
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343323; cv=none; b=eQRuo834N1H7hdPDENdor/r37sMwlrVFUwXiR8CHoxeU+0aCea0JonKBmTzQhRO72w1qLGyJbHDl26AAiwrR3z5/hWd+qFXKQbqMAGq5rdo8Fm2oMmRo6hdNFjttWbWO5J+nexlTW4RHCya9sY5dG+UNwbR7FQPBM2Khpz6Wj1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343323; c=relaxed/simple;
	bh=4NJvpz2RnE7LLpmvRQAsdRnn4Zgd+uKku+16slGylXE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GkvPsCw3bREGTFfNxDlKG7VQs5yArNwYOpRTqejUiw7Mv4Xq/HbGDfbA80iXaOajevbxIZsOolfliKgjm7AHrUnvCbo6kOXmhAiCnif1unv/mrvpjvT++jFkVT312ekrulkXdpYnQB1jzOcyAvaJ++P86ISpnM0VtU4RpJlAH+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PINxa/8u; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7872570470eso573988685a.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708343320; x=1708948120; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwZ2a7+2VGra5HwuOBKn0CmjD9GQoqV7rwcv+kyW2rs=;
        b=PINxa/8uYL6xxnUd1RyEcLVU3wLWM5VvWa5Ti3Ch3RL40ZWfo7dZ7CSdnlIOHgBDfw
         mpzqv4UgrG3gzlipciZjyDTks8YioBVFPGhkWM8lE9Wfi+DI30I8/N0epeQ+ZgOSzWng
         w+baQAXIkBG0liAeG9qVpZlO8d54/3xYKsYLMiMBzoS4MPvOdubOAtRTVvd+27+CQvyy
         1Kku33i4DSRCCUQGUlRkEP22DsOE9QFjfyzf7vTPegnw/x4SfNp5vl2mEgSPqYENDlUJ
         elZPXLn9AiOUbj4CYRF/CwIzilyU8Q/+zSYH9VXbXYSN4doBCYwbqqALwEPNeblRlZif
         2fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708343320; x=1708948120;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwZ2a7+2VGra5HwuOBKn0CmjD9GQoqV7rwcv+kyW2rs=;
        b=SSot9BmPPKCXitZhon5cMQjPhHzVgPgthdhNJZQpevX1S51mlX7Chn3E1oqKCFzcxB
         s1jhjZMW7zsvCuX/i8lKqFUkANIQMxRNYPNlX+oNQmH258MHnryUlppPfmOxgVWDhY1f
         VnnBpLtlApMiwTWqprkhsiiair17OfCTEKWbNWd+JHnKqUYf9LqcC9HIEXs/t9sWM6FO
         MhBW8C55Ywwu6weYTFG4hPAZH4WhysvfaV4agrYOYn0oUv/BRATEE3auoTjSn/IcZPfI
         dPupftUWofW7qmRw1pQFXtOka3SGFIRFoUiSt1NJJAi6wFoSvbrBYZUNJmRk3VqBqZGs
         TZdw==
X-Forwarded-Encrypted: i=1; AJvYcCWlTnq0h5WfxhQ3crNcRk0EkT6lhq715e/wdj2wMnC2U6KuacUvRKY5q8tbZom6xCqFi7PuvJvoKEcSB/W+y4Q4CVZ0V3DbOMf4U4jZ
X-Gm-Message-State: AOJu0YwHcV2IyFGkFM0qYXvL5XsgVIgDnN9CRcslUxMhCZxHsggAmwA6
	WB4LvxWGrtaSt5d9t1Yd5+zLEJaEMfwvhg38VS19jdPtagaRybAWNdPmg68yLe9y006fIApShUc
	2wHt9qlb23RmEJP8/Vnb/TpjpQw==
X-Google-Smtp-Source: AGHT+IGDBGfKAo/Ungf5s/jI4EAe3bAVE6/PPDBM+hhCtNGcU7dixp9DA1y9KC8zzngasR+k/S2iAgNOX4DQQUAl+go=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:620a:1909:b0:787:6f35:ba54 with
 SMTP id bj9-20020a05620a190900b007876f35ba54mr9547qkb.8.1708343320353; Mon,
 19 Feb 2024 03:48:40 -0800 (PST)
Date: Mon, 19 Feb 2024 11:48:12 +0000
In-Reply-To: <20240219-b4-rbtree-v2-0-0b113aab330d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219-b4-rbtree-v2-0-0b113aab330d@google.com>
X-Mailer: b4 0.12.4
Message-ID: <20240219-b4-rbtree-v2-5-0b113aab330d@google.com>
Subject: [PATCH v2 5/6] rust: rbtree: add `RBTreeCursor`
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

Add a cursor interface to `RBTree`, supporting the following use cases:
- Inspect the current node pointed to by the cursor, inspect/move to
  it's neighbors in sort order (bidirectionally).
- Mutate the tree itself by removing the current node pointed to by the
  cursor, or one of its neighbors.

Add functions to obtain a cursor to the tree by key:
- The node with the smallest key
- The node with the largest key
- The node matching the given key, or the one with the next larger key

The cursor abstraction is needed by the binder driver to efficiently
search for nodes and (conditionally) modify them, as well as their
neighbors [1].

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-6-08ba9197f637@google.com/ [1]
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
---
 rust/kernel/rbtree.rs | 512 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 512 insertions(+)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index ccf74e0dc3ec..6c3b10e46517 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -245,6 +245,36 @@ pub fn values(&self) -> impl Iterator<Item = &'_ V> {
     pub fn values_mut(&mut self) -> impl Iterator<Item = &'_ mut V> {
         self.iter_mut().map(|(_, v)| v)
     }
+
+    /// Returns a cursor over the tree nodes, starting with the smallest key.
+    pub fn cursor_front(&mut self) -> Option<RBTreeCursor<'_, K, V>> {
+        let root = addr_of_mut!(self.root);
+        // SAFETY: `self.root` is always a valid root node
+        let current = unsafe { bindings::rb_first(root) };
+        if current.is_null() {
+            return None;
+        }
+        Some(RBTreeCursor {
+            _tree: PhantomData,
+            root,
+            current,
+        })
+    }
+
+    /// Returns a cursor over the tree nodes, starting with the largest key.
+    pub fn cursor_back(&mut self) -> Option<RBTreeCursor<'_, K, V>> {
+        let root = addr_of_mut!(self.root);
+        // SAFETY: `self.root` is always a valid root node
+        let current = unsafe { bindings::rb_last(root) };
+        if current.is_null() {
+            return None;
+        }
+        Some(RBTreeCursor {
+            _tree: PhantomData,
+            root,
+            current,
+        })
+    }
 }
 
 impl<K, V> RBTree<K, V>
@@ -377,6 +407,59 @@ pub fn remove(&mut self, key: &K) -> Option<V> {
         } = *node;
         Some(value)
     }
+
+    /// Returns a cursor over the tree nodes based on the given key.
+    ///
+    /// If the given key exists, the cursor starts there.
+    /// Otherwise it starts with the first larger key in sort order.
+    /// If there is no larger key, it returns [`None`].
+    pub fn cursor_lower_bound(&mut self, key: &K) -> Option<RBTreeCursor<'_, K, V>>
+    where
+        K: Ord,
+    {
+        let mut node = self.root.rb_node;
+        let mut best_match: Option<NonNull<Node<K, V>>> = None;
+        while !node.is_null() {
+            // SAFETY: All links fields we create are in a `Node<K, V>`.
+            let this = unsafe { crate::container_of!(node, Node<K, V>, links) }.cast_mut();
+            // SAFETY: `this` is a non-null node so it is valid by the type invariants.
+            let this_key = unsafe { &(*this).key };
+            // SAFETY: `node` is a non-null node so it is valid by the type invariants.
+            let left_child = unsafe { (*node).rb_left };
+            // SAFETY: `node` is a non-null node so it is valid by the type invariants.
+            let right_child = unsafe { (*node).rb_right };
+            if key == this_key {
+                return Some(RBTreeCursor {
+                    _tree: PhantomData,
+                    root: addr_of_mut!(self.root),
+                    current: node,
+                });
+            } else {
+                node = if key > this_key {
+                    right_child
+                } else {
+                    let is_better_match = match best_match {
+                        None => true,
+                        Some(best) => {
+                            // SAFETY: `best` is a non-null node so it is valid by the type invariants.
+                            let best_key = unsafe { &(*best.as_ptr()).key };
+                            best_key > this_key
+                        }
+                    };
+                    if is_better_match {
+                        best_match = NonNull::new(this);
+                    }
+                    left_child
+                }
+            };
+        }
+        best_match.map(|best| RBTreeCursor {
+            _tree: PhantomData,
+            root: addr_of_mut!(self.root),
+            // SAFETY: `best` is a non-null node so it is valid by the type invariants.
+            current: unsafe { addr_of_mut!((*best.as_ptr()).links) },
+        })
+    }
 }
 
 impl<K, V> Default for RBTree<K, V> {
@@ -407,6 +490,435 @@ fn drop(&mut self) {
     }
 }
 
+/// A bidirectional cursor over the tree nodes, sorted by key.
+///
+/// # Invariants
+///
+/// In instance of `RBTreeCursor` is only acquired from [`RBTree`].
+/// A reference to the tree used to create the cursor outlives the cursor, so
+/// the tree cannot change. By the tree invariant, all nodes are valid.
+///
+/// # Examples
+///
+/// In the following example, we obtain a cursor to the first element in the tree.
+/// The cursor allows us to iterate bidirectionally over key/value pairs in the tree.
+///
+/// ```
+/// use kernel::rbtree::RBTree;
+///
+/// // Create a new tree.
+/// let mut tree = RBTree::new();
+///
+/// // Insert three elements.
+/// tree.try_create_and_insert(10, 100)?;
+/// tree.try_create_and_insert(20, 200)?;
+/// tree.try_create_and_insert(30, 300)?;
+///
+/// // Get a cursor to the first element.
+/// let mut cursor = tree.cursor_front().unwrap();
+/// let mut current = cursor.current();
+/// assert_eq!(current, (&10, &100));
+///
+/// // Move the cursor, updating it to the 2nd element.
+/// cursor = cursor.move_next().unwrap();
+/// current = cursor.current();
+/// assert_eq!(current, (&20, &200));
+///
+/// // Peek at the next element without impacting the cursor.
+/// let next = cursor.peek_next().unwrap();
+/// assert_eq!(next, (&30, &300));
+/// current = cursor.current();
+/// assert_eq!(current, (&20, &200));
+///
+/// // Moving past the last element causes the cursor to return [`None`].
+/// cursor = cursor.move_next().unwrap();
+/// current = cursor.current();
+/// assert_eq!(current, (&30, &300));
+/// let cursor = cursor.move_next();
+/// assert!(cursor.is_none());
+///
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// A cursor can also be obtained at the last element in the tree.
+///
+/// ```
+/// use kernel::rbtree::RBTree;
+///
+/// // Create a new tree.
+/// let mut tree = RBTree::new();
+///
+/// // Insert three elements.
+/// tree.try_create_and_insert(10, 100)?;
+/// tree.try_create_and_insert(20, 200)?;
+/// tree.try_create_and_insert(30, 300)?;
+///
+/// let mut cursor = tree.cursor_back().unwrap();
+/// let current = cursor.current();
+/// assert_eq!(current, (&30, &300));
+///
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// Obtaining a cursor returns [`None`] if the tree is empty.
+///
+/// ```
+/// use kernel::rbtree::RBTree;
+///
+/// let mut tree: RBTree<u16, u16> = RBTree::new();
+/// assert!(tree.cursor_front().is_none());
+///
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// [`RBTree::cursor_lower_bound`] can be used to start at an arbitrary node in the tree.
+///
+/// ```
+/// use kernel::rbtree::RBTree;
+///
+/// // Create a new tree.
+/// let mut tree = RBTree::new();
+///
+/// // Insert five elements.
+/// tree.try_create_and_insert(10, 100)?;
+/// tree.try_create_and_insert(20, 200)?;
+/// tree.try_create_and_insert(30, 300)?;
+/// tree.try_create_and_insert(40, 400)?;
+/// tree.try_create_and_insert(50, 500)?;
+///
+/// // If the provided key exists, a cursor to that key is returned.
+/// let cursor = tree.cursor_lower_bound(&20).unwrap();
+/// let current = cursor.current();
+/// assert_eq!(current, (&20, &200));
+///
+/// // If the provided key doesn't exist, a cursor to the first larger element in sort order is returned.
+/// let cursor = tree.cursor_lower_bound(&25).unwrap();
+/// let current = cursor.current();
+/// assert_eq!(current, (&30, &300));
+///
+/// // If there is no larger key, [`None`] is returned.
+/// let cursor = tree.cursor_lower_bound(&55);
+/// assert!(cursor.is_none());
+///
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// The cursor allows mutation of values in the tree.
+///
+/// ```
+/// use kernel::rbtree::RBTree;
+///
+/// // Create a new tree.
+/// let mut tree = RBTree::new();
+///
+/// // Insert three elements.
+/// tree.try_create_and_insert(10, 100)?;
+/// tree.try_create_and_insert(20, 200)?;
+/// tree.try_create_and_insert(30, 300)?;
+///
+/// // Retrieve a cursor.
+/// let mut cursor = tree.cursor_front().unwrap();
+///
+/// // Get a mutable reference to the current value.
+/// let (k, v) = cursor.current_mut();
+/// *v = 1000;
+///
+/// // The updated value is reflected in the tree.
+/// let updated = tree.get(&10).unwrap();
+/// assert_eq!(updated, &1000);
+///
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// It also allows node removal. The following examples demonstrate the behavior of removing the current node.
+///
+/// ```
+/// use kernel::rbtree::RBTree;
+///
+/// // Create a new tree.
+/// let mut tree = RBTree::new();
+///
+/// // Insert three elements.
+/// tree.try_create_and_insert(10, 100)?;
+/// tree.try_create_and_insert(20, 200)?;
+/// tree.try_create_and_insert(30, 300)?;
+///
+/// // Remove the first element.
+/// let mut cursor = tree.cursor_front().unwrap();
+/// let mut current = cursor.current();
+/// assert_eq!(current, (&10, &100));
+/// cursor = cursor.remove_current().unwrap();
+///
+/// // If a node exists after the current element, it is returned.
+/// current = cursor.current();
+/// assert_eq!(current, (&20, &200));
+///
+/// // Get a cursor to the last element, and remove it.
+/// cursor = tree.cursor_back().unwrap();
+/// current = cursor.current();
+/// assert_eq!(current, (&30, &300));
+///
+/// // Since there is no next node, the previous node is returned.
+/// cursor = cursor.remove_current().unwrap();
+/// current = cursor.current();
+/// assert_eq!(current, (&20, &200));
+///
+/// // Removing the last element in the tree returns [`None`].
+/// assert!(cursor.remove_current().is_none());
+///
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// Nodes adjacent to the current node can also be removed.
+///
+/// ```
+/// use kernel::rbtree::RBTree;
+///
+/// // Create a new tree.
+/// let mut tree = RBTree::new();
+///
+/// // Insert three elements.
+/// tree.try_create_and_insert(10, 100)?;
+/// tree.try_create_and_insert(20, 200)?;
+/// tree.try_create_and_insert(30, 300)?;
+///
+/// // Get a cursor to the first element.
+/// let mut cursor = tree.cursor_front().unwrap();
+/// let mut current = cursor.current();
+/// assert_eq!(current, (&10, &100));
+///
+/// // Calling `remove_prev` from the first element returns [`None`].
+/// assert!(cursor.remove_prev().is_none());
+///
+/// // Get a cursor to the last element.
+/// cursor = tree.cursor_back().unwrap();
+/// current = cursor.current();
+/// assert_eq!(current, (&30, &300));
+///
+/// // Calling `remove_prev` removes and returns the middle element.
+/// assert_eq!(cursor.remove_prev().unwrap(), (20, 200));
+///
+/// // Calling `remove_next` from the last element returns [`None`].
+/// assert!(cursor.remove_next().is_none());
+///
+/// // Move to the first element
+/// cursor = cursor.move_prev().unwrap();
+/// current = cursor.current();
+/// assert_eq!(current, (&10, &100));
+///
+/// // Calling `remove_next` removes and returns the last element.
+/// assert_eq!(cursor.remove_next().unwrap(), (30, 300));
+///
+/// # Ok::<(), Error>(())
+/// ```
+pub struct RBTreeCursor<'a, K, V> {
+    _tree: PhantomData<&'a RBTree<K, V>>,
+    root: *mut bindings::rb_root,
+    current: *mut bindings::rb_node,
+}
+
+// SAFETY: An [`RBTree`] allows the same kinds of access to its values that a struct allows to its
+// fields, so we use the same Send condition as would be used for a struct with K and V fields.
+unsafe impl<'a, K: Send, V: Send> Send for RBTreeCursor<'a, K, V> {}
+
+// SAFETY: An [`RBTree`] allows the same kinds of access to its values that a struct allows to its
+// fields, so we use the same Sync condition as would be used for a struct with K and V fields.
+unsafe impl<'a, K: Sync, V: Sync> Sync for RBTreeCursor<'a, K, V> {}
+
+impl<'a, K, V> RBTreeCursor<'a, K, V> {
+    /// The current node
+    pub fn current(&self) -> (&K, &V) {
+        Self::to_key_value(self.current)
+    }
+
+    /// The current node, with a mutable value
+    pub fn current_mut(&mut self) -> (&K, &mut V) {
+        Self::to_key_value_mut(self.current)
+    }
+
+    /// Remove the current node from the tree.
+    ///
+    /// Returns a cursor to the next node, if it exists,
+    /// else the previous node. Returns [`None`] if the tree
+    /// becomes empty.
+    pub fn remove_current(mut self) -> Option<Self> {
+        let prev = self.get_neighbor_raw(Direction::Prev);
+        let next = self.get_neighbor_raw(Direction::Next);
+        // SAFETY: All links fields we create are in a `Node<K, V>`.
+        let this = unsafe { crate::container_of!(self.current, Node<K, V>, links) }.cast_mut();
+        // SAFETY: The reference to the tree used to create the cursor outlives the cursor, so
+        // the tree cannot change. By the tree invariant, all nodes are valid.
+        unsafe { bindings::rb_erase(&mut (*this).links, self.root) };
+
+        let current = match (prev, next) {
+            (_, Some(next)) => next,
+            (Some(prev), None) => prev,
+            (None, None) => {
+                return None;
+            }
+        };
+
+        Some(Self {
+            current,
+            _tree: self._tree,
+            root: self.root,
+        })
+    }
+
+    /// Remove the previous node, returning it if it exists.
+    pub fn remove_prev(&mut self) -> Option<(K, V)> {
+        self.remove_neighbor(Direction::Prev)
+    }
+
+    /// Remove the next node, returning it if it exists.
+    pub fn remove_next(&mut self) -> Option<(K, V)> {
+        self.remove_neighbor(Direction::Next)
+    }
+
+    fn remove_neighbor(&mut self, direction: Direction) -> Option<(K, V)> {
+        if let Some(neighbor) = self.get_neighbor_raw(direction) {
+            // SAFETY: All links fields we create are in a `Node<K, V>`.
+            let this = unsafe { crate::container_of!(neighbor, Node<K, V>, links) }.cast_mut();
+            // SAFETY: The reference to the tree used to create the cursor outlives the cursor, so
+            // the tree cannot change. By the tree invariant, all nodes are valid.
+            unsafe { bindings::rb_erase(&mut (*this).links, self.root) };
+            return Some(Self::to_key_value_owned(neighbor));
+        }
+        None
+    }
+
+    /// Move the cursor to the previous node, returning [`None`] if it doesn't exist.
+    pub fn move_prev(self) -> Option<Self> {
+        self.mv(Direction::Prev)
+    }
+
+    /// Move the cursor to the next node, returning [`None`] if it doesn't exist.
+    pub fn move_next(self) -> Option<Self> {
+        self.mv(Direction::Next)
+    }
+
+    fn mv(mut self, direction: Direction) -> Option<Self> {
+        self.get_neighbor_raw(direction).map(|neighbor| Self {
+            _tree: self._tree,
+            root: self.root,
+            current: neighbor,
+        })
+    }
+
+    /// Access the previous node without moving the cursor.
+    pub fn peek_prev(&self) -> Option<(&K, &V)> {
+        self.peek(Direction::Prev)
+    }
+
+    /// Access the previous node without moving the cursor.
+    pub fn peek_next(&self) -> Option<(&K, &V)> {
+        self.peek(Direction::Next)
+    }
+
+    fn peek(&self, direction: Direction) -> Option<(&K, &V)> {
+        // SAFETY: `self.current` is valid by the type invariants.
+        let neighbor = unsafe {
+            match direction {
+                Direction::Prev => bindings::rb_prev(self.current),
+                Direction::Next => bindings::rb_next(self.current),
+            }
+        };
+
+        if neighbor.is_null() {
+            return None;
+        }
+
+        Some(Self::to_key_value(neighbor))
+    }
+
+    /// Access the previous node mutably without moving the cursor.
+    pub fn peek_prev_mut(&mut self) -> Option<(&K, &mut V)> {
+        self.peek_mut(Direction::Prev)
+    }
+
+    /// Access the next node mutably without moving the cursor.
+    pub fn peek_next_mut(&mut self) -> Option<(&K, &mut V)> {
+        self.peek_mut(Direction::Next)
+    }
+
+    fn peek_mut(&mut self, direction: Direction) -> Option<(&K, &mut V)> {
+        // SAFETY: `self.current` is valid by the type invariants.
+        let neighbor = unsafe {
+            match direction {
+                Direction::Prev => bindings::rb_prev(self.current),
+                Direction::Next => bindings::rb_next(self.current),
+            }
+        };
+
+        if neighbor.is_null() {
+            return None;
+        }
+
+        Some(Self::to_key_value_mut(neighbor))
+    }
+
+    fn get_neighbor_raw(&mut self, direction: Direction) -> Option<*mut bindings::rb_node> {
+        // SAFETY: `self.current` is valid by the type invariants.
+        let neighbor = unsafe {
+            match direction {
+                Direction::Prev => bindings::rb_prev(self.current),
+                Direction::Next => bindings::rb_next(self.current),
+            }
+        };
+
+        if neighbor.is_null() {
+            return None;
+        }
+
+        Some(neighbor)
+    }
+
+    // This internal method should *only* be called with a valid pointer to a node.
+    fn to_key_value(node: *mut bindings::rb_node) -> (&'a K, &'a V) {
+        // SAFETY: All links fields we create are in a `Node<K, V>`.
+        let this = unsafe { crate::container_of!(node, Node<K, V>, links) };
+        // SAFETY: The passed `node` is the current node or a non-null neighbor,
+        // thus `this` is valid by the type invariants.
+        let k = unsafe { &(*this).key };
+        // SAFETY: The passed `node` is the current node or a non-null neighbor,
+        // thus `this` is valid by the type invariants.
+        let v = unsafe { &(*this).value };
+        (k, v)
+    }
+
+    // This internal method should *only* be called with a valid pointer to a node.
+    fn to_key_value_mut(node: *mut bindings::rb_node) -> (&'a K, &'a mut V) {
+        // SAFETY: All links fields we create are in a `Node<K, V>`.
+        let this = unsafe { crate::container_of!(node, Node<K, V>, links) }.cast_mut();
+        // SAFETY: The passed `node` is the current node or a non-null neighbor,
+        // thus `this` is valid by the type invariants.
+        let k = unsafe { &(*this).key };
+        // SAFETY: The passed `node` is the current node or a non-null neighbor,
+        // thus `this` is valid by the type invariants.
+        let v = unsafe { &mut (*this).value };
+        (k, v)
+    }
+
+    // This internal method should *only* be called with a valid pointer to a node *that is being removed*.
+    fn to_key_value_owned(node: *mut bindings::rb_node) -> (K, V) {
+        // SAFETY: All links fields we create are in a `Node<K, V>`.
+        let this = unsafe { crate::container_of!(node, Node<K, V>, links) }.cast_mut();
+        // SAFETY: The passed `node` is the current node or a non-null neighbor,
+        // thus `this` is valid by the type invariants.
+        let n = unsafe { Box::from_raw(this) };
+
+        (n.key, n.value)
+    }
+}
+
+/// Direction for [`RBTreeCursor`] operations.
+enum Direction {
+    /// the node immediately before, in sort order
+    Prev,
+    /// the node immediately after, in sort order
+    Next,
+}
+
 impl<'a, K, V> IntoIterator for &'a RBTree<K, V> {
     type Item = (&'a K, &'a V);
     type IntoIter = RBTreeIterator<'a, K, V>;

-- 
2.44.0.rc0.258.g7320e95886-goog


