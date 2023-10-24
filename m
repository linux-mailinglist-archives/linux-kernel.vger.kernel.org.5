Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139DC7D4E93
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjJXLKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJXLKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:10:05 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E89A109
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:10:02 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6bbfb8f7ac4so913500b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698145802; x=1698750602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RE1wsH4r/PT9CdvJUxnqs/kAns7JcqtTbkS2nbmYIlM=;
        b=Y4YmxgKCt2HVyW75f+YrxDHiakcKG9Q6nBVxQLg01RAvOdk5mOPUg+E2S3OTsW243a
         75uUBbWtaBDapss81wUA6151bfQbnrmz0oelW7E07XY/ISjF9Q//ftrDEXZ2Mn9jyXNt
         TVofZ6Njca9DghJYbwzPQF+56hG1kIrlMKRyj4ctIuQ4ZhzAftOCHOYjkFD+B7Ga1QwC
         EHVI/oYvJ0uhQLav4nLxOn9cjT0EDt92Q0S5MmYLMJSlxJcDQS3SC5qWZjUh4Pvv/1qm
         Yx9leHD7TZmIoO549gWkllEHbSkYDTdI9ALw1SKp7jOBmLP/MyvWv6gVJ2KlRsKdnfI5
         i94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698145802; x=1698750602;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RE1wsH4r/PT9CdvJUxnqs/kAns7JcqtTbkS2nbmYIlM=;
        b=VpkdIXkGjsZzotPCcakeEOMJbOQpixKv15k4EKE12wwoNVQZFvWj0lRUzOxJoa2Rx2
         HTC6A+uHJXLo2Q5be5OO6hVa2xZsJhRw7VXtZjEJ9ussqC+Vv/fdJoIVJwJKdAOMEMzO
         +U0BQVqoqPpJCFjDTK02Cx6gyZukCOXaPVbUplLtWAlGevVpcym2/+NeTKFWWp/Sg9x2
         qFTwNCKCXIsjrSBqhp/5NZlFzlqSx4QzlJOAUVe3u6eDRQsUk0AKO3lQGh8vbUh2JIWy
         7z2ibKUEm/Y4UlFbMDnud+I20BJ1euMYXcAOSwNr/e4XzW4DBTRHQSc3U7tp6P4iJ/cI
         aw/A==
X-Gm-Message-State: AOJu0YwPNVraUTpb+ifArbx0A8yAR7CNcs0CCS/5Lmpb3KIvfcNotRw2
        VOq5HKe1hZGu4mEiuYgIhLhHGQ==
X-Google-Smtp-Source: AGHT+IEX6WuqA5vIkcaujPmdybMRkAiT+hemmNEfBNRefkfhx9JKBoVLMwM5Lt2yToWxR/gWgGlVNg==
X-Received: by 2002:a05:6a21:8cc5:b0:17b:170c:2d11 with SMTP id ta5-20020a056a218cc500b0017b170c2d11mr11510054pzb.6.1698145801901;
        Tue, 24 Oct 2023 04:10:01 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:7c15:610f:1205:f10c])
        by smtp.gmail.com with ESMTPSA id f125-20020a625183000000b0065a1b05193asm7801805pfb.185.2023.10.24.04.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 04:10:01 -0700 (PDT)
Date:   Tue, 24 Oct 2023 20:09:52 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, sudeep.holla@arm.com,
        cristian.marussi@arm.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Oleksii_Moisieiev@epam.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [RFC v2 5/5] dt-bindings: gpio: Add bindings for pinctrl based
 generic gpio driver
Message-ID: <ZTemAK/jBtv9b5xP@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, sudeep.holla@arm.com,
        cristian.marussi@arm.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Oleksii_Moisieiev@epam.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20231005025843.508689-1-takahiro.akashi@linaro.org>
 <20231005025843.508689-6-takahiro.akashi@linaro.org>
 <20231006132346.GA3426353-robh@kernel.org>
 <CACRpkdaLsfSBEG-h9ZNT2_Lm8tW8AZO7tedDVNeuZoQAqSkyjw@mail.gmail.com>
 <ZSTgTC4cFFpofYAk@octopus>
 <CACRpkdYD6pkccYoy90AfzV3KT7oYkBPD2_4ZW-AXzT1eUVpchA@mail.gmail.com>
 <ZS3yK/f12Mxw9rXe@octopus>
 <CACRpkdarDrVkPmyDawhZ+H94S4F=dtDSDVuKegi-eNfQNDY3rg@mail.gmail.com>
 <ZTduWx7CH1ifI5Uc@octopus>
 <CACRpkdba=echR=rZYKVbROfaOp4mzjTQ9RphHFyzqSNgE1jZqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdba=echR=rZYKVbROfaOp4mzjTQ9RphHFyzqSNgE1jZqg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, Oct 24, 2023 at 11:40:00AM +0200, Linus Walleij wrote:
> Hi Takahiro,
> 
> On Tue, Oct 24, 2023 at 9:12???AM AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> 
> > > I think it is better of the pin controller just parse and add any
> > > subdevices (GPIO or other) using of_platform_default_populate()
> > > (just grep for this function and you will see how many device
> > > drivers use that).
> >
> > IICU, then, we will have to add a "compatible" to pinctrl node
> > to make of_platform_default_populate() work as expected. That is:
> >
> > scmi {
> >     ...
> >     protocol@19 {
> >         compatible = "simple-bus"; // <- added
> 
> Hm right, but you could also use
> of_platform_populate(np, NULL, NULL, dev);
> 
> Then the compatible match is of no concern.
> 
> Sorry for my lack of attention to details :/
> 
> If you want to restrict the population to a few select compatibles
> (maybe only "pin-control-gpio") then you can do
> that with
> 
> const struct of_device_id of_scmi_protocol_19_match_table[] = {
>         { .compatible = "pin-control-gpio", },
>         {}
> };
> of_platform_populate(np, of_scmi_protocol_19_match_table, NULL, dev);
> 
> > Is this what you meant?
> > In this case, however, "protocol@19" has a mixture of sub-nodes,
> > most are pinconf definitions which are the properties of the pin
> > controller, while "scmi_gpio" is a separate device.
> 
> That looks good to me, it makes sense to have the GPIO as a subnode
> here and mandate it with a compatible to match.
> 
> > The code will work, but is it sane from DT binding pov?
> 
> Let's let the DT people jump in on that.
> 
> > > Instead just call gpiochip_add_pin_range() directly in Linux
> > > after adding the pin controller and gpio_chip.
> > > C.f. drivers/pinctrl/pinctrl-sx150x.c for an example of a driver
> > > doing this. In this case the SX150X is hot-plugged (on a slow
> > > bus) so it needs to figure out all ranges at runtime anyway.
> >
> > Are you suggesting implementing a custom function for parsing "gpio-ranges"
> > and calling it in pin_control_gpio_probe() instead of a generic helper?
> 
> The generic helper will always be attempted but if there are
> no ranges in the device tree, it will just continue without adding
> any ranges. I suggest putting *no* ranges into the device tree.
> 
> > Or do you want to always map all the pin controller's pins to
> > gpio pins as sx150x does?
> 
> I think since the SCMI firmware knows about the available line
> and pins etc, it makes sense that the driver comes up with the
> applicable ranges on its own (derived from the information from
> the SCMI firmware) and add them, instead of trying to put that
> information into the device tree at all. Just omit it, and make your
> own ranges, and add them in the Linux driver with
> gpiochip_add_pin_range() without involving DT at all when defining
> the ranges.

As far as I understand, there is only one way for SCMI gpio driver
to know which pins are actually GPIO pins; Calling PINCNTRL_CONFIG_GET
command with "Input-mode" or "Output-mode" configuration type
against *every* pin-controller's pins.
(Here I assume that the command would fail with INVALID_PARAMETERS or
NOT_SUPPORTED if configuring the given pin as a GPIO input or output
is not possible. But the specification seems to be a bit ambiguous.)

It means that, if SCMI firmware has 100 pinctrl pins, the driver needs
to call the command 200 times in order to get the answer.

It is possible but I believe that it is clunky and painful for the driver
initialization.
I'd like to see explicit "gpio-ranges" property in a device tree.

Thanks,
-Takahiro Akashi



> I'm sorry if I'm unclear sometimes.
> 
> Yours,
> Linus Walleij
