Return-Path: <linux-kernel+bounces-61571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF088513C2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084B02811F0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C13139FEF;
	Mon, 12 Feb 2024 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iM92ejlz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7181539FE0
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741952; cv=none; b=KUeo+KpZnR5mHuyLOBNhC0UJVQFZRFnnKu5fShhxVANu/Jtc/kH1ykwsjiJgCItuaT/X7GSuP8DyyuXZRq+zgn4swqgYuVFo64HhL0jD+LqAli+0kNPLZdhllV/fTrFlJ1r/OE5cc8dVh8oZb3pbki9xfBztJsMSJHAkcyt1NdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741952; c=relaxed/simple;
	bh=tayDtlPlx5o6p0Re1yK3lCp2UKqcklR8YnRrrnZiHmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPOdjfmqrdgkHinsKpdi6oAhh2h3FNGrBlG6ZYwifDcYIm2aYFA5Ki/4aSnneg6Blkh12Onbg8a78soNra1btR0fjRq3tH7WhFihVXPMkEsRU78jFc4C+DyuUXnIE8xZCgCyNtT3eCPz5x05fQG4gTCQj5x746bpawegCr5a+ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iM92ejlz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D09C43394;
	Mon, 12 Feb 2024 12:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707741951;
	bh=tayDtlPlx5o6p0Re1yK3lCp2UKqcklR8YnRrrnZiHmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iM92ejlzhszCISkJf+x8WRaW92+r0uNWiwo7qZYTcchEJXLqLby6H8yXVhCWcbHH0
	 CtWrp2QHwG/ILgWFr5Hjm7pYnn/8D0i4IUzfFazLGn1KLteJZTi4DU32azYylR2BJo
	 1Ye5UjxGBgFHJu4MP6mOT+iEB3S8YTtbQ3gbKbncCYjR6A1DXI2udpnQO0lmyZnZRS
	 mCSDj3bAIOvrrK/uxKqV86D3WcrmN5gqMUXok2rC5ZWqv6+99uW+QY0+lrowixowUf
	 9Pjh17556hsYyjlRQhBnwdhNRabEJ5R6EXg334z4KRg7YOXuAb34/aDna6jn+0IXWU
	 prMLp5w9mr3Mw==
Date: Mon, 12 Feb 2024 12:45:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Yinchuan Guo <guoych37@mail2.sysu.edu.cn>
Cc: linux-kernel@vger.kernel.org, lee.jones@linaro.org, lgirdwood@gmail.com,
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH] sound: codecs: fix typo 'reguest' to 'request'
Message-ID: <279b1b4f-1487-4519-8208-dca5f2576078@sirena.org.uk>
References: <20240212065014.3696356-1-guoych37@mail2.sysu.edu.cn>
 <20240212101820.18437-1-guoych37@mail2.sysu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YZPcNs4IBbyjVRkh"
Content-Disposition: inline
In-Reply-To: <20240212101820.18437-1-guoych37@mail2.sysu.edu.cn>
X-Cookie: Will stain.


--YZPcNs4IBbyjVRkh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 12, 2024 at 06:18:20PM +0800, Yinchuan Guo wrote:
> This patch corrects a common misspelling of "request" as "reguest" found
> in the log messages across various files within sound/soc/codecs.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--YZPcNs4IBbyjVRkh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXKEvoACgkQJNaLcl1U
h9Bl7wf+IHfyDCF21Yc366dRvZpkBp65DHKrxCRC6RKhJjS91F4fgTz+ZQUSdjvg
mA7Nz1Gq5DR0dDAy5zNrFQVb6Qq2cZInJRwJ9Zv+M+6XhTlvVI+sTEa8eLL1Z2LH
wvDy2+K90gSaMWYWNbAMJWT+m3mDG1UVBKMkutSmtGQMnkHAR8RGILhApTr1MFtz
B3s8ZwiHw2LheKvEaviyO+B5zZ6BYyZJ740jFENdWfltHKNRKVCg8ly7drcBEddx
pnMKP4hhr3261pDeQPYsTmkheyxVQt4AdPvEUbdwfqKJuuNpN+mJb2MYgaDc/u+Y
KDDsFV/kjDwcqcIdlzqtpIdeQTv4nA==
=4JNf
-----END PGP SIGNATURE-----

--YZPcNs4IBbyjVRkh--

