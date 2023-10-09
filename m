Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390907BD680
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345648AbjJIJNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345657AbjJIJNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:13:12 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2A4B6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:13:09 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32487efc319so4088665f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 02:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696842788; x=1697447588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=riy2ohNnJTI8tyOBkVxN9+KyXQ2yc80mwJGtwl0WMgc=;
        b=ckI2uJTLQhGZNVBJdnLWclwcNcBtYhEilwWZhTK7Lbtsr4GvIcTSq6+borBYbbdJCz
         IN80eqYlf7KXBPtzdHIxWRPhCpMMMn3v7O36Mp0hCyTIsn1EmloVAdcv4SvRCAmygvw1
         WzUvN+TmLN7KSd4BQaRU0x56jrgAC9iUAFlLfOwlUO0XwjTLQ3J1ox1wUXtO51KoeE07
         +CnUegihTcLzdCwD3ySTq+G5zbm3f8VX4H2L93QNMTu+a16wwk8/LS0qSJ0PCFC4d8en
         jAAPk0blJV/ILf1eXh+/HdxxPzChTz3dEcTKvcbxOVTO70LjEM3eIUi4mSJv9po71ml5
         NpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696842788; x=1697447588;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=riy2ohNnJTI8tyOBkVxN9+KyXQ2yc80mwJGtwl0WMgc=;
        b=Rw1mHMnqMu7J5ZHky+heskI6uP/y3FD9/YvyvWZtvmMXy1+J1UGfIXmRaIHyRWikn2
         tEq7hEaPWO6UkPIS8lVN4LEIFQa7ENVs1hdefYqXGrgRfEBnkwyZNeLZwxnb6P8pN2CI
         FmP2b7/0oEt3HK7NssNYq985jPiuv7Rye1jO9k5GEJzKzp1toMPGqiNdMmnjjr7dIGXk
         vMrknSpBweSJhPGv/xwvay8NAif9wAuKTZaRH7W2Pz9I+KW0Uw+i5zqiw/bbCPKHBvLA
         FDwULzTh2oB9li/QYGMIZ48OBjUNAGxVY3bfdjKwtKGKK95cxKsju2SHMBXzOtsCiY+t
         MwLw==
X-Gm-Message-State: AOJu0Yy+Uj+z4onD3OvArOB0ogBblDW17MJhutfFbSwp29giKVxHTnI9
        UMnqfkKRNnH09mpRVq6UTiTaqw==
X-Google-Smtp-Source: AGHT+IGUWNNjEgJ0FR3882pEmsZ7c1/CLbNVn8Kj5cKMrT9umktbrGd+rVu/jugoM9qaPAym4jSJug==
X-Received: by 2002:adf:fdd0:0:b0:324:8353:716f with SMTP id i16-20020adffdd0000000b003248353716fmr12227404wrs.20.1696842788387;
        Mon, 09 Oct 2023 02:13:08 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id e18-20020adffd12000000b0031980783d78sm9021939wrr.54.2023.10.09.02.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 02:13:08 -0700 (PDT)
Message-ID: <e6384e25-dae3-4488-b1ca-e0c07a601741@linaro.org>
Date:   Mon, 9 Oct 2023 11:13:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] drm/panel/panel-tpo-tpg110: fix a possible null
 pointer dereference
Content-Language: en-US, fr
To:     Ma Ke <make_ruc2021@163.com>, linus.walleij@linaro.org,
        sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20231009090446.4043798-1-make_ruc2021@163.com>
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
In-Reply-To: <20231009090446.4043798-1-make_ruc2021@163.com>
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

On 09/10/2023 11:04, Ma Ke wrote:
> In tpg110_get_modes(), the return value of drm_mode_duplicate() is
> assigned to mode, which will lead to a NULL pointer dereference on
> failure of drm_mode_duplicate(). Add a check to avoid npd.
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>   drivers/gpu/drm/panel/panel-tpo-tpg110.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-tpo-tpg110.c b/drivers/gpu/drm/panel/panel-tpo-tpg110.c
> index 845304435e23..f6a212e542cb 100644
> --- a/drivers/gpu/drm/panel/panel-tpo-tpg110.c
> +++ b/drivers/gpu/drm/panel/panel-tpo-tpg110.c
> @@ -379,6 +379,8 @@ static int tpg110_get_modes(struct drm_panel *panel,
>   	connector->display_info.bus_flags = tpg->panel_mode->bus_flags;
>   
>   	mode = drm_mode_duplicate(connector->dev, &tpg->panel_mode->mode);
> +	if (!mode)
> +		return -ENOMEM;
>   	drm_mode_set_name(mode);
>   	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
