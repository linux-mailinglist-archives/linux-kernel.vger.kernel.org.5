Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A197EE0F6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjKPNBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjKPNBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:01:12 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7357AD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:01:08 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-daf26d84100so728894276.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700139668; x=1700744468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U/PXn3eeHS/wDgkaVCJ1lURblbDajIyUVP8u15N5ho8=;
        b=VLKd1rzidkcUsMtXXbc6NGzD4ONpuL6C56G79STasElpsLMRvkAKwe9EUg3bjobfrB
         03Gq7E3qjIR9qUQYupahdhVec9a5uP5svoXRpiFNUcx+pTFmw79IWKhSmFICtpnS86sQ
         l1g+BW8sPinkgaXtSYGRW4Yyf8XaxgmtEwOGoJZOM/CKFsK7rzAfXDl10+SMfoqSo0NL
         wGxsslT5yKLOwtT6aqzQuTeSeOcrbhw3UKSCT+6LcD87burBuRlhrLsXkGrU2LeeojtX
         chT8RNfCcn7afwJOJJZordfsaxg/Ly35Z+YGWMXvPs3jE3SFH7JBOizd36OqHtRMLYXQ
         V8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700139668; x=1700744468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/PXn3eeHS/wDgkaVCJ1lURblbDajIyUVP8u15N5ho8=;
        b=lHK4spd6KXtEPMD/YNeRg4OLHcPk5t8unUSnSVIYm6Io4YcGfrWkkkMdfhKO6yJkTo
         HGAHfSFwZavoPJ9ejQXgm7b78cxWlkQph+5mW3AvdI9VRShDCnDIJpMAFGfk2zuku8hZ
         4vUxHh3aElcVU0IzEobOJrmBwviodbHT1lgJCk0G6cILMQz9N7avZc7cSH4Mi0kb7O6U
         eT6JeO4ty0nKUeghKHgAgD1LAaWO2qXDmyA39lpkUKaH5j7rVxm+rsfdGmLPXsiDX2uS
         GSC8qIc2wTJKcWC+Aa5fFBxjveBvUdkvc5QyQmCpjTITdT//oc4sQUZORedITKHPAZD1
         qNSw==
X-Gm-Message-State: AOJu0YzuNz3H1DlVp4IdmidziKveX4fRcS2ixzYhFwyD4Bw4dEWIazN8
        THZitMnzI1vzT9qmpfvEBsMk2XmS0+ghn0PEIh6vh/xuR8rGq5fF
X-Google-Smtp-Source: AGHT+IHfONo0tC8bD8ROdTl4bdeTY7eubSMkJY9OUE5F5W9FT94g22MhsyrH9cOpie8KGuRuNWgGErCZzgmq+5B3w0E=
X-Received: by 2002:a05:6902:1149:b0:da0:5346:f32b with SMTP id
 p9-20020a056902114900b00da05346f32bmr18485222ybu.53.1700139667560; Thu, 16
 Nov 2023 05:01:07 -0800 (PST)
MIME-Version: 1.0
References: <20231114150130.497915-1-sui.jingfeng@linux.dev>
 <20231114150130.497915-6-sui.jingfeng@linux.dev> <CAA8EJprkDpjuHEi5R01p4XNvFBr94BvXhr7AZCLr6dC8Mk=yPw@mail.gmail.com>
 <7602cd83-0e05-4e11-9bd1-10eb1d48a507@linux.dev>
In-Reply-To: <7602cd83-0e05-4e11-9bd1-10eb1d48a507@linux.dev>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 16 Nov 2023 15:00:55 +0200
Message-ID: <CAA8EJprFjdrQtegJd5HyzGYQaMawwQOhvkE=SNqsdsBCrtfDTA@mail.gmail.com>
Subject: Re: [PATCH 5/8] drm/bridge: it66121: Add a helper function to read
 chip id
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

On Thu, 16 Nov 2023 at 14:18, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> Hi,
>
>
> On 2023/11/15 00:06, Dmitry Baryshkov wrote:
> > On Tue, 14 Nov 2023 at 17:09, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
> >> From: Sui Jingfeng <suijingfeng@loongson.cn>
> >>
> >> Read the required chip id data back by calling regmap_bulk_read() once,
> >> reduce the number of local variables needed in it66121_probe() function.
> >> And store its values into struct it66121_ctx, as it will be used latter.
> >>
> >> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> >> ---
> >>   drivers/gpu/drm/bridge/ite-it66121.c | 47 ++++++++++++++++++++--------
> >>   1 file changed, 34 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> >> index 7e473beefc79..f36d05331f25 100644
> >> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> >> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> >> @@ -313,6 +313,9 @@ struct it66121_ctx {
> >>                  bool auto_cts;
> >>          } audio;
> >>          const struct it66121_chip_info *info;
> >> +       u16 vender_id;
> >> +       u16 device_id;
> >> +       u8 revision;
> > There is no need to store them, they are not used by the driver anywhere.
> >
> >>   };
> >>
> >>   static inline struct it66121_ctx *bridge_to_it66121(struct drm_bridge *bridge)
> >> @@ -399,6 +402,30 @@ static void it66121_hw_reset(struct it66121_ctx *ctx)
> >>          gpiod_set_value(ctx->gpio_reset, 0);
> >>   }
> >>
> >> +static int it66121_read_chip_id(struct it66121_ctx *ctx, bool verbose)
> >> +{
> >> +       u8 id[4];
> >> +       int ret;
> >> +
> >> +       ret = regmap_bulk_read(ctx->regmap, IT66121_VENDOR_ID0_REG, id, 4);
> >> +       if (ret < 0) {
> >> +               dev_err(ctx->dev, "Failed to read chip ID: %d\n", ret);
> >> +               return ret;
> >> +       }
> >> +
> >> +       ctx->vender_id = (u16)id[1] << 8 | id[0];
> >> +       ctx->device_id = ((u16)(id[3] & IT66121_DEVICE_ID1_MASK) << 8 | id[2]);
> >> +       /* Revision is shared with DEVICE_ID1 */
> >> +       ctx->revision = FIELD_GET(IT66121_REVISION_MASK, id[3]);
> >> +
> >> +       if (verbose) {
> >> +               dev_info(ctx->dev, "Found ITE66121: 0x%x%x, revision: %u\n",
> >> +                        ctx->vender_id, ctx->device_id, ctx->revision);
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>   static inline int it66121_preamble_ddc(struct it66121_ctx *ctx)
> >>   {
> >>          return regmap_write(ctx->regmap, IT66121_MASTER_SEL_REG, IT66121_MASTER_SEL_HOST);
> >> @@ -1561,7 +1588,6 @@ static const char * const it66121_supplies[] = {
> >>
> >>   static int it66121_probe(struct i2c_client *client)
> >>   {
> >> -       u32 revision_id, vendor_ids[2] = { 0 }, device_ids[2] = { 0 };
> >>          int ret;
> >>          struct it66121_ctx *ctx;
> >>          struct device *dev = &client->dev;
> >> @@ -1603,19 +1629,13 @@ static int it66121_probe(struct i2c_client *client)
> >>          if (IS_ERR(ctx->regmap))
> >>                  return PTR_ERR(ctx->regmap);
> >>
> >> -       regmap_read(ctx->regmap, IT66121_VENDOR_ID0_REG, &vendor_ids[0]);
> >> -       regmap_read(ctx->regmap, IT66121_VENDOR_ID1_REG, &vendor_ids[1]);
> >> -       regmap_read(ctx->regmap, IT66121_DEVICE_ID0_REG, &device_ids[0]);
> >> -       regmap_read(ctx->regmap, IT66121_DEVICE_ID1_REG, &device_ids[1]);
> >> -
> >> -       /* Revision is shared with DEVICE_ID1 */
> >> -       revision_id = FIELD_GET(IT66121_REVISION_MASK, device_ids[1]);
> >> -       device_ids[1] &= IT66121_DEVICE_ID1_MASK;
> >> +       ret = it66121_read_chip_id(ctx, false);
> >> +       if (ret)
> >> +               return ret;
> >>
> >> -       if ((vendor_ids[1] << 8 | vendor_ids[0]) != ctx->info->vid ||
> >> -           (device_ids[1] << 8 | device_ids[0]) != ctx->info->pid) {
> >> +       if (ctx->vender_id != ctx->info->vid ||
> >> +           ctx->device_id != ctx->info->pid)
>
> Q: There is no need to store them, they are not used by the driver anywhere.
>
> A: Here it is used, it is also used by the 0007-patch to get the entity(instance)-specific data.

And the patch 7 will be changed once you have proper i2c client struct
registered.

>
>
> Since it6610 was introduced, this is used for chip identifying.
> It can also be used with in debugfs context, to show who I am.

I'd say, there is little point in whoami debugfs files. Debugfs is for
the useful information.

>
>
> >>                  return -ENODEV;
> >> -       }
> >>
> >>          ctx->bridge.funcs = &it66121_bridge_funcs;
> >>          ctx->bridge.of_node = dev->of_node;
> >> @@ -1633,7 +1653,8 @@ static int it66121_probe(struct i2c_client *client)
> >>
> >>          drm_bridge_add(&ctx->bridge);
> >>
> >> -       dev_info(dev, "IT66121 revision %d probed\n", revision_id);
> >> +       dev_info(dev, "IT66121 probed, chip id: 0x%x:0x%x, revision: %u\n",
> >> +                ctx->vender_id, ctx->device_id, ctx->revision);
> >>
> >>          return 0;
> >>   }
> >> --
> >> 2.34.1
> >>
> >



-- 
With best wishes
Dmitry
