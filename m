Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95287AFAB6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjI0GHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjI0GHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:07:06 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51870DD;
        Tue, 26 Sep 2023 23:07:05 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4063da036c9so27074555e9.3;
        Tue, 26 Sep 2023 23:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695794824; x=1696399624;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ilGbwZbw+r63tsdGtSB6Sstf8G+rcZU4Qn42BZBqRc=;
        b=rYP0xqz2lLLe046yeVqADyqTD5GXoelOEPEeVSSJMv8v3nBLor8fBL4lSkDyMY7p1T
         bayQ6sy6x1dHZ9wWNCcSOPjkeTlibE3Ujnd9dcJ8MV9VwZlDo+GfmV4diSvl8+U73kJ+
         OkrJ3OSdJYPnIAB+4c6SE0l/jZwAxZ7ni1mysi1Cc1UrbvDRFC057cQX18aoyCJxIxF2
         tCZnok/s5frtBG2rMo0MzLyja1A0N9ZXgjpshYVJGf2BrYThaynqbLQGmtycesuV/zCY
         akW7XNQqKm+LFXszgHMWkpM5ZBaPpfEzVjIiNu8Hl1GqJgWbz9alY2yrebris+s5cvda
         PF1w==
X-Gm-Message-State: AOJu0YxyMcAVsZodtiFv0SIdpnaK4VyP0srvPX98dwfkwvlrDDUYfL7H
        41XZ2B41X+q2P80u+3zVz/o=
X-Google-Smtp-Source: AGHT+IExiuRhyetKklbMtnuZX3MinJL95Qxp7MaKxoC/O93bGilh4rCdS630ztVDycq2j5nYZI2SUg==
X-Received: by 2002:a05:600c:1587:b0:406:44fe:7621 with SMTP id r7-20020a05600c158700b0040644fe7621mr672176wmf.25.1695794823700;
        Tue, 26 Sep 2023 23:07:03 -0700 (PDT)
Received: from [192.168.86.246] (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b0040550c20cbcsm12015055wmo.24.2023.09.26.23.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 23:07:03 -0700 (PDT)
Message-ID: <bb37e3ec-d0b9-4b73-ac6e-183b55e8814f@linux.com>
Date:   Wed, 27 Sep 2023 07:07:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: Add gpio_intc node for Amlogic-T7 SoCs
Content-Language: en-US
To:     neil.armstrong@linaro.org, Huqiang Qin <huqiang.qin@amlogic.com>,
        tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, hkallweit1@gmail.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20230913080924.3336391-1-huqiang.qin@amlogic.com>
 <20230913080924.3336391-4-huqiang.qin@amlogic.com>
 <4c1566e0-a502-4379-b360-9e6ef374af04@linaro.org>
From:   Lucas Tanure <tanure@linux.com>
In-Reply-To: <4c1566e0-a502-4379-b360-9e6ef374af04@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-09-2023 09:26, neil.armstrong@linaro.org wrote:
> On 13/09/2023 10:09, Huqiang Qin wrote:
>> Add GPIO interrupt controller device.
>>
>> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
>> ---
>>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi 
>> b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
>> index dae3465bd39b..21b2436c47e2 100644
>> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
>> @@ -155,6 +155,16 @@ watchdog@2100 {
>>                   clocks = <&xtal>;
>>               };
>> +            gpio_intc: interrupt-controller@4080 {
>> +                compatible = "amlogic,t7-gpio-intc",
>> +                         "amlogic,meson-gpio-intc";
>> +                reg = <0x0 0x4080 0x0 0x20>;
>> +                interrupt-controller;
>> +                #interrupt-cells = <2>;
>> +                amlogic,channel-interrupts =
>> +                    <10 11 12 13 14 15 16 17 18 19 20 21>;
>> +            };
>> +
>>               uart_a: serial@78000 {
>>                   compatible = "amlogic,t7-uart", 
>> "amlogic,meson-s4-uart";
>>                   reg = <0x0 0x78000 0x0 0x18>;
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
I re-tested this today with Vim4 and works fine.
By works I mean, vim4 is able to boot without panics but drops to 
emergency shell as expected.

Tested-by: Lucas Tanure <tanure@linux.com>
