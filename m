Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0439376FBDB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjHDIXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbjHDIXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:23:00 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA507AC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:22:58 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe2fb9b4d7so17709945e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691137377; x=1691742177;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gqxlgcpfhwpFaXOSuUXztrVkPV/filJ7HPI5vUJFn3E=;
        b=la56hkmB5KE/vOZuUxcRaQmvZ9MPF1D/ZT7jq21xwwgHzFLMD4dPW5/wJdduQftQwQ
         NMa883gmLxCK3Lya0Fb1kEgjoxoAb5MehiBui6PLmTFKp4gD8hhFUIWi2K1HcGEea1Cr
         vXkv6la4FfyMKuPogb6rVlOJqZdHZaIFRxqVMHDWs/tdOgVsLZe0ZmXERhgVDQreNyhp
         8R5xi2VL809H4dHkjecL0tCJCTtYKs7af13o8yoncFirEPjET66BiNeALHjgit16amwL
         e9B4WL7jZSs/paDR8b1lIAvUMgvgfABlMUFoYYwji/kzjOQ87Y52KPQGv/XLli4dPEz6
         qZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691137377; x=1691742177;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gqxlgcpfhwpFaXOSuUXztrVkPV/filJ7HPI5vUJFn3E=;
        b=TD+06KYxRfa/ddxkHCrnxN1QUQkFVd7iEBh7fRxOeLjOoTrLZBl5oIyqJg6hegEeNe
         zf8C6xtr/eI0ewwJV1H3stLaSo/Uvme4dtXnlPqnPLw1onW+MPbyk8j61KNqpvclWJ6p
         ctd90OO3qxkbwLt77F8LKszoASA2GJWvUX2H5DZFajgaAQxltYT2NHvJtVpcYUkm7WOx
         frScC30Cl/pAlkwA3vleaFby4SjMo7z21Z9RthPTqZUcgd7dBN+lTCHgjgphJ6F+LltC
         walvnTBEL4stffdbMbkdasYBvsI5X5DUSG4LH5b0wY6i7pjPe5dY0FHL37Jx+gN3Pnt6
         cJBg==
X-Gm-Message-State: AOJu0YzNhcMU5VwqJuNUvUCzIpC3I87hzFeUxWZvSgOpFWLTFFIPGevj
        UKGtA6f7AvK0PNl4H/BXii1tWw==
X-Google-Smtp-Source: AGHT+IG2FD99zjQl1RKbp122WjUmU7duUYTnuzjwbWYiAUstk12U3P1aLTLGGMkCF2ZwFb7pd/4o2A==
X-Received: by 2002:a7b:c7cc:0:b0:3fb:ffa8:6d78 with SMTP id z12-20020a7bc7cc000000b003fbffa86d78mr945295wmk.36.1691137377113;
        Fri, 04 Aug 2023 01:22:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b526:9083:f5a6:4af1? ([2a01:e0a:982:cbb0:b526:9083:f5a6:4af1])
        by smtp.gmail.com with ESMTPSA id h6-20020a5d6e06000000b0031435731dfasm1884500wrz.35.2023.08.04.01.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 01:22:56 -0700 (PDT)
Message-ID: <4912be5e-99c8-588c-9fb4-0d8a404c4b62@linaro.org>
Date:   Fri, 4 Aug 2023 10:22:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] drm: bridge: dw_hdmi: Fix ELD is not updated issue
Content-Language: en-US
To:     Sandor Yu <Sandor.yu@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     andrzej.hajda@intel.com, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, adrian.larumbe@collabora.com,
        treding@nvidia.com, the.cheaterman@gmail.com,
        l.stach@pengutronix.de, ville.syrjala@linux.intel.com,
        cychiang@chromium.org, shengjiu.wang@nxp.com
References: <20230804061145.2824843-1-Sandor.yu@nxp.com>
Organization: Linaro Developer Services
In-Reply-To: <20230804061145.2824843-1-Sandor.yu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 08:11, Sandor Yu wrote:
> The ELD (EDID-Like Data) is not updated when the HDMI cable
> is plugged into different HDMI monitors.
> This is because the EDID is not updated in the HDMI HPD function.
> As a result, the ELD data remains unchanged and may not reflect
> the capabilities of the newly connected HDMI sink device.
> 
> To address this issue, the handle_plugged_change function should move to
> the bridge_atomic_enable and bridge_atomic_disable functions.
> Make sure the EDID is properly updated before updating ELD.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> 
> ---
> v2:
>    - Add the variable of last_connector_result back to driver.
>      It will only be used to initialize audio codec jack status when audio codec driver probe.
> 
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index aa51c61a78c7..963050de42c3 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2463,15 +2463,7 @@ static enum drm_connector_status dw_hdmi_detect(struct dw_hdmi *hdmi)
>   	enum drm_connector_status result;
>   
>   	result = hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
> -
> -	mutex_lock(&hdmi->mutex);
> -	if (result != hdmi->last_connector_result) {
> -		dev_dbg(hdmi->dev, "read_hpd result: %d", result);
> -		handle_plugged_change(hdmi,
> -				      result == connector_status_connected);
> -		hdmi->last_connector_result = result;
> -	}
> -	mutex_unlock(&hdmi->mutex);
> +	hdmi->last_connector_result = result;
>   
>   	return result;
>   }
> @@ -2971,6 +2963,7 @@ static void dw_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
>   	hdmi->curr_conn = NULL;
>   	dw_hdmi_update_power(hdmi);
>   	dw_hdmi_update_phy_mask(hdmi);
> +	handle_plugged_change(hdmi, false);
>   	mutex_unlock(&hdmi->mutex);
>   }
>   
> @@ -2989,6 +2982,7 @@ static void dw_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
>   	hdmi->curr_conn = connector;
>   	dw_hdmi_update_power(hdmi);
>   	dw_hdmi_update_phy_mask(hdmi);
> +	handle_plugged_change(hdmi, true);
>   	mutex_unlock(&hdmi->mutex);
>   }
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
