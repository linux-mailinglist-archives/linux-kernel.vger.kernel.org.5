Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A73804C04
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjLEINa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjLEIN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:13:27 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A7F19B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:13:32 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b595bf5d2so57110855e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 00:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701764011; x=1702368811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWja+/NJZfgKI5wDXKrgIcWo2x8Q6ApX0pGmb/ZtNHI=;
        b=Sg1XvEzIWptzf7zecZRBvsRbm+j8ZNjBlWukLj18pjvG+aypbP2k1rfhcImu6OICuD
         FegNYGY3819rWkoL43PmZtVeSRflUug+QX2/omgL8AWM773NsX834AiPQwq7f5zucIhB
         WI84ZID3Qd0jfjyiPQrCtGcwhvh6y9fSJLGFg/MCbmTCpApJXYzJ8sYGCLK4VRqzSfr4
         V0Y6KZT3ds/TH6SLeJ4qxM9GWhCV8elU01uF0PdUWTPQ2bO1Xa4allZ4KAl4Onc9Xxls
         Y5eE0Bht05NJUKPs1AE5S0CpmzCCM3jh2KLHi2dBQx9Wz6zMNis6ncCWaDt28A6Hf8yd
         lFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701764011; x=1702368811;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XWja+/NJZfgKI5wDXKrgIcWo2x8Q6ApX0pGmb/ZtNHI=;
        b=C3U+zrLnRLc5JCjKqSrCJ3f7URDdBx/J2LnHLUdoFSKDw5rjE6zkjXst1JycrDrDt9
         D2IrMn/PPTZ0J9DkWjXYmbMvDuuYVo6ee40eC8j37aEB0fJAUujoO4XMMnLdIvyRhU9F
         wRxTMMkRNFJ3gvEVzSRtbhpLDldOVGMTggbgQqYHr/fUrpzgkAEKq8+iAmT4CB5dJ5aJ
         9di8uqJAxKCloF763TJ6RGjj0niWBoexNwzU4arinldGWighpsyQEpbQt/ayveneP443
         nuY4YBVzBBSyNwMpTa2x6KR4fwj9heAJXG31DjAsCrDuowpalMgn/048CQf14GpyPo6p
         6NMA==
X-Gm-Message-State: AOJu0Yzhw41IYaoD+r/VsPDjATtwBMkgV31eCdLhU8mMrfpTVrjchMoL
        cqyuj1LI00r96JBalZHEkW51rw==
X-Google-Smtp-Source: AGHT+IHywBwwMICzmpSikqbB/Gw1BnE1K6zCV6jpsXcXKgRPnuPD0n/hV+xrys8lX74iOpylMILcKw==
X-Received: by 2002:a05:600c:4445:b0:40c:9df:3e30 with SMTP id v5-20020a05600c444500b0040c09df3e30mr144326wmn.103.1701764011132;
        Tue, 05 Dec 2023 00:13:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:4518:5e57:ff13:b4bb? ([2a01:e0a:982:cbb0:4518:5e57:ff13:b4bb])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c470900b004063cd8105csm21461190wmo.22.2023.12.05.00.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 00:13:30 -0800 (PST)
Message-ID: <b1fe97f3-4236-4efe-b156-762d5668eda4@linaro.org>
Date:   Tue, 5 Dec 2023 09:13:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/3] drm/panel: ilitek-ili9881c: make use of
 prepare_prev_first
Content-Language: en-US, fr
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        kernel@pengutronix.de
References: <20231123-drm-panel-ili9881c-am8001280g-v1-0-fdf4d624c211@pengutronix.de>
 <20231123-drm-panel-ili9881c-am8001280g-v1-1-fdf4d624c211@pengutronix.de>
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
In-Reply-To: <20231123-drm-panel-ili9881c-am8001280g-v1-1-fdf4d624c211@pengutronix.de>
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

On 23/11/2023 18:08, Philipp Zabel wrote:
> From: Marco Felsch <m.felsch@pengutronix.de>
> 
> The panel.prepare() call requires an initialized MIPI-DSI host, so set
> the prepare_prev_first flag to indicate that the host must be
> initialized first.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>   drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> index 7838947a1bf3..0c911ed9141b 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> @@ -1094,6 +1094,8 @@ static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
>   		return ret;
>   	}
>   
> +	ctx->panel.prepare_prev_first = true;
> +
>   	ret = drm_panel_of_backlight(&ctx->panel);
>   	if (ret)
>   		return ret;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
