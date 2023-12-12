Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A3A80F994
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377314AbjLLViH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbjLLVh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:37:56 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B265BC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:38:02 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5d3644ca426so60949357b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702417082; x=1703021882; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hzxdy4DAqYYy/QedSXGsAE7/tNvWAE0PzW8vKkT/Z+Q=;
        b=mWtC57EgH17ygeRM7FPM1w6jTUZW6gJhR3YJ98ARpUQLJkLUifHY6VCPXF50frkD35
         tKLLPJUGDaF7rdfR81lcLUfl9J6QpLInjT4s8qeAQx+W/60tCZoq/OpCMxokbWRDdALM
         agkNrk6k1D/4gvfq3MKCTR3RhmnCgQQSek1NOhdJR6M2Cb8ARZe2IZ7JghwPJ4cBpFbG
         oawKFBMje7mxt1jVlSc3qckYS4b9sKDDdsboeFSyS6sLPwpJ/iXKCzAgsTVoU/Wi0tMn
         7eJe7VHJDAk5CuPrPgz/GQ10aRVb+6ePJ+qll5JYRTfmonU6SV+k/dy+G+BP+kFI4EKd
         Oa3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702417082; x=1703021882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hzxdy4DAqYYy/QedSXGsAE7/tNvWAE0PzW8vKkT/Z+Q=;
        b=ZUC3Sh5Y44LaNnL32kDYRPzgNy5JasGQG2aDd9nzVwgR8DPZU3KAPi+6QWWSzwXp37
         mg9Ob6p3HIWdjydKLw3dWcf6fx5TsPlymsM6ObAwdKYLRacYbA/+hKfleRCjwK89AGLM
         0FT2c9UUSb+Ek2N/SYxSewdUCd4iP/SYJqmdAhSFBUkiVGEBIFKzKQIpu0tFD99e1Fht
         UtOBIfAWr3TgcvcRqEALW9QbibI4WBGWK2YcI1fWSVdNBa/Hf4Yo9WTo9vsTofE/ZcyI
         vr4xuRzxoVkAwUlXxU9DoMSTvPdjCilm0w6yB4jr7xS48Sn2s6ykgVrSo/LIUri3WLsh
         WYaw==
X-Gm-Message-State: AOJu0YyIqhHE8fBZ8kVGdZx7Ibb9Nu6GEz88eN+IJk1lwzylWiVlfHDn
        74UHvFyyKlZp6J+226wJfSFBClUf1zTbLtuboWU6eDVQqCbOSSOxMLE=
X-Google-Smtp-Source: AGHT+IHOaQxAO03DA1eRwI9KuaEK/YYi+78fp45l1XIByFOvK8wRRxPSjLqjbcQfM3q4ZBmUdltsfAN58G975GhgKo0=
X-Received: by 2002:a05:690c:4705:b0:5e1:80b6:a731 with SMTP id
 gz5-20020a05690c470500b005e180b6a731mr2364533ywb.60.1702417081817; Tue, 12
 Dec 2023 13:38:01 -0800 (PST)
MIME-Version: 1.0
References: <20231212205254.12422-1-quic_abhinavk@quicinc.com> <20231212205254.12422-8-quic_abhinavk@quicinc.com>
In-Reply-To: <20231212205254.12422-8-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 12 Dec 2023 23:37:51 +0200
Message-ID: <CAA8EJprBF35zAhNjTrQ85yDOQwu3rssr3+xstSBVBLZyD0gfKQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/15] drm/msm/dpu: add dpu_hw_cdm abstraction for CDM block
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, seanpaul@chromium.org,
        quic_jesszhan@quicinc.com, linux-arm-msm@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 at 22:53, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> CDM block comes with its own set of registers and operations
> which can be done. In-line with other hardware blocks, this
> change adds the dpu_hw_cdm abstraction for the CDM block.
>
> changes in v4:
>         - used FIELD_PREP() for dpu_hw_cdm_setup_cdwn() operations
>         - change to lowercase hex in dpu_hw_cdm_bind_pingpong_blk()
>         - move disable assignment inside else in dpu_hw_cdm_bind_pingpong_blk()
>
> changes in v3:
>         - fix commit text from sub-blk to blk for CDM
>         - fix kbot issue for missing static for dpu_hw_cdm_enable()
>         - fix kbot issue for incorrect documentation style
>         - add more documentation for enums and struct in dpu_hw_cdm.h
>         - drop "enable" parameter from bind_pingpong_blk() as we can
>           just use PINGPONG_NONE for disable cases
>         - drop unnecessary bit operation for zero value of cdm_cfg
>
> changes in v2:
>         - replace bit magic with relevant defines
>         - use drmm_kzalloc instead of kzalloc/free
>         - some formatting fixes
>         - inline _setup_cdm_ops()
>         - protect bind_pingpong_blk with core_rev check
>         - drop setup_csc_data() and setup_cdwn() ops as they
>           are merged into enable()
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312101815.B3ZH7Pfy-lkp@intel.com/
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/Makefile                |   1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c  | 245 ++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.h  | 142 ++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |   1 +
>  4 files changed, 389 insertions(+)
>  create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c
>  create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.h

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
