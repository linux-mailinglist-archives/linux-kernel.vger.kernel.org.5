Return-Path: <linux-kernel+bounces-6312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78F1819710
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22356B25875
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B978F45;
	Wed, 20 Dec 2023 03:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fOYB4t+w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDAA1C69C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3ba2dd905f9so3486108b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 19:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703041352; x=1703646152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+SUgrFQfnU6UHwK7AW2rQ/gZgr4SsShcYa3n9nuWsGE=;
        b=fOYB4t+w9nuuE6H4GUGEMG0O+mUhVvRW4ApRvDhziV009F0qmvPiSjy6nUcV4Cg9y+
         nCJ3e/t+H5kKVLhUGeFqF9biLqm/6g/f02QCoJc4B0l9IHmO8R9ycDWP8UUM+JE8j+iL
         oFCcHz9FDzp4rs+VAJrLLFmrfm40oOV2sOU+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703041352; x=1703646152;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+SUgrFQfnU6UHwK7AW2rQ/gZgr4SsShcYa3n9nuWsGE=;
        b=EvDXadccew8L/UpMJLT4X+1lbX4Z4dh/Nt011LmKtQEh6rF3t9OD6og4HmNvw+/E2j
         M4I2ndTGj6C6/ldUEgggjzGYyLipZVG3+FwUxRGTl4byGSVH9saPQbjFfqCFrDDHi0Lc
         lwIdKEjJhMIbR2W8lSnq55FrWTzbh2XWlkduMY5OjV4QTvcD42W3KEo6hbQHp0cg7MHw
         r+juQg4IhxZxwpvSBYUBje3ZEiZ3i/SGT8EwLZc2GIo/l4eSkY98JL36cxbD/Gexq78/
         M3dcx5LzbiDna5A2hzyOddiu4nSlkdNecVPrMofDKJ1LBsfED2HSmhRVYLl2CTFf1ibr
         /+Iw==
X-Gm-Message-State: AOJu0YzzFFufXa2CV3MYLC4F7i1VHsYvLKmQIc6kcehowQO10WK0hrUo
	g/VFbR6q5GbqeV1WzhHxQD8D3A==
X-Google-Smtp-Source: AGHT+IEeRBgpy6L5tgvl+vCGq75Z6yngTrc/IJp/TT5cDbJOGiyV5Wb/G9KOxM1LcduixL5aaQnq1Q==
X-Received: by 2002:a05:6808:198e:b0:3b8:bd7a:613f with SMTP id bj14-20020a056808198e00b003b8bd7a613fmr19780515oib.53.1703041352617;
        Tue, 19 Dec 2023 19:02:32 -0800 (PST)
Received: from [192.168.0.111] (d-174-140-102-53.fl.cpe.atlanticbb.net. [174.140.102.53])
        by smtp.gmail.com with ESMTPSA id d27-20020a631d5b000000b005b529d633b7sm19915254pgm.14.2023.12.19.19.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 19:02:32 -0800 (PST)
Message-ID: <5169497a-e16c-402c-bbcd-4bdc7d063849@broadcom.com>
Date: Tue, 19 Dec 2023 19:02:27 -0800
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
 <ba679460-827d-40b1-bc78-bcee1c013f36@broadcom.com>
 <20231220010000.y5ybey76xjckvh6y@box.shutemov.name>
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
Autocrypt: addr=alexey.makhalov@broadcom.com; keydata=
 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 EuY0
In-Reply-To: <20231220010000.y5ybey76xjckvh6y@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/19/23 5:00 PM, kirill.shutemov@linux.intel.com wrote:
> On Tue, Dec 19, 2023 at 04:27:51PM -0800, Alexey Makhalov wrote:
>>
>>
>> On 12/19/23 3:23 PM, kirill.shutemov@linux.intel.com wrote:
>>> On Tue, Dec 19, 2023 at 01:57:51PM -0800, Alexey Makhalov wrote:
>>>> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
>>>> index 3aa1adaed18f..ef07ab7a07e1 100644
>>>> --- a/arch/x86/kernel/cpu/vmware.c
>>>> +++ b/arch/x86/kernel/cpu/vmware.c
>>>> @@ -428,6 +428,30 @@ static bool __init vmware_legacy_x2apic_available(void)
>>>>    		(eax & BIT(VCPU_LEGACY_X2APIC));
>>>>    }
>>>> +#ifdef CONFIG_INTEL_TDX_GUEST
>>>> +unsigned long vmware_tdx_hypercall(unsigned long cmd,
>>>> +				   struct tdx_module_args *args)
>>>> +{
>>>> +	if (!hypervisor_is_type(X86_HYPER_VMWARE))
>>>> +		return 0;
> 
> BTW, don't you want to warn here to? We don't expect vmware hypercalls to
> be called by non-vmware guest, do we?

The answer is below...

> 
>>>> +
>>>> +	if (cmd & ~VMWARE_CMD_MASK) {
>>>> +		pr_warn("Out of range command %x\n", cmd);
>>>> +		return 0;
>>>
>>> Is zero success? Shouldn't it be an error?
>>
>> VMware hypercalls do not have a standard way of signalling an error.
>> To generalize expectations from the caller perspective of any existing
>> hypercalls: error (including hypercall is not supported or disabled) is when
>> return value is 0 and out1/2 are unchanged or equal to in1/in2.
> 
> You are talking about signaling errors over hypercall transport. But if
> kernel can see that something is wrong why cannot it signal the issue
> clearly to caller. It is going to be in-kernel convention.These "return 0" blocks were introduced to protect against non-vmware 
guest or arbitrary modules trying to use __tdx_hypercall via exported 
vmware_tdx_hypercall function. In this case, it will be NOOP behavior 
with no or minor side effects.

 From valid vmware_hypercall callers point of view, there is no such 
thing as a hypercall not available. Once guest detection code recognizes 
VMWare hypervisor via cpuid, it will start using hypercalls in 
accordance to per-call API.

Valid VMware guest code will never go into first return, no warning 
required.
Second return can be hit in rare cases for example during development 
phase, or, hypothetical case, when cmd was dynamically generated.
That's why we have a warning warning only for the second condition.

While speaking about it, I'm started to lean towards your 
recommendation. Yes, we can return standard error code such as -EINVAL 
or just -1 instead of "return 0" in this function. And it will be 
algorithmically correct. As if Vmware guest caller provide out of range 
cmd - it is not documented behavior.

Speaking of additional in-kernel convention for passing additional 
parameter if error happens, it does not makes sense for me because:
1. existing caller codes analyze output argument to recognize error 
error response from the hypervisor. Adding one additional check for 
in-kernel errors just for TDX path which will be never hit by valid code 
in production is an unnecessary overhead.
2. It will definitely add an overhead as an error code will require one 
more output value, or out0 should be moved from return in-register value 
to return by pointer function argument.

Summarizing, overloading vmware_tdx_hypercall return value by arg0 (from 
the hypervisor) and kernel error (-1 or any other) seems like reasonable 
change.

> 
> And to very least, it has to be pr_warn_once().
> 
Good catch! Will change it.

Thanks,
--Alexey

