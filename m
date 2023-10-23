Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B58B7D3A28
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjJWO6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjJWO6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:58:03 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BE510CB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:57:57 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40837ebba42so25145075e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698073076; x=1698677876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4sb9XVGW0QNKpavfuN9oxWsbx8M351MiA2dCW1xgcc=;
        b=nXhPLoe4fhdUKga+rifOvUMU/NRI4JwjULzZ/AZ9zDfyHOlN6ySFu3bBn+sTM5jiBz
         Pbn1PHkZetIh4xSFaZPjVj/XY9RJhyJVHtLYQhkDrBK65xanx9BHqWa+jWwl4GVVuj8c
         CnDuV5FX2eX9nFQ66wgafGtlTrrMOEZOCs/HODynb8B8gFCrvQPRlb6QpFykIDOr2jo9
         YllNWKEbkQdDqdTXf5oHQrJ953nJnI7yeHhTinu857pNFamoEvvlLE8m/XK+p5lQVkvo
         SlX8WqwIBE8XfZ4O9QM7YoaqHbA2rRLZV+XFsYv2ymjxeVK0bbBSHMP2PfyVV5euqPK0
         CDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698073076; x=1698677876;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X4sb9XVGW0QNKpavfuN9oxWsbx8M351MiA2dCW1xgcc=;
        b=CWqeSDOwvoiZpGPiDJns7i+9E0fF8zemMRbYHIAyc1mCDIf9Q0DRSDUMRolLH9dsBi
         Asm+WryL2ys20tB9CgazZHztyAHQE9UVokOhnrC+MDX3iMwTCSFMQhaxM98x2//VNqrY
         O2Ea9glDP14KaWoXq690Zwbpxz++I7CtaS314l67wdP7wmEuCaVs7k3jKeN7CWr3iq4D
         h6UlpaNTDJorywG2oCJJfff1Ym8j403davpZqQlyti9WUhRWtb5/cjQ0UWTuOoKdQtL+
         NM67R388MvnscVmqWwOHyRLkOIBrOYnixeX5ZVKaY6jfQibUANShxP/bCEIU7NtODHS/
         Wb8w==
X-Gm-Message-State: AOJu0YxOvuzJPF0FVEC651XvOVVcLLib4J33brv/dXCYZKdcYvzzPYOp
        QW37091B5iBOWfovsKrXjUn1yw==
X-Google-Smtp-Source: AGHT+IHui4rUsP9khjsKc/fS6TOgZjAVE9q7nFPizFWwt54lJdTljB6STJsMyrfiujNUFdNh9niqyA==
X-Received: by 2002:a05:600c:3c8d:b0:408:434c:dae7 with SMTP id bg13-20020a05600c3c8d00b00408434cdae7mr8254117wmb.2.1698073075657;
        Mon, 23 Oct 2023 07:57:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a36e:a5d9:26ae:74b1? ([2a01:e0a:982:cbb0:a36e:a5d9:26ae:74b1])
        by smtp.gmail.com with ESMTPSA id x9-20020a05600c420900b004065e235417sm14163567wmh.21.2023.10.23.07.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 07:57:55 -0700 (PDT)
Message-ID: <53982fa5-3396-4c1f-8360-18957fd687e8@linaro.org>
Date:   Mon, 23 Oct 2023 16:57:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [RFC] Clean up check for already prepared panel
Content-Language: en-US, fr
To:     Yuran Pereira <yuran.pereira@hotmail.com>
Cc:     sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org
References: <DB3PR10MB68352B33759F5DB6CC041C84E8D8A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
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
In-Reply-To: <DB3PR10MB68352B33759F5DB6CC041C84E8D8A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
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

On 23/10/2023 16:51, Yuran Pereira wrote:
> Since the core function drm_panel_prepare already checks if the
> panel is prepared, we can remove this duplicate check from tm5p5_nt35596_prepare
> which acts as a no-op. As suggested in the GPU TODO [1]
> 
> [1] https://docs.kernel.org/gpu/todo.html#clean-up-checks-for-already-prepared-enabled-in-panels
> 
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> ---
>   drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c b/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c
> index 075a7af81eff..af83451b3374 100644
> --- a/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c
> +++ b/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c
> @@ -112,9 +112,6 @@ static int tm5p5_nt35596_prepare(struct drm_panel *panel)
>   	struct device *dev = &ctx->dsi->dev;
>   	int ret;
>   
> -	if (ctx->prepared)
> -		return 0;
> -
>   	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>   	if (ret < 0) {
>   		dev_err(dev, "Failed to enable regulators: %d\n", ret);
> @@ -132,7 +129,6 @@ static int tm5p5_nt35596_prepare(struct drm_panel *panel)
>   		return ret;
>   	}
>   
> -	ctx->prepared = true;
>   	return 0;
>   }
>   

This has already been done and merged in:
https://patchwork.freedesktop.org/patch/msgid/20230804140605.RFC.1.Ia54954fd2f7645c1b86597494902973f57feeb71@changeid

Thanks,
Neil
