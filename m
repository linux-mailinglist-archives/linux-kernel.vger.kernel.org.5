Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CB77EDD02
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 09:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344958AbjKPIlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 03:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjKPIlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 03:41:11 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED58BD41
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 00:41:06 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4083f613272so4619495e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 00:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700124065; x=1700728865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5hniODu6j01bbuESP6Z8fITScn6cg4zb+KdTZ5eQC+A=;
        b=gO0MyIsyJX+LK3/NXqxfEoubGWA8ZgDxkNsK+qMKUluQGoCti2Pb5vj+8dHfpEyZgQ
         DwmMaYO0Gd7zDlqNYh2bEvs5vja4OYCJ3qeft/oRKyb4Pn9YZmwrML063huzfadbOmg2
         qHJ5ySNu2r1z5UQmbvefrp9WH8/aZ2klL/UEb2npLkXiAIgBX/EwUHNhdxN7eFPPbfmN
         KMq89kNhlAnMjt3j4VO7uKuj/ZGY6/S2nKHC2rYxZQieUAlWFBRTkXO/2HFRz3HSh5t8
         7ePnjP/muYeJS+ff1KUFyoWzrzT/Wu82BY7lQmps1mDCGgtSTEvMZNgonXVvXUHcKy1l
         Q4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700124065; x=1700728865;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5hniODu6j01bbuESP6Z8fITScn6cg4zb+KdTZ5eQC+A=;
        b=OFjWZVkDg+uhJbYww+jEufdV+JyOcwG6V35TypDZEpDS+M2TM5Ypn7wP3qGCfMKxny
         HRB3odPE5LnZGrjTuDcxVvU99U0zQY2558poPBpHAM5qdo5ODmK2xx4lQnzKbimKCkrm
         XqNFLaCEgEMXzMeo0z8HEelS9knLx6mp4VzEUi6DUUu8R7nvX+60RKVKNpxQkce58l1f
         3NELW6hj3WPVtGudDYEvE3hO6UBaOS5V5ZWeDBWGPRxVQx/PderSXOumSaBHBwdiLBvd
         rL/eRVL2Spr9mQa0Ik25hbcgx1NNYxbjFz6dX6cJM+VN3VTRJfmo4HUYyoLECo01MikC
         2YRg==
X-Gm-Message-State: AOJu0Yyru6fCKIzwiXB2RdlRkm5kcftxB2IJIB9O9IhiGEHFKFb5idlD
        3VhsojizpIwmfOODMj0TTmNMYQ==
X-Google-Smtp-Source: AGHT+IEbqKjc9pBdKDJPIAE2x0mP6MrzoeK8GDVpuk7vcRIpt529YfQbm64Em7Utuj56L3deAnstTg==
X-Received: by 2002:a05:600c:202:b0:404:4b6f:d705 with SMTP id 2-20020a05600c020200b004044b6fd705mr12740802wmi.17.1700124065303;
        Thu, 16 Nov 2023 00:41:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:eaed:bc6a:fc25:5159? ([2a01:e0a:982:cbb0:eaed:bc6a:fc25:5159])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b0040588d85b3asm2617051wmq.15.2023.11.16.00.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 00:41:04 -0800 (PST)
Message-ID: <0ba99820-ada8-4a42-af99-3b57f585bec8@linaro.org>
Date:   Thu, 16 Nov 2023 09:41:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v8 08/14] mfd: rk8xx: add rk806 support
Content-Language: en-US, fr
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Diederik de Haas <didi.debian@cknow.org>,
        Vincent Legoll <vincent.legoll@gmail.com>
References: <20230504173618.142075-1-sebastian.reichel@collabora.com>
 <20230504173618.142075-9-sebastian.reichel@collabora.com>
 <e612cef3-3bb6-46b7-a2c9-53fffc20c819@linaro.org>
 <20231115180050.5r5xukttz27vviyi@mercury.elektranox.org>
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
In-Reply-To: <20231115180050.5r5xukttz27vviyi@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/11/2023 19:00, Sebastian Reichel wrote:
> Hi Neil,
> 
> On Wed, Nov 15, 2023 at 06:17:50PM +0100, Neil Armstrong wrote:
>> Hi Sebastian,
>>
>> On 04/05/2023 19:36, Sebastian Reichel wrote:
>>> Add support for SPI connected rk806, which is used by the RK3588
>>> evaluation boards. The PMIC is advertised to support I2C and SPI,
>>> but the evaluation boards all use SPI. Thus only SPI support is
>>> added here.
>>>
>>> Acked-for-MFD-by: Lee Jones <lee@kernel.org>
>>> Tested-by: Diederik de Haas <didi.debian@cknow.org> # Rock64, Quartz64 Model A + B
>>> Tested-by: Vincent Legoll <vincent.legoll@gmail.com> # Pine64 QuartzPro64
>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>>> ---
>>>    drivers/mfd/Kconfig       |  14 ++
>>>    drivers/mfd/Makefile      |   1 +
>>>    drivers/mfd/rk8xx-core.c  |  69 ++++++-
>>>    drivers/mfd/rk8xx-spi.c   | 124 ++++++++++++
>>>    include/linux/mfd/rk808.h | 409 ++++++++++++++++++++++++++++++++++++++
>>>    5 files changed, 614 insertions(+), 3 deletions(-)
>>>    create mode 100644 drivers/mfd/rk8xx-spi.c
>>>
>>
>> <snip>
>>
>>> -	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
>>> -			      cells, nr_cells, NULL, 0,
>>> +	ret = devm_mfd_add_devices(dev, 0, cells, nr_cells, NULL, 0,
>>>    			      regmap_irq_get_domain(rk808->irq_data));
>>
>> It seems you replaced PLATFORM_DEVID_NONE by 0, triggering again the bug preventing
>> having multiples RK pmics on the same system I fixed earlier at [1].
> 
> All cells have PLATFORM_DEVID_NONE specified and thus are registered
> without an ID. I changed this bit to avoid overriding the
> information, since I did not want to have PLATFORM_DEVID_NONE for
> rk806.
> 
>> This gives (again):
>> <4>[ 0.664107] sysfs: cannot create duplicate filename '/bus/platform/devices/rk808-clkout'
> 
> Which means, you do not want PLATFORM_DEVID_NONE (-1), but
> PLATFORM_DEVID_AUTO (-2). The above path is the expected path
> for PLATFORM_DEVID_NONE.
> 
>> <4>[ 0.664120] CPU: 3 PID: 97 Comm: kworker/u12:2 Not tainted 6.6.1 #1
>> <4>[ 0.664131] Hardware name: Hardkernel ODROID-GO-Ultra (DT)
>> <4>[ 0.664139] Workqueue: events_unbound deferred_probe_work_func
>> <4>[ 0.664160] Call trace:
>> <4>[ 0.664165] dump_backtrace+0x9c/0x11c
>> <4>[ 0.664181] show_stack+0x18/0x24
>> <4>[ 0.664193] dump_stack_lvl+0x78/0xc4
>> <4>[ 0.664205] dump_stack+0x18/0x24
>> <4>[ 0.664215] sysfs_warn_dup+0x64/0x80
>> <4>[ 0.664227] sysfs_do_create_link_sd+0xf0/0xf8
>> <4>[ 0.664239] sysfs_create_link+0x20/0x40
>> <4>[ 0.664250] bus_add_device+0x114/0x160
>> <4>[ 0.664259] device_add+0x3f0/0x7cc
>> <4>[ 0.664267] platform_device_add+0x180/0x270
>> <4>[ 0.664278] mfd_add_device+0x390/0x4a8
>> <4>[ 0.664290] devm_mfd_add_devices+0xb0/0x150
>> <4>[ 0.664301] rk8xx_probe+0x26c/0x410
>> <4>[ 0.664312] rk8xx_i2c_probe+0x64/0x98
>> <4>[ 0.664323] i2c_device_probe+0x104/0x2e8
>> <4>[ 0.664333] really_probe+0x184/0x3c8
>> <4>[ 0.664342] __driver_probe_device+0x7c/0x16c
>> <4>[ 0.664351] driver_probe_device+0x3c/0x10c
>> <4>[ 0.664360] __device_attach_driver+0xbc/0x158
>> <4>[ 0.664369] bus_for_each_drv+0x80/0xdc
>> <4>[ 0.664377] __device_attach+0x9c/0x1ac
>> <4>[ 0.664386] device_initial_probe+0x14/0x20
>> <4>[ 0.664395] bus_probe_device+0xac/0xb0
>> <4>[ 0.664403] deferred_probe_work_func+0xa0/0xf4
>> <4>[ 0.664412] process_one_work+0x1bc/0x378
>> <4>[ 0.664421] worker_thread+0x1dc/0x3d4
>> <4>[ 0.664429] kthread+0x104/0x118
>> <4>[ 0.664440] ret_from_fork+0x10/0x20
>> <3>[ 0.664494] rk8xx-i2c 0-001c: error -EEXIST: failed to add MFD devices
>> <4>[ 0.666769] rk8xx-i2c: probe of 0-001c failed with error -17
> 
> I didn't notice when working on rk806, but after analyzing it now:
> 
> Your patch effectively set the cells to PLATFORM_DEVID_AUTO, because
> you set all cells to PLATFORM_DEVID_NONE (-1) and additionally used
> PLATFORM_DEVID_NONE (-1) for the devm_mfd_add_devices() call. But
> that uses the sum of both IDs. Adding -1 to -1 is -2 and thus
> PLATFORM_DEVID_AUTO. This is of course very confusing and just
> worked by chance. There are two options:
> 
> 1. Modify all cells to use PLATFORM_DEVID_AUTO instead of
> PLATFORM_DEVID_NONE
> 2. Drop the .id from all cells and use PLATFORM_DEVID_AUTO in the
> call to devm_mfd_add_devices()
> 
> Note, that switching from PLATFORM_DEVID_NONE to PLATFORM_DEVID_AUTO
> modifies sysfs paths and thus might break people's scripts; that's why
> I tried not to modify any existing platform. I will let you deal
> with that, since I cannot even test any !rk806 platform supported by
> this driver :)

Yes it will modify sysfs path, but it's a regression since this before this patch
everything was registered with PLATFORM_DEVID_AUTO anyway,
so I'll provide a fix adding back PLATFORM_DEVID_NONE to devm_mfd_add_devices
in a first time...

> 
> Also mfd_add_device should probably get special handling for
> PLATFORM_DEVID_NONE, just like it already has special handling
> for PLATFORM_DEVID_AUTO.

... and yes thanks for the great analysis I'll provide a change cleaning the mess.

Thanks,
Neil

> 
> Greetings,
> 
> -- Sebastian

