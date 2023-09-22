Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4918D7AA76B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 05:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjIVDqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 23:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIVDq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 23:46:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95B4E8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 20:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695354381; x=1726890381;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=G6xSMpjFRwQrGb8MMWYRjWHAo9ZkxEd9ki7TKtPPdqI=;
  b=ENj6bGq/FGJT8oo55CPDMLEkV+mnkMaHXXDpkqVkwqcZbu+ofTTkkqP6
   7wpAgq//FQAzxKgEqqgNUx51TODG+/uN9eQxGqIRhiiJfEFMc7qC7MRH7
   OqqCQ1f/40dhGmMHEgX2/BapHt739caHICqom0Z9GYp4V298FY68bPiXL
   cgHkSF74zbF5cDYXVw/IYP5Zz6epn4rP8cQPopHvfV8ZMUCWkQmkJDX/5
   +hMpVDRq/9QgKH5ANIsR8Dl6tIlnp4RdQYLefHiDSCzfV0LKB4+KdElCY
   sE3w36mg5oZwMaIWhhCg6vs1aD83hz8MrBgjcX0Ry3Mm4aI0dy/SSOnNY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="447209596"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="447209596"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 20:44:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="890650314"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="890650314"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 20:43:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 20:44:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 20:44:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 20:44:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 20:44:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeHnfIHyKCcCg+z6I5Gw6OZ8n5D+6VmcVeHiGPccMM6Xx9VCGjbAYI+eoJ1WNQ/sKa6xA/54KlYoYhsP0y4yvHk1nuLsNjPg2Wji7nYnzFKYQ/00UrLRuLcIj+Kl/oXGEypVeLJJQoQYV1qrPBeOOZPivYMTpaLCGeLxCaqf2bJZEW+W48lFxc7ZPNeMQ2jePYcBMPl/76Ej4TvE7ChPC3zBHLx0d/24eZeGeibKBgmEitaBP6+Kv7zblwPW9OZhANpeahpW1wpSaWyUBECY+3RrUiz9h0Nkc1YYYnBMhq2nvrBLg3w5iIPz7qT7dosREFoS6GatvrfbwW0RtEU7WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNhGglu+mtyzhSKHd/+XisnzujLW7/lLpPjO/wmdxe4=;
 b=AQ/8Jv8lOC3nCSrvrg7Ps4/RFiGwn6HpZ/M9DMzO0o5Emlcf1FbG4bcfH3WGUDL2mH4OrC5fOSiCUequoMoeiUYGprOfkG+FiIf58zeOVyLNkgY0Yd7KbbruM8ZTQdztKqOEAbv4BcpBPkal4s0Gf3HJC9u17Z5m1jee9QKbw3tWaZyohrdQ6Yvrv9P9A6/AvubFU2FAeaHD0hMjR2Ij9sHvMv6EIxBVx62BF1QfMhoI04y8sqBEzOm7cuSw0Qr3FNIgb87q0PqPeqy5QRh2yA+bFXzXcHjLYpOta4k1rqNZWqmae0F47yvjyvqgYJqT0g2atf7mBek44PVjPCm10Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3094.namprd11.prod.outlook.com (2603:10b6:a03:87::25)
 by SJ0PR11MB4878.namprd11.prod.outlook.com (2603:10b6:a03:2d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Fri, 22 Sep
 2023 03:44:36 +0000
Received: from BYAPR11MB3094.namprd11.prod.outlook.com
 ([fe80::5e3:67e1:e213:c87]) by BYAPR11MB3094.namprd11.prod.outlook.com
 ([fe80::5e3:67e1:e213:c87%6]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 03:44:36 +0000
Date:   Fri, 22 Sep 2023 11:44:18 +0800
From:   Yi Sun <yi.sun@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
CC:     Ingo Molnar <mingo@kernel.org>, <dave.hansen@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <sohil.mehta@intel.com>, <ilpo.jarvinen@linux.intel.com>,
        <heng.su@intel.com>, <tony.luck@intel.com>,
        <yi.sun@linux.intel.com>, <yu.c.chen@intel.com>
Subject: Re: [PATCH v7 1/3] x86/fpu: Measure the Latency of XSAVE and XRSTOR
Message-ID: <ZQ0NkklaVzFgoeww@ysun46-mobl.ccr.corp.intel.com>
References: <20230921062900.864679-1-yi.sun@intel.com>
 <20230921062900.864679-2-yi.sun@intel.com>
 <ZQvqvpSbyub6gFZX@gmail.com>
 <ZQx01AfyvbJQYPsi@tassilo>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <ZQx01AfyvbJQYPsi@tassilo>
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To BYAPR11MB3094.namprd11.prod.outlook.com
 (2603:10b6:a03:87::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3094:EE_|SJ0PR11MB4878:EE_
X-MS-Office365-Filtering-Correlation-Id: 522a4c03-3583-44b0-b69b-08dbbb1e3d20
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9iymedKQccjD22kxDLOEtuH+eBURkjYIUFpGdQc5S1itB0cpWb3pqROjYKeWYCyV2JUIkd0ZUFy1qBHTGoPMzilltigVXBkUTlx/0hZZwmvjFZQuXkUKfivLGyASwtOPSa+kHXz0DGcLtmmoItzvfbnuGf+/JRQSKcCCWDfWndPsZZXrtbMc1KW1MHKsviLAajFOCzeuhDLrdzMvxv9lj90Tzz5EWhHAMZy1Z0kcdgvyXpCbZZU7J7vXzTKt9h0hGbCUGy0Wucm7zR8evmmkevY9GSwdIvkKJ++Nl/PI7Fak9O40vmaDbyXvGGsKlfZvpnqlh/twVZnVyTms83rfgN2M81j2mXKwqJdg/BoCr/cmBUIX56AC6Fm8rUNyFqx4DrKFoin5Rht8n8yHo8aj5PNHBu7x8sBLY/urDwopf3ei+6ma32Uqafs0SjDsaEhUJgrhLHKLgADjrdyYRoJGsZpF/S/BnpDncclJ5qv0xfjLedwBKKAO8k4oADYk+kBob8ESW7o/vakzC/uUhrnEAlsKOsAT07TbUVNjUBimsbf+JB9nUfBleGH5e9oXJ5+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3094.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(186009)(1800799009)(451199024)(6506007)(53546011)(6512007)(82960400001)(4326008)(5660300002)(2906002)(4744005)(8676002)(6916009)(44832011)(316002)(41300700001)(8936002)(6666004)(6486002)(26005)(38100700002)(478600001)(66946007)(86362001)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3V1MHJTd20rMUREeW9FdU9wOTNIWFlDdEswWmlFNUYrRjNtSkZKMkwvenBR?=
 =?utf-8?B?Skw2YVdUS1dpa0FUKzMrYUs1V2tOV3hvMkJEbUxZUStLdmtzanN0dzV5blJ4?=
 =?utf-8?B?L2pLOTZ0SDNDbUpQT1cwQ0pVbjVMajdmT0RGNFZvQzYzbU5NL2dWTktoZFNw?=
 =?utf-8?B?OUt2bDVSejNSWXpudmdxM3ZrV1ptaTBNdUpUcytQakJvZGhnRXFrcjR4NndX?=
 =?utf-8?B?TGluajF5emR5bHY5Mng0WWFXaHBRQ0s5VzhnTzVnaCsvekE5b0JZS1hTSmJF?=
 =?utf-8?B?LzhzcGpZKy9XMFRJc1pRbW5jZVZVZVVVMkY0T1EvMkhhYUc5NENheWxtdGM2?=
 =?utf-8?B?U0hwbzY4V2l1aDZDekwvVzlOUFN1Y0IzVTJvLzdJQXZLU1J6RHl2RzdGUVQx?=
 =?utf-8?B?ZkpWWmpPWnBKVVErWExtNlFBUXl3SkpGM0swb1VTWXdRMjJieFE3RTgybURH?=
 =?utf-8?B?bHZ1L1RLK3ZVeFpNM1YwVXl1ZkNXbzNrbzlXU29TUThTUmdNVi9ldVZrb2Vv?=
 =?utf-8?B?WnFxOXRlQzlQZk9wQVlQWWcyWCtYdzkyTnlESWgxTFlxNThXU01rbE43WDlp?=
 =?utf-8?B?QkVVLzQrVTc4cFB6U3BXMGxBa0ptS0xta0gxSmZSS1FJMGhGNFZWZ1k4dWov?=
 =?utf-8?B?MTk3cjZxNkpueEkyU2UvVU9MS2hsVFNwdWNLZXA5Ylh6TjFpeEtJOHJtYW1K?=
 =?utf-8?B?M0F0M203RUZ2L2FJdXgyOUZMNXEzR0ltek9kd3NOMU1DZkZ2NVM2bjVJQXp0?=
 =?utf-8?B?ejlVZXQrYUNLTjhlcHNMTlZjaGJ4dEl6VWQ4ZTBsM2VMV1YzSXpHakZRRWFk?=
 =?utf-8?B?V1d4UUE5ZDBqM2h4cVV1Z09sdXNLbmEvdmVjYW1sLy9VcFZwUTdrMVNJQnJn?=
 =?utf-8?B?Nzh1VnRFMlhITzRBV2F4eEFSREZJSEpyVjNWdlFnUG1DalN0YVR0RzhJa1dy?=
 =?utf-8?B?ZXJseTRmaGE3K1VYa28wZ24ySmVyS1JtMnBFa2llSjBlNjV4MFU3ZkZLL1Jp?=
 =?utf-8?B?S2o1RVV4ME1HRHBLN081YnFyK3M0MzQzNWRabDlzQzBEcHppdnEyS2NvTjRt?=
 =?utf-8?B?WUcxU0pVc3JJUWI1NkFQNEllT0lYbUhBRFhjbFNtRDBmODkrNVp5THYzRjlI?=
 =?utf-8?B?ak95OXRFZ1pZMmFLSis0bEZVcURsR3ZyRFd0K2VNSDlmM1gzNkNyeFU0WG9r?=
 =?utf-8?B?bndVVS81aUNoNGxRQVJmWWNEd25PZEl3emx0V1J2WUtXMnJZcFBKTGxXblBL?=
 =?utf-8?B?YTYrU1k4ODBwUFh1TFZOV1BoWElQS2FRV2VJQkxRbnNvNXNMc0Ird3hMK3Rs?=
 =?utf-8?B?a21SVlJHTC83bElCdDkwSjFwM3N5MU1kZEhiV3N4Vno0Q0NCMW5QbDZDZTUv?=
 =?utf-8?B?dUJ5cUtkNnQ0d1FKdEp5SGpNYzVLUFZmRVFvUWc0RzBLZmM3ZG9hdG5XdVJ4?=
 =?utf-8?B?SkJDSkVmWm05MHZxUk1MaVhIaWl2clRVdjVHV3ZoMkRiUWZRbGtaUzFzL0Jx?=
 =?utf-8?B?QmNoZTl0TUU3L2tXU3dWeUJvVVBSZXVZeTMxWU1vRDh0MXZvWllsTGJ4SlAr?=
 =?utf-8?B?RVBOL3QrdWJRblpVL2Vub0NyRXBHYldyZkNSSzMvczVlMWxQd2ZHY1VveTBD?=
 =?utf-8?B?VlYzK1NQc1RLMzVjcDRNbEU4cForcEQyTW1PWUQwZ3YwZmF1U3ZsbVZMSE8r?=
 =?utf-8?B?UEU1TUtZVGdZZm9hVmViNHNZdUgrKy95SjBwUWZJRTVsK1QyKytkQUNSZ1hR?=
 =?utf-8?B?RDFIU1F0V0pRQkh2d2FlbVRlNmpxOHN6NjAybXYvZnZQY0tnSkFpTnR2QXpm?=
 =?utf-8?B?WlRDQ1pmcUVLeUxFdC9YbjJrcm45N0VhRVhldG9zVzhBSzlRTlpmMGRQdWV6?=
 =?utf-8?B?VVI1eVZjZC9EdFgyTFFkUXA1OWJGSE13L0F3Q2JtTVNMaDJpcjBoWTFYbU8w?=
 =?utf-8?B?RnhrQ0hIbzgvVExranlOMWRSbjVGUXFRNnVtd0lnUEcvcDJ2Z2Z4L05NQ01W?=
 =?utf-8?B?RW1tQkgrS2NZUGdQTkpTMHgvMzQ3cmxZeTVkNkViUEszb28zVVRRbWJDWGYv?=
 =?utf-8?B?Y0MzOVY2WEFDMnVFQlkxclBWTHBEUlVaMGpXbk0zS011WTd1TFZvWmp3VWdO?=
 =?utf-8?Q?oguF+JHJTK6y+9J+Yhfu8gn/g?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 522a4c03-3583-44b0-b69b-08dbbb1e3d20
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3094.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 03:44:35.5345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDy4JdlgC2s+pDf2hHeph5dOHoDCVMPlf7iutZjYAua4uyS8pl8bB0dNJsHf0QtpkV5zx32jaWlxcLHvWkjI4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4878
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.09.2023 09:52, Andi Kleen wrote:
>> It seems unnecessarily complex: why does it have to measure latency
>> directly? Tracepoints *by default* come with event timestamps. A latency
>> measurement tool should be able to subtract two timestamps to extract the
>> latency between two tracepoints...
>>
>> In fact, function tracing is enabled on all major Linux distros:
>>
>>   kepler:~/tip> grep FUNCTION_TRACER /boot/config-6.2.0-33-generic
>>   CONFIG_HAVE_FUNCTION_TRACER=y
>>   CONFIG_FUNCTION_TRACER=y
>>
>> Why not just enable function tracing for the affected FPU context switching
>> functions?
>
>Or use PT address filters to get it even accurately, as described
>in [1]. In any case I agree the trace points are not needed.
>
Hi Andi,

Here, we have implemented latency measurement for all x86 platforms, not
just for Intel but also for other vendors like AMD. This allows us to 
obtain comparable data.

Thanks
    --Sun, Yi
