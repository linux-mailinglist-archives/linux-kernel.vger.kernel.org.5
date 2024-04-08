Return-Path: <linux-kernel+bounces-135875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3DE89CC7E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906D01C223AF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B125146583;
	Mon,  8 Apr 2024 19:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="YWn73cB4"
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01C9145321;
	Mon,  8 Apr 2024 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.211.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712604758; cv=none; b=BIlIjpN9FusA4dfhcAsvyKaOxjbscCO2+pSEyZIPYw2XaVGGTumfmiGW5CiUbxuz73A7q2Ups68VJWA4FMpdbqBzKAmgKys2dCMvlqnr4jnBOwmhIprXuQGjQASOIxt0bA4unmjMBzR1dDoqB5c7V8LZufSlTnzeJXBIlLOxr9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712604758; c=relaxed/simple;
	bh=8YLMTLDWH3NghugdmXPWJ6D2/GZYKf+qb4W4/n17nks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMuxPn9dei8LYvuOij0AZ0IyYxDmh36e93e1EoFhPIlVlH18Z8P7MMXCVxAc2o0BYydRMqIMZF424J8YIPUdK23bcsSJvbqGWu7R9LIZnKBTiPKh1Ran5ciSe20u3eeyc4zYR6Oook3xj7o7W3Hs/tAMBkSyKAeA50YxsnyQQkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=YWn73cB4; arc=none smtp.client-ip=51.81.211.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=default; t=1712604755;
	bh=8YLMTLDWH3NghugdmXPWJ6D2/GZYKf+qb4W4/n17nks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YWn73cB4vjbD3T+hykH+IJoxOsOLx1ZIxC8v9951XhambwuhlkUxI+Dmvq+f4RkJd
	 0lWf/SqIB1Tr3AQzPf546VmzZKKR0hGKzIjnm+7XKQA2MYN4z5Yq4TB1Xtzfv5z+/D
	 dfegL05r5wtzYNZWomePGlrGmsOg4+6RQpsrMDBAoPMa4jJFgbwN/v3+YHJ+cpyZVH
	 T7TbFnigYoMzsjtLuxMOeAiTN0WXdoIOiYUOGCA1V6Xa2V/M+eFqBmWhO+tX3pkZla
	 gnQ0MnlGEQDYJR+oHqikZLKRKYzJNF172v6Bmlnyrs+EUzUIdot2qfrW6+JBqjV5/y
	 OzmdVTteKuc5g==
Received: from bloom.tail0d56f.ts.net (unknown [88.235.219.169])
	by gnuweeb.org (Postfix) with ESMTPSA id 4B4EC24AC60;
	Tue,  9 Apr 2024 02:32:29 +0700 (WIB)
From: Stella Bloom <windowz414@gnuweeb.org>
To: Armin Wolf <w_armin@gmx.de>
Cc: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
	Ammar Faizi <ammarfaizi2@gnuweeb.org>,
	Bedirhan KURT <bedirhan_kurt22@erdogan.edu.tr>,
	GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	jdelvare@suse.com,
	lee@kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux@roeck-us.net,
	=?UTF-8?q?Mustafa=20Ek=C5=9Fi?= <mustafa.eskieksi@gmail.com>,
	pavel@ucw.cz,
	platform-driver-x86@vger.kernel.org,
	Stella Bloom <stelbl@elrant.team>
Subject: Re: [PATCH v5 0/1] platform/x86: Add wmi driver for Casper Excalibur laptops
Date: Mon,  8 Apr 2024 22:32:22 +0300
Message-ID: <20240408193224.476521-1-windowz414@gnuweeb.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <abc9f198-e61f-4116-bdea-4ace82daba10@gmx.de>
References: <abc9f198-e61f-4116-bdea-4ace82daba10@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Am 08.04.24 um 18:13 schrieb Stella Bloom:
>
>> On Mon, 2024-04-08 at 18:23 +0300, Mustafa Ekşi wrote:
>>> On 7.04.2024 03:57, Stella Bloom wrote:
>>>>> From: Mustafa Ekşi <mustafa.eskieksi@gmail.com>
>>>>>
>>>>> Hi,
>>>>> I want to note that moving mutex_init to the bottom of the function
>>>>> crashes the driver when mutex_lock is called. I didn't investigate it
>>>>> further but I wanted to say that since Ai Chao also did it like that.
>>>>>
>>>>> Driver sets all leds to white on start. Before that, when a led's
>>>>> brightness is changed, that led's color gets set to white but others
>>>>> keep their old colors which creates a bad user experience (at least for
>>>>> me). Please inform me if this is a bad approach.
>>>>> Also, this driver still lacks support for changing modes and I seek
>>>>> advise for that.
>>>>>
>>>>> Mustafa Ekşi (1):
>>>>>     platform/x86: Add wmi driver for Casper Excalibur laptops
>>>>>
>>>>>    MAINTAINERS                       |   6 +
>>>>>    drivers/platform/x86/Kconfig      |  14 +
>>>>>    drivers/platform/x86/Makefile     |   1 +
>>>>>    drivers/platform/x86/casper-wmi.c | 641 ++++++++++++++++++++++++++++++
>>>>>    4 files changed, 662 insertions(+)
>>>>>    create mode 100644 drivers/platform/x86/casper-wmi.c
>>>>>
>>>> Hi there,
>>>>
>>>> I just wanted to pitch in by testing the driver on the kernel I use
>>>> on my Arch install on an Excalibur G770.1245, namely xdevs23's
>>>> linux-nitrous (https://gitlab.com/xdevs23/linux-nitrous), but trying to
>>>> compile the driver using LLVM, which is the default compilation behavior
>>>> in this kernel's AUR package, spits out the following error;
>>>> ```
>>>> drivers/platform/x86/casper-wmi.c:633:3: error: field designator 'no_singleton' does not refer to any field in type 'struct wmi_driver'
>>>>    633 |         .no_singleton = true,
>>>>        |         ~^~~~~~~~~~~~~~~~~~~
>>>> 1 error generated.
>>>> make[5]: *** [scripts/Makefile.build:243: drivers/platform/x86/casper-wmi.o] Error 1
>>>> make[4]: *** [scripts/Makefile.build:481: drivers/platform/x86] Error 2
>>>> make[3]: *** [scripts/Makefile.build:481: drivers/platform] Error 2
>>>> make[2]: *** [scripts/Makefile.build:481: drivers] Error 2
>>>> make[1]: *** [/home/stella/.cache/yay/linux-nitrous/src/linux-nitrous/Makefile:1919: .] Error 2
>>>> make: *** [Makefile:240: __sub-make] Error 2
>>>> ```
>>>>
>>>> I want to help debug this somehow, but I'm more of an Android custom
>>>> ROM developer than a Linux kernel maintainer, so my knowledge on the
>>>> programming and build system languages other than Java, Makefile, Bash,
>>>> etc is pretty much limited if not outright non-existent.
>>> Hi,
>>> This is because of a newly merged patch from Armin Wolf:
>>> https://lore.kernel.org/platform-driver-x86/20240226193557.2888-2-W_Armin@gmx.de/
>>> You can comment that line or apply that patch to your tree to make it
>>> compile. Also, you'll probablyneed to change the call to wmidev_block_set in
>>> casper_query function with wmi_set_block (which is now deprecated).
>> Well, I prefer not to touch the driver itself, so I already resorted to
>> picking the patch over the latest RC, which is v6.9-rc2 as of now, and
>> got onto compiling `linux-mainline` AUR package with it. It will be
>> kind of a hassle considering how I have to write systemd-boot entries
>> after the installation to get the kernel to appear (one for normal
>> initramfs and the other for fallback one) and sign the kernel image
>> using `sbctl` so I don't fail secure boot, but I'm willing to go
>> through it just for the sake of seeing this driver in action without
>> bugs related to the "backport" modifications I would do to it.
>
> Hi,
>
> if you use kernel 6.9-rc2, then wmidev_block_set() is already available, so you do not
> have to change that.
>
> You just have to comment out the line with the no_singleton flag, then the driver should
> work.

Hi,

Thanks for letting me know of that. I'm doing the change locally right away.

> Thanks,
> Armin Wolf
>
>>>> I would *love* to see this driver actually hit mainline repos, and
>>>> eventually the upcoming kernel releases, given how much I need to use
>>>> this laptop of mine as a computer engineering student.
>>>>
>>>> Asking just for the case I manage to get this driver up and going on
>>>> my end somehow: Is there a tool made for controlling the LED colors yet?
>>>> I can still use CLI tools much like on ASUS ROG series laptops, but it
>>>> would be much easier and more appreciated to have a GUI provided
>>>> Excalibur series laptops' LED lights can virtually take any color in
>>>> the RGB space - At least that's how I interpreted with the
>>>> configurations I used to do on mine using Excalibur Control Center
>>>> on Windows 10/11.
>>> No, there isn't a tool yet but controlling leds via sysfs ispretty easy.
>>> For example, if you wanted to change the left led zone's color to red:
>>> ```
>>> # echo 0xff0000 > /sys/class/leds/casper\:\:kbd_zoned_backlight-left/multi_intensity
>>> ```
>> Oh so the LED zones are in different sysfs directories, that's pretty
>> good. I might code a simple Bash script to make things easier later
>> down the road.
>>> And don't forget that all leds' initial brightnesses are 0.
>> Yeah I think I read that somewhere in the initial message. Can't I
>> change the brightness of the LEDs using Fn+Space anyway if I can't find
>> the sysfs entries for that? At least it works just fine on the latest
>> stable release - v6.8.4.
>>> Also, I'm planning to add support for this API in OpenRGB.
>> That's pretty nice to hear! If you need someone to test it out on a
>> 12th gen G770, I'm more than willing to do so!
>>>> And as for the profiles, let me make sure we're talking about the same
>>>> thing in this term: You're talking about the "Office", "Gaming" and
>>>> "High Performance" modes as seen in Excalibur Control Center, right?
>>> For laptops with 11th gen processors or newer: yes.
>>> For laptops with 10th gen processors or older: no, there are 4 power
>>> profiles for these laptops (High Performance, Gaming, Text Mode andPower
>>> save).
>> Oh so that's a yes in my case as my laptop has a 12th gen processor.
>> Glad to know.
>>>> If so, can this be somehow integrated into `power-profiles-daemon`
>>>> SystemD service for easier controlling with GNOME and other DEs that
>>>> use it? It's fine if it can't be, this was just a thought struck on my
>>>> mind for whatever reason.
>>> Yes, power-profiles-daemon is already integrated with platform_profile.
>> Now that's exciting to hear. I haven't seen a laptop that has its power
>> profiles integrated into the system with a driver in terms of Linux...
>> At least on the Monster and ASUS laptops I've tried Ubuntu on IIRC.
>>>> Please do CC me and the people I've added to the CC list with this email
>>>> of mine on the upcoming revisions, if any. We would love to keep track
>>>> of this driver and I personally would love to contribute into testing
>>>> as a power user.
>>>>
>>>> Cc: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
>>>> Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>
>>>> Cc: GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
>>>>
>>>> Also adding my organizational and school email addresses to the CC list
>>>> so I can still be notified while I stay offline on this email address.
>>>> GNOME Evolution doesn't run in the background and periodically check
>>>> for emails sadly, and I switch ROMs every now and then on my phone as a
>>>> source maintainer of 3 different custom ROMs. :/
>>>>
>>>> Cc: Stella Bloom <stelbl@elrant.team>
>>>> Cc: Bedirhan KURT <bedirhan_kurt22@erdogan.edu.tr>
>>>>
>>>> -- 
>>>> Stella Bloom
>>> Thanks for your interest,
>>> Mustafa Ekşi
>> Also I apologize for the previous (empty) email. I forgot to put one
>> newline after the "Subject" line, which caused git-send-email to not
>> pick up the email content.
>>
>> -- 
>> Stella Bloom

--
Stella Bloom

