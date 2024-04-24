Return-Path: <linux-kernel+bounces-156076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 674E78AFD99
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2506B282D41
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E695221;
	Wed, 24 Apr 2024 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVSFrqY0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295964C79;
	Wed, 24 Apr 2024 01:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713921006; cv=none; b=PrI7JMK0RhabDF3KmdEFmxihY6ODcvLcVrdFsTCknpelN4fa+j1CMzOTtlLHd1776EpNkYR9AaFhzOHiq7TgrUex1SONsAw6h3oM1qSJDq6+5TQTqO82XhftGzIvQeIRGx+1jVvL8tiZBEj57cQnrLfgKaAcYjRJZbTYNqc74os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713921006; c=relaxed/simple;
	bh=AWv2VsZOJ7kzWIisS22KXSQm6oWtn2t9d7lEq4N4gdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGh75kCt7oR3VJ5S6j1eeziUdU/jaamhVs0LpMlKRsQjEMQ7N/n2xRrXv4y8QtqQJ8cTQluEvB2BVf/FzC88EtMNPSI3+P19Pn5Q4TvDRqe/EyJRZXfR94SmP5caOE8UBP+IXzE+tM16HaxnC1TausVF9UVRFJfkrgIfDDPxFIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVSFrqY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD40C116B1;
	Wed, 24 Apr 2024 01:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713921005;
	bh=AWv2VsZOJ7kzWIisS22KXSQm6oWtn2t9d7lEq4N4gdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dVSFrqY0ZaR2yPQtuVIAGuOC+tb64efoP80Lju9G3QsUqgmThczfbGXCXw2MKYldO
	 BocodyAZfzXEe+Js5Rn3ZTPc9Si24wJXu2sIVDMlc9pf/SvMyEyT/cH1zxa22/8tmw
	 8rHWpPFX9/M8/6TxvpIMywWK6pblfvjBRVGzrVU72lPJsKDDbY4y7aru1TcZap0dU5
	 rcgoItHWdKMLc1VTsbzBh1HQTriKV84MINLhTuiBsEFcZnh65i4iAQYM8RuzZJU5ZI
	 b4zbxAG3vnzjeSA+EYsJ/Wnz+7Jwe/XWACa6CwMKD8gzPDicIOo0AN2OEMP+yyYxI2
	 jCnUtKYyenbsg==
Date: Wed, 24 Apr 2024 10:10:02 +0900
From: Mark Brown <broonie@kernel.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 2/2] Documentation: process: Recommend to put Cc: tags
 after cutter '---' line
Message-ID: <Zihb6tSWTF_an5gY@finisterre.sirena.org.uk>
References: <20240423132024.2368662-1-andriy.shevchenko@linux.intel.com>
 <20240423132024.2368662-3-andriy.shevchenko@linux.intel.com>
 <871q6wrw12.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eHHhEKhDjIo3qvrb"
Content-Disposition: inline
In-Reply-To: <871q6wrw12.fsf@intel.com>
X-Cookie: TANSTAAFL


--eHHhEKhDjIo3qvrb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 05:30:49PM +0300, Jani Nikula wrote:

> The Cc's on the mailing list archive are harder to dig up, and do not
> accurately reflect the same information. A lot of patches get sent with
> more Cc's in the mail message than in the commit message.

These days with b4 and lore it's pretty straightforward, especially with
subsystems that include a message ID based link to the discussion when
applying the patch - you can just grab the original discussion with a b4
mbox command. =20

--eHHhEKhDjIo3qvrb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYoW+oACgkQJNaLcl1U
h9BKYAf/XQhM385YGlm7a5BVnIggeGCeYY6QPYeIwezN0DSdZ53V3LsYPmPVxABH
q8UQU1quCpPX+MfRCulGa/gIDO6ciaiqgTnGwe1G+wt+1T/Xwmgg3etqUkDU9SuW
iwPiLv5abSeUi0KBjhQ3/0IDiK9Eo0IbUffK2rwjO+xlBmM+MgRZlv+zF4ytdMzR
1Tu5MaxKYpbm/QZK45HffL4iuVSi6Pdpbkqi8nvpVrGwMoULn7iZEScYhnamO7C8
scgVOVkDsfEytTq/pxaGuOBxkbdx+c3dedJhqDKMkzlxGCSgJIZF+3174M3RZndU
GuahmmH2nWAU3QFgDlWb5OH6Hf4AwQ==
=UTnu
-----END PGP SIGNATURE-----

--eHHhEKhDjIo3qvrb--

