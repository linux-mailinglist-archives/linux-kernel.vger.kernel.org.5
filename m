Return-Path: <linux-kernel+bounces-134643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D4189B40B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 22:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53B92814ED
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 20:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C4E433CC;
	Sun,  7 Apr 2024 20:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPhfTzm6"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13361DFF2;
	Sun,  7 Apr 2024 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712523117; cv=none; b=rxQWImiy+C7tZ/sd4ZNCy0c3Q1DvfAbnCc/13EhSSKCZxJ9xB3KANIFEqA3Q/TsU6yKUl2G29pTdYmjnhrO6pLSapgObkS9nU8rTvYFS1ZjIRPvgiu0eC4Kabm/FyE2jm1ucJXGDfbrFzRa8i+Szmlf9yGj2h7FDYLsZX38rXIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712523117; c=relaxed/simple;
	bh=S8bA1qYXwEaZja36zVKgL/OSjbM1L06ThbIrA8qgTXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b55PIsHzwX1ahqI0Rvcne5/4JyUvlRU4j8V12/3imWEK4Kx1t6UmMtGi+5Pxda5Dw52RWE7kTl+aIO3H5BC//5JseCAHEGRoi8nrFz/wfEDANo+Uvbwd9ft15x0vDulUtsozo2fSTHiF8rkD7bcigu8rA+RhbVxxMuSvBH5rCpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPhfTzm6; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-516d6898bebso2265761e87.3;
        Sun, 07 Apr 2024 13:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712523114; x=1713127914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8/6W4QF2DX7LV1stD18ZSFVSpYGUbnlXl9aexisM+X4=;
        b=MPhfTzm6812vsBKRXa5Tyz9I2hZqU8w654yV9rqPLyllvef7+RkZobZlYiQtAkwgXJ
         T87r7ONc06bxChQ4PywgIpLpN5PxAOKDcM45fIXzBnBoTQg1uurDLpLDiQmKSK8H57Ow
         UxJ1qgiOLSYKFZf0Ti2GCLa5jKzVCJ7LDntNuk3q2nBBBH+eDOm75YJRKOMSTiXOofhV
         o9pCxBiFhawoUoGHILpAyGhTrNMzjk+E13WghMuZf3L3ObVsBM71UTQPyjhocgq4NitS
         8cTWYsobrRgcDDOtu/95sPnUg/VKPM3TKOyHN2ldL150i6NIQYH07utplObsZCuaQZ1Y
         G5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712523114; x=1713127914;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/6W4QF2DX7LV1stD18ZSFVSpYGUbnlXl9aexisM+X4=;
        b=unPShrjO270GbO0OwCmE0a78vDMQbDkL/alDcSj/cRYLJ/27Cd/dfmb9rT7IVgsvhR
         by9SNmnFuCD+1tb/CtaZmLp7LsXc4ksQ4CNGOjpA+AJHg/l51Rvw57uxViasmoAt3KbH
         LMlD0OaxyIaFUC5RrUJmChjkLsGb5O/KKeFNvNrcPN+ixmtLNbmfUg1gjBhkIrDHkD6z
         2X/ua1VsW7//B6qOmLN8JTLIdm1UA0orR/ZRJm8frnPIPSFsTB3Rg8sUuZXri9I9rYM4
         QrGECapHp/kDbJQn3LBdBo4T40TQYN27lzOnOZGMZa31YFzJvuuPWbV6DTkex3t+lRKD
         PmFw==
X-Forwarded-Encrypted: i=1; AJvYcCX/Go8eA6jv2SfSIGUqQQDuQu7l9YjFRtanGa1EfXbEj24D3+5MrpFgs+Al/aTkSZZ6vO7/n/Iu0mtrWhiK6Jp1NEwH42t02mCfPG61T6uBXzArahe/CislYYh/F0BY94zPQcBhHdyL
X-Gm-Message-State: AOJu0Yw0Pcy5fLSmIHTQuOALgfj8UwZRvuE3r1SDNbqj3rERGkk0vmFu
	7v0VWpS8u28rOTE0RnZjmPAVE42YlOcNpGMXXXiuX9qbYoOHcplc
X-Google-Smtp-Source: AGHT+IESKjXaQeewabqSoHdOdhrx/U2YxlITd9L1EXsRsrm1l4ERwwX7NUCmvaSxslYDUdm0M/Zulw==
X-Received: by 2002:a05:6512:3e17:b0:513:5dc3:9ebb with SMTP id i23-20020a0565123e1700b005135dc39ebbmr6407450lfv.4.1712523113313;
        Sun, 07 Apr 2024 13:51:53 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:6ac4:af9:58dd:395a? (2a02-a466-68ed-1-6ac4-af9-58dd-395a.fixed6.kpn.net. [2a02:a466:68ed:1:6ac4:af9:58dd:395a])
        by smtp.gmail.com with ESMTPSA id c22-20020ac24156000000b00516c9c999aesm910187lfi.251.2024.04.07.13.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 13:51:52 -0700 (PDT)
Message-ID: <321e908e-0d10-4e36-8dc4-6997c73fe2eb@gmail.com>
Date: Sun, 7 Apr 2024 22:51:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] usb: gadget: u_ether: Replace netif_stop_queue with
 netif_device_detach
To: Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 gregkh@linuxfoundation.org, s.hauer@pengutronix.de, jonathanh@nvidia.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_linyyuan@quicinc.com, paul@crapouillou.net, quic_eserrao@quicinc.com,
 erosca@de.adit-jv.com
References: <20231006153808.9758-1-hgajjar@de.adit-jv.com>
 <20231006155646.12938-1-hgajjar@de.adit-jv.com>
 <ZaQS5x-XK08Jre6I@smile.fi.intel.com>
 <20240115132720.GA98840@vmlxhi-118.adit-jv.com>
 <f25283fc-4550-4725-960b-2ea783fd62e1@gmail.com>
 <aeee83d8-dee3-42ed-b705-988b17800721@gmail.com>
 <20240405113855.GA121923@vmlxhi-118.adit-jv.com>
Content-Language: en-US
From: Ferry Toth <fntoth@gmail.com>
In-Reply-To: <20240405113855.GA121923@vmlxhi-118.adit-jv.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

Op 05-04-2024 om 13:38 schreef Hardik Gajjar:
> On Wed, Apr 03, 2024 at 11:01:58PM +0200, Ferry Toth wrote:
>> Hi,
>>
>> Op 15-01-2024 om 21:10 schreef Ferry Toth:
>>> Hi,
>>>
>>> Op 15-01-2024 om 14:27 schreef Hardik Gajjar:
>>>> On Sun, Jan 14, 2024 at 06:59:19PM +0200, Andy Shevchenko wrote:
>>>>> +Cc: Ferry.
>>>>>
>>>>> On Fri, Oct 06, 2023 at 05:56:46PM +0200, Hardik Gajjar wrote:
>>>>>> This patch replaces the usage of netif_stop_queue with
>>>>>> netif_device_detach
>>>>>> in the u_ether driver. The netif_device_detach function not
>>>>>> only stops all
>>>>>> tx queues by calling netif_tx_stop_all_queues but also marks
>>>>>> the device as
>>>>>> removed by clearing the __LINK_STATE_PRESENT bit.
>>>>>>
>>>>>> This change helps notify user space about the disconnection
>>>>>> of the device
>>>>>> more effectively, compared to netif_stop_queue, which only
>>>>>> stops a single
>>>>>> transmit queue.
>>>>> This change effectively broke my USB ether setup.
>>>>>
>>>>> git bisect start
>>>>> # status: waiting for both good and bad commits
>>>>> # good: [1f24458a1071f006e3f7449c08ae0f12af493923] Merge tag
>>>>> 'tty-6.7-rc1' of
>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
>>>>> git bisect good 1f24458a1071f006e3f7449c08ae0f12af493923
>>>>> # status: waiting for bad commit, 1 good commit known
>>>>> # bad: [2c40c1c6adab90ee4660caf03722b3a3ec67767b] Merge tag
>>>>> 'usb-6.7-rc1' of
>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
>>>>> git bisect bad 2c40c1c6adab90ee4660caf03722b3a3ec67767b
>>>>> # bad: [17d6b82d2d6d467149874b883cdba844844b996d] usb/usbip: fix
>>>>> wrong data added to platform device
>>>>> git bisect bad 17d6b82d2d6d467149874b883cdba844844b996d
>>>>> # good: [ba6b83a910b6d8a9379bda55cbf06cb945473a96] usb:
>>>>> xhci-mtk: add a bandwidth budget table
>>>>> git bisect good ba6b83a910b6d8a9379bda55cbf06cb945473a96
>>>>> # good: [dddc00f255415b826190cfbaa5d6dbc87cd9ded1] Revert "usb:
>>>>> gadget: uvc: cleanup request when not in correct state"
>>>>> git bisect good dddc00f255415b826190cfbaa5d6dbc87cd9ded1
>>>>> # bad: [8f999ce60ea3d47886b042ef1f22bb184b6e9c59] USB: typec:
>>>>> tps6598x: Refactor tps6598x port registration
>>>>> git bisect bad 8f999ce60ea3d47886b042ef1f22bb184b6e9c59
>>>>> # bad: [f49449fbc21e7e9550a5203902d69c8ae7dfd918] usb: gadget:
>>>>> u_ether: Replace netif_stop_queue with netif_device_detach
>>>>> git bisect bad f49449fbc21e7e9550a5203902d69c8ae7dfd918
>>>>> # good: [97475763484245916735a1aa9a3310a01d46b008] USB: usbip:
>>>>> fix stub_dev hub disconnect
>>>>> git bisect good 97475763484245916735a1aa9a3310a01d46b008
>>>>> # good: [0f5aa1b01263b8b621bc4f031a1f2983ef8517b7] usb: usbtest:
>>>>> fix a type promotion bug
>>>>> git bisect good 0f5aa1b01263b8b621bc4f031a1f2983ef8517b7
>>>>> # first bad commit: [f49449fbc21e7e9550a5203902d69c8ae7dfd918]
>>>>> usb: gadget: u_ether: Replace netif_stop_queue with
>>>>> netif_device_detach
>>>>>
>>>>> Note, revert indeed helps. Should I send a revert?
>>>>>
>>>>> I use configfs to setup USB EEM function and it worked till this
>>>>> commit.
>>>>> If needed, I can share my scripts, but I believe it's not needed
>>>>> as here
>>>>> we see a clear regression.
>>>>>
>>>>> -- 
>>>>> With Best Regards,
>>>>> Andy Shevchenko
>>>>>
>>>>>
>>>> Without this patch, there may be a potential crash in a race
>>>> condition, as __LINK_STATE_PRESENT is monitored at many places in
>>>> the Network stack to determine the status of the link.
>>>>
>>>> Could you please provide details on how this patch affects your
>>>> functionality? Are you experiencing connection problems or data
>>>> transfer interruptions?
>>> In my case on mrfld (Intel Edison Arduino) using configfs with this
>>> patch no config from host through dhcp is received. Manual setting
>>> correct ipv4 addr / mask / gw still no connection.
>>>
>>>> Instead of reverting this patch, consider trying the upcoming patch
>>>> (soon to be available in the mainline) to see if it resolves your
>>>> issue.
>>>>
>>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_lkml_2023122900-2Dcommence-2Dagenda-2Ddb2c-40gregkh_T_-23m36a812d3f1e5d744ee32381f6ae4185940b376de&d=DwICaQ&c=euGZstcaTDllvimEN8b7jXrwqOf-v5A_CdpgnVfiiMM&r=SAhjP5GOmrADp1v_EE5jWoSuMlYCIt9gKduw-DCBPLs&m=4g6EtvkKKfp8YYHpU196b2HzQxCMgsAhuo8pFng3X4TCWdcOVEUCug2-l2hRfLyV&s=t82wZAFwm2FTSaacgsmSpZWvWEa89jN8GX-okIJrwFw&e=
>>>>
>>> This patch works for me with v6.7.0.
>> I need to revisit this. The patch in this topic landed in v6.7.0-rc1
>> (f49449fbc21e) and breaks the gadget mrfld (Intel Edison Arduino) and other
>> platforms as well.
>>
>> The mentioned fix "usb: gadget: u_ether: Re-attach netif device to mirror
>> detachment*" * has landed in v6.8.0-rc1 (76c945730). What it does fix: I am
>> able to make a USB EEM function again.
>>
>> However, now a hidden issue appears. With mrfld there is an external switch
>> to easily switch between host and device mode.
>>
>> What is not fixed:
>>
>> - when in device mode and unplugging/plugging the cable when using `ifconfig
>> usb0` the line "usb0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>" changes to
>> "usb0: flags=4099<UP,BROADCAST,MULTICAST>" as is supposed to, the route
>> table is updated and the dir `/sys/class/net/usb0` exists and in the dir
>> `cat carrier*` shows the carrier up and down counts. This is the expected
>> behavior.
>>
>> - when in device mode and switching to host mode `ifconfig usb0` continues
>> to show "RUNNING", the route table is not modified and the dir
>> `/sys/class/net/usb0` no longer exists.
>>
>> - switching to device mode again, USB EEM works fine, no changes to RUNNING
>> or the route table happen and the dir `/sys/class/net/usb0` still is non-
>> existing.
>>
>> - unplugging/plugging the cable in device mode after this does not restore
>> the original situation.
>>
>> This behavior I tested on v6.9.0-rc2 (with a few unrelated but essential
>> patches on top) and bisected back to this patch in v6.70-rc1.
>>
>> It seems `netif_device_detach` does not completely clean up as expected and
>> `netif_device_attach` does not completely rebuild.
>>
>> I am wondering if on other platforms this can be reproduced? If so, inho it
>> would be best to revert the both patches until the issue is resolved.
>>
>> Thanks,
>>
>> Ferry
> I'm wondering why the /sys/class/net/usb0 directory is being removed when the network interface is still available.
> This behavior seems not correct.

Exactly. And this didn't happen before the 2 patches.

To be precise: /sys/class/net/usb0 is not removed and it is a link, the 
link target 
/sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/net/usb0 no 
longer exists

> The gether_cleanup function should remove the interface along with the associated kobject,
> and this function should only be called during the unloading of the driver or deleting the gadget.
> Could you please confirm whether any of your custom modifications are removing the net interface kobject?

As far as know not. I have one tusb1210 (usb phy) and 2 dwc3 patches, 
nothing related to gadgets or net.

For reference, patches are here: 
https://github.com/htot/meta-intel-edison/tree/nanbield/meta-intel-edison-bsp/recipes-kernel/linux/files

0001-phy-ti-tusb1210-write-to-scratch-on-power-on.patch

0001a-usb-dwc3-core-Fix-dwc3_core_soft_reset-before-anythi.patch

044-REVERTME-usb-dwc3-gadget-skip-endpoints-ep-18-in-out.patch

Seems (just guessing) gether_cleanup is being called due to the switch 
to host mode, but cleanup only partly succeeds. Now I'm finding I can 
make the net interface disappear with `ip link set dev usb0 down` and 
the broken link goes away by destroying the gadget in configfs.

Is that intentional? Do I need to tear down the gadgets in reverse order 
as on create when switching to host mode? That would be new.

What happens when you trigger a switch to host mode without actually 
unplugging your cable?

>>>> Thanks,
>>>> Hardik

