Return-Path: <linux-kernel+bounces-130136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A7D897483
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64671F2875E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B47514A631;
	Wed,  3 Apr 2024 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="a4SGYtwi"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9222D146A96;
	Wed,  3 Apr 2024 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159514; cv=none; b=Sk+apQFCpyUn4esQVTpwW6glmiTTdM7w0cIZeNYP7Epljnj4jlVeyV8ZUaHpotBL55ogAVlQHin2kmGCfKuniwM32jWvZ5JBny6Lyv8vPe06bT1ppwV5OVP4mQHP7GVxe9ShZ1NTKpyWIpfZPTlOcPZZbmsDFrvnFaKIgT9Ypxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159514; c=relaxed/simple;
	bh=wOtVDkDP5TIIgmnuGlntttCWA3GnSxnAWVJEuBaypkw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OtiHsKHTSsX8k1Jseap+FrpOZXuKg64+TjfjPMeMggafC0o/Q27ZBUmLKa49GtMP++RTJUQVGDOBYY66Wmz3UwFsr2hskkHE+UJOYYE9gU98sB5LuGxQrjew70dBIzlZ4HU6LGfBMXau/U9jKk8hOdCTlL2XV+vJ2bUvHJj++24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=a4SGYtwi; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712159508; x=1712418708;
	bh=UW23mqUm97ijKHcnsCqAhKuKRDp8kBhzeRwm31J4K/E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=a4SGYtwiY6BXaeQNZkqHurT+AkVChaN1RMlIRu+oPuTJ9UvfV22vAs953oSyDuVgo
	 sSsk9CS4xQlq2z3RrXf/aXnP9djkNLaWtS4+z5h7nVkfQTgRwcfBGe4loJiMs7z74S
	 DE8/LPB5jTFt9BR/xhCAnR3D1l4GNSWbjG74PLFw7ZIpPXNj/9i5uIkok+rFwJO0XU
	 ODnThcf8N/S3rVxPO3qTRg5A9DTpb0ZwpOfzWXrqMdbet1Ztwf8h8JGcs3OD7orzWy
	 CksfvKS64XwVcBpwheqG6CRfqBshxTK1eA+vkcsYNTImlnaJRzoxI6GxbtDLzOX+t8
	 clMNPE9Zom7iQ==
Date: Wed, 03 Apr 2024 15:51:42 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/9] rust: list: add ListArc
Message-ID: <2f25f21e-fad8-48bb-aa2b-d61bf8909a41@proton.me>
In-Reply-To: <20240402-linked-list-v1-1-b1c59ba7ae3b@google.com>
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com> <20240402-linked-list-v1-1-b1c59ba7ae3b@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.04.24 14:16, Alice Ryhl wrote:
> +impl<T: ListArcSafe<ID>, const ID: u64> ListArc<T, ID> {
> +    /// Constructs a new reference counted instance of `T`.
> +    pub fn try_new(contents: T) -> Result<Self, AllocError> {
> +        Ok(Self::from_unique(UniqueArc::try_new(contents)?))
> +    }
> +
> +    /// Use the given initializer to in-place initialize a `T`.
> +    ///
> +    /// If `T: !Unpin` it will not be able to move afterwards.
> +    pub fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Self>
> +    where
> +        Error: From<E>,
> +    {
> +        Ok(Self::from_pin_unique(UniqueArc::pin_init(init)?))
> +    }

pin-init has a general trait for this: InPlaceInit. I don't know if the
other functions that it provides would help you.

> +}
> +
> +impl<T, const ID: u64> ListArc<T, ID>
> +where
> +    T: ListArcSafe<ID> + ?Sized,
> +{
> +    /// Convert a [`UniqueArc`] into a [`ListArc`].
> +    pub fn from_unique(mut unique: UniqueArc<T>) -> Self {
> +        // SAFETY: We have a `UniqueArc`, so there is no `ListArc`.
> +        unsafe { T::on_create_list_arc_from_unique(&mut unique) };
> +        let arc =3D Arc::from(unique);
> +        // SAFETY: We just called `on_create_list_arc_from_unique` on an=
 arc without a `ListArc`,
> +        // so we can create a `ListArc`.
> +        unsafe { Self::transmute_from_arc(arc) }
> +    }
> +
> +    /// Convert a pinned [`UniqueArc`] into a [`ListArc`].
> +    pub fn from_pin_unique(unique: Pin<UniqueArc<T>>) -> Self {
> +        // SAFETY: We continue to treat this pointer as pinned after thi=
s call, since `ListArc`
> +        // implicitly pins its value.

This is not sufficient, since you also rely on `Self::from_unique` to
handle the parameter as if it were pinned, which it does not. Since it
calls `T::on_create_list_arc_from_unique` which just gets a `&mut self`
as a parameter and it could move stuff out.

> +        Self::from_unique(unsafe { Pin::into_inner_unchecked(unique) })
> +    }
> +
> +    /// Like [`from_unique`], but creates two `ListArcs`.
> +    ///
> +    /// The two ids must be different.
> +    ///
> +    /// [`from_unique`]: ListArc::from_unique
> +    pub fn pair_from_unique<const ID2: u64>(mut unique: UniqueArc<T>) ->=
 (Self, ListArc<T, ID2>)
> +    where
> +        T: ListArcSafe<ID2>,
> +    {
> +        assert_ne!(ID, ID2);

Can this be a `build_assert!`?

> +
> +        // SAFETY: We have a `UniqueArc`, so we can call this method.

I liked the comment from above better:

     // SAFETY: We have a `UniqueArc`, so there is no `ListArc`.

Maybe use the variation "so there are no `ListArc`s for any ID.".

> +        unsafe { <T as ListArcSafe<ID>>::on_create_list_arc_from_unique(=
&mut unique) };
> +        // SAFETY: We have a `UniqueArc`, so we can call this method. Th=
e two ids are not equal.
> +        unsafe { <T as ListArcSafe<ID2>>::on_create_list_arc_from_unique=
(&mut unique) };
> +
> +        let arc1 =3D Arc::from(unique);
> +        let arc2 =3D Arc::clone(&arc1);
> +
> +        // SAFETY: We just called `on_create_list_arc_from_unique` on an=
 arc without a `ListArc`,
> +        // so we can create a `ListArc`.

I would mention the two different IDs again.

> +        unsafe {
> +            (
> +                Self::transmute_from_arc(arc1),
> +                ListArc::transmute_from_arc(arc2),
> +            )
> +        }
> +    }
> +
> +    /// Like [`pair_from_unique`], but uses a pinned arc.
> +    ///
> +    /// The two ids must be different.
> +    ///
> +    /// [`pair_from_unique`]: ListArc::pair_from_unique
> +    pub fn pair_from_pin_unique<const ID2: u64>(
> +        unique: Pin<UniqueArc<T>>,
> +    ) -> (Self, ListArc<T, ID2>)
> +    where
> +        T: ListArcSafe<ID2>,
> +    {
> +        // SAFETY: We continue to treat this pointer as pinned after thi=
s call, since `ListArc`
> +        // implicitly pins its value.
> +        Self::pair_from_unique(unsafe { Pin::into_inner_unchecked(unique=
) })
> +    }
> +
> +    /// Transmutes an [`Arc`] into a `ListArc` without updating the trac=
king inside `T`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * The value must not already have a `ListArc` reference.
> +    /// * The tracking inside `T` must think that there is a `ListArc` r=
eference.
> +    #[inline]
> +    unsafe fn transmute_from_arc(me: Arc<T>) -> Self {
> +        // INVARIANT: By the safety requirements, the invariants on `Lis=
tArc` are satisfied.
> +        // SAFETY: ListArc is repr(transparent).
> +        unsafe { core::mem::transmute(me) }

Why do you need a transmute here? Can't you just construct the struct?

     Self { arc: me }

--=20
Cheers,
Benno

> +    }
> +


