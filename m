Return-Path: <linux-kernel+bounces-158923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939C48B26BF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9279B23EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5B414D45B;
	Thu, 25 Apr 2024 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="egrSn6Uy"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF2614A0BC;
	Thu, 25 Apr 2024 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714063525; cv=none; b=Jkb09s99xXclyzLXfCiSEclzheZqXRTLRiAkVlgBWKmKCiAqNjVFCPWoUtk9qopx0DCiKUf/Dii9ektB/gXJkbibIr+yZImkGq3G9FAXsvOzhyB9QKQUT/IJ9Nv0Blqdntsm3MT0Falm0Fd1CMM3IbSup+iUrOLw1ZQhJsPvNao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714063525; c=relaxed/simple;
	bh=j5UZ+cQV4SXINoKHgY4xZ6cPUqoxlcu39Ruy2XEaKgQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=faTXknj2Kgr8gYhpCTwFFtiVOP9F5PI+1u9pwcuIYwfkNcWS3b8j9y6eikabBglu3LkUX4IQyjKcAfaDynjwSuF9qAV5WfKRoqprZhx7cOyJmXElNgNGdl+0s4z+0nf0SLZ4fkyGNLXx8MYk/vubsj9bUR4knzXipEezY8q5KXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=egrSn6Uy; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1714061397; x=1714320597;
	bh=zKyfqDvrv1iM+SS0y6qDUkiVXJnVCCSFwwXsqVZwxgg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=egrSn6UybOkpEtfOhezwa0BtBqQ35NzpKW2wa4tINIsjE5Gf5cVNIFmP4wV7V/z3T
	 gIeVFv3XgJhiPQy/Ir1XZGYpRzNgNPn0zVpMDY17zZDRDJSzOLtc0GopGqkhOSskO8
	 zSN3slWSKhb3u/gEbIGi/szG8zljTLlTww3vlimRrfP0rTLc8vkOgYFf78O1GyuPGy
	 WWc9o3wZYR4uSm5DnvCO/Y3/GMDF6cPBUUltxGiXv7loqWIFyvYmqrGWNIfoOpSv38
	 2Ea/C6/IUif57bhnMgWisY3Zw47U/0WFUHE/Ytrk/lfLVCGISrR4lKac5Tw0fJj5h6
	 4cUpP8LVvSbWw==
Date: Thu, 25 Apr 2024 16:09:46 +0000
To: Danilo Krummrich <dakr@redhat.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>, ajanulgu@redhat.com, Andy Currid <acurrid@nvidia.com>, Neo Jia <cjia@nvidia.com>, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 00/10] Allocation APIs
Message-ID: <74cbdaf7-360e-47e3-bda4-4661422a11ae@proton.me>
In-Reply-To: <Zip4dFpt8xhk7UBL@cassiopeiae>
References: <Zip4dFpt8xhk7UBL@cassiopeiae>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 1d4e6985a2bfda98d609c203fecb91f144d65ed4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.04.24 17:36, Danilo Krummrich wrote:
> (adding folks from [1])
>=20
> On Tue, Apr 23, 2024 at 05:43:08PM +0200, Danilo Krummrich wrote:
>> Hi all,
>>
>> On 3/28/24 02:35, Wedson Almeida Filho wrote:
>>> From: Wedson Almeida Filho <walmeida@microsoft.com>
>>>
>>> Revamp how we use the `alloc` crate.
>>>
>>> We currently have a fork of the crate with changes to `Vec`; other
>>> changes have been upstreamed (to the Rust project). This series removes
>>> the fork and exposes all the functionality as extension traits.
>>>
>>> Additionally, it also introduces allocation flag parameters to all
>>> functions that may result in allocations (e.g., `Box::new`, `Arc::new`,
>>> `Vec::push`, etc.) without the `try_` prefix -- the names are available
>>> because we build `alloc` with `no_global_oom_handling`.
>>>
>>> Lastly, the series also removes our reliance on the `allocator_api`
>>> unstable feature.
>>>
>>> Long term, we still want to make such functionality available in
>>> upstream Rust, but this allows us to make progress now and reduces our
>>> maintainance burden.
>>>
>>> In summary:
>>> 1. Removes `alloc` fork
>>> 2. Removes use of `allocator_api` unstable feature
>>> 3. Introduces flags (e.g., GFP_KERNEL, GFP_ATOMIC) when allocating
>>
>> With that series, how do we implement alternative allocators, such as
>> (k)vmalloc or DMA coherent?
>>
>> For instance, I recently sketched up some firmware bindings we want to
>> use in Nova providing
>>
>> fn copy<A: core::alloc::Allocator>(&self, alloc: A) -> Result<Vec<u8, A>=
>
>> [1]
>>
>> making use of Vec::try_with_capacity_in(). How would I implement
>> something similar now?
>=20
> I want to follow up on this topic after also bringing it up in yesterday'=
s
> weekly Rust call.
>=20
> In the call a few ideas were discussed, e.g. whether we could just re-ena=
ble the
> allocator_api feature and try getting it stabilized.
>=20
> With the introduction of alloc::Flags (gfp_t abstraction) allocator_api m=
ight
> not be a viable choice anymore.

Bringing in some more context from the meeting: Gary suggested we create
a custom trait for allocators that can also handle allocation flags:

     pub trait AllocatorWithFlags: Allocator {
         type Flags;
        =20
         fn allocate_with_flags(&self, layout: Layout, flags: Self::Flags) =
-> Result<NonNull<[u8]>, AllocError>;

         /* ... */
     }
    =20
     impl AllocatorWithFlags for Global { /* ... */ }
    =20
     impl<T, A> VecExt<T> for Vec<T, A> where A: AllocatorWithFlags {
         /* ... */
     }

I think that this would work, but we would have to ensure that users are
only allowed to call allocating functions if they are functions that we
control. For example `Vec::try_reserve` [1] would still use the normal
`Allocator` trait that doesn't support our flags.
Gary noted that this could be solved by `klint` [2].


But we only need to extend the allocator API, if you want to use the std
library types that allocate. If you would also be happy with a custom
newtype wrapper, then we could also do that.
I think that we probably want a more general solution (ie `Allocator`
enriched with flags), but we would have to design that before you can
use it.


[1]: https://doc.rust-lang.org/alloc/vec/struct.Vec.html#method.try_reserve
[2]: https://github.com/Rust-for-Linux/klint

>=20
> I think it would work for (k)vmalloc, where we could pass the page flags =
through
> const generics for instance.
>=20
> But I don't see how it could work with kmem_cache, where we can't just cr=
eate a
> new allocator instance when we want to change the page flags, but need to
> support allocations with different page flags on the same allocator (same
> kmem_cache) instance.

I think that you can write the `kmem_cache` abstraction without using
the allocator api. You just give the function that allocates a `flags`
argument like in C.

The `Allocator` API might make it more *convenient* to use it, because
you don't have to explicitly pass the flags every time (since the flags
are determined by the allocator). But I have also heard that it might be
desirable to always be explicit.

--=20
Cheers,
Benno

>=20
> So, I think we have to create our own allocator trait / API.
>=20
> Any other thoughts on that?
>=20
> - Danilo
>=20
> [1] https://lore.kernel.org/rust-for-linux/20240408094738.00005e59.zhiw@n=
vidia.com/
>=20


