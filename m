Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D072575318E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbjGNF5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjGNF5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:57:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24EB2D43
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689314261; x=1720850261;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RhSIDjPG1IanV8XetG02SA0ewq04owzjJ/9U8wufnEY=;
  b=cRbqs41W1inJSXSodkOivz9QI08zR/Yyoat09itP2mRDnjafRiaae9+A
   2HOBMxvbjIIdSvXLWjAdkHITkyOdj3uhjyy7x/UyHW6IRcZxk7R/7rgY4
   AFppO+Xhu2GyrkAvnzQS9I1799+RXFEsyV8/UT9zu2mvWiwpkndWwJUvP
   N7uA5nmFTMhNdhAJoX39BtMQ7XwoUTC/gOupcjeNSO0LxPT2vnpqvJi73
   EONXPqPy/AFhcdzH1wmcVMKIPWzcuunmPhwuDRrpC8QFSRwNJhYFKrhI1
   pFi33jDbuXu53V6ilvAfkZF9ueaD1D/2Fik/I9Y9NoTp4hrAqb8c+LFWr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="368039328"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="368039328"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 22:57:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="722272069"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="722272069"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 13 Jul 2023 22:57:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 22:57:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 22:57:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 22:57:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 22:57:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dyf43f28mY3vQrs3qsNbOMO7FhgcxlZu3Gv2YGw9LSkfLyv707v2u069Jy4VD/UmwDvMLKByN1OGESnHfKvV5M5crvTKxg7IARTeTds66RkxDvoRuEYMYGpDLV/1uiitBMq+ihzbtnvDjznhW32SkE3Nc6dn15yeSldy9VpmY4dN1n0X6J7VmB7lRLH9GqCTvNJht9X/GouOBnLEvfrv3rZMNeFKYmOUncCpr0/5RA/qJ94o1L0+gJBIlO0MW9oE1/JZPQPvbDYTYdMcRNsG9gDhv97x97VzAREiSZ/hpKgMe5Ub03idTeIexixFrXE32LGFH8DIZNPFG6la/nH6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbL18O8nHKCWkQgj8g9jb9BjTmuMOHD4B8q4KgRkMN8=;
 b=RnWiMa+jgnK6mUDL2Len0YSlRHvZHUAAPP3p0sZRphL7DnUepi7/UXoEYY2m8GGDOjyAt3zOChYpnUlhiqniMBHcQ4jR9zacZ7X5Hd/J1ULVAlm5DKLX2+7FF9UznJw00Bt/RMrdMSQ0kWz3JdqM3D8D0fR7MLWLkz0lt0fLo1kUSuQeslUP3bpBHvs/V6ruupHEnNhMS0Ob/oztf7LcgEEN6SE93Hm1QAqnJOrS+aDpRKb8IIUQjWvCW63DlDWzJ6F71dHUHL0aHglHgElVPkg2+jMTELIcXaIMcqKW054Q61UnB/8Xsv2clU7fJEyt/BbTQE0UPR8vI6MYrUKlnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA2PR11MB4810.namprd11.prod.outlook.com (2603:10b6:806:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 05:57:36 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 05:57:36 +0000
Message-ID: <7e09d69e-50a7-04c5-0a40-065e2d6fd658@intel.com>
Date:   Fri, 14 Jul 2023 13:57:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] madvise: make madvise_cold_or_pageout_pte_range()
 support large folio
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <david@redhat.com>, <ryan.roberts@arm.com>, <shy828301@gmail.com>
References: <20230713150558.200545-1-fengwei.yin@intel.com>
 <CAOUHufZBoV-ujMF3v60Sj4bARb5vRg7cpcRsqTiKHB4CKZc_fw@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufZBoV-ujMF3v60Sj4bARb5vRg7cpcRsqTiKHB4CKZc_fw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA2PR11MB4810:EE_
X-MS-Office365-Filtering-Correlation-Id: d4c60835-7aaf-4352-4d5f-08db842f393c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2+02M2i5kaElRHzv7sLttUu9dpGdlG/6NZ6gyXSpWX7x36snIqwD4ynelBPtaEC1k5OE+gG7UUC5IpZzTQ7Ilrm1ad5ClVBQZdjpeEafw0V457WH5Szo/XPwW8nNFmhU+8ymdOlZ14XTBfbWNI5GUmdmv/X31uqhLNzqImBD+xcxTv2BKtGdE8oTYFDIsqm2sgSzatNd/0MRBXOf/yau80UlIvBrX5+xNDCXim4h56308NLYgRm7w7inWGQ54RAXRjA7h3CUG3Lh9FYXsjFO0fXDVU/J5Ksv+EARhfj505GBZrYAkJW99Pg7ZwvhR3V5Vrdw4pNIdUeL+URGVqE5CnTfT/Rcy/EXybq+3gzYW4C9YS1kVxXswQh9EovTJa/rZUbLg29Y7ldQz2p8fMSxXw997k4wGXxnoJq7NHLnP8yp3U2WQqhACIdYDXzWXAX16NaPgaBsXrWZdq4H2WQZf6mfS8CcDYYD/eVBkw1tLHhNPCn92VYnnT6KTdkC5DjVTX7gK50b9nalWNBPk76sjUka6n3RLMgf/y9kgsG17Vz/qPsg4K8vTAgz62QHt0r7GIHYj0dnFh1V/k7eUlU6y3eivO9F0bqZeRqOwXIm6YDpV9R3OXDSLQNgthu2h/SZCjGCYc1pq1VAw5YfJqJ/SA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(41300700001)(66476007)(4326008)(66946007)(66556008)(6916009)(31686004)(478600001)(5660300002)(2906002)(8936002)(316002)(8676002)(6666004)(6486002)(6512007)(31696002)(86362001)(82960400001)(26005)(6506007)(186003)(83380400001)(36756003)(2616005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGhqd250d1NYQnFaZ2tlYnQvRGJBQ1FWbE5OZ0JOZXcvYUt2UExDQnlBSlI4?=
 =?utf-8?B?RGpvUjRUK3RmVXBDUUlZRVJmc2FRWGlrMjlUbGFxZEQyWXVtOFB5SkJNekx5?=
 =?utf-8?B?U1RFaUlMN3pLaWY0L0kvS3IxOUhHcTkyd2xiUFFDR2tzVjg3L2pwWWR6b1h5?=
 =?utf-8?B?bWdWeTY2ZkVLQzRDUHdSY08xdHBwOE9ZV09UMWtBR3R2QjNISWRsSTVMUE8w?=
 =?utf-8?B?YnhxNUNrM1lIcGxRd0FvQjBHQVNGeHQ0QkhnTHNvQTVaUTc2WGJ4UHRGZlM4?=
 =?utf-8?B?Rm0yMmtORzdGcmRmaXQzT0piSVl4NEV3UXRhU3MrZTlPekpLOGJtWG9NZjdY?=
 =?utf-8?B?a0c0WG56UU9yWGtPVHZuWlJVbyt1dGxCRUtOZTh5V2VZL3FidTErNXRNbmdO?=
 =?utf-8?B?YzZFdEpicG5URUI1TnNzSEh4SS81SXAvWGtYWEU3YkdOZG1mOGFkOHdVeDdX?=
 =?utf-8?B?NTA3QUxtOG5XQzRnemk2RUFBa203MloyUDE4d2o1bkFRUG9BYkR5M1dEVHdJ?=
 =?utf-8?B?cDhTMVYybnpwRzlOOVZmUzEyS0VrRU51dHhQbzdGck1JNTBRZDFTQVVCZzRQ?=
 =?utf-8?B?MWQ4WS9ZZEJtaG1vYkYxWFpYSHZ3NDNMNzh4eTIyUkJ2KzhTQXhXZzZHcFdC?=
 =?utf-8?B?RXBxZ2ppWXk5SjJRTmh0TGhjUjUvUUNvclBvK2ZrZDVFdTZNeEJHMEVMNlpr?=
 =?utf-8?B?NGJCbWZtKzhSS1BkOThYY2dRYnEyTW5FbDUyOHk5K2NpTDNKUk1Dc2Rtajdn?=
 =?utf-8?B?VzYxS1RRZ0RQWGtGYml1MFB1NnZSNHZxMFpCcVNvcmVDT1FxVWtVMUc0aUlE?=
 =?utf-8?B?dk1mcjdjR1F0NGY5aHZGOU4yZ3pHSEdGVDhKUGkyUjdPcVJVZnNFcEJGVmo1?=
 =?utf-8?B?VmpBNUZTVFNYdEdOT2VhemplUzdhU20zRk9vc2FpT2dDWEpsZCtBaDZQY3Ja?=
 =?utf-8?B?bEw4RVkxKzVFY3hwbDZKSWNxZ3lzRUZkcVhoVTR5a0FCWE5RdVprMGRmMlVM?=
 =?utf-8?B?UGpQVCt4K2RudkZmcXpZL0hyVTVETWNOQjNGcnd3N0Q5T2piVzhzZGtsYTF1?=
 =?utf-8?B?R0EwNXpJRE1pNE9QMWhPbEYrbzhvRlF3RGRZUHhEZUxGR2lML0lzWDA3dHph?=
 =?utf-8?B?Tmt4bEh2bXoxanFuL2Z3M0k2OFZXWURMbS80MU5IZytCcFBKNFlzbENnNFlp?=
 =?utf-8?B?dWZzNk40MzBoN3RBMy9MUks5Y0lReHQ0RitUWEZmUFBKTzRPMllzNHZNZ2lT?=
 =?utf-8?B?eFFBMlM3eHNtVTZMY0N4YUtrcUtkZXc1UzVQblJBdTdYallsV2F4bUk0Zjgx?=
 =?utf-8?B?SDZMWUVUQ1NQVWh4VEFFYmM2SWZEYXprdTJqK1dHZDZZOGdsOWZmTTVOQ2hz?=
 =?utf-8?B?bHl2VGtLaWNObmNOOG4rT1FIelcvTDMwaGJlZlpNZEtGUmpiNWhlMzlBaU9u?=
 =?utf-8?B?cWFIU3BtdWd5L2loNFFEZUljNm5DaWxiTjNhU0hpZXN4UzQwNk51YjNvZmlW?=
 =?utf-8?B?Y1hZSGdzeXNuS05BQkdsckR0cDkrcnk4TTR6QVJsdFNvM1hEMDQ1bUJMLzVs?=
 =?utf-8?B?Vlc3MlRkV1JJTXp6VXZSb1I3TzV1V216WHRscjFia29hY0hZd3RuRVloRUhm?=
 =?utf-8?B?bHk2a3kwQ0tER0ZUaHR1NkxsbjdnbElwVENFdzIxMC9wWjY1L09SZFdIT0po?=
 =?utf-8?B?ZWhrcnEzc0tQVnNaWUVNSGRaTGNwSnVjNDNrR3BpTitUS3BlVXhrL2lTK0ta?=
 =?utf-8?B?aHFDYnlmVnlYS0xkdlU0L2lRdDZDeVZ0VHdiVllpbVJPaCsyejUvV3JoeE41?=
 =?utf-8?B?ZjVqT0dDMTRYYzdCNTdpc2Q3WlVNOXV1MmxUcWdQWlJsQTdWOFI4aGNRMkpl?=
 =?utf-8?B?dGRmSGZhOTN6OVlVSm9ZRzY3NGxtaVlHQ3RVeStOMkVuNUFvdG5zVFJoS0l1?=
 =?utf-8?B?WlFKejJ1RTNES0dSTWZFNTlTamdEMGZFeUJuay9KN2ZvWXVRcTlCVy9mQWp3?=
 =?utf-8?B?ZmhMQy9Ocmk1MzZYVHlxb1lhZWovQkdvM0FnVGszUDhiNXRCTVh6MHhPRGsz?=
 =?utf-8?B?cVRlalBudmRqUDZXaTdPaHFoNGREK0VjdmRqckNzV0swRTV5TStFRUdjbkNI?=
 =?utf-8?B?V2xHbW13WCs0aEhkcGcxM0M3aDJsU1lTc0I2S3ZJQnIzd01hUjI1SjdvTkhn?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c60835-7aaf-4352-4d5f-08db842f393c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 05:57:36.5707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ayKu8lAaizoxsFk1LWLad9zB8kFoXBwr4I7/AMkmdEUWMkcNUHNCFY50WEOnYqxywQ93OfPY06Wj0N+8wv/Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4810
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> -               if (pageout_anon_only_filter && !folio_test_anon(folio))
>> +               /* Do not interfere with other mappings of this folio */
>> +               if (folio_mapcount(folio) != 1)
>>                         continue;
>>
>> -               VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
>> -
>> -               if (pte_young(ptent)) {
>> -                       ptent = ptep_get_and_clear_full(mm, addr, pte,
>> -                                                       tlb->fullmm);
>> -                       ptent = pte_mkold(ptent);
>> -                       set_pte_at(mm, addr, pte, ptent);
>> -                       tlb_remove_tlb_entry(tlb, pte, addr);
>> -               }
>> -
>> -               /*
>> -                * We are deactivating a folio for accelerating reclaiming.
>> -                * VM couldn't reclaim the folio unless we clear PG_young.
>> -                * As a side effect, it makes confuse idle-page tracking
>> -                * because they will miss recent referenced history.
>> -                */
>> -               folio_clear_referenced(folio);
>> -               folio_test_clear_young(folio);
>> -               if (folio_test_active(folio))
>> -                       folio_set_workingset(folio);
>> +pageout_cold_folio:
>>                 if (pageout) {
>>                         if (folio_isolate_lru(folio)) {
>>                                 if (folio_test_unevictable(folio))
>> @@ -529,8 +542,30 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>>                 arch_leave_lazy_mmu_mode();
>>                 pte_unmap_unlock(start_pte, ptl);
>>         }
>> -       if (pageout)
>> -               reclaim_pages(&folio_list);
>> +
>> +       if (pageout) {
>> +               LIST_HEAD(reclaim_list);
>> +
>> +               while (!list_empty(&folio_list)) {
>> +                       int refs;
>> +                       unsigned long flags;
>> +                       struct mem_cgroup *memcg = folio_memcg(folio);
>> +
>> +                       folio = lru_to_folio(&folio_list);
>> +                       list_del(&folio->lru);
>> +
>> +                       refs = folio_referenced(folio, 0, memcg, &flags);
>> +
>> +                       if ((flags & VM_LOCKED) || (refs == -1)) {
>> +                               folio_putback_lru(folio);
>> +                               continue;
>> +                       }
>> +
>> +                       folio_test_clear_referenced(folio);
>> +                       list_add(&folio->lru, &reclaim_list);
>> +               }
>> +               reclaim_pages(&reclaim_list);
>> +       }
> 
> i overlooked the chunk above -- it's unnecessary: after we split the
> large folio (and splice the base folios onto the same LRU list), we
> continue at the position of the first base folio because of:
> 
>   pte--;
>   addr -= PAGE_SIZE;
>   continue;
> 
> And then we do pte_mkold(), which takes care of the A-bit.
This patch moves the A-bit clear out of the folio isolation loop. So
even the folio is split and loop restarts from the first base folio,
the A-bit is not cleared. A-bit is only cleared in reclaim loop.

There is one option for A-bit clearing:
  - clear A-bit of base 4K page in isolation loop and leave large folio
    A-bit clearing to reclaim loop.

This patch didn't use it because don't want to introduce A-bit clearing
in two places. But I am open about clearing base 4K page A-bit cleared in
isolation loop. Thanks.


Regards
Yin, Fengwei

