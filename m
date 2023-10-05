Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60277BA3C8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbjJEP6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbjJEP4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:56:50 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BC01FED9;
        Thu,  5 Oct 2023 03:07:01 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9b6559cbd74so148899466b.1;
        Thu, 05 Oct 2023 03:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696500420; x=1697105220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZhNCejINv/rvRMnwXFbkozy89uWTZdk6L4MDx6KXZ3M=;
        b=UcLbykxScrw5D1eskgwDNWoREKFPtLji+FLIErYXo/MJhBbqqT4w3QmjfNXztdREbj
         D1qPOVeU6KsJYOcjsaoKRVgWMEC3bzh0RAL5k89Gqh/RoWVAad/DZGtIgnh+OlwLrpzL
         imqtDXfLy3HkPlw/AizBUfJFzekL4WkZDnDwjxDTI0nzd9ryDVRT16X0EHPhnEbBKD41
         AjLu0F2i7kDdWWIPrHLorxmmqcRVrbP4sK7EUCmWTfry7odd0Z0Kc0KovYRKPJcCjCrq
         arQoitlwglF90Zo0zgVUJ8SGWGf7rddrywMHIryGCT0eSrMRJtbLbmiHStfbMr+DpVye
         x5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696500420; x=1697105220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhNCejINv/rvRMnwXFbkozy89uWTZdk6L4MDx6KXZ3M=;
        b=v0x1ygP28Sz8BdM108Z/O693PM7ApwzNDpkbIA7RXhNDGELJdb1dKrZMjjOT3SB3N3
         7g2TwM5m6baYkrpM1MXI++lLFzgUsQPMMkAxPfKzZyNNnMPt18CaMUKVHKDmVNAYlmUA
         fWSzPPgsXzxU93e6Xnr+gvUsEX5+s6kr8+RbqEVykogyDCXCKHF2hIJYDFT5uQcIaNEa
         jbqoTgoqwZxFXVuS2ZswelaaHf+3KZhrKpLTelEnGlOEH7gtGbu3eHLsG+X96PT0Lbp9
         ga/xj8bIhiUCUkV/IP/lPsNETmUexqH76z7SdrpN8ml18jlAOF0V5lwdVQcLT15wMSjc
         BExQ==
X-Gm-Message-State: AOJu0YyeqiM6dTuGRwoN01SwKS6w7Zp9JiloL+C+wrW4o8IPsewdfT+f
        SbhjJspD9Is940bc/aQRhuQUMD3elg==
X-Google-Smtp-Source: AGHT+IGtUzYRQnJzanS5pJVO4ZNw7dC55MP4rIku1b1FoShJe1HuVaSF4EtOHELw98Bx/KD+mJHU+g==
X-Received: by 2002:a17:906:220c:b0:9b8:a556:87a5 with SMTP id s12-20020a170906220c00b009b8a55687a5mr3963317ejs.22.1696500419691;
        Thu, 05 Oct 2023 03:06:59 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4300:8342:fd16:599d:c630? ([2a02:810b:f40:4300:8342:fd16:599d:c630])
        by smtp.gmail.com with ESMTPSA id q23-20020a17090622d700b009930308425csm915447eja.31.2023.10.05.03.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 03:06:59 -0700 (PDT)
Message-ID: <db6476ad-361c-427e-8f57-1ad51861b2ed@gmail.com>
Date:   Thu, 5 Oct 2023 12:06:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] ARM: dts: rockchip: Disable non-required timers
 for RK3128
To:     Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230829203721.281455-4-knaerzche@gmail.com>
 <20230829203721.281455-14-knaerzche@gmail.com>
 <101f3b88-7151-af5c-3bd4-feb13763228b@arm.com>
Content-Language: en-US
From:   Alex Bee <knaerzche@gmail.com>
In-Reply-To: <101f3b88-7151-af5c-3bd4-feb13763228b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin, Hi Heiko,

Am 30.08.23 um 20:17 schrieb Robin Murphy:
> On 2023-08-29 21:37, Alex Bee wrote:
>> The Rockchip timer linux driver can handle a maximum of 2 timers and 
>> will
>> get confused if more of them exist.
>
> Wouldn't it be better to fix that? It looks trivial to do, and frankly 
> it's a behaviour that doesn't make sense anyway. Of course a system 
> can have more hardware available than Linux wants to use; that's not 
> an error, it's just Linux's choice to not use it! See commit 
> a98399cbc1e0 ("clocksource/drivers/sp804: Avoid error on multiple 
> instances") for example.
>
> DTs shouldn't be treated like Linux board files, so curating them 
> around Linux-specific driver behaviour is inappropriate; FreeBSD or 
> U-Boot or whatever are perfectly entitled to make use of 5 timers at 
> once if they can.

That's fully true, thanks for the hint.

The common Rockchip workaround currently seems to be to just expose the 
timer(s) in the DT which can be handled by the linux driver.  RK3288, 
for instance, has 7 timers but there's a single one present in the SoC 
DT ... and another one is enabled in the common RK mach-code, .... ups

Anyway: I'll have a look in the RK timer driver and try to fix it. 
Though, I'm not sure if just ignoring the others like sp804 driver does 
is sufficient, as we still will have to add workarounds to the clock 
driver in order to keep the clocks enabled for those timers which are 
not used by linux, but are required (as source for the arm timer, for 
instance).

The dw_apb_timer driver seems to register the second timer as 
clocksource- and all others as clockevent-timers .... that looks like 
the "better" approach around that issue.

Regards,

Alex

>
> Thanks,
> Robin.
>
>> RK3128 only needs timer0, timer1 and timer5. The latter is the source
>> for the arm-timer and it's clock is prevented from being disabled in the
>> clock driver so it can get disabled in the device tree, too.
>>
>> Fixes: a0201bff6259 ("ARM: dts: rockchip: add rk3128 soc dtsi")
>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
>> ---
>>   arch/arm/boot/dts/rockchip/rk3128.dtsi | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi 
>> b/arch/arm/boot/dts/rockchip/rk3128.dtsi
>> index 88a4b0d6d928..f3f0788195d2 100644
>> --- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
>> +++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
>> @@ -252,6 +252,7 @@ timer2: timer@20044040 {
>>           interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
>>           clocks = <&cru PCLK_TIMER>, <&cru SCLK_TIMER2>;
>>           clock-names = "pclk", "timer";
>> +        status = "disabled";
>>       };
>>         timer3: timer@20044060 {
>> @@ -260,6 +261,7 @@ timer3: timer@20044060 {
>>           interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
>>           clocks = <&cru PCLK_TIMER>, <&cru SCLK_TIMER3>;
>>           clock-names = "pclk", "timer";
>> +        status = "disabled";
>>       };
>>         timer4: timer@20044080 {
>> @@ -268,6 +270,7 @@ timer4: timer@20044080 {
>>           interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
>>           clocks = <&cru PCLK_TIMER>, <&cru SCLK_TIMER4>;
>>           clock-names = "pclk", "timer";
>> +        status = "disabled";
>>       };
>>         timer5: timer@200440a0 {
>> @@ -276,6 +279,7 @@ timer5: timer@200440a0 {
>>           interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
>>           clocks = <&cru PCLK_TIMER>, <&cru SCLK_TIMER5>;
>>           clock-names = "pclk", "timer";
>> +        status = "disabled";
>>       };
>>         watchdog: watchdog@2004c000 {
