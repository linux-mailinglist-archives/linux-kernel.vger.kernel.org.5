Return-Path: <linux-kernel+bounces-83017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAFB868D25
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFDB8284B92
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B981384BE;
	Tue, 27 Feb 2024 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ybC+BVUJ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D81A137C54;
	Tue, 27 Feb 2024 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029064; cv=none; b=DXqlJ1JwWWakbWlgb4pqs52N3kTJ3G/yn4Hy1/JemcJwbMvsTau/2wntnRnk+1dWNOTAXGqqtcXPMUzVLAjrKhJLYvvQH2pAFfyGKlwjDmYqA1HJAYovelNPAK4mfDW9lNKaPp9oOKLsBmqHmTvdlsYsEH+ymxEzF32jYVF2qmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029064; c=relaxed/simple;
	bh=BCYUXwloy7tx6CRy691yjbouMr/IoorgoY29ZokBmYE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6WsKkeSvcRFCgtfhDokrSUB7Z07Y7/GHZFiv/F5vHTogD9w4emsMKpMYx5Hij7x+N1DZSXBb/B+LHoHg1vQeJ3bpavm6hC2ZdGgF5+e5F6bBlSRTMdl62T4lb+vw+wdyDylefSfjNb2YICupIgbEb2hnVCmWnm2aVYW1q+LgIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ybC+BVUJ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709029062; x=1740565062;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BCYUXwloy7tx6CRy691yjbouMr/IoorgoY29ZokBmYE=;
  b=ybC+BVUJgzou+CI5al+qwjYyEMIKqTbwgt+seo2rGNUAwpjO3uC/iho8
   03o0R2Ipnvf63xRs/sx18Q019EYSzwAO+dB4mqeHnNnSUudr/h5F+FMCd
   5/b/E1ZijgX+O/3T7awSPngNo1KYzhRZNP9OeZvUiFtBvhImoW0jJS408
   JG+DY5Gb9MizrIY8UJ0wWEF2r32mFqF70MwBlArpMkivHWIP5MlpB/wyQ
   w5D1uHcm+2hdmSL6toKJxCq6gwRbZWyBraunNlIUW4z6RyGEG8DA42x+j
   crEeFtB/4mSHadsJuKp2gh9pTqy/51zZCzVSkNjnTzoao3ueJGjzEL3G7
   g==;
X-CSE-ConnectionGUID: LY36k2aJTB+eb3sMK+kGPw==
X-CSE-MsgGUID: hIqM4eg7QzWgtrOMupVYnQ==
X-IronPort-AV: E=Sophos;i="6.06,187,1705388400"; 
   d="asc'?scan'208";a="16878492"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2024 03:17:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 03:17:12 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 03:17:09 -0700
Date: Tue, 27 Feb 2024 10:16:26 +0000
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
Message-ID: <20240227-resolved-deceit-4a59a6af5b71@wendy>
References: <20240223-leverage-walmart-5424542cd8bd@spud>
 <20240223-employee-pessimism-03ba0b58db6b@spud>
 <CANiq72ngEZskjH0f=8+cJuQsFTK227bGCxe5G0STMHuPbZYnXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q7uzvEFdRZs2AO5O"
Content-Disposition: inline
In-Reply-To: <CANiq72ngEZskjH0f=8+cJuQsFTK227bGCxe5G0STMHuPbZYnXg@mail.gmail.com>

--Q7uzvEFdRZs2AO5O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 03:39:47PM +0100, Miguel Ojeda wrote:

> Conor Dooley <conor@kernel.org> wrote:

> Thanks for this Connor!




> arm64 is sending these for 6.9:
>=20
>     https://git.kernel.org/arm64/c/f82811e22b48
>     https://git.kernel.org/arm64/c/724a75ac9542
>=20
> So it would be nice to see if it may be already possible to enable it
> via a builtin target + flags instead of the custom target, e.g. arm64
> does:
>=20
>     KBUILD_RUSTFLAGS +=3D --target=3Daarch64-unknown-none -Ctarget-featur=
e=3D"-neon"
>=20
> and so on.
>=20
> If it does not work, it would be good to know what would be needed for
> RISC-V and put it into the unstable features / wanted features list
> for Rust.

Sure, I'll take a look.

> Either way, it is not a blocker (although you will need a rebase after
> arm64 lands to use the `target.json` in the right places).

Nah, I think that is silly. Either this goes in as-is, and there's
fixup done by Linus, or the thing should be converted to match arm64,
assuming that that is possible.

Cheers,
Conor.

--Q7uzvEFdRZs2AO5O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd22egAKCRB4tDGHoIJi
0i2xAQCRgFXg1ZapmwoJszFsyzygxNYjswLT1sD8OtIU1BPdWgEAwEJBWvVFMPMo
eBGiUJpqcMZ92Gg1yEfHXhd17awAWww=
=SKPI
-----END PGP SIGNATURE-----

--Q7uzvEFdRZs2AO5O--

