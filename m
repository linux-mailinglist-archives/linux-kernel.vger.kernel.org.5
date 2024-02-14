Return-Path: <linux-kernel+bounces-64720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CE78541E6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2E81F29F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E87BA30;
	Wed, 14 Feb 2024 04:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="bVoF6owy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qu3kXAZp"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A152B670;
	Wed, 14 Feb 2024 04:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707883220; cv=none; b=Tkju8VRTUgUH/7PHQBTA5QlyTQ5iGs5qXcP6/DEd5Zkc4SljemnzdVQodL5cu6pTkeNYovKxrX0nH77qEBXGhmrmUf48+vtO8znj2rPug38qKPOSN/NsqCVI08VkUYgCj1MTu9BgVxotZ+Qk8KcjzTGPpU2k018r/T4tJ6GUc5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707883220; c=relaxed/simple;
	bh=K8qOiZrUEmXMyJy8G+Prfu4akp3Z9sfjpsVZ8t1PZt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIfvt4VIiew2moY2cLQ8TAIfPNkV+3DyG+XFHLbxZFS/2gmlUJ0kIPwgv0WPHEizNXVLqV5rKvRurtwtJTXsq53Sst8x3avNQxScd7UN1Q86k2+S/J3WjONV4JasWhn3rVIM+kwXU+MmDjQ5+KLCuepeZnPInPCPmP+p5hg2CQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=bVoF6owy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qu3kXAZp; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E7C8211400D7;
	Tue, 13 Feb 2024 23:00:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 13 Feb 2024 23:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707883215; x=1707969615; bh=eSqa5vOfrNq3JhkGEjhlTovtf3Fms65Y
	5Wl9KASJnhQ=; b=bVoF6owyQdmalEip/o/0JXNG/IaQitreZFqqWh3mHLjkIDyh
	NtMm1YhHFe28g3s1afs4NpvpRGsZSCoVMkYZaIlHzCG7KF3TWoyata9fe869Srlt
	KtIq0kYFqXsIY0rG3FFu3RODA0pEhwvGcAyAeShwiez0ZcChygqSOfrncaxKNmyY
	PhayC7Jzc9ARYflnxguggFzxJNZs6V4Ugm7tCBmjtzOKJU1DrRIID766rg2PTZj3
	m1YIMLRuoHbFIXxRawA4f0Ua9Kh+ZKC/NsloKDXJMYGG+i6v+uVe45Kqt/iJ9XDm
	prK/kIAauCnkejz4QLkYvEj0WIWu5qXhtEddhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707883215; x=
	1707969615; bh=eSqa5vOfrNq3JhkGEjhlTovtf3Fms65Y5Wl9KASJnhQ=; b=Q
	u3kXAZpLHb2gSNJio3rMDMMrtdUquV/3uM1FSeylMK2/0fKZ/mFCQJhSFoxj+hPl
	ZOAjbY6VILrDbBvmouIGZx6oysoBxyFY5HW4Hb30paTZFAnX2m6Y11D/ODMgSK8h
	vMAfcF5Kkrns/3hYNWWALugz1yYMMYAsjCTBNZXNAnbJ0ox7Hpcv1A6OuXqWCAQb
	YcQkJk/BmVTOJcslTJXd47ItpUI77paVjSLN35xd+ofDv+KURp41KZ7IyrMOIOVo
	IENPsAe1du+CX3XW0CB8R6fkr/IoB4MoKg1c5u//xFy7Z3iRD2zsWigKWHE62yi6
	NHtdE5anHlvmxyMexCdmw==
X-ME-Sender: <xms:zzrMZfnZ8_epbNtUEmqlLfnsT-7kvx1hYhnZ5aHwM89nR-20eDxAQA>
    <xme:zzrMZS2hK9Bb0YjRPf87hTp24R7e0Z6qgH09ByENLOwWycMCV_ftxmORVYSvDUP_Y
    R10oaXVeg>
X-ME-Received: <xmr:zzrMZVpmPmjj6EnCU260QAdScGKNcJs0aE1zkiyDQiQSyfQGzgu_IEfIaUHiPrRbSrGOUrzUa1YUMAKgRezmOtjefACor31rspdNMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeigdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhimhcu
    nfhunhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrh
    hnpeetfeefheettdffheeggefhtdegfeeltdekjeeiteevtdefieevvedtheejfedvteen
    ucffohhmrghinheplhhinhgrrhhordhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepthhimhesfhgvrghthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:zzrMZXncYR6XbSIcg5M2AiPhJpbPBT-am3_L1eDdi4D2BhkSaX2vkw>
    <xmx:zzrMZd1Zj0WSrjxCoHajH3LQJGCmppcyd5NrGDi9K0mXBGJqK5O-zA>
    <xmx:zzrMZWttaGcUbmaWDYLD3wLLW-V8zdFPwsiqbKEPFfQQ_1tHV2uOCQ>
    <xmx:zzrMZc3ogRcU6nKwH_AKPyL9DIO1eu1TnbLMwFTgDrlodNvPLjshbA>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 23:00:09 -0500 (EST)
Message-ID: <3aa1fe01-0d7d-4d42-af31-8cdd24363910@feathertop.org>
Date: Wed, 14 Feb 2024 15:00:06 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: rockchip: Fix Hardkernel ODROID-M1 board
 bindings
Content-Language: en-US
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>
Cc: KyuHyuk Lee <lee@kyuhyuk.kr>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>,
 Tianling Shen <cnsztl@gmail.com>, Jagan Teki <jagan@edgeble.ai>,
 Ondrej Jirman <megi@xff.cz>, Andy Yan <andyshrk@163.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240115145142.6292-1-lee@kyuhyuk.kr> <47795047.XUcTiDjVJD@diego>
 <194a0894-a9f9-4c5e-b304-e7278104d8e7@feathertop.org>
 <2185016.Icojqenx9y@phil>
From: Tim Lunn <tim@feathertop.org>
In-Reply-To: <2185016.Icojqenx9y@phil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Heiko,

On 2/14/24 06:31, Heiko Stuebner wrote:
> Hi Tim,
>
> Am Mittwoch, 17. Januar 2024, 11:03:26 CET schrieb Tim Lunn:
>> On 1/17/24 06:55, Heiko Stübner wrote:
>>> Am Dienstag, 16. Januar 2024, 20:26:05 CET schrieb Rob Herring:
>>>> On Tue, Jan 16, 2024 at 09:31:35AM +0100, Heiko Stübner wrote:
>>>>> Am Dienstag, 16. Januar 2024, 08:24:44 CET schrieb Krzysztof Kozlowski:
>>>>>> On 16/01/2024 03:00, Tim Lunn wrote:
>>>>>>> On 1/16/24 01:58, Krzysztof Kozlowski wrote:
>>>>>>>> On 15/01/2024 15:51, KyuHyuk Lee wrote:
>>>>>>>>> The vendor in ODROID-M1 is hardkernel, but it was incorrectly written
>>>>>>>>> as rockchip. Fixed the vendor prefix correctly.
>>>>>>>>>
>>>>>>>>> Signed-off-by: KyuHyuk Lee <lee@kyuhyuk.kr>
>>>>>>>>> ---
>>>>>>>>>     Documentation/devicetree/bindings/arm/rockchip.yaml | 2 +-
>>>>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>> You need to start testing your patches. Your last M1 fails as well in
>>>>>>>> multiple places.
>>>>>>>>
>>>>>>>> It does not look like you tested the DTS against bindings. Please run
>>>>>>>> `make dtbs_check W=1` (see
>>>>>>>> Documentation/devicetree/bindings/writing-schema.rst or
>>>>>>>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
>>>>>>>> for instructions).
>>>>>>>>
>>>>>>>> The DTS change will break the users, so would be nice to mention this in
>>>>>>>> its commit msg.
>>>>>>> I notice there are a couple of other boards that incorrectly use
>>>>>>> rockchip as the vendor also:
>>>>>>>
>>>>>>>              - const: rockchip,rk3399-orangepi
>>>>>>>              - const: rockchip,rk3568-bpi-r2pro
>>>>>>>
>>>>>>> Perhaps these should also be fixed at the same time?
>>>>>> What is happening with rockchip boards?
>>>>> Copy-paste stuff ... boards using rockchip,boardname instead of
>>>>> vendor,boardname for their compatible.
>>>>>
>>>>> I do remember us noticing this a number of times on some boards
>>>>> and requesting fixes, but looks like some slipped through.
>>>>>
>>>>> So I guess Tim is suggesting changing the compatible, but with boards
>>>>> being merged a while ago, this would break backwards compatibility.
>>>>> So I guess both the Orange and Banana Pies will need to live with that.
>>>> You may get away with it because we generally don't use the names...
>>>>
>>>> Though there are some discussions to start using them to select dtbs by
>>>> bootloaders.
>>> Ah, that's good to know (both points) ... so essentially right now would be
>>> a good time to do what Tim suggested, before the names get actual usage.
>>>
>>> @Tim: is that something you'd want to do?
>>>
>> Sure, I will prepare patches and send them out soon.
> As I stumbled upon this patch just now, how is that coming along? :-)


Thanks for the reminder, I will send them now ;)

Regards
   Tim

>
> Thanks
> Heiko
>
>

