Return-Path: <linux-kernel+bounces-27108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA8582EA9C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD651F2106B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233B211717;
	Tue, 16 Jan 2024 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cJFrTgMk"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CCA11702
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e7065b692so23483935e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 00:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705392109; x=1705996909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bbsGWmQ361n86fqb5EvED9myRmOjNXMpdIrnq7x3pKk=;
        b=cJFrTgMkORcgkjFBgSrgihkujTZOvn0uvYtVN4o2aa174+jRLRx+isopOpMWr88v/x
         BWKogGNwKJmOLSel6w59LvA3LwHJytepwNr+/YmCA/Nsm2P/3Bz5fCBiyZ3gK/jrIcNx
         kToS7GtLEqMiHVP+awFCqMh820N8c/gSl1ZyoNTteo55ko2tFdZ4YWnqewAep3Q/rLpq
         d9ijecfn2G2u8/62DV9yO5qKJFHmuxfMqW3zUcar+7cpI1q058jvTUYDBlsm0E83/7/l
         4oSaimddm8qXQnMUkZUz7xqyjiPckUwZbV1bb55iMh+pb86irohz61o5DPBm+4hfdanK
         XeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705392109; x=1705996909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bbsGWmQ361n86fqb5EvED9myRmOjNXMpdIrnq7x3pKk=;
        b=XUFr7QNwRSHst1B/8gIov92Lo3blFLTfSuG8ItZb+lQ2I8fgfDo32cVQ/eejFWs7rS
         rXnZLntJ6G8DhpE3HqBlpS0udyGaVsSWaBd09Kt+NQmqluUOyKeZDMq4cQfR+878fzjx
         VaoaHA7WkOTIh/mLD9Fs+LcCv0l23uKnBTtHBBw6uLyEHxO3dkiRaF7fr2rahpU5vVKI
         bLIiqqzhFSYncFjMo+ZvcmYbgpv6XQAprHuS/0B+b8Vo2rGv92WXPTCKj9wUAewoHmCx
         +n7Lg/1IVZn6NehPNXnF9V7wxN/mhLNLD12w6KsaeSO02J/wqyDoJcPYiAV15v+nfZ9+
         p3dQ==
X-Gm-Message-State: AOJu0Yy5uHnPv5DwkN8nQCqNl4Y5FFOBfSQP7GmlFPkO12QstX+NAEZK
	kq66vW4G0JTx0LwUWip3Jx8I+qFE6SiAoA==
X-Google-Smtp-Source: AGHT+IHEVDR57nCdsQnrgKWaiuwI6BrlBa+3Gafle4OC07B48/FwRJh/R2OQX6PrvQsuocnkYYxPDw==
X-Received: by 2002:a05:600c:2050:b0:40e:49c4:43c7 with SMTP id p16-20020a05600c205000b0040e49c443c7mr3396133wmg.159.1705392109407;
        Tue, 16 Jan 2024 00:01:49 -0800 (PST)
Received: from ?IPV6:2a10:bac0:b000:7588:4197:afbd:4d31:1a09? ([2a10:bac0:b000:7588:4197:afbd:4d31:1a09])
        by smtp.gmail.com with ESMTPSA id j28-20020a05600c1c1c00b0040e6726befcsm14570130wms.10.2024.01.16.00.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 00:01:49 -0800 (PST)
Message-ID: <bad09d97-d99b-4231-a481-c14ed0f8d59d@suse.com>
Date: Tue, 16 Jan 2024 10:01:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 10/16] x86/tdx: Convert shared memory back to private on
 kexec
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
 "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
 <20231222235209.32143-11-kirill.shutemov@linux.intel.com>
 <89e8722b-661b-4319-8018-06705b366c62@suse.com>
 <20240116072822.pvzseyqry56eqa4j@box.shutemov.name>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240116072822.pvzseyqry56eqa4j@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16.01.24 г. 9:28 ч., Kirill A. Shutemov wrote:

<snip>

>>> @@ -41,6 +44,9 @@
>>>    static atomic_long_t nr_shared;
>>> +static atomic_t conversions_in_progress;
>>> +static bool conversion_allowed = true;
>>
>> Given the usage model of this variable, shouldn't it be simply accessed via
>> READ/WRITE_ONCE macros?
> 
> What do you see it changing?


Serving as documentation that you are accessing a shared variable 
without an explicit lock (unless I'm missing something). 
conversion_allowed can be read by multiple threads, no ? And it's 
written by a single thread?


> 

<snip>

>>> +static void tdx_kexec_stop_conversion(bool crash)
>>> +{
>>> +	/* Stop new private<->shared conversions */
>>> +	conversion_allowed = false;
>>
>> What's the logic behind this compiler barrier?
> 
> Disallow compiler to push the assignment past atomic_read() loop below.
> Not sure if anything else prevents such reorder without the barrier.
> 
> And I don't think WRITE_ONCE() will do the trick. It only prevents
> multiple writes, but doesn't prevent reorders agains accesses
> non-READ_ONCE()/WRITE_ONCE() accesses.
> 
>>> +	barrier();
>>> +
>>> +	/*
>>> +	 * Crash kernel reaches here with interrupts disabled: can't wait for
>>> +	 * conversions to finish.
>>> +	 *
>>> +	 * If race happened, just report and proceed.
>>> +	 */
>>> +	if (!crash) {
>>> +		unsigned long timeout;
>>> +
>>> +		/*
>>> +		 * Wait for in-flight conversions to complete.
>>> +		 *
>>> +		 * Do not wait more than 30 seconds.
>>> +		 */
>>> +		timeout = 30 * USEC_PER_SEC;
>>> +		while (atomic_read(&conversions_in_progress) && timeout--)
>>> +			udelay(1);
>>> +	}
>>> +
>>> +	if (atomic_read(&conversions_in_progress))
>>> +		pr_warn("Failed to finish shared<->private conversions\n");
>>> +}
>>> +
>>
>> <snip>
>>
>>> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
>>> index c9503fe2d13a..3196ff20a29e 100644
>>> --- a/arch/x86/include/asm/x86_init.h
>>> +++ b/arch/x86/include/asm/x86_init.h
>>> @@ -154,6 +154,8 @@ struct x86_guest {
>>>    	int (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
>>>    	bool (*enc_tlb_flush_required)(bool enc);
>>>    	bool (*enc_cache_flush_required)(void);
>>> +	void (*enc_kexec_stop_conversion)(bool crash);
>>> +	void (*enc_kexec_unshare_mem)(void);
>>
>> These are only being initialized in the TDX case, but called in all cases
>> when CC_ATTR_GUEST_MEM_ENCRYPT is true, which includes AMD. So it would
>> cause a crash, no ? Shouldn't you also introduce noop handlers initialized
>> in the default x86_platform struct in arch/x86/kernel/x86_init.c ?
> 
> kexec on AMD will not work without them, I think. But noops makes sense
> anyway. Will fix.

I'm not disputing whether those are needed for AMD or not, that way I 
see it you make those callbacks mandatory in the case of 
CC_ATTR_GUEST_MEM_ENCRYPT being present, yet only implement them for 
TDX. So in the case of AMD they will be NULL and so AMD with kexec 
enabled (albeit erroneously) will crash, no ?

> 

