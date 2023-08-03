Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A3C76DCC9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 02:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjHCAnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 20:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjHCAnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 20:43:00 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DB8198A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 17:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691023379; x=1722559379;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=rOfaYZN/A9Q7Xf2BKggUyXpDAP8lA5UoqtRmIaJH8n8=;
  b=mFmRlSHEWFmO1jlMBlwtWd65TOc966zFxrx02hIFkkB4s/XAiYHoc7ZC
   z86yXlvihzEJgJwqcco3EYvoN+3WOJDDaDJWg4f0GErLexqI/xcC2iZuI
   rMlCiHRdzEknD48NHw2nZKoZOOlwzNZ0g7V2zDhXRtIlNRO9Wq9w+Ejv+
   lEIfEEE3gZR9ScgLWsMxc4lb4MSf/iJz5/a8eIwNvVpRvGIGj47+/ibCy
   Ze5Cs8wJw4dRxuuecB3Kgp5X6DZ0rGkyr5NrWeXS2koTrnM4IpjTT+0bh
   bXJ1SwrtcPW1losKZGyspLvlRn7pT3s59ckeUkB227r3UHFbCtV4SH7Gu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="436050523"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="436050523"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 17:42:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="872718776"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 02 Aug 2023 17:43:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 17:42:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 17:42:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 17:42:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgXmhgeF3mBgCwvjfrc85QLof08sya+UutWXNCXO1bJCDGyoHG/XnwNZ3zBs2SHsVVjjkGxKLKSGeHkTRUpjKyapotWiQX5MdNW5pV9yNX4mXexpA/O4PhvCDcOyWI5255XyI9aWnWxCL0htaORbrfhNZPYbRJRuiLfLcZmRxAV6EnkS1nOZ6LYfVLPxpxgfH1KNnlbNHvGKPQIwL62GWEWAte3+c9+Laota/PY1xerpQN/a0IuKjnS1utCt6qpDdNIpmGKp2ZdkhQErUdi5l0OF0LIgapLXYDoJev5/vprXiZVCrunEtV58e0f/i9s6J/QTHk248O3GDhJXhL/p5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kg+ROPHFZtkNzpBdmcQ7Pa3NUraMgyxjTQaOHgKnY38=;
 b=m9uz5zswJNV0S7SnyOHxtUI5q9Gxv24HczcChxUSmU6n+mzHqQXni7eel+GUoTtYHKqk1VaN04NhJR/f9+XFLvQM/OXnOmO8tjBWWcuB5UWZ2cDVHFDkKJrAxbLzRpF2ReTKoDB2CQqWtRsqkjNoxSR24MeUN7SQibZ3oE8BmJyaWCN9M+x4s7yXgkvBhd0QY8VPaytB6dJbrVdvFXKTVieRJkqN85e7mR2r2DbjpE1mtjBA2pb0ru0M9+OvEqRRIRRG4lrwaev45OTE85Uiyl28yWOYQgOuz/Sl94h6bKyOKhNlYq6ZC051RlIUGDcxFgz6C4YN5ceHFTTbqWGHMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by IA1PR11MB7891.namprd11.prod.outlook.com (2603:10b6:208:3fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 00:42:56 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 00:42:56 +0000
Message-ID: <1f01beae-3468-030b-1627-5f5ed4f26595@intel.com>
Date:   Thu, 3 Aug 2023 08:41:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] mm: add functions folio_in_range() and
 folio_within_vma()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <yuzhao@google.com>, <willy@infradead.org>, <david@redhat.com>,
        <shy828301@gmail.com>, <hughd@google.com>
References: <20230728070929.2487065-1-fengwei.yin@intel.com>
 <20230728070929.2487065-2-fengwei.yin@intel.com>
 <f1d07ca4-3d69-67cd-a14d-333e4be699b9@arm.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <f1d07ca4-3d69-67cd-a14d-333e4be699b9@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:3:17::19) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|IA1PR11MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: a5afd7c3-1978-472c-b260-08db93ba943b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c3xS4a67E263KN89Oujf50QOazQGui6arovK7+uAa5sRtEq+pkqMMG4sH0cLJNhsjmAi7VLA25z9/vz89A4anexsrRO1pkF67oIwsb7zPwitOMNCAPX76T6rPtiWB6TfWbZq9vdZLCRSCsGHQMPoYGBhkvmEW0KnpsUbpIhlySNsj7y/jgEJVD2hRmGuykyrvSLXL+ZZ73hYz+j7SWj99Ixd56nePswRDnH5m1Roxq7+RmR7Wvxyn0nO6vJlNzJeHBaMqVMX78gvDKDKLxqwGecibW63TeR9K6hcrPhCNbWnje2VJ5C8JEGobhfGhmf1+5O1yO/G2Dn3+HA86uD06KD0nQW7H91GKqkPsIcNOTbD7lkRSQKqD3K5CMGO3Y1JchEpHd+HTra4Glo4Z6GJOftVW1+jz2mzi4WlxFhoPsReuu+ICtE0tGDK2jUiRD+RYt4AqjgZdCNiWenFySDB3W2GlKOnPx5u7t3RzFxvWZRscD+zfr0PPDbLkQZRxMQ77IfytrXxV5xQorHTH5C29eqv+lH4OtV6hgfXP/+yv+BF4NlngzKvq/6axJ7sz3/54wyzFglL4PXKEvez/nUeVHVaY03G1U5TfzDySV4/PDqexNZwskET7IAAgfuQFD8p7QDABxQleRdo/yVfHWc7kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199021)(66556008)(66476007)(66946007)(2616005)(316002)(5660300002)(41300700001)(186003)(26005)(53546011)(6506007)(8676002)(8936002)(31696002)(86362001)(6666004)(478600001)(6512007)(6486002)(31686004)(38100700002)(82960400001)(2906002)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWoyWE1wL09obm9ia1FlczV2NkpjUE5rVnd6QUdRTjVaQXlrbE9UTlFRRkcw?=
 =?utf-8?B?OFJsV2J0WUdKczhmK2FRTXhhSFpzUkpUdkh0TC8xZlNaOTZsMFF2UWd4K0E3?=
 =?utf-8?B?VDhTY0JIN3JuaWVvVFV1ODdXQmxhOE1qQlA4d3NJaXdCRUhWTmJ2NzN2QzJy?=
 =?utf-8?B?NTExcjVFTXQxMGM1aEZpbWVXc0k2bjV1emZ6ZUdCQ2diR0JpZFBWU0RpQ2pD?=
 =?utf-8?B?ckxBRHJCdzlxcEhVK1lGd1JIa29BeFM5WjB4L1J6OWRVVFpkbEcyVGZ0L3ln?=
 =?utf-8?B?V1VGLyt4MSt6MVdPb3YyWEJaQWxRZTFUOVlQbi8yWS9YY3ZUVldaQ2h6K1BN?=
 =?utf-8?B?K1JNbU1ObWhEc1FtQk82Rjc2Skx1V0U3Z25ERXRIcGdBSXY1WExrckhGMldK?=
 =?utf-8?B?WXQvcGFUa0loSXBCalFFSndaMmllR0QrNm1rY1J3SFhsRnU3c2phZDYyTWFt?=
 =?utf-8?B?Q3pKQmZwci9vQm1TMnNrTi9mVnFWUjJ1RjA1by8xakR3NWRuUG45NlFnSFdB?=
 =?utf-8?B?T2hHSGJEU0t0RFRNeHBCTTU5MlBrZ05makcwek91cGFHNEhQbkpaZTRiaGRl?=
 =?utf-8?B?a3lFL1NWdHBlZ0JpdStNcUwwQVFiOE9OSFh4NERnWllQNzlRTmJCMkdyWkNM?=
 =?utf-8?B?M1NFbUpqNVZHRUpWQnMzcmpOOWhLcUdKTjkzLzBHWE1BUGxCeFFBSWF0YndD?=
 =?utf-8?B?bDRMNGtFdmhmVTM1TEVPeFd4SUk1MG82dlB0bnZkVE9ySmJMQ29Xd2FqeUVx?=
 =?utf-8?B?WnhHRTlXTXRTazhSRmR4enRxcXVTNkJ6V3RTRVRxdzNmQTBIZnVZd2VtRFlm?=
 =?utf-8?B?SkNrYVZmVnlhWEFPM25ZdmNCSjY4MTg5K0pWVkN2c3psU0wyOEx5U3RjTUlR?=
 =?utf-8?B?Q1dhenBnYnRVZHNhZjRnYWJMUTYrQzF1aWhNTjh6aGt6dW5QN0c5Qm9UVVpv?=
 =?utf-8?B?RG1XZ2NXby80endPTndEdVRSam95NGxFUnZFcFlTWEd0NEdFODRsOGpjdDNZ?=
 =?utf-8?B?WFNHL1pXSC9LMDE0bmpUWlNBVXFrOVVkV3NBOGhadnRnMVZXL1A4dXVIY3Bj?=
 =?utf-8?B?U0QwS2tIWHpWdVhaZkFYbzY3bEl0QVNZSm1pMFI3cnBsYlpsYmtySWdvNzAy?=
 =?utf-8?B?WDhiM3JFbEhFZVFCdU1CczVxNFFBY3VldE5xdUdQeVJFb3VCT3Q5bVNzY3VK?=
 =?utf-8?B?aXcvbTc4UnJzWFg2VTQ2NzAwUUgvM0VDM1BjeXM4T1ZRV3kvaXl6aHNMeVBC?=
 =?utf-8?B?alpZakZqYk9MdWtjc3dGTjF3Sm9BeXZsdEExY2FJNXRQd2dBc2F2eFhwZmV1?=
 =?utf-8?B?VStkd1A2Q1VyaVVKZGEvRWV4aDNJWEZrbE55emZxZTY1VDIxZUhJR01tQnFI?=
 =?utf-8?B?aHdZUEF2OUt0UVRYWWJHTklHaThOSUJqb1pMbVJtV2dQZU9jM1dvenVRL1ph?=
 =?utf-8?B?WFFPY1F2bUlGa1lidDJ6WndVREdaWEk5SHY3NkNGTkt0dFZjbU92SGUvc3Jm?=
 =?utf-8?B?dzhNNDVIaVpsZC9GaWI1L0FOeWw4YmJXTms2QUhKUGVFY0ExYVhNRFlDK0Mr?=
 =?utf-8?B?SGFNNXdNQTJWd2ZLRWloMEdVMEZrSWxHUVAxZ0NaV2taZ1AzdGhkQlhhUXVs?=
 =?utf-8?B?UnNBUXJYWDh5VUJGcTBidU1kWG9rNm16WFFneGUydGRpNFV4S1V0LzdYOFNB?=
 =?utf-8?B?NDFBRjc1dW00cTR2MlhuaVl2NWNiUGprcUNxNFJOV1gwcWdsdkg3cFAwcGho?=
 =?utf-8?B?S3NpeENZc1pBV2NxaHFEZ0YyckdXVGkrYUZLVEYyVXNxdmdmaVJWamxla2Ra?=
 =?utf-8?B?bjU1WUJtV3pVV1czMlIxQlpmeXpJSUhtejc1SU9NeGlUZFBsay9EUE53V1J1?=
 =?utf-8?B?T0VDUXFnQjlnMGIrMDBXVGJJL2ViaHVBV3VUK0JMQ1lRUlR1dEZtaWlQdkZD?=
 =?utf-8?B?ZVJMOTFQYjJsTEJLOWxBazZFNmo1WXo3TmZybE1oYnY1TEduTkFRc3lCTHdk?=
 =?utf-8?B?RW93bUdYanFnbFJnWFRiRjZyRzBuczNXSHA2U0g3b0ltY2NLYzM2LysrcXRy?=
 =?utf-8?B?T0RxS1Flei80dXBUVkcrZzVsTkhpbk1HazYwQm5WeDlySktocnU4V3lhRER1?=
 =?utf-8?B?UmxSMVpDR0F1RzV2K1dLRXI2MGxlYmcvTDVtaWNDTG1YT0ZHUi9PcnBWbEpM?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5afd7c3-1978-472c-b260-08db93ba943b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 00:42:56.4515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZWoKFzOZNH1y0uAr6TZvnSw5BSXA7bTq2P8axi+iMIWNyH/Sys0SMoUuKtjnpR8YjYK7dtzSWgzKTCZazah3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7891
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/23 23:15, Ryan Roberts wrote:
> On 28/07/2023 08:09, Yin Fengwei wrote:
>> It will be used to check whether the folio is mapped to specific
>> VMA and whether the mapping address of folio is in the range.
>>
>> Also a helper function folio_within_vma() to check whether folio
>> is in the range of vma based on folio_in_range().
>>
>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>> ---
>>  mm/internal.h | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 69 insertions(+)
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 5a03bc4782a2..63de32154a48 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -585,6 +585,75 @@ extern long faultin_vma_page_range(struct vm_area_struct *vma,
>>  				   bool write, int *locked);
>>  extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
>>  			       unsigned long bytes);
>> +
>> +/*
>> + * Check whether the folio is in specific range
>> + *
>> + * First, check whether the folio is in the range of vma.
>> + * Then, check whether the folio is mapped to the range of [start, end].
>> + * In the end, check whether the folio is fully mapped to the range.
>> + *
>> + * @pte page table pointer will be checked whether the large folio
>> + *      is fully mapped to. Currently, if mremap in the middle of
>> + *      large folio, the large folio could be mapped to to different
>> + *      VMA and address check can't identify this situation.
>> + */
>> +static inline bool
>> +folio_in_range(struct folio *folio, struct vm_area_struct *vma,
>> +		unsigned long start, unsigned long end, pte_t *pte)
>> +{
>> +	pte_t ptent;
>> +	unsigned long i, nr = folio_nr_pages(folio);
>> +	pgoff_t pgoff, addr;
>> +	unsigned long vma_pglen = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
>> +
>> +	VM_WARN_ON_FOLIO(folio_test_ksm(folio), folio);
>> +
>> +	if (start < vma->vm_start)
>> +		start = vma->vm_start;
>> +	if (end > vma->vm_end)
>> +		end = vma->vm_end;
>> +
>> +	pgoff = folio_pgoff(folio);
>> +	/* if folio start address is not in vma range */
>> +	if (pgoff < vma->vm_pgoff || pgoff > vma->vm_pgoff + vma_pglen)
>> +		return false;
> 
> I'm struggling with this logic. What happens for an anonymous folio in a
> (private) file mapping? Wouldn't the folio's pgoff be 0? In this case you could
> return false incorrectly?
You mean cow page for a file mapping?
I suppose the pgoff of folio (folio->index) is not 0 unless the folio is mapped
to vaddr 0. __page_set_anon_rmap() will set the folio->index based on vma->pgoff.


Regards
Yin, Fengwei

> 
>> +
>> +	addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
>> +	if (addr < start || end - addr < folio_size(folio))
>> +		return false;
>> +
>> +	/* not necessary to check pte for none large folio */
>> +	if (!folio_test_large(folio))
>> +		return true;
>> +
>> +	if (!pte)
>> +		return false;
>> +
>> +	/* check whether parameter pte is associated with folio */
>> +	ptent = ptep_get(pte);
>> +	if (pte_none(ptent) || !pte_present(ptent) ||
>> +			pte_pfn(ptent) - folio_pfn(folio) >= nr)
>> +		return false;
>> +
>> +	pte -= pte_pfn(ptent) - folio_pfn(folio);
>> +	for (i = 0; i < nr; i++, pte++) {
>> +		ptent = ptep_get(pte);
>> +
>> +		if (pte_none(ptent) || !pte_present(ptent) ||
>> +				pte_pfn(ptent) - folio_pfn(folio) >= nr)
>> +			return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +static inline bool
>> +folio_within_vma(struct folio *folio, struct vm_area_struct *vma, pte_t *pte)
>> +{
>> +	return folio_in_range(folio, vma, vma->vm_start, vma->vm_end, pte);
>> +}
>> +
>>  /*
>>   * mlock_vma_folio() and munlock_vma_folio():
>>   * should be called with vma's mmap_lock held for read or write,
> 
