Return-Path: <linux-kernel+bounces-43892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CD9841A78
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9025EB26025
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70381383A2;
	Tue, 30 Jan 2024 03:22:16 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D3C381D9;
	Tue, 30 Jan 2024 03:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584936; cv=none; b=TkKuF8mJKQB1GWi70uCH44zzDaVs1OyS9muX0NwVKvm12dhgyx8qAM2K9drpvVD5E3RsywGhJFDh1vb7ssXiKVhUsqJYDcBIVkBXcNzmHWKYWS1FBTCFR2A8ejX8biEupoxx4KIqT5LDBDpH4JOQbs53F8jxqWjRvs7xJymr8Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584936; c=relaxed/simple;
	bh=2IXwML/OhIF3bCdnqcufjvigJt0sgb+gpzdgSWQKPMg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TCkKVCZoycGVCt8sXJi748hftxns5ZbILf3IZMNvPoQQajxC/XYAqe0h7uYQirvSXUkaWx+ZkJKBdyxERlTM9+L0qeMelWhjERJZL+Mmi0aXpKaAxwLain48CmF+STLpUwPAZXfwGpMj69o/m29VBndxv50ut+duIjzy0Pc//OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8Cxbetka7hlDSoIAA--.25279S3;
	Tue, 30 Jan 2024 11:22:12 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx7c5ga7hl2jonAA--.22829S3;
	Tue, 30 Jan 2024 11:22:10 +0800 (CST)
Subject: Re: [PATCH v4 1/3] irqchip/loongson-eiointc: Typo fix in function
 eiointc_domain_alloc
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
 lvjianmin@loongson.cn, Huacai Chen <chenhuacai@loongson.cn>
References: <20240125113623.2043061-1-maobibo@loongson.cn>
 <20240125113623.2043061-2-maobibo@loongson.cn>
 <CAAhV-H4w7BYpoBbudpu3TiR5COHoBRFHHra9URdK1kczpeZbGA@mail.gmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <42844534-9b08-1aed-9067-6d4525a0d2ef@loongson.cn>
Date: Tue, 30 Jan 2024 11:22:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4w7BYpoBbudpu3TiR5COHoBRFHHra9URdK1kczpeZbGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Bx7c5ga7hl2jonAA--.22829S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF1fAr48Aw43JF1rur4DGFX_yoW8Xry7pF
	WUA3Wqkr45XryUA34agr4DZFyak390qrZ7Kayxtayavr98Jw1DGF1ruayqkr1vyw48GF12
	9F40qr1Uu3W5CacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4s2-UUUUU



On 2024/1/29 下午8:23, Huacai Chen wrote:
> Hi, Bibo,
> 
> We usually use eiointc_domain_alloc() rather than eiointc_domain_alloc
> to describe a function, but it is not a big issue. If you will update
> a new version you can modify this.
sure, will do.

Regards
Bibo Mao
> 
> Huacai
> 
> On Thu, Jan 25, 2024 at 7:36 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> There is small typo in function eiointc_domain_alloc, and there is no
>> definition about struct eiointc, instead it should be struct eiointc_priv.
>> It is strange that there is no warning with gcc compiler. This patch
>> fixes the typo issue.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> Acked-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>>   drivers/irqchip/irq-loongson-eiointc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
>> index 1623cd779175..b3736bdd4b9f 100644
>> --- a/drivers/irqchip/irq-loongson-eiointc.c
>> +++ b/drivers/irqchip/irq-loongson-eiointc.c
>> @@ -241,7 +241,7 @@ static int eiointc_domain_alloc(struct irq_domain *domain, unsigned int virq,
>>          int ret;
>>          unsigned int i, type;
>>          unsigned long hwirq = 0;
>> -       struct eiointc *priv = domain->host_data;
>> +       struct eiointc_priv *priv = domain->host_data;
>>
>>          ret = irq_domain_translate_onecell(domain, arg, &hwirq, &type);
>>          if (ret)
>> --
>> 2.39.3
>>


