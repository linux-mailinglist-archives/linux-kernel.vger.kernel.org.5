Return-Path: <linux-kernel+bounces-13009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FE181FE5D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C62641C22D82
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 08:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5F41096C;
	Fri, 29 Dec 2023 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Aw12T9BT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0342210A00;
	Fri, 29 Dec 2023 08:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703840183; x=1704444983; i=markus.elfring@web.de;
	bh=TLIBnCVR41anr31BNytRhjf9vcw4oSOtATyNR7teNzA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Aw12T9BTOms3c731LbdPhLBu7QQ7WYYcMSe2es/lXoYMLdm++riAyrgre1jcn8UP
	 L7TJ1Pnh6ndqUhlrzK8XdOAKm2tTJ46d6pVzEpP7igdZtGZHnHoMh6xxgrXtHKwxv
	 K7PlYnZAWdciF8jqULSKGI/5ObrdyQwzBNc3HjiMU7JMVxpF5++ktZ28YwuC+TNVl
	 QhXm3mLN7h2W6NJFP1Ll+GkRIsoVOuv+4BMUtOi+Mn7wLM0y8zB13dNDlXSRMkVEs
	 kh4w2HUL4jihQacQ2R0qKSFRCZBayRVZYdkAoLRh6kEmVMK7b6nr7M3SL2TVulMtp
	 D7Ng0RHiJYsKnTd8Pg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MF2gW-1rUBH511se-00Foq7; Fri, 29
 Dec 2023 09:56:23 +0100
Message-ID: <d224c77f-048a-4fb4-b582-492fd428e270@web.de>
Date: Fri, 29 Dec 2023 09:56:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Input: usbtouchscreen - Return directly after a failed kmalloc()
 in nexio_init()
Content-Language: en-GB
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
 Oliver Graute <oliver.graute@kococonnector.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 ye xingchen <ye.xingchen@zte.com.cn>, LKML <linux-kernel@vger.kernel.org>,
 cocci@inria.fr
References: <9365c845-baa1-44d1-add9-ec8ca4d365eb@web.de>
 <ZY54UDosMHwj6D3Y@google.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZY54UDosMHwj6D3Y@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K3N/JgCX21RpM3f27fdRKwJDDoLXRmG2i5YFyXwrN/krCUMYcE8
 0a5Sm2ZiF2RAnDHWOVUfRNQocEqoUuEdGbCpW0AwENZ0siJiN2CZb1WhSRGstr71sZTop03
 YVBB/G4J+DC6PDg7Y6EZ/NfJptbJCWz11dmhHXIAUgd/JnfFF6YS0h4cZsXkH2XcVF0m7Q3
 npARVFm6PJrP/sPvwEfZw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:abzbliDP3o4=;nsgH/UvmEiwsgW3As5IIowSgbT3
 2dziVncnGh89DkBPVaZaZWtbkwNZHy0do+5q49KULlmBPD36s0DxDXTr0an4CHWpsRroF8K2A
 fw8uiAJMMUzbxxFw713oFHoyIOWRCsq08TnGzuL6lQee+KuV3aeHYJehHUPB9eJLxfqbp7qKL
 16+4cDQ+JDQ/TENMnl/CQIYA/E+TWM2WxtDXDQzO0qli0FK3U+Xbp34F3Hqnr3fWWEivv+J2W
 b1mYJ/JOwaE6zwcORbqMrDp3dQH/DhroaIYzOenrZ6bOgxBGhiyzQXxtLZZpbBBKYEDlnsRbk
 P2DpgkDfd0/R4rm6VjYlhoVOC5CVlzC3s5zxeThJX1x5WN+VvJc7n2eUU1TBT0d74WVryfTfM
 cWAlgHJsXtshVbVIdNaC2qtIc2x91PvwtqmBSfgsrmbn/c84VmiIcggyjGGyDl4nQv3sVqxE7
 ootKcDr3tLbTQC3ezv5a6S+dlUwUFQ9RLTm+AT4xXxxv2afDr2PqIn3J8hmLJqVXqtYSrVKG/
 r0AM2p58lEzFJPkfXFEzhA9oBeKOcz95oz45VcnEPvVKeGmW4pfRmzVpDa0+dfrJztGF5lqxk
 F06e21MB03swuaIPjvkZkn/Ln7GlBmUhJMRUywuh9xrXPWnk4G+EogfOWr/0jk4NgiIizvpAp
 EsHc01nvBcgZZ94ooSqGJHaKThnYCCDLE5MzsMi4zTCGFnLtmuj8R2HE58zjY/JOAwm7k3vsM
 Sw0F/4dN3ev3KYugyJpB/3pS/SjyKZxvcGMXQ4HcRwbhcgUJSwGoLxyQA6G8l4TIj42IkSUkT
 Cz6t3jUb6oSZkgcdkWaKqgi7zKQ0hTSGGASKgI/EVP8ECKKKsKIKZ3rrdlo3PTxGBqKW78d98
 DWTlpiig38SFkivZCzJIRChdZ/pVwLBB3ZOYFdmMDJxo28cNe6WarHg90aT0nnY6JRVBXhKT5
 Nejg0PDxdxx+BxqKTbo1dR9jM6U=

>> The kfree() function was called in one case by
>> the nexio_init() function during error handling
>> even if the passed variable contained a null pointer.
>
> Which is perfectly valid thing to do, like free(), kfree() accepts NULL =
argument.

I find such a function call with this special parameter not so useful.


>> Thus return directly after a call of the function =E2=80=9Ckmalloc=E2=
=80=9D failed
>> at the beginning.
>
> This is simply a matter of preference, the original author preferred
> that style, I see no objective reason to change it.

Would you ever like to avoid redundant data processing a bit more?

Regards,
Markus

