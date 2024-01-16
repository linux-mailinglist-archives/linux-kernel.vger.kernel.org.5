Return-Path: <linux-kernel+bounces-27201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAA082EC1B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A741C22FE5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B54134B6;
	Tue, 16 Jan 2024 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gdhuVufm"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD14134A3;
	Tue, 16 Jan 2024 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705398556; x=1736934556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d/LmQtM6md3wSSgxarWeNXc3nWd8MVX7G2TVJesXeRI=;
  b=gdhuVufmQweEZdMW3E7ZUIv6G1cfEN1gkw0ENXJTLp8XcOhoKIkrlRI5
   6AOcp1hgcS672eIXnEeCM2HVETVikdFy9Klp/qixXCVOvnhHT7VngWyTm
   /n5ugSPEJqnE5BZuvkah2ovUeqXp6t+YpXbO9P/t/zDywOu0QJVSZh9D7
   QAxRU8BgbZ/g7ybjkSF2QL629HExTWzWhyIJyd2QwyPXKrLMjHAE1rXF+
   IgiqMiypMziiz2ouEX2LWK9VuzCZEB8/LD6Js8FK7trQU6/bStK3MObZP
   oAiylVyC5kSlKiKbwhx3ggGX6PbUyxiT+LyrLSAbCQ4fzYkMdBDVNYL9u
   g==;
X-CSE-ConnectionGUID: lhV4ifIESgq7KLyVEfkQ/Q==
X-CSE-MsgGUID: H9BXj9zQRVij7q1BDAfNUw==
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="asc'?scan'208";a="245529089"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2024 02:49:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 02:48:47 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 16 Jan 2024 02:48:44 -0700
Date: Tue, 16 Jan 2024 09:48:08 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Frank Li <Frank.li@nxp.com>, <robh@kernel.org>,
	<alexandre.belloni@bootlin.com>, <conor.culhane@silvaco.com>,
	<gregkh@linuxfoundation.org>, <imx@lists.linux.dev>, <jirislaby@kernel.org>,
	<joe@perches.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<miquel.raynal@bootlin.com>, <zbigniew.lukwinski@linux.intel.com>,
	<devicetree@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 2/7] dt-bindings: i3c: svc: add compatible string i3c:
 silvaco,i3c-target-v1
Message-ID: <20240116-achiness-thievish-10a12b3c08cd@wendy>
References: <3c0be658-e7a6-4231-b206-86ffb47e0cb2@linaro.org>
 <ZaFbbeQrC7o2dchO@lizhi-Precision-Tower-5810>
 <e3b9aa63-25a5-41cc-9eb7-6e7d1eacb136@linaro.org>
 <ZaFjaWCA6k+tiCSJ@lizhi-Precision-Tower-5810>
 <ZaWLCrWJEMtFx8cR@lizhi-Precision-Tower-5810>
 <1b628901-7f71-4c97-9a16-723912988417@linaro.org>
 <ZaXqCoCHPWER94Hh@lizhi-Precision-Tower-5810>
 <d45e31c4-914e-4cea-a145-9775b6f516ab@linaro.org>
 <20240116-bleach-herbicide-48d636967134@wendy>
 <3199c245-3d2d-49e8-951e-2b059de4d683@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lyAJBZzxW05Or8+L"
Content-Disposition: inline
In-Reply-To: <3199c245-3d2d-49e8-951e-2b059de4d683@linaro.org>

--lyAJBZzxW05Or8+L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 10:33:48AM +0100, Krzysztof Kozlowski wrote:
> On 16/01/2024 10:30, Conor Dooley wrote:
> > On Tue, Jan 16, 2024 at 08:24:20AM +0100, Krzysztof Kozlowski wrote:
> >> On 16/01/2024 03:29, Frank Li wrote:
> >>>>> 	Patches were accepted after discussion, what you ponit to. So I
> >>>>> think everyone agree on the name 'silvaco,i3c-master-v1'.
> >>>>> 	I plan send next version to fix auto build error. Any additional
> >>>>> comments about this?
> >>>>
> >>>> I still do not see how did you address Rob's comment and his point is
> >>>> valid. You just did not reply to it.
> >>>
> >>> See https://lore.kernel.org/imx/ZXCiaKfMYYShoiXK@lizhi-Precision-Towe=
r-5810/
> >>
> >> First of all, that's not the answer to Rob's email, but some other
> >> thread which is 99% ignored by Rob (unless he has filters for
> >> "@Rob"...). Therefore no, it does not count as valid answer.
> >>
> >> Second, explanation does not make sense. There is no argument granting
> >> you exception from SoC specific compatibles.
> >=20
> > The patch could have been applied two months ago had Frank done as
> > was requested (multiple times). I don't understand the resistance
> > towards doing so given the process has taken way way longer as a result.
>=20
> I think that Rob's comment was just skipped and original master binding
> was merged without addressing it. I don't want to repeat the same
> process for the "target". Indeed I could point this earlier... if I only
> knew that Rob pointed out that issue.

Oh I think I got confused here. The context for this mail led me to
think that this was still trying to push the i3c-master-v1 stuff through
and I was commenting on my frustration with the resistance to applying
the feedback received. I didn't realise that this was for another
patch adding a target.

I think you already said it, but NAK to adding any more compatibles here
until the soc-specific compatible that was asked for for the imx93 is
added.

Thanks,
Conor.

--lyAJBZzxW05Or8+L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaZQ2AAKCRB4tDGHoIJi
0pPQAPwOtqo+AaPupCQJlV+rWAmSvitBpzmIYrOAkGb6DlqLfAEAkGGgrQwVHqSi
f4RUVEYgW3INJX+Bf9bl1aY22t/R4gw=
=o8PF
-----END PGP SIGNATURE-----

--lyAJBZzxW05Or8+L--

