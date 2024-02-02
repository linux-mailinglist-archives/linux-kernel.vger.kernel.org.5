Return-Path: <linux-kernel+bounces-49393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6EE8469E5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD9028C982
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E45A17C70;
	Fri,  2 Feb 2024 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XpQlNfzf"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0848217BA8;
	Fri,  2 Feb 2024 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706860705; cv=none; b=EjWzR3h8b68Fo1w5vFBkOHWhmoLNZ52LVAUlKornar0hvxAOAi0wnJjSJdFZUz1yzgVAcQUiC0leTqo4S+Fih/YNwycSI7owWlqIPRGwtlrPGXVz1yuFd8jrSFAQ7nq00xIGdRk1moc4ANrQIFTjhlQd5OBxmWug0A+QHv64HZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706860705; c=relaxed/simple;
	bh=WXu4/0SmNlUw9ukdfS1oTJfdOj9hOaYnoUFtTE5PiCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M0OAmfEzXY4+5Jibn4jSCHO4U9vvHrefEz8WQlIWwcweu6w3TkD/iB/U3f6HPUgHug0gVk7TRiTd0l9GyQqT9+VISRISzGTM4xe9h12snHJebJ+iXC/wfqcQGz6mk0E0FKi1zDKYQBS6Ha7Np5AsGWuViZLS6udm9vOIbXzsb34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XpQlNfzf; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706860685; x=1707465485; i=markus.elfring@web.de;
	bh=WXu4/0SmNlUw9ukdfS1oTJfdOj9hOaYnoUFtTE5PiCw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=XpQlNfzfNN7R/qHoN6/4ryLK6Wjb03ahHvwl/TItpslkoxaLO2w3IAvV0DZYi/Jo
	 jNlCNfCw4EyTDJJP6nfKMR+0u4UdprCru4th+GOtDsgjcfDKN3CcX57dIEEV694mQ
	 BZXcLTi6IETSLJAy6dUSnzKMpRCR3WwS/ZfHa88qIPKB3ZvMbXLm7M2F/8Tf/qddL
	 uFH2CeVBXgnsJ5Ap2v9JgUZBT8AWoZ7aLbdDqhLxnGyANPvREBSNpxtT+QSC9+mOh
	 iwy2fgtpP79h/O/x/lt059XjukifSqxZvWzBXOxNN0qNWFSC3nQKM7j1+vbOlU49U
	 YvngotXnnrbJ7txkaQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6YNJ-1rPVye0Mqf-006dAH; Fri, 02
 Feb 2024 08:58:05 +0100
Message-ID: <0008614d-bd62-4e05-a063-b1ce6ced90d1@web.de>
Date: Fri, 2 Feb 2024 08:57:02 +0100
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
X-Provags-ID: V03:K1:Gd9FMzio+eEpJUmNTbX9PyQNmf38A2yTnU3187dIPcNgwsbWayg
 3XhyF35zXqWOaNupGrh1+HQZqwf8DJnXujVs6zMb3FKwBKEvIb7Z8fU0C1lorcf7+tKTcGE
 SBCcLTctYYXZYPakUQe/a/I99h2yNQfO0NE79pq4tz5YYdnKsM5e3qHtRBWGHkhwQUVt2zo
 HRSe5bs02Cczj3RL447eg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zC3BJmvRg6I=;B4Of8fxqFhJqj4E8sLHvqF/ZqIS
 6tYr22rkX8WtAHtd4b+AKHUAT23I2xvzyQhy1eO/5NjNKcVppHb5erefO01dCn+kbUuKOSKrB
 Pknh3SQP+b+xWQ/7k908VapY3lyWp6v0nrUmvaXJIDiFbFTITq15a7xYfUmchhEL5pOjaNLf3
 Bz7BVWuc82KErFpmEkbw+kUQ02CaR7BDrA3T9VVYH0+9a7K7M4N9TNpIMK6miEjVIU4Mm1bZu
 W7bmrkWZcliQ1RATqEvKMqDtNaxkXQ5ekz2tcn1ZsXllVXhMAXOpiljY9BjpfxiLC2j6IUN45
 g1FN9IaXlNOdeLxvEMStlqLexEXUFtn46DsumT6+3YZZvI7oNXthyB9EExhfFXcMzt5BGoVz1
 cAkn06U3g4jeA/WL6wDKyNzzhxp1Bf8ZV82FGAI4ZXhATFTgZ8QFsooVt5X/R2SIvYGtWO5In
 BPQexypSymRH/yDPhRFQgy5Xe8nzdXMY8HgLbO5/dgUXLLPE+Xxmi6oP8xf0BU3NKVRSfiCPW
 Q6jO46uZahQLEHaugJWgcsrBbSR32erekNeFc9cYnIPvmiedsw+3ycaZfE0Ep8ms+JqW1uPQY
 9KJDOzwBuwJ+HnGxmRytCgnhmrSmnujR0TRHAOgc9P1/sHIhi1aOQjMKBSz/1YmoBr/1wpHwU
 /kT+qeNIxSbUlAaJbX7fXJujLtdyQh8s7iOQ/cHe+8iLBud/AK8jEgxCjJ7ngxFDAjzhr9IP3
 D/Kapw8H1nehDYvz1EHH7BSzJqI0q6Q4uQHRbGkpbtItlw30Y4oKjP7t4ubDs/rIE27XvYoLz
 DXo12Wr7aDyzVk3qp0ucKER4H0FKaY5Fc9/SnUn7Y5Cuk=

>> Thus return directly after a failed devm_kasprintf() call.
>>
>> Fixes: 724142f8c42a7 ("fpga: dfl: fme: add performance reporting suppor=
t")
>
> This basically doesn't affect runtime because perf_pmu_register() checks=
 for NULL

https://elixir.bootlin.com/linux/v6.8-rc2/source/kernel/events/core.c#L115=
27

Do you prefer the usage of the error code =E2=80=9C-ENOMEM=E2=80=9D instea=
d of =E2=80=9C-EINVAL=E2=80=9D
as an indication for a failed memory allocation?


> so no need for a Fixes tag.

Does the selection of a more appropriate error code qualify for this tag?

Regards,
Markus

