Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8757BCFEF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 22:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344512AbjJHUAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 16:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbjJHUAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 16:00:04 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDECB6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 13:00:02 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d862533ea85so4580491276.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 13:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696795202; x=1697400002; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2eWQS+wABqdAVoM6ZVRN79K1EujhH8FxWaSNWwoMdbY=;
        b=Pzvu0ddZgTCeOhv2kn2oNwki2EtIHQFyBXTUXgl1JWltu79lg+MkILnJMV2DYWxV1A
         5GXvHGUmLdHnlb+M54cBfzuXsmsU9eL5pWNO0FTTqj1fEZfey+3JSGFEb/YtL5UTtZNE
         YWLLMKQewH28cfUK4cZLVUmUe7qGXO1XTCZwlJCq4WD3+YiEAmYg+5VeQnUHjyos2NaS
         ZYdWgEyBWuoMTi2/BDeIILmLfTiI8vJuge7xZVmSfiVI7K8WFT10xHsGc72+vrgH14uZ
         IeaKD0Y6Hb9kfmAAeQ8WdkSi8GsWAiZksaIjhGCokwCUBLdxfI/ZD6uPFCF+j97HcgYT
         /B4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696795202; x=1697400002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2eWQS+wABqdAVoM6ZVRN79K1EujhH8FxWaSNWwoMdbY=;
        b=bvEaRm/s4/ByMuOPwU0rfiPYgC9EeK8g8nFTS/c2rBuC+EUZ0k+FGPWIwIwfrjavv2
         TzuRLCB3NyK8H6ba0KRb8yTr+WnqwkOJsiMPCtzOe3k8j9lc9zmS5a98gEKGgGEtlT18
         +/7y1f5lwjs9WmNSx5GUZJjteqluu907PImGOKTQu1lncdCh4IbHAmB2O0wHBTnNzPZT
         myJk+EYAvg9TKKZ8AJ2gKTFahMq3ppLf1TbBUpBS32M9n++k74WwJK28kfFEPsQuWMcZ
         tbSGpUMODuxm/7A8IVjMXr0/fscpZHufNztxQuJH8vjDBLwoFF5SUbsYGUTaAMVUK+TI
         u9aA==
X-Gm-Message-State: AOJu0YxQsGyI7XZl5Q7A559DLEHHLevahGJMjR5n2fPFRU81Xl7zjPj8
        1dTAZaURrx6TFt1RgYdZR8iAVIz7FkDURBYmM0mVXw==
X-Google-Smtp-Source: AGHT+IF5uHocDVEehYHwATnyUF2wBSy1xa65UxYQAxkUfPBXcnqMQFryQVME6DT00RvcJN2KycDZLyIzKS1iEqzbLvg=
X-Received: by 2002:a25:5503:0:b0:d91:c488:5b65 with SMTP id
 j3-20020a255503000000b00d91c4885b65mr8239359ybb.31.1696795201929; Sun, 08 Oct
 2023 13:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231008175615.413497-1-robdclark@gmail.com>
In-Reply-To: <20231008175615.413497-1-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 8 Oct 2023 22:59:50 +0300
Message-ID: <CAA8EJppgUmkLrhTw779tq5wkgXfu4sypGrQbJFYtrnCrbwa3=Q@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: Use the encoder for default CRC source
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org,
        Helen Koike <helen.koike@collabora.com>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Daniel Stone <daniels@collabora.com>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        open list <linux-kernel@vger.kernel.org>
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

On Sun, 8 Oct 2023 at 20:56, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> i-g-t expects the CRC to reflect any applied CTM.  But the layer mixer
> source is upstream of the DSPP, so it is before the CTM is applied.
>
> Switch the default source to 'encoder' instead so that the CRC is
> captured downstream of the DSPP.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/ci/xfails/msm-sc7180-fails.txt |  4 ----
>  drivers/gpu/drm/ci/xfails/msm-sc7180-skips.txt |  5 -----
>  drivers/gpu/drm/ci/xfails/msm-sdm845-fails.txt | 11 +----------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c       |  6 +++---

I'm not sure, if updating the CI skip list together with the
functional changs is a good idea, my preference would be towards two
separate patches.

Nevertheless:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>  4 files changed, 4 insertions(+), 22 deletions(-)


-- 
With best wishes
Dmitry
