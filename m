Return-Path: <linux-kernel+bounces-163725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AC38B6ED1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1AE21F24222
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6ED128833;
	Tue, 30 Apr 2024 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0vDQKLOw"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D711272AB;
	Tue, 30 Apr 2024 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714470760; cv=none; b=a4NmXZgeOeiS8tVABFyxPYA9nRkjosEUvI2+NUKoaslvQtDDByA2e4UhHiHymf/fGiRivP3/5rXUL12kN9BgNw0mCZcV8aKYGPOk1WD7Nj70gO52xqFNm7dfATNSxpKlu3HcBTNNQVhLQ1WxqABzpmszUTl6oQ/dWDQmmvV+h9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714470760; c=relaxed/simple;
	bh=34AxLChZrxxqHn1rYrjE3n7vuuxWsZUQYT7Rf3uwoQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fbMoshS8ersUE0ykX/E8UxTCRHQmDudBI8R4u8Ma6cXVf85Dj9eYdoxsLzUsqHBssfLZjB5oOEGSjb9BqRNh3D/rpwumxr6mAtzWtIYeFwmGBMGqUlZ1Fk0uuiAC8TAIBAno1jOy+yG7sVFvLAW2Oi+V1kPShX0lch6Rli+DSh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0vDQKLOw; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714470756;
	bh=34AxLChZrxxqHn1rYrjE3n7vuuxWsZUQYT7Rf3uwoQc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=0vDQKLOwgXxhzFhDjTWnQU3kuptP84J3H/JMQqd4nlpdZuZ245vHqSGv8SqIzEFyD
	 pI64jSlCfB8+4477d7BHY5JMPlK4YNn8NqcKEmgKCQy/y+Ro5kJkP/MPIqA6VVqS1n
	 OQCUC36ha+e8u2EvH0s1tSiUi3Yr7AgrU+c8cA6OnzoYRMJORAsTRQ/Wbx9SDBiYPt
	 VPIDHGggwOh4xGokXkAYTj74YdHlcqgTAMAYKr3gPU93G866zVS+q1+BduFU86I2Hb
	 KLL8liPgykUc49u9k0luukl8NXbE+5QTjujclGtNi1zj8oQSIqP/j7yu5wPkhi1FB7
	 zH6leRSB1LbJQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 27EE2378143B;
	Tue, 30 Apr 2024 09:52:36 +0000 (UTC)
Message-ID: <8c4f32db-5c80-4fef-8e8d-76f74d3c6bd4@collabora.com>
Date: Tue, 30 Apr 2024 11:52:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8192-asurada: Add off-on-delay-us
 for pp3300_mipibrdg
To: Pin-yen Lin <treapking@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
 Hsin-Te Yuan <yuanhsinte@chromium.org>
References: <20240429095333.3585438-1-treapking@chromium.org>
 <b3c69a78-78c9-4a15-829b-e4b36e16566a@collabora.com>
 <CAEXTbpf2HOQj_AxHGbsgOXVF_HyKttL=z7Mi8QStcmuOS+yN7g@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAEXTbpf2HOQj_AxHGbsgOXVF_HyKttL=z7Mi8QStcmuOS+yN7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 30/04/24 11:32, Pin-yen Lin ha scritto:
> Hi Angelo,
> 
> On Tue, Apr 30, 2024 at 4:17 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 29/04/24 11:53, Pin-yen Lin ha scritto:
>>> Set off-on-delay-us to 500000 us for pp3300_mipibrdg to make sure it
>>> complies with the panel sequence. Explicit configuration on the
>>> regulator node is required because mt8192-asurada uses the same power
>>> supply for the panel and the anx7625 DP bridge. So powering on/off the
>>> DP bridge could break the power sequence requirement for the panel.
>>>
>>> Fixes: f9f00b1f6b9b ("arm64: dts: mediatek: asurada: Add display regulators")
>>> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
>>>
>>
>> Uhm, there might be more to it - I don't think that this should ever happen.
>>
>> The regulator is refcounted, so...
>>    * Bridge on: panel goes off, but regulator doesn't turn off (refcount=1)
>>      * Panel resume -> sequence respected (refcount=2 -> wait -> more vregs, etc)
>>    * Bridge off: panel is already off (refcount=0)
>>      * Bridge resume -> refcount=1, no panel commands yet
> 
> The off-on-delay could be violated because the bridge driver does not
> check the delay.
> 
>>      * Panel resume -> refcount=2, wait -> more vregs, etc
>>
>> Can you please describe the issue that you're getting?
> 
> The symptom we observed is that the device has a small chance to
> reboot to a black panel, and we think the panel's unprepare delay (the
> time to power down completely) might not be satisfied because the
> bridge doesn't check that when it enables the regulator. Even if the
> regulator is enabled by the panel driver, the delay can also be
> violated in the following sequence:
> 
> * t=0ms, bridge on: panel goes off, but regulator doesn't turn off
> (refcount=1). The .unprepared_time in panel_edp is updated
> * t=300ms, bridge off, regulator goes off (refcount=0)
> * t=600ms, panel on, the panel driver thinks the unprepare delay
> (500ms) is satisfied, but the regulator was disabled 300ms ago.
> 
> Did I miss anything here? Or should I add more detail to the commit message?
> 

Heh, no you didn't miss anything, this time it's just me :-)

If you can please add that description to the commit message for a v2 that'd be
appreciated on my side.

In any case

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

>>
>> Cheers,
>> Angelo
>>
> Regards,
> Pin-yen
> 
>>> ---
>>>
>>>    arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
>>> index 7a704246678f..08d71ddf3668 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
>>> @@ -147,6 +147,7 @@ pp3300_mipibrdg: regulator-3v3-mipibrdg {
>>>                regulator-boot-on;
>>>                gpio = <&pio 127 GPIO_ACTIVE_HIGH>;
>>>                vin-supply = <&pp3300_g>;
>>> +             off-on-delay-us = <500000>;
>>>        };
>>>
>>>        /* separately switched 3.3V power rail */
>>


