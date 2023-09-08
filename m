Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFA2798032
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 03:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbjIHBax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 21:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjIHBau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 21:30:50 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214361BD2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 18:30:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a6190af24aso190330866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 18:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694136644; x=1694741444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+s6ddDNWj5Ed/aqdjx7Pfh0SYjgnxSyCgwh9TBhOQWw=;
        b=CDgHwCEQ9xmWztLOsNwxJ58XlzSQTIUUU2Pxo5Vz2bjf/0nk8nvrWaYb2JTQ8Pqxcg
         uq/FKnrYvSEhWKmwvhQqWYqUzaBrjdkof2GDniT3l46MuEOMDvNSWNYTVudM9ArGTB1b
         UzNM5lWfy2NO6REnFWbKC+BY/djscLYVzNlgokjYPNwkpJT0WFZm04Y4lQatyVYxnHhi
         360Jx8DJGQGWHhAesJCG3GFjWWCompxHb3aUW1dW9sM6oGlGtAOLj1caNSLlZ65sTw/b
         Vy07qQbqe2Bma8BNfPFn+oSMBloLVMJRHMW2d5WN6AxrZOmnsWhEcnud1V59015ffl8t
         VwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694136644; x=1694741444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+s6ddDNWj5Ed/aqdjx7Pfh0SYjgnxSyCgwh9TBhOQWw=;
        b=UXoWb+joMToDsoK9yvuxsCkHr6JjZzHnKUCxy2HQhTXJQnQVEKU/OdO0v4uT8io1yW
         lquDrxDabkxY+YnwVfR47gPdYxjYOU8jVzEiA2q9whGbAgc+deVed1AQFeOnywfxxbrJ
         um2pYAjWqqXHXsuRR0jIKPlQIRyGegTg1XvnJqLEbQhKGbRhmTZFVNKC4X1mK55nrBH8
         kNwP0wxjjOGiYq+YrrGvpkV10WCNGvuGEvLbFLhVy2he9Ujn/R5FA8msYzkzLzYpdSA2
         Tsif6MGwdFG7308H+P2NYpEEkPk4bfFdZZd41E125owfllPD+HpoIvcG6U+wFTM3owMC
         ppUw==
X-Gm-Message-State: AOJu0YyyxXZLuVyRcGHI8fvzXAnW+e8j2rP2IBLPc0ogDtKw6gjoIEuq
        exVlHHxp/xJJuu2w7y4vdkWhZt36GOrOZOXWXOQ=
X-Google-Smtp-Source: AGHT+IGoHfi/f0ipDYYNQtYwElSZi0+PTS0KL74gN0o35Q3QTzuxbhrmUK7vaOEkHJM2Pm7wiL3FwQ==
X-Received: by 2002:a17:906:76d8:b0:9a9:ee3e:e6b6 with SMTP id q24-20020a17090676d800b009a9ee3ee6b6mr608770ejn.3.1694136644631;
        Thu, 07 Sep 2023 18:30:44 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id d24-20020a17090648d800b00992e14af9c3sm325285ejt.143.2023.09.07.18.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 18:30:44 -0700 (PDT)
Message-ID: <d5135c84-65d1-4e39-8c97-a7c6838a32a5@linaro.org>
Date:   Fri, 8 Sep 2023 04:30:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/msm/dpu: change _dpu_plane_calc_bw() to use u64 to
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
References: <20230908012616.20654-1-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230908012616.20654-1-quic_abhinavk@quicinc.com>
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

On 08/09/2023 04:26, Abhinav Kumar wrote:
> _dpu_plane_calc_bw() uses integer variables to calculate the bandwidth
> used during plane bandwidth calculations. However for high resolution
> displays this overflows easily and leads to below errors
> 
> [dpu error]crtc83 failed performance check -7
> 
> Promote the intermediate variables to u64 to avoid overflow.
> 
> changes in v2:
> 	- change to u64 where actually needed in the math
> 
> Fixes: c33b7c0389e1 ("drm/msm/dpu: add support for clk and bw scaling for display")
> Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/32
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

