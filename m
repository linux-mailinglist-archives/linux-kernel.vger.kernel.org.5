Return-Path: <linux-kernel+bounces-53233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CF484A268
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59EFE28A579
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B439482EE;
	Mon,  5 Feb 2024 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="YnyBr7qg"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FEE481DB;
	Mon,  5 Feb 2024 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157769; cv=none; b=iTUgZzz0UjOnCPBf+oNFgu2ZWEibpnRVf/VZuDncyZIQucznc3AqjYmjmj/rtA47lLfgy/OBFCIHOzGovY9/HmJWQf/OZ4hS5M5046B18JBZQzeyHWHlKo0gb0DTXX5/TFZTHbCc9UyDv9EQ3qJC1uTfdcZqZVgHBqse0uA8OTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157769; c=relaxed/simple;
	bh=epr8z7zCKvhQ7345JjrnHGEZ1xHlE1h/r/cTKKw6iHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILMSq68dxwwK3kQUYlcdn9V/QWp/tWVPMyT86DAEXd3Lfv0ZQD2cOjnV+NqP2HbCWx74U9celEd5/ZbAzUNqmWkbQkS029k7PTt8gdcT4bxC0F2QOYWWo95TklVAEaLk13u180wAmOmJN7/fFzuEDvPGDHmKMBbgUBnimKEje7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=YnyBr7qg; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707157756; x=1707762556; i=markus.elfring@web.de;
	bh=epr8z7zCKvhQ7345JjrnHGEZ1xHlE1h/r/cTKKw6iHo=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=YnyBr7qgaXedp6EoQXv6TY2d1Jp+nKoCBByNw82zGyaBePgv/zyhr9scqk+pIwYx
	 TG9ujHbBE1fxiKl2lY8VOUptFDglJwfcjTfA84ex0/PyWz2fFb66AHH4FuOGMjHjG
	 0MCHegS00Me+o1ej+TJL7yl28SAuTGw1GbxwywuoxXkr/xV1j+2/PiwQRh8Z+COop
	 uD/FjL2mEI4IpMktUIgfBQCzvY5Lgxb09lGQEwKF+rx9ZRvbJpfXDRg00lg7u1J4e
	 Vya9rkP1puv4IFTDE4NAJiW22vqHIBMEYRzIk54Ph4HnOw8SnwKTQhEBRaOlILHhs
	 x/tqz1XaBYqTEOUvNQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7xeb-1qtvaB0ikV-014YeP; Mon, 05
 Feb 2024 19:29:16 +0100
Message-ID: <53e6862c-89dd-40ec-94ba-04a2e1a995b7@web.de>
Date: Mon, 5 Feb 2024 19:29:13 +0100
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
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <324d4e02-6a5a-4112-a3a7-d7aeb5876acc@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ujxrei2DCvKpapByIscEOekp7MQurk0SuMRM4V4Gd3xDHqsMN5r
 ZHPqCQAG+s0T3kkVFk9saf6mBQ4Km6yf3LmwaQetw9OOYtM280J1JMAEwvh9BzNTyuzno60
 jsPyoN86RxRuy6TVDpz4Oyz5aF3zUMB64kwTa7S5tyFCkUvo7CwXaH0gAcCIJfaRVyCSDLZ
 Km/HKKaEvLk5pGrwqZRyQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FetAMrHLiBc=;hGPtfzAE1B1SpfuMRTRmBFv2JQR
 wSZr3wMYf4uhjSngnW+/d6sEMo/kiTZ85HuZs0YqwYvP6jXqJJA2sqnygEGQciZktO/KjWm/J
 mn0Deh9ogH8G12Ey8TimbILro4RmwH9TXJi8q6ZSxagqqIULjJXTGF3aazJ/ECpRCpIO7wdbb
 WrezKPTMBl85uwRhOsA0r1LXjZNDX9LgJLBtQeqNUhdiIAeqbcTSpxyiH7fQ8CmsEJ8XlqPrl
 oA7qX98fzdLP9ZosTjEaudm9s1iHCSpxAkRd+L/rgyeF6d2viDZ85zJVdvu8HSB4fxMjhU65/
 BSWUQf36jPnoDx/WOqm5Kfl+eWwdKycKDa9fZiLxGc07BgIZLyl5WMH0YGrZG98jrlB+4tWX/
 UYW4uoqoTMwGyo/EqEhzV58fOEAu9d2Ca1OTGwrZumzcv2RnSl7CKrQsF2RkNWAHV9cMpaVnP
 jb1f5kRedgfqaj08vFmO2Hdb33qF51Ta+SuD/Nn6+g5iAI7FmRQ7CL5zAL5K47mEj79rMCEt7
 dNq5RVGidCE5TnBBqSyc66V0z1ADMD53+Cfa8kgrfdebJG+Q0oD8DnVpaM70ateMK67ugNkUa
 DLAfKLvuoGoNDAftFej6v4hTL3Q3X8e3Gvi3jDUWC/bt3SwBsR6ah1UsH7AKkTuqzAoMoJnzd
 B6xinuYB6Ef4PIOXyaplgkA0wsC9pb1Pt6SMrn1UEPVI9lw1zS1WOrmhD0IFpsSUqdvtU87hA
 32IL+zyocwsUYTd49Z6qoqBtZJv6JW9JNH9KYc1UrDzZhhog3uscIL5N7L843n+eS/KWfTgp2
 9lL2I4VoAHyWMuR/ULWmKLI+5r12R8YERjLxQLHi98+5g=

>> Thus reuse existing functionality instead of keeping duplicate source c=
ode.
>
> Much as I detest the get_and_ioremap_resource obfuscator, it's not even =
appropriate here since nothing else is using "res".

Another adjustment might follow for the application of the function =E2=80=
=9Cdevm_platform_ioremap_resource=E2=80=9D.
https://elixir.bootlin.com/linux/v6.8-rc3/source/drivers/base/platform.c#L=
112

Regards,
Markus

