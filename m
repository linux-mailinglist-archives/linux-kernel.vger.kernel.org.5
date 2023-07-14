Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8044753C51
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbjGNN6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjGNN6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:58:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B1A26B5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689343110; x=1720879110;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tzRObSvgrNUbBanXFBXYTzdRES3RmVzSZgIZuB9X9F8=;
  b=NdovyyL2bLltp0Tu1gKMn0eqpW6K3j/n/eqhwK/AdIZIHoiG7Ecw8i4W
   oEaQGJiyu/XR8tPN6wAy9IOGnizADfrNAz3bklkYbZJNdtpyVAtBd5zUb
   q17hWlfGaQVp2oKWwnJSuTuFaosbqDGX3bHo1mlaBuRjceIqL6EZqHN3H
   rmmitRVXxa5C9vHix3rBlJDAQteDZdLRcGvZlK6tDZtve7zBHxMX3Nhc7
   u224DLIAwrd4rw8wAOblhIbShSRH3xoHK23I9va/TrbuTHn6hinAEJtrQ
   RrwW52pu5VCSN8kEWFPHtj8d6FE5Yn25XaAaDy0Mwy05MY0pwRljfbNwr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="345075463"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="345075463"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 06:58:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="725714373"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="725714373"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jul 2023 06:58:30 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 06:58:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 14 Jul 2023 06:58:29 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 14 Jul 2023 06:58:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNOaFOgQE75r2Rmy0SsTKYZJ+T+r1Fsn8L+4PksefRMFFjMyPTTOawtGCkCZc9NOD7O29WUYZBvAaGir/x1nzbmdzbJcRe4HIuRRJeUz23z4owQ3GmqWhiJhXdYpF9Z+aXbxAJfl0kxyO2DhoCyfuyWMKe6zSjSB/JtGlK2NaReVaoHadY/sHRjmkcMJMBgLsQSepke7acZjJEiKZSd6XjV+C5Fo73xPkIiPVkRn7hgziN2rEde/NdqCGEJxOqg/8wOTZ2IMDvOEWlQu4YqoGYRiCEqZFB4d7IEjE/fM15yaPocHMn43oQkmlejqg0hKxAL3lgYAltIOIMSjQ40LbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeJz92wLvKOCF0Mtid71Dgi9kkEa4Q9tY/O8SUwd/M4=;
 b=EM5KVYWuGgH6veSa0/et+73TAdAlZSahV5v4Pc2ureEpScodq27l2IkIndOK4JIUbJN4Wj5MyTruHVS9dXeXEsSai0iqf7pPjRWb4EF/2isaZDcgS8+BPKNmuFuhu25UL/FREMe9cxgyR0h1Jzt5ufP3uVu9mHQj62ZNgSvbDtER+L5IbyrsRHO1ebyW0rirnGwCb/KdZ4/DuZ4k++Sd9+6yufRJ73weJgpAyk9H1g5BYqW22SLknzgCINA0fkiJR2Kyw+x/v+TXR8ZJm8gs9X5JLxc50PMrhSHcKjB+FTP3mrS/XjDx/7UBZZsMl82Id9Am0qsTCEufW5bhjl/Lrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS7PR11MB7808.namprd11.prod.outlook.com (2603:10b6:8:ee::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.27; Fri, 14 Jul 2023 13:58:27 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 13:58:27 +0000
Message-ID: <9bcc8014-f5ef-9021-3ffc-032e39c32249@intel.com>
Date:   Fri, 14 Jul 2023 21:58:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] madvise: make madvise_cold_or_pageout_pte_range()
 support large folio
To:     David Hildenbrand <david@redhat.com>, Yu Zhao <yuzhao@google.com>,
        Zi Yan <ziy@nvidia.com>
CC:     Minchan Kim <minchan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <ryan.roberts@arm.com>,
        <shy828301@gmail.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20230713150558.200545-1-fengwei.yin@intel.com>
 <CAOUHufb0zxKvmvEXfG4kySenxyPtagnr_cf4Ms-6si3bQTybGQ@mail.gmail.com>
 <8547495c-9051-faab-a47d-1962f2e0b1da@intel.com>
 <CAOUHufY-edD2j2Nfz3xrObF2ERAGKecjFr_1Qarh5aDwyDGS2A@mail.gmail.com>
 <d024fa03-ca51-632b-9a01-bbdc75543f5d@redhat.com>
 <2cbf457e-389e-cd45-1262-879513a4cf41@intel.com>
 <36cfe140-5685-bea7-d267-4a61f21aeb79@redhat.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <36cfe140-5685-bea7-d267-4a61f21aeb79@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS7PR11MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0819f3-2e61-45ef-22a2-08db84726609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +L2zk6TLWKpnPq1nbLGND7OODKuok7vV6tg/uvAVBcqFiqNMq1dGwxtipgHEuZi5UdT7AGTicwLngOpWkIxBfcnODJ8cEH/iuRxOVYsMqHdLPowFRpz+xNnTOv1I+0Rs/RWGM7fgr8v6v/rHDzXxoKspM+OV2pH9a78VYDXIl7FPgbVjIHeDowK4EjluQt+2AzZIcSEtz1mXCdPQnfo8xhidRP+HdXX8oOnDT+r54umQS9Eo1bI2TCXEyKO2f9WRcSgMlzVLqi/HrEL4iveXSQ12KE+QpxO0EnxvBPGYmYBWPEEj5W4zybryrItZ7VeIr48/xv8DOETCIAMTcZHnPN/qAX4dbjgz8JOuNzRyQ2P+lqUcN6WmScRSqeeiQPpi5nOdIvamKvEeyLjJv7NHmiPXl7E/l0LGe0TBU//zvFL6hPGef1wfhAllUfYdQDd25L3qFocwVLPPkm/vifaF1cHSvD0cVLWf4/JZHUUJKQSqgbBHmfC/3TMMDB99nB2wq5PUBvxz4eCm9zHxIuOP4LVjR53oANbxVUE+C3SmdMlZ7I+QKeWX+sjGSn1WNowdNvj8EUa/YXnlq5wzcnLpKAqBG0xQnOfqmBbyU/qyUI4cnH2XxlEwJG0SnQ+k/F6sjJLWKgnyuVh9XqSlExDGLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(396003)(376002)(366004)(451199021)(31686004)(2906002)(41300700001)(110136005)(54906003)(478600001)(6486002)(6666004)(8676002)(8936002)(36756003)(7416002)(66946007)(66556008)(4326008)(66476007)(316002)(6512007)(82960400001)(83380400001)(38100700002)(31696002)(5660300002)(6506007)(186003)(2616005)(86362001)(53546011)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDBCVGIvWk4yNmZaN0l2ZVVEbFg1N25NR2JrWDdMMUx2N3oyaDVNdVRrNGQr?=
 =?utf-8?B?QlVzS3JxSkNzTzFMdEh1VFhPaUtNdDNHa3Z3NkNMVHBHSGtBMGZ5dnhtWEtD?=
 =?utf-8?B?UlNjYzYvQjZ1Sk9XTFh6d0Y2WDJrZ1dTbUY3ZVV2VStWR0M1UmtVZ1NUYVVH?=
 =?utf-8?B?THRsZ2EyMUxFSU94YTNyYUhaaEZkakNUSUl6NGhoSnJrZkVrUTJVbm45cUFo?=
 =?utf-8?B?UmxURENnQmk1SncvWXh0N2NaaTVrNS94dm1PNnRDdFlnNzZFYzlXTThYbzds?=
 =?utf-8?B?VjdLRVlqakErSjAyN2xFaTZYYUZyUERzc05ka2pmTmhaR1Zkd3J1a0FWN0hS?=
 =?utf-8?B?Z1gvdzZKL2NpZk9iVE4rcGxKenBaZ2RIVWpDaWpiQ0VJN1FnVE0wSFplZHRY?=
 =?utf-8?B?bVZudWxSZHk4UE5mdGJ2amhYVzhZcmRWQVRXcjdPQmpxOHlWTG9KSENURmxk?=
 =?utf-8?B?cUhvUjA3cjEwY0VJbHZmMnAxMU5QYXVBU3FrQWluOUg4R0g0TU93Y1BOUWJX?=
 =?utf-8?B?bmhxdWI3RXlYd2Q5TVptVDdGa1g0OHB0RSs4Mml3V3prQ1REWmVoL0ZRS0VI?=
 =?utf-8?B?aWd2TE1Id3F4SFBnL1lwWURHTkFDZDd3Uk9qMCs4ZGRDSzBxRFc2bForcUtP?=
 =?utf-8?B?MU9HQ3FXYWw2TXBqZkpTTEd0bjhyNCtCeEk4cFRsTmJHRDV1RjBjazkwRHN5?=
 =?utf-8?B?VnFPOUNiOUl5YzRkQWVndEVLT1VqaWkwR0l4WFMwUndQeTRUdlgrVEtWTnI0?=
 =?utf-8?B?S252Y0dhcGd5cWlIcVNEL1ArTEVWRjVTYmc2cjU5cmIxWVZEWXdUVXQ4Slgr?=
 =?utf-8?B?b1BuL0dZNXBJZlY3ak84bkc5cHZJMVd3ajVXTVYwT2luQ3FiMWlqQVY1OWRu?=
 =?utf-8?B?UFV3SGg4QmVRQktUdVdkMkJnRVBvbkpZNW5UVzU3ZE5yblprN0VES3lsK2ZB?=
 =?utf-8?B?ajBEOEhYZC9YNGFjc1cvY1ZaK250MWI1enpVTXlJZ3RkSC9QbTlpNllFaWdP?=
 =?utf-8?B?cFhLR3ZZcFEvNDlWOEpQOVhjVFJpWG93SG0rSHFveWV0aVlFSjlXMTV5ZUZC?=
 =?utf-8?B?SnRYRU9oZnFZOU0ySlhrLzByQndYdGpsZ3A2YjBRVlNVTVhsU1RrVUdzOTR3?=
 =?utf-8?B?NTdxMHFpSVNaaGYzWHFFeCtpRXYvQ2YreW5odEZPeUNHVHdjOVQ3YzF0SXU3?=
 =?utf-8?B?aEQvYnVHN2VJM2NhU1VoV3EvUkJhODYvRzVIb280ckJsT3hrNVJLR3RSSkd2?=
 =?utf-8?B?TkxvSHNrbldFSGpiZkxieDZJdWxKYVZQbGRnSG5yZ3cyREtjUjBGdjBMb2xB?=
 =?utf-8?B?THJJaHp3NC82N0dKcFAyUHU2Qi9waWhWMFRBcTM1WUxaMGJ4Q25UVVJtUkcz?=
 =?utf-8?B?UXhpL2FYQ0FQQ2h1dHNEOGFLNkNlTTB1ZU0rWGtJYmt5OXFWUG1pckcwRzRu?=
 =?utf-8?B?SW9SMkErUTNTMmhleFMvcFl1bXRUajVaSGpIUzNPU2xqYXd3Skxpd3AzWTF2?=
 =?utf-8?B?RGdWMWlvZ3VISW03SWtXQkNOejVFNm45SWpFSGp1SmtGSDAySGlJVjBKSW0r?=
 =?utf-8?B?YTBIYWE3ZnpCczdBUFBIeVFpQnkxQ01HcmFia24wMDZXK0ZaVEVaV1k2M3ZM?=
 =?utf-8?B?SEZwSXYycUVqczJYK3h4bFY5K1dBQnlxRFYrZnBhK3RaU2dwV1JQRW1lZnFt?=
 =?utf-8?B?ZUNHbVU4NWpReFNHemI5cmxpQ2lBS0lEUlRXTEx2dm9TYXIvZS94bm5rVGxs?=
 =?utf-8?B?bk1ZT1ZBUG5lTnljZTdSWHRPRERZUkcxN3hFRE1Ed29ZMDZ0a01WdlV4WDJU?=
 =?utf-8?B?TDA2WlordlJTQ1FUUHF5K1RUY3pLVDN5SFl4R01HR1l1YUNwT2hFbkcvMVBl?=
 =?utf-8?B?VHc3TDU2cm9YQ0R1b09pWXhBZlBHTDEvWGl6ek1pUVF4SVN0Qkl0Q3Y5K1Vq?=
 =?utf-8?B?YytET21iamtMYVErNDlmaVpBanR5cjZlV2RRTGMrbTQwMVFmV3lDckdrMWtO?=
 =?utf-8?B?MnhibGJoS1lWelpCT3RZUUgvdG8vS3EyNUtEZTdvaUIzeUttUndKRUpqSmtr?=
 =?utf-8?B?SDJGSEhDZUcxSVQ4YzJUcXU4dXNWcCtaYXF1NTQ3SFNDS0hzc2taeVBHQ2ox?=
 =?utf-8?Q?a4B22qgIiuwDGXCe2pOyvFG1I?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0819f3-2e61-45ef-22a2-08db84726609
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 13:58:27.6894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLyfpOLf4YiWqtF4xr+3lmhE99yRc7Rr8AkUc5ip7aF/cV5xxOZzR1WPLK886PdZLJqqy5eY/ArAhQWCTmrWnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7808
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/2023 5:25 PM, David Hildenbrand wrote:
> 
> (1) We're unmapping a single subpage, the compound_mapcount == 0
>     and the total_mapcount > 0. If the subpage mapcount is now 0, add it
>     to the deferred split queue.
> 
> (2) We're unmapping a complete folio (PMD mapping / compound), the
>     compound_mapcount is 0 and the total_mapcount > 0.
> 
>  (a) If total mapcount < folio_nr_pages, add it
>      to the deferred split queue.
> 
>  (b) If total mapcount >= folio_nr_pages , we have to scan all subpage
>      mapcounts. If any subpage mapcount == 0, add it to the deferred
>      split queue.
> 
> 
> (b) is a bit nasty. It would happen when we fork() with a PMD-mapped THP, the parent splits the THP due to COW, and then our child unmaps or splits the PMD-mapped THP (unmap easily happening during exec()). Fortunately, we'd only scan once when unmapping the PMD.
> 
> 
> Getting rid of the subpage mapcount usage in (1) would mean that we have to do exactly what we do in (2). But then we'd need to ha handle (2) (B) differently as well.
> 
> So, for 2 (b) we would either need some other heuristic, or we add it to the deferred split queue more frequently and let that one detect using an rmap walk "well, every subpage is still mapped, let's abort the split".

Or another option for 2 (b): don't add it to deferred split queue. We
know the folio in deferred list is mainly scanned when system needs to
reclaim memory.

Maybe it's better to let page reclaim choose the large folio here because
page reclaiming will call folio_referenced() which does rmap_walk()->pvmw().
And we can reuse rmap_walk() in folio_referenced() to detect whether there
are pages of folio are not mapped. If it's the case, we can split it then.

Comparing to deferred list, the advantage is that folio_referenced() doesn't
unmap page. While in deferred list, we need to add extra rmap_walk() to
check whether there is page not mapped.

Just a thought. I could miss something here. Thanks.


Regards
Yin, Fengwei
