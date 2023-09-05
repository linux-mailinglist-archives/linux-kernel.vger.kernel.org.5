Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6BB7927B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbjIEQDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352354AbjIEFlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 01:41:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E74DD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 22:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693892506; x=1725428506;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/O8QoEF9HGo+7Z9miF9S8+ygVwW1u9GjJ1ib8DNelUI=;
  b=NXUUo5d5DVYbRN4rMuw3JPkmhi2Mfe/gk8azKxyDVaKmp+CLX3RZ6Uq3
   0Gn6dlJSYZ181MSi5/vD/UxsW3CAzKpGvcERwVI505YN7hn7uICJ2EYyL
   YmbnGBqmaY1Klx+KevAgqECmpHDUkkIa3I2fyMDvPuJ0lWX/fQIaLNcwF
   VOcYOfZ2K4m1MnTzBoycXTz2vGswVNS9LoOlSJ90XWqYIgf70pbOft4mq
   fQGu7xWzRLAiYScAnbfBF1rbiaUCTA8QlqrQuCVvFFTqxi/5rv+2CuE54
   cORd4FlJY+jjRCoLuKHeIz+ZwJVz1yVcFNLIEoQqU46iA+YReJi2B2pu+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="443111597"
X-IronPort-AV: E=Sophos;i="6.02,228,1688454000"; 
   d="scan'208";a="443111597"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 22:41:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="884196007"
X-IronPort-AV: E=Sophos;i="6.02,228,1688454000"; 
   d="scan'208";a="884196007"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2023 22:41:37 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 22:41:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 4 Sep 2023 22:41:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 4 Sep 2023 22:41:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gddPsC6AOdEjhYafTlVLAByPNqlmqvrf/2Hk9fW2rPf2O/IV3iViBDePkEzG/XgJGCn4yx4hYxEjCZJcIGgwnq4ydaiHqAT9TZOBF92OSELSfAM8zIeYAYSMK6xLAGXjqh2G7ZR3WYMoWVYBkc5uO0TsG+Yn6KerKai4S20x6znTp+3s4QmTk1sKKdNlbPDgTeCkqQGyiMnfdZCgD8BHd9T/+WS+IDZT+576st2F546daWkW2mtTK7S9cTvCtIwdRVaMmS0aAQh+zUR9FYqMPcllUUvnDSOcDdEknQnnF08DDhWHJOzH3hbKnuneHor7s8XaGtAcGWaQUCoBz4t6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mO9+CQj9wH4MehN2rZCcyKb9o1qqzF+zE2QjXK589Bc=;
 b=Uqmj4vaWUpK2wM29rqC7zNd9NmZGZ1S6QGod+Y002k8EdIusL7azwzR2Ddlf9g/0V4iiO5R9YiS6XdQc2/pc42TCtY053bbdiBmy2cz7DLNTXJ1hntvyxVp4Y1160enDADj6wkXhSG6FQAJMFOs3NqKJzgR1zoVm6g/tOU47xOD/OCstlikVuxjBB2PZrRdDtYV52wtSTx8o05lNXHwDRZCYreUgkrljiB1szAimorm6aHluoMBcjoFJHvnH+ubJ+COv+4r50LI4TMYhnnnd3t4zTUHHRLmdoZNW/zPsL4S6rutY/1TkoxouimKICdimG6BIPKylkFw+kBfHykHzqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SJ2PR11MB7545.namprd11.prod.outlook.com (2603:10b6:a03:4cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Tue, 5 Sep
 2023 05:41:42 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 05:41:42 +0000
Message-ID: <8351fcd6-d4a2-9656-eae8-96e92e3e5257@intel.com>
Date:   Tue, 5 Sep 2023 13:41:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [linus:master] [mm] c1753fd02a: stress-ng.madvise.ops_per_sec
 -6.5% regression
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        kernel test robot <oliver.sang@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <yujie.liu@intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Olivier Dion <odion@efficios.com>,
        Feng Tang <feng.tang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
        <ying.huang@intel.com>
References: <202307181511.8643eac7-oliver.sang@intel.com>
 <3b4ab51b-e3e9-a504-ee07-82326e9ee1e9@intel.com>
 <c5983185-5bdc-b703-1600-6e44c49d6442@efficios.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <c5983185-5bdc-b703-1600-6e44c49d6442@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0198.apcprd04.prod.outlook.com
 (2603:1096:4:14::36) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SJ2PR11MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: 1688ce89-ca2c-4fb8-f01e-08dbadd2c840
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qUhC/iIjKLc0q72K9pZEBJZ0TZEeagawAjAx3vWT6yEcJrWckPYeNjLmlNFav1ptEnXdnqoHSNG9OecrrjRoPtOGosPGJ8glxtP9GJVeNSFvT0aptmy6uqyAPMkxdnHnOP0ofW3OB8v++6SnijYMnphUJRl1E6r/zfytQ3Ykn9SUKAmlBCF6jm7eBsMNQrERp89f3zhfFgl4a4UtINCVwV8MXUK9wZSxi+GgFhqHdXEM0ZayYnoyREMtwHT3SNiu8/k7IhbbBThN8o3pD6+cUf5k23rX9YuU7hJdW8FIGpIAHmFojiL8K/166fvoCymaqnevr/gxLR+GRGGu6zKOwRTttlJMP94H+SVk9okm8jDqPNdeMoga+sO8gqdjofwE5xLwtmE6eDVoQxTFMQU7f9+VDBR6r6ym36rkfr6P/YTYyudYqrWwbAX2C+sKyfb5QvIJEEtdD8GOneBY9l+HTJNsHMxFV4LlVi3BFB+nIJIQ7gD8+X+jNWmsXAgza70WTHuufZ8MStzink0UkLVNIrgaZbDxSBBW6mDFT+pKwKhY0SW3t+LaSSxFe0eLFPXw6l+WFWMpgjW82jt2BnFOb9uogTfDH0QrG+jedYSXd4DbtEDwWwEwYz6Q1OyMs4iaN5w/j5hMDRlsyhG5B1pTjKhW/QTwKiNL5vOVZOBI49HCEb4xBI3XeXW95b8vR/RK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(31686004)(82960400001)(5660300002)(36756003)(31696002)(86362001)(83380400001)(41300700001)(66556008)(66476007)(66946007)(107886003)(26005)(38100700002)(478600001)(6486002)(2616005)(110136005)(6666004)(966005)(8936002)(8676002)(4326008)(316002)(53546011)(6636002)(6512007)(54906003)(2906002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE1oZFdqTnFSZXkrRlVMQlltbi8rOG5JN3JtMW9yVkNTMnZwaWQydWRycUk1?=
 =?utf-8?B?M0taUXB3dnBhZkVEOU9EWk1TNmtLN0d3eS8rVHNZTzQwZ0xsZC9tenhIenB6?=
 =?utf-8?B?aXJZaHlIdXJPWEo0ODlVUTVKL1BaNzNOcTdPWDQ2RDVWOCt4bVRUOXdTdUcy?=
 =?utf-8?B?QlR5RWhRN2J3b1VrVWY2VUJSQVo2Qm9KR1g1bnppQTJTTitDcEwyNTFFbk5v?=
 =?utf-8?B?LzJoNE5ndkxJVmsvU2FHbXZyZmFHUkVIRTBYdngwOXg4Mkw1cEFuUzRzK3dX?=
 =?utf-8?B?dHo3RzFkZjhNTUNQcHpkaC92TXRtbUI5dlpDNmJ4V3dhVHlxdVo2V2VZTzFv?=
 =?utf-8?B?Zm9Wd3E4OWJoclVCUkFwWHJXMUszZTNRSHZ0T3VrRmwya3l2ejZ1ejhja1Q5?=
 =?utf-8?B?RmlWQUdEVENpM0cvYU5LUUtTMkVOMGMvUXFVMXRaWnVWKzc4S0liMFlkVHhY?=
 =?utf-8?B?YkxPeUpDK05GSlRML3pMQnZweVVxYTFtZ2ZZN1VINHRvUG5OcVJZV0E1bGxo?=
 =?utf-8?B?MklZZzBEOVVaU3NrVW44UUczVjVvQ2t4MjN1V3RjNlZIVjZJV083ekZqZnls?=
 =?utf-8?B?VnZ0alZLeHlFemR6d2VkaE05TllJMVI3UTJsb3k3bnJLMGY2amZUdU00MlhH?=
 =?utf-8?B?d1FZUDNkNDhqNFZFTXBtVGRMTjRXblNKUWcvd1hhS3BQdHBkZVhzajJuRkpZ?=
 =?utf-8?B?NXZtaHI4aUlDTmV3VHJhc3l4dS8xS3FHUHdhQ2k1dFdiNkFSdHNic2N1Q1Jy?=
 =?utf-8?B?ajBJRmlEbjczZzhad0I1bnFEQnZxVnQxSmF4OHpHN0J4a29oMXVFSVVxSkJI?=
 =?utf-8?B?QU9VaytJVHBaWi9rUUVteEhCSk5zUHZMaVkwYXF3a1FSc3haRkdPUzRwdjZ1?=
 =?utf-8?B?Q2srRDFuUThkNE0yVE82cmRnQW1WTlJUaU9LRlZTN0tBTzhzMHRCNHVxOGFI?=
 =?utf-8?B?ZHVIYlRiUk5MZkxJRHQxeGZFV3E2RlkrSVNNVm55Q2F4L3Rud0dFZFVGQkgx?=
 =?utf-8?B?VUg1ckZrNGUwNlN4ajdCVmRKTkh1RHBhK3NjOVFLL0tKUHN6eDYvSFZrcVM1?=
 =?utf-8?B?Z0ZDV1k2RmpuZVJ4R2k2eUNZdmtpb2pHUEs1dzlRdU5WQTJXUE9OQUJBRW9U?=
 =?utf-8?B?RWNFMEl3L1VWVDBEYWdxeFRzZ2o2eWNzdnNzcnNqenlFdjBoZ0E5dStobU83?=
 =?utf-8?B?RjBMaFdtYjBDWGd0UzVEaE5wZWtnRFZHUUFFZWpBc3c2YXZJTThhWGNhRUIz?=
 =?utf-8?B?THhzSVpUeVlocW5XeTZVUW5VUkRHREtIYzM0M2FzZDg3N3I4WWYxWG1adXlG?=
 =?utf-8?B?MHdiYnJaQnZHN0lKTTJneEpHeGNmcDZrYnMzWFIyOVh3YjBBWkVqajN1ajY0?=
 =?utf-8?B?K0RlLyt3d3BDR2llTkE5T3pIaGtRY0twdFg5RUNJaFR2MHdhVGZZak5PalVh?=
 =?utf-8?B?eFRZcUN6b0FNZ0ZFc0kxdGg4V0JhY0w1R0JjM2NtY0xBTzRGQzhrY0xURHVC?=
 =?utf-8?B?NFR0YjdIa0JiTThkZ2dNamh3UFkxaE9JaWJSR3I2b1pZQW9KTkRXSWJ3dnFB?=
 =?utf-8?B?Q3dRQWRIeFhpcVFQTnJtZzZjVDNDWThINytwTXU4dDRidlZjclo1TXhibWJC?=
 =?utf-8?B?MUZrNlRiVGVCa3RoeVpwRWRjaGhZb0ZpejRJMEVtWFdYS0gyTXVGMHlrTGxH?=
 =?utf-8?B?a0hwMmZha2cwazRCbllIQ0MybXpiR1M2TDdXRWlyOHlrZ1dVZWZPbUMxVE8v?=
 =?utf-8?B?ZGlxZW1LeC9tcEJJSG1wREN4ektaOFA3aS8xaE0yTS9OUk1rRXRPQlpvNyts?=
 =?utf-8?B?OXVOTlFFa0V5blQ5Q1NUbFNkZmNEWU1wNEsxcS9MNFNjeE1RcXEvcmV6Zngz?=
 =?utf-8?B?ajZTRW1KSlVNYU9YU2lHOHBnSTVvR1c2MFd3SjdzTjNBWG9CVjhwL3dURkRO?=
 =?utf-8?B?SzJLMTJpNk9PTXpGeTlpcS9nNHkvVzMxT2cyNEFRQ2lhRTJtQnlXaGMzUVdt?=
 =?utf-8?B?UUMvMHhrVnZYQXhPU01BUFNGdTJVOGNtRkY1Nk9yaXZVVGVmc20rU0Y3ZmJj?=
 =?utf-8?B?eG03OUJ1R3l1TDRyY3cwQ0lPMzM1aTBrYzR4SlJhQnFUWUpDUWgvbUdzRStD?=
 =?utf-8?Q?G3uLZM1Hhscd1DDKlMPHyl4XE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1688ce89-ca2c-4fb8-f01e-08dbadd2c840
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 05:41:42.0853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1GxXkgT3YB5yrkj+25mohBCO40AgjRZeafZN8WjyJBbZM66EHHPJAeHXFGCgReCXz+pp5JIwP6MRHY+KBHu38Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7545
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/23 18:04, Mathieu Desnoyers wrote:
> On 9/4/23 01:32, Yin Fengwei wrote:
>>
>>
>> On 7/19/23 14:34, kernel test robot wrote:
>>>
>>> hi, Mathieu Desnoyers,
>>>
>>> we noticed that this commit addressed issue:
>>>    "[linus:master] [sched] af7f588d8f: will-it-scale.per_thread_ops -13.9% regression"
>>> we reported before on:
>>>    https://lore.kernel.org/oe-lkp/202305151017.27581d75-yujie.liu@intel.com/
>>>
>>> we really saw a will-it-scale.per_thread_ops 92.2% improvement by this commit
>>> (details are as below).
>>> however, we also noticed a stress-ng regression.
>>>
>>> below detail report FYI.
>>>
>>>
>>> Hello,
>>>
>>> kernel test robot noticed a -6.5% regression of stress-ng.madvise.ops_per_sec on:
>>>
>>>
>>> commit: c1753fd02a0058ea43cbb31ab26d25be2f6cfe08 ("mm: move mm_count into its own cache line")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>> I noticed that the struct mm_struct has following layout change after this patch.
>> Without the patch:
>>                  spinlock_t         page_table_lock;      /*   124     4 */
>>                  /* --- cacheline 2 boundary (128 bytes) --- */
>>                  struct rw_semaphore mmap_lock;           /*   128    40 */   ----> in one cache line
>>                  struct list_head   mmlist;               /*   168    16 */
>>                  int                mm_lock_seq;          /*   184     4 */
>>
>> With the patch:
>>                  spinlock_t         page_table_lock;      /*   180     4 */
>>                  struct rw_semaphore mmap_lock;           /*   184    40 */   ----> cross to two cache lines
>>                  /* --- cacheline 3 boundary (192 bytes) was 32 bytes ago --- */
>>                  struct list_head   mmlist;               /*   224    16 */
> 
> If your intent is just to make sure that mmap_lock is entirely contained
> within a cache line by forcing it to begin on a cache line boundary, you
> can do:
> 
> struct mm_struct {
> [...]
>     struct rw_semaphore mmap_lock ____cacheline_aligned_in_smp;
>     struct list_head mmlist;
> [...]
> };
> 
> The code above keeps mmlist on the same cache line as mmap_lock if
> there happens to be enough room in the cache line after mmap_lock.
> 
> Otherwise, if your intent is to also eliminate false sharing by making
> sure that mmap_lock sits alone in its cache line, you can do the following:
> 
> struct mm_struct {
> [...]
>     struct {
>         struct rw_semaphore mmap_lock;
>     } ____cacheline_aligned_in_smp;
>     struct list_head mmlist;
> [...]
> };
> 
> The code above keeps mmlist in a separate cache line from mmap_lock;
> 
> Depending on the usage, one or the other may be better. Comparative
> benchmarks of both approaches would help choosing the best way forward
> here.
Tested the will_it_scale.mmap1 on Intel Ice Lake 48C/96T + 192G ram. And
confirmed that my patch bring around 12% regression. Which confirmed the
information in
commit 2e3025434a6b ("mm: relocate 'write_protect_seq' in struct mm_struct")

Putting state and owner of rwsem to different cache line can benefit the 
will_it_scale.mmap1.

So we may just keep the mm_struct as it now.


Regards
Yin, Fengwei

> 
> Thanks,
> 
> Mathieu
> 
