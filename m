Return-Path: <linux-kernel+bounces-96368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB98875B33
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8032283304
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B508A481B4;
	Thu,  7 Mar 2024 23:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="gf4QFrwz"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB79E3309C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 23:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709855213; cv=none; b=bYkHEfnxs2Ht/4ig8zCbx8Hc/7LOcVx42bHPOOmDOUDLpE1v4NLkZjuEsafiso58vqU35xzmlRzSJpqRasrvx7kZSTp1fUgT/RUCz15ak5+BvaGQQMpkMgut5k2T70/ba+EbrNwU6VIzxm6LnvIObihIa2oBrS73G6FnEncE+lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709855213; c=relaxed/simple;
	bh=wF6nOFCqocpsBSgk2lYQp+fzFod97LPq/8M/FHS/q0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGGYYXqjLa82QxKn9YQ+QD6KQIsEFtkdyenZw9GzaPbXcYqi15OFBZhfYYV070V2iylBIV5/FDYMEFFFC4qS9jcbuxUTYoW9h2R5jz6eKhoaE5x+i1la1dxQ5UxVqbOxuDcNqYIP5wuUGSBAA9iW5/MXEHIU8/uoUacripxkoxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=gf4QFrwz; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id iJjRrNlTRuh6siNRkrheox; Thu, 07 Mar 2024 23:46:45 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id iNRkrPD0ezugMiNRkriSwk; Thu, 07 Mar 2024 23:46:44 +0000
X-Authority-Analysis: v=2.4 cv=NePg1XD4 c=1 sm=1 tr=0 ts=65ea51e4
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=_DmBcgav1riKsY_yCuwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7z7q2oC1uoCR6VrsF8fDkT9utXrmRySUy35G6DBhC1U=; b=gf4QFrwz4lDtNHm7liWxG8HSKB
	vgRIhxQ9/oZkTzEJNqtoFlrcqyEatYSfZUTcuA0wZzejMZ4n7B1WvF6Kz5EhWTbYc0nZgsynniLAm
	rUjD3tds3mZCQQBsHgRGgk5D+SdDSOEhEiuYTqjyX/e/+iuGT0rbr3iUtAByIgHN/hrw+hxPHzd+n
	RIxz8JLIsBvGm/LMb30T3g+nXSHNSQPV8V1WIDK/mfj+DXRifkWZOFg0S0dbKADGqThapGSupPGcp
	FGp+8jgaS0DynQFlkPpwJbvoKny/GBmmfON9iH31qx6sCCjycJr9EzmqO3KvurdmfNKm04GEgl0Rd
	hUgWAd2g==;
Received: from [201.172.172.225] (port=50666 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1riNRi-000vqt-1f;
	Thu, 07 Mar 2024 17:46:42 -0600
Message-ID: <82c1dc9e-d5b6-40e3-9d81-d18cc270724b@embeddedor.com>
Date: Thu, 7 Mar 2024 17:46:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] net/smc: Avoid -Wflex-array-member-not-at-end
 warnings
Content-Language: en-US
To: Jan Karcher <jaka@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Wenjia Zhang <wenjia@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Tony Lu <tonylu@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Kees Cook <keescook@chromium.org>
References: <ZeIhOT44ON5rjPiP@neat>
 <71aa847b-2edc-44a2-beb7-3610bf744937@linux.alibaba.com>
 <1cb9a110-c877-4420-9b23-1e7980f1300a@linux.ibm.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <1cb9a110-c877-4420-9b23-1e7980f1300a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.172.225
X-Source-L: No
X-Exim-ID: 1riNRi-000vqt-1f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.172.225]:50666
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJyZMNw9gmJyFZSp+bJmqLv0ZfUpU0s2HhEPrrbP7TGxasOCJecSsWYeVKbuBaMqJP7WxYz3jVXg40g6+1jJJ0uO0GY6GDbwN9G8YHwV9AsvL3T7n8/H
 lXELtJ4nD57Z8GlTI2DV/ttnjjoVTFCrRuSeX89YDGzNZsI8DN9zwtpKOTPHNzabqAw0Wg8ImLO+fBKTnxrHq7AECeuMJecu5NTJdRJqGsBdFX/bwChSK0gi



On 3/7/24 02:17, Jan Karcher wrote:
> 
> 
> On 04/03/2024 10:00, Wen Gu wrote:
>>
>>
>> On 2024/3/2 02:40, Gustavo A. R. Silva wrote:
>>> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
>>> ready to enable it globally.
>>>
>>> There are currently a couple of objects in `struct smc_clc_msg_proposal_area`
>>> that contain a couple of flexible structures:
>>>
> 
> Thank you Gustavo for the proposal.
> I had to do some reading to better understand what's happening and how your patch solves this.
> 
>>> struct smc_clc_msg_proposal_area {
>>>     ...
>>>     struct smc_clc_v2_extension             pclc_v2_ext;
>>>     ...
>>>     struct smc_clc_smcd_v2_extension        pclc_smcd_v2_ext;
>>>     ...
>>> };
>>>
>>> So, in order to avoid ending up with a couple of flexible-array members
>>> in the middle of a struct, we use the `struct_group_tagged()` helper to
>>> separate the flexible array from the rest of the members in the flexible
>>> structure:
>>>
>>> struct smc_clc_smcd_v2_extension {
>>>          struct_group_tagged(smc_clc_smcd_v2_extension_hdr, hdr,
>>>                              u8 system_eid[SMC_MAX_EID_LEN];
>>>                              u8 reserved[16];
>>>          );
>>>          struct smc_clc_smcd_gid_chid gidchid[];
>>> };
>>>
>>> With the change described above, we now declare objects of the type of
>>> the tagged struct without embedding flexible arrays in the middle of
>>> another struct:
>>>
>>> struct smc_clc_msg_proposal_area {
>>>          ...
>>>          struct smc_clc_v2_extension_hdr        pclc_v2_ext;
>>>          ...
>>>          struct smc_clc_smcd_v2_extension_hdr    pclc_smcd_v2_ext;
>>>          ...
>>> };
>>>
>>> We also use `container_of()` when we need to retrieve a pointer to the
>>> flexible structures.
>>>
>>> So, with these changes, fix the following warnings:
>>>
>>> In file included from net/smc/af_smc.c:42:
>>> net/smc/smc_clc.h:186:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>>    186 |         struct smc_clc_v2_extension             pclc_v2_ext;
>>>        |                                                 ^~~~~~~~~~~
>>> net/smc/smc_clc.h:188:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>>    188 |         struct smc_clc_smcd_v2_extension pclc_smcd_v2_ext;
>>>        |                                                 ^~~~~~~~~~~~~~~~
>>>
>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> ---
>>>   net/smc/smc_clc.c |  5 +++--
>>>   net/smc/smc_clc.h | 24 ++++++++++++++----------
>>>   2 files changed, 17 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
>>> index e55026c7529c..3094cfa1c458 100644
>>> --- a/net/smc/smc_clc.c
>>> +++ b/net/smc/smc_clc.c
>>> @@ -853,8 +853,9 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
>>>       pclc_smcd = &pclc->pclc_smcd;
>>>       pclc_prfx = &pclc->pclc_prfx;
>>>       ipv6_prfx = pclc->pclc_prfx_ipv6;
>>> -    v2_ext = &pclc->pclc_v2_ext;
>>> -    smcd_v2_ext = &pclc->pclc_smcd_v2_ext;
>>> +    v2_ext = container_of(&pclc->pclc_v2_ext, struct smc_clc_v2_extension, _hdr);
>>> +    smcd_v2_ext = container_of(&pclc->pclc_smcd_v2_ext,
>>> +                   struct smc_clc_smcd_v2_extension, hdr);
>>>       gidchids = pclc->pclc_gidchids;
>>>       trl = &pclc->pclc_trl;
>>> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
>>> index 7cc7070b9772..5b91a1947078 100644
>>> --- a/net/smc/smc_clc.h
>>> +++ b/net/smc/smc_clc.h
>>> @@ -134,12 +134,14 @@ struct smc_clc_smcd_gid_chid {
>>>                */
>>>   struct smc_clc_v2_extension {
>>> -    struct smc_clnt_opts_area_hdr hdr;
>>> -    u8 roce[16];        /* RoCEv2 GID */
>>> -    u8 max_conns;
>>> -    u8 max_links;
>>> -    __be16 feature_mask;
>>> -    u8 reserved[12];
>>> +    struct_group_tagged(smc_clc_v2_extension_hdr, _hdr,
>>> +        struct smc_clnt_opts_area_hdr hdr;
>>> +        u8 roce[16];        /* RoCEv2 GID */
>>> +        u8 max_conns;
>>> +        u8 max_links;
>>> +        __be16 feature_mask;
>>> +        u8 reserved[12];
>>> +    );
>>>       u8 user_eids[][SMC_MAX_EID_LEN];
>>>   };
>>> @@ -159,8 +161,10 @@ struct smc_clc_msg_smcd {    /* SMC-D GID information */
>>>   };
>>>   struct smc_clc_smcd_v2_extension {
>>> -    u8 system_eid[SMC_MAX_EID_LEN];
>>> -    u8 reserved[16];
>>> +    struct_group_tagged(smc_clc_smcd_v2_extension_hdr, hdr,
>>> +        u8 system_eid[SMC_MAX_EID_LEN];
>>> +        u8 reserved[16];
>>> +    );
>>>       struct smc_clc_smcd_gid_chid gidchid[];
>>>   };
>>> @@ -183,9 +187,9 @@ struct smc_clc_msg_proposal_area {
>>>       struct smc_clc_msg_smcd            pclc_smcd;
>>>       struct smc_clc_msg_proposal_prefix    pclc_prfx;
>>>       struct smc_clc_ipv6_prefix pclc_prfx_ipv6[SMC_CLC_MAX_V6_PREFIX];
>>> -    struct smc_clc_v2_extension        pclc_v2_ext;
>>> +    struct smc_clc_v2_extension_hdr        pclc_v2_ext;
>>>       u8            user_eids[SMC_CLC_MAX_UEID][SMC_MAX_EID_LEN];
>>> -    struct smc_clc_smcd_v2_extension    pclc_smcd_v2_ext;
>>> +    struct smc_clc_smcd_v2_extension_hdr    pclc_smcd_v2_ext;
>>>       struct smc_clc_smcd_gid_chid
>>>                   pclc_gidchids[SMCD_CLC_MAX_V2_GID_ENTRIES];
>>>       struct smc_clc_msg_trail        pclc_trl;
>>
>> Thank you! Gustavo. This patch can fix this warning well, just the name
>> '*_hdr' might not be very accurate, but I don't have a good idea ATM.
> 
> I agree. Should we chose this option we should come up for a better name.
> 
>>
>> Besides, I am wondering if this can be fixed by moving
>> user_eids of smc_clc_msg_proposal_area into smc_clc_v2_extension,
>> and
>> pclc_gidchids of smc_clc_msg_proposal_area into smc_clc_smcd_v2_extension.
>>
>> so that we can avoid to use the flexible-array in smc_clc_v2_extension
>> and smc_clc_smcd_v2_extension.
> 
> I like the idea and put some thought into it. The only thing that is not perfectly clean IMO is the following:
> By the current definition it is easily visible that we are dealing with a variable sized array. If we move them into the structs one could think they are always 
> at their MAX size which they are not.
> E.g.: An incoming proposal can have 0 UEIDs indicated by the eid_cnt.
> That said nothing a comment can't fix.
> 
>  From what i have seen the offset and length calculations regarding the "real" size of those structs is fine with your proposal.
> 
> Can you verify that your changes also resolve the warnings?

I can confirm that the changes Wen Gu is proposing also resolve the warnings.

Wen,

If you send a proper patch, you can include the following tags:

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Build-tested-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> 
> [...]
> 
>>   };
>>
>>
>> Thanks!
>> Wen Gu
> 
> Thanks you
> - Jan

