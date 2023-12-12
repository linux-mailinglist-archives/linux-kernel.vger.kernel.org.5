Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D9280E4E2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjLLHWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLLHWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:22:23 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28963AB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 23:22:30 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso4002309276.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 23:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702365749; x=1702970549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ChpZ3DTwNnea6UJpvxUIWDuGDG5RPxpXSi/vdcH9wOY=;
        b=ZpcYCXpgaS0nLQFxj/3wp6tAftsFVd0CEzfOPnlaR/GrEqnIPtBsJec2JoqMsk44ep
         oosVvQXEQRVOE/ykM8EkFwXRq226cCCc3pQjoUQN8VllJWMMhL1Q47Y+qauUqeJDCeKY
         /ekJ83lOPjkG6NuBOUGLUOhXEZUtenkmEVxMOV1gUgYGcl0d9ZzuJnZS4BJr3uueFGRB
         BKgeJ7jFX6yF7worWF9po6s3NHDLIKqmnSn7lAg7likcYicw4X83zmU/Y+3ASAAgPptX
         L0HuU5V9tUv/t89lsh53Uj1ZWL63CJU4pz2zO2Y6lAQjgjSTpPSamD7o8AMEl4+A1VtC
         MX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702365749; x=1702970549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ChpZ3DTwNnea6UJpvxUIWDuGDG5RPxpXSi/vdcH9wOY=;
        b=YYBlHH/7SuFIMzHSkb1taVu0aFITkKGElx/1fXqwzo11FvviFO2miRxrmL5k0GUKh9
         0Ei0Hr5jbWgWAhvSQVVaHdKrZjdD78eTZNAPxpmMDAG3qzJMiOVN0BW/Z2VHswFYd7s4
         8DfrtLkZZ1AXhGdHvqGWnSVBWgLh/3mQiqidsphG4BnI6N5wUF7wfqpuz2LCLuuty/RY
         OUr6tweGPMs4mbh24aVcHyZcTVwfPysGvyXSMYTvLhXDdd8lp2xDAlog2SpkhoaQzwCo
         oMXaBZTG3JSRgxAUQDeld5jYboryVgjlEE4M9MZc33iLbG/7vRGlXggTA+lgGCNkVm/O
         WHcg==
X-Gm-Message-State: AOJu0Yz9y29j7BqRo4bhnxHluusNJtPDa7CElUGf5IvlewALI3OgwoSC
        OGUBjviKnRwtH/5jgMFBIrWyN7hZ9Jd7FzC9paMSew==
X-Google-Smtp-Source: AGHT+IFPR8fd+a0ocBEqptE2Dwxw2OhgvjQgzcLmo5cYSUTDyVSX6swyFuxqgUbNPyfiI+F4JCcixtPa397/UgVjePs=
X-Received: by 2002:a25:2653:0:b0:db9:8bcd:a071 with SMTP id
 m80-20020a252653000000b00db98bcda071mr2411598ybm.28.1702365749111; Mon, 11
 Dec 2023 23:22:29 -0800 (PST)
MIME-Version: 1.0
References: <20231212002245.23715-1-quic_abhinavk@quicinc.com> <20231212002245.23715-15-quic_abhinavk@quicinc.com>
In-Reply-To: <20231212002245.23715-15-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 12 Dec 2023 09:22:18 +0200
Message-ID: <CAA8EJpp72_Qy5Lh+bq4Zi8_DRyhCf48gdGRz2fiZvb4y7qb4SQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/15] drm/msm/dpu: introduce separate wb2_format
 arrays for rgb and yuv
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, seanpaul@chromium.org,
        quic_jesszhan@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 at 02:23, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Lets rename the existing wb2_formats array wb2_formats_rgb to indicate
> that it has only RGB formats and can be used on any chipset having a WB
> block.
>
> Introduce a new wb2_formats_rgb_yuv array to the catalog to
> indicate support for YUV formats to writeback in addition to RGB.
>
> Chipsets which have support for CDM block will use the newly added
> wb2_formats_rgb_yuv array.
>
> changes in v3:
>         - change type of wb2_formats_rgb/wb2_formats_rgb_yuv to u32
>           to fix checkpatch warnings
>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  .../msm/disp/dpu1/catalog/dpu_10_0_sm8650.h   |  4 +-
>  .../msm/disp/dpu1/catalog/dpu_6_0_sm8250.h    |  4 +-
>  .../msm/disp/dpu1/catalog/dpu_6_2_sc7180.h    |  4 +-
>  .../msm/disp/dpu1/catalog/dpu_7_2_sc7280.h    |  4 +-
>  .../msm/disp/dpu1/catalog/dpu_9_0_sm8550.h    |  4 +-
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 37 ++++++++++++++++++-
>  6 files changed, 46 insertions(+), 11 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
