Return-Path: <linux-kernel+bounces-137747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC4C89E6A6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37871F226F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E3763E;
	Wed, 10 Apr 2024 00:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="x1DLPITV"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15A020E3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712707897; cv=none; b=bAt+e5nQKTDeaH9fCoQz+EFW6viRmMmu4K4h+LIipFZGMtdqnZ5dg1zgwsEGOP3Li3wUIfNbk//6BHhKLSv/8BHY4PK8OlZvrqGIVQq/9hJHvOVXLfuP/pmynf4IzpmA5npDybFPZPZ+qcaN0Jd6Gnj9lOMqw98+Yu7stk33RfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712707897; c=relaxed/simple;
	bh=jb461/Hw0ZqEf1wO7HDax8yrOboCkSwQKL6zWAmMrUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hLnBH/V1wvfBEa5DRluKV7Hip6/FyZRks3TgzCGlywQr5S05OOG96Nbb+H1NxhcqKLwA84ri3zMJRos/55A/pjbaOsPibGaJ6MBdtFKKlm9yJPEVJ5OAmC+zLhWqPZ5bz+dyN28tShaCPtygwviJUsgglIXLBajly9IxUnx3kOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=x1DLPITV; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-229a90b7aa9so2779568fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 17:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712707895; x=1713312695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gtH2sd79QyaRF1BMJBe3s1Wc0LYZsHGHiseKLFNrnNM=;
        b=x1DLPITV9nMIlhpYlEx84azkC26S3DzZ8vyifZPWEneQjZabIytDgy5r0udEUtCUZz
         z9kFhajxYGcGyGEcVoIMhrI2CY7Aek0yfL5Up0Wp7+Kqj6IHjLJmE4CVki30GfmNlK36
         B2oHHR1HbvBLfLZtqd4/6Kd7XG5dbbpd6l0IxFRR/WggRSm2l5DmRo/J69AhvMJBhElN
         7Uwng3MPdbilaYRcftqw4zfS7JTjGHo/qsUpqmLR8ZKk5qqbfN8N9pqhgt0rBRrRMdlU
         uRYJdDNEvw2zngFO4e8Xbq3qPUWtlrjIpJGdtIqRVBKOZnovoOv9IstXigTDCxSNW0es
         YK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712707895; x=1713312695;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gtH2sd79QyaRF1BMJBe3s1Wc0LYZsHGHiseKLFNrnNM=;
        b=QnCOlmpCGY3OpvO0DA4CMuuQsjHDmvPg1jP5L+k5cdhvd5CsLZjCJc42XbHSp0fqe0
         wVDRaGUa+4jZqSHfxEkanDg4ZAi5IAVmcmzGYxb7KGUuS1z+OPuRqbLT87I5T7WmuObL
         VFBO4kuivM1LE3jjHtsL0NkYnOeNomOiGdxXIyGwij75QeRlnfPtXd4fk1H8TgVJN4PV
         cfe4O8tWpNlHYYn0/Gak+9zWoBvYiJxHCzV5rXom2FAh3i73onvX/JlOt/lF5wHy/bw8
         XwvY0MUTJv89+vSwNwxxgzEmGqXb5rahf3JE5UVPEw/ibQhA6nDNvdW4jIO8VJ8tIZxZ
         jJyw==
X-Gm-Message-State: AOJu0YyE2CJr7NqppsLtZffimb2Sk++OY8aubZf79+qJZeZj3i2zGJ+p
	bgcAuP1KEqsYWQOUa4rFuxc+x8B27N8ATpGGeQJ4VztDCF/LqeiS1/R4PaHw5Oc=
X-Google-Smtp-Source: AGHT+IEeDpvGXBqH/je10IHPu14YT86VdOv9pM7mB36It6cqAwKg+lgXt6Z2O4u7jJXtXFs/Sn2j4g==
X-Received: by 2002:a05:6870:332b:b0:22a:7ce0:dd37 with SMTP id x43-20020a056870332b00b0022a7ce0dd37mr1322899oae.9.1712707894814;
        Tue, 09 Apr 2024 17:11:34 -0700 (PDT)
Received: from [10.0.16.226] ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id o5-20020a056a001b4500b006e72c8ece23sm8926609pfv.191.2024.04.09.17.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 17:11:34 -0700 (PDT)
Message-ID: <388ef032-7030-47b5-bba5-852b00de7382@rivosinc.com>
Date: Tue, 9 Apr 2024 17:11:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/15] RISC-V: KVM: Add perf sampling support for
 guests
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Atish Patra <atishp@atishpatra.org>,
 Conor Dooley <conor.dooley@microchip.com>, Guo Ren <guoren@kernel.org>,
 Icenowy Zheng <uwu@icenowy.me>, kvm-riscv@lists.infradead.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 Will Deacon <will@kernel.org>
References: <20240229010130.1380926-1-atishp@rivosinc.com>
 <20240229010130.1380926-10-atishp@rivosinc.com>
 <20240302-f9732d962e5f7c7760059f2e@orel>
 <c46c57c2-95bc-4289-ac99-efd5bad093b5@rivosinc.com>
 <20240405-de92b25fdc1ecf53770c49d9@orel>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20240405-de92b25fdc1ecf53770c49d9@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/5/24 05:05, Andrew Jones wrote:
> On Tue, Apr 02, 2024 at 01:33:10AM -0700, Atish Patra wrote:
> ...
>>> but it should be possible for the VMM to disable this extension in the
>>> guest. We just need to change all the checks in KVM of the host's ISA
>>> for RISCV_ISA_EXT_SSCOFPMF to checking the guest's ISA instead. Maybe
>>> it's not worth it, though, if the guest PMU isn't useful without overflow.
>>> But, sometimes it's nice to be able to disable stuff for debug and
>>> workarounds.
>>>
>>
>> As per my understanding, kvm_riscv_vcpu_isa_disable_allowed only returns
>> true for those extensions which can be disabled architecturally.
> 
> I think kvm_riscv_vcpu_isa_disable_allowed can return true for any
> extensions that KVM can guarantee won't be exposed in any way to the
> guest. Extensions that cannot be disabled architecturally must return
> false, since their instructions will still be present in the guest, even
> if KVM doesn't want to expose them, but extensions which KVM emulates
> can return true because KVM can choose not to emulate them. IIUC, sscofpmf
> falls in this latter category.
> 

hmm. The Sscofpmf is dependent on interrupt filtering via hvien and SBI 
PMU. So you are suggesting to toggle off the CSR_HVIEN bit for overflow 
interrupt or do more granular disabling for privilege mode filtering in 
SBI PMU as well.

Beyond that we can't disable SBI PMU. Is that okay ? A guest can still 
cause counter overflow and interrupt the host. However, the guest won't 
get any interrupt as hvien is not set.

It can also still filter the events as that is tied with SBI PMU.

We can put more granular checks in SBI pmu but I am just wondering if it 
provides anything additional beyond just disabling the sscofpmf in 
device tree.


>>
>> VMM can still disable any extension by not adding to the device tree.
>> In fact, that's how kvmtool can disable sstc or sscofpmf with
>> --disable-<isa-ext command>.
>>
>> The warning is bit confused though.
>>
>> For example: if you run kvmtool with --disable-sstc
>>
>> "Warning: Failed to disable sstc ISA exension"
> 
> I think Sstc should allow disabling since it has a corresponding henvcfg
> bit which KVM could not set in order to force accesses to the Sstc CSRs
> to raise ILL exceptions. So, let's put Sstc aside, since it's not a good

Agreed. I will send a separate patch for that.

> example. An extension like Zihintpause, OTOH, cannot be disabled since
> the 'pause' instruction will be present even if KVM does not put
> Zihintpause in the guest's ISA string. If a kvmtool user uses
> --disable-zihintpause, then I think this warning about failing to disable
> the extension is appropriate.
> 
>>
>> But sstc is disabled: Here is the cpuinfo output.
>> # cat /proc/cpuinfo
>> processor       : 0
>> hart            : 0
>> isa             : rv64imafdc_zicbom_zicboz_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zfa_zba_zbb_zbc_zbs_smstateen_sscofpmf
>> mmu             : sv57
>> mvendorid       : 0x0
>> marchid         : 0x0
>> mimpid          : 0x0
>> hart isa        : rv64imafdc_zicbom_zicboz_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zfa_zba_zbb_zbc_zbs_smstateen_sscofpmf
> 
> Removing from the ISA string is the best we can do in cases like
> Zihintpause, and is likely good enough for well-behaved guests, but the
> VMM's warning to the user is good for these cases too, since not all
> guests are well-behaved.
> 
> Thanks,
> drew


