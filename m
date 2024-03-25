Return-Path: <linux-kernel+bounces-117891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B0288B0FD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89741FA407C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012344E1DB;
	Mon, 25 Mar 2024 20:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="KDCS/0zr"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08BD45033;
	Mon, 25 Mar 2024 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397458; cv=none; b=cj05Qs/7s3Eb1iaoMwmFHF4KY85M3ZwtR8tm36Y1b0NEhA/2pEdtxKp+Wj4qSHykQVsmJlAS6OlUCsnG4OIg8Y+0huclQoPLzlxPcSYvBj+Boj/LozM0sXrjUFJx1jSlxjyMUE8xwO3N24LvLTvAxCISlwz1vAuX3TSHS2mhSYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397458; c=relaxed/simple;
	bh=1hS5NcLSFnVm2dCXuWF1CcXyaqi1PIrZM8H+m08BW8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pxVDIcnDKiK/g0BTOB/p0rk85iYNQMGUqiHgGxdryChjhz9t42oJH0mVoX3fAibmBpUT3F9gj0pxo3Pxunxfej9sQYznXTDkMnvLadtx8Uq2lq7z6vgdtklxEMz/UpeRL/nIIETZOmDAB2GOGbjylMgEEJ2EkauaNunIWK6/0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=KDCS/0zr; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711397427; x=1712002227; i=w_armin@gmx.de;
	bh=k5GImjZ67YtdbUkAgxVbsS2XJfKlz1HCv891Pa0K9js=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=KDCS/0zrDTxyxdvF/Hy3PacpYWCo72HItPKTv98QWlJz+1cQEWS4RTyxpj2FWDT9
	 drdwdLQO9c/jsd2fkEnYMBMQwT4Qq4Fhm5Ek2/rZUQxJToOocIp5C+QklPgpUifdN
	 6JxEpTQWfEDUNdb7rzKYjHxSqVNwOOX6QYAfZiog5h+FJAS0cF5kZaKCFqPDpicrN
	 Udynh2HboSvaCvRkufE3Ke1QLWK/EOcUAU/DWr7J1FZqAE6RHr9pklp8GqgNgFTpA
	 2rxGsE0j4Z1lKyrOW2cIk9cdlX4YogkgXblJzWbQoBGc2YifkyqEoK1iN9DmPnQqX
	 FsXg4jOwFPFv5xu9mA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4QwW-1spvPx0OQw-011Tra; Mon, 25
 Mar 2024 21:10:27 +0100
Message-ID: <19661160-76d4-43ed-987f-dbf183e891ba@gmx.de>
Date: Mon, 25 Mar 2024 21:10:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/1] platform/x86: Add wmi driver for Casper Excalibur
 laptops
To: mustafa <mustafa.eskieksi@gmail.com>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, jdelvare@suse.com, linux@roeck-us.net,
 pavel@ucw.cz, lee@kernel.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-leds@vger.kernel.org
References: <20240324181201.87882-1-mustafa.eskieksi@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240324181201.87882-1-mustafa.eskieksi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MzAOenI/8ST5bPq1ExjXTewiulUgJsw+eKvNeLMu9b/QqFXI+HZ
 DDi/1ZBInrf9MDaHj+0zRFBJsC+ua38+dOLRn523wjSiDyxrkQVDsIYh/wieCdbjvFCxy2e
 hQan7SNyErbcAZwEcUF9cudypMEch+wSOJG25OSM8PqSSAT1yBXZqBcZdy+nOJD0meWazAA
 TCWWVyHGmNWCrujxWENyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4Q7DKlFfmFE=;1gutw6nxLW14lkJsyKYuM4sLje8
 z/GVi1B240WDw392PqTI8PmIGLBIaP6em5iITJ+UL7Q+rIYiJevgcuBJ2cu0uFjwUrcoYGyXs
 s/zKD4WK7gRXFWfWmvd3t4nGLT8p3bijTGAk3STO5TDxGfjU8vK9x/sEjcVmA5M2AwrAIgVzR
 BNxJmpqbWStWlkBuTuJxjrSZ3PT6Izl42brBi4/z6kNBLrFXzu3E3oXLQc8MIvHFSYWb+spCC
 XZb+yXWnZc2XSTnuRsFdqA/5g8x2vDLMxyBkqrfZ7yn4IZQoL46n/dsdVgEikTB068zmGl0/o
 KQ3PrJ4jb+VvOd4Ohs5fzkMJlA1QpN7T5oLQgj0McqNMMhdfz1GnMWNm63jHiQNkKL5UOMP6h
 WFacbdwoLlJNFcKcFHOHUtp8TutqM/YRAD5v+Nc07bIjelQBV+SMokkst+l7VSqoL7/f36szu
 kvBeL2vw286XGsMWOwv0oMrnyQggLdHdVhse9NaK5PFiHCNMLAUg6ba5XcDs1TR3MbiyO+pXX
 gq3YGulqT4AnsvN9O93y/HZIQshKjEeclZJ8WzCSImYHXBXY6b8DhRWI2hqTlbvskXRjQYbnP
 Nj0J0HFCMyz7xdRwYu+ht/lRbn9WEBr46eWI94dtDidmFu7/YUUQqt7YncO7ZATaax4nC8/nz
 OcU1IYjBo9+XIFba9EdJxqBZOMJWKDv1GdI1CgyVdzEyniUDtTyXyn4O+F7Vw/NegtDr6rAOJ
 TCjfULJos8hMDcNteij1eMjoqN4mccnxAF3Ml6tyyPMnbyXnZsb42ed/Ne0+QYEooslCF+8aw
 d5+zTZpHGYt/N4+6u2FKNQrd1/F3taRwYzruGb54CmmKU=

Am 24.03.24 um 19:12 schrieb mustafa:

> From: Mustafa Ek=C5=9Fi <mustafa.eskieksi@gmail.com>
>
> Hi,
> I want to note that moving mutex_init to the bottom of the function
> crashes the driver when mutex_lock is called. I didn't investigate it
> further but I wanted to say that since Ai Chao also did it like that.

You mean like the lenovo-wmi-camera driver? In this case, the driver was
only using the mutex inside the WMI notify callback, which can only run
once the driver has finished probing.

In your case however, the mutex can already be used while the driver is st=
ill
probing, because it registers callbacks with other subsystems.
The subsystem (maybe led?) assumes that the device is already fully operat=
ional
and will begin calling the callbacks immediately, causing a crash.

Looking at the code, it seems that you are not calling mutex_destroy() in
casper_wmi_remove(). I suggest to use devm_add_action_or_reset() for handl=
ing this.

Thanks,
Armin Wolf

> Driver sets all leds to white on start. Before that, when a led's
> brightness is changed, that led's color gets set to white but others
> keep their old colors which creates a bad user experience (at least for
> me). Please inform me if this is a bad approach.
> Also, this driver still lacks support for changing modes and I seek
> advise for that.
>
> Mustafa Ek=C5=9Fi (1):
>    platform/x86: Add wmi driver for Casper Excalibur laptops
>
>   MAINTAINERS                       |   6 +
>   drivers/platform/x86/Kconfig      |  14 +
>   drivers/platform/x86/Makefile     |   1 +
>   drivers/platform/x86/casper-wmi.c | 641 ++++++++++++++++++++++++++++++
>   4 files changed, 662 insertions(+)
>   create mode 100644 drivers/platform/x86/casper-wmi.c
>

