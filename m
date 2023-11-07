Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2349B7E4762
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343756AbjKGRpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbjKGRpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:45:09 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C20110D7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 09:45:07 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5437d60fb7aso10055525a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 09:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699379106; x=1699983906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ILUIzwGAmI1ZGqr+mNktROdUm42J2cs6GtRudtdLn1E=;
        b=k6//Xuk7EFxONKIWFXKIhqD4lS6yflujqs6eb/A0d9TVQ+qhvd0VMXbWNtQZ8WmEzQ
         YgALl56qVYGnGpQ0jCH+sXKdUktIIpq0OnCBLUVSi4eFtkR4ncFw14uxyX8HkaqUoUyZ
         Fvp9YvrOl9cP9MjfRNuMZRoOzBi/y2NTDDH+XDfwfv1kPI7qIhvWlVQTyhrzfhTQmP41
         b56XCMgxGc0XR+AF3UWBCxZy7pRE4F2IlePbgoHe4+wM9k9cFKhyRZmBTRUtwVpo9/BJ
         c+aMOQxpuauUDuj2pvFqSjp7fwqs991Y8OVM+zDwmXUgs+w1R2xTnvKk+n9OHohNrcVN
         eiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699379106; x=1699983906;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ILUIzwGAmI1ZGqr+mNktROdUm42J2cs6GtRudtdLn1E=;
        b=XHbtx2HPCbNRbgNz+RqcBWVNtj7NU8lvrp1nHenl5yrd16p2tkgde10smbESPHHyUK
         h7BlNGpYu8XEWByx3/ZOZBMn9xmBbU4/9E5NAOJXcRQiScQgdVrrxHhezKDE7lHcd1yi
         /JotMbCqVIjswjqzUjgl9X4XdoHLbQ+qeoht/39ysWtGxmq+J1qS2NiOx1pJ+EShkkBx
         ZDS/ZBM3QlKAYmwCPnPe9mErdyTtyPQX2yUiBenBdU2BWQPxZjhhwt8hhpsGPiMgsUoj
         7ckP1CVx+Yo44XqBE+drit4ONjvBRyCo9td2uj0Ye2w9lG0N6AR8CPVtDaynaHsdhJUs
         Ai6w==
X-Gm-Message-State: AOJu0Yzw2EXI9y9ZdaT25nxQDrMdIDp6uU5hv0foJPZEubDq/pgKSeBU
        VLYFYsGlOOBSokbMkmTslz29tA==
X-Google-Smtp-Source: AGHT+IFKDLQKbTn7D5fZTBdaWJNTm4HkaW0LdlsOEsJrS4CxylI8TwfduuE4pveznNmb6DhIWPmxRw==
X-Received: by 2002:a17:907:6d27:b0:9ba:2fe3:c97e with SMTP id sa39-20020a1709076d2700b009ba2fe3c97emr15896949ejc.11.1699379105480;
        Tue, 07 Nov 2023 09:45:05 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id ox11-20020a170907100b00b009dd949b75c7sm1288243ejb.151.2023.11.07.09.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 09:45:05 -0800 (PST)
Message-ID: <d82865bc-29a7-4150-876e-489e0d797699@linaro.org>
Date:   Tue, 7 Nov 2023 18:45:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] reset: rockchip: secure reset must be used by SCMI
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Corentin Labbe <clabbe@baylibre.com>, davem@davemloft.net,
        herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, sboyd@kernel.org
Cc:     ricardo@pardini.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20231107155532.3747113-1-clabbe@baylibre.com>
 <20231107155532.3747113-6-clabbe@baylibre.com>
 <f1b24f19-c210-4f55-b40f-ab063e7eeb22@linaro.org> <11278271.CDJkKcVGEf@diego>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <11278271.CDJkKcVGEf@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2023 18:35, Heiko Stübner wrote:
> Am Dienstag, 7. November 2023, 17:21:41 CET schrieb Krzysztof Kozlowski:
>> On 07/11/2023 16:55, Corentin Labbe wrote:
>>> While working on the rk3588 crypto driver, I loose lot of time
>>> understanding why resetting the IP failed.
>>> This is due to RK3588_SECURECRU_RESET_OFFSET being in the secure world,
>>> so impossible to operate on it from the kernel.
>>> All resets in this block must be handled via SCMI call.
>>>
>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>> ---
>>>  drivers/clk/rockchip/rst-rk3588.c             | 42 ------------
>>>  .../dt-bindings/reset/rockchip,rk3588-cru.h   | 68 +++++++++----------
>>
>> Please run scripts/checkpatch.pl and fix reported warnings. Some
>> warnings can be ignored, but the code here looks like it needs a fix.
>> Feel free to get in touch if the warning is not clear.
>>
>>>  2 files changed, 34 insertions(+), 76 deletions(-)
>>>
>>> diff --git a/drivers/clk/rockchip/rst-rk3588.c b/drivers/clk/rockchip/rst-rk3588.c
>>> index e855bb8d5413..6556d9d3c7ab 100644
>>> --- a/drivers/clk/rockchip/rst-rk3588.c
>>> +++ b/drivers/clk/rockchip/rst-rk3588.c
>>> @@ -16,9 +16,6 @@
>>>  /* 0xFD7C8000 + 0x0A00 */
>>>  #define RK3588_PHPTOPCRU_RESET_OFFSET(id, reg, bit) [id] = (0x8000*4 + reg * 16 + bit)
>>>  
>>> -/* 0xFD7D0000 + 0x0A00 */
>>> -#define RK3588_SECURECRU_RESET_OFFSET(id, reg, bit) [id] = (0x10000*4 + reg * 16 + bit)
>>> -
>>>  /* 0xFD7F0000 + 0x0A00 */
>>>  #define RK3588_PMU1CRU_RESET_OFFSET(id, reg, bit) [id] = (0x30000*4 + reg * 16 + bit)
>>>  
>>> @@ -806,45 +803,6 @@ static const int rk3588_register_offset[] = {
>>>  	RK3588_PMU1CRU_RESET_OFFSET(SRST_P_PMU0IOC, 5, 4),
>>>  	RK3588_PMU1CRU_RESET_OFFSET(SRST_P_GPIO0, 5, 5),
>>>  	RK3588_PMU1CRU_RESET_OFFSET(SRST_GPIO0, 5, 6),
>>> -
>>> -	/* SECURECRU_SOFTRST_CON00 */
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_A_SECURE_NS_BIU, 0, 10),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_SECURE_NS_BIU, 0, 11),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_A_SECURE_S_BIU, 0, 12),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_SECURE_S_BIU, 0, 13),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_P_SECURE_S_BIU, 0, 14),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_CRYPTO_CORE, 0, 15),
>>> -
>>> -	/* SECURECRU_SOFTRST_CON01 */
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_CRYPTO_PKA, 1, 0),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_CRYPTO_RNG, 1, 1),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_A_CRYPTO, 1, 2),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_CRYPTO, 1, 3),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_KEYLADDER_CORE, 1, 9),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_KEYLADDER_RNG, 1, 10),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_A_KEYLADDER, 1, 11),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_KEYLADDER, 1, 12),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_P_OTPC_S, 1, 13),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_OTPC_S, 1, 14),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_WDT_S, 1, 15),
>>> -
>>> -	/* SECURECRU_SOFTRST_CON02 */
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_T_WDT_S, 2, 0),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_BOOTROM, 2, 1),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_A_DCF, 2, 2),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_P_DCF, 2, 3),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_BOOTROM_NS, 2, 5),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_P_KEYLADDER, 2, 14),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_TRNG_S, 2, 15),
>>> -
>>> -	/* SECURECRU_SOFTRST_CON03 */
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_TRNG_NS, 3, 0),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_D_SDMMC_BUFFER, 3, 1),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_SDMMC, 3, 2),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_SDMMC_BUFFER, 3, 3),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_SDMMC, 3, 4),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_P_TRNG_CHK, 3, 5),
>>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_TRNG_S, 3, 6),
>>>  };
>>>  
>>>  void rk3588_rst_init(struct device_node *np, void __iomem *reg_base)
>>> diff --git a/include/dt-bindings/reset/rockchip,rk3588-cru.h b/include/dt-bindings/reset/rockchip,rk3588-cru.h
>>> index d4264db2a07f..c0d08ae78cd5 100644
>>> --- a/include/dt-bindings/reset/rockchip,rk3588-cru.h
>>> +++ b/include/dt-bindings/reset/rockchip,rk3588-cru.h
>>> @@ -716,39 +716,39 @@
>>>  #define SRST_P_GPIO0			627
>>>  #define SRST_GPIO0			628
>>>  
>>> -#define SRST_A_SECURE_NS_BIU		629
>>> -#define SRST_H_SECURE_NS_BIU		630
>>> -#define SRST_A_SECURE_S_BIU		631
>>> -#define SRST_H_SECURE_S_BIU		632
>>> -#define SRST_P_SECURE_S_BIU		633
>>> -#define SRST_CRYPTO_CORE		634
>>> -
>>> -#define SRST_CRYPTO_PKA			635
>>> -#define SRST_CRYPTO_RNG			636
>>> -#define SRST_A_CRYPTO			637
>>> -#define SRST_H_CRYPTO			638
>>> -#define SRST_KEYLADDER_CORE		639
>>> -#define SRST_KEYLADDER_RNG		640
>>> -#define SRST_A_KEYLADDER		641
>>> -#define SRST_H_KEYLADDER		642
>>> -#define SRST_P_OTPC_S			643
>>> -#define SRST_OTPC_S			644
>>> -#define SRST_WDT_S			645
>>> -
>>> -#define SRST_T_WDT_S			646
>>> -#define SRST_H_BOOTROM			647
>>> -#define SRST_A_DCF			648
>>> -#define SRST_P_DCF			649
>>> -#define SRST_H_BOOTROM_NS		650
>>> -#define SRST_P_KEYLADDER		651
>>> -#define SRST_H_TRNG_S			652
>>> -
>>> -#define SRST_H_TRNG_NS			653
>>> -#define SRST_D_SDMMC_BUFFER		654
>>> -#define SRST_H_SDMMC			655
>>> -#define SRST_H_SDMMC_BUFFER		656
>>> -#define SRST_SDMMC			657
>>> -#define SRST_P_TRNG_CHK			658
>>> -#define SRST_TRNG_S			659
>>> +#define SRST_A_SECURE_NS_BIU		10
>>
>> NAK. You just broke all users.
> 
> If I'm reading the commit message correctly, all resets in that area
> couldn't have any users to begin with, as the registers controlling them
> are in the secure space, and need a higher exception level
> 
> So if  anything is trying to handle these resets, would end up with some
> security exception right now.
> 
> Though I guess we might want to use different names and not reuse the
> existing ones. scmi clocks use a SCMI_CLK_* id scheme, so maybe SCMI_SRST_* ?

I don't quite get what the patch wants to achieve. Why dropping driver
support for given reset ID is connected with changing the value of
binding for given reset?

What is the point of this define SRST_A_SECURE_NS_BIU 10?

Best regards,
Krzysztof

