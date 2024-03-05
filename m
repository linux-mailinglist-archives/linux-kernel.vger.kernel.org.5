Return-Path: <linux-kernel+bounces-92011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B195B8719AC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D7E1C22812
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E678652F99;
	Tue,  5 Mar 2024 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1GjDofeH"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF0752F6A;
	Tue,  5 Mar 2024 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709631255; cv=none; b=CwVmbTC3VWDsWFeG9a77v60SrAQ0+22QSYdVZgaLlMOj4aNbumDYC4/KlGnCIROyELXeS2LDXQSHw/3DdESX6cBNWrtsoiguznCobo9uNHujxidF+xiVnVYDB82AGqIy1U8SGPdhXVxKdVGCNYqgKibSdQCGMpsXAAnPhzT0dK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709631255; c=relaxed/simple;
	bh=T+7Q7gQskuw24wef7dAaNh5RUkK6uPhJY7sdZqTMIFY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oa4YmeoNK1O9bQvyONpAkWdAhrEpwdcZrj1WNKj3pqfem+EC4NAs4y7vJ2Wtdd8kx+yQFr6AOEDsjNGHzM04B8Ba/ulmTkAN/dHJV5shVb01/VUlJAvwPBtwAm8AEPMqGj61wr/gvn+kw7NKaaLamn/6GQIhYFO2+Gc3hJXJ1Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1GjDofeH; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709631253; x=1741167253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T+7Q7gQskuw24wef7dAaNh5RUkK6uPhJY7sdZqTMIFY=;
  b=1GjDofeHSagFvJHCgXShstittoYUF/LgrggDvGIf+f81xQO5cCN0qGvS
   +XZ/2gxJ4RwFgM9rf+CJwGs+FK0K6TQorKQUM28xcMeBFN8GCocC3nmbj
   hcz4lSmikPqcu4hAr1hbn84LpA75/1i50WKGBs+U3Ugn628yw03kXNI9+
   nJ0Rzy8GCwkP8sK7o+SyFa4xx/Vx+deKnlc/g8ZeNP1eLUE+HXuGVMGST
   2Pur3Oxt7H0gJf0n1YJCnvHxDgnj6UaTSIisbHCXia9/l7rJyev5hnIG6
   htsD7yJel2fUDOUxYJFdVqoJeQlh1IJdMqro5dz8InWsU7UiRyB0NJvdT
   Q==;
X-CSE-ConnectionGUID: wgXCSyg+Q4GqTX7SY8rAAw==
X-CSE-MsgGUID: 6EM9gp66SGKa0dtg7wp0Vg==
X-IronPort-AV: E=Sophos;i="6.06,205,1705388400"; 
   d="asc'?scan'208";a="17205101"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2024 02:34:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 02:33:32 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 5 Mar 2024 02:33:29 -0700
Date: Tue, 5 Mar 2024 09:32:45 +0000
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
Message-ID: <20240305-squeezing-backlit-d952f4503e57@wendy>
References: <20240305074649.580820283@linuxfoundation.org>
 <20240305-arson-panhandle-afa453ccb0aa@wendy>
 <CADo9pHg4teVS7Lt1j+gOt4G9U=dZF9G92AUK=Km6PTdURkc0pg@mail.gmail.com>
 <20240305-series-flogging-e359bae88efd@wendy>
 <CADo9pHh6fnOz7d6+WCwkKz6_T4Ahru=0YDuc6q+KNnKYqQ2gBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UN1dzwzL0P7pYwKx"
Content-Disposition: inline
In-Reply-To: <CADo9pHh6fnOz7d6+WCwkKz6_T4Ahru=0YDuc6q+KNnKYqQ2gBg@mail.gmail.com>

--UN1dzwzL0P7pYwKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 10:21:46AM +0100, Luna Jernberg wrote:
> Den tis 5 mars 2024 kl 10:20 skrev Conor Dooley <conor.dooley@microchip.c=
om>:
> >
> > On Tue, Mar 05, 2024 at 10:07:37AM +0100, Luna Jernberg wrote:
> > > Den tis 5 mars 2024 kl 09:32 skrev Conor Dooley <conor.dooley@microch=
ip.com>:
> > > >
> > > > On Tue, Mar 05, 2024 at 07:58:57AM +0000, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 6.7.9 releas=
e.
> > > > > There are 163 patches in this series, all will be posted as a res=
ponse
> > > > > to this one.  If anyone has any issues with these being applied, =
please
> > > > > let me know.
> > > > >
> > > > > Responses should be made by Thu, 07 Mar 2024 07:46:26 +0000.
> > > > > Anything received after that time might be too late.
> > > >
> > > > > Samuel Holland <samuel.holland@sifive.com>
> > > > >     riscv: Save/restore envcfg CSR during CPU suspend
> > > > >
> > > > > Samuel Holland <samuel.holland@sifive.com>
> > > > >     riscv: Add a custom ISA extension for the [ms]envcfg CSR
> > > >
> > > > I left a comment in response to the off-list email about this patch,
> > > > I don't think it's gonna work as the number this custom extension h=
as
> > > > been given exceeds the max in 6.7/
> > > > >
> > > > > Samuel Holland <samuel.holland@sifive.com>
> > > > >     riscv: Fix enabling cbo.zero when running in M-mode
> > >
> > > Works fine on my Arch Linux desktop with model name    : AMD Ryzen 5
> > > 5600 6-Core Processor
> > > after the Arch Linux manual intervention for new mkinitcpio settings
> > > and version in Arch
> > >
> > > Tested by: Luna Jernberg <droidbittin@gmail.com>
> >
> > This problem is riscv only, your x86 machine should not be affected
> > by it.
>=20
> Ah alright then i know, did feel like compiling the latest test kernel
> anyways, but thanks for the heads up

Ah, I understand now. You meant to reply saying that you had tested
6.7.9-rc2 but you replied to me instead of Greg's original posting which
confused me into thinking you tried to test these specific patches.


--UN1dzwzL0P7pYwKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZebmvQAKCRB4tDGHoIJi
0jhIAQClM9yQavCbDkoYin11QTej1ArzrXhWBjMeuKYGikpd5AD/dDwnEqxVMLDR
d3O4OEYxS1hBkrGB+U39kaBzeuzPzg0=
=QlJ9
-----END PGP SIGNATURE-----

--UN1dzwzL0P7pYwKx--

