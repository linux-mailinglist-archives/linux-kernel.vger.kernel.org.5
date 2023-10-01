Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D209F7B499A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 22:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbjJAUqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 16:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbjJAUqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 16:46:21 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09959FD
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 13:46:14 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id n3KNqyyr9615Bn3KNqlffC; Sun, 01 Oct 2023 22:46:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1696193173;
        bh=7At+tgghxTpDkCLTU9xfaQ4S4LQnyz/kWKTMko1AVgw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dnqhl6EIg76q1bgjLTHypcynJguKurd8tKbMZv8VaLdT/cFU7bo465sBi4rdHgVW8
         939S0FX+c+9AVPVenj9gxEzQriNqBBzLhLksCuxr7Rs/eBR9qI41E5rCC2ZGlxYx+X
         3YA1kU1vFi+RGyoUOPz+MTS8wbIUaXtFGvGwIzPZkfoOfj6lT1GOkNZ3j/Y4zWG/Uy
         1iuxKDfwnyLkqgs8fvmFfGQZCkua/8+rZWTbhHF7YqBV1fxoysGWyPAZy1TjL+QAfR
         iRw1cZ9n8+xk1VOnnJyy9HV0PNWpn4O7m7t4+5pzdnp2NBSULYbXQBiltY1cPOylha
         I4qlL0UM4Msjg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 01 Oct 2023 22:46:13 +0200
X-ME-IP: 86.243.2.178
Message-ID: <82e9cffc-472a-b725-1a12-de8aade67189@wanadoo.fr>
Date:   Sun, 1 Oct 2023 22:46:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 2/2] leds: add ktd202x driver
Content-Language: fr
To:     =?UTF-8?Q?Andr=c3=a9_Apitzsch?= <git@apitzsch.eu>
Cc:     conor+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        pavel@ucw.cz, phone-devel@vger.kernel.org, robh+dt@kernel.org,
        u.kleine-koenig@pengutronix.de,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20231001-ktd202x-v5-0-f544a1d0510d@apitzsch.eu>
 <20231001-ktd202x-v5-2-f544a1d0510d@apitzsch.eu>
 <a2380c93-42a5-9de5-3be9-9ebb50a965a3@wanadoo.fr>
 <250d0e681e7bbb750464338fb3a1a4a3199ce6ef.camel@apitzsch.eu>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <250d0e681e7bbb750464338fb3a1a4a3199ce6ef.camel@apitzsch.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/10/2023 à 18:56, André Apitzsch a écrit :
> Hi Christophe,
> 
> Am Sonntag, dem 01.10.2023 um 17:15 +0200 schrieb Christophe JAILLET:
>> Le 01/10/2023 à 15:52, André Apitzsch a écrit :
>>> This commit adds support for Kinetic KTD2026/7 RGB/White LED
>>> driver.
>>>
>>> Signed-off-by: André Apitzsch
>>> <git-AtRKszJ1oGPsq35pWSNszA@public.gmane.org>
>>
>> ...
>>
>>> +static int ktd202x_setup_led_rgb(struct ktd202x *chip, struct
>>> device_node *np,
>>> +                                struct ktd202x_led *led, struct
>>> led_init_data *init_data)
>>> +{
>>> +       struct led_classdev *cdev;
>>> +       struct device_node *child;
>>> +       struct mc_subled *info;
>>> +       int num_channels;
>>> +       int i = 0;
>>> +       u32 reg;
>>> +       int ret;
>>> +
>>> +       num_channels = of_get_available_child_count(np);
>>> +       if (!num_channels || num_channels > chip->num_leds)
>>> +               return -EINVAL;
>>> +
>>> +       info = devm_kcalloc(chip->dev, num_channels, sizeof(*info),
>>> GFP_KERNEL);
>>> +       if (!info)
>>> +               return -ENOMEM;
>>> +
>>> +       for_each_available_child_of_node(np, child) {
>>> +               u32 mono_color = 0;
>>
>> Un-needed init.
>> And, why is it defined here, while reg is defined out-side the loop?
> 
> I'll move it out-side the loop (without initialization).
> 
>>
>>> +
>>> +               ret = of_property_read_u32(child, "reg", &reg);
>>> +               if (ret != 0 || reg >= chip->num_leds) {
>>> +                       dev_err(chip->dev, "invalid 'reg' of
>>> %pOFn\n", np);
>>
>> Mossing of_node_put(np);?
> 
> It shouldn't be needed here if handled in the calling function, right?

How can the caller do this?

The goal of this of_node_put() is to release a reference taken by the 
for_each_available_child_of_node() loop, in case of early exit.

The caller can't know if np needs to be released or not. An error code 
is returned either if an error occurs within the for_each loop, or if 
devm_led_classdev_multicolor_register_ext() fails.

More over, in your case the caller is ktd202x_add_led().
 From there either ktd202x_setup_led_rgb() or ktd202x_setup_led_single() 
is called.

ktd202x_setup_led_single() does not take any reference to np.
But if it fails, of_node_put() would still be called.

> 
>>
>>> +                       return -EINVAL;
>>> +               }
>>> +
>>> +               ret = of_property_read_u32(child, "color",
>>> &mono_color);
>>> +               if (ret < 0 && ret != -EINVAL) {
>>> +                       dev_err(chip->dev, "failed to parse 'color'
>>> of %pOF\n", np);
>>
>> Mossing of_node_put(np);?
>>
>>> +                       return ret;
>>> +               }
>>> +
>>> +               info[i].color_index = mono_color;
>>> +               info[i].channel = reg;
>>> +               info[i].intensity = KTD202X_MAX_BRIGHTNESS;
>>> +               i++;
>>> +       }
>>> +
>>> +       led->mcdev.subled_info = info;
>>> +       led->mcdev.num_colors = num_channels;
>>> +
>>> +       cdev = &led->mcdev.led_cdev;
>>> +       cdev->brightness_set_blocking = ktd202x_brightness_mc_set;
>>> +       cdev->blink_set = ktd202x_blink_mc_set;
>>> +
>>> +       return devm_led_classdev_multicolor_register_ext(chip->dev,
>>> &led->mcdev, init_data);
>>> +}
>>> +
>>> +static int ktd202x_setup_led_single(struct ktd202x *chip, struct
>>> device_node *np,
>>> +                                   struct ktd202x_led *led, struct
>>> led_init_data *init_data)
>>> +{
>>> +       struct led_classdev *cdev;
>>> +       u32 reg;
>>> +       int ret;
>>> +
>>> +       ret = of_property_read_u32(np, "reg", &reg);
>>> +       if (ret != 0 || reg >= chip->num_leds) {
>>> +               dev_err(chip->dev, "invalid 'reg' of %pOFn\n", np);
>>> +               return -EINVAL;
>>> +       }
>>> +       led->index = reg;
>>> +
>>> +       cdev = &led->cdev;
>>> +       cdev->brightness_set_blocking =
>>> ktd202x_brightness_single_set;
>>> +       cdev->blink_set = ktd202x_blink_single_set;
>>> +
>>> +       return devm_led_classdev_register_ext(chip->dev, &led-
>>>> cdev, init_data);
>>> +}
>>> +
>>> +static int ktd202x_add_led(struct ktd202x *chip, struct
>>> device_node *np, unsigned int index)
>>> +{
>>> +       struct ktd202x_led *led = &chip->leds[index];
>>> +       struct led_init_data init_data = {};
>>> +       struct led_classdev *cdev;
>>> +       u32 color = 0;
>> Un-needed init.
>>
>>> +       int ret;
>>> +
>>> +       /* Color property is optional in single color case */
>>> +       ret = of_property_read_u32(np, "color", &color);
>>> +       if (ret < 0 && ret != -EINVAL) {
>>> +               dev_err(chip->dev, "failed to parse 'color' of
>>> %pOF\n", np);
>>> +               return ret;
>>> +       }
>>> +
>>> +       led->chip = chip;
>>> +       init_data.fwnode = of_fwnode_handle(np);
>>> +
>>> +       if (color == LED_COLOR_ID_RGB) {
>>> +               cdev = &led->mcdev.led_cdev;
>>> +               ret = ktd202x_setup_led_rgb(chip, np, led,
>>> &init_data);
>>> +       } else {
>>> +               cdev = &led->cdev;
>>> +               ret = ktd202x_setup_led_single(chip, np, led,
>>> &init_data);
>>> +       }
>>> +
>>> +       if (ret) {
>>> +               dev_err(chip->dev, "unable to register %s\n", cdev-
>>>> name);
>>> +               of_node_put(np);
>>
>> This is strange to have it here.
>> Why not above after "if (ret < 0 && ret != -EINVAL) {"?
>>
>> It would look much more natural to have it a few lines below, ... [1]
> 
> Good catch. I'll move of_node_put(np); to [1] and [2].

Why [2]?
It does not seem needed here.

of_get_available_child_count() does not keep any reference.

CJ

> 
>>
>>> +               return ret;
>>> +       }
>>> +
>>> +       cdev->max_brightness = KTD202X_MAX_BRIGHTNESS;
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int ktd202x_probe_dt(struct ktd202x *chip)
>>> +{
>>> +       struct device_node *np = dev_of_node(chip->dev), *child;
>>> +       unsigned int i;
>>> +       int count, ret;
>>> +
>>> +       chip->num_leds = (int)(unsigned
>>> long)of_device_get_match_data(chip->dev);
>>> +
>>> +       count = of_get_available_child_count(np);
>>> +       if (!count || count > chip->num_leds)
> 
> [2].
> 
>>> +               return -EINVAL;
>>> +
>>> +       regmap_write(chip->regmap, KTD202X_REG_RESET_CONTROL,
>>> KTD202X_RSTR_RESET);
>>> +
>>> +       /* Allow the device to execute the complete reset */
>>> +       usleep_range(200, 300);
>>> +
>>> +       i = 0;
>>> +       for_each_available_child_of_node(np, child) {
>>> +               ret = ktd202x_add_led(chip, child, i);
>>> +               if (ret)
>>
>> [1] ... here.
>>
>> Otherwise, it is likely that, thanks to a static checker, an
>> additionnal
>> of_node_put() will be added on early exit of the loop.
>>
>> CJ
>>
>>> +                       return ret;
>>> +               i++;
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>
>> ...
>>
> 
> Best regards,
> André
> 

