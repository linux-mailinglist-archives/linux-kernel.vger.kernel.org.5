Return-Path: <linux-kernel+bounces-79814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E82A862720
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 194E4282C46
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0291A4CB41;
	Sat, 24 Feb 2024 19:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0PyI7E+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EE53F8FF;
	Sat, 24 Feb 2024 19:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708804260; cv=none; b=kJaEf2LKvJcNzn45IPQl6/iv7XHTroRWmgZY58rWxzZHvfuLyyn2Ig9qikKf3F64wcwjKk7yKMIR/Aep+U31o0zVjARJkzlMed8wZruO3zcWTNXf5MGQGXlvWG11DCfTriPTX867v979HT2Nc/pt0iWkdS76NNRggeDVykl2vwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708804260; c=relaxed/simple;
	bh=c+R74h3fQSp0t22NPjb+YRPWdwV9TUzr8d5YF9e/LyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXg7r6kDiysffJOgCiojIxrzFRUjVIqcqht58aP+3dLJLwAgV7LzOkMIb0PNef+l6OgxEHL6NkWOk2w5DGdO2DD0DKBowUkMYTw6z1mI7XSj/W2xVbSkq4px1+wj2uSNMYiceW3T5iV9XgNLYQusfcW+hWin+4VUncXXIeCnQ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0PyI7E+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E698C433C7;
	Sat, 24 Feb 2024 19:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708804260;
	bh=c+R74h3fQSp0t22NPjb+YRPWdwV9TUzr8d5YF9e/LyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F0PyI7E+BZwWRHrs8HzkPrS5kX0T/qb8zclPbkIBSFygX+9LqS/LYqC4h61aIXk6V
	 cyhEgYplgpmzxbS5n4RCB1e/3xc4JMuO11zbWqzLaSHCZhb8jPrlxYrdpI80tZgPul
	 78v4Maq0qwhvdayXO6C3D3/NLANskFY3uEQBu9CWWQnApiccLM7RVy+h76wW//iHyA
	 OvTh/r2UUc7cAJbS0C/sWV151JiGkRIgSu3mL3cB9F2gguGThBSkmoUamcaz+cNkze
	 r5vxTFxUqCDaabbtQBN/HJv/VurT+oXt2Ue9nsyrf/xpAxK54+Cm86MHzHchE4IhsU
	 jEbuUeg3q0QyQ==
Date: Sat, 24 Feb 2024 19:50:54 +0000
From: Conor Dooley <conor@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: tudor.ambarus@linaro.org, miquel.raynal@bootlin.com, richard@nod.at,
	vigneshr@ti.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/39] dt-bindings: atmel-nand: add
 microchip,sam9x7-pmecc
Message-ID: <20240224-doorknob-shrubs-ca14a595fc21@spud>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172520.671940-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UgdQRHjwd+VMErNW"
Content-Disposition: inline
In-Reply-To: <20240223172520.671940-1-varshini.rajendran@microchip.com>


--UgdQRHjwd+VMErNW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 10:55:20PM +0530, Varshini Rajendran wrote:
> Add microchip,sam9x7-pmecc to DT bindings documentation.
>=20
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/mtd/atmel-nand.txt | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Docum=
entation/devicetree/bindings/mtd/atmel-nand.txt
> index 50645828ac20..4598930851d9 100644
> --- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> @@ -56,6 +56,7 @@ Required properties:
>  	"atmel,sama5d4-pmecc"
>  	"atmel,sama5d2-pmecc"
>  	"microchip,sam9x60-pmecc"
> +	"microchip,sam9x7-pmecc", "atmel,at91sam9g45-pmecc"
>  - reg: should contain 2 register ranges. The first one is pointing to th=
e PMECC
>         block, and the second one to the PMECC_ERRLOC block.
> =20
> --=20
> 2.25.1
>=20

--UgdQRHjwd+VMErNW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdpIngAKCRB4tDGHoIJi
0gAXAPjsa4IFqKMWYB3KmESjebgH/eC1spT80i6dCT/5gk4GAP4rMhPt5KVhUaB9
lngbJHwvw7BKAvJ9BQj4y5TQgwr0Aw==
=XyGE
-----END PGP SIGNATURE-----

--UgdQRHjwd+VMErNW--

