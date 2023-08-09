Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4DC776707
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjHISPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjHISPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:15:00 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F862100
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 11:14:59 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so2548386a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 11:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691604897; x=1692209697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o5aCxWlinyQcJkM+9Oa2MsH3kjFRE6iVNspKQ8+nH/g=;
        b=a0RkVZkjTomjJ1Zu4ERiqOKbNgEiYnJQLecWpiPTYExFLhhTnL0OKviRiQpYQZMgx0
         1VwXmsPW6LI7ufOqAI5aE2RyOArlYbljBShZX0sK5syNkk12iEm+3RaEotyNw2/uKWP/
         axl/4MBtCDPbCaEF6x4J5msxapMzTEO/rc6EGIJZNYLRFWXV6Ot10FOQcD5IxeaT+Ma0
         lTHFLj1MdY/Qs1Tx2pZanA03hLSTmpoIm0YVdAqgmWSJd/YwiNYtCCJCvsPu5AZFCPBW
         K6I6fP25NAVGz8N0wBPcomM3SR3CUY7kwkj8vgwyz7ui9UEZ7Egm1o2UcpnzR/fRIS5p
         HIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691604897; x=1692209697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5aCxWlinyQcJkM+9Oa2MsH3kjFRE6iVNspKQ8+nH/g=;
        b=XmjA+HRUY4y2IpWXWwZ/OuLVeQaeVA2ZLYa5reoou+p7BHqTsQ4PbqB4pfgwIuB+eQ
         EaFlxAFGrc+154PSrHstngwLyC70q603fuFTppwjZoJML1jVqL9dxyLNooGWPjV0q+iZ
         XAZeRCTOHD3lt2IVPZeWiKbPPdfz4G208Cijis/dqNcZMRHv4D7QkYDT5VL4/z6cmRkd
         ef0rOfBgPFEDPDKWq0tuyYCE4Rk58JyzHNEmBGO1JkgzokIFrILXyqUOi69dgwQQxqzk
         aiuwlT4RU61vYROpJIr9QMalzqkVV5vEgfzToI+1nME4TIm3liHEl9I3rKSbsmcv48HP
         QPOQ==
X-Gm-Message-State: AOJu0Yx7b/lP1TuOaTa2KkUPjKOJA4MWrPpvM4DJG7tBRb96QlXLmlt4
        qUZCEmU2pTAV2hENLOwfcCQcWQ==
X-Google-Smtp-Source: AGHT+IHsxlXjaIw6U/rG9TFR0w5BMU/zulMhVwKH0f2tyNmMTtv3K/zB0R5LrsUba6Js2JJDxSJGSQ==
X-Received: by 2002:a17:906:31ca:b0:99b:4d3d:c9b7 with SMTP id f10-20020a17090631ca00b0099b4d3dc9b7mr184259ejf.31.1691604897370;
        Wed, 09 Aug 2023 11:14:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id v8-20020a170906180800b009934855d8f1sm8359001eje.34.2023.08.09.11.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 11:14:56 -0700 (PDT)
Message-ID: <3939bd56-d57d-173e-da78-297ce607f9bc@linaro.org>
Date:   Wed, 9 Aug 2023 20:14:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 4/4] iio: adc: mcp3911: add support for the whole
 MCP39xx family
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230808110432.240773-1-marcus.folkesson@gmail.com>
 <20230808110432.240773-4-marcus.folkesson@gmail.com>
 <ZNJP6xpOvRJigtMx@smile.fi.intel.com> <ZNM1AYMB3RGRWp7C@gmail.com>
 <20230809190257.67602e55@jic23-huawei>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230809190257.67602e55@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 20:02, Jonathan Cameron wrote:
> On Wed, 9 Aug 2023 08:41:05 +0200
> Marcus Folkesson <marcus.folkesson@gmail.com> wrote:
> 
>>> ...
>>>   
>>>> +#define MCP3910_OFFCAL(x)		(MCP3910_REG_OFFCAL_CH0 + x * 6)  
>>>
>>> Inconsistent macro implementation, i.e. you need to use (x).  
>>
>> Sorry, I do not get you
>>
>>
>> [...]
>>
>>>> +static int mcp3910_get_osr(struct mcp3911 *adc, int *val)
>>>> +{
>>>> +	int ret, osr;  
>>>
>>> Strictly speaking osr can't be negative, otherwise it's a UB below.
>>>
>>> 	u32 osr = FIELD_GET(MCP3910_CONFIG0_OSR, *val);
>>> 	int ret;
>>>
>>> and why val is int?  
>>
>> I will change val to u32 for *_get_osr(), *_set_osr() and *_set_scale().
>>
>> [...]
>>
>>>> +	if (device_property_read_bool(&adc->spi->dev, "microchip,data-ready-hiz"))  
>>>
>>> This also becomes shorter.
>>>
>>> One trick to make it even shorter:
>>>
>>> 	if (device_property_present(dev, "microchip,data-ready-hiz"))  
>>
>> Thank you, I wasn't aware of device_property_present().
> 
> I know the read_bool function is direct equivalent of this but where a property
> is a flag, it feels more natural to me to check it with that one.
> read_present() feels more appropriate for where you want to know a more
> complex property is present.
> 
> Doesn't matter that much either way however so up to you.

For the OF, of_property_read_bool() is indeed preferred. Is there
device-xxx() equivalent?

Best regards,
Krzysztof

