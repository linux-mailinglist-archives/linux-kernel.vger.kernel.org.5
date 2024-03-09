Return-Path: <linux-kernel+bounces-97888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4861F877130
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF467281E37
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 12:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF22F3BB4F;
	Sat,  9 Mar 2024 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="PSBu2eQy"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FE828E22;
	Sat,  9 Mar 2024 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709987466; cv=none; b=ppc8IZCHZ50tMmggnvTvfuGs7o+e4OpP4jlJuGGQ+U7erCO3MPQgA91QKlDGoVjS0i2brvRockw/zehd1pc25tFee1VLloDLa3R6ODGHAj1jE2D+Uv6AjbaMl//6YyIS3pqRptxSTL27sDZdKxDhm+MZT6B640NP0PGrZGnF8i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709987466; c=relaxed/simple;
	bh=W7YTL00nz29DAGJaWkG4DPmr0d/GljxYJK7IQ9Pp/nU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aER59QFOaiOxlqtH/OF8MoBKC8rdUgDDAaMrERlNanKFARraOQyghjwxOpJhyWfbCH4IVacLUbo5Dax1CbYELvuLa3SOSi0PIM+UDaNVRbki3WbXc8acBxYGU1H1uQRx3OvL3FSfEgKWArzvTyQTDCaJFP2k3PR7ie+tj/A6wGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=PSBu2eQy; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=m3froqkqbjc2pp2zduek3yuqkm.protonmail; t=1709987453; x=1710246653;
	bh=05L/QFx4kyM1UqnbGE/ORzxwoDQ/tgXCO+v998Lwz+E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PSBu2eQyi/6Nk+GyUT6L1k3cKFcixgwyETajG2gV1Qeq02Ai/SwEMRGeqY1Kir5Gv
	 9l3D5S1GZs+81EnrbegJQ2isiPgt8rEFXEx3HX4TMdsnbtpkFgAxMQiG62186QWHLz
	 ggOhyc5Vlt3XCa7GbXUP3qdqapco38AckZE4pADWONbEK+ftVO9fewqVRvgN9JV1EH
	 a6R2ugY1IRHaoaWhRjIMe0l5HSl9lG84yuSHohnPJ9rO6DfJADS0xHLjWAl0CRrzLh
	 bop9NUyT8H59LU8gq1Wo5SR1SxVUopAiplXT2EAMZcsC/hDbPZPTOMCRggOgJt9ky/
	 P0NwT+znhTzsA==
Date: Sat, 09 Mar 2024 12:30:49 +0000
To: Andreas Hindborg <nmi@metaspace.dk>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, Hannes Reinecke <hare@suse.de>, lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, linux-kernel@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC PATCH 04/11] rust: block: introduce `kernel::block::bio` module
Message-ID: <6cd89162-a11f-4a2f-a609-b6d51caf6ba1@proton.me>
In-Reply-To: <878r34aboo.fsf@metaspace.dk>
References: <20230503090708.2524310-1-nmi@metaspace.dk> <20230503090708.2524310-5-nmi@metaspace.dk> <-SiJ5paRDIUkH1WEWhGhEjhIgFbSo5PJAvac53bTnBZ5o41DR-kNWZEQBsnKeW1FRJh35siVFRrx54L0M6ebSzl0rzecgcDjqZFGRa9uypE=@proton.me> <87a5pcyqf8.fsf@metaspace.dk> <878r34aboo.fsf@metaspace.dk>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/28/24 15:31, Andreas Hindborg wrote:
>=20
> Hi Benno,
>=20
> "Andreas Hindborg (Samsung)" <nmi@metaspace.dk> writes:
>=20
> <cut>
>=20
>>>> +);
>>>> +
>>>> +impl<'a> Bio<'a> {
>>>> +    /// Returns an iterator over segments in this `Bio`. Does not con=
sider
>>>> +    /// segments of other bios in this bio chain.
>>>> +    #[inline(always)]
>>>
>>> Why are these `inline(always)`? The compiler should inline them
>>> automatically?
>>
>> No, the compiler would not inline into modules without them. I'll check
>> again if that is still the case.
>=20
> I just tested this again. If I remove the attribute, the compiler will
> inline some of the functions but not others. I guess it depends on the
> inlining heuristics of rustc. The majority of the attributes I have put
> is not necessary, since the compiler will inline by default. But for
> instance `<BioIterator as Iterator>::next` is not inlined by default and
> it really should be inlined.
>=20
> Since most of the attributes do not change compiler default behavior, I
> would rather tag all functions that I want inlined than have to
> disassemble build outputs to check which functions actually need the
> attribute. With this approach, we are not affected by changes to
> compiler heuristics either.
>=20
> What do you think?

I think that you should do whatever leads to the best results in
practice. I know that the compiler developers spend considerable time
coming up with smart algorithms for deciding when and when not to inline
functions. But they aren't perfect, so if you find them necessary then
please add them.
What I want to avoid is that we end up tagging every function
`inline(always)`, or at least we do not check if it makes a difference.

--=20
Cheers,
Benno


