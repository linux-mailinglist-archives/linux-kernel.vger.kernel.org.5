Return-Path: <linux-kernel+bounces-130666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9DE897B70
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2444F28B52B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481BC15689D;
	Wed,  3 Apr 2024 22:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="g5bYXxoG"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C242A138494;
	Wed,  3 Apr 2024 22:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712182199; cv=none; b=RGp/G2TZsV+XYopKKjH+nfdZf1V2Y86OGPkvDHsuFpih1uxtZy578cG3lzt4JzEQhS2bUMZvMaWIUrqIKPpGdCjktuRjPvC/UYwMeBedrjQxNLTIU/DHrVVeBu3TyeSQnGTiGw9T/WKxD1oEIwvswUVaeNB/FZC/RvO0+lZTxWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712182199; c=relaxed/simple;
	bh=uwNMpeVW0XerVfkSfw/u0neKwfY6b63R2YNbmJr2Yis=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUNoS4pF/1cdJ1LvyfZJU5lcTHHSjlnW+Zz1/8rkRs2nqRF9wLLeFFaHMZB9A8CTNq4iyzkJHGby6cRiDjZ9KmHMacy3I3h7FvRVbIE46fLyDHEzEyy7rfvAj0X+FinAzd5TUN1FctVNTRTEPX2UhPQ7vXtzTTNKby+4VBmpew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=g5bYXxoG; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712182194; x=1712441394;
	bh=uwNMpeVW0XerVfkSfw/u0neKwfY6b63R2YNbmJr2Yis=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=g5bYXxoGqxndHYNWtHzNmrse6m3z5qOIF+gu68LKmOKnr+k4nvWNFRZFmuzSCL27m
	 MEtSUXKDZvUfSeTxpEOSlJpmmThUZJzQ6WzqxVovKrEkcysS97yv4+8BFV+aDZjLaZ
	 MFeElpdfeFKDS5otZd6M348XeEjWZgehSR8Lyl2NEcEbZ5f8ir2AhzN5IntLWazftB
	 6hxFE16N5sOG0dSm9nAnK8o7iWeXqd2DpCBjMUFMvbps39F9y6KPva2/P8lq3yGP7F
	 Z7kJvVtgIEJNLy4s7laA1lq2v7sOS10fHlXrivXbvnjsnBs/L7IcqUAz1E2D2odndk
	 gGihGxgtcgB+Q==
Date: Wed, 03 Apr 2024 22:09:49 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: init: change the generated name of guard variables
Message-ID: <ef1400ae-ba9e-4656-98db-a882ac720c1e@proton.me>
In-Reply-To: <Zg3IHZfYVEOh7nc4@boqun-archlinux>
References: <20240403194321.88716-1-benno.lossin@proton.me> <Zg3IHZfYVEOh7nc4@boqun-archlinux>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.04.24 23:20, Boqun Feng wrote:
> On Wed, Apr 03, 2024 at 07:43:37PM +0000, Benno Lossin wrote:
>> The initializers created by the `[try_][pin_]init!` macros utilize the
>> guard pattern to drop already initialized fields, when initialization
>> fails mid-way. These guards are generated to have the same name as the
>> field that they handle. To prevent namespacing issues when the field
>=20
> Do you have an example of this kind of issues?

https://lore.kernel.org/rust-for-linux/1e8a2a1f-abbf-44ba-8344-705a9cbb1627=
@proton.me/

--=20
Cheers,
Benno


