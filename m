Return-Path: <linux-kernel+bounces-83082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74513868E29
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD1328B562
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D46313958D;
	Tue, 27 Feb 2024 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qZl+MIli"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC621386C3;
	Tue, 27 Feb 2024 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031292; cv=none; b=NfmaiTOOjaCbOhSLNPTR7K4SSrmti5iiCj7GuJWckBPjPGbgsmIB0Zg6l4xarFZTMArDvvScX3cJG/uFrJKpkqAMa8k5GjaXErNfK9mnbIaF32rivZSI5o3R/h+dicQWAg7icIz6k0D+Z2n7HAB2IM+wogoSwVolbqnHvs0D+Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031292; c=relaxed/simple;
	bh=2dJXeGkL18BLr3sq0Pf/vdUj3hVf2tCKH8bAhmkTlSk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXRJ8w5SFwXzBAuu+BHYKbR/tmeDJ2N0iG+OHcpPJ8fjFjCSQrZMMEzxu8Mhah7OB7QTqW0XNLHG4NN8cuTACU2G5Xjp26PSeqaPN4qaDf3JB2qypcVT29c62XeAQKy3MQdX4I0iV7i7GvT5hvuPs4xu0i5HRclWes2zZ9xSpo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qZl+MIli; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709031290; x=1740567290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2dJXeGkL18BLr3sq0Pf/vdUj3hVf2tCKH8bAhmkTlSk=;
  b=qZl+MIlifaAXUoAN2GsfM8XC4a1AIWPcgtEbJIL973rxggAGBPxbR6Vs
   gTtvxuuWT6AgsolvJu48+XB/7bjL+XQZhgGTxNv7gQCasPrTZe+WSUsBX
   JdX/bXGSAcLPD3wqT0+7HIthcBVtS5I4Fg+Gcj988ljY5Vy37R203BP/X
   DWsbF4UbWC3rEG8GuLWuDKgA3p1Gkc8aG7XU8NRF9aDyZ9dZ4UNXeC1dV
   vooiKRd/vT6+M3TNnfi8t9W4mDKPT95cksEAy1wuVWFsOQUzCl1vP2eRr
   b7hdaKjA6yOzKORtKEHW7iQQ0r0N4VU1EmrQjQrv9uOt3u3/kS9D0KZw0
   g==;
X-CSE-ConnectionGUID: 5VRzFmqxShG6JMonl7+fzw==
X-CSE-MsgGUID: 8on+D4dCRzeaeBB4CqE2NA==
X-IronPort-AV: E=Sophos;i="6.06,187,1705388400"; 
   d="asc'?scan'208";a="18451573"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2024 03:54:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 03:54:22 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 03:54:18 -0700
Date: Tue, 27 Feb 2024 10:53:35 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC: Conor Dooley <conor@kernel.org>, Matthew Maurer <mmaurer@google.com>,
	<linux-riscv@lists.infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Jonathan
 Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
	<rust-for-linux@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
	<stable@vger.kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Ramon de C
 Valle <rcvalle@google.com>
Subject: Re: [PATCH v2 1/3] rust: make mutually exclusive with CFI_CLANG
Message-ID: <20240227-uncertain-amaze-6197e627ad95@wendy>
References: <20240223-leverage-walmart-5424542cd8bd@spud>
 <20240223-perjury-preshow-fc2cf73d552e@spud>
 <CANiq72=mCnm0mKOw5K44PmZ+jF=67jxEEkcXP-E0O8CaUrps=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qesnKr6zWGeidy+1"
Content-Disposition: inline
In-Reply-To: <CANiq72=mCnm0mKOw5K44PmZ+jF=67jxEEkcXP-E0O8CaUrps=w@mail.gmail.com>

--qesnKr6zWGeidy+1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 03:45:10PM +0100, Miguel Ojeda wrote:
> On Fri, Feb 23, 2024 at 2:38=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > configuring a kernel without symmetrical support for kfi.
>=20
> Nit: typo.
>=20
> > This probably needs to go to stable. The correct fixes tag for that I am
> > not sure of however, but since CFI_CLANG predates RUST, I blamed the
> > commit adding rust support.
>=20
> Cc'ing Matthew et al. in case this is a problem for them, but I guess
> we can relax it later as needed.

I suspect that nobody has actually sat down and tried it.

I did try to test it but I ran into too many toolchain issues - my
older copies of LLVM (pre 17) are not multiarch as I built them by hand
with PGO for x86 and RISC-V. My LLVM 17 is from kernel.org and has no
libclang. And then the copy of LLVM 18 on kernel.org apparently does not
support kcfi at all. I gave up there, but I don't see how this would not
be a problem on other arches, given rustc never gets told to enable
kcfi.

Cheers,
Conor.

--qesnKr6zWGeidy+1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd2/LwAKCRB4tDGHoIJi
0kCFAQDbFb4J84k51y4ZZDP1Z2Nwwsm14EnLI4s7gDvdwmNr2wD/V+413aDcYoix
UrYilvihx41Q4hI/sSLoniAT8LzW/Qg=
=eco2
-----END PGP SIGNATURE-----

--qesnKr6zWGeidy+1--

