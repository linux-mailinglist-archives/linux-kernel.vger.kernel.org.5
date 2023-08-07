Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F2B772693
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbjHGNvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbjHGNvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:51:48 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1383A10DB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:51:47 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so9688453a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 06:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691416305; x=1692021105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5U7uXQPqJdJRTybbD7UWkq4hcpTzTPPBe48JRQK60d8=;
        b=siUwPP6TAI6SSnVRXaqAXAkU8Y+9KQFZNj8SGOBskXBIh5sKvzKy5gY3yyHBWgiERn
         bhmarSHyd6YFmvOXWtq7r29XxO6ht/vgMpJSHrL8LpRBWtOblDd1S2qDnQBiMvbYE0ig
         1m0no4m00eF9Cs8ietNs0mpAFHuFT8/OUqmSZgq10I0uJMOqax04L67CiRZK5pHAk+gT
         pDLWYzbvzWdq/b5se479A9NNUxiZxS2MM3+bApIBYpjn/K3kF0smFqXVoJLP5ta97b/Y
         z4//rrJqg3X35F14zrNDD7PWe3JNaHiEp3ezuFaSKEP7UQoLbUVonTYJmzsRLbPxKLfp
         ojPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691416305; x=1692021105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5U7uXQPqJdJRTybbD7UWkq4hcpTzTPPBe48JRQK60d8=;
        b=Xi8chxeKO+qyGJZfvNbDur4vrLxhRadfCA8LlkymKhbegVOYgs1ln3Nyo2E8LQGQ84
         KYrWaXZq22kcsbbirJfSP02ou/V/AjGXVZ3NDNDIGIoEvwOg6etHA/wTbmK+MGJqpwzo
         bh/ztY+2wq46Ga1D4SmmTjek65OxKx70A54doTkEB8RfPoKOJeKXC35B8gIzboEMXrX5
         Si5pMwDJLz365gRb/cO+IDRu5piNVYoNxJwrTwARKwaidtUUAwFIC1L3UuukrbakRCzp
         4brpY8LGuY+BDrwxnhLaAk/0CoJmwIg+W30G9pyARdINM4Ia/63xspTSYX/X3Ee10ikU
         IxHw==
X-Gm-Message-State: AOJu0YxtW09fXvpAfgb92VYYYJXH8PDiYGS40zIXVo2vi4Dz5rlj4P/m
        L/dlm5LY2IGGPIPLqs+dlqeyJQ==
X-Google-Smtp-Source: AGHT+IFHT60GM0SzX9TXq5wlvNhwlntdej2m89q9MKu3133qU0DChWx1leGNQ8gUg3hl1tGkiS5DKQ==
X-Received: by 2002:a05:6402:51d2:b0:521:ef0f:8ef9 with SMTP id r18-20020a05640251d200b00521ef0f8ef9mr8152852edd.19.1691416305604;
        Mon, 07 Aug 2023 06:51:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id e26-20020a50ec9a000000b0051873c201a0sm5195571edr.26.2023.08.07.06.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 06:51:45 -0700 (PDT)
Message-ID: <af8893b8-0556-e355-abe9-aba99c7a839a@linaro.org>
Date:   Mon, 7 Aug 2023 15:51:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 4/4] ARM: configs: s5pv210_defconfig: enable IIO
 required by MAX17040
Content-Language: en-US
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     Svyatoslav Ryhel <clamor95@gmail.com>,
        Iskren Chernev <me@iskren.info>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Stefan Hansson <newbie13xd@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20230731073613.10394-1-clamor95@gmail.com>
 <20230731073613.10394-5-clamor95@gmail.com>
 <20230805224211.qquexvseq24hxcju@intel.intel>
 <16047849-1001-4d6f-4995-0fdfc065cded@linaro.org>
 <20230807085543.3tfzpsa2joolay3r@intel.intel>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230807085543.3tfzpsa2joolay3r@intel.intel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 10:55, Andi Shyti wrote:
> Hi,
> 
> On Sun, Aug 06, 2023 at 10:29:04AM +0200, Krzysztof Kozlowski wrote:
>> On 06/08/2023 00:42, Andi Shyti wrote:
>>> Hi Svyatoslav,
>>>
>>> On Mon, Jul 31, 2023 at 10:36:13AM +0300, Svyatoslav Ryhel wrote:
>>>> After adding support for passing temperature data from thermal sensor
>>>> to MAX17040 it got dependency on CONFIG_IIO. From all defconfigs
>>>> using MAX17040 only s5pv210_defconfig did not have IIO already enabled
>>>> so let's enable it to avoid regression.
>>>>
>>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>>>> ---
>>>>  arch/arm/configs/s5pv210_defconfig | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
>>>> index 4c1e480b5bbd..24070ee3d43e 100644
>>>> --- a/arch/arm/configs/s5pv210_defconfig
>>>> +++ b/arch/arm/configs/s5pv210_defconfig
>>>> @@ -97,6 +97,7 @@ CONFIG_MMC_SDHCI_S3C_DMA=y
>>>>  CONFIG_RTC_CLASS=y
>>>>  CONFIG_RTC_DRV_MAX8998=m
>>>>  CONFIG_DMADEVICES=y
>>>> +CONFIG_IIO=y
>>>>  CONFIG_PWM=y
>>>>  CONFIG_PWM_SAMSUNG=y
>>>>  CONFIG_PHY_SAMSUNG_USB2=m
>>>
>>> Should this patch be squashed to the previous patch? I think you
>>> break bisectability for this board if you enable iio only here.
>>
>> The defconfig change matters less - distros don't use them - so this
>> points to the fact that patchset affected the users. All existing users
>> of max17040 drivers, who do not enable IIO, will have their setups broken.
> 
> That's why I'm suggesting to squash this patch with the previous.

It would not solve much. All existing users will be still broken.

> 
> Anyway, up to you... except of this note everything looks fine in
> the series.

I would actually prefer not to depend on IIO, but this would require
stubs for missing IIO functions.

Best regards,
Krzysztof

