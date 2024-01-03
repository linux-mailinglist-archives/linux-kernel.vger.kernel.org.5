Return-Path: <linux-kernel+bounces-15458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0BD822C44
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51591C23115
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8431618E35;
	Wed,  3 Jan 2024 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="DkaoUD9m"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B22199A1;
	Wed,  3 Jan 2024 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
	s=s31663417; t=1704281856; x=1704886656; i=frank-w@public-files.de;
	bh=sUpi9OO18E6+D4gSZ3zZNN+IT1SjgCxBXG5+RS7BeFk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=DkaoUD9mIKj4cwMCmzN4odZ5Qfr7MwPs2SOO/cwIcQo7KU9WI7m3nA6Udjxs1AL3
	 +h+HFCv7ttqCspwQArgaHQILKA8wgcjr1HZOZZC//40Vs7aGvoe6Eb29OSOD8tSlD
	 Ig5cl8rTJrfpzpMzYcXwiniILgzTXq2H2WfiTgW+of5iEACMrz2m5j/1tgf7vdRD3
	 GqJEIJgmNbB0+Hcd+y1WEbQMp8ZWpejeTJhFi8CH9ZmnSPzppUihgKZWT3kNuGMpb
	 eCvaA1A2vZ2tQ03eVgKI1Lo50zFroBLctT/Nc6b8DJFVCyhe1FTLR8cy0EecZyoyf
	 a5wCOs5Rb0/9l9O9Uw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.158.44] ([217.61.158.44]) by web-mail.gmx.net
 (3c-app-gmx-bs51.server.lan [172.19.170.104]) (via HTTP); Wed, 3 Jan 2024
 12:37:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-9d471f1d-cbfd-492b-95a6-59aca5412fab-1704281856691@3c-app-gmx-bs51>
From: Frank Wunderlich <frank-w@public-files.de>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Daniel Golle <daniel@makrotopia.org>, =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?=
 <zajec5@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Hsin-Yi Wang <hsinyi@chromium.org>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 jason-ch chen <Jason-ch.Chen@mediatek.com>, Macpaul Lin
 <macpaul.lin@mediatek.com>, =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?=
 <bero@baylibre.com>, Sean Wang <sean.wang@mediatek.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Daniel
 Golle <daniel@makrotopia.org>
Subject: Aw: Re: [PATCH 2/2] arm64: dts: mediatek: Add initial MT7988A and
 BPI-R4
Content-Type: text/plain; charset=UTF-8
Date: Wed, 3 Jan 2024 12:37:36 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <04dbf010-5e0a-42f9-8a13-d02f97347c23@collabora.com>
References: <20240102205941.29654-1-zajec5@gmail.com>
 <20240102205941.29654-2-zajec5@gmail.com>
 <04dbf010-5e0a-42f9-8a13-d02f97347c23@collabora.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:UwYn9+R8+0ROzDo5XL00LlQX5+rKlJBgLjUUaYfq5iSqqHiUEJTjbA8gqjeS2XPDokroC
 H41V2BF6UJR1VrJhdN4z/T3jssHSVxO6DS5A3cb5aEjELuXAawMQKgCf8+meG61g9hQzrK9QfU9d
 J2kP3bGpFwefsHMASVgiaSQ3NOLdYmTJKBlwhpASs7kG/9VvtTDcfcOALF8m9E/Se1rRbvgiEoE2
 4xt1FmUUlO0IzKfbxsvkVRSEhf87D+vlaHBIFQVJ6QDLoFzxV39XSLIG0C3BgJa0kEvJN0Na0IBz
 1c=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ml/GBz+8k3w=;0yL9TS6Khvfp6Eds/Jka3DWq23I
 Hi/qc5Tuz4deq2FsACkpvO4/GEzaxaJgJz8b7yrfFerTLdayeDnDlDGVyrCnZAygLnC01oNf+
 z1T73zzayk4BWQJs91FT31LFYmOyxMpF/7rS+LbnBj4/3X4WuWDueLOChxffVg7s4yQ3oQYrn
 /s4UOdc+UBCFjYJCDa7P8tSTOHKZyPxDbUcRCQ1TJj/Adn6d3mGWeUlZdQBNCPQYKSOL4WFnL
 wkC0il4KHnxvI4ctlB91KRlL9vzigMwwA7eSvrfqYxPfv6QzfUN/GmO8L/WhYPNUL6+4iiFOI
 DhKDsCKW/UCFdG/elAqPFVe35ENTYpRlEX5i4KpRlbnaZXXiKIrKcdTCgwaUAzY0/f/tiwPI4
 2iLXRp933jIobMft70ncF5/lAoEhOA7bwnYM6J2yqAh388ma3DFnE5IyM7SllJ4HZM/xOQKeP
 JdCsL3hdMzFL0vSi0mnlN7QGBBtLc1YcuPO3xQYTZ4VtfjkpWq2jF7qcJ33KWyx1fnaBK4rkL
 ERo/c4PwwmkujuGR1byH8enj+tW/XHh1NVhwdCUA1/wy6JWMOI0EUr0NaZhs7KPdonzr6nSrO
 lEwpJNTeDWdwnzc0+12K7LAIkzUeDQUPqfFvTXBFDTJ3H17wpIsLkrOtMlBKmpu0yVA6QQ+Jj
 i3LlWAnvvSvmr0O3YZ5ojir0lRnsKRdNPSXekluSiAk702uus578yIgdQI5MRY+Lt9pW9w4Mu
 kcAucHSqbnJhZonS6BVkEWGSM3g4wgbgiMhfIiPB35V31chQt/k+HNN5qD4OQFK90Pw/khQFf
 AKU9far4mZG4i888k2esby2Q==

Hi

thanks Rafal for making the first loop of Dts-patches and splitting it and=
 Angelo for first review=2E
Just my 2c on the thermal-part=2E

> Gesendet: Mittwoch, 03=2E Januar 2024 um 10:49 Uhr
> Von: "AngeloGioacchino Del Regno" <angelogioacchino=2Edelregno@collabora=
=2Ecom>
>
> Il 02/01/24 21:59, Rafa=C5=82 Mi=C5=82ecki ha scritto:
> > From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki=2Epl>
> >=20
> > MT7988A (AKA MediaTek Filogic 880) is a quad-core ARM Cortex-A73
> > platform designed for Wi-Fi 7 devices (there is no wireless on SoC
> > though)=2E The first public MT7988A device is Banana Pi BPI-R4=2E
> >=20
> > Many SoC parts remain to be added (they need their own bindings or
> > depend on missing clocks)=2E Those present block however are correct a=
nd
> > having base =2Edtsi will help testing & working on missing stuff=2E
> >=20
> > +	thermal-zones {
> > +		cpu-thermal {
> > +			polling-delay-passive =3D <1000>;
> > +			polling-delay =3D <1000>;
> > +
>=20
> Those thermal zones will not work, as they have no thermal-sensors - as =
this
> node is right now, it will produce a probe error and nothing else: pleas=
e
> either drop it entirely or add support for the thermal sensors (lvts or =
auxadc?)
> and fix this node to use them=2E

it is LVTS and i upstreamed dt-binding and driverchange already, but it al=
so needs a (infracfg-)reset which
i try to upstream soon after infracfg clock driver appear in next (imho da=
niels patch merged in subsystem tree today)=2E

so also the infracfg-node will be needed in next round, if thermal part sh=
ould be part of it (else not much is in the dtsi at this time)=2E

> > +			trips {
> > +				crit {
> > +					temperature =3D <125000>;
> > +					hysteresis =3D <2000>;
> > +					type =3D "critical";
> > +				};
> > +
> > +				hot {
> > +					temperature =3D <120000>;
> > +					hysteresis =3D <2000>;
> > +					type =3D "hot";
> > +				};
> > +
> > +				active-high {
> > +					temperature =3D <115000>;
> > +					hysteresis =3D <2000>;
> > +					type =3D "active";
>=20
> Active cooling is board specific=2E Keep only critical/hot trips in the =
SoC DT=2E
>=20
> > +				};
> > +
> > +				active-med {
> > +					temperature =3D <85000>;
> > +					hysteresis =3D <2000>;
> > +					type =3D "active";
> > +				};
> > +
> > +				active-low {
> > +					temperature =3D <40000>;
> > +					hysteresis =3D <2000>;
> > +					type =3D "active";
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +	timer {
> > +		compatible =3D "arm,armv8-timer";
> > +		interrupt-parent =3D <&gic>;
> > +		interrupts =3D <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> > +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> > +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> > +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> > +	};
> > +};
>=20
> Regards,
> Angelo

@rafal how do we sync our work? what is your codebase?
i currently work on daniels wip tree, but it does not contain your current=
 splitting=2E=2E=2E
maybe daniel can include your splitted dts patches?

i already tried to fix some binding-issues in the full dts(i)=2E=2E=2E=2E
waiting for vendor about clocks for mmc which are currently not matching a=
ctual binding (and using mt7986 compatible)=2E

regards Frank

