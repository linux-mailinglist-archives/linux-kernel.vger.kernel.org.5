Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33B27A832D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjITNVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbjITNVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:21:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D49CA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695216071; x=1726752071;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lhdLReCii2ISQFHNbKVIvHvfrV+2NuEbDiwV4d1wxEg=;
  b=gLrV/ZWUBtdTP3Zbr6X+W6uh7T9NJ2juNjGupAXZiw9P6BgCVICPXdV6
   cb84oYEd0pAZriTkMANz+9iJbm5mbO2mUddz1TnVc0GvTGpzhcl2cEMIP
   0Eg48mogTLrjGUQrY/+oXSbRwVK8VkW2lo1d0HPhlfBEolXpS6ePCwibw
   zgmIpivRd+afl3YRPxiOYEabP3A/HNlHfh5bWacMQp+4MjcmRwy2jXJpj
   AKR5Ef4RViu5FbEZPm5+QK7FP2X9bHsAnJQ8liEpIV73sGpHf5qBTuXxG
   7XCV1KLuPBMiofZREYIfQ9Qol4k5bzBYirXP41vYD+J+LG6js2cuTXlfB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="411163205"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="411163205"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 06:21:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="746654689"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="746654689"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2023 06:21:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 06:21:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 06:21:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 06:21:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 06:21:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYiIN5Xzt9w/JOu4pXyYITbtnhhcbYUqJCm7MRpsX6bIrg8XTuV8eEu94bdcOYD0hXYoQO5isqzxN9x2a6Yc5/KJDGLverl3Fmzbx5gCkqF3UuE/ONF9ALqd5pHLiUElRh7XDhyMSZE5UASL6iqEE+DXE4gXNVyyZnKH3EWF2aNGu1Iziip5fERy/a0Ch2dwi3AxJhW7KXoMePr1Bpfv/nWgifCkaIpeiDnNdnuHzOm67HYvwBDUQbZq9HQBsMhaN0mIwQ3PEda+IK3SiOHxq/JGu73DFcgfCsVLULUVKU/VIxF+RuXXsgNG195mBKuojLkMn0DAFf6xqAxWGdk11g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9Z+WPyOGygEltknSOxydsiJCBsXC1vr9EloomxWcwQ=;
 b=Km95ZCTe2DiWujPNupiy06aw97EB46ezapbVdjJpqESAMZJPtIZp/UMkv8G8H0z64zplSc3JmjCa9Ujxs2XVSmwWX+8nqY7fN8V4zggz6IzXec/eFoliilPAN4hi6jLdc2tYSISD3PnrgxOe7kPuoYBiULQZQJPk/ylcpnwjBjvqADNJzQosjAK7uj9/PNsaw1YgZMHF18OQfnfwq9EkAgLtrJFTb17t1uo3e1G26rrTBozOPqeJjHp27ALdrVRpODtBD6jHw5DGifcOZgv6E/HjFu2gzbQBQg7qaQKhlUfYk4+QbT/0eWYDmHj0Ylic3EUC6Rvqk0mcWadaBVa6zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by BN9PR11MB5225.namprd11.prod.outlook.com (2603:10b6:408:132::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 13:21:07 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7edc:de45:7f2d:9ade]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7edc:de45:7f2d:9ade%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 13:21:07 +0000
Date:   Wed, 20 Sep 2023 21:11:40 +0800
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
Subject: Re: [PATCH 3/4] mm/slub: attempt to find layouts up to 1/2 waste in
 calculate_order()
Message-ID: <ZQrvjFuSAO6DHhQ0@feng-clx>
References: <20230908145302.30320-6-vbabka@suse.cz>
 <20230908145302.30320-9-vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230908145302.30320-9-vbabka@suse.cz>
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|BN9PR11MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: 6adf5664-8d1e-4f1c-c766-08dbb9dc72df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vgtUcu1X3GgKG4rrlHhkW802x1Iv6chx5SuQsahgHe264TU0G2aSR1ObhTySwynLffcW4vuzi6hu4otw7TSMyN5QQgX7G+40rvU0jpGeoZ6sOpzp0w3TXdVIciTcj79Qacw349YzEucG4grma7lUUXumK4fb1/2g7agE9bozXYt/HsqriOhJvcLNM2kLsjZzf8YEtrDoVg1kaofSrRi/8kQEUezr22bcKAx0J2jt3e2X7eWi94lhhA/Hg7vvymYusMwr/fzt8AgSZaPHT0siSVWUABYLuL26yWq4eTaDh23B6JM2nYWArDggMuia9l8OenzUT6wubTmgMGt1MaG166SkYwg7AJ+AbqIWW9zND17zLdiMr3MjvI8sngD+ndDlkx3W/y8ccbLYVpc+T8eyhLHxq4cSntEAV7/13VFTcc/DJ6duzZgMZ4ap8F3dRsUHskunuPTXVjz/8SmmJSUVLIXwartiWBVXGb/lf2NFwiZRn4SC8GfCknmIp881pQ+YkkHNiIEipiBtJ+1K0PXR511Gj4J+7Yt+O3BnPmoT986py/nFJYCaAH01Rwmxen1ix76MjPK4Nfk3lsZYz8vaDDGPdSGsy5OrcDwFV0HAQmM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199024)(1800799009)(186009)(26005)(4326008)(8936002)(8676002)(83380400001)(2906002)(44832011)(5660300002)(7416002)(86362001)(6512007)(6666004)(6506007)(6486002)(9686003)(38100700002)(82960400001)(33716001)(41300700001)(478600001)(316002)(66556008)(6916009)(66476007)(54906003)(66946007)(37363002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dv3TYCcX+eepzv6+IXT35ktV+UQQdOj1cRSNqqIeZrEPqZWSDjTTQdsc61cp?=
 =?us-ascii?Q?t212cfKmt3syEU4pWfk1bBqjvCVptqTST/qhcFTs6CrPkEQ3XOmyWWdlE18I?=
 =?us-ascii?Q?kT+Un9v1yopAVlRojzXGvKYYpQD/gB84EKQEHCAHhe9tF19KB5tlINxqP1RZ?=
 =?us-ascii?Q?IWhP2xvyhcLEb1U8L7NhIs7J3IoR0oeW2t5rqPh78t31qnLXsq3MqSUDTPog?=
 =?us-ascii?Q?SiDudbh/FnTZ9C7OpbdFgn4vKaDXo0BJNMEfgWC6jVwZcNneXH2IY2ch+oyB?=
 =?us-ascii?Q?T2kzVYVACO6sqHVMYYRKRVeovI7peE75BsTz4wfKsh0xrMgcCytBf032wjeK?=
 =?us-ascii?Q?DbePwLyG+5BuY7BXaGnyUyi0O5O4fAIKHqOUEg2w1JUujheYiTlL/QBVetRq?=
 =?us-ascii?Q?cwBVh2vTHkmhu+B9egQQXXXlk/SzmKA1nErvT+Fm6f5DnhDNbuJ4fm2IpG4d?=
 =?us-ascii?Q?FgQZzxfHVntWylWQfXYw7Xz1DimFGPvr+d0chCJ3RqbMn9t8WVrXiQYF6R8E?=
 =?us-ascii?Q?xqgwGfL4bWNV9hP9KpDsrV8xeaDs21loTwkhtQt+lFTdo55DElnSiPEcDdi0?=
 =?us-ascii?Q?eqvpcA0BnTbX8exYrdPSqpMrqvU4CorDPAw8I4XjoxDbqZrbXTamThh4FTLa?=
 =?us-ascii?Q?78HTOO9td01kwjh/jyz/LbylL5phF6tE+Zv/EiCntBLjL3LhBDCFCtMHzLZe?=
 =?us-ascii?Q?RADIdGBOdAvkvdHFLDwKQPrgozVOm8i+ioLQ48LQl+edO6GZZoia4tlSLm6P?=
 =?us-ascii?Q?ROqIW88omr95a83WpGPUBVLOeEpS+tHYnp1jvDQrC3vRwPklil3aTEUr3kgS?=
 =?us-ascii?Q?I4fvSwBtJpMQ1TFWZj/lU4M7hP2FYpHR6ujHEdtfTNKOYC0v2vqo8WXBaYi5?=
 =?us-ascii?Q?8Fdxuq5CyncOE7fPCVw1THRirDMJkftCti8iUT3Xgj/JzyJK0dAq5sLKN6Cm?=
 =?us-ascii?Q?ISh1TQeDmawp1RUYHQRI1i+ZO7igtMCcZXd49xo8/0Oi2iHHCa/N8O8n8403?=
 =?us-ascii?Q?/I2mSVZ2arB/m3GNxGAGVPyGd7HC7dIT83bw1yAeGXrYbKu87f/L42DLLOQ9?=
 =?us-ascii?Q?EiUGOiu+e9iQSD/xY8UtgHsaGZaCaKklbXJQQi2/b7bpVfRl9BMtRaKK1rDt?=
 =?us-ascii?Q?0R5efaUx9cr9Gg08TSQtJvllQciK0nnJLi8Bampj2lBQNWI2qwKaXgSSjCxH?=
 =?us-ascii?Q?HQ4QdctLhv80wcANSGRe5vMt2lYabXoP+lhQusEvCC9bbfdF2rEH3RLAMKcf?=
 =?us-ascii?Q?GH6nbgS7OIAQm+fR62JUZJ8sEfuwjI+yWicGE6aRZMW8KoFM85h4VRCN6znd?=
 =?us-ascii?Q?A8uAaFUKS0HyQ+yWRvvz9iLVdDqy0ZJSgPQUlElnGn4w8tVykWJ1dwMQkQE4?=
 =?us-ascii?Q?EEHIzvebsMjhP9gN+SqiuuLqw982z6W9gxTfQPPZApyn3J8ZrOW2iXx4r9qJ?=
 =?us-ascii?Q?wd8+PeplGxxf5znuqPIlg4ZqwLCFjfGXSEiE0Dmv1Bg2harWS1H0OxemTw40?=
 =?us-ascii?Q?/eNISUKDCaKchBhoEYqsR8gLws3VgWhElfwUTRKuVHihtfYvM4AKUQVXrwO2?=
 =?us-ascii?Q?WTvvZ//v40FXtFqve4ewYkt2qMgQY0BZJgW/pEjM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6adf5664-8d1e-4f1c-c766-08dbb9dc72df
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 13:21:07.7775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6yaTP/24i0VYcGQZmAxU4Q5+eQdY2Sb7X1u+8WuwhTBWrqt4tp7J8eYO33y5pK5s5wuhZ8Tsqmc3VQde1H5VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5225
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 10:53:06PM +0800, Vlastimil Babka wrote:
> The main loop in calculate_order() currently tries to find an order with
> at most 1/4 waste. If that's impossible (for particular large object
> sizes), there's a fallback that will try to place one object within
> slab_max_order.
> 
> If we expand the loop boundary to also allow up to 1/2 waste as the last
> resort, we can remove the fallback and simplify the code, as the loop
> will find an order for such sizes as well. Note we don't need to allow
> more than 1/2 waste as that will never happen - calc_slab_order() would
> calculate more objects to fit, reducing waste below 1/2.
> 
> Sucessfully finding an order in the loop (compared to the fallback) will
> also have the benefit in trying to satisfy min_objects, because the
> fallback was passing 1. Thus the resulting slab orders might be larger
> (not because it would improve waste, but to reduce pressure on shared
> locks), which is one of the goals of calculate_order().
> 
> For example, with nr_cpus=1 and 4kB PAGE_SIZE, slub_max_order=3, before
> the patch we would get the following orders for these object sizes:
> 
>  2056 to 10920 - order-3 as selected by the loop
> 10928 to 12280 - order-2 due to fallback, as <1/4 waste is not possible
> 12288 to 32768 - order-3 as <1/4 waste is again possible
> 
> After the patch:
> 
> 2056 to 32768 - order-3, because even in the range of 10928 to 12280 we
>                 try to satisfy the calculated min_objects.
> 
> As a result the code is simpler and gives more consistent results.
 
Current code already tries the fraction "1" in the follwing 2 fallback
calls of calc_slab_order(), so trying fraction "2" makes sense to me.

Reviewed-by: Feng Tang <feng.tang@intel.com>

Thanks,
Feng

> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 5c287d96b212..f04eb029d85a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4171,23 +4171,17 @@ static inline int calculate_order(unsigned int size)
>  	 * the order can only result in same or less fractional waste, not more.
>  	 *
>  	 * If that fails, we increase the acceptable fraction of waste and try
> -	 * again.
> +	 * again. The last iteration with fraction of 1/2 would effectively
> +	 * accept any waste and give us the order determined by min_objects, as
> +	 * long as at least single object fits within slub_max_order.
>  	 */
> -	for (unsigned int fraction = 16; fraction >= 4; fraction /= 2) {
> +	for (unsigned int fraction = 16; fraction > 1; fraction /= 2) {
>  		order = calc_slab_order(size, min_objects, slub_max_order,
>  					fraction);
>  		if (order <= slub_max_order)
>  			return order;
>  	}
>  
> -	/*
> -	 * We were unable to place multiple objects in a slab. Now
> -	 * lets see if we can place a single object there.
> -	 */
> -	order = calc_slab_order(size, 1, slub_max_order, 1);
> -	if (order <= slub_max_order)
> -		return order;
> -
>  	/*
>  	 * Doh this slab cannot be placed using slub_max_order.
>  	 */
> -- 
> 2.42.0
> 
> 
