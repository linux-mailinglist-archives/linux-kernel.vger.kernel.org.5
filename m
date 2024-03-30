Return-Path: <linux-kernel+bounces-125720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08842892B0E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 13:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A3C4B21D4A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC06D3770D;
	Sat, 30 Mar 2024 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="f+F9bupj"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C89D1FBA;
	Sat, 30 Mar 2024 12:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711800220; cv=none; b=qYPjOiC9jbpFV2r3VWtBmS5vjM+flGE3JulDMmceLkHLOZS6P9PCSx3Xabcxg5Qt1PpR6dnv780d6kxpfNP+coeyubtsk6VI9agvUIlpjdyFMEC8hu20J6I9AmBwp5hZAXLHkXLbJwPeg0un2uRgTiiFpTLCZ2HfTr6pZBhuyoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711800220; c=relaxed/simple;
	bh=+Nha7AhXlZIaPPsVuUPnRGZTRCFgib3EZhIf2wQU+fA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOYXFqbhLjTjgf148SjtiF7DEEE8UtUdYBSPrby7+hVnShb2CZTqcFAPLGx+Em7FmLtOfks0HpYvbx9o2Ecwy8GyJZIChWgAL5uIRMlIhOvc+Jo2SD7HbAhlWjBRnrqFbvJIDFWMf1wJ0onDump7B98Z5lhX5XwA8EpTHMBP1rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=f+F9bupj; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711800216; x=1712059416;
	bh=3whj0k58pL0GaO5Dv0/Jw6FeGqHzzIhwiZFFSAfmeos=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=f+F9bupjAOinB4jRtXK5mnJLbyT1QFx1iwXvWC5hn1ubqcy0sYFh6tQ+RpcYwo+/W
	 EFQyREP8o86fEprsNdEdxSZmyBQR+zgfN7jD/Ih8tOxnBBUUbnZyVpV1K2MpSFluHy
	 6mJk4Nss7yYMWvUbI8NdvUpxuRJwqhQ5l42Z/N9WykoqUUW+LmA//JMcY8dB1oq8hf
	 9qaG/tVNJsclmVs/3303RIcI71d0UO3EM+LbWQIoPH/c8+0/Rf2DkMh3QrAxSfcHm8
	 wIKPu95RMA0oX6/PCx+MNKhseEj4cW41Wpv+0df6/J96Fdduit96Rrv81ofGInKC3I
	 aHhvl5w0OBxGg==
Date: Sat, 30 Mar 2024 12:03:31 +0000
To: Laine Taffin Altman <alexanderaltman@me.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, stable@vger.kernel.org, rust-for-linux@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: init: remove impl Zeroable for Infallible
Message-ID: <2dd2c052-0d1f-4a77-9fff-1d6db80310e1@proton.me>
In-Reply-To: <F1F3C985-9CAE-4286-B236-4AF6C0918DB5@me.com>
References: <20240313230713.987124-1-benno.lossin@proton.me> <Zfh5DYkxNAm-mY_9@boqun-archlinux> <93FD9491-7E2D-4324-8443-0884B7CFC6EF@me.com> <ZfkW8rwpdRc_hJBU@Boquns-Mac-mini.home> <3FBC841A-968E-4AC5-83F0-E906C7EE85C3@me.com> <6857bb37-c4ee-4817-9b6a-e40e549b6402@proton.me> <F1F3C985-9CAE-4286-B236-4AF6C0918DB5@me.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.03.24 05:53, Laine Taffin Altman wrote:
> On Mar 19, 2024, at 3:34=E2=80=AFAM, Benno Lossin <benno.lossin@proton.me=
> wrote:
>> On 3/19/24 06:28, Laine Taffin Altman wrote:
>>> On Mar 18, 2024, at 9:39=E2=80=AFPM, Boqun Feng <boqun.feng@gmail.com> =
wrote:
>>>> On Mon, Mar 18, 2024 at 08:17:07PM -0700, Laine Taffin Altman wrote:
>>>>> On Mar 18, 2024, at 10:25=E2=80=AFAM, Boqun Feng <boqun.feng@gmail.co=
m> wrote:
>>>>>> On Wed, Mar 13, 2024 at 11:09:37PM +0000, Benno Lossin wrote:
>>>>>>> From: Laine Taffin Altman <alexanderaltman@me.com>
>>>>>>>
>>>>>>> It is not enough for a type to be a ZST to guarantee that zeroed me=
mory
>>>>>>> is a valid value for it; it must also be inhabited. Creating a valu=
e of
>>>>>>> an uninhabited type, ZST or no, is immediate UB.
>>>>>>> Thus remove the implementation of `Zeroable` for `Infallible`, sinc=
e
>>>>>>> that type is not inhabited.
>>>>>>>
>>>>>>> Cc: stable@vger.kernel.org
>>>>>>> Fixes: 38cde0bd7b67 ("rust: init: add `Zeroable` trait and `init::z=
eroed` function")
>>>>>>> Closes: https://github.com/Rust-for-Linux/pinned-init/pull/13
>>>>>>> Signed-off-by: Laine Taffin Altman <alexanderaltman@me.com>
>>>>>>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>>>>>>
>>>>>> I think either in the commit log or in the code comment, there bette=
r be
>>>>>> a link or explanation on "(un)inhabited type". The rest looks good t=
o
>>>>>> me.
>>>>>
>>>>> Would the following be okay for that purpose?
>>>>>
>>>>> A type is inhabited if at least one valid value of that type exists; =
a
>>>>> type is uninhabited if no valid values of that type exist.  The terms
>>>>> "inhabited" and "uninhabited" in this sense originate in type theory,
>>>>> a branch of mathematics.
>>>>>
>>>>> In Rust, producing an invalid value of any type is immediate undefine=
d
>>>>> behavior (UB); this includes via zeroing memory.  Therefore, since an
>>>>> uninhabited type has no valid values, producing any values at all for
>>>>> it is UB.
>>>>>
>>>>> The Rust standard library type `core::convert::Infallible` is
>>>>> uninhabited, by virtue of having been declared as an enum with no
>>>>> cases, which always produces uninhabited types in Rust.  Thus, remove
>>>>> the implementation of `Zeroable` for `Infallible`, thereby avoiding
>>>>> the UB.
>>>>>
>>>>
>>>> Yeah, this works for me. Thanks!
>>>
>>> Great!  Should it be re-sent or can the new wording be incorporated upo=
n merge?
>>
>> I can re-send it for you again, or do you want to send it yourself?
>> I think it is also a good idea to add a link to [1] in the code, since
>> the above explanation is rather long and fits better in the commit
>> message.
>>
>=20
> I=E2=80=99ll try and do it myself; thank you for sending the first round =
for me and illustrating procedures!  What Reviewed-By=E2=80=99s/Signed-Off-=
By's should I retain?

Do you still want to send it yourself? If you don't have the time, no
problem, I can send it again.

--=20
Cheers,
Benno


