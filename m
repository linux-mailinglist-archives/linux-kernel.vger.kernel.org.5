Return-Path: <linux-kernel+bounces-141552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922B48A1FCC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D231C20B56
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782D917BCF;
	Thu, 11 Apr 2024 19:55:41 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB568179A8;
	Thu, 11 Apr 2024 19:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712865341; cv=none; b=rZ4pwYMKuO4cPmBY0hPb1lo5I24qn27erGYASBZmIrBp/jcgmDvU4tDrHMGHymM7OpkIXaCE5i5WL/pkfmnr1/Md28E6NaQf8ecTWlD7sIgSfYlqyMuFCMlcWIUULDasDI3LlZdlewLz645UdU5U3uXlCX856SlI/Ge+t1ZU6P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712865341; c=relaxed/simple;
	bh=5IOiIJH0M09GKwVXYH45rDpcWxq6QcfkugF9A4US9wM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CuF0ft/sjI0jcGNj6S9aGLmmfVexZf5p5igAxP0ygPhyquHIJnV9ZUb/xE4WosZNiY3ZwyNXXt112993o+9db8/2I+roB3R3CmLEwPNul8o9nDdUvt3Utgqlc3hlWAmN4U7AgYh+n7IKWaJPFSk+BLdJrfKFWnixF2o9/zrjjMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.53] (ip5f5aedc4.dynamic.kabel-deutschland.de [95.90.237.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3F65B61E5FE01;
	Thu, 11 Apr 2024 21:55:05 +0200 (CEST)
Message-ID: <bf5e1667-6052-4207-a2b3-e784f9b49d44@molgen.mpg.de>
Date: Thu, 11 Apr 2024 21:55:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: xhci_hcd 0000:00:14.0: ERROR Transfer event TRB DMA ptr not part
 of current TD ep_index 1 comp_code 1
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>, LKML
 <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org,
 Niklas Neronin <niklas.neronin@linux.intel.com>
References: <58bca6f2-797a-4e20-a476-2294309afdd5@molgen.mpg.de>
 <20240405113247.743e34b2@foxbook>
 <7090d3af-18ce-40e1-8ac2-bf18152e5c4a@molgen.mpg.de>
 <20240406183659.3daf4fa0@foxbook>
 <c57f2116-8c42-44fb-9c32-6115ad88f914@molgen.mpg.de>
 <20240407142542.036fb02f@foxbook>
 <1f64af9a-0618-a7da-4acc-f043b6580308@linux.intel.com>
 <20240408210541.771253ff@foxbook>
 <82113c7d-0405-ba11-94d9-5673593cec50@linux.intel.com>
 <fca78115-209f-4090-b83b-acc684484587@molgen.mpg.de>
 <049c4850-fdb5-78fb-1d5e-0850dcd062aa@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <049c4850-fdb5-78fb-1d5e-0850dcd062aa@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Mathias,


Thank you for your reply.

Am 11.04.24 um 09:18 schrieb Mathias Nyman:
> On 10.4.2024 10.59, Paul Menzel wrote:

>> Am 09.04.24 um 13:22 schrieb Mathias Nyman:
>>> On 8.4.2024 22.05, Michał Pecio wrote:
>>>>> It's also possible this TD/TRB was cancelled due to the disconnect.
>>>>> Could be that even if driver removes the TD from the list and cleans
>>>>> out the TRB from the ring buffer (turns TRB to no-op) hardware may
>>>>> have read ahead and cached the TRB, and process it anyway.
>>>>
>>>> I thought about it, but my debug patch says that the missing TD was
>>>> freed by finish_td(), which is called on TDs considered completed by
>>>> hardware. A cancelled TD would show giveback_invalidated_tds().
>>>>
>>>> Anyway, we now have new information from the reporter. My v2 patch
>>>> keeps a log of the last five events processed on each transfer ring
>>>> and dumps the log on TRB mismatch errors.
>>>>
>>>> Unfortunately, it looks like the host controller is broken and signals
>>>> completion of those transfers twice. The log below shows two distinct
>>>> events for TRB 32959a1c0 and that the coresponding TD has just been
>>>> freed by finish_td().
>>>
>>> The trace confirms this, we get double completion events for several
>>> Isoc TRBs. These double completions are seen after a transaction
>>> error on the same device (different endpoint). >
>>> Transfer events for TRB ..a1c0 twice, with a transaction error in 
>>> between:
>>>   <idle>-0       [000] d.h2. 33819.709897: xhci_handle_event: EVENT: TRB 000000032959a1c0 status 'Success' len 0 slot 6 ep 2 type 'Transfer Event' flags e:c
>>>   <idle>-0       [000] d.h2. 33819.709904: xhci_handle_event: EVENT: TRB 000000041547d010 status 'USB Transaction Error' len 4 slot 6 ep 15 type 'Transfer Event' flags e:c
>>>   systemd-journal-395     [000] d.H1. 33819.711886: xhci_handle_event: EVENT: TRB 000000032959a1c0 status 'Success' len 0 slot 6 ep 2 type 'Transfer Event' flags e:c
>>>
>>> Transfer events for TRB ..a1d0 twice (the next TRB)
>>>   systemd-journal-395     [000] d.H1. 33819.712001: xhci_handle_event: EVENT: TRB 000000032959a1d0 status 'Success' len 0 slot 6 ep 2 type 'Transfer Event' flags e:c
>>>   systemd-journal-395     [000] d.H1. 33819.712059: xhci_handle_event: EVENT: TRB 000000032959a1d0 status 'Success' len 0 slot 6 ep 2 type 'Transfer Event' flags e:c
>>>
>>> Transfer events for TRB ..a1e0 twice
>>>   systemd-journal-395     [000] d.H1. 33819.712139: xhci_handle_event: EVENT: TRB 000000032959a1e0 status 'Success' len 0 slot 6 ep 2 type 'Transfer Event' flags e:c
>>>   systemd-journal-395     [000] d.h1. 33819.712871: xhci_handle_event: EVENT: TRB 000000032959a1e0 status 'Success' len 0 slot 6 ep 2 type 'Transfer Event' flags e:c
>>>
>>> etc..
>>>
>>> Driver can cope with these extra events, but if this is common we should
>>> probably handle it silently and not concern users with that ERROR 
>>> message.
>>
>> Thank you for the detailed analysis. Excuse my ignorance, but do you 
>> have an idea, what this Sennheiser USB headset does differently than 
>> other USB devices? Additionally, is this a known problem with this 
>> Intel xHCI controller, meaning, is there an errata about this problem?
> 
> There are a few related erratas in older 9 series chipsets that possibly
> could explain this, but those issues are no longer listed for newer 
> chipsets.
> 
> The Sennheiser headset is a full-speed (FS) device that use 192 byte 
> Isoch transfers.
> 
> Series 9 chipset xHC has issues with exactly those FS Isoch transfers 
> over 189 bytes, see
> " 1. USB Isoch In Transfer Error Issue"
> 
> There are some issues related to FS device removal:
> " 13. USB Full-/low-speed Device Removal Issue"
> 
> And some related to resending transfer events for "cached" TRBs after
> FS device disconnect/reconnect.
> "25. USB xHCI may Execute a Stale Transfer Request Block (TRB)"
> 
> https://www.intel.co.jp/content/dam/www/public/us/en/documents/specification-updates/9-series-chipset-pch-spec-update.pdf

Thank you for digging this up. Judging from the document, these erratas 
were not addressed in any firmware update.

As another data point, I was able to reproduce this issue with the 
Sennheiser USB headset and a Dell XPS 15 7590.

     $ lspci -nn | grep USB
     00:14.0 USB controller [0c03]: Intel Corporation Cannon Lake PCH 
USB 3.1 xHCI Host Controller [8086:a36d] (rev 10)
     3a:00.0 USB controller [0c03]: Intel Corporation JHL6340 
Thunderbolt 3 USB 3.1 Controller (C step) [Alpine Ridge 2C 2016] 
[8086:15db] (rev 02)

I uploaded the logs to *Hardware for Linux* [1].


Kind regards,

Paul


[1]: https://linux-hardware.org/?probe=904c918345

