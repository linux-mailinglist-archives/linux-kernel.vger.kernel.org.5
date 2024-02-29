Return-Path: <linux-kernel+bounces-87230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67AB86D16B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794A32835FA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ADE78272;
	Thu, 29 Feb 2024 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cg1541hv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A9816062E;
	Thu, 29 Feb 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230042; cv=none; b=EFYBPbPSvG3K7GjvgvwKIsmoi+zYz+Yz3ax8mxZChfQ5gFQ/QN3E8eK0+MPwKaVFChG5im5xCgGM/V4bQWzeULD/bJtVLwAeCScu1A3uXhdFbhFXMFxMgAIFLATZ7u6dphNvzk2v9SfOVcfs438ZNimd+V8CR/HNTuQ2A8iKUSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230042; c=relaxed/simple;
	bh=cX2PHbRKLPBHDGWFeHshU8/kZ6O3pk6xNH+MwzuwUqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDRF91VtWrdFw3Be/EhCsNLyx0nhu89GPvAgLKl7OQ6V9k1SGXIEtmTlGg4Ye01RsM9GxLdgZZXYoA06BHD98GrdRQ0gwru6jy7zKB1vY/LdiYZ8yrApwoNhbvCLjM+jQhTGov3rmddB8IevNKOPIU0GbYqQ4qZyTtIhHKkEE54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cg1541hv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF73C433F1;
	Thu, 29 Feb 2024 18:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709230042;
	bh=cX2PHbRKLPBHDGWFeHshU8/kZ6O3pk6xNH+MwzuwUqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cg1541hvCxmc/49oNGiTZXi+uzcb5gnkddG0ZEFtXZNCP/xCLIo0W5wA0Y5BVSTfV
	 1/VAdoDvJwVNAe2Rd4VXy4G/9x2zFlXw5qiMsgABhuSkNERiZHFSMjY8ZlEPhvtGUp
	 mo1pmXwkCq9+Ufu3F9UW5CLqsFRVo1U/3t17NYnbuZIGFczMQQsZ/B9Pcpfox9Vsm7
	 vySAGACLxG2/uFu30N9+l5YoNESW4TY8u0Q8sumLKh2mTIl27gODNBYGroxKtVDk1V
	 2Thqv9jlex0BiX9Eqd7VngEvUFSiJRY5gscioA/zBcHMF0K34bqpFyWvUf2PUek185
	 ZqObIVvPdA8Hg==
Date: Thu, 29 Feb 2024 18:07:17 +0000
From: Conor Dooley <conor@kernel.org>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "antoniu.miclaus@analog.com" <antoniu.miclaus@analog.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"jdelvare@suse.com" <jdelvare@suse.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	"linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH v8 2/2] dt-bindings: rtc: add max313xx RTCs
Message-ID: <20240229-skeletal-ultimatum-27cd91e8d8a8@spud>
References: <20240227010312.3305966-1-chris.packham@alliedtelesis.co.nz>
 <20240227010312.3305966-3-chris.packham@alliedtelesis.co.nz>
 <20240228-embark-rimmed-d81bab3d42b8@spud>
 <bd43a198-6287-40b2-be15-2734c5d2742d@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iR98pNhTE57Kvx2v"
Content-Disposition: inline
In-Reply-To: <bd43a198-6287-40b2-be15-2734c5d2742d@alliedtelesis.co.nz>


--iR98pNhTE57Kvx2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 08:21:35PM +0000, Chris Packham wrote:
>=20
> On 29/02/24 00:58, Conor Dooley wrote:
> > On Tue, Feb 27, 2024 at 02:03:10PM +1300, Chris Packham wrote:
> >
> >>     interrupts:
> >> +    description:
> >> +      Alarm1 interrupt line of the RTC. Some of the RTCs have two int=
errupt
> >> +      lines and alarm1 interrupt muxing depends on the clockin/clocko=
ut
> >> +      configuration.
> >>       maxItems: 1
> > The maxItems: 1 looks odd here when you state "some of the RTCs have two
> > interrupt lines", which makes it sound as if there are actually two
> > interrupts that should be exposed here. If those two interrupts get
> > muxed to the same pin for output I'd suggest that you clarify that here.
>=20
> This may end up changing if I can come up with something that Alexandre=
=20
> is happy with. Basically (some of) the chips have a configurable pin=20
> that can either be dedicated to the ALARM1 output (annoyingly labelled=20
> as INTB) or to a clock output. There is an INTA line that has other=20
> interrupts and if the clock output option is used then it also has=20
> ALARM1. The driver doesn't currently do anything with the other=20
> interrupt sources so as written this needs to correspond to whichever=20
> interrupt output is asserted for ALARM1.

So you're saying that depending on whether or not the clock output is
used, there could be two interrupts?

Without looking further, it sounds like you should be setting maxItems
to 1 if #clock-cells is present and to 2 if it is not. Then if there are
two interrupts provided, the driver is free to configure whatever way it
wants. If there aren't, send everything to INTA.

Am I missing something?

Cheers,
Conor.

--iR98pNhTE57Kvx2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeDH1QAKCRB4tDGHoIJi
0mgUAP968MrAUrLc4/ZPgIL2M9ot1CbzwNP1m69CXgjSTaqhBAEAzgOl8/WsPk83
fJ+Eot7rs9erOG9XK/haG0oYOJlUBww=
=znc+
-----END PGP SIGNATURE-----

--iR98pNhTE57Kvx2v--

