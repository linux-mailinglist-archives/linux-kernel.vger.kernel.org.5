Return-Path: <linux-kernel+bounces-90399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D020B86FEA8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE811F22F1F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8086D3D544;
	Mon,  4 Mar 2024 10:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="d+D4umXx"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378D925755;
	Mon,  4 Mar 2024 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547161; cv=none; b=QXwwmYetuuQb+AvCRQWnNZdrEnFn4K/z2RcXnrGpqRHAMc3grmX44/4UqBP2QRrDNWwCKXJOm7CJ7SyZ4q/0HWxQDa094WAdfDIgPF5i0sCDKuJzbEht7+42SSshLF1729cIZJGtplfHBo8GpWCcgxgUt+/kAJXYtgdFHr6X8EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547161; c=relaxed/simple;
	bh=kfAcNKmA4cBvu+kjAgfSfD0IyZ8QJAIfKSZTQk0XGtM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSX8lbT2zXPyQLc1HYRbOKJLq+b047nTL3un1itfJZrH42M8H1FJO2BOqsFY70f1vyuuSDV1xv387z22LaZ2N/BDQEK6JL+OsnlOfRk6IK15gtOlwNkQ2RmyKTVrjQJeQhToPWYREdHw0C75S4jIigGaN8F0ZKdQAhpgSZttVUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=d+D4umXx; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709547159; x=1741083159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kfAcNKmA4cBvu+kjAgfSfD0IyZ8QJAIfKSZTQk0XGtM=;
  b=d+D4umXxKq+/z12ay63WdCST85WafWmWTQq6ktq5dHhxEEMLV3DqtcgT
   hzdtFtksThsDHsqlf2PtZazrijCtxJEpBEqcuO9crvYYfFTcC2hW40sWp
   OuEucRbxGlNXR4rBzzbkovspe+L6mEvjD/vfv4SE4exhSA4AnuAMp/IbQ
   7MtxN0/2vDJKE2u/hgNzUSYos+ty0qm481WxZvHGs6/oLrIgI9gpgh32O
   pvaZwq4hsXJ81FfY5l4ZFBq/dv+Xd8DJud1iJs3Yh0B9+gm24f+AQ2Yl9
   YqOCzd9K+9OVla6cljSHk9yhLNK0lA7YatLgD7xRn2EJHXJ+J7D63VnT2
   g==;
X-CSE-ConnectionGUID: wCwOhLHtRuaTzD16zsH71g==
X-CSE-MsgGUID: pesRzB4dSCO6pOnMr5pS8w==
X-IronPort-AV: E=Sophos;i="6.06,203,1705388400"; 
   d="asc'?scan'208";a="17693678"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2024 03:12:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 03:12:31 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 4 Mar 2024 03:12:29 -0700
Date: Mon, 4 Mar 2024 10:11:45 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Yangyu Chen <cyy@cyyself.name>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	<linux-riscv@lists.infradead.org>, Conor Dooley <conor@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: add Canaan K230 boards compatible
 strings
Message-ID: <20240304-wharf-safely-8167b9641821@wendy>
References: <tencent_E15F8FE0B6769E6338AE690C7F4844A31706@qq.com>
 <tencent_D5188EA5B85A31AC21588DBD7C7482ACDA08@qq.com>
 <7c3c578a-d662-4485-ad15-47250ad0e935@linaro.org>
 <tencent_BF607C338244DA7F8EB2B8F2314A218B8D08@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sMeZDBbqBAeg1clN"
Content-Disposition: inline
In-Reply-To: <tencent_BF607C338244DA7F8EB2B8F2314A218B8D08@qq.com>

--sMeZDBbqBAeg1clN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 04:51:05PM +0800, Yangyu Chen wrote:
> On 2024/3/4 16:11, Krzysztof Kozlowski wrote:
> > On 03/03/2024 14:26, Yangyu Chen wrote:
> > > Since K230 was released, K210 is no longer the only SoC in the Kendry=
te
> > > series, so remove the K210 string from the description. Also, add two
> > > boards based on k230 to compatible strings to allow them to be used i=
n the
> > > dt.
> > >=20
> > > Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> > > ---
> > >   Documentation/devicetree/bindings/riscv/canaan.yaml | 13 ++++++++++=
++-
> > >   1 file changed, 12 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/riscv/canaan.yaml b/Do=
cumentation/devicetree/bindings/riscv/canaan.yaml
> > > index 41fd11f70a49..444758db964e 100644
> > > --- a/Documentation/devicetree/bindings/riscv/canaan.yaml
> > > +++ b/Documentation/devicetree/bindings/riscv/canaan.yaml
> > > @@ -10,7 +10,7 @@ maintainers:
> > >     - Damien Le Moal <dlemoal@kernel.org>
> > >   description:
> > > -  Canaan Kendryte K210 SoC-based boards
> > > +  Canaan Kendryte SoC-based boards
> > >   properties:
> > >     $nodename:
> > > @@ -42,6 +42,17 @@ properties:
> > >         - items:
> > >             - const: canaan,kendryte-k210
> > > +      - items:
> > > +          - const: canaan,k230-usip-lp3-evb
> > > +          - const: canaan,kendryte-k230
> > > +
> > > +      - items:
> > > +          - const: canaan,canmv-k230
> >=20
> > Why this is not part of previous entry in an enum?
> >=20
> > > +          - const: canaan,kendryte-k230
> > > +
> > > +      - items:
> > > +          - const: canaan,kendryte-k230
> >=20
> > Usually you cannot run SoCs alone. What does it represent (in real life=
)?
> >=20
>=20
> I'm not sure what it means.

You have a SoC compatible but no board compatible. You cannot run a SoC
without some sort of board connected to it, so this should be removed.

> If you wonder why should I add a compatible string for soc, that is altho=
ugh
> we cannot run SoCs alone, adding a soc compatible will allow some
> bootloaders or SBI on RISC-V to choose an errata for a soc. Such as this
> opensbi patch. [1]

You don't need to add an isolated compatible like this to be able to
apply that "erratum", the compatible is already documented from the
"usip-l3-evb" and "canmv-k230" entries.

> If you wonder why I should allow a soc-compatible string with soc alone,
> that is because k210 did it previously.

The k210 is not really a beacon of quality in the DT department, copying
=66rom there is likely to be misleading unfortunately.

> And provide a k210_generic.dts to
> use it. I haven't provided generic dts now but allowing only soc-compatib=
le
> string alone would also be acceptable I think.

To be honest, I would like to delete the generic dts for the k210, I
don't think it should exist, at least not in the current form.

Thanks,
Conor.

--sMeZDBbqBAeg1clN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeWeYQAKCRB4tDGHoIJi
0l7sAP47uOhYd1DCwmJBkxO8TaMhAQS5Yf1og9jIrnGIqxlXVgD/Y4GmbTvJfOfh
M8suFJ9UmnJ3S0rikA5KJgnrXlJZ7gA=
=TfqN
-----END PGP SIGNATURE-----

--sMeZDBbqBAeg1clN--

