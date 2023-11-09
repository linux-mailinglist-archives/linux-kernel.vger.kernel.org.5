Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F217E6C73
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 15:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjKIOdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 09:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjKIOc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 09:32:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7E12D78
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 06:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699540376; x=1731076376;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D+TCl4UfNdd9ebG6Wcxu1EgwZQbqTyrTc+jcOSKyyAk=;
  b=S1SXbhzD7zmUBGL1SjN/k77RQxY4KaDCSx2h1at0+RVUT6Bbk3TNJy4Y
   C8G/KvkXcNEh2k2ebKpewqAAtkOSCGQ5BRXYMLzRYmB28YbEi85JHnch6
   09P61AjXdEj+J0m/kvlY8FR3ULqWJNOG15G09INIwlqFUNjWDhinlfuXP
   MJGg+8SpYDfFIaGVWgNWMbEDI/R9ZQwqoChhICxat9DgikraHqJpCp0BA
   x/bUhG31aJ5HR/Ev8tb4Cn6oC7q00Sec/HxL2sA0gZeclaiw1EsdpW5Ec
   +ijVF/sSCzEQgm6y3+YKGACuNVTOSoQVOTL/c+JMzDODFbOkZi5uBX1/0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="454295322"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="454295322"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 06:32:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="880621760"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="880621760"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 06:32:55 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 06:32:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 06:32:54 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 06:32:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sm8hb6b8xRDLQAMsWnzcfYaZKLpM64gihYE0DUv99FRTNNw9LEq5wf/j/VMokBs1Uarl3/BH+XEv0KAXobf61h+f71GNflh6UwlUP1aNYeSFGkKVsZ7wmKHNwS8WpgE6M/C1hBuBh9TFj9bAj5q2q67tNB0WTQEGmCqoMzJws/Cn+gdDzKfOMaOu2KGAqKJyx8pPhML1Yj4BFFBwbMlJZQQlLe0SrRq0nDGd5asay2Z0ev3hcvbUlBoF6qO3DjP9LVruFY1cO0vFvWELJAUHyFJBL/oy6TJSUZ0bDlHPNygACImenH79Nbg/8GhmekGK3vpr9SgS9lPLg1/gYA2XIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BR6TEGxRU51Wy2cD5PYP2qY4KbsZEVBtrmefcVgqkIc=;
 b=DwESU42RonFEJdkkaddz5LbLIdlXtrKeNxJxHg1W2MiBYwzeRVwTm8fT+Rfa4JQr2ZTk2gtW12urCdDj2ze85ibiwF8+0N5WAG1xkJQh/zXmBw4qdqRDC7bGAgPDsl0LWLWRZrygX1Od9WbpMiNUe8/mHny73/3o17UQXHYUpdVhHyZ2UJ9v7IpjBS6JQ7nH/y+RlivSyr9S0936aPmqWzxGoNS/4644esX/627FYxhyClkxEjhNBIjTu+vO1u1G5u5j6q0dhOXxPGRiozEnEa4KHpWkagpTHW02HY2/dwqNjTOyvdzoYNGaNPqja0JT9/BYXwv4AMcRwQHZjtEkOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH0PR11MB5141.namprd11.prod.outlook.com (2603:10b6:510:3c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 14:32:52 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 14:32:52 +0000
Message-ID: <27f5d15b-28da-469b-9625-1c840f33b60d@intel.com>
Date:   Thu, 9 Nov 2023 15:32:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/2] lib/test_bitmap: add tests for
 bitmap_{read,write}()
Content-Language: en-US
To:     Alexander Potapenko <glider@google.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>, <pcc@google.com>,
        <andreyknvl@gmail.com>, <andriy.shevchenko@linux.intel.com>,
        <linux@rasmusvillemoes.dk>, <yury.norov@gmail.com>,
        <alexandru.elisei@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <eugenis@google.com>,
        <syednwaris@gmail.com>, <william.gray@linaro.org>
References: <20231030153210.139512-1-glider@google.com>
 <20231030153210.139512-2-glider@google.com>
 <093114e8-b02f-4df0-a0d4-8e9f86e2259d@intel.com>
 <CAG_fn=W3LqtdDoUDDVGn_=2+gvKNeCusH6yUzWmVmMmOLZp9jA@mail.gmail.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CAG_fn=W3LqtdDoUDDVGn_=2+gvKNeCusH6yUzWmVmMmOLZp9jA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB9PR05CA0013.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::18) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH0PR11MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 4506558c-cb1f-494f-3d24-08dbe130c16a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aKKuP0Z0+WaRWLBv0I0xpj0FLKPy5G4Dm6QiD7G/uPWujLnlXVGNXxHJ1fKUsj4GPjj63uS7IZk7FtzDUiJRH/EriI+mgPzU5ozKP6c5pN77zRiQxYbXKi9x60zsohNwG++vr5EObfNDqtrm7lIrN06mfveSr9srr/XgBnRJ1QnMtwkBGFWh8T4xShR7SiXKrrqvgDBwv8lFAp093EwiGOgkf86LeUfEKrOpa69qnhrpkU8iTINYyzTufO7UfsJ7AY5yc1mVqgf/AmG9L2ASRXDEqKNH1BV6dF/JUfCkbSDQq2LT/Oin65nTpvl/NqxuoKQqgyFEYnx4CAIE1v1F5DmMBxunOPWCDaE/wddWQ6WRxfFUFJeDFtJzPY67yXND8he5GBvaDKXuHHzqhevaXCJsAeVGaQYxYQvw27I63YKQQde/zo0hRyPzy3YH7iTix2/IcxfCyusDNW9rLeh8U52ROIjevNkxtiu6GTFSAmD5+aSSUWmE2C8cHMn2ASruJH6pbBNOMgJXYd0WxmmRBul0F3qLug/IXj18IInMXtqzR+gJ8Y6POievyPi2E/H/Mq3zu0zcEfI8KV+s9EcRHPOap9EcDPqrrehMQQFbLmpF2j6HIPxB0UTJB/2XM8YRbSXLcHUhvxiEiyFJWkOprMRdgNoCgDcakovN0weeACc3avdSqu5EeRJjbSYSrgyJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(230173577357003)(230273577357003)(1800799009)(186009)(64100799003)(451199024)(6916009)(8676002)(4326008)(41300700001)(316002)(36756003)(8936002)(2906002)(5660300002)(38100700002)(31696002)(6486002)(66556008)(6512007)(66476007)(31686004)(86362001)(7416002)(66946007)(83380400001)(26005)(66574015)(82960400001)(2616005)(6506007)(6666004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTV3STk3ZCtkUVNqUnVyZDdsVUNkaUR4ZmZ6YU56Ui9OVkd6KzlNZFh1OHlZ?=
 =?utf-8?B?OCt1a3VGakdhTzhHaDIwSi9EenFxSGhpNGdGT3d1SWk2d1VVYmd2bTFBanR2?=
 =?utf-8?B?RjQyMHYxUkVlWlRWN2lBWnNjbHRVZStaRFJpUFN2cXNJejRLaWRRUHk0YUhL?=
 =?utf-8?B?Y3JRbzJqQllocTNHcVVkeWluc0VIVDBvWDYvN0YwUHNOQ1JOSDlZbTNFMy82?=
 =?utf-8?B?bW1nUXQ3aUs0dFE0ZXFCNFpnb1BKK1Z6VVJqaitjRVNYbGZTQ2ExemIyd1hC?=
 =?utf-8?B?ZTZsbUtFSW9VOTAvZXBjaFJFZmRvTDNwTDNBbjdJSW56Mm51enhVN2dsaDVK?=
 =?utf-8?B?d3grOTZwTU5LSjI4cktwdExNdXRoS1BubUREZEE4bWM1ZENlVzJubTJ1akQv?=
 =?utf-8?B?ZVJrM2lkajhtdVFrOTBPQTdneGJMOGoxdXRCUWgyLzNWbDdPY0FoNWxDMVJx?=
 =?utf-8?B?RnZyTFV1NWJOQ0l3ZFBRMUJ6UVdBNHBNZzEvd0s3aE4xcEtDazlBRW8zWGx4?=
 =?utf-8?B?SDZ3V1RDaDMzcGVzaXFvdDFzNURZUTcwY2N6VEVSMlRtaWdTYWdLWW9VTDUr?=
 =?utf-8?B?RVUreGdmNW56T3NqOXVzaXk4OTRMSm1YckM0SEVwY0J3WVpjYzZSTzljUVhB?=
 =?utf-8?B?c1Y4dFFhdUJKUHFqcHBCbzFOa1pEWjZQTmFLL1JHZlVjZGNQU3lpbE13ekhE?=
 =?utf-8?B?VFd2Uk9RcDNIeVB2TVgrZi9yMlh0dGljWmhUeUVjemRVbU9aNC9Fd3c3TGEy?=
 =?utf-8?B?SWpzRUluNTZEbFhYWkdFN3dIT2FHNmlZMmRKbWpvdTZIbTdyZVVJOGd6QVR2?=
 =?utf-8?B?L2hna1dGbGlqNjlyTU9GWVc5c09nd0tyNjVyS1YydVczS2RLTHBKTXU5cWF6?=
 =?utf-8?B?YzJ6TGFOM0E4VEErNGdod0ZSNVNDRkxmcUpGTXQySFVPSHQyQnk1eHd2VlFZ?=
 =?utf-8?B?a2U3WmZ5K2U1U0E2MFZjWEFWandVK2g0K1ZlK1k2blFnT2tXTlN3WTU5eHN0?=
 =?utf-8?B?Nk94U1FpeFdBdDhzUjNNMEhhWVI3QjhUdUtVbkM4c2tHZW9uYWl5VWxmMUpU?=
 =?utf-8?B?U2s1Mjg5Uk55OFFJNGNOcjEva20vQXNNbmJ3NS9JU3RJWXBYV3RPNUs2TFli?=
 =?utf-8?B?blRSWmFxbXdIWEVoMUlhU2xjVXgxZmNXTERRa2FIc0xlL0J6eEllWlE3T0xk?=
 =?utf-8?B?Vk5qVk9GRWpMQzBMZWx0NVo2c1Eyd2ppazg0dkYxcVVRQ1hIZXlsV2hBS0VR?=
 =?utf-8?B?bW5wR1B1L25RWVpZZ3RVd1F6c3JTdjZxcmc5UXh4M3hoUDFRRHJiRmhiTmZE?=
 =?utf-8?B?ZGVidng3N3FmMkdOaFpUQWJaOUFnN1kxQzAxZmlzZGhEOGx4aW9oN2xiZHox?=
 =?utf-8?B?N3RkRWlOc2JXYnRsM004Tm9hYW1Eam5HaVdtai8vNmtIT3ROTmExQlB5TzQ5?=
 =?utf-8?B?dXdjeVBZQk1iNmNXTEk0bFVYTnZxTWZFK0JrdnBTTTFSOGJ3MVJ5U0NkejVy?=
 =?utf-8?B?c1lUa20rOTNmeVZCcDMwcDRBT3hjWFFGa3hWTDROOTdXSGEzeW5wWm5pd2xs?=
 =?utf-8?B?S0RkN2FTZ2l5bTZKM09aUkVndTRrWFpxZTlHVi9TRHJpL1NkR0xxbGFibXh0?=
 =?utf-8?B?QTdxR2gwVTBCRkVCSHZLaTB6ZEtUZlpqMUJCNi9Od1c3dy9XYUZoNy83QWVu?=
 =?utf-8?B?a0krbmUwYVJROWFhMnRLQkNOSU9xZm5wSkFuZU0xZ1YrTGZDYkFhVGQ2K3JT?=
 =?utf-8?B?U092WHoza0k2UGtKOElLWGZYU1JqM1BHK2VUY3Q0M1hoSlhna2Z5TzRxNTEz?=
 =?utf-8?B?ZGhsMFhNYzE3NnpEZ1ZqZFB5M09XOUVaTTE0ckpYSDgxZmxoUXNRUXZSMVY0?=
 =?utf-8?B?T05tRW5pMDBKNlM1QkJnSWliYlFLQmNaOWNGNkxWd2JwNmRNVDFWeXpkWmt1?=
 =?utf-8?B?ZXBRT241TGpiOVFDU0kwTE9VeGFTeEpHYzJ5U0VpSE9jQjArTFdZQ1VWQUpX?=
 =?utf-8?B?SXdOSGdIeUl4aGhWZ3YvRThRbFJRd2NWcWVYRWxPREZEalVzZldBdCsrckFW?=
 =?utf-8?B?NkUybDdaeXYwejducXFjM1R2UjJwd0dOWGtuQzBwaUpTL1hZZnl0WU41QVgz?=
 =?utf-8?B?aXhhT2VGMXZZZ0h1TDZtZzQ5dGJVZk9Hb1Jpa2dZMEtQTXJvdUx0OFJKMFh1?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4506558c-cb1f-494f-3d24-08dbe130c16a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 14:32:52.4648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aizbbbTxJcO14+hhMAU7A6DILO0s2KEa/EwRy53cbJa7U0G8dcUZHifAFnQt7zXoAN1BkFJ5OLt/EVHhhaUi9zrYtUpE7lH8xcZxql1GvG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5141
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Potapenko <glider@google.com>
Date: Thu, 9 Nov 2023 15:28:56 +0100

>>
>> Could we maybe rather extend __check_eq_uint to take ulongs? Doesn't
>> seem like they differ a lot.
> 
> We could redefine expect_eq_uint as:
> 
> #define expect_eq_uint(x, y)           expect_eq_ulong((unsigned
> int)(x), (unsigned int)(y))

Do we need explicit casts here tho?

> 
> and throw __expect_eq_uint away.
> 
> 
>>> +     }
>>> +     time = ktime_get() - time;
>>> +     pr_err("Time spent in %s:\t%llu\n", __func__, time);
>>
>> pr_err() is for printing errors and is shown in red by some log readers.
>> Maybe use pr_info() or pr_notice()? Definitely not an error or even warning.
> 
> Note that test_bitmap.c has 17 calls of pr_err() and 7 calls of
> pr_warn(), which aren't really consistent (e.g. they are used in
> certain __check helpers instead of pr_err()), and the existing
> performance tests are calling pr_err().

Correct, and that's what caught my attention: visual grepping for bitmap
messages makes no sense because some of them are red even thought all
tests pass correctly.

> I can change that in a separate patch, if you think it's worth the
> effort: the error messages should probably remain pr_err(), but the
> informational ones could be made pr_info().

Sounds good to be, would be nice to see!

[...]

>>> @@ -1237,6 +1411,9 @@ static void __init selftest(void)
>>>       test_bitmap_cut();
>>>       test_bitmap_print_buf();
>>>       test_bitmap_const_eval();
>>> +     test_bitmap_read_write();
>>> +     test_bitmap_read_perf();
>>> +     test_bitmap_write_perf();
>>>
>>>       test_find_nth_bit();
>>>       test_for_each_set_bit();
>>
>> Thanks,
>> Olek
> 
> 
> 
> --
> Alexander Potapenko
> Software Engineer
> 
> Google Germany GmbH
> Erika-Mann-Straße, 33
> 80636 München
> 
> Geschäftsführer: Paul Manicle, Liana Sebastian
> Registergericht und -nummer: Hamburg, HRB 86891
> Sitz der Gesellschaft: Hamburg

Thanks,
Olek
