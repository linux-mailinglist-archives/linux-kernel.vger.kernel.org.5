Return-Path: <linux-kernel+bounces-102115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5393787AE87
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096132844BB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC95F69E1E;
	Wed, 13 Mar 2024 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JiursjGl"
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61F369E1A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349032; cv=none; b=Ougiqr+UYmZiil+vfoCNHvY/QItU/ZgEbFZSFjdzRTOQp21cZtNT6RKb3mVaALReBWiBOzT20MQC8RIqJuF/QgxC/HmJv5uiAiVVLoTa04iGbs7OJpfh1CtOvum5KDxurnOwgzsVR9XHt4Jy8XsEnzH8DyJaOEihxpRXxT2oVbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349032; c=relaxed/simple;
	bh=vLYe+hg0xx8mQ9Rjzd1F/WSU8MGReqAiODJvhLckMWU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IfFVlqauMLtjHfdE3rp11/smtTGxINl+tX6jEOLQxCO7eKVyyMcyWWq6iAD9Kj3zgQqXcikpVBwpOa0Wwx3S0T8K7d7Nmpo4Ae9gzMVTQA+JB1WGikDLykdOMb3oQ+PsixZ8P6bJc1r1kXAoLXvoojJIuGIpF75Q647bNixMX7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=JiursjGl; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710349019; bh=4mRSPJZDse+FhtPX2JihRkhT/GhaNNgYU4Y77qF9Kzw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=JiursjGl/DjbtUcuMrs+dhDkTppo7Z15aVe/zXhkCoPQz2oohJ8ubbR8wFSBOQNod
	 ARB45/D0jmjEJ7eSk7fYNoTvo2zU0+HzS32wsQgrY9WOi0GQLhY5TUJHsw6lj9Sgtj
	 XFkxXignLL/pIPM3CqZReP5rom+PBQsROdmvuzsM=
Received: from [IPV6:2409:895a:3250:228a:f4e8:af77:3451:7f84] ([2409:895a:3250:228a:f4e8:af77:3451:7f84])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id E3880A3A; Thu, 14 Mar 2024 00:56:56 +0800
X-QQ-mid: xmsmtpt1710349016tdgirfa7w
Message-ID: <tencent_9543398AE3BAC424842837CEF01508D6680A@qq.com>
X-QQ-XMAILINFO: M7n9VusxZAlPGPlIJTfz+AwavCckFRj2HUU3AOQkRKR3XtavbiEmdSuF4L3odh
	 /Psq4/fDQdHLPq60YoajvAwdidSbmgOfpu6Qb563mgepuMnWB0QcdwJzqMwtInTnoca+qGnRbUHe
	 BQVvOd0qGPKYFJByULOLf0p+K0nnPVT+7Q3oFLLpmh1FaV2zHRkmio+AQcERHR5wwUwt5rIiNpor
	 QmKRrml8t+exuyJM4SsGRbMtqMjZbx2NjgIa5wUA0pTfv8x/5Q5GbRtpJByfEnTkQo3oHWk7PJxZ
	 645kuUUzk/q1hofDL90U6MpuDfCpB6pTOcmCWI+bsypDaorCpUkjJQY/qQZR8a2dOK5LaSp64Myi
	 PTKnJmBgaoXbkx8kKBJhIgaWJfZ4euhgcPayzLh+d2eGsAsKW/Vp+sJGFk8BrekPB/4jIMOSdARU
	 D9lR8p7QrT6m1mypBVHm12dTeCuQktWhIHVIcWtc9JrPWRHa6T+YNx+EZJ/8/+ni38kY9hN5uDMo
	 ZDcgelIa1YM5jLTSr3b0+5q9962ImY6VJAtCu+zfe2rYHOiACvbY9OyjSjVyBDgQMNOinx2UvmQZ
	 7zx5O9GKZhOhbkwk+mMq0VGUc527RItu5JcXveEpXLFndjDstmsEXbeTREzk6t8+Xo5u4zGMP8yp
	 jM2aYyVgB9odzxKraf1Xd2Z/yXHY0bF1se5iaJMvNNqTx6uxgqFMDMilIs/a2XTRb+rs1S4ERRLV
	 iIXAbDQjUVWL0rP6yPIrIuMQkpofEQ7ZohjjifkonZc7xyaFGN4qPtSaJN8a7r5v+0XCP5beEOJZ
	 CFd6OB9PYFBMcN+EnoCOIGh7W8waHIU/wnXPWxO6nLR6a78J83NkgmxxbCGqywimrBD1SsCaaGbU
	 miIEto9zMso5YBz1kvDT+9IEozOVa4EhnxhOd4Sio9Oom2FPdraSc6XHsTl5TPQnF1fdWSIgb6w3
	 pdGSO3G2tHqqEQlx7vr4Uav/1kDtVe1SQFlYIxN24=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-OQ-MSGID: <0425a7b7-95a7-4f16-b1a4-4010ae1c3e6b@cyyself.name>
Date: Thu, 14 Mar 2024 00:56:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] riscv: Kconfig.socs: Allow SOC_CANAAN with MMU for
 K230
Content-Language: en-US
From: Yangyu Chen <cyy@cyyself.name>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com>
 <tencent_0432DA968E39B81431F921F38D747C008208@qq.com>
 <ef8df22f-dac8-4652-bf17-d10254e6abfb@kernel.org>
 <tencent_E56A833916E00EC7B4840C34FAF1250ADE0A@qq.com>
 <20240305-fascism-enrich-06483ddeb149@spud>
 <311bdf17-c16f-41d8-8366-10f9b00adf27@kernel.org>
 <tencent_FF86EF51905CFBDF1102F721663984B2F105@qq.com>
In-Reply-To: <tencent_FF86EF51905CFBDF1102F721663984B2F105@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/8 05:03, Yangyu Chen wrote:
> 
> 
>> On Mar 6, 2024, at 07:58, Damien Le Moal <dlemoal@kernel.org> wrote:
>>
>> On 3/6/24 02:20, Conor Dooley wrote:
>>> On Tue, Mar 05, 2024 at 03:47:15PM +0800, Yangyu Chen wrote:
>>>> On 2024/3/5 07:46, Damien Le Moal wrote:
>>>>> On 3/5/24 06:05, Yangyu Chen wrote:
>>>>>> Since K230 was released, SOC_CANAAN is no longer only referred to the K210.
>>>>>> Remove it depends on !MMU will allow building dts for K230 and remove the
>>>>>> K210 string from the help message.
>>>>>>
>>>>>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>>>>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>>>>> ---
>>>>>>   arch/riscv/Kconfig.socs | 5 ++---
>>>>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
>>>>>> index 623de5f8a208..b4e9b7f75510 100644
>>>>>> --- a/arch/riscv/Kconfig.socs
>>>>>> +++ b/arch/riscv/Kconfig.socs
>>>>>> @@ -75,13 +75,12 @@ config ARCH_CANAAN
>>>>>>    def_bool SOC_CANAAN
>>>>>>   config SOC_CANAAN
>>>>>> - bool "Canaan Kendryte K210 SoC"
>>>>>> - depends on !MMU
>>>>>
>>>>> This seems wrong to me. The k210 support does require no-mmu. So why remove
>>>>> this ?
>>>>
>>>> It just allows SOC_CANAAN to be selected when MMU=y. With this patch,
>>>> nommu_k210_defconfig still works.
>>>
>>> I think the concern here is that this would allow people to build a
>>> kernel for the k120 with the MMU enabled, not that the existing nommu
>>> build will be affected.
>>
>> Yes, this is my concern. Apologies for the lack of clarity.
>>
> 
> Hi,
> 
> Thanks for the review comments. After thinking about it for a while,
> I think we don't need to change it as we have changed the help
> message which deleted the "K210". And the dts on k210.dtsi shows
> mmu-type is riscv.none, I think if someone noticed this would know
> why it fails to boot on the S-Mode MMU Kernel on K210. The only
> special thing for ARCH_CANAAN is that a loader.bin will be built
> when M-Mode is on arch/riscv/Makefile. However, Canaan has no other
> M-Mode chips except for K210. So I think we don't need to change
> it.
> 
> Another reason is that SOC_CANAAN for K210 is somehow hard to change.
> If we continue using SOC_CANAAN for K210 but not for other Canaan
> SoCs such as K230, it will cause some confusion to users. If we
> rename SOC_CANAAN to SOC_CANAAN_K210, it will change many drivers
> in many subsystems like my patch v5 [1]. So I don't think we need
> to fix it.
> 
> 
> If we don't change it, A concern for this is that some drivers for
> K210 will be built when SOC_CANAAN=y and if we add this to defconfig,
> all riscv builds will also build some K210 drivers even on MMU. But
> I think this will not be a problem just need some memory/storage
> for a slightly bigger kernel. Also, we will enable some new configs
> in defconfig when a new soc gets supported, it's normal for K210
> SoC drivers.
> 
> Thus, I think we don't need to change it. If you have some other
> opinions, please let me know.
> 
> [1] https://lore.kernel.org/linux-riscv/tencent_6F35FEF31908DE6AEB385AE30AC658863C0A@qq.com/
> 
> Thanks,
> Yangyu Chen
> 

Hi Damien,

I'm waiting for your decision before sending the next patch revision.
Please reply to this when you are free.

Thanks,
Yangyu Chen

>>>
>>> Maybe you could squash in something like the following?
>>>
>>> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
>>> index b4e9b7f75510..75d55059163f 100644
>>> --- a/arch/riscv/Kconfig.socs
>>> +++ b/arch/riscv/Kconfig.socs
>>> @@ -72,15 +72,19 @@ config SOC_VIRT
>>>    This enables support for QEMU Virt Machine.
>>>
>>> config ARCH_CANAAN
>>> - def_bool SOC_CANAAN
>>> + bool "Canaan Kendryte SoCs"
>>> + help
>>> +   This enables support for Canaan Kendryte SoC platform hardware.
>>>
>>> config SOC_CANAAN
>>> - bool "Canaan Kendryte SoC"
>>> + bool "Canaan Kendryte K210 SoC"
>>> + depends on !MMU
>>> + depends on ARCH_CANAAN
>>> select CLINT_TIMER if RISCV_M_MODE
>>> select ARCH_HAS_RESET_CONTROLLER
>>> select PINCTRL
>>> select COMMON_CLK
>>> help
>>> -   This enables support for Canaan Kendryte SoC platform hardware.
>>> +   This enables support for Canaan Kendryte K210 SoC platform hardware.
>>>
>>> endmenu # "SoC selection"
>>>
>>> (Which reminds me, I really need to go and finish sorting out the ARCH_
>>> stuff)
>>
>> -- 
>> Damien Le Moal
>> Western Digital Research
> 
> 


