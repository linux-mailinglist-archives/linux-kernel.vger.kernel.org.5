Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF6D757665
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjGRIQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjGRIQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:16:02 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD872188
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:15:58 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso8909112e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689668157; x=1690272957;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iw8rToh05r7bUfycHBeb+uZz00o8lFw7cQSPQLUCF2M=;
        b=tdM8sAUVKS2LHDZxtM7iRxFyCeKyFP/DhzOJ/LcgkJwYR8tK31PrRanIjDLxCKerFi
         Azz0AXE1Bv825E9D+/EbPXgtfE0b3ojU6znaC34tqB8U8GnLTnIG3CL+itF0HepL57GV
         L0LF8vZrF8UM1vUgvgiRpLgB2XXgiWYkxr0Kqt2KJqM8J9aEtD3mJQuaNvHvWmghxJng
         DjVZvsJjcISaQuZopEULICVLNs053lZBG5qjSo087RcINyWrmaoNUvyo0Q8qqhjjbZUA
         LZPc6EoevtJBR1R+ahTfTwnIWOMVhauDS6WtldaFOHXUUGJswcOZvMBwtVXrqwJ1iFzN
         ZUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689668157; x=1690272957;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iw8rToh05r7bUfycHBeb+uZz00o8lFw7cQSPQLUCF2M=;
        b=XciM5Inm8uOXYvUlZmZ8/X3eQU0ulaR0KH4jpARgGOgkUfGTuJ1yFUkaUgLill9oCg
         Qtzq40gkQW+ua5oq3V+Ku/WMKyfZJ9zAyxOi6pxiZkqSAI78x5sIKIbhrc+caNtOXw1Q
         WahYMsTZrQT1QZ80xuRDue+jxZzvyjWYiUA4KlpGUwxd5AmvKddQKBiZryD/oVeIQILt
         N58EVAGIpvbiASdvF4nushi8TuSPdak46IBaHqeQgbwEvBVY1jDTZ1QiOqgQMf45LFFl
         S8zPnxOX58wugQzgiLzo/VVKbJ+J89aj5q9wPOH+BUHG7l27FAFlVLBUL9xRu4qp38vY
         dW/A==
X-Gm-Message-State: ABy/qLYWI3DmuC7fI2LBzlbieKMQEaZL1oQWQtbyHGA69sn8ADny1c2v
        CUvbPBu9EZKGw6Jhlidj2NqBoA==
X-Google-Smtp-Source: APBJJlG0i+8oZJSxOcAnNcuG+MiAU7YhlOlYb4AgmHWdYRATrnr8cHmgyMEWL/+T3Tpu+68WeMapPQ==
X-Received: by 2002:a05:6512:b1d:b0:4f8:4719:1f4a with SMTP id w29-20020a0565120b1d00b004f847191f4amr9888796lfu.7.1689668157012;
        Tue, 18 Jul 2023 01:15:57 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id h8-20020a05651211c800b004f9c44b3e6dsm320705lfr.127.2023.07.18.01.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 01:15:56 -0700 (PDT)
Message-ID: <c17625f5-515e-3c8a-29b8-0bef9f125dc4@linaro.org>
Date:   Tue, 18 Jul 2023 11:15:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/msm/dsi: add missing put_device()
Content-Language: en-GB
To:     sunran001@208suo.com, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230718081139.16918-1-xujianghui@cdjrlc.com>
 <c07be8cdf5ceceeec6bc7918774c18e0@208suo.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <c07be8cdf5ceceeec6bc7918774c18e0@208suo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 11:13, sunran001@208suo.com wrote:
> The of_find_device_by_node() takes a reference to the underlying device
> structure, we should release that reference.
> 
> Detected by coccinelle with the following ERROR:
> ./drivers/gpu/drm/msm/dsi/dsi.c:50:1-7: ERROR: missing put_device; call
> of_find_device_by_node on line 32, but without a corresponding object
> release within this function.
> 
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/msm/dsi/dsi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
> index baab79ab6e74..81461e8852a7 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi.c
> @@ -46,7 +46,7 @@ static int dsi_get_phy(struct msm_dsi *msm_dsi)
>           DRM_DEV_ERROR(&pdev->dev, "%s: phy driver is not ready\n", 
> __func__);
>           return -EPROBE_DEFER;
>       }
> -
> +    put_device(&pdev->dev);

NAK. First, you are putting pdev instead of phy_pdev. Next, the 
reference to the phy dev is correctly stored and then put in 
dsi_destroy(). Please do not make blind patches when reviewing static 
analyser warnings.

>       return 0;
>   }

-- 
With best wishes
Dmitry

