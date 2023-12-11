Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D57080DD44
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345137AbjLKVbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjLKVbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:31:14 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC7BD0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 13:31:20 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-db632fef2dcso4854174276.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 13:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702330279; x=1702935079; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YuklrYjWcOTs+XkpZrSUZD3XCm59iUhB/fuyZPiMpJ8=;
        b=ZTj4En5gF8duPenVe+BgUDKAA/uQYdMLjW/6w+dszAu1ksB8iu1sliOvuIfpVAdtfo
         tFFg94w7nG8/yvDJKDMJzamQ2S8/WxPI5jdrVZr9yrafCWCjsLvlQYGzUd0xMDkndl5R
         yy4+ohNxmMg29Ndqgr3tjDxlZ2KPKd8W9BHIdtdm5AOFvVDUrNQ01PA9E7XI1b/9IHsR
         m/iSKOQFAiukUHAPUcqtEYg6nH4OiYHqWL0ejgnb1YCs4mnMnvUf2hfRe5qrMEhXECKR
         v6RIMe0JDG41L7Fxhm2cTaPFSc9JgtSbVq8CXyl0SJ7VHF/+/z3eysBpb9u3EZHI370Y
         ybnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702330279; x=1702935079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YuklrYjWcOTs+XkpZrSUZD3XCm59iUhB/fuyZPiMpJ8=;
        b=jndy/x3U0ZPT90MemquGM4VpdMhmAt04vbPAf0FsWNPoOFQv9CA/34ECHnKp42D4FV
         DawaeviCzDwLm1j9luAvmgy/Iz3gQyTXGrc5RXKwNV4QDQX/edilVWMSQBZWEW1FpYga
         gHoZquSR+lx0KTUeOEY8JPdE4wCr1fpmcG5oOvQtxVT/kNiFh2RYcFGT4rSASxbNgPzy
         V8/J6vpeYz7G30BMRC2CR3E6Oc71V5cBGvP/1eTvdbtnqR6nvblykjG4XeLbCRP8Q2fD
         xOGBcum56fRCy83yiaVV3umnun8avJOtuXhatzvUoOMKQxQ4NS07AMGV2j9keugzr/hX
         m+4g==
X-Gm-Message-State: AOJu0YzxO1PJC2CY0vxS0WMcNxnu8vVAFZOghMF8Hr/GeX70Eqy59S4d
        XfZRdX98EQIQY6wQwLao2qyZ2TA+YzkSQITQ4BW19g==
X-Google-Smtp-Source: AGHT+IGQqhoI+KxGOe25sYIXnHw1HWBewU71k6nhxZZTP0O4IrPw0vYC5vm+Op22lSoK+zDeIAzJkpFzKVZAcsm7KNU=
X-Received: by 2002:a25:5f45:0:b0:dbc:b2e1:43e1 with SMTP id
 h5-20020a255f45000000b00dbcb2e143e1mr670824ybm.91.1702330279400; Mon, 11 Dec
 2023 13:31:19 -0800 (PST)
MIME-Version: 1.0
References: <20231208050641.32582-1-quic_abhinavk@quicinc.com>
 <20231208050641.32582-6-quic_abhinavk@quicinc.com> <CAA8EJprR92=TRvYNu1dSTUcphUu3v-cD326AK2+80Ex8ppYBBw@mail.gmail.com>
 <4966bfa0-ef50-a02d-a917-86d82429e45e@quicinc.com>
In-Reply-To: <4966bfa0-ef50-a02d-a917-86d82429e45e@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 11 Dec 2023 23:31:08 +0200
Message-ID: <CAA8EJpqu42b0AP8Ar2LoFcrS51iKTUM1Qr++j7MYjv4WCx=tCg@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] drm/msm/dpu: add cdm blocks to sc7280 dpu_hw_catalog
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 at 23:16, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 12/8/2023 3:19 AM, Dmitry Baryshkov wrote:
> > On Fri, 8 Dec 2023 at 07:07, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>
> >> Add CDM blocks to the sc7280 dpu_hw_catalog to support
> >> YUV format output from writeback block.
> >>
> >> changes in v2:
> >>          - remove explicit zero assignment for features
> >>          - move sc7280_cdm to dpu_hw_catalog from the sc7280
> >>            catalog file as its definition can be re-used
> >>
> >> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >> ---
> >>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h  |  1 +
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c      | 10 ++++++++++
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h      | 13 +++++++++++++
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h         |  5 +++++
> >>   4 files changed, 29 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
> >> index 209675de6742..19c2b7454796 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
> >> @@ -248,6 +248,7 @@ const struct dpu_mdss_cfg dpu_sc7280_cfg = {
> >>          .mdss_ver = &sc7280_mdss_ver,
> >>          .caps = &sc7280_dpu_caps,
> >>          .mdp = &sc7280_mdp,
> >> +       .cdm = &sc7280_cdm,
> >>          .ctl_count = ARRAY_SIZE(sc7280_ctl),
> >>          .ctl = sc7280_ctl,
> >>          .sspp_count = ARRAY_SIZE(sc7280_sspp),
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> >> index d52aae54bbd5..1be3156cde05 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> >> @@ -426,6 +426,16 @@ static const struct dpu_dsc_sub_blks dsc_sblk_1 = {
> >>          .ctl = {.name = "ctl", .base = 0xF80, .len = 0x10},
> >>   };
> >>
> >> +/*************************************************************
> >> + * CDM sub block config
> >
> > Nit: it is not a subblock config.
> >
>
> Ack.
>
> >> + *************************************************************/
> >> +static const struct dpu_cdm_cfg sc7280_cdm = {
> >
> > I know that I have r-b'ed this patch. But then one thing occurred to
> > me. If this definition is common to all (or almost all) platforms, can
> > we just call it dpu_cdm or dpu_common_cdm?
> >
> >> +       .name = "cdm_0",
> >> +       .id = CDM_0,
> >> +       .len = 0x228,
> >> +       .base = 0x79200,
> >> +};
>
> hmmm .... almost common but not entirely ... msm8998's CDM has a shorter
> len of 0x224 :(

Then sdm845_cdm?

>
> >> +
> >>   /*************************************************************
> >>    * VBIF sub blocks config
> >>    *************************************************************/
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> >> index e3c0d007481b..ba82ef4560a6 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> >> @@ -682,6 +682,17 @@ struct dpu_vbif_cfg {
> >>          u32 memtype[MAX_XIN_COUNT];
> >>   };
> >>
> >> +/**
> >> + * struct dpu_cdm_cfg - information of chroma down blocks
> >> + * @name               string name for debug purposes
> >> + * @id                 enum identifying this block
> >> + * @base               register offset of this block
> >> + * @features           bit mask identifying sub-blocks/features
> >> + */
> >> +struct dpu_cdm_cfg {
> >> +       DPU_HW_BLK_INFO;
> >> +};
> >> +
> >>   /**
> >>    * Define CDP use cases
> >>    * @DPU_PERF_CDP_UDAGE_RT: real-time use cases
> >> @@ -805,6 +816,8 @@ struct dpu_mdss_cfg {
> >>          u32 wb_count;
> >>          const struct dpu_wb_cfg *wb;
> >>
> >> +       const struct dpu_cdm_cfg *cdm;
> >> +
> >>          u32 ad_count;
> >>
> >>          u32 dspp_count;
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> >> index a6702b2bfc68..f319c8232ea5 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> >> @@ -185,6 +185,11 @@ enum dpu_dsc {
> >>          DSC_MAX
> >>   };
> >>
> >> +enum dpu_cdm {
> >> +       CDM_0 = 1,
> >> +       CDM_MAX
> >> +};
> >> +
> >>   enum dpu_pingpong {
> >>          PINGPONG_NONE,
> >>          PINGPONG_0,
> >> --
> >> 2.40.1
> >>
> >
> >



-- 
With best wishes
Dmitry
