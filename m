Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ED9776C0E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjHIWPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjHIWPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:15:31 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5E483;
        Wed,  9 Aug 2023 15:15:30 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe4a89e8c4so2149835e9.3;
        Wed, 09 Aug 2023 15:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691619329; x=1692224129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+iJ6yF+JifkMrPOYhZUvJyGxXgs7A1jvN2VjyrqrnI=;
        b=AEnMxHFAjFr+t+Fv4gp5f6SaAAZn/zjl2EQxRQx4dG/wsepAOjR4pLmy9jhCnY/Vib
         holfLQ4faoacjF3oUZ6yS4bgXfLU/W5gbvbChvkHkZ4O5MgiBd9ESj+bttV+W3S+BVCp
         JH1kG73KIwWSZUaB9r5zXDlQT25w9zVlcz5La+VsX1V1t2fZRmtQHUnQnVdEJj9NYPJf
         mXmMxylE3H29YihR2Ja7xSkhE0V9E26CmhkvLBb33e8nyh05uUDK8xzrJZOUnmZw2FIk
         LkchJ9QHDF/gvTurw2NzZzgqKw/g320k9D/mc4HyndAYcfRHnbLGQtiRDLMIpEPvf3hW
         074A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691619329; x=1692224129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+iJ6yF+JifkMrPOYhZUvJyGxXgs7A1jvN2VjyrqrnI=;
        b=brUzxFB6GpRRiV0/VHs/V4P7g4Dhjn/i4TcKhJepb9mI6fcqJ7L/Hq6+qtMH88vMwU
         /4MVKiR782fHrTNrUPNjgvZq3G2hUyEwLL3PQBY1Rezv9gVjAwReZxZHWOZzBmFBHrlq
         FdhMqGSn7U/ALpTzyrwWDdpHAhrxQyJo+IX81jFzlrWrCoNMWfbdrgPQrthc6zmGbkII
         qXC5sDqGMB/zJfIAnqnrA97pNSfvHelenp52Al35WyEU9Z36qtSNWlD2VbVuuyrNTcQ3
         kz9iv1syzEA1Qv9/YM2S0UkwN7kBsgHUCNZstpERmIHFfIHHEDPYlGy5+xRLQj39RIKJ
         EelQ==
X-Gm-Message-State: AOJu0YyS16C2ZJWRpbshKrWTWOf31D3VBtKSFJpXPkXUH++Bv0LwZSBC
        e3fczGnZCAX6QvALiSO+lnS7qwB1jjjgpQqk+0o=
X-Google-Smtp-Source: AGHT+IHV1xs1dkP+pOGfhd0RGUDfPYeFzLZpaU1m6hjicg46DC1woF+aE7CJjryFD6qT/kAeqsR5O9L8D1t5J2nM8P0=
X-Received: by 2002:a5d:594a:0:b0:314:4915:689 with SMTP id
 e10-20020a5d594a000000b0031449150689mr450261wri.34.1691619328716; Wed, 09 Aug
 2023 15:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230628-topic-a7xx_drmmsm-v2-0-1439e1b2343f@linaro.org> <20230628-topic-a7xx_drmmsm-v2-13-1439e1b2343f@linaro.org>
In-Reply-To: <20230628-topic-a7xx_drmmsm-v2-13-1439e1b2343f@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 9 Aug 2023 15:15:17 -0700
Message-ID: <CAF6AEGsJ1WyLttZcvkgJjxsHHxX-uyz6+yb4=xizqakeZrSdTQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] drm/msm/a6xx: Vastly increase HFI timeout
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
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

On Tue, Aug 8, 2023 at 2:03=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linaro.=
org> wrote:
>
> A7xx GMUs can be slow as molasses at times.
> Increase the timeout to 1 second to match the vendor driver.
>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # sm8450
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/=
adreno/a6xx_hfi.c
> index cdb3f6e74d3e..e25ddb82a087 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> @@ -108,7 +108,7 @@ static int a6xx_hfi_wait_for_ack(struct a6xx_gmu *gmu=
, u32 id, u32 seqnum,
>
>         /* Wait for a response */
>         ret =3D gmu_poll_timeout(gmu, REG_A6XX_GMU_GMU2HOST_INTR_INFO, va=
l,
> -               val & A6XX_GMU_GMU2HOST_INTR_INFO_MSGQ, 100, 5000);
> +               val & A6XX_GMU_GMU2HOST_INTR_INFO_MSGQ, 100, 1000000);

yikes.. so our default autosuspend delay is 66ms.. and we hit this
path in the resume path (ie. if you click something after things have
been sitting idle for >66ms).. you really don't want something in that
critical path to take 1sec

BR,
-R

>
>         if (ret) {
>                 DRM_DEV_ERROR(gmu->dev,
>
> --
> 2.41.0
>
