Return-Path: <linux-kernel+bounces-30166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D429B831AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731141F288D6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E6025618;
	Thu, 18 Jan 2024 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Im/qJ8b+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F73724B42;
	Thu, 18 Jan 2024 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705585801; cv=none; b=Xc6AeCrA67Z7CC6a8rXDevy+HbnV9SU7jy9gdHRmUKwgV+/xD5HtFyxV1v/hqt5yiisUjCuY3npCe4ZRc/QCGB8pdksQNvl8GNrAmnsLGmo7Fz523XHgrPa42uz3UZfN/VxOxYnkmrgsCt6zCdhFv9ddS7BcH4r+ba9c7wEhLRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705585801; c=relaxed/simple;
	bh=c2Kr9pyBCgxHYB3SD8hNYiQBeM9zBrS7UndTcmBVxLU=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Cookie; b=dROcAtkllVWCJMDCALGyuAtlxZ5El2AxWTeTF0UsgrRe9mJBOpFXeln2fgdU9LjpOaoaIsnPBcMexuLrVtABO034n9dd8zfaIvQWERkJYrjB/sbkMFOcKl6435T5gJjboNP3ZzNN4RbIecERMBha0anzkYNLoFUe2QP9zEsbivI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Im/qJ8b+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB75C433C7;
	Thu, 18 Jan 2024 13:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705585800;
	bh=c2Kr9pyBCgxHYB3SD8hNYiQBeM9zBrS7UndTcmBVxLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Im/qJ8b+8Ulj106Cp/pXjnNIcYd1kOLQ1bdIWcDoh6Bm+TvsfoBWwq/RSBQMz0C9b
	 0BtpqDMFPKW91cLJe7GwcOQ/9RgE3V+7tk3j8cNeptMod10u0IP3+gCGStIeGpcg1y
	 YQcFQM+mzhsKIsZxUzXrxcbjtkK5bVJCNhIj6mutgTzPzPt5DIq6/edYIIfqenmJhx
	 YBLe/H2yHZwYBM3wgdkHK+mnCnYJpCcVODRYBKh5Z13Blp0Sl3p6686vhUo0qa6Axi
	 n71zppbfJanR8uu6hEVxRqTv7K5LnExa8gyd4/sfIgryKYZwITKTZUEjJw1T5RVl3M
	 4gfgUe7AAO8ow==
Date: Thu, 18 Jan 2024 13:49:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 5/5] hwmon: Add support for Amphenol ChipCap 2
Message-ID: <226d3abd-e372-4c66-b2b0-cc86e6a4bb27@sirena.org.uk>
References: <20240115-topic-chipcap2-v5-0-0cc7a15aeece@gmail.com>
 <20240115-topic-chipcap2-v5-5-0cc7a15aeece@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QrXWaaDFLUIiRC/N"
Content-Disposition: inline
In-Reply-To: <20240115-topic-chipcap2-v5-5-0cc7a15aeece@gmail.com>
X-Cookie: FEELINGS are cascading over me!!!


--QrXWaaDFLUIiRC/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 15, 2024 at 09:02:25PM +0100, Javier Carrasco wrote:

> +static int cc2_enable(struct cc2_data *data)
> +{
> +	int ret;
> +
> +	if (regulator_is_enabled(data->regulator))
> +		return 0;

This is generally a sign that the regulator API usage is not good, the
driver should not rely on references to the regulator held by anything
else since whatever else is holding the regulator on could turn it off
at any time.  If the driver did the enable itself then it should know
that it did so and not need to query.

> +	ret = regulator_enable(data->regulator);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * TODO: the startup-delay-us property of the regulator might be
> +	 * added to the delay (if provided).
> +	 * Currently there is no interface to read its value apart from
> +	 * a direct access to regulator->rdev->constraints->enable_time,
> +	 * which is discouraged like any direct access to the regulator_dev
> +	 * structure. This would be relevant in cases where the startup delay
> +	 * is in the range of milliseconds.
> +	 */
> +	usleep_range(CC2_STARTUP_TIME_US, CC2_STARTUP_TIME_US + 125);

Note that the regulator startup delay is the time taken for the
regulator to power up so if the device needs additional delay then that
will always need to be in addition to whatever the regulator is doing.

--QrXWaaDFLUIiRC/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWpLIIACgkQJNaLcl1U
h9B65wf/Wg0QW0LIWGgdWQ7IuOfqDh3LYsyHxFindkzlWUik31DSPhRG1Y8mGpCn
HttmSyq3JRctGJdKnMpoiFfK6WpQk8SWvqN6c8S1sXUAHzJ+kUuiIrBgg7Rttd2a
aYyK2M6NxTC3VBx3BGgcPOGsgdIxF5jBG9UBE2//kBpqSICHtc1D4P7XfTGsf4nX
2XLXqW7HqqIQFS6w9pi785wY6D0JDPUR8guOOUV+RJM2dWHxO54vx1dmINy9il+0
1z098JjEQIMfqs1T0t9tH06wbkNGQCfAi/AnKGSEYwkxcneiU1eo65GwsMV3H163
MnMMsNykw5LhV9yVpqLOYKPn/yF6lw==
=N/9a
-----END PGP SIGNATURE-----

--QrXWaaDFLUIiRC/N--

