Return-Path: <linux-kernel+bounces-158919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0298B26B8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8501C21936
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746AE14D42C;
	Thu, 25 Apr 2024 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="mtUdiBGs"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABF78528D;
	Thu, 25 Apr 2024 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714063341; cv=none; b=MudVVORRxx+EWOIvOpb9KNvxq2jW8vT3PTPubIOXZwqNrHQ9LaTAuZGJ1k877lMZWU+lwhzU9qKR9w+b5RSB/D3Z6vRGcTmaHkGCUrg8uh/3CqG0osxRMypt3ShT33RwgagHLizYlVidcIThX5xM+CwHzuttrexPIzcZ1hsNBkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714063341; c=relaxed/simple;
	bh=Q/D/pXTwAfQjRhdoTeFpIBY9vbHFtbsg1krUpeEtO1I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G9v4k05XvJ5hW8jnqdWePAeDc1oqKG8BcZWlpVC4VFNaAyBwuko3o7sw76pVECCSjUl2LsvzwxejKkFmTuzQ5tMXy18suHQf47XzA2y2axYtyu6ZRzWbWVTk/stlfc/w6EJY2zmQyR1DsmypOyjBi7B97ezzKGjHkdulHjIN/3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=mtUdiBGs; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=2wfsuboutvaw7hlox4qfx64uai.protonmail; t=1714060471; x=1714319671;
	bh=l6ejzdU+/oJTsZFPqAfrkNNF2qMH3A6mlJ13xMJmIUU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mtUdiBGsCrBGGwlAZiHmz9FeQhbxTP52ufvoZLR2FkOCkUvgOKCCx/ios0HZxuj+z
	 bIZowo0duS37tSX/lMt/3KkW0jCAaF+RCCvMSxhORHB3AGi8paUuXHPI5N8AByQ9Yv
	 iaUIfiOgaqW/lcOVOfUof735OWGY9Ki81MSDXCB02aldeRQT6rfmjkHCJpfQAWRgO5
	 hiScGQ7GvgJLzVzSEfVDYp7PixaBHSw8YB03cTXRlmSvJYsS0JGNZ+BEsxcBtAFhnh
	 OgnfgeseSEXrK06FVrh59KV1l93F8Lc8QQpfpDCb7egAaY0EVkGl0tU2ryWAk1AJsW
	 5EkTfiQYzgQsw==
Date: Thu, 25 Apr 2024 15:54:27 +0000
To: Viresh Kumar <viresh.kumar@linaro.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] cpufreq: Add Rust based cpufreq-dt driver
Message-ID: <f02e0c3f-1e24-4ecc-8729-81d99f7543fc@proton.me>
In-Reply-To: <20240422103050.tiecvamrd5upunou@vireshk-i7>
References: <cover.1712314032.git.viresh.kumar@linaro.org> <1792467a772b7a8355c6d0cb0cbacfbffff08afd.1712314032.git.viresh.kumar@linaro.org> <4ff5f30b-f2b8-4625-b3cd-ac08e4ffb068@proton.me> <8c4f2053-acbc-4f4a-93de-18f149c80869@proton.me> <20240422103050.tiecvamrd5upunou@vireshk-i7>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 5d0be9780b09350ea47be15e0ac7434cd03a4b54
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22.04.24 12:30, Viresh Kumar wrote:
> On 07-04-24, 10:17, Benno Lossin wrote:
>> On 07.04.24 11:54, Benno Lossin wrote:
>>> On 05.04.24 13:09, Viresh Kumar wrote:
>>>> +// Finds exact supply name from the OF node.
>>>> +fn find_supply_name_exact(np: *mut bindings::device_node, name: &str)=
 -> Option<CString> {
>>>> +    let sname =3D CString::try_from_fmt(fmt!("{}-supply", name)).ok()=
?;
>>>> +
>>>> +    // SAFETY: The OF node is guaranteed by the C code to be valid.
>>>> +    let pp =3D unsafe { bindings::of_find_property(np, sname.as_ptr()=
 as *mut _, ptr::null_mut()) };
>>>
>>> Drivers should avoid calling `unsafe` code as much as possible. They
>>> also should not be calling `bindings` code directly. Please write (or
>>> find) abstractions for these `unsafe` calls.
>>
>> Having re-read the cover letter, I see that you are already aware of
>> this. If you need any help with creating the abstractions, feel free to
>> reach out!
>=20
> Thanks Benno. I am not sure what's the right approach here as there
> are so many missing things (frameworks) I need. Though I don't need
> full support for them but just a handful of APIs.
>=20
> And then there is dependency on the generic support for device/driver,
> platform device/driver, etc.

I don't know exactly what you are referring to, but you can try to reach
out to other people on our zulip. Splitting the work with others could
help you :)

Also if the frameworks that you need are particularly difficult to
upstream, because they have a lot of dependencies, then you can try to
create something similar to [1].

[1]: https://github.com/Rust-for-Linux/linux/issues/1004

--=20
Cheers,
Benno


