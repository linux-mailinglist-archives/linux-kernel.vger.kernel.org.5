Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204A97EC3EC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343964AbjKONmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343698AbjKONl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:41:59 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BA7AC;
        Wed, 15 Nov 2023 05:41:56 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFDZMdu017617;
        Wed, 15 Nov 2023 13:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=JpTnhZafrWktJuKVw3AxPIhy13lJv4awBySKdIudrf0=;
 b=YD5sdu1xUVqeGU0OqKnpeeXmkWVsONKq8iTy7ybEIZdHiJOMZ6uV5tk4jzhVonn0433k
 fpEkdw31Rseuux2DHJiX0mzb3SvgZFEN0YRtEIjCWp/GHq47ksB1fTb0KhCVi4lYZFrX
 x8T5UZKUFfCodNq7Sjt9h8558lH9UvjUv2NtbbKme15MO8aJ/P2YO8SB5TJuxRC+YTIM
 Hoc1YrvxlkGwguPj6Pc05HftKqkLQeOarB1rETAc4P6Qf3HNZulI0hHwZaY255mbqcYd
 6ZT0UJ4622fm/yz8SEMu7Ktr2/9DwJ9pLu6BhUGHkreBJ+hzXYFRsZWcehykVsGzFMMK uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucy0j0aue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 13:41:45 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFDa41V020973;
        Wed, 15 Nov 2023 13:41:45 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucy0j0au3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 13:41:45 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFDXpCb011481;
        Wed, 15 Nov 2023 13:41:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uap5k7153-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 13:41:44 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AFDffrm23331524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 13:41:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6F6B20040;
        Wed, 15 Nov 2023 13:41:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27E4220043;
        Wed, 15 Nov 2023 13:41:41 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.171.69.220])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 15 Nov 2023 13:41:41 +0000 (GMT)
Date:   Wed, 15 Nov 2023 14:41:39 +0100
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
Subject: Re: [PATCH 1/8] mm/memory_hotplug: fix memory hotplug locking order
Message-ID: <ZVTKk7J1AcoBBxhR@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
 <20231114180238.1522782-2-sumanthk@linux.ibm.com>
 <cbf8863a-d987-472f-8df3-bc621599f1ee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbf8863a-d987-472f-8df3-bc621599f1ee@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Di5py07534yhG8bWURnJb4HbBOIYUTC7
X-Proofpoint-GUID: tVEzKg6vzHJuCjuNGvuZcxg7RreBoyP-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_12,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=30 spamscore=30 mlxlogscore=37
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 mlxscore=30 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150105
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 07:22:33PM +0100, David Hildenbrand wrote:
> On 14.11.23 19:02, Sumanth Korikkar wrote:
> 
> The patch subject talks about "fixing locking order", but it's actually
> missing locking, no?
> 
> >  From Documentation/core-api/memory-hotplug.rst:
> > When adding/removing/onlining/offlining memory or adding/removing
> > heterogeneous/device memory, we should always hold the mem_hotplug_lock
> > in write mode to serialise memory hotplug (e.g. access to global/zone
> > variables).
> > 
> > mhp_(de)init_memmap_on_memory() functions can change zone stats and
> > struct page content, but they are currently called w/o the
> > mem_hotplug_lock.
> > 
> > When memory block is being offlined and when kmemleak goes through each
> > populated zone, the following theoretical race conditions could occur:
> > CPU 0:					     | CPU 1:
> > memory_offline()			     |
> > -> offline_pages()			     |
> > 	-> mem_hotplug_begin()		     |
> > 	   ...				     |
> > 	-> mem_hotplug_done()		     |
> > 					     | kmemleak_scan()
> > 					     | -> get_online_mems()
> > 					     |    ...
> > -> mhp_deinit_memmap_on_memory()	     |
> >    [not protected by mem_hotplug_begin/done()]|
> >    Marks memory section as offline,	     |   Retrieves zone_start_pfn
> >    poisons vmemmap struct pages and updates   |   and struct page members.
> >    the zone related data			     |
> >     					     |    ...
> >     					     | -> put_online_mems()
> > 
> > Fix this by ensuring mem_hotplug_lock is taken before performing
> > mhp_init_memmap_on_memory(). Also ensure that
> > mhp_deinit_memmap_on_memory() holds the lock.
> 
> What speaks against grabbing that lock in these functions?
>
At present, the functions online_pages() and offline_pages() acquire the
mem_hotplug_lock right at the start. However, given the necessity of
locking in mhp_(de)init_memmap_on_memory(), it would be more efficient
to consolidate the locking process by holding the mem_hotplug_lock once
in memory_block_online() and memory_block_offline().

Moreover, the introduction of the 'memmap on memory' feature on s390
brings a new physical memory notifier, and functions like __add_pages()
or arch_add_memory() are consistently invoked with the mem_hotplug_lock
already acquired.

Considering these factors, it seemed more natural to move
mem_hotplug_lock in memory_block_online() and memory_block_offline(),
which was described as "fixing locking order" in the subject. 
I will change the subject to "add missing locking", if it is misleading .

Would you or Oscar agree that there is a need for those
mhp_(de)init_memmap_on_memory() functions to take lock at all?

Thanks
