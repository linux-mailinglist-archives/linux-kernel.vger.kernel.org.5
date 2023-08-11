Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D8D77848D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 02:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjHKAhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 20:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHKAhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 20:37:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EE92D54
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691714219; x=1723250219;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ElrlUVJI5kIyYqcPIYpF4Jr6Ruoq6GE9bORq6SzWKA4=;
  b=jGvOSvXqemydHqGOcmazf52bomHcLp1cli9pils4GclcCM7/+4dQiGpP
   1jI1QfXb1A1lNerJsLSsJyf6cXm5XffPeA28zDTLyi5I5aL3gFkVQgl2Z
   5ohML7bMyp56Pf2pCZsYiWDWihDarbo47QAk9pNvDQSeXc9Aa3RKZnaAd
   fw+IYph6OpmX3Zkj+N/NRa550fyPQ89fnhh5b+OXio7i+/2FN7VfNyECB
   Rm4NGf0SYQe1Pht6Xdh6YpIgLU5in7WfhQ5ichJjjmGm+i1JLQDMrB13P
   /N9HmK+9l7seRtPWGgodGYrqXq5fbmBkapnPPnjUh5qt1KeL3etmPGLoZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="351165921"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="351165921"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 17:36:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="682337856"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="682337856"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 10 Aug 2023 17:36:58 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 17:36:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 17:36:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 17:36:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyOPRcVEzEM8lZic3qhmyLkbEjeCR2igN38eXoF2RoWPaFfO7Tik10tVyIptl/+FYK/u20OlXBopOpLrgm2Sqmf74kbrjnXev+YMC3FCYp542Kg3j5M9IyTmlbgw14hpLWErVWZc4fa3cMcEdok58pjckbCBcThLa4sRRZENw2NUNMaljKF8IuHlED2IK5qM9XPNSfDEZ14SBpDn3tPyJ2xPyLeEL+hkVx8msar+nNt+Zw9BqkkBpwLTCefNk2TnQrYJjIr4touyYvORsjPHxanokjwHLyIov2I0vJu4DzsaNxsWvwpK5ZrYVgQbKpM3QZLl8yok65/wAzDDIuXt9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KulD7k70igIxu1gL+THVLvhwgTwrAceiRdboWHpn+IY=;
 b=aTPIrjlmb0CyXcdHtUG1px5zYlYdc2l7I+JoJfETFrY/9UzhyyHVmr0YyM6rLwZshkyqh+CcqimpKy3B2iyZVnu002uSjstnOLkM7+6FEVMcwpWsGOIh8tScbyGVfLMMty5DDXggL1eAEKbU9FrdnmYvwkWw4Y3lDJlupC948TKISaUSGKupWJBxYJQ2rSDS7HyOmAyf4LZNMRfXpKDSSjVCzmQTyBdVsarMdZ4FR3ObWttvCfp4yXHPt2ZRpUDdWXnJscGkZuymICkHTceeCuhb5g2W0euIBqUZiQ7COqFAejC3hAHCBztUapELbf9rMDRvBNctO5TCOssMZR77gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by BN9PR11MB5323.namprd11.prod.outlook.com (2603:10b6:408:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 00:36:56 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 00:36:56 +0000
Message-ID: <6cc1654a-460c-474a-864c-04a53ca1ca05@intel.com>
Date:   Fri, 11 Aug 2023 08:36:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zswap: don't warn if none swapcache folio is passed to
 zswap_load
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>
CC:     Yosry Ahmed <yosryahmed@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <hannes@cmpxchg.org>
References: <20230810095652.3905184-1-fengwei.yin@intel.com>
 <CAOUHufYb2LiZYqhyk7GZ2roUbHUEUf3iKkvmSThHBS21EewHiw@mail.gmail.com>
 <26949c92-95a0-414f-918a-8b8cc11e3e9c@intel.com>
 <CAJD7tkZRjSKrGBhBQmFsc+45TNAcii2QRMwwhnsgP3_3o8Jxug@mail.gmail.com>
 <3732dd16-148d-4ac6-8295-86a12f89365b@intel.com>
 <CAOUHufZWReio1bwzLFeJhi1YVko=kjxcfHo1sS8cfnBZuPaHFQ@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufZWReio1bwzLFeJhi1YVko=kjxcfHo1sS8cfnBZuPaHFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|BN9PR11MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f0d97e-3c52-4a62-4895-08db9a031093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GkCv8mcMNp1sYOhsg7LAZUxzOGXHPVYl3v0aYyBpyTHGjhBDzYIujZdNeJM+AvrvUXCQ8CLU8jZJg3kgvRdlS7JcR7EttXOdlt+8Q89tMYRAltdsfK2MbsiR7+j2Gdjzs63kHIpyOaBwPgYoK8ZwByxeq0KohrmB1gBciy7cY2C18TpES1m8IGf5O8MYQUToAR4JFWCylyF+w2SeS8Fa1Wulj9TzbcZ1lQkBJ2KPxAtBB50QAkJS+lRYw4kdqY0bemQa8Qi+bWkdCY0J9kdu7t/eNzyAYmEmbQWzklsbO30xkDxyvCybe7X98zMEA8fnJfwZ2R6fwkWnYVK4uDJoV2ue5XI49/kGD/AW+vQkinLYateJGwmJQmoEK8Fv++Cm1RKqrJDSyk9Z7drDmR5iR/lsT3ldjPeJh/nBPdGbJ5IAre436NcsLz1+P7dAi0+Cf2gWUIjFLhzXzmU0f9pDxRPgZTa1T1ufL3Ibw6JmQBtaPHcoKcoP8leNN6vmd4VHF0/FqjvXSlnR8pUO2gVCEio46PWjI8vtcZWlKnNqvoJSF5O4MNbAjZCdp4LIM8FhDg1SjvPfJhN/ufBUg7frMkVov9TbgBX6jBhG47kaJYyP8OX30w/PlNq285/nte45oWl5XXQF2U5LTmMCqq8gqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(1800799006)(186006)(36756003)(66556008)(6666004)(478600001)(45080400002)(53546011)(66476007)(6506007)(66946007)(6916009)(26005)(6512007)(6486002)(2906002)(4326008)(316002)(8676002)(5660300002)(38100700002)(82960400001)(8936002)(86362001)(83380400001)(2616005)(41300700001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3l0d1ZvR2xRYmswckFCZWY5ZTIwNzJuTTdjcktkQWtxdXI2cXF3WjQ2N0U1?=
 =?utf-8?B?aEp0MnZDaUFwQzhYaE5LOEVLLy8wcElWUHNTd2JOWWJPcFZMZ0VuTGlVWTBp?=
 =?utf-8?B?VVZHOVhyNEJuS0NVY3dncXMyN1NhY3o1RkVGK3J4cVcwNkh5RHplS1h2cVQ5?=
 =?utf-8?B?aEVUQjZDMXdZSVB4QzdjWHlGc0JGR1pLT1p4dGtZc1dYK3Rqdk5xVEplWlZU?=
 =?utf-8?B?bWx1NDFIMUtRQ0FmTU5PWldkcU9BSXRoTmtMbWtDcVJEb2k2ZVZFcHhRMElE?=
 =?utf-8?B?d1RvNTlveU9sOS9XU1hGUFQxUlBodDk5WmNzSDhMMkRrc0ZsKytLUk5wWDht?=
 =?utf-8?B?OER3VXkwaS9lbEt3a0pMVUdKOHhwNGt4a1Z4MjgySnVZVDFHOXZ6ZGVDNDhu?=
 =?utf-8?B?QzFNOCsvMTJyc0FPNlZJME12M05TUFUzYUt2cUprK1dsTTVLMm5jZ2x4OEtY?=
 =?utf-8?B?YUwrR2FvSmNQeHJ2MmtJdTg2YjlTSityUnJCMTFRcnNndkFFekg0VktseGFP?=
 =?utf-8?B?RG1DSHQ4NkN3Kyt6bUhYdzNIY1VYVHlXRzY0ZEVXaEtTK0xFdTVCa09KeGxN?=
 =?utf-8?B?ZlY4R0Y2bm1haVVZb0U1OUk3UFh5WFNlUzFhclZCVlFWNGJLNXB4UGRlVlVQ?=
 =?utf-8?B?WUV3K0FkZS9mNml6UDZPZ1NwNGZjZ2g1Zlo0ZmdjOUlxQXpTVEc2dDJRcnhG?=
 =?utf-8?B?emtxRXhGM3hwSUEvSW1yVFg3d01aNTRVRGJBRytVS3g5T1VwaTJZeXgxM25v?=
 =?utf-8?B?N0R3VlRuN2JEYTZHQ1FKWUlGVlIxUzZ6RkpKa0N2MUN6cS9TcXQ1RG8zRWxa?=
 =?utf-8?B?elpRYlo4Z2ZYR1pZV2RHRDZmTXlMMWJaUWhuNWY4MzhibG55MkFXcEhsczZW?=
 =?utf-8?B?RG43d3Y1dEsrMjJ4MUJSeG5wUWpMSkoyMHkxanpSZGVzdC9qK0RwY1NPWU1U?=
 =?utf-8?B?VnRUak4xQjJUM0d4ZWlibE5zbTBmZG1yQlRzTlFZV0s1c3ExQUVFWG5QY3RQ?=
 =?utf-8?B?RU9JQzh2a3pvVG94S0lUM3hDMXpIVks5MWFJMzhjWk5QdUdUcDVLTmRiYjdk?=
 =?utf-8?B?Z24xZ1AvMVpIVlowdkZnL3pEdmRlV29xa2ZLRzcybFE4ZVR3UldNK29URDN6?=
 =?utf-8?B?b2hxL3BNbnhpM0QvSWQySjBHMVBzRkRmOFJ6VXJaZmM3bGdURENydVdqSnZi?=
 =?utf-8?B?c2Z1SmNsNXY3bHJ6M3pLWW1wRm9KMFRyN1hnMTcwcWJJcUtMUkVRbEdlanhR?=
 =?utf-8?B?aHEvTkdsYWgxbVc4L1hub3QydUxDRU40MHpIakJXR2Q5Yi9nMy8xSXlrMGpI?=
 =?utf-8?B?NHpvMkFOT01iN3RVTm9QZUJYVXZDTUhMYXU5MkdOc290NUU3NzBpNXNlUkFS?=
 =?utf-8?B?OTdCTENQLytPYmlKQ3hIWmkxYzVVSVgvb0dWSUR6NEtoa1p3Z0ozSkcvZk9z?=
 =?utf-8?B?OUE0anQ3Q3FVK1YzRFRSN0xWa0dWZDB6K09FUGNGSVVrZTk1MGdCcldwZERU?=
 =?utf-8?B?WUZxTW5QdUNUNjJzWUI0OWhXTWpEUjhmblNVZmRnNXZvRHhVQnNnbDM2VjhR?=
 =?utf-8?B?VSthb3RZNWlTd1lmcWNqRkJ1SFB4cWo5UmhRU0RmZm4wb1E2VTkxZWd0L3lK?=
 =?utf-8?B?NXVHejAwd21RMHVnSlhFWmYxemlwMDBNQkpOYURMSUpEbFV0Ym1PN08weTlh?=
 =?utf-8?B?UDFNN2xPT0tyQ2J1QW1OczR3NDVVek0yRHRid3UyTkpBQ1RiekpKVWZ2WXhL?=
 =?utf-8?B?bmJlaURaT3lWYnRncmhMRVhaeWRMMEpTT2dSd1UyeGp0K1pTdTdNdnQ0ZzVa?=
 =?utf-8?B?YUw5NE11azJ6VmNIUVFnSEIwd2FEWHVQSS9vcXlSVDRVOTNkQ0ZXbE9CRk00?=
 =?utf-8?B?YjBHOTNGWkVUVVh2dkdCT0dYS1B6ejB4eCtpYWtjalZxQkQ1N3g3QzdBSnhQ?=
 =?utf-8?B?ZldESXdERSsvM0FiSi83bG10L21JWGp4NFpNYWNZeldXZFcvYWQrUDNhM2Nj?=
 =?utf-8?B?NlFmMUJJeWc5Mjc3U21DWTVQNTlhc1V1dVZvQjlPZ1VzbDRlSGM0cjJFRlV4?=
 =?utf-8?B?YTN2WWNxazhNRFpNaXJicW4rWDFqRGVyeXU3d1g1SGNlakUxMGw2bm96VWRR?=
 =?utf-8?B?ZmZBbGg5SDNyMFZ4S3N2a3Buekw0b0crQXEvUTA2cG9kaE8rOWlUQU1pOUt4?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f0d97e-3c52-4a62-4895-08db9a031093
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 00:36:55.9759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGH6sTrz875pb1+DjOy5OOPXTwYab8IXxlYn+xHjpicEWcSF4xuyn9NyCRWj8UL9o9NM7Z2kNeLgRQjW5EEswg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5323
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/2023 7:43 AM, Yu Zhao wrote:
> On Thu, Aug 10, 2023 at 5:31 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>
>>
>>
>> On 8/11/2023 7:15 AM, Yosry Ahmed wrote:
>>> On Thu, Aug 10, 2023 at 4:09 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 8/11/2023 2:44 AM, Yu Zhao wrote:
>>>>> On Thu, Aug 10, 2023 at 3:58 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>>>
>>>>>> With mm-unstable branch, if trigger swap activity and it's possible
>>>>>> see following warning:
>>>>>> [  178.093511][  T651] WARNING: CPU: 2 PID: 651 at mm/zswap.c:1387 zswap_load+0x67/0x570
>>>>>> [  178.095155][  T651] Modules linked in:
>>>>>> [  178.096103][  T651] CPU: 2 PID: 651 Comm: gmain Not tainted 6.5.0-rc4-00492-gad3232df3e41 #148
>>>>>> [  178.098372][  T651] Hardware name: QEMU Standard PC (i440FX + PIIX,1996), BIOS 1.14.0-2 04/01/2014
>>>>>> [  178.101114][  T651] RIP: 0010:zswap_load+0x67/0x570
>>>>>> [  178.102359][  T651] Code: a0 78 4b 85 e8 ea db ff ff 48 8b 00 a8 01 0f 84 84 04 00 00 48 89 df e8 d7 db ff ff 48 8b 00 a9 00 00 08 00 0f 85 c4
>>>>>> [  178.106376][  T651] RSP: 0018:ffffc900011b3760 EFLAGS: 00010246
>>>>>> [  178.107675][  T651] RAX: 0017ffffc0080001 RBX: ffffea0004a991c0 RCX:ffffc900011b37dc
>>>>>> [  178.109242][  T651] RDX: 0000000000000000 RSI: 0000000000000001 RDI:ffffea0004a991c0
>>>>>> [  178.110916][  T651] RBP: ffffea0004a991c0 R08: 0000000000000243 R09:00000000c9a1aafc
>>>>>> [  178.112377][  T651] R10: 00000000c9657db3 R11: 000000003c9657db R12:0000000000014b9c
>>>>>> [  178.113698][  T651] R13: ffff88813501e710 R14: ffff88810d591000 R15:0000000000000000
>>>>>> [  178.115008][  T651] FS:  00007fb21a9ff700(0000) GS:ffff88813bc80000(0000) knlGS:0000000000000000
>>>>>> [  178.116423][  T651] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>> [  178.117421][  T651] CR2: 00005632cbfc81f6 CR3: 0000000131450002 CR4:0000000000370ee0
>>>>>> [  178.118683][  T651] DR0: 0000000000000000 DR1: 0000000000000000 DR2:0000000000000000
>>>>>> [  178.119894][  T651] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:0000000000000400
>>>>>> [  178.121087][  T651] Call Trace:
>>>>>> [  178.121654][  T651]  <TASK>
>>>>>> [  178.122109][  T651]  ? zswap_load+0x67/0x570
>>>>>> [  178.122658][  T651]  ? __warn+0x81/0x170
>>>>>> [  178.123119][  T651]  ? zswap_load+0x67/0x570
>>>>>> [  178.123608][  T651]  ? report_bug+0x167/0x190
>>>>>> [  178.124150][  T651]  ? handle_bug+0x3c/0x70
>>>>>> [  178.124615][  T651]  ? exc_invalid_op+0x13/0x60
>>>>>> [  178.125192][  T651]  ? asm_exc_invalid_op+0x16/0x20
>>>>>> [  178.125753][  T651]  ? zswap_load+0x67/0x570
>>>>>> [  178.126231][  T651]  ? lock_acquire+0xbb/0x290
>>>>>> [  178.126745][  T651]  ? folio_add_lru+0x40/0x1c0
>>>>>> [  178.127261][  T651]  ? find_held_lock+0x2b/0x80
>>>>>> [  178.127776][  T651]  swap_readpage+0xc7/0x5c0
>>>>>> [  178.128273][  T651]  do_swap_page+0x86d/0xf50
>>>>>> [  178.128770][  T651]  ? __pte_offset_map+0x3e/0x290
>>>>>> [  178.129321][  T651]  ? __pte_offset_map+0x1c4/0x290
>>>>>> [  178.129883][  T651]  __handle_mm_fault+0x6ad/0xca0
>>>>>> [  178.130419][  T651]  handle_mm_fault+0x18b/0x410
>>>>>> [  178.130992][  T651]  do_user_addr_fault+0x1f1/0x820
>>>>>> [  178.132076][  T651]  exc_page_fault+0x63/0x1a0
>>>>>> [  178.132599][  T651]  asm_exc_page_fault+0x22/0x30
>>>>>>
>>>>>> It's possible that swap_readpage() is called with none swapcache folio
>>>>>> in do_swap_page() and trigger this warning. So we shouldn't assume
>>>>>> zswap_load() always takes swapcache folio.
>>>>>
>>>>> Did you use a bdev with QUEUE_FLAG_SYNCHRONOUS? Otherwise it sounds
>>>>> like a bug to me.
>>>> I hit this warning with zram which has QUEUE_FLAG_SYNCHRONOUS set. Thanks.
>>>
>>> Does it make sense to keep the warning and instead change it to check
>>> SWP_SYNCHRONOUS_IO as well? Something like:
>>>
>>> VM_WARN_ON_ONCE(!folio_test_swapcache(folio) &&
>>> !swap_type_to_swap_info(type)->flags && SWP_SYNCHRONOUS_IO);
>>>
>>> Of course this is too ugly, so perhaps we want a helper to check if a
>>> swapfile is synchronous.
>> My understanding was that the WARN here is zswap_load() doesn't expect
>> a folio not in swapcache. With zram, swap_readpage() must accept the
>> folio not in swapcache. So this warn should not be there.
>>
>> But your comment make more sense to me. I will update the patch not
>> to remove this WARN. Thanks.
> 
> That can cause another warning.
My understanding is that WARN may be wanted by zswap code.

> 
> Please don't overegineer.
