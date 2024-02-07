Return-Path: <linux-kernel+bounces-56498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC0D84CADA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3919E287996
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB5C76913;
	Wed,  7 Feb 2024 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLGJNQQ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF28768F6
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707310141; cv=none; b=g20GtMUrmtMUhQDR9WiAvgaxZqZ0Ypuqss3Lg9/4OG1n5f6FpEoLP0hIS7E8Rrax8fDsJ1upmRA/2NPZ01cmaadkibkbkZTgNuChCp+0G3fqD+YbGTqemflFqu0XFG4WOKJx1DMY10O9MQV9P8jwoRujHpKyD99zaeGbiJ0oGFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707310141; c=relaxed/simple;
	bh=kpCKC3B/98YpyoP171CggRXhut1sdettn+WPRc7jzQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5hES3I/IQWo+f6s6HV65D4F8+Jtp/vosnylMmE8IqLvvRVqsDuppXM3y8ythSSIUo5otI5cm/Mxkd537JVyEfqnsvI30RD8ylFqQVvXEXFLKJRbPrVq4JqfT6qi8F+jeC8qlzaCRCAnIveX3S8DTymc6re8NDYOS1Ww6rYIpds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLGJNQQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB8DC433C7;
	Wed,  7 Feb 2024 12:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707310141;
	bh=kpCKC3B/98YpyoP171CggRXhut1sdettn+WPRc7jzQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RLGJNQQ5EaQggFyKDJZDZ+vFCX0Le2fYgcxiSMcrU5YTTdBL5yjnpocSDH+eIBNl1
	 3/3dRI9h3b04yEcdwS6h9gJFDXc1vXCaABN0PjpHlE3Alm8Bwwk+LW1VHm1mLiuaCQ
	 9H8T64fcEiRriX+krSy18+3zXpt+zJqCexBSabV63gDPM+da6jIk2WUdl4e7itxmM1
	 1TbSwS5BuniBUdzGzrIL7c92yzJrRzVA54ETJYu7NE+9w52DlcnZXasV0/nWYFX6P9
	 nxXRC6HWZxt1V1yrvgc4NLaSl7mrFTdjvz0RRBgUZU0NxcJDPJISH5UTzbtp/+9D8S
	 OTh4DGVQFml9g==
Date: Wed, 7 Feb 2024 12:48:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sve: Document that __SVE_VQ_MAX is much larger
 than needed
Message-ID: <ZcN8OltRDUlDlTHQ@finisterre.sirena.org.uk>
References: <20240206-arm64-sve-vl-max-comment-v1-1-dddf16414412@kernel.org>
 <ZcNxJ56+bvcUTGlT@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ELNIFKK91+/JknQx"
Content-Disposition: inline
In-Reply-To: <ZcNxJ56+bvcUTGlT@e133380.arm.com>
X-Cookie: You might have mail.


--ELNIFKK91+/JknQx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 07, 2024 at 12:01:43PM +0000, Dave Martin wrote:
> On Tue, Feb 06, 2024 at 04:27:01PM +0000, Mark Brown wrote:

> > +/*
> > + * Note that for future proofing __SVE_VQ_MAX is defined much larger
> > + * than the actual architecture maximum of 16.
> > + */

> I think that putting shadow #defines in comments in UAPI headers is a
> really bad idea...  is this a normative statement about the user API,
> or what?

Well, the only reason I'm mentioning the constant here is that
__SVE_VQ_MIN is defined too and has a perfectly good value, things look
a bit neater with a shared comment block.  I'm not sure there's a hugely
meaingful difference between having a comment adjacent to a named
constant in a header and one a couple of lines away that mentions the
constant by name.

> My concern is that if we muddy the waters here different bits of
> software will do different things and we will get a mess with no
> advantages.

> Portability issues may ensue if userspace software feels it can
> substitute some other value for this constant, since we can't control
> what userspace uses it for.

I don't think we want people using this at all, ideally we'd remove it
but it's in the uapi.

> Would it be sufficient to say something like:

> /*
>  * Yes, this is 512 QUADWORDS.
>  * Never allocate memory or size structures based on the value of this
>  * constant.
>  */
> >  #define __SVE_VQ_MAX		512

I think the fact that this vector length is more than an order of
magnitude more than is architecturally supported at present needs to be
conveyed, it's perfectly reasonable for people to not want to do dynamic
allocation/sizing of buffers in some applications and the above sounds
more like stylistic guidance about using dynamic sizing to improve
memory usage.

> Though comments might be better placed alongsize SVE_VQ_MAX at al., in
> ptrace.h and sigcontext.h rather than here.  The leading __ should at
> least be a hint that __SVE_VQ_MAX shouldn't be used directly by
> anyone...

Yeah, the multiple layers of indirection aren't helpful here.  We
probably need to comment it in both places TBH.

--ELNIFKK91+/JknQx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXDfDQACgkQJNaLcl1U
h9DuvQf+P75jQ/P+a7LiKl/CWZZ9nAD7CK6hy2bySrvt3Cc6OPiHNPErFwrAEApn
5uJ5WxuYCKGm5+FlxXUUMXffizaKRe2J4P3kyoBl1gKyODDAY/Iz8HrsOuLZr0YB
pU5datvOip8ppZ+P1CcKU3+xn3moyENmTdDW0b3wxOR8d5pGoTacE4MPt526Nh3X
1Jh9/fIjFhWq3RN6wbZ6XdWMaowcvol59tphB/lhubOO04yoAm6q8MhZUfXB9h1X
1KEaw/4AbLW1OJOqEjdpOp5GJFpwhyq8m5V3hjK377TezXhlreytXc0SXhS0p4Ln
yPt4cehy5zjHbNi8//mQVmWN35YHEg==
=B1CU
-----END PGP SIGNATURE-----

--ELNIFKK91+/JknQx--

