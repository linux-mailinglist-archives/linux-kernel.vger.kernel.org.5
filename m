Return-Path: <linux-kernel+bounces-155368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 318628AE96D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B16E1F22A62
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24EE13B2B8;
	Tue, 23 Apr 2024 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Q5UZ4GHQ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E536A03F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882416; cv=none; b=MLXD8VDWGEYBf9THOVvs8xJ2uJiLmyJz4JIbX0MtEyy8coZW7QnIlREeHNUiiTkDDI/Z27fYtj/Z+Cq5TfiF7lbKYLyHskQdjIzMgpiaAweXfdRWBKbw5lCBUeDme/DAaCtq8Ol/KwhCc80+S4iC+o3ABUEYvRGP958TCzwWCD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882416; c=relaxed/simple;
	bh=95hNE3qu5btyaFiIcsb/7+lWda+/1mYFsf8+WoOgRX8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bhWNvHHJo/yaMis0/s2POkDS+RcyIfyjPVh3y6dIS2EaqC4ahqoyAZCXxFcH0vDC2JahCpQiQQzsSuYuOt2Wz49twD5/OhfS49wXttG4KxIuoMrbm3/e/G2WZGKXrthnFcgQN31lN0Tgp/Vd2tTL2iEM63v4BR8fZ2GLjBHUiTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Q5UZ4GHQ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713882412;
	bh=95hNE3qu5btyaFiIcsb/7+lWda+/1mYFsf8+WoOgRX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q5UZ4GHQqII0zc7Y94U1ReoETAHqNYBogi47u5oNvYU5fKKWoMGHQCyeoFxKS6Cgm
	 LUkPXubg8t1LIZ0sYmR7DJpYhryTPLwcjf2hU5j2Uz39Ob52h4GGd4hqprlGsGpL0l
	 0HVgbQt2oChHqoSZYMymLMtwyuf3sfbOHn0+N3hs22rGdmxVRXaZyeyvLKD9i+WG/r
	 jtrbjR+YsYD+A2pxP88EdMs3dLDiuodEB26TCwV+9FYDTdfpMjHxFgZ0UJDYk5Zm2R
	 0+uoLdqEBciWTGbwe+2ZHES0q/dfEKogxGMuVdbh2zAkfyorK8+9nBrPL2nWD0RLwZ
	 hKo4t0AW1jcoA==
Received: from eldfell (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pq)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 33C6B3780C22;
	Tue, 23 Apr 2024 14:26:51 +0000 (UTC)
Date: Tue, 23 Apr 2024 17:26:49 +0300
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, Melissa Wen
 <melissa.srw@gmail.com>, =?UTF-8?B?TWHDrXJh?= Canal
 <mairacanal@riseup.net>, Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 rdunlap@infradead.org, arthurgrillo@riseup.net, Jonathan Corbet
 <corbet@lwn.net>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
Subject: Re: [PATCH v6 17/17] drm/vkms: Add support for DRM_FORMAT_R*
Message-ID: <20240423172649.0375fa38.pekka.paalanen@collabora.com>
In-Reply-To: <20240409-yuv-v6-17-de1c5728fd70@bootlin.com>
References: <20240409-yuv-v6-0-de1c5728fd70@bootlin.com>
	<20240409-yuv-v6-17-de1c5728fd70@bootlin.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//l8=8HvAxry37/MKoDecP+y";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_//l8=8HvAxry37/MKoDecP+y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 09 Apr 2024 15:25:35 +0200
Louis Chauvet <louis.chauvet@bootlin.com> wrote:

> This add the support for:
> - R1/R2/R4/R8
>=20
> R1 format was tested with [1] and [2].
>=20
> [1]: https://lore.kernel.org/r/20240313-new_rotation-v2-0-6230fd5cae59@bo=
otlin.com
> [2]: https://lore.kernel.org/igt-dev/20240306-b4-kms_tests-v1-0-8fe451efd=
2ac@bootlin.com/
>=20
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_formats.c | 101 ++++++++++++++++++++++++++++++=
++++++
>  drivers/gpu/drm/vkms/vkms_plane.c   |   4 ++
>  2 files changed, 105 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/v=
kms_formats.c
> index ca9028c1ef1a..7f49995686fd 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -237,6 +237,11 @@ static struct pixel_argb_u16 argb_u16_from_RGB565(co=
nst u16 *pixel)
>  	return out_pixel;
>  }
> =20
> +static struct pixel_argb_u16 argb_u16_from_gray8(u8 gray)
> +{
> +	return argb_u16_from_u8888(255, gray, gray, gray);
> +}
> +
>  VISIBLE_IF_KUNIT struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 cha=
nnel_1, u8 channel_2,
>  							   const struct conversion_matrix *matrix)
>  {
> @@ -302,6 +307,94 @@ static void magenta_to_argb_u16(const struct vkms_pl=
ane_state *plane, int x_star
>  	}
>  }
> =20
> +static void Rx_read_line(const struct vkms_plane_state *plane, int x_sta=
rt,
> +			 int y_start, enum pixel_read_direction direction, int count,
> +			 struct pixel_argb_u16 out_pixel[], u8 bit_per_pixel, u8 lum_per_leve=
l)

Hi Louis,

I guess for R1, R2 and R4, you would get both bit_per_pixel and
lum_per_level from the pixel format info?

bits_per_pixel =3D drm_format_info_bpp(...)

lum_per_level =3D 0xFF / (1 << bits_per_pixel - 1) =3D 0xFF / mask

or even 0xFFFF so you get the 16-bit value directly.

> +{
> +	struct pixel_argb_u16 *end =3D out_pixel + count;
> +	u8 *src_pixels;
> +	int rem_x, rem_y;
> +
> +	WARN_ONCE(drm_format_info_block_height(plane->frame_info->fb->format, 0=
) !=3D 1,
> +		  "%s() only support formats with block_h =3D=3D 1", __func__);
> +
> +	packed_pixels_addr(plane->frame_info, x_start, y_start, 0, &src_pixels,=
 &rem_x, &rem_y);
> +	int bit_offset =3D (8-bit_per_pixel) - rem_x * bit_per_pixel;
> +	int step =3D get_block_step_byte(plane->frame_info->fb, direction, 0);
> +	int mask =3D (0x1 << bit_per_pixel) - 1;

Bit masks are best unsigned, because a signed shift-right of a value
will replicate the old highest bit to all the new high bits. That might
be a surprise if the old value happens to be negative.

> +
> +	if (direction =3D=3D READ_LEFT_TO_RIGHT || direction =3D=3D READ_RIGHT_=
TO_LEFT) {
> +		int restart_bit_offset;
> +		int step_bit_offset;
> +
> +		if (direction =3D=3D READ_LEFT_TO_RIGHT) {
> +			restart_bit_offset =3D 8 - bit_per_pixel;
> +			step_bit_offset =3D -bit_per_pixel;
> +		} else {
> +			restart_bit_offset =3D 0;
> +			step_bit_offset =3D bit_per_pixel;
> +		}
> +
> +		while (out_pixel < end) {
> +			u8 val =3D ((*src_pixels) >> bit_offset) & mask;
> +
> +			*out_pixel =3D argb_u16_from_gray8(val * lum_per_level);
> +
> +			bit_offset +=3D step_bit_offset;
> +			if (bit_offset < 0 || 8 <=3D bit_offset) {
> +				bit_offset =3D restart_bit_offset;
> +				src_pixels +=3D step;
> +			}
> +			out_pixel +=3D 1;
> +		}
> +	} else if (direction =3D=3D READ_TOP_TO_BOTTOM || direction =3D=3D READ=
_BOTTOM_TO_TOP) {
> +		while (out_pixel < end) {
> +			u8 val =3D (*src_pixels >> bit_offset) & mask;
> +			*out_pixel =3D argb_u16_from_gray8(val * lum_per_level);
> +			src_pixels +=3D step;
> +			out_pixel +=3D 1;
> +		}
> +	}
> +}
> +
> +static void R1_read_line(const struct vkms_plane_state *plane, int x_sta=
rt,
> +			 int y_start, enum pixel_read_direction direction, int count,
> +			 struct pixel_argb_u16 out_pixel[])
> +{
> +	Rx_read_line(plane, x_start, y_start, direction, count, out_pixel, 1, 0=
xFF);
> +}
> +
> +static void R2_read_line(const struct vkms_plane_state *plane, int x_sta=
rt,
> +			 int y_start, enum pixel_read_direction direction, int count,
> +			 struct pixel_argb_u16 out_pixel[])
> +{
> +	Rx_read_line(plane, x_start, y_start, direction, count, out_pixel, 2, 0=
x55);
> +}
> +
> +static void R4_read_line(const struct vkms_plane_state *plane, int x_sta=
rt,
> +			 int y_start, enum pixel_read_direction direction, int count,
> +			 struct pixel_argb_u16 out_pixel[])
> +{
> +	Rx_read_line(plane, x_start, y_start, direction, count, out_pixel, 4, 0=
x11);
> +}
> +
> +static void R8_read_line(const struct vkms_plane_state *plane, int x_sta=
rt,
> +			 int y_start, enum pixel_read_direction direction, int count,
> +			 struct pixel_argb_u16 out_pixel[])
> +{
> +	struct pixel_argb_u16 *end =3D out_pixel + count;
> +	u8 *src_pixels;
> +	int step =3D get_block_step_byte(plane->frame_info->fb, direction, 0);
> +
> +	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pix=
els);
> +
> +	while (out_pixel < end) {
> +		*out_pixel =3D argb_u16_from_gray8(*src_pixels);
> +		src_pixels +=3D step;
> +		out_pixel +=3D 1;
> +	}
> +}
> +
>  static void ARGB8888_read_line(const struct vkms_plane_state *plane, int=
 x_start, int y_start,
>  			       enum pixel_read_direction direction, int count,
>  			       struct pixel_argb_u16 out_pixel[])
> @@ -625,6 +718,14 @@ pixel_read_line_t get_pixel_read_line_function(u32 f=
ormat)
>  	case DRM_FORMAT_YVU422:
>  	case DRM_FORMAT_YVU444:
>  		return &planar_yuv_read_line;
> +	case DRM_FORMAT_R1:
> +		return &R1_read_line;
> +	case DRM_FORMAT_R2:
> +		return &R2_read_line;
> +	case DRM_FORMAT_R4:
> +		return &R4_read_line;
> +	case DRM_FORMAT_R8:
> +		return &R8_read_line;
>  	default:
>  		/*
>  		 * This is a bug in vkms_plane_atomic_check(). All the supported
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkm=
s_plane.c
> index 8f764a108b00..67f891e7ac58 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -30,6 +30,10 @@ static const u32 vkms_formats[] =3D {
>  	DRM_FORMAT_YVU420,
>  	DRM_FORMAT_YVU422,
>  	DRM_FORMAT_YVU444,
> +	DRM_FORMAT_R1,
> +	DRM_FORMAT_R2,
> +	DRM_FORMAT_R4,
> +	DRM_FORMAT_R8,
>  };
> =20
>  static struct drm_plane_state *
>=20

This patch looks good to me, and the R8_read_line() is ok to have
separately, I guess for performance reasons.

I suggested a way to reduce the repetition between R1, R2, R4 a little
bit. With or without that:

Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>


Thanks,
pq

--Sig_//l8=8HvAxry37/MKoDecP+y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmYnxSkACgkQI1/ltBGq
qqerhA/+MdxogXs13wvNJapD5rtpFzzhT0xnPb7dPesC5I7YV8ILtzKMa52RFI3r
W/xY+0nfksbA4n9oF5O9Xb8au+384vnGlJ3kfTRwnnctoyS/pu2o5tHmwhqasCZK
kF/IkI0LjbEqEEbv5GyywtsJ8amwzHwH+CBWtLtlRlMNzTN0Q/0g6171yfFuGdIz
ISN+nv9TRTdnHz3R/WPT2OisVPnqWteDgLWxYqohec31Gt5PQeX7a1ScBeuf7/VI
0KDzDfnjvqrfl3Ha0GY9x2htJdL4v1dSFt4cc57kJoaaTp0GjeXZyYO9A94VpmUz
UAQUE2BcQNpmm02rwKtR/swW4dSjptJU1ZOl9siMYCxDGPAidKUh2YQOGd62P2ed
ACT46wJlela6KgH577BZFdA8eNN19Q2tOlEZ+1jbDxxGamWb2TnyjSVElXGHpJrn
kaITZFizmXrJVN0kEMfsYpOrFkO3OdbxAA1xS4REEWU6T5nzqw2kdzRSbFns9Jih
LVhn43PzC43vWYM7zWuZzPFtZZXz7D1tJksHxe1RbqMg1nMpNPNrx57AmR0ULnVQ
wExVKRed2kJOyTvEs01/ip3aiigQZZ+njAfFAaLxiBP2W4At3DYZESJYjLUV2AK8
IO61FnVoktIlsWvDXYJoSDfZNsiVpLeo6dKCpUQyvFM24xKhSJY=
=iyxH
-----END PGP SIGNATURE-----

--Sig_//l8=8HvAxry37/MKoDecP+y--

