Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05137D63FF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjJYHuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbjJYHtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:49:52 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F170CD43
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:49:49 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9beb865a40so4853453276.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698220189; x=1698824989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1mPZL+BmecJLI1raShNlD/spbj5/yWrHF1o5a2NHN48=;
        b=F41nMFxQCLRlb1zFJ9QolQyWwfV78A4YMpbFgLf4BJSWaOTwhcRCxQ+E9xw3pmjnm1
         TfoKNWZV1SHjsDM9B/iHumGYe1gQqZlT5G8RXi02qOJKhCwALBjeqY7rl3Ih+XHoaCRp
         C0Lkix7vcmf3LEeuTqW7TTHymsnaKANs5D6IvNmb0nwe3lPAMkScdC106wH1nGqNjNan
         ovabrbGT1pv58aToeGO1d8CSFnGFFWNz0bd52Y7rdkTvi3R3Ao8qr4ZhjfhCymtUZjMt
         VxFZQ0B2ZWx9kcj/Q2bRK6S91RA3dFL9PO4yQcNkc6C7A16ZyCLNkUyA0j+5CPLHU49p
         LRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698220189; x=1698824989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1mPZL+BmecJLI1raShNlD/spbj5/yWrHF1o5a2NHN48=;
        b=OFpOLT6GiFdS93NOwzyssj18spG6mamiLxfWaglHBISM6RmtOUoboXHnjU58ZtDrNx
         G0FvXkQpuewtXlKmOdSbvQ+UAp5v1PgfJYNxdszU98eVJrtA0RQ5ojIUibufMuhip687
         w7vvqkyGql5XODsvK4gj6RYwZ7t4p/fFoSOrXiYXWck1yVPGWCXbuZn5hvp/cW15MEqs
         hEC8PfjqinvFsFSRqAv7w3SUD4tTrrw4Oygu7+reIVJbqOJku77/L2SF036oe8+8caSZ
         lsIKkwZldtG5fpVHcH+HYcvw6f3zm+11eCG1x77+XRHEtEMX57g16yAVITq0pm01DtS8
         Kpyw==
X-Gm-Message-State: AOJu0Yz2JHeL4gUElMIvRBN4FF4UCBuYVBzF7LIVAKPnIGmLHX+cD2BC
        ySaB13RuECLqyjcxgoA5wWAijzNFdi3g8M5m0MUxuw==
X-Google-Smtp-Source: AGHT+IFkibsCTPletgNIKgRFCG8zEbKtKhuMRGWu9dJ/Z2gpcZTNPiloV3NsJSBSfNWJPl9BX6pmshk2fW6iQLs8Y18=
X-Received: by 2002:a25:dc04:0:b0:da0:4576:3689 with SMTP id
 y4-20020a25dc04000000b00da045763689mr3713196ybe.25.1698220189116; Wed, 25 Oct
 2023 00:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231025-topic-sm8650-upstream-mdss-v1-0-bb219b8c7a51@linaro.org> <20231025-topic-sm8650-upstream-mdss-v1-6-bb219b8c7a51@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-mdss-v1-6-bb219b8c7a51@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 25 Oct 2023 10:49:38 +0300
Message-ID: <CAA8EJpqSuX=BL3x7p3SUaRQ8JLtVOQNM4Cf6LojYKV66OyOJqA@mail.gmail.com>
Subject: Re: [PATCH 6/8] drm/msm: mdss: add support for SM8650
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 at 10:35, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Add Mobile Display Subsystem (MDSS) support for the SM8650 platform.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/msm_mdss.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> index 6865db1e3ce8..33947a2e313c 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -621,6 +621,7 @@ static const struct of_device_id mdss_dt_match[] = {
>         { .compatible = "qcom,sm8350-mdss", .data = &sm8250_data },
>         { .compatible = "qcom,sm8450-mdss", .data = &sm8250_data },
>         { .compatible = "qcom,sm8550-mdss", .data = &sm8550_data },
> +       { .compatible = "qcom,sm8650-mdss", .data = &sm8550_data},
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, mdss_dt_match);
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
