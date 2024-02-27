Return-Path: <linux-kernel+bounces-83241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E37BD8690B1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 852F5B2103A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE61F136667;
	Tue, 27 Feb 2024 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hqnyz1zy"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0E11CD3B;
	Tue, 27 Feb 2024 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709037448; cv=none; b=HFEj8AtQAnf6LzYcPgGJru9Fl2TIVwrpWpIeGUSEESe6CEN9tloy6waFqXD33YH9Da6tVajGY/8QUavkN5iOyqErjdCZaIZQJi3wkRE6A1iH/AVXXUqjyizomoyMliIhFla20taPPVdAmLqGJHX6Ouh3GnXha4IYIO6EKZ2AUX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709037448; c=relaxed/simple;
	bh=vL3h/IKG2Lc53EUgGT8KSBiS7JMMvvCh4EzUmuDxQuI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrshsZqcllTisn67flBj+K2kIqhnyyr8DRAVpnGCqiTPiuhYmk4R/kUO2tZPguQNP97t3uxMPf3SJlbDfyLdvghyQX7xLaZeqTkVvD+stcxmnb97H8KuAgfweJoaEwB4DaadzY9G8ZTMoSUjI3woEJSVjGkBT90qZZpP4+Lc/x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hqnyz1zy; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709037446; x=1740573446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vL3h/IKG2Lc53EUgGT8KSBiS7JMMvvCh4EzUmuDxQuI=;
  b=hqnyz1zyUmFx0mZVDgnVpoyeyc98LDGtGQqep23JBNikKIOmNQtYPZZw
   Cpuaj2zj+Tzm0OaYn44FFbNiuhZfKCPVdGz4bqc/rVeOuj93HTV9CN3ID
   0vqVDPNwN1LlkGgg6dO0qVneqptTd78uraVSU1GLMEt8UF5bFzo2ii90Q
   RNP9MJ7o1yZboZmqIZe/ZRdV97d7QsDFyiK0FAlxRLtdXL66fleo2VY86
   50RQy2yTVxaNjlJRWxY329KQi+Izk05Pvl1r85tnpjmce0o3oXpAzA1SS
   pmFp//244xdLHXb8kLtfifufNI+wMWrmwzWBCHmBDOkH0qH7QZB1Jxv9Z
   Q==;
X-CSE-ConnectionGUID: RIjtrF0uTky5IbYLb0NUFw==
X-CSE-MsgGUID: VyN+l4VUTNyBBErAHgla5w==
X-IronPort-AV: E=Sophos;i="6.06,187,1705388400"; 
   d="asc'?scan'208";a="16883354"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2024 05:37:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 05:37:09 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 05:37:06 -0700
Date: Tue, 27 Feb 2024 12:36:23 +0000
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
Message-ID: <20240227-swarm-serpent-2010b255f68a@wendy>
References: <20240223-leverage-walmart-5424542cd8bd@spud>
 <20240223-employee-pessimism-03ba0b58db6b@spud>
 <CANiq72ngEZskjH0f=8+cJuQsFTK227bGCxe5G0STMHuPbZYnXg@mail.gmail.com>
 <20240227-resolved-deceit-4a59a6af5b71@wendy>
 <CANiq72mwM+4Oh-H5WmRoqQ_nE1w-eJ1wn-nEwS=BR9JRwzxMMQ@mail.gmail.com>
 <20240227-glove-underwire-f562a56cf2c7@wendy>
 <CANiq72=f03_bw9B8ww8UxHkVyP2F7ZPyvC+KWCyhO3Nk1yqdaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lgqlciDgvTDbCOgO"
Content-Disposition: inline
In-Reply-To: <CANiq72=f03_bw9B8ww8UxHkVyP2F7ZPyvC+KWCyhO3Nk1yqdaw@mail.gmail.com>

--lgqlciDgvTDbCOgO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 01:12:51PM +0100, Miguel Ojeda wrote:
> On Tue, Feb 27, 2024 at 12:05=E2=80=AFPM Conor Dooley
> <conor.dooley@microchip.com> wrote:
> >
> > My point though was more
> > that either this was acceptable for v6.9 or would be v6.10 material
> > with the same mechanism as arm64. Rebasing after v6.9-rc1 but not
> > adapting to that way of doing things is what seemed silly to me, since
> > if a resend is required then the other improvements should be carried
> > out at the same time.
>=20
> If avoiding the `target.json` is possible, definitely.
>=20
> I didn't want to assume it is, though -- e.g. the native integer
> widths you have is 64 but the built-in targets use 32:64 (perhaps
> there is a way to tweak it with an LLVM param via `-Cllvm-args`, but I
> don't see any obvious way from a quick look; `opt` does have it,
> though).

Looking closer at those targets, all of them enable compressed
instructors, but we support hardware that does not support them.
I think that means we are stuck with the custom targets.

I could badger Palmer to pick this up tomorrow, provided you're okay
with the gist of this series.

Cheers,
Conor.

--lgqlciDgvTDbCOgO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd3XRwAKCRB4tDGHoIJi
0pwnAQDKxa0TynZPieVRztR0zcy3tmhfLcVSi9lF1+smiaRObwD/S98C/1BHyqaa
o69/XjNcE1BNOR9mwoXX9xRD9UA01Qc=
=I1HU
-----END PGP SIGNATURE-----

--lgqlciDgvTDbCOgO--

