Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE92802305
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjLCLaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLCL3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:29:52 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32E01A4
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:29:58 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9f72176cfso6436131fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 03:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701602997; x=1702207797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L0LyKzKnnjQNBqpZgr3H1rimZEhXmRz8udpJ0Q/WYuk=;
        b=BGSI5SiarnJ5/Uo93YilEwgGfDH90dSNtTPLzPBRTjD1IxCa5SIXKXL/nvKMoy2z++
         5pCShdlE650yiyU07S4+OX969IRYW2yG31KvgyAOercHZF9gBHYspP5xO38ZfuaxIe1N
         FQDvwzECGbPW57V0kvU4SY8taJ3CgbK4Y3R4HISVlg4jpcWALQCkCGOWTdmahI8ATSN9
         G49fO7a2gPoLOHesmBcC8A7KTO6Ut/oXqO7AagDxc08OhHh716+W9kZyKAxaUS+8b+2y
         E277eidZIqZ42HfMBP+cnW4EjFxDoO3z2AI9aFWcGecOBRgs0/gwrTG9zsfZ/s49C91E
         J23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701602997; x=1702207797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L0LyKzKnnjQNBqpZgr3H1rimZEhXmRz8udpJ0Q/WYuk=;
        b=LVf9TNF+ag5f9ez4PvT2L6LUYYOkyPr7+lfASaSqaAgnO1GeJ1UKzw17vNcLhNZyzL
         g4M37fBxoMTfsH+falSjzUtJIPN0zZ0wkct5dI7Do1GEu8bmET7IICS7pB6EzilW8mHG
         NlBjRy8S4WNR3lDVeiTpNSI1n8R4R1C9S8T0ysS/s2nHaHB+Mr8nx9ow9ll0xcjYj0AW
         N/E4BStUri02V3P/TRt1s/HnXfzhXIRWgGrzMSRDf16qZsxjjvYG6hZOZGAUoy0lGBls
         E1mJtd4q1JXmNHJsKo8MqlpG2ZYfsxW8jQUejmT+U7E0F+FjvnzIKnDt1Xx6oNpetTAH
         +IsA==
X-Gm-Message-State: AOJu0YwFijeZB+DsPQGfC4fXKderGDrfObiYzMIRP5Ib/dyXxvCBpekg
        f1VghASg1W+EpyDOr7RyCfgRSg==
X-Google-Smtp-Source: AGHT+IGTWhetex2umS/MYFjg06ukzdRjs5bcWAHhEyNkgUiBPD5J1u1F0p2cwaRW9I0sqe5Y/14uTQ==
X-Received: by 2002:a2e:8483:0:b0:2c9:dae6:442a with SMTP id b3-20020a2e8483000000b002c9dae6442amr715352ljh.172.1701602997158;
        Sun, 03 Dec 2023 03:29:57 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id a39-20020a2ebea7000000b002c9f70a0419sm274718ljr.140.2023.12.03.03.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Dec 2023 03:29:56 -0800 (PST)
Message-ID: <2d5acbda-61a9-412d-bf9d-04a372c927c5@linaro.org>
Date:   Sun, 3 Dec 2023 13:29:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] drm/msm/gem: Cleanup submit_cleanup_bo()
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20231121003935.5868-1-robdclark@gmail.com>
 <20231121003935.5868-6-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231121003935.5868-6-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2023 02:38, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Now that it only handles unlock duty, drop the superfluous arg and
> rename it.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/msm_gem_submit.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
> index d001bf286606..603f04d851d9 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -248,14 +248,10 @@ static int submit_lookup_cmds(struct msm_gem_submit *submit,
>   	return ret;
>   }
>   
> -/* Unwind bo state, according to cleanup_flags.  In the success case, only
> - * the lock is dropped at the end of the submit (and active/pin ref is dropped
> - * later when the submit is retired).
> - */
> -static void submit_cleanup_bo(struct msm_gem_submit *submit, int i,
> -		unsigned cleanup_flags)
> +static void submit_unlock_bo(struct msm_gem_submit *submit, int i)
>   {
>   	struct drm_gem_object *obj = submit->bos[i].obj;
> +	unsigned cleanup_flags = BO_LOCKED;

Nit: checkpatch will warn here, it should be unsigned int.

>   	unsigned flags = submit->bos[i].flags & cleanup_flags;
>   
>   	/*
> @@ -304,10 +300,10 @@ static int submit_lock_objects(struct msm_gem_submit *submit)
>   	}
>   
>   	for (; i >= 0; i--)
> -		submit_cleanup_bo(submit, i, BO_LOCKED);
> +		submit_unlock_bo(submit, i);
>   
>   	if (slow_locked > 0)
> -		submit_cleanup_bo(submit, slow_locked, BO_LOCKED);
> +		submit_unlock_bo(submit, slow_locked);
>   
>   	if (ret == -EDEADLK) {
>   		struct drm_gem_object *obj = submit->bos[contended].obj;
> @@ -533,7 +529,6 @@ static int submit_reloc(struct msm_gem_submit *submit, struct drm_gem_object *ob
>    */
>   static void submit_cleanup(struct msm_gem_submit *submit, bool error)
>   {
> -	unsigned cleanup_flags = BO_LOCKED;
>   	unsigned i;
>   
>   	if (error)
> @@ -541,7 +536,7 @@ static void submit_cleanup(struct msm_gem_submit *submit, bool error)
>   
>   	for (i = 0; i < submit->nr_bos; i++) {
>   		struct drm_gem_object *obj = submit->bos[i].obj;
> -		submit_cleanup_bo(submit, i, cleanup_flags);
> +		submit_unlock_bo(submit, i);
>   		if (error)
>   			drm_gem_object_put(obj);
>   	}

-- 
With best wishes
Dmitry

