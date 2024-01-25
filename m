Return-Path: <linux-kernel+bounces-39022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104EA83C9C2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4652849D2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6FC13399E;
	Thu, 25 Jan 2024 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bU1YdkO+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84546481CB;
	Thu, 25 Jan 2024 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706203079; cv=none; b=SE682JNk6V7BiLDy0K8Jcss2xrWL9NvSNVUHQ+EzOtTOAfc87Dsin7dfcu7Ldr7wtlWFUdNYvscb3cRrURBTvzg5bybs4adegPFTq3RCADyywjeEDCzK8iS2m9rRNyPBJCoc21n7ie865ekVlcj6IeAQUhhkDLyOTOnkUynOJyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706203079; c=relaxed/simple;
	bh=PGjwh8WrgD8mpDJNmLuY2zwV1TrvwjWGmGaOhxyBsGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvfMQDYIUIYUvgVzJ4ZGkCXQUUCWBzZv4jJmiWQTdT+AOH1lwjjT8VBE/GVb4j1sUMWHj8RFphW4TQ7+THU+aowOhXn3s8C+tyqbUVpZjdTxEwG8ZgRxuv5GW0Hx6aswqbTDRuAd5VBXkDDsoBM5AMR5493YgaoXFNwklYRiVTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bU1YdkO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1682C43390;
	Thu, 25 Jan 2024 17:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706203079;
	bh=PGjwh8WrgD8mpDJNmLuY2zwV1TrvwjWGmGaOhxyBsGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bU1YdkO+++AKRPkpGE4N7f61XbNLnIpJp00g3YmhwMWb1lvN1BmQbk4hvm8sx3kVs
	 tDb2Q750OJWsa9QhxUfxXmFrLP8eE7wB0064lmD4ajne1TQw0M6r0F8u+ZkK/px3E6
	 Mpzje3TuiI4sPCJ7TBufJzl/By9OhH+CDVENz1tsBuxsb4r5Z4FWfadgenhtNY+Sef
	 ZdvRDeEn6BVqLKL1KhGczXHv9pIY3TvQZEi1rOaRV07APa8Lly+hU3cbo+KTDl6vRQ
	 yLFYQB2fSNo2GtZVghsMdh48Db2DS5cpzMGIjtnGRyMd3Qo7CWStu/C3PxsWorKcbp
	 bd8h7zsQRncGQ==
Date: Thu, 25 Jan 2024 17:17:53 +0000
From: Conor Dooley <conor@kernel.org>
To: Mantas Pucka <mantas@8devices.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: thermal: qcom-tsens: add IPQ6018
 compatible
Message-ID: <20240125-hazily-scorpion-7047dfd08f7c@spud>
References: <1706173452-1017-1-git-send-email-mantas@8devices.com>
 <1706173452-1017-2-git-send-email-mantas@8devices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wn8f/nru8b2mI6oI"
Content-Disposition: inline
In-Reply-To: <1706173452-1017-2-git-send-email-mantas@8devices.com>


--wn8f/nru8b2mI6oI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 11:04:10AM +0200, Mantas Pucka wrote:
> IPQ6018 has tsens HW block compatible with IPQ8074.
>=20
> Signed-off-by: Mantas Pucka <mantas@8devices.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/=
Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 99d9c526c0b6..d6f333a7bcd1 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -76,6 +76,7 @@ properties:
>        - description: v2 of TSENS with combined interrupt
>          items:
>            - enum:
> +              - qcom,ipq6018-tsens
>                - qcom,ipq9574-tsens
>            - const: qcom,ipq8074-tsens
> =20
> --=20
> 2.7.4
>=20

--wn8f/nru8b2mI6oI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbKXwQAKCRB4tDGHoIJi
0iOIAQCdQoZ/kwj/HEaWawVaxBFvf1repCb5Fn7Vs8hxvEsOowEAzwRGYfFjhkzl
ZFTOTNvJfVytRXRnzi6g6l4Qm2V8bw0=
=KlOy
-----END PGP SIGNATURE-----

--wn8f/nru8b2mI6oI--

