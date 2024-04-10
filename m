Return-Path: <linux-kernel+bounces-138476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7881389F1DF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5E121F25032
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A8B15B143;
	Wed, 10 Apr 2024 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hqM3Q6uk"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB861119F;
	Wed, 10 Apr 2024 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712751477; cv=none; b=E9ggjPcJ4VMbhdog1DmJuLdsG1CS95X8TbWNYeSPvHJRPstbOoqJjje0Osay/WjxkQdBeNjk/JMLoERoKhoFek27MyjTWZA3qu2lNZIGWzCWHKoloN8n1EE6eG3UgU+9WCPiKhy+OjaiZHlhQHzlJDeaAX4NAifP/xbwRcIo0tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712751477; c=relaxed/simple;
	bh=aSWsZW3PPr3ut14CSL6esqj3XAo3ApAiyL2z+qeFyUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgP+M3KzEVh1u21AUDpDGLqIUH6/rAuUCzQvTvYidOJW+0m485BbZ9hNFRCzNKjCESB7YGjHv0zJevI2aZbzB72MPcCBbt0kpiKBfbc3v9D8N/rra6GfHgdf1AG8slPlWO+L1m0ecK0OjUrV2iWvTHKVZk3A9NJQF3I/4OWzsC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hqM3Q6uk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712751467;
	bh=aSWsZW3PPr3ut14CSL6esqj3XAo3ApAiyL2z+qeFyUM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hqM3Q6ukcFIQgwSig39iCJNyMZbUwME4Zc+vHw7Fkq0PbfNvj8FKXgvOxYpZsbdSD
	 xwcyLgpcf+HtWUiAJLss6ZEswzJtaqGxolgdeSEihM6whs2JJGUzQraueye6dPm6jN
	 1xDYXNqiDjQB4KrO920HNy65ePd6E52DaLwiopaVEcTZfxf2BDGiv0E87w6Jlq1jrJ
	 bVaot+9bMLXf0+N5/SPKzSb8+RbtEOW7eek9zgwhrZTVVtCUTy4EZbmympa3moUZB1
	 PEPq2CSCudJgw2n+RH9roo+gM5/QDLvRIrtSmnCBWk5i1aotOvUDbRvyQzMGMaHKRE
	 xRgYGCuIjzUAQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0B84737811D1;
	Wed, 10 Apr 2024 12:17:46 +0000 (UTC)
Message-ID: <0487ed41-0404-4215-a346-1a3daedc417f@collabora.com>
Date: Wed, 10 Apr 2024 14:17:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt8192: Add missing trip point
 in thermal zone
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?=
 <nfraprado@collabora.com>, =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?=
 <bero@baylibre.com>, Balsam CHIHI <bchihi@baylibre.com>,
 Alexandre Mergnat <amergnat@baylibre.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240410-upstream-torvalds-master-v2-1-679777847b63@chromium.org>
 <d1dafc46-9b14-4752-822c-86cbabdcfb8b@collabora.com>
 <CAHc4DNLrU=QVWODOzHXW16Ko1V=W31zkSHOi7rztiJMOMDcKqg@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAHc4DNLrU=QVWODOzHXW16Ko1V=W31zkSHOi7rztiJMOMDcKqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 10/04/24 14:06, Hsin-Te Yuan ha scritto:
> Hi Angelo,
> 
> 1. 68°C is provided by MediaTek previously in downstream
> 2. I think sustainable power will be estimated by
> estimate_sustainable_power in drivers/thermal/gov_power_allocator.c,
> but I'll ask MediaTek if they can provide the precise value.
> 3. Sure. I'll do it in v3 after I check 2. with MediaTek
> 

Perfect, thanks for the clarification.

Will wait for v3.

Cheers,
Angelo

> Regards,
> Hsin-Te
> 
> On Wed, Apr 10, 2024 at 5:50 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 10/04/24 10:40, Hsin-Te Yuan ha scritto:
>>> According to Documentation/driver-api/thermal/power_allocator.rst, there
>>> should be two passive trip points. Adding the missing trip point to
>>> ensure that the governor works optimally.
>>>
>>> Fixes: c7a728051f4e ("arm64: dts: mediatek: mt8192: Add thermal nodes and thermal zones")
>>> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
>>
>> That's better - but while I can agree about setting a general temperature
>> for that, I still have a few questions and requests:
>>
>> 1. Why is this 68°C? Was that value provided by MediaTek, or was it calculated?
>>    1b. If this was calculated, please, can you explain how?
>>
>> 2. The power allocator documentation also says that the governor works good
>>      when a "sustainable dissipatable power" parameter is fed to it through the
>>      `sustainable-power` devicetree property (with that being strictly board
>>      specific and never SoC-global, as that depends on the form factor and on
>>      the cooling method of the machine), can you please also add the right
>>      sustainable power indication to the Chromebook devicetrees?
>>      In the MT8192 specific case, that's mt8192-asurada.dtsi.
>>
>> 3. I just noticed that MT8192 is not the only one that would be affected by
>>      the issue that you're describing in this commit; can you please perform a
>>      similar change on the others, if parameters are known?
>>
>> Thanks,
>> Angelo
>>
>>> ---
>>> Changes in v2:
>>> - Clearify the reason of adding another passive trip point
>>> - Link to v1: https://lore.kernel.org/r/20240410-upstream-torvalds-master-v1-1-852e903f0cec@chromium.org
>>> ---
>>>    arch/arm64/boot/dts/mediatek/mt8192.dtsi | 40 ++++++++++++++++++++++++++++++++
>>>    1 file changed, 40 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> index 05e401670bced..08d8bccc84669 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> @@ -1959,6 +1959,11 @@ cpu0-thermal {
>>>                        thermal-sensors = <&lvts_mcu MT8192_MCU_LITTLE_CPU0>;
>>>
>>>                        trips {
>>> +                             cpu0_thres: trip-point {
>>> +                                     temperature = <68000>;
>>> +                                     hysteresis = <2000>;
>>> +                                     type = "passive";
>>> +                             };
>>>                                cpu0_alert: trip-alert {
>>>                                        temperature = <85000>;
>>>                                        hysteresis = <2000>;
>>> @@ -1989,6 +1994,11 @@ cpu1-thermal {
>>>                        thermal-sensors = <&lvts_mcu MT8192_MCU_LITTLE_CPU1>;
>>>
>>>                        trips {
>>> +                             cpu1_thres: trip-point {
>>> +                                     temperature = <68000>;
>>> +                                     hysteresis = <2000>;
>>> +                                     type = "passive";
>>> +                             };
>>>                                cpu1_alert: trip-alert {
>>>                                        temperature = <85000>;
>>>                                        hysteresis = <2000>;
>>> @@ -2019,6 +2029,11 @@ cpu2-thermal {
>>>                        thermal-sensors = <&lvts_mcu MT8192_MCU_LITTLE_CPU2>;
>>>
>>>                        trips {
>>> +                             cpu2_thres: trip-point {
>>> +                                     temperature = <68000>;
>>> +                                     hysteresis = <2000>;
>>> +                                     type = "passive";
>>> +                             };
>>>                                cpu2_alert: trip-alert {
>>>                                        temperature = <85000>;
>>>                                        hysteresis = <2000>;
>>> @@ -2049,6 +2064,11 @@ cpu3-thermal {
>>>                        thermal-sensors = <&lvts_mcu MT8192_MCU_LITTLE_CPU3>;
>>>
>>>                        trips {
>>> +                             cpu3_thres: trip-point {
>>> +                                     temperature = <68000>;
>>> +                                     hysteresis = <2000>;
>>> +                                     type = "passive";
>>> +                             };
>>>                                cpu3_alert: trip-alert {
>>>                                        temperature = <85000>;
>>>                                        hysteresis = <2000>;
>>> @@ -2079,6 +2099,11 @@ cpu4-thermal {
>>>                        thermal-sensors = <&lvts_mcu MT8192_MCU_BIG_CPU0>;
>>>
>>>                        trips {
>>> +                             cpu4_thres: trip-point {
>>> +                                     temperature = <68000>;
>>> +                                     hysteresis = <2000>;
>>> +                                     type = "passive";
>>> +                             };
>>>                                cpu4_alert: trip-alert {
>>>                                        temperature = <85000>;
>>>                                        hysteresis = <2000>;
>>> @@ -2109,6 +2134,11 @@ cpu5-thermal {
>>>                        thermal-sensors = <&lvts_mcu MT8192_MCU_BIG_CPU1>;
>>>
>>>                        trips {
>>> +                             cpu5_thres: trip-point {
>>> +                                     temperature = <68000>;
>>> +                                     hysteresis = <2000>;
>>> +                                     type = "passive";
>>> +                             };
>>>                                cpu5_alert: trip-alert {
>>>                                        temperature = <85000>;
>>>                                        hysteresis = <2000>;
>>> @@ -2139,6 +2169,11 @@ cpu6-thermal {
>>>                        thermal-sensors = <&lvts_mcu MT8192_MCU_BIG_CPU2>;
>>>
>>>                        trips {
>>> +                             cpu6_thres: trip-point {
>>> +                                     temperature = <68000>;
>>> +                                     hysteresis = <2000>;
>>> +                                     type = "passive";
>>> +                             };
>>>                                cpu6_alert: trip-alert {
>>>                                        temperature = <85000>;
>>>                                        hysteresis = <2000>;
>>> @@ -2169,6 +2204,11 @@ cpu7-thermal {
>>>                        thermal-sensors = <&lvts_mcu MT8192_MCU_BIG_CPU3>;
>>>
>>>                        trips {
>>> +                             cpu7_thres: trip-point {
>>> +                                     temperature = <68000>;
>>> +                                     hysteresis = <2000>;
>>> +                                     type = "passive";
>>> +                             };
>>>                                cpu7_alert: trip-alert {
>>>                                        temperature = <85000>;
>>>                                        hysteresis = <2000>;
>>>
>>> ---
>>> base-commit: 20cb38a7af88dc40095da7c2c9094da3873fea23
>>> change-id: 20240410-upstream-torvalds-master-40aeff5416c7
>>>
>>> Best regards,
>>
>>

