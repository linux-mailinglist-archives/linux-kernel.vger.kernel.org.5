Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2D57BABDE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 23:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjJEVV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 17:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJEVVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 17:21:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1545293;
        Thu,  5 Oct 2023 14:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696540884; x=1728076884;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jZiOl+fJ/HqK3stYB7JNOip5gZ0VCOjaFpcDWav/Qmg=;
  b=SYeR5/anhjOWOoConpmUFyJo4Dv8j5sJxKn+uRVFfE7b4EafVRrRL4nM
   0D9NxrR6R/s2E2IzytwC84dzdu1uwJIQ4Lq5CUHSXTBwWsoABAtJ+XwCT
   pqlFqpbCgVNvRvC2Ftoqf5Ym5XlSUe0O7TjrQO/37QKxpgh9QcD5fEFn/
   +SEmIxQgLFgdIyE/4tQGL79G2p4CYsb3vY2kHNoDAZCOk4anwl9JOXvjp
   QTvD0uMwOufUigVP9SNf/OgFyVqZsR3JpGeenJM0UXJS2jgc0QFRShzu2
   Y/ZpMNUW9dtmuhjFCFJBBcCmfNQGte7H6AHoHAZwAskyDqoCY+mvSUcIz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="5181665"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="5181665"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 14:21:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="895615609"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="895615609"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 14:19:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 14:21:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 14:21:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 14:21:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hftgwpOilsL+hQu/LlYBw1HSFjFwokeQwv2wtxWt4AyA0zvHj2dQ8KDuJK/rRIyVGvOyZDby++4q95kXXcLOwv29ixsAgYy1pHxEnQpjiKRrMF1Nlun/VIHaPd+FUhh435PwqsiQI++qJuN4GqdzxwRgvSCDE602xZkyY3hFO3eDntj0NnZkxuptLw4uKSDdt+UOE4B+1mQOG5OxvvATDL5ypzvJh/YNrgDF6eG4ZR90H9DmaMiPZT7ovGR9GCOvqurtOj02SOJzdnvzu8o6oTQuS5ZdtH49XaWowkml2t8WKytYZvKI4s34v5jJJmVZpkbQV/i0hw1A4B8rckEPlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/351L/fMzO4AWk4CXTa4RP4m1IKnVgeHo5E5KgJZOg=;
 b=cNwdUwnweUYCu/nzV8lKUFhdyBgljZMLXWvuTRfxvNRf0Fc3yE9tEUqh1qgsDzeFuZ8deEsQDgVtBLsLUb1KOL1QCeP7LVXrtj/cpTpc5MG0KXtwqyWwc2TmroT9+WYHsmt+csNcfEh1c9p9/ASOQPG+gAtP5av0t9kJaV0spE6vSm1eH45pJkvogAeE/+eeH/eeRRWH6K3TSs3AJ8a15kc0s7ukWEqXGGFrsEaNe6pdKb6UCBHWf88K1FCNjK/pJS1m3c2ZEDiMzK0/yeHz5SVevyqXzEllSCozSiKkT7RZOSVax0mjVZPVa+GSzwfAdyckGeituxIhcXoTDHrcLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BY1PR11MB7982.namprd11.prod.outlook.com (2603:10b6:a03:530::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 5 Oct
 2023 21:21:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 21:21:00 +0000
Date:   Thu, 5 Oct 2023 14:20:56 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Oscar Salvador" <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: RE: [PATCH v5 1/2] mm/memory_hotplug: split memmap_on_memory
 requests across memblocks
Message-ID: <651f28b87e6a8_ae7e7294b8@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231005-vv-kmem_memmap-v5-0-a54d1981f0a3@intel.com>
 <20231005-vv-kmem_memmap-v5-1-a54d1981f0a3@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231005-vv-kmem_memmap-v5-1-a54d1981f0a3@intel.com>
X-ClientProxiedBy: MW4PR04CA0271.namprd04.prod.outlook.com
 (2603:10b6:303:89::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BY1PR11MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 4048eb08-3ab9-4bcc-e725-08dbc5e8f8d8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /r/RgTKOOsX25SsoqLLrzKLKJIs3RBQ78TtmDTdiaNQHaYzZTRDTDcmUPtuArl7B/ue2unEXI07rxaorTK/BSq06OTgIsz6uhAkjHPiBh0tvXhu0rpUdyesW6U8MnrNPtogf8ttboole6wjYqgqgKJYa44wSW6bBkxLXtuwOl2uzWWFtklL8AMFL/pekYTXPb4Fnd13B4GdYgVLsujfJEMCukVJ00M5VyenLPedkgmtRLfnWjuFRz9p40IFFZIXKMagsH3hEq9YOlqUwaq7oeoYIQzJWoJhaNGN2gG99jxfCo/MFB0SmRzIHJ0JHlMLh2/xpLF4kCeoqrwxfXJeEwIrz6XvgGgY2mB7ohLVtZj3rc1UvFBG7V2QUN/3AuCZAWKrupy0lfwBVOcqnyhY6ASjF9+X8k537cpGn6dVHupp9CoeNIyUxx4vlkFFQ0nddE4ECa8Cp3VsoIouXB22yQuOOQ7HRktmmKJ07gyrGB6U4UPt9kMxf1QBxqWUzhcQyPXvaGArdSbQeCeAYj7CTDnaPoUbII+sXBhu6ZqgocWqQNZAkyd00WA97Skn7iGeM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(39860400002)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(7416002)(5660300002)(8676002)(2906002)(4326008)(8936002)(41300700001)(316002)(6636002)(66946007)(66556008)(66476007)(54906003)(110136005)(26005)(6666004)(6506007)(6512007)(9686003)(82960400001)(38100700002)(83380400001)(86362001)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?udKZmivdH62PRMPBs8MV6FiNulujzELg0pUhClUH3qu1/v+lLKaKHh4UyPdh?=
 =?us-ascii?Q?HfTR+NmJNqRNkwzdEqBL2l8gi6XHQYWBXcUNvGeqK6X7AlVOPkDqXQ/wklhX?=
 =?us-ascii?Q?hr4euvhXDUpTgXu/C0jGEAvq9kYDiFpTgH+SwtXDJslaIk6NdZ4O9+J8Rgio?=
 =?us-ascii?Q?rfKVuc+R+sYdJWiS5KefSy8O/PjfIOBUfx0TFen+jQ36XkEGrxzhS10GuRwh?=
 =?us-ascii?Q?wVBud0nPGF4g+NLbAEQ+5dr/THfc6v03VuCXfynfhPv2JC6OeTLpfK3piQjv?=
 =?us-ascii?Q?U5F0aj9TP2yuaAHpmI1sy3q3DFeiiFzk0g4DNgh0aiVs+o9rXXScnvKnkfqd?=
 =?us-ascii?Q?jrUx5N2evjoA66Dl5rjrSQ5emAJYyX6kAyssDh4AIpMVFLYxPBRGE7rA9tNc?=
 =?us-ascii?Q?89S0Oyo4F479B+Kk3fhuzm7WGW/68I/TKqCsXvKM9vpI0vL2ujgtYv62Hxtc?=
 =?us-ascii?Q?PEsTqMu/9OW+lfhSun14f+cWrLKQjCBofxqxcR2scYonfaCCjxljwxn3P0pM?=
 =?us-ascii?Q?0BEWh6olYQ5VleVGc5IUr7q41Fli/I9RTRU8rTDDThXXmInicXwPy5jxfwBI?=
 =?us-ascii?Q?mTf7HRCJw0W7sBXz3UJCdMOO61Cfjn/8CVTdYcWhaJHqq1+8OMsu8hHSR29p?=
 =?us-ascii?Q?CKgjbauCvxUY8tPv6TZlgIwmiVnr/G+NWSuhbi9ZLquqcbH2Sak1elzG4MNS?=
 =?us-ascii?Q?4AHJ0SO4BLVXc+GBTpMhAQzX8SuTLSVomjGUYhcAHQmHDxAgJENpmEKuVBue?=
 =?us-ascii?Q?2vJST4UYSgb0zmqwYhvCclRzwyRAtF0JZLgw3Y6XmFDTUnJEgTGXpboibdTl?=
 =?us-ascii?Q?8SpnUDqMnnzf2xPX8aS4i3gWnxoHP/AqAYRGhRIoHZbyeixdosXV04wXoWC1?=
 =?us-ascii?Q?QQbzZG0V458rS6b5pn/NYmZ/IIxTIu3cPWHozQAMNRYYn3F4atKgmw3bnLm8?=
 =?us-ascii?Q?wFWuodXMghwhTKiRx7mS2rl2CyOph9G5NQEmKYWcM0Cc5cxXDXPCBgiZwCks?=
 =?us-ascii?Q?3dkqTcowozEhg2iVEzKPiSnymS8rDfNEfof18wl4JKjx9NyJ6e3vkyPBkRJO?=
 =?us-ascii?Q?B6879skfKg9r3yBrPI2Xe7YXngfD9ce94qnwAW8g+IDWjFs31jCCSz3frb+n?=
 =?us-ascii?Q?7gqD+DVrmAhIrAPEvabDjs0uhPaHlH0Rq3kBvA44W708ftFi0aoQq4VfYbmQ?=
 =?us-ascii?Q?Uha3ZU108J6mkTS2wA/+ytsOt+IWuBgx+lX6ydnR7p/caM3C2XqQVnyv3k2A?=
 =?us-ascii?Q?eaKhaXaataR/To6zTEwEw8x7TgjzwKWi0RSCSDuKvbEtvXLv/9iWta1uquZ9?=
 =?us-ascii?Q?uu6M+MWJQciHmW7NxjMGFKR9H6nZSL/ch5eqqqKHZOtLgAQLf+2T1hSYCmMT?=
 =?us-ascii?Q?vnQBthRN4XY4EwPX0XcuQWBzSn6qpOKcFYsAEee4not2eUwpCjxyBinRBC2L?=
 =?us-ascii?Q?7xO95UzHTXE0N7Db/MOitj6Y0xPVVW5YeBGkuUXaYQ/QdnfzWwoQvrFu/eci?=
 =?us-ascii?Q?mZCHRDHJanNaApgqdVK9aSjLY1MOORuje1MxLA/md/AhkgutQAJ/zrFJ7Ivz?=
 =?us-ascii?Q?rYhMF/OyRaA6ekveD0WfOSFwdm+a2w+51rLYFhgF0Dgbx5CU8+Qg5EkVPZSO?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4048eb08-3ab9-4bcc-e725-08dbc5e8f8d8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 21:21:00.3008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxGpK//FuWMGyRsg2Wspe201ZMA0dVInH41bQ4krFJzENps70zYkMudHltOxzw1n+W6uJPpGo6ogiBJ2cQvbrPbLJPUYl9UTeAeN6G0EsBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7982
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vishal Verma wrote:
> The MHP_MEMMAP_ON_MEMORY flag for hotplugged memory is restricted to
> 'memblock_size' chunks of memory being added. Adding a larger span of
> memory precludes memmap_on_memory semantics.
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
> it are met. Teach try_remove_memory() to also expect that a memory
> range being removed might have been split up into memblock sized chunks,
> and to loop through those as needed.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  mm/memory_hotplug.c | 162 ++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 99 insertions(+), 63 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index f8d3e7427e32..77ec6f15f943 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1380,6 +1380,44 @@ static bool mhp_supports_memmap_on_memory(unsigned long size)
>  	return arch_supports_memmap_on_memory(vmemmap_size);
>  }
>  
> +static int add_memory_create_devices(int nid, struct memory_group *group,
> +				     u64 start, u64 size, mhp_t mhp_flags)
> +{
> +	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
> +	struct vmem_altmap mhp_altmap = {
> +		.base_pfn =  PHYS_PFN(start),
> +		.end_pfn  =  PHYS_PFN(start + size - 1),
> +	};
> +	int ret;
> +
> +	if ((mhp_flags & MHP_MEMMAP_ON_MEMORY)) {
> +		mhp_altmap.free = memory_block_memmap_on_memory_pages();
> +		params.altmap = kmalloc(sizeof(struct vmem_altmap), GFP_KERNEL);
> +		if (!params.altmap)
> +			return -ENOMEM;
> +
> +		memcpy(params.altmap, &mhp_altmap, sizeof(mhp_altmap));

Isn't this just open coded kmemdup()?

Other than that, I am not seeing anything else to comment on, you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
