Return-Path: <linux-kernel+bounces-135565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1F489C7A2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9222285C94
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840F513F427;
	Mon,  8 Apr 2024 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="cHwhBQaa"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B55813F01A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588233; cv=none; b=A39Wkul9bniOmS/FYXgSype5SyXVNXToqo+p9PO5xomVeniWIDYHy8fdir7UwyrIY48qC+ISXGrykrCJMDxw9HXvh2+sD9ySOpfmaHs/20lAmb7qMQ94LQWRezK1OHJeoLnJ0ND9YyTcSGEmanowFb65t5m1Wl0UZxQYfpYXpbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588233; c=relaxed/simple;
	bh=ZL5WxRd6xX5YwWDXJ0UNj1PKwdcUln7meecPcR7SOyc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sa9IUdT6ytSp/W/3AYEwN0c0HB3HxTh6wjoeMrwqNkeqQMsQng5Z2b128TzK9jJqQMAwfubFgvRmZcqS3P3CbbAD8dr0j/lN7gx5oIT/gCrB0xSM7O13IQ8R3zG8COfT6qMKTNOU4skGmfL2EOK4Y1ejslmZajO0/KShd0yI96c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=cHwhBQaa; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: References: Cc:
 To: From: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1712588227;
 bh=Vrqed05exdnqCvLdsEGiIF00ILNQUOlq51lQmfBBM8s=;
 b=cHwhBQaa94tEYSoDZUSED06sXUlf1O7V2Iq3tWYOej0f4c6whydMrhWFlEg+8aZxvuo3WVDpW
 sNsV+B3plUjuWUjaK6FuHb5XU8D4bwjCONjLsLBy6dekfVnUQJesjygtAdqOVVvQgcmsMmUe9f+
 KstEVBP5JkieE9k/bWIOHG8yFva52i8tVtLbfeTPsVf+zORvR9ViFfVewiZZt6kGRGrLU+nlj9C
 2AlA/eG3cRrqi+d3L3/7mqmHgqSFdgbH/nwAl3OmpImuJRNUR8XwtpnPiNGlOx0iaHY76dRdCY+
 z1SWM5h1X+Hm0bNu+qbdlbVVgdg6fme0/OMmJRM5RClA==
Message-ID: <b32c284e-f3ec-44b0-abbd-7fa403bc9870@kwiboo.se>
Date: Mon, 8 Apr 2024 16:56:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: enable onboard spi flash for
 rock-3a
From: Jonas Karlman <jonas@kwiboo.se>
To: Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>
Cc: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240408124005.182565-1-amadeus@jmu.edu.cn>
 <421ab43b-ff92-41c6-9904-3c7681c926be@kwiboo.se>
Content-Language: en-US
In-Reply-To: <421ab43b-ff92-41c6-9904-3c7681c926be@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 661405c13464f70b49a230b8

Hi again,

On 2024-04-08 16:44, Jonas Karlman wrote:
> Hi Chukun,
> 
> On 2024-04-08 14:40, Chukun Pan wrote:
>> There is a mx25u12835f spi flash on this board, enable it.
>>
>> [    2.525805] spi-nor spi4.0: mx25u12835f (16384 Kbytes)
>>
>> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
>> index a5e974ea659e..d8738cc47c73 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
>> @@ -757,6 +757,18 @@ &sdmmc2 {
>>  	status = "okay";
>>  };
>>  
>> +&sfc {
> 
> This is missing:
> 
> 	#address-cells = <1>;
> 	#size-cells = <0>;
> 
>> +	status = "okay";
>> +
>> +	flash@0 {
>> +		compatible = "jedec,spi-nor";
>> +		reg = <0x0>;
>> +		spi-max-frequency = <50000000>;
> 
> At least in U-Boot the spi clock only support 24, 100 or 200 mhz and I
> am pretty sure the spi flash support 100mhz, so I would suggest you test
> with 100mhz, same as used on other rk356x boards.

Sorry, looked at spi clock instead of sfc clock.
sfc clock support 24, 50, 75, 100, 125 and 150 mhz.

Regards,
Jonas

> 
> For U-Boot I have used 24 mhz for rk356x boards not defining a flash@0
> node in linux device tree, such as the rock-3a board.
> 
> Regards,
> Jonas
> 
>> +		spi-rx-bus-width = <4>;
>> +		spi-tx-bus-width = <1>;
>> +	};
>> +};
>> +
>>  &tsadc {
>>  	rockchip,hw-tshut-mode = <1>;
>>  	rockchip,hw-tshut-polarity = <0>;
> 


