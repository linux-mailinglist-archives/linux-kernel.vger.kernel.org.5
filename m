Return-Path: <linux-kernel+bounces-70075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E896F8592B8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19B50B20AD0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5C17F7D9;
	Sat, 17 Feb 2024 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jP09jcbj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62F87F484;
	Sat, 17 Feb 2024 20:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708201807; cv=none; b=tGTin1vQ4MJBE+4SEV0UqQRs3Ohagwz0FipPbicINJIiXsNh5q7tHQaz7vOrIP9FZEGjGjUcqvnI0p2d4y38Bb8j06plg0TBXv+xwGnpt6EBnT+E9RicUTb0+4mG9YYckgNFTOpCf7qMyXWC+c+GPjFayRYV230aA+toLUQoc9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708201807; c=relaxed/simple;
	bh=NnCkYxT8FeGPtNSEwGVJYueBaB6b4r61V5EUsPERHmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Huo72p7Vua/xavs455AUq8MvmoVqffa5iD/vSIaYD1Pp5SlDNUddv9IDOC2osWNkfmjXFpM9JnTeHs3LWFCLmdKlgZjMsT4/J0qfdojgjQDE5ySp61AZ1E5dcF1yyVoUkJjjmDWrIaEdAd9q7ZEwNf0pJc8szMMEQwnPup8pI+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jP09jcbj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE1EC433F1;
	Sat, 17 Feb 2024 20:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708201807;
	bh=NnCkYxT8FeGPtNSEwGVJYueBaB6b4r61V5EUsPERHmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jP09jcbjLBGTLHHcaVM5/o3gafLIg0WDbIJxmF+p9IYlLS/7k+bLQfp1CvRwhu2IR
	 eP+MRgKEiMBvX/P3WLvtLFjU9GCIlq63bcq2Oag2eYzwz2s6j4JNCDNetncAwSGbtW
	 SpS+xs17G18YLTd+vSwo8vSI+IZqUHwhTwPYqonM4YIRy+Bqce0MFuGBYYKjeVuee1
	 kKlc6zz90rshc7bGyIqyPK8/OqAf8eUhZYynb1JJJU17MUtCRZN/BPMH5eoiVjK/8D
	 3uB3U/XfSOYlYcmPWzBwjeyXI/f2vEjoX9bFMwnDUbHx4/IMReLkYDH1wLfGszrXr5
	 PZ3ky0VGgq1Hg==
Date: Sat, 17 Feb 2024 20:30:03 +0000
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
Message-ID: <20240217-studio-cytoplast-ca99a55e7a36@spud>
References: <20240214092504.1237402-1-naresh.solanki@9elements.com>
 <20240214-trinity-delouse-6dcd0b046895@spud>
 <0f1665e5-bae1-4a17-a976-cc225a28dad3@roeck-us.net>
 <20240214-dimly-wife-5b6239d4adec@spud>
 <b306a27e-505e-43d4-aaf8-ab31284a3396@roeck-us.net>
 <20240215-wildfire-dotted-a561e86a6054@spud>
 <9cc60b90-329b-4065-a3c8-74c208964d45@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D2aeU6KpYyLQU2Qj"
Content-Disposition: inline
In-Reply-To: <9cc60b90-329b-4065-a3c8-74c208964d45@roeck-us.net>


--D2aeU6KpYyLQU2Qj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 07:57:43AM -0800, Guenter Roeck wrote:
> On 2/15/24 03:48, Conor Dooley wrote:
> > On Wed, Feb 14, 2024 at 05:17:04PM -0800, Guenter Roeck wrote:
> > > On 2/14/24 11:55, Conor Dooley wrote:
> > > [ ... ]
> > > > > > Why "vout0" if there's only one output? Is it called that in the
> > > > > > documentation? I had a quick check but only saw it called "vout=
".
> > > > > > Are there other related devices that would have multiple regula=
tors
> > > > > > that might end up sharing the binding?
> > > > > >=20
> > > > >=20
> > > > > Primarily because that is what the PMBus core generates for the d=
river
> > > > > because no one including me was aware that this is unacceptable
> > > > > for single-output drivers.
> > > >=20
> > > > Is it unacceptable? If you're implying that I am saying it is, that=
's
> > > > not what I was doing here - I'm just wondering why it was chosen.
> > > > Numbering when there's only one seems odd, so I was just looking fo=
r the
> > > > rationale.
> > > >=20
> > >=20
> > > Given the tendency of corporate speak (aka "this was a good attempt" =
for
> > > a complete screwup), and since this did come up before, I did interpr=
et
> > > it along that line. My apologies if that was not the idea.
> >=20
> > I'm not gonna go and decree that "vout0" is unacceptable, if it was
> > called that in documentation that I had missed or was convention, I was
> > just gonna say "okay, that sounds reasonable to me".
> >=20
>=20
> "convention" only if lack of awareness how regulators are supposed to be =
named
> is a convention.

They're "supposed" to be named whatever the binding says they are named,
but as we've discovered none of these devices actually have bindings
that allow regulators in the first place. I think they should be called
whatever they're called in the documentation for the device, which in
this case was "vout".

> > > Still, I really don't know how to resolve this for existing PMBus dri=
vers
> > > which do register "vout0" even if there is only a single output regul=
ator.
> >=20
> > I had a quick look at that series, none of the devices that I checked
> > out there seem to have documented regulators at all. Some of the devices
> > were only documented in trivial-devices.yaml. Relying on the naming of
> > undocumented child nodes is a bug in those drivers & I guess nobody car=
es
> > about dtbs_check complaints for those platforms. The example that was
> > linked in the other thread doesn't even use a valid compatible :(
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts?id=3D8d3dea210042f5=
4b952b481838c1e7dfc4ec751d#n21
> > I guess it uses the i2c device ids to probe on that platform, or have
> > I missed something there?
> >=20
>=20
> I think that is correct. If I recall correctly, the I2C subsystem no long=
er
> searches for compatible drivers by only looking at the device id in the
> compatible node, so I guess one has to list "lm25066" instead of "ti,lm25=
066"
> as compatible to get a match in the i2c subsystem. That is of course
> completely wrong.

If the driver is probing based on i2c_device_id matching, is it correct to
use DT to probe the regulators? (I don't know, that's not some sort of
rhetorical question).

--D2aeU6KpYyLQU2Qj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdEXSwAKCRB4tDGHoIJi
0gOYAP9P80PNTgJyncyBUxpU84sRQkXT+6oYERv+nytj6zTs+wD9FlnhbvwEkPy6
0gZXsU7X2UrgvG2+rck9hf5RjIvO9Q0=
=nN+t
-----END PGP SIGNATURE-----

--D2aeU6KpYyLQU2Qj--

