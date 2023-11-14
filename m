Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEE57EB481
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjKNQKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjKNQKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:10:15 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578B3FE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:10:12 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-dae0ab8ac3eso5768140276.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699978211; x=1700583011; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3NZgVf3mTInsrRVqgIvOMR7QMPkoKdJpiVaybWg4PMs=;
        b=nUwnhtxyi9rSLD3Kdc3IQre5JS0Iii6/KRKCCcIHEOzURpGeOqgeoGVxplBWWgwVJ9
         EQJStmVS9vj+vxyjmUn3wVyQrIvgZO3xKSSkKTmJhkbX18Coua1Xi/3nzRXgGf7eIDes
         lhVjY6UuP0vddmOWP3iFr/c5dCJm/jG73jEFHTCDySIP10aqVVCONrlEfB1IrkkyPwWe
         xVP6Ddn8+lcDj7G6XTHdC1hUEaBLOREGyzdxDkXEWbPdfcodL8anE94yB2+qZSfwurfu
         KWugWsc17mKDMmOdBiW50yCh2IZhGgYAvH2urVjbqyS23NMJTBnbipm3ZE1UAa7oq4e4
         +oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699978211; x=1700583011;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NZgVf3mTInsrRVqgIvOMR7QMPkoKdJpiVaybWg4PMs=;
        b=C8ihxANPscXHnvzTZHcZ6CXwcc1ufJlzUAaxFz4C7Lub0bXgDsK3ODei6qZPD05I02
         8LcySVAua/h++2sWqii+uz7pfJRimvIM1PQWk7Z1TsYVF6q7gbtBq7DcVdlOwCZKH7Qc
         zskPZ4aTFw8ewNxie3SdAuiS5Ch10evo4U3/4SDLCMngAg4TKm8wDPGiikm2F6Vxa5Yd
         akim5alNUwoFbkxGNaip2QLmMLFU2coG8VtUrmFVD68PL8oK96KEQNSSZxH4Tgxr0PXx
         gJh/nIO/SH1Lkd/NabRqq5XoUQz6rgbSeBnSJKHTEBGUFV5dxBhfYKursSpgr2SVEEAG
         +ZeQ==
X-Gm-Message-State: AOJu0YztcVS6UBlbtRdne4yYVYuzmbsQPx4Bnc+KLl2lWaVIi7q0Z1sU
        TMFFJMvr2VGlZMf59y9Tgc3+epWND0IOFir6Fs2ghQ==
X-Google-Smtp-Source: AGHT+IGsphBbtZCg5/tRs4yy3MUn3QTlPYZ+xdX/yMSogol2QvpwBWrufvRV4l421M3zeDbGqyePnqqeo0Gvd2ckuqM=
X-Received: by 2002:a25:3624:0:b0:da0:6a55:b4d5 with SMTP id
 d36-20020a253624000000b00da06a55b4d5mr10138459yba.46.1699978211508; Tue, 14
 Nov 2023 08:10:11 -0800 (PST)
MIME-Version: 1.0
References: <20231114150130.497915-1-sui.jingfeng@linux.dev> <20231114150130.497915-7-sui.jingfeng@linux.dev>
In-Reply-To: <20231114150130.497915-7-sui.jingfeng@linux.dev>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 14 Nov 2023 18:10:00 +0200
Message-ID: <CAA8EJpoQFZjSbJ+nENH7Zcrg_0RZLTxxgdqFzoF7hb11ge_LOQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] drm/bridge: it66121: Add a helper to initialize the
 DRM bridge structure
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
> Helps the it66121_probe() function to reduce weight, no functional change.

This is not a proper commit message.

>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index f36d05331f25..2f7f00f1bedb 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -1004,6 +1004,21 @@ static const struct drm_bridge_funcs it66121_bridge_funcs = {
>         .hpd_disable = it66121_bridge_hpd_disable,
>  };
>
> +static void it66121_bridge_init_base(struct drm_bridge *bridge,
> +                                    struct device_node *of_node,
> +                                    bool hpd_support)

At this point there is no reason for the bridge to miss HPD support.

> +{
> +       bridge->funcs = &it66121_bridge_funcs;
> +       bridge->type = DRM_MODE_CONNECTOR_HDMIA;
> +       bridge->ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID;
> +       if (hpd_support)
> +               bridge->ops |= DRM_BRIDGE_OP_HPD;
> +
> +       bridge->of_node = of_node;
> +
> +       drm_bridge_add(bridge);
> +}
> +
>  static irqreturn_t it66121_irq_threaded_handler(int irq, void *dev_id)
>  {
>         int ret;
> @@ -1637,11 +1652,6 @@ static int it66121_probe(struct i2c_client *client)
>             ctx->device_id != ctx->info->pid)
>                 return -ENODEV;
>
> -       ctx->bridge.funcs = &it66121_bridge_funcs;
> -       ctx->bridge.of_node = dev->of_node;
> -       ctx->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
> -       ctx->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_HPD;
> -
>         ret = devm_request_threaded_irq(dev, client->irq, NULL, it66121_irq_threaded_handler,
>                                         IRQF_ONESHOT, dev_name(dev), ctx);
>         if (ret < 0) {
> @@ -1649,9 +1659,9 @@ static int it66121_probe(struct i2c_client *client)
>                 return ret;
>         }
>
> -       it66121_audio_codec_init(ctx, dev);
> +       it66121_bridge_init_base(&ctx->bridge, dev->of_node, true);
>
> -       drm_bridge_add(&ctx->bridge);
> +       it66121_audio_codec_init(ctx, dev);
>
>         dev_info(dev, "IT66121 probed, chip id: 0x%x:0x%x, revision: %u\n",
>                  ctx->vender_id, ctx->device_id, ctx->revision);
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
