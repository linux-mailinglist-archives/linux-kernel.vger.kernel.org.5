Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4717F2E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjKUNVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjKUNVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:21:54 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D544F98;
        Tue, 21 Nov 2023 05:21:48 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALCPr6U019674;
        Tue, 21 Nov 2023 13:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=eeSboqAjtQLorF8gWd25eGiF12N+F42IRC+rLymJQbI=;
 b=OMrBIS+dviaKyEBrdmxY6Y1viDijLzBwV5fA7KA08dUs0W0+rW7W7N+mP7MJvhTkIpIX
 tJwmrvGMJNC68tYYSFVAObVCXOWgZKMETpyXAmW9OKhwnkqQ/6LUZzc4NPIi7JCplv6k
 A2g+pYiXmgWQSjUv4acMRCMJrJdUp0FLnSDZ1laC7AP7UD3q6js9JLFSJggOmkhkNPWb
 Coq7oyqfQ7OoTt0Z/JzZa7kOAJWCl1om/fTyyHT1DDv8pvgvrskXJ+Ud5dEzwkgPZ8vk
 O3swRPY0Oc3kLPklsjhFtvuR/L4+2khyZb6Axfezt9pAVITRJTnM942c96lhtH6aRO6w 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uguhu34r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 13:21:36 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALDAvqI015522;
        Tue, 21 Nov 2023 13:21:36 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uguhu34px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 13:21:36 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALDJAMs019328;
        Tue, 21 Nov 2023 13:21:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf7yygyhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 13:21:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ALDLVFW45547966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 13:21:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD79020043;
        Tue, 21 Nov 2023 13:21:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D175320040;
        Tue, 21 Nov 2023 13:21:27 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.171.14.211])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 21 Nov 2023 13:21:27 +0000 (GMT)
Date:   Tue, 21 Nov 2023 14:21:26 +0100
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
Message-ID: <ZVyu1gAinLEtg5RR@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
 <ec3fcd7d-17a0-4901-9261-a204c2c50c52@redhat.com>
 <20231117140009.5d8a509c@thinkpad-T15>
 <ee492da8-74b4-4a97-8b24-73e07257f01d@redhat.com>
 <ZVys8HF1lgbA8u0c@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVys8HF1lgbA8u0c@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NbTv6UbR9kMb309-jvyhh6MyQEstmKOC
X-Proofpoint-ORIG-GUID: GhEUkmm31j9GsomI-sPIdNOidy72mCAQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_05,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=18 mlxlogscore=65 phishscore=0
 bulkscore=0 mlxscore=18 adultscore=0 spamscore=18 clxscore=1015
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210105
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 02:13:22PM +0100, Sumanth Korikkar wrote:
> Approach 2:
> ===========
> Shouldnt kasan zero shadow mapping performed first before
> accessing/initializing memmap via page_init_poisining()?  If that is
> true, then it is a problem for all architectures and should could be
> fixed like:
> 
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 7a5fc89a8652..eb3975740537 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1093,6 +1093,7 @@ int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
>  	if (ret)
>  		return ret;
> 
> +	page_init_poison(pfn_to_page(pfn), sizeof(struct page) * nr_pages);
>  	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_UNMOVABLE);
> 
>  	for (i = 0; i < nr_pages; i++)
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 77d91e565045..4ddf53f52075 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -906,8 +906,11 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>  	/*
>  	 * Poison uninitialized struct pages in order to catch invalid flags
>  	 * combinations.
> +	 * For altmap, do this later when onlining the memory, as it might
> +	 * not be accessible at this point.
>  	 */
> -	page_init_poison(memmap, sizeof(struct page) * nr_pages);
> +	if (!altmap)
> +		page_init_poison(memmap, sizeof(struct page) * nr_pages);
> 
>  	ms = __nr_to_section(section_nr);
>  	set_section_nid(section_nr, nid);
> 
> 
> 
> Also, if this approach is taken, should page_init_poison() be performed
> with cond_resched() as mentioned in commit d33695b16a9f
> ("mm/memory_hotplug: poison memmap in remove_pfn_range_from_zone()") ?

Sorry, wrong commit id.

should page_init_poison() be performed with cond_resched() as mentioned in
Commit b7e3debdd040 ("mm/memory_hotplug.c: fix false softlockup
during pfn range removal") ?

Thanks
> 
> Opinions?
> 
> Thank you
