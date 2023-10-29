Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5F87DAD40
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 17:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjJ2QkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 12:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJ2QkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 12:40:20 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71A0BC
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 09:40:18 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-352a22e1471so14326655ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 09:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698597618; x=1699202418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9bWPCuhLl7Eu2Wz5OYZ1UnKjf97K54GCVXL6Pmup34=;
        b=kz33E5mc9prvV3K8aJVBpPVgqPSWXTzN9+0lsOcgtcO98QQ5138ivCRC7vT96H0X0w
         lwYLbsP8ZTOeUqUYq0iCga/7FW00bsPaB5+6aybwI8xqM2BQ7X/YRflA6LYpwH++7Jyv
         jT8CZfMZPDgzFQDAzpu4PrCaKoSZkhuTiQ2x5wTNiotzGQpQ9zThkSqA7TPmvH88x5Mf
         yh5rL2fbL+Qz0e2lZrU5OdjfSF57smhnzOZAng/XkLcsoSjjQXfe0C6TtMcHvzZ5Xn+E
         uPdTCEY5IMqrn+mwEHAVIhUC5o6WzWgQItzD+0g8d6hfiNHm4a+DNiYH6BozJquR80ul
         FEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698597618; x=1699202418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q9bWPCuhLl7Eu2Wz5OYZ1UnKjf97K54GCVXL6Pmup34=;
        b=mXsPp45EA2Rj63mgiZuF4wTWlST6VhA4kLX5lKun2ne5gqCVWe/HE9LiuSpZwpuXcq
         zbcCIlT2pHUtAxIEGlPjKwqhzTBLFqaJEHLyaHfKEw6uuI66Fj/MUBWzzhzxwBrL8QeN
         VK1R5f5zCaXqgiCGaAQI0zbXCCZ2QGsrrkg2anSLHTrfucnxUcQ4Jc6dCy2IEWZ6K5uk
         Z0PC5g3tlRZAjJMRRU0dtO9qdyP8jJHO1EQSUtf8RE1xGRsQ+RJzQYKZ1EKcND3aDeDr
         TiZXOoK/0hPALxpVwwyzazblB5f2e2XtB+TV+X0x09evf9Qi7VwjgYO5L1p8o43Rxdml
         HtAw==
X-Gm-Message-State: AOJu0YyhLsz8EuZvkLXwgUfWSiMol9l8wNW7Y2i3emmnwsEpPAI7QBNV
        ZsCl7AJXKTXVeM4i+YB6xfeEwVKSUlPY1Bh8yqSDgA==
X-Google-Smtp-Source: AGHT+IEMTTkd3iokIkHgwuWImh0kMLQCmV4IUjrrsJzeTsT2AK9xdWYaJqUNFO6i6aN3ig0Ep5iZuNbQcrZQnQdocIc=
X-Received: by 2002:a92:c266:0:b0:357:5db1:9170 with SMTP id
 h6-20020a92c266000000b003575db19170mr10291105ild.28.1698597617965; Sun, 29
 Oct 2023 09:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231027194537.408922-1-robdclark@gmail.com> <20231029150740.6434-2-robdclark@gmail.com>
In-Reply-To: <20231029150740.6434-2-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 29 Oct 2023 18:40:10 +0200
Message-ID: <CAA8EJpqK6uGDrjzhSq7zhGtcqsT7G3LEAj7cZKUex15E4uTK+Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/msm: Small uabi fixes
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniels@collabora.com>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2023 at 17:07, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Correct the minor version exposed and error return value for
> MSM_INFO_GET_NAME.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/msm_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>




-- 
With best wishes
Dmitry
