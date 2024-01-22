Return-Path: <linux-kernel+bounces-33822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D65836F03
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18378292425
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF18F55C1F;
	Mon, 22 Jan 2024 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzn55LXj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5761E896;
	Mon, 22 Jan 2024 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944642; cv=none; b=o+/PR+APbzWV2dzzxsABPxNohmDTRVN46lP/E4fMwGFEiv7evfNbxERWHta9W4OyApa0NLFsHVv4J53WG6ahYA3kVrODSlJzHUgvDkzhKOkjrwhhib8ukgmtv/jA6fx5VOKiv47KLWW5/0PtTGO90Hd2qp6Hp0KQWbPLmVyvWbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944642; c=relaxed/simple;
	bh=mchknaq5YkDrWaP+ZwY4WqGhaeuC6EUhgRpZtphYFXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oybxy9akOgqW76/A1GCeK/Jc1xLTHxNdIDtW1Cs7GF9xObO6IaNqJoTazVxGcxbRvL543gVaha1ezcgeJN8xRypZW8qJ/FeWK50tWcDQ8UZGyer4QeaTOn6lCtKZ3q1ZXaWF5BWEsRtIrBHCPX0tZ5dN+hGJ9E1PKGkVrMOn2Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzn55LXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390B7C43390;
	Mon, 22 Jan 2024 17:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705944641;
	bh=mchknaq5YkDrWaP+ZwY4WqGhaeuC6EUhgRpZtphYFXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uzn55LXjVnN7YbqfMAImR8qdEjtkFO5wZa1Y8nCqo0/cpWXpry3Le9uF0LI5keClk
	 r+cRD+yFQEXSQ0txJiKm40ADu/w2A8S7fYNEyHrHZ2OdGv9livWQkPwMzGSaqg5CYn
	 UHBmSKQOsfU8a2O/RIGT8PlNl7qAOYgtsalk2q2Etfdhr+zvXmkEtnBoUgnZj9RrUX
	 4TTPZq71OSuLBZDGxXC+3A8M5GZPA2ytp+I1+7/WCOs76KoA5UsSuB9cPyl/ScPIjm
	 GtS+XACdsuh9Gf5NvLiQyvAt1UUKNMJdJVngQi3mPmoaPUua8YfTdQwmbL2H92p64o
	 n/S2KXpLhIaGA==
Date: Mon, 22 Jan 2024 17:30:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Romain Naour <romain.naour@smile.fr>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	tony@atomide.com, lgirdwood@gmail.com,
	Romain Naour <romain.naour@skf.com>
Subject: Re: [PATCH] regulator: ti-abb: don't use
 devm_platform_ioremap_resource_byname for shared interrupt register
Message-ID: <1b2b5afc-308f-48bb-924a-2c29371abfc9@sirena.org.uk>
References: <20240122170442.729374-1-romain.naour@smile.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fLVcmu4sGIFI8Iwp"
Content-Disposition: inline
In-Reply-To: <20240122170442.729374-1-romain.naour@smile.fr>
X-Cookie: Nice guys don't finish nice.


--fLVcmu4sGIFI8Iwp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 06:04:42PM +0100, Romain Naour wrote:

> We can't use devm_platform_ioremap_resource_byname() to remap the
> interrupt register that can be shared between
> regulator-abb-{ivahd,dspeve,gpu} drivers instance.

=2E..

> The commit b36c6b1887ff (regulator: ti-abb: Make use of the helper
> function devm_ioremap related) overlooked the following comment
> explaining why devm_ioremap() is used in this case:

> /*
>  * We may have shared interrupt register offsets which are
>  * write-1-to-clear between domains ensuring exclusivity.
>  */

I have to say that I wouldn't infer from that comment that there is any
reason why _byname() won't work - one would generally expect that a
get_resource_by_name() followed by an ioremap() of that resource would
be equivalent to the combined helper.  Based on the commit log here I
frankly have no idea what the issue is.  You should also add something
to the code which makes it clear what the issue is so the same
conversion isn't performed again, assuming that the fix isn't in the
helper.

>=20
> Fixes:

You're missing the commit here.

> This partially reverts commit b36c6b1887ffc6b58b556120bfbd511880515247.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--fLVcmu4sGIFI8Iwp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWupjwACgkQJNaLcl1U
h9AYCQf9GqCmATajujQku7+2xQjUQrrWF5EEd4pwN21iJ9zY7BTfqDU6T5u05IUn
PO6VW3mCs1fMkUKsmLYz8TfoDBNWNxa3CivN1oCopBmxPZT204vOrA7QUPx35NFr
Yn1N9U8XWu98yayfB2gTx9zuSW/IlPWRUnPXpzKGJMV3X7Cx/ZvGrelxeWG3DPWA
PFh4ftak5pgD5iUMFXc9cyuoRpY9gLhrbRq6kYPTVoiD8KjZ1NK3CNhk6O7ql98Z
9heSxGBFNtJgZycp72zPI8fqB/3KA6xgnVw7VL/M4SzOIVHa5LxTDB7Af3F7gOOu
uf2Ik+3X7iP/TxZ9NFuWynB9BtUG3Q==
=L5mv
-----END PGP SIGNATURE-----

--fLVcmu4sGIFI8Iwp--

