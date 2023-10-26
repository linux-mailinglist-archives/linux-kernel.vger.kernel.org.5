Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C807D829B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344919AbjJZM13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjJZM11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:27:27 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB36193
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:27:25 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507b18cf2e1so1096709e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698323244; x=1698928044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0P71wVS48La4jPQi6tVCrTZ6bHsJV48oqbwPiJ0ir8=;
        b=i0VU0Q49MxXZaymYGujsfz0vwzMVzGcYp7zWMKjmPpl4gcssfStUjjlwLvgk2CE3mB
         10AnmZMGtP1ceYW+mv6DsQNCsepyI759cCDdHduxrZto8l8+ECpM7ckiTQJPJ4MCrPYV
         cEIhT4yXRzPav6pI/54CfyqCTOYkEWSGzJ+oo33ksw4wvb9nkmtdNmYyc3fhOeQPt7M+
         DCrBgrURK7bsk1fRVwp+X9SIRC9QTWdRge4o4i3l7Milhz0ZQeTFahyzQGmHNnMELM7Q
         jhBm+o2QNcHjt05TosktuRtC60UXfnUOwSk+CRoPsXcTT6a4I5BM4A4d92KM4bozb1oR
         A2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698323244; x=1698928044;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H0P71wVS48La4jPQi6tVCrTZ6bHsJV48oqbwPiJ0ir8=;
        b=OLI8F8vWMbzD2KfFAUuMm6sShctUYiMVMc2vbOvZQ6wGf7RvcD0JQV0wLA42V0sEz6
         0ihvPwDhEM38oCWkugz+WLISPPcsqPra366hKuvivZCmFi26KybhcvsSHkbT9Sp0oXoe
         maipsVCA4yE9VqqGhdhpJpc2HOJAI2YYBXdR3i//68koUy3a8UolVH8YUp5UiNzt3lyq
         91Oye+4TYMQPmDSnHTFH7LONCFOlEsrPxpfifMQUyJsINpkgcW0Atqz6H/UeTANKHUyM
         h+Wm/463Uy4fSA5PsthNVzN1antWqKgMa/6ZPhNtONNNuyD4M17CwRXQv4kmHT4WAHT3
         wV7Q==
X-Gm-Message-State: AOJu0Yw/o9Y+q8elA6mEc02fs0y1wIS5axgw/yQWQUxIqm3DvMjYYUL8
        qdksNYGhcEKjJ9tg/0yRI0Fr2Q==
X-Google-Smtp-Source: AGHT+IEEmdwW+QLsNrn6w7xcamSTlEPh/aCQ9HPZZqWMpOGzQKV/c/f1WbC/70g14sO/MG0eoyVgKQ==
X-Received: by 2002:ac2:5337:0:b0:505:72bf:43a4 with SMTP id f23-20020ac25337000000b0050572bf43a4mr13167156lfh.39.1698323243561;
        Thu, 26 Oct 2023 05:27:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f57f:eb08:d29b:8c9c? ([2a01:e0a:982:cbb0:f57f:eb08:d29b:8c9c])
        by smtp.gmail.com with ESMTPSA id e8-20020adffc48000000b0031c5e9c2ed7sm11264703wrs.92.2023.10.26.05.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 05:27:22 -0700 (PDT)
Message-ID: <afb778da-ec0a-4451-b853-4b1eba14a68a@linaro.org>
Date:   Thu, 26 Oct 2023 14:27:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 08/10] clk: qcom: add the SM8650 Display Clock Controller
 driver
Content-Language: en-US, fr
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231025-topic-sm8650-upstream-clocks-v1-0-c89b59594caf@linaro.org>
 <20231025-topic-sm8650-upstream-clocks-v1-8-c89b59594caf@linaro.org>
 <a939ef1a4c2cad763fe484cc943f44d5.sboyd@kernel.org>
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
In-Reply-To: <a939ef1a4c2cad763fe484cc943f44d5.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2023 23:45, Stephen Boyd wrote:
> Quoting Neil Armstrong (2023-10-25 00:32:45)
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index c04b6526f4f3..5bf25e8d033c 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -842,6 +842,15 @@ config SM_DISPCC_8550
>>            Say Y if you want to support display devices and functionality such as
>>            splash screen.
>>   
>> +config SM_DISPCC_8650
>> +       tristate "SM8650 Display Clock Controller"
>> +       depends on SM_GCC_8650
> 
> selects?
> 
> We use selects instead of depends so that the driver can be built-in or
> modular regardless of parent clks that provide clks to this device.
> Orphan clk handling resolves issues with the driver registering clks
> before parents. And with fw_devlink the driver isn't even attempted to
> probe before the GCC driver is probed so there's no build dependency
> between these drivers.

All current DISPCC entries uses depends, but CAM_CC doesn't,
I'll switch to select and re-sync Kconfig for all 8650 entries.

> 
>> +       help
>> +         Support for the display clock controller on Qualcomm Technologies, Inc
>> +         SM8650 devices.
>> +         Say Y if you want to support display devices and functionality such as
>> +         splash screen.
>> +
>>   config SM_GCC_4450
>>          tristate "SM4450 Global Clock Controller"
>>          depends on ARM64 || COMPILE_TEST
>> diff --git a/drivers/clk/qcom/dispcc-sm8650.c b/drivers/clk/qcom/dispcc-sm8650.c
>> new file mode 100644
>> index 000000000000..7cb91306e895
>> --- /dev/null
>> +++ b/drivers/clk/qcom/dispcc-sm8650.c
>> @@ -0,0 +1,1806 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023, Linaro Ltd.
>> + */
>> +
>> +#include <linux/clk.h>
> 
> Is this include used?
> 
>> +#include <linux/clk-provider.h>
>> +#include <linux/err.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
> 
> Is this mod_devicetable.h?
> 
>> +#include <linux/of.h>
> 
> Is this include used?
> 
>> +#include <linux/regmap.h>
>> +#include <linux/pm_runtime.h>
>> +
>> +#include <dt-bindings/clock/qcom,sm8650-dispcc.h>
>> +
>> +#include "common.h"
>> +#include "clk-alpha-pll.h"
>> +#include "clk-branch.h"
>> +#include "clk-pll.h"
>> +#include "clk-rcg.h"
>> +#include "clk-regmap.h"
>> +#include "clk-regmap-divider.h"
>> +#include "clk-regmap-mux.h"
> 
> Is this include used?
> 
>> +#include "reset.h"
>> +#include "gdsc.h"
>> +

Did a include cleanup aswell on all drivers.

Thanks,
Neil

