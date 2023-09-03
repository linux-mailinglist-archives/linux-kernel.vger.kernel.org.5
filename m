Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69B9790F17
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 00:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348799AbjICWk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 18:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjICWkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 18:40:55 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05DCC4
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 15:40:51 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bcde83ce9fso13733451fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 15:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693780850; x=1694385650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4uZeHrs3brpLA9BIYNN/FvNUjPGrJaqU0dAdN56uTls=;
        b=Su+5VOcFYHV8orV5eTpeLki/BBncSmMH8vFTiS8JhEIE+hc9xj3kEkO1Ch80tPgbMY
         HH97aFaS6VFb8ks0MR7RwZ837GjRt+nQaWtTKPz20A4LuN/WSF3LDsev0T1x/GOfNyN2
         9FtpsbQGsYhpONBX0LkqJ8Tb5AILVG/79rQ8fpuljrRzx5Ehjx0zrx3d1C1qkWncT1n4
         hAgkyAzSjnA11Csfzkj9b3MLg2dAyq63XaUYsaB4Sr0OP79M8i7y3L9FwmQt78iNSsKp
         +bnfCvMxsJL4yniB/X2Iji5nve+FwVXL81KGhs7YEGVL7+cSFRUQ0GeBxTF2aI6ELVfu
         OxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693780850; x=1694385650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4uZeHrs3brpLA9BIYNN/FvNUjPGrJaqU0dAdN56uTls=;
        b=VFtfEd9MsCr8mMi+K1VVnExeGG54DBvum7v9eQKx7Jx7W+U1Dn0FDcZm7y9I1MmmiW
         P2iEnmqFZqEnlksU1ugwNl1w0xGt689Rg2mwpygbSe5PLv8PLKYilogCl2eT8tCP2Uxc
         3Ku4l1pYD0/+Ox5/rFQp5Dyg14pdAvU8X+m7O/9597AP1BQeDa2SqSRNjwCFK3wGyG+F
         f5u4yk+VHM5yhIoq9eScm5JwTZi/nxR9YuehU7au2JtJlQDYDvYY4hrJhmxZYXLJdKlq
         HQemoFuVXmes3b8MQLB3ovTS2OzzI+NiUXnQmYxEEBIrTev7nCUC0ENLsgae4co0YR5V
         AIaQ==
X-Gm-Message-State: AOJu0YyndNPFeJwyMJJ9RoimQUsX0C4/1N0kgv9qmZOsoxtOuQWNqr45
        PzNgR574dHtF4GwlF58vF8bnvQ==
X-Google-Smtp-Source: AGHT+IFmWZRk24SDi37FSiWwzAUFzDGcudEUHjvx8xHvUKUKpT4Ml6Ym6mavr1lOx4JWTmr2YnXbNA==
X-Received: by 2002:a05:6512:3083:b0:500:9524:f733 with SMTP id z3-20020a056512308300b005009524f733mr6407395lfd.20.1693780850292;
        Sun, 03 Sep 2023 15:40:50 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id bo9-20020a0564020b2900b0052889d090bfsm4972604edb.79.2023.09.03.15.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 15:40:49 -0700 (PDT)
Message-ID: <726d4be5-d207-4176-bc0d-43492eb2c4e5@linaro.org>
Date:   Mon, 4 Sep 2023 01:40:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] drm/msm/dp: Remove dp_display_is_ds_bridge()
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
 <20230829184735.2841739-8-swboyd@chromium.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230829184735.2841739-8-swboyd@chromium.org>
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
> This function is simply drm_dp_is_branch() so use that instead of
> open-coding it.
> 
> Cc: Vinod Polimera <quic_vpolimer@quicinc.com>
> Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 76f13954015b..96bbf6fec2f1 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -341,19 +341,12 @@ static const struct component_ops dp_display_comp_ops = {
>   	.unbind = dp_display_unbind,
>   };
>   
> -static bool dp_display_is_ds_bridge(struct dp_panel *panel)
> -{
> -	return (panel->dpcd[DP_DOWNSTREAMPORT_PRESENT] &
> -		DP_DWN_STRM_PORT_PRESENT);
> -}
> -
>   static bool dp_display_is_sink_count_zero(struct dp_display_private *dp)

Nit: you might as well inline this function

>   {
>   	drm_dbg_dp(dp->drm_dev, "present=%#x sink_count=%d\n",
>   			dp->panel->dpcd[DP_DOWNSTREAMPORT_PRESENT],
>   		dp->link->sink_count);
> -	return dp_display_is_ds_bridge(dp->panel) &&
> -		(dp->link->sink_count == 0);
> +	return drm_dp_is_branch(dp->panel->dpcd) && dp->link->sink_count == 0;
>   }
>   
>   static void dp_display_send_hpd_event(struct msm_dp *dp_display)

-- 
With best wishes
Dmitry

