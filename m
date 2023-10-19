Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14C07CF686
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345321AbjJSLUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjJSLUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:20:05 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D080112
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:20:03 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a7ab31fb8bso93798547b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697714402; x=1698319202; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LClJmbXBbgZZ9PL/ptRr8uW+H9M+Lhuk/jPg67TAQuM=;
        b=Scw1PNSeXgotgZQKTuLd5d5wdM8SgZXZiHarEsfMMVLL6xjf08gdjyUNkgfH3AapTg
         Jz/ftuxy6+1imNEuskuNvoZfURr0TBhi9nHOx0tGepw5Ax8gK44ktJI2FHAON0sihijY
         ZCVkZD6h/5lPZulPHk1OvzJwNai2Dr9hOr/vkwXNMHAzdX3xMPuVu/Lmy8sYca+BQ2b/
         ZFVPe0sjHT1IAjihIx2+9hVx4RKV5mIrbiRLnn3u8qVkhDVXvaq/8qrLtZ8lrcwq2SKh
         BY7VpXMqsQRVr0IkiuAceJ+M7PBfa9jBysXVgtbwO/B5+SjB5KbCS9d7KTBF1fXKxKzG
         A99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697714402; x=1698319202;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LClJmbXBbgZZ9PL/ptRr8uW+H9M+Lhuk/jPg67TAQuM=;
        b=cUaFuoFE7GjqvLIHCvJN/tQmVIQ4FqcDFVo9YgocXg0bHmD+4YpAWJQ54H1awvADmm
         VgRjfdWgnDD1eh7Xy4lINz4C1fNZU9q2uTJhthumiyVKe+OfjdFduPdDNNeT/VdJLXpP
         v5fCn1jMiDJ/R9oOwVAX8RTS1VvQLoEqu+EKYKH1VJXKdN8czDpbvmxhNLjv2GtJO1+4
         R93CCloiFC/idQn+9pY1sSA6Wyye70qA2+fN7Uq+5PBpj9yIxrSmUa9kZ3KBAu1YeVcT
         afynh4pdOvZ1HwwYasE5R4ruaEBbfW6fpjfFfKUtXA5WablQ4sjHqw9EYWC3K2fnKPgJ
         8roQ==
X-Gm-Message-State: AOJu0Ywr2GaQTm1s1nE4fuu31gpzhW3xBcFEbCezf2ujPaS/SQagKH/J
        ++et4G+irUsrYQJqidxXIhnrLDl15zf0EZVqemW1Cg==
X-Google-Smtp-Source: AGHT+IHsKrnC+HnnF2UK0XWJsB/bhHUzaseUh9wgYFQMhnXiNl5Q/h72pZzdPFWB8GR4VoHaQazj+FeGDz8qhVkt4fA=
X-Received: by 2002:a25:285:0:b0:d9a:5f91:c616 with SMTP id
 127-20020a250285000000b00d9a5f91c616mr2004733ybc.46.1697714402196; Thu, 19
 Oct 2023 04:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231016165355.1327217-1-dmitry.baryshkov@linaro.org>
 <20231016165355.1327217-4-dmitry.baryshkov@linaro.org> <7e4ak4e77fp5dat2aopyq3g4wnqu3tt7di7ytdr3dvgjviyhrd@vqiqx6iso6vg>
In-Reply-To: <7e4ak4e77fp5dat2aopyq3g4wnqu3tt7di7ytdr3dvgjviyhrd@vqiqx6iso6vg>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 19 Oct 2023 14:19:51 +0300
Message-ID: <CAA8EJpp48AdJmx_U=bEJZUWZgOiT1Ctz6Lpe9QwjLXkMQvsw5w@mail.gmail.com>
Subject: Re: [RFC PATCH 03/10] drm/mipi-dsi: add API for manual control over
 the DSI link power state
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 at 12:26, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Mon, Oct 16, 2023 at 07:53:48PM +0300, Dmitry Baryshkov wrote:
> > The MIPI DSI links do not fully fall into the DRM callbacks model.
>
> Explaining why would help

A kind of explanation comes afterwards, but probably I should change
the order of the phrases and expand it:

The atomic_pre_enable / atomic_enable and correspondingly
atomic_disable / atomic_post_disable expect that the bridge links
follow a simple paradigm: either it is off, or it is on and streaming
video. Thus, it is fine to just enable the link at the enable time,
doing some preparations during the pre_enable.

But then it causes several issues with DSI. First, some of the DSI
bridges and most of the DSI panels would like to send commands over
the DSI link to setup the device. Next, some of the DSI hosts have
limitations on sending the commands. The proverbial sunxi DSI host can
not send DSI commands after the video stream has started. Thus most of
the panels have opted to send all DSI commands from pre_enable (or
prepare) callback (before the video stream has started).

However this leaves no good place for the DSI host to power up the DSI
link. By default the host's pre_enable callback is called after the
DSI bridge's pre_enable. For quite some time we were powering up the
DSI link from mode_set. This doesn't look fully correct. And also we
got into the issue with ps8640 bridge, which requires for the DSI link
to be quiet / unpowered at the bridge's reset time.

Dave has come with the idea of pre_enable_prev_first /
prepare_prev_first flags, which attempt to solve the issue by
reversing the order of pre_enable callbacks. This mostly solves the
issue. However during this cycle it became obvious that this approach
is not ideal too. There is no way for the DSI host to know whether the
DSI panel / bridge has been updated to use this flag or not, see the
discussion at [1].

Thus comes this proposal. It allows for the panels to explicitly bring
the link up and down at the correct time, it supports automatic use
case, where no special handling is required. And last, but not least,
it allows the DSI host to note that the bridge / panel were not
updated to follow new protocol and thus the link should be powered on
at the mode_set time. This leaves us with the possibility of dropping
support for this workaround once all in-kernel drivers are updated.

> > The drm_bridge_funcs abstraction.
>
> Is there a typo or missing words?

missing comma in front of The

>
> > Instead of having just two states (off and on) the DSI hosts have
> > separate LP-11 state. In this state the host is on, but the video
> > stream is not yet enabled.
> >
> > Introduce API that allows DSI bridges / panels to control the DSI host
> > power up state.

[1] https://lore.kernel.org/dri-devel/6c0dd9fd-5d8e-537c-804f-7a03d5899a07@linaro.org/

> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/gpu/drm/drm_mipi_dsi.c | 31 +++++++++++++++++++++++++++++++
> >  include/drm/drm_mipi_dsi.h     | 29 +++++++++++++++++++++++++----
> >  2 files changed, 56 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> > index 14201f73aab1..c467162cb7d8 100644
> > --- a/drivers/gpu/drm/drm_mipi_dsi.c
> > +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> > @@ -428,6 +428,37 @@ int devm_mipi_dsi_attach(struct device *dev,
> >  }
> >  EXPORT_SYMBOL_GPL(devm_mipi_dsi_attach);
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
>
> If this API is supposed to be used by DSI devices, it should probably
> take a mipi_dsi_device pointer as a parameter?

Ack.

>
> We should probably make sure it hasn't been powered on already too?

Ack, I can add an atomic count there and a WARN_ON. However I don't
think that it is a real problem.

>
> Maxime



--
With best wishes

Dmitry
