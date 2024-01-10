Return-Path: <linux-kernel+bounces-22178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE6F829A89
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508CF2872B6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1A3482EE;
	Wed, 10 Jan 2024 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="r6wNb2QL"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BBC48794;
	Wed, 10 Jan 2024 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704890642; x=1705495442; i=markus.elfring@web.de;
	bh=la73kn+TFTFDaF+8Q3UYpU2TqjBC/104wbhwQuU4dVA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=r6wNb2QLlvgzanAylRuVIUnrnIhoQHCghVrgE0np/3FuNwDKHeXAdtQy8FLFx7id
	 RWlL1xR/Etldcu55AikeqKyJq4cXTtWAk15hIhpx0m69fkfjRur/edlcXl/biHlNn
	 cPIlstKwno5OkxSFwkbVaZaGl+jgByLS0aYNj6qAFliaxcp2UxvDcC7JOwPCdtvbP
	 DxJqJKsC3keKNNTzoS+2fZN0jewnuvm56CNw8yzxHNUvPpScoe4cryv3O2pB1JRRG
	 NlU4lYTPchb2vQfvRhkinoPDPjKnWvwsitdWvhahSrqC/XckxjtaFHkFkECKpTiyZ
	 i7M0XDdSGq/h30pHmw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6JxT-1r8NZb2ynx-016YEe; Wed, 10
 Jan 2024 13:44:02 +0100
Message-ID: <1c38e495-5c9c-4ff8-b453-93b882dd2c4c@web.de>
Date: Wed, 10 Jan 2024 13:44:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [0/2] ARM: Adjustments for init_atags_procfs()
Content-Language: en-GB
To: Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 cocci@inria.fr
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <562a6f99-3f8e-9a77-e519-b668e24dced2@web.de>
 <b3c42397-c879-4381-aa96-c7887e81c068@web.de>
 <7dd19987-6590-4756-a929-1ff01503ad1c@web.de>
 <ZZ6MZl14bcIaCaQn@shell.armlinux.org.uk>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZZ6MZl14bcIaCaQn@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CdzX4zLJRKZiTncQNCOSQvc+4e103tCDmLiHfON4OVsvsJodBn4
 Y+SFuLIXC2xvnz5QfL2UL3MBVukgf+QqUMavAu0AbyULgt/T/FIqEY/kCTz7zZGeV27Svj7
 sSc2Jxbr/q/e5kCNJvcKuY0zWpJqxed9bKExbGIxcki165O5urwF3HvrStTtBvlc4mTQGjO
 9LbqwN09hU9l17l7QxhUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uIIKa0+Co88=;a0o93Pace7y+DJpz4dPP0YadH7y
 kUAmPkvK54GswrVaj/QWwAYFmpKrhZaw56a8e3J3J9eGXx+/SiN69tNuFKO3V6VIcYGH42sqi
 yra5mmX+Xk5K2bYbetfYshKXYUM02QA4TPXh4JipPrlklWXq5heYcS45ngb92kV2o6k/Hp+oO
 OpdKhsfk4xHnv7RJ1P3hRujSnrqyO7WTutJIHXqXLE1BQ4/DhBE9cD/BxT6Lzigs3LklUjDyE
 poBfln4jtmJ8LK7hVe0snKplnG65nrWbJ+NTQfGs9NtwvqGaqebjPQ5e71Rq5CUzA7gzt19jQ
 FWlUKCVkZ+yg4KOyQAIUM0gMzholkrjqLHgHH9xgAy8bqIhfUCNRm5Sc0nIA7fygfU3aPakBM
 3I7c3BW98RuMI4DlxkvuIBfpS2fn99nx9BTXCwUuSe8ZyBnX48cPwByM1dzChAViaLHBM1GqR
 ES9zie1ufpdEGX5T0k8R4Hp0Pqzv0wQyePNsnkn5PMLZRmWoRWgPsYmNow5l53fFSp0sFplWk
 sTT0wMPt3ODH3xaTOCgBSv8EB36KDVZw6JzFfz5MAXx7kX1C86UGfV2PMJQqoIQpE5ztWI4N0
 1GtW4I/8QE2laovyTVmX40EYaf41EsWFZAd7/hUzJMIVSeCSH4TaTfbnPJBRYsVK/vKFWFE78
 vwlu045mF2Vu+Os5Svy4iGP5z+d+EAoU+qIQ9EC211AK6bfn4691MfOOsSqlXBeyzG3n9LtwA
 +LZIYY1HoVBuLZEhgudwKEj4G2fRFKZFAsG/ZiEuIgQNvNwV6xdztfY/IJnYKH5hWSLVUkG5c
 ZQTFl6KqehppMJv8yT4FSBFBtoHTHgjuYA4V1dtO1iyWlr5/81lqjvolsEK01pq1RCiZmFPcU
 ymdH8yIXvIgrXKgyT0U6Hh8h/3qFoq7d56vGUcNokjHXad2HlEVzfLMmtaqSRwC3+3QUXlOqB
 J7GFpQ==

>>> Is this patch series still in review queues?
>>
>> See also:
>> https://lore.kernel.org/cocci/562a6f99-3f8e-9a77-e519-b668e24dced2@web.=
de/
>> https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00098.html
>
> I suspect no one looked at it, sorry.

Special mailing list settings probably influenced this situation.


>                                       I don't catch everything that is
> on the mailing list. Looks fine to me but it needs to end up in the
> patch system to be applied.

Can you collaborate also with mentioned mailing list archive interfaces?

Regards,
Markus

