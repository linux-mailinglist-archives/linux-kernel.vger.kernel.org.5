Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACFF790F1A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 00:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349218AbjICWpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 18:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjICWpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 18:45:43 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34036CA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 15:45:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c136ee106so132350966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 15:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693781138; x=1694385938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=icCZ5tdF61yj1pSKhn/ffpI/X+SJfCRYhcOnGB1o1ts=;
        b=wHErKy1cGe5ad+uNrHWl/31cmmcF3H9LSPViEoNUMhvg1JLU6AumSRw85L4us3fYyx
         y0Cw8rZ5dDytsVKYJ9F9MWYx5i0LT67U7K978yQvOaSTBr2B3HzCtPlUrtMxo+1fdosv
         jTizJ+Pyw+rpEEqcNy2mqQpLVYws3hxMK73dcFrLeAqptm8T3cyLSg4xswHcQYPa75+k
         ryQjpUqsUsy5inJ5h7tWiJwilCeydDBFTKRTvF9Ycq0BPPL6/g4A+9n5S4xpegkoxkBe
         DgxzybLbf1X6HS5ZNChPoEAwgvTP1Ip+vbXwqGzcA+g3fIPLJxIVqeE4D7XLsvXf/+fh
         7/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693781138; x=1694385938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icCZ5tdF61yj1pSKhn/ffpI/X+SJfCRYhcOnGB1o1ts=;
        b=anlfU4vaGRkSDmz1uWP33jv06agpd1ORYPcMPUsJ3j719UhAsqLrXsifUzQsYeN28v
         fpaqBdBf7uHl/VzAd8ef/mjoA5bN1nwVflH8FryDVIRsAN7m3mMRl27Cg1JrDmry+auG
         qSX7cSi5/sZVMmOdpKSLRCPxXFa706HCZM2GjA82ZcYpXk+gCU/JMo0AO3r3diC32dG6
         GlYOoeR4I8xVfGzrvXdTAQLoRImMNkDtgswp0om8TOQ2VQDF16oqmtl5gRyr5zwNhhgL
         OP3TYtkXapBDHEPpVylcEw1f4i35KSxw+Mzh1iRLpU5mEqyx3+pWa1/yh/L8yHgVXlcW
         FgvQ==
X-Gm-Message-State: AOJu0Yxv5GnR/yhRmRoqQ0cy6skT83GL58wgGerVEswRD2U1OYeWpAhc
        6DRVWkEcog24BAgfnOxfRFca2w==
X-Google-Smtp-Source: AGHT+IH4gRHcH2C56k65qmxY/tgOsFae4qzfQvdNHKXi+ydhfItRS40/B9o9IDmJDqAt517CDjrUBw==
X-Received: by 2002:a17:907:7798:b0:9a1:c669:6e66 with SMTP id ky24-20020a170907779800b009a1c6696e66mr6491833ejc.70.1693781138694;
        Sun, 03 Sep 2023 15:45:38 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id lz20-20020a170906fb1400b009929d998abcsm5223365ejb.209.2023.09.03.15.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 15:45:38 -0700 (PDT)
Message-ID: <cefd4c7a-3b98-4a4c-be03-a8b02d35de3c@linaro.org>
Date:   Mon, 4 Sep 2023 01:45:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] drm/msm/dp: Simplify DPCD related code with helpers
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
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230829184735.2841739-1-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 21:47, Stephen Boyd wrote:
> This driver open-codes a few of the DPCD register reads when it can be
> simplified by using the helpers instead. This series reworks the MSM DP
> driver to use the DPCD helpers and removes some dead code along the way.
> There's the potential for even more code reduction around the test
> registers, but I haven't tried to do that yet.

For the whole series:

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Using drm_dp_get_phy_test_pattern() / drm_dp_set_phy_test_pattern() 
would be definitely a benefit, especially since the latter one has 
support for DP >= 1.2, while msm DP code doesn't.

> 
> Stephen Boyd (7):
>    drm/msm/dp: Replace open-coded drm_dp_read_dpcd_caps()
>    drm/msm/dp: Use drm_dp_read_sink_count() helper
>    drm/msm/dp: Remove dead code related to downstream cap info
>    drm/msm/dp: Remove aux_cfg_update_done and related code
>    drm/msm/dp: Simplify with drm_dp_{max_link_rate,max_lane_count}()
>    drm/msm/dp: Inline dp_link_parse_sink_count()
>    drm/msm/dp: Remove dp_display_is_ds_bridge()
> 
> Cc: Vinod Polimera <quic_vpolimer@quicinc.com>
> Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
> 
>   drivers/gpu/drm/msm/dp/dp_display.c |   9 +--
>   drivers/gpu/drm/msm/dp/dp_link.c    |  38 +---------
>   drivers/gpu/drm/msm/dp/dp_panel.c   | 105 +++++-----------------------
>   drivers/gpu/drm/msm/dp/dp_panel.h   |  10 +--
>   4 files changed, 22 insertions(+), 140 deletions(-)
> 
> 
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c

-- 
With best wishes
Dmitry

