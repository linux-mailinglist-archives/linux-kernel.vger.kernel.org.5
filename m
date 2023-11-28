Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FD27FB351
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343911AbjK1Hyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjK1Hyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:54:52 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279E598;
        Mon, 27 Nov 2023 23:54:59 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS7fkE8004051;
        Tue, 28 Nov 2023 07:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=mvhId/iOn6bQbWlkTiJuvlh1+3b6/ZRtze8kpz/5F1U=;
 b=klNhIv9XTqECkEL2JmXlXqyYsYG7G930xOrFNYI7iEGormjavzrCJcXaRnuBEB16G/WY
 DBjwyzoeyV1+DsTAmoQQRbY++20gXl2672sxUfNHgH0NJjOqlzpK+IewGHCBpm2NrLu7
 oc8TWaQObGZuPrAZb5iRB6eyGS6+HCs84siTXj7RaftRDWIEyCrTb7drD7EpH9n7AotR
 uu9QDOKxoFwRr4505PQOR9ObiaZe3fxRvFFIcmVrDrtwt9f7uVDOviLUUimGbgFXSqaX
 fij4X3Bj5bsHTJTRoa0eDYqmhJuvHDQQzvavdpnHBDXMQyqGUHAkUFp8ryO3qZVdJFRQ KA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unah2k3py-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 07:54:49 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AS7fnm5004679;
        Tue, 28 Nov 2023 07:54:48 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unah2k3pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 07:54:48 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS7NGli004930;
        Tue, 28 Nov 2023 07:54:47 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfjwvkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 07:54:47 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AS7si4f27066916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Nov 2023 07:54:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3F8E2004B;
        Tue, 28 Nov 2023 07:54:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 141FC20043;
        Tue, 28 Nov 2023 07:54:44 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.179.11.62])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 28 Nov 2023 07:54:44 +0000 (GMT)
Date:   Tue, 28 Nov 2023 08:54:42 +0100
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
Subject: Re: [PATCH v3 1/5] mm/memory_hotplug: introduce
 MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers
Message-ID: <ZWWcwvcohncIH/RI@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20231127082023.2079810-1-sumanthk@linux.ibm.com>
 <20231127082023.2079810-2-sumanthk@linux.ibm.com>
 <c7512dd7-5009-4230-a29e-ea13c2e3be3e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7512dd7-5009-4230-a29e-ea13c2e3be3e@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kCNG8rYAMNiN1LpdXU_VXqr5NeMHArEt
X-Proofpoint-ORIG-GUID: wc8ecEWfv7zif7pkpuC-EjvZRuKliQM4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_06,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=317 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280060
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 04:16:18PM +0100, David Hildenbrand wrote:
> On 27.11.23 09:20, Sumanth Korikkar wrote:
> > Introduce  MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE memory notifiers to
> > prepare the transition of memory to and from a physically accessible
> > state. This enhancement is crucial for implementing the "memmap on
> > memory" feature for s390 in a subsequent patch.
> > 
> > Platforms such as x86 can support physical memory hotplug via ACPI. When
> > there is physical memory hotplug, ACPI event leads to the memory
> > addition with the following callchain:
> > acpi_memory_device_add()
> >    -> acpi_memory_enable_device()
> >       -> __add_memory()
> > 
> > After this, the hotplugged memory is physically accessible, and altmap
> > support prepared, before the "memmap on memory" initialization in
> > memory_block_online() is called.
> > 
> > On s390, memory hotplug works in a different way. The available hotplug
> > memory has to be defined upfront in the hypervisor, but it is made
> > physically accessible only when the user sets it online via sysfs,
> > currently in the MEM_GOING_ONLINE notifier. This is too late and "memmap
> > on memory" initialization is performed before calling MEM_GOING_ONLINE
> > notifier.
> > 
> > During the memory hotplug addition phase, altmap support is prepared and
> > during the memory onlining phase s390 requires memory to be physically
> > accessible and then subsequently initiate the "memmap on memory"
> > initialization process.
> > 
> > The memory provider will handle new MEM_PREPARE_ONLINE /
> > MEM_FINISH_OFFLINE notifications and make the memory accessible.
> > 
> > The mhp_flag MHP_OFFLINE_INACCESSIBLE is introduced and is relevant when
> > used along with MHP_MEMMAP_ON_MEMORY, because the altmap cannot be
> > written (e.g., poisoned) when adding memory -- before it is set online.
> > This allows for adding memory with an altmap that is not currently made
> > available by a hypervisor. When onlining that memory, the hypervisor can
> > be instructed to make that memory accessible via the new notifiers and
> > the onlining phase will not require any memory allocations, which is
> > helpful in low-memory situations.
> > 
> > All architectures ignore unknown memory notifiers.  Therefore, the
> > introduction of these new notifiers does not result in any functional
> > modifications across architectures.
> > 
> > Suggested-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> > ---
...
> >   int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
> > -			      struct zone *zone)
> > +			      struct zone *zone, bool mhp_off_inaccessible)
> >   {
> >   	unsigned long end_pfn = pfn + nr_pages;
> >   	int ret, i;
> > @@ -1092,7 +1109,14 @@ int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
> >   	ret = kasan_add_zero_shadow(__va(PFN_PHYS(pfn)), PFN_PHYS(nr_pages));
> >   	if (ret)
> >   		return ret;
> > -
> > +	/*
> > +	 * Memory block is accessible at this stage and hence poison the struct
> > +	 * pages now.  If the memory block is accessible during memory hotplug
> > +	 * addition phase, then page poisining is already performed in
> > +	 * sparse_add_section().
> > +	 */
> > +	if (mhp_off_inaccessible)
> > +		page_init_poison_with_resched(pfn, nr_pages);
> 
> Can you elaborate why a simple page_init_poison() as for
> sparse_add_section() is insufficient?
>
Looks like cond_resched() is not needed. page_init_poison() could be
performed similar to when adding new memory in sparse_add_section().
IIUC, As memory is onlined in memory block granuality, this
cond_resched() wouldnt be needed then.

Thanks
