Return-Path: <linux-kernel+bounces-67841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A40538571B4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32BD61F2370C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF8B145FEF;
	Thu, 15 Feb 2024 23:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="eO8kA/v4"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E718053362;
	Thu, 15 Feb 2024 23:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040365; cv=none; b=ZQi61fatgJkAgiRJXIFfeb/0qb2rA5/lfVRFKDDu8Iam3HV4WQjkiENGTho+NilHR8ZO3z2hnhb81t3XYnC1fJkp0Pgd+jUGu09olyuwSZrDajxbOFyd4vAOPvl++nXWxlE8gqoTX0KULbmIpu9/0gZThN5lObDpYJaSvmzCsAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040365; c=relaxed/simple;
	bh=eQxomNVfWWrzdgxqJHK578iWgPvpAddY5NiTfq6HaqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uwg1fLUCfkF21V6vK2bvNuVqVP/UKUdhN0pgvYT+iYaVWWUv/9XERee5TYFP0b9jjyNtZOjm1QBqVREXZCTmSxEDz1cfKD9dCakConn5TXWkJMAI+51l7eMVIdaj8hz58j0FDWHphz504dKV/enJcyajKASCctcPWYBFYyX9xTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=eO8kA/v4; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id C431F600D7;
	Thu, 15 Feb 2024 23:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1708040360;
	bh=eQxomNVfWWrzdgxqJHK578iWgPvpAddY5NiTfq6HaqM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eO8kA/v4+8nXr5onGAkqPI/kSCzCCvfHJDF2KhF0KWzQxwho/45G0JBuXIYcR9n5Z
	 gV+DArGInYiw2AIha3jrBhaQA+2UmlEK8pZFcxiju3+5FxbyxeVP/Lx7zhtSj2XePM
	 i93PU6Ii50ZU/33LEslZhmHUEyTPhcBO63zzAaxb+61HtMHvq9JyYNnXCHyD/IJHNH
	 jRDr8+2ic+44USbaAqmXxPFKa55eXielNhn4Oirt16g6weyoC7qBwGCF+bxSfQEidr
	 LzNielHJqRAKgJqg8uOri/f3QKf/G15ou3IrNU0d9lYBtm3QbIu8NAuFRa0vrFnEaF
	 0WBGzaPbX4mOw==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 978AC200338;
	Thu, 15 Feb 2024 23:34:02 +0000 (UTC)
Message-ID: <a4798b5d-1a8a-41ab-842f-52e8c7ac00ed@fiberby.net>
Date: Thu, 15 Feb 2024 23:34:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: sched: cls_api: add skip_sw counter
Content-Language: en-US
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, llu@fiberby.dk, Vlad Buslov
 <vladbu@nvidia.com>, Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240215160458.1727237-1-ast@fiberby.net>
 <20240215160458.1727237-2-ast@fiberby.net>
 <CAM0EoMndBjwC8Otx6th_dM_aV_r80NeLEke9C8PwzGt1q3vAMA@mail.gmail.com>
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <CAM0EoMndBjwC8Otx6th_dM_aV_r80NeLEke9C8PwzGt1q3vAMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jamal,

Thank you for the review.

On 2/15/24 17:39, Jamal Hadi Salim wrote:
> +Cc Vlad and Marcelo..
> 
> On Thu, Feb 15, 2024 at 11:06 AM Asbjørn Sloth Tønnesen <ast@fiberby.net> wrote:
>>
>> Maintain a count of skip_sw filters.
>>
>> This counter is protected by the cb_lock, and is updated
>> at the same time as offloadcnt.
>>
>> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
>> ---
>>   include/net/sch_generic.h | 1 +
>>   net/sched/cls_api.c       | 4 ++++
>>   2 files changed, 5 insertions(+)
>>
>> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
>> index 934fdb977551..46a63d1818a0 100644
>> --- a/include/net/sch_generic.h
>> +++ b/include/net/sch_generic.h
>> @@ -476,6 +476,7 @@ struct tcf_block {
>>          struct flow_block flow_block;
>>          struct list_head owner_list;
>>          bool keep_dst;
>> +       atomic_t skipswcnt; /* Number of skip_sw filters */
>>          atomic_t offloadcnt; /* Number of oddloaded filters */
> 
> For your use case is skipswcnt ever going to be any different than offloadcnt?

No, we only use skip_sw filters, since we only use TC as a control path to
install skip_sw rules into hardware.

AFAICT offloadcnt is the sum of skip_sw filters, and filters with no flags which
have implicitly been offloaded.

The reason that I didn't just use offloadcnt, is that I'm not sure if it is
acceptable to treat implicitly offloaded rules without skip_sw, as if they were
explicitly skip_sw. It sounds reasonable, given that the filters without skip_* flags
shouldn't really care.

I tried to only trigger the TC bypass, in the cases that I was absolutely sure would
be safe as a first step.


> 
> cheers,
> jamal
> 
>>          unsigned int nooffloaddevcnt; /* Number of devs unable to do offload */
>>          unsigned int lockeddevcnt; /* Number of devs that require rtnl lock. */
>> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
>> index ca5676b2668e..397c3d29659c 100644
>> --- a/net/sched/cls_api.c
>> +++ b/net/sched/cls_api.c
>> @@ -3483,6 +3483,8 @@ static void tcf_block_offload_inc(struct tcf_block *block, u32 *flags)
>>          if (*flags & TCA_CLS_FLAGS_IN_HW)
>>                  return;
>>          *flags |= TCA_CLS_FLAGS_IN_HW;
>> +       if (tc_skip_sw(*flags))
>> +               atomic_inc(&block->skipswcnt);
>>          atomic_inc(&block->offloadcnt);
>>   }
>>
>> @@ -3491,6 +3493,8 @@ static void tcf_block_offload_dec(struct tcf_block *block, u32 *flags)
>>          if (!(*flags & TCA_CLS_FLAGS_IN_HW))
>>                  return;
>>          *flags &= ~TCA_CLS_FLAGS_IN_HW;
>> +       if (tc_skip_sw(*flags))
>> +               atomic_dec(&block->skipswcnt);
>>          atomic_dec(&block->offloadcnt);
>>   }
>>
>> --
>> 2.43.0
>>

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

