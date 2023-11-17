Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F7E7EF804
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjKQTrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjKQTrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:47:02 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C29D5D;
        Fri, 17 Nov 2023 11:46:58 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHJgFVU009656;
        Fri, 17 Nov 2023 19:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=V2het07mxfWMUnHT9sJPdfoPQsc50ihRh3IyKWgcirs=;
 b=VSQGOg2wbO9wdvRfJYoS2RKuOB7FMbmkX9Q87tqMPY5R5dSsW/htEwBIprv5CNlVetIo
 +iaQZ0w39j0Q9tAdbDlrazDQ3BoEEhdzDJgelHuFdSzCT82SzPvb59Qdw+7eWBlYq45z
 qt/5kEjHP3isK+7iIZekQdDUncNqZJWMYMsFs3rScTDtHO71al9elrWPZ4NW/9mNTUtz
 33vjRY3r/43yPc5Rix1CPzteHtzSS+k9ybct6Yei9I2WKct0miIFLL3NmmjwsIImEhAw
 7JcTjm/La8IOpZHzPQS5BOctb6LmutAZnyHFOTCYEwA+/GEIf4RCGUbtgHel3r4twtBM Dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ueejer5fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 19:46:45 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AHJgCsj009592;
        Fri, 17 Nov 2023 19:46:45 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ueejer5eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 19:46:45 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHISDNL009056;
        Fri, 17 Nov 2023 19:46:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uanem88sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 19:46:43 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AHJkerM22020816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 19:46:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A6D120043;
        Fri, 17 Nov 2023 19:46:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6776620040;
        Fri, 17 Nov 2023 19:46:39 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.171.27.169])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 17 Nov 2023 19:46:39 +0000 (GMT)
Date:   Fri, 17 Nov 2023 20:46:37 +0100
From:   Sumanth Korikkar <sumanthk@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] implement "memmap on memory" feature on s390
Message-ID: <ZVfDHbeonM0bwLek@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
 <ec3fcd7d-17a0-4901-9261-a204c2c50c52@redhat.com>
 <20231117140009.5d8a509c@thinkpad-T15>
 <ee492da8-74b4-4a97-8b24-73e07257f01d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee492da8-74b4-4a97-8b24-73e07257f01d@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: i039OZloyrjehCuPpyvMOCtYL7DKo22X
X-Proofpoint-GUID: fLtOoATvfYaANKAn4lXdlzZ9nheuGiX3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_19,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 phishscore=0 mlxscore=1
 adultscore=0 spamscore=1 mlxlogscore=202 malwarescore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170150
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 04:37:29PM +0100, David Hildenbrand wrote:
> 
> It might make sense to
> 
> 1) Send the first 3 out separately

Ok sure, I will first send 3 patches as bug fixes with your feedback
applied.

> 2) Look into a simple variant that leaves __add_pages() calls alone and
>    only adds the new MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers --
>    well, and deals with an inaccessible altmap, like the
>    page_init_poison() when the altmap might be inaccessible.

Thanks for the valuable feedback.

I just tried out quickly with disabling page_init_poison() and removing
the hack in arch_add_memory() and arch_remove_memory(). Also used new
MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers. The current testing
result looks promising and seems to work and no issues found so far.

I will also double check if there are any other memmap accesses in
add_pages() phase.

we will try to go for this approach currently, i.e. with the notifiers you
suggested, and __add_pages() change.

Do you have any suggestions with how we could check for inaccessible altmap?

> 3) Look into a proper interface to add/remove memory instead of relying
>    on online/offline.

agree for long term.
> 
> 2) is certainly an improvement and might be desired in some cases. 3) is
> more powerful (e.g., where you don't want an altmap because of
> fragmentation) and future proof.
> 
> I suspect there will be installations where an altmap is undesired: it
> fragments your address space with unmovable (memmap) allocations. Currently,
> runtime allocations of gigantic pages are affected. Long-term other large
> allocations (if we ever see very large THP) will be affected.
> 
> For that reason, we want to either support variable-sized memory blocks
> long-term, or simulate that by "grouping" memory blocks that share a same
> altmap located on the first memory blocks in that group: but onlining one
> block forces onlining of the whole group.
> 
> On s390x that adds all memory ahead of time, it's hard to make a decision
> what the right granularity will be, and seeing sudden online/offline changed
> behavior might be quite "surprising" for users. The user can give better
> hints when adding/removing memory explicitly.

Thanks for providing insights and details.
