Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FC27CE8DE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjJRU3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjJRU22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:28:28 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1984D4C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:28:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507bd19eac8so3482198e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697660896; x=1698265696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1IkfvvSOsBHtTtrxwDROKr8J2+syziWFNikOdZa81Lk=;
        b=mkWYfqQqjb878ItjeyYcPAoG0BJ3aTsas2sb2gwBo+WwhMWDee04ln5rcE4/DnhAPU
         mhroC/KttNdHg2mtZfRzMc7p5TSM6COHpUrTMTK4oIzvlPfNx7waf9NsOSxg8zgq6Pgt
         +O9IDirCWv2BLeMchjal9h8TKVLsa8j8CiWfqQLCqEp7sc6+FFXv9PyHJppX+igvLDZA
         qBMJ8GGgIzMeLJ6ovbHbtGEW8Uf21+dL8mtthYiRSL6AER8ohAmAcIioZ/n7XdfXXyE6
         oT+56kc47k9QJW6gFoVxTqkPI9qqWM6vXkbZVEKDgRoXtqQRXLwGztyv5JpcQ8AqtR+n
         e9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697660896; x=1698265696;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IkfvvSOsBHtTtrxwDROKr8J2+syziWFNikOdZa81Lk=;
        b=mjsqWkkFz0ZGgW+kN61LUBELzbb3Ul1i5pxQkYaQmICgPmG4OHVtgvQsVhHid1v/aJ
         AEQZ7Kkd7v3onaEkD4R9jVVXD/mLz6nb3nheRESiPFo17gY7n9tE/28Lsmu9jeUJVzs/
         f7nRVLJoEqB06y87PJyCueZhIsmjx+xKEyb1qzqfXMIPaa42RotTiq9ZNNMmtAauyhZX
         ulTPFkKSp1VBHHN3RCEeTfIRJUvzFSiwsvNEMr02pSaNT0ITVpxfNcNWaNnD6cbYRwuL
         S3y8W/Gz2oB+SiE6qoX9KT/N2jI7VcCant5SDJenHND6L2nbcpdOh4tvdRiKWKoPjeI/
         5ZZw==
X-Gm-Message-State: AOJu0Ywj8lZmm7pCScERcPARRU2QFPnSXciUr+7wnVMkUq+04U3gaM1o
        s9oy6PwX8iJDOzNpzZwtkzn/9A==
X-Google-Smtp-Source: AGHT+IG8XQIHxsr/RXLobSRarxMuGa2jh08MntDK4B5b0mJ7E/k80IR779VemDrdi8r7WBRejm78mw==
X-Received: by 2002:a19:f603:0:b0:500:b42f:1830 with SMTP id x3-20020a19f603000000b00500b42f1830mr46218lfe.63.1697660895733;
        Wed, 18 Oct 2023 13:28:15 -0700 (PDT)
Received: from [172.30.205.86] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id v12-20020ac2558c000000b00507aced147esm825302lfg.203.2023.10.18.13.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 13:28:15 -0700 (PDT)
Message-ID: <5ac0d16a-0303-46c7-a008-31280629cc11@linaro.org>
Date:   Wed, 18 Oct 2023 22:28:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: qcm6490-fairphone-fp5: Add PM7325
 thermals
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20231013-fp5-thermals-v1-0-f14df01922e6@fairphone.com>
 <20231013-fp5-thermals-v1-4-f14df01922e6@fairphone.com>
 <34da335e-cbcd-4dc2-8a86-f31369db1fcd@linaro.org>
 <4958673.31r3eYUQgx@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <4958673.31r3eYUQgx@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/14/23 19:52, Luca Weiss wrote:
> On Samstag, 14. Oktober 2023 01:13:29 CEST Konrad Dybcio wrote:
>> On 13.10.2023 10:09, Luca Weiss wrote:
>>> Configure the thermals for the QUIET_THERM, CAM_FLASH_THERM, MSM_THERM
>>> and RFC_CAM_THERM thermistors connected to PM7325.
>>>
>>> With this PMIC the software communication to the ADC is going through
>>> PMK7325 (= PMK8350).
>>>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>>
>>>   arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 117
>>>   +++++++++++++++++++++ 1 file changed, 117 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
>>> b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts index
>>> 2c01f799a6b2..d0b1e4e507ff 100644
>>> --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
>>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
>>> @@ -9,6 +9,7 @@
>>>
>>>   #define PM7250B_SID 8
>>>   #define PM7250B_SID1 9
>>>
>>> +#include <dt-bindings/iio/qcom,spmi-adc7-pm7325.h>
>>>
>>>   #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
>>>   #include <dt-bindings/leds/common.h>
>>>   #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>>>
>>> @@ -137,6 +138,20 @@ afvdd_2p8: regulator-afvdd-2p8 {
>>>
>>>   	};
>>>   	
>>>   	thermal-zones {
>>>
>>> +		camera-thermal {
>>> +			polling-delay-passive = <0>;
>>> +			polling-delay = <0>;
>>> +			thermal-sensors = <&pmk8350_adc_tm 2>;
>>> +
>>> +			trips {
>>> +				active-config0 {
>>> +					temperature = <125000>;
>>
>> are
>>
>>> +		rear-cam-thermal {
>>>
>>> +					temperature = <125000>;
>>
>> you
>>
>>> +		sdm-skin-thermal {
>>>
>>> +					temperature = <125000>;
>>
>> sure
>>
>> about these temps?
> 
> (email from my other address, quicker right now)
> 
> Well yes and no.
> 
> Yes as in those are the temps specified in downstream dtb.
> No as in I'm 99% sure there's user space with definitely lower threshold that
> actually does something in response to the temps.
> 
> I didn't look too much into this but does the kernel even do something when it
> hits one of these trip points? I assume when there's a cooling device thing
> specified then it can actually tell the driver to do something, but without
> (and most drivers don't support this?) I'm assuming the kernel can't do much
> anyways?
> 
> So e.g. when the temperature for the flash led is reached I'm assuming
> downstream (+Android) either dims the led or turns it off? But I'd have to dig
> quite a bit into the thermal setup there to check what it's really doing.
I think reaching "critical" shuts down the platform, unless something
registering the thermal zone explicitly overrides the behavior.

> 
> But for now I think it's okay to put this current thermal config into dts and
> we'll improve it later when 1. I understand more and 2. maybe some useful
> drivers support the cooling bits?
Yeah it's better than nothing, but ultimately we should probably move
the values that userspace daemon operates on here in the dt..

Konrad
