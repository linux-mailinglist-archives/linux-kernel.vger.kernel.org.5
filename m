Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CD77575D8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjGRH5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjGRH5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:57:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68101731
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:56:59 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-992dcae74e0so741530366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689667018; x=1692259018;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j2mqKS21xBBL3zXrGxkLzWPef1bfANHcgljJaPtyzwU=;
        b=NKVNVbSckCvKGu0R0gppl9879OSOLjK0QBshjeArkJbgy01VI80E4ELIEbae215ANi
         mlgqB12E4Fo6xQNJRtM36yFXDtWXCOKWxa6H5eUVxm9udkLeWJiS7LQ1Nm04DbMZ0rg5
         cYua6GM/+FQeZOjvuI7QLV7lj3Lutt+6PdiFNio2Vu5zcEABUD1PIxuyPB4EeNSujQbJ
         kevbs/nBsPBMNvd+Ggn9Si+9c0yna5jTsVAdkOyE76Vjny3tXJE7Jv2Wlb+7vg3JZCcv
         PDoyzNASsfa3aRZ8gXyq7l66lVxk+rAN0+Q4CK1V6xGjIJQd1I/x+lpEsf32dU+2cOqJ
         c62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689667018; x=1692259018;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2mqKS21xBBL3zXrGxkLzWPef1bfANHcgljJaPtyzwU=;
        b=VDF7L9RQ9tRyb/jM5M1Ob5LgD6ftKw10iSfvQMqs1sdC4y3Lo1sFT+Mpfh76KeHSKA
         GvmFwiyjodTXWQly4wW3JNm+tbT1knJXsLFWww+0Tgd8mr4WzDmGy8b6WpQVs6y2vmho
         APP0u70Zc7kYO2/bdCkL+SjYm2HRusLQJevMj0/wR3ZOSi1KKreFBRFwWjpoO+xGxPj4
         WYfVZ+BLnv285wQraYfUjzCpSFRMn0xMrkLDd+WzA1EbnO0jwo8lbw5v/p1n6rQzd58L
         MPLV6URC15u5Wh8Obts48+RJL18IOhk8Jge3lrDT/nAti6a+faBbqsFkeq+xQZ467OdX
         ONXg==
X-Gm-Message-State: ABy/qLbU9sV8V+PJ+ZcghLviCGOMyCZg8PLvxYVdmkmAgoeX22tMUUtS
        MTYIpQA4ecNVWpHQhmDHSmKJdg==
X-Google-Smtp-Source: APBJJlHcVq7zSEK4BPdjL4HH9uIjX0xE3a8mSTjRnUA7ZqdPtwY+Rn4WkWqqCMKZQzwPF27zs9aTzA==
X-Received: by 2002:a17:907:3d90:b0:997:d975:64eb with SMTP id he16-20020a1709073d9000b00997d97564ebmr1408272ejc.35.1689667017838;
        Tue, 18 Jul 2023 00:56:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id gx19-20020a170906f1d300b0099275c59bc9sm684299ejb.33.2023.07.18.00.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 00:56:57 -0700 (PDT)
Message-ID: <81285b87-866e-198c-b32c-f09a0d3e9d24@linaro.org>
Date:   Tue, 18 Jul 2023 09:56:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] usb: dwc2: add new compatible for Intel SoCFPGA Stratix10
 platform
Content-Language: en-US
To:     "Li, Meng" <Meng.Li@windriver.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230718030851.2014306-1-Meng.Li@windriver.com>
 <78b06bf0-ab71-acdf-5799-1f6d849e7ead@linaro.org>
 <PH0PR11MB519187156E9F27AA52C87063F138A@PH0PR11MB5191.namprd11.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PH0PR11MB519187156E9F27AA52C87063F138A@PH0PR11MB5191.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 09:43, Li, Meng wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Tuesday, July 18, 2023 2:11 PM
>> To: Li, Meng <Meng.Li@windriver.com>; dinguyen@kernel.org;
>> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>> devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] usb: dwc2: add new compatible for Intel SoCFPGA Stratix10
>> platform
>>
>> CAUTION: This email comes from a non Wind River email account!
>> Do not click links or open attachments unless you recognize the sender and
>> know the content is safe.
>>
>> On 18/07/2023 05:08, Meng Li wrote:
>>> Intel Stratix10 is very the same with Agilex platform, the DWC2 IP on
>>> the Stratix platform also does not support clock-gating. The commit
>>> 3d8d3504d233("usb: dwc2: Add platform specific data for Intel's
>>> Agilex") had fixed this issue. So, add the essential compatible to
>>> also use the specific data on Stratix10 platform.
>>>
>>> Signed-off-by: Meng Li <Meng.Li@windriver.com>
>>> ---
>>>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
>>> b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
>>> index ea788a920eab..b8dd5509c214 100644
>>> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
>>> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
>>> @@ -490,7 +490,7 @@ usbphy0: usbphy@0 {
>>>               };
>>>
>>>               usb0: usb@ffb00000 {
>>> -                     compatible = "snps,dwc2";
>>> +                     compatible = "intel,socfpga-agilex-hsotg",
>>> + "snps,dwc2";
>>
>> You miss SoC specific compatible.
>>
> 
> Sorry! I don't understand what do you mean about SoC specific compatible.
> I think agilex is the soc specific.
> Could you please show your example?

But this is stratix.

rk3128.dtsi

Or many other devices in Linux kernel.

Best regards,
Krzysztof

