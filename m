Return-Path: <linux-kernel+bounces-103566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0494C87C134
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C131C21775
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69E573181;
	Thu, 14 Mar 2024 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="glEsPaJa"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FEB5D74C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710433482; cv=none; b=WWLZQkJC/XSb5A+u0GfaeKSNohEXjJgJiJ5ePCz8F23p1XLitOmXfipGbzB5eXSA6K5MDNZFlP880UD7B00fr+WWdyJwg7RIc4Kk+uWta5TOaazJcEQRwmR6kaRVBKwk5gsXpJC0o/pXQIY2JBmmNfPNQOODDxVlFu/mEVFKcIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710433482; c=relaxed/simple;
	bh=paQCo9lpiP6kOLc1/HV9mO/b3xfvpnDtdbn/vBXj3hs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iWmHkhXQSXVwEYUkkdGqjoatjlw3U4A2vcgVy/f3fcj1BBR9UaOfn7VcBnJ3RUoGbF2rsD/D73CFh6ZFaL0/u5RGp2T5mCzveWKltK0WlZdts4piLCNu0SY2rGKG1uLt8VjOJ6oosybjtiAOwpt7s8EmmBTpp4rqu3tGBHvMkRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=glEsPaJa; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1710433476; x=1710692676;
	bh=Jd4nfT5gXP3CYGNG45QfWm+S59cKf0dh995GCAX2/EY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=glEsPaJaRFumXfpPsaE8DeR1JXfODs1SHNGgMQN3rcvU0z4EauyHgYsvrQSL/yQxp
	 uOCDytDgmrlbaE8vJdYthT8/hV20PBpF6vOeHwbjbFSNH/N+t4BlINBY/386QOM10p
	 D1SzJvCR9c2D0ejDzMWm4c6SK6htO4XuAcvP4217zF2VCFIKpj6l0sTuY+hUqSEo/m
	 J+2z2uZTS+VD0Zj6wgsOCJUV9j60P6aTTHFGZ/jukK1r2OxmDIZ5glStvPzIGvTVYL
	 kFtHJDwSg9TStNmeQ0usGfWXtP3P9c9RXZ7OMui8e26rXE+x33aTyq60fKRnSmkGF/
	 GIn5BYu0dGSPA==
Date: Thu, 14 Mar 2024 16:24:23 +0000
To: Matt Gilbride <mattgilbride@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] rust: rbtree: add `RBTreeIterator`
Message-ID: <00178dbe-6dfc-48f5-9712-b0b7361d14e4@proton.me>
In-Reply-To: <20240219-b4-rbtree-v2-3-0b113aab330d@google.com>
References: <20240219-b4-rbtree-v2-0-0b113aab330d@google.com> <20240219-b4-rbtree-v2-3-0b113aab330d@google.com>
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
> @@ -350,6 +393,52 @@ fn drop(&mut self) {
>       }
>   }
>=20
> +impl<'a, K, V> IntoIterator for &'a RBTree<K, V> {
> +    type Item =3D (&'a K, &'a V);
> +    type IntoIter =3D RBTreeIterator<'a, K, V>;
> +
> +    fn into_iter(self) -> Self::IntoIter {
> +        self.iter()
> +    }
> +}
> +
> +/// An iterator over the nodes of a [`RBTree`].
> +///
> +/// Instances are created by calling [`RBTree::iter`].

There probably should be some invariants here, like
- `self.next` is a valid pointer
- `self.next` points to a node stored inside of a valid `RBtree`

> +pub struct RBTreeIterator<'a, K, V> {
> +    _tree: PhantomData<&'a RBTree<K, V>>,
> +    next: *mut bindings::rb_node,
> +}
> +
> +// SAFETY: An [`RBTree`] allows the same kinds of access to its values t=
hat a struct allows to its
> +// fields, so we use the same Send condition as would be used for a stru=
ct with K and V fields.
> +unsafe impl<'a, K: Send, V: Send> Send for RBTreeIterator<'a, K, V> {}
> +
> +// SAFETY: An [`RBTree`] allows the same kinds of access to its values t=
hat a struct allows to its
> +// fields, so we use the same Sync condition as would be used for a stru=
ct with K and V fields.
> +unsafe impl<'a, K: Sync, V: Sync> Sync for RBTreeIterator<'a, K, V> {}

These comments should also be updated.

> +
> +impl<'a, K, V> Iterator for RBTreeIterator<'a, K, V> {
> +    type Item =3D (&'a K, &'a V);
> +
> +    fn next(&mut self) -> Option<Self::Item> {
> +        if self.next.is_null() {
> +            return None;
> +        }
> +
> +        // SAFETY: All links fields we create are in a `Node<K, V>`.

See my suggestion on patch 2.

> +        let cur =3D unsafe { crate::container_of!(self.next, Node<K, V>,=
 links) };
> +
> +        // SAFETY: The reference to the tree used to create the iterator=
 outlives the iterator, so
> +        // the tree cannot change. By the tree invariant, all nodes are =
valid.

Why does the pointer come from a tree to begin with? (ie you need the
invariants I stated above)

--=20
Cheers,
Benno

> +        self.next =3D unsafe { bindings::rb_next(self.next) };
> +
> +        // SAFETY: By the same reasoning above, it is safe to dereferenc=
e the node. Additionally,
> +        // it is ok to return a reference to members because the iterato=
r must outlive it.
> +        Some(unsafe { (&(*cur).key, &(*cur).value) })
> +    }
> +}
> +
>   /// A memory reservation for a red-black tree node.
>   ///
>   /// It contains the memory needed to hold a node that can be inserted i=
nto a red-black tree. One
>=20
> --
> 2.44.0.rc0.258.g7320e95886-goog
>=20


