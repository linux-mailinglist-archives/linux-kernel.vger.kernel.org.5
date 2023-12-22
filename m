Return-Path: <linux-kernel+bounces-9600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ABB81C844
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54ED2B22F49
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D15A12E7E;
	Fri, 22 Dec 2023 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="MDzHYzZY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m127230.xmail.ntesmail.com (mail-m127230.xmail.ntesmail.com [115.236.127.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F87014A86;
	Fri, 22 Dec 2023 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=MDzHYzZYYMKiuAb0H9f+9p49+AvE/kR1FV64dqf4egat372paSoVnIe2HDoSX8bLe+DjXFF+ftNxOjWRrmVdWndOCXAcmYs8zm1aTxVzXnqylsFMp9zXyTbRi8CvYg6NwBys4AHRdsFX8ML41m1yh83duM9xt/i/btkBNgjuZ2I=;
	s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=cYx3cEyew4wgHXkUGMpRDrNMXv9JyJmRzTLBW8rcTjA=;
	h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.102] (unknown [103.29.142.67])
	by mail-m12779.qiye.163.com (Hmail) with ESMTPA id BEC107801AA;
	Fri, 22 Dec 2023 18:37:59 +0800 (CST)
Message-ID: <74e497f5-0361-47f7-a410-4b20d3526d52@rock-chips.com>
Date: Fri, 22 Dec 2023 18:37:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ARM: dts: rockchip: Add psci for rk3036
Content-Language: en-US
To: Alex Bee <knaerzche@gmail.com>, Andy Yan <andyshrk@163.com>,
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
From: Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <a82481ca-b578-49a4-b0d0-974b6ee65c98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSBkeVkMZTEMeSE1DTB8ZGVUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpLSFVJQlVKT0lVTUxZV1kWGg8SFR0UWUFZT0tIVUpISkJIT1VKS0tVS1kG
X-HM-Tid: 0a8c911a7d22b24fkuuubec107801aa
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTY6ECo4Qzw5FR4VIjIZLDk5
	AzAaCzZVSlVKTEtISU9KT0NJSU5IVTMWGhIXVRoVHwJVAhoVOwkUGBBWGBMSCwhVGBQWRVlXWRIL
	WUFZSktIVUlCVUpPSVVNTFlXWQgBWUFOSkpDNwY+

Hi Alex,

On 12/21/23 23:58, Alex Bee wrote:
> Hi Andy,
> 
> Am 21.12.23 um 02:07 schrieb Andy Yan:
>> Hi Alex:
>>
>> On 12/20/23 19:16, Alex Bee wrote:
>>> Hi Andy,
>>> Am 18.12.23 um 11:55 schrieb Andy Yan:
>>>> From: Andy Yan <andy.yan@rock-chips.com>
>>>>
>>>> The system will hang at bringup secondary CPUs
>>>> without psci node.
>>>>
>>>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>>>>
>>>> ---
>>>>
>>>> (no changes since v1)
>>>>
>>>>   arch/arm/boot/dts/rockchip/rk3036.dtsi | 5 +++++
>>>>   1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/rockchip/rk3036.dtsi b/arch/arm/boot/dts/rockchip/rk3036.dtsi
>>>> index 78686fc72ce6..5344803442a1 100644
>>>> --- a/arch/arm/boot/dts/rockchip/rk3036.dtsi
>>>> +++ b/arch/arm/boot/dts/rockchip/rk3036.dtsi
>>>> @@ -67,6 +67,11 @@ display-subsystem {
>>>>           ports = <&vop_out>;
>>>>       };
>>>> +    psci {
>>>> +        compatible = "arm,psci-1.0";
>>>> +        method = "smc";
>>>> +    };
>>>> +
>>> I don't think that's an good idea. 
>>
>> Why?
> It's only what I've been told before: We shoudn't add properties which
> depend on non-upstream software (if an upstream alternative exists). Also

> I'm not sure what happens if somebody doesn't use downstream bootloader
> and PSCI can't be found: Would the board still be able to boot?

The psci is released herel[0].
And also, there are only two rk3036 based boards in mainline:
rk3036-evb,rk3036-keylin, both of them from rockchip.
And the mainline support of these boards broken from linux 5.7(2020, see PATCH 3),
no one report this broken until I try to run this board now.
So maybe there is no such somebody will run into this situation.


[0]https://github.com/rockchip-linux/rkbin/tree/master/bin/rk30

>>
>>> You most likely need that because you have downstream bootloader installed on this board. PSCI implementation takes place in TEE-OS for Rockchips ARM SoCs. There is no support for RK3036 in upstream op-tee OS. It's pretty much the same for RK3128 and RK3288.
>>> If you use upstream u-boot it should be good as-is.
>>
>> Unfortunately, upstream u-boot also cannot boot up on this board.
>> At present, I haven't had time to debug what is going on.
>>
>> Another reason I want to use downstream u-boot it is: I try run
>> this board with mainline just because i want to test some community
>> patches about inno-hdmi driver, as you said "the inno-hdmi driver currently gets a lot of attention"[0]
>>
> Thanks for helping testing this.
> 
> Alex
> 
>> With a downstream u-boot I can easy switch between upstream kernel and downstream kernel(no need to replace other components)
>> if I found some function is not work as expected.
>>
>>
>> [0]https://patchwork.kernel.org/project/linux-rockchip/cover/20231219170100.188800-1-knaerzche@gmail.com/
>>>
>>> Alex
>>>>       timer {
>>>>           compatible = "arm,armv7-timer";
>>>>           arm,cpu-registers-not-fw-configured;
>>>
>>>
>>> _______________________________________________
>>> Linux-rockchip mailing list
>>> Linux-rockchip@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip

