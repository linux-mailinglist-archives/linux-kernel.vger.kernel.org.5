Return-Path: <linux-kernel+bounces-110314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C89885D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677251C20821
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B3312C558;
	Thu, 21 Mar 2024 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="UIyozjzi"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C278662F;
	Thu, 21 Mar 2024 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037401; cv=none; b=AUhy8u0T7IfhwrJ1h0goVFHqEuydb/WzxIbInmEhXYwdKdkBzHqyDQ6XlN6vokPY78cqABgZ0MCLMIzMIKZgvwXG3vc4DI7xv3OOOFJaX4leN9uN9HNvhIqUrixIi5pVX2v1iZpxWBg7rhDkv1dMioE38Nv3vSCCj07rGxdDy4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037401; c=relaxed/simple;
	bh=/COouxoyd/nzT49ztSHw7buRXFW3G2DZYDfUjusNGhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qsgUONZqueW/o7Sw88YWo4DU9PsIIMJf2EzTToM7cSRBNmhG94EQqQEMHj0BpY5UjkmZHD0fhKd+2/pe58IyIzYUyNxEWnGDZ8x6pO+QaMyqdx7le+gZ3rdN+s3Rl61VVdielCEzQZZhJPiz2dbfYd09n9PBpAENmqXXxIFgjPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=UIyozjzi; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 458D240008;
	Thu, 21 Mar 2024 16:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1711037391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrChM2bMyOZ06ublb4gFN2AgR2OzWBbSVut/5tc1iQ8=;
	b=UIyozjziieWmwYdBiKJK/bXdSKQEvgtMNVegmQmAe4mwYJCgXOAcMxQvzG/DPZ+XWLySwG
	pNYm2J+wW5gZocJM+aMbHexmQsarqcic1FreLWeSQcv/adAf1+zEBm9morWBlpBTtjmzaM
	jEyUrtNPdC/7tmq/ZMpdzYUbmUVhrVIHvtYvbl0OQTMlEf/BCKEymvLVx74RI3wAp7kzPW
	HamM2GmpYUIWzXrZHsiovGBhJ0C/Qa3osDjZwLWmXEx0n81f1ncu5iW/T9W+Zif/uoHtAG
	8HcSm9MGLTbFzIa88JkwITb5Ur/PiTQ5p1VUbReXCsxWNOxvua0UyZY8/IR9qQ==
Message-ID: <0fbe7ba2-6529-4118-b050-8ea76d28b712@arinc9.com>
Date: Thu, 21 Mar 2024 19:09:25 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fix EEE support for MT7531 and MT7988 SoC switch
To: Florian Fainelli <f.fainelli@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>
Cc: DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>,
 Russell King <linux@armlinux.org.uk>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v>
 <ZfnYkuzuvwLepIfC@makrotopia.org>
 <00ec9779-19ce-4005-83f0-f4abf37350fc@arinc9.com>
 <6cb585f6-6da8-45a2-a28b-2fb556f95672@lunn.ch>
 <Zfn1DxkEa3u-f7l2@makrotopia.org>
 <38798882-c033-4949-9446-4c6f15c25ebe@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <38798882-c033-4949-9446-4c6f15c25ebe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 20.03.2024 00:31, Florian Fainelli wrote:
> On 3/19/24 13:26, Daniel Golle wrote:
>> On Tue, Mar 19, 2024 at 08:38:03PM +0100, Andrew Lunn wrote:
>>>> I would argue that EEE advertisement on the PHY should be enabled by
>>>> default.
>>>
>>> That is an open question at the moment. For some use cases, it can add
>>> extra delay and jitter which can cause problems. I've heard people
>>> doing PTP don't like EEE for example.
>>
>> MediaTek consumer-grade hardware doesn't support PTP and hence that
>> quite certainly won't ever be an issue with all switch ICs supported
>> by the mt7530 driver.
>>
>> I'd rather first change the (configuration) default in OpenWrt (which
>> is arguable the way most people are using this hardware), also because
>> that will be more visible/obvious for users. Or even just make EEE
>> configurable in the LuCI web-UI as a first step so users start playing
>> with it.
>>
>> After all, I also have a hard time imagining that MediaTek disabled
>> EEE in their downstream driver for no reason:
>>
>> https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/24091177a18ba7f2dd8d928a8f5b27b14df46b16
> 
> EEE tends to be an interoperability trap and typically results in unexplained link drops with different link partners which are difficult to debug and root cause. It would be great to have more context as to why it was disabled in the downstream tree to know what we are up against, though I would not be surprised if there had been a number of issues reported.

I have started testing MT7531 with EEE enabled and immediately experienced
frames that wouldn't egress the switch or improperly received on the link
partner.

SoC MAC       <-EEE off-> MT7531 P6 MAC (acting as PHY)
MT7531 P0 MAC <-EEE on -> MT7531 P0 PHY
MT7531 P0 PHY <-EEE on -> Computer connected with twisted pair

I've tested pinging from the SoC's CPU. Packet capturing on the twisted
pair computer showed very few frames were being received.

# ping 192.168.2.2
PING 192.168.2.2 (192.168.2.2): 56 data bytes
64 bytes from 192.168.2.2: seq=36 ttl=64 time=0.486 ms
^C
--- 192.168.2.2 ping statistics ---
64 packets transmitted, 1 packets received, 98% packet loss
round-trip min/avg/max = 0.486/0.486/0.486 ms

It seems there's less loss when frames are passed more frequently.

# ping 192.168.2.2 -i 0.06
PING 192.168.2.2 (192.168.2.2): 56 data bytes
64 bytes from 192.168.2.2: seq=5 ttl=64 time=0.285 ms
64 bytes from 192.168.2.2: seq=6 ttl=64 time=0.155 ms
64 bytes from 192.168.2.2: seq=7 ttl=64 time=0.243 ms
64 bytes from 192.168.2.2: seq=8 ttl=64 time=0.139 ms
64 bytes from 192.168.2.2: seq=9 ttl=64 time=0.224 ms
64 bytes from 192.168.2.2: seq=68 ttl=64 time=0.350 ms
64 bytes from 192.168.2.2: seq=69 ttl=64 time=0.242 ms
64 bytes from 192.168.2.2: seq=70 ttl=64 time=0.230 ms
64 bytes from 192.168.2.2: seq=71 ttl=64 time=0.242 ms
64 bytes from 192.168.2.2: seq=72 ttl=64 time=0.276 ms
64 bytes from 192.168.2.2: seq=101 ttl=64 time=0.224 ms
64 bytes from 192.168.2.2: seq=102 ttl=64 time=0.238 ms
64 bytes from 192.168.2.2: seq=103 ttl=64 time=0.240 ms
..
--- 192.168.2.2 ping statistics ---
214 packets transmitted, 32 packets received, 85% packet loss
round-trip min/avg/max = 0.099/0.225/0.350 ms

# ping 192.168.2.2 -i 0.05
PING 192.168.2.2 (192.168.2.2): 56 data bytes
64 bytes from 192.168.2.2: seq=1 ttl=64 time=0.277 ms
64 bytes from 192.168.2.2: seq=2 ttl=64 time=0.240 ms
64 bytes from 192.168.2.2: seq=3 ttl=64 time=0.133 ms
64 bytes from 192.168.2.2: seq=4 ttl=64 time=0.233 ms
64 bytes from 192.168.2.2: seq=5 ttl=64 time=0.223 ms
64 bytes from 192.168.2.2: seq=6 ttl=64 time=0.228 ms
64 bytes from 192.168.2.2: seq=7 ttl=64 time=0.236 ms
64 bytes from 192.168.2.2: seq=8 ttl=64 time=0.150 ms
..
--- 192.168.2.2 ping statistics ---
41 packets transmitted, 40 packets received, 2% packet loss
round-trip min/avg/max = 0.112/0.206/0.277 ms

> 
> That said as an user, if someone has a well controlled environment, they should absolutely be able to turn on EEE and see how stable it holds in their environment.

Looks like this is the way to go. I'm planning to submit v2 with patch 1
as:

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 678b51f9cea6..6aa99b590329 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2458,6 +2458,20 @@ mt7531_setup(struct dsa_switch *ds)
  	/* Reset the switch through internal reset */
  	mt7530_write(priv, MT7530_SYS_CTRL, SYS_CTRL_SW_RST | SYS_CTRL_REG_RST);
  
+	/* Allow modifying the trap and enable Energy-Efficient Ethernet (EEE).
+	 */
+	val = mt7530_read(priv, MT7531_HWTRAP);
+	val |= CHG_STRAP;
+	val &= ~EEE_DIS;
+	mt7530_write(priv, MT7530_MHWTRAP, val);
+
+	/* Disable EEE advertisement on the switch PHYs. */
+	for (i = MT753X_CTRL_PHY_ADDR;
+	     i < MT753X_CTRL_PHY_ADDR + MT7530_NUM_PHYS; i++) {
+		mt7531_ind_c45_phy_write(priv, i, MDIO_MMD_AN, MDIO_AN_EEE_ADV,
+					 0);
+	}
+
  	if (!priv->p5_sgmii) {
  		mt7531_pll_setup(priv);
  	} else {
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index a71166e0a7fc..509ed5362236 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -457,6 +457,7 @@ enum mt7531_clk_skew {
  #define  XTAL_FSEL_M			BIT(7)
  #define  PHY_EN				BIT(6)
  #define  CHG_STRAP			BIT(8)
+#define  EEE_DIS			BIT(4)
  
  /* Register for hw trap modification */
  #define MT7530_MHWTRAP			0x7804

Arınç

