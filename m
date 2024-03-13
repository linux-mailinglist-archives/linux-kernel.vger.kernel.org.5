Return-Path: <linux-kernel+bounces-102232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B738287AFA0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92311C25749
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D877762D;
	Wed, 13 Mar 2024 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbdUdZY3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CA577624;
	Wed, 13 Mar 2024 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349733; cv=none; b=GzNTl1bQPTVrL9wBUzJXCe2N3VErvXQeKkwI5JsBqIKQfFzUC+e9gWJTrz2n9XB2CC2c+rhLxboYzRBU6HTJaD3BKKHa4okBP13NltySLombpI0HGaPB314wHM6xQPD54a4X63qOBptrCbvoF0peVTo5MDu4PO/8swA9wfhmW4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349733; c=relaxed/simple;
	bh=keuQhg3foI7ik3PHzL1Oy5CNygbpYHEt35VrYX/ALYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RywGQavqBj7b7PJf95QSbyEs+YtHlP3Wp1Z6U57Q6hPf0lqA0ZhkYUmuS+XsPRjxuv14E9T6OwegDmmhSCi0c8SmrUL0mbVk9AC3CXU7vZfuuPcGwv9Wla2BHkplK9VBv54KVTe8djhldLBOW+P4f6WJdg4QVydWWTiT0188ALY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbdUdZY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67415C433F1;
	Wed, 13 Mar 2024 17:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349732;
	bh=keuQhg3foI7ik3PHzL1Oy5CNygbpYHEt35VrYX/ALYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XbdUdZY3fNNyx7zu62uuMWbKSy37FYls313diUx44FimNBczrShLJtvJpxe2ceMG7
	 jT6MgVHff/GD/xL+gda4+vBHkuWGuAPT3Sbxfe86PCxhjy4+S8LvC/GLPc8yJxdPEj
	 DMtHnWxVb+GEX7nMsjjFfZXXqDIQ2b1JjLyjWayKZqHGmY2ie93Ts/bDt6I9qZUdrp
	 7QFh09DFT41juaQY4R42LJXyiiiYG40uBrHH8Ug8yidGlgmJGzGqL9D02KQpwYVr9Z
	 o52hju9oI4dBvO31FHjQJO2o1Fe+J4+ZYAN0YAlyHM0IyJbHFz36qryKI3GLGRgi48
	 iZmcTNCJmdOiA==
Date: Wed, 13 Mar 2024 17:08:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Ansuel Smith <ansuelsmth@gmail.com>
Subject: Re: [PATCH 5.4 46/51] regmap: allow to define reg_update_bits for no
 bus configuration
Message-ID: <a8a62275-bcd7-4652-8a21-758f8e5f4911@sirena.org.uk>
References: <20240313170212.616443-1-sashal@kernel.org>
 <20240313170212.616443-47-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6l1XsiI6r34fGSja"
Content-Disposition: inline
In-Reply-To: <20240313170212.616443-47-sashal@kernel.org>
X-Cookie: It's later than you think.


--6l1XsiI6r34fGSja
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 01:02:07PM -0400, Sasha Levin wrote:
> From: Ansuel Smith <ansuelsmth@gmail.com>
>=20
> [ Upstream commit 02d6fdecb9c38de19065f6bed8d5214556fd061d ]
>=20
> Some device requires a special handling for reg_update_bits and can't use
> the normal regmap read write logic. An example is when locking is
> handled by the device and rmw operations requires to do atomic operations.
> Allow to declare a dedicated function in regmap_config for
> reg_update_bits in no bus configuration.

New feature.

--6l1XsiI6r34fGSja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXx3Z8ACgkQJNaLcl1U
h9CkSgf/XLOZB7MDULvxqB9e9n1SAiTj7Bn6Ax4WwW3rBmhQ0XLUQkhrg2VIp5cY
Cp5rjkbHD5qYnjp4/0hVfzCRcnr7H6pSeMU6FlgpIgV8zxxfmaPnXTqHWZN6dqmF
RFJU6wJ6uy8ThaTpfqkZ+lpoIF70gsYdEUpPPWb87frQefbZs35U5WsjvB3gWhtK
SUjLJQFLewR+XVySZb9qWcI25wYe/3tW/D6/+SiIGXTSzCRTc/HVS2Joc9SCAoj6
UXRnNsO2/EILJqLgPqYTMDx93vYxDTHuJAIujdX+lEAyYoXrY34N9zKBykztFkC+
Y9HyHafzYEp/zn3qcpi7vOBaAPFsKA==
=7zit
-----END PGP SIGNATURE-----

--6l1XsiI6r34fGSja--

