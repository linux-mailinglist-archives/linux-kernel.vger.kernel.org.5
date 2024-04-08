Return-Path: <linux-kernel+bounces-135595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B29E89C826
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118D7284388
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48293140386;
	Mon,  8 Apr 2024 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bINt+vVT"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6151F14036F;
	Mon,  8 Apr 2024 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589803; cv=none; b=pg33elQWafXWYLmqxe+QxBn1f/U9IVInzaZt23hHvNEdXzhqiMNMBJpaPYQrVRLvsi2tErgTxDMNbLvNB6W8kDBrZ1pLhWYFPi1cNtvD+l1lKsxyyoUThb/lC6ju2j9nQaTPvM0uydJWmGl/3GUYXYHvdVwLZXBKJ+SyLq2JXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589803; c=relaxed/simple;
	bh=aWmOwBMxnBPrBPIX7HbRjPzOo9yySi2pZ/rTpMbx3kU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDJQzWAJIPJs333BPsxD8zObG+1TwqJV+buwOngpImk2faqPU1GVvhk9DCJRznET/IcV845hRC/EA+2BMTieKjRbMYU+VNqMCtoikqoM37Z32MTrfcDjT76lpK1LvxU3zSSueOm7fRQpMblu8vsUaklwivmqKIpKKkINppvIUyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bINt+vVT; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516b6e75dc3so5681834e87.3;
        Mon, 08 Apr 2024 08:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712589799; x=1713194599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5aJBY+lZMBOzeDlvQBcDc5wZfXjkZJi9SVA77e0QYTY=;
        b=bINt+vVT/kQ1PcYsAtgZFZhSpRyJp9bs7NPSWSQ1S5hzUGzUNdwq6irgLJl/SgrnhB
         tQIOHZOQRaMycnTJoMo2CCRdiloCNwYsqCWbMo68e3s+tIl0VZvqV4qqXbwJIWpAEYhe
         QzqGbyBfJgcvIN6YRUn99jjdVdHE7grZpvOsSHK6hsGo7O1S5GZant0ceCFtnwOGt0/r
         I0pjHFol+M4hXarBhmY4NQp/+M7vPGUjcSJI35PnJAek0nOuFsV7AvE7yXSsANAS6ucg
         fxQzDx8FRmm2wNWVjpBoXKwwZo2w12pMR6JSMmCxXzjo4vXaem+bgjn2fWxluNVcruLU
         d3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712589799; x=1713194599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5aJBY+lZMBOzeDlvQBcDc5wZfXjkZJi9SVA77e0QYTY=;
        b=FJprU7A5Vgkv4Kkh5lclgw0n94W3qicZtCx5invhGwdlLDZb1tTn3cecEwAQOv75aO
         HN97QMfqorCp2/U76kk6Db/Uq1zMVAVvZ7HHxBuyFCp282lZUJK2UeiUPvf4xarnlNDy
         hHt4B7yCiHgxtvrodlOpZLfasncppSzw+J+2biNjtWrSz2LUf/xIwr0Gs8ine+0UOQ0T
         nvC96hbGbhPrNjgUqGdhpfIXCFQWpl7u8q6wVY7q+y/2hDteosWMJ9IHTS2+V3X49kXX
         +Lul+TDMNtQ6+Pz+9ME1lg/eb9j0BerETp9RqH9JBZxTcgK9O/QMt8vUm06aY5t2oujR
         LBHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA1PJw/djglZQWwNSD7idzCA96f8biRK4DNgL4mJKrnnH6IAoMWbm05wgqNVSow3pg9ni7yqslxyC2MQGiTflFkx5kv1p4TJWs6NWqAsVF0NoF/8FQeMP7oko9r7EQyxo38K+h4nT4EjaxzS55zuu5NF7cLNCpkZbVfsSTzUBD/0WUWasZ0+Hjfh08S81sunIn6qXdL6jKfmzL8GByQlpic3PEQo3YocdALA==
X-Gm-Message-State: AOJu0YwZo/elvB97QfX2lFFTCpUPpLGG8FWEDOOB/ZW5rnwDvrtPx6x6
	+LTWsdMo7jnwCO7mOH2e4L4FW8e6D2qD2/HdoflFDiHQji3eZmRc
X-Google-Smtp-Source: AGHT+IH4FQk+olUPye5/qT5UhgYxtR0ctIYPXKb7ahlfpoh73KZ4aTrWe59dHaOVw+Ua31BF9351Lw==
X-Received: by 2002:a19:914b:0:b0:516:be09:4b5e with SMTP id y11-20020a19914b000000b00516be094b5emr5477888lfj.46.1712589796719;
        Mon, 08 Apr 2024 08:23:16 -0700 (PDT)
Received: from [192.168.1.105] ([94.120.83.72])
        by smtp.gmail.com with ESMTPSA id a23-20020a1709062b1700b00a51dd26f6dcsm922980ejg.51.2024.04.08.08.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 08:23:16 -0700 (PDT)
Message-ID: <15fdc072-9329-4675-8d9e-189862d88351@gmail.com>
Date: Mon, 8 Apr 2024 18:23:13 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/1] platform/x86: Add wmi driver for Casper Excalibur
 laptops
To: Stella Bloom <windowz414@gnuweeb.org>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
 lee@kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux@roeck-us.net, pavel@ucw.cz,
 platform-driver-x86@vger.kernel.org,
 Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
 Ammar Faizi <ammarfaizi2@gnuweeb.org>,
 GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
 Stella Bloom <stelbl@elrant.team>,
 Bedirhan KURT <bedirhan_kurt22@erdogan.edu.tr>
References: <20240324181201.87882-1-mustafa.eskieksi@gmail.com>
 <20240407005746.412603-1-windowz414@gnuweeb.org>
Content-Language: en-US
From: =?UTF-8?Q?Mustafa_Ek=C5=9Fi?= <mustafa.eskieksi@gmail.com>
In-Reply-To: <20240407005746.412603-1-windowz414@gnuweeb.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7.04.2024 03:57, Stella Bloom wrote:
>> From: Mustafa Ekşi <mustafa.eskieksi@gmail.com>
>>
>> Hi,
>> I want to note that moving mutex_init to the bottom of the function
>> crashes the driver when mutex_lock is called. I didn't investigate it
>> further but I wanted to say that since Ai Chao also did it like that.
>>
>> Driver sets all leds to white on start. Before that, when a led's
>> brightness is changed, that led's color gets set to white but others
>> keep their old colors which creates a bad user experience (at least for
>> me). Please inform me if this is a bad approach.
>> Also, this driver still lacks support for changing modes and I seek
>> advise for that.
>>
>> Mustafa Ekşi (1):
>>    platform/x86: Add wmi driver for Casper Excalibur laptops
>>
>>   MAINTAINERS                       |   6 +
>>   drivers/platform/x86/Kconfig      |  14 +
>>   drivers/platform/x86/Makefile     |   1 +
>>   drivers/platform/x86/casper-wmi.c | 641 ++++++++++++++++++++++++++++++
>>   4 files changed, 662 insertions(+)
>>   create mode 100644 drivers/platform/x86/casper-wmi.c
>>
> Hi there,
>
> I just wanted to pitch in by testing the driver on the kernel I use
> on my Arch install on an Excalibur G770.1245, namely xdevs23's
> linux-nitrous (https://gitlab.com/xdevs23/linux-nitrous), but trying to
> compile the driver using LLVM, which is the default compilation behavior
> in this kernel's AUR package, spits out the following error;
> ```
> drivers/platform/x86/casper-wmi.c:633:3: error: field designator 'no_singleton' does not refer to any field in type 'struct wmi_driver'
>   633 |         .no_singleton = true,
>       |         ~^~~~~~~~~~~~~~~~~~~
> 1 error generated.
> make[5]: *** [scripts/Makefile.build:243: drivers/platform/x86/casper-wmi.o] Error 1
> make[4]: *** [scripts/Makefile.build:481: drivers/platform/x86] Error 2
> make[3]: *** [scripts/Makefile.build:481: drivers/platform] Error 2
> make[2]: *** [scripts/Makefile.build:481: drivers] Error 2
> make[1]: *** [/home/stella/.cache/yay/linux-nitrous/src/linux-nitrous/Makefile:1919: .] Error 2
> make: *** [Makefile:240: __sub-make] Error 2
> ```
>
> I want to help debug this somehow, but I'm more of an Android custom
> ROM developer than a Linux kernel maintainer, so my knowledge on the
> programming and build system languages other than Java, Makefile, Bash,
> etc is pretty much limited if not outright non-existent.
Hi,
This is because of a newly merged patch from Armin Wolf:
https://lore.kernel.org/platform-driver-x86/20240226193557.2888-2-W_Armin@gmx.de/
You can comment that line or apply that patch to your tree to make it
compile. Also, you'll probablyneed to change the call to wmidev_block_set in
casper_query function with wmi_set_block (which is now deprecated).
> I would *love* to see this driver actually hit mainline repos, and
> eventually the upcoming kernel releases, given how much I need to use
> this laptop of mine as a computer engineering student.
>
> Asking just for the case I manage to get this driver up and going on
> my end somehow: Is there a tool made for controlling the LED colors yet?
> I can still use CLI tools much like on ASUS ROG series laptops, but it
> would be much easier and more appreciated to have a GUI provided
> Excalibur series laptops' LED lights can virtually take any color in
> the RGB space - At least that's how I interpreted with the
> configurations I used to do on mine using Excalibur Control Center
> on Windows 10/11.
No, there isn't a tool yet but controlling leds via sysfs ispretty easy.
For example, if you wanted to change the left led zone's color to red:
```
# echo 0xff0000 > /sys/class/leds/casper\:\:kbd_zoned_backlight-left/multi_intensity
```
And don't forget that all leds' initial brightnesses are 0.
Also, I'm planning to add support for this API in OpenRGB.
> And as for the profiles, let me make sure we're talking about the same
> thing in this term: You're talking about the "Office", "Gaming" and
> "High Performance" modes as seen in Excalibur Control Center, right?
For laptops with 11th gen processors or newer: yes.
For laptops with 10th gen processors or older: no, there are 4 power
profiles for these laptops (High Performance, Gaming, Text Mode andPower
save).
> If so, can this be somehow integrated into `power-profiles-daemon`
> SystemD service for easier controlling with GNOME and other DEs that
> use it? It's fine if it can't be, this was just a thought struck on my
> mind for whatever reason.
Yes, power-profiles-daemon is already integrated with platform_profile.
> Please do CC me and the people I've added to the CC list with this email
> of mine on the upcoming revisions, if any. We would love to keep track
> of this driver and I personally would love to contribute into testing
> as a power user.
>
> Cc: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
> Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> Cc: GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
>
> Also adding my organizational and school email addresses to the CC list
> so I can still be notified while I stay offline on this email address.
> GNOME Evolution doesn't run in the background and periodically check
> for emails sadly, and I switch ROMs every now and then on my phone as a
> source maintainer of 3 different custom ROMs. :/
>
> Cc: Stella Bloom <stelbl@elrant.team>
> Cc: Bedirhan KURT <bedirhan_kurt22@erdogan.edu.tr>
>
> --
> Stella Bloom
Thanks for your interest,
Mustafa Ekşi

