Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F8F77DD3D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243305AbjHPJZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243353AbjHPJZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:25:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2348926A1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692177934; x=1723713934;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W3wmUH0NKqDQNbK7RlDlLjX2r/kOQpte+vCNJ9q92Bc=;
  b=h7HFbjMljZ/hm1+ApKuutPXTTqKYfbz0S0JpYQy5NUjb2E0gn11Q1vFb
   OMCifpB94wGZUgLtbktMtZoY6W6L7XDQa1ie7KGRywmgQ0NWSJJcE7JJP
   bWCpAXjLz9qj4J9T2e/oOmAqg2D0TFOpHJ8QHESA5uwaLQp5Z2qr8vW3s
   0m7QZMaFfbzlDRQGqoe1A//i0MxFLdMrPsZMBf71rd24DWGFecs7KA8xm
   dU3lSQrJvZ/WQux41/B+kZ+8WP8MuklemHTK3bK/GymaflHNgTiwFKnyi
   vyuD75K0EMf87tDAT1/W6/R3N6j/h/LXpnkfp0F9fe7RbfvIioERLiMMX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="372487108"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="372487108"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 02:25:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="877717514"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 16 Aug 2023 02:25:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 02:25:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 02:25:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 02:25:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVJnIo1g1cld5G4rJk/VIWYMll9eA6KHFXw+D0WM6xwEee3UGyCOMQZe0fTfD4NlM2LQYPIBTVaw2PjXsBVLvv/F5bfAj4fyHTgXzuNGtSzR1JgxnHP3SjzLSE9/n9CiF1Kh1rFm00x+T+bo8uGKnYoOcfsE34a9D+c1vJkWAupOLqTP40IoLB60tRpD+dylGRa2AX43XhLYA7cuvAvjW0Z8ll8DzQYogVU+ICD+cjJ3+V5bm/UpH3CGVNaMdqHrxzR5/6WJjIIlqP/9Z2pIUksJcvTRzru7p2mQKNElrk+6Hj50kaS8ROD6KWTsvvQd7sgUOwNCPXoOMUv8RzUMNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OM8k344FoDUAv3ObVmX/drB9MzX/BS01vbT9Wj4QXs=;
 b=VUwnZdS2IKeuVUozn/0bRlwL+CzYVh1KMy6FAQViCP+NjT015e6yGI4gS0a8ixKMBbO9BRZo+H8jhDiiD6JvZwp8KcAGUjPsGnavdxx61fNTxPglKyyoIKjA3g7UaqVB0KsGbwPrbKbXquHnP4ecR8eJNB5ldSXMv9meWKsJAYS+7cxnDHEqviE8SCWMrAPVCKeXVukBXPHYcpUBsVhid+A9ES8ab1Q1DxFD86zJfiLRomQq2N//r74MuT4s54x0D/ur2zk7FiFhi9ghrMMCiRvcBlK6194Zo4+VJEDSWpNwC3G+0zMqqHYyQDMpxpFUKiN0ZMiSuKXltiCcdH61xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS7PR11MB5991.namprd11.prod.outlook.com (2603:10b6:8:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Wed, 16 Aug
 2023 09:25:31 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 09:25:30 +0000
Message-ID: <3a0ada31-0ec5-4a7a-ab9d-d59c3684b662@intel.com>
Date:   Wed, 16 Aug 2023 17:25:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] variable-order, large folios for anonymous memory
Content-Language: en-US
To:     Itaru Kitayama <itaru.kitayama@gmail.com>,
        Ryan Roberts <ryan.roberts@arm.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230810142942.3169679-1-ryan.roberts@arm.com>
 <EFC00B0B-CB45-40F0-A55E-0F110961A5B9@gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <EFC00B0B-CB45-40F0-A55E-0F110961A5B9@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS7PR11MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e2bbed8-d646-4e47-9122-08db9e3abbf8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xMd2LbbrZM3fW1tfGIw8nQ6kzkwjtmptWPOBsi4p3Ged5V+B8Qs5Cs6a9xBpazFiv2h+4C5ICr8yFntpyAqx0KrmVLil7e/oCNuG05X6zzYbeREYvjhF5rxNKXUi56A4C/tQ9rUx0rj4fcOjT29yStkE/YPUsOLsbJJzQVcemOd0CFGPiPDHuo2ilsRw4r8RTME9+2lQZ1VMRGDsL5A3w/IpsWE0yekP+NMJKvSCP3S7Ez0RQZA5vV8B0PfpNJf5vJJsirAGS0bx0Jivf2jHgIgdyuVBF574wYBNCA08r/W1ySxj4KtLefQjr51Vofi0yOivsOyvcoqQ45tJ7DMl8URr91jo1SFttldrLjJCYNIYwP0LSnhJpr6CGW0Rb9tXFuDEBghOXA8MjNQuZAw6hZ/lweqeYkmpaGZkEcxVPb8q207uc8ZwzaDm9wRyHU7TfS3SabIIeeE/ki3cogn4hMHkUPVgSsb0yVdcn1iRX9ZDAZdOaSBk/xsb92+0H/8BQ9nCte7y6FuGXsZrqZo7+3t1uSsuYPXmEcI3AwqNlp5xr0lbPKaevGzUpROFUNj/4iRFpmikH2etYJ/RzPjtHaZpsLK6vDiAsAqr0DF0MjJ6OjTmVDIRYR8Oze3m1tTPNQnjhbCW4xks97czIOK1H3+qhqUeNDLcZnG30QcBdGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(1800799009)(451199024)(186009)(6666004)(54906003)(31686004)(66476007)(66556008)(66946007)(6512007)(6486002)(6506007)(2906002)(478600001)(966005)(26005)(110136005)(7416002)(5660300002)(2616005)(83380400001)(41300700001)(316002)(53546011)(8936002)(4326008)(8676002)(66899024)(38100700002)(82960400001)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFFwZHk2bWtpRkNCNW84VnVCdVQ2NnBIUHFVZ3oxbWxNRFJkVVpldEE5S2NT?=
 =?utf-8?B?TDVpMXZmRVZTL3ZuS1hZZm5NR2YzMW1EV0xKUFUxT0J3N2RUVEFkLzc2b2pJ?=
 =?utf-8?B?SzhsYkxJeHU4QkdsSW9sSmFoejhiYzNzY214M3ZnUStZWXZ1WnBSMlU5cHNF?=
 =?utf-8?B?amxNK2FFK0I4dUR3OVl4OVorYlRnb0FNUHF3VGs1L2RQNi84OVVsanpISHdr?=
 =?utf-8?B?YXZRdUdFdkdlcmRsZENBaDZOWEtkckExdE5VTzcyNmk3S1pydG14RDdKZHFQ?=
 =?utf-8?B?Qjk4QnJIWGNTcTNOSTRBbVRPVjlhaDE4Slh0MC9nTHoxV3VPZmJJY0tndzRS?=
 =?utf-8?B?bjBIZjNyQUUrdkRzYjhqYjR6QXp0UEVHSzBaZVh2L3U1VVM1RWowOFFHTFZk?=
 =?utf-8?B?bVJubHZuc2M0clBKZTd6L2lNMSt3ZWlZOFNwR2MzZVdzb0JrYjliSVVOckJ2?=
 =?utf-8?B?cnRna0Z6WEJDR1BoTXNaTEx1bk1ZZWI2My9QUUsxS2JDdnhpS3k1SjMxT1Fx?=
 =?utf-8?B?b3Rjd1J3RTM2ZW9tVW9XaThxQjlVR3AvdnJsNk9SZUdmK0M0YlVTL3IrTzhG?=
 =?utf-8?B?Qy91WFVmaUxFSXdtNWlUS1RnbGhtV2pVeWNySlVCZlYxZE5iL294bFdrcDA0?=
 =?utf-8?B?dnRyU05xU09hWTVIUGk2L2RlZFl5djVvYkppelROTUovZG5jM0E2NW1XeE1v?=
 =?utf-8?B?WERpUFFuKzhieXdxTVltUWNuejBZRGIrSTNOUzQ0eXBUa1dqYUhqMTZVQ28r?=
 =?utf-8?B?b2FvbjZhdGlyWDMvZ29uSTFRUE1JSzluS0NOWkVjeW9ZNk1PRXRkemZoUGFz?=
 =?utf-8?B?aElFZFIySjVDL1U1RFBrRG1FOFpieFhXYWpDeHBKVytDTGlEM2NQVjVDZnNv?=
 =?utf-8?B?a2FHeG9neXdtYlZ0MnNWT0tOejlDSWY4eENlZlREOWJaK2c1bGZzeVpXWEtl?=
 =?utf-8?B?c3FxWmxhTUUwVUJ6WUZNUVhsaVNYR3VYYlo1emhxdmc0NjZ2S3MvUmttMnpJ?=
 =?utf-8?B?RXdZb2NPOVI3RS9tUDBJYzRSR05EeFRnNS94ay83STBUc2VGNURaNDNNY2JV?=
 =?utf-8?B?UDZnUkZsUTlvRktRR1lsZ1R0UkpaYmtMVGdqZnRHc0JmMjk5VGZxWnRKS3Vk?=
 =?utf-8?B?dkV6a2txUlhrUTNPNjh4R00yVzZPK25XbEV5ejhoZ1NuT21KUWhzaWlWRzND?=
 =?utf-8?B?ZS9weUdLRTBZcStlSW5CU2ZJTklwYW1FYkkySGVVcVI1a0x0akdRVTRiTmwy?=
 =?utf-8?B?RXJSWWdOeWhkMk9VaEJqUzRCTGRxWlU3UnBEQ2pSYVg1QWZqdkozWlBXTHZ2?=
 =?utf-8?B?Q1hySEpBNUZ2YW5Pc1hmbE9HMEc1M25Wem13Mmx2VlNXRVk3MWxzVUFrR0tH?=
 =?utf-8?B?VVBVNnExU1ZDYlN0ZU1MeEI5NnlSTi9iNml3TDZwUGV4Q1F1R1VjdVlQYURl?=
 =?utf-8?B?dEg5SFhoS1hEZHMrSXczdDNSWWtDRUVSamRYZGlSNUtMakJKZXFVbmtoL1ho?=
 =?utf-8?B?Q0d2elVOOXAyQlhLOTZLUkNKQ1VXMGxHOEFqd0JRQzdDcXNudnBIQklDQito?=
 =?utf-8?B?bWxzTnVJTlRRRVdsMzdwLy9Ec28wVnBXd1NqTktyWGw4Z0tENTcyTkZKaWZH?=
 =?utf-8?B?bUdrWjJoL2Q2TXpUM2ltMFlJSlJaYzM0aW9pR2hqYXhuc0dqYVltNHRRYWhS?=
 =?utf-8?B?OC9hcUhkOVVTdVpMZjE5SlhRYzlseUZiZE0vN05EZFRrRUpIM1JSa0k4bFI3?=
 =?utf-8?B?UFc2RXJxMUJadUs4MFJJNk83SXRzd0NTSUVRc0twZ3pza1RVTjFUTEovaXoz?=
 =?utf-8?B?L0lpbnJBem1VeldjdTE0Z1didDhuZW53RVM3OWYrSHY3ZjJEaDZDQU5GNkFx?=
 =?utf-8?B?MzVIRkRpZDYrKzVZNHJSVWh4VUhOa0hRZ2JEdGl5d1BsbmNMd1RzMU1hWWUx?=
 =?utf-8?B?aEFzQWNaUWRkcTRoUFNiRnpEbEoxTUlvZVNncVBlK0FyVldqdlV6dmFjVFRz?=
 =?utf-8?B?K3ZxWXlsdlV2R1ByMzVwVFpLajJ5RzBGdWZ6V29aRk10Z0V0UUxJZ2pSRktB?=
 =?utf-8?B?dW81ZDlvN29Fbk5WcjJ6VVd1OUs1MVBQdmhKMTNaeWx6REJMaEhNc0gwaVh3?=
 =?utf-8?B?Sm5tamI0TXVvY1UwRWdWUVVRWUZvWGpWZHMrQVRyR0dMZGwvaFNtRThZQTVV?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2bbed8-d646-4e47-9122-08db9e3abbf8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 09:25:30.8687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4VXNwmr2BdaKsxslro1YuX4yvpBplbKMkYCdJRNELkYmiLB3PtsTLYEKX7/1fKSgpDfvJKgwOBACBjo06ierAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5991
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/2023 4:11 PM, Itaru Kitayama wrote:
> 
> 
>> On Aug 10, 2023, at 23:29, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> ﻿Hi All,
>>
>> This is v5 of a series to implement variable order, large folios for anonymous
>> memory. (currently called "LARGE_ANON_FOLIO", previously called "FLEXIBLE_THP").
>> The objective of this is to improve performance by allocating larger chunks of
>> memory during anonymous page faults:
>>
>> 1) Since SW (the kernel) is dealing with larger chunks of memory than base
>>   pages, there are efficiency savings to be had; fewer page faults, batched PTE
>>   and RMAP manipulation, reduced lru list, etc. In short, we reduce kernel
>>   overhead. This should benefit all architectures.
>> 2) Since we are now mapping physically contiguous chunks of memory, we can take
>>   advantage of HW TLB compression techniques. A reduction in TLB pressure
>>   speeds up kernel and user space. arm64 systems have 2 mechanisms to coalesce
>>   TLB entries; "the contiguous bit" (architectural) and HPA (uarch).
>>
>> This patch set deals with the SW side of things (1). (2) is being tackled in a
>> separate series. The new behaviour is hidden behind a new Kconfig switch,
>> LARGE_ANON_FOLIO, which is disabled by default. Although the eventual aim is to
>> enable it by default.
>>
>> My hope is that we are pretty much there with the changes at this point;
>> hopefully this is sufficient to get an initial version merged so that we can
>> scale up characterization efforts. Although they should not be merged until the
>> prerequisites are complete. These are in progress and tracked at [5].
>>
>> This series is based on mm-unstable (ad3232df3e41).
>>
>> I'm going to be out on holiday from the end of today, returning on 29th
>> August. So responses will likely be patchy, as I'm terrified of posting
>> to list from my phone!
>>
>>
>> Testing
>> -------
>>
>> This version adds patches to mm selftests so that the cow tests explicitly test
>> large anon folios, in the same way that thp is tested. When enabled you should
>> see something similar at the start of the test suite:
>>
>>  # [INFO] detected large anon folio size: 32 KiB
>>
>> Then the following results are expected. The fails and skips are due to existing
>> issues in mm-unstable:
>>
>>  # Totals: pass:207 fail:16 xfail:0 xpass:0 skip:85 error:0
>>
>> Existing mm selftests reveal 1 regression in khugepaged tests when
>> LARGE_ANON_FOLIO is enabled:
>>
>>  Run test: collapse_max_ptes_none (khugepaged:anon)
>>  Maybe collapse with max_ptes_none exceeded.... Fail
>>  Unexpected huge page
>>
>> I believe this is because khugepaged currently skips non-order-0 pages when
>> looking for collapse opportunities and should get fixed with the help of
>> DavidH's work to create a mechanism to precisely determine shared vs exclusive
>> pages.
>>
>>
>> Changes since v4 [4]
>> --------------------
>>
>>  - Removed "arm64: mm: Override arch_wants_pte_order()" patch; arm64
>>    now uses the default order-3 size. I have moved this patch over to
>>    the contpte series.
>>  - Added "mm: Allow deferred splitting of arbitrary large anon folios" back
>>    into series. I originally removed this at v2 to add to a separate series,
>>    but that series has transformed significantly and it no longer fits, so
>>    bringing it back here.
>>  - Reintroduced dependency on set_ptes(); Originally dropped this at v2, but
>>    set_ptes() is in mm-unstable now.
>>  - Updated policy for when to allocate LAF; only fallback to order-0 if
>>    MADV_NOHUGEPAGE is present or if THP disabled via prctl; no longer rely on
>>    sysfs's never/madvise/always knob.
>>  - Fallback to order-0 whenever uffd is armed for the vma, not just when
>>    uffd-wp is set on the pte.
>>  - alloc_anon_folio() now returns `strucxt folio *`, where errors are encoded
>>    with ERR_PTR().
>>
>>  The last 3 changes were proposed by Yu Zhao - thanks!
>>
>>
>> Changes since v3 [3]
>> --------------------
>>
>>  - Renamed feature from FLEXIBLE_THP to LARGE_ANON_FOLIO.
>>  - Removed `flexthp_unhinted_max` boot parameter. Discussion concluded that a
>>    sysctl is preferable but we will wait until real workload needs it.
>>  - Fixed uninitialized `addr` on read fault path in do_anonymous_page().
>>  - Added mm selftests for large anon folios in cow test suite.
>>
>>
>> Changes since v2 [2]
>> --------------------
>>
>>  - Dropped commit "Allow deferred splitting of arbitrary large anon folios"
>>      - Huang, Ying suggested the "batch zap" work (which I dropped from this
>>        series after v1) is a prerequisite for merging FLXEIBLE_THP, so I've
>>        moved the deferred split patch to a separate series along with the batch
>>        zap changes. I plan to submit this series early next week.
>>  - Changed folio order fallback policy
>>      - We no longer iterate from preferred to 0 looking for acceptable policy
>>      - Instead we iterate through preferred, PAGE_ALLOC_COSTLY_ORDER and 0 only
>>  - Removed vma parameter from arch_wants_pte_order()
>>  - Added command line parameter `flexthp_unhinted_max`
>>      - clamps preferred order when vma hasn't explicitly opted-in to THP
>>  - Never allocate large folio for MADV_NOHUGEPAGE vma (or when THP is disabled
>>    for process or system).
>>  - Simplified implementation and integration with do_anonymous_page()
>>  - Removed dependency on set_ptes()
>>
>>
>> Changes since v1 [1]
>> --------------------
>>
>>  - removed changes to arch-dependent vma_alloc_zeroed_movable_folio()
>>  - replaced with arch-independent alloc_anon_folio()
>>      - follows THP allocation approach
>>  - no longer retry with intermediate orders if allocation fails
>>      - fallback directly to order-0
>>  - remove folio_add_new_anon_rmap_range() patch
>>      - instead add its new functionality to folio_add_new_anon_rmap()
>>  - remove batch-zap pte mappings optimization patch
>>      - remove enabler folio_remove_rmap_range() patch too
>>      - These offer real perf improvement so will submit separately
>>  - simplify Kconfig
>>      - single FLEXIBLE_THP option, which is independent of arch
>>      - depends on TRANSPARENT_HUGEPAGE
>>      - when enabled default to max anon folio size of 64K unless arch
>>        explicitly overrides
>>  - simplify changes to do_anonymous_page():
>>      - no more retry loop
>>
>>
>> [1] https://lore.kernel.org/linux-mm/20230626171430.3167004-1-ryan.roberts@arm.com/
>> [2] https://lore.kernel.org/linux-mm/20230703135330.1865927-1-ryan.roberts@arm.com/
>> [3] https://lore.kernel.org/linux-mm/20230714160407.4142030-1-ryan.roberts@arm.com/
>> [4] https://lore.kernel.org/linux-mm/20230726095146.2826796-1-ryan.roberts@arm.com/
>> [5] https://lore.kernel.org/linux-mm/f8d47176-03a8-99bf-a813-b5942830fd73@arm.com/
>>
>>
>> Thanks,
>> Ryan
>>
>> Ryan Roberts (5):
>>  mm: Allow deferred splitting of arbitrary large anon folios
>>  mm: Non-pmd-mappable, large folios for folio_add_new_anon_rmap()
>>  mm: LARGE_ANON_FOLIO for improved performance
>>  selftests/mm/cow: Generalize do_run_with_thp() helper
>>  selftests/mm/cow: Add large anon folio tests
>>
>> include/linux/pgtable.h          |  13 ++
>> mm/Kconfig                       |  10 ++
>> mm/memory.c                      | 144 +++++++++++++++++--
>> mm/rmap.c                        |  31 +++--
>> tools/testing/selftests/mm/cow.c | 229 ++++++++++++++++++++++---------
>> 5 files changed, 347 insertions(+), 80 deletions(-)
>>
>> --
>> 2.25.1
>>
> 
> I know Ryan is away currently, but as I can’t find the base commit mentioned in the cover letter to be based off of can anybody point me to it so I can use b4 for applying the series and test?
> 
Ryan mentioned: This series is based on mm-unstable (ad3232df3e41).

I believe you can apply the patchset to latest mm-unstable.


Regards
Yin, Fengwei

> Thanks,
> Itaru.
