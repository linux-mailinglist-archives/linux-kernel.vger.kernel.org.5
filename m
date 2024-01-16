Return-Path: <linux-kernel+bounces-27153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD8A82EB48
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2A72B22146
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D132312B77;
	Tue, 16 Jan 2024 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YhSJ3sEz"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63743125DB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50eabd1c701so11698871e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 01:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705396168; x=1706000968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JP+pTH80AGhoHRS7N2h9nNb/JBmIT3BiPKqeh2cEls=;
        b=YhSJ3sEz3jg6T5NM1466XqUeMQWZqTimWvpUJMg/FdDFvDbDFkb4Qp2xVBnwWlVkcH
         eDkXp/OEneP9gsNf6bOwu7A9GkfuU0+UWBlauzz6ys4VGCjEMfYyPdsPhrH1OlE8VPqK
         1DvYUtIe3nGqPcko3KSX8gP7ibuN4hlhkfRbiuisVLSy/632R033kbOnZPDzldgNofDo
         CzWbaDIT/IXnvrKbK8kP0PsPArV305f1EA6CfYMgqbZg3HWGdn3+73leEwvCTin5iTg9
         a+nH6LoUsSEIRGWm9PfF31JrArMsxzbxJ8m8aNJdvYcnjOWYALwmRwN9e/5sFFC1Dv5S
         d4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705396168; x=1706000968;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4JP+pTH80AGhoHRS7N2h9nNb/JBmIT3BiPKqeh2cEls=;
        b=asAQo8LmtARsu2t0bPSsiiZJAfyNqcRTJMzGHRtW+yhLhcIFk09k/kF8RqIwwZ+OFo
         v5LmnbQvzXIrbLZ6lrpgVB/1f8LiTdLhmOMLyVUFlIGPS1hbzU3sasDja9rA/XQ9erPX
         Tbw4B6SaILy+RsM17/FH8CrflVIIzVPYNCYDzLEvnc0oJWG9aqFlLjxkT/BTsrAXzia2
         J2aw0Ot1JTf1dp30zEk/FMFaQdexTbKtka55xXIAGZVRdy3Xb+17Nspf2Ypp1fcM1AlO
         KZ+ETem4PJrzA3wSaaERWUKcko7XObuKMUOKeFxM1/tq4oQL9Gy3PiLqZnYx/6/jaO0c
         7bOQ==
X-Gm-Message-State: AOJu0YyCv0knlnpe+YozSjcMnPfoGpXQIdWNFJOEMDlka+jrHItM9W5P
	bGdPzvCaboN8eRyxWnRXFBYamDcGRZ2rhQ==
X-Google-Smtp-Source: AGHT+IHEGwnPMy/GeMEYuhyhSNovt05ckF1h6USwD8Wn4VmfmOYiXiG0ukimRShuWP8X/xzAdLpKaA==
X-Received: by 2002:a19:8c1d:0:b0:50e:7b7b:5597 with SMTP id o29-20020a198c1d000000b0050e7b7b5597mr3081813lfd.98.1705396168251;
        Tue, 16 Jan 2024 01:09:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:30a6:c236:cc88:349e? ([2a01:e0a:982:cbb0:30a6:c236:cc88:349e])
        by smtp.gmail.com with ESMTPSA id z12-20020a19650c000000b0050e7b8ff90esm1737416lfb.66.2024.01.16.01.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 01:09:27 -0800 (PST)
Message-ID: <5f72b937-184d-4002-b300-6092e1731724@linaro.org>
Date: Tue, 16 Jan 2024 10:09:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: novatek-nt36672e: Include <linux/of.h>
Content-Language: en-US, fr
To: Ritesh Kumar <quic_riteshk@quicinc.com>, quic_jesszhan@quicinc.com,
 sam@ravnborg.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, quic_abhinavk@quicinc.com,
 quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240116071803.5264-1-quic_riteshk@quicinc.com>
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
In-Reply-To: <20240116071803.5264-1-quic_riteshk@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/01/2024 08:18, Ritesh Kumar wrote:
> Include <linux/of.h> instead of <linux/of_device.h> to fix
> below compilation errors:
> 
> drivers/gpu/drm/panel/panel-novatek-nt36672e.c:564:14: error: implicit declaration of function 'of_device_get_match_data'
>    ctx->desc = of_device_get_match_data(dev);
>                ^
> drivers/gpu/drm/panel/panel-novatek-nt36672e.c:622:34: error: array type has incomplete element type 'struct of_device_id'
>   static const struct of_device_id nt36672e_of_match[] = {
>                                    ^
> 
> Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>
> 
> ---
> In the patch https://lore.kernel.org/all/20231129164316.2663565-1-robh@kernel.org/,
> include of <linux/of.h> from of_device.h was removed. This change was not present
> in my local build resulting in successful compilation while posting
> https://lore.kernel.org/all/20240108095902.22725-3-quic_riteshk@quicinc.com/.
> ---
>   drivers/gpu/drm/panel/panel-novatek-nt36672e.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
> index d4e85c2fc899..cb7406d74466 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
> @@ -4,7 +4,7 @@
>   #include <linux/delay.h>
>   #include <linux/gpio/consumer.h>
>   #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>   #include <linux/regulator/consumer.h>
>   
>   #include <drm/drm_mipi_dsi.h>

Fixes: ea4f9975625a ("drm/panel: Add support for Novatek NT36672E panel driver")
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

