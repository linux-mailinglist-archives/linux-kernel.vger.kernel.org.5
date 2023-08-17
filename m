Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1363777FD1D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354017AbjHQRj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354046AbjHQRjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:39:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32B310C8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692293943; x=1723829943;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CK7xznJ9Om7nX2rLRX2JgKEplaJTFNASHrqOdQZugjw=;
  b=eKc4rkwNUS/KtKK2ELzJKtOMls4JwnoBr+FmyEl3oH4g+L0aDsdT6QCc
   7Oc6SaWNS2s0LUsghV5TZxvGqke9W7tuE41oUCgCBpq0GUKyBnp/OUVgG
   jGmGT48xVMysNQLmd5/X2vE8FiS7B7l0yInXy3umEsiBZGaukdulXMyxg
   q7tDJbp4f8zQSci1Q8ZoM1hdrYXj2B9UYGnHj5+mezDRwKaBtIJo/i5qd
   aH3H1tkpDD4O71A+dQxwZaXF56tJqxPes/THEy3zRE/Jd8zdEr5eDKbga
   2qgr1BLHfJVvSIqTtrfwLjy+1KmIGJlGppieR0Q9cv7OLXxSoPJQooeY8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="372872637"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="372872637"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 10:39:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="908505643"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="908505643"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 17 Aug 2023 10:39:03 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 10:39:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 10:39:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 10:39:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 10:39:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuHtOax7bJzyzs9WwMHCXmBSnoKSqKHtn2jXyKHkpLak7UJp67GyhmGZ/WWVaxBBIjRtyV+cO8jtIG85Lu2FRbHtuRyYxOVrUZwnfiJtp8nEHDy5x+K1WBEYOIkAGMDoaGSHi/AUXQn6vPwwevjlslERY//Z9cbCE7zmANt+5q6jEYFW7c9sK5ufOP/PnbJuwrIYCh/M6WRg3cmqVx9gKv6wWdpDtb7oeqskKyuXzid4ts35Eldl0ZR4cOXeH7qBWjarccsypl2oB7ivlE9uWI9cciHclsO9Oo2xrwEAV8PPU4s5gN2PywxYphJyrPhplQg0Ya6SaNZN0fflwmRvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoSbqtHlTkWe3QEWQNYi+/1Bag2Z16xuhDuSsnJh09c=;
 b=nnAFm9gaBfz0lMwG47QULjJaVjeeDUQEE3r1i7RFWV0G94h2eBhQx5mBm1W1Jw84fxVaR/885K/hahyDQ5wT6Qc6JX5GxH5bNq5zu2s3Wexc5wxTJE/f8bcxGOm0EZMvLTuWbWzcyJvL5v/KjEQqMY0s+1g8eqmhfq5gg+9UYDNyisa1rlDF9lNNa5DyiYVBFUJOSn6Z2aFi+ewcp/duQLDwISDqheLN+wHEmU/nkKhYQCfomS2O7p0Xpex+upLGy3b75uc+W8yMT0pPpbYe9zNqZEfdoR3Ijw3W8p8KIVGKz/m1cY4ztN5cE5nOdjW2UpD06YP7tP4OMeQdS9EUqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SJ0PR11MB6768.namprd11.prod.outlook.com (2603:10b6:a03:47f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Thu, 17 Aug
 2023 17:38:55 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 17:38:54 +0000
Message-ID: <a254878e-1872-846f-bed3-3c857d7a73d7@intel.com>
Date:   Thu, 17 Aug 2023 10:39:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [RFC 05/12] fs/resctrl: Set-up downstream priority partition
 resources
Content-Language: en-US
To:     Amit Singh Tomar <amitsinght@marvell.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <reinette.chatre@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>, <peternewman@google.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
 <20230815152712.1760046-6-amitsinght@marvell.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230815152712.1760046-6-amitsinght@marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0362.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::7) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SJ0PR11MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: 2017952c-d71e-411b-4302-08db9f48d3b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9aLfK011QcarYN4sRQ7yNy5XA2HVSC1U7xiCbxwrA93CnLjN0vYSJJprIw24R2sEH7JZD8Fid5PISU1kKNHxne294ZxpdQghxk0G5IuJOTLBuoGd6u8Bth5v2xbZbyGd2y6xy/DJLkmPCoONh/PlqfEUY69R3bwrB5Z1rX7kpcGimn+ZrkK2AnSjoY7273sDrVWzQalFjrLdTzpssiPKH3BgfCBTaN8I4LBuLSo49FM4IyqQ2cAi3XIh92OAHsiTWHRPZYKfznylii91FhwAQpu9NFHPwYySUvHWIWSZgBgBjgCHDvVimrVj+o2oqlUA7tyr3g+ePQtA2XR03YyXKzZlv/L3ntA5iRiPJnZUoaWjnesznmc6BG7ncDnhy7lAD+VA84M5VczFpd2qVJYyDn+M+2AvmP4cTkF8iu/0CoZzK8XQfRMPb/uazLoF/h5MmJm5ofiHVd8hDsuCSJrIm9rs0eJExyCyWiOLlFefKEqvD8SXXVZOb2YkoSE7avi/G0F/biFtLchh8RFBzp3CbVh3Z1QlAh8DSNR2k1AvaJUmCNwoFBjH8LwCT+hSHgQ3e4n3gVxUuUGr3bzZfI2fWXJbAt81zQRqB5Sql8WFx8fW2vU2A4oXWlLqcElhYZv8yJlhzmkW25tZVYfmGn6jgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(396003)(346002)(376002)(186009)(451199024)(1800799009)(31696002)(2906002)(83380400001)(26005)(86362001)(478600001)(36756003)(6506007)(6666004)(2616005)(6486002)(6512007)(53546011)(44832011)(5660300002)(41300700001)(316002)(66476007)(66556008)(66946007)(31686004)(4326008)(8676002)(8936002)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTJzcW9VenJ0OFZ3eGpFdHo4YUM3bmdQamhaSWFSRnZBQjZ1V1llMExZZnBE?=
 =?utf-8?B?R3lreDk0aGY0WVVMMktwNHBwWG0wU0J3OEp3TDNjWVFQTHpJU2owRGhPM1ZE?=
 =?utf-8?B?Rm9NQjRyYmNYMWNkY0JYU2JCVldsYkpTWVFzL2JZaTZEY1NyVHBaWC9MR2li?=
 =?utf-8?B?by9yUHFzaERKNmVtZk5GdlBaNkkrMjVJWm9ITHo3WTJ4QTA0SitYc1NvVWtC?=
 =?utf-8?B?N3RRdmxXMWt3VWVsSTl1bldOaXozaHF2eWRtazg0ZDZRZ0JESnlUQWlTYTNU?=
 =?utf-8?B?VkpqdEhuZ0ladDdSeTE5RWdCZ21zMEFtU1FUMUkvL2Q2Q3BKamRBSEVtWkhr?=
 =?utf-8?B?cFh6MHlDeW9WNWhiL01vR0Q5N3UwWTBHVCtxcjNjMnJ4UFFiWG8zWWUyanVD?=
 =?utf-8?B?NTU4WlBxNTNBMEVhWms2bkNOeDRLbU95dDh6WnlpbExnTDZEdUx1RlRHQTIw?=
 =?utf-8?B?dXY2aXhPS0pDRVowSnF3RlBKUC9ucCtEUE43ckMyelV3ZFdCNHAwcU5kSzAr?=
 =?utf-8?B?SmljQy84V2NjajA3R1RPa01EWEJLVS9BL2Z4dFc3V0hOcllidGJBcTEwV0FS?=
 =?utf-8?B?V1UwYW8wS2VlOFhtMmNtVHZVbUh6bEZzclRvTjdPU1dpcngwOC94TnIzT3ZN?=
 =?utf-8?B?WERlZjJ2RnQ3TVNEdVRuWlRMeE91c1ZxcnpFdERPS05pY3o3QXRTdlo1aVNu?=
 =?utf-8?B?WmgxRnlacldKc00wWEpESE9VOHNZNXkyYUcvQTRhOXNDTkYrY2FNM3U5c0g3?=
 =?utf-8?B?VktJYnFFS2U1dUhrby9aRkl1TUVUR1Z0SnlYdjJjQmNTQlNGQm5CdkdZdnJ1?=
 =?utf-8?B?VW5EdXprL0hrVzdkaXFrM0dQVEJXMjdNSHE3K3B6a0gvVFFhYlhtdHR1ZXhP?=
 =?utf-8?B?Q3JyL2M5VjdnRGFud0wzcFRTS0NUalFHbXVPaG4zZkorQkV3ZkR4Q2RqYkU1?=
 =?utf-8?B?TGp0U3R3NnhOSnZDSHBsd0dmRCtSUEpGN1hyV2xDY3JMb2JUbmZBTjVMbFFK?=
 =?utf-8?B?aXlLbElxVzZRVTNhRFhqeWRDdTIzQTltRzZLTnZBUk5XYjNDdEhlWTBZZFB5?=
 =?utf-8?B?UEpVdFNiWFZJMmh1bGw5L3BGZnI1QzVWS1pYcHJMWTRiekU5dlZibGhQdkhB?=
 =?utf-8?B?RXpjbzk0T1grNU1pWDFNN0czWXQ5a0ZhVHhkR2NCQzJ3S0RSQ2hlRGxhbDNR?=
 =?utf-8?B?QzhGWjFxM1ZKbm9vTHdTMm9LcFBIb3lTZG12d0l3dHEyQXVnT0ZKV1RVQ2xl?=
 =?utf-8?B?azdlNDd5Z29uSXdJVy9FemZnWGZ4UGNEN3EyaElSczVtNWlKVTNMTGdHdmdx?=
 =?utf-8?B?Wko5c3VVNnQzcDlmTTlLZnlXcFNQZGU4NWFkaVJ4ZzR4OVh1WURUbmtESmpG?=
 =?utf-8?B?TUx6cU41UFhqQUJ3L1ZTSWFMSTNBNksyNjJtUTZzVktoQWt1NW9LY0ljcWJl?=
 =?utf-8?B?QTVTQVkyZVBBenRuaXdncitxcWRFOFMwblVHK3JFYnRvTzBXUmQyenU2bFV6?=
 =?utf-8?B?bEpxb0lnaTQzaFJSWnlHN3dtNkRDQWRkZlZoR0hxTW5FdmpncnRFOVArdkRo?=
 =?utf-8?B?bkJ0dDlhM0ZJMEpCRytEYnpJUkorNG5sUVlTbFJpekNNV2Q3Sko5WW1aeXA4?=
 =?utf-8?B?RURXeHdVQU9xNUhwZCsxRnVCK0UycGlrTFViaHpqOUFxSld4Y052YSt5SGM2?=
 =?utf-8?B?N0c5aXJqTGlCeDVHbkRKSDRDUDFWbmViN3hVVWJISDVjWjhrbHBkYWNiNGVk?=
 =?utf-8?B?NWlJSWdzTlZCeHJFc1h4MGNJbnJtcnQySE5xcEZKWTkxUFFtNjg0cDQ1bm5v?=
 =?utf-8?B?R0pSUWhSV0dVNFg4ZFplYTkvMnJNdmtGdEZqbng0R3Vkb21XUWZteEd4cFhU?=
 =?utf-8?B?WE1SazM0clRjSXBzaVlYaFd4bjJ6TEZ6elFWZnFEWGJjSEdIdzBBV2lIRFI5?=
 =?utf-8?B?T0laZW9jWitBemIreFVmdEhscDM4TC9tN1lvd2tpV3FxcXhkbkxlTEs0bSs5?=
 =?utf-8?B?aGx2S1dBdDNtOFBIVkJWVFdjWDVCbjhrOHZaWHVHV1dYZElFQ2F1cU80QUds?=
 =?utf-8?B?N0xrR1RDUTlodEExUGxhc0FveUN0NFVTRFF3MzVVMDZsOGtKWmQ1YnkrRE1N?=
 =?utf-8?Q?A2ZAx1kTig74RslLGYE9rmwi+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2017952c-d71e-411b-4302-08db9f48d3b6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 17:38:54.3853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWHBtO9gUWACIGBef4A5eeQBOfd+Req2gC0EIAk6U4x1HXaePGojfoLF5C/lSQQxjhgwHSV3EYH/p/u1xBis6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6768
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Amit,

On 8/15/23 08:27, Amit Singh Tomar wrote:
> Upon resource control group creation, Cache portion bitmap, and Memory
> bandwidth allocation gets initialized to the default/maximum values,
> obtained from resource control code.
> 
> Let's replicate it for priority partition resource, and setup the default
> downstream priority value.
> 
> Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
> ---
>   drivers/platform/mpam/mpam_resctrl.c |  4 +++-
>   fs/resctrl/rdtgroup.c                | 30 ++++++++++++++++++++++++++++
>   include/linux/resctrl.h              |  4 ++++
>   3 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/mpam/mpam_resctrl.c b/drivers/platform/mpam/mpam_resctrl.c
> index 1081ceac41a8..cc843f1b0fb7 100644
> --- a/drivers/platform/mpam/mpam_resctrl.c
> +++ b/drivers/platform/mpam/mpam_resctrl.c
> @@ -733,8 +733,10 @@ static int mpam_resctrl_resource_init(struct mpam_resctrl_res *res)
>   			exposed_alloc_capable = true;
>   		}
>   
> -		if (has_ppart)
> +		if (has_ppart) {
>   			r->priority_cap = true;
> +			r->dspri_default_ctrl = BIT_MASK(class->props.dspri_wd) - 1;
> +		}
>   
>   		/*
>   		 * MBWU counters may be 'local' or 'total' depending on where
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index 9c5dfaaa7fa2..bc5fb246ba68 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -3045,6 +3045,21 @@ static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
>   	return 0;
>   }
>   
> +static int rdtgroup_init_dspri(struct rdt_resource *r, u32 closid)
> +{
> +	struct resctrl_staged_config *cfg;
> +	struct rdt_domain *d;
> +
> +	list_for_each_entry(d, &r->domains, list) {
> +		cfg = &d->staged_config[CDP_NONE];
> +		cfg->new_ctrl = r->dspri_default_ctrl;
> +		cfg->have_new_ctrl = true;
> +		r->dspri_store = true;
> +	}
> +
> +	return 0;
> +}
> +
>   /* Initialize MBA resource with default values. */
>   static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
>   {
> @@ -3082,12 +3097,27 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
>   				return ret;
>   		}
>   
> +		if (r->priority_cap)
> +			r->dspri_store = false;
> +
>   		ret = resctrl_arch_update_domains(r, rdtgrp->closid);
>   		if (ret < 0) {
>   			rdt_last_cmd_puts("Failed to initialize allocations\n");
>   			return ret;
>   		}
>   
> +		if (r->priority_cap) {
> +			ret = rdtgroup_init_dspri(r, rdtgrp->closid);
> +			if (ret < 0)
> +				return ret;
> +
> +			ret = resctrl_arch_update_domains(r, rdtgrp->closid);
> +			if (ret < 0) {
> +				rdt_last_cmd_puts("Failed to initialize allocations\n");
> +				return ret;
> +			}
> +			r->dspri_store = false;
> +		}
>   	}
>   
>   	rdtgrp->mode = RDT_MODE_SHAREABLE;
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index a98ba5828211..d5b0661c0f70 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -198,6 +198,7 @@ struct resctrl_membw {
>    * @alloc_capable:	Is allocation available on this machine
>    * @mon_capable:	Is monitor feature available on this machine
>    * @priority_capable:   Is priority partitioning feature available on this machine
> + * @dspri_store:

Please add description for this new field.

>    * @num_rmid:		Number of RMIDs available
>    * @cache_level:	Which cache level defines scope of this resource
>    * @cache:		Cache allocation related data
> @@ -206,6 +207,7 @@ struct resctrl_membw {
>    * @name:		Name to use in "schemata" file.
>    * @data_width:		Character width of data when displaying
>    * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
> + * @dspri_default_ctrl: Specifies default downstream priority value.
>    * @format_str:		Per resource format string to show domain value
>    * @evt_list:		List of monitoring events
>    * @fflags:		flags to choose base and info files
> @@ -216,6 +218,7 @@ struct rdt_resource {
>   	bool			alloc_capable;
>   	bool			mon_capable;
>   	bool                    priority_cap;
> +	bool			dspri_store;
>   	int			num_rmid;
>   	int			cache_level;
>   	struct resctrl_cache	cache;
> @@ -224,6 +227,7 @@ struct rdt_resource {
>   	char			*name;
>   	int			data_width;
>   	u32			default_ctrl;
> +	u32			dspri_default_ctrl;
>   	const char		*format_str;
>   	struct list_head	evt_list;
>   	unsigned long		fflags;

Thanks.

-Fenghua
