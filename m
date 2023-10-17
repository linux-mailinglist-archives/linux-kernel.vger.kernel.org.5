Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1886D7CC6EC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344127AbjJQPBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344080AbjJQPBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:01:18 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5534710F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:01:15 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27d4372322aso2452506a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1697554875; x=1698159675; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uq+1vYvsKUhR+01sCVILJR2at0sMDRh6S+TkivbpdsI=;
        b=dxLh6l711+sNW2qDv26FbbOQHlZp88JFydocY+9vB/zHc7axS9VqF3aaJlqpiUtM/y
         /5CEESAdYKuVH3QO1t8yEm8OnUhwi9KXBtvKsaDCuYmTAEnLo7nkx+tBOlq9fmre+HyL
         SBJkUFw5oUB2PEEdvAgfW4seoEPGmzrHuEzg4RkGtOw8fLoYGZtq9HHVfcSG//zgm5/l
         DDsr3z/vES/YP31SvSNyFGzcu5+swsXbURU8u0T1x5w32DCY8kb8pAXWVJV2jBxUsjHS
         S7XF7XhThEi+hKswyH76Op103tVD2F8lifT1IYDeSB3lb5tfMIPiP0mGtP9m/uQt1cdd
         RmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697554875; x=1698159675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uq+1vYvsKUhR+01sCVILJR2at0sMDRh6S+TkivbpdsI=;
        b=QVx0vqvZ5Qdrj4ioHNw3+a7cGjmB3Eh6Clrg1H4g5W5DzscTPIOexz2iZWvAb6SFq1
         9xPAqt+d0MFAb6Sve1Fl7gPq7E0902DJfKwA5REaw/cRadj1TKCItGak5G1vHjOndQTk
         eni/2Kt8o6sz2pSgFqN11Iss+rYuf3T+gIctbguM5TRuX0bsHP+OptROK5EDCeVIQDXM
         wecDVopdLYALZEDyseDQgTqViCUJ7J/QpyRWuPzAw/4A5dxolLXTFxGoOWTdm9OVpYkS
         h9l+Q67h66q81zdU6+8Z/W9shtxQSeg7ZzCvZNCJ6+XGSuSlx7kdTiI8BdvtFKPKN16l
         d4YQ==
X-Gm-Message-State: AOJu0YxXNZPoQMyussIVsTTfq437Ca4fNQgQjcBUs4Grs4/yGL1fDmpi
        a1uGYccjATa6ap6AK4VgdvqV0e0zZycR5F7M5fS//g==
X-Google-Smtp-Source: AGHT+IH03vw4ZiVzpHXevOUKz9nspjwM2TxoPoMAPYygoFKdH4AW2A0kLpfWOHwh5gb6r8ionu93yvT0hU4mt+YeSIA=
X-Received: by 2002:a17:90a:ac0a:b0:27d:3968:8366 with SMTP id
 o10-20020a17090aac0a00b0027d39688366mr2439909pjq.8.1697554874479; Tue, 17 Oct
 2023 08:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231005075508.1656071-1-naresh.solanki@9elements.com> <a1bae0c4-0453-4f17-808f-859b684ae525@roeck-us.net>
In-Reply-To: <a1bae0c4-0453-4f17-808f-859b684ae525@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Tue, 17 Oct 2023 20:31:05 +0530
Message-ID: <CABqG17jAgjzT3M2O7OWuc_eMzRBVwnUhfBX7jCiVyineRsKaEA@mail.gmail.com>
Subject: Re: [PATCH v5] regulator (max5970): Add hwmon support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     broonie@kernel.org, zev@bewilderbeest.net,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 11 Oct 2023 at 19:50, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, Oct 05, 2023 at 09:55:07AM +0200, Naresh Solanki wrote:
> > Utilize the integrated 10-bit ADC in Max5970/Max5978 to enable voltage
> > and current monitoring. This feature is seamlessly integrated through
> > the hwmon subsystem.
> >
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > ---
> > Changes in V5:
> > - Simplify memory allocation for rdevs
> > Changes in V4:
> > - Use IS_REACHABLE
> > - Use rdevs array for hwmon ops.
> > - Remove duplicate i2c_set_clientdata
>
> I just noticed this one. Not my decision how to handle this,
> but the change is really unrelated to this patch.
Sure. Will make separate change for it.
>
> > Changes in V3:
> > - Update signed-off
> > - Add break
> > - Update hwmon dev register name to max5970
> > - Remove changes in Kconfig.
> > Changes in V2:
> > - default case added for switch statement
> > - Add dependency on HWMON
> > ---
> >  drivers/regulator/max5970-regulator.c | 141 +++++++++++++++++++++++++-
> >  1 file changed, 139 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/regulator/max5970-regulator.c b/drivers/regulator/max5970-regulator.c
> > index b56a174cde3d..71b4a543339a 100644
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
>
>                         if (ret < 0)
>                                 return ret;
Ack
>
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
>
>                         return 0;
Ack
>
> > +             default:
> > +                     return -EOPNOTSUPP;
> > +             }
> > +
> > +     case hwmon_in:
> > +             switch (attr) {
> > +             case hwmon_in_input:
> > +                     ret = max5970_read_adc(regmap, MAX5970_REG_VOLTAGE_H(channel), val);
>                         if (ret < 0)
>                                 return ret;
>
Ack
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
>
>                         return 0;
>
Ack
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
> > +     if (channel >= MAX5970_NUM_SWITCHES || !rdevs[channel])
> > +             return 0;
> > +
> > +     ddata = rdev_get_drvdata(rdevs[channel]);
> > +
> > +     if (!ddata || channel >= ddata->num_switches)
>
> How would ddata ever be NULL ? I don't see that check
> elsewhere in the driver.
>
Will remove the NULL check.

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
>
> The common approach in hwmon drivers is to define a default
> (typically 1 mOhm) if the value is not set, to let the user
> configure it from userspace with the sensors configuration file.
>
> Checking ... Never mind. I guess the problem here is that while the
> shunt-resistor-micro-ohms property is mandatory, the dt author can
> explicitly configure a shunt resistor value of 0 and that is accepted
> by the rest of the code. I am not sure if that makes sense, but ...
> With this in mind, keep as is, but please add a note explaining that
> this can happen.
Ack

Regards,
Naresh
>
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
> > @@ -442,6 +566,11 @@ static int max597x_regulator_probe(struct platform_device *pdev)
> >       if (!max597x)
> >               return -ENOMEM;
> >
> > +     rdevs = devm_kcalloc(&i2c->dev, MAX5970_NUM_SWITCHES, sizeof(struct regulator_dev *),
> > +                          GFP_KERNEL);
> > +     if (!rdevs)
> > +             return -ENOMEM;
> > +
> >       i2c_set_clientdata(i2c, max597x);
> >
> >       if (of_device_is_compatible(i2c->dev.of_node, "maxim,max5978"))
> > @@ -451,7 +580,6 @@ static int max597x_regulator_probe(struct platform_device *pdev)
> >       else
> >               return -ENODEV;
> >
> > -     i2c_set_clientdata(i2c, max597x);
> >       num_switches = max597x->num_switches;
> >
> >       for (i = 0; i < num_switches; i++) {
> > @@ -485,6 +613,15 @@ static int max597x_regulator_probe(struct platform_device *pdev)
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
> >
> > base-commit: f9a1d31874c383f58bb4f89bfe79b764682cd026
> > --
> > 2.41.0
> >
