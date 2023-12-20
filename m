Return-Path: <linux-kernel+bounces-6162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097E3819538
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44FC4B22A37
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B2F5252;
	Wed, 20 Dec 2023 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gFFdU9YF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E794C468D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so3864693a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703032076; x=1703636876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qd1p4zVeoUamI2mjRUTIt+8BF9TE63HS8QpugOrL9t0=;
        b=gFFdU9YFTQgy7BSWtR7/mQGdhcsxha/sS0K1wzbMsBtuTK93yQAoSbap+M5tnhSHMM
         ji9ZEEJ0g+4QyzWv83vJMOncQDyhkq9XS//R8WFUKpZixPlYlyqeQoh5o5eiDXdnS+Jt
         ptKqcqNERG1FubSn+RD8wZm8rLbfXDnNXxhFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703032076; x=1703636876;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qd1p4zVeoUamI2mjRUTIt+8BF9TE63HS8QpugOrL9t0=;
        b=Jdfn+JcmLYNRKfZBPiwj3nJhlx5gGm86WeOwj8LWgM286dXKj8hksomH5LSX9PbJWF
         TwzdG++1TLH5AJB823Y+gf6ZgHCg+GLgYc9SsR/I/NvEKYMbNGJuOMatY9A/h7MuwFL6
         YhsfOTUnoEs/XghpI0EXFodIU63oarJ3t/nziFJKhzV9E03bh1yK8hN9DY7uR6Iw3hZc
         Wf3lC3nCFQlIZ1KTxbAkhDrED1Q6XA9DwshX/Wuo3Zb87SxF+nm8wGfU88CYuoLmM4CQ
         godGSGsBZ7+PyPdYI/QO1njx6fK896CyTLxXEtov+iMr9mO83XgNgRZsiLxs1RHJZuaH
         A0Kg==
X-Gm-Message-State: AOJu0YzKJX1DB8xEP3WTIwoiRcEztwuRzTSHzJuZYBFGJFxGV2HnAEfl
	NTyi/5M77wGtc6RWeGQnE6LL0g==
X-Google-Smtp-Source: AGHT+IEGBZlYNFejsRyuZtJoOsR4NgZKkdzDMV/z5t+t3pGWJWTO/QXMqNBIsivcGeekCW+XGkzCxw==
X-Received: by 2002:a17:902:6bc2:b0:1d0:6ffd:e2ea with SMTP id m2-20020a1709026bc200b001d06ffde2eamr17476654plt.132.1703032076209;
        Tue, 19 Dec 2023 16:27:56 -0800 (PST)
Received: from [192.168.0.111] (d-174-140-102-53.fl.cpe.atlanticbb.net. [174.140.102.53])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902854300b001d3ea8ad878sm522565plo.290.2023.12.19.16.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 16:27:55 -0800 (PST)
Message-ID: <ba679460-827d-40b1-bc78-bcee1c013f36@broadcom.com>
Date: Tue, 19 Dec 2023 16:27:51 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] x86/vmware: Add TDX hypercall support
Content-Language: en-US
To: kirill.shutemov@linux.intel.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, mingo@redhat.com,
 tglx@linutronix.de, x86@kernel.org, netdev@vger.kernel.org,
 richardcochran@gmail.com, linux-input@vger.kernel.org,
 dmitry.torokhov@gmail.com, zackr@vmware.com,
 linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
 namit@vmware.com, timothym@vmware.com, akaher@vmware.com, jsipek@vmware.com,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch, airlied@gmail.com,
 tzimmermann@suse.de, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 horms@kernel.org
References: <20231219215751.9445-1-alexey.makhalov@broadcom.com>
 <20231219215751.9445-7-alexey.makhalov@broadcom.com>
 <20231219232323.euweerulgsgbodx5@box.shutemov.name>
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
Autocrypt: addr=alexey.makhalov@broadcom.com; keydata=
 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 EuY0
In-Reply-To: <20231219232323.euweerulgsgbodx5@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/19/23 3:23 PM, kirill.shutemov@linux.intel.com wrote:
> On Tue, Dec 19, 2023 at 01:57:51PM -0800, Alexey Makhalov wrote:
>> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
>> index 3aa1adaed18f..ef07ab7a07e1 100644
>> --- a/arch/x86/kernel/cpu/vmware.c
>> +++ b/arch/x86/kernel/cpu/vmware.c
>> @@ -428,6 +428,30 @@ static bool __init vmware_legacy_x2apic_available(void)
>>   		(eax & BIT(VCPU_LEGACY_X2APIC));
>>   }
>>   
>> +#ifdef CONFIG_INTEL_TDX_GUEST
>> +unsigned long vmware_tdx_hypercall(unsigned long cmd,
>> +				   struct tdx_module_args *args)
>> +{
>> +	if (!hypervisor_is_type(X86_HYPER_VMWARE))
>> +		return 0;
>> +
>> +	if (cmd & ~VMWARE_CMD_MASK) {
>> +		pr_warn("Out of range command %x\n", cmd);
>> +		return 0;
> 
> Is zero success? Shouldn't it be an error?

VMware hypercalls do not have a standard way of signalling an error.
To generalize expectations from the caller perspective of any existing 
hypercalls: error (including hypercall is not supported or disabled) is 
when return value is 0 and out1/2 are unchanged or equal to in1/in2.

All existing vmware_hypercall callers will gracefully handle returned 0.
But they should never hit this path, as 0 bail out was introduced as a 
protection for the case where exported vmware_tdx_hypercall is used by 
random caller (not following VMware hypercall ABI).

> 
>> +	}
>> +
>> +	args->r10 = VMWARE_TDX_VENDOR_LEAF;
>> +	args->r11 = VMWARE_TDX_HCALL_FUNC;
>> +	args->r12 = VMWARE_HYPERVISOR_MAGIC;
>> +	args->r13 = cmd;
>> +
>> +	__tdx_hypercall(args);
>> +
>> +	return args->r12;
>> +}
>> +EXPORT_SYMBOL_GPL(vmware_tdx_hypercall);
>> +#endif
>> +
>>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>>   static void vmware_sev_es_hcall_prepare(struct ghcb *ghcb,
>>   					struct pt_regs *regs)
>> -- 
>> 2.39.0
>>
> 

