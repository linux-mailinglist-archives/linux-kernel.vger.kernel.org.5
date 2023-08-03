Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EE276EEA2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237239AbjHCPuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237233AbjHCPuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:50:01 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BBC2690
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:50:00 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d35a9d7a5bdso1176013276.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 08:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691077799; x=1691682599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+4Wzr5DVMlZc1pH6QeuSNiApXly7C56WNxj8x1bVeY=;
        b=gzhMq4KPHvG6ZhunE/V3Y0xg8sylBue0aRsl06ODKlaEdf3szqY3SrKaupRovtgbEK
         gKga/H3lpF5ch1m5g1NEqcopsbgdHkGl2WoU7JzehexLVIizdIATMrp2SFRGWJruTrgg
         UBpbPjc05NN313xxV3WERtnbE/ed1k0uf4DrRFCRJd0+CPiz8VPjLjOBvAPxK821Flhk
         e4owjgBBtLtSqSibLWbbtcOCQ7uf7nzrlQSmj8ZdqZ1Ja+buMt93gdzCs8MLM3T48sZc
         WdO4MuDaut0np4XNQJx7tR5vIYqV3rSpdNmLkqisODn+QLJbe6KUROS5fwxkIpvd+kUL
         mNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691077799; x=1691682599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+4Wzr5DVMlZc1pH6QeuSNiApXly7C56WNxj8x1bVeY=;
        b=k335VPDOd4O3c+p6EVVpETMS67xth6OrOA6npi852pRnEytpHj7HrVPQRsN6LFZYpo
         lpX84dREJiRJtiD9Twq9U6IpRbZ1016JPaYRxiFF0sDOa/L8yRY1eOxnz/3haU7YCIg1
         mpebV3nZtTm6bxIm3s0uqBlH7evioUb3RzaUdfpIbX7c9LtYsHv6T1esoTiPnIwJB+Pm
         gt1Ws6EI3CpSW64N9snigTn/Upu/d3/FoHlO3zJh1SJIwad4nabc1PO6N2iKDsKwlGjI
         zzcAEBQO0KLnYvLPF6nXNFvNR0BFBHw7fK/9UTz5DGkSYw5FsWM5a+cIMFxd79Jn/slP
         Bp4g==
X-Gm-Message-State: ABy/qLasjvbkwZSUNfvhbSL/Lee9W+c7cZF8nWTHbDNE6HfqZHHSxN6O
        nx/YvUjpvzteI3eAKAdNXeUDuYsgO+SyyhNzawJEwQ==
X-Google-Smtp-Source: APBJJlGqe5OwfFXTkIX8KjflNZxLCJaBlCJcozkLSMt9bNI1VvyZ4ueyHK5KDKBhNWN4ugZ27MKACXtQew4zW6psAas=
X-Received: by 2002:a25:2386:0:b0:cae:d40f:5934 with SMTP id
 j128-20020a252386000000b00caed40f5934mr18670211ybj.27.1691077799474; Thu, 03
 Aug 2023 08:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230729004913.215872-1-dmitry.baryshkov@linaro.org>
 <20230729004913.215872-4-dmitry.baryshkov@linaro.org> <20230802185547.GC32500@pendragon.ideasonboard.com>
 <a32ce695-038f-0ef8-3584-5bd1ba528131@linaro.org> <20230802191351.GA1407@pendragon.ideasonboard.com>
 <DE2B4523-D16C-4AFC-8352-212B23548DD5@linaro.org> <b6oOVz2YMIG4hJDWhq9lTh6R2HYcrpRwHENhplig9KSQMD8dIjTgC5KdH1Ij3URgV2HESp67Ax7QUsByGjMLouvbs-5q7PiPRdLkgJz6Fwk=@emersion.fr>
 <ADjuOeqA6575DKutMPaR9mW9rLhm-wjLc4ruoUkNwImf-GB90FdwDB7v7y6LFdzVG3BC4R52A0RUtStK4_smmGYTUs3UPDOX4T4Zl2YHkxE=@emersion.fr>
 <CAA8EJppCECObEe5UG3LsHUsmYfKzakWzVw33S4nVc=DB9sA0ig@mail.gmail.com> <C-Fu9j3hts_YcQxukEbidrKyTdqYNxYuWUX-694HnmYKiJGZip24s6R8-dULdTvb2VE972he3PZlju2K9wFNkA9j-XKUGemuWiFLGT1eUu0=@emersion.fr>
In-Reply-To: <C-Fu9j3hts_YcQxukEbidrKyTdqYNxYuWUX-694HnmYKiJGZip24s6R8-dULdTvb2VE972he3PZlju2K9wFNkA9j-XKUGemuWiFLGT1eUu0=@emersion.fr>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 3 Aug 2023 18:49:48 +0300
Message-ID: <CAA8EJpqvTV8yhf-xC5vbRuzhNjQ2qp5yxhTWWN6AdxX1-+JszA@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/uapi: document the USB subconnector type
To:     Simon Ser <contact@emersion.fr>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Janne Grunau <j@jannau.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2023 at 18:43, Simon Ser <contact@emersion.fr> wrote:
>
> On Thursday, August 3rd, 2023 at 17:36, Dmitry Baryshkov <dmitry.baryshko=
v@linaro.org> wrote:
>
> > On Thu, 3 Aug 2023 at 18:31, Simon Ser contact@emersion.fr wrote:
> >
> > > On Thursday, August 3rd, 2023 at 17:22, Simon Ser contact@emersion.fr=
 wrote:
> > >
> > > > The KMS docs describe "subconnector" to be defined as "downstream p=
ort" for DP.
> > > > Can USB-C (or USB) be seen as a DP downstream port?
> > >
> > > To expand on this a bit: I'm wondering if we're mixing apples and
> > > oranges here. The current values of "subconnector" typically describe
> > > the lower-level protocol tunneled inside DP. For instance, VGA can be
> > > tunneled inside the DP cable when using DP =E2=86=92 VGA adapter.
> >
> > My opinion hasn't changed: I think this should be the USB connector
> > with proper DP / DVI / HDMI / etc. subconnector type (or lack of it).
> > In the end, the physical connector on the side of laptop is USB-C.
>
> - Even if the connector is USB-C, the protocol used for display is
>   still DP. There's also the case of Thunderbolt.

Yes. But the connector type is not about the protocol.

> - This is inconsistent with existing drivers. i915 and amdgpu expose
>   DP ports for their USB-C ports. Changing that isn't possible without
>   causing user-space regressions (compositor config files use the
>   connector type).

Yes, I know. Consider my phrase as a personal opinion or minority report.

I think that using DisplayPort for USB-C connectors was a mistake,
which we now have to cope with somehow.

--=20
With best wishes
Dmitry
