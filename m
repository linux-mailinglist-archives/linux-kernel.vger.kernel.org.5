Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADE1812130
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442730AbjLMWGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjLMWGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:06:52 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18638AC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:06:59 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5d226f51f71so72965727b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702505218; x=1703110018; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IiZLeydFv0dQoVsgTLSTJeU50o5YR4HggKIDBADvvDw=;
        b=lx7cLn9NdZt9/bqftOe4XWKSKIHu7IpyaeHvgAJ3gDzGuViTRgwVdycjSw2HtSVIj+
         ygOR15I45/tubqZmdKN0C26uPQZ/pb03iDVMN5X9Y1xsQpCZIPVY++zmQXlmnvRYbUE8
         uI8CztcZcSKSkUMTuBhmsVYQpjKjlDJfIdW5Lmlx24t8f6NAOOPWs58miXMF4YGnE8Gs
         L3+upSEGq0sYQ0dQ8bTTQN65lS2FdbBhvGbe3d1ACFC+uxkUsYBnfUOLxU8kn5dfkodg
         bWOuLVrj+gFbi8jdjMukaKmlWYsMUDJkwBmA+gmKv7zOQrkXUV5ujqT2qiIlrof3ZNOD
         kHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702505218; x=1703110018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IiZLeydFv0dQoVsgTLSTJeU50o5YR4HggKIDBADvvDw=;
        b=Y0epY17NlRfqcKE9/heKj9lcdySlL85/52bblB5Xaf6bPu2KN4/8W0tzVBatA5NRVk
         uuFZ71p2SwefeKIhbHHHxaACOo1g27pXjyemi6RCGUXrHl0AuxNw7JvbDwEHiljkThaA
         AGDdFIhln4XjXwa6gaLz3k5UKnWsTF5ehcPhQqgbJSu+UOqFE0l50kQp0uE6gTefwldL
         CQF8H6L0adrqGesUmJ+Lmv//fkgKvmM1IqKmjTfVgabU53adD0E7bsEb+spxwAiSnZio
         qJa/wR3aFKhGBgAmEz1EMelZygHOVO656lrbOfJfEEWLHnpflPgrVEr91a0M/acXRg0l
         cv7w==
X-Gm-Message-State: AOJu0Yz3X8OGrDnsOZcP25wSHVkOVL9Zr2lBn3SdJ4De6Uje37qV0WvZ
        o9PTADXKaAWSVr9xD2PnJUpUo9WrWCnOky6TRnelag==
X-Google-Smtp-Source: AGHT+IEr68TyT/QvLeseprICEqjDcN/rRoj0lk5BxuC5payzc9s1YVNN9YYwQvjCujY3WsP7jPO/aXoRaDtxmbQXGKo=
X-Received: by 2002:a81:5ec2:0:b0:5d3:977b:d632 with SMTP id
 s185-20020a815ec2000000b005d3977bd632mr8471435ywb.6.1702505218315; Wed, 13
 Dec 2023 14:06:58 -0800 (PST)
MIME-Version: 1.0
References: <20231213-encoder-fixup-v4-0-6da6cd1bf118@quicinc.com> <20231213-encoder-fixup-v4-2-6da6cd1bf118@quicinc.com>
In-Reply-To: <20231213-encoder-fixup-v4-2-6da6cd1bf118@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 14 Dec 2023 00:06:47 +0200
Message-ID: <CAA8EJprcH22ouehetL4uNwUuroRUc9q6swGZo1GjuGuCRZDv=A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/msm/dpu: Drop enable and frame_count
 parameters from dpu_hw_setup_misr()
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, quic_abhinavk@quicinc.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Wed, 13 Dec 2023 at 23:30, Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
>
> Drop the enable and frame_count parameters from dpu_hw_setup_misr() as they
> are always set to the same values.
>
> In addition, replace MISR_FRAME_COUNT_MASK with MISR_FRAME_COUNT as
> frame_count is always set to the same value.
>
> Fixes: 7b37523fb1d1 ("drm/msm/dpu: Move MISR methods to dpu_hw_util")
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  4 ++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  4 ++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c |  6 +++---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h |  4 ++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c   |  6 +++---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h   |  3 ++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c | 19 +++++--------------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h |  9 +++------
>  8 files changed, 22 insertions(+), 33 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
