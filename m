Return-Path: <linux-kernel+bounces-149470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276C08A918A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934B51F22801
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403B650A73;
	Thu, 18 Apr 2024 03:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="QivVdbs3"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4386286AF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713410777; cv=none; b=ayECkYohw8AFBCDif99pcleCkk6w7pV0v8lYSCO+l8pPpE77kquvbuNs/xBsyIT4Nu6CxbyjpcIITkNb1ZKj+P17JMesZ9D/kWqJpm9F+N+/OEjDF5WkB5LQ/MWlrYTt4HAFQCqL5GBj+V3BuykIdHFULsUdnp0tsNrSSRpvuno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713410777; c=relaxed/simple;
	bh=KNfQStDglR7kPEh2jWKZCSvCebnvLHoecf23uDfOkIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2Mvo5yp1ya3F8i33XFU9epVpkd4xSyeao5O7Os5s2eL2m+MV+d2Tl4IRH+P4L3aJYOKG4N1CcnA5SeXoA1MqGGrx3pbdrUBRV154RJAbd834a9YXfzDClugSXU0eqU9QSwTvlC/+z1KBePMQ6bAFoG82Xo+rQqRFBMPWTKsD2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=QivVdbs3; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e651a9f3ffso2916775ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1713410775; x=1714015575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFTAjtM3f8h+Urx2x//CqQOtFkuR1kgk8D12m9A+m5E=;
        b=QivVdbs3jDqRolAfz6Q8Z8+phVwTOLrSDQdfxO1xTkreply9ROnzzklBuDAOBESiox
         mIUNlORcw0eD+VHORKjePy89AI9/dxUzj/Lof3ESqW1CQ5BLy3SYH5Prup1zTHiYbxyG
         XEWkoqj2agEvIItvTTzYgkTcErta7sCDrbRJ1JhopVK+76fIlBah1fksqJcpLVsO29RC
         OrAAA9hYKT0Y95XNyEaJu0Mt1wySGL8Fo97WswPxdz/jjLhQbYLxeGiE6n6BzvyKFQRc
         cZQMhUK/nkOjoNUSKF8k56Mr8YKF6lOOn2RT8AEDL7DN8PZzUXwGJjJyaxKTCd5JLZLq
         I/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713410775; x=1714015575;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QFTAjtM3f8h+Urx2x//CqQOtFkuR1kgk8D12m9A+m5E=;
        b=m0uppMhVddWOiG5XWW511Qw66P8Ll+bofCBL73XGLopV+gOUSjhYRwR2/pfye+I3yX
         FsEPmBY0MCufUR0ree1PsEzrVX87hydGpzRDoGSNIGTTrQavCkRn4KiuEWZKjcPzRLUd
         wyZB1NKipoO4L6y+D1Sq7TUO0qS+atTc/K6ZMAr7YwUuyNpzVey/EhDEplXzLjTUYWMW
         qnQPfUmLeLRNQmmD8ta5PIIEdzueLtXQM1ekCwxRYzeqi2AJ5WvX2eCU1yCfVOCHVePY
         n2a+y/8i4n3rOzBwOOYFKl9KKWmN3jac+bm/Fla9MJxY16O9xfkX0Iphm6FHeAWStLDy
         HEtw==
X-Forwarded-Encrypted: i=1; AJvYcCVvUSENxrv6M0Tdsfc9e3g+agnk3SPVtILpA1WQToA+TQF4AQO6K1QnZTY8/T2sqXOf2ubVK1d/i6gGqoHGmTgwXg/PfzlJkEy6MfRD
X-Gm-Message-State: AOJu0Yw6qlsxnIgkAkYyFLfrQX7PJhB173+8oju0gv589AuTACFaUQ7S
	g93i644cB40GQjWZMe+N0rWiHoDlN5CookN2VgTHSxSw0i8uk4fSM3wVzWxSBTE=
X-Google-Smtp-Source: AGHT+IHHs5IjKp87EK4YTz1xuPnPct23eqJRVDf4bTtBn9ITzGm07U0YTYlE6ZFnP/DL8vhc5dygSw==
X-Received: by 2002:a17:902:700c:b0:1e5:28cd:4ef9 with SMTP id y12-20020a170902700c00b001e528cd4ef9mr1436753plk.30.1713410775232;
        Wed, 17 Apr 2024 20:26:15 -0700 (PDT)
Received: from [10.54.24.115] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id w9-20020a1709026f0900b001e20be11688sm410256plk.229.2024.04.17.20.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 20:26:14 -0700 (PDT)
Message-ID: <6af2cb1b-4d93-4fd4-a5f5-0fdf2ae9d759@shopee.com>
Date: Thu, 18 Apr 2024 11:26:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/core: Fix missing wakeup when waiting for context
 reference
To: Frederic Weisbecker <frederic@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240410035506.599192-1-haifeng.xu@shopee.com>
 <Zh_8FpT10qoE-x1u@localhost.localdomain>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <Zh_8FpT10qoE-x1u@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/4/18 00:43, Frederic Weisbecker wrote:
> Le Wed, Apr 10, 2024 at 03:55:06AM +0000, Haifeng Xu a écrit :
>> In our production environment, we found many hung tasks which are
>> blocked for more than 18 hours. Their call traces are like this:
>>
>> [346278.191038] __schedule+0x2d8/0x890
>> [346278.191046] schedule+0x4e/0xb0
>> [346278.191049] perf_event_free_task+0x220/0x270
>> [346278.191056] ? init_wait_var_entry+0x50/0x50
>> [346278.191060] copy_process+0x663/0x18d0
>> [346278.191068] kernel_clone+0x9d/0x3d0
>> [346278.191072] __do_sys_clone+0x5d/0x80
>> [346278.191076] __x64_sys_clone+0x25/0x30
>> [346278.191079] do_syscall_64+0x5c/0xc0
>> [346278.191083] ? syscall_exit_to_user_mode+0x27/0x50
>> [346278.191086] ? do_syscall_64+0x69/0xc0
>> [346278.191088] ? irqentry_exit_to_user_mode+0x9/0x20
>> [346278.191092] ? irqentry_exit+0x19/0x30
>> [346278.191095] ? exc_page_fault+0x89/0x160
>> [346278.191097] ? asm_exc_page_fault+0x8/0x30
>> [346278.191102] entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> The task was waiting for the refcount become to 1, but from the vmcore,
>> we found the refcount has already been 1. It seems that the task didn't
>> get woken up by perf_event_release_kernel() and got stuck forever. The
>> below scenario may cause the problem.
>>
>> Thread A					Thread B
>> ...						...
>> perf_event_free_task				perf_event_release_kernel
>> 						   ...
>> 						   acquire event->child_mutex
>> 						   ...
>> 						   get_ctx
>>    ...						   release event->child_mutex
>>    acquire ctx->mutex
>>    ...
>>    perf_free_event (acquire/release event->child_mutex)
>>    ...
>>    release ctx->mutex
>>    wait_var_event
>> 						   acquire ctx->mutex
>> 						   acquire event->mutex
>> 						   # move existing events to free_list
>> 						   release event->child_mutex
>> 						   release ctx->mutex
>> 						   put_ctx
>> ...						...
>>
>> In this case, all events of the ctx have been freed, so we couldn't
>> find the ctx in free_list and Thread A will miss the wakeup. It's thus
>> necessary to add a wakeup after dropping the reference.
>>
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> ---
>>  kernel/events/core.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 4f0c45ab8d7d..01dfe715f09e 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -5340,6 +5340,8 @@ int perf_event_release_kernel(struct perf_event *event)
>>  again:
>>  	mutex_lock(&event->child_mutex);
>>  	list_for_each_entry(child, &event->child_list, child_list) {
>> +		void *var;
>> +		bool freed = false;
>>  
>>  		/*
>>  		 * Cannot change, child events are not migrated, see the
>> @@ -5380,11 +5382,25 @@ int perf_event_release_kernel(struct perf_event *event)
>>  			 * this can't be the last reference.
>>  			 */
>>  			put_event(event);
>> +		} else {
>> +			freed = true;
>> +			var = &ctx->refcount;
>>  		}
>>  
>>  		mutex_unlock(&event->child_mutex);
>>  		mutex_unlock(&ctx->mutex);
>>  		put_ctx(ctx);
>> +
>> +		if (freed) {
>> +			/*
>> +			 * perf_event_free_task() delete all events of the ctx and
>> +			 * there is no event of the ctx in free_list. It may step
>> +			 * into wait_var_event() before decrement the refcount. So
>> +			 * we should add a wakeup here.
>> +			 */
>> +			smp_mb(); /* pairs with wait_var_event() */
>> +			wake_up_var(var);
>> +		}
>>  		goto again;
> 
> Good catch!
> 
> How about the following slightly simplified version?

Yes. I'll send next verion with your suggestions and add:

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 724e6d7e128f..4082d0161b2b 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5365,6 +5365,7 @@ int perf_event_release_kernel(struct perf_event *event)
>  again:
>  	mutex_lock(&event->child_mutex);
>  	list_for_each_entry(child, &event->child_list, child_list) {
> +		void *var = NULL;
>  
>  		/*
>  		 * Cannot change, child events are not migrated, see the
> @@ -5405,11 +5406,23 @@ int perf_event_release_kernel(struct perf_event *event)
>  			 * this can't be the last reference.
>  			 */
>  			put_event(event);
> +		} else {
> +			var = &ctx->refcount;
>  		}
>  
>  		mutex_unlock(&event->child_mutex);
>  		mutex_unlock(&ctx->mutex);
>  		put_ctx(ctx);
> +
> +		if (var) {
> +			/*
> +			 * If perf_event_free_task() has deleted all events from the
> +			 * ctx while the child_mutex got released above, make sure to
> +			 * notify about the preceding put_ctx().
> +			 */
> +			smp_mb(); /* pairs with wait_var_event() */
> +			wake_up_var(var);
> +		}
>  		goto again;
>  	}
>  	mutex_unlock(&event->child_mutex);
> 
> 
> 
>>  	}
>>  	mutex_unlock(&event->child_mutex);
>> -- 
>> 2.25.1
>>
>>

