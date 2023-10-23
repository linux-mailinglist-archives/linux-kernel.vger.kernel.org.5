Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246497D2B89
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjJWHkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjJWHkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:40:20 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA88D66
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:40:17 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-7b61de8e456so1015826241.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698046817; x=1698651617; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LTwZL7ZB+4qPOTcj2G/meZmbL6HBlSSmbTIpmPj/DWo=;
        b=iwTylf5PFE0lK6nJdcspMuSGrVpuLBP7cuc+VzVsTtS2/H4GLfDLUQOZgBo4v8t/yZ
         9cL99Yi0UEPWWpeOEX1wljhTCbt0k8lGyQxwpED15Uhs4cJy9MHhFy0C1YL82tzLxc4w
         K/4Op01gBqWA60hZw1WHugxdOCwhaQOxjZibDqvtRF+9ndjMD+Aqc1u2uWeis90z9VCh
         s4Ud1MnFWY3QM9MFYuAxMHvm5xO9kNX4cbv5a+Qs/tZIVknVoc74efL5MDLMM/rE2nVB
         Wk2oMLahrMod0z822heYsA94KRCsQZ+ISndsGPopK3A2BZmRJL6GnX5KEkFPzCIvprqh
         iTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698046817; x=1698651617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTwZL7ZB+4qPOTcj2G/meZmbL6HBlSSmbTIpmPj/DWo=;
        b=fPfk47htvdACimoCnwMTprNN4JOmOXJr26NOeDSobULtCPFoG4C7tnx63Xl+dDxObP
         KbwJqvDOzch6Y9wA1SO4k6ftOJrRwIm1PvlbLzOwbab8nLKAt0e1ywS+j5TJ9cXV3f+l
         x7myIaDiIIg4/1Hl279uzPXzeL4/fwjSUQnoQsSD6FelYGbpTukGQGVR7JXiXG38dTKy
         C1jY2uyLCKv7SREiBRcEjHOMfa4ReF25G+vg0ZxJLlcu350sdUQe66BhDNvE7xKYpQU6
         C5h5C54Yj5HEmkD855kMaUuQL6wSN05Y5S6hdxCkoFb/EGcX+QYEg6yAuynFYeWPfRsz
         5SIg==
X-Gm-Message-State: AOJu0YyKASSYA6LfTvgfE6KdI/L2t8IUxCodyGPAuYAI0fu16nhUooB1
        OpmTGxP94eCKustoaclH+ECYp4X3Dk8IQhgnzKejnA==
X-Google-Smtp-Source: AGHT+IFIuNOE5csO/dEMQna24sjlvo6iAi0uk2UHGNbT+8VHC5+6qCdvQw7xewHtIa5zcWhbY15Yzb9NZ+ZLP2wfiNg=
X-Received: by 2002:a1f:fc07:0:b0:49b:adce:e2d1 with SMTP id
 a7-20020a1ffc07000000b0049badcee2d1mr7498986vki.10.1698046816744; Mon, 23 Oct
 2023 00:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231016165355.1327217-1-dmitry.baryshkov@linaro.org>
 <20231016165355.1327217-4-dmitry.baryshkov@linaro.org> <d941462e-1ac8-4dce-bd09-ddb99d79578a@linaro.org>
In-Reply-To: <d941462e-1ac8-4dce-bd09-ddb99d79578a@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 23 Oct 2023 10:40:05 +0300
Message-ID: <CAA8EJpqB6eMCEEg3Ptg531mTiOsnP=3qE_C6dyA1_TO4ZbJAbw@mail.gmail.com>
Subject: Re: [RFC PATCH 03/10] drm/mipi-dsi: add API for manual control over
 the DSI link power state
To:     neil.armstrong@linaro.org
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Marek Vasut <marex@denx.de>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 at 10:35, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 16/10/2023 18:53, Dmitry Baryshkov wrote:
> > The MIPI DSI links do not fully fall into the DRM callbacks model. The
> > drm_bridge_funcs abstraction. Instead of having just two states (off and
> > on) the DSI hosts have separate LP-11 state. In this state the host is
> > on, but the video stream is not yet enabled.
> >
> > Introduce API that allows DSI bridges / panels to control the DSI host
> > power up state.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/drm_mipi_dsi.c | 31 +++++++++++++++++++++++++++++++
> >   include/drm/drm_mipi_dsi.h     | 29 +++++++++++++++++++++++++----
> >   2 files changed, 56 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> > index 14201f73aab1..c467162cb7d8 100644
> > --- a/drivers/gpu/drm/drm_mipi_dsi.c
> > +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> > @@ -428,6 +428,37 @@ int devm_mipi_dsi_attach(struct device *dev,
> >   }
> >   EXPORT_SYMBOL_GPL(devm_mipi_dsi_attach);
> >
> > +bool mipi_dsi_host_power_control_available(struct mipi_dsi_host *host)
> > +{
> > +     const struct mipi_dsi_host_ops *ops = host->ops;
> > +
> > +     return ops && ops->power_up;
> > +}
> > +EXPORT_SYMBOL_GPL(mipi_dsi_host_power_control_available);
> > +
> > +int mipi_dsi_host_power_up(struct mipi_dsi_host *host)
> > +{
> > +     const struct mipi_dsi_host_ops *ops = host->ops;
> > +
> > +     if (!mipi_dsi_host_power_control_available(host))
> > +             return -EOPNOTSUPP;
> > +
> > +     return ops->power_up ? ops->power_up(host) : 0;
> > +}
> > +EXPORT_SYMBOL_GPL(mipi_dsi_host_power_up);
> > +
> > +void mipi_dsi_host_power_down(struct mipi_dsi_host *host)
> > +{
> > +     const struct mipi_dsi_host_ops *ops = host->ops;
> > +
> > +     if (!mipi_dsi_host_power_control_available(host))
> > +             return;
> > +
> > +     if (ops->power_down)
> > +             ops->power_down(host);
> > +}
> > +EXPORT_SYMBOL_GPL(mipi_dsi_host_power_down);
> > +
> >   static ssize_t mipi_dsi_device_transfer(struct mipi_dsi_device *dsi,
> >                                       struct mipi_dsi_msg *msg)
> >   {
> > diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> > index 167742e579e3..e503c3e4d057 100644
> > --- a/include/drm/drm_mipi_dsi.h
> > +++ b/include/drm/drm_mipi_dsi.h
> > @@ -68,6 +68,8 @@ int mipi_dsi_create_packet(struct mipi_dsi_packet *packet,
> >    * @attach: attach DSI device to DSI host
> >    * @detach: detach DSI device from DSI host
> >    * @transfer: transmit a DSI packet
> > + * @power_up: enable DSI link and bring it to the LP-11 state
> > + * @power_down: fully disable DSI link
> >    *
> >    * DSI packets transmitted by .transfer() are passed in as mipi_dsi_msg
> >    * structures. This structure contains information about the type of packet
> > @@ -81,10 +83,18 @@ int mipi_dsi_create_packet(struct mipi_dsi_packet *packet,
> >    * function will seldomly return anything other than the number of bytes
> >    * contained in the transmit buffer on success.
> >    *
> > - * Also note that those callbacks can be called no matter the state the
> > - * host is in. Drivers that need the underlying device to be powered to
> > - * perform these operations will first need to make sure it's been
> > - * properly enabled.
> > + * Note: currently there are two modes of DSI power control. Legacy drivers
> > + * will call those callbacks no matter the state the host is in. DSI host
> > + * drivers that need the underlying device to be powered to perform these
> > + * operations will first need to make sure it's been properly enabled.
> > + *
> > + * Newer drivers will set the @MIPI_DSI_MANUAL_POWERUP flag to indicate that
> > + * they will call @mipi_dsi_power_up() and @mipi_dsi_power_down() to control
> > + * the link state of the DSI host or they will set @MIPI_DSI_AUTO_POWERUP to
> > + * indicate that the driver is fine with the link being powered up in DSI
> > + * host's (atomic_)pre_enable() callback and then being disabled in the
> > + * (atomic_)post_disable() callback. The transfer callback must only be called
> > + * if the DSI host has been powered up and was not brought down.
> >    *
> >    * Note: some hosts (sunxi) can not send LP commands between HS video
> >    * packets. Thus all DSI transfers sent in LP mode should be limited to the
> > @@ -97,6 +107,8 @@ struct mipi_dsi_host_ops {
> >                     struct mipi_dsi_device *dsi);
> >       ssize_t (*transfer)(struct mipi_dsi_host *host,
> >                           const struct mipi_dsi_msg *msg);
> > +     int (*power_up)(struct mipi_dsi_host *host);
> > +     void (*power_down)(struct mipi_dsi_host *host);
> >   };
> >
> >   /**
> > @@ -143,6 +155,10 @@ struct mipi_dsi_host *of_find_mipi_dsi_host_by_node(struct device_node *node);
> >   #define MIPI_DSI_MODE_LPM           BIT(11)
> >   /* transmit data ending at the same time for all lanes within one hsync */
> >   #define MIPI_DSI_HS_PKT_END_ALIGNED BIT(12)
> > +/* DSI peripheral driver manually controls DSI link powerup */
> > +#define MIPI_DSI_MANUAL_POWERUP              BIT(13)
> > +/* DSI peripheral driver is fine with automatic DSI link power control */
> > +#define MIPI_DSI_AUTO_POWERUP                BIT(14)
>
> What happens if none of the bits are in the flags ?
>
> Can't we implement "opportunistic power-up" on the first DSI command sent?

Not really. Such an opportunistic power up was expected to be there
and ... it failed, as you can see from the pre_enable_prev_first and
then by this series.

If the device doesn't set either of these flags, the DSI host can not
make any guesses about the time to power up the link. So, it should
follow the previous approach of enabling the DSI link no later than
mode_set. Otherwise the DSI sink might not be able to send DSI
commands from pre_enable callback.

>
> If a bridge/panel sends a DSI command, and if it happens before the DSI host enable, then
> the DSI host will "pre-enable" the host and put the link in LP-11.
>
> This would be simpler and would work whatever the pre_enable order.
>
> But this won't work for the tc358767, except if we add a dummy DSI host command
> which powers up the DSI link.
>
> This won't fix the PS8640 either who also needs a disabled DSI link to initialize.

Well, you have said it. The automatic enabling doesn't work if the DSI
host has no information about the DSI sink.

>
> Neil
>
> >
> >   enum mipi_dsi_pixel_format {
> >       MIPI_DSI_FMT_RGB888,
> > @@ -235,6 +251,11 @@ void mipi_dsi_device_unregister(struct mipi_dsi_device *dsi);
> >   struct mipi_dsi_device *
> >   devm_mipi_dsi_device_register_full(struct device *dev, struct mipi_dsi_host *host,
> >                                  const struct mipi_dsi_device_info *info);
> > +
> > +bool mipi_dsi_host_power_control_available(struct mipi_dsi_host *host);
> > +int mipi_dsi_host_power_up(struct mipi_dsi_host *host);
> > +void mipi_dsi_host_power_down(struct mipi_dsi_host *host);
> > +
> >   struct mipi_dsi_device *of_find_mipi_dsi_device_by_node(struct device_node *np);
> >   int mipi_dsi_attach(struct mipi_dsi_device *dsi);
> >   int mipi_dsi_detach(struct mipi_dsi_device *dsi);
>


-- 
With best wishes
Dmitry
