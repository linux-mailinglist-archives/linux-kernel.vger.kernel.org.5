Return-Path: <linux-kernel+bounces-123007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9988900F1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2A0285514
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D70B84FDA;
	Thu, 28 Mar 2024 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="L0t3ABS+"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F34614294;
	Thu, 28 Mar 2024 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634257; cv=none; b=ckh3ccKtPzJm5G25hKYW/JfjxCluB8W9Cdj+DSbAWmjK2hRPeqoFinTMM5b7nnNCAlBD+zHD8wCgyS9CZIdjVDZQF5GuEQ7oTNgJzBZsODZYdiOO8TwJ83pgQI7d8uqVnWJg9x4LgS/5OZZ2bmU8znv/KvKtwkUlXnhu37jRxvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634257; c=relaxed/simple;
	bh=9RofGKgvHQHCoOZxYF9mlY0Up86pYWDmWdp/w8heN70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+//87SmzBgjqupftgHjpX3+QAWjM2vuD3QjQaEF4GJrZq1r2na0ymxQaGiN+TZvK9Zf13WCYDfv69nQHSsXTsGUTnvhzpqfHBab9mK1DYs4fQMfjk/g8j+YXrdgJ6dS0z1UivnR4VH5pKnSxsMIP13mFQPWiPV5ISWkLlgg0/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=L0t3ABS+; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A70EEE0002;
	Thu, 28 Mar 2024 13:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1711634246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SCQ9RPPj7JeE/FpB6Ks85yrsSUcZMUGlwaZ3/+Rvahc=;
	b=L0t3ABS+aJrpoSGJuuXmYc7StRZ3z4cWfC3QedoR2VNbfToeiUksXB2jyEkMOpht1M7lbO
	5zz/+c0sXtyNVuJgeH+kj7/DRfWQy2mqgcpAJVM/66yCBS9v+HcvHnA9Opex+60VRZvX+c
	MzRYerKviHGbVForqSE13QAkLth0982jkKsk81/8EzY1jo76L64n7pME7gbtCZGhMfJMxU
	dM1YgLBvRUpLzg4QdoAQoZBhE2FoKa3m34erMWCzQF86bjFkJ4aFwX/XwRgQnXlAKuJ6Tt
	ZlYwNJCCYFdK4/4T0yWLFNStjYQiiIwjA4SEOnVtPPF23LHN6I04+DrLK6Sh6g==
Message-ID: <d286ea27-e911-4dcb-9037-b75f22b437b8@arinc9.com>
Date: Thu, 28 Mar 2024 16:57:19 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net: dsa: mt7530: fix enabling EEE on MT7531
 switch on all boards
To: =?UTF-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
 <SkyLake.Huang@mediatek.com>, "olteanv@gmail.com" <olteanv@gmail.com>,
 "andrew@lunn.ch" <andrew@lunn.ch>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
 "opensource@vdorst.com" <opensource@vdorst.com>,
 Sean Wang <Sean.Wang@mediatek.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "dqfext@gmail.com"
 <dqfext@gmail.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "daniel@makrotopia.org" <daniel@makrotopia.org>,
 "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>
Cc: "bartel.eerdekens@constell8.be" <bartel.eerdekens@constell8.be>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "mithat.guner@xeront.com" <mithat.guner@xeront.com>,
 "erkin.bozoglu@xeront.com" <erkin.bozoglu@xeront.com>
References: <20240321-for-net-mt7530-fix-eee-for-mt7531-mt7988-v2-0-9af9d5041bfe@arinc9.com>
 <20240321-for-net-mt7530-fix-eee-for-mt7531-mt7988-v2-1-9af9d5041bfe@arinc9.com>
 <70bc9c503c8ce1ee821a22e0739344229646dbe2.camel@mediatek.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <70bc9c503c8ce1ee821a22e0739344229646dbe2.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

Hello Huang.

It's great to see someone from MediaTek providing information on this
intellectual property.

On 27.03.2024 12:51, SkyLake Huang (黃啟澤) wrote:
> You may try to set bit 6 of CL45 register dev=0x1f,
> reg=0x403(PLL_GROUP_CTL_REG), which is an internal EEE switch called
> RG_SYSPLL_DMY2.
> 
> Read it out first with "switch command", if you have it:
> root@OpenWrt:/# switch phy cl45 r 0 0x1f 0x403
>    Phy read dev_num=0x1f, reg=0x403, value=0x1091
> 
> And then set bit 6:
> root@OpenWrt:/# $ switch phy cl45 w 0 0x1f 0x403 0x10d1
> root@OpenWrt:/# ethtool --set-eee lan1 eee on tx-lpi on tx-timer 0x1e
> advertise 0x28
> root@OpenWrt:/# switch phy cl45 r 0 0x7 0x3c
>   Phy read dev_num=0x7, reg=0x3c, value=0x6
> 
> Then you should be able to enable EEE via ethtool without clearing
> EEE_DIS bit of MT7530_HWTRAP.

This won't interfere with the LEDs so it's better. I'll use this method,
thank you! This is the current diff [1].

I suppose bit 6 is an internal EEE switch only on MT7531? I see that bit 6
of 0x403 is unset on MT7530 yet EEE is still enabled on the switch MACs.

There's still packet loss when EEE is enabled by setting
MT7531_RG_SYSPLL_DMY2. Please let me know if MT7531 switch PHYs need
calibration for EEE like MT7986 and MT7988 SoC PHYs.

> If above CL45 command is good for you, I think this can be moved to
> mtk_gephy_config_init() @ mediatek-ge.c, which will lead to cleaner
> implementation.

I disagree. The operation concerns the switch MACs too, not just the switch
PHYs. And the operation is not per switch PHY.

>> +
>> +/* Disable EEE advertisement on the switch PHYs. */
>> +for (i = MT753X_CTRL_PHY_ADDR;
>> +     i < MT753X_CTRL_PHY_ADDR + MT7530_NUM_PHYS; i++) {
>> +mt7531_ind_c45_phy_write(priv, i, MDIO_MMD_AN, MDIO_AN_EEE_ADV,
>> + 0);
>> +}
> Sorry, I still can't figure out why this is needed since we disable
> MDIO_AN_EEE_ADV in mediatek-ge.c after reading previous threads. Would
> you please provide something else (like dmesg log?) to show that
> settings in mtk_gephy_config_init() may fail?

Disabling EEE advertisement on the PHY driver doesn't fail. To confirm that
and that MDIO_AN_EEE_ADV is populated after it is unset by the PHY driver,
I've done some tests with this diff [2].

Currently:

[    2.189149] MediaTek MT7531 PHY mt7530-0:00: MDIO_AN_EEE_ADV is 00000000
[    2.204792] MediaTek MT7531 PHY mt7530-0:00: MDIO_AN_EEE_ADV is 00000000
[    2.221413] mt7530-mdio mdio-bus:1f wan (uninitialized): PHY [mt7530-0:00] driver [MediaTek MT7531 PHY] (irq=139)
[    2.233762] MediaTek MT7531 PHY mt7530-0:01: MDIO_AN_EEE_ADV is 00000000
[    2.242555] MediaTek MT7531 PHY mt7530-0:01: MDIO_AN_EEE_ADV is 00000000
[    2.259011] mt7530-mdio mdio-bus:1f lan0 (uninitialized): PHY [mt7530-0:01] driver [MediaTek MT7531 PHY] (irq=140)
[    2.271052] MediaTek MT7531 PHY mt7530-0:02: MDIO_AN_EEE_ADV is 00000000
[    2.279842] MediaTek MT7531 PHY mt7530-0:02: MDIO_AN_EEE_ADV is 00000000
[    2.296297] mt7530-mdio mdio-bus:1f lan1 (uninitialized): PHY [mt7530-0:02] driver [MediaTek MT7531 PHY] (irq=141)
[    2.308331] MediaTek MT7531 PHY mt7530-0:03: MDIO_AN_EEE_ADV is 00000000
[    2.317134] MediaTek MT7531 PHY mt7530-0:03: MDIO_AN_EEE_ADV is 00000000
[    2.333597] mt7530-mdio mdio-bus:1f lan2 (uninitialized): PHY [mt7530-0:03] driver [MediaTek MT7531 PHY] (irq=142)
[    2.345653] MediaTek MT7531 PHY mt7530-0:04: MDIO_AN_EEE_ADV is 00000000
[    2.354423] MediaTek MT7531 PHY mt7530-0:04: MDIO_AN_EEE_ADV is 00000000
[    2.370885] mt7530-mdio mdio-bus:1f lan3 (uninitialized): PHY [mt7530-0:04] driver [MediaTek MT7531 PHY] (irq=143)

# mount -t debugfs none /sys/kernel/debug
# echo go > /sys/kernel/debug/mt7530/eee_adv
[   33.055962] mt7530-mdio mdio-bus:1f: phy0: MDIO_AN_EEE_ADV is 00000000
[   33.062943] mt7530-mdio mdio-bus:1f: phy1: MDIO_AN_EEE_ADV is 00000000
[   33.069909] mt7530-mdio mdio-bus:1f: phy2: MDIO_AN_EEE_ADV is 00000000
[   33.076871] mt7530-mdio mdio-bus:1f: phy3: MDIO_AN_EEE_ADV is 00000000
[   33.083822] mt7530-mdio mdio-bus:1f: phy4: MDIO_AN_EEE_ADV is 00000000

# ethtool --show-eee lan0
EEE settings for lan0:
	EEE status: not supported

---

If EEE_DIS is unset or MT7531_RG_SYSPLL_DMY2 is set, MDIO_AN_EEE_ADV is
populated. This also happens on the MT7530 switch:

[    2.254291] MediaTek MT7531 PHY mt7530-0:00: MDIO_AN_EEE_ADV is 00000006
[    2.270015] MediaTek MT7531 PHY mt7530-0:00: MDIO_AN_EEE_ADV is 00000000
[    2.286572] mt7530-mdio mdio-bus:1f wan (uninitialized): PHY [mt7530-0:00] driver [MediaTek MT7531 PHY] (irq=139)
[    2.298921] MediaTek MT7531 PHY mt7530-0:01: MDIO_AN_EEE_ADV is 00000006
[    2.307712] MediaTek MT7531 PHY mt7530-0:01: MDIO_AN_EEE_ADV is 00000000
[    2.324162] mt7530-mdio mdio-bus:1f lan0 (uninitialized): PHY [mt7530-0:01] driver [MediaTek MT7531 PHY] (irq=140)
[    2.336204] MediaTek MT7531 PHY mt7530-0:02: MDIO_AN_EEE_ADV is 00000006
[    2.344974] MediaTek MT7531 PHY mt7530-0:02: MDIO_AN_EEE_ADV is 00000000
[    2.361445] mt7530-mdio mdio-bus:1f lan1 (uninitialized): PHY [mt7530-0:02] driver [MediaTek MT7531 PHY] (irq=141)
[    2.373475] MediaTek MT7531 PHY mt7530-0:03: MDIO_AN_EEE_ADV is 00000006
[    2.382273] MediaTek MT7531 PHY mt7530-0:03: MDIO_AN_EEE_ADV is 00000000
[    2.398728] mt7530-mdio mdio-bus:1f lan2 (uninitialized): PHY [mt7530-0:03] driver [MediaTek MT7531 PHY] (irq=142)
[    2.410780] MediaTek MT7531 PHY mt7530-0:04: MDIO_AN_EEE_ADV is 00000006
[    2.419571] MediaTek MT7531 PHY mt7530-0:04: MDIO_AN_EEE_ADV is 00000000
[    2.436028] mt7530-mdio mdio-bus:1f lan3 (uninitialized): PHY [mt7530-0:04] driver [MediaTek MT7531 PHY] (irq=143)

# mount -t debugfs none /sys/kernel/debug
# echo go > /sys/kernel/debug/mt7530/eee_adv
[    8.731911] mt7530-mdio mdio-bus:1f: phy0: MDIO_AN_EEE_ADV is 00000006
[    8.738908] mt7530-mdio mdio-bus:1f: phy1: MDIO_AN_EEE_ADV is 00000006
[    8.745861] mt7530-mdio mdio-bus:1f: phy2: MDIO_AN_EEE_ADV is 00000006
[    8.752816] mt7530-mdio mdio-bus:1f: phy3: MDIO_AN_EEE_ADV is 00000006
[    8.759776] mt7530-mdio mdio-bus:1f: phy4: MDIO_AN_EEE_ADV is 00000006

# ethtool --show-eee lan0
EEE settings for lan0:
	EEE status: enabled - inactive
	Tx LPI: disabled
	Supported EEE link modes:  100baseT/Full
	                           1000baseT/Full
	Advertised EEE link modes:  100baseT/Full
	                            1000baseT/Full
	Link partner advertised EEE link modes:  Not reported

---

If MDIO_AN_EEE_ADV is unset before the PHY driver kicks in, it stays unset:

[    2.266561] MediaTek MT7531 PHY mt7530-0:00: MDIO_AN_EEE_ADV is 00000000
[    2.282268] MediaTek MT7531 PHY mt7530-0:00: MDIO_AN_EEE_ADV is 00000000
[    2.298832] mt7530-mdio mdio-bus:1f wan (uninitialized): PHY [mt7530-0:00] driver [MediaTek MT7531 PHY] (irq=139)
[    2.311187] MediaTek MT7531 PHY mt7530-0:01: MDIO_AN_EEE_ADV is 00000000
[    2.319976] MediaTek MT7531 PHY mt7530-0:01: MDIO_AN_EEE_ADV is 00000000
[    2.336443] mt7530-mdio mdio-bus:1f lan0 (uninitialized): PHY [mt7530-0:01] driver [MediaTek MT7531 PHY] (irq=140)
[    2.348488] MediaTek MT7531 PHY mt7530-0:02: MDIO_AN_EEE_ADV is 00000000
[    2.357280] MediaTek MT7531 PHY mt7530-0:02: MDIO_AN_EEE_ADV is 00000000
[    2.373728] mt7530-mdio mdio-bus:1f lan1 (uninitialized): PHY [mt7530-0:02] driver [MediaTek MT7531 PHY] (irq=141)
[    2.385780] MediaTek MT7531 PHY mt7530-0:03: MDIO_AN_EEE_ADV is 00000000
[    2.394551] MediaTek MT7531 PHY mt7530-0:03: MDIO_AN_EEE_ADV is 00000000
[    2.411011] mt7530-mdio mdio-bus:1f lan2 (uninitialized): PHY [mt7530-0:03] driver [MediaTek MT7531 PHY] (irq=142)
[    2.423047] MediaTek MT7531 PHY mt7530-0:04: MDIO_AN_EEE_ADV is 00000000
[    2.431849] MediaTek MT7531 PHY mt7530-0:04: MDIO_AN_EEE_ADV is 00000000
[    2.448324] mt7530-mdio mdio-bus:1f lan3 (uninitialized): PHY [mt7530-0:04] driver [MediaTek MT7531 PHY] (irq=143)

# mount -t debugfs none /sys/kernel/debug
# echo go > /sys/kernel/debug/mt7530/eee_adv
[   33.906140] mt7530-mdio mdio-bus:1f: phy0: MDIO_AN_EEE_ADV is 00000000
[   33.913121] mt7530-mdio mdio-bus:1f: phy1: MDIO_AN_EEE_ADV is 00000000
[   33.920094] mt7530-mdio mdio-bus:1f: phy2: MDIO_AN_EEE_ADV is 00000000
[   33.927054] mt7530-mdio mdio-bus:1f: phy3: MDIO_AN_EEE_ADV is 00000000
[   33.934005] mt7530-mdio mdio-bus:1f: phy4: MDIO_AN_EEE_ADV is 00000000

# ethtool --show-eee lan0
EEE settings for lan0:
	EEE status: disabled
	Tx LPI: disabled
	Supported EEE link modes:  100baseT/Full
	                           1000baseT/Full
	Advertised EEE link modes:  Not reported
	Link partner advertised EEE link modes:  Not reported

[1]
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index fb3d2a53bbd9..9a351d11f349 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2630,18 +2630,25 @@ mt7531_setup(struct dsa_switch *ds)
  	mt7530_rmw(priv, MT7531_GPIO_MODE0, MT7531_GPIO0_MASK,
  		   MT7531_GPIO0_INTERRUPT);
  
-	/* Enable PHY core PLL, since phy_device has not yet been created
-	 * provided for phy_[read,write]_mmd_indirect is called, we provide
-	 * our own mt7531_ind_mmd_phy_[read,write] to complete this
-	 * function.
+	/* Enable Energy-Efficient Ethernet (EEE) and PHY core PLL, since
+	 * phy_device has not yet been created provided for
+	 * phy_[read,write]_mmd_indirect is called, we provide our own
+	 * mt7531_ind_mmd_phy_[read,write] to complete this function.
  	 */
  	val = mt7531_ind_c45_phy_read(priv, MT753X_CTRL_PHY_ADDR,
  				      MDIO_MMD_VEND2, CORE_PLL_GROUP4);
-	val |= MT7531_PHY_PLL_BYPASS_MODE;
+	val |= MT7531_RG_SYSPLL_DMY2 | MT7531_PHY_PLL_BYPASS_MODE;
  	val &= ~MT7531_PHY_PLL_OFF;
  	mt7531_ind_c45_phy_write(priv, MT753X_CTRL_PHY_ADDR, MDIO_MMD_VEND2,
  				 CORE_PLL_GROUP4, val);
  
+	/* Disable EEE advertisement on the switch PHYs. */
+	for (i = MT753X_CTRL_PHY_ADDR;
+	     i < MT753X_CTRL_PHY_ADDR + MT7530_NUM_PHYS; i++) {
+		mt7531_ind_c45_phy_write(priv, i, MDIO_MMD_AN, MDIO_AN_EEE_ADV,
+					 0);
+	}
+
  	mt7531_setup_common(ds);
  
  	/* Setup VLAN ID 0 for VLAN-unaware bridges */
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index d17b318e6ee4..9439db495001 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -616,6 +616,7 @@ enum mt7531_clk_skew {
  #define  RG_SYSPLL_DDSFBK_EN		BIT(12)
  #define  RG_SYSPLL_BIAS_EN		BIT(11)
  #define  RG_SYSPLL_BIAS_LPF_EN		BIT(10)
+#define  MT7531_RG_SYSPLL_DMY2		BIT(6)
  #define  MT7531_PHY_PLL_OFF		BIT(5)
  #define  MT7531_PHY_PLL_BYPASS_MODE	BIT(4)
  

[2]
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 35906e669259..fb3d2a53bbd9 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -845,6 +845,22 @@ static ssize_t reg_value_write(struct file *filp, const char __user *buffer,
  	return count;
  }
  
+static ssize_t eee_adv_write(struct file *filp, const char __user *buffer,
+			     size_t count, loff_t *ppos)
+{
+	struct mt7530_priv *priv = filp->private_data;
+	int i;
+
+	for (i = MT753X_CTRL_PHY_ADDR;
+	     i < MT753X_CTRL_PHY_ADDR + MT7530_NUM_PHYS; i++) {
+		dev_info(priv->dev, "phy%d: MDIO_AN_EEE_ADV is %08x", i,
+			 mt7531_ind_c45_phy_read(priv, i, MDIO_MMD_AN,
+						 MDIO_AN_EEE_ADV));
+	}
+
+	return count;
+}
+
  static const struct file_operations reg_address_fops = {
  	.owner = THIS_MODULE,
  	.open = simple_open,
@@ -859,6 +875,12 @@ static const struct file_operations reg_value_fops = {
  	.write = reg_value_write,
  };
  
+static const struct file_operations eee_adv_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.write = eee_adv_write,
+};
+
  static void mt7530_debugfs_init(struct mt7530_priv *priv)
  {
  	struct dentry *dir;
@@ -869,6 +891,7 @@ static void mt7530_debugfs_init(struct mt7530_priv *priv)
  
  	debugfs_create_file("reg_address", 0644, dir, priv, &reg_address_fops);
  	debugfs_create_file("reg_value", 0644, dir, priv, &reg_value_fops);
+	debugfs_create_file("eee_adv", 0644, dir, priv, &eee_adv_fops);
  }
  
  static void
diff --git a/drivers/net/phy/mediatek-ge.c b/drivers/net/phy/mediatek-ge.c
index e8822adbf3bc..aacef7091d8f 100644
--- a/drivers/net/phy/mediatek-ge.c
+++ b/drivers/net/phy/mediatek-ge.c
@@ -71,9 +71,15 @@ static int mtk_gephy_write_page(struct phy_device *phydev, int page)
  
  static void mtk_gephy_config_init(struct phy_device *phydev)
  {
+	dev_info(&phydev->mdio.dev, "MDIO_AN_EEE_ADV is %08x",
+		 phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV));
+
  	/* Disable EEE */
  	phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0);
  
+	dev_info(&phydev->mdio.dev, "MDIO_AN_EEE_ADV is %08x",
+		 phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV));
+
  	/* Enable HW auto downshift */
  	phy_modify_paged(phydev, MTK_PHY_PAGE_EXTENDED, 0x14, 0, BIT(4));
  

Arınç

