Return-Path: <linux-kernel+bounces-121282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 027D888E4A4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A4F1C28AC6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85C5130E37;
	Wed, 27 Mar 2024 12:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EOxICtBR"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671C6130E31
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542599; cv=none; b=NEiBEU/H6oS/2TvE+0vPZdrocRO1mvp9hk+IaOTLS7yuAWwXS+ufDCeeNhbr74L7rlP7Dl+JQoQpGr+WE6HJmNSctZvpLoLhDzcd8NrSB55GRrsS7t5VI/QN7YBoWAn4C3K/2HINBUnJudg0XoaQWf7pmwyiQKTuxD9H28oRhEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542599; c=relaxed/simple;
	bh=rBSk2crF8ZXx9ouVgILg9VbK8sh4lcnXRnYuSoDMFvY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lFxx5Uh1rJlVJeNEHRJzPI12I5TzSUIL3qkktSO9bmvG3mI8GWtsFXHfDvkygKOLoyPM8xPuMEhNRCWQrZeGhDLpK1CuADOePXSENJsV2yoE/1aO1ANfoQNXQa3+FcjW7XXv2G22HA3WZMorSGZZSEUe2ga+8Ev1f2A4Oc+cE/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EOxICtBR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711542594;
	bh=rBSk2crF8ZXx9ouVgILg9VbK8sh4lcnXRnYuSoDMFvY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EOxICtBRMJvl89NGYwRz8EelTFQaeNaEZMwmAMyaGwGJn1NhFzZtEOEP8DPLOGCC1
	 llO1a4Vzza4tCGRN+hxJ9j76EjC4Xp+1yPmVVtqnFURSOXz2IfG8dG/zHwZvtn+bCk
	 la7Sb6Y2ZgEwJ5+5HfqG4v9psGtYaQlDHck/Hp/LCCHNEHmd0QlogbKo+t2bAyA6ef
	 Ik8WjHhGc2LWPQC1KMj+NVWxjae2IDQFammzz7cW4NNrcprjYw9xV6q2X/BEiNaTES
	 D61kiS8AegG1PP+67AlK0iylUTb7koADgWSHjZjr9ydezAfRn1KZbQ61wXb/80cotM
	 WL1LptNSBrXjQ==
Received: from eldfell (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pq)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 14CBB37811CD;
	Wed, 27 Mar 2024 12:29:53 +0000 (UTC)
Date: Wed, 27 Mar 2024 14:29:51 +0200
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, Melissa Wen
 <melissa.srw@gmail.com>, =?UTF-8?B?TWHDrXJh?= Canal
 <mairacanal@riseup.net>, Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com,
 nicolejadeyee@google.com
Subject: Re: [PATCH v5 10/16] drm/vkms: Re-introduce line-per-line
 composition algorithm
Message-ID: <20240327142951.192e0b5f.pekka.paalanen@collabora.com>
In-Reply-To: <ZgLwTvjdzf8KTZsY@localhost.localdomain>
References: <20240313-yuv-v5-0-e610cbd03f52@bootlin.com>
	<20240313-yuv-v5-10-e610cbd03f52@bootlin.com>
	<20240325174309.28f91bec.pekka.paalanen@collabora.com>
	<ZgLwTvjdzf8KTZsY@localhost.localdomain>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lddhg.sxiDa51TLW7SbOP9Y";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/lddhg.sxiDa51TLW7SbOP9Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Mar 2024 16:57:02 +0100
Louis Chauvet <louis.chauvet@bootlin.com> wrote:

> [...]
>=20
> > > @@ -215,34 +188,146 @@ static void blend(struct vkms_writeback_job *w=
b,
> > >  {
> > >  	struct vkms_plane_state **plane =3D crtc_state->active_planes;
> > >  	u32 n_active_planes =3D crtc_state->num_active_planes;
> > > -	int y_pos, x_dst, x_limit;
> > > =20
> > >  	const struct pixel_argb_u16 background_color =3D { .a =3D 0xffff };
> > > =20
> > > -	size_t crtc_y_limit =3D crtc_state->base.crtc->mode.vdisplay;
> > > +	int crtc_y_limit =3D crtc_state->base.crtc->mode.vdisplay;
> > > +	int crtc_x_limit =3D crtc_state->base.crtc->mode.hdisplay;
> > > =20
> > >  	/*
> > >  	 * The planes are composed line-by-line to avoid heavy memory usage=
 It is a necessary
> > >  	 * complexity to avoid poor blending performance.
> > >  	 *
> > > -	 * The function vkms_compose_row is used to read a line, pixel-by-p=
ixel, into the staging
> > > -	 * buffer.
> > > +	 * The function pixel_read_line callback is used to read a line, us=
ing an efficient
> > > +	 * algorithm for a specific format, into the staging buffer.
> > >  	 */
> > >  	for (size_t y =3D 0; y < crtc_y_limit; y++) {
> > >  		fill_background(&background_color, output_buffer);
> > > =20
> > >  		/* The active planes are composed associatively in z-order. */
> > >  		for (size_t i =3D 0; i < n_active_planes; i++) {
> > > -			x_dst =3D plane[i]->frame_info->dst.x1;
> > > -			x_limit =3D min_t(size_t, drm_rect_width(&plane[i]->frame_info->d=
st),
> > > -					stage_buffer->n_pixels);
> > > -			y_pos =3D get_y_pos(plane[i]->frame_info, y);
> > > +			struct vkms_plane_state *current_plane =3D plane[i];
> > > =20
> > > -			if (!check_limit(plane[i]->frame_info, y_pos))
> > > +			/* Avoid rendering useless lines */
> > > +			if (y < current_plane->frame_info->dst.y1 ||
> > > +			    y >=3D current_plane->frame_info->dst.y2)
> > >  				continue;
> > > =20
> > > -			vkms_compose_row(stage_buffer, plane[i], y_pos);
> > > -			pre_mul_alpha_blend(stage_buffer, output_buffer, x_dst, x_limit);
> > > +			/*
> > > +			 * dst_line is the line to copy. The initial coordinates are insi=
de the =20
>=20
> [...]
>=20
> > > +				 */
> > > +				pixel_count =3D drm_rect_width(&src_line);
> > > +				if (x_start < 0) {
> > > +					pixel_count +=3D x_start;
> > > +					x_start =3D 0;
> > > +				}
> > > +				if (x_start + pixel_count > current_plane->frame_info->fb->width=
) {
> > > +					pixel_count =3D
> > > +						(int)current_plane->frame_info->fb->width - x_start;
> > > +				}
> > > +			} else {
> > > +				/*
> > > +				 * In vertical reading, the src_line height is the number of pix=
el
> > > +				 * to read
> > > +				 */
> > > +				pixel_count =3D drm_rect_height(&src_line);
> > > +				if (y_start < 0) {
> > > +					pixel_count +=3D y_start;
> > > +					y_start =3D 0;
> > > +				}
> > > +				if (y_start + pixel_count > current_plane->frame_info->fb->heigh=
t) {
> > > +					pixel_count =3D
> > > +						(int)current_plane->frame_info->fb->width - y_start;
> > > +				} =20
> >=20
> > When you are clamping x_start or y_start or pixel_count to be inside
> > the source FB, should you not equally adjust the destination
> > coordinates as well? =20
>=20
> I did not think about it. Currently it is not an issue and it will not=20
> read or write outside a buffer because the pixel count is properly=20
> limited. But indeed, there is an issue here. I will fix it in the v6.
> =20
> > If we take a step back and look at the UAPI, I believe the answer is
> > "no", but it's in no way obvious. It results from the combination of
> > several facts:
> >=20
> > - UAPI checks reject any source rectangle that extends outside of the
> >   source FB.
> >=20
> > - The source rectangle stretches to fill the destination rectangle
> >   exactly.
> >=20
> > - VKMS does not support stretching (scaling), so its UAPI checks reject
> >   any commit with source and destination rectangles of different sizes
> >   after accounting for rotation. (Right?) =20
>=20
> I don't know what are exactly the UAPI contract but as the dst can be=20
> outside the CRTC, I assumed that the src can be outside the source plane.=
=20
> After thinking it doesn't really make sense.

The UAPI contract for source and destination rectangles is here:
https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#standard-plane-proper=
ties

I assume there is some shared (helper?) code in DRM that enforces the
contract and returns error to userspace if it is violated.

> > I think this results in the clamping code being actually dead code.
> > However, I would not delete the clamping code, because it is a cheap
> > safety net in case something goes wrong. =20
>=20
> If UAPI check that the source rectangle is inside the plane, yes it is=20
> just a safety net. Otherwise, it is required to manage properly the=20
> userspace requests. In the v6, the outside of a source buffer is=20
> transparent.
>=20
> > If you agree that it's just a safety net, then maybe explain that in a
> > comment? If the safety net catches anything, the composition result
> > will be wrong anyway, so it doesn't matter to adjust the destination
> > rectangle to match. =20
>=20
> I will extract this whole clamping stuff in a function, is this comment=20
> enough?
>=20
>  * This function is mainly a safety net to avoid reading outside the sour=
ce buffer. As the
>  * userspace should never ask to read outside the source plane, all the c=
ases covered here should
>  * be dead code.

Sure. Perhaps use a bit more assertive tone about what the UAPI
contract guarantees. Yes, userspace "should not", but the kernel DRM
code ensures that it does not.

> > When the last point is relaxed and VKMS gains scaling support, I think
> > it won't change the fact that the clamping remains as a safety net. It
> > just increases the risk of bugs that would be caught by the net.
> >=20
> > Going outside of FB boundaries is a serious bug and deserves to be
> > checked. Going outside of the source rectangle would be a bug too,
> > assuming that partially included pixels are considered fully included,
> > but it's not serious enough to warrant explicit checks. Ideally IGT
> > would catch it. =20
>=20
> That was exactly the idea behind all those check and clamping: avoid=20
> access outside the buffers.

Good.

To catch a driver using pixels outside of a source rectangle, the test
FB in IGT should be painted to have a different non-black color outside
of the source rectangle.

> > > +			}
> > > +
> > > +			if (pixel_count <=3D 0) {
> > > +				/* Nothing to read, so avoid multiple function calls for nothing=
 */
> > > +				continue;
> > > +			}
> > > +
> > > +			/*
> > > +			 * Modify the starting point to take in account the rotation
> > > +			 *
> > > +			 * src_line is the top-left corner, so when reading READ_RIGHT_TO=
_LEFT or
> > > +			 * READ_BOTTOM_TO_TOP, it must be changed to the top-right/bottom=
-left
> > > +			 * corner.
> > > +			 */
> > > +			if (direction =3D=3D READ_RIGHT_TO_LEFT) {
> > > +				// x_start is now the right point
> > > +				x_start +=3D pixel_count - 1;
> > > +			} else if (direction =3D=3D READ_BOTTOM_TO_TOP) {
> > > +				// y_start is now the bottom point
> > > +				y_start +=3D pixel_count - 1;
> > > +			}
> > > +
> > > +			/*
> > > +			 * Perform the conversion and the blending
> > > +			 *
> > > +			 * Here we know that the read line (x_start, y_start, pixel_count=
) is
> > > +			 * inside the source buffer [2] and we don't write outside the st=
age
> > > +			 * buffer [1]
> > > +			 */
> > > +			current_plane->pixel_read_line(
> > > +				current_plane, x_start, y_start, direction, pixel_count,
> > > +				&stage_buffer->pixels[current_plane->frame_info->dst.x1]);
> > > +
> > > +			pre_mul_alpha_blend(stage_buffer, output_buffer,
> > > +					    current_plane->frame_info->dst.x1,
> > > +					    pixel_count);
> > >  		}
> > > =20
> > >  		apply_lut(crtc_state, output_buffer);
> > > @@ -250,7 +335,7 @@ static void blend(struct vkms_writeback_job *wb,
> > >  		*crc32 =3D crc32_le(*crc32, (void *)output_buffer->pixels, row_siz=
e);
> > > =20
> > >  		if (wb)
> > > -			vkms_writeback_row(wb, output_buffer, y_pos);
> > > +			vkms_writeback_row(wb, output_buffer, y);
> > >  	}
> > >  }


Thanks,
pq

--Sig_/lddhg.sxiDa51TLW7SbOP9Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmYEET8ACgkQI1/ltBGq
qqdLog//WG3lrD7UWAQgtj0+J3L/cX7uRLrdxOeZ9Iygg6n+qychr0ZCQv9Q4fsA
hf/QmqXNT/zQsoV1+ZS8tlGOwvU8Q74PEMvNU8ij1jqtLuYh3ln+Cb6rY7lu59tw
rdFpD/bygkVIOTSjCqIqXtz8ycqtzrcFT8/9txbkNZO11QPuDcMouZ2OX0j0Wdau
yUdzTAs2Qc1xTn7khhHZjCCQyqJInEQEePrB5xOO4L/FoFxQqe+EhS7/zbmD8ePA
VWk2EBgHoBgH0HL6nn+vGAuCyUOl13SK1Iced/RIp4tlyRnnYCaAE8y135jGOfKD
nfW4y7BoxwTp7aLk/H6H1Y8rF7RlqdKRpIZKh+agsYA864NJIYeEqdA/4xcVxvZj
6nZM0rSr7U7yxoVivZGiRo20LW9W3dE88rhTZajSnJhR8uMYEY2sEtoatOHrrr6i
+YsAW46SPPK4iCO/BiN0ofkXsWayoSz6WQjkIFL/r9jW0MZZhbfGXFS3MDwk9qyN
EPF1WSygx4+isAB+IItKXiE2PGFLNmZEs4eVyKJvD+vKUDELMjvRuglEouJY8+9K
HkPibXD+Y24h+lM1nEWN0Vq0bjuPqOW8DahqrRLe+iM1CatcpIPXhZri/EVTZZNb
h4Dx31qvmnTPO3ynQ+mStdKfTTUeRljgIl3/8Uw0+aThj6VEmN0=
=kB0e
-----END PGP SIGNATURE-----

--Sig_/lddhg.sxiDa51TLW7SbOP9Y--

