Return-Path: <linux-kernel+bounces-35107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 580F2838C3E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BB061C232AC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14D45C8E7;
	Tue, 23 Jan 2024 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZuLuyXeb"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FFA5C5FE;
	Tue, 23 Jan 2024 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006332; cv=none; b=eGDnRNrh0mqo7ZyDDb1+u3O+SrfnkiCDHofRnhVH8omge8oivSaWJl7263OsgPsXjDemTHhya9AvPp4t4oKBvqa72pGGUAzg/FIilSAjI2FP+yMiTgaS/K33on9jq/pG6Hf9c2HzDjHtTnL/NTNDOoIiKZuN70TTo9pp7KDDrRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006332; c=relaxed/simple;
	bh=fwg7iBzcpslli0ryw+wtduKrPGzNpgD5nM2Zx1ePlms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNU6BMSeVvg4Qy4oogNqQu6HK0wS5SoOosglScypZ0gWTMOWQHFUH1Zi/Y/genXc8LT4xSlc6yQsvJcpVGE+ZzVkkfDm4Et9vFRatFlpjEKrtEFlz+T8at64nSFmaW9zkuKpYEmvXvRSjLwvtNlVzw9ixQvQRngv65bkweq+xAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZuLuyXeb; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706006323;
	bh=fwg7iBzcpslli0ryw+wtduKrPGzNpgD5nM2Zx1ePlms=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZuLuyXebqQIG3hIBTdPltslzYWi3LxwHi0JJG2YvYJ6+6y5UJctBEG01QbcZTCcbN
	 c543IXvAmNSM9qIAPV0m+Neeqw6MNEVnDrv2FOtWaExL0sPflG6UmOghjGowu4EHOc
	 vFeSrVENN8IcvU9mz5airnhfaMnf2jmSuzmHFtD2FRzAExoAcIQq/NebZ2gyys5U+T
	 3OgF3UF+BEByuo9EAGYYjyPWlqSsCx1eYLYIlqk7NSI9WMtwMUjps5J6UxuEFF3OdI
	 diUJ4azfCCzcG7zodhGSX7SbyPk1vdb+WnU0kUMUWeuO3LKSVBAWaEwGMN4ZBoG7Ph
	 a59aoE63yQdTg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B9DB137820A9;
	Tue, 23 Jan 2024 10:38:42 +0000 (UTC)
Message-ID: <cfee57f3-5940-44c3-a93b-3a5160dc8351@collabora.com>
Date: Tue, 23 Jan 2024 11:38:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2] arm64: dts: mt8195-cherry-tomato: change
 watchdog reset boot flow
To: Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>
References: <20231228105717.719624-1-yuanhsinte@chromium.org>
 <CAGXv+5H-mpXZ_0H_HchDWeTgx+4Nkxh6651DEs1C62mrXczTkA@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAGXv+5H-mpXZ_0H_HchDWeTgx+4Nkxh6651DEs1C62mrXczTkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 23/01/24 05:03, Chen-Yu Tsai ha scritto:
> +CC Nicolas
> 
> On Thu, Dec 28, 2023 at 6:57 PM Hsin-Te Yuan <yuanhsinte@chromium.org> wrote:
>>
>> The external output reset signal was originally disabled and sent from
>> firmware. However, an unfixed bug in the firmware on tomato prevents
>> the signal from being sent, causing the device to fail to boot. To fix
>> this, enable external output reset signal to allow the device to reboot
>> normally.
>>
>> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> 
> Friendly ping?
> 
> Also wondering if you folks hit this, or if you haven't triggered the
> watchdog at all.
> 

I have never seen any watchdog timeout on Tomato R2.

In any case - this commit misses a Fixes tag...

Cheers,
Angelo

> ChenYu
> 
>> ---
>>
>> Changes in v2:
>> - Limit the effect only on tomato.
>>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts | 4 ++++
>>   arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts | 4 ++++
>>   arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts | 4 ++++
>>   3 files changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
>> index 2d5e8f371b6d..a82d716f10d4 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
>> @@ -23,3 +23,7 @@ &sound {
>>   &ts_10 {
>>          status = "okay";
>>   };
>> +
>> +&watchdog {
>> +       /delete-property/ mediatek,disable-extrst;
>> +};
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
>> index 2586c32ce6e6..2fe20e0dad83 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
>> @@ -43,3 +43,7 @@ &sound {
>>   &ts_10 {
>>          status = "okay";
>>   };
>> +
>> +&watchdog {
>> +       /delete-property/ mediatek,disable-extrst;
>> +};
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
>> index f54f9477b99d..dd294ca98194 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
>> @@ -44,3 +44,7 @@ &sound {
>>   &ts_10 {
>>          status = "okay";
>>   };
>> +
>> +&watchdog {
>> +       /delete-property/ mediatek,disable-extrst;
>> +};
>> --
>> 2.43.0.472.g3155946c3a-goog
>>

