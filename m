Return-Path: <linux-kernel+bounces-120493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E92088D84F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90772A37AE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851F02D61B;
	Wed, 27 Mar 2024 07:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Di0d0Yt+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E1D2C699;
	Wed, 27 Mar 2024 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526345; cv=none; b=YXK5EZ3uP5LL/mhGDtxmrGuuveM44kfQEWJsMDXu4LP409PlNzsgqheUMdajj/KJed4NF16nGJKfjTjye9RVKv9ybr0Sm+7q6MjpSv5KQaCaOQGcoXI2JfQCji2ZO+xmxZPW38tjri0gaCFXq9QQNVf4TZnqGpHTvqYqNFyo56A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526345; c=relaxed/simple;
	bh=3Vch1QVVKz9oQdQipI2bgreZmQt1j9KfA9zuNaGttL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgfXJnLQhESxjaCPNC/W5slBJ7bMaKqT8cjHOSfcnwxU0k8jcA8PQAgxxk5KclXjuRiCKxF9C0Idn02GxfLfkwE0z3YuInTwWdf/5nJ3KbPAC9Ym2wAdkE8aTqZRrrtTkiYfQ7Qsbcm6BUnMkt6tZPl4ut3L+wxGSbP2MjwWPWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Di0d0Yt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0C3C433C7;
	Wed, 27 Mar 2024 07:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711526345;
	bh=3Vch1QVVKz9oQdQipI2bgreZmQt1j9KfA9zuNaGttL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Di0d0Yt+kulV0SFZXj34A8yHfdbrIl/RQIlgdOWmOgu0vU93q7/uZcKNfJbM19Owo
	 +BZ42uXnvBbs2aNMWX2zEVxEyEJJPMwojzQAd/oOuGc6hsuzo9sjEfue92kS5s1+tL
	 +X0T/IGlGpYESHZQDwjrSGM0goF1hyFWvEyWXrPg1ad4hI7cP4+ovYoM/hTgx8fCb/
	 EZkqiKMKRqfh12FvgojNrxLdXU0BvomFMfwgXagDQybevdkNVgP/cLwVpzGTfko6us
	 yqkf2Kn+Jp3UowrzesRfAiXd+8e3L1KqUh1f6QDNw2jNEHTy88aStfZfM1dI3aIme8
	 Qz+9AY3eVnZ4w==
Date: Wed, 27 Mar 2024 08:59:02 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, virtualization@lists.linux.dev, 
	spice-devel@lists.freedesktop.org, dri-devel <dri-devel@lists.freedesktop.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: drivers/gpu/drm/qxl/qxl_cmd.c:424:6: error: variable 'count' set
 but not used
Message-ID: <20240327-magnetic-nonchalant-hare-bbe8d2@houat>
References: <CANiq72mbsAYmR_dRPpQQ=9-NWhTtp0TWiOz0v=V-0AvwYbWw4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="6rt63sq2kbvenrzj"
Content-Disposition: inline
In-Reply-To: <CANiq72mbsAYmR_dRPpQQ=9-NWhTtp0TWiOz0v=V-0AvwYbWw4A@mail.gmail.com>


--6rt63sq2kbvenrzj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Miguel,

On Tue, Mar 26, 2024 at 07:04:34PM +0100, Miguel Ojeda wrote:
> Hi,
>=20
> In today's next, I got:
>=20
>     drivers/gpu/drm/qxl/qxl_cmd.c:424:6: error: variable 'count' set
> but not used [-Werror,-Wunused-but-set-variable]
>=20
> `count` seems to be there since commit f64122c1f6ad ("drm: add new QXL
> driver. (v1.4)").
>=20
> Untested diff below -- if you want a formal patch, please let me know.
>=20
> Cheers,
> Miguel
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
> index 281edab518cd..d6ea01f3797b 100644
> --- a/drivers/gpu/drm/qxl/qxl_cmd.c
> +++ b/drivers/gpu/drm/qxl/qxl_cmd.c
> @@ -421,7 +421,6 @@ int qxl_surface_id_alloc(struct qxl_device *qdev,
>  {
>         uint32_t handle;
>         int idr_ret;
> -       int count =3D 0;
>  again:
>         idr_preload(GFP_ATOMIC);
>         spin_lock(&qdev->surf_id_idr_lock);
> @@ -433,7 +432,6 @@ int qxl_surface_id_alloc(struct qxl_device *qdev,
>         handle =3D idr_ret;
>=20
>         if (handle >=3D qdev->rom->n_surfaces) {
> -               count++;
>                 spin_lock(&qdev->surf_id_idr_lock);
>                 idr_remove(&qdev->surf_id_idr, handle);
>                 spin_unlock(&qdev->surf_id_idr_lock);
>=20

It looks reasonable to me, can you send a formal patch?

Thanks!
Maxime

--6rt63sq2kbvenrzj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZgPRxgAKCRAnX84Zoj2+
duBCAYCkWAxADritRMIdxuo60bi8gMXg3ORzEQ+Re/8bjBZRbnoR6xSqWL/e9li6
7QpWXHEBewR48AANqEfzQxPcmpLpFROyX8u8HAbDv9hKJuo8mvAnbhPYLB2LBIbR
B2ivQmRB1A==
=ZxYE
-----END PGP SIGNATURE-----

--6rt63sq2kbvenrzj--

