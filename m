Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDA0803587
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbjLDNxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235654AbjLDNxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:53:04 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E47181
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:53:09 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b595bf5d2so46887965e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 05:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701697988; x=1702302788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=caHOksw5I0x/otbSLvQvnBWXc9OQUPmugqhHhV4G93g=;
        b=LRUpT1wQeIrQYLsXKyXMArsuOByyVHStSRnnp5rb/sYhPWkG7lkWkG1843gmyQEEFy
         0onKeRqATsCJSHGRVQIc2PiRRJ3WguhM97h7qRalZz4Y6PB4MnL5tCOfPZxHG6z+eXyQ
         cg1kHj4kO7DZbls5Ah/qoslTee0/O8Z8HfMbS8tFSmhc4IbJ0XKVfkIMLyV/gRkkmY5k
         ZfeMt1Q4S8LIahxmOE4RNAqdGjqmgOJoRXK/DCk51MNAeNRqHK+VbTEOzHPH9PYJ5i5E
         s/B18M/e2mJLaZ8MOLoQpYi9UnlZjxPaBi3ICwWfswervEKOW6giNhgDLygfSoraOsDJ
         g0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701697988; x=1702302788;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=caHOksw5I0x/otbSLvQvnBWXc9OQUPmugqhHhV4G93g=;
        b=KCvStSeuLzW4iQES/T5nbbxkdI6R3CZ73d7V3t+ZV3w2l9SdSkqvqZ9/ZkdpEAeBon
         G+DGnMRWLvOvumLABYbGrW8LFQ3bAEdhvmD+1gS0tQ5/F6eMi4B7QHfdqxt8kLBBoByi
         b8XAyBeUW0fDT3ZQq6iuLQdDs0W0OjURuKxokVZcyXmP62Ga5DgIGEgtkYlKjeaX8Cl+
         3GJFJZ5dm5g4pXyWtjT0IjGRqRmfjeWIHshp0r3gW2djjK87vfxIG/wPLSfr75aJzjVm
         +U23myg6aRMDZL9SbbmzMKKca2x+BR37yMHdiTjn3+LD2tVxFhzzZgOdY32nNWjbeGfE
         s7xQ==
X-Gm-Message-State: AOJu0Yz2LlJho9tN8SybwzQvkHxcMpJdQEI5HwN2uora7RAgfpwFicD9
        2Mo91+HXrc15P3SGfp0oLLqUyw==
X-Google-Smtp-Source: AGHT+IHZZ6atFrXFiYIGXh1lMDQZw4HmJbJRHC9P20p593Wf0++RCyxVXc0+Prz/gHfzVPvFoNqyTA==
X-Received: by 2002:a05:600c:d6:b0:40c:909:3642 with SMTP id u22-20020a05600c00d600b0040c09093642mr910809wmm.216.1701697987800;
        Mon, 04 Dec 2023 05:53:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:58:12b5:777b:9d17? ([2a01:e0a:982:cbb0:58:12b5:777b:9d17])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c468b00b0040b561924bbsm16752989wmo.21.2023.12.04.05.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 05:53:07 -0800 (PST)
Message-ID: <75c11af4-3f5e-4909-a3d3-8feea947d4ea@linaro.org>
Date:   Mon, 4 Dec 2023 14:53:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: nxp-ptn3460: fix i2c_master_send() error
 checking
Content-Language: en-US, fr
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Sean Paul <seanpaul@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Inki Dae <inki.dae@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <0cdc2dce-ca89-451a-9774-1482ab2f4762@moroto.mountain>
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
In-Reply-To: <0cdc2dce-ca89-451a-9774-1482ab2f4762@moroto.mountain>
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

On 04/12/2023 13:29, Dan Carpenter wrote:
> The i2c_master_send/recv() functions return negative error codes or the
> number of bytes that were able to be sent/received.  This code has
> two problems.  1)  Instead of checking if all the bytes were sent or
> received, it checks that at least one byte was sent or received.
> 2) If there was a partial send/receive then we should return a negative
> error code but this code returns success.
> 
> Fixes: a9fe713d7d45 ("drm/bridge: Add PTN3460 bridge driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> This is from static analysis and code review.  It's always a concern
> when you add stricter error handling that something will break.
> 
>   drivers/gpu/drm/bridge/nxp-ptn3460.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
> index d81920227a8a..9b7eb8c669c1 100644
> --- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
> +++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
> @@ -56,13 +56,13 @@ static int ptn3460_read_bytes(struct ptn3460_bridge *ptn_bridge, char addr,
>   	ret = i2c_master_send(ptn_bridge->client, &addr, 1);
>   	if (ret <= 0) {
>   		DRM_ERROR("Failed to send i2c command, ret=%d\n", ret);
> -		return ret;
> +		return ret ?: -EIO;
>   	}
>   
>   	ret = i2c_master_recv(ptn_bridge->client, buf, len);
> -	if (ret <= 0) {
> +	if (ret != len) {

This is impossible, i2c_transfer_buffer_flags() returns len as-is if no error, so
ret can only be negative or equal to len. The original code is right.

>   		DRM_ERROR("Failed to recv i2c data, ret=%d\n", ret);
> -		return ret;
> +		return ret < 0 ? ret : -EIO;
>   	}
>   
>   	return 0;
> @@ -78,9 +78,9 @@ static int ptn3460_write_byte(struct ptn3460_bridge *ptn_bridge, char addr,
>   	buf[1] = val;
>   
>   	ret = i2c_master_send(ptn_bridge->client, buf, ARRAY_SIZE(buf));
> -	if (ret <= 0) {
> +	if (ret != ARRAY_SIZE(buf)) {

Ditto

>   		DRM_ERROR("Failed to send i2c command, ret=%d\n", ret);
> -		return ret;
> +		return ret < 0 ? ret : -EIO;
>   	}
>   
>   	return 0;

