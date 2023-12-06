Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2417A807030
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378133AbjLFMtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378101AbjLFMtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:49:42 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71691A2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:49:48 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-db8892a5f96so3955130276.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 04:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701866988; x=1702471788; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jrpEd8RJRtQUwtVg9+y681GZcu+Yhv9ko2OvFWCbawE=;
        b=QJKkWvkTyYdjOD00IjEjocC/Trf/mKUgXeSrNT6ME4kL3rZwwP2Xof307zY8YONStj
         INq0klNrTVOV4yuRmg6Mt73WA23f8PRRRCafHxGtEICsHvuNYoQxONCwQI3gkOKVbqal
         UvODuPg6Hnd8k0m1cbzC/ru/JLrfZZB/s1ZU5mtZt8eZ9bHcleCWQj36Ezx0/9qKLZF/
         fjBjg+/au8fz26m3Yve2ma1lqKjt5ZfAQWtgF7IcvlBrc2SlTXZlJ6E3qgpOXZPZ+HVR
         BJMzlgV8gch0S/IeY4vHydTdo0rOdxtqIY12lXe8geRbJ58HIeNSE2ALb+Qp4rIolgZh
         55Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701866988; x=1702471788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrpEd8RJRtQUwtVg9+y681GZcu+Yhv9ko2OvFWCbawE=;
        b=gBp1zRcqPLOCQRALCMqrELCymqexjnV8T3FxOB6rcz8xSezO0PRtQ4LPDeKplP2rrw
         7xb+UO+xHw1tJJN7JNIiKVGu2pDz3volK1torvWJOtkKBSWWwCs6yG18lv3CESxAApvA
         cET1DpP927lvpmRgd9GQkRtJpi8VQHwbWhcLO8li3omPAoGsDETt+2LNiCeV/sUajTQH
         63DyWPqjyaieMzAUZD9lXpBF0P3L5OIWUd+yEnYnKUw0zxvUJ8WMdBbCvsnj10iCjUYe
         Xwzmm9eALevYNJleFVJOsGt33MbVrpA4Uu+RNHOkP53CdLPvLumWtKOy12ulIhHcc1WY
         DWVQ==
X-Gm-Message-State: AOJu0YyfszPyFy49G79KFTBuuwEcsMgQKHiS4RZJqxXtsZcIWtwUnVRv
        +5yhf2dsLPMJjTMFmxsHK0nHLrbM5qhaDXQZlwoWQQ==
X-Google-Smtp-Source: AGHT+IHeqJ1eTYAQg7X0GkSNud8ldZu9UODzg7lAQ9auwRFlAMgP9S/UuJtWfqYW2ZPM/Qhaz91I9uCvRVyAd2//C24=
X-Received: by 2002:a25:d80a:0:b0:db5:4857:5fdf with SMTP id
 p10-20020a25d80a000000b00db548575fdfmr582661ybg.37.1701866987913; Wed, 06 Dec
 2023 04:49:47 -0800 (PST)
MIME-Version: 1.0
References: <20231205220526.417719-1-robdclark@gmail.com> <20231205220526.417719-2-robdclark@gmail.com>
 <19ca53ae-b180-4ec6-9294-dd45825af653@linaro.org>
In-Reply-To: <19ca53ae-b180-4ec6-9294-dd45825af653@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 6 Dec 2023 14:49:36 +0200
Message-ID: <CAA8EJprhH_HgftREL4UQuKEDiNsTOUrCh74v8OLwm6bm75SqyA@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/msm/adreno: Split up giant device table
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Wed, 6 Dec 2023 at 14:29, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 12/5/23 23:03, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Split into a separate table per generation, in preparation to move each
> > gen's device table to it's own file.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/gpu/drm/msm/adreno/adreno_device.c | 59 +++++++++++++++++++---
> >   1 file changed, 51 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > index 41b13dec9bef..36392801f929 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > @@ -20,7 +20,7 @@ bool allow_vram_carveout = false;
> >   MODULE_PARM_DESC(allow_vram_carveout, "Allow using VRAM Carveout, in place of IOMMU");
> >   module_param_named(allow_vram_carveout, allow_vram_carveout, bool, 0600);
> >
> > -static const struct adreno_info gpulist[] = {
> > +static const struct adreno_info a2xx_gpus[] = {
> >       {
> >               .chip_ids = ADRENO_CHIP_IDS(0x02000000),
> >               .family = ADRENO_2XX_GEN1,
> > @@ -55,6 +55,12 @@ static const struct adreno_info gpulist[] = {
> >               .inactive_period = DRM_MSM_INACTIVE_PERIOD,
> >               .init  = a2xx_gpu_init,
> >       }, {
> > +             /* sentinal */
> sentinel?
>
> > +     }
> > +};
> > +
> > +static const struct adreno_info a3xx_gpus[] = {
> > +     {
> >               .chip_ids = ADRENO_CHIP_IDS(
> >                       0x03000512,
> >                       0x03000520
> > @@ -110,6 +116,12 @@ static const struct adreno_info gpulist[] = {
> >               .inactive_period = DRM_MSM_INACTIVE_PERIOD,
> >               .init  = a3xx_gpu_init,
> >       }, {
> > +             /* sentinal */
> > +     }
> > +};
> > +
> > +static const struct adreno_info a4xx_gpus[] = {
> > +     {
> >               .chip_ids = ADRENO_CHIP_IDS(0x04000500),
> >               .family = ADRENO_4XX,
> >               .revn  = 405,
> > @@ -143,6 +155,12 @@ static const struct adreno_info gpulist[] = {
> >               .inactive_period = DRM_MSM_INACTIVE_PERIOD,
> >               .init  = a4xx_gpu_init,
> >       }, {
> > +             /* sentinal */
> > +     }
> > +};
> > +
> > +static const struct adreno_info a5xx_gpus[] = {
> > +     {
> >               .chip_ids = ADRENO_CHIP_IDS(0x05000600),
> >               .family = ADRENO_5XX,
> >               .revn = 506,
> > @@ -268,6 +286,12 @@ static const struct adreno_info gpulist[] = {
> >               .init = a5xx_gpu_init,
> >               .zapfw = "a540_zap.mdt",
> >       }, {
> > +             /* sentinal */
> > +     }
> > +};
> > +
> > +static const struct adreno_info a6xx_gpus[] = {
> > +     {
> >               .chip_ids = ADRENO_CHIP_IDS(0x06010000),
> >               .family = ADRENO_6XX_GEN1,
> >               .revn = 610,
> > @@ -493,6 +517,12 @@ static const struct adreno_info gpulist[] = {
> >               .hwcg = a690_hwcg,
> >               .address_space_size = SZ_16G,
> >       }, {
> > +             /* sentinal */
> > +     }
> > +};
> > +
> > +static const struct adreno_info a7xx_gpus[] = {
> > +     {
> >               .chip_ids = ADRENO_CHIP_IDS(0x07030001),
> >               .family = ADRENO_7XX_GEN1,
> >               .fw = {
> > @@ -522,7 +552,18 @@ static const struct adreno_info gpulist[] = {
> >               .zapfw = "a740_zap.mdt",
> >               .hwcg = a740_hwcg,
> >               .address_space_size = SZ_16G,
> > -     },
> > +     }, {
> > +             /* sentinal */
> > +     }
> > +};
> > +
> > +static const struct adreno_info *gpulist[] = {
> > +     a2xx_gpus,
> > +     a3xx_gpus,
> > +     a4xx_gpus,
> > +     a5xx_gpus,
> > +     a6xx_gpus,
> > +     a7xx_gpus,
> >   };
> >
> >   MODULE_FIRMWARE("qcom/a300_pm4.fw");
> > @@ -557,12 +598,14 @@ static const struct adreno_info *adreno_info(uint32_t chip_id)
> >   {
> >       /* identify gpu: */
> >       for (int i = 0; i < ARRAY_SIZE(gpulist); i++) {
> > -             const struct adreno_info *info = &gpulist[i];
> > -             if (info->machine && !of_machine_is_compatible(info->machine))
> > -                     continue;
> > -             for (int j = 0; info->chip_ids[j]; j++)
> I'm not sure using sentinels here is a good idea, it adds a
> whole lot of stack size. Perhaps gpulist could be a struct
> of array pointers and an array of sizes?

My 2c would be to reimplement it as a of_device_id.data and thus the
device_match_data.

-- 
With best wishes
Dmitry
