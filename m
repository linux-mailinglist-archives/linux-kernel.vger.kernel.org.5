Return-Path: <linux-kernel+bounces-71426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A5585A50D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316D1282772
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09634364D4;
	Mon, 19 Feb 2024 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IoZTuhzQ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880CE364AE
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708350343; cv=none; b=o/Bd4PFaQ5LB9IZJDnufMEgARqkZow6cZoKL+4Su1ptIZ84TQiuXnXr0JbsIWmZjOq/8ImavbiXMBlPkbDFV5USFxmHFEuKkj+co6Vo06JhHhcVbq/Re+s3R0j44LMdYe0QLQtIPapI5qqihKv3kC8sa/mQGErs6r6lUwQWCDn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708350343; c=relaxed/simple;
	bh=6T4E9rKWOU8ABV5ueI7azVASkW23xgjY0SQUFURr2nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qEae14vx9q5KcAXjNR9P3Jl1jnU3qrtfIgPJYQI0fXfcdDlys5F6g0wjezhjZNJvkpgJhwjOM1vXOAnrOrK4FWfiHEJgZv26hP6RCMiHsA34+lEDrO6uatx8PfIXFdlIXbnkZCJ1DIse/UVmFdsikqz55gezWox1y62BCDiHtz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IoZTuhzQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JDUiV5018392;
	Mon, 19 Feb 2024 13:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kSHUGzxff29yhHhKf6lDGRFrLRDsLkZ5PSGlibIxQGk=;
 b=IoZTuhzQnrt0gG/STcYCjEiAWDJ66olxh/Z3abQMOKGtFib/XeglU1GdmDbGC+kPusCD
 il43urJxuZj68VClsRGCwyUHLbx5shDaeSBPu5arnquyph6sXnxq/V5yekeRANKHNIm+
 iYF5IEn9vhAqoaA22HVQOkJm0OrSS5zSDycnUCTX6Esd4mj9Txe46FiM4hLruTsvteGJ
 BIKPbVvdk6aHtzPr+ek0X0cD5VVdVhQ58BS7AqX+eegvglkPItfXYSniu5b1iHDoaXYQ
 Q2zTGaRVE/mX42OHP0hUGlDdB77S3cOwDKaqe+J/TvxB/HOuoNWrJTT7lHyYeVt4f2FF TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wb2p8j2se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 13:45:02 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41JDVMMC020218;
	Mon, 19 Feb 2024 13:45:01 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wb2p8j2rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 13:45:01 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41JBEB75009507;
	Mon, 19 Feb 2024 13:45:00 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84p1g3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 13:45:00 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41JDiv9J22479384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 13:44:59 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5081E5805D;
	Mon, 19 Feb 2024 13:44:57 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 399B258059;
	Mon, 19 Feb 2024 13:44:50 +0000 (GMT)
Received: from [9.109.245.191] (unknown [9.109.245.191])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Feb 2024 13:44:49 +0000 (GMT)
Message-ID: <e7b138a4-de46-4cb6-94b8-67019e0369e9@linux.ibm.com>
Date: Mon, 19 Feb 2024 19:14:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mm/numa_balancing:Allow migrate on protnone reference
 with MPOL_PREFERRED_MANY policy
Content-Language: en-US
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Aneesh Kumar <aneesh.kumar@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen
 <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Ben Widawsky <ben.widawsky@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz
 <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>
References: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
 <8d7737208bd24e754dc7a538a3f7f02de84f1f72.1708097962.git.donettom@linux.ibm.com>
 <ZdNEg_aA0LHJY22T@tiehlicka>
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <ZdNEg_aA0LHJY22T@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q7_9O6cHxUE9y41zZX0BwYNStWROOXN_
X-Proofpoint-GUID: ZIiErT2dAOWutbpSlDer5VN-p2pQW_dr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_09,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190102


On 2/19/24 17:37, Michal Hocko wrote:
> On Sat 17-02-24 01:31:35, Donet Tom wrote:
>> commit bda420b98505 ("numa balancing: migrate on fault among multiple bound
>> nodes") added support for migrate on protnone reference with MPOL_BIND
>> memory policy. This allowed numa fault migration when the executing node
>> is part of the policy mask for MPOL_BIND. This patch extends migration
>> support to MPOL_PREFERRED_MANY policy.
>>
>> Currently, we cannot specify MPOL_PREFERRED_MANY with the mempolicy flag
>> MPOL_F_NUMA_BALANCING. This causes issues when we want to use
>> NUMA_BALANCING_MEMORY_TIERING. To effectively use the slow memory tier,
>> the kernel should not allocate pages from the slower memory tier via
>> allocation control zonelist fallback. Instead, we should move cold pages
>> from the faster memory node via memory demotion. For a page allocation,
>> kswapd is only woken up after we try to allocate pages from all nodes in
>> the allocation zone list. This implies that, without using memory
>> policies, we will end up allocating hot pages in the slower memory tier.
>>
>> MPOL_PREFERRED_MANY was added by commit b27abaccf8e8 ("mm/mempolicy: add
>> MPOL_PREFERRED_MANY for multiple preferred nodes") to allow better
>> allocation control when we have memory tiers in the system. With
>> MPOL_PREFERRED_MANY, the user can use a policy node mask consisting only
>> of faster memory nodes. When we fail to allocate pages from the faster
>> memory node, kswapd would be woken up, allowing demotion of cold pages
>> to slower memory nodes.
>>
>> With the current kernel, such usage of memory policies implies we can't
>> do page promotion from a slower memory tier to a faster memory tier
>> using numa fault. This patch fixes this issue.
>>
>> For MPOL_PREFERRED_MANY, if the executing node is in the policy node
>> mask, we allow numa migration to the executing nodes. If the executing
>> node is not in the policy node mask but the folio is already allocated
>> based on policy preference (the folio node is in the policy node mask),
>> we don't allow numa migration. If both the executing node and folio node
>> are outside the policy node mask, we allow numa migration to the
>> executing nodes.
> The feature makes sense to me. How has this been tested? Do you have any
> numbers to present?

Hi Michal

I have a test program which allocate memory on a specified node and
trigger the promotion or migration (Keep accessing the pages).

Without this patch if we set MPOL_PREFERRED_MANY promotion or migration was not happening
with this patch I could see pages are getting  migrated or promoted.

My system has 2 CPU+DRAM node (Tier 1) and 1 PMEM node(Tier 2). Below
are my test results.

In below table N0 and N1 are Tier1 Nodes. N6 is the Tier2 Node.
Exec_Node is the execution node, Policy is the nodes in nodemask and
"Curr Location Pages" is the node where pages present before migration
or promotion start.

Tests Results
------------------
Scenario 1:  if the executing node is in the policy node mask
================================================================================
Exec_Node    Policy           Curr Location Pages       Observations
================================================================================
N0           N0 N1 N6             N1                Pages Migrated from N1 to N0
N0           N0 N1 N6             N6                Pages Promoted from N6 to N0
N0           N0 N1                N1                Pages Migrated from N1 to N0
N0           N0 N1                N6                Pages Promoted from N6 to N0

Scenario 2: If the folio node is in policy node mask and Exec node not in policy  node mask
================================================================================
Exec_Node    Policy       Curr Location Pages       Observations
================================================================================
N0           N1 N6             N1               Pages are not Migrating to N0
N0           N1 N6             N6               Pages are not migration to N0
N0           N1                N1               Pages are not Migrating to N0

Scenario 3: both the folio node and executing node are outside the policy nodemask
==============================================================================
Exec_Node    Policy         Curr Location Pages       Observations
==============================================================================
N0            N1                     N6          Pages Promoted from N6 to N0
N0            N6                     N1          Pages Migrated from N1 to N0


Thanks
Donet Tom

>
>> Signed-off-by: Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> ---
>>   mm/mempolicy.c | 28 ++++++++++++++++++++++++++--
>>   1 file changed, 26 insertions(+), 2 deletions(-)
> I haven't spotted anything obviously wrong in the patch itself but I
> admit this is not an area I am actively familiar with so I might be
> missing something.

