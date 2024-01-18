Return-Path: <linux-kernel+bounces-30546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42E183201C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD8A28CD8E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058732E637;
	Thu, 18 Jan 2024 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="A1jayF8Q";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="j/gOikvb"
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B002A2E627;
	Thu, 18 Jan 2024 20:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.235.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705608266; cv=none; b=Jz6kcavxHZHByFdPAxQJ05hfRM9cPsCyrEAV9qZo9tlkK3yJ+GtGILVX8gHGhn8ikO/30W072TOHzuSlDiGJp25j16oUswtU6VvK8AZcYrTKoZYV/2w+y2Y1ypGzu0kBqR3kAdBoCPKqRLrxeUz5T6lxklw2+Oyhz+fU7tLwWy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705608266; c=relaxed/simple;
	bh=COhXMdF3+eMsGttATIi38DB05n6Iu0a1pqC7yzI2boU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ucr3mhm5y/cvvLXqf2sQqhTnc0ZCBAi9m+kDh2fhhuZBAsWmDN2kE83ywYvOpm/ClSf0ubo67lYiDKXyBpzVjIXWoleWIqhuxaOLekH+VJvJoc2bnZ4k3O6Rg/zihViXL5mSrLddhmyBfVSKaqaHKcYow/yY64SFn8TatRIJT1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr; spf=pass smtp.mailfrom=alu.unizg.hr; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=A1jayF8Q; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=j/gOikvb; arc=none smtp.client-ip=161.53.235.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 3F2786019E;
	Thu, 18 Jan 2024 21:04:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1705608255; bh=COhXMdF3+eMsGttATIi38DB05n6Iu0a1pqC7yzI2boU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A1jayF8QuQG4CrL+drJbI+qkNLTjXQzU+eDifn/TwMc8PpwLP1JHsQKToJS2ck2ky
	 eA83g3Pi53SKYfFm++BwmO/8uqU8NlL/1F8XszCc5f2pYwzAZ5Z5ihFc/oi4PGiPHv
	 Y2Uyot9OXv9V+Wn13ZJkR065xsHsdU9s480DTRX/bYaWr5/8Z0fYdpr+k7laTDj0WT
	 nOunha61Rc09tQF2FN1f7E2ZJgci1E81fb/Q3OJ6UAEgezxNugFiS2s3IbrgllHbU8
	 bFAldZ37BRAPfaijo3euhQeFfXwQLEohsmwPmPkq+ItKWJJFM/kieZKt42fohtq1X+
	 0VolhUwSNJMuQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FFRGPimg4s5R; Thu, 18 Jan 2024 21:04:13 +0100 (CET)
Received: from [192.168.178.20] (dh207-40-167.xnet.hr [88.207.40.167])
	by domac.alu.hr (Postfix) with ESMTPSA id B694C6019B;
	Thu, 18 Jan 2024 21:04:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1705608253; bh=COhXMdF3+eMsGttATIi38DB05n6Iu0a1pqC7yzI2boU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j/gOikvbTlQUFW2rcpxBxkrxfjuxfp2hRJDRFlLWlGKIz4rmHNo6UCKhSCWMe3176
	 qNbm723njL6MP34/hETkBQ0mIVHd+aYEJpPacF/MulHsb3SolvdMdDFmShcmZGd/xJ
	 4O3SjhERBbckMzJSOLlV5QqXIkFbNCpi6dWaGSKuScEo+Y0abzoBesQudnbZzAdDA5
	 rvVyAq3mg6VvrXhY5QJCTq3eHzrwXdr8Av1RozguaBJ+8hARN31fk4LUJHkv4+nWee
	 XtiqTJF294exckpH5Sq5FEI/GnYzN2U/kBMNB1L5eqbuRfbcjcBXaHisRN9mW+FBe2
	 oRhs5YMbC/AyA==
Message-ID: <1fe9b78c-7fb5-4d7b-a754-afd563950829@alu.unizg.hr>
Date: Thu, 18 Jan 2024 21:04:05 +0100
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
Content-Language: en-US
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <gevqxytidg5efylozindaqntkbl4yeoyzqnh5m3ylitmipgum3@sgmv7qieo7rs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/18/24 08:45, Uwe Kleine-König wrote:
> Hello Mirsad,
> 
> On Wed, Jan 17, 2024 at 07:47:49PM +0100, Mirsad Todorovac wrote:
>> On 1/16/24 01:32, Mirsad Todorovac wrote:
>>> On the Ubuntu 22.04 LTS Jammy platform, on a mainline vanilla torvalds tree kernel, the boot
>>> freezes upon first two lines and before any systemd messages.
>>>
>>> (Please find the config attached.)
>>>
>>> Bisecting the bug led to this result:
>>>
>>> marvin@defiant:~/linux/kernel/linux_torvalds$ git bisect good
>>> d97a78423c33f68ca6543de510a409167baed6f5 is the first bad commit
>>> commit d97a78423c33f68ca6543de510a409167baed6f5
>>> Merge: 61da593f4458 689237ab37c5
>>> Author: Linus Torvalds <torvalds@linux-foundation.org>
>>> Date:   Fri Jan 12 14:38:08 2024 -0800
>>>
>>> [...]
>>>
>>> Hope this helps.
>>
>> P.S.
>>
>> As I see that this is a larger merge commit, with 5K+ lines changed, I don't think I can
>> bisect further to determine the culprit.
> 
> Actually it's not that hard. If a merge commit is the first bad commit
> for a bisection, either the merge wasn't done correctly (less likely,
> looking at d97a78423c33f68ca6543de510a409167baed6f5 I'd bet this isn't
> the problem); or changes on different sides conflict or you did
> something wrong during bisection.
> 
> To rule out the third option, you can just retest d97a78423c33,
> 61da593f4458 and 689237ab37c5. If d97a78423c33 is the only bad one, you
> did it right.

This was confirmed.

> Then to further debug the second option you can find out the offending
> commit on each side with a bisection as follows, here for the RHS (i.e.
> 689237ab37c5):
> 
> 	git bisect start 689237ab37c5 $(git merge-base 61da593f4458 689237ab37c5)
> 
> and then in each bisection step do:
> 
> 	git merge --no-commit 61da593f4458
> 	test if the problem is present
> 	git reset --hard
> 	git bisect good/bad
> 
> In this case you get merge conflicts in drivers/video/fbdev/amba-clcd.c
> and drivers/video/fbdev/vermilion/vermilion.c. In the assumption that
> you don't have these enabled in your .config, you can just ignore these.
> 
> Side note: A problem during bisection can be that the .config changes
> along the process. You should put your config into (say)
> arch/x86/configs/lala_defconfig and do
> 
> 	make lala_defconfig
> 
> before building each step to prevent this.

I must have done something wrong:

marvin@defiant:~/linux/kernel/linux_torvalds$ git bisect log
# bad: [689237ab37c59b9909bc9371d7fece3081683fba] fbdev/intelfb: Remove driver
# good: [de927f6c0b07d9e698416c5b287c521b07694cac] Merge tag 's390-6.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
git bisect start '689237ab37c5' 'de927f6c0b07d9e698416c5b287c521b07694cac'
# good: [d9f25b59ed85ae45801cf45fe17eb269b0ef3038] fbdev: Remove support for Carillo Ranch driver
git bisect good d9f25b59ed85ae45801cf45fe17eb269b0ef3038
# good: [e2e0b838a1849f92612a8305c09aaf31bf824350] video/sticore: Remove info field from STI struct
git bisect good e2e0b838a1849f92612a8305c09aaf31bf824350
# good: [778e73d2411abc8f3a2d60dbf038acaec218792e] drm/hyperv: Remove firmware framebuffers with aperture helper
git bisect good 778e73d2411abc8f3a2d60dbf038acaec218792e
# good: [df67699c9cb0ceb70f6cc60630ca938c06773eda] firmware/sysfb: Clear screen_info state after consuming it
git bisect good df67699c9cb0ceb70f6cc60630ca938c06773eda
marvin@defiant:~/linux/kernel/linux_torvalds$

with the error:

marvin@defiant:~/linux/kernel/linux_torvalds$ git bisect good
Bisecting: 0 revisions left to test after this (roughly 0 steps)
drivers/video/fbdev/amba-clcd.c: needs merge
drivers/video/fbdev/vermilion/vermilion.c: needs merge
error: you need to resolve your current index first
marvin@defiant:~/linux/kernel/linux_torvalds$

Best regards,
Mirsad

> Best regards
> Uwe
> 

