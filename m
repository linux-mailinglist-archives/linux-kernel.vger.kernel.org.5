Return-Path: <linux-kernel+bounces-128091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668F9895600
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EAEB28256A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DDF85C5E;
	Tue,  2 Apr 2024 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1K/27f1q"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDE385639;
	Tue,  2 Apr 2024 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066440; cv=none; b=IWM9YK88PKrSXjDU5InSLftYPt3WLjUH21GU9RcyuNBdQM0sjaUa+NyG2kfGxNZIHetOVCejAvoz9t5eTJETGbsoDRssrT6yzZaPBph6SLp1vRLfQOPwA6JfRrDgELhVvEXRKkoJ6+rblM6bKQfPp2Ssj+2ItFtlolZ+qQyAhIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066440; c=relaxed/simple;
	bh=qsST0ylz6gOANXRGsGFqczoAFStFcUOplO5NxDoGV7U=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C0MaAdWvZMlWqqkYFMI1ZsJf1JLB/4goOXO9u5OeVGEyPLSaUF5n3EF3pg8hZZi7k+rm2XFU4pyr39KPTbuRGcJ84n7e2g103pc5nVvrylpXEmUuv/YNjcJthDJrNmhnj/ZC/wU/eGRygxpjzEYh2JLmR+JwIugPKUGVzZ0jE2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1K/27f1q; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712066438; x=1743602438;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=qsST0ylz6gOANXRGsGFqczoAFStFcUOplO5NxDoGV7U=;
  b=1K/27f1qJ0aJ/VMY9DZCAMala9HzpzdZxIpqluoufgxI16a/RL5fUvwt
   cSMPOgk0yhL0xe1LN11ugXrtlLZqgwc6k1Lq/4xFQLmAO9bCidNiTtDqx
   9hZJxpgDkSh4y6dKcO/IlDdZexQEN0R4TaQ5AgG83yMBqr3WsShM9M/Nl
   CdPzK3RYXre/Dq28wqRuHSE1PZWiu9NIV70373cC3jRMYQXrUreddtTXz
   3Od2pallLfWqsJQ7Y8l4xRLZsKyn3EXinjS2qNmpjHJG9rh71PLHD8mM3
   NiLc2GuZe541Sh3tehvs3BsF6eDQndBsGlCV+cv3DfxVfSFaORGfLS1/E
   g==;
X-CSE-ConnectionGUID: FQZgR+amRMal/fXHX2p5Mw==
X-CSE-MsgGUID: 8c+KslA7TH6D+wDEUkqJTQ==
X-IronPort-AV: E=Sophos;i="6.07,175,1708412400"; 
   d="scan'208";a="19169899"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Apr 2024 07:00:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 07:00:35 -0700
Received: from DEN-DL-M31857.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 07:00:33 -0700
Message-ID: <b3d818df8819d2fb3e96fa61b277d49941d9b01b.camel@microchip.com>
Subject: Re: [PATCH RFT 01/10] arm64: dts: microchip: sparx5: fix mdio reg
From: Steen Hegelund <steen.hegelund@microchip.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Lars Povlsen
	<lars.povlsen@microchip.com>, Daniel Machon <daniel.machon@microchip.com>,
	<UNGLinuxDriver@microchip.com>, "David S. Miller" <davem@davemloft.net>,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Conor Dooley <conor@kernel.org>
Date: Tue, 2 Apr 2024 16:00:32 +0200
In-Reply-To: <20240401153740.123978-1-krzk@kernel.org>
References: <20240401153740.123978-1-krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Krzysztof,


On Mon, 2024-04-01 at 17:37 +0200, Krzysztof Kozlowski wrote:
> [Some people who received this message don't often get email from
> krzk@kernel.org. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification=C2=A0]
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you
> know the content is safe
>=20
> Correct the reg address of mdio node to match unit address.=C2=A0 Assume
> the
> reg is not correct and unit address was correct, because there is
> alerady node using the existing reg 0x110102d4.
>=20
> =C2=A0 sparx5.dtsi:443.25-451.5: Warning (simple_bus_reg):
> /axi@600000000/mdio@6110102f8: simple-bus unit address format error,
> expected "6110102d4"
>=20
> Fixes: d0f482bb06f9 ("arm64: dts: sparx5: Add the Sparx5 switch
> node")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>=20
> ---
>=20
> Not tested on hardware
> ---
> =C2=A0arch/arm64/boot/dts/microchip/sparx5.dtsi | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi
> b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> index 24075cd91420..5d820da8c69d 100644
> --- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
> +++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> @@ -447,7 +447,7 @@ mdio2: mdio@6110102f8 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-=
names =3D "default";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address=
-cells =3D <1>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-ce=
lls =3D <0>;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x6 0=
x110102d4 0x24>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x6 0=
x110102f8 0x24>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 };
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mdio3: mdio@61101031c {
> --
> 2.34.1
>=20

I did a check of our current Sparx5 EVBs and none of them uses
controller 2 in any revision, so this is probably why it has not come
up before, so as it stands we have no platform to test this change on
currently.

Besides that the change looks good to me.

Best Regards
Steen

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>



