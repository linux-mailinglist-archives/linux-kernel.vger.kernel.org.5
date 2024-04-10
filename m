Return-Path: <linux-kernel+bounces-138214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EB989EE2D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4911F239C6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4472156663;
	Wed, 10 Apr 2024 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJ1Vvw41"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B41F15531A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740066; cv=none; b=Rt/7aj0PFUiHScKl/dmmIUlS3O9S+pb18Kg9RulH9X6EV8Dtdv/JANqh2nqH3lQolEy23NmtgOAdFZjYmQuzf7wb8q6R/N2Q5MBksA3W0jwTMyMv/9KeBYEAGw5GTw8gwdxrnvhns0Fh1qVyFm/ajIVahIQNGdShM9zJMjTAiNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740066; c=relaxed/simple;
	bh=luN0t0HNV6pacgKxjXToQdAgTwlahLqp49Y3Pwj/+Ys=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QFlxOG0zVr1uugvIhzgZjlSlLkxo1La0Kn4EMdiRWns+k6rSxpfCBttNmf/1TYgnBxjtOgIKz9hbKkkrjGaPckMeAtoDiN1ABlkzgjr6GnM+Ojl7KFKCjHe7k2fKnuARKa0KOo6t561+wYLI0inhjYHPRjW4Jhnk4rID3IR716w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OJ1Vvw41; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516dbc36918so5065729e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712740062; x=1713344862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=duc/Dbl/Cjtaq4jKQcJqe623WLKfFna/k+1G9vHqsrQ=;
        b=OJ1Vvw41h+omlg7H7w52XTX2uClnHM5tfQMixTGvv6EvNKjut4ohIogcrzmzNzaaoW
         CwUiUsCDTu1Etg5abMaJQ7AO/csj8PHN77gNP8zDikB6+aOrXWW9NI1VWRgsmNa/4liJ
         Gd2bFO/toS+hWMyZFXcK0561w0nmfOX5CtTg5E6dngvJ2/7IABNxeCMr8FvM+Pzu2JU5
         aZEUcn0XfGh0sCmS64GQC5fZ+LtaqgbrbnGUklXqJrLqIUzU3U01LzjVcPq8tWR2jmQD
         xhOXfLkW2fi07Y8y0PQ9Ir/tlZbAKXL1sGKDbMhej1cV9SmzOjo9WX8324l4WDhTTxDR
         8Z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712740062; x=1713344862;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=duc/Dbl/Cjtaq4jKQcJqe623WLKfFna/k+1G9vHqsrQ=;
        b=myOjL7lEGDz13mnu/JYPNEGjHqHBYjr4jLhlaBSAKb/EWtW/Pytkak2pZFGqgM6YdZ
         eZwNHTp6RZhCQWB4tAJdxkLvssTycJI5ergVClh0YrAEMDOLani5bSULBddTg0248Rc5
         faNXDdZp5BxR0OTeGSy6nhl0PSaEKPZKwToJtwixG50zdcO+H2xKrzzZiiJ4dkUs7R5d
         zFDpib7YgcVa9SP01fVhceZHSd9a23lRL0v04UBwDf16mg2YkL2Qya3Q1JivevX0U3M1
         ldzJEjHfA8K9P3A4TFos7O0jcwC2qiMWVGvtbgnrJrOBsgW7Ha50lqQ3/ELKFGi9y+Av
         2erw==
X-Forwarded-Encrypted: i=1; AJvYcCWC4RXTugvqGr/o9NizxhDXXyJhkpUOhXKw7UQawOl6qkR4CDcp/L83BaMncgJh5zwvsuk2k1x1JZaXk4mLLHbz594oAiCFAV+tPCsq
X-Gm-Message-State: AOJu0YxaKigIVjh9sJkw81GhLKpfpMYt5LpkdoQnP5yPXOuTW8+/H5D9
	fHfdJMydu2LvtuB+C3wFWUWE4F90V6lXoar/nitq8UISJVyVvLdw9bQMpABhC8c=
X-Google-Smtp-Source: AGHT+IHqleKIYdgSYtADyybe6lUqcvkPzHpFY5eWWUAxhHp90xeEfjgOqjhY3Bz8AM9gVtHxMt4Cyw==
X-Received: by 2002:a05:6512:554:b0:516:d097:8c32 with SMTP id h20-20020a056512055400b00516d0978c32mr1157497lfl.18.1712740062261;
        Wed, 10 Apr 2024 02:07:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7b0c:6cd:4afa:674b? ([2a01:e0a:982:cbb0:7b0c:6cd:4afa:674b])
        by smtp.gmail.com with ESMTPSA id s7-20020adff807000000b00343d6c7240fsm13293822wrp.35.2024.04.10.02.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 02:07:41 -0700 (PDT)
Message-ID: <67aaaea4-089c-4de5-8070-57e6a7134362@linaro.org>
Date: Wed, 10 Apr 2024 11:07:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RESEND] drm: use capital "OR" for multiple licenses in
 SPDX
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240410082200.44966-1-krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20240410082200.44966-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/04/2024 10:22, Krzysztof Kozlowski wrote:
> Documentation/process/license-rules.rst expects the SPDX identifier
> syntax for multiple licenses to use capital "OR".  Correct it to keep
> consistent format and avoid copy-paste issues.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Resend...
> 
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/gpu/drm/drm_client.c        | 2 +-
>   drivers/gpu/drm/drm_format_helper.c | 2 +-
>   include/drm/drm_client.h            | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
> index 77fe217aeaf3..d8e3427ae205 100644
> --- a/drivers/gpu/drm/drm_client.c
> +++ b/drivers/gpu/drm/drm_client.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0 or MIT
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>   /*
>    * Copyright 2018 Noralf Trønnes
>    */
> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
> index b1be458ed4dd..2348135fb6c0 100644
> --- a/drivers/gpu/drm/drm_format_helper.c
> +++ b/drivers/gpu/drm/drm_format_helper.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0 or MIT
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>   /*
>    * Copyright (C) 2016 Noralf Trønnes
>    *
> diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
> index bc0e66f9c425..1b907709115e 100644
> --- a/include/drm/drm_client.h
> +++ b/include/drm/drm_client.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 or MIT */
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
>   
>   #ifndef _DRM_CLIENT_H_
>   #define _DRM_CLIENT_H_

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

I think we'll need maxime or thomas ack to apply this via drm-misc-next

Neil

