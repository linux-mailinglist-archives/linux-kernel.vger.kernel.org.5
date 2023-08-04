Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC40476FADE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjHDHPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjHDHPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:15:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BF135A4;
        Fri,  4 Aug 2023 00:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691133310; x=1722669310;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XaoHTgDEnuHM99MiY/A8lqRDPG6kbhweo3Q8tZlObnI=;
  b=C/TtP3ffZQOvJF7rzUhXyYfNekc3ZWt0raktd99un5jPZEO8jKaEGp2z
   hCzvCTekJgNYQxMuNXKSWwqDnmRO2HzL0EOYdxaSnvmtRKlaKSVioHJSC
   OytXMzyaVR+JXGXeFsIEj3yz9IbOrL2rsOgku0Hx1Bz/Z++G87Ay/Ucly
   5ffJrSDwx9RYfdF93b9QHLVYpTQ7S8ZbsBJCkk9WIHQE+znit0gRyGI3U
   eee6KlzSZGOXoaVIb7ZOjTaUd/ycsS5rTyzzfsqjeAzQs6K+V+iGkcynM
   y9RauGpWcnV4fjRYisILrzG6haZwvqPl66cuXb0rRmUnrfyXwqTHYGK0t
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="433939815"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="433939815"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 00:15:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="764976541"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="764976541"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 04 Aug 2023 00:15:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 00:15:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 00:15:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 00:15:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKqQuX8lcOVuCXBdwGu9c7ZWNGFB5l6wbgjAF6zRh7dV17+qDAJmzbsJlFwQSFZ9XSpanZ66yJDlchzZdBVpWhblhSZiyK31ojNjVOEP/XdbugGkLBq4GUPtYWxZNX0lt6EutSZh4IjSgeHPbUxiwsNG2uC+MJnXEHB7o85OWmdjY+yq6YuPFD4kq9FPYejGYM/kJ2NN180FSRe5QMXR7+lNSbGIUGECvbiuRbH0rSmyGldf4go+8nBwF2jx0tHwqNM90gnZmZU3tgYWwXn84IeJ03trSjsCR1+NnXdI1m8MX+UDhSWhCmFwR1vrXEUzN/ITUctaQ7L2XKlAtvuF7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCE3iJ7SM79uss3F5vWl2qrHM3hXMqRoXgkRDAtObkw=;
 b=dxU1cZCLXoLxHN6Fx1NeyvjFIUkMNNwMGvJJPb5xoqmxVGpk5ghjPSI/d7tLYpR/qJDcwvnV2X4qhexIiSRZoZ2EdarshJxRPmOYtG/TrhAoIr4/mKM/s56rmJWtRNFBFmxDjAii1TG2qayOvmrQHeivCUyRZ9c3ED9CD8WrN/8pu8BmNTcqrH5y4fxD2KxYgdORO6XoU3kEy6837rwSkJvrp5O0i/G4LEgkYPm2PWBZHTJqKVX2aLaXkZG6TZ09R+SnDJkny04q/iIeHeyCub+jD9vsvPyEsLsyfJ8oMy5TTs9F6R3pEfyDTuqBvrsH6RyPzIt4/94NqpCtdAvnKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY8PR11MB7035.namprd11.prod.outlook.com (2603:10b6:930:51::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 07:15:06 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 07:15:05 +0000
Message-ID: <6dbf9f37-e4bf-656d-4121-789e2e6cfae2@intel.com>
Date:   Fri, 4 Aug 2023 15:14:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] don't use mapcount() to check large folio sharing
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <willy@infradead.org>,
        <vishal.moola@gmail.com>, <wangkefeng.wang@huawei.com>,
        <minchan@kernel.org>, <yuzhao@google.com>, <david@redhat.com>,
        <ryan.roberts@arm.com>, <shy828301@gmail.com>
References: <20230728161356.1784568-1-fengwei.yin@intel.com>
 <20230728102405.7b456eb87fb46042fbce5e4b@linux-foundation.org>
 <29cd58c4-08d3-c03c-7232-15f85878934d@intel.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <29cd58c4-08d3-c03c-7232-15f85878934d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY8PR11MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d75eaa-3808-44c8-6e05-08db94ba872f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PicHGwN2Rzs3R6+Zy6PeF8GBtbpW0GpFl022EoAEwlw1JmLLQDMxAiVKJ5R17uZ/3CBNwRsEULzMwN86FMNJLBAvMhV3ISNAJ2z7wTeH97N30zpagNU4pmMN0hkoTDBE1TTUkTK2lcfGcuukuCvJR5TI3G+BSi1TFOurmNyWdEdTprC8j/XJtAbrhHZJ6Dq0H1+RSZTWu5hxwEdd0QMPnAzUJHPQY4CaPiYlkqAhMFPI/zR9G5iY+y//1wRCeetRgxkPwYIbzxz7Qtdvel9SbgvQ9KFzhRdbT+AQEgluXaWW+GI3vgFKS8nfQ8ap1l4uAX9xEfpboTDK6ntWOSHSIB55Hjlvbm2r9pDQMsUEAPdQp30CRYtcaNUYh5LCK6cf9YijHSSf7nfoXVF/gqNPXlEajBKrkg6OKeeSEaCeRGs+hY/l7+QGPfndCOoe8KCcRB0elENJE9GXr11C3B5dvfbil6dQpZeMmBrdEdMVoVuge/Au0e9Hb5U1sM5BqYphJUytUTiMu1UjSvZcF3hROs+mBF8QBEdd47yYkb9i+yydyFoPA8H8OoxMIt9CgoRx4PocTYmFCIczfEZwwZd7w4o3Hwc4Sj89ZXpU486moMOCdolwzgi62lKf0/ObfwA5jG0v+gDtf41IPXatn7jMYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(1800799003)(186006)(316002)(478600001)(2616005)(31696002)(5660300002)(2906002)(7416002)(86362001)(38100700002)(82960400001)(36756003)(6666004)(26005)(53546011)(6506007)(8936002)(8676002)(6512007)(41300700001)(6486002)(6916009)(4326008)(66556008)(66946007)(66476007)(31686004)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTJTcDNmcTNNdGZJWTFwMmhvR3J1Wk9OdHpuWTh5dHh4RGJkdVlmTFhsclVw?=
 =?utf-8?B?M2RFZEhZTTc4NGZMZEdCYmc5Q2dhemxucUhCVENrMnhkSVorMHZSNG1La0xk?=
 =?utf-8?B?YmI5bVZqZmRwdk5pcnpzWE11WXFEQXZzUmhmZ0JpMzk4MHVnaUdobWx0WU53?=
 =?utf-8?B?alk2VnJMMGhScnZNNWliZW05Y3M1d255R0x2cCtaZmZrTTdvMVQ1MTlNSlpz?=
 =?utf-8?B?c1hzd3RiaWpqWWxqRGU5M1grekFSSmkwUWlrKzgwQkVzaFh1RlRTYkRHZ2hj?=
 =?utf-8?B?NGFSOHlGZklOWDNzYk9rNkhSWVJ6RmVVL2JIUE1INzBWWTBqMzBiYlB4MnpR?=
 =?utf-8?B?MFJTZFdPTGFLSkFLbTE1S3hZZnBwM1hZYk1tOFpoUHJlNE5QWVdpMFRoTUFS?=
 =?utf-8?B?RzdFVWhDb1Zqc3lFSHJJUVE4SThRUndLVC9kTjUyNW5Dd05XL3dMdlp6Q2FP?=
 =?utf-8?B?K1dFbGlCM3hvRGl3RnU0TENKQVk1NktZNHZ2eGpWR0xvNmxpK1oyZ0x0YkJ6?=
 =?utf-8?B?SXlGeFc1dVdvRFI4SVNrcWpMZW4zWlpnYUZSN3Ura3pURkJjRUpCbVJBUFI5?=
 =?utf-8?B?d1U0ZFpHT01BYW5RMzVMSC9JcU4wMVN4YnZBLzRWc0RrMDhGbk1qNGFrbEtv?=
 =?utf-8?B?ZEpLalZpMHBBYTd2R095bWNyZzlZVWM1RVY0M2tOV2RDN3ZYc1FybmtuU3Iw?=
 =?utf-8?B?T1JucnZwZUlKTnFMRmNpNzZGbTJnVi9uNmRXa3BFRUlDZ0t1M1QwVEgxQ2wy?=
 =?utf-8?B?WUxEM2VMNDQxMTNtc0h2MHIwblFXKzJyMUVtMnhnenFoMkRVeEY4a3NEL0tL?=
 =?utf-8?B?Qzg2T3MxUFhQRUh5bXZTTFZQUVg5LzYzV0FqRHMyZmE4NjhxMTJTYzFRaEhV?=
 =?utf-8?B?bStoa2cvVkQvWTZLdzFTM0o5Uk9hTE9GL3lna1k3K3VycEZXUXVNbEdyZnBP?=
 =?utf-8?B?c0J6ak5kTW9ZazFLTTRvUXVsUFpBR2I1U2V4TzZLM3dGajhZUDBybmg1bysr?=
 =?utf-8?B?bVJvV3g0V1pvd1gyYmxEYmYzKzBVS3E3WWV0T21WWXBmYitRRTNRc0NmWGtE?=
 =?utf-8?B?SWVob3A5eWkzTmo5Zk8vbkRwVFFFdVE5QUh5NDNhOVlEMkxPOE4rbmZXRDFm?=
 =?utf-8?B?TGZQdENwdW52ZTNiM0tPRlNOWFpjOXg0RWhtWHNVK20zTk9QdDRyQ2E1ZVdm?=
 =?utf-8?B?N2x4OWpRZThza01WTVVWOE4wdlR6RUIwMldKbGtaakwrbVkrK0tyb1lCL3Z0?=
 =?utf-8?B?WTh4SERGcXNrZW1WRVpoajRpaCtncXMwNk5pcGt3ZjdqdWxtSW9ZTmw1U1RO?=
 =?utf-8?B?dEk0VDNZdC9oR0xYOU5BcGtQcmhMbFJzOE9pOExiQmgwRnlJdnV6RzZSWFBn?=
 =?utf-8?B?ZkwyMk95a2ZidXR5dUNYU25OV0RUcnFhaHR3aWova2pFa2pNYURHQXRoN1NG?=
 =?utf-8?B?ZlhYWnJ5S1VjWHNjS1kyemVzWVdGbXZubUNETVhOeHJwZjJkczMxcTZ1UGEw?=
 =?utf-8?B?NVpDdElmeE54eDNnZzVuc1dkTUNUT2tZOVNvdWdxMjJsOVRBZk5HZGJkWHdy?=
 =?utf-8?B?bkNmV0lpaHc0anlYTDJINEFpLzFxODdjTnhWSnh3d0hSVXNjSS9oR1U3K1VY?=
 =?utf-8?B?ZHU2RXhWL0FQS3JWbjd5L1g3V3RIeTFqTXJVZHJYcG1DdDNMSXNtenJkVFBN?=
 =?utf-8?B?RkZSVWNLOXNjVXNjMUVwVUM5c3VpbC8xdVlQU1AwSE45UCs5Q3NnWWNlRjU0?=
 =?utf-8?B?YTZjMzFiTC9zWnpFa1VndmRjTXBnN1ZQcHVHdlBVK01OMnloMXNYU2R1VWU3?=
 =?utf-8?B?MjdXNmkxYlhmRFFLZ2pQc3Q5SkNzcDFkeER1N0pzMTBrNEErTmc0bUtBQXUr?=
 =?utf-8?B?K1Q2WkNvcXJKaGtkN3NCNy8vQlZpM0dlMERqKzVjQkkwR2dqMnVJWS9TclNQ?=
 =?utf-8?B?QmpNbk1ONnJZT0hqcFBWT29JdHY5dnFFQklNK3hVbjNiTjZBZXp5UVhDVkRX?=
 =?utf-8?B?TXZsTkUxeTVuM3RGeDgyYmg2N3BGeFpJSkcxVjU5ZTVtTVhTWGpEOFdIanFN?=
 =?utf-8?B?cFYzeTU0RGlobjVGNFBRRVBqdThLTDYxYmYyd1JzbjhsaStwQ3VneXVzVmly?=
 =?utf-8?Q?Q93MwMLBTxv2AH2z9mqe+9Qc2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d75eaa-3808-44c8-6e05-08db94ba872f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 07:15:05.8819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Nsdj86dHZUcicf7j0qU+Njv3VbADgKXFktE7yAE3xKMsgmQliXMju3KG3Y6K3uh8XGGAJRWmZ9wSjENb75mUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7035
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 8/2/2023 8:39 PM, Yin, Fengwei wrote:
> Hi Andrew,
> 
> On 7/29/2023 1:24 AM, Andrew Morton wrote:
>> On Sat, 29 Jul 2023 00:13:54 +0800 Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>>> In madvise_cold_or_pageout_pte_range() and madvise_free_pte_range(),
>>> folio_mapcount() is used to check whether the folio is shared. But it's
>>> not correct as folio_mapcount() returns total mapcount of large folio.
>>>
>>> Use folio_estimated_sharers() here as the estimated number is enough.
>>
>> What are the user-visible runtime effects of these changes?
>>
>> (and please try to avoid using the same Subject: for different patches)
>>
> 
> Can you hold on these patches to mm-unstable? I think we need to wait for
> David's work on folio_maybe_mapped_shared() and redo the fix base on that.
> Thanks and sorry for the noise.
Sorry for bothering you again for this patchset.

Let me explain the situation here:
  - The reason to hold on the patches to mm-unstable is that I don't want to
    promote the fix in this patch (using folio_estimated_sharers()). The
    correct way is waiting for folio_maybe_mapped_shared() from David.

    Merging these patches motivate using folio_estimated_sharers() in other
    places. So once folio_maybe_mapped_shared() is ready, we need to replace
    folio_estimated_sharers() with folio_maybe_mapped_shared().

  - For this specific patches, if they are suitable for stable, we may want to
    merge it (special for stable branch. I assume folio_maybe_mapped_shared()
    may not be back ported to stable branch).

So how do we deal with this situation? Thanks in advance.

Regards
Yin, Fengwei

> 
> 
> Regards
> Yin, Fengwei
