Return-Path: <linux-kernel+bounces-30329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31019831D2F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7E8285111
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7C728E07;
	Thu, 18 Jan 2024 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s806ud0K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A592C183;
	Thu, 18 Jan 2024 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593867; cv=none; b=qYRRG30Czcf/eNnHRWXmrRVLzc/1ur4yUWv2Y4tyCN1NcCaHDa87X9Dys4dSv9Ih1MHpsscdQhDTsbcDgUoQxJXwSRxZrqcvNzy/2HdE+tjOWYH9hCA2PQSkvxj60xnKsiN/dKBd2b+BgCFZ0O52FMeP3jTWssV1ZKUM3233LVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593867; c=relaxed/simple;
	bh=PzeADkiL6ebFQpxODXk48UDd1lVVQ/gpZ90OWnSrLqQ=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Cookie; b=ODXB4ld7uvOkR35ArVXsdjiVkIUF9zkMmBKmoHFd3dVsLZBLFGGZ1z7BbiHwDWUUyf6plmABkGJ9b86HbbVW/tPlQ9ciNuUL+zYj2zRm7MRJ1JweQ21r3U3RSR/yJiuf9Fntw1atW/kDV4v2aBcgxSOMlyljJioR3m6MCXkK7qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s806ud0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B13C433C7;
	Thu, 18 Jan 2024 16:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705593866;
	bh=PzeADkiL6ebFQpxODXk48UDd1lVVQ/gpZ90OWnSrLqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s806ud0Kuq+gL6cI32OifNI1pz3HJl4dWlSV3VuGDQAGJQPNUMfE/eXwVRravvsoS
	 xr13ZTDB2x9D2a/MH1o4QeL5lHS9+YrqirkKcwtLEn4qj9O2Atn3obftzsn6r/oK6H
	 Wy3E/oSyhFYV2MXKtq9vX5cc4xQ5r/uk6YeCaBIPKBhQa4y9cCrAU6JNftV1cqBc2a
	 UrxPj14r5pVkPvGa6zGmJNcfEiwz1nZUEPt9MffBsOzCV80Z9pGoqBrNoHK7AzsEm1
	 AFbNnD5n5vfUtwu/ulZLuHvgtr3LCayH9oy4ric0qNFp4LjU2B12dz5XV00KB8WQek
	 CFf+l1+mLkAbA==
Date: Thu, 18 Jan 2024 16:04:20 +0000
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
Message-ID: <f5827df7-34fa-4c11-aca9-ecc6c83c512d@sirena.org.uk>
References: <20240115-topic-chipcap2-v5-0-0cc7a15aeece@gmail.com>
 <20240115-topic-chipcap2-v5-5-0cc7a15aeece@gmail.com>
 <226d3abd-e372-4c66-b2b0-cc86e6a4bb27@sirena.org.uk>
 <30b9ab0c-f3cb-4b5a-a726-de9f7c61769b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pCbgqIbLtZhTtuRa"
Content-Disposition: inline
In-Reply-To: <30b9ab0c-f3cb-4b5a-a726-de9f7c61769b@gmail.com>
X-Cookie: FEELINGS are cascading over me!!!


--pCbgqIbLtZhTtuRa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 18, 2024 at 04:30:37PM +0100, Javier Carrasco wrote:
> On 18.01.24 14:49, Mark Brown wrote:
> > On Mon, Jan 15, 2024 at 09:02:25PM +0100, Javier Carrasco wrote:

> >> +static int cc2_enable(struct cc2_data *data)
> >> +{
> >> +	int ret;

> >> +	if (regulator_is_enabled(data->regulator))
> >> +		return 0;

> > This is generally a sign that the regulator API usage is not good, the
> > driver should not rely on references to the regulator held by anything
> > else since whatever else is holding the regulator on could turn it off
> > at any time.  If the driver did the enable itself then it should know
> > that it did so and not need to query.

> The driver handles a dedicated regulator, but I wanted to account for
> the cases where the attempts to enable and disable the regulator fail
> and keep parity. If the disabling attempt fails, will the regulator not
> stay enabled? In that case, an additional call to regulator_enable would
> not be required, right?
> That is the only reason I am using regulator_is_enabled(), but maybe
> things don't work like that.

With exclusive use you can get away with this, you should have a comment
for that case though.

> >> +	ret = regulator_enable(data->regulator);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	/*
> >> +	 * TODO: the startup-delay-us property of the regulator might be
> >> +	 * added to the delay (if provided).
> >> +	 * Currently there is no interface to read its value apart from
> >> +	 * a direct access to regulator->rdev->constraints->enable_time,
> >> +	 * which is discouraged like any direct access to the regulator_dev
> >> +	 * structure. This would be relevant in cases where the startup delay
> >> +	 * is in the range of milliseconds.
> >> +	 */
> >> +	usleep_range(CC2_STARTUP_TIME_US, CC2_STARTUP_TIME_US + 125);

> > Note that the regulator startup delay is the time taken for the
> > regulator to power up so if the device needs additional delay then that
> > will always need to be in addition to whatever the regulator is doing.

> What I mean by that is that the device cannot be ready until the
> regulator powers it up (obvious) plus the start up time of the device
> itself once it gets powered up. So if a regulator takes for example 1 ms
> to power up, the sleep function could (and should) wait for 1 ms longer.

No, the sleep function should do nothing of the sort - if any delay is
neeeded for the regulator it will be handled as part of enabling the
regulator.  This is not exposed to client drivers because it is
transparent to them.

--pCbgqIbLtZhTtuRa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWpTAMACgkQJNaLcl1U
h9CYFgf/Qehv6NdtI4HdY20rddA8XoUZMygn0/H7omFeU3P6JTeybouEpsVlQwuP
twqa/HzVCKwlguVO4UeqaISzAco4mbMm26jKlAvx+ZBoGjkwkZn68gVjqZ4gNIxD
Lnt1eLJGRK2B7IpZyTCKLrvuXPuHA6bQSgOy+Pvqnm6Q85kHZ4/mEhg/hQTgMFGZ
QQRG6SgBDxNBqwWupmokkM4c50nMLCinGFlINiYa2thDWEoeDJH18LD3KUCip4ZU
q7fjha9GbZj7ddeAEKGXA15B88Wt3P+CXz7Cy/WAHrOfS/Nu/LMCiHG7iOUyhSi3
CjynkW6339lxeVkd2iURGCqR6g8LQw==
=mO+x
-----END PGP SIGNATURE-----

--pCbgqIbLtZhTtuRa--

