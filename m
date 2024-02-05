Return-Path: <linux-kernel+bounces-52524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B70849941
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96831281359
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EE21946C;
	Mon,  5 Feb 2024 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="siqK75NV"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFC21B7E4;
	Mon,  5 Feb 2024 11:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134024; cv=none; b=BtOIUF4yi3udh1K8uLrP7j8IztpXeL4O41M44ztrluUJJ/wCqZaWiDyUHtf/cHLYRHKmnvroLgLh2F2QS+7pTdxDHy/VnmA9V5lt4rVk649kZXmXKvbmmQvLWswY6fx+VfqEqjdze+SDfOeEdoSENKoViXl+4qMfB/ZhEUk4AkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134024; c=relaxed/simple;
	bh=mZgak3wd7sP/8YP0PUhMwClPhbg0YKX/cOYKWUE+Bq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGn5WzOD4q1neg+QFOJk4fcGyaWHXse9vBXVVmU01z+t/Y1DwiOXwel5erSDvTyqyN38LnWBT6im4f2sE9AdKJ+P3YwEhlwn6LfZ4FT3FefLNOaqAigvjNpBaFDBM1Ag+Jxvk+pSXNzgldibYjN5brAXfMS4x4gyl80gMpOvZe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=siqK75NV; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707133999; x=1707738799; i=markus.elfring@web.de;
	bh=mZgak3wd7sP/8YP0PUhMwClPhbg0YKX/cOYKWUE+Bq0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=siqK75NVVacoNo9yPVF8GnsraFLx/dbc4H4kAlsCj/m/IyfxJOXzegY3npA+YDzH
	 9c3O6KCKdyk07svNfJUbjU5ARHD5zwJUDMQlwT4zIQra/2ybpj+Ln27C7jUGyXKFE
	 cWEXPhQoTuMVZbnWyxY/txucnG+pmzFoxrpc1K0tEARG7dJFsci3LPrambXRktWLL
	 22gdxHRcc+hS33NanawtvHEYA7cB7kYMS7dcNk5Pw3L97fOT7r1ZcajZEt0qccMcc
	 l/QQs7X7To3huXELl8iCOSj3flzYnZRWMj+yo4CjKsWFROnharXcYSw45+QIolzu8
	 L6aULQTQrDKu/Sz4JA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1My6lX-1qoUOP3r0Z-00zZsa; Mon, 05
 Feb 2024 12:53:18 +0100
Message-ID: <49fc6a59-2c07-4366-b32f-0599c2418916@web.de>
Date: Mon, 5 Feb 2024 12:52:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iommu/ipmmu-vmsa: Use devm_platform_get_and_ioremap_resource() in
 ipmmu_probe()
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 kernel-janitors@vger.kernel.org, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <e01cdb99-8497-4fec-b423-a0bfb483ac75@web.de>
 <324d4e02-6a5a-4112-a3a7-d7aeb5876acc@arm.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <324d4e02-6a5a-4112-a3a7-d7aeb5876acc@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+826gXMyLcStg3Xy/PzCqSu6s3UWOFdtPyMNHhZPcTyAcapjuwc
 hY2bkVLsGjiA45FLXmNuKyQhl3KxJeizwFMw8ZZKb8x/OlgRTI3ady07tT8N2d68XozXEoY
 lUgGr0kBYXOPJlpHgIXobTVC04TJRVRPgzEg/dNBKTrRzR9YmQoka6IJ08ne1koDwZ7H+52
 Vi0+T7POPR5LTfklD+q8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PPzBUwye1A4=;yZje3G6p8eaUY9thc/9Y8vZXB31
 vmpZ815y67a0ftY9N8F39Pid+ttPfQXWICaCnm7/f6LrGxbh1Fo7CM/bCNpkq2ml7KyPsvKWv
 hwp62fK+FEmdGWmoAw1xQ6n4Albd1f8O320e19jYNLBrPzRPJimBPLU6i3XWtHodnsFas9WuE
 bhWmYS14GT/yiioM5/76+yzxPnaFVZi8ezvZBbpSTHLEly3J7Af3GAaATThZXF89NYyZlGhlL
 fja3XHGqvO76kqX7k2BGuG+6zjcoubPg6lpnKJHZEVdmzzsyNUF7VJXXsda4fkTWlMAF4W6yY
 Kkv3dSEDQNZ25poFldyfmvmOuXcYTL0WQN1hnwlu+6+Bt6b/mgqJskromvcZ1BkuY9DR1gNQM
 JNU5ho6HeA+vYDi18HrPHfWJCe22zQoW2XhTN8oXU5JxA8I6YMsm4qXr7XZk7yVU30R++wYqt
 AhjEWw4QdMTSDUNXRUMA8tKtp59RN+SplrdJLTnlyfzYcRjps7BUI4D9Wl+5ANkzkeXZzWf1+
 a9SxeUKza99awL6LDpC7XWVGf/P6t597i3xolPz9VbU3hhVr/4dTd7nAx3/Fw8s3M9ZZG9Jfk
 zkgm4KLGIFSN/cEfLh8sZ8Llnp9FAUyLHzPoZt4Up7YT0UZoqjPoigj/aywmWMNvawHiwQ7t7
 Zu8epuMjD2hILWBh2Ir6sFvVwEdqg444+H2ZaNpVHNnW5/OxGhLYMz5lQEplX9Q7vlyTTddTo
 2NzmLB0E+nwVVzPU405z3Z9usNgE2wv6jOHUp5n7iDuysZdPNmmJxgedstIorf3GLVPQvoLNh
 eU9DJhYSDgztxPHQYwU934c2nN3BTXvn5HDjiKZexDy9w=

>> Thus reuse existing functionality instead of keeping duplicate source c=
ode.
>
> Much as I detest the get_and_ioremap_resource obfuscator, it's not even =
appropriate here since nothing else is using "res".

I got the impression that this local variable is needed to perform
a desired function call.

Regards,
Markus

