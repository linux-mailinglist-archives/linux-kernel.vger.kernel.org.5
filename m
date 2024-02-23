Return-Path: <linux-kernel+bounces-78992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92303861BE3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42351C22F1D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4F512BE83;
	Fri, 23 Feb 2024 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cznrKh9E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7750747F4A;
	Fri, 23 Feb 2024 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708713585; cv=none; b=kxmWC79qfrAx72alsCxrqHTo2lNqQdyAWFhlyschG/KhArn99E/fsODoKNFZjm0zNIKCFCFdSAfw4Kxls2ggB/WZr5VOqd5+dOiIT1qXqmAAlIoc6vUA7xLHglIQLwlAHCv7zROqdTOZUBP7ruhbCyobR2UK4UZQhE+i0+HdLB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708713585; c=relaxed/simple;
	bh=takZljqXLnt3Ixs0Fc0KHYxpdZzcgivO66t0n7S9oqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TF980/KQTpKFJbJWR3TGoeQtR99nt0EQVpoRuPPIULx4HVpNSwfAgM0FbDPimL2sJbRqhVjJf6m2GzybMjaXIzHI6cE4Z3ZPI1DnZ7419azLVJ5U6Uk2z9JLuOotSJ9n0A77p4UYPmUhocE98zyZCYhHPjKn/lAkb47OZm8P+F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cznrKh9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F376FC433F1;
	Fri, 23 Feb 2024 18:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708713584;
	bh=takZljqXLnt3Ixs0Fc0KHYxpdZzcgivO66t0n7S9oqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cznrKh9EkNAmXjXJafMtPo08zjCgPziGn6n66fIIyTPB0UbZqWgDYOtIbYTtnlpLz
	 KlAZoKAKpQJ1Jr9Ch0d6opKANT3BKcia+oSihNtWcOIGJC1iu01FF61zlhLZb4WptN
	 qloIuRxEoCR30+vgTJDIwf8ee0Fx0glu9+IWYsC2ppje4XYgdW1xbWfJfcIm05sZJr
	 drbsteSBhJ7CJQzDvJLiF0aRIac4CTshHo326spQ9wY6IRHtK6GUJviosqGsI7dJ/g
	 piS3EcFJLIlh4vTbZwk0J8Ou7IZYSIWUJ/HwORKBxdK5lLbghuICITf+y7dY2+/wyK
	 jnGJt+pL9aG8w==
Date: Fri, 23 Feb 2024 18:39:40 +0000
From: Conor Dooley <conor@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: add TP-Link Archer AX55 v1
Message-ID: <20240223-enchanted-marmalade-04effab0909c@spud>
References: <20240223-archer-ax55-v1-v1-0-99f8fa2c3858@gmail.com>
 <20240223-archer-ax55-v1-v1-1-99f8fa2c3858@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rK4sGWGH5kTCaSuz"
Content-Disposition: inline
In-Reply-To: <20240223-archer-ax55-v1-v1-1-99f8fa2c3858@gmail.com>


--rK4sGWGH5kTCaSuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 09:17:44AM +0100, Gabor Juhos wrote:
> Document the TP-Link Archer AX55 v1 which is a dual-band
> WiFi router based on the IPQ5018 SoC.
>=20
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


--rK4sGWGH5kTCaSuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdjmbAAKCRB4tDGHoIJi
0vS3AQC9PMpgJiux4JhNOBz8n/CKPTxbhqrO7VEvcgjT4tia2QEA8pJz4Tqxcabk
lfoyRh6xWFw9SKxkhbCOxkPBzM3YJgU=
=e/3t
-----END PGP SIGNATURE-----

--rK4sGWGH5kTCaSuz--

