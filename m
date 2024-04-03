Return-Path: <linux-kernel+bounces-129711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC19896ECC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBFFD28D7E6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF81146583;
	Wed,  3 Apr 2024 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Xv9GRf4L"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699DC3DB9B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 12:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712146791; cv=none; b=E20fbWYeM7lRbrJ0KxRt/SJOlLmXfLoqEdDS4YFqFHSDVLgQJP54zMAHTzfK+2K0WcuFJ2rEN2XQoG7E+cyJvoJBo7nVA7R1ND/KBXZVEE+BPv5fJ/t1IdO9FJJj/8EVUmTAVNxsCvmtQwIOQiDAVbRKYFGPEHV+FEZJF0id8NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712146791; c=relaxed/simple;
	bh=DtimUzcCiaEemuoUaPjn4n0jKJP0VTmi4Z8kvystU2g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MvIcQobks+qSFRzAzXoU0SnpWQt3NcxflYqFYQzr0V++LW0Z89n+51v7ECpaDQzUuqFc4y+lvaH5Zi9iPE0Y5NAC25fDabyeUY8h0d9TSehHDig0EY95cQdTCnG8lNM5UJrCXTzjfDLe3NRnnHSDY2VSaZz12ojNaWVpXGMtVXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Xv9GRf4L; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712146786; x=1712405986;
	bh=0bM9BhDiM99LAuLM/L3WaFL905yHSxqRHWxKfPusUgY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Xv9GRf4LDL0m+M7PmKZenEhuN4QhZyqARnY2A1tSww0dcPL+oQJ8jDjRdwfmqGkua
	 uNUvQaZGvm7d3Gxt96PKHN6uFes5rb2r79tYvvN5l1BccQRwxRDIt6dy9j0SV3C6N0
	 VqJysdzsgv7fd68HyQJvlvUkUyXdY/WnSdO/EAzmyFL3dB8NuRRCjMr3ZtYmcbY2ur
	 G6/HsNy1jaJL88pqL5j5IVAv5O+XwQSaip4c9J1Ilmf1J1X7ANn9Caw/8W3KuBGpnw
	 7Jlakk0IQa8eoubezehHvRZg03s1WXIsRLLzQhd9qXq9a38k4rHafG02GUQqmtHggJ
	 T97UyL1iq3JBw==
Date: Wed, 03 Apr 2024 12:19:38 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 7/9] rust: list: add cursor
Message-ID: <4aaf7fd7-49ed-4b3e-b691-0d8d7d426d3a@proton.me>
In-Reply-To: <20240402-linked-list-v1-7-b1c59ba7ae3b@google.com>
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com> <20240402-linked-list-v1-7-b1c59ba7ae3b@google.com>
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
> diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
> index 892705dd0571..47e52818c7bd 100644
> --- a/rust/kernel/list.rs
> +++ b/rust/kernel/list.rs
> @@ -408,6 +408,20 @@ pub fn push_all_back(&mut self, other: &mut List<T, =
ID>) {
>          other.first =3D ptr::null_mut();
>      }
>=20
> +    /// Returns a cursor to the first element of the list.
> +    ///
> +    /// If the list is empty, this returns `None`.
> +    pub fn cursor_front(&mut self) -> Option<Cursor<'_, T, ID>> {
> +        if self.first.is_null() {
> +            None
> +        } else {
> +            Some(Cursor {

Missing INVARIANT comment.

> +                current: self.first,
> +                list: self,
> +            })
> +        }
> +    }
> +
>      /// Creates an iterator over the list.
>      pub fn iter(&self) -> Iter<'_, T, ID> {
>          // INVARIANT: If the list is empty, both pointers are null. Othe=
rwise, both pointers point
> @@ -476,6 +490,69 @@ fn next(&mut self) -> Option<ArcBorrow<'a, T>> {
>      }
>  }
>=20
> +/// A cursor into a [`List`].
> +///
> +/// # Invariants
> +///
> +/// The `current` pointer points a value in `list`.
> +pub struct Cursor<'a, T: ?Sized + ListItem<ID>, const ID: u64 =3D 0> {
> +    current: *mut ListLinksFields,
> +    list: &'a mut List<T, ID>,
> +}
> +
> +impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> Cursor<'a, T, ID> {
> +    /// Access the current element of this cursor.
> +    pub fn current(&self) -> ArcBorrow<'_, T> {
> +        // SAFETY: The `current` pointer points a value in the list.
> +        let me =3D unsafe { T::view_value(ListLinks::from_fields(self.cu=
rrent)) };
> +        // SAFETY:
> +        // * All values in a list are stored in an `Arc`.
> +        // * The value cannot be removed from the list for the duration =
of the lifetime annotated
> +        //   on the returned `ArcBorrow`, because removing it from the l=
ist would require mutable
> +        //   access to the cursor or the list. However, the `ArcBorrow` =
holds an immutable borrow
> +        //   on the cursor, which in turn holds an immutable borrow on t=
he list, so any such

The cursor has a mutable borrow on the list.


> +        //   mutable access requires first releasing the immutable borro=
w on the cursor.
> +        // * Values in a list never have a `UniqueArc` reference.

Is there some type invariant guaranteeing this?

--=20
Cheers,
Benno

> +        unsafe { ArcBorrow::from_raw(me) }
> +    }
> +
> +    /// Move the cursor to the next element.
> +    pub fn next(self) -> Option<Cursor<'a, T, ID>> {
> +        // SAFETY: The `current` field is always in a list.
> +        let next =3D unsafe { (*self.current).next };
> +
> +        if next =3D=3D self.list.first {
> +            None
> +        } else {
> +            Some(Cursor {
> +                current: next,
> +                list: self.list,
> +            })
> +        }
> +    }


