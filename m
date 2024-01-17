Return-Path: <linux-kernel+bounces-29372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76659830D5E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94D21F2531E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96C6249FF;
	Wed, 17 Jan 2024 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MYIN5P68"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E54124200;
	Wed, 17 Jan 2024 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705520471; cv=none; b=E4As0DBbWDlEevFoIZlSavw/XddP8lfjF3OTo94CbkNsSv7Hu9v1twIxkltUeIIiOsyosYNPbRfaJcHvLqStkEcsleVydOQgDBYgV9svR6OdE5Gor8V10wQDOqlfhTkAP6Z5b6Er/5Sdu01T/Mnf6Nf0EvUS9U4zVztkIYfYzTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705520471; c=relaxed/simple;
	bh=bYuD2E9L5kAIqPygLO0nnJJ+T5lKV5RVt+n4QmW2WbA=;
	h=DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version; b=G5Yjk8WdJDYoABzZIHfuchFrw6v2ngeorS+OFlRBKGviMxMkk4bYHiO3cXZS8FXjn1EeHbseQqwbRMxegqZKLEUk18dqzosrh82mTRTvu/zamcCzKzSUAlqqeGV92S/FPyaelGlwnyR5x4tEQkhFOt1YItp0uvez4sbk9KpQzBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MYIN5P68; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705520468;
	bh=bYuD2E9L5kAIqPygLO0nnJJ+T5lKV5RVt+n4QmW2WbA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MYIN5P68u86ENoTZ3LMrNandBbngqfcpeXIJMf8hajev/wcpmbaK0jApvRbk9irum
	 U8k2i5zYfNRkciCxg+mk94vysMtq7//t+1euECVUeim2tMJkBHfkgwOcf/Qz+q8gL6
	 4BWAH2Xis5rLgUxTwLRvADhYY76fDsffxP6ahjeBbBImISIdKbkx8H2DPkhwRx6FRJ
	 KwRhDydR3v8AG8TPfj/iCURcq/3t/EgURcE28bwjxVwBdLN2aO5hINzaNcjHzuYl7M
	 lewrkoOqoID2U2SGhBrjopnGL97IVADa6fp7qYwrDZA0Wd5Yf/RnBk9TJInyTzHEs5
	 irGY6n269wNpw==
Received: from nicolas-tpx395.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3E9E23781FC7;
	Wed, 17 Jan 2024 19:41:07 +0000 (UTC)
Message-ID: <cc3944167e6b98470befd575520adb50cb8a45fa.camel@collabora.com>
Subject: Re: [RCF 1/2] media: videodev2: Add V4L2_FMT_FLAG_ALL_FORMATS flag
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, mchehab@kernel.org,
  p.zabel@pengutronix.de, hverkuil-cisco@xs4all.nl
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Date: Wed, 17 Jan 2024 14:41:03 -0500
In-Reply-To: <20240111160721.50020-2-benjamin.gaignard@collabora.com>
References: <20240111160721.50020-1-benjamin.gaignard@collabora.com>
	 <20240111160721.50020-2-benjamin.gaignard@collabora.com>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le jeudi 11 janvier 2024 =C3=A0 17:07 +0100, Benjamin Gaignard a =C3=A9crit=
=C2=A0:
> Add new flag to allow enumerate all pixels formats when
> calling VIDIOC_ENUM_FMT ioctl.
> When this flag is set drivers must ignore the configuration
> and return the hardware supported pixel formats for the specified queue.
> This will permit to discover which pixels formats are supported
> without setting codec-specific information so userland can more easily
> knows if the driver suit well to what it needs.
> The main target are stateless decoders so update the documentation
> about how use this flag.
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../userspace-api/media/v4l/dev-stateless-decoder.rst         | 3 +++
>  Documentation/userspace-api/media/v4l/vidioc-enum-fmt.rst     | 4 ++++
>  Documentation/userspace-api/media/videodev2.h.rst.exceptions  | 1 +
>  drivers/media/v4l2-core/v4l2-ioctl.c                          | 2 +-
>  include/uapi/linux/videodev2.h                                | 1 +
>  5 files changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/dev-stateless-decoder.=
rst b/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst
> index 35ed05f2695e..b7b650f1a18f 100644
> --- a/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst
> +++ b/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst
> @@ -58,6 +58,9 @@ Querying capabilities
>       default values for these controls being used, and a returned set of=
 formats
>       that may not be usable for the media the client is trying to decode=
.
> =20
> +   * If ``V4L2_FMT_FLAG_ALL_FORMATS`` flag is set the driver must enumer=
ate
> +     all the supported formats without taking care of codec-dependent co=
ntrols.
> +
>  3. The client may use :c:func:`VIDIOC_ENUM_FRAMESIZES` to detect support=
ed
>     resolutions for a given format, passing desired pixel format in
>     :c:type:`v4l2_frmsizeenum`'s ``pixel_format``.
> diff --git a/Documentation/userspace-api/media/v4l/vidioc-enum-fmt.rst b/=
Documentation/userspace-api/media/v4l/vidioc-enum-fmt.rst
> index 000c154b0f98..db8bc8e29a91 100644
> --- a/Documentation/userspace-api/media/v4l/vidioc-enum-fmt.rst
> +++ b/Documentation/userspace-api/media/v4l/vidioc-enum-fmt.rst
> @@ -227,6 +227,10 @@ the ``mbus_code`` field is handled differently:
>  	The application can ask to configure the quantization of the capture
>  	device when calling the :ref:`VIDIOC_S_FMT <VIDIOC_G_FMT>` ioctl with
>  	:ref:`V4L2_PIX_FMT_FLAG_SET_CSC <v4l2-pix-fmt-flag-set-csc>` set.
> +    * - ``V4L2_FMT_FLAG_ALL_FORMATS``
> +      - 0x0200
> +      - Set by userland application to enumerate all possible pixels for=
mats
> +        without taking care of the current configuration.

This is a bit ambiguous regarding if OUTPUT queue FMT is ignored or not. Fr=
om
our chat, it is ignored in this implementation. Such if I use MTK VCODEC as=
 an
example, using that feature would return:

- MM21
- MT2T
- MT2R

At high level, the use case is to find an easy way to combine the per codec
profile information and the pixel format, since userspace can only use e.g.
10bit capability if it knows the associated pixel formats. This implementat=
ion
is already useful in my opinion, I'll try and draft a GStreamer change to u=
se
it, as I think it will better support the idea. But it has come ceavats.

Notably, if you had a userland that implement MT2T (VP9/AV1/HEVC) but not M=
T2R
(H264), it would not have an easy API to figure-out. It would still have to
resort into enumerating formats for each possible codec and codec specific
compound control configuration.

An alternative is to make this enumerate "all" for the configure OUTPUT for=
mat.
This increase the precision, while still allowing generic code to be used. =
In
pseudo code that would be like:

for output formats
  S_FMT(OUTPUT)

  for ALL capture formats
    store(format)

Where right now we have do do:


for output formats
  S_FMT(OUTPUT)

  S_CTRL(codec_specific_ctl_config_1)
  for capture formats
    store(format)


  S_CTRL(codec_specific_ctl_config_n)
  for capture format
    store(format)
 =20
  ...

  S_CTRL(codec_specific_ctl_config_n)
  for capture formats
    store(format)

Where each config would demote a specific feature, like 10bit, 422, 444, fi=
lm-
grain (posprocessing affect output formats). The posprocessing remains a bi=
t
hard to figure-out in both cases though. But in practice, if I use Hantro A=
V1
decoder as an example, I'd get something like:

  NV15_4L4
  P010

Where NV15_4L4 is not available with filmgrain filter, but P010 is always
available. For my GStreamer use case (template caps) this wouldn't be a pro=
blem,
P010 is a well supported format and I strictly need a superset of the suppo=
rted
formats.

What I'd really gain is that I don't have to do complicated enumeration log=
ic
per codec features.

Nicolas

p.s. It would be logical to update dev-stateless-decoder doc, to mention th=
is
enumeration option. Currently it says:


   To enumerate the set of supported raw formats, the client calls
   VIDIOC_ENUM_FMT() on the CAPTURE queue.
  =20
      *    The driver must return only the formats supported for the format
      currently active on the OUTPUT queue.
  =20
      *    Depending on the currently set OUTPUT format, the set of support=
ed
      raw formats may depend on the value of some codec-dependent controls.=
 The
      client is responsible for making sure that these controls are set bef=
ore
      querying the CAPTURE queue. Failure to do so will result in the defau=
lt
      values for these controls being used, and a returned set of formats t=
hat
      may not be usable for the media the client is trying to decode.


> =20
>  Return Value
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/userspace-api/media/videodev2.h.rst.exceptions=
 b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
> index 3e58aac4ef0b..42d9075b7fc2 100644
> --- a/Documentation/userspace-api/media/videodev2.h.rst.exceptions
> +++ b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
> @@ -215,6 +215,7 @@ replace define V4L2_FMT_FLAG_CSC_XFER_FUNC fmtdesc-fl=
ags
>  replace define V4L2_FMT_FLAG_CSC_YCBCR_ENC fmtdesc-flags
>  replace define V4L2_FMT_FLAG_CSC_HSV_ENC fmtdesc-flags
>  replace define V4L2_FMT_FLAG_CSC_QUANTIZATION fmtdesc-flags
> +replace define V4L2_FMT_FLAG_ALL_FORMATS fmtdesc-flags
> =20
>  # V4L2 timecode types
>  replace define V4L2_TC_TYPE_24FPS timecode-type
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index 33076af4dfdb..22a93d074a5b 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1544,7 +1544,7 @@ static int v4l_enum_fmt(const struct v4l2_ioctl_ops=
 *ops,
>  		p->mbus_code =3D 0;
> =20
>  	mbus_code =3D p->mbus_code;
> -	memset_after(p, 0, type);
> +	memset_after(p, 0, flags);

In other similar places, we still clear the flags, and only keep the allowe=
d
bits. Maybe we should do this here too to avoid accidental flags going thro=
ugh ?

That should maybe be under some capability flag, so that userland knows if =
the
driver did implement that feature or not. If the driver didn't set that fla=
g, we
can then clear it so that userlands not checking that flag would at least g=
et an
enumeration response without it.

>  	p->mbus_code =3D mbus_code;
> =20
>  	switch (p->type) {
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index 68e7ac178cc2..82d8c8a7fb7f 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -869,6 +869,7 @@ struct v4l2_fmtdesc {
>  #define V4L2_FMT_FLAG_CSC_YCBCR_ENC		0x0080
>  #define V4L2_FMT_FLAG_CSC_HSV_ENC		V4L2_FMT_FLAG_CSC_YCBCR_ENC
>  #define V4L2_FMT_FLAG_CSC_QUANTIZATION		0x0100
> +#define V4L2_FMT_FLAG_ALL_FORMATS		0x0200
> =20
>  	/* Frame Size and frame rate enumeration */
>  /*


