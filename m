Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B187BB686
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjJFLhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjJFLhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:37:20 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B21D6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 04:37:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-503065c4b25so2703247e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 04:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696592236; x=1697197036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W1VsvxhUXFiTgLAymq3ebUz3YFWk1kEe5SWqaT+jDqg=;
        b=MXHad73Rieia+KSM9N8U0lQHJIVVd3qas9djEHlGb4LtAvqVCNBpnyCrVo0m0MSwoi
         z1wJ/teSabSZeSMbReH8umazPIMWwZKHLfUV2yD/Eb6qLau0u95OFNA3V3hdyHUZB3ky
         MjRTWZKChgS7CZi61S5NwpljenSbBVj64ytoJr1M3cOhwXO/TNWHzyxtLw6gRrMqnigy
         76vMzq270ClxbYIZZYSaf4eer3eMd/ufFseHJvSn2Qwz3t0R5BWA/hYzVjNlPOQwo21I
         4fa5L3F9pqVFPmnwV3BE17heBmLH8yw43C061q5crhz2T+I2mMUEdUJSHa2FDZLQaB+N
         m49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696592236; x=1697197036;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1VsvxhUXFiTgLAymq3ebUz3YFWk1kEe5SWqaT+jDqg=;
        b=DuUF5QvAZEtf017tp43Py+jLbiV6cKB59kFPBVz2pknIMwzVDECYfbfV3M+ltZ3ooL
         99YaXhAI+I1+0mYAJQGC+J9cHu5ELfx1Q4z28yvhcaBhroyFT2tzz7d0Wi76VPWbXraB
         cEa8IBwLpvfoaqNNkUx8YQXUyVhmHytqzp63vKF0Hhf3thvHPWbyj4/vozpSdogdoeO+
         63+4lgEaz34Irlq5mijR8YLHUeJf2N2YntRU6NEELRuNzVqpbNq5LKTgcxsJbdhDCF9X
         Q7flG6X9J3G7mD0ICSfkcVvKiTNGooZ3+WdLEyuHG4tnf9+PIx+aqdZXosoMrxOpE/z2
         GQrA==
X-Gm-Message-State: AOJu0YxR2IJjvm+6MrBKZOahLQSD5xV6Gq1BaFsIIqkPjx8OpZiCXgL0
        v5AtLCdHIgzTgH+QNqkbKzVXeQ==
X-Google-Smtp-Source: AGHT+IF+Jpya32i8cpjd/eEUDafUcO+YT0nT8KXnyToGumNwtjpvCiq/Lgj7ChqbBTe+srBXkEe46g==
X-Received: by 2002:a05:6512:4015:b0:503:9eb:d277 with SMTP id br21-20020a056512401500b0050309ebd277mr8005030lfb.49.1696592235801;
        Fri, 06 Oct 2023 04:37:15 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id y20-20020ac24214000000b00500829f7b2bsm269094lfh.250.2023.10.06.04.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 04:37:15 -0700 (PDT)
Message-ID: <1b317a1f-f7d1-4ec2-8e15-7c9cad3036bf@linaro.org>
Date:   Fri, 6 Oct 2023 14:37:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] drm/msm/dp: move parser->parse() and
 dp_power_client_init() to probe
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1696436821-14261-1-git-send-email-quic_khsieh@quicinc.com>
 <1696436821-14261-5-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1696436821-14261-5-git-send-email-quic_khsieh@quicinc.com>
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

On 04/10/2023 19:26, Kuogee Hsieh wrote:
> Original both parser->parse() and dp_power_client_init() are done at
> dp_display_bind() since eDP population is done at binding time.
> In the preparation of having eDP population done at probe() time,
> move both function from dp_display_bind() to dp_display_probe().
> 
> Changes in v4:
> -- explain why parser->parse() and dp_power_client_init() are moved to probe time
> -- tear down sub modules if failed
> 
> Changes in v4:
> -- split this patch out of "incorporate pm_runtime framework into DP driver" patch
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 32663ea..e4942fc 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -276,11 +276,6 @@ static int dp_display_bind(struct device *dev, struct device *master,
>   	dp->dp_display.drm_dev = drm;
>   	priv->dp[dp->id] = &dp->dp_display;
>   
> -	rc = dp->parser->parse(dp->parser);
> -	if (rc) {
> -		DRM_ERROR("device tree parsing failed\n");
> -		goto end;
> -	}
>   
>   
>   	dp->drm_dev = drm;
> @@ -291,11 +286,6 @@ static int dp_display_bind(struct device *dev, struct device *master,
>   		goto end;
>   	}
>   
> -	rc = dp_power_client_init(dp->power);

As we have moved dp_power_client_init() from bind() to probe(), we 
should also move dp_power_client_deinit() to remove(). Otherwise after 
several bind/unbind attempts the pm enablement count can become negative.

> -	if (rc) {
> -		DRM_ERROR("Power client create failed\n");
> -		goto end;
> -	}
>   
>   	rc = dp_register_audio_driver(dev, dp->audio);
>   	if (rc) {
> @@ -1250,6 +1240,18 @@ static int dp_display_probe(struct platform_device *pdev)
>   		return -EPROBE_DEFER;
>   	}
>   
> +	rc = dp->parser->parse(dp->parser);
> +	if (rc) {
> +		DRM_ERROR("device tree parsing failed\n");
> +		goto err;
> +	}
> +
> +	rc = dp_power_client_init(dp->power);
> +	if (rc) {
> +		DRM_ERROR("Power client create failed\n");
> +		goto err;
> +	}
> +
>   	/* setup event q */
>   	mutex_init(&dp->event_mutex);
>   	init_waitqueue_head(&dp->event_q);

-- 
With best wishes
Dmitry

