Return-Path: <linux-kernel+bounces-145329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB42C8A52D9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70CBD282BFB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B70374C04;
	Mon, 15 Apr 2024 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXygLDxb"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73C33D0D9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190585; cv=none; b=hrlUTKn2I6ZculnaEb1J9bgboSPazblMZ0ueQ/+FUevM3vUejf65CY8aT5x/T0+/CGatqmjuc1C2YJpWQxRTp85PnZ7KF5nSxJB3/W/YSy7subJOHt1Bi09qfVuuLkEkjRDQb7YNY9EsmGn+J740FvxIutFaIsmw/6W6Tpl7ARM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190585; c=relaxed/simple;
	bh=5j50+LNubO51nxnR2JJ43o5/CyCmoDd9nwGW7qI3y8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PA6ljoO0NJ77VniL6bW70mMap8l6X3hx2OxcFyaix7GKD8ijQQVREyjdiUV2cS6vb2UrvjM0awdw7FSuFvo8WiRZUgmpWF7A+LJ0/7zil/GS3brtBQAsBe7VZie9BSs6M2iV+QfdlO60592ZQBDUvePB8G/TCrQXzWMRR1Llwf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXygLDxb; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso2691940b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713190583; x=1713795383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QfWZ6p4Ra3V5a1g7hJEFDN7tbjxd+ey9ZnLhDNNg/5k=;
        b=EXygLDxbZ61Ky39psJOrRrtDUsMMnqByLgbbbL3bs1Pu0eeG4tjhwasHNhLx6YWerv
         xH/yHcJlR0uqKtYCH6CwDRFq7LYWC6Cql3sPbIf7E9eXZHddxpu8cDs8bZUmz2F9YTSX
         Dzv3arzrEzTK3xol7LUblgJYPExAS2t91pxNZd9gOybEa5si/yuCg3qf59a1qzp0SkBb
         h8EKbncCCgwUQfdFi4ceC3xMzhvNujtuorNW2gTGiycRq93MjPEsX7OctZkiFAKup10b
         TVb+6u1R0gL554wYOee7+P3PCW09q8br9Iv6Qb2JFVx86+gkHz05bC4h38sUeEatCFoV
         WJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713190583; x=1713795383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfWZ6p4Ra3V5a1g7hJEFDN7tbjxd+ey9ZnLhDNNg/5k=;
        b=d0dCj8gBNK85DG9u+z8KJc/Qw6j5QhLT6NkHpkOFbyjUGgkaUTHcT4RKLjC2S7UubO
         kv2mwNcBeB0WD90PYy4/jasyrVSBwTM8PVUhNyGYooUmvy+o/8a02uYJ7tPOcxuuatj+
         Y2SxGhDv+5HWEzyPTnpQAq6z0ICQKYLYz9J9P08RrWxvZpi9NYwt6MjsiEpE46USh6k/
         9BlqPm7hSg8CFF5A9bmN9SCuzivfpoAXGiNiTXYFqUVXHKAlWx0xi+ivd7xvrYE5k7kM
         H9i14fE1WhvFJspw+vFo3vX34E70pLdkB8RgpCvsbjyh4UHYlgnD24ZKnTCn5EqX7VLU
         rXXw==
X-Forwarded-Encrypted: i=1; AJvYcCWo84SUIbZU/BTsp6SiK9/CkjCgEgX4UIauyJNj2r6KM7xcKnb+tIUqvFkVxl1j/Vgl4dcZuXwu9BiBhnscfUdsZ9mDgWh9wdkoJbtm
X-Gm-Message-State: AOJu0YycmrzYkLOHpFxL8ci9J9D4CRde6kNUvDjaZI52172Qw3gHwGTT
	rU6jrircvTNzF712XMSJT5xaSzeyTlrerIjnSU4/HKBq09JXSNxk
X-Google-Smtp-Source: AGHT+IHx7ybRjl1lX/qgj18sR8Rm0HIVycuQyLLVmCr1H4BxvhQQKLOseYfd8ym1djHwIJvXLoSI2Q==
X-Received: by 2002:a05:6a00:1406:b0:6ec:d76b:6fac with SMTP id l6-20020a056a00140600b006ecd76b6facmr11387342pfu.12.1713190582734;
        Mon, 15 Apr 2024 07:16:22 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id y16-20020a056a00181000b006ed9760b815sm7237942pfa.211.2024.04.15.07.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 07:16:22 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 59A891832065F; Mon, 15 Apr 2024 21:16:19 +0700 (WIB)
Date: Mon, 15 Apr 2024 21:16:18 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
	pekka.paalanen@collabora.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 3/3] drm/fourcc: Add documentation around drm_format_info
Message-ID: <Zh02sk_NAy6eMSCt@archie.me>
References: <20240409-google-drm-doc-v1-0-033d55cc8250@bootlin.com>
 <20240409-google-drm-doc-v1-3-033d55cc8250@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/AhLcWdqLXTIlsLz"
Content-Disposition: inline
In-Reply-To: <20240409-google-drm-doc-v1-3-033d55cc8250@bootlin.com>


--/AhLcWdqLXTIlsLz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2024 at 12:04:07PM +0200, Louis Chauvet wrote:
>  /**
>   * struct drm_format_info - information about a DRM format
> + *
> + * A drm_format_info describes how planes and pixels are stored in memor=
y.
> + *
> + * Some format like YUV can have multiple planes, counted in @num_planes=
=2E It
> + * means that a full pixel can be stored in multiple non-continuous buff=
ers.
> + * For example, NV12 is a YUV format using two planes: one for the Y val=
ues and
> + * one for the UV values.
> + *
> + * On each plane, the "pixel" unit can be different in case of subsampli=
ng. For
> + * example with the NV12 format, a pixel in the UV plane is used for fou=
r pixels
> + * in the Y plane.
> + * The fields @hsub and @vsub are the relation between the size of the m=
ain
> + * plane and the size of the subsampled planes in pixels:
> + *	plane[0] width =3D hsub * plane[1] width
> + *	plane[0] height =3D vsub * plane[1] height
> + *
> + * In some formats, pixels are not independent in memory. It can be a pa=
cked
> + * representation to store more pixels per byte (for example P030 uses 4=
 bytes
> + * for three 10 bit pixels). It can also be used to represent tiled form=
ats,
> + * where a continuous buffer in memory can represent a rectangle of pixe=
ls (for
> + * example, in DRM_FORMAT_Y0L0, a buffer of 8 bytes represents a 2x2 pix=
el
> + * region of the picture).
> + *	The field @char_per_block is the size of a block on a specific plane,=
 in
> + *	bytes.
> + *	The fields @block_w and @block_h are the size of a block in pixels.
> + *
> + * The older format representation (which only uses @cpp, kept for histo=
rical
> + * reasons because there are a lot of places in drivers where it's used)=
 is
> + * assuming that a block is always 1x1 pixel.
> + *
> + * To keep the compatibility with older format representations and treat=
 block
> + * and non-block formats in the same way one should use:
> + *	- @char_per_block to access the size of a block on a specific plane, =
in
> + *	bytes.
> + *	- drm_format_info_block_width() to access the width of a block of a
> + *	specific plane, in pixels.
> + *	- drm_format_info_block_height() to access the height of a block of a
> + *	specific plane, in pixels.
>   */
>  struct drm_format_info {
>  	/** @format: 4CC format identifier (DRM_FORMAT_*) */
> @@ -97,13 +135,6 @@ struct drm_format_info {
>  		 * formats for which the memory needed for a single pixel is not
>  		 * byte aligned.
>  		 *
> -		 * @cpp has been kept for historical reasons because there are
> -		 * a lot of places in drivers where it's used. In drm core for
> -		 * generic code paths the preferred way is to use
> -		 * @char_per_block, drm_format_info_block_width() and
> -		 * drm_format_info_block_height() which allows handling both
> -		 * block and non-block formats in the same way.
> -		 *
>  		 * For formats that are intended to be used only with non-linear
>  		 * modifiers both @cpp and @char_per_block must be 0 in the
>  		 * generic format table. Drivers could supply accurate
>=20

Sphinx reports htmldocs warnings:

Documentation/gpu/drm-kms:357: ./include/drm/drm_fourcc.h:74: ERROR: Unexpe=
cted indentation.
Documentation/gpu/drm-kms:357: ./include/drm/drm_fourcc.h:83: ERROR: Unexpe=
cted indentation.
Documentation/gpu/drm-kms:357: ./include/drm/drm_fourcc.h:93: ERROR: Unexpe=
cted indentation.
Documentation/gpu/drm-kms:357: ./include/drm/drm_fourcc.h:94: WARNING: Bull=
et list ends without a blank line; unexpected unindent.

I have to fix up the lists:

---- >8 ----
diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index 66cc30e28f794a..10ee74fa46d21e 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -71,8 +71,9 @@ struct drm_mode_fb_cmd2;
  * in the Y plane.
  * The fields @hsub and @vsub are the relation between the size of the main
  * plane and the size of the subsampled planes in pixels:
- *	plane[0] width =3D hsub * plane[1] width
- *	plane[0] height =3D vsub * plane[1] height
+ *
+ *	- plane[0] width =3D hsub * plane[1] width
+ *	- plane[0] height =3D vsub * plane[1] height
  *
  * In some formats, pixels are not independent in memory. It can be a pack=
ed
  * representation to store more pixels per byte (for example P030 uses 4 b=
ytes
@@ -80,9 +81,10 @@ struct drm_mode_fb_cmd2;
  * where a continuous buffer in memory can represent a rectangle of pixels=
 (for
  * example, in DRM_FORMAT_Y0L0, a buffer of 8 bytes represents a 2x2 pixel
  * region of the picture).
- *	The field @char_per_block is the size of a block on a specific plane, in
- *	bytes.
- *	The fields @block_w and @block_h are the size of a block in pixels.
+ *
+ *	- The field @char_per_block is the size of a block on a specific plane,
+ *	  in bytes.
+ *	- The fields @block_w and @block_h are the size of a block in pixels.
  *
  * The older format representation (which only uses @cpp, kept for histori=
cal
  * reasons because there are a lot of places in drivers where it's used) is
@@ -90,12 +92,13 @@ struct drm_mode_fb_cmd2;
  *
  * To keep the compatibility with older format representations and treat b=
lock
  * and non-block formats in the same way one should use:
+ *
  *	- @char_per_block to access the size of a block on a specific plane, in
- *	bytes.
+ *	  bytes.
  *	- drm_format_info_block_width() to access the width of a block of a
- *	specific plane, in pixels.
+ *	  specific plane, in pixels.
  *	- drm_format_info_block_height() to access the height of a block of a
- *	specific plane, in pixels.
+ *	  specific plane, in pixels.
  */
 struct drm_format_info {
 	/** @format: 4CC format identifier (DRM_FORMAT_*) */

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--/AhLcWdqLXTIlsLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZh02rgAKCRD2uYlJVVFO
o/AIAP9nAjuvp2Syyy0KsbDw+mAbk2nVyjWPoMzlKnG+nYAn3gD/fAP+e2p93os3
hY0n5qJZp+AlZtoBCoICJkxphd2UCQM=
=NyHa
-----END PGP SIGNATURE-----

--/AhLcWdqLXTIlsLz--

