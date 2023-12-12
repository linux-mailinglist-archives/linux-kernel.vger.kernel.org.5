Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFFE80F972
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjLLVdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbjLLVcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:32:45 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE95A7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:32:51 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-dbcb4747d84so1477196276.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702416770; x=1703021570; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nAMCWPmOAEyI7QnHbEVFzQzgfOnlTbYbwwq0iE7QXzY=;
        b=hBz2agZPHmFoCNfkYwLxe49dfn7WI+3JZZM6PBOJzHQcyXBlEsBGUFciDGneuIHqOq
         MrVgLNCfiYw4IpZg5Bh/MykT7+7R1zEOVGtc8yAr5y5Q5QDa6vY9xO7Wr5ExaM3ltp2D
         IAl6NMUNrDX+etN1vh1X1ogQobiHojiVe6Sf+Y2B8rKdR1ZTI+t5ZU4+nuyKhjwNKQjD
         kA6h0i8I5UCogjp+Ypu/sWHXmlQAFdzPzi1P7wt7LRkFmA9WnS9ri9DI0yTkB9gvPgit
         vjXQL3mBUi0EoLFXBmojcIw3oX8ji+TkFjO1S6ucP7SSyOB0rVgHYsNbhE1IckY9/OBl
         gI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702416770; x=1703021570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nAMCWPmOAEyI7QnHbEVFzQzgfOnlTbYbwwq0iE7QXzY=;
        b=fMrnQ81uNfvgNPGqrnaeRewEWwyv9C17H1qgnLeRC/gJvupkPaPI6BPdT1luZnndjW
         1Oo+wq605k5feSGSmmW4hzq/r8kMqPL568qV+C1k8vLUgJwCLG4IWdGlZXEbMkznIeWd
         uwoNLjz6mzsArKxPSHjpNCQ6VJA3ijthT3VBzcvBefQHKevmBmnQpNzj11FgAMKtUvXY
         8FhgzSmY9KCx3/+cJSxbff3IyyW2mUZPznOJs0xd3iQGBF6PbZGx+cfL/az2dVTjUIhk
         Jngv7aQsu63tgNbXhzRPbYQ+Q3u5aldJJc8Z+V7pwJdjZsT+9CCWPwihd7Dg2aUu1LRX
         ZENg==
X-Gm-Message-State: AOJu0Yxzs8uK9biQkFkqGtC9w2SHfqRFU4kS9CD0lEbq0eFt6L828BY0
        pcvCLcQx14IfJlorraLSQjdGbqX3td4EacE6mFmWcg==
X-Google-Smtp-Source: AGHT+IHwhm79zg1o8Twrfkas2RbpxztHXKT11jxCktgcQzXvIJ4yp5ZwLauwclFvKaPNojWCQqYq1B6yvcIm7JME4n8=
X-Received: by 2002:a81:8305:0:b0:5d4:4bb:2090 with SMTP id
 t5-20020a818305000000b005d404bb2090mr5961876ywf.17.1702416770167; Tue, 12 Dec
 2023 13:32:50 -0800 (PST)
MIME-Version: 1.0
References: <20231212002245.23715-1-quic_abhinavk@quicinc.com>
 <20231212002245.23715-2-quic_abhinavk@quicinc.com> <CAA8EJpqJOh0R1X3i1UGe9hHoezV4uBNDCWPFSdeuXyC6Ju4eHA@mail.gmail.com>
 <59304cf8-33b7-bf27-f9e2-a15e323c869a@quicinc.com>
In-Reply-To: <59304cf8-33b7-bf27-f9e2-a15e323c869a@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 12 Dec 2023 23:32:39 +0200
Message-ID: <CAA8EJpr3Gjd-5cw=15g9TNcs1q30_eSzFYpD0_-0fc43VBof1g@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] drm/msm/dpu: add formats check for writeback encoder
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

On Tue, 12 Dec 2023 at 19:17, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 12/11/2023 10:40 PM, Dmitry Baryshkov wrote:
> > On Tue, 12 Dec 2023 at 02:23, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>
> >> In preparation for adding more formats to dpu writeback add
> >> format validation to it to fail any unsupported formats.
> >>
> >> changes in v3:
> >>          - rebase on top of msm-next
> >>          - replace drm_atomic_helper_check_wb_encoder_state() with
> >>            drm_atomic_helper_check_wb_connector_state() due to the
> >>            rebase
> >>
> >> changes in v2:
> >>          - correct some grammar in the commit text
> >>
> >> Fixes: d7d0e73f7de3 ("drm/msm/dpu: introduce the dpu_encoder_phys_* for writeback")
> >> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >> ---
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> >> index bb94909caa25..425415d45ec1 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> >> @@ -272,6 +272,7 @@ static int dpu_encoder_phys_wb_atomic_check(
> >>   {
> >>          struct drm_framebuffer *fb;
> >>          const struct drm_display_mode *mode = &crtc_state->mode;
> >> +       int ret;
> >>
> >>          DPU_DEBUG("[atomic_check:%d, \"%s\",%d,%d]\n",
> >>                          phys_enc->hw_wb->idx, mode->name, mode->hdisplay, mode->vdisplay);
> >> @@ -308,6 +309,12 @@ static int dpu_encoder_phys_wb_atomic_check(
> >>                  return -EINVAL;
> >>          }
> >>
> >> +       ret = drm_atomic_helper_check_wb_connector_state(conn_state->connector, conn_state->state);
> >> +       if (ret < 0) {
> >> +               DPU_ERROR("invalid pixel format %p4cc\n", &fb->format->format);
> >> +               return ret;
> >> +       }
> >
> > There is no guarantee that there will be no other checks added to this
> > helper. So, I think this message is incorrect. If you wish, you can
> > promote the level of the message in the helper itself.
> > On the other hand, we rarely print such messages by default. Most of
> > the checks use drm_dbg.
> >
>
> hmm...actually drm_atomic_helper_check_wb_connector_state() already has
> a debug message to indicate invalid pixel formats.
>
> You are right, i should perhaps just say that "atomic_check failed" or
> something.
>
> I can make this a DPU_DEBUG. Actually I didnt know that we are not
> supposed to print out atomic_check() errors. Is it perhaps because its
> okay for check to fail?

There are no messages by default there, because otherwise it is so
easy for the user to overspam the dmesg and thus syslog / journal. DoS
on the plate.

>
> But then we would not know why it failed.

Think about the user of X11. They don't see the console. And by
default in the contemporary distros they won't be able to check dmesg.
So if a commit fails, they have to deduce anyway, why did it fail.

>
> >> +
> >>          return 0;
> >>   }
> >>
> >> --
> >> 2.40.1
> >>
> >
> >



-- 
With best wishes
Dmitry
