Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A627B79EC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241610AbjJDIWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjJDIWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:22:45 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C2DA6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 01:22:42 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57be3d8e738so1036291eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 01:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1696407761; x=1697012561; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PJhWTahwPzFcO3iUw842eEfYD0v/m2gKJpoeejD6OZM=;
        b=RG6LGWbavshJ7SFvqsHY6+Q81+OWBMzzUepbBjNTYYUoBkRdbBAqG1rBlZBFlXddwc
         bHXZArqE6cXslAuLWVwMQIN/L+22D/R5DQ5yAsdeHQHtOw155KDDJuQn6Xihl75v05Rk
         zPGCGriVwp2z5Yj0OBA90Od4Q4TNve3waTeZWGpAHVq6n3sgCY7fHgb8iKWsbtjIw9cr
         YdgGClltdSgMvTQUIBpMorhfPGDYeFcDwnxv8JV2ZVqgsHsmpXgF0xxf6pfE8vXjrtrx
         qPnl2Dt1zjoM6EuAyopHWIm9vB0pv9XmQ2kOVwft45haBVlbhtoDAtBWe9epNuVH/ZLA
         j/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696407761; x=1697012561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJhWTahwPzFcO3iUw842eEfYD0v/m2gKJpoeejD6OZM=;
        b=ZyDdid5I370Z0cJBMQdhXRT/L0llpwC4vaECEpd6x4gEQKFRYML+g+ZQ+zcwryh97z
         B16El6cJOO5c+16lpiQzghEc1tw+iYF4BcTgfPMC1ys0CIbXYqwTNdgz3HKsL+MvUC4H
         q1AWyEKHL+WW6kyMyLPGpVONr+EeJxugThfY43y0k2n7SCGRXS3Mmqe/c3G0n2cxzuo8
         uK34/on+i0LQxK6MiTfKuUdP3aqJewu6AyZ8CtN9TfMMtRxEP3A2krUe76vVOWpskSKD
         vAsewWs9bPiTGPD8r8LER5JpfXanb/USTtr6XmHFtLL1jYjq0w16hZhrLCEOTyP4tN5o
         cr4A==
X-Gm-Message-State: AOJu0YxcHekyhxTPd2DxA2CKoLETVldmTZWxKQwmZvXeV1h5ICq0ZWyC
        QVgWOFnXuO0Afp6fdcTD2A2A4onFh54L2ntU9/2FfXsqoDOK3sVt81k=
X-Google-Smtp-Source: AGHT+IHqP3gZ1v8UjWse496ioyNyDRr9Q18xYYHrvnlwMPL+uHQjCBUqa75yp5tcgVSppEo0NVCOJmbPTsq0VmUnlng=
X-Received: by 2002:a05:6358:720f:b0:143:5697:b682 with SMTP id
 h15-20020a056358720f00b001435697b682mr2250793rwa.24.1696407761303; Wed, 04
 Oct 2023 01:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230919054824.3368656-1-naresh.solanki@9elements.com> <6b7e00e6-c7ff-4bd7-a7b3-81f914ba3031@roeck-us.net>
In-Reply-To: <6b7e00e6-c7ff-4bd7-a7b3-81f914ba3031@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Wed, 4 Oct 2023 13:52:30 +0530
Message-ID: <CABqG17hv9VTus_Zdf6t4pYJFc1uk5sk+6AQA46RDf6bXhvb=Sg@mail.gmail.com>
Subject: Re: [PATCH v4] regulator (max5970): Add hwmon support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     broonie@kernel.org, zev@bewilderbeest.net,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,


On Wed, 27 Sept 2023 at 01:06, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Sep 19, 2023 at 07:48:23AM +0200, Naresh Solanki wrote:
> > Utilize the integrated 10-bit ADC in Max5970/Max5978 to enable voltage
> > and current monitoring. This feature is seamlessly integrated through
> > the hwmon subsystem.
> >
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > ---
> > Changes in V4:
> > - Use IS_REACHABLE
> > - Use rdevs array for hwmon ops.
> > - Remove duplicate i2c_set_clientdata
> > Changes in V3:
> > - Update signed-off
> > - Add break
> > - Update hwmon dev register name to max5970
> > - Remove changes in Kconfig.
> > Changes in V2:
> > - default case added for switch statement
> > - Add dependency on HWMON
> > ---
> >  drivers/regulator/max5970-regulator.c | 138 +++++++++++++++++++++++++-
> >  1 file changed, 136 insertions(+), 2 deletions(-)
> >
> >
> > base-commit: 41f02a383ac652f1a0b5538c5901b7ec93e37290
> >
> > diff --git a/drivers/regulator/max5970-regulator.c b/drivers/regulator/max5970-regulator.c
> > index b56a174cde3d..06168fe1dadd 100644
> > --- a/drivers/regulator/max5970-regulator.c
> > +++ b/drivers/regulator/max5970-regulator.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/bitops.h>
> >  #include <linux/device.h>
> >  #include <linux/err.h>
> > +#include <linux/hwmon.h>
> >  #include <linux/module.h>
> >  #include <linux/io.h>
> >  #include <linux/of.h>
> > @@ -32,6 +33,128 @@ enum max597x_regulator_id {
> >       MAX597X_SW1,
> >  };
> >
> > +static int max5970_read_adc(struct regmap *regmap, int reg, long *val)
> > +{
> > +     u8 reg_data[2];
> > +     int ret;
> > +
> > +     ret = regmap_bulk_read(regmap, reg, &reg_data[0], 2);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     *val = (reg_data[0] << 2) | (reg_data[1] & 3);
> > +
> > +     return 0;
> > +}
> > +
> > +static int max5970_read(struct device *dev, enum hwmon_sensor_types type,
> > +                     u32 attr, int channel, long *val)
> > +{
> > +     struct regulator_dev **rdevs = dev_get_drvdata(dev);
> > +     struct max5970_regulator *ddata = rdev_get_drvdata(rdevs[channel]);
> > +     struct regmap *regmap = ddata->regmap;
> > +     int ret;
> > +
> > +     switch (type) {
> > +     case hwmon_curr:
> > +             switch (attr) {
> > +             case hwmon_curr_input:
> > +                     ret = max5970_read_adc(regmap, MAX5970_REG_CURRENT_H(channel), val);
> > +                     /*
> > +                      * Calculate current from ADC value, IRNG range & shunt resistor value.
> > +                      * ddata->irng holds the voltage corresponding to the maximum value the
> > +                      * 10-bit ADC can measure.
> > +                      * To obtain the output, multiply the ADC value by the IRNG range (in
> > +                      * millivolts) and then divide it by the maximum value of the 10-bit ADC.
> > +                      */
> > +                     *val = (*val * ddata->irng) >> 10;
> > +                     /* Convert the voltage meansurement across shunt resistor to current */
> > +                     *val = (*val * 1000) / ddata->shunt_micro_ohms;
> > +                     return ret;
> > +             default:
> > +                     return -EOPNOTSUPP;
> > +             }
> > +
> > +     case hwmon_in:
> > +             switch (attr) {
> > +             case hwmon_in_input:
> > +                     ret = max5970_read_adc(regmap, MAX5970_REG_VOLTAGE_H(channel), val);
> > +                     /*
> > +                      * Calculate voltage from ADC value and MON range.
> > +                      * ddata->mon_rng holds the voltage corresponding to the maximum value the
> > +                      * 10-bit ADC can measure.
> > +                      * To obtain the output, multiply the ADC value by the MON range (in
> > +                      * microvolts) and then divide it by the maximum value of the 10-bit ADC.
> > +                      */
> > +                     *val = mul_u64_u32_shr(*val, ddata->mon_rng, 10);
> > +                     /* uV to mV */
> > +                     *val = *val / 1000;
> > +                     return ret;
> > +             default:
> > +                     return -EOPNOTSUPP;
> > +             }
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> > +
> > +static umode_t max5970_is_visible(const void *data,
> > +                               enum hwmon_sensor_types type,
> > +                               u32 attr, int channel)
> > +{
> > +     struct regulator_dev **rdevs = (struct regulator_dev **)data;
> > +     struct max5970_regulator *ddata;
> > +
> > +     if (!rdevs || !rdevs[channel])
>
> How can rdevs be NULL here ? Unless I am missing something, that can
> only happen if its allocation in the probe function failed, but then
> the system would long since have crashed before it gets here.
>
> Also, rdevs[] only has as many entries as there are switches. That can
> be 1 or 2. However, the hwmon subsystem will always assume that there are
> two channels, because it is told so, and it will thus try to access rdevs[1]
> even if only a single channel was allocated.
Yes. Will update to:
if (!rdevs[channel])
        return 0;
Also will simplify memory allocation to have two element array.
>
> > +             return 0;
> > +
> > +     ddata = rdev_get_drvdata(rdevs[channel]);
>
> With the above in mind, I wonder what that points to if channel == 1 and
> ddata->num_switches == 1.
This can be avoided with memory allocation simplification & previous
if condition check.
>
> > +
> > +     if (!ddata || channel >= ddata->num_switches)
> > +             return 0;
> > +
> > +     switch (type) {
> > +     case hwmon_in:
> > +             switch (attr) {
> > +             case hwmon_in_input:
> > +                     return 0444;
> > +             default:
> > +                     break;
> > +             }
> > +             break;
> > +     case hwmon_curr:
> > +             switch (attr) {
> > +             case hwmon_curr_input:
> > +                     /* Current measurement requires knowledge of the shunt resistor value. */
> > +                     if (ddata->shunt_micro_ohms)
> > +                             return 0444;
> > +                     break;
> > +             default:
> > +                     break;
> > +             }
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +     return 0;
> > +}
> > +
> > +static const struct hwmon_ops max5970_hwmon_ops = {
> > +     .is_visible = max5970_is_visible,
> > +     .read = max5970_read,
> > +};
> > +
> > +static const struct hwmon_channel_info *max5970_info[] = {
> > +     HWMON_CHANNEL_INFO(in, HWMON_I_INPUT, HWMON_I_INPUT),
> > +     HWMON_CHANNEL_INFO(curr, HWMON_C_INPUT, HWMON_C_INPUT),
> > +     NULL
> > +};
> > +
> > +static const struct hwmon_chip_info max5970_chip_info = {
> > +     .ops = &max5970_hwmon_ops,
> > +     .info = max5970_info,
> > +};
> > +
> >  static int max597x_uvp_ovp_check_mode(struct regulator_dev *rdev, int severity)
> >  {
> >       int ret, reg;
> > @@ -431,7 +554,8 @@ static int max597x_regulator_probe(struct platform_device *pdev)
> >       struct i2c_client *i2c = to_i2c_client(pdev->dev.parent);
> >       struct regulator_config config = { };
> >       struct regulator_dev *rdev;
> > -     struct regulator_dev *rdevs[MAX5970_NUM_SWITCHES];
> > +     struct regulator_dev **rdevs = NULL;
> > +     struct device *hwmon_dev;
> >       int num_switches;
> >       int ret, i;
> >
> > @@ -451,9 +575,10 @@ static int max597x_regulator_probe(struct platform_device *pdev)
> >       else
> >               return -ENODEV;
> >
> > -     i2c_set_clientdata(i2c, max597x);
> >       num_switches = max597x->num_switches;
> >
> > +     rdevs = devm_kcalloc(&i2c->dev, num_switches, sizeof(struct regulator_dev *), GFP_KERNEL);
> > +
>
> What if devm_kcalloc() returns NULL ?
Will add error checking here.
>
> >       for (i = 0; i < num_switches; i++) {
> >               data =
> >                   devm_kzalloc(&i2c->dev, sizeof(struct max5970_regulator),
> > @@ -485,6 +610,15 @@ static int max597x_regulator_probe(struct platform_device *pdev)
> >               max597x->shunt_micro_ohms[i] = data->shunt_micro_ohms;
> >       }
> >
> > +     if (IS_REACHABLE(CONFIG_HWMON)) {
> > +             hwmon_dev = devm_hwmon_device_register_with_info(&i2c->dev, "max5970", rdevs,
> > +                                                              &max5970_chip_info, NULL);
> > +             if (IS_ERR(hwmon_dev)) {
> > +                     return dev_err_probe(&i2c->dev, PTR_ERR(hwmon_dev),
> > +                                          "Unable to register hwmon device\n");
> > +             }
> > +     }
> > +
> >       if (i2c->irq) {
> >               ret =
> >                   max597x_setup_irq(&i2c->dev, i2c->irq, rdevs, num_switches,


Regards,
Naresh
