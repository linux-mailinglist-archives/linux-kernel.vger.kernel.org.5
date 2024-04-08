Return-Path: <linux-kernel+bounces-135075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB9789BACD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD051F23D19
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2555453E3B;
	Mon,  8 Apr 2024 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0fIGRVRr"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84974084A;
	Mon,  8 Apr 2024 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565928; cv=none; b=FwasQeKMmO0GBLIfw3zteeLWGCnXNZr/o9KdNNzc1IgaRGdUaRMTbYSdYii0AbvLyy4oUzi8KD6yLGRc2TivHGDvp/BSlzTN4i+ALuGOYO3+n52A1jGJtfUCiZMRJ6C5iYyrVptsBms2tqanRkfJql/jzN+1hbsOdUmm1QpEzbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565928; c=relaxed/simple;
	bh=83N2Zg358rfVEcQ6QuWDjqdgmN731APrX4ABU4MXzWw=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hlh9wnmEZU1xJ4DZsbvFdFrUSdfFNj0rPFqCQl9eysazKIQtzh9xmoqIBLhPN6+1apUgjtCdy3oNiNCVNvesQ3G3sBc6yv6ULu5kO/dI8FjMRwgfA6hkOK8C4KGfmWjdbV7gt68h2ms7rgObf+sm7n64Rdu+nACPIV1c20t8U0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0fIGRVRr; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712565926; x=1744101926;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=83N2Zg358rfVEcQ6QuWDjqdgmN731APrX4ABU4MXzWw=;
  b=0fIGRVRrvTMriWhmiUu2BRj+MIs9HOZFUamqHoVBmURgIOlXN2+0+Nbm
   HNVrtiJeQSQ0WiaVl6O6FVWSGkoPcUtqIePeSCNNI9Uy+kYyNF9OWT6+f
   DXxnMRLvWQUfIouVOgmsP80m2jU+C/vDEoCwH4KoUxROjJLNjp4AVvt7Q
   fpggdQ35KSIlgZWpzHfQ9hY2Pg8jEHo9bKMQtPojIowoZd49v9MmBYfDa
   7YF19bYYx3jRrmaYD0PCwZHxxRvKn46nqagJ4DGFanEnIxpWV2d5L1bVd
   IfLBPF7+ek5ZnjrzLIEjhT1C2IqxSl4UUgg9nSW+dbSOW46cfmFlPWXtb
   g==;
X-CSE-ConnectionGUID: QDy9mJANSZOULymPxbzwyg==
X-CSE-MsgGUID: AOvaTyltR22o+QtiX/EJEw==
X-IronPort-AV: E=Sophos;i="6.07,186,1708412400"; 
   d="scan'208";a="187258007"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Apr 2024 01:45:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 01:45:15 -0700
Received: from DEN-DL-M31857.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 01:45:13 -0700
Message-ID: <3f1fa4837819099bb91f83ace0cc6473e131d4a9.camel@microchip.com>
Subject: Re: [RFT PATCH v2 10/10] arm64: dts: microchip: sparx5_pcb135: drop
 duplicated NOR flash
From: Steen Hegelund <steen.hegelund@microchip.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Lars Povlsen
	<lars.povlsen@microchip.com>, Daniel Machon <daniel.machon@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Bjarni Jonasson
	<bjarni.jonasson@microchip.com>, "David S. Miller" <davem@davemloft.net>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <horatiu.vultur@microchip.com>
Date: Mon, 8 Apr 2024 10:45:12 +0200
In-Reply-To: <20240405190419.74162-10-krzk@kernel.org>
References: <20240405190419.74162-1-krzk@kernel.org>
	 <20240405190419.74162-10-krzk@kernel.org>
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

On Fri, 2024-04-05 at 21:04 +0200, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you
> know the content is safe
>=20
> Since beginning the DTS extended the SPI0 in two places adding two
> SPI
> muxes, each with same SPI NOR flash.=C2=A0 Both used exactly the same
> chip-selects, so this was clearly buggy code.=C2=A0 Then in commit
> d0f482bb06f9 ("arm64: dts: sparx5: Add the Sparx5 switch node") one
> SPI
> mux was removed, while keeping the SPI NOR flash node.
>=20
> This still leaves duplicated SPI nodes under same chip select 0,
> reported by dtc W=3D1 warnings:
>=20
> =C2=A0 sparx5_pcb135_board.dtsi:92.10-96.4: Warning
> (unique_unit_address_if_enabled):
> /axi@600000000/spi@600104000/flash@0: duplicate unit-address (also
> used in node /axi@600000000/spi@600104000/spi@0)
>=20
> Steen Hegelund confirmed that in fact there is a SPI mux, thus remove
> the duplicated node without the mux.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>=20
> ---
>=20
> Not tested on hardware
>=20
> Changes in v2:
> 1. Remove SPI node without mux.
> ---
> =C2=A0arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi | 9 --------=
-
> =C2=A01 file changed, 9 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
> b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
> index 20016efb3656..af2f1831f07f 100644
> --- a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
> +++ b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
> @@ -87,15 +87,6 @@ i2cmux_s32: i2cmux-3-pins {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> =C2=A0};
>=20
> -&spi0 {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flash@0 {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 compatible =3D "jedec,spi-nor";
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 spi-max-frequency =3D <8000000>;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 reg =3D <0>;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> -};
> -
> =C2=A0&spi0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi@0 {
> --
> 2.34.1
>=20

This also works fine on my setup now.
Thanks for the patch series.

For this patch:
Tested-by: Steen Hegelund <Steen.Hegelund@microchip.com>


BR
Steen


