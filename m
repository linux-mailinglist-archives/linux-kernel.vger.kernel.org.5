Return-Path: <linux-kernel+bounces-86392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B67CE86C4C8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB40288434
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9A659171;
	Thu, 29 Feb 2024 09:19:14 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A80B59167
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198354; cv=none; b=DHsLh+24d9ZvKtg+HzGcN6PGkv2P0YsXqjM0wj42Sa041xUYpyoEh4iDXHFz8Bo1Z0yW7dnfCY+zNF4gpfN6KHRwv/QUxtugGoBbaB+iwJ8c58lEvkFIAnKbJlKYQYZ7vPG3+vnALVqkfdBF0d6fx1+wCNLqEHcs6ii4TB2I0xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198354; c=relaxed/simple;
	bh=+X5jIsVq9TVlJLKpu9D7tcU0IrjWTHw9jZoJN8pqMfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gU0m71k6rpWwixhAm/UqpA92kUZkKpEuJ/suhNSqOdkOENCBKOYkaME1EcxLxQ5Lfav5VamjSuSLDKC3VRsyMu+R5tU6R63RDMmHw+3TN3v86cAWdWM9UN4bsj5xmix/W6LqCoM2gWmGEgJ6Gkppuc/WYTKjVWTuczBpRxPanWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-412bf3d52d7so1645365e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:19:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709198351; x=1709803151;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iUEc3ehK7hIKOXIAcNfCmlmcUbE44nOZhgcc+0ww71c=;
        b=UP2QkXKIx97vEPUYu8FjuOy2YJ/sXLxmgUrlZOhRyvCFbasSYu65N58T86VBWFm6f1
         c4nCGFCR3YpuIq5tIFSav/VraWO0iMlCC1lfoi51ld8lETxV97NUT9pBiLCGooUGz9wD
         VhHTEJAonbLbo1Mtav28R6deGdhHpqrVb//Bk4bm997rFrl6C2G1q15lgot9oq/Vh0dd
         ira59duvo2+0EfP6n1KKbHzJx4plV+NkfMfpjB4LlgHIKRc/zXGwMs+v1eDaY5oLYQMz
         9gpXFqIhbt71bx9Y4tVOGtqYMgT1ZuCIgq/jn7cooG2aMg/8y2W4gk7vPR4y7A5jyJ2u
         fExA==
X-Forwarded-Encrypted: i=1; AJvYcCUrRebGyfoL+oB0LbRBiMUBvIrSGXZ4UnkEyfOuhXg4tWhCaaVEjUpkloV2ScPogwp69p6SAXONAakae/jPap3CHaS7n5qF7tDCCmSm
X-Gm-Message-State: AOJu0YzQublUlu/44UvzW5Djeh+0jBktzJbRTk+Zcgwhy52dfku/NNPk
	VPrwNANVZALK/PmCnVR8VljGk0BYaXtgPT2Cjd4csJKJXBRtG+1N
X-Google-Smtp-Source: AGHT+IEE5knZ+zBixlSv2HQWviGB/dsoJoe48/57JNdGedBFBblZG+jjsszG05pexdhclXSLXGC2qw==
X-Received: by 2002:a05:600c:190a:b0:412:ad6e:88cb with SMTP id j10-20020a05600c190a00b00412ad6e88cbmr1302666wmq.36.1709198350669;
        Thu, 29 Feb 2024 01:19:10 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id jn3-20020a05600c6b0300b004128e903b2csm4555754wmb.39.2024.02.29.01.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 01:19:10 -0800 (PST)
Message-ID: <28205b59-50b8-4e05-b267-503179156431@kernel.org>
Date: Thu, 29 Feb 2024 10:19:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/bugs: Use fixed addressing for VERW operand
Content-Language: en-US
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20240226-verw-arg-fix-v1-1-7b37ee6fd57d@linux.intel.com>
 <92440f47-21b7-4f4f-ad99-a99358cfbedf@suse.com>
 <373674e4-cbd0-44d7-98c7-304b0ab4f34b@kernel.org>
 <20240229013924.cksuxebpylyeymzo@desk> <20240229091428.lnbcvhm3udzl5jd5@desk>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240229091428.lnbcvhm3udzl5jd5@desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29. 02. 24, 10:14, Pawan Gupta wrote:
> On Wed, Feb 28, 2024 at 05:39:27PM -0800, Pawan Gupta wrote:
>> On Tue, Feb 27, 2024 at 10:43:53AM +0100, Jiri Slaby wrote:
>>> On 27. 02. 24, 9:47, Nikolay Borisov wrote:
>>>>
>>>>
>>>> On 27.02.24 г. 1:52 ч., Pawan Gupta wrote:
>>>>> Macro used for MDS mitigation executes VERW with relative addressing for
>>>>> the operand. This is unnecessary and creates a problem for backports on
>>>>> older kernels that don't support relocations in alternatives. Relocation
>>>>> support was added by commit 270a69c4485d ("x86/alternative: Support
>>>>> relocations in alternatives"). Also asm for fixed addressing is much
>>>>> more cleaner than relative RIP addressing.
>>>>>
>>>>> Simplify the asm by using fixed addressing for VERW operand.
>>>>>
>>>>> Fixes: baf8361e5455 ("x86/bugs: Add asm helpers for executing VERW")
>>>>> Reported-by: Nikolay Borisov <nik.borisov@suse.com>
>>>>> Closes: https://lore.kernel.org/lkml/20558f89-299b-472e-9a96-171403a83bd6@suse.com/
>>>>> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>>>>> ---
>>>>>    arch/x86/include/asm/nospec-branch.h | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/x86/include/asm/nospec-branch.h
>>>>> b/arch/x86/include/asm/nospec-branch.h
>>>>> index 2aa52cab1e46..ab19c7f1167b 100644
>>>>> --- a/arch/x86/include/asm/nospec-branch.h
>>>>> +++ b/arch/x86/include/asm/nospec-branch.h
>>>>> @@ -323,7 +323,7 @@
>>>>>     * Note: Only the memory operand variant of VERW clears the CPU
>>>>> buffers.
>>>>>     */
>>>>>    .macro CLEAR_CPU_BUFFERS
>>>>> -    ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)),
>>>>> X86_FEATURE_CLEAR_CPU_BUF
>>>>> +    ALTERNATIVE "", __stringify(verw mds_verw_sel),
>>>>> X86_FEATURE_CLEAR_CPU_BUF
>>>>
>>>> Actually thinking about it more and discussing with Jiri (cc'ed), will
>>>> this work with KASLR enabled?
>>>
>>> I might of course be wrong. We appear to rely on the asm+linker here.
>>
>> You were right, with KASLR enabled, instructions with fixed addressing
>> in alternatives don't get relocated. I guess we will have to keep
>> rip-relative as is. Thanks for catching that.
> 
> Looks like this is not settled yet, it was naive of me to trust gdb on
> /proc/kcore earlier with KASLR enabled.
> 
> With the below debug patch it appears the relocation with fixed
> addresses is working as expected with KASLR enabled.

As I wrote already, asm+linker converts the fixed address to rip-rela 
anyway:

https://lore.kernel.org/all/fd8f2df0-563e-4f5c-aca4-bc92a14e9426@kernel.org/

I also raised questions in there:
====
The assembler generates a relocation for the fixed address anyway. And
the linker resolves it as rip-relative. At least the pair from my
binutils-2.42.

But if it generates a rip-relative address, is < 6.5 with no support of
rip-rel in alternatives still fine?

Another question: can we rely on the assembler to generate a relocation
and on the linker to resolve it as rip-relative?
====

thanks,
-- 
js
suse labs


