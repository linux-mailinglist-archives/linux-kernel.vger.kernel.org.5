Return-Path: <linux-kernel+bounces-71558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B5385A70E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2E66B2491E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC743CF63;
	Mon, 19 Feb 2024 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SunLaCRo"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE203C49C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355291; cv=none; b=skLwuu1/53dW9bNChbIK4Avt73aC3yd25/d1h28J18ll3G0pfNYtXWmxuDXlcJxnn1MNBoTLUWcmkCHYehgJD0gerIgy8QUaT+hXKzmYlbOeAsavqB47c/Lvy/D4Js6ZsnbkWZr59+/JVj26lYrDTgMPw1JQSMJ6xaZ1R7Yepqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355291; c=relaxed/simple;
	bh=KY4QaQV6v0Y3oaXRAJ1MoPUwoBO5sxsrbtEwSCafyIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLP+0yY1BAxrP9OHLrL73uAnay7vMLM9BEjvnS2NON891u/9pNH7vMpwfG0ESeb0q/IOze/omMsHc3T94WQEe9DzT/kRI5gS+LeZSj+cqlZDCI0EnoEf/tP5EcwIvxV3eKeXke9INxrk1nIvhb8kpdPTZuphU1W6HPMC2u22u28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SunLaCRo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JF36oZ014146;
	Mon, 19 Feb 2024 15:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rkndU+NnuO7/1RDNdFrkuk4Jm0zJ0XhgNoPsGshVc0I=;
 b=SunLaCRoRblZgR7uTkjILl7gig+35o40zlY1Q0cpz9nRclgNgBY4KSSbQ0yT6u95ffGm
 fHbFI/UBsy5cAXhKkkbqayqDh1/S7gYy+Vvyx8CMO6miZFdMNfFpvnYGMmB0EYBf3Ptp
 rJpFjVmKOaNX95WVwF3diq0LM7oX58sNA39y6rnPmHw+p95WUp5scJa7WxNfCw699XBW
 67kDaByH2lz8cO1Mtc1SuR6efgens6qNKM3Qxw5zgSgL8QZe8KthrH8fIRsBaWKBtfvP
 fQoMlnetW1x6bkcINhWai6Ovf4mJU7lB6QnPPwbkEEInMz9fqupxXSAwOdhi94NZGvSP Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wc99h85k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 15:07:32 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41JF55ZG021278;
	Mon, 19 Feb 2024 15:07:31 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wc99h85jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 15:07:31 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41JDBrsc003606;
	Mon, 19 Feb 2024 15:07:30 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74ta7uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 15:07:30 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41JF7R0X44434016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 15:07:29 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1496658067;
	Mon, 19 Feb 2024 15:07:27 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4835E5805D;
	Mon, 19 Feb 2024 15:07:19 +0000 (GMT)
Received: from [9.109.245.191] (unknown [9.109.245.191])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Feb 2024 15:07:18 +0000 (GMT)
Message-ID: <25b420aa-3fe6-40a4-8d60-a46ab61ee7b7@linux.ibm.com>
Date: Mon, 19 Feb 2024 20:37:17 +0530
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
 <ZdNjmOlkMqEOGci1@tiehlicka>
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <ZdNjmOlkMqEOGci1@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: axymrxJYgqQiIZPCDql1czZk-MR6X7tU
X-Proofpoint-ORIG-GUID: SeGuMQBK-_3pEtMiggIDmQMp_pydrOJv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_11,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=889
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190113


On 2/19/24 19:50, Michal Hocko wrote:
> On Sat 17-02-24 01:31:35, Donet Tom wrote:
> [...]
>> +static inline bool mpol_preferred_should_numa_migrate(int exec_node, int folio_node,
>> +					    struct mempolicy *pol)
>> +{
>> +	/* if the executing node is in the policy node mask, migrate */
>> +	if (node_isset(exec_node, pol->nodes))
>> +		return true;
>> +
>> +	/* If the folio node is in policy node mask, don't migrate */
>> +	if (node_isset(folio_node, pol->nodes))
>> +		return false;
>> +	/*
>> +	 * both the folio node and executing node are outside the policy nodemask,
>> +	 * migrate as normal numa fault migration.
>> +	 */
>> +	return true;
>> +}
> I have looked at this again and only now noticed that this doesn't
> really work as one would expected.
>
>          case MPOL_PREFERRED_MANY:
>                  /*
>                   * use current page if in policy nodemask,
>                   * else select nearest allowed node, if any.
>                   * If no allowed nodes, use current [!misplaced].
>                   */
>                  if (node_isset(curnid, pol->nodes))
>                          goto out;
>                  z = first_zones_zonelist(
>                                  node_zonelist(numa_node_id(), GFP_HIGHUSER),
>                                  gfp_zone(GFP_HIGHUSER),
>                                  &pol->nodes);
>                  polnid = zone_to_nid(z->zone);
>                  break;
>
> Will collapse the whole MPOL_PREFERRED_MANY nodemask into the first
> notde into that mask. Is that really what we want here? Shouldn't we use
> the full nodemask as the migration target?

With this patch it will take full nodemask and find out the correct migration target. It will not collapse into first node.

For example if we have 5 NUMA nodes in our system N1 to N5, all five are in nodemask and the execution node is N3.
with this fix mpol_preferred_should_numa_migrate() will return true because the execution node is there in the nodemask.
So mpol_misplaced() will select N3 as the migration target since MPOL_F_MORON is set and migrate the pages to N3.

     /* Migrate the folio towards the node whose CPU is referencing it */
     if (pol->flags & MPOL_F_MORON) {
         polnid = thisnid;

So with this patch pages will get migrated to the correct migration target.

>

