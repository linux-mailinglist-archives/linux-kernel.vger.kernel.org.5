Return-Path: <linux-kernel+bounces-145354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6282A8A53B8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8B14B227F1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73137F7EF;
	Mon, 15 Apr 2024 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpXs78/Q"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A478874E25
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191307; cv=none; b=BeAvv1DsGQd8t2R/+MMp/llef83hW4cuKD9Eam0stMVy4m0PO3kXxVZf20pOyEiq3sXRqxtxetERS+0Qxvw5KCF5PtoNGWqFDBmfyXAcMAKYW/uLOePfASeJV+LxLeiK8khgDMnGSSf0sbR0VFE/UdGtBn1d5AK5R/MrcQjJWhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191307; c=relaxed/simple;
	bh=ytcogp74VJ66uuFEXxuGZV5D/Qv4HwWVONS/Jg5tnbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxWkN5iRDaYCbSkuo6XfShuGFo7madJoBXYA8T9ALgkIzOxLLGU3RWusp626Rg+9Zs/eUsbUXIYGIOqDGLildq/qUGVMcu3CmFcydzXNL7XPq+r3NIfXeS0M07ZwG5mOHwegcJFXu/SI3ViYI8adWxwawSNRWf+YmbDSoO/a0Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpXs78/Q; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6eff2be3b33so949899b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713191305; x=1713796105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dCR27t1hGGufnpVnvCmoWaIgC3EfAz+l4DjDvpX/Ib0=;
        b=RpXs78/Q4RyDnYJ8kW0Vtx3fnf2d3DQ6nUbUTyC1xvZ13m7yNyioyu6dy0YmuXK3SW
         5yKAxfptuGCWG+dwawE4+X7T+LdLjrmdbAM8KhzcWy/G/j39+Z1VCFOU55G5Woz2+q/Y
         4jxj+H9D/km0GLg5+uPgYj55GVBIfmy349XkX82MWg0ii3PHu4OcFNU9n3xzZ0WZ/rsH
         QNXc9JOvuG4ZpPoMtQgvxxdLaKwEy2CmwLLp02aLTyyvHEXa3xhi5wuii/FoRFNCBqyE
         MAMn7bFQdq+sr1FeiknhC2UAhAOh2Su22hUaeaeEOuNP8JEKEbuBhioABN2l5Gg+Oo3b
         ocvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713191305; x=1713796105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCR27t1hGGufnpVnvCmoWaIgC3EfAz+l4DjDvpX/Ib0=;
        b=EqCCwttEXc3Jx5SII+DnbVg9vfdOXFrWzufdLPbPr0HH/Ojg0kb6M1Rpfgy7XcA9oE
         +JFKHQcozp3o7azeclzCp4800tJ4Y+u9iOWFiHIWgCpQf63gJEh8UnRQ5HxxnZE9UBH0
         3OlAzbiGtDkMxMixRyYV/FG6CdcO14H6LTPkXlutTZfymLHD0ANK51HP7/lOiKOSnXVb
         bY1NGdoDWPp6KrwAqWmoDpccFguOyVCEyraqJ7JHuVu34ENCu2nxItPQmK+vpgoZpnmw
         QsBAL9E5Qm7uayJzmrydYDaQlRpu64Ip4s0yAENiThpCmhr3nI7qMrTAuujiW1a2r/rn
         5lZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTyneVAbzyBDvbh80P7FK8HpfUxzSeNL4ympqcsB5m1zSuB9Cs0mltOmre50mHUTRdVkD7ddAFteUWG/kD2jWXtZsz/v0MmeODtX4z
X-Gm-Message-State: AOJu0YwB8Uh2Mi3uYTm8Q95VaKo+WHXGmcUayNLK3gVOCeTLNlLRIfgH
	mppk2OA9X4bEOlrOI/V8F2PPoQjlxWdGb1TRVdCCF57TbZhIqIol
X-Google-Smtp-Source: AGHT+IEZsOXWoubXFpf8Vkx3wtYoY3Jn51Rk7KaombfQH8gQhzRsZEy2LZRoH/MX2zdMWNSfl4NpvQ==
X-Received: by 2002:a05:6a21:398f:b0:1a9:fe63:90f0 with SMTP id ad15-20020a056a21398f00b001a9fe6390f0mr3568262pzc.53.1713191304871;
        Mon, 15 Apr 2024 07:28:24 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id y25-20020aa78059000000b006ef97508163sm4349905pfm.37.2024.04.15.07.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 07:28:24 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9C0131B5EF086; Mon, 15 Apr 2024 21:28:22 +0700 (WIB)
Date: Mon, 15 Apr 2024 21:28:22 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
	pekka.paalanen@collabora.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 2/3] drm: drm_blend.c: Improve
 drm_plane_create_rotation_property kernel doc
Message-ID: <Zh05hqtB9owzjjez@archie.me>
References: <20240409-google-drm-doc-v1-0-033d55cc8250@bootlin.com>
 <20240409-google-drm-doc-v1-2-033d55cc8250@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j3zP2GZ4OPkidsR1"
Content-Disposition: inline
In-Reply-To: <20240409-google-drm-doc-v1-2-033d55cc8250@bootlin.com>


--j3zP2GZ4OPkidsR1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2024 at 12:04:06PM +0200, Louis Chauvet wrote:
> @@ -266,8 +257,41 @@ EXPORT_SYMBOL(drm_plane_create_alpha_property);
>   *
>   * Rotation is the specified amount in degrees in counter clockwise dire=
ction,
>   * the X and Y axis are within the source rectangle, i.e.  the X/Y axis =
before
> - * rotation. After reflection, the rotation is applied to the image samp=
led from
> - * the source rectangle, before scaling it to fit the destination rectan=
gle.
> + * rotation.
> + *
> + * Here are some examples of rotation and reflections:
> + *
> + * |o  +|  REFLECT_X  |+  o|
> + * |    |  =3D=3D=3D=3D=3D=3D=3D=3D>  |    |
> + * |    |             |    |
> + *
> + * |o   |  REFLECT_Y  |+   |
> + * |    |  =3D=3D=3D=3D=3D=3D=3D=3D>  |    |
> + * |+   |             |o   |
> + *
> + * |o  +|  ROTATE_90  |+   |
> + * |    |  =3D=3D=3D=3D=3D=3D=3D=3D>  |    |
> + * |    |             |o   |
> + *
> + * |o   |  ROTATE_180 |   +|
> + * |    |  =3D=3D=3D=3D=3D=3D=3D=3D>  |    |
> + * |+   |             |   o|
> + *
> + * |o   |  ROTATE_270 |+  o|
> + * |    |  =3D=3D=3D=3D=3D=3D=3D=3D>  |    |
> + * |+   |             |    |
> + *
> + * Rotation and reflection can be combined to handle more situations. In=
 this condition, the
> + * reflection is applied first and the rotation in second.
> + *
> + * For example the expected result for DRM_MODE_ROTATE_90 | DRM_MODE_REF=
LECT_X is:
> + *
> + * |o  +|  REFLECT_X  |+  o|  ROTATE_90  |o   |
> + * |    |  =3D=3D=3D=3D=3D=3D=3D=3D>  |    |  =3D=3D=3D=3D=3D=3D=3D=3D> =
 |    |
> + * |    |             |    |             |+   |
> + *
> + * It is not possible to pass multiple rotation at the same time. (i.e R=
OTATE_90 | ROTATE_180 is
> + * not the same as ROTATE_270 and is not accepted).

Sphinx reports htmldocs warnings on these transformation diagrams:

Documentation/gpu/drm-kms:389: ./drivers/gpu/drm/drm_blend.c:265: ERROR: Un=
defined substitution referenced: "o +".
Documentation/gpu/drm-kms:389: ./drivers/gpu/drm/drm_blend.c:265: ERROR: Un=
defined substitution referenced: "+ o".
Documentation/gpu/drm-kms:389: ./drivers/gpu/drm/drm_blend.c:273: ERROR: Un=
defined substitution referenced: "o +".
Documentation/gpu/drm-kms:389: ./drivers/gpu/drm/drm_blend.c:277: ERROR: Un=
defined substitution referenced: "o | ROTATE_180 | +".
Documentation/gpu/drm-kms:389: ./drivers/gpu/drm/drm_blend.c:277: ERROR: Un=
defined substitution referenced: "+ | | o".
Documentation/gpu/drm-kms:389: ./drivers/gpu/drm/drm_blend.c:281: ERROR: Un=
defined substitution referenced: "o | ROTATE_270 |+ o".
Documentation/gpu/drm-kms:389: ./drivers/gpu/drm/drm_blend.c:290: ERROR: Un=
defined substitution referenced: "o +".
Documentation/gpu/drm-kms:389: ./drivers/gpu/drm/drm_blend.c:290: ERROR: Un=
defined substitution referenced: "+ o".

I have to wrap them in literal blocks:

---- >8 ----
diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
index 6fbb8730d8b022..f2cbf8d8efbbbc 100644
--- a/drivers/gpu/drm/drm_blend.c
+++ b/drivers/gpu/drm/drm_blend.c
@@ -259,36 +259,36 @@ EXPORT_SYMBOL(drm_plane_create_alpha_property);
  * the X and Y axis are within the source rectangle, i.e.  the X/Y axis be=
fore
  * rotation.
  *
- * Here are some examples of rotation and reflections:
+ * Here are some examples of rotation and reflections::
  *
- * |o  +|  REFLECT_X  |+  o|
- * |    |  =3D=3D=3D=3D=3D=3D=3D=3D>  |    |
- * |    |             |    |
+ *	|o  +|  REFLECT_X  |+  o|
+ *	|    |  =3D=3D=3D=3D=3D=3D=3D=3D>  |    |
+ *	|    |             |    |
  *
- * |o   |  REFLECT_Y  |+   |
- * |    |  =3D=3D=3D=3D=3D=3D=3D=3D>  |    |
- * |+   |             |o   |
+ *	|o   |  REFLECT_Y  |+   |
+ *	|    |  =3D=3D=3D=3D=3D=3D=3D=3D>  |    |
+ *	|+   |             |o   |
  *
- * |o  +|  ROTATE_90  |+   |
- * |    |  =3D=3D=3D=3D=3D=3D=3D=3D>  |    |
- * |    |             |o   |
+ *	|o  +|  ROTATE_90  |+   |
+ *	|    |  =3D=3D=3D=3D=3D=3D=3D=3D>  |    |
+ *	|    |             |o   |
  *
- * |o   |  ROTATE_180 |   +|
- * |    |  =3D=3D=3D=3D=3D=3D=3D=3D>  |    |
- * |+   |             |   o|
+ *	|o   |  ROTATE_180 |   +|
+ *	|    |  =3D=3D=3D=3D=3D=3D=3D=3D>  |    |
+ *	|+   |             |   o|
  *
- * |o   |  ROTATE_270 |+  o|
- * |    |  =3D=3D=3D=3D=3D=3D=3D=3D>  |    |
- * |+   |             |    |
+ *	|o   |  ROTATE_270 |+  o|
+ *	|    |  =3D=3D=3D=3D=3D=3D=3D=3D>  |    |
+ *	|+   |             |    |
  *
  * Rotation and reflection can be combined to handle more situations. In t=
his condition, the
  * reflection is applied first and the rotation in second.
  *
- * For example the expected result for DRM_MODE_ROTATE_90 | DRM_MODE_REFLE=
CT_X is:
+ * For example the expected result for DRM_MODE_ROTATE_90 | DRM_MODE_REFLE=
CT_X is::
  *
- * |o  +|  REFLECT_X  |+  o|  ROTATE_90  |o   |
- * |    |  =3D=3D=3D=3D=3D=3D=3D=3D>  |    |  =3D=3D=3D=3D=3D=3D=3D=3D>  |=
    |
- * |    |             |    |             |+   |
+ *	|o  +|  REFLECT_X  |+  o|  ROTATE_90  |o   |
+ *	|    |  =3D=3D=3D=3D=3D=3D=3D=3D>  |    |  =3D=3D=3D=3D=3D=3D=3D=3D>  |=
    |
+ *	|    |             |    |             |+   |
  *
  * It is not possible to pass multiple rotation at the same time. (i.e ROT=
ATE_90 | ROTATE_180 is
  * not the same as ROTATE_270 and is not accepted).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--j3zP2GZ4OPkidsR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZh05hgAKCRD2uYlJVVFO
o1ViAQCpYUwFBWA1VJ9hNZykmFyvVHFiqufi3AfxQWmolU+5WgD/QCeVancsmMRC
Xu+Tf5kfiNJTrMQwSlF/2Dxr+StGagc=
=91C7
-----END PGP SIGNATURE-----

--j3zP2GZ4OPkidsR1--

