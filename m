Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C447AB8DD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbjIVSHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbjIVSHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:07:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE323E48;
        Fri, 22 Sep 2023 11:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695406002; x=1726942002;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pYTFuI7lmsyffB059XJmuis4R9WojXPJWD7ts8wuSck=;
  b=LmMiH7yO+xCItuSmQjFMdrKzSrfTYCjxe7IFlHzwNQCZWBEYfYY7RXBE
   XxZZDmRn8AzfzOcKEu7fKDxfytG+d+xENHUZDZVxKZNhcX4DKrxZA6rf4
   AOVw6lTs/idv/Y0S2zHWzB3OEEe66ZaOIaKG7eoBBiuJrIgxHYpBkl+iJ
   8AtBV+OToFUUh6UueX0zIkiQ5vGIbjFp0svMJeMG9ZjOgIbRp3kY+0S72
   NkulfzjTRpzZnBHBI+WHzlSwlpCuw6m6ZIP2J2hFggFDLiwkm8UQKibXE
   c+Ds0AER2oj1QCOq96Z0qU6MFt1J87c4LQOJYxinhakO1u27k6AhSlPI8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="378190875"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="378190875"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 11:05:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="863040606"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="863040606"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2023 11:05:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 22 Sep 2023 11:05:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 22 Sep 2023 11:05:13 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 22 Sep 2023 11:05:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3oQTODcb7qnWsvn1yEanj6e8pIukVqAthMgBtb3ma65NqUcMBK4YC8cDWvz+45cykqiEUK3Iy4MLwKoLDx7WglGni+3Q5qNiqTDkUzdKdt1JN5YHeeX02tU5OQFKBJBJucyQSjj+nyjc/7mXEgXkSL33+hyJPnFeRuVuQPzp9h+p02b+5QxDG9KuN2wYdoK9OEaWKVlbwUZjHNGF234sMydYRC/0tyq8Wbw5qtFKiLBXcW568LQBu1bBayz6j0IHg6AkbyhDxXyTyCF8LrvPXqAh24VwHz9JHiqwUvStoOjwvTGloAQTyF+7rlblAHTyLBPQpNLEPqzjpFYVzxUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jK1nsDeQU5xCNq4avIP08i6fNx6YPG731zuWS6w7sJk=;
 b=jhyN+HLgG+Oi7rtY+uotl5RnSTgSy/DZRM1A6C1J0bhXnoqNCEquoeAivVHMm6x1b8fBAEu0BVNdooqPNBazN+I/FXe2hRC5MoFEMrxBL1Drgbu5abk7P7ieGmTDY7VtUIK7QPk6mbdcbosXALQyOaEEEXvECz882PKVhnXI98mlxi2aAXNGI5Dfn79+ys84n0ugPwwQaFdiU+HDJnGaF5uNd1SfgDELBVWuIYt4xGCDwoFZrwEI6vKXBUezPA4n/SkOz47E+aERyvTl77y3RLy5N9FPuRUrPzPStIWNYlxsxIDTOmbhe41q+k6foq8n8n8YG1V/T0RHRdXMTsLubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA0PR11MB4544.namprd11.prod.outlook.com (2603:10b6:806:92::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Fri, 22 Sep
 2023 18:05:10 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 18:05:10 +0000
Message-ID: <d48b5c4a-7cd8-64c7-f99f-59d68995c10e@intel.com>
Date:   Fri, 22 Sep 2023 11:05:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] cxl/acpi: Annotate struct cxl_cxims_data with
 __counted_by
To:     Kees Cook <keescook@chromium.org>,
        Davidlohr Bueso <dave@stgolabs.net>
CC:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, <linux-hardening@vger.kernel.org>
References: <20230922175319.work.096-kees@kernel.org>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230922175319.work.096-kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:a03:338::27) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA0PR11MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d07c88b-6deb-4360-bb15-08dbbb96759f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rQcB7Z+i41TRZquo0IRHTsHM4YZlfUnv2zcCOBK9LbCMuqtgttUey5RNqVVd1a6E8srFYq2/xa7dQc6+izzS2hJP/fivhjYyGAZlG7a0aPcUha46PFc8ZAM1CXViO8d4VY8S1SZlwjOWlKm4EX4Q+kqDjtFsEBMudD3LFRFBYcShHPrJBM3k86tb4wsO6XN/J2W+GPA/EZjcjKc5Ght63WzUQRQ1Z6JSiVt61wvN6XiY7npDc4wXb0LO3ZEzpyCZC2CyVa6O6tu93OeKT2Vu1WrYVaERCl41uW7Ahw65ptx+5E6N6mHlXv4x8pPgZ3YbHK/8odDMO8EmwsCqtKVf91gfGsblORzoXGGXFGLcLxJ5bJJtokQaGVLm1v+9EnOO00KdwbxsoOjK1+AoIdiE7npFmqlL+wLgRkQFiD0HJf4wsL8dMA6e1Dg8tFPVetfsnOlWrMtCJGNWihIgMc+MbBHbUzOdACa4kxbH8Eow6DE8EEjIlYZBqejXeVqaDibNSCYiug9NUeLxQVTIJuXAlPj0eyFEnzmG8kxkhXARqyote6Tns9hAY3ZYa8QNqXmA7l4DbXa2cI6/cJJwiVGLS8gsEeWfrB8gzW2bfErNkFSs3Gtx2oymdOAh5eQ8yWFS4oprKNnwGZzGEZ9iRUeyvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199024)(186009)(1800799009)(82960400001)(31686004)(53546011)(6512007)(6666004)(6506007)(6486002)(31696002)(86362001)(36756003)(38100700002)(83380400001)(7416002)(2616005)(44832011)(2906002)(26005)(966005)(478600001)(66476007)(8676002)(5660300002)(4326008)(66556008)(41300700001)(110136005)(66946007)(8936002)(316002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUtYNTUyTTJTVVhWSk1ZT1ZHQTBOM0I5UXJoS1NGOXRtYmF2V1B3TTh6NFNq?=
 =?utf-8?B?eStDT2pTYnErVUZSQTNIbENFdlhxOWp5elBrSXcvOFdzNlE2RGNROEtoblhB?=
 =?utf-8?B?NW0yS1MzSmtPSnVKYXMxTkRidms0QUtuMW9lVzhZOFlxNTFyU3VOOEtJbmxC?=
 =?utf-8?B?eFlxK2k5S0JsakdheG5KZldDRlJYV09PYXNnckREWTZsOEZyZ3hHR0ljYU80?=
 =?utf-8?B?Sko5ZUZVdWpERXZpbC81WENPYnhLZUFtMHR6TW9CdmJMQlpDSytUOEZUWjN6?=
 =?utf-8?B?KzBZMVRIeFYvZzhmZnlTUFZVcDl0Q2hMUFNBY2k1ZEFCWkR2MTJIWFRuRVNM?=
 =?utf-8?B?TTlZNXZkd2JQR1dvK0h4NWIvYTk2cmpNTjVMcmp4NEJBUUpuKzdwWmhjYy9G?=
 =?utf-8?B?UXhuaDhHTDFCRXc4SlN0ZDZNWnhZcFFrdW9RWlhCaUVoNk5GcWtMb29pQ1lG?=
 =?utf-8?B?cG8zS0lkWTZDVjF3V3g4VitnalRpeFMxV1Fubkc0M2VRdVpkdThjSGEzY0Vy?=
 =?utf-8?B?T1JQeFFPQlptWDNXT1VTdWlWdlFWWVdwVUtoVEZDVGlpMUswOGhPSzN4VURa?=
 =?utf-8?B?NGFRc1lBU3FEMGQ2ZzVvWUZRYmVEUEQvQkZVOEdhbUJtc01qc0tYaWhWbzFk?=
 =?utf-8?B?azVNNHdlQjBIeEZ2aW5HWmhtc01wZENuUTdrT2pnN0NzZ1RUdGg3Nm5CL0E1?=
 =?utf-8?B?dGRJa1ZZVEVUck9oWVpyaUowcXh3cHIyY2R2REZ0MXVPNmpmNFFtVW84a0o1?=
 =?utf-8?B?YTJ5MytlUEE0bk51cCtTUkVmc2VMejhlZVcwMU1nTzRFdHR0QXpDa0ZXaERi?=
 =?utf-8?B?eWNZL1lrYXpkTUkyb2Z2c0Evamg2ZWUvd2FmT2tCaVNDMno0K0NWQ3F2RUtG?=
 =?utf-8?B?b1FOSFlSK0xkTVp2WWYzNGN4eTRQTzhjdHJsbVVKOXJ3RDU4MXRCOE9ZUHZM?=
 =?utf-8?B?b2xEZmlSMytLZllrRFpTSHVaeHFUZGZadWlnQTFqQnR6MHgvdHEwZVVWZ0dF?=
 =?utf-8?B?M1J3Lzduak5aV2tsSmw5YUtsUytXb2tQMU52R3NCUjNwWjZTaTh4Yk1zMEg5?=
 =?utf-8?B?czJJMWU0Y1lCZXZEbW51WnQ0YXNQOW1rRUZRK21mU2NBYUt3UHR0aEx0SnRP?=
 =?utf-8?B?alVmZms3M0Ntb3pIZW40cGFwVmVNWEwzcmZYUEVFOU4xamx4ZGd0RkxsdmpT?=
 =?utf-8?B?a1dkTVh2NjlRZ25RTDYwTVMyR1ZqWTJic1ZLQnFVaWk0RTVKNkYrOVlPVVQ4?=
 =?utf-8?B?dE81NEUydWtRdXlSMUVCc21aK1lZNmVTeHRuQy9BdFQ2V1hONmM3L0V0K3FT?=
 =?utf-8?B?TER4V1hiUkdNdVdVUmc1M3JMNFBPdFJDOXBpcldvV2w1aFJXa2hvcWFlVjdM?=
 =?utf-8?B?YnZNS3VQcnYzZElFN3dURXhpUnlFRFRwWFNGWlJleHNSZ2ZHWWN0dWRXUnIx?=
 =?utf-8?B?bFNDL3NYa0FadW5SamI1eW16TGcrdkVQeEg5ckJnODM0amhoenBpUU1kank2?=
 =?utf-8?B?aCtBbm1yVms3d2FIZVlxbUxTRW1MSkgrMWxWRXZmUHVpZHZTR1hXQmh2V2xu?=
 =?utf-8?B?QS9kamkzQVlLdmx5QzhTRllGa251b0JGclVxeWdBVEpBTSsydDR4Q0V6Ly9B?=
 =?utf-8?B?N1llZVdFOWlOSVVTTzFucVc5V1JJSUp2c0FTeDJzMmFoYjhXZTVRcnFoTVdJ?=
 =?utf-8?B?SHRLUVhJYVBzOHlmdU1RY3RoLytlSmw5WWNqUkQzUElHS0I5VjJYOTRoZWVI?=
 =?utf-8?B?THNZZWtja1ZRQTRKTDV4NDk2U3dQajMzL0Z5UGlQY1Eyb2l2NDdyRHNETWNG?=
 =?utf-8?B?UStqc082a1IxcmhnK3RoQ21MdUl1MDUzOERkalVxSUdNUHZIdGN2RWo4MkhJ?=
 =?utf-8?B?aGd2MVFSNFRvdjV3eUxVckxQVDBkR1c4cVU4SDAzUHVEQTQ4NXVkUGFQQjIx?=
 =?utf-8?B?cEpwemlyRzhiYnA1aVM1eGgzNEsxTjlJcmdOekNwc1k2ZWkzQktqU3RnTW9T?=
 =?utf-8?B?ejd4WkRVYmtHdFlZUmV0NzJsRng1azdwMEF2WE5xY3dxZktqTzREQ2ZqZWhq?=
 =?utf-8?B?cXJGMStSUG9mM2wwakl2d1BwbUkwVEF4bWxVTWJBRy9zays3Y0VCSys5R0Ft?=
 =?utf-8?B?MHpNRlRabkhiYUJCZ3lwSXBkbkNjdlNOMW1qem5oUFhsOXZLZWs4eHdOb09N?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d07c88b-6deb-4360-bb15-08dbbb96759f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 18:05:10.3020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNPQzTZPgUEFl58AlOIs1PbhdksSq05uj/r2bbnrUUlK/85pjAc4yxHnDL7Gnt278EvFev3XyrJi2RQPZNDcQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4544
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 10:53, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct cxl_cxims_data.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-cxl@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/acpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index d1c559879dcc..40d055560e52 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -14,7 +14,7 @@
>  
>  struct cxl_cxims_data {
>  	int nr_maps;
> -	u64 xormaps[];
> +	u64 xormaps[] __counted_by(nr_maps);
>  };
>  
>  /*
> @@ -112,9 +112,9 @@ static int cxl_parse_cxims(union acpi_subtable_headers *header, void *arg,
>  			      GFP_KERNEL);
>  	if (!cximsd)
>  		return -ENOMEM;
> +	cximsd->nr_maps = nr_maps;
>  	memcpy(cximsd->xormaps, cxims->xormap_list,
>  	       nr_maps * sizeof(*cximsd->xormaps));
> -	cximsd->nr_maps = nr_maps;
>  	cxlrd->platform_data = cximsd;
>  
>  	return 0;
