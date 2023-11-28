Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D247FB405
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344116AbjK1IY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344121AbjK1IYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:24:25 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE5BE1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:24:31 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bba1dd05fso506260e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701159869; x=1701764669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjZBEQ9AyQtIh3obfbE4Kjaq3VrAc19BWN06fxuJK0Y=;
        b=RsxW4iP+SSSqjAB4BROYtdW/SeDrqY59jZhNsLNMQQnofapca8DpRnKoAhHmD48SLi
         B6zfTAKFRW1iTJqxqOHZTBPgU58TFqwidY2mEgng3OEVH8W9OVrPTcWUoRcuoycFnwVZ
         N842rVF3Re2gj0Q5g0qILyX6XMLkXdM/YxRHvXT4gwjxBw633YovWzYWW+kAW0PMj9Jh
         yim1MYQOcblk48QOfB7IffLmY0Q/1E+V28GlpbzFa0vgUl2I342I0sTv9hpNlpp7Wj0d
         uyxOdixIQvMEMpeqQa53uhKrRvIxXQ0BbtwRyn+uhGYCmFgwG7dGszQbx1s0IDnNAFfs
         /Uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701159869; x=1701764669;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zjZBEQ9AyQtIh3obfbE4Kjaq3VrAc19BWN06fxuJK0Y=;
        b=S/iOo9SCg+TJUrQgLw09JTR5V4UEh0RluchhuJZW3f0M2lkaR5L6PEeQoAHVRVAmlt
         a7PCiOq0pIPqgjjHNZnK3IMzZfs1VHLzTXRzrRIUWdIIj/aPg8TIGItGcLkT7w8/Xbr0
         gpHckjN6Kx18+RXOf3+aDJnotEzGtBHQbRDFjrP+ffR1WmIkyX1lr5BlWBQ8uant5M2Z
         daRVNQnsCQStzSetPhcX4R7dyrwmpIjnJJ3iXwGBsiQZTcAMuBVqe+ltACgrgIMeFfNI
         Dj2M/X2YHIer9F7eZpTthHVeOImOCSuYbtmT/7QHfPAoZRR46XdXA8NDHLz8L5nf/B0R
         kKRA==
X-Gm-Message-State: AOJu0Yy84NYz2oxSNaxywC+HPaFpcYS32OMP56b+cLtHXgPStPirtOT4
        rdwAW4KdgMJHbyQlmkEb3c4Wnw==
X-Google-Smtp-Source: AGHT+IH8Z4mDZsxySIBMwyAcd7FKhE4ahDXn1VO+snYpIIrZ5VNift1glxxYRZIyrMA/ipnuRL0SOg==
X-Received: by 2002:a05:6512:1386:b0:507:a9b7:f071 with SMTP id fc6-20020a056512138600b00507a9b7f071mr13170044lfb.1.1701159869318;
        Tue, 28 Nov 2023 00:24:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe? ([2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c3b1200b00405959469afsm16730777wms.3.2023.11.28.00.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 00:24:28 -0800 (PST)
Message-ID: <63412979-d7fa-4147-8c38-f576503a3173@linaro.org>
Date:   Tue, 28 Nov 2023 09:24:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/3] Revert "drm/bridge: panel: Check device dependency
 before managing device link"
Content-Language: en-US, fr
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liu Ying <victor.liu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20231128-revert-panel-fix-v1-0-69bb05048dae@linaro.org>
 <20231128-revert-panel-fix-v1-2-69bb05048dae@linaro.org>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20231128-revert-panel-fix-v1-2-69bb05048dae@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2023 00:10, Linus Walleij wrote:
> This reverts commit 39d5b6a64ace77d0c11c398d272218df5f939abb.
> 
> This patch was causing build errors by using an unexported
> function from the device core, which Greg questions the
> saneness in exporting.
> 
> Link: https://lore.kernel.org/lkml/CACRpkdaGzXD6HbiX7mVUNJAJtMEPG00Pp6+nJ1P0JrfJ-ArMvQ@mail.gmail.com/T/
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>   drivers/gpu/drm/bridge/panel.c | 27 +++++++++------------------
>   1 file changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> index 5e8980023407..e48823a4f1ed 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -23,7 +23,6 @@ struct panel_bridge {
>   	struct drm_panel *panel;
>   	struct device_link *link;
>   	u32 connector_type;
> -	bool is_independent;
>   };
>   
>   static inline struct panel_bridge *
> @@ -68,17 +67,12 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
>   	struct drm_device *drm_dev = bridge->dev;
>   	int ret;
>   
> -	panel_bridge->is_independent = !device_is_dependent(drm_dev->dev,
> -							    panel->dev);
> -
> -	if (panel_bridge->is_independent) {
> -		panel_bridge->link = device_link_add(drm_dev->dev, panel->dev,
> -						     DL_FLAG_STATELESS);
> -		if (!panel_bridge->link) {
> -			DRM_ERROR("Failed to add device link between %s and %s\n",
> -				  dev_name(drm_dev->dev), dev_name(panel->dev));
> -			return -EINVAL;
> -		}
> +	panel_bridge->link = device_link_add(drm_dev->dev, panel->dev,
> +					     DL_FLAG_STATELESS);
> +	if (!panel_bridge->link) {
> +		DRM_ERROR("Failed to add device link between %s and %s\n",
> +			  dev_name(drm_dev->dev), dev_name(panel->dev));
> +		return -EINVAL;
>   	}
>   
>   	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
> @@ -86,8 +80,7 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
>   
>   	if (!bridge->encoder) {
>   		DRM_ERROR("Missing encoder\n");
> -		if (panel_bridge->is_independent)
> -			device_link_del(panel_bridge->link);
> +		device_link_del(panel_bridge->link);
>   		return -ENODEV;
>   	}
>   
> @@ -99,8 +92,7 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
>   				 panel_bridge->connector_type);
>   	if (ret) {
>   		DRM_ERROR("Failed to initialize connector\n");
> -		if (panel_bridge->is_independent)
> -			device_link_del(panel_bridge->link);
> +		device_link_del(panel_bridge->link);
>   		return ret;
>   	}
>   
> @@ -123,8 +115,7 @@ static void panel_bridge_detach(struct drm_bridge *bridge)
>   	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
>   	struct drm_connector *connector = &panel_bridge->connector;
>   
> -	if (panel_bridge->is_independent)
> -		device_link_del(panel_bridge->link);
> +	device_link_del(panel_bridge->link);
>   
>   	/*
>   	 * Cleanup the connector if we know it was initialized.
> 

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
