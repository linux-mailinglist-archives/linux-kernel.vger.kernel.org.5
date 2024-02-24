Return-Path: <linux-kernel+bounces-79826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8F686273C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 076EB284E8A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0328A4CDFB;
	Sat, 24 Feb 2024 20:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLaoaovN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A482907;
	Sat, 24 Feb 2024 20:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708805156; cv=none; b=XG7QWOszfuHmdDY2FTYv/CV4uedRXMh6M4c5LmezFum+VGr9YaOkhbdXHvGNSmnD2neVqwyH2yMPFMsxteCITWIO+2ErUkBXIRe7O3lTN1bKNZQcH89JUhUJBQ2e8pA0WnvELnQ1F7lQ31vAUmHL6WFlxGcMEo5HwFRakxhrto4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708805156; c=relaxed/simple;
	bh=VVconFov6r58LkpENTvrOORG9jm8Kbr70JfM/2Cn400=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmUNQQpxRxRNzTv3M9t4EKRZqMhw9Ljc1yN3xO/Gxl5rtglybKMyulRAjXVo8Lg7b8Nx2eNvjfdvF0aMjqVsNZkEAcVj46Guo9DFarWpinaF3k4+5ketWCdWRd5V07TqaooF7m9TS9KJ1tIgcNYnixMHPimu1pMAYvXWBwh7CyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLaoaovN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADAFC433F1;
	Sat, 24 Feb 2024 20:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708805155;
	bh=VVconFov6r58LkpENTvrOORG9jm8Kbr70JfM/2Cn400=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SLaoaovNXKUTSsxYBUgHNut8hVCCfzputtDm/gpygPrfTPJm8FuHZBj61UBkJIW12
	 90TYHeBju39F35cqBrQFPy6vySRRKJTtcPZJwzjOe2RxJw9SD2p3ROifYB6k7UE/h5
	 xwxeF+ev7DF3HS0Vf/U8mEtNVu4oUG/HWgenWkOpdzM0pQvf5FX3v8CAc+ojAiF/OK
	 pA9OOu5IrBXZ1xy3ms2MkXKdVC8vy5UZw5TKr8r0LIXlyIYYRod31jzXvv5cGnzmoW
	 lFmajO2lCcwvPCLs/Nw6nU68GV7uZq2l7s2/MaKoHtgS1Q+QG+SrzRY5xAA6hLYc7M
	 cShERKkqiaSRw==
Date: Sat, 24 Feb 2024 20:05:51 +0000
From: Conor Dooley <conor@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 21/39] dt-bindings: clk: at91: add sam9x7
Message-ID: <20240224-procreate-tumble-52241e198587@spud>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172732.672645-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7iwFKyEFd0qR+fSs"
Content-Disposition: inline
In-Reply-To: <20240223172732.672645-1-varshini.rajendran@microchip.com>


--7iwFKyEFd0qR+fSs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 10:57:32PM +0530, Varshini Rajendran wrote:
> Add bindings for SAM9X7's slow clock controller.
>=20
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
> Changes in v4:
> - Added sam9x7 compatible as an enum with sama7g5 compatible as per the
>   review comment
> ---
>  .../devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml      | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sck=
c.yaml b/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
> index 7be29877e6d2..ab81f0b55ad5 100644
> --- a/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
> +++ b/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
> @@ -18,7 +18,9 @@ properties:
>            - atmel,sama5d4-sckc
>            - microchip,sam9x60-sckc
>        - items:
> -          - const: microchip,sama7g5-sckc
> +          - enum:
> +              - microchip,sama7g5-sckc
> +              - microchip,sam9x7-sckc
>            - const: microchip,sam9x60-sckc
> =20
>    reg:
> --=20
> 2.25.1
>=20

--7iwFKyEFd0qR+fSs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdpMHgAKCRB4tDGHoIJi
0l7/AQDdwpKKmLnJf+PrnNwytMtigguNvjqPw9Msr0NSj2oOBwD+Lfrrc7b+bs7l
HixHFhWu4FXSXzUoEpxXElCWUfIQuQM=
=x3MZ
-----END PGP SIGNATURE-----

--7iwFKyEFd0qR+fSs--

