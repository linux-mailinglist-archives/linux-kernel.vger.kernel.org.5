Return-Path: <linux-kernel+bounces-159570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FF38B3075
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C481F23635
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11CF8529B;
	Fri, 26 Apr 2024 06:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="W5KyuVI9"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBFB2E64C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714113160; cv=none; b=pkjbWpt5rugsOGackOe7YgOHBbxxdyQQpbwrBssWXaw/GvC6lh0f2npSLSGZ1H3ZihAtz04q3CBFKj6p08A9vTHLVwqPwI09TnMh60m4dfA3HjtkiGyJwsLLhDOSaSfA0kJh/sTCiIqZNxOaYFaRf/CftuVXVeLU6bC3gjPdV6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714113160; c=relaxed/simple;
	bh=rtUGVKsO10LJIWRTFpXOF9wdVjJzy6xZKY26OOTm/Is=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/D9b4DdDeHthlMnZki5QZZ3exZiRNJicQypZk2IxKMcfH7ZlI0tOM0HqPAYyqGc2mJVlQ2JJeNlf2IYRubkM2/mWzxVt41jF5G+Qg3sUb4+XImKOXaE/eLmpBjrIRs/w+7d75CKl+Fa35Wl3Xx13v0ft5oIZ1sgQF7zljRFBK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=W5KyuVI9; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=bumkvdrs3vb7pdpoegwbmhrw3a.protonmail; t=1714113150; x=1714372350;
	bh=r7oVaw4lyexpBvPL+bwDK6PgFxfu0wR1UC6/ArBRmvQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=W5KyuVI96XxmnIj2xaQr+XAxmGY1ENLMiLlm0aDDE+MBjh8nFryx9wPrHUQ76ol2H
	 AuyIMnhxrvY3bdOHiWZPPRH9vk1tyOconkzOCda0fE1PNYS6RAzpIu/DQRye37WMKZ
	 nNOgooyQkiQ0bk/bYFKhC9HfsSTry/qJoBtN2MUzxfcNqzlu9g+N/qIeWaqNTc5fE/
	 6FMAuSFH5asmIvILC5wvHiFKuRycLJHmPEPM5bxi8OwQ6YWu6JlUNVgnb1JGTPR056
	 YOkQURAs8NCD2blLZHRKlp03DHEwkXzGXRlKxR1vz0BIQF0DNxNh/B08PsEJdE6ppJ
	 dW6sEEbmo+Hgg==
Date: Fri, 26 Apr 2024 06:32:26 +0000
To: Danilo Krummrich <dakr@redhat.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>, ajanulgu@redhat.com, Andy Currid <acurrid@nvidia.com>, Neo Jia <cjia@nvidia.com>, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 00/10] Allocation APIs
Message-ID: <71dd99fe-0d64-47cc-b367-8fdd4fcdbdca@proton.me>
In-Reply-To: <Zirfyp_NiYCRQYvk@cassiopeiae>
References: <Zip4dFpt8xhk7UBL@cassiopeiae> <74cbdaf7-360e-47e3-bda4-4661422a11ae@proton.me> <ZiqkIQTHe9apd-LW@pollux> <f71c4e07-9f6f-4709-a3bb-012e644c4845@proton.me> <Zirfyp_NiYCRQYvk@cassiopeiae>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 4054ead838636b1f6f56c2ad711aafe46f1920da
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.04.24 00:57, Danilo Krummrich wrote:
> On Thu, Apr 25, 2024 at 08:52:16PM +0000, Benno Lossin wrote:
>> On 25.04.24 20:42, Danilo Krummrich wrote:
>>> On Thu, Apr 25, 2024 at 04:09:46PM +0000, Benno Lossin wrote:
>>>> On 25.04.24 17:36, Danilo Krummrich wrote:
>>>>> (adding folks from [1])
>>>>>
>>>>> On Tue, Apr 23, 2024 at 05:43:08PM +0200, Danilo Krummrich wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> On 3/28/24 02:35, Wedson Almeida Filho wrote:
>>>>>>> From: Wedson Almeida Filho <walmeida@microsoft.com>
>>>>>>>
>>>>>>> Revamp how we use the `alloc` crate.
>>>>>>>
>>>>>>> We currently have a fork of the crate with changes to `Vec`; other
>>>>>>> changes have been upstreamed (to the Rust project). This series rem=
oves
>>>>>>> the fork and exposes all the functionality as extension traits.
>>>>>>>
>>>>>>> Additionally, it also introduces allocation flag parameters to all
>>>>>>> functions that may result in allocations (e.g., `Box::new`, `Arc::n=
ew`,
>>>>>>> `Vec::push`, etc.) without the `try_` prefix -- the names are avail=
able
>>>>>>> because we build `alloc` with `no_global_oom_handling`.
>>>>>>>
>>>>>>> Lastly, the series also removes our reliance on the `allocator_api`
>>>>>>> unstable feature.
>>>>>>>
>>>>>>> Long term, we still want to make such functionality available in
>>>>>>> upstream Rust, but this allows us to make progress now and reduces =
our
>>>>>>> maintainance burden.
>>>>>>>
>>>>>>> In summary:
>>>>>>> 1. Removes `alloc` fork
>>>>>>> 2. Removes use of `allocator_api` unstable feature
>>>>>>> 3. Introduces flags (e.g., GFP_KERNEL, GFP_ATOMIC) when allocating
>>>>>>
>>>>>> With that series, how do we implement alternative allocators, such a=
s
>>>>>> (k)vmalloc or DMA coherent?
>>>>>>
>>>>>> For instance, I recently sketched up some firmware bindings we want =
to
>>>>>> use in Nova providing
>>>>>>
>>>>>> fn copy<A: core::alloc::Allocator>(&self, alloc: A) -> Result<Vec<u8=
, A>>
>>>>>> [1]
>>>>>>
>>>>>> making use of Vec::try_with_capacity_in(). How would I implement
>>>>>> something similar now?
>>>>>
>>>>> I want to follow up on this topic after also bringing it up in yester=
day's
>>>>> weekly Rust call.
>>>>>
>>>>> In the call a few ideas were discussed, e.g. whether we could just re=
-enable the
>>>>> allocator_api feature and try getting it stabilized.
>>>>>
>>>>> With the introduction of alloc::Flags (gfp_t abstraction) allocator_a=
pi might
>>>>> not be a viable choice anymore.
>>>>
>>>> Bringing in some more context from the meeting: Gary suggested we crea=
te
>>>> a custom trait for allocators that can also handle allocation flags:
>>>>
>>>>        pub trait AllocatorWithFlags: Allocator {
>>>>            type Flags;
>>>>
>>>>            fn allocate_with_flags(&self, layout: Layout, flags: Self::=
Flags) -> Result<NonNull<[u8]>, AllocError>;
>>>>
>>>>            /* ... */
>>>>        }
>>>>
>>>>        impl AllocatorWithFlags for Global { /* ... */ }
>>>>
>>>>        impl<T, A> VecExt<T> for Vec<T, A> where A: AllocatorWithFlags =
{
>>>>            /* ... */
>>>>        }
>>>>
>>>> I think that this would work, but we would have to ensure that users a=
re
>>>> only allowed to call allocating functions if they are functions that w=
e
>>>> control. For example `Vec::try_reserve` [1] would still use the normal
>>>> `Allocator` trait that doesn't support our flags.
>>>> Gary noted that this could be solved by `klint` [2].
>>>
>>> I agree, extending the Allocator trait should work.
>>>
>>> Regarding allocating functions we don't control, isn't that the case al=
ready?
>>> AFAICS, we're currently always falling back to GFP_KERNEL when calling
>>> Vec::try_reserve().
>>
>> Yes we're falling back to that, but
>> 1. there are currently no calls to `try_reserve` in tree,
>> 2. if you use eg a `vmalloc` allocator, then I don't know if it would be
>>      fine to reallocate that pointer using `krealloc`. I assumed that th=
at
>>      would not be OK (hence my extra care with functions outside of our
>>      control).
>=20
> Well, this would indeed not be valid. However, a vmalloc allocater wouldn=
't
> implement realloc() this way.

Oh yeah that is correct.

> Or are you saying that Vec always uses the global allocator in that case?=
 Why
> would it do that?

No, it would use the vmalloc allocator.

So I guess the issue isn't as bad as I at first thought. I still think
we should lint for this though (but maybe a warning instead of an error).

>>> But yes, I also think it would be better to enforce being explicit.
>>>
>>> Given that, is there any value extending the existing Allocator trait a=
t all?
>>
>> This is what I meant in the meeting by "do you really need the allocator
>> trait?". What you lose is the ability to use `Vec` and `Box`, instead
>=20
> Oh, indeed. I forgot about that when I wrote that. In that case I feel li=
ke it's
> worth extending the existing allocator_api.
>=20
>> you have to use your own wrapper types (see below). But what you gain is
>> freedom to experiment. In the end we should still try to upstream our
>> findings to Rust or at least share our knowledge, but doing that from
>> the get-go is not ideal for productivity.
>>
>>>> But we only need to extend the allocator API, if you want to use the s=
td
>>>> library types that allocate. If you would also be happy with a custom
>>>> newtype wrapper, then we could also do that.
>>>
>>> What do you mean with "custom newtype wrapper"?
>>
>> You create a newtype struct ("newtype" means that it wraps an inner type
>> and adds/removes/changes features from the inner type):
>>
>>       pub struct BigVec<T>(Vec<T>);
>>
>> And then you implement the common operations on it:
>>
>>       impl<T> BigVec<T> {
>>           pub fn push(&mut self, item: T) -> Result {
>>               self.reserve(1)?;
>>
>>               self.0.spare_capacity_mut()[0].write(item);
>>
>>               // SAFETY: <omitted for brevity>
>>               unsafe { self.0.set_len(self.0.len() + 1) };
>>               Ok(())
>>           }
>>
>>           pub fn reserve(&mut self, additional: usize) -> Result {
>>               /*
>>                * implemented like `VecExt::reserve` from this patchset,
>>                * except that it uses `vmalloc` instead of `krealloc`.
>>                */
>>           }
>>       }
>>
>> If we need several of these, we can also create a general API that
>> makes it easier to create them and avoids the duplication.
>=20
> Thanks for for explaining.
>=20
> I'd probably tend to extending allocator_api then. Do you see any major
> advantages / disadvantages doing one or the other?

So aside from being able to use `Vec` and `Box` etc, I don't think there
are any advantages to using `allocator_api`. The disadvantages are that
it's another unstable feature that we need to get stabilized in some
form. So it increases the amount of time it takes for us to be able to
support multiple versions of Rust.

I think it's fine for you to experiment with the `allocator_api` and see
where that leads you. But when we discuss merging patches that enable
unstable features, we should be sure that the feature is truly needed.
And that it cannot be replaced by custom code (it also depends on how
complicated it is, but I think `allocator_api` would be simple enough).

--=20
Cheers,
Benno


