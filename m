Return-Path: <linux-kernel+bounces-135061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9340A89BA96
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B634FB22948
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782F53B7A0;
	Mon,  8 Apr 2024 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QVUI2r6z"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DC239AC7;
	Mon,  8 Apr 2024 08:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565875; cv=none; b=B1Fl4C7F284TQoHiK7oxpxgMw/GMpRMrzpojbeVyjAwBxFgxtKMm2EO+F3tdQqA1v37TuahXg4u3+6o/IpKAYWfefI3PPxusAPajAox7HjD7qvhWhdhQWPxTWJ5llpA3iSsCStjQBhht+MJi1smpwZLVFZu34DQXfMr3mPkKX8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565875; c=relaxed/simple;
	bh=w/7Cfru1jeu34Q9Vl8j4bBuUInw+tAUevmF63QKFySs=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IRb+TBt/xb5LDxTSJuvZy79fEno6EClpee5X6n9Q9+d6/Dg1fNAB4T9RUnzNVurHfAdzPHyKRb0rsZJpUnfK+rH9DYIWt7hcr+Bx2ChR4K5L1IFbtt41vgVNFneKJ3C9diEaMh2HGi5+CQOM8is21BSqALNplC3zd1H0YbNgdnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QVUI2r6z; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712565873; x=1744101873;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=w/7Cfru1jeu34Q9Vl8j4bBuUInw+tAUevmF63QKFySs=;
  b=QVUI2r6zxjp8yEdQxJ2+LlKe0qCm6/93DKoFvRPHc0kr8JIIYkpMBPkD
   SuUol+6FUYaHUk/aO/TaXATroPmAifxE8KQ+ZlFF0V5kGSYUgApOhHC/H
   yhu79hAkO4sglLjALNUrQd6jDqjZJQZTiZIu6aXLQmjZX3t5q1mvpIIh9
   gwAHJpR+nFMXgoWZguydE7rhI3Kp0QjikOpjTNxRHZV+WgFTGW+N4YbMC
   vIT3X0XardU0mLmM/1358ADhmiuMNR32vx41OfpzYLqqOwewWwUDkZC5J
   K8xdBhRRIEv3umm/+qSV0m2UJHnRdfQYwMKPNgqXZDVai7B4YVrIqgaz0
   A==;
X-CSE-ConnectionGUID: 8pobTt9vTly9Ld1KhjYNIw==
X-CSE-MsgGUID: WATcLxsPS9ybzdgc+0gB7Q==
X-IronPort-AV: E=Sophos;i="6.07,186,1708412400"; 
   d="scan'208";a="19929239"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Apr 2024 01:44:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 01:44:04 -0700
Received: from DEN-DL-M31857.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 01:44:02 -0700
Message-ID: <86852effcded43fa054f5abbde40ba0d56212f67.camel@microchip.com>
Subject: Re: [RFT PATCH v2 09/10] arm64: dts: microchip: sparx5_pcb134: drop
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
Date: Mon, 8 Apr 2024 10:44:01 +0200
In-Reply-To: <20240405190419.74162-9-krzk@kernel.org>
References: <20240405190419.74162-1-krzk@kernel.org>
	 <20240405190419.74162-9-krzk@kernel.org>
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
> =C2=A0 sparx5_pcb134_board.dtsi:277.10-281.4: Warning
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
> =C2=A0arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi | 9 --------=
-
> =C2=A01 file changed, 9 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
> b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
> index f165a409bc1d..2c5574734c9e 100644
> --- a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
> +++ b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
> @@ -272,15 +272,6 @@ gpio@1 {
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

This works fine on my setup now.
Thanks for the patch series.

For this patch:
Tested-by: Steen Hegelund <Steen.Hegelund@microchip.com>

For whole series:
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>




