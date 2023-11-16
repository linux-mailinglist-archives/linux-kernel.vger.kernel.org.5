Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6971F7EE125
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjKPNNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjKPNNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:13:17 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FDED4F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:13:12 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32dcd3e5f3fso567013f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700140391; x=1700745191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMbhkugRGBK9Nmxo+p7a+HNB8F8J1UNGjmT0mRvTJJk=;
        b=wtWCsSC6+zVr24oC159bfv6sNcuMtXVBmIFKpJnGh0XPOBDy5RCeM1E9mVwn70BbVS
         TbGLV2dLHKD6+ULmZiZkOvLLj728DeUTAI1UH9cAPovBKUc63AaGbNpy2xPiSLSI2sWR
         1+EzCB9we8JgrAFnKXLEz7l9TKsUShYbi59h0Iulz2JG0D4nSFqzMbVhmUUCqG1uufay
         X2Ho/YnNCQaUifzmRMEt7IAwFoMT+GhuvEuj8VYP71JoD1sqEBfPRnLpNnOiuYJe+doJ
         TBChSL4Mi4UAR/OOu/2UZ2F/0XknIoFBPjNVGOPLxpWCo/pM2aghT6KV5EYpS6JmhPvr
         eVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700140391; x=1700745191;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nMbhkugRGBK9Nmxo+p7a+HNB8F8J1UNGjmT0mRvTJJk=;
        b=p57G3pvHXSlsvpkvzjpxy+UmNDDd+FL8KLU1QYjyu+1kfYQGAJc4OfCLTmwIrZH3Zu
         tvFjT/yQ94YbU3yWE0HhG2z5UjBesJvl/Wb2CppLMf9C9lfTDOIl3okGeQYdJmNKvaxq
         OCQlryCcBCtaTcDdhF6XDeeG/eTT6iyoPH8PwlL2aXqiydOtwLLst6mLtT6eRQ/wLI5A
         yjkYXR6vvvmFZZ7VRyiK/0qw7HSh9J5WM1atJ0B/hNLFfnR8PtqOsbxuAEkKakpvpcgQ
         pw1l95tJfiGTX5FrqMZYlAAhYugoLnZcw+NM9w5bDBZOohyGHV9KSUNSh7vkNfIfAsIg
         ZqbQ==
X-Gm-Message-State: AOJu0YxmzbdNBp1GAAR1nnaNVuTYW8b65b/xoQyX/CAWPkZfAlqt6HzX
        fQNws9g3QAXr8o/YkxqTqnhx4Q==
X-Google-Smtp-Source: AGHT+IEil2jol5MIx1ocjxe9ekk/wg57MKq85rxPL7jkm3RWHDTwf/8F9bz+tBjqa/JNuzR5G2yj0A==
X-Received: by 2002:adf:e8d1:0:b0:317:6513:da7e with SMTP id k17-20020adfe8d1000000b003176513da7emr10547455wrn.36.1700140390889;
        Thu, 16 Nov 2023 05:13:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:eaed:bc6a:fc25:5159? ([2a01:e0a:982:cbb0:eaed:bc6a:fc25:5159])
        by smtp.gmail.com with ESMTPSA id v2-20020adfa1c2000000b0032fc5f5abafsm13698387wrv.96.2023.11.16.05.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 05:13:10 -0800 (PST)
Message-ID: <45cf3bc2-e63e-4a4e-a310-90bb2230e1bc@linaro.org>
Date:   Thu, 16 Nov 2023 14:13:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] mfd: rk8xx: register devices again with
 PLATFORM_DEVID_NONE
Content-Language: en-US, fr
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        Adam Green <greena88@gmail.com>
References: <20231116-topic-amlogic-upstream-fix-rk8xx-devid-auto-v1-1-75fa43575ab7@linaro.org>
 <20231116113505.ay4kihy3u32smhbm@mercury.elektranox.org>
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
In-Reply-To: <20231116113505.ay4kihy3u32smhbm@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/11/2023 12:35, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Nov 16, 2023 at 09:53:05AM +0100, Neil Armstrong wrote:
>> Since commit 210f418f8ace ("mfd: rk8xx: Add rk806 support"), devices are
>> registered with "0" as id, causing devices to not have an automatic device id
>> and prevents having multiple RK8xx PMICs on the same system.
> 
> They are not registered with "0" as ID - they are registered without
> any ID at all, because their cells have PLATFORM_DEVID_NONE.
> 
>> This fixes a regression while booting the Odroid Go Ultra on v6.6.1:
>> sysfs: cannot create duplicate filename '/bus/platform/devices/rk808-clkout'
> 
> ^ which you can see here. There is no ".0" suffix at the end of the
> sysfs path.
> 
>> CPU: 3 PID: 97 Comm: kworker/u12:2 Not tainted 6.6.1 #1
>> Hardware name: Hardkernel ODROID-GO-Ultra (DT)
>> Workqueue: events_unbound deferred_probe_work_func
>> Call trace:
>> dump_backtrace+0x9c/0x11c
>> show_stack+0x18/0x24
>> dump_stack_lvl+0x78/0xc4
>> dump_stack+0x18/0x24
>> sysfs_warn_dup+0x64/0x80
>> sysfs_do_create_link_sd+0xf0/0xf8
>> sysfs_create_link+0x20/0x40
>> bus_add_device+0x114/0x160
>> device_add+0x3f0/0x7cc
>> platform_device_add+0x180/0x270
>> mfd_add_device+0x390/0x4a8
>> devm_mfd_add_devices+0xb0/0x150
>> rk8xx_probe+0x26c/0x410
>> rk8xx_i2c_probe+0x64/0x98
>> i2c_device_probe+0x104/0x2e8
>> really_probe+0x184/0x3c8
>> __driver_probe_device+0x7c/0x16c
>> driver_probe_device+0x3c/0x10c
>> __device_attach_driver+0xbc/0x158
>> bus_for_each_drv+0x80/0xdc
>> __device_attach+0x9c/0x1ac
>> device_initial_probe+0x14/0x20
>> bus_probe_device+0xac/0xb0
>> deferred_probe_work_func+0xa0/0xf4
>> process_one_work+0x1bc/0x378
>> worker_thread+0x1dc/0x3d4
>> kthread+0x104/0x118
>> ret_from_fork+0x10/0x20
>> rk8xx-i2c 0-001c: error -EEXIST: failed to add MFD devices
>> rk8xx-i2c: probe of 0-001c failed with error -17
>>
>> Fixes: 210f418f8ace ("mfd: rk8xx: Add rk806 support")
>> Reported-by: Adam Green <greena88@gmail.com>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>> Lee, This is only a fix for the regression, as discussed with Sebastian at [1],
>> the driver would require some more cleanup to cleanly register all devices with
>> PLATFORM_DEVID_AUTO. I plan to send this later on.
>>
>> [1] https://lore.kernel.org/all/20231115180050.5r5xukttz27vviyi@mercury.elektranox.org/
> 
> NAK, this would break rk806. You can use PLATFORM_DEVID_AUTO instead,
> since that has special handling in devm_mfd_add_devices and will
> ignore the PLATFORM_DEVID_NONE specified by the cells.

You're right, I was preparing the patch cleanup and it's clear it will
break rk806 because I just saw you specifically added PLATFORM_DEVID_AUTO
to rk806 cells.

I'll send a v2.

Thanks,
Neil

> 
> Greetings,
> 
> -- Sebastian
> 
>> ---
>>   drivers/mfd/rk8xx-core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
>> index c47164a3ec1d..58d8dec7ac02 100644
>> --- a/drivers/mfd/rk8xx-core.c
>> +++ b/drivers/mfd/rk8xx-core.c
>> @@ -684,7 +684,7 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
>>   					     pre_init_reg[i].addr);
>>   	}
>>   
>> -	ret = devm_mfd_add_devices(dev, 0, cells, nr_cells, NULL, 0,
>> +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, cells, nr_cells, NULL, 0,
>>   			      regmap_irq_get_domain(rk808->irq_data));
>>   	if (ret)
>>   		return dev_err_probe(dev, ret, "failed to add MFD devices\n");
>>
>> ---
>> base-commit: f31817cbcf48d191faee7cebfb59197d2048cd64
>> change-id: 20231116-topic-amlogic-upstream-fix-rk8xx-devid-auto-59ce0d1b738a
>>
>> Best regards,
>> -- 
>> Neil Armstrong <neil.armstrong@linaro.org>
>>

