Return-Path: <linux-kernel+bounces-22191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B39829AA9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8F01C2147C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F066048782;
	Wed, 10 Jan 2024 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qJePEBBM"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75A6482C5;
	Wed, 10 Jan 2024 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704891155; x=1705495955; i=markus.elfring@web.de;
	bh=z/lBwRWBNcQYTImVtZA+5BhEFyRCnsNgZwbeW9VNd3I=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=qJePEBBMfk3OLRY02rwrXtVGxNVknjMOeTm1SpPSmPPAxcCxQUyKB32OqQXI418C
	 fpa/6WIb0IChCiliG7tnnVHUfq8kWcq7CBO6UnE/bfOvnEY9Ue7t9dbqt4qd3uRh7
	 1VMUcGuItboxy1VNr/RyEgACwkK22rfzqTKXx6WUfOGs0CTY5GmklfSDFBaFuxxTA
	 NDVuAq+lIqy7fNujaRGf+qPRJihR4qqI/oCgJ4bz+kpH2zycEJCrODS566YiaA66E
	 6kgw/O98ldMZdYjAbQVTM5XAWHdMbJ0nVUhohrsZgliRSGlChpgW6+A7wFCY6vZlY
	 CgmY7ZnxfqzmrvtiHQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7usy-1rIZzF2aVG-005Tl7; Wed, 10
 Jan 2024 13:52:35 +0100
Message-ID: <09c4cb2e-967b-4d0e-b5c6-f959e80290d9@web.de>
Date: Wed, 10 Jan 2024 13:52:34 +0100
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
 <1c38e495-5c9c-4ff8-b453-93b882dd2c4c@web.de>
 <ZZ6R6KSQo9ph3ARZ@shell.armlinux.org.uk>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZZ6R6KSQo9ph3ARZ@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dVPKRYI/UEIH4hpwOzF6NFT7pctrhluHhlbEnIDqNss/Of0suzs
 TvAZMy8INtCv1rIGLCRa+0+mEf7BkuILXAbtD8/6npUhImkfxlXNoB9PZqWAKmNKP0DXy4E
 STeXZ5fKZUOhHcIaZvLn+Xj/yq4ODhOSnI5ERSVUG79CmcVF6ynro5R6zHIaWJULGyTFGVd
 4cut+GmQA+l+7G40fy8Gg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/pQKDMW6cEU=;DvrOxllCli9naHa/NHd1YV+DYb+
 N0UleONu7EheaCF3AvxhEf7UhujzMLxMmx55wopKZb0EyEcuounzIfhLbSCymfiDj3wjrJFk5
 CdePYXFN7YLopADQVaTEirLo3VkayCaoB735OeJDQrOZvuYxzu3oqKUMffMk3WRYTCNO7tbhM
 1DxAuBUBBUCzDkwJhlWmqsx1WIzH5OZ6zH/+tX6e9YqlWkLtJyuM5BgEc8yIHcSxN8FuEBp4i
 ZaDAJlzRv3zHEfEgS6KsckzxzCgDqwxeI7FZTDlBkcskIhYn6lyR9jGDYDYCdSpUcXL7BHKna
 flUuZXDlBYyRcDqErnggWTsWI28O6stiXktwYh4RCYudFE3BGx2vzY8V88dtZ3G76WAWMGqvE
 EanikHOvefUcoxhuQfbixdWvlHNv0weYjHhogPexZlKUA4qvNPDVqp3ShdhNzD604GECfcdf3
 Yq1li1Vzbv5pc6rXe+AHZLblpsN4ADnzJ/bMSJOXn5ZO+ArE8+34v9zZJxlRODt91NLAflL12
 2JVj+KJlmqe5S1Is31aevbwKQQSI2nLTDTQ7TggWS/l1zwgbGGRhf6cxCqSfAjB1YcqRGpuaq
 SAoCO1yZm1SWM3UEIajo4W52skC357cmt16sqEdfWxLdhgiRgZWtPufAb8eSuiJqPf1Eu7lZ5
 82eUhxfhaK2Bem0XFp8eJYhaAMJ4QIISeRzTY5avxt7gUh1LG6nALurUq2wrWACGXVKiCNCVx
 MKwZAIdKot9qEDA0Cq9Uo9q34EtsUmXCETWljogqctPJQRzQcYLNFz/Kt97ivoch49G017RD9
 ml/DgId9pWabcnBtURrwUy/6Bv4u+99wu8HG5RTfMhxzDrnTf7Cn+yjc1KgMZRIOCsFlLPpna
 ZAEYGiCNl4QfF7UBrrZ1HYm+PnfBHbXpHQFi4/4AXpiIogkeFDPAR8M4GdzRmfWxH8/sdeS0A
 iThRQg==

>>>>> Is this patch series still in review queues?
>>>>
>>>> See also:
>>>> https://lore.kernel.org/cocci/562a6f99-3f8e-9a77-e519-b668e24dced2@we=
b.de/
>>>> https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00098.html
>>>
>>> I suspect no one looked at it, sorry.
>>
>> Special mailing list settings probably influenced this situation.

Did any communication filters hinder the clarification of further developm=
ent ideas?


>>>                                       I don't catch everything that is
>>> on the mailing list. Looks fine to me but it needs to end up in the
>>> patch system to be applied.
>>
>> Can you collaborate also with mentioned mailing list archive interfaces=
?
>
> Err what? Sorry, I don't understand your comment.

Are you going to pick any patches up from linked information sources?

Regards,
Markus

