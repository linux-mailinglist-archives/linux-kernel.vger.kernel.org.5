Return-Path: <linux-kernel+bounces-166052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D74E8B9547
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12CB91F21DC3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB41224DD;
	Thu,  2 May 2024 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A6yBNzv7"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E69D219E0
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 07:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714634871; cv=none; b=daFanGzi1TS7L9+zOJDKkD2OMbsgVN9R3KNiB0dAq1pxJxRoIusK0xMXJm23SNF39/WTjHiKsBsRqlBOIh5us14AfLvQfUqT87f+ZG5pEYqv2sZNViQPBPAumaKr2LxgHP/0r756eAzyS4Pg9sVRKdz8Qs8bkvOPlekfCTV2XJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714634871; c=relaxed/simple;
	bh=0ZVilrUYz2leH6Knv/K89DRoEbqcodXGKC9fS3yFlXY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZaN9ZDBM/1DU/1sYfVcCH9u/YSLj2sdjB8WBbZ8W+SS0I/xFk1DitpPQJV7uRHiwYmI7dytGK21IIVxkRpYstdwzuL93kjdsn3LuowTImbN0kYoElfc40ZQ+kdN+uUimIJ8NqyEJyl+sY5VCMIOpNTJpNm47mVX4QI28pc+EGL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A6yBNzv7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41bab13ca80so42173305e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 00:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714634868; x=1715239668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXT/J90gBM/ZkziXEFYH32qGJNPytAF2UXjIplhY28I=;
        b=A6yBNzv7g8lTLBL2uPNnyHlhNoKnCLaYAviNNPBJj/a04DUawk3arH1pJxusUuJNtY
         QAeotyjD8bOJL6CzwHhJj3LpEwYdafH2nhP3eRlgh3sI36oIoHCcFZcXqctxB9bqP9gn
         66FRHhPIIW84iojKCvQf7JFLMZwbgCy+S3xCPOSl03sHFQymiQuzLebGPlvk1SLLOstf
         fRY5ap5HbIETfnFXjX7gn5v+avEb/Rs920CuLH1J5ZE50at2bMc2ufPl9ND1vSOku/Dk
         n/QZPLhpj8NmAU5aYLsi1mry0pW5F8NFIRfgE3JUOgi9XOchAROXuQi4p64efMRkBEek
         wvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714634868; x=1715239668;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qXT/J90gBM/ZkziXEFYH32qGJNPytAF2UXjIplhY28I=;
        b=tTgQe/dKMJZzZc5FxUr/wpXwdOx3HgYqJHY3hCNge5qHFKJSJIrz94LGXoH4qUPJei
         axP95edOCuChyDMZVujbOay3lsYy8zJHlrulLVq+8sCqrCYaDKVRvd6mcvIRqAqaPDD7
         +GoElVEcfItd7u7MvD+v28iQE0J4H8qMnHlVoLR+0Yc8lI3+1w5g3h0y6bydaNkbXclN
         hK+MZcUFD5shnDD3xJLs5GvUc/EoxVMS16AvWZ+Jb0P9Uy2WNIhjL9qKrlPx5MBOgLA8
         S46/8/ftG/oFRJ6JlxsTisOP2z/pNHgd+q3Jrub8/6ShfL+0xPtBL0vb9ZUY7O9GDMYx
         v+dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMdtHpRSSjJ9qNcHIJx66Ne1zQVxKIxcAr95yEYi+E+xvlP4hrqzhmfh3Ewynj1PCOYe1Y6DTp0yItEZByu8WaIGW2NfNZ/Z0NZE6p
X-Gm-Message-State: AOJu0Yw8zS7NB6STilv7Cf6gM5wzjz/XTqA5erE4VZj3wJegRlFwpc/K
	EUzGkvCnSlGnF/wnJ/6lzjnFKHKb/g7yfs2lY8ShPixVOC7EukVbrPGu8CuQIAo=
X-Google-Smtp-Source: AGHT+IETwWizKsrR98dW27XIAemEkEqgp8jjNVgqy0g7K4l8voBGcDlS16AHgUqxUyy+2F+gkxyXNg==
X-Received: by 2002:a05:600c:34c5:b0:418:fb6f:5f59 with SMTP id d5-20020a05600c34c500b00418fb6f5f59mr1031543wmq.2.1714634867521;
        Thu, 02 May 2024 00:27:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:67e2:5e2:652b:4129? ([2a01:e0a:cad:2140:67e2:5e2:652b:4129])
        by smtp.gmail.com with ESMTPSA id b20-20020a05600c4e1400b0041892857924sm931549wmq.36.2024.05.02.00.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 00:27:47 -0700 (PDT)
Message-ID: <f52a8452-4219-4b25-9cf5-2ae6c8747ac8@linaro.org>
Date: Thu, 2 May 2024 09:27:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 4/9] drm/mipi-dsi: Reduce driver bloat of
 mipi_dsi_*_write_seq()
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
 <20240501084109.v3.4.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid>
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
In-Reply-To: <20240501084109.v3.4.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/05/2024 17:41, Douglas Anderson wrote:
> Through a cooperative effort between Hsin-Yi Wang and Dmitry
> Baryshkov, we have realized the dev_err() in the
> mipi_dsi_*_write_seq() macros was causing quite a bit of bloat to the
> kernel. Let's hoist this call into drm_mipi_dsi.c by adding a "chatty"
> version of the functions that includes the print. While doing this,
> add a bit more comments to these macros making it clear that they
> print errors and also that they return out of _the caller's_ function.
> 
> Without any changes to clients this gives a nice savings. Building
> with my build system shows one example:
> 
> $ scripts/bloat-o-meter \
>    .../before/panel-novatek-nt36672e.ko \
>    .../after/panel-novatek-nt36672e.ko
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-4404 (-4404)
> Function                                     old     new   delta
> nt36672e_1080x2408_60hz_init               10640    6236   -4404
> Total: Before=15055, After=10651, chg -29.25%
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
> It should be noted that the current consensus of DRM folks is that the
> mipi_dsi_*_write_seq() should be deprecated due to the non-intuitive
> return behavior. A future patch will formally mark them as deprecated
> and provide an alternative.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v3:
> - Rebased upon patch to remove ratelimit of prints.
> 
> Changes in v2:
> - Add some comments to the macros about printing and returning.
> - Change the way err value is handled in prep for next patch.
> - Modify commit message now that this is part of a series.
> - Rebased upon patches to avoid theoretical int overflow.
> 
>   drivers/gpu/drm/drm_mipi_dsi.c | 56 ++++++++++++++++++++++++++++++++++
>   include/drm/drm_mipi_dsi.h     | 47 +++++++++++++++-------------
>   2 files changed, 82 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> index 795001bb7ff1..8593d9ed5891 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -764,6 +764,34 @@ ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
>   }
>   EXPORT_SYMBOL(mipi_dsi_generic_write);
>   
> +/**
> + * mipi_dsi_generic_write_chatty() - mipi_dsi_generic_write() w/ an error log
> + * @dsi: DSI peripheral device
> + * @payload: buffer containing the payload
> + * @size: size of payload buffer
> + *
> + * Like mipi_dsi_generic_write() but includes a dev_err_ratelimited()
> + * call for you and returns 0 upon success, not the number of bytes sent.
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +int mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
> +				  const void *payload, size_t size)
> +{
> +	struct device *dev = &dsi->dev;
> +	ssize_t ret;
> +
> +	ret = mipi_dsi_generic_write(dsi, payload, size);
> +	if (ret < 0) {
> +		dev_err(dev, "sending generic data %*ph failed: %zd\n",
> +			(int)size, payload, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(mipi_dsi_generic_write_chatty);
> +
>   /**
>    * mipi_dsi_generic_read() - receive data using a generic read packet
>    * @dsi: DSI peripheral device
> @@ -852,6 +880,34 @@ ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
>   }
>   EXPORT_SYMBOL(mipi_dsi_dcs_write_buffer);
>   
> +/**
> + * mipi_dsi_dcs_write_buffer_chatty - mipi_dsi_dcs_write_buffer() w/ an error log
> + * @dsi: DSI peripheral device
> + * @data: buffer containing data to be transmitted
> + * @len: size of transmission buffer
> + *
> + * Like mipi_dsi_dcs_write_buffer() but includes a dev_err_ratelimited()
> + * call for you and returns 0 upon success, not the number of bytes sent.
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +int mipi_dsi_dcs_write_buffer_chatty(struct mipi_dsi_device *dsi,
> +				     const void *data, size_t len)
> +{
> +	struct device *dev = &dsi->dev;
> +	ssize_t ret;
> +
> +	ret = mipi_dsi_dcs_write_buffer(dsi, data, len);
> +	if (ret < 0) {
> +		dev_err(dev, "sending dcs data %*ph failed: %zd\n",
> +			(int)len, data, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(mipi_dsi_dcs_write_buffer_chatty);
> +
>   /**
>    * mipi_dsi_dcs_write() - send DCS write command
>    * @dsi: DSI peripheral device
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index 67967be48dbd..6d68d9927f46 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -256,6 +256,8 @@ int mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
>   
>   ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
>   			       size_t size);
> +int mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
> +				  const void *payload, size_t size);
>   ssize_t mipi_dsi_generic_read(struct mipi_dsi_device *dsi, const void *params,
>   			      size_t num_params, void *data, size_t size);
>   
> @@ -279,6 +281,8 @@ enum mipi_dsi_dcs_tear_mode {
>   
>   ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
>   				  const void *data, size_t len);
> +int mipi_dsi_dcs_write_buffer_chatty(struct mipi_dsi_device *dsi,
> +				     const void *data, size_t len);
>   ssize_t mipi_dsi_dcs_write(struct mipi_dsi_device *dsi, u8 cmd,
>   			   const void *data, size_t len);
>   ssize_t mipi_dsi_dcs_read(struct mipi_dsi_device *dsi, u8 cmd, void *data,
> @@ -311,38 +315,39 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
>   
>   /**
>    * mipi_dsi_generic_write_seq - transmit data using a generic write packet
> + *
> + * This macro will print errors for you and will RETURN FROM THE CALLING
> + * FUNCTION (yes this is non-intuitive) upon error.
> + *
>    * @dsi: DSI peripheral device
>    * @seq: buffer containing the payload
>    */
> -#define mipi_dsi_generic_write_seq(dsi, seq...)                           \
> -	do {                                                              \
> -		static const u8 d[] = { seq };                            \
> -		struct device *dev = &dsi->dev;                           \
> -		ssize_t ret;                                              \
> -		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));      \
> -		if (ret < 0) {                                            \
> -			dev_err(dev, "transmit data failed: %zd\n", ret); \
> -			return ret;                                       \
> -		}                                                         \
> +#define mipi_dsi_generic_write_seq(dsi, seq...)                                \
> +	do {                                                                   \
> +		static const u8 d[] = { seq };                                 \
> +		int ret;                                                       \
> +		ret = mipi_dsi_generic_write_chatty(dsi, d, ARRAY_SIZE(d));    \
> +		if (ret < 0)                                                   \
> +			return ret;                                            \
>   	} while (0)
>   
>   /**
>    * mipi_dsi_dcs_write_seq - transmit a DCS command with payload
> + *
> + * This macro will print errors for you and will RETURN FROM THE CALLING
> + * FUNCTION (yes this is non-intuitive) upon error.
> + *
>    * @dsi: DSI peripheral device
>    * @cmd: Command
>    * @seq: buffer containing data to be transmitted
>    */
> -#define mipi_dsi_dcs_write_seq(dsi, cmd, seq...)                            \
> -	do {                                                                \
> -		static const u8 d[] = { cmd, seq };                         \
> -		struct device *dev = &dsi->dev;                             \
> -		ssize_t ret;                                                \
> -		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));     \
> -		if (ret < 0) {                                              \
> -			dev_err(dev, "sending command %#02x failed: %zd\n", \
> -				cmd, ret);                                  \
> -			return ret;                                         \
> -		}                                                           \
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

