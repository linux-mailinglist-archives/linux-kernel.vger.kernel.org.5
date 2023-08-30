Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5ADC78E0A5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238841AbjH3U2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239611AbjH3U2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:28:25 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005203C3E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:16:12 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-26fc5a218daso60909a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1693422896; x=1694027696; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HGvmAnYANPHouVA+BdJfC0MXGgtwfV2UgiyZIn2PRsI=;
        b=gAP45YDSH4meXjfY6beNK9/rOWh+OfPuHr7VWqMK0fW9YBLdFuNb934zGrq3Qzg8Je
         MpUzEKgprkHUtmSfxcP2ceWao0AWWCipAbj5dKXBOFvbE8dxuY2fzLCPKflVHcd7YzTL
         r7MDiqLy+85drfLZenZH1wCpJVJzvY6HSXR/oEXSiKTIXwQyCgiGzgbrkUoWfFio6bJl
         RawTksh6u8zAc++I/J4RwbARS9b0aRR7+YlTCLVWEDeG0yBpE4Okhr1L6ETZqCk9yJA0
         fkiG76o9fgiZdp6ilvdZJBZ62AR2jGPcKsVP62TvY0oZDNc9eWCE2GDQNDuBIW1FwpZm
         zCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693422896; x=1694027696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGvmAnYANPHouVA+BdJfC0MXGgtwfV2UgiyZIn2PRsI=;
        b=ZD7aqE/e3RikMbjd4c8HnpoMRbesu1ODfmSxRCbSCj62d+xindH4n+ZXtLJYF+c8VV
         J0vhYXmVQ6088709s8ZBMcacxck76llb7dJM0Ds8fiIv0NHEnkpV4tTnP5W2l2zknbba
         CxWpQvp8FGmV4mrwNezQJjDIuFd15QZueVdfLd2BjwlY/u4QlDWz1jhe4L3LvEn5P/DY
         D42IUzptqqrQ+xwiwriS0FWWYqe6Gbt+jiQNvIqhEpsn5xuTR5SdYeBF9xSiQKyS9O9B
         AkRz57ZXZb4h3H9MG4m8yjq7Kkhji0THtKmHD4GkKPzjwPE2gnPAkXvxHFq99NI71TOK
         4ohg==
X-Gm-Message-State: AOJu0YzdzKVjnJ7wFCPcJuIhE4JwKGhnfw4FRVUqvSo+04jSf46tWNGv
        ruRixWNuWPP4vARNAxDkOJvQFvGrPRYEIzAii2u4y/60Gox7Qfl6GUl5mQ==
X-Google-Smtp-Source: AGHT+IFAARw8v1UFiFy5BY+Jwg3667PEy/UO72QjYBKljjXc7Hi5OYjANU6LOXgIEcoktmjI6GsRSRfpcd8/MvLOM3g=
X-Received: by 2002:a17:90b:e07:b0:263:f62b:3601 with SMTP id
 ge7-20020a17090b0e0700b00263f62b3601mr2848202pjb.10.1693422895963; Wed, 30
 Aug 2023 12:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230830111319.3882281-1-Naresh.Solanki@9elements.com> <0bfbbbb3-6144-fc9a-c8ab-423a8865591b@roeck-us.net>
In-Reply-To: <0bfbbbb3-6144-fc9a-c8ab-423a8865591b@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Thu, 31 Aug 2023 00:44:45 +0530
Message-ID: <CABqG17ig1VRJYqbrOvPKAYS8iUFwY9J3tYcgYGtnnXw+vrnoRA@mail.gmail.com>
Subject: Re: [PATCH] regulator (max5970): Add hwmon support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, zev@bewilderbeest.net,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


On Wed, 30 Aug 2023 at 21:26, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 8/30/23 04:13, Naresh Solanki wrote:
> > Utilize the integrated 10-bit ADC in Max5970/Max5978 to enable voltage
> > and current monitoring. This feature is seamlessly integrated through
> > the hwmon subsystem.
> >
> > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > ---
> >   drivers/regulator/max5970-regulator.c | 119 ++++++++++++++++++++++++++
> >   1 file changed, 119 insertions(+)
> >
> > diff --git a/drivers/regulator/max5970-regulator.c b/drivers/regulator/max5970-regulator.c
> > index b56a174cde3d..3a6f7c293526 100644
> > --- a/drivers/regulator/max5970-regulator.c
> > +++ b/drivers/regulator/max5970-regulator.c
> > @@ -10,6 +10,7 @@
> >   #include <linux/bitops.h>
> >   #include <linux/device.h>
> >   #include <linux/err.h>
> > +#include <linux/hwmon.h>
> >   #include <linux/module.h>
> >   #include <linux/io.h>
> >   #include <linux/of.h>
> > @@ -32,6 +33,116 @@ enum max597x_regulator_id {
> >       MAX597X_SW1,
> >   };
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
> > +     struct max5970_data *ddata = dev_get_drvdata(dev);
> > +     struct regmap *regmap = dev_get_regmap(dev->parent, NULL);
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
> > +                     *val = (*val * ddata->irng[channel]) >> 10;
> > +                     /* Convert the voltage meansurement across shunt resistor to current */
> > +                     *val = (*val * 1000) / ddata->shunt_micro_ohms[channel];
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
> > +                     *val = mul_u64_u32_shr(*val, ddata->mon_rng[channel], 10);
>
> Why do you use mul_u64_u32_shr() here but a direct shift above ?
There is possibility of overflow due to large value of ddata->mon_rng
>
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
> > +     struct max5970_data *ddata = (struct max5970_data *)data;
> > +
> > +     if (channel >= ddata->num_switches)
> > +             return 0;
> > +
> > +     switch (type) {
> > +     case hwmon_in:
> > +             switch (attr) {
> > +             case hwmon_in_input:
> > +                     return 0444;
>
>                 default:
>                         break;
Ack
>
> > +             }
> > +             break;
> > +     case hwmon_curr:
> > +             switch (attr) {
> > +             case hwmon_curr_input:
> > +                     /* Current measurement requires knowledge of the shunt resistor value. */
> > +                     if (ddata->shunt_micro_ohms[channel])
> > +                             return 0444;
>                 default:
>                         break;
Ack
>
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
>
> Your call, but the chip does support limit and status registers, so you
> could add reporting those as well since you are at it, possibly even including
> notifications.
Will consider separate set of patch for this.
>
> > +     NULL
> > +};
> > +
> > +static const struct hwmon_chip_info max5970_chip_info = {
> > +     .ops = &max5970_hwmon_ops,
> > +     .info = max5970_info,
> > +};
> > +
> >   static int max597x_uvp_ovp_check_mode(struct regulator_dev *rdev, int severity)
> >   {
> >       int ret, reg;
> > @@ -432,6 +543,7 @@ static int max597x_regulator_probe(struct platform_device *pdev)
> >       struct regulator_config config = { };
> >       struct regulator_dev *rdev;
> >       struct regulator_dev *rdevs[MAX5970_NUM_SWITCHES];
> > +     struct device *hwmon_dev;
> >       int num_switches;
> >       int ret, i;
> >
> > @@ -485,6 +597,13 @@ static int max597x_regulator_probe(struct platform_device *pdev)
> >               max597x->shunt_micro_ohms[i] = data->shunt_micro_ohms;
> >       }
> >
> > +     hwmon_dev = devm_hwmon_device_register_with_info(&i2c->dev, "max5970_hwmon", max597x,
> > +                                                      &max5970_chip_info, NULL);
>
> This makes the driver dependent on hwmon, so you either need a strict
>         depends on HWMON
> in Kconfig, or
>         depends on HWMON || HWMON=n
> and add #if IS_ENABLED(CONFIG_HWMON) as appropriate into the code.
Sure, will update accordingly. Thanks
>
>
> > +     if (IS_ERR(hwmon_dev)) {
> > +             return dev_err_probe(&i2c->dev, PTR_ERR(hwmon_dev), \
> > +                                  "Unable to register hwmon device\n");
> > +     }
> > +
> >       if (i2c->irq) {
> >               ret =
> >                   max597x_setup_irq(&i2c->dev, i2c->irq, rdevs, num_switches,
> >
> > base-commit: 35d0d2350d774fecf596cfb2fb050559fe5e1850
>
