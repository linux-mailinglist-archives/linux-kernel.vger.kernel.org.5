Return-Path: <linux-kernel+bounces-79821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF4A86272F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6AAE1F21849
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79EB4CDEB;
	Sat, 24 Feb 2024 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4EJfrEu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1596C4D107;
	Sat, 24 Feb 2024 20:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708804953; cv=none; b=Fcm80jeLhCNw4Ntg+P8byEf/9XxTvut8SlFPPB7zstdS/omH9K9x38GwE7m31kATuHU3i06iKrl88eDrfN2pOR52G/xs948b8yI0a242XMjmDyk8zM4exC2jIhPe1B2ibTDd8V5feNrs/2Obf1w1zNuRuLNeuQyKz69iFVW8m88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708804953; c=relaxed/simple;
	bh=tpvjkEKYJLAWc8r/kFlJlpJPF2ji+9TFnmJFk47EZlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3+O4VicqeRWTlyqgRXx0BKFu6Cfl14jOWuTuWFBOAnEp1/817tscmWZm37lXewsE6DVDy+6FFP8p6LyWG/5d6nlT9qsY969iy5MHWRXCae0iu4pOluNcP0k06uzDGPbeB0bC8nWRPABffzM5ULgue0wNJUDyWvsUhFYe6lkgo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4EJfrEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476DFC433F1;
	Sat, 24 Feb 2024 20:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708804952;
	bh=tpvjkEKYJLAWc8r/kFlJlpJPF2ji+9TFnmJFk47EZlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M4EJfrEukmXbwH6vbe4k1OZ9uAkIti2PK99vA7IODObK94M/+dWtj7ewfRKkVCzBe
	 C07PLANm15udqZOyj0fM2A+5/64AqnNp3y7OEZ3m3qx2LWwmuSym2P3mmbLbMCEoKW
	 ZkeTkEvJD+E0tqJ7Gei3Ggez2ugzAV+DBBYd++cVQBzLxvTkNqUIGzbRdGOQ571d/l
	 K2ZCQTYsYFh6ibAlxc+Gnr56XzXoeytPVFeMjE8PDfI0+iAV7a/LICTWNMVF0McfNw
	 LpwUA2ZTyv3N3EV5tpPt4xQ8FJJcAUG9iSwZPjoDy2T18+4IVkB1Mr/mckTL/hvbzv
	 vljH/6Y+VYOZA==
Date: Sat, 24 Feb 2024 20:02:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 12/39] dt-bindings: serial: atmel,at91-usart: add
 compatible for sam9x7.
Message-ID: <20240224-kimono-stress-898eae80abd3@spud>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172559.672142-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8c64jTTjW0j3INUS"
Content-Disposition: inline
In-Reply-To: <20240223172559.672142-1-varshini.rajendran@microchip.com>


--8c64jTTjW0j3INUS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 10:55:59PM +0530, Varshini Rajendran wrote:
> Add sam9x7 compatible to DT bindings documentation.
>=20
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
> Changes in v4:
> - Fixed the wrong addition of compatible
> - Added further compatibles that are possible correct (as per DT)
> ---
>  .../devicetree/bindings/serial/atmel,at91-usart.yaml | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.ya=
ml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> index 65cb2e5c5eee..30af537e8e81 100644
> --- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> +++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> @@ -23,11 +23,17 @@ properties:
>            - const: atmel,at91sam9260-dbgu
>            - const: atmel,at91sam9260-usart
>        - items:
> -          - const: microchip,sam9x60-usart
> +          - enum:
> +              - microchip,sam9x60-usart
> +              - microchip,sam9x7-usart
>            - const: atmel,at91sam9260-usart
>        - items:
> -          - const: microchip,sam9x60-dbgu
> -          - const: microchip,sam9x60-usart
> +          - enum:
> +              - microchip,sam9x60-dbgu
> +              - microchip,sam9x7-dbgu

> +          - enum:
> +              - microchip,sam9x60-usart
> +              - microchip,sam9x7-usart

This doesn't make sense - this enum should be a const.
I don't really understand the idea behind of the original binding here that
allowed:
"microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbg=
u", "atmel,at91sam9260-usart"

Specifically, I don't get the purpose of the "microchip,sam9x60-usart".
Either make it
      - items:
          - enum:
              - microchip,sam9x60-dbgu
              - microchip,sam9x7-dbgu
          - const: microchip,sam9x60-usart
          - const: atmel,at91sam9260-dbgu
          - const: atmel,at91sam9260-usart
or add
      - items:
          - const: microchip,sam9x60-dbgu
          - const: atmel,at91sam9260-dbgu
          - const: atmel,at91sam9260-usart
or explain exactly why this needs to be
"chipa-dgbu", "chipa-usart", "chipb-dbgu", "chipb-dbgu"

Thanks,
Conor.


--8c64jTTjW0j3INUS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdpLUgAKCRB4tDGHoIJi
0gcuAPwKJcQi8VunTtf+c2HxMwJnzd/VcSM1qfFZR7t6Y2RTxwD/UV6+lcP8ArXQ
HqrqN+g0Ua0mQyRSLJa+cfksxbl88wY=
=PXng
-----END PGP SIGNATURE-----

--8c64jTTjW0j3INUS--

