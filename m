Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B537A493E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241892AbjIRMHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241951AbjIRMHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:07:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED56E197;
        Mon, 18 Sep 2023 05:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695038817; x=1726574817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rp8cq1yXS0m/MrKPrdwoAhoUUVmnHZDZwzHX59VGQkg=;
  b=MCZpTISK9wtin0yMYkVi/aYfUm87pCRc3t9/9Q/P5CgqnxUVal7r7bsg
   1ueziWQrh21+xgBUecZQMzaVKZYEypy4uO7/V+9FYjlwkLgXfojUeqeOt
   nH/ZvjfszytUfbcMNWexdw8zellxz/o8TPZ+rEkWZPX6yz7a3cPvudipM
   Y3P0E82zSKuniH6MJDb+RFQPxw42p002AGeZnE7dePdW4goEFOi5yoEkD
   hGfzPR/GbJmxSsYU5JYOQ3rfafAbQckii4YZ4FVU1hKbISr/5te91M+RU
   jEo3BZP+FXZyzZfCmvCCmWc6HF679ReVxW3HKTNb5CCG5CStC41sdnxec
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="378544668"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="378544668"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 05:01:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="816008522"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="816008522"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 05:01:28 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 2C20311FAD0;
        Mon, 18 Sep 2023 15:01:26 +0300 (EEST)
Date:   Mon, 18 Sep 2023 12:01:26 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] media: i2c: Add ROHM BU64754 Camera Autofocus
 Actuator
Message-ID: <ZQg8FugCJfrlmMiR@kekkonen.localdomain>
References: <20230915165946.4183839-1-kieran.bingham@ideasonboard.com>
 <20230915165946.4183839-3-kieran.bingham@ideasonboard.com>
 <CAPY8ntCeo2LVCRbcrx8q+RSvo2B+KcUYRCAkoHCeVywioknM2A@mail.gmail.com>
 <169480557269.84025.9501931492272338428@ping.linuxembedded.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169480557269.84025.9501931492272338428@ping.linuxembedded.co.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran, Dave,

On Fri, Sep 15, 2023 at 08:19:32PM +0100, Kieran Bingham wrote:
> Hi Dave,
> 
> Quoting Dave Stevenson (2023-09-15 18:44:02)
> > Hi Kieran
> > 
> > On Fri, 15 Sept 2023 at 18:02, Kieran Bingham
> > <kieran.bingham@ideasonboard.com> wrote:
> > >
> > > Add support for the ROHM BU64754 Motor Driver for Camera Autofocus. A
> > > V4L2 Subdevice is registered and provides a single
> > > V4L2_CID_FOCUS_ABSOLUTE control.
> > >
> > > Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> > > ---
> > >  MAINTAINERS                 |   1 +
> > >  drivers/media/i2c/Kconfig   |  13 ++
> > >  drivers/media/i2c/Makefile  |   1 +
> > >  drivers/media/i2c/bu64754.c | 308 ++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 323 insertions(+)
> > >  create mode 100644 drivers/media/i2c/bu64754.c
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index f43e0ffcaf56..fd244560c317 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -18576,6 +18576,7 @@ L:      linux-media@vger.kernel.org
> > >  S:     Maintained
> > >  T:     git git://linuxtv.org/media_tree.git
> > >  F:     Documentation/devicetree/bindings/media/i2c/rohm,bu64754.yaml
> > > +F:     drivers/media/i2c/bu64754.c
> > >
> > >  ROHM MULTIFUNCTION BD9571MWV-M PMIC DEVICE DRIVERS
> > >  M:     Marek Vasut <marek.vasut+renesas@gmail.com>
> > > diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> > > index 74ff833ff48c..b7b8004816ed 100644
> > > --- a/drivers/media/i2c/Kconfig
> > > +++ b/drivers/media/i2c/Kconfig
> > > @@ -641,6 +641,19 @@ config VIDEO_AK7375
> > >           capability. This is designed for linear control of
> > >           voice coil motors, controlled via I2C serial interface.
> > >
> > > +config VIDEO_BU64754
> > > +       tristate "BU64754 Motor Driver for Camera Autofocus"
> > > +       depends on I2C && VIDEO_DEV
> > > +       select MEDIA_CONTROLLER
> > > +       select VIDEO_V4L2_SUBDEV_API
> > > +       select V4L2_ASYNC
> > > +       select V4L2_CCI_I2C
> > > +       help
> > > +         This is a driver for the BU64754 Motor Driver for Camera
> > > +         Autofocus. The BU64754 is an actuator driver IC which can
> > > +         control the actuator position precisely using an internal
> > > +         Hall Sensor.
> > 
> > I can't find any data on this driver.
> > Is it still expecting a VCM and hence near instantaneous movement? I
> > was noting your comment on the hall sensor and thinking you
> > potentially needed to be able to report whether the target position
> > had been reached or not. Michael's series at [1] was trying to address
> > that.
> 
> The hall sensor is internal. The component description is just a
> slightly fixed grammar of the product brief.
> 
> As I understand it, this is a VCM yes but I have so little visibility.
> 
> > 
> > [1] https://patchwork.linuxtv.org/project/linux-media/cover/20230406-feature-controls-lens-v2-0-faa8ad2bc404@wolfvision.net/
> > 
> > > +
> > >  config VIDEO_DW9714
> > >         tristate "DW9714 lens voice coil support"
> > >         depends on I2C && VIDEO_DEV
> > > diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
> > > index 80b00d39b48f..e62aa0df7b1a 100644
> > > --- a/drivers/media/i2c/Makefile
> > > +++ b/drivers/media/i2c/Makefile
> > > @@ -22,6 +22,7 @@ obj-$(CONFIG_VIDEO_AR0521) += ar0521.o
> > >  obj-$(CONFIG_VIDEO_BT819) += bt819.o
> > >  obj-$(CONFIG_VIDEO_BT856) += bt856.o
> > >  obj-$(CONFIG_VIDEO_BT866) += bt866.o
> > > +obj-$(CONFIG_VIDEO_BU64754) += bu64754.o
> > >  obj-$(CONFIG_VIDEO_CCS) += ccs/
> > >  obj-$(CONFIG_VIDEO_CCS_PLL) += ccs-pll.o
> > >  obj-$(CONFIG_VIDEO_CS3308) += cs3308.o
> > > diff --git a/drivers/media/i2c/bu64754.c b/drivers/media/i2c/bu64754.c
> > > new file mode 100644
> > > index 000000000000..3367b6f17660
> > > --- /dev/null
> > > +++ b/drivers/media/i2c/bu64754.c
> > > @@ -0,0 +1,308 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * The BU64754 is an actuator driver IC which can control the
> > > + * actuator position precisely using an internal Hall Sensor.
> > > + */
> > > +
> > > +#include <linux/delay.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/module.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/regulator/consumer.h>
> > > +
> > > +#include <media/v4l2-cci.h>
> > > +#include <media/v4l2-ctrls.h>
> > > +#include <media/v4l2-device.h>
> > > +
> > > +#define BU64754_REG_ACTIVE     CCI_REG16(0x07)
> > > +#define BU64754_ACTIVE_MODE    0x8080
> > > +
> > > +#define BU64754_REG_SERVE      CCI_REG16(0xd9)
> > > +#define BU64754_SERVE_ON       0x0404
> > > +
> > > +#define BU64754_REG_POSITION   CCI_REG16(0x45)
> > > +#define BU64753_POSITION_MAX   1023 /* 0x3ff */
> > > +
> > > +#define BU64754_POWER_ON_DELAY 800 /* uS : t1, t3 */
> > > +
> > > +struct bu64754 {
> > > +       struct device *dev;
> > > +
> > > +       struct v4l2_ctrl_handler ctrls_vcm;
> > > +       struct v4l2_subdev sd;
> > > +       struct regmap *cci;
> > > +
> > > +       u16 current_val;
> > > +       struct regulator *vdd;
> > > +       struct notifier_block notifier;
> > > +};
> > > +
> > > +static inline struct bu64754 *sd_to_bu64754(struct v4l2_subdev *subdev)
> > > +{
> > > +       return container_of(subdev, struct bu64754, sd);
> > > +}
> > > +
> > > +static int bu64754_set(struct bu64754 *bu64754, u16 position)
> > > +{
> > > +       int ret;
> > > +
> > > +       ret = cci_write(bu64754->cci, BU64754_REG_POSITION, position, NULL);
> > > +       if (ret) {
> > > +               dev_err(bu64754->dev, "Set position failed ret=%d\n", ret);
> > > +               return ret;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int bu64754_active(struct bu64754 *bu64754)
> > > +{
> > > +       int ret;
> > > +
> > > +       /* Power on */
> > > +       ret = cci_write(bu64754->cci, BU64754_REG_ACTIVE, BU64754_ACTIVE_MODE,
> > > +                       NULL);
> > > +       if (ret < 0) {
> > > +               dev_err(bu64754->dev, "Failed to set active mode ret = %d\n",
> > > +                       ret);
> > > +               return ret;
> > > +       }
> > > +
> > > +       /* Serve on */
> > > +       ret = cci_write(bu64754->cci, BU64754_REG_SERVE, BU64754_SERVE_ON,
> > > +                       NULL);
> > > +       if (ret < 0) {
> > > +               dev_err(bu64754->dev, "Failed to enable serve ret = %d\n",
> > > +                       ret);
> > > +               return ret;
> > > +       }
> > > +
> > > +       return bu64754_set(bu64754, bu64754->current_val);
> > > +}
> > > +
> > > +static int bu64754_standby(struct bu64754 *bu64754)
> > > +{
> > > +       int ret;
> > > +
> > > +       cci_write(bu64754->cci, BU64754_REG_ACTIVE, 0, &ret);
> > > +       if (ret < 0)
> > > +               dev_err(bu64754->dev, "Failed to set active mode ret = %d\n",
> > > +                       ret);
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +static int bu64754_regulator_event(struct notifier_block *nb,
> > > +                                  unsigned long action, void *data)
> > > +{
> > > +       struct bu64754 *bu64754 = container_of(nb, struct bu64754, notifier);
> > > +
> > > +       if (action & REGULATOR_EVENT_ENABLE) {
> > > +               /*
> > > +                * Initialisation delay between VDD low->high and availability
> > > +                * i2c operation.
> > > +                */
> > > +               usleep_range(BU64754_POWER_ON_DELAY,
> > > +                            BU64754_POWER_ON_DELAY + 100);
> > > +
> > > +               bu64754_active(bu64754);
> > > +       } else if (action & REGULATOR_EVENT_PRE_DISABLE) {
> > > +               bu64754_standby(bu64754);
> > > +       }
> > 
> > Presumably this is based on the assumption that the same regulator
> > controls sensor and lens, so when the sensor is powered up the lens
> > position gets restored.
> > I'm sure when I suggested doing the same previously it was shot down
> > in flames ... found it [2]
> > 
> > Personally I think it makes sense that the lens powers up
> > automagically, and have almost exactly the same code as this in a
> > couple of our VCM drivers, but others disagree.
> 
> I've tested this on the Raspberry Pi, and I expect this design model
> comes from you originally then. I thought it was a good way to handle
> things, but I wasn't aware that others had already disagreed.
> 
> Being a module that will connect over the RPi interface, with a single
> POWER_EN, indeed - the regulators are shared with the camera, and
> synchronising how it is handled seemed reasonable. I guess I have some
> more reading to do now then.

Consider this is a driver for a VCM that may well be used in other sensors
and so wired differently.

Is there no reset GPIO? Or another regulator? Add these, and you will start
having circular dependencies.

In general case, the power up sequence is specific to the camera module.
We don't have a device for the modules but I think we could for cases where
you can't correctly execute the power on and off sequences separately for
the sensor and the lens.

What comes to powering on the lens based on the sensor --- could you use a
device link for that purpose?

> 
> I'm already thinking about making a 'simple-vcm' module or parent-driver
> that can reduce the boilerplate for the vcms though. There's very little
> difference between them all ... and I think they could be abstracted out
> substantially to simplify adding new devices.

Either that, or a library to have the helpers modular. That approach could
produce lots of very small drivers though.

-- 
Kind regards,

Sakari Ailus
