Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E46800478
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377695AbjLAHOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjLAHOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:14:20 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E467410FD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:14:25 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5cece20f006so20373817b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701414865; x=1702019665; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fwEyNpMfW1Ufx9odV3bnrhN7pz+UIxPRZV5Xveszz0A=;
        b=sVytQP6rvUPUia+SwYjKet+G2cfBoqn3sYqKPjerZyGM76hXzxYG1OZeq6FWckjB9j
         0QLsQzFLuwBn6TKP3em4ggSAiHol1ewbgabEC4ViH+jELx7ABugFI4A26teKqoLzCFIA
         2lXQ4cpG886ymJF0DHz4wUymoLR3jDcZuaypK39YupCvG/h6oNSvDHLj6vqOvxBm3fj7
         nz6Rg4k03I+p3/mJrsBfQwvi/cBm1HkLv7hmT72V2wgHexx/0sxxuOHBeloZ+LW/3jNC
         wjiTrl5qm2JFfbDPYEHYNl1CWGVgrlMaKD46HuTCEi/6FbWcGK96boKmcrxO4EHDtVsk
         zNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701414865; x=1702019665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwEyNpMfW1Ufx9odV3bnrhN7pz+UIxPRZV5Xveszz0A=;
        b=XiJKuG/dtYcrqnvvY4RB8PQRU5AkTtf60TDt9cBaUKVIyJI/CN9B7gR0DhTk7HhG+2
         btZ2uDTHeRsb7ow1tEnU7J5D/7X0t5WZKGkfiviNd11shMIMZlQYRRzbYg3vIeAK6d1m
         zfaH+qi43n7kkmPI5rFFCbMUqInvkoe/RobmzmzwiYm8vigmoi8+ULg6mUTlavjGCwNs
         dyfFG/rlbw+G7DkLrXnqTrHWbHW1P/xeCJgkSJc+oLG919sxy7VOHuilbJmNCg7JjUsB
         itWvzqulTRhTquXomwm3obKjdjnhgCZy4hMrnms/Bk5sKIXrf9995EgGggLQElpeWTmO
         /Ybw==
X-Gm-Message-State: AOJu0YwDX3MgV163UIfx37YAFJtPV4EYiF7W7Ml325DGjLMAciOYRR1q
        bSiFPi26LkDQXvoEe3L8dGoRWxeZP8EUWRhfyrjNOw==
X-Google-Smtp-Source: AGHT+IH1zrA0sedjaTZM9ZUB1Xj3rWiOnVGBxUse/78AVWt2GLivnKjlJLa6tr6P49ZKi6Z6HiLTYSJNGyzwhMUczKg=
X-Received: by 2002:a0d:fa05:0:b0:5d0:55c:382c with SMTP id
 k5-20020a0dfa05000000b005d0055c382cmr16611927ywf.10.1701414865131; Thu, 30
 Nov 2023 23:14:25 -0800 (PST)
MIME-Version: 1.0
References: <20230830224910.8091-1-quic_abhinavk@quicinc.com>
 <20230830224910.8091-15-quic_abhinavk@quicinc.com> <CAA8EJprZma-e=zbtDuGKfcHK7zTaSykACt+=rh7W92iEpif=Ug@mail.gmail.com>
 <6ed0c636-c222-36b3-aae9-eb822e088a2c@quicinc.com>
In-Reply-To: <6ed0c636-c222-36b3-aae9-eb822e088a2c@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 1 Dec 2023 09:14:14 +0200
Message-ID: <CAA8EJpp4XNCwRzF=Lo4_oV7Gj1yDDcEQn5YJ5vXEx=HiJvByWA@mail.gmail.com>
Subject: Re: [PATCH 14/16] drm/msm/dpu: do not allow YUV formats if no CDM
 block is present
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

On Fri, 1 Dec 2023 at 02:50, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 8/30/2023 5:24 PM, Dmitry Baryshkov wrote:
> > On Thu, 31 Aug 2023 at 01:50, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>
> >> On chipsets where CDM block is not available OR where support has
> >> not been added yet do not allow YUV formats for writeback block.
> >>
> >> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >> ---
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> >> index 7fc174b33ae2..d8edca9bc964 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> >> @@ -406,6 +406,12 @@ static int dpu_encoder_phys_wb_atomic_check(
> >>                  return ret;
> >>          }
> >>
> >> +       if (DPU_FORMAT_IS_YUV(to_dpu_format(msm_framebuffer_format(fb))) &&
> >> +           !phys_enc->dpu_kms->catalog->cdm) {
> >> +               DPU_ERROR("cannot support YUV formats without CDM block\n");
> >> +               return -EINVAL;
> >> +       }
> >
> > Can we have YUV formats in wb_formats if we do not support CDM? That
> > would be an error.
>
> I can drop this one once i address the comments on the next patch.
>
> Yeah the reason for this change was we had one formats array for wb and
> were using that for all chipsets. We can have two arrays : one only rgb
> and the other rgb+yuv to address this.

Yes, this sounds fine to me.



-- 
With best wishes
Dmitry
