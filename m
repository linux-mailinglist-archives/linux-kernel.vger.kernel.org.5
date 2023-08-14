Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B82B77B8D7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjHNMkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjHNMjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:39:51 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47BAE63
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:39:50 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe8242fc4dso34773385e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692016789; x=1692621589;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MaW4bORmwFdLBeozTIiRBmy0rVkdPjQDOyBPETHjUOc=;
        b=hEJNdeug2ZTgRi2Dc7CDYT1/LUEvAL/EhtH58drTb32MyoUFaKuk+cBG4xVH7G4eJ1
         Bt+qkTRJngb0f5VSVTDWfrYurjckxqvDaK0pZHLZ4VI+xuAEMQmk7hHNF5qYnphyIc1/
         3ke0JiA5EGaMs/helu7sfq2dnNOxL1+ghmkkAVon8nHbhTa3OaFyE1+Ww3QHuUuIw/vo
         SqAhy/vtRb6x4TFWVXEx5JZ4oK/SJnmtBNvHF1ahRokAYSZ9NebD9kJzMM+WcgkMv5iU
         dQ7lWNZh/vJWEtu4o8xKBlyjJKn5U0zwRzlrQWb2P6fKvDHvYc8zFkLcZL+xrPbg1WzH
         uBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692016789; x=1692621589;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MaW4bORmwFdLBeozTIiRBmy0rVkdPjQDOyBPETHjUOc=;
        b=IQx1tcD26K/WTw1zIMZdw+ODlHMZJme4412R/m1W1p+FLcuJQymF7XU33RPzd0djua
         ifcR1nCqGtF1hm12XPQRwc3reStW7ZQzFxRW7dH6jcoDgzfQPqNiF8vDfbnSHMqf+rr6
         tr718pLrD1JHW2iHD7NRAgnJB8HAcpJbO0IBKZQRW6MepvI3QGYr+pF22Zi8Ckkz2vzG
         9JYge05QGV4KHkp1ZafE3lxVi8Lx8H3k3dmtuV5Rjb5RaicpIIujQEJARcSvMVLh/Sst
         TXlyCXIJUYtp98yOVWHnH1fA0oBwLPZpNe7zk0l1ONFOMWrCfbqEFtzTSLiSh9DAmrnS
         rSrQ==
X-Gm-Message-State: AOJu0YwmuuZbIIbJBA2LbxgPeyJUO4JyJlbr6lOfdJ7zPEHzmjq1vSeg
        F2hsYxM3iXiJ26PjwDSUi+iLHw==
X-Google-Smtp-Source: AGHT+IFLoMvOszpMHBwo1mQ1xr/E3a7hFhmXRDVqgNS4e1intI14cCpMXKnb+Pu1ZD0N9Utc7RWurA==
X-Received: by 2002:a05:600c:2197:b0:3fb:b56b:470f with SMTP id e23-20020a05600c219700b003fbb56b470fmr7194256wme.14.1692016789103;
        Mon, 14 Aug 2023 05:39:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a3d8:b217:d82c:9bc0? ([2a01:e0a:982:cbb0:a3d8:b217:d82c:9bc0])
        by smtp.gmail.com with ESMTPSA id v14-20020a1cf70e000000b003fe24441e23sm14193823wmh.24.2023.08.14.05.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 05:39:48 -0700 (PDT)
Message-ID: <e6024f7e-a7b7-41d9-a949-ac0a72e2512e@linaro.org>
Date:   Mon, 14 Aug 2023 14:39:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: JDI LT070ME05000 drop broken link
Content-Language: en-US
To:     David Heidelberg <david@ixit.cz>, Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230812183404.374718-1-david@ixit.cz>
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
In-Reply-To: <20230812183404.374718-1-david@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/2023 20:34, David Heidelberg wrote:
> Link is no longer functional and web.archive.org doesn't provide PDF
> with detail information.
> 
> Some informations can be found from web.archive.org here:
> https://web.archive.org/web/20170629205602/http://panelone.net/en/7-0-inch/JDI_LT070ME05000_7.0_inch-datasheet
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/gpu/drm/panel/panel-jdi-lt070me05000.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
> index 213008499caa..f9a69f347068 100644
> --- a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
> +++ b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
> @@ -5,10 +5,6 @@
>    *
>    * Copyright (C) 2016 Linaro Ltd
>    * Author: Sumit Semwal <sumit.semwal@linaro.org>
> - *
> - * From internet archives, the panel for Nexus 7 2nd Gen, 2013 model is a
> - * JDI model LT070ME05000, and its data sheet is at:
> - * http://panelone.net/en/7-0-inch/JDI_LT070ME05000_7.0_inch-datasheet
>    */
>   
>   #include <linux/backlight.h>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
