Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4D87DAD3D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 17:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjJ2Qjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 12:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJ2Qjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 12:39:41 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4CCBA
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 09:39:38 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9ac31cb051so3008740276.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698597578; x=1699202378; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tl1cBv3dYTwBgbuAiIEubgr/5XL2B88gltLfW0waoWc=;
        b=C9+caUHTkwNAi3273qsVn7JSO9R8u5vmAbOBNjQol+iRUajvMtt5Kk4ZYYVu3fmbDy
         QKyMhWYTYZ/SsTZlBn66iW6C+yu5ZeZvkajyRYVZQqtL8klmTg1bKNVsAbe6eBun1pkg
         CcAyqtybaKt1uYYaNQMda4zZGuU6k0MJLEIatCW/Pn5wvsfzmihBz3LYsyFCe14Huzti
         v2MeFula89OhkHA3tCRvr2fbxt7ZoXOxsw5mdt9p98peyf16FrXRX9eSzu+3zXorDbMS
         Kqv+XEKcpAvoHiU38MHpKmXmMkPsQ/Y9aVCi8QyA3n9l+5D8ewBLUCVC29q+vTSxw14J
         O7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698597578; x=1699202378;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tl1cBv3dYTwBgbuAiIEubgr/5XL2B88gltLfW0waoWc=;
        b=pecrjkqbSlmvSndyZtWTh0vtLCwDRBqkDRf2nozlQuQmhq/6sfILpYZu0J6Hzlw3Du
         ljTEu1T31FFV6SlqyxihgfWfE86X/uU3B8k0AeNrEufDWRQ5sfSZW81JwM9nwR5CU6Fn
         vxFoOT1m/967QGxt+jBBhXyC4zWUmVnTSp1XRIDQy3caWxmnuHLBb35fTUGaVZc5UB0R
         PwvXIk8QanlXUiHRqWjrA+Pk8XyFcEWClYhuEuQyBHIgzifHVb4ttLidu8REZIf964YV
         NHuPigAJdcdkhJaOMWMeS897ks2thI3cy2YYU83qT9dRIf+IjIxz/nCiKFy+biLssAPN
         xPXQ==
X-Gm-Message-State: AOJu0YwlWdNTb15GwKYB51xKeMOSFGuBxpJu6ICO6DwOraAp31lrq7UZ
        JX3gMIitXvjc6kgiNFBCpVH2CUcAtTCc/U2twXraYw==
X-Google-Smtp-Source: AGHT+IGjPBBWyNNN0IUoNRwk6XwQlBXRCJ8+mgcNMtr7YdPC3bwRkZo25mPX9aJNUaKgoHKiqak2ZR6uslFegHWl1hc=
X-Received: by 2002:a25:d411:0:b0:da0:c64f:ea10 with SMTP id
 m17-20020a25d411000000b00da0c64fea10mr6985485ybf.43.1698597578053; Sun, 29
 Oct 2023 09:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231027194537.408922-1-robdclark@gmail.com> <20231029150740.6434-3-robdclark@gmail.com>
In-Reply-To: <20231029150740.6434-3-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 29 Oct 2023 18:39:30 +0200
Message-ID: <CAA8EJpp-pwho=GRX1WuA3TbNTdOjM57SR52-=G=LU3rSeifohA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/msm/gem: Add metadata
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
> The EXT_external_objects extension is a bit awkward as it doesn't pass
> explicit modifiers, leaving the importer to guess with incomplete
> information.  In the case of vk (turnip) exporting and gl (freedreno)
> importing, the "OPTIMAL_TILING_EXT" layout depends on VkImageCreateInfo
> flags (among other things), which the importer does not know.  Which
> unfortunately leaves us with the need for a metadata back-channel.
>
> The contents of the metadata are defined by userspace.  The
> EXT_external_objects extension is only required to work between
> compatible versions of gl and vk drivers, as defined by device and
> driver UUIDs.
>
> v2: add missing metadata kfree
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/msm_drv.c | 57 ++++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/msm/msm_gem.c |  1 +
>  drivers/gpu/drm/msm/msm_gem.h |  4 +++
>  include/uapi/drm/msm_drm.h    |  2 ++
>  4 files changed, 63 insertions(+), 1 deletion(-)

-- 
With best wishes
Dmitry
