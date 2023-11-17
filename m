Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1FC7EF33F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 14:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346064AbjKQNBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 08:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbjKQNAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 08:00:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FECCD6A;
        Fri, 17 Nov 2023 05:00:49 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHCqMrm010784;
        Fri, 17 Nov 2023 13:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Ti0Js1qc2vTGC9CKeVEb9NHoQB/UVWpZ7SWSh4M3nUc=;
 b=kBHHp//02MdsoeL3SJs9QkodG3RyPDxR0v1V4p1yH6lD8q00QFzurNv+W1i462yq8OsD
 KkAlAw3DpAu15JkMHOaoTm+jBgPbLixPuF1K2LwZ8ok4M3IkV7p2X9EjyBC5LmFWlfnk
 G1WUKgzR30Oc46dkAOF6mY9lux0qoFNOBUnDo0+VeayCXGUFk7IK9W2zBTN3oau0pMWa
 0neSzrNhYmHA70oD2jhOnZjv4JgA1NjHHclaBnOkWA6K2twcYcCaCLagLkQib8yHxEMT
 QkIVsI6oMx2LwSY1IcDky19TceDcqepRk2H5W11PrAqd4fIZ3hWcxvSG3pGEYi1lVQs1 sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ue8j9r8f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 13:00:35 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AHCrsBl016605;
        Fri, 17 Nov 2023 13:00:34 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ue8j9r8d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 13:00:34 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHCnFv4028932;
        Fri, 17 Nov 2023 13:00:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uanem5tej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 13:00:33 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AHD0TGq36110914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 13:00:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6AB220043;
        Fri, 17 Nov 2023 13:00:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D34720040;
        Fri, 17 Nov 2023 13:00:29 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.171.21.29])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
        Fri, 17 Nov 2023 13:00:29 +0000 (GMT)
Date:   Fri, 17 Nov 2023 14:00:27 +0100
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Sumanth Korikkar <sumanthk@linux.ibm.com>,
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
Subject: Re: [PATCH 6/8] s390/mm: implement MEM_PHYS_ONLINE MEM_PHYS_OFFLINE
 memory notifiers
Message-ID: <20231117140027.00866eab@thinkpad-T15>
In-Reply-To: <dfa5eb84-270e-4c6b-b9a1-3bb66beed6a4@redhat.com>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
        <20231114180238.1522782-7-sumanthk@linux.ibm.com>
        <458da84d-3838-4c5d-abda-1aebba676186@redhat.com>
        <ZVTTs2H6DgNGFPkF@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
        <dfa5eb84-270e-4c6b-b9a1-3bb66beed6a4@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jjkk7e2MoqaLPEfgo5VstZcynymbU60f
X-Proofpoint-ORIG-GUID: h-0ZTlVTiukoP3ODLRwmCiQT01pmTq7L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_11,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 20:16:02 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 15.11.23 15:20, Sumanth Korikkar wrote:
> > On Tue, Nov 14, 2023 at 07:39:40PM +0100, David Hildenbrand wrote:  
> >> On 14.11.23 19:02, Sumanth Korikkar wrote:  
> >>> Implement MEM_PHYS_ONLINE and MEM_PHYS_OFFLINE memory notifiers on s390
> >>>  
> > ...  
> >>>    arch/s390/mm/init.c          | 16 +++++++++++++++-
> >>>    drivers/s390/char/sclp_cmd.c | 33 ++++++++++++++++++++++++++++++---
> >>>    2 files changed, 45 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> >>> index 8d9a60ccb777..db505ed590b2 100644
> >>> --- a/arch/s390/mm/init.c
> >>> +++ b/arch/s390/mm/init.c
> >>> @@ -288,6 +288,12 @@ int arch_add_memory(int nid, u64 start, u64 size,
> >>>    	rc = vmem_add_mapping(start, size);
> >>>    	if (rc)
> >>>    		return rc;
> >>> +	/*
> >>> +	 * If MHP_MEMMAP_ON_MEMORY is enabled, perform __add_pages() during memory
> >>> +	 * onlining phase
> >>> +	 */
> >>> +	if (params->altmap)
> >>> +		return 0;  
> >>
> >>
> >> So we'd have added memory blocks without a memmap? Sorry, but this seems to
> >> further hack into the s390x direction.  
> > 
> > This new approach has the advantage that we do not need to allocate any
> > additional memory during online phase, neither for direct mapping page
> > tables nor struct pages, so that memory hotplug can never fail.  
> 
> Right, just like any other architecture that (triggered by whatever 
> mechanism) ends up calling add_memory() and friends.

Just for better understanding, are page tables for identity and also
vmemmap mapping not allocated from system memory on other archs? I.e.
no altmap support for that, only for struct pages (so far)?

> 
> > 
> > The old approach (without altmap) is already a hack, because we add
> > the memmap / struct pages, but for memory that is not really accessible.  
> 
> Yes, it's disgusting. And you still allocate other things like memory 
> block devices or the identify map.

I would say it is special :-). And again, for understanding, all other
things apart from struct pages, still would need to be allocated from
system memory on other archs?

Of course, struct pages would be by far the biggest part, so having
altmap support for that helps a lot. Doing the other allocations also
via altmap would feel natural, but it is not possible yet, or did we
miss something?

> 
> > And with all the disadvantage of pre-allocating struct pages from system
> > memory.  
> 
> Jep. It never should have been done like that.

At that time, it gave the benefit over all others, that we do not need
to allocate struct pages from system memory, at the time of memory online,
when memory pressure might be high and such allocations might fail.

I guess you can say that it should have been done "right" at that time,
e.g. by already adding something like altmap support, instead of our own
hack.

> 
> > 
> > The new approach allows to better integrate s390 to the existing
> > interface, and also make use of altmap support, which would eliminate
> > the major disadvantage of the old behaviour. So from s390 perspective,
> > this new mechanism would be preferred, provided that there is no
> > functional issue with the "added memory blocks without a memmap"
> > approach.  
> 
> It achieves that by s390x specific hacks in common code :) Instead of 
> everybody else that simply uses add_memory() and friends.
> 
> > 
> > Do you see any functional issues, e.g. conflict with common
> > code?  
> 
> I don't see functional issues right now, just the way it is done to 
> implement support for a new feature is a hack IMHO. Replacing hack #1 by 
> hack #2 is not really something reasonable. Let's try to remove hacks.

Ok, sounds reasonable, let's try that. Introducing some new s390-specific
interface also feels a bit hacky, or ugly, but we'll see if we find a
way so that it is only "special" :-)
Reminds me a bit of that "probe" attribute, that also was an arch-specific
hack initially, IIRC, and is now to be deprecated...
