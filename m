Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973157D2B6A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbjJWHfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjJWHe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:34:57 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB2ED66
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:34:54 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d84c24a810dso2631182276.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698046494; x=1698651294; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UvVD2Vf14O9B8kXPrbE8pvJNizR2rdft4kqgfT1VWFE=;
        b=LtJOo4AuzXjlNlFDDQVqwpav2mjQc59OgKpZnwGYNkgn+vCbCA8atpRerqteQneY5U
         0qd43o3G5/cLoYdbH60DEWsvUQKazl3Od7xmaLc6DedvzuMW65fTmy+kWRPv7z3UrUVQ
         QKBOhO1Lf47d9IqP4cc8sCP01V++oDZ//AiOcp0+XyLEBabMMA1ZWjAgNlQRsB0hHRty
         +xbDv19Wygi+ZIqfF2pGm7/5GIMNNv/mrsJgs++XeaxIfCEuLiQTYse2pjWn2LrrqOnv
         iBxgiWsGOJZx669H3brO7oaFh09+D7wQ93pdZ2N6lx6kw+m2KVit//nY0Mzi6jZasMNR
         IVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698046494; x=1698651294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvVD2Vf14O9B8kXPrbE8pvJNizR2rdft4kqgfT1VWFE=;
        b=HSefYpTw2g18tTCeEmLM/5oavaAFxpOHKwCoJ7iVdyX5J9F7UxV4BYp3eZlAY+QVsf
         oFi9EOtzWVgkB/iZ4oYrUnnUrOgxTKW9CPpIkxqRsfskCVFw/co093t2K2HeAFOVR8WP
         QGEgmicgc8H7bpy8tfZwnlIJcvSJG0K+NSi+DD3fNuc2SLdI7zuMDRYvZP7b4otEKF/R
         9pEBMzfFRUk8kC8ijWIt+Cwn9uSVYtnJFHYM02Xp2IqOVog9aMZLix6iW3FAxbglyuo8
         ga83wUdWv/bUIRszPuRVPT2PBr04uFEH5+BQ7ZLQD2vN/vILRjIN+0IFSDP/NXpU6fkG
         kvCw==
X-Gm-Message-State: AOJu0Yyc34gEHkTmFDozrvRbM/eKCj5dwzskGWKsyZriEXUlxsC7OWi7
        q+AdPQRo1sn+d9Y4TH7eXQrQgJu7cOj/RsYMfWNE8w==
X-Google-Smtp-Source: AGHT+IGt4nAtdDC++hWsqIdRPEhfnV6IkoVyNUDdWcAokDPoR0GkAGPsVz/zRYARQaZVEGGI2zP0FgmKWac6//hONDM=
X-Received: by 2002:a5b:9d2:0:b0:d9a:47a7:f7c1 with SMTP id
 y18-20020a5b09d2000000b00d9a47a7f7c1mr7713291ybq.42.1698046493712; Mon, 23
 Oct 2023 00:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231016165355.1327217-1-dmitry.baryshkov@linaro.org>
 <1907377.IobQ9Gjlxr@steina-w> <CAA8EJpoN36PHoZH=Osfn_wr7kO-dypius2ae_FuJ4Hk+gjeBtQ@mail.gmail.com>
 <1871104.tdWV9SEqCh@steina-w>
In-Reply-To: <1871104.tdWV9SEqCh@steina-w>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 23 Oct 2023 10:34:42 +0300
Message-ID: <CAA8EJpofiawC5z3jw1-TsxS+ZWz4QobCby3kScDDdk9Z-74mgQ@mail.gmail.com>
Subject: Re: [RFC PATCH 03/10] drm/mipi-dsi: add API for manual control over
 the DSI link power state
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Marek Vasut <marex@denx.de>, Robert Foss <rfoss@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-arm-msm@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 at 09:52, Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi Dmitry,
>
> Am Sonntag, 22. Oktober 2023, 12:49:41 CEST schrieb Dmitry Baryshkov:
> > On Thu, 19 Oct 2023 at 14:42, Alexander Stein
> >
> > <alexander.stein@ew.tq-group.com> wrote:
> > > Hi,
> > >
> > > Am Donnerstag, 19. Oktober 2023, 13:19:51 CEST schrieb Dmitry Baryshkov:
> > > > On Thu, 19 Oct 2023 at 12:26, Maxime Ripard <mripard@kernel.org> wrote:
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
> > > > the DSI link to setup the device. Next, some of the DSI hosts have
> > > > limitations on sending the commands. The proverbial sunxi DSI host can
> > > > not send DSI commands after the video stream has started. Thus most of
> > > > the panels have opted to send all DSI commands from pre_enable (or
> > > > prepare) callback (before the video stream has started).
> > > >
> > > > However this leaves no good place for the DSI host to power up the DSI
> > > > link. By default the host's pre_enable callback is called after the
> > > > DSI bridge's pre_enable. For quite some time we were powering up the
> > > > DSI link from mode_set. This doesn't look fully correct. And also we
> > > > got into the issue with ps8640 bridge, which requires for the DSI link
> > > > to be quiet / unpowered at the bridge's reset time.
> > >
> > > There are also bridges (e.g. tc358767) which require DSI-LP11 upon bridge
> > > reset. And additionally this DSI-(e)DP bridge requires LP11 while
> > > accessing
> > > DP-AUX channel, e.g. reading EDID. So bridges need at least some control
> > > over DSI line state.
> >
> > For sending commands in LP11 it is typical to toggle the
> > MIPI_DSI_MODE_LPM flag, for example see panel-=jdi-lt070me05000.c or
> > some other drives. It might be a good idea to make that more explicit.
> > All suggestions here would be appreciated.
>
> The biggest difference between that display and the tc358767 bridge is that
> the display uses DSI commands, while the bridge is using i2c transfer to issue
> DP-AUX commands. There is no host_transfer [1] which would enable LP-11.
> It seems this DSI-DP bridge requires LP-11/HS on DSI lanes all times. This
> contradicts current Linux behaviour.

I see. I took a quick glance at the driver. Does the device mark AUX
as busy when there is a HS transfer?
Because otherwise it might be pretty hard to synchronise DP-AUX
transfers with the DSI link state. We might need to add an API for
this, if the DSI hosts actually can signal the blanking / DSI LP.

Side note: the driver needs some care. It doesn't support the aux-bus
bindings for eDP panels, it doesn't support other bridges on top of DP
connectors (but there can be e..g. dp-connector device).

>
> Best regards,
> Alexander
>
> [1] https://www.kernel.org/doc/html/latest/gpu/drm-kms-helpers.html#mipi-dsi-bridge-operation


-- 
With best wishes
Dmitry
