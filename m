Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87B1752B36
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 21:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbjGMTxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 15:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjGMTxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 15:53:09 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037A71BEB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 12:53:08 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so2051783e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 12:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689277986; x=1689882786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tkSK4Hprfqvy1sXh7+UPS2V9p+xt/zZPx5zVI9IIj2A=;
        b=L7U6PT4gRJmUhzc3i7IRnueruqmsdNXGog/dPpUVMruUPYVb0oqU7SxON1iD4YQxAP
         vDkd9HkZi2gB0XGHa1rK2dqh8gze/DIz3KMcqb/RcvJlas9besq0hEp4/Ci/QE7Pwnv/
         qYsfXY57LEmSJ+MVyXub7Y/Lz12muLA8HN91GfTFUuji1Cg53XwqKHFm82kUbiKWztsw
         u0JayV0DURL81rR74Aa0PVq189o/XSYxpIIJC2if/0f1ri4SpEcpz3V01fdvourmNrkC
         /Z8cQ/2Zpsqg6j80zn7gnHjxkNazhOSsRaugR2PAfuU3dDWI6yI6pvmsehjHG+im3oDS
         zljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689277986; x=1689882786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tkSK4Hprfqvy1sXh7+UPS2V9p+xt/zZPx5zVI9IIj2A=;
        b=G0yQ4A4++GkTXvT5p6w4LBiiyMV000hjeZEkLylXx7sN618fl0X1K8opOxf1rbIDSM
         pGFjcl3itPIdx/BRgbGpNpseWrH8Wd58Dfj1wIlGPfJTRQag71Cek4MZxbGxRLxM7owN
         71JE9R1BCzM8X4OzN4hDgtpA56MHjL+yJHEiLjnnOkYEh5efnJYAoJp28kGBoFfkikyW
         wXP8n7NlMXo1oAZ/Tkb4Tx/3Sioo8My0PfOumDGCCD+UX9w1wJUQW0tzgsVln/ic4Kpo
         TaXdnKmqQDbNbKKDMxKUL8Ah1E7UM0qdm0yOXt6radrVDPv2DUJVxgexQ+H8DG7EVzPG
         Lt9Q==
X-Gm-Message-State: ABy/qLYx4MV5gPCewE6Ehvs9ilhLpyp8KOxrfmBs/jlwDldmh6zst7Ki
        JokS+8oIJpgl3wdCUE4lxqzoKQ==
X-Google-Smtp-Source: APBJJlGVw6V+RP1LIbdt+ch7pPvJN+Jx/IZaclPER7QiiajPjn4MUP8U4h/rRIIgI0eVg2+9OrIxIw==
X-Received: by 2002:a05:6512:3f10:b0:4f7:6976:2070 with SMTP id y16-20020a0565123f1000b004f769762070mr2159598lfa.40.1689277986183;
        Thu, 13 Jul 2023 12:53:06 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id i12-20020ac2522c000000b004fa52552c82sm1224452lfl.155.2023.07.13.12.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 12:53:05 -0700 (PDT)
Message-ID: <bf9439f1-4ae6-78db-95cb-b8cad84ff0ab@linaro.org>
Date:   Thu, 13 Jul 2023 22:53:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/msm/adreno: Fix snapshot BINDLESS_DATA size
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230711175409.157800-1-robdclark@gmail.com>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230711175409.157800-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 20:54, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> The incorrect size was causing "CP | AHB bus error" when snapshotting
> the GPU state on a6xx gen4 (a660 family).
> 
> Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/26
> Signed-off-by: Rob Clark <robdclark@chromium.org>

What about:

Fixes: 1707add81551 ("drm/msm/a6xx: Add a6xx gpu state")

?

> ---
>   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
> index 790f55e24533..e788ed72eb0d 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
> @@ -206,7 +206,7 @@ static const struct a6xx_shader_block {
>   	SHADER(A6XX_SP_LB_3_DATA, 0x800),
>   	SHADER(A6XX_SP_LB_4_DATA, 0x800),
>   	SHADER(A6XX_SP_LB_5_DATA, 0x200),
> -	SHADER(A6XX_SP_CB_BINDLESS_DATA, 0x2000),
> +	SHADER(A6XX_SP_CB_BINDLESS_DATA, 0x800),
>   	SHADER(A6XX_SP_CB_LEGACY_DATA, 0x280),
>   	SHADER(A6XX_SP_UAV_DATA, 0x80),
>   	SHADER(A6XX_SP_INST_TAG, 0x80),

-- 
With best wishes
Dmitry

