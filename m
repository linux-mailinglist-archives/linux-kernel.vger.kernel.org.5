Return-Path: <linux-kernel+bounces-96357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385F2875AF4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B64F1C2105C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5113F9DE;
	Thu,  7 Mar 2024 23:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Criokw7C"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37BC2E648;
	Thu,  7 Mar 2024 23:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709853143; cv=none; b=N+QYnsWJ1zfbOLwBAr2Pgwb2p0H/vtNc3hMHFhJp+GEQ/+YsLnMi/9PNZw3N5bJSq7FhKPNhmESy87pHvcLWea11oky8KYatHVhLNzQebPlYwEFHjh+wC1mdZkMaEQYNQTSEFGSalhbMDd3T6H8lqwXAkNrmBQG0OdU9ni72enM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709853143; c=relaxed/simple;
	bh=CmjyZes5Qlhbfnd2Y+0692hdVxLoArfO5/4AlWnfbGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9g3lQloI/9ZhhA22bAaQp1xpR+I9+u3kGK4kLF+6V4KCzsHRXXob5NOCZi6Mn/4AHOfhls1uqs150FvVfNaeaj4eQIvcwtx9zebr6yVwUvqoYKdidosrvJVFxhVAK3tWH2BEBWvJkvBB14FgUWtrkmXkoj+S1UGxx2j66HV7Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Criokw7C; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51320ca689aso346135e87.2;
        Thu, 07 Mar 2024 15:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709853140; x=1710457940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVEc5Xl+i99zIqPFLTRwHZY3ZSTjKvswMjVmatg1/JM=;
        b=Criokw7CbpBc5PkpFGQcHvVZx8S4OXjF8Rnd1saEsPtTEP6/b7AyiNrxBjfcd/NTw/
         xH+moDz4l/+zAF7Q43easRI64V8a7qmliRtPuwdfY+eutUbJfW+buqHKtie3zeDj7qGe
         9B01KxY4zGJmRFICXSelKNCVcdHN7iEglFhOp/mZuO9hHc72jLP93TmoPadnUVbJKj2C
         QaYoXhA6K7lGRqbSEJxG5BsCty/zTi8TzeL/TB6wngmM/bGgjE+JztW89S/yhCHySxSS
         PTJPlqXbZZXr8rghmWLVCOUc0vny1BTuGPF3hwgD4kQcCfSR0X/PuukHFGRuf+ejHQfv
         1ZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709853140; x=1710457940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVEc5Xl+i99zIqPFLTRwHZY3ZSTjKvswMjVmatg1/JM=;
        b=L9GsqmbSBkh04He3JcIpsONEDxj1eh5BANXtKYAEXEuXBzO5BIKg/FikYWNroMQban
         MVTHzYtL6q7lBZjUE49DQu/+wHRiEHaJrH6J09AAG30SVjoOerskZoyTNqiRe2IZhG4m
         PhXWNQVPMCEAp1mwpdiqBbaPdopk77hGwClL+nivGk2n7wAd3U1kzD2COytbPDuDEQG9
         /VO8yPnTZ8Bh43SxcLVo9cBjjtQ/e8sTBsHAJ4YK9Wm5/drVn4TI101XlwvtFYOpvm5r
         fqB16iGFTAoECnKV7pwWvyUSrX632JzWs7mM2dHIPcNmOtMai/dbtzeLl5uR5IIW7uoa
         Rg0A==
X-Forwarded-Encrypted: i=1; AJvYcCVj6G2/bpPhDHKoxyQNKfKJ1jbS5XuwyjaHA5jagY3eoebDnzoZtjUNtWSP138QMvFaODq0u+rk3xAW+1dquGIsvweJ94fSpo+Kd94V
X-Gm-Message-State: AOJu0YzLpTMrQRe6ZgT+tg3y3sGlV82xOY+uZoHQLtvXFEqfs42VYDzQ
	YoQEc9zu0ub1vSJHqH74K3KIKTWwvj1MxkJ1AgmBX/7IPXknOzfJqDAP75DDi+kE/k3T1x2tJB7
	RXcluWKHBy68eMr1gPBgigFLLdcc=
X-Google-Smtp-Source: AGHT+IEHyocgVSKDcnR4dHTen9epwObJpndd4s1P4/3IZYbEpK0dy8pqTHlurooqt9pz9UvFy807F+H6C3a+uBC9uvk=
X-Received: by 2002:a05:6512:39cd:b0:513:58dc:1377 with SMTP id
 k13-20020a05651239cd00b0051358dc1377mr3172922lfu.45.1709853139367; Thu, 07
 Mar 2024 15:12:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307214048.858318-1-umang.jain@ideasonboard.com> <20240307214048.858318-3-umang.jain@ideasonboard.com>
In-Reply-To: <20240307214048.858318-3-umang.jain@ideasonboard.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 8 Mar 2024 01:11:42 +0200
Message-ID: <CAHp75Vcvvadd6EeTWk2ZDrmtCQzWBV8rOoxNCotzYRRPwecaEA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] media: i2c: Add imx283 camera sensor driver
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, willl will <will@willwhang.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Hans de Goede <hdegoede@redhat.com>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Paul Elder <paul.elder@ideasonboard.com>, 
	Mehdi Djait <mehdi.djait@bootlin.com>, Bingbu Cao <bingbu.cao@intel.com>, 
	Sebastian Reichel <sre@kernel.org>, Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 11:41=E2=80=AFPM Umang Jain <umang.jain@ideasonboard=
com> wrote:
>
> From: Kieran Bingham <kieran.bingham@ideasonboard.com>
>
> Add a v4l2 subdevice driver for the Sony IMX283 image sensor.
>
> The IMX283 is a 20MP Diagonal 15.86 mm (Type 1) CMOS Image Sensor with
> Square Pixel for Color Cameras.
>
> The following features are supported:
> - Manual exposure an gain control support
> - vblank/hblank/link freq control support
> - Test pattern support control
> - Arbitrary horizontal and vertical cropping
> - Supported resolution:
>   - 5472x3648 @ 20fps (SRGGB12)
>   - 5472x3648 @ 25fps (SRGGB10)
>   - 2736x1824 @ 50fps (SRGGB12)

..

+ array_size.h
+ bitops.h
+ container_of.h

> +#include <linux/clk.h>
> +#include <linux/delay.h>

+ errno.h

> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>

+ mutex.h

> +#include <linux/of.h>

How is this being used, please?

> +#include <linux/pm_runtime.h>

+ property.h

> +#include <linux/regulator/consumer.h>

+ types.h

> +#include <linux/units.h>

..

> +#define IMX283_HMAX_MAX                        0xffff

I would rather use the form of (BIT(16) - 1) to imply that this is
limited by bit field in the HW.

..

> +#define   IMX283_VMAX_MAX              0xfffff

Ditto.

..

> +#define IMX283_XCLR_MIN_DELAY_US       1000
> +#define IMX283_XCLR_DELAY_RANGE_US     1000

Perhaps (1 * USEC_PER_MSEC) ?

..

> +       /* Veritcal 2/9 subsampling, horizontal 3 binning cropping */

Vertical

..

> +static const s64 link_frequencies[] =3D {
> +       720 * MEGA, /* 1440 Mbps lane data rate */
> +       360 * MEGA, /* 720 Mbps data lane rate */

HZ_PER_MHZ

> +};

..

> +/* regulator supplies */
> +static const char *const imx283_supply_name[] =3D {
> +       "vadd", /* Analog (2.9V) supply */
> +       "vdd1", /* Supply Voltage 2 (1.8V) supply */
> +       "vdd2", /* Supply Voltage 3 (1.2V) supply */
> +};
> +
> +

One blank line is enough.

..

> +       default:
> +               *mode_list =3D NULL;
> +               *num_modes =3D 0;

break;

..

> +       u64 link_frequency =3D link_frequencies[__ffs(imx283->link_freq_b=
itmap)];
> +
> +       return link_frequency * ddr * lanes / bpp;

No overflow on 32-bit?

..

> +static u64 imx283_internal_clock(unsigned int pixel_rate, unsigned int p=
ixels)
> +{
> +       /*
> +        * Determine the following operation without overflow:
> +        *    pixels =3D 72 * MEGA / pixel_rate

Use proper units in the comments, I believe you want MHz here.

> +        * The internal clock at 72MHz and Pixel Rate (between 240 and 57=
6MHz)
> +        * can easily overflow this calculation, so pre-divide to simplif=
y.
> +        */
> +       const u32 iclk_pre =3D 72 * MEGA / 1000000;

HZ_PER_MHZ
MEGA

(But why? wouldn't simply 72 be enough here?)

> +       const u32 pclk_pre =3D pixel_rate / 1000000;

MEGA

> +       return pixels * iclk_pre / pclk_pre;
> +}

..

> +static u64 imx283_iclk_to_pix(unsigned int pixel_rate, unsigned int cycl=
es)

Same comments as per above function.

..

> +       do_div(numerator, hmax);

> +       numerator =3D clamp_t(u32, numerator, 0, 0xFFFFFFFF);

Please, avoid _t variant, better to use proper types.
Also the last should be U32_MAX, no?

> +       return numerator;

return clamp(...);

..

> +       max_shr =3D min_t(u64, max_shr, 0xFFFF);

No min_t() please. You probably wanted clamp() here.

..

> +/*
> + * Integration Time [s] =3D [{VMAX x (SVR + 1) =E2=80=93 (SHR)} x HMAX +=
 offset]
> + *                      / (72 x 10^6)

Indent better, so we can read easily.

> + */

..

> +       shr =3D (u32)(vmax * (svr + 1) - temp);
> +
> +       return shr;

Unneeded casting, simply

return vmas * ...;

..

> +               current_exposure =3D clamp_t(u32, current_exposure, min_e=
xposure,
> +                                          max_exposure);

Can it be clamp()?

..

> +       case V4L2_CID_VBLANK:
> +               imx283->vmax =3D mode->height + ctrl->val;
> +               dev_dbg(imx283->dev, "V4L2_CID_VBLANK : %d  VMAX : %d\n",
> +                       ctrl->val, imx283->vmax);

%d or %u? Check ALL specifiers to have proper signedness.

> +               ret =3D cci_write(imx283->cci, IMX283_REG_VMAX, imx283->v=
max, NULL);
> +               break;

..

> +       usleep_range(1000, 2000); /* 1st Stabilisation period of 1 ms or =
more */

fsleep()

..

> +       /* Apply customized values from controls (HMAX/VMAX/SHR) */
> +       ret =3D  __v4l2_ctrl_handler_setup(imx283->sd.ctrl_handler);
> +
> +       return ret;

return __v4l2_ctrl_handler_setup(...);

..

> +       ret =3D cci_write(imx283->cci, IMX283_REG_STANDBY, IMX283_STBLOGI=
C, NULL);
> +       if (ret)
> +               dev_err(imx283->dev, "%s failed to set stream\n", __func_=
_);

Why __func__?

..

> +       ret =3D regulator_bulk_enable(ARRAY_SIZE(imx283_supply_name),
> +                                   imx283->supplies);
> +       if (ret) {
> +               dev_err(imx283->dev, "%s: failed to enable regulators\n",
> +                       __func__);
> +               return ret;

Ditto.

> +       }
> +
> +       ret =3D clk_prepare_enable(imx283->xclk);
> +       if (ret) {
> +               dev_err(imx283->dev, "%s: failed to enable clock\n",
> +                       __func__);

Ditto.

> +               goto reg_off;
> +       }

This Q applies to all error messages.

..

> +static int __maybe_unused imx283_power_off(struct device *dev)

No __maybe_unused in a new code.

..

> +       switch (sel->target) {
> +       case V4L2_SEL_TGT_CROP: {
> +               sel->r =3D *v4l2_subdev_state_get_crop(sd_state, 0);
> +               return 0;
> +       }
> +
> +       case V4L2_SEL_TGT_NATIVE_SIZE:
> +               sel->r =3D imx283_native_area;
> +               return 0;
> +
> +       case V4L2_SEL_TGT_CROP_DEFAULT:
> +       case V4L2_SEL_TGT_CROP_BOUNDS:
> +               sel->r =3D imx283_active_area;
> +               return 0;
> +       }
> +
> +       return -EINVAL;

Instead use default: case.

..

> +       mutex_lock(imx283->ctrl_handler.lock);

> +       mutex_unlock(imx283->ctrl_handler.lock);

Can you use cleanup.h?

..

> +static int imx283_parse_endpoint(struct imx283 *imx283)
> +{
> +       struct fwnode_handle *fwnode =3D dev_fwnode(imx283->dev);

Split this assignment that it will be easier to understand at the
first use where it came from.

> +       struct v4l2_fwnode_endpoint bus_cfg =3D {
> +               .bus_type =3D V4L2_MBUS_CSI2_DPHY
> +       };
> +       struct fwnode_handle *ep;
> +       int ret;

fwnode =3D ...

> +       if (!fwnode)
> +               return -ENXIO;
> +
> +       ep =3D fwnode_graph_get_next_endpoint(fwnode, NULL);
> +       if (!ep) {
> +               dev_err(imx283->dev, "Failed to get next endpoint\n");
> +               return -ENXIO;
> +       }
> +
> +       ret =3D v4l2_fwnode_endpoint_alloc_parse(ep, &bus_cfg);
> +       fwnode_handle_put(ep);
> +       if (ret)
> +               return ret;
> +
> +       if (bus_cfg.bus.mipi_csi2.num_data_lanes !=3D 4) {
> +               dev_err(imx283->dev,
> +                       "number of CSI2 data lanes %d is not supported\n"=
,
> +                       bus_cfg.bus.mipi_csi2.num_data_lanes);
> +               ret =3D -EINVAL;
> +               goto done_endpoint_free;
> +       }
> +
> +       ret =3D v4l2_link_freq_to_bitmap(imx283->dev, bus_cfg.link_freque=
ncies,
> +                                      bus_cfg.nr_of_link_frequencies,
> +                                      link_frequencies, ARRAY_SIZE(link_=
frequencies),
> +                                      &imx283->link_freq_bitmap);
> +
> +done_endpoint_free:
> +       v4l2_fwnode_endpoint_free(&bus_cfg);
> +
> +       return ret;
> +};

..

> +       imx283->cci =3D devm_cci_regmap_init_i2c(client, 16);
> +       if (IS_ERR(imx283->cci)) {
> +               ret =3D PTR_ERR(imx283->cci);
> +               dev_err(imx283->dev, "failed to initialize CCI: %d\n", re=
t);
> +               return ret;

What's wrong with

  return dev_err_probe(...);

?

> +       }

..

> +       if (!imx283->freq) {
> +               dev_err(imx283->dev, "xclk frequency unsupported: %d Hz\n=
", xclk_freq);
> +               return -EINVAL;

return dev_err_probe(...);

> +       }

..

> +       ret =3D imx283_parse_endpoint(imx283);
> +       if (ret) {
> +               dev_err(imx283->dev, "failed to parse endpoint configurat=
ion\n");
> +               return ret;

Ditto.

Make all messages in ->probe() stage to use the same pattern.

> +       }

..

> +       /* Request optional enable pin */
> +       imx283->reset_gpio =3D devm_gpiod_get_optional(imx283->dev, "rese=
t",
> +                                                    GPIOD_OUT_LOW);

No error check?! Why?

..

> +       ret =3D media_entity_pads_init(&imx283->sd.entity, 1, &imx283->pa=
d);
> +       if (ret) {
> +               dev_err(imx283->dev, "failed to init entity pads: %d\n", =
ret);

dev_err_probe(...);

> +               goto error_handler_free;
> +       }
> +
> +       imx283->sd.state_lock =3D imx283->ctrl_handler.lock;
> +       ret =3D v4l2_subdev_init_finalize(&imx283->sd);
> +       if (ret < 0) {
> +               dev_err(imx283->dev, "subdev init error: %d\n", ret);

Ditto.

> +               goto error_media_entity;
> +       }
> +
> +       ret =3D v4l2_async_register_subdev_sensor(&imx283->sd);
> +       if (ret < 0) {
> +               dev_err(imx283->dev, "failed to register sensor sub-devic=
e: %d\n", ret);

Ditto.

> +               goto error_subdev_cleanup;
> +       }

..

> +static const struct dev_pm_ops imx283_pm_ops =3D {
> +       SET_RUNTIME_PM_OPS(imx283_power_off, imx283_power_on, NULL)
> +};

Use the respective DEFINE_* PM macro.

..

> +static const struct of_device_id imx283_dt_ids[] =3D {
> +       { .compatible =3D "sony,imx283", },

Inner comma is not needed.

> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx283_dt_ids);
> +
> +static struct i2c_driver imx283_i2c_driver =3D {
> +       .driver =3D {
> +               .name =3D "imx283",
> +               .of_match_table =3D imx283_dt_ids,

> +               .pm =3D &imx283_pm_ops,

Missing respective PM macro.

> +       },
> +       .probe =3D imx283_probe,
> +       .remove =3D imx283_remove,
> +};

> +

Unneeded blank line.

> +module_i2c_driver(imx283_i2c_driver);

--=20
With Best Regards,
Andy Shevchenko

