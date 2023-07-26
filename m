Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140897628E0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 04:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjGZCuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 22:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjGZCtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 22:49:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A370193
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 19:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690339788; x=1721875788;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fJy4Bvui4l6vCDJUcAuHl5yJfE8yedirz564Rlz24VE=;
  b=HGBH5jCIq34/ZBlNnKPcXEJmXwJ/0iVCRx4l2Los8ODstqjHm0PzGXxP
   /QSIZgYrbvGrhAt8EhKUsZsEpujvnuONatwjr5v9nXzt8LLImgumsYHR1
   jQlNoOMl+Pn1lNh/DrHX4nY4/h/5J+jjQqh55fRy9lk4LgaG1y0YWgfPt
   iC5xJ/Sk/vUN1DENEl+rmA6OxkS3xvGdryTZANVQsaahKs2VM5hgCyM/z
   Dnj9XCFl9MPsKiedE6Zf6wu3fZ97N5j9dHhlSFP4j9KOtl2GUMSmB26nK
   jpwyY4OoYN5q6hEIq7Pg54dXMORtvHdSDGOlSryrOgn/tl9yyq0rw2/Ay
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="367920664"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="367920664"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 19:49:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="761459589"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="761459589"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 25 Jul 2023 19:49:47 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 19:49:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 25 Jul 2023 19:49:47 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 25 Jul 2023 19:49:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHdR0ZyXNLRnGvCROuW76gWL3HbRhCw3ZPD1ztHYq2f48SmvJSaPTA3vEI//lK0ptd2eXjfvzcili6Ht843Br0gMi1oNF6jC3km/FximUxm4m2FgJg/dSoMHGwZ5/iohWCksDRz0xQGyJIydBhzmDbpTt0Hc5ETbZIWCv1mntm+9tc5RijH4JPJMHGX0i0E9flZnNqJvxi5sUej03mMVgHpdCwIWOSYnnib4ZryeUnyj0h2htR7xFGZFLxksr2zcllzx7gBeyPXs3ERX28KgyTPwHLboEHhmCufyBjr3YycO/yvzgQ06tpp9+eXDZ3GsqvdaP3y9+5nX8i6bLxoJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArQfDI2veyAwQ+XtaQsgCXW1PaWcPjoOWM/IN4O5pAg=;
 b=MQFe8mPR22QpI8va2u1HDXrXvAfIkl26UEnLaR0Bjzr4YUy6OrjTkEoWzE16kRPSShRWxgVxFbRjGCrQZgSijFnfw1W2TrYp5KN01M9m6ZdpT5Ldk39GqYigwC8jhLihhMgQ6A8aYuH9gwNE+BtXiLPskC1BAGjfF3sAywiYVxN6SiOQsUnlGNj4BjLhFo5L880kPGMg04+S8CWFpICk9+frdmv+B7KDv78WaA/V6Zqb2ggcHT5r2B6ah7afLdVolel30VHOjQCuax8Y4IjttKpHRa1KHm+DwUd2Y0b/4S5rcRUCFe7pWiXKM7dNwWUMj3GpNtd0qgF1ZyV8bfmiag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS0PR11MB6496.namprd11.prod.outlook.com (2603:10b6:8:c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 02:49:44 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e%5]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 02:49:44 +0000
Message-ID: <05bc90b6-4954-b945-f0d8-373f565c1248@intel.com>
Date:   Wed, 26 Jul 2023 10:49:49 +0800
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
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufY2tdO0JNTiY=RzHitR7CB1cM5kA=7bd6nbCUW6KM_OVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096::25) To
 CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS0PR11MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: ffacb418-f518-4c76-cb8d-08db8d82f77e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kLT9GLOjHQQSvDK2omRpXyAzbiILTOV0tgj1qQ1IU8PPtQNBkebuGIvmhOkJsTUw5JwmuzQyQA1ED3TI1AoofGZJlItB4WioRkTrEICB9SxGPMCxWnjgkRS8CSpANJJeBdhCdMGcd93P0Acp9WNwPCpr/uzZHVN6pqznpeyfsTT+/L6MQtQ3CErzkKhj2I7VEE7JhKQ4EO5AKZjD9M/q67QqHoDkze3D0UjCWvmhS3xss0NJ5WJvyoB2CWriyoAofc9Itb5Y1n5IJWJnkFET4Tqka4MiaV4FLqRB9nQVrgsVupekOpwNvvwMDcY+JBLaEd/JgVqFNOG9m9dJpuHMXpPYO1aDszHb9gT3TKyssgJEvMQVLgdxo2NBmhesUEnZ0xcZo7Cbk0IRcg0RSvNoUhiBnd4CZCcWnFHGOJGoMCjMEE5axaRHJctT2Z6IDZpFeGZmtKTcCiX3ikvq8iJLN5CKXhFLSXu1P0hvk0AeWgfw0xYvx5OiZMv4VksaruQV9EYChhHqKf5+TWsoSsPiVgMsQh2nl1oY/Qadpe5yJ/Yi1xd7h1ad/+hYin2SXB8SM9F12Gv6x6TgtzE7BQRj6tEG8pS916UV/hFrjt9rJrwyXM05wr8nQN6rbfkNTYuZZw+4u3saiTYjfdGFL3vLLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(186003)(26005)(6506007)(53546011)(5660300002)(31696002)(36756003)(8936002)(8676002)(2906002)(2616005)(82960400001)(86362001)(38100700002)(316002)(6916009)(4326008)(66946007)(66556008)(66476007)(478600001)(6486002)(6512007)(83380400001)(41300700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDJ2YlgwY1U5UzEvYlk4SXVSSG9VWGNudXB4L3FoYWVEQ2V4eGV2Sk84TDM2?=
 =?utf-8?B?d0tSbWdWcVROZ0FJV1BEaURLaW92ZlE0UVNFa0UwRU1xVjdvTEZVdkRqRENW?=
 =?utf-8?B?WTN1a0NmZ2JiZHd2Y0VGRWdPdDc1N08vK2RGd1hoVEllamhGL1JDRWo2eTZj?=
 =?utf-8?B?MXJQRHlaNFpPbmsvUDZnekhjN3ZLbVNOTHp1YzRySmliT2d0cjc3bzcwaTlq?=
 =?utf-8?B?M3ByOWVxRElRdUZJdFAvOTNvb0tIMExVN0lQcG9QZzM0T0NJdVV6ci9DQWdv?=
 =?utf-8?B?eFY4Y2lpUC9mWks4NjQzVHptSE9iRm5YblRWd1FGeUYxcUlwaDZVdWFZMm5G?=
 =?utf-8?B?RnpsWnZvRWR4YnRMNlJvVjdDVU02cm1Wdkk2Rkp3YmxEL1VWV0U3WkRZU2tj?=
 =?utf-8?B?bWc3d0lLYnVZVHU1eGhHWVB1ZzNyWHZ6VGUvWGtDdDBGM2MvWXp6azNCOEpp?=
 =?utf-8?B?M05vWVN0dGpVQmxIdEREQWNWNlY4ME5tbFpYeTJvL05xMHVmdVBndU43N094?=
 =?utf-8?B?anliY1pDbTB1SkNPbGpJMkxLS0VJcGRCSURUb0szQ01aSjhyY0dKQWRsbVVp?=
 =?utf-8?B?c21Ed1NwZHAzMzlqSVprU3hyak8xanlidlozR3JuU0NETllpaE1TY1JnMUpZ?=
 =?utf-8?B?YUU5eVNaRWw1YmZEelVLOFp1emRxVnZjOWpDRG9pT1BGOEpaWU80U01JaEZU?=
 =?utf-8?B?MFJiUytoWkZXQVN0eFhoOW01QXJGMkJSRHYxZFZUcFk0VVNhckQrNEpLYms4?=
 =?utf-8?B?Z3J0R0pxZTZpRU4ycUtvV0pUVW9RanIzV0RKdk04RjNpTmVWVE9RNzJKd3RP?=
 =?utf-8?B?K0thOXlQWU96MnZlY29wTkZvUmprUWtqRG1aN09PdDYzVlRRZUl0Mk5EL3dF?=
 =?utf-8?B?aWtFdDN4ZDFSOTM3OXVLbEJrWjJ1dDJUTmkvMnFJekZYeG5Fak5yU1JmZm92?=
 =?utf-8?B?bHBNYXV2Ulp2cVlkS1hWM2twMGlrWHpOUU1pYXdtYkRSZ0syVjB0N3JRWk0y?=
 =?utf-8?B?czFvVmV1QTdrdkJFYnRjWGp3NHF5Wmw0MERxZEpaTzZlMUlyVWQyVS8zNlo1?=
 =?utf-8?B?NXRqMDVtRk83ODhXZ1dvQ3BSRVJDUmJIa2grbzRlY0l3bHlySGxDc3l0dXpv?=
 =?utf-8?B?UlZ3Y1lwVTE3aVJ6cDV3ekluVW1YK1RnSnVYNU1hVjlTalBhREhvUkhGVHZo?=
 =?utf-8?B?ak9JSjVoYXVpSXZZR2pKZ3NaTW8rMEpjbU9IenJwcmp3VGVBbzJ5aGpkUnNq?=
 =?utf-8?B?VTlDcWVlcVN4czFUOGhEcnJCcktSd3pUM0NBTktzT0owdWliTU5naFByUWt6?=
 =?utf-8?B?S2RHTytRMUx5QXJSMGo3V3hKSGE0THNGVEZLbVdxbHpXcXpzQ0NiYkMvVm5I?=
 =?utf-8?B?QmFlN1R1eWx4Qks3STR5L3hrZzV2SVZGNUl3aXRxeElKMjRkSFczODJFNTdM?=
 =?utf-8?B?TndQM0VDM01GQk4yalpaMjlXbnlGQm12YVBtOXVBbythZytzc2RhZHZEbXhq?=
 =?utf-8?B?V1VxWmx3cDVMOVVsSE1Da1M4cGhwaEFaWDB4b2ticGVZZmJWVTdId3d3V3M0?=
 =?utf-8?B?aHUvNFd5ZXBYZlBRV3lLSXI0blgvYjMrNzkrQ2hRd1pQWHBWTGRVZ3hJZ1Zy?=
 =?utf-8?B?MFF3MXBQcmREK3NJRnVQeWlwZUtmenZnQ2x5SGgzZGgwQWQzTjE4QzZ0TFdm?=
 =?utf-8?B?ZGQySzdHb0ZuTG9JM2NBK215UGo4SlVpVm4rRkxJTW5tSGtBZFN0M2xTRHo4?=
 =?utf-8?B?YTdYVVdKTHViUUppcEhEaXBpMkdhNmlwNjhDZ0tLaUo0VHRmL3o2MkpsQ0Y3?=
 =?utf-8?B?c3E1RzRIei9HQjFseENMK0d1a2JENjMrS2lxUWFRZjA5TDFlTWQ2bWp1Q095?=
 =?utf-8?B?NTk1UUZ6Qlp3UzZPcU5jWE1Xc1hTTzBINDZ0ZDhBRHdWeEw1K2w0Z1FlK0dQ?=
 =?utf-8?B?QWJ1T0hPTzQ3M3hpcGdxTk9Od1BJQ0dacE5rT1pTa3RGSkppU3NqU210REs2?=
 =?utf-8?B?ckU0S3VLbVVnMG5JVFhtaGRqdkNpQi9acmJISTNIUW16NkRkKzF3QUdkRkNh?=
 =?utf-8?B?SGMySEhlN3E1cyt5ZkMvVHJOQjY5MTVFOHAwTjk0d3NQTmQ3UlFxdUx3cElC?=
 =?utf-8?B?dElRMnQvVGZCckF6bFVGZldpSjk5RUg2eDZnMG9DSFROMXV6SXdidTI0TEpD?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ffacb418-f518-4c76-cb8d-08db8d82f77e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 02:49:44.1590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qMC+N/51Z7PAYLbkgXhyeCBQESPDELLxs2Ws8zHlulR0LvKDJfVlzociOdJ8sxGyrh82TMAz8nue6byS/nemg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6496
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



On 7/25/23 13:55, Yu Zhao wrote:
> On Fri, Jul 21, 2023 at 3:41 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>> Currently, in function madvise_cold_or_pageout_pte_range(), the
>> young bit of pte/pmd is cleared notify subscripter.
>>
>> Using notify-able API to make sure the subscripter is signaled about
>> the young bit clearing.
>>
>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>> ---
>>  mm/madvise.c | 18 ++----------------
>>  1 file changed, 2 insertions(+), 16 deletions(-)
>>
>> diff --git a/mm/madvise.c b/mm/madvise.c
>> index f12933ebcc24..b236e201a738 100644
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -403,14 +403,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>>                         return 0;
>>                 }
>>
>> -               if (pmd_young(orig_pmd)) {
>> -                       pmdp_invalidate(vma, addr, pmd);
>> -                       orig_pmd = pmd_mkold(orig_pmd);
>> -
>> -                       set_pmd_at(mm, addr, pmd, orig_pmd);
>> -                       tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
>> -               }
>> -
>> +               pmdp_clear_flush_young_notify(vma, addr, pmd);
>>                 folio_clear_referenced(folio);
>>                 folio_test_clear_young(folio);
>>                 if (folio_test_active(folio))
>> @@ -496,14 +489,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>>
>>                 VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
>>
>> -               if (pte_young(ptent)) {
>> -                       ptent = ptep_get_and_clear_full(mm, addr, pte,
>> -                                                       tlb->fullmm);
>> -                       ptent = pte_mkold(ptent);
>> -                       set_pte_at(mm, addr, pte, ptent);
>> -                       tlb_remove_tlb_entry(tlb, pte, addr);
>> -               }
>> -
>> +               ptep_clear_flush_young_notify(vma, addr, pte);
> 
> These two places are tricky.
> 
> I agree there is a problem here, i.e., we are not consulting the mmu
> notifier. In fact, we do pageout on VMs on ChromeOS, and it's been a
> known problem to me for a while (not a high priority one).
> 
> tlb_remove_tlb_entry() is batched flush, ptep_clear_flush_young() is
> not. But, on x86, we might see a performance improvement since
> ptep_clear_flush_young() doesn't flush TLB at all. On ARM, there might
> be regressions though.
> 
> I'd go with ptep_clear_young_notify(), but IIRC, Minchan mentioned he
> prefers flush. So I'll let him chime in.
I am OK with either way even no flush way here is more efficient for
arm64. Let's wait for Minchan's comment.

> 
> If we do end up with ptep_clear_young_notify(), please remove
> mmu_gather -- it should have been done in this patch.

I suppose "remove mmu_gather" means to trigger flush tlb operation in
batched way to make sure no stale data in TLB for long time on arm64
platform.


Regards
Yin, Fengwei
