Return-Path: <linux-kernel+bounces-43207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E548410DE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A381286225
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F58276C94;
	Mon, 29 Jan 2024 17:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCfLqCvL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE2976C6E;
	Mon, 29 Jan 2024 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706549860; cv=none; b=OyWXc4OboMcdHYelInvnvSuJKDcFmdASiS98pI98v53KhJoBlK32C6kb8x5deNpAmxyWEU1+fFSBSjjoY8iLoY7PGc+YxUPRKWFMGGZanFGgBnwbUEXi0GBBBRhoSsx2CEj4lxIsBtP2vrmuOIeyNxZfAXGoPPEV/bZz+MMS3QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706549860; c=relaxed/simple;
	bh=wWhOLdLXWR1J1NWYiGZwNuJQrSw+KC0GWCJmCtB76nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZR/EwD3J07wRxU9RDH7QaN2Q5rI1ubOOj8QiWGk3VX1bcKYYui1hjGc8FL0QnnNjlaNkXQH/uyUwTzZiTBiqQH/6t1bu9DDVJ5bF/LPB3Z47YFpdUX0M9FBHS7ceggZleDaC6WGY43hF5PAulFTL74Y5FRF98uuwZazAyhbhOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCfLqCvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0385BC433C7;
	Mon, 29 Jan 2024 17:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706549859;
	bh=wWhOLdLXWR1J1NWYiGZwNuJQrSw+KC0GWCJmCtB76nM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HCfLqCvLEn2f/rHk1ypJKgFsAPd5jmBc2bDnCVeJR1lxgrjULX/wI5r4ZUBE3kusZ
	 /ZjBWLjTpVzK12QvQaRnSiqKSQs41szRviG17dOAvJ2S/JpXODaMyzLbeXYFJ7G/qo
	 QZLUqntvH2OX9vLeXqUOFGMC9xZ2wdLd5YC2r8nYdMpnLFhBZzkW2f4Fm69HuqXYoO
	 2WWH4WaBUz6qkkJWa4rpwTfLxiW5yv0cWOK02mnJT28FsU5Ag6G3AHRzQS4TwgG/4I
	 rhUy/OXX5aQIB0rxZjUQL6xToHDrug8kK9Eej7Ghfa0H/wwyYCSGNlNLgwCPQ3o9+d
	 h7IlwIac7LuGw==
Date: Mon, 29 Jan 2024 17:37:33 +0000
From: Conor Dooley <conor@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dt-bindings: qcom,sc7280-venus: Allow one IOMMU
 entry
Message-ID: <20240129-numerate-brought-4660c2a89719@spud>
References: <20240129-sc7280-venus-bindings-v1-1-20a9ba194c60@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uIfXiQKiceuPgh4l"
Content-Disposition: inline
In-Reply-To: <20240129-sc7280-venus-bindings-v1-1-20a9ba194c60@fairphone.com>


--uIfXiQKiceuPgh4l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 08:48:54AM +0100, Luca Weiss wrote:
> Some SC7280-based boards crash when providing the "secure_non_pixel"
> context bank, so allow only one iommu in the bindings also.
>=20
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Do we have any idea why this happens? How is someone supposed to know
whether or not their system requires you to only provide one iommu?
Yes, a crash might be the obvious answer, but is there a way of knowing
without the crashes?

Cheers,
Conor.

> ---
> Reference:
> https://lore.kernel.org/linux-arm-msm/20231201-sc7280-venus-pas-v3-2-bc13=
2dc5fc30@fairphone.com/
> ---
>  Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/media/qcom,sc7280-venus.ya=
ml b/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
> index 8f9b6433aeb8..10c334e6b3dc 100644
> --- a/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
> @@ -43,6 +43,7 @@ properties:
>        - const: vcodec_bus
> =20
>    iommus:
> +    minItems: 1
>      maxItems: 2
> =20
>    interconnects:
>=20
> ---
> base-commit: 596764183be8ebb13352b281a442a1f1151c9b06
> change-id: 20240129-sc7280-venus-bindings-6e62a99620de
>=20
> Best regards,
> --=20
> Luca Weiss <luca.weiss@fairphone.com>
>=20

--uIfXiQKiceuPgh4l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbfiXQAKCRB4tDGHoIJi
0u+kAQD6hQJxEFZGeDrdCSNz807MgW2B9L9wp4d7nPT8zipYcQD+PHraEQhlwbax
l6JDJfuJlD+YZfuAGqEETe5slN7CuA8=
=uaeV
-----END PGP SIGNATURE-----

--uIfXiQKiceuPgh4l--

