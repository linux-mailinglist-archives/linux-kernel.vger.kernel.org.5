Return-Path: <linux-kernel+bounces-71436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4E885A539
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465D31F234EA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9360E36AFF;
	Mon, 19 Feb 2024 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8AyvZQ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D19364C6;
	Mon, 19 Feb 2024 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708351164; cv=none; b=On4HsBWiR/Bz3+OA5a4Hbm+/ZtxItXnMmvQZCCyTHRU/IVkypfr+BVCmWcICgjKUzS3S5dMP1oU9/ZwWt4w/iVMTfOmsft/Fr0nv2exxugmgDhGW2q5hJBzcfEbRsXo9tShlRyWBqFYDq+9+TtIpSSTVP7LJ7ZMlpYBYuyeeBqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708351164; c=relaxed/simple;
	bh=z+LUHVxMNuaZaB3RCn8D1OAdSMF663IBq3JaYmth/Bs=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=HeM1IYq+JYMuJ3XCJhd9dVNOmvD0EFbyHST+9/F8apLEhwtyRiIJA7YOrkbwKfeYzBi8vboWGqIPSy9ccNi6XGlYbnnnUnk5JlF7v4kqr/HtGUdmzGqETeWRzkDcQLOUYlcGiOgDhk7C4UqR5jhUmrcXOwa8xjg1OJuJalnyQts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8AyvZQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2B6C433F1;
	Mon, 19 Feb 2024 13:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708351164;
	bh=z+LUHVxMNuaZaB3RCn8D1OAdSMF663IBq3JaYmth/Bs=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=m8AyvZQ5Ohu1atbf96hEHaz9Pokq2daWbrJfLUgMLQRFIQOa8lbFCHhtlvYjRGY9z
	 06b32rtvxL7d6gRwUBpsxeOEmqEAJ5d/KTCEySs+UllYH7K+aFq3CYUdpfjDTXWjb3
	 tJzaua0YMTlQdyeTxdG//DX6ASbplDq34q+E0r2xXNiDFjkDkONTbDHFhTMqdN89Kn
	 BFkpTMPq8gMzGRPMozKDC5B2oDqY3A0FgrYe5BUCSrUVbQGhIkFftwOd28g8YhpdF6
	 iVoutFNaee+xsY+50Glo4NZWSMT1nffJXJMtFPeePcb9YDxwuTdvETsj7zdUPG6nef
	 ow43dtJLGgh9g==
Content-Type: multipart/signed;
 boundary=99d1e3bae09ed9ca9f76a08dd12da8ba24b3a631d884834e984f62944198;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Mon, 19 Feb 2024 14:59:16 +0100
Message-Id: <CZ93XYV3MB10.YRCFWLLHIICY@kernel.org>
Cc: <devicetree@vger.kernel.org>, "Sean Wang" <sean.wang@mediatek.com>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: add Kontron 3.5"-SBC-i1200
X-Mailer: aerc 0.16.0
References: <20240219084456.1075445-1-mwalle@kernel.org>
 <20240219084456.1075445-2-mwalle@kernel.org>
 <2ad6bda8-a457-421b-b35d-dc005fb00ae9@collabora.com>
 <CZ92W3VSYV1A.1693O76GY1XDP@kernel.org>
 <b50d49fd-2976-46fc-9f35-354fb39720ad@collabora.com>
In-Reply-To: <b50d49fd-2976-46fc-9f35-354fb39720ad@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--99d1e3bae09ed9ca9f76a08dd12da8ba24b3a631d884834e984f62944198
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Feb 19, 2024 at 2:35 PM CET, AngeloGioacchino Del Regno wrote:
> >> vbus is always supplied by something, as otherwise USB won't work - wh=
ether this
> >> is an always-on regulator or a passthrough from external supply this d=
oesn't really
> >> matter - you should model a regulator-fixed that provides the 5V VBUS =
line.
> >=20
> > I don't think this is correct, though. Think of an on-board USB
> > hub. There only D+/D- are connected (and maybe the USB3.2 SerDes
> > lanes). Or have a look at the M.2 pinout. There is no Vbus.
> >=20
>
> Yes but the MediaTek MTU3 and/or controllers do have it ;-)

. and ..

> >> For example:
> >> 	vbus_fixed: regulator-vbus {
> >> 		compatible =3D "regulator-fixed";
> >> 		regulator-name =3D "usb-vbus";
> >> 		regulator-always-on;
> >> 		regulator-boot-on;
> >> 		regulator-min-microvolt =3D <5000000>;
> >> 		regulator-max-microvolt =3D <5000000>;
> >> 	};
> >=20
> > As mentioned above, I don't think this will make sense in my case.
> >  >> P.S.: If the rail has a different name, please use that different n=
ame. Obviously
> >> that requires you to have schematics at hand, and I don't know if you =
do: if you
> >> don't, then that regulator-vbus name is just fine.
> >=20
> > I do have the schematics.
>
> In that case, you should model the power tree with the fixed power lines,
> check mt8195-cherry (and/or cherry-tomato) and radxa-nio-12l; even though
> those are technically "doing nothing", this is device tree, so it should
> provide a description of the hardware ... and the board does have fixed
> power lines.
> It has at least one: DC-IN (typec, barrel jack or whatever, the board nee=
ds
> power, doesn't it?!).

Mh, maybe I don't get it. But within the hardware there is simply no
Vbus. Thus I'd argue it doesn't make sense to have a vbus-supply
property. Besides, the mediatek,mtu3.yaml binding lists it as
deprecated anyway and it should rather be on the connector. There,
it makes perfectly sense (at least if it's a USB connector).

Thus in my case, the xhci for the front port has a vbus-supply
property (but it should rather have a connector node, as I've just
learned). But the internal port which connects to the USB hub
shouldn't have one.


  +-----+           +-----+                  +------+
  |     |<--Dp/Dn-->|     |<------Dp/Dn----->| USB  |
  | SoC |           |     |                  | Conn |
  |     |           |     |   +-----+        |      |
  +-----+           | USB |   | PWR |--Vbus->|      |
                    | Hub |   | SW  |        +------+
                    |     |   +-----+
                    |     |     ^
                    |     |     | PRTPWR
                    |     |-----'
                    +-----+

"PWR SW" is a power switch, the input (+5V) isn't shown here. The
power will be enabled by the USB Hub.

-michael

--99d1e3bae09ed9ca9f76a08dd12da8ba24b3a631d884834e984f62944198
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIgEABYIADAWIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZdNetBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQzcodo7VsRvudvgEAyZCGdO77Pxmrm6K+phBbI5ki8C3j8JDu
SRao0N5psZUBAJZpI2DCkGN2QIvMqVrxwVuZpy7mA4Hbal7hl7rlF3gH
=UXiX
-----END PGP SIGNATURE-----

--99d1e3bae09ed9ca9f76a08dd12da8ba24b3a631d884834e984f62944198--

