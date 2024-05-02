Return-Path: <linux-kernel+bounces-166051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FC68B9545
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9331C20A16
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78D6224F2;
	Thu,  2 May 2024 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XHeT52VF"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B10D21A04
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 07:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714634854; cv=none; b=hZVzQWzlg8dbTvIIPoI7dKV3ovfMF2Go35EWtMt2caDVHOgs8yn9hYHqQSrTctbWcZl5Yr4rlW7rcG2rAGXDatJ1D0X9+eV9rOnrlQH7Bduj8xOAB1tO806MWb9iDslZRTLjqXgyBgBu49W4IAHevPAfNvgiTRA9zrA3C7DZsO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714634854; c=relaxed/simple;
	bh=ewsvuxdN32VzItCqL6J5mPdL39iZxXn3c1UwFFQBfDM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=vA18c9oaKubK3+kKCv4JKaBAgmSeGL4urumzKkggQDMakjZoL+bA4OTXmGR3dwD6fU8iPQC1otW3T2zSBzHcNVD8a3y+Q7dYLkb1inuVOXoESSWRhOhJvL3i8PaiWBNGC3Qmkf5hAZtfUZ0200XslRMeac9rdtgS4f34l6FByUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XHeT52VF; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34d0aa589a4so2632833f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 00:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714634851; x=1715239651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5k8DvRGdvhEX/z9Xhr6psWRJjlN+z3tQCAAExl9kNg=;
        b=XHeT52VFQyTATSkC6YtoQ3yCQUV6u85ZssVLlZdmm8BQwM3q3AZDNh/qADeRCZE92z
         0utq/a/MFtG+BocuxH8ecfFFpOATBtq5wP/xGPTlWyIRvKPNEMUiebl+HiBGBP/1QhyR
         /7z1pk1rHN+jQrQ32rerJUsruYI/tAE8vqFP8Q3n/rRZgxSSzQmXr/e51X7te+6XcXUV
         7tWte/vy7NurKT8WfRsgW/+Q4opKaes6PUfyEHJ2l0KHbeZjqOc5dt9Ry1Ga1sgS7wCm
         13W6WssB7vq6zBasMz16CZZj/F10fgbsUurXN5T1vZgI+6ATyLEv1RTdMedLFtBXIpZL
         k5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714634851; x=1715239651;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G5k8DvRGdvhEX/z9Xhr6psWRJjlN+z3tQCAAExl9kNg=;
        b=u2TUE5O4No2p/+gVuAFhSYOJmN/JFF77QVqVoe+HLxtnpWlPCg7783rjxC5bA54JHY
         bPrQ9iIFLJQlE7fZ//TR3+vJB1Tq4P+MIT8laplLGaHwp2Pe1K8TxXpddu5yhb2phfFW
         vU7WBnEus4mH4VpBDeRyn1dVSmZFi6Uq3PUlnyqJv39EW2FPSMfESKfpZXx7TfFxGCKi
         lDO2Xk9OklvXnMSa/2MlCRJbhnYniD3lcSUFBVLjX2QdukNJeG7ViXvchXUkLFJ/GlW5
         xnUJHa7modjJP/KQMENuKdAsbU8wjhOz05J02RsUdKf0kSrcxjMGK/XviYaexHVFtTOM
         Q+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZEwJzf8JMq/rUbowcKkyIyXjp5DA4NgkPxPpU8ooxvxsRja08yeSdHL9Q5G4BLpSzCL8JTYVQeVyksul/wciCzar6hC4qsMHCxrg4
X-Gm-Message-State: AOJu0YxSICtVhP9menvufcgqrkr0VUA8V/28etfwGK0IH6JppAo2NzDa
	/KAmC+7eZn7oU5M2WgrXNV8nV3V9ABpnHK8Xyqk77jEmWQdCuOU94AtDY47s3bg=
X-Google-Smtp-Source: AGHT+IGZrZk7jaoMjvXiFC3UYLQHz0/e2fTYO9VQm5c70FoNXeWhEkIJb7cyw4px5GhwxWGv7z/G1Q==
X-Received: by 2002:a05:6000:a86:b0:34c:f507:84b6 with SMTP id dh6-20020a0560000a8600b0034cf50784b6mr1047368wrb.41.1714634850581;
        Thu, 02 May 2024 00:27:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:67e2:5e2:652b:4129? ([2a01:e0a:cad:2140:67e2:5e2:652b:4129])
        by smtp.gmail.com with ESMTPSA id h4-20020adff4c4000000b0034cee43238fsm533563wrp.27.2024.05.02.00.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 00:27:30 -0700 (PDT)
Message-ID: <9598098a-183f-448b-91ff-b60decc8218e@linaro.org>
Date: Thu, 2 May 2024 09:27:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 3/9] drm/mipi-dsi: mipi_dsi_*_write functions don't
 need to ratelimit prints
To: Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Hsin-Yi Wang <hsinyi@google.com>, Brian Norris <briannorris@chromium.org>,
 Sam Ravnborg <sam@ravnborg.org>,
 Javier Martinez Canillas <javierm@redhat.com>, Joel Selvaraj
 <jo@jsfamily.in>, lvzhaoxiong@huaqin.corp-partner.google.com,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-kernel@vger.kernel.org
References: <20240501154251.3302887-1-dianders@chromium.org>
 <20240501084109.v3.3.I9982cd5d8014de7a4513f5619f66f88da49ce4ec@changeid>
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
Organization: Linaro
In-Reply-To: <20240501084109.v3.3.I9982cd5d8014de7a4513f5619f66f88da49ce4ec@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/05/2024 17:41, Douglas Anderson wrote:
> We really don't expect these errors to be printed over and over
> again. When a driver hits the error it should bail out. Just use a
> normal error print.
> 
> This gives a nice space savings for users of these functions:
> 
> $ scripts/bloat-o-meter \
>    .../before/panel-novatek-nt36672e.ko \
>    .../after/panel-novatek-nt36672e.ko
> add/remove: 0/1 grow/shrink: 0/1 up/down: 0/-16760 (-16760)
> Function                                     old     new   delta
> nt36672e_1080x2408_60hz_init               17080   10640   -6440
> nt36672e_1080x2408_60hz_init._rs           10320       -  -10320
> Total: Before=31815, After=15055, chg -52.68%
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v3:
> - ("mipi_dsi_*_write functions don't need to ratelimit...") moved earlier.
> 
> Changes in v2:
> - New
> 
>   include/drm/drm_mipi_dsi.h | 24 +++++++++++-------------
>   1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index e0f56564bf97..67967be48dbd 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -314,17 +314,16 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
>    * @dsi: DSI peripheral device
>    * @seq: buffer containing the payload
>    */
> -#define mipi_dsi_generic_write_seq(dsi, seq...)                                 \
> -	do {                                                                    \
> -		static const u8 d[] = { seq };                                  \
> -		struct device *dev = &dsi->dev;                                 \
> -		ssize_t ret;                                                    \
> -		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));            \
> -		if (ret < 0) {                                                  \
> -			dev_err_ratelimited(dev, "transmit data failed: %zd\n", \
> -					    ret);                               \
> -			return ret;                                             \
> -		}                                                               \
> +#define mipi_dsi_generic_write_seq(dsi, seq...)                           \
> +	do {                                                              \
> +		static const u8 d[] = { seq };                            \
> +		struct device *dev = &dsi->dev;                           \
> +		ssize_t ret;                                              \
> +		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));      \
> +		if (ret < 0) {                                            \
> +			dev_err(dev, "transmit data failed: %zd\n", ret); \
> +			return ret;                                       \
> +		}                                                         \
>   	} while (0)
>   
>   /**
> @@ -340,8 +339,7 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
>   		ssize_t ret;                                                \
>   		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));     \
>   		if (ret < 0) {                                              \
> -			dev_err_ratelimited(                                \
> -				dev, "sending command %#02x failed: %zd\n", \
> +			dev_err(dev, "sending command %#02x failed: %zd\n", \
>   				cmd, ret);                                  \
>   			return ret;                                         \
>   		}                                                           \

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

