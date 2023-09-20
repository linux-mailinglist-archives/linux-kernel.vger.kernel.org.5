Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1021D7A83B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbjITNpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbjITNpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:45:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6603AC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695217546; x=1726753546;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=60Bsxv8ngUJ8xyYO7UsOfpsTcnrO+LXqtU/F0Pt0Hk8=;
  b=IxF9A5QxmfUHeU2ktgNsy66MbdCsIVoZUmvwzF7s3Gu2hnBD1fatTijt
   fC7rgzbFMdOSj5f3vWT9UOC5WSpfM+7vkJ1pxrfMeDuv1fQbIl89jfNXD
   74Ewm8LqfBc4NBOnHNMomNbNbByeFUEuhkbLzQv12OqfRzJ/YDERYYxBx
   SxrYnK+u/qXSpY+xAzl+BYjxACgRIvyjU2HCKi9ZDDJ2F+ghonyI8uWLD
   fbkQIzlKgSvFxm9MLYlpx+cPqS7FcdwVjoL0fDpu99rpmvs6yyyNq7oDO
   x118ugHPuzr1i8cfexjZQr3ChuWAh1uLYiu9erGtn+FSzGulwBO32i/o3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="382968977"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="382968977"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 06:45:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="836849498"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="836849498"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2023 06:45:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 06:45:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 06:45:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 06:45:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 06:45:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmtLG7TgOIqEsMImxU/7VpqoFLuAsYN+RhcNBjDvWCq0aIJq6LzZO02f8c3RofDoxwCiWUgxuUtSLlpfXaZflVuXFKzhDcfq84/H3ACvUkIvt5p5r0Hbc2WNYwuxq/WgZVCa7SXziWCq/bnFX5LQ3xeqWZWsCmsdgjvJ48wuEVldz/TL4uEcTvyOo370RpmQ2j8+P7l1rSt68T7gUcNCpy8YrNpUiExklckyv20BWONVySN8OIYfFUlZ1GAn5MNxUQba6Se/MISM5B2OjaG7Impr8AF4gwdBWm5kLC2cwzwXY/xFCbtZbs/f1qZ2jhQV0Q6mkRufPs3WMiDtho1maA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5aeN67t30pGFXYO1Kn2l+83mdMd41kuip42g+hI27Y=;
 b=G2HLDbfHi+MgL1kKblHOK44bKvYpoZvhCo09qBVcGldp/aanLzFbn6r81iGSsJyO5xseHnRtnF+IsL6p/eN9rQ1LXYD0GGXrb9U3Dd+iQ6bviq8an7Y8e5ujCmSRQ0Mu0zHlQ2T5EfEe1kiVESveVaxIsnP23FdaWr9f93fn1i8sfGgIG7ZGoaO6T7kEg+p8zVMvYfQpcjq96ACSkvJ8/tE6U5b/nRR3sCt/GhSrS8D/2++RoOcKyIKnrROasGXzGXioPSma+mUHYmLpG4m/eVoQnjowTJtJXSOMPMWXs0hzibdh+GPnA6gHsIRmyw2dsR4Jmye0m6BgU7RAImEuYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SN7PR11MB8041.namprd11.prod.outlook.com (2603:10b6:806:2ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Wed, 20 Sep
 2023 13:45:43 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7edc:de45:7f2d:9ade]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7edc:de45:7f2d:9ade%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 13:45:42 +0000
Date:   Wed, 20 Sep 2023 21:36:11 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Jay Patel <jaypatel@linux.ibm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] mm/slub: refactor calculate_order() and
 calc_slab_order()
Message-ID: <ZQr1SwNeNA+nTpzW@feng-clx>
References: <20230908145302.30320-6-vbabka@suse.cz>
 <20230908145302.30320-10-vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230908145302.30320-10-vbabka@suse.cz>
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SN7PR11MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 872d16f0-32aa-4fa3-80c9-08dbb9dfe1d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zd6B4Uch2EdrNmh7tfyom90unrDRpIUmZ+ylvyi9nsrWtRiKAIAnmutgPVQZFTi5QjTnnHPbEFqXRWkRgyLHr9u991+y3fodwSwIY48mDZmdebBM+47nv3mnr/whSZ8enBb9Wyz9c9FlF2RWMfdbK9Mpmzm3I8huNzdJjhxUFcsnh4m46ULkwye43hZrPaA14anYc+UyNZKMp5jTJEUaS33cP8N5UkQkNNImEwv/dfxUqsySbwP8ztF9O63dMpTnmfMnautqTdsoGUvyuvhvqKvwwUzgTqAq5s9RCRXCE4Mj/Tcxh1YtjLJScUinAsvlDlHJ+I7BQWNw8Aj0u5Zo09Ji+M5JJe43Zcbs/jHHZ8dGWy6twBTEUKzUbgFN+qRnbDD4+2sjubgoT47LPSlGaEyb3670oMd65Xae4/bUIFms0BUkSP42fiQFFonhUfKRj/v/fsfRd1D++lcigik7Hsta19jOqdC4ANwy+0jQNuDQdhn9xGjMHvXU+e9bnVfdmOBINYybxQBXUNuLhpI4JorVG4v28IBhaNm66zbSrFEeNf8UVO4rFT9YElUTjkoZi4dKjgT77o2eaVhUzdakcWdYkRXMjIeGRNckWTnXvuo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199024)(1800799009)(186009)(38100700002)(6512007)(6486002)(9686003)(6666004)(26005)(6506007)(86362001)(82960400001)(41300700001)(33716001)(7416002)(2906002)(478600001)(5660300002)(83380400001)(8936002)(316002)(44832011)(6916009)(66556008)(4326008)(66946007)(54906003)(8676002)(66476007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rv6o3D3TszUBPfX3ofM6jbDIT7VEUdW/En6xsYrSAbYrvn0kYTC9UhXxpNj/?=
 =?us-ascii?Q?u6d4GFnxqYyGJaM3XTy9rt1proHa4c816GUubVTYg2F34O3/IZ4kixNCKWFz?=
 =?us-ascii?Q?W19BvU3PMF45xHmIv+nUw82xaL81r02Nvy78gOqc3jS/M2zWoGHPvqlmiLdd?=
 =?us-ascii?Q?KwLfl68r/BjNDjnY/lgCDdHmsLuzRP/F1E0y436pTtvSzNSodEEyU5floW8y?=
 =?us-ascii?Q?e9fKsRh6cefnQmPPL9nKf9Esi5Mj1illmBlotutL7J9IE+AjfaOFXYJh0LBm?=
 =?us-ascii?Q?2dDBl1ebkCulochodK8wx+gOaJ40gjd25oQxVwSGMU0x/00NEmwASXc/sfYw?=
 =?us-ascii?Q?cXjH0T79pXZ79m9Hdux+e5Mvn3QKZyBE5RQD5STD/n2FKZZ0dOGBBu+HufTC?=
 =?us-ascii?Q?iLrMaRTBJNqPGYQNk48jKeUC0FdR0TtbAU+2TnXBnciD+mpBG7jeacKTNaoy?=
 =?us-ascii?Q?0gUC0vHKE01uS7R/ENhWGPp0Skzb9SFdiqSKMh3NmV3l7gY9p7d01CrZogxh?=
 =?us-ascii?Q?ispnS9cFd5L5itQL91vcwRSk7NjrYtb5KQR7r01pRcNLEu6/WUPLlgLd+CkD?=
 =?us-ascii?Q?O0cdGYE+SQupDosBVuYxHNE1bcNKFJX8X+Dzd6HEAzduJyzXPk5WmG6vzbW6?=
 =?us-ascii?Q?jiGMZM6bIYjsk+f0QxSZVobvSOplaCjhUWJo7CD2OWoaQPhcVM1WlAxesp0D?=
 =?us-ascii?Q?LpIC1kndoM8CrcYsmebnMk17Bv00Y6pHfhXdiW9RnJfBDzh+hhjomsRJKUPK?=
 =?us-ascii?Q?QcYqCOQ7WuPrk8NGFAyu6Gwlp9pHHU0+9mnB0dC1hFd2KP8xiOy39jILcpFh?=
 =?us-ascii?Q?NAN4a97TB6h1ZIuGxH2S7w6Kg+amnE2O5CelGWUOA+7muH6mj17mJwry4xOg?=
 =?us-ascii?Q?7ptcn4a78UrBLYcgM2ZZFzQ3ImBvrpOVWLxvGCCV+uVBKIz/Clayq+GjVDZO?=
 =?us-ascii?Q?O9yqcyW+AqRB83r3CAijak29cSYi4xw/MJc+KVgoh60pakV06MBNgWvL0SLk?=
 =?us-ascii?Q?k5pCYWULDLhkkiFMuIhGfWnZhH9oYMubAlsC53RrChnMypl6nCr89DgrbUnc?=
 =?us-ascii?Q?0a0MbiJ+qyMQiQJ5ZAKJvex7bpoSOUD0UqesKYCL2Boybv/i6j6Vf06ZlyyJ?=
 =?us-ascii?Q?Bja3Nt/AMxYiA/yj0gerUvSNkNFAFIPbnwawV6V27poSzOxUidOdeMCSl1o6?=
 =?us-ascii?Q?1ybmK69RCb4UNZO71wp0vwmveNf5dHKegmOBMs29sKekxQ38uZQ6eEcffQpA?=
 =?us-ascii?Q?I/TEkYi/JQvg6tSXRtStqY0PDsJnjKb2sg9mY3YzQMt0t8yadBhLT10ennkA?=
 =?us-ascii?Q?W1J1i+jzgT321k2LO1wZ+NT+R3UbflG1eBXIllaR5yDWrSdSZL1xxWvV1+Vz?=
 =?us-ascii?Q?DbsPldJYVR1yVEAG/IvDEoVGpxvnIq2OnUoG1tTbP0MNB9JqDMer97zl3OqJ?=
 =?us-ascii?Q?F2RjwyChjy+uqPHs4aHdfVTs5k4IJgLY8E2v9h7dpyl71OMfFpR+R6OMZHd0?=
 =?us-ascii?Q?reGIMmx4tj6kw05cp6OtOc3qSL91ZorQHnv57zBrIgEUDErIfeb4BSqUtpk5?=
 =?us-ascii?Q?qBYMl0KUo4V8v3mYRiKeCyskwEa4va74y9S2Ia2v?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 872d16f0-32aa-4fa3-80c9-08dbb9dfe1d2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 13:45:42.2397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4m/eli1qwYa+5bhn3sHGZ4hF/PPZ22YbG0l9Et1byeplBhp5Yzezntb3cxQMZRu+e6OsrNEYcXuy/qnxSrB1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8041
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 10:53:07PM +0800, Vlastimil Babka wrote:
> After the previous cleanups, we can now move some code from
> calc_slab_order() to calculate_order() so it's executed just once, and
> do some more cleanups.
> 
> - move the min_order and MAX_OBJS_PER_PAGE evaluation to
>   calc_slab_order().

Nit: here is to 'move ... to calculate_order()'?

I tried this patch series with normal boot on a desktop and one 2
socket server: patch 2/4 doesn't change order of any slab, and patch
3/4 does make the slab order of big objects more consistent.

Thanks for making the code much cleaner! And for the whole series, 

Reviewed-by: Feng Tang <feng.tang@intel.com>

> - change calc_slab_order() parameter min_objects to min_order
> 
> Also make MAX_OBJS_PER_PAGE check more robust by considering also
> min_objects in addition to slub_min_order. Otherwise this is not a
> functional change.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index f04eb029d85a..1c91f72c7239 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4110,17 +4110,12 @@ static unsigned int slub_min_objects;
>   * the smallest order which will fit the object.
>   */
>  static inline unsigned int calc_slab_order(unsigned int size,
> -		unsigned int min_objects, unsigned int max_order,
> +		unsigned int min_order, unsigned int max_order,
>  		unsigned int fract_leftover)
>  {
> -	unsigned int min_order = slub_min_order;
>  	unsigned int order;
>  
> -	if (order_objects(min_order, size) > MAX_OBJS_PER_PAGE)
> -		return get_order(size * MAX_OBJS_PER_PAGE) - 1;
> -
> -	for (order = max(min_order, (unsigned int)get_order(min_objects * size));
> -			order <= max_order; order++) {
> +	for (order = min_order; order <= max_order; order++) {
>  
>  		unsigned int slab_size = (unsigned int)PAGE_SIZE << order;
>  		unsigned int rem;
> @@ -4139,7 +4134,7 @@ static inline int calculate_order(unsigned int size)
>  	unsigned int order;
>  	unsigned int min_objects;
>  	unsigned int max_objects;
> -	unsigned int nr_cpus;
> +	unsigned int min_order;
>  
>  	min_objects = slub_min_objects;
>  	if (!min_objects) {
> @@ -4152,7 +4147,7 @@ static inline int calculate_order(unsigned int size)
>  		 * order on systems that appear larger than they are, and too
>  		 * low order on systems that appear smaller than they are.
>  		 */
> -		nr_cpus = num_present_cpus();
> +		unsigned int nr_cpus = num_present_cpus();
>  		if (nr_cpus <= 1)
>  			nr_cpus = nr_cpu_ids;
>  		min_objects = 4 * (fls(nr_cpus) + 1);
> @@ -4160,6 +4155,10 @@ static inline int calculate_order(unsigned int size)
>  	max_objects = order_objects(slub_max_order, size);
>  	min_objects = min(min_objects, max_objects);
>  
> +	min_order = max(slub_min_order, (unsigned int)get_order(min_objects * size));
> +	if (order_objects(min_order, size) > MAX_OBJS_PER_PAGE)
> +		return get_order(size * MAX_OBJS_PER_PAGE) - 1;
> +
>  	/*
>  	 * Attempt to find best configuration for a slab. This works by first
>  	 * attempting to generate a layout with the best possible configuration and
> @@ -4176,7 +4175,7 @@ static inline int calculate_order(unsigned int size)
>  	 * long as at least single object fits within slub_max_order.
>  	 */
>  	for (unsigned int fraction = 16; fraction > 1; fraction /= 2) {
> -		order = calc_slab_order(size, min_objects, slub_max_order,
> +		order = calc_slab_order(size, min_order, slub_max_order,
>  					fraction);
>  		if (order <= slub_max_order)
>  			return order;
> -- 
> 2.42.0
> 
> 
