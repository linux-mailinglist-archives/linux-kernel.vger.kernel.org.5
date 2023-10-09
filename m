Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E477BD5E7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345580AbjJII4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345504AbjJII4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:56:21 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57B8AB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 01:56:18 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40651a726acso39090135e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 01:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696841777; x=1697446577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ueES/8yBzYqCwOAJln/R5/6edxFgxoHrnNrLI+a2X2k=;
        b=snwDKnlncJPnLIvjuXTU8CLyeBUR8muPltOH4WMMk7O9snPmU3Z1INAAyO3xxQh4fr
         Q9ii0O7+xGzu+ed8dnwOJpUVTqJ3ie9EIztIL8KKU06f0skaeX6hpnkb/+R/6OMxrvs6
         Qq9H+RlGXd0KgEQHXUvn/FXnR9IDRNtdo7zBWvI+RBn5CbvgSHFbqD8BDCg6muq/G/eN
         NuJxFkIs+VRb93qwhhOOQ0s/jZKouYtudbnJRJkJ/+NdqgjmNOUmHy+eQlPTAZ8WgwKh
         l//GhiCXp2vGA3Xyk0Fd5wwZnfo0abDzpco8TbRsGcGDg88scW3bDjt20vuqJMAtfN35
         tliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696841777; x=1697446577;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ueES/8yBzYqCwOAJln/R5/6edxFgxoHrnNrLI+a2X2k=;
        b=d2q4qwd8+tZC85AbJIuOj8nCnE/lV0/US79Kph20VT2xCztILvd0BAKUBVufojSS66
         LMBXkHJcr1SwImPB8qWFweKLZpX0z5SMrkUxrP/ll7+8aPnr/GR0DYThckQmVJq/Qzol
         /5CoW9VJigJkJwmxDAO3/+4ShIPYaV6hq7lfaZ2Y8xBRE0xTBkxweun0Sp2Da7dFI0vs
         GLHobflbaDUS+JNr7edSyDzcac/BP9e3Zvq0C5AK1xVw9bjtmxtEPqwc+7ZDE0lfvdSp
         FXx3c/3HRkvCmh+9Bx52T96SR6pXYVVhM7BCloJlRw/3C7Oa8TucLw42YVa9lYFWmHUu
         RJhQ==
X-Gm-Message-State: AOJu0Yz3zD0rv65rmdhx91McX1rqnJQ2qeyW83Cef+g5z+w7HUabMNAV
        33g1mMBpHJzMDBshx54zf9jDMQ==
X-Google-Smtp-Source: AGHT+IFKl1Du09bcDEqIqN0Dx2j1ILGNurHoolKTWXzQ/hnHVeJLeVvEMzSxrr++xZO03RYyGjt2Og==
X-Received: by 2002:a5d:630c:0:b0:31f:fa6a:936e with SMTP id i12-20020a5d630c000000b0031ffa6a936emr13100829wru.17.1696841777144;
        Mon, 09 Oct 2023 01:56:17 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id f15-20020a5d50cf000000b00323330edbc7sm8974100wrt.20.2023.10.09.01.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 01:56:16 -0700 (PDT)
Message-ID: <1b9b0c61-1f28-4e5b-96bf-65c3d3896a0a@linaro.org>
Date:   Mon, 9 Oct 2023 10:56:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel/panel-tpo-tpg110: fix a possible null pointer
 dereference
Content-Language: en-US, fr
To:     Ma Ke <make_ruc2021@163.com>, linus.walleij@linaro.org,
        sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20231007030318.3996798-1-make_ruc2021@163.com>
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
In-Reply-To: <20231007030318.3996798-1-make_ruc2021@163.com>
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

On 07/10/2023 05:03, Ma Ke wrote:
> In radeon_fp_native_mode(), the return value of drm_mode_duplicate()

Wrong function, it should be tpg110_get_modes()

Thanks,
Neil

> is assigned to mode, which will lead to a NULL pointer dereference
> on failure of drm_mode_duplicate(). Add a check to avoid npd.
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

