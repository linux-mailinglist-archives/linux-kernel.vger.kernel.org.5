Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E2B7AEA3E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjIZKVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjIZKVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:21:06 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C693DD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:20:59 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59f6e6b206fso52229067b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695723659; x=1696328459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a7cJFhOb7t5Ix8iaURWtIsSLoskJCiWsX4e1QNdB7IE=;
        b=SFrSdNhzfDwXzyi4Z5Ryab1Gsf1+SlrMugcdgc7rxGBlx0VE0SLxP8u6xNYK7KZdwo
         IWs3xtTrYcOYpoZvBZeb+Du+0p4EZ0zWwA/FrsNkRNHjuOb/YnhcEJijP8H4Rf6hZAx9
         jwTArIT2z1ow6uH8xJuCtfvHrWPu7IE+fgsRnIS4d8Jz6j0mAtovyLwRAIICERR6jern
         BmzNBVW57zeFHmV62HWnmaAobs/mGwY0P67dhdUCPufj4KDRzQg74nrZpXgpi6997skP
         lR1+rYbr12354NDYFxTjljIuSB7E+8Ukt2qDOmY3hFjDiHsE6GwGFd9fRWZdBg8inxet
         d0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695723659; x=1696328459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7cJFhOb7t5Ix8iaURWtIsSLoskJCiWsX4e1QNdB7IE=;
        b=geQumsna5uGD5R9DYSE9EoauI+A5J8fqmWLcCN+k3js1XB63di46wavFgDdHWbZVzE
         A/FWZtLslYBlLxj/pBSUd6L78mYOeJipw2TSelYIsXzDA0jl8h638tjFBozV9cbAs2N8
         d/c1okXJ5VmUxsWE/qqUTC3k7xiTTA4yI5HNY0Z3CnZp/qXvZRR/0XmPQOYh0sM79/d1
         rPueVY5+Lve+dQbQjL5R3kuL6QONGubmO3UNQJX3YkbMFHyqXbY8dayC42Wo/BH834G2
         zg9Qmk6fqAeXYRXAMbO85jHabJBYqA712WLMrYUN6BoM9qTrF5jGz0YHXw8rqkGIU0C6
         2XKg==
X-Gm-Message-State: AOJu0YwYjKRn6rzBp0UICz6aholTFTO0SAkep7u9EYVkaoaMGDSLYO4h
        QkKJY3sqZ8Gli/FQvcIgUd52Uk7+cixxhaD0c9sDr29yVKlZdIFRnOj3mg==
X-Google-Smtp-Source: AGHT+IEWYOJ9taaGh0PkabxpCEUGNezaZuflzZehi3vKviCYxKZE7piisyJy7s6QgSXcRkCOW+2l/NpKDudM3y/juvU=
X-Received: by 2002:a0d:fb83:0:b0:592:9035:8356 with SMTP id
 l125-20020a0dfb83000000b0059290358356mr10373886ywf.26.1695723658832; Tue, 26
 Sep 2023 03:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230911221627.9569-1-quic_abhinavk@quicinc.com> <20230911221627.9569-2-quic_abhinavk@quicinc.com>
In-Reply-To: <20230911221627.9569-2-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 26 Sep 2023 13:19:52 +0300
Message-ID: <CAA8EJpq+rDGoC43F=S6Xb=N-V0J-4xB8gdB+M+dpK=USoA8D8w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/msm/dpu: try multirect based on mdp clock limits
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sept 2023 at 01:16, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> It's certainly possible that for large resolutions a single DPU SSPP
> cannot process the image without exceeding the MDP clock limits but
> it can still process it in multirect mode because the source rectangles
> will get divided and can fall within the MDP clock limits.
>
> If the SSPP cannot process the image even in multirect mode, then it
> will be rejected in dpu_plane_atomic_check_pipe().
>
> Hence try using multirect for resolutions which cannot be processed
> by a single SSPP without exceeding the MDP clock limits.
>
> changes in v2:
>         - use crtc_state's adjusted_mode instead of mode
>         - fix the UBWC condition to check maxlinewidth
>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
