Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6877EDFDA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjKPL3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjKPL3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:29:23 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7D4C2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:29:20 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a8628e54d4so5697017b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700134159; x=1700738959; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S5lTa43//cUFklB5+ZWKlvD2U+T55CUcIy8KREpqNZA=;
        b=dn4yo0yCL0T25fTp0gItWCkqazues1hxwSDEHm16+GIUr0zxG/689urb77ku0Jpdbx
         KlQ8Mk5mzGUi9aARyWms+0JkQessRdTOYD5EbwjGgx690QDRyBDOu0ArCUb/JuIrmsIY
         6Q7qzLapZzel12fDxFSjxbNYcvyn+kt+isQIJQyq924U/kRhMtRaB28aRSbojufmVQiQ
         Yi6REDRwL5eM3xJUy3mE5K3YOhTHHgHkQ98rlSqAMZC066EdeclOZi9MeVvUWoGqGcPd
         HOVNcplkU6/dzHYqv75ex9dRqLTZOEH2un+fFFHVMnQhzbx7NXa4Qek62bb9Z9K/5jOx
         /hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700134159; x=1700738959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S5lTa43//cUFklB5+ZWKlvD2U+T55CUcIy8KREpqNZA=;
        b=hebUFHvv6Ox+f7OnErjiXO9tNlWQ96c+WmPrYp1S5yIBUzFl73O34quwFhvas3yr5/
         rJaHh/KHnl/OQc7tht6rW4vue1ErShjAyiBTSxswIzY5Nt99lol+eBZZNdcMAGXaI90c
         F4qliEBfwq/nkKrTfe7dmS1UfLvx7xaLJS9lg4Nh4yLCThJByJHI4g0tYoOScPFLM7aO
         uLINomTXK96/4LoC68ULWk/JNqscfLtcsr4BnGi4xuDs8bv5fe4k9Lq5PoKmPvQ3aYKQ
         wnqnjYWPZS7vQHBqZ/p3Y5P2gx3WFx5fuxrV/Moy2Uzgd0Y2W1O99oy3BNM2LiEXc13g
         SzDA==
X-Gm-Message-State: AOJu0Yx+Z9m8FxBS58RceP+28nB5Ve4M+FyqEo4z3lab0JDppQ3HGd0H
        FCsnXT7OV29oEZkFkHpw81++g9eRSpaHXLqI8Lpy+w==
X-Google-Smtp-Source: AGHT+IGErFMqPkXK2Jal0NKNMlezVIeEoPnpOpWdwKLNkwKg18d8jKM1z5k/zbLBqUCnqanAX89cbCNB/R+NRbHjXwA=
X-Received: by 2002:a0d:d686:0:b0:570:2542:cc9b with SMTP id
 y128-20020a0dd686000000b005702542cc9bmr672414ywd.18.1700134159197; Thu, 16
 Nov 2023 03:29:19 -0800 (PST)
MIME-Version: 1.0
References: <20231114150130.497915-1-sui.jingfeng@linux.dev>
 <20231114150130.497915-9-sui.jingfeng@linux.dev> <CAA8EJprQq3aDhzE+yKGZ2-nsuHWcptzMvApsyOi9D63PgeiZ3w@mail.gmail.com>
 <1b59d647-c345-4260-b07b-22abb70ae17a@linux.dev>
In-Reply-To: <1b59d647-c345-4260-b07b-22abb70ae17a@linux.dev>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 16 Nov 2023 13:29:07 +0200
Message-ID: <CAA8EJppY2+ymX0kLY+cuR=SV1Po2J24r=NQecmb3ZhSE9NHG7Q@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 at 13:18, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> Hi,
>
>
> On 2023/11/15 00:30, Dmitry Baryshkov wrote:
> >> +
> >> +               ctx->connector = connector;
> >> +       }
> >>
> >>          if (ctx->info->id == ID_IT66121) {
> >>                  ret = regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
> >> @@ -1632,16 +1651,13 @@ static const char * const it66121_supplies[] = {
> >>          "vcn33", "vcn18", "vrf12"
> >>   };
> >>
> >> -static int it66121_probe(struct i2c_client *client)
> >> +int it66121_create_bridge(struct i2c_client *client, bool of_support,
> >> +                         bool hpd_support, bool audio_support,
> >> +                         struct drm_bridge **bridge)
> >>   {
> >> +       struct device *dev = &client->dev;
> >>          int ret;
> >>          struct it66121_ctx *ctx;
> >> -       struct device *dev = &client->dev;
> >> -
> >> -       if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> >> -               dev_err(dev, "I2C check functionality failed.\n");
> >> -               return -ENXIO;
> >> -       }
> >>
> >>          ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> >>          if (!ctx)
> >> @@ -1649,24 +1665,19 @@ static int it66121_probe(struct i2c_client *client)
> >>
> >>          ctx->dev = dev;
> >>          ctx->client = client;
> >> -       ctx->info = i2c_get_match_data(client);
> >> -
> >> -       ret = it66121_of_read_bus_width(dev, &ctx->bus_width);
> >> -       if (ret)
> >> -               return ret;
> >> -
> >> -       ret = it66121_of_get_next_bridge(dev, &ctx->next_bridge);
> >> -       if (ret)
> >> -               return ret;
> >> -
> >> -       i2c_set_clientdata(client, ctx);
> >>          mutex_init(&ctx->lock);
> >>
> >> -       ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(it66121_supplies),
> >> -                                            it66121_supplies);
> >> -       if (ret) {
> >> -               dev_err(dev, "Failed to enable power supplies\n");
> >> -               return ret;
> >> +       if (of_support) {
> >> +               ret = it66121_of_read_bus_width(dev, &ctx->bus_width);
> >> +               if (ret)
> >> +                       return ret;
> >> +
> >> +               ret = it66121_of_get_next_bridge(dev, &ctx->next_bridge);
> >> +               if (ret)
> >> +                       return ret;
> >> +       } else {
> >> +               ctx->bus_width = 24;
> >> +               ctx->next_bridge = NULL;
> >>          }
> > A better alternative would be to turn OF calls into fwnode calls and
> > to populate the fwnode properties. See
> > drivers/platform/x86/intel/chtwc_int33fe.c for example.
>
>
> Honestly, I don't want to leave any scratch(breadcrumbs).
> I'm worries about that turn OF calls into fwnode calls will leave something unwanted.
>
> Because I am not sure if fwnode calls will make sense in the DT world, while my patch
> *still* be useful in the DT world.

fwnode calls work for both DT and non-DT cases. In the DT case they
work with DT nodes and properties. In the non-DT case, they work with
manually populated properties.

> Because the newly introduced it66121_create_bridge()
> function is a core. I think It's better leave this task to a more advance programmer.
> if there have use case. It can be introduced at a latter time, probably parallel with
> the DT.
>
> I think DT and/or ACPI is best for integrated devices, but it66121 display bridges is
> a i2c slave device. Personally, I think slave device shouldn't be standalone. I'm more
> prefer to turn this driver to support hot-plug, even remove the device on the run time
> freely when detach and allow reattach. Like the I2C EEPROM device in the monitor (which
> contains the EDID, with I2C slave address 0x50). The I2C EEPROM device *also* don't has
> a corresponding struct device representation in linux kernel.

It has. See i2c_client::dev.

> so I still think It is best to make this drivers functional as a static lib, but I want
> to hear you to say more. Why it would be a *better* alternative to turn OF calls into
> fwnode calls? what are the potential benefits?

Because then you can populate device properties from your root device.
Because it allows the platform to specify the bus width instead of
hardcoding 24 bits (which might work in your case, but might not be
applicable to another user next week).

Anyway, even without fwnode, I'd strongly suggest you to drop the
it66121_create_bridge() as it is now and start by populating the i2c
bus from your root device. Then you will need some way (fwnode?) to
discover the bridge chain. And at the last point you will get into the
device data and/or properties business.

-- 
With best wishes
Dmitry
