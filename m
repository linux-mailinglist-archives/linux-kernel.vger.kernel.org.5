Return-Path: <linux-kernel+bounces-82945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F62868C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ABCD1C223FA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEE513667F;
	Tue, 27 Feb 2024 09:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LrYgYKBI"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA34C136663;
	Tue, 27 Feb 2024 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025588; cv=none; b=OwHWQfgEY6dPSfmdI+e2JX9eMw05M30SSjuw4PIIJV3ec94k4bvzs0+v+RtYF85OkbT88u3ntiqWGLUq3mo7ajrkFSirZXudBMFKj/jMTRmjGlkSLCpmRU4CIhhj7N+FKDRGXkuMR/2ppXrHrpgp6MiHokmX9iYEBA0vrygcjzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025588; c=relaxed/simple;
	bh=C/oFzRJOAX2fab2jouBghp4z46x7LVa76qoFEBIuBbo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rC9SfvY7FLBovNOskdgfHlfknL+5AQmemcY84dhyKwiBE+s8AeH+lmC/y3CRpY7/d4f0XSJuwBEpzwWznANLz6WR+3JUPbKctoAt11bKlAaDiyQMXaAfuug2uQQFmJShM6UgpKSHN7XlTAMp9bDYQNrg9n9P7SKdR3usLFFK2+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LrYgYKBI; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709025583;
	bh=C/oFzRJOAX2fab2jouBghp4z46x7LVa76qoFEBIuBbo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LrYgYKBI6DOH/pc/J7Ecmx7ttT5KIkffirla/dzc3bn81fLzhQgOIG0tqaHxOQO6G
	 AHPdsi75rlq8QALWaEZFFOLMnlrwoXdsyiKk1xsOWeCWk0onAN0CikzdPDo16tMImq
	 YWJoWwdmHwyZJ2+OdFQqiXuT0KSOEPJFHGHxbPSZta5y8ETLSOXTSr2mLb5OQZNC3s
	 s+odA/MNkmLG6eIeSllVJiRBIhw9QL149crogYPIumL5bSoOWKlU6Pj6wpLYakO+TV
	 pp6ucS/gstI4ep3IVMV1VXKk+6DvsLdZwz2Eq67loRYD2p2//hDR5NVtGUB+d7f1pL
	 x82SfNoMjKwAg==
Received: from eldfell (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pq)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 132A13781FA4;
	Tue, 27 Feb 2024 09:19:43 +0000 (UTC)
Date: Tue, 27 Feb 2024 11:19:41 +0200
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
Message-ID: <20240227111941.061a2892.pekka.paalanen@collabora.com>
In-Reply-To: <20240226-bench-vkms-v1-1-515ef91b11c8@riseup.net>
References: <20240226-bench-vkms-v1-1-515ef91b11c8@riseup.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Al3K0O_fW7VTKwg+hyaw9T9";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Al3K0O_fW7VTKwg+hyaw9T9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Feb 2024 17:42:11 -0300
Arthur Grillo <arthurgrillo@riseup.net> wrote:

> Now that we have a defined benchmark for testing the driver, add
> documentation on how to run it.
>=20
> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> ---
>  Documentation/gpu/vkms.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> index ba04ac7c2167..6d07f79f77ff 100644
> --- a/Documentation/gpu/vkms.rst
> +++ b/Documentation/gpu/vkms.rst
> @@ -89,6 +89,12 @@ You can also run subtests if you do not want to run th=
e entire test::
>    sudo ./build/tests/kms_flip --run-subtest basic-plain-flip --device "s=
ys:/sys/devices/platform/vkms"
>    sudo IGT_DEVICE=3D"sys:/sys/devices/platform/vkms" ./build/tests/kms_f=
lip --run-subtest basic-plain-flip
> =20
> +If you are developing features that may affect performance, you can run =
the kms_fb_stress

s/can/must/

> +benchmark::

before and after, and report the numbers.

> +
> +  sudo ./build/benchmarks/kms_fb_stress --device "sys:/sys/devices/platf=
orm/vkms"
> +  sudo IGT_DEVICE=3D"sys:/sys/devices/platform/vkms" ./build/benchmarks/=
kms_fb_stress

Do people need to run both commands?

Anyway, a good idea.

Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>


Thanks,
pq

> +
>  TODO
>  =3D=3D=3D=3D
> =20
>=20
> ---
> base-commit: eeb8e8d9f124f279e80ae679f4ba6e822ce4f95f
> change-id: 20240226-bench-vkms-5b8b7aab255e
>=20
> Best regards,


--Sig_/Al3K0O_fW7VTKwg+hyaw9T9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmXdqS0ACgkQI1/ltBGq
qqfGJRAApGG99tBnUJJr8a9IT2dsMQqZ46B5JVGCsYV1IR8pQOa7XIuuXgla19vF
HcIiUw0SZDclUtRiK5K1p1S6VPR65Yr0wrfBGlmjJDOOoWuGwEcfPbs8e7KThpxr
pA55UAzznjP2jXpY70ef5FE4wAbM7Q48zdEjoOd7OREkKMPjuMW0IfuQdGZp7YjZ
RzPZPhnqVChBkRwYD5mWs8Au/gMZkaIMedg8hyAhimO6h1GDNA2GMqEFr1DSYv8A
TBG/mkIWlCGmb+j6+V7EQzoDZODASTjtf+KRqDlQnfpZB63UnOvt83mqABUM1wYt
ltVilQfRO3gUJYbqZchCKj5kce91amQydbnlwgtdeue5JZUYx9XUk6Pz9lOysysV
UpCbYTKytIrS+owxhxbsCcsq0P2xeV9g+jT07ZjLU9K78XnKMeL4Tzf+8ssEfWKS
zVmBDhaKA0l2RRBB+Md9sQqwmyCufAAz05mmXOduYSvJhZPolp2vqVpVEkrIfQ76
Xmuw1AeC4Iz/3zAdlSL0sQ8xauwT+A/MPGaeNEfxBYjMKZj6Q8adQlQ0yFhTCcF/
+co2b/dSFYu5Pvb0G6nwH9kXGYutsM/BEeY5cXWeqez2U0tegbRSjWX8kxRdQU1i
cRAfOOIvgzpqMyWHbPrWPf5KVDV0erWwhuVcIfQuEEfWIsKGPao=
=FQV+
-----END PGP SIGNATURE-----

--Sig_/Al3K0O_fW7VTKwg+hyaw9T9--

