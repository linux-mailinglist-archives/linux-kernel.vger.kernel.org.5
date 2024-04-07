Return-Path: <linux-kernel+bounces-134117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CF189ADD0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 03:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6AE41F21B86
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 01:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E43136A;
	Sun,  7 Apr 2024 01:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="tT7beCP5"
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F5F81F;
	Sun,  7 Apr 2024 01:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.211.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712452124; cv=none; b=FeZLYsjV4kTFoOCA+tu/x6cmmTNaGmKC994CFTpIfQXEnL7XffsuQgKeaoiR7A28f0e7+qko/3oeOHAI1PxSzevHbdCwCsOJ5OO920//JMwbqWR+bIMq/X9E0fUvV3/WGpbCHlCjo3uaX2Epv6taH0z+qo5OzQX7V3Q/Qxypq/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712452124; c=relaxed/simple;
	bh=CcOjLI0GWZofIXrmTkh1+TI42ZiuHGsX7W4wxX6Rbrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nzf8CR81WqRnbCsyy4AqtlltfX6hUgUi/80Ew2gsAII+TEO4qmOCt3uffjw88a4Da/7CETaguZOPxXHq8EBLc74UPPUZaFUh+nhZ08N0O9Sy5n2Ds0jx7iAV2Rds60na6Ts78ijnjyX/lNTTo5p9yf4DEESEw8KbLfIk0t9Z1+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=tT7beCP5; arc=none smtp.client-ip=51.81.211.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=default; t=1712451480;
	bh=CcOjLI0GWZofIXrmTkh1+TI42ZiuHGsX7W4wxX6Rbrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tT7beCP5uJdNDAwo2F8QzZhPOGKlTtYflRA0eOsZ99OWIL80ZtEK2BCjPVu7KSh1H
	 kUgRk4SILVRQdGSP9MWM+PB5bX3u1/kRrGR8azZWzjwm3Hj+bdmYnhYO5CweG0gJ4l
	 GEZIYaaqoCLOyLO5a9M96k3jaZMV7U3EUrmkZ+ZdCIuJCx2OksHM/IQMh3juIBeLgF
	 9cYXFmXP3sTAMoy+T0Wv+6Uv/2UU1btEJ7kKDh1comW6jUpmwKMdHT9jXtMDNf/khv
	 19btnxYuTXjf0pSo4FHfjfICrZPkm2fW6oqLO/3NBvMvvVQ6g646gQ21wcBK1I80Hz
	 d7ll5nKyHfkLg==
Received: from bloom.tail0d56f.ts.net (unknown [88.235.219.169])
	by gnuweeb.org (Postfix) with ESMTPSA id 6ABA824AA7D;
	Sun,  7 Apr 2024 07:57:56 +0700 (WIB)
From: Stella Bloom <windowz414@gnuweeb.org>
To: mustafa <mustafa.eskieksi@gmail.com>
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	jdelvare@suse.com,
	lee@kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux@roeck-us.net,
	pavel@ucw.cz,
	platform-driver-x86@vger.kernel.org,
	Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
	Ammar Faizi <ammarfaizi2@gnuweeb.org>,
	GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
	Stella Bloom <stelbl@elrant.team>,
	Bedirhan KURT <bedirhan_kurt22@erdogan.edu.tr>
Subject: [PATCH v5 0/1] platform/x86: Add wmi driver for Casper Excalibur laptops
Date: Sun,  7 Apr 2024 03:57:44 +0300
Message-ID: <20240407005746.412603-1-windowz414@gnuweeb.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240324181201.87882-1-mustafa.eskieksi@gmail.com>
References: <20240324181201.87882-1-mustafa.eskieksi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> From: Mustafa Ekşi <mustafa.eskieksi@gmail.com>
>
> Hi,
> I want to note that moving mutex_init to the bottom of the function
> crashes the driver when mutex_lock is called. I didn't investigate it
> further but I wanted to say that since Ai Chao also did it like that.
>
> Driver sets all leds to white on start. Before that, when a led's
> brightness is changed, that led's color gets set to white but others
> keep their old colors which creates a bad user experience (at least for
> me). Please inform me if this is a bad approach.
> Also, this driver still lacks support for changing modes and I seek
> advise for that.
>
> Mustafa Ekşi (1):
>    platform/x86: Add wmi driver for Casper Excalibur laptops
>
>   MAINTAINERS                       |   6 +
>   drivers/platform/x86/Kconfig      |  14 +
>   drivers/platform/x86/Makefile     |   1 +
>   drivers/platform/x86/casper-wmi.c | 641 ++++++++++++++++++++++++++++++
>   4 files changed, 662 insertions(+)
>   create mode 100644 drivers/platform/x86/casper-wmi.c
>

Hi there,

I just wanted to pitch in by testing the driver on the kernel I use
on my Arch install on an Excalibur G770.1245, namely xdevs23's
linux-nitrous (https://gitlab.com/xdevs23/linux-nitrous), but trying to
compile the driver using LLVM, which is the default compilation behavior
in this kernel's AUR package, spits out the following error;
```
drivers/platform/x86/casper-wmi.c:633:3: error: field designator 'no_singleton' does not refer to any field in type 'struct wmi_driver'
  633 |         .no_singleton = true,
      |         ~^~~~~~~~~~~~~~~~~~~
1 error generated.
make[5]: *** [scripts/Makefile.build:243: drivers/platform/x86/casper-wmi.o] Error 1
make[4]: *** [scripts/Makefile.build:481: drivers/platform/x86] Error 2
make[3]: *** [scripts/Makefile.build:481: drivers/platform] Error 2
make[2]: *** [scripts/Makefile.build:481: drivers] Error 2
make[1]: *** [/home/stella/.cache/yay/linux-nitrous/src/linux-nitrous/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
```

I want to help debug this somehow, but I'm more of an Android custom
ROM developer than a Linux kernel maintainer, so my knowledge on the
programming and build system languages other than Java, Makefile, Bash,
etc is pretty much limited if not outright non-existent.

I would *love* to see this driver actually hit mainline repos, and
eventually the upcoming kernel releases, given how much I need to use
this laptop of mine as a computer engineering student.

Asking just for the case I manage to get this driver up and going on
my end somehow: Is there a tool made for controlling the LED colors yet?
I can still use CLI tools much like on ASUS ROG series laptops, but it
would be much easier and more appreciated to have a GUI provided
Excalibur series laptops' LED lights can virtually take any color in
the RGB space - At least that's how I interpreted with the
configurations I used to do on mine using Excalibur Control Center
on Windows 10/11.

And as for the profiles, let me make sure we're talking about the same
thing in this term: You're talking about the "Office", "Gaming" and
"High Performance" modes as seen in Excalibur Control Center, right?
If so, can this be somehow integrated into `power-profiles-daemon`
SystemD service for easier controlling with GNOME and other DEs that
use it? It's fine if it can't be, this was just a thought struck on my
mind for whatever reason.

Please do CC me and the people I've added to the CC list with this email
of mine on the upcoming revisions, if any. We would love to keep track
of this driver and I personally would love to contribute into testing
as a power user.

Cc: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>

Also adding my organizational and school email addresses to the CC list
so I can still be notified while I stay offline on this email address.
GNOME Evolution doesn't run in the background and periodically check
for emails sadly, and I switch ROMs every now and then on my phone as a
source maintainer of 3 different custom ROMs. :/

Cc: Stella Bloom <stelbl@elrant.team>
Cc: Bedirhan KURT <bedirhan_kurt22@erdogan.edu.tr>

--
Stella Bloom

