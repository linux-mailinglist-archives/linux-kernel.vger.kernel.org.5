Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050807EB4C4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjKNQac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjKNQab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:30:31 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B106F9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:30:27 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5afabb23900so68441117b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699979427; x=1700584227; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MQ/Qqv68EhxO9YJhGzex04om4yQqLVpqd8gbiKzc5hg=;
        b=P9Z4MDiYSyuaknTi4y/arZ5nhjjOKru7Xi/tekwPgD1c71t8UhZfC9zEVFbfj7Fnrh
         LEfT94KYRddJHPzTKan1dCVuPInz3pNWPwLen5vIrAohM7VNyG7uGCYm4eRHxEUpBC8c
         xjog7pOiPON5TekczQNBAcP5A0RrWLdePxuqjO7r/gHndm9iaw7p+9NIwIlWCDfWFHo5
         OT/nozKuwKcsTunWCMRs6OosZq9W37g10xTUGp+OxvQi6jpak7PzRDoGagKjE+hEdNOF
         UBUd6+nrR3eyWIK7zP+JwxSaHkKF96Z3PkbgnuWU9h6H1xmY5j+LphvMKCBqRO5xLnBD
         3OqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699979427; x=1700584227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MQ/Qqv68EhxO9YJhGzex04om4yQqLVpqd8gbiKzc5hg=;
        b=dipEEPWdM6Y2PkeeXLggc+Wptb6JNobqiC4yGSV9Va6E20O2z891zOPDym1E8wpeGK
         CYYMot2IoryG89okjt9TzJP1AGN5TeOpZJlysJ6NR2UE0eAdgYI39evQV22p70ARByAr
         QAThMQv9n5gLYWxdUzbnk+eMgeBWixA3Eymwdfw8DlCuYqZTcSJunL02RUYGzjU7K1XW
         7WQFofs5sHc1vqcQhI4XXy7T+8ozsDG+BZWhxfCtVCGonyKCjCRxpCwX/MPP/vz084ow
         fLZiZHaX4kd1Arwjf4F/p/b4uGU7cDqwUVFc8VDm1lm/7JY3odHKIUM6ZALZVgWJDSHy
         w9+A==
X-Gm-Message-State: AOJu0YxTGXRRzKNLl0m2Z3CnZsBUx9BivX7vxZHOidW0pRy437JL1CIR
        UVolwg3VQbxowX8OkBtmo73Tw/oMvr+E1pgCK2Rm0wtSZ9wbdH9OvrQ=
X-Google-Smtp-Source: AGHT+IENgot5xMLhykCCdSDLZHi47WdNP0wq0ekFI3RoGQO3hHfs+o00hv0VUIXTBHZ0MNcwRkbF9bhu/zjfecJUPq0=
X-Received: by 2002:a25:d2c3:0:b0:d9b:2477:b625 with SMTP id
 j186-20020a25d2c3000000b00d9b2477b625mr9145720ybg.54.1699979426688; Tue, 14
 Nov 2023 08:30:26 -0800 (PST)
MIME-Version: 1.0
References: <20231114150130.497915-1-sui.jingfeng@linux.dev> <20231114150130.497915-9-sui.jingfeng@linux.dev>
In-Reply-To: <20231114150130.497915-9-sui.jingfeng@linux.dev>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 14 Nov 2023 18:30:15 +0200
Message-ID: <CAA8EJprQq3aDhzE+yKGZ2-nsuHWcptzMvApsyOi9D63PgeiZ3w@mail.gmail.com>
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
> The it66121_create_bridge() and it66121_destroy_bridge() are added to
> export the core functionalities. Create a connector manually by using
> bridge connector helpers when link as a lib.
>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 134 +++++++++++++++++++--------
>  include/drm/bridge/ite-it66121.h     |  17 ++++
>  2 files changed, 113 insertions(+), 38 deletions(-)
>  create mode 100644 include/drm/bridge/ite-it66121.h
>
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index 8971414a2a60..f5968b679c5d 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -22,6 +22,7 @@
>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
> +#include <drm/drm_bridge_connector.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_modes.h>
>  #include <drm/drm_print.h>
> @@ -703,14 +704,32 @@ static int it66121_bridge_attach(struct drm_bridge *bridge,
>                                  enum drm_bridge_attach_flags flags)
>  {
>         struct it66121_ctx *ctx = bridge_to_it66121(bridge);
> +       struct drm_bridge *next_bridge = ctx->next_bridge;
> +       struct drm_encoder *encoder = bridge->encoder;
>         int ret;
>
> -       if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
> -               return -EINVAL;
> +       if (next_bridge) {
> +               if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
> +                       WARN_ON(1);

Why? At least use WARN() instead

> +                       flags |= DRM_BRIDGE_ATTACH_NO_CONNECTOR;
> +               }
> +               ret = drm_bridge_attach(encoder, next_bridge, bridge, flags);
> +               if (ret)
> +                       return ret;
> +       } else {
> +               struct drm_connector *connector;
>
> -       ret = drm_bridge_attach(bridge->encoder, ctx->next_bridge, bridge, flags);
> -       if (ret)
> -               return ret;
> +               if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
> +                       WARN_ON(1);

No. It is perfectly fine to create attach a bridge with no next_bridge
and with the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag.

> +
> +               connector = drm_bridge_connector_init(bridge->dev, encoder);
> +               if (IS_ERR(connector))
> +                       return PTR_ERR(connector);
> +
> +               drm_connector_attach_encoder(connector, encoder);

This goes into your device driver.

> +
> +               ctx->connector = connector;
> +       }
>
>         if (ctx->info->id == ID_IT66121) {
>                 ret = regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
> @@ -1632,16 +1651,13 @@ static const char * const it66121_supplies[] = {
>         "vcn33", "vcn18", "vrf12"
>  };
>
> -static int it66121_probe(struct i2c_client *client)
> +int it66121_create_bridge(struct i2c_client *client, bool of_support,
> +                         bool hpd_support, bool audio_support,
> +                         struct drm_bridge **bridge)
>  {
> +       struct device *dev = &client->dev;
>         int ret;
>         struct it66121_ctx *ctx;
> -       struct device *dev = &client->dev;
> -
> -       if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> -               dev_err(dev, "I2C check functionality failed.\n");
> -               return -ENXIO;
> -       }
>
>         ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
>         if (!ctx)
> @@ -1649,24 +1665,19 @@ static int it66121_probe(struct i2c_client *client)
>
>         ctx->dev = dev;
>         ctx->client = client;
> -       ctx->info = i2c_get_match_data(client);
> -
> -       ret = it66121_of_read_bus_width(dev, &ctx->bus_width);
> -       if (ret)
> -               return ret;
> -
> -       ret = it66121_of_get_next_bridge(dev, &ctx->next_bridge);
> -       if (ret)
> -               return ret;
> -
> -       i2c_set_clientdata(client, ctx);
>         mutex_init(&ctx->lock);
>
> -       ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(it66121_supplies),
> -                                            it66121_supplies);
> -       if (ret) {
> -               dev_err(dev, "Failed to enable power supplies\n");
> -               return ret;
> +       if (of_support) {
> +               ret = it66121_of_read_bus_width(dev, &ctx->bus_width);
> +               if (ret)
> +                       return ret;
> +
> +               ret = it66121_of_get_next_bridge(dev, &ctx->next_bridge);
> +               if (ret)
> +                       return ret;
> +       } else {
> +               ctx->bus_width = 24;
> +               ctx->next_bridge = NULL;
>         }

A better alternative would be to turn OF calls into fwnode calls and
to populate the fwnode properties. See
drivers/platform/x86/intel/chtwc_int33fe.c for example.

>
>         it66121_hw_reset(ctx);
> @@ -1679,33 +1690,80 @@ static int it66121_probe(struct i2c_client *client)
>         if (ret)
>                 return ret;
>
> -       if (ctx->vender_id != ctx->info->vid ||
> -           ctx->device_id != ctx->info->pid)
> +       ctx->info = it66121_get_match_data(ctx->vender_id, ctx->device_id);
> +       if (!ctx->info)
>                 return -ENODEV;
>
> -       ret = devm_request_threaded_irq(dev, client->irq, NULL, it66121_irq_threaded_handler,
> -                                       IRQF_ONESHOT, dev_name(dev), ctx);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to request irq %d:%d\n", client->irq, ret);
> -               return ret;
> +       if (hpd_support) {

Who handles HPD in your platform case?

> +               ret = devm_request_threaded_irq(dev, client->irq, NULL,
> +                                               it66121_irq_threaded_handler,
> +                                               IRQF_ONESHOT, dev_name(dev),
> +                                               ctx);
> +               if (ret < 0) {
> +                       dev_err(dev, "Failed to request irq: %d\n", ret);
> +                       return ret;
> +               }
>         }
>
>         it66121_bridge_init_base(&ctx->bridge, dev->of_node, true);
>
> -       it66121_audio_codec_init(ctx, dev);
> +       if (audio_support)
> +               it66121_audio_codec_init(ctx, dev);
> +
> +       *bridge = &ctx->bridge;
>
>         dev_info(dev, "IT66121 probed, chip id: 0x%x:0x%x, revision: %u\n",
>                  ctx->vender_id, ctx->device_id, ctx->revision);
>
>         return 0;
>  }
> +EXPORT_SYMBOL_GPL(it66121_create_bridge);
> +
> +static int it66121_probe(struct i2c_client *client)
> +{
> +       struct device *dev = &client->dev;
> +       struct it66121_ctx *ctx;
> +       struct drm_bridge *bridge;
> +       int ret;
> +
> +       if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +               dev_err(dev, "I2C check functionality failed.\n");
> +               return -ENXIO;
> +       }
> +
> +       ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(it66121_supplies),
> +                                            it66121_supplies);
> +       if (ret) {
> +               dev_err(dev, "Failed to enable power supplies\n");
> +               return ret;
> +       }
> +
> +       ret = it66121_create_bridge(client, true, true, true, &bridge);
> +       if (ret)
> +               return ret;
> +
> +       ctx = bridge_to_it66121(bridge);
> +
> +       i2c_set_clientdata(client, ctx);
> +
> +       return 0;
> +}
> +
> +void it66121_destroy_bridge(struct drm_bridge *bridge)
> +{
> +       struct it66121_ctx *ctx = bridge_to_it66121(bridge);
> +
> +       drm_bridge_remove(bridge);
> +
> +       mutex_destroy(&ctx->lock);
> +}
> +EXPORT_SYMBOL_GPL(it66121_destroy_bridge);
>
>  static void it66121_remove(struct i2c_client *client)
>  {
>         struct it66121_ctx *ctx = i2c_get_clientdata(client);
>
> -       drm_bridge_remove(&ctx->bridge);
> -       mutex_destroy(&ctx->lock);
> +       it66121_destroy_bridge(&ctx->bridge);
>  }
>
>  static const struct of_device_id it66121_dt_match[] = {
> diff --git a/include/drm/bridge/ite-it66121.h b/include/drm/bridge/ite-it66121.h
> new file mode 100644
> index 000000000000..e6753f695b7f
> --- /dev/null
> +++ b/include/drm/bridge/ite-it66121.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __ITE_IT66121_H__
> +#define __ITE_IT66121_H__
> +
> +#include <linux/i2c.h>
> +
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_device.h>
> +
> +int it66121_create_bridge(struct i2c_client *client, bool of_support,
> +                         bool hpd_support, bool audio_support,
> +                         struct drm_bridge **bridge);
> +
> +void it66121_destroy_bridge(struct drm_bridge *bridge);
> +
> +#endif
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
