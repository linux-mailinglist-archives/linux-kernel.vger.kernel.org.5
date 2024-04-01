Return-Path: <linux-kernel+bounces-126989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DAF89457A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA641F21933
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576154A99C;
	Mon,  1 Apr 2024 19:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Cd+rwCHl"
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D10247A76
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711999704; cv=none; b=QoxpY4Wz816OO4YTuipDPBImTMfj25lRkLWlafsnOvTK2LMjE/Mkf2ytKupU6LN9jtEobrSSa2KSFWBqUDO02NyXXQeYSP3+3xOiA2KKPYjka91LFgq5gVdoORcuaTUgucevZvQkS8u/qVyYFZicofXGYor5rAU7LRyX3Y+x6R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711999704; c=relaxed/simple;
	bh=FtZFlGzW0MUxmZa/IKg7XcCyUtT2vw1AULuLvoBCx/g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=plzRNzzS5J+3jMHXxnS5DIxS17TCUQE6lT9nIY7mzSD6Zk2mTaG2ONa1xV8yRM+8uKIQlxGSgbUTVc3vxJABdkBqhgz+BarQcEQElsseS1vWoEvrJJj5dUvIktcGjwKIQm1dzqyZ36MTV8qBbu40+pxM+fz6/XW5zThjhUt5wGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Cd+rwCHl; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=wclaxxtrgfhp5fwlzubutvdnoi.protonmail; t=1711999686; x=1712258886;
	bh=a6gs8Co461eG3wpA5ckHsQcQV9C3iIwIFI/gKjKHzRo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Cd+rwCHlBl14MRIpQhRV9HbmzaYxp/tFS5svfZDZDwebUa2Aa9wHWHXQGHEFF1hbv
	 4rull/MuQxtGHt1O5EjUEwUfcMSynpPf3WF9HiXOfp9USq8Qyytk4mz1CUNV7cwvSv
	 f6/wZNwtJUny4v11TYz0Tp7QR+G1qx2qxFOSUNtrOUvt5HO+9tsEien0xhhNxY8G4X
	 tNxRNFgZEXzuPd9+fkqcmv5BFrbXR0rxZyB5kwP4ehApq4tIMS/rdDyrJt18MjlUDG
	 X7iMhQXdsEGFYxBrlTdRni77tVGRefpp1nWHk6BYOscBAKHX2p3cu6r/352HMgq1vP
	 PDh4axXklOC5A==
Date: Mon, 01 Apr 2024 19:27:52 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Asahi Lina <lina@asahilina.net>, Eric Curtin <ecurtin@redhat.com>, Neal Gompa <neal@gompa.dev>, Thomas Bertschinger <tahbertschinger@gmail.com>, Andrea Righi <andrea.righi@canonical.com>, Sumera Priyadarsini <sylphrenadin@gmail.com>, Finn Behrens <me@kloenk.dev>, Adam Bratschi-Kaye <ark.email@gmail.com>, stable@vger.kernel.org, Daniel Xu <dxu@dxuuu.xyz>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: macros: fix soundness issue in `module!` macro
Message-ID: <06d5ccdb-a5c3-4630-9f97-9a7bdf7b7a48@proton.me>
In-Reply-To: <CANeycqr_AkxTj2iNdnjRFrC-C8npsBtS34V4hNy35RpQHszG9w@mail.gmail.com>
References: <20240327160346.22442-1-benno.lossin@proton.me> <CANeycqp0o-HKBx6nuGCy9DD6mAwoGWzTR6bm5ceajsUhKcZuQg@mail.gmail.com> <d41d123e-d682-4685-88f5-e45567cc1975@proton.me> <CANeycqr_AkxTj2iNdnjRFrC-C8npsBtS34V4hNy35RpQHszG9w@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.04.24 21:10, Wedson Almeida Filho wrote:
> On Sun, 31 Mar 2024 at 07:27, Benno Lossin <benno.lossin@proton.me> wrote=
:
>>
>> On 31.03.24 03:00, Wedson Almeida Filho wrote:
>>> On Wed, 27 Mar 2024 at 13:04, Benno Lossin <benno.lossin@proton.me> wro=
te:
>>>> -            fn __init() -> core::ffi::c_int {{
>>>> -                match <{type_} as kernel::Module>::init(&THIS_MODULE)=
 {{
>>>> -                    Ok(m) =3D> {{
>>>> +                    /// # Safety
>>>> +                    ///
>>>> +                    /// This function must
>>>> +                    /// - only be called once,
>>>> +                    /// - be called after `__init`,
>>>> +                    /// - not be called concurrently with `__init`.
>>>
>>> The second item is incomplete: it must be called after `__init` *succee=
ds*.
>>
>> Indeed.
>>
>>>
>>> With that added (which is a different precondition), I think the third
>>> item can be dropped because if you have to wait to see whether
>>> `__init` succeeded or failed before you can call `__exit`, then
>>> certainly you cannot call it concurrently with `__init`.
>>
>> I would love to drop that requirement, but I am not sure we can. With
>> that requirement, I wanted to ensure that no data race on `__MOD` can
>> happen. If you need to verify that `__init` succeeded, one might think
>> that it is not possible to call `__exit` such that a data race occurs,
>> but I think it could theoretically be done if the concrete `Module`
>> implementation never failed.
>=20
> I see. If you're concerned about compiler reordering, then we need
> compiler barriers.
>=20
>> Do you have any suggestion for what I could add to the "be called after
>> `__init` was called and returned `0`" requirement to make a data race
>> impossible?
>=20
> If you're concerned with reordering from the processor as well, then
> we need cpu barriers. You'd have to say that the cpu/thread executing
> `__init` must have a release barrier after `__init` completes, and the
> thread/cpu doing `__exit` must have an acquire barrier before starting
> `__exit`.
>=20
> But I'm not sure we need to go that far. Mostly because C is going to
> guarantee that ordering for us, so I'd say we can just omit this or
> perhaps say "This function must only be called from the exit module
> implementation".

Yeah, though I do not exactly know where or what the "exit module
implementation" is. If you are happy with v2, then I think we can go
with that. This piece of code is also not really something people will
need to read.

--=20
Cheers,
Benno


