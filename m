Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6F57B0EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 00:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjI0WFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 18:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI0WFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:05:43 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECE5AF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:05:41 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-59eb8ec5e20so149828247b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695852340; x=1696457140; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CNs9Uy0sZIcXogJDKuzAoviMSMHPVfDjWIe9eamVRQE=;
        b=rf8g9OXS/oQoEFEXXB2zV9m5e/4cb13RHHUf3gEEj70UJR1deKo01vC48RGyOCeqDU
         Q942J5yGADD9nFPRtMzd3AAnW11czyimawbD4wKhC2k+LBCwgPDdtIR2nam0UXG8AKJ+
         rBXg3jTADlUJJUpz8ClVl+gqgtj2UxLrXG0go9jmrh+Y6a1zr+eT80sMdlF5zQfI8dR9
         SSenLoSTjOc/VquA3KXVQjgO0lN+6K8bVk6uWxaTqroJycEX/Ygb1RSR5BvF6HMBuUMv
         wfdF7EUpdpVZJGQbcm0tRxE1RjeTZteTairpRY2xDCpX+voJTRDQSt/Z12LFKKn9U+bA
         lIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695852340; x=1696457140;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNs9Uy0sZIcXogJDKuzAoviMSMHPVfDjWIe9eamVRQE=;
        b=X03Ntoynn/flPu1D85/faUgTZLpqbsCIjZ49dsxCfJedKNVa/XCoksIvedA9vhYhhe
         dGyMQrOwvcCZsKV9gZhmrcufxLTIEeMKHtZQSAPzRlsmPJf2rn4Ok2zr+ZVLFq5lCCg3
         sZKgoBjp67yYC5gwV7iRuQLk1L/nTbgeYrHgco7ZejGAHOP76ooYi9DM//wNeCRMQVli
         SAVy2I7tDR1zOqGzN0AqmrmJTRL+VvflKjoIJCRpdtlt6VRs3jCPg89qx07m+nKv2qW6
         aXiAEF+GyUCAnIiAkaj6lh4PftZPD2opdyEuMcva88yWjDV5cGyX+/lFm8x7h6WanSk0
         TRwA==
X-Gm-Message-State: AOJu0YwKaObqBZWRLLJGUrRDaq6fDe8yUCjpEbtgkPpLRozzX7HuPyS2
        KgwlWeGVjRra6q1A0hAh9j2HMZZfcX5SA/yRSU/ydg==
X-Google-Smtp-Source: AGHT+IHR+moAslgN5T2iYRiOJljTYTXI9au6Nrv8poHtrZJxnq88ULiQGkND2FasIyvPuzQVl0Il+NK5ZQcIELMzmQs=
X-Received: by 2002:a81:9186:0:b0:59f:4c52:2f51 with SMTP id
 i128-20020a819186000000b0059f4c522f51mr3574047ywg.17.1695852340711; Wed, 27
 Sep 2023 15:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <1694813901-26952-1-git-send-email-quic_khsieh@quicinc.com>
 <1694813901-26952-7-git-send-email-quic_khsieh@quicinc.com>
 <CAA8EJpqPXoFX4LXyXYgfh07Vpxg-KgD8VBR6x5bXf4GOJmbOtw@mail.gmail.com>
 <2f98d5f1-57c1-d9fe-cb1c-b975db057287@quicinc.com> <CAA8EJpr2wRq6Txi7YAQpJKa_9UGqH_nmHzvVOaAPkwOrtDg4Tw@mail.gmail.com>
 <CAE-0n53dqHONzMTd_ZC-fKWTzDVq6Wqwo4OFZMUcghZ5SD5RhA@mail.gmail.com>
 <65566a68-3510-2e5f-7d57-e4dba08c008c@quicinc.com> <1d9bf80d-0267-937b-4dd9-c57db7a89cb4@quicinc.com>
 <CAE-0n51Hrs66oG4NF5rDETkVO-ocG_6_=Aqc5cE-qPDViSgKyA@mail.gmail.com>
In-Reply-To: <CAE-0n51Hrs66oG4NF5rDETkVO-ocG_6_=Aqc5cE-qPDViSgKyA@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 28 Sep 2023 01:04:31 +0300
Message-ID: <CAA8EJppNSS-ZUoJRbLaO7XHr+69Th6ANU5KGrnbj8eWGyGFQDw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] drm/msm/dp: add pm_runtime_force_suspend()/resume()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, dianders@chromium.org, vkoul@kernel.org,
        daniel@ffwll.ch, airlied@gmail.com, agross@kernel.org,
        andersson@kernel.org, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sept 2023 at 01:01, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Kuogee Hsieh (2023-09-25 09:07:18)
> >
> > On 9/22/2023 6:35 PM, Abhinav Kumar wrote:
> > >
> > > Doing link training when we get hpd instead of atomic_enable() is a
> > > design choice we have been following for a while because for the case
> > > when link training fails in atomic_enable() and setting the link
> > > status property as you mentioned, the compositor needs to be able to
> > > handle that and also needs to try with a different resolution or take
> > > some other corrective action. We have seen many compositors not able
> > > to handle this complexity. So the design sends the hotplug to usermode
> > > only after link training succeeds.
> > >
> > > I do not think we should change this design unless prototyped with an
> > > existing compositor such as chrome or android at this point.
> > >
> > > Thanks
> > >
> > > Abhinav
> >
> >
> > We did perform link training at atomic_enable() at eDP case since we can
> > assume link training will always success without link rate or link lane
> > being reduced.
> >
> > However for external DP case, link training can not be guarantee always
> > success without link rate or lane being reduced as Abhinav mentioned.
> >
> > In addition,  CTS (compliance test) it required to complete link
> > training within 10ms after hpd asserted.
>
> Is it possible to change that timeout? I have to look around for the CTS
> parameters because I'm pretty confused how it can work. What do we do if
> DP wakes the system from suspend and asserts HPD? We need resume time to
> be < 10ms?  That's not realistic.
>
> >
> > I am not sure do link training at atomic_enable() can meet this timing
> > requirement.
> >
>
> At least in the DP spec itself it doesn't require the link to be trained
> within 10ms of HPD being asserted. Instead it simply recommends that the
> OS start configuring the display promptly after HPD is asserted, e.g.
> within 100ms. There's some strict timing on IRQ_HPD, so the driver must
> read DPCD registers within 100ms of IRQ_HPD rising edge; maybe that is
> what CTS is checking for?
>
> TL;DR: I don't see why CTS should stop us from link training in
> atomic_enable(). It would be beneficial to do so to make eDP and DP the
> same. It would also help to report a drm connector being connected
> _before_ link training so that userspace knows the link itself is the
> bad part of the equation (and not that the DP connector looks
> disconnected to userspace when in fact it really is connected and the
> monitor is asserting HPD, just the link training failed).

Also this will move us closer to i915 user experience: failing link
training in the display enablement part. So that a part of xrandr
calls can retry link training.

-- 
With best wishes
Dmitry
