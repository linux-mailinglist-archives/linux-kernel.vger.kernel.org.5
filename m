Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAF07E80D0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345467AbjKJSSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345986AbjKJSQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:16:24 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCA793CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 00:18:11 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA8HLf7032592;
        Fri, 10 Nov 2023 08:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=t5lI2JnpQfxUTa1JOhlKB2TwExDv4LZawrSI6Ffzayo=;
 b=HDA9cLCXKUJgMizRcboMup6RoR52u9IszjsrQZsifEuva3ss37qg7j3j2xAGO7sIGgYc
 xy3kIK5qwZ54dsuT9DAfd+lh2up4Z/kM2jY3hwXwVWYRC4p0YVMuHBsPMXGspRVIVy0c
 1Qnl45lJ79M7O9vX61G6r9EHSq5DuK/68enx/eD5HdJK3TCPI6o/CZQBuThxapvcFVhW
 vi/vv/FFI7v2qaW0vplECAyKXP5riTe+qz0PYlDbuSM1el3nIkPiKA8ZEbw00lL3l8Ay
 NMejOSLCTl0l3hrwS0O+eZ2mZKn62JPuUgWSOnR+D3nUFOEEm4hmbgnQj7ZcO4cb9HZT aA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9gvh801k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 08:17:39 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AA8HdpU001230;
        Fri, 10 Nov 2023 08:17:39 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9gvh800v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 08:17:39 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA7ngvj004176;
        Fri, 10 Nov 2023 08:17:37 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w219jm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 08:17:37 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AA8HbH265405218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 08:17:37 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F23A5805A;
        Fri, 10 Nov 2023 08:17:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9753E5805F;
        Fri, 10 Nov 2023 08:17:31 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.109.212.144])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Nov 2023 08:17:31 +0000 (GMT)
X-Mailer: emacs 29.1 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     "zhangpeng (AS)" <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
        lstoakes@gmail.com, hughd@google.com, david@redhat.com,
        fengwei.yin@intel.com, vbabka@suse.cz, peterz@infradead.org,
        mgorman@suse.de, mingo@redhat.com, riel@redhat.com,
        ying.huang@intel.com, hannes@cmpxchg.org,
        Nanyong Sun <sunnanyong@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [Question]: major faults are still triggered after mlockall
 when numa balancing
In-Reply-To: <9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com>
References: <9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com>
Date:   Fri, 10 Nov 2023 13:47:28 +0530
Message-ID: <87edgynht3.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: W50-Wk7X5L7IseBE0GaXZJQn481t68gW
X-Proofpoint-GUID: zFj-0Ux6-s2m9vk314f8WeTW9GqxedWB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_04,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=642 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"zhangpeng (AS)" <zhangpeng362@huawei.com> writes:

> Hi everyone,
>
> There is a performance issue that has been bothering us recently.
> This problem can reproduce in the latest mainline version (Linux 6.6).
>
> We use mlockall(MCL_CURRENT | MCL_FUTURE) in the user mode process
> to avoid performance problems caused by major fault.
>
> There is a stage in numa fault which will set pte as 0 in do_numa_page() :
> ptep_modify_prot_start() will clear the vmf->pte, until
> ptep_modify_prot_commit() assign a value to the vmf->pte.
>

pte lookup don't expect the pte to be 0 after it got initialized (We do
check pte value without holding ptl and if we find the pte val 0 we
return). So the read-modify-write updates to the pte should make sure we
don't clear the pte right? powerpc did that by marking the pte present
but invalid. Can we do similar for other architecture? The default
implementation of ptep_modify_prot_start() to ptep_get_and_clear() can
result in pte lookup returning wrong pte as explained in the report
because we don't hold ptl and recheck if we find pte == 0


>
> For the data segment of the user-mode program, the global variable area
> is a private mapping. After the pagecache is loaded, the private
> anonymous page is generated after the COW is triggered. Mlockall can
> lock COW pages (anonymous pages), but the original file pages cannot
> be locked and may be reclaimed. If the global variable (private anon page)
> is accessed when vmf->pte is zero which is concurrently set by numa fault,
> a file page fault will be triggered.
>
> At this time, the original private file page may have been reclaimed.
> If the page cache is not available at this time, a major fault will be
> triggered and the file will be read, causing additional overhead.
>
> Our problem scenario is as follows:
>
> task 1                      task 2
> ------                      ------
> /* scan global variables */
> do_numa_page()
>    spin_lock(vmf->ptl)
>    ptep_modify_prot_start()
>    /* set vmf->pte as null */
>                              /* Access global variables */
>                              handle_pte_fault()
>                                /* no pte lock */
>                                do_pte_missing()
>                                  do_fault()
>                                    do_read_fault()
>    ptep_modify_prot_commit()
>    /* ptep update done */
>    pte_unmap_unlock(vmf->pte, vmf->ptl)
>                                      do_fault_around()
>                                      __do_fault()
>                                        filemap_fault()
>                                          /* page cache is not available
>                                          and a major fault is triggered */
>                                          do_sync_mmap_readahead()
>                                          /* page_not_uptodate and goto
>                                          out_retry. */
>
> Is there any way to avoid such a major fault?
>

-aneesh
