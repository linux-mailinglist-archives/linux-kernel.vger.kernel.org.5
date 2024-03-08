Return-Path: <linux-kernel+bounces-96774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C11876147
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FBE3282C2E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8916C537E1;
	Fri,  8 Mar 2024 09:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="D0K6lOUP"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F114F61C;
	Fri,  8 Mar 2024 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709891498; cv=none; b=YShtpEaHjSYJCDOdScohe9qIjh9SMX4bWpqSkFyPyC3az7WMdd28op4mI9E9K4CJVT2msm03I1b46wKqdJ7DeoMCft03joSh5GOXjnNGEZovBCLHy+T9J3S9gZDNjkpun9Xs0077VolkLoHSAkq0cOTkL54nKK9FBZMLKpmxswE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709891498; c=relaxed/simple;
	bh=NKrNSC6qhuvRFx3Kh2XwhCFqJtnAJEyyi+jeQA3amI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukmAwsqjQUIoUtlSmFzxlW372ef2qsGLcWVKlOxHZL+n31/4TU2XU7XEdDx0ZOjUJP06miR/wPfWqzSCFvLgtS9H6pKCutu3F9+TpoVeOzYWXog+g74hzHv5tqCQQgISiZrOnTGx3PbGgkkjz64xaR6iPMVba4Zy+2DEkrXoCcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=D0K6lOUP; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B74EEFF804;
	Fri,  8 Mar 2024 09:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1709891488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NMu+zpEb92qbzBeVgPiblvfdISaMvD+q1a3C/ZP1pJM=;
	b=D0K6lOUPKOvYThoRiVrI/cJLIHCcWiTvLdN7iOIERU8NK/zaiyR5BcLnFAEVe6KuVirJQz
	TBx2ewm/WinDcKzVvgX6D5rP8YVzood99ICA6jU9dJXUEYzgxntKiVaOrOVzGOHrhXEBAs
	jKcr4isEG6MOmDk3yQQmlNdZoqTDM5dfScHDJ2K8ASVy2BDfaJmqplLifN8micU6B+LxS4
	Bms07a1GO7DlrHyRBlsuxnUS+P84LWegUZFqSNvN4AkqPoeZ5VGqYRFNfsq9wEpZeU2xaZ
	b6b/p8La7XFJdD5SyFcLiFs+AvLqvjI4Q7oNJjpfpDMv7GWWc6ABtAcuWj93Ow==
Message-ID: <6064ba52-2470-4c56-958c-35632187f148@arinc9.com>
Date: Fri, 8 Mar 2024 12:51:15 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: mt7530: disable LEDs before reset
To: Justin Swartz <justin.swartz@risingedge.co.za>,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240305043952.21590-1-justin.swartz@risingedge.co.za>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240305043952.21590-1-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

Hey Justin.

I couldn't find anything on the MT7621 Giga Switch Programming Guide v0.3
document regarding which pin corresponds to which bit on the HWTRAP
register. There's only this mention on the LED controller section,
"hardware traps and LEDs share the same pins in GSW". But page 16 of the
schematics document for Banana Pi BPI-R2 [1] fully documents this.

The HWTRAP register is populated right after power comes back after the
switch chip is reset [2]. This means any active link before the reset will
go away so the high/low state of the pins will go back to being dictated by
the bootstrapping design of the board. The HWTRAP register will be
populated before a link can be set up.

In conclusion, I don't see any need to disable the LED controller before
resetting the switch chip.

[1] https://wiki.banana-pi.org/Banana_Pi_BPI-R2#Documents

[2] I've tested it on my MT7621AT board with a 40MHz XTAL frequency and a
board with standalone MT7530 with 25MHz XTAL frequency.

While the kernel was booting, before the DSA subdriver kicks in:
- For the board with 40 MHz XTAL: I've connected a Vcc pin to ESW_P3_LED_0
   to set it high.
- For the board with 25 MHz XTAL: I've connected a GND pin to ESW_P3_LED_0
   to set it low.

Board with 40 MHz XTAL:
[    2.359428] mt7530-mdio mdio-bus:1f: MT7530 adapts as multi-chip module
[    2.374918] mt7530-mdio mdio-bus:1f: xtal is 25MHz

Board with 25 MHz XTAL:
[    4.324672] mt7530-mdio mdio-bus:1f: xtal is 40MHz

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 51d7b816dd02..beab5e5558d0 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2216,6 +2216,15 @@ mt7530_setup(struct dsa_switch *ds)
  		return ret;
  	}
  
+	if ((val & HWTRAP_XTAL_MASK) == HWTRAP_XTAL_25MHZ)
+		dev_info(priv->dev, "xtal is 25MHz\n");
+
+	if ((val & HWTRAP_XTAL_MASK) == HWTRAP_XTAL_40MHZ)
+		dev_info(priv->dev, "xtal is 40MHz\n");
+
+	if ((val & HWTRAP_XTAL_MASK) == HWTRAP_XTAL_20MHZ)
+		dev_info(priv->dev, "xtal is 20MHz\n");
+
  	id = mt7530_read(priv, MT7530_CREV);
  	id >>= CHIP_NAME_SHIFT;
  	if (id != MT7530_ID) {

Arınç

On 5.03.2024 07:39, Justin Swartz wrote:
> Disable LEDs just before resetting the MT7530 to avoid
> situations where the ESW_P4_LED_0 and ESW_P3_LED_0 pin
> states may cause an unintended external crystal frequency
> to be selected.
> 
> The HT_XTAL_FSEL (External Crystal Frequency Selection)
> field of HWTRAP (the Hardware Trap register) stores a
> 2-bit value that represents the state of the ESW_P4_LED_0
> and ESW_P4_LED_0 pins (seemingly) sampled just after the
> MT7530 has been reset, as:
> 
>      ESW_P4_LED_0    ESW_P3_LED_0    Frequency
>      -----------------------------------------
>      0               1               20MHz
>      1               0               40MHz
>      1               1               25MHz
> 
> The value of HT_XTAL_FSEL is bootstrapped by pulling
> ESW_P4_LED_0 and ESW_P3_LED_0 up or down accordingly,
> but:
> 
>    if a 40MHz crystal has been selected and
>    the ESW_P3_LED_0 pin is high during reset,
> 
>    or a 20MHz crystal has been selected and
>    the ESW_P4_LED_0 pin is high during reset,
> 
>    then the value of HT_XTAL_FSEL will indicate
>    that a 25MHz crystal is present.
> 
> By default, the state of the LED pins is PHY controlled
> to reflect the link state.
> 
> To illustrate, if a board has:
> 
>    5 ports with active low LED control,
>    and HT_XTAL_FSEL bootstrapped for 40MHz.
> 
> When the MT7530 is powered up without any external
> connection, only the LED associated with Port 3 is
> illuminated as ESW_P3_LED_0 is low.
> 
> In this state, directly after mt7530_setup()'s reset
> is performed, the HWTRAP register (0x7800) reflects
> the intended HT_XTAL_FSEL (HWTRAP bits 10:9) of 40MHz:
> 
>    mt7530-mdio mdio-bus:1f: mt7530_read: 00007800 == 00007dcf
> 
>    >>> bin(0x7dcf >> 9 & 0b11)
>    '0b10'
> 
> But if a cable is connected to Port 3 and the link
> is active before mt7530_setup()'s reset takes place,
> then HT_XTAL_FSEL seems to be set for 25MHz:
> 
>    mt7530-mdio mdio-bus:1f: mt7530_read: 00007800 == 00007fcf
> 
>    >>> bin(0x7fcf >> 9 & 0b11)
>    '0b11'
> 
> Once HT_XTAL_FSEL reflects 25MHz, none of the ports
> are functional until the MT7621 (or MT7530 itself)
> is reset.
> 
> By disabling the LED pins just before reset, the chance
> of an unintended HT_XTAL_FSEL value is reduced.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---
>   drivers/net/dsa/mt7530.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 3c1f65759..8fa113126 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -2238,6 +2238,12 @@ mt7530_setup(struct dsa_switch *ds)
>   		}
>   	}
>   
> +	/* Disable LEDs before reset to prevent the MT7530 sampling a
> +	 * potentially incorrect HT_XTAL_FSEL value.
> +	 */
> +	mt7530_write(priv, MT7530_LED_EN, 0);
> +	usleep_range(1000, 1100);
> +
>   	/* Reset whole chip through gpio pin or memory-mapped registers for
>   	 * different type of hardware
>   	 */

