Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8130E7EB466
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjKNQFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbjKNQFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:05:43 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C98E183
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:05:40 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5c08c47c055so45295537b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699977939; x=1700582739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WfkIhYLDN5Q40p/hrse+654ByEaL28KAMyC20ym6eww=;
        b=k7FhytyUZEQObB4sNkXJbflRGdLTklZgWI9hjWKWt1K2bQ6bHapUvNuLKGpqvc4eBv
         CHP7Jn8h5hVlYwy4+HZZFcrbWKJLFIk5Ql95i70o8Y5T/R/NH562d4cpxwk0EyTQsimq
         lbke71uQsDx7TmUdOpvTXgJwi5xvXajcDlYJ1riVtCIow2PPVvr7O04f7tQJkLnhvfR5
         cH4mIuZSw3ZZgv+ux1TZtM6LegO1fso5yO+d9TLZu+3WwJ6E+merB1Ev9dJzHVwC4LZK
         S6gETerJuRgFjnW9yZksLlqoGzC4dX4Cn89URbX3nrgftSuMpRgSka9sUSEehA5Noilb
         8gjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699977939; x=1700582739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WfkIhYLDN5Q40p/hrse+654ByEaL28KAMyC20ym6eww=;
        b=U0AlzcFlIkiJ+KUVzXw6SP6deLjgTCbvpOzTXABUVEoyNoSVO+8YuZKfh3PqUpGy/2
         uHBbV8QBkGa0xHJUWIS55mnHdm4844gYC6V0ICkon4hxw5MLCptU7E4wN+LCVZl69tCn
         nVgQr0CkyxZvZV87uAn86brp5MZPeuVcDE3uKFSRH64rR29Nt6d/Hmx1iuIR9sKaauMd
         9dNyXAfsHSFOcUIbFvg5P3jS6Qw/tEB8vp21Por/pIV21w4rAdQngs1kN5bztIQDl90u
         XwdEv6xA9Eg66lxuMl/PZoHO9ammRXlsgYiYbRqz/RKfrMFO2VCnQ/K3GfJt2Ur4A2ee
         6NyQ==
X-Gm-Message-State: AOJu0YxrtEELV1Apx3vrSB7ltW6SgFRedyc4wEQU4FfmUPojghC/DoTC
        QdpM3Gli9jlmNPIqrOYDvf5TvEFQLyhQNasZTmzCMA==
X-Google-Smtp-Source: AGHT+IE2uFa8wpPES/znVeDKECxvMLpftVWkcswHyO5DEGPZytjv38tdoGHKEukoT+EL/XJ0A+CoxJaO//giNxlpFCo=
X-Received: by 2002:a81:840b:0:b0:5be:ae23:c002 with SMTP id
 u11-20020a81840b000000b005beae23c002mr9935221ywf.26.1699977939348; Tue, 14
 Nov 2023 08:05:39 -0800 (PST)
MIME-Version: 1.0
References: <20231114150130.497915-1-sui.jingfeng@linux.dev> <20231114150130.497915-5-sui.jingfeng@linux.dev>
In-Reply-To: <20231114150130.497915-5-sui.jingfeng@linux.dev>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 14 Nov 2023 18:05:28 +0200
Message-ID: <CAA8EJpp0HY=PsCVFk4S3OERNUcin73c5w6ihnoY6aFg83+NhkA@mail.gmail.com>
Subject: Re: [PATCH 4/8] drm/bridge: it66121: Add a helper function to get the
 next bridge
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
> Group the code lines(which with the same functional) into one dedicated
> function, which reduce the weight of it66121_probe() function. Just trivial
> cleanuo, no functional change.
>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 53 ++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index 0f78737adc83..7e473beefc79 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -340,6 +340,37 @@ static int it66121_of_read_bus_width(struct device *dev, u32 *bus_width)
>         return 0;
>  }
>
> +static int it66121_of_get_next_bridge(struct device *dev,
> +                                     struct drm_bridge **next_bridge)

it already exists and it is called drm_of_find_panel_or_bridge(),
could you please use it instead?

> +{
> +       struct device_node *np;
> +       struct drm_bridge *bridge;
> +
> +       np = of_graph_get_remote_node(dev->of_node, 1, -1);
> +       if (!np) {
> +               dev_err(dev, "The endpoint is unconnected\n");
> +               return -EINVAL;
> +       }
> +
> +       if (!of_device_is_available(np)) {
> +               of_node_put(np);
> +               dev_err(dev, "The remote device is disabled\n");
> +               return -ENODEV;
> +       }
> +
> +       bridge = of_drm_find_bridge(np);
> +       of_node_put(np);
> +
> +       if (!bridge) {
> +               dev_dbg(dev, "Next bridge not found, deferring probe\n");
> +               return -EPROBE_DEFER;
> +       }
> +
> +       *next_bridge = bridge;
> +
> +       return 0;
> +}
> +
>  static const struct regmap_range_cfg it66121_regmap_banks[] = {
>         {
>                 .name = "it66121",
> @@ -1531,7 +1562,6 @@ static const char * const it66121_supplies[] = {
>  static int it66121_probe(struct i2c_client *client)
>  {
>         u32 revision_id, vendor_ids[2] = { 0 }, device_ids[2] = { 0 };
> -       struct device_node *ep;
>         int ret;
>         struct it66121_ctx *ctx;
>         struct device *dev = &client->dev;
> @@ -1553,24 +1583,9 @@ static int it66121_probe(struct i2c_client *client)
>         if (ret)
>                 return ret;
>
> -       ep = of_graph_get_remote_node(dev->of_node, 1, -1);
> -       if (!ep) {
> -               dev_err(dev, "The endpoint is unconnected\n");
> -               return -EINVAL;
> -       }
> -
> -       if (!of_device_is_available(ep)) {
> -               of_node_put(ep);
> -               dev_err(dev, "The remote device is disabled\n");
> -               return -ENODEV;
> -       }
> -
> -       ctx->next_bridge = of_drm_find_bridge(ep);
> -       of_node_put(ep);
> -       if (!ctx->next_bridge) {
> -               dev_dbg(dev, "Next bridge not found, deferring probe\n");
> -               return -EPROBE_DEFER;
> -       }
> +       ret = it66121_of_get_next_bridge(dev, &ctx->next_bridge);
> +       if (ret)
> +               return ret;
>
>         i2c_set_clientdata(client, ctx);
>         mutex_init(&ctx->lock);
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
