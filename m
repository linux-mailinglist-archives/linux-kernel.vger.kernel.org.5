Return-Path: <linux-kernel+bounces-158156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D818B1C48
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142631F21741
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B826E60F;
	Thu, 25 Apr 2024 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R3dQ5zUq"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EB567A1A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714031717; cv=none; b=M4TYMxEup5cqSpZlg9WhS29tQ1sQ365sBFC+OWjSZagb7pz6XE5ZCpxEUPhnoBwnLaZz6aP+Y8S60npHsmt12gP4wuIB/woW43CN4kUU3++2K8mVC/dXwaXUQvIfbFs9p0XkFOMsNzNiU6CZdY0gVmbhIDfQqLh4SPjz7X1AZuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714031717; c=relaxed/simple;
	bh=A5IdGeqi1A6VzWrwgnARoAoAqhTJ8uQcuGn9obAb0tA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=E/WNFhf1QaYvWiB00faneqUq3x+kcLkwZbi5FrFKG+OwMs01KLimFL76/J68NBVmUTQ+lLQksgh3iCaQTAdR8Zdtroos7nybmdj+n9VIY6vxk3lk32Stak28aFmDKwgC0qPt1Ldd23LyJXYniy+6Uo/SIixaU5DtsyXEYPf9m4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R3dQ5zUq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41b5aed246dso804675e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714031714; x=1714636514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gzHFo+ZVHj886+TN1PTtTcZZeGCWMQE2qidNssQocQ=;
        b=R3dQ5zUqBzdF18/kcG2bJ0HoY68DWqy/A8ujt3F1LChPE8XvHexnCNOzff/MAw2+qL
         VpdmeUzALF1eB6s/salpN+E0LYuD+HmxUFARb9O5qrBLoOU4Qq5cigXtn9Yb4CZ/NQ2T
         dkdtddbxLy67/nLWkDdIg9ykZqpFh+AWh/iKPw3k1yModta6jOwdV0qDyuqUeKUaV13Z
         WOc+EZCyW5kQsMCAH7E9kz/PPPNSNYGo4agRpPrD0qMmPyAPeIk/IeKvsbZOC5tpJS9n
         kEvjHV69JtQ5ZTm6zcmbo1L3oOQ4RZMmlNQhCcEQ+vjnRSTYq4DqEVp48QQYLpkV2HVh
         EvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714031714; x=1714636514;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9gzHFo+ZVHj886+TN1PTtTcZZeGCWMQE2qidNssQocQ=;
        b=Ovxw/XElszk+oKUV5hcik1oX5zm5pfnj2HkoAhUtJDYwUjWEF1rSNfzD6vGh3Omoae
         9U763XasX8hf9PNd3NGZHyhk6Cvhbx7r0dcCdEV34cJJ6960qvHt2y2OewuN5Pt8KqEf
         mWEEu4VZ7Cfdok9UpOzs1Xr5T4HsesjV7p41Oa3/5Y1CAmgF4aSOQhJ1fY1LnC7con31
         8MdHF7JFAa2v6TgUb4bPQ5DcSwGbCp432SaXnGYJ5rnGzNqqyZdYephHpu3ndqPYsLa1
         Waf7zw89xb8Be/r1bt22uSFiWX9snaPcF9FM4jjToE629g3AALE+NH3ZOfNO80Uagi0z
         8JUA==
X-Forwarded-Encrypted: i=1; AJvYcCWeCX1R7pfMOoFH5J2bO0bEYEHTwq/gpoalAdzQ1zMQr7GWZUbXqOldXmkXIY/fllxnc9XPldH4Zr6xBjmA5Kk9KhfLNngmg2HsvZZB
X-Gm-Message-State: AOJu0YyyvJzKEMCFPk6PMir1fzlWzJY8hN03CYoJ9PoTq+AA1kx+01gl
	bO7nWFzSDiPTbsYP7plKb7IkivI5sgQGeJL4ofJ8HKUrXlLWquN7hbQw9s83qUc=
X-Google-Smtp-Source: AGHT+IEPCBod4hEdYtHuPJ8xARgVziqMxN6jilsih9qLqB38Gkx/8Q+QCKG8slRe0IQKFjxMrWFgug==
X-Received: by 2002:a05:600c:19ce:b0:417:fbc2:caf8 with SMTP id u14-20020a05600c19ce00b00417fbc2caf8mr3644192wmq.23.1714031713281;
        Thu, 25 Apr 2024 00:55:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:15c7:bd9c:c500:ed62? ([2a01:e0a:982:cbb0:15c7:bd9c:c500:ed62])
        by smtp.gmail.com with ESMTPSA id j13-20020a05600c190d00b00418a386c17bsm30281607wmq.12.2024.04.25.00.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 00:55:12 -0700 (PDT)
Message-ID: <300eab2e-f884-4978-9f19-b764bb5fb47a@linaro.org>
Date: Thu, 25 Apr 2024 09:55:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/mipi-dsi: Reduce driver bloat of
 mipi_dsi_*_write_seq()
To: Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linus.walleij@linaro.org,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 lvzhaoxiong@huaqin.corp-partner.google.com, Hsin-Yi Wang
 <hsinyi@google.com>, Sam Ravnborg <sam@ravnborg.org>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-kernel@vger.kernel.org
References: <20240424172017.1.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid>
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
In-Reply-To: <20240424172017.1.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/04/2024 02:20, Douglas Anderson wrote:
> The consensus of many DRM folks is that we want to move away from DSI
> drivers defining tables of init commands. Instead, we want to move to
> init functions that can use common DRM functions. The issue thus far
> has been that using the macros mipi_dsi_generic_write_seq() and
> mipi_dsi_dcs_write_seq() bloats the driver using them.
> 
> Through a cooperative effort between Hsin-Yi Wang and Dmitry
> Baryshkov, we have realized that the majority of the bloat is the fact
> that we have the dev_err_ratelimited() directly in the macros. Let's
> hoist this call into drm_mipi_dsi.c by adding a "chatty" version of
> the functions that includes the print.
> 
> Without any changes to clients this gives a dramatic savings. Building
> with my build system shows one example:
> 
> $ scripts/bloat-o-meter \
>    .../before/panel-novatek-nt36672e.ko \
>    .../after/panel-novatek-nt36672e.ko
> 
> add/remove: 0/1 grow/shrink: 1/1 up/down: 6/-19652 (-19646)
> Function                                     old     new   delta
> __UNIQUE_ID_vermagic520                       64      70      +6
> nt36672e_1080x2408_60hz_init               16592    7260   -9332
> nt36672e_1080x2408_60hz_init._rs           10320       -  -10320
> Total: Before=31503, After=11857, chg -62.36%
> 
> Note that given the change in location of the print it's harder to
> include the "cmd" in the printout for mipi_dsi_dcs_write_seq() since,
> theoretically, someone could call the new chatty function with a
> zero-size array and it would be illegal to dereference data[0].
> There's a printk format to print the whole buffer and this is probably
> more useful for debugging anyway. Given that we're doing this for
> mipi_dsi_dcs_write_seq(), let's also print the buffer for
> mipi_dsi_generic_write_seq() in the error case.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> The MIPI device I have in front of me (wormdingler) hasn't been
> converted to use these functions yet, so this is just compile
> tested. It's about my end of day so I'm sending this out since it's
> pretty straightforward. Hopefully others can confirm it works well for
> them and also saves space under their compilers.
> 
>   drivers/gpu/drm/drm_mipi_dsi.c | 54 ++++++++++++++++++++++++++++++++++
>   include/drm/drm_mipi_dsi.h     | 31 ++++++++-----------
>   2 files changed, 67 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> index 795001bb7ff1..5ded6aef38ed 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -764,6 +764,33 @@ ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
>   }
>   EXPORT_SYMBOL(mipi_dsi_generic_write);
>   
> +/**
> + * mipi_dsi_generic_write_chatty() - mipi_dsi_generic_write() w/ an error log
> + * @dsi: DSI peripheral device
> + * @payload: buffer containing the payload
> + * @size: size of payload buffer
> + *
> + * Just like mipi_dsi_generic_write() but includes a dev_err_ratelimited()
> + * call for you.
> + *
> + * Return: The number of bytes transmitted on success or a negative error code
> + * on failure.
> + */
> +ssize_t mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
> +				      const void *payload, size_t size)
> +{
> +	struct device *dev = &dsi->dev;
> +	int ret;
> +
> +	ret = mipi_dsi_generic_write(dsi, payload, size);
> +	if (ret < 0)
> +		dev_err_ratelimited(dev, "sending generic data %*ph failed: %d\n",
> +				    (int)size, payload, ret);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(mipi_dsi_generic_write_chatty);
> +
>   /**
>    * mipi_dsi_generic_read() - receive data using a generic read packet
>    * @dsi: DSI peripheral device
> @@ -852,6 +879,33 @@ ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
>   }
>   EXPORT_SYMBOL(mipi_dsi_dcs_write_buffer);
>   
> +/**
> + * mipi_dsi_dcs_write_buffer_chatty - mipi_dsi_dcs_write_buffer() w/ an error log
> + * @dsi: DSI peripheral device
> + * @data: buffer containing data to be transmitted
> + * @len: size of transmission buffer
> + *
> + * Just like mipi_dsi_dcs_write_buffer() but includes a dev_err_ratelimited()
> + * call for you.
> + *
> + * Return: The number of bytes successfully transmitted or a negative error
> + * code on failure.
> + */
> +ssize_t mipi_dsi_dcs_write_buffer_chatty(struct mipi_dsi_device *dsi,
> +					 const void *data, size_t len)
> +{
> +	struct device *dev = &dsi->dev;
> +	int ret;
> +
> +	ret = mipi_dsi_dcs_write_buffer(dsi, data, len);
> +	if (ret < 0)
> +		dev_err_ratelimited(dev, "sending dcs data %*ph failed: %d\n",
> +				    (int)len, data, ret);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(mipi_dsi_dcs_write_buffer_chatty);
> +
>   /**
>    * mipi_dsi_dcs_write() - send DCS write command
>    * @dsi: DSI peripheral device
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index 82b1cc434ea3..784e425dc4c8 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -256,6 +256,8 @@ int mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
>   
>   ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
>   			       size_t size);
> +ssize_t mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
> +				      const void *payload, size_t size);
>   ssize_t mipi_dsi_generic_read(struct mipi_dsi_device *dsi, const void *params,
>   			      size_t num_params, void *data, size_t size);
>   
> @@ -279,6 +281,8 @@ enum mipi_dsi_dcs_tear_mode {
>   
>   ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
>   				  const void *data, size_t len);
> +ssize_t mipi_dsi_dcs_write_buffer_chatty(struct mipi_dsi_device *dsi,
> +					 const void *data, size_t len);
>   ssize_t mipi_dsi_dcs_write(struct mipi_dsi_device *dsi, u8 cmd,
>   			   const void *data, size_t len);
>   ssize_t mipi_dsi_dcs_read(struct mipi_dsi_device *dsi, u8 cmd, void *data,
> @@ -317,14 +321,10 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
>   #define mipi_dsi_generic_write_seq(dsi, seq...)                                \
>   	do {                                                                   \
>   		static const u8 d[] = { seq };                                 \
> -		struct device *dev = &dsi->dev;                                \
>   		int ret;                                                       \
> -		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));           \
> -		if (ret < 0) {                                                 \
> -			dev_err_ratelimited(dev, "transmit data failed: %d\n", \
> -					    ret);                              \
> +		ret = mipi_dsi_generic_write_chatty(dsi, d, ARRAY_SIZE(d));    \
> +		if (ret < 0)                                                   \
>   			return ret;                                            \
> -		}                                                              \
>   	} while (0)
>   
>   /**
> @@ -333,18 +333,13 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
>    * @cmd: Command
>    * @seq: buffer containing data to be transmitted
>    */
> -#define mipi_dsi_dcs_write_seq(dsi, cmd, seq...)                           \
> -	do {                                                               \
> -		static const u8 d[] = { cmd, seq };                        \
> -		struct device *dev = &dsi->dev;                            \
> -		int ret;                                                   \
> -		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));    \
> -		if (ret < 0) {                                             \
> -			dev_err_ratelimited(                               \
> -				dev, "sending command %#02x failed: %d\n", \
> -				cmd, ret);                                 \
> -			return ret;                                        \
> -		}                                                          \
> +#define mipi_dsi_dcs_write_seq(dsi, cmd, seq...)                               \
> +	do {                                                                   \
> +		static const u8 d[] = { cmd, seq };                            \
> +		int ret;                                                       \
> +		ret = mipi_dsi_dcs_write_buffer_chatty(dsi, d, ARRAY_SIZE(d)); \
> +		if (ret < 0)                                                   \
> +			return ret;                                            \
>   	} while (0)
>   
>   /**

At first sight it looks o for me, it's less efficient since it adds a function call
for each sequence, but the saving if very significant.

I'll run a test on the vtdr6130 to be sure.

Neil

