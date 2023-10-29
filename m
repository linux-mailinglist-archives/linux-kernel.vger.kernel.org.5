Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18307DAD4A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 17:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjJ2Qwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 12:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJ2Qwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 12:52:36 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557C6BE
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 09:52:33 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5ac376d311aso32428837b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 09:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698598352; x=1699203152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Aoy1l/OIWuZyO9Z9oXh2HgTPM0zwmwHlZqeVfBp4F14=;
        b=ICBNXs3MjBrR8S36oUFwyhFsLrCqp00IgwPLWE3/kru9CoNJTunde/9OBVqk+F3UxX
         tMs8C/QjUvYkZQvSNsP9LvedVHj3WAHWkhmrJnFUssoD2ClcZnc5ILu91ujmUqtg3vfW
         EF7LFpoXbqBVNwrGLKrbc8UBxeG4nimKEbmnm/uxGpIHit1f2ubmesgaMfCKv7DpqSeF
         bM2C8aRRnJwcndWhijIScZRRnoAP92tiwyvbr4Q2Tuvpa1WRUAsOjqEQDKyCQuilVOsP
         rh1DdbHE/K6WKhyoSaJGUJoWv7weHYEaTODie+hB0Jb+ENzahKMzeLfs+bxw6VeoO0OV
         ZBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698598352; x=1699203152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aoy1l/OIWuZyO9Z9oXh2HgTPM0zwmwHlZqeVfBp4F14=;
        b=eBqUKgwnXtUwzI6oNDtPaVtyqduZFMkVv3vbZ8vCvZhG1d0Ar3AEJnaeMRlk/dZGwB
         JlqSWGwZRKsIMI3Tg6mGgDwjU0hh/M3Ow40jiga0ZIVRmDG+Z/spOOOYAO5M2X1RVBuU
         BLn/osKhH/2hxH/pTQr8w2lq7OijRPJZGp/WmLZ/Cz4IPnANle2Sx70m9BbFbmn1oBkv
         ZjmCOBnKzSUGfLHXPvfAnaP6snHsxfBANs/v3sAaawjLxkfvdOPKXZIKouu5wvApe0KI
         mS9Tc4wog2HYr1VYKNlAmf0UdJlxmBS/bmLebrfwwzimIm6GYA7XwaQiX9dALeHQeDg7
         Y/Nw==
X-Gm-Message-State: AOJu0YzDfbIpktobzEAiNPxerADRuzfZ4UL0wMgn6KcU2TYhvb5uPm3M
        k3FpYEE5mhy5YZupDUANywkDb+9bClToQMbXGIm3Yg==
X-Google-Smtp-Source: AGHT+IFXSrP5aeoWhs3Y4D0eNG10IP70i3n/QShH9gKSv775NDiMg4SU6zfUoxyYEuuq+a+adTKElsBDmpSGQ+aBEhI=
X-Received: by 2002:a81:e50c:0:b0:5ad:a3f9:1b10 with SMTP id
 s12-20020a81e50c000000b005ada3f91b10mr6688733ywl.10.1698598352517; Sun, 29
 Oct 2023 09:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231025103957.3776-1-keith.zhao@starfivetech.com>
 <20231025103957.3776-7-keith.zhao@starfivetech.com> <70805ff2-56a8-45e1-a31c-ffb0e84749e5@linaro.org>
 <3twc4zoohon7uujypgjtlnryfmebx4osvpykagnwr5nemmqz2w@w4vw55uswebh>
 <CAA8EJppxQ7J8DEDFsWzPL8bDpNW-KY0nhUA++zDBRpMCpP-bkA@mail.gmail.com> <344veqjvvwlo7vls2kdlgjggf77of2ijxwc2hmk7tarm75ugcs@bmozk23uqxqr>
In-Reply-To: <344veqjvvwlo7vls2kdlgjggf77of2ijxwc2hmk7tarm75ugcs@bmozk23uqxqr>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 29 Oct 2023 18:52:24 +0200
Message-ID: <CAA8EJpomaDoJVkq+_NhcxqOs6X-dFd=Vo9Wtqnp8egNaWzDH2Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] drm/vs: Add hdmi driver
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Keith Zhao <keith.zhao@starfivetech.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jagan Teki <jagan@edgeble.ai>,
        Rob Herring <robh+dt@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Shawn Guo <shawnguo@kernel.org>, christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 at 14:53, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Thu, Oct 26, 2023 at 11:57:22AM +0300, Dmitry Baryshkov wrote:
> > On Thu, 26 Oct 2023 at 11:07, Maxime Ripard <mripard@kernel.org> wrote:
> > >
> > > On Thu, Oct 26, 2023 at 01:23:53AM +0300, Dmitry Baryshkov wrote:
> > > > > +static int starfive_hdmi_register(struct drm_device *drm, struct starfive_hdmi *hdmi)
> > > > > +{
> > > > > +   struct drm_encoder *encoder = &hdmi->encoder;
> > > > > +   struct device *dev = hdmi->dev;
> > > > > +
> > > > > +   encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
> > > > > +
> > > > > +   /*
> > > > > +    * If we failed to find the CRTC(s) which this encoder is
> > > > > +    * supposed to be connected to, it's because the CRTC has
> > > > > +    * not been registered yet.  Defer probing, and hope that
> > > > > +    * the required CRTC is added later.
> > > > > +    */
> > > > > +   if (encoder->possible_crtcs == 0)
> > > > > +           return -EPROBE_DEFER;
> > > > > +
> > > > > +   drm_encoder_helper_add(encoder, &starfive_hdmi_encoder_helper_funcs);
> > > > > +
> > > > > +   hdmi->connector.polled = DRM_CONNECTOR_POLL_HPD;
> > > > > +
> > > > > +   drm_connector_helper_add(&hdmi->connector,
> > > > > +                            &starfive_hdmi_connector_helper_funcs);
> > > > > +   drmm_connector_init(drm, &hdmi->connector,
> > > > > +                       &starfive_hdmi_connector_funcs,
> > > > > +                       DRM_MODE_CONNECTOR_HDMIA,
> > > >
> > > > On an embedded device one can not be so sure. There can be MHL or HDMI
> > > > Alternative Mode. Usually we use drm_bridge here and drm_bridge_connector.
> > >
> > > On an HDMI driver, it's far from being a requirement, especially given
> > > the limitations bridges have.
> >
> > It's a blessing that things like MHL / HDMI-in-USB-C / HDMI-to-MyDP
> > are not widely used in the wild and are mostly non-existing except
> > several phones that preate wide DP usage.
>
> And those can be supported without relying on bridges.

Yes, they likely can, in the way that nouveau handles I2C TV encoders.
But I don't think this can scale. We can have different devices
attached to the DSI, LVDS, HDMI and even DP image sources. I don't see
a scalable solution for either of them. E.g. by switching drm/msm to
use panel bridges for DSI panels we were able to significantly unify
and simplify code paths.

> > Using drm_connector directly prevents one from handling possible
> > modifications on the board level. For example, with the DRM connector
> > in place, handling a separate HPD GPIO will result in code duplication
> > from the hdmi-connector driver. Handling any other variations in the
> > board design (which are pretty common in the embedded world) will also
> > require changing the driver itself. drm_bridge / drm_bridge_connector
> > save us from those issues.
>
> And we have other solutions there too. Like, EDIDs are pretty much in
> the same spot with a lot of device variations, but it also works without
> a common driver. I'd really wish we were having less bridges and more
> helpers, but here we are.
>
> > BTW: what are the limitations of the drm_bridge wrt. HDMI output? I'm
> > asking because we heavily depend on the bridge infrastructure for HDMI
> > output. Maybe we are missing something there, which went unnoticed to
> > me and my colleagues.
>
> A bridge cannot extend the connector state or use properties, for
> example. It works for basic stuff but falls apart as soon as you're
> trying to do something slightly advanced.

Ack. I agree, we didn't have a necessity to implement properties up to
now. But that sounds like an interesting topic for DSI-to-HDMI bridges
and HDCP support. I'll need to check if any of the RB3/RB5/Dragonboard
bridges are programmed with the HDCP keys.
--
With best wishes
Dmitry
