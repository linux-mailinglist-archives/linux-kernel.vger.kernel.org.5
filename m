Return-Path: <linux-kernel+bounces-134267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B1A89AFD1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB4DFB21A1E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BE7125D6;
	Sun,  7 Apr 2024 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZgJMAxvj"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAF5748F;
	Sun,  7 Apr 2024 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712480211; cv=none; b=MU+rir1BjA8fKawZPBgfpsK7BsV2PZcriNRGai00qQMqidr9APXr0QsdE8UvFQE1T6a0hxf4MwsFFQXO8Djpd6xTd0L8SXcn1whDkCUYEX2I+ArrP7a6MhgRZ7itxIgOfQHMW1K5TdaUKffH63ABaPgbieCbU8dPT/8iEgCyRF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712480211; c=relaxed/simple;
	bh=lcxJexEkoHogdNOtOs2qWf4QkdeM/dGq8DJ6At4V7Ns=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iB6bD1hCpUxr5ol6DEOQhEllIPq/J+hk3RqtpB4tB5YDw8YdVsshRjs2gApteRHqqtIOCGiWGL3kfIJqIKUG35+Uz57mtwSOu1qSoAi+Ni/0uN/70Cny5ig7j76LCbID8GF2mdV3HODabvs87WZnE4gd2kWIhQLKv+ZJQaojyPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZgJMAxvj; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712480199; x=1712739399;
	bh=fkLAMTA9SYFbeV2VtvwPt35anLNFZH3MmztMTzZClDY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZgJMAxvjg/nMNDu66DoiwGc8Qh7cfbFSk9Ogx0240Ih+NUZcYNXC0WZByINQbrNSa
	 tSH1UZgeDqn5VRKuVtsxNRmLGWB4O7Dm+dbl97MWCdKsuFWvprJSEUi6sJ9WlCqody
	 rOgqVhtZ1gvWY/gkz/IosmLOj/CsfAn17WkiuozUo06nbJTEmtZIb6n3QXrLEjh86r
	 jA3jOIQ0W8eNnHoBi0uCwgZioMZqV0nMWROqotKvIa+tuqtbtTlb7ebZzwed1nYibM
	 ETlSjctnwfvSIvi4XHey1emXm9vSf4fXrkltsGsrTLQMYXhd+mG77Tztv6ZKMXMiwC
	 TP1DVyXtiRAuA==
Date: Sun, 07 Apr 2024 08:56:31 +0000
To: Laine Taffin Altman <alexanderaltman@me.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, rust-for-linux@vger.kernel.org, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, lkml <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v4] rust: init: remove impl Zeroable for Infallible
Message-ID: <3ecba34f-95a2-4f18-9729-f9cb3a4366c0@proton.me>
In-Reply-To: <A68286F0-AB83-4D64-99E3-EE47F03D1AAE@me.com>
References: <CANiq72nyqxH2C1gr=UUCOftaKe0zSuuB++mMUD9zXo-pPBVMVg@mail.gmail.com> <A68286F0-AB83-4D64-99E3-EE47F03D1AAE@me.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.04.24 19:28, Laine Taffin Altman wrote:
> On Apr 4, 2024, at 4:03=E2=80=AFAM, Miguel Ojeda <miguel.ojeda.sandonis@g=
mail.com> wrote:
>>
>> =EF=BB=BFOn Thu, Apr 4, 2024 at 11:01=E2=80=AFAM Benno Lossin <benno.los=
sin@proton.me> wrote:
>>>
>>> I don't see this commit in the kernel tree, what did you specify as
>>> `--base` when running `git format`?
>>
>> Yeah, I don't have it either, but it seems to apply cleanly.
>>
>> Cheers,
>> Miguel
>=20
> I ran `git format-patch origin/master --base=3Dorigin/master`.  I
> can=E2=80=99t imagine how that could have resulted in a nonexistent commi=
t
> hash?

That heavily depends on what `origin/master` is. Is `origin` pointing to
Torvald's git? In that case it would explain why we don't have that
commit hash yet.
Normally you should base your work on the tree listed in the `T:` entry
of the subsystem in the MAINTAINERS file. In our case it is `rust-next`.
But no worries, since it applies cleanly it should be fine for this
patch. Just something to keep in mind if you submit any future patches.

--=20
Cheers,
Benno


