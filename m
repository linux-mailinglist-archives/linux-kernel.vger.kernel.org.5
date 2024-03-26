Return-Path: <linux-kernel+bounces-118577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B405C88BCD0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537961F39AAA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9314045954;
	Tue, 26 Mar 2024 08:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1/CR//ZZ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EE71848;
	Tue, 26 Mar 2024 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443039; cv=none; b=f9vRPtI/QCJxKh6iwcKcG578nFVEHDd64iq6z4hSuhVD8OBi654IXTKRBvj/GijMnWTxl5SBBXkdDstsU0lFEJbUpx3EYLCv2oJwyshm8wxl03KbIiEjJC6GLszG2o5q6AXvPqR5b4YwdEqsO4nLMa+Jq3GEjeePMTqVWYJAmbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443039; c=relaxed/simple;
	bh=lG7B+qUkM9NeNykReSQx3p76pLX9hN3mEUMsi5Fr0GI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZCDaJzefxjDUilxNpyu6dyCvbPZErpdPW5PLY1SskW1WNvMUg7c0RX3maN6w4UlXVOHiqZ/NCf+Wzs4/XV9nX1Zf6diUyfgM4N6SDQKvvg5z0q8o4gxJLYuuvEduwX+PS78K1oTziomVBHiOovd54TBXxwMIXn2/6NgY70Mz/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1/CR//ZZ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711443037; x=1742979037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lG7B+qUkM9NeNykReSQx3p76pLX9hN3mEUMsi5Fr0GI=;
  b=1/CR//ZZy8hxBue+bXsHiwULsO9yv3UErLL3hwI4DtAwjwIyJR+9NiSF
   djgGe8UjoR+eT7sDau+2sjGiIh3VXllKcMYjvgZ8ibcKGcAQBq2j+vx2u
   xG8KbiZNHE20nCjeQvOlKVLA5F8PWeLlcjPAGHJBs1OSVk+EUe4lPHTiu
   0moYShnS75Go9PsXgaVqV1oN4SnpJo2dxHTtZsnn/92u8oNcEv0TBU47l
   KCXrfmokJ0Vn/aUBNgVVOg8ShzOWyp7bLsYjZZb15Un+RRovZH7YT61UK
   Im4WHSw80OJzf/h/sRJRuA0jgwBfmyO0PCswXNQSSwR8K/sk0vllg3TnX
   Q==;
X-CSE-ConnectionGUID: UBqr2gvTSQSnKz9w8yaX1g==
X-CSE-MsgGUID: WNkR9VEaRtu1ChEtau3wJg==
X-IronPort-AV: E=Sophos;i="6.07,155,1708412400"; 
   d="asc'?scan'208";a="185499468"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Mar 2024 01:50:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 01:49:19 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 26 Mar 2024 01:49:17 -0700
Date: Tue, 26 Mar 2024 08:48:29 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Allen Lin <allencl_lin@hotmail.com>
CC: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	<dmitry.torokhov@gmail.com>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
	<linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/4] dt-bindings: input: Add Himax HX83102J touchscreen
Message-ID: <20240326-whoever-spotter-1fe7ace35428@wendy>
References: <20240322085606.993896-1-allencl_lin@hotmail.com>
 <TY0PR06MB56116F0902017225C78EDDDD9E312@TY0PR06MB5611.apcprd06.prod.outlook.com>
 <20240322-mammary-boil-f9a4c347fba1@spud>
 <20240322183009.GA1227164-robh@kernel.org>
 <20240322-rectified-udder-fef9102f58da@spud>
 <TY0PR06MB56110ADEA805B68BE2B887069E352@TY0PR06MB5611.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MNNZ2t7NSNgD6OgC"
Content-Disposition: inline
In-Reply-To: <TY0PR06MB56110ADEA805B68BE2B887069E352@TY0PR06MB5611.apcprd06.prod.outlook.com>

--MNNZ2t7NSNgD6OgC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 01:46:56PM +0800, Allen Lin wrote:
> Conor Dooley <conor@kernel.org> =E6=96=BC 2024=E5=B9=B43=E6=9C=8823=E6=97=
=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=882:34=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Fri, Mar 22, 2024 at 01:30:09PM -0500, Rob Herring wrote:
> > > On Fri, Mar 22, 2024 at 05:54:08PM +0000, Conor Dooley wrote:
> > > > On Fri, Mar 22, 2024 at 04:56:03PM +0800, Allen_Lin wrote:
> > > > > Add the HX83102j touchscreen device tree bindings documents.
> > > > > HX83102j is a Himax TDDI touchscreen controller.
> > > > > It's power sequence should be bound with a lcm driver, thus it
> > > > > needs to be a panel follower. Others are the same as normal SPI
> > > > > touchscreen controller.
> > > > >
> > > > > Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
> > > >
> > > > note to self/Krzysztof/Rob:
> > > > There was a previous attempt at this kind of device. This version l=
ooks
> > > > better but might be incomplete given there's a bunch more propertie=
s in
> > > > that patchset:
> > > > https://lore.kernel.org/all/20231017091900.801989-1-tylor_yang@hima=
x.corp-partner.google.com/
> > >
> > > Those don't look like properties we want coming back.
> >
> > Oh, I don't want most of them coming back either. There are some
> > supplies in there though that I think we would like to come back, no?
> > Maybe this particular device doesn't have any supplies, but that doesn't
> > really seem credible.
>=20
> We will use Firmware-name in Device Tree.

> For power supply settings, because there may be other device using
> same regulator.

If there are other devices using the same regulator is it more
important that you document it so that it doesn't get disabled by the
other users.

> We plan to define it as an optional property for user to control in
> next release.

I don't see how the regulator would not be required, the device doesn't
function without power.

Thanks,
Conor.

--MNNZ2t7NSNgD6OgC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgKL2AAKCRB4tDGHoIJi
0m2yAQCWBWCSYIcP5R7VCgO/0OcvwNyQA3V8xkXyyNTaF56DjAEA9p3hmjmzoWbc
Y3z2iIHDUeGgBDNtUNF2Uu9ALdlJ5AM=
=0xei
-----END PGP SIGNATURE-----

--MNNZ2t7NSNgD6OgC--

