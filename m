Return-Path: <linux-kernel+bounces-162772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E70DD8B6051
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EBE41F21E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D802C1272BB;
	Mon, 29 Apr 2024 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CpVuOMEf"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5E0126F2C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412668; cv=none; b=bFyhEmZgF2WBcLfNWmI7Y0fo4WN/znHoLaAC1P5q/xJdX35STgkWrxVUCwhSIMvyOt1nFqcC3FxlYQW4ODr0To2yc6emKn9374Wx45hRSLoY62L4MiMSkEqraJlPYfDKZcdwcq7rueKTbaLkXJ+DanEOyJZ78gR8g8yvUrwlhGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412668; c=relaxed/simple;
	bh=OHfQy3ul0uJldKkAAD2jEbA5GG0EwQWPkz9F2GwnSwk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UkhLkRhvq34GMccBMPBA5ueGCRLDpb0e9+qRJ3c4eb6jp+pu+ijOHZ/DSO30iIMoNjsHH8WlEAK0NYsil8sCgTRypGlsQPewk/LIrrzlGdmRdK21lRLil64i9IKhw8Fkoi5bMuACMrOqFh1rhNoP4JCSMMs2pgq5G0rZ07VUHtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CpVuOMEf; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1714412658; x=1714671858;
	bh=OHfQy3ul0uJldKkAAD2jEbA5GG0EwQWPkz9F2GwnSwk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CpVuOMEfhiBareejLuxq0hLh7zbxrwQ/GykeqzJcLa9ebtFMNbCTm5s9VZmyzm9bJ
	 tWzL14T21dzBgZ5z5/rNuWVj4TZEd9GzWJjGuX1u1Jhno3ElH0uila5jsDJh1mi3XH
	 +r9pe5EwjbfhtdafPXMH9B1tS3/9CUv9ovw+F5o7N8xcUZGamFlIGYVNZEcJo5YK/h
	 1325U5sWLn0qkAdkbNqU0puyQX2AHmrsf9wtc9D0ZQ+cQP0BNBiM0xfup1ycCtD4as
	 vVwJEEE1/pQkN0juSqP/GBmZAOu7oNnPVjPh7wYBbSdQurgUHL1X3blaAO2YzO9HeT
	 K8eJBTDgtwFEw==
Date: Mon, 29 Apr 2024 17:44:13 +0000
To: Gary Guo <gary@garyguo.net>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: init: add re-initialization functions
Message-ID: <d264de17-acc2-4345-96be-d5f4bcd3cffc@proton.me>
In-Reply-To: <20240429132415.3039940d@eugeo>
References: <20240425213419.3904105-1-benno.lossin@proton.me> <20240425213419.3904105-2-benno.lossin@proton.me> <20240429132415.3039940d@eugeo>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e96a42a100e9fa8aa33d798ae6d460c115f85155
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.04.24 14:24, Gary Guo wrote:
> On Thu, 25 Apr 2024 21:34:44 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>=20
>> Sometimes it is necessary to split allocation and initialization into
>> two steps. One such situation is when reusing existing allocations
>> obtained via `Box::drop_contents`. See [1] for an example.
>> In order to support this use case add `re_[pin_]init` functions to the
>> pin-init API. These functions operate on already allocated smart
>> pointers that contain `MaybeUninit<T>`.
>>
>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>> Link: https://lore.kernel.org/rust-for-linux/f026532f-8594-4f18-9aa5-57a=
d3f5bc592@proton.me/ [1]
>=20
>=20
> I don't find the re_init name very intuitive. From the name I would
> imagine these functions be taking a `Box<T>` and a `impl Init<T, E>`,
> dropping the content and produces a `Box<T>` again.

I see your point, but if you look at the link [1] from above, you will
see that there such a function wouldn't be helpful.

> Would it make more to rename the existing functions to have `new` in
> their name to indiciate that they allocate, e.g. `pin_new`, and have
> these functions that only does initialisation `init`/`pin_init`?

Since we now have full control over `Box::new` (via `BoxExt`), we could
also make it take a `impl Init<T, E>` instead of just `T`.
And we could also provide `fn pin(impl PinInit<T>) -> Pin<Box<T>>`.

I would happily rename the `re_init` functions to `init` in that case.
But if we don't want to do the other rename, then I think it would be
confusing to have the functions `new(T)`, `pin(T)`,
`pin_new(impl PinInit<T, E>)` and `new_in_place(impl Init<T, E>)`...

--
Cheers,
Benno


