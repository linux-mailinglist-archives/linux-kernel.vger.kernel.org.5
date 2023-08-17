Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4037577F609
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350565AbjHQMH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348499AbjHQMH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:07:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B396A2136;
        Thu, 17 Aug 2023 05:07:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 472006117E;
        Thu, 17 Aug 2023 12:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9EAC433C8;
        Thu, 17 Aug 2023 12:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692274043;
        bh=uDSbGNjKph8sVLzy0zWdifmHwwgdjRRXRkEP4MTyMKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iP6NkX51vzvUmGIuZhQLFyYaBb71gxpWrbmdJERwm3eIBdJ6V7Ee53It7lt8SOPy0
         gygtEBb5UKdjMayt7gfvvq+pwqhZJZi0GpwTKCpQWVVLuTEe6C4d5fHoUT2N6/0man
         cmqqWsJiKlZT4rOEBzeXhPZTh5Vl1us6lBBYYPY00E1L8C+DrGFmNBu8BgtnxQ7iUg
         3444MViMH9Gh3aIwTDuNnhpeHl6qCzmdfyfKip8D0H8oS6F3TBrpdtR5H4zxxupuQo
         tKFy3RPNv69ktQHrrvO9UtgT2ynrWOU8RVBIstyYKdvPERmS8MoW36TQmgkfp+4fHv
         IiXDLhWG3o+Pg==
Date:   Thu, 17 Aug 2023 13:07:18 +0100
From:   Lee Jones <lee@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= <git@apitzsch.eu>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 2/2] leds: add ktd202x driver
Message-ID: <20230817120718.GE986605@google.com>
References: <20230618-ktd202x-v1-0-fc182fefadd7@apitzsch.eu>
 <20230618-ktd202x-v1-2-fc182fefadd7@apitzsch.eu>
 <20230622181050.GY10378@google.com>
 <ba6aa842190956cb3e513d7fc0d90e6b97a07b99.camel@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba6aa842190956cb3e513d7fc0d90e6b97a07b99.camel@apitzsch.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Aug 2023, André wrote:

> Hi Lee Jones,
> 
> thanks for your feedback and sorry for the late response.
> 
> I'll try to address everything in the next version. But some things
> need clarification, see questions and comments below.
> 
> Am Donnerstag, dem 22.06.2023 um 19:10 +0100 schrieb Lee Jones:
> > On Sun, 18 Jun 2023, André Apitzsch wrote:
> > 
> > > This commit adds support for Kinetic KTD2026/7 RGB/White LED
> > > driver.
> > > 
> > > Signed-off-by: André Apitzsch <git@apitzsch.eu>
> > > ---
> > >  drivers/leds/rgb/Kconfig        |  12 +
> > >  drivers/leds/rgb/Makefile       |   1 +
> > >  drivers/leds/rgb/leds-ktd202x.c | 610
> > > ++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 623 insertions(+)
> > > 
> > > diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
> > > index 360c8679c6e2..fa422e7a3f74 100644
> > > --- a/drivers/leds/rgb/Kconfig
> > > +++ b/drivers/leds/rgb/Kconfig
> > > @@ -2,6 +2,18 @@
> > >  
> > >  if LEDS_CLASS_MULTICOLOR
> > >  
> > > +config LEDS_KTD202X
> > > +       tristate "LED support for KTD202x Chips"
> > > +       depends on I2C
> > > +       depends on OF
> > > +       select REGMAP_I2C
> > > +       help
> > > +         This option enables support for LEDs connected to the
> > > KTD202x
> > > +         chip.
> > 
> > More info please.
> > 
> > Who makes it?  Where can it be found?  What is it?  What does it do?
> > 
> > > +         To compile this driver as a module, choose M here: the
> > > module
> > > +         will be called leds-ktd202x.
> > > +
> > >  config LEDS_PWM_MULTICOLOR
> > >         tristate "PWM driven multi-color LED Support"
> > >         depends on PWM
> > > diff --git a/drivers/leds/rgb/Makefile b/drivers/leds/rgb/Makefile
> > > index 8c01daf63f61..5b4f22e077c0 100644
> > > --- a/drivers/leds/rgb/Makefile
> > > +++ b/drivers/leds/rgb/Makefile
> > > @@ -1,5 +1,6 @@
> > >  # SPDX-License-Identifier: GPL-2.0
> > >  
> > > +obj-$(CONFIG_LEDS_KTD202X)             += leds-ktd202x.o
> > >  obj-$(CONFIG_LEDS_PWM_MULTICOLOR)      += leds-pwm-multicolor.o
> > >  obj-$(CONFIG_LEDS_QCOM_LPG)            += leds-qcom-lpg.o
> > >  obj-$(CONFIG_LEDS_MT6370_RGB)          += leds-mt6370-rgb.o
> > > diff --git a/drivers/leds/rgb/leds-ktd202x.c
> > > b/drivers/leds/rgb/leds-ktd202x.c
> > > new file mode 100644
> > > index 000000000000..4f0cc558c797
> > > --- /dev/null
> > > +++ b/drivers/leds/rgb/leds-ktd202x.c
> > > @@ -0,0 +1,610 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +// Driver for Kinetic KTD2026/7 RGB/White LED driver
> > 
> > No C++ comments beyond the SPDX please.
> > 
> > Copyright?  Author?  Date?  Description.
> > 
> > > +#include <linux/i2c.h>
> > > +#include <linux/led-class-multicolor.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/regulator/consumer.h>
> > > +
> > > +#define KTD202X_MAX_LEDS 4
> > > +
> > > +#define KTD202X_REG_RESET_CONTROL      0x00
> > > +#define KTD202X_REG_FLASH_PERIOD       0x01
> > > +#define KTD202X_REG_PWM1_TIMER         0x02
> > > +#define KTD202X_REG_PWM2_TIMER         0x03
> > > +#define KTD202X_REG_CHANNEL_CTRL       0x04
> > > +#define KTD202X_REG_TRISE_FALL         0x05
> > > +#define KTD202X_REG_LED_IOUT(x)                (0x06 + (x))
> > > +
> > > +#define KTD202X_RSTR_RESET 0x07
> > > +
> > > +#define KTD202X_ENABLE_CTRL_WAKE 0x00 /* SCL & SDA High */
> > > +#define KTD202X_ENABLE_CTRL_SLEEP 0x08 /* SCL=High & SDA Toggling
> > > */
> > 
> > The formatting between the 2 comments above is making my OCD twitch.
> 
> Should I change anything here?

I guess just dropping the '=' would straighten things out.

> > > +#define KTD202X_CHANNEL_CTRL_MASK(x) (BIT(2 * (x)) | BIT(2 * (x) +
> > > 1))
> > > +#define KTD202X_CHANNEL_CTRL_OFF 0
> > > +#define KTD202X_CHANNEL_CTRL_ON(x) BIT(2 * (x))
> > > +#define KTD202X_CHANNEL_CTRL_PWM1(x) BIT(2 * (x) + 1)
> > > +#define KTD202X_CHANNEL_CTRL_PWM2(x) (BIT(2 * (x)) | BIT(2 * (x) +
> > > 1))
> > > +
> > > +#define KTD202X_TIME_MIN 256 /* ms */
> > 
> > Put MS in the name, then omit the comment.
> > 
> > > +#define KTD202X_TIME_STEP 128 /* ms */
> > > +#define KTD202X_ON_MAX 256
> > > +
> > > +static const struct reg_default ktd202x_reg_defaults[] = {
> > > +       { KTD202X_REG_RESET_CONTROL, 0x00 },
> > > +       { KTD202X_REG_FLASH_PERIOD, 0x00 },
> > > +       { KTD202X_REG_PWM1_TIMER, 0x01 },
> > > +       { KTD202X_REG_PWM2_TIMER, 0x01 },
> > > +       { KTD202X_REG_CHANNEL_CTRL, 0x00 },
> > > +       { KTD202X_REG_TRISE_FALL, 0x00 },
> > > +       { KTD202X_REG_LED_IOUT(0), 0x4f },
> > > +       { KTD202X_REG_LED_IOUT(1), 0x4f },
> > > +       { KTD202X_REG_LED_IOUT(2), 0x4f },
> > > +       { KTD202X_REG_LED_IOUT(3), 0x4f },
> > 
> > What do these magic numbers mean?
> 
> The default value (0x00) for KTD202X_REG_RESET_CONTROL seems difficult
> to describe in a variable name, as it changes multiple parts (Timer
> Slot Control, Enable Control and Rise/Fall Time Scaling;
> see https://www.kinet-ic.com/uploads/KTD2026-7-04h.pdf page 13)

We usually define each bit or selection of bits, then OR them.

[...]

-- 
Lee Jones [李琼斯]
