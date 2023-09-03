Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD1D790F01
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 00:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348319AbjICWhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 18:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240826AbjICWhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 18:37:21 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB02C4
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 15:37:18 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4e6so1080446a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 15:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693780636; x=1694385436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JTU8KrO8RUU8FiWRZw+rl4K+4j0rOVVykAlc2x+Gur8=;
        b=AOn5oJ9ZIVvioS8yTbQGiku19FjNeenzc/LaorIif6p3t0e3DReas4zzaogdK/CMNL
         Fc5Kyp+Z84fJzM07c5EDOXLTeMqYUd0sZGe6uHVNdhIkJYt07mp3FQ76CjwDzsEpPeBB
         UaE4FrB3ulzVcK2cS5HSOa6M+YkomCdcVyRiwEm900QqC8fCHDSUsZPqOj7gnI5qJNoc
         8HOSZ4A0B6e0K9eA85LSHEZjE500aCgFpTQWQEArXLUKf70IMu4ODaRdljPpGFbpy2kp
         dX0LjDUTVWhvNVtb7O6mBy5H6y/9v6/nA2MqoggM3GQow++Do6ufOlCxAtTHOqG5LELN
         CV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693780637; x=1694385437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTU8KrO8RUU8FiWRZw+rl4K+4j0rOVVykAlc2x+Gur8=;
        b=ZZ3T9apUm+XR6ZI/ExxVUE6uUMITdXcpy8WPrSZ61fBbKghALaS0clOz96h2cCEDpp
         IpOAuyVzry9YHoZT3u0kGuphZXT6GacjdfHFB32WQHJ4RkjeLxETpIUCNlCQGA1K2s+e
         ERgnYJ+JyiC7HCeNvN0h1s1GT5rQ3Wp8A47F47HEC2TI8yBYrXMDDOw80I/jQupQdN9P
         6bIiUnksIDFaOjXGogN/FWoDFIctKagSJG41H2pFlYhuYs9+BugRkdkqWM3u5WeuJZ9e
         3GX5Qt3IJgo4hfp+KewyEgDQ2TtZk9kRtLhLrFH8sFlQ3tLxQbclQk0l/91h6+eIbT1l
         z6nQ==
X-Gm-Message-State: AOJu0Yy+78w8DsVAEsfHYIUthpGVx/LZSNZQfwLZC9SY74Uf6LppEBs4
        xSOLg44TfqqD5AftqLS54yawbg==
X-Google-Smtp-Source: AGHT+IH887EsApjxxqgeKDwZfphqZJP+92AGGLQhQH1W/cbewlBiwmTzV6SErfuj2s5lfRAgmYmXeg==
X-Received: by 2002:a50:ec90:0:b0:523:3e90:68b0 with SMTP id e16-20020a50ec90000000b005233e9068b0mr5378864edr.21.1693780636732;
        Sun, 03 Sep 2023 15:37:16 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id bo9-20020a0564020b2900b0052889d090bfsm4972604edb.79.2023.09.03.15.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 15:37:16 -0700 (PDT)
Message-ID: <1c7b1397-de05-49f7-8e26-3244fbd1573f@linaro.org>
Date:   Mon, 4 Sep 2023 01:37:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] drm/msm/dp: Replace open-coded
 drm_dp_read_dpcd_caps()
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
 <20230829184735.2841739-2-swboyd@chromium.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230829184735.2841739-2-swboyd@chromium.org>
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
> This function duplicates the common function drm_dp_read_dpcd_caps().
> The array of DPCD registers filled in is one size larger than the
> function takes, but from what I can tell that extra byte was never used.
> Resize the array and use the common function to reduce the code here.
> 
> Cc: Vinod Polimera <quic_vpolimer@quicinc.com>
> Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/gpu/drm/msm/dp/dp_panel.c | 42 ++++---------------------------
>   drivers/gpu/drm/msm/dp/dp_panel.h |  4 +--
>   2 files changed, 6 insertions(+), 40 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

