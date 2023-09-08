Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B137992BF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 01:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345079AbjIHXST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 19:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345065AbjIHXSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 19:18:16 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F79E46
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 16:18:12 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d7b89ae27d3so2253994276.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 16:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694215091; x=1694819891; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NJMUBhG0eoBNMSnOz1KraejVtnxEE/dXjjdZnrGqmlg=;
        b=MV9zkB6B/Tv9qsvUIy1cOaU5dTmzZ6tyR1eV72uFAt+jVmoG5+RsPoPDVotMUVUG+n
         KbMITwp0hCErEF5a4xsi/bQIXE+KjNT8V3GpApTBB+Ix52vEq1E5InLHksEwobIwXhVJ
         GEXRgKJVHR9hdi8NNPdLM9VQiwgygrEP6T/JzVzkNdqJgcnOY1ESWpCeDs3g4LChtO7/
         Yv7+oRhzn4kRDWyoFF38vxSjphH4dRwvXBBwNLVPMKdTx9rU+wpRGQYb+V+Ig6rtxuPj
         5NnVJg++gsh6u/r29u+d8awEc5sifX532K8msRG9I3fQk3etoVi7Ymo/ziEo0S28zMx4
         GH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694215091; x=1694819891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJMUBhG0eoBNMSnOz1KraejVtnxEE/dXjjdZnrGqmlg=;
        b=m1nQGWL12Lv8eR4arC4GUF7Ak9w9qOkp2uYNFIVuW6g0qGV5iCHbMcD4aZweGIENf+
         z1NMsf7pGl0UwHKYQqrQKhZwB4X0wCR+1NFvlQmr9ovFPYS+STH8HYi4RTOMnh1sFoa/
         +MRmlUbDUrC1yKOw6qliNc+67xf+8klH816kR/XDNDQl5xRWalmd8a8/yN1muaG/AzgZ
         0y7yDjCys19i13TSztANj3XCoqkwENP+9nNZ80MtjPaqbmNRh/FS7Dv440Vu4BXJ5Mjd
         TRdkgludSFYmlWTgjuTJw+bi+IMvSnZ7saRwa80nD4lu9GUKigYpeXzeSAzSWdZV8ooV
         AnHQ==
X-Gm-Message-State: AOJu0YyoAokg+uEvUMWvtC0k1vB9lgbvQlIMJIp6Rp+ke/kKfftaVn+k
        Q5nJk1yjwl2doDjAfsex+4VErMHyhh+sa21Dq/H1xw==
X-Google-Smtp-Source: AGHT+IEHwQi9VCn0Ewp1OpyUXVY6DBAkAsvUro6YE8dOwPuGcphb95UIrrUWzqBjJD0FOWCSZ/X/MBXn68aBCYeLzAU=
X-Received: by 2002:a05:6902:1895:b0:bc9:92c9:7fd1 with SMTP id
 cj21-20020a056902189500b00bc992c97fd1mr4692606ybb.3.1694215091567; Fri, 08
 Sep 2023 16:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230908193314.27008-1-quic_abhinavk@quicinc.com>
In-Reply-To: <20230908193314.27008-1-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 9 Sep 2023 02:18:00 +0300
Message-ID: <CAA8EJppXTpTW=Q2N_wJ_VUYeQDagRYqYXHJBBhNWFv8asYPKJQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: enable smartdma on sm8350
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, nespera@igalia.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sept 2023 at 22:33, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> To support high resolutions on sm8350, enable smartdma
> in its catalog.
>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>
> Notes:
>     only compile tested, to be landed after sufficient testing

I'll test sm8350 (and hopefully sm8450) early next week.

>
>  .../drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h   | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
> index 8da424eaee6a..a32d235ff08e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
> @@ -82,21 +82,21 @@ static const struct dpu_ctl_cfg sm8350_ctl[] = {
>  };
>
>  static const struct dpu_sspp_cfg sm8350_sspp[] = {
> -       SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, 0x1f8, VIG_SC7180_MASK,
> +       SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, 0x1f8, VIG_SC7180_MASK_SDMA,
>                 sm8250_vig_sblk_0, 0, SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG0),
> -       SSPP_BLK("sspp_1", SSPP_VIG1, 0x6000, 0x1f8, VIG_SC7180_MASK,
> +       SSPP_BLK("sspp_1", SSPP_VIG1, 0x6000, 0x1f8, VIG_SC7180_MASK_SDMA,
>                 sm8250_vig_sblk_1, 4, SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG1),
> -       SSPP_BLK("sspp_2", SSPP_VIG2, 0x8000, 0x1f8, VIG_SC7180_MASK,
> +       SSPP_BLK("sspp_2", SSPP_VIG2, 0x8000, 0x1f8, VIG_SC7180_MASK_SDMA,
>                 sm8250_vig_sblk_2, 8, SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG2),
> -       SSPP_BLK("sspp_3", SSPP_VIG3, 0xa000, 0x1f8, VIG_SC7180_MASK,
> +       SSPP_BLK("sspp_3", SSPP_VIG3, 0xa000, 0x1f8, VIG_SC7180_MASK_SDMA,
>                 sm8250_vig_sblk_3, 12, SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG3),
> -       SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000, 0x1f8, DMA_SDM845_MASK,
> +       SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000, 0x1f8, DMA_SDM845_MASK_SDMA,
>                 sdm845_dma_sblk_0, 1, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA0),
> -       SSPP_BLK("sspp_9", SSPP_DMA1, 0x26000, 0x1f8, DMA_SDM845_MASK,
> +       SSPP_BLK("sspp_9", SSPP_DMA1, 0x26000, 0x1f8, DMA_SDM845_MASK_SDMA,
>                 sdm845_dma_sblk_1, 5, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA1),
> -       SSPP_BLK("sspp_10", SSPP_DMA2, 0x28000, 0x1f8, DMA_CURSOR_SDM845_MASK,
> +       SSPP_BLK("sspp_10", SSPP_DMA2, 0x28000, 0x1f8, DMA_CURSOR_SDM845_MASK_SDMA,
>                 sdm845_dma_sblk_2, 9, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA2),
> -       SSPP_BLK("sspp_11", SSPP_DMA3, 0x2a000, 0x1f8, DMA_CURSOR_SDM845_MASK,
> +       SSPP_BLK("sspp_11", SSPP_DMA3, 0x2a000, 0x1f8, DMA_CURSOR_SDM845_MASK_SDMA,
>                 sdm845_dma_sblk_3, 13, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA3),
>  };
>
> --
> 2.40.1
>


-- 
With best wishes
Dmitry
