Return-Path: <linux-kernel+bounces-131736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C297D898B3F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296AD283524
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA68912A176;
	Thu,  4 Apr 2024 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kG5CqHgg"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B771292F3;
	Thu,  4 Apr 2024 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244961; cv=none; b=RAdIp7ntuYITiedWwEBEIhrTDLpCsPdKYk1YwU/Y3sQl+uo2Awy/qKtD/VONvA/N+XkBJReCDoGdj0Oy0MNSxCfDtszqxmboyDKqzWCDdSHeSCykeHNKKdAwvbb1oJoKjQ6pVpei6MLtDqHIpR5UckcV7i+64zQF0Qflh5hak+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244961; c=relaxed/simple;
	bh=fYbjEPVccjvYnn46iD7vpnVoAkxI1If0zG6IiW1R9Yc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EX+PRgUQw7YpSmwqTOBSy+qF1/juGKzfBp93YWykG4CXus2UpewSMY9z5Sf82SdcfXc3Ojaz8cK9EYPF2LfpJm6GtQFvsUX1wytsnbU9A6/YcpydpfFPcyg7rj/WKtfND06kUMlvSCWzQiSNrN12CZDpawdNEEB3urTsqsWxozQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=kG5CqHgg; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712244956; x=1712504156;
	bh=DMdXBi/0LZqIUvhAKHpVgBvC+3bzEmZ+xPRxQLFsuwM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kG5CqHgg3sWkxpkV4h1CY2VTd2fIjN6bWbDfeKo76m48UFkcTGqap3UjOvpv+WneM
	 4C+Mpd5Z1Tb0jSdnnLiKCuagArdS+Y/7Q8J0zbBytdw+JqnjCekcdErlq5Me/BQ0TO
	 u2PwF84SRv0suewmB5wHBzXP7471tALVTIo2EVgOj7TH3JVtbD7LdqHMdEwyP6Ndq4
	 DaNRQ6Jh7sBaAPAnt3hdVAxWBi3K347iiSPSHlelfKULtsJTybwkN/pFR6B+M+E4KT
	 m3jx/FP+aMM7v7CIvcFi9c4TN6Cms2R55sXKDyvdhWZyz5bDpv2yNUkpCAematsTcs
	 DB6GUR9U2HJJw==
Date: Thu, 04 Apr 2024 15:35:51 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 8/9] rust: list: support heterogeneous lists
Message-ID: <18698be5-fe4b-44ed-a12e-444ebffd4b32@proton.me>
In-Reply-To: <20240402-linked-list-v1-8-b1c59ba7ae3b@google.com>
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com> <20240402-linked-list-v1-8-b1c59ba7ae3b@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.04.24 14:17, Alice Ryhl wrote:
> @@ -180,6 +184,41 @@ unsafe fn from_fields(me: *mut ListLinksFields) -> *=
mut Self {
>      }
>  }
>=20
> +/// Similar to [`ListLinks`], but also contains a pointer to the full va=
lue.
> +///
> +/// This type can be used instead of [`ListLinks`] to support lists with=
 trait objects.
> +#[repr(C)]
> +pub struct ListLinksSelfPtr<T: ?Sized, const ID: u64 =3D 0> {
> +    /// The `ListLinks` field inside this value.
> +    ///
> +    /// This is public so that it can be used with `impl_has_list_links!=
`.
> +    pub inner: ListLinks<ID>,
> +    self_ptr: UnsafeCell<MaybeUninit<*const T>>,
> +}
> +
> +unsafe impl<T: ?Sized + Send, const ID: u64> Send for ListLinksSelfPtr<T=
, ID> {}
> +unsafe impl<T: ?Sized + Sync, const ID: u64> Sync for ListLinksSelfPtr<T=
, ID> {}

Missing SAFETY comments.

> +
> +impl<T: ?Sized, const ID: u64> ListLinksSelfPtr<T, ID> {
> +    /// The offset from the [`ListLinks`] to the self pointer field.
> +    pub const LIST_LINKS_SELF_PTR_OFFSET: usize =3D core::mem::offset_of=
!(Self, self_ptr);
> +
> +    /// Creates a new initializer for this type.
> +    pub fn new() -> impl PinInit<Self> {
> +        // INVARIANT: Pin-init initializers can't be used on an existing=
 `Arc`, so this value will
> +        // not be constructed in an `Arc` that already has a `ListArc`.
> +        Self {
> +            inner: ListLinks {
> +                inner: Opaque::new(ListLinksFields {
> +                    prev: ptr::null_mut(),
> +                    next: ptr::null_mut(),
> +                }),
> +            },

Why don't you use `inner <- ListLinks::new(),`?

> +            self_ptr: UnsafeCell::new(MaybeUninit::zeroed()),
> +        }
> +    }
> +}
> +
>  impl<T: ?Sized + ListItem<ID>, const ID: u64> List<T, ID> {
>      /// Creates a new empty list.
>      pub const fn new() -> Self {

[...]

> @@ -94,5 +137,45 @@ unsafe fn post_remove(me: *mut ListLinks<$num>) -> *c=
onst Self {
>              }
>          }
>      };
> +
> +    (
> +        impl$({$($generics:tt)*})? ListItem<$num:tt> for $t:ty {
> +            using ListLinksSelfPtr;
> +        } $($rest:tt)*
> +    ) =3D> {
> +        unsafe impl$(<$($generics)*>)? ListItem<$num> for $t {
> +            unsafe fn prepare_to_insert(me: *const Self) -> *mut ListLin=
ks<$num> {
> +                let links_field =3D unsafe { Self::view_links(me) };
> +
> +                let spoff =3D ListLinksSelfPtr::<Self, $num>::LIST_LINKS=
_SELF_PTR_OFFSET;
> +                let self_ptr =3D unsafe { (links_field as *const u8).add=
(spoff)
> +                    as *const ::core::cell::UnsafeCell<*const Self> };
> +                let cell_inner =3D ::core::cell::UnsafeCell::raw_get(sel=
f_ptr);
> +
> +                unsafe { ::core::ptr::write(cell_inner, me) };
> +                links_field
> +            }
> +
> +            unsafe fn view_links(me: *const Self) -> *mut ListLinks<$num=
> {
> +                unsafe {
> +                    <Self as HasListLinks<$num>>::raw_get_list_links(me.=
cast_mut())
> +                }
> +            }
> +
> +            unsafe fn view_value(links_field: *mut ListLinks<$num>) -> *=
const Self {
> +                let spoff =3D ListLinksSelfPtr::<Self, $num>::LIST_LINKS=
_SELF_PTR_OFFSET;
> +                let self_ptr =3D unsafe { (links_field as *const u8).add=
(spoff)
> +                    as *const ::core::cell::UnsafeCell<*const Self> };
> +                let cell_inner =3D ::core::cell::UnsafeCell::raw_get(sel=
f_ptr);
> +                unsafe {
> +                    ::core::ptr::read(cell_inner)
> +                }
> +            }
> +
> +            unsafe fn post_remove(me: *mut ListLinks<$num>) -> *const Se=
lf {
> +                unsafe { Self::view_value(me) }
> +            }
> +        }
> +    };

The paths in this macro should use `$crate::...` to prevent import
errors.

--=20
Cheers,
Benno


