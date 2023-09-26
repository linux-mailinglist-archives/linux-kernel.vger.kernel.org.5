Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493947AF352
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbjIZSwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbjIZSwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:52:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0BA13A;
        Tue, 26 Sep 2023 11:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695754344; x=1727290344;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NyzXyy5pixQrih4rZ7ZPdJr5ZoWBctlC7Bq7bMG04UE=;
  b=HsXeLlrG0BpxIDB3vsC/4XraP82mcdMcy+HZlb0YwhvOW8eXcXrmraJq
   gSMbcyvE1+JTeNhRKztuLHWIatgJEAS7qDVlkF5wtmIFKBIyep+G6T0mj
   H4FYQeCXhnnLOPb6xp+CKpAkGYdAcsl3NLuKCqiNMC/OPXSRo6H+eAgJ5
   cgBAKc/+B5qHuCz/+ug76gqG58Ax7pMkMz3ZwJU1e6yySYOtYsZCjRr6H
   1E/WuYhuR8DruzBBP9a0I3womhmVJweR/N3AX2m962rLDIBXDcDps+DI7
   dSzg5llWWCB50GgibsU/7s+c3C4ND3cPMh2qUsLmPSgfh4Wob2IscDIQW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="361023736"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="361023736"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 11:52:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="892314128"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="892314128"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 11:51:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 11:52:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 11:52:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 11:52:23 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 11:52:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4qaPO0o+mycWWot2Nx9VtNy5b4cKQyfEc2Ya89VvbffgllZw4uP4bLaZZpYiFSibw64oOfQuzdTiwdTkD9amkPH60eOhK7mGpVTT58XVNWbmXY6zzNDTQw3KOBkhl34AbZw5keiHN3rDuJV7cHpLDNSYrkESxeZ+6pveMRO8OOQ7gtjM1G7rOW29cgELstnV0+Ao9EQeGv3LEg4JmVsAUFlrU4nDAmGc2xVoB6ntLgUa0T/lukqirVgV1Oi2mVhLpUa/3iWaI/HdZVhLdGv+zeyU66q+Vo3wSMlwCPrc7jTjXC3ww5myPuxviGasSsrn3Y2KcGpV1D2TzOLsByydQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLOcyEsQvAT5Yza8N0HpwbXRXRzGn3fQDsGtCQoLxNQ=;
 b=cns4TIyW7DKregiiPl6qMkggqN1gyQGs3S5sXamj3DU+WwHnQlOX2Nj+dIcUMXVZoCTZxSA2HNfYTK+PlZ92NpX1+dpSFH/KaQZTi+PvxuHY/boKF7CN9+U0nfvZ6um7MWPqR8DJRmfDMgXvBK7MWz5wf4NBON0sgDcasOxAR0ZGT2MNIyoH5Txl8xzXwK8D7L5qDQxuu2tiScDn4NYhz7jSmJ4FuP5hV58mDCdD0LtYFjwJz5DkwCIkJph8LNZOtNHVPf0NFJ0fs+wHZDx1Ng2XLS4siNd/WIDhVOruaQDu4vY0A8fRcGfDEwBc50Pzp+5PZcrcbjKAVAVfqK93nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CO1PR11MB5202.namprd11.prod.outlook.com (2603:10b6:303:97::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 18:52:21 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 18:52:20 +0000
Message-ID: <caf9a9e6-dea5-9dd7-846d-30d445b8ed2b@intel.com>
Date:   Tue, 26 Sep 2023 11:52:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH v1 1/2] ACPI: NFIT: Fix memory leak, and local use of
 devm_*()
To:     Michal Wilczynski <michal.wilczynski@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
CC:     <rafael.j.wysocki@intel.com>, <andriy.shevchenko@intel.com>,
        <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20230926184520.2239723-1-michal.wilczynski@intel.com>
 <20230926184520.2239723-2-michal.wilczynski@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230926184520.2239723-2-michal.wilczynski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0073.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::14) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CO1PR11MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: e182da62-b0f1-4573-64d3-08dbbec1b6af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFSoiS6amaoeTQ7PrQ4+POGO5NdEDyuCQGcoNPijjbTZ5zwxgBJFZsdYjanE3InPKZHJ7l+7Y8PAnr9qEO0PBUEUYYKxhzTv1hmNsNtxOjwDFuj8QgV0CSIoXcvlKoz/CP0FQLoOyBrE9hJiToiBxJQ5npMQLE4YPXZgIH0ss15Ro1Ll+JvdE1Z3K+YEVJVL9g0sfBM/Gz9kI8QzsHlnDNO1xKd7/umkI6Q0YZ1ZuQer4m+blm8Rg5gwzAhjlljojp3T+St4CZw0bzZvgmvmrOX7eqXUoBgtz4rzomhTNE/65FEQlKnpZgTwWCKGpnK4qKVl9dpGX7CTE6eP0X32WdoQGg9dm12yYC8uv+g2i/XE0xaSS1tq33w59U3T+12sva5eE2dPK6daDYtgqy9v6fm8XoDbKpyuveTSMW2psnwHVb1ZVJ0ZYg/KQawRKO2Ii2pQ9cqY/cHOa02nbWS1g/pmy9YrGcusCr+ZOqXXTPZMX39DYDcmMoJyUp+gO++MTtStn1YdEAWHMsCckUaG2b1w52V2YFu84OKzCwIJm7or9hsI1wenvuhb9KZTKIpCYJJDlvHaU91jJstdcE56irBvoE7LTfkw/1w8pG8MUCp0hxkCbHveRmdoQaZ8GrxyajugYaxtegJ1YcM9fq/pig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(1800799009)(186009)(451199024)(2906002)(86362001)(6486002)(36756003)(26005)(6666004)(83380400001)(38100700002)(82960400001)(2616005)(6512007)(6506007)(31696002)(53546011)(8936002)(41300700001)(8676002)(4326008)(316002)(44832011)(5660300002)(66946007)(31686004)(478600001)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDJZQnRJdXg5S2V3bm1FYUtVMGdOWXF0ZU51elN2RE45OXVXdTVSaHlYcDJU?=
 =?utf-8?B?WlR5U29wZGRNTDBnU2I5Yk04SlJFQnZnekZUREFjRUk0V1FmZEZHY3hhaXdQ?=
 =?utf-8?B?MUs2cDR6Ty9MenZMUVFHZ0h4QmRoc3lPSmkrOUpxOGhpYTdOcE9Wa01JVHZU?=
 =?utf-8?B?K01VSDFVcTluMDBpMElnbE1nU2JUcFdwcENKK0FBSEhXaHZWOEs1OUhncXlO?=
 =?utf-8?B?USs1aUJtY3ZxQXFvSkcrN096L2FhNHNiMEU5M1V2S09pOXMxbFk4ZC9TNk04?=
 =?utf-8?B?SFdKdXQrSVpSWStXaVRrSjRvdUVGdXB2YUVGcUJWTTgyeEpLTkdIa1lpaEd3?=
 =?utf-8?B?YTFseXhrbnlhb2dYaFh0dmRYU2RMdnlET25XbXFxOEZBREpULzBsbWdON1NP?=
 =?utf-8?B?UTZtTzFZd2c0YXdaRTExRVB0TjQ5NkdjUStOK2J6NEJWbnpzcThXMG5zVkN2?=
 =?utf-8?B?YTJWS04zZHFDb2JRYXNmNFR3cGtPeUpZQVpOemRYTEJkeWtQT0N1S2xxd2J3?=
 =?utf-8?B?anZzbW8rbzlCK0RLbjJvOGlORlB5MnphNnhpR2J2TCswRFZjVDdYTGoxaVlr?=
 =?utf-8?B?WmxnSmJsZXlxVmRPR243MklXNFBjVFdvQzk3RVp3MTB3REkrQzhXQW9NbSta?=
 =?utf-8?B?ZnpuZzBPTGsvVjNRYWZKUE93RjAzU0lRZjRLWW5PdlBkTGdmOVZHd25Ga0tJ?=
 =?utf-8?B?c053c2pGcjZrRklPOGxEYjcwUTdhbm11bFpRbkFRc2NXUFd4eStWcmlKclpZ?=
 =?utf-8?B?RlJBZUVva2FlaGZ6cFJqVFpld0RUajhnS0VSbGNhSVBNTkxtcWxFQmkreTdr?=
 =?utf-8?B?eDNNdmtDcjZYa0Rmb2daZHNDcjNUZzFSN3FpSTdqaW1ZSE1yRGxTeVhmSkJt?=
 =?utf-8?B?cEdkdWVmaXZwL3A2YXI0WkFSRDdMcnlSbDZYZVltVXo0cEp4YkF3bUUvbFd1?=
 =?utf-8?B?NEh4Slh2a0lqemdILzhVYi9WVk1xRTRDZGpRMUZITTJOSUdwK20vbk9jWk9h?=
 =?utf-8?B?UzZYYUFPUXhNSmFBTGU3ZERqYnpSajY4VFV4a3lUdjBVaVVKZFB4UTNiNTdL?=
 =?utf-8?B?WXlleHozdmJPazdyMWt6N21rdndkd3pSZm50OXJ0aUdwWGRMYXJsMTRKZVFo?=
 =?utf-8?B?dmZyOExLMklrbXNMM2EzcHZ2OVV0OGl1ZC8zUGV3ancyZkk1SFA0aCtLOTNH?=
 =?utf-8?B?ZFJSbDZpZnJ1TzhrR280M2JtejNMTFhWa0VFWTl3ODVucU9keWdBOXl4Qk1z?=
 =?utf-8?B?VG1sUFV5WlZtb1dqRGJaL0Q3RTVudWc4TlRnOGJBc1JDaUxYWjZZbGUyYysv?=
 =?utf-8?B?VmZuMzdEelJQMXBxNENzTmU5dEdxSzVMNDlrVWFoRDNEZ09RcXgrbkF0ZG40?=
 =?utf-8?B?UDVRdDhVUEhHck0yQmZvdXB3UVF6b2RsQThMU3dlQmJKUUQrd3Y1OTU4QkVC?=
 =?utf-8?B?N2Q3bHJON2gxYUgyem1iWTcyUmdTYktCTkxaNExweHlFNnFWVFhiZEdadTZq?=
 =?utf-8?B?cXk4NGZjbGg2aFBWaXRRNUlhTlBRdzN0UlJoUHJPRHYrY1JmckVrS3ZZMVBq?=
 =?utf-8?B?MjgwMW02dVRsNndFTkxwd1hYdHhPODMvWVZTQlRxQXo3cTRPWW1sbDNoTXBj?=
 =?utf-8?B?eFVGbHBVOTJUVnJMWVFOdU5QdXVWcDNJNldZRTI1QWZkekoybHcwcWdUQ0NG?=
 =?utf-8?B?bkdNRzUvQU9rUkRUN0tZYWViNWxlbmVYRWNzRFJUOVg0VUhHVyszc1FZRzlS?=
 =?utf-8?B?Nng3cW0ycXBjczdDYTdoUjBvZ2pscG1ENUtpQ2owZnNWd1pDRDlyaW5IaXp0?=
 =?utf-8?B?cjgxK1ROR3A4YzI0UndjUUpHYW14M3c5Q0pmL1pmeDVwVnpORW1nSVpjTW0w?=
 =?utf-8?B?bUJWNTJTQzRENVpGbzlEOHJRTWhpRi9yeENWbk1zQ3NSV2tXWTE2SnlxWmlI?=
 =?utf-8?B?TEthMzN0L2JJazJKUTdLTlc1MHpnR0FzYnNETGtWNGJlRjIwR0hEMFh6Tk94?=
 =?utf-8?B?a01VelpYREcwTEVIQ2xoUFpSQktGZTlrM0ZONGR5Q2lkdEg5YU5TQXdsNlhC?=
 =?utf-8?B?Mm1TSURqMm1vM0VmUFBmT056UEFjRE9DdjlsaHBhb0tPOVZPeVZSZlJxVmZG?=
 =?utf-8?B?UVBReWZZeUZpOG9pS2QzbFhJdVZzY1dVdmxEWWRoREt5QXJ2ckJ3dGR1RXBq?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e182da62-b0f1-4573-64d3-08dbbec1b6af
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 18:52:20.7807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNPkji7et47PvF4VLh+3POJohvyzdKi0FY6VIB3bAIQl2J15+vwn7sM70r2cJn3o5WYSKTJfAY5Tpwaz9w6k2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5202
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/23 11:45, Michal Wilczynski wrote:
> devm_*() family of functions purpose is managing memory attached to a
> device. So in general it should only be used for allocations that should
> last for the whole lifecycle of the device. This is not the case for
> acpi_nfit_init_interleave_set(). There are two allocations that are only
> used locally in this function. What's more - if the function exits on
> error path memory is never freed. It's still attached to dev and would
> be freed on device detach, so this leak could be called a 'local leak'.
> 
> Fix this by switching from devm_kcalloc() to kcalloc(), and adding
> proper rollback.
> 
> Fixes: eaf961536e16 ("libnvdimm, nfit: add interleave-set state-tracking infrastructure")
> Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/nfit/core.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index f0e6738ae3c9..78f0f855c4de 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -2262,6 +2262,7 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
>  	u16 nr = ndr_desc->num_mappings;
>  	struct nfit_set_info2 *info2;
>  	struct nfit_set_info *info;
> +	int err = 0;
>  	int i;
>  
>  	nd_set = devm_kzalloc(dev, sizeof(*nd_set), GFP_KERNEL);
> @@ -2269,13 +2270,15 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
>  		return -ENOMEM;
>  	import_guid(&nd_set->type_guid, spa->range_guid);
>  
> -	info = devm_kcalloc(dev, nr, sizeof(*info), GFP_KERNEL);
> +	info = kcalloc(nr, sizeof(*info), GFP_KERNEL);
>  	if (!info)
>  		return -ENOMEM;
>  
> -	info2 = devm_kcalloc(dev, nr, sizeof(*info2), GFP_KERNEL);
> -	if (!info2)
> -		return -ENOMEM;
> +	info2 = kcalloc(nr, sizeof(*info2), GFP_KERNEL);
> +	if (!info2) {
> +		err = -ENOMEM;
> +		goto free_info;
> +	}
>  
>  	for (i = 0; i < nr; i++) {
>  		struct nd_mapping_desc *mapping = &ndr_desc->mapping[i];
> @@ -2289,7 +2292,8 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
>  
>  		if (!memdev || !nfit_mem->dcr) {
>  			dev_err(dev, "%s: failed to find DCR\n", __func__);
> -			return -ENODEV;
> +			err = -ENODEV;
> +			goto free_info2;
>  		}
>  
>  		map->region_offset = memdev->region_offset;
> @@ -2337,10 +2341,13 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
>  	}
>  
>  	ndr_desc->nd_set = nd_set;
> -	devm_kfree(dev, info);
> -	devm_kfree(dev, info2);
>  
> -	return 0;
> +free_info2:
> +	kfree(info2);
> +free_info:
> +	kfree(info);
> +
> +	return err;
>  }
>  
>  static int ars_get_cap(struct acpi_nfit_desc *acpi_desc,
