Return-Path: <linux-kernel+bounces-111893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AA388724E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538861C22BFD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD4E60B80;
	Fri, 22 Mar 2024 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXHJRrgE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF8260898;
	Fri, 22 Mar 2024 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130130; cv=none; b=AD4Fg+wkaKtaBflsfWgP9+I+uTgePzTWjbiIBi+A/yEoHYjxBfl0NrDVp7CraFdb058kPe6/y5hS+okWmIZU19g7vJtahlUpjd7FVXnlGFKR6Yvtx7Dx4LI9Y8jEYWR1h3gLesWRgkrT0zf5zV6lDap+n74V5T1GZb+Bq94QlPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130130; c=relaxed/simple;
	bh=IatL3AnQ1sBWIjVS3yyegSKCpECgw5Uocz0/m+B0+pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpZoLyTr6zTyCfo5lcOc9lw2us00STD3NLm+6XVyPNMIBRMW5kIRvC6JNdFy4gT3vrVuUm6BlKShyWSL8Wr/qxXX+3GV7sdAztXNcWKXt2i2xiPfSz3uDOTnMdxyPxrPfxWKD07yZfTKquwuVwunAakEUu6+HpUeg594eJ0WUFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXHJRrgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7D3C433C7;
	Fri, 22 Mar 2024 17:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711130129;
	bh=IatL3AnQ1sBWIjVS3yyegSKCpECgw5Uocz0/m+B0+pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RXHJRrgEJLOCeZhgwemuP6xrjBHYm2239sO30SiCsL3RIHc7pHbM66Av+16ot42fn
	 i0331hL6gzDQZ6PcwlOzFPzqLpxK7t9S1JlDKJSNLVeqpjND0VjKA7MqmLzBZ3f58D
	 Wymu905/jKYV6TR7fi/ruOdnfcN5YLKTI6Rl7GX1Hk4PQOWK6E1oEzxq98mtoDQrda
	 7z6ve/70lFzQX9huMiCr/h3EHNwpFHbxCKBfGQ1CXm67ocZQ66urc3cq31FGuSw3CB
	 ECNQcTR4SZ5+EJDTgFc6YSWD+2Deg6aL/mE0/4k8/nKL7gxoAZ0MHoZdrbpAlWBDX6
	 3tBPQO4XMeYSA==
Date: Fri, 22 Mar 2024 17:55:24 +0000
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
Subject: Re: [PATCH 1/5] dt-bindings: regulator: qcom,usb-vbus-regulator: Add
 PM7250B compatible
Message-ID: <20240322-front-rekindle-20f15e9841bd@spud>
References: <20240322-fp4-tcpm-v1-0-c5644099d57b@fairphone.com>
 <20240322-fp4-tcpm-v1-1-c5644099d57b@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zrO6/TpLSL1IE1BD"
Content-Disposition: inline
In-Reply-To: <20240322-fp4-tcpm-v1-1-c5644099d57b@fairphone.com>


--zrO6/TpLSL1IE1BD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 09:01:32AM +0100, Luca Weiss wrote:
> The VBUS register block on the PM6150 PMIC shares the design with the
> PM8150B one. Define corresponding compatible string, having the
> qcom,pm8150b-vbus-reg as a fallback.
>=20
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--zrO6/TpLSL1IE1BD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZf3GDAAKCRB4tDGHoIJi
0tNSAP43+Tgl00PPvrdj3zRAA0b2dvtJfOKFaIei0uPXW1HnIgEA7HECliQR+dHz
KAqbZgZcRczb5ech2CZFcJU1Z2hjDgM=
=xGlc
-----END PGP SIGNATURE-----

--zrO6/TpLSL1IE1BD--

