Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC4B7EDF3A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345109AbjKPLLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjKPLLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:11:17 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D617C1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:11:13 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a81ab75f21so7194587b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700133073; x=1700737873; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0RGeCL4pbInHPFxgrG6befW6cqWS0yz+u9JSBQ5zil0=;
        b=gjxhDLGWSA0JE16jF9pApn1Jp70KxDxg2RCrjNty/zslvg0Z/cxibsB7dvL6Ykcg+g
         v2lsUnhNnS3WhmHq5p7s5SMV+xfc5OMMNXbXxbd/SrEyXcOb8ZktcuZskgQScMV0TtqH
         D9G0WoG1TWHOwpXvQX0JbvBp6spSW/xhxdyIHbdBFY359AVxjniOZSoWHuIU73KhwaGs
         ztl73j9rSBc5Y7vgPWpRL6qgrar/TBtgwcwJqevMpZd11iEowU7n3N46pDVfu+7JHSiL
         ZczKo1aSKdQzU1V4kEpfPlcOqrXkdFW+l+UiTAZ3a16fX1SswTI8Mi0mYxkQjWleWg/n
         seDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700133073; x=1700737873;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0RGeCL4pbInHPFxgrG6befW6cqWS0yz+u9JSBQ5zil0=;
        b=A80X3g1cO/A9spTBwrLZP6wfpb/4TL20qKLuy9h8m84t6RT0Ct7h5rf2vew7r00Xid
         9iq1feTP4ehArRGWK89B9QDVEFJ0tkmlpuQjFvEdG4jZx9LXpUeSotUX4XXmLZBN8jvs
         QEXuNrpFHINphx2wXrZksddQWkayGQEcues7JHXYhfYeVHv1Zzn76AWqZ9zl4VkxxMbl
         uoS9Mjz56aI8roUi5DWT/jIMHrunVTE2jbeG55TI+zW6hZXm5kcuqJ+uF00qMpG7xOPB
         N2KwoWyFwIqoE9wgt2LNvxmVMqFJ6TgVmEnmNtDwk8RLlTzmHIsX0nltv/6Mn3wTfoWQ
         gQ+A==
X-Gm-Message-State: AOJu0YzTRtA8HTz6g7h1Clja2lMvlgXvTyd6CQFlwCwFXPDRiyg/+nWA
        7W2FBm+SIwGgdhplyiEObK/x+WyCIbMbatSRqqK5PA==
X-Google-Smtp-Source: AGHT+IFDnrrkc+6Nm8lx8gkkxzo53vg5vCzNzDQ4UR0BiVw1QwFwneAsH1tIZXYXEuKrRXeJmIubqNmURaGHwUUi8SQ=
X-Received: by 2002:a05:690c:368f:b0:5a8:960d:e538 with SMTP id
 fu15-20020a05690c368f00b005a8960de538mr4883776ywb.47.1700133072791; Thu, 16
 Nov 2023 03:11:12 -0800 (PST)
MIME-Version: 1.0
References: <20231114150130.497915-1-sui.jingfeng@linux.dev>
 <20231114150130.497915-9-sui.jingfeng@linux.dev> <CAA8EJprQq3aDhzE+yKGZ2-nsuHWcptzMvApsyOi9D63PgeiZ3w@mail.gmail.com>
 <50006160-f82b-4ec1-91a4-2ebbd7752e1d@linux.dev>
In-Reply-To: <50006160-f82b-4ec1-91a4-2ebbd7752e1d@linux.dev>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 16 Nov 2023 13:11:00 +0200
Message-ID: <CAA8EJpokxcO2qXgZ=+f=J+6EhAS_7KkrNJ_oZgk=RMHfv8riog@mail.gmail.com>
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

On Thu, 16 Nov 2023 at 12:29, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> Hi,
>
>
> On 2023/11/15 00:30, Dmitry Baryshkov wrote:
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
> If (next_bridge) is true, it says that the driver *already* known that
> it66121 have a next bridges attached. Then it66121 driver should certainly
> attach it, no matter what it is. Either a connector or another display bridge.
> It also says that this is a DT-based system on such a case. CallingWARN_ON(1) here helps to see(print) which DC driver is doing the wired
> things. Ok, I will remove the WARN_ON(1)  on the next version.

That's why I pointed you to WARN(). WARN_ON(1) gives no information to
the user. WARN() allows you to add a message.

-- 
With best wishes
Dmitry
