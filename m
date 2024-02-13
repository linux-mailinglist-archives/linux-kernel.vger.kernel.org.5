Return-Path: <linux-kernel+bounces-64067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920468539BD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3F2DB280E8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61558605CA;
	Tue, 13 Feb 2024 18:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad5JWAs5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9543A5FB8E;
	Tue, 13 Feb 2024 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848321; cv=none; b=C/G0SmK8P5+ilMtPU3VQTKPQkBl1pRsCm1mSf9rR90HDaj6ipp4AhhDK5iPjIMG3uBzlUSsbSI6OOan5Y0i8PUdPegrSOZxxS1O9ql3QLKFcD/JGMVZ9hkF48Qss9hNWqeyCY5K43E2rB9Ue3KITyaSfM4GIhwrQxMOh1LtZ8pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848321; c=relaxed/simple;
	bh=SXLQ1pLcws2l0Xu0viSOaOO/O0DM9PSjTl8YaFye7O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBErasOwtnWqvRNRlOjRtg8ARI2b3TRBi2BcKQkg+3W5gHLeqmC1qmDQpEkqlU0pXSVCBcwhWI9VIY/YBIzzLc8m3cz32QCQy8ICk+Md62sLmeDI1Gv0+ElaN7qvRaqFTqZpC0bYJe/c3lqQ7oRcnRiZv2+xkZ+hEfMvVO7z7jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad5JWAs5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B2BC433C7;
	Tue, 13 Feb 2024 18:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707848321;
	bh=SXLQ1pLcws2l0Xu0viSOaOO/O0DM9PSjTl8YaFye7O4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ad5JWAs5XvKh8//hxsQfl8sVNqHO31XPsh+ZF8+QSExCv6zGXvJzPT5IGPP9aRFeN
	 0wjW8TZGBHZCHFSEVjr6P8iE+daTR0e8NnAluUKjvAT4adPufiTasPE+Uqdv0lbw8U
	 d6gwYaWj1W00LAzE8ntx72wAfwn62hcHengKnCpS49gz2Jgy/IndIVhyMO7XFGq9E/
	 xH6t91BnSH9I/tMgtoNLiYl8bA45jzuKULGxgMrEU/u/xgJ2WIkh9kB3oeLT22VJn6
	 nvL6jqxyg6zvs4HTDRKb359KCTZEDNx4bYMNjFKRFU2MVTB0LH3kjxak2fyFPFRzae
	 12mz6EtEUxCiw==
Date: Tue, 13 Feb 2024 18:18:36 +0000
From: Conor Dooley <conor@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: mediatek,mt2712: add compatible
 for MT7988
Message-ID: <20240213-resource-evaluator-0754cfd5882d@spud>
References: <20240213164633.25447-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IwSpqDfDVNcc7RLA"
Content-Disposition: inline
In-Reply-To: <20240213164633.25447-1-zajec5@gmail.com>


--IwSpqDfDVNcc7RLA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 05:46:32PM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> MT7988 has on-SoC controller that can control up to 8 PWMs.

I see a binding and a dts patch, but no driver patch, how come?

Also, what makes this incompatibly different with the other devices in
the binding, like the 8183?

Cheers,
Conor.

>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> ---
>  Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.ya=
ml b/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
> index 0fbe8a6469eb..a5c308801619 100644
> --- a/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
> @@ -24,6 +24,7 @@ properties:
>            - mediatek,mt7629-pwm
>            - mediatek,mt7981-pwm
>            - mediatek,mt7986-pwm
> +          - mediatek,mt7988-pwm
>            - mediatek,mt8183-pwm
>            - mediatek,mt8365-pwm
>            - mediatek,mt8516-pwm
> --=20
> 2.35.3
>=20

--IwSpqDfDVNcc7RLA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcuyewAKCRB4tDGHoIJi
0uxEAQDGsfDNcKZx9Z0a6eodrNyCrahRr5IkdabX4h7AqUDWPAEA17xUt82LhKde
tA7TZ/ft3fpvv0XodKAVGbutj7bELQA=
=znwI
-----END PGP SIGNATURE-----

--IwSpqDfDVNcc7RLA--

