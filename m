Return-Path: <linux-kernel+bounces-30287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42902831CA2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC99A28A72F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B3A28DB3;
	Thu, 18 Jan 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYgMK7mK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC1A23741;
	Thu, 18 Jan 2024 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591893; cv=none; b=BQHvGt9VNMoPxBsnVS+hV1kENEdrGIIfQIdin2+sdInt2woo0uWeF4bUhNsklj21G6B7t/+loo3YGzybzT87Le45ekDHOL5tv+pggAbgNlI8PIud3PqP0C2Gmr1YBgHRq4FskoRkEzBSVwvhVpL8lK2DEXirGrb0fR3riHHHMNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591893; c=relaxed/simple;
	bh=4wA+UWwUt1juxH0gO+qlw0qBSnENNfKQfAfESA3JOVA=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=nbvf4eG2WQ3vV1Ba56cdPbhZdWTiLqtwPnLEvUaZK0ntf4OzdcFfWd4zdPGuLa9cIM6BVDdCzypCY7hMpMdy/AUTnxJ7rZTlLV6kH5hEBNNxecr0E3xIvmTrFRb9yqR6nWVkzSk7J3LKzK1dt0G0nkSLhdbVDecmTIGjIgM+Ss8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYgMK7mK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A758C433F1;
	Thu, 18 Jan 2024 15:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705591892;
	bh=4wA+UWwUt1juxH0gO+qlw0qBSnENNfKQfAfESA3JOVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oYgMK7mKWk4ZpaH3EseK8Uu7+VHlxzes9YSDMKw0MQl6vDz0aE35z9l5zA3rAJHxy
	 BsMNnOdU+x1zZVU5ULw4Vi++4+idxP+fxaG4rDIVsNy0FceRSO1rQZ1d9c14jWDNB3
	 VDjGwfjyA/qljuvGO80OcVYJV44ejuOioTJ6QpooEQkxKNn5zMXO0DG1ZGkDY21vs2
	 lC3EVqEUqTc5/+e8ceuNyI/SV87N55LGVlxR7gw6+Ar7IueUmvo7ELbdeYy9R3OR1u
	 aBeUpNP3Xwd53UP2qVMZAEDmGH1Ag1xLa9UCQlATBEv9FG6HnJaQ/Hea1i9hhhKBnO
	 L3p63L2WnYYIg==
Date: Thu, 18 Jan 2024 15:31:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: conor.dooley@microchip.com, sam@ravnborg.org, bbrezillon@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lee@kernel.org, thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
	linux4microchip@microchip.com
Subject: Re: [PATCH v3 1/3] dt-bindings: display: convert Atmel's HLCDC to DT
 schema
Message-ID: <20240118-unscathed-flail-be2e49abc56d@spud>
References: <20240118092612.117491-1-dharma.b@microchip.com>
 <20240118092612.117491-2-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uK+u7gbhbDVqB0jo"
Content-Disposition: inline
In-Reply-To: <20240118092612.117491-2-dharma.b@microchip.com>


--uK+u7gbhbDVqB0jo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 02:56:10PM +0530, Dharma Balasubiramani wrote:
> Convert the existing DT binding to DT schema of the Atmel's HLCDC display
> controller.
>=20
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
> changelog
> v2 -> v3
> - Remove '|' in description, as there is no formatting to preserve.
> - Ref video-interfaces as endpoint.
> - Remove ref and description for bus-width.
> - Add new line before the child node in example.

> - Remove 'example 2', as it is not required for just one additional prope=
rty.

Rob's comment on the previous version was:
| Just 1 extra property doesn't justify 2 examples.
|=20
| In any case, drop the partial examples and just have 1 complete example=
=20
| in the MFD binding schema.


--uK+u7gbhbDVqB0jo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZalETQAKCRB4tDGHoIJi
0oMyAP9+Ll8fdXViDHTVjFHNGPWzChucZsZdKY7aRr7jkFYBhAD/Qt7JIQGWHJ89
hYQiygsvwed2ijEO9ueMCNp10XQMzw4=
=FSle
-----END PGP SIGNATURE-----

--uK+u7gbhbDVqB0jo--

