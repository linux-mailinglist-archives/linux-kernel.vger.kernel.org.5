Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541747846E4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237643AbjHVQTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236596AbjHVQTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:19:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4D319A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:19:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31c615eb6feso717284f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692721182; x=1693325982;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e2sK25pHmy+ze1Ybz8hn3pPQzDyrBRYa60rRH4NH4K4=;
        b=EIr1I4lkGWcsjJhSARAeppBKOlivRpYDEKnMMlMqc8br9LSs+W/8+ObH7xmN6/O8mB
         CEk9ec26vYMXxU1M0Zr1+kTvvkeZmB6JOxDu7UkvfMzIdWBopKpEGT8dmNjIKXwLj3ul
         0CnlGGh4HMrIMeFYK7IsgNeL+Wdx4zSePl15f3jdiSJQ7JTY/0aA15J4+gWF4xtgmpof
         Ufih+szZNwlgZIt/0sFRCPp/BnLx6oFpwqp5Yd5okz5ofoloAxIqdpzD2gXDf85q4xrY
         9gklxTxamFUMMpAmkJ5sL6ZAoETDIV1DpNJ++428Fmxc0gJ2bMTM6KW+xHOZmzlXDqVF
         Iotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692721182; x=1693325982;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e2sK25pHmy+ze1Ybz8hn3pPQzDyrBRYa60rRH4NH4K4=;
        b=QR0PbjffSUYRwXu8zitVnUtT6RXSc5OHIUGG8zAhucjRQtbypd6ERK07MFC47nKkLF
         UjZ9c2iA+uUyOdM0Aw986wmrxOsxxPbpn0DbgQRnh2p2Y70Lr1rkQQZYp4ZrMx4Wy81D
         QTki/XwAcyeNKzDmN8omFYd16BD1mf3IiyF5+EUBN15eeMxTKsH3fdbOp0swi1QGRFd0
         cKNwbAjrUi5L7B/icDKf4yBraewXG6W+0LnF2benyu3W1Ltj1fdKhkOJLEMe31ep680v
         on2rP8qZreWePK33urFLRsnWxv0mPd/kjSThIkQxBuusybNrYhTmio4S3wLRca3eExpj
         +q9g==
X-Gm-Message-State: AOJu0YyuuND6hYu6RFf41Ib+iy3O9YPWUYMcLKTk7Smh4+71e5Ij8UGC
        tsnDhIiJT8uzrbTVILgiQftcTA==
X-Google-Smtp-Source: AGHT+IFV2T7QA2Y8bKBQIemr3twqEOx//JFK9SnUvRdlu3ELv5Fb8pjW8G6OT+xALpwoMCsJaKtPYQ==
X-Received: by 2002:adf:e548:0:b0:317:5c82:10c5 with SMTP id z8-20020adfe548000000b003175c8210c5mr7196004wrm.17.1692721182281;
        Tue, 22 Aug 2023 09:19:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:de4a:6da8:c7fc:12c? ([2a01:e0a:cad:2140:de4a:6da8:c7fc:12c])
        by smtp.gmail.com with ESMTPSA id y17-20020a5d4ad1000000b0031984b370f2sm16289955wrs.47.2023.08.22.09.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 09:19:41 -0700 (PDT)
Message-ID: <36efbd0b-7f33-4c11-8e8e-f07bea4b3455@linaro.org>
Date:   Tue, 22 Aug 2023 18:19:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 0/4] input: touchscreen: add initial support for Goodix
 Berlin touchscreen IC
Content-Language: en-US, fr
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>
Cc:     linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
References: <20230801-topic-goodix-berlin-upstream-initial-v5-0-079252935593@linaro.org>
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
In-Reply-To: <20230801-topic-goodix-berlin-upstream-initial-v5-0-079252935593@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01/08/2023 14:15, Neil Armstrong wrote:
> These touchscreen ICs support SPI, I2C and I3C interface, up to
> 10 finger touch, stylus and gestures events.
> 
> This initial driver is derived from the Goodix goodix_ts_berlin
> available at [1] and [2] and only supports the GT9916 IC
> present on the Qualcomm SM8550 MTP & QRD touch panel.
> 
> The current implementation only supports BerlinD, aka GT9916.
> 
> Support for advanced features like:
> - Firmware & config update
> - Stylus events
> - Gestures events
> - Previous revisions support (BerlinA or BerlinB)
> is not included in current version.
> 
> The current support will work with currently flashed firmware
> and config, and bail out if firmware or config aren't flashed yet.


Gentle ping, is there any changes to be made in order to get this driver in ?

Thanks,
Neil

> 
> [1] https://github.com/goodix/goodix_ts_berlin
> [2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v5:
> - rebased on next-20230801
> - Link to v4: https://lore.kernel.org/r/20230606-topic-goodix-berlin-upstream-initial-v4-0-0947c489be17@linaro.org
> 
> Changes in v4:
> - Core updates:
>   - drop kconfig depends, deps will be handled by _SPI and _I2C
>   - change power_on() error labels
>   - print errors on all dev_err() prints
>   - remove useless default variable initialization
>   - switch irq touch checksum error to dev_err()
>   - add Jeff's review tag
> - I2C changes
>   - change REGMAP_I2C Kconfig from depends to select
>   - add Jeff's review tag
> - SPI changes
>   - add select REGMAP to Kconfig
>   - added GOODIX_BERLIN_ prefix to defines
>   - switched from ret to error
>   - add Jeff's review tag
> - Link to v3: https://lore.kernel.org/r/20230606-topic-goodix-berlin-upstream-initial-v3-0-f0577cead709@linaro.org
> 
> Changes in v3:
> - Another guge cleanups after Jeff's review:
>   - appended goodix_berlin_ before all defines
>   - removed some unused defines
>   - removed retries on most of read functions, can be added back later
>   - added __le to ic_info structures
>   - reworked and simplified irq handling, dropped enum and ts_event structs
>   - added struct for touch data
>   - simplified and cleaned goodix_berlin_check_checksum & goodix_berlin_is_dummy_data
>   - moved touch_data_addr to the end of the main code_data
>   - reworked probe to get_irq last and right before setip input device
>   - cleaned probe by removing the "cd->dev"
>   - added short paragraph to justify new driver for berlin devices
>   - defined all offsets & masks
> - Added bindings review tag
> - Link to v2: https://lore.kernel.org/r/20230606-topic-goodix-berlin-upstream-initial-v2-0-26bc8fe1e90e@linaro.org
> 
> Changes in v2:
> - Huge cleanups after Jeff's review:
>   - switch to error instead of ret
>   - drop dummy vendor/product ids
>   - drop unused defined/enums
>   - drop unused ic_info and only keep needes values
>   - cleanup namings and use goodix_berlin_ everywhere
>   - fix regulator setup
>   - fix default variables value when assigned afterwars
>   - removed indirections
>   - dropped debugfs
>   - cleaned input_dev setup
>   - dropped _remove()
>   - sync'ed i2c and spi drivers
> - fixed yaml bindings
> - Link to v1: https://lore.kernel.org/r/20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org
> 
> ---
> Neil Armstrong (4):
>        dt-bindings: input: document Goodix Berlin Touchscreen IC
>        input: touchscreen: add core support for Goodix Berlin Touchscreen IC
>        input: touchscreen: add I2C support for Goodix Berlin Touchscreen IC
>        input: touchscreen: add SPI support for Goodix Berlin Touchscreen IC
> 
>   .../bindings/input/touchscreen/goodix,gt9916.yaml  |  95 ++++
>   drivers/input/touchscreen/Kconfig                  |  31 ++
>   drivers/input/touchscreen/Makefile                 |   3 +
>   drivers/input/touchscreen/goodix_berlin.h          | 159 ++++++
>   drivers/input/touchscreen/goodix_berlin_core.c     | 581 +++++++++++++++++++++
>   drivers/input/touchscreen/goodix_berlin_i2c.c      |  69 +++
>   drivers/input/touchscreen/goodix_berlin_spi.c      | 173 ++++++
>   7 files changed, 1111 insertions(+)
> ---
> base-commit: a734662572708cf062e974f659ae50c24fc1ad17
> change-id: 20230606-topic-goodix-berlin-upstream-initial-ba97e8ec8f4c
> 
> Best regards,

