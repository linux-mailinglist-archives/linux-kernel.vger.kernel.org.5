Return-Path: <linux-kernel+bounces-130177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DB08974F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026861F2290F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DF714EC7C;
	Wed,  3 Apr 2024 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+LnZsIa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795A914D433;
	Wed,  3 Apr 2024 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160895; cv=none; b=CMeKmWubor/TFTUeyQPhTTTlSupRw9TRY9ns68CLg/Lh6yAB7+buTFaqfld1N9Gj7deCLCMNMLjQq4UoWm5T8QQlEJCjMHgOeit1u9DDEqq35HW/p1tG5H0BbXnlqOJPUDvDtXP36f24AWRsPcXU25cQKfgUAyyOg5wxNCb4pIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160895; c=relaxed/simple;
	bh=Dw4TMcgMCYmhY8DkUmtF9XK+klTwM7RxE/GPJ5ycJF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2ku/qIfqaKY1E6dMhrNgD/EYFks25O20WFI1dIAPUWL4D4/hidTC5E4m2fsYTbxcnngYG/qeerJQ0vh2J5pmbBRCfAeAx9uSCtqP8uXvL0APVvfaTCGzjN3ceFq98313xahJazfYI61xgfcbC7DvLc17sIcXTeOjzU5BpD3DjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+LnZsIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B015DC433F1;
	Wed,  3 Apr 2024 16:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712160895;
	bh=Dw4TMcgMCYmhY8DkUmtF9XK+klTwM7RxE/GPJ5ycJF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q+LnZsIa2JGGoV12cX3ZMFQhd29l75NesZeX4wzM5ZgtWKEXLDNztOOzWr/GFhev1
	 tE1H+SaIbAdpnugrYIgh6WzbcOp6E++9hG5TeVmT08B589T+ncsXxX68JxxZ80XJIT
	 qAym+sr7rBOxZWGcWmPQPZXd1+F+lodeNob5iXBbn2aLh3XHAY/Mc6nLnnN9RSmFWD
	 dSocGzn7mou1RMW/gV5GCp3DPFDxCi4EO5Y9QU50YdMEu4XHD4Lll9+xBJBA4jurGO
	 ocpL8tD168CUWyUqz7acBtK5wIm2oe/mOcVoypANl6/J4V6Fk0Q6RJpl0wVl8HiSA+
	 fdh54vM0/5inA==
Date: Wed, 3 Apr 2024 17:14:49 +0100
From: Conor Dooley <conor@kernel.org>
To: git@luigi311.com
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pavel@ucw.cz, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 18/25] dt-bindings: media: imx258: Add alternate
 compatible strings
Message-ID: <20240403-vista-defendant-ebadbaa52059@spud>
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-19-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dTboEyzG/5e2UTpE"
Content-Disposition: inline
In-Reply-To: <20240403150355.189229-19-git@luigi311.com>


--dTboEyzG/5e2UTpE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 09:03:47AM -0600, git@luigi311.com wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
>=20
> There are a number of variants of the imx258 modules that can not
> be differentiated at runtime, so add compatible strings for the
> PDAF variant.
>=20
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Luis Garcia <git@luigi311.com>
> ---
>  .../devicetree/bindings/media/i2c/sony,imx258.yaml       | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml=
 b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> index bee61a443b23..c978abc0cdb3 100644
> --- a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> @@ -13,11 +13,16 @@ description: |-
>    IMX258 is a diagonal 5.867mm (Type 1/3.06) 13 Mega-pixel CMOS active p=
ixel
>    type stacked image sensor with a square pixel array of size 4208 x 312=
0. It
>    is programmable through I2C interface.  Image data is sent through MIPI
> -  CSI-2.
> +  CSI-2. The sensor exists in two different models, a standard variant
> +  (IMX258) and a variant with phase detection autofocus (IMX258-PDAF).
> +  The camera module does not expose the model through registers, so the
> +  exact model needs to be specified.
> =20
>  properties:
>    compatible:
> -    const: sony,imx258
> +    enum:
> +      - sony,imx258
> +      - sony,imx258-pdaf

Does the pdaf variant support all of the features/is it register
compatible with the regular variant? If it is, the regular variant
should be a fallback compatible.

Cheers,
Conor.

--dTboEyzG/5e2UTpE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZg2AeQAKCRB4tDGHoIJi
0g9GAP9MN2G2glo0Nhr4UByr3u4eG2VrUcxCMe2B4Uzd1ErwTQEA7j5t7hgUL0mU
pr1/uez8k5GMNQNEpwMErPYIlusOjw8=
=KKOZ
-----END PGP SIGNATURE-----

--dTboEyzG/5e2UTpE--

