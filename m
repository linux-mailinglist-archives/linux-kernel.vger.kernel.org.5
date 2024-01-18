Return-Path: <linux-kernel+bounces-29764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADC183131B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3401C22450
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26BEB65B;
	Thu, 18 Jan 2024 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="zGmVbKeo"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BA6C127
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563100; cv=none; b=uE4Fj8X2r6EUC1v9Avb0RFmREP6NDTChmz9AY0jwuok4ZC8IWn7CSpZp+3+tozfP5+Ev8zd3dh8oFhBtD1eEfzgHIaW5JMm8vZX10uHTvXMOdeeJMgpc3tGPzDyYbI1GBT8UpzOJwxrpZnb2oMXIevsc8atQ7NLEB5JWKCwTmKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563100; c=relaxed/simple;
	bh=dcyPHowVowojvYwqybjhAHT+o5+hBycJepvY2VZ/r+w=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 From:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Report-Abuse-To:X-Report-Abuse:
	 X-Complaints-To:X-ForwardEmail-Version:X-ForwardEmail-Sender:
	 X-ForwardEmail-ID; b=kivErcx1mL+AfMOPbnu0PHFs+qZK02wRcJ70TZFKPCrbDCLY6Z8ytl9h1jGE0Cz+PPo+sKnkqK8yijeP9TBTP29Fhs8LLC6DbuXjlhrjKGflqD/dPRdTXx68LdvEPNKc2PdNfMjvp0tLD8QdeJQReNeYnudAamTyUy+DjrX5ixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=zGmVbKeo; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: References: Cc:
 To: From: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1705563094;
 bh=D9ZkcwjkVkGoVyXUCHS1LAJlQ3CiUF2oO0UMAU5d3Pw=;
 b=zGmVbKeofuLzzupz6023S9mfUpt7WC2oeGojsHwqrzjGIcQZqyCvckAOc5KjTW0uBnKRvjxYF
 jVL6pe7g5uLQbLhuDntzSY/Lxik7FZqvEkn+V0BJkqly72pbde5zMmgEfBfRKLh4eBqfp/NAa6q
 uJaGnMQgtlCT/h8lqueW09QYKbklZ2ScALkaLHoshupJlflgcZIDosgZbJHTh3DgW1qwwCjcSdF
 YnPYSbKMEMo9OdZAwt0O3+v7gCBAprI6fPBmxH5Ho+6hlflbYmcPF60mfKB1HJqux7+zKPUAMOa
 RqpVY2Yoc80wyhERLm2tG4TWrBXa+PoD/MwHNIuuZfwA==
Message-ID: <df78489b-7546-46ea-b09f-39a80692a962@kwiboo.se>
Date: Thu, 18 Jan 2024 08:31:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: rock-pi-e: fix location of snps
 properties
From: Jonas Karlman <jonas@kwiboo.se>
To: Trevor Woerner <twoerner@gmail.com>, "Chen-Yu Tsai" <wens@csie.org>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20240116204103.29318-1-twoerner@gmail.com>
 <20240116204103.29318-2-twoerner@gmail.com>
 <CAGb2v67KfNR_U_Qz85aqY1D0DKE9mo-X_L8MGvT7cdcZGUHVUg@mail.gmail.com>
 <20240117054705.GA33225@localhost>
 <852071ad-24e8-40a8-9b10-623abf1dc4bf@kwiboo.se>
Content-Language: en-US
In-Reply-To: <852071ad-24e8-40a8-9b10-623abf1dc4bf@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65a8d3d6d66eecd94fbb69d3

On 2024-01-17 09:15, Jonas Karlman wrote:
> On 2024-01-17 06:47, Trevor Woerner wrote:
>> On Wed 2024-01-17 @ 12:38:39 PM, Chen-Yu Tsai wrote:
>>> On Wed, Jan 17, 2024 at 4:41 AM Trevor Woerner <twoerner@gmail.com> wrote:
>>>>
>>>> A number of snps (Synopsys) properties are not in their correct location.
>>>
>>> Nope. If you read the snps,dwmac.yaml binding file, you'll see that these
>>> properties have been deprecated. They are properties pertaining to the PHY
>>> and should be described under the PHY node. Support for reset GPIOs on PHY
>>> devices in phylib has been there since v4.16. The snps prefixed properties
>>> were deprecated in v5.3.
>>
>> If that's the case, then the bindings and the drivers are out of sync in both
>> U-Boot and Linux. I discovered this issue while working with older and newer
>> revisions of the rock-pi-e board. The first three spins of the rock-pi-e have
>> the rtl8211e PHY but the last one (v1.21) has the rtl8211f PHY.
>>
>> With the existing layout nothing works in U-Boot and in Linux the rtl8211e
>> works but not the rtl8211f. With this patch both the rtl8211e and the rtl8211f
>> PHYs work using the exact same device trees on both older and newer rock-pi-e
>> boards in both U-Boot and Linux.
> 
> For linux this is probably related to the same chicken-and-egg reset
> issue outlined at [1]. The phy is not reset before it is probed and
> cannot be probed because it is not reset.
> 
> As for U-Boot the designware/gmac_rockchip ethernet driver may need some
> adjustments to properly integrate with eth-phy uclass to properly reset
> the phy described in a ethernet-phy node before it can be probed.
> 
> Following config options is disabled for rock-pi-e-rk3328 defconfig:
> 
> # CONFIG_DM_ETH_PHY is not set
> # CONFIG_PHY_REALTEK is not set
> 
> Also the driver needs to be updated to make use eth-phy uclass for it to
> work correctly. More similar to how the dwc_eth_qos driver works related
> to ethernet phy.

I have just sent out a U-Boot series that fix ethernet on the v1.21
revision of the ROCK Pi E board, see [2].

Would expect that ethernet also starts to work in linux with those
patches applied to U-Boot. I only tested and verified ethernet in U-Boot.

Hopefully someone can take a closer look at the issue on linux side
so that it does not need to depend on PHY being reset by the bootloader.

[2] https://lore.kernel.org/u-boot/20240118071949.927089-1-jonas@kwiboo.se/T/

Regards,
Jonas

> 
> [1] https://lore.kernel.org/linux-rockchip/47d55aca-bee6-810f-379f-9431649fefa6@kwiboo.se/
> 
> Regards,
> Jonas
> 
>>
>> Comparing the rock-pi-e's dts file with the one from the roc-rk3328-cc board,
>> which also uses the layout in this patch, and which also uses the rtl8211e
>> external PHY, is what led me in this direction.
>>
>>>
>>> ChenYu
>>>
>>>> Fixes: b918e81f2145 ("arm64: dts: rockchip: rk3328: Add Radxa ROCK Pi E")
>>>> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
>>>> ---
>>>>  arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts | 10 +++++-----
>>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
>>>> index 096cfa19036e..0739b8fec86e 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
>>>> @@ -150,8 +150,11 @@ &gmac2io {
>>>>         phy-mode = "rgmii";
>>>>         phy-supply = <&vcc_io>;
>>>>         pinctrl-names = "default";
>>>> -       pinctrl-0 = <&rgmiim1_pins>;
>>>> +       pinctrl-0 = <&rgmiim1_pins>, <&eth_phy_reset_pin>;
>>>>         snps,aal;
>>>> +       snps,reset-gpio = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
>>>> +       snps,reset-active-low;
>>>> +       snps,reset-delays-us = <0 10000 50000>;
>>>>         snps,rxpbl = <0x4>;
>>>>         snps,txpbl = <0x4>;
>>>>         tx_delay = <0x26>;
>>>> @@ -165,13 +168,10 @@ mdio {
>>>>
>>>>                 rtl8211: ethernet-phy@1 {
>>>>                         reg = <1>;
>>>> -                       pinctrl-0 = <&eth_phy_int_pin>, <&eth_phy_reset_pin>;
>>>> +                       pinctrl-0 = <&eth_phy_int_pin>;
>>>>                         pinctrl-names = "default";
>>>>                         interrupt-parent = <&gpio1>;
>>>>                         interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
>>>> -                       reset-assert-us = <10000>;
>>>> -                       reset-deassert-us = <50000>;
>>>> -                       reset-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
>>>>                 };
>>>>         };
>>>>  };
>>>> --
>>>> 2.43.0.76.g1a87c842ece3
>>>>


