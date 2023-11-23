Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D4F7F584F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344799AbjKWGfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344782AbjKWGfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:35:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE25D67
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700721327; x=1732257327;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=N9m7SpOVWldYJ8ChnXCbRIb7PdFe7q1FmrM2X3JuN5w=;
  b=ZKv/jMPqW2tStNLbMNA1wwhQDspIM1HZZ2dU6ZJKW/3aIsSzpGRdls4K
   UdT0ASKaM6yugjfrxSAy1UB6dHDd7hXGnr72lWm7MVoiAJ1GbfhwlYw29
   OXnTNjfNvcvkk5ahym1KstatGDYYV9FfM/IHJfSFkt//Odc08XREp918O
   NUFdHRYBIUBWdAuTN+4G2fQ9Pa5ueE3R0O2EgWcpqGfaad53KYqzvXUuK
   9cb8SZFkt9YZ+DO6/IrYxK6Vz1qZqM+D7PPYZFho3u1r9Mr1ADjvKx8RN
   QEThfWFcVYWfOwes5cXzQ58twBOeg3zJHK916T6aDkBjwJbej6fzbgty5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456541783"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="456541783"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 22:35:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="1098698439"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="1098698439"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 22:35:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 22:35:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 22:35:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 22:35:25 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 22:35:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkur1vYs8/lGB5J2DD0T8biNshB+ngms2wOsBX9XbeiXTU+wJIEm7UeWE5Cl9ZfbrI88spq8XDWIrvCJ4lTqd3UH9DCPh1X/dXsfJYvOe3T7OI4UheT/RPeFJmqC4qcji9COtMO4dFuejIRoVmUioSP5/M3i4I1+SdFh58ZFrgi+Vu+U/QKsOWMhMcPFkPqPHLGD/kc2tutMF7t5vwnBQt5tvaFVNs/U9I5IWfvN4KsFGZBWd259YGgmZVJqbSw2Vlh6sqyTxckctNtlUiDm7VYT/ZZsjP9qLekUMPrGCIepsfv8POWsDZjtGM2KiWVCzqjYwVZQlU9q2TJbP4Nvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xl2vIlz9Rx2wfctzeaJXKx2eaI9u2Vl4okxkE0H6mfQ=;
 b=LpI5cnvAfedV1ZcmIvQljE+FpOnRu7uv1mNGl0sXhQIEN/3YN2DHgiBkl16SO//sNG1uBldJgnxArkJk+vvCxnbp4xXzu2qT7rt99QjcM/HWwSRZ1X1lh//gtpsz7ixMNNXGIgnl+9q2Dgh8Wd4Oyjv9UZ1gld+rnetxbKkhvGuxxn4N27aukDdWHapC3CLQMNZeFZ0vc8FAnttiFsjnFWq2zLW4KfPSQOgD82zLp86dhsk5JvLAq5ug/8O1mFfgydWgkjRMCoqXRomgy8IjCTlywqjs+PZqm0oWJiCzKINZi7dCqKbVtue/06runOPyPFb6xrRWLpJ70Vj+H8htGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CY8PR11MB6868.namprd11.prod.outlook.com (2603:10b6:930:5c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Thu, 23 Nov
 2023 06:35:18 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::24ce:9f48:bce:5ade]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::24ce:9f48:bce:5ade%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 06:35:18 +0000
Date:   Thu, 23 Nov 2023 14:26:13 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "andrey.konovalov@linux.dev" <andrey.konovalov@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH mm] slub, kasan: improve interaction of KASAN and
 slub_debug poisoning
Message-ID: <ZV7whSufeIqslzzN@feng-clx>
References: <20231122231202.121277-1-andrey.konovalov@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231122231202.121277-1-andrey.konovalov@linux.dev>
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CY8PR11MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: a39392f8-aefc-4f8b-75cf-08dbebee5bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brQbWZTLNpqhdsd8ErRE5JhryRK2vYx0KOFQsj64Yg6wPNYQ6u2eos2Ho33jJmHr9ZRz5HnKuO6q3/at7d7fgls02qbsgpSMr9K6FS+4EE/A5HJUvl0TnrlFi64J2wf6M4ru70zottBwE6gUXTPa4ZV3z+AlTnzhK40/AhnR6f8oKZHK7qBeZ0Rx875k+5oR/YajC26QPqKfwjDXdsnjOF+MTpTwfWq+0LrSrjylxoqUYZZog4fjsSHSvGvrWTaF8p8KiXtujk18B9PJps7WEsVZXsW21oJEKrRfp6fnrCUYW5/T7SHK+nFOomA/9JnFkTL+1zpXZ/RdGhHciQFLA3nFUargMi8Y0dE90p13uvpThxLWWaMyHHlne17DaJwx/TV+42OGOaGSsWxqB1x8SNklfe6FPmoV1ylrd3cOBvS+5qwKWRyapS+L0QCtCykIUmkhGKTz8+UYEWm/5ojBajLbdygeb0K80a3nlMgdxd4NCdp+fm7p5JnkH/PQEsuriCm5QHdfbgSnvDYLn+xCDYLEhhmH8QnQ/8aA3485YpCygcz9WSsg16bhllIDkLSh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(346002)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(9686003)(6512007)(41300700001)(33716001)(83380400001)(5660300002)(26005)(82960400001)(4326008)(44832011)(6506007)(7416002)(8676002)(8936002)(478600001)(86362001)(6486002)(66556008)(66476007)(38100700002)(6666004)(2906002)(6916009)(316002)(54906003)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x0RiTcjRLpN/Mv1IPhKVAEqOBGFiDu0XDGELDotRnmqL+8kh6/zx2impQCH8?=
 =?us-ascii?Q?mS92OImYqE9LKqOBA+bt/mqeSWaPxwRH4rJ6xm2Y2AE9Pq4bh0X1rR2OxqdX?=
 =?us-ascii?Q?1lWo4bLmL0HeyzWZinpUac7nrEuXX9g0nIHBq6Qx53q3GzyGo2g07SbkXUZG?=
 =?us-ascii?Q?Ns17APEqlxFy2up6xp5lL8KsDp787/fPVXnbKp/EF/9wJxarsIzw3w0aVR+1?=
 =?us-ascii?Q?/NLTcFsGbs7Ik7gf3hbYAVfpl29R97khrwhjkqBIwyqxqHMYlcM0RvN+3Toj?=
 =?us-ascii?Q?IMWZJa1PFWjKvRJ3VOjUwTDctfdYEjG4J8Ad8O94Oa8ohzo7ZolC7Zi1GDx0?=
 =?us-ascii?Q?0ixqMnY5LJX0Fco3tuRJDfLd7iG6axmxmjm9pVSjAtqT+ktLCiJMQP0frbvy?=
 =?us-ascii?Q?w/xVw4uzzJdif+5Ru2bSF4Z+DJxQSKG7jhJqNd/XLv7bS7qRbUMH2wX9mqMu?=
 =?us-ascii?Q?Ahgdg73VPMHQb89I1hFhj6FB7QgujN8jQwuKyR00QhLeBncFxNWCWcNM0QJW?=
 =?us-ascii?Q?kXvCnyLqs6eKfyGsKJzCBnpLVLKCvVrkeH5oSWg2uEkC6YDLzFkp+1oZube7?=
 =?us-ascii?Q?QKC1gQwxXnJIrvIGquZL9eZrWzXeIlviZ1ATRhZoIuVyO1wRLW+iGWq9FcNC?=
 =?us-ascii?Q?LTUoSyf2D4R11AXg5QGnjat7/FQ7Wi59touKY6dB+IkJpiDRO4g33TrswLNk?=
 =?us-ascii?Q?0AS2SWUMoV0CdMWSNibSZQdG6VIOqILyeH73y6h9d6pPNXcH9Khr9pelf3pn?=
 =?us-ascii?Q?0k1u3r6Kq6vAco928XZlpZmtNicjn86ltCSE7UarogxtAOxE6HAeXzr47UEB?=
 =?us-ascii?Q?sbFimiyWHZoxzUv86qvHqdUMxQHjWkNcsL2UlYyGjSR9WO2KjveTe4WqPfqK?=
 =?us-ascii?Q?6KYVCVxEqt2QInKheuBc9Lk70jM20Wwtq6Z5cxPm0BKyHCheLqVlFvvI+AqD?=
 =?us-ascii?Q?P6cljSPMA1u9myJB2ash9mXF4EALCzVZpYpKEGUij2UyRiqTpXWQBNMfWvX/?=
 =?us-ascii?Q?QEQfzQBWcWNj8wEJQX4/V/suxfaN7ySzARazNAVqwf/YkqNH5R86uDVv3OvQ?=
 =?us-ascii?Q?Y2eUq9ON7OkNP5AHGOo+1g4Y/QkEoGhvvNbE0OySEdl5EhsQcyl4U70vuUHS?=
 =?us-ascii?Q?VQ4CQJyUPVWpayFhxUnCRyVMKg3SfInlNXimhxKffXoZGJ83OvqjXoCiH3dC?=
 =?us-ascii?Q?D7yM6asxhsY2PxTEGWXhSoAl/JkLNn1cGkhCpNDsRBgmlNqB5x2n48OLUC8L?=
 =?us-ascii?Q?6QDihxbON4yC5RphSW4xq6E5/hjtRgOaANCqkxSAwBDDA9ztRSFyshrj952K?=
 =?us-ascii?Q?4LDjuITG+PCKdFoMmpsJQk6W15Uc7epxucndkHkOyOLZRm0cu0YsyFl/aATU?=
 =?us-ascii?Q?XOwAtJwwmBgcGu5XeCFY6jcdP2MyeavCOlWLELliUkQ1kC/WxbhUl54fGK/g?=
 =?us-ascii?Q?f1afsJuqBkDoHad92kYjbXccXHbY+WNX8a1btYkQasfXolqf6BmvqJHOV8E+?=
 =?us-ascii?Q?0wOYRXlazXqyq3YtF/76XgQ4zlwkjE/CfonGWtdmH3pHG5Xmk9ibQgl5B0Zs?=
 =?us-ascii?Q?wkNPWfCj8+lCBjWT4/7WZkLJ4Y8xJjTA2J9EoTB9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a39392f8-aefc-4f8b-75cf-08dbebee5bac
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 06:35:17.6929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R11T4pA7dFg/0B+3Sh3b/v4/WZAmXfHbyqTqOrS6Zl/EmDyCYEMlc0xJ87xcDfJK4ooWYqZv2kfJ3baN8oTyOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6868
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Thu, Nov 23, 2023 at 07:12:02AM +0800, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> When both KASAN and slub_debug are enabled, when a free object is being
> prepared in setup_object, slub_debug poisons the object data before KASAN
> initializes its per-object metadata.
> 
> Right now, in setup_object, KASAN only initializes the alloc metadata,
> which is always stored outside of the object. slub_debug is aware of
> this and it skips poisoning and checking that memory area.
> 
> However, with the following patch in this series, KASAN also starts
> initializing its free medata in setup_object. As this metadata might be
> stored within the object, this initialization might overwrite the
> slub_debug poisoning. This leads to slub_debug reports.
> 
> Thus, skip checking slub_debug poisoning of the object data area that
> overlaps with the in-object KASAN free metadata.
> 
> Also make slub_debug poisoning of tail kmalloc redzones more precise when
> KASAN is enabled: slub_debug can still poison and check the tail kmalloc
> allocation area that comes after the KASAN free metadata.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> 
> ---
> 
> Andrew, please put this patch right before "kasan: use stack_depot_put
> for Generic mode".
> ---
>  mm/slub.c | 41 ++++++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 63d281dfacdb..782bd8a6bd34 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -870,20 +870,20 @@ static inline void set_orig_size(struct kmem_cache *s,
>  				void *object, unsigned int orig_size)
>  {
>  	void *p = kasan_reset_tag(object);
> +	unsigned int kasan_meta_size;
>  
>  	if (!slub_debug_orig_size(s))
>  		return;
>  
> -#ifdef CONFIG_KASAN_GENERIC
>  	/*
> -	 * KASAN could save its free meta data in object's data area at
> -	 * offset 0, if the size is larger than 'orig_size', it will
> -	 * overlap the data redzone in [orig_size+1, object_size], and
> -	 * the check should be skipped.
> +	 * KASAN can save its free meta data inside of the object at offset 0.
> +	 * If this meta data size is larger than 'orig_size', it will overlap
> +	 * the data redzone in [orig_size+1, object_size]. Thus, we adjust
> +	 * 'orig_size' to be as at least as big as KASAN's meta data.
>  	 */
> -	if (kasan_metadata_size(s, true) > orig_size)
> -		orig_size = s->object_size;
> -#endif
> +	kasan_meta_size = kasan_metadata_size(s, true);
> +	if (kasan_meta_size > orig_size)
> +		orig_size = kasan_meta_size;

'orig_size' is to save the orignal request size for kmalloc object,
and its main purpose is to detect the memory wastage of kmalloc
objects, see commit 6edf2576a6cc "mm/slub: enable debugging memory
wasting of kmalloc"

Setting "orig_size = s->object_size" was to skip the wastage check
and the redzone sanity check for this 'wasted space'.

So it's better not to set 'kasan_meta_size' to orig_size.

And from the below code, IIUC, the orig_size is not used in fixing
the boot problem found by Hyeonggon?

Thanks,
Feng

>  
>  	p += get_info_end(s);
>  	p += sizeof(struct track) * 2;
> @@ -1192,7 +1192,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>  {
>  	u8 *p = object;
>  	u8 *endobject = object + s->object_size;
> -	unsigned int orig_size;
> +	unsigned int orig_size, kasan_meta_size;
>  
>  	if (s->flags & SLAB_RED_ZONE) {
>  		if (!check_bytes_and_report(s, slab, object, "Left Redzone",
> @@ -1222,12 +1222,23 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>  	}
>  
>  	if (s->flags & SLAB_POISON) {
> -		if (val != SLUB_RED_ACTIVE && (s->flags & __OBJECT_POISON) &&
> -			(!check_bytes_and_report(s, slab, p, "Poison", p,
> -					POISON_FREE, s->object_size - 1) ||
> -			 !check_bytes_and_report(s, slab, p, "End Poison",
> -				p + s->object_size - 1, POISON_END, 1)))
> -			return 0;
> +		if (val != SLUB_RED_ACTIVE && (s->flags & __OBJECT_POISON)) {
> +			/*
> +			 * KASAN can save its free meta data inside of the
> +			 * object at offset 0. Thus, skip checking the part of
> +			 * the redzone that overlaps with the meta data.
> +			 */
> +			kasan_meta_size = kasan_metadata_size(s, true);
> +			if (kasan_meta_size < s->object_size - 1 &&
> +			    !check_bytes_and_report(s, slab, p, "Poison",
> +					p + kasan_meta_size, POISON_FREE,
> +					s->object_size - kasan_meta_size - 1))
> +				return 0;
> +			if (kasan_meta_size < s->object_size &&
> +			    !check_bytes_and_report(s, slab, p, "End Poison",
> +					p + s->object_size - 1, POISON_END, 1))
> +				return 0;
> +		}
>  		/*
>  		 * check_pad_bytes cleans up on its own.
>  		 */
> -- 
> 2.25.1
> 
