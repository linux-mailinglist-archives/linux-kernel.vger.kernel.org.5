Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDDC7FB407
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344115AbjK1IY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344102AbjK1IYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:24:55 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC86DF5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:25:00 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50bbef0e5d5so140146e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701159899; x=1701764699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+YNpAXoY7RqHSKth6Tad17PREnvnHxofFJD9tpmWJw=;
        b=Z8/xS32MAWgAsKoiwQjC8LEmgSZR8KkwJJWypzOtmeh+6m2TphkL9j0TUwj9d16FBz
         fZo4IZRyJ/oAhR7h+1GT684uV+6fNKvV/xHiy5itKsseV346/7VhR+AqUX3+CwHa/EfC
         L9nD4SK76+w2RdJsyMovV9pcny1Yw+8guuSv7yvoxdaWa+EcTL7TqhXBXJVNXzUedy4b
         qP5W1tZEfn87hh6HkklFoDOv83AvzjxHiwLzDJVlGiXj7n2aPQrxa8Bhh4vfoad4fnLh
         kFqZGj1B+QwrKCgo8gl/A1hYBt+ufAyabG+E2IGpSi1SpZ8oitdlDYVVz5DfnLMBogvo
         eUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701159899; x=1701764699;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O+YNpAXoY7RqHSKth6Tad17PREnvnHxofFJD9tpmWJw=;
        b=uTM0MNklyFFHR3/PBltcUtRJnemUOqNj4G7gocC14EjnXqRdRHhOaGiy9udloRLUDZ
         rDrC0PZrmcwtChjuuNNn7JKRqouaNZSOiGC7ZYGwUkols7ZyV23eiFwANJpnzFVg8h4O
         Q1Cs4f8UwLHO5E3yO1JJOSokC1Dv8yzhIDnwJ8qD5TKeFhyg4ovzegMBFssFSql5OkZ4
         3xOx/NzbK+DaZjkp7C0pZW0BtY+CVbxaus3UFxbpnCNWZOyeFxBqiHs8eRl5yyhFlLtR
         0MMG6Brwv1Tq/8qpkmAwdtDI1l/EVUwZ19h2US6/F1A7oJjwQteS7gt34TEgK2crtWwj
         LJvg==
X-Gm-Message-State: AOJu0YwTiz0ezHbu1j6vpOOBNjNsIxEcnM291ClugQu5w2opYXbhWJR9
        C6pAX7RHfS1keO/+NQpeqZRPhA==
X-Google-Smtp-Source: AGHT+IGWGSTt3dq8UTk2cpUK7hzx6ClBhDFDv7AqYfQMFKdIqWRv/ImXRDqXQpLtgIQPEja2URI3vw==
X-Received: by 2002:ac2:58f8:0:b0:4fa:f96c:745f with SMTP id v24-20020ac258f8000000b004faf96c745fmr8254471lfo.38.1701159899088;
        Tue, 28 Nov 2023 00:24:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe? ([2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c3b1200b00405959469afsm16730777wms.3.2023.11.28.00.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 00:24:58 -0800 (PST)
Message-ID: <6e235fe1-d2ab-4a57-9f31-f16c22de5093@linaro.org>
Date:   Tue, 28 Nov 2023 09:24:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/3] Revert "drm/bridge: panel: Add a device link between
 drm device and panel device"
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
 <20231128-revert-panel-fix-v1-3-69bb05048dae@linaro.org>
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
In-Reply-To: <20231128-revert-panel-fix-v1-3-69bb05048dae@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2023 00:10, Linus Walleij wrote:
> This reverts commit 199cf07ebd2b0d41185ac79b895547d45610b681.
> 
> This patch creates bugs on devices where the DRM device is
> the ancestor of the panel devices.
> 
> Attempts to fix this have failed because it leads to using
> device core functionality which is questionable.
> 
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> Link: https://lore.kernel.org/lkml/CACRpkdaGzXD6HbiX7mVUNJAJtMEPG00Pp6+nJ1P0JrfJ-ArMvQ@mail.gmail.com/T/
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>   drivers/gpu/drm/bridge/panel.c | 17 -----------------
>   1 file changed, 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> index e48823a4f1ed..7f41525f7a6e 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -4,8 +4,6 @@
>    * Copyright (C) 2017 Broadcom
>    */
>   
> -#include <linux/device.h>
> -
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_bridge.h>
>   #include <drm/drm_connector.h>
> @@ -21,7 +19,6 @@ struct panel_bridge {
>   	struct drm_bridge bridge;
>   	struct drm_connector connector;
>   	struct drm_panel *panel;
> -	struct device_link *link;
>   	u32 connector_type;
>   };
>   
> @@ -63,24 +60,13 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
>   {
>   	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
>   	struct drm_connector *connector = &panel_bridge->connector;
> -	struct drm_panel *panel = panel_bridge->panel;
> -	struct drm_device *drm_dev = bridge->dev;
>   	int ret;
>   
> -	panel_bridge->link = device_link_add(drm_dev->dev, panel->dev,
> -					     DL_FLAG_STATELESS);
> -	if (!panel_bridge->link) {
> -		DRM_ERROR("Failed to add device link between %s and %s\n",
> -			  dev_name(drm_dev->dev), dev_name(panel->dev));
> -		return -EINVAL;
> -	}
> -
>   	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
>   		return 0;
>   
>   	if (!bridge->encoder) {
>   		DRM_ERROR("Missing encoder\n");
> -		device_link_del(panel_bridge->link);
>   		return -ENODEV;
>   	}
>   
> @@ -92,7 +78,6 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
>   				 panel_bridge->connector_type);
>   	if (ret) {
>   		DRM_ERROR("Failed to initialize connector\n");
> -		device_link_del(panel_bridge->link);
>   		return ret;
>   	}
>   
> @@ -115,8 +100,6 @@ static void panel_bridge_detach(struct drm_bridge *bridge)
>   	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
>   	struct drm_connector *connector = &panel_bridge->connector;
>   
> -	device_link_del(panel_bridge->link);
> -
>   	/*
>   	 * Cleanup the connector if we know it was initialized.
>   	 *
> 

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
