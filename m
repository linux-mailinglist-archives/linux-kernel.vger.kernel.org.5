Return-Path: <linux-kernel+bounces-120769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4DD88DCCF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5631C25BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314E012AAF5;
	Wed, 27 Mar 2024 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qiNKtOaS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CE72C1A4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711540107; cv=none; b=KUREwSiQFRQR13LduSVVBYW7aQkmWyF9HjkT7WZWEtN9cqj65Ac2uWxZZqsBPrbdwTkb8/BftDd8vnw9WNMvMiPle9kvPzM/GFSVj/5fIq4PNQzjLtEMgd/dpd8FDC437GarS6RhCbj9j1h6gDfawXxxHeF2ra3JGPdMU99R1ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711540107; c=relaxed/simple;
	bh=3sk4zjCCtDc6KYaI3PqLEnSxJKrj4tSQGn57GgNp1w8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K847MHamUS1kNDDdZe6XRbTNzvAmbAR3TtKnzruXKyVT4CdOaKJaCu9NuiXl/XZAu6vdGV2hHE3vR0fpLm/ROdGEKRHlpz2+BbWPO7N6PDvpHQORQ/1Z+KJiWElUp7bzUkXFNLZ5CCAV1ZZeHLVAoW45L1P+8ycWseh+o0aGM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qiNKtOaS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711540103;
	bh=3sk4zjCCtDc6KYaI3PqLEnSxJKrj4tSQGn57GgNp1w8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qiNKtOaSMVISNNx7awmHbCzBRer/z5ZGzimoNJtP06jfd2mag5u/wnqSL5RNYklHb
	 2Oxrc2Xekejo0nug3C/DCaZEeJfDaq8/Fr15J9laf2pAqkQLs/Xie0HBg7aMo/UR/j
	 yQ542h2hKMztTMiAQdgGo/EtsF0Lt85EhnOEH8GtrrYazLKO14ks+Hg9RgdSiSyhmU
	 VHxAuKd+e7549XcLnL0ENyVIwwQ0Kwk0nlXe4gTfOB4Z9s9rG35HcJPtoEV9vI32wx
	 AqwHIaeH7mkvi8EsyqUoCksT9OJaL8x5qz7imr7qRYo/9C/J/z6CY0JjYbk33JV64M
	 xNej8qfVyk+LA==
Received: from eldfell (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pq)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8DB8837820E4;
	Wed, 27 Mar 2024 11:48:22 +0000 (UTC)
Date: Wed, 27 Mar 2024 13:48:21 +0200
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
Subject: Re: [PATCH v5 08/16] drm/vkms: Avoid computing blending limits
 inside pre_mul_alpha_blend
Message-ID: <20240327134821.3a985ab5.pekka.paalanen@collabora.com>
In-Reply-To: <ZgLwTNsehDG4z6Bo@localhost.localdomain>
References: <20240313-yuv-v5-0-e610cbd03f52@bootlin.com>
	<20240313-yuv-v5-8-e610cbd03f52@bootlin.com>
	<20240325144101.6d9fcf7e.pekka.paalanen@collabora.com>
	<ZgLwTNsehDG4z6Bo@localhost.localdomain>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BpgFWwG.B4zFeuVTStC0wqj";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/BpgFWwG.B4zFeuVTStC0wqj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Mar 2024 16:57:00 +0100
Louis Chauvet <louis.chauvet@bootlin.com> wrote:

> Le 25/03/24 - 14:41, Pekka Paalanen a =C3=A9crit :
> > On Wed, 13 Mar 2024 18:45:02 +0100
> > Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> >  =20
> > > The pre_mul_alpha_blend is dedicated to blending, so to avoid mixing
> > > different concepts (coordinate calculation and color management), ext=
ract
> > > the x_limit and x_dst computation outside of this helper.
> > > It also increases the maintainability by grouping the computation rel=
ated
> > > to coordinates in the same place: the loop in `blend`.
> > >=20
> > > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > ---
> > >  drivers/gpu/drm/vkms/vkms_composer.c | 40 +++++++++++++++++---------=
----------
> > >  1 file changed, 19 insertions(+), 21 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/v=
kms/vkms_composer.c
> > > index da0651a94c9b..9254086f23ff 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_composer.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> > > @@ -24,34 +24,30 @@ static u16 pre_mul_blend_channel(u16 src, u16 dst=
, u16 alpha)
> > > =20
> > >  /**
> > >   * pre_mul_alpha_blend - alpha blending equation
> > > - * @frame_info: Source framebuffer's metadata
> > >   * @stage_buffer: The line with the pixels from src_plane
> > >   * @output_buffer: A line buffer that receives all the blends output
> > > + * @x_start: The start offset to avoid useless copy =20
> >=20
> > I'd say just:
> >=20
> > + * @x_start: The start offset
> >=20
> > It describes the parameter, and the paragraph below explains the why.
> >=20
> > It would be explaining, that x_start applies to output_buffer, but
> > input_buffer is always read starting from 0. =20
>=20
> I will change it to:
>=20
>  * Using @x_start and @count information, only few pixel can be blended i=
nstead of the whole line
>  * each time. @x_start is only used for the output buffer. The staging bu=
ffer is always read from
>  * the start (0..@count in stage_buffer is blended at @x_start..@x_start+=
@count in output_buffer).

The important part is

0..@count in stage_buffer is blended at @x_start..@x_start+@count in output=
_buffer

and everything else from that paragraph is not really adding much.

Remember to update the doc in "drm/vkms: Re-introduce line-per-line
composition  algorithm" to follow the changes.


> > > + * @count: The number of byte to copy =20
> >=20
> > You named it pixel_count, and it counts pixels, not bytes. It's not a
> > copy but a blend into output_buffer. =20
>=20
> Oops, fixed in v6.
> =20
> > >   *
> > > - * Using the information from the `frame_info`, this blends only the
> > > - * necessary pixels from the `stage_buffer` to the `output_buffer`
> > > - * using premultiplied blend formula.
> > > + * Using @x_start and @count information, only few pixel can be blen=
ded instead of the whole line
> > > + * each time.
> > >   *
> > >   * The current DRM assumption is that pixel color values have been a=
lready
> > >   * pre-multiplied with the alpha channel values. See more
> > >   * drm_plane_create_blend_mode_property(). Also, this formula assume=
s a
> > >   * completely opaque background.
> > >   */
> > > -static void pre_mul_alpha_blend(struct vkms_frame_info *frame_info,
> > > -				struct line_buffer *stage_buffer,
> > > -				struct line_buffer *output_buffer)
> > > +static void pre_mul_alpha_blend(const struct line_buffer *stage_buff=
er,
> > > +				struct line_buffer *output_buffer, int x_start, int pixel_count)
> > >  {
> > > -	int x_dst =3D frame_info->dst.x1;
> > > -	struct pixel_argb_u16 *out =3D output_buffer->pixels + x_dst;
> > > -	struct pixel_argb_u16 *in =3D stage_buffer->pixels;
> > > -	int x_limit =3D min_t(size_t, drm_rect_width(&frame_info->dst),
> > > -			    stage_buffer->n_pixels);
> > > -
> > > -	for (int x =3D 0; x < x_limit; x++) {
> > > -		out[x].a =3D (u16)0xffff;
> > > -		out[x].r =3D pre_mul_blend_channel(in[x].r, out[x].r, in[x].a);
> > > -		out[x].g =3D pre_mul_blend_channel(in[x].g, out[x].g, in[x].a);
> > > -		out[x].b =3D pre_mul_blend_channel(in[x].b, out[x].b, in[x].a);
> > > +	struct pixel_argb_u16 *out =3D &output_buffer->pixels[x_start];
> > > +	const struct pixel_argb_u16 *in =3D stage_buffer->pixels;
> > > +
> > > +	for (int i =3D 0; i < pixel_count; i++) {
> > > +		out[i].a =3D (u16)0xffff;
> > > +		out[i].r =3D pre_mul_blend_channel(in[i].r, out[i].r, in[i].a);
> > > +		out[i].g =3D pre_mul_blend_channel(in[i].g, out[i].g, in[i].a);
> > > +		out[i].b =3D pre_mul_blend_channel(in[i].b, out[i].b, in[i].a);
> > >  	}
> > >  }
> > > =20
> > > @@ -183,7 +179,7 @@ static void blend(struct vkms_writeback_job *wb,
> > >  {
> > >  	struct vkms_plane_state **plane =3D crtc_state->active_planes;
> > >  	u32 n_active_planes =3D crtc_state->num_active_planes;
> > > -	int y_pos;
> > > +	int y_pos, x_dst, x_limit;
> > > =20
> > >  	const struct pixel_argb_u16 background_color =3D { .a =3D 0xffff };
> > > =20
> > > @@ -201,14 +197,16 @@ static void blend(struct vkms_writeback_job *wb,
> > > =20
> > >  		/* The active planes are composed associatively in z-order. */
> > >  		for (size_t i =3D 0; i < n_active_planes; i++) {
> > > +			x_dst =3D plane[i]->frame_info->dst.x1;
> > > +			x_limit =3D min_t(size_t, drm_rect_width(&plane[i]->frame_info->d=
st),
> > > +					stage_buffer->n_pixels); =20
> >=20
> > Are those input values to min_t() really of type size_t? Or why is
> > size_t here? =20
>=20
> n_pixel is size_t, drm_rect_width is int. I will change everything to int=
=20
> Is there a way to ask the compiler "please don't do implicit conversion=20
> and report them as warn/errors"?

There probably is, you can find it in the gcc manual. However, I suspect
you would drown in warnings for cases where the implicit conversion is
wanted and an explicit cast is unwanted.


Thanks,
pq

> > >  			y_pos =3D get_y_pos(plane[i]->frame_info, y);
> > > =20
> > >  			if (!check_limit(plane[i]->frame_info, y_pos))
> > >  				continue;
> > > =20
> > >  			vkms_compose_row(stage_buffer, plane[i], y_pos);
> > > -			pre_mul_alpha_blend(plane[i]->frame_info, stage_buffer,
> > > -					    output_buffer);
> > > +			pre_mul_alpha_blend(stage_buffer, output_buffer, x_dst, x_limit);=
 =20
> >=20
> > I thought it was a count, not a limit?
> >=20
> > "Limit" sounds to me like "end", and end - start =3D count. =20
>=20
> It is effectively a pixel count. I just took those naming from the=20
> original pre_mul_alpha_blend. I will change it to pixel_count.
>=20
> Thanks,
> Louis Chauvet
>=20
> > >  		}
> > > =20
> > >  		apply_lut(crtc_state, output_buffer);
> > >  =20
> >=20
> > The details aside, this is a good move.
> >=20
> >=20
> > Thanks,
> > pq =20
>=20
>=20
>=20


--Sig_/BpgFWwG.B4zFeuVTStC0wqj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmYEB4UACgkQI1/ltBGq
qqdORBAAnCedEcvQbA5YNgvJhMd6M7Ee8pjqvxsC+9jBy0MYwfosnYIB1E9jbDcl
2QZNb8/bH9Cuv7muJWqeCGTwyygMmyNltMqBUE81gDXKOETkr7EVWhfItch5vuQV
W5OtRnave1L6X8qm9vJGAKTAaX5gcWEppogMyhRQ9ujhx57W+aF19aqS8Y2NmqKq
+X2C46O5fU9a9dVTvp2aQkmxG5fOUxoHls4TL/wsyXvgzMyPVGPgf7DvI364GdWu
twYXhUMH0XWlLgVd8Ka1RCJGc1FgLU2/l9wNcnoLbaa6OGiFr7Gl8/4vHiaXuUDi
l4ukf0J6cb2UfGXr2w3MY8ODsZWxHu6XLuqRXcTunefooAZYwSmB/Q3B26TdmEgB
1NMTJpLvKf2MnLcu2Lz9/6qPc7GmGmO/a+q5o3Kj7J7Uo+s6Dlx5WxOmii4d/hxi
ig6PQQLIpchBI8ytsPavQmsYyMm4SY5z8gIluNH39cSMw4RbQ8XBQ+62dZlaG9xk
Oohg7DS5ag8+OSGmb9fOANhOYtIb7UY4RXYivROJDg6B3RJMkwPViiTphV8Cqw0c
JbGIzyLQCeJv9po/9vjNMXS2ObZRaM/lZlH/3i8BlMrQkG7bDC2YE6qIsPgIRMSb
9nnpHOrSujO8eH8WljdqnosopA5s/Y4sOG06AsUUvjKV4Klyvvw=
=LoLO
-----END PGP SIGNATURE-----

--Sig_/BpgFWwG.B4zFeuVTStC0wqj--

