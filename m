Return-Path: <linux-kernel+bounces-45018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C17842A83
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F3F4B25727
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C8B129A8F;
	Tue, 30 Jan 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="J+6Fj07r"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FD967A0F;
	Tue, 30 Jan 2024 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634626; cv=none; b=YIebvrXXZDEHyDiA6qnYqz89RCmEL8vmPsAWmxNLfnxHbZ45N/LfB118o/5a0MLYpqI2rRaFWsbg3M6wVFW5OjY6q0VqaFXBevO0U3X/qcHxdkoK22UMFp48WJ010pawYKzRQWjw7rzu+Ba15ps1p5JnMt43O/2421z1rFfW8VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634626; c=relaxed/simple;
	bh=QOE3n4Szn+LSvifyAKQARBkvfKb6ykLiCedZCr70OAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dG+Aih0qDVjW1iL1Bv6pIQRkW70fyrdbq6oSkKxFehIPDWy5rIUiu5/IIvRpkbg5+2m4/OIeKm0u3FetPhX+5cPwedFZetqxOOlX9PO4irqfewK7jun3swJn3QefjohsMqiPuc7vwACtGknJjIExMj1bWHRY8tcgB3uF+l/KiV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=J+6Fj07r; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706634579; x=1707239379; i=markus.elfring@web.de;
	bh=QOE3n4Szn+LSvifyAKQARBkvfKb6ykLiCedZCr70OAc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=J+6Fj07r4h5QMBXDL3yWwpiIA4YuvymFHWYwCxF/fzliYafXYoOq3aQtKLmhjf0D
	 bqX39felXEEv+IP0w3LMd51AMFBFbMm68ZYjTA4rFJ/Y+bIkojaWxHgbH0b1gsmBV
	 4FMCqe1u0IeT84V+o0nPlPU1zn79Y0R2Aljqwqd1K0UQSbNT07Ns4FJx8G1gcVJAr
	 ZYgrZnZAbW5LhqBB60wsFsQ3NUH2wEkJ+HXdM2l1tpoxjgPseDdcFQPDQXnwVPXNx
	 e1YyzasYf+LFyKbvYztTq2wCkfJXpQyuUgCDqgndpNFtIJB4QQ7uilxtfgHmE+ORX
	 1OnoxGHdYQBpRyCGHQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPrLN-1riQNs2kRX-00N4Bk; Tue, 30
 Jan 2024 18:09:39 +0100
Message-ID: <e760bd1b-30bf-489f-b745-128d05397feb@web.de>
Date: Tue, 30 Jan 2024 18:09:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fpga: dfl: fme: Return directly after a failed devm_kasprintf()
 call in fme_perf_pmu_register()
To: Dan Carpenter <dan.carpenter@linaro.org>, linux-fpga@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
 Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <chentao@kylinos.cn>
References: <d94376b6-12e8-45bb-a9be-4887bb316d35@web.de>
 <b7e2e9d1-5e3e-44b2-a4b7-327d334b776d@moroto.mountain>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b7e2e9d1-5e3e-44b2-a4b7-327d334b776d@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s0VR/FQjS8xqSh6FSezEsTEJZaJ+Kbc9lwjc4qySvtM5vk5B9d5
 1A86barTpJ5n2bgZDN5MoVCNBa80vBQkveD0xtfiR8zwKgJK17Fbiykcsn92243jpl5F1Sa
 yKrRaZrlnO42TK+fXz8ihIQJc4X+NNA8iDTgt+nMs9/N19uQrJ2SwdTalhBVDuYNLgtKltC
 b67oz431eomL1htQGsTZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0Ig/6CYNJlQ=;YAvJJnUV3C50hnqV3RKw+y4p40z
 HRPxUrOm3NJcdxxv7ApPGPAiGPdYFa0TTdcXTYuT5M6ULSPUCcAdxaqLgxfOQ0YzyOh5NVpdk
 H7LqAPx3y9n3IUWIwhjJ5AofSXgatsrCYpUvZguDkQyhakpEtbiQJ8P1CN1KT721GpgRBs0hq
 HbB2mElLGM9EDcKw39u9UJyF3K+pknXdh6nh67D1O7bgsk0/HlPFjvnZY9FA6FgQg0M8QhsLt
 qPYzcvIwKOu0xzX6fcu15F3VlUK2Y2gut0MsuNGj7u2GIfgRjN056xO9sApZPoFen+T3MUgB4
 70YdYfnJ+dq0q1pmfNjn0Dzh9Cc6QVGav3hYGfl5PtK/3nZ4KH/LiqZNb4zXLksOCOcanfQL+
 owOBCvM7lPv3gT7NP5cQ+DkeNoM32nRQOowc2LPzLuJjwf5lxC3zh6HnIH9oY+xhOSEwBxcIm
 rEOrosjz/LVz1Njifyoqayk01llh8mR5eXS1J6IjCSFUM3WbhlXi9nX3hh2YVpnsOpj7Ri/tT
 7+ZD2L3VN8L5muWAcFWoaiS810RbMWNwtOeh7q7kR1cVb5wiFaEnhoRVBPnr18b6hoSgO+Tlm
 6IZn/fwhMPi9lGyAMMHJMERQWFbMZbImjOgEyrGcVvDO8S3WN8x3YMXhqewLX5SUG5TLSnht7
 hi5fe+wCBTod7q+ft761AHmHUlO1b8Jec+vubhCQukeNunFE73Y0yS/ufAh1liv/XeoD4fjYd
 Y2tTa26NoK7l2OhHIIUyJ1X3bvg28A1bH41xx1vGpVTLwLejIHe2rvAkN5QmicoKkAwOQZpbT
 oL2IPYYLf9peo0nWNXD7M3Egz1Dc5i1tQkpyiKlv8AgTQutwpW0lpn5E++rrixJiiplUXNCdB
 rR/Se+9eXfFZdcJDM9Bdg54bZ3sGtG15+AAq4Mc2WISzEJPrAceGnMgufWE6O/Zqb0adxZYPJ
 hCOolA==

>> Thus return directly after a failed devm_kasprintf() call.
>>
>> Fixes: 724142f8c42a7 ("fpga: dfl: fme: add performance reporting suppor=
t")
>
> This basically doesn't affect runtime because perf_pmu_register() checks
> for NULL so no need for a Fixes tag.

I suggest to clarify this view a bit more also according to statements
like the following.

1. https://elixir.bootlin.com/linux/v6.8-rc2/source/kernel/events/core.c#L=
11532
   perf_pmu_register:
   =E2=80=A6
	pmu->name =3D name;
   =E2=80=A6

2. https://elixir.bootlin.com/linux/v6.8-rc2/source/kernel/events/core.c#L=
11472
   pmu_dev_alloc:
   =E2=80=A6
	ret =3D dev_set_name(pmu->dev, "%s", pmu->name);
   =E2=80=A6


Regards,
Markus

