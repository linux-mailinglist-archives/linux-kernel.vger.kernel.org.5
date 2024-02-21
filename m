Return-Path: <linux-kernel+bounces-75439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5154285E8B2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A48F2826A7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975B18615C;
	Wed, 21 Feb 2024 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0X4C3LO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39FD83CB2;
	Wed, 21 Feb 2024 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708545728; cv=none; b=cskNKH4+yx9/oDlj65o75Qeo6IakZd0l0oq4FmUBj9OTWL03CaULdYwdfIBwmmn6mUqdPrx9k37QLVAsF8R9PKfW/OMCF71cXTzYZR2hUf08X7NLFrhRh+r7c3tcwNDfA5jh3ebdvq0/qK+asAAoi13IZTNCJ4jidrs5lMPnK+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708545728; c=relaxed/simple;
	bh=4sSjUaJAvAvU+yuX/UH8v6iibvf0J12G4JsS+RnhCzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hm/zFiJLkXGCmPpK3EcyTGlQvgRkfw4ihw0QZ8AfRgLVYqeztH73av7NrGDSqBwZ03O8e/ICdyHMZn2CUOG074Usx76lT8F4LyBFrQljxUXEr52IXY8Vp9WAGZYLoYko0AbLpCw2Alu4wuCPvVvg1kgcBE49N9u2IynbC59FlHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0X4C3LO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A58FC433C7;
	Wed, 21 Feb 2024 20:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708545728;
	bh=4sSjUaJAvAvU+yuX/UH8v6iibvf0J12G4JsS+RnhCzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N0X4C3LOH67LeZC75ydNa+rfp5fm30GBlET+Wwr6rl1fNiY+tL2rd3YNqWS5ZxC33
	 pRUBGfdfZNbZ3AJflyl7SKbZR9nQICO2Hueny/uAzsfa1xkKr3n6IVMB91mmalPY9j
	 r7H7VZ66CDpxTCkdmthlHOvj/6765Ubkw0dDZxG6fpOBzZb/vzwecv6FmVT7mFL8S6
	 5xJJieLmViqIzXetdOwNUetHbElBVaenr5++rn+PeWRKSefGz6QspEqL4tkp6G0L5R
	 gJbJh80Bn/L22KLCTuurAOPz0J657/ikpsfqtjQSxGZ8qt71kMueJY+bqhvLcTSrUt
	 WWcRTVU01tGGg==
Date: Wed, 21 Feb 2024 20:02:02 +0000
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
Subject: Re: [PATCH v7 2/2] dt-bindings: rtc: add max313xx RTCs
Message-ID: <20240221-sputter-tinker-48ed252e0a0a@spud>
References: <20240219221827.3821415-1-chris.packham@alliedtelesis.co.nz>
 <20240219221827.3821415-3-chris.packham@alliedtelesis.co.nz>
 <20240220-unified-payback-13b0964c8c29@spud>
 <021800f9-c81c-41fb-b907-5cb27a8854d2@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B9ELagnuuN1Vwj6H"
Content-Disposition: inline
In-Reply-To: <021800f9-c81c-41fb-b907-5cb27a8854d2@alliedtelesis.co.nz>


--B9ELagnuuN1Vwj6H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 08:11:13PM +0000, Chris Packham wrote:
> On 21/02/24 08:21, Conor Dooley wrote:
> > On Tue, Feb 20, 2024 at 11:18:24AM +1300, Chris Packham wrote:

> > The one thing I do want the comment on is the number of examples.
> > I don't really see what we gain from having 3 - I'd roll the clock
> > provider example into with one of the other ones I think.
> The 3 examples are an artifact of me combining the in-flight max313xx=20
> series with the one that landed. The clock output is only valid for some=
=20
> chips but that's probably just a matter of picking the right compatible.

Yeah, I think you could collapse it in, if you modify the compatible
appropriately.

Cheers,
Conor.

--B9ELagnuuN1Vwj6H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdZWugAKCRB4tDGHoIJi
0lNjAP0Y1ftsyNZJ4jgRn5i4R/44xcHG7gHpsUafYTdx6vCcrgEAqGcNnae8VN2n
t+EY+K/WpmW6SUYPoZhTtso5WdqfIQE=
=ldv+
-----END PGP SIGNATURE-----

--B9ELagnuuN1Vwj6H--

