Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71DB75E2BA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 16:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjGWOyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 10:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGWOx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 10:53:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021E0C9;
        Sun, 23 Jul 2023 07:53:56 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36NE7aiD003504;
        Sun, 23 Jul 2023 14:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=UOUQ0aIG3tMZ1kPV0iy5M7XtmGItPeZ5AGFodoLAnZI=;
 b=hVavILof0mNPNiAs4RRSPmnEUhHl6vXQWYuqDHG09PHfSE8e1HZVTgo3i3CLhzJJL0mG
 q5G4N+htgl41fu2gJET8Qdpod+QGJGuncjcbUEiQ4fgdRVR7O3hQK6J4xh1CWYVR0pFB
 P6ojYQLpRzNN0OC3KErc0dO2iWAC7Voozq8cNUsO1LMXtQq4YzM25d5viJCfW1BYTUI/
 lph3UwkGswwR11jhGhyoNbS0lpccYWGbpKE5WiNomqb5huAsehsFU/sod/oqtmWMvITx
 OgVMzllIw6SO1ahU5xUNVlDA81iWnIOF0ly/yfCycAkOYmBQSIZfV5DZSsphXtlhAThy 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s0mw8wqee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Jul 2023 14:53:30 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36NEkFf3024226;
        Sun, 23 Jul 2023 14:53:30 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s0mw8wqe8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Jul 2023 14:53:29 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36NC0qYD014384;
        Sun, 23 Jul 2023 14:53:28 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0stxcb0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Jul 2023 14:53:28 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36NErRD05046898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 14:53:27 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACC1158062;
        Sun, 23 Jul 2023 14:53:27 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADF9158059;
        Sun, 23 Jul 2023 14:53:22 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.39.113])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 23 Jul 2023 14:53:22 +0000 (GMT)
X-Mailer: emacs 29.0.91 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v2 2/3] mm/memory_hotplug: split memmap_on_memory
 requests across memblocks
In-Reply-To: <20230720-vv-kmem_memmap-v2-2-88bdaab34993@intel.com>
References: <20230720-vv-kmem_memmap-v2-0-88bdaab34993@intel.com>
 <20230720-vv-kmem_memmap-v2-2-88bdaab34993@intel.com>
Date:   Sun, 23 Jul 2023 20:23:19 +0530
Message-ID: <87a5vmadcw.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: D-UmcYDsQlgdmR3uA39CuKFCIjjXE_7f
X-Proofpoint-GUID: Mp5Xv6-BD6HwkUxJNdGxki9y-wcKUbtL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-23_04,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307230135
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vishal Verma <vishal.l.verma@intel.com> writes:

> The MHP_MEMMAP_ON_MEMORY flag for hotplugged memory is currently
> restricted to 'memblock_size' chunks of memory being added. Adding a
> larger span of memory precludes memmap_on_memory semantics.
>
> For users of hotplug such as kmem, large amounts of memory might get
> added from the CXL subsystem. In some cases, this amount may exceed the
> available 'main memory' to store the memmap for the memory being added.
> In this case, it is useful to have a way to place the memmap on the
> memory being added, even if it means splitting the addition into
> memblock-sized chunks.
>
> Change add_memory_resource() to loop over memblock-sized chunks of
> memory if caller requested memmap_on_memory, and if other conditions for
> it are met,. Teach try_remove_memory() to also expect that a memory
> range being removed might have been split up into memblock sized chunks,
> and to loop through those as needed.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  mm/memory_hotplug.c | 154 +++++++++++++++++++++++++++++++---------------------
>  1 file changed, 91 insertions(+), 63 deletions(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index e9bcacbcbae2..20456f0d28e6 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1286,6 +1286,35 @@ bool mhp_supports_memmap_on_memory(unsigned long size)
>  }
>  EXPORT_SYMBOL_GPL(mhp_supports_memmap_on_memory);
>  
> +static int add_memory_create_devices(int nid, struct memory_group *group,
> +				     u64 start, u64 size, mhp_t mhp_flags)
> +{
> +	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
> +	struct vmem_altmap mhp_altmap = {};
> +	int ret;
> +
> +	if ((mhp_flags & MHP_MEMMAP_ON_MEMORY)) {
> +		mhp_altmap.free = PHYS_PFN(size);
> +		mhp_altmap.base_pfn = PHYS_PFN(start);
> +		params.altmap = &mhp_altmap;
> +	}
> +
> +	/* call arch's memory hotadd */
> +	ret = arch_add_memory(nid, start, size, &params);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* create memory block devices after memory was added */
> +	ret = create_memory_block_devices(start, size, mhp_altmap.alloc,
> +					  group);
> +	if (ret) {
> +		arch_remove_memory(start, size, NULL);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
>   * and online/offline operations (triggered e.g. by sysfs).
> @@ -1294,11 +1323,10 @@ EXPORT_SYMBOL_GPL(mhp_supports_memmap_on_memory);
>   */
>  int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  {
> -	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
> +	unsigned long memblock_size = memory_block_size_bytes();
>  	enum memblock_flags memblock_flags = MEMBLOCK_NONE;
> -	struct vmem_altmap mhp_altmap = {};
>  	struct memory_group *group = NULL;
> -	u64 start, size;
> +	u64 start, size, cur_start;
>  	bool new_node = false;
>  	int ret;
>  
> @@ -1339,27 +1367,20 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  	/*
>  	 * Self hosted memmap array
>  	 */
> -	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
> -		if (!mhp_supports_memmap_on_memory(size)) {
> -			ret = -EINVAL;
> +	if ((mhp_flags & MHP_MEMMAP_ON_MEMORY) &&
> +	    mhp_supports_memmap_on_memory(memblock_size)) {
> +		for (cur_start = start; cur_start < start + size;
> +		     cur_start += memblock_size) {
> +			ret = add_memory_create_devices(nid, group, cur_start,
> +							memblock_size,
> +							mhp_flags);
> +			if (ret)
> +				goto error;
> +		}

We should handle the below error details here. 

1) If we hit an error after some blocks got added, should we iterate over rest of the dev_dax->nr_range.
2) With some blocks added if we return a failure here, we remove the
resource in dax_kmem. Is that ok? 

IMHO error handling with partial creation of memory blocks in a resource range should be
documented with this change.


> +	} else {
> +		ret = add_memory_create_devices(nid, group, start, size, mhp_flags);
> +		if (ret)
>  			goto error;
> -		}
> -		mhp_altmap.free = PHYS_PFN(size);
> -		mhp_altmap.base_pfn = PHYS_PFN(start);
> -		params.altmap = &mhp_altmap;
> -	}
> -
> -	/* call arch's memory hotadd */
> -	ret = arch_add_memory(nid, start, size, &params);
> -	if (ret < 0)
> -		goto error;
> -
> -	/* create memory block devices after memory was added */
> -	ret = create_memory_block_devices(start, size, mhp_altmap.alloc,
> -					  group);
> -	if (ret) {
> -		arch_remove_memory(start, size, NULL);
> -		goto error;
>  	}
>  
>  	if (new_node) {
> @@ -2035,12 +2056,38 @@ void try_offline_node(int nid)
>  }
>  EXPORT_SYMBOL(try_offline_node);
>  
> -static int __ref try_remove_memory(u64 start, u64 size)
> +static void __ref __try_remove_memory(int nid, u64 start, u64 size,
> +				     struct vmem_altmap *altmap)
>  {
> -	struct vmem_altmap mhp_altmap = {};
> -	struct vmem_altmap *altmap = NULL;
> -	unsigned long nr_vmemmap_pages;
> -	int rc = 0, nid = NUMA_NO_NODE;
> +	/* remove memmap entry */
> +	firmware_map_remove(start, start + size, "System RAM");
> +
> +	/*
> +	 * Memory block device removal under the device_hotplug_lock is
> +	 * a barrier against racing online attempts.
> +	 */
> +	remove_memory_block_devices(start, size);
> +
> +	mem_hotplug_begin();
> +
> +	arch_remove_memory(start, size, altmap);
> +
> +	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
> +		memblock_phys_free(start, size);
> +		memblock_remove(start, size);
> +	}
> +
> +	release_mem_region_adjustable(start, size);
> +
> +	if (nid != NUMA_NO_NODE)
> +		try_offline_node(nid);
> +
> +	mem_hotplug_done();
> +}
> +
> +static int try_remove_memory(u64 start, u64 size)
> +{
> +	int rc, nid = NUMA_NO_NODE;
>  
>  	BUG_ON(check_hotplug_memory_range(start, size));
>  
> @@ -2058,20 +2105,21 @@ static int __ref try_remove_memory(u64 start, u64 size)
>  		return rc;
>  
>  	/*
> -	 * We only support removing memory added with MHP_MEMMAP_ON_MEMORY in
> -	 * the same granularity it was added - a single memory block.
> +	 * For memmap_on_memory, the altmaps could have been added on
> +	 * a per-memblock basis. Loop through the entire range if so,
> +	 * and remove each memblock and its altmap
>  	 */
>  	if (mhp_memmap_on_memory()) {
> -		nr_vmemmap_pages = walk_memory_blocks(start, size, NULL,
> -						      get_nr_vmemmap_pages_cb);
> -		if (nr_vmemmap_pages) {
> -			if (size != memory_block_size_bytes()) {
> -				pr_warn("Refuse to remove %#llx - %#llx,"
> -					"wrong granularity\n",
> -					start, start + size);
> -				return -EINVAL;
> -			}
> +		unsigned long memblock_size = memory_block_size_bytes();
> +		struct vmem_altmap mhp_altmap = {};
> +		struct vmem_altmap *altmap;
> +		u64 cur_start;
>  
> +		for (cur_start = start; cur_start < start + size;
> +		     cur_start += memblock_size) {
> +			unsigned long nr_vmemmap_pages =
> +				walk_memory_blocks(start, memblock_size, NULL,
> +						   get_nr_vmemmap_pages_cb);
>  			/*
>  			 * Let remove_pmd_table->free_hugepage_table do the
>  			 * right thing if we used vmem_altmap when hot-adding
> @@ -2079,33 +2127,13 @@ static int __ref try_remove_memory(u64 start, u64 size)
>  			 */
>  			mhp_altmap.alloc = nr_vmemmap_pages;
>  			altmap = &mhp_altmap;
> +			__try_remove_memory(nid, cur_start, memblock_size,
> +						 altmap);
>  		}
> +	} else {
> +		__try_remove_memory(nid, start, size, NULL);
>  	}
>  
> -	/* remove memmap entry */
> -	firmware_map_remove(start, start + size, "System RAM");
> -
> -	/*
> -	 * Memory block device removal under the device_hotplug_lock is
> -	 * a barrier against racing online attempts.
> -	 */
> -	remove_memory_block_devices(start, size);
> -
> -	mem_hotplug_begin();
> -
> -	arch_remove_memory(start, size, altmap);
> -
> -	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
> -		memblock_phys_free(start, size);
> -		memblock_remove(start, size);
> -	}
> -
> -	release_mem_region_adjustable(start, size);
> -
> -	if (nid != NUMA_NO_NODE)
> -		try_offline_node(nid);
> -
> -	mem_hotplug_done();
>  	return 0;
>  }
>  
>
> -- 
> 2.41.0
