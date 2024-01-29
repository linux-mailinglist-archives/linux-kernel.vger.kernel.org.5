Return-Path: <linux-kernel+bounces-43145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FC2840C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7F51F2387D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEEA157027;
	Mon, 29 Jan 2024 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+hVcMcz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC137664D2;
	Mon, 29 Jan 2024 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547120; cv=none; b=jO9+j/GnjDgPsYGbjph0vAepTA6lFNKAzUFeYiXl+lxNS0MOGpvhHAdMPxSGgsVapoky9pzCpeYgRaszkcwFY5UgGYUcmgQsppGKAmh31jGOsjqhyaua4lymuu2girGKMUTZ0y4U+Sv0ezkuPBK6c+E2W7p46NId65/I7gb04LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547120; c=relaxed/simple;
	bh=Tere6Vxvz/ed/+qOczM5/zXeFie6UH3FjdtmUEOHVDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEBspswqVpXKrq45w5Rp0fpX2s4Rip4r/CoQ6ka7oC1auwFCe8SbnVFoVB1YMfBBc+jEUwI0a7nY5bFLu78JugbA9O0wwhSeE3NQHwx2KUwytMiH2nS4Gn3VwdF/ePbKDFf/uq7zFFLEdNCBt3w+uY6XJkMkeJOcu+K3dZax6CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+hVcMcz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9F4C433C7;
	Mon, 29 Jan 2024 16:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706547119;
	bh=Tere6Vxvz/ed/+qOczM5/zXeFie6UH3FjdtmUEOHVDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+hVcMczXYoZwjx5iobCvRdHJflXivAr+727+oIPradNseUtwlzkDMBaOmHo17UDf
	 6jYj1c6sudKkKAcrAEybsZUoVw1iJtz+teX1reyrtHkVR5DRbF+LUgD1JWxZvLaRb5
	 AyPeurvXiFgSUQtSR2jEL/MzDbjaqDAqRRl6YDI2IgA8MY5vQ+qaERRd8rR5C1Pvgp
	 ZBdSMkTBY91LMIDawr9Pbff2AJeD6YKjwGfNWEvLS9tCayJzgn6YCP84/SNRp7+dej
	 V1K6l4oidJedDLe6gZSZk+wJhwdrNWhReI9OG2bNS7JgHLkfosCGzIlyNEINWvuHUA
	 LIOY/ekd3r9kQ==
Date: Mon, 29 Jan 2024 16:51:54 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: qcom,ipa: do not override
 firmware-name $ref
Message-ID: <20240129-anthill-boxcar-a73159ac1c79@spud>
References: <20240129142121.102450-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sjsnelgbeNpCDbvr"
Content-Disposition: inline
In-Reply-To: <20240129142121.102450-1-krzysztof.kozlowski@linaro.org>


--sjsnelgbeNpCDbvr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 03:21:21PM +0100, Krzysztof Kozlowski wrote:
> dtschema package defines firmware-name as string-array, so individual
> bindings should not make it a string but instead just narrow the number
> of expected firmware file names.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


--sjsnelgbeNpCDbvr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbfXqQAKCRB4tDGHoIJi
0lfXAQC1ejpO+kSb2Dfpi4BzRds5tGo/fgK/EdsP/ySoLnyhrQEA28RolBg1YnvV
IRrIGSK94JgSp+hJqsKTpBnHMmxKXgU=
=uGjc
-----END PGP SIGNATURE-----

--sjsnelgbeNpCDbvr--

