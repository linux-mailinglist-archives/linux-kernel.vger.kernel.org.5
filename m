Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AB9790F14
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 00:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349208AbjICWkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 18:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349188AbjICWkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 18:40:08 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBE410D
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 15:39:59 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-500c7796d8eso1330949e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 15:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693780798; x=1694385598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3njyN7L52ply28cLSWvghKHcDvpsiniGrJ+Mxrq7efI=;
        b=zp33HXH5ykGplPx+9i3lXlqj85GziIReOFjI9gH1iOa36b5LAAn2+T04TmekSxiH/c
         NZNNBsnIZuhptiNGD8lDCwnkn50Ap+9AORzNRqkSJYbN2UYkc1Em5vYl8SaO9Z49wA3E
         mrZp7aVoAJptXuQIebZyuUf1TegmO3slzWdbTFrXwzKFmV+mhUzTaehi26cHhYYbeWgY
         W7ywmqgClbZFGdLmPVFzMFyq1FC2tbR5CzpjYuer1OEK1Fh9PT/wy9m2NWRbra5G2vVw
         qZQV3EZvspi1TX2S3yELNfpPtDi6TgtmvQyZYeWIzXXSP9GT66nguLxAmcx3F0zP4wwY
         Z1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693780798; x=1694385598;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3njyN7L52ply28cLSWvghKHcDvpsiniGrJ+Mxrq7efI=;
        b=VSbhndHiggvfVAU6aZMJM4hemQaGyCJ8Pat+6SZxB36UHINdkoHxDfUXhke/p51m/o
         NFONQDYyqrNVhmmvLe4FURzzjTlPa4Jnws3uGCCiT/YWieBpM7HOvlB+J4DWdBoLBnT8
         RWqIKQtGLkluPp23O/riCB5PWGy8KsK9MrDqSvRSAAv0SQio57ONRLSIRjEjU4szf3UZ
         G3+Eok+pWd+uvfrelebulj3Has4N+csSz2Qf1hk4Psyneu1A71SGvBYTo1XrPKch8sbL
         K1S6PyOb6GpU8hsaXw2BlXH1U8UtV27i7lvwr2Q/C5se5gUfczKjrkQVPLQREBVmtkHb
         2RGA==
X-Gm-Message-State: AOJu0YyBiLUX2L4Frz3C+pW+HRjpx42xgOtcIMe3CkibwDcN9jPxTwKD
        NxnLAFYbBiCh/6v+4ijYdYQJag==
X-Google-Smtp-Source: AGHT+IHqA5bKFtbDh+6zSj7AEktpbIX5QdrDfqbVTVJTxtGdex58MNMVKlZ2+5ZRABDSdhyKeGSD5A==
X-Received: by 2002:a05:6512:3701:b0:500:7e64:cff1 with SMTP id z1-20020a056512370100b005007e64cff1mr4786349lfr.14.1693780797803;
        Sun, 03 Sep 2023 15:39:57 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id bo9-20020a0564020b2900b0052889d090bfsm4972604edb.79.2023.09.03.15.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 15:39:57 -0700 (PDT)
Message-ID: <79297172-7be5-4eb1-9288-83334f8302b6@linaro.org>
Date:   Mon, 4 Sep 2023 01:39:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] drm/msm/dp: Inline dp_link_parse_sink_count()
Content-Language: en-GB
To:     Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
References: <20230829184735.2841739-1-swboyd@chromium.org>
 <20230829184735.2841739-7-swboyd@chromium.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230829184735.2841739-7-swboyd@chromium.org>
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

On 29/08/2023 21:47, Stephen Boyd wrote:
> The function dp_link_parse_sink_count() is really just
> drm_dp_read_sink_count(). It debug prints out the bit for content
> protection (DP_SINK_CP_READY), but that is not useful beyond debug
> because 'link->dp_link.sink_count' is overwritten to only contain the
> sink_count in this same function. Just use drm_dp_read_sink_count() in
> the one place this function is called to simplify.
> 
> Cc: Vinod Polimera <quic_vpolimer@quicinc.com>
> Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/gpu/drm/msm/dp/dp_link.c | 38 +++-----------------------------
>   1 file changed, 3 insertions(+), 35 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

