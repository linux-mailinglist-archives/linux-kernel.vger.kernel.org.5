Return-Path: <linux-kernel+bounces-103090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA6887BAE5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86EA1C21BEB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57AC6DCEA;
	Thu, 14 Mar 2024 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2vW0+MY3"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0EC6BFB5;
	Thu, 14 Mar 2024 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710410589; cv=none; b=E5Qh/iku8byf698VmDbw2h/yZ4PfL+UgB1Fm+tC+kWZtaW+2p+K5LwgU5v7ocKtxLHawYpe9SDjuLLrsTlT4gV/JEfFbVyjZmG/QFdGCOkC9fgjdXI0zQI6D0h/YEUun89Ihh6knf39JpJXukWn10HifWl+c8CvYmmLzILehfVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710410589; c=relaxed/simple;
	bh=7Te3YspK5rB2494WTdPhhCk43LasN8upRyD7Xd2ldfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SC+CeKfjQgJb2SSV7/Y35aIqqPC0mBqJ2uJyNoeGsxuD0Si0/kFGnF4N39oPVb8VE4Ax4plxZ6logTL+Qaw+sGujEk57fkG/RigPqQrLH59jlwF67xvhbcI6jHbJtni5beamzxtUas659aODV2dMySzMar1z/YFFQd6MmXpSqYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2vW0+MY3; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710410580;
	bh=7Te3YspK5rB2494WTdPhhCk43LasN8upRyD7Xd2ldfk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=2vW0+MY3gziKQl7e8yqupDfds0LLNG44VwBCObMCrLlpAmnOJylOQRzfmda8N0ZUA
	 nUDMWQsFnxXJ1WQ/BAK4C7TipPu2JeOXsWYCACkP2fLugMvGnEvwygTrIy4xqTux1I
	 LtWpR7PJ5OkeWlvrFTCiOttl81g79vJBS/siV4apVmZ6DproUihLLeT+TZhGEvsXl4
	 2n8HjfX21h0cYXlip4Eoq/hk/G8Fsc+2Ujr99aPB6deXZEZKnz9IoYadkB1aJwkCI3
	 9G6uRt5Nt5YxmrNLcBB3+FhMDHZlO/XW079tGVELuogfahNZDKtxfSTDn8S2AWQg39
	 6NYHUJKUNzQMw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9245937820A3;
	Thu, 14 Mar 2024 10:02:59 +0000 (UTC)
Message-ID: <63cdec54-8dd6-4f17-8256-bbb8cfe791be@collabora.com>
Date: Thu, 14 Mar 2024 11:02:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8192-asurada: Update min voltage
 constraint for Vgpu
Content-Language: en-US
To: Pin-yen Lin <treapking@google.com>
Cc: Pin-yen Lin <treapking@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Chen-Yu Tsai
 <wenst@chromium.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 devicetree@vger.kernel.org
References: <20240313135157.98989-1-treapking@chromium.org>
 <d1bdf9a6-3082-4076-99de-e49d59843244@collabora.com>
 <CAHwYsiqJBsQn73H+2VeB4N3GNH=0EZ4qznqWwYCBjt6+qwNhHw@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAHwYsiqJBsQn73H+2VeB4N3GNH=0EZ4qznqWwYCBjt6+qwNhHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 14/03/24 10:59, Pin-yen Lin ha scritto:
> Hi Angelo,
> 
> On Wed, Mar 13, 2024 at 10:36 PM AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com> wrote:
> 
>> Il 13/03/24 14:51, Pin-yen Lin ha scritto:
>>> Although the minimum voltage listed on the GPU OPP table is 606250 uV,
>>> the actual requested voltage could be even lower when the MTK Smart
>>> Voltage Scaling (SVS) driver is enabled.
>>>
>>> Set the minimum voltage to 300000 uV because it's supported by the
>>> regulator.
>>>
>>> Fixes: 3183cb62b033 ("arm64: dts: mediatek: asurada: Add SPMI
>> regulators")
>>> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
>>
>> Okay, that makes sense, I agree.
>>
>> ...but.
>>
>> The datasheet never mentions 0.3V as vmin - infact, it does mention that
>> the
>> vsel is selected as (0V +) 6250 * Vsel, but the brief spec says that for
>> the
>> standard configuration (in terms of HW), the Vmin is 0.4V and not 0.3.
>>
>> Reading through makes me think that it's not much about the buck providing
>> an
>> unstable output, but more about it starting to become inefficient under
>> that
>> value.
>>
>> This means that it is sensible to set, instead:
>>
>>          regulator-min-microvolt = <400000>;
>>
>> Also, this is repeated on multiple platforms: can you please perform the
>> same
>> change also on MT8183, MT8186 and MT8195?
>>
>> P.S.: For MT6358, the Vmin for VGPU is 0.5V :-)
>>
> 
> Thanks for checking! I'll update the values on other platforms as well.
> 
> I assume that we also want to update other mt6315 nodes listing 300000 uV
> as the min voltage, so I'll update them as well.
> 

Yes, didn't notice that, nice catch. Please do!

Cheers,
Angelo

>>
>>> ---
>>>
>>>    arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
>> b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
>>> index 43d80334610a..5cc5100a7c40 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
>>> @@ -1448,7 +1448,7 @@ regulators {
>>>                        mt6315_7_vbuck1: vbuck1 {
>>>                                regulator-compatible = "vbuck1";
>>>                                regulator-name = "Vgpu";
>>> -                             regulator-min-microvolt = <606250>;
>>> +                             regulator-min-microvolt = <300000>;
>>>                                regulator-max-microvolt = <800000>;
>>>                                regulator-enable-ramp-delay = <256>;
>>>                                regulator-allowed-modes = <0 1 2>;
>>
>>
>>
> 


