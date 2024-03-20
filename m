Return-Path: <linux-kernel+bounces-108998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F5088132D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C431C22802
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D9044370;
	Wed, 20 Mar 2024 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="CZlW0Xne"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C741341C84
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710944231; cv=none; b=sDxSNpSUNQmIXZJXnhLRCgvB9rE0xDsnBJIsiOEZIX93vRvZiLKyD57oOn9aJzlF/fTrO0yEivm//YsF4nUZ8mqz68Dvd/WyjoEhtxb7fpJmJpauWNRuPXXPRMIRi9jWJP25n/idjmeCYElAeAWYOc+T/FBl+F60UD4Sy0xh/s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710944231; c=relaxed/simple;
	bh=p6dQqq/oYkWbfdi5xnwDgINsJNpwikfJyCRvq5/qIQI=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=I/tTSS0/zq1tMp1wB0fCnfvBCRU5+PLwiU2lFnkkFJGeTQ8lNUz3OSmNzZl85TC4izXgTzKsbZHt91NelkFLFOfe77DeWhLSd7LDfvZ3vgY9jOmquKdU97CBpS/lUnzuMKJYqCzK/xZG/30NxgOYqXtwqk3lyq3S7uQ/H+BTxEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=CZlW0Xne; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1def59b537cso35798525ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1710944229; x=1711549029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2EgfvxxgK+wJvZtFaKjr7t9HOODvH7M/KpVWvGGTzE=;
        b=CZlW0Xne9LkFEqRqi/HnxU6DS1b7g30iriiHJC78bciKoaqmqd3g1SdAHUe5qD1YuZ
         Xm42ltTIznjk0DSaYTUWWYsK82hETHigtGs7KLnyOh2tGY8Ic50D7hy8LPVDg/NV/DVe
         GLFAXs6sD2tm6UhLMCvW4lRXyYoONS4lxUBU3PLJuF/M6kxMsq3YkCkdENwC8O3Nj+aI
         PlT6sqzwvSrPe/bozKZ49CM7lIJXzp87GMLVAJbn1Cfmu6G77PGM6lpFe5XWx1kCLCLN
         Gpj81WFjJeumhhWZqvtKOcYntNMgEX7LY7ao0XWeF3Tl5b4pcauiU1sbuoAzx+vkwd94
         Us/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710944229; x=1711549029;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2EgfvxxgK+wJvZtFaKjr7t9HOODvH7M/KpVWvGGTzE=;
        b=Efb5NR5KoPYdZA1xUmmUl/nwubeL99yOWufTCoB4hYUuXZfWduU0XJ8dgyMGMFowLH
         NIHcW89o3B0hC6rg+2j0ABfnjMbnSSNwPtWP192BUyuhZrd2UrPcpo//aZpiASqSQ6OB
         +f4Lwgw3aJmnScj/SbueKi3l4ZgVIxyQmTB08clI1f8WZWplG3HMBvxdaenZV4UQJVhh
         3Xci6nNrS5rAHgv5cjykAy2yu509pClpAEVEHTu0Kk2ndw+uRoomAM7VyOKX7dn/3OOn
         hU6gIW/L3qpn3EtwvZZjtly7TYRbYNPTuJthmoAQJtL1lKkKrPiUQ6U6Z9iOsqmpTfJk
         MLnw==
X-Forwarded-Encrypted: i=1; AJvYcCXrmstGpGSws/J2GLPuz4Tqo6MXEaywtq2URkv7fPlq0YIlqDuH74/Wz+mzwStsWFV/WmkeMt84Ocu5ORM9VSrkWhR0evFlodSDd2Eq
X-Gm-Message-State: AOJu0Yyhi2WlU8MrHuFhUr5+SLbS2NHu/1EG93Pq5AQovuK5KChodadZ
	RdiVKI9Q64dodSpC3z1BF6NnPH4WnNVCJjpc+0GZxy+7d9FDWEuu5f09cQMIBcU=
X-Google-Smtp-Source: AGHT+IGycrYcZflVp1sNbYxQH6AqEecSt6Yeb5KG7ltM7bagqWpsCCfgRrtVN3eRcOSSKhXrIi+/+g==
X-Received: by 2002:a17:902:eb8c:b0:1de:ddc6:278f with SMTP id q12-20020a170902eb8c00b001deddc6278fmr17506092plg.0.1710944228449;
        Wed, 20 Mar 2024 07:17:08 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090282ca00b001d8edfec673sm13539227plz.214.2024.03.20.07.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 07:17:08 -0700 (PDT)
Date: Wed, 20 Mar 2024 07:17:08 -0700 (PDT)
X-Google-Original-Date: Wed, 20 Mar 2024 07:17:06 PDT (-0700)
Subject:     Re: [PATCH v2] irqchip/sifive-plic: enable interrupt if needed before EOI
In-Reply-To: <87wmr8hd7j.ffs@tglx>
CC: namcao@linutronix.de, Paul Walmsley <paul.walmsley@sifive.com>,
  samuel@sholland.org, Marc Zyngier <maz@kernel.org>, guoren@kernel.org, linux-kernel@vger.kernel.org,
  linux-riscv@lists.infradead.org, namcao@linutronix.de, stable@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: tglx@linutronix.de
Message-ID: <mhng-2ab049d5-bab9-4d62-8d68-a7159a987f12@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 13 Feb 2024 02:26:40 PST (-0800), tglx@linutronix.de wrote:
> Nam!
>
> On Wed, Jan 31 2024 at 09:19, Nam Cao wrote:
>> RISC-V PLIC cannot "end-of-interrupt" (EOI) disabled interrupts, as
>> explained in the description of Interrupt Completion in the PLIC spec:
>>
>> "The PLIC signals it has completed executing an interrupt handler by
>> writing the interrupt ID it received from the claim to the claim/complete
>> register. The PLIC does not check whether the completion ID is the same
>> as the last claim ID for that target. If the completion ID does not match
>> an interrupt source that *is currently enabled* for the target, the
>> completion is silently ignored."
>>
>> Commit 69ea463021be ("irqchip/sifive-plic: Fixup EOI failed when masked")
>> ensured that EOI is successful by enabling interrupt first, before EOI.
>>
>> Commit a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask
>> operations") removed the interrupt enabling code from the previous
>> commit, because it assumes that interrupt should already be enabled at the
>> point of EOI. However, this is incorrect: there is a window after a hart
>> claiming an interrupt and before irq_desc->lock getting acquired,
>> interrupt can be disabled during this window. Thus, EOI can be invoked
>> while the interrupt is disabled, effectively nullify this EOI. This
>> results in the interrupt never gets asserted again, and the device who
>> uses this interrupt appears frozen.
>
> Nice detective work!
>
>> Make sure that interrupt is really enabled before EOI.
>>
>> Fixes: a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask operations")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Nam Cao <namcao@linutronix.de>
>> ---
>> v2:
>>   - add unlikely() for optimization
>>   - re-word commit message to make it clearer
>>
>>  drivers/irqchip/irq-sifive-plic.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
>> index e1484905b7bd..0a233e9d9607 100644
>> --- a/drivers/irqchip/irq-sifive-plic.c
>> +++ b/drivers/irqchip/irq-sifive-plic.c
>> @@ -148,7 +148,13 @@ static void plic_irq_eoi(struct irq_data *d)
>>  {
>>  	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
>>
>> -	writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
>> +	if (unlikely(irqd_irq_disabled(d))) {
>> +		plic_toggle(handler, d->hwirq, 1);
>> +		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
>> +		plic_toggle(handler, d->hwirq, 0);
>
> It's unfortunate to have this condition in the hotpath, though it should
> be cache hot, easy to predict and compared to the writel() completely in
> the noise.

Ya, I think it's fine.

I guess we could try and play some tricks.  Maybe hide the load latency 
with a relaxed writel and some explict fencing, or claim interrupts when 
enabling them.  Those both seem somewhat race-prone, though, so I'm not 
even sure if they're sane.

Anything with a PLIC is going to have pretty poor interrupt latency 
already, so I doubt it's worth the headache.

>> +	} else {
>> +		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
>> +	}
>>  }
>
> Can the RISCV folks please have a look at this?

Sorry I missed this.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

in case anyone was worried, though I saw it got merged so I think we're 
safe there.  I'm always a bit lost with the IRQ stuff, I didn't even 
know that race condition was posisble.

Thanks for the fix!

>
> Thanks,
>
>         tglx

