Return-Path: <linux-kernel+bounces-15640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6126C822F4D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D9B284B34
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C311A591;
	Wed,  3 Jan 2024 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="bp5gsgHT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379081A587
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1704291574;
 bh=3c19w6vY1jyD7/GphZNPpueD7bdTp6aOk8Eg2b52Ujc=;
 b=bp5gsgHTBnOKKFqXDvXj+1UM664A3zOXm1skicaPB9pP/IcH8+Hhfudr/vggwWUTI7mLZlCBJ
 LY2T8q06ysaYxoC9n6Tht1UY3rXip6nB72M+s+stBM/773i+twTd2kKesmZaPtsTDn+GJpVnItN
 4T5yJWw5kAalam3wwFP1hraCfPRdMov9VP+dzSNSnbpeI3RV4A7thBrF1jLBOG+uK1lHGEpBiDZ
 2GYX81eCz0IAi3+o7a+fUq2I48cBiRMsqdlJ1NnmXRgoaCybJ4JG+T9vPj4KJh6lHLjSpiobLHH
 ex4L1I8wkMmmFzBCtGJ66UUmbHqE8nqCx0zlnuA8BUpg==
Message-ID: <6efe305c-4ab4-43c1-ab6d-64bdf1d81a2f@kwiboo.se>
Date: Wed, 3 Jan 2024 15:19:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: dts: rockchip: Add devicetree for Pine64
 PineTab2
Content-Language: en-US
To: Manuel Traut <manut@mecka.net>
Cc: "=?UTF-8?Q?Ond=C5=99ej_Jirman?=" <megi@xff.cz>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Sandy Huang
 <hjc@rock-chips.com>, Mark Yao <markyao0591@gmail.com>, Diederik de Haas
 <didi.debian@cknow.org>, Segfault <awarnecke002@hotmail.com>, Arnaud
 Ferraris <aferraris@debian.org>, Danct12 <danct12@riseup.net>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20240102-pinetab2-v3-0-cb1aa69f8c30@mecka.net>
 <20240102-pinetab2-v3-4-cb1aa69f8c30@mecka.net>
 <775vjfucu2g2s6zzeutj7f7tapx3q2geccpxvv4ppcms4hxbq7@cbrdmlu2ryzp>
 <903e9d0c-a00c-4214-9f0e-dd676b13b428@kwiboo.se> <ZZVjzwgANJMdHnuo@mecka.net>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <ZZVjzwgANJMdHnuo@mecka.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65956cf5cdaacf2fcbc351f3

Hi Manuel,

On 2024-01-03 14:40, Manuel Traut wrote:
> Hi Jonas and Ondřej,
> 
>>>> +&sfc {
>>>> +	pinctrl-names = "default";
>>>> +	pinctrl-0 = <&fspi_dual_io_pins>;
>>>> +	status = "okay";
>>>> +	#address-cells = <1>;
>>>> +	#size-cells = <0>;
>>>> +
>>>> +	flash@0 {
>>>> +		compatible = "jedec,spi-nor";
>>>> +		reg = <0>;
>>>> +		spi-max-frequency = <24000000>;
>>>
>>> That's a bit on the low side. The flash chip should work for all commands up to
>>> 80MHz https://megous.com/dl/tmp/b428ad9b85ac4633.png and SGM3157YC6 switch
>>> for the FSPI-CLK should have high enough bandwidth, too.
>>
>> I agree that this is a little bit on the low side, it was a safe rate
>> that I used for U-Boot. U-Boot required an exact rate of the supported
>> sfc clk rates: 24, 50, 75, 100, 125 or 150 MHz.
>>
>> Please also note that the SPI NOR flash chip used in PineTab2 is not a
>> GigaDevice GD25LQ128E, it should be a SiliconKaiser SK25LP128, same as
>> found in the Pine64 PinePhone Pro.
> 
> The schematics for v2.0 reference a GD25LQ128EWIGR. I never checked the jedec
> id. How did you retrieve this information, or is it maybe a difference in v0.1
> and 2.0?

This was when working on mainline U-Boot for the PineTab2 (and other
rk356x devices). See [1] for a pending U-Boot patch that is waiting on a
proper mainline linux devicetree for the PT2.

The JEDEC ID is reported as 0x257018 on my v2.0 production unit, and
does not match the JEDEC ID for GD25LQ128E (0xc86018) referenced in
the schematics.

I found that the JEDEC ID 0x257018 was referenced in prior patches
related to the SK25LP128 SPI NOR flash chip used in Pine64 PinePhone Pro.

I have only ever tested the 24 MHz rate, but I am expecting that e.g.
100 MHz also should work. Will not be able to test on my PT2 until at
earliest next week.

[1] https://github.com/Kwiboo/u-boot-rockchip/commit/66562d6eaf2c11a9f97fcdba379d3ceda8aa70ef

Regards,
Jonas

> 
>>>> +		spi-rx-bus-width = <2>;
>>>
>>> GD25LQ128E supports quad I/O. Maybe try 4 if it will work.
>>
>> The schematic only shows fspi D0 and D1 connected, and use the D2 line
>> for eMMC_RSTn, so spi-rx-bus-width = <2> should be correct.
> 
> ack
> 
> Since it is only needed for bootloader updates and environment its maybe better
> to stay on the safe side?
> 
> But I can test faster frequency if you want me to do..
> 
> Regards
> Manuel


