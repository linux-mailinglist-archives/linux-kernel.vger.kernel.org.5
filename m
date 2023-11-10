Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A719B7E8059
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344934AbjKJSJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345602AbjKJSGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:06:39 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F95D59D7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:15:46 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA4RN2Y003143;
        Fri, 10 Nov 2023 05:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=3OdEQPond3eBhJg8KNy/M7RgQdpQRv6NWUmynbS6pmk=;
 b=QAYGlQBNJrWFygpiMd5d7GFQHqGu3BlPeB0M5yMMN20sKroQWT5D9oATN1sDbr9WC2fx
 eHW4MtgawuOu7UV8L6RlfX4ELwsxvPsuYUFoYUEaBYB0ERo8wWizVbpbE6XdlsHFItyP
 c0kiMhDdxF7GAaB4Q1XggCXHRur4VFIBkCxyh0q5WQhXJoTmzk2R+KAy7fiOmI699lZT
 bejar1Tdv1FfOy7vE1Os3tqel5YSxfpilSpR/uxmTGWzb1NUb85Mvp0fO249KlrOI8Ry
 6jfCiyhj7XLqxLPVQnu7XXPvaM8xj1C7OzJ8/A2zeTBB4pkfe6WGh04ExWsjLPX31eRg mA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9dgq8v5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 05:04:35 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AA4exWd005363;
        Fri, 10 Nov 2023 05:04:34 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9dgq8v4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 05:04:34 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA4XP1Y028299;
        Fri, 10 Nov 2023 05:04:32 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u7w22rr9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 05:04:32 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AA54Wbd45548074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 05:04:32 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76BC85805D;
        Fri, 10 Nov 2023 05:04:32 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 277A25805C;
        Fri, 10 Nov 2023 05:04:26 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.109.212.144])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Nov 2023 05:04:25 +0000 (GMT)
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
Date:   Fri, 10 Nov 2023 10:34:23 +0530
Message-ID: <87h6lunqqw.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4FyxtxcXYjFHBDowN2BwytQM3JSyx0Uy
X-Proofpoint-ORIG-GUID: Sxp_TsW7tfsi1KXbAWNrivzY4Q1dGSpN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_01,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0 mlxlogscore=678
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100041
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

This is also true w.r.t change_pte_range() in addition to do_numa_page()
?

-aneesh
