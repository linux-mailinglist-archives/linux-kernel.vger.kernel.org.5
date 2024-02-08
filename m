Return-Path: <linux-kernel+bounces-58771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2D584EB82
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39451F2D9A7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1787B4F895;
	Thu,  8 Feb 2024 22:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbwdIjAk"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF3F4F613;
	Thu,  8 Feb 2024 22:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430715; cv=none; b=oC37QKpSLogSydcCze3JDqx2HTcZ8mFFtNAHETtlQtLPWNtfy1YYJXu6bpfK0PE7wcVzexEjaPmLjvjtVV6LdmnmXeChAqmZaR8PND0Wmi/f9FTVKBNm9+2/2fCMbQcVitcObrqTImfe9Phpq9tK1pu0uI2NXeRfEupy/qtRrtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430715; c=relaxed/simple;
	bh=E7pQkT/EnDMtDd5wNY6f9DSBUat4RJiu067561kQ/6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PiWih0p08Nnhhajj79XE8W99F2MTPenAoSgJ2IWwu/vuL0oc8MQsb7UGkAVRS1W+r9A1YaXw2zRLSNNRJ+6M7jBTbYF0zIsErielKw6gqK9DT2eo706Qph4GPftT3gPMQT+Q0KwkB/TmkhtBuSpB7eMMH+J4LdEiLI3vytqVQPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbwdIjAk; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a39e31e1aa9so39687966b.0;
        Thu, 08 Feb 2024 14:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707430712; x=1708035512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hmJVjh6EL0IAfYmSYuwTPhn47XwgyYvO0OBHlfnZxG4=;
        b=WbwdIjAkVHEe4yOyQA2bmQ5oJHrCmwWe6dM6+x2Wdwu5xjbuiO9VIEFMiJvAV+K1zh
         FJDWE6sOfIv+53D/tY98dRvHrCl2u5pxqeIoZ0TV4oBXmZ2WnSxaU8onKgSFzvphkUO3
         MXsjXZXmdOzRnJ8zgVz3xmg2kgIKXUNDORpqhdvxbs9F2F1zSsk4cGt/ObPgHbHsYx7j
         Lrqh9RZrsUHyMj1QN5J//gQ1u5r6pAIq6SbPKHhLM9Q68mGHQMicPMZKgRw6ImmMJGET
         n6/XHxWFYA1uGuXLCdxU7BOuG62ty1RF1iBdu037PAIL6BygKRJfsTJS5nLX+B5ztd8L
         pKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707430712; x=1708035512;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hmJVjh6EL0IAfYmSYuwTPhn47XwgyYvO0OBHlfnZxG4=;
        b=v6c4XYLkYxrgXCEcu3p849OmLxA0W7jxt5av4JlriLyXCPtpRQZ4k4rlwzdejYdswZ
         Eithy17arMNA1a2LM3WL8lA8x90s/Q90GsyW20AvfGoBxR7HqUqReDzzb6zNqwjhdOHy
         3O+9h1XPjQX/TpeoxYGpN8FJvHBC4TbXD+FiR6wrEVItyuZDeLV/dbsst6y7UX0wVsD+
         nwdzt8IBeYHJGTukJgtSc4V2n/BiImlgiTYkjUeH08QuYd/2iIJ8cMCQbrBRuFTML7zm
         GyvmcW2YTQM6nbfoZ8sRuQhmPRrrIo7XOxIhGuxuPsDi0xLnMWSwcNG4oOmP5gmcELym
         GeUA==
X-Forwarded-Encrypted: i=1; AJvYcCXgU7zi1PjkUkbtLPS2tSosKfIWMuRfxBiiJcWxI2JEfzJtBQT/nDjJsk0jKJkZ1j3Ufrt5swMUh3Ou+dfJt8tBN3TOdZiytf7+iAX1
X-Gm-Message-State: AOJu0YyFrDIMN0Tm7+NJiPE9GkQ1e8E6VqoAcCesO1GKY52IW7M88WxR
	yO7/VPopr7GbvyP0iNmnC3Nkgc5i2+x+MVvOCnw3dyR3yh6GOslTmjHnKQ0F
X-Google-Smtp-Source: AGHT+IEvCtQVgKYq4bOkCegoNUtzbbrVr74SLt604Pn6KDxXecqGMh7w38gd/DQ2uzwds+xJMwqtwQ==
X-Received: by 2002:a17:906:b7d4:b0:a3a:91b8:f306 with SMTP id fy20-20020a170906b7d400b00a3a91b8f306mr450433ejb.31.1707430711463;
        Thu, 08 Feb 2024 14:18:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUm5KXOlNbKcPE8Ao/jPj9PSFUBKm4qGPn30lLSUxBeOKOHzSnJClzRfWENJNZAQMjznfBLUkQVtgJjok87jgOphNQ56Rk88ab2rT7tmVcmBIeIEi6OJTZIM4XB7yCqCQMd2vqkljkY0szBCj+V6E7oGaU0N27DpwhfahixoktuKYpdrnNxQnhXYmtMhc9WbLJAN27xJo5DnZEsa/Wx3XNr
Received: from ?IPV6:2a01:c23:c599:8500:402f:6940:bc68:be4e? (dynamic-2a01-0c23-c599-8500-402f-6940-bc68-be4e.c23.pool.telefonica.de. [2a01:c23:c599:8500:402f:6940:bc68:be4e])
        by smtp.googlemail.com with ESMTPSA id cx1-20020a170907168100b00a38a0f61e0bsm121729ejd.27.2024.02.08.14.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 14:18:30 -0800 (PST)
Message-ID: <aa9a3495-22fd-4fac-abb0-afedf1b4d8ec@gmail.com>
Date: Thu, 8 Feb 2024 23:18:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next20240208: tg3 driver nw interfaces not getting
 configured
Content-Language: en-US
To: "Aithal, Srikanth" <sraithal@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, andrew@lunn.ch,
 Jakub Kicinski <kuba@kernel.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20240208155740.24c6ada7@canb.auug.org.au>
 <ce7150b7-b6f1-4635-ba5f-fdfda84a6e2f@amd.com>
 <fd72544a-f3ed-44bb-86e3-bdfa4fca720e@gmail.com>
 <8a59f072-4a71-4662-bfde-308b81e4ce88@amd.com>
 <47987433-7d56-483e-a0fc-38140cc17448@gmail.com>
 <11baa678-8cbe-4a9a-af09-381d649d648c@amd.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <11baa678-8cbe-4a9a-af09-381d649d648c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08.02.2024 16:28, Aithal, Srikanth wrote:
> On 2/8/2024 7:32 PM, Heiner Kallweit wrote:
>> On 08.02.2024 12:05, Aithal, Srikanth wrote:
>>> On 2/8/2024 4:16 PM, Heiner Kallweit wrote:
>>>> On 08.02.2024 09:30, Aithal, Srikanth wrote:
>>>>> Hi,
>>>>>
>>>>> On 6.8.0-rc3-next-20240208, the network interfaces are not getting configured.
>>>>>
>>>> Thanks for the report. Could you please elaborate on what "not getting
>>>> configured" means in detail?
>>>> - Any error in any log?
>>>> - Any other error message?
>>>> - Interface doesn't come up or which specific configuration are you missing?
>>>>
>>> I am not seeing any errors in the dmesg,
>>>
>>> [    4.019383] tg3 0000:c1:00.0 eth0: Tigon3 [partno(BCM95720) rev 5720000] (PCI Express) MAC address d0:8e:79:bb:95:90
>>> [    4.019391] tg3 0000:c1:00.0 eth0: attached PHY is 5720C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
>>> [    4.019394] tg3 0000:c1:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
>>> [    4.019397] tg3 0000:c1:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
>>> [    4.041082] tg3 0000:c1:00.1 eth1: Tigon3 [partno(BCM95720) rev 5720000] (PCI Express) MAC address d0:8e:79:bb:95:91
>>> [    4.041087] tg3 0000:c1:00.1 eth1: attached PHY is 5720C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
>>> [    4.041090] tg3 0000:c1:00.1 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
>>> [    4.041092] tg3 0000:c1:00.1 eth1: dma_rwctrl[00000001] dma_mask[64-bit]
>>> [    4.077483] tg3 0000:c1:00.1 eno8403: renamed from eth1
>>> [    4.124657] tg3 0000:c1:00.0 eno8303: renamed from eth0
>>>
>>> nmcli says interfaces are disconnected:
>>>
>>> [root@localhost ~]# nmcli
>>> eno8303: disconnected
>>>          "Broadcom and subsidiaries NetXtreme BCM5720"
>>>          ethernet (tg3), D0:8E:79:BB:95:90, hw, mtu 1500
>>>
>>> eno8403: disconnected
>>>          "Broadcom and subsidiaries NetXtreme BCM5720"
>>>          ethernet (tg3), D0:8E:79:BB:95:91, hw, mtu 1500
>>>
>>> I am attaching host dmesg.
>>>
>>
>> Thanks. dmesg lists no error. Please send output from the following commands.
>>
>> ip link
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> 2: eno8303: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN mode DEFAULT group default qlen 1000
>     link/ether d0:8e:79:bb:95:90 brd ff:ff:ff:ff:ff:ff
>     altname enp193s0f0
> 3: eno8403: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN mode DEFAULT group default qlen 1000
>     link/ether d0:8e:79:bb:95:91 brd ff:ff:ff:ff:ff:ff
>     altname enp193s0f1
> 
>> ethtool <if>
> Settings for eno8303:
>         Supported ports: [ TP ]
>         Supported link modes:   10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>                                 1000baseT/Half 1000baseT/Full
>         Supported pause frame use: No
>         Supports auto-negotiation: Yes
>         Supported FEC modes: Not reported
>         Advertised link modes:  10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>                                 1000baseT/Half 1000baseT/Full
>         Advertised pause frame use: No
>         Advertised auto-negotiation: Yes
>         Advertised FEC modes: Not reported
>         Speed: Unknown!
>         Duplex: Unknown! (255)
>         Auto-negotiation: on
>         Port: Twisted Pair
>         PHYAD: 1
>         Transceiver: internal
>         MDI-X: Unknown
>         Supports Wake-on: g
>         Wake-on: d
>         Current message level: 0x000000ff (255)
>                                drv probe link timer ifdown ifup rx_err tx_err
>         Link detected: no
> 
> Settings for eno8403:
>         Supported ports: [ TP ]
>         Supported link modes:   10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>                                 1000baseT/Half 1000baseT/Full
>         Supported pause frame use: No
>         Supports auto-negotiation: Yes
>         Supported FEC modes: Not reported
>         Advertised link modes:  10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>                                 1000baseT/Half 1000baseT/Full
>         Advertised pause frame use: No
>         Advertised auto-negotiation: Yes
>         Advertised FEC modes: Not reported
>         Speed: Unknown!
>         Duplex: Unknown! (255)
>         Auto-negotiation: on
>         Port: Twisted Pair
>         PHYAD: 2
>         Transceiver: internal
>         MDI-X: Unknown
>         Supports Wake-on: g
>         Wake-on: d
>         Current message level: 0x000000ff (255)
>                                drv probe link timer ifdown ifup rx_err tx_err
>         Link detected: no
> 
>> ethtool --show-eee <if>
> EEE settings for eno8403:
>         EEE status: enabled - inactive
>         Tx LPI: 2047 (us)
>         Supported EEE link modes:  100baseT/Full
>                                    1000baseT/Full
>         Advertised EEE link modes:  100baseT/Full
>                                     1000baseT/Full
>         Link partner advertised EEE link modes:  Not reported
> 
> EEE settings for eno8303:
>         EEE status: enabled - inactive
>         Tx LPI: 2047 (us)
>         Supported EEE link modes:  100baseT/Full
>                                    1000baseT/Full
>         Advertised EEE link modes:  100baseT/Full
>                                     1000baseT/Full
>         Link partner advertised EEE link modes:  Not reported
> 
>>
>> If the interfaces aren't up, please try to bring them up manually and see what happens.
>> ip link set <if> up
> Nothing happens.
> [root@localhost ~]# ip link set eno8303 up
> [root@localhost ~]# ip link set eno8403 up
> [root@localhost ~]# ip link
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> 2: eno8303: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN mode DEFAULT group default qlen 1000
>     link/ether d0:8e:79:bb:95:90 brd ff:ff:ff:ff:ff:ff
>     altname enp193s0f0
> 3: eno8403: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN mode DEFAULT group default qlen 1000
>     link/ether d0:8e:79:bb:95:91 brd ff:ff:ff:ff:ff:ff
>     altname enp193s0f1
> 
>>
>>
>>>>> I have 'NetXtreme BCM5720 Gigabit Ethernet PCIe'
>>>>>          configuration: autonegotiation=on broadcast=yes driver=tg3
>>>>>
>>>>> If I revert below commit I am able to get back the interfaces mentioned.
>>>>>
>>>>> commit 9bc791341bc9a5c22b94889aa37993bb69faa317
>>>>> Author: Heiner Kallweit <hkallweit1@gmail.com>
>>>>> Date:   Sat Feb 3 22:12:50 2024 +0100
>>>>>
>>>>>       tg3: convert EEE handling to use linkmode bitmaps
>>>>>
>>>>>       Convert EEE handling to use linkmode bitmaps. This prepares for
>>>>>       removing the legacy bitmaps from struct ethtool_keee.
>>>>>       No functional change intended.
>>>>>
>>>>>       Note: The change to mii_eee_cap1_mod_linkmode_t(tp->eee.advertised, val)
>>>>>       in tg3_phy_autoneg_cfg() isn't completely obvious, but it doesn't change
>>>>>       the current functionality.
>>>>>
>>>>>       Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>>>       Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>>>>       Link: https://lore.kernel.org/r/0652b910-6bcc-421f-8769-38f7dae5037e@gmail.com
>>>>>       Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>>>>>
>>>>>
>>>>> The same works fine on 6.8.0-rc3-next-20240207.
>>>>>
>>>>> Thanks,
>>>>> Srikanth Aithal
>>>>> sraithal@amd.com
>>>> Heiner
>>
> 

Could you please test whether the following fixes the issue for you?

The uninitialized struct ethtool_keee causes the bug because
mii_eee_cap1_mod_linkmode_t() leaves unknown bits as-is.

---
 drivers/net/ethernet/broadcom/tg3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 50f674031..7d0a2f5f3 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -4616,7 +4616,7 @@ static int tg3_init_5401phy_dsp(struct tg3 *tp)
 
 static bool tg3_phy_eee_config_ok(struct tg3 *tp)
 {
-	struct ethtool_keee eee;
+	struct ethtool_keee eee = {};
 
 	if (!(tp->phy_flags & TG3_PHYFLG_EEE_CAP))
 		return true;
-- 
2.43.0



