Return-Path: <linux-kernel+bounces-9848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81A081CC52
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD0D61C221B8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD60241EB;
	Fri, 22 Dec 2023 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCdfZ3In"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FE123768;
	Fri, 22 Dec 2023 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3333b46f26aso1710782f8f.1;
        Fri, 22 Dec 2023 07:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703259459; x=1703864259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jO+Yn/pm/7QZ79FVkxxMV1L8t+Nw+iioD1El4NSSjm8=;
        b=BCdfZ3In/bXxAZtNI1pmR/ZNTsbZkGc2AmJyJ5MWhrrB57N8GFExOx9V3CJJAc0qV8
         iqGNBZ6ZWQE3S/3Nt0l/Tl9Scoufa6Y/RSas74TTfBdqthHoyGBDZpW4MgZTm+T8rhHl
         ELqMVAgcZSZHUVjldiMGHXqgILwlUEoMUmE8xhZJKp+KZAM4mHMg1yIfkC1kyFU/eRKA
         IRuGkHPnQanWBx0p6JTyFjgTgDgmTgo7TlnLOzu4O87NZFRjMYyx3C6ra+3zVYS2Agyd
         ScwYbF0JYSggTztC3dVTOpG5BAFaUdt/MhSZDP3zEeyY9FhLyu+uhhNkWx2giOtyuDva
         g+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703259459; x=1703864259;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jO+Yn/pm/7QZ79FVkxxMV1L8t+Nw+iioD1El4NSSjm8=;
        b=N1fJIfWilfNz0LjeFcjxFZMcRw5SUkYnEJB7jIA4ChZPq3Y3YpHqUMcs9FhqlA/8GJ
         OH/7u3nWWoEr5Ect0XG9kA4SaRQXXPfEbWsm63ZqOvKkThmbnCMiziGA4v9RRHACH1jd
         w1+QvPf1BQMMkxcMUIdxC/XGJauJGDAemgmX8eGNGcJRK/4SJ9skePie8rgJquPFvOi8
         pwJ/V6Ttb+7kOTjwsYTh+Kft7o/7Ao6fYmT4DHBBL4jEBNsrX0U3YXFcaCy9k5RaOSj8
         5AF7oG3sipVuwbWKKh3AIizZ7HgAEOirpGA1OugEwzdQdDM5/faey1OUnTNBp8j+uqZl
         wXWw==
X-Gm-Message-State: AOJu0YxWqdi2fDneKqXCPc0UZNyPb+6t/0RWf5VZtmqBS1lY+Tkz8cAd
	Das/BtiDvNyik7aoFgI26Q==
X-Google-Smtp-Source: AGHT+IF/S1bUccm049yDqtraSZeXSvw0RtqJJi5b7sN4cROAVAAsyvDsoozy5bwdK3uoqUyPC7Ff7g==
X-Received: by 2002:a5d:5487:0:b0:336:60e9:483 with SMTP id h7-20020a5d5487000000b0033660e90483mr910801wrv.125.1703259458799;
        Fri, 22 Dec 2023 07:37:38 -0800 (PST)
Received: from ?IPV6:2a02:810b:f40:4300:f3ae:2788:7e03:f44? ([2a02:810b:f40:4300:f3ae:2788:7e03:f44])
        by smtp.gmail.com with ESMTPSA id a7-20020a5d4d47000000b00333404e9935sm4595304wru.54.2023.12.22.07.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 07:37:38 -0800 (PST)
Message-ID: <18c16355-9140-45be-bd16-96fad8b184a4@gmail.com>
Date: Fri, 22 Dec 2023 16:37:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ARM: dts: rockchip: Add psci for rk3036
Content-Language: en-US, de-DE
To: Andy Yan <andy.yan@rock-chips.com>, Andy Yan <andyshrk@163.com>,
 heiko@sntech.de
Cc: krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 zhengxing@rock-chips.com
References: <20231218105523.2478315-1-andyshrk@163.com>
 <20231218105523.2478315-2-andyshrk@163.com>
 <da10e2fc-3179-4bd5-88ed-b4d5f64a7191@gmail.com>
 <28216be5-810f-40d6-850b-a0fc590ffa3c@rock-chips.com>
 <a82481ca-b578-49a4-b0d0-974b6ee65c98@gmail.com>
 <74e497f5-0361-47f7-a410-4b20d3526d52@rock-chips.com>
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <74e497f5-0361-47f7-a410-4b20d3526d52@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andy,

Am 22.12.23 um 11:37 schrieb Andy Yan:
> Hi Alex,
>
> On 12/21/23 23:58, Alex Bee wrote:
>> Hi Andy,
>>
>> Am 21.12.23 um 02:07 schrieb Andy Yan:
>>> Hi Alex:
>>>
>>> On 12/20/23 19:16, Alex Bee wrote:
>>>> Hi Andy,
>>>> Am 18.12.23 um 11:55 schrieb Andy Yan:
>>>>> From: Andy Yan <andy.yan@rock-chips.com>
>>>>>
>>>>> The system will hang at bringup secondary CPUs
>>>>> without psci node.
>>>>>
>>>>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>>>>>
>>>>> ---
>>>>>
>>>>> (no changes since v1)
>>>>>
>>>>>   arch/arm/boot/dts/rockchip/rk3036.dtsi | 5 +++++
>>>>>   1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/rockchip/rk3036.dtsi 
>>>>> b/arch/arm/boot/dts/rockchip/rk3036.dtsi
>>>>> index 78686fc72ce6..5344803442a1 100644
>>>>> --- a/arch/arm/boot/dts/rockchip/rk3036.dtsi
>>>>> +++ b/arch/arm/boot/dts/rockchip/rk3036.dtsi
>>>>> @@ -67,6 +67,11 @@ display-subsystem {
>>>>>           ports = <&vop_out>;
>>>>>       };
>>>>> +    psci {
>>>>> +        compatible = "arm,psci-1.0";
>>>>> +        method = "smc";
>>>>> +    };
>>>>> +
>>>> I don't think that's an good idea. 
>>>
>>> Why?
>> It's only what I've been told before: We shoudn't add properties which
>> depend on non-upstream software (if an upstream alternative exists). 
>> Also
>
>> I'm not sure what happens if somebody doesn't use downstream bootloader
>> and PSCI can't be found: Would the board still be able to boot?
>
> The psci is released herel[0].
> And also, there are only two rk3036 based boards in mainline:
> rk3036-evb,rk3036-keylin, both of them from rockchip.
> And the mainline support of these boards broken from linux 5.7(2020, 
> see PATCH 3),
> no one report this broken until I try to run this board now.
> So maybe there is no such somebody will run into this situation.
>
>
> [0]https://github.com/rockchip-linux/rkbin/tree/master/bin/rk30
>
Yeah sure, there are binary release for downstream optee implementations,
but the won't work with upstream u-boot, since they are using a calling
convention different from upstream optee os. I tried to add support for
those, but it was rejected [0].

Upstream bootflow doesn't implement/need PSCI as it uses a SMP bringup
method which is done in kernel only (see enable-method in cpu section). I
guess that it doesn't work for you is most likely because the downstream
tee os makes the cpu registers the upstream enable-method uses only
accessible in a higher exception level.

I can undust my RK3036 evb board during christmas holidays and check whats
broken for RK3036 in u-boot. Everything was working fine (including SMP
bringup w/o PSCI and upstream u-boot) when I was adding VPU support in 5.14
[1]. I likely booted from TF-card rather than eMMC.

[0] 
https://patchwork.ozlabs.org/project/uboot/patch/20230718145715.1280201-6-knaerzche@gmail.com/
[1] 
https://patchwork.kernel.org/project/linux-rockchip/patch/20210527154455.358869-11-knaerzche@gmail.com/

Nice holidays!

Alex

>>>
>>>> You most likely need that because you have downstream bootloader 
>>>> installed on this board. PSCI implementation takes place in TEE-OS 
>>>> for Rockchips ARM SoCs. There is no support for RK3036 in upstream 
>>>> op-tee OS. It's pretty much the same for RK3128 and RK3288.
>>>> If you use upstream u-boot it should be good as-is.
>>>
>>> Unfortunately, upstream u-boot also cannot boot up on this board.
>>> At present, I haven't had time to debug what is going on.
>>>
>>> Another reason I want to use downstream u-boot it is: I try run
>>> this board with mainline just because i want to test some community
>>> patches about inno-hdmi driver, as you said "the inno-hdmi driver 
>>> currently gets a lot of attention"[0]
>>>
>> Thanks for helping testing this.
>>
>> Alex
>>
>>> With a downstream u-boot I can easy switch between upstream kernel 
>>> and downstream kernel(no need to replace other components)
>>> if I found some function is not work as expected.
>>>
>>>
>>> [0]https://patchwork.kernel.org/project/linux-rockchip/cover/20231219170100.188800-1-knaerzche@gmail.com/ 
>>>
>>>>
>>>> Alex
>>>>>       timer {
>>>>>           compatible = "arm,armv7-timer";
>>>>>           arm,cpu-registers-not-fw-configured;
>>>>
>>>>
>>>> _______________________________________________
>>>> Linux-rockchip mailing list
>>>> Linux-rockchip@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip

