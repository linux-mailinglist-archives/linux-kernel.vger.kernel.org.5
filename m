Return-Path: <linux-kernel+bounces-34222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E7E8375CF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E11A1F26EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6DF482FF;
	Mon, 22 Jan 2024 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="dDcFSayU";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="oAyjTd/h"
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6C3482D6;
	Mon, 22 Jan 2024 22:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.235.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961223; cv=none; b=nJn857DR2ruzpWdwoVkDQV2DIHgiPXJea0XZb2Q0Dihf75O5L8k0USAqoR9TNyAvCJGtpZn+wgmCuVLO1nMJPaeomsTaSnb7UbxjcRV+q8+qKBwSix9SUraaDhUx/s3Ykcc1bTtDSGNta1DGqGzrxv2h5Vgx4yT7dZrkDq5hRv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961223; c=relaxed/simple;
	bh=EoXU08fPJsQVQOcewbMGUkC3TgysIQesGJVpibCMum4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VKEmkEuN3wM5UQ2DwIotyvg2b/Fztqmpdfs9rMsQ2KU5aX1YZlseclC1UqQlfTvtrZji21Xm6NDPdztbY9cm72DFCLSyWHyPTzJlXA9GkDeAL6yP6DDdzmFyG99IFlnnNVk38Rt0rkiyzgvBmk8uKGyo6sK6E505OUMxzi8dX0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr; spf=pass smtp.mailfrom=alu.unizg.hr; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=dDcFSayU; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=oAyjTd/h; arc=none smtp.client-ip=161.53.235.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 4D99460177;
	Mon, 22 Jan 2024 23:06:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1705961210; bh=EoXU08fPJsQVQOcewbMGUkC3TgysIQesGJVpibCMum4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dDcFSayU2ug8zC9zfYwtOZeSOe2v26nXCGfiUU8DDLyTqFtvVumXhxJicFrvxCLqf
	 yHjLD9SX4x/BBln0CnYt0f7N/7ghBPyCsvtb7IBpQ7mIjjs6FJwnzTqX+AmIL583Eh
	 5I59hMS6Y1VRuTuaoHyjsbpcPLS1KhS/FzXJ+Gnl395bhgh8o6/2kg/8AZHNCaBKih
	 gtNTM0Omv9blwBjsFv9eCn2bC5mfoBnoUP0Et1Z9YHsRKTxneyYUp962+RFwNTmlUR
	 Ahm3IGJtcvQF8tXmBTQux4u/3PSaT/0j/uzffTvHoYll9tP4SzSdo0WvgaPwbX1Wxf
	 PeV15Iz4C89mQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TwbCQrD6lUaw; Mon, 22 Jan 2024 23:06:48 +0100 (CET)
Received: from [192.168.178.20] (dh207-42-16.xnet.hr [88.207.42.16])
	by domac.alu.hr (Postfix) with ESMTPSA id 476A260173;
	Mon, 22 Jan 2024 23:06:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1705961208; bh=EoXU08fPJsQVQOcewbMGUkC3TgysIQesGJVpibCMum4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oAyjTd/hrCJD+7mI/mIpOyfnv3efqtYUFuPdSTTMCZWb+TZbRBw+iPpKNDps8HPch
	 Znb6YOwUOULLLmTFBrK2lHz/uLwDJBzaaOE9HIkl6TO/3RwdgrDqb9uwgKELRASnRX
	 AkmvpoFsU01Dj0oZsKoA4ZJYfMVAw8/ruxmc45GAkXbhkxfBt7XHXQjw+nExikCjB/
	 uQTBRhahUKjyj2gk8PSrPsAY7ndYMQQTR6KjXAT0rVmAtjVA2O1FjbXh5fAAf/hH7R
	 eXxM6O/AQJnqKqcocvkv/5TjXB3mPwegN2oo51sQdEn/q9EOZO/+2V2oB3iXeAj2gM
	 RF8/FHRdcIPxg==
Message-ID: <0b4f6c60-fda7-4e5e-8f58-7b8729f966b7@alu.unizg.hr>
Date: Mon, 22 Jan 2024 23:06:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG][BISECTED] Freeze at loading init ramdisk
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hdegoede@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Prathu Baronia <prathubaronia2011@gmail.com>, Sam Ravnborg
 <sam@ravnborg.org>, Sui Jingfeng <suijingfeng@loongson.cn>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org
References: <8a6aa228-f2da-4dcd-93c1-e34614cd6471@alu.unizg.hr>
 <cc813525-5484-443e-a40a-cb98f2ed4e1f@alu.unizg.hr>
 <gevqxytidg5efylozindaqntkbl4yeoyzqnh5m3ylitmipgum3@sgmv7qieo7rs>
 <1fe9b78c-7fb5-4d7b-a754-afd563950829@alu.unizg.hr>
 <2q2t7mgnpuk2t7wq2tmymxv72oki4uetojkz72xofn7wh45l64@smk3wi6zw54g>
Content-Language: en-US
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <2q2t7mgnpuk2t7wq2tmymxv72oki4uetojkz72xofn7wh45l64@smk3wi6zw54g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/22/24 11:20, Uwe Kleine-König wrote:
> On Thu, Jan 18, 2024 at 09:04:05PM +0100, Mirsad Todorovac wrote:
>>
>>
>> On 1/18/24 08:45, Uwe Kleine-König wrote:
>>> Hello Mirsad,
>>>
>>> On Wed, Jan 17, 2024 at 07:47:49PM +0100, Mirsad Todorovac wrote:
>>>> On 1/16/24 01:32, Mirsad Todorovac wrote:
>>>>> On the Ubuntu 22.04 LTS Jammy platform, on a mainline vanilla torvalds tree kernel, the boot
>>>>> freezes upon first two lines and before any systemd messages.
>>>>>
>>>>> (Please find the config attached.)
>>>>>
>>>>> Bisecting the bug led to this result:
>>>>>
>>>>> marvin@defiant:~/linux/kernel/linux_torvalds$ git bisect good
>>>>> d97a78423c33f68ca6543de510a409167baed6f5 is the first bad commit
>>>>> commit d97a78423c33f68ca6543de510a409167baed6f5
>>>>> Merge: 61da593f4458 689237ab37c5
>>>>> Author: Linus Torvalds <torvalds@linux-foundation.org>
>>>>> Date:   Fri Jan 12 14:38:08 2024 -0800
>>>>>
>>>>> [...]
>>>>>
>>>>> Hope this helps.
>>>>
>>>> P.S.
>>>>
>>>> As I see that this is a larger merge commit, with 5K+ lines changed, I don't think I can
>>>> bisect further to determine the culprit.
>>>
>>> Actually it's not that hard. If a merge commit is the first bad commit
>>> for a bisection, either the merge wasn't done correctly (less likely,
>>> looking at d97a78423c33f68ca6543de510a409167baed6f5 I'd bet this isn't
>>> the problem); or changes on different sides conflict or you did
>>> something wrong during bisection.
>>>
>>> To rule out the third option, you can just retest d97a78423c33,
>>> 61da593f4458 and 689237ab37c5. If d97a78423c33 is the only bad one, you
>>> did it right.
>>
>> This was confirmed.
>>
>>> Then to further debug the second option you can find out the offending
>>> commit on each side with a bisection as follows, here for the RHS (i.e.
>>> 689237ab37c5):
>>>
>>> 	git bisect start 689237ab37c5 $(git merge-base 61da593f4458 689237ab37c5)
>>>
>>> and then in each bisection step do:
>>>
>>> 	git merge --no-commit 61da593f4458
>>> 	test if the problem is present
>>> 	git reset --hard
>>> 	git bisect good/bad
>>>
>>> In this case you get merge conflicts in drivers/video/fbdev/amba-clcd.c
>>> and drivers/video/fbdev/vermilion/vermilion.c. In the assumption that
>>> you don't have these enabled in your .config, you can just ignore these.
>>>
>>> Side note: A problem during bisection can be that the .config changes
>>> along the process. You should put your config into (say)
>>> arch/x86/configs/lala_defconfig and do
>>>
>>> 	make lala_defconfig
>>>
>>> before building each step to prevent this.
>>
>> I must have done something wrong:
>>
>> marvin@defiant:~/linux/kernel/linux_torvalds$ git bisect log
>> # bad: [689237ab37c59b9909bc9371d7fece3081683fba] fbdev/intelfb: Remove driver
>> # good: [de927f6c0b07d9e698416c5b287c521b07694cac] Merge tag 's390-6.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
>> git bisect start '689237ab37c5' 'de927f6c0b07d9e698416c5b287c521b07694cac'
>> # good: [d9f25b59ed85ae45801cf45fe17eb269b0ef3038] fbdev: Remove support for Carillo Ranch driver
>> git bisect good d9f25b59ed85ae45801cf45fe17eb269b0ef3038
>> # good: [e2e0b838a1849f92612a8305c09aaf31bf824350] video/sticore: Remove info field from STI struct
>> git bisect good e2e0b838a1849f92612a8305c09aaf31bf824350
>> # good: [778e73d2411abc8f3a2d60dbf038acaec218792e] drm/hyperv: Remove firmware framebuffers with aperture helper
>> git bisect good 778e73d2411abc8f3a2d60dbf038acaec218792e
>> # good: [df67699c9cb0ceb70f6cc60630ca938c06773eda] firmware/sysfb: Clear screen_info state after consuming it
>> git bisect good df67699c9cb0ceb70f6cc60630ca938c06773eda
> 
> FTR: Now that you identified df67699c9cb0ce as the culprit, calling
> git bisect good on it was wrong, so something was fishy in your testing
> and it's no surprise the bisection found a wrong result.

Copy that. But it is my first attempt on a bisect of a merge commit, so I will simply
ask to be forgiven. Maybe I forgot "git reset --hard" in some step.

I have to do a thorough homework on the merge commit magic.

Best regards,
Mirsad


> Best regards
> Uwe
> 

