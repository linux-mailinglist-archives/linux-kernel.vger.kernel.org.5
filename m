Return-Path: <linux-kernel+bounces-71026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DB9859FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEC98B20A91
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB60723765;
	Mon, 19 Feb 2024 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8rTnnHg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6D523746;
	Mon, 19 Feb 2024 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334740; cv=none; b=Ixjtnsps8/4SDbZjlfbLnWodg1eHyO9yW6BTeD7mZEfrarw9CySTTqSHYyXiX7vvLjm2qHdVXekKLYc5W5suLAlXLt5fOTAVtoW/EMsXC0XcIiMdKsY4QIdlPHQPNBG03oMdVdDKUFM7IBrOTLUIve3JffvTNNTS98xIip+qAX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334740; c=relaxed/simple;
	bh=TQgJ/dUEc4sWbXoGbmu4Gc1ioWBXLv4l0BknLPBgqHs=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=lfxlaC5BTChlTmRh3SANwYb3XNCUA35eU4XbUd4F2naXFNjR+nmf7F5Oevptk+Oub7Oqc5bQJS2iVTy1zvRbUwKr6slYx6Ogmmce+P+0VEhOPdgmaxhuctp7rqZfi+QDD7dyY1+YShFFSKJDIlsqRyJ5/CxhWSev2hY6la5X+dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8rTnnHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBB4C433C7;
	Mon, 19 Feb 2024 09:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708334739;
	bh=TQgJ/dUEc4sWbXoGbmu4Gc1ioWBXLv4l0BknLPBgqHs=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=J8rTnnHg2jq4qSe9wkaheaQRnHYTStPOBliPhPlu9XMSyAH/7SWcw+hwCnAZQuBSp
	 pm85XhsSaDbD3Ax/bBjkrBzKoGoM97KCZVs+0q4D+rQpV9WLmtf6ALdW7f1weaxPWX
	 hUkEjEuIcTAbHDt0k5zo9PBiRn5YxkbIEq/aOHbAqSW2zcQ+CfhX2HiHZ6IrEozmnh
	 3rvO22UujnQ20i4N0rOlQYbTujhp3PfZSEJpQNk6QJco5j6aRrlcWtzj6n//wPkNP3
	 1FRCRfBoNY7g6cPGsxCE3z14MBM+xLVjYz/VIudpFQG2XclvUj+yxuHmgWviMY07UN
	 2r/5zPMQ89atw==
Content-Type: multipart/signed;
 boundary=03803a3ba4b4ec418cf5496082e438ace4bc390993da25f1c1c6651408c6;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Mon, 19 Feb 2024 10:25:31 +0100
Message-Id: <CZ8Y4DFQNLM9.3GIGATDIAXBR5@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm64: mediatek: add Kontron
 3.5"-SBC-i1200
Cc: <devicetree@vger.kernel.org>, "Sean Wang" <sean.wang@mediatek.com>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>
X-Mailer: aerc 0.16.0
References: <20240219084456.1075445-1-mwalle@kernel.org>
 <72fffc25-33f0-4394-b7c1-8dbc2d23a4a4@linaro.org>
In-Reply-To: <72fffc25-33f0-4394-b7c1-8dbc2d23a4a4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--03803a3ba4b4ec418cf5496082e438ace4bc390993da25f1c1c6651408c6
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Feb 19, 2024 at 10:06 AM CET, Krzysztof Kozlowski wrote:
> On 19/02/2024 09:44, Michael Walle wrote:
> > Add the compatible string for the Kontron 3.5"-SBC-i1200 single board
> > computer.
> >=20
> > Signed-off-by: Michael Walle <mwalle@kernel.org>
> > ---
> > v2:
> >  - convert enum to const as there is only one specific board
> >=20
> >  Documentation/devicetree/bindings/arm/mediatek.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docu=
mentation/devicetree/bindings/arm/mediatek.yaml
> > index 09f9ffd3ff7b..add167d8b8da 100644
> > --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> > +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> > @@ -357,6 +357,11 @@ properties:
> >                - radxa,nio-12l
> >            - const: mediatek,mt8395
> >            - const: mediatek,mt8195
> > +      - description: Kontron 3.5"-SBC-i1200
> > +        items:
> > +          - const: kontron,3-5-sbc-i1200
>
> And then it should be part of earlier entry. Just take a look there in
> the file...

FWIW I did and all the entries with descriptions are by there own
(that's also true for fsl.yaml and sunxi.yaml).

mediatek.yaml seems to have both, either boards without description
like the "radxa,nio-12l" which you are probably referring to. Or
boards which has the same sub compatibles but still have individual
entries, like google,burnet, google,cozmo, google,damu.

Therefore, what is the rule of thumb here? Drop the description?
If so, why it it there in the first place?

-michael

--03803a3ba4b4ec418cf5496082e438ace4bc390993da25f1c1c6651408c6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIgEABYIADAWIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZdMeixIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQzcodo7VsRvus0wEA961xASC5sQxgLl7D2sdBs8vZGbpKm2xY
5IGGz3L8+T8A+gJrDnh9avI1bglxsEP4pVy4KSuErmUiYYw9/g58FPgO
=LoCQ
-----END PGP SIGNATURE-----

--03803a3ba4b4ec418cf5496082e438ace4bc390993da25f1c1c6651408c6--

