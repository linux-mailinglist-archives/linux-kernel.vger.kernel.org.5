Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E3C7FE7E4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 04:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344378AbjK3D51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 22:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjK3D50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 22:57:26 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2930CD5C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 19:57:31 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-da3b4b7c6bdso415671276.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 19:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701316650; x=1701921450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NGWm3u9yYVotTkhg+4wnu73eBmCMgIje2MPFVUlA884=;
        b=SxQ3GhtJI228GGsFBj0LkhMfAJakHIsPzhQTXHtMHMAYQgblOm8metId4SNtSG1GUm
         kFqSI62syK43u5o5UnclbgQMEbeVC2Kpaiyl8VB15Mxnq75G/InBoOGb0/BjbXCSww0T
         s3nWI62FSailoiOBvUifX9g3CYtgHpIAkKZCaaFro9oUucXPwVOK4uBYlZFV9PTrKQLZ
         EluJEHTU3thMHFQ4gfofQcbTzkjeVHaHuB9yzTDVgIT1WldLiQSYAskPSdHxBwcbZ1C1
         gndymGUomHFLzus7vsAQch0wyPR/Yz9nyIvMmDZIbXNRC2XECE/w9dsyHkmRFc8SHql8
         733Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701316650; x=1701921450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NGWm3u9yYVotTkhg+4wnu73eBmCMgIje2MPFVUlA884=;
        b=ZzFL8VFRykp1fgPqgX0XuECltEgbYa3XLrmZCuMPZI1HL34bwV2cKraRpTe42eUFoE
         ix08miz0YfkdWkNoGIJBbZS1i7OST3ZVnpAhRFaB2wj823dc18bmmegRAUlL1yu+qc3E
         3rYPv6PSjhU27PZ2fsuptKUU5rWP8nQXF6k8KAhxqs1lAcMwfCQPplkkHE/sTzY+yT+B
         jAuG9L/wCLd7G2P6ZaIW2b6dPPuVm8fDjuwJAPY+GUoqxtVwU6L48iP/DDW1bzaNlqo1
         mybP6NkBOrk/s64oLmesap3pHVet091lIRN7lxVUt9gk1ITU+l/bwG6a/XGwL0ovtTiE
         ACAA==
X-Gm-Message-State: AOJu0Yw7TzUd6zuLHNbR3oDNdoDqfNz50/6Qyh06k/cSeHC0CJ5ZTIzO
        db8OpSqAvIaLwtRRwp5gQXbBeve71f/OPylmvZobWLsvz4WG/tE1
X-Google-Smtp-Source: AGHT+IHP8cmKMSRlWXDU40883HCygxSwYOviecR5TtB5mbgCkaXhi1OzQryXhlndiX8Qzrf6Lr/w3YtOT7bwaWCpeLk=
X-Received: by 2002:a25:ab07:0:b0:db5:3cf7:ffe0 with SMTP id
 u7-20020a25ab07000000b00db53cf7ffe0mr192427ybi.45.1701316650319; Wed, 29 Nov
 2023 19:57:30 -0800 (PST)
MIME-Version: 1.0
References: <1701289898-12235-1-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1701289898-12235-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 30 Nov 2023 05:57:19 +0200
Message-ID: <CAA8EJpqX0AWmLMrNo23cfsnU5q0ySDUkb1XTGwaxGt0eTPkLpg@mail.gmail.com>
Subject: Re: [PATCH v1] drm/msm/dpu: improve DSC allocation
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 at 22:31, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> A DCE (Display Compression Engine) contains two DSC hard slice encoders.
> Each DCE start with even DSC encoder index followed by an odd DSC encoder
> index. Each encoder can work independently. But Only two DSC encoders from
> same DCE can be paired to work together to support merge mode. In addition,
> the DSC with even index have to mapping to even pingpong index and DSC with
> odd index have to mapping to odd pingpong index at its data path. This patch
> improve DSC allocation mechanism with consideration of above factors.

Is this applicable to old DSC 1.1 encoders?

>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 94 +++++++++++++++++++++++++++++-----
>  1 file changed, 82 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> index f9215643..427d70d 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> @@ -466,24 +466,94 @@ static int _dpu_rm_reserve_dsc(struct dpu_rm *rm,
>                                struct drm_encoder *enc,
>                                const struct msm_display_topology *top)
>  {
> -       int num_dsc = top->num_dsc;
> -       int i;
> +       int num_dsc = 0;
> +       int i, pp_idx;
> +       bool pair = false;
> +       int dsc_idx[DSC_MAX - DSC_0];
> +       uint32_t pp_to_enc_id[PINGPONG_MAX - PINGPONG_0];
> +       int pp_max = PINGPONG_MAX - PINGPONG_0;
> +
> +       if (!top->num_dsc || !top->num_intf)
> +               return 0;
> +
> +       /*
> +        * Truth:
> +        * 1) every layer mixer only connects to one pingpong
> +        * 2) no pingpong split -- two layer mixers shared one pingpong
> +        * 3) each DSC engine contains two dsc encoders
> +        *    -- index(0,1), index (2,3),... etc
> +        * 4) dsc pair can only happens with same DSC engine except 4 dsc
> +        *    merge mode application (8k) which need two DSC engines
> +        * 5) odd pingpong connect to odd dsc
> +        * 6) even pingpong connect even dsc
> +        */
> +
> +       /* num_dsc should be either 1, 2 or 4 */
> +       if (top->num_dsc > top->num_intf)       /* merge mode */
> +               pair = true;
> +
> +       /* fill working copy with pingpong list */
> +       memcpy(pp_to_enc_id, global_state->pingpong_to_enc_id, sizeof(pp_to_enc_id));
> +
> +       for (i = 0; i < ARRAY_SIZE(rm->dsc_blks); i++) {

&& num_dsc < top->num_dsc

> +               if (!rm->dsc_blks[i])   /* end of dsc list */
> +                       break;

I'd say, it's `continue' instead, let's just skip the index.

>
> -       /* check if DSC required are allocated or not */
> -       for (i = 0; i < num_dsc; i++) {
> -               if (!rm->dsc_blks[i]) {
> -                       DPU_ERROR("DSC %d does not exist\n", i);
> -                       return -EIO;
> +               if (global_state->dsc_to_enc_id[i]) {   /* used */
> +                       /* consective dsc index to be paired */
> +                       if (pair && num_dsc) {  /* already start pairing, re start */
> +                               num_dsc = 0;
> +                               /* fill working copy with pingpong list */
> +                               memcpy(pp_to_enc_id, global_state->pingpong_to_enc_id,
> +                                                               sizeof(pp_to_enc_id));
> +                       }
> +                       continue;
>                 }
>
> -               if (global_state->dsc_to_enc_id[i]) {
> -                       DPU_ERROR("DSC %d is already allocated\n", i);
> -                       return -EIO;
> +               /* odd index can not become start of pairing */
> +               if (pair && (i & 0x01) && !num_dsc)
> +                       continue;

After looking at all conditions, can we have two different helpers?
One which allocates a single DSC and another one which allocates a
pair. For the pair you can skip odd indices at all and just check if
DSC_i and DSC_i+1 are free.

> +
> +               /*
> +                * find the pingpong index which had been reserved
> +                * previously at layer mixer allocation
> +                */
> +               for (pp_idx = 0; pp_idx < pp_max; pp_idx++) {
> +                       if (pp_to_enc_id[pp_idx] == enc->base.id)
> +                               break;
>                 }
> +
> +               /*
> +                * dsc even index must map to pingpong even index
> +                * dsc odd index must map to pingpong odd index
> +                */
> +               if ((i & 0x01) != (pp_idx & 0x01))
> +                       continue;
> +
> +               /*
> +                * delete pp_idx so that it can not be found at next search
> +                * in the case of pairing
> +                */
> +               pp_to_enc_id[pp_idx] = NULL;
> +
> +               dsc_idx[num_dsc++] = i;
> +               if (num_dsc >= top->num_dsc)
> +                       break;
>         }
>
> -       for (i = 0; i < num_dsc; i++)
> -               global_state->dsc_to_enc_id[i] = enc->base.id;
> +       if (num_dsc < top->num_dsc) {
> +               DPU_ERROR("DSC allocation failed num_dsc=%d required=%d\n",
> +                                               num_dsc, top->num_dsc );
> +               return -ENAVAIL;
> +       }
> +
> +       /* reserve dsc */
> +       for (i = 0; i < top->num_dsc; i++) {
> +               int j;
> +
> +               j = dsc_idx[i];
> +               global_state->dsc_to_enc_id[j] = enc->base.id;
> +       }
>
>         return 0;
>  }
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
