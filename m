Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2B676F676
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 02:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjHDARt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 20:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjHDARr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 20:17:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DF53AB1;
        Thu,  3 Aug 2023 17:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691108266; x=1722644266;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=784A0RTF5iH0nqCR3z1UnX5aUrE78UQ2T7+BHcP1OA8=;
  b=ZLJVmlIlVLJyZUX7JvahhgBtodf0r2aSDLi51gZGfJSHBgC2ZTbZyeAs
   dZCNdY/Au8hyCHho0bWtmm2nF2wjdVT2W6eSfRvnjrsGb1OKFVkYb66GI
   FPkarbw76LvPKDMZZ+dLcc1WaAdFobWWzvdDjAyIhUIx7WBub61XKV87k
   uG4Rq9BT7ls5Br8IpXtigLUh0/dEdr4Zv0mvxLlsMXM3ny01VDCbkSiVU
   0vpJntxTgnyzhc87gNB6eC02FVI7d3W+JNtn4pFwmYSV+7lUMV3ZQVWzC
   2hA8nj0yZVANEAMWaI38b9Ncsw7TCje8CXOoF+vS0oii+4MRrZ0RetV8h
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="456399688"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="456399688"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 17:17:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="764883141"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="764883141"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 03 Aug 2023 17:17:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 17:17:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 17:17:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 17:17:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMakeNkQTJ/yUY1S8Z5x6ranl2tArUzNd6rwv1/oepdYNIKgjdQ8Gt//p49rOVqMIvpJnRqQEO370OcOo7PcJ5gsSNHe941FF5tL3Y3d1J6nL1KJ9zYiKoEsfhzJy9YQ5MuF2UDsiVoqVU2+0wP+H/DKtr4CnZldxTgzikbRaQ+RCLbN3EJmSBnnG5DzR2gqr13MVXg9a1vUfuiiz3P95gMQ7KEJqnQuWC02k1WFSSrXshWzULcMLksnvQ2qcI8Kkiu2K7O9z7x2wCtubha5vUS+xc9zjva/qwelCeX2WRiB7G+BtzVwBBNkY6ontBmpF6SW6O2+i+NXCjyIdSY+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvDc8kG3LyvPX2X2vJR769nvg62ac/uGtLaSvOpbkPA=;
 b=MMNNOs/PQuziUqAUx9+AD/1zL5+NzunDDnPtkLKwb5Jo4di1b4SWboFSBSZN432kttTO1rDpoHToScvBelwA+PzZ52p9e184iuTnLD69DwRxCOO9j9lWJreXiNJ8onUPbuJ3v4Rq21UCNaX8MDhNGcvGSQDUsjRpy5i+R+sfuUWKKpxHIVjn6XmN80ujokOyb8pUZMXgwlmMkzNTuMr5GpEacppZps3rCn2SkMDChLtV8LBcfmrhuFXKoSlU3dExz5AzX8H4gXk7msgDZmN/tMo9VIwGibEQm0YF1lHruHYbRhnXuqMGMxMkzhzTyb3aUMCY5DNj17y4uvvOTw5LNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SJ2PR11MB8298.namprd11.prod.outlook.com (2603:10b6:a03:545::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 00:17:35 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 00:17:35 +0000
Message-ID: <45457815-66c4-029f-42f9-6c377e4eb1e3@intel.com>
Date:   Fri, 4 Aug 2023 08:17:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] don't use mapcount() to check large folio sharing
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>
CC:     Ryan Roberts <ryan.roberts@arm.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <vishal.moola@gmail.com>, <wangkefeng.wang@huawei.com>,
        <minchan@kernel.org>, <david@redhat.com>, <shy828301@gmail.com>
References: <20230728161356.1784568-1-fengwei.yin@intel.com>
 <3bbfde16-ced1-dca8-6a3f-da893e045bc5@arm.com>
 <56c8f4f9-b54b-b0bb-250c-ec8643accfc7@intel.com>
 <3541d2de-5cf8-2f84-8153-277e2bfc0101@arm.com>
 <5f98748a-97ca-6426-1e24-a5675da75381@intel.com>
 <a590da86-0c42-7d46-d320-c661a59a46c1@arm.com>
 <837ba176-c97f-f81b-c044-eb6aa3d88bb7@intel.com>
 <CAOUHufY9EQ70Pn-n2zVa9=Gm3-WHxxphp7VHia4qv9x2domdbg@mail.gmail.com>
 <40d49276-fae9-e538-61cf-64bb79233bc3@intel.com>
 <CAOUHufbcAJWUoVuCYtaDZKdcw+JPWVV0EiB=JcDvz1Jt_Au2Tw@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufbcAJWUoVuCYtaDZKdcw+JPWVV0EiB=JcDvz1Jt_Au2Tw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0046.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::15)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SJ2PR11MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c4b7c6-ba19-452a-0825-08db9480340c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NuChHemPkfd4RHLJIwMH5MLdDRU+X++Yf+vNduHCpSt7U655U98GVZrIzHOItnW4eZgBpd2UxM2IEEI6U3XuFfxRH8KsvrZmvOIsKuQiTNBpR9vV58pzNBdn8qXJyoh0DWPUUeqcN+t+eDCzLYCdc75B0NTckaT/AVGYA78MzeDiSBiV/dXc7CwXu/FSPptQS9GSeA7DGsRgvLcpr9aaObfTO++XGkmt//M7OU3Pt9U8axvEoI/cyDVsAkvtN0q6Ye2ngwUEu3j+iL/WApg8kpgxyFrRo63WGrh0iaVhsb4nUUGiUfJp0krbqAABX1fgn7MIxw/UHoqtJI4ZIzd1ltrzrZl022Z6tCVvEFp4P139Br1A2CMaVneoHhnLp1moq5jgf8/3eabicMXoG2FPer4aINOoXaJLHSTvE+0WzF5Th49p040/9Evbfk3s0uqE2qsu6V5JYpUxWLL+4+pOV/JTApUYTZyoEUt1/JGxndzZF6TeRnrkt1HukBmwCSkjV0yHqGB9DOUUAtxLiWPw3i4LzSnqSyjGgYmhjgnrRPeDleQ0KNyksPEjFvsxy70ATezXZWmOobGEeVYlkIr/sUii2m2mC5MVgMS+FqWWeeTHcE/USiNq0VTXoBdR1WHhGrei3Q00adj33zoS+iUArg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(39860400002)(396003)(136003)(186006)(451199021)(1800799003)(82960400001)(2906002)(31686004)(7416002)(5660300002)(66476007)(66556008)(66946007)(8676002)(83380400001)(41300700001)(8936002)(4326008)(316002)(6666004)(6916009)(36756003)(6486002)(6512007)(478600001)(86362001)(38100700002)(2616005)(31696002)(53546011)(6506007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHpnNzE2aHlhSlVMSGU2RStraVcwVzNzRjE0cUpGaXNjODRtcWd3MFh4UFJ0?=
 =?utf-8?B?bXpPWGkzcTBMSFpOZDlCMm91WEQ5bFI0dEdiZEtBVDBaR3FqMFR4K1VFdnZq?=
 =?utf-8?B?eFJRYVc4eUo1YzRMbXplNFFXdWlXU2VMK1BrY3k1aW10RmtlU3NkZEVKd1ZJ?=
 =?utf-8?B?SWpQZk9zR1Q5MTlRMkZULzdBd1o4VStHaUhxM0tiRDgwRUtJcEg4aXg2b2s5?=
 =?utf-8?B?UTR4YUlTZzVXaWZjUURsckdxUk9PTVZHQ1Q2dHh2ZldsTTBHajJQY1RFbjRQ?=
 =?utf-8?B?by83Ynp6a2RFd0hFYkVVRDB4a1loVHF4NnRyT0lNTEJ1Z21qUEJaVXc2Nnox?=
 =?utf-8?B?Vnl0d0E1U1ZLYk5WbjlYZkxMRU95Y2U0Y0VZcWNMbnc5dWpsanZuZ243Mjlz?=
 =?utf-8?B?VjJtdC8vQm1GYmYvdm9JaytaVFBEUWxNczFGaFp5TjJYb3kvWGJ2THF4RTho?=
 =?utf-8?B?YUpwQ3l0RFV1QXpTT1JwWDFGaWNYNmJ5RTY1elNHaEVaNHQrUVJrUU1pRkVm?=
 =?utf-8?B?L2NtQWtOZnE1bzJwWXRUTXl1S1VXOSsrbmtLc2pLUWxRdjlMS2txelRkZnhQ?=
 =?utf-8?B?d29KSExIb0c1Q3NZRlF3bm51dyswdG1TbXd0MzRRSlNZME85SGY2WkRKNnI0?=
 =?utf-8?B?Ry9EQ1JnYks0RnBSK1d6TmFtN3pJV0NZN0ExSmp2RkhGWE5ORWxuQzBkaHFo?=
 =?utf-8?B?Z0k2SWFzVGNXeWR6Z3pIS0hlNDhKQ1ZBZWZHS2VEdGtRMDRuTlFRczNIZWJ6?=
 =?utf-8?B?S283V0tFcGdMVnREeDhsUlZta3dwL25hcElCSDRBSVZ1TnFtditBMlpsWGRC?=
 =?utf-8?B?WElIY2ZrK2VDS1RKRWZPRU1MQkh6TXNaZXNVb3d5M2l3dzhFZWxTdW41bXdh?=
 =?utf-8?B?SFJGVzU1end6WVFUNitKT1Q5YWVMOWdJSXFRTnhrbDFWMGtnb0pJdTBSbFg1?=
 =?utf-8?B?QjZnanJLY2pMQk8wR0xFU0NjRk5FMmRqSklEZFhoU1ZTYmhQVE5ZWXlualVH?=
 =?utf-8?B?TUpyWXZycjZGZDBpa2hjN09iTElwWHlmNUJMeW5yTDVqdVcwMFVERFBQcjFk?=
 =?utf-8?B?UFdiaTdidXNGeTlSUkRrYmNSS2w1Y1AyMllVdUI0b2IyWmZsd1B3UUxWV2pZ?=
 =?utf-8?B?MUl4am51ZHIzcTlTQmJBRWJTZE5GOTVjMkZicjN4dDIwM0MyVGkxYVcxYXJP?=
 =?utf-8?B?UlBnYlpuMDdqMG93WUw0Q05wWnU2bHdzcS9YVXRSaVhLUnpoeEorSDUyVWlH?=
 =?utf-8?B?TlVLODVoWFRwNXVsclBiTlpsMVVWNWFFdXZlR2Q4Ylp5alFPbTBlSS90aHNp?=
 =?utf-8?B?bHlZTW9MOU52dDBGa1B2K1FXblNFdXUxZm05RDg2NGs0YktBRjRYR2JOOUE5?=
 =?utf-8?B?VjF6MENyYWlTZlR5WmcyUU9vNmZBZjlMbGE0bHFwRGxzcUNmRVVFdGt3UmxT?=
 =?utf-8?B?NWtiZDI4RVptMUFWalMwZUNUcWJYcGhaVlNUUThYQWg5MldLem1kWDhTdmNZ?=
 =?utf-8?B?RkRLd09MWFVGZ3RyY3pwRHFSYWZPYWlrOC9MNmtvU2h4cUx3eFltQTlVaWo0?=
 =?utf-8?B?ZVphWjBJQTg5SThoSzFCWkxndWlRbW9LMGI2YmFpWlFZYWlNZVc3U0lYeXhN?=
 =?utf-8?B?NE5CV0JOc3R1MURHakdmN0JFZmE0R1ZFODIyOW9GL29LR2J3bE5ZSGJNYWJy?=
 =?utf-8?B?K2g0TzM5NWxQc1g2YjZTeFFsdWg0akNBdTVsaXZNcnlkYTVlNmdOVDJyOU9p?=
 =?utf-8?B?VzE3YnVVcjU4TFhIWGNQS0p1RWR5WEJIcFg2ZGVIaGtiVlhCdkE1T1pYajdl?=
 =?utf-8?B?WGYyNVZpOUlaVEx4bUlwSERKZXhjRVN3T2x5WlVud1p6WXhRMGhnMHkzWWRN?=
 =?utf-8?B?VFdpYXpQTzUxK3RiK1BvOU1rcllUNWJhanBoRWEwY3J5dFRlZVVYaWgxelg0?=
 =?utf-8?B?RU9pNnJUbEhFK05KaTRYK05vcGgvTFczOVNLZnV2clc5Z1phTVMvdEI4ZDc1?=
 =?utf-8?B?bVVwRElLQ291QkdIaTk0bWd4WGwwT3oyYWxteTcycC9YOFVaWi9Nb0ZhYm5W?=
 =?utf-8?B?dkgwaytZNUYvQkxKOFBwSnkxekhHRkYvWm8zKytxUEVJczF1U1ZKMmkxODZF?=
 =?utf-8?B?dzEwNEgrZ3JjcWdqVk83eHhkRllIME5JblpFbmttZlp5dG4zY3RMMDR6Z3BJ?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c4b7c6-ba19-452a-0825-08db9480340c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 00:17:35.5871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRJN+ROXUUZDn8yB7iNRX8G7LKblKHRKlSuTjY88T3zohy3O36DtUMBsGqPwZ3KxvpMl5e+uDpxuU8Fp/E0mXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8298
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/2023 7:38 AM, Yu Zhao wrote:
> On Thu, Aug 3, 2023 at 5:27 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>
>>
>>
>> On 8/4/2023 4:46 AM, Yu Zhao wrote:
>>> On Wed, Aug 2, 2023 at 6:56 AM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>
>>>> "
>>>>
>>>> On 8/2/2023 8:49 PM, Ryan Roberts wrote:
>>>>> On 02/08/2023 13:42, Yin, Fengwei wrote:
>>>>>>
>>>>>>
>>>>>> On 8/2/2023 8:40 PM, Ryan Roberts wrote:
>>>>>>> On 02/08/2023 13:35, Yin, Fengwei wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 8/2/2023 6:27 PM, Ryan Roberts wrote:
>>>>>>>>> On 28/07/2023 17:13, Yin Fengwei wrote:
>>>>>>>>>> In madvise_cold_or_pageout_pte_range() and madvise_free_pte_range(),
>>>>>>>>>> folio_mapcount() is used to check whether the folio is shared. But it's
>>>>>>>>>> not correct as folio_mapcount() returns total mapcount of large folio.
>>>>>>>>>>
>>>>>>>>>> Use folio_estimated_sharers() here as the estimated number is enough.
>>>>>>>>>>
>>>>>>>>>> Yin Fengwei (2):
>>>>>>>>>>   madvise: don't use mapcount() against large folio for sharing check
>>>>>>>>>>   madvise: don't use mapcount() against large folio for sharing check
>>>>>>>>>>
>>>>>>>>>>  mm/huge_memory.c | 2 +-
>>>>>>>>>>  mm/madvise.c     | 6 +++---
>>>>>>>>>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> As a set of fixes, I agree this is definitely an improvement, so:
>>>>>>>>>
>>>>>>>>> Reviewed-By: Ryan Roberts
>>>>>>>> Thanks.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> But I have a couple of comments around further improvements;
>>>>>>>>>
>>>>>>>>> Once we have the scheme that David is working on to be able to provide precise
>>>>>>>>> exclusive vs shared info, we will probably want to move to that. Although that
>>>>>>>>> scheme will need access to the mm_struct of a process known to be mapping the
>>>>>>>>> folio. We have that info, but its not passed to folio_estimated_sharers() so we
>>>>>>>>> can't just reimplement folio_estimated_sharers() - we will need to rework these
>>>>>>>>> call sites again.
>>>>>>>> Yes. This could be extra work. Maybe should delay till David's work is done.
>>>>>>>
>>>>>>> What you have is definitely an improvement over what was there before. And is
>>>>>>> probably the best we can do without David's scheme. So I wouldn't delay this.
>>>>>>> Just pointing out that we will be able to make it even better later on (if
>>>>>>> David's stuff goes in).
>>>>>> Yes. I agree that we should wait for David's work ready and do fix based on that.
>>>>>
>>>>> I was suggesting the opposite - not waiting. Then we can do separate improvement
>>>>> later.
>>>> Let's wait for David's work ready.
>>>
>>> Waiting is fine as long as we don't miss the next merge window -- we
>>> don't want these two bugs to get into another release. Also I think we
>>> should cc stable, since as David mentioned, they have been causing
>>> selftest failures.
>>
>> Stable was CCed.
> 
> Need to add the "Cc: stable@vger.kernel.org" tag:
> Documentation/process/stable-kernel-rules.rst
OK. Thanks for clarification. I totally mis-understanded this. :).

I'd like to wait for answer from Andrew whether these patches are suitable
for stable (I suppose you think so) branch.


Regards
Yin, Fengwei
