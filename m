Return-Path: <linux-kernel+bounces-163462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E90B8B6B65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB611F22A93
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB3631A8F;
	Tue, 30 Apr 2024 07:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="h4abnvZ+"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642E1374E3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714461991; cv=none; b=bsO0ZDM5RUBuWez2Vkn7DJsX6DP1lNpwBAfU9231bf5m8QYbwHLLUuHNO68CaVSgniReTCfwJkN4TLcquVBve/S9YfohUpHe3g0OL+5HeiDzsia1vwHaFJ+SYhSK87FjRE76m0yvjBWcrkGiBraM/W8gahlUVgADm6xTd1qTLVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714461991; c=relaxed/simple;
	bh=uebO/s6LVxhG0opGGRAkrg4m1oP1SCiyjdL2AO+Foz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIJZQ7RtauA1zuCQdnC8r2YG0XMxhSdxyBgSoy7W95Cddo26KeQ1KEYJ5hUTFFOQDg+8lg6wtxesFLQndrkPmZH/EQ4vagjjHrW8pHl4NouSrCWo7xl1bW46+X++W3v0EWTOifsz1aQW77Zq5t+c+YIw9wCv6cq7Sx4tPlnH+XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=h4abnvZ+; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2db239711ebso13031421fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714461987; x=1715066787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WvyI3HdmRjoW+CLhdf/TdUb0HyFLPhU7rZbG7Bu9wO4=;
        b=h4abnvZ+UUUPUnNEAfn90fnbQ2jU1Sh26JF+QCyw2vxc4+gdfjUuTu06iUDBjBls4J
         T+CASH33Vcc5t10yBvPN9X7HJrWeQaGdbr1V39fT/NssMr9wfxp0lTsHGdDiU6MkEqSX
         WHb/Eo4hn5zZoR87hzMRyWWvxhaHG8EhUSy5OaTG9dk5fg+Z3w3kz4yvMp8mSEEFAbaD
         2O2fqTISYo7tfenKIPubJh+bOq/DAfUs87h2MItFR/kphebbJtnGVoKSLcZBC0SH5YEj
         P3cJje/DlRZMGiqoM7GKZJSRi9nBXy7cz/W6R4VN1xdStEGuR5tUN1QYpUn8zjol7Oeg
         f0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714461987; x=1715066787;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WvyI3HdmRjoW+CLhdf/TdUb0HyFLPhU7rZbG7Bu9wO4=;
        b=bSEJXcXUP2MQLnDEjWUFtZ89veFWqmIuz5q66lcRtEDRTNWM1iGdB+rBMadcZXMw2n
         SKbw/m9/p53AbwxOFIhgDCdJeDtPQUcrSiXSruKDAD+GpyU8oiA1SFYtVZ1YoTuL8VM+
         29jaqOBGUj9jgTxKkxzePTmc8ihBuro2Hic5spyAwRw3uahyrcXe+HZr4hTwi2RFbJuo
         zKL05Lgyb2XkObGKUoPntxH95NyhYNXbAZwBGqmQmCfcHJuXT5Nm7tG+MH3hJ4v+rIpH
         nEMreocHP12hO/ZveUgAE78ernPO7v873PlfzQcVThzN2nYsJLqbs3oJKNTYFl/47T1R
         4MXA==
X-Forwarded-Encrypted: i=1; AJvYcCU0Ni5ZUSEJBNm0Ua6fx+dJNqUIwQ+OPcW8xa234qaQS9eiVVbbbIvgds/mA5aygf/glhM2wq/uJM1XLTJ6N8+d70aOeaIYiYeZuvKT
X-Gm-Message-State: AOJu0YzoVLjTWAD/HC+MQYLk0c23UOH72E7SGuKNJPb0HZ2lvbZtePnz
	vvcZ8pXfUD+ZiV3YeZg/mJD0UmCVPxz5qbJGG8BJbNlRm/R2tfEhqXMwVoE7Ef0=
X-Google-Smtp-Source: AGHT+IF2/6JmkhuEesT0rXrPHpRH7kD8BY37pMN1aCWhBwhe5bjgiO3RpG2IZ9ZZSdnOrjhKRv7i/A==
X-Received: by 2002:a2e:9254:0:b0:2dd:374d:724e with SMTP id v20-20020a2e9254000000b002dd374d724emr7481828ljg.1.1714461987258;
        Tue, 30 Apr 2024 00:26:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:c21b:67fd:90ab:9053? ([2a01:e0a:999:a3a0:c21b:67fd:90ab:9053])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c35c700b0041bff91ea43sm9651380wmq.37.2024.04.30.00.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 00:26:26 -0700 (PDT)
Message-ID: <99d3eabc-0289-4ace-90a8-ad02dbffd6d2@rivosinc.com>
Date: Tue, 30 Apr 2024 09:26:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/7] riscv: kvm: add support for FWFT SBI extension
To: Deepak Gupta <debug@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, Ved Shanbhogue <ved@rivosinc.com>
References: <20240418142701.1493091-1-cleger@rivosinc.com>
 <20240418142701.1493091-2-cleger@rivosinc.com>
 <Ziw8c0X0K3mXjJWK@debug.ba.rivosinc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <Ziw8c0X0K3mXjJWK@debug.ba.rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27/04/2024 01:44, Deepak Gupta wrote:
> On Thu, Apr 18, 2024 at 04:26:40PM +0200, Clément Léger wrote:
>> Add support for FWFT extension in KVM
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>> arch/riscv/include/asm/kvm_host.h          |   5 +
>> arch/riscv/include/asm/kvm_vcpu_sbi.h      |   1 +
>> arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h |  37 ++++++
>> arch/riscv/include/uapi/asm/kvm.h          |   1 +
>> arch/riscv/kvm/Makefile                    |   1 +
>> arch/riscv/kvm/vcpu.c                      |   5 +
>> arch/riscv/kvm/vcpu_sbi.c                  |   4 +
>> arch/riscv/kvm/vcpu_sbi_fwft.c             | 136 +++++++++++++++++++++
>> 8 files changed, 190 insertions(+)
>> create mode 100644 arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h
>> create mode 100644 arch/riscv/kvm/vcpu_sbi_fwft.c
>>
>> diff --git a/arch/riscv/include/asm/kvm_host.h
>> b/arch/riscv/include/asm/kvm_host.h
>> index 484d04a92fa6..be60aaa07f57 100644
>> --- a/arch/riscv/include/asm/kvm_host.h
>> +++ b/arch/riscv/include/asm/kvm_host.h
>> @@ -19,6 +19,7 @@
>> #include <asm/kvm_vcpu_fp.h>
>> #include <asm/kvm_vcpu_insn.h>
>> #include <asm/kvm_vcpu_sbi.h>
>> +#include <asm/kvm_vcpu_sbi_fwft.h>
>> #include <asm/kvm_vcpu_timer.h>
>> #include <asm/kvm_vcpu_pmu.h>
>>
>> @@ -169,6 +170,7 @@ struct kvm_vcpu_csr {
>> struct kvm_vcpu_config {
>>     u64 henvcfg;
>>     u64 hstateen0;
>> +    u64 hedeleg;
>> };
>>
>> struct kvm_vcpu_smstateen_csr {
>> @@ -261,6 +263,9 @@ struct kvm_vcpu_arch {
>>     /* Performance monitoring context */
>>     struct kvm_pmu pmu_context;
>>
>> +    /* Firmware feature SBI extension context */
>> +    struct kvm_sbi_fwft fwft_context;
>> +
>>     /* 'static' configurations which are set only once */
>>     struct kvm_vcpu_config cfg;
>>
>> diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h
>> b/arch/riscv/include/asm/kvm_vcpu_sbi.h
>> index b96705258cf9..3a33bbacc233 100644
>> --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
>> +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
>> @@ -86,6 +86,7 @@ extern const struct kvm_vcpu_sbi_extension
>> vcpu_sbi_ext_srst;
>> extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_hsm;
>> extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbcn;
>> extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta;
>> +extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_fwft;
>> extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental;
>> extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor;
>>
>> diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h
>> b/arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h
>> new file mode 100644
>> index 000000000000..7dc1b80c7e6c
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h
>> @@ -0,0 +1,37 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2023 Rivos Inc
>> + *
>> + * Authors:
>> + *     Atish Patra <atishp@rivosinc.com>
> 
> nit: probably need to fix Copyright year and Authors here :-)
> Same in all new files being introduced.
> 
>> + */
>> +
>> +#ifndef __KVM_VCPU_RISCV_FWFT_H
>> +#define __KVM_VCPU_RISCV_FWFT_H
>> +
>> +#include <asm/sbi.h>
>> +
>> +#define KVM_SBI_FWFT_FEATURE_COUNT    1
>> +
>> +static int kvm_sbi_fwft_set(struct kvm_vcpu *vcpu,
>> +                enum sbi_fwft_feature_t feature,
>> +                unsigned long value, unsigned long flags)
>> +{
>> +    struct kvm_sbi_fwft_config *conf = kvm_sbi_fwft_get_config(vcpu,
>> +                                   feature);
>> +    if (!conf)
>> +        return SBI_ERR_DENIED;
> 
> Curious,
> Why denied and not something like NOT_SUPPORTED NOT_AVAILABLE here?

Hey Deepak,

So indeed, the return value is not totally correct since the spec states
that we return  EDENIED if feature is reserved or is platform-specific
and unimplemented. But in that case it dos not distinguish between
defined features and reserved one. I'll add a check for that.

Thanks,

Clément

> 
>> +
>> +    if ((flags & ~SBI_FWFT_SET_FLAG_LOCK) != 0)
>> +        return SBI_ERR_INVALID_PARAM;
>> +
>> +    if (conf->flags & SBI_FWFT_SET_FLAG_LOCK)
>> +        return SBI_ERR_DENIED;
>> +
>> +    conf->flags = flags;
>> +
>> +    return conf->feature->set(vcpu, conf, value);
>> +}
>> +

