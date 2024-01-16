Return-Path: <linux-kernel+bounces-27500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA1982F111
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E811C23591
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2A41BF51;
	Tue, 16 Jan 2024 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQBmJlPe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251451BF41;
	Tue, 16 Jan 2024 15:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC60C433F1;
	Tue, 16 Jan 2024 15:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705417813;
	bh=B1FJIuGceQwGGUr1VdWXxI5e+Mbkrvt6mGSLavFdtRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sQBmJlPeo0s/7USxGte5IlqP3pBJU3TX0Ms0p3AN/ACkQN1ZvtUv+Hfb8hGkjSsdw
	 nZCx54vGUXhQXZqC5yaybqyjfbRayZ+FeyjVopDy62wGeb346r/imKBgGbHg10Htmk
	 R5KdV7BAuHpDIwAb3zGjoSkB5eLnIZPFAL6COuYYWSYInKGnyfhLJGpPR/FeJa0ps5
	 qYfRtTz1Sm9YQK97x6hztp8OqZjG8l8MxmsfVjG1N7XI8ayXGR+IbE2JTUah7GyYm7
	 Zd7eavOKvMQr6+ltIHe8IhhtyfoEvwB+AoyTHx45YQSUbICdpRDoiFOFsbo3XAf8uX
	 klsxHD33fhclQ==
Date: Tue, 16 Jan 2024 15:10:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/7] ASoC: qcom: sc8280xp: limit speaker volumes
Message-ID: <029c8d1b-a621-41cb-a577-dd5829fe8427@sirena.org.uk>
References: <20240116093903.19403-1-johan+linaro@kernel.org>
 <20240116093903.19403-2-johan+linaro@kernel.org>
 <1cc50979-741b-4341-9e9e-2fdee1dd2e65@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ShzZHTDGEX/OI1T3"
Content-Disposition: inline
In-Reply-To: <1cc50979-741b-4341-9e9e-2fdee1dd2e65@linaro.org>
X-Cookie: Programmers do it bit by bit.


--ShzZHTDGEX/OI1T3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 11:11:47AM +0000, Srinivas Kandagatla wrote:
> On 16/01/2024 09:38, Johan Hovold wrote:
> > The current UCM configuration sets the speaker PA volume to 15 dB when
> > enabling the speakers but this does not prevent the user from increasing
> > the volume further.
> >=20
> > Limit the PA volume to 15 dB in the machine driver to reduce the risk of
> > speaker damage until we have active speaker protection in place.

> LGTM, We can get rid of this limit once we have Speaker protection inplac=
e.

There should be a userspace component for speaker protection so you'll
need to limit things when that's not running.

--ShzZHTDGEX/OI1T3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWmnE8ACgkQJNaLcl1U
h9Dbmgf+IblLPaBg7D2oSrtByTikbx592QEXrkcWHGjqquxgdEdDaTQXUNfUE9oR
N7Dllk3rRDTEPEc78Gb5hFvjE7zut/xjfOoaGqSiwtv9/pA8TkEI8qBB65eQxSNt
5Zpcy5Y2bZ3AkzcggF3JFZsUBx1pdE6CVi7BrR3SCOsvnZGowBpVRaMP+MWvZPO1
I+mntld1hnmH2g/1fnMmPIpvXlGSKPQ3bbcqd7d7IVnxBagNzPdKyQVnpMlHTQM0
5w2XCZc8Nikf/8UzUrM6DBL8AeNww6V9etfyjkquZ5COHeaW16quGxMksHtpO7bL
2MAtAP7YlZTbCeQv/VmF4TshVtrPqw==
=ukiF
-----END PGP SIGNATURE-----

--ShzZHTDGEX/OI1T3--

