Return-Path: <linux-kernel+bounces-86085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2954086BF5D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2EE1F241BB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE57736B17;
	Thu, 29 Feb 2024 03:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="Jql3TE8E"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A4E364D6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 03:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709176572; cv=none; b=kZ84jG8+HA1TxK/Q9zeVZacZOnVWVTPJuPcT/OtwJuO2hO591xPwKGV7yTmQgWyyuE6XwuRVAbHOeNtJeIRgw4oMdj1wBqNhK5MTwj+Kpw6N04V141J1ZWICi8IwnyaUg/1mEiYr9G+NoxJUC2UhONrVTEg6Tm2vqrp0G8ivG1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709176572; c=relaxed/simple;
	bh=EJZRbPECg0hDD4jIQFJ0zGYFELWwvvLjOzOPcGZulos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sl2CwusyQGeOVDoCOIfvCju7wU/Y8PieFIJBNiYz1LSgGOhNBYMGW6+IfR9Kg6eBFIj/T1KP2NIbzp1ZxU24caXH/BXpdlnqfGzhI88aC2r8xQ99LFheHenN4AJkIPwTJfFYeAh5QlN1hYoJizVZh+yzlmdC1acQ1T9oErrLujM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=Jql3TE8E; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1db6e0996ceso4359375ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1709176568; x=1709781368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHvPtHE9TbunhY9bCDHKeK6IELSH464L5v57KsFpdC8=;
        b=Jql3TE8EO1FXrERSCJZ+KVI3rAmBNHXENn3Ig60BologLnzDCF9NjQUtIXd+UAtDJu
         dqA5Artyao/EQmNCR1kTZMh9Eohl6ooxbMTjRopH7hi0BXmAnulT1mL7tV06XT7xo1va
         8e+1aLfD4bbRvBam4YPbqNnU62wIiSwSli/hiOui0yVy2JDnNF9oFNtdByZszv/t65JL
         McgSHEE94yozB/BBj/cfOn813EB/QSzXpjIwa5MepDDixS/Z+hGj5QZ6+2TZYpD4afR3
         UD6URaf7nuvDWjp9OZ6RbLX6eSry9gtJORCu+N5VVopKTGzyaSp1ijabOX2kQO7iEU3p
         l4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709176568; x=1709781368;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IHvPtHE9TbunhY9bCDHKeK6IELSH464L5v57KsFpdC8=;
        b=Wug2qsNnuFAN/8s1D1IS93SJbX6BKLeb+ODs/YvTB2O2V8qv+mYhlTIj/E+n/IhsuB
         QwwF21HcJ2CfvW04u4pxhWZ8lTgMNBjlfquqgoEDI5/CbT+PcF3THEpGThz5TW4/m2VM
         PumfKhqM51N5729I3on1IpYOIgep5vBeccGXpwfU4teXEKW6vFHlSJQd/5iLfUcpnv2n
         vp71HzuQqTvuC++UJr5s23onXIQzUKLPWNXpIZdXkIh0tIULwYk9QIam3KjQ0AvG56tk
         VOP5O0KSAMmc1Bogb2iDHUV4rQ6XA3utTrjsQZF6LSyPKIgJm/kWS726ViIjqsFB1Apt
         l2dA==
X-Forwarded-Encrypted: i=1; AJvYcCVOymOUipYFmsu5GZsRmYAnJzY9foJlaV3DRiw3DpksfgLdecMVjtrxKoGVNL/3cMz2/NODzhLBI6ublo6iXk3bPuUwL5rCV+dZztnS
X-Gm-Message-State: AOJu0YylP194dzBvOJV0/cqfO5dVCFENYyz5aW1pGqdn4AD/gXXE2fdg
	hvgRFlp6Co3RyKqKV4BJ88NUkKlXcyr3HtkXcsW1xpv61zwUEzG5EOg7L3zL71Y=
X-Google-Smtp-Source: AGHT+IFk3ZeMCvpLvSoaOVIczRtg5SXJQ4rzviuRNgjKTu5cW9r74UB8HwAF53U4iiDkY5eykNGGog==
X-Received: by 2002:a17:903:1104:b0:1dc:ad9c:5099 with SMTP id n4-20020a170903110400b001dcad9c5099mr946688plh.4.1709176568504;
        Wed, 28 Feb 2024 19:16:08 -0800 (PST)
Received: from [10.54.24.74] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902ed0b00b001dcc3b2cde0sm193396pld.264.2024.02.28.19.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 19:16:08 -0800 (PST)
Message-ID: <c06dbac5-f849-4259-b395-83ba1c98c557@shopee.com>
Date: Thu, 29 Feb 2024 11:16:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] x86/resctrl: Add tracepoint for llc_occupancy
 tracking
To: Reinette Chatre <reinette.chatre@intel.com>,
 James Morse <james.morse@arm.com>
Cc: fenghua.yu@intel.com, babu.moger@amd.com, peternewman@google.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
References: <20240221092101.90740-1-haifeng.xu@shopee.com>
 <20240221092101.90740-3-haifeng.xu@shopee.com>
 <371242fb-dce2-4de0-bba9-4d85475d5d9a@intel.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <371242fb-dce2-4de0-bba9-4d85475d5d9a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/2/24 03:41, Reinette Chatre wrote:
> (+James)
> 
> Hi Haifeng and James,
> 
> On 2/21/2024 1:21 AM, Haifeng Xu wrote:
>> In our production environment, after removing monitor groups, those unused
>> RMIDs get stuck in the limbo list forever because their llc_occupancy are
>> always larger than the threshold. But the unused RMIDs can be successfully
>> freed by turning up the threshold.
>>
>> In order to know how much the threshold should be, the following steps can
>> be taken to acquire the llc_occupancy of RMIDs in each rdt domain:
>>
>> 1) perf probe -a '__rmid_read eventid rmid'
>>    perf probe -a '__rmid_read%return $retval'
>> 2) perf record -e probe:__rmid_read -e probe:__rmid_read__return -aR sleep 10
>> 3) perf script > __rmid_read.txt
>> 4) cat __rmid_read.txt | grep "eventid=0x1 " -A 1 | grep "kworker" > llc_occupnacy.txt
>>
> 
> The details on how perf can be used was useful during the discussion of this
> work but can be omitted from this changelog.
 
Got it.

> 
>> Instead of using perf tool to track llc_occupancy and filter the log manually,
>> it is more convenient for users to use tracepoint to do this work. So add a new
>> tracepoint that shows the llc_occupancy of busy RMIDs when scanning the limbo
>> list.
>>
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/monitor.c |  2 ++
>>  arch/x86/kernel/cpu/resctrl/trace.h   | 13 +++++++++++++
>>  2 files changed, 15 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index f136ac046851..1533b1932b49 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -23,6 +23,7 @@
>>  #include <asm/resctrl.h>
>>  
>>  #include "internal.h"
>> +#include "trace.h"
>>  
>>  struct rmid_entry {
>>  	u32				rmid;
>> @@ -302,6 +303,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>>  			}
>>  		}
>>  		crmid = nrmid + 1;
>> +		trace_mon_llc_occupancy_limbo(nrmid, d->id, val);
> 
> This area recently received some changes (you can find the latest on the
> x86/cache branch of the tip repo). Please see [1] for a good
> description of the new "index". For this tracing to be useful to MPAM
> I thus expect that the tracepoint will need to print the MPAM equivalent
> to CLOSID, the PARTID. We can refer to this CLOSID/PARTID value as
> "ctrl_hw_id".
> 
> This snippet can then change to use the new resctrl_arch_rmid_idx_decode()
> to learn the "ctrl_hw_id" and "mon_hw_id" and print it as part of
> tracepoint:
> "ctrl_hw_id=%u mon_hw_id=%u domain=%d llc_occupancy=%llu"

OK, I'll post a new patch based on tip repo.

> 
> This will be filesystem code so it cannot know how an architecture
> treats these numbers. Consequently, this may look strange to x86 users
> when ctrl_hw_id will always be X86_RESCTRL_EMPTY_CLOSID ... but it should
> be clear that it is invalid? 
> 
> James, what do you think? Any thoughts on how MPAM will use the limbo handler
> to understand what information can be useful to the user here?
> 
> Reinette
> 
> [1] https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_lkml_20240213184438.16675-2D7-2Djames.morse-40arm.com_&d=DwICaQ&c=R1GFtfTqKXCFH-lgEPXWwic6stQkW4U7uVq33mt-crw&r=3uoFsejk1jN2oga47MZfph01lLGODc93n4Zqe7b0NRk&m=Grl-QGKKyzz601g4WQFhPFVML6pju3g8CUGyD2VF8r8BUlO_caHlZMafoTxW9iYc&s=ToJ7E8_Afpnn5zh-c-CVReg4WqM-T0pEgB9hN6ntj1A&e= 

