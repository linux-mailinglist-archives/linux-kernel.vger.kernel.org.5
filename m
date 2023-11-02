Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDA57DEF72
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 11:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346155AbjKBKD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 06:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345942AbjKBKDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:03:53 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EDF112;
        Thu,  2 Nov 2023 03:03:46 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9B95A1BF205;
        Thu,  2 Nov 2023 10:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698919424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZZrxUAGnpH5QAbYwnnqoXvL0oDhI8gFZgr4d7fCkrG4=;
        b=bj0IJ+uOeWDXEcBdVd3kb18hynOIKeUGIvcKnyZ4CeRdxkNdjMAremiSofqATYnhZkzCua
        6zJI0xnmo7B2+uelBRE1JvURsFBpei3b6iC9GaAnPAER75GlFngt3MjXd8/1yLjvCfXIAO
        3cWshI860Bv9Jpjyj3LhlN5mBBoRWMLCAAmukQhoiC7drS1Z9zB3ldJKeVa4L3g6ZiB1Cz
        Dblxn3EybjqtWBRaXHZbOtLVljfHSp5rGkvx4jUKQbXcHNjn5PdI2I8kqzcuN8Naye5qr/
        kWtufi0HVmlYiRSbxgD/Tzy2CAPLg0SOYPOSrDj0DbbyRXZlGjEILI5Q6FalGA==
Date:   Thu, 2 Nov 2023 11:03:42 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Mehdi Djait <mehdi.djait@bootlin.com>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, laurent.pinchart@ideasonboard.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com
Subject: Re: [PATCH v7 3/3] media: i2c: Introduce a driver for the Techwell
 TW9900 decoder
Message-ID: <ZUNz_h1fn9RH9Uc5@aptenodytes>
References: <cover.1697463708.git.mehdi.djait@bootlin.com>
 <c3cd9002b2db69a6fb155722adc8410cd6e1f9ab.1697463708.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="64XEZOarVR5dsTg8"
Content-Disposition: inline
In-Reply-To: <c3cd9002b2db69a6fb155722adc8410cd6e1f9ab.1697463708.git.mehdi.djait@bootlin.com>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--64XEZOarVR5dsTg8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mehdi,

On Mon 16 Oct 23, 15:58, Mehdi Djait wrote:
> The Techwell video decoder supports PAL, NTSC input formats,

PAL and NTSC are not formats, they are standards or interfaces.
Also no preceeding comma before "and".

> and outputs a BT.656 signal.

You could mention this is a parallel interface (also signal is not the best
wording).

> This commit adds support for this device, with basic support for NTSC
> and PAL, along with brightness and contrast controls.
>=20
> The TW9900 is capable of doing automatic standard detection, this is
> implemented with support for PAL and NTSC autodetection.

Please mention that this an I2C (or SMBUS) device.

> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> ---
> V6->V7:=20
> - added #include <linux/bitfield.h> to fix a Warning from the kernel
>   robot
> - removed a dev_info and replaced a dev_err by dev_err_probe
>=20
> V5->V6:=20
> - dropped .skip_top and .field in the supported_modes
> - added error handling for the i2c writes/reads
> - added the colorimetry information to fill_fmt
> - removed pm_runtime
> - added the g_input_status callback
> - dropped SECAM
> - dropped the non-standard PAL/NTSC variants
>=20
> V4->V5:=20
> - Added .querystd() and .g_tvnorms(), dropped the .open() and
>   unified the g_fmt() / s_fmt().
>=20
> V3->V4:=20
> - Fix a warning about an uninitialized ret variable in probe()
>=20
> V2->V3:=20
> - Fix coding-style issues, and remove the use of the bulk API
>   for regulators. Make the driver select the media-controller and
>   V4L2-subdev APIs.
>=20
> V1->V2:=20
> - Set the media entity type to decoder, and implement the
>   s_std/g_std ops
>=20
>  MAINTAINERS                |   6 +
>  drivers/media/i2c/Kconfig  |  12 +
>  drivers/media/i2c/Makefile |   1 +
>  drivers/media/i2c/tw9900.c | 648 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 667 insertions(+)
>  create mode 100644 drivers/media/i2c/tw9900.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90f13281d297..164dfb016f18 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21121,6 +21121,12 @@ L:	linux-media@vger.kernel.org
>  S:	Maintained
>  F:	drivers/media/rc/ttusbir.c
> =20
> +TECHWELL TW9900 VIDEO DECODER
> +M:	Mehdi Djait <mehdi.djait@bootlin.com>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +F:	drivers/media/i2c/tw9900.c
> +
>  TECHWELL TW9910 VIDEO DECODER
>  L:	linux-media@vger.kernel.org
>  S:	Orphan
> diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> index 74ff833ff48c..1bd412d90cee 100644
> --- a/drivers/media/i2c/Kconfig
> +++ b/drivers/media/i2c/Kconfig
> @@ -1175,6 +1175,18 @@ config VIDEO_TW2804
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called tw2804.
> =20
> +config VIDEO_TW9900
> +	tristate "Techwell TW9900 video decoder"
> +	depends on VIDEO_DEV && I2C
> +	select MEDIA_CONTROLLER
> +	select VIDEO_V4L2_SUBDEV_API
> +	help
> +	  Support for the Techwell tw9900 multi-standard video decoder.
> +	  It supports NTSC, PAL standards with auto-detection features.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called tw9900.
> +
>  config VIDEO_TW9903
>  	tristate "Techwell TW9903 video decoder"
>  	depends on VIDEO_DEV && I2C
> diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
> index 80b00d39b48f..ec318e1fb0c3 100644
> --- a/drivers/media/i2c/Makefile
> +++ b/drivers/media/i2c/Makefile
> @@ -135,6 +135,7 @@ obj-$(CONFIG_VIDEO_TVP514X) +=3D tvp514x.o
>  obj-$(CONFIG_VIDEO_TVP5150) +=3D tvp5150.o
>  obj-$(CONFIG_VIDEO_TVP7002) +=3D tvp7002.o
>  obj-$(CONFIG_VIDEO_TW2804) +=3D tw2804.o
> +obj-$(CONFIG_VIDEO_TW9900) +=3D tw9900.o
>  obj-$(CONFIG_VIDEO_TW9903) +=3D tw9903.o
>  obj-$(CONFIG_VIDEO_TW9906) +=3D tw9906.o
>  obj-$(CONFIG_VIDEO_TW9910) +=3D tw9910.o
> diff --git a/drivers/media/i2c/tw9900.c b/drivers/media/i2c/tw9900.c
> new file mode 100644
> index 000000000000..41776992cb4e
> --- /dev/null
> +++ b/drivers/media/i2c/tw9900.c
> @@ -0,0 +1,648 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for the Techwell TW9900 multi-standard video decoder.
> + *
> + * Copyright (C) 2018 Fuzhou Rockchip Electronics Co., Ltd.
> + * Copyright (C) 2020 Maxime Chevallier <maxime.chevallier@bootlin.com>
> + * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/sysfs.h>
> +#include <linux/timer.h>
> +#include <linux/delay.h>
> +#include <media/media-entity.h>
> +#include <media/v4l2-async.h>
> +#include <media/v4l2-ctrls.h>
> +#include <media/v4l2-event.h>
> +#include <media/v4l2-subdev.h>
> +
> +#define TW9900_REG_CHIP_ID	0x00
> +#define TW9900_REG_CHIP_STATUS	0x01
> +#define TW9900_REG_CHIP_STATUS_VDLOSS	BIT(7)
> +#define TW9900_REG_CHIP_STATUS_HLOCK	BIT(6)
> +#define TW9900_REG_OUT_FMT_CTL	0x03
> +#define TW9900_REG_OUT_FMT_CTL_STANDBY		0xA7
> +#define TW9900_REG_OUT_FMT_CTL_STREAMING	0xA0
> +#define TW9900_REG_CKHY_HSDLY	0x04
> +#define TW9900_REG_OUT_CTRL_I	0x05
> +#define TW9900_REG_ANALOG_CTL	0x06
> +#define TW9900_REG_CROP_HI	0x07
> +#define TW9900_REG_VDELAY_LO	0x08
> +#define TW9900_REG_VACTIVE_LO	0x09
> +#define TW9900_REG_HACTIVE_LO	0x0B
> +#define TW9900_REG_CNTRL1	0x0C
> +#define TW9900_REG_BRIGHT_CTL	0x10
> +#define TW9900_REG_CONTRAST_CTL	0x11
> +#define TW9900_REG_VBI_CNTL	0x19
> +#define TW9900_REG_ANAL_CTL_II	0x1A
> +#define TW9900_REG_OUT_CTRL_II	0x1B
> +#define TW9900_REG_STD_SEL	0x1C
> +#define TW9900_REG_STD_SEL_AUTODETECT_IN_PROGRESS BIT(7)
> +#define TW9900_STDNOW_MASK	GENMASK(6, 4)
> +#define TW9900_REG_STDR		0x1D
> +#define TW9900_REG_MISSCNT	0x26
> +#define TW9900_REG_MISC_CTL_II	0x2F
> +#define TW9900_REG_VVBI		0x55
> +
> +#define TW9900_CHIP_ID		0x00
> +
> +#define VSYNC_POLL_INTERVAL_MS	20
> +#define VSYNC_WAIT_MAX_POLLS	50
> +
> +#define TW9900_STD_NTSC_M	0
> +#define TW9900_STD_PAL_BDGHI	1
> +#define TW9900_STD_AUTO		7
> +
> +#define TW9900_VIDEO_POLL_TIMEOUT 20
> +
> +struct regval {
> +	u8 addr;
> +	u8 val;
> +};
> +
> +struct tw9900_mode {
> +	u32 width;
> +	u32 height;
> +	u32 std;
> +	const struct regval *reg_list;
> +	int n_regs;
> +};
> +
> +struct tw9900 {
> +	struct i2c_client *client;
> +	struct gpio_desc *reset_gpio;
> +	struct regulator *regulator;
> +
> +	bool streaming;
> +
> +	struct v4l2_subdev subdev;
> +	struct v4l2_ctrl_handler hdl;
> +	struct media_pad pad;
> +
> +	struct timer_list timer;
> +	struct work_struct work_i2c_poll;

These two are not used anywhere, please get rid of them (and corresponding
headers too).

> +
> +	const struct tw9900_mode *cur_mode;

Unless I'm mistaken you need to have a mutex here to serialize access to
hardware and for the current mode configuration.

> +};
> +
> +#define to_tw9900(sd) container_of(sd, struct tw9900, subdev)
> +
> +static const struct regval tw9900_init_regs[] =3D {
> +	{ TW9900_REG_MISC_CTL_II,	0xE6 },
> +	{ TW9900_REG_MISSCNT,		0x24 },
> +	{ TW9900_REG_OUT_FMT_CTL,	0xA7 },
> +	{ TW9900_REG_ANAL_CTL_II,	0x0A },
> +	{ TW9900_REG_VDELAY_LO,		0x19 },
> +	{ TW9900_REG_STD_SEL,		0x00 },
> +	{ TW9900_REG_VACTIVE_LO,	0xF0 },
> +	{ TW9900_REG_STD_SEL,		0x07 },
> +	{ TW9900_REG_CKHY_HSDLY,	0x40 },
> +	{ TW9900_REG_ANALOG_CTL,	0x80 },
> +	{ TW9900_REG_CNTRL1,		0xDC },
> +	{ TW9900_REG_OUT_CTRL_I,	0x98 },
> +};
> +
> +static const struct regval tw9900_pal_regs[] =3D {
> +	{ TW9900_REG_STD_SEL,		0x01 },
> +};
> +
> +static const struct regval tw9900_ntsc_regs[] =3D {
> +	{ TW9900_REG_OUT_FMT_CTL,	0xA4 },
> +	{ TW9900_REG_VDELAY_LO,		0x12 },
> +	{ TW9900_REG_VACTIVE_LO,	0xF0 },
> +	{ TW9900_REG_CROP_HI,		0x02 },
> +	{ TW9900_REG_HACTIVE_LO,	0xD0 },
> +	{ TW9900_REG_VBI_CNTL,		0x01 },
> +	{ TW9900_REG_STD_SEL,		0x00 },
> +};
> +
> +static const struct tw9900_mode supported_modes[] =3D {
> +	{
> +		.width =3D 720,
> +		.height =3D 480,
> +		.std =3D V4L2_STD_NTSC,
> +		.reg_list =3D tw9900_ntsc_regs,
> +		.n_regs =3D ARRAY_SIZE(tw9900_ntsc_regs),
> +	},
> +	{
> +		.width =3D 720,
> +		.height =3D 576,
> +		.std =3D V4L2_STD_PAL,
> +		.reg_list =3D tw9900_pal_regs,
> +		.n_regs =3D ARRAY_SIZE(tw9900_pal_regs),
> +	},
> +};
> +
> +static int tw9900_write_reg(struct i2c_client *client, u8 reg, u8 val)
> +{
> +	int ret;
> +
> +	ret =3D i2c_smbus_write_byte_data(client, reg, val);

Is this an SMBUS device in particular? Or is there any reason to use the SM=
BUS
API instead of the general I2C API?

> +	if (ret < 0)
> +		dev_err(&client->dev, "write reg error: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int tw9900_write_array(struct i2c_client *client,
> +			      const struct regval *regs, int n_regs)
> +{
> +	int i, ret =3D 0;
> +
> +	for (i =3D 0; ret =3D=3D 0 && i <=3D n_regs; i++) {

The ret =3D=3D 0 check is not useful here, since you're checking it in the =
loop
already. Also <=3D instead of < looks very, very suspicious. Please double-=
check.

> +		ret =3D tw9900_write_reg(client, regs[i].addr, regs[i].val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tw9900_read_reg(struct i2c_client *client, u8 reg)
> +{
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_byte_data(client, reg);

Same comment about i2c vs smbus.

> +	if (ret < 0)
> +		dev_err(&client->dev, "read reg error: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static void tw9900_fill_fmt(const struct tw9900_mode *mode,
> +			    struct v4l2_mbus_framefmt *fmt)
> +{
> +	fmt->code =3D MEDIA_BUS_FMT_UYVY8_2X8;
> +	fmt->width =3D mode->width;
> +	fmt->height =3D mode->height;
> +	fmt->field =3D V4L2_FIELD_NONE;
> +	fmt->quantization =3D V4L2_QUANTIZATION_DEFAULT;
> +	fmt->colorspace =3D V4L2_COLORSPACE_SMPTE170M;
> +	fmt->xfer_func =3D V4L2_MAP_XFER_FUNC_DEFAULT(V4L2_COLORSPACE_SMPTE170M=
);
> +	fmt->ycbcr_enc =3D V4L2_MAP_YCBCR_ENC_DEFAULT(V4L2_COLORSPACE_SMPTE170M=
);
> +}
> +
> +static int tw9900_cfg_fmt(struct v4l2_subdev *sd,

You might have to differentiate between set_fmt/get_fmt to return -EBUSY
if streaming is on in set_fmt. However I understand it will just copy the
current mode in both cases, but this might still be required to follow v4l2
semantics (please double-check).

> +			  struct v4l2_subdev_state *sd_state,
> +			  struct v4l2_subdev_format *fmt)
> +{
> +	struct tw9900 *tw9900 =3D to_tw9900(sd);
> +	struct v4l2_mbus_framefmt *mbus_fmt =3D &fmt->format;

Should be mutex-protected (for cur_mode access).

> +
> +	tw9900_fill_fmt(tw9900->cur_mode, mbus_fmt);
> +
> +	return 0;
> +}
> +
> +static int tw9900_enum_mbus_code(struct v4l2_subdev *sd,
> +				 struct v4l2_subdev_state *sd_state,
> +				 struct v4l2_subdev_mbus_code_enum *code)
> +{
> +	if (code->index >=3D 1)

Make this > 0, it will be easier to read/understand.

> +		return -EINVAL;
> +
> +	code->code =3D MEDIA_BUS_FMT_UYVY8_2X8;
> +
> +	return 0;
> +}
> +
> +static int tw9900_power_on(struct tw9900 *tw9900)
> +{
> +	int ret;
> +	struct device *dev =3D &tw9900->client->dev;

Define ret last here.

> +
> +	if (tw9900->reset_gpio)
> +		gpiod_set_value_cansleep(tw9900->reset_gpio, 1);
> +
> +	ret =3D regulator_enable(tw9900->regulator);
> +	if (ret < 0)
> +		goto error;
> +
> +	usleep_range(50000, 52000);
> +
> +	if (tw9900->reset_gpio)
> +		gpiod_set_value_cansleep(tw9900->reset_gpio, 0);
> +
> +	usleep_range(1000, 2000);
> +
> +	ret =3D tw9900_write_array(tw9900->client, tw9900_init_regs,
> +				 ARRAY_SIZE(tw9900_init_regs));
> +	if (ret)
> +		dev_err(dev, "Failed to init tw9900\n");
> +
> +	return ret;
> +
> +error:
> +

Remove this newline.

> +	return ret;
> +}
> +
> +static void tw9900_power_off(struct tw9900 *tw9900)
> +{
> +	if (tw9900->reset_gpio)
> +		gpiod_set_value_cansleep(tw9900->reset_gpio, 1);
> +
> +	regulator_disable(tw9900->regulator);
> +}

Power on/off would be best folded into runtime pm.

> +static int tw9900_s_ctrl(struct v4l2_ctrl *ctrl)
> +{
> +	struct tw9900 *tw9900 =3D container_of(ctrl->handler, struct tw9900, hd=
l);
> +

This function should be mutex-protected to serialize register access.

> +	switch (ctrl->id) {
> +	case V4L2_CID_BRIGHTNESS:
> +		return tw9900_write_reg(tw9900->client, 0x10, (u8)ctrl->val);

Use the define, not the raw address.

> +	case V4L2_CID_CONTRAST:
> +		return tw9900_write_reg(tw9900->client, 0x11, (u8)ctrl->val);

Ditto.

> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int tw9900_s_stream(struct v4l2_subdev *sd, int on)
> +{
> +	struct tw9900 *tw9900 =3D to_tw9900(sd);
> +	struct i2c_client *client =3D tw9900->client;
> +	int ret;

This function should be mutex-protected to serialize register access.

> +
> +	on =3D !!on;
> +	if (on =3D=3D tw9900->streaming)

It's a lot more readable and clear to avoid the !!on and do:
if ((tw9900->streaming && on) || (!tw9900->streaming && !on))

Also there's a chance that the framework already does this verification (pl=
ease
double-check).

> +		return 0;
> +
> +	if (on) {

You should power on here.

> +		ret =3D v4l2_ctrl_handler_setup(sd->ctrl_handler);

Once this is mutex-protected, you need to use __v4l2_ctrl_handler_setup.

> +		if (ret)
> +			return ret;
> +
> +		ret =3D tw9900_write_array(tw9900->client,
> +					 tw9900->cur_mode->reg_list,
> +					 tw9900->cur_mode->n_regs);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D tw9900_write_reg(client, TW9900_REG_OUT_FMT_CTL,
> +				       TW9900_REG_OUT_FMT_CTL_STREAMING);
> +		if (ret)
> +			return ret;
> +
> +	} else {
> +		ret =3D tw9900_write_reg(client, TW9900_REG_OUT_FMT_CTL,
> +				       TW9900_REG_OUT_FMT_CTL_STANDBY);
> +		if (ret)
> +			return ret;

You should power off here.

> +	}
> +
> +	tw9900->streaming =3D on;
> +
> +	return 0;
> +}
> +
> +static int tw9900_subscribe_event(struct v4l2_subdev *sd,
> +				  struct v4l2_fh *fh,
> +				  struct v4l2_event_subscription *sub)
> +{
> +	switch (sub->type) {
> +	case V4L2_EVENT_SOURCE_CHANGE:
> +		return v4l2_src_change_event_subdev_subscribe(sd, fh, sub);
> +	case V4L2_EVENT_CTRL:
> +		return v4l2_ctrl_subdev_subscribe_event(sd, fh, sub);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct tw9900_mode *tw9900_get_mode_from_std(v4l2_std_id st=
d)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(supported_modes); i++)
> +		if (supported_modes[i].std & std)
> +			return &supported_modes[i];
> +
> +	return NULL;
> +}
> +
> +static int tw9900_s_std(struct v4l2_subdev *sd, v4l2_std_id norm)

Please stay consistent in how these are called: std or norm but pick one and
stick to it.

> +{
> +	struct tw9900 *tw9900 =3D to_tw9900(sd);
> +	const struct tw9900_mode *mode;

Should be mutex-protected (for cur_mode).

> +
> +	if (!(norm & (V4L2_STD_NTSC | V4L2_STD_PAL)))
> +		return -EINVAL;
> +
> +	mode =3D tw9900_get_mode_from_std(norm);

This function is only called once from here so you can fold it in.

> +	if (!mode)
> +		return -EINVAL;
> +
> +	tw9900->cur_mode =3D mode;
> +
> +	return 0;
> +}
> +
> +static int tw9900_get_stream_std(struct tw9900 *tw9900,
> +				 v4l2_std_id *std_id)

Same comment about variable naming inconsistency.

> +{
> +	int std, ret;

Should be mutex-protected.

> +
> +	ret =3D tw9900_read_reg(tw9900->client, TW9900_REG_STD_SEL);
> +	if (ret < 0) {
> +		*std_id =3D V4L2_STD_UNKNOWN;
> +		return ret;
> +	}
> +
> +	std =3D FIELD_GET(TW9900_STDNOW_MASK, ret);
> +	switch (std) {
> +	case TW9900_STD_NTSC_M:
> +		*std_id =3D V4L2_STD_NTSC;
> +		break;
> +	case TW9900_STD_PAL_BDGHI:
> +		*std_id =3D V4L2_STD_PAL;
> +		break;
> +	case TW9900_STD_AUTO:
> +		*std_id =3D V4L2_STD_UNKNOWN;
> +		break;
> +	default:
> +		*std_id =3D V4L2_STD_UNKNOWN;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tw9900_g_std(struct v4l2_subdev *sd, v4l2_std_id *std)
> +{
> +	struct tw9900 *tw9900 =3D to_tw9900(sd);

Should be mutex-protected.

> +
> +	*std =3D tw9900->cur_mode->std;
> +
> +	return 0;
> +}
> +
> +static int tw9900_start_autodetect(struct tw9900 *tw9900)
> +{
> +	int ret;
> +
> +	ret =3D tw9900_write_reg(tw9900->client, TW9900_REG_STDR,
> +			       BIT(TW9900_STD_NTSC_M) |
> +			       BIT(TW9900_STD_PAL_BDGHI));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D tw9900_write_reg(tw9900->client, TW9900_REG_STD_SEL,
> +			       TW9900_STD_AUTO);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D tw9900_write_reg(tw9900->client, TW9900_REG_STDR,
> +			       BIT(TW9900_STD_NTSC_M) |
> +			       BIT(TW9900_STD_PAL_BDGHI) |
> +			       BIT(TW9900_STD_AUTO));
> +	if (ret)
> +		return ret;
> +
> +	/* Autodetect takes a while to start, and during the starting sequence
> +	 * the autodetection status is reported as done.
> +	 */
> +	msleep(30);
> +
> +	return 0;
> +}
> +
> +static int tw9900_cancel_autodetect(struct tw9900 *tw9900)
> +{
> +	return tw9900_s_std(&tw9900->subdev, tw9900->cur_mode->std);
> +}
> +
> +static int tw9900_detect_done(struct tw9900 *tw9900, bool *done)
> +{
> +	int ret;
> +
> +	ret =3D tw9900_read_reg(tw9900->client, TW9900_REG_STD_SEL);
> +	if (ret < 0)
> +		return ret;
> +
> +	*done =3D !(ret & TW9900_REG_STD_SEL_AUTODETECT_IN_PROGRESS);
> +
> +	return 0;
> +}
> +
> +static int tw9900_querystd(struct v4l2_subdev *sd, v4l2_std_id *std_id)
> +{
> +	struct tw9900 *tw9900 =3D to_tw9900(sd);
> +	bool done =3D false;
> +	int i, ret;
> +

Should be mutex-protected.

> +	if (tw9900->streaming)
> +		return -EBUSY;
> +
> +	ret =3D tw9900_start_autodetect(tw9900);
> +	if (ret)
> +		return ret;
> +
> +	for (i =3D 0; i < TW9900_VIDEO_POLL_TIMEOUT; i++) {
> +		ret =3D tw9900_detect_done(tw9900, &done);
> +		if (ret)
> +			return ret;
> +
> +		if (done)
> +			break;
> +
> +		msleep(20);
> +	}
> +
> +	if (!done) {
> +		tw9900_cancel_autodetect(tw9900);
> +		return -EBUSY;
> +	}
> +
> +	return tw9900_get_stream_std(tw9900, std_id);
> +}
> +
> +static int tw9900_g_tvnorms(struct v4l2_subdev *sd, v4l2_std_id *norm)
> +{
> +	*norm =3D V4L2_STD_NTSC | V4L2_STD_PAL;
> +
> +	return 0;
> +}
> +
> +static int tw9900_g_input_status(struct v4l2_subdev *sd, u32 *status)
> +{
> +	struct tw9900 *tw9900 =3D to_tw9900(sd);
> +	int ret;
> +

Should be mutex-protected.

> +	ret =3D tw9900_read_reg(tw9900->client, TW9900_REG_CHIP_STATUS);
> +	if (ret < 0)
> +		return ret;
> +
> +	*status =3D ret & TW9900_REG_CHIP_STATUS_HLOCK ? 0 : V4L2_IN_ST_NO_SIGN=
AL;
> +
> +	return 0;
> +}
> +
> +static const struct v4l2_subdev_core_ops tw9900_core_ops =3D {
> +	.subscribe_event	=3D tw9900_subscribe_event,
> +	.unsubscribe_event	=3D v4l2_event_subdev_unsubscribe,
> +};
> +
> +static const struct v4l2_subdev_video_ops tw9900_video_ops =3D {
> +	.s_std		=3D tw9900_s_std,
> +	.g_std		=3D tw9900_g_std,
> +	.querystd	=3D tw9900_querystd,
> +	.g_tvnorms	=3D tw9900_g_tvnorms,
> +	.g_input_status =3D tw9900_g_input_status,
> +	.s_stream	=3D tw9900_s_stream,
> +};
> +
> +static const struct v4l2_subdev_pad_ops tw9900_pad_ops =3D {
> +	.enum_mbus_code		=3D tw9900_enum_mbus_code,
> +	.get_fmt		=3D tw9900_cfg_fmt,
> +	.set_fmt		=3D tw9900_cfg_fmt,
> +};
> +
> +static const struct v4l2_subdev_ops tw9900_subdev_ops =3D {
> +	.core	=3D &tw9900_core_ops,
> +	.video	=3D &tw9900_video_ops,
> +	.pad	=3D &tw9900_pad_ops,
> +};
> +
> +static const struct v4l2_ctrl_ops tw9900_ctrl_ops =3D {
> +	.s_ctrl	=3D tw9900_s_ctrl,
> +};
> +
> +static int tw9900_check_id(struct tw9900 *tw9900,
> +			   struct i2c_client *client)
> +{
> +	struct device *dev =3D &tw9900->client->dev;
> +	int ret;
> +
> +	ret =3D tw9900_read_reg(client, TW9900_CHIP_ID);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret !=3D TW9900_CHIP_ID) {
> +		dev_err(dev, "Unexpected decoder id(0x%x)\n", ret);
> +		return -EINVAL;

Maybe -ENODEV instead.

> +	}
> +
> +	return 0;
> +}
> +
> +static int tw9900_probe(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct v4l2_ctrl_handler *hdl;
> +	struct tw9900 *tw9900;
> +	int ret =3D 0;
> +
> +	tw9900 =3D devm_kzalloc(dev, sizeof(*tw9900), GFP_KERNEL);
> +	if (!tw9900)
> +		return -ENOMEM;
> +
> +	tw9900->client =3D client;
> +	tw9900->cur_mode =3D &supported_modes[0];
> +
> +	tw9900->reset_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);

=46rom the looks of the code using it, it seems to be optional.=20
This will return -ENOENT if the gpio is not present, not NULL.
You probably want to use devm_gpiod_get_optional instead.

Also the binding should make it clear that this is optional.

> +	if (IS_ERR(tw9900->reset_gpio))
> +		tw9900->reset_gpio =3D NULL;

You don't want to do this, since it will ignore all errors (including ones
were you do supply a GPIO but the provider fails to make it available).

You should dev_err_probe too.

> +
> +	tw9900->regulator =3D devm_regulator_get(&tw9900->client->dev, "vdd");

This is not marked as a required property in the binding. If this is option=
al,
the code should reflect it (devm_regulator_get_optional + conditionals).
If it's mandatory (which is probably the case), the binding should be updat=
ed to
have vdd-supply as a required property.

> +	if (IS_ERR(tw9900->regulator))
> +		return dev_err_probe(dev, PTR_ERR(tw9900->regulator),
> +				     "Failed to get power regulator\n");
> +
> +	v4l2_i2c_subdev_init(&tw9900->subdev, client, &tw9900_subdev_ops);
> +	tw9900->subdev.flags |=3D V4L2_SUBDEV_FL_HAS_DEVNODE |
> +				V4L2_SUBDEV_FL_HAS_EVENTS;
> +
> +	hdl =3D &tw9900->hdl;
> +
> +	ret =3D v4l2_ctrl_handler_init(hdl, 2);
> +	if (ret)
> +		return ret;
> +
> +	v4l2_ctrl_new_std(hdl, &tw9900_ctrl_ops, V4L2_CID_BRIGHTNESS,
> +			  -128, 127, 1, 0);
> +	v4l2_ctrl_new_std(hdl, &tw9900_ctrl_ops, V4L2_CID_CONTRAST,
> +			  0, 255, 1, 0x60);
> +
> +	tw9900->subdev.ctrl_handler =3D hdl;
> +	if (hdl->error) {
> +		int err =3D hdl->error;
> +
> +		v4l2_ctrl_handler_free(hdl);
> +		return err;
> +	}
> +
> +	ret =3D tw9900_power_on(tw9900);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D tw9900_check_id(tw9900, client);
> +	if (ret)
> +		goto err_power_off;
> +

You should power off after checking the id.

Right now you're keeping the device powered at all times after it was probe=
d,
which is not right. Consider switching to runtime pm too.

> +	tw9900->subdev.flags |=3D V4L2_SUBDEV_FL_HAS_DEVNODE;

You're already setting this earlier.

> +	tw9900->pad.flags =3D MEDIA_PAD_FL_SOURCE;
> +	tw9900->subdev.entity.function =3D MEDIA_ENT_F_DV_DECODER;
> +
> +	ret =3D media_entity_pads_init(&tw9900->subdev.entity, 1, &tw9900->pad);
> +	if (ret < 0)
> +		goto err_power_off;
> +
> +	ret =3D v4l2_async_register_subdev(&tw9900->subdev);
> +	if (ret) {
> +		dev_err(dev, "v4l2 async register subdev failed\n");
> +		goto err_clean_entity;
> +	}
> +
> +	return 0;
> +
> +err_clean_entity:
> +	media_entity_cleanup(&tw9900->subdev.entity);
> +err_power_off:
> +	tw9900_power_off(tw9900);
> +
> +	return ret;
> +}
> +
> +static void tw9900_remove(struct i2c_client *client)
> +{
> +	struct v4l2_subdev *sd =3D i2c_get_clientdata(client);
> +
> +	v4l2_async_unregister_subdev(sd);
> +	media_entity_cleanup(&sd->entity);
> +}
> +
> +static const struct i2c_device_id tw9900_id[] =3D {
> +	{ "tw9900", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, tw9900_id);
> +
> +static const struct of_device_id tw9900_of_match[] =3D {
> +	{ .compatible =3D "techwell,tw9900" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, tw9900_of_match);
> +
> +static struct i2c_driver tw9900_i2c_driver =3D {
> +	.driver =3D {
> +		.name		=3D "tw9900",
> +		.of_match_table	=3D tw9900_of_match
> +	},
> +	.probe	  =3D tw9900_probe,
> +	.remove	  =3D tw9900_remove,
> +	.id_table =3D tw9900_id,
> +};
> +
> +module_i2c_driver(tw9900_i2c_driver);
> +
> +MODULE_DESCRIPTION("tw9900 decoder driver");
> +MODULE_LICENSE("GPL");
> --=20
> 2.41.0
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--64XEZOarVR5dsTg8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmVDc/4ACgkQ3cLmz3+f
v9GxIAf+NOp7Vd/7Jb0F8AeuVsmKbCoPdFMof41rIVUoaVa61WnIIgCpBivxc0U8
Jcnl6MlwOhOO8mXTzRleP/rJ4u9dHiCFanJmDa3lfaBG6hSr7c3+fUjq/vZ1csfZ
hL5WQ/RPxJ6Tf2GbVRoqm3LaAuMQAT0bWFDD+RCxJhJG/bZv5X7shZNe23VCtKhE
6Tngc0zH0/jlTMev0y80qa7KB5CihryaeEoFCjySzYKcoH3sYFlMIrIcP6FM5zlt
RTgnQxCJ26C8MauKUlqDuTaUoeVNjA8CEoSETecx1F3N9cZ87ZZolxNJfDbkoJzI
yz4S/XUMjSlEj8gwj7z0JqxoJuf9kQ==
=xWWQ
-----END PGP SIGNATURE-----

--64XEZOarVR5dsTg8--
