Return-Path: <linux-kernel+bounces-107079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B807887F749
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46FBB1F226C0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D60B7BAEE;
	Tue, 19 Mar 2024 06:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="C4b7QSIJ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4F74594E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829649; cv=none; b=jxVh35ziJo+7h0vJkjhtSOpwQZW4Bi7SfqsXjy2UIaPTSsYgz+BOSzhAjm/kXr08Fs9U7z4G9KBgdaqP2eyU1hNzEATwflV1OPa2G5woOczGzg2M99NnjPeWugt5SOMl9Lz0Kkpq+mhpNUQdjSlmSRIk7NpN1DIjK8M10XRmCpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829649; c=relaxed/simple;
	bh=s9Npf4BnVmi7B3XVY1acshbD50GVpEXc7ci83JbHTts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xr1DK0VqJCC7HG+1nmvfnz9x65+baMigvES/DujWFvLiLLEo07EYLDnRWEoc6kJmkOQCs5NZetwRfbRHCMI0WP6BgkxeiSyK+na67Jckt9FK0q8pHkQGY3Lms4Xu+/+mMM8UEjefzouMpG4WyyIJKX5eYvBjR+QqCfpyJmYoA84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=C4b7QSIJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dee27acf7aso33357855ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1710829647; x=1711434447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oac/H665Upn99d/GW4a2mZh9auV+zuFrhXx9xokbC9M=;
        b=C4b7QSIJ78Zs8OVIIjlKyBd+fwzTYS7foHjt+5R8NNGM46UJnrOTBPVGEuK2WnFhfi
         j1nnMIov6ASNUVSI1lenVjQoCk5m/O84Qp0hWFM1yITHvGzt5itz0boYu6OWaE0uIlOk
         pa7CYLYQyEtG6xA3TDWTUbxqxbJTmUHt3a2XhCHKcjE2ATd0te9VgXq31TR4vLFycWp0
         xfu+/A1nr34dkcq8oVz3VEswVwNq6S8vK+zUGS3fTVUmUyF2yolBX5Wk8YAc5Ccy3bNp
         FlUn1jxFrP5QvIJDompiBE2BA2S3I5+9hn44fCccNRSn26Xu0bZQ6+IUvZzZF0E/TAiI
         DBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710829647; x=1711434447;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Oac/H665Upn99d/GW4a2mZh9auV+zuFrhXx9xokbC9M=;
        b=VIZ7FgMcZ9Im082pFSs2SFYAoQ832uOLuy8Zi3SanXx8ixZJLCzwJgzosLV2bLAxDS
         X6v3B8TJVDlMegr1eCjfOeBpWZprVGmK6VrRp+OlYfTEb16yQG/xmvu+hzDTuiPm2A0l
         6v9icQxTnceRtS3dbr9HAMcLUnegfr848BR1XEmo5MbaLe/D1maZxVNzU3VUUYEqt+nL
         TdYRYIZXLxTlaI/t12vNnxT6TkbSL3973Xs9Oho4ZgXq60AAYe1yg5thP23tWV6flQxY
         ry2QPxDQJDbRUi0ygrG344ZtalOPtKOQpZ9Hr5DyBBtzcm5h3h4BLZY6k4rDwfEiHdVY
         erzw==
X-Forwarded-Encrypted: i=1; AJvYcCUm4oqC96QZNrfVp5b21HbAhEk60LgW9kkYvLajvNnanXxHUiNEPRx5QpQXgwpjl2zBcuqLg00yc+EOSx39rX8+VVAUpjQDPWN5LVEY
X-Gm-Message-State: AOJu0YxMxeMtc/jm0Zao5gH+AltlOcBeS7UMEJm/FZXd0HTIP8dFpkbj
	qZGii7JexzZ1KYm6sLeU+QXE8A9RQv8GhOaV58njAb3iy/hXJVSyVcl0A4uPkos=
X-Google-Smtp-Source: AGHT+IE+FTHrD+f7KT3cSLTSqyat6zpyuVkiZgNrpvtXJduzhveRWd079fxz4nWY4nbOn6e8qn9uUA==
X-Received: by 2002:a17:902:f80f:b0:1dd:96ca:e1ae with SMTP id ix15-20020a170902f80f00b001dd96cae1aemr12208125plb.69.1710829647650;
        Mon, 18 Mar 2024 23:27:27 -0700 (PDT)
Received: from [10.54.24.74] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db8500b001dd5b86d809sm10416953pld.279.2024.03.18.23.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 23:27:27 -0700 (PDT)
Message-ID: <ed992a7f-7b1d-415d-8d90-1fbb8b619a8c@shopee.com>
Date: Tue, 19 Mar 2024 14:27:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] x86/resctrl: Rename pseudo_lock_event.h to trace.h
To: Reinette Chatre <reinette.chatre@intel.com>, james.morse@arm.com
Cc: fenghua.yu@intel.com, babu.moger@amd.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 peternewman@google.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 corbet@lwn.net, linux-doc@vger.kernel.org
References: <20240308074132.409107-1-haifeng.xu@shopee.com>
 <20240308074132.409107-2-haifeng.xu@shopee.com>
 <f1fd3dbf-a4a3-419e-9092-ff7f9302c874@intel.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <f1fd3dbf-a4a3-419e-9092-ff7f9302c874@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/3/14 06:46, Reinette Chatre wrote:
> Hi Haifeng,
> 
> On 3/7/2024 11:41 PM, Haifeng Xu wrote:
>> Now only pseudo-locking part uses tracepoints to do event tracking, but
>> other parts of resctrl may need new tracepoints. It is unnecessary to
>> create separate header files and define CREATE_TRACE_POINTS in different
>> c files which fragments the resctrl tracing.
>>
>> Therefore, give the resctrl tracepoint header file a generic name to
>> support its use for tracepoints that are not specific to pseudo-locking.
>>
>> No functional change.
>>
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c                   | 2 +-
>>  .../x86/kernel/cpu/resctrl/{pseudo_lock_event.h => trace.h} | 6 +++---
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>  rename arch/x86/kernel/cpu/resctrl/{pseudo_lock_event.h => trace.h} (88%)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>> index 884b88e25141..492c8e28c4ce 100644
>> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>> @@ -31,7 +31,7 @@
>>  #include "internal.h"
>>  
>>  #define CREATE_TRACE_POINTS
>> -#include "pseudo_lock_event.h"
>> +#include "trace.h"
>>  
>>  /*
>>   * The bits needed to disable hardware prefetching varies based on the
>> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h b/arch/x86/kernel/cpu/resctrl/trace.h
>> similarity index 88%
>> rename from arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h
>> rename to arch/x86/kernel/cpu/resctrl/trace.h
>> index 428ebbd4270b..ed5c66b8ab0b 100644
>> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h
>> +++ b/arch/x86/kernel/cpu/resctrl/trace.h
>> @@ -2,7 +2,7 @@
>>  #undef TRACE_SYSTEM
>>  #define TRACE_SYSTEM resctrl
>>  
>> -#if !defined(_TRACE_PSEUDO_LOCK_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#if !defined(_TRACE_RESCTRL_H) || defined(TRACE_HEADER_MULTI_READ)
>>  #define _TRACE_PSEUDO_LOCK_H
> 
> The above #define should match the new name also.

Sorry, I forgot to replace it with 'RESCTRL' in this version.
Thanks for pointing that out!
> 
>>  
>>  #include <linux/tracepoint.h>
>> @@ -35,9 +35,9 @@ TRACE_EVENT(pseudo_lock_l3,
>>  	    TP_printk("hits=%llu miss=%llu",
>>  		      __entry->l3_hits, __entry->l3_miss));
>>  
>> -#endif /* _TRACE_PSEUDO_LOCK_H */
>> +#endif /* _TRACE_RESCTRL_H */
>>  
>>  #undef TRACE_INCLUDE_PATH
>>  #define TRACE_INCLUDE_PATH .
>> -#define TRACE_INCLUDE_FILE pseudo_lock_event
>> +#define TRACE_INCLUDE_FILE trace
>>  #include <trace/define_trace.h>
> 
> The rest looks good.
> 
> Thank you.
> 
> Reinette

