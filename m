Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF0C758B11
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 03:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjGSB5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 21:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGSB5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 21:57:46 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A2DFC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 18:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689731865; x=1721267865;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9Fmjbx1lYUatnmCrVSy7+ZfXQVMLx3fgpPChu9xysKo=;
  b=HHNedhOL+xZBE1NGp0CC+ll60V7FKycHCoe+qC+AYGB1Xwr0woiB4HmB
   7gAKnu6x6maTyUMQXgqWiIbPWnAcO4UIkktyPpzriFoLtTrBN5We84c9e
   6qXiDwGDD/YKo6m5Jw9WqycUFMk4W3H8zbT8v5AdoJAJfWWHn3Qnk0KcW
   2OHSpvV5N4A/Ycgy2SfFR/9uXDf7TZ+4QvhsOgBXMG8HyO1iOsR9zv5Bj
   HNjA0gGFvg7yvLgSr/NYzwiLevBhySC+WvVmA4KO1oIwJHvBpunv6wxLO
   fCAK7yWbnK7HWNIuY/iQ195+Voi9juLJr8u+ArhsRUdUro1ChXalzgIOq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="369910340"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="369910340"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 18:57:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="793837332"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="793837332"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 18 Jul 2023 18:57:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 18:57:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 18:57:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 18:57:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 18:57:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHlDmnK8NDfR2bhP3hJdrGqo/JLRxEf7nEQ2h/mbnkUV2SjrFslC9SygtD/2BL8WPSAiq6KSrvNRlC2es9ux1/g1NquAya9LoaghjeDKnCy8lzTQCP4aCBF3zdbfjo1rcXkEHrNOvvzl0ecRclECSF8u8q74JdUMvvzuk5cDUxcRuJ/s73oRnblseutbtB+cLB0kTAFiosIgFFTXlYgSVR+1FI7hvHtp+5/Q4uP5xAhD0MwL3cAblryTFOny8IqYpWKtfIKqE3TZLvQ8og7NFs03MJ7IHST0ONiK+0EusTtcOw86DxtoeQs4h9weuuUA4xkV6gX2ho+Z54MYJYXsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TYdqdFLJPXmdsT1UIpXHLZ2MoeFSjTvIWpPMquZ7XU=;
 b=FVYXFn0G7EIZYlmw50DFNWyB3RfmqAiqcdun+iQFGUVx2rqhCkiYyQjNVUAwsBLn/g/liW1M6e/wT1e7fCLZF38lCu1Zu8Av0D0QClK8fg1dJj7uKtCu5wgZGWVSIrbV2ZLRfPNu6lquUgnUSrXESs8cZdJkVOL/QCuc+rmbJ2Igc8GZD6S58ehVWICljkP5MvVigv3CCrwMON1hWdJfBGD3T+c2KF44wXx5z3VxSySZ71KxxBQ8tDp1XgdYrs5UL24lFFkz6An5nbAb4GJVNPT61XWVlXeShbHuBpFYQ+d/iggr7HZFkoPqOvxZVKSVLDNdBXVtefgE9Mnr6ApP4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DM4PR11MB5389.namprd11.prod.outlook.com (2603:10b6:5:394::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 01:57:40 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e%5]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 01:57:40 +0000
Message-ID: <208aff10-8a32-6ab8-f03a-7f3c9d3ca0f7@intel.com>
Date:   Wed, 19 Jul 2023 09:57:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 3/3] mm: mlock: update mlock_pte_range to handle
 large folio
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <david@redhat.com>, <ryan.roberts@arm.com>, <shy828301@gmail.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Hugh Dickins <hughd@google.com>
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <20230712060144.3006358-4-fengwei.yin@intel.com>
 <CAOUHufYef--8MxFettL6fOGjVx2vyZHZQU6EEaTCoW0XBvuC8Q@mail.gmail.com>
 <CAOUHufZ6=9P_=CAOQyw0xw-3q707q-1FVV09dBNDC-hpcpj2Pg@mail.gmail.com>
 <40cbc39e-5179-c2f4-3cea-0a98395aaff1@intel.com>
 <CAOUHufZHyEvU-c2O6B6stM_QVMxc22zV4Szn52myYqjdZvptUA@mail.gmail.com>
 <16844254-7248-f557-b1eb-b8b102c877a2@intel.com>
 <CAJD7tkYAkVOE2caqEj_hTmm47Kex451prBQ1wKTRUiOwnDcwNA@mail.gmail.com>
 <b995e802-1500-6930-79d0-8cc4bfe89589@intel.com>
 <CAJD7tkZtHku-kaK02MAdgaxNzr9hQkPty=cw44R_9HdTS+Pd5w@mail.gmail.com>
 <CAJD7tkZWXdHwpW5AeKqmn6TVCXm1wmKr-2RN2baRJ7c4ciTJng@mail.gmail.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CAJD7tkZWXdHwpW5AeKqmn6TVCXm1wmKr-2RN2baRJ7c4ciTJng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DM4PR11MB5389:EE_
X-MS-Office365-Filtering-Correlation-Id: c39668d7-9faf-473f-2021-08db87fb887b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2zD37VM35+lltaP1VaZ+gRH4NzVEfAMpWR1ysPsel7PLoItGDnx7tbcF94E1d2mfxSc8gU8SqgQ60/uN/E7HPwMwdR6xnyHVWiXY7KqT3btNOGnaARNToC6YKi+vHgKMnxZCIMr/pRo+gSsi3Ma63tGdbpKyzESWY3+nT99JJNdlAbLrzYWxCOB6gzXD7iiU+nKshOkBPkrGlEHvVhem3a4FqaLVU5ZNYHdQ1RtRi2PCVNzFTJbKouo6aMKR3exb7iqogCOUoMnp+tIzeV3TSBWn1XAF4G+UZ27J8LKqrkvr8ntWT7eboaoxPcUoYlIkMk7qHLM5uQoDi2n2nndAlzULrgsAhEovL7ihi//p/My6zfWQ+eQUjmXGWZRuBGXXbXay8415Mqporr9zsDYKySUwMbtlhBiFX4JLXpWqVDg6LF5Ol3ixy9YC/hL0m+irkZYIBGCa1icybTUNoPTqHTHBJ2Nt72Zob5cHUqupnlgBSaPnMl8v9nLxXYfizlEnQ9JQ0vtzpYnUbU+Cqw6KgSK52ZPsCoC2+sgcv09qepo4sP1k1FPVWK1lyIKIxpb+FNKU+04MG9nAhtaVk9HmrkBOQLlngTbE7eMR871vjg7pexheMk/FqqMMom9LUFE26COSMOz1IqJOuaHJeuNeGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199021)(86362001)(2906002)(31696002)(8936002)(83380400001)(8676002)(4326008)(316002)(41300700001)(7416002)(2616005)(5660300002)(38100700002)(54906003)(66946007)(110136005)(66556008)(66476007)(36756003)(31686004)(186003)(26005)(6506007)(53546011)(6512007)(82960400001)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk9OREFmMDdHc2ZyUTQ4Z2NpVjFCNnFxTEk1dmlZQkVWcGoxS0VmN1VreDQ2?=
 =?utf-8?B?SkY3ajlIMzZuM01kbGRqTTlwQ3o3UEtuZTNQV01PNjlPL1hqZVJhTitKNERx?=
 =?utf-8?B?ZEdESWlLbDYyaEJLYTlDWS8vTUozanJSNGFuUGxacVFtbngwL1NQQVQxUUMv?=
 =?utf-8?B?Um1FTVNRVU4zM0dEcUd2UWFONFhPNW1tT0JMbnNHYnpva2JqQnJqZUpoSCtx?=
 =?utf-8?B?dTlVS2d6Y1BBVHhKN3FRWk9qTGVkeFFVWGRJb1pMbE1CMVQ0NzByVE1rU3JI?=
 =?utf-8?B?SWk3c1cybVkyQXhIbmNzNDFYSDlqaTdBZm1pTkdwNUwzNGZja3Q2aG1sUi9x?=
 =?utf-8?B?aHFNNWRWMFVLbGVUd05ZYnpsc2djQUh2aEkrV0RVWnc5ZGpTR3VsQjI2OFpQ?=
 =?utf-8?B?Wi9OZlNCQlNGT3p6RmkwcW96RUJaMko5Rkd0SHN6WXE0TC9tZ3krYkVMWC9k?=
 =?utf-8?B?MktROUthQ0ZkNU1UNk4zQWc5Skk2WEtlVzlwQk4wY2psRGZxUHlxcGNrR1Vz?=
 =?utf-8?B?U1JCQUk2Sjh3SUFpVkh5SEFiRWdLeFcreEZMRU56ajR0RnF0aFlwanNqQ2Np?=
 =?utf-8?B?SWd4b1FIZnJzSWxuM0dlcW9GM3BFbUkyaUQ2Vi9GQTlFditLMmhHSVZoeXE5?=
 =?utf-8?B?S0w2Q29UK1dEMk00bGxic0lCK3ZqQkN4VkhPNzQySFQ4bjNsMTFreHVlNHdO?=
 =?utf-8?B?WDlkZVNCMXh2Z0hDOTlQRXc2ajErWW5PVzZNaUtpQlRTMWFSTzRHTTVTZkVL?=
 =?utf-8?B?UkJkMTNHNFBsVlh3a1d5OThyb0d1WGgvRVdWWElpaHN2bnVPcENwOWY1SEZo?=
 =?utf-8?B?dElSUXV0WXRlSzJLTU9vc2t2MkpwYkJSai9NU09hN3pzV2x0NWFkT2RQME04?=
 =?utf-8?B?SjFFTTNxN09MaXl3QVdPZlFYSU9DTW9vTlFSNHQrOExJS3ZvR1JqM05RTEdG?=
 =?utf-8?B?aCs1OENDQVF2VUlUUTNtajJieXlyV2U4OVd3SUZHazZGOTJ1RmxOZTl1V1V5?=
 =?utf-8?B?ZkhVQSsyNDFCTmJLdUtYKytzd0RWalhJbGJyRVplNlg1VlQ5VDNiOUV1RW9Q?=
 =?utf-8?B?bFFCODRYSHZIQzhWcVA2UVBGNFV5bEZZNVJQSnFpLzJBdEJvUEVoYkJkYXpk?=
 =?utf-8?B?VDRrY0JSdGluM3RmbU4xVmtsNjBGV1N4UGJ5YXMrWUxBcDRvRlpHb3A1Zmg1?=
 =?utf-8?B?R0lPWGNTSmcyc2Rmb1orcGZQOEpsUmM2MFd6cXVwTk9HOTd4M1JaYkxGVjRT?=
 =?utf-8?B?QlhhTmF4cFBUN0VRZzRQSUNSNGlwTi80SmxVazFQMDl6K0NVY1pGLzNibjRV?=
 =?utf-8?B?a0dyeTI1dWgxMTZtUzJ3SUFiYzNmM09LQWNoZkg0VTMrcGhHRHdGWVFNaHo4?=
 =?utf-8?B?eUIyQVIyenlHSFpJVE1iWGliaTYyOVRUQjRTOWN6YzdxdlhKckZ0UVRmVmYr?=
 =?utf-8?B?Qkx1SkpHL2JJaEcyZm12T3BGMGJKazU5cDZCbEt5eXdNemM0Z3lteVVsaW84?=
 =?utf-8?B?QTR4RlB0dVE0cytzWWcxR0UreFJ1OTQ3SG5sNEY0TWU2THpYVGY4MG91TzBj?=
 =?utf-8?B?SzFUbjUvRDUwMjJjazgwRjFiK2orR3FLd1B2ZWQ1YTBZQjEvaytqWHI0OWNi?=
 =?utf-8?B?SzVEekpqYktsN3dkb2p4Z0R1Vmt4YnpvSG5ZQ2kzTjE2ZGppM3RadVpTWmNa?=
 =?utf-8?B?bVo4TjVIcUxzS0EyUXJORS8wRm9vSS9vd2Z5MGgrUDVaNk1hS0dSTEtUM2Q3?=
 =?utf-8?B?aHNTam4yTm5YUmxZMkxSVlJUci9FUVpWNE52WTFHcERsOUhQaFVwTlhocVMy?=
 =?utf-8?B?ay81VStDcVlEUnBiQkRhTDhNUWFNbHphUEJRbmd0ZitVNHowc3ZxVmRURHM4?=
 =?utf-8?B?Yi9HM3MvdVVqV0hsTVFxWFdGU3o0VE9HcDZwZkhvUGRUQjRqSzFhU250bGhY?=
 =?utf-8?B?YlZrN3dCamdPR0tTVE9kM2dJZkNza3lEUitUMnVLY0Fvc0x1VCtaRkxKU1pk?=
 =?utf-8?B?RytDejlSa2tqa3VuL0J4aklRRzJqelJoa1BHdENKWEVOWWtibytKa3I4Qi9r?=
 =?utf-8?B?UFd2SzZRWDZGYzdrTjFuTTBjdzBOcG5lUnFxSDVTd0c5YzFEZWxzUGplUGlJ?=
 =?utf-8?B?Qmwxc1ozMUtvMzArenhGSWdPMWxSeHRVbkdQZmI5MEZ1d0EzYS9JZ0xMMHBS?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c39668d7-9faf-473f-2021-08db87fb887b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 01:57:40.1717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7dTxa536ds4ONDOh8CcaWoiz9hIGDcG+GkHI8nZcO5nW/g8eCkDe1IrC0UWzaONiMfrUIwcjdvuMNLMn7AXSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5389
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/19/23 09:52, Yosry Ahmed wrote:
> On Tue, Jul 18, 2023 at 6:32 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>> On Tue, Jul 18, 2023 at 4:47 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>
>>>
>>> On 7/19/23 06:48, Yosry Ahmed wrote:
>>>> On Sun, Jul 16, 2023 at 6:58 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>>
>>>>>
>>>>> On 7/17/23 08:35, Yu Zhao wrote:
>>>>>> On Sun, Jul 16, 2023 at 6:00 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>>>> On 7/15/2023 2:06 PM, Yu Zhao wrote:
>>>>>>>> There is a problem here that I didn't have the time to elaborate: we
>>>>>>>> can't mlock() a folio that is within the range but not fully mapped
>>>>>>>> because this folio can be on the deferred split queue. When the split
>>>>>>>> happens, those unmapped folios (not mapped by this vma but are mapped
>>>>>>>> into other vmas) will be stranded on the unevictable lru.
>>>>>>> This should be fine unless I missed something. During large folio split,
>>>>>>> the unmap_folio() will be migrate(anon)/unmap(file) folio. Folio will be
>>>>>>> munlocked in unmap_folio(). So the head/tail pages will be evictable always.
>>>>>> It's close but not entirely accurate: munlock can fail on isolated folios.
>>>>> Yes. The munlock just clear PG_mlocked bit but with PG_unevictable left.
>>>>>
>>>>> Could this also happen against normal 4K page? I mean when user try to munlock
>>>>> a normal 4K page and this 4K page is isolated. So it become unevictable page?
>>>> Looks like it can be possible. If cpu 1 is in __munlock_folio() and
>>>> cpu 2 is isolating the folio for any purpose:
>>>>
>>>> cpu1                                        cpu2
>>>>                                                 isolate folio
>>>> folio_test_clear_lru() // 0
>>>>                                                 putback folio // add
>>>> to unevictable list
>>>> folio_test_clear_mlocked()
>>> Yes. Yu showed this sequence to me in another email. I thought the putback_lru()
>>> could correct the none-mlocked but unevictable folio. But it doesn't because
>>> of this race.
>> (+Hugh Dickins for vis)
>>
>> Yu, I am not familiar with the split_folio() case, so I am not sure it
>> is the same exact race I stated above.
>>
>> Can you confirm whether or not doing folio_test_clear_mlocked() before
>> folio_test_clear_lru() would fix the race you are referring to? IIUC,
>> in this case, we make sure we clear PG_mlocked before we try to to
>> clear PG_lru. If we fail to clear it, then someone else have the folio
>> isolated after we clear PG_mlocked, so we can be sure that when they
>> put the folio back it will be correctly made evictable.
>>
>> Is my understanding correct?
> Hmm, actually this might not be enough. In folio_add_lru() we will
> call folio_batch_add_and_move(), which calls lru_add_fn() and *then*
> sets PG_lru. Since we check folio_evictable() in lru_add_fn(), the
> race can still happen:
>
>
> cpu1                              cpu2
>                                       folio_evictable() //false
> folio_test_clear_mlocked()
> folio_test_clear_lru() //false
>                                       folio_set_lru()
>
> Relying on PG_lru for synchronization might not be enough with the
> current code. We might need to revert 2262ace60713 ("mm/munlock:
> delete smp_mb() from __pagevec_lru_add_fn()").
>
> Sorry for going back and forth here, I am thinking out loud.

Yes. Currently, the order in lru_add_fn() is not correct.

I think we should move folio_test_clear_lru(folio) into

lru locked range. As the lru lock here was expected to

use for sync here. Check the comment in lru_add_fn().


Regards

Yin, Fengwei


>
>> If yes, I can add this fix to my next version of the RFC series to
>> rework mlock_count. It would be a lot more complicated with the
>> current implementation (as I stated in a previous email).
>>
>>>>
>>>> The page would be stranded on the unevictable list in this case, no?
>>>> Maybe we should only try to isolate the page (clear PG_lru) after we
>>>> possibly clear PG_mlocked? In this case if we fail to isolate we know
>>>> for sure that whoever has the page isolated will observe that
>>>> PG_mlocked is clear and correctly make the page evictable.
>>>>
>>>> This probably would be complicated with the current implementation, as
>>>> we first need to decrement mlock_count to determine if we want to
>>>> clear PG_mlocked, and to do so we need to isolate the page as
>>>> mlock_count overlays page->lru. With the proposal in [1] to rework
>>>> mlock_count, it might be much simpler as far as I can tell. I intend
>>>> to refresh this proposal soon-ish.
>>>>
>>>> [1]https://lore.kernel.org/lkml/20230618065719.1363271-1-yosryahmed@google.com/
>>>>
>>>>>
>>>>> Regards
>>>>> Yin, Fengwei
>>>>>
