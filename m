Return-Path: <linux-kernel+bounces-71041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA816859FCE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4AF1F212C8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A73A286AC;
	Mon, 19 Feb 2024 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crbNLM/4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE43E2562E;
	Mon, 19 Feb 2024 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335392; cv=none; b=TjV3NmPx5iZxe4bXfDihMmJnN3zRi3tvCuzE7jFGG2EdowJA3j2bWrBJYScpoCWOcYY0RDFnW07ADMuayVTKTxtOO9tsJlCQ2zzlNq6kDMAAfZM0+eYTEnhP+HEJU6EGFS/FPEzm+ybJ7T2J2nGmh56y3TJN+6aUsHYufvxF7D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335392; c=relaxed/simple;
	bh=2JEkX46Vp/cBAVVvgsgHoF/zxvBsYbJKJ4rTHU/s2hk=;
	h=Content-Type:Date:Message-Id:From:To:Subject:Cc:References:
	 In-Reply-To; b=PyIWgaL+ThLGi19K+xsyf+WPFrANijjwAhQ/TXwoSSGei/2FtLgQw85nVAU8ry890VE2SYGN34VbYv4R9Bb6VR1s7lSh+INK6XA7Fx2/Q6yhaOpkwAWrsqzspU2vpcllAdEN7Naq3xnL6Z+WmUqy/F9Jgd+pc/Ee5rGvvovfIEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crbNLM/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA76DC433F1;
	Mon, 19 Feb 2024 09:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708335391;
	bh=2JEkX46Vp/cBAVVvgsgHoF/zxvBsYbJKJ4rTHU/s2hk=;
	h=Date:From:To:Subject:Cc:References:In-Reply-To:From;
	b=crbNLM/4l3WxOMO/z1NI5uM/uMSLp3JKrA1HesJ67bumXJ9OewEOn/oK7qGTbh/Cx
	 0MM5bHgbYQkGSbKzWTVhwTCMgD0EVbcfbjtXcG38PpFP+Jj/CQ4XFeGgcos2YTn08Q
	 xx7ZlwO0es5Pb936IJuNIXmLiqlMmgq8m/NoXFw0BhtowiQByycV0WreEjKwzfILek
	 5u3cVT4CLanHf1GdCmbYmTvdJcEjW5Kk1U0AutY8cz7O7dDQeUaVrLF1eegt+n7ilk
	 2ogtUwa2kqam0bgJT99sOLYI3e/7AYi6wbDRd6zSQFYvc7sVKVfnmcBfRUmpLLgDKl
	 xcyF5LzNi6Bsg==
Content-Type: multipart/signed;
 boundary=5b911bf665d2ea492c216b90f01b24b10ab08eb643d157bdd14da66d2129;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Mon, 19 Feb 2024 10:36:26 +0100
Message-Id: <CZ8YCQETS7LL.1BLJJZNCLV7DT@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm64: mediatek: add Kontron
 3.5"-SBC-i1200
Cc: <devicetree@vger.kernel.org>, "Sean Wang" <sean.wang@mediatek.com>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
X-Mailer: aerc 0.16.0
References: <20240219084456.1075445-1-mwalle@kernel.org>
 <ed3530f0-227a-47f2-938c-28eba90dd6eb@collabora.com>
In-Reply-To: <ed3530f0-227a-47f2-938c-28eba90dd6eb@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--5b911bf665d2ea492c216b90f01b24b10ab08eb643d157bdd14da66d2129
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Feb 19, 2024 at 10:23 AM CET, AngeloGioacchino Del Regno wrote:
> Il 19/02/24 09:44, Michael Walle ha scritto:
> > Add the compatible string for the Kontron 3.5"-SBC-i1200 single board
> > computer.
> >=20
> > Signed-off-by: Michael Walle <mwalle@kernel.org>
> > ---
> > v2:
> >   - convert enum to const as there is only one specific board
> >=20
> >   Documentation/devicetree/bindings/arm/mediatek.yaml | 5 +++++
> >   1 file changed, 5 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docu=
mentation/devicetree/bindings/arm/mediatek.yaml
> > index 09f9ffd3ff7b..add167d8b8da 100644
> > --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> > +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> > @@ -357,6 +357,11 @@ properties:
> >                 - radxa,nio-12l
> >             - const: mediatek,mt8395
> >             - const: mediatek,mt8195
> > +      - description: Kontron 3.5"-SBC-i1200
> > +        items:
> > +          - const: kontron,3-5-sbc-i1200
> > +          - const: mediatek,mt8395
> > +          - const: mediatek,mt8195
> >         - items:
> >             - enum:
> >                 - mediatek,mt8516-pumpkin
>
> I understand that you took inspiration from the Google Chromebooks entrie=
s, but
> those are separated only because they've got "a bunch of revisions".
>

I don't really care about the description. It's just the way I've
done it in the past. And in this file, there is also google,burnet,
google,cozmo, google,damu, without any further revs.

> For machines that don't have a billion compatible strings, I would sugges=
t to
> add the compatible under a single big entry: like this, the binding is (i=
mo) a
> bit more readable .. and cleaner.
>
> Eventually, the machine name is in the devicetree so we're not losing any=
 kind
> of information anyway... :-)
>
>        - items:
>            - enum:
>                - kontron,3-5-sbc-i1200
>                - mediatek,mt8395-evk
>                - radxa,nio-12l
>            - const: mediatek,mt8395
>            - const: mediatek,mt8195

Ack. I'll give you some time to look at the actual DTS before
posting a new version.

-michael

--5b911bf665d2ea492c216b90f01b24b10ab08eb643d157bdd14da66d2129
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIgEABYIADAWIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZdMhGhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQzcodo7VsRvs3fgEAlFQCpxkpEfzEqfjyl3YucexQcUbd1+Lj
0DJqee5gUp0BAP0BDmrnoWc+fCp5T7L07BNNJRAC7wDWhSUbmgvyBvEF
=mwoc
-----END PGP SIGNATURE-----

--5b911bf665d2ea492c216b90f01b24b10ab08eb643d157bdd14da66d2129--

