Return-Path: <linux-kernel+bounces-123770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8628890D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6611F275DF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249CF13B7BE;
	Thu, 28 Mar 2024 22:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6vF72lY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFA413AD16;
	Thu, 28 Mar 2024 22:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711664474; cv=none; b=KTwJ0XWhFNQldiwOA2zjpH5fV1HLpzEsLuAtv+zs+ZXpd9FaN0ygYmJ4ueFuyD8Ps7e+o6hFB0+BHLIqSsPh3cskiyXT/zmcS5/B3LznPi3n9qbe12RaCJ7Z8/Q+24jj1nFyOJrRZ5fogbiXWuNlsvVJpqrfg/rW/h7K92e0sm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711664474; c=relaxed/simple;
	bh=bsSpq2w4oaQS7kD7JI8nwjuSOuDf0gdzrs5EEVCG4Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhbZ7ii9tC2kBMAcGxO2QppbTWh6cmrVv+MegemZmjkSerjdzfNhjN2NyymmRDNvE/6hcIDalqlhB2g6CWBSjxGjfSdhsm6QyI9eb26qsA09GLXX/JoJz+A3p5bCK9imCURPdTSMKNOl0rlUPtfbQlb10OCZBcT8S8fna/mFBrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6vF72lY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049D4C433C7;
	Thu, 28 Mar 2024 22:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711664474;
	bh=bsSpq2w4oaQS7kD7JI8nwjuSOuDf0gdzrs5EEVCG4Fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r6vF72lYF1z6UGUgicOrv8mOgCUAVX9ejvJfqMEGf+KWg0mOd8QRBSk5ODn2dEb6F
	 nMoD6qfE4mfWRADfW8V7SkyhtNVs9pPVorRWS/6PMQGQHIXrUQRSJ5A4MqD9LUr6KO
	 +1Objm5Ppqb4Yfw5H6liWjCUKtCI0HVe6U9YFfC21qdsl5iJaTTMqkL+5Q6exlEjh3
	 QyvPGn31vgVBc+JwROFSRmDbidRw2vmPcM9zqWd6SqUxI4oS+MtrMg7pUvoGT1bPfe
	 g8Bofxz696RnKT7IgBkcFnOAssUotPbTtdGSTpv5ZrxSnOGUmO+FEqjcWmgRLG5SRs
	 VCdLNrP7aCX1A==
Date: Thu, 28 Mar 2024 22:21:07 +0000
From: Conor Dooley <conor@kernel.org>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: neil.armstrong@linaro.org, jbrunet@baylibre.com,
	mturquette@baylibre.com, khilman@baylibre.com,
	martin.blumenstingl@googlemail.com, glaroque@baylibre.com,
	rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
	lukasz.luba@arm.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	kernel@salutedevices.com, rockosov@gmail.com,
	linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: amlogic: add support for A1
 thermal sensor
Message-ID: <20240328-crummiest-snare-cfdd5f3676bd@spud>
References: <20240328191322.17551-1-ddrokosov@salutedevices.com>
 <20240328191322.17551-2-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q47ai3GyIvUiEQNG"
Content-Disposition: inline
In-Reply-To: <20240328191322.17551-2-ddrokosov@salutedevices.com>


--q47ai3GyIvUiEQNG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 10:13:10PM +0300, Dmitry Rokosov wrote:
> Provide right compatible properties for Amlogic A1 Thermal Sensor
> controller. A1 family supports only one thermal node - CPU thermal
> sensor.
>=20
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--q47ai3GyIvUiEQNG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgXtUwAKCRB4tDGHoIJi
0t8dAPwOdnpLHUuMl9milt9H60HZRcx8vIKeJHzJzSPxZycsOgD/Tap8JbmOP7iC
4qa6cJjymaDGRdbAt/HGE/o0XnrSpwc=
=AzG/
-----END PGP SIGNATURE-----

--q47ai3GyIvUiEQNG--

