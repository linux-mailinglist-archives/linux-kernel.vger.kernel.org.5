Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B237E8107
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344438AbjKJSVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345176AbjKJSS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:18:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBBB72A5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:29:39 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA3vsew010482;
        Fri, 10 Nov 2023 04:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+m4TOSrhua6AyhvcRL7JIj8vxb8M64dgXd5oxhdIgfs=;
 b=HE6SqNpEZZFRbG+8evVynaBhaurH1IHrHBoV2Bb5zCn1UwI63SgY/zVdVc0LFpQhZeDp
 6kLBMXdRBiADY/zbvyd0WH59L72Vt45B/U2oJ8gUAcccGK4ru2koGYlxWZ1TIpc4ZRdc
 ixCiAYN7c5DYkliOlcgmW5EQo5Ou9NkgOzt74c6LtSDFLeLbZsZIqoQKLDE7Us3HcYUX
 6WgiZmYbe6I1MMIpWlIDTEg9aeE+R1xo4iQlfKb1clf7U6AjOePjZEcW08B6UHFKK8Cu
 XsAGboJdYxgXLmWy7v0U/gd2wdZCOqHNc2k6V0JjYDZcOy7c5LhCQQtEXJY/wm7RCFkF /A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9d2p8291-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 04:00:39 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AA40deO020244;
        Fri, 10 Nov 2023 04:00:39 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9d2p8285-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 04:00:39 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA1UKgN004176;
        Fri, 10 Nov 2023 04:00:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w218f7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 04:00:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AA40awA44565058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 04:00:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EABB20040;
        Fri, 10 Nov 2023 04:00:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66CAE2005A;
        Fri, 10 Nov 2023 04:00:32 +0000 (GMT)
Received: from [9.43.54.75] (unknown [9.43.54.75])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Nov 2023 04:00:32 +0000 (GMT)
Message-ID: <42fbe90e-dd41-4934-bf03-a0f672d7095c@linux.ibm.com>
Date:   Fri, 10 Nov 2023 09:30:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Question]: major faults are still triggered after mlockall when
 numa balancing
To:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        "zhangpeng (AS)" <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
        lstoakes@gmail.com, hughd@google.com, david@redhat.com,
        vbabka@suse.cz, peterz@infradead.org, mgorman@suse.de,
        mingo@redhat.com, riel@redhat.com, ying.huang@intel.com,
        hannes@cmpxchg.org, Nanyong Sun <sunnanyong@huawei.com>
References: <9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com>
 <CAHbLzkqEytFbRoHU3=Y85tmTQ--XVQpwhVEXgDN0ss_PPv8VGA@mail.gmail.com>
 <648aa9dc-fc42-4f28-af9a-b24adfdcd43d@intel.com>
 <56e1e123-f593-443a-be5b-754cbfb0e611@huawei.com>
 <98479379-0fff-409a-a60d-2233da114588@intel.com>
Content-Language: en-US
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <98479379-0fff-409a-a60d-2233da114588@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FFyhId3LGLMy6LsRqkt7d5XKuzVoDoSi
X-Proofpoint-GUID: o0P4BwdIzG5XoXSJ-VlNaKGHxmKmeLMT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_17,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100032
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/23 9:20 AM, Yin, Fengwei wrote:
> 
> 
> On 11/10/2023 11:39 AM, Kefeng Wang wrote:
>>
>>
>> On 2023/11/10 9:57, Yin, Fengwei wrote:
>>>
>>>
>>> On 11/10/2023 6:54 AM, Yang Shi wrote:
>>>> On Thu, Nov 9, 2023 at 5:48 AM zhangpeng (AS) <zhangpeng362@huawei.com> wrote:
>>>>>
>>>>> Hi everyone,
>>>>>
>>>>> There is a performance issue that has been bothering us recently.
>>>>> This problem can reproduce in the latest mainline version (Linux 6.6).
>>>>>
>>>>> We use mlockall(MCL_CURRENT | MCL_FUTURE) in the user mode process
>>>>> to avoid performance problems caused by major fault.
>>>>>
>>>>> There is a stage in numa fault which will set pte as 0 in do_numa_page() :
>>>>> ptep_modify_prot_start() will clear the vmf->pte, until
>>>>> ptep_modify_prot_commit() assign a value to the vmf->pte.
>>>>>
>>>>> For the data segment of the user-mode program, the global variable area
>>>>> is a private mapping. After the pagecache is loaded, the private
>>>>> anonymous page is generated after the COW is triggered. Mlockall can
>>>>> lock COW pages (anonymous pages), but the original file pages cannot
>>>>> be locked and may be reclaimed. If the global variable (private anon page)
>>>>> is accessed when vmf->pte is zero which is concurrently set by numa fault,
>>>>> a file page fault will be triggered.
>>>>>
>>>>> At this time, the original private file page may have been reclaimed.
>>>>> If the page cache is not available at this time, a major fault will be
>>>>> triggered and the file will be read, causing additional overhead.
>>>>>
>>>>> Our problem scenario is as follows:
>>>>>
>>>>> task 1                      task 2
>>>>> ------                      ------
>>>>> /* scan global variables */
>>>>> do_numa_page()
>>>>>     spin_lock(vmf->ptl)
>>>>>     ptep_modify_prot_start()
>>>>>     /* set vmf->pte as null */
>>>>>                               /* Access global variables */
>>>>>                               handle_pte_fault()
>>>>>                                 /* no pte lock */
>>>>>                                 do_pte_missing()
>>>>>                                   do_fault()
>>>>>                                     do_read_fault()
>>>>>     ptep_modify_prot_commit()
>>>>>     /* ptep update done */
>>>>>     pte_unmap_unlock(vmf->pte, vmf->ptl)
>>>>>                                       do_fault_around()
>>>>>                                       __do_fault()
>>>>>                                         filemap_fault()
>>>>>                                           /* page cache is not available
>>>>>                                           and a major fault is triggered */
>>>>>                                           do_sync_mmap_readahead()
>>>>>                                           /* page_not_uptodate and goto
>>>>>                                           out_retry. */
>>>>>
>>>>> Is there any way to avoid such a major fault?
>>>>
>>>> IMHO I don't think it is a bug. The man page quoted by Willy says "All
>>>> mapped pages are guaranteed to be resident in RAM when the call
>>>> returns successfully", but the later COW already made the file page
>>>> unmapped, right? The PTE pointed to the COW'ed anon page.
>>>> Hypothetically if we kept the file page mlocked and unmapped,
>>>> munlock() would have not munlocked the file page at all, it would be
>>>> mlocked in memory forever.
>>> But in this case, even the COW page is mlocked. There is small window
>>> that PTE is set to null in do_numa_page(). data segment access (it's to
>>> COW page which has nothing to do with original page cache) happens in
>>> this small window will trigger filemap_fault() to fault in original
>>> page cache.
>>>
>>> I had thought to do double check whether vmf->pte is NULL in do_read_fault().
>>> But it's not reliable enough.
>>>
>>> Matthew's idea to use protnone to block both hardware accessing and
>>> do_pte_missing() looks more promising to me.
>>
>> Actual， we could revert the following patch to avoid this issue,
>> but this workaroud from ppc...
>>
>> commit cee216a696b2004017a5ecb583366093d90b1568
>> Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> Date:   Fri Feb 24 14:59:13 2017 -0800
>>
>>     mm/autonuma: don't use set_pte_at when updating protnone ptes
>>
>>     Architectures like ppc64, use privilege access bit to mark pte non
>>     accessible.  This implies that kernel can do a copy_to_user to an
>>     address marked for numa fault.  This also implies that there can be a
>>     parallel hardware update for the pte.  set_pte_at cannot be used in such
>>     scenarios.  Hence switch the pte update to use ptep_get_and_clear and
>>     set_pte_at combination.
> Oh. This means the protnone doesn't work for PPC.
> 
>

That is correct. I am yet to read the full thread. Can we make ptep_modify_prot_start()
not to mark pte = 0 ? One of the requirement for powerpc is to mark it hardware invalid
such that not TLB entries get inserted after that. Other options is to get a proper
pte_update API for generic kernel so that architectures can do this without marking the
pte invalid. 


-aneesh


