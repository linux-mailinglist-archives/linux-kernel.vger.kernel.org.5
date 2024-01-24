Return-Path: <linux-kernel+bounces-37429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AA983AFED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8DB11C27437
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2649C86156;
	Wed, 24 Jan 2024 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Q/lh0GNJ"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408BE81AC9;
	Wed, 24 Jan 2024 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117323; cv=none; b=eVDj+UMcNwQbdRomOgC0EOunsxTFflkz986uLCdyA42cmMxDkW2mnjbZWdZl8UR3m1UfyzlleBA6Ok/iKpfAXE7iAD+XRu+QBSKMBPl27xJT0mHr3XskMMj5isifyHK/HM4YdyVCZ6gydJnuaKrXQAuriwlKEVx+nWsaiKsnRrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117323; c=relaxed/simple;
	bh=H+PqRdahESOhwBQHRpCPYTPjtB4Ee5lSleiuK+QP+sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QucVTgfOa0Ivm3PHdgFwnUhJZZRNP3JS9vziBSYv+K543PdMxFfnPIuafipDDT9c2mrsK7/aXMe+pwmUknTg4bR7M1SETlOxN+0IgthNzk1XONEJT6MLspcRBuXJzhUtE+bD2WjlNtszKUFmzkUUvpcr5mvWwbRtp3mzOYBJ2iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Q/lh0GNJ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706117291; x=1706722091; i=wahrenst@gmx.net;
	bh=H+PqRdahESOhwBQHRpCPYTPjtB4Ee5lSleiuK+QP+sc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Q/lh0GNJqpz67/AyCGWWRuiAIuFIPfPdn+8PzCtcer4OZEyLB2fzclad4rrUq/bK
	 I7qbZo62uYZ483RBU1ck6IOsleMdBvBkuOshiX73Ge0b8XZuAo0Z/ujvh/LfIbEKJ
	 6OQCOhEM/DfvyQEOZfr16+rVsI/dUWi7M4TYH1bzpfkrtPtD1/Ot1ECF5ywt+/tHV
	 +WRvJEhD4Zfa3+nI9obdNK97XJxdnHeXjcf1P2eBrHuqQmqfIZ+SbbZBz6rTU46RK
	 KFzMmkIFwQ2LHuum/Dk/4aNX+YkZeK639n4GzE2E0BR3DQ2KMUG/KlgElWwFYdMI0
	 MSQ4p8SYN6hdAUeXKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgesG-1qsXsl1Qse-00h4rE; Wed, 24
 Jan 2024 18:28:11 +0100
Message-ID: <f2fcb4d4-b1d7-4d82-a3b0-d06c0ffd906b@gmx.net>
Date: Wed, 24 Jan 2024 18:28:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: imx93: Add phyBOARD-Segin-i.MX93
 support
To: Mathieu Othacehe <othacehe@gnu.org>, Wadim Egorov <w.egorov@phytec.de>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Primoz Fiser <primoz.fiser@norik.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 upstream@lists.phytec.de
References: <20240122095306.14084-1-othacehe@gnu.org>
 <20240122095306.14084-4-othacehe@gnu.org>
 <537266fe-0bf7-4208-a9f3-ae27f462c6ed@phytec.de>
 <85fe8c8b-ea08-4f24-9a06-33a5678c1a0a@gmx.net>
 <7944bd80-32d7-4ac3-9c0a-806394262f1c@phytec.de>
 <08ef805a-b041-4db0-aaf7-51d5d06596ff@gmx.net>
 <008317aa-4dd1-4889-8c64-5e4396d83931@phytec.de>
 <47c79a0a-5be0-4ee8-87d4-fd03809a9664@gmx.net> <87o7da4zc1.fsf@gnu.org>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <87o7da4zc1.fsf@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eRZ7xQ3BPGslVgUOuVkixGadYqVW+b3sXGg9awfX0Jozyuk5lRh
 LW46X/BC6XQAdYVlzxlVbbhp3VLHxUs9tSTyhxPAWoEf3AItqOaDbDCnFa7MMo5JVQYIEFq
 HHkwTSfXElCDtNUOuLgYHk9Gddbfh6YTnkJ2JQG9V/+Qf5EVLMsX/7GymSasxQ2Cy10X6pu
 eBEn7BESEDrNPFrNDVOyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xx/BKrwc9cg=;AoM4FjyIddteEhdRtHq2gsEvkVU
 7RnglQm+WKRb/xUL946Hv/kumRulIqSS1Z5Qm8MKBQsJqhGbBG/JHKyS+MbHbfdF+skHKdjEx
 6Yf8Frj+j9uZ0fydJ61/0b9E0sEtsiex5GUYYH31FPVJ8nD5uMBtvhSJAWJ4q6OB914z4N7KH
 LOC3mcjoSQCd441KYH19CNi5cwnMeY3whh9AM62fvwP+Tdw7pGGmsYDICeZdwjcTH1R4PHaiz
 qedA9oBC3LWLGSlQ6ffcUsRvBR2HRZNG3aSCEB5Nzw7imc1fdJB7yftZPb5G0bFZfc3EFZH/o
 S6wBDCjwfZ2tp7pP2pHvEQrP+pIEIfLXyBNEldFPKRU68FhiiooiECaxxeK1KcZRZuKpa6mDw
 vz9jdQ1s+L/Xi0TK41rswdNKBq22xKgfZDLM21gX+kwR+JwQcHo2jJ3C3Hzd6P3n/5sbsaARi
 FY8+fzr3vXb6fH6yUSYLqczX8RhYx1gsifK7EMk+qRawscEstWGCjJj3QVWO4ehnX6qGiQTQs
 Cv3N1r20s9COUlw4l4u0TvBksp0Sdk5z/0j2Z0zmnKLjdVDiPY55VF6N8X3/vV3LqBzcaLgjJ
 lXi5BUogpDOtwN5PeTnimuD9x1jh2ognE23jxOfGpr8qENGJ+OL7o3swCSpiQCiJeUoyREqtc
 AYXqihAgZMOMxI64WGKKSWow1NpoIDB+I90wc6S///MIAiHpyA3ptZM/+0HeRMAu8brfAFjN+
 ltAuLoUZE7xCwzpKhFAQnrjE1si5k0yEqWjp/ymH3ddWdMGYU/ohH2MgXwec2SijpBX3Xv+HB
 ztG0i9aSLdfCHqpCq3/7JdyfI79VaJHrWBcgxQvbIEsIpRCzpYuU719m4SuK4T3cvxEROymzC
 wS+rmHbIPkvVfPZ07VNUfQ7M3P4cP+i4j2mCB5JOlYYDy+LvGUKRWrDyyX5DA6kA189OCXESE
 MN2a2YFhf1jakJvtCTiCUEGyVw8=

Hello Mathieu,

Am 24.01.24 um 14:48 schrieb Mathieu Othacehe:
> Hello Stefan,
>
>>> Defining line names should be fine. But I would still prefer to have
>>> the muxing in an overlay bound to a specific use case.
>> I'm fine with this. Unfortunately Mathieu dropped the line names in V5
>> today :-(
>>
>> AFAIR reviewers should have 2 weeks time maximum. This was just 2 days.
> I am sorry but it is not easy for me to deal with contradictory input. I
> chose to remove the gpio-line-names even though it also seemed like a
> nice addition to me. The idea was to not interfere with Phytec plans in
> the future.
tbh sending v5 before the discussion between Wadim and me was finished
made it more complicated. Please keep in mind that some reviewers do
this in their spare time, so a response could take some time.

In this particular case Wadim and me agreed on a solution, so no action
from your side was necessary except a little bit patience.

The reason why i suggested the gpio-line-names in the first place is
that users doesn't need to care about different versions of the DT files
(except the downstream one). Changing the line names afterwards leads to
confusion.

So before we discuss on a v6, just a question: are on the X16 connector
just 2 pins muxable as GPIO? This is hard to believe.

Best regards
> There is no hurry and I can always restore them in a v6.
>
> Let me know what you think,
>
> Thanks,
>
> Mathieu
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


