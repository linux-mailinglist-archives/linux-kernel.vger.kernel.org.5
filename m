Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E1D8005E6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377867AbjLAIja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377814AbjLAIj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:39:28 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E69A131
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 00:39:34 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5d279bcce64so21321867b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 00:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701419973; x=1702024773; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QM9xhtSWl8bZod+heLo+OxtwiUVff2dCtOs0sAGegx4=;
        b=w/SbIx7Rri7db/tA1bsHTWwhsiN5T4Yfo+Sc2AcnWLv7+4fXgOGTJmC4+4GJGbmRXd
         w7VN7jIiqU9v/uPHcBcrPy9YmGM82LHldXxVV5IzYXCS9NVI79WuKwpu2D+yj5ZkfMSH
         z2309llgI4MmRR18bJVwwHdSbb6hYn1JMqWPzrVhrS3Gc/7gA9UtcdDiRG3x19MvtacM
         /PlNrfFq5BplyAK1vnf+hhljvlNbhdUmU4fLDA7ofuwgumpFmJ1lkL1c1S7tkIoACssx
         8kBrsekfupaZcGBlwfcnhAcZLFiLS3YXZTJxqtpfTntZk/ggpni5ws3tWTfjh+9nxbdA
         gEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701419973; x=1702024773;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QM9xhtSWl8bZod+heLo+OxtwiUVff2dCtOs0sAGegx4=;
        b=wEiBhldPxibLBumuNw0bW8ddlhBoSl0Po8GI8y2Y/o1R9ySbkGVZHpfwI85rVQF6ft
         tyfazWNZNlBmEL6addpKS2JdyZeHkXXLwGnoc6J9BH9JbKXgOTmGzhqNd1dXUUweL9dF
         R4bn+SppOAo/PtH8DrjG6U6ZLVYndiDiE4gIRQ07rmFo74CBBExwTFCn1cCHfVbPY6VY
         27U6HcHkpk4l1HM82sIW8ZFfoP25gS1/+YsrXFRJYq85Vn88G/diC2H+/yK8l/S0ZkkW
         uQfKeb9z/I8ZV906qNExn+QHUG7tlOc2kIkfGkG95bw2g1JGtlWEN+XDzk5WUOHpa077
         wnYA==
X-Gm-Message-State: AOJu0YxzrJ31i6c1AnhpzigBCKBdBo6CAmv9we4/2J7Owuuc5C8Ieb3Y
        vcQcmo5uNL1Qht1Igq+HXrMOcgdRMtdsHYvXrHEy/w==
X-Google-Smtp-Source: AGHT+IFmyIRr/gCqW6f+UW7j7jp8SM1NhNjkR32wOxNjKbwQ4wkSgwoud6Vt7F9+XZwH/86mmn+tBWKoGO57Bl+YGDU=
X-Received: by 2002:a81:b71b:0:b0:5ca:da4c:306a with SMTP id
 v27-20020a81b71b000000b005cada4c306amr296205ywh.51.1701419973356; Fri, 01 Dec
 2023 00:39:33 -0800 (PST)
MIME-Version: 1.0
References: <20230830224910.8091-1-quic_abhinavk@quicinc.com>
 <20230830224910.8091-9-quic_abhinavk@quicinc.com> <CAA8EJporcrBikTob9xJe8_96AJSP1vDJNYPkt1za73PAcg1+Bw@mail.gmail.com>
 <396724e1-2c51-090e-cfa5-e516a0eea861@quicinc.com>
In-Reply-To: <396724e1-2c51-090e-cfa5-e516a0eea861@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 1 Dec 2023 10:39:22 +0200
Message-ID: <CAA8EJpqTYcPw0DqBqydZRbNZ7Mex_Q4Kkxnjni7XxKtqLomkPQ@mail.gmail.com>
Subject: Re: [PATCH 08/16] drm/msm/dpu: add support to allocate CDM from RM
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, quic_khsieh@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2023 at 01:50, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 8/30/2023 5:06 PM, Dmitry Baryshkov wrote:
> > On Thu, 31 Aug 2023 at 01:50, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>
> >> Even though there is usually only one CDM block, it can be
> >> used by either HDMI, DisplayPort OR Writeback interfaces.
> >>
> >> Hence its allocation needs to be tracked properly by the
> >> resource manager to ensure appropriate availability of the
> >> block.
> >
> > It almost feels like an overkill, as up to now there is at most one CDM block.
> >
>
> Yes but even that one CDM block can be used by any connector. So as we
> discussed on IRC, this just implements the FCFS and we need RM to be the
> manager of that one block.

Yes. "almost"

>
> >>
> >> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >> ---
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  2 +-
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  1 +
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h     |  1 +
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      | 45 +++++++++++++++++++--
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h      |  4 +-
> >>   5 files changed, 48 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> >> index 6cf6597148fd..582680804016 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> >> @@ -663,7 +663,7 @@ static int dpu_encoder_virt_atomic_check(
> >>
> >>                  if (!crtc_state->active_changed || crtc_state->enable)
> >>                          ret = dpu_rm_reserve(&dpu_kms->rm, global_state,
> >> -                                       drm_enc, crtc_state, topology);
> >> +                                       drm_enc, crtc_state, topology, false);
> >>          }
> >>
> >>          trace_dpu_enc_atomic_check_flags(DRMID(drm_enc), adj_mode->flags);
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> >> index 34f943102499..07f75f295844 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> >> @@ -98,6 +98,7 @@ enum dpu_hw_blk_type {
> >>          DPU_HW_BLK_DSPP,
> >>          DPU_HW_BLK_MERGE_3D,
> >>          DPU_HW_BLK_DSC,
> >> +       DPU_HW_BLK_CDM,
> >>          DPU_HW_BLK_MAX,
> >>   };
> >>
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> >> index b6f53ca6e962..61aa58643fda 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> >> @@ -136,6 +136,7 @@ struct dpu_global_state {
> >>          uint32_t ctl_to_enc_id[CTL_MAX - CTL_0];
> >>          uint32_t dspp_to_enc_id[DSPP_MAX - DSPP_0];
> >>          uint32_t dsc_to_enc_id[DSC_MAX - DSC_0];
> >> +       uint32_t cdm_to_enc_id;
> >>   };
> >>
> >>   struct dpu_global_state
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> >> index 7b6444a3fcb1..e7d4beb4661e 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> >> @@ -29,10 +29,12 @@ static inline bool reserved_by_other(uint32_t *res_map, int idx,
> >>   /**
> >>    * struct dpu_rm_requirements - Reservation requirements parameter bundle
> >>    * @topology:  selected topology for the display
> >> + * @needs_cdm: whether the display needs a CDM block for the current mode
> >>    * @hw_res:       Hardware resources required as reported by the encoders
> >>    */
> >>   struct dpu_rm_requirements {
> >>          struct msm_display_topology topology;
> >> +       bool needs_cdm;
> >>   };
> >>
> >>   int dpu_rm_destroy(struct dpu_rm *rm)
> >> @@ -505,6 +507,26 @@ static int _dpu_rm_reserve_dsc(struct dpu_rm *rm,
> >>          return 0;
> >>   }
> >>
> >> +static int _dpu_rm_reserve_cdm(struct dpu_rm *rm,
> >> +                              struct dpu_global_state *global_state,
> >> +                              struct drm_encoder *enc)
> >> +{
> >> +       /* try allocating only one CDM block */
> >> +       if (!rm->cdm_blk) {
> >> +               DPU_ERROR("CDM block does not exist\n");
> >> +               return -EIO;
> >> +       }
> >> +
> >> +       if (global_state->cdm_to_enc_id) {
> >> +               DPU_ERROR("CDM_0 is already allocated\n");
> >> +               return -EIO;
> >> +       }
> >> +
> >> +       global_state->cdm_to_enc_id = enc->base.id;
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>   static int _dpu_rm_make_reservation(
> >>                  struct dpu_rm *rm,
> >>                  struct dpu_global_state *global_state,
> >> @@ -530,15 +552,25 @@ static int _dpu_rm_make_reservation(
> >>          if (ret)
> >>                  return ret;
> >>
> >> +       if (reqs->needs_cdm) {
> >> +               ret = _dpu_rm_reserve_cdm(rm, global_state, enc);
> >> +               if (ret) {
> >> +                       DPU_ERROR("unable to find CDM blk\n");
> >> +                       return ret;
> >> +               }
> >> +       }
> >> +
> >>          return ret;
> >>   }
> >>
> >>   static int _dpu_rm_populate_requirements(
> >>                  struct drm_encoder *enc,
> >>                  struct dpu_rm_requirements *reqs,
> >> -               struct msm_display_topology req_topology)
> >> +               struct msm_display_topology req_topology,
> >> +               bool needs_cdm)
> >
> > Push it to the topology, please. It is a part of the topology at some
> > point of view.
> >
>
> hmmm ... ok with a pinch of salt as we somewhat deviate from the true
> topology definition that topology is just how lm, dsc and intf blocks
> are used. it was not intended to hold cdm.

Why not? I mean it is more logical compared to adding the 'needs_cdm'
argument which gets passed through together with the topology.

>
> >>   {
> >>          reqs->topology = req_topology;
> >> +       reqs->needs_cdm = needs_cdm;
> >>
> >>          DRM_DEBUG_KMS("num_lm: %d num_dsc: %d num_intf: %d\n",
> >>                        reqs->topology.num_lm, reqs->topology.num_dsc,
> >> @@ -571,6 +603,7 @@ void dpu_rm_release(struct dpu_global_state *global_state,
> >>                  ARRAY_SIZE(global_state->dsc_to_enc_id), enc->base.id);
> >>          _dpu_rm_clear_mapping(global_state->dspp_to_enc_id,
> >>                  ARRAY_SIZE(global_state->dspp_to_enc_id), enc->base.id);
> >> +       _dpu_rm_clear_mapping(&global_state->cdm_to_enc_id, 1, enc->base.id);
> >>   }
> >>
> >>   int dpu_rm_reserve(
> >> @@ -578,7 +611,8 @@ int dpu_rm_reserve(
> >>                  struct dpu_global_state *global_state,
> >>                  struct drm_encoder *enc,
> >>                  struct drm_crtc_state *crtc_state,
> >> -               struct msm_display_topology topology)
> >> +               struct msm_display_topology topology,
> >> +               bool needs_cdm)
> >>   {
> >>          struct dpu_rm_requirements reqs;
> >>          int ret;
> >> @@ -595,7 +629,7 @@ int dpu_rm_reserve(
> >>          DRM_DEBUG_KMS("reserving hw for enc %d crtc %d\n",
> >>                        enc->base.id, crtc_state->crtc->base.id);
> >>
> >> -       ret = _dpu_rm_populate_requirements(enc, &reqs, topology);
> >> +       ret = _dpu_rm_populate_requirements(enc, &reqs, topology, needs_cdm);
> >>          if (ret) {
> >>                  DPU_ERROR("failed to populate hw requirements\n");
> >>                  return ret;
> >> @@ -644,6 +678,11 @@ int dpu_rm_get_assigned_resources(struct dpu_rm *rm,
> >>                  hw_to_enc_id = global_state->dsc_to_enc_id;
> >>                  max_blks = ARRAY_SIZE(rm->dsc_blks);
> >>                  break;
> >> +       case DPU_HW_BLK_CDM:
> >> +               hw_blks = &rm->cdm_blk;
> >> +               hw_to_enc_id = &global_state->cdm_to_enc_id;
> >> +               max_blks = 1;
> >> +               break;
> >>          default:
> >>                  DPU_ERROR("blk type %d not managed by rm\n", type);
> >>                  return 0;
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
> >> index 29b221491926..74262d3cb6c3 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
> >> @@ -69,13 +69,15 @@ int dpu_rm_destroy(struct dpu_rm *rm);
> >>    * @drm_enc: DRM Encoder handle
> >>    * @crtc_state: Proposed Atomic DRM CRTC State handle
> >>    * @topology: Pointer to topology info for the display
> >> + * @needs_cdm: bool to indicate whether current encoder needs CDM
> >>    * @Return: 0 on Success otherwise -ERROR
> >>    */
> >>   int dpu_rm_reserve(struct dpu_rm *rm,
> >>                  struct dpu_global_state *global_state,
> >>                  struct drm_encoder *drm_enc,
> >>                  struct drm_crtc_state *crtc_state,
> >> -               struct msm_display_topology topology);
> >> +               struct msm_display_topology topology,
> >> +               bool needs_cdm);
> >>
> >>   /**
> >>    * dpu_rm_reserve - Given the encoder for the display chain, release any
> >> --
> >> 2.40.1
> >>
> >
> >



-- 
With best wishes
Dmitry
