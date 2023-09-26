Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4F17AF489
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbjIZT46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjIZT44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:56:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ECC139
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695758209; x=1727294209;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DxtRe8YYFUEGD+ODu/0uLjn1zLoWv0rqkGWlP5f6n6Q=;
  b=CuNpauFCZKzo5Ywv+3jOfDDa3TU7usLETINON4OKfwA9zqMzzSwziQ9c
   uFBwuBIeQp+MCrRl65207vkKUcU76mer3ZfcsbhM1ucr1PoEpS7rV6LFa
   EmNuOqRocXn4TETvMpInGZUjcD6hzK1KzRQ0PTXd0vKpHC4rWnYgdswxc
   FgBTvUhUHeiTLGxGipYx6bwJyBJrGNCLPHqc1TcM9XJ7Tg/3tpWWj/ZFv
   sYRjW1kPK9spHNjP6acJRdJpkPmu8U8opz4PZUvcgjslen9FU9JKuEWEQ
   lj0Edue6UxnesAf0tRbPMUci/4PdJ0SDin6wMNwbe+ruDZ1XX/mPUK5sM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="378937177"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="378937177"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 12:56:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="892327313"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="892327313"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 12:55:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 12:56:43 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 12:56:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 12:56:43 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 12:56:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0KW98laFAtE66m4AhtC8NXwQWKlHD8M+khw6H0M6pghLlfiekK/fa9lJZaONThs6OIOiTUlqeBqnPHuE4Nk/1c/RMG7kJwRgVtJsKnOC5OSw4R8MZiy3xnPk4CHo1n0VSQCp9RFBsjkO4Y3aknqt+r3rxjM+QidlXfwQjHB33QKQhjc79jvjBf3WLw+f5adl/kSI1z/6VPwa+TxiJnmarmhdkC4AB8HuxeNX5aIneJX+0QzMoupVABtVgurACNqZ9JGHfK3bSCtOTgZ7/76FEai6myWwGA7mVsCmmxut3/QRVoC81UBM5dwmN04LB0b+CabgSxiF9vpw+Xk+uykeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGLpzaBTNJClts2UAF9Vfe+nUCOM/JYukuodhcqysro=;
 b=V40/TKB6DK8mdywe67pAW5jFVFRcmMUmle+iBRUdtrRipZAd1jUW3k4gFApYXyJtf9H6sIPQr3mJ8FW1ZDhSBWTC0Z5+SC7j/8NQfiaqJLSP8VrLiUqgYQqRwRbqVkpfdBUvQhcvjTAcgY8bLveSftLH6QPJ86a2vnCZ0zickszyi9Kgpszv/nAC/RjncQ/ZO/iykDvrhB7XOuFMSTRmKJTCRmNroo3pcVoIRiRfCYuU4Qr3wJflxLfQI/TTYvi4VkCpezYjByvSwXZab3JCxZ7MD5X/KCBS/ZzTZY387UBhmnwSt/o6p6eauo4dhdmqXK8lzAvZWExGbCyUST+z/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB7871.namprd11.prod.outlook.com (2603:10b6:208:3f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 19:56:41 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e%4]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 19:56:39 +0000
Date:   Tue, 26 Sep 2023 12:56:34 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Li kunyu <kunyu@nfschina.com>, <gregkh@linuxfoundation.org>,
        <dan.j.williams@intel.com>, <pasha.tatashin@soleen.com>,
        <andriy.shevchenko@linux.intel.com>, <Jonathan.Cameron@huawei.com>,
        <ira.weiny@intel.com>
CC:     <linux-kernel@vger.kernel.org>, Li kunyu <kunyu@nfschina.com>
Subject: Re: [PATCH] kernel/resource: Remove unnecessary initial values of
 variables
Message-ID: <65133772ea921_e18a62948f@iweiny-mobl.notmuch>
References: <20230926014548.31523-1-kunyu@nfschina.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230926014548.31523-1-kunyu@nfschina.com>
X-ClientProxiedBy: BYAPR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: bc977fc1-0992-49ca-6015-08dbbecab1c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1giXxOh5HBctEOpo8ELRxfKPNacnkafwpLjp9Zn4odjZ6kXvUakRluX6EC/SZnVEXYBC00iRgZFfwpMX/3S140tB53xogWlqJSG8ND2vqsbkNzV4xmxinfdsyPWg7J0ni+nNddEZS5qlFQmGOE1nrIlfCrGaS6qM+F3C4GJaPv1/U18fpVP/dwNtDZQqtU0AvnnAeL4K4l6+afdfWEifvH0kZ2b4fP7ibs5yqiejPSYAd9Yv2mV+4k0Piktk61lo9ZCtW3D8H8Vh3DJb9QU1wFfJbRm0BzZBP/gHloUgRvv0S99H5Lkonz2sVG46TmxG9D5OANKU97blP51SJU4HPEL7IBZ4DJ21mFzwzao199cXVajIjxBmJRaIjuoRQxKKWI4a2GYBfqHkM8IyPgKY5yb5xUCm+tl5O2j1UnXKkuTPDp4qaNHJ+PD4AGE9drHt4QAfdlMZS4pTS3ISaGshcC0vKx5o/oYu4F3oMa1dnQtk4LzM9laFlXuu/Ne7MxwqcvRmAXEg7qgys523Rj9XUDjEXCAOKQjMyCjhmsrPxvPOeb3dMk1+cEjmc09DYYWF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(451199024)(186009)(1800799009)(86362001)(6506007)(6666004)(5660300002)(26005)(66556008)(66946007)(6512007)(9686003)(66476007)(478600001)(44832011)(8936002)(4326008)(316002)(41300700001)(8676002)(6486002)(2906002)(82960400001)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vzatJb6UGX1qBL5O63UG5P6Odmjpw2bw0RgQhIfVIsvhFl7JhcpsIUMP6aUd?=
 =?us-ascii?Q?yFTxMfjDLjavZ5zKg0/SMGVSIh+4vxCySN9f48K9rPajDxYLviz9ys5KLZXZ?=
 =?us-ascii?Q?GjheRQiLU0r/IbtkgL3PzhW/a0rJ4F/F3QhDA4ur6UE/rYUUltCtPuYCPw65?=
 =?us-ascii?Q?f3Y/5AGs3E2aG2nBKSUj5K+28VtDxINxl90JDTfVETaHW6UhSF+3oz9O8YOe?=
 =?us-ascii?Q?CQDvO3O37S/i2fzk94gI6/vVRxDsPF10etay1srjtT22fvGw+qnLQRkeXdXf?=
 =?us-ascii?Q?cVZebMjwSHOP1m45E/VqzYxwJ08rP8lQi/SwyWjA0/ymL+f0wkTaQYht52S4?=
 =?us-ascii?Q?G4USnAr0L8yCkYZ5Y3I8OyURT9t0GlFnTLE8aI9zaQ4i3ZsetFtONlQTUx3M?=
 =?us-ascii?Q?mr5SbCuCF/wIIqaEavAGmxcxuiyqE7ABV8LLvzZ5Wy/UUhMpz0zM3TEOyvGb?=
 =?us-ascii?Q?1i4jaSPZv3ZcZj9TlYkXgL6saJu8qr8hsWSSa9ZuKWF8xllt4KnFsiwwpdCi?=
 =?us-ascii?Q?Aj0f74Nz1X5wowpqoI3ZtaIGrXhkTkUqKqEnlhU0sngOrI1n9OzjuU2v59N0?=
 =?us-ascii?Q?h0ATaP8TezShfqdz6tH46JoMJSCX56KCuuvrVKIpef/i43Yts+cN5S+RpFqg?=
 =?us-ascii?Q?TMVCEg7TQ9XbNTRE09bLRJhol+nNkSIzQC7W+yheuOs6K+yCpQ/v0UIyCZ+6?=
 =?us-ascii?Q?AcjgcdX2NAtHw9EQ9Ztgfn5wm44oMFntjAmCC9+S8RMWEQRA2U6D9agyaylK?=
 =?us-ascii?Q?m4uW8Jgw8zxOXH77x2ZA3hOa0IlJcLJzvApI1IRysiB2Y48DMP9dwNpiEUNt?=
 =?us-ascii?Q?1cS6MRNvmt2I1tueY7pO9NK8B5Q1KFksRNTGYQsHPvBkchANTL2AOgjtlF7M?=
 =?us-ascii?Q?FQfVNH4tt7YQJCBwf2WulTnPzvN5ZpdwCYpTOGKBHu1QnVG5H7Jrved/kzd5?=
 =?us-ascii?Q?EiHLBv8b68EpM//v7QkRM2ht+K/9wWUUMaT0eCSfX9BeaZ8yTuj6kj7TKurG?=
 =?us-ascii?Q?YcpWZxPf9lZbJpqYLSRSIiVbzKmyvGyHjL2sjbT3snHruSopmPnq2X5FdaFn?=
 =?us-ascii?Q?zkkPinHnEu6Mb1sHVMKRiqS3Z5c71rmFomA1MvUdIpXcuRHIcqf2cGPpGmko?=
 =?us-ascii?Q?5HKrNs+5PggUJAsBSnjjsZAeSJYHCZ/1m2DFboiiGaqBuUDRwO+R5+lPD01T?=
 =?us-ascii?Q?coWgnznLj0uVv+r0KGgQ0xTfnJ7dO/ATc2l9wbsxynUcti0M4x1tYKByEqEL?=
 =?us-ascii?Q?Wkx+1VXaJrRhSJPndNy+kraXB0aIcBi4tlvDouZmZKj6Olm2z/HmZ2nY+20A?=
 =?us-ascii?Q?nrTB83Fr+0fbFbA5cBnI1lNALn5lEBzfh3qU0Kge5tT7eJpvec0rWl75wuNm?=
 =?us-ascii?Q?r02fWeLNxseAhK/BAGO6HzdP9+TuZoQn+H0xxFk1q8luRoRb29tHrLIsBddG?=
 =?us-ascii?Q?r5++q+HRHUlZpuptSXAY+0Mj4BamgPSa99Sb3EgTkXRxte0hjP99vuFtPJE3?=
 =?us-ascii?Q?WqCYNiIfCHq0uk53tQomP/IvmyjPtiuq1tnVzURewYnsoEGh9u7DUg8pqPOj?=
 =?us-ascii?Q?edfATkHUzQErwFTHiFD2bea/XjhrRRkYXPmZu2bu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc977fc1-0992-49ca-6015-08dbbecab1c8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 19:56:38.5564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x863uKWR/ZJfhBR7h+gi7mIMG0QS+Mwpf4dlBtENbIrmgRnNJsyD1FbnFGS/7GiPvXZPLoX/vE+tFBTTzfcsOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7871
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li kunyu wrote:
> err, new_res and dr is assigned first, so it does not need to initialize
>  the assignment.

A good commit message will explain _why_ this change is required or
desired.  Changing code just for the sake of changing it is not
productive.

Ira

> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>  kernel/resource.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index b1763b2fd7ef..bbd7c113307a 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -656,7 +656,7 @@ static int reallocate_resource(struct resource *root, struct resource *old,
>  			       resource_size_t newsize,
>  			       struct resource_constraint *constraint)
>  {
> -	int err=0;
> +	int err;
>  	struct resource new = *old;
>  	struct resource *conflict;
>  
> @@ -1310,7 +1310,7 @@ EXPORT_SYMBOL(__release_region);
>  void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
>  {
>  	struct resource *parent = &iomem_resource;
> -	struct resource *new_res = NULL;
> +	struct resource *new_res;
>  	bool alloc_nofail = false;
>  	struct resource **p;
>  	struct resource *res;
> @@ -1556,7 +1556,7 @@ struct resource *
>  __devm_request_region(struct device *dev, struct resource *parent,
>  		      resource_size_t start, resource_size_t n, const char *name)
>  {
> -	struct region_devres *dr = NULL;
> +	struct region_devres *dr;
>  	struct resource *res;
>  
>  	dr = devres_alloc(devm_region_release, sizeof(struct region_devres),
> -- 
> 2.18.2
> 


