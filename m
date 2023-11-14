Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3ED17EB470
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjKNQG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbjKNQGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:06:54 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7041B134
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:06:49 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a7afd45199so68381727b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699978009; x=1700582809; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Y7pSbHxAeptPMpbGtw1Nyu9tRet4KDB8iz60TRRUZY=;
        b=WYqzT3aIfO4Mw8K7GRPepvig5um5q6AQkaErX6B8STJcrS/s9PjLVtKkO60Ls+nSI9
         2NlsutBj6kRgQsfzQPXhBtJ0sB3tByn0XniR+/rhbh44p529C9I1Uxbc+sKkoR4TnC75
         mAx0hCMaHGSTc/RHt++2EREyJgssQNo6In/rRfDBUg7mcBUuDDHbcOR5WKF8Gw5jqXJe
         fH7xBc0hXl/MoCGnHV234ZvhQ/YL6gZvK/TPBVikz4PBxgylrcAP8yHtytB+R1oHLCgO
         4KUOUX9SzLw0RGuijRUmXcVUIAQ230V0tqwIpEThEhfN8l5Ku6BJTJXd8hfV9Fs4ZE/I
         fqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699978009; x=1700582809;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Y7pSbHxAeptPMpbGtw1Nyu9tRet4KDB8iz60TRRUZY=;
        b=LtrIU2rVoalRhWFwD+z4mAZCu3+hZawPN4oUytey+/mCnh3zZNDVnouWgYwLrtyPVs
         YlRvHMQ7+FhUD0QQYtHZ+YChy0bes0SvSzPrv9JIIDTENip9zs/Nr2E/XajN7K94Y300
         1GdUtmze5yzY+0nQq+Ffy4A+WUTmIzeQUb06rL0ODcoQU37Grk/66XJ1lfYnroLvpL7y
         ldWLq9XLmMiQXxB2z+mIEoCrRpOpjDz7Le+df93d8ETgEvsFW6CL7AYSvaWp4PX6sl6s
         O6Xvd0g3n+nBuINjApgduL2loVT8h//j+RCiJeD9XOMWUwPFbdkSyef+wAmIuOPUPeBE
         PqmA==
X-Gm-Message-State: AOJu0Yze29hwPR5nZKRwFSeaT8vmnVrcvrKsDWNWrRqw+YrP5KyFrcn8
        0X6OUDgcUGe5xiimGJqAhFHGYERy/N3fF11YJdAEIw==
X-Google-Smtp-Source: AGHT+IGKnxLbqMi0TPe5TBa4FgaIVmyvb8hFukBEwfaro0b+XieoQDT5QEOxlHajv9JhlfHFixRwD7rpQSLkUUFt1qM=
X-Received: by 2002:a81:49c2:0:b0:5b3:23f7:4254 with SMTP id
 w185-20020a8149c2000000b005b323f74254mr10635050ywa.25.1699978008914; Tue, 14
 Nov 2023 08:06:48 -0800 (PST)
MIME-Version: 1.0
References: <20231114150130.497915-1-sui.jingfeng@linux.dev> <20231114150130.497915-6-sui.jingfeng@linux.dev>
In-Reply-To: <20231114150130.497915-6-sui.jingfeng@linux.dev>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 14 Nov 2023 18:06:37 +0200
Message-ID: <CAA8EJprkDpjuHEi5R01p4XNvFBr94BvXhr7AZCLr6dC8Mk=yPw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 at 17:09, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> From: Sui Jingfeng <suijingfeng@loongson.cn>
>
> Read the required chip id data back by calling regmap_bulk_read() once,
> reduce the number of local variables needed in it66121_probe() function.
> And store its values into struct it66121_ctx, as it will be used latter.
>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 47 ++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index 7e473beefc79..f36d05331f25 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -313,6 +313,9 @@ struct it66121_ctx {
>                 bool auto_cts;
>         } audio;
>         const struct it66121_chip_info *info;
> +       u16 vender_id;
> +       u16 device_id;
> +       u8 revision;

There is no need to store them, they are not used by the driver anywhere.

>  };
>
>  static inline struct it66121_ctx *bridge_to_it66121(struct drm_bridge *bridge)
> @@ -399,6 +402,30 @@ static void it66121_hw_reset(struct it66121_ctx *ctx)
>         gpiod_set_value(ctx->gpio_reset, 0);
>  }
>
> +static int it66121_read_chip_id(struct it66121_ctx *ctx, bool verbose)
> +{
> +       u8 id[4];
> +       int ret;
> +
> +       ret = regmap_bulk_read(ctx->regmap, IT66121_VENDOR_ID0_REG, id, 4);
> +       if (ret < 0) {
> +               dev_err(ctx->dev, "Failed to read chip ID: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ctx->vender_id = (u16)id[1] << 8 | id[0];
> +       ctx->device_id = ((u16)(id[3] & IT66121_DEVICE_ID1_MASK) << 8 | id[2]);
> +       /* Revision is shared with DEVICE_ID1 */
> +       ctx->revision = FIELD_GET(IT66121_REVISION_MASK, id[3]);
> +
> +       if (verbose) {
> +               dev_info(ctx->dev, "Found ITE66121: 0x%x%x, revision: %u\n",
> +                        ctx->vender_id, ctx->device_id, ctx->revision);
> +       }
> +
> +       return 0;
> +}
> +
>  static inline int it66121_preamble_ddc(struct it66121_ctx *ctx)
>  {
>         return regmap_write(ctx->regmap, IT66121_MASTER_SEL_REG, IT66121_MASTER_SEL_HOST);
> @@ -1561,7 +1588,6 @@ static const char * const it66121_supplies[] = {
>
>  static int it66121_probe(struct i2c_client *client)
>  {
> -       u32 revision_id, vendor_ids[2] = { 0 }, device_ids[2] = { 0 };
>         int ret;
>         struct it66121_ctx *ctx;
>         struct device *dev = &client->dev;
> @@ -1603,19 +1629,13 @@ static int it66121_probe(struct i2c_client *client)
>         if (IS_ERR(ctx->regmap))
>                 return PTR_ERR(ctx->regmap);
>
> -       regmap_read(ctx->regmap, IT66121_VENDOR_ID0_REG, &vendor_ids[0]);
> -       regmap_read(ctx->regmap, IT66121_VENDOR_ID1_REG, &vendor_ids[1]);
> -       regmap_read(ctx->regmap, IT66121_DEVICE_ID0_REG, &device_ids[0]);
> -       regmap_read(ctx->regmap, IT66121_DEVICE_ID1_REG, &device_ids[1]);
> -
> -       /* Revision is shared with DEVICE_ID1 */
> -       revision_id = FIELD_GET(IT66121_REVISION_MASK, device_ids[1]);
> -       device_ids[1] &= IT66121_DEVICE_ID1_MASK;
> +       ret = it66121_read_chip_id(ctx, false);
> +       if (ret)
> +               return ret;
>
> -       if ((vendor_ids[1] << 8 | vendor_ids[0]) != ctx->info->vid ||
> -           (device_ids[1] << 8 | device_ids[0]) != ctx->info->pid) {
> +       if (ctx->vender_id != ctx->info->vid ||
> +           ctx->device_id != ctx->info->pid)
>                 return -ENODEV;
> -       }
>
>         ctx->bridge.funcs = &it66121_bridge_funcs;
>         ctx->bridge.of_node = dev->of_node;
> @@ -1633,7 +1653,8 @@ static int it66121_probe(struct i2c_client *client)
>
>         drm_bridge_add(&ctx->bridge);
>
> -       dev_info(dev, "IT66121 revision %d probed\n", revision_id);
> +       dev_info(dev, "IT66121 probed, chip id: 0x%x:0x%x, revision: %u\n",
> +                ctx->vender_id, ctx->device_id, ctx->revision);
>
>         return 0;
>  }
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
