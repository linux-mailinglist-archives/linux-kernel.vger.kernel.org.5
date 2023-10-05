Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB6A7BAEED
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjJEWmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjJEWms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:42:48 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642C6CE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 15:42:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-505a62d24b9so1846872e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 15:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696545764; x=1697150564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J55C2DECva8x20ZCPV5VaEapm9sYZn6cEu2d8qLrjfw=;
        b=o7scVgVaBiu4bYn17sb1+jVHr9j8WG3GKSRJLFbZLWCqdQeenQr75keX4r80BaTnt1
         u4x+/M0dj8elDTLk8/+WhzUWfMp7yxu3TCuc2MJpjNHBuK4ixX76ddSaQP09x/4v/Dkg
         rej/ebJyCqrVVgMimZJv7+NawJhnp2PIy/iGDRWfW5PE/HJU1pxmPlEGhfLdlb6IkqwM
         JaTcKVZm/kwELJnWdFihtU8sUG3akr/gnM9wPIjKoS+nxK+iHk+SNUI+ML8twmoF3yDd
         rRABG2i2znyyhAfZM2kdpEZTwUDMQq+dtRkr8XHayvqXJioishzbk+8K8+lToxjC5mNh
         Kzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696545764; x=1697150564;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J55C2DECva8x20ZCPV5VaEapm9sYZn6cEu2d8qLrjfw=;
        b=DGvUzu648lXYHaslspm/jiJNin987ZJ08/q24FVQZ115f3bjbK+cyd4jhVxDwhgWG+
         6czkD8nYv6ZCJwxj3pWjoOa7pa+NFcWZtlOzLwEvCFfTz+XyUFaR8Ha60qEf+EJIxwUq
         pTCMg91IrYzob8D+96xz2/o2A1zb6OAd6qtGcxiaWPXmFktuYpLYEDNZ1M9Qcz9q4Ox3
         bwBXaU/srlkweYZuiwwOo4izyLP2pZ0aUDpzPrrXR78rMcIpdNQXC9NVWF3YQFTXkbTG
         kTZJuDxXtczgK7YnidKHzu3WJKtSTs2jHzGuWYkWM6F8rgKrEUvfXEQDtJ0SpCoNEkMw
         Io3g==
X-Gm-Message-State: AOJu0YwU/bloC+IyRbRmUh6y4frqWlnEaNcQKXf35cm84m/dCiIzn8b0
        3qTC8Jp2JXGlI1wHx/uVCnVumA==
X-Google-Smtp-Source: AGHT+IGEkk1/dB0O8kz/B/IOyEVgYrzdTBNr3I5VSfV7uBhvhWf6AWTlOwegLw3Kr7Ps7P1/Hd7iEA==
X-Received: by 2002:a05:6512:2512:b0:4fb:740a:81ae with SMTP id be18-20020a056512251200b004fb740a81aemr6924452lfb.16.1696545764617;
        Thu, 05 Oct 2023 15:42:44 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id d24-20020ac25458000000b005009b979e3dsm31121lfn.303.2023.10.05.15.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 15:42:44 -0700 (PDT)
Message-ID: <77b410f5-93a2-48be-a0d4-2053f280bc8b@linaro.org>
Date:   Fri, 6 Oct 2023 01:42:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/msm/dp: Remove error message when downstream port
 not connected
Content-Language: en-GB
To:     Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
References: <20230906181226.2198441-1-swboyd@chromium.org>
 <20230906181226.2198441-3-swboyd@chromium.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230906181226.2198441-3-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 21:12, Stephen Boyd wrote:
> Plugging in an Apple dongle without the HDMI cable attached prints out
> an error message in the kernel logs when nothing is actually wrong.
> 
>     no downstream ports connected
> 
> This is because the downstream port for the HDMI connector is not
> connected, so the Apple dongle reports that as a zero sink count device.
> 
> Cc: Vinod Polimera <quic_vpolimer@quicinc.com>
> Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/gpu/drm/msm/dp/dp_panel.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
> index 97ba41593820..ae778e1a6fd0 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
> @@ -156,7 +156,6 @@ int dp_panel_read_sink_caps(struct dp_panel *dp_panel,
>   	if (drm_dp_is_branch(dp_panel->dpcd)) {
>   		count = drm_dp_read_sink_count(panel->aux);
>   		if (!count) {
> -			DRM_ERROR("no downstream ports connected\n");

Maybe this can be converted to drm_dbg_dp?

>   			panel->link->sink_count = 0;
>   			return -ENOTCONN;
>   		}

-- 
With best wishes
Dmitry

