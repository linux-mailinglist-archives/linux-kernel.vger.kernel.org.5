Return-Path: <linux-kernel+bounces-138938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0351789FC42
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5511C28E3F9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A175916F0EF;
	Wed, 10 Apr 2024 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tLLPGzNs"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FB91791FE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764576; cv=none; b=PDpeNZ7kIIsjNo6fvxjmnXgtB1fD/2U08nniKfLjpMpd0GpwxEol1BMMtRY8cI9Q79HGzY6GxnPDRzBeli2uZ41wVuo0qcbR6OikPtMLcAJ7heJpRskGkN5KsCaw54GB2P+ku5VuUeXQ+h4OZBmVsgmSA2MwrwmQtV/g6A1UkLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764576; c=relaxed/simple;
	bh=POh8IzPVqd5g9ddH6pfdaCVtLO682z9BexNHdz5ZleU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=msfYGIhQgrTkjlPnxypxWcD6HVheZbEOMY8wzpt3woPTxrsr2auw9c6tVUeyGcuMAU1J54wfu9VsU8qLBBLlDNr8XuDTc+8KCNgKKhDDDKkH3Rmwe8o3SDrHqs78GAri73M9fi3jLRgYScJjOx94jXZf4O9NlIejVkCIBxE8MMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tLLPGzNs; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3442f4e098bso2455481f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712764573; x=1713369373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HMdmKuUIz4lixjCtcUgme1poJSOdnyEZp5xiFsRRNeM=;
        b=tLLPGzNsVhSvdOXwRhU7ge6mXA5h6UGJi+xU3TPkC9x+6H/OvSBc9HYcXaccuR0NWx
         LSz2tYNZmZNmIZAE52UKwzm+SCOB7w6MsMeedlmwNW/0q6wl0ooKIUHZ7ZovTP3XbUq7
         V1R8VibjB9nWYJcViV5CgJUzmedqrIW9RMCMurIImH/r/u6E9/rKxEtTEw4F7sL3Qbpv
         +FkPEvGBqs3b245L7Ul4rKP+QFyTsKFpVODrB3g/LqR7/6j4W94hBe+pAzWwxYSO2uZF
         LNqRjamzEBlKAjJJDZGATYz8NsvkuJA81++Ryh6ajVf6Bp/D7y/lx+dMofkcJkDoGbu3
         3Rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712764573; x=1713369373;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HMdmKuUIz4lixjCtcUgme1poJSOdnyEZp5xiFsRRNeM=;
        b=HQi0OReI/9UL5knw0Ck3bnlgmKPqgguY+EEnKJDRkObWKULGkRQcU4BsgFjY+sV8oN
         Lk5+AW0c6pbrldMufJGFN/glQsp+ZLKYy6sixlRJTAw7zpmIKLiu17FqRNdAn8TgngBG
         JGOQmFVH+J17K0goPtH9t0kSqximCzGJabwRL/L1k7hK077mUrFpg7SWqEfXY3r3pBnH
         N6MsdAFbdt1hBX12QsdEnWx4J6NQFbITS1muaz5BfUMkPJo5vDLttEE1uiqifvCmNyZd
         zL1z88IUAJhz3BlcEUwzeO/h+hnlgssiRHkZpFuWaiv/RP+L1Y26LGpZHFshr8Uchtk0
         rp+w==
X-Forwarded-Encrypted: i=1; AJvYcCUAHRFzE1H24otMA7iP668hcDUt0MXyR0XkmJrIuSwaFVMGxhribSZKTwxe7HAmtd+GkY6HQPHKxF9gHkF14nWZOiwpCYSEgf1FhZOD
X-Gm-Message-State: AOJu0Yw8uWyRszjdJtpveVlxsI8tFq3dLOAzmiU/C5k3P/tRcF8lRhnk
	TCOoDPHM+W/nPVuTmljBTnbD/8kq8G6a9dbxAoPuSY+XkdAtp9c9b4TpyaYnvx4=
X-Google-Smtp-Source: AGHT+IH0DicSj7EZdYVwanK8DChE5Kq6JyrG4DLOmsDfa/paE/heJ15/axU+4Ae8PBBUkNTAuGB01w==
X-Received: by 2002:a05:6000:402c:b0:345:811b:466e with SMTP id cp44-20020a056000402c00b00345811b466emr46608wrb.26.1712764573431;
        Wed, 10 Apr 2024 08:56:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:760d:c2fa:a66b:fed3? ([2a01:e0a:982:cbb0:760d:c2fa:a66b:fed3])
        by smtp.gmail.com with ESMTPSA id i6-20020adffc06000000b003455e5d2569sm10468562wrr.0.2024.04.10.08.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 08:56:13 -0700 (PDT)
Message-ID: <7c1aa6a9-b964-45e7-bd8c-d9ef5096a04a@linaro.org>
Date: Wed, 10 Apr 2024 17:56:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] clk: meson: s4: fix module autoloading
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240410155406.224128-1-krzk@kernel.org>
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
In-Reply-To: <20240410155406.224128-1-krzk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/04/2024 17:54, Krzysztof Kozlowski wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.  Clocks are considered core
> components, so usually they are built-in, however these can be built and
> used as modules on some generic kernel.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   drivers/clk/meson/s4-peripherals.c | 1 +
>   drivers/clk/meson/s4-pll.c         | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
> index 6c35de3d536f..22ff030bd6a8 100644
> --- a/drivers/clk/meson/s4-peripherals.c
> +++ b/drivers/clk/meson/s4-peripherals.c
> @@ -3799,6 +3799,7 @@ static const struct of_device_id clkc_match_table[] = {
>   	},
>   	{}
>   };
> +MODULE_DEVICE_TABLE(of, clkc_match_table);
>   
>   static struct platform_driver s4_driver = {
>   	.probe		= meson_s4_periphs_probe,
> diff --git a/drivers/clk/meson/s4-pll.c b/drivers/clk/meson/s4-pll.c
> index 8dfaeccaadc2..8a917b9703bf 100644
> --- a/drivers/clk/meson/s4-pll.c
> +++ b/drivers/clk/meson/s4-pll.c
> @@ -853,6 +853,7 @@ static const struct of_device_id clkc_match_table[] = {
>   	},
>   	{}
>   };
> +MODULE_DEVICE_TABLE(of, clkc_match_table);
>   
>   static struct platform_driver s4_driver = {
>   	.probe		= meson_s4_pll_probe,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

