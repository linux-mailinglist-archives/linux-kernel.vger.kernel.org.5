Return-Path: <linux-kernel+bounces-39688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF26583D502
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6241B2451B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6727D2421E;
	Fri, 26 Jan 2024 07:05:58 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F071AACD;
	Fri, 26 Jan 2024 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706252757; cv=none; b=ShZAY6bjoQm3NWiChmnx9UvJy+5vesfMllDi3z3Z5vmL54L4u7p3P+XiLyDrlTm31709r0/7HQh/uDv+TVRz/Ucjjcyc5psXectZJ0FP5G82gW9dZpK+QzGinMciaYlQY6wELfeG6OoaXWRLeFMSRquk+EIJ01KEFls6k0WVEmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706252757; c=relaxed/simple;
	bh=pcsil5fXr8+VHV+eVDviFFwwRsocY/oapa4amn5QRYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZu6X8WPyr2XN2+KdKYJ8q9ApfUrDiSrFYOQGLlEEAop6xnkRSV7UFu6eM0+RD8nh6oErqmPWqY+atAGTVti3w7aqDm4ocoteeCm2eUXYyjaS8aOVDooofzW1zWTPUamskRNk2LyDC2d3+j52JDBESsRjOCvlcI4+xdx1SMIUCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aec07.dynamic.kabel-deutschland.de [95.90.236.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0DFC161E5FE03;
	Fri, 26 Jan 2024 08:03:18 +0100 (CET)
Message-ID: <f07333d2-ebb0-4531-a396-8fb3d1daa2c3@molgen.mpg.de>
Date: Fri, 26 Jan 2024 08:03:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PS/2 keyboard of laptop Dell XPS 13 9360 goes missing after S3
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
 Dell.Client.Kernel@dell.com, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <0aa4a61f-c939-46fe-a572-08022e8931c7@molgen.mpg.de>
 <f27b491c-2f1c-4e68-804c-24eeaa8d10de@redhat.com>
 <0b30c88a-6f0c-447f-a08e-29a2a0256c1b@molgen.mpg.de>
 <dde1bdfe-7877-41bd-b233-03bcdba0e2de@redhat.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <dde1bdfe-7877-41bd-b233-03bcdba0e2de@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Hans,


Thank you for your reply, and sorry for the delay on my side. I needed 
to set up an environment to easily build the Linux kernel.


Am 22.01.24 um 14:43 schrieb Hans de Goede:

> On 1/21/24 15:26, Paul Menzel wrote:

[…]

>> Am 20.01.24 um 21:26 schrieb Hans de Goede:
>>
>>> On 1/18/24 13:57, Paul Menzel wrote:
>>>> #regzbot introduced v6.6.11..v6.7
>>
>>>> There seems to be a regression in Linux 6.7 on the Dell XPS 13 9360 (Intel i7-7500U).
>>>>
>>>>       [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
>>>>
>>>> The PS/2 keyboard goes missing after S3 resume¹. The problem does not happen with Linux 6.6.11.
>>>
>>> Thank you for reporting this.
>>>
>>> Can you try adding "i8042.dumbkbd=1" to your kernel commandline?
>>>
>>> This should at least lead to the device not disappearing from
>>>
>>> "sudo libinput list-devices"
>>>
>>> The next question is if the keyboard will still actually
>>> work after suspend/resume with "i8042.dumbkbd=1". If it
>>> stays in the list, but no longer works then there is
>>> a problem with the i8042 controller; or interrupt
>>> delivery to the i8042 controller.
>>>
>>> If "i8042.dumbkbd=1" somehow fully fixes things, then I guess
>>> my atkbd driver fix for other laptop keyboards is somehow
>>> causing issues for yours.
>>
>> Just a quick feedback, that booting with `i8042.dumbkbd=1` seems to fix the issue.
>>
>>> If "i8042.dumbkbd=1" fully fixes things, can you try building
>>> your own 6.7.0 kernel with commit 936e4d49ecbc:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=936e4d49ecbc8c404790504386e1422b599dec39
>>>
>>> reverted?
>>
>> I am going to try that as soon as possible.
> 
> Assuming this was not some one time glitch with 6.7.0,
> I have prepared a patch hopefully fixing this (1) as well
> as a follow up fix to address another potential issue which
> I have noticed.

Unfortunately, it wasn’t just a glitch.

> Can you please give a 6.7.0 (2) kernel with the 2 attached
> patches added a try ?
> 
> I know building kernels can be a bit of work / takes time,
> sorry. If you are short on time I would prefer testing these 2
> patches and see if they fix things over trying a plain revert.

Applying both patches on v6.7.1

     $ git log --oneline -3
     053fa44c0de1 (HEAD -> v6.7.1) Input: atkbd - Do not skip 
atkbd_deactivate() when skipping ATKBD_CMD_GETID
     0e0fa0113c7a Input: atkbd - Skip ATKBD_CMD_SETLEDS when skipping 
ATKBD_CMD_GETID
     a91fdae50a6d (tag: v6.7.1, stable/linux-6.7.y, origin/linux-6.7.y) 
Linux 6.7.1

I am unable to reproduce the problem in eight ACPI S3 suspend/resume 
cycles. The DMAR errors [3] are also gone:

     $ sudo dmesg --level alert,crit,err,warn
     [    0.065292] MDS CPU bug present and SMT on, data leak possible. 
See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html 
for more details.
     [    0.065292] MMIO Stale Data CPU bug present and SMT on, data 
leak possible. See 
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html 
for more details.
     [    0.092064] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
     [    0.294522] hpet_acpi_add: no address or irqs in _CRS
     [    0.345003] i8042: Warning: Keylock active
     [    1.063807] usb: port power management may be unreliable
     [    1.178339] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is 
disabled. Duplicate IMA measurements will not be recorded in the IMA log.
     [   37.712916] wmi_bus wmi_bus-PNP0C14:01: WQBC data block query 
control method not found
     [   67.307070] warning: `atop' uses wireless extensions which will 
stop working for Wi-Fi 7 hardware; use nl80211
     [  141.861803] ACPI Error: AE_BAD_PARAMETER, Returned by Handler 
for [EmbeddedControl] (20230628/evregion-300)
     [  141.861808] ACPI Error: Aborting method \_SB.PCI0.LPCB.ECDV.ECR1 
due to previous error (AE_BAD_PARAMETER) (20230628/psparse-529)
     [  141.861814] ACPI Error: Aborting method \_SB.PCI0.LPCB.ECDV.ECR2 
due to previous error (AE_BAD_PARAMETER) (20230628/psparse-529)
     [  141.861818] ACPI Error: Aborting method \ECRW due to previous 
error (AE_BAD_PARAMETER) (20230628/psparse-529)
     [  141.861821] ACPI Error: Aborting method \ECG1 due to previous 
error (AE_BAD_PARAMETER) (20230628/psparse-529)
     [  141.861824] ACPI Error: Aborting method \NEVT due to previous 
error (AE_BAD_PARAMETER) (20230628/psparse-529)
     [  141.861827] ACPI Error: Aborting method \_SB.PCI0.LPCB.ECDV._Q66 
due to previous error (AE_BAD_PARAMETER) (20230628/psparse-529)

Please tell me, if I can do anything else.


Kind regards,

Paul


> 1) Assuming it is caused by this commit in the first place,
> which seems likely
> 
> 2) 6.8-rc1 has a follow up patch which is squashed into the
> first patch here, so these patches will only apply cleanly
> to 6.7.0 .

[3]: 
https://lore.kernel.org/all/9a24c335-8ec5-48c9-9bdd-b0dac5ecbca8@molgen.mpg.de/

>>>>       [    1.435071] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
>>>>       [    1.435409] i8042: Warning: Keylock active
>>>>       [    1.437624] serio: i8042 KBD port at 0x60,0x64 irq 1
>>>>       [    1.437631] serio: i8042 AUX port at 0x60,0x64 irq 12
>>>>       […]
>>>>       [    1.439743] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
>>>>
>>>>       $ sudo libinput list-devices
>>>>       […]
>>>>       Device:           AT Translated Set 2 keyboard
>>>>       Kernel:           /dev/input/event0
>>>>       Group:            15
>>>>       Seat:             seat0, default
>>>>       Capabilities:     keyboard
>>>>       Tap-to-click:     n/a
>>>>       Tap-and-drag:     n/a
>>>>       Tap drag lock:    n/a
>>>>       Left-handed:      n/a
>>>>       Nat.scrolling:    n/a
>>>>       Middle emulation: n/a
>>>>       Calibration:      n/a
>>>>       Scroll methods:   none
>>>>       Click methods:    none
>>>>       Disable-w-typing: n/a
>>>>       Disable-w-trackpointing: n/a
>>>>       Accel profiles:   n/a
>>>>       Rotation:         0.0
>>>>
>>>> `libinput list-devices` does not list the device after resuming
>>>> from S3. Some of the function keys, like brightness and airplane
>>>> mode keys, still work, as the events are probably transmitted over
>>>> the embedded controller or some other mechanism. An external USB
>>>> keyboard also still works.
>>>>
>>>> I haven’t had time to further analyze this, but wanted to report
>>>> it. No idea
>>>>
>>>>
>>>> Kind regards,
>>>>
>>>> Paul
>>>>
>>>>
>>>> ¹ s2idle is not working correctly on the device, in the sense, that
>>>> energy usage is very high in that state, and the full battery is at
>>>> 20 % after leaving it for eight hours.

