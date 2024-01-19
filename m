Return-Path: <linux-kernel+bounces-31232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB04832ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CE761C244DB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E71537FC;
	Fri, 19 Jan 2024 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="keRfYpmP"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866AC3C493;
	Fri, 19 Jan 2024 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705672757; cv=none; b=W5b7QO7FnDrv1GzneR2fH3FyFi4hn304FiQA74B+y0qdHUWHVTTzEboIrl1fl+je7Y3shHUF7H7txevYvUFftZ2Q4j22ZFW59COcSrLYhv3Cl//h5ibx+YbYaJNsZsC1i6xvukkEvbc0mFxvax0Qs+NM64DX6CLDwfks1zKjzfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705672757; c=relaxed/simple;
	bh=p/40/RTB9UjKxi9Od0nRasdxiGZ7GyKTbdCW/49cFRw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZ0nrGyIeqf7MxkeIYm3rqTqnJm0THYbr5bwmosvjU2/p7RDj7rq9h/lFUQW4VO0g5opNxJPz3TIwP3WpG+tjwk7832A9x/ZRPQ249wKyDvYt4qp+GEL741lKCG75Qa8jYZN+iCnYIWCWXiZ0sJcCnQ4sf34ClJ5jUaQqEurm90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=keRfYpmP; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705672755; x=1737208755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p/40/RTB9UjKxi9Od0nRasdxiGZ7GyKTbdCW/49cFRw=;
  b=keRfYpmPCBsUlwvAwV0v6lFCDEl3YrCd92IolPf05EAhKBpsrCwcNwZp
   xSsNriZSQ/Y6QY5KUvUmyFH1hTP61SruJi5JGb5nWuxdlP3toKltKCEM3
   uX9xF6SNafZrEpnwmtI73HVn8nYawy3fVXGy2R3zr9pLdmquQAoqd9LbT
   hQi0U/v/0hanyUis/WyyJB8KnR8FLFcpkypbbiwaW2ubgvJBs8sS0RQIi
   IJp7wPVBBCupwVC7V2BWePIVInQcNItmEuvmFMqDg2APwppuGl4O0DTuB
   avsm8laH3aVTiSIfeve+eg2Wz5uwcPz/15alJwH8xHUn9nq+gcs7eoPDW
   A==;
X-CSE-ConnectionGUID: s9DSPa5yT/2lOC1K8aydzA==
X-CSE-MsgGUID: 5xml2/pvTuq3Y5CpQ8hwdw==
X-IronPort-AV: E=Sophos;i="6.05,204,1701154800"; 
   d="asc'?scan'208";a="16217918"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jan 2024 06:59:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 06:59:00 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 19 Jan 2024 06:58:57 -0700
Date: Fri, 19 Jan 2024 13:58:21 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Emil
 Renner Berthing <kernel@esmil.dk>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Jack
 Zhu <jack.zhu@starfivetech.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjEgMS8y?=
 =?utf-8?Q?=5D_dt-bindings?= =?utf-8?Q?=3A?= media: starfive: Match driver
 and yaml property names
Message-ID: <20240119-preamble-calm-7724e17fcebc@wendy>
References: <20240119100639.84029-1-changhuang.liang@starfivetech.com>
 <20240119100639.84029-2-changhuang.liang@starfivetech.com>
 <20240119-despair-festival-59ab2d4d896b@wendy>
 <SHXPR01MB0671E2150D9A2707F12E0901F270A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FEb8PAW5xTtdkNzj"
Content-Disposition: inline
In-Reply-To: <SHXPR01MB0671E2150D9A2707F12E0901F270A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>

--FEb8PAW5xTtdkNzj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 12:57:22PM +0000, Changhuang Liang wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> Hi , Conor
>=20
> > =E4=B8=BB=E9=A2=98: Re: [PATCH v1 1/2] dt-bindings: media: starfive: Ma=
tch driver and yaml
> > property names
> >
> > On Fri, Jan 19, 2024 at 02:06:38AM -0800, Changhuang Liang wrote:
> > > Drop some unused properties for clocks, resets and interrupts for
> > > StarFive JH7110 camera subsystem.
> >
> > What do you mean "unused"?
> >
> > Do these clocks etc exist but are not used by the driver?
> >
> > Or do they not exist at all?
> >
> > The two are very different!

> These clocks etc exist but are not used by the driver.

That's not an acceptable reason for removing them from the binding. If
they exist, they should be documented, regardless of whether the driver
makes use of them. NAK.

Also, your mail didn't end up on LKML, so there's something wrong with
your setup.

Thanks,
Conor.

--FEb8PAW5xTtdkNzj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZap//AAKCRB4tDGHoIJi
0jW2AP9Bp7EjUTpBTrdQLP7B4nOmzqnt6gXBTDDnZd6H416uMgEApGygc1Eeq1gd
yDqYrR/umDrmC2JDspWdkwzShFgVXgQ=
=HLIX
-----END PGP SIGNATURE-----

--FEb8PAW5xTtdkNzj--

