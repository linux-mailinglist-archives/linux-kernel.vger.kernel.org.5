Return-Path: <linux-kernel+bounces-153262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AD28ACBA5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C80DC1C224F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66722146012;
	Mon, 22 Apr 2024 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2YX2Y/hE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CFA482C1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784084; cv=none; b=UBf2+kecg7dLoAVUI1NVjJH5hUhnDUeOnMOuB+4FZDtKul1s0IpFDJTj/9bl+X7Zf3qyovv9N2R3ylekdu8WmOvUxjJWG9wsSt0b5oO9XxxiiVNp6PDc6+FBeL0BMPnkLMrX3ZTDIQg0n/JDk8CrDlLpEqBwiBpJzlAPi8kmm2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784084; c=relaxed/simple;
	bh=zg9qrtgRE2UpeYA1ByK9XyduO2fhr+naoASgNwaaX/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pNrY28Irygn+FoYbrVRkWFM97/QWnqQU+iIxCBBbvC7LnG64oTEbZOGQ6ad4hEFo6feEX0zcc0vW2eyjb8HxO8I321xF8UQx65MdaZz/iEDpDgI8HoeFJ1omBFBfLLjSuwjXz0z2oDz+yoJEN1p2QEaytCo/DYzocQC1y7oCAro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2YX2Y/hE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713784080;
	bh=zg9qrtgRE2UpeYA1ByK9XyduO2fhr+naoASgNwaaX/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2YX2Y/hEFn6Vxgq852GZEx45Nn3GWycfbPuPdxJ43qQsFR9dU9tFIN3dw/RjHblaN
	 pq789pZV1qVPFhmbjkoYUrd/OTIuKaa5JT7XvK9YDfaKLtnu66I2rQXLo4fgEsi1uN
	 8vZ0UutDo1sIC6eg9adR4xy2SfzDZpS7Ha0hfVePpnqkqk2JdaD2+gIPd+4yGK3avA
	 ZLjHzqcNutGI8YllX4f9VL6fQNLNPNErEV+cdm4C2uVadjPH3kamZiuaoNAS9RDwc6
	 Z/xlmLhYVT/TU6VqkZWv0OAQfiW8C+fN4LnhIGNqCYRVxXdhPEJEyo+hORMoxUulaF
	 VCni1+zPd43HA==
Received: from eldfell (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pq)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4DDB93780C22;
	Mon, 22 Apr 2024 11:07:59 +0000 (UTC)
Date: Mon, 22 Apr 2024 14:07:57 +0300
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
Subject: Re: [PATCH v6 07/17] drm/vkms: Update pixels accessor to support
 packed and multi-plane formats.
Message-ID: <20240422140757.576e363b.pekka.paalanen@collabora.com>
In-Reply-To: <20240409-yuv-v6-7-de1c5728fd70@bootlin.com>
References: <20240409-yuv-v6-0-de1c5728fd70@bootlin.com>
	<20240409-yuv-v6-7-de1c5728fd70@bootlin.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ayru+Gaj1xtpkU2yOI3bjdC";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ayru+Gaj1xtpkU2yOI3bjdC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 09 Apr 2024 15:25:25 +0200
Louis Chauvet <louis.chauvet@bootlin.com> wrote:

> Introduce the usage of block_h/block_w to compute the offset and the
> pointer of a pixel. The previous implementation was specialized for
> planes with block_h =3D=3D block_w =3D=3D 1. To avoid confusion and allow=
 easier
> implementation of tiled formats. It also remove the usage of the
> deprecated format field `cpp`.
>=20
> Introduce the plane_index parameter to get an offset/pointer on a
> different plane.
>=20
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_formats.c | 110 ++++++++++++++++++++++++++++--=
------
>  1 file changed, 87 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/v=
kms_formats.c
> index 69cf9733fec5..9a1400ad4db6 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -10,22 +10,43 @@
>  #include "vkms_formats.h"
> =20
>  /**
> - * pixel_offset() - Get the offset of the pixel at coordinates x/y in th=
e first plane
> + * packed_pixels_offset() - Get the offset of the block containing the p=
ixel at coordinates x/y
>   *
>   * @frame_info: Buffer metadata
>   * @x: The x coordinate of the wanted pixel in the buffer
>   * @y: The y coordinate of the wanted pixel in the buffer
> + * @plane_index: The index of the plane to use
> + * @offset: The returned offset inside the buffer of the block
> + * @rem_x,@rem_y: The returned coordinate of the requested pixel in the =
block
>   *
> - * The caller must ensure that the framebuffer associated with this requ=
est uses a pixel format
> - * where block_h =3D=3D block_w =3D=3D 1.
> - * If this requirement is not fulfilled, the resulting offset can point =
to an other pixel or
> - * outside of the buffer.
> + * As some pixel formats store multiple pixels in a block (DRM_FORMAT_R*=
 for example), some
> + * pixels are not individually addressable. This function return 3 value=
s: the offset of the
> + * whole block, and the coordinate of the requested pixel inside this bl=
ock.
> + * For example, if the format is DRM_FORMAT_R1 and the requested coordin=
ate is 13,5, the offset
> + * will point to the byte 5*pitches + 13/8 (second byte of the 5th line)=
, and the rem_x/rem_y
> + * coordinates will be (13 % 8, 5 % 1) =3D (5, 0)
> + *
> + * With this function, the caller just have to extract the correct pixel=
 from the block.
>   */
> -static size_t pixel_offset(const struct vkms_frame_info *frame_info, int=
 x, int y)
> +static void packed_pixels_offset(const struct vkms_frame_info *frame_inf=
o, int x, int y,
> +				 int plane_index, int *offset, int *rem_x, int *rem_y)
>  {
>  	struct drm_framebuffer *fb =3D frame_info->fb;
> +	const struct drm_format_info *format =3D frame_info->fb->format;
> +	/* Directly using x and y to multiply pitches and format->ccp is not su=
fficient because
> +	 * in some formats a block can represent multiple pixels.
> +	 *
> +	 * Dividing x and y by the block size allows to extract the correct off=
set of the block
> +	 * containing the pixel.
> +	 */
> =20
> -	return fb->offsets[0] + (y * fb->pitches[0]) + (x * fb->format->cpp[0]);
> +	int block_x =3D x / drm_format_info_block_width(format, plane_index);
> +	int block_y =3D y / drm_format_info_block_height(format, plane_index);
> +	*rem_x =3D x % drm_format_info_block_width(format, plane_index);
> +	*rem_y =3D y % drm_format_info_block_height(format, plane_index);
> +	*offset =3D fb->offsets[plane_index] +
> +		  block_y * fb->pitches[plane_index] +
> +		  block_x * format->char_per_block[plane_index];

I started thinking... is

+		  block_y * fb->pitches[plane_index] +

correct, or should it be

+		  y * fb->pitches[plane_index] +

?

I'm looking at drm_format_info_min_pitch() which sounds like it should
be the latter? Because of

        return DIV_ROUND_UP_ULL((u64)buffer_width * info->char_per_block[pl=
ane],
                            drm_format_info_block_width(info, plane) *
                            drm_format_info_block_height(info, plane));

in drm_format_info_min_pitch().

Btw. maybe this should check that the result is not negative (e.g. due
to overflow)? Or does that even work since signed overflow is undefined
behavior (UB) and compilers may assume UB does not happen, causing the
check to be eliminated as dead code?

Otherwise this patch looks ok to me.


Thanks,
pq

>  }
> =20
>  /**
> @@ -35,30 +56,70 @@ static size_t pixel_offset(const struct vkms_frame_in=
fo *frame_info, int x, int
>   * @frame_info: Buffer metadata
>   * @x: The x (width) coordinate inside the plane
>   * @y: The y (height) coordinate inside the plane
> + * @plane_index: The index of the plane
> + * @addr: The returned pointer
> + * @rem_x,@rem_y: The returned coordinate of the requested pixel in the =
block
>   *
> - * Takes the information stored in the frame_info, a pair of coordinates=
, and
> - * returns the address of the first color channel.
> - * This function assumes the channels are packed together, i.e. a color =
channel
> - * comes immediately after another in the memory. And therefore, this fu=
nction
> - * doesn't work for YUV with chroma subsampling (e.g. YUV420 and NV21).
> + * Takes the information stored in the frame_info, a pair of coordinates=
, and returns the address
> + * of the block containing this pixel and the pixel position inside this=
 block.
>   *
> - * The caller must ensure that the framebuffer associated with this requ=
est uses a pixel format
> - * where block_h =3D=3D block_w =3D=3D 1, otherwise the returned pointer=
 can be outside the buffer.
> + * See @packed_pixel_offset for details about rem_x/rem_y behavior.
>   */
> -static void *packed_pixels_addr(const struct vkms_frame_info *frame_info,
> -				int x, int y)
> +static void packed_pixels_addr(const struct vkms_frame_info *frame_info,
> +			       int x, int y, int plane_index, u8 **addr, int *rem_x,
> +			       int *rem_y)
>  {
> -	size_t offset =3D pixel_offset(frame_info, x, y);
> +	int offset;
> =20
> -	return (u8 *)frame_info->map[0].vaddr + offset;
> +	packed_pixels_offset(frame_info, x, y, plane_index, &offset, rem_x, rem=
_y);
> +	*addr =3D (u8 *)frame_info->map[0].vaddr + offset;
>  }
> =20
> -static void *get_packed_src_addr(const struct vkms_frame_info *frame_inf=
o, int y)
> +/**
> + * packed_pixels_addr_1x1() - Get the pointer to the block containing th=
e pixel at the given
> + * coordinates
> + *
> + * @frame_info: Buffer metadata
> + * @x: The x (width) coordinate inside the plane
> + * @y: The y (height) coordinate inside the plane
> + * @plane_index: The index of the plane
> + * @addr: The returned pointer
> + *
> + * This function can only be used with format where block_h =3D=3D block=
_w =3D=3D 1.
> + */
> +static void packed_pixels_addr_1x1(const struct vkms_frame_info *frame_i=
nfo,
> +				   int x, int y, int plane_index, u8 **addr)
> +{
> +	int offset, rem_x, rem_y;
> +
> +	WARN_ONCE(drm_format_info_block_width(frame_info->fb->format,
> +					      plane_index) !=3D 1,
> +		"%s() only support formats with block_w =3D=3D 1", __func__);
> +	WARN_ONCE(drm_format_info_block_height(frame_info->fb->format,
> +					       plane_index) !=3D 1,
> +		"%s() only support formats with block_h =3D=3D 1", __func__);
> +
> +	packed_pixels_offset(frame_info, x, y, plane_index, &offset, &rem_x,
> +			     &rem_y);
> +	*addr =3D (u8 *)frame_info->map[0].vaddr + offset;
> +}
> +
> +static void *get_packed_src_addr(const struct vkms_frame_info *frame_inf=
o, int y,
> +				 int plane_index)
>  {
>  	int x_src =3D frame_info->src.x1 >> 16;
>  	int y_src =3D y - frame_info->rotated.y1 + (frame_info->src.y1 >> 16);
> +	u8 *addr;
> +	int rem_x, rem_y;
> +
> +	WARN_ONCE(drm_format_info_block_width(frame_info->fb->format, plane_ind=
ex) !=3D 1,
> +		  "%s() only support formats with block_w =3D=3D 1", __func__);
> +	WARN_ONCE(drm_format_info_block_height(frame_info->fb->format, plane_in=
dex) !=3D 1,
> +		  "%s() only support formats with block_h =3D=3D 1", __func__);
> =20
> -	return packed_pixels_addr(frame_info, x_src, y_src);
> +	packed_pixels_addr(frame_info, x_src, y_src, plane_index, &addr, &rem_x=
, &rem_y);
> +
> +	return addr;
>  }
> =20
>  static int get_x_position(const struct vkms_frame_info *frame_info, int =
limit, int x)
> @@ -167,14 +228,14 @@ void vkms_compose_row(struct line_buffer *stage_buf=
fer, struct vkms_plane_state
>  {
>  	struct pixel_argb_u16 *out_pixels =3D stage_buffer->pixels;
>  	struct vkms_frame_info *frame_info =3D plane->frame_info;
> -	u8 *src_pixels =3D get_packed_src_addr(frame_info, y);
> +	u8 *src_pixels =3D get_packed_src_addr(frame_info, y, 0);
>  	int limit =3D min_t(size_t, drm_rect_width(&frame_info->dst), stage_buf=
fer->n_pixels);
> =20
>  	for (size_t x =3D 0; x < limit; x++, src_pixels +=3D frame_info->fb->fo=
rmat->cpp[0]) {
>  		int x_pos =3D get_x_position(frame_info, limit, x);
> =20
>  		if (drm_rotation_90_or_270(frame_info->rotation))
> -			src_pixels =3D get_packed_src_addr(frame_info, x + frame_info->rotate=
d.y1)
> +			src_pixels =3D get_packed_src_addr(frame_info, x + frame_info->rotate=
d.y1, 0)
>  				+ frame_info->fb->format->cpp[0] * y;
> =20
>  		plane->pixel_read(src_pixels, &out_pixels[x_pos]);
> @@ -275,7 +336,10 @@ void vkms_writeback_row(struct vkms_writeback_job *w=
b,
>  {
>  	struct vkms_frame_info *frame_info =3D &wb->wb_frame_info;
>  	int x_dst =3D frame_info->dst.x1;
> -	u8 *dst_pixels =3D packed_pixels_addr(frame_info, x_dst, y);
> +	u8 *dst_pixels;
> +	int rem_x, rem_y;
> +
> +	packed_pixels_addr(frame_info, x_dst, y, 0, &dst_pixels, &rem_x, &rem_y=
);
>  	struct pixel_argb_u16 *in_pixels =3D src_buffer->pixels;
>  	int x_limit =3D min_t(size_t, drm_rect_width(&frame_info->dst), src_buf=
fer->n_pixels);
> =20
>=20


--Sig_/ayru+Gaj1xtpkU2yOI3bjdC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmYmRQ0ACgkQI1/ltBGq
qqey+xAAobaAzGoi/ZARnUF6tZSjCPLP7Q9DUsB3YQq8lfhubhS3F94TOodnhhBE
HaVLAxzsCLyJ72+lpgpZP6WyytflD3dN+RSzXfJ6vu2nMsZeBmwYx0oGXFtnCAxj
0y7Unjn2iJofzHxgUER1WAM/tNjh5COyme0lXKmevGHLNYUyP5rcu+8kwWpAi38s
RU54xwUxrk4U82XYpFbp7mkEIY62OCVNollifqgCPwfJ5vB5RcmPozsCV/OJIp/o
sJHz3ayIXq/6AQP0DW/wkrNV0V9r2CuLXVAYRLJXOTUwmYuWa1vexMB6dqIXC8+R
Btp/Xdl1NOGDmgPt9FvIWfFGzifXXbcJOkQVfpa4GpfmkLZDxVbncoD+b93awL7G
LeIzCz0iU4DoDEBIwCvIKHdVMgkLP0gJx0yV2sNL6JM40pdrRkveo6oLnM45IVBs
hHDSEv5uzEMcrtMfCCjMtxedRDNLL0v1q6rKWiYJCDmVhWqv5hg6AfKUTLtiPFOh
tD9oAgAyGDeQRMGESv9Iyl/T+JLb45ZIgtf0vTKUbC9sGekj+Br3h1VtkY4d2EG1
ik6ytqCrVmRrarR4wrx+rszlvsKqAzXu5zVCpOsi20hQWntIJi1y8ojYftZLGlKk
pQLC+eblRz6bqPR+Vn0C4Z8OGsz1/nfLKiQznTA0OTEUFD+fBys=
=ERQv
-----END PGP SIGNATURE-----

--Sig_/ayru+Gaj1xtpkU2yOI3bjdC--

