Return-Path: <linux-kernel+bounces-105287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4D887DB70
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 21:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDEDBB212AC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 20:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAA21C695;
	Sat, 16 Mar 2024 20:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="JgGHx0uu"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77D31C280;
	Sat, 16 Mar 2024 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710621614; cv=none; b=SQthdQBZmx7DKa/OA8ezpyjHD2FUm/4/+PUk/tilVOhFlGeM9JKXYgugT3ml3VkvE5cBad9hj4Vse2RRwTaGjyIYYnHZh5BMKDkFnuOofhfNiZ2fi/AkLyTDSRx1VPpCZKaoijiB2vUIlstfwwzUX2jynjLhZMrGDKMdpAL5VMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710621614; c=relaxed/simple;
	bh=58qvFg1dNbBCwLLsr/YODHvr/DIfRi6oxdDcpHNBgbU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STmxKkptUraF97oLsCDOOOuApQJZAJr1bC8CwHaTS/jvTF2Mabbo9oj0PB0DNvwiwed/Q6Yyg3zooMKudKXPeuEF4tnC6j9Vpb6W3gbiD03ZjZXguGh1psgYa5pcyhAQ2r4aFZckLutF7/GB3gj3E0JsTFrYhZKu4hnUZ02p6Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=JgGHx0uu; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1710621600; x=1710880800;
	bh=A+6SILfQFnqsXEoZHJxtgDtsdF1CEuXy/QosmJOt4ws=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=JgGHx0uuMKBY3EgucoOqQigFj4ZnBofZ9IxIHHWScg/kbyb+yXdlWDAmFJFDQ3OuR
	 fpumksGePiOKvE4YlfElV5zQSq3SbTtpFQYFj7UuWR93EyVxgHXpOhFfvhN2zcIpG4
	 Kmhj+3GyqOp9Ga/sVM5GgYasYfzvMFBHFD2zkK0KbSNvy38WRXlYd3CiJlntNnO5nB
	 JnFk46P9Lc7TJ9TlljquzGRU5Lg7Y9K1N/aMvDAtCWpY8lAWnXDTcmeZXPQeF9jF79
	 hIL8H81YQH0qu7QHhjNjj2BwC3jt78ZydYOdynUzsBHJqKMv4Uf4e1MvT/PK5IqGNx
	 h6hMuqChE8Rhw==
Date: Sat, 16 Mar 2024 20:39:34 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 4/4] rust: add abstraction for `struct page`
Message-ID: <baee63d9-273a-48aa-b3cc-f15e3782156b@proton.me>
In-Reply-To: <20240311-alice-mm-v3-4-cdf7b3a2049c@google.com>
References: <20240311-alice-mm-v3-0-cdf7b3a2049c@google.com> <20240311-alice-mm-v3-4-cdf7b3a2049c@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/11/24 11:47, Alice Ryhl wrote:
> +/// A pointer to a page that owns the page allocation.
> +///
> +/// # Invariants
> +///
> +/// The pointer points at a page, and has ownership over the page.

Why not "`page` is valid"?
Do you mean by ownership of the page that `page` has ownership of the
allocation, or does that entail any other property/privilege?

> +pub struct Page {
> +    page: NonNull<bindings::page>,
> +}
> +
> +// SAFETY: It is safe to transfer page allocations between threads.

Why?

> +unsafe impl Send for Page {}
> +
> +// SAFETY: As long as the safety requirements for `&self` methods on thi=
s type
> +// are followed, there is no problem with calling them in parallel.

Why?

> +unsafe impl Sync for Page {}
> +
> +impl Page {
> +    /// Allocates a new page.
> +    pub fn alloc_page(gfp_flags: flags::gfp_t) -> Result<Self, AllocErro=
r> {
> +        // SAFETY: The specified order is zero and we want one page.

This doesn't explain why it is sound to call the function. I expect that
it is always sound to call this function with valid arguments.

> +        let page =3D unsafe { bindings::alloc_pages(gfp_flags, 0) };
> +        let page =3D NonNull::new(page).ok_or(AllocError)?;
> +        // INVARIANT: We checked that the allocation succeeded.

Doesn't mention ownership.

> +        Ok(Self { page })
> +    }
> +
> +    /// Returns a raw pointer to the page.
> +    pub fn as_ptr(&self) -> *mut bindings::page {
> +        self.page.as_ptr()
> +    }
> +
> +    /// Runs a piece of code with this page mapped to an address.
> +    ///
> +    /// The page is unmapped when this call returns.
> +    ///
> +    /// It is up to the caller to use the provided raw pointer correctly=
.

This says nothing about what 'correctly' means. What I gathered from the
implementation is that the supplied pointer is valid for the execution
of `f` for `PAGE_SIZE` bytes.
What other things are you allowed to rely upon?

Is it really OK for this function to be called from multiple threads?
Could that not result in the same page being mapped multiple times? If
that is fine, what about potential data races when two threads write to
the pointer given to `f`?

> +    pub fn with_page_mapped<T>(&self, f: impl FnOnce(*mut u8) -> T) -> T=
 {
> +        // SAFETY: `page` is valid due to the type invariants on `Page`.
> +        let mapped_addr =3D unsafe { bindings::kmap_local_page(self.as_p=
tr()) };
> +
> +        let res =3D f(mapped_addr.cast());
> +
> +        // SAFETY: This unmaps the page mapped above.

This doesn't explain why it is sound.

> +        //
> +        // Since this API takes the user code as a closure, it can only =
be used
> +        // in a manner where the pages are unmapped in reverse order. Th=
is is as
> +        // required by `kunmap_local`.
> +        //
> +        // In other words, if this call to `kunmap_local` happens when a
> +        // different page should be unmapped first, then there must nece=
ssarily
> +        // be a call to `kmap_local_page` other than the call just above=
 in
> +        // `with_page_mapped` that made that possible. In this case, it =
is the
> +        // unsafe block that wraps that other call that is incorrect.
> +        unsafe { bindings::kunmap_local(mapped_addr) };
> +
> +        res
> +    }
> +
> +    /// Runs a piece of code with a raw pointer to a slice of this page,=
 with
> +    /// bounds checking.
> +    ///
> +    /// If `f` is called, then it will be called with a pointer that poi=
nts at
> +    /// `off` bytes into the page, and the pointer will be valid for at =
least
> +    /// `len` bytes. The pointer is only valid on this task, as this met=
hod uses
> +    /// a local mapping.

This information about the pointer only being valid on this task should
also apply to `with_page_mapped`, right?

> +    ///
> +    /// If `off` and `len` refers to a region outside of this page, then=
 this
> +    /// method returns `EINVAL` and does not call `f`.
> +    ///
> +    /// It is up to the caller to use the provided raw pointer correctly=
.

Again, please specify what 'correctly' means.

--=20
Cheers,
Benno

> +    pub fn with_pointer_into_page<T>(
> +        &self,
> +        off: usize,
> +        len: usize,
> +        f: impl FnOnce(*mut u8) -> Result<T>,
> +    ) -> Result<T> {
> +        let bounds_ok =3D off <=3D PAGE_SIZE && len <=3D PAGE_SIZE && (o=
ff + len) <=3D PAGE_SIZE;
> +
> +        if bounds_ok {
> +            self.with_page_mapped(move |page_addr| {
> +                // SAFETY: The `off` integer is at most `PAGE_SIZE`, so =
this pointer offset will
> +                // result in a pointer that is in bounds or one off the =
end of the page.
> +                f(unsafe { page_addr.add(off) })
> +            })
> +        } else {
> +            Err(EINVAL)
> +        }
> +    }


