Return-Path: <linux-kernel+bounces-69232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F338858601
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A3F1F21AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770DA135A62;
	Fri, 16 Feb 2024 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nF+G8qw+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C5D149DF2
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708110630; cv=none; b=idpO+EQHfdD8SbLzvlF+7xHGGJnOC+ww+elByBdQl6MzPm40t/6JDvca/t0V8e3WcQ5wefti8u1PbpOI5WLlWssc0vcJPmAecJf27rIOTgcQW+B8TQ9oJN2KVZ9pW/07rFJ6P7tauFAdcFFp1NZMP+3lTdMwJ7XHGpDLXKcUqWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708110630; c=relaxed/simple;
	bh=AFbmUl8rqURn7hXJUEq5OaU+gq+IORCCJJXdUoY2k+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Um40Bt4TxVgtIh71wecb9HL76xUz82lrXldZ/nVusyOccFqr2kJrGNskJnKgwaKlrQVU8TA/g+ftgWL59TH3nym14dCvNnwX9jV5LJcYVpKlQ/oBnKM0wdEIWOunm0ACqKlV8kjL4vurAbB8nChovl7hxpb0+M3h8NJFM7WGqWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nF+G8qw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954E9C433C7;
	Fri, 16 Feb 2024 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708110630;
	bh=AFbmUl8rqURn7hXJUEq5OaU+gq+IORCCJJXdUoY2k+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nF+G8qw+TD1YTwQVYNCbiRvdlIGUiP0wbBXs40zKKOTmwaGOgSqErh49/svhAuA85
	 MlGPfEbDmHBcuyShzcfVjiO4GJlA2LKZLgP/3/i0D17t4YCcCYpbmPpsr6I93FPV26
	 OHMMcJSJe7iR429eX1mQhC8UC3EvMev0LF7uHTHjm2HpKcqq5ZoYH22BCzNSiWcWsJ
	 PXv7OJMnISZ0/RVUsbd5et9XJkoP+lkbGoFHH3xjx59qnHldjFYZKnCk5jRPkhbdn3
	 AqBKHfeesNG0/YGBzyidFVcxijXseCkGXD/mzS2dEv3uRdn6FTBasheYiSV+aikhTL
	 4LwFjAL5ropcw==
Date: Fri, 16 Feb 2024 19:10:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: samuel.holland@sifive.com, Paul Walmsley <paul.walmsley@sifive.com>,
	greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
	green.wan@sifive.com, aou@eecs.berkeley.edu,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update SiFive driver maintainers
Message-ID: <20240216-imposing-disband-b0fd6d0c67b8@spud>
References: <20240215234941.1663791-1-samuel.holland@sifive.com>
 <mhng-a672acb9-4e32-4a63-898d-08b10d09d8b8@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CBjwoUKfGcHWfuH6"
Content-Disposition: inline
In-Reply-To: <mhng-a672acb9-4e32-4a63-898d-08b10d09d8b8@palmer-ri-x1c9>


--CBjwoUKfGcHWfuH6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 10:43:31AM -0800, Palmer Dabbelt wrote:
> On Thu, 15 Feb 2024 15:49:11 PST (-0800), samuel.holland@sifive.com wrote:
> > Add myself as a maintainer for the various SiFive drivers, since I have
> > been performing cleanup activity on these drivers and reviewing patches
> > to them for a while now. Remove Palmer as a maintainer, as he is focused
> > on overall RISC-V architecture support.
> >=20
> > Collapse some duplicate entries into the main SiFive drivers entry:
> >  - Conor is already maintainer of standalone cache drivers as a whole,
> >    and these files are also covered by the "sifive" file name regex.
> >  - Paul's git tree has not been updated since 2018, and all file names
> >    matching the "fu540" pattern also match the "sifive" pattern.
> >  - Green has not been active on the LKML for a couple of years.
> >=20
> > Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> > ---
> >=20
> >  MAINTAINERS | 29 +++++------------------------
> >  1 file changed, 5 insertions(+), 24 deletions(-)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 73d898383e51..f1bbb0f82664 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1395,6 +1395,7 @@ F:	drivers/hwmon/max31760.c
> >=20
> >  ANALOGBITS PLL LIBRARIES
> >  M:	Paul Walmsley <paul.walmsley@sifive.com>
> > +M:	Samuel Holland <samuel.holland@sifive.com>
> >  S:	Supported
> >  F:	drivers/clk/analogbits/*
> >  F:	include/linux/clk/analogbits*
> > @@ -16725,6 +16726,7 @@ F:	drivers/pci/controller/dwc/*layerscape*
> >  PCI DRIVER FOR FU740
> >  M:	Paul Walmsley <paul.walmsley@sifive.com>
> >  M:	Greentime Hu <greentime.hu@sifive.com>
> > +M:	Samuel Holland <samuel.holland@sifive.com>
> >  L:	linux-pci@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> > @@ -19968,36 +19970,15 @@ S:	Maintained
> >  F:	drivers/watchdog/simatic-ipc-wdt.c
> >=20
> >  SIFIVE DRIVERS
> > -M:	Palmer Dabbelt <palmer@dabbelt.com>
> >  M:	Paul Walmsley <paul.walmsley@sifive.com>
> > +M:	Samuel Holland <samuel.holland@sifive.com>
> >  L:	linux-riscv@lists.infradead.org
> >  S:	Supported
> > +F:	drivers/dma/sf-pdma/
> >  N:	sifive
> > +K:	fu[57]40
> >  K:	[^@]sifive
> >=20
> > -SIFIVE CACHE DRIVER
> > -M:	Conor Dooley <conor@kernel.org>
> > -L:	linux-riscv@lists.infradead.org
> > -S:	Maintained
> > -F:	Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> > -F:	drivers/cache/sifive_ccache.c
> > -
> > -SIFIVE FU540 SYSTEM-ON-CHIP
> > -M:	Paul Walmsley <paul.walmsley@sifive.com>
> > -M:	Palmer Dabbelt <palmer@dabbelt.com>
> > -L:	linux-riscv@lists.infradead.org
> > -S:	Supported
> > -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pjw/sifive.git
> > -N:	fu540
> > -K:	fu540
> > -
> > -SIFIVE PDMA DRIVER
> > -M:	Green Wan <green.wan@sifive.com>
> > -S:	Maintained
> > -F:	Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> > -F:	drivers/dma/sf-pdma/
> > -
> > -
> >  SILEAD TOUCHSCREEN DRIVER
> >  M:	Hans de Goede <hdegoede@redhat.com>
> >  L:	linux-input@vger.kernel.org
>=20
> I'm fine not having to maintain the SiFive drivers, the SOC stuff was nev=
er
> really my thing anyway so that's all a bit easier on my end.  So
>=20
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>=20
> I do end up picking up some random patches though, mostly because stuff
> seems to slip through the cracks.  Are you going to have an SOC subtree a=
nd
> send stuff over there?  That seems more manageable on my end, as it's a b=
it
> scattered today.

I don't think anything in this patch was "supposed" to go via the riscv
tree as things stood. Probably more a case of harassing subsystem
maintainers (or sending them PRs) than sending things to Arnd I think.

--CBjwoUKfGcHWfuH6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc+zIgAKCRB4tDGHoIJi
0pk9AP49AQq75Pc8iwhAz25msOXfEjXnyTZPr0kLpw8052CdLwEAmIs40UF42FKN
OIcpjPmt9Shk5TOLM10/vSuqSzaxpQE=
=jdaH
-----END PGP SIGNATURE-----

--CBjwoUKfGcHWfuH6--

