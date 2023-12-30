Return-Path: <linux-kernel+bounces-13347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5768203DC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 08:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D929E1F21537
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 07:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879434404;
	Sat, 30 Dec 2023 07:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XjP1iojg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D85823BB;
	Sat, 30 Dec 2023 07:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703919874; x=1704524674; i=markus.elfring@web.de;
	bh=zCHgF8mqJGlh0F14PrBAaelXu0eznOwtpnIZ2X+LMaA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=XjP1iojg5NqwgGosbEveIyKe69DQWoHVYrGemxAkxv1A+k7lwceGlW57TKY8nxYI
	 +sDij5t4N9fGAM3tVWI8VbuJj+51lgP8hJGeuB+xwqtl2n9YAPV/551ijC/wxOCHl
	 RHrOauhEbuyVIpnnjoA4x7Ob8uY60lpiafajJARIqtRkbzRlMAAMBr0yacC0bHpY+
	 bqEGW2i/JoPIXZeV63W/fGCUieAjTUxvuzyc/BIVh/2obYCohrlvlCn6I89HW7mbv
	 0FvVXeXCB7qpm6VrEe38SYtdUIORnn7jMG1E/Hn/nK8ZpIttpy03kk6jofgXEavrb
	 j0f+ZVMhPtdtZv27FQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mm9Zi-1qsyLh4C6S-00iMiE; Sat, 30
 Dec 2023 08:04:34 +0100
Message-ID: <b65afa15-41e6-4d71-87bd-39fd688fa551@web.de>
Date: Sat, 30 Dec 2023 08:04:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: scsi: ses: Move a label in ses_enclosure_data_process()
Content-Language: en-GB
To: James Bottomley <jejb@linux.ibm.com>, linux-scsi@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <4616e325-e313-4078-9788-dd1e6e51b9e0@web.de>
 <9d24844f30604f969ac10da456801f594ce72f2d.camel@linux.ibm.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9d24844f30604f969ac10da456801f594ce72f2d.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ssePVKLr7X7YYW7M4vbgxXgx3i6L8c4Izh4MH9ObKOra4G/gfsA
 e44rrbzrGRS/L+C7MupMsG4jh40JTh7C7Yk+E9TuPMKOWiCmGQGkaxMBC+UFyP476QTP/NP
 RzWit4rhxBITKzGaFXLj8/s34JprLuTh0M9GwuBLPzusH8Yv3UGx5oV5mqg9MpF2+PwSgg2
 XvrJqP3LMaTtswhxKotdw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2lzua34+dEI=;+BaW9nVmUeud/3myjYL60Ga3r6X
 m44U5lz6s4yrB6gpa/29gx0gVDOKSOqFFOv76Ede9c1jRHK/7E4LIyywcPElm36HaVVDUwW9s
 7viaT0n6tISZeOw7MIwh8WdRUk6vfUsRx586er2gVByBmg3xE8bDqxDejxS1t3NEXmcQ8TzlO
 5l/l42JdtBrV0xF9hQuzzgojOXf2gsMeHyUiGb0e0Ngmp6Ha8LTnJDw8Jo0iZa7V+YNCstFVh
 kPEY9trR/+2BwRhQqi651NCifrScKgwU7n+rEAtTZyb+MXZER1n0zbYZKQFqmODEXs9nISLOE
 wbwRYlN1Y4Nl3CS7yM7V0c1CFxJwSNLmZtS4boVbsnfRopQvbSCPAlZ8qexsaPAP8vXy1wHEx
 NqnJqacSA7hOxB0+K6WfG1STIqKAy4ncTacCFKU7bEk3ZKdatLPC24W9sfSk5jRF1+7x/X9Py
 yR0zPzUo7DXq6Eiypj2c8XI5AB9SxY+I7q/zz58Q4P2oqcCnEUAIlzri16eX5A5Oi1gFh4W+B
 k4DQnvs1x7EzCfJgHvjpfLRpoeWZEj3/OuSoJvVTsa8Oq+M2AqJAUaRlWPm5/kTMIdrKQyH0U
 LVYuuVInC3BfcRU9iSMrGSP2b15Yh5KJsNTprR8NfqRCv5rOgUhzjzZVOqIgVuz7vV44joDGe
 ZrmjrYCg9/LtB1gWM5ZOR6cqYMRw/XkOoD+Oy4impAzsxVfy1IRMS0qRJtvbU5sJuZi+3bGlC
 Nlw4060n90jH9djd/aKdEWySPdFVbQn3mnVPRzUdXt1seUW5G+IrkejG1eifV6W17tnxnZFAP
 Vgj/70gUYWDeovsOJqfbKM6otmFV84pNailzlU6bPy1YCpOaL1spxaitTVkqeF2USXUZNirk6
 cWXRLYbFNVjJMRdIA6wNdIU9yWkJ5pyIbli1YoOkJDE/HLGI2bFqQTqQfFTHB8JA7bOeegQYW
 71CPDg==

>> The kfree() function was called in up to three cases by
>> the ses_enclosure_data_process() function during error handling
>> even if the passed variable contained a null pointer.
>> This issue was detected by using the Coccinelle software.
>
> Why is this an issue?  The whole point of having kfree(NULL) be a nop

Such =E2=80=9Ca nop=E2=80=9D can trigger the allocation of extra data proc=
essing resources,
can't it?


> is so we don't have to special case the free path.

A bit more development attention can hopefully connect the mentioned label
with a more appropriate jump target directly.


>                                                     The reason we do
> that is because multiple special case paths through code leads to more
> complex control flows and more potential bugs.

You probably know some advices from another information source.

https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+go=
to+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es


>                                                 If coccinelle suddenly
> thinks this is a problem, it's coccinelle that needs fixing.

This software tool can help to point source code places out for further co=
nsiderations.
The search patterns are evolving accordingly.

Regards,
Markus

