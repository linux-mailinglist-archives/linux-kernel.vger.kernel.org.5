Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A535E789313
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 03:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjHZBaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 21:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjHZBaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 21:30:04 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8B21FD7;
        Fri, 25 Aug 2023 18:30:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-525bd0b2b48so2014057a12.0;
        Fri, 25 Aug 2023 18:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693013400; x=1693618200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2D36dOoa06BWR5AgzTMO8lYHiZ+scFy120F5WcTjb4=;
        b=FDM7incZcG0SAgE8+njJbysK0lJLfbZ5w5pqVsOhU0RVVKAbbu9S2DM/Ck1prs72Pq
         I1r85m4ckvcMwSk1x9V/A6/mHix2474u+E+NzTZ4GWI3bHSDYt9JoYxCISI9J3MBWfQ7
         g1CoUg3IzIojkWoDzheYx/OTFNTt1V/6tkwFQ2peXQWpAEhQxGcVNC70/9TV7NC3NfW8
         1qLkYtq3W7SQg4Mgvc4a12z8gMdWJX+3B0OJlVtmliGYW/Qpm5PV/EYkpVeVqO+FiNyh
         OPmriR2FLEwDSulrTmguaW/O2uxJ3T/ZR5TdkJL5lv9TmqjEHrUTVKdnmaV385nDHbxF
         Xiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693013400; x=1693618200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2D36dOoa06BWR5AgzTMO8lYHiZ+scFy120F5WcTjb4=;
        b=h8131xYGlNH73KWewRU28PEBeerSFZkJMACOsr32VHBzQU45ASacy6yGTLd97/As/l
         eOGye3Vb6RLGsjpSTiQQVIW0Yc2xWloKvPfMLo+c41d30As7/fkFnhPnDCb/qmKw44TY
         9zbGj1AqvQ6BR+f8F4dtTlc5jaSUPnzltxrmEI2isoW8/U1Q38yfmMhTPwblmSjGIrtB
         JVPwmLQw99aTA3HfFa0AUXXdvflms0+fKrMOHnWY4nkGTdksw49Xv/umKZFUQGsAaehA
         9GF9ZF76eKpxsuMVl4UXxYnGvv5yzsZG0IEx118tVv7uxcdHSh1PN95fwb2FidPKi2Ze
         TzPQ==
X-Gm-Message-State: AOJu0YwjoAyJQcFpV1xOjZYI239UroQCz3uwHdW+8VPjCN5xepfZ9TQc
        pRkuTDJEYs+GMxxmCrEAQnH5Uf4uM6ePYEr9nSs=
X-Google-Smtp-Source: AGHT+IEXsOl+EHSkkBQhRH9RjwYOfhOsIxG3m6cpaf528qm11nkEYjjL1pWzb1LveXcoEDTjgx812Dp7EL91FKYuxKo=
X-Received: by 2002:a05:6402:34b:b0:525:69ec:e1c8 with SMTP id
 r11-20020a056402034b00b0052569ece1c8mr12651629edw.40.1693013399773; Fri, 25
 Aug 2023 18:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230825-topic-6375_gpu_id-v1-1-e24f46d7f139@linaro.org>
In-Reply-To: <20230825-topic-6375_gpu_id-v1-1-e24f46d7f139@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 25 Aug 2023 18:29:48 -0700
Message-ID: <CAF6AEGsNr+5zaXqKRhyeY6NV+iRD+Yz8ftqiX6Z08esoyh=DzQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/adreno: Fix SM6375 GPU ID
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 2:11=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
> SM6375 comes with a patchlevel=3D1. Fix the chipid up to reflect that.
>
> Fixes: 90b593ce1c9e ("drm/msm/adreno: Switch to chip-id for identifying G=
PU")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm=
/msm/adreno/adreno_device.c
> index 575e7c56219f..f2d9d34ed50f 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -331,7 +331,7 @@ static const struct adreno_info gpulist[] =3D {
>                 ),
>         }, {
>                 .machine =3D "qcom,sm6375",
> -               .chip_ids =3D ADRENO_CHIP_IDS(0x06010900),
> +               .chip_ids =3D ADRENO_CHIP_IDS(0x06010901),

r-b, but maybe we should list both to be safe?  But unsure if any
patchlevel=3D0 things are out there in the wild... I guess we could add
it back in later if needed

BR,
-

>                 .family =3D ADRENO_6XX_GEN1,
>                 .revn =3D 619,
>                 .fw =3D {
>
> ---
> base-commit: 6269320850097903b30be8f07a5c61d9f7592393
> change-id: 20230825-topic-6375_gpu_id-cf1596e2b147
>
> Best regards,
> --
> Konrad Dybcio <konrad.dybcio@linaro.org>
>
