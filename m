Return-Path: <linux-kernel+bounces-67442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F31856B98
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9050528B297
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A35513848A;
	Thu, 15 Feb 2024 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="An931f/1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762FF13667D;
	Thu, 15 Feb 2024 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019462; cv=none; b=JjUoQDqzhawL7QgGVCTaoVWI/CT+sjjtIJ2pRZLnFlrx5DtpJsgwjJrT9HgK4pIocFR/23ZZchTS1upJf1WQG+Okapn9M1XT85aR+KesvK3lWoc+/Zgih6iNr8Na2bEnEnjvsWpGf3VE++1HETJncuDG3PA1JBvEAsE50bJDg2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019462; c=relaxed/simple;
	bh=dpqcQEuKP3mHeIIAJ34hexRGvNtqvpRmFBgMCz2ZH5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSAPVuLNQTO/gJhu5K2GarMmXtye/rqTqqVLMKNcJjcaR0hb0l7M8/M4e1xhuhQGw5LIdAXHMEBSzY7jKGUN30Sju8ARlh2iSTuwzrES2JYYjebHzFh6zvTjcqtJQVd5dG9vIRbDAexQhVDaChC3o0dxS/mEwVMVgctTanRzSj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=An931f/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C96C433F1;
	Thu, 15 Feb 2024 17:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708019462;
	bh=dpqcQEuKP3mHeIIAJ34hexRGvNtqvpRmFBgMCz2ZH5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=An931f/1AQDPwWTVvh47+FjPNfzyvR9wLinhZJxYs0kdziP13Z8me8rWP5kX+YKNk
	 /gTlwm7DWqzmrWEzceOajWdq9SBCnyfoY5hms/YIkcvRPd7kKWm0OvkaF3dStKGB4q
	 0h+IKxGAAIPsDTyS7QvZfvFFKYbNsExyDqXPHkGePW9465LVbw9GG/ZwpKifc3UDfi
	 p+ETQp+k6V+y89FXpE5SeeovHv5GUvOg1vhhjM4WSwqzkpfMxVPhrK8TpMnbdHufw9
	 PdZ0M8WECWAhB1HO1oDsi4YfXVdnGNoSMHYS6hbgXrklN5kzQXy4CLGXSS99LcsExP
	 n3uMvHgi9lMxg==
Date: Thu, 15 Feb 2024 17:50:57 +0000
From: Conor Dooley <conor@kernel.org>
To: Bryant Mairs <bryant@mai.rs>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	luca@z3ntu.xyz, ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: qcom: Document
 samsung,milletwifi device
Message-ID: <20240215-stitch-respect-9073beb16a70@spud>
References: <20240215172617.115307-1-bryant@mai.rs>
 <20240215172617.115307-2-bryant@mai.rs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qH5FbCXFBQ9ocbjE"
Content-Disposition: inline
In-Reply-To: <20240215172617.115307-2-bryant@mai.rs>


--qH5FbCXFBQ9ocbjE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 06:19:48PM +0100, Bryant Mairs wrote:
> Add binding documentation for Samsung Galaxy Tab 4 8.0 Wi-Fi
> tablet which is based on Snapdragon 400 (apq8026) SoC.
>=20
> Signed-off-by: Bryant Mairs <bryant@mai.rs>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentat=
ion/devicetree/bindings/arm/qcom.yaml
> index 2b993b4c51dc..c11bb2a81643 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -104,6 +104,7 @@ properties:
>                - huawei,sturgeon
>                - lg,lenok
>                - samsung,matisse-wifi
> +              - samsung,milletwifi
>            - const: qcom,apq8026
> =20
>        - items:
> --=20
> 2.43.0
>=20

--qH5FbCXFBQ9ocbjE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc5PAQAKCRB4tDGHoIJi
0qpyAP0X0WZKt2zgAlS0u7K+dptT9RH+ibt0Pogr75dolPapYQEAx4eYm69jx3VK
jPe6ok7U4f3+2zoACma6ly7X3GE00wE=
=o+WJ
-----END PGP SIGNATURE-----

--qH5FbCXFBQ9ocbjE--

