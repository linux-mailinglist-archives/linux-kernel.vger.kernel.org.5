Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A28476C98D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjHBJfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjHBJfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:35:53 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B35E7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:35:52 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe426521adso3141484e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 02:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690968950; x=1691573750;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pohg9zSaMOJCBUazSnms5q/h+HApb0cmdo5z/ZK/mUQ=;
        b=ZC+Grn4yM3PgtUUEkhcgq4sTNTV+3REq8KjNQiY1swdBRWPGO3kM790yIOM832qrp0
         nFwJMjrgw9cXxoLFcNhPmV4TmmCujAh85rXMbvW0RDAai+cuLYpsHqiLWOuUnGrE4o8M
         CG3tlLBcmXglNsuW9MjYctyhnvDq6qtHyS8AmzJTTn6GZULEradARsrD5gZkINDvC5qL
         m/7nuSeWzA1qccmWZcCEYR0LwNOojikWz2tTv4cOEB5FbizxJZIQMPo4xHJqKTZlgOi6
         spaF+F4YD5qgUeMGcUos8qO5FSiZqL0d+p0IYy59QfsK7oiiKCa4lFzK114iZi+3X6QN
         uVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690968950; x=1691573750;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pohg9zSaMOJCBUazSnms5q/h+HApb0cmdo5z/ZK/mUQ=;
        b=ItfZu4RLXvdkpmr5BIj6J8zpuAkP74GRBszdxxl0wMNwze/oPR+3npkF4Wt5UsABte
         i0HSgSHz/6ijLbc2wKJ/G6HC6iQpyudZvIV5Rm9cNkt4GtdJIM5OhXmtG4eE1dVvgflL
         1qEB0abIMly+psZApKMBfwvhbJrJZOZrbgV30549J1HOcn0LgB6MMuPG92HRhPII/+RQ
         ujoFIotUk64SOHd8hY34yWDI0tsUQfV5joQUU/+xZXq3N9DCMJt0EgT72miNc+CifP9p
         MYv8q4pWWmCQ5rBY52jRP2hZWTWcXICiwjKn9pm+TbOJ25L6ezckxdODheadXXLrVH4z
         TKUw==
X-Gm-Message-State: ABy/qLYFzaaSE5ZsPfliCUI6UnPIGxFaOzCcpkB1b5KauoEbMjsXFyAz
        bsjKFTUd32Qq7vqhbFV9zx6fVE382SbMwB3HWBc=
X-Google-Smtp-Source: APBJJlHJTVMe30C4pbnicvRVJ2SsKv2DoOIoce/FePG1RZbhSiexihUJ5NXl7ZGcJyuxBNgNRnGWHg==
X-Received: by 2002:a05:6512:3b2:b0:4fe:df7:bcf5 with SMTP id v18-20020a05651203b200b004fe0df7bcf5mr3523141lfp.8.1690968950204;
        Wed, 02 Aug 2023 02:35:50 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id k19-20020ac257d3000000b004fb8c31c8desm2909996lfo.208.2023.08.02.02.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 02:35:49 -0700 (PDT)
Message-ID: <131f9c51-10d6-c4b4-4e7f-c3c30480d385@linaro.org>
Date:   Wed, 2 Aug 2023 12:35:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] drm/msm: Remove redundant DRM_DEV_ERROR()
Content-Language: en-GB
To:     Ruan Jinjie <ruanjinjie@huawei.com>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch,
        quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230727112407.2916029-1-ruanjinjie@huawei.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230727112407.2916029-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 14:24, Ruan Jinjie wrote:
> There is no need to call the DRM_DEV_ERROR() function directly to print
> a custom message when handling an error from platform_get_irq() function
> as it is going to display an appropriate error message
> in case of a failure.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>   drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 1 -
>   drivers/gpu/drm/msm/msm_gpu.c            | 1 -
>   2 files changed, 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

