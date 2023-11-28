Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C16F7FB402
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344104AbjK1IYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344049AbjK1IYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:24:13 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EAF91
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:24:20 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b4746ae3bso10791755e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701159858; x=1701764658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k1e94yCRn7c94vk5lMUhPb5cFN0Hvus7Nz3SJzHr3dY=;
        b=XxjpRyLqUqOxRKsrtuDD2eEYXeIwUvCmMB0rE+JRBGI3FY5ePQBkoD+oXQco5T6S3p
         kg60yyiarT8dIOk2jTBrvTdK1KqXn8qrQiwn1Wd8wdzz4qAASLzrf6zdoBpJYC+riY7f
         vxGJKXqMO/Z+37afHGrhApdSihCJwJxZxV035cyX/Z7rEwf4MxcBwXyCT7ZpzXdP8DKB
         vkJYwmocJdEE/0SRj5RP1EXTYg+NJzMp2IU7FP36JEhU0zpm2z2tDnsJj/bGn8T+ek09
         4dXLFM1u32LTFuksQooUt3sa9vaE/xVkldHjSUhY44OskuRKDdQz5GtjU1wujz/tbZKd
         vAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701159858; x=1701764658;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k1e94yCRn7c94vk5lMUhPb5cFN0Hvus7Nz3SJzHr3dY=;
        b=ibESNqv6G9/2dIfJ5toL4eLCY3x2JE/Os/3gBJarVNrWiTbkWjN/zdeUkdUu2/Odqb
         W0qC0lymgnGg+hLdfx8Tbe1uJSoyCQODy5qBhvIFJ6Sx766JSyO+p5XaunJm/OVoYsWu
         2zBkDhc5yQ30pWQrbSgxQ6I76vwlwm6nvP4MQ1Y6Xo0YBvebBfdAK6fqXDGHFFMrwuNu
         XMt+6cgcjnh0PI8S7WxC72Xu/QASj8kspix+/+NHMYKx8S1Qv5AAjWx64EAWhVnrqKcz
         De62CfY+ZIBPoVk9LR5wvVlCXDEZ0ni7WvqIfj5kbjJaF+kR9s4zxiukiLeBUwEyTkwp
         qISw==
X-Gm-Message-State: AOJu0Yzr2oP5Yya9LCNZKdDfZN8keqg02PzChTksMWWSxpLQVkk/Bi6/
        OJ0h3Zaj/T9EW4KjVYVrcBzQSQ==
X-Google-Smtp-Source: AGHT+IF4jzEY+4anphsz6a8Sg0UvyxyQmZboBVunI0rP5xeovVCKmfjApOQshEMsHWXQI/rtZxmoCA==
X-Received: by 2002:a05:600c:470f:b0:40b:369b:2c53 with SMTP id v15-20020a05600c470f00b0040b369b2c53mr10657836wmo.22.1701159858363;
        Tue, 28 Nov 2023 00:24:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe? ([2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c3b1200b00405959469afsm16730777wms.3.2023.11.28.00.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 00:24:17 -0800 (PST)
Message-ID: <95016bb1-64de-4963-9a5e-7201923a5ae2@linaro.org>
Date:   Tue, 28 Nov 2023 09:24:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/3] Revert "driver core: Export device_is_dependent() to
 modules"
Content-Language: en-US, fr
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liu Ying <victor.liu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20231128-revert-panel-fix-v1-0-69bb05048dae@linaro.org>
 <20231128-revert-panel-fix-v1-1-69bb05048dae@linaro.org>
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
In-Reply-To: <20231128-revert-panel-fix-v1-1-69bb05048dae@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2023 00:10, Linus Walleij wrote:
> This reverts commit 1d5e8f4bf06da86b71cc9169110d1a0e1e7af337.
> 
> Greg says: "why exactly is this needed?  Nothing outside of
> the driver core should be needing this function, it shouldn't
> be public at all (I missed that before.)
> 
> So please, revert it for now, let's figure out why DRM thinks
> this is needed for it's devices, and yet no other bus/subsystem
> does."
> 
> Link: https://lore.kernel.org/dri-devel/2023112739-willing-sighing-6bdd@gregkh/
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>   drivers/base/core.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index bfd2bf0364b7..67ba592afc77 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -328,7 +328,6 @@ int device_is_dependent(struct device *dev, void *target)
>   	}
>   	return ret;
>   }
> -EXPORT_SYMBOL_GPL(device_is_dependent);
>   
>   static void device_link_init_status(struct device_link *link,
>   				    struct device *consumer,
> 

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
