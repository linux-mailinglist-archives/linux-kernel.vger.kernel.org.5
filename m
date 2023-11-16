Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457507EDF85
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345132AbjKPLUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345117AbjKPLUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:20:13 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10884196
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:20:06 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so649039276.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700133606; x=1700738406; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GNz8Mj94lyuJrLopjO1nbrgigdrAg1NmhmUedWnVTlg=;
        b=KHJ/d+HzIt1ioOI1NmiOJb4wXQhY4MXtCEQoFucJpuM3DhyQrCrsLQVTBHyHcmdT9x
         xVCu4Xuw+35gyCy63+7nBecZIlYxSf82MnkVbrhpQdlCle6JmggDg6shwJnGWhjAYEMV
         P1GeTCtcRdxLEzkiIHHFMzBo/xX4qxa58E5yFmRra/FFliHfrBUCyvUalIsnEIXUYv7W
         g1nH3CQh86zB9O73dyurrI1eaknfzl2oxDzRKRfY3t+0omK0un2JPbhxWlF5P+lQtUg+
         rU1ZigmIba9jDzv7cvHqjZkRqdi72Rv3WvROJfL+ctmCwuDBfziK1MNuRx3lJ6+pVTx3
         0FmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700133606; x=1700738406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNz8Mj94lyuJrLopjO1nbrgigdrAg1NmhmUedWnVTlg=;
        b=mhKVShCXwuIHyY3ZN4pAsL+xL7mypAX6xWpH9bAPEk3/7iqrcMpgzLC9MTfLFBrq8x
         sKJAu/4hUrZtbB2om8jin3kx3IUXpE7PmH2rJY+6T6M/oj1kGfd2VE3eO15CTSQihXK2
         f0UzQQGZvZkqDhDOW7dafHuGS0PXiR7o3u/GSUVDAnrd1+p18obwqieq5nf+X61p8tLb
         IDBobnqdg6DeV6iUBFEXyHg8MdtPGMe832ioHPNZDx5so20+WmOHK5vyIRvSAAvyc53w
         2vHyDPz+WrONUVn6bb7a4KqfT8qZNtQ6ho8JWMp6qdXqlhV+86UNqKvrVYqEVlhU52AI
         rr6Q==
X-Gm-Message-State: AOJu0YytyuE2L3/AMjT7wKg+P1yzkuSLgggwoI/eWtWo2l70TV0/bbJB
        4X/9I/OGgPqKbfmxPNni+L1Bim4kCCFAIjHgeCFQnA==
X-Google-Smtp-Source: AGHT+IGqFClAsyT9AYCbI8ZNvTJFKmmRF+52rXiJuzPb5Oh4ZMwuLuYLj2qT2aoDAhyNn9INEi2ilkqWkU4DSjwbYpY=
X-Received: by 2002:a25:b15:0:b0:daf:5f13:4a4e with SMTP id
 21-20020a250b15000000b00daf5f134a4emr11298963ybl.48.1700133605833; Thu, 16
 Nov 2023 03:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20231114150130.497915-1-sui.jingfeng@linux.dev>
 <20231114150130.497915-9-sui.jingfeng@linux.dev> <CAA8EJprQq3aDhzE+yKGZ2-nsuHWcptzMvApsyOi9D63PgeiZ3w@mail.gmail.com>
 <79301d04-c0cb-4740-8a6d-27a889b65daf@linux.dev> <CAA8EJpom5kAbDkacOdqp6BR7YPfmCSXaQfDYRVcLf9eGmi64CQ@mail.gmail.com>
 <121163c9-0d56-47ad-a12e-e67390fef2b4@linux.dev>
In-Reply-To: <121163c9-0d56-47ad-a12e-e67390fef2b4@linux.dev>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 16 Nov 2023 13:19:54 +0200
Message-ID: <CAA8EJpowjhX=LL-9cnQL4pfCei63zNkCGW5wGOeeFxcnFpNCVA@mail.gmail.com>
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

On Thu, 16 Nov 2023 at 12:13, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> Hi,
>
>
> On 2023/11/16 17:30, Dmitry Baryshkov wrote:
> > On Thu, 16 Nov 2023 at 11:14, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
> >> Hi,
> >>
> >> Thanks a lot for reviewing!
> >>
> >>
> >> On 2023/11/15 00:30, Dmitry Baryshkov wrote:
> >>> On Tue, 14 Nov 2023 at 17:09, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
> >>>> From: Sui Jingfeng <suijingfeng@loongson.cn>
> >>>>
> >>>> The it66121_create_bridge() and it66121_destroy_bridge() are added to
> >>>> export the core functionalities. Create a connector manually by using
> >>>> bridge connector helpers when link as a lib.
> >>>>
> >>>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> >>>> ---
> >>>>    drivers/gpu/drm/bridge/ite-it66121.c | 134 +++++++++++++++++++--------
> >>>>    include/drm/bridge/ite-it66121.h     |  17 ++++
> >>>>    2 files changed, 113 insertions(+), 38 deletions(-)
> >>>>    create mode 100644 include/drm/bridge/ite-it66121.h
> >>>>
> >>>> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> >>>> index 8971414a2a60..f5968b679c5d 100644
> >>>> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> >>>> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> >>>> @@ -22,6 +22,7 @@
> >>>>
> >>>>    #include <drm/drm_atomic_helper.h>
> >>>>    #include <drm/drm_bridge.h>
> >>>> +#include <drm/drm_bridge_connector.h>
> >>>>    #include <drm/drm_edid.h>
> >>>>    #include <drm/drm_modes.h>
> >>>>    #include <drm/drm_print.h>
> >>>> @@ -703,14 +704,32 @@ static int it66121_bridge_attach(struct drm_bridge *bridge,
> >>>>                                    enum drm_bridge_attach_flags flags)
> >>>>    {
> >>>>           struct it66121_ctx *ctx = bridge_to_it66121(bridge);
> >>>> +       struct drm_bridge *next_bridge = ctx->next_bridge;
> >>>> +       struct drm_encoder *encoder = bridge->encoder;
> >>>>           int ret;
> >>>>
> >>>> -       if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
> >>>> -               return -EINVAL;
> >>>> +       if (next_bridge) {
> >>>> +               if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
> >>>> +                       WARN_ON(1);
> >>> Why? At least use WARN() instead
> >> Originally I want to
> >>
> >>
> >>
> >>
> >>>> +                       flags |= DRM_BRIDGE_ATTACH_NO_CONNECTOR;
> >>>> +               }
> >>>> +               ret = drm_bridge_attach(encoder, next_bridge, bridge, flags);
> >>>> +               if (ret)
> >>>> +                       return ret;
> >>>> +       } else {
> >>>> +               struct drm_connector *connector;
> >>>>
> >>>> -       ret = drm_bridge_attach(bridge->encoder, ctx->next_bridge, bridge, flags);
> >>>> -       if (ret)
> >>>> -               return ret;
> >>>> +               if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
> >>>> +                       WARN_ON(1);
> >>> No. It is perfectly fine to create attach a bridge with no next_bridge
> >>> and with the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag.
> >>>
> >> The document say when DRM_BRIDGE_ATTACH_NO_CONNECTOR flag is set
> >> the bridge shall not create a drm_connector. So I think if a display
> >> bridge driver don't have a next bridge attached (Currently, this is
> >> told by the DT), it says that this is a non-DT environment. On such
> >> a case, this display bridge driver(it66121.ko) should behavior like
> >> a *agent*. Because the upstream port of it66121 is the DVO port of
> >> the display controller, the downstream port of it66121 is the HDMI
> >> connector. it66121 is on the middle. So I think the it66121.ko should
> >> handle all of troubles on behalf of the display controller drivers.
> > No. Don't make decisions for the other drivers. They might have different needs.
>
> [...]
>
>
> >
> >> Therefore (when in non-DT use case), the display controller drivers
> >> side should not set DRM_BRIDGE_ATTACH_NO_CONNECTOR flag anymore.
> >> Which is to hint that the it66121 should totally in charge of those
> >> tasks (either by using bridge connector helper or create a connector
> >> manually). I don't understand on such a case, why bother display
> >> controller drivers anymore.
> > This is the reason why we had introduced this flag. It allows the
> > driver to customise the connector. It even allows the driver to
> > implement a connector on its own, completely ignoring the
> > drm_bridge_connector.
>
>
> I know what you said is right in the sense of the universe cases,
> but I think the most frequent(majority) use case is that there is
> only one display bridge on the middle. Therefore, I don't want to
> movethe connector things into device driver if there is only one display
> bridge(say it66121) in the middle. After all, there is no *direct
> physical connection* from the perspective of the hardware. I means that
> there is no hardware wires connectthe HDMI connector and the DVO port. So display controller drivers
> should not interact with anything related with the connector on a
> perfect abstract on the software side. Especially for such a simple use
> case. It probably make senses to make a  decision for themost frequently use case, please also note
> that this patch didn't introduce any-restriction for the more advance
> uses cases(multiple bridges in the middle).

So, for the sake of not having the connector in the display driver,
you want to add boilerplate code basically to each and every bridge
driver. In the end, they should all behave in the same way.

Moreover, there is no way this implementation can work without a
warning if there are two bridges in a chain and the it66121 is the
second (the last) one. The host can not specify the
DRM_BRIDGE_ATTACH_NO_CONNECTOR)
> >>>> +                       WARN_ON(1);
> >>> No. It is perfectly fine to create attach a bridge with no next_bridge
> >>> and with the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag.
> >>>
> >> The document say when DRM_BRIDGE_ATTACH_NO_CONNECTOR flag is set
> >> the bridge shall not create a drm_connector. So I think if a display
> >> bridge driver don't have a next bridge attached (Currently, this is
> >> told by the DT), it says that this is a non-DT environment. On such
> >> a case, this display bridge driver(it66121.ko) should behavior like
> >> a *agent*. Because the upstream port of it66121 is the DVO port of
> >> the display controller, the downstream port of it66121 is the HDMI
> >> connector. it66121 is on the middle. So I think the it66121.ko should
> >> handle all of troubles on behalf of the display controller drivers.
> > No. Don't make decisions for the other drivers. They might have different needs.
>
> [...]
>
>
> >
> >> Therefore (when in non-DT use case), the display controller drivers
> >> side should not set DRM_BRIDGE_ATTACH_NO_CONNECTOR flag anymore.
> >> Which is to hint that the it66121 should totally in charge of those
> >> tasks (either by using bridge connector helper or create a connector
> >> manually). I don't understand on such a case, why bother display
> >> controller drivers anymore.
> > This is the reason why we had introduced this flag. It allows the
> > driver to customise the connector. It even allows the driver to
> > implement a connector on its own, completely ignoring the
> > drm_bridge_connector.
>
>
> I know what you said is right in the sense of the universe cases,
> but I think the most frequent(majority) use case is that there is
> only one display bridge on the middle. Therefore, I don't want to
> movethe connector things into device driver if there is only one display
> bridge(say it66121) in the middle. After all, there is no *direct
> physical connection* from the perspective of the hardware. I means that
> there is no hardware wires connectthe HDMI connector and the DVO port. So display controller drivers
> should not interact with anything related with the connector on a
> perfect abstract on the software side. Especially for such a simple use
> case. It probably make senses to make a  decision for themost frequently use case, please also note
> that this patch didn't introduce any-restriction for the more advance
> uses cases(multiple bridges in the middle).

So, for the sake of not having the connector in the display driver,
you want to add boilerplate code basically to each and every bridge
driver. In the end, they should all behave in the same way.

Moreover, there is no way this implementation can work without a
warning if there are two bridges in a chain and the it66121 is the
second (the last) one. The host can not specify the
DRM_BRIDGE_ATTACH_NO_CONNECTOR flag, it will cause a warning here. And
it can not omit the flag (as otherwise the first bridge will create a
connector, without consulting the second bridge).

>
>
> >>
> >>>> +
> >>>> +               connector = drm_bridge_connector_init(bridge->dev, encoder);
> >>>> +               if (IS_ERR(connector))
> >>>> +                       return PTR_ERR(connector);
> >>>> +
> >>>> +               drm_connector_attach_encoder(connector, encoder);
> >>> This goes into your device driver.
> >>>
> >>>> +
> >>>> +               ctx->connector = connector;
> >>>> +       }
> >>>>
> >>>>           if (ctx->info->id == ID_IT66121) {
> >>>>                   ret = regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
> >>>> @@ -1632,16 +1651,13 @@ static const char * const it66121_supplies[] = {
> >>>>           "vcn33", "vcn18", "vrf12"
> >>>>    };
> >
> >



-- 
With best wishes
Dmitry
