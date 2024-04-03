Return-Path: <linux-kernel+bounces-129186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EC08966B3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C5F28253B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357D56E60F;
	Wed,  3 Apr 2024 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jX9Xyvip"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715F95D732;
	Wed,  3 Apr 2024 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129764; cv=none; b=Js8MEj4uRBHvhJ65DI37HhbiKBWr6S+qtVOj8XtjvhU59BTNbjTfTCGAPpS9bG1IX9n1KqR+2aXpMRwdmg2QHUnfU6aNE7SvCYHdup03gieuUvcj5RRhqUPXlxFe9og8kZgZNSFWk45yDfdVBaZ7GKdZHD1L4Gulh2eOnEclZSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129764; c=relaxed/simple;
	bh=comgvq/b/dwZzcz2JKiAiH5R+wKfYaBn19+EszVed4M=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=IxHahNl7IFlWYIET0RlPjLut6rnmBqEJRre63n+emaVnujwSlBekjgM1KhXzz+3rfs8CuMGHZLeCw9XGilcrOknebLmQRrhTRN3QXaJtOSpHpjzM3o5sbP4eRlK2eX0fEtuTduYZaD/hJPL/a67KMZ0lGOPxoF82hDHN1NdO628=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jX9Xyvip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717BFC433C7;
	Wed,  3 Apr 2024 07:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712129763;
	bh=comgvq/b/dwZzcz2JKiAiH5R+wKfYaBn19+EszVed4M=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=jX9XyvipU7W5InrF55jvVKTf5hV4lNqR9/nPyJZQXUCD1AzJ7vSzG3njmgo0VgRTS
	 SWV1y9yPgz8kyAaAmCteRrfG7kihV2of+Qbumh9mcfhOnciIstv9yT7ozWpy0shln/
	 Lvxej33RnmwoE39JuESlK1ccFpL38Fpma6kUhJCoTZ38IYBrW6Y0AWx8swRG7cj1Dq
	 de8SK+MGCX6/RM8aKHhentdf+4qqQKyrVVOC1YjAT+mhjJlZGSi4Z7AxIa6dBWJB9z
	 M+7uP27PyHXmVEb5HPV3O+bzkZJreQwOcR4tGMk6+G5YHMvefZnyl4ehojdcLJMJlK
	 8rnWXXIguJGkQ==
Content-Type: multipart/signed;
 boundary=85268debbb0a249bf83d175894db0da66e51c3e05656b17bb875057ea9e9;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 03 Apr 2024 09:35:47 +0200
Message-Id: <D0ABCBUEV6ZD.1TDS2WSEH48DY@kernel.org>
Cc: "Nishanth Menon" <nm@ti.com>, "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Tero Kristo" <kristo@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Francesco Dolcini" <francesco@dolcini.it>
Subject: Re: [PATCH] arm64: dts: ti: k3-j722s: Disable ethernet ports by
 default
X-Mailer: aerc 0.16.0
References: <20240402151802.3803708-1-mwalle@kernel.org>
 <20240402165824.GA32125@francesco-nb>
In-Reply-To: <20240402165824.GA32125@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--85268debbb0a249bf83d175894db0da66e51c3e05656b17bb875057ea9e9
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Francesco,

On Tue Apr 2, 2024 at 6:58 PM CEST, Francesco Dolcini wrote:
> On Tue, Apr 02, 2024 at 05:18:02PM +0200, Michael Walle wrote:
> > Device tree best practice is to disable any external interface in the
> > dtsi and just enable them if needed in the device tree. Thus, disable
> > both ethernet ports by default and just enable the one used by the EVM
> > in its device tree.
> >=20
> > There is no functional change.
> >=20
> > Signed-off-by: Michael Walle <mwalle@kernel.org>
> > ---
> > This should also be true for all the other SoCs. But I don't wanted to
> > touch all the (older) device trees. j722s is pretty new, so there we
> > should get it right.
> > ---
> >  arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 5 +----
> >  arch/arm64/boot/dts/ti/k3-j722s.dtsi    | 8 ++++++++
> >  2 files changed, 9 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/=
dts/ti/k3-j722s-evm.dts
> > index d045dc7dde0c..afe7f68e6a4b 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> > +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> > @@ -224,14 +224,11 @@ cpsw3g_phy0: ethernet-phy@0 {
> >  };
> > =20
> >  &cpsw_port1 {
> > +	status =3D "okay";
>
> status should be the last property, according to the dts coding guideline=
s.

Thanks for pointing that out. There is
devicetree/bindings/dts-coding-style.rst, which is in fact new to
me. Up until now, I was under the impression that how this is
handled is up to the maintainer of the SoC. I know that for the NXP
Layerscape for example, the maintainer will have an eye esp. for
that. But here it seems kinda random/all over the place. That being
said, I tried to be consistent with the other cpsw* nodes.

Anyway, I'll change it to come last.

> >  	phy-mode =3D "rgmii-rxid";
> >  	phy-handle =3D <&cpsw3g_phy0>;
> >  };

-michael

--85268debbb0a249bf83d175894db0da66e51c3e05656b17bb875057ea9e9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZg0G1BIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/i0pAF8Dtz9BfG4VFPzoKkZsJB4/ncZfyEy67rC
g7XVK/JrcCwHEW/hAXnmXOs/cMk+J2XPAYDKbawvIqW1fdpvFoh5EKNQNSOtuAP9
YpTk1kAKNDkR8TGLeLubNsleDRzW8MdoHj4=
=PWPU
-----END PGP SIGNATURE-----

--85268debbb0a249bf83d175894db0da66e51c3e05656b17bb875057ea9e9--

