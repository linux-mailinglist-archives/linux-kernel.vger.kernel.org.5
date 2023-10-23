Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BF07D375E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjJWNCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjJWNCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:02:30 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C813D73
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:02:28 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c54c8934abso45309481fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698066146; x=1698670946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmrEJMDm9NV/OX4RuxTpHBh/JZKg9mwQsrXOAEEcbYc=;
        b=xm0V7Z4pCQV0Ib9Y+rvt5u7+BsLeppS0r0UuJfj2g1N/rjSMm/zQJc+kyWiZJTXXpx
         Q4/YCGybrKhHtjR2gpWBy5do1DYY2Tw8uWihwoXMujObBQLZjE2s+KnEbH65g+VFnfei
         wfUGhUOfJGbub56AmtOCuzeE2FH+CunVm3GQxFZ8Ql9Yi+quAMD1OIeynwgiuto+9iFj
         dVhzK86vo7rRzWPQ1TwjUqsBPz/7BWBDZl1aXhmJdgaXuSuFvKdKz4XVstdyOEFHhQjJ
         Ol1JxyQDg5ZqVvKc6k2WxLyqPj+n9er5If62nuc1ke2/6I9wgM2z58gbH/xxqipF+iDF
         WCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698066146; x=1698670946;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fmrEJMDm9NV/OX4RuxTpHBh/JZKg9mwQsrXOAEEcbYc=;
        b=mAocfBy7Qcrkl/DCn7fGdr4clc6BL1ete3eF4TsKtgyNQoniHKXVm3iuN7i8Z9CVas
         znwsJl+zevozD/nvVEVvVHaKcRXaflF4/MmGTr50BiL7hRiLAb1MqlpD1UaYtpzDxAVn
         +nx3vF6/r3dii327d2t99pAk9kNAE9yWDWBONyLTg/bZJQGwastpUy6uinFKcHRrEb0+
         nqyGhP8OHc39+nGzuLGQveYdHHHhNNdgqI6iOMpC7lfRi1dvweMnRwCKUiEHmrAgiuSI
         JdasCQ1cLLndlli4Iy0A+zaXVFJNtqwSWs8y0rGTa/BydBgpy/HHILcntyUNHN7DlBlH
         CMug==
X-Gm-Message-State: AOJu0YxFRX66fKBisVXkq6OS+Uluk1DDMx//VTa3GIyE2WoV5OWwBWVp
        v7rJ8S0Ia0AMWJiFpyy/Vb+cIw==
X-Google-Smtp-Source: AGHT+IHchV/cYmKpch+lkDxCiAwIOK0lDpGSdnb9Zr4gjJtjnKmGLfRonfeVWlpYTI6YHAaWbW3CVA==
X-Received: by 2002:a05:651c:4d2:b0:2c0:52e:eafa with SMTP id e18-20020a05651c04d200b002c0052eeafamr8896753lji.29.1698066146570;
        Mon, 23 Oct 2023 06:02:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a36e:a5d9:26ae:74b1? ([2a01:e0a:982:cbb0:a36e:a5d9:26ae:74b1])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c130e00b0040772934b12sm13983176wmf.7.2023.10.23.06.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 06:02:25 -0700 (PDT)
Message-ID: <6c415fb2-97f1-477c-b6ef-2e4c64e46dec@linaro.org>
Date:   Mon, 23 Oct 2023 15:02:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: nt35510: fix typo
Content-Language: en-US, fr
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org
References: <20231023090613.1694133-1-dario.binacchi@amarulasolutions.com>
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
In-Reply-To: <20231023090613.1694133-1-dario.binacchi@amarulasolutions.com>
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

On 23/10/2023 11:05, Dario Binacchi wrote:
> Replace 'HFP' with 'HBP'.
> 
> Fixes: 899f24ed8d3a ("drm/panel: Add driver for Novatek NT35510-based panels")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>   drivers/gpu/drm/panel/panel-novatek-nt35510.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35510.c b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
> index d6dceb858008..83a9cf53d269 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt35510.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
> @@ -1023,7 +1023,7 @@ static const struct nt35510_config nt35510_hydis_hva40wv1 = {
>   		.hdisplay = 480,
>   		.hsync_start = 480 + 2, /* HFP = 2 */
>   		.hsync_end = 480 + 2 + 0, /* HSync = 0 */
> -		.htotal = 480 + 2 + 0 + 5, /* HFP = 5 */
> +		.htotal = 480 + 2 + 0 + 5, /* HBP = 5 */
>   		.vdisplay = 800,
>   		.vsync_start = 800 + 2, /* VFP = 2 */
>   		.vsync_end = 800 + 2 + 0, /* VSync = 0 */

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
