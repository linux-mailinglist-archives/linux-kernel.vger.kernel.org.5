Return-Path: <linux-kernel+bounces-157361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E334C8B105E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F111C24B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF53E16D33D;
	Wed, 24 Apr 2024 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="2UpQJN3A"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED5616C87B;
	Wed, 24 Apr 2024 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713977784; cv=none; b=tfwIVM4rSq/JkZ4Wzsrje2uk3cJJmG7mUnEtYN+Xqf0SgONpk8qadPQ3FOwMdVfvF3/W9QLdBSc3XM6Iyc/ZKBTMoRPhibq3slSWaPVUIeCxGkTpcl4A6PaswJmQkrBzVSrfdVtN1wiek0w4D6kXbKhADmWXShceuvOUAKNGbKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713977784; c=relaxed/simple;
	bh=jFSAdj8Fg1g/sV31cy/CgP0Fejcy6/GdPi/dUTUgELU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=coZuX/3ThjKEYhmHCQuT+UEVz0Oc4lZ2nMmohAyG7w1XxNLzTgS2Vt8z1tfNOhazcE2Z746zjYMywcsP4R5v4ThgTc1RFeuyoRgexL6TQ+Dr/3IxYCyG7NW3zwNaCq3ePHclmyJMMhCS5I8vKXz0wG50ftTwdSvPXzBN4jAb+Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=2UpQJN3A; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Gr5w+NNXaBuu9MFvS/3sV7owIcp9t8FJfSpSoyXuyTk=; t=1713977782;
	x=1714409782; b=2UpQJN3AUCGtXaPA6BYlPw/2ltZGacGaU5IfAUgvQoN83avPhpYvLvb0X3p9A
	8WqmDNCyDBHF3IGYGF/UoiB6y5V4i+FnbI1gOaN+fdjmSkjaWrIEQnNu1j5sVpGfoTh87fRPvrZG1
	0pVoaqEE6r9gSpW7wu6LXHF0IAOXxQSv2yoPPlGcn8xNJRqSZghxHnJY+sYBqtBnqZpOfNyTJaGck
	+CeNB8N9Ws42AIpahmx0OjuS+/FuYo32G58ikk3wXH0Fxt7FBU5nrtx2q23oUfw9Ki5NGRxsEudXI
	mZs21UUrlNemneRqzYW+KYaLfNUFqo9jCOIxAwmQ6gxNK9ix2Q==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rzfus-0000lM-MC; Wed, 24 Apr 2024 18:56:18 +0200
Message-ID: <a810561a-14f3-412e-9903-acaba7a36160@leemhuis.info>
Date: Wed, 24 Apr 2024 18:56:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: regression fixes sitting in subsystem git trees for a week or longer
 (was: Re: [PATCH v2] HID: i2c-hid: Revert to await reset ACK before reading
 report descriptor)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>, Douglas Anderson <dianders@chromium.org>,
 Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kenny Levinsen <kl@kl.wtf>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <20240331182440.14477-1-kl@kl.wtf>
 <14d1b38e-0f11-4852-9c52-92b4bedb0a77@leemhuis.info>
 <CAO-hwJJtK2XRHK=HGaNUFb3mQhY5XbNGeCQwuAB0nmG2bjHX-Q@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <CAO-hwJJtK2XRHK=HGaNUFb3mQhY5XbNGeCQwuAB0nmG2bjHX-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1713977782;880531d9;
X-HE-SMSGID: 1rzfus-0000lM-MC

Linus,

On 23.04.24 16:59, Benjamin Tissoires wrote:
> On Mon, Apr 22, 2024 at 7:11 PM Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>> On 31.03.24 20:24, Kenny Levinsen wrote:
>
> [previous subject: [PATCH v2] HID: i2c-hid: Revert to await reset ACK before reading report descriptor]
>
>>> In af93a167eda9, i2c_hid_parse was changed to continue with reading the
>>> report descriptor before waiting for reset to be acknowledged.
>>>
>>> This has lead to two regressions:
>>
>> Lo! Jiri, Benjamin, quick question: is there a reason why this fix for a
>> 6.8-rc1 regression after more than two and half weeks is not yet
>> mainlined? Or is there some good reason why we should be should be extra
>> cautious?
> 
> No special reasons I guess. Neither Jiri nor I have sent a HID update
> for this rc cycle, so it's still there, waiting to be pushed.
> I've been quite busy with BPF lately and dropped the ball slightly on
> the HID maintainer side, but I'm sure we'll send the PR to Linus this
> week or the next.

out of interest: what's your stance on regression fixes sitting in
subsystem git trees for a week or longer before being mainlined?

The quoted patch is such a case. It fixes a regression caused by a
change that made it into 6.8-rc1, but the problem afaik was only
reported on 2024-03-19, e.g. ~nine days after 6.8 was out[1]; Kenny, the
author of the fix, apparently noticed and fixed the problem a bit later
independently[2]. Jiri merged a newer version of the fix on
2024-04-03[3], which was included in -next a day later -- the Thursday
before 6.9-rc3.

The fix thus would even have gotten two days of testing in -next, if
Benjamin or Jiri would have send it your way for that pre-release. But
from Benjamin's statement quoted above it seems the fix might even make
-rc6.

That obviously heavily reduces the time the fix will be tested before
6.9 is released.

It obviously also means that 6.8.y is as of now still unfixed, as the
stable team usually only applies fixes once they landed in mainline.

Which also means that even more people ran into the problem with
6.8.y[4] or mainline even after Jiri merged the patch into the hid tree
-- and maybe some of those people wasted their time on a bisection only
to find out that a fix exists.

That sounds, ehh, sub-optimal to me. Which is why I wonder what's your
stance here, as I encounter similar situations frequently[5] -- which
sometimes is kinda demotivating. :-/

Ciao, Thorsten

[1]
https://lore.kernel.org/all/a587f3f3-e0d5-4779-80a4-a9f7110b0bd2@manjaro.org/

[2] https://lore.kernel.org/all/20240331132332.6694-1-kl@kl.wtf/

[3]
https://lore.kernel.org/all/nycvar.YFH.7.76.2404031401411.20263@cbobk.fhfr.pm/

[4] https://social.lol/@major/112294923280815017

[5] This fix for example:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=afc89870ea677bd5a44516eb981f7a259b74280c
Reports:
https://lore.kernel.org/lkml/ZYhQ2-OnjDgoqjvt@wens.tw/
https://lore.kernel.org/lkml/1553a526-6f28-4a68-88a8-f35bd22d9894@linumiz.com/

> [...]
>>> 1. We fail to handle reset acknowledgement if it happens while reading
>>>    the report descriptor. The transfer sets I2C_HID_READ_PENDING, which
>>>    causes the IRQ handler to return without doing anything.
>>>
>>>    This affects both a Wacom touchscreen and a Sensel touchpad.
>>>
>>> 2. On a Sensel touchpad, reading the report descriptor this quickly
>>>    after reset results in all zeroes or partial zeroes.
>>>
>>> The issues were observed on the Lenovo Thinkpad Z16 Gen 2.
>>>
>>> The change in question was made based on a Microsoft article[0] stating
>>> that Windows 8 *may* read the report descriptor in parallel with
>>> awaiting reset acknowledgement, intended as a slight reset performance
>>> optimization. Perhaps they only do this if reset is not completing
>>> quickly enough for their tastes?
>>>
>>> As the code is not currently ready to read registers in parallel with a
>>> pending reset acknowledgement, and as reading quickly breaks the report
>>> descriptor on the Sensel touchpad, revert to waiting for reset
>>> acknowledgement before proceeding to read the report descriptor.
>>>
>>> [0]: https://learn.microsoft.com/en-us/windows-hardware/drivers/hid/plug-and-play-support-and-power-management
>>>
>>> Fixes: af93a167eda9 ("HID: i2c-hid: Move i2c_hid_finish_hwreset() to after reading the report-descriptor")
>>> Signed-off-by: Kenny Levinsen <kl@kl.wtf>
>>> ---
>>>  drivers/hid/i2c-hid/i2c-hid-core.c | 13 ++++---------
>>>  1 file changed, 4 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
>>> index 2df1ab3c31cc..72d2bccf5621 100644
>>> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
>>> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
>>> @@ -735,9 +735,12 @@ static int i2c_hid_parse(struct hid_device *hid)
>>>       mutex_lock(&ihid->reset_lock);
>>>       do {
>>>               ret = i2c_hid_start_hwreset(ihid);
>>> -             if (ret)
>>> +             if (ret == 0)
>>> +                     ret = i2c_hid_finish_hwreset(ihid);
>>> +             else
>>>                       msleep(1000);
>>>       } while (tries-- > 0 && ret);
>>> +     mutex_unlock(&ihid->reset_lock);
>>>
>>>       if (ret)
>>>               goto abort_reset;
>>> @@ -767,16 +770,8 @@ static int i2c_hid_parse(struct hid_device *hid)
>>>               }
>>>       }
>>>
>>> -     /*
>>> -      * Windows directly reads the report-descriptor after sending reset
>>> -      * and then waits for resets completion afterwards. Some touchpads
>>> -      * actually wait for the report-descriptor to be read before signalling
>>> -      * reset completion.
>>> -      */
>>> -     ret = i2c_hid_finish_hwreset(ihid);
>>>  abort_reset:
>>>       clear_bit(I2C_HID_RESET_PENDING, &ihid->flags);
>>> -     mutex_unlock(&ihid->reset_lock);
>>>       if (ret)
>>>               goto out;
>>>
>>
> 
> 
> 

