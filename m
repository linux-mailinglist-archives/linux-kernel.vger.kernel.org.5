Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DB18038A9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbjLDPXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbjLDPXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:23:24 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CEDF0;
        Mon,  4 Dec 2023 07:23:29 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54bfa9b3ffaso5891059a12.1;
        Mon, 04 Dec 2023 07:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701703408; x=1702308208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mxYp/TPj2SDljkx7akhBocUojf/1bHbrDV2kmdKcuiw=;
        b=jOWQ+NVgcA55mkrS1YmqfA6St67vuu1Sci23Ov0LAmtm7JCw3n72rwwNXa1QH8xBu2
         6zH+DW9Psuo44vmLIEjCxVl94tGIwYrhUMq4n79IUflTELifgWsckVZ2eVLpiuE/vICK
         V1jbzkp2UTv6d+KtgxOrqgWKk30LMQs6o2/6L6GyeMh1A88KwMKzLdV9mzh6gBvYWkYN
         HR+3BUbI/uLUv8SN+qZ847+oaoF81p11naoaaxlwCELmNuwAxfvGoaIfflaEU4d8hbB1
         O4hvsywb/8yXENsAEQG1H/pwFp4g10uObgB8qHaXTltCyL2/piFfDW8pxo+EF3yMhKa7
         4dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701703408; x=1702308208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mxYp/TPj2SDljkx7akhBocUojf/1bHbrDV2kmdKcuiw=;
        b=gNFTfbx8mZfS3eZM7Hw3RHYQ370c/gBhOlcrBWCKSndsW56mLpY7Pri+02MwatpIAs
         WNjNu4P118zuS6hzG5bSdeUvzX90wE3Yp9+OAvZokp0XKUUsPf1vGGjpaG7/C1/HKctv
         xC1iLHTFnzFRt6fivFrcs+o0LHfJkth09yZGF+ZF9bHA2gC2vXjely69C3vHIcm7k4pO
         bZxPrGcdmk8cfXswaf2wb5TrNqRenNbxoH62kZWeLmyEeSMyufokEGB/xPrkHK4LYjEW
         mynRkBNKflfaj8X+SrFEzvJ5yz48DGLHrBvbzsRbImBbBOKna9yDEg8w9jIBkQcmyM2Y
         1qhA==
X-Gm-Message-State: AOJu0YyqhSpimtX6YCV+T8Tkrh27bo0CcdwJ2kUCjHdvTezZ8jEqI/Hv
        WrrPHigh00mo3VxWuoGTzA==
X-Google-Smtp-Source: AGHT+IH6NaMxB0hD8p+w4THyQqPHgLUhFhYRDIhCfbDi49ieB3DqkYaAbCCN/8DRLm52i+pnC1Tesg==
X-Received: by 2002:a17:907:2daa:b0:a19:a1ba:8cc2 with SMTP id gt42-20020a1709072daa00b00a19a1ba8cc2mr3994784ejc.96.1701703407956;
        Mon, 04 Dec 2023 07:23:27 -0800 (PST)
Received: from ?IPV6:2a02:810b:f40:4300:55ff:210b:5393:c9d7? ([2a02:810b:f40:4300:55ff:210b:5393:c9d7])
        by smtp.gmail.com with ESMTPSA id s7-20020a170906bc4700b00a0f78db91c3sm5416316ejv.95.2023.12.04.07.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 07:23:27 -0800 (PST)
Message-ID: <e58f5aa5-a4d4-4334-a7ff-aa139ec7166f@gmail.com>
Date:   Mon, 4 Dec 2023 16:23:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] ARM: dts: rockchip: Add power-controller for
 RK3128
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org
References: <20231202125144.66052-1-knaerzche@gmail.com>
 <4891026.6YUMPnJmAY@diego> <4dec2316-f840-44ab-a07a-3d7f0e5e6d8f@gmail.com>
 <9588573.jRhZ6ZUK3Y@diego>
Content-Language: en-US
From:   Alex Bee <knaerzche@gmail.com>
In-Reply-To: <9588573.jRhZ6ZUK3Y@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

Am 03.12.23 um 17:42 schrieb Heiko Stübner:
> Hi Alex,
>
> Am Sonntag, 3. Dezember 2023, 17:05:47 CET schrieb Alex Bee:
>> Am 02.12.23 um 18:46 schrieb Heiko Stübner:
>>> Am Samstag, 2. Dezember 2023, 17:36:15 CET schrieb Alex Bee:
>>>> Am 02.12.23 um 16:51 schrieb Heiko Stübner:
>>>>> Am Samstag, 2. Dezember 2023, 13:51:41 CET schrieb Alex Bee:
>>>>>> Add power controller and qos nodes for RK3128 in order to use
>>>>>> them as powerdomains.
>>>>> does the power-domain controller work with the incomplete set of
>>>>> pm-domains too?
>>>> Yes, it does - the missing domains can request idle only and can't be
>>>> powered on/off - if no one requests idle they are just up all the time.
>>>>
>>>>> What I have in mind is
>>>>> - adding the power-controller node with the existing set of power-domains
>>>>> - the gpu pm-domain is in there
>>>>> - adding the gpu parts
>>>> My main concern about adding them later was the change of the ABI after
>>>> they've been exposed in the SoC DT. If that's not an issue - sure: I can
>>>> add them in a separate series.
>>> An ABI change would be _changing_ the domain-ids in the rk3128-power.h
>>> I think :-) .
>> Well, an addition is still a change.
>>> Right now the existing domain ids in the header are already exposed to the
>>> world, so someone could already use them, but not the new ones.
>> I'm fully aware that nothing would ever hard fail anywhere if the new
>> domain ids get added later.
>>
>> Nevertheless we start using here an ABI which is known to be incomplete.
>> For no reason, as the patches (which I am now asked to remove from this
>> series) for completion are already there (here).
>>
>> Anyway, if you prefer it this way: I'm pleased to do so.
> I was more thinking of accelerating the gpu-part of the series, as that
> really is just waiting for the power-domain node that already has driver
> support and domain-ids present.
>
> It looks like you're feeling more strongly about that though, so I'll
> definitly not pressure you ;-) .

I'm really not insisting on this - I just didn't understand why you 
would want this. And honestly I haven't considered merging timeline as 
an argument.

So sure: Let's get the low hanging fruits merged for 6.8. Having the 
power domains in the DT will also help for my upcoming hdmi / vop series.

Alex

>
> But I guess the split into IDs and driver change should still be
> done, especially as the dt-binding-header likely will want an Ack
> from the DT maintainers.
>
> And the power-domain change will go through the new pmdomain
> subsystem.
>
>
> Heiko
>
>
>>>>> And a second series with
>>>>> - patch1 from here
>>>>> - a dts patch adding the additional pm-domains to rk3128.dtsi
>>>>> - I guess patch1 also should be split into a patch adding the binding-ids
>>>>>      and a separate patch for the code addition.
>>>> Yeah, I noticed this also :)
>>>>
>>>> Regards,
>>>>
>>>> Alex
>>>>
>>>>> Heiko
>>>>>
>>>>>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
>>>>>> ---
>>>>>>     arch/arm/boot/dts/rockchip/rk3128.dtsi | 101 +++++++++++++++++++++++++
>>>>>>     1 file changed, 101 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
>>>>>> index 4e8b38604ecd..b72905db04f7 100644
>>>>>> --- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
>>>>>> +++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
>>>>>> @@ -8,6 +8,7 @@
>>>>>>     #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>>>     #include <dt-bindings/interrupt-controller/irq.h>
>>>>>>     #include <dt-bindings/pinctrl/rockchip.h>
>>>>>> +#include <dt-bindings/power/rk3128-power.h>
>>>>>>     
>>>>>>     / {
>>>>>>     	compatible = "rockchip,rk3128";
>>>>>> @@ -133,6 +134,106 @@ smp-sram@0 {
>>>>>>     	pmu: syscon@100a0000 {
>>>>>>     		compatible = "rockchip,rk3128-pmu", "syscon", "simple-mfd";
>>>>>>     		reg = <0x100a0000 0x1000>;
>>>>>> +
>>>>>> +		power: power-controller {
>>>>>> +			compatible = "rockchip,rk3128-power-controller";
>>>>>> +			#power-domain-cells = <1>;
>>>>>> +			#address-cells = <1>;
>>>>>> +			#size-cells = <0>;
>>>>>> +
>>>>>> +			power-domain@RK3128_PD_VIO {
>>>>>> +				reg = <RK3128_PD_VIO>;
>>>>>> +				clocks = <&cru ACLK_CIF>,
>>>>>> +					 <&cru HCLK_CIF>,
>>>>>> +					 <&cru DCLK_EBC>,
>>>>>> +					 <&cru HCLK_EBC>,
>>>>>> +					 <&cru ACLK_IEP>,
>>>>>> +					 <&cru HCLK_IEP>,
>>>>>> +					 <&cru ACLK_LCDC0>,
>>>>>> +					 <&cru HCLK_LCDC0>,
>>>>>> +					 <&cru PCLK_MIPI>,
>>>>>> +					 <&cru ACLK_RGA>,
>>>>>> +					 <&cru HCLK_RGA>,
>>>>>> +					 <&cru ACLK_VIO0>,
>>>>>> +					 <&cru ACLK_VIO1>,
>>>>>> +					 <&cru HCLK_VIO>,
>>>>>> +					 <&cru HCLK_VIO_H2P>,
>>>>>> +					 <&cru DCLK_VOP>,
>>>>>> +					 <&cru SCLK_VOP>;
>>>>>> +				pm_qos = <&qos_ebc>,
>>>>>> +					 <&qos_iep>,
>>>>>> +					 <&qos_lcdc>,
>>>>>> +					 <&qos_rga>,
>>>>>> +					 <&qos_vip>;
>>>>>> +				#power-domain-cells = <0>;
>>>>>> +			};
>>>>>> +
>>>>>> +			power-domain@RK3128_PD_VIDEO {
>>>>>> +				reg = <RK3128_PD_VIDEO>;
>>>>>> +				clocks = <&cru ACLK_VDPU>,
>>>>>> +					 <&cru HCLK_VDPU>,
>>>>>> +					 <&cru ACLK_VEPU>,
>>>>>> +					 <&cru HCLK_VEPU>,
>>>>>> +					 <&cru SCLK_HEVC_CORE>;
>>>>>> +				pm_qos = <&qos_vpu>;
>>>>>> +				#power-domain-cells = <0>;
>>>>>> +			};
>>>>>> +
>>>>>> +			power-domain@RK3128_PD_GPU {
>>>>>> +				reg = <RK3128_PD_GPU>;
>>>>>> +				clocks = <&cru ACLK_GPU>;
>>>>>> +				pm_qos = <&qos_gpu>;
>>>>>> +				#power-domain-cells = <0>;
>>>>>> +			};
>>>>>> +
>>>>>> +			power-domain@RK3128_PD_CRYPTO {
>>>>>> +				reg = <RK3128_PD_CRYPTO>;
>>>>>> +				clocks = <&cru HCLK_CRYPTO>,
>>>>>> +					 <&cru SCLK_CRYPTO>;
>>>>>> +				pm_qos = <&qos_crypto>;
>>>>>> +				#power-domain-cells = <0>;
>>>>>> +			};
>>>>>> +		};
>>>>>> +	};
>>>>>> +
>>>>>> +	qos_crypto: qos@10128080 {
>>>>>> +		compatible = "rockchip,rk3128-qos", "syscon";
>>>>>> +		reg = <0x10128080 0x20>;
>>>>>> +	};
>>>>>> +
>>>>>> +	qos_gpu: qos@1012d000 {
>>>>>> +		compatible = "rockchip,rk3128-qos", "syscon";
>>>>>> +		reg = <0x1012d000 0x20>;
>>>>>> +	};
>>>>>> +
>>>>>> +	qos_vpu: qos@1012e000 {
>>>>>> +		compatible = "rockchip,rk3128-qos", "syscon";
>>>>>> +		reg = <0x1012e000 0x20>;
>>>>>> +	};
>>>>>> +
>>>>>> +	qos_rga: qos@1012f000 {
>>>>>> +		compatible = "rockchip,rk3128-qos", "syscon";
>>>>>> +		reg = <0x1012f000 0x20>;
>>>>>> +	};
>>>>>> +
>>>>>> +	qos_ebc: qos@1012f080 {
>>>>>> +		compatible = "rockchip,rk3128-qos", "syscon";
>>>>>> +		reg = <0x1012f080 0x20>;
>>>>>> +	};
>>>>>> +
>>>>>> +	qos_iep: qos@1012f100 {
>>>>>> +		compatible = "rockchip,rk3128-qos", "syscon";
>>>>>> +		reg = <0x1012f100 0x20>;
>>>>>> +	};
>>>>>> +
>>>>>> +	qos_lcdc: qos@1012f180 {
>>>>>> +		compatible = "rockchip,rk3128-qos", "syscon";
>>>>>> +		reg = <0x1012f180 0x20>;
>>>>>> +	};
>>>>>> +
>>>>>> +	qos_vip: qos@1012f200 {
>>>>>> +		compatible = "rockchip,rk3128-qos", "syscon";
>>>>>> +		reg = <0x1012f200 0x20>;
>>>>>>     	};
>>>>>>     
>>>>>>     	gic: interrupt-controller@10139000 {
>>>>>>
>>>>>
>>>
>>>
>
>
>
