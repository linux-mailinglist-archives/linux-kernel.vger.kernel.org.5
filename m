Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2570A765F06
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjG0WNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjG0WNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:13:02 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FE812D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:13:01 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-c4cb4919bb9so1415854276.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690495980; x=1691100780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mgs3XoyVKvSXYQJGdno5tMM7wH8/lhpHnXzFG3+f28I=;
        b=k/+0Thgxr5YSZb4Hx0Scbv5fsz0foyW+ghVPq4QJwRqo0AwQodJcZ7LT72n8vuQmfY
         Pg0wxIkowCMCxaL8QOcgt6jXZtzYNR1rphLXCLpiP+pIgFpeLFvz5SpmzMCGoZ9YpBha
         pbwTv8t44a7YF+gbTsbx+d/8VYSKeik3htYipYXqs2Ec2gdwEMQNttqkRH00XciWTIkk
         K+K5iUeKOzaJqxQiYBpIK+bjOl69GTRKz+KQo/C6ik5Y9luIsf7tr/wL8pjW8nODfdB3
         5SB0fV1bxoc+S6IqkKV5h0kNcbTGzx+5bqTlGtmmqoYDTHzCEjXDZo0Dczu2KLmfo0A3
         M4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690495980; x=1691100780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mgs3XoyVKvSXYQJGdno5tMM7wH8/lhpHnXzFG3+f28I=;
        b=KM/ArbP59ETyG3MRKocBT0akbgSTrdgyu9Kx/3sn1ji172Xfwvk1zWTI71adkUheXt
         bfQ6qrqe3bNo/E12cLeZDn+Wu109UKaBctFxSnUkmM1BWASriExD879X5+AZq4/52Gx+
         G1DaYEmGsTwAGf1fu8g/FA5nQ/KtkjZkOHNL3x8XPdjLv1gVKhnKMZLafWWoekLwX/4m
         MnA7WzVDFWT7eR1AAB690thEeRMIB1OTAVzYWFbuZAvsXJt4ftMo6sfrzzsqpsOQBW4I
         haDrouMH6sd7wTS75OFIf6M8kzzqLq+keYGNv/Js2f8XfnIe+A9d2jFensShknabTTk2
         OlIA==
X-Gm-Message-State: ABy/qLafawIk/1etGuKs9Zeb6pGEjPpPE1IHAcGlppO8X4R3b1SJPFG5
        3REfT3QdKSWVGLx6oviscOTwWFwKFzMHFgWj1fZvUg==
X-Google-Smtp-Source: APBJJlETuE77rCp86MlShR/Cytch8bHfXHvuB6FjIXw2Ps7T35UKvb3xqfOxLvgy3n+kh/fDi1WBtt0rVJHyRIwj8+o=
X-Received: by 2002:a25:ad9c:0:b0:d12:1094:2036 with SMTP id
 z28-20020a25ad9c000000b00d1210942036mr658573ybi.43.1690495980400; Thu, 27 Jul
 2023 15:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230727212208.102501-1-robdclark@gmail.com> <20230727212208.102501-8-robdclark@gmail.com>
In-Reply-To: <20230727212208.102501-8-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 28 Jul 2023 01:12:49 +0300
Message-ID: <CAA8EJpouv1nAH1HfVBpAXfCK0Ub0-Jb-xpH=XuWa4CBOZ9abxg@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] drm/msm/adreno: Move speedbin mapping to device table
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Fri, 28 Jul 2023 at 00:23, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> This simplifies the code.
>
> v2: Use a table of structs instead of flat uint32_t[]
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 171 ++-------------------
>  drivers/gpu/drm/msm/adreno/adreno_device.c |  51 ++++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  30 ++++
>  3 files changed, 97 insertions(+), 155 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
