Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D407E7E3E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344858AbjKJRmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjKJRlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:41:39 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6755A3A230;
        Fri, 10 Nov 2023 07:13:05 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6d261cb07dcso1258061a34.3;
        Fri, 10 Nov 2023 07:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699629184; x=1700233984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uVDypX2FHMLEYAo/wmOnUp9dzR8vVVSP2/7xQKtOce0=;
        b=XSi9mx9XFK2lHldSeygi8UJT5/UQwH4tmHpC4Iqc9xTPZ1aNvEKTrMrpWYP+mWalyL
         84ml1BeZOF7NwDgNQr/dQh6bTU0sSGDr2o2NTHDCFl3e7jbtyrufU6b7Wk3LoPwEVAMq
         fdWXtp34r9/zmHG3ymmhcY9uCLRmSZLOGnugMT5fDnO+FSht+9t6mvT+VhKgTxsL8Af7
         1F68ODFaPsXzpRgwHUjmCPyPwnSTpaAqSYrpGaNHgn/3RD3qe4OaED6lLllZFI3XTCjW
         G3f06hZBw0r/UV3/huf0SD8xPnwG95uaBFs0tcA9/UX3UmnT0z9CgAg2Fbjl5gBMlhUD
         wDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699629184; x=1700233984;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVDypX2FHMLEYAo/wmOnUp9dzR8vVVSP2/7xQKtOce0=;
        b=lH2KjhIbIxqPGaFpOUpyAhzWX+Q1amGDdkunOJU3/mIfNi4qO8zB38f4xc//dv7PzH
         w5jvKKkmhoKM1nnx/pY7XIyCcR5O9B3mMR1bN8O7OeUho+hpZd9P/S9ffwsxXm2rbWpo
         ZHfJhpCcHEpDnfCb/OUTb/OQ6Xl7xOfQLvpcp8JfLdsjfQLr8V6xYskwtdAFHpeu3pFy
         bZRtujoGvoO0aw/Fj6yeI0o/AW0hrAvVDJqMjCPdK0X5y2p1w4erF+ZeTCoIopTNO78o
         gDc6TxmVRtUu07gEnPiTC+8GTe02xkE7u0Nzl6je2NBhxjQXvLX5uJx1fhFyCvxiNktF
         chiA==
X-Gm-Message-State: AOJu0YxT7858zaN0q65/6J0eluNrrXWojbzHan2eQR3ly6UWs6yNCyzU
        K1c350m4qgDD6+FjEmm9WUoClnfeMxs=
X-Google-Smtp-Source: AGHT+IHw8EI8qT2P8geBeuCeR5v1TS+FXGbNtYjBwkZnXdfsGMiyEKS/jeO58EAhzeKHvYCSIWYBMA==
X-Received: by 2002:a9d:5d17:0:b0:6c4:e507:3747 with SMTP id b23-20020a9d5d17000000b006c4e5073747mr8128513oti.30.1699629184433;
        Fri, 10 Nov 2023 07:13:04 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g3-20020ad45423000000b00670c7fd09cbsm2972112qvt.95.2023.11.10.07.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 07:13:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <47733364-82b5-4052-9bb9-7631668c98a0@roeck-us.net>
Date:   Fri, 10 Nov 2023 07:13:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] watchdog: mediatek: mt7988: add wdt support
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <6912f6f406bc45674020681184f3eeca2f2cb63f.1699576174.git.daniel@makrotopia.org>
 <ddb5b6ca88165aa69f73fe2804eedd0231d8d9e7.1699576174.git.daniel@makrotopia.org>
 <58b551f2-2d0b-4432-b1fd-edc690f13e4c@collabora.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <58b551f2-2d0b-4432-b1fd-edc690f13e4c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/23 03:55, AngeloGioacchino Del Regno wrote:
> Il 10/11/23 01:30, Daniel Golle ha scritto:
>> Add support for watchdog and reset generator unit of the MediaTek
>> MT7988 SoC.
>>
>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>> ---
>>   drivers/watchdog/mtk_wdt.c | 56 +++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 55 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
>> index b2330b16b497a..b98b8c29735aa 100644
>> --- a/drivers/watchdog/mtk_wdt.c
>> +++ b/drivers/watchdog/mtk_wdt.c
>> @@ -12,6 +12,7 @@
>>   #include <dt-bindings/reset/mt2712-resets.h>
>>   #include <dt-bindings/reset/mediatek,mt6795-resets.h>
>>   #include <dt-bindings/reset/mt7986-resets.h>
>> +#include <dt-bindings/reset/mediatek,mt7988-resets.h>
>>   #include <dt-bindings/reset/mt8183-resets.h>
>>   #include <dt-bindings/reset/mt8186-resets.h>
>>   #include <dt-bindings/reset/mt8188-resets.h>
>> @@ -58,6 +59,8 @@
>>   #define WDT_SWSYSRST        0x18U
>>   #define WDT_SWSYS_RST_KEY    0x88000000
>> +#define WDT_SWSYSRST_EN        0xfc
>> +
>>   #define DRV_NAME        "mtk-wdt"
>>   #define DRV_VERSION        "1.0"
>> @@ -71,44 +74,85 @@ struct mtk_wdt_dev {
>>       struct reset_controller_dev rcdev;
>>       bool disable_wdt_extrst;
>>       bool reset_by_toprgu;
>> +    bool has_swsysrst_en;
> 
> mtk_wdt_data is always a const and this has_swsysrst_en member is never supposed
> to change during runtime.
> 
> At this point, just add a pointer to struct mtk_wdt_data in mtk_wdt_dev, then
> instead of mtk_wdt->has_swsysrst_en you check mtk_wdt->pdata->has_swsysrst_en.
> 

Oh, I don't know. Personally I dislike having to execute double dereferences
at runtime. I tend to accept it because people seem to like it, but I really
don't see the point.

Guenter

