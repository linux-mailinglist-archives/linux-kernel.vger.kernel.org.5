Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE0F76913D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjGaJPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjGaJPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:15:08 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02421F3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:15:06 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe24b794e5so1823625e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690794904; x=1691399704;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lsmJTHkFvalyswMhqHMmOlhHGvbnj9h6zOsNHQsTX5g=;
        b=V+mpUgkirwP3reN4Gc9UtUO8z96h7uKyTI6JcPloSkfE1g7Asx/d+0t8pRUtVb82ZH
         K8gm3wV0e20iJNVihkJCn1vMU48nhepx9rFF4Dj2CNYe3ZmeoPIj54NvQZAFySCINixo
         yBTtPFhC+RlRPITL1GE13OZa2+x0+Uk6BhTnuiBdPdHzh+e/tWVKX1uwr/Rv+0C2CBD1
         KzlfP+58jRZUiektF1AO+mx/A/Ds61f5yk7OBh4+zIGeY7d+wX8S8IVApf7ck2fWb6LX
         hu7WuEw1Pv83apHKcJ8u42LrqMkr/XIwExoIWoO2BkLrOALIeljUpId+WXxJmpA1lDG8
         41ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690794904; x=1691399704;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lsmJTHkFvalyswMhqHMmOlhHGvbnj9h6zOsNHQsTX5g=;
        b=SSpu6xuH9xw2EXIQIVgW458vmaeuZUrNanKPciRcp+TsT09LgefA6cx6CGyDTl8D0X
         EzxRU3LaRN1NNCV7EZDr0RagMPzaEMnM9/LQl1eNXBySRQQXQpPrsmuHl09pPhndNfvG
         +kTHnakvKhaqF8t2x6IroKrxgYj8TmcLJXS0Wu7y8HhEf3xpiodLQnEZnqhD5gNmUMj7
         U787lvRK9e8ziOPkyWkjZXyHuLdm0DeKWaxBGJA8LhdhOl4lhBIiU3JiVsUa9lAKaddb
         Op639k5I/vNbq8p1qlcGu/O8MidIMr5oHvl30i6wHFt3Hp6XOPRwy17amJnx6FVCytGD
         9njQ==
X-Gm-Message-State: ABy/qLaORd40z68tYq+ySFbrMs/KSy79CP26aSMJXfpoe6Crbk5XRZ8Z
        fWrPFXd60ITXe4mDd560aHDbzQ==
X-Google-Smtp-Source: APBJJlEkler0TgLc/iMDSwbwqS0e4hF80bV864dwxS2txwciA9RxZEpLiwFVYZW7BnUqUgj4zAMiLQ==
X-Received: by 2002:a05:600c:2053:b0:3fe:1dad:5403 with SMTP id p19-20020a05600c205300b003fe1dad5403mr2004591wmg.23.1690794904422;
        Mon, 31 Jul 2023 02:15:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d? ([2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d])
        by smtp.gmail.com with ESMTPSA id c13-20020a05600c0acd00b003fe1fe56202sm2888938wmr.33.2023.07.31.02.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 02:15:03 -0700 (PDT)
Message-ID: <fd94578b-da5f-6820-8a56-6fba5d34b9d5@linaro.org>
Date:   Mon, 31 Jul 2023 11:15:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 0/4] input: touchscreen: add initial support for Goodix
 Berlin touchscreen IC
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20230606-topic-goodix-berlin-upstream-initial-v4-0-0947c489be17@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230606-topic-goodix-berlin-upstream-initial-v4-0-0947c489be17@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29/06/2023 11:27, Neil Armstrong wrote:
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
> 
> [1] https://github.com/goodix/goodix_ts_berlin
> [2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers

Gentle ping,

Should I send a v5 rebased on linux-next ?

Thanks,
Neil

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
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
> base-commit: 6db29e14f4fb7bce9eb5290288e71b05c2b0d118
> change-id: 20230606-topic-goodix-berlin-upstream-initial-ba97e8ec8f4c
> 
> Best regards,

