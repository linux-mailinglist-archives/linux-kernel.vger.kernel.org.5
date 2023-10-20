Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3C17D06A0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 04:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346865AbjJTCsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 22:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJTCsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 22:48:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E014BBB
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 19:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697770083; x=1729306083;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xYLc4ldpV/fe1Ecio1EqZHCudUG+w9Rw2kUv0vV903Q=;
  b=bxKJD8VvqYstSQ5ZaPkk3L0JsFvTz8ABRL9qJ/ApyTtvEaCfUOzfPCVy
   UrhU4wB1kE+ITd9TGpX+3+aGfb3E9ew0X/WpnYIS+d2S6Z0nGONp9VxdP
   AsGwFgzH9bcQghVKpWCr6dPzEYU/y9fnDw9ehopFxEMGm8+9X/3zBaFRZ
   BeCNxj8ETiwHD03tt9G4JpZwvwfn8e6ufekTl/P+1L8rodiLmuYMzTMbY
   kFxzDO7Ep/fh/qe45j8f+Dt0IzvCDkJPsNYFvYeeLAOqFVYb+zFmAyqB0
   jfqT5ygMPgQuLs8VKrZ0cIgOHp0HpuPN4kB+iNbV441c6pnToqt7Kw2EC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="366650976"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="366650976"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 19:48:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="1004457629"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="1004457629"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 19:48:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 19:48:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 19:48:02 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 19:48:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPfU1tcJSQnr8p2D4+kUO3YnEJIno6wopEpQOXtTFB+6QpnALyg9FCEu+KL5J0AS6qDnrLzlSy+nQ4QWM/9U1acs5y8rHW8ryvR0NNs7PmxQmkVir++97wNJswTCc5VXvCyd4RxYk1xPN1pMv3LC0zrPrZGjIcKImmkhvNZ47Q99/0RjB7C8CJGuDSqerUs6WeiEin5L+BcypoOqgKJj44NN3PztPGFEi8QtQHUDgu8ghaVDTLWlx9KfVYfkpDBGRGatXvYt54SQiWdmqrVDjlYs1DlzkUwWIyF8WjyyFDTDeQXRkemZLwPf2CRWZFa6pWTvKUTpvUWwZPgmPve28w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTbghsMuuZMeZmD0fXsRbBZZgdRaSkRPaZDiP1w7zbw=;
 b=fmgrwhXHIUCLjfW+RwEn2WtWohUEu4DRbDp1+H0CrzkG2o2YTGS7Ztcs5Iul/fjHQ9aafPuaK9f0E07ASuK89F7feCrkjG1qJg0B80ubYtykBCsvSUUdF5mFS2q44bqKyLF8eNG+pTeZt36tss3uj1kA05NQk29sb6XEeg3vGF/llzQDSqX6p8wqox8mqf0KbzLmIiDBFH1ehcMbafCEnY0m78CwP5nobv6iVi6hXULaar3LXdkSF796zvv/ImdFm4knlmar/yQMJjOLxX8xowwLkqqGiLbo+AcO9BlpTy/qKqZs2+UevQtA2aHksUjgCj/BEeu5GxRlCRYeADYWQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DM4PR11MB5231.namprd11.prod.outlook.com (2603:10b6:5:38a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 02:48:00 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::d108:2976:a361:da49]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::d108:2976:a361:da49%6]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 02:48:00 +0000
Message-ID: <f90f72ec-0999-40a9-a4ea-895d848545d9@intel.com>
Date:   Fri, 20 Oct 2023 10:47:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: migrate: record the mlocked page status to remove
 unnecessary lru drain
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>
CC:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <hughd@google.com>, <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <64899ad0bb78cde88b52abed1a5a5abbc9919998.1697632761.git.baolin.wang@linux.alibaba.com>
 <1F80D8DA-8BB5-4C7E-BC2F-030BF52931F7@nvidia.com>
 <87il73uos1.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <2ad721be-b81e-d279-0055-f995a8cfe180@linux.alibaba.com>
 <27f40fc2-806a-52a9-3697-4ed9cd7081d4@intel.com>
 <e8099116-6f78-cb4a-5036-1d7e38b63e52@linux.alibaba.com>
 <fd389af5-d949-43dc-9a35-d53112fe4a60@intel.com>
 <05d596f3-c59c-76c3-495e-09f8573cf438@linux.alibaba.com>
 <b9042fcb-05df-460f-87b8-4d7a04d3bd5e@intel.com>
 <e84f8c2d-6264-f2a3-3737-17d48a0251f8@linux.alibaba.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <e84f8c2d-6264-f2a3-3737-17d48a0251f8@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0094.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::34) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DM4PR11MB5231:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc828dc-7712-436e-dac3-08dbd116f8fd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fV/o/7gD1gm8hMfAycv9aDrqcIIZ7sZqPSfCZfAJbOZioCAjqVkgjODdejQRFanJI3Pk602CdCNJ1iCDH0kcS7TzSlOxgpeyB3puuctr48K6SE+CemaVYmWLPYOBHKoHY0la8EyTI2JoPnSU1WZRaNa6wOkyqo13eVBk/MXKe4PjX3fQc9tRbJ0ynSgxjq2HI3WwUq+6FkxbMczCHxfJzpqg1vEOLIIme5nTkJXGFmS3gECi6Js9ma95BCoIyy3jZ8bpfn+7ct1mvmFXu2g6LVChI6UtPutWnrow095yw1Teua04EGp5Qk1LWnV3p9274QXqQiI0GY6Nw2B2XZI9wIQd7QubDzBsySlS6XQr5OefW4nET/lquQP8IlhTwpVB/a98BpH7ExRCCbu74Rx/IjeJU963rIS3w2gGKsZLXi0j4KqKlbZMYNrQhlHjh3KQXrQM0Vme7q1c8ujsJfU/CtV1j8K3keBrXfYL13BHCPFS1KWmAfkE5r7L+LvyYHPVe1D+uM95FGmggJa7gAOqXpesEESBdy2OjoIf86xOvXrmNMyaEsWpZ0G5obie2J2EGnLBCYjWdZ44JwLaeq/aNnXiiKcw5wDHar9tWqss5g+l9dlJQHgCrtoCE55pAYeYPTufC5VO/k9z5kIvrXgDWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(346002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(110136005)(66476007)(66946007)(66556008)(316002)(8936002)(6486002)(6666004)(8676002)(478600001)(4326008)(36756003)(86362001)(83380400001)(5660300002)(41300700001)(31696002)(6506007)(38100700002)(53546011)(2616005)(26005)(6512007)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0U2Y243VWhoVTI1TjJDZVBnb0p5eGZQYVBmeEV2elRKSnpMaWVsWHJRbndF?=
 =?utf-8?B?KzQ4a1VpZ3dZRUQ2THN3Ty9ndFI4V3VqTjlaL3BGZE8vb29jMDFKalhaMGV3?=
 =?utf-8?B?Y2lkRk03emllQ09vS1o3WEtrNE5UakhjZk5xdVg3K3VxdVJkajJ3Mm1GY092?=
 =?utf-8?B?Ui9EQjVJdlUvOWpSV21LODhTMzhzei9SYy9lbmJaL1BFQ0hmaFhvSGJRS3V6?=
 =?utf-8?B?ODVhRldFUnl1SEduYTRPVUxiUmZPZklzbldBSXp0RU9IYzVSSFF1MCtsVGdx?=
 =?utf-8?B?SmdFZG13NTJBY2piZWpiNEwyWkU0RFlyWFp4VGlLR2pESGdBWVBQNmoySG9N?=
 =?utf-8?B?ckpuRkVDU2tJRTMvWVpvckZ4Q1QxUUZrOGxuaFM2LzNYcWd1YmhjNkx2YUc4?=
 =?utf-8?B?T2JrVkxYT0trcUIxV1gvLzhqOHlSNHJPSXptWVRXRGZQTURrZEdNbWY5V0Fi?=
 =?utf-8?B?cVZmQ0dRYm5BQnIyZWRVQzI2VVVIV2JjaFBSMEZibzNjYmZNOVNMdll3NFJW?=
 =?utf-8?B?OElHZGxHVDVlTHY0VXkvQUVFTGFONk03R2dzUFdUWks2ck9sVGlVUWZuN0JG?=
 =?utf-8?B?VHVWQnF0djl5RFRING5ybnJBWXNHTWZEOGk1cHhGTXVvVXdmSldJQWh1Wlg1?=
 =?utf-8?B?STZ5alBUeDZqSmwrOWcwR0o3VUhaTEs5NHpDTzZ6MFR4MVRqbVVJUmZVanpz?=
 =?utf-8?B?Yk1aeE04cG1pTFNpVEV2blRwSUxhTElQaEFFdEM2UGlPKzNRUFU0bHJYelkw?=
 =?utf-8?B?Wm04UGl1NzAwTE4xcmVwZnB5TVVaamg3ZEs4OTZabXpKbDk0L2lyRWNNTFFR?=
 =?utf-8?B?Y1RuWUFUUTVBMVpkTnY3WTJTNTFSUkhCU3orRWNXVVh1OVpmNHdWTHBUZVFt?=
 =?utf-8?B?Rkx1cHFKL1V2c1VoWHlTK2xaZlpPN1QyTkN1eVN5TitUK3BoTTZzMHJwNjRr?=
 =?utf-8?B?a0k0aWdiNFlOallWR2xKYWxhb21mbEpScG1PQ1hDYVpva21TNEh6QjRTbE9m?=
 =?utf-8?B?VE9EYUVnL3N1K0MvY2JxWEZhdnY2dU13d0FpaWdkMWgwOHNZZGRPNGxzeSs0?=
 =?utf-8?B?RUI4MXBuT21FUlNJMWk5aUdxUmFTYkY3SFhyaTVkSFF6czBXTmN0R1NVc2FZ?=
 =?utf-8?B?aGFocURFc0tTZndMUXRCUDBQK3g4cU5NTWZzOHBENEhwWHRVVUN0WmJUL1hL?=
 =?utf-8?B?aHJnTEF6WUN2T2N3aTROL29qNFZFWURuVUlYSWhvOUl6U2s4N2NrTi9tTGIv?=
 =?utf-8?B?TDJtZ2NHdys4RXBwLysvaXdXUXhGbitDYmhKNlppc2d0eDZ5L1RCaWxocTJX?=
 =?utf-8?B?b1BzZHoxQU5Gd1g5eUtJUFVOUEwwQXJoYSs4cVNkVFlURko1ODlXTVRzS2RO?=
 =?utf-8?B?a2J0dHBJZHBrVE1QM09mWmJodWx5TWlRcDBFSS82WitsclZlSWNieWduWStB?=
 =?utf-8?B?Q0dwdmVBSXdhY0k4aG9RSUlNWk1icmdMQ1cvNkJjcHdGMlQ0YmpmaGRVV3g2?=
 =?utf-8?B?ZktOVGhyaW95ZjN6cDlWT3JtMzFJU1ZzejQvM01FZnVxTkgrL0ZML012czFX?=
 =?utf-8?B?Y1BtcjZkMEZHRE0xT3Vpb2drQVpOY05FQS8wSzc5M2wzTFhJcG5UaXVyb0Fo?=
 =?utf-8?B?MnZwTGFFSmhzRTh2MDdYN3V5dXZ6a3Y4L3VlSElZNU9WMTA1b1g5Z2ZHZXhu?=
 =?utf-8?B?Nnk1dit5d3o2TFNBTCtMMnNHSnZXakFuaUZEeGZPamZ4cWd2THFMUVFOckRi?=
 =?utf-8?B?UjFTZG1zTkF5bWc0cnFjM1FNanovMGFuQUdrT25FbWRDSnk2Tko3U1JxZWYr?=
 =?utf-8?B?VTh1cHkzY3ZXU2RIZW93WjhYYkx0MUtNblBOZDJvWitqWWt4dkxSMmRWTDVC?=
 =?utf-8?B?WFkzcEFMRGl5WXNyWWd5b3VZa2ZWNk5OVjQreVdwNTlDWlo5Vm11TFcySU9x?=
 =?utf-8?B?bGpPV0pYKy9ZTkdCMjhLa2ZWcEFhcSt3aGNDUXVyaHNzS3Y3dE16TUJhbXNt?=
 =?utf-8?B?Mk9DY1VUaktsZkVrZ25DcVFBamhueTJVNHlXYlFVYUFvUktOK2JobXMrVkVw?=
 =?utf-8?B?Q0ZvQzZiYVhyRXJBSDIwKzVWL0o3UHVGUVVNdDh6RmJhVllwZndqL0lZS2Ux?=
 =?utf-8?B?L1NZV0x2VnVOQXJqdFllZFYwamNmL3VzZVRZWllpemp4cVFvSGFCUU56dW5Q?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc828dc-7712-436e-dac3-08dbd116f8fd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 02:48:00.0876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9y/sHPq++VuZ7np8lFpjqZB0QU2+W5oj6hMHdJlSNAn6+7cKOoCGTry1QVmeb9sTs8EZlp+8KLDrqFEhgbFkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5231
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2023 10:45 AM, Baolin Wang wrote:
> 
> 
> On 10/20/2023 10:30 AM, Yin, Fengwei wrote:
>>
>>
>> On 10/20/2023 10:09 AM, Baolin Wang wrote:
>>>
>>>
>>> On 10/19/2023 8:07 PM, Yin, Fengwei wrote:
>>>>
>>>>
>>>> On 10/19/2023 4:51 PM, Baolin Wang wrote:
>>>>>
>>>>>
>>>>> On 10/19/2023 4:22 PM, Yin Fengwei wrote:
>>>>>> Hi Baolin,
>>>>>>
>>>>>> On 10/19/23 15:25, Baolin Wang wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 10/19/2023 2:09 PM, Huang, Ying wrote:
>>>>>>>> Zi Yan <ziy@nvidia.com> writes:
>>>>>>>>
>>>>>>>>> On 18 Oct 2023, at 9:04, Baolin Wang wrote:
>>>>>>>>>
>>>>>>>>>> When doing compaction, I found the lru_add_drain() is an obvious hotspot
>>>>>>>>>> when migrating pages. The distribution of this hotspot is as follows:
>>>>>>>>>>        - 18.75% compact_zone
>>>>>>>>>>           - 17.39% migrate_pages
>>>>>>>>>>              - 13.79% migrate_pages_batch
>>>>>>>>>>                 - 11.66% migrate_folio_move
>>>>>>>>>>                    - 7.02% lru_add_drain
>>>>>>>>>>                       + 7.02% lru_add_drain_cpu
>>>>>>>>>>                    + 3.00% move_to_new_folio
>>>>>>>>>>                      1.23% rmap_walk
>>>>>>>>>>                 + 1.92% migrate_folio_unmap
>>>>>>>>>>              + 3.20% migrate_pages_sync
>>>>>>>>>>           + 0.90% isolate_migratepages
>>>>>>>>>>
>>>>>>>>>> The lru_add_drain() was added by commit c3096e6782b7 ("mm/migrate:
>>>>>>>>>> __unmap_and_move() push good newpage to LRU") to drain the newpage to LRU
>>>>>>>>>> immediately, to help to build up the correct newpage->mlock_count in
>>>>>>>>>> remove_migration_ptes() for mlocked pages. However, if there are no mlocked
>>>>>>>>>> pages are migrating, then we can avoid this lru drain operation, especailly
>>>>>>>>>> for the heavy concurrent scenarios.
>>>>>>>>>
>>>>>>>>> lru_add_drain() is also used to drain pages out of folio_batch. Pages in folio_batch
>>>>>>>>> have an additional pin to prevent migration. See folio_get(folio); in folio_add_lru().
>>>>>>>>
>>>>>>>> lru_add_drain() is called after the page reference count checking in
>>>>>>>> move_to_new_folio().  So, I don't this is an issue.
>>>>>>>
>>>>>>> Agree. The purpose of adding lru_add_drain() is to address the 'mlock_count' issue for mlocked pages. Please see commit c3096e6782b7 and related comments. Moreover I haven't seen an increase in the number of page migration failures due to page reference count checking after this patch.
>>>>>>
>>>>>> I agree with your. My understanding also is that the lru_add_drain() is only needed
>>>>>> for mlocked folio to correct mlock_count. Like to hear the confirmation from Huge.
>>>>>>
>>>>>>
>>>>>> But I have question: why do we need use page_was_mlocked instead of check
>>>>>> folio_test_mlocked(src)? Does page migration clear the mlock flag? Thanks.
>>>>>
>>>>> Yes, please see the call trace: try_to_migrate_one() ---> page_remove_rmap() ---> munlock_vma_folio().
>>>>
>>>> Yes. This will clear mlock bit.
>>>>
>>>> What about set dst folio mlocked if source is before try_to_migrate_one()? And
>>>> then check whether dst folio is mlocked after? And need clear mlocked if migration
>>>> fails. I suppose the change is minor. Just a thought. Thanks.
>>>
>>> IMO, this will break the mlock related statistics in mlock_folio() when the remove_migration_pte() rebuilds the mlock status and mlock count.
>>>
>>> Another concern I can see is that, during the page migration, a concurrent munlock() can be called to clean the VM_LOCKED flags for the VMAs, so the remove_migration_pte() should not rebuild the mlock status and mlock count. But the dst folio's mlcoked status is still remained, which is wrong.
>>>
>>> So your suggested apporach seems not easy, and I think my patch is simple with re-using existing __migrate_folio_record() and __migrate_folio_extract() :)
>>
>> Can these concerns be addressed by clear dst mlocked after lru_add_drain() but before
>> remove_migration_pte()?
> 
> IMHO, that seems too hacky to me. I still prefer to rely on the migration process of the mlcock pages.

Fair enough. Thanks.


Regards
Yin, Fengwei
