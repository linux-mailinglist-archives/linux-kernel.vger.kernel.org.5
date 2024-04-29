Return-Path: <linux-kernel+bounces-161998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E17128B545B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CDCF281D61
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F1323773;
	Mon, 29 Apr 2024 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ld+rrLqj"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523C110A13
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714383490; cv=none; b=tRlmdgoFu++NMY+wltuaUOotv/CDgPYOPj3ZWrMBYSI6CPx6/7lOr4DSe2+6SqQ+hn14CG5si+Os/6EC7c7/nzL2QI9Tp5jtGW/MgyTn+7qlJWGpJFFYQrKfUBjGVAqDsvMPmU0Se9iBFOtBWvfflF/XbRFXpoSwKhY4gaNnFMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714383490; c=relaxed/simple;
	bh=zA6xKat/sfgyvpOiLk32Wchu0VF6PKEOQX86Smcut9w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TwRmjGvRyqbNCpK2s9/fQtPztBwGSbUnThow4E58vBwZuRFwEfh+o8IEvV9gUxxncgLOquLYdPeZDr/ZuSTrYF/3So8CWzAbvg8n0VhoAefxjgmoUHaFXAl1Y7XQ/jmkKC7FX81Jvvfem6j4Osrj4oh2FNoWtyfFFMu/eYd6BaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ld+rrLqj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34c8f392172so1524728f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 02:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714383486; x=1714988286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+LnRlsICvGEFiJqDwaAff8ODI9d9U18e2E6oVjJp+M=;
        b=Ld+rrLqjT3J7SG/hmLaLAB/dP1tEMC4DYcQ+HFgFKmeN/KAJtSugW6CC18k/29UHCm
         OKCjXQBGCYMvUlNht0HumIYu0dAW45e0igPE6bUe86Q5f4xmlxA53oFi4yzIvpLuN8JW
         0N0K+WITl8fR1y0LyLbQLhEr+4GITysx4XSeNrGByQaKqWmYXXVDPI5UOaj3oKJxQbNh
         B/o93U8CKV4Yy+ybOcYdMrrNc4fEps48PEmsiflf50/tJbK9faepPO+vQ4DZu5zxfX+1
         M+jysWPc0Dh78VlsYWP6j6A1L6y+3FenWRUwsxbnQcyn3qQiD+82ULKrOJe39ZvirCpi
         Oy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714383486; x=1714988286;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A+LnRlsICvGEFiJqDwaAff8ODI9d9U18e2E6oVjJp+M=;
        b=roXhIB0nNHmg/kjUaOtcLhBz0NeH1LBAn3Sxt5fP4mvBC3O6hSnDnpxlXaV/XCUW/v
         iLni4ESuYNy1yXTBcEDrq1wQhNSzurnyWcoHlzz9/e8P8DLy1Cko0kzcS8sPSiHz4Pwe
         LmuSs58cvU/omp8yH+zXUo8AepQB/zKo0Oz0snK2x4iC6dEynn8dyw4udQh+x8AGB/a2
         98Sh0epxHqHadlwHSEw0DoAQB7V+VTnS5q486daCLz9qkKHdnzb+BmtUvrElyuN2dpND
         5iJLg/7x5AuLRBJ+MGwQNioP8KZ/Iowog9oIfxzldD2iHJjg9tVvbsc3cObUnzKqwu9g
         BC1w==
X-Forwarded-Encrypted: i=1; AJvYcCVENy5QifxBNQXapdqYSAFxDIrInN2xhnrg0s3b6aef58gDcs7b73KOfMTEFHNZJiDjnbFI+vKgCv1pqQrXV6Qqq31kH6NrnpX+l/oY
X-Gm-Message-State: AOJu0Yy1wCSVCAxOj2akKliUi49HiB22lJFXQ4VbhJPH3regzcoEypmr
	kNb4TuUGGBPKNI41+MpazAMnbtw4Mvm/sNuXAmXbg2zFe4IVOd0i42I6mlQ2f6o=
X-Google-Smtp-Source: AGHT+IF4glwX/gOVNwy5kk//cdVouWrqxBeBlGjgMfsH0PaEMwuHOiWu8jeqIKtAZwy8kuUkkxiUtg==
X-Received: by 2002:a5d:59a8:0:b0:34c:ceee:b2f5 with SMTP id p8-20020a5d59a8000000b0034cceeeb2f5mr4652539wrr.67.1714383486530;
        Mon, 29 Apr 2024 02:38:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:d72:4b40:65fa:89e6? ([2a01:e0a:cad:2140:d72:4b40:65fa:89e6])
        by smtp.gmail.com with ESMTPSA id q4-20020adffec4000000b00347f6b5bb6dsm28923908wrs.30.2024.04.29.02.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 02:38:06 -0700 (PDT)
Message-ID: <2af446d3-7834-4a6b-897b-b14c6bccff65@linaro.org>
Date: Mon, 29 Apr 2024 11:38:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 4/8] drm/mipi-dsi: Introduce
 mipi_dsi_*_write_seq_multi()
To: Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
 lvzhaoxiong@huaqin.corp-partner.google.com,
 Jani Nikula <jani.nikula@linux.intel.com>, Hsin-Yi Wang <hsinyi@google.com>,
 Javier Martinez Canillas <javierm@redhat.com>, Joel Selvaraj
 <jo@jsfamily.in>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-kernel@vger.kernel.org
References: <20240426235857.3870424-1-dianders@chromium.org>
 <20240426165839.v2.4.Ie94246c30fe95101e0e26dd5f96e976dbeb8f242@changeid>
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
In-Reply-To: <20240426165839.v2.4.Ie94246c30fe95101e0e26dd5f96e976dbeb8f242@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Mister Anderson,

On 27/04/2024 01:58, Douglas Anderson wrote:
> The current mipi_dsi_*_write_seq() macros are non-intutitive because
> they contain a hidden "return" statement that will return out of the
> _caller_ of the macro. Let's mark them as deprecated and instead
> introduce some new macros that are more intuitive.
> 
> These new macros are less optimal when an error occurs but should
> behave more optimally when there is no error. Specifically these new
> macros cause smaller code to get generated and the code size savings
> (less to fetch from RAM, less cache space used, less RAM used) are
> important. Since the error case isn't something we need to optimize
> for and these new macros are easier to understand and more flexible,
> they should be used.
> 
> After converting to use these new functions, one example shows some
> nice savings while also being easier to understand.
> 
> $ scripts/bloat-o-meter \
>    ...after/panel-novatek-nt36672e.ko \
>    ...ctx/panel-novatek-nt36672e.ko
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-988 (-988)
> Function                                     old     new   delta
> nt36672e_1080x2408_60hz_init                6236    5248    -988
> Total: Before=10651, After=9663, chg -9.28%
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Right now this patch introduces two new functions in
> drm_mipi_dsi.c. Alternatively we could have changed the prototype of
> the "chatty" functions and made the deprecated macros adapt to the new
> prototype. While this sounds nice, it bloated callers of the
> deprecated functioin a bit because it caused the compiler to emit less
> optimal code. It doesn't seem terrible to add two more functions, so I
> went that way.
> 
> Changes in v2:
> - New
> 
>   drivers/gpu/drm/drm_mipi_dsi.c | 56 +++++++++++++++++++++++++++++++++
>   include/drm/drm_mipi_dsi.h     | 57 ++++++++++++++++++++++++++++++++++
>   2 files changed, 113 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> index 1e062eda3b88..b7c75a4396e6 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -792,6 +792,34 @@ int mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
>   }
>   EXPORT_SYMBOL(mipi_dsi_generic_write_chatty);
>   

<snip>

>   };
>   
> +/**
> + * struct mipi_dsi_multi_context - Context to call multiple MIPI DSI funcs in a row
> + * @dsi: Pointer to the MIPI DSI device
> + * @accum_err: Storage for the accumulated error over the multiple calls. Init
> + *	to 0. If a function encounters an error then the error code will be
> + *	stored here. If you call a function and this points to a non-zero
> + *	value then the function will be a noop. This allows calling a function
> + *	many times in a row and just checking the error at the end to see if
> + *	any of them failed.
> + */
> +
> +struct mipi_dsi_multi_context {
> +	struct mipi_dsi_device *dsi;
> +	int accum_err;
> +};

I like the design, but having a context struct seems over-engineered while we could pass
a single int over without encapsulating it with mipi_dsi_multi_context.

void mipi_dsi_dcs_write_buffer_multi(struct mipi_dsi_multi_context *ctx,
				     const void *data, size_t len);
vs
void mipi_dsi_dcs_write_buffer_multi(struct mipi_dsi_device *dsi, int *accum_err,
				     const void *data, size_t len);

is the same, and it avoids having to declare a mipi_dsi_multi_context and set ctx->dsi,
and I'll find it much easier to migrate, just add a &ret and make sure ret is initialized to 0.


<snip>


