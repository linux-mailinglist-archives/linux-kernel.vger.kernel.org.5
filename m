Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D3B80F420
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjLLRMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjLLRML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:12:11 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DB89F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:12:15 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5d7a47d06eeso59713417b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702401134; x=1703005934; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lOtvIagPK2zbOSSPQv7q+2G1sYyn0bSwgtfVk7Q1BdA=;
        b=arGLCz+ROKIxok2HuLNFaVtIaoE/dUe7gdGMAwUCHoMyV42WBnvh1XRCoi0zjjJep6
         1s84Q5EoFI2iD1G3/OM7O1qtCV9NmSNMVN6lYmhp/FJf5fK9ZXhXi02fnsjhLfR4cHTf
         HDmK2YtA4q0Z1lHa/lvtiGFbCHr8jFN929Nsnizn9aGiazhSLygi8K0mqBk1UnjD83Pr
         dW/uahA4QaMQ6mgxZ12mU/o38Ct52HYRFxe+UCHWdvr1o5x73SRJ+bVJO6zpuB1wI50c
         Cp5gIqJU47BrJtFCHSWyUYepvBaN+yE4ppxmN7aKDrF4WTJv41PegJmDZpLv8ETrvoB+
         WwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702401134; x=1703005934;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOtvIagPK2zbOSSPQv7q+2G1sYyn0bSwgtfVk7Q1BdA=;
        b=UhcoNzhBkQGOxhOD0279RPoUm/Pk9Iv6yA8UHA1FlTj0v7sdxVnLDlJyXU4utam3+v
         A3Olc/q6WCBFuPd/YIxw1v6oKeO5ayaZlQ2EvpW+ylakQwzle6FhAVC0JO+EY8vZjtZ7
         Hg6z05qLpfvwtouiZCSWnbi86jd0/1Zc9vaNTfESb3AItxFoyNGbKJA0Rvs/ClkTpX6t
         GOpYfhXLSgCrOm7BhnusD4A+8J5KAGcDswtIyB7xBAnb0pzy5+MhEMP66nJyX6aLFm+K
         JKirrrYBrSZSxMq46UA8xEo4+T0wsKic1CQWcEtF9frU+FSrd0YqUCCueWheHktNOwjX
         Y80w==
X-Gm-Message-State: AOJu0YwLFHxpeRfKrYnHwr+nTPo1c6/by43G8sWpTKbO9qGOXY5S3IDu
        miBfoKTmAZLXQlyuihE1zvl+4NwCcmZWrwoioTfVo5FMFJobwQWZqAs=
X-Google-Smtp-Source: AGHT+IFEOvODxrOkJxwZOaOfBrqcTw4OWgQNxg+L3JQ9QrU9EmXg6iJWSFlly5IUec5Y+CSK1S3c7pr02Sy1wcQg+kE=
X-Received: by 2002:a81:8305:0:b0:5d4:4bb:2090 with SMTP id
 t5-20020a818305000000b005d404bb2090mr5576470ywf.17.1702401134642; Tue, 12 Dec
 2023 09:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20231208050641.32582-1-quic_abhinavk@quicinc.com>
 <20231208050641.32582-6-quic_abhinavk@quicinc.com> <CAA8EJprR92=TRvYNu1dSTUcphUu3v-cD326AK2+80Ex8ppYBBw@mail.gmail.com>
 <4966bfa0-ef50-a02d-a917-86d82429e45e@quicinc.com> <CAA8EJpqu42b0AP8Ar2LoFcrS51iKTUM1Qr++j7MYjv4WCx=tCg@mail.gmail.com>
 <e9634306-dbc4-fe5d-3227-321a492c73cb@quicinc.com> <CAA8EJpq9RPi0q8LBytW=E+H2WWX2T9ShQe6zzzCSCwn1t12FGA@mail.gmail.com>
 <ab69ba1e-3108-c2f0-27be-f1fd5d11bc82@quicinc.com> <CAA8EJppN6=_d7FQ-ZkswkgW9ahRrqjC1f7yLPtOid1taq1QtsA@mail.gmail.com>
In-Reply-To: <CAA8EJppN6=_d7FQ-ZkswkgW9ahRrqjC1f7yLPtOid1taq1QtsA@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 12 Dec 2023 19:12:03 +0200
Message-ID: <CAA8EJpr0s-tnHWFM84CdXANYv5EtcFHrbzQvO7cn98rFJVs+Wg@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] drm/msm/dpu: add cdm blocks to sc7280 dpu_hw_catalog
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Sean Paul <sean@poorly.run>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@gmail.com>, quic_parellan@quicinc.com,
        Daniel Vetter <daniel@ffwll.ch>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        quic_jesszhan@quicinc.com, David Airlie <airlied@gmail.com>,
        freedreno@lists.freedesktop.org
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

Hi Abhinav,

On Tue, 12 Dec 2023 at 08:49, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, 11 Dec 2023 at 23:48, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >
> >
> >
> > On 12/11/2023 1:42 PM, Dmitry Baryshkov wrote:
> > > On Mon, 11 Dec 2023 at 23:32, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> > >>
> > >>
> > >>
> > >> On 12/11/2023 1:31 PM, Dmitry Baryshkov wrote:
> > >>> On Mon, 11 Dec 2023 at 23:16, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> > >>>>
> > >>>>
> > >>>>
> > >>>> On 12/8/2023 3:19 AM, Dmitry Baryshkov wrote:
> > >>>>> On Fri, 8 Dec 2023 at 07:07, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> > >>>>>>
> > >>>>>> Add CDM blocks to the sc7280 dpu_hw_catalog to support
> > >>>>>> YUV format output from writeback block.
> > >>>>>>
> > >>>>>> changes in v2:
> > >>>>>>            - remove explicit zero assignment for features
> > >>>>>>            - move sc7280_cdm to dpu_hw_catalog from the sc7280
> > >>>>>>              catalog file as its definition can be re-used
> > >>>>>>
> > >>>>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > >>>>>> ---
> > >>>>>>     .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h  |  1 +
> > >>>>>>     drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c      | 10 ++++++++++
> > >>>>>>     drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h      | 13 +++++++++++++
> > >>>>>>     drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h         |  5 +++++
> > >>>>>>     4 files changed, 29 insertions(+)
> > >>>>>>
> > >>>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
> > >>>>>> index 209675de6742..19c2b7454796 100644
> > >>>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
> > >>>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
> > >>>>>> @@ -248,6 +248,7 @@ const struct dpu_mdss_cfg dpu_sc7280_cfg = {
> > >>>>>>            .mdss_ver = &sc7280_mdss_ver,
> > >>>>>>            .caps = &sc7280_dpu_caps,
> > >>>>>>            .mdp = &sc7280_mdp,
> > >>>>>> +       .cdm = &sc7280_cdm,
> > >>>>>>            .ctl_count = ARRAY_SIZE(sc7280_ctl),
> > >>>>>>            .ctl = sc7280_ctl,
> > >>>>>>            .sspp_count = ARRAY_SIZE(sc7280_sspp),
> > >>>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> > >>>>>> index d52aae54bbd5..1be3156cde05 100644
> > >>>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> > >>>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> > >>>>>> @@ -426,6 +426,16 @@ static const struct dpu_dsc_sub_blks dsc_sblk_1 = {
> > >>>>>>            .ctl = {.name = "ctl", .base = 0xF80, .len = 0x10},
> > >>>>>>     };
> > >>>>>>
> > >>>>>> +/*************************************************************
> > >>>>>> + * CDM sub block config
> > >>>>>
> > >>>>> Nit: it is not a subblock config.
> > >>>>>
> > >>>>
> > >>>> Ack.
> > >>>>
> > >>>>>> + *************************************************************/
> > >>>>>> +static const struct dpu_cdm_cfg sc7280_cdm = {
> > >>>>>
> > >>>>> I know that I have r-b'ed this patch. But then one thing occurred to
> > >>>>> me. If this definition is common to all (or almost all) platforms, can
> > >>>>> we just call it dpu_cdm or dpu_common_cdm?
> > >>>>>
> > >>>>>> +       .name = "cdm_0",
> > >>>>>> +       .id = CDM_0,
> > >>>>>> +       .len = 0x228,
> > >>>>>> +       .base = 0x79200,
> > >>>>>> +};
> > >>>>
> > >>>> hmmm .... almost common but not entirely ... msm8998's CDM has a shorter
> > >>>> len of 0x224 :(
> > >>>
> > >>> Then sdm845_cdm?
> > >>>
> > >>
> > >> That also has a shorter cdm length.
> > >
> > > Could you please clarify. According to the downstream DT files all CDM
> > > blocks up to (but not including) sm8550 had length 0x224. SM8550 and
> > > SM8650 got qcom,sde-cdm-size = <0x220>.  But I don't see any registers
> > > after 0x204.
> > >>
> >
> > We always list 0x4 more than the last offset.
>
> Yes, so this makes it correct for several latest DT files, which have
> qcom,sde-cdm-size = <0x220>.
> However all the previous DT files (from msm8998 to sm8450) had
> qcom,sde-cdm-size = <0x224>;

Ok, I think I got it, what you were writing about. And we can ignore
the sde-cdm-size from the DT files.

>
> >
> > In chipsets sdm845 and msm8998, I only see the last offset of CDM as
> > 0x220 but in sm8250 and sc7280, the last offset is 0x224. Hence the
> > total length is more in sc7280/sm8250 as compared to sdm845/msm8998.
> >
> > I didnt follow that you do not see any registers after 0x204.
> >
> > The CDM_MUX is the last offset which has an offset 0x224 from the base
> > address. So thats the last offset.
>
> Ack
>
> >
> > The newer chipsets have CDM_MUX and the older ones did not. Hence the
> > difference in length.
> >
> > >> BTW, sdm845 is not in this series. It will be part of RFT as we discussed.
> > >>
> > >>>>
> > >>>>>> +
> > >>>>>>     /*************************************************************
> > >>>>>>      * VBIF sub blocks config
> > >>>>>>      *************************************************************/
> > >>>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> > >>>>>> index e3c0d007481b..ba82ef4560a6 100644
> > >>>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> > >>>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> > >>>>>> @@ -682,6 +682,17 @@ struct dpu_vbif_cfg {
> > >>>>>>            u32 memtype[MAX_XIN_COUNT];
> > >>>>>>     };
> > >>>>>>
> > >>>>>> +/**
> > >>>>>> + * struct dpu_cdm_cfg - information of chroma down blocks
> > >>>>>> + * @name               string name for debug purposes
> > >>>>>> + * @id                 enum identifying this block
> > >>>>>> + * @base               register offset of this block
> > >>>>>> + * @features           bit mask identifying sub-blocks/features
> > >>>>>> + */
> > >>>>>> +struct dpu_cdm_cfg {
> > >>>>>> +       DPU_HW_BLK_INFO;
> > >>>>>> +};
> > >>>>>> +
> > >>>>>>     /**
> > >>>>>>      * Define CDP use cases
> > >>>>>>      * @DPU_PERF_CDP_UDAGE_RT: real-time use cases
> > >>>>>> @@ -805,6 +816,8 @@ struct dpu_mdss_cfg {
> > >>>>>>            u32 wb_count;
> > >>>>>>            const struct dpu_wb_cfg *wb;
> > >>>>>>
> > >>>>>> +       const struct dpu_cdm_cfg *cdm;
> > >>>>>> +
> > >>>>>>            u32 ad_count;
> > >>>>>>
> > >>>>>>            u32 dspp_count;
> > >>>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> > >>>>>> index a6702b2bfc68..f319c8232ea5 100644
> > >>>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> > >>>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> > >>>>>> @@ -185,6 +185,11 @@ enum dpu_dsc {
> > >>>>>>            DSC_MAX
> > >>>>>>     };
> > >>>>>>
> > >>>>>> +enum dpu_cdm {
> > >>>>>> +       CDM_0 = 1,
> > >>>>>> +       CDM_MAX
> > >>>>>> +};
> > >>>>>> +
> > >>>>>>     enum dpu_pingpong {
> > >>>>>>            PINGPONG_NONE,
> > >>>>>>            PINGPONG_0,
> > >>>>>> --
> > >>>>>> 2.40.1
> > >>>>>>
> > >>>>>
> > >>>>>
> > >>>
> > >>>
> > >>>
> > >
> > >
> > >
>
>
>
> --
> With best wishes
> Dmitry



-- 
With best wishes
Dmitry
