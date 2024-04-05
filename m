Return-Path: <linux-kernel+bounces-133087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46480899E96
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A233528375A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843C116DEC0;
	Fri,  5 Apr 2024 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rz1rhltk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C271B16D4F5;
	Fri,  5 Apr 2024 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324423; cv=none; b=UoR5fSYqOgUiw5MGQmXMJRuo+9QpqCeFFi71wBuWz6y21EtWYgDLxOKLiK9lEddJvpcvdaMEh5HXOCZ8ghbkr61bJBqodmAh6K+J8bMsTQtolo9CRSQfX3UqiECp0SKT0lKsQpemtl9t6F+3pc+kVeLEnMDIXCq4YpzZ/YL4JgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324423; c=relaxed/simple;
	bh=KxZQ7ehx1DNyePhFG2kzZH/j/invOxWdsA6YprcZ8Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQcECgC+iKTdmX11Ig0Vt0YhOQ8+pBUzckDGxj0oGkZ/3j9LuOvqMFBuhPGz609AZg4j1lBIagohxYJSZ3O2lKFd1xffPZyrQ/m1ldzdqDtZU2hIh1qFdRjv16Yl/XcXYfqyaRC/KxfQ5NJxRjtKajxzmA3wLRK/twOELr7mYT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rz1rhltk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E22BC433F1;
	Fri,  5 Apr 2024 13:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712324423;
	bh=KxZQ7ehx1DNyePhFG2kzZH/j/invOxWdsA6YprcZ8Aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rz1rhltkWxcNCP4HFVtDkm2b4YMwphSXw5Rse8DhpBG0tJ7kLZ7luQHF1oZVXU/Tu
	 7Q5yFnAxuDpTeuEpSj3wYDqKiYqCauDgfU99AGiVxUWlMZ+ZSjZ2FP8UfoGnWsJELy
	 wRwqibuER42W/3Qzw7luOSqilXNqOmuYDQZ8Huc54zuSpBY3wAyXUw+fSK4/QU/g63
	 rQGk8VAE+zfiRp2lkt7yperviQPraW5at7cnCion4D8jxIrSxFk2p7eoUTRTk0wUTX
	 J5Pofz7cuJvPVYtvt1hxuZrAHzvBk28/tz4rr30RbgZpb7+bFe8lYdrtdhe1WWWhqc
	 LYsfzFGaqKlNQ==
Date: Fri, 5 Apr 2024 14:40:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: linux-kernel@vger.kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	perex@perex.cz, tiwai@suse.com, 13916275206@139.com,
	mohit.chawla@ti.com, soyer@irl.hu, jkhuang3@ti.com, tiwai@suse.de,
	pdjuandi@ti.com, manisha.agrawal@ti.com, aviel@ti.com,
	hnagalla@ti.com, praneeth@ti.com, Baojun.Xu@fpt.com
Subject: Re: [PATCH v8 0/4] ASoc: PCM6240: mixer-test report
Message-ID: <11c55770-a306-45f6-91fd-2dd9918bb39a@sirena.org.uk>
References: <20240403003159.389-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mnAkXzmNKO4zU4Z0"
Content-Disposition: inline
In-Reply-To: <20240403003159.389-1-shenghao-ding@ti.com>
X-Cookie: Honk if you love peace and quiet.


--mnAkXzmNKO4zU4Z0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2024 at 08:31:54AM +0800, Shenghao Ding wrote:
> mixer-test report:
>  root@am335x-evm:/bin# mixer-test
>  TAP version 13
>  # Card 0 - TI BeagleBone Black (TI BeagleBone Black)
>  1..7
>  ok 1 get_value.0.0
>  # 0.0 pcmd3180-i2c-2 Profile id
>  ok 2 name.0.0
>  ok 3 write_default.0.0
>  ok 4 write_valid.0.0
>  ok 5 write_invalid.0.0
>  ok 6 event_missing.0.0
>  ok 7 event_spurious.0.0
>  # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
>  root@am335x-evm:/bin#

None of the additional %s-i2c-%d-dev%d-ch%d-ana-gain type controls
appear to have shown up here - what's the story there?

--mnAkXzmNKO4zU4Z0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYP/z8ACgkQJNaLcl1U
h9DR8wf+IM1zIAXw8sdz9hd6YBuO8aMFJqEjXokQWNsOQKBM2ZmkvI4cqaAubt/L
v5HlYUHmXTV90zSlk7A0e/CFT3AGyiDwNXHmn4Y+2VIpTMIWfqLcqBc3tauCuK2M
fKFuWcXeFygJ4XHQspODnVO2WubCALtnHEUjnnJFI60e649rxLyz8oYbVz+26MW8
9zfM9Fmwk0Rl5PTN22TOQoDQ74WpEJq/ZjlrUqdsDDb1MOrw88KuWBIrbqqVA2cq
tlomERUxQRkPJayASezXVk4FBEtmcdvwhNgBDD+HgBHgpebIr6EtS81IzfBLjqE+
D9nqWsITMs8s9KguCxWmoHAUfF3ZPQ==
=7dyz
-----END PGP SIGNATURE-----

--mnAkXzmNKO4zU4Z0--

