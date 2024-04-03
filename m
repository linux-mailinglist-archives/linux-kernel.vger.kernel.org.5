Return-Path: <linux-kernel+bounces-130139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1652C897489
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399711C27895
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E2514AD16;
	Wed,  3 Apr 2024 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="PvdkV5kN"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE1114AD04;
	Wed,  3 Apr 2024 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159575; cv=none; b=kD3isNOpz1GXD1XDQZr1aupZ2VgKSeblqR5uHF+6wo/tyQqdMWYR8bHPAZZsNpH9vh6ccxoM5kSKbDxdpyxgtCVslCPwNgNLfKHFHbv/iK9drldbWe89Ri4dErWPTR8ltdvLdnf3KE4ppUDzYrwI8QBWk3HodyrPnCbT+O5DloM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159575; c=relaxed/simple;
	bh=/vZX2get8gvrEKmp5nQhazHtD6ekfyGqU9MLUrfMpH8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KrRQE7Ceka9tlEXy6qy4T/d3C6lzClBN5RL7oEpQOJU1tSbj/qV2PsB99g086C7EuCqzjdila88hEHtfD1C/+ZGIcjU8HLfzzXJwYq5Gt9mJwSZmvS1yFLm6VvNqZSRI9TK1uIIOMTTIblG7MqZGxkfxhFoP1M9aSpkHdpvdjEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=PvdkV5kN; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712159569; x=1712418769;
	bh=LEM29//9PWH9+2k8SgrjQzlMlVMJZcFkdCQis3k3reQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PvdkV5kNtHJJBOipgvrD3z+DNffsZR6IVqpZHOSc9EIbPWb4pRokHhh5n9l6DY7+E
	 YEqNFAhpyOy4ZfAEKJVWnuj1q7LhmXWtgqf7BTy97a3QkZsX2mEbqICfeJgyzmJ+g4
	 mZpvRZpHLF+YXpaRgSJcnfsWujAPWxjoIAeIMLiAmZMU/jHSqhTkVRVbIQ89XwZyE7
	 f1tlIFCsaSMWLks0/OZ45FkHFkBadm6UReCBzEvIxcCTTMOjhfH5SjORrEwv/foLvr
	 ZxFP54IGolbJa10O+va2oNYTtVLN/NSeyex7uNi7hikbrYlpeBHyDjEVYBSpCD/1/R
	 8b9OumxApYDHA==
Date: Wed, 03 Apr 2024 15:52:45 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/9] rust: list: add tracking for ListArc
Message-ID: <36306930-0390-4342-830d-03c11ec4a3a7@proton.me>
In-Reply-To: <20240402-linked-list-v1-2-b1c59ba7ae3b@google.com>
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com> <20240402-linked-list-v1-2-b1c59ba7ae3b@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I think the commit one-line description sounds a bit strange, how about
"rust: list: add ListArc tracking strategies"?

On 02.04.24 14:16, Alice Ryhl wrote:
> @@ -33,19 +34,64 @@ pub trait ListArcSafe<const ID: u64 =3D 0> {
>      unsafe fn on_drop_list_arc(&self);
>  }
>=20
> +/// Declares that this type is able to safely attempt to create `ListArc=
`s at any time.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that `try_new_list_arc` does not return `tr=
ue` if a `ListArc` already
> +/// exists.
> +pub unsafe trait TryNewListArc<const ID: u64 =3D 0>: ListArcSafe<ID> {
> +    /// Attempts to convert an `Arc<Self>` into an `ListArc<Self>`. Retu=
rns `true` if the
> +    /// conversion was successful.
> +    fn try_new_list_arc(&self) -> bool;
> +}
> +
>  /// Declares that this type supports [`ListArc`].
>  ///
> -/// When using this macro, it will only be possible to create a [`ListAr=
c`] from a [`UniqueArc`].
> +/// When using this macro, you may choose between the `untracked` strate=
gy where it is not tracked
> +/// whether a [`ListArc`] exists, and the `tracked_by` strategy where th=
e tracking is deferred to a
> +/// field of the struct. The `tracked_by` strategy can be combined with =
a field of type
> +/// [`AtomicListArcTracker`] to track whether a [`ListArc`] exists.
>  #[macro_export]
>  macro_rules! impl_list_arc_safe {
>      (impl$({$($generics:tt)*})? ListArcSafe<$num:tt> for $t:ty { untrack=
ed; } $($rest:tt)*) =3D> {
> -        impl$(<$($generics)*>)? $crate::list::ListArcSafe<$num> for $t {
> +        impl$(<$($generics)*>)? ListArcSafe<$num> for $t {

This change seems unintentional.

>              unsafe fn on_create_list_arc_from_unique(&mut self) {}
>              unsafe fn on_drop_list_arc(&self) {}
>          }
>          $crate::list::impl_list_arc_safe! { $($rest)* }
>      };
>=20
> +    (impl$({$($generics:tt)*})? ListArcSafe<$num:tt> for $t:ty {
> +        tracked_by $field:ident : $fty:ty;
> +    } $($rest:tt)*) =3D> {
> +        impl$(<$($generics)*>)? ListArcSafe<$num> for $t {

Here you also want to access `ListArcSafe` via
`$crate::list::ListArcSafe`.

> +            unsafe fn on_create_list_arc_from_unique(&mut self) {
> +                let me =3D self as *mut Self;
> +                let field: *mut $fty =3D unsafe { ::core::ptr::addr_of_m=
ut!((*me).$field) };

I think we should also have `SAFETY` comments in macros.

Also why can't this be done using safe code?:

     let field: &mut $fty =3D &mut self.$field;

> +                unsafe { <$fty as $crate::list::ListArcSafe<$num>>::on_c=
reate_list_arc_from_unique(
> +                        &mut *field
> +                ) };

Formatting? rustfmt gives me this:

                 unsafe {
                     <$fty as $crate::list::ListArcSafe<$num>>::on_create_l=
ist_arc_from_unique(
                         &mut *field
                     )
                 };

(maybe the `;` should be inside the `unsafe` block in this case?)

--=20
Cheers,
Benno

> +            }
> +            unsafe fn on_drop_list_arc(&self) {
> +                let me =3D self as *const Self;
> +                let field: *const $fty =3D unsafe { ::core::ptr::addr_of=
!((*me).$field) };
> +                unsafe { <$fty as $crate::list::ListArcSafe<$num>>::on_d=
rop_list_arc(&*field) };
> +            }
> +        }
> +        unsafe impl$(<$($generics)*>)? TryNewListArc<$num> for $t
> +        where
> +            $fty: TryNewListArc<$num>,
> +        {
> +            fn try_new_list_arc(&self) -> bool {
> +                let me =3D self as *const Self;
> +                let field: *const $fty =3D unsafe { ::core::ptr::addr_of=
!((*me).$field) };
> +                unsafe { <$fty as $crate::list::TryNewListArc<$num>>::tr=
y_new_list_arc(&*field) }
> +            }
> +        }
> +        $crate::list::impl_list_arc_safe! { $($rest)* }
> +    };
> +
>      () =3D> {};
>  }
>  pub use impl_list_arc_safe;


