Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86587EDD9D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjKPJaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjKPJau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:30:50 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87629C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:30:46 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a82c2eb50cso6009357b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700127046; x=1700731846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cOalNhNWON0tzgJDSNBQ7PJyNiEFmyM6jXYqhmL2sw4=;
        b=LlIT1MIbSYQuwFF1bc2TW/MsUwfu3u/6GkxqtWV+LZFmrycZeTUXgwwV4Wgn1PWZkv
         GbdumcXgf/YtM/88H8DHTg3Ter9ojqG66ZrYcgJ9UoTTssNyIMUFS8hBfsnZrw+JL/qy
         lURyJDpzVDC67z3uKAGTM0pFu2zzqvPFjKH2N27iU7JlKt32cEh/PdVQCSGHDxoUXXq3
         DKvqHVMa5g6/H3DPeiaTBApckJqqfpcbvQO1b7UA7pkftoygfMDItocNr+4lD7Xahu+8
         He3xF5XEOLs8oewfS65JtJM9cUSI20lEiAEoJ3qs57yn9bYhMURgYjNxq1JUlgDGzlWk
         J1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700127046; x=1700731846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cOalNhNWON0tzgJDSNBQ7PJyNiEFmyM6jXYqhmL2sw4=;
        b=hBBCo7ArLMJcc9UjifesZ61jkSMUrqXzMSUmoLoRgUUGW2GNWI/VwuUn/ocR7ysK6v
         PH1k00hxbSr60ZBc4ntGrbzmMcdQ8/BJNkbFzdjQzst3hThvMVQzso1K3vTDlFQ7O+Gc
         TtK+oZznuCjfJl+7/qG+8fXkWLqSDyNz+m9EQXOdZyK0jlBIub/23dRXHnfRbt3MOF9U
         b6kVtGsoijpkfZmlSdBOUI+dq5C3H7oy8bMQNSMi5j9XvvcYdnr2Uglp2UWYpFY8BBpn
         hrYhrZxnZxp+h83Texv0zpU0oF70IgcrnrvomiQI1SvSqEO99xZee6thujDsGupZxEQp
         vn4g==
X-Gm-Message-State: AOJu0Yx+VTij0aLoBgu6Xbet0YWv561BW3N9R7q5IuY0uXyHekyjzljU
        So4g0JCLh6glhB/XTJxHCz9BaLwtCfxCJZEawuQunw==
X-Google-Smtp-Source: AGHT+IG/y2QkwE5jz6zn2wyoqRZJsRkb2SMpVkvXZlwMv12XeV3+EIY7Vc3LwWdJMLOl+P+/86tTF28+DWBpYWwsTB0=
X-Received: by 2002:a0d:ccc4:0:b0:5be:9d2f:2eaf with SMTP id
 o187-20020a0dccc4000000b005be9d2f2eafmr13881753ywd.0.1700127045878; Thu, 16
 Nov 2023 01:30:45 -0800 (PST)
MIME-Version: 1.0
References: <20231114150130.497915-1-sui.jingfeng@linux.dev>
 <20231114150130.497915-9-sui.jingfeng@linux.dev> <CAA8EJprQq3aDhzE+yKGZ2-nsuHWcptzMvApsyOi9D63PgeiZ3w@mail.gmail.com>
 <79301d04-c0cb-4740-8a6d-27a889b65daf@linux.dev>
In-Reply-To: <79301d04-c0cb-4740-8a6d-27a889b65daf@linux.dev>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 16 Nov 2023 11:30:34 +0200
Message-ID: <CAA8EJpom5kAbDkacOdqp6BR7YPfmCSXaQfDYRVcLf9eGmi64CQ@mail.gmail.com>
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

On Thu, 16 Nov 2023 at 11:14, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> Hi,
>
> Thanks a lot for reviewing!
>
>
> On 2023/11/15 00:30, Dmitry Baryshkov wrote:
> > On Tue, 14 Nov 2023 at 17:09, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
> >> From: Sui Jingfeng <suijingfeng@loongson.cn>
> >>
> >> The it66121_create_bridge() and it66121_destroy_bridge() are added to
> >> export the core functionalities. Create a connector manually by using
> >> bridge connector helpers when link as a lib.
> >>
> >> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> >> ---
> >>   drivers/gpu/drm/bridge/ite-it66121.c | 134 +++++++++++++++++++--------
> >>   include/drm/bridge/ite-it66121.h     |  17 ++++
> >>   2 files changed, 113 insertions(+), 38 deletions(-)
> >>   create mode 100644 include/drm/bridge/ite-it66121.h
> >>
> >> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> >> index 8971414a2a60..f5968b679c5d 100644
> >> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> >> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> >> @@ -22,6 +22,7 @@
> >>
> >>   #include <drm/drm_atomic_helper.h>
> >>   #include <drm/drm_bridge.h>
> >> +#include <drm/drm_bridge_connector.h>
> >>   #include <drm/drm_edid.h>
> >>   #include <drm/drm_modes.h>
> >>   #include <drm/drm_print.h>
> >> @@ -703,14 +704,32 @@ static int it66121_bridge_attach(struct drm_bridge *bridge,
> >>                                   enum drm_bridge_attach_flags flags)
> >>   {
> >>          struct it66121_ctx *ctx = bridge_to_it66121(bridge);
> >> +       struct drm_bridge *next_bridge = ctx->next_bridge;
> >> +       struct drm_encoder *encoder = bridge->encoder;
> >>          int ret;
> >>
> >> -       if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
> >> -               return -EINVAL;
> >> +       if (next_bridge) {
> >> +               if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
> >> +                       WARN_ON(1);
> > Why? At least use WARN() instead
>
> Originally I want to
>
>
>
>
> >> +                       flags |= DRM_BRIDGE_ATTACH_NO_CONNECTOR;
> >> +               }
> >> +               ret = drm_bridge_attach(encoder, next_bridge, bridge, flags);
> >> +               if (ret)
> >> +                       return ret;
> >> +       } else {
> >> +               struct drm_connector *connector;
> >>
> >> -       ret = drm_bridge_attach(bridge->encoder, ctx->next_bridge, bridge, flags);
> >> -       if (ret)
> >> -               return ret;
> >> +               if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
> >> +                       WARN_ON(1);
> > No. It is perfectly fine to create attach a bridge with no next_bridge
> > and with the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag.
> >
>
> The document say when DRM_BRIDGE_ATTACH_NO_CONNECTOR flag is set
> the bridge shall not create a drm_connector. So I think if a display
> bridge driver don't have a next bridge attached (Currently, this is
> told by the DT), it says that this is a non-DT environment. On such
> a case, this display bridge driver(it66121.ko) should behavior like
> a *agent*. Because the upstream port of it66121 is the DVO port of
> the display controller, the downstream port of it66121 is the HDMI
> connector. it66121 is on the middle. So I think the it66121.ko should
> handle all of troubles on behalf of the display controller drivers.

No. Don't make decisions for the other drivers. They might have different needs.

> Therefore (when in non-DT use case), the display controller drivers
> side should not set DRM_BRIDGE_ATTACH_NO_CONNECTOR flag anymore.
> Which is to hint that the it66121 should totally in charge of those
> tasks (either by using bridge connector helper or create a connector
> manually). I don't understand on such a case, why bother display
> controller drivers anymore.

This is the reason why we had introduced this flag. It allows the
driver to customise the connector. It even allows the driver to
implement a connector on its own, completely ignoring the
drm_bridge_connector.

>
>
> >> +
> >> +               connector = drm_bridge_connector_init(bridge->dev, encoder);
> >> +               if (IS_ERR(connector))
> >> +                       return PTR_ERR(connector);
> >> +
> >> +               drm_connector_attach_encoder(connector, encoder);
> > This goes into your device driver.
> >
> >> +
> >> +               ctx->connector = connector;
> >> +       }
> >>
> >>          if (ctx->info->id == ID_IT66121) {
> >>                  ret = regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
> >> @@ -1632,16 +1651,13 @@ static const char * const it66121_supplies[] = {
> >>          "vcn33", "vcn18", "vrf12"
> >>   };
> >



-- 
With best wishes
Dmitry
