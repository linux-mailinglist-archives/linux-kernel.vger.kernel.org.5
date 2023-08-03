Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A496876DC97
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 02:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjHCAZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 20:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjHCAZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 20:25:37 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD05011D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 17:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691022335; x=1722558335;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=nPLMmrCl17gnM0L94JNVs0Qy/4c5PCOGFw2zDAaZV3g=;
  b=JxEGC25hCQF3VbOuhbumYlNGtTbTEh9P/PPRzjK+rSQiShaR4pgfYAJa
   sr8PDr2Mw1udzTAZ5/bT0fPM/4QS7qBRh8uJsdK4t6ulc4QXGhpTGFMKO
   jNrKZoX6UNieaGx1AyOJWX9a/XKHqWMSROuKQrKPBYnTW6fBmrLfbcesZ
   Z+OloalgA4Zweg9hADTejAiW0w6pRfGGAn5zCJmenQIjAZ6s5zNfV7YYH
   /ZsuionFOZseORh6+6FqlW3DLMubzXLUfwhzN/CiHStkbr/HxYlkthODG
   4d6SHToRsrDrWnQMHAyo0W1lZSIP9DIR3v7eiguVb3Hl9WsdVz6BjIgC7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="369736729"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="369736729"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 17:25:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="1060024902"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="1060024902"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 02 Aug 2023 17:25:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 17:25:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 17:25:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 17:25:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZnfb+E7MwVrCTJwxcwDLNElZfpaW5gWyLKJ+oL2dCdlp0wDiyflk39fYk6HTOWw3JDxYOdHUlMzPpVHz94kRxYWTk3nK7Ihf/S4I1fbv2gWTSV7OJAwtm3SIzUL2CmfyJfqbS4IBu/1zfUb4dAQu9wMktUyAaHJTUa8MRIwkOe0aU0ngwlykN6BfTwhAbcSsGtN6ln25IYiNfPUYR+l3f2Kqx6vrnTKkJE31r1DfUEE5ZKzUqOfTh09rlx/aMEsx4AZaQna5ZjI3knWs1xGtoSc1LHeo6i00qgDc0sJI+63qoW+noXuklbxZFLMtLzN/npnna3TnX28NXGPoiKOxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cows6l9r6qlnr9qle8UHZUzWlZrbtqS2KjbMX9H8FJ0=;
 b=IZqW1AZWtbvk6OBLj9WFCi2lsct6sLaFu783ziBpsANmoBHp0CB0+yPuityqUG3Yo4Et3176pEA83j+hMTGcmJPiXEMO8GfwPWOfDANWwx21qE4BOHTbE/7fjflHSWb8KjMCTZfq0tDnLEyT82l4VlrEC+ZkUbnJcrNfaLJW3QQioaMc2NOaD893ZNZrdF9gSVfPrbuh1KSAorqS9ljrXpc9rJEcHpT/gsaOEu505ouyarbyXDSP0F/S28xHiqIFtZwfPjz3z6ofThiTWHF8Qp0xZUSvnSEQORu9l2oeHk2580RbAR4rf5gkVY+/xG28+IYjXjMx+6DQZdqoQvMZxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CYYPR11MB8329.namprd11.prod.outlook.com (2603:10b6:930:c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 00:25:33 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 00:25:32 +0000
Message-ID: <e0e6c8e3-62e0-eeaa-3648-2b21f24ed831@intel.com>
Date:   Thu, 3 Aug 2023 08:24:01 +0800
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
 <55c9e3f7-099d-6f57-32da-1f318a9688a0@arm.com>
 <eb50a427-3738-c1bb-b8cd-8636902deffb@intel.com>
 <65a36b41-d69e-4072-cfd2-253ed6e4e040@arm.com>
 <286cbca6-ab5e-ad06-ea2a-89ea08ee53d4@intel.com>
 <8dcf002a-088e-32de-7868-5dc5ca6b1206@arm.com>
 <6f5301b4-57f5-bcef-45d4-68b0efbd4e67@intel.com>
 <d863b403-6737-7c76-ab47-e6bdddbfe37f@arm.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <d863b403-6737-7c76-ab47-e6bdddbfe37f@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0091.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::31) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CYYPR11MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 94bfdc8e-e444-4eed-89d1-08db93b8261f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2jlEQl4ldDY9RgV0zOnsltFJTFuhwGuKWGtPZW/KD+TUfLpE02Wuke7GyMiL7y9GpiodeOl36dHI51OZ0E2kudVU3MWBiqOaqDZWFOlVWskVJnkhlGKHn6/xZHCnqq9XIyA7Olxs8UFDL44vQtZ6kFTfZlfQ0o4HFacWzJfE2ztt8N0eWw8PL+2+uwEgDdWjrFwWunUfqtTeFtdvl+XPYJHOLaCNxtguvw++csgbV9sQu+BO7qxmNXWuYp8R3bSZNn7Aa/fBspHViiOmuV73C1IDDLQyXELwluhbbqefjxXQ+IEiQgHKDY71fO4k8slpyUh8fNy+hcRgkxK642xcO7sX0+XsBN8vrebCDEAOBSN1+RRQbVcNNUov8SmGZwyku49v4chu7WPhhxcJaU/VAXSlNKxhVFyPFGMYXxFYZxR3wnXWnBjXM4tevuYubbFlRIPV1SMTSfmNnu468L+rBxPEYqA8M5YwaJgKvKP2Pf5V/ihFVFpISuHwrLEtTLJz9+yzJfBLSwl93FRhKyO/0y+NYxC4iLC64tMp+Oj55k2pwA38uEYUFxrG3KfKYGXdOBG9IAVgz+WAK6IzLqM7NT9Sl4rem/g3QwhC8Mnm0gvgvObPlAsVOpSlDtb5JajU5UgOOGxIXy5+6m+dUTnhrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199021)(66556008)(66476007)(66946007)(2616005)(316002)(5660300002)(41300700001)(186003)(26005)(53546011)(6506007)(8676002)(8936002)(31696002)(86362001)(6666004)(478600001)(6512007)(6486002)(31686004)(38100700002)(82960400001)(2906002)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFEzWFdOc0dMMFdFTXVZMm5UN3B1VDlhK3FwY1p1ay9uVjludFpQczhtY3ZD?=
 =?utf-8?B?NlN0Uzg4Rk1kK0RqQVFveGhyeXRMNTZRQVFCam9UV3ZpdkNZaEdHdG1YcGxD?=
 =?utf-8?B?aTJwRkFBbllISEd1ZzFQb0JsdGpBcWJXemdPNjc1MHBVN0xMVEcvS0N5Q2x3?=
 =?utf-8?B?VmFMOHNPZEdIeTVacDRFd29kdm9iaWhCbFUrd2ZLWEhmbFFoL0N5QW5USkM4?=
 =?utf-8?B?enl2dGdMZWhzdFhkd1BybHVxVjkzTEZMYVlVKzBwTnR5aGZRWmQzT09kQ09k?=
 =?utf-8?B?NEUzeXBQQThJNUxXRytQSExuTVZpTXRwSkh6czQ0V1YwSDY3cUlNR0NFRTZj?=
 =?utf-8?B?ZVlncUdHYzZLZ3pxSVgwS2xJNVU3Ri9OUG1NNGJqVHppelQyYkQzY0RRRkN0?=
 =?utf-8?B?UDFhVlRSQXVXVXY5aGMxa215ZS9BR1lhRHl1QTE1UnlKb084TXFKa0ZzMHo3?=
 =?utf-8?B?akdGd1RZM0tBbHNhamt6V1Vmd1ZqUmtFR1VUQU1lMTAxbU82VkdoMnZiWGVJ?=
 =?utf-8?B?aXMzM05yR3h2bm9hUXpaN3RoYTBCZWltQTdSY0JBaitVZ0U1bnc3Z2pENzIw?=
 =?utf-8?B?VVltbnNTQ0JTcmswZXdsd0J4VktWcXNVMGtaUlFSRTZqbXlmbFp1SmJURENP?=
 =?utf-8?B?MzR5TmZFbTVIMml6TmJMQWJvNFJENVZEcVdacmY2TThnNTVhMzdiTW05M1cx?=
 =?utf-8?B?L3dtVys5SU9jQk9Reko2dU1BRGhPWkd6Nkg3cEhOSXlJQ1luWFVrdnBPc3pY?=
 =?utf-8?B?UkxsaHU5ZXk1bnl2VTZlYWh2ZWlhUWVQSHhibWNWVElkaFpqRE1MWkRSZG9m?=
 =?utf-8?B?VlJaZVNiOWJEV01VUWttQjQ5WndPUzliM3ptT0FkTEEweVN2U0lvbTlpTzc2?=
 =?utf-8?B?Z3BMU2svbmNaMmRhdk9IKzYrZDRYcExvdnFVQ0JWajlady9iVllEaXVXS1FM?=
 =?utf-8?B?N1V2NktWSEpaVHhqRXczeFhRSXFuUmRvZUJrTS9HQ0Y3WnBnQi82YmkyWnpm?=
 =?utf-8?B?c28xd2J6ZmxjdUlSa2x2ellVZmlXWlVSbGwzNGhVbE5QVHpLdENTK01TMlJ4?=
 =?utf-8?B?RGJIRVZtbGtzL3d0VGhLSnhiTjA1am41QlliUHZzTmRaTWZFck5SQjBIdmFF?=
 =?utf-8?B?QkgrTVZPblZDVFloVnltOExvUTJ3N1JGOXBBV3FYeGtqeDZvRmtjN054d1VX?=
 =?utf-8?B?aEVCZU1ZSzBiaHg1SWFMNEVodHduQXliaXFZU1c5QTFXRW1FOWg4eFViQjhJ?=
 =?utf-8?B?WFE2UjZ2MlJrYUo3TGpLa3EvdVQyVXdnUC9SUGF0QTlSWnd5V1Z3S1RhQVp6?=
 =?utf-8?B?bitzaG9iN1Z1SXVWM3EzU2pFK0RoUFlSSVZFdHRwN2V4aGRzNWgrTnBiOUFh?=
 =?utf-8?B?WXVuOFAyTEFqQlkwRk9CZ0FKK0hRVkhkTGlNVlV3UXJwb3RTQklwSSs5UkNz?=
 =?utf-8?B?U2NkT0ZxaGkyUkRuZG0wSG15Q2dMdUhTK3V0amtuZWNHaXlZQ2ZDL3BQL3p1?=
 =?utf-8?B?c05QbGNoLzVsdlVvalN3T0ZmQ2FaL3Q5RWUxNlhmdnJIRFdEc3ByUGNHRjJm?=
 =?utf-8?B?bkFNWHlJRHZMVG0vUHZraEFxaVBJYURwaXBpSGtTT3ozYkxYd2FJK2hCY2N3?=
 =?utf-8?B?eUhOMVZvTjE5bWdpVW9HWGpqM01rUytJZkpTb2dyRzkyQ2xxTUx5a25PNVBY?=
 =?utf-8?B?TVNWZ21odVpMVFRIb2JuMlMrMEhBQk1Zc2wwRm01QmFSQXFBYmhYQXRXdEta?=
 =?utf-8?B?T0g0RDNmS0pjV2hUR25SMWxWOHRkR1FXeFFtRG9DTm03SFdKbmlQaFlpRFJl?=
 =?utf-8?B?ZmRnV3FaYUROTVVtbDdzZFRna1BHWFRYcG1URUZjS0E5YmFCcXBvQ2FPdHFB?=
 =?utf-8?B?WFVsTVR3TTR2elBUUWNWMnNBM2doY21lci84aTV2TE84bER2UU1sT09nWkdO?=
 =?utf-8?B?b0dEdmZ6UXVrU2ViQnVyeUxUUVhZci81VjNOYUdrRExycllibmtxcGVWeFFD?=
 =?utf-8?B?YU9vNE1aT2RFNEN2YlE3L2M0N0JXeEtrS1BqV05aTDZyL0RRY0ZoOGs2OTZ6?=
 =?utf-8?B?eFdPaGpJMHJzRGRibkNXZFBiYmV2K21sRXJpNGtzaXd2ajBCckFyUC9tVTlo?=
 =?utf-8?Q?4MJmtvFNrzdb7hJLaEF5Vx/IU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bfdc8e-e444-4eed-89d1-08db93b8261f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 00:25:32.8416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLKQReslRY/jBQwfOosR+8v37qWXMKP2UEMnFJk4KEqM5OhZawijEksg1MOQI41BwLdD0MROahkHGhQX1tpEHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8329
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/23 22:59, Ryan Roberts wrote:
> On 02/08/2023 15:14, Yin, Fengwei wrote:
>>
>>
>> On 8/2/2023 10:08 PM, Ryan Roberts wrote:
>>> On 02/08/2023 14:46, Yin, Fengwei wrote:
>>>>
>>>>
>>>> On 8/2/2023 9:09 PM, Ryan Roberts wrote:
>>>>> On 02/08/2023 13:50, Yin, Fengwei wrote:
>>>>>>
>>>>>>
>>>>>> On 8/2/2023 7:14 PM, Ryan Roberts wrote:
>>>>>>> On 28/07/2023 08:09, Yin Fengwei wrote:
>>>>>>>> It will be used to check whether the folio is mapped to specific
>>>>>>>> VMA and whether the mapping address of folio is in the range.
>>>>>>>>
>>>>>>>> Also a helper function folio_within_vma() to check whether folio
>>>>>>>> is in the range of vma based on folio_in_range().
>>>>>>>>
>>>>>>>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>>>>>>>> ---
>>>>>>>>  mm/internal.h | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>  1 file changed, 69 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/mm/internal.h b/mm/internal.h
>>>>>>>> index 5a03bc4782a2..63de32154a48 100644
>>>>>>>> --- a/mm/internal.h
>>>>>>>> +++ b/mm/internal.h
>>>>>>>> @@ -585,6 +585,75 @@ extern long faultin_vma_page_range(struct vm_area_struct *vma,
>>>>>>>>  				   bool write, int *locked);
>>>>>>>>  extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
>>>>>>>>  			       unsigned long bytes);
>>>>>>>> +
>>>>>>>> +/*
>>>>>>>> + * Check whether the folio is in specific range
>>>>>>>> + *
>>>>>>>> + * First, check whether the folio is in the range of vma.
>>>>>>>> + * Then, check whether the folio is mapped to the range of [start, end].
>>>>>>>> + * In the end, check whether the folio is fully mapped to the range.
>>>>>>>> + *
>>>>>>>> + * @pte page table pointer will be checked whether the large folio
>>>>>>>> + *      is fully mapped to. Currently, if mremap in the middle of
>>>>>>>> + *      large folio, the large folio could be mapped to to different
>>>>>>>> + *      VMA and address check can't identify this situation.
>>>>>>>> + */
>>>>>>>> +static inline bool
>>>>>>>> +folio_in_range(struct folio *folio, struct vm_area_struct *vma,
>>>>>>>> +		unsigned long start, unsigned long end, pte_t *pte)
>>>>>>>
>>>>>>> This api seems a bit redundant to me. Wouldn't it be better to remove the vma
>>>>>>> parameter and instead fix up the start/end addresses in folio_within_vma()?
>>>>>> My understanding is it's necessary. As for madvise, we need to check whether
>>>>>> the folio is both in the range of VMA and also in the range of [start, end).
>>>>>
>>>>> But in folio_within_vma() you pass start as vma->vm_start and end as
>>>>> vma->vm_end. And in this function, you narrow start/end to be completely
>>>>> contained in vma. So surely there is only really one start/end you are
>>>>> interested in? Just seems a bit odd to me.
>>>> madvise() will call filio_in_range() with VMA and real range [start, end) passed
>>>> from user space.
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>> +{
>>>>>>>> +	pte_t ptent;
>>>>>>>> +	unsigned long i, nr = folio_nr_pages(folio);
>>>>>>>> +	pgoff_t pgoff, addr;
>>>>>>>> +	unsigned long vma_pglen = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
>>>>>>>> +
>>>>>>>> +	VM_WARN_ON_FOLIO(folio_test_ksm(folio), folio);
>>>>>>>> +
>>>>>>>> +	if (start < vma->vm_start)
>>>>>>>> +		start = vma->vm_start;
>>>>>>>> +	if (end > vma->vm_end)
>>>>>>>> +		end = vma->vm_end;
>>>>>>>> +
>>>>>>>> +	pgoff = folio_pgoff(folio);
>>>>>>>> +	/* if folio start address is not in vma range */
>>>>>>>> +	if (pgoff < vma->vm_pgoff || pgoff > vma->vm_pgoff + vma_pglen)
>>>>>>>> +		return false;
>>>>>>>> +
>>>>>>>> +	addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
>>>>>>>> +	if (addr < start || end - addr < folio_size(folio))
>>>>>>>> +		return false;
>>>>>>>> +
>>>>>>>> +	/* not necessary to check pte for none large folio */
>>>>>>>> +	if (!folio_test_large(folio))
>>>>>>>> +		return true;
>>>>>>>> +
>>>>>>>> +	if (!pte)
>>>>>>>> +		return false;
>>>>>>>> +
>>>>>>>> +	/* check whether parameter pte is associated with folio */
>>>>>>>> +	ptent = ptep_get(pte);
>>>>>>>> +	if (pte_none(ptent) || !pte_present(ptent) ||
>>>>>>>> +			pte_pfn(ptent) - folio_pfn(folio) >= nr)
>>>>>>>> +		return false;
>>>>>>>> +
>>>>>>>> +	pte -= pte_pfn(ptent) - folio_pfn(folio);
>>>>>>>> +	for (i = 0; i < nr; i++, pte++) {
>>>>>>>> +		ptent = ptep_get(pte);
>>>>>>>> +
>>>>>>>> +		if (pte_none(ptent) || !pte_present(ptent) ||
>>>>>>>> +				pte_pfn(ptent) - folio_pfn(folio) >= nr)
>>>>>>>> +			return false;
>>>>>>>> +	}
>>>>>>>
>>>>>>> I don't think I see anything to ensure you don't wander off the end (or start)
>>>>>>> of the pgtable? If the folio is mremapped so that it straddles multiple tables
>>>>>>> (or is bigger than a single table?) then I think pte can become invalid? Perhaps
>>>>>>> you intended start/end to always be within the same pgtable, but that is not
>>>>>>> guarranteed in the case that folio_within_vma() is making the call.
>>>>>> If pte is invalid for any reason (pass wrong parameter, not fully mapped etc), this
>>>>>> function just return false in page table entry check phase.
>>>>>
>>>>> Sorry I don't think this covers the issue I'm describing. If you have a
>>>>> pte-mapped THP that gets mremapped to straddle 2 pte tables, don't you have a
>>>>> problem?
>>>>>
>>>>> example for 4K base page set up:
>>>>>
>>>>> folio_nr_pages = 512
>>>>> first page of folio mapped at vaddr = 2M - 4K = 0x1FF000
>>>>>
>>>>> If you then call this function with the pte pointer for the second page in the
>>>>> folio, which is mapped at address 0x200000, that pte is pointing to the first
>>>>> pte entry in the table pointed to by the second pmd entry. The pte pointer can
>>>>> be legitimately manipulated to point to any entry within that table,
>>>>> corrsponding to vaddrs [0x200000, 0x400000). But you will end up subtracting 1
>>>>> from the pointer, intending that it now points to the pte entry that represents
>>>>> vaddr 0x1FF000. But actually it has fallen off the front of the table into some
>>>>> other arbitrary memory in the linear map. 0x1FF000 is represented in a different
>>>>> table, pointed to by the first pmd entry.
>>>> Yes. This can be an issue as hold the second page table lock can't prevent the first
>>>> part unmapped. Let me add another check vaddr align to folio_size in next version. 
>>>
>>> Locking is a problem but its not the only problem. The 2 tables are almost
>>> certainly not contiguous in virtual memory. So once you have moved the pointer
>>> to before the start of the second table, then you are pointing to arbitrary memory.
>> If vaddr is aligned to folio_size, suppose we are OK here (I have assumption that
>> large folio will not be larger than PMD size. Or it's possible on ARM platform?).
> 
> I *think* your assumption that a folio will never be bigger than PMD size is ok.
> (I'm guessing page cache never allocates bigger folios than that?).> 
> But its a bad assumption to assume folios are always mapped in a naturally
> aligned manner. mremapping a thp will cause non-natural alignment. User space
> requesting a file (that is in a large folio in pagecache) to be mapped to
> arbitrary (page-aligned) address will do that.
The none-aligned THP is what I want to filter out here. But I totally forget the
page cache which could cause same thing as mremap. I will use another way to check it.
Thanks.


Regards
Yin, Fengwei

> 
>>
>>
>> Regards
>> Yin, Fengwei
>>
>>>
>>>>
>>>> Regards
>>>> Yin, Fengwei
>>>>
>>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Also I want to check that this function is definitely always called under the
>>>>>>> PTL for the table that pte belongs to?
>>>>>> Yes. I should spell it out. Thanks.
>>>>>>
>>>>>>
>>>>>> Regards
>>>>>> Yin, Fengwei
>>>>>>
>>>>>>>
>>>>>>>> +
>>>>>>>> +	return true;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static inline bool
>>>>>>>> +folio_within_vma(struct folio *folio, struct vm_area_struct *vma, pte_t *pte)
>>>>>>>> +{
>>>>>>>> +	return folio_in_range(folio, vma, vma->vm_start, vma->vm_end, pte);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>  /*
>>>>>>>>   * mlock_vma_folio() and munlock_vma_folio():
>>>>>>>>   * should be called with vma's mmap_lock held for read or write,
>>>>>>>
>>>>>
>>>
> 
