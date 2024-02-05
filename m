Return-Path: <linux-kernel+bounces-52678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF93D849B55
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6C51C2082F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512A8210FF;
	Mon,  5 Feb 2024 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="gInmokFX"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C9F2375D;
	Mon,  5 Feb 2024 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138167; cv=none; b=SieThCByQLu3KxzqkMg7bV1XJt4UGV0lW7kkwcYrp0EOlpafTr2fmwbkBWSzTJF38+8uJnC8/S5tL9JOVZ1BMykfXvQCVQD0LdQ8GeYmmivAAYG9chpz5+kqgsynVKRNLYPF+5LfwgXZS0HOf7I/60JJd3um+1Z4vSFJNXvGrok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138167; c=relaxed/simple;
	bh=M7kC1Gk7zW5Rzv1t84FKmyEQZQWveaLF7BWFYaTRwo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7SfLJ3M6+t0EAXpCKofnNetnfC+lXW0Flq3B73tPUUvht1BzU9KFY4oc5jzEUndI/qMDszxNu0bUPlzhpsenrMSqmEIAtSxtK/j2qsClYc5Pt9mxPiD8jop8zY4i+7tjjpqUaqY6V7PuikPpQRLFDlx2txZqzyqh/XDi4GfKrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=gInmokFX; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707138155; x=1707742955; i=markus.elfring@web.de;
	bh=M7kC1Gk7zW5Rzv1t84FKmyEQZQWveaLF7BWFYaTRwo8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=gInmokFXD88OG+TQVq9DRGXn7Uytl5F1dxzbh7DYKEfCVm6ufvmFd9MObR349q2E
	 W7wPDJoPaokW6lwnmQUfgRecr59+ioYqi7QJq+m4DaWUQ9iBQiV+kL02lQOJQh0fI
	 3JNPJPhHaGNt/n4c9DtcvkU3jMnpesA2LCD1genyOpk8gYV4gp2l4MOEXgY4siNB4
	 3PSpYYdGsHJ8UpjnNsI8kpSo1hmo7Ntq10OmBx7d1VK7JxiOLS4Wnnp3fi/H/NNm1
	 yqU/HBYuhWpRJPHjpxx9VxPi6347eyPFtOEo8wnK03WtYon8WkzTdCX7LiF5Ga5Ym
	 OxTXH5+UbagcjQSO2g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCGSU-1rgMXJ2Y6s-009fM2; Mon, 05
 Feb 2024 14:02:35 +0100
Message-ID: <0c757d69-ec60-477c-a978-a94118a571a2@web.de>
Date: Mon, 5 Feb 2024 14:02:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iommu/ipmmu-vmsa: Use devm_platform_get_and_ioremap_resource() in
 ipmmu_probe()
Content-Language: en-GB
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 kernel-janitors@vger.kernel.org, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <e01cdb99-8497-4fec-b423-a0bfb483ac75@web.de>
 <324d4e02-6a5a-4112-a3a7-d7aeb5876acc@arm.com>
 <49fc6a59-2c07-4366-b32f-0599c2418916@web.de>
 <51315925-21ac-427c-abea-4d652ed5280f@arm.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <51315925-21ac-427c-abea-4d652ed5280f@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q0Qe30SNi/9mqfN3u/mG03dVuA8Cg6vcFggSYnH0fpTJrb5x0RK
 uN+E+ui+VphNCypZhvXPO8v0SZCqSi7nqW48GoU0giwxlyrdihct5RxLgjCHVWanuJCV9hr
 /pwdaUAS3Cd8wn5Ozt5KAqTChfDDEy+054BcGJlC2Guboml9nd9TemoEXYPxzXNX3hrD6yZ
 cLvDd5bbTQ1SzSEjmYn8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:G9WiypKrGiA=;uV7MKkwX+3MbtwDIw4sYVlU1Zwl
 b+/PB1TmIceiC2kiIRRY4NJgkuV+/t0iqNqZoAVcAZe7ReuXQVC60YuPjDD0gQU3KyBqK3hOW
 ZAD1GzFNOI9JSSFQ4BAhgvZ12N3zXijCJh6UyPvvQyCHUM5BXDRzRr79lrrCxDiLhH393QXUW
 /QPbjcWKo1sCh8cUoIWjlFz3pFOTg21VCMIDgP/7fhfb0+h0FTjriIMq2IKS3rKEGvtu/kF83
 bqm4jmuXoHCR+PCtGxW+HW4hg4iePM7mH+deDznnXIcbY/OYjfoX1D0myXDN6plJvl/kp0dVC
 7jqyGmP8EbvgSe0a6Eq4q3DWd5Fyske9Cm8BvVhLt4HulQupB9z7r07CDntS7zDtyQ840D9NI
 VsKOV5Dy9G+ATbv9K7mudMmbNv3qJFMtVChl2a6Uu9l4gbmJQD45M022N5Me6FNyNdI5iAyxX
 zBda4TLAxQAeGTUeRSMWwsBNZYS4D92azj+ERSkpNFeEz0Nd+etkl1druyeLDsJioESmnuweO
 5Svv2AgnloFfa4TUeW1sIk/ayMVldb079xnPIZAz02qm4dn/Oy5Jsqd8bWP6N/nfXZAZoPiRR
 CAv/eQAHdqna+BItLaLEDQm7aAcG/AF96diMzh2yZMGq2b/G/nBvNSTlV6vn0sMo0Uiu5UzNR
 JLe8zwZeQRkyFejwQe6avLfy49AQa3sCTdLm27qdeeZo2OcuLVTmQrxuf667kqW/NCJgetFeZ
 5DB67PJoCcnIzgjERoryxA7E3SY353d637QLYfacCCarbqItV96a70ikX7LhGtgvZbGWLB8Zd
 VK5lG6OqzIyCL83/HTdrWbo7UMevQoQx2TCips5aG23kc=

>>>> Thus reuse existing functionality instead of keeping duplicate source=
 code.
>>>
>>> Much as I detest the get_and_ioremap_resource obfuscator, it's not eve=
n appropriate here since nothing else is using "res".
>>
>> I got the impression that this local variable is needed to perform
>> a desired function call.
>
> Yes, the call to devm_ioremap_resource(). Which you're proposing to remo=
ve...

I propose to replace a specific function call combination
by an other single call for a known wrapper function.
The mentioned variable is preserved for this purpose.

Regards,
Markus

