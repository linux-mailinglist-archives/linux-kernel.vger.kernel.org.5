Return-Path: <linux-kernel+bounces-54561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C69B84B0B7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289D2288578
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0743812D157;
	Tue,  6 Feb 2024 09:04:19 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C18F12D14D;
	Tue,  6 Feb 2024 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707210258; cv=none; b=j4TGy+zlIFC2pF1PEy3HFbMtVzJQdzgLsdlsVHifZPIulp9hGRdrbTqdUjmYV3Lv/yyfZOZAg8ksTMMPAuJfRbchURutelr/GNV4EXG2I9eGfjpVqbQEU6bEPkugnMxmvFwCYUMLmp2ZUMw7c20ITPJ5D02z9xBzxeYrRkTtwbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707210258; c=relaxed/simple;
	bh=ffqF9pbg73X9+xuZrZI4+596sHg1hrjRjb7G8U2PqrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABClXdsYGNbfcW8Les7ECFrU/xWjaAlGGnEAd9+awAMSA/DLs5c06eZ44DX6If+j7yztKwlLS6AYq4ntt9s08lHxbcv8s1WFNk0Gn302leS+hsMjKSVgXAO/Dwwrwtbbi0ITlwtDX7Jl3NY+MDXRbLa2FIcd8tHaANKZDwUKEh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.59.18.202] (p4fff0ce7.dip0.t-ipconnect.de [79.255.12.231])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6FD4261E5FE04;
	Tue,  6 Feb 2024 10:03:41 +0100 (CET)
Message-ID: <210f8e5d-aa78-41f7-a9ce-2584274f1848@molgen.mpg.de>
Date: Tue, 6 Feb 2024 10:03:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux warning `usb: port power management may be unreliable` on
 Dell XPS 13 9360
To: Mathias Nyman <mathias.nyman@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Mike Jones <mike@mjones.io>
References: <b97d07bf-da27-4576-bed6-fd63e3e0b569@molgen.mpg.de>
 <e595bcb8-bfc0-aa12-a5c1-a62c5fe9e950@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <e595bcb8-bfc0-aa12-a5c1-a62c5fe9e950@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Mathias,


Thank you very much for your quick reply.


Am 05.02.24 um 16:15 schrieb Mathias Nyman:
> On 4.2.2024 10.45, Paul Menzel wrote:

>> On the Dell XPS 13 9360, Linux warns:
>>
>>      usb: port power management may be unreliable
> 
> Is this a new issue, regression?

No, it is not. In the database provided by *Hardware for Linux* [1], I 
could find an upload with Ubuntu 16.04.12’s Linux version 
4.4.0-176-generic with the warning [2][3].

> Was the firmware recently updated?

No, it wasn’t. Unfortunately, Dell does not provide any firmware updates 
for the device anymore, and the latest version 2.21.0 is from July 2021 [4].

>>      $ lsusb -t
>>      /:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/12p, 480M
>>          |__ Port 003: Dev 002, If 0, Class=Wireless, Driver=[none], 12M
>>          |__ Port 003: Dev 002, If 1, Class=Wireless, Driver=[none], 12M
>>          |__ Port 004: Dev 003, If 0, Class=Human Interface Device, Driver=usbhid, 12M
>>          |__ Port 005: Dev 004, If 0, Class=Video, Driver=uvcvideo, 480M
>>          |__ Port 005: Dev 004, If 1, Class=Video, Driver=uvcvideo, 480M
>>      /:  Bus 002.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/6p, 5000M
>>
>> Enabling dynamic debug with `usbcore.dyndbg=+p` – `dyndbg="file port.c 
>> +p"` did not work¹ – the additional messages are:
>>
>>      [    1.149417] usb usb2-port1: peered to usb1-port1
>>      [    1.150123] usb usb2-port2: peered to usb1-port2
>>      [    1.150916] usb usb2-port3: peered to usb1-port6
>>      [    1.151621] usb: failed to peer usb2-port4 and usb1-port6 by location (usb2-port4:none) (usb1-port6:usb2-port3)
>>      [    1.151634] usb usb2-port4: failed to peer to usb1-port6 (-16)
>>      [    1.151642] usb: port power management may be unreliable
>>      [    1.152314] usb: failed to peer usb2-port5 and usb1-port6 by location (usb2-port5:none) (usb1-port6:usb2-port3)
>>      [    1.152325] usb usb2-port5: failed to peer to usb1-port6 (-16)
>>      [    1.153020] usb: failed to peer usb2-port6 and usb1-port6 by location (usb2-port6:none) (usb1-port6:usb2-port3)
>>      [    1.153031] usb usb2-port6: failed to peer to usb1-port6 (-16)
>>      [    1.153079] usb usb2: port-1 no _DSM function 5
>>      [    1.153096] usb usb2: port-2 no _DSM function 5
>>      [    1.153111] usb usb2: port-3 no _DSM function 5
>>      [    1.153124] usb usb2: port-4 no _DSM function 5
>>      [    1.153137] usb usb2: port-5 no _DSM function 5
>>      [    1.153151] usb usb2: port-6 no _DSM function 5
>>      [    1.166521] usb usb1-port3: status 0101 change 0001
>>      [    1.166555] usb usb1-port4: status 0101 change 0001
>>      [    1.166584] usb usb1-port5: status 0101 change 0001
>>      [    1.270442] usb usb1-port3: status 0101, change 0000, 12 Mb/s
>>      [    1.362751] usb usb2: bus auto-suspend, wakeup 1
> 
> These are all related to reading values from firmware ACPI tables.
> 
> The "failed to peer portx-porty.." messages are because driver can't match
> which HS USB 2 and SS USB3 ports are in the same physical connector based
> on info read from firmware ACPI _PLD entries
> 
> _DSM function 5 is related to port link power management.
> 
> Both cases mostly impact power management, but might affect something
> else. Haven't looked at it in detail.
> 
> ACPI table dump could show more info, especially the DSDT table

I created issue #218465 in the Linux Kernel Bugzilla [5] and attached 
the output of `acpidump` there.

>> So the problematic ports do not show up in `lsusb`, do they?
>>
>> Please find the output of `dmesg` attached.
> 
> dmesg shows that "usb2" is the SuperSpeed USB 3 roothub.
> It's suspended as no SuperSpeed devices are connected to it.

Yes, nothing is connected to it.

> Do USB 3 devices work normally on this machine?

Kind off. I have to pass pci=noaer and sometimes Linux warns about some 
USB-C things, but so far the devices I test work fine.


Kind regards,

Paul


[1]: https://linux-hardware.org/
[2]: https://linux-hardware.org/?probe=713D96799F
[3]: 
https://github.com/linuxhw/Dmesg/blob/main/Notebook/Dell/XPS/XPS%2013%209360/F5BE747E0815/UBUNTU-16.04/4.4.0-176-GENERIC/X86_64/713D96799F#L669
[4]: 
https://www.dell.com/support/home/en-us/drivers/driversdetails?driverid=xkrg8&oscode=wt64a&productcode=xps-13-9360-laptop
[5]: https://bugzilla.kernel.org/show_bug.cgi?id=218465

