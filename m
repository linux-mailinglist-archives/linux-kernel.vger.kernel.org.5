Return-Path: <linux-kernel+bounces-81124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C1486708B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589B61F2B31F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0C91CD35;
	Mon, 26 Feb 2024 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="czKMvXSh"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC101BF53;
	Mon, 26 Feb 2024 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941676; cv=none; b=BKzwNfZG9NaRW+q73BWOEwr0idf1Ivsdas4p7rXPes8Pl0DbgMLFkeamoSqVZS8bgk10HSESCaErMNV4BUNeHX7AzdhYN8w3QVosHNbnxlaLNAaSjnEP4M8+u/TlM1JNpoQjHcyfM/iZ6A1NU+u+j32OZvJVaOYsEkhAFduRUfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941676; c=relaxed/simple;
	bh=20R+xqDeDVw9ZtogwM2IQU2YVHkmY//AxAOlDJCpmQY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bG0eAplGY+vhF1uGgueMdhYh1RvojE07cpsfp7/MsTFe12CUyAP8PFQXOEA1eUnkVl9KkhRZqVKwMUWIYPlBL3qz+KQT7Lz8lzDFtOr6jT6dBO5UgsGlC7KoSUbgG+dXBQs/88ssImhmb7PE5KqpoFBryNXbt/ZyXqbk05WCOYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=czKMvXSh; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708941675; x=1740477675;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=20R+xqDeDVw9ZtogwM2IQU2YVHkmY//AxAOlDJCpmQY=;
  b=czKMvXSh8aZMnPGlbdekLT8KXPCAKZrmKkjl2xbX1M9Pv8MylKQDtMOS
   wXBJYGC5u4Yg42sRBLz6YJVOgzmmRc9m0d5ecjEfJEk7Syd2DM+zhdjDU
   Lq8QfhzgU3HJ1OPFdl8LnLUCv33cl3jNE2MnB62JFiPvs9QkDix/hl8hi
   RHuiMghND83YRFzFGXqnWzBd0yLVDfN33tP2mFEp/Xe2lX515rFqLmo5H
   lemrCvIEluFT2dfwzTagUqq5lZtEZQxqJcd/U8/apd7QV9KwEKiZKLoGq
   WAP9BCcNiUHl3YGsW9JxQH7FUQMdZDk7yBIFyflrrfcL4aUD8XG+NF0cL
   g==;
X-CSE-ConnectionGUID: gRuuUu1JT96ZGupzs5M00w==
X-CSE-MsgGUID: hu0OAtBmSMyULpQwlqszwA==
X-IronPort-AV: E=Sophos;i="6.06,185,1705388400"; 
   d="asc'?scan'208";a="18370423"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Feb 2024 03:01:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 03:01:06 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 26 Feb 2024 03:01:03 -0700
Date: Mon, 26 Feb 2024 10:00:21 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
CC: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, Conor Dooley
	<conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, William Qiu <william.qiu@starfivetech.com>, Ley Foon
 Tan <leyfoon.tan@starfivetech.com>, <linux-pwm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: pwm: opencores: Add compatible for StarFive
 JH8100
Message-ID: <20240226-greasily-balcony-cee5014f5b8b@wendy>
References: <20240226033945.816974-1-jisheng.teoh@starfivetech.com>
 <opzxowacxsagwgw3l33p6y7omzjokus2bi3ol5wizfwjwi2s44@3p5frb4ysji7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qIf1NVTAKfLs5NKT"
Content-Disposition: inline
In-Reply-To: <opzxowacxsagwgw3l33p6y7omzjokus2bi3ol5wizfwjwi2s44@3p5frb4ysji7>

--qIf1NVTAKfLs5NKT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 09:11:23AM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Mon, Feb 26, 2024 at 11:39:45AM +0800, Ji Sheng Teoh wrote:
> > StarFive JH8100 uses the same OpenCores PWM controller as JH7110.
> > Mark JH8100 as compatible to the OpenCores PWM controller.
> >=20
> > Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> >=20
> > ---
> >=20
> > This patch depends on patch [1] ("dt-bindings: pwm: Add bindings for
> > OpenCores PWM Controller") in Conor's riscv-dt-for-next branch.
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/com=
mit/?h=3Driscv-dt-for-next&id=3D2529085831b01fcd02ff58ab4e2596d3b31bcf80
>=20
> I recommend to make use of git format-patch's --base parameter to
> additionally(!) make this information available to the build bots.

I like the "additionally" :)
>=20
> Looks fine to me.
>=20
> Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> Coner: If you're happy with this patch, please apply it in the same way
> as the initial OpenCores PWM Controller binding patch.

Ye, I can do. Although, I suppose this is an example of why the driver
maintainers applying the bindings is preferred, even if the driver patch
itself isn't ready or there is no driver patch.

Cheers,
Conor.

--qIf1NVTAKfLs5NKT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdxhNAAKCRB4tDGHoIJi
0sfGAP4gXa3ZQBTcw4KYOWpO4Y9Hl56JOtYMdxzTr8/ALwaDwAD/WwrHnl741xey
Tfp2k4uQHY/CONnty4macPOekNyY4wI=
=Oyq2
-----END PGP SIGNATURE-----

--qIf1NVTAKfLs5NKT--

