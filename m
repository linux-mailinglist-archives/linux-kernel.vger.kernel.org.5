Return-Path: <linux-kernel+bounces-158849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1DF8B25C6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646592816C3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B1314D281;
	Thu, 25 Apr 2024 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNxIOtmq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D746414C585;
	Thu, 25 Apr 2024 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714060605; cv=none; b=BttVKiEGGCto85DL/XXEI9gYQE/v/iQn+Q3BP9Ws81KsOX7lj7FTD+99Vk5ZmnlCv8/teQ2oK/MtpclB4RYIzKhjHanUkqrL9Wg2TqRppr6999rWVX3FhjfIuv3QtnjqYxC8oXqcr1OLNQ/imYmzTJGOhBd3CwAEzSVV7zSF198=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714060605; c=relaxed/simple;
	bh=WuAKIKma+/FB2Ips3osw/A9+g1o7pziDj656fCihlRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVZbJHcB5AKVekkP7ddweX8yXF7QXDskAMS/2qGapO5rsPMxhCNocQH9lUsNUv4y0JWWoVMh0IC/1nMGVsZy7kkqQe5ncqsp4euauQ+brcS4LyxlB8+/RKLaGtw9u6QJ7NRXFJ4xvt9lt9E0vUVnm9BuAvsU59c5caalg1NsFnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNxIOtmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5E7C113CE;
	Thu, 25 Apr 2024 15:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714060605;
	bh=WuAKIKma+/FB2Ips3osw/A9+g1o7pziDj656fCihlRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DNxIOtmq7emZWHtH/3JlkQsF3at92iGgkNSoYSrPm8wOobwWO4i1EtMni59snnjUI
	 +q1xeBYAYqez7sk3EUQfkiUu5rGcNkJs2oZTUXowxfnDU1zZ21qFNhfD+cGkybmnsK
	 0A/ewFfjnACiOV1MH7JuVhF2VkIj96GTdcd8EEE5VsmEIgC5zEdhxl9uHQ0aGyUJyQ
	 vmzEGxaAWU287XjfIVSl7sRe4vwiX9m4kP51+CSI9Be6/LCdVj7ncCMW+aJHbwpt/C
	 Yy5KhGqVwrZwUhNtL6NDa7wordwOccl46qLaMB721f5HnZvfyENhgM9fDv5Va5Pte5
	 a46e3g2BalYOQ==
Date: Thu, 25 Apr 2024 16:56:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Chanh Nguyen <chanh@amperemail.onmicrosoft.com>,
	Chanh Nguyen <chanh@os.amperecomputing.com>,
	Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Justin Ledford <justinledford@google.com>,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	Open Source Submission <patches@amperecomputing.com>,
	Phong Vo <phong@os.amperecomputing.com>,
	Thang Nguyen <thang@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: hwmon: max31790: Add
 maxim,pwmout-pin-as-tach-input property
Message-ID: <20240425-enigmatic-portly-c2282fc1709a@spud>
References: <20240414042246.8681-1-chanh@os.amperecomputing.com>
 <20240414042246.8681-4-chanh@os.amperecomputing.com>
 <13b195e6-cbbd-4f74-a6fa-d874cb4aaa45@linaro.org>
 <065243cc-09cf-4087-8842-bd4394fb324f@amperemail.onmicrosoft.com>
 <d549cf2b-a7fa-4644-8fcb-3c420503ee01@amperemail.onmicrosoft.com>
 <20240423-gallantly-slurp-24adbfbd6f09@spud>
 <ab5cfd8c-0e88-4194-a77e-5ffbb6890319@amperemail.onmicrosoft.com>
 <396b47f5-9604-44ab-881f-94d0664bcab8@roeck-us.net>
 <b79b5323-196f-41bc-b47a-d350c49d769a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nEP+ljWS/1R7JDAt"
Content-Disposition: inline
In-Reply-To: <b79b5323-196f-41bc-b47a-d350c49d769a@linaro.org>


--nEP+ljWS/1R7JDAt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 05:46:02PM +0200, Krzysztof Kozlowski wrote:
> On 25/04/2024 16:05, Guenter Roeck wrote:
> > On 4/25/24 03:33, Chanh Nguyen wrote:
> >>
> >>
> >> On 24/04/2024 00:02, Conor Dooley wrote:
> >>> [EXTERNAL EMAIL NOTICE: This email originated from an external sender=
=2E Please be mindful of safe email handling and proprietary information pr=
otection practices.]
> >>>
> >>
> >=20
> > The quote doesn't make much sense.

The reply is to me questioning part of their earlier reply:
	> I think a vendor property is suitable for this purpose. It is only avail=
able
	> on specific MAX31790 fan controllers and not on other fan controller
	> devices. So I think we can't use the "tach-ch" in fan-common.yaml.

	Can you explain why you think that only MAX31790 fan controllers are
	capable of an arbitrary mapping of PWM outputs to TACH inputs?

> >=20
> >> Sorry Conor, there may be confusion here. I mean the mapping of the PW=
M output to the TACH input, which is on the MAX31790, and it is not sure a =
common feature on all fan controllers.
> >>
> >=20
> > I think the term "mapping" is a bit confusing here.
> >=20
> > tach-ch, as I understand it, is supposed to associate a tachometer input
> > with a pwm output, meaning the fan speed measured with the tachometer i=
nput
> > is expected to change if the pwm output changes.
> >=20
> > On MAX31790, it is possible to configure a pwm output pin as tachometer=
 input pin.
> > That is something completely different. Also, the association is fixed.
> > If the first pwm channel is used as tachometer channel, it would show u=
p as 7th
> > tachometer channel. If the 6th pwm channel is configured to be used as =
tachometer
> > input, it would show up as 12th tachometer channel.
> >=20
> > Overall, the total number of channels on MAX31790 is always 12. 6 of th=
em
> > are always tachometer inputs, the others can be configured to either be=
 a
> > pwm output or a tachometer input.
> >

> > pwm outputs on MAX31790 are always tied to the matching tachometer inpu=
ts
> > (pwm1 <--> tach1 etc) and can not be reconfigured, meaning tach-ch for
> > channel X would always be X.

Are they? Granted, I probably didn't read this as well as you did, but
figure 3, 4 5 & 6 seem to show mappings that are not 1:1, with PWMOUT1
controlling several fans, each of which report back via a different tach
channel. I think the fan controller binding accounts for this though:
the child nodes would reference the same PWM provider but have different
tach-ch values.

> >=20
> >> I would like to open a discussion about whether we should use the tach=
-ch property on the fan-common.yaml
> >>
> >> I'm looking forward to hearing comments from everyone. For me, both ta=
ch-ch and vendor property are good.
> >>
> >=20
> > I am not even sure how to define tach-ch to mean "use the pwm output pin
> > associated with this tachometer input channel not as pwm output
> > but as tachometer input". That would be a boolean, not a number.
>=20
> Thanks for explanation. So this is basically pin controller function
> choice - kind of output or input, although not in terms of GPIO.
>=20

> Shouldn't we have then fan children which will be consumers of PWMs?

In this case, the max31790 has the PWM hardware, so it would be the
provider...

> Having a consumer makes pin PWM output. Then tach-ch says which pins are
> tachometer for given fan? Just like aspeed,g6-pwm-tach.yaml has?

=2E..and it seems to me like there should be several fan child nodes as in
the aspeed binding you mention here that are the consumers. The binding
as written seems to only support a single fan.

--nEP+ljWS/1R7JDAt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZip9NwAKCRB4tDGHoIJi
0vP1AP4j4+fuNIvolurSpFQaXNehLyhR+uSnou0/9LHPJ1mr9AEA/znEjxTUZQ7d
vWL7Gzplb2kPTy1lhPVh5m0EXqhERws=
=1b3W
-----END PGP SIGNATURE-----

--nEP+ljWS/1R7JDAt--

