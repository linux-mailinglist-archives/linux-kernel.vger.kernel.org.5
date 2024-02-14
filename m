Return-Path: <linux-kernel+bounces-65901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD34F855385
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E6E1F26CD8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F048913DB8F;
	Wed, 14 Feb 2024 19:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPF7r5o8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3CC13B7B5;
	Wed, 14 Feb 2024 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707940532; cv=none; b=qWiyZ1Sl9oYOrS/zkrAbrp/UCfVfRFNOmr7OAM3+d70MF86fZkQYfiFFRfg2strSwaPVg1ZwopdmLVK5jwfhOtuMsO7MR1KE5dcOvtpIJi18ewGOBFUAOZKzVx22LZ2eIVo43tNYHCqrpfWCWSFD+6YEKxUoiqzYDFrhj2B7GDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707940532; c=relaxed/simple;
	bh=aN1RQYhpuVAtEpsc/MudXniLKa3dvmAiLsNZ9i8++FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxfEQ1CGRWj7ULMDEKGQpHgVjVgdTbgQHjRtudkGWMSeo3R5ZdRcR/pZ09NaaEdjP1HfEins+osDuw+cyhbAInkw81fiPjgTU9pqc/p8Cdaf1FVl5Z+jh0Nh/tb8DqL57ChfMQgysTk0Y6vurbwLAbZSeWXHi5+dDmjzABF1ICM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPF7r5o8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B97C433C7;
	Wed, 14 Feb 2024 19:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707940531;
	bh=aN1RQYhpuVAtEpsc/MudXniLKa3dvmAiLsNZ9i8++FQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BPF7r5o8y4H7bDrDpLcEtMHw2F5B4qUrp6FwYfjwuCg/FcXarE+YdrxY69PpTtat9
	 JxJPI2PdTNzOC1wmE2B7cpj3GL2NmnAFGMhFQjtT4C34N4olyB5orZB7XhfHjyy5Wh
	 scfs3njKTQZOU+LywXw1fjBRxl4IIe2dc+hoQgzwaQeN7At17fp1IMFHWQTXM1yDqj
	 aHICeaEL/1iZQSa33XVXUSrPS4g70whSndILPuQgfT1DpOhXfzabSATDF8SBpEN2TW
	 sDNt6VjfQ+r2A/sqMutDNkSZ0cB2cKugqhjsRFOyXyVOGwCy4TEhLQH9r8h1CGn8c9
	 3IUomvF86kyGA==
Date: Wed, 14 Feb 2024 19:55:27 +0000
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
Message-ID: <20240214-dimly-wife-5b6239d4adec@spud>
References: <20240214092504.1237402-1-naresh.solanki@9elements.com>
 <20240214-trinity-delouse-6dcd0b046895@spud>
 <0f1665e5-bae1-4a17-a976-cc225a28dad3@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xG+P4JTtsjcaH+61"
Content-Disposition: inline
In-Reply-To: <0f1665e5-bae1-4a17-a976-cc225a28dad3@roeck-us.net>


--xG+P4JTtsjcaH+61
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 10:48:52AM -0800, Guenter Roeck wrote:
> On 2/14/24 09:51, Conor Dooley wrote:
> > On Wed, Feb 14, 2024 at 02:55:03PM +0530, Naresh Solanki wrote:
> > > Add properties for interrupt & regulator.
> > > Also update example.
> >=20
> > I feel like a broken record. Your patches need to explain _why_ you're
> > doing what you're doing. I can read the diff and see this, but I do not
> > know what the justification for it is.
> >=20
> > /30 seconds later
> > I really am a broken record, to quote from v1:
> > | Feeling like a broken record, given I am leaving the same comments on
> > | multiple patches. The commit message needs to explain why you're doing
> > | something. I can read the diff and see what you did!
> >=20
> > https://lore.kernel.org/all/20240126-fleshed-subdued-36bae813e2ba@spud/
> >=20
> > The patch itself does look better than the v1, with one minor comment
> > below.
> >=20
> > Thanks,
> > Conor.
> >=20
> > > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > >=20
> > > ---
> > > Changes in v2:
> > > 1. Remove TEST=3D..
> > > 2. Update regulator subnode property as vout0
> > > 3. Restore commented line in example
> > > 4. blank line after interrupts property in example.
> > > ---
> > >   .../hwmon/pmbus/infineon,tda38640.yaml        | 28 ++++++++++++++++=
+++
> > >   1 file changed, 28 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,t=
da38640.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38=
640.yaml
> > > index ded1c115764b..a93b3f86ee87 100644
> > > --- a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640=
=2Eyaml
> > > +++ b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640=
=2Eyaml
> > > @@ -30,6 +30,23 @@ properties:
> > >         unconnected(has internal pull-down).
> > >       type: boolean
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  regulators:
> > > +    type: object
> > > +    description:
> > > +      list of regulators provided by this controller.
> > > +
> > > +    properties:
> > > +      vout0:
> >=20
> > Why "vout0" if there's only one output? Is it called that in the
> > documentation? I had a quick check but only saw it called "vout".
> > Are there other related devices that would have multiple regulators
> > that might end up sharing the binding?
> >=20
>=20
> Primarily because that is what the PMBus core generates for the driver
> because no one including me was aware that this is unacceptable
> for single-output drivers.

Is it unacceptable? If you're implying that I am saying it is, that's
not what I was doing here - I'm just wondering why it was chosen.
Numbering when there's only one seems odd, so I was just looking for the
rationale.

> We now have commit 88b5970e92d0 ("hwmon:
> (pmbus/core) Add helper macro to define single pmbus regulator").
> I guess we can update the tda38640 driver to use the new macro
> to register vout instead of vout0.


--xG+P4JTtsjcaH+61
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc0arwAKCRB4tDGHoIJi
0lyZAQDo72m1JTDm3RB2kzIKmBYKf7gk6P+U/7VON1Kjca7/+wD+KDyCgv+ptSlb
2Gv/TNj8JuKGhWht70cIyT72yXA1QwI=
=enKi
-----END PGP SIGNATURE-----

--xG+P4JTtsjcaH+61--

