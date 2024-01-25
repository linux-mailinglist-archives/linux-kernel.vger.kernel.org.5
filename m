Return-Path: <linux-kernel+bounces-38678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B7083C401
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12BB11C23579
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2130D57321;
	Thu, 25 Jan 2024 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="orCz+Hii"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935B05732D;
	Thu, 25 Jan 2024 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190374; cv=none; b=QruronxoZwnKVfJBGxUqs7Ap5qDstYM4SU1PX9KivyyeBOy5DxIxW/jnL9HO68CuGI3wzTxgC/G6IqTtMbnWE2Ko4xz0a2MpTApp7OBGUZVqdJtY2CcoAperIgcj7SAqtaXVJupSGrSdNDZTlgvOwbrS8APhrRQ26nvH0DM68MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190374; c=relaxed/simple;
	bh=QkGYH2ypWOTDiq5BbVC5hKUniLV64BDsYDuZSL4c+Ek=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGLisyoPUfamuPJjbJTEwZFFCw5KJpb7jYOe0AA3xpDxstqPAr9PdVLaXvv/X1/tBZd5CkvYJEYLdHohl7jwiuf1i3gxkA/YQ4mmHbt61fgVURTORPhSZgHpJ5ZS7ElnUNY2GFeKfeKh541Dloeuk/6lqR+vQy1nkVeXvFVdx8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=orCz+Hii; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706190372; x=1737726372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QkGYH2ypWOTDiq5BbVC5hKUniLV64BDsYDuZSL4c+Ek=;
  b=orCz+HiiQp/tfRwDA4AgKVTsDixe37pm18Tgv+OkbKj4Qjx+P+qRnR6E
   5IjfilFA1gC+KYrluSL1jfrl+/eGEmB5dUBxVPi8xGkzFMCTbsLSoYZxk
   0uL4J2sfY5dk9YinvaKvNNSst4HKUcVPgVR4I0cYw3mPLTz77VonnQIIl
   q/XTfd7UYmHSO//K1mrjW2QGjndEEgaLPsHucwOl10YM7XokQF5qtYEDb
   kyCdnZZNfskbAWfgc1VrExY5n60fFNym0pmjb+2UfA++5KXHeCCU5p/hI
   OEecHE8gON0ShOAbHzoYtQreFvSZOEyPZOQCwxTTjpMfNpNXYslPiE2fQ
   A==;
X-CSE-ConnectionGUID: m+PhERqEQH65VJ/qKW5gkQ==
X-CSE-MsgGUID: fy6M6828T9yyNgsJcQ4UyQ==
X-IronPort-AV: E=Sophos;i="6.05,216,1701154800"; 
   d="asc'?scan'208";a="15287685"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2024 06:46:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 06:45:46 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 25 Jan 2024 06:45:42 -0700
Date: Thu, 25 Jan 2024 13:45:05 +0000
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
	<llvm@lists.linux.dev>, Matthew Maurer <mmaurer@google.com>, Ramon de C Valle
	<rcvalle@google.com>, Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v1 0/2] RISC-V: enable rust
Message-ID: <20240125-lazy-thrower-744aacc6632a@wendy>
References: <20230307102441.94417-1-conor.dooley@microchip.com>
 <20230608-dispatch-sneer-aa09bd7b2eb8@wendy>
 <CANiq72nnph7LS1fLRtHz8NJ91PWXPaUnm0EuoV3wrbvK398AnA@mail.gmail.com>
 <20230608-spiritism-gonad-5f5aff4c3a24@wendy>
 <20240117-swiftly-parasail-618d62972d6e@spud>
 <CANiq72mVKCOAuK4Qe+8AHmpkFwyJsVfx8AqB7ccGi3DYpSSWcw@mail.gmail.com>
 <20240118-implode-delirium-eefdd86e170e@spud>
 <CANiq72nx1s_nyvPW86jL7eiOxROr18LfOJqNtw8L42CP+gkhRg@mail.gmail.com>
 <20240125-bucked-payroll-47f82077b262@wendy>
 <CANiq72k7n0aZrifRRU08N8qLkNe+2EZwijZy5sM7M56n2xYHgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GuHppkpX7NvgOUA9"
Content-Disposition: inline
In-Reply-To: <CANiq72k7n0aZrifRRU08N8qLkNe+2EZwijZy5sM7M56n2xYHgQ@mail.gmail.com>

--GuHppkpX7NvgOUA9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 01:50:05PM +0100, Miguel Ojeda wrote:
> On Thu, Jan 25, 2024 at 1:31=E2=80=AFPM Conor Dooley <conor.dooley@microc=
hip.com> wrote:

> > > Recently, there has been a thread in our Zulip and a couple people are
> > > experimenting: https://rust-for-linux.zulipchat.com/#narrow/stream/28=
8089-General/topic/Bindgen.20--.20GCC.20backend.20port
> >
> > That link for me goes to a message on 22/01, so later than the email you
> > sent.
>=20
> Zulip seems to scroll to the latest message in the topic -- you should
> be able to scroll a bit up, but if that doesn't work, this link should
> go to the first message:
> https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topic/=
Bindgen.20--.20GCC.20backend.20port/near/412609074

Ah, thanks for the direct link :)

>=20
> > That said, I gave things another spin today, in a different environment,
> > as a final check before sending and found an issue causing kernel
> > panics. RISC-V (and x86/arm64) supports kcfi (CFI_CLANG) but enabling

I mention x86 and arm64 here, because my grepping didn't see the flag
being set for x86 (in tree) or arm64 (in that series) if CFI_CLANG was
set or any mutual exclusion. Has noone tried CFI_CLANG + RUST there or
just not run into any issues?

> > sanitisers seems to be a nightly only option for rustc. The kernel I
> > built today had CFI_CLANG enabled and that caused panics when the rust
> > samples were loaded.
> >
> > The CFI_CLANG Kconfig entry has a cc-option test for whether the option
> > is supported, but from a quick check I don't see a comparable test to
> > use for rust. Even if a test was added, the current flag is an unstable
> > one, so I am not sure if testing for it is the right call in the first
> > place, given the stabilised flag would be entirely different?
>=20
> Yeah, KCFI and other mitigations is WIP -- Cc'ing Ramon and Matthew
> who may be able to tell us the latest status.

Also CC Sami I guess, since he is the one who added the CFI_CLANG bits
to the kernel, and can probably comment on the suitability of adding a
check etc.

> Testing for unstable flags is fine, i.e. we only support a single
> compiler, so we can change the name when we do the upgrade.

Actually, thinking about it for a moment - if only a single compiler
version is supported (the minimum, right?) then you could just add the
-Zsanitizer=3Dkcfi flag whenever CFI_CLANG and RUST are both set.

I'm not sure if that is a better option though. It's a choice between
CFI_CLANG being disabled if the check is not updated when the toolchain
is bumped versus being enabled for C and not for RUST. I think I prefer
the former though, tracking down the cause of the latter I would rather
not wish on a user.

I vote for having the check, even if it can only ever be true at the
moment.

Cheers,
Conor.

--GuHppkpX7NvgOUA9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbJl4QAKCRB4tDGHoIJi
0r2YAP9Kbj4u//RY0nIROcBBxVP3ucR5cgnfxPjsXpqrdOu6FgD/ef8EVCC207/s
Jy65DzLCk1V5UGLDXdSuKcxvD/qEngw=
=6p43
-----END PGP SIGNATURE-----

--GuHppkpX7NvgOUA9--

