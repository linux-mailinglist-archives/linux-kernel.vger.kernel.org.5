Return-Path: <linux-kernel+bounces-159166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4327E8B2A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46FEFB267E6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B58154450;
	Thu, 25 Apr 2024 20:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ncgASzbR"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3001F153811;
	Thu, 25 Apr 2024 20:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714078346; cv=none; b=g1HHcyU1GDxmiidu2Zs1dlr99FSXTWAJQB3Lf8G++TXEIngli3eMj5mttsley0tN3IXEpz9DxqSHUvH3keGrkWr4IVXSQ5LtakaSucrVbwIfgi2e1u+UNCF1jR0nCc8MnnovMGlp6tQobSenagYdD7NxzHyngXwPBZVHZO/7oRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714078346; c=relaxed/simple;
	bh=QhmTDV0HN3ntsJ7iNLe4i8FOQ2T+E1ksRlQTmHVtun4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3PmzBvMh29AosDhstGBuxCYTvoOfhX9qDZ3spFrIoidWIqk+j1eg+msNjdTLEJgCClYJxj1ZzSE7lc979y8R+4GR35To2PJ9j9jOdLzRYNfXkmCRdi6ThHoUoMl5f6T1HeaYcgloFdcLmgLaH4ZDsoK+S/CsWxEQG7fLgzvugI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ncgASzbR; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=6kwi4qc6qneolo3aj2w7josh7e.protonmail; t=1714078340; x=1714337540;
	bh=kuBMwu2qu8Edmmb81SBFVZfp0S8IZhGnSfV57gB5Muk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ncgASzbRMHjgOejiG18rtJZazqlmyqKnGZlYEfym4oqMCt6xIUy4KVQyniKouMMae
	 PIDb1NyzOzRL3QQ73gPOi9A9zNiICrDOjKXt+phkEg6wnu2OF6G6UHOyAoHqT4nMWe
	 iWeHiQ53V98U3JcAlFMCyAVzUNU2sBOG+SYNZ//MSWElxgQZzn/+W5nRWnVwjuJuTg
	 xer8gYOlnHnoN79hV/1RS+1ZiYkrGHGXgAFgQUp9iYAuS6faydZXfpxZ/nRRAYi8Gg
	 mndzlHq/XM3AP3J0ljRxysoslnMQt1Frc8t/eNJE4r7FE0xZ32siRJpbAfRl9adWQL
	 SDH0bPWGkHukA==
Date: Thu, 25 Apr 2024 20:52:16 +0000
To: Danilo Krummrich <dakr@redhat.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>, ajanulgu@redhat.com, Andy Currid <acurrid@nvidia.com>, Neo Jia <cjia@nvidia.com>, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 00/10] Allocation APIs
Message-ID: <f71c4e07-9f6f-4709-a3bb-012e644c4845@proton.me>
In-Reply-To: <ZiqkIQTHe9apd-LW@pollux>
References: <Zip4dFpt8xhk7UBL@cassiopeiae> <74cbdaf7-360e-47e3-bda4-4661422a11ae@proton.me> <ZiqkIQTHe9apd-LW@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 6fff10a820791c06d4527c15c2d28dd49efc0741
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.04.24 20:42, Danilo Krummrich wrote:
> On Thu, Apr 25, 2024 at 04:09:46PM +0000, Benno Lossin wrote:
>> On 25.04.24 17:36, Danilo Krummrich wrote:
>>> (adding folks from [1])
>>>
>>> On Tue, Apr 23, 2024 at 05:43:08PM +0200, Danilo Krummrich wrote:
>>>> Hi all,
>>>>
>>>> On 3/28/24 02:35, Wedson Almeida Filho wrote:
>>>>> From: Wedson Almeida Filho <walmeida@microsoft.com>
>>>>>
>>>>> Revamp how we use the `alloc` crate.
>>>>>
>>>>> We currently have a fork of the crate with changes to `Vec`; other
>>>>> changes have been upstreamed (to the Rust project). This series remov=
es
>>>>> the fork and exposes all the functionality as extension traits.
>>>>>
>>>>> Additionally, it also introduces allocation flag parameters to all
>>>>> functions that may result in allocations (e.g., `Box::new`, `Arc::new=
`,
>>>>> `Vec::push`, etc.) without the `try_` prefix -- the names are availab=
le
>>>>> because we build `alloc` with `no_global_oom_handling`.
>>>>>
>>>>> Lastly, the series also removes our reliance on the `allocator_api`
>>>>> unstable feature.
>>>>>
>>>>> Long term, we still want to make such functionality available in
>>>>> upstream Rust, but this allows us to make progress now and reduces ou=
r
>>>>> maintainance burden.
>>>>>
>>>>> In summary:
>>>>> 1. Removes `alloc` fork
>>>>> 2. Removes use of `allocator_api` unstable feature
>>>>> 3. Introduces flags (e.g., GFP_KERNEL, GFP_ATOMIC) when allocating
>>>>
>>>> With that series, how do we implement alternative allocators, such as
>>>> (k)vmalloc or DMA coherent?
>>>>
>>>> For instance, I recently sketched up some firmware bindings we want to
>>>> use in Nova providing
>>>>
>>>> fn copy<A: core::alloc::Allocator>(&self, alloc: A) -> Result<Vec<u8, =
A>>
>>>> [1]
>>>>
>>>> making use of Vec::try_with_capacity_in(). How would I implement
>>>> something similar now?
>>>
>>> I want to follow up on this topic after also bringing it up in yesterda=
y's
>>> weekly Rust call.
>>>
>>> In the call a few ideas were discussed, e.g. whether we could just re-e=
nable the
>>> allocator_api feature and try getting it stabilized.
>>>
>>> With the introduction of alloc::Flags (gfp_t abstraction) allocator_api=
 might
>>> not be a viable choice anymore.
>>
>> Bringing in some more context from the meeting: Gary suggested we create
>> a custom trait for allocators that can also handle allocation flags:
>>
>>       pub trait AllocatorWithFlags: Allocator {
>>           type Flags;
>>
>>           fn allocate_with_flags(&self, layout: Layout, flags: Self::Fla=
gs) -> Result<NonNull<[u8]>, AllocError>;
>>
>>           /* ... */
>>       }
>>
>>       impl AllocatorWithFlags for Global { /* ... */ }
>>
>>       impl<T, A> VecExt<T> for Vec<T, A> where A: AllocatorWithFlags {
>>           /* ... */
>>       }
>>
>> I think that this would work, but we would have to ensure that users are
>> only allowed to call allocating functions if they are functions that we
>> control. For example `Vec::try_reserve` [1] would still use the normal
>> `Allocator` trait that doesn't support our flags.
>> Gary noted that this could be solved by `klint` [2].
>=20
> I agree, extending the Allocator trait should work.
>=20
> Regarding allocating functions we don't control, isn't that the case alre=
ady?
> AFAICS, we're currently always falling back to GFP_KERNEL when calling
> Vec::try_reserve().

Yes we're falling back to that, but
1. there are currently no calls to `try_reserve` in tree,
2. if you use eg a `vmalloc` allocator, then I don't know if it would be
    fine to reallocate that pointer using `krealloc`. I assumed that that
    would not be OK (hence my extra care with functions outside of our
    control).

> But yes, I also think it would be better to enforce being explicit.
>=20
> Given that, is there any value extending the existing Allocator trait at =
all?

This is what I meant in the meeting by "do you really need the allocator
trait?". What you lose is the ability to use `Vec` and `Box`, instead
you have to use your own wrapper types (see below). But what you gain is
freedom to experiment. In the end we should still try to upstream our
findings to Rust or at least share our knowledge, but doing that from
the get-go is not ideal for productivity.

>> But we only need to extend the allocator API, if you want to use the std
>> library types that allocate. If you would also be happy with a custom
>> newtype wrapper, then we could also do that.
>=20
> What do you mean with "custom newtype wrapper"?

You create a newtype struct ("newtype" means that it wraps an inner type
and adds/removes/changes features from the inner type):

     pub struct BigVec<T>(Vec<T>);

And then you implement the common operations on it:

     impl<T> BigVec<T> {
         pub fn push(&mut self, item: T) -> Result {
             self.reserve(1)?;

             self.0.spare_capacity_mut()[0].write(item);

             // SAFETY: <omitted for brevity>
             unsafe { self.0.set_len(self.0.len() + 1) };
             Ok(())
         }

         pub fn reserve(&mut self, additional: usize) -> Result {
             /*
              * implemented like `VecExt::reserve` from this patchset,
              * except that it uses `vmalloc` instead of `krealloc`.
              */
         }
     }

If we need several of these, we can also create a general API that
makes it easier to create them and avoids the duplication.

>> I think that we probably want a more general solution (ie `Allocator`
>> enriched with flags), but we would have to design that before you can
>> use it.
>>
>>
>> [1]: https://doc.rust-lang.org/alloc/vec/struct.Vec.html#method.try_rese=
rve
>> [2]: https://github.com/Rust-for-Linux/klint
>>
>>>
>>> I think it would work for (k)vmalloc, where we could pass the page flag=
s through
>>> const generics for instance.
>>>
>>> But I don't see how it could work with kmem_cache, where we can't just =
create a
>>> new allocator instance when we want to change the page flags, but need =
to
>>> support allocations with different page flags on the same allocator (sa=
me
>>> kmem_cache) instance.
>>
>> I think that you can write the `kmem_cache` abstraction without using
>> the allocator api. You just give the function that allocates a `flags`
>> argument like in C.
>=20
> Guess you mean letting the kmem_cache implementation construct the corres=
ponding
> container? Something like:
>=20
> KmemCache<T>::alloc_box(flags: alloc::Flags) -> Box<T>
>=20
> I think that'd make a lot of sense, since the size of an allocation is fi=
xed
> anyways.

Yes, but you would probably need a newtype return type, since you need
to control how it is being freed. Also in the example above there is no
`kmem_cache` object that stores the state.

I think that the API would look more like this:

     impl<T> KMemCache<T> {
         pub fn alloc(&self, value: T, flags: Flags) -> Result<KMemObj<'_, =
T>>;
     }

Here are a couple of interesting elements of this API:
- I don't know if `kmem_cache` uses the same flags as the alloc module,
   if not you will need a custom `Flags` type.
- I assume that an object allocated by a `kmem_cache` is only valid
   while the cache still exists (ie if you drop the cache, all allocated
   objects are also invalidated). That is why the return type contains a
   lifetime (`'_` refers to the elided lifetime on the `&self` parameter.
   It means that the `KMemObj` is only valid while the `KMemCache` is
   also valid).
- The return type is its own kind of smart pointer that allows you to
   modify the inner value like `Box`, but it takes care of all the
   `kmem_cache` specifics (eg ensuring that the associated cache is still
   valid, freeing the object etc).r

Since I assumed several things, in the end the API might look different,
but I think that this could be a more fruitful starting point.

--=20
Cheers,
Benno


