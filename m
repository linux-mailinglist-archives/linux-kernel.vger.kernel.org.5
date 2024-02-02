Return-Path: <linux-kernel+bounces-50548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB54847A8F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C1D1F22C2D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D73433D3;
	Fri,  2 Feb 2024 20:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/YGcjsy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054A03CF5A;
	Fri,  2 Feb 2024 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906274; cv=none; b=bte1ic15zOpiuq1RUYR+RUKGD9id0+DXCpADoYQUA0BaVu+FyfcSca4A+lHtXJRz5BeozQrxM7huLZ3LLgVQcTgeE6uLmDnAm7Yesq7Q7KwrtBU+uzRu9sNXs7oPn0V+15qs653OTye512aBcoVhKopWUavWbtd8O/rIr5V2IQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906274; c=relaxed/simple;
	bh=DnL2BYtNo/BWxPSTLX3y8QEL2Bemtf/eP6XUte/NEzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHd6IEm3mJ5hY7Ha3QQZtV99EW1Q6x/eWdhfMIueB7mryE7krtdQLV/Z0Ue3mVVMDdSyDiinB3b8PlFB3Z0jOYlzDfOmm4qijvxfKIxjzWgfaaA4BAJ3tfKAiID26c5RDhpsWerkeLUpHY/q0WiZo7MpEXBFLAshmLLn/Jh1XcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/YGcjsy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B64EC433F1;
	Fri,  2 Feb 2024 20:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706906273;
	bh=DnL2BYtNo/BWxPSTLX3y8QEL2Bemtf/eP6XUte/NEzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/YGcjsy9+T0hM405wkxqUVVqDv7+yW4JrrYa0UoTIsf9vWnbn02mfigqWmAEFids
	 +KybpZVBaN1BHiqOV/Ad0K6HSjf4IRCZpqb/PyEF8Jld+VMDO+zxG86YeNXWLJhQKg
	 TA7pVpz4ZWE6V52msvob7vF2DkJdVgIFlHG02iyAXjFiiiE7OVD0j3YJhzmRqunTLA
	 FHUlF7ja9hub9WmlrRwJDPGPXFsKRYUE62cREYKuLroQ+cVgKsRquaGJaNBGui9wWn
	 nTbME8ntgSBP3BJ+m0tuOerjKdp+5ek/jeQqHZTJXRIbL0KAAVcreWDBd4rUnQHtpI
	 iWwAI3tMEEH4w==
Date: Fri, 2 Feb 2024 20:37:49 +0000
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Charles Hsu <ythsu0511@gmail.com>,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: trivial-devices: sort entries
 alphanumerically
Message-ID: <20240202-bully-matron-f8bc086cfc74@spud>
References: <20240201075805.7492-1-krzysztof.kozlowski@linaro.org>
 <5461a237-1df4-4077-86ef-e9ff6ff17e27@roeck-us.net>
 <20240201-silliness-unfair-265a0d896377@spud>
 <20240202202158.GA1007609-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qID5frt9zuGEe04y"
Content-Disposition: inline
In-Reply-To: <20240202202158.GA1007609-robh@kernel.org>


--qID5frt9zuGEe04y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 02:21:58PM -0600, Rob Herring wrote:
> On Thu, Feb 01, 2024 at 06:32:09PM +0000, Conor Dooley wrote:
> > On Thu, Feb 01, 2024 at 05:25:13AM -0800, Guenter Roeck wrote:
> > > On 1/31/24 23:58, Krzysztof Kozlowski wrote:
> > > > Sort entries alphanumerically.  This was a semi manual job with hel=
p of:
> > > >=20
> > > >    cat Documentation/devicetree/bindings/trivial-devices.yaml | gre=
p '    - ' > old
> > > >    cat old | sort -n > new
> > > >    diff -ubB old new
> > > >=20
> > > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > >=20
> > >=20
> > > Acked-by: Guenter Roeck <linux@roeck-us.net>
> >=20
> > z sorts before a, please fix in the whole file.
>=20
> I don't follow this comment.

I was just taking the piss out of myself, dw bout it.

> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > Thanks,
> > Conor.

--qID5frt9zuGEe04y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZb1SnQAKCRB4tDGHoIJi
0oWDAQDMtfrz1OyRUefGpWzVlTVAFWBhaFNc5aCVu+1RG7aIVAEA7oykg3S4shBG
ivAEvFgW8H8WzOonxTz6i1cRuYud9wc=
=R56H
-----END PGP SIGNATURE-----

--qID5frt9zuGEe04y--

