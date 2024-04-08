Return-Path: <linux-kernel+bounces-135856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAD889CC17
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA41F2850B1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C54D1465BC;
	Mon,  8 Apr 2024 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="K5mq36Cg"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9501448EE;
	Mon,  8 Apr 2024 18:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712602658; cv=none; b=rGPUjowFc7/aYyjRn5Kt6NSSQyISIXMyjW3v+f7RQuIeJFfQUkC+5ltOTyHV5HTVl1z9V2NQBlJRNaQB5SqLPbN/irAsjB9Tm61jXeoT3B8WTDfq+4kEAPxBc7Z1epDDNCu9LZebYtVVmyCgLuG9kUMxXeantE3HlLhHFliP1xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712602658; c=relaxed/simple;
	bh=3Ksy3uqKz0AmubAouqn4Gy4u9t6taDQCdgYL0z2nOpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rox++uiN0edvj/i6YdYwqN9Gp+RilJoxILi9bhIlXFAlA1GsvXAaA0xDkQbwPAdjVwcExvoxRMQKb+lzHFu52P+BdUHNpuIRf3n51ooeq5tbZKuumC2rO9vhBExrh+WREqDzKxtl46G2JLs8nAKC09M6ZtTOobHXWmuV69mDcok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=K5mq36Cg; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712602612; x=1713207412; i=w_armin@gmx.de;
	bh=YFt6HXbVB0FjjMKhB/Z8n5ElJhc+LyOOGP8ml8nGxH4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=K5mq36Cg5fAlAM3Oxi9gxKvuhIjLaWrO+DESFW2nTpWftEAWqsa8T1xw7QcpR99R
	 fRClbB+KSak2uWkSVUI0YBt24lmul7MwsbqoA4rwOWSTQ4GetzOr909K7lFfmpXXT
	 K4qgD5QK3PnJR14w+aFZpyn1sclRXul1H5NktuYnJwsL3Ete1d8RWf94e7KjJSmxk
	 hGUdqt5eobqmeKb4tzQaq/+GKtV7R39d+PgmIANMATCRM3l6lYTIikNb1Zzt4hFjb
	 q/rIcw1NRQ171aS3Lu1Vd92SUsZKVDNWUu5WVdGTHHv+8NV/v6PxQCZLomRRG5y0F
	 2fRd4P/J2A+Dai50jA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mdeb5-1sTVuH20Ej-00ZeHi; Mon, 08
 Apr 2024 20:56:52 +0200
Message-ID: <abc9f198-e61f-4116-bdea-4ace82daba10@gmx.de>
Date: Mon, 8 Apr 2024 20:56:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/1] platform/x86: Add wmi driver for Casper Excalibur
 laptops
To: Stella Bloom <windowz414@gnuweeb.org>,
 =?UTF-8?Q?Mustafa_Ek=C5=9Fi?= <mustafa.eskieksi@gmail.com>
Cc: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
 Ammar Faizi <ammarfaizi2@gnuweeb.org>,
 Bedirhan KURT <bedirhan_kurt22@erdogan.edu.tr>,
 GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, jdelvare@suse.com, lee@kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux@roeck-us.net, pavel@ucw.cz,
 platform-driver-x86@vger.kernel.org, Stella Bloom <stelbl@elrant.team>
References: <15fdc072-9329-4675-8d9e-189862d88351@gmail.com>
 <20240408161345.143779-1-windowz414@gnuweeb.org>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240408161345.143779-1-windowz414@gnuweeb.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gQ3zI48bEbO/AxG9Qc4MlpUI7h6Ajq+5eDw8B8rCEQXvIi8SDyU
 aLi+wvAFeo2a9NdbRwvOV8LjQYfFgA8c9/AoMserEsFq3Y+T2daI4uziQtz+MZ3VTfpABwm
 EFQaLJCViQFn62f9SZCpM1g3ixX6kdS/jAhV1Y2poB5Icg9CjJHBUFNsozO41prcQQxDl9y
 ffnVAntDnSnyN0Sw7ft9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:74pjY0jDzyM=;ltokrsYI4CNYCU519bGXPmd8M3e
 D5c/IktiHby5K5mj9PLDoudz4WCTXDDQ4NRSfnebNPMd5b6GUnYvVS+Y05E76erHQIA7yPTP6
 XwJUHWX2jD7Oe75bjx+fOGCi8kHAMQKpp3J6/aTQSnuvUxLRyYoPT/yfCqvqorFRUnsd1rPHY
 X+HgnaQHH1gU5HZNx9ZiQSqebIulxBDiG7yQ1LbU3WcovlSm+kImGFWRUNMAsy/rIeJo5LvsA
 Vu7IN5/SDMypVTWPRl7pj48ruygqAoFWC7g87+FYmi/xMZDecbnWIEmEv/WvUjfp67XZgBh0B
 qoCGnEcAaZ3ErDvnoPOPWHQVudDjcdWlejFbEz4V8OS6fZusEhHI/uT0xC9hNYv22rCNmQCBG
 agtaQHqPBY+sbBeHo1OBYydFJct64vY0AkHLrwBQluLS06JinYtAcHudTgl0OVj6vIFGgHB4x
 4ZxGPB0KNb2P9tfSZ2m9RuhgGgcIitim4NtW7ZhQQFsX8VP/Uv8RZ9rQSd7vp7N3Y9zkoqEN0
 DwW4XKyJOwevoHjkI0QEoI77SQ+/BzVvLbELY8dpplhQ6rvJOgTHWzP3ZtQYO5l0hlIJDTMsU
 l13IvRxw1DMn1k+Q6NUo1c0n1bwk61rtaNtLmvYEbVEhKAFDbKrGebs5zO2JHl4ClNiAdshwy
 ByT88n2MbJ0aLBzNSrEkWjfSzWzt79ZvT6Vl/j3V7pZQ/Nl/sMBOxGusnstle2ZVlBIW0tJ18
 NgSsG3pXnTm/kXHKpmPz1nJQWg7YGpCCh4OlH8DQxwAi5AvAWfwnYTip5zaGNr8QqMvqNApyt
 GmEGt7LKZt2ktdaHjZhGigvb1WMteEjFGd1kgQWxg7N64=

Am 08.04.24 um 18:13 schrieb Stella Bloom:

> On Mon, 2024-04-08 at 18:23 +0300, Mustafa Ek=C5=9Fi wrote:
>> On 7.04.2024 03:57, Stella Bloom wrote:
>>>> From: Mustafa Ek=C5=9Fi <mustafa.eskieksi@gmail.com>
>>>>
>>>> Hi,
>>>> I want to note that moving mutex_init to the bottom of the function
>>>> crashes the driver when mutex_lock is called. I didn't investigate it
>>>> further but I wanted to say that since Ai Chao also did it like that.
>>>>
>>>> Driver sets all leds to white on start. Before that, when a led's
>>>> brightness is changed, that led's color gets set to white but others
>>>> keep their old colors which creates a bad user experience (at least f=
or
>>>> me). Please inform me if this is a bad approach.
>>>> Also, this driver still lacks support for changing modes and I seek
>>>> advise for that.
>>>>
>>>> Mustafa Ek=C5=9Fi (1):
>>>>     platform/x86: Add wmi driver for Casper Excalibur laptops
>>>>
>>>>    MAINTAINERS                       |   6 +
>>>>    drivers/platform/x86/Kconfig      |  14 +
>>>>    drivers/platform/x86/Makefile     |   1 +
>>>>    drivers/platform/x86/casper-wmi.c | 641 ++++++++++++++++++++++++++=
++++
>>>>    4 files changed, 662 insertions(+)
>>>>    create mode 100644 drivers/platform/x86/casper-wmi.c
>>>>
>>> Hi there,
>>>
>>> I just wanted to pitch in by testing the driver on the kernel I use
>>> on my Arch install on an Excalibur G770.1245, namely xdevs23's
>>> linux-nitrous (https://gitlab.com/xdevs23/linux-nitrous), but trying t=
o
>>> compile the driver using LLVM, which is the default compilation behavi=
or
>>> in this kernel's AUR package, spits out the following error;
>>> ```
>>> drivers/platform/x86/casper-wmi.c:633:3: error: field designator 'no_s=
ingleton' does not refer to any field in type 'struct wmi_driver'
>>>    633 |         .no_singleton =3D true,
>>>        |         ~^~~~~~~~~~~~~~~~~~~
>>> 1 error generated.
>>> make[5]: *** [scripts/Makefile.build:243: drivers/platform/x86/casper-=
wmi.o] Error 1
>>> make[4]: *** [scripts/Makefile.build:481: drivers/platform/x86] Error =
2
>>> make[3]: *** [scripts/Makefile.build:481: drivers/platform] Error 2
>>> make[2]: *** [scripts/Makefile.build:481: drivers] Error 2
>>> make[1]: *** [/home/stella/.cache/yay/linux-nitrous/src/linux-nitrous/=
Makefile:1919: .] Error 2
>>> make: *** [Makefile:240: __sub-make] Error 2
>>> ```
>>>
>>> I want to help debug this somehow, but I'm more of an Android custom
>>> ROM developer than a Linux kernel maintainer, so my knowledge on the
>>> programming and build system languages other than Java, Makefile, Bash=
,
>>> etc is pretty much limited if not outright non-existent.
>> Hi,
>> This is because of a newly merged patch from Armin Wolf:
>> https://lore.kernel.org/platform-driver-x86/20240226193557.2888-2-W_Arm=
in@gmx.de/
>> You can comment that line or apply that patch to your tree to make it
>> compile. Also, you'll probablyneed to change the call to wmidev_block_s=
et in
>> casper_query function with wmi_set_block (which is now deprecated).
> Well, I prefer not to touch the driver itself, so I already resorted to
> picking the patch over the latest RC, which is v6.9-rc2 as of now, and
> got onto compiling `linux-mainline` AUR package with it. It will be
> kind of a hassle considering how I have to write systemd-boot entries
> after the installation to get the kernel to appear (one for normal
> initramfs and the other for fallback one) and sign the kernel image
> using `sbctl` so I don't fail secure boot, but I'm willing to go
> through it just for the sake of seeing this driver in action without
> bugs related to the "backport" modifications I would do to it.

Hi,

if you use kernel 6.9-rc2, then wmidev_block_set() is already available, s=
o you do not
have to change that.

You just have to comment out the line with the no_singleton flag, then the=
 driver should
work.

Thanks,
Armin Wolf

>>> I would *love* to see this driver actually hit mainline repos, and
>>> eventually the upcoming kernel releases, given how much I need to use
>>> this laptop of mine as a computer engineering student.
>>>
>>> Asking just for the case I manage to get this driver up and going on
>>> my end somehow: Is there a tool made for controlling the LED colors ye=
t?
>>> I can still use CLI tools much like on ASUS ROG series laptops, but it
>>> would be much easier and more appreciated to have a GUI provided
>>> Excalibur series laptops' LED lights can virtually take any color in
>>> the RGB space - At least that's how I interpreted with the
>>> configurations I used to do on mine using Excalibur Control Center
>>> on Windows 10/11.
>> No, there isn't a tool yet but controlling leds via sysfs ispretty easy=
.
>> For example, if you wanted to change the left led zone's color to red:
>> ```
>> # echo 0xff0000 > /sys/class/leds/casper\:\:kbd_zoned_backlight-left/mu=
lti_intensity
>> ```
> Oh so the LED zones are in different sysfs directories, that's pretty
> good. I might code a simple Bash script to make things easier later
> down the road.
>> And don't forget that all leds' initial brightnesses are 0.
> Yeah I think I read that somewhere in the initial message. Can't I
> change the brightness of the LEDs using Fn+Space anyway if I can't find
> the sysfs entries for that? At least it works just fine on the latest
> stable release - v6.8.4.
>> Also, I'm planning to add support for this API in OpenRGB.
> That's pretty nice to hear! If you need someone to test it out on a
> 12th gen G770, I'm more than willing to do so!
>>> And as for the profiles, let me make sure we're talking about the same
>>> thing in this term: You're talking about the "Office", "Gaming" and
>>> "High Performance" modes as seen in Excalibur Control Center, right?
>> For laptops with 11th gen processors or newer: yes.
>> For laptops with 10th gen processors or older: no, there are 4 power
>> profiles for these laptops (High Performance, Gaming, Text Mode andPowe=
r
>> save).
> Oh so that's a yes in my case as my laptop has a 12th gen processor.
> Glad to know.
>>> If so, can this be somehow integrated into `power-profiles-daemon`
>>> SystemD service for easier controlling with GNOME and other DEs that
>>> use it? It's fine if it can't be, this was just a thought struck on my
>>> mind for whatever reason.
>> Yes, power-profiles-daemon is already integrated with platform_profile.
> Now that's exciting to hear. I haven't seen a laptop that has its power
> profiles integrated into the system with a driver in terms of Linux...
> At least on the Monster and ASUS laptops I've tried Ubuntu on IIRC.
>>> Please do CC me and the people I've added to the CC list with this ema=
il
>>> of mine on the upcoming revisions, if any. We would love to keep track
>>> of this driver and I personally would love to contribute into testing
>>> as a power user.
>>>
>>> Cc: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
>>> Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>
>>> Cc: GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
>>>
>>> Also adding my organizational and school email addresses to the CC lis=
t
>>> so I can still be notified while I stay offline on this email address.
>>> GNOME Evolution doesn't run in the background and periodically check
>>> for emails sadly, and I switch ROMs every now and then on my phone as =
a
>>> source maintainer of 3 different custom ROMs. :/
>>>
>>> Cc: Stella Bloom <stelbl@elrant.team>
>>> Cc: Bedirhan KURT <bedirhan_kurt22@erdogan.edu.tr>
>>>
>>> --
>>> Stella Bloom
>> Thanks for your interest,
>> Mustafa Ek=C5=9Fi
> Also I apologize for the previous (empty) email. I forgot to put one
> newline after the "Subject" line, which caused git-send-email to not
> pick up the email content.
>
> --
> Stella Bloom
>

