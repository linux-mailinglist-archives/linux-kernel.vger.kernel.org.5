Return-Path: <linux-kernel+bounces-105194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E754D87DA5F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 15:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DCC61C20C6C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 14:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249ED1B963;
	Sat, 16 Mar 2024 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="J0ligexB"
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6011B94D;
	Sat, 16 Mar 2024 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710597808; cv=none; b=Lngp6IEG7TyO1fumZjScyCtV3A/pqe1C5v9Ht3Rk1V6E5ccZ7IiMADtDQswoghSl7zOyh9qnt+NSHWZ7wi5wdmB8dml/+93dmKJbI+g511BbOWvlMVnu6Oytoxx+Uv6QOp4IweMOiWD5eUyij+7Yz49GRmuOgvBFsN048f1wFIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710597808; c=relaxed/simple;
	bh=iurHmmgzGEhzsPovvTwnS7RaWLPjQs7AqlAoNlw71GU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DyUruuWDL6JzVMXhiLYYF9X8Ep8UM7AhmZE6TH93B7FPuAjojtbgJkv9rpDxAZQ9hZdViuDq5nJOkn+DxLdLKonc6EAZhj2MaCaWsb5Gx/uX8f/+wCMVl1LhvWdC6PG8b4qVw6DayISDGQ+p/3l3kM2TsLf7oOa1rrxbfhnWWZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=J0ligexB; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id lUd0rmhVnu7EMlUd0rHLw0; Sat, 16 Mar 2024 15:03:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1710597796;
	bh=VHWK2/irYPcGg1v/zR7vQ0TWgWp7p1a/IHLgtTM+Hkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=J0ligexB2EI5ykbsiKRLHGGD4kmZV5hEd/PqsOtRRjuvDqvCl5k9aWrZGoqAFUwiF
	 jis9w/L5zRF2kTY9f2mPG5X/IxnQcDxvX7mH0vIhh+E4SRf3dTrwY5XRgIAvyGUZRg
	 lKM1AXppNlt4WxTKvfM3eXUgQfapMm6ZIHxya62ZzTyYfbLXUXAa/tN/4u9pfGsfQH
	 TGZAXQOI1vFHeEXp+YeNsGGpnmwGj98Hrw0Hi/P8liUR6xfTwcNkhXqvQmzpwJukGi
	 JpRlcmyVkPjgKRBUMIwXmPVSlS3AcS6V5vmskTPJ6+V52epJS7y3JOfTCXa78/oVHL
	 V48a7MlAU4ZSw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 16 Mar 2024 15:03:16 +0100
X-ME-IP: 92.140.202.140
Message-ID: <0fda46c7-87e1-41f1-b3f0-ee3d1a4ac601@wanadoo.fr>
Date: Sat, 16 Mar 2024 15:03:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] irqchip/loongson-pch-pic: Update interrupt
 registration policy
Content-Language: en-MW, en-GB
To: Tianyang Zhang <zhangtianyang@loongson.cn>, chenhuacai@kernel.org,
 jiaxun.yang@flygoat.com, tglx@linutronix.de
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Baoqi Zhang <zhangbaoqi@loongson.cn>, Biao Dong <dongbiao@loongson.cn>
References: <20240316082141.26139-1-zhangtianyang@loongson.cn>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240316082141.26139-1-zhangtianyang@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 16/03/2024 à 09:21, Tianyang Zhang a écrit :
> From: Baoqi Zhang <zhangbaoqi@loongson.cn>
> 
> This patch remove the fixed mapping between the 7A interrupt source
> and the HT interrupt vector, and replaced it with a dynamically
> allocated approach.
> 
> We introduce a mapping table in struct pch_pic, where each interrupt
> source will allocate an index as a 'hwirq' from the table in the order
> of application and set table value as interrupt source number. This hwirq
> will be configured as its vector in the HT interrupt controller. For an
> interrupt source, the validity period of the obtained hwirq will last until
> the system reset
> 
> This will be more conducive to fully utilizing existing vectors to
> support more devices
> 
> Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
> Signed-off-by: Biao Dong <dongbiao@loongson.cn>
> Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
> ---
>   drivers/irqchip/irq-loongson-pch-pic.c | 77 ++++++++++++++++++++------
>   1 file changed, 59 insertions(+), 18 deletions(-)
> 

..

> @@ -171,6 +183,27 @@ static int pch_pic_domain_translate(struct irq_domain *d,
>   			return -EINVAL;
>   
>   		*hwirq = fwspec->param[0] - priv->gsi_base;
> +
> +		raw_spin_lock_irqsave(&priv->pic_lock, flags);
> +		/* Check pic-table to confirm if the hwirq has been assigned */
> +		for (i = 0; i < priv->inuse; i++) {
> +			if (priv->table[i] == *hwirq) {
> +				*hwirq = i;
> +				break;
> +			}
> +		}
> +		if (i == priv->inuse) {
> +			/* Assign a new hwirq in pic-table */
> +			if (priv->inuse >= PIC_COUNT) {
> +				pr_err("pch-pic domain has no free vectors\n");
> +				raw_spin_unlock_irqrestore(&priv->pic_lock, flags);
> +				return -EINVAL;
> +			}
> +			priv->table[priv->inuse] = *hwirq;
> +			*hwirq = priv->inuse++;
> +		}
> +		raw_spin_unlock_irqrestore(&priv->pic_lock, flags);

Hi,

not sure if it helps or if this is a hot path, but, IIUC, taking the 
lock could be avoided with some code reordering and 'inuse' being an 
atomic_t.

IIUC, the lock is only needed to protect 'inuse' and 'table' is never 
modified afterwards.

Somehing like:

 > +		int cur_inuse;
		...
 > +		cur_inuse = atomic_read(&priv->inuse);
 > +		/* Check pic-table to confirm if the hwirq has been assigned */
 > +		for (i = 0; i < cur_inuse; i++) {
 > +			if (priv->table[i] == *hwirq) {
 > +				*hwirq = i;
 > +				break;
 > +			}
 > +		}
 > +		if (i == cur_inuse) {
 > +			/* Assign a new hwirq in pic-table */
 > +			if (cur_inuse >= PIC_COUNT) {
 > +				pr_err("pch-pic domain has no free vectors\n");
 > +				return -EINVAL;
 > +			}
 > +			priv->table[cur_inuse] = *hwirq;
 > +			*hwirq = atomic_inc_return(&priv->inuse);
 > +		}


> +
>   		if (fwspec->param_count > 1)
>   			*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
>   		else
> @@ -194,6 +227,9 @@ static int pch_pic_alloc(struct irq_domain *domain, unsigned int virq,
>   	if (err)
>   		return err;
>   
> +	/* Write vector ID */
> +	writeb(priv->ht_vec_base + hwirq, priv->base + PCH_INT_HTVEC(hwirq_to_bit(priv, hwirq)));
> +
>   	parent_fwspec.fwnode = domain->parent->fwnode;
>   	parent_fwspec.param_count = 1;
>   	parent_fwspec.param[0] = hwirq + priv->ht_vec_base;

..


