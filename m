Return-Path: <linux-kernel+bounces-107955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB31880406
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA111C230D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C68B2B9DE;
	Tue, 19 Mar 2024 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+Lu2gnZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0BA3838F;
	Tue, 19 Mar 2024 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870908; cv=none; b=o30+Zl6mxfQWi63UTUPCCiq+OA+XeE0zAN18r4VuGD0X4gchVxN/TJXSsvfsjYYg3OKOkcxZe6pgBBcZxpCj9o85/PC2tTc64+Lo5/Y4hBdAvqGtUF/MDfzIEgVYpEnwj0Xl+pok3QsXBXxyfsuvHXlY8pg9WpZcVVhXT/vFzqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870908; c=relaxed/simple;
	bh=i9Wx1B16rL428tWQhDd0HaROyOOmkti/BIWj0paHtmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hj7F42d2AXs/yTqx/jfa0vo6AFzR4Qg18LiQJCRFs+nCT2Ic+nucK5IsaxQUyAG67M0NrYTv6bH4XoqVptjKzfi5qwRVEIXSZC8pyDip6v81iV+iA7UbJzwIEJFHXGjslq+GpsAYSCFJp8d9Uf9/B/JiJ1ioAX7PcXzX0WNaAnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+Lu2gnZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B343C433F1;
	Tue, 19 Mar 2024 17:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710870908;
	bh=i9Wx1B16rL428tWQhDd0HaROyOOmkti/BIWj0paHtmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+Lu2gnZRUnwSjPGkP4tAZPn9ic1z42vaes3QUEiGaehJFIlBTW76JxkiAUgxVBm7
	 s7S47tbFPTsCnvBx/VqE56CEYMY5ZED2xo8jiDWXHVXZmgUFBqUwPZpn1V3aLMyVhO
	 /jjKHzK5ntW7KLZ2F9jMhYpIBsIk/Unz1Qbz1FVAt2tb3C9uQd1CjdkISwsrYvctV/
	 WtdS2sNb1WBVGhrgHBHofDQ000J/dkvXpPbaEZpmIS3YRD1f1gcuYSPiZMVCLkzCtC
	 XgPpU1YEliVGDvYoflwQONf5bzWKUjBNBqbXclNNWVqe+dJpM9fDjUrUQGM/PLES1n
	 Qek97JB+eHjuA==
Date: Tue, 19 Mar 2024 17:55:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Richard Alpe <richard@bit42.se>, linux-kernel@vger.kernel.org,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	Michael Walle <michael@walle.cc>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: Remove fsl,t1023-sfp in favor of
 fsl,layerscape-sfp
Message-ID: <20240319-fondling-implode-322a9cb570b8@spud>
References: <20240316002026.1808336-1-sean.anderson@linux.dev>
 <20240317-starved-pager-7a81c5045cfc@spud>
 <9daf9c8f-6606-4ff6-8065-6a32fa0d152c@linux.dev>
 <20240318-scarf-startup-64088b1d8d35@spud>
 <fa047914-da03-4234-b48f-eebdf350795e@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nI3bLVs9cY0aY44i"
Content-Disposition: inline
In-Reply-To: <fa047914-da03-4234-b48f-eebdf350795e@linux.dev>


--nI3bLVs9cY0aY44i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 11:48:06AM -0400, Sean Anderson wrote:
> On 3/18/24 11:40, Conor Dooley wrote:
> > On Mon, Mar 18, 2024 at 11:08:00AM -0400, Sean Anderson wrote:
> >> On 3/17/24 11:10, Conor Dooley wrote:
> >=20
> >> > Additionally, should
> >> > they fall back to t1023-sfp? I see that there's already some dts fil=
es
> >> > with these compatibles in them but seemingly no driver support as th=
ere
> >> > is for the t1023-sfp.
> >>=20
> >> I checked the reference manuals for these processors, and all of them =
use TA 2.0.
> >=20
> > Sounds like a fallback is suitable then, although that will require
> > updating the various dts files.
>=20
> Yes, a fallback (like what is done for the T-series) would be suitable,
> but given that these devicetrees have been in-tree for eight years I
> think it would be preferable to support the existing bindings for
> compatibility purposes.

Just cos stuff snuck into the tree in dts files doesn't make it right
though, I'd rather the bindings were done correctly. I don't care if you
want to support all of the compatibles in the driver so that it works
with the existing devicetrees though, as long as you mention the
rationale in the commit message.

--nI3bLVs9cY0aY44i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfnRdwAKCRB4tDGHoIJi
0me8AP0SHieSWI60ybk0My6MtdBu8dEwX2OPXkbv0GS0b/jcAQEA0BMBzGueOCUP
i4nd9SNbLZ1ZChDd/C2pBguwmU1K3gM=
=fj05
-----END PGP SIGNATURE-----

--nI3bLVs9cY0aY44i--

