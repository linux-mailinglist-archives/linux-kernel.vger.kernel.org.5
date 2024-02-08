Return-Path: <linux-kernel+bounces-58208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4A384E2C0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4136429367F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5207978B44;
	Thu,  8 Feb 2024 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwXYHYRp"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C5D76C79;
	Thu,  8 Feb 2024 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400958; cv=none; b=leoIXon4evGK2TBSUGloslgUNeS3PFRS/mXZnayuiTxaJfzEg643LhGyU6ICGW2nI6cARBEg/Mzu4+O+1JVi/TuoNvrJBkJVZLwWH99pq4BZfEizNPdejSbJz2fvSm8nf13U1xLZUPm3EGMnPgdaSZA1BXUbkE6ZQ4sl95XduPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400958; c=relaxed/simple;
	bh=umeZgszej+9+nlhawL9gGz8MqAnrmt2tAS0zlXcFnA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpwF0w0wpvd5QKdswoYf6tzfRFanXClWonRWItuDDjr6BiWu1MdKbEmPoPrqZVxbEyB2rTRy+ggumcRbHk2agIVgu1ghEAV7Yw+odMqvVgv6A+4+/Da70y/jQxoIPIex5WdP81zWbwfy4gvZAUjp27vgmwhZ1md52fcERLdhehc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwXYHYRp; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so247354466b.2;
        Thu, 08 Feb 2024 06:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707400955; x=1708005755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xfZFtQ2+pP05qvZsJg/nXDMvuPggRgolLgTJFuLApQA=;
        b=SwXYHYRpealOTDWu4KtU+kHuz4aqPBhsSg/I6tgSfFC2vAJfNepYZwffgyW1M/EllL
         F4moasTq/l1SrwWF4aFckCT4K0sjWZuatofstmc3bH4l3xv2OpgcKe1c+Cv+dHNpcjZS
         fDSc6Az+1iPynrNLp91zFHWg7shXPtn4wkKjYtK1x3O9uieQCBKdRO8KOdve7Dn5MXed
         KCwNVEq43w60U0xNtpnDwB6v6QpLddekYTxz4vY+F/bn4cppLNjpaKglK0rFyEiJ4r/4
         2WuRXFyn+l3oRo8MqwaK8meFvjNdk/BpBC8aKTQb1jm/P8VYjYf68QM5Y+KmyQkr19DY
         cKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707400955; x=1708005755;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfZFtQ2+pP05qvZsJg/nXDMvuPggRgolLgTJFuLApQA=;
        b=Uya6rZ1mWW7wZuB9i20nc4fSxNhHP171nsDib2nPU2UIzo7liVmUoYDyBIA3YwlbK5
         T0aPuDGiaffdOdQpW9xgFJOt6z/msWdbbGTzNj5nVjM78UrqI110IxZJaMY6Mr/e/CaJ
         62E0Hy5WoZfDXVXTnrdjGogB+jCQIqeIEATP7/GpueYiLHDNnp5ulzh+Lj1Q+DbHUj4/
         Ryhh6hf6SrGVlWe+/8qhNWKVTb1CmMPJ13s/6R/BmWOTelz4OB6Fm9kzSF4Q2auKKEYN
         Y/vO7weIU5Hv+WW3F/be8epsJf77tIfd7Z+be5VX1vjemzGvyfkJ7zWQnBYtuJyGbZn7
         6i1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpm2c1Swp50VhVsfm45nhM9f/oqr1xjHf0u/cUgWOX6/s4w73v/7RPRnhQ681q5fgHz8To36/NGOMvxQ07FJhgGKEV4T+9WS0XodKR
X-Gm-Message-State: AOJu0Yxz3Z3cga9bEBDomk5ZfTvbusTWxczPbj9+yhHlfJ6BTn6M5A7/
	JDH76j64QWqvr0wJAxkRaU+ih0yADl+SYpKuwFjx5T4q1d/FCEdkfwjnBhxA
X-Google-Smtp-Source: AGHT+IE01pa/eOm3afiZ/mr8l5gzBO4XU0w/bCpy1rIIXp4mBM84j/Rolju1WUzHhxtt1PMe9Uas8g==
X-Received: by 2002:a17:906:895:b0:a37:9bae:ee09 with SMTP id n21-20020a170906089500b00a379baeee09mr6557718eje.11.1707400954432;
        Thu, 08 Feb 2024 06:02:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX4akIVlp+d4aB2HOCHqSRQTZ8VNDszLOvo16qdyMC8Urz8EzdZQfE0ANlRcaAJ8x7U+C49IikNr1gmZDDxok63dP14NA9V8m2vm5RLsC1bfQHTyXfWVVPYoDABLAmfJX27YHEalbzUXVu2indORih/SyR1YzIMgw2XKAhTNW0RVECQWObR352bantG5Rp+MocWSurn8oUnaUHIG7bn6XUx
Received: from ?IPV6:2a01:c23:c599:8500:99e8:d59b:f0fa:1092? (dynamic-2a01-0c23-c599-8500-99e8-d59b-f0fa-1092.c23.pool.telefonica.de. [2a01:c23:c599:8500:99e8:d59b:f0fa:1092])
        by smtp.googlemail.com with ESMTPSA id r5-20020a170906350500b00a3bb41034adsm74602eja.81.2024.02.08.06.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 06:02:34 -0800 (PST)
Message-ID: <47987433-7d56-483e-a0fc-38140cc17448@gmail.com>
Date: Thu, 8 Feb 2024 15:02:34 +0100
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
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <8a59f072-4a71-4662-bfde-308b81e4ce88@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08.02.2024 12:05, Aithal, Srikanth wrote:
> On 2/8/2024 4:16 PM, Heiner Kallweit wrote:
>> On 08.02.2024 09:30, Aithal, Srikanth wrote:
>>> Hi,
>>>
>>> On 6.8.0-rc3-next-20240208, the network interfaces are not getting configured.
>>>
>> Thanks for the report. Could you please elaborate on what "not getting
>> configured" means in detail?
>> - Any error in any log?
>> - Any other error message?
>> - Interface doesn't come up or which specific configuration are you missing?
>>
> I am not seeing any errors in the dmesg,
> 
> [    4.019383] tg3 0000:c1:00.0 eth0: Tigon3 [partno(BCM95720) rev 5720000] (PCI Express) MAC address d0:8e:79:bb:95:90
> [    4.019391] tg3 0000:c1:00.0 eth0: attached PHY is 5720C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
> [    4.019394] tg3 0000:c1:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
> [    4.019397] tg3 0000:c1:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
> [    4.041082] tg3 0000:c1:00.1 eth1: Tigon3 [partno(BCM95720) rev 5720000] (PCI Express) MAC address d0:8e:79:bb:95:91
> [    4.041087] tg3 0000:c1:00.1 eth1: attached PHY is 5720C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
> [    4.041090] tg3 0000:c1:00.1 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
> [    4.041092] tg3 0000:c1:00.1 eth1: dma_rwctrl[00000001] dma_mask[64-bit]
> [    4.077483] tg3 0000:c1:00.1 eno8403: renamed from eth1
> [    4.124657] tg3 0000:c1:00.0 eno8303: renamed from eth0
> 
> nmcli says interfaces are disconnected:
> 
> [root@localhost ~]# nmcli
> eno8303: disconnected
>         "Broadcom and subsidiaries NetXtreme BCM5720"
>         ethernet (tg3), D0:8E:79:BB:95:90, hw, mtu 1500
> 
> eno8403: disconnected
>         "Broadcom and subsidiaries NetXtreme BCM5720"
>         ethernet (tg3), D0:8E:79:BB:95:91, hw, mtu 1500
> 
> I am attaching host dmesg.
> 

Thanks. dmesg lists no error. Please send output from the following commands.

ip link
ethtool <if>
ethtool --show-eee <if>

If the interfaces aren't up, please try to bring them up manually and see what happens.
ip link set <if> up


>>> I have 'NetXtreme BCM5720 Gigabit Ethernet PCIe'
>>>         configuration: autonegotiation=on broadcast=yes driver=tg3
>>>
>>> If I revert below commit I am able to get back the interfaces mentioned.
>>>
>>> commit 9bc791341bc9a5c22b94889aa37993bb69faa317
>>> Author: Heiner Kallweit <hkallweit1@gmail.com>
>>> Date:   Sat Feb 3 22:12:50 2024 +0100
>>>
>>>      tg3: convert EEE handling to use linkmode bitmaps
>>>
>>>      Convert EEE handling to use linkmode bitmaps. This prepares for
>>>      removing the legacy bitmaps from struct ethtool_keee.
>>>      No functional change intended.
>>>
>>>      Note: The change to mii_eee_cap1_mod_linkmode_t(tp->eee.advertised, val)
>>>      in tg3_phy_autoneg_cfg() isn't completely obvious, but it doesn't change
>>>      the current functionality.
>>>
>>>      Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>      Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>>      Link: https://lore.kernel.org/r/0652b910-6bcc-421f-8769-38f7dae5037e@gmail.com
>>>      Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>>>
>>>
>>> The same works fine on 6.8.0-rc3-next-20240207.
>>>
>>> Thanks,
>>> Srikanth Aithal
>>> sraithal@amd.com
>> Heiner


