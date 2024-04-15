Return-Path: <linux-kernel+bounces-145226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878C68A5118
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44151C21F3E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AF47828B;
	Mon, 15 Apr 2024 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="V6hLvTiW"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89A912C538;
	Mon, 15 Apr 2024 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186483; cv=none; b=FS0aS6dEpgyDlRcdFt0uar93plSaz+jPdGnI8YsK1ufUqg3Vb1iJF6MgzEU06gpI2hFZozvaS8Qfk/yGpiHyGPjJ/qY58lw4SEGzbfg7ebHw2uG9aFplzsp59apVegXcz5v/OoEPnkVkKN/MZ5ESpAGhckoasCDWyPlU4mDcunE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186483; c=relaxed/simple;
	bh=m0/I5+S6CSiilQW69yS2LbTSrey8p/oYlcMWnlsQ1J0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Anp6u6vQoun88I2pysGUkEjfkLQ4oY36X52EkMNBguQl0WUu1mnz21oIeFdrNjvGEwxo2UJT2MO32W2yPZ8ncFDV7M0ViBjgS3rIvhDNq/0Y30Axhhjn6XkzIUR3A1QNV+h0qxV+UkWHT/FLs2SiIIAdF4D1oK6j8DuvvFaEzSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=V6hLvTiW; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713186419; x=1713791219; i=markus.elfring@web.de;
	bh=4q1T+fveRZjMHTvoEUqhMQBqnsOLA8vdGMrLNev6YzI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=V6hLvTiWwBcQMJjgKssj/YRycNHHayc9GY/F/ZOJhV6qRMUb5S4a4ZlFaki16AIy
	 0TQ3G9D//AyAV6nRCb2fqGz65SJaBC1+qkM5a7LHIksupkkbBNRQrt2DRsucDePoF
	 xmut1bsz2bo3057UG4ShP+eZqmIywbu0Lym0cPQWdV2IPR29olwBN5oKMrvq5V3Id
	 tmglOZQ/U11PL3fQoYhfeCpInOTznaBM3M0snzoKIV6GcxLFHyUx8xPlSfuSWMjGn
	 d72KdnTb9v9RAKdh8lWoX7sSUAq0/25NX+kWfTXkixMKKiQPs6GuwAnDdaVMSy2lX
	 BNv93auRRxUnjuDVCQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mq1CC-1sacXB10a2-00nOEZ; Mon, 15
 Apr 2024 15:06:59 +0200
Message-ID: <f1a38236-82fb-40e3-a7eb-bac913ba8f0f@web.de>
Date: Mon, 15 Apr 2024 15:06:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Guanrui Huang <guanrui.huang@linux.alibaba.com>,
 linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Shannon Zhao <shannon.zhao@linux.alibaba.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20240412021556.101792-1-guanrui.huang@linux.alibaba.com>
Subject: Re: [PATCH v3] irqchip/gic-v3-its: Fix double free on error
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240412021556.101792-1-guanrui.huang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:je1w6x2K7IgLg/YyCsujg70skuT5+UwFo/5EsgvyV0OKa75ON14
 gLXr96eR4s/F1aoHi3GMFu9cpnRnrefuHQ4f5Gtoql6ONnBPdisIgpigWf5smwap4c2VUwX
 9fTijWZyBo/MiS1bL3BDAGJUkhZUqjwx1tKJJTbtZhTcLPcZPTPg849RRO+nekfa6sPfXAh
 j4Dz5XiZVKnipOor0dWEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rm1SAKFwmZ8=;fwAliXKSJZyg6ImW72zUAywwFPP
 ngNWHHnusHBQIVHgT+2fYTiGcLDsfgc7Jpn7QIidJLdANeBPzMvL/8ku0xm4iBB00kr2Yv7Xc
 IDML4Z6UKRXaNx6HlN9jOAOQRbv7gVlFbqn/OPjhTkJubMtY3JheowwdCA0CWosGeB7Nz0Za1
 ve26JZB3uuTkPF418kpZzW98NJ9DHlXhplm4hyY8Oyb8U0fjomdQCUJjFXzDu6lGkF9ma8IKy
 6neuqOa/BIIoxxoqM0b6w3OhDBhfHs1e94Za5FZtxscROW0uDDndGZoZcceTkxY2s1O+xcOlR
 M1OSwLipi8gZtrGa3AX81vn762kIDj1ocNfPxcut9/XOueVhSX4oSo5Lg9HNdPswFWMhzuLew
 sVRhWeHLGPvfoSte7uKAUK+QbhzFJqBjnL6BzbAiHlILBGQWkENV14cnnq0ZYXfkM2AUbez2n
 3EIEPC0Jw+LOlJRrQiJAUM2akKimJ1Qd+a3IJBOrzNoo/pfQdW8pvNoF3RdnpNnigZmnTOM20
 LsO+04tfYuLAnRmqe86XLgoqr3M3/dlSSfOSkY3YAWoMAhLccgvCu8costpi5bjXxaPPGL55n
 uBbDN3FTXRLOMY7i6pCfiXkR7VbP2uapW7NeBIqr+mkpoGqaaT1NfzXIuGbb9wPQw6y3wLmSI
 COc90LcDdj/4vM9SKXbFL1AZPafPZRKkKl+BaahFV0IzlGO7yTbQBirmH7GzbGBVQR5n7WpMp
 rEZMKUUjQcVbIhhqikZ6Vi350WkGD41xizgBbDFgeRvUT0HUDIBw8haLiE37y71rxR30wZcGj
 PW+yBx+e1AwtQQaPZyEEOz9Ffre/ALat/P/OTXQdKZFac=

> In its_vpe_irq_domain_alloc, when its_vpe_init() returns an error
> with i > 0, its_vpe_irq_domain_free may free bitmap and vprop_page,
> and then there is a double free in its_vpe_irq_domain_alloc.
>
> Fix it by calling its_vpe_irq_domain_free directly, bitmap and
> vprop_page will be freed in this function.

I find this change description improvable.

Would you like to add the tag =E2=80=9CFixes=E2=80=9D accordingly?


=E2=80=A6
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -4521,8 +4521,6 @@ static int its_vpe_irq_domain_alloc(struct irq_dom=
ain *domain, unsigned int virq
>  	struct page *vprop_page;
>  	int base, nr_ids, i, err =3D 0;
>
> -	BUG_ON(!vm);
=E2=80=A6

Please improve the patch granularity.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc4#n81

Regards,
Markus

