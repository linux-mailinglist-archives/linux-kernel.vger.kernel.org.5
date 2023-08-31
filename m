Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F17678F4D2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347620AbjHaVsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347608AbjHaVsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:48:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299D810CB;
        Thu, 31 Aug 2023 14:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693518507; x=1725054507;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E2MUvGomcaDLRRQ2W8QhMBn1Z2fhpnx1GrJqgtA2PV0=;
  b=CPv7roRlK73z1PIPgC8fvSHj5yKzAZUQmCxRGpg4J20F7m3v506lcK5I
   htAPffT4GOlWkOVSlI89wyMG/OPbBDip5QD0ioaK+txCGJ6hYLH08Jayy
   tGfVtl7jxm1c9dOyANhh1Gd8yXVuLWN3kBliSGoBK1J7U3r4Jvzk6/C7L
   A6YMOGe7dU/qbN+OAtkKKYoTT7yd8YdLYIYU6ZoxPUVHkDqWuc+bM11SI
   EMAcUWQoYqfNRLCc1zPeuzXwtWchFLp6r9UxSjvokjSw+hg0lINh8EZEs
   GUPaHZX8t0EGdw8G6ZzsR8WHbMal8UGewKVRuLb+UNaBbBu3JeB6sSQNh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="356388262"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="356388262"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 14:48:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="733292071"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="733292071"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 14:48:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 14:48:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 14:48:24 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 14:48:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3nFdNyji6FF1tDGnEmcXiyX46MT4TfRThm+QmtvNhgK+mZWm53tugBa4X25ZKlghPfRn5l4ZNmF97c4xddVsVTwPym8omOvzCabtiTUIYqRuTiTLfbp0L7sqccpZUH6zsyyaMdgL33L6YiF8s9I+0fHYZGmZPwRVDhXgmFXntUT4H6c2Shn/uQaB2yKAgzJ3ZrEHkKl8PmOzoB3YlugoiRj4Y7oK7wkOWfeQDAUoU+nugl2ZLAKh4aT3M5YoJRQZOUtQeH0wXn+5xme9WApCy1NNSAMCv+YKYSjuzbi108BBLINyGOF5tVDJqq8Rm6yQ1MvoBzm7+D/YjYZ2CY7Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAc7X1KfYrvQo+Z7PU/EMccycokK8lC+hJ8tPmRhOz4=;
 b=m2L5+25mEGtJtmj93oBJdl1gmNPkSw6Y4KeHd4dRbLehkqn08oifLl9n8DEV+7zqAj8Kso/eJ06aUyy4GmwJ/3XSaXWN81tZ+bixjh/SA94GE/0ZvfURxnZA128IuBNX/+w9d2zQ3G5zTv7P/UJ3yMKdeXAVBR929sG9kSytG9x9ZF3Et/x9Wy5IhVga6rDd4fBSlb5PGyI8aIg5MbdJYsbV3HKjcl4cZkNsPzXKUrFjkO+BD+oUpcCD6ZpvInye7NlWZZ1bMERZLy2NrqndgJgCyA4alfyDrYha0OdBIA7yBALNTPPvYyJLg2JANigmvZt6fvNGTyuh56cFt39m3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH0PR11MB5595.namprd11.prod.outlook.com (2603:10b6:510:e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Thu, 31 Aug
 2023 21:48:22 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6745.022; Thu, 31 Aug 2023
 21:48:21 +0000
Message-ID: <83a9a5e9-c876-7d26-f119-342237216dc1@intel.com>
Date:   Thu, 31 Aug 2023 14:48:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH RFC v2 13/18] dax/bus: Factor out dev dax resize logic
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-13-f740c47e7916@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-13-f740c47e7916@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::36) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH0PR11MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f79f681-8ed2-4437-c42a-08dbaa6bfe8f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jf1fUiDo8giwJqEbLzCavkmTA/Fu4+P9ubUsggGrBUxdqwKxaL9M+T9z++iEllQUAWdrqJSiqrWaFLDYEQd+jQ+BPhiu2wfH7Iqvc4a7Bza16iuO9rYxz2H6UqVXhGIG+BTkSNR7SmZJ4BYOhltCfjYSOxeemnT4fqRrYgxRHs1g5lRYt95hIQrerH4MP1BkOQHgVro62yKKhKGKtN3fGUyVeHybmEG0phqvQJxn9HrfWQyS0CUwjX+r4GhC6Lt44pQ1HXZbCzzCC1N/uUhl2bp081faLJWAo57KKAUM4LjM/3vewFe39Xbf9umStiv9JEvR4W3OUnYz0xl7Oe0aCdXFewojF43LQ24rreUIy4wyPLwuWpW7lzPi4lQZS21C0idPg35rw2WJWm5Cgu7gieMFRWXubOUniRvQ+myIR1XPNT1OKufwLEuZDHfNHpII+QhYa2CnCVUXUo4SQLV1UxUslB3l5O8KqX81uTKnRpMUCUSA3d1gfKo5ECvzVmKkZx4d9EmnQCaEtry3Kgh0kQeJXhH04i3SHQvv+u0qnVTFqRvmxJLlD39KVDm1w5iWr5eujGxVXnQGFDB06tZ2ispc9mRq9reM2Jp3pGrlL8sc21fxyrTGLy5I9ajhlHtEEDpkbNpDLUtB2otJzzK7pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199024)(186009)(1800799009)(2906002)(6506007)(6512007)(6666004)(6486002)(53546011)(478600001)(26005)(2616005)(5660300002)(66946007)(54906003)(8676002)(316002)(41300700001)(4326008)(66556008)(44832011)(83380400001)(66476007)(6636002)(110136005)(36756003)(31696002)(82960400001)(38100700002)(86362001)(8936002)(31686004)(66899024)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUJsNGgybnNGOW9uUVJvbE4xTmQ5OWppSTVDK2R1bFQ2LzRCWVBkY3dEYW8x?=
 =?utf-8?B?WFI5RFhpK3BNVm81L0JlSnFsN0ZwZWtOdkkvRldNaHpTRmhZVDcybjkzanBD?=
 =?utf-8?B?RGhJS25ZSWtwSitpODlacUtXZUplT2pyMVl6Q2NqVWN3SG80V0d1YUhGd0hv?=
 =?utf-8?B?c082M1ZuT0JBTG1xelloOGRZVGYxUnQ4bVpQTzlTblVCSWVEN0hJdm1jUXUy?=
 =?utf-8?B?aVNOeGdiYTBZRkx1eU9MNDZKcC9HSjhIMWVsRU83STlhM0Fub2VhWmJyODVI?=
 =?utf-8?B?Mzk4OElmYk5oTmhPOG5NaXJFRk9FMktlb3VOaE5ZNllQTVlBM2x5MmVnd01V?=
 =?utf-8?B?TlQ5Vnl3SjZ6MllpeHRHeitDMEZsOU1CaC9GcWdtaFQzUG5vMVNpemJycEV0?=
 =?utf-8?B?eU5qWVNuVFRVR0JyUkszSlRicjgzNFhrT3lieFIySk9UZU85bWJmUTRWODZt?=
 =?utf-8?B?amFoNmYxSlhTQzVMdmJxSlo1cjREQ3dsV2VobHBvWk1iVFBSYmZYMmdURGhz?=
 =?utf-8?B?S3RtdnNDV0hRUHc5a3VGcU5mblAvQzRRR0lodzNoRkQ1OVdvaEorL045cEEx?=
 =?utf-8?B?ZVhlNGtQWXUvN3gvblJGV2F2MEtqMnR6UXhPVzhNYnNlNW1FMDgrbXVBcCts?=
 =?utf-8?B?TG5HMjB1dHJhbjUwQUI4VEF3cFo1RzI4d2tDNVFKR21ZN21BYkgyVlJlQ0Ur?=
 =?utf-8?B?TUx2MGU5MVZsejVmK1ZLTVdIc2pabEVkTEdkUXcxeXNMdDJaMkgyMzFDSnkw?=
 =?utf-8?B?d2NMRjRvODc0SnFsVGh0bnFpKzNDODBLZUJwRGplaHlkR2dUaVluWjRPQTE0?=
 =?utf-8?B?RlFaRjVDeTNzOTlwNFl1YWZyQ1ovRGgwbVVuQ1lMTkR5c28rbkp3ZFl1aTZG?=
 =?utf-8?B?dC9JVElQb21qZDNUUHpjSUNyMGczY0xSZVNXTU4wS05XcHluM3ZITGxkR3gr?=
 =?utf-8?B?TWV0S3hRU0swV0VZWjhROElKTlZYNEpZYmFibkZoM0dEODg0VVprbEp4by9S?=
 =?utf-8?B?RFlJay9KWWpqRnIvc2ZKV0gvOTU1UU54Vk93SFRNay8zelpnYWpwZ0NUZkla?=
 =?utf-8?B?aWQ5RHc3ODlwY0FEQllKa3VJQllyWStiM2FpT2FtWlN2dEExUmdYdjRVMlBu?=
 =?utf-8?B?Y2VldXVKV1ozd0Mxdk1YeExzOUxFaXhoRzRrR0VoOUw4YnhMTWY3TkpJUmcw?=
 =?utf-8?B?am0rQ3Nvd1hvMlFCdUs2bHVVQ1IrTXJCM2pGRk44T05wZzk4cUxoNjhaMDlo?=
 =?utf-8?B?bGdudVZyZy9lS2VPNUxFenhMVERxQUFoY2p1QTBEcGExRVhXdEVQMVVUaURa?=
 =?utf-8?B?dzJESVBBOHpHMEluK1BuMUxyZjFMcktIVXlJS2gvTTd0WU13OEd6YStKZE0r?=
 =?utf-8?B?Z2gwN01RaHBpaHZJWWJranZ5MDA4bjAyNmpCTmlGams5bUdOMWFUQUQvMFRU?=
 =?utf-8?B?R3JCRFFSYXVYSTc3YW9WMVJheklCMThLMy94ZGRHRUhyOUZaUGgzdTU5MzJX?=
 =?utf-8?B?ckJjb2NRU2o3ejlHZ0hGRFZ3N2hvTnNXWGkyRkNEeGdSejRNSmlYV0d5L0Ju?=
 =?utf-8?B?aUJWcmh3VncxNW41V3h5OGpobmJsd3R2b01GaHRFVDBLQitJWHVFaThxOHFs?=
 =?utf-8?B?Vi9pWVUzOWNTMmQ3VVNLWHZXM203UElQVklweTM5MUJ6b3lnSmV5ZEJENHJF?=
 =?utf-8?B?ajRMbnlOTjZXYUtYLzQ1dWlkVXludmg0U1FxbUdJcXlrUDZTYUxEbnJQMkEz?=
 =?utf-8?B?NWE3a05VMUxSMG10S3BocXJjTzl2UlVZRURIRGtleVIvb3NaWnZrdjhJc0ln?=
 =?utf-8?B?SnVGRE12MWNtcUVrRkpTd2NaeVhWNUpKMlQySEQvSno3bnlhbWI4dkN5RzNp?=
 =?utf-8?B?czE2bnNMekd5QndPWktYU1RUZVVYZmlsMjFSY3NoNUNUdGhiaHQvZkNoV0dw?=
 =?utf-8?B?aUJlOS9FK1dpendadEV6dzNuOTdUYlVtT3llektaMTVLTmdJdlpPVDIwRUMx?=
 =?utf-8?B?Tk1vdzJ5QXhncUZBVmdHVFRBcDRXdDBzak9zWEQ0ZTRLb2xrMjcxa25LcERa?=
 =?utf-8?B?TjJ6Y0FGL0tvUlhGYktJYk5uVlFtTGZEZHFjK3B6eGV5Z09YUzViTjY0K3Z3?=
 =?utf-8?Q?em+XiE6bW8E7RG3MHpx34dof5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f79f681-8ed2-4437-c42a-08dbaa6bfe8f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 21:48:21.5496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBimXBnPo7rK2yMjLTln+DEWQYJ/VC5T93Tec1jdggpzgtntVk3mZyjCh3ISLgmB+S8zgSBhdAuBBejIL33eVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5595
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/23 22:21, Ira Weiny wrote:
> Dynamic Capacity regions must limit dev dax resources to those areas
> which have extents backing real memory.  Four alternatives were
> considered to manage the intersection of region space and extents:
> 
> 1) Create a single region resource child on region creation which
>     reserves the entire region.  Then as extents are added punch holes in
>     this reservation.  This requires new resource manipulation to punch
>     the holes and still requires an additional iteration over the extent
>     areas which may already have existing dev dax resources used.
> 
> 2) Maintain an ordered xarray of extents which can be queried while
>     processing the resize logic.  The issue is that existing region->res
>     children may artificially limit the allocation size sent to
>     alloc_dev_dax_range().  IE the resource children can't be directly
>     used in the resize logic to find where space in the region is.
> 
> 3) Maintain a separate resource tree with extents.  This option is the
>     same as 2) but with a different data structure.  Most ideally we have
>     some unified representation of the resource tree.
> 
> 4) Create region resource children for each extent.  Manage the dax dev
>     resize logic in the same way as before but use a region child
>     (extent) resource as the parents to find space within each extent.
> 
> Option 4 can leverage the existing resize algorithm to find space within
> the extents.
> 
> In preparation for this change, factor out the dev_dax_resize logic.
> For static regions use dax_region->res as the parent to find space for
> the dax ranges.  Future patches will use the same algorithm with
> individual extent resources as the parent.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/dax/bus.c | 128 +++++++++++++++++++++++++++++++++---------------------
>   1 file changed, 79 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index b76e49813a39..ea7ae82b4687 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -817,11 +817,10 @@ static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
>   	return 0;
>   }
>   
> -static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
> -		resource_size_t size)
> +static int alloc_dev_dax_range(struct resource *parent, struct dev_dax *dev_dax,
> +			       u64 start, resource_size_t size)
>   {
>   	struct dax_region *dax_region = dev_dax->region;
> -	struct resource *res = &dax_region->res;
>   	struct device *dev = &dev_dax->dev;
>   	struct dev_dax_range *ranges;
>   	unsigned long pgoff = 0;
> @@ -839,14 +838,14 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
>   		return 0;
>   	}
>   
> -	alloc = __request_region(res, start, size, dev_name(dev), 0);
> +	alloc = __request_region(parent, start, size, dev_name(dev), 0);
>   	if (!alloc)
>   		return -ENOMEM;
>   
>   	ranges = krealloc(dev_dax->ranges, sizeof(*ranges)
>   			* (dev_dax->nr_range + 1), GFP_KERNEL);
>   	if (!ranges) {
> -		__release_region(res, alloc->start, resource_size(alloc));
> +		__release_region(parent, alloc->start, resource_size(alloc));
>   		return -ENOMEM;
>   	}
>   
> @@ -997,50 +996,45 @@ static bool adjust_ok(struct dev_dax *dev_dax, struct resource *res)
>   	return true;
>   }
>   
> -static ssize_t dev_dax_resize(struct dax_region *dax_region,
> -		struct dev_dax *dev_dax, resource_size_t size)
> +/*
> + * dev_dax_resize_static - Expand the device into the unused portion of the
> + * region. This may involve adjusting the end of an existing resource, or
> + * allocating a new resource.
> + *
> + * @parent: parent resource to allocate this range in.
> + * @dev_dax: DAX device we are creating this range for
> + * @to_alloc: amount of space to alloc; must be <= space available in @parent
> + *
> + * Return the amount of space allocated or -ERRNO on failure
> + */
> +static ssize_t dev_dax_resize_static(struct resource *parent,
> +				     struct dev_dax *dev_dax,
> +				     resource_size_t to_alloc)
>   {
> -	resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
> -	resource_size_t dev_size = dev_dax_size(dev_dax);
> -	struct resource *region_res = &dax_region->res;
> -	struct device *dev = &dev_dax->dev;
>   	struct resource *res, *first;
> -	resource_size_t alloc = 0;
>   	int rc;
>   
> -	if (dev->driver)
> -		return -EBUSY;
> -	if (size == dev_size)
> -		return 0;
> -	if (size > dev_size && size - dev_size > avail)
> -		return -ENOSPC;
> -	if (size < dev_size)
> -		return dev_dax_shrink(dev_dax, size);
> -
> -	to_alloc = size - dev_size;
> -	if (dev_WARN_ONCE(dev, !alloc_is_aligned(dev_dax, to_alloc),
> -			"resize of %pa misaligned\n", &to_alloc))
> -		return -ENXIO;
> -
> -	/*
> -	 * Expand the device into the unused portion of the region. This
> -	 * may involve adjusting the end of an existing resource, or
> -	 * allocating a new resource.
> -	 */
> -retry:
> -	first = region_res->child;
> -	if (!first)
> -		return alloc_dev_dax_range(dev_dax, dax_region->res.start, to_alloc);
> +	first = parent->child;
> +	if (!first) {
> +		rc = alloc_dev_dax_range(parent, dev_dax,
> +					   parent->start, to_alloc);
> +		if (rc)
> +			return rc;
> +		return to_alloc;
> +	}
>   
> -	rc = -ENOSPC;
>   	for (res = first; res; res = res->sibling) {
>   		struct resource *next = res->sibling;
> +		resource_size_t alloc;
>   
>   		/* space at the beginning of the region */
> -		if (res == first && res->start > dax_region->res.start) {
> -			alloc = min(res->start - dax_region->res.start, to_alloc);
> -			rc = alloc_dev_dax_range(dev_dax, dax_region->res.start, alloc);
> -			break;
> +		if (res == first && res->start > parent->start) {
> +			alloc = min(res->start - parent->start, to_alloc);
> +			rc = alloc_dev_dax_range(parent, dev_dax,
> +						 parent->start, alloc);
> +			if (rc)
> +				return rc;
> +			return alloc;
>   		}
>   
>   		alloc = 0;
> @@ -1049,21 +1043,55 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
>   			alloc = min(next->start - (res->end + 1), to_alloc);
>   
>   		/* space at the end of the region */
> -		if (!alloc && !next && res->end < region_res->end)
> -			alloc = min(region_res->end - res->end, to_alloc);
> +		if (!alloc && !next && res->end < parent->end)
> +			alloc = min(parent->end - res->end, to_alloc);
>   
>   		if (!alloc)
>   			continue;
>   
>   		if (adjust_ok(dev_dax, res)) {
>   			rc = adjust_dev_dax_range(dev_dax, res, resource_size(res) + alloc);
> -			break;
> +			if (rc)
> +				return rc;
> +			return alloc;
>   		}
> -		rc = alloc_dev_dax_range(dev_dax, res->end + 1, alloc);
> -		break;
> +		rc = alloc_dev_dax_range(parent, dev_dax, res->end + 1, alloc);
> +		if (rc)
> +			return rc;
> +		return alloc;
>   	}
> -	if (rc)
> -		return rc;
> +
> +	/* available was already calculated and should never be an issue */
> +	dev_WARN_ONCE(&dev_dax->dev, 1, "space not found?");
> +	return 0;
> +}
> +
> +static ssize_t dev_dax_resize(struct dax_region *dax_region,
> +		struct dev_dax *dev_dax, resource_size_t size)
> +{
> +	resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
> +	resource_size_t dev_size = dev_dax_size(dev_dax);
> +	struct device *dev = &dev_dax->dev;
> +	resource_size_t alloc = 0;
> +
> +	if (dev->driver)
> +		return -EBUSY;
> +	if (size == dev_size)
> +		return 0;
> +	if (size > dev_size && size - dev_size > avail)
> +		return -ENOSPC;
> +	if (size < dev_size)
> +		return dev_dax_shrink(dev_dax, size);
> +
> +	to_alloc = size - dev_size;
> +	if (dev_WARN_ONCE(dev, !alloc_is_aligned(dev_dax, to_alloc),
> +			"resize of %pa misaligned\n", &to_alloc))
> +		return -ENXIO;
> +
> +retry:
> +	alloc = dev_dax_resize_static(&dax_region->res, dev_dax, to_alloc);
> +	if (alloc <= 0)
> +		return alloc;
>   	to_alloc -= alloc;
>   	if (to_alloc)
>   		goto retry;
> @@ -1154,7 +1182,8 @@ static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
>   
>   	to_alloc = range_len(&r);
>   	if (alloc_is_aligned(dev_dax, to_alloc))
> -		rc = alloc_dev_dax_range(dev_dax, r.start, to_alloc);
> +		rc = alloc_dev_dax_range(&dax_region->res, dev_dax, r.start,
> +					 to_alloc);
>   	device_unlock(dev);
>   	device_unlock(dax_region->dev);
>   
> @@ -1371,7 +1400,8 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
>   	device_initialize(dev);
>   	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
>   
> -	rc = alloc_dev_dax_range(dev_dax, dax_region->res.start, data->size);
> +	rc = alloc_dev_dax_range(&dax_region->res, dev_dax, dax_region->res.start,
> +				 data->size);
>   	if (rc)
>   		goto err_range;
>   
> 
