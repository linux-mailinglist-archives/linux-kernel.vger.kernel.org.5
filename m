Return-Path: <linux-kernel+bounces-60125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A058D850027
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F4C1C23537
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F182134B;
	Fri,  9 Feb 2024 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCxOPiz+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376A623B1
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707518353; cv=none; b=hG85VV2VcIoENIHEKno/kss5ao8sTR48FD+D9mz/myRqpwGO3JgMr0iJmjjHpQ2qNNNbaWR7QV9o/F74ASL6ni6ztCrRJWMgMU5LClLwQdPnoTF4vlVzwYlMEjdBibrzrh9l5QksGvvcQ4G6KuYOAOMRjcTgNFNMZ3z2yp6G5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707518353; c=relaxed/simple;
	bh=O2p/iHn6nduWKmXgccSc04pIrLBwIZTcB5QO+VCOtQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3Nqlsh8c3J0rj86Wx9wngMryjQ/PSXtdr/enE63nkqqHMgtPMpW48oW+4061Rae/4/QBDOvYObPW0LOTEMBExHxZ2+U3DHBC0ZzsUJnwiKJ4wffa31iqjTvtrMR29UMdt1GnXd2LQ0Z3+6Tv12ugx/HTOxTtqoyGoADNUTymZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCxOPiz+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E540C433F1;
	Fri,  9 Feb 2024 22:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707518352;
	bh=O2p/iHn6nduWKmXgccSc04pIrLBwIZTcB5QO+VCOtQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aCxOPiz+58Nj0MRMnlc8qGwBRChYvc7v3VGmsFsylAOGan160N5ZquSNZRPrsNVG+
	 Zkp9sPD7r6offhWGeJagvo9/R/4SsZUx6wbe7cjmcR7o3ZwtGaiGyiIeqdM+qqLJlj
	 YSTuEUWyTW5pxG40m+qVwmy0SW4SdP2+OHCai6+epODEyk5tiJCwGtX3EcbFdQlREV
	 70qWeBjpNd8nozuBRR5elho/QkDugvTvKOq75UpM6FpTpYZkKTHSG/SF452RW2Y3Az
	 OSYq8hNonFn72zPrpxizp4CyFm1B0UT4hC0sItSEFGMl0lfSmwsfMX9j1hQXQqYPme
	 8EFoCxDbEqw/A==
Date: Fri, 9 Feb 2024 22:39:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regmap: kunit: Ensure that changed bytes are actually
 different
Message-ID: <ZcapjWTuggJNdV/o@finisterre.sirena.org.uk>
References: <20240209-regmap-kunit-random-change-v2-1-be0a447c2891@kernel.org>
 <7d077da1-e792-4570-914e-5c26de420c43@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="00KVmmgnlwWwSgYM"
Content-Disposition: inline
In-Reply-To: <7d077da1-e792-4570-914e-5c26de420c43@roeck-us.net>
X-Cookie: You might have mail.


--00KVmmgnlwWwSgYM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 09, 2024 at 02:07:38PM -0800, Guenter Roeck wrote:

> This is actually worse than v1 because hw_buf[6] isn't used anywhere.
> Making sure that the values in the val[] array don't match the values
> in hw_buf[6..7] doesn't add any value.

Yeah, I realised after reading your earlier mail.  It's passing for me
somehow.

> FWIW, I had struggled with the re-use of val[0] for two different tests
> (on hw_buf[2] and hw_buf[4]) myself. The only solution other than making sure
> that it neither matches hw_buf[2] nor hw_buf[4] I came up with was to use a
> separate variable for the accesses to hw_buf[4] (or hw_buf[6] in the old code).
Indeed, it was fine with the old code due to not caring about having
different values but we need to generate three values now.

>         get_changed_bytes(&hw_buf[6], &val[0], sizeof(val));
> +       // Let's cheat.
> +       // Remember, the above code doesn't look into hw_buf[2..5],
> +       // so anything might be in there, including the values from
> +       // the val[] array.
> +       hw_buf[2] = val[0];
> +       hw_buf[3] = val[1];
> +       hw_buf[4] = val[0];
> +       hw_buf[5] = val[1];

I don't understand how this interacts with the pre-sync check?

--00KVmmgnlwWwSgYM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXGqYcACgkQJNaLcl1U
h9AnQQf6A0EncPp0Xeqv5CTgLGJmSZL0hXzVAFHFsYEZY8WC8MFVdojalr/NrUbR
oetgen26XmgXwT2vhH6ehK1tgCFtI+rDqE42xkS2aKqtkVkXkpD8HXd3urPOyAdA
eQLgAGFYGV/eD00UyoH5UEcsRA7twP4CqIzWXNpggBCxqZvO0UNlCoyNMFBfkbVI
1dLBbyRHJjaLOwGWX8aOaBkXf5YWo2znHP/ZegGtzi1bv6HiZ2aR35ieGlD0iK3Y
Mw1uRcdUcP9iXAJYucFHejNDY69fJEQwZF5jMFIL4IrjPM70tGQkS2/aVb1D0DvN
KJF4ywc1tev9t5A7z4/1ImA9R/FhLw==
=FQIn
-----END PGP SIGNATURE-----

--00KVmmgnlwWwSgYM--

