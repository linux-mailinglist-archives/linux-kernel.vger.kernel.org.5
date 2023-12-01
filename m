Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE778004D3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377736AbjLAHju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjLAHjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:39:49 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8964A10FD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:39:55 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5d33574f64eso17669627b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701416394; x=1702021194; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r4ZRsjdL9I2iUGO1VnJG1tezBUm0g0FIW6dRQVzc5r8=;
        b=Bf8hLTZYbzzOYtoZPnVG+1UJauRzkOpd7ZOKV9os6r4cjs0pgJH3JjZIHaOsbWEzco
         +wHu7I3Z3K5ZijegIv57ahBhZy64Z9QeozUUFELWUU0rBosHKqdwutnjWhw4Sg0I0mxE
         nfDFM2o1F3dOoEZfV9F50wkFtoAEsTs7OAlY8b57PZtJwsyZvUMciA3CFtjgZhiaJt/W
         vzo3RwddA66dRxUeYdvR8ukLul2tL99JTu4CZpTCVtXKAy1YK7TVRWGbWKBjC+x0hpEc
         EI+zElkAfQjzDwsct5Fat6WUatKyHlHtqb9L0Osg/Y6NWH1nmX1vooAgYBRmjENu/yyL
         P41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701416394; x=1702021194;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r4ZRsjdL9I2iUGO1VnJG1tezBUm0g0FIW6dRQVzc5r8=;
        b=SH5bfFke7WjW8RS27m8M6NQybmT0xcBhp/HvO59xhvoh3iiAO2oaCKJbtQiVX3q6B3
         tD/wsE7NbkRhYpuySGCL5mKHbo6PldHxqhZ1X1nlQc1oWG4fSlNnOEty8SA3tLs3B7Su
         CKzmLQiQoShmYUNjn4fTFJNR3znQa6gjEtYi7icR/Yp/DDT7UnJmGwjlzorEaKbLAesG
         LnmgJNqBRro7NLcWvgjgy1FWyH2wdXsLlWhrAeDUZFhefbVgT2BTuBg6EuxEcafJK9k4
         LvtuECh0ZFSn3H2WQcK3XlUiNbV/6MQGPqt6RFEDs69kXMJLWqwP4mGHIz5JOGp99f0r
         7Hzg==
X-Gm-Message-State: AOJu0YycsiIzA5QeHy5NXr/HHn6KJTw7DE8kNe1wE36wA32Fmi9UDsBf
        xXmxjicbZ7Wa+5282nVViz1fF0U8pIeJwHV+ZIBdzA==
X-Google-Smtp-Source: AGHT+IG6YJFYpxxDEGA5/9WsFpWY9Xkeap+TYkek9J98RCloSx+NNN/prVWH9iqo7eEB0Fko9lDJ0o8Q44uv8RIxQR8=
X-Received: by 2002:a5b:ec7:0:b0:d9a:4cc2:1961 with SMTP id
 a7-20020a5b0ec7000000b00d9a4cc21961mr21395804ybs.26.1701416394767; Thu, 30
 Nov 2023 23:39:54 -0800 (PST)
MIME-Version: 1.0
References: <20231130-encoder-fixup-v1-0-585c54cd046e@quicinc.com>
In-Reply-To: <20231130-encoder-fixup-v1-0-585c54cd046e@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 1 Dec 2023 09:39:43 +0200
Message-ID: <CAA8EJpof5LO7pyXaqgtbL=sL2a2Te2tzLF-NrTFT7n58pB3iww@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/msm/dpu: INTF CRC configuration cleanups and fix
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, quic_abhinavk@quicinc.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2023 at 03:31, Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
>
> This series drops the frame_count and enable parameters (as they're always
> set to the same value). It also sets input_sel=0x1 for INTF.
>
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
> Jessica Zhang (2):
>       drm/msm/dpu: Drop enable and frame_count parameters from dpu_hw_setup_misr()
>       drm/msm/dpu: Set input_sel bit for INTF

Please change the order of the commits: fix (input_sel) comes first,
then comes the improvement.
Otherwise if one needs to backport this fix, they either need to pick
up the irrelevant patch, or they have to rework the fix.

>
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  4 ++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  4 ++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c |  6 +++---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h |  4 ++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c   |  6 +++---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h   |  3 ++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c | 18 +++++++-----------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h | 11 +++++------
>  8 files changed, 26 insertions(+), 30 deletions(-)
> ---
> base-commit: 4047f50eb64d980fcd581a19bbe6164dab25ebc7
> change-id: 20231122-encoder-fixup-61c190b16085
>
> Best regards,
> --
> Jessica Zhang <quic_jesszhan@quicinc.com>
>


-- 
With best wishes
Dmitry
