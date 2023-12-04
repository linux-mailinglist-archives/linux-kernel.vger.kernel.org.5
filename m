Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2492803AFE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjLDQ6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbjLDQr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:47:26 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D9118C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:47:28 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5d33574f64eso50744547b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701708448; x=1702313248; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3nepwvvRD/gfBaWMYXy5vN/GJrBOCZb1VaNVzHXVB1s=;
        b=boiJBLSzrjKzUhNoa4jZ22WfGC/x1uE/BymTosCXeAIPhx6PHPczxHXfFCHQVhD++M
         GyrbArh9ZY3TuoyiSBWFzfq3xSMScR1853+uXS8LH2M2taM4nTU78tRm/YXbncWkDrNh
         +MtPOl6Avb2TrjxV+XsCr2fpliM1EtAqDkUdg/u7eU4WLsAfdiQLp8ZuEza2Ym81LKk/
         R46tx1DiPD90Rrr/x59rTU5CsXkFs8p54oVIJpfC4lhagIskKnFoKpvPZNHSVdVU3uFt
         bo2GkbiINYNrhUHaBYi6/exFNpBEzALh7CjlCtVHSaf+q1qoT0G8BR/6VDK3Nz+vuh7U
         xY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701708448; x=1702313248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nepwvvRD/gfBaWMYXy5vN/GJrBOCZb1VaNVzHXVB1s=;
        b=tuYKeqv7HAMHJB9OM/c+q/qDFGUQuBEEFVQt99kS6ju+fBR8p76JXw68CAroRJsGfJ
         r0dXRVtpw9M9gJ9LjKpjxDc5bjTLfF4RpXV7M1jqq1wY3E1QVAJ+1Xcq1pGdBOJsoYdf
         up+K9HCFZ4ApYHgFlDIuBS3U/gDm1MxbuYUKIXhNPpYRUR9oFWg0tmmoCIBMG/NhoehR
         fIel6oIZWo1lCNiJDiX2WQT1kjLgJaDqMpppmdBkwFxvvVmPK0xgWJyqRPoSiYkRkPlY
         3bMxpGP4QSqbd7dCF1rRtB5q3s5PIMMYdlD0GbKeBQvf5ch+zQvLOvGhSgvR5Rfa10Hg
         sKTQ==
X-Gm-Message-State: AOJu0Yzv/MOL0cAGy1fPNqZU2avGxyUsZWkqtgoqr0Hs3CleL8yn/Mq9
        lFdaSzkeUO5sgtr4Alpyh0zQixMiDg1qgx5YaTfi1g==
X-Google-Smtp-Source: AGHT+IHcFMkVwwmYMMqki+2Qc6dR02+fv6yJEbd0ifGsqlMUJ9h6kZC+DljYT4ID8A8TJWm7PVUVkQDg4bH96RGd4zo=
X-Received: by 2002:a81:ae0f:0:b0:5d7:1940:b36a with SMTP id
 m15-20020a81ae0f000000b005d71940b36amr3624983ywh.54.1701708448087; Mon, 04
 Dec 2023 08:47:28 -0800 (PST)
MIME-Version: 1.0
References: <1701289898-12235-1-git-send-email-quic_khsieh@quicinc.com>
 <CAA8EJpqX0AWmLMrNo23cfsnU5q0ySDUkb1XTGwaxGt0eTPkLpg@mail.gmail.com> <1086300a-2c8e-f897-a0d7-84d36276a6b6@quicinc.com>
In-Reply-To: <1086300a-2c8e-f897-a0d7-84d36276a6b6@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 4 Dec 2023 18:47:17 +0200
Message-ID: <CAA8EJpq_zE5J584smV=Gido9G-spo7hPYZyf-7vr8ki+r9Az9g@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2023 at 18:37, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
>
> On 11/29/2023 7:57 PM, Dmitry Baryshkov wrote:
> > On Wed, 29 Nov 2023 at 22:31, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
> >> A DCE (Display Compression Engine) contains two DSC hard slice encoders.
> >> Each DCE start with even DSC encoder index followed by an odd DSC encoder
> >> index. Each encoder can work independently. But Only two DSC encoders from
> >> same DCE can be paired to work together to support merge mode. In addition,
> >> the DSC with even index have to mapping to even pingpong index and DSC with
> >> odd index have to mapping to odd pingpong index at its data path. This patch
> >> improve DSC allocation mechanism with consideration of above factors.
> > Is this applicable to old DSC 1.1 encoders?
> yes, this algorithm should work with V1 too

Are the limitations (odd:odd, allocation in pairs, etc) applicable to
v1.1 encoders?

I assume that at least 'allocate two consecutive DSC for DSC merge' is
not applicable, since there are no separate DCE units.

> >
> >> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> >> ---
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 94 +++++++++++++++++++++++++++++-----
> >>   1 file changed, 82 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> >> index f9215643..427d70d 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> >> @@ -466,24 +466,94 @@ static int _dpu_rm_reserve_dsc(struct dpu_rm *rm,
> >>                                 struct drm_encoder *enc,
> >>                                 const struct msm_display_topology *top)
> >>   {
> >> -       int num_dsc = top->num_dsc;
> >> -       int i;
> >> +       int num_dsc = 0;
> >> +       int i, pp_idx;
> >> +       bool pair = false;
> >> +       int dsc_idx[DSC_MAX - DSC_0];
> >> +       uint32_t pp_to_enc_id[PINGPONG_MAX - PINGPONG_0];
> >> +       int pp_max = PINGPONG_MAX - PINGPONG_0;
> >> +
> >> +       if (!top->num_dsc || !top->num_intf)
> >> +               return 0;
> >> +
> >> +       /*
> >> +        * Truth:
> >> +        * 1) every layer mixer only connects to one pingpong
> >> +        * 2) no pingpong split -- two layer mixers shared one pingpong
> >> +        * 3) each DSC engine contains two dsc encoders
> >> +        *    -- index(0,1), index (2,3),... etc
> >> +        * 4) dsc pair can only happens with same DSC engine except 4 dsc
> >> +        *    merge mode application (8k) which need two DSC engines
> >> +        * 5) odd pingpong connect to odd dsc
> >> +        * 6) even pingpong connect even dsc
> >> +        */
> >> +
> >> +       /* num_dsc should be either 1, 2 or 4 */
> >> +       if (top->num_dsc > top->num_intf)       /* merge mode */
> >> +               pair = true;
> >> +
> >> +       /* fill working copy with pingpong list */
> >> +       memcpy(pp_to_enc_id, global_state->pingpong_to_enc_id, sizeof(pp_to_enc_id));
> >> +
> >> +       for (i = 0; i < ARRAY_SIZE(rm->dsc_blks); i++) {
> > && num_dsc < top->num_dsc
> >
> >> +               if (!rm->dsc_blks[i])   /* end of dsc list */
> >> +                       break;
> > I'd say, it's `continue' instead, let's just skip the index.
> >
> >> -       /* check if DSC required are allocated or not */
> >> -       for (i = 0; i < num_dsc; i++) {
> >> -               if (!rm->dsc_blks[i]) {
> >> -                       DPU_ERROR("DSC %d does not exist\n", i);
> >> -                       return -EIO;
> >> +               if (global_state->dsc_to_enc_id[i]) {   /* used */
> >> +                       /* consective dsc index to be paired */
> >> +                       if (pair && num_dsc) {  /* already start pairing, re start */
> >> +                               num_dsc = 0;
> >> +                               /* fill working copy with pingpong list */
> >> +                               memcpy(pp_to_enc_id, global_state->pingpong_to_enc_id,
> >> +                                                               sizeof(pp_to_enc_id));
> >> +                       }
> >> +                       continue;
> >>                  }
> >>
> >> -               if (global_state->dsc_to_enc_id[i]) {
> >> -                       DPU_ERROR("DSC %d is already allocated\n", i);
> >> -                       return -EIO;
> >> +               /* odd index can not become start of pairing */
> >> +               if (pair && (i & 0x01) && !num_dsc)
> >> +                       continue;
> > After looking at all conditions, can we have two different helpers?
> > One which allocates a single DSC and another one which allocates a
> > pair. For the pair you can skip odd indices at all and just check if
> > DSC_i and DSC_i+1 are free.
> >
> >> +
> >> +               /*
> >> +                * find the pingpong index which had been reserved
> >> +                * previously at layer mixer allocation
> >> +                */
> >> +               for (pp_idx = 0; pp_idx < pp_max; pp_idx++) {
> >> +                       if (pp_to_enc_id[pp_idx] == enc->base.id)
> >> +                               break;
> >>                  }
> >> +
> >> +               /*
> >> +                * dsc even index must map to pingpong even index
> >> +                * dsc odd index must map to pingpong odd index
> >> +                */
> >> +               if ((i & 0x01) != (pp_idx & 0x01))
> >> +                       continue;
> >> +
> >> +               /*
> >> +                * delete pp_idx so that it can not be found at next search
> >> +                * in the case of pairing
> >> +                */
> >> +               pp_to_enc_id[pp_idx] = NULL;
> >> +
> >> +               dsc_idx[num_dsc++] = i;
> >> +               if (num_dsc >= top->num_dsc)
> >> +                       break;
> >>          }
> >>
> >> -       for (i = 0; i < num_dsc; i++)
> >> -               global_state->dsc_to_enc_id[i] = enc->base.id;
> >> +       if (num_dsc < top->num_dsc) {
> >> +               DPU_ERROR("DSC allocation failed num_dsc=%d required=%d\n",
> >> +                                               num_dsc, top->num_dsc );
> >> +               return -ENAVAIL;
> >> +       }
> >> +
> >> +       /* reserve dsc */
> >> +       for (i = 0; i < top->num_dsc; i++) {
> >> +               int j;
> >> +
> >> +               j = dsc_idx[i];
> >> +               global_state->dsc_to_enc_id[j] = enc->base.id;
> >> +       }
> >>
> >>          return 0;
> >>   }
> >> --
> >> 2.7.4
> >>
> >



-- 
With best wishes
Dmitry
