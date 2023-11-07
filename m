Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D657E4656
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbjKGQoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjKGQoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:44:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C0593;
        Tue,  7 Nov 2023 08:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699375451; x=1730911451;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A6QjB7g7YEfGq9Y8mgIhi0AUnnX3jzQGt7Ss1lwCVH4=;
  b=DawF0wbJlFDb3crG3qDRKH0Zt1LkqlNGl4sIWcT/Hvl82zWWZxBhdi9t
   Xd7aAObdbvOt5L97aw5Ya7pYx7Lww40Yx/6AVa3MLnvFzeVvEtZtTzcqb
   9ocXXzzcszgeN9TKnFSWD2xR8mlD6UkLzhg9OqvjQit8Bj7pZPL5Y9LQZ
   q+vim9gwqRWZ7bus4whpBEGpLam6+VwHU+sgDLJC1lrviOJ7zVqMkMxv1
   D4o9eGACO38FtzUlqk7uUVYEutnjhDRbpychI+R7rsRloVv+aEX5UvJvc
   nzfEaNuDJCmuTjL9bJ+RNeZixm895TZn9r9qojONaaNWbO6Va+pVW6VLR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="392423834"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="392423834"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 08:44:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="10491113"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2023 08:44:11 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 08:44:10 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 08:44:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 7 Nov 2023 08:44:09 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 7 Nov 2023 08:44:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElXRaCZ7y06LPy5jV9o5sYJHlVnIkPjO0FwpqOvGbCAAPugdfXy14Qm2aTP8v26vsy/2Hb7tx185fjlG+DyIsq9FZSdDdmbF4LRucBAu4/GmDubVH2YIFlyYCcUhv3/ztlZMuZDROlgSy0ZjsfOUCjEyGOlNZc7uG1aQqjFYs7UVZfCtjeujnMssf8Eoduxuli+eVi9H5+gzWnhzzwEFOSgP9QEzTA1ZwX0XCoW88lH1umnEZirrGasGQ+ICY21wQBbIS6lA85pCkNfwU1LbNYB4By0ybwV8jWn/+2IH8OQV0VSd8UKCS3R97+rWSOa/Xaq35+E7C9BDMVsCZnYOyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBT2uBbqHKfRfIleW3qLN72ZtwPLcBl/Yw9lrMBwcFU=;
 b=LYxejLCkYMWUiCjpkxtWSy1acvb0OWO/34EOyXmafJ5jwcO2wEEAsBhKR449wUzhR6mRXoDlR9wvMemNgUtgj/o1+RiKezAvYzPWN+gprJ1dVP7o4P/HXH8ahHre+kj/L7Nmww6lR7GFuTlNGCnCX2KfR23BWk+X7Tg+PwFFNEa/6NDb5b0h+VGvujVCbhKjfj+6BMsaINHxtuWuVTsnOtDmJapC1+5SBCBHF9fbIzyZOUOP/Q234UfwFBd7LQCs0BUoCCHi41xF8WETOl5kHvrr3zo1SagZS2sRX+6RFpigVHr5FQlqbzRG2O2Hg6m6+n6CW+m4Vf7H5C6/SKPMnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by BL1PR11MB5980.namprd11.prod.outlook.com (2603:10b6:208:387::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Tue, 7 Nov
 2023 16:44:06 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 16:44:06 +0000
Message-ID: <ca0ad357-727b-4f41-a3d6-2c48a9dd5836@intel.com>
Date:   Tue, 7 Nov 2023 17:44:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [alobakin:pfcp 11/19] include/linux/bitmap.h:642:17: warning:
 array subscript [1, 1024] is outside array bounds of 'long unsigned int[1]'
Content-Language: en-US
To:     Alexander Potapenko <glider@google.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        <oe-kbuild-all@lists.linux.dev>, <linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <202310170708.fJzLlgDM-lkp@intel.com>
 <bd7fe929-c6fc-42be-9d2f-3f53ec21fd10@intel.com>
 <ZUkvOCxyiin_77qd@smile.fi.intel.com>
 <0a29df6b-bc27-43e9-a97d-57ecabb29a9e@intel.com>
 <CAG_fn=VtA6e3oGm4WVnxmy9yMBab780-U_4VoHSqm4tcd2UTzQ@mail.gmail.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CAG_fn=VtA6e3oGm4WVnxmy9yMBab780-U_4VoHSqm4tcd2UTzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0041.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::27) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|BL1PR11MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5980e0-8e44-44d3-c7a2-08dbdfb0c187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hCf4zp4ccsrliNXFfKfzXj9yRboURrYWmd1m9dlqNimYrDgTHbHvIQpgOMeEofSXgljWraYv67albs8iHX4+xg/LtOU7ZTeA5a4RD4F1KId/kuP3bbq1w9KwmSb9j/EpXqkWa2/LyUWM5+6VchrQMxDCqCOabUTn+VVX8t7lIzX5qonL0ZKVlzQa7Q/K3ibc6XCwnKZBKn40d5C9XErLN0fhKxOKsEU/YQ9TmxQ240axl16j73Lbwb0B2C5CyEVvqrVbY0tyJbYlH8wZW4LfKuM+6AO4qgP3OQmJlOYnkFpPT8Gz47tACDbrIFsPriiTF04FSpur4uhmFDeJzewXJCdVxGwRfTjGscYk9YrU4ts9j+SA1NH3vEIS7qw6Jr/G0j3EHAA9XZF2BlrvCdAvll7gFp4suItlos2/pLQriopZBw2XaIsXteF4RPijFNBICjsyDOkBKKaW+pmRSzqrSTOXnGDPFdtHLOYtnRcyx4/6hNF2i75UZhx8ZdN3rEyoPAUVuxoHwPe5TF0ZwSsr4TZDfJ4SXn2pRod1q9ktDWEQ03zPug1U+DpUnmSR5FFeWrgB2CshIK9XzSLCw8LXCJRJRtzX164q2B272Oqy4tjMJpxjoJgkgfTBLPpdSOIjvbbmblBcytXb5xV1JWnfbdbrRYyqhEeqgG3hqSTtbmHoRzNZMakOeBOlU4nUiRmnt81EDzxhX6HG05ioIfPaHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(66556008)(66476007)(8676002)(54906003)(4326008)(316002)(6916009)(66946007)(31686004)(5660300002)(8936002)(2906002)(86362001)(82960400001)(41300700001)(478600001)(966005)(83380400001)(53546011)(6512007)(2616005)(6486002)(36756003)(6506007)(26005)(38100700002)(6666004)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGNiNjhubjVXWFpJOXNoUDRkS1hQcjkzSmRUaitRK1VTZXh3U1dOckt2VWl1?=
 =?utf-8?B?V05HZUhRWU9OZmJnRER0bkVGSFdXMUgzM2F0NVhPS1dqSFQvcWgyK1drUlpk?=
 =?utf-8?B?emd6R0tCc0xNNi9NN25EeEFwbHl3bzFGK2JIRUNrUk9SM1JleHAxUzAzOUw0?=
 =?utf-8?B?aVd0UUQ3dTVmakNPblRmbWEyRS85cnlkOVIvdUJGZDZMdHEzNnJjQi9iTk54?=
 =?utf-8?B?RmJydUpUY2I0SE5IT3NwY0UydlppRGdlWlNjeU1xbzBId0FBNEsvMDloWjFT?=
 =?utf-8?B?ckJtRWN2czhsU215eEJRSHVjZERmNzhCMDM2dTArRHlqejlidUdhSDVaelJt?=
 =?utf-8?B?blJuUDVVa3h2OHk4RERxaUo2RXUxV2FaMldpM3JGeFNuWFZ5SkwrdU5DT3No?=
 =?utf-8?B?SEJXemxhQkNhcVlsZUt3WEdTOXlxVm1uNndYRTBxaE9zSFFScEZhV1Y2RnAw?=
 =?utf-8?B?VFlWeEhMNjFDNFFxcUtUenVFVEdNbHRiZnFaQXM0cmdJaFZlZkJPckd0dXNO?=
 =?utf-8?B?OU9sQ0x6NnFIUG8xVzdvalJjbFQzeC93bGJqWmxjdy9TbWlvNFlsWktzZzll?=
 =?utf-8?B?Uk5ZN252cUlVSDR2ZHlZbVR4YnAybm1IdklEVlVocUtjSUE1OXlpTTNJY3pT?=
 =?utf-8?B?WG5vL1NmTHRHVXQzNWpNNlAxQkhLc00xMnBMSWl6OVUwSjJONnF0Nm10OU9v?=
 =?utf-8?B?ZzFZaTU5R1JYZDRYMmdlUUdoRXhnVUdCSHIyeUtBbjZyalRVdks0VUV0ZUZP?=
 =?utf-8?B?VXNzUS8xTEVoM3BvQ2NJT1NKUjkzSXpOOXFSUXJzOHI3UXdlUU5MRndGQ1Nx?=
 =?utf-8?B?TkdNRGhvNVZ5MWxsSWRuVFdDWWppQlRJMFlHcGZGek4vaG43aWphYnpKWkxn?=
 =?utf-8?B?TEp3S0NWc3c5WDNZbHJTd3QxTnJJT3diTjhhOExUOWJlZHlIbjdWT202NkV5?=
 =?utf-8?B?YnVvM2xNS01RVTBiZlZYZmFNOGdkVmliSitUMytSRVFoNHNCWlhTVzNBYWdF?=
 =?utf-8?B?M1ZUTU5Rc2hLRDE4R1lPZWlYaG1RQ2J3ZHJ1OUo5MTdRRzd3OEc5dmQ3d0tx?=
 =?utf-8?B?VUVKOFZZVVQ1N25CNS9NVnhpRFBHbFk4T0hmOSs1dlJkQjZtcTdkTjNxdE9z?=
 =?utf-8?B?UTh2c2g1VEREY2NYTGtwRVVDRjdQc1p3bmlKYTJlc1kxOTJ1T0pJaW5GLzVr?=
 =?utf-8?B?dy9rMVU5cVl2K0t5YmQyOXdFNFFsNnR0WjdHV0RKRytWVVVWbmV4M0hZOW01?=
 =?utf-8?B?aDIrQlZiSjhFT3FyTjF0bm9GZHlLRjMrVHU3OXJXWDZKYXBCd01LOGRVdit0?=
 =?utf-8?B?b0k1Ri9TK3dXOTJETUlCaTlrdmFTZHBlZ0JTN0ZjamxxajZRNjJaaE54T2dH?=
 =?utf-8?B?MmpuYzVlTFNNQTBQOWZjQWl2RGs5TThXdytsdGQ3dko3bUhUdlpUWVcrSnFs?=
 =?utf-8?B?YzcyQ1pZTHQ4Nm9LVVZYamY4cDVZVHV2QnlVdFJ1YTJnTHFjMHBFVVJwUmg3?=
 =?utf-8?B?VlE3SU9kRXoxTTE1alZ1NWZUdGRpK1Vob3laU013eEJrc05mVG40ZC9RRDB4?=
 =?utf-8?B?WnFKZDVUYnNBOTZzRmwwbUY4Ynp4bkRkYVpnTEp6YVgyYnB2Mlh2QzRmTEdh?=
 =?utf-8?B?eEVBMFc1VG5VVkp3U1c4Z08yb1VvLzEvaDRGSVRYcHgwei92eDhOTVk0WlJX?=
 =?utf-8?B?alluWUlGYzdyWFRneU1mZkU5TW8rcmd6ZUNBUm9pWCsxR05mVjFUQ2RUQzhm?=
 =?utf-8?B?NGJxSHFwVndrSWJwMjVRbFVadmtqdG9UOXJnd0NaNFVNTEhieVc3b0c4UzZM?=
 =?utf-8?B?T3VWQ3BaSFdmc1F5ZXBodkREaEp5V2NDMElHRUlWU0o2WHFIR3F1L3BTdVpq?=
 =?utf-8?B?cG52RElLeDRXUElrdWI4UGkyaHJGaTQvSHQwaEFwS1JISWJWeUhnenBBNTdW?=
 =?utf-8?B?T0p5ZU9SRk0zTUNaOE9QYXFFNWdrckNqRGRUbzg2Z3c1b1ljeXBPWERGY1Bo?=
 =?utf-8?B?NmcyTEhMSTNCeUU4U0dDWmdyczlCTHZuZFFXNi9WYi9kY1VtbU0zdHhPVE1v?=
 =?utf-8?B?MXZZUjVIdlJJVmxFNXZKb3Z4N3hBTk8xZGNHZWdReUY5ZmY1Qy8zYmpqdHZ4?=
 =?utf-8?B?MXZIdW43YXdXa1hUaW5pMWZRWmlBN2FWN053aC9mOXVtcTZ2Uk0yaS9EcmpE?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5980e0-8e44-44d3-c7a2-08dbdfb0c187
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 16:44:05.9831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4bYCHt/BJMpuJkQJCch5oWhYCf+J0DKGhcwUKdwYGkPmmG2LMTWitT8fPIMdY3Qr96/nqpoK3c6anvecj/SNy/Hv/PJA5j9bnJcynLfQ/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5980
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Potapenko <glider@google.com>
Date: Tue, 7 Nov 2023 17:33:56 +0100

> On Tue, Nov 7, 2023 at 2:23 PM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Date: Mon, 6 Nov 2023 20:23:52 +0200
>>
>>> On Mon, Nov 06, 2023 at 05:31:34PM +0100, Alexander Lobakin wrote:
>>>
>>>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202310170708.fJzLlgDM-lkp@intel.com/
>>>
>>>> Not sure how to approach this :z It was also captured on the version you
>>>> sent 2 weeks ago, so this could've been resolved already.
>>>
>>> Is it in the repository already? if so, we should revert it.
>>> Otherwise you have time to think and fix.
>>
>> Nah, neither Alex' series nor mine. And I'd say this should rather be
>> resolved in the functions Alex introduce.
>>
>> Thanks,
>> Olek
> 
> Sorry, I couldn't reproduce the problem using the instructions at
> https://download.01.org/0day-ci/archive/20231017/202310170708.fJzLlgDM-lkp@intel.com/reproduce
> locally, maybe that's because I only have gcc-11 and higher.
> 
> But if I'm understanding correctly what's going on, then GCC will be
> reporting the same issue in the following code:
> 
> =======================================================
> #include <stddef.h>
> #include <stdbool.h>
> 
> #define BITS_PER_LONG 64
> #define unlikely(x) x
> #define UL(x) (x##UL)
> #define GENMASK(h, l) \
>         (((~UL(0)) - (UL(1) << (l)) + 1) & \
>          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
> 
> #define BIT_WORD(nr)            ((nr) / BITS_PER_LONG)
> #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
> #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
> 
> inline void bitmap_write(unsigned long *map,
>                                 unsigned long value,
>                                 unsigned long start, unsigned long nbits)
> {
>         size_t index;
>         unsigned long offset;
>         unsigned long space;
>         unsigned long mask;
>         bool fit;
> 
>         if (unlikely(!nbits))
>                 return;
> 
>         mask = BITMAP_LAST_WORD_MASK(nbits);
>         value &= mask;
>         offset = start % BITS_PER_LONG;
>         space = BITS_PER_LONG - offset;
>         fit = space >= nbits;
>         index = BIT_WORD(start);
> 
>         map[index] &= (fit ? (~(mask << offset)) :
> ~BITMAP_FIRST_WORD_MASK(start));
>         map[index] |= value << offset;
>         if (fit)
>                 return;
> 
>         map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
>         map[index + 1] |= (value >> space);
> }
> 
> unsigned long foo(unsigned int n) {
>     unsigned long bm[1] = {0};
>     bitmap_write(bm, 1, n, 2);
>     return bm[0];
> }
> =======================================================
> (see also https://godbolt.org/z/GfGfYje53)
> 
> If so, the problem is not specific to GCC 9, trunk GCC also barks on this code:
> 
> =======================================================
> In function 'bitmap_write',
>     inlined from 'bitmap_write' at <source>:15:13,
>     inlined from 'foo' at <source>:47:7:
> <source>:40:12: warning: array subscript 1 is outside array bounds of
> 'long unsigned int[1]' [-Warray-bounds=]
>    40 |         map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
>       |         ~~~^~~~~~~~~~~
> =======================================================
> 
> If this is true for the code in drivers/gpio/gpio-pca953x.c,
> suppressing the report for GCC 9 won't help for other versions.
> Given that this report is isolated in a single file, we probably need

I tested it on GCC 9 using modified make.cross from lkp and it triggers
on one more file:

drivers/thermal/intel/intel_soc_dts_iosf.c: In function 'sys_get_curr_temp':
./include/linux/bitmap.h:601:18: error: array subscript [1,
288230376151711744] is outside array bounds of 'long unsigned int[1]'
[-Werror=array-bounds]

> to give the compiler some hints about the range of values passed to
> bitmap_write() rather than suppressing the optimizations.

OPTIMIZER_HIDE_VAR() doesn't disable optimizations if I get it
correctly, rather shuts up the compiler in cases like this one.

I've been thinking of using __member_size() from fortify-string.h, we
could probably optimize the object code even a bit more while silencing
this warning.
Adding Kees, maybe he'd like to participate in sorting this out as well.

Thanks,
Olek
