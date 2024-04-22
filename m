Return-Path: <linux-kernel+bounces-153638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C138AD0E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F103C1C2239A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899EE1534F5;
	Mon, 22 Apr 2024 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="te+a3h/g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB79514EC61;
	Mon, 22 Apr 2024 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799922; cv=none; b=RJe7PK1ZmsTUx9A+5LwJdsYo8XvVigGxb2SSRtO0qPH2vXhYbvcOLeasukSHhwygld2CSb46L8B/H/Oon4x2kpGvANhK2VdRcvFmy3UgYBlkcNOwLHu6/cHPsgBFw9eYehpHXDmqICsWXztDICwmJcRqYg1xtKy/0SpZW55AnF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799922; c=relaxed/simple;
	bh=UvmIfCiITCcdyzxsZMMrgYWKx8FzLEXrnqmTNkMaMaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwPvfwCb5XYxz1jN1A/LhQwefNHmcZwRBkH2pWcX2Zm3mzZkPCFpuPbVK2QsGTzLHHWXsqE+FFLMmRAy9WxA3s+ycJGaYUXy4QXJsfydslAZFQLUJHg7MUGbGBZzLIo4mlihYMVwGvIgZZqmmh/oO3fIU2HkXz6Pzfph0pJ3U8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=te+a3h/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF42C113CC;
	Mon, 22 Apr 2024 15:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713799922;
	bh=UvmIfCiITCcdyzxsZMMrgYWKx8FzLEXrnqmTNkMaMaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=te+a3h/gS8fUUis5ddHZ1+T6SNiYNG/yCMPhmrcLcA9c0XNiYlXgTAohCu59EV0uP
	 yDA6i3FchjzUMC0jT0z9muuac/dDSnPlboA7BCsepHnoscx48lVUTH58MKf49rWvsb
	 JH7iLX+uOxmJj2rDwrDKetSxzBEf9cgZVKs9litqnb6A9vOoc1nIsW3SL/2hhfbzar
	 ruOXYQV4JmP52gvKEzWEtY9STxF4ifuFM3DkG4Yis69WXNwSpckTwKfINEW7QjG1ws
	 pqAHyZrqxERLCsVjcbmojT9Zgx4IP6OszxgZKSitE/IVraV5dE+kVDroliMA6NWYXp
	 becZgB7l6n/2g==
Date: Mon, 22 Apr 2024 16:31:57 +0100
From: Conor Dooley <conor@kernel.org>
To: kelvin.zhang@amlogic.com
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	Zelong Dong <zelong.dong@amlogic.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: reset: Add Amlogic T7 reset
 controller
Message-ID: <20240422-unbridle-busybody-1ac4abc20843@spud>
References: <20240422-t7-reset-v2-0-cb82271d3296@amlogic.com>
 <20240422-t7-reset-v2-1-cb82271d3296@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="st57Evgp6eg7VOFY"
Content-Disposition: inline
In-Reply-To: <20240422-t7-reset-v2-1-cb82271d3296@amlogic.com>


--st57Evgp6eg7VOFY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 07:11:43PM +0800, Kelvin Zhang via B4 Relay wrote:
> From: Zelong Dong <zelong.dong@amlogic.com>
>=20
> Add a new compatible for Amlogic T7 reset controller.
>=20
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--st57Evgp6eg7VOFY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiaC7QAKCRB4tDGHoIJi
0gu7AP9QZ6oXIIzIK8YedKjepYRFL4uNI4BB05WmkRTGeCKSTwD9FitSjjV78XBr
dqFLrp1pz7ps0KLscW8UUSS/Uq9TuQk=
=AVLI
-----END PGP SIGNATURE-----

--st57Evgp6eg7VOFY--

