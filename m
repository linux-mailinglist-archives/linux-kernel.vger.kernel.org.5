Return-Path: <linux-kernel+bounces-91989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A09D871972
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E009A1F239E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3DB51C56;
	Tue,  5 Mar 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yRFwyaSP"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71193535D1;
	Tue,  5 Mar 2024 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630429; cv=none; b=GtiBe9DBSPtkdJm+K/oA5x5gWaDnnhhFrAW3HJGJxxrX2Bl9EbQ9u6IrVE0MZTyS7JcnAWodOncGy7FL+libRRdfdn3Y3DbMe6qsCTftQzXGV1i62Lo+WR0UquUOQX2Ct8A6rAbR+rZGSkhzA72WGHWL4bDZCgFmmhDW9XVeZco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630429; c=relaxed/simple;
	bh=KNDxR2j3MvTGAgZhx6a4KBsYjLrI0eP9AakaQhlVDZ8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnTrDg4OpIJfazDjgh/7ZJNp7N4twfnd2sCKMtK9rstartaEliGoJTaBBnBdZ2aSL7IW5MmxsVOd4nyt3Dvg2X6Psa2F/4hPHIECBBahkUA8Cjse9gA6WpPpLyNE1U5wkl/peErInFrhl+OBZZdBUPCkQX5+ImyDNZGI6bISv/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yRFwyaSP; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709630428; x=1741166428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KNDxR2j3MvTGAgZhx6a4KBsYjLrI0eP9AakaQhlVDZ8=;
  b=yRFwyaSPkibc/vCzcqdIBZvcRqAZDYWc9zeC2GeNRKvEysky1I5Q2t/S
   xIqKdA+Uov4DPCZSESOmx2w4rYhQ8cIrTJ02YPq+5L1g/En0R2AL3tfWi
   qwN/skdIVsw7iypWwY8Yj1e0FNX1YLlOYLWinKNfVg47OwGHYJfXNP9M+
   Lq0gPrk3H1ZJ/STbY70AhsGvMt1aSGgIL/PSwRxoeRUPQgA7cZ8zxN9n9
   Nmbo+F3QidUdzHflw2Ft9t8FLQ+qcSkH+UINy2JEvx8i7x6l8c6Z8qcQb
   cLx7X9Mhfaby5Y7Gfnus9xGQ6W/f+MYNOEa2+fbVox9FmNvsYDFekeq74
   A==;
X-CSE-ConnectionGUID: VD/eKWW4R0CkALrT5bQsvg==
X-CSE-MsgGUID: iIWBvtyeSHS/T8iVoQqQcw==
X-IronPort-AV: E=Sophos;i="6.06,205,1705388400"; 
   d="asc'?scan'208";a="17214612"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2024 02:20:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 02:20:11 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 5 Mar 2024 02:20:08 -0700
Date: Tue, 5 Mar 2024 09:19:24 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Luna Jernberg <droidbittin@gmail.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>,
	<patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
	<linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
	<lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
	<f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
	<rwarsow@gmx.de>, <conor@kernel.org>, <allen.lkml@gmail.com>
Subject: Re: [PATCH 6.7 000/163] 6.7.9-rc2 review
Message-ID: <20240305-series-flogging-e359bae88efd@wendy>
References: <20240305074649.580820283@linuxfoundation.org>
 <20240305-arson-panhandle-afa453ccb0aa@wendy>
 <CADo9pHg4teVS7Lt1j+gOt4G9U=dZF9G92AUK=Km6PTdURkc0pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="su+l/DhT5GQyjIBy"
Content-Disposition: inline
In-Reply-To: <CADo9pHg4teVS7Lt1j+gOt4G9U=dZF9G92AUK=Km6PTdURkc0pg@mail.gmail.com>

--su+l/DhT5GQyjIBy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 10:07:37AM +0100, Luna Jernberg wrote:
> Den tis 5 mars 2024 kl 09:32 skrev Conor Dooley <conor.dooley@microchip.c=
om>:
> >
> > On Tue, Mar 05, 2024 at 07:58:57AM +0000, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 6.7.9 release.
> > > There are 163 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Thu, 07 Mar 2024 07:46:26 +0000.
> > > Anything received after that time might be too late.
> >
> > > Samuel Holland <samuel.holland@sifive.com>
> > >     riscv: Save/restore envcfg CSR during CPU suspend
> > >
> > > Samuel Holland <samuel.holland@sifive.com>
> > >     riscv: Add a custom ISA extension for the [ms]envcfg CSR
> >
> > I left a comment in response to the off-list email about this patch,
> > I don't think it's gonna work as the number this custom extension has
> > been given exceeds the max in 6.7/
> >
> > Cheers,
> > Conor.
> >
> > >
> > > Samuel Holland <samuel.holland@sifive.com>
> > >     riscv: Fix enabling cbo.zero when running in M-mode
>=20
> Works fine on my Arch Linux desktop with model name    : AMD Ryzen 5
> 5600 6-Core Processor
> after the Arch Linux manual intervention for new mkinitcpio settings
> and version in Arch
>=20
> Tested by: Luna Jernberg <droidbittin@gmail.com>

This problem is riscv only, your x86 machine should not be affected
by it.

Thanks,
Conor.

--su+l/DhT5GQyjIBy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZebjjwAKCRB4tDGHoIJi
0vizAP9NwkspUIO6a0++FEWXo3Js1rlKjf+VBtNa08ZydZphUAEAh7gYpidSzumB
xKBhlOVFcYG/1A6OC3ohFmVTT7UwhgI=
=F/lT
-----END PGP SIGNATURE-----

--su+l/DhT5GQyjIBy--

