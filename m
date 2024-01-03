Return-Path: <linux-kernel+bounces-15865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D53282347D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EEC71F24509
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFA11C6A3;
	Wed,  3 Jan 2024 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etyECy0X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D6F15E93;
	Wed,  3 Jan 2024 18:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B131C433C7;
	Wed,  3 Jan 2024 18:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704306667;
	bh=hngD+IDMCG5UNcY50O5jUIC2dfyxPIe5eyQlBYdFUr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=etyECy0X/5DzXMxH8hftxAv025gWeYUOJfvwVqvbixE3Ip4xKl1IrL0JHYCYb0wL8
	 AyrVSvtzjBqmR61R9QiKdKoBV+G89G+s5+5kAK8CXh/KTUkZXVxAjYkHI/oSTby0Pk
	 6O4EsOanROyzxzRa3WnoZavh5pUCjj3F0chZIPPOJau1HUexpRkAXJSPyn1KAufw4e
	 uoyQVYA4s19TKbgQSnUXtGdMnqUjaLWc8amHNE6mYPpSbybcM0mQWw/uXObmdTtuyT
	 Bi+DNIK/ixR1E7DO6yfYKTUlu3wgnK0QX+m/4NmsDGfr1can8EWQUkuvh0BMjrM3tW
	 Sg6Xk/1eWQFnw==
Date: Wed, 3 Jan 2024 18:31:02 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>, lgirdwood@gmail.com,
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Oops in hdac_hda_dev_probe (6.7-rc7)
Message-ID: <ZZWn5vWeWe0BYFfY@finisterre.sirena.org.uk>
References: <ZYvUIxtrqBQZbNlC@shine.dominikbrodowski.net>
 <87sf3lxiet.wl-tiwai@suse.de>
 <ZY7kosArPqhlCfOA@shine.dominikbrodowski.net>
 <874jg1x7ao.wl-tiwai@suse.de>
 <ZY_Gb8-rncuOjRq-@shine.dominikbrodowski.net>
 <87plyovwg7.wl-tiwai@suse.de>
 <3260e806-a708-4462-9d4e-346e54143a65@linux.intel.com>
 <87y1d8ulxv.wl-tiwai@suse.de>
 <87o7e2a3hr.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BfbeOu7ghkN4iRpV"
Content-Disposition: inline
In-Reply-To: <87o7e2a3hr.wl-tiwai@suse.de>
X-Cookie: You might have mail.


--BfbeOu7ghkN4iRpV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 03, 2024 at 03:36:00PM +0100, Takashi Iwai wrote:

> > > Mark, Takashi, can you pick the fix for 6.7 (it is in -next)? I think we
> > > might have time for it to land?

> > Oh that landed to Mark's for-next branch, i.e. only for 6.8.
> > Mark, please cherry-pick and send a PR before 6.7 final.

If you're trying to attract my attention a comment deep in a thread
about HDA probably isn't the way to do it, there's a very good chance
I'm just deleting them unread given how much random HDA stuff I seem to
get CCed on these days :/ .

> I ended up with cherry-picking by myself now.

> I'm going to send a PR to Linus for 6.7 final in tomorrow.

I have some critical fixes I should be posting just now and sending a PR
for later today (unfortunately the board that's impacted has some
ethernet issues in the bootloader which is really slowing down tests
here).

--BfbeOu7ghkN4iRpV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWVp+YACgkQJNaLcl1U
h9AAIwf/Qzap4+U79NRRmhcs4FVob+v57O/mHIzX8S6LB53NGVey9KARMwFrFV9O
C5JKz/NVo68HRvG79ed9XP92r360aPRzdTsUaNRH/q2n7d9W8qaRJVDO9oYY0mA5
uq517mTtY4AhMK/QodecrEySvjgwzVQNL42YS4CvUiFYXnpUJwR3p07E4WzHIcpZ
dMa/tXPPVnHMWg1bDPyCPeOgoHwTGVuu6Wauk1ZUNvO/StRNbmX9IMVnguTkkx+7
E5ouzPwkxmgXNyEZmfYW9LKGoLqphZ+d9kXaTWEVPO7b8xic9hjb4C+Wte9ASHYf
JcMZrunllwufIpMXDAhlLXpphs579A==
=IoKw
-----END PGP SIGNATURE-----

--BfbeOu7ghkN4iRpV--

