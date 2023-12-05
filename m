Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E74804C64
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344795AbjLEIad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbjLEIaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:30:15 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7BFD71
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:30:16 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b5155e154so57079305e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 00:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701765015; x=1702369815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UITyNimW6NjgxBsrNVLcSnT1CZu1dSK21apn8J0ImE=;
        b=vQNPcmj79QRR+LHl68x3pKf+vUzEXQWqlM9oelYlwd3OG4KYbejJa58vw7BrDSbwtp
         aa/iq3JXnCpurVfVGYjk+JyHGEyqPSsprcoQw2h1P1lQCZTw/UiC77fkyXf583Cn9Jtt
         M4GBvt2zAy8dOw/q0oJkWHfD//C5R9anf+s054J8qeGHvuIUQD6Ojr98+tSV8DsX/Y7R
         mpH9WmAxoMK1tSATNTfvgExruEc59MPgA3VIdNuTBTe0IK9nJ3BDG1U3bJGSAR/ancjV
         qogJSOitGuffx+WQ7NSPHaHRGwFZ5TKeI+IRQ1ODhwbGp1i72msy6puaq0azW63dViZA
         PlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701765015; x=1702369815;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+UITyNimW6NjgxBsrNVLcSnT1CZu1dSK21apn8J0ImE=;
        b=AtfiGWYpRATULiwuIiAQlmU9W3rnmm8NZfcrg7fKA30O/MIXmxxwplN0rDytV/X+gt
         a3XeEhs1Tqupq+ts/KHzxZ7ZmrUtoFqpkjWP7TtZNWkvE39qByDjgaCpAQSUk0eu1Dwg
         3yLYLL+Xq+Y8S9Xk0smqXBXwzITsrzC78/a4K+q0YmYY8JOkY0wTzRxkRXCyEAhAEkdt
         AlOHC9Jbcs2wvsVqybpNq7T8rd/WaK/Z8p2IpkWWxw4TTESejMvQfWNmXm9gcw5f6bc9
         O8/aQq6HNkjDBCCuGDh3FQR6dJ8wQdE71BIC2V2p3I1Zc6addyDRe53zPwQAjImRT1y3
         PI/Q==
X-Gm-Message-State: AOJu0YwmeujtDWxugNzLFWw7VPTbmEPbFlsZe+PG7YZ87Ivy3UtmaKjE
        a7TrZhULeOSIHoUxXsyij7iJEQ==
X-Google-Smtp-Source: AGHT+IFazNlMJO2Phi4FOM2GZeBYIngyJd8JRcCm2L6tpEGnKSzGpmSVmHySB7ZAlkWUhw8FTawI1w==
X-Received: by 2002:a1c:770d:0:b0:40a:5c71:2c3e with SMTP id t13-20020a1c770d000000b0040a5c712c3emr216278wmi.19.1701765015146;
        Tue, 05 Dec 2023 00:30:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:4518:5e57:ff13:b4bb? ([2a01:e0a:982:cbb0:4518:5e57:ff13:b4bb])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c4ed000b0040b47c53610sm17866225wmq.14.2023.12.05.00.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 00:30:14 -0800 (PST)
Message-ID: <9845c9ea-9121-436f-8185-95119a461127@linaro.org>
Date:   Tue, 5 Dec 2023 09:30:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: nxp-ptn3460: fix i2c_master_send() error
 checking
Content-Language: en-US, fr
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
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
 <75c11af4-3f5e-4909-a3d3-8feea947d4ea@linaro.org>
 <bb28e859-215d-4279-bc7e-f601352d06df@suswa.mountain>
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
In-Reply-To: <bb28e859-215d-4279-bc7e-f601352d06df@suswa.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2023 17:59, Dan Carpenter wrote:
> On Mon, Dec 04, 2023 at 02:53:05PM +0100, Neil Armstrong wrote:
>> On 04/12/2023 13:29, Dan Carpenter wrote:
>>> The i2c_master_send/recv() functions return negative error codes or the
>>> number of bytes that were able to be sent/received.  This code has
>>> two problems.  1)  Instead of checking if all the bytes were sent or
>>> received, it checks that at least one byte was sent or received.
>>> 2) If there was a partial send/receive then we should return a negative
>>> error code but this code returns success.
>>>
>>> Fixes: a9fe713d7d45 ("drm/bridge: Add PTN3460 bridge driver")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>>> ---
>>> This is from static analysis and code review.  It's always a concern
>>> when you add stricter error handling that something will break.
>>>
>>>    drivers/gpu/drm/bridge/nxp-ptn3460.c | 10 +++++-----
>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
>>> index d81920227a8a..9b7eb8c669c1 100644
>>> --- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
>>> +++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
>>> @@ -56,13 +56,13 @@ static int ptn3460_read_bytes(struct ptn3460_bridge *ptn_bridge, char addr,
>>>    	ret = i2c_master_send(ptn_bridge->client, &addr, 1);
>>>    	if (ret <= 0) {
>>>    		DRM_ERROR("Failed to send i2c command, ret=%d\n", ret);
>>> -		return ret;
>>> +		return ret ?: -EIO;
>>>    	}
>>>    	ret = i2c_master_recv(ptn_bridge->client, buf, len);
>>> -	if (ret <= 0) {
>>> +	if (ret != len) {
>>
>> This is impossible, i2c_transfer_buffer_flags() returns len as-is if no error, so
>> ret can only be negative or equal to len. The original code is right.
> 
> It works, but it's not "right".  The <= 0 could be changed to < 0.  The
> "len" variable is EDID_LENGTH (128).

So indeed, switching to < 0 is the most reasonable, no need to change the ret value in this case.

Neil

> 
> regards,
> dan carpenter
> 

