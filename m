Return-Path: <linux-kernel+bounces-83091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2038A868E50
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4627B248E9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8688F1386DD;
	Tue, 27 Feb 2024 11:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kAeNuAsj"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36A6130ADF;
	Tue, 27 Feb 2024 11:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031909; cv=none; b=Swst7tOP2pbUt09Ph7Kegk1skotXL3e8nmK/g7i8czHY8dEFMztezXPvWV4w33corRnF1jlyXNioLj4/FX/YRNgOCaU40hEpdjL9/DEMst5CJ7EGRUKP+nI94seLnOmS4fBCSG5UGryKf7xdhemmw1VvU8og2gXGzImMVm1YEe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031909; c=relaxed/simple;
	bh=nkEmgcF2sqsTVrDLvW1DSslli5qr0PA0DGExmFUENFo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdKmkEVxGKrbo+44kAC+di+AkuQm4HFeVeOFaZwULBEWhkNNbLfrTaLaYoLNaeoY7mOA5uqpMa4GH6xKj7OOW5aseS212vFDxQXDTOm9PT6xzsmsj+f5SJrn4NwchD1hJw4r6FSPDjah7qFUW0nl3A5NujiRRLOyRZEtFYeMLy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kAeNuAsj; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709031907; x=1740567907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nkEmgcF2sqsTVrDLvW1DSslli5qr0PA0DGExmFUENFo=;
  b=kAeNuAsjZPcZrxLSW2xXHhiW9q4lVKoBtABPTYFaZq8pVJn4m+uUPG/I
   BRjWKJalUXetz5phBc2adYGTqvJc/VncHCPFn6f8KoAnxJa3k2dfU6z32
   q3Be0IoPRys7MfdcwITd/Yd19x43PedJulUC9HeqbUTvlP/mflJKUAhcs
   zD3eAoEGpA/Y2M6VaSSDDtvkzn8k92q6/kwyY96N51g1fJM37FEjwEE3J
   HEyl7q9lqyQMrjARIjHsRkYcuYbdpzRIp8UF4rd+qgj6VfWeTUrvB9DXp
   29CxDbot132UQptmp5NhC5xayVVPLsiUPA/tTOm678etVoSoRcs1PhjMN
   w==;
X-CSE-ConnectionGUID: hJeSGw/8TAyVRlagmnchCA==
X-CSE-MsgGUID: KTDcPATNQk+OtFWm54w0BA==
X-IronPort-AV: E=Sophos;i="6.06,187,1705388400"; 
   d="asc'?scan'208";a="16880169"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2024 04:05:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 04:04:59 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 04:04:56 -0700
Date: Tue, 27 Feb 2024 11:04:13 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC: Conor Dooley <conor@kernel.org>, <linux-riscv@lists.infradead.org>, Miguel
 Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida
 Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
	<gary@garyguo.net>, =?iso-8859-1?Q?Bj=F6rn?= Roy Baron
	<bjorn3_gh@protonmail.com>, Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, <rust-for-linux@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>
Subject: Re: [PATCH v2 2/3] scripts: generate_rust_target: enable building on
 RISC-V
Message-ID: <20240227-glove-underwire-f562a56cf2c7@wendy>
References: <20240223-leverage-walmart-5424542cd8bd@spud>
 <20240223-employee-pessimism-03ba0b58db6b@spud>
 <CANiq72ngEZskjH0f=8+cJuQsFTK227bGCxe5G0STMHuPbZYnXg@mail.gmail.com>
 <20240227-resolved-deceit-4a59a6af5b71@wendy>
 <CANiq72mwM+4Oh-H5WmRoqQ_nE1w-eJ1wn-nEwS=BR9JRwzxMMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4yFQMGvLloPM49wl"
Content-Disposition: inline
In-Reply-To: <CANiq72mwM+4Oh-H5WmRoqQ_nE1w-eJ1wn-nEwS=BR9JRwzxMMQ@mail.gmail.com>

--4yFQMGvLloPM49wl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 11:46:42AM +0100, Miguel Ojeda wrote:
> On Tue, Feb 27, 2024 at 11:17=E2=80=AFAM Conor Dooley
> <conor.dooley@microchip.com> wrote:
> >
> > Sure, I'll take a look.
>=20
> Thanks!
>=20
> > Nah, I think that is silly. Either this goes in as-is, and there's
> > fixup done by Linus, or the thing should be converted to match arm64,
> > assuming that that is possible.
>=20
> Ah, so you are going for 6.9 too? I can give the series a try on my
> side in that case. When do you plan to apply them?

If they're to be applied, it would be Palmer, not I. And if history is
any guide, it could be into the merge window. My point though was more
that either this was acceptable for v6.9 or would be v6.10 material
with the same mechanism as arm64. Rebasing after v6.9-rc1 but not
adapting to that way of doing things is what seemed silly to me, since
if a resend is required then the other improvements should be carried
out at the same time.

Cheers,
Conor.

--4yFQMGvLloPM49wl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd3BrQAKCRB4tDGHoIJi
0l+1AQD2Kv7qn0sG5InjsblGeMCFLO+iLg5s4b1JdnY/mXJAMgEAnPLESP1zEN5H
BZ6fe0suc1bctDUkHs99G3uQ759MlQc=
=9yZw
-----END PGP SIGNATURE-----

--4yFQMGvLloPM49wl--

