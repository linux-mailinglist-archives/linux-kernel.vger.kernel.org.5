Return-Path: <linux-kernel+bounces-32611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBDB835DED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454682884C5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80F339AC0;
	Mon, 22 Jan 2024 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="OcGyh8ih"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC8139AC3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915032; cv=none; b=aZtPxEnJrlBmPEkxNrD1OyTySneDOok9J4yzHRIxG1RL9eO18ZXVXsPYlfL8fLZSEizPX7H+non2tvu5IOlcQc1JWc6F6o2zAe92qER62oNtpS2EoqzfzWJ2HjZTBBP2FE2fIX2DBSN/cQRqN+JjJpNkFIsOLU0WPxfT9ybRgyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915032; c=relaxed/simple;
	bh=mtduuqe5/RkHoDCDNXg5CIs7GgpBB82qessFrFtHGRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0a+lcXDWR6yET6AWfROSINgpN1xRpXjNI09Vb1X9uqNed0ezYiW5iEZWAysQZUAZnwX9ot7T4U1K2aSBStB3t2duHQJqwHMWU0UQvJRR2DCiXXJ1yO2tsU4joSd/QbWDAh6lw3G3rP/0c3S+WYFdNRumnx9RpaTOm5vBfRcuN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=OcGyh8ih; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705915024; x=1706519824; i=markus.elfring@web.de;
	bh=mtduuqe5/RkHoDCDNXg5CIs7GgpBB82qessFrFtHGRE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=OcGyh8ihnBJ7xBdweAtrMrBhltHejXE1NMEbhNmn0EgSlbZdzWIe5feCMBLpYz04
	 afKRQvKaXBgjq63Olm8wXbBUvJnd1HgPGDV6GEN5xE7EA0ujJmefjlWlBmlpOfKWJ
	 +QaACQUcalUHTNw3Vnymr7Ch2102Xi7KOvj5D+2Brc7N46DvtmbLHwxuOC/V+S6j4
	 9VBIC5M7ro+H1yMsMM0QR7ZGHw304+/9uYf/S7baFPAKWF/0Trt1Jrz4ReNZvGko+
	 msDneRJQuKu1RnYsDrM2EXvkMLJ1UluyMCpQR/mQzR6TcxOYtxMqokemKIjNsbAzZ
	 dyh4/Yxkh+/g9UgEyg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1u6n-1qzhdZ2UhN-012Iu6; Mon, 22
 Jan 2024 10:17:04 +0100
Message-ID: <a9dcafd6-07c3-4bff-9203-ce1f9f114b75@web.de>
Date: Mon, 22 Jan 2024 10:16:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [v2] coccinelle: device_attr_show: Adapt to the latest
 Documentation/filesystems/sysfs.rst
To: Julia Lawall <julia.lawall@inria.fr>, Li Zhijian <lizhijian@fujitsu.com>,
 cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>
References: <20240119062057.4026888-1-lizhijian@fujitsu.com>
 <alpine.DEB.2.22.394.2401202217550.3267@hadrien>
 <f34231dc-186b-4cb9-889b-b3be9224c5a9@web.de>
 <alpine.DEB.2.22.394.2401211159350.3743@hadrien>
 <161c3be1-011c-4ffd-8646-1b95f1a461eb@web.de>
 <alpine.DEB.2.22.394.2401211220480.3743@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2401211220480.3743@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wVJhxdUSwmU5DKJWNtg0qUNfPYJKuqsTX/0gCW0acueX+/ppdcv
 Wx0Rtg69phOAOjypmM0hyuUcApBj2idDM4ffSaXwWosbW0EyESpVPD1FYG9A5M7lt3RJEhL
 7mYvovfIOva8qCwUP9UXjgo6h675gApggYA3C8FXMOJo9FFrTFBj+qDG2wWqy3qGv4bsa1i
 iniDevwdPi2E2irlp2PVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TalHp1KW6BM=;aViEpTEmyLlfBptGi/00su5EYsw
 huGHvpaFA37IeBIBonlz8BDCRBq9UXRPOVH3GkFcDTsshWhPhZUzCmDMiFkL7jOqSn0XowByS
 7VdLDprefbwPDJEQwXXj7kN7kVfvcRUV91S6EW8dMX7XdV1szRKrOYCVsq3pgNH/BZCN08w4p
 7wTLuFnL/LgczFTm32zHJqgI0xC6wKZ8Fh81kvvh/uYFbzBVxFHIRytBiLJm8Spt5/Z4NlVJd
 TXkl1ckpZnNA/babNZf9HZhJ1soKZVQyUgzaTZ0r6cOxguyzPXW3R0ckyGgqCEwnRGkwFAa78
 8LiQHULR8QCnV8kDXz015Pg52R7Mq1qQiB+SziQDs7Sd7040D5CChExHPn0kGTax2n91naEVe
 eKKupjkXFsAVsQegcLpDo0P5jphOyKTFTbEsUWLlHh3enA/GQzucYAp+DblsbT/QoY0EXivv4
 S6XqGtXZwSNH1QPwphbB8B4HvvXUJKFuuTk9XKUo2IgHdjC/KAecoSS56YzpUUJvKy63OWy7V
 j6kZd53E2dwiXkQG9Jkq9+9VlVUJcwp36vJCvsFfxc9KYLsDl2Jn+awqFDLiyWfQOEQJB9+BP
 nkxKNJKYPqg3XtZQ+L70pQQVQYWrdTvClVpZiRD6Tch7cbruAXqGoEkAUfFKmeLLEFj2mhr0Q
 IgRkQI1v7bH+RRmWCcGD06hcQSU7dsr6x6wL7LWSOH+Gdgs/r5S5pNSRgcvoXD6NIHstVU4F9
 s9twKtIjXO6w2Ke4qA906kbPpmHzqHkWun71GQdAtx1wVCPuOA5MWZtu+4bXt9bRIvswcXo0b
 MhNmKWGKUScHeQjXdUWneC+UOjIhw9kZguDYLkZxi3wpL7dguCidac8zZzl1I7oAazRWwu9pL
 zS1PEtjZz5L5KOJAXtjMmcJNQZutUSZoRrhBMLgptTlNjLuygr8c+Ca4eTxTo5bwPH5jjjKnm
 dubvhQ==

>>> It's ok too.
>>
>> Are you going to integrate such a transformation approach?
>
> No.  I already pushed the commit for Linux v6.8,

I suggest to reconsider such a view together with the metavariable =E2=80=
=9CSTR=E2=80=9D
which became obsolete in the discussed SmPL script.


> and I don't think the change has any practical impact.

Can you ever get into the mood to increase the granularity of
a source code change specification a bit more?

Regards,
Markus

