Return-Path: <linux-kernel+bounces-159318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 086B88B2D04
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3576B25744
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61DD155398;
	Thu, 25 Apr 2024 22:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ezHuqltE"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFE012BF28;
	Thu, 25 Apr 2024 22:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714083637; cv=none; b=pXbvGx1/cZsnVLrZ3oNehUm9PrjegRRpbgVhMDBYzRKc/gqup3Vz2FxQ5oFFshMS6JxbOQPmx0qgA8cG563myHOrkxvVwR3rYrRV7gc7hXB4Ap4xPysQzvSdYjBdLwT3ai5FN1UDZ8di+19ZAwPQ0HhLconQzZIrE4GvxGj2Osw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714083637; c=relaxed/simple;
	bh=eFXnJkqs/cZiDYAJ2loxQUSzW4V0P2cEE6ve4E8dmF4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SiiQnHceLQRReqFbcZ05KjG8Y0lau/ax3deU/qpCn0IdyYJ6tpf3EcZ1UGwMpdX3Snb507h+R6s6ETWvvWI4EkwldxtBZtQcB1IQPVUG3VM/axhwTyOfvExyV3PzoQfyZghwGnX6BRtmEsPa3U2J5NdOQeOufQ+25UUHdtgIKWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ezHuqltE; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=4r5jppq7xja7vc4akxf5zkw5dy.protonmail; t=1714083632; x=1714342832;
	bh=x8XINNQlG+ME5cqW30DA+XLIbTnCIlyS+hje8cQijCY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ezHuqltEwrYYavslXKaCmlxFY3aV3bFVSDrsvufzjrmJCGOP/w0guX3UeliENgZ8V
	 wydICZit57EokMAo6gdLmzo+7aj7hwoB/6kOdTv7z6ZkA+3+/zKF9c8F4JQswhmE1l
	 N6JQnMVGcGDUbJILEsz7VjrnzkdL7PNS/9N5RSMi/SbKwPQyni0fnIAvq7S9Xjj9IJ
	 nvHAV9AVESPl7b1f0SdVVSx5+zfO94/GGwbU/CkJ6z9Zw+1P0zZLJ8PVLkwHcDN9BX
	 oypalv7RVcZtGkEZnpUpvKcFmW0IxsHkCt9J5IZiRyJ2n0LfAnyqOn9v1ktm+/oq9v
	 BiBOMy300lnFw==
Date: Thu, 25 Apr 2024 22:20:27 +0000
To: Matt Gilbride <mattgilbride@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] rust: rbtree: add `RBTreeCursor`
Message-ID: <1af2f75d-4f5d-408e-9ce7-8a3671cc0962@proton.me>
In-Reply-To: <20240418-b4-rbtree-v3-4-323e134390ce@google.com>
References: <20240418-b4-rbtree-v3-0-323e134390ce@google.com> <20240418-b4-rbtree-v3-4-323e134390ce@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 96f4001a6063c079d1feb633337affe829918d02
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.04.24 16:15, Matt Gilbride wrote:
> @@ -400,6 +442,72 @@ fn remove_node(&mut self, key: &K) -> Option<RBTreeN=
ode<K, V>> {
>      pub fn remove(&mut self, key: &K) -> Option<V> {
>          self.remove_node(key).map(|node| node.node.value)
>      }
> +
> +    /// Returns a cursor over the tree nodes based on the given key.
> +    ///
> +    /// If the given key exists, the cursor starts there.
> +    /// Otherwise it starts with the first larger key in sort order.
> +    /// If there is no larger key, it returns [`None`].
> +    pub fn cursor_lower_bound(&mut self, key: &K) -> Option<RBTreeCursor=
<'_, K, V>>
> +    where
> +        K: Ord,
> +    {
> +        let mut node =3D self.root.rb_node;
> +        let mut best_match: Option<NonNull<Node<K, V>>> =3D None;
> +        while !node.is_null() {
> +            // SAFETY: By the type invariant of `Self`, all non-null `rb=
_node` pointers stored in `self`
> +            // point to the links field of `Node<K, V>` objects.
> +            let this =3D unsafe { container_of!(node, Node<K, V>, links)=
 }.cast_mut();
> +            // SAFETY: `this` is a non-null node so it is valid by the t=
ype invariants.
> +            let this_key =3D unsafe { &(*this).key };
> +            // SAFETY: `node` is a non-null node so it is valid by the t=
ype invariants.
> +            let left_child =3D unsafe { (*node).rb_left };
> +            // SAFETY: `node` is a non-null node so it is valid by the t=
ype invariants.
> +            let right_child =3D unsafe { (*node).rb_right };

Since you have this pattern multiple times, I think you could have a
single function that walks the tree and takes care of most of the
`unsafe` stuff. A good starting point might be this:

     unsafe fn walk<F, R>(node: *mut bindings::rb_node, dir: F) -> R
     where
                /*     this,             key */
         F: FnMut(*mut bindings::rb_node, &K) -> Either<Direction, R>;

> +            if key =3D=3D this_key {
> +                // INVARIANT:
> +                // - `self.root` and `node` are valid pointers.
> +                // - `self.root` is the root of an [`RBTree`].
> +                // - `node` is a valid node in an [`RBTree`].
> +                // - Due to the type signature of this function, the ret=
urned [`RBTreeCursor`]
> +                //   borrows from `self`.
> +                return Some(RBTreeCursor {
> +                    _tree: PhantomData,
> +                    root: addr_of_mut!(self.root),
> +                    current: node,
> +                });
> +            } else {
> +                node =3D if key > this_key {
> +                    right_child
> +                } else {
> +                    let is_better_match =3D match best_match {
> +                        None =3D> true,
> +                        Some(best) =3D> {
> +                            // SAFETY: `best` is a non-null node so it i=
s valid by the type invariants.
> +                            let best_key =3D unsafe { &(*best.as_ptr()).=
key };
> +                            best_key > this_key
> +                        }
> +                    };
> +                    if is_better_match {
> +                        best_match =3D NonNull::new(this);
> +                    }
> +                    left_child
> +                }
> +            };
> +        }
> +        // INVARIANT:
> +        // - `self.root` and `best` are valid pointers.
> +        // - `self.root` is the root of an [`RBTree`].
> +        // - `best` is a valid node in an [`RBTree`].
> +        // - Due to the type signature of this function, the returned [`=
RBTreeCursor`]
> +        //   borrows from `self`.
> +        best_match.map(|best| RBTreeCursor {
> +            _tree: PhantomData,
> +            root: addr_of_mut!(self.root),
> +            // SAFETY: `best` is a non-null node so it is valid by the t=
ype invariants.
> +            current: unsafe { addr_of_mut!((*best.as_ptr()).links) },
> +        })
> +    }
>  }
>=20
>  impl<K, V> Default for RBTree<K, V> {

[...]

> +/// # Invariants
> +/// - `root` and `current` are valid pointers.
> +/// - `root` points to the `root` node of an [`RBTree`].
> +/// - `current` points to a node that is in the same [`RBTree`] that `ro=
ot` is pointing to.
> +/// - A cursor must borrow the [`RBTree`] containing `root` and `current=
` mutably.
> +pub struct RBTreeCursor<'a, K, V> {
> +    _tree: PhantomData<&'a RBTree<K, V>>,

Why is this not `&'a mut RBTree<K, V>`?

> +    root: *mut bindings::rb_root,
> +    current: *mut bindings::rb_node,
> +}
> +
> +// SAFETY: The [`RBTreeCursor`] gives out immutable references to K and =
mutable references to V,
> +// so it has the same thread safety requirements as mutable references.
> +unsafe impl<'a, K: Send, V: Send> Send for RBTreeCursor<'a, K, V> {}
> +
> +// SAFETY: The [`RBTreeCursor`] gives out immutable references to K and =
mutable references to V,
> +// so it has the same thread safety requirements as mutable references.
> +unsafe impl<'a, K: Sync, V: Sync> Sync for RBTreeCursor<'a, K, V> {}
> +
> +impl<'a, K, V> RBTreeCursor<'a, K, V> {
> +    /// The current node
> +    pub fn current(&self) -> (&K, &V) {
> +        // SAFETY:
> +        // - `self.current` is a valid node by the type invariants.
> +        // - We have an immutable reference by the function signature.
> +        unsafe { Self::to_key_value(self.current) }
> +    }
> +
> +    /// The current node, with a mutable value
> +    pub fn current_mut(&mut self) -> (&K, &mut V) {
> +        // SAFETY:
> +        // - `self.current` is a valid node by the type invariants.
> +        // - We have an mutable reference by the function signature.
> +        unsafe { Self::to_key_value_mut(self.current) }
> +    }
> +
> +    /// Remove the current node from the tree.
> +    ///
> +    /// Returns a cursor to the next node, if it exists,
> +    /// else the previous node. Returns [`None`] if the tree
> +    /// becomes empty.
> +    pub fn remove_current(self) -> Option<Self> {
> +        let prev =3D self.get_neighbor_raw(Direction::Prev);
> +        let next =3D self.get_neighbor_raw(Direction::Next);
> +        // SAFETY: By the type invariant of `Self`, all non-null `rb_nod=
e` pointers stored in `self`
> +        // point to the links field of `Node<K, V>` objects.
> +        let this =3D unsafe { container_of!(self.current, Node<K, V>, li=
nks) }.cast_mut();
> +        // SAFETY: The reference to the tree used to create the cursor o=
utlives the cursor, so
> +        // the tree cannot change. By the tree invariant, all nodes are =
valid.
> +        unsafe { bindings::rb_erase(&mut (*this).links, self.root) };
> +
> +        let current =3D match (prev, next) {
> +            (_, Some(next)) =3D> next,
> +            (Some(prev), None) =3D> prev,
> +            (None, None) =3D> {
> +                return None;
> +            }
> +        };
> +
> +        // INVARIANT:
> +        // - `self.root` and `current` are valid pointers.
> +        // - `self.root` is the root of an [`RBTree`].
> +        // - `current` is a valid node in an [`RBTree`].
> +        // - Due to the function signature, `self` is an owned [`RBTreeC=
ursor`],
> +        //   and [`RBTreeCursor`]s are only created via functions with a=
 mutable reference
> +        //   to an [`RBTree`].
> +        Some(Self {
> +            current,
> +            _tree: self._tree,
> +            root: self.root,
> +        })
> +    }
> +
> +    /// Remove the previous node, returning it if it exists.
> +    pub fn remove_prev(&mut self) -> Option<(K, V)> {

Why do these functions not return `Option<RBTreeNode<K, V>>`?

> +        self.remove_neighbor(Direction::Prev)
> +    }
> +
> +    /// Remove the next node, returning it if it exists.
> +    pub fn remove_next(&mut self) -> Option<(K, V)> {
> +        self.remove_neighbor(Direction::Next)
> +    }
> +
> +    fn remove_neighbor(&mut self, direction: Direction) -> Option<(K, V)=
> {
> +        if let Some(neighbor) =3D self.get_neighbor_raw(direction) {
> +            // SAFETY: The reference to the tree used to create the curs=
or outlives the cursor, so
> +            // the tree cannot change. By the tree invariant, all nodes =
are valid.
> +            unsafe { bindings::rb_erase(neighbor, self.root) };
> +            // SAFETY: By the type invariant of `Self`, all non-null `rb=
_node` pointers stored in `self`
> +            // point to the links field of `Node<K, V>` objects.
> +            let this =3D unsafe { container_of!(neighbor, Node<K, V>, li=
nks) }.cast_mut();
> +            // SAFETY: `this` is valid by the type invariants as describ=
ed above.
> +            let n =3D unsafe { Box::from_raw(this) };
> +            return Some((n.key, n.value));
> +        }
> +        None
> +    }
> +
> +    /// Move the cursor to the previous node, returning [`None`] if it d=
oesn't exist.
> +    pub fn move_prev(self) -> Option<Self> {
> +        self.mv(Direction::Prev)
> +    }
> +
> +    /// Move the cursor to the next node, returning [`None`] if it doesn=
't exist.
> +    pub fn move_next(self) -> Option<Self> {
> +        self.mv(Direction::Next)
> +    }
> +
> +    fn mv(self, direction: Direction) -> Option<Self> {

Does it hurt to name this `move`?

> +        // INVARIANT:
> +        // - `self.root` and `neighbor` are valid pointers.
> +        // - `self.root` is the root of an [`RBTree`].
> +        // - `neighbor` is a valid node in an [`RBTree`].
> +        // - Due to the function signature, `self` is an owned [`RBTreeC=
ursor`],
> +        //   and [`RBTreeCursor`]s are only created via functions with a=
 mutable reference
> +        //   to an [`RBTree`].
> +        self.get_neighbor_raw(direction).map(|neighbor| Self {
> +            _tree: self._tree,
> +            root: self.root,
> +            current: neighbor,
> +        })
> +    }

[...]

> +    /// SAFETY:
> +    /// - `node` must be a valid pointer to a node in an [`RBTree`].
> +    /// - The caller has immutable access to `node` for the duration of =
'a.
> +    unsafe fn to_key_value(node: *mut bindings::rb_node) -> (&'a K, &'a =
V) {
> +        // SAFETY: By the type invariant of `Self`, all non-null `rb_nod=
e` pointers stored in `self`
> +        // point to the links field of `Node<K, V>` objects.
> +        let this =3D unsafe { container_of!(node, Node<K, V>, links) };
> +        // SAFETY: The passed `node` is the current node or a non-null n=
eighbor,
> +        // thus `this` is valid by the type invariants.
> +        let k =3D unsafe { &(*this).key };
> +        // SAFETY: The passed `node` is the current node or a non-null n=
eighbor,
> +        // thus `this` is valid by the type invariants.
> +        let v =3D unsafe { &(*this).value };
> +        (k, v)
> +    }
> +
> +    /// SAFETY:
> +    /// - `node` must be a valid pointer to a node in an [`RBTree`].
> +    /// - The caller has mutable access to `node` for the duration of 'a=
.
> +    unsafe fn to_key_value_mut(node: *mut bindings::rb_node) -> (&'a K, =
&'a mut V) {
> +        // SAFETY: By the type invariant of `Self`, all non-null `rb_nod=
e` pointers stored in `self`
> +        // point to the links field of `Node<K, V>` objects.
> +        let this =3D unsafe { container_of!(node, Node<K, V>, links) }.c=
ast_mut();
> +        // SAFETY: The passed `node` is the current node or a non-null n=
eighbor,
> +        // thus `this` is valid by the type invariants.
> +        let k =3D unsafe { &(*this).key };
> +        // SAFETY: The passed `node` is the current node or a non-null n=
eighbor,
> +        // thus `this` is valid by the type invariants.
> +        let v =3D unsafe { &mut (*this).value };
> +        (k, v)
> +    }

You can create a single function that does the `container_of!` stuff and
that returns `(*mut K, *mut V)` and implement these two in terms of that
one.

--=20
Cheers,
Benno

> +}
> +
> +/// Direction for [`RBTreeCursor`] operations.
> +enum Direction {
> +    /// the node immediately before, in sort order
> +    Prev,
> +    /// the node immediately after, in sort order
> +    Next,
> +}
> +
>  impl<'a, K, V> IntoIterator for &'a RBTree<K, V> {
>      type Item =3D (&'a K, &'a V);
>      type IntoIter =3D RBTreeIterator<'a, K, V>;
>=20
> --
> 2.44.0.769.g3c40516874-goog
>=20



