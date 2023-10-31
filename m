Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC5B7DC7B3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343829AbjJaHy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343816AbjJaHyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:54:25 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7209ADF;
        Tue, 31 Oct 2023 00:54:15 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a82c2eb50cso45584227b3.2;
        Tue, 31 Oct 2023 00:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698738854; x=1699343654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BxgfRq08akdKpYPvawQ/qmWvcE1o35b6GhP90H8S4Mw=;
        b=eZSxllZ0b7Eit4t59bPFoYnEC3CrOLynCaHi8tW93TTyfNrH4ZfBz0ezgc2Wmt751v
         45jeZ4kqhS1XdbhlbIuZUBVN0fSMPRKR4LR3ZnxzUBOLccqAY5XxynnV2YbYkbMac/jT
         rD1M65b6ZbcOFsyVxiCDpDvag2K914ckC86aspDdkOCPALUl0QDJOBRV7EzaVyF65idd
         4Xn0F/MWt/bCelRXYHxjJmqEvPpABykMeWxzibI3iNqO+tn7xPdgMnCQUmnyBfhpVy3u
         Q7tYLGMgCUUSVlS6K3yRaJaYq/jA1oaYpsDkfcaJfrEyyMc8YD6VmFuP64sitYlwHDOy
         4h8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698738854; x=1699343654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BxgfRq08akdKpYPvawQ/qmWvcE1o35b6GhP90H8S4Mw=;
        b=VRpwxnEsy4INdzi1YXz2Arrq0XmnWxQrJ87l9j/28B0av+fIEJSxFPkZFsxS0qbHFk
         8nszRxORbLJKS+HBJFFycWaubIKCE2MQHyhhl4zncqR6VpE1wAcfbPnOUhcbFKGjKvfR
         Zm8bRO8jfnmo276xOh5bI01ifGdbhAUT8tyIm6R0w71YzkVEtfTBbyPII6/EZ6Sd3F0G
         lfX+8CeShOtWSWvr2dH4IcLgq5e60pJkCNnwkE499ZDTTxUoIRYN8dZjgq+RC6s5bzk2
         boj3wFv+bsx6ct35JjvvV+eoMM1MITealcam7iFwDxvbjoezI+GfPY00X9pLQdpCBX00
         K2LA==
X-Gm-Message-State: AOJu0YxGt7uTyez5Fk13q5tDjBAAXW6guoNhdmxwtj4phTDNHNV7C5tN
        cwEgc+0IuCP0DQpioU+H/zYF58eQOE4KNGyPM6w=
X-Google-Smtp-Source: AGHT+IFrhKKyprJBm7nHBd4Rydqf0TOpZaL4oUpk4f4I19bsjnxQTcsk67zFEJtpBYSlcIgoeVc3brPEWGbY86zKMbg=
X-Received: by 2002:a81:ad62:0:b0:5a7:c01d:268 with SMTP id
 l34-20020a81ad62000000b005a7c01d0268mr10163703ywk.18.1698738854542; Tue, 31
 Oct 2023 00:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231030150119.342791-1-tmaimon77@gmail.com> <20231030150119.342791-2-tmaimon77@gmail.com>
 <e3de2c1f-3a05-4ffc-a50e-0b5522cf7740@roeck-us.net>
In-Reply-To: <e3de2c1f-3a05-4ffc-a50e-0b5522cf7740@roeck-us.net>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 31 Oct 2023 09:54:03 +0200
Message-ID: <CAP6Zq1hEFN==n3Um6MCvR-MqPERxwrm8Qd0DrKudA6L4xynDZA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] hwmon: npcm750-pwm-fan: Add NPCM8xx support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, avifishman70@gmail.com, tali.perry1@gmail.com,
        joel@jms.id.au, andrew@codeconstruct.com.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, j.neuschaefer@gmx.net,
        openbmc@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Thanks for your comments

On Mon, 30 Oct 2023 at 17:57, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 10/30/23 08:01, Tomer Maimon wrote:
> > Adding Pulse Width Modulation (PWM) and fan tacho NPCM8xx support to
> > NPCM PWM and fan tacho driver.
> > NPCM8xx uses a different number of PWM devices.
> >
> > As part of adding NPCM8XX support:
> > - Add NPCM8xx specific compatible string.
> > - Add data to handle architecture-specific PWM and fan tacho parameters.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >   drivers/hwmon/npcm750-pwm-fan.c | 34 +++++++++++++++++++++++++++++----
> >   1 file changed, 30 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
> > index 10ed3f4335d4..765b08fa0396 100644
> > --- a/drivers/hwmon/npcm750-pwm-fan.c
> > +++ b/drivers/hwmon/npcm750-pwm-fan.c
> > @@ -46,9 +46,9 @@
> >   #define NPCM7XX_PWM_CTRL_CH3_EN_BIT         BIT(16)
> >
> >   /* Define the maximum PWM channel number */
> > -#define NPCM7XX_PWM_MAX_CHN_NUM                      8
> > +#define NPCM7XX_PWM_MAX_CHN_NUM                      12
> >   #define NPCM7XX_PWM_MAX_CHN_NUM_IN_A_MODULE 4
> > -#define NPCM7XX_PWM_MAX_MODULES                 2
> > +#define NPCM7XX_PWM_MAX_MODULES                 3
> >
> >   /* Define the Counter Register, value = 100 for match 100% */
> >   #define NPCM7XX_PWM_COUNTER_DEFAULT_NUM             255
> > @@ -171,6 +171,10 @@
> >   #define FAN_PREPARE_TO_GET_FIRST_CAPTURE    0x01
> >   #define FAN_ENOUGH_SAMPLE                   0x02
> >
> > +struct npcm_hwmon_info {
> > +     u32 pwm_max_channel;
> > +};
> > +
> >   struct npcm7xx_fan_dev {
> >       u8 fan_st_flg;
> >       u8 fan_pls_per_rev;
> > @@ -204,6 +208,7 @@ struct npcm7xx_pwm_fan_data {
> >       struct timer_list fan_timer;
> >       struct npcm7xx_fan_dev fan_dev[NPCM7XX_FAN_MAX_CHN_NUM];
> >       struct npcm7xx_cooling_device *cdev[NPCM7XX_PWM_MAX_CHN_NUM];
> > +     const struct npcm_hwmon_info *info;
> >       u8 fan_select;
> >   };
> >
> > @@ -619,9 +624,13 @@ static umode_t npcm7xx_is_visible(const void *data,
> >                                 enum hwmon_sensor_types type,
> >                                 u32 attr, int channel)
> >   {
> > +     const struct npcm7xx_pwm_fan_data *hwmon_data = data;
> > +
> >       switch (type) {
> >       case hwmon_pwm:
> > -             return npcm7xx_pwm_is_visible(data, attr, channel);
> > +             if (channel < hwmon_data->info->pwm_max_channel)
> > +                     return npcm7xx_pwm_is_visible(data, attr, channel);
>
> I would have expected this check to be handled in npcm7xx_pwm_is_visible().
I will change the handle in npcm7xx_pwm_is_visible
>
> Guenter
>

Thanks,

Tomer
