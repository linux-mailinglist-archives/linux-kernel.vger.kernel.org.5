Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF860762A60
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjGZEpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjGZEo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:44:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91FC19AD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 21:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690346695; x=1721882695;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i+zNUQO7G1a8eX9GmYC6Ld7uSAvwUQ3A1fvQRzFU+3c=;
  b=G+sQWgxxuZ6c/MQqlM074h9TyoRz6Vzcr11SBtDCIsxoAhX09jYIGXMe
   y8xKpg1obUsLKAE+AqdJ4R54JQC4k1jd1tC4ODBHzsm2RJqX614Mdm8Dv
   lFi5KSGiz0oqGu2H/WF+05M9NbK1yVM6jdbi7prl/DM0AC6iwRSG/6c19
   NoH7l9MuyTqaHHoPWq1LFMCAqodNZxTXiq2n5adNWsPmqe/oOlW+E3lCG
   vV7VfqRGswWE5ZqhqT1Hu8D8rE7r1Oero/AvuEnOx3gdiRfm7eylnisCe
   qKIQPlS0/t49SLEMZ4x+zKaZKcnSg6CH56bkcqCoPn90J2qNrwHxQA50Q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="348187383"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="348187383"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 21:44:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="676503542"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="676503542"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 25 Jul 2023 21:44:55 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 21:44:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 25 Jul 2023 21:44:54 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 25 Jul 2023 21:44:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mi2dEHvAJp8PFkxalhZx0zYVM37BdZXne7uBYZPW3rrYwyMYUBPkL/XIYcQ4BcyDTnWn6MyPWs0O1FSO1Mncaw1Jpe9GcqxqXnaAWrtIXqutPNGpRkgwlXFnfTMDRAYTYCxGo8/X1UqADY523Ov7tHppSE4kzWLIjG0Xpw4u7sidGgcvBh2Cx1KTLsPs9A/LHQbvdbplOTCY74RelYB2d7DPT9lsxFSNd+SiUP+CiKyevDjVdIEcu1nMZMrY0PYmPtmJjQ3aQjzKMn1dq/Vtp3aIQiJVPzW93mIbhB789Ex/X28gmkCD8Yr01L4Mlj4E73d/o0uxZQj5p4tTyuigEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EFJwmHeZwxcg6adbUlsdd9NrVOOrEvnETHLjhvr4EE=;
 b=JQB3dgx4nIPsDOeCp0BiTYbKivxSRLe4mFOwhCT9TFoLgXfXNSsPee+82vI7MSgyV9SjjehD97yRrki23juYs2amZd0bujCkNIYZZ4yLK7BlvVwTjHHKSPevCg7qxdUBZoRIFbhKEFGfDQo9z52EkTVMgtUzVVMjjATgaH2/eeEuliQD2wGQnytOx4AFDbYsdZEw9DV7UDoCuxJmqXIdR3SlU8nHGKcpD2F4PNNWNTZypdP9c2PUFRyb0fYcQLNM4XRk6MqOC/JUs/Up3FDWOJG6mKY0+GWp6F/HaBPy+gS47LLgsOMuUjQdW8AxCmgKIzbPPwGIn4wor4diRH+IXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH7PR11MB8479.namprd11.prod.outlook.com (2603:10b6:510:30c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 04:44:52 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e%5]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 04:44:52 +0000
Message-ID: <feb58221-e481-3d71-8707-6ffe90158b66@intel.com>
Date:   Wed, 26 Jul 2023 12:44:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 2/4] madvise: Use notify-able API to clear and
 flush page table entries
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <minchan@kernel.org>,
        <willy@infradead.org>, <david@redhat.com>, <ryan.roberts@arm.com>,
        <shy828301@gmail.com>
References: <20230721094043.2506691-1-fengwei.yin@intel.com>
 <20230721094043.2506691-3-fengwei.yin@intel.com>
 <CAOUHufY2tdO0JNTiY=RzHitR7CB1cM5kA=7bd6nbCUW6KM_OVA@mail.gmail.com>
 <05bc90b6-4954-b945-f0d8-373f565c1248@intel.com>
 <CAOUHufYJE40wcT4HTYFJ_7X5=my3OPbMyMBt+QNZdByuL6j58Q@mail.gmail.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufYJE40wcT4HTYFJ_7X5=my3OPbMyMBt+QNZdByuL6j58Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH7PR11MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: cbbbaaa1-5893-4f3e-4131-08db8d930c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQu8fdwbXNZoZOGWshpYngvvmfUPWYh/vAra3/18MihCDil4PbOmdQoQwQsvr2kapKyi/titAFM5oIesUKR+4QRZCMVidZsOmf272pekcIZbvPOJQi8gApxlT+wQcQE8cIr7ubJytVqhMbw/wkoWNGbRXDSSMtodXdvZsPJQSji959HiVP9s9v21Ra+9AbrNbzrF+742Qjph31pw7vqoD/xanYwikHvgkxkD8nIyvxvhhu/ffLb+CjhS9ZhpIw3CaEz7tWUoo9VhPcDbbh9lgPd+Ecwx+Oy+9tkfhw8QF0OjcziBYgxaKC8+Or/ZDF/5LY6cxqbr1ahkl1qe3bMoeBgq7CwUeSXyWZ91fv7Woj7xLBcmlPf7Tb67L/UFXf0g4l7E0iuYAVFCZx8VUJuP8FqB9U0z6VuqGIbvKCaUUrx8JVu0uVA8bb3z1hoLGcLBNcv7Ux9Agx0kdksgFmGLZ8Ohnv71nk8aCBVKFP5eYLNF3ov6tU2mj22xRX1+3hegT2q95kJnlEOZJyS25D3+xJpdSBGZE7edT3IcyVR3euVJseW1aQWOgvQQt+6HTcv4Yz6q1UU07D6mXohIIKu0SDVRGTAFQd8yJZRhS8K6sN7In3FFKHiAkjGbApjmF3gB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199021)(186003)(53546011)(6506007)(26005)(2616005)(6916009)(83380400001)(66476007)(66556008)(4326008)(66946007)(316002)(5660300002)(8676002)(41300700001)(6486002)(6512007)(966005)(8936002)(2906002)(478600001)(38100700002)(82960400001)(36756003)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L21QVnlqV1JKWEVHUXptMDVLREhCOUNFTUtqQ09mSzBEN2xkVHlYSVdkby9R?=
 =?utf-8?B?Rk0za2tUcHNRNWgyVWlPZThOc2x3UUdlV1JXa2NMZWZsUzFwRCtDbDZUclZW?=
 =?utf-8?B?eE5uZjZDaEpZQ3E2Mm4wQXczS09LSEE1bStOdlg1Nk5WVnRHSEtHdWE5WllT?=
 =?utf-8?B?Q3NYSGhTV2lVdGZRUy9xRVppaWJ0UFVvSkZyNWpqbW9QamwxZXRwSUVPOVZL?=
 =?utf-8?B?dTJQYXRONnRab0VSbFFkN2RZdE5YMEhGR0dzeEU2MWllL3Jac1JsZmFWdTF2?=
 =?utf-8?B?M0RDcTBJTHhOM2FhSGdkV0cvK0ZzWGh6QzZPcnR6dFovNlg4SEdURWMvQTU1?=
 =?utf-8?B?ZFJocXlOa3ZRQ3lGUWJaOThSNnlzaUZ3TjJsYjFJTkRqUFFCRU5rVUJ3TGc3?=
 =?utf-8?B?VTFxcng5RTU1dGZweXFjNUhZQ2dSTE5qeGhnY2twelVDN0o3T1d3eGh0MkQ5?=
 =?utf-8?B?M2EyOFd4TW1UNzV3VW1ab0pOdmk2SXFjRTNpNndvS01SVndiVFZuenhlRExq?=
 =?utf-8?B?OGY3aDgyT2ZCbHAxcUhRUzduVzNZT3labUo4VUdYT045c2FCb0pmUmVidWJ4?=
 =?utf-8?B?dzFPaFZqOW1SK2hONXdVTFIyVkIwNU5PUGhtZUo0d0VvTzA5TzVETFJrUzBD?=
 =?utf-8?B?enFXTDVrbE9uUWRUUlhXTXM1R1JGaDlnKzd5QkNXZHhRdjQ0dmtiQ3lnRWtF?=
 =?utf-8?B?Q2l5WHE0VmpDalJrSE53dXpPeWJvMTBuMm40Z0JLVTFBeWZpTUp0alV1WUkx?=
 =?utf-8?B?N0pzU0hjK2NBSmVyMGM3dGE1cTFvR2hJZFFlaXFQTml4VEgwNi9vWEM5WmZL?=
 =?utf-8?B?ZlErMnZseEZqcm1nZDIrb3M2MWlNdVNDQ0NSSHZwT2JhYldRK204YTlQUnNz?=
 =?utf-8?B?WHlIZHNzYlAzK2FWWDVUakFvVXlzQmROTDQyQWZ0bWptS3lDR0UxQk1xZmxH?=
 =?utf-8?B?dTBBYmx3UXRUaUZtRm9lRHAyWVIwK2wvTkJTQzIvWU1Sck1XOVM1T2sreTA5?=
 =?utf-8?B?NlU4SWozU3pnSnU2V3BVTDB3Ti9TMlVGb0NVenZySVB6YU1vcjRHaFFPN1ox?=
 =?utf-8?B?aEx0a1pzdGw2dEtTaFMxUzBZZlAxME9kWlpPNTRRNW0zRDlmMHJYV2t3RUZ6?=
 =?utf-8?B?TWNaQjVnSUp1VDB3R0w1NHNBS2hIUE1ZTUd5YmVLdnNiZGVpWlJ5R29ra0Y2?=
 =?utf-8?B?UjlkRXNxckUyVm1sZ29sdnFNaTJrT25DWDhENU5Wa2ZaS3RHd0hCbXdaN1Av?=
 =?utf-8?B?bmVTK2FsK0R0NDNkOE95VkNlbVJzRmg1eGpZMnViVUtNU3dDb0FSUDRTUVVG?=
 =?utf-8?B?aWZwY1gwQ1B0d044Z2dNalE1NG1hVmtkRWZHdmtlMyt6ejFpUzd6eElvTVJk?=
 =?utf-8?B?NTJNRU5GYXNLQU5TOXZONVN6Z0ErdnhIK3FaMHJWZFpuOWQ1cUlOdVpwYnBI?=
 =?utf-8?B?YXRGd0pKOTNQWnRlci9EMVgwdFZVS1RiODZvMkRabkF3SjZMSkNPU21qUjJv?=
 =?utf-8?B?R1ZFU3lVVm1xSEZIa1YrOHNBcDNML011ZU1JWXJzYkUrY0I4Q2x6MFU5QlhL?=
 =?utf-8?B?R0pBWGcvVjZub0s3dElmTkg2WnIxbTlCZGZQbEU1djJzYnhMY3ZOT214NWNw?=
 =?utf-8?B?VXNvOUN5L1dTMkU0YzhINjlQVTg1ZklxVzR4Y2gwcjhjQURnaURPclVPbm96?=
 =?utf-8?B?TGh2UUpCZTZTTEJOK1d5K3RQZXhMcDRLZkRiTzFYN1NSTlU4ZWVNRXl6a05x?=
 =?utf-8?B?UTBVYmx6WmRjc1lvaFM5UHdYRk1pZnNFZ0Y1dy9LM3RVNVBYSGYxd1lIdldj?=
 =?utf-8?B?d1NRRDlkWmNJKzRqRFN4MWZYYks4WHhMd1hUK2FhMzc0TGgycVkxOTc2a2E3?=
 =?utf-8?B?T29HZTB6eEZqNjVGMGxwL295dXE4aGI0ZlB4QjlPbisyb3R0aWJxVW5Ya3ow?=
 =?utf-8?B?ODVTNHRVcVE4N0hsbXlwMVN1NVdXUUdaeDR5cnlKeUNGL1N1cnZ2dkNQRnMx?=
 =?utf-8?B?SWIrVDI1bjJFSjE4Wk5LZHpwMmtXcVhYUlhzaUtQbndBMTl5Q2RaamFjOWdO?=
 =?utf-8?B?SkVLNHl6d21CS01xOUw4aEE4UUhzb3NtdVpsMG9Kbk9jWEE0U0h5VHdvVjZV?=
 =?utf-8?B?MEwwTFI1cHRzTmxreW0wbGs3ellCWncveHdxcjBsYXpRbENqVUh0ZHZxMWNy?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbbaaa1-5893-4f3e-4131-08db8d930c8d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:44:51.9555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFBHhmxZADlkHoRq9RnKWsjYDWij5IvpNn+MmNKBOXS9oT6zCDwYSm/h9y+X0CsC1UWEXQYmo/6IDgHfFxXtJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8479
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/23 11:26, Yu Zhao wrote:
> On Tue, Jul 25, 2023 at 8:49 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>>
>> On 7/25/23 13:55, Yu Zhao wrote:
>>> On Fri, Jul 21, 2023 at 3:41 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>
>>>> Currently, in function madvise_cold_or_pageout_pte_range(), the
>>>> young bit of pte/pmd is cleared notify subscripter.
>>>>
>>>> Using notify-able API to make sure the subscripter is signaled about
>>>> the young bit clearing.
>>>>
>>>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>>>> ---
>>>>  mm/madvise.c | 18 ++----------------
>>>>  1 file changed, 2 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/mm/madvise.c b/mm/madvise.c
>>>> index f12933ebcc24..b236e201a738 100644
>>>> --- a/mm/madvise.c
>>>> +++ b/mm/madvise.c
>>>> @@ -403,14 +403,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>>>>                         return 0;
>>>>                 }
>>>>
>>>> -               if (pmd_young(orig_pmd)) {
>>>> -                       pmdp_invalidate(vma, addr, pmd);
>>>> -                       orig_pmd = pmd_mkold(orig_pmd);
>>>> -
>>>> -                       set_pmd_at(mm, addr, pmd, orig_pmd);
>>>> -                       tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
>>>> -               }
>>>> -
>>>> +               pmdp_clear_flush_young_notify(vma, addr, pmd);
>>>>                 folio_clear_referenced(folio);
>>>>                 folio_test_clear_young(folio);
>>>>                 if (folio_test_active(folio))
>>>> @@ -496,14 +489,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>>>>
>>>>                 VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
>>>>
>>>> -               if (pte_young(ptent)) {
>>>> -                       ptent = ptep_get_and_clear_full(mm, addr, pte,
>>>> -                                                       tlb->fullmm);
>>>> -                       ptent = pte_mkold(ptent);
>>>> -                       set_pte_at(mm, addr, pte, ptent);
>>>> -                       tlb_remove_tlb_entry(tlb, pte, addr);
>>>> -               }
>>>> -
>>>> +               ptep_clear_flush_young_notify(vma, addr, pte);
>>>
>>> These two places are tricky.
>>>
>>> I agree there is a problem here, i.e., we are not consulting the mmu
>>> notifier. In fact, we do pageout on VMs on ChromeOS, and it's been a
>>> known problem to me for a while (not a high priority one).
>>>
>>> tlb_remove_tlb_entry() is batched flush, ptep_clear_flush_young() is
>>> not. But, on x86, we might see a performance improvement since
>>> ptep_clear_flush_young() doesn't flush TLB at all. On ARM, there might
>>> be regressions though.
>>>
>>> I'd go with ptep_clear_young_notify(), but IIRC, Minchan mentioned he
>>> prefers flush. So I'll let him chime in.
>> I am OK with either way even no flush way here is more efficient for
>> arm64. Let's wait for Minchan's comment.
> 
> Yes, and I don't think there would be any "negative" consequences
> without tlb flushes when clearing the A-bit.
> 
>>> If we do end up with ptep_clear_young_notify(), please remove
>>> mmu_gather -- it should have been done in this patch.
>>
>> I suppose "remove mmu_gather" means to trigger flush tlb operation in
>> batched way to make sure no stale data in TLB for long time on arm64
>> platform.
> 
> In madvise_cold_or_pageout_pte_range(), we only need struct
> mmu_gather *tlb because of tlb_remove_pmd_tlb_entry(), i.e., flushing
> tlb after clearing the A-bit. There is no correction, e.g., potential
> data corruption, involved there.

From https://lore.kernel.org/lkml/20181029105515.GD14127@arm.com/,
the reason that arm64 didn't drop whole flush tlb in ptep_clear_flush_young()
is to prevent the stale data in TLB. I suppose there is no correction issue
there also.

So why keep stale data in TLB in madvise_cold_or_pageout_pte_range() is fine?


Regards
Yin, Fengwei
