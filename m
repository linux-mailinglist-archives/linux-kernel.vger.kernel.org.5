Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3F57D3800
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjJWN0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjJWN02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:26:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5E210F5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:25:04 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4079ed65471so27265955e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698067502; x=1698672302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MfTe2mItOOKjEsaFlS0tcGkoINaBgb/MwgZiyuRpNWc=;
        b=T8g4X9IyouMZIo6Qe/6IvdeurXuDJcmI5VqTF7Rwl8G5ny0Jj5P3Y3aHgitpA02PL1
         yugiwSc4eP5fQC5owyCKiRJyKrYD09tXco5WEhauhSupuTB9hDUMr5TTMcB49pca0ivn
         5v8TbtdU0p5rxyb8Sy7v6gFfu9LhbOQtqJdIRmkrMznFjwB9gBBdEIN7SGK3k+dXHiYp
         aND5TH0sSRIfcLx+p6fClqBdgIrU56LApSAnl1Y/mzIGCEViMd6Od/A8EPKI6u3CuKbI
         2qYB9jme25RYOFUQ8POdqJwwP5rN1IevwFbFcXoYBYh8LBa7htIN0PYk0i2eQ5NQy0qq
         8C6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698067502; x=1698672302;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MfTe2mItOOKjEsaFlS0tcGkoINaBgb/MwgZiyuRpNWc=;
        b=LlCR5wrUEuT3CAx5SFCdAmIfhxY28peCTLXrM0O69KursFYblCJVK2YWEm7ef80EZw
         QFDNuKEYRS9ZLj5rGfQBbTdi7FIKbzx3lrqs+yeGAXUFkp9/OEY3qdl4AMvwQd7ewirD
         fhhIYNkLwLPul5MFiSz2jqkz7AC9eQ4sziCYLe1pYgI+3P8e5IYmVPhVQgWlKNvsXeLX
         bvbVRnmVgJSgZTNKVRmvAjOrhTAhXvAoQCr+dRhHZyJxRFdZ7pdB0ykVzlN1UYnQPRCU
         8/Cwe4TWfocnx4nKLF6ViM/1FMK7wfZyDjIISC4UfwqSkZPv399t6b0BPKluCOzmRugf
         V1CA==
X-Gm-Message-State: AOJu0Yz4TxHOWYXfk/EdJSWJ//vAeyduuIiOOjeU/POkL46E+9tmyYgX
        Bx7iMV6b6SBwcqOVZf60Xgz4Pw==
X-Google-Smtp-Source: AGHT+IEduB7wx3eedVGayKFCj1JBqguF5m2D0FBesP2GCt4VG7PKD6l90JrFEf446JDrgRBgMq5d3A==
X-Received: by 2002:a05:600c:4506:b0:405:dbe2:df10 with SMTP id t6-20020a05600c450600b00405dbe2df10mr7584940wmo.35.1698067502387;
        Mon, 23 Oct 2023 06:25:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a36e:a5d9:26ae:74b1? ([2a01:e0a:982:cbb0:a36e:a5d9:26ae:74b1])
        by smtp.gmail.com with ESMTPSA id o6-20020a5d62c6000000b0032196c508e3sm7738393wrv.53.2023.10.23.06.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 06:25:01 -0700 (PDT)
Message-ID: <00e81457-9148-4ca1-8433-4b7cad0652b5@linaro.org>
Date:   Mon, 23 Oct 2023 15:25:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel/raydium-rm692e5: select
 CONFIG_DRM_DISPLAY_DP_HELPER
Content-Language: en-US, fr
To:     Arnd Bergmann <arnd@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20231023115619.3551348-1-arnd@kernel.org>
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
In-Reply-To: <20231023115619.3551348-1-arnd@kernel.org>
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

Hi,

On 23/10/2023 13:55, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> As with several other panel drivers, this fails to link without the DP
> helper library:
> 
> ld: drivers/gpu/drm/panel/panel-raydium-rm692e5.o: in function `rm692e5_prepare':
> panel-raydium-rm692e5.c:(.text+0x11f4): undefined reference to `drm_dsc_pps_payload_pack'
> 
> Select the same symbols that the others already use.
> 
> Fixes: 988d0ff29ecf7 ("drm/panel: Add driver for BOE RM692E5 AMOLED panel")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/gpu/drm/panel/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 99e14dc212ecb..a4ac4b47777fe 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -530,6 +530,8 @@ config DRM_PANEL_RAYDIUM_RM692E5
>   	depends on OF
>   	depends on DRM_MIPI_DSI
>   	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_DISPLAY_DP_HELPER
> +	select DRM_DISPLAY_HELPER
>   	help
>   	  Say Y here if you want to enable support for Raydium RM692E5-based
>   	  display panels, such as the one found in the Fairphone 5 smartphone.

Will apply once drm-misc-next-fixes is synced with the last drm-misc-next PR for v6.7.

Neil
