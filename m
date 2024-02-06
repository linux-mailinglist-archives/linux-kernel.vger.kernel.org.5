Return-Path: <linux-kernel+bounces-54378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7734E84AE7B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C901285C0C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD7812880D;
	Tue,  6 Feb 2024 06:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iuBBtHdq"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACDB2E3F0;
	Tue,  6 Feb 2024 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707202143; cv=none; b=aD45PlDi+vcMlYkq53kpjcGrhIUaA5CHGn+f9U4Ed67pJzi5CGwAqsScSIhgjdxUPF4PeFlVWPKerOOWmajQ6eaL/UvZ9H9pqUk2TOhJXDxGZCXfIdppJNPaFTJcxGfjqdf+XA8+vcdYQI28lC6T1HAIIlanu9DwgedYbZcO7PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707202143; c=relaxed/simple;
	bh=2lFZZPCNVNZhzbCa5T+MjLLbKaAPsyPoqZFZFvC6rVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfA6hF4OGywNCVICZ45jCHnrAzgsqzlx91b7MzXl9LJMzebvPWLiK5m1cP3eetTxCLM3kmyEb6IXRmc++zioDSoHj1HL/Zcucu0oWIFyuplOTJbdondKesQRyVvuidInVz3PFwoJQLZStV6KE56WCNx5Q8EnzCMHXO8p6qupk1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=iuBBtHdq; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707202098; x=1707806898; i=markus.elfring@web.de;
	bh=2lFZZPCNVNZhzbCa5T+MjLLbKaAPsyPoqZFZFvC6rVk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=iuBBtHdqFjB2sYjgipc1iMpbV22LTAxj/3DgvdYl3uIEJWFxCcYew29Q7bHs/CmC
	 ebgQQuQha25yh96Yogx11P2ij3Lb8McRD5dIRQK4ItDbAoGjFpa5WbPJI7DjPOg/1
	 kNsm3eQarO7JkVjzZhvyA8wI9wFgESt0Y8aKqRGy/YVzRcEeLNPcZOMHqrKyWBjG0
	 0YCkVCT6WtbbqkCazeJ/riTNzaUgSMQi4RYqLGQ+aWDjNToJfE6xtTzMlQxxmYBnu
	 P6WYaRX6iRu84ODQ39o85UpHHDJ7DQabUN3opJP5eR3MpnSWzy9pzxQz2D7fCtjrT
	 FLR68XxRgSCaWbQIpQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N30ZN-1qs6gh0KuD-013NaD; Tue, 06
 Feb 2024 07:48:18 +0100
Message-ID: <8ffda85d-8fc4-4329-ac7c-1afa6c1eaa2e@web.de>
Date: Tue, 6 Feb 2024 07:48:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: mediatek: Use
 devm_platform_get_and_ioremap_resource() in init_scp()
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <da6af483-5ee9-45cd-922e-d9d5364674dc@web.de>
 <CAMuHMdUxn4Ne7kmEfONz8Uk3Why3m9r83GdM5RzTxm_4Gj_a6g@mail.gmail.com>
 <8f011126-c95a-4c71-8bc9-a6b0a5823c96@web.de>
 <CAMuHMdUQLWBQemtgnCHj64wCYAET8J2-MgbisyMChSbh0k0L7w@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAMuHMdUQLWBQemtgnCHj64wCYAET8J2-MgbisyMChSbh0k0L7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o/3aMV1nQUNLqPKmjne/+7bI2APDOaggdys0QHaQrW0+OKONMkj
 sbqB6ZmxIPsUzqviRRKqYrOo3CpGDTOwnTZMY0Y6r9FAOqGGz3hMJjedOanCNM0Gn6TS2u0
 sCfXkd+jN4WNZByF3kKzfTjMGNjfMfaMHrF9rAnF/Ys0KvHM42yTwzsTcgGerrfjFN6MqDZ
 PqQMjLlgpR61ZYKxM66tg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7MxG6CeOe7w=;413LJvkTnNOJdKCs/lCykWnD2Kt
 BQT/UvQT71F5jO2KIRqATDo8w4RUIuLmDApmmtav+YMa3Ji20AeE3JMk1vJlau7eLC0kowAV4
 /8IRhk0BKXY+UmudkMp4AkAXEcO/sOCnsVJAHPlScYHgQA4fqMGlo5kKsm98BPLy8Zi+z3E00
 fFF2noJrZssdxBxxo54CTmSZ5NFukL5H1t48QwpFoYrAlfNAiiiisHPo1LwzUu4a5S73U++VC
 e3Tmv1VpghL2FEvxf5cy30cOzdTGIsHGWfieiBRd7HtnVyBEDn4F13kMK+G3SezR4vJv2X+rH
 DjhitoPaQkHncYR7tjral7yvnnVEdVyMuj7PIO19TpzsVcObV1aZg3ATqCuiup3aRzl/KxCM5
 RP8OAxbdLX3kRshzRs+D5RccfWOxbkrZUyqlHbs7cr2yDbjktuR5q8q3meiBLKOL3KsHGaaDM
 eGgo77a/UhN0Bwt2r3zcFwCIS8GVWKqUXx+ycJggwZN5uv51p9grMQpc4bTSNW6bEMjI6eH9o
 az2EmGRbt6Znsj2thyYziC7egRaYLBFKoRUKPvTHG8k+upFJUmvWWYs/87gXc34NzjfppYgV5
 NUJ5XG80ztfLvV4bP5qimen441rNJVSHLA7T06isu0DDd0KBJD6ytPxvJXDsx67STTDaT7XXL
 0Jx5yG3N+4c8S8k/dHBwq6KxZe8ObazKVBbLHnrfFzhpyxauE/O/OxA2Rzle5Yia+MCwTrK6Z
 1Z6tA9n4I5VcHcdWuBfuSveB8XqnHNiQSM4ovo1q1aO8lN6Bmzbx9erfx8Y2TVO0m3dWmAt/V
 HTjHOgUjvW1hi6+VUAz7ANL9DJdVtKEgZGsdeKIU7indI=

=E2=80=A6
>> I got another idea after looking at the implementation of the function
>> =E2=80=9Cdevm_platform_get_and_ioremap_resource=E2=80=9D once more.
>> https://elixir.bootlin.com/linux/v6.8-rc3/source/drivers/base/platform.=
c#L87
=E2=80=A6
> Yes, you can pass a NULL pointer as the last parameter.

Would you like to support any approaches which can make interface descript=
ions clearer
for such an implementation detail?


> And as this is very common, the wrapper devm_platform_ioremap_resource()=
 exists.

I find further collateral evolution interesting for the involved parameter=
 reduction.

Regards,
Markus

