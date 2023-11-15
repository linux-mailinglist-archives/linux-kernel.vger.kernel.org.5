Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C907EC505
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344208AbjKOOVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344201AbjKOOU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:20:58 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E68C5;
        Wed, 15 Nov 2023 06:20:54 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFE6L3v024237;
        Wed, 15 Nov 2023 14:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=iIO02IFVTCuL2l+MYSOb9E92ecTVk5MbFe4XymLpvAo=;
 b=QODiOrAZ6D3Lyv74WQXnUq/J6NNNqLZMANwQmO6lp78c7clQ1trsdPrhAkpTzjB7cFpA
 L3q645CFMNtdW338yu1jnwr/H5YettSlzucHWyoJH52H2FWFAyIiU1cWARQVnpvn2Oub
 khP4X25JGEzCfYavdmSt0t+BIu5b/8oOH+JO6Q556mIb6x1caZ2ag1WCcTKgdigKfmgj
 deR2o3TMHGyuPpbQk0t/tuBb4p/QvxxWZCLPPeIAxBDrUukaSPl1irGcXVKQisnluEtp
 sMu3WmxqcUQRNaJiUrEUdIpFe13N13JpJub9B3Tue7PBeCi0i/hcCoPL38oZWWi03Bhz dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucyf4ghhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 14:20:44 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFE7C3w028788;
        Wed, 15 Nov 2023 14:20:44 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucyf4ghgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 14:20:43 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFDmw03020512;
        Wed, 15 Nov 2023 14:20:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamxnfmn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 14:20:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AFEKeQi17236508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 14:20:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EACB22004B;
        Wed, 15 Nov 2023 14:20:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A43C20043;
        Wed, 15 Nov 2023 14:20:37 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.171.69.220])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 15 Nov 2023 14:20:37 +0000 (GMT)
Date:   Wed, 15 Nov 2023 15:20:35 +0100
From:   Sumanth Korikkar <sumanthk@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/8] s390/mm: implement MEM_PHYS_ONLINE MEM_PHYS_OFFLINE
 memory notifiers
Message-ID: <ZVTTs2H6DgNGFPkF@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
 <20231114180238.1522782-7-sumanthk@linux.ibm.com>
 <458da84d-3838-4c5d-abda-1aebba676186@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458da84d-3838-4c5d-abda-1aebba676186@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9b7dDx8KFTNFeVw7B4-xj3v6fwtslpa4
X-Proofpoint-GUID: OUd9BhB4V8HkjqGLN8EGhtJyl8CYuEGq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_13,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=609 spamscore=0 clxscore=1015 adultscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 07:39:40PM +0100, David Hildenbrand wrote:
> On 14.11.23 19:02, Sumanth Korikkar wrote:
> > Implement MEM_PHYS_ONLINE and MEM_PHYS_OFFLINE memory notifiers on s390
> > 
...
> >   arch/s390/mm/init.c          | 16 +++++++++++++++-
> >   drivers/s390/char/sclp_cmd.c | 33 ++++++++++++++++++++++++++++++---
> >   2 files changed, 45 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> > index 8d9a60ccb777..db505ed590b2 100644
> > --- a/arch/s390/mm/init.c
> > +++ b/arch/s390/mm/init.c
> > @@ -288,6 +288,12 @@ int arch_add_memory(int nid, u64 start, u64 size,
> >   	rc = vmem_add_mapping(start, size);
> >   	if (rc)
> >   		return rc;
> > +	/*
> > +	 * If MHP_MEMMAP_ON_MEMORY is enabled, perform __add_pages() during memory
> > +	 * onlining phase
> > +	 */
> > +	if (params->altmap)
> > +		return 0;
> 
> 
> So we'd have added memory blocks without a memmap? Sorry, but this seems to
> further hack into the s390x direction.

This new approach has the advantage that we do not need to allocate any
additional memory during online phase, neither for direct mapping page
tables nor struct pages, so that memory hotplug can never fail.

The old approach (without altmap) is already a hack, because we add
the memmap / struct pages, but for memory that is not really accessible.
And with all the disadvantage of pre-allocating struct pages from system
memory.

The new approach allows to better integrate s390 to the existing
interface, and also make use of altmap support, which would eliminate
the major disadvantage of the old behaviour. So from s390 perspective,
this new mechanism would be preferred, provided that there is no
functional issue with the "added memory blocks without a memmap"
approach.

Do you see any functional issues, e.g. conflict with common
code?
> 
> Maybe s390x should just provide a dedicate interface to add these memory
> blocks instead of adding them during boot and then relying on the old way of
> using online/offline set them online/offline.

Existing behavior:
The current 'lsmem -a' command displays both online and standby memory.

interface changes:
If a new interface is introduced and standby memory is no longer listed,
the following consequences might occur:

1. Running 'lsmem -a' would only show online memory, potentially leading
   to user complaints.
2. standby memory addition would need:
   * echo "standby memory addr" > /sys/devices/system/memory/probe
   As far as I understand, this interface is already deprecated.

3. To remove standby memory, a new interface probe_remove is needed
   * echo "standby memory addr" > /sys/devices/system/memory/probe_remove

4. Users may express a need to identify standby memory addresses,
resulting in the creation of another interface to list these standby
memory ranges.

Hence, introducing new physical memory notifiers to platforms lacking
dynamic ACPI events would be highly advantageous while maintaining
existing user-friendly interface.

Thanks
