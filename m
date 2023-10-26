Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA257D7EB1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjJZIlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjJZIlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:41:50 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74F218D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:41:46 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a7ac4c3666so4553247b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698309706; x=1698914506; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/VZIAdjrhXZ5QafqMeZ1Ozgnq7kYuBpDdNEjKCunMHk=;
        b=OAWyAF2VwoB0ijemsFc8PLzPUZfw0BFBZINN4EbYCneRQ7diwZeTRUxV1DZoZUBa8Z
         a3oI2Uq/7gtYRZTldBgUwXAKVyfaO1TMi0gFG9DePJHVvn74Dsozi/xBjR5KjQAdtm0K
         BtTtlUXwIKFqdpx5Vv1YdoaCw9uXAeKAGn/2WMpnVv2113p6zKrFFNbca7OFoptDvYi5
         I4OS1QjgzB9VyQHjpysVMD07XsOvu4hIy+kI0DVP1vSpdk550rad3tTO4OFUZy1xsjVj
         Z3qsxU+XFd4b4/3S/l5PwkMB5SlCfuYFJPjYHR9EIF/RCkssMckICRu9xipxeFPKR5un
         gamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698309706; x=1698914506;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/VZIAdjrhXZ5QafqMeZ1Ozgnq7kYuBpDdNEjKCunMHk=;
        b=NsQ77bb+VVt4NqJk8FcgXhI4Dq5oprNC3TldeWSHK8a7JoS+WubrAJaDqwJsFngVgf
         xc+uT9zVikhXybyFojLBXWvS7X2KI0Nw5NT1L2MHVkR7ADT2gkBLWXxHZG8nLUeeG53D
         4uW6NuGmgjbmWtJz8EmyGwP98XNvrNg0zTYjarjGNLLPcoAkOFYWUpljYEYJyn0TOwlx
         3Aor1MbUyBc50eBO52aPzvuZv8AIZlI6OPofo+8Mddq3lv67Fq/xaTy3VCUppKKA9+dr
         7rRUoh7CnOdWCxibZwuGofXU3QV8r+eN9ThQGgoBeEFuUPx/AtKvlxRBroJn47iiGxR9
         CHKg==
X-Gm-Message-State: AOJu0YwhN6I9Pn0fWCzu6aLmmgOzJWZYDswv04ab/G0PKs/bYgh4o+qk
        gP7khQwgmkzezvj9jSgF1q7TLoSr0zTOwdTjapBAMQ==
X-Google-Smtp-Source: AGHT+IGjlEPz9ZfZy5VliCCpb5XIJ3AzbfqvfdyV/KHCNAk/IrIlOqwWdTwDb1N8pJ7KnvWoH8J0L1+1Wqv7cupjzfI=
X-Received: by 2002:a81:8441:0:b0:5a7:ba09:e58b with SMTP id
 u62-20020a818441000000b005a7ba09e58bmr20064553ywf.14.1698309705935; Thu, 26
 Oct 2023 01:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231016165355.1327217-1-dmitry.baryshkov@linaro.org>
 <20231016165355.1327217-4-dmitry.baryshkov@linaro.org> <7e4ak4e77fp5dat2aopyq3g4wnqu3tt7di7ytdr3dvgjviyhrd@vqiqx6iso6vg>
 <CAA8EJpp48AdJmx_U=bEJZUWZgOiT1Ctz6Lpe9QwjLXkMQvsw5w@mail.gmail.com>
 <uj6rtlionmacnwlqxy6ejt5iaczgbbe5z54ipte5ffbixcx3p4@pps7fcr3uqhf>
 <1696f131-83fb-4d0c-b4d7-0bdb61e4ae65@linaro.org> <mxtb6vymowutj7whbrygwlcupbdnfqxjralc3nwwapsbvrcmbm@sewxtdslfoen>
In-Reply-To: <mxtb6vymowutj7whbrygwlcupbdnfqxjralc3nwwapsbvrcmbm@sewxtdslfoen>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 26 Oct 2023 11:41:34 +0300
Message-ID: <CAA8EJpozZkEswnioKjRCqBg4fcjVHFwGivoFNTNHVwyocKprQw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 at 11:04, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Wed, Oct 25, 2023 at 06:16:14PM +0300, Dmitry Baryshkov wrote:
> > On 25/10/2023 15:44, Maxime Ripard wrote:
> > > On Thu, Oct 19, 2023 at 02:19:51PM +0300, Dmitry Baryshkov wrote:
> > > > On Thu, 19 Oct 2023 at 12:26, Maxime Ripard <mripard@kernel.org> wrote:
> > > > >
> > > > > On Mon, Oct 16, 2023 at 07:53:48PM +0300, Dmitry Baryshkov wrote:
> > > > > > The MIPI DSI links do not fully fall into the DRM callbacks model.
> > > > >
> > > > > Explaining why would help
> > > >
> > > > A kind of explanation comes afterwards, but probably I should change
> > > > the order of the phrases and expand it:
> > > >
> > > > The atomic_pre_enable / atomic_enable and correspondingly
> > > > atomic_disable / atomic_post_disable expect that the bridge links
> > > > follow a simple paradigm: either it is off, or it is on and streaming
> > > > video. Thus, it is fine to just enable the link at the enable time,
> > > > doing some preparations during the pre_enable.
> > > >
> > > > But then it causes several issues with DSI. First, some of the DSI
> > > > bridges and most of the DSI panels would like to send commands over
> > > > the DSI link to setup the device.
> > >
> > > What prevent them from doing it in enable when the link is enabled?
> > >
> > > > Next, some of the DSI hosts have limitations on sending the commands.
> > > > The proverbial sunxi DSI host can not send DSI commands after the
> > > > video stream has started. Thus most of the panels have opted to send
> > > > all DSI commands from pre_enable (or prepare) callback (before the
> > > > video stream has started).
> > >
> > > I'm not sure we should account for a single driver when designing a
> > > framework. We should focus on designing something sound, and then making
> > > that driver work with whatever we designed, but not the other way
> > > around. And if we can't, we should get rid of that driver because it's
> > > de-facto unmaintainable. And I'm saying that as the author of that
> > > driver.
> >
> > That's not the only driver with strange peculiarities. For example, see
> > commit 8a4b2fc9c91a ("drm/bridge: tc358762: Split register programming from
> > pre-enable to enable"), which was one of the issues that actually prompted
> > me to send this this patchset (after my previous version of this patch being
> > rejected because of sunxi).
>
> The datasheet for that bridge is available so at least we can try to fix
> it (and bridges are much simpler than controllers anyway). It's not
> something we can do with the sunxi driver.
>
> > > > However this leaves no good place for the DSI host to power up the DSI
> > > > link. By default the host's pre_enable callback is called after the
> > > > DSI bridge's pre_enable. For quite some time we were powering up the
> > > > DSI link from mode_set. This doesn't look fully correct.
> > >
> > > Yeah, it's not.
> > >
> > > > And also we got into the issue with ps8640 bridge, which requires for
> > > > the DSI link to be quiet / unpowered at the bridge's reset time.
> > > >
> > > > Dave has come with the idea of pre_enable_prev_first /
> > > > prepare_prev_first flags, which attempt to solve the issue by
> > > > reversing the order of pre_enable callbacks. This mostly solves the
> > > > issue. However during this cycle it became obvious that this approach
> > > > is not ideal too. There is no way for the DSI host to know whether the
> > > > DSI panel / bridge has been updated to use this flag or not, see the
> > > > discussion at [1].
> > >
> > > Yeah. Well, that happens. I kind of disagree with Neil here though when
> > > he says that "A panel driver should not depend on features of a DSI
> > > controller". Panels definitely rely on particular features, like the
> > > number of lanes, the modes supported, etc.
> >
> > In the mentioned discussion it was more about 'DSI host should not assume
> > panel driver features', like the panel sending commands in pre_enable or
> > not, or having pre_enable_prev_first.
> >
> > So the pre_enable_prev_first clearly lacks feature negotiation.
> >
> > > Panels shouldn't depend on a particular driver *behaviour*. But the
> > > features are fine.
> > >
> > > For our particular discussion, I think that that kind of discussion is a
> > > dead-end, and we just shouldn't worry about it. Yes, some panels have
> > > not yet been updated to take the new flags into account. However, the
> > > proper thing to do is to update them if we see a problem with that (and
> > > thus move forward to the ideal solution), not revert the beginning of
> > > that feature enablement (thus moving away from where we want to end up
> > > in).
> > >
> > > > Thus comes this proposal. It allows for the panels to explicitly bring
> > > > the link up and down at the correct time, it supports automatic use
> > > > case, where no special handling is required. And last, but not least,
> > > > it allows the DSI host to note that the bridge / panel were not
> > > > updated to follow new protocol and thus the link should be powered on
> > > > at the mode_set time. This leaves us with the possibility of dropping
> > > > support for this workaround once all in-kernel drivers are updated.
> > >
> > > I'm kind of skeptical for these kind of claims that everything will be
> > > automatic and will be handled fine. What if we have conflicting
> > > requirements, for example two bridges drivers that would request the
> > > power up at different times?
> >
> > Well, we do not support DSI sublinks, do we?
>
> No, but we start to consider adding support for muxes for example. A DSI
> mux + a DSI bridge behind it might trigger that behaviour, even if we
> don't support sublinks.

Ack.

>
> > > Also, we would still need to update every single panel driver, which is
> > > going to create a lot of boilerplate that people might get wrong.
> >
> > Yes, quite unfortunately. Another approach that I have in mind is to add two
> > callbacks to mipi_dsi_device. This way the DSI host will call into the
> > device to initialise it once the link has been powered up and just before
> > tearing it down. We solve a lot of problems this way, no boilerplate and the
> > panel / bridge are in control of the initialisation procedure. WDYT?
> >
> > > I have the feeling that we should lay out the problem without talking
> > > about any existing code base first. So, what does the MIPI-DSI spec
> > > requires and what does panels and bridges expect?
> >
> > There is not that much in the DSI spec (or maybe I do not understand the
> > question). The spec is more about the power states and the commands. Our
> > problem is that this doesn't fully match kernel expectations.
>
> You're explicitly asking for comments on that series. How can we provide
> any comment if you're dead-set on a particular implementation and not
> explain what the problem you are trying to solve is?

Ah, excuse me. I thought that I explained that in the cover letter.

DSI device lifetime has three different stages:
1. before the DSI link being powered up and clocking,
2. when the DSI link is in LP state (for the purpose of this question,
this is the time between the DSI link being powered up and the video
stream start)
3. when the DSI link is in HS state (while streaming the video).

Different DSI bridges have different requirements with respect to the
code being executed at stages 1 and 2. For example several DSI-to-eDP
bridges (ps8640, tc358767 require for the link to be quiet during
reset time.
The DSI-controlled bridges and DSI panels need to send some commands
in stage 2, before starting up video

In the DRM subsystem stage 3 naturally maps to the
drm_bridge_funcs::enable, stage 1 also naturally maps to the
drm_bridge_funcs::pre_enable. Stage 2 doesn't have its own place in
the DRM call chain.
Earlier we attempted to solve that using the pre_enable_prev_first,
which remapped pre-enable callback execution order. However it has led
us to the two issues. First, at the DSI host driver we do not know
whether the panel / bridge were updated to use pre_enable_prev_first
or not. Second, if the bridge has to perform steps during both stages
1 and 2, it can not do that.

I'm trying to find a way to express the difference between stages 1
and 2 in the generic code, so that we do not to worry about particular
DSI host and DSI bridge / panel peculiarities when implementing the
DSI host and/or DSI panel driver.

Last, but not least, we currently document that it is fine to call DSI
transfer functions at any point during the driver's life time (at
least that was the interpretation that we have agreed in the
DSI-related threads). It has its own drawbacks for the DSI host
drivers. The hosts have to deal with the DSI commands being sent at
the different times, when the host is fully powered down, when it is
running in the LP mode and when it is fully running and streaming
video. By defining DSI lifetime more precisely, we can limit the
period when the DSI commands can be legitimately sent, simplifying DSI
host drives.

> Thinking more about it, I'm even more skeptical about the general
> approach that this should be implemented at the bridge level (or in
> KMS).
>
> It looks to me that this is very much a bus problem. USB device drivers
> also require the bus to be powered and generally available to send data
> to their device, and you don't fix that up in the HID or storage
> drivers, you make the bus behave that way.
>
> What prevents us from fixing it at the bus level?

Yes, this can also be possible. Do you mean adding code / callbacks to
struct mipi_dsi_device ?

-- 
With best wishes
Dmitry
