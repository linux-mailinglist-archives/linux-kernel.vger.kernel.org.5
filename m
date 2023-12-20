Return-Path: <linux-kernel+bounces-7374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D870C81A6BB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 19:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1501F2389B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31A9482E3;
	Wed, 20 Dec 2023 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="lOFusqj8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63893482D6;
	Wed, 20 Dec 2023 18:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id C981241EC4;
	Wed, 20 Dec 2023 18:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1703096070; bh=0Ruf0uIt2rqlsafRm8hWJqxuBvI8xmomb8EP+jsV6e0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lOFusqj8rv3nosUxmw0TU/RJ4TCdPhl8aMAFf+AeAoeD1jHAaP5w6xVOAkzjLlFfz
	 NyiyGeFALRHdKovnCvTv4g1O0XZw8L/uidUKT4tHcXZNgCG5ZnhX+uV5I5/Fg0ecI+
	 /o9ztQzI0eQG/6Z7NrRsMeIpKjp+7wleKfI/7WVb6sUAutf1d2cr8Awv3qtSCwIu7A
	 Glof+lHsxsdRvmAT6LiRZbdZv9FwWPYJs3KLvi3V6MB7/XZyx7FMaI7ZgqX/uzw7Qy
	 1GDgRdh6qo3Td0u5YiliHCA6ZR687tCikPJbY+objKKdQ6OT8OeeHsBxoeJqZzjQo1
	 NPTYyPrHNmj1w==
Message-ID: <4c89b71e-8667-40fe-add0-205748de51ef@marcan.st>
Date: Thu, 21 Dec 2023 03:14:25 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Daniel Berlin <dberlin@dberlin.org>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 Arend van Spriel <aspriel@gmail.com>, Franky Lin <franky.lin@broadcom.com>,
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
 <871qbhqio8.fsf@kernel.org>
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <871qbhqio8.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023/12/20 19:20, Kalle Valo wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
>>> Just recently a patch was posted to remove the Infineon list from
>>> MAINTAINERS because that company cares so little they have literally
>>> stopped accepting emails from us. Meanwhile they are telling their
>>> customers that they do not recommend upstream brcmfmac and they should
>>> use their downstream driver [1].
>>
>> Unquestionably broadcom is not helping maintain things, and I think it
>> should matter.
>>
>> As Hector says, they point to their random driver dumps on their site
>> that you can't even download unless you are a "Broadcom community
>> member" or whatever, and hey - any company that works that way should
>> be seen as pretty much hostile to any actual maintenance and proper
>> development.
> 
> Sadly this is the normal in the wireless world. All vendors focus on the
> latest generation, currently it's Wi-Fi 7, and lose interest on older
> generations. And vendors lose focus on the upstream drivers even faster,
> usually after a customer project ends.
> 
> So in practise what we try to do is keep the drivers working somehow on
> our own, even after the vendors are long gone. If we would deliberately
> allow breaking drivers because vendor/corporations don't support us, I
> suspect we would have sevaral broken drivers in upstream.
> 
>> If Daniel and Hector are responsive to actual problem reports for the
>> changes they cause, I do think that should count a lot.
> 
> Sure, but they could also respect to the review comments. I find Arend's
> proposal is reasonable and that's what I would implement in v2. We
> (linux-wireless) make abstractions to workaround firmware problems or
> interface conflicts all the time, just look at ath10k for example. I
> would not be surprised if we need to add even more abstractions to
> brcmfmac in the future. And Arend is the expert here, he has best
> knowledge of Broadcom devices and I trust him.
> 
> Has anyone even investigated what it would need to implement Arend's
> proposal? At least I don't see any indication of that.

Of course we can implement it (and we will as we actually got a report
of this patch breaking Cypress now, finally).

The question was never whether it could be done, we're already doing a
bunch of abstractions to deal with just the Broadcom-only side of things
too. The point I was trying to make is that we need to *know* what
firmware abstractions we need and *why* they are needed. We can't just
say, for every change, "well, nobody knows if the existing code works or
not, so let's just add an abstraction just in case the change breaks
something". As far as anyone involved in the discussions until now could
tell, this code was just something some Cypress person dumped upstream,
and nobody involved was being responsive to any of our inquiries, so
there was no way to be certain it worked at all, whether it was
supported in public firmware, or anything else.

*Now* that we know the existing code is actually functional and not just
dead/broken, and that the WSEC approach is conversely not functional on
the Cypress firmwares, it makes sense to introduce an abstraction.

Here's an example of the case where an abstraction was *not* needed: I
switched over WPA PSK configuration from hex-encoded to binary. That was
needed to make more recent Apple firmwares work. My evidence at the time
that that change *was* at least fairly backwards compatible was that the
OpenBSD driver had been doing it that way all along. Had we introduced
an abstraction/conditional for that case "just in case", it would have
generated superfluous technical debt for no reason.

- Hector

