Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4528E752FB5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbjGNDKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjGNDKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:10:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586552D6B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689304200; x=1720840200;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XGK2Q6lLK5UdOSk1G+zBp1wP6otoMf3b44YN94qB+p0=;
  b=ApN4WyuqE7jvn91Ch4mYt6bAcuMyG7/nwej0erw4vFwG6y19hdu81XdA
   ca/tKvs8I6OJpgOR/zvGMSPnYnjFeEr9w1zegiwtMUy5lnKAf9ROYI2vF
   AYJr8fe9I3QPZvfwLpZFDYJbem9jqQr1kkASg/VYoBjw96wRQTPT1eWBM
   J/7MmiMkThV0Lzklpi7kn8Mp/hUExwndXUvfQiekW/JuTl29aJ2MAT+Xm
   nrH8v16f0LUcFe9O1GEPPrJcdFbSLsxn62P5itX5lZXz1HecMhyoaoVag
   EoyIA1hWDLtu2/vMnyPxGoTyAU1PGZFuXU8LLxdkX90OslwUtzQj0kHj+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="396186198"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="396186198"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 20:09:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="716177566"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="716177566"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 13 Jul 2023 20:09:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 20:09:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 20:09:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 20:09:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 20:09:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qx6/duOjKhH4FVVdDeUKE28qFunoI8GB3tenxqbGjmyYMBy3dWYZ1A0KUoFTqlHZeiY6zYmGOOph4sIP2MLowH2OWLY2lAw2tyhJAck6gxnLEpx2zUHcLmP5Qb5gDRPBV2/4fEN6mZRJpd8LmWzS6PGoyKUQyUVUUO1kfcRk/Nk8lrChiN3P/NFrQxaNJ+PkGJ/CEK1UkXWY+gRkKeKGSetZWBZXwRz+npkcAYBJrpPboRuYXbRwhqMnji6fQ4/8d3+vqbJ6egDrf4w1WcXWsVcpJGsbxZVj0ddFXEMoYptp4X7YMEW1nx25KIki6NxDYU3wsH/htoDrxQX0baStAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoEcT6I+jdPT9Njcqhb3q7wyh5ocJ2v8Gfdzcq2juy4=;
 b=buib/NSKljAYTJwDDwWS4EPOUunXF6RyKNSOe8OxqEIswwDYC7nnc9LozPtYWNN5GhL9xF3b7HGMOiEyGP8T1fvRCIPTliZJKlzME0qGGbZKxxPUtmPQ09luV87mTBMg0ziBGWwCsEkf4RdhcToe1uOQTvhUdqayOM7LzovSAnZmNTh8d+f6S/ZPsI0ewMrkT9pErIGDNHgTV2nEOhqsU1Y+gc9oB4uwJuN41o5Mnwbv7jB9A6dM01zv3Ur/XMUfz5GNeQNNGD3Gp4lc/EyRPBJ8e2JZjlG9l8FpCzOxrZRcWs+NSvorGK4gw3pc0HuZfZm4y1X22iAmdE6JEs6gYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW3PR11MB4569.namprd11.prod.outlook.com (2603:10b6:303:54::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 03:09:56 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 03:09:56 +0000
Message-ID: <8547495c-9051-faab-a47d-1962f2e0b1da@intel.com>
Date:   Fri, 14 Jul 2023 11:09:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] madvise: make madvise_cold_or_pageout_pte_range()
 support large folio
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <david@redhat.com>, <ryan.roberts@arm.com>, <shy828301@gmail.com>
References: <20230713150558.200545-1-fengwei.yin@intel.com>
 <CAOUHufb0zxKvmvEXfG4kySenxyPtagnr_cf4Ms-6si3bQTybGQ@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufb0zxKvmvEXfG4kySenxyPtagnr_cf4Ms-6si3bQTybGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|MW3PR11MB4569:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f793807-c5d3-4224-388e-08db8417cd15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33AnHuaypIuxBJkgx6MCYQy3/TQzaVsJA6o6UJeKCbWT5WkYghs3DLqiQC2TBPQfcHf2PrsZI1wUm5VjJdvZvSE5Kw4CavL+lMqbu6HNw/bHoZeFTMMJamtQvMwVKUuNP5qvgH1jG/97m56wlXlV85k57U9p2GB47fOZNBI+ZdJ6TT2rvwfvT1MbhlcErRwlsYsIvkGuXccUN8Zbgv5DsOEvo4njuaJ8aOSdADs6nq7IFkg7zXPP/bm7mybR3PGRkgwyJVhm5qaSDyxykV+WflFhH/qclNopDjNKaIMWfpj11sLmzKn8lwdjHtq/86zwduUkNMXwVEGPRgRqsWOMtrs9ivrcLUna6QpxGAL6n92DajBQY34Tj2Sr9yCL+1F7XftG1yNVjVYa5JUTMTS0o7yO2JzKFzlTrtwd43/5IOxZEVox4sKqZKNuxUTGKt95z7lOOE6Ebp8GuL5/e0zhk5RkqO+bRVfqNRV2oju+mjL6lCcC+cN4VrYRxWFLIWa/csybBZnk309PKVnno2MXGEaR44mf4of22s/f5+IZLUzCi8BoEdU+q1CY525Qiv0J9KvmX52oZ4UFNVGAOgoriDUFft6DeUEeQH6Fv7JMbg1PQG53Qumr2Qhg3PqIR+dmSqykCpYTtLbOqdhXS7zmJ8qjMpXw8sQrBS5EFFg6qf8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199021)(966005)(6512007)(6486002)(6666004)(83380400001)(186003)(2616005)(36756003)(38100700002)(31696002)(86362001)(82960400001)(26005)(53546011)(6506007)(66476007)(4326008)(66946007)(66556008)(110136005)(41300700001)(5660300002)(31686004)(316002)(8936002)(8676002)(2906002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE9xWGE5eHJXdHNSdVorc2xsU1hhbkl5T0wwLy9WeHZKdHVIb1M2cERkbkxo?=
 =?utf-8?B?UzZXb2V4M0t1NUd1WjgvaGlsUnROZzEvdkUwS1ZtNFpVWWhRM1VFVWZhb2R1?=
 =?utf-8?B?VUJZK3ovN21Fc3NIUEIrbmE4L0VYbjE4cVhqQWZhZnR6YU9FOWVzNTYzL0pH?=
 =?utf-8?B?VWp5cFphZVZ0RE1jd2VDbmxpdDMzTHBmQ0JOUUNjYzdZVEFZY1kzWGF1ejhh?=
 =?utf-8?B?M01NaHlaTkhMSEQrV08zZ3RyZlNndlJCMUhtY1FPTjhDOHJ4WmlpY0dhREpM?=
 =?utf-8?B?Nk0vdDNNWStLcFBubG44OFpFeXZ4a0xRMVQwWHQzWTE3Y3l4MC9KNEVEYVZa?=
 =?utf-8?B?Zjd3b0VkZ1V1MHlZeTBERFpxbzV3eWVUMVVrWjMrcHZqaVFIbi9yUWtiTVNM?=
 =?utf-8?B?SEZkRTR3ZTIyeFFNckxjeHVDd05xR3RTeVo2bUFXWitnVkJoM1NENnk0MFRR?=
 =?utf-8?B?RjZ3dGlLMi9rVXczeW8vMCticDJNeitiK3A4NE5MQlpOTnFQSUN0d25EM255?=
 =?utf-8?B?aXEyMVdIWHhFcWlQSFRTNmxkQWE0SnNvVzNBRmwvWmgwVFNsUEtUNXhJbXFw?=
 =?utf-8?B?UUZqL2tmOW9CSW1pbmJDSmtaQTV4YUJUb1dNSEw0eXA5VFVlT2RVbGNXSEZH?=
 =?utf-8?B?b00wblVONklSTkZUclQwc0VnbXQ2T2dVdDY5bWNKWjhPR3F3L2REem14YVph?=
 =?utf-8?B?V0FiSTN3bjczT3dWVmtuRTU3c1NpL3RsdlJhZkZ0T0d2Z2pORUtwM1lXaHNy?=
 =?utf-8?B?VnowN3V1ZFc4K2hGUUdlbEpCK3htOThzY0VlMzdHT05QMmhtSE95TTJZTVlD?=
 =?utf-8?B?K2hHeTgxc0oxRnRSTFR5RW1kaGtjNTg3OWhLUkZMMmo4QnBZTVJwQ21vamV1?=
 =?utf-8?B?b0hYNjI1cTg1R3JDSmpRVUYwc0ZzNFplQVY1aUZoTm9GREtNM2IvdW5rZlYx?=
 =?utf-8?B?ZU1vbFRhZzkyZzQ2QmFiYWxON2ZNUHIzeFFTRkt5TEJ6dSt4YjlvZytBMTNv?=
 =?utf-8?B?NmZNL0QyWm83SFVUMmluNkNLQ1VHR2RQblM2RnZBdnJEMk9tMmtSVGswbWJT?=
 =?utf-8?B?bFd2TWhFcWpCRlR6dWNtRnp3TVgrVzBUNjNiSFMwT1dFK3BmVHJUSjYxNWZr?=
 =?utf-8?B?RUEwb1pTR0krWWt1a1FZcEtwdHlJeXdVcVdaYm9aMFdibTdEWjNBdSsraVF2?=
 =?utf-8?B?UFF5OGJzRTVtbmZ1MStteERXZThMc29sVVBkNTZOVmh3c0JXbk01MHQ0UEsw?=
 =?utf-8?B?MmtNN3pDUWdNMGl4eUlRWVNGVGM4UjFTSE1mWlQ0anBZVVpnWGw2T05JaXpi?=
 =?utf-8?B?UXg1TWRud0hRa284eGNmVHBNdDN5MTFDYW15TUhULzROVDQxWkk3T0N4Y0lv?=
 =?utf-8?B?NFZ5RDhqa1ZYQ0psZ3F0V21ZdVZUQzFpaE11M3YvMXVjUVhjK2QwUFpBSHBC?=
 =?utf-8?B?c2sxVnF3Rlh4T1FIVmlzaFExZmtnbmpHaTVjdGh4NkJ2YjZHWWdSU2QvYXJ5?=
 =?utf-8?B?eFJXN29yMjU1VDlqd1NmdGNEOWMwUlJseitHUjd1Z000WWNaSzJKaEdqUzZJ?=
 =?utf-8?B?NVA0QW0veTMreG9ZbjkvL1lQcCs5UFlvUzY4a0JJcjY5eGdISXI0L3J4cmp5?=
 =?utf-8?B?bWpTa0ovWDlrYXRVSUdLTXMzRGRzdWVMTTZKdVAvZmVMYllOckFnSzJ3YWtj?=
 =?utf-8?B?am5nZURKclhIYVJLOVJVUEF4SEl1QWxtUVJnQVdOVHNuUnU5SUROL0UwUXBB?=
 =?utf-8?B?aFovVWtiYUNETlBwbHE4ejVnRHNWcW1NWm9kd295NFd0QVhLakRpZWJkMnpG?=
 =?utf-8?B?dk11Zm9QZ0o4Ly90VmJZOENGM2lmanNydXhvaWZGL1AzZ2RGOFlMN0ZFL1lJ?=
 =?utf-8?B?a1VYc090emwySG9BelVIMTdBRWRHK0NraldqMXk0a21jTmtyTVJtUnJYOWlv?=
 =?utf-8?B?NDRyNkNSc3Evc2ZnUkdWQktKVG1KTHBEczBCN1hmMXhqS3h0M0dRb0F1cVh0?=
 =?utf-8?B?TDgyU3dTZHhoVzlKaUl3OWxja0Z3ZEk4RENhOE42bXIwTkVlWWtRK1dsWEFn?=
 =?utf-8?B?Z09vMzRlNGxnL0dpQi95M1hqVWlQZzN5R3hvZVcxd3cvY1RyQ0Rmb2pXeW4x?=
 =?utf-8?B?bTFhZFZvMHM3bnhpdldybTQ4aGNPV2Q1UnJNcjVWdWQvRWZ2SVQrL0VtbjBK?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f793807-c5d3-4224-388e-08db8417cd15
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 03:09:56.5222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwxS5s0OvTSeYReLKRxqviTomXwEe2wPa/ixL3SwtKuIf+oi2BEczlR32UUgLkuG69I1z6Ewk7uObSs2iHFoBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4569
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/2023 10:08 AM, Yu Zhao wrote:
> On Thu, Jul 13, 2023 at 9:06 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>> Current madvise_cold_or_pageout_pte_range() has two problems for
>> large folio support:
>>   - Using folio_mapcount() with large folio prevent large folio from
>>     picking up.
>>   - If large folio is in the range requested, shouldn't split it
>>     in madvise_cold_or_pageout_pte_range().
>>
>> Fix them by:
>>   - Use folio_estimated_sharers() with large folio
>>   - If large folio is in the range requested, don't split it. Leave
>>     to page reclaim phase.
>>
>> For large folio cross boundaries of requested range, skip it if it's
>> page cache. Try to split it if it's anonymous folio. If splitting
>> fails, skip it.
> 
> For now, we may not want to change the existing semantic (heuristic).
> IOW, we may want to stick to the "only owner" condition:
> 
>   - if (folio_mapcount(folio) != 1)
>   + if (folio_entire_mapcount(folio) ||
>   +     (any_page_within_range_has_mapcount > 1))
> 
> +Minchan Kim
The folio_estimated_sharers() was discussed here:
https://lore.kernel.org/linux-mm/20230118232219.27038-6-vishal.moola@gmail.com/
https://lore.kernel.org/linux-mm/20230124012210.13963-2-vishal.moola@gmail.com/

Yes. It's accurate to check each page of large folio. But it may be over killed in
some cases (And I think madvise is one of the cases not necessary to be accurate.
So folio_estimated_sharers() is enough. Correct me if I am wrong).

> 
> Also there is an existing bug here: the later commit 07e8c82b5eff8
> ("madvise: convert madvise_cold_or_pageout_pte_range() to use folios")
> is incorrect for sure; the original commit 9c276cc65a58f ("mm:
> introduce MADV_COLD") seems incorrect too.
> 
> +Vishal Moola (Oracle)
> 
> The "any_page_within_range_has_mapcount" test above seems to be the
> only correct to meet condition claimed by the comments, before or
> after the folio conversion, assuming here a THP page means the
> compound page without PMD mappings (PMD-split). Otherwise the test is
> always false (if it's also PMD mapped somewhere else).
> 
>   /*
>    * Creating a THP page is expensive so split it only if we
>    * are sure it's worth. Split it if we are only owner.
>    */
> 
>> The main reason to call folio_referenced() is to clear the yong of
>> conresponding PTEs. So in page reclaim phase, there is good chance
>> the folio can be reclaimed.
>>
>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>> ---
>> This patch is based on mlock large folio support rfc2 as it depends
>> on the folio_in_range() added by that patchset
>>
>> Also folio_op_size() can be unitfied with get_folio_mlock_step().
>>
>> Testing done:
>>   - kselftest: No new regression introduced.
>>
>>  mm/madvise.c | 133 ++++++++++++++++++++++++++++++++-------------------
>>  1 file changed, 84 insertions(+), 49 deletions(-)
> 
> Also the refactor looks fine to me but it'd be better if it's a separate patch.
OK. I will split the bug fix and refactor to two different patches. Thanks.


Regards
Yin, Fengwei
