Return-Path: <linux-kernel+bounces-66833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F8785621B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203B31F2724A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF82112BEAC;
	Thu, 15 Feb 2024 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftKTfYVm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA0312B151;
	Thu, 15 Feb 2024 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997723; cv=none; b=G0dPfYZn1I0SgPPsK04EyomRoJC06S7/aiaaYb+KlsDIjRO/o7pPkF6TR38doxW7e4IowoS/Z5e0fk8TH2q0cdpT0pqgGmL7HUdIr2NlJSdwCO0gw3StS5nOhQeRmTiq70LLpq+VW/uDNvu7IHmhYJ6yPiK93xsdJ7FzRfcAgrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997723; c=relaxed/simple;
	bh=6kDEft4yZaxt/MvQeW3rybsZfR6n+Mzo3vGvIfyQKQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuEW2XSEBQIVfLBXfkdADNJIiwPPQEVC54yH5jSwIyhguUiRnl3RLHpiH/YQbyyLcXx41cvrv7I0rN0/b0BzvcMShpnF5n/D7sMmA5yomWkU9rWtn8C15wuNzRcwY1grgKBWy88aa14b7YAmJQ+Sk/cjb8k+7PCQIgf1Hq7yejI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftKTfYVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480B7C433F1;
	Thu, 15 Feb 2024 11:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707997722;
	bh=6kDEft4yZaxt/MvQeW3rybsZfR6n+Mzo3vGvIfyQKQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ftKTfYVmcIdKYvWge8L8BBtCRgVqZZ9ialp4cCC53VwdtXVajE9sBlA4SI/8JsytO
	 XUedARwlNTgDSIcYKk9cOO0k3m8oU14yua8WaCl9hUwQaZliMXY1MWt652hu8IxIqP
	 5OmMyAr8crOwvtMXoZfslk3O64NZE3Dem9+s1kL4Snub36vuhyVr/RWsb0QMv3CiKJ
	 yP8j3pQQuhQleiS35vt8HkabskExuoKv7rexXMYIhcwj+dgPsR/gU8iZ7v6A6D8RwG
	 HMtXAWnAUzphwyycYlpDUBFIEX45xxHlXGzTOsOr0zpuPBOBy2w5Qxgu4pwlNpH0j7
	 zFP01YRueGoLQ==
Date: Thu, 15 Feb 2024 11:48:38 +0000
From: Conor Dooley <conor@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
	Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, mazziesaccount@gmail.com,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: hwmon: tda38640: Add interrupt &
 regulator properties
Message-ID: <20240215-wildfire-dotted-a561e86a6054@spud>
References: <20240214092504.1237402-1-naresh.solanki@9elements.com>
 <20240214-trinity-delouse-6dcd0b046895@spud>
 <0f1665e5-bae1-4a17-a976-cc225a28dad3@roeck-us.net>
 <20240214-dimly-wife-5b6239d4adec@spud>
 <b306a27e-505e-43d4-aaf8-ab31284a3396@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tmiZQ9tIrjdkv1MF"
Content-Disposition: inline
In-Reply-To: <b306a27e-505e-43d4-aaf8-ab31284a3396@roeck-us.net>


--tmiZQ9tIrjdkv1MF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 05:17:04PM -0800, Guenter Roeck wrote:
> On 2/14/24 11:55, Conor Dooley wrote:
> [ ... ]
> > > > Why "vout0" if there's only one output? Is it called that in the
> > > > documentation? I had a quick check but only saw it called "vout".
> > > > Are there other related devices that would have multiple regulators
> > > > that might end up sharing the binding?
> > > >=20
> > >=20
> > > Primarily because that is what the PMBus core generates for the driver
> > > because no one including me was aware that this is unacceptable
> > > for single-output drivers.
> >=20
> > Is it unacceptable? If you're implying that I am saying it is, that's
> > not what I was doing here - I'm just wondering why it was chosen.
> > Numbering when there's only one seems odd, so I was just looking for the
> > rationale.
> >=20
>=20
> Given the tendency of corporate speak (aka "this was a good attempt" for
> a complete screwup), and since this did come up before, I did interpret
> it along that line. My apologies if that was not the idea.

I'm not gonna go and decree that "vout0" is unacceptable, if it was
called that in documentation that I had missed or was convention, I was
just gonna say "okay, that sounds reasonable to me".

> Still, I really don't know how to resolve this for existing PMBus drivers
> which do register "vout0" even if there is only a single output regulator.

I had a quick look at that series, none of the devices that I checked
out there seem to have documented regulators at all. Some of the devices
were only documented in trivial-devices.yaml. Relying on the naming of
undocumented child nodes is a bug in those drivers & I guess nobody cares
about dtbs_check complaints for those platforms. The example that was
linked in the other thread doesn't even use a valid compatible :(
	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/ar=
ch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts?id=3D8d3dea210042f54b95=
2b481838c1e7dfc4ec751d#n21
I guess it uses the i2c device ids to probe on that platform, or have
I missed something there?

Cheers,
Conor.

--tmiZQ9tIrjdkv1MF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc36FQAKCRB4tDGHoIJi
0pUaAQCoI/EW1WcdOCPKDAlNbr2bCXACKjFu6s7NFg8LVaQekQD+IGn2qZPeluC+
C6w8/WhsHQp3eI+6sJbs1z6r/ZvPZw0=
=VQ5Y
-----END PGP SIGNATURE-----

--tmiZQ9tIrjdkv1MF--

