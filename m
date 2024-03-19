Return-Path: <linux-kernel+bounces-108040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E43F880524
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90AA31C22B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A01939FCE;
	Tue, 19 Mar 2024 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="lM95JhmQ"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C786639ACD;
	Tue, 19 Mar 2024 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710874403; cv=none; b=AS6xMQQ+ks7N6+2cEJ0Lcn6BerqKHpl/It3LJgYiw6BFENU8ieW8WHp2xZo9JFO1PDYMUDTssQgfal0u7c97jmw/mC2Y+IO81s95DnkRmu+qLms8nuxwJ0bN3D22oc7OCOgzdpNouxRng/OdNrwuYZ2auCfzXaxd/tT5Wz47DcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710874403; c=relaxed/simple;
	bh=lBQhmh2kAEkLdGWl3ngSGG0TPu+2FbksK509QDmeZTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kD4r6xN4xuG4UmRwlfeas7t9txB5h5wJvd1r4Xvp+pZHVQVGM1mNbo3XKd7MjmNUGnpz4dKxmRvYJ5f7yidfj7xAJ5Pre0+TPgP4sD3KzovislcPzo/9SiaeEp0lDW9rso0+cu9wDH8FNNVjdECmQsGDW4uZ1/47Bd2Ib7ddmZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=lM95JhmQ; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 3CFAFC102C;
	Tue, 19 Mar 2024 18:47:03 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 296531C0005;
	Tue, 19 Mar 2024 18:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710874015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hqjw5/4OqJvrXdntVY+Zb5+0XQA0wPKvw3S8mwvRbX4=;
	b=lM95JhmQPcXUfhGSFLijlkAHQxEuDJdCn0ODi7c+UcwmmUpfUz5Jmcfdg8whXK6f/RpGEz
	DILnO21s+QISwJhhIFPHDkahn+GFdTsYGh6fxmQmpGZ0YCAd3vxPHpNhL4pPLDLYClVeOy
	j/f4yJWXq3s+SSYUK878yVsGwlXhEOl54UiFd63sqdK32b4vlVvIYOa8tznzL60IRo9y6W
	9XAA6+IHnK5e6c5jLGmHIVBP3iT+W3BTBlSsyGVxDaclnM0j2niazvM3zEByu9j3Yh3W2q
	xfVvLW2p+YEmJPJCzvdv1MBwTpN/K/nGFn5NzfcpQbnNeVDfqWTT6Cs5oi5APw==
Message-ID: <00ec9779-19ce-4005-83f0-f4abf37350fc@arinc9.com>
Date: Tue, 19 Mar 2024 21:46:30 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fix EEE support for MT7531 and MT7988 SoC switch
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>
Cc: DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
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
References: <<20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v>
 <ZfnYkuzuvwLepIfC@makrotopia.org>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZfnYkuzuvwLepIfC@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 19.03.2024 21:25, Daniel Golle wrote:
> On Mon, Mar 18, 2024 at 10:46:22AM +0300, Arınç ÜNAL via B4 Relay wrote:
>> Hi.
>>
>> This patch series fixes EEE support for MT7531 and the switch on the MT7988
>> SoC. EEE did not work on MT7531 on most boards before this, it is unclear
>> what's the status on MT7988 SoC switch as I don't have the hardware.
> 
> EEE seems to already work just fine on the MT7988 built-in switch, at least
> on the BPI-R4. I don't think the SoC has bootstrap pins related to EEE like
> stand-alone MT753x may have.
> 
> root@bpi-r4:~# ethtool --show-eee lan1
> EEE settings for lan1:
>      EEE status: disabled
>      Tx LPI: 30 (us)
>      Supported EEE link modes:  100baseT/Full
>                                 1000baseT/Full
>      Advertised EEE link modes:  Not reported
>      Link partner advertised EEE link modes:  100baseT/Full
>                                               1000baseT/Full
> 
> root@bpi-r4:~# ethtool --set-eee lan1 eee on
> root@bpi-r4:~# ethtool --show-eee lan1
> EEE settings for lan1:
>      EEE status: enabled - inactive
>      Tx LPI: 30 (us)
>      Supported EEE link modes:  100baseT/Full
>                                 1000baseT/Full
>      Advertised EEE link modes:  100baseT/Full
>                                  1000baseT/Full
>      Link partner advertised EEE link modes:  Not reported
> root@bpi-r4:~# ethtool --show-eee lan1
> EEE settings for lan1:
>      EEE status: enabled - active
>      Tx LPI: 30 (us)
>      Supported EEE link modes:  100baseT/Full
>                                 1000baseT/Full
>      Advertised EEE link modes:  100baseT/Full
>                                  1000baseT/Full
>      Link partner advertised EEE link modes:  100baseT/Full
>                                               1000baseT/Full
> 
> So don't fix if it ain't broken maybe...?

I would argue that EEE advertisement on the PHY should be enabled by
default. I guess we're supposed to supply that on the PHY driver. Can you
test with this diff applied and see if it works without manually enabling
EEE using ethtool?

diff --git a/drivers/net/phy/mediatek-ge-soc.c b/drivers/net/phy/mediatek-ge-soc.c
index 0f3a1538a8b8..5f482c12018a 100644
--- a/drivers/net/phy/mediatek-ge-soc.c
+++ b/drivers/net/phy/mediatek-ge-soc.c
@@ -978,6 +978,9 @@ static void mt798x_phy_eee(struct phy_device *phydev)
  		       MTK_PHY_RG_LPI_PCS_DSP_CTRL_REG122,
  		       MTK_PHY_LPI_NORM_MSE_HI_THRESH1000_MASK,
  		       FIELD_PREP(MTK_PHY_LPI_NORM_MSE_HI_THRESH1000_MASK, 0xff));
+
+	phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, MDIO_EEE_100TX |
+		      MDIO_EEE_1000T);
  }
  
  static int cal_sw(struct phy_device *phydev, enum CAL_ITEM cal_item,

Arınç

