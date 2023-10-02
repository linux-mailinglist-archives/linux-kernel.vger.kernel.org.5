Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA9D7B5788
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238222AbjJBPqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238155AbjJBPqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:46:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AE893;
        Mon,  2 Oct 2023 08:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696261603; x=1727797603;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dtH31Oh8my+lnvKPmb3OhUYcURbpCRvnCs201W87S6I=;
  b=J2+ZQfRLnExotAgRghD9Lb9w2Z7ed2dD4L82QA9ZWlX9C/DEx3lfm0zm
   o86Wv8gR5rFO4cfUP6WUbI3m6GH0xxQ1El0oPudryLHJlbRouDdMmxzxt
   CoaukAG+UWeDN70dO7vjXjwHUBYZjLZT2n0whiSg2sJ+K6cBpzfqsgGVl
   gR1Qj2vtFRup+fbnl4jNBuJ70Z911kvPvI9hqN4fP4MgVV4sksCIWdenK
   Vq/oB1jSuQrRVAJBOQScQjvBq5Ayk+YOJULEAwAoSK/6MFGtcrVUPIJmP
   U2xaEqljxHcILVT1GANwi127fLRsv+5j5nUvZlkI6qmDaXrCqZUHHoola
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="468948952"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="468948952"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 08:46:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="785809652"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="785809652"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2023 08:46:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 08:46:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 08:46:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 2 Oct 2023 08:46:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 2 Oct 2023 08:46:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGrZL2dHQ9wXCO2Kv7M8bhBko7lqKNjeg7eqSXakk5W1kUu2bkFL+2M0aRL8Ja/p33JhB7OVZZW4LjsNc+ZxbRuS5IYRnGwAWP2pBkH881iwFWER7R18iwEUJR6u1g+bGjreIJTvxjb/YzN7LH6RvMN4XEoJ+axn+NU/SE9fz/6FpRSHRrSDCx2UJMwPbsisba9n2MXXakD7UkAcXe6fUMXjqhuHl26hnPs+gsL+MX1mLBZNF131IBNCh0RGHIDSqsNC4z3bd+HkHskzcXR87l1lwCZCIztbJAcv5mJKZlhqr1VE4vh3IjVa4Csf2U5XxiCY2r8hwKeU1uxlSVmH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2WskOmUBmIJqJx+hgRirRhlsiZdvEGbZjEOsZ9j9B0=;
 b=kdx52mHkjMwq5srJO3z9mlhWzrOFMM8019oQN2e6kyc2nDB7gdI2GIRrV2OMqWXpvk3NIiENpULd/jkbK42jbyVX688MSePfel5pvtFeaaSQVNMxglx3dNrJR0sMS8KGCP9oh+2HWMi03iarrHm4XPhiah7ua8PvO5PoHDIVevmnYqUSpI2EEJlu8lCWLEhitXq/NyG+iu6Os1QS0OqV4RSZRmpoAU6IUuFCCBXEk7CH6bsz6vyoc1+eWLq/YqHIcrP8XPD6x9Tezo2FvHS7L8uPU5ioqOAFn/ZTeTa/aF16Dnh6t0RKlIkWVVDSX8ObwaqUHiA4iY3wxP0G82jm1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA0PR11MB4750.namprd11.prod.outlook.com (2603:10b6:806:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 2 Oct
 2023 15:46:34 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.029; Mon, 2 Oct 2023
 15:46:34 +0000
Message-ID: <b9201868-192a-4ddf-b739-9f8d93b49a75@intel.com>
Date:   Mon, 2 Oct 2023 08:46:31 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v1 1/1] ACPI: NFIT: Switch to use
 acpi_evaluate_dsm_typed()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
References: <20231002135458.2603293-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231002135458.2603293-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0010.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::23) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA0PR11MB4750:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a4f4718-5aec-4eea-bdde-08dbc35ec193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+VuBtsbH7Xuy5GvjP5sWUblKS+okcE6IjGll2D4Re1TW8yDYQLFL9dsGKLp7x/vsHx722CQn6ZcVIqKtg4NDoFnGsxQMPtM3Ki42dCFakp58Ra4u/LTrF4Deho/y1LQeycsNSSd1zz5p4s7VEy7KKW3yP6s+MIK5AD6zcBehukd8uSpeceEI822dqxCt+HAZGCXobkj3nu1qBSUuKtQY2ZZwfCOE1q2HYEffGHlzyzj1dQ8aZ/cGZ4kwT5cjlepP35mD8NbJGWuRSHhNrn+9PFuN3C9ZdSJ564e9eaYr76JaPu/6Z4x0XR8gDWBa3gGQMWSeMnxR6+9XlUUBUH5+OqlLkcskYPEEFxtJpwg0dR3J3KpGR5Kv/H0CAnRv+YKZEJeNt7JmIBwwJ1r+ATd1uuk24QR1/skcxNmYPN9eDNJj11IddlfW+7WTODUoyplFz7R1e0j4fU+jgdfRN9LtC9OiyKpUyN2g9bg3/5y2u9EkiLpa5pIFSFuMfsqEDLTJO01jDAbCJ5QkpwxswepblXYw9ZzLCCx8WtLDfAvZyTA0+8oRMk6WGlvXXvVW7+gBdCy3qW+/3UVbdQ/NLuCkl4pVLYW+5Y5SZcRY8RwLd7atCEQa8DFxIZ5MXLYciPG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(53546011)(82960400001)(66556008)(38100700002)(26005)(6512007)(110136005)(6666004)(31696002)(86362001)(6486002)(5660300002)(66946007)(41300700001)(54906003)(2616005)(44832011)(83380400001)(8936002)(4326008)(478600001)(8676002)(316002)(6506007)(36756003)(66476007)(31686004)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djh3U2NleVp3M0ZTQkswNTBuUDFDRUdwRVNTQmU5QVR1K0RodE9FUW9pamxZ?=
 =?utf-8?B?TzhlTmNHZm9hdHdJVVVzQzJHM2M0UGtkZ2lwOHFycFpBbmFQRkM5YzRIYy96?=
 =?utf-8?B?c1NJZWNkVktOTko2TkFWMzhET0tBMFNVUFZEY05QdXdXTXpKMDZZMHBmanJU?=
 =?utf-8?B?WWpVbW9HNEwzLzFSV2NLSGhSdS9tOGR5LzRVZ3R5Q1lHRE9vcjFoQUZVWm1h?=
 =?utf-8?B?RnlFK2hGTGkrTDVDbGorTDVvbCtBUjJkcDFHWDJKTjNUSmlNY0gvRFJtdEZh?=
 =?utf-8?B?amhrNnozV2lyTFNaTEdMWTlFT3NuSzV5ekh6MEZvTDZsVmN4VFdVYzg0d0dL?=
 =?utf-8?B?dHRVbmRPNGtLUnRLR25FWlBvbkg0SWVhaitISk1sODdWNnBiKzQ5cVN6ZkFx?=
 =?utf-8?B?ejR6bitwM3V3WE1ZODhvR1VqRm9OSzJhRDNwQ2tLaEZnQVlsU3lqemdTdTFs?=
 =?utf-8?B?RUZSNWdhTkdrcVhxMWR2VVVhbzEybVFPQkNFRmlsVnFpRGZTYjB6QkhWS3A5?=
 =?utf-8?B?TmFSTXZlOUFkWUR0clNQMFB1Mm9hQmttRllLV2lGemw0MXRibERXdmFuYUJ4?=
 =?utf-8?B?Vk1Rcy83Z2ZaTWErWjl3K3hRWDZnWnBQQ2tLdXdqZVlPOVFLUVdwc3dBMDFY?=
 =?utf-8?B?M0N6R0FGeUNiL1JTcnNmdW5Yam9XWFA0cWxkVEh3ZlFRcTdwNE90cjBYekxE?=
 =?utf-8?B?Z0lzc05QLytCWE9YOUJKeTcwL3pnV2h5bHRoay9MSk9IK015T2YwdUFBUWdI?=
 =?utf-8?B?S1cvN1hHaHBmM0MyQ2tLVmtWbTJKaHl3c1VjUGpTeVErMFAvTzJEejJFU21G?=
 =?utf-8?B?cjZIWlhEZU5BM1VLUk53Mzg2SnN1SU1kVmxlVUhPTTZETE1RdVRtQlFQNmNZ?=
 =?utf-8?B?UFpRSGppTzVmRDJPLzZVcVYvbUM2VDVEZXRSR0I4TEZ6aGNqbm9UK3VwTmY3?=
 =?utf-8?B?dDVVOEpzVGFvSGRyY2k1dC9DWjZEcnRWUi9HdG43cEk4MDQ0RWlSUkM5dGgw?=
 =?utf-8?B?Nkl1VVNvL2xWK1VJTFc1SkJVa0gxc3dCMTZ4T0UrdjBtTVRUTE1Zc0lyenJH?=
 =?utf-8?B?NkhDMXVKcUpMaDF2THZXNzNzZ1hwajcrYnBJRW5xY3Q4YTF2eGFOd3plVnpi?=
 =?utf-8?B?ZWUrQW1HMXFYUHlSTGtlanJXZjQrclRaeHFFNE1BQW4wcjhrTHVibzZ5NjZZ?=
 =?utf-8?B?cTVuQlZ3aGJRY1RxY1ZPajRFU0tHc3J0bzVVSXBidS9nNUc1bldxRE5uNWpZ?=
 =?utf-8?B?bjBMWmR6T3F6TEZONWNOK2xNU2tsNWI1OUNCeFp1Y0QyMTlHcHFDeW5DdkNx?=
 =?utf-8?B?RmpicjNhZjNSRGYvMWNJd2tER016T09EZkhxWS8yWTZpellvU0ZSd2kzT2gy?=
 =?utf-8?B?VE03dVhRaG9vVm5GaTZHaUI2SzdkZlBCUkVmazdodUZYb1NOK2NTaXlsU010?=
 =?utf-8?B?eUJqdy9kSjc5eHpQUW1uS3NpNDEvelYzOFlNZ2NnVy9SUnpaZ2s0TDdqYmcw?=
 =?utf-8?B?UlNRTDRWNzRWb2svckNNc0k5OGJaaWhhbGNBeVo4Vzk5NWN1T3VRZHVNalo0?=
 =?utf-8?B?eklMU3FQQWpNSkxIYTNYd0hlM3orZlU2MkxoeURsdG44S3Q0WVZZVUhDNkVN?=
 =?utf-8?B?a01COXNJNWQweHF4bTBhZ01ZNFA1YjA4ZDQxNEs5MXhRUVAwanBxalNhLzFl?=
 =?utf-8?B?bWlYSXNPVFQzKzJqdFdhNmFFTnVPWHRteEJMZDYvNnlocTl3c2JNaFQ5a1o3?=
 =?utf-8?B?OVd1Skc0dGw4V0kxUXZQRWhoclJLaklQTkZXTkR5VDUvdXhJb2ZwL3JnMnF2?=
 =?utf-8?B?OXhZbDR2L1hDeHJCenhQcWxOUkdJT21Na21QdFlkdlhaSjNYOHNSVGxpaHVz?=
 =?utf-8?B?NVg3ek44SVZQcURoTlZwT3FVckZNTEZEQjRWZEVTcmE1Q1dQdXlYYUllR0N4?=
 =?utf-8?B?aXFBUHBwY1E0MHltS2JQNnh3TWJvVlhOR2p5aUxOa2daUEpSY2dGUUphUGZ1?=
 =?utf-8?B?cG1ycTNBU1NFOUpFMUl0NVhXay9YOEVlYTZudWdNd2tiTDNGVi83dzNDTHRv?=
 =?utf-8?B?SjNWTnJsMDVweG83cXBVZ21nZjFKQlB2NnZGZkpLdzJ4NHFIMWpTSDFCZ0Zz?=
 =?utf-8?Q?K+3iOnZ9gUOUjJB+5gyNk8bDP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4f4718-5aec-4eea-bdde-08dbc35ec193
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 15:46:34.6728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cv9be5u+plKsd+Y2jTAcHiCipFToC88M2kve80HWh+pxvRHuTmzZDqrTNg/ubWF0wZO7jmKJJi7sHvELC3uCpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4750
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



On 10/2/23 06:54, Andy Shevchenko wrote:
> The acpi_evaluate_dsm_typed() provides a way to check the type of the
> object evaluated by _DSM call. Use it instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/nfit/core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index f96bf32cd368..280da408c02c 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1737,9 +1737,8 @@ __weak void nfit_intel_shutdown_status(struct nfit_mem *nfit_mem)
>  	if ((nfit_mem->dsm_mask & (1 << func)) == 0)
>  		return;
>  
> -	out_obj = acpi_evaluate_dsm(handle, guid, revid, func, &in_obj);
> -	if (!out_obj || out_obj->type != ACPI_TYPE_BUFFER
> -			|| out_obj->buffer.length < sizeof(smart)) {
> +	out_obj = acpi_evaluate_dsm_typed(handle, guid, revid, func, &in_obj, ACPI_TYPE_BUFFER);
> +	if (!out_obj || out_obj->buffer.length < sizeof(smart)) {
>  		dev_dbg(dev->parent, "%s: failed to retrieve initial health\n",
>  				dev_name(dev));
>  		ACPI_FREE(out_obj);
