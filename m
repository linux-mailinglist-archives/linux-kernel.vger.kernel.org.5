Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7163177848C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 02:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjHKAgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 20:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHKAgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 20:36:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9777E26AB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691714192; x=1723250192;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aBIm30MbI6WXkTfvAhbg+fZCessQiDtEMEAuZ+nEXUI=;
  b=bcdwvHw/POe1T8VqYgJG8+bp7jSW1iIOAKZTMx7JJmrdrPRoRiaCk6Sg
   fUiUhl3M4izooaBFSp7ANtEchbztdGv0gLv53iBsFk/MIDpi6N25f17Af
   Vkb9LiEX6nTPAe+qfddsNlvlvmrs+SAjgCxXRSV7IlUBm7rbeCJQEbOH4
   3aauSIPhV88C43Fb/f7bLy607EXDxtqgzAf4V1ZhYADDPxzwfoVXSVwW6
   04YUeUOySaTzvbEQDF78b2nvXV/n+yRGEIqiJulPj0PFoOhXPMgl3Zyq6
   l2kui2JTnvtprNYp5QbreoO/uvN0R4X16zhHdYdkXhfxnb5mxh+PlnXN0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="351165863"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="351165863"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 17:36:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="682337792"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="682337792"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 10 Aug 2023 17:36:30 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 17:36:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 17:36:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 17:36:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiRNQ+xjq9STjnhGwC0eiyr01EDFe3UadIVsg8/GNv161uM/hhmWP/WrnRwT/u/eSA6kuh0y/dFfL833dhFW3XcwL+8qqeybiuu7+Z4fJGccD/SPOA8ct4utlMgT2TKMkK56GGqZqMPZqhm4ajt5OE1ZMC07YATjPV5XIM0AADmOjVwC6coFJQ2TrcsiDUyWTNZRgV7jirVkby5cXnggzC4MECqTpg6ofwbrGWQGkw/4n6pNxQz6zNNQWil3EzZ7praQc9IATz4VbveAJRtovVrLnr5GZQzyFnt96kMRBhMIhNv6Yk+tuMLnpeMHQqqEAMUf/3ETeiUT0HfHhxlyLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LY5KV7ziH5BmMFg/Kdgu9lz3xosfmDLbwuZVbJDxi80=;
 b=LAigyFRYaDYRx2n7rvFIGwXVDmN1S5HZ/7e8sZvYjXYgbyIgv3rOCOqFIKjuNviv93ZL0RvkO70RjwROCatMpmPYYIaJ5PolFeBe2C84mdHSAncsvlLEAN9BE9VdnlXjmrxPpprhq62e4kfQSAl+mqEnjyn3Z53WJ9Tr+sidfeFLlpBjUda3NzXqe8DWzjUiwYmE0qGjNxZdodVvZEgd9PcUa+J8QOMvn1SdS1iChk7afr0yTxsvGQZC2VtrZahlKEzK7pc+y7Z+S6EAvLYZRJyOpz9bb0RWaohi9q3mALHYxsq05VSO5kb0hxTJ8jmyH2zWyz4Z89aw11P/tFZ7vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by BN9PR11MB5323.namprd11.prod.outlook.com (2603:10b6:408:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 00:36:22 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 00:36:22 +0000
Message-ID: <627c9081-68f6-49df-a270-1a5e47741d31@intel.com>
Date:   Fri, 11 Aug 2023 08:36:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] mm: LARGE_ANON_FOLIO for improved performance
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>
CC:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230810142942.3169679-1-ryan.roberts@arm.com>
 <20230810142942.3169679-4-ryan.roberts@arm.com>
 <CAOUHufbUGwc2XvZOBmTCzMsOHxP-eLB60EdysKYzrkRMScOyMg@mail.gmail.com>
 <f97446e3-85d8-4d14-9fc0-683b31925325@arm.com>
 <16B84D1E-F234-414E-BA54-5893B6318E57@nvidia.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <16B84D1E-F234-414E-BA54-5893B6318E57@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|BN9PR11MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: a9171122-6a2e-47d9-3c42-08db9a02fc8e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LmR3vHauikZdULLeSIglv+/++9WihDMBlc+ixqix32nmThSVcuKR+7K1KclSD2vp6II0uVxMDrxuRzPiDtxccTG2SF/Baxyh/1K6MAmW4Pl/2hRMgVv8IVyBx2Shksu1Bw14+GmUQkd8miNWIZpxtsl5Yr5PBmW9Jr8k+27Cdp0JSLZIgU4P8VkIxnOMSkAI+umHFyCukGG91bYpnwma+Wyxmi5NbcqiP3GDiq6+/pEaLQb3eeXwm998+d5uCqj0ORx7AvioR8fZeQHuWvGlTjcAhS+ye423QWYaU44l0x9q7wXeoEN6YKHYUFPRpQ4ZZSMvnBMkTMb8rHQIVRs/kfzef8FTJsgKb1zF6nS80nJzaur5LX/eMIy4EPdT8RFlT/nOLrYOOn6PlqC/6HP39u7DvkEVTZOmK4kuXe7Nlj9h8dST1eGL6fsha1eimXmDOY8BddAsF0t55RpjtzK12lTOzRyBMjr9i5iIzSLxF6/yRrNwmwmUwmtao4gpvtmSErxRL437+hczZhLj3vLrWBloqxf088TYPX+5ZXGx2xrTjIfPG1WR4CesGFC1WQ3iSinwB6QmrJ0Qi9m2QKZkHhD/FvJyAQ8T+pTmRy0tXWrLcIOYUuAQdFlPt0pAeF9iy2TVHPH1IvewLpIoX7efCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(1800799006)(186006)(36756003)(54906003)(66556008)(6666004)(110136005)(478600001)(53546011)(66476007)(6506007)(66946007)(26005)(6512007)(6486002)(966005)(2906002)(4326008)(7416002)(30864003)(316002)(8676002)(5660300002)(38100700002)(82960400001)(8936002)(86362001)(83380400001)(2616005)(41300700001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWNyZEJHS2JYYzB1ekU4VERiQi83NGpZMHB3ZWFiWkFEK3JaRWJJVklXT291?=
 =?utf-8?B?cmEreForK1MzQW96ZUJQcEtSUUE0aUZmUERZVnVJOGZHT0x3U0dTYUVHZ3Mr?=
 =?utf-8?B?Tzl4QmRremU1OFk2Y1ZZTlVaRWRrQko1NVhzMHdDVlk3eVBzMWlabmFYc2NF?=
 =?utf-8?B?SjgyRDJUR0N6NUwwSFp3OGdZVjJMamFkWXJlSm5sTDQzMDZndXJ2aUwzUzV5?=
 =?utf-8?B?bWFRM3l0L2ZQNE5DdDVWNmdhWHJRYmxPam5Ka0lQNWMrQ2gzVk43ZTJuazBs?=
 =?utf-8?B?Z080Y0x1MmJFVU9JNjZKS3IvdVZaOSsrOVNoekw3ZVhEZkhUb1hCaHNFNWVE?=
 =?utf-8?B?ZmtlZDlOWG9ON3VKckd1aktPVkd3cE9lS3BJUUNEY2R2eHBIUEdkOVkzYkFa?=
 =?utf-8?B?K1BOcHZ0TmhEZFhTTnlZa0JnSTR3TkZ2UktlSlgvcVd2MENNU2s4TkF6eU80?=
 =?utf-8?B?aHh1OFJTeHpsRmQxTCtCWnRIKzdmRTZkVDZseG9KdUZWUWVacXBVMldrcDFj?=
 =?utf-8?B?TEY2T2E4Z1pZTWtEVVV3Vlk5dThsOEVlamo3ZTlReWlFVjZ2bkUrSCthaWtW?=
 =?utf-8?B?TUxZY0NQM3NzU3lBNkZTM1VEWmFTb09hRlBjcG9NVmZtQjM5aGo5Y0JIZzFa?=
 =?utf-8?B?VUQzUTB5L1hZY2ZvWmpVQlFEU1R3T2hKVTNOalYyQnI4cnVOcVEvRW94K1lN?=
 =?utf-8?B?NjlHZDlTN0pFVGlhWG5QQ3FKbit4d24xaGszU0p6ZzJoVkVoZnE2K0xObU1q?=
 =?utf-8?B?Wkg2V1p6MnRPa1UwTVhpU0pmRmE5WWZLNDQ2OVdRUXByMTd4K2FWMktmc1Mz?=
 =?utf-8?B?K2NwWFdyZ0UvRDhqcjJhQlFRc2tDRGQ4cDViWmlSclo5Nys0Rm5GRGZLSW52?=
 =?utf-8?B?OExTNmlsSThwRW0reW5pczd2SnlGb3BxeXJOcURkWkFSM25vYm1GNk5RWEN1?=
 =?utf-8?B?d2xlNnFScDExcjVPdGh1SjhwUGYxZE9yZTlNY2ZUemxIMEQvTFJmUldNK3lO?=
 =?utf-8?B?Ylh5UGRFcXBacHBRak9hSGx6U0c1N3lqMk9mK2hKZ2FqOGdndzIyVWZPYXdm?=
 =?utf-8?B?TlpxaitMSXE3RUl6eklqUlJDbWZOMTBhTXI3bEcvdHhEb3BCbTByVXZJQ0RS?=
 =?utf-8?B?bFdXdm5YUzZRSXdXYXVGMHVPUmwxNU1mL1hvMkUrQlRpSWRWeWQrbGRqNVd6?=
 =?utf-8?B?bVZFSTR3Mmh3OS9rR1NseHhORVFNZDB5dDdqcHVOY0FTTzErR1NhaFZ6bks2?=
 =?utf-8?B?UWR5Qk1uZmMyRDF4QzdLUUdiYTJKa0RRZUpVUlRKNHI4SzUwRTc5aTVLeXJt?=
 =?utf-8?B?WCtNZ004TXFGY1hKTG85WGlVaVJjTFREcHlSQ25ETVkydVJtMDFLb0ZkRm1S?=
 =?utf-8?B?UElaeDk2cjI2NjRmcWc1RVR3eFhJcUFyT05GcnlZeFlCQzUrTUZzSWNxd2t6?=
 =?utf-8?B?T2YwSWJQaGdZMzdhcTZhNWYzM0FtN0ZqeXgrMVJDQWQ3OTRzWTc5SlBPSWpo?=
 =?utf-8?B?UkhyOFB5NlJZMWYwdG82S0pWdXAwUGc3NlMvZGFOSWllNldOS2J6VlVpd2RR?=
 =?utf-8?B?MElsL1RiNnI3a2lTbFlIZ002ZElzeExZeUhMMUtSZS82VWpXdHRTaThmbDd5?=
 =?utf-8?B?U2llbjY1MVFDNHBEem5qTUNuaWU5WE9ZcXU3RE9YbVhaU2REU0xLM3YrRzBP?=
 =?utf-8?B?MXRzUk92VlZYVzRZdHBMTm9LemFodnRqTHBqeVFsdVJMaWNoUU9MQmxnVC9i?=
 =?utf-8?B?SlFVa1hPSDN0VjQyTisxclEvN0hoTitJam0xSWk0YmhJT2Y5OHEvMUdCTzlM?=
 =?utf-8?B?Ky84WVVsUUdBMElmQjRjamZISnNWbmlQN0h3Rm9PYU1NQ1YyMjVhZTJObUJX?=
 =?utf-8?B?VG9xRlg3ODdwTk1aNW1hUTg3MjluUEovT0dXUXYvU0VpZEdFanZCZElLQmFB?=
 =?utf-8?B?N0pwcmxSdG1xVzhlcWRjbVV4ekJLZ21NbUwvR1gyY29IalpBSUptZGdRYnRG?=
 =?utf-8?B?dzUwM2R5M1N1YmI3OTZaVlovd0JRRWFMb25uWDNhMm1ieFFaRXUxaDBnVWRT?=
 =?utf-8?B?UE9TVW1RZHNwTlFERTQ4QXlNTzV1UjRkUzZxOEFyNHRSdlV5NEVCQWd1S0or?=
 =?utf-8?B?RUN2UEVLRGt4eEt3K2JkblVxbVZYT21QYm5rMzRKVVh3TURDcDZiTHdtaVdT?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9171122-6a2e-47d9-3c42-08db9a02fc8e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 00:36:22.3984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQsR+hV+ESBw12q3dLiMX+oDH4AhHw+M5YOwxU1fnObabZnuOa1GMBju/5CU66Mtc8BFFKjAP8raQAoU/R7BXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5323
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



On 8/11/2023 3:46 AM, Zi Yan wrote:
> On 10 Aug 2023, at 15:12, Ryan Roberts wrote:
> 
>> On 10/08/2023 18:01, Yu Zhao wrote:
>>> On Thu, Aug 10, 2023 at 8:30 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
>>>> allocated in large folios of a determined order. All pages of the large
>>>> folio are pte-mapped during the same page fault, significantly reducing
>>>> the number of page faults. The number of per-page operations (e.g. ref
>>>> counting, rmap management lru list management) are also significantly
>>>> reduced since those ops now become per-folio.
>>>>
>>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
>>>> which defaults to disabled for now; The long term aim is for this to
>>>> defaut to enabled, but there are some risks around internal
>>>> fragmentation that need to be better understood first.
>>>>
>>>> Large anonymous folio (LAF) allocation is integrated with the existing
>>>> (PMD-order) THP and single (S) page allocation according to this policy,
>>>> where fallback (>) is performed for various reasons, such as the
>>>> proposed folio order not fitting within the bounds of the VMA, etc:
>>>>
>>>>                 | prctl=dis | prctl=ena   | prctl=ena     | prctl=ena
>>>>                 | sysfs=X   | sysfs=never | sysfs=madvise | sysfs=always
>>>> ----------------|-----------|-------------|---------------|-------------
>>>> no hint         | S         | LAF>S       | LAF>S         | THP>LAF>S
>>>> MADV_HUGEPAGE   | S         | LAF>S       | THP>LAF>S     | THP>LAF>S
>>>> MADV_NOHUGEPAGE | S         | S           | S             | S
>>>>
>>>> This approach ensures that we don't violate existing hints to only
>>>> allocate single pages - this is required for QEMU's VM live migration
>>>> implementation to work correctly - while allowing us to use LAF
>>>> independently of THP (when sysfs=never). This makes wide scale
>>>> performance characterization simpler, while avoiding exposing any new
>>>> ABI to user space.
>>>>
>>>> When using LAF for allocation, the folio order is determined as follows:
>>>> The return value of arch_wants_pte_order() is used. For vmas that have
>>>> not explicitly opted-in to use transparent hugepages (e.g. where
>>>> sysfs=madvise and the vma does not have MADV_HUGEPAGE or sysfs=never),
>>>> then arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever
>>>> is bigger). This allows for a performance boost without requiring any
>>>> explicit opt-in from the workload while limitting internal
>>>> fragmentation.
>>>>
>>>> If the preferred order can't be used (e.g. because the folio would
>>>> breach the bounds of the vma, or because ptes in the region are already
>>>> mapped) then we fall back to a suitable lower order; first
>>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>>>
>>>> arch_wants_pte_order() can be overridden by the architecture if desired.
>>>> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
>>>> set of ptes map physically contigious, naturally aligned memory, so this
>>>> mechanism allows the architecture to optimize as required.
>>>>
>>>> Here we add the default implementation of arch_wants_pte_order(), used
>>>> when the architecture does not define it, which returns -1, implying
>>>> that the HW has no preference. In this case, mm will choose it's own
>>>> default order.
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>  include/linux/pgtable.h |  13 ++++
>>>>  mm/Kconfig              |  10 +++
>>>>  mm/memory.c             | 144 +++++++++++++++++++++++++++++++++++++---
>>>>  3 files changed, 158 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>> index 222a33b9600d..4b488cc66ddc 100644
>>>> --- a/include/linux/pgtable.h
>>>> +++ b/include/linux/pgtable.h
>>>> @@ -369,6 +369,19 @@ static inline bool arch_has_hw_pte_young(void)
>>>>  }
>>>>  #endif
>>>>
>>>> +#ifndef arch_wants_pte_order
>>>> +/*
>>>> + * Returns preferred folio order for pte-mapped memory. Must be in range [0,
>>>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires large folios
>>>> + * to be at least order-2. Negative value implies that the HW has no preference
>>>> + * and mm will choose it's own default order.
>>>> + */
>>>> +static inline int arch_wants_pte_order(void)
>>>> +{
>>>> +       return -1;
>>>> +}
>>>> +#endif
>>>> +
>>>>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>>>>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>>>                                        unsigned long address,
>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>> index 721dc88423c7..a1e28b8ddc24 100644
>>>> --- a/mm/Kconfig
>>>> +++ b/mm/Kconfig
>>>> @@ -1243,4 +1243,14 @@ config LOCK_MM_AND_FIND_VMA
>>>>
>>>>  source "mm/damon/Kconfig"
>>>>
>>>> +config LARGE_ANON_FOLIO
>>>> +       bool "Allocate large folios for anonymous memory"
>>>> +       depends on TRANSPARENT_HUGEPAGE
>>>> +       default n
>>>> +       help
>>>> +         Use large (bigger than order-0) folios to back anonymous memory where
>>>> +         possible, even for pte-mapped memory. This reduces the number of page
>>>> +         faults, as well as other per-page overheads to improve performance for
>>>> +         many workloads.
>>>> +
>>>>  endmenu
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index d003076b218d..bbc7d4ce84f7 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -4073,6 +4073,123 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>         return ret;
>>>>  }
>>>>
>>>> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages)
>>>> +{
>>>> +       int i;
>>>> +
>>>> +       if (nr_pages == 1)
>>>> +               return vmf_pte_changed(vmf);
>>>> +
>>>> +       for (i = 0; i < nr_pages; i++) {
>>>> +               if (!pte_none(ptep_get_lockless(vmf->pte + i)))
>>>> +                       return true;
>>>> +       }
>>>> +
>>>> +       return false;
>>>> +}
>>>> +
>>>> +#ifdef CONFIG_LARGE_ANON_FOLIO
>>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
>>>> +               (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_SHIFT)
>>>> +
>>>> +static int anon_folio_order(struct vm_area_struct *vma)
>>>> +{
>>>> +       int order;
>>>> +
>>>> +       /*
>>>> +        * If the vma is eligible for thp, allocate a large folio of the size
>>>> +        * preferred by the arch. Or if the arch requested a very small size or
>>>> +        * didn't request a size, then use PAGE_ALLOC_COSTLY_ORDER, which still
>>>> +        * meets the arch's requirements but means we still take advantage of SW
>>>> +        * optimizations (e.g. fewer page faults).
>>>> +        *
>>>> +        * If the vma isn't eligible for thp, take the arch-preferred size and
>>>> +        * limit it to ANON_FOLIO_MAX_ORDER_UNHINTED. This ensures workloads
>>>> +        * that have not explicitly opted-in take benefit while capping the
>>>> +        * potential for internal fragmentation.
>>>> +        */
>>>> +
>>>> +       order = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
>>>> +
>>>> +       if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
>>>> +               order = min(order, ANON_FOLIO_MAX_ORDER_UNHINTED);
>>>> +
>>>> +       return order;
>>>> +}
>>>
>>> I don't understand why we still want to keep ANON_FOLIO_MAX_ORDER_UNHINTED.
>>> 1. It's not used, since no archs at the moment implement
>>> arch_wants_pte_order() that returns >64KB.
>>> 2. As far as I know, there is no plan for any arch to do so.
>>
>> My rationale is that arm64 is planning to use this for contpte mapping 2MB
>> blocks for 16K and 64K kernels. But I think we will all agree that allowing 2MB
>> blocks without the proper THP hinting is a bad plan.
>>
>> As I see it, arches could add their own arch_wants_pte_order() at any time, and
>> just because the HW has a preference, doesn't mean the SW shouldn't get a say.
>> Its a negotiation between HW and SW for the LAF order, embodied in this policy.
>>
>>> 3. Again, it seems to me the rationale behind
>>> ANON_FOLIO_MAX_ORDER_UNHINTED isn't convincing at all.
>>>
>>> Can we introduce ANON_FOLIO_MAX_ORDER_UNHINTED  if/when needed please?
>>>
>>> Also you made arch_wants_pte_order() return -1, and I acknowledged [1]:
>>>   Thanks: -1 actually is better than 0 (what I suggested) for the
>>>   obvious reason.
>>>
>>> I thought we were on the same page, i.e., the "obvious reason" is that
>>> h/w might prefer 0. But here you are not respecting 0. But then why
>>> -1?
>>
>> I agree that the "obvious reason" is that HW might prefer order-0. But the
>> performance wins don't come solely from the HW. Batching up page faults is a big
>> win for SW even if the HW doesn't benefit. So I think it is important that a HW
>> preference of order-0 is possible to express through this API. But that doesn't
>> mean that we don't listen to SW's preferences either.
>>
>> I would really rather leave it in; As I've mentioned in the past, we have a
>> partner who is actively keen to take advantage of 2MB blocks with 64K kernel and
>> this is the mechanism that means we don't dole out those 2MB blocks unless
>> explicitly opted-in.
>>
>> I'm going to be out on holiday for a couple of weeks, so we might have to wait
>> until I'm back to conclude on this, if you still take issue with the justification.
> 
> From my understanding (correct me if I am wrong), Yu seems to want order-0 to be
> the default order even if LAF is enabled. But that does not make sense to me, since
> if LAF is configured to be enabled (it is disabled by default now), user (and distros)
> must think LAF is giving benefit. Otherwise, they will just disable LAF at compilation
> time or by using prctl. Enabling LAF and using order-0 as the default order makes
> most of LAF code not used.
For the device with limited memory size and it still wants LAF enabled for some specific
memory ranges, it's possible the LAF is enabled, order-0 as default order and use madvise
to enable LAF for specific memory ranges.

So my understanding is it's possible case. But it's another configuration thing and not
necessary to be finalized now.


Regards
Yin, Fengwei

> 
> Also arch_wants_pte_order() might need a better name like
> arch_wants_large_folio_order(). Since current name sounds like the specified order
> is wanted by HW in a general setting, but it is not. It is an order HW wants
> when LAF is enabled. That might cause some confusion.
> 
>>>
>>> [1] https://lore.kernel.org/linux-mm/CAOUHufZ7HJZW8Srwatyudf=FbwTGQtyq4DyL2SHwSg37N_Bo_A@mail.gmail.com/
> 
> 
> --
> Best Regards,
> Yan, Zi
