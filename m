Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DD97EE425
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjKPPX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjKPPX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:23:26 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D4D126
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:23:22 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d9fe0a598d8so865928276.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700148201; x=1700753001; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jSgupIeANP5tueuGjabzmCgxHpd7wjSVIIaOyj586g8=;
        b=C6VVoZL3OWgeErug8AwuxL9UDuqDvihZKZSFEukscobEg+Jy7z9qHAIMnGHEKsMOhi
         /l687KOFpoU5g/nTN3KrUoivHflhzZ/xTW/KemdUSb4YRmUUcoi0vHB3hZLMx0dEU486
         EOBMeNng9Ox8ppMC98cTmuHA7eodcpyGDMsndxK9qDqGUUdaCWaoXMbwWXfkKHxmP/ME
         MWn1+M144VXf3Coe8rdrwkL5+TGrEEfyvkbM8nTAYSkC0EMmOc2vL1cG/hIaCIHLeRsI
         Xt6OUo4XlCq6pn2ne/r+COX9QGSZEdmu/jlKsewnaOw16WbkmU/RxdtHYT34hEY+WLBv
         pe1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700148201; x=1700753001;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jSgupIeANP5tueuGjabzmCgxHpd7wjSVIIaOyj586g8=;
        b=TONn5aTb7dxy1jNmj2Al/oif/wzWz6lkULq1D/qyjr/c9nGfpEL0aB6lpzyPrlcmNa
         maoN7OFGLSRylWVP+SwqS+lXxEYUXH2DLY7Q5Sp2w9jmjIawm15pmtSmyL0brTvkh09Q
         YnBwGspUFMzBm8hvu+4a/i9T06jSjURw6u2Vm0BSUp1ac/6i6SxVqlrMsYyJL82I27V3
         8moYvWF4bzBEf+zqHL78Nhl1YNWdrJDcJZN0RBwptczCJOLGmezNJyto+z9n0q7BC680
         ork1MHylJ0Lobr1J+YxMEYtvfNZwXmmGu6zzerQcj/BkcjxwksaMbcWtnpP1XNQlyv0a
         jn5A==
X-Gm-Message-State: AOJu0YxPUg5WuXRLk8fW5gg7FjbvQ1JHtr2dh/UJ/ZjTIpHHsZjhp8DW
        Qod3V6I+Kdzl/GHBdDsL6Nck2HdwcaBkTAL4C63jEA==
X-Google-Smtp-Source: AGHT+IEIVa1NI6XgtzOUgIl2iL6jHoUviE3ArBPvKGR5eaRoUTXtbiZhuEKkizVPrrGfKMTq8p/Vw7/vzby5tkqKXs8=
X-Received: by 2002:a05:6902:188d:b0:d9a:49bb:3d1d with SMTP id
 cj13-20020a056902188d00b00d9a49bb3d1dmr18422215ybb.3.1700148201540; Thu, 16
 Nov 2023 07:23:21 -0800 (PST)
MIME-Version: 1.0
References: <20231114150130.497915-1-sui.jingfeng@linux.dev>
 <20231114150130.497915-9-sui.jingfeng@linux.dev> <CAA8EJprQq3aDhzE+yKGZ2-nsuHWcptzMvApsyOi9D63PgeiZ3w@mail.gmail.com>
 <1b59d647-c345-4260-b07b-22abb70ae17a@linux.dev> <CAA8EJppY2+ymX0kLY+cuR=SV1Po2J24r=NQecmb3ZhSE9NHG7Q@mail.gmail.com>
 <7b85d057-3d66-435a-a657-dd69067b6bef@linux.dev> <b9eacd91-8d6f-4265-931e-bc31cadd54d4@linux.dev>
In-Reply-To: <b9eacd91-8d6f-4265-931e-bc31cadd54d4@linux.dev>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 16 Nov 2023 17:23:09 +0200
Message-ID: <CAA8EJpo1KhzTpaSqjbOuQvNKw4WGaqrtNBtNfdNLn28eZVgwhw@mail.gmail.com>
Subject: Re: [PATCH 8/8] drm/bridge: it66121: Allow link this driver as a lib
To:     Sui Jingfeng <sui.jingfeng@linux.dev>
Cc:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 at 14:08, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
>
> On 2023/11/16 19:53, Sui Jingfeng wrote:
> > Hi,
> >
> >
> > On 2023/11/16 19:29, Dmitry Baryshkov wrote:
> >> On Thu, 16 Nov 2023 at 13:18, Sui Jingfeng <sui.jingfeng@linux.dev>
> >> wrote:
> >>> Hi,
> >>>
> >>>
> >>> On 2023/11/15 00:30, Dmitry Baryshkov wrote:
> >>>>> +
> >>>>> +               ctx->connector = connector;
> >>>>> +       }
> >>>>>
> >>>>>           if (ctx->info->id == ID_IT66121) {
> >>>>>                   ret = regmap_write_bits(ctx->regmap,
> >>>>> IT66121_CLK_BANK_REG,
> >>>>> @@ -1632,16 +1651,13 @@ static const char * const
> >>>>> it66121_supplies[] = {
> >>>>>           "vcn33", "vcn18", "vrf12"
> >>>>>    };
> >>>>>
> >>>>> -static int it66121_probe(struct i2c_client *client)
> >>>>> +int it66121_create_bridge(struct i2c_client *client, bool
> >>>>> of_support,
> >>>>> +                         bool hpd_support, bool audio_support,
> >>>>> +                         struct drm_bridge **bridge)
> >>>>>    {
> >>>>> +       struct device *dev = &client->dev;
> >>>>>           int ret;
> >>>>>           struct it66121_ctx *ctx;
> >>>>> -       struct device *dev = &client->dev;
> >>>>> -
> >>>>> -       if (!i2c_check_functionality(client->adapter,
> >>>>> I2C_FUNC_I2C)) {
> >>>>> -               dev_err(dev, "I2C check functionality failed.\n");
> >>>>> -               return -ENXIO;
> >>>>> -       }
> >>>>>
> >>>>>           ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> >>>>>           if (!ctx)
> >>>>> @@ -1649,24 +1665,19 @@ static int it66121_probe(struct i2c_client
> >>>>> *client)
> >>>>>
> >>>>>           ctx->dev = dev;
> >>>>>           ctx->client = client;
> >>>>> -       ctx->info = i2c_get_match_data(client);
> >>>>> -
> >>>>> -       ret = it66121_of_read_bus_width(dev, &ctx->bus_width);
> >>>>> -       if (ret)
> >>>>> -               return ret;
> >>>>> -
> >>>>> -       ret = it66121_of_get_next_bridge(dev, &ctx->next_bridge);
> >>>>> -       if (ret)
> >>>>> -               return ret;
> >>>>> -
> >>>>> -       i2c_set_clientdata(client, ctx);
> >>>>>           mutex_init(&ctx->lock);
> >>>>>
> >>>>> -       ret = devm_regulator_bulk_get_enable(dev,
> >>>>> ARRAY_SIZE(it66121_supplies),
> >>>>> - it66121_supplies);
> >>>>> -       if (ret) {
> >>>>> -               dev_err(dev, "Failed to enable power supplies\n");
> >>>>> -               return ret;
> >>>>> +       if (of_support) {
> >>>>> +               ret = it66121_of_read_bus_width(dev,
> >>>>> &ctx->bus_width);
> >>>>> +               if (ret)
> >>>>> +                       return ret;
> >>>>> +
> >>>>> +               ret = it66121_of_get_next_bridge(dev,
> >>>>> &ctx->next_bridge);
> >>>>> +               if (ret)
> >>>>> +                       return ret;
> >>>>> +       } else {
> >>>>> +               ctx->bus_width = 24;
> >>>>> +               ctx->next_bridge = NULL;
> >>>>>           }
> >>>> A better alternative would be to turn OF calls into fwnode calls and
> >>>> to populate the fwnode properties. See
> >>>> drivers/platform/x86/intel/chtwc_int33fe.c for example.
> >>>
> >>> Honestly, I don't want to leave any scratch(breadcrumbs).
> >>> I'm worries about that turn OF calls into fwnode calls will leave
> >>> something unwanted.
> >>>
> >>> Because I am not sure if fwnode calls will make sense in the DT
> >>> world, while my patch
> >>> *still* be useful in the DT world.
> >> fwnode calls work for both DT and non-DT cases. In the DT case they
> >> work with DT nodes and properties. In the non-DT case, they work with
> >> manually populated properties.
> >>
> >>> Because the newly introduced it66121_create_bridge()
> >>> function is a core. I think It's better leave this task to a more
> >>> advance programmer.
> >>> if there have use case. It can be introduced at a latter time,
> >>> probably parallel with
> >>> the DT.
> >>>
> >>> I think DT and/or ACPI is best for integrated devices, but it66121
> >>> display bridges is
> >>> a i2c slave device. Personally, I think slave device shouldn't be
> >>> standalone. I'm more
> >>> prefer to turn this driver to support hot-plug, even remove the
> >>> device on the run time
> >>> freely when detach and allow reattach. Like the I2C EEPROM device in
> >>> the monitor (which
> >>> contains the EDID, with I2C slave address 0x50). The I2C EEPROM
> >>> device *also* don't has
> >>> a corresponding struct device representation in linux kernel.
> >> It has. See i2c_client::dev.
> >
> > No, what I mean is that there don't have a device driver for
> > monitor(display) hardware entity.
> > And the drm_do_probe_ddc_edid() is the static linked driver, which is
> > similar with the idea
> > this series want to express.

Because the monitor is not a part of the display pipeline.

> >
> >
> >>> so I still think It is best to make this drivers functional as a
> >>> static lib, but I want
> >>> to hear you to say more. Why it would be a *better* alternative to
> >>> turn OF calls into
> >>> fwnode calls? what are the potential benefits?
> >> Because then you can populate device properties from your root device.
> >> Because it allows the platform to specify the bus width instead of
> >> hardcoding 24 bits (which might work in your case, but might not be
> >> applicable to another user next week).
> >
> >
> > No, this problem can be easily solved. Simply add another argument.
> >
> > ```
> >
> > int it66121_create_bridge(struct i2c_client *client, bool of_support,
> >                           bool hpd_support, bool audio_support, u32
> > bus_width,
> >                           struct drm_bridge **bridge);
> > ```
> >
> >
> >> Anyway, even without fwnode, I'd strongly suggest you to drop the
> >> it66121_create_bridge() as it is now and start by populating the i2c
> >> bus from your root device.
> >
> > This will force all non-DT users to add the similar code patter at the
> > display controller side,
> > which is another kind of duplication. The monitor is also as I2C slave
> > device, can be abstract
> > as a identify drm bridges in theory, I guess.
> >
>
> 'identify' -> 'identity'
>
>
> >
> >> Then you will need some way (fwnode?) to
> >> discover the bridge chain. And at the last point you will get into the
> >> device data and/or properties business.
> >>
> > No, leave that chance to a more better programmer and forgive me please,
> > too difficult, I'm afraid of not able to solve. Thanks a lot for the
> > trust!

From my point of view: no.

-- 
With best wishes
Dmitry
