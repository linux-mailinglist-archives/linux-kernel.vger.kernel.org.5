Return-Path: <linux-kernel+bounces-154088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8D28AD741
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61FDC1F21F00
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B4C2940B;
	Mon, 22 Apr 2024 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtIEshkF"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82AB1F945;
	Mon, 22 Apr 2024 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713824784; cv=none; b=Mkf+23ySAR3qs24LXKcP64YLjiybc0n6sEOe9re6Ox/fzdibIwC4JYSoRD6R03Di0XXTdF6qklN+wvI52tTVnN9Yex/bPdFMnBlJAcJaoSXWPTDe5C0qTTHRcaRh55XBS+2LYl4Da6GmpB+ckuIkXCYeITxvFLqPm+FiwNayEro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713824784; c=relaxed/simple;
	bh=yytd/TKDcz0zO0Y37oJt6qufnxgJiwwtFNIShmyvX+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWVwAep1BP2slK5bVnAa3EHbdWdz9P3isUmoizGTC1y+ycT44p+hsRqL4h/ImUvVub7Zbvz2JCjV2czoaEhBXfli0XmXdkMaAY4w++8af2RPQ6RPTfM26Dw8QL8j3ugUwhSXd5QeLhCrdDddQgPD6DtF0xb2UmJqPmntEPLMWuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtIEshkF; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ecff9df447so4768513b3a.1;
        Mon, 22 Apr 2024 15:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713824782; x=1714429582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JuM0/xDG6R+np+C0O0vux1OzQYg+atHpSL0uJUVCs4k=;
        b=MtIEshkFTRxMmE3RfQ/JKnBBk3PXoADrzJi/hV/LoN4cevMbP103XRb+A4edqOvGhg
         uWfr2WLC+DIo2x1sq90Lk4DjHbUQmwcPUpcyrngfoP/VwpY4J8SQ0Jabn1MZ2slKl/Fc
         nLUNHwPatPdZVuk0dl+pJZNiu+yfAlI/BtYvSes4zIrNDb/IOM0NFX3C0EKf01BYg2EW
         fBseyI4nxhi9cDN3dbpRvjVPfAr/LHjpcJADqKbAb3MS+EVGpmUVcuN2QkG0H6Y/tmzn
         /McLfbbNaiYm6GzSQN0qRIocx5W9YruNj8nboNYAFg+WcYzzg4um9Tx6Vu4LWdH9cdPl
         G9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713824782; x=1714429582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JuM0/xDG6R+np+C0O0vux1OzQYg+atHpSL0uJUVCs4k=;
        b=KJpn4jLW+MROAe10UhFHBg6FE2zA31bHLyLelIH+jv0EIBL3OcpdhHJ+TYynCcLTna
         5rR/WTE5M357te0APHpcwBkUWcOEyRhoH34naIVCwpP/zmQiojeGVNWiSF/m6nxet3dk
         awmYts4nvjejfUZ3mnlBuyqS/H/Oqn7De7cZ4F3NeJYlBVdUZFPRvNkDeYuk+wiEhX7P
         +i5UIn0MYDqKq5DOmdI9EmxoUutUPQ/vKuKZ4N8i/D3voDnZg8v+uW/69nxbkLjtI8FH
         kyIYvS0wSS7dp/Y0SWVM8KWa1GKzUZAbbel1tKfBMp+sMd+NCWZLJUj4x7SKhd3THwnX
         3HDg==
X-Forwarded-Encrypted: i=1; AJvYcCWPs9IHJw9gXVSJNCVMhsl9UGlTlO3ZP49j+yJDbVUJCS3uuRlYnDv3infNtmozcxVvM7L24zPmKXk12oUEDZPXH6ULVL3evgv/OXKHB/XPUNpIlwiZ9boWZDHi9IPgBrvAH+X2wT9dpw==
X-Gm-Message-State: AOJu0YwLm7634BCaQjF09Pi8QNJEY0RiNjU/SyWIH4nInUdoI4d6Kt38
	LiNlqV8d3moI9wzo4pbYQWCixzuraA4OSo+P/7wFiWpjw6gBxLp9
X-Google-Smtp-Source: AGHT+IHelQAPOIkLBsZeo/EkIlImeVDt9hnHq5y+I8dvw2RRE4WOw7SDyeajvl0NT5G42CRA3VEBfQ==
X-Received: by 2002:a05:6a00:929e:b0:6ed:1c7:8c5d with SMTP id jw30-20020a056a00929e00b006ed01c78c5dmr14921405pfb.12.1713824781952;
        Mon, 22 Apr 2024 15:26:21 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id k63-20020a638442000000b005fd88b393b4sm3381015pgd.59.2024.04.22.15.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 15:26:20 -0700 (PDT)
Message-ID: <958c27b1-26d7-4927-976b-4502f33f31f7@gmail.com>
Date: Mon, 22 Apr 2024 15:26:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip/irq-brcmstb-l2: Avoid saving mask on shutdown
To: Thomas Gleixner <tglx@linutronix.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-kernel@vger.kernel.org
Cc: opendmb@gmail.com, Tim Ross <tim.ross@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 "open list:BROADCOM BMIPS MIPS ARCHITECTURE" <linux-mips@vger.kernel.org>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
References: <20240416194343.469318-1-florian.fainelli@broadcom.com>
 <87le55ulw5.ffs@tglx>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <87le55ulw5.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/24 14:29, Thomas Gleixner wrote:
> On Tue, Apr 16 2024 at 12:43, Florian Fainelli wrote:
>> The interrupt controller shutdown path does not need to save the mask of
>> enabled interrupts because the next state the system is going to be in
>> is akin to a cold boot, or a kexec'd kernel.
> 
> Sure, but
> 
>> Reported-by: Tim Ross <tim.ross@broadcom.com>
>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> ---
>>   drivers/irqchip/irq-brcmstb-l2.c | 17 ++++++++++++++---
>>   1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
>> index 2b0b3175cea0..c988886917f7 100644
>> --- a/drivers/irqchip/irq-brcmstb-l2.c
>> +++ b/drivers/irqchip/irq-brcmstb-l2.c
>> @@ -118,7 +118,7 @@ static void brcmstb_l2_intc_irq_handle(struct irq_desc *desc)
>>   	chained_irq_exit(chip, desc);
>>   }
>>   
>> -static void brcmstb_l2_intc_suspend(struct irq_data *d)
>> +static void __brcmstb_l2_intc_suspend(struct irq_data *d, bool save)
>>   {
>>   	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
>>   	struct irq_chip_type *ct = irq_data_get_chip_type(d);
>> @@ -127,7 +127,8 @@ static void brcmstb_l2_intc_suspend(struct irq_data *d)
>>   
>>   	irq_gc_lock_irqsave(gc, flags);
>>   	/* Save the current mask */
>> -	b->saved_mask = irq_reg_readl(gc, ct->regs.mask);
>> +	if (save)
>> +		b->saved_mask = irq_reg_readl(gc, ct->regs.mask);
> 
> what's the conditional actually buying you except more complex code?

Not much this is an optimization that is simple to carry out. There can 
be dozens of such L2 interrupt controllers in a given system and the 
MMIO accesses start adding up eventually.
-- 
Florian


