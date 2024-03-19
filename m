Return-Path: <linux-kernel+bounces-107111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271AD87F79B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBE56B21F6A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8801A50A6B;
	Tue, 19 Mar 2024 06:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="GHoB+bg1"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E564C50279
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710830323; cv=none; b=bTmaOcKocc49QAsetEC97AFtbaQHQk6plpQXWSWemMspmsMO04y/ZQuO7qLUG/QbWMFSJBRssVIoWbAIUQtShBF7f3Wb9HYuo07ZNKWXKfn/K8izHOYJ6vmHhLACssZJ4TdH2xMeNour4kHl4oCiKxHmcjzKQ1x+bJGRvqX9niA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710830323; c=relaxed/simple;
	bh=bjT6FldSxgup/ReK7ge/QkZ76rWQH+EEryHgjYCignU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPH+3vpCIMNgPIMKGkd5TkcJ6inilaxXd1O2YYf4eaAjBTaONfiXgvlG/7LZfLzIEViW1nivGuLZ/O4+7wyt79zLwr+uWoi8bv5+gBxYOQ6CofoYNpHrrcLXS6O5NLwx+o0EWxBJIwMVLLlYwRm0i1JXXdn3+cOmydLm3dy8sDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=GHoB+bg1; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c19aaedfdaso2830555b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1710830321; x=1711435121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noN96cPMD1gNzMjOR5ipD8vWN+vnxx7o9SOW4Qr0LXY=;
        b=GHoB+bg1KDyASOluwJojRwLE3+Uw2RTCn3+cW3f7tTs5PJYiVryr9Hkk/Prq3OAhwE
         PKH3Li7OUujXGo4X2DuYl/cuFnwInrzARp0gdvIXhZWtaGALeokG5l9xLfQgyEroPCN8
         aSHmJioPLDMvKqeu7fKsnbhtTtlAJogtZEkDLDe82Q8eoCHkC43q+E0/D9sXWV0D0XfQ
         C1J+E7j1sv2PW0PCmUzg4Y9jCg5TxIZXRZPDrZonEzY7KP2uFOLxso7eSNde7JDFJP2K
         HyB4IB82Xu85RyLxtTF1VA/RftkpY9wx34uFUeZ4AL58kC/o3c+fZ3NqDwE1qU/L/QOX
         A55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710830321; x=1711435121;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=noN96cPMD1gNzMjOR5ipD8vWN+vnxx7o9SOW4Qr0LXY=;
        b=xAHyDbnOH5/ylac51A9q9+qZCBsxjSN4P0UeOXjzCu0FbyeWPt7IO7i+d/MXw+3vfo
         IVQggY9vN1GBFcHhemgxqm1QiLPBy+QBJD2xkBqB4Io2X+ZoOVuA/Kpey8QVEJ1tcmPz
         n2jZPiYCxm64Cyb39FpVXdIxfpXx5twGYlHiekbpMP2a67QxLpxt7bVhZtrpxGW7Pl9w
         bWQInmiik4BwidvM4pTOJmcMsn9lOwmQg/Dh+dDU0eLdIBSN6sL+xptJEpl9Y2OCrBVl
         Kqn0mVCWYPS9CAnR/Cs4J4RCRYiOE/kD48avd+RhP9tBLC73lqM2/Z6qriU9SgOIvUEb
         lAlg==
X-Forwarded-Encrypted: i=1; AJvYcCXHs5EBviiut6OaIbOBnkNMwT6o8uqrqll9CKxlGk43NSDc7JOEzXK0st8/0AnxTbm4JJ4q8mWEkRGc9bxygcsDo4xKjbzrx+sEVB+Z
X-Gm-Message-State: AOJu0YxGmlZ2e3/lst/jUBhiN+0VopAQzBl70jswaiRlaYXhug4/Up6Y
	2FMvKdr9aihtw/FME0yREE0Kx9rwUOchQa70WOW3dDRjCuUvAHbUp71sGGvu8Ms=
X-Google-Smtp-Source: AGHT+IHzsKZM4qFHtSVqwn9EIQkYsjUTmMcpte765e1uYWoCE9gzpp72gqxxi2N5iYkhz3XcJ9sFdQ==
X-Received: by 2002:a05:6808:ec3:b0:3c2:4cb6:2c99 with SMTP id q3-20020a0568080ec300b003c24cb62c99mr17282795oiv.30.1710830320973;
        Mon, 18 Mar 2024 23:38:40 -0700 (PDT)
Received: from [10.54.24.74] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id q5-20020aa79825000000b006e053e98e1csm8935985pfl.136.2024.03.18.23.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 23:38:40 -0700 (PDT)
Message-ID: <4da41bfd-6949-4f85-bd1c-d1bd0acb9686@shopee.com>
Date: Tue, 19 Mar 2024 14:38:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] x86/resctrl: Add tracepoint for llc_occupancy
 tracking
To: Reinette Chatre <reinette.chatre@intel.com>, james.morse@arm.com
Cc: fenghua.yu@intel.com, babu.moger@amd.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 peternewman@google.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 corbet@lwn.net, linux-doc@vger.kernel.org
References: <20240308074132.409107-1-haifeng.xu@shopee.com>
 <20240308074132.409107-3-haifeng.xu@shopee.com>
 <c8822e06-a3df-4f05-8625-b2bb011887b7@intel.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <c8822e06-a3df-4f05-8625-b2bb011887b7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/3/14 06:47, Reinette Chatre wrote:
> Hi Haifeng,
> 
> On 3/7/2024 11:41 PM, Haifeng Xu wrote:
>> In our production environment, after removing monitor groups, those unused
>> RMIDs get stuck in the limbo list forever because their llc_occupancy are
>> always larger than the threshold. But the unused RMIDs can be successfully
>> freed by turning up the threshold.
>>
>> In order to know how much the threshold should be, perf can be used to
>> acquire the llc_occupancy of RMIDs in each rdt domain.
>>
>> Instead of using perf tool to track llc_occupancy and filter the log
>> manually, it is more convenient for users to use tracepoint to do this
>> work. So add a new tracepoint that shows the llc_occupancy of busy RMIDs
>> when scanning the limbo list.
>>
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>> Suggested-by: James Morse <james.morse@arm.com>
>> Reviewed-by: James Morse <james.morse@arm.com>
>> ---
>>  Documentation/arch/x86/resctrl.rst    |  8 ++++++++
>>  arch/x86/kernel/cpu/resctrl/monitor.c |  9 +++++++++
>>  arch/x86/kernel/cpu/resctrl/trace.h   | 16 ++++++++++++++++
>>  3 files changed, 33 insertions(+)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>> index a6279df64a9d..dd3507dc765c 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -478,6 +478,14 @@ if non-contiguous 1s value is supported. On a system with a 20-bit mask
>>  each bit represents 5% of the capacity of the cache. You could partition
>>  the cache into four equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
>>  
>> +Tracepoint - mon_llc_occupancy_limbo
>> +------------------------------------
> 
> I think that the below paragraph would fit nicely as a new paragraph in the
> existing "max_threshold_occupancy - generic concepts" section. To support that
> just one change to text below ...
> 
>> +This tracepoint gives you the precise occupancy values for a subset of RMID
> 
> The mon_llc_occupancy_limbo tracepoint gives the precise occupancy in bytes
> for a subset of RMID ...
> 

OK, I'll move the descriptions to "max_threshold_occupancy - generic concepts" section.

>> +that are not immediately available for allocation. This can't be relied on
>> +to produce output every second, it may be necessary to attempt to create an
>> +empty monitor group to force an update. Output may only be produced if creation
>> +of a control or monitor group fails.
>> +
>>  Memory bandwidth Allocation and monitoring
>>  ==========================================
>>  
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index c34a35ec0f03..60b6a29a9e29 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -24,6 +24,7 @@
>>  #include <asm/resctrl.h>
>>  
>>  #include "internal.h"
>> +#include "trace.h"
>>  
>>  /**
>>   * struct rmid_entry - dirty tracking for all RMID.
>> @@ -354,6 +355,14 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>>  			rmid_dirty = true;
>>  		} else {
>>  			rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
>> +
>> +			/* x86's CLOSID and RMID are independent numbers, so the entry's
>> +			 * closid is a invalid CLOSID. But on arm64, the RMID value isn't
>> +			 * a unique number for each CLOSID. It's necessary to track both
>> +			 * CLOSID and RMID because there may be dependencies between each
>> +			 * other on some architectures.
>> +			 */
> 
> Please watch for proper formatting of multi-line comment and consistent capitalization.
> I also think comment can be more accurate, for example:
> 
> 	/*
> 	 * x86's CLOSID and RMID are independent numbers, so the entry's
>  	 * CLOSID is an empty CLOSID (X86_RESCTRL_EMPTY_CLOSID). On Arm the
> 	 * RMID (PMG) extends the CLOSID (PARTID) space with bits that aren't used
> 	 * to select the configuration. It is thus necessary to track both
> 	 * CLOSID and RMID because there may be dependencies between them
> 	 * on some architectures.
> 	 */
> 

Thanks for your suggestions!

>> +			trace_mon_llc_occupancy_limbo(entry->closid, entry->rmid, d->id, val);
>>  		}
>>  
>>  		if (force_free || !rmid_dirty) {
>> diff --git a/arch/x86/kernel/cpu/resctrl/trace.h b/arch/x86/kernel/cpu/resctrl/trace.h
>> index ed5c66b8ab0b..b310b4985b94 100644
>> --- a/arch/x86/kernel/cpu/resctrl/trace.h
>> +++ b/arch/x86/kernel/cpu/resctrl/trace.h
>> @@ -35,6 +35,22 @@ TRACE_EVENT(pseudo_lock_l3,
>>  	    TP_printk("hits=%llu miss=%llu",
>>  		      __entry->l3_hits, __entry->l3_miss));
>>  
>> +TRACE_EVENT(mon_llc_occupancy_limbo,
>> +	    TP_PROTO(u32 ctrl_hw_id, u32 mon_hw_id, int domain_id, u64 llc_occupancy_bytes),
>> +	    TP_ARGS(ctrl_hw_id, mon_hw_id, domain_id, llc_occupancy_bytes),
>> +	    TP_STRUCT__entry(__field(u32, ctrl_hw_id)
>> +			     __field(u32, mon_hw_id)
>> +			     __field(int, domain_id)
>> +			     __field(u64, llc_occupancy_bytes)),
>> +	    TP_fast_assign(__entry->ctrl_hw_id = ctrl_hw_id;
>> +			   __entry->mon_hw_id = mon_hw_id;
>> +			   __entry->domain_id = domain_id;
>> +			   __entry->llc_occupancy_bytes = llc_occupancy_bytes;),
>> +	    TP_printk("ctrl_hw_id=%u mon_hw_id=%u domain_d=%d llc_occupancy_bytes=%llu",
> 
> domain_d -> domain_id
> 
>> +		      __entry->ctrl_hw_id, __entry->mon_hw_id, __entry->domain_id,
>> +		      __entry->llc_occupancy_bytes)
>> +	   );
>> +
>>  #endif /* _TRACE_RESCTRL_H */
>>  
>>  #undef TRACE_INCLUDE_PATH
> 
> 
> Reinette

Thanks!

