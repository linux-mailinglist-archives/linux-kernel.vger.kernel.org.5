Return-Path: <linux-kernel+bounces-63887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E958535F9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E38A1C24D88
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD455F87E;
	Tue, 13 Feb 2024 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W3o6sjPQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C3456B65;
	Tue, 13 Feb 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841686; cv=none; b=dT/Uua+9kQuuRoxMb6mzM4jsYGyD5aTE8i/cvXSxOPKLTtMKyzNZgGZ7oHzvkpZbTBoUye8LBk4brJI9Ywfn1C0GK9fVp8R+z1Xg58oNzYyfUrXrvmBwnl/RpNwM18PE94A9ihRq2wQpRsKku7D2jWyX6tt+3NSveFKxRSZkjBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841686; c=relaxed/simple;
	bh=HIv6cOuvk/uI07ixalGc00ruoB4JpP4nHvZzIKqSy7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KNS2ZhxNQvhG38TtNRqYqNFhlTaLZn/YwvE/UmN8IHRAxGfTONzqYX7gpDON5QMEj0Dt5UZ0FMQG7Z9vHFJUuFVXsLhHO/htr0zPM/dx+3QVP3p9kQN3oMxKxBCBo/wu1gQxBoy76X9A7Os+HOlmnXk/3AgEwA4qUBTObUbgD9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W3o6sjPQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41DEbwlZ004674;
	Tue, 13 Feb 2024 16:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gZZNfFALv+w2YYhu1FLg3jywnsLsE9Um5CpTaCn36P4=; b=W3
	o6sjPQVb0GWe+stoSypTUZxJ/M5lmsXA6vRKCyCFKQJjho0rSb1+pYNYBqJYsIoy
	x9CpW75bQX23/bSTEMJ1FHSWPWLJDWmtm6PTV44EUHC5QommThwrImtqRs0n8GnU
	MV3NlFpVne5LMlCW7c88jIWJ33nTdKprDnik7YihurYJaDfljqch3jMwq50R6TM5
	tAZDQbJw31GCZ+Ah4JaePnJI6yEeJm2sUzVNw3upRTWq8bZsNL4+Q2nCrymZUlEV
	7LoFztwANTTQWw7XizRmcew9C+7RgzB6YGKUQb3kjyyWsZptwNBblwsloNjvTCLN
	iIvHl9VRbPjSlvK0cA8w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7hewbbb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 16:27:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41DGRiEB015130
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 16:27:44 GMT
Received: from [10.216.11.8] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 13 Feb
 2024 08:27:39 -0800
Message-ID: <8620c1a0-e091-46e9-418a-db66e621b9c4@quicinc.com>
Date: Tue, 13 Feb 2024 21:57:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm/huge_memory: fix swap entry values of tail pages of
 THP
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>, <vbabka@suse.cz>,
        <dhowells@redhat.com>, <surenb@google.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        # see patch
 description <stable@vger.kernel.org>
References: <1707814102-22682-1-git-send-email-quic_charante@quicinc.com>
 <a683e199-ce8a-4534-a21e-65f2528415a6@redhat.com>
From: Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <a683e199-ce8a-4534-a21e-65f2528415a6@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v8W7XKziphPLBlxM3EVEsOt7amI8esis
X-Proofpoint-ORIG-GUID: v8W7XKziphPLBlxM3EVEsOt7amI8esis
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_09,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130129

Thanks David!!

On 2/13/2024 2:55 PM, David Hildenbrand wrote:
> On 13.02.24 09:48, Charan Teja Kalla wrote:
>> An anon THP page is first added to swap cache before reclaiming it.
>> Initially, each tail page contains the proper swap entry value(stored in
>> ->private field) which is filled from add_to_swap_cache(). After
> 
> This is a stable-only fix? In that case, it make sense to indicate that
> in the patch subject [PATCH STABLE vX.Y].
> 
Noted. Will take care of this from next time.

> But it's always odd to have stable-only fixes, the docs [1] don't cover
> that (maybe they should? or I missed it).
> 
Not sure If the below rules implicitly allows:
 - It or __an equivalent fix__ must already exist in Linus' tree (upstream).
 - It cannot be bigger than 100 lines, with context.

> [1]
> https://www.kernel.org/doc/Documentation/process/stable-kernel-rules.rst>
> So we are migrating a THP that was added to the swapcache. Do you have a
> reproducer?
> 
Yes, a bunch of them can be reproduced daily in our device farm which is
being tested on 6.1.

>> migrating the THP page sitting on the swap cache, only the swap entry of
>> the head page is filled(see folio_migrate_mapping()).
>>
>> Now when this page is tried to split(one case is when this page is again
>> migrated, see migrate_pages()->try_split_thp()), the tail pages
>> ->private is not stored with proper swap entry values.  When this tail
>> page is now try to be freed, as part of it delete_from_swap_cache() is
>> called which operates on the wrong swap cache index and eventually
>> replaces the wrong swap cache index with shadow/NULL value, frees the
>> page.
> 
> But what if we don't split the THP after migration. Is there anything
> else that can go wrong?
> 
> It's sufficient to look where upstream calls page_swap_entry():
> 
> For example, do_swap_page() will never be able to make progress, because
> the swap entry of the page does not correspond to the swap entry in the
> PTE? It can easily fault on a swap PTE that refers a THP subpage in the
> swapcache.
> 
> So unless I am missing something, only fixing this up during the split
> is insufficient. You have to fix it up during migration.
> 

I think you are right....My understanding is that below can make the
do_swap_page() will never be able to make progress:
do_swap_page:
		entry = pte_to_swp_entry(vmf->orig_pte);
		......
                if (unlikely(!folio_test_swapcache(folio) ||
                             page_private(page) != entry.val))
                        goto out_page;

This current patch is posted looking at the series in upstream that
looks simple, but that turn out to be not correct.

BTW, the fix we've tested internally is below discussed in [1].

diff --git a/mm/migrate.c b/mm/migrate.c
index 9f5f52d..8049f4e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -427,10 +427,8 @@ int folio_migrate_mapping(struct address_space
*mapping,
        folio_ref_add(newfolio, nr); /* add cache reference */
        if (folio_test_swapbacked(folio)) {
                __folio_set_swapbacked(newfolio);
-               if (folio_test_swapcache(folio)) {
+               if (folio_test_swapcache(folio))
                        folio_set_swapcache(newfolio);
-                       newfolio->private = folio_get_private(folio);
-               }
                entries = nr;
        } else {
                VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
@@ -446,6 +444,8 @@ int folio_migrate_mapping(struct address_space *mapping,

        /* Swap cache still stores N entries instead of a high-order
entry */
        for (i = 0; i < entries; i++) {
+               set_page_private(folio_page(newfolio, i),
+                               folio_page(folio, i)->private);
                xas_store(&xas, newfolio);
                xas_next(&xas);
        }

[1]
https://lore.kernel.org/linux-mm/69cb784f-578d-ded1-cd9f-c6db04696336@quicinc.com/

>>
>> This leads to the state with a swap cache containing the freed page.
>> This issue can manifest in many forms and the most common thing observed
>> is the rcu stall during the swapin (see mapping_get_entry()).
>>
>> On the recent kernels, this issues is indirectly getting fixed with the
>> series[1], to be specific[2].
>>
>> When tried to back port this series, it is observed many merge
>> conflicts and also seems dependent on many other changes. As backporting
>> to LTS branches is not a trivial one, the similar change from [2] is
>> picked as a fix.
> 
> The fix is in
> 
> commit cfeed8ffe55b37fa10286aaaa1369da00cb88440
> Author: David Hildenbrand <david@redhat.com>
> Date:   Mon Aug 21 18:08:46 2023 +0200
> 
>     mm/swap: stop using page->private on tail pages for THP_SWAP
> 
>>
>> [1] https://lore.kernel.org/all/20230821160849.531668-1-david@redhat.com/
>> [2] https://lore.kernel.org/all/20230821160849.531668-5-david@redhat.com/
>>
>> Closes:
>> https://lore.kernel.org/linux-mm/69cb784f-578d-ded1-cd9f-c6db04696336@quicinc.com/
>> Fixes: 3417013e0d18 ("mm/migrate: Add folio_migrate_mapping()")
>> Cc: <stable@vger.kernel.org> # see patch description, applicable to <=6.1
>> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> 
> 3417013e0d18 went into 5.16.
> 
> cfeed8ffe55b3 went into 6.6.
> 
> So only 6.1 is affected.
> 

I tried to dig why the older kernels don't have this issue. The issue
persists on the older kernels too, AFAICS. See,
migrate_page_move_mapping().

So, The Fixes: tag too is unique for 6.1 kernel. And older LTS kernel
requires different tag it seems..

> 
> Isn't there a way to bite the bullet and backport that series to 6.1
> instead?

My worry is that, because of merge conflicts, not sure If It can end up
in inducing some other issues.

Although we didn't test THP on older kernels, from the code walk, it
seems issue persists to me on older to 6.1 kernel, unless I am missing
something here. So back porting of this series to all those LTS kernels,
may not be a straight forward?

So, I am really not sure of what is the way forward here...
>

Thanks.


