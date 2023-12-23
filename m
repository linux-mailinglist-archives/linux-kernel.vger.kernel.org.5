Return-Path: <linux-kernel+bounces-10388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6C781D3B6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 12:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0531F228AD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 11:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38990CA56;
	Sat, 23 Dec 2023 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="BspHYKFM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m6017.netease.com (mail-m6017.netease.com [210.79.60.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A0DCA4C;
	Sat, 23 Dec 2023 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=BspHYKFMaXBputBUpX1ObDvnTFBiitYLacZplp4Pq8etyZvfErVOx47lSjQ+6K/a9lOyD1Hg3amtfuFC6Me6urBC07tlKyuvWaFPe5tCUAnHh+mpBISoGkfEDzo6OOKXvwFEE5gtuD6D0yy8GKCMl+PpqQc1g674AswbI8wGI0I=;
	s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=UrXH3jWuHs/HH6U7OUE10uuuoLRhgpHq9XyW9Yz3h24=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.141] (unknown [58.22.7.114])
	by mail-m12779.qiye.163.com (Hmail) with ESMTPA id 4D6737801BC;
	Sat, 23 Dec 2023 19:14:04 +0800 (CST)
Message-ID: <b81d91e4-a06d-40c6-8c08-23c3ea5bd945@rock-chips.com>
Date: Sat, 23 Dec 2023 19:14:03 +0800
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
 heiko@sntech.de, Kever Yang <Kever.yang@rock-chips.com>
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
 <18c16355-9140-45be-bd16-96fad8b184a4@gmail.com>
From: Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <18c16355-9140-45be-bd16-96fad8b184a4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0NLSVYdTkwZSUlNHhlPT0hVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
	kG
X-HM-Tid: 0a8c9661daabb24fkuuu4d6737801bc
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NVE6PTo*ETw*Nxw2MCkaGjYC
	MRRPChBVSlVKTEtISEhLS09OSkxJVTMWGhIXVRoVHwJVAhoVOwkUGBBWGBMSCwhVGBQWRVlXWRIL
	WUFZTkNVSUlVTFVKSk9ZV1kIAVlBTEhKTzcG

Hi Alex,

On 12/22/23 23:37, Alex Bee wrote:
> Hi Andy,
> 
> Am 22.12.23 um 11:37 schrieb Andy Yan:
>> Hi Alex,
>>
>> On 12/21/23 23:58, Alex Bee wrote:
>>> Hi Andy,
>>>
>>> Am 21.12.23 um 02:07 schrieb Andy Yan:
>>>> Hi Alex:
>>>>
>>>> On 12/20/23 19:16, Alex Bee wrote:
>>>>> Hi Andy,
>>>>> Am 18.12.23 um 11:55 schrieb Andy Yan:
>>>>>> From: Andy Yan <andy.yan@rock-chips.com>
>>>>>>
>>>>>> The system will hang at bringup secondary CPUs
>>>>>> without psci node.
>>>>>>
>>>>>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>>>>>>
>>>>>> ---
>>>>>>
>>>>>> (no changes since v1)
>>>>>>
>>>>>>   arch/arm/boot/dts/rockchip/rk3036.dtsi | 5 +++++
>>>>>>   1 file changed, 5 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/rockchip/rk3036.dtsi b/arch/arm/boot/dts/rockchip/rk3036.dtsi
>>>>>> index 78686fc72ce6..5344803442a1 100644
>>>>>> --- a/arch/arm/boot/dts/rockchip/rk3036.dtsi
>>>>>> +++ b/arch/arm/boot/dts/rockchip/rk3036.dtsi
>>>>>> @@ -67,6 +67,11 @@ display-subsystem {
>>>>>>           ports = <&vop_out>;
>>>>>>       };
>>>>>> +    psci {
>>>>>> +        compatible = "arm,psci-1.0";
>>>>>> +        method = "smc";
>>>>>> +    };
>>>>>> +
>>>>> I don't think that's an good idea. 
>>>>
>>>> Why?
>>> It's only what I've been told before: We shoudn't add properties which
>>> depend on non-upstream software (if an upstream alternative exists). Also
>>
>>> I'm not sure what happens if somebody doesn't use downstream bootloader
>>> and PSCI can't be found: Would the board still be able to boot?
>>
>> The psci is released herel[0].
>> And also, there are only two rk3036 based boards in mainline:
>> rk3036-evb,rk3036-keylin, both of them from rockchip.
>> And the mainline support of these boards broken from linux 5.7(2020, see PATCH 3),
>> no one report this broken until I try to run this board now.
>> So maybe there is no such somebody will run into this situation.
>>
>>
>> [0]https://github.com/rockchip-linux/rkbin/tree/master/bin/rk30
>>
> Yeah sure, there are binary release for downstream optee implementations,
> but the won't work with upstream u-boot, since they are using a calling
> convention different from upstream optee os. I tried to add support for
> those, but it was rejected [0].
> 
> Upstream bootflow doesn't implement/need PSCI as it uses a SMP bringup
> method which is done in kernel only (see enable-method in cpu section). I
> guess that it doesn't work for you is most likely because the downstream
> tee os makes the cpu registers the upstream enable-method uses only
> accessible in a higher exception level.
> 
> I can undust my RK3036 evb board during christmas holidays and check whats
> broken for RK3036 in u-boot. Everything was working fine (including SMP

With one day bisect, I finally fond the mainline u-boot support for rk3036
was broken by this commit f113d7d30346 (" Convert CONFIG_SPL_STACK to Kconfig")

It makes rk3036 can't set SPL_STACK as rk3036 can't enable SPL_FRAMEWORK(very small sram)

I still don't have a proper patch to fix this issue.

Thank you very much for you explanation.
I think i should not add psci to mainline before the tee binary can be used by mainline u-boot.

Nice holidays!
> bringup w/o PSCI and upstream u-boot) when I was adding VPU support in 5.14
> [1]. I likely booted from TF-card rather than eMMC.
> 
> [0] https://patchwork.ozlabs.org/project/uboot/patch/20230718145715.1280201-6-knaerzche@gmail.com/
> [1] https://patchwork.kernel.org/project/linux-rockchip/patch/20210527154455.358869-11-knaerzche@gmail.com/
> 
> Nice holidays!
> 
> Alex
> 
>>>>
>>>>> You most likely need that because you have downstream bootloader installed on this board. PSCI implementation takes place in TEE-OS for Rockchips ARM SoCs. There is no support for RK3036 in upstream op-tee OS. It's pretty much the same for RK3128 and RK3288.
>>>>> If you use upstream u-boot it should be good as-is.
>>>>
>>>> Unfortunately, upstream u-boot also cannot boot up on this board.
>>>> At present, I haven't had time to debug what is going on.
>>>>
>>>> Another reason I want to use downstream u-boot it is: I try run
>>>> this board with mainline just because i want to test some community
>>>> patches about inno-hdmi driver, as you said "the inno-hdmi driver currently gets a lot of attention"[0]
>>>>
>>> Thanks for helping testing this.
>>>
>>> Alex
>>>
>>>> With a downstream u-boot I can easy switch between upstream kernel and downstream kernel(no need to replace other components)
>>>> if I found some function is not work as expected.
>>>>
>>>>
>>>> [0]https://patchwork.kernel.org/project/linux-rockchip/cover/20231219170100.188800-1-knaerzche@gmail.com/
>>>>>
>>>>> Alex
>>>>>>       timer {
>>>>>>           compatible = "arm,armv7-timer";
>>>>>>           arm,cpu-registers-not-fw-configured;
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> Linux-rockchip mailing list
>>>>> Linux-rockchip@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip

