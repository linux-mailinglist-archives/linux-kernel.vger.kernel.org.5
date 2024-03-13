Return-Path: <linux-kernel+bounces-101644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B4987A9CC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7808C1F22D89
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044D721111;
	Wed, 13 Mar 2024 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bVcu0QED"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E66446A2;
	Wed, 13 Mar 2024 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710341563; cv=none; b=gU489fOL2gHTYZg3zGSLseZLL/t0SUuhe/7a0vh1VjweDgYlxhYJYg9uVy5AtrB1/NGh1TVj6WQ5pi6wlkdcJLHpMCd6u0XQhDV5W8Fdhj8hes1ImNBT/bXrh8W2S4LEOzJitFZvC2MWerkBsNgduZbXlkRP3nyeicFl76aoI7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710341563; c=relaxed/simple;
	bh=wRUrD3Ulnv6bcx0ziZA5RH4Fr2ljhTZG8fdkWrlWbJU=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=oTaCV5fzcHLNsJIzbtoEKKBj7oCOGlfbQnRmyKGTG2q3aSUQDqg5k50xJ+Yw5rLbwFeMv3ju7n343vtSV8RAXY2wweRNVGBqOiTPXxlPORhI+I7E989kPY6yZkEaS5TB1GkLQIXQYHKZOcUyRBK/gHTq69pFySrEiepjUXHYCQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=bVcu0QED; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3B408899;
	Wed, 13 Mar 2024 15:52:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710341534;
	bh=wRUrD3Ulnv6bcx0ziZA5RH4Fr2ljhTZG8fdkWrlWbJU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=bVcu0QEDufYyMVK7Xo5KAb7UXIYAhd3LtqeDokj1aLif44xic5jTSy4ap9wdwMkPm
	 xrj/D3gnsIq9oM05vTT1QIVfLqfFPuv0mHo7oRGzg5fEeBHbOetMKVuCZVydEgZRdP
	 80ev1jzT801ntAPTonmvMFNyqNKnOdeO/XeDIQlA=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240313070705.91140-3-umang.jain@ideasonboard.com>
References: <20240313070705.91140-1-umang.jain@ideasonboard.com> <20240313070705.91140-3-umang.jain@ideasonboard.com>
Subject: Re: [PATCH v3 2/2] media: i2c: Add imx283 camera sensor driver
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, willl will <will@willwhang.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, tomi.valkeinen@ideasonboard.com, Umang Jain <umang.jain@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, Alain Volmat <alain.volmat@foss.st.com>, Paul Elder <paul.elder@ideasonboard.com>, Mehdi Djait <mehdi.djait@bootlin.com>, Bingbu Cao <bingbu.cao@intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-kernel@vger.kernel.org
To: Umang Jain <umang.jain@ideasonboard.com>, linux-media@vger.kernel.org
Date: Wed, 13 Mar 2024 14:52:34 +0000
Message-ID: <171034155409.1011926.3990407129363039340@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Hi Umang,

Some corrections to make on the frame/mode timings below that we seem to
have missed before.

Quoting Umang Jain (2024-03-13 07:06:59)
> From: Kieran Bingham <kieran.bingham@ideasonboard.com>
>=20
> Add a v4l2 subdevice driver for the Sony IMX283 image sensor.
>=20
> The IMX283 is a 20MP Diagonal 15.86 mm (Type 1) CMOS Image Sensor with
> Square Pixel for Color Cameras.
>=20
> The following features are supported:
> - Manual exposure an gain control support
> - vblank/hblank/link freq control support
> - Test pattern support control
> - Arbitrary horizontal and vertical cropping
> - Supported resolution:
>   - 5472x3648 @ 20fps (SRGGB12)
>   - 5472x3648 @ 25fps (SRGGB10)
>   - 2736x1824 @ 50fps (SRGGB12)
>=20
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  MAINTAINERS                |    1 +
>  drivers/media/i2c/Kconfig  |   10 +
>  drivers/media/i2c/Makefile |    1 +
>  drivers/media/i2c/imx283.c | 1596 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 1608 insertions(+)
>  create mode 100644 drivers/media/i2c/imx283.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 32f790c3a5f9..8169f0e41293 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20375,6 +20375,7 @@ L:      linux-media@vger.kernel.org
>  S:     Maintained
>  T:     git git://linuxtv.org/media_tree.git
>  F:     Documentation/devicetree/bindings/media/i2c/sony,imx283.yaml
> +F:     drivers/media/i2c/imx283.c
> =20
>  SONY IMX290 SENSOR DRIVER
>  M:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> index 4c3435921f19..2090b06b1827 100644
> --- a/drivers/media/i2c/Kconfig
> +++ b/drivers/media/i2c/Kconfig
> @@ -153,6 +153,16 @@ config VIDEO_IMX274
>           This is a V4L2 sensor driver for the Sony IMX274
>           CMOS image sensor.
> =20
> +config VIDEO_IMX283
> +       tristate "Sony IMX283 sensor support"
> +       select V4L2_CCI_I2C
> +       help
> +         This is a V4L2 sensor driver for the Sony IMX283
> +         CMOS image sensor.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called imx283.
> +
>  config VIDEO_IMX290
>         tristate "Sony IMX290 sensor support"
>         select REGMAP_I2C
> diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
> index dfbe6448b549..0fbd81f9f420 100644
> --- a/drivers/media/i2c/Makefile
> +++ b/drivers/media/i2c/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_VIDEO_IMX214) +=3D imx214.o
>  obj-$(CONFIG_VIDEO_IMX219) +=3D imx219.o
>  obj-$(CONFIG_VIDEO_IMX258) +=3D imx258.o
>  obj-$(CONFIG_VIDEO_IMX274) +=3D imx274.o
> +obj-$(CONFIG_VIDEO_IMX283) +=3D imx283.o
>  obj-$(CONFIG_VIDEO_IMX290) +=3D imx290.o
>  obj-$(CONFIG_VIDEO_IMX296) +=3D imx296.o
>  obj-$(CONFIG_VIDEO_IMX319) +=3D imx319.o
> diff --git a/drivers/media/i2c/imx283.c b/drivers/media/i2c/imx283.c
> new file mode 100644
> index 000000000000..81fe2d4fd4d3
> --- /dev/null
> +++ b/drivers/media/i2c/imx283.c
> @@ -0,0 +1,1596 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * V4L2 Support for the IMX283
> + *
> + * Diagonal 15.86 mm (Type 1) CMOS Image Sensor with Square Pixel for Co=
lor
> + * Cameras.
> + *
> + * Copyright (C) 2024 Ideas on Board Oy.
> + *
> + * Based on Sony IMX283 driver prepared by Will Whang
> + *
> + * Based on Sony imx477 camera driver
> + * Copyright (C) 2019-2020 Raspberry Pi (Trading) Ltd
> + */
> +
..
> +/* Mode : resolution and related config values */
> +struct imx283_mode {
> +       unsigned int mode;
> +
> +       /* Bits per pixel */
> +       unsigned int bpp;
> +
> +       /* Frame width */
> +       unsigned int width;
> +
> +       /* Frame height */
> +       unsigned int height;
> +
> +       /*
> +        * Minimum horizontal timing in pixel-units
> +        *
> +        * Note that HMAX is written in 72MHz units, and the datasheet as=
sumes a
> +        * 720MHz link frequency. Convert datasheet values with the follo=
wing:
> +        *
> +        * For 12 bpp modes (480Mbps) convert with:
> +        *   hmax =3D [hmax in 72MHz units] * 480 / 72
> +        *
> +        * For 10 bpp modes (576Mbps) convert with:
> +        *   hmax =3D [hmax in 72MHz units] * 576 / 72
> +        */
> +       u32 min_hmax;
> +
> +       /* minimum V-timing in lines */
> +       u32 min_vmax;
> +
> +       /* default H-timing */
> +       u32 default_hmax;
> +
> +       /* default V-timing */
> +       u32 default_vmax;
> +
> +       /* minimum SHR */
> +       u32 min_shr;
> +
> +       /*
> +        * Per-mode vertical crop constants used to calculate values
> +        * of IMX283REG_WIDCUT and IMX283_REG_VWINPOS.
> +        */
> +       u32 veff;
> +       u32 vst;
> +       u32 vct;
> +
> +       /* Horizontal and vertical binning ratio */
> +       u8 hbin_ratio;
> +       u8 vbin_ratio;
> +
> +       /* Optical Blanking */
> +       u32 horizontal_ob;
> +       u32 vertical_ob;
> +
> +       /* Analog crop rectangle. */
> +       struct v4l2_rect crop;
> +};
..
> +/* Mode configs */
> +static const struct imx283_mode supported_modes_12bit[] =3D {
> +       {
> +               /* 20MPix 21.40 fps readout mode 0 */
> +               .mode =3D IMX283_MODE_0,
> +               .bpp =3D 12,
> +               .width =3D 5472,
> +               .height =3D 3648,
> +               .min_hmax =3D 5914, /* 887 @ 480MHz/72MHz */
> +               .min_vmax =3D 3793, /* Lines */
> +
> +               .veff =3D 3694,
> +               .vst =3D 0,
> +               .vct =3D 0,
> +
> +               .hbin_ratio =3D 1,
> +               .vbin_ratio =3D 1,
> +
> +               /* 20.00 FPS */
> +               .default_hmax =3D 6000, /* 900 @ 480MHz/72MHz */
> +               .default_vmax =3D 4000,
> +
> +               .min_shr =3D 11,
> +               .horizontal_ob =3D 96,
> +               .vertical_ob =3D 16,
> +               .crop =3D CENTERED_RECTANGLE(imx283_active_area, 5472, 36=
48),
> +       },
> +       {
> +               /*
> +                * Readout mode 2 : 2/2 binned mode (2736x1824)
> +                */
> +               .mode =3D IMX283_MODE_2,
> +               .bpp =3D 12,
> +               .width =3D 2736,
> +               .height =3D 1824,
> +               .min_hmax =3D 1870, /* Pixels (362 * 360/72 + padding) */

I believe this should be
		.min_hmax =3D 2414, /* Pixels (362 * 480/72 + padding) */

> +               .min_vmax =3D 3840, /* Lines */
> +
> +               /* 50.00 FPS */
> +               .default_hmax =3D 1870, /* 362 @ 360MHz/72MHz */
> +               .default_vmax =3D 3960,

And for 50.00 FPS, these should be something like=20
		.default_hmax =3D 2500, /* 375 @ 480/72 */
		.default_vmax =3D 3840,

> +
> +               .veff =3D 1824,
> +               .vst =3D 0,
> +               .vct =3D 0,
> +
> +               .hbin_ratio =3D 2,
> +               .vbin_ratio =3D 2,
> +
> +               .min_shr =3D 12,
> +               .horizontal_ob =3D 48,
> +               .vertical_ob =3D 4,
> +
> +               .crop =3D CENTERED_RECTANGLE(imx283_active_area, 5472, 36=
48),
> +       },
> +};
> +
> +static const struct imx283_mode supported_modes_10bit[] =3D {
> +       {
> +               /* 20MPix 25.48 fps readout mode 1 */
> +               .mode =3D IMX283_MODE_1,
> +               .bpp =3D 10,
> +               .width =3D 5472,
> +               .height =3D 3648,
> +               .min_hmax =3D 5960, /* 745 @ 576MHz / 72MHz */
> +               .min_vmax =3D 3793,
> +
> +               /* 25.00 FPS */
> +               .default_hmax =3D 1500, /* 750 @ 576MHz / 72MHz */

This line has gone wrong somewhere. The default can't be lower than the
min. I suspect it should be:

			=3D 6000, /* 750 @ 576MHz / 72MHz */

> +               .default_vmax =3D 3840,
> +
> +               .min_shr =3D 10,
> +               .horizontal_ob =3D 96,
> +               .vertical_ob =3D 16,
> +               .crop =3D CENTERED_RECTANGLE(imx283_active_area, 5472, 36=
48),
> +       },
> +};

--
Kieran

