Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3163801EF1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 23:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjLBWGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 17:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBWGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 17:06:52 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47190FF
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 14:06:58 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c9cb021d5bso39412761fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 14:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701554816; x=1702159616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8EEqQbM+NDSOnW/8JPVObWqPerbfzPFaOO/AA0Ia5kw=;
        b=G9+JEouxkAouKw4ujbTYvYS89h2dxY6UejhyPP1cOm0Y2Mwk1YDdGSlvKpoiPgl9We
         vRWDt/dg11r9aQ6yB/5zxL8hqT6ojILe0Q4qv4oZWsfwpzIGFQB9+khvStp6zUOqksC0
         0r0Z4ZyElzI29z3gl7MQB+ReJKaw38EV18LvAUkA76urIXT3o7SimBiOGmcblP6PBCkg
         2/u/xbGSjuZEDCrMnc0y4m2a0QCY5bKzRVHnoMOlnahejLapSTgtx+F7C9jyPsBOtZiA
         LeEno1/SN2CWgwaE1DMd1mTujtj3wiZILTyk/jtEGtipker+VOZqT1jrVeS5ukqHceGn
         xkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701554816; x=1702159616;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8EEqQbM+NDSOnW/8JPVObWqPerbfzPFaOO/AA0Ia5kw=;
        b=Uy8d4E/PIfIntEZCf+B1TBxYlnO43koCoVqbExmpkXuGIVGpsGslSQmEwc7zxBczr0
         ebuYfgRelVfPBFY5n3fokt5fbh2JmgxrmK1aqcAhU4IQWZZVhFA4gh57cIIisFVLvkKe
         hd50gwLoDim7/xBCkbZZMlVZxKq8QvQ7aZ7on8ZsRDKfy9O7Ck9OvS8w18CEyg93cO2h
         oPl/ppzQOksuLzqqD9C4bRSrOnVxW9KnnLEn6zE1kLye7yKMNkgECJuEGFxeHFKdQr++
         jAnzSQ9CkpzglsOxVsGsByRQ2MNvgaWP/+08aXnqgomvXm5qoLS1Yflpg/PamEc9sSzj
         nFMQ==
X-Gm-Message-State: AOJu0YwAUZcNu2JhVhr1MqoMgtbRXK4yNUQWKkp1UmU08fVV1b8A417R
        zPoSBAojd2g7X78kqQi3WE2Q9Q==
X-Google-Smtp-Source: AGHT+IH126mZ0/iFlCmfP9RcDvlY7iS5lYG457fIONwriSCdsyDra+BvTashg0w9kij8AjWyl3UGJw==
X-Received: by 2002:a05:6512:104f:b0:50b:e1ea:f7c5 with SMTP id c15-20020a056512104f00b0050be1eaf7c5mr929335lfb.138.1701554816497;
        Sat, 02 Dec 2023 14:06:56 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id z8-20020a195048000000b0050be3c0b29bsm165323lfj.195.2023.12.02.14.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Dec 2023 14:06:56 -0800 (PST)
Message-ID: <37daa626-6f6f-4fce-aa35-6e6e8ba2ddb7@linaro.org>
Date:   Sun, 3 Dec 2023 00:06:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dpu: Add missing safe_lut_tbl in sc8180x catalog
Content-Language: en-GB
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20231130-sc8180x-dpu-safe-lut-v1-1-a8a6bbac36b8@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231130-sc8180x-dpu-safe-lut-v1-1-a8a6bbac36b8@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2023 02:35, Bjorn Andersson wrote:
> Similar to SC8280XP, the misconfigured SAFE logic causes rather
> significant delays in __arm_smmu_tlb_sync(), resulting in poor
> performance for things such as USB.
> 
> Introduce appropriate SAFE values for SC8180X to correct this.
> 
> Fixes: f3af2d6ee9ab ("drm/msm/dpu: Add SC8180x to hw catalog")
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

