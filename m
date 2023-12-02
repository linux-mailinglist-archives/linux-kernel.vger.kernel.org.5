Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774F9801DC7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 17:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjLBQgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 11:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjLBQgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 11:36:15 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EB2102;
        Sat,  2 Dec 2023 08:36:18 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50aab20e828so4290640e87.2;
        Sat, 02 Dec 2023 08:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701534977; x=1702139777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v0V2pKk4+4aA81N20X6iKRNTg+2H72cbN/toxwCkNhk=;
        b=SX9D6PA3tIHRR4KkFTlZwi27U9blNDCtK6BYa2hMFeAM1yS02SX+QMYABlUBDd9ft4
         bqreMp5vUTPzKmhcjusJ6DjGr39r3IcDaL3HZ0/CGxKXgUt7LEa43A+Fyttd0ytFu16T
         0nnLnahz4zyELdrPUjEUOESAJCmOC7fNNHFDQPuRBAekaeKkm9Z7oQ3DlNeaQPMgS94v
         imhC90lrRtXutZsTbUDNnpK6l8AvNN0SS4Fe7KQxbRATyKoAzN3zzJdFfc1IGxfM3YYr
         wAevnayMvLBKLizWagOj66N3AW+srUG5CiBszuMkq+RB6t0KP5JmXqiflJS821Wzsy+y
         +Nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701534977; x=1702139777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v0V2pKk4+4aA81N20X6iKRNTg+2H72cbN/toxwCkNhk=;
        b=ZLHrtPiKbE/xQmyzkaCxkEGWL20cdrwDkaQjCC9+JWHdg4rmJ5WnkB0BHIvGLled6O
         vNjJX/XqNOl+iEW1CfuacijCzKYsHpmhyYflVDCPt6RSydRpr9sZN1LADr5atDHKtOBE
         pHfmaMlPQVqpm436G1Fe9pp351tC4iRLTtITATLHDmdlhy0TmPIDyI8o8hIR8gM1sIS1
         5tIT5onBnNPJS89pEY49z2HyRBmoONmsEscfY/LH3nHyXKJRta+zIsuvzDM1NaSHlDHX
         MWK5C/bHI+OBUyqLULDi/+KH2WJWxlsKooiXNFjUUIFwazxITb/uZ5WCzVga82nRrfKs
         ROOQ==
X-Gm-Message-State: AOJu0YxnNXpcEkulWKhVlN/yOIFMBgdPl4KhFCw+WRxVPmlhsSyrCmix
        /h0uEjY3kBQ2vfvVbZOjMg==
X-Google-Smtp-Source: AGHT+IF33HnUEXqWEy4B+lQlMo7S3GPuLcKmlqPCjVR7Kz4ZLcX9FlrrJcRavP6xP748jt47pbec1g==
X-Received: by 2002:a05:6512:e98:b0:50b:bfaa:317b with SMTP id bi24-20020a0565120e9800b0050bbfaa317bmr1710184lfb.11.1701534976526;
        Sat, 02 Dec 2023 08:36:16 -0800 (PST)
Received: from ?IPV6:2a02:810b:f40:4300:b6b5:9b26:a823:2f2d? ([2a02:810b:f40:4300:b6b5:9b26:a823:2f2d])
        by smtp.gmail.com with ESMTPSA id eh4-20020a0564020f8400b0054c9b0bd576sm314474edb.26.2023.12.02.08.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Dec 2023 08:36:16 -0800 (PST)
Message-ID: <7a6eed43-477a-48a4-bd64-4528da920ffd@gmail.com>
Date:   Sat, 2 Dec 2023 17:36:15 +0100
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
 <20231202125144.66052-3-knaerzche@gmail.com> <6926340.F8r316W7xa@diego>
Content-Language: en-US
From:   Alex Bee <knaerzche@gmail.com>
In-Reply-To: <6926340.F8r316W7xa@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

Am 02.12.23 um 16:51 schrieb Heiko Stübner:
> Hi Alex,
>
> Am Samstag, 2. Dezember 2023, 13:51:41 CET schrieb Alex Bee:
>> Add power controller and qos nodes for RK3128 in order to use
>> them as powerdomains.
> does the power-domain controller work with the incomplete set of
> pm-domains too?

Yes, it does - the missing domains can request idle only and can't be 
powered on/off - if no one requests idle they are just up all the time.

> What I have in mind is
> - adding the power-controller node with the existing set of power-domains
> - the gpu pm-domain is in there
> - adding the gpu parts

My main concern about adding them later was the change of the ABI after 
they've been exposed in the SoC DT. If that's not an issue - sure: I can 
add them in a separate series.

>
>
> And a second series with
> - patch1 from here
> - a dts patch adding the additional pm-domains to rk3128.dtsi
> - I guess patch1 also should be split into a patch adding the binding-ids
>    and a separate patch for the code addition.

Yeah, I noticed this also :)

Regards,

Alex

>
>
> Heiko
>
>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
>> ---
>>   arch/arm/boot/dts/rockchip/rk3128.dtsi | 101 +++++++++++++++++++++++++
>>   1 file changed, 101 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
>> index 4e8b38604ecd..b72905db04f7 100644
>> --- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
>> +++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
>> @@ -8,6 +8,7 @@
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/interrupt-controller/irq.h>
>>   #include <dt-bindings/pinctrl/rockchip.h>
>> +#include <dt-bindings/power/rk3128-power.h>
>>   
>>   / {
>>   	compatible = "rockchip,rk3128";
>> @@ -133,6 +134,106 @@ smp-sram@0 {
>>   	pmu: syscon@100a0000 {
>>   		compatible = "rockchip,rk3128-pmu", "syscon", "simple-mfd";
>>   		reg = <0x100a0000 0x1000>;
>> +
>> +		power: power-controller {
>> +			compatible = "rockchip,rk3128-power-controller";
>> +			#power-domain-cells = <1>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			power-domain@RK3128_PD_VIO {
>> +				reg = <RK3128_PD_VIO>;
>> +				clocks = <&cru ACLK_CIF>,
>> +					 <&cru HCLK_CIF>,
>> +					 <&cru DCLK_EBC>,
>> +					 <&cru HCLK_EBC>,
>> +					 <&cru ACLK_IEP>,
>> +					 <&cru HCLK_IEP>,
>> +					 <&cru ACLK_LCDC0>,
>> +					 <&cru HCLK_LCDC0>,
>> +					 <&cru PCLK_MIPI>,
>> +					 <&cru ACLK_RGA>,
>> +					 <&cru HCLK_RGA>,
>> +					 <&cru ACLK_VIO0>,
>> +					 <&cru ACLK_VIO1>,
>> +					 <&cru HCLK_VIO>,
>> +					 <&cru HCLK_VIO_H2P>,
>> +					 <&cru DCLK_VOP>,
>> +					 <&cru SCLK_VOP>;
>> +				pm_qos = <&qos_ebc>,
>> +					 <&qos_iep>,
>> +					 <&qos_lcdc>,
>> +					 <&qos_rga>,
>> +					 <&qos_vip>;
>> +				#power-domain-cells = <0>;
>> +			};
>> +
>> +			power-domain@RK3128_PD_VIDEO {
>> +				reg = <RK3128_PD_VIDEO>;
>> +				clocks = <&cru ACLK_VDPU>,
>> +					 <&cru HCLK_VDPU>,
>> +					 <&cru ACLK_VEPU>,
>> +					 <&cru HCLK_VEPU>,
>> +					 <&cru SCLK_HEVC_CORE>;
>> +				pm_qos = <&qos_vpu>;
>> +				#power-domain-cells = <0>;
>> +			};
>> +
>> +			power-domain@RK3128_PD_GPU {
>> +				reg = <RK3128_PD_GPU>;
>> +				clocks = <&cru ACLK_GPU>;
>> +				pm_qos = <&qos_gpu>;
>> +				#power-domain-cells = <0>;
>> +			};
>> +
>> +			power-domain@RK3128_PD_CRYPTO {
>> +				reg = <RK3128_PD_CRYPTO>;
>> +				clocks = <&cru HCLK_CRYPTO>,
>> +					 <&cru SCLK_CRYPTO>;
>> +				pm_qos = <&qos_crypto>;
>> +				#power-domain-cells = <0>;
>> +			};
>> +		};
>> +	};
>> +
>> +	qos_crypto: qos@10128080 {
>> +		compatible = "rockchip,rk3128-qos", "syscon";
>> +		reg = <0x10128080 0x20>;
>> +	};
>> +
>> +	qos_gpu: qos@1012d000 {
>> +		compatible = "rockchip,rk3128-qos", "syscon";
>> +		reg = <0x1012d000 0x20>;
>> +	};
>> +
>> +	qos_vpu: qos@1012e000 {
>> +		compatible = "rockchip,rk3128-qos", "syscon";
>> +		reg = <0x1012e000 0x20>;
>> +	};
>> +
>> +	qos_rga: qos@1012f000 {
>> +		compatible = "rockchip,rk3128-qos", "syscon";
>> +		reg = <0x1012f000 0x20>;
>> +	};
>> +
>> +	qos_ebc: qos@1012f080 {
>> +		compatible = "rockchip,rk3128-qos", "syscon";
>> +		reg = <0x1012f080 0x20>;
>> +	};
>> +
>> +	qos_iep: qos@1012f100 {
>> +		compatible = "rockchip,rk3128-qos", "syscon";
>> +		reg = <0x1012f100 0x20>;
>> +	};
>> +
>> +	qos_lcdc: qos@1012f180 {
>> +		compatible = "rockchip,rk3128-qos", "syscon";
>> +		reg = <0x1012f180 0x20>;
>> +	};
>> +
>> +	qos_vip: qos@1012f200 {
>> +		compatible = "rockchip,rk3128-qos", "syscon";
>> +		reg = <0x1012f200 0x20>;
>>   	};
>>   
>>   	gic: interrupt-controller@10139000 {
>>
>
>
>
