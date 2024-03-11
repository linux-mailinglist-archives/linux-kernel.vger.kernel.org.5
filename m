Return-Path: <linux-kernel+bounces-98825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353A7877FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17ABD1C214B5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94903CF7E;
	Mon, 11 Mar 2024 12:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="J4762hO4"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF11F3BB29;
	Mon, 11 Mar 2024 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710160109; cv=none; b=qMM7vBW/HpG8Oi8ux2RN9qUDOo1ZCMH1m4xRpTwsndwFMolJd43xSsGWxB2sYN+zXq0QitlWcJ0Comkad+vk6tEUuDwbBmUBrRN/gAIppnT4W4zTbTCF//KXjbZmsXD9BC5x6N6aLReoUJNcuMLFOJ3n5YhnRpCXsHqqq59j53o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710160109; c=relaxed/simple;
	bh=algMjWy7rc/Bd1PuNsvFKLxSixkqACbowufPT9YikUk=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=Fxr1hjw7EywR5+sN83oakriB8eFdPX5i0+VHR8WkgzOmI3Rh/Y9WX9hgYuggOlj8nH8jnxxM6v/XcoHXbUuJHMydgpJ/JmPd6zkCztXm6E68khBIrdFx7fD9GU7/5ZcdX0D2P8eyK1xTX0BU5OieIr/NcVPWQVqXVFu2NTQIcdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=J4762hO4; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CF82DC85;
	Mon, 11 Mar 2024 13:28:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710160081;
	bh=algMjWy7rc/Bd1PuNsvFKLxSixkqACbowufPT9YikUk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=J4762hO4DSR2jfiRLA7LNO7MQuwoE4raGCXT45sIenu3bIu8W8/PDOYMunJ7l/SdW
	 goZZvRIti4/OsKSi7lmqMaPWpTiYkM3geqJAom3UodjjoDcVxuFng2BN7NrEuLuR4o
	 mzA0YSR9aDmWX9Nl2f1TDxQVeLkEAAK9L6hQjD8k=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Zeq7HBMqqrw4nSPj@kekkonen.localdomain>
References: <20240307214048.858318-1-umang.jain@ideasonboard.com> <20240307214048.858318-3-umang.jain@ideasonboard.com> <Zeq7HBMqqrw4nSPj@kekkonen.localdomain>
Subject: Re: [PATCH v2 2/2] media: i2c: Add imx283 camera sensor driver
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: linux-media@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, willl will <will@willwhang.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Alain Volmat <alain.volmat@foss.st.com>, Paul Elder <paul.elder@ideasonboard.com>, Mehdi Djait <mehdi.djait@bootlin.com>, Bingbu Cao <bingbu.cao@intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sebastian Reichel <sre@kernel.org>, Jacopo Mondi <jacopo.mondi@ideasonboard.com>, open list <linux-kernel@vger.kernel.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, Umang Jain <umang.jain@ideasonboard.com>
Date: Mon, 11 Mar 2024 12:28:19 +0000
Message-ID: <171016009901.2924028.16001544322304093037@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Hi Sakari, Umang,

I've replied inline below to a couple of points that I was responsible for.

--
Kieran

Quoting Sakari Ailus (2024-03-08 07:15:40)
> Hi Umang,
>=20
> On Fri, Mar 08, 2024 at 03:10:43AM +0530, Umang Jain wrote:
> > From: Kieran Bingham <kieran.bingham@ideasonboard.com>
> >=20
> > Add a v4l2 subdevice driver for the Sony IMX283 image sensor.
> >=20
> > The IMX283 is a 20MP Diagonal 15.86 mm (Type 1) CMOS Image Sensor with
> > Square Pixel for Color Cameras.
> >=20
> > The following features are supported:
> > - Manual exposure an gain control support
> > - vblank/hblank/link freq control support
> > - Test pattern support control
> > - Arbitrary horizontal and vertical cropping
> > - Supported resolution:
> >   - 5472x3648 @ 20fps (SRGGB12)
> >   - 5472x3648 @ 25fps (SRGGB10)
> >   - 2736x1824 @ 50fps (SRGGB12)
> >=20
> > Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> > Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> > ---
> >  MAINTAINERS                |    1 +
> >  drivers/media/i2c/Kconfig  |   10 +
> >  drivers/media/i2c/Makefile |    1 +
> >  drivers/media/i2c/imx283.c | 1573 ++++++++++++++++++++++++++++++++++++
> >  4 files changed, 1585 insertions(+)
> >  create mode 100644 drivers/media/i2c/imx283.c
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 32f790c3a5f9..8169f0e41293 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20375,6 +20375,7 @@ L:    linux-media@vger.kernel.org
> >  S:   Maintained
> >  T:   git git://linuxtv.org/media_tree.git
> >  F:   Documentation/devicetree/bindings/media/i2c/sony,imx283.yaml
> > +F:   drivers/media/i2c/imx283.c
> > =20
> >  SONY IMX290 SENSOR DRIVER
> >  M:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> > index 4c3435921f19..2090b06b1827 100644
> > --- a/drivers/media/i2c/Kconfig
> > +++ b/drivers/media/i2c/Kconfig
> > @@ -153,6 +153,16 @@ config VIDEO_IMX274
> >         This is a V4L2 sensor driver for the Sony IMX274
> >         CMOS image sensor.
> > =20
> > +config VIDEO_IMX283
> > +     tristate "Sony IMX283 sensor support"
> > +     select V4L2_CCI_I2C
> > +     help
> > +       This is a V4L2 sensor driver for the Sony IMX283
> > +       CMOS image sensor.
> > +
> > +       To compile this driver as a module, choose M here: the
> > +       module will be called imx283.
> > +
> >  config VIDEO_IMX290
> >       tristate "Sony IMX290 sensor support"
> >       select REGMAP_I2C
> > diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
> > index dfbe6448b549..0fbd81f9f420 100644
> > --- a/drivers/media/i2c/Makefile
> > +++ b/drivers/media/i2c/Makefile
> > @@ -48,6 +48,7 @@ obj-$(CONFIG_VIDEO_IMX214) +=3D imx214.o
> >  obj-$(CONFIG_VIDEO_IMX219) +=3D imx219.o
> >  obj-$(CONFIG_VIDEO_IMX258) +=3D imx258.o
> >  obj-$(CONFIG_VIDEO_IMX274) +=3D imx274.o
> > +obj-$(CONFIG_VIDEO_IMX283) +=3D imx283.o
> >  obj-$(CONFIG_VIDEO_IMX290) +=3D imx290.o
> >  obj-$(CONFIG_VIDEO_IMX296) +=3D imx296.o
> >  obj-$(CONFIG_VIDEO_IMX319) +=3D imx319.o
> > diff --git a/drivers/media/i2c/imx283.c b/drivers/media/i2c/imx283.c
> > new file mode 100644
> > index 000000000000..bdedcb73148d
> > --- /dev/null
> > +++ b/drivers/media/i2c/imx283.c
> > @@ -0,0 +1,1573 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * V4L2 Support for the IMX283
> > + *
> > + * Diagonal 15.86 mm (Type 1) CMOS Image Sensor with Square Pixel for =
Color
> > + * Cameras.
> > + *
> > + * Copyright (C) 2024 Ideas on Board Oy.
> > + *
> > + * Based on Sony IMX283 driver prepared by Will Whang
> > + *
> > + * Based on Sony imx477 camera driver
> > + * Copyright (C) 2019-2020 Raspberry Pi (Trading) Ltd
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/units.h>
> > +#include <media/v4l2-cci.h>
> > +#include <media/v4l2-ctrls.h>
> > +#include <media/v4l2-device.h>
> > +#include <media/v4l2-event.h>
> > +#include <media/v4l2-fwnode.h>
> > +#include <media/v4l2-mediabus.h>
> > +
> > +/* Chip ID */
> > +#define IMX283_REG_CHIP_ID           CCI_REG8(0x3000)
> > +#define IMX283_CHIP_ID                       0x0b    // Default power =
on state
> > +
> > +#define IMX283_REG_STANDBY           CCI_REG8(0x3000)
> > +#define   IMX283_ACTIVE                      0
> > +#define   IMX283_STANDBY             BIT(0)
> > +#define   IMX283_STBLOGIC            BIT(1)
> > +#define   IMX283_STBMIPI             BIT(2)
> > +#define   IMX283_STBDV                       BIT(3)
> > +#define   IMX283_SLEEP                       BIT(4)
> > +
> > +#define IMX283_REG_CLAMP             CCI_REG8(0x3001)
> > +#define   IMX283_CLPSQRST            BIT(4)
> > +
> > +#define IMX283_REG_PLSTMG08          CCI_REG8(0x3003)
> > +#define   IMX283_PLSTMG08_VAL                0x77
> > +
> > +#define IMX283_REG_MDSEL1            CCI_REG8(0x3004)
> > +#define IMX283_REG_MDSEL2            CCI_REG8(0x3005)
> > +#define IMX283_REG_MDSEL3            CCI_REG8(0x3006)
> > +#define   IMX283_MDSEL3_VCROP_EN     BIT(5)
> > +#define IMX283_REG_MDSEL4            CCI_REG8(0x3007)
> > +#define   IMX283_MDSEL4_VCROP_EN     (BIT(4) | BIT(6))
> > +
> > +#define IMX283_REG_SVR                       CCI_REG16_LE(0x3009)
> > +
> > +#define IMX283_REG_HTRIMMING         CCI_REG8(0x300b)
> > +#define   IMX283_MDVREV                      BIT(0) /* VFLIP */
> > +#define   IMX283_HTRIMMING_EN                BIT(4)
> > +
> > +#define IMX283_REG_VWINPOS           CCI_REG16_LE(0x300f)
> > +#define IMX283_REG_VWIDCUT           CCI_REG16_LE(0x3011)
> > +
> > +#define IMX283_REG_MDSEL7            CCI_REG16_LE(0x3013)
> > +
> > +/* CSI Clock Configuration */
> > +#define IMX283_REG_TCLKPOST          CCI_REG8(0x3018)
> > +#define IMX283_REG_THSPREPARE                CCI_REG8(0x301a)
> > +#define IMX283_REG_THSZERO           CCI_REG8(0x301c)
> > +#define IMX283_REG_THSTRAIL          CCI_REG8(0x301e)
> > +#define IMX283_REG_TCLKTRAIL         CCI_REG8(0x3020)
> > +#define IMX283_REG_TCLKPREPARE               CCI_REG8(0x3022)
> > +#define IMX283_REG_TCLKZERO          CCI_REG16_LE(0x3024)
> > +#define IMX283_REG_TLPX                      CCI_REG8(0x3026)
> > +#define IMX283_REG_THSEXIT           CCI_REG8(0x3028)
> > +#define IMX283_REG_TCLKPRE           CCI_REG8(0x302a)
> > +#define IMX283_REG_SYSMODE           CCI_REG8(0x3104)
> > +
> > +#define IMX283_REG_Y_OUT_SIZE                CCI_REG16_LE(0x302f)
> > +#define IMX283_REG_WRITE_VSIZE               CCI_REG16_LE(0x3031)
> > +#define IMX283_REG_OB_SIZE_V         CCI_REG8(0x3033)
> > +
> > +/* HMAX internal HBLANK */
> > +#define IMX283_REG_HMAX                      CCI_REG16_LE(0x3036)
> > +#define IMX283_HMAX_MAX                      0xffff
> > +
> > +/* VMAX internal VBLANK */
> > +#define IMX283_REG_VMAX                      CCI_REG24_LE(0x3038)
> > +#define   IMX283_VMAX_MAX            0xfffff
> > +
> > +/* SHR internal */
> > +#define IMX283_REG_SHR                       CCI_REG16_LE(0x303b)
> > +#define   IMX283_SHR_MIN             11
> > +
> > +/*
> > + * Analog gain control
> > + *  Gain [dB] =3D -20log{(2048 - value [10:0]) /2048}
> > + *  Range: 0dB to approximately +27dB
> > + */
> > +#define IMX283_REG_ANALOG_GAIN               CCI_REG16_LE(0x3042)
> > +#define   IMX283_ANA_GAIN_MIN                0
> > +#define   IMX283_ANA_GAIN_MAX                1957
> > +#define   IMX283_ANA_GAIN_STEP               1
> > +#define   IMX283_ANA_GAIN_DEFAULT    0x0
> > +
> > +/*
> > + * Digital gain control
> > + *  Gain [dB] =3D value * 6
> > + *  Range: 0dB to +18db
> > + */
> > +#define IMX283_REG_DIGITAL_GAIN              CCI_REG8(0x3044)
> > +#define IMX283_DGTL_GAIN_MIN         0
> > +#define IMX283_DGTL_GAIN_MAX         3
> > +#define IMX283_DGTL_GAIN_DEFAULT     0
> > +#define IMX283_DGTL_GAIN_STEP                1
> > +
> > +#define IMX283_REG_HTRIMMING_START   CCI_REG16_LE(0x3058)
> > +#define IMX283_REG_HTRIMMING_END     CCI_REG16_LE(0x305a)
> > +
> > +#define IMX283_REG_MDSEL18           CCI_REG16_LE(0x30f6)
> > +
> > +/* Master Mode Operation Control */
> > +#define IMX283_REG_XMSTA             CCI_REG8(0x3105)
> > +#define   IMX283_XMSTA                       BIT(0)
> > +
> > +#define IMX283_REG_SYNCDRV           CCI_REG8(0x3107)
> > +#define   IMX283_SYNCDRV_XHS_XVS     (0xa0 | 0x02)
> > +#define   IMX283_SYNCDRV_HIZ         (0xa0 | 0x03)
> > +
> > +/* PLL Standby */
> > +#define IMX283_REG_STBPL             CCI_REG8(0x320b)
> > +#define  IMX283_STBPL_NORMAL         0x00
> > +#define  IMX283_STBPL_STANDBY                0x03
> > +
> > +/* Input Frequency Setting */
> > +#define IMX283_REG_PLRD1             CCI_REG8(0x36c1)
> > +#define IMX283_REG_PLRD2             CCI_REG16_LE(0x36c2)
> > +#define IMX283_REG_PLRD3             CCI_REG8(0x36f7)
> > +#define IMX283_REG_PLRD4             CCI_REG8(0x36f8)
> > +
> > +#define IMX283_REG_PLSTMG02          CCI_REG8(0x36aa)
> > +#define   IMX283_PLSTMG02_VAL                0x00
> > +
> > +#define IMX283_REG_EBD_X_OUT_SIZE    CCI_REG16_LE(0x3a54)
> > +
> > +/* Test pattern generator */
> > +#define IMX283_REG_TPG_CTRL          CCI_REG8(0x3156)
> > +#define   IMX283_TPG_CTRL_CLKEN              BIT(0)
> > +#define   IMX283_TPG_CTRL_PATEN              BIT(4)
> > +
> > +#define IMX283_REG_TPG_PAT           CCI_REG8(0x3157)
> > +#define   IMX283_TPG_PAT_ALL_000     0x00
> > +#define   IMX283_TPG_PAT_ALL_FFF     0x01
> > +#define   IMX283_TPG_PAT_ALL_555     0x02
> > +#define   IMX283_TPG_PAT_ALL_AAA     0x03
> > +#define   IMX283_TPG_PAT_H_COLOR_BARS        0x0a
> > +#define   IMX283_TPG_PAT_V_COLOR_BARS        0x0b
> > +
> > +/* Exposure control */
> > +#define IMX283_EXPOSURE_MIN          52
> > +#define IMX283_EXPOSURE_STEP         1
> > +#define IMX283_EXPOSURE_DEFAULT              1000
> > +#define IMX283_EXPOSURE_MAX          49865
> > +
> > +#define IMAGE_PAD                    0
> > +
> > +#define IMX283_XCLR_MIN_DELAY_US     1000
> > +#define IMX283_XCLR_DELAY_RANGE_US   1000
> > +
> > +/* IMX283 native and active pixel array size. */
> > +static const struct v4l2_rect imx283_native_area =3D {
> > +     .top =3D 0,
> > +     .left =3D 0,
> > +     .width =3D 5592,
> > +     .height =3D 3710,
> > +};
> > +
> > +static const struct v4l2_rect imx283_active_area =3D {
> > +     .top =3D 40,
> > +     .left =3D 108,
> > +     .width =3D 5472,
> > +     .height =3D 3648,
> > +};
> > +
> > +struct imx283_reg_list {
> > +     unsigned int num_of_regs;
> > +     const struct cci_reg_sequence *regs;
> > +};
> > +
> > +/* Mode : resolution and related config values */
> > +struct imx283_mode {
> > +     unsigned int mode;
> > +
> > +     /* Bits per pixel */
> > +     unsigned int bpp;
> > +
> > +     /* Frame width */
> > +     unsigned int width;
> > +
> > +     /* Frame height */
> > +     unsigned int height;
> > +
> > +     /*
> > +      * Minimum horizontal timing in pixel-units
> > +      *
> > +      * Note that HMAX is written in 72MHz units, and the datasheet as=
sumes a
> > +      * 720MHz link frequency. Convert datasheet values with the follo=
wing:
> > +      *
> > +      * For 12 bpp modes (480Mbps) convert with:
> > +      *   hmax =3D [hmax in 72MHz units] * 480 / 72
> > +      *
> > +      * For 10 bpp modes (576Mbps) convert with:
> > +      *   hmax =3D [hmax in 72MHz units] * 576 / 72
> > +      */
> > +     u32 min_hmax;
> > +
> > +     /* minimum V-timing in lines */
> > +     u32 min_vmax;
> > +
> > +     /* default H-timing */
> > +     u32 default_hmax;
> > +
> > +     /* default V-timing */
> > +     u32 default_vmax;
> > +
> > +     /* minimum SHR */
> > +     u32 min_shr;
> > +
> > +     /*
> > +      * Per-mode vertical crop constants used to calculate values
> > +      * of IMX283REG_WIDCUT and IMX283_REG_VWINPOS.
> > +      */
> > +     u32 veff;
> > +     u32 vst;
> > +     u32 vct;
> > +
> > +     /* Horizontal and vertical binning ratio */
> > +     u8 hbin_ratio;
> > +     u8 vbin_ratio;
> > +
> > +     /* Optical Blanking */
> > +     u32 horizontal_ob;
> > +     u32 vertical_ob;
> > +
> > +     /* Analog crop rectangle. */
> > +     struct v4l2_rect crop;
> > +};
> > +
> > +struct imx283_input_frequency {
> > +     unsigned int mhz;
> > +     unsigned int reg_count;
> > +     struct cci_reg_sequence regs[4];
> > +};
> > +
> > +static const struct imx283_input_frequency imx283_frequencies[] =3D {
> > +     {
> > +             .mhz =3D 6 * MEGA,
> > +             .reg_count =3D 4,
> > +             .regs =3D {
> > +                     { IMX283_REG_PLRD1, 0x00 },
> > +                     { IMX283_REG_PLRD2, 0x00f0 },
> > +                     { IMX283_REG_PLRD3, 0x00 },
> > +                     { IMX283_REG_PLRD4, 0xc0 },
> > +             },
> > +     },
> > +     {
> > +             .mhz =3D 12 * MEGA,
> > +             .reg_count =3D 4,
> > +             .regs =3D {
> > +                     { IMX283_REG_PLRD1, 0x01 },
> > +                     { IMX283_REG_PLRD2, 0x00f0 },
> > +                     { IMX283_REG_PLRD3, 0x01 },
> > +                     { IMX283_REG_PLRD4, 0xc0 },
> > +             },
> > +     },
> > +     {
> > +             .mhz =3D 18 * MEGA,
> > +             .reg_count =3D 4,
> > +             .regs =3D {
> > +                     { IMX283_REG_PLRD1, 0x01 },
> > +                     { IMX283_REG_PLRD2, 0x00a0 },
> > +                     { IMX283_REG_PLRD3, 0x01 },
> > +                     { IMX283_REG_PLRD4, 0x80 },
> > +             },
> > +     },
> > +     {
> > +             .mhz =3D 24 * MEGA,
> > +             .reg_count =3D 4,
> > +             .regs =3D {
> > +                     { IMX283_REG_PLRD1, 0x02 },
> > +                     { IMX283_REG_PLRD2, 0x00f0 },
> > +                     { IMX283_REG_PLRD3, 0x02 },
> > +                     { IMX283_REG_PLRD4, 0xc0 },
> > +             },
> > +     },
> > +};
> > +
> > +enum imx283_modes {
> > +     IMX283_MODE_0,
> > +     IMX283_MODE_1,
> > +     IMX283_MODE_1A,
> > +     IMX283_MODE_1S,
> > +     IMX283_MODE_2,
> > +     IMX283_MODE_2A,
> > +     IMX283_MODE_3,
> > +     IMX283_MODE_4,
> > +     IMX283_MODE_5,
> > +     IMX283_MODE_6,
> > +};
> > +
> > +struct imx283_readout_mode {
> > +     u64 mdsel1;
> > +     u64 mdsel2;
> > +     u64 mdsel3;
> > +     u64 mdsel4;
> > +};
>=20
> What's the reasoning for using u64 here? These seem to be 8-bit values (a=
nd
> registers).

I don't really remember my reasoning there, but whatever it was may not
still hold up to scrutiny ;-) Perhaps it was about how the CCI writes
were being handled.

But indeed 4 u8 values are likely sufficient here.

>=20
> > +
> > +static const struct imx283_readout_mode imx283_readout_modes[] =3D {
> > +     /* All pixel scan modes */
> > +     [IMX283_MODE_0] =3D { 0x04, 0x03, 0x10, 0x00 }, /* 12 bit */
> > +     [IMX283_MODE_1] =3D { 0x04, 0x01, 0x00, 0x00 }, /* 10 bit */
> > +     [IMX283_MODE_1A] =3D { 0x04, 0x01, 0x20, 0x50 }, /* 10 bit */
> > +     [IMX283_MODE_1S] =3D { 0x04, 0x41, 0x20, 0x50 }, /* 10 bit */
> > +
> > +     /* Horizontal / Vertical 2/2-line binning */
> > +     [IMX283_MODE_2] =3D { 0x0d, 0x11, 0x50, 0x00 }, /* 12 bit */
> > +     [IMX283_MODE_2A] =3D { 0x0d, 0x11, 0x70, 0x50 }, /* 12 bit */
> > +
> > +     /* Horizontal / Vertical 3/3-line binning */
> > +     [IMX283_MODE_3] =3D { 0x1e, 0x18, 0x10, 0x00 }, /* 12 bit */
> > +
> > +     /* Veritcal 2/9 subsampling, horizontal 3 binning cropping */
> > +     [IMX283_MODE_4] =3D { 0x29, 0x18, 0x30, 0x50 }, /* 12 bit */
> > +
> > +     /* Vertical 2/19 subsampling binning, horizontal 3 binning */
> > +     [IMX283_MODE_5] =3D { 0x2d, 0x18, 0x10, 0x00 }, /* 12 bit */
> > +
> > +     /* Vertical 2 binning horizontal 2/4, subsampling 16:9 cropping */
> > +     [IMX283_MODE_6] =3D { 0x18, 0x21, 0x00, 0x09 }, /* 10 bit */
> > +};
> > +
> > +static const struct cci_reg_sequence mipi_data_rate_1440Mbps[] =3D {
> > +     /* The default register settings provide the 1440Mbps rate */
> > +     { CCI_REG8(0x36c5), 0x00 }, /* Undocumented */
> > +     { CCI_REG8(0x3ac4), 0x00 }, /* Undocumented */
> > +
> > +     { IMX283_REG_STBPL, 0x00 },
> > +     { IMX283_REG_TCLKPOST, 0xa7 },
> > +     { IMX283_REG_THSPREPARE, 0x6f },
> > +     { IMX283_REG_THSZERO, 0x9f },
> > +     { IMX283_REG_THSTRAIL, 0x5f },
> > +     { IMX283_REG_TCLKTRAIL, 0x5f },
> > +     { IMX283_REG_TCLKPREPARE, 0x6f },
> > +     { IMX283_REG_TCLKZERO, 0x017f },
> > +     { IMX283_REG_TLPX, 0x4f },
> > +     { IMX283_REG_THSEXIT, 0x47 },
> > +     { IMX283_REG_TCLKPRE, 0x07 },
> > +     { IMX283_REG_SYSMODE, 0x02 },
> > +};
> > +
> > +static const struct cci_reg_sequence mipi_data_rate_720Mbps[] =3D {
> > +     /* Undocumented Additions "For 720MBps" Setting */
> > +     { CCI_REG8(0x36c5), 0x01 }, /* Undocumented */
> > +     { CCI_REG8(0x3ac4), 0x01 }, /* Undocumented */
> > +
> > +     { IMX283_REG_STBPL, 0x00 },
> > +     { IMX283_REG_TCLKPOST, 0x77 },
> > +     { IMX283_REG_THSPREPARE, 0x37 },
> > +     { IMX283_REG_THSZERO, 0x67 },
> > +     { IMX283_REG_THSTRAIL, 0x37 },
> > +     { IMX283_REG_TCLKTRAIL, 0x37 },
> > +     { IMX283_REG_TCLKPREPARE, 0x37 },
> > +     { IMX283_REG_TCLKZERO, 0xdf },
> > +     { IMX283_REG_TLPX, 0x2f },
> > +     { IMX283_REG_THSEXIT, 0x47 },
> > +     { IMX283_REG_TCLKPRE, 0x0f },
> > +     { IMX283_REG_SYSMODE, 0x02 },
> > +};
> > +
> > +static const s64 link_frequencies[] =3D {
> > +     720 * MEGA, /* 1440 Mbps lane data rate */
> > +     360 * MEGA, /* 720 Mbps data lane rate */
> > +};
> > +
> > +static const struct imx283_reg_list link_freq_reglist[] =3D {
> > +     { /* 720 MHz */
> > +             .num_of_regs =3D ARRAY_SIZE(mipi_data_rate_1440Mbps),
> > +             .regs =3D mipi_data_rate_1440Mbps,
> > +     },
> > +     { /* 360 MHz */
> > +             .num_of_regs =3D ARRAY_SIZE(mipi_data_rate_720Mbps),
> > +             .regs =3D mipi_data_rate_720Mbps,
> > +     },
> > +};
> > +
> > +#define CENTERED_RECTANGLE(rect, _width, _height)                    \
> > +     {                                                               \
> > +             .left =3D rect.left + ((rect.width - (_width)) / 2),     =
 \
> > +             .top =3D rect.top + ((rect.height - (_height)) / 2),     =
 \
> > +             .width =3D (_width),                                     =
 \
> > +             .height =3D (_height),                                   =
 \
> > +     }
> > +
> > +/* Mode configs */
> > +static const struct imx283_mode supported_modes_12bit[] =3D {
> > +     {
> > +             /* 20MPix 21.40 fps readout mode 0 */
> > +             .mode =3D IMX283_MODE_0,
> > +             .bpp =3D 12,
> > +             .width =3D 5472,
> > +             .height =3D 3648,
> > +             .min_hmax =3D 5914, /* 887 @ 480MHz/72MHz */
> > +             .min_vmax =3D 3793, /* Lines */
> > +
> > +             .veff =3D 3694,
> > +             .vst =3D 0,
> > +             .vct =3D 0,
> > +
> > +             .hbin_ratio =3D 1,
> > +             .vbin_ratio =3D 1,
> > +
> > +             /* 20.00 FPS */
> > +             .default_hmax =3D 6000, /* 900 @ 480MHz/72MHz */
> > +             .default_vmax =3D 4000,
> > +
> > +             .min_shr =3D 11,
> > +             .horizontal_ob =3D 96,
> > +             .vertical_ob =3D 16,
> > +             .crop =3D CENTERED_RECTANGLE(imx283_active_area, 5472, 36=
48),
> > +     },
> > +     {
> > +             /*
> > +              * Readout mode 2 : 2/2 binned mode (2736x1824)
> > +              */
> > +             .mode =3D IMX283_MODE_2,
> > +             .bpp =3D 12,
> > +             .width =3D 2736,
> > +             .height =3D 1824,
> > +             .min_hmax =3D 1870, /* Pixels (362 * 360/72 + padding) */
> > +             .min_vmax =3D 3840, /* Lines */
> > +
> > +             /* 50.00 FPS */
> > +             .default_hmax =3D 1870, /* 362 @ 360MHz/72MHz */
> > +             .default_vmax =3D 3960,
> > +
> > +             .veff =3D 1824,
> > +             .vst =3D 0,
> > +             .vct =3D 0,
> > +
> > +             .hbin_ratio =3D 2,
> > +             .vbin_ratio =3D 2,
> > +
> > +             .min_shr =3D 12,
> > +             .horizontal_ob =3D 48,
> > +             .vertical_ob =3D 4,
> > +
> > +             .crop =3D CENTERED_RECTANGLE(imx283_active_area, 5472, 36=
48),
> > +     },
> > +};
> > +
> > +static const struct imx283_mode supported_modes_10bit[] =3D {
> > +     {
> > +             /* 20MPix 25.48 fps readout mode 1 */
> > +             .mode =3D IMX283_MODE_1,
> > +             .bpp =3D 10,
> > +             .width =3D 5472,
> > +             .height =3D 3648,
> > +             .min_hmax =3D 5960, /* 745 @ 576MHz / 72MHz */
> > +             .min_vmax =3D 3793,
> > +
> > +             /* 25.00 FPS */
> > +             .default_hmax =3D 1500, /* 750 @ 576MHz / 72MHz */
> > +             .default_vmax =3D 3840,
> > +
> > +             .min_shr =3D 10,
> > +             .horizontal_ob =3D 96,
> > +             .vertical_ob =3D 16,
> > +             .crop =3D CENTERED_RECTANGLE(imx283_active_area, 5472, 36=
48),
> > +     },
> > +};
> > +
> > +static const u32 imx283_mbus_codes[] =3D {
> > +     MEDIA_BUS_FMT_SRGGB12_1X12,
> > +     MEDIA_BUS_FMT_SRGGB10_1X10,
> > +};
> > +
> > +/* regulator supplies */
> > +static const char *const imx283_supply_name[] =3D {
> > +     "vadd", /* Analog (2.9V) supply */
> > +     "vdd1", /* Supply Voltage 2 (1.8V) supply */
> > +     "vdd2", /* Supply Voltage 3 (1.2V) supply */
> > +};
> > +
>=20
> Extra newline.
>=20
> > +
> > +struct imx283 {
> > +     struct device *dev;
> > +     struct regmap *cci;
> > +
> > +     const struct imx283_input_frequency *freq;
> > +
> > +     struct v4l2_subdev sd;
> > +     struct media_pad pad;
> > +
> > +     struct clk *xclk;
> > +
> > +     struct gpio_desc *reset_gpio;
> > +     struct regulator_bulk_data supplies[ARRAY_SIZE(imx283_supply_name=
)];
> > +
> > +     /* V4L2 Controls */
> > +     struct v4l2_ctrl_handler ctrl_handler;
> > +     struct v4l2_ctrl *exposure;
> > +     struct v4l2_ctrl *vblank;
> > +     struct v4l2_ctrl *hblank;
> > +     struct v4l2_ctrl *vflip;
> > +
> > +     unsigned long link_freq_bitmap;
> > +
> > +     u16 hmax;
> > +     u32 vmax;
> > +};
> > +
> > +static inline struct imx283 *to_imx283(struct v4l2_subdev *_sd)
> > +{
> > +     return container_of(_sd, struct imx283, sd);
>=20
> It's a function, you can call _sd sd instead.

Except then that could 'look' like it is passed as the first and third
argument to container_of...

But if it's fine / accepted otherwise then sure.
>=20
> > +}
> > +
> > +static inline void get_mode_table(unsigned int code,
> > +                               const struct imx283_mode **mode_list,
> > +                               unsigned int *num_modes)
> > +{
> > +     switch (code) {
> > +     case MEDIA_BUS_FMT_SRGGB12_1X12:
> > +     case MEDIA_BUS_FMT_SGRBG12_1X12:
> > +     case MEDIA_BUS_FMT_SGBRG12_1X12:
> > +     case MEDIA_BUS_FMT_SBGGR12_1X12:
> > +             *mode_list =3D supported_modes_12bit;
> > +             *num_modes =3D ARRAY_SIZE(supported_modes_12bit);
> > +             break;
> > +
> > +     case MEDIA_BUS_FMT_SRGGB10_1X10:
> > +     case MEDIA_BUS_FMT_SGRBG10_1X10:
> > +     case MEDIA_BUS_FMT_SGBRG10_1X10:
> > +     case MEDIA_BUS_FMT_SBGGR10_1X10:
> > +             *mode_list =3D supported_modes_10bit;
> > +             *num_modes =3D ARRAY_SIZE(supported_modes_10bit);
> > +             break;
> > +     default:
> > +             *mode_list =3D NULL;
> > +             *num_modes =3D 0;
> > +     }
> > +}
> > +
> > +/* Calculate the Pixel Rate based on the current mode */
> > +static u64 imx283_pixel_rate(struct imx283 *imx283,
> > +                          const struct imx283_mode *mode)
> > +{
> > +     unsigned int bpp =3D mode->bpp;
> > +
>=20
> Extra newline.
>=20
> > +     const unsigned int ddr =3D 2; /* Double Data Rate */
> > +     const unsigned int lanes =3D 4; /* Only 4 lane support */
> > +     u64 link_frequency =3D link_frequencies[__ffs(imx283->link_freq_b=
itmap)];
> > +
> > +     return link_frequency * ddr * lanes / bpp;
> > +}
> > +
> > +/* Convert from a variable pixel_rate to 72 MHz clock cycles */
> > +static u64 imx283_internal_clock(unsigned int pixel_rate, unsigned int=
 pixels)
> > +{
> > +     /*
> > +      * Determine the following operation without overflow:
> > +      *    pixels =3D 72 * MEGA / pixel_rate
> > +      *
> > +      * The internal clock at 72MHz and Pixel Rate (between 240 and 57=
6MHz)
> > +      * can easily overflow this calculation, so pre-divide to simplif=
y.
> > +      */
> > +     const u32 iclk_pre =3D 72 * MEGA / 1000000;
>=20
> You can replace 1000000 by MEGA. Or just remove the division and
> multiplication.
>=20
> > +     const u32 pclk_pre =3D pixel_rate / 1000000;
>=20
> Same here regarding 1000000.

They both made sense to me originally to break out while making sure we
got the calculations right. But simplifing probably makes sense now.

>=20
> > +
> > +     return pixels * iclk_pre / pclk_pre;
> > +}
> > +
> > +/* Internal clock (72MHz) to Pixel Rate clock (Variable) */
> > +static u64 imx283_iclk_to_pix(unsigned int pixel_rate, unsigned int cy=
cles)
> > +{
> > +     /*
> > +      * Determine the following operation without overflow:
> > +      *    cycles * pixel_rate / (72 * MEGA)
> > +      *
> > +      * The internal clock at 72MHz and Pixel Rate (between 240 and 57=
6MHz)
> > +      * can easily overflow this calculation, so pre-divide to simplif=
y.
> > +      */
> > +     const u32 iclk_pre =3D 72 * MEGA / 1000000;
> > +     const u32 pclk_pre =3D pixel_rate / 1000000;
> > +
> > +     return cycles * pclk_pre / iclk_pre;
> > +}
> > +
> > +/* Determine the exposure based on current hmax, vmax and a given SHR =
*/
> > +static u64 imx283_exposure(struct imx283 *imx283,
> > +                        const struct imx283_mode *mode, u64 shr)
> > +{
> > +     u32 svr =3D 0; /* SVR feature is not currently supported */
>=20
> What does this refer to? I guess you could just drop it as well if it's n=
ot
> supported?

Keeping this will keep the calculation matching the datasheet, and
provide clear value for what to update when we/others return to enable
long exposures.

So it would be nice to keep as it sort of documents/tracks the
datasheet.


> > +     u32 hmax =3D imx283->hmax;
> > +     u64 vmax =3D imx283->vmax;
>=20
> You're not changing the values here. I wouldn't introduce temporary
> variables just for that.
>=20
> > +     u32 offset;
> > +     u64 numerator;
> > +
> > +     /* Number of clocks per internal offset period */
> > +     offset =3D mode->mode =3D=3D IMX283_MODE_0 ? 209 : 157;
>=20
> Shouldn't this be in the mode definition?

It could be, but then there would be one copy of 209, and 9 copies of
157.=20

>=20
> > +     numerator =3D (vmax * (svr + 1) - shr) * hmax + offset;
> > +
> > +     do_div(numerator, hmax);
> > +     numerator =3D clamp_t(u32, numerator, 0, 0xFFFFFFFF);
> > +     return numerator;
> > +}
> > +
> > +static void imx283_exposure_limits(struct imx283 *imx283,
> > +                                const struct imx283_mode *mode,
> > +                                u64 *min_exposure, u64 *max_exposure)
>=20
> Note that these are s32 values, not u64.

Hrm, likely due to the return value of imx283_exposure() which could be
updated if required.


>=20
> > +{
> > +     u64 vmax =3D imx283->vmax;
> > +     u32 svr =3D 0; /* SVR feature is not currently supported */
> > +     u64 min_shr =3D mode->min_shr;
> > +     u64 max_shr =3D (svr + 1) * vmax - 4; /* Global Shutter is not su=
pported */
> > +
> > +     max_shr =3D min_t(u64, max_shr, 0xFFFF);
> > +
> > +     *min_exposure =3D imx283_exposure(imx283, mode, max_shr);
> > +     *max_exposure =3D imx283_exposure(imx283, mode, min_shr);
> > +}
> > +
> > +/*
> > + * Integration Time [s] =3D [{VMAX x (SVR + 1) =E2=80=93 (SHR)} x HMAX=
 + offset]
> > + *                      / (72 x 10^6)
> > + */
> > +static u32 imx283_shr(struct imx283 *imx283, const struct imx283_mode =
*mode,
> > +                   u32 exposure)
> > +{
> > +     u32 svr =3D 0; /* SVR feature is not currently supported */
> > +     u32 hmax =3D imx283->hmax;
> > +     u64 vmax =3D imx283->vmax;
> > +     u32 shr;
> > +     u64 temp;
> > +
>=20
> Extra newline.
>=20
> > +     /* Number of clocks per internal offset period */
> > +     u32 offset =3D mode->mode =3D=3D IMX283_MODE_0 ? 209 : 157;
>=20
> Could this be put to the mode definition instead?
>=20
> > +
> > +     temp =3D ((u64)exposure * hmax - offset);
> > +     do_div(temp, hmax);
> > +     shr =3D (u32)(vmax * (svr + 1) - temp);
> > +
> > +     return shr;
> > +}
> > +
> > +static const char * const imx283_tpg_menu[] =3D {
> > +     "Disabled",
> > +     "All 000h",
> > +     "All FFFh",
> > +     "All 555h",
> > +     "All AAAh",
> > +     "Horizontal color bars",
> > +     "Vertical color bars",
> > +};
> > +
> > +static const int imx283_tpg_val[] =3D {
> > +     IMX283_TPG_PAT_ALL_000,
> > +     IMX283_TPG_PAT_ALL_000,
> > +     IMX283_TPG_PAT_ALL_FFF,
> > +     IMX283_TPG_PAT_ALL_555,
> > +     IMX283_TPG_PAT_ALL_AAA,
> > +     IMX283_TPG_PAT_H_COLOR_BARS,
> > +     IMX283_TPG_PAT_V_COLOR_BARS,
> > +};
> > +
> > +static int imx283_update_test_pattern(struct imx283 *imx283, u32 patte=
rn_index)
> > +{
> > +     int ret;
> > +
> > +     if (pattern_index >=3D ARRAY_SIZE(imx283_tpg_val))
> > +             return -EINVAL;
> > +
> > +     if (pattern_index) {
> > +             ret =3D cci_write(imx283->cci, IMX283_REG_TPG_PAT,
> > +                             imx283_tpg_val[pattern_index], NULL);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D cci_write(imx283->cci, IMX283_REG_TPG_CTRL,
> > +                             IMX283_TPG_CTRL_CLKEN | IMX283_TPG_CTRL_P=
ATEN, NULL);
>=20
>         return ...;
>=20
> > +     } else {
> > +             ret =3D cci_write(imx283->cci, IMX283_REG_TPG_CTRL, 0x00,=
 NULL);
>=20
> Ditto.
>=20
> The else clause isn't needed either. I'd make this first and test for
> !pattern_index.
>=20
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static int imx283_set_ctrl(struct v4l2_ctrl *ctrl)
> > +{
> > +     struct imx283 *imx283 =3D container_of(ctrl->handler, struct imx2=
83,
> > +                                          ctrl_handler);
> > +     const struct imx283_mode *mode;
> > +     struct v4l2_mbus_framefmt *fmt;
> > +     const struct imx283_mode *mode_list;
> > +     struct v4l2_subdev_state *state;
> > +     unsigned int num_modes;
> > +     u64 shr, pixel_rate;
> > +     int ret =3D 0;
> > +
> > +     state =3D v4l2_subdev_get_locked_active_state(&imx283->sd);
> > +     fmt =3D v4l2_subdev_state_get_format(state, 0);
> > +
> > +     get_mode_table(fmt->code, &mode_list, &num_modes);
> > +     mode =3D v4l2_find_nearest_size(mode_list, num_modes, width, heig=
ht,
> > +                                   fmt->width, fmt->height);
> > +
> > +     /*
> > +      * The VBLANK control may change the limits of usable exposure, s=
o check
> > +      * and adjust if necessary.
> > +      */
> > +     if (ctrl->id =3D=3D V4L2_CID_VBLANK) {
> > +             /* Honour the VBLANK limits when setting exposure. */
> > +             u64 current_exposure, max_exposure, min_exposure;
> > +
> > +             imx283->vmax =3D mode->height + ctrl->val;
> > +
> > +             imx283_exposure_limits(imx283, mode,
> > +                                    &min_exposure, &max_exposure);
> > +
> > +             current_exposure =3D imx283->exposure->val;
> > +             current_exposure =3D clamp_t(u32, current_exposure, min_e=
xposure,
> > +                                        max_exposure);
> > +
> > +             __v4l2_ctrl_modify_range(imx283->exposure, min_exposure,
> > +                                      max_exposure, 1, current_exposur=
e);
> > +     }
> > +
> > +     /*
> > +      * Applying V4L2 control value only happens
> > +      * when power is up for streaming
> > +      */
> > +     if (!pm_runtime_get_if_active(imx283->dev, true))
> > +             return 0;
> > +
> > +     switch (ctrl->id) {
> > +     case V4L2_CID_EXPOSURE:
> > +             shr =3D imx283_shr(imx283, mode, ctrl->val);
> > +             dev_dbg(imx283->dev, "V4L2_CID_EXPOSURE : %d - SHR: %lld\=
n",
> > +                     ctrl->val, shr);
> > +             ret =3D cci_write(imx283->cci, IMX283_REG_SHR, shr, NULL);
> > +             break;
> > +
> > +     case V4L2_CID_HBLANK:
> > +             pixel_rate =3D imx283_pixel_rate(imx283, mode);
> > +             imx283->hmax =3D imx283_internal_clock(pixel_rate, mode->=
width + ctrl->val);
> > +             dev_dbg(imx283->dev, "V4L2_CID_HBLANK : %d  HMAX : %d\n",
> > +                     ctrl->val, imx283->hmax);
> > +             ret =3D cci_write(imx283->cci, IMX283_REG_HMAX, imx283->h=
max, NULL);
> > +             break;
> > +
> > +     case V4L2_CID_VBLANK:
> > +             imx283->vmax =3D mode->height + ctrl->val;
> > +             dev_dbg(imx283->dev, "V4L2_CID_VBLANK : %d  VMAX : %d\n",
> > +                     ctrl->val, imx283->vmax);
> > +             ret =3D cci_write(imx283->cci, IMX283_REG_VMAX, imx283->v=
max, NULL);
> > +             break;
> > +
> > +     case V4L2_CID_ANALOGUE_GAIN:
> > +             ret =3D cci_write(imx283->cci, IMX283_REG_ANALOG_GAIN, ct=
rl->val, NULL);
> > +             break;
> > +
> > +     case V4L2_CID_DIGITAL_GAIN:
> > +             ret =3D cci_write(imx283->cci, IMX283_REG_DIGITAL_GAIN, c=
trl->val, NULL);
> > +             break;
> > +
> > +     case V4L2_CID_VFLIP:
> > +             /*
> > +              * VFLIP is managed by BIT(0) of IMX283_REG_HTRIMMING add=
ress, hence
> > +              * both need to be set simultaneously.
> > +              */
> > +             if (ctrl->val) {
> > +                     cci_write(imx283->cci, IMX283_REG_HTRIMMING,
> > +                               IMX283_HTRIMMING_EN | IMX283_MDVREV, &r=
et);
> > +             } else {
> > +                     cci_write(imx283->cci, IMX283_REG_HTRIMMING,
> > +                               IMX283_HTRIMMING_EN, &ret);
> > +             }
> > +             break;
> > +
> > +     case V4L2_CID_TEST_PATTERN:
> > +             ret =3D imx283_update_test_pattern(imx283, ctrl->val);
> > +             break;
> > +
> > +     default:
> > +             dev_err(imx283->dev, "ctrl(id:0x%x, val:0x%x) is not hand=
led\n",
> > +                     ctrl->id, ctrl->val);
> > +             break;
> > +     }
> > +
> > +     pm_runtime_put(imx283->dev);
> > +
> > +     return ret;
> > +}
> > +
> > +static const struct v4l2_ctrl_ops imx283_ctrl_ops =3D {
> > +     .s_ctrl =3D imx283_set_ctrl,
> > +};
> > +
> > +static int imx283_enum_mbus_code(struct v4l2_subdev *sd,
> > +                              struct v4l2_subdev_state *sd_state,
> > +                              struct v4l2_subdev_mbus_code_enum *code)
> > +{
> > +     if (code->index >=3D ARRAY_SIZE(imx283_mbus_codes))
> > +             return -EINVAL;
> > +
> > +     code->code =3D imx283_mbus_codes[code->index];
> > +
> > +     return 0;
> > +}
> > +
> > +static int imx283_enum_frame_size(struct v4l2_subdev *sd,
> > +                               struct v4l2_subdev_state *sd_state,
> > +                               struct v4l2_subdev_frame_size_enum *fse)
> > +{
> > +     const struct imx283_mode *mode_list;
> > +     unsigned int num_modes;
> > +
> > +     get_mode_table(fse->code, &mode_list, &num_modes);
> > +
> > +     if (fse->index >=3D num_modes)
> > +             return -EINVAL;
> > +
> > +     fse->min_width =3D mode_list[fse->index].width;
> > +     fse->max_width =3D fse->min_width;
> > +     fse->min_height =3D mode_list[fse->index].height;
> > +     fse->max_height =3D fse->min_height;
> > +
> > +     return 0;
> > +}
> > +
> > +static void imx283_update_image_pad_format(struct imx283 *imx283,
> > +                                        const struct imx283_mode *mode,
> > +                                        struct v4l2_mbus_framefmt *for=
mat)
> > +{
> > +     format->width =3D mode->width;
> > +     format->height =3D mode->height;
> > +     format->field =3D V4L2_FIELD_NONE;
> > +     format->colorspace =3D V4L2_COLORSPACE_RAW;
> > +     format->ycbcr_enc =3D V4L2_YCBCR_ENC_601;
> > +     format->quantization =3D V4L2_QUANTIZATION_FULL_RANGE;
> > +     format->xfer_func =3D V4L2_XFER_FUNC_NONE;
> > +}
> > +
> > +static int imx283_init_state(struct v4l2_subdev *sd,
> > +                          struct v4l2_subdev_state *state)
> > +{
> > +     struct imx283 *imx283 =3D to_imx283(sd);
> > +     struct v4l2_mbus_framefmt *format;
> > +     const struct imx283_mode *mode;
> > +     struct v4l2_rect *crop;
> > +
> > +     /* Initialize try_fmt */
> > +     format =3D v4l2_subdev_state_get_format(state, IMAGE_PAD);
> > +
> > +     mode =3D &supported_modes_12bit[0];
> > +     format->code =3D MEDIA_BUS_FMT_SRGGB12_1X12;
> > +     imx283_update_image_pad_format(imx283, mode, format);
> > +
> > +     /* Initialize crop rectangle to mode default */
> > +     crop =3D v4l2_subdev_state_get_crop(state, IMAGE_PAD);
> > +     *crop =3D mode->crop;
> > +
> > +     return 0;
> > +}
> > +
> > +static void imx283_set_framing_limits(struct imx283 *imx283,
> > +                                   const struct imx283_mode *mode)
> > +{
> > +     u64 pixel_rate =3D imx283_pixel_rate(imx283, mode);
> > +     u64 min_hblank, max_hblank, def_hblank;
> > +
> > +     /* Initialise hmax and vmax for exposure calculations */
> > +     imx283->hmax =3D imx283_internal_clock(pixel_rate, mode->default_=
hmax);
> > +     imx283->vmax =3D mode->default_vmax;
> > +
> > +     /*
> > +      * Horizontal Blanking
> > +      * Convert the HMAX_MAX (72MHz) to Pixel rate values for HBLANK_M=
AX
> > +      */
> > +     min_hblank =3D mode->min_hmax - mode->width;
> > +     max_hblank =3D imx283_iclk_to_pix(pixel_rate, IMX283_HMAX_MAX) - =
mode->width;
> > +     def_hblank =3D mode->default_hmax - mode->width;
> > +     __v4l2_ctrl_modify_range(imx283->hblank, min_hblank, max_hblank, =
1,
> > +                              def_hblank);
> > +     __v4l2_ctrl_s_ctrl(imx283->hblank, def_hblank);
> > +
> > +     /* Vertical Blanking */
> > +     __v4l2_ctrl_modify_range(imx283->vblank, mode->min_vmax - mode->h=
eight,
> > +                              IMX283_VMAX_MAX - mode->height, 1,
> > +                              mode->default_vmax - mode->height);
> > +     __v4l2_ctrl_s_ctrl(imx283->vblank, mode->default_vmax - mode->hei=
ght);
> > +}
> > +
> > +static int imx283_set_pad_format(struct v4l2_subdev *sd,
> > +                              struct v4l2_subdev_state *sd_state,
> > +                              struct v4l2_subdev_format *fmt)
> > +{
> > +     struct v4l2_mbus_framefmt *format;
> > +     const struct imx283_mode *mode;
> > +     struct imx283 *imx283 =3D to_imx283(sd);
> > +     const struct imx283_mode *mode_list;
> > +     unsigned int num_modes;
> > +
> > +     get_mode_table(fmt->format.code, &mode_list, &num_modes);
> > +
> > +     mode =3D v4l2_find_nearest_size(mode_list, num_modes, width, heig=
ht,
> > +                                   fmt->format.width, fmt->format.heig=
ht);
> > +
> > +     fmt->format.width =3D mode->width;
> > +     fmt->format.height =3D mode->height;
> > +     fmt->format.field =3D V4L2_FIELD_NONE;
> > +     fmt->format.colorspace =3D V4L2_COLORSPACE_RAW;
> > +     fmt->format.ycbcr_enc =3D V4L2_YCBCR_ENC_601;
> > +     fmt->format.quantization =3D V4L2_QUANTIZATION_FULL_RANGE;
> > +     fmt->format.xfer_func =3D V4L2_XFER_FUNC_NONE;
> > +
> > +     format =3D v4l2_subdev_state_get_format(sd_state, 0);
> > +
> > +     if (fmt->which =3D=3D V4L2_SUBDEV_FORMAT_ACTIVE)
> > +             imx283_set_framing_limits(imx283, mode);
> > +
> > +     *format =3D fmt->format;
> > +
> > +     return 0;
> > +}
> > +
> > +static int imx283_standby_cancel(struct imx283 *imx283)
> > +{
> > +     unsigned int link_freq_idx;
> > +     int ret =3D 0;
> > +
> > +     cci_write(imx283->cci, IMX283_REG_STANDBY,
> > +               IMX283_STBLOGIC | IMX283_STBDV, &ret);
> > +
> > +     /* Configure PLL clocks based on the xclk */
> > +     cci_multi_reg_write(imx283->cci, imx283->freq->regs,
> > +                         imx283->freq->reg_count, &ret);
> > +
> > +     dev_dbg(imx283->dev, "Using clk freq %ld MHz",
> > +             imx283->freq->mhz / MEGA);
> > +
> > +     /* Initialise communication */
> > +     cci_write(imx283->cci, IMX283_REG_PLSTMG08, IMX283_PLSTMG08_VAL, =
&ret);
> > +     cci_write(imx283->cci, IMX283_REG_PLSTMG02, IMX283_PLSTMG02_VAL, =
&ret);
> > +
> > +     /* Enable PLL */
> > +     cci_write(imx283->cci, IMX283_REG_STBPL, IMX283_STBPL_NORMAL, &re=
t);
> > +
> > +     /* Configure the MIPI link speed */
> > +     link_freq_idx =3D __ffs(imx283->link_freq_bitmap);
> > +     cci_multi_reg_write(imx283->cci,
> > +                         link_freq_reglist[link_freq_idx].regs,
> > +                         link_freq_reglist[link_freq_idx].num_of_regs,
> > +                         &ret);
>=20
> This fits on fewer lines.
>=20
> > +
> > +     usleep_range(1000, 2000); /* 1st Stabilisation period of 1 ms or =
more */
> > +
> > +     /* Activate */
> > +     cci_write(imx283->cci, IMX283_REG_STANDBY, IMX283_ACTIVE, &ret);
> > +     usleep_range(19000, 20000); /* 2nd Stabilisation period of 19ms o=
r more */
> > +
> > +     cci_write(imx283->cci, IMX283_REG_CLAMP, IMX283_CLPSQRST, &ret);
> > +     cci_write(imx283->cci, IMX283_REG_XMSTA, 0, &ret);
> > +     cci_write(imx283->cci, IMX283_REG_SYNCDRV, IMX283_SYNCDRV_XHS_XVS=
, &ret);
> > +
> > +     return ret;
> > +}
> > +
> > +/* Start streaming */
> > +static int imx283_start_streaming(struct imx283 *imx283,
> > +                               struct v4l2_subdev_state *state)
> > +{
> > +     const struct imx283_readout_mode *readout;
> > +     const struct imx283_mode *mode;
> > +     const struct v4l2_mbus_framefmt *fmt;
> > +     const struct imx283_mode *mode_list;
> > +     unsigned int num_modes;
> > +     u32 v_widcut;
> > +     s32 v_pos;
> > +     u32 write_v_size;
> > +     u32 y_out_size;
> > +     int ret =3D 0;
> > +
> > +     fmt =3D v4l2_subdev_state_get_format(state, 0);
> > +     get_mode_table(fmt->code, &mode_list, &num_modes);
> > +     mode =3D v4l2_find_nearest_size(mode_list, num_modes, width, heig=
ht,
> > +                                   fmt->width, fmt->height);
> > +
> > +     ret =3D imx283_standby_cancel(imx283);
> > +     if (ret) {
> > +             dev_err(imx283->dev, "failed to cancel standby\n");
> > +             return ret;
> > +     }
> > +
> > +     /*
> > +      * Set the readout mode registers.
> > +      * MDSEL3 and MDSEL4 are updated to enable Arbitrary Vertical Cro=
pping.
> > +      */
> > +     readout =3D &imx283_readout_modes[mode->mode];
> > +     cci_write(imx283->cci, IMX283_REG_MDSEL1, readout->mdsel1, &ret);
> > +     cci_write(imx283->cci, IMX283_REG_MDSEL2, readout->mdsel2, &ret);
> > +     cci_write(imx283->cci, IMX283_REG_MDSEL3,
> > +               readout->mdsel3 | IMX283_MDSEL3_VCROP_EN, &ret);
> > +     cci_write(imx283->cci, IMX283_REG_MDSEL4,
> > +               readout->mdsel4 | IMX283_MDSEL4_VCROP_EN, &ret);
> > +
> > +     /* Mode 1S specific entries from the Readout Drive Mode Tables */
> > +     if (mode->mode =3D=3D IMX283_MODE_1S) {
> > +             cci_write(imx283->cci, IMX283_REG_MDSEL7, 0x01, &ret);
> > +             cci_write(imx283->cci, IMX283_REG_MDSEL18, 0x1098, &ret);
> > +     }
> > +
> > +     if (ret) {
> > +             dev_err(imx283->dev, "%s failed to set readout\n", __func=
__);
> > +             return ret;
> > +     }
> > +
> > +     /* Initialise SVR. Unsupported for now - Always 0 */
> > +     cci_write(imx283->cci, IMX283_REG_SVR, 0x00, &ret);
> > +
> > +     dev_dbg(imx283->dev, "Mode: Size %d x %d\n", mode->width, mode->h=
eight);
> > +     dev_dbg(imx283->dev, "Analogue Crop (in the mode) %d,%d %dx%d\n",
> > +             mode->crop.left,
> > +             mode->crop.top,
> > +             mode->crop.width,
> > +             mode->crop.height);
> > +
> > +     y_out_size =3D mode->crop.height / mode->vbin_ratio;
> > +     write_v_size =3D y_out_size + mode->vertical_ob;
> > +     /*
> > +      * cropping start position =3D (VWINPOS =E2=80=93 Vst) =C3=97 2
> > +      * cropping width =3D Veff =E2=80=93 (VWIDCUT =E2=80=93 Vct) =C3=
=97 2
> > +      */
> > +     v_pos =3D imx283->vflip->val ?
> > +             ((-mode->crop.top / mode->vbin_ratio) / 2) + mode->vst :
> > +             ((mode->crop.top / mode->vbin_ratio) / 2)  + mode->vst;
> > +     v_widcut =3D ((mode->veff - y_out_size) / 2) + mode->vct;
> > +
> > +     cci_write(imx283->cci, IMX283_REG_Y_OUT_SIZE, y_out_size, &ret);
> > +     cci_write(imx283->cci, IMX283_REG_WRITE_VSIZE, write_v_size, &ret=
);
> > +     cci_write(imx283->cci, IMX283_REG_VWIDCUT, v_widcut, &ret);
> > +     cci_write(imx283->cci, IMX283_REG_VWINPOS, v_pos, &ret);
> > +
> > +     cci_write(imx283->cci, IMX283_REG_OB_SIZE_V, mode->vertical_ob, &=
ret);
> > +
> > +     /* TODO: Validate mode->crop is fully contained within imx283_nat=
ive_area */
> > +     cci_write(imx283->cci, IMX283_REG_HTRIMMING_START, mode->crop.lef=
t, &ret);
> > +     cci_write(imx283->cci, IMX283_REG_HTRIMMING_END,
> > +               mode->crop.left + mode->crop.width, &ret);
> > +
> > +     /* Disable embedded data */
> > +     cci_write(imx283->cci, IMX283_REG_EBD_X_OUT_SIZE, 0, &ret);
> > +
> > +     /* Apply customized values from controls (HMAX/VMAX/SHR) */
> > +     ret =3D  __v4l2_ctrl_handler_setup(imx283->sd.ctrl_handler);
> > +
> > +     return ret;
> > +}
> > +
> > +/* Stop streaming */
> > +static void imx283_stop_streaming(struct imx283 *imx283)
> > +{
> > +     int ret;
> > +
> > +     ret =3D cci_write(imx283->cci, IMX283_REG_STANDBY, IMX283_STBLOGI=
C, NULL);
> > +     if (ret)
> > +             dev_err(imx283->dev, "%s failed to set stream\n", __func_=
_);
> > +
> > +     pm_runtime_put(imx283->dev);
> > +}
> > +
> > +static int imx283_set_stream(struct v4l2_subdev *sd, int enable)
>=20
> Could you implement {enable,disable}_streams instead?
>=20
> > +{
> > +     struct imx283 *imx283 =3D to_imx283(sd);
> > +     struct v4l2_subdev_state *state;
> > +     int ret =3D 0;
> > +
> > +     state =3D v4l2_subdev_lock_and_get_active_state(sd);
> > +
> > +     if (enable) {
> > +             ret =3D pm_runtime_get_sync(imx283->dev);
> > +             if (ret < 0) {
> > +                     pm_runtime_put_noidle(imx283->dev);
> > +                     goto unlock;
> > +             }
> > +
> > +             ret =3D imx283_start_streaming(imx283, state);
> > +             if (ret)
> > +                     goto err_rpm_put;
> > +     } else {
> > +             imx283_stop_streaming(imx283);
> > +     }
> > +
> > +     v4l2_subdev_unlock_state(state);
> > +
> > +     return ret;
> > +
> > +err_rpm_put:
> > +     pm_runtime_put(imx283->dev);
> > +unlock:
> > +     v4l2_subdev_unlock_state(state);
> > +
> > +     return ret;
> > +}
> > +
> > +/* Power/clock management functions */
> > +static int __maybe_unused imx283_power_on(struct device *dev)
> > +{
> > +     struct i2c_client *client =3D to_i2c_client(dev);
> > +     struct v4l2_subdev *sd =3D i2c_get_clientdata(client);
> > +     struct imx283 *imx283 =3D to_imx283(sd);
> > +     int ret;
> > +
> > +     ret =3D regulator_bulk_enable(ARRAY_SIZE(imx283_supply_name),
> > +                                 imx283->supplies);
> > +     if (ret) {
> > +             dev_err(imx283->dev, "%s: failed to enable regulators\n",
> > +                     __func__);
> > +             return ret;
> > +     }
> > +
> > +     ret =3D clk_prepare_enable(imx283->xclk);
> > +     if (ret) {
> > +             dev_err(imx283->dev, "%s: failed to enable clock\n",
> > +                     __func__);
> > +             goto reg_off;
> > +     }
> > +
> > +     gpiod_set_value_cansleep(imx283->reset_gpio, 0);
> > +
> > +     usleep_range(IMX283_XCLR_MIN_DELAY_US,
> > +                  IMX283_XCLR_MIN_DELAY_US + IMX283_XCLR_DELAY_RANGE_U=
S);
> > +
> > +     return 0;
> > +
> > +reg_off:
> > +     regulator_bulk_disable(ARRAY_SIZE(imx283_supply_name), imx283->su=
pplies);
> > +     return ret;
> > +}
> > +
> > +static int __maybe_unused imx283_power_off(struct device *dev)
> > +{
> > +     struct i2c_client *client =3D to_i2c_client(dev);
> > +     struct v4l2_subdev *sd =3D i2c_get_clientdata(client);
> > +     struct imx283 *imx283 =3D to_imx283(sd);
> > +
> > +     gpiod_set_value_cansleep(imx283->reset_gpio, 1);
> > +     regulator_bulk_disable(ARRAY_SIZE(imx283_supply_name), imx283->su=
pplies);
> > +     clk_disable_unprepare(imx283->xclk);
> > +
> > +     return 0;
> > +}
> > +
> > +static int imx283_get_regulators(struct imx283 *imx283)
> > +{
> > +     unsigned int i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(imx283_supply_name); i++)
> > +             imx283->supplies[i].supply =3D imx283_supply_name[i];
> > +
> > +     return devm_regulator_bulk_get(imx283->dev,
> > +                                    ARRAY_SIZE(imx283_supply_name),
> > +                                    imx283->supplies);
> > +}
> > +
> > +/* Verify chip ID */
> > +static int imx283_identify_module(struct imx283 *imx283)
> > +{
> > +     int ret;
> > +     u64 val;
> > +
> > +     ret =3D cci_read(imx283->cci, IMX283_REG_CHIP_ID, &val, NULL);
> > +     if (ret) {
> > +             dev_err(imx283->dev, "failed to read chip id %x, with err=
or %d\n",
> > +                     IMX283_CHIP_ID, ret);
> > +             return ret;
> > +     }
> > +
> > +     if (val !=3D IMX283_CHIP_ID) {
> > +             dev_err(imx283->dev, "chip id mismatch: %x!=3D%llx\n",
> > +                     IMX283_CHIP_ID, val);
> > +             return -EIO;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int imx283_get_selection(struct v4l2_subdev *sd,
> > +                             struct v4l2_subdev_state *sd_state,
> > +                             struct v4l2_subdev_selection *sel)
> > +{
> > +     switch (sel->target) {
> > +     case V4L2_SEL_TGT_CROP: {
> > +             sel->r =3D *v4l2_subdev_state_get_crop(sd_state, 0);
> > +             return 0;
> > +     }
> > +
> > +     case V4L2_SEL_TGT_NATIVE_SIZE:
> > +             sel->r =3D imx283_native_area;
> > +             return 0;
> > +
> > +     case V4L2_SEL_TGT_CROP_DEFAULT:
> > +     case V4L2_SEL_TGT_CROP_BOUNDS:
> > +             sel->r =3D imx283_active_area;
> > +             return 0;
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static const struct v4l2_subdev_core_ops imx283_core_ops =3D {
> > +     .subscribe_event =3D v4l2_ctrl_subdev_subscribe_event,
> > +     .unsubscribe_event =3D v4l2_event_subdev_unsubscribe,
> > +};
> > +
> > +static const struct v4l2_subdev_video_ops imx283_video_ops =3D {
> > +     .s_stream =3D imx283_set_stream,
> > +};
> > +
> > +static const struct v4l2_subdev_pad_ops imx283_pad_ops =3D {
> > +     .enum_mbus_code =3D imx283_enum_mbus_code,
> > +     .get_fmt =3D v4l2_subdev_get_fmt,
> > +     .set_fmt =3D imx283_set_pad_format,
> > +     .get_selection =3D imx283_get_selection,
> > +     .enum_frame_size =3D imx283_enum_frame_size,
> > +};
> > +
> > +static const struct v4l2_subdev_internal_ops imx283_internal_ops =3D {
> > +     .init_state =3D imx283_init_state,
> > +};
> > +
> > +static const struct v4l2_subdev_ops imx283_subdev_ops =3D {
> > +     .core =3D &imx283_core_ops,
> > +     .video =3D &imx283_video_ops,
> > +     .pad =3D &imx283_pad_ops,
> > +};
> > +
> > +/* Initialize control handlers */
> > +static int imx283_init_controls(struct imx283 *imx283)
> > +{
> > +     struct v4l2_ctrl_handler *ctrl_hdlr;
> > +     struct v4l2_fwnode_device_properties props;
> > +     struct v4l2_ctrl *link_freq;
> > +     const struct imx283_mode *mode =3D &supported_modes_12bit[0];
> > +     u64 min_hblank, max_hblank, def_hblank;
> > +     u64 pixel_rate;
> > +     int ret;
> > +
> > +     ctrl_hdlr =3D &imx283->ctrl_handler;
> > +     ret =3D v4l2_ctrl_handler_init(ctrl_hdlr, 16);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /*
> > +      * Create the controls here, but mode specific limits are setup
> > +      * in the imx283_set_framing_limits() call below.
> > +      */
> > +
> > +     /* By default, PIXEL_RATE is read only */
> > +     pixel_rate =3D imx283_pixel_rate(imx283, mode);
> > +     v4l2_ctrl_new_std(ctrl_hdlr, &imx283_ctrl_ops,
> > +                       V4L2_CID_PIXEL_RATE, pixel_rate,
> > +                       pixel_rate, 1, pixel_rate);
> > +
> > +     link_freq =3D v4l2_ctrl_new_int_menu(ctrl_hdlr, &imx283_ctrl_ops,
> > +                                        V4L2_CID_LINK_FREQ,
> > +                                        __fls(imx283->link_freq_bitmap=
),
> > +                                        __ffs(imx283->link_freq_bitmap=
),
> > +                                        link_frequencies);
> > +     if (link_freq)
> > +             link_freq->flags |=3D V4L2_CTRL_FLAG_READ_ONLY;
> > +
> > +     /* Initialise vblank/hblank/exposure based on the current mode. */
> > +     imx283->vblank =3D v4l2_ctrl_new_std(ctrl_hdlr, &imx283_ctrl_ops,
> > +                                        V4L2_CID_VBLANK,
> > +                                        mode->min_vmax - mode->height,
> > +                                        IMX283_VMAX_MAX, 1,
> > +                                        mode->default_vmax - mode->hei=
ght);
> > +
> > +     min_hblank =3D mode->min_hmax - mode->width;
> > +     max_hblank =3D imx283_iclk_to_pix(pixel_rate, IMX283_HMAX_MAX) - =
mode->width;
> > +     def_hblank =3D mode->default_hmax - mode->width;
> > +     imx283->hblank =3D v4l2_ctrl_new_std(ctrl_hdlr, &imx283_ctrl_ops,
> > +                                        V4L2_CID_HBLANK, min_hblank, m=
ax_hblank,
> > +                                        1, def_hblank);
> > +
> > +     imx283->exposure =3D v4l2_ctrl_new_std(ctrl_hdlr, &imx283_ctrl_op=
s,
> > +                                          V4L2_CID_EXPOSURE,
> > +                                          IMX283_EXPOSURE_MIN,
> > +                                          IMX283_EXPOSURE_MAX,
> > +                                          IMX283_EXPOSURE_STEP,
> > +                                          IMX283_EXPOSURE_DEFAULT);
> > +
> > +     v4l2_ctrl_new_std(ctrl_hdlr, &imx283_ctrl_ops, V4L2_CID_ANALOGUE_=
GAIN,
> > +                       IMX283_ANA_GAIN_MIN, IMX283_ANA_GAIN_MAX,
> > +                       IMX283_ANA_GAIN_STEP, IMX283_ANA_GAIN_DEFAULT);
> > +
> > +     v4l2_ctrl_new_std(ctrl_hdlr, &imx283_ctrl_ops, V4L2_CID_DIGITAL_G=
AIN,
> > +                       IMX283_DGTL_GAIN_MIN, IMX283_DGTL_GAIN_MAX,
> > +                       IMX283_DGTL_GAIN_STEP, IMX283_DGTL_GAIN_DEFAULT=
);
> > +
> > +     imx283->vflip =3D v4l2_ctrl_new_std(ctrl_hdlr, &imx283_ctrl_ops, =
V4L2_CID_VFLIP,
> > +                                       0, 1, 1, 0);
> > +     if (imx283->vflip)
> > +             imx283->vflip->flags |=3D V4L2_CTRL_FLAG_MODIFY_LAYOUT;
> > +
> > +     v4l2_ctrl_new_std_menu_items(ctrl_hdlr, &imx283_ctrl_ops,
> > +                                  V4L2_CID_TEST_PATTERN,
> > +                                  ARRAY_SIZE(imx283_tpg_menu) - 1,
> > +                                  0, 0, imx283_tpg_menu);
> > +
> > +     if (ctrl_hdlr->error) {
> > +             ret =3D ctrl_hdlr->error;
> > +             dev_err(imx283->dev, "%s control init failed (%d)\n",
> > +                     __func__, ret);
> > +             goto error;
> > +     }
> > +
> > +     ret =3D v4l2_fwnode_device_parse(imx283->dev, &props);
> > +     if (ret)
> > +             goto error;
> > +
> > +     ret =3D v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx283_ctrl_o=
ps,
> > +                                           &props);
> > +     if (ret)
> > +             goto error;
> > +
> > +     imx283->sd.ctrl_handler =3D ctrl_hdlr;
> > +
> > +     mutex_lock(imx283->ctrl_handler.lock);
> > +
> > +     /* Setup exposure and frame/line length limits. */
> > +     imx283_set_framing_limits(imx283, mode);
> > +
> > +     mutex_unlock(imx283->ctrl_handler.lock);
> > +
> > +     return 0;
> > +
> > +error:
> > +     v4l2_ctrl_handler_free(ctrl_hdlr);
> > +
> > +     return ret;
> > +}
> > +
> > +static int imx283_parse_endpoint(struct imx283 *imx283)
> > +{
> > +     struct fwnode_handle *fwnode =3D dev_fwnode(imx283->dev);
> > +     struct v4l2_fwnode_endpoint bus_cfg =3D {
> > +             .bus_type =3D V4L2_MBUS_CSI2_DPHY
> > +     };
> > +     struct fwnode_handle *ep;
> > +     int ret;
> > +
> > +     if (!fwnode)
> > +             return -ENXIO;
>=20
> No need to check for this.
>=20
> > +
> > +     ep =3D fwnode_graph_get_next_endpoint(fwnode, NULL);
> > +     if (!ep) {
> > +             dev_err(imx283->dev, "Failed to get next endpoint\n");
> > +             return -ENXIO;
> > +     }
> > +
> > +     ret =3D v4l2_fwnode_endpoint_alloc_parse(ep, &bus_cfg);
> > +     fwnode_handle_put(ep);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (bus_cfg.bus.mipi_csi2.num_data_lanes !=3D 4) {
> > +             dev_err(imx283->dev,
> > +                     "number of CSI2 data lanes %d is not supported\n",
> > +                     bus_cfg.bus.mipi_csi2.num_data_lanes);
> > +             ret =3D -EINVAL;
> > +             goto done_endpoint_free;
> > +     }
> > +
> > +     ret =3D v4l2_link_freq_to_bitmap(imx283->dev, bus_cfg.link_freque=
ncies,
> > +                                    bus_cfg.nr_of_link_frequencies,
> > +                                    link_frequencies, ARRAY_SIZE(link_=
frequencies),
> > +                                    &imx283->link_freq_bitmap);
> > +
> > +done_endpoint_free:
> > +     v4l2_fwnode_endpoint_free(&bus_cfg);
> > +
> > +     return ret;
> > +};
> > +
> > +static int imx283_probe(struct i2c_client *client)
> > +{
> > +     struct imx283 *imx283;
> > +     unsigned int i;
> > +     unsigned int xclk_freq;
> > +     int ret;
> > +
> > +     imx283 =3D devm_kzalloc(&client->dev, sizeof(*imx283), GFP_KERNEL=
);
> > +     if (!imx283)
> > +             return -ENOMEM;
> > +
> > +     imx283->dev =3D &client->dev;
> > +
> > +     v4l2_i2c_subdev_init(&imx283->sd, client, &imx283_subdev_ops);
> > +
> > +     imx283->cci =3D devm_cci_regmap_init_i2c(client, 16);
> > +     if (IS_ERR(imx283->cci)) {
> > +             ret =3D PTR_ERR(imx283->cci);
> > +             dev_err(imx283->dev, "failed to initialize CCI: %d\n", re=
t);
> > +             return ret;
> > +     }
> > +
> > +     /* Get system clock (xclk) */
> > +     imx283->xclk =3D devm_clk_get(imx283->dev, NULL);
> > +     if (IS_ERR(imx283->xclk)) {
> > +             return dev_err_probe(imx283->dev, PTR_ERR(imx283->xclk),
> > +                                  "failed to get xclk\n");
> > +     }
> > +
> > +     xclk_freq =3D clk_get_rate(imx283->xclk);
> > +     for (i =3D 0; i < ARRAY_SIZE(imx283_frequencies); i++) {
> > +             if (xclk_freq =3D=3D imx283_frequencies[i].mhz) {
> > +                     imx283->freq =3D &imx283_frequencies[i];
> > +                     break;
> > +             }
> > +     }
> > +     if (!imx283->freq) {
> > +             dev_err(imx283->dev, "xclk frequency unsupported: %d Hz\n=
", xclk_freq);
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret =3D imx283_get_regulators(imx283);
> > +     if (ret) {
> > +             return dev_err_probe(imx283->dev, ret,
> > +                             "failed to get regulators\n");
> > +     }
> > +
> > +     ret =3D imx283_parse_endpoint(imx283);
> > +     if (ret) {
> > +             dev_err(imx283->dev, "failed to parse endpoint configurat=
ion\n");
> > +             return ret;
> > +     }
> > +
> > +     /* Request optional enable pin */
> > +     imx283->reset_gpio =3D devm_gpiod_get_optional(imx283->dev, "rese=
t",
> > +                                                  GPIOD_OUT_LOW);
> > +
> > +     /*
> > +      * The sensor must be powered for imx283_identify_module()
> > +      * to be able to read the CHIP_ID register
> > +      */
> > +     ret =3D imx283_power_on(imx283->dev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D imx283_identify_module(imx283);
> > +     if (ret)
> > +             goto error_power_off;
> > +
> > +     /*
> > +      * Enable runtime PM with autosuspend. As the device has been pow=
ered
> > +      * manually, mark it as active, and increase the usage count with=
out
> > +      * resuming the device.
> > +      */
> > +     pm_runtime_set_active(imx283->dev);
> > +     pm_runtime_get_noresume(imx283->dev);
> > +     pm_runtime_enable(imx283->dev);
> > +     pm_runtime_set_autosuspend_delay(imx283->dev, 1000);
> > +     pm_runtime_use_autosuspend(imx283->dev);
> > +
> > +     /* This needs the pm runtime to be registered. */
> > +     ret =3D imx283_init_controls(imx283);
> > +     if (ret)
> > +             goto error_pm;
> > +
> > +     /* Initialize subdev */
> > +     imx283->sd.flags |=3D V4L2_SUBDEV_FL_HAS_DEVNODE |
> > +                         V4L2_SUBDEV_FL_HAS_EVENTS;
> > +     imx283->sd.entity.function =3D MEDIA_ENT_F_CAM_SENSOR;
> > +     imx283->sd.internal_ops =3D &imx283_internal_ops;
> > +
> > +     /* Initialize source pads */
> > +     imx283->pad.flags =3D MEDIA_PAD_FL_SOURCE;
> > +
> > +     ret =3D media_entity_pads_init(&imx283->sd.entity, 1, &imx283->pa=
d);
> > +     if (ret) {
> > +             dev_err(imx283->dev, "failed to init entity pads: %d\n", =
ret);
> > +             goto error_handler_free;
> > +     }
> > +
> > +     imx283->sd.state_lock =3D imx283->ctrl_handler.lock;
> > +     ret =3D v4l2_subdev_init_finalize(&imx283->sd);
> > +     if (ret < 0) {
> > +             dev_err(imx283->dev, "subdev init error: %d\n", ret);
> > +             goto error_media_entity;
> > +     }
> > +
> > +     ret =3D v4l2_async_register_subdev_sensor(&imx283->sd);
> > +     if (ret < 0) {
> > +             dev_err(imx283->dev, "failed to register sensor sub-devic=
e: %d\n", ret);
> > +             goto error_subdev_cleanup;
> > +     }
> > +
> > +     return 0;
> > +
> > +error_subdev_cleanup:
> > +     v4l2_subdev_cleanup(&imx283->sd);
> > +
> > +error_media_entity:
> > +     media_entity_cleanup(&imx283->sd.entity);
> > +
> > +error_handler_free:
> > +     v4l2_ctrl_handler_free(imx283->sd.ctrl_handler);
> > +
> > +error_pm:
> > +     pm_runtime_disable(imx283->dev);
> > +     pm_runtime_set_suspended(imx283->dev);
> > +error_power_off:
> > +     imx283_power_off(imx283->dev);
> > +
> > +     return ret;
> > +}
> > +
> > +static void imx283_remove(struct i2c_client *client)
> > +{
> > +     struct v4l2_subdev *sd =3D i2c_get_clientdata(client);
> > +     struct imx283 *imx283 =3D to_imx283(sd);
> > +
> > +     v4l2_async_unregister_subdev(sd);
> > +     v4l2_subdev_cleanup(&imx283->sd);
> > +     media_entity_cleanup(&sd->entity);
> > +     v4l2_ctrl_handler_free(imx283->sd.ctrl_handler);
> > +
> > +     pm_runtime_disable(imx283->dev);
> > +     if (!pm_runtime_status_suspended(imx283->dev))
> > +             imx283_power_off(imx283->dev);
> > +     pm_runtime_set_suspended(imx283->dev);
> > +}
> > +
> > +static const struct dev_pm_ops imx283_pm_ops =3D {
> > +     SET_RUNTIME_PM_OPS(imx283_power_off, imx283_power_on, NULL)
> > +};
> > +
> > +static const struct of_device_id imx283_dt_ids[] =3D {
> > +     { .compatible =3D "sony,imx283", },
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, imx283_dt_ids);
> > +
> > +static struct i2c_driver imx283_i2c_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "imx283",
> > +             .of_match_table =3D imx283_dt_ids,
> > +             .pm =3D &imx283_pm_ops,
> > +     },
> > +     .probe =3D imx283_probe,
> > +     .remove =3D imx283_remove,
> > +};
> > +
> > +module_i2c_driver(imx283_i2c_driver);
> > +
> > +MODULE_AUTHOR("Will Whang <will@willwhang.com>");
> > +MODULE_AUTHOR("Kieran Bingham <kieran.bingham@ideasonboard.com>");
> > +MODULE_AUTHOR("Umang Jain <umang.jain@ideasonboard.com>");
> > +MODULE_DESCRIPTION("Sony IMX283 Sensor Driver");
> > +MODULE_LICENSE("GPL");
>=20
> --=20
> Kind regards,
>=20
> Sakari Ailus

