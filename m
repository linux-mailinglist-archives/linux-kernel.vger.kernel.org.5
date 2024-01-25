Return-Path: <linux-kernel+bounces-38580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E31C83C288
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3EF8B2204C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A432AE71;
	Thu, 25 Jan 2024 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vYVPfKcT"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B6423D6;
	Thu, 25 Jan 2024 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706185883; cv=none; b=rOzGYv5aF2+E4YHzJa/sPr673bvhaSkFxlcfKXj4YUzMfV/B3RHswvo/mFPY/5juI92bde4s11reNHw/DWi6/avXNaXF30LMoqQy7mBV70UiKsyGjHWL/GlGHSGatbjm9Vv6Iedto2orIeO9qPt0cK6JXznIztHDx161MnHr6bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706185883; c=relaxed/simple;
	bh=e2Gx71tG+PGiXuCcWrEYqd74AvFTiXta4T5CfVZ20i4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tl9axKTFX64Tull4M0FaU5q2VepxDfet26WgyGKkjYKlmaq7GCZN8Fagl7OWhW7HLXgj6qLxUdDJf+aoyTc1EZ9vg8B1JymbsI1QezFYpFntKaPHPSI1G/J2nm/lDOyjH/zg6LSl999foSseqAx0zmfjzaFavY0cW17vvEd2NCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vYVPfKcT; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706185881; x=1737721881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e2Gx71tG+PGiXuCcWrEYqd74AvFTiXta4T5CfVZ20i4=;
  b=vYVPfKcTjbqNf6fxMdBuEt2Brx8eTxfc/k/sNNZncYBSMyuJmmhaj8mj
   L79dHltC21R73ictxK1VeqCZRnzI9hItXRrN2wPltmt6tmEIE0QxX7JW9
   cSiunODrLQoO/IRXWE0ytVYE20DbBlxsoHxg6N1M8DstKPVEwVolFSjZ1
   xo3OuDIwXd7Vj25EgPiqBYtikDPrDp5GD86Z5u4mWL1TLg3K+3KgKDsm8
   cSXx8UjusttDS2JSQ0hwbCE5K3GsBQxFYus+6fIfjJZ72fm9PkX2r1qxk
   EYKgCpK20ZRsCY6A4BFHcr4Cb/fPy0ClRzjbZuiDPSM1Bv/I8UIIdIeJD
   A==;
X-CSE-ConnectionGUID: kHKU490MTVa/CUpB0qKI1Q==
X-CSE-MsgGUID: 04RsdzskT3uNcxxVcLoRZg==
X-IronPort-AV: E=Sophos;i="6.05,216,1701154800"; 
   d="asc'?scan'208";a="15284694"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2024 05:31:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 05:31:15 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 25 Jan 2024 05:31:12 -0700
Date: Thu, 25 Jan 2024 12:30:34 +0000
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
Subject: Re: [PATCH v1 0/2] RISC-V: enable rust
Message-ID: <20240125-bucked-payroll-47f82077b262@wendy>
References: <20230307102441.94417-1-conor.dooley@microchip.com>
 <20230608-dispatch-sneer-aa09bd7b2eb8@wendy>
 <CANiq72nnph7LS1fLRtHz8NJ91PWXPaUnm0EuoV3wrbvK398AnA@mail.gmail.com>
 <20230608-spiritism-gonad-5f5aff4c3a24@wendy>
 <20240117-swiftly-parasail-618d62972d6e@spud>
 <CANiq72mVKCOAuK4Qe+8AHmpkFwyJsVfx8AqB7ccGi3DYpSSWcw@mail.gmail.com>
 <20240118-implode-delirium-eefdd86e170e@spud>
 <CANiq72nx1s_nyvPW86jL7eiOxROr18LfOJqNtw8L42CP+gkhRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mujnSF4ge/jontNh"
Content-Disposition: inline
In-Reply-To: <CANiq72nx1s_nyvPW86jL7eiOxROr18LfOJqNtw8L42CP+gkhRg@mail.gmail.com>

--mujnSF4ge/jontNh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 05:09:40PM +0100, Miguel Ojeda wrote:
> On Thu, Jan 18, 2024 at 4:49=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > The bit that worries me most is bindgen, and in particular detecting the
> > version of libclang used. I mentioned to Nathan or Nick about needing a
> > buildtime test for the version of LIBCLANG being used.
> > I'm less worried about this for LLVM=3D1 builds, since while I think it=
 is
> > possible to provide a LIBCLANG path to the build system, I suspect that
> > for LLVM=3D1 builds it's almost always going to match the LLVM toolchain
> > in use.

I chatted with the clang built linux folks about this yesterday, Nathan
agreed that dealing with incompatibility issues iff they crop up is a
reasonable way to go.

> `scripts/rust_is_available.sh` tests whether `libclang` is at least
> the minimum LLVM supported version; and under `LLVM=3D1` builds, it also
> tests whether the `bindgen` found one matches the C compiler. Do you
> mean something like that?

If by "the bindgen found one matches the C compiler" you mean that the
version of libclang used by bindgen matches the C compiler, then that
sounds great.

> For `bindgen` under GCC builds, we will eventually want a "proper" way
> to use GCC instead (or possibly other approaches like querying the
> information): https://github.com/rust-lang/rust-bindgen/issues/1949.

> Recently, there has been a thread in our Zulip and a couple people are
> experimenting: https://rust-for-linux.zulipchat.com/#narrow/stream/288089=
-General/topic/Bindgen.20--.20GCC.20backend.20port

That link for me goes to a message on 22/01, so later than the email you
sent.

> > I'll do another rebase and resend after the merge window closes I
> > suppose :)


That said, I gave things another spin today, in a different environment,
as a final check before sending and found an issue causing kernel
panics. RISC-V (and x86/arm64) supports kcfi (CFI_CLANG) but enabling
sanitisers seems to be a nightly only option for rustc. The kernel I
built today had CFI_CLANG enabled and that caused panics when the rust
samples were loaded.

The CFI_CLANG Kconfig entry has a cc-option test for whether the option
is supported, but from a quick check I don't see a comparable test to
use for rust. Even if a test was added, the current flag is an unstable
one, so I am not sure if testing for it is the right call in the first
place, given the stabilised flag would be entirely different?

The tracking issue seems to be complete:
https://github.com/rust-lang/rust/issues/89653
but the tracking issue for sanitisiers themselves is only 3/5:
https://github.com/rust-lang/rust/issues/39699

The simple thing would be to make them mutually exclusive options in
Kconfig.

What do you think?

Cheers,
Conor.

--mujnSF4ge/jontNh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbJUXAAKCRB4tDGHoIJi
0uVHAQDIljZB931BuYsvFh8CDiXkeXE86yDu7dnEqYO2MErRBwEArNXVKUHQ6zGx
JQPxBR+Fd23f1rnzfJFcWNiA7BscMA8=
=IPeL
-----END PGP SIGNATURE-----

--mujnSF4ge/jontNh--

