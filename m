Return-Path: <linux-kernel+bounces-137269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8E189DFB6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C961C22A07
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2920137C21;
	Tue,  9 Apr 2024 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKglQhqX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A49B13667F;
	Tue,  9 Apr 2024 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677875; cv=none; b=R5BPcjU9cdhKnVR+CzE0WnXb0fztIpTxcL1AX8nj14evkkNrc2rQk/tmTHd9nJ6BdS6eMLuhT5JX+QSoz03Amak9xLkbRPVr2VEXNXTZsb2s4Oq4LBiXZC2ouHU7Wtq6kzNw09AEeuiGrO+o5u/h0SbHzGpFvt7cgIPz4+TJwl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677875; c=relaxed/simple;
	bh=3rRigGgrftXHxJMkPsD1T8AKbfSmr3FbCk/KvX7w3vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuqaqwhQk35CWvvWmGuxsoRaXo/ixoYPpgDGxWzNT/Mu+tnj4GqeBpk+J53XtrYISnSo5GWxyNa0SlVHfXpBqtVloUkr1ps69sTVZXudjSZ1O3VriaG54OJmNv2Sqk1Tj0zklEfgnWom7inyfJwLCBz+2VrfcK06GQXqrMpM3q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKglQhqX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F9DC433B1;
	Tue,  9 Apr 2024 15:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712677874;
	bh=3rRigGgrftXHxJMkPsD1T8AKbfSmr3FbCk/KvX7w3vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gKglQhqXcTVxJi1naUItRLt/gwaK1khmO0uOdyi47teij5ePlbSCMLSqqu6O5n9u3
	 q3+noVB29K61ferPB1f2rRYhL1D0fwyK54WLxQbNchz1q0+8a9jULG3jRF20wm7//f
	 J9WjURMRfKBmwr1re5d/XIyKeJlZr5ACOBLGTWeIgGrzpkviTWuAFtt0vEirWW/YVm
	 95NZVK173pBwrMPfD9LpG+r3yzxYo6XGso2QGeBhNpRflzz9uHa/wRHpbUKL2DgA05
	 7j3thoTSyKMbjF8Az/hP6izpL7zSrBGxrjdXCNcvHiKOL1lY6A0vLgICWjz68aFCqG
	 YCFuR7IWa7eOw==
Date: Tue, 9 Apr 2024 16:51:06 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vaishnav Achath <vaishnav.a@ti.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rob Herring <robh@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH v2 05/11] spi: cadence-qspi: add FIFO depth detection
 quirk
Message-ID: <c058fd5e-f5ef-4469-a41f-38d72a345f77@sirena.org.uk>
References: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
 <20240405-cdns-qspi-mbly-v2-5-956679866d6d@bootlin.com>
 <551bea0a-1c9e-4e04-87db-c643fdaee85e@sirena.org.uk>
 <D0ETH1AG1ONG.1M1FPSZM69H0Z@bootlin.com>
 <66bf7d58-a726-49ba-9765-f769f6189310@sirena.org.uk>
 <D0FIC34Z35BV.1RT6NNGWA85SL@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i0WU2ZVJwt5+hsRw"
Content-Disposition: inline
In-Reply-To: <D0FIC34Z35BV.1RT6NNGWA85SL@bootlin.com>
X-Cookie: Everything you know is wrong!


--i0WU2ZVJwt5+hsRw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2024 at 12:07:56PM +0200, Th=E9o Lebrun wrote:

>  - (3) Make DT property optional for all compatibles.
>     - (3a) If provided, warn if runtime detect value is different.
>     - (3b) If provided, do not detect+warn.

I think either of these is fine.

--i0WU2ZVJwt5+hsRw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYVY+kACgkQJNaLcl1U
h9C/6wf/R39iaV51I3X0bI2R7WmoJqIn1NUIMRkmNhL3JTH0GuiS0y4uhXxAi1Mh
ctXKqYIe88R+Tj6JFqZ94QN/UPne013ighl8AK5g77nyUQudXNSMyU60jzsf2BeB
T91CvGIJM4taLxkcZ+Mb9RNOY6sFDzGOvPJmaidb1hV0LPy6VIxdnyUpjj8MZi+H
Rll8YToay3JntnlqkTCi5PFiDeJra4ZfUKiHJlyDoxQ9knxMqPjseOlovAP99e6w
oPHzWyDQds/d75m349lz2X24njRunjmg638jtf+7zZFsd7Q6cr12lS+BdwN7mz9x
Jbw0UghamdQziIwhj2zfRssV2RM27g==
=EeT2
-----END PGP SIGNATURE-----

--i0WU2ZVJwt5+hsRw--

