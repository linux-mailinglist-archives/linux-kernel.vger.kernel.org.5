Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0219E8138F7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjLNRmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLNRmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:42:17 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD7099
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:42:23 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-db4422fff15so7115040276.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702575742; x=1703180542; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g0LtA3RcxjW8vTbuZqn9CO5WSi3XER//Pr1fbXwAcxM=;
        b=Xf/9H3hLqpClvwW8/BYxjwC9JTB61zVFljmRD9tx1Ik+ij8edVs8L6c15iVNuAwvHP
         tGP739v5yHF34rt0ghjkq6p40Pn4q5eoAooJ2EKLskBYjvAmQa7aebVqDATMxsVaYodi
         rVtRMrNFZupVVJIG7B8gxfWm5O2ByPghDvxaleWwwxgYW/p4GNHvPLMAqoEFj6wg0maF
         ixjWJBrNLDzMRi7I/NUHXmuEzXQSLxKBj/wrlP8IPH8a03hVsVbTO/GtZ6Qpe/A07rPy
         j8FLrL30UFpvQAwmNlG1cpKwve6nTSF+J7W8bIPllKXqkJi8wA3XjQ1xsprzlRk8sSTW
         IKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702575742; x=1703180542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g0LtA3RcxjW8vTbuZqn9CO5WSi3XER//Pr1fbXwAcxM=;
        b=AQ7S/kBov2bBkPUgX7MNufiBwm4nRTYjUj8sMqLlqdGdB8WKNx4UVIDiAveu/wQM8w
         MPaKh/rlj5RpnJTY9sAyGFyOjtnsBVZ0esG2gDttSPUev0aGSWQ7udn3ZaeHW4xYQ3Q6
         5oqt6DKrNVhCN8T0EEuKCxyPg62jUq2Xiw/aErYwtekwaMUVwOYeMmPEyBBrxAWlyrnI
         HDwn17ROgLr260QzSy5pdgmdIgVHdXTW3vr9KwCcxvDNx1HoXffoxW/R3/JO4PRem4tH
         AtAPnzPMX++Ri9MwrEza9xE+03/MO1/4KXhcoIUUP+DhOPXWkIrte5K6ZXof5ZuFN9tI
         itJg==
X-Gm-Message-State: AOJu0Yxb1ArX51fR8uOuOyK+umgLjlZIauHnmD4kcC2LdTXqHN6N2LE3
        CGYuGEeR7wRRrTSTKt0XtteMKJCYiGPxzlR0UXQs/A==
X-Google-Smtp-Source: AGHT+IFnj3g/SgfAeLkquhUQHDuy6XEO5JpKxJ5SEflXowFLhUKUgPtEG67blDHWMI0wKboRKWkCzGeFSdED0V4W4NE=
X-Received: by 2002:a25:938e:0:b0:dbc:eda9:a8f5 with SMTP id
 a14-20020a25938e000000b00dbceda9a8f5mr589837ybm.44.1702575742141; Thu, 14 Dec
 2023 09:42:22 -0800 (PST)
MIME-Version: 1.0
References: <1702493883-30148-1-git-send-email-quic_khsieh@quicinc.com>
 <CAA8EJppypE-0tUfVD-24YMOQ+3cP+_D1BZYju0K7qzaUE_RnKA@mail.gmail.com> <dab2beed-78de-6638-8389-d3e03c8cfc44@quicinc.com>
In-Reply-To: <dab2beed-78de-6638-8389-d3e03c8cfc44@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 14 Dec 2023 19:42:10 +0200
Message-ID: <CAA8EJppizUj3wWMXn32Ro6QfQ+er+vnetbLd+Bff6YhAQj7zYw@mail.gmail.com>
Subject: Re: [PATCH v5] drm/msm/dpu: improve DSC allocation
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

On Thu, 14 Dec 2023 at 19:34, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
>
> On 12/13/2023 3:00 PM, Dmitry Baryshkov wrote:
> > On Wed, 13 Dec 2023 at 20:58, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
> >> At DSC V1.1 DCE (Display Compression Engine) contains a DSC encoder.
> >> However, at DSC V1.2 DCE consists of two DSC encoders, one has an odd
> >> index and another one has an even index. Each encoder can work
> >> independently. But only two DSC encoders from same DCE can be paired
> >> to work together to support DSC merge mode at DSC V1.2. For DSC V1.1
> >> two consecutive DSC encoders (start with even index) have to be paired
> >> to support DSC merge mode.  In addition, the DSC with even index have
> >> to be mapped to even PINGPONG index and DSC with odd index have to be
> >> mapped to odd PINGPONG index at its data path in regardless of DSC
> >> V1.1 or V1.2. This patch improves DSC allocation mechanism with
> >> consideration of those factors.
> >>
> >> Changes in V5:
> >> -- delete dsc_id[]
> >> -- update to global_state->dsc_to_enc_id[] directly
> >> -- replace ndx with idx
> >> -- fix indentation at function declaration
> >> -- only one for loop at _dpu_rm_reserve_dsc_single()
> >>
> >> Changes in V4:
> >> -- rework commit message
> >> -- use reserved_by_other()
> >> -- add _dpu_rm_pingpong_next_index()
> >> -- revise _dpu_rm_pingpong_dsc_check()
> >>
> >> Changes in V3:
> >> -- add dpu_rm_pingpong_dsc_check()
> >> -- for pair allocation use i += 2 at for loop
> >>
> >> Changes in V2:
> >>      -- split _dpu_rm_reserve_dsc() into _dpu_rm_reserve_dsc_single() and
> >>         _dpu_rm_reserve_dsc_pair()
> >>
> >> Fixes: f2803ee91a41 ("drm/msm/disp/dpu1: Add DSC support in RM")
> >> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> >> ---
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 162 +++++++++++++++++++++++++++++----
> >>   1 file changed, 146 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> >> index f9215643..7c7a88f 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> >> @@ -461,29 +461,159 @@ static int _dpu_rm_reserve_ctls(
> >>          return 0;
> >>   }
> >>
> >> -static int _dpu_rm_reserve_dsc(struct dpu_rm *rm,
> >> -                              struct dpu_global_state *global_state,
> >> -                              struct drm_encoder *enc,
> >> -                              const struct msm_display_topology *top)
> >> +static int _dpu_rm_pingpong_next_index(int start,
> >> +                                      uint32_t enc_id,
> >> +                                      uint32_t *pp_to_enc_id,
> >> +                                      int pp_max)
> >>   {
> >> -       int num_dsc = top->num_dsc;
> >>          int i;
> >>
> >> -       /* check if DSC required are allocated or not */
> >> -       for (i = 0; i < num_dsc; i++) {
> >> -               if (!rm->dsc_blks[i]) {
> >> -                       DPU_ERROR("DSC %d does not exist\n", i);
> >> -                       return -EIO;
> >> -               }
> >> +       for (i = start; i < pp_max; i++) {
> >> +               if (pp_to_enc_id[i] == enc_id)
> >> +                       return i;
> >> +       }
> >> +
> >> +       return -ENAVAIL;
> >> +}
> >> +
> >> +static int _dpu_rm_pingpong_dsc_check(int dsc_idx, int pp_idx)
> >> +{
> >> +
> > CHECK: Blank lines aren't necessary after an open brace '{'
> > #85: FILE: drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c:481:
> >
> >> +       /*
> >> +        * DSC with even index must be used with the PINGPONG with even index
> >> +        * DSC with odd index must be used with the PINGPONG with odd index
> >> +        */
> >> +       if ((dsc_idx & 0x01) != (pp_idx & 0x01))
> >> +               return -ENAVAIL;
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int _dpu_rm_reserve_dsc_single(struct dpu_rm *rm,
> >> +                                     struct dpu_global_state *global_state,
> >> +                                     uint32_t enc_id,
> >> +                                     const struct msm_display_topology *top)
> >> +{
> >> +       int num_dsc = 0;
> >> +       uint32_t *pp_to_enc_id = global_state->pingpong_to_enc_id;
> >> +       uint32_t *dsc_enc_id = global_state->dsc_to_enc_id;
> >> +       int pp_max = PINGPONG_MAX - PINGPONG_0;
> >> +       int pp_idx;
> >> +       int dsc_idx;
> >> +       int ret;
> >> +
> >> +       for (dsc_idx = 0; dsc_idx < ARRAY_SIZE(rm->dsc_blks) &&
> >> +                         num_dsc < 1; dsc_idx++) {
> > The condition is wrong here. Also it is misaligned.
>
> i will remove checking  num_dsc < 1 here and add break at end of body of
> for loop since it only allocate one dsc

I thought we established that in v4 or v3 that _single can get two DSC
interfaces to be allocated.

       if (top->num_dsc > top->num_intf)       /* merge mode */
               return _dpu_rm_reserve_dsc_pair(rm, global_state, enc_id, top);
       else
               return _dpu_rm_reserve_dsc_single(rm, global_state, enc_id, top);


Consider a bonded DSI panel (num_intf = 2) and two DSC encoders being
requested (num_dsc = 2). The code goes to the
_dpu_rm_reserve_dsc_single().

>
>
> >
> >> +               if (!rm->dsc_blks[dsc_idx])
> >> +                       continue;
> >> +
> >> +               if (reserved_by_other(dsc_enc_id, dsc_idx, enc_id))
> >> +                       continue;
> >> +
> >> +               pp_idx = _dpu_rm_pingpong_next_index(0, enc_id,
> > And this is wrong too. You should start relatively to your previous PP index.
>
> It does not have previous pp_index since it only allocate on dsc.
>
> >
> >> +                                                    pp_to_enc_id, pp_max);
> >> +               if (pp_idx < 0)
> >> +                       return -ENAVAIL;
> >> +
> >> +               ret = _dpu_rm_pingpong_dsc_check(dsc_idx, pp_idx);
> >> +               if (ret)
> >> +                       return -ENAVAIL;
> >> +
> >> +               dsc_enc_id[dsc_idx] = enc_id;
> >> +               num_dsc++;
> >> +       }
> >> +
> >> +       if (!num_dsc) {
> >> +               DPU_ERROR("DSC allocation failed num_dsc=%d\n", num_dsc);
> >> +               return -ENAVAIL;
> >> +       }
> >>
> >> -               if (global_state->dsc_to_enc_id[i]) {
> >> -                       DPU_ERROR("DSC %d is already allocated\n", i);
> >> -                       return -EIO;
> >> +       return 0;
> >> +}
> >> +
> >> +static int _dpu_rm_reserve_dsc_pair(struct dpu_rm *rm,
> >> +                                   struct dpu_global_state *global_state,
> >> +                                   uint32_t enc_id,
> >> +                                   const struct msm_display_topology *top)
> >> +{
> >> +       int num_dsc = 0;
> >> +       uint32_t *pp_to_enc_id = global_state->pingpong_to_enc_id;
> >> +       uint32_t *dsc_enc_id = global_state->dsc_to_enc_id;
> > No need for these anymore. Please inline them. Or simply pass
> > global_state to _dpu_rm_pingpong_next_index().
> > Other functions in dpu_rm.c don't define local variables for these
> > arrays. I don't see why this patch should deviate from that.
> >
> >> +       int pp_max = PINGPONG_MAX - PINGPONG_0;
> >> +       int start_pp_idx = 0;
> >> +       int dsc_idx, pp_idx;
> >> +       int ret;
> >> +
> >> +       /* only start from even dsc index */
> >> +       for (dsc_idx = 0; dsc_idx < ARRAY_SIZE(rm->dsc_blks) &&
> >> +                         num_dsc < top->num_dsc; dsc_idx += 2) {
> > Misaligned
> >
> >> +               if (!rm->dsc_blks[dsc_idx] ||
> >> +                   !rm->dsc_blks[dsc_idx + 1])
> >> +                       continue;
> >> +
> >> +               /* consective dsc index to be paired */
> >> +               if (reserved_by_other(dsc_enc_id, dsc_idx, enc_id) ||
> >> +                   reserved_by_other(dsc_enc_id, dsc_idx + 1, enc_id))
> >> +                       continue;
> >> +
> >> +               pp_idx = _dpu_rm_pingpong_next_index(start_pp_idx, enc_id,
> >> +                                                    pp_to_enc_id, pp_max);
> >> +               if (pp_idx < 0)
> >> +                       return -ENAVAIL;
> >> +
> >> +               ret = _dpu_rm_pingpong_dsc_check(dsc_idx, pp_idx);
> >> +               if (ret) {
> >> +                       pp_idx = 0;
> >> +                       continue;
> >>                  }
> >> +
> >> +               pp_idx = _dpu_rm_pingpong_next_index(pp_idx + 1, enc_id,
> >> +                                                    pp_to_enc_id, pp_max);
> >> +               if (pp_idx < 0)
> >> +                       return -ENAVAIL;
> > Fresh pp_idx has to be checked against dsc_idx + 1.
> >
> > Let me also have a suggestion for you. The pp_max is a constant. You
> > don't have to pass it to _dpu_rm_pingpong_next_index() at all! Also if
> > you change the function to accept enum dpu_pingpong, you can start
> > with PINGPONG_NONE and move +1 into the function, making the callers
> > simpler, removing the need or start_pp_idx (which I asked to do in v4)
> > etc.
> >
> >> +
> >> +               dsc_enc_id[dsc_idx] = enc_id;
> >> +               dsc_enc_id[dsc_idx + 1] = enc_id;
> >> +               num_dsc += 2;
> >> +
> >> +               start_pp_idx = pp_idx + 1;      /* start for next pair */
> >>          }
> >>
> >> -       for (i = 0; i < num_dsc; i++)
> >> -               global_state->dsc_to_enc_id[i] = enc->base.id;
> >> +       if (num_dsc < top->num_dsc) {
> >> +               DPU_ERROR("DSC allocation failed num_dsc=%d required=%d\n",
> >> +                                               num_dsc, top->num_dsc);
> > Misaligned
> >
> >> +               return -ENAVAIL;
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int _dpu_rm_reserve_dsc(struct dpu_rm *rm,
> >> +                              struct dpu_global_state *global_state,
> >> +                              struct drm_encoder *enc,
> >> +                              const struct msm_display_topology *top)
> >> +{
> >> +       uint32_t enc_id = enc->base.id;
> >> +
> >> +       if (!top->num_dsc || !top->num_intf)
> >> +               return 0;
> >> +
> >> +       /*
> >> +        * Facts:
> >> +        * 1) DSCs ouput to an interface
> > WARNING: 'ouput' may be misspelled - perhaps 'output'?
> >
> > Also, what does it bring to us?
> >
> >> +        * 2) no pingpong split (two layer mixers shared one pingpong)
> >> +        * 3) DSC pair start from even index, such as index(0,1), (2,3), etc
> > starts
> >
> >> +        * 4) even PINGPONG connects to even DSC
> >> +        * 5) odd PINGPONG connects to odd DSC
> >> +        * 6) pair: encoder +--> pp_idx_0 --> dsc_idx_0
> >> +        *                  +--> pp_idx_1 --> dsc_idx_1
> >> +        */
> >> +
> >> +       /* num_dsc should be either 1, 2 or 4 */
> >> +       if (top->num_dsc > top->num_intf)       /* merge mode */
> >> +               return _dpu_rm_reserve_dsc_pair(rm, global_state, enc_id, top);
> >> +       else
> >> +               return _dpu_rm_reserve_dsc_single(rm, global_state, enc_id, top);
> >>
> >>          return 0;
> >>   }
> >> --
> >> 2.7.4
> >>
> > Kuogee, we value your patches. But could you please fix your editor
> > settings to properly align C statements? E.g. Vim has the "set
> > cino=(0" setting, which does most of the work. I suspect that your
> > code editor should also have a similar setting. Also could you please
> > establish a practice of using checkpatch.pl at least until we stop
> > hitting obvious issues there?
> >



-- 
With best wishes
Dmitry
