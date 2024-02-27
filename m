Return-Path: <linux-kernel+bounces-83280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1911786913D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ACA81C2541C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A1B13AA58;
	Tue, 27 Feb 2024 13:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dbMq4gCk"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A001913AA2C;
	Tue, 27 Feb 2024 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039006; cv=none; b=BRQFAIJyzCKgOuz+3pDjSe5wmopX/B3Qrnnjl1aivp0/gj9TeYRr6fpPV84ySuWslj1SZyhriBj5SfFgZ/CbiZ81zVtmKRfSW2xwl6ZbkRDrYqHp+Ed6PyziGuJyHeRxaiYsA83D0f0QizBaseMLZEK544HsL7fJzw8t5XHEaHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039006; c=relaxed/simple;
	bh=MXbXhXbeu0cQ9TFbNb7UEonPBK55rX+buvq6bECICU8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7OIe5VDQ/v7G4APezyu2OUS/qX3Q1M70mxZlN7vCF9E2sibfZUVJFmReBsSxVcW0fhxYas4Ndj16OLelmNGweN1LSgB1gQgB2h5bdBjrojocndDp2k4UikoGo4jym3kVussvlQ1dsMFv1Kz6F87K1wcCPi5qKlMDb+PHjtzlwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dbMq4gCk; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709039005; x=1740575005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MXbXhXbeu0cQ9TFbNb7UEonPBK55rX+buvq6bECICU8=;
  b=dbMq4gCkgozKQM5P+r2OnRtqJAfxkPSoSuC2Zgw2UNuY9q1ijh1RLmXV
   sZEJVlpjTv3wDoDknTPqIC7OkS1qdafgu3GLasjzJ7ViVJ5AW2B5/GDxw
   riu1M+HgBYPD7IEY7XSJevkxT9mainLserfXEvSATCXXrHzpJ8NJi8bfi
   nDKw0u0IGC/LBItZW64iQ1AA6ORVuMW/uq/kO26lVzrIf47umGCN1UiZ+
   3S5BJWs0kljGsKRgMUh9qticT61N54/SxRfM3qSJ8Vvjk6U09n0rXFTJD
   3XcBN2Y1c/iTwKVMJhf6skHXOtpewFpssw+TbRKEXlWVg0MRd96Y7amsT
   g==;
X-CSE-ConnectionGUID: we5qw0mfT+K6Mg0u+ozr0g==
X-CSE-MsgGUID: mMGKrDnoRIqlIlHrvTgxew==
X-IronPort-AV: E=Sophos;i="6.06,187,1705388400"; 
   d="asc'?scan'208";a="247636234"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2024 06:03:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 06:02:58 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 06:02:54 -0700
Date: Tue, 27 Feb 2024 13:02:11 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC: Nathan Chancellor <nathan@kernel.org>, Conor Dooley <conor@kernel.org>,
	Matthew Maurer <mmaurer@google.com>, <linux-riscv@lists.infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson
 Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary
 Guo <gary@garyguo.net>, =?iso-8859-1?Q?Bj=F6rn?= Roy Baron
	<bjorn3_gh@protonmail.com>, Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Nick
 Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
	<rust-for-linux@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
	<stable@vger.kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Ramon de C
 Valle <rcvalle@google.com>
Subject: Re: [PATCH v2 1/3] rust: make mutually exclusive with CFI_CLANG
Message-ID: <20240227-unwind-canteen-3da9b07af10c@wendy>
References: <20240223-leverage-walmart-5424542cd8bd@spud>
 <20240223-perjury-preshow-fc2cf73d552e@spud>
 <CANiq72=mCnm0mKOw5K44PmZ+jF=67jxEEkcXP-E0O8CaUrps=w@mail.gmail.com>
 <20240227-uncertain-amaze-6197e627ad95@wendy>
 <CANiq72=geBobqM0Dc2yv=NjAc3MWXhOrDHfuJ84TgQ+XVxBo0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W8J+rAw6y6pbbfl0"
Content-Disposition: inline
In-Reply-To: <CANiq72=geBobqM0Dc2yv=NjAc3MWXhOrDHfuJ84TgQ+XVxBo0w@mail.gmail.com>

--W8J+rAw6y6pbbfl0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 01:34:14PM +0100, Miguel Ojeda wrote:
> On Tue, Feb 27, 2024 at 11:54=E2=80=AFAM Conor Dooley
> <conor.dooley@microchip.com> wrote:
> >
> > I did try to test it but I ran into too many toolchain issues - my
> > older copies of LLVM (pre 17) are not multiarch as I built them by hand
> > with PGO for x86 and RISC-V. My LLVM 17 is from kernel.org and has no
> > libclang. And then the copy of LLVM 18 on kernel.org apparently does not
> > support kcfi at all. I gave up there, but I don't see how this would not
>=20
> I asked Nathan to add libclang a few days ago, and he very quickly did
> it for LLVM 18 -- though I don't know the plan for the others. I just
> pinged in that thread.

I had actually said it to him on IRC already (although he is CCed here)
but I just noticed that this was my fault - I symlinked incorrectly
after downloading the toolchain. kcfi is detected fine with llvm18.
I'll give testing another try.

--W8J+rAw6y6pbbfl0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd3dUwAKCRB4tDGHoIJi
0iscAQCFqXISaMEU8lWDJeRHwsnAImvV4ocTSMxS5RJFKcJHqQD/a/u0vuVtSyp7
18rvQE+YASYYpq5tCU08KsgXCbSU7gI=
=o4T8
-----END PGP SIGNATURE-----

--W8J+rAw6y6pbbfl0--

