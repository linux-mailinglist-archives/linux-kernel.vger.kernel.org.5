Return-Path: <linux-kernel+bounces-120739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A5D88DC5B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D885A1F2D7D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F525A791;
	Wed, 27 Mar 2024 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="M0B4jITA"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D1959149
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538332; cv=none; b=NTcqLgGnanc/A9RYbqNe3AtUIp3ZfLAGQcf26YqJH/01I9UhnHDu09He9HbSWvmAh/lN9qNalCU8EjZMS7pesazTT5o9QhpNpxSO1EF0AorBk06UecTShyTLWz7aTn7bKYdO+5f8Fw8iDR1TVL1/4SGbVyVZk1Edvh/sEoTi/2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538332; c=relaxed/simple;
	bh=mhOieoq7DfxAaJ++d+O0WtR+BfTTgESKgZZHlPaztWg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEg0tOXoGqY6M/4FhWLfVqEjpTQElDGzJBFkl+NMiBvihGBE3rQ4GNjH15IcU28QSwti4mqMSSoaFJLxT+fTLMUgiapRfD187AnEEKDsxzwMfbPLqEJWdvP6QDyb92riGjviNUbmUMDonfYhmHFy2DvsXoJR3qdKZWXk1hsCGQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=M0B4jITA; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711538321; x=1711797521;
	bh=b+ixGN0r2/X/83UL4UB0Gt8jkXQcthsc8tHh8gZmqG0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=M0B4jITA+ZBAu+TvTskwA5UPn3mlMurWkFylBxDnHhZW19+fG7cTiwLFINyYSE0oI
	 ZoJ+8kBSbJtbSzvusod86Bd15kt1ix50aAt4SvbxONrXhCKEBjItFc/mrtVySGNDoM
	 LOkRqViBBLNI0Bn3wTDFPuVfM7Kl8hfy25QC+WLhoWIYGA/4eoa61S/07heIgRdQp5
	 oQt6/xQVjjjZwV2q2oJUgAiCqKJbR4vrkLw39rhrW2hAJVYF0UcXViDiz0a0Ds1A74
	 NWEK77SjvvL1UcyQK9yICxHKVgM6VpTg7R8Z7WEH3rLabzNPtNTfAmlWITYQvQOLT4
	 2y6qfHdiG4qug==
Date: Wed, 27 Mar 2024 11:18:28 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH 2/5] rust: time: Introduce Duration type
Message-ID: <e93d124b-e2db-4a7d-848c-6d4fb389d780@proton.me>
In-Reply-To: <ZgMDGYMj7V50PZbP@boqun-archlinux>
References: <20240324223339.971934-1-boqun.feng@gmail.com> <20240324223339.971934-3-boqun.feng@gmail.com> <4hYJbftgOk1JOPbJ6CfKZell6ngp8GljwIUIB1vOQvIf-7jiogG5xDtCvcMlF7cIJAdy9fO5HLQh_8ohnWNB3MAaj0xjAGeyyDowemgunOU=@proton.me> <ZgMBqzv0r98_EGGR@boqun-archlinux> <ZgMDGYMj7V50PZbP@boqun-archlinux>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.03.24 18:17, Boqun Feng wrote:
> On Tue, Mar 26, 2024 at 10:11:07AM -0700, Boqun Feng wrote:
> [...]
>>>> +impl Duration {
>>>> +    /// Creates a new duration of `ns` nanoseconds.
>>>> +    pub const fn new(ns: i64) -> Self {
>>>> +        Self { inner: ns }
>>>> +    }
>>>> +
>>>> +    /// Divides the number of nanoseconds by a compile-time constant.
>>>> +    #[inline]
>>>> +    fn divns_constant<const DIV: i64>(self) -> i64 {
>>>> +        self.to_ns() / DIV
>>>> +    }
>>>
>>> I am a bit confused, why is this better than writing
>>> `self.to_ns() / DIV` at the callsite?
>>>
>>
>> Hmm.. you're right, there should be no difference I think. If there is
>> nothing I'm missing from Alice, I will drop this function in the next
>> version.
>>
>=20
> On a second thought, I think this prevents accidentally divide a
> non-const value, in other words, if you use this function, you're
> guaranteed the divisor is a constant, and you have the compiler checking
> that for you. So in that sense, I think it makes sense to remain it
> here. Thoughts?

I don't see the value in that. It does not prevent me from just doing
`self.to_ns() / DIV` now. I imagine that 99% of the time users will want
to get milliseconds or microseconds and we should have methods for that
(when we have users). But for the last 1% I don't think we need this
method.

--=20
Cheers,
Benno


