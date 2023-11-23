Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4AC7F599F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344853AbjKWHyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKWHyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:54:08 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215A41B2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 23:54:15 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5cce3010367so5741187b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 23:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700726054; x=1701330854; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f5KwFuLZ/LzwMj0Lr7xpRitCKzKd8VxfJ4AdjnQ0KTs=;
        b=m6P8AN1HBsXPid+Nlm2FJ5rvafkuGxG7/8s/SKMcj2CQ9+LeeF7BAYNeNzZEZxLrgC
         mKlfRXOdqC/eRk7SEVEFJywQiXFx/WFeDqFL+vg+OMJHf+ubQnUq9VyG6SF079iMi2QG
         kqJlP2B2IpxqdflIgHDpdv6XMWix8U4HPknZKwFpihR5tFi27aPNkrSMqvbzIndMdxvI
         zLALV3ytGyVKl/sKOVoKL8lhiKIrlc/8qsC4kGrEB5kgb0kovBHAJJMhlq9jdWjqI1vk
         +uBDYofH6AvEf2bVNz5OoDMKFCEGP3Opjk0YVE28CXqXOza9im5jd4J7lgij8ZRB9Mt4
         yF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700726054; x=1701330854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5KwFuLZ/LzwMj0Lr7xpRitCKzKd8VxfJ4AdjnQ0KTs=;
        b=uoBBCORqGW90FI6fZwL2oBes8uRjQrioAAXmEDu3FS0taA5Ag1HrdwxlRdpGLT4gQ0
         VvF0enTBpLq5SsSRXkO/R/AdGXxU9QzflhI07OD1B21rvj9GxLhEixjpeqj5udLzTjdG
         IS5zpuF2nzqKT7eV0CLw833hblBe7o7FY1Yx0JYodGOlMQjFBVSLhVtBlKYbaz5CrOdH
         6vJlmEXgFRGKVOg27XsKQn0rnP90jf1D7pofKGtV464l4XoWzYC2NRCTc8Ekd/HbjP7i
         2czf+9OFRQeZJsaOyAS76yMa0ue4WWkpxvwPOJnev3QbHZ8L24UT66BhL0ORhzvfw44L
         sANA==
X-Gm-Message-State: AOJu0Yyxk1EM8U5uHW6f5kuFg3yu2xOwGhDy4xQKO5BxJOXkObuwARWF
        EFW6yBykYRALEoe9Qu4Tb/sk4SGd9J17YSrZ+4fkrw==
X-Google-Smtp-Source: AGHT+IGfDu/9I47nLk79+G6LbU1Nnht9vmXhErvPc7HbK4Rf5Fw6QGjnMYIJ79g2fougllfxvj/J8H6Lcf5zKmcQmos=
X-Received: by 2002:a81:9a4c:0:b0:5cd:ad4:16dd with SMTP id
 r73-20020a819a4c000000b005cd0ad416ddmr1997505ywg.45.1700726054292; Wed, 22
 Nov 2023 23:54:14 -0800 (PST)
MIME-Version: 1.0
References: <20231114150130.497915-1-sui.jingfeng@linux.dev>
 <20231114150130.497915-5-sui.jingfeng@linux.dev> <CAA8EJpp0HY=PsCVFk4S3OERNUcin73c5w6ihnoY6aFg83+NhkA@mail.gmail.com>
 <1ea7e68d-7005-4f5b-92df-d2f7c56a49b2@linux.dev>
In-Reply-To: <1ea7e68d-7005-4f5b-92df-d2f7c56a49b2@linux.dev>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 23 Nov 2023 09:54:03 +0200
Message-ID: <CAA8EJpp=U9x0rjXeT2m8S2PESd0y18h+pOFB-RQWJh83s9UGOQ@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 at 07:25, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> Hi,
>
>
> On 2023/11/15 00:05, Dmitry Baryshkov wrote:
> > On Tue, 14 Nov 2023 at 17:09, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
> >> From: Sui Jingfeng <suijingfeng@loongson.cn>
> >>
> >> Group the code lines(which with the same functional) into one dedicated
> >> function, which reduce the weight of it66121_probe() function. Just trivial
> >> cleanuo, no functional change.
> >>
> >> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> >> ---
> >>   drivers/gpu/drm/bridge/ite-it66121.c | 53 ++++++++++++++++++----------
> >>   1 file changed, 34 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> >> index 0f78737adc83..7e473beefc79 100644
> >> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> >> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> >> @@ -340,6 +340,37 @@ static int it66121_of_read_bus_width(struct device *dev, u32 *bus_width)
> >>          return 0;
> >>   }
> >>
> >> +static int it66121_of_get_next_bridge(struct device *dev,
> >> +                                     struct drm_bridge **next_bridge)
> > it already exists and it is called drm_of_find_panel_or_bridge(),
> > could you please use it instead?
>
> That function is too fat and tangled, and should be untangled.
> it66121 can not connect with a panel, this is a prior knowledge
> and is known at compile time. So this prior knowledge shouldn't
> be dropped.

This prior knowledge is kept by passing NULL as a panel. We already
have a helper. It covers your use case. There is no need to write your
own boilerplate code for it.

>
> >> +{
> >> +       struct device_node *np;
> >> +       struct drm_bridge *bridge;
> >> +
> >> +       np = of_graph_get_remote_node(dev->of_node, 1, -1);
> >> +       if (!np) {
> >> +               dev_err(dev, "The endpoint is unconnected\n");
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       if (!of_device_is_available(np)) {
> >> +               of_node_put(np);
> >> +               dev_err(dev, "The remote device is disabled\n");
> >> +               return -ENODEV;
> >> +       }
> >> +
> >> +       bridge = of_drm_find_bridge(np);
> >> +       of_node_put(np);
> >> +
> >> +       if (!bridge) {
> >> +               dev_dbg(dev, "Next bridge not found, deferring probe\n");
> >> +               return -EPROBE_DEFER;
> >> +       }
> >> +
> >> +       *next_bridge = bridge;
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>   static const struct regmap_range_cfg it66121_regmap_banks[] = {
> >>          {
> >>                  .name = "it66121",
> >> @@ -1531,7 +1562,6 @@ static const char * const it66121_supplies[] = {
> >>   static int it66121_probe(struct i2c_client *client)
> >>   {
> >>          u32 revision_id, vendor_ids[2] = { 0 }, device_ids[2] = { 0 };
> >> -       struct device_node *ep;
> >>          int ret;
> >>          struct it66121_ctx *ctx;
> >>          struct device *dev = &client->dev;
> >> @@ -1553,24 +1583,9 @@ static int it66121_probe(struct i2c_client *client)
> >>          if (ret)
> >>                  return ret;
> >>
> >> -       ep = of_graph_get_remote_node(dev->of_node, 1, -1);
> >> -       if (!ep) {
> >> -               dev_err(dev, "The endpoint is unconnected\n");
> >> -               return -EINVAL;
> >> -       }
> >> -
> >> -       if (!of_device_is_available(ep)) {
> >> -               of_node_put(ep);
> >> -               dev_err(dev, "The remote device is disabled\n");
> >> -               return -ENODEV;
> >> -       }
> >> -
> >> -       ctx->next_bridge = of_drm_find_bridge(ep);
> >> -       of_node_put(ep);
> >> -       if (!ctx->next_bridge) {
> >> -               dev_dbg(dev, "Next bridge not found, deferring probe\n");
> >> -               return -EPROBE_DEFER;
> >> -       }
> >> +       ret = it66121_of_get_next_bridge(dev, &ctx->next_bridge);
> >> +       if (ret)
> >> +               return ret;
> >>
> >>          i2c_set_clientdata(client, ctx);
> >>          mutex_init(&ctx->lock);
> >> --
> >> 2.34.1
> >>
> >



-- 
With best wishes
Dmitry
