Return-Path: <linux-kernel+bounces-112676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE344887CDA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F6B1F213EC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31A217C6A;
	Sun, 24 Mar 2024 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="kQMkCT8m"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4D9BA55;
	Sun, 24 Mar 2024 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711286604; cv=none; b=mQcjTo64fDMnu8zpxlWXN3fY9HID1SBd9sjk4rqPH/wBZUfyeN/hiCBOMTw6EltbgPKS/bsvsRsLTmnmU8P521ZHy6GHTnsdnj6//tE1fBQBdsvlhvxxp3ENn9oatW/PPr/14m6st44V6+KkqJYQR1fT0cPwDjJco3AfQIuXM9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711286604; c=relaxed/simple;
	bh=PZ1lJ8EZUKwwYkv9frDc8GCtVXzwadN5P2zxl/C7Vew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPBgtCnt+vByvkJJFuGkrPqrJ4qmBT0d2KmUR2tSnbwq3fSpXFUZdQDGs/Y643NgogEYH5/IzNPj/3sLIGx37bT0J2tRPGXyVmMHtT0pxgtSPOyvQDiFxgUNvRiACogApOYqApoRcs87GairV/C3KD7KxmnT2lHDCzFtCgWbnt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=kQMkCT8m; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711286567; x=1711891367; i=markus.elfring@web.de;
	bh=MTqIB3naOtDYLJf0K8rUUG6vL07A9g5twS2/717iwn0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=kQMkCT8m4qnhAjinVUeBCnUPEwveJL7b1XTagYv/8FdtFu0EMKMtUIVVYCqVa75w
	 /3c8fG62V4M24e7nUi2Enyopu0uwExw8XTJCPsS3EWipxVW+O4tajAz/IHmfoVwCG
	 QmQVAsYLSHWt403NGLaumyQ9pAf6LTTQgM8qUEJMwKJ350RlMU5gcN7hAYUyXs+hE
	 TEEDsGYslfqrRz9XhPkwr+kZ1M3V2aH3Z8CGhIXr/bqXN40sio2duh7KaQnR3A67W
	 IuZ0efVRBu4RdU3f7bm2EngEiq5zm15a+GgprRFRFO0dYlj8kvmBAiDtU6Hd4pqSR
	 PyFMe0qAYgOviryUZg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdwJY-1sPNJp2ydq-00b2mp; Sun, 24
 Mar 2024 14:22:47 +0100
Message-ID: <4366d46d-0edc-4e45-8695-9fbaae571049@web.de>
Date: Sun, 24 Mar 2024 14:22:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] ice: Fix freeing uninitialized pointers
To: Dan Carpenter <dan.carpenter@linaro.org>,
 kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, smatch@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 David Laight <David.Laight@aculab.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Cameron <jic23@kernel.org>,
 Julia Lawall <julia.lawall@inria.fr>, Kees Cook <keescook@chromium.org>,
 Lukasz Czapnik <lukasz.czapnik@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
References: <0efe132b-b343-4438-bb00-5a4b82722ed3@moroto.mountain>
 <08c9f970-3007-461a-b9f9-9ab414024f68@web.de>
 <f292facc-8a22-42e1-9a41-5ec8bd665cb7@moroto.mountain>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <f292facc-8a22-42e1-9a41-5ec8bd665cb7@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CTdIMvqo4D4qp88LUdaGqZIeHr1rsg3dFK6XkIHsGrHhX8hygEY
 xeM1L1NTweuW3yDjP7/0iUWobOfG1BjWaTh6I8vwbM+vIvzxR8Rk+KlwJTjzxlTOvCwFLiV
 +ZneA5TyR0xTkqnQYujVvGiIS4L4sz89Ic4B4ewElUyLvHfwQP8x1gHUbg0FmhebGh9xuHv
 M5jekW0cafP2FWuE+PxZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q96qtKu9Jgg=;9ZP3rm0Jn0OfUlIbeNEbpN9nU/M
 xn8mc10NleKEXz9b2oluXRoccSYgAKwfacOkizrpDcGDnA9ZWAPjXgL0sHcLDNA893XhI5baF
 Za+a0Dk7zhjy1NtgOnvWyo1VV/UazU3K/hCP7pN5n3u0QSt2GaCFi6B4yHoUq2Ca1IkSiKgGf
 mPBqFcSyKwCofpDzEZzRMioDXbCcVphpYLX1UZmKVTZ9kWB3QeTYLNPiqwEXvYtoH6y7PVkPZ
 8/AAtegyu4TxtA55uI1LMi1g3y/oTkScC1n2JyvuIZSTyd+P7Aiu0/zI0sVEV6Fvh6LXyo9ar
 HMVXM/t+fcB0cwP1jVYymweYswOrSkcjfxA1D3tHaPhbFU+36QYNWLxDc64kVOMFVAsqL1EN0
 t9Fdg+UXNwFhJznxczvf6pUV+ji9bp/9YQsoglcoc0iCQgxAVv9QWk/lfReVIiThk9d5nxPGD
 iPz3nrl6c5FQlW0yHtfCg+x3RHaPKHSL7OXjG3R/sNIvaVD4AhynRV20X00jEHmnwwoqpQkUs
 WsH+pdc69FXbRYfMOxKH8Nx1DnTeFcs9qhzXhkq9Njp5il1TpSkUv5u9bzUo/u7dIXM3Eluur
 q7getxrKfv/PYUUZlRrQgVuVBQYrllnrQLWWhxGdR6eyA6NOnpefkkkpH4yVGdRsqY+AgeV0V
 t5Qb7luwnYivTUSN3geuL32ZCRpS6mL0G+CQx3wjQxVFmD2kU47/FShQQqTnLsedVWrq40npN
 IYjTeRXrsJeAvWv2mPe+RLXDx2BghdjxTKoeGWSVVioGfXoUHr2SkEU7v2By3wcXP3FoJWrkH
 BFs1R1u8LpCFyGRh9sx5j5NlL9a4aTob4DGb4OPMaPmFc=

>>> Automatically cleaned up pointers need to be initialized before exitin=
g
>>> their scope.  In this case, they need to be initialized to NULL before
>>> any return statement.
>>
>> * May we expect that compilers should report that affected variables
>>   were only declared here instead of appropriately defined
>>   (despite of attempts for scope-based resource management)?
>>
>
> We disabled GCC's check for uninitialized variables a long time ago
> because it had too many false positives.

Can further case distinctions (and compilation parameters) become more hel=
pful
according to the discussed handling of the attribute =E2=80=9C__cleanup=E2=
=80=9D (or =E2=80=9C__free=E2=80=9D)?


>> * Did you extend detection support in the source code analysis tool =E2=
=80=9CSmatch=E2=80=9D
>>   for a questionable implementation detail?
>
> Yes.  Smatch detects this as an uninitialized variable.

Does the corresponding warning indicate requirements for scope-based resou=
rce management?

Regards,
Markus

