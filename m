Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17A1801FEF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 01:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjLCAI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 19:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLCAIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 19:08:24 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44938E3
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 16:08:30 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50bd8efb765so2790553e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 16:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701562108; x=1702166908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zdl2HKrC6VDqcQMieLin647Q0Xn6ap4MwvU9WaW0Y5Q=;
        b=GNl5uClE/anAmjp7JeAmYnV6SXAADbIPjPF7zlrprW5H+9xjbfKA/2KEElqwDjgqfv
         pdVHjgQ7twesp966VXRJJIqC5z2PBLxb/4ipPw8xIJAEavcgy1X/8pMLCUdWRUQw/rR2
         puCOZHM48lWXGjNY79VDkswAkUjiOl9MX5W3X4MZ3ZaCZlU5PS/vcQnSk/ZgC1LXP6Ew
         r7i4drC4aRCHjiQgH/RcB9KWN9g/6q3V3plrGEc9Ug9Ca6SkaI4FO5H74e0Fa0KQmcFg
         kwV129Aqj5NWSrNFBzKJUkAkb9AcLFapkjqXtbrneFupuoan0Wf68trRv2cgxxU/CquT
         2MLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701562108; x=1702166908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdl2HKrC6VDqcQMieLin647Q0Xn6ap4MwvU9WaW0Y5Q=;
        b=jtajmuL89X1hE9GqKHd8vHM7joeamaEzlEBuqcqbHHNr/HxP+W3AJa7+u+L1l4TYGI
         SAhjeBvfRN+HphWc+QSba+gtyv/cPS+OYZ1DoGNHItKJKY5GOid1E8NriFQwQvhCBwv1
         qDkhQnbeTKvPLcU9AsC+dFxn08j6vs4lREl9YQYKarc36SII+8g8vN0wdYin3Nx8LDcS
         gsAr6oI6SXSz6Yz09DSFubY1dMUOfY8Jxgc4KCpe9vjIglE1UortQMJkAktLoYvWgJCE
         LWzUnmu8WqNT1e6kBSnJlq1oO5ZLEBUroAXSwVyLZHGQGt/XF7yLlgdaxxwQAoSHbloy
         fU1g==
X-Gm-Message-State: AOJu0YzpnlNmNo5TUQ3cwOOHO7X4dOe9cxKiZIHIv2P6zfYmv3LvW9TL
        n4Op+ya8X337KKrCwnDdRKTm5g==
X-Google-Smtp-Source: AGHT+IGKKKovG+G/EKvfWVyIsAtKAdovDgxSn7t9v9ctBMOdpY6B633LhdgxF9RCRhAKLajhX41/FA==
X-Received: by 2002:a05:6512:b20:b0:50b:d764:969c with SMTP id w32-20020a0565120b2000b0050bd764969cmr2043149lfu.128.1701562108507;
        Sat, 02 Dec 2023 16:08:28 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id e14-20020ac2546e000000b0050bbcd68e8bsm830211lfn.47.2023.12.02.16.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Dec 2023 16:08:27 -0800 (PST)
Message-ID: <fa10b293-9c7f-4904-88bf-4ec6528bd0ef@linaro.org>
Date:   Sun, 3 Dec 2023 02:08:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] drm/msm/rd: Check PT_PTRACED for cmdstream dumping
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230914172453.9707-1-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230914172453.9707-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2023 20:24, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> So, when you want to get a cmdstream trace of some deqp or piglit test,
> but you happen to be running it on the same laptop with full desktop
> env, the current dump-everything firehose of `cat $debugfs/dri/n/rd` is
> quite a bit too much.  Ptrace seemed kind of a natural way to control
> it, ie. either run what you want to trace under gdb or hack in a
> ptrace(PTRACE_TRACEME) call.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/msm/msm_gem_submit.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

I think this is a good idea, to be able to separate process being 
debugged and all other tasks.

> 
> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
> index a908373cf34b..a105ca1f2102 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -979,7 +979,8 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
>   	/* The scheduler owns a ref now: */
>   	msm_gem_submit_get(submit);
>   
> -	msm_rd_dump_submit(priv->rd, submit, NULL);
> +	if (current->ptrace & PT_PTRACED)
> +		msm_rd_dump_submit(priv->rd, submit, NULL);
>   
>   	pm_runtime_get_sync(&gpu->pdev->dev);
>   

-- 
With best wishes
Dmitry

