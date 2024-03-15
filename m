Return-Path: <linux-kernel+bounces-104362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A41187CC9B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15FAE283706
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B01B1BC5B;
	Fri, 15 Mar 2024 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Vs/bxmdS"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAE219478
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710503031; cv=none; b=pU5kGZC63QclgWuIfCTzE6dNZqKW4sFXIiaZ4Hp9+mu2vNp/SK6CnGscudiDju6bjkI7zsHyL6Ee0oBfmbcPT03rbepm3MIePrwdM8e3UxOcj2d/oa0iOFOg9HPp4UIq6ov77vcuvWaoNzjwgKopv34gzHC9DBj2G652apVH4ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710503031; c=relaxed/simple;
	bh=HC4c8ZOgoF3e+Cl8VtuCX1BOUL8AarY5k2o3PXacYr0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQ5b3dunJ/Wn/Jik5Btm4wtHam0ce8PC2n/ivd1GjMgAegX+eHsV8t6F55JQTjjh0NCxkIFmcwlEJxmUasxVz5NWYGgmugKfbdxGQM+vFEcGAGlN+rwL17DmZGgIcVMb/5F4HYYMNqjzN4Bl4PJxc/hUChyOkdk5GJMfKTN3uLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Vs/bxmdS; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=hf34ba44hvgntfggywyg6hgxfu.protonmail; t=1710503019; x=1710762219;
	bh=BEpl/6eDjt/wHDQt2hX8g1OrUDcjjSfIRDLmKijpsrI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Vs/bxmdSf1wTqVGbbnPa0dvTy63GVVXnpHL0HE2rdkRaT03SW7mw+I/zy8tZjyDfW
	 EwW+f1DMgGLeAPJ8j5ZVkfqkhjZdwYKVq3bw2SdB0PWR3gV7Yumfnn/Ko2E/9koGyQ
	 OqC/W0hMN95e2cZSqZwSuzhdKJXu7k+XaHVrjy9w4XGRkRi3BZ7/vB9aY1caKzN4WH
	 CoDds4cwFhL0Hr6xNmMX28Yx1ekgNsMu/oKsCBNs7V4105eHK1dBrsgoi4ntZAKuVu
	 thOBuACID45kY6ILt5yRVQRmkUbrg6A9mn7MQW+7PycOZn5F4sceO+YDzRzXb7e3Wp
	 aSBBfdpmW0Bag==
Date: Fri, 15 Mar 2024 11:43:17 +0000
To: Matt Gilbride <mattgilbride@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] rust: rbtree: add `RBTree::entry`
Message-ID: <85f0aa0e-c584-4ccd-beb7-15c8526bd244@proton.me>
In-Reply-To: <20240219-b4-rbtree-v2-6-0b113aab330d@google.com>
References: <20240219-b4-rbtree-v2-0-0b113aab330d@google.com> <20240219-b4-rbtree-v2-6-0b113aab330d@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/19/24 12:48, Matt Gilbride wrote:
> From: Alice Ryhl <aliceryhl@google.com>
>=20
> This mirrors the entry API [1] from the Rust standard library on
> `RBTree`. This API can be used to access the entry at a specific key and
> make modifications depending on whether the key is vacant or occupied.
> This API is useful because it can often be used to avoid traversing the
> tree multiple times.
>=20
> This is used by binder to look up and conditionally access or insert a
> value, depending on whether it is there or not [2].
>=20
> Link: https://doc.rust-lang.org/stable/std/collections/btree_map/enum.Ent=
ry.html [1]
> Link: https://android-review.googlesource.com/c/kernel/common/+/2849906 [=
2]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Tested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Matt Gilbride <mattgilbride@google.com>
> ---
>   rust/kernel/rbtree.rs | 284 ++++++++++++++++++++++++++++++++++++++-----=
-------
>   1 file changed, 216 insertions(+), 68 deletions(-)
>=20
> diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
> index 6c3b10e46517..b564e4eb733c 100644
> --- a/rust/kernel/rbtree.rs
> +++ b/rust/kernel/rbtree.rs
> @@ -298,56 +298,64 @@ pub fn try_create_and_insert(&mut self, key: K, val=
ue: V) -> Result<Option<RBTre
>       ///
>       /// This function always succeeds.
>       pub fn insert(&mut self, node: RBTreeNode<K, V>) -> Option<RBTreeNo=
de<K, V>> {
> -        let RBTreeNode { node } =3D node;
> -        let node =3D Box::into_raw(node);
> -        // SAFETY: `node` is valid at least until we call `Box::from_raw=
`, which only happens when
> -        // the node is removed or replaced.
> -        let node_links =3D unsafe { addr_of_mut!((*node).links) };
> +        match self.raw_entry(&node.node.key) {
> +            RawEntry::Occupied(entry) =3D> Some(entry.replace(node)),
> +            RawEntry::Vacant(entry) =3D> {
> +                entry.insert(node);
> +                None
> +            }
> +        }
> +    }
> +
> +    fn raw_entry(&mut self, key: &K) -> RawEntry<'_, K, V> {
>           let mut new_link: &mut *mut bindings::rb_node =3D &mut self.roo=
t.rb_node;
>           let mut parent =3D core::ptr::null_mut();
> -        while !new_link.is_null() {
> +        while !(*new_link).is_null() {
> +            let curr =3D *new_link;
>               // SAFETY: All links fields we create are in a `Node<K, V>`=
.
> -            let this =3D unsafe { crate::container_of!(*new_link, Node<K=
, V>, links) };
> +            let node =3D unsafe { crate::container_of!(curr, Node<K, V>,=
 links) };
>=20
> -            parent =3D *new_link;
> -
> -            // SAFETY: `this` is a non-null node so it is valid by the t=
ype invariants. `node` is
> -            // valid until the node is removed.
> -            match unsafe { (*node).key.cmp(&(*this).key) } {
> -                // SAFETY: `parent` is a non-null node so it is valid by=
 the type invariants.
> -                Ordering::Less =3D> new_link =3D unsafe { &mut (*parent)=
rb_left },
> -                // SAFETY: `parent` is a non-null node so it is valid by=
 the type invariants.
> -                Ordering::Greater =3D> new_link =3D unsafe { &mut (*pare=
nt).rb_right },
> +            // SAFETY: `node` is a non-null node so it is valid by the t=
ype invariants.
> +            match key.cmp(unsafe { &(*node).key }) {
> +                // SAFETY: `curr` is a non-null node so it is valid by t=
he type invariants.
> +                Ordering::Less =3D> new_link =3D unsafe { &mut (*curr).r=
b_left },
> +                // SAFETY: `curr` is a non-null node so it is valid by t=
he type invariants.
> +                Ordering::Greater =3D> new_link =3D unsafe { &mut (*curr=
).rb_right },
>                   Ordering::Equal =3D> {
> -                    // INVARIANT: We are replacing an existing node with=
 a new one, which is valid.
> -                    // It remains valid because we "forgot" it with `Box=
::into_raw`.
> -                    // SAFETY: All pointers are non-null and valid (pare=
nt, despite the name, really
> -                    // is the node we're replacing).
> -                    unsafe { bindings::rb_replace_node(parent, node_link=
s, &mut self.root) };
> -
> -                    // INVARIANT: The node is being returned and the cal=
ler may free it, however,
> -                    // it was removed from the tree. So the invariants s=
till hold.
> -                    return Some(RBTreeNode {
> -                        // SAFETY: `this` was a node in the tree, so it =
is valid.
> -                        node: unsafe { Box::from_raw(this as _) },
> -                    });
> +                    return RawEntry::Occupied(OccupiedEntry {
> +                        rbtree: self,
> +                        node_links: curr,
> +                    })
>                   }
>               }
> +            parent =3D curr;
>           }
>=20
> -        // INVARIANT: We are linking in a new node, which is valid. It r=
emains valid because we
> -        // "forgot" it with `Box::into_raw`.
> -        // SAFETY: All pointers are non-null and valid (`*new_link` is n=
ull, but `new_link` is a
> -        // mutable reference).
> -        unsafe { bindings::rb_link_node(node_links, parent, new_link) };
> +        RawEntry::Vacant(RawVacantEntry {
> +            parent,
> +            new_link,
> +            rbtree: self,
> +        })
> +    }
>=20
> -        // SAFETY: All pointers are valid. `node` has just been inserted=
 into the tree.
> -        unsafe { bindings::rb_insert_color(node_links, &mut self.root) }=
;
> -        None
> +    /// Gets the given key's corresponding entry in the map for in-place=
 manipulation.
> +    pub fn entry(&mut self, key: K) -> Entry<'_, K, V> {
> +        match self.raw_entry(&key) {
> +            RawEntry::Occupied(entry) =3D> Entry::Occupied(entry),
> +            RawEntry::Vacant(entry) =3D> Entry::Vacant(VacantEntry { raw=
: entry, key }),
> +        }
>       }
>=20
> -    /// Returns a node with the given key, if one exists.
> -    fn find(&self, key: &K) -> Option<NonNull<Node<K, V>>> {
> +    /// Used for accessing the given node, if it exists.
> +    pub fn find_mut(&mut self, key: &K) -> Option<OccupiedEntry<'_, K, V=
>> {
> +        match self.raw_entry(key) {
> +            RawEntry::Occupied(entry) =3D> Some(entry),
> +            RawEntry::Vacant(_entry) =3D> None,
> +        }
> +    }
> +
> +    /// Returns a reference to the value corresponding to the key.
> +    pub fn get(&self, key: &K) -> Option<&V> {
>           let mut node =3D self.root.rb_node;
>           while !node.is_null() {
>               // SAFETY: All links fields we create are in a `Node<K, V>`=
.
> @@ -358,54 +366,30 @@ fn find(&self, key: &K) -> Option<NonNull<Node<K, V=
>>> {
>                   Ordering::Less =3D> unsafe { (*node).rb_left },
>                   // SAFETY: `node` is a non-null node so it is valid by =
the type invariants.
>                   Ordering::Greater =3D> unsafe { (*node).rb_right },
> -                Ordering::Equal =3D> return NonNull::new(this as _),
> +                // SAFETY: `node` is a non-null node so it is valid by t=
he type invariants.
> +                Ordering::Equal =3D> return Some(unsafe { &(*this).value=
 }),
>               }
>           }
>           None
>       }
>=20
> -    /// Returns a reference to the value corresponding to the key.
> -    pub fn get(&self, key: &K) -> Option<&V> {
> -        // SAFETY: The `find` return value is a node in the tree, so it =
is valid.
> -        self.find(key).map(|node| unsafe { &node.as_ref().value })
> -    }
> -
>       /// Returns a mutable reference to the value corresponding to the k=
ey.
>       pub fn get_mut(&mut self, key: &K) -> Option<&mut V> {
> -        // SAFETY: The `find` return value is a node in the tree, so it =
is valid.
> -        self.find(key)
> -            .map(|mut node| unsafe { &mut node.as_mut().value })
> +        self.find_mut(key).map(|node| node.into_mut())
>       }
>=20
>       /// Removes the node with the given key from the tree.
>       ///
>       /// It returns the node that was removed if one exists, or [`None`]=
 otherwise.
> -    fn remove_node(&mut self, key: &K) -> Option<RBTreeNode<K, V>> {
> -        let mut node =3D self.find(key)?;
> -
> -        // SAFETY: The `find` return value is a node in the tree, so it =
is valid.
> -        unsafe { bindings::rb_erase(&mut node.as_mut().links, &mut self.=
root) };
> -
> -        // INVARIANT: The node is being returned and the caller may free=
 it, however, it was
> -        // removed from the tree. So the invariants still hold.
> -        Some(RBTreeNode {
> -            // SAFETY: The `find` return value was a node in the tree, s=
o it is valid.
> -            node: unsafe { Box::from_raw(node.as_ptr()) },
> -        })
> +    pub fn remove_node(&mut self, key: &K) -> Option<RBTreeNode<K, V>> {
> +        self.find_mut(key).map(OccupiedEntry::remove_node)
>       }
>=20
>       /// Removes the node with the given key from the tree.
>       ///
>       /// It returns the value that was removed if one exists, or [`None`=
] otherwise.
>       pub fn remove(&mut self, key: &K) -> Option<V> {
> -        let node =3D self.remove_node(key)?;
> -        let RBTreeNode { node } =3D node;
> -        let Node {
> -            links: _,
> -            key: _,
> -            value,
> -        } =3D *node;
> -        Some(value)
> +        self.find_mut(key).map(OccupiedEntry::remove)
>       }
>=20
>       /// Returns a cursor over the tree nodes based on the given key.
> @@ -1064,3 +1048,167 @@ unsafe impl<K: Send, V: Send> Send for RBTreeNode=
<K, V> {}
>   // SAFETY: An [`RBTree`] allows the same kinds of access to its values =
that a struct allows to its
>   // fields, so we use the same Sync condition as would be used for a str=
uct with K and V fields.
>   unsafe impl<K: Sync, V: Sync> Sync for RBTreeNode<K, V> {}
> +
> +impl<K, V> RBTreeNode<K, V> {
> +    /// "Uninitialises" a node.

I think "Drop the key and value, but keep the allocation." might fit
better.

> +    ///
> +    /// It then becomes a reservation that can be re-initialised into a =
different node (i.e., with
> +    /// a different key and/or value).
> +    ///
> +    /// The existing key and value are dropped in-place as part of this =
operation, that is, memory
> +    /// may be freed (but only for the key/value; memory for the node it=
self is kept for reuse).
> +    pub fn into_reservation(self) -> RBTreeNodeReservation<K, V> {
> +        let raw =3D Box::into_raw(self.node);
> +        let mut ret =3D RBTreeNodeReservation {
> +            // SAFETY: The pointer came from a valid `Node`, which has t=
he same layout as
> +            // `MaybeUninit<Node>`.
> +            node: unsafe { Box::from_raw(raw as _) },
> +        };
> +        // SAFETY: Although the type is `MaybeUninit<Node>`, we know it =
has been initialised
> +        // because it came from a `Node`. So it is safe to drop it.
> +        unsafe { core::ptr::drop_in_place(ret.node.as_mut_ptr()) };
> +        ret
> +    }
> +}
> +
> +/// A view into a single entry in a map, which may either be vacant or o=
ccupied.
> +///
> +/// This enum is constructed from the [`entry`] method on [`RBTree`].
> +///
> +/// [`entry`]: fn@RBTree::entry
> +pub enum Entry<'a, K, V> {
> +    /// This [`RBTree`] does not have a node with this key.
> +    Vacant(VacantEntry<'a, K, V>),
> +    /// This [`RBTree`] already has a node with this key.
> +    Occupied(OccupiedEntry<'a, K, V>),
> +}
> +
> +/// Like [`Entry`], except that it doesn't have ownership of the key.
> +enum RawEntry<'a, K, V> {
> +    Vacant(RawVacantEntry<'a, K, V>),
> +    Occupied(OccupiedEntry<'a, K, V>),
> +}
> +
> +/// A view into a vacant entry in a [`RBTree`]. It is part of the [`Entr=
y`] enum.
> +pub struct VacantEntry<'a, K, V> {
> +    key: K,
> +    raw: RawVacantEntry<'a, K, V>,
> +}
> +
> +/// Like [`VacantEntry`], but doesn't hold on to the key.
> +struct RawVacantEntry<'a, K, V> {
> +    rbtree: &'a mut RBTree<K, V>,
> +    /// The node that will become the parent of the new node if we inser=
t one.
> +    ///
> +    /// This pointer may be null if the new node becomes the root.
> +    parent: *mut bindings::rb_node,
> +    /// This points to the left-child or right-child field of `parent`. =
This controls whether the
> +    /// new node will become the left or right child of `parent`.
> +    ///
> +    /// If `parent` is null, then this points at `rbtree.root`.

These constraints should be type invariants.

> +    new_link: *mut *mut bindings::rb_node,
> +}
> +
> +impl<'a, K, V> RawVacantEntry<'a, K, V> {
> +    /// Inserts the given node into the [`RBTree`] at this entry.
> +    ///
> +    /// The `node` must have a key such that inserting it here does not =
break the ordering of this
> +    /// [`RBTree`].
> +    fn insert(self, node: RBTreeNode<K, V>) -> &'a mut V {
> +        let node =3D Box::into_raw(node.node);
> +
> +        // SAFETY: `node` is valid at least until we call `Box::from_raw=
`, which only happens when
> +        // the node is removed or replaced.
> +        let node_links =3D unsafe { addr_of_mut!((*node).links) };
> +
> +        // INVARIANT: We are linking in a new node, which is valid. It r=
emains valid because we
> +        // "forgot" it with `Box::into_raw`.
> +        // SAFETY: All pointers are null or valid in an appropriate way.
> +        unsafe { bindings::rb_link_node(node_links, self.parent, self.ne=
w_link) };
> +
> +        // SAFETY: All pointers are valid. `node` has just been inserted=
 into the tree.
> +        unsafe { bindings::rb_insert_color(node_links, &mut self.rbtree.=
root) };
> +
> +        // SAFETY: The node is valid until we remove it from the tree.
> +        unsafe { &mut (*node).value }
> +    }
> +}
> +
> +impl<'a, K, V> VacantEntry<'a, K, V> {
> +    /// Inserts the given node into the [`RBTree`] at this entry.
> +    pub fn insert(self, value: V, reservation: RBTreeNodeReservation<K, =
V>) -> &'a mut V {
> +        self.raw.insert(reservation.into_node(self.key, value))
> +    }
> +}
> +
> +/// A view into an occupied entry in a [`RBTree`]. It is part of the [`E=
ntry`] enum.
> +pub struct OccupiedEntry<'a, K, V> {
> +    rbtree: &'a mut RBTree<K, V>,
> +    /// The node that this entry corresponds to. Non null.

Must this pointer also be valid? This should be an invariant.

> +    node_links: *mut bindings::rb_node,
> +}
> +
> +impl<'a, K, V> OccupiedEntry<'a, K, V> {
> +    fn node_ptr(&self) -> *mut Node<K, V> {
> +        // SAFETY: All links fields we create are in a `Node<K, V>`.
> +        unsafe { crate::container_of!(self.node_links, Node<K, V>, links=
) }.cast_mut()
> +    }
> +
> +    /// Gets a reference to the value in the entry.
> +    pub fn get(&self) -> &V {
> +        unsafe { &(*self.node_ptr()).value }

Missing SAFETY comment.

> +    }
> +
> +    /// Gets a mutable reference to the value in the entry.
> +    pub fn get_mut(&mut self) -> &mut V {
> +        unsafe { &mut (*self.node_ptr()).value }

Ditto.

> +    }
> +
> +    /// Converts the entry into a mutable reference to its value.
> +    ///
> +    /// If you need multiple references to the `OccupiedEntry`, see [`se=
lf#get_mut`].
> +    pub fn into_mut(self) -> &'a mut V {
> +        unsafe { &mut (*self.node_ptr()).value }

Ditto.

> +    }
> +
> +    /// Remove this entry from the [`RBTree`].
> +    pub fn remove_node(self) -> RBTreeNode<K, V> {
> +        // SAFETY: The node is a node in the tree, so it is valid.
> +        unsafe { bindings::rb_erase(self.node_links, &mut self.rbtree.ro=
ot) };
> +
> +        // INVARIANT: The node is being returned and the caller may free=
 it, however, it was
> +        // removed from the tree. So the invariants still hold.
> +        RBTreeNode {
> +            // SAFETY: The node was a node in the tree, but we removed i=
t, so we can convert it
> +            // back into a box.
> +            node: unsafe { Box::from_raw(self.node_ptr()) },
> +        }
> +    }
> +
> +    /// Takes the value of the entry out of the map, and returns it.
> +    pub fn remove(self) -> V {
> +        self.remove_node().node.value
> +    }
> +
> +    /// Swap the current node for the provided node.
> +    ///
> +    /// The key of both nodes must be equal.
> +    fn replace(self, node: RBTreeNode<K, V>) -> RBTreeNode<K, V> {
> +        let node =3D Box::into_raw(node.node);
> +
> +        // SAFETY: `node` is valid at least until we call `Box::from_raw=
`, which only happens when
> +        // the node is removed or replaced.
> +        let new_node_links =3D unsafe { addr_of_mut!((*node).links) };
> +
> +        // SAFETY: This updates the pointers so that `new_node_links` is=
 in the tree where
> +        // `self.node_links` used to be.
> +        unsafe {
> +            bindings::rb_replace_node(self.node_links, new_node_links, &=
mut self.rbtree.root)
> +        };
> +
> +        // SAFETY: Now that we removed this entry from the tree, we can =
convert the node to a box.

This comment does not explain why `self.node_ptr()` is a valid pointer.

--=20
Cheers,
Benno

> +        let old_node =3D unsafe { Box::from_raw(self.node_ptr()) };
> +
> +        RBTreeNode { node: old_node }
> +    }
> +}
>=20
> --
> 2.44.0.rc0.258.g7320e95886-goog
>=20


