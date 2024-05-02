Return-Path: <linux-kernel+bounces-166597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265FC8B9CD0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68FC287F5E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEBE153BFA;
	Thu,  2 May 2024 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gl9hi2+e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA05168AE3;
	Thu,  2 May 2024 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661232; cv=none; b=RQ2xdqD+WThB9X5fjT1NyUfL6T13cuF05LWuIwxUN40WCqQB6ElRdggmwwjR0jJUbSPDjJqTGK+dwhCmyo2CQSaYVd5EPOphVF0VoZ5Nxda9JqKt0VJ6O1NSZFI/op6lVTb7yry6+8qT7YY8tCTp9HSr9ilVeK6lGm8PdpvP77Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661232; c=relaxed/simple;
	bh=y2u5f1oLItJctxgAjcS4FjLpG55+1RDUaMcyi4F1aXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTFMa+ZWC7qHrWer6eNr4H+aTLWHnvYZ++q1blJDytKmM/BXfbV4s9iFNKniiWnPnt1aedBMvPzaTEd5TixeaDSEPFfhCKi6ZaUYvDRPZjFn8O+7As5wjmTV8J1IH4OIud0kFm/gXKJZ4Fctzqtbp5/q6DThILTN0yiyE9DzHAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gl9hi2+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82927C4AF52;
	Thu,  2 May 2024 14:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714661232;
	bh=y2u5f1oLItJctxgAjcS4FjLpG55+1RDUaMcyi4F1aXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gl9hi2+ep47qhlCNVTn6ohOxbSroz6nK01LlIZBnI2QZ9ydzGObDkNdpG6MzQ7dKk
	 taPz00sZSwMMla58IgruhJd2ka4duylPaHynYr18/gkWH1TW3Sf7NNdDNH9wTS15uM
	 7ATFQcatEXiEp4K5FKQwH/scHIC29lm4uP1nKOxmgGrD57QHKQMhXLfY0CjY5GZSOC
	 n4RReNUxq14RkXiPJTJAY00qp1/x+MB1W0g3n1CfCQIJRHimXsgPrljqrmvThRmCIM
	 E4vrgduR50OxOizLbhgvaYH4eL/L10UXQuTWRx4/sSYp01l2H5Gcc5UBz3lerkRg/z
	 Yh8B/E5njqp2w==
Date: Thu, 2 May 2024 15:47:06 +0100
From: Conor Dooley <conor@kernel.org>
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: drm/bridge: anx7625: Add a perporty to
 change TDM setting
Message-ID: <20240502-sheath-share-eac9afc24da9@spud>
References: <20240502-anx-tdm-v1-0-894a9f634f44@chromium.org>
 <20240502-anx-tdm-v1-1-894a9f634f44@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8/5nJfSkNtzWjt3N"
Content-Disposition: inline
In-Reply-To: <20240502-anx-tdm-v1-1-894a9f634f44@chromium.org>


--8/5nJfSkNtzWjt3N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2024 at 09:03:31AM +0000, Hsin-Te Yuan wrote:
> Add a perporty to indicate whether anx7625 should shift the first audio
> data bit. The default TDM setting is to shift the first audio data bit.
>=20
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
>  .../devicetree/bindings/display/bridge/analogix,anx7625.yaml          | =
4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,an=
x7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7=
625.yaml
> index a1ed1004651b9..915d5d54a2160 100644
> --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.y=
aml
> +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.y=
aml
> @@ -82,6 +82,10 @@ properties:
>      type: boolean
>      description: let the driver enable audio HDMI codec function or not.
> =20
> +  no-shift-audio-data:
> +    type: boolean
> +    description: Disable the first audio data bit shift in the TDM setti=
ngs.

This just looks like software policy, since there's no mention in the
commit message or description as to what property of the hardware causes
this to be required. Can you please explain why this property is needed?

You're also missing a vendor prefix.

Thanks,
Conor.

> +
>    aux-bus:
>      $ref: /schemas/display/dp-aux-bus.yaml#
> =20
>=20
> --=20
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>=20

--8/5nJfSkNtzWjt3N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjOnagAKCRB4tDGHoIJi
0ln0AP9DyApFCoVvS4YZh4Z7BXzH/YTUbAbf7PTbHgDz4cGL9QEA+ljG5oEiafmA
RaxNUDoXgKTJ7j2W3ct+VICnrpiK+AQ=
=XNgZ
-----END PGP SIGNATURE-----

--8/5nJfSkNtzWjt3N--

