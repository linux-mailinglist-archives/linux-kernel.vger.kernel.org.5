Return-Path: <linux-kernel+bounces-98732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEBF877E82
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0A71F210CD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3F038DEC;
	Mon, 11 Mar 2024 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dZlizvyf"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDC61B599;
	Mon, 11 Mar 2024 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154760; cv=none; b=A+HOnEvhxL/liMycZFMpdSeAvSwVgG9bvsRwg2dGFktOdRBJuq64412GD2IPPx91gEtEfI3Opo5RncRqvtUJ0phDEjJ2dlehORuSKq9i4Q8VZUJL73hdkhvYoedWgpFiCkcLGFi91BMsQ/cHcSPQMFMZY9hT82C6qMYEm2l485k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154760; c=relaxed/simple;
	bh=oXZqPOZ6YIXTm+WG3dgEh3MLHaLjbWnhRyHghOoWAP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrzIhkU0DyA6/bxcjE/055hVZQouSDQNYK0sZzXliOAa8Haq3AbJfJnkT3lTQW5zssiQFj38v0Y8QZV6PMwxGz0Ji4LDX24paWfmx1fIyc9msqyPIlZT+ukQd92uyTGraCDdf2FdQGfKccelRU3gs9GcERXwJAgf+H0uBZkLcqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dZlizvyf; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710154754; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IcfjheDQ5kV24cq9Mvp8h+viyjO4uKlMJPaqsPHtqgU=;
	b=dZlizvyfLA2e1s/alWGuZ0mTpSw7DUtdEV/KI3y1q0K0tVdZeRMz4E4YeN3cdxtSVGcY46dg4c8MOaIbe0Pm4086Q1npZK1ykfq8SeElZjf+93i7Jes+9JWmZWmEJ5LSSXJuN4SgfV6bmzWUmzcaYzWoobamLobiokJSnWqm6bQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W2FTvzX_1710154752;
Received: from 30.221.129.118(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W2FTvzX_1710154752)
          by smtp.aliyun-inc.com;
          Mon, 11 Mar 2024 18:59:13 +0800
Message-ID: <d145d2c7-5cbd-4da5-be14-b25d00baad19@linux.alibaba.com>
Date: Mon, 11 Mar 2024 18:59:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] net/smc: Avoid -Wflex-array-member-not-at-end
 warnings
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Jan Karcher <jaka@linux.ibm.com>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Wenjia Zhang <wenjia@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Kees Cook <keescook@chromium.org>
References: <ZeIhOT44ON5rjPiP@neat>
 <71aa847b-2edc-44a2-beb7-3610bf744937@linux.alibaba.com>
 <1cb9a110-c877-4420-9b23-1e7980f1300a@linux.ibm.com>
 <82c1dc9e-d5b6-40e3-9d81-d18cc270724b@embeddedor.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <82c1dc9e-d5b6-40e3-9d81-d18cc270724b@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/3/8 07:46, Gustavo A. R. Silva wrote:
> 
> 
> On 3/7/24 02:17, Jan Karcher wrote:
>>
>>
>> On 04/03/2024 10:00, Wen Gu wrote:
>>>
>>>
>>> On 2024/3/2 02:40, Gustavo A. R. Silva wrote:
>>>> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
>>>> ready to enable it globally.
>>>>
>>>> There are currently a couple of objects in `struct smc_clc_msg_proposal_area`
>>>> that contain a couple of flexible structures:
>>>>
>>
>> Thank you Gustavo for the proposal.
>> I had to do some reading to better understand what's happening and how your patch solves this.
>>
>>>> struct smc_clc_msg_proposal_area {
>>>>     ...
>>>>     struct smc_clc_v2_extension             pclc_v2_ext;
>>>>     ...
>>>>     struct smc_clc_smcd_v2_extension        pclc_smcd_v2_ext;
>>>>     ...
>>>> };
>>>>
>>>> So, in order to avoid ending up with a couple of flexible-array members
>>>> in the middle of a struct, we use the `struct_group_tagged()` helper to
>>>> separate the flexible array from the rest of the members in the flexible
>>>> structure:
>>>>
>>>> struct smc_clc_smcd_v2_extension {
>>>>          struct_group_tagged(smc_clc_smcd_v2_extension_hdr, hdr,
>>>>                              u8 system_eid[SMC_MAX_EID_LEN];
>>>>                              u8 reserved[16];
>>>>          );
>>>>          struct smc_clc_smcd_gid_chid gidchid[];
>>>> };
>>>>
>>>> With the change described above, we now declare objects of the type of
>>>> the tagged struct without embedding flexible arrays in the middle of
>>>> another struct:
>>>>
>>>> struct smc_clc_msg_proposal_area {
>>>>          ...
>>>>          struct smc_clc_v2_extension_hdr        pclc_v2_ext;
>>>>          ...
>>>>          struct smc_clc_smcd_v2_extension_hdr    pclc_smcd_v2_ext;
>>>>          ...
>>>> };
>>>>
>>>> We also use `container_of()` when we need to retrieve a pointer to the
>>>> flexible structures.
>>>>
>>>> So, with these changes, fix the following warnings:
>>>>
>>>> In file included from net/smc/af_smc.c:42:
>>>> net/smc/smc_clc.h:186:49: warning: structure containing a flexible array member is not at the end of another 
>>>> structure [-Wflex-array-member-not-at-end]
>>>>    186 |         struct smc_clc_v2_extension             pclc_v2_ext;
>>>>        |                                                 ^~~~~~~~~~~
>>>> net/smc/smc_clc.h:188:49: warning: structure containing a flexible array member is not at the end of another 
>>>> structure [-Wflex-array-member-not-at-end]
>>>>    188 |         struct smc_clc_smcd_v2_extension pclc_smcd_v2_ext;
>>>>        |                                                 ^~~~~~~~~~~~~~~~
>>>>
>>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>>> ---
>>>>   net/smc/smc_clc.c |  5 +++--
>>>>   net/smc/smc_clc.h | 24 ++++++++++++++----------
>>>>   2 files changed, 17 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
>>>> index e55026c7529c..3094cfa1c458 100644
>>>> --- a/net/smc/smc_clc.c
>>>> +++ b/net/smc/smc_clc.c
>>>> @@ -853,8 +853,9 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
>>>>       pclc_smcd = &pclc->pclc_smcd;
>>>>       pclc_prfx = &pclc->pclc_prfx;
>>>>       ipv6_prfx = pclc->pclc_prfx_ipv6;
>>>> -    v2_ext = &pclc->pclc_v2_ext;
>>>> -    smcd_v2_ext = &pclc->pclc_smcd_v2_ext;
>>>> +    v2_ext = container_of(&pclc->pclc_v2_ext, struct smc_clc_v2_extension, _hdr);
>>>> +    smcd_v2_ext = container_of(&pclc->pclc_smcd_v2_ext,
>>>> +                   struct smc_clc_smcd_v2_extension, hdr);
>>>>       gidchids = pclc->pclc_gidchids;
>>>>       trl = &pclc->pclc_trl;
>>>> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
>>>> index 7cc7070b9772..5b91a1947078 100644
>>>> --- a/net/smc/smc_clc.h
>>>> +++ b/net/smc/smc_clc.h
>>>> @@ -134,12 +134,14 @@ struct smc_clc_smcd_gid_chid {
>>>>                */
>>>>   struct smc_clc_v2_extension {
>>>> -    struct smc_clnt_opts_area_hdr hdr;
>>>> -    u8 roce[16];        /* RoCEv2 GID */
>>>> -    u8 max_conns;
>>>> -    u8 max_links;
>>>> -    __be16 feature_mask;
>>>> -    u8 reserved[12];
>>>> +    struct_group_tagged(smc_clc_v2_extension_hdr, _hdr,
>>>> +        struct smc_clnt_opts_area_hdr hdr;
>>>> +        u8 roce[16];        /* RoCEv2 GID */
>>>> +        u8 max_conns;
>>>> +        u8 max_links;
>>>> +        __be16 feature_mask;
>>>> +        u8 reserved[12];
>>>> +    );
>>>>       u8 user_eids[][SMC_MAX_EID_LEN];
>>>>   };
>>>> @@ -159,8 +161,10 @@ struct smc_clc_msg_smcd {    /* SMC-D GID information */
>>>>   };
>>>>   struct smc_clc_smcd_v2_extension {
>>>> -    u8 system_eid[SMC_MAX_EID_LEN];
>>>> -    u8 reserved[16];
>>>> +    struct_group_tagged(smc_clc_smcd_v2_extension_hdr, hdr,
>>>> +        u8 system_eid[SMC_MAX_EID_LEN];
>>>> +        u8 reserved[16];
>>>> +    );
>>>>       struct smc_clc_smcd_gid_chid gidchid[];
>>>>   };
>>>> @@ -183,9 +187,9 @@ struct smc_clc_msg_proposal_area {
>>>>       struct smc_clc_msg_smcd            pclc_smcd;
>>>>       struct smc_clc_msg_proposal_prefix    pclc_prfx;
>>>>       struct smc_clc_ipv6_prefix pclc_prfx_ipv6[SMC_CLC_MAX_V6_PREFIX];
>>>> -    struct smc_clc_v2_extension        pclc_v2_ext;
>>>> +    struct smc_clc_v2_extension_hdr        pclc_v2_ext;
>>>>       u8            user_eids[SMC_CLC_MAX_UEID][SMC_MAX_EID_LEN];
>>>> -    struct smc_clc_smcd_v2_extension    pclc_smcd_v2_ext;
>>>> +    struct smc_clc_smcd_v2_extension_hdr    pclc_smcd_v2_ext;
>>>>       struct smc_clc_smcd_gid_chid
>>>>                   pclc_gidchids[SMCD_CLC_MAX_V2_GID_ENTRIES];
>>>>       struct smc_clc_msg_trail        pclc_trl;
>>>
>>> Thank you! Gustavo. This patch can fix this warning well, just the name
>>> '*_hdr' might not be very accurate, but I don't have a good idea ATM.
>>
>> I agree. Should we chose this option we should come up for a better name.
>>
>>>
>>> Besides, I am wondering if this can be fixed by moving
>>> user_eids of smc_clc_msg_proposal_area into smc_clc_v2_extension,
>>> and
>>> pclc_gidchids of smc_clc_msg_proposal_area into smc_clc_smcd_v2_extension.
>>>
>>> so that we can avoid to use the flexible-array in smc_clc_v2_extension
>>> and smc_clc_smcd_v2_extension.
>>
>> I like the idea and put some thought into it. The only thing that is not perfectly clean IMO is the following:
>> By the current definition it is easily visible that we are dealing with a variable sized array. If we move them into 
>> the structs one could think they are always at their MAX size which they are not.
>> E.g.: An incoming proposal can have 0 UEIDs indicated by the eid_cnt.
>> That said nothing a comment can't fix.
>>
>>  From what i have seen the offset and length calculations regarding the "real" size of those structs is fine with your 
>> proposal.
>>
>> Can you verify that your changes also resolve the warnings?
> 
> I can confirm that the changes Wen Gu is proposing also resolve the warnings.
> 
> Wen,
> 
> If you send a proper patch, you can include the following tags:
> 
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Build-tested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 

Hi Gustavo, thank you for the confirmation that my proposal can fix the warning.

But I found that I may have something missed in my proposal when I think further.
My proposal changed the sizes of struct smc_clc_v2_extension and smc_clc_smcd_v2_extension,
and some places in SMC need them, such as the fill of kvec in smc_clc_send_proposal().

So my proposal may involve more changes to current SMC code, and I think it is
not as clean as your solution. So I perfer yours now.

And as for the name, I think maybe we can use '*_elems' as a suffix, at least it
is unambiguous. So it will be smc_clc_v2_extension_elems and smc_clc_smcd_v2_extension_elems.


Jan, what do you think of the name '*_elems' ?

Thanks!

> Thanks!
> -- 
> Gustavo
> 
>>
>> [...]
>>
>>>   };
>>>
>>>
>>> Thanks!
>>> Wen Gu
>>
>> Thanks you
>> - Jan

