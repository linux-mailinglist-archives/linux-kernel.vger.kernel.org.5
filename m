Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C677765B2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjHIQz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjHIQz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:55:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DA5128
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691600158; x=1723136158;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=llLLY3VUBgs+j6EWlUby3sci/oK4jgJ2oWM/GWUXOPI=;
  b=B3fJIn4j3K5yGW2OiBKlx21GIarwgIqjBY2vy4S25JglgiQNuOmlHpRs
   JPXBMlJ3I3urjaFnmanPwLTp2a5zsN7YIyBnmtWtgtu3Y4yJRqYg4UIwm
   sL9I4wybXEqqvzz098DUdBb8B+lAU9CrnjT+Xbv1XVuVk/p5tRNvSE29C
   I20kD5Yi6hTKXz7Y0D9dzJkgQqzN8vdK1OVjOQx3/EiGCtOvBycc2u7VI
   fE+fabNz4V1YuD4ZIppoCgOXI6xe+iP+koMsFibyWlPCWIcTy43USlMir
   GXfw5y7s6b75GHDhAjj+ZN+iXJPvM2I/6eCcYa5Q0jN8yr5A+vSI1ByRL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="370077185"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="370077185"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 09:55:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="731887756"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="731887756"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 09 Aug 2023 09:55:40 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 09:55:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 09:55:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 09:55:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 09:55:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oK6JG1s6emAbsYMI9YLEDep1h9Pt5ordkbtPzovf49a/oeYeXpjMKKHJjLDw1n+YevBEIsz6YRiirdqQO6C6WFQDaNCp/7rfbV3qDlpjFNAMUcqosxVZG5nrkkiT+4lKJr6aSPgdx6SuivSm66+Yk26gpgmvE+IupApCzLaU4UFUpEZbjj6lpzkiHdNh5eRiPo5enNDv52ywC/7QdTknPU4dz+Mf4Vf3aO4eEZmb21tmtrGmsmLkdu1dDERp/qHIOCrZXgCd4Sv073BsfrfS0hXAfcQP5JaWWwYH7OIMQDhYVotvGgDRjtc/QbY5d9FRgtOXfC+mvSb9rAzjy/NCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+qyFqDiFtg4l/a/IQv7f7EGrPE36TufvAd9pQTdFII=;
 b=nu2RmkAPBVdrHBxB6p4fYf8zF/qETjnbIBTMhgoefxUMZtDMNyWW7kpZ8ydUe0gKPvRvSdmSclmy4no3CbhDHiKlZEfMhIO1EMBupbNVJ1bW8G8+oCLiYEPZWxiiyWm1Q0PI7QQOOPzF4IOZenVA1UlXmIPi+V2kLTQOV/AvdGmuWXM30xYsHYPz0Rs9fiCw5vRPkPDJSzKq8WboUoA4iwnpAX544t5SASm1UFQZXVyv/5cslavLUdrCKhhICoO2ei+E3eZB0h0F+7Lp4qtGhr9ICQGZN2X1iZZwwsTOf/kLHDeQTXhwNUQ17BYMeRAB3GiWdAENTpzsu0p1F7uyZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3322.namprd11.prod.outlook.com (2603:10b6:5:55::19) by
 CH0PR11MB5236.namprd11.prod.outlook.com (2603:10b6:610:e3::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.28; Wed, 9 Aug 2023 16:55:32 +0000
Received: from DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::64e5:1afd:a48:29ad]) by DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::64e5:1afd:a48:29ad%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 16:55:32 +0000
Message-ID: <a4007aa9-0320-87f3-cf7d-f5c025516d68@intel.com>
Date:   Wed, 9 Aug 2023 09:55:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [patch 00/53] x86/topology: The final installment
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "Arjan van de Ven" <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>,
        "Juergen Gross" <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
References: <20230807130108.853357011@linutronix.de>
 <c8ca9e16-ce03-1fe0-cf9f-f6cc2302dbac@intel.com> <87h6p9l58u.ffs@tglx>
 <7ef60626-28ab-a4cc-2f24-4f35e3d946aa@intel.com> <87edkdl10w.ffs@tglx>
 <20230808221039.GH212435@hirez.programming.kicks-ass.net>
 <ee7ee03c-43b0-a891-e94e-4a2eb7c5da64@intel.com> <87350tktp2.ffs@tglx>
Content-Language: en-US
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <87350tktp2.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0114.namprd05.prod.outlook.com
 (2603:10b6:a03:334::29) To DM6PR11MB3322.namprd11.prod.outlook.com
 (2603:10b6:5:55::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3322:EE_|CH0PR11MB5236:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f0df1d-0671-4219-5c55-08db98f9719d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2NOZIGNc5WPgpNx4yRHsx2auYpNdUI0lr5XT9j3WXwcB4QX93csBWgfofFbvRRn579TDk7QSKAZrk1/QZVq5LMp6IRGLIUnrRbF6uwYycx+zjR3l4smIvlclSVAl9pHhVWrl//xa5gbS9mFtIQu+4c1A3IhDns/uAkn4SOZTgSUCinbZ5P0ZtooqvHD10Bko0dfVcI/yTHeSosGpru6OdJ96yERGhIdf0IPnoajtW9ie8Ir1cZfS0jk8rYeEVH3AD8fPCMs3eydRiScMQuRz0BY/XOI+IgMFgkUkc2SEWS+KFZUATfJ1jICGRRHhxn3l/evRXOxOwyW0B8Q5px8+pwvdCJ4xLR4T1uWwGw4KPg9aJyGx37gXl4z6B/5TLi+AuyT+KKPVfHlGb8SNZaLCnFdOhYHk/MxE0IvU/NT6/EAPrwFoSMjILCsgIk+crtTH2uSwGn/neVenD3m87pYV1uXcg7UfV2lrMPxBtepNtwucC4ySrVyA2oYvUu4fXNPoot8eCfaeXHbbCSo2SjUX3cHFM1lWx535Frjlu+kKHtTHpNMlr4EuoCgHQnTNAaZlGNnZaNx26G2biYb0gqa1677f8eXo+lPfw1/ATJ+7o3JE1Gedna3jQiXeGnqcu0Z3zwQX7E7PqI/fq9ENrrwA+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3322.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(39860400002)(346002)(396003)(1800799006)(451199021)(186006)(31686004)(54906003)(66946007)(66556008)(66476007)(53546011)(6506007)(26005)(6666004)(478600001)(110136005)(36756003)(2616005)(7416002)(6512007)(44832011)(316002)(41300700001)(4326008)(6486002)(966005)(2906002)(4744005)(31696002)(86362001)(8936002)(82960400001)(5660300002)(8676002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME5YUE9CNkVvMG1kbzZVL2Z4YlpiK014OWF5ZitSNk9waGZGa0dNeWd0ZXlv?=
 =?utf-8?B?Q3N0ZVVrYkRBdUJDSURXUjcvdlVlVGtzRVozYU42ellsMFcrdTc4QmwvdEtt?=
 =?utf-8?B?ZUJzdTJGcVMyVCtHR2Y5Qzg3YlNIZnNzVGFwcmExT1U1QzJ1Y0lTV0NhT2Q0?=
 =?utf-8?B?a3MrQmhjMVQ0TlJ6MnNyVlgwMldVdjZUejVMclVsOE1HVlRSL0ZpK051M3Nv?=
 =?utf-8?B?aWtlcGRrekRmSmJ2emdoRWc1WG4ySWw0Rm43U2lmaktnUUZncWhmdS82M1Zu?=
 =?utf-8?B?RElUMmo3L2VEQkQ0c3JoTHBvOE0zdWVISjhNaEhHaUZHQTY4TFNid0JSeXp6?=
 =?utf-8?B?VVptMW9TbUx1aXZ5K0g2R2dRQnZLMHRsazAzcUl1TGkySE5tc2Njc3hTOE05?=
 =?utf-8?B?UU96L0FlSGRDbkprNXkvZVVkaXYyQlBkbDJKdFBWeU9VQ2E5dnF5UEh2UFpo?=
 =?utf-8?B?VUZHd3FqK0ZIaURURTRqbnZYa3loT2RzQ1hWcXRGdlRFQm5LNTYzTmdxczJC?=
 =?utf-8?B?WG5lcC9jbXNIYUZFN3R2K2E2OGhRRW5mQjlBNUdJeEZWMUdPQU1Ua0UvNVZW?=
 =?utf-8?B?V0lyTGNHR0NzZmorODJJcGNCK1h2SmYwaWJlMWFVVmFwbUIrdDJwZ0doLzhU?=
 =?utf-8?B?ZUkvSEVKalBVenhWSmVOZFVRYUVxdUtiT210ZUFmdEsrMncxZGpiODV2ckF1?=
 =?utf-8?B?TjB5Q0pYb3JueXMwVmgyTlUxMmtvZ2tjZmFxY3FQU1JXVkZBSXRMYTNoWnMx?=
 =?utf-8?B?TkQ3cUdDV2wxUkpEUnBsbW50KzFPTU81dmFHcGhIdjlPVzR1OWNJT09WK0pN?=
 =?utf-8?B?dkpoS2ZNRzlPQVVWWGdHbUFCU21MMkF6RVRacmZBNVh1ZndaOEg0QWZoQ3dt?=
 =?utf-8?B?SEVZNENPTVdYQ3BJRDdMUGJrVjR2cTBPNTN2c2o0dzlaUUlVeFZtME9JbGE1?=
 =?utf-8?B?N3FNMDJJYy91a3lYUFJrcUpkTjhHTEZiRDA3K1JBVE1xVCs5dWdpSGZOeExE?=
 =?utf-8?B?bzlBNUcxaGhTbFFacG5PTW5sZ3A2bGg1eGdBbGxVT3ZweUVDUHpraW5OeFpS?=
 =?utf-8?B?eVhsWFZHVjh3QnhWV05GRVFlbzh2Z3U5c0NUMjErUUd1R2JBUFpacThJRWpQ?=
 =?utf-8?B?aVRIZVRxNUZmaEx5ZGR3cTNJTmZ1YksyRm5ZckNCZ2JlOWJ2T2RtZUtvdHBa?=
 =?utf-8?B?b0hwd3ZsdmxuL2FYbFdnNEJianUyTGFqNm1Td2lkc2VpYmxsZWozRVlQMENY?=
 =?utf-8?B?Z3haYkgyZk1Lc2o5VkpNT2tMbmFBVi9icGlWTVJodFlqQ3NGKytVYlRXTGk2?=
 =?utf-8?B?dGc2L3NFak9DRkNKWXN2Sy9zWE1raWxha1lPZTZMYnhuSGZJakVsbGdiZGQ5?=
 =?utf-8?B?UXU3SUpkK1JIdk5zcjhKNC9Pb3RMODJGdEVIdDJ3Qi9yKytJc2pmRUh6dTd3?=
 =?utf-8?B?bWMvcVFOVXd2b2RxOE1ISkR4MFJTT0E2R0VKRkJBSkFEWmVWbWZoalB0TmMw?=
 =?utf-8?B?YUwwWmE2ZkU4Q2x0S01TbVJlbW9oT1BOSlIwQ0hHR0VJTTFMUEs2MmJjb0JV?=
 =?utf-8?B?Y243UUhhNzdFa3JzV3ptTnd2MTNJSU5lK0NybEVIVlRxeGJ4ejNHRlpjWUJy?=
 =?utf-8?B?cWowdXFEazdUMk9LZWlGNTVsNVd2T0lmc1FMZUtIZUFHUGxjUk4vZUtGT0g2?=
 =?utf-8?B?bzh4ZUV6WUtDVlJBRFBYQ2Qza1ZKSUJXcmlLOG1xMzl5SUliL21VTWtvbjFO?=
 =?utf-8?B?dU93ZGNCZGdua3ZGbTJGWDdCeWVUYjVRMDBpSDIrWW1iN2hsYXRHdG1GM2hT?=
 =?utf-8?B?bVlZZ2pqa2FDc25Lb1p3VzMvSGNTYUR3cy9DOGthbGcwajN4K3IranBzQTB0?=
 =?utf-8?B?bnBYOHJscWUzSFlKZHdadzAzWGhPdzc1TkNZYjcwbloxNXhxMS9oU2NZbnZ3?=
 =?utf-8?B?K1AzQ1BVUTRyeUpOVE5aeGxHMlpKVjJ0TVFGL2hTTUlRRGYwVk42NlZzaVN1?=
 =?utf-8?B?MjE2ckIrdjB1bjkrdEgzcVlYdHFrbHFSc3d3cyt6SjZEQkxZdk42aXM2WGl6?=
 =?utf-8?B?L2JHN1ZYNmFGWTdaakwxZm5odDJKVktaQVpGbE9CRVBHSFVjdWlVV0RIK0E5?=
 =?utf-8?Q?//Xy3Ijl7Ok7oYwkYFV7LoeDv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f0df1d-0671-4219-5c55-08db98f9719d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3322.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 16:55:32.5351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A//s6zEMY5v8gVYcgd1kYMcZTWHmkoK1LkEjWCGApyWntw4ISo2r+ZNIwk9aEl28DwDFM4jlZqtdh+2eD9a/DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5236
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/2023 4:20 PM, Thomas Gleixner wrote:
> That makes much more sense now.
> 
> Zhang, can you please follow up on:
> 
>   https://lore.kernel.org/all/613df280116378115585d0c483f7e186cffaeb58.camel@intel.com/
> 
> or otherwise I just polish up PeterZ's variant of it tomorrow.
> 
> Thanks,
> 
>         tglx

For the full series (with PeterZ's patch applied),

Tested-by: Sohil Mehta <sohil.mehta@intel.com>

Zhang, Thomas, please let me know if there is a different variant of the
patch that needs to be tested.

Sohil
