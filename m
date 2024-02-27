Return-Path: <linux-kernel+bounces-83150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEBE868F84
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED37C286EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF3C13A252;
	Tue, 27 Feb 2024 11:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GibmauCk"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C78955E63;
	Tue, 27 Feb 2024 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709034951; cv=none; b=bGCP3czXiU6gJ6S0IO6jpdN9rPUCG9kL7P7DuS26yFygU6eciG1f4hxVi4NPZ6tISWc977vZUZJLWZE0XUtBlfXtEM1GtwtzDRBtvAsTIfXsBrFy0oftxIrW6vU7ziWDZy9yvXEq+hGjHrn5MhdxszMeMgTzzmCudkaBt1YNnDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709034951; c=relaxed/simple;
	bh=RfddnnU8S+jV++kMOxgI3dSukhFkW631ZIFHHadg1VA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bz4Ms1m0k8nYKgJJHKhujV9Mgs/hhtAHGVKZJ5IA9RcGTDnVgYwQmqY/RbnkTH4f6VneDJisnMG7yUfpWELUPIxunzucj3wb190YFIVxnmjhxs7iZUm0sDzvZCzqnPB9nrLEMYk3lzAg6R/YbwdQtKOUxuGQlJapQ2BMPLw1wtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GibmauCk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709034948;
	bh=RfddnnU8S+jV++kMOxgI3dSukhFkW631ZIFHHadg1VA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GibmauCkTF0b1YsFR4GI6l3k2A3/qVIQNfjNNTsfBcVN1FH1zofdiiC0fUrCMlGuR
	 04PyiPtkc6jbCWN8RN/wmp0kxKFk8+M0ClgZ1e54qMZ+GLl5FfU69B0FweAcfI1R7f
	 LiZ4u34RG6sls+w1ULDn/7QfXMnNnmGZMqEt2LlOg+kcUEpoI8FeaBoomgx4C4HnzD
	 Xbx0qXDCqzPdMuiqRvFiKCDvto8w+zhwsmEvCyYnzrFSlt3hZEv2H4ogB4vY8/BSSx
	 HeulD0NXJ0X9YnTbCgEegARZxAyWZdUCLiCLqpvYanJHRaYa/Qb49AOOoytpCIaFD7
	 mVm5c/DnDuYsQ==
Received: from eldfell (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pq)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 59C6B37820CC;
	Tue, 27 Feb 2024 11:55:47 +0000 (UTC)
Date: Tue, 27 Feb 2024 13:55:45 +0200
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: Arthur Grillo <arthurgrillo@riseup.net>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, Melissa Wen
 <melissa.srw@gmail.com>, =?UTF-8?B?TWHDrXJh?= Canal
 <mairacanal@riseup.net>, Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: Add information on how to benchmark
Message-ID: <20240227135545.62dd5f57.pekka.paalanen@collabora.com>
In-Reply-To: <8ac7bf91-fbce-4403-a801-9dfee39ea802@riseup.net>
References: <20240226-bench-vkms-v1-1-515ef91b11c8@riseup.net>
	<20240227111941.061a2892.pekka.paalanen@collabora.com>
	<8ac7bf91-fbce-4403-a801-9dfee39ea802@riseup.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/A2mWu+vSdQNKM_BZwjnjD0Q";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/A2mWu+vSdQNKM_BZwjnjD0Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Feb 2024 08:44:52 -0300
Arthur Grillo <arthurgrillo@riseup.net> wrote:

> On 27/02/24 06:19, Pekka Paalanen wrote:
> > On Mon, 26 Feb 2024 17:42:11 -0300
> > Arthur Grillo <arthurgrillo@riseup.net> wrote:
> >  =20
> >> Now that we have a defined benchmark for testing the driver, add
> >> documentation on how to run it.
> >>
> >> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> >> ---
> >>  Documentation/gpu/vkms.rst | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> >> index ba04ac7c2167..6d07f79f77ff 100644
> >> --- a/Documentation/gpu/vkms.rst
> >> +++ b/Documentation/gpu/vkms.rst
> >> @@ -89,6 +89,12 @@ You can also run subtests if you do not want to run=
 the entire test::
> >>    sudo ./build/tests/kms_flip --run-subtest basic-plain-flip --device=
 "sys:/sys/devices/platform/vkms"
> >>    sudo IGT_DEVICE=3D"sys:/sys/devices/platform/vkms" ./build/tests/km=
s_flip --run-subtest basic-plain-flip
> >> =20
> >> +If you are developing features that may affect performance, you can r=
un the kms_fb_stress =20
> >=20
> > s/can/must/
> >  =20
> >> +benchmark:: =20
> >=20
> > before and after, and report the numbers. =20
>=20
> Did you mean to write the benchmarks logs here?

I mean people should be required tell their before and after numbers in
either commit message (my preference) or in series cover letter (if
benchmarking commits is not useful).

With the addition of YUV support in VKMS, maybe the benchmark needs to
start printing YUV numbers separately as a new case.


Thanks,
pq

>=20
> >  =20
> >> +
> >> +  sudo ./build/benchmarks/kms_fb_stress --device "sys:/sys/devices/pl=
atform/vkms"
> >> +  sudo IGT_DEVICE=3D"sys:/sys/devices/platform/vkms" ./build/benchmar=
ks/kms_fb_stress =20
> >=20
> > Do people need to run both commands? =20
>=20
> No, they don't, just two options.
>=20
> Best Regards,
> ~Arthur Grillo
>=20
> >=20
> > Anyway, a good idea.
> >=20
> > Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> >=20
> >=20
> > Thanks,
> > pq
> >  =20
> >> +
> >>  TODO
> >>  =3D=3D=3D=3D
> >> =20
> >>
> >> ---
> >> base-commit: eeb8e8d9f124f279e80ae679f4ba6e822ce4f95f
> >> change-id: 20240226-bench-vkms-5b8b7aab255e
> >>
> >> Best regards, =20
> >  =20


--Sig_/A2mWu+vSdQNKM_BZwjnjD0Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmXdzcEACgkQI1/ltBGq
qqc8SA//bU98zQBK+jIEVhc/aP0I7notpot6B1M0AFjUka9CgrjdKa5KKWjZspUy
uCkPYdDHLqIEq3rhABUlxhIscQZDeNPWbkau6abaf/jhlrRytwwJ9tP2CKhjX6HE
WADwmKjRQwBYyxVmAXA++4abB818zfniZN1VbpgHlHiiZTsM0Y/Ck9PCl2sKhzpp
ANI3HvYyRiYnvYJuIRrGsE6t8JCFglUx8C4yaNlma+N7N7nzel+lMw2RjE7cprNc
1kBXj/fo3RvrhPv6e84YxfzXNSOnKo9PBEgWw2srapFIXf9Y3GnyU2kuX/lsoilv
gekCWYdaDTwraTJOsmLAHTtKFF554Ab1KGx+S5rx6QBPDg5/8F9KDYd43KEGzfkg
mGl0Up0UIqhdb5ioiXrFAkcwQ7+ChpqNj1Tr0dsiyiqWu7T6VQFWK2PBrATJ6ONI
hv/v0GSFzyBOVjSt5J0PbKZkqYYxwbCRjdpAjlxCyCkc3GaJEnRwRjNnVx6foz/m
xs4kLSo1XwRuGz0u6Vjt6xxecMEBulmoHKK+wQsHRThr96BSdPL5OAI86lZOvFrF
sRIycPX+SFR17AiQfyxYByUPrqzr6kHpAosBeEZ6N9gIUGNGSoOBijzRR+HoayoJ
gu6f4ssszr4qskgMqvNSDQnxhtBpJj2JN4IdXTZ2R4FwesuXmFw=
=dsHb
-----END PGP SIGNATURE-----

--Sig_/A2mWu+vSdQNKM_BZwjnjD0Q--

