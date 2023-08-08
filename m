Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819D2773552
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 02:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjHHACu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 20:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjHHACr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 20:02:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099D5BD;
        Mon,  7 Aug 2023 17:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691452965; x=1722988965;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iLsAI05iVgfkB1N2st8m/Rx7c7rCmLQqmQ5UKrcjgBs=;
  b=d9S77yfAEs/pNSaq5jvktx5j0xDdp/9PgNKiDY/Vq8TsipZjNBOBAEtS
   m/oolV4EB21QpwruYXttuxCMlv5KEBSZ57fAbj1dUfsTjaLDydf6zRSt0
   abhCqjJL/8CsUIF2YB9tALl98JwyT49oHeU1ilSM9YyumsZg5UN+0H7zr
   1CNcIAAFuMy92BhEMks+iiEz6xm0mfoDR2sPCCMcYoDJnwx7MJOA0ODzN
   /IyvQaU1luinXbS4bnBTdXWgb/A9Mi6y07eWPzk5UFSEEHsRF2aLoNnk3
   +1TbfdmTNjVSVMcuqwM3uKO4RHmm5QuY5GiKcVOgkmF45x4BSE3Y0LFWM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="350272033"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="350272033"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 17:02:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="821145705"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="821145705"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Aug 2023 17:02:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 17:02:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 17:02:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 7 Aug 2023 17:02:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 7 Aug 2023 17:02:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxcJVgnp5ImicGVILhdCbOOAR6uTC1mjgWqWr1IkR7IzMgTRv0p51J9H4l+SVZ0dyK7USua+zdwG/7jCirs+ymZDLkA/0lP11kTMX/tByqU/EbopQrnlEsn88wJ9Mx/CLnspBQeOOYFQhWHe3XOcmfIFEQviqQbehYmhT6bXKwPlnAEXBMj2Wk0a2yX89KRx7/pQG+JMSBWf6y55bEmbHf/nGWPw1MonGSpTyxB0EbHpmh+ciS4RDZKC8DVR6PAZPU2Oy0lmjWxTr2XE+OCaQY3K3m+lTMDB5qiT0KORF8+6JrqxuiKCH4L5vYvqI05ZJyFqfRib1w8gNWXAE+wPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSkH9HsPoS+Dkj4bOXnNHIopqeHtQMORfjo5cVYVbKQ=;
 b=TZ/qVMyQwB8VLR+mVqssmywXoAAmOhjza2FyM5YQE4hbCu2FPoNAO4rjnAqyepz8JXOeAB/4Xp65NGU6JYJuOWRfNvcMYpPo5vwaLTq3L2FlcTwMrGO9tZuk0yxH9PeJfDznz5RO3ZO3TBIr+ZvH7M/4d/XaCrElUqsyNdAl9K8ifFKjyWDXXcbbkBiDp7M50zqafkYwz47A1urtzXq5TAQJvhIejQa2ecSQqxIksEhfOACWntWRifXEX/MTrvbKQ0XhrBwHCGkyaBcE46uRRqg8Kz5kqViotL1RYF4Gds/ow2+FtQsqcH71zf4sbc8jJfGbiuUyec94VTnJTIQ/ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA2PR11MB4986.namprd11.prod.outlook.com (2603:10b6:806:114::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 00:02:37 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 00:02:37 +0000
Message-ID: <9e92e42d-488f-47db-ac9d-75b24cd0d037@intel.com>
Date:   Tue, 8 Aug 2023 08:02:28 +0800
User-Agent: Mozilla Thunderbird
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
 <6dbf9f37-e4bf-656d-4121-789e2e6cfae2@intel.com>
 <20230807094342.17199a897f51a298f20fda57@linux-foundation.org>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20230807094342.17199a897f51a298f20fda57@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OS0PR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:604:98::12) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA2PR11MB4986:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd544b7-e871-4344-609d-08db97a2c610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yiukz9xPTYcM+AddGo0pZ/7pN1lAU8RMxdsJcLQhYMrOl5WZzzvP9oxqtFsR1WCWQA1nV+xlxFk7DlbdTT5uHAlE7Jkb2iTCXo3xA9L+q7J2x+b1OITbGgI3ZILwDQcebPvCIt8571/TxR4IKOyWR9kp674el+h3B3fwNSVg9yCT4a6u7pO7B0SnmpwzfCCSn05rnF2GNsQq6MncybOAeqMOUL48GhigRKQ2CzHg8AJUyTN7W+9+PbPUx+bJ/jNJqjxLa4WwkibDqzckFKp69Cv3kz1JVY6S85kNtisjgjI2D/X2z2T3gR1iO/Mwqla6iTKOMIrfWpuVxwIoAyEnLFl/RCz34JhriaopbOCTBoRvAoyT5njLdgmqNWmAuWV6uYOuxlYT4ePwA98GbWeLXjBV1qE2ivlujXV9VtHuAuCqXGWygaSTMxsFGnUaPq61gkOwTWuInRR58KMe6NDMPvIzWA/T7F0o/ksG6QZpDlFWUvQsvqcB78Z4KoIaU2/hUnC5VVMDjMm9M/JkGY6HvtsNu6VzckWlCHFiBrOBSkwvnX1VWz2jnc+XgBfZ3x2ZY3cceWKBGGtVQanzjHu616cdw7BzJgRWVeQW5ZPqydvgqszXjJrjeSecHUYqbvK1cXn32OL/GFAO0xV4yNbJr2njlAmC6QugbEMHW0FzhFtxR4LE8TS0YPZ9fVbLE1P7/cBd1lwDzxwGNM32sJA1Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(136003)(396003)(39860400002)(90011799007)(186006)(1800799003)(90021799007)(451199021)(41300700001)(26005)(2906002)(5660300002)(31686004)(7416002)(8676002)(66899021)(8936002)(2616005)(6916009)(86362001)(316002)(31696002)(53546011)(6506007)(6486002)(38100700002)(82960400001)(478600001)(66476007)(66556008)(6666004)(66946007)(6512007)(4326008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0RVWGdQTXEwc1NqcUp5VE02ckc1MU9NVXRuWVVwRE9xUWw2dWZteWpHZURz?=
 =?utf-8?B?cHRSaDJrNERtN3dVYzgyNmxTOC9CTk1jZjBzK01zWmtjTWVRTll3MHE3WFVx?=
 =?utf-8?B?WFhDbjJnTW5iRncyOEt4M3JQWHV5RXFXMkVmcTBRS0xGWFQyd2xOUE01N1N2?=
 =?utf-8?B?R3JncWVESGtJNTNuWFhOeWNNZnZ1ZVh6Q2RWN0Y3ZkJHM29nRkYydUFWa1Rr?=
 =?utf-8?B?L0tVRm5aL0pDcmhiZ0E4TDNpTFQ5SkMvTWoxaEJBUDByRUVuczFYTi9TV0xh?=
 =?utf-8?B?bTF6b0JkRzVxcHZLK253N2tORG56ZVZKM3VkQVY3dlNaUDJqS29zNyttLzlF?=
 =?utf-8?B?UVVDeVFoa1Rud1dZdWZpNUYwZWZGaFZlT1VNRjdGZGExYnR4WE9FaHFFVkox?=
 =?utf-8?B?U0djWHNjT3lyYmMwUmZDbVlSSXhxMGJZcWdGQXMrcEFsV0FkTGRlKytnaVNt?=
 =?utf-8?B?ampUYjF0eU1YY3lOSEVmTUpnbStFcWdFMDR1bHByd1ZMNGIzRHNkN1hpaXhZ?=
 =?utf-8?B?UEJZaW1nTFFqQmVEMTNLaVRheGhPYXFnclFvTEdQQkxkVC9XRFpyWHc5YU5Q?=
 =?utf-8?B?S1h3bmJNU1lVQU5QNWxFMzlFQ2EyYy9xc2pHZG1JLzhUSWZiRXhoRWFzbHRa?=
 =?utf-8?B?OGpOWW1YQUZ4MnVWSnUxYmlzQlpVVWdtWjVYVWRSWWRpMmtzdG1yaU91WHZH?=
 =?utf-8?B?L1VJZ3dMdlVPOEp3MklsTDVmbFFESVMzRld1YWlkcHFZZ1k0aHZaTlBZb1Y4?=
 =?utf-8?B?Z2tkTlpDVlhqYThUUkxmWG9sOVVIRXQ1VVppVUZRSkpCRHFmV2FjR01WQ3dp?=
 =?utf-8?B?WktEaGpXMnNNL1hUeWpzWEdpQmlLdm81UjdEejhrMmt3bWllOWFsR2dUOTd1?=
 =?utf-8?B?RUJIWENCVVVuQVgzK1VjMy9rY05Vb3dxckNZM25oYkJmK1NudEcySXF0UEJ1?=
 =?utf-8?B?KzdkZzlKNVByN1lBNnBZQUpQQll0N3U2V3Y1U0VLWmdFOTJkNVJ1QXlHekdY?=
 =?utf-8?B?TUJDL1VYMkIycWdMaE5qUFJnWUh1MlVndllDaEFhT0JraEF0YldmUHpmY0E4?=
 =?utf-8?B?OHIySWhqdnRzNXVIRDBSZXJZZXN2L3ZVWnU3UU9PdE9NemVvKzc2NWwxZGVj?=
 =?utf-8?B?WGZkUU1BeDBORHl5RmoyRXVVVW5xaWJtM3NGaWhyQjVwNUQ2TmhhWXovajJl?=
 =?utf-8?B?b0RxOHVnZmE4cUNLWG41K0tiOFhUSnBVaWhlQU4wT1pYZzlQZWNIc1pQS2xk?=
 =?utf-8?B?L2RJNmlkU3E1UXZoVmJsYlJ6enRkSUxiNHUzbXlwdFBvQUMreXI4a1F1Zndx?=
 =?utf-8?B?T1h2ZlZvcGpxZlFvRFNUZnpkWURyNkU5SkFmeitLQXlsU1RUVVdGMzZNMHll?=
 =?utf-8?B?QjNuYWoxODNvUWVqell0UXhHZ01CNDd4dHhmZ2dzTUhnY3JhSmtobVNuVkdW?=
 =?utf-8?B?Y0Vud0I5aHY3cGpYcDZxMk5acjdEeWdnY25rT3Z5QlhDd1RYUzBRcFhlVlph?=
 =?utf-8?B?M05SczVwQkxVR1JJaFpseEFlN3ZjYmE0RW9WZm10RXVoU3hXU0wrR2NpOUFq?=
 =?utf-8?B?cVNHOVlzSk5UTkxpclU1RWVHNWEwM0M5WHFhVURYckw2N0pUUmR1bGpha0Nn?=
 =?utf-8?B?UTI2dkx1MTRMckdDZXBIRTByQ2FuNzVYTW1IMjVMQzRyQ2p3ZjBOZEdCS21M?=
 =?utf-8?B?WWd0WCtXZFo5aXg3OWRyQWxPc1FQbzIveHhpTEpUZEIxUGs3NUZqMStNZmVU?=
 =?utf-8?B?c1YzelpWS3BCemtQZlZzT1AvU0tnUmthUWQ5dEE0c043MzFabWVta1dsUE1s?=
 =?utf-8?B?Q0U5MC9TdnpuTDFSMXo5MkpWTDRqY1N4RXZnYVdxS2hoWnpaeFRjOXZoS1M4?=
 =?utf-8?B?dTFQUUI0T0tyQUJIMXRGWmhhekVGVzJaWXBpTVZFeE15Mk83TS9NS0FYcWJm?=
 =?utf-8?B?bW1WS3RZSXZVVUdhWDhyOHM3bVMrNTdhOWF5dWpwdVNmSlF4cHlPbjhEZ3Mz?=
 =?utf-8?B?RkRCd1d1Q1FWZUhMaXM4QkRMVHBrblJFck1GQjlxdHVvQXg4UVJHVmlpZXFG?=
 =?utf-8?B?QmF5UGxkVlRCN1JmNWVpQXIwU3Jod0tFQ3BydWFiUVNiSVRTTTM0QjBRaWFv?=
 =?utf-8?Q?NGEtBFIpsh+KqpFY4UYU1zVgM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd544b7-e871-4344-609d-08db97a2c610
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 00:02:36.9663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: na3NpvwRAHPOKqoEAo9dqA5u40lEGYwyLmna5cAJy8ZYI8b8viIu4TMIPKHNzmnziRdvHmSPpzN0+QvTtonOeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4986
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

Hi Andrew,

On 8/8/2023 12:43 AM, Andrew Morton wrote:
> On Fri, 4 Aug 2023 15:14:53 +0800 "Yin, Fengwei" <fengwei.yin@intel.com> wrote:
> 
>> Hi Andrew,
>>
>> On 8/2/2023 8:39 PM, Yin, Fengwei wrote:
>>> Hi Andrew,
>>>
>>> On 7/29/2023 1:24 AM, Andrew Morton wrote:
>>>> On Sat, 29 Jul 2023 00:13:54 +0800 Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>
>>>>> In madvise_cold_or_pageout_pte_range() and madvise_free_pte_range(),
>>>>> folio_mapcount() is used to check whether the folio is shared. But it's
>>>>> not correct as folio_mapcount() returns total mapcount of large folio.
>>>>>
>>>>> Use folio_estimated_sharers() here as the estimated number is enough.
>>>>
>>>> What are the user-visible runtime effects of these changes?
>>>>
>>>> (and please try to avoid using the same Subject: for different patches)
>>>>
>>>
>>> Can you hold on these patches to mm-unstable? I think we need to wait for
>>> David's work on folio_maybe_mapped_shared() and redo the fix base on that.
>>> Thanks and sorry for the noise.
>> Sorry for bothering you again for this patchset.
>>
>> Let me explain the situation here:
>>   - The reason to hold on the patches to mm-unstable is that I don't want to
>>     promote the fix in this patch (using folio_estimated_sharers()). The
>>     correct way is waiting for folio_maybe_mapped_shared() from David.
>>
>>     Merging these patches motivate using folio_estimated_sharers() in other
>>     places. So once folio_maybe_mapped_shared() is ready, we need to replace
>>     folio_estimated_sharers() with folio_maybe_mapped_shared().
>>
>>   - For this specific patches, if they are suitable for stable, we may want to
>>     merge it (special for stable branch. I assume folio_maybe_mapped_shared()
>>     may not be back ported to stable branch).
>>
>> So how do we deal with this situation? Thanks in advance.
>>
> 
> I think I'll stage them for 6.5, with a cc:stable.
> 
> I'll drop the current three patches.  Please resend with
Thanks. Will resend the patches.

Regards
Yin, Fengwei

> 
> a) different Subject:s for all patches and
> 
> b) changelogs which fully describe the user-visible effects of the change.
> 
> Thanks.
