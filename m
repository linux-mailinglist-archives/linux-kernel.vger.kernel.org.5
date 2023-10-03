Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1FB7B6A5B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbjJCNW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbjJCNWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:22:25 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22DABF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 06:22:21 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-406618d080eso9301995e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 06:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696339340; x=1696944140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPhEMScslRMaYaqRO+dwG2HnFAyJ6EQmjoVhDMsvm2g=;
        b=IAokKng1wNC58ZiZHAgQASpvPtYUAEa3YSukbCQf9EuZ1aG4cuBTMjvSFHvSbSJR2s
         4mJw2VrQ6sJ7CSHNmAhtz5emzTHeBFZIb5b4A/Rgjd41adA9cQu1d7G/N/GChKvtY20K
         gfYxTtRKj0Nq1dn2ZPRg7SIiuZvBcVF2YyeUIgMsfeJpKgBycPKMDAh032aPqzEuTUCZ
         iDZtUPpa/2j5/QCsuWNwpCWQXZcMFvJMGbQ5i8BuO/fcJcAN6iRIDd09UbxtnNsFI3ol
         ZKRjtPhA4HLz4QRXoGl7LNV3qx+LDfq/S/vh3t4Cu89CnW3RY63siyByEGqSdtaWjpKa
         hOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696339340; x=1696944140;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BPhEMScslRMaYaqRO+dwG2HnFAyJ6EQmjoVhDMsvm2g=;
        b=mbLLiEB3GqX8luBCpWL6WMCuz1/K86ZqYEX9sdtJU1fJ+yrembj3z0lNp661UXQcbB
         CUshoArVx2f47gKsh65TiKU/5M4Rj+QeuIUOi+WiUA70I7jF3MVFvW3InaHpPIx/CcUV
         Rg7Ef41aFQtakBxVC5u915lyvRK+t1BsIY1xrx2ImOTRfjIU6A5K4SmPHGmNr45Fv3iZ
         vb9mFxGLI8BhB4CYPOoVnexRxISb0xkwdzj5psHupBvtdsLvi90IdKEMUBkdpDmpWbmv
         OOsdf48UizHHjDZOU7IoQrzznxiX3ycRzDDGNxIIlwyTl59vcm1VumRfmbBbcUmfZ8cM
         i+3w==
X-Gm-Message-State: AOJu0Yy7OTXdqySBUMEaLAxtrVqswg2GyhpGlh89SmCuTeMXR5N0M+sT
        OkPoYbk/Cx/ex+Q0nZ1EoFlRvg==
X-Google-Smtp-Source: AGHT+IFDM9mm4RExiIDQOdgnZFNqOULSOor4UvfTWPqFV+FOp96KsWwjv9wciLPT3qCL81igyWfz8g==
X-Received: by 2002:adf:eed2:0:b0:31f:fedd:83ad with SMTP id a18-20020adfeed2000000b0031ffedd83admr11897768wrp.4.1696339340083;
        Tue, 03 Oct 2023 06:22:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e31a:fe1c:e925:9858? ([2a01:e0a:982:cbb0:e31a:fe1c:e925:9858])
        by smtp.gmail.com with ESMTPSA id f8-20020adfdb48000000b0031ff89af0e4sm1568213wrj.99.2023.10.03.06.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 06:22:19 -0700 (PDT)
Message-ID: <bd3bc4bc-b684-4bbd-82cf-c59797ba21cf@linaro.org>
Date:   Tue, 3 Oct 2023 15:22:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Associate DSI device lifetime
 with auxiliary device
Content-Language: en-US, fr
To:     Stephen Boyd <swboyd@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Maxime Ripard <maxime@cerno.tech>
References: <20231002235407.769399-1-swboyd@chromium.org>
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
In-Reply-To: <20231002235407.769399-1-swboyd@chromium.org>
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

On 03/10/2023 01:54, Stephen Boyd wrote:
> The kernel produces a warning splat and the DSI device fails to register
> in this driver if the i2c driver probes, populates child auxiliary
> devices, and then somewhere in ti_sn_bridge_probe() a function call
> returns -EPROBE_DEFER. When the auxiliary driver probe defers, the dsi
> device created by devm_mipi_dsi_device_register_full() is left
> registered because the devm managed device used to manage the lifetime
> of the DSI device is the parent i2c device, not the auxiliary device
> that is being probed.
> 
> Associate the DSI device created and managed by this driver to the
> lifetime of the auxiliary device, not the i2c device, so that the DSI
> device is removed when the auxiliary driver unbinds. Similarly change
> the device pointer used for dev_err_probe() so the deferred probe errors
> are associated with the auxiliary device instead of the parent i2c
> device so we can narrow down future problems faster.
> 
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Maxime Ripard <maxime@cerno.tech>
> Fixes: c3b75d4734cb ("drm/bridge: sn65dsi86: Register and attach our DSI device at probe")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/gpu/drm/bridge/ti-sn65dsi86.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index f448b903e190..84148a79414b 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -692,7 +692,7 @@ static struct ti_sn65dsi86 *bridge_to_ti_sn65dsi86(struct drm_bridge *bridge)
>   	return container_of(bridge, struct ti_sn65dsi86, bridge);
>   }
>   
> -static int ti_sn_attach_host(struct ti_sn65dsi86 *pdata)
> +static int ti_sn_attach_host(struct auxiliary_device *adev, struct ti_sn65dsi86 *pdata)
>   {
>   	int val;
>   	struct mipi_dsi_host *host;
> @@ -707,7 +707,7 @@ static int ti_sn_attach_host(struct ti_sn65dsi86 *pdata)
>   	if (!host)
>   		return -EPROBE_DEFER;
>   
> -	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
> +	dsi = devm_mipi_dsi_device_register_full(&adev->dev, host, &info);
>   	if (IS_ERR(dsi))
>   		return PTR_ERR(dsi);
>   
> @@ -725,7 +725,7 @@ static int ti_sn_attach_host(struct ti_sn65dsi86 *pdata)
>   
>   	pdata->dsi = dsi;
>   
> -	return devm_mipi_dsi_attach(dev, dsi);
> +	return devm_mipi_dsi_attach(&adev->dev, dsi);
>   }
>   
>   static int ti_sn_bridge_attach(struct drm_bridge *bridge,
> @@ -1298,9 +1298,9 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
>   	struct device_node *np = pdata->dev->of_node;
>   	int ret;
>   
> -	pdata->next_bridge = devm_drm_of_get_bridge(pdata->dev, np, 1, 0);
> +	pdata->next_bridge = devm_drm_of_get_bridge(&adev->dev, np, 1, 0);
>   	if (IS_ERR(pdata->next_bridge))
> -		return dev_err_probe(pdata->dev, PTR_ERR(pdata->next_bridge),
> +		return dev_err_probe(&adev->dev, PTR_ERR(pdata->next_bridge),
>   				     "failed to create panel bridge\n");
>   
>   	ti_sn_bridge_parse_lanes(pdata, np);
> @@ -1319,9 +1319,9 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
>   
>   	drm_bridge_add(&pdata->bridge);
>   
> -	ret = ti_sn_attach_host(pdata);
> +	ret = ti_sn_attach_host(adev, pdata);
>   	if (ret) {
> -		dev_err_probe(pdata->dev, ret, "failed to attach dsi host\n");
> +		dev_err_probe(&adev->dev, ret, "failed to attach dsi host\n");
>   		goto err_remove_bridge;
>   	}
>   
> 
> base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d

This looks reasonable

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
