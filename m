Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACDC7BE710
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377313AbjJIQ4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376894AbjJIQ4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:56:21 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40039AC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:56:20 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c15463ddd4so53118011fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 09:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696870578; x=1697475378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WlhqBQl9oFMKzadsnusYrJDuDpk68abfiZiL1f4YOiY=;
        b=e1RnG2rGAJ5pYOCfwlD3tDUon6SBQvXbNpPLBZp9v9GX90y28V/6ksBOryahdqjXdH
         jw5qT7FxZU5en5waqS9BliPcFMVe+5TII9yXhfWs8dxaKVNfSl6V9G7GpPj6rv9eNbO3
         gnmrZhVIGEyA4gC6cwQHkdEB7bHHLhw6BaFwxEl7nU3HSw+1CiZFjadFqn3swOGs5cR3
         kZYr1iAX++CiYFR3vggWfa5yDUvy5aVC6TVkipojlOeW5FFxZdWSt4fY9hFc3YjxOueo
         LMLvsuD2HFRQUjpIn63sOrgWUyruRn0MfO/AEtenBQ5FwmQ+/2RAtYiNuDRauouVlUU/
         H0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696870578; x=1697475378;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WlhqBQl9oFMKzadsnusYrJDuDpk68abfiZiL1f4YOiY=;
        b=fnRTXe1MRgTsaKOhK7CuBOBjLUZqFP8oLDvO/i/1vfkzQRROF60yyv0Q8qQw2wFDWt
         Vni3y8r9s+opF/rk8VHoj5jQlxUPVeajRu7TTr5ksE9nb4sS3R2cHsAFyPMTZHF0ryo3
         YwzH4kuIwb3W83AzmG1fC3DBL52F1oanPUCaTBpsKW1m3p2F+iMa3xmEZHJibbO3Mr8w
         3Mf0XYG0zf24+jM0AmMLbZhWhzS7B3tTzUZw0vB/p7zAiFEp5RJ0MMHRIys0hjKcgU8/
         b3wGhD9RtrAOWFSAcwZKkEp7FEsV5oGvy/S5Up2SQ46WppkOoyk5fMqvt+mrFp1BFi2A
         4+YA==
X-Gm-Message-State: AOJu0YxRBMTDkY9vv90Ibs/yll6RBJ4Enc9OHjrTvVEEQGeEk7YwjzFU
        kOAVbR/jrgFlSmCOdMMLu28imw==
X-Google-Smtp-Source: AGHT+IEzc+wWdYLx/D2ts2ez2S94HZ9kZNSnVve1pOz142p3GNd2sRYfgrX3YVCBmxnsKQjBUkC4Lw==
X-Received: by 2002:ac2:5fa7:0:b0:4ff:7004:545e with SMTP id s7-20020ac25fa7000000b004ff7004545emr12437678lfe.4.1696870578282;
        Mon, 09 Oct 2023 09:56:18 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id q18-20020a19a412000000b005047baf3385sm1488987lfc.181.2023.10.09.09.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 09:56:17 -0700 (PDT)
Message-ID: <ce15113b-c032-44ad-ab03-ff1b719fcb99@linaro.org>
Date:   Mon, 9 Oct 2023 19:56:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dpu: enable smartdma on sm8350
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, nespera@igalia.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230908193314.27008-1-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230908193314.27008-1-quic_abhinavk@quicinc.com>
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

On 08/09/2023 22:33, Abhinav Kumar wrote:
> To support high resolutions on sm8350, enable smartdma
> in its catalog.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> 
> Notes:
>      only compile tested, to be landed after sufficient testing

-- 
With best wishes
Dmitry

