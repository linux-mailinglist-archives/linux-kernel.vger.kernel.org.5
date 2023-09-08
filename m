Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC23797FCB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 02:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbjIHAfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 20:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238727AbjIHAfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 20:35:30 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F141BF0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 17:35:17 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b974031aeaso27330501fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 17:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694133316; x=1694738116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WufLjNztGlChBv98FBmKb2FlfCV1VsF4EoYLdsQzy3U=;
        b=HsexrnJtMm0uyGQLlcnh9fAya4/GVLBzn8wA4h4p7WQnddZEQD3FNCmAxMHJEVK7wp
         EQt7TgBLgspnessP8NNSMefqjtYJZ0vtseeIdQCWyDSJ0sExHceojaaBdQuIURJUzF01
         HD1K3kImqwUoxr7niXDjpu+ge08TePiZM09UHh2U9Oqs2x7vllKttpEpnazcMNma7DvZ
         z+N7PXHFTBYyjGfyPmRI9bbqUPyNdosRqCwsZdr2jXpxyJMJRf4Cmu3BD5Z8Hrl7dyzV
         iZ1c1nYKWU7d2x+T0hVA702Wf6I/iCIExWqK0HbVMzx7UxDOcXCSX4QkDvV4Jn1Fskjy
         U+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694133316; x=1694738116;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WufLjNztGlChBv98FBmKb2FlfCV1VsF4EoYLdsQzy3U=;
        b=ZK6gECRHHKGLU969pwJPHT60m3ASN8at+POpHXYd4XfgooDfmIQ63Uh1ofZOt+Tq3/
         sDIVLtzuVSGvBhuyMB8ecjnPf4x0CRqPhOjdReVSKfpftX3nAEtDRgAhYcWJhjXMawgu
         EBJ1HlSUwR3hMrLp7/QWJyesr2x+SDzQFyjLxKW7YKHU7ZgeZolVWqqC8ooLTKJZVSZ1
         5hqaeQBrdN37HxJIEjDrmcUJY189N0sWvqZqEl6jYImMw//uwhbaZz5cG/UOMTrKHMgc
         cMglaZKEa854/0zIdBqKUiEtIgLrLb27wDb5a5qfNDDk9K22t4FtqTqb4Ry6QRQIjk9J
         Kgaw==
X-Gm-Message-State: AOJu0YynwxMhBVlW/MLDYzTmuUGePO0i3GlUpZd8eeiv67CALIebvZx9
        yF381RV5XNIBzhj4cInYYmjCkw==
X-Google-Smtp-Source: AGHT+IEG4qe0Wnk8qI7Djt2pE2CXmT2pRRN8CzJa4p9Pz+uJgkGUR0afl2XPdHrEJ6PdPoYLGQg/YQ==
X-Received: by 2002:a2e:9782:0:b0:2ba:6519:c50f with SMTP id y2-20020a2e9782000000b002ba6519c50fmr484086lji.52.1694133315738;
        Thu, 07 Sep 2023 17:35:15 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id i18-20020a17090671d200b0099cf840527csm280373ejk.153.2023.09.07.17.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 17:35:15 -0700 (PDT)
Message-ID: <f110b0fa-f41f-47e8-a83b-30de2f2b128c@linaro.org>
Date:   Fri, 8 Sep 2023 03:35:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dpu: change _dpu_plane_calc_bw() to use u64 to
 avoid overflow
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kalyan Thota <quic_kalyant@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, nespera@igalia.com,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230908003240.14104-1-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230908003240.14104-1-quic_abhinavk@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2023 03:32, Abhinav Kumar wrote:
> _dpu_plane_calc_bw() uses integer variables to calculate the bandwidth
> used during plane bandwidth calculations. However for high resolution
> displays this overflows easily and leads to below errors

Can we move the u64 conversion closer to the place where we actually 
need it? Having u64 source width looks very strange.

> 
> [dpu error]crtc83 failed performance check -7
> 
> Promote the intermediate variables to u64 to avoid overflow.
> 
> Fixes: c33b7c0389e1 ("drm/msm/dpu: add support for clk and bw scaling for display")
> Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/32
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index ae970af1154f..c6193131beec 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -118,7 +118,7 @@ static u64 _dpu_plane_calc_bw(const struct dpu_mdss_cfg *catalog,
>   	const struct drm_display_mode *mode,
>   	struct dpu_sw_pipe_cfg *pipe_cfg)
>   {
> -	int src_width, src_height, dst_height, fps;
> +	u64 src_width, src_height, dst_height, fps;
>   	u64 plane_prefill_bw;
>   	u64 plane_bw;
>   	u32 hw_latency_lines;

-- 
With best wishes
Dmitry

