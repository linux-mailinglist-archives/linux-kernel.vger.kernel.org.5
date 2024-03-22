Return-Path: <linux-kernel+bounces-111891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333C2887240
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EAB5282661
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C1B60BAA;
	Fri, 22 Mar 2024 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8l4kkl8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAC060B92;
	Fri, 22 Mar 2024 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130106; cv=none; b=Lmm0ZORFs/eRk2LOKh0DCSjqfOtlw0+Issv0YScJTxg/YoN1l1Etg/4fvLJZEYTn7HeinpAiXk5GkPDQjQMN50PGeaLDE3XmnoP0Vdb0OyrSk3oBBt/Mi5KnXEhAeF2wU7moC2gpaoQnc3aQXBU+40YES2+s5N2bCK+HzCq/zv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130106; c=relaxed/simple;
	bh=SdA10GSjVQNqqmFuTSnxiUAhaxT2iu+4G7rjXFP4CWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjYgPECzseXce3r9d3pQgCf1VyT+BoPRCd9bPJkbd2ObcMv0WfMbEY+ST5e8CruXGb+6qu5qsIbdp80B5bAHwQ8LPi60QR2Pf2qU+tQJ4IHbBeppGwWAA98HR5pshXXUTB7ryCWaZ7Bfp3Rg+mgquwRcg9fit7+gdkNZboBwG/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8l4kkl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFC9C433A6;
	Fri, 22 Mar 2024 17:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711130106;
	bh=SdA10GSjVQNqqmFuTSnxiUAhaxT2iu+4G7rjXFP4CWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M8l4kkl8LWW6mvudC3pVWyDm3Nfppb8REzKBQpQLI3Rg5BDVjqsEJq4JYt736MyqH
	 PKvXY9tr5g5fT1yodFt0D+wrcqZoSPUzQRgkc5H8Ni5TOgqAPs5WnvpNEhK/ITHSHh
	 l27uAfyeVRKdZb0Th15DJZfFh9hMwbgdc465BBaFCNPaCQ68WGe0qzfdXrOzBBaWka
	 YgHtClWc2rfBomVWRz4DWGpWYfp0iofB9veCM3pcMIEdf2H0093d7gv/+OnG0yR5bK
	 GjqM4AwscZXS+3xOj5dBCDgGW1WWwB8GNsanWY8LYauYN3sY3PoLx3WwQ2LZqZiP8C
	 pFCFPDETVP1UA==
Date: Fri, 22 Mar 2024 17:55:01 +0000
From: Conor Dooley <conor@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: usb: qcom,pmic-typec: Add support for
 the PM7250B PMIC
Message-ID: <20240322-precise-snazzy-a6f1decd1b9e@spud>
References: <20240322-fp4-tcpm-v1-0-c5644099d57b@fairphone.com>
 <20240322-fp4-tcpm-v1-2-c5644099d57b@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MLqEUximXdvM3c2M"
Content-Disposition: inline
In-Reply-To: <20240322-fp4-tcpm-v1-2-c5644099d57b@fairphone.com>


--MLqEUximXdvM3c2M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 09:01:33AM +0100, Luca Weiss wrote:
> The PM6150 PMIC has the same Type-C register block as the PM8150B.
> Define corresponding compatible string, having the qcom,pm8150b-vbus-reg
> as a fallback.
>=20
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml b=
/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
> index d9694570c419..0cdc60b76fbd 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
> +++ b/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
> @@ -21,6 +21,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,pm6150-typec
> +              - qcom,pm7250b-typec
>            - const: qcom,pm8150b-typec
>        - items:
>            - enum:
>=20
> --=20
> 2.44.0
>=20

--MLqEUximXdvM3c2M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZf3F9QAKCRB4tDGHoIJi
0rPOAPwMxzOCDjBFz3sxD1SVujrMjWf8oOtiURMB7A610DmvlwD9FohXIqp01uic
ykS083bSkVYLQUJ3qpYyVT8+yF2hkAg=
=Nv79
-----END PGP SIGNATURE-----

--MLqEUximXdvM3c2M--

