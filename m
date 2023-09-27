Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644387B0DE5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 23:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjI0VLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 17:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0VL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:11:28 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679F811D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 14:11:26 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-59c0b9ad491so149305197b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 14:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695849085; x=1696453885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a74pdDrZrdwlkEh28Y630eaCwo/I4QCGA/VwQZGH4Q8=;
        b=w3S261RXkbxuTnKGHxar5fWqqbhsfPc8nWnQkHX5ckHiXPcWyW0UyltkObP4Ymi+Jf
         zmw6im0v2W6cvkpdJYXuGE2Y1bOK93S2b7Gk7mOZQDLumCcIqscp/kbGL2QkXjq4CQOV
         S/QSat/6sX9b9JE+wgJzB/udT6OJm9OyI9CoXm5fJ0sSEbo3FL0o4Vbr0J3nw1tJrPmO
         OQo+0srmdjybzmS6XgCl3wGWNaZuFGv7egILpcpXC0ov+bdyRAB4+llPrAZXnJrqDrne
         BZoRHF7tJ/v9YrI00s1D13nTEZw09ybPDfj6leVAGZ2NrztIorzPJXFSs4113s6TMp7R
         obZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695849085; x=1696453885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a74pdDrZrdwlkEh28Y630eaCwo/I4QCGA/VwQZGH4Q8=;
        b=cdhrXyxjMav9bCJPfec567ZkK7gnMnBeD6IZlIAJgvItB64FoM0YB4PF1m5A3HYW/V
         1P20VujASrN5f9rC2PFM2/8/sAE0qVBwNSvq1RJVyXCAVt8SVET3duGSlbY/0ZydZkuO
         zkdyxh6pTgPKpd1tR5QSWfpDfR4OMhFQYEifuS4ZtKgQCIdFvMmtCSiPXOjsm75cu7IG
         HkqDB3EWZZ5HsDXZAdLYSBKQq8LS/0+GPlrapK7TMRW07CxBShPkvjFOsWoI/+X9p4DN
         eg8YxIBv9iWBpHNRaYD+81YMSVhT25bHzLCvhEG0gI/BhgwuQtF7p4Q5fL4/5o+sVHdj
         Ul1Q==
X-Gm-Message-State: AOJu0YzE715DsiN1C91tti9KQVNKEQR9P0jGEJU0zHApA0wi2Z+09UA7
        XmvVEr2n5a4kaxgQgTHXn1BcuAHySZdX7ZOUmnV8Rg==
X-Google-Smtp-Source: AGHT+IH67numDaxZxD54zJxyc373zfgNCr6bHhLpTmrffYZJw6Y61+w8l7XIlNFAtKDeQo92EdTus8ziHzjBuyteBp8=
X-Received: by 2002:a0d:dcc1:0:b0:59e:9fbc:a16c with SMTP id
 f184-20020a0ddcc1000000b0059e9fbca16cmr3335409ywe.35.1695849085295; Wed, 27
 Sep 2023 14:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <1695848028-18023-1-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1695848028-18023-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 28 Sep 2023 00:10:18 +0300
Message-ID: <CAA8EJpodnwS7nLupewLJfmGw6HhVSpFj=EGxSp4gKXDwtLw2QA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] incorporate pm runtime framework and eDP clean up
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, 27 Sept 2023 at 23:54, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> Incorporate pm runtime framework into DP driver and clean up eDP
> by moving of_dp_aux_populate_bus() to probe().

Dear Kuogee. Let me quote my response to v1 of your series:

Please use sensible prefix for cover letters too. It helps people
understand, which driver/area is touched by the patchset.

This is v4 already and the cover letter still has the same subject line.
If you are ignoring the review comments, should I start ignoring your patches?

>
> Kuogee Hsieh (8):
>   drm/msm/dp: tie dp_display_irq_handler() with dp driver
>   drm/msm/dp: rename is_connected with link_ready
>   drm/msm/dp: use drm_bridge_hpd_notify() to report HPD status changes
>   drm/msm/dp: move parser->parse() and dp_power_client_init() to probe
>   drm/msm/dp: incorporate pm_runtime framework into DP driver
>   drm/msm/dp: delete EV_HPD_INIT_SETUP
>   drm/msm/dp: add pm_runtime_force_suspend()/resume()
>   drm/msm/dp: move of_dp_aux_populate_bus() to eDP probe()
>
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c |   4 -
>  drivers/gpu/drm/msm/dp/dp_aux.c         |  40 +++-
>  drivers/gpu/drm/msm/dp/dp_display.c     | 341 +++++++++++---------------------
>  drivers/gpu/drm/msm/dp/dp_display.h     |   3 +-
>  drivers/gpu/drm/msm/dp/dp_drm.c         |  14 +-
>  drivers/gpu/drm/msm/dp/dp_power.c       |  16 --
>  drivers/gpu/drm/msm/dp/dp_power.h       |  11 --
>  drivers/gpu/drm/msm/msm_drv.h           |   5 -
>  8 files changed, 161 insertions(+), 273 deletions(-)
>
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
