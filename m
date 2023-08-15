Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B52977D6AB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 01:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240617AbjHOXcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 19:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240614AbjHOXcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:32:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3281798;
        Tue, 15 Aug 2023 16:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692142323; x=1723678323;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=W3Alss24rkmgyQ8r1Q1PR+ZfE41lK1Ve2blopDUXExo=;
  b=DJK0eqx2r6bGxL8jOB8mVpJPXCpONRgM0RqaawOlW+PTyctAw1vQ9klo
   JIaDUwyxMJP/9MJMllhPrmcxlSUkqhEvVgvFvZJhXOf+AR2JdPtApnegI
   V9BAQzTkXn5bgxnP8/XdXzWTYR6mnWhkxRm3pKqe67zZGtM3AKmD5j0qY
   ytyzDvyWBAIsRdZWUbBt7uhdMfbxTZL3rlmNjm7SkRwwlj/+p5aZalJVl
   bYldbxpkhPeMPMHuoq84Z4rh2ImdqCt/1lJH9H3Wz16zacaa0mpuitKTQ
   Qq2lZo46CikecpUweoa04tMyZTRqtcg6uOaGlzU5CZlskKSK56fZSdpyk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="369873445"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="369873445"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 16:32:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="683828457"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="683828457"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 15 Aug 2023 16:32:02 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 16:32:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 16:32:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 16:32:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hkm7BGEdEMKcF9sCSqZRzo5cECFSToRvMAAfN0uOg59+KnJFQYUdx8sfQuz/fzdolQrlUY94O0+m0bZOiblxyiE/MqBj2OnlpNPOFPzaBEXWh1vwZz2//YnbTUU6FCe1pMayhHVxlslMtktnca1/XSWmfbCMNg+8ir2EidyjJA+jr5LmCYXAuKDK3E5l1ttltGulR/kTUvi9EV/waSbcK87miR5z3d9g4lA8II/lNwyi6htoAdqeEeieaqrAzXnbIpLM2cG5YuH7HYSwIFO7+RQS1apX5pyrklJPVPB4eO7rIDtLrEg3Mg4ngmMQBT6IOd2xJq5eLNEH/5JkfkIhug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTX9YD3Cm/jTYvjZX6REzz0oxVxRVcGgsEBxWbjn48w=;
 b=PYZfaj+rYjT30RZoznpgQINMRdmWuoNSoeRu7DDo7weEp2wpIegkyVSCo6E6FVmY5eqPWyYmyeOjjXKoqYOQcDSrbfkEsoZ/JnyL99ulRrNdV8qX8QA4q+CYgRcT0MeH4CnxbRt8CGI+S07ch+sZl+Rn9qvcDiJYSBDCVXh9A0XXPyeCHHXQLYKD+eH7RxbY4oLn+NJhxpPfnSfafyv4MItCcN08TRUBB6bh0aOw7JG/dOTMk0U7xlLduSicaQ/8rgtGjThZGWoMIZtNQjRncfkWHVHUBr1CMYmyjsNh505SCQiB6lMnB8pGsJlDzA61zCj8FUQhNpcwnM3uXJwr2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20)
 by MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 23:31:59 +0000
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::663f:543f:a672:9ec8]) by SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::663f:543f:a672:9ec8%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 23:31:59 +0000
Message-ID: <2bfa1931-1fc6-5d6f-cba1-c7a9eb8a279a@intel.com>
Date:   Wed, 16 Aug 2023 07:30:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/3] madvise:madvise_free_pte_range(): don't use
 mapcount() against large folio for sharing check
Content-Language: en-US
To:     Daniel Gomez <da.gomez@samsung.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "vishal.moola@gmail.com" <vishal.moola@gmail.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "david@redhat.com" <david@redhat.com>,
        "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>
References: <20230808020917.2230692-1-fengwei.yin@intel.com>
 <20230808020917.2230692-4-fengwei.yin@intel.com>
 <CGME20230815132509eucas1p1b34b2852a9c4efe743c8da82867c4cc3@eucas1p1.samsung.com>
 <4jvrmdpyteny5vaqmcrctzrovap2oy2zuukybbhfqyqbbb5xmy@ufgxufss2ngw>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <4jvrmdpyteny5vaqmcrctzrovap2oy2zuukybbhfqyqbbb5xmy@ufgxufss2ngw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To SJ0PR11MB4831.namprd11.prod.outlook.com
 (2603:10b6:a03:2d2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4831:EE_|MN0PR11MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d0aebc8-6473-40d5-7d47-08db9de7d232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qi5PmaWqxMwwiljpqb/GIC/KjfEhTxLFfRIl9+iMsF84vITVSGtMYiXRuLeSmvJSwK5iKlubhcOeo/r9UlwGAraDwJ2FyAqhZJck1VgaV4fseaYC2Q88g9F4Gk3sQIPcwHCT2bHzqTfLxpuAv9bQwuZl6nX5rDVfdu9MwWLcmFTULlsdOaAzY64ZtlF07ibZIPqApgJHI5InlYAas+R76CHVL8fMnS3cfI1oVzS+b1Y2vHhwgr/wBk7dCyWGDAyVcNvD3AtDbJ26iKcq9IskHcTiFCnAPVKbDGt+PZFg2wWerY6FrH+jMtHF0fdy6kkmjF4l4xx/Z/V+dbZDPqb4N7nnbahQTYL4SVsl0U5X4EdoBiQ3oDPbYZAYRjOMOw2ymO8kIU9ANp3M/cACBhK/nbrRJ5aQQTMx1ccVy1vEP1asUdmB9V+/tv59sRRnVpIs9CxH9GRjEmmF5idSvONPeQpwnacfolmkCx45W4y9j6c/zYrnjXnPiOC6z4uzRIJu1+BA0drwkk2VrBUK1eASynDYK6jOv8bTCRHlzC44czN7nvy2eZqMKwT5Se60U5Z5k+kjC65uLr3HXhO95kA3qqmCYabmIWI0lXQFhzZgZpOjvRHUh6d3r4O9afiKZr95UOCr5czaaUF3SEnIKTEhBrYuVb3GUMlocNCOyGbY30I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4831.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199024)(186009)(1800799009)(82960400001)(8936002)(53546011)(6666004)(38100700002)(26005)(8676002)(110136005)(921005)(83380400001)(66556008)(86362001)(31686004)(2616005)(2906002)(7416002)(31696002)(6486002)(36756003)(66946007)(478600001)(41300700001)(316002)(66476007)(6512007)(5660300002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmsrbkxVbEs3QUJXa3Z6c0NUNGlOd1c0ajhNMHNXcEtXUWRPeUlNYmxTOW1o?=
 =?utf-8?B?R0pseGRxeW9NUjNMSHBGV3dUeVdKK2pjWTNBcUMzM1Y0VWUzMVViZHljTWpo?=
 =?utf-8?B?RzRmYkdJSTV4RVNBMys2THduV09LT2w5N2lnRDh6RS85Nkl2QWI0dnlRWFVr?=
 =?utf-8?B?aXlXNldOWUdTcG85djgrQzhtZ2ZmSmFTbEFyR1RTNHlNYnU4YjNBendmS1hV?=
 =?utf-8?B?cDF2dS9UZ0M0cm92NVozWlZGaUtReDhlRUQ4bWNUSE9QSkpJeWIvSWRmSDkw?=
 =?utf-8?B?YjMweHRPVDd4VUx3Nk1UdzRwSEZiRm9ReUpUNFZyWVh0a08rdEJWVzdUcld0?=
 =?utf-8?B?M0ViU0xRbWRMRE5rNy9UMUpyLzNFMEpDd3V6T004QTgxdHFTdkRRczN0MGVP?=
 =?utf-8?B?L0ZoK2JaVlB3VVQ4WjNFN0krUkVjSm5EbXJYaE55bloyQXRnbnJDR3FkQkFD?=
 =?utf-8?B?eDRvR2ZTZEJCU1RDZWovSlh3eHVnQXc3QnBueXRFYU5vcHp4VkpNOHNacmFx?=
 =?utf-8?B?R1dHMkRLL05NTnZMb3RKZFpsM20rTVJ2VWQ0NXdGdHZpaHV4OVJ0WVJkbFdw?=
 =?utf-8?B?ai96R09HYWtZZFVGSHl3WjZmZTMwdUpOR1FQaHJ1TTZudzVJd2NlQ2VkYTRE?=
 =?utf-8?B?NlN3dnhKMjN5djRZLzd4WmRncXVFQmh0MU81VUhIcDVPWlZhZWE4N3JEYjdv?=
 =?utf-8?B?QWg4MGptcXp6OGxZYmRjdkpicTF6S2hjRXd5WjVQTGhwRndwb1hwU29nUXFh?=
 =?utf-8?B?V0hqdGJDdHRwcjZIWDBrVS9KRlAzWldvNXUyUmh0dVJXS3VXaFk4T3JWSGxz?=
 =?utf-8?B?d1lxSHRHRndYMzFaQUVtZjhJcnk2bUZ3SDI5M1RqRkNpNnVsWWJxaGRtWm5i?=
 =?utf-8?B?a2ZpUXIyYVpBcUZtTElZU2o4WHNQRWRzYzhDWVFxUGhzaHI4TGxXdVlaS055?=
 =?utf-8?B?ck9kRmU3U0dlMGRIbmo0cTFXdjJhOHhQYWtheGVEVU9DVHBaeThsZ2p6amJF?=
 =?utf-8?B?NXQ4aHNTc3hPSFBrWWVEVmZ2SFdyYXJnT2l3TWZIMUlTNWtuODE0TlVGU1VN?=
 =?utf-8?B?UksxdGowZ0M2WnRWQlF1YkxzZllkWUJwOGszOU9YYXI0Wko5dHBZTjVzV2M5?=
 =?utf-8?B?THNpWmVOZWVZRldqb2xCZnBiYVhtZTN6emNSQTAxU3pFYmRQVjlyanZ5akZX?=
 =?utf-8?B?R0dYRi91dFFqV3ZxeCtZWll5OGR0UWtmUlVOWm00aWUvbkhPaVpSUVRZM3RB?=
 =?utf-8?B?NXVNbUtob3NQMFJtRmpDM2IrbmE0bnZVcHFoZGhWWS9MdURXTU5zNVlDNjBz?=
 =?utf-8?B?WmhPbDVNaHV2dlUrVC9SSlFNTHJqNE1EaktXNnZPcHRGSXhmNkZicW55aERM?=
 =?utf-8?B?MFVXdlBLYkMzcUZoZysyL1ZkblRJa3d1ZGVuSldhYU1wcmxvVnZ1TElxdVhV?=
 =?utf-8?B?OHJ4OWpvUDVmNW5RRW05RHNDL0E3a3ZVYUxqa3lBQ0FpN2NSQWlvUXZXb2Ew?=
 =?utf-8?B?RnhTVkpFWkg0eHdrZXZzOU5EN0ZibFRXNU43Vi8xdHZ0SFdOYmJDcHhlUXN2?=
 =?utf-8?B?bS81eDEvcXo5N3dXZmdLQ0JCWVVVaGJYKytabVZQYlRlYW00cFlIWnJSL0N0?=
 =?utf-8?B?L1Y1NnIvWk9sMlJnMFlkTWw3WlYzblJob1BiUVFoSVdod1hZcG5SQld1akNl?=
 =?utf-8?B?enQ0MU5XMWdiZEZsdXlNa3BwV2hIamI4TDZhZkJSZFR0VGFVU2pWYlNOQnd2?=
 =?utf-8?B?cVplemtIWThJbVNCNnYrR0Zob3lGOFhKWXAxelkyWE1rUGd3aWFheEV4Zm5T?=
 =?utf-8?B?WHhBdk94dDN5SzNMVWE5S0ZLQnNybXFJSG9LS0lEdlZudGQ2cTBEYkl5L2FN?=
 =?utf-8?B?VlNSK2tlTG5TR1ppSmVZUkZKbk96U3g5alE0S1JXcDJqcElCcnNrZnFseGpS?=
 =?utf-8?B?TW9PcTV0WFAzQUxuWnN6eWhXZG1UVlh1Z25wUDlsYnpOVkY3anpka211WDBK?=
 =?utf-8?B?bmlvMTlkUGMrc25vRFMzdzBHeFV1MUIrb1lJenNKb2hvbGJUOThFcHRQaUxu?=
 =?utf-8?B?cTZnVVloZ0JlMmtQMzlHTkhQdEh4MDR5SFcyR25nK1EvR2Z6YTYxU21KWXoy?=
 =?utf-8?B?SndhSE1nekJVSzJKQmtSZWVURlRRSEU1cHNQVE9qRWp4UlUrUGcwNkpSQzhp?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0aebc8-6473-40d5-7d47-08db9de7d232
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4831.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 23:31:59.5694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kbc+gXdL4yIrFFEtKnEK5VvUm5dffwHEMAvxRwZjYjkV4dFG9UHGt4vRHdNn97+C+pfCCA4e7cI3NDx3n22P0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6059
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/23 21:25, Daniel Gomez wrote:
> Hi Yin,
> On Tue, Aug 08, 2023 at 10:09:17AM +0800, Yin Fengwei wrote:
>> Commit 98b211d6415f ("madvise: convert madvise_free_pte_range() to use a
>> folio") replaced the page_mapcount() with folio_mapcount() to check
>> whether the folio is shared by other mapping.
>>
>> It's not correct for large folios. folio_mapcount() returns the total
>> mapcount of large folio which is not suitable to detect whether the folio
>> is shared.
>>
>> Use folio_estimated_sharers() which returns a estimated number of shares.
>> That means it's not 100% correct. It should be OK for madvise case here.
> 
> I'm trying to understand why it should be ok for madvise this change, so
> I hope it's okay to ask you few questions.
> 
> folio_mapcount() calculates the total maps for all the subpages of a
> folio. However, the folio_estimated_sharers does it only for the first
> subpage making it not true for large folios. Then, wouldn't this change
> drop support for large folios?
I saw David explained this very well in another mail.

> 
> Seems like folio_entire_mapcount() is not accurate either because of it
> does not inclue PTE-mapped sub-pages which I think we need here. Hence,
> the folio_mapcount(). Could this be something missing in the test side?
> 
> I tried to replicate the setup with CONFIG_TRANSPARENT_HUGEPAGE but
> seems like I'm not able to do it:
> 
> ./cow
> # [INFO] detected THP size: 2048 KiB
> # [INFO] detected hugetlb size: 2048 KiB
> # [INFO] detected hugetlb size: 1048576 KiB
> # [INFO] huge zeropage is enabled
> TAP version 13
> 1..166
> # [INFO] Anonymous memory tests in private mappings
> # [RUN] Basic COW after fork() ... with base page
> not ok 1 MADV_NOHUGEPAGE failed
> # [RUN] Basic COW after fork() ... with swapped out base page
> not ok 2 MADV_NOHUGEPAGE failed
> # [RUN] Basic COW after fork() ... with THP
> not ok 3 MADV_HUGEPAGE failed
> # [RUN] Basic COW after fork() ... with swapped-out THP
> not ok 4 MADV_HUGEPAGE failed
> # [RUN] Basic COW after fork() ... with PTE-mapped THP
> not ok 5 MADV_HUGEPAGE failed
> # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
> not ok 6 MADV_HUGEPAGE failed
> ...
Can you post the MADV_PAGEOUT and PTE-mapped THP related testing result?
And I suppose swap need be enabled also for the testing.


Regards
Yin, Fengwei

> 
> 
> Daniel
>>
>> User-visible effects is that the THP is skipped when user call madvise.
>> But the correct behavior is THP should be split and processed then.
>>
>> NOTE: this change is a temporary fix to reduce the user-visible effects
>> before the long term fix from David is ready.
>>
>> Fixes: 98b211d6415f ("madvise: convert madvise_free_pte_range() to use a folio")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>> Reviewed-by: Yu Zhao <yuzhao@google.com>
>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  mm/madvise.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/madvise.c b/mm/madvise.c
>> index 49af35e2d99a..4dded5d27e7e 100644
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -683,7 +683,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>>  		if (folio_test_large(folio)) {
>>  			int err;
>>
>> -			if (folio_mapcount(folio) != 1)
>> +			if (folio_estimated_sharers(folio) != 1)
>>  				break;
>>  			if (!folio_trylock(folio))
>>  				break;
>> --
>> 2.39.2
>>
