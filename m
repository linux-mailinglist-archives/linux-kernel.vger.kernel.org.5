Return-Path: <linux-kernel+bounces-7710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6BE81ABE2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E37287688
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B440187E;
	Thu, 21 Dec 2023 00:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="yAC+tX25"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD9910FF;
	Thu, 21 Dec 2023 00:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 2810541EC4;
	Thu, 21 Dec 2023 00:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1703119764; bh=CqQ+Tm1lCQF1aHtQ7ijDsp2WEslXk+ZdGq6SK1W3+lY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=yAC+tX25PsMIYont0Bqq8ekIDkQ3fVnUYZYFaGmlIEvwZpaNECIsG8O2s/7H5Fdof
	 OlnNnUlMhE96JEZFYEGn689vPtHrjz1F+/eDmOUBApby1g+dHTonR7r2p055V2VcGb
	 AN5c3f6bcFWym2zItaxkEHLptXs/T3Bk93HR4QXC0d5/MDmJHT1UHElrbAOM8u+KsU
	 o+lDOXFb78qOEyZG9GLU0UtUqsrXqRQqWqLru++MYv61qCJ3T5586vyMlFQtemgqS8
	 56iQtdBskdv2JsasVK7qN8JjGY/b7thUTFdF58ENRrpMLnrwdTywXHEMkh9i5yfx1V
	 TR1+SiHfc99uw==
Message-ID: <d5e26dd4-483d-4662-ba83-5cb19187b24a@marcan.st>
Date: Thu, 21 Dec 2023 09:49:17 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
Content-Language: en-US
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
 Kalle Valo <kvalo@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Daniel Berlin <dberlin@dberlin.org>, Arend van Spriel
 <aspriel@gmail.com>, Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>,
 SHA-cyfmac-dev-list@infineon.com, asahi@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, David Airlie <airlied@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>
References: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
 <170281231651.2255653.7498073085103487666.kvalo@kernel.org>
 <18c80d15e30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <1b51997f-2994-46e8-ac58-90106d1c486d@marcan.st>
 <c392f901-789a-42e2-8cf7-5e246365a1ca@broadcom.com>
 <CAF4BwTXNtu30DAgBXo4auDaDK0iWc9Ch8f=EH+facQ-_F-oMUQ@mail.gmail.com>
 <87r0jiqmnx.fsf@kernel.org> <01bd8c68-1b9c-49b2-8ace-1c7d1b5192ad@marcan.st>
 <CAHk-=whDLKZZEuxU_jEhZRdeWjXAkL8=J_JRk2Ar6wp9UK3h2w@mail.gmail.com>
 <871qbhqio8.fsf@kernel.org> <4c89b71e-8667-40fe-add0-205748de51ef@marcan.st>
 <bdb078c0-2f45-485a-86a0-bb7d0b5e3516@broadcom.com>
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <bdb078c0-2f45-485a-86a0-bb7d0b5e3516@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2023/12/21 4:36, Arend van Spriel wrote:
> On 12/20/2023 7:14 PM, Hector Martin wrote:
>>
>>
>> On 2023/12/20 19:20, Kalle Valo wrote:
>>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>>>
>>>>> Just recently a patch was posted to remove the Infineon list from
>>>>> MAINTAINERS because that company cares so little they have literally
>>>>> stopped accepting emails from us. Meanwhile they are telling their
>>>>> customers that they do not recommend upstream brcmfmac and they should
>>>>> use their downstream driver [1].
>>>>
>>>> Unquestionably broadcom is not helping maintain things, and I think it
>>>> should matter.
>>>>
>>>> As Hector says, they point to their random driver dumps on their site
>>>> that you can't even download unless you are a "Broadcom community
>>>> member" or whatever, and hey - any company that works that way should
>>>> be seen as pretty much hostile to any actual maintenance and proper
>>>> development.
>>>
>>> Sadly this is the normal in the wireless world. All vendors focus on the
>>> latest generation, currently it's Wi-Fi 7, and lose interest on older
>>> generations. And vendors lose focus on the upstream drivers even faster,
>>> usually after a customer project ends.
>>>
>>> So in practise what we try to do is keep the drivers working somehow on
>>> our own, even after the vendors are long gone. If we would deliberately
>>> allow breaking drivers because vendor/corporations don't support us, I
>>> suspect we would have sevaral broken drivers in upstream.
>>>
>>>> If Daniel and Hector are responsive to actual problem reports for the
>>>> changes they cause, I do think that should count a lot.
>>>
>>> Sure, but they could also respect to the review comments. I find Arend's
>>> proposal is reasonable and that's what I would implement in v2. We
>>> (linux-wireless) make abstractions to workaround firmware problems or
>>> interface conflicts all the time, just look at ath10k for example. I
>>> would not be surprised if we need to add even more abstractions to
>>> brcmfmac in the future. And Arend is the expert here, he has best
>>> knowledge of Broadcom devices and I trust him.
>>>
>>> Has anyone even investigated what it would need to implement Arend's
>>> proposal? At least I don't see any indication of that.
>>
>> Of course we can implement it (and we will as we actually got a report
>> of this patch breaking Cypress now, finally).
>>
>> The question was never whether it could be done, we're already doing a
>> bunch of abstractions to deal with just the Broadcom-only side of things
>> too. The point I was trying to make is that we need to *know* what
>> firmware abstractions we need and *why* they are needed. We can't just
>> say, for every change, "well, nobody knows if the existing code works or
>> not, so let's just add an abstraction just in case the change breaks
>> something". As far as anyone involved in the discussions until now could
>> tell, this code was just something some Cypress person dumped upstream,
>> and nobody involved was being responsive to any of our inquiries, so
>> there was no way to be certain it worked at all, whether it was
>> supported in public firmware, or anything else.
>>
>> *Now* that we know the existing code is actually functional and not just
>> dead/broken, and that the WSEC approach is conversely not functional on
>> the Cypress firmwares, it makes sense to introduce an abstraction.
> 
> Just a quick look in the git history could have told you that it was not 
> just dumped upstream and at least one person was using it and extended 
> it for 802.11r support (fast-roaming):
> 
> 
> author	Paweł Drewniak <czajernia@gmail.com>	2021-08-24 23:13:30 +0100
> committer	Kalle Valo <kvalo@codeaurora.org>	2021-08-29 11:33:07 +0300
> commit	4b51de063d5310f1fb297388b7955926e63e45c9 (patch)
> tree	ba2ccb5cbd055d482a8daa263f5e53531c07667f 
> /drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> parent	81f9ebd43659320a88cae8ed5124c50b4d47ab66 (diff)
> download	wireless-4b51de063d5310f1fb297388b7955926e63e45c9.tar.gz
> brcmfmac: Add WPA3 Personal with FT to supported cipher suites
> This allows the driver to connect to BSSIDs supporting SAE with 802.11r.
> Tested on Raspberry Pi 4 Model B (STA) and UniFi 6LR/OpenWRT 21.02.0-rc2.
> AP was set to 'sae-mixed' (WPA2/3 Personal).
> 
> Signed-off-by: Paweł Drewniak <czajernia@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> Link: https://lore.kernel.org/r/20210824221330.3847139-1-czajernia@gmail.com

Sure, but we also had user reports of it *not* actually working (maybe
it regressed?). We didn't know whether it was functional with the
linux-firmware blobs in any way, I wanted confirmation of that. And we
also didn't know that the patch *would* break it at all; perhaps the
Cypress firmware had also grown support for the WSEC mechanism.

That's why I wanted someone to actually confirm the code worked (in some
subset of cases) and the patch didn't, before starting to introduce
conditionals. There is, of course, also the element that the Cypress
side has been long unmaintained, and if nobody is testing/giving
feedback/complaining, perhaps it's better to err on the side of maybe
breaking something and see if that gets someone to come out of the
woodwork if it really breaks, rather than tiptoeing around the code
without knowing what's going on and without anyone actually testing things.

It's not about this *specific* patch, it's about the general situation
of not being able to touch firmware interfaces "just in case Cypress
breaks" being unsustainable in the long term. I wasn't pushing back
because I think this particular one will be hard, I was pushing back
because I can read the tea leaves and see this is not going to end well
if it's the approach we start taking for everything. We *need* someone
to be testing patches on Cypress, we can't just "try not to touch it"
and cross our fingers. That just ends in disaster, we are not going to
succeed in not breaking it either way and it's going to make the driver
worse.

- Hector

