Return-Path: <linux-kernel+bounces-69115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED578584CB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD44928471A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7CD1350E3;
	Fri, 16 Feb 2024 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvkKXLas"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AD71350D5;
	Fri, 16 Feb 2024 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106651; cv=none; b=Ul3kKtwm6Gtu1lOjYbUD6t77OAGLIYMoaMZJryPezTIKNy1B39faa5Fn2bogxmq+ww+Adzvp2MYjQEz46sT5FZiw5ZS50P+buBLjvmrTiP97AY90eQo7woGYL7MH71mhtRlXhgmASSqIIkHr1gsKZfZM7QAYEAGgmQbCEZC274s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106651; c=relaxed/simple;
	bh=4zAkwFBwhltmz4rki5uzbVVp2kIHfC3lppNg/ef2oWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOuPLKfF+sRbHiXirHfxpw5qKOZlAulk0A9F8JyXIxt7Do/stY0nGIv+EuHKRPmXipH7itadXUKa1OAA8NzAKWjXrA/09AxjFh/51TjASOZpwgp+9Av+quxOtUGN5k1UEiwOgaCxFozqyLZjByWqcLSQX2tQNnSURvnYAMWkS8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvkKXLas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69298C433F1;
	Fri, 16 Feb 2024 18:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708106651;
	bh=4zAkwFBwhltmz4rki5uzbVVp2kIHfC3lppNg/ef2oWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kvkKXLaspERoZLUmJ2GAqcBR63dKo2UQTuIIqNvBXjFHSMSZ7lF7RGFy5hsirkwOm
	 0/GrwZWwgrkNDIIjE+5lwxVCQ1epEohR1N+PCIGaMupLm++hKwRuSA5D1GmW4R3/w7
	 4DKCY4NIoRoIAOtjg12u/sDHyJ20lyFcq0Snwe/6sUYOdggh/KJDDe4MqhaUv8GiHG
	 nlbxLgUTtnA6+DAjrkoVMOKEJx1j1K9sCxp5n6ImHZDiABHqXzx76ohxEAfgCoQ5pP
	 RaVKxIO7N059zQSHEVe/mM00XqAWkB0uulSrjw1oQ1x0pTYfalg4reqJ39YGui342L
	 KjkbtGqDm+xoA==
Date: Fri, 16 Feb 2024 18:04:07 +0000
From: Conor Dooley <conor@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: arm64: mediatek: add Kontron
 3.5"-SBC-i1200
Message-ID: <20240216-unsettled-polygraph-e55f7f2dba90@spud>
References: <20240216163406.1050929-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GfQPB3jyAyI//zwd"
Content-Disposition: inline
In-Reply-To: <20240216163406.1050929-1-mwalle@kernel.org>


--GfQPB3jyAyI//zwd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 05:34:05PM +0100, Michael Walle wrote:
> Add the compatible string for the Kontron 3.5"-SBC-i1200 single board
> computer.
>=20
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docume=
ntation/devicetree/bindings/arm/mediatek.yaml
> index 09f9ffd3ff7b..32896f91ea38 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -357,6 +357,12 @@ properties:
>                - radxa,nio-12l
>            - const: mediatek,mt8395
>            - const: mediatek,mt8195
> +      - description: Kontron 3.5"-SBC-i1200
> +        items:
> +          - enum:
> +              - kontron,3-5-sbc-i1200

This is a specific SBC, why the enum?

> +          - const: mediatek,mt8395
> +          - const: mediatek,mt8195
>        - items:
>            - enum:
>                - mediatek,mt8516-pumpkin
> --=20
> 2.39.2
>=20

--GfQPB3jyAyI//zwd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc+jlwAKCRB4tDGHoIJi
0v0vAQD7OvJN5P3h8A9HqT3/JRs2VwVOUaNZR+gQQJVOUQzUwwD9F/fbds1vFdQs
K+oS3OF8Gtsl66sx2RY48OfHJTuTawY=
=a4sf
-----END PGP SIGNATURE-----

--GfQPB3jyAyI//zwd--

