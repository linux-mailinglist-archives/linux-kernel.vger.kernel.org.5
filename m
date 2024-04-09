Return-Path: <linux-kernel+bounces-137558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E68989E3DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54664284C04
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A328157A7B;
	Tue,  9 Apr 2024 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="dlz0NLut"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0F1145320
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712691835; cv=none; b=JF8i5Nts91oBYV8t4CgbXyb9Z+xnBQjncBSXlRTP4T+dGE0qu+QUJ+ecg35uwqckhORfh4ME+tLl6Y8RukxR8rKFE0M9zu8thYXmCgm9hirspKBdCd04vIolPDu6Kq+vW088MeaQBZFXxDXRtqHJqUeh5zQxJ2cIvYN4QqI7SpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712691835; c=relaxed/simple;
	bh=ACQcM30tSW2SL5zP4ycccQREhmMc4+KanOtj6bG1ZDQ=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=TJ2tIAQBsaAMo8irTiYE22csO93kOtNqcX560h62raCjJ8RhGan6/fE6l4/mkZ53q02ElojQXXcolxFytFZfCiQP6qPh6vZEu3tJRIVOkyBvQSrCxSnP3E4eCYIW6KzwTZIrOx+7LTIwVJ2vJfFKrw2C53oEcp1LCWe6IX2ElO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=dlz0NLut; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e703e0e5deso5136797b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 12:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1712691833; x=1713296633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h53B27ecNHID1eXdf2FDHGt3AvdzJKoL8em24LSk0zk=;
        b=dlz0NLutmDQTcUAPNSe/cQER5CLC54TrJZz6m+K54elJPJC/PwIdZ7VqmYblVsUCuR
         4C1C9IV5SNqLXalK1woIiJIlGvsl6LWxkq/KIXy6WWt21Dx+1+BO8lgczeFyInDivPCU
         r46izjwLSjg2QTsOUyY6zcxPg7zV2n1syL3G6IbsPtctQQ6yzvGzKaTLzg/rb6UnB0AA
         q/XfE2JILnD8BMKrMniR8nWa6XsOkeilyzijy/IIuRl4C0La0RlGJ6QGD9K0v1tXKy1a
         EKiRQYsG3lGNlfLhNI2nklij5bONMtfO3obi6aCA6EJJSvtKqvvF2r6QNFlVdTamNr/B
         mUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712691833; x=1713296633;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h53B27ecNHID1eXdf2FDHGt3AvdzJKoL8em24LSk0zk=;
        b=uosbENgfjTV8Hh9x1oAMqyWEcyCVAFVPilt5TkbF+sPykcq2XTlAF4CPDBBDKDotJI
         yWoOlhYBBIxIZPIapXHi60dob5BwkHl2pKZHZm3D4GT/kaUtTAAouvdmKqzPH5PWzfAW
         0x8rfgPYh2TM64qn+6KQ2cb1iuhF64W3WI89KJ8rumqUizDSFta3s0LZLzVAe/QFqWm7
         8dij65DOGgq12GKFK10b+U/1Q0EcvaJvSRUw8uGWUsF9C7a/iemtgJzCKqerpI6TBq5M
         rreb4R7lvsPWXDI65Sdn+WuCBVHd+nyRB7vFxzdTbHH4WrPaHAB7621Yy/RtjS8VudrY
         JoOA==
X-Forwarded-Encrypted: i=1; AJvYcCUa68gvlyGWkphIGi7QEO83H0Zrm5JoyXh9f+VGvdYKTRpv5orpZbgq4e33k/hneoaPbvWV7PWDl4lViB5/d0lTCjQoc2+b8MR7oOM1
X-Gm-Message-State: AOJu0YwOpeHfw7kVxZnlSE9piec2rtpDqrm3bZ4fhKQ7YugKuJQ+TbUs
	BXEX1/A7GATgGOLuMSCEXp0yfun97t9+cJqYkA+8LppRactVtPx5QVq+Qh6GpgI=
X-Google-Smtp-Source: AGHT+IFBDhalit5CBUtLdP+oCW6gPaGZXDYApBZDPMr2GixfOhzhLUtkHUNZ/dpRhZzvWQ/JDO1haw==
X-Received: by 2002:a05:6a00:22c3:b0:6ed:1c7:8c6b with SMTP id f3-20020a056a0022c300b006ed01c78c6bmr588864pfj.1.1712691832230;
        Tue, 09 Apr 2024 12:43:52 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id y10-20020aa79e0a000000b006ecf217a5e1sm8655966pfq.189.2024.04.09.12.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 12:43:51 -0700 (PDT)
Date: Tue, 09 Apr 2024 12:43:51 -0700 (PDT)
X-Google-Original-Date: Tue, 09 Apr 2024 12:43:49 PDT (-0700)
Subject:     Re: [PATCH] riscv: Do not save the scratch CSR during suspend
In-Reply-To: <3010bb57-c13f-494a-9e8c-0ae6393b1eee@sifive.com>
CC: jeeheng.sia@starfivetech.com, linux-riscv@lists.infradead.org,
  aou@eecs.berkeley.edu, ajones@ventanamicro.com, Conor Dooley <conor.dooley@microchip.com>,
  leyfoon.tan@starfivetech.com, Paul Walmsley <paul.walmsley@sifive.com>, pavel@ucw.cz, rafael@kernel.org,
  linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: samuel.holland@sifive.com
Message-ID: <mhng-fa663ef4-be7b-455b-b467-f4d331a269ea@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 21 Mar 2024 16:51:31 PDT (-0700), samuel.holland@sifive.com wrote:
> On 2024-03-14 11:55 PM, JeeHeng Sia wrote:
>>
>>
>>> -----Original Message-----
>>> From: Samuel Holland <samuel.holland@sifive.com>
>>> Sent: Wednesday, March 13, 2024 3:57 AM
>>> To: Palmer Dabbelt <palmer@dabbelt.com>; linux-riscv@lists.infradead.org
>>> Cc: Samuel Holland <samuel.holland@sifive.com>; Albert Ou <aou@eecs.berkeley.edu>; Andrew Jones <ajones@ventanamicro.com>;
>>> Conor Dooley <conor.dooley@microchip.com>; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Paul Walmsley
>>> <paul.walmsley@sifive.com>; Pavel Machek <pavel@ucw.cz>; Rafael J. Wysocki <rafael@kernel.org>; JeeHeng Sia
>>> <jeeheng.sia@starfivetech.com>; linux-kernel@vger.kernel.org; linux-pm@vger.kernel.org
>>> Subject: [PATCH] riscv: Do not save the scratch CSR during suspend
>>>
>>> While the processor is executing kernel code, the value of the scratch
>>> CSR is always zero, so there is no need to save the value. Continue to
>>> write the CSR during the resume flow, so we do not rely on firmware to
>>> initialize it.
>>>
>>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>>> ---
>>>
>>>  arch/riscv/include/asm/suspend.h | 1 -
>>>  arch/riscv/kernel/suspend.c      | 3 +--
>>>  2 files changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
>>> index 491296a335d0..6569eefacf38 100644
>>> --- a/arch/riscv/include/asm/suspend.h
>>> +++ b/arch/riscv/include/asm/suspend.h
>>> @@ -13,7 +13,6 @@ struct suspend_context {
>>>  	/* Saved and restored by low-level functions */
>>>  	struct pt_regs regs;
>>>  	/* Saved and restored by high-level functions */
>>> -	unsigned long scratch;
>>>  	unsigned long envcfg;
>>>  	unsigned long tvec;
>>>  	unsigned long ie;
>>> diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
>>> index 299795341e8a..3d306d8a253d 100644
>>> --- a/arch/riscv/kernel/suspend.c
>>> +++ b/arch/riscv/kernel/suspend.c
>>> @@ -14,7 +14,6 @@
>>>
>>>  void suspend_save_csrs(struct suspend_context *context)
>>>  {
>>> -	context->scratch = csr_read(CSR_SCRATCH);
>>>  	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
>>>  		context->envcfg = csr_read(CSR_ENVCFG);
>>>  	context->tvec = csr_read(CSR_TVEC);
>>> @@ -37,7 +36,7 @@ void suspend_save_csrs(struct suspend_context *context)
>>>
>>>  void suspend_restore_csrs(struct suspend_context *context)
>>>  {
>>> -	csr_write(CSR_SCRATCH, context->scratch);
>>> +	csr_write(CSR_SCRATCH, 0);
>> If the register is always zero, do we need to explicitly write zero to the register during resume?
>
> The register contains zero while executing in the kernel. While executing in
> userspace, the value is nonzero. The value is checked at the beginning of
> handle_exception(). We must ensure the value is zero before enabling interrupts,
> or we might incorrectly think the interrupt was entered from userspace.
>
> We don't know what the value will be when the hart comes out of non-retentive
> suspend. Per the SBI HSM specification, Table 6: "All other registers remain in
> an undefined state."

We're also not setting it at all in `.macro suspend_restore_csrs`, which 
I think is just a bug?

That said, I'm kind of seeing bugs everywhere I look in this now -- what 
about all the other registers we can poke, like timers/counters or the 
V/F state (or anything from M-mode, though maybe that's just someone 
else's problem)?

I also think we'd break on medlow kernels, as a bunch of this relies on 
medany-as-PIC for the SATP-off transition.

Maybe I'm going crazy here, though...

> Regards,
> Samuel

