Return-Path: <linux-kernel+bounces-125109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F19BD892040
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C1E1F21B33
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5814404;
	Fri, 29 Mar 2024 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="L/9teXmA"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E37012DD97
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724890; cv=none; b=M72wIoLFZ+Fyg6Hh6yo6PoqZPY+bjpvlD7vh2GoXhqMRaSv3CcHnAFdDech8ud0AAwCOYEvjZqbfl1oOZfIzRZJVad/hhiNZhRzlrJsW+4b4s7faBD2YDnZ2dmv0zf1GPOBkHIop2wjJSn4WqcnvmIa2ow9UeENHlf1n1Paoaog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724890; c=relaxed/simple;
	bh=dxsK+A0zGzWuoyy/rv8SNAdBIJ4VUlSM+Fjev0Dd4os=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UCc5Kha+KIWU4T4TXU/Ewd3+K5rknYBvQN26jpVdpfW0F21fI7UgHgaC1T/EZn4TDzfVa6Xd+wP0ZUNhqrU/XnchpBqZ1hiiG7bYX4XIFIFwpxUnctaNZZcrg1fKn/zvOOh30MdamWF/z14EJx/07gtvT0GJZzwvp4dE6SHKUg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=L/9teXmA; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711724880; x=1711984080;
	bh=TwY71wkAkVzxEFQEXuu91xb0QlVVxXbICyOBQ0qK7/Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=L/9teXmAuZm2PqAvmPxW8XhLSUIku4P5Cw6jwo0QLtWXE+zg367gaLokhspFzj2fJ
	 oNfJyH1SKbPNQK/ua+A2HZWmx+fTTH9NrEPiNkjGJ2/KRLAoZvdA3qArVHKpc5gEts
	 KKjDpfvLbRF7CW6LuLDOmh6JHQTAKRM04lm3Bhf5XCqA4xQqUgUtNN5J0LklXnCj2T
	 cslNiUrNuAyNUicXsNdQyclAjtFWqazLMpUVqQ6MDRcWWmDognXxTe6Ok7XYRqMIsS
	 9Pn491iU9luYMFYz0GNGLb1/lN13eFI0+PiZwVqw9Vnr+iC1kCZ/HcZ7mF6QWO8sIc
	 /s/WM2LjwKoog==
Date: Fri, 29 Mar 2024 15:07:55 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 2/2] samples: rust: add in-place initialisation sample
Message-ID: <6f789e0a-2e98-4ee8-a905-f2ae7c45cc48@proton.me>
In-Reply-To: <CANeycqp08CFeh4rO+b1ocGDp_nViN2uYhL6_RZ4PWn5TeVmNVQ@mail.gmail.com>
References: <20240327032337.188938-1-wedsonaf@gmail.com> <20240327032337.188938-3-wedsonaf@gmail.com> <ffuYV4VQCfRoM7Fws9Z7TOVXS_dJp89q9--Sv9fipzWpOUqkjad5EfXsZPcBZ8ciGzrPo-U-2rEy5CUOitXNp4e4hAJHwZ0uH_u3zDxr0zE=@proton.me> <CANeycqp08CFeh4rO+b1ocGDp_nViN2uYhL6_RZ4PWn5TeVmNVQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28.03.24 14:00, Wedson Almeida Filho wrote:
> On Wed, 27 Mar 2024 at 10:53, Benno Lossin <benno.lossin@proton.me> wrote=
:
>> On 27.03.24 04:23, Wedson Almeida Filho wrote:
>>> +        pr_info!("Am I built-in? {}\n", !cfg!(MODULE));
>>> +        try_pin_init!(Self {
>>> +            numbers: {
>>> +                let mut numbers =3D Vec::new();
>>> +                numbers.push(72, GFP_KERNEL)?;
>>> +                numbers.push(108, GFP_KERNEL)?;
>>> +                numbers.push(200, GFP_KERNEL)?;
>>> +                numbers
>>> +            },
>>> +        })
>>
>> I think it might be useful to also have a field that needs pin-init, eg
>> a `Mutex` or similar. What about placing the `Vec` inside of a mutex?
>=20
> I'm not sure this belongs in a "minimal" example.
>=20
> But I added it in v2 because we're already violating minimality with
> vectors anyway. Perhaps we should later have minimal samples and
> rename these to something else.

I think a fully minimal example would be less valuable as a learning
resource. We can of course have both, but I think having real usage of
pin-init in this example can help people get familiar with it.

--=20
Cheers,
Benno


