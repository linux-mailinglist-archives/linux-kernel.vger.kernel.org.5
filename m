Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD68802F9E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjLDKIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbjLDJzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:55:35 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF96CB6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:55:40 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-33349b3f99aso581072f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 01:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701683739; x=1702288539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jxjebb37Sne+DCka+TV8LuBzeXYyvVFK5U1pDR7IXD0=;
        b=RnmmTIjO5ViWHtTq64w2ItHw+F38lPi528l0YiBJtiMIjLvlgKCnO6+KUJq9vzsJq5
         OY0sU/ZuNgMQhJTF/BqxoMuSKDmwFmbCE+CgHNnrk7hdrbi6p+0qWDHZyXnfByrF37th
         HKRzuPjq7ry82e6Zfi/qXxl7YwqKoqBguTm1PQliJmu42EN4fyemVzhmA2DrKEHKlom1
         D5zHbuaxMzTO3jPM6H586xNz8al2UdmPxWuqmAg9+yH26xuYB+svGCMSkn9lu9b6FNrM
         lHH1bdN6gsvN1CdwqivOaj7YqRBA4v/ljbNBI0PpIj5SVK2SgzxnyULhE4CHQWgX+Ryh
         eDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701683739; x=1702288539;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jxjebb37Sne+DCka+TV8LuBzeXYyvVFK5U1pDR7IXD0=;
        b=aMlIMs39Gv656CiL1CuTa0qjWGLe+jM0amZEcPegt7H4Rc6Df35FOpfJb4necs7XXW
         ldSY3V+ALXqVx2ca1VBhcceuTl6cHo8SsnCGRVTr+BJaQ3AMPl7qp0ZBeZl0WbX1XIqH
         9Z4vNBTCxrAnOtTmLsLD0oeDBA6GBvgfUQONXHbCVGKEvnVEH5+lXCU2H5UfmzJ7mAQ2
         D/Jc8F+8GD/a/E1TMPzW6eyAgWRgV237a3RhpBq4vPll/bt/AmfIfGQQi+AKH2uef0Xv
         XohUwgWKthzRUVxoJM78MVQadMXvBydK1q6RwGd/2gKRisDDBZgiSJBBaG0u6gSlOhrb
         a8ig==
X-Gm-Message-State: AOJu0Yw9ffOgFs1PG3aXq+pT3vtkNMtqfmbzfKdj4EIVW+s938cJlgzu
        E6zLppmt389D0F7x9QIyh5YRdw==
X-Google-Smtp-Source: AGHT+IHOF2x2nOBvKzkL5ClpV4l+rVoeI49QmCyyViebLcCdoNL/gwOZllNFKElB4n4NjA2FqTxO9g==
X-Received: by 2002:a5d:4291:0:b0:332:f8d2:6407 with SMTP id k17-20020a5d4291000000b00332f8d26407mr3737740wrq.64.1701683739255;
        Mon, 04 Dec 2023 01:55:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:58:12b5:777b:9d17? ([2a01:e0a:982:cbb0:58:12b5:777b:9d17])
        by smtp.gmail.com with ESMTPSA id g3-20020a056000118300b0033340b6d3a7sm4421442wrx.76.2023.12.04.01.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 01:55:38 -0800 (PST)
Message-ID: <bb1554d0-7a5e-4b1e-a8e7-bcfabad9b070@linaro.org>
Date:   Mon, 4 Dec 2023 10:55:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: tc358768: select CONFIG_VIDEOMODE_HELPERS
To:     Arnd Bergmann <arnd@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20231204072814.968816-1-arnd@kernel.org>
Content-Language: en-US, fr
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
In-Reply-To: <20231204072814.968816-1-arnd@kernel.org>
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

On 04/12/2023 08:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A dependency on this feature was recently introduced:
> 
> x86_64-linux-ld: vmlinux.o: in function `tc358768_bridge_pre_enable':
> tc358768.c:(.text+0xbe3dae): undefined reference to `drm_display_mode_to_videomode'
> 
> Make sure this is always enabled.
> 
> Fixes: e5fb21678136 ("drm/bridge: tc358768: Use struct videomode")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/gpu/drm/bridge/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index ba82a1142adf..3e6a4e2044c0 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -313,6 +313,7 @@ config DRM_TOSHIBA_TC358768
>   	select REGMAP_I2C
>   	select DRM_PANEL
>   	select DRM_MIPI_DSI
> +	select VIDEOMODE_HELPERS
>   	help
>   	  Toshiba TC358768AXBG/TC358778XBG DSI bridge chip driver.
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
