Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCA47BD5E9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345590AbjJII4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345584AbjJII4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:56:33 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A49ED
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 01:56:30 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50307acd445so5363809e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 01:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696841788; x=1697446588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ChWpLMUD+BbEHc72eqlablETJQRcBST3BsLrGcOm/6s=;
        b=Ov4716z0T+311CF9IlQYYfcgB9G7kqXwfT/w8J75C8/PXFPY2nJXJie1ojni3nSxDV
         oq+ZR2jImx0s8su2vw5lxJE3zibRlCUigLjQxt/i9qpDJk2L/0w9ry2uA7RRGCzBskao
         rXM++sD4XaBOm3yfmgS5t/heiQ4XpGTNGAEwcvYgVqSfoko/3q8rftbsOo5GuwBwgbMV
         GuEhp9TJR+5pC8jgm8GfjCMKdWi4oZ6Zi3eSTsVDKL5nH/doFkENBnlyfA3AhpE1lpFV
         Kx99mAM/Tp6eeXg7S8hbNcT3Oum8yYVKpTp2/RbiNdfNtwWTwqcnOPTi/xAG4nAAB71S
         XG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696841788; x=1697446588;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ChWpLMUD+BbEHc72eqlablETJQRcBST3BsLrGcOm/6s=;
        b=ZbIh5Iy7pvpf7/TMej4bFVtinkP8oHUYudosePRH26oCtPoQusEgc+7JrxBi9I1X45
         ts9OsU2xhxxDTaFWwIbXjrgMcbaYDzZITrJKS0tVoWz7lMoWrOSTcGBeXlt0w3D4mho+
         0iwk4dqrl+T1wsTh80Xzl6Je/xB2srQAp5g1JQwsbZ3sXnJtFQRR5F2/2/RH+Y7DrxdR
         Hi6t/TLmcYvEPpFqsubybKN7mO7nIguGo2JvPKiQZyG8TfMJ9Mktindt3LkwL+rnglKS
         CrPu0j00LUx67LgbP8rYtuIsKry5GLqPa1juPB9E0C2FH/8T8DNNcGfuZHOxmm/L2C2v
         hCIw==
X-Gm-Message-State: AOJu0YzvWpr696x+peDnt14DE6NHNcy/o2ibYZqY6Up4I0qts0umIZDQ
        A1VhacuI2pCWSgkKLmVJ58AR9w==
X-Google-Smtp-Source: AGHT+IGyuTLZ4fPvw+bBUFyo+rbizHaok4Vwz1d4frUaeSaATq0eKx9UQ6diDVdNYZraHDfo7Xs71w==
X-Received: by 2002:a19:6709:0:b0:503:3ac:8457 with SMTP id b9-20020a196709000000b0050303ac8457mr11851695lfc.45.1696841788363;
        Mon, 09 Oct 2023 01:56:28 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id f15-20020a5d50cf000000b00323330edbc7sm8974100wrt.20.2023.10.09.01.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 01:56:27 -0700 (PDT)
Message-ID: <63ff768e-2155-4e71-8888-8b9fe5079b76@linaro.org>
Date:   Mon, 9 Oct 2023 10:56:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: fix a possible null pointer dereference
Content-Language: en-US, fr
To:     Ma Ke <make_ruc2021@163.com>, linus.walleij@linaro.org,
        sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20231007033105.3997998-1-make_ruc2021@163.com>
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
In-Reply-To: <20231007033105.3997998-1-make_ruc2021@163.com>
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

On 07/10/2023 05:31, Ma Ke wrote:
> In versatile_panel_get_modes(), the return value of drm_mode_duplicate()
> is assigned to mode, which will lead to a NULL pointer dereference
> on failure of drm_mode_duplicate(). Add a check to avoid npd.
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>   drivers/gpu/drm/panel/panel-arm-versatile.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-arm-versatile.c b/drivers/gpu/drm/panel/panel-arm-versatile.c
> index abb0788843c6..1811bfaeb9c7 100644
> --- a/drivers/gpu/drm/panel/panel-arm-versatile.c
> +++ b/drivers/gpu/drm/panel/panel-arm-versatile.c
> @@ -267,6 +267,8 @@ static int versatile_panel_get_modes(struct drm_panel *panel,
>   	connector->display_info.bus_flags = vpanel->panel_type->bus_flags;
>   
>   	mode = drm_mode_duplicate(connector->dev, &vpanel->panel_type->mode);
> +	if (!mode)
> +		return -ENOMEM;
>   	drm_mode_set_name(mode);
>   	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
