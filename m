Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E799477943C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjHKQVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjHKQVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:21:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D362702;
        Fri, 11 Aug 2023 09:21:36 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52256241c50so2834691a12.3;
        Fri, 11 Aug 2023 09:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691770895; x=1692375695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gu8V37ck4bhW/MDHFFxPdQxj3+UGhQMkMY7C4RdA7kU=;
        b=iE5QNHzCs/a84dftki8VPTvxzfS4UsEgOLYbiwuZGVELYQrM2auOZfRbn2xmXEaybz
         LniC3FU0oDl/F+bCXaqR+mdTR2tYvlGPKSpXA2WGpX2/0T62EpBViCPJE+J8uSlJdd4f
         B9zRO3ZU9LE3B93qLUU+LQTF7A3kovZzRMTl1UB+rMLIpPorGCl/Qv+MvWtpd9SH60i8
         YigMmy8UUL1rBUauj/6gMTUfEui7sBuIp7YCDhqF0nUhzcK8cYQ3GHwn+GQq6exDw8Su
         5ZqwSQDQ3xiHLdGobRkcra8le1Hq9jONgFb8MId+bscgVlWoy7JOwl6WsPRHd0E2v2Yd
         UpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691770895; x=1692375695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gu8V37ck4bhW/MDHFFxPdQxj3+UGhQMkMY7C4RdA7kU=;
        b=ceQH+LL3FYMG6uTPm/xnYfBGtBYOtlmNLlPgqJgvCDkHwWUTfFA0z9lveprRxTq1zJ
         I2qag8oVo6ETcJvSSex9CUhKOfuBtnstnKpiE+TnaGZ2WgNGabXtjMr9S2f3wSl1OY96
         iyIdnqODZRwxe8oP0jEypwPsRJ1OCsG3t+vVKmVGuUAlms+xELziR2zIWqNrEOBU1JG3
         66jvKJdz1AZPoHeu4Z4bSTsb6BIGNAkPjnzu/nTQRFgwxoDrgoZbw9VXdlLZKisfDxNX
         +GjST7p72bsFLPTNokcjhd2Ung/aWc8e0yNEsPJJL8JScR2lHu4+gcxV3lTxC6Eklgjc
         ubQA==
X-Gm-Message-State: AOJu0Yy5tSIRREUxC9wNTIS3LE5SjlDsGFWHkfc0chrW8uP7zh914dQw
        +GZRvWSe7GFX2mMWYh9Hjf9gTrF9/9QxWlf9ePY=
X-Google-Smtp-Source: AGHT+IHxJ7loqb9uBPUfzjEVz2W5ApsU10Ng4qTENXy3nPtyg76zYG6eo2MZZO+e2x4Qu1z+qceCnvjHoMnNVoJMK9Y=
X-Received: by 2002:aa7:c956:0:b0:523:b1b0:f69f with SMTP id
 h22-20020aa7c956000000b00523b1b0f69fmr2241060edt.32.1691770894855; Fri, 11
 Aug 2023 09:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230811160505.174574-1-robdclark@gmail.com> <CAF6AEGtNgCxsOLyF31=WCdag4Gb7+2FvFEvOWDcqd_TxiTeE3w@mail.gmail.com>
 <d400c787-3c81-4e37-b541-371d6096cf7e@linaro.org>
In-Reply-To: <d400c787-3c81-4e37-b541-371d6096cf7e@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 11 Aug 2023 09:21:22 -0700
Message-ID: <CAF6AEGuHKuW_LGYfC640fBHsf3xzxSiyqL0YVpb5HqE=HSiL4w@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/a690: Switch to a660_gmu.bin
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 9:11=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
> On 11.08.2023 18:09, Rob Clark wrote:
> > On Fri, Aug 11, 2023 at 9:05=E2=80=AFAM Rob Clark <robdclark@gmail.com>=
 wrote:
> >>
> >> From: Rob Clark <robdclark@chromium.org>
> >>
> >> There isn't actually a a690_gmu.bin.  But it appears that the normal
> >> a660_gmu.bin works fine.  Normally all the devices within a sub-
> >> generation (or "family") will use the same fw, and a690 is in the a660
> >> family.
> >>
> >
> > possibly this could be considered as:
> >
> > Fixes: 5e7665b5e484 ("drm/msm/adreno: Add Adreno A690 support")
> For a lack of a better response, "meh"

It would help route the change back to 6.4.y so we can stop explaining
to folks that they should create a symlink ;-)

> Other than that:
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>
> Perhaps we could take this further and do something like
>
> if (failed to load gmu fw)
>         try loading "gmu.bin"

that (loading random fw) sounds like a bad idea.. plus gmu.bin doesn't exis=
t

BR,
-R

>
> Konrad
> >
> >> Signed-off-by: Rob Clark <robdclark@chromium.org>
> >> ---
> >>  drivers/gpu/drm/msm/adreno/adreno_device.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/=
drm/msm/adreno/adreno_device.c
> >> index 1ed270dae148..756a9cfe1cbf 100644
> >> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> >> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> >> @@ -478,7 +478,7 @@ static const struct adreno_info gpulist[] =3D {
> >>                 .family =3D ADRENO_6XX_GEN4,
> >>                 .fw =3D {
> >>                         [ADRENO_FW_SQE] =3D "a660_sqe.fw",
> >> -                       [ADRENO_FW_GMU] =3D "a690_gmu.bin",
> >> +                       [ADRENO_FW_GMU] =3D "a660_gmu.bin",
> >>                 },
> >>                 .gmem =3D SZ_4M,
> >>                 .inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
> >> --
> >> 2.41.0
> >>
