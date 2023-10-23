Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7877D3A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjJWPTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjJWPTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:19:00 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB5CE8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:18:56 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so51214071fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698074335; x=1698679135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1MLGwaWl3ZChj/jIuzuUz8ORV4VhUnXGKItCTv8F9w=;
        b=xdVSdIfMyUwRv/7v20t9Vdlx7Li3MMJtzxOO4G8hai1L67qPTHI3GiHCS+Lfph0XGK
         iDhdUYpTtgqLkjAAZcdMfaq6x5Wv2xuZLZb3wYshElI8mXt6F6RllRts2KTjAXQSVYM0
         vuAoW8SQ1QMkL2HOHZ14fCTI/YR1ZejLnnoWpulJvfkMdeqOTR7cb+qYEO81Ui0Ym8/P
         fD1JfNCh6lpplmrHkntzwHQ9wUz0mkKPI2qBg3fOBgiT10IePhldYT/50x6L0WCfWpFA
         GubgPvAL28q2IvdC1EkU9GxDdmAQAHLfK0pQzx7EIlYhArEqNzQ4M19ljGYrEjcS7DRS
         VVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698074335; x=1698679135;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P1MLGwaWl3ZChj/jIuzuUz8ORV4VhUnXGKItCTv8F9w=;
        b=hrxtATUdSr2Au8pAiSrcavdQTaewfVP621ymq1uI2gxVKlLHQEWzxYOrAUJiRs1zMI
         I4BNCcUk52rIlvWZbGOziUGTMB7gtFOEYfZwjVRJhyhJpp4irx/zY+vAgXqWhhRb/3ou
         XAksrBINBb+Ux5pXd2f0sYYX80MpjGLtKAFCEaz2Z/+bPnDEpYv/XpjsMSCvNiy1DIn6
         iFS2e1jF9jXzlEk+KnNUeqEMnpKBDU29QLYwjjKbCLTj5Y/4qVHnrKjsWYlB6DdI/T6z
         wAaPwk85lNiuMFSnK7yicUPIEEAdCZAdfbgGecdVbRbx43xrI00ebPyKK5qYfQHN7rVG
         IHtA==
X-Gm-Message-State: AOJu0Yz6LKbSzDb9p2nU8WLdinruJdSjtKm8SS1ywK0knBO94Efs4WKI
        6g4f+fQZteTyT3Xhc37I2dPcag==
X-Google-Smtp-Source: AGHT+IHB0J8y26HcqtTde0NBv2OOmtsa7H7+Log3XwhbM1zJ1Us50QS4+6dcdbGMQW98onusyJX6dQ==
X-Received: by 2002:a2e:b4ba:0:b0:2c0:18b8:9656 with SMTP id q26-20020a2eb4ba000000b002c018b89656mr6038735ljm.24.1698074334662;
        Mon, 23 Oct 2023 08:18:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a36e:a5d9:26ae:74b1? ([2a01:e0a:982:cbb0:a36e:a5d9:26ae:74b1])
        by smtp.gmail.com with ESMTPSA id t22-20020a05600c41d600b004083996dad8sm14241695wmh.18.2023.10.23.08.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 08:18:54 -0700 (PDT)
Message-ID: <05ef5179-3233-4294-99e1-220454c5c81f@linaro.org>
Date:   Mon, 23 Oct 2023 17:18:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v10 0/4] Input: add initial support for Goodix Berlin
 touchscreen IC
Content-Language: en-US, fr
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
References: <20231023-topic-goodix-berlin-upstream-initial-v10-0-59066cf1f56f@linaro.org>
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
In-Reply-To: <20231023-topic-goodix-berlin-upstream-initial-v10-0-59066cf1f56f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please ignore this cover letter, gmail's SMTP returned an error while sending it
but still sent it....

The properly sent patchset can be found at:
https://lore.kernel.org/all/20231023-topic-goodix-berlin-upstream-initial-v10-0-88eec2e51c0b@linaro.org/

Neil

On 23/10/2023 17:03, Neil Armstrong wrote:
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
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v10:
> - Fix according to Dmitry's review:
>   - move goodix_berlin_get_ic_info() afe_data to heap
>   - merge the goodix_berlin_parse_finger() loops and skip invalid fingers instead of returning
>   - remove unwanted goodix_berlin_touch_handler() "static" for buffer
>   - only call goodix_berlin_request_handle_reset() if gpio was provided
>   - use "error = func(); if(error) return error;" instead of "return func()" when function handles multiple error cases
> - Link to v9: https://lore.kernel.org/r/20231021-topic-goodix-berlin-upstream-initial-v9-0-13fb4e887156@linaro.org
> 
> Changes in v9:
> - Rebased on next-20231020
> - Link to v8: https://lore.kernel.org/r/20231003-topic-goodix-berlin-upstream-initial-v8-0-171606102ed6@linaro.org
> 
> Changes in v8:
> - Add missing bitfield.h include in core
> - Link to v7: https://lore.kernel.org/r/20231002-topic-goodix-berlin-upstream-initial-v7-0-792fb91f5e88@linaro.org
> 
> Changes in v7:
> - rebased on v6.6-rc3
> - Link to v6: https://lore.kernel.org/r/20230912-topic-goodix-berlin-upstream-initial-v6-0-b4ecfa49fb9d@linaro.org
> 
> Changes in v6:
> - rebased on v6.6-rc1
> - changed commit message prefix to match the other Input commits
> - Link to v5: https://lore.kernel.org/r/20230801-topic-goodix-berlin-upstream-initial-v5-0-079252935593@linaro.org
> 
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
>        Input: add core support for Goodix Berlin Touchscreen IC
>        Input: goodix-berlin - add I2C support for Goodix Berlin Touchscreen IC
>        Input: goodix-berlin - add SPI support for Goodix Berlin Touchscreen IC
> 
>   .../bindings/input/touchscreen/goodix,gt9916.yaml  |  95 ++++
>   drivers/input/touchscreen/Kconfig                  |  31 ++
>   drivers/input/touchscreen/Makefile                 |   3 +
>   drivers/input/touchscreen/goodix_berlin.h          | 159 ++++++
>   drivers/input/touchscreen/goodix_berlin_core.c     | 594 +++++++++++++++++++++
>   drivers/input/touchscreen/goodix_berlin_i2c.c      |  74 +++
>   drivers/input/touchscreen/goodix_berlin_spi.c      | 177 ++++++
>   7 files changed, 1133 insertions(+)
> ---
> base-commit: 2030579113a1b1b5bfd7ff24c0852847836d8fd1
> change-id: 20230606-topic-goodix-berlin-upstream-initial-ba97e8ec8f4c
> 
> Best regards,

