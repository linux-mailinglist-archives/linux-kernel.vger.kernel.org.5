Return-Path: <linux-kernel+bounces-7740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB28B81AC7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C81282254
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF5423A5;
	Thu, 21 Dec 2023 02:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="VhNvvwdb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m121157.qiye.163.com (mail-m121157.qiye.163.com [115.236.121.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7AD15CC;
	Thu, 21 Dec 2023 02:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=VhNvvwdbjPo7R61TzOR7Aoq7UhGk90latFKZasp/5FxmK2Zjgf2YfDe0ZBFJecM7NR1DXcqoUsW3nK8cXmZgzOuYE/TAa3QnMX32jVmW/gxqfreP9IFqU4cYuEpns3ENMq+AZ+R+yAYnR2JwuFqd61hBXnyypD0j6XJNr0ult9o=;
	s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=sgNbKKH79HHBf3IgFv/B9H2If9G4Vjiqig3E0NMzJhk=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.141] (unknown [58.22.7.114])
	by mail-m12779.qiye.163.com (Hmail) with ESMTPA id 3FEEA780171;
	Thu, 21 Dec 2023 09:07:14 +0800 (CST)
Message-ID: <28216be5-810f-40d6-850b-a0fc590ffa3c@rock-chips.com>
Date: Thu, 21 Dec 2023 09:07:13 +0800
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
From: Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <da10e2fc-3179-4bd5-88ed-b4d5f64a7191@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUhOSFYeQ0NIS0NMQkoZGUJVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
	tLWQY+
X-HM-Tid: 0a8c89e98fafb24fkuuu3feea780171
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ME06Sio6EDw0LyFLHC1WFUxK
	TTwKCRFVSlVKTEtISklLQ0hOS05JVTMWGhIXVRoVHwJVAhoVOwkUGBBWGBMSCwhVGBQWRVlXWRIL
	WUFZTkNVSUlVTFVKSk9ZV1kIAVlBSENDQzcG

Hi Alex:

On 12/20/23 19:16, Alex Bee wrote:
> Hi Andy,
> Am 18.12.23 um 11:55 schrieb Andy Yan:
>> From: Andy Yan <andy.yan@rock-chips.com>
>>
>> The system will hang at bringup secondary CPUs
>> without psci node.
>>
>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>>
>> ---
>>
>> (no changes since v1)
>>
>>   arch/arm/boot/dts/rockchip/rk3036.dtsi | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/rockchip/rk3036.dtsi b/arch/arm/boot/dts/rockchip/rk3036.dtsi
>> index 78686fc72ce6..5344803442a1 100644
>> --- a/arch/arm/boot/dts/rockchip/rk3036.dtsi
>> +++ b/arch/arm/boot/dts/rockchip/rk3036.dtsi
>> @@ -67,6 +67,11 @@ display-subsystem {
>>           ports = <&vop_out>;
>>       };
>> +    psci {
>> +        compatible = "arm,psci-1.0";
>> +        method = "smc";
>> +    };
>> +
> I don't think that's an good idea. 

Why?

>You most likely need that because you have downstream bootloader installed on this board. PSCI implementation takes place in TEE-OS for Rockchips ARM SoCs. There is no support for RK3036 in upstream op-tee OS. It's pretty much the same for RK3128 and RK3288.
> If you use upstream u-boot it should be good as-is.

Unfortunately, upstream u-boot also cannot boot up on this board.
At present, I haven't had time to debug what is going on.

Another reason I want to use downstream u-boot it is: I try run
this board with mainline just because i want to test some community
patches about inno-hdmi driver, as you said "the inno-hdmi driver currently gets a lot of attention"[0]

With a downstream u-boot I can easy switch between upstream kernel and downstream kernel(no need to replace other components)
if I found some function is not work as expected.


[0]https://patchwork.kernel.org/project/linux-rockchip/cover/20231219170100.188800-1-knaerzche@gmail.com/
> 
> Alex
>>       timer {
>>           compatible = "arm,armv7-timer";
>>           arm,cpu-registers-not-fw-configured;
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

