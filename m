Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CD67BD5EC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345567AbjJII5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345404AbjJII5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:57:10 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F8E97
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 01:57:06 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40572aeb673so41195465e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 01:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696841824; x=1697446624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=20IhD3DbtExVKpTNHHdJ+qviTzAO61ihrX5GQAYq0yM=;
        b=vbztzF+mZPsdbReI+yVn38qvOrh8Fr+3q8A7I8TDalUXu2k0MSe6l7PRX3mRgxSmit
         eZjRo+Z9Z9u6s3odcQYAsZvIsZ0qwT4em/qZioXTTySuS5A0WJrB7d6kz/S0ZvyYZbn6
         2Jilmjs3UDCoMhgTY5eIDvKrcsf4HoINJmcH/L6ker05GajwvqDo426yk3w7ZPAanWeM
         98HYgwd1oswyGiScokvqW86y3Jtigj2NIiY0RM/2dgRyCTFUu1TXUubmx/5QFR53C5NS
         XweFAo1IWlrOt8khkSPPQj7G7ToeMSWudheJvTqZ16/Fj3cPx3se1RF5g5D3I2m83RtW
         b/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696841824; x=1697446624;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=20IhD3DbtExVKpTNHHdJ+qviTzAO61ihrX5GQAYq0yM=;
        b=ahf7VKhtLaOQ0eencssRioYCc/kisCeozuUagsK5eudUnwmZvGrZDAnGjCGru+++9a
         bKp+6IDNKk+c6WoaQ1G9TCbBp8axmn5K25N1aMOHoqH1kYq/E2QuatS+ft8CSH+pERMG
         DWefCm3eEChFXx9biE5mK8b2vr8hlBAx+XDyQNPpYIbt/732j7KbOMru/1Ww13TAurbI
         YlA7ypn+/zCfZLkN4aaxkQ70/p82+1b4TeHQmxjxn8U5vf/5LvL2ogoAD9Jz8oivbKMV
         bNhzPGFqvn/ZIanEDjj08hfg9KEGYN98BLAXLi9rG0dLzWub1xSCUXB32EHotIhBpa+f
         z90A==
X-Gm-Message-State: AOJu0YzWeqCzrN5WEPKKkF8/IxdNqAA6PGJfZc6eOrYvP/CnOkFSOxAY
        KurO176vRrZJNnUn/jWr3KLIPg==
X-Google-Smtp-Source: AGHT+IH0i8kEX6PYBwVQWP8U0pI3LmQpNgbpRNwQakkyxjARRuS0lm0+DLxX320ZnHrU2/fAtmCgAQ==
X-Received: by 2002:a05:6000:10c2:b0:321:68af:947 with SMTP id b2-20020a05600010c200b0032168af0947mr11828477wrx.8.1696841824507;
        Mon, 09 Oct 2023 01:57:04 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id f15-20020a5d50cf000000b00323330edbc7sm8974100wrt.20.2023.10.09.01.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 01:57:04 -0700 (PDT)
Message-ID: <d38226b2-9e93-4469-afa5-d1b76c9b9537@linaro.org>
Date:   Mon, 9 Oct 2023 10:57:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] drm/panel: boe-tv101wum-nl6: Completely pull GPW to
 VGL before TP term
Content-Language: en-US, fr
To:     Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>,
        quic_jesszhan@quicinc.com, sam@ravnborg.org,
        yangcong5@huaqin.corp-partner.google.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20231007064949.22668-1-zhouruihai@huaqin.corp-partner.google.com>
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
In-Reply-To: <20231007064949.22668-1-zhouruihai@huaqin.corp-partner.google.com>
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

On 07/10/2023 08:49, Ruihai Zhou wrote:
> The sta_himax83102 panel sometimes shows abnormally flickering
> horizontal lines. The front gate output will precharge the X point of
> the next pole circuit before TP(TouchPanel Enable) term starts, and wait
> until the end of the TP term to resume the CLK. For this reason, the X
> point must be maintained during the TP term. In abnormal case, we
> measured a slight leakage at point X. This because during the TP term,
> the GPW does not fully pull the VGL low, causing the TFT to not be
> closed tightly.
> 
> To fix this, we completely pull GPW to VGL before entering the TP term.
> This will ensure that the TFT is closed tightly and prevent the abnormal
> display.
> 
> Fixes: 1bc2ef065f13 ("drm/panel: Support for Starry-himax83102-j02 TDDI MIPI-DSI panel")
> Signed-off-by: Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
> ---
> Changes since v1:
> 
> - Rebased on top of drm-misc-next
> - Add Fixes tag from Jessica's comment
> 
> v1: https://patchwork.kernel.org/project/dri-devel/patch/20230912105932.16618-1-zhouruihai@huaqin.corp-partner.google.com/
> ---
>   drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> index 5ac926281d2c..c9087f474cbc 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -1342,9 +1342,7 @@ static const struct panel_init_cmd starry_himax83102_j02_init_cmd[] = {
>   	_INIT_DCS_CMD(0xB1, 0x01, 0xBF, 0x11),
>   	_INIT_DCS_CMD(0xCB, 0x86),
>   	_INIT_DCS_CMD(0xD2, 0x3C, 0xFA),
> -	_INIT_DCS_CMD(0xE9, 0xC5),
> -	_INIT_DCS_CMD(0xD3, 0x00, 0x00, 0x00, 0x00, 0x80, 0x0C, 0x01),
> -	_INIT_DCS_CMD(0xE9, 0x3F),
> +	_INIT_DCS_CMD(0xD3, 0x00, 0x00, 0x44, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x0C, 0x01),
>   	_INIT_DCS_CMD(0xE7, 0x02, 0x00, 0x28, 0x01, 0x7E, 0x0F, 0x7E, 0x10, 0xA0, 0x00, 0x00, 0x20, 0x40, 0x50, 0x40),
>   	_INIT_DCS_CMD(0xBD, 0x02),
>   	_INIT_DCS_CMD(0xD8, 0xFF, 0xFF, 0xBF, 0xFE, 0xAA, 0xA0, 0xFF, 0xFF, 0xBF, 0xFE, 0xAA, 0xA0),

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
