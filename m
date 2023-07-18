Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6BB7576A9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjGRIfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjGRIfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:35:22 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D76E6C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:35:19 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so8816999e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689669317; x=1690274117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jltQbt/ysIAO4H/U9iLsKGNjKI0zGdvEg+c0SeC+Iy4=;
        b=Y625WVzDH2hu1noq7lharO4SSHOSzvbFhJLomuztmWPCkE78l33miNwR8+8oRSk08H
         R+gNB4PYy4h5knWIl+aljH0ZEI/F2N04MvCnlXAXX/02gZrHo6yUEUdGcFzrKi0AP8a2
         ErK0aJFTOpkMGwIXEhqFMBsr6Jrziwv9xLeqL/dThbCEuPBptA/73E0Qc6ZC9zcqUSCL
         KigjjLzruKojsDHPcm66KEQpnGZnVoAm4LGT3hdKz/to/utnzaIwxM24J6I1V++5SRS0
         rdmnj8a+IdfD7+/rG+GtbFFBz4T4fXxl3EifQbbnqhd95wbmKsKF2pUv6+7R5qzhd0qX
         J38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689669317; x=1690274117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jltQbt/ysIAO4H/U9iLsKGNjKI0zGdvEg+c0SeC+Iy4=;
        b=cHjG04XFnosGkrxUlycvVPA2LUMNxdn58DW+TEQMmuXHnEsmXoral27Yfu0cD33sZ/
         cqvMTBCXzLipa8C0Gn3LLH5gNWwsPwFIN6/aEcyPX9fjroWe5BDs5b/wn8olXMipKnji
         nMEwNQnl0H/d5MMvD/OAo+xkBD+zjnOVVPxF4hjWkpJeRN07iA61UaFlt+SiMqrqQ7lb
         Q3DJUzNbcYnGQuC086lwbF7gD/to955lxRYVxl67H8MDsNiEy+4jgig+AO9KYD/PR/mO
         icVSl+SzXHY8wD/XgUbfXAzzlwogR4Z2sWZalVZHW7ol+X5AZCJqHz/TXJt8SqGAbjGr
         C3bw==
X-Gm-Message-State: ABy/qLYWjTOCavIwJEXmnRfvFSChYOAnhTXT7M4HvyEizyJXCk95+Zah
        vdV88ML0pWkTEN7tZ65LEWZifg==
X-Google-Smtp-Source: APBJJlFVA7urEp30BxkywhvnadVtbxL9hADGcHBwielyCquDoPYHQ+RWgxsqsAKJJ2HUyq0sN6o5Gg==
X-Received: by 2002:a19:911e:0:b0:4f9:5ac3:4133 with SMTP id t30-20020a19911e000000b004f95ac34133mr9402162lfd.25.1689669317695;
        Tue, 18 Jul 2023 01:35:17 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id q16-20020a19a410000000b004fdc0023a47sm323058lfc.238.2023.07.18.01.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 01:35:17 -0700 (PDT)
Message-ID: <c2d21b04-d400-83ec-9e63-87f570c5cfd8@linaro.org>
Date:   Tue, 18 Jul 2023 11:35:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/msm/dsi: add missing put_device()
Content-Language: en-GB
To:     sunran001@208suo.com, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230718083149.17178-1-xujianghui@cdjrlc.com>
 <225e67f32dbc423daa4a83bc0c4f2179@208suo.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <225e67f32dbc423daa4a83bc0c4f2179@208suo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 11:33, sunran001@208suo.com wrote:
> The of_find_device_by_node() takes a reference to the underlying device
> structure, we should release that reference.
> 
> Detected by coccinelle with the following ERROR:
> ./drivers/gpu/drm/msm/dsi/dsi.c:50:1-7: ERROR: missing put_device; call
> of_find_device_by_node on line 32, but without a corresponding object
> release within this function.

Still NAK, the device should not be put. It is handled in dsi_destroy(), 
as I wrote in the previous email. Please stop.

Note, your patch lacks versioning and changelog. Please care to read 
Documentation/process/submitting-patches.rst before sending your changes.

> 
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/msm/dsi/dsi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
> index 81461e8852a7..5e3cc287f0d3 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi.c
> @@ -46,7 +46,7 @@ static int dsi_get_phy(struct msm_dsi *msm_dsi)
>           DRM_DEV_ERROR(&pdev->dev, "%s: phy driver is not ready\n", 
> __func__);
>           return -EPROBE_DEFER;
>       }
> -    put_device(&pdev->dev);
> +    put_device(&phy_pdev->dev);
>       return 0;
>   }

-- 
With best wishes
Dmitry

