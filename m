Return-Path: <linux-kernel+bounces-158845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E1B8B25AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B964284680
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FA814D280;
	Thu, 25 Apr 2024 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Mzei7UZm"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881B212B156;
	Thu, 25 Apr 2024 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714060302; cv=none; b=i7BcfNXO5DdZPZ4QGTtyvHrrBiZwbydFlHvZBr+Zcb1ovNWBB43mnbNfFhvpwjsNDoh+XSayEvt7ibMdDl0gWa/rsN5lo1U30NjAe32ZR2Xftag1NwyajrSyrtUbwcBkml447tQ8JODz4gluk5DZ3rkh6VZzskQtEmV016xFI9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714060302; c=relaxed/simple;
	bh=JnNuiwEjp88T0SxNSyjjxPwL8xwkm7/welwhj9Mm3fU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ju87+G1RaxgroRRaTjWTQj3Gm+Du0kK6HvQQEAwS6adZaax7+E9bAkmm2jfqtIGmtXytisg4n2ojWg2ZNiUNTHcB2Rlou+HbK39fMgoKk6ctXkXHjBc8olMQ72gx4qSwPESrdClP65A6qEmgkV3ohPde8PgGex6UeQUcuYq7tcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Mzei7UZm; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1714060292; x=1714319492;
	bh=kVfecRLul1bWESph5bgI+QIEjsAZi68hrnU3YEYNhsU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Mzei7UZmRTxq/ydowLnAD+P4ThggwXzpEPGgfRubUFcYtbOKJnxjGIMfuem/SQvIM
	 +yHk5RLEQPGxp+XREUAiXeGMGWjrGprT0VJ1jj3MH2/b55hvKujgkxco0T7WQlpbLl
	 yPxwxkPq84udniaYcvemwXAOle5lSAnfzBosSNAQMUWpgB6Oo1uOvo+sd1txeZ8Lo0
	 qlw+gEwwul2Yo1FzC1OSiwBt1AO7mDOp2atcdcPijyM+M4Cc/lpspQTR5Z11ul9dZS
	 I4JOWa/3ugKXcZuGKnhA+0u1LyjFwzPZr0Zwj4vKDZ4TvjMVk6Odt2wCipuVBPI8PT
	 GgiMeTOM3/kZw==
Date: Thu, 25 Apr 2024 15:51:29 +0000
To: Viresh Kumar <viresh.kumar@linaro.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] rust: Add bindings for OPP framework
Message-ID: <5a6542d6-4644-4083-99e4-73de7038fe92@proton.me>
In-Reply-To: <20240422102415.xvmuja6bdfxgl4pv@vireshk-i7>
References: <cover.1712314032.git.viresh.kumar@linaro.org> <06bb914eae00671a69b393bf86bb01ddec86c16f.1712314032.git.viresh.kumar@linaro.org> <ff6c7d5e-d6e9-4331-b8cc-eab139160e59@proton.me> <20240422102415.xvmuja6bdfxgl4pv@vireshk-i7>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 50e695419f6a03950bbc639587da801f21c5bfea
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22.04.24 12:24, Viresh Kumar wrote:
> Thanks for the review Benno. I was waiting for more review comments to
> come in and hence didn't reply earlier with an update.
>=20
> On 07-04-24, 09:54, Benno Lossin wrote:
>> On 05.04.24 13:09, Viresh Kumar wrote:
>>> +    clk_names: Option<Pin<Vec<CString>>>,
>>
>> Why are you using `Pin<Vec<_>>`? The vector may reallocate the backing
>> storage at any point in time.
>=20
>>> +    /// Sets the configuration with the OPP core.
>>> +    pub fn set(&mut self, dev: &Device) -> Result<()> {
>>> +        // Already configured.
>>> +        if self.token.is_some() {
>>
>> Why does the config hold onto this token? Would it make sense to consume
>> the config and return a `Handle` or `Token` abstraction? Then you don't
>> need to check if the config has been "used" before.
>=20
>>> +#[repr(transparent)]
>>> +pub struct OPP(*mut bindings::dev_pm_opp);
>>
>> I think you should use the `ARef` pattern instead:
>>
>>       #[repr(transparent)]
>>       pub struct OPP(Opaque<bindings::dev_pm_opp>);
>>
>>       unsafe impl AlwaysRefCounted for OPP {
>>           // ...
>>       }
>>
>> Then you can use `ARef<OPP>` everywhere you use `OPP` currently.
>=20
> All these comments look good to me. Updated the code with them (not
> reposting them for now)

I currently do not have a lot of time, so I will re-review it when you
post a new version.

> -------------------------8<-------------------------
>=20
>  rust/bindings/bindings_helper.h |   1 +
>  rust/kernel/lib.rs              |   2 +
>  rust/kernel/opp.rs              | 888 ++++++++++++++++++++++++++++++++

One other nice thing that you could do would be to split this patch into
multiple smaller ones. That makes understanding the pieces a lot easier.

--=20
Cheers,
Benno


