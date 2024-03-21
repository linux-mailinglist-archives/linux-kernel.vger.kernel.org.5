Return-Path: <linux-kernel+bounces-110342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0A7885D78
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C536DB210B8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548F8F511;
	Thu, 21 Mar 2024 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1f8+E9f"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F182B673;
	Thu, 21 Mar 2024 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038698; cv=none; b=tylXaZU7aGjWzekHDSZYAcK8ofqXY19YuddmSnGwjCedkwLU0jAvOMMzmAiKdpX0GGOc8qNZbvg6ZTW3q7CmDWg/xc++qI9HWYL01G2MB2V0VBswPaxRSf6JIY9ulWHatYNAuJLFzYeh63pOxuSUPaEbQ6VhcN60yqKa9WDZupI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038698; c=relaxed/simple;
	bh=54H1Nf53rtUug2KCAAmn2XNOdsGZzEyQgpLJ0TMFmAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWXNZcAm7LPnjJtTWkeN998nXiocL94mW3JozwjUtsJTKjTkoT4sfbp+Twzm6ILozDUCA9q0LLmMpgFrBxCd+f7DoB9kyxJ0ao7v91xbcSDUoqo0p2Y61HGbGnF24Nhyfw1O6kofEXmlO7RXqqd9pWsfhMu9DcEIAY4EVpbryA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1f8+E9f; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-430c41f3f89so11350981cf.0;
        Thu, 21 Mar 2024 09:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711038695; x=1711643495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S49dHfkZRhvGjdSr++8beY2YowBVxXV9+RrlXYaulEw=;
        b=L1f8+E9fl478j0VJrmeHxBPM/AXeXgtOcroXLATuInHdEzpaV9ih6M9FXUfm3aNHFg
         9zxZ2UgGvyHRuLM5Ahx/plckWr8XdMa70SDHyE3AIbB6R2ZYrigibiZ2DwrgEczjedKm
         fX9pK8pE5Al+4Rk7Nmx5p1tGeSX5PiRt2l5EikGU22Z2x2A+kKWVtjZooCDxL0Nacndz
         vne4qJ/+fF3xbffKFdjPfAI0sVKODSoeo3JluJNaZ4e3dcG3YkR4CSiZXktZjiU0+YxJ
         QPAfTyHGjVLsSbhlSRpIdsOXEyCvT8WqNfEt9e0CO3cJcRudHW941QXyrTz0GdUx+byv
         72fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711038695; x=1711643495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S49dHfkZRhvGjdSr++8beY2YowBVxXV9+RrlXYaulEw=;
        b=ax9fsHFrZL6/FULB0Iw2X+H/QhojLUZY3gF+3ECsn8Tkfe9lM+D5MjbLVGIqeS6qMK
         S2OWIePGroas/AQvlnRNS59YPrCAbbYrYLgCrwanKyaD3CLgjtW2bD4ruj3qZkpNqAOV
         eNY+A3+6J3unKBkgWfJDBOKfJ9jS5CBaXz6/RUOGF0GkUewDn7vQI4DbX9OqiooB3hUF
         UFWbgcNDE1ncrFtLuXDSMBdQHMkrx4aw+xJ/CElt/C9BOU0GL1Qh/n4+T74Ru7O2JVT9
         cSHUSk7sounaW1hC2ZyvwNPNQPpd/r6V5lrz6TkS6GreaLUBeID07UZ8lq2iRffrT8+w
         /U3A==
X-Forwarded-Encrypted: i=1; AJvYcCVwdYQZGfZ6DTi0Hxr+Gq4aGxWRtbm1EH5ypKIb0OYZhfjv+OgT6+Yd6bomYgqCGgC/ihJ0PbZscX/Dd4o4xAucOh70irEPdV+xi1Bl9fk7BSXVo0mSKkZMnsD7eILQMTDC0B+M
X-Gm-Message-State: AOJu0Yw7Hiqm+1NQzHYTi5xQoUn2yoZcUZiskb6IAT+n2TwFKLd0WUH7
	aUCirmwx9ZpPs/fGSsvi998giTbRXYcQ5S0KJ3er2fqAPLPMXsj/
X-Google-Smtp-Source: AGHT+IF4Jq5m/V0phrC5UTN1Th0lDfZYqyJ+t4y8mBiUV/M6F4ub6yCG+Ho67J65LuMJkLnvA9JI2g==
X-Received: by 2002:ac8:7d92:0:b0:430:d489:38e2 with SMTP id c18-20020ac87d92000000b00430d48938e2mr75298qtd.0.1711038695185;
        Thu, 21 Mar 2024 09:31:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id fk25-20020a05622a559900b00430b5dcac34sm30489qtb.8.2024.03.21.09.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 09:31:34 -0700 (PDT)
Message-ID: <11b2a4d1-66d8-4bcf-b1a8-20a635b99cc4@gmail.com>
Date: Thu, 21 Mar 2024 09:31:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fix EEE support for MT7531 and MT7988 SoC switch
Content-Language: en-US
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
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
 <0fbe7ba2-6529-4118-b050-8ea76d28b712@arinc9.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <0fbe7ba2-6529-4118-b050-8ea76d28b712@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/21/24 09:09, Arınç ÜNAL wrote:
> On 20.03.2024 00:31, Florian Fainelli wrote:
>> On 3/19/24 13:26, Daniel Golle wrote:
>>> On Tue, Mar 19, 2024 at 08:38:03PM +0100, Andrew Lunn wrote:
>>>>> I would argue that EEE advertisement on the PHY should be enabled by
>>>>> default.
>>>>
>>>> That is an open question at the moment. For some use cases, it can add
>>>> extra delay and jitter which can cause problems. I've heard people
>>>> doing PTP don't like EEE for example.
>>>
>>> MediaTek consumer-grade hardware doesn't support PTP and hence that
>>> quite certainly won't ever be an issue with all switch ICs supported
>>> by the mt7530 driver.
>>>
>>> I'd rather first change the (configuration) default in OpenWrt (which
>>> is arguable the way most people are using this hardware), also because
>>> that will be more visible/obvious for users. Or even just make EEE
>>> configurable in the LuCI web-UI as a first step so users start playing
>>> with it.
>>>
>>> After all, I also have a hard time imagining that MediaTek disabled
>>> EEE in their downstream driver for no reason:
>>>
>>> https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/24091177a18ba7f2dd8d928a8f5b27b14df46b16
>>
>> EEE tends to be an interoperability trap and typically results in 
>> unexplained link drops with different link partners which are 
>> difficult to debug and root cause. It would be great to have more 
>> context as to why it was disabled in the downstream tree to know what 
>> we are up against, though I would not be surprised if there had been a 
>> number of issues reported.
> 
> I have started testing MT7531 with EEE enabled and immediately experienced
> frames that wouldn't egress the switch or improperly received on the link
> partner.
> 
> SoC MAC       <-EEE off-> MT7531 P6 MAC (acting as PHY)
> MT7531 P0 MAC <-EEE on -> MT7531 P0 PHY
> MT7531 P0 PHY <-EEE on -> Computer connected with twisted pair

OK, so this is intended to describe that the SoC's Ethernet MAC link to 
the integrated switch did not use EEE only the user-facing ports. That 
makes sense because it's all digital logic and you are not going to be 
seeing much power saving from having EEE enabled between the SoC's 
Ethernet MAC and CPU port of the switch, that said, however, I wonder if 
this has an impact on any form of flow control within the switch that is 
reacting to LPI and you need EEE to be enabled end-to-end?

> 
> I've tested pinging from the SoC's CPU. Packet capturing on the twisted
> pair computer showed very few frames were being received.
> 
> # ping 192.168.2.2
> PING 192.168.2.2 (192.168.2.2): 56 data bytes
> 64 bytes from 192.168.2.2: seq=36 ttl=64 time=0.486 ms
> ^C
> --- 192.168.2.2 ping statistics ---
> 64 packets transmitted, 1 packets received, 98% packet loss
> round-trip min/avg/max = 0.486/0.486/0.486 ms
> 
> It seems there's less loss when frames are passed more frequently.

That would point to an issue getting in and out of LPI, do you see these 
packet losses even with different LPI timeouts?

> 
> # ping 192.168.2.2 -i 0.06
> PING 192.168.2.2 (192.168.2.2): 56 data bytes
> 64 bytes from 192.168.2.2: seq=5 ttl=64 time=0.285 ms
> 64 bytes from 192.168.2.2: seq=6 ttl=64 time=0.155 ms
> 64 bytes from 192.168.2.2: seq=7 ttl=64 time=0.243 ms
> 64 bytes from 192.168.2.2: seq=8 ttl=64 time=0.139 ms
> 64 bytes from 192.168.2.2: seq=9 ttl=64 time=0.224 ms
> 64 bytes from 192.168.2.2: seq=68 ttl=64 time=0.350 ms
> 64 bytes from 192.168.2.2: seq=69 ttl=64 time=0.242 ms
> 64 bytes from 192.168.2.2: seq=70 ttl=64 time=0.230 ms
> 64 bytes from 192.168.2.2: seq=71 ttl=64 time=0.242 ms
> 64 bytes from 192.168.2.2: seq=72 ttl=64 time=0.276 ms
> 64 bytes from 192.168.2.2: seq=101 ttl=64 time=0.224 ms
> 64 bytes from 192.168.2.2: seq=102 ttl=64 time=0.238 ms
> 64 bytes from 192.168.2.2: seq=103 ttl=64 time=0.240 ms
> ...
> --- 192.168.2.2 ping statistics ---
> 214 packets transmitted, 32 packets received, 85% packet loss
> round-trip min/avg/max = 0.099/0.225/0.350 ms
> 
> # ping 192.168.2.2 -i 0.05
> PING 192.168.2.2 (192.168.2.2): 56 data bytes
> 64 bytes from 192.168.2.2: seq=1 ttl=64 time=0.277 ms
> 64 bytes from 192.168.2.2: seq=2 ttl=64 time=0.240 ms
> 64 bytes from 192.168.2.2: seq=3 ttl=64 time=0.133 ms
> 64 bytes from 192.168.2.2: seq=4 ttl=64 time=0.233 ms
> 64 bytes from 192.168.2.2: seq=5 ttl=64 time=0.223 ms
> 64 bytes from 192.168.2.2: seq=6 ttl=64 time=0.228 ms
> 64 bytes from 192.168.2.2: seq=7 ttl=64 time=0.236 ms
> 64 bytes from 192.168.2.2: seq=8 ttl=64 time=0.150 ms
> ...
> --- 192.168.2.2 ping statistics ---
> 41 packets transmitted, 40 packets received, 2% packet loss
> round-trip min/avg/max = 0.112/0.206/0.277 ms
> 
>>
>> That said as an user, if someone has a well controlled environment, 
>> they should absolutely be able to turn on EEE and see how stable it 
>> holds in their environment.
> 
> Looks like this is the way to go. I'm planning to submit v2 with patch 1
> as:
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 678b51f9cea6..6aa99b590329 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -2458,6 +2458,20 @@ mt7531_setup(struct dsa_switch *ds)
>       /* Reset the switch through internal reset */
>       mt7530_write(priv, MT7530_SYS_CTRL, SYS_CTRL_SW_RST | 
> SYS_CTRL_REG_RST);
> 
> +    /* Allow modifying the trap and enable Energy-Efficient Ethernet 
> (EEE).
> +     */
> +    val = mt7530_read(priv, MT7531_HWTRAP);
> +    val |= CHG_STRAP;
> +    val &= ~EEE_DIS;
> +    mt7530_write(priv, MT7530_MHWTRAP, val);
> +
> +    /* Disable EEE advertisement on the switch PHYs. */
> +    for (i = MT753X_CTRL_PHY_ADDR;
> +         i < MT753X_CTRL_PHY_ADDR + MT7530_NUM_PHYS; i++) {
> +        mt7531_ind_c45_phy_write(priv, i, MDIO_MMD_AN, MDIO_AN_EEE_ADV,
> +                     0);
> +    }
> +
>       if (!priv->p5_sgmii) {
>           mt7531_pll_setup(priv);
>       } else {
> diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
> index a71166e0a7fc..509ed5362236 100644
> --- a/drivers/net/dsa/mt7530.h
> +++ b/drivers/net/dsa/mt7530.h
> @@ -457,6 +457,7 @@ enum mt7531_clk_skew {
>   #define  XTAL_FSEL_M            BIT(7)
>   #define  PHY_EN                BIT(6)
>   #define  CHG_STRAP            BIT(8)
> +#define  EEE_DIS            BIT(4)
> 
>   /* Register for hw trap modification */
>   #define MT7530_MHWTRAP            0x7804
> 
> Arınç

-- 
Florian


