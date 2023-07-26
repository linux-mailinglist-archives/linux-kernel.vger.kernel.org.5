Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3CE762B52
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjGZGVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjGZGVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:21:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD2910B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690352493; x=1721888493;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RcqnNsARtttN5SYrzpcbKxqzWy6hN3ABaKYW/GGT2c0=;
  b=Wqcqtn3VvhgHdl/mWgFB51vByF0cU8gNCFnmNw/zCpVSiXWbTp8ECnar
   lQP5xMGuYo2GHs7rRDnvMVoD51S1PR0l/8rd6ruK9PYttue+RHWdnoEpx
   EAfGk1UpvMPf1SDMAzZKOuio2PzDsueV1VDHfKtptBa8MFPNakxgLkmej
   vO+4sDwg7P5kUWeQn8wd5LqWMLCCgOCQtF9owK9lQIuEIJBp61WBMtVl7
   omyRPoJVIUvndA/CmaTdm6ZzAtiHi7c1ivDg+X8jdiZsVDatmgXBZwUVH
   akwGm9hGvjZ5Vzkz5k8HPxdWIDiHW0vFEyXuoKH53mYEBPE6k3T+bmYgb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="367951227"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="367951227"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 23:21:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="703608503"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="703608503"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 25 Jul 2023 23:21:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 23:21:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 23:21:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 25 Jul 2023 23:21:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 25 Jul 2023 23:21:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMksSHfSmgHQtXZsnb3jKaFpSghGRkozO9CYVmHtbAa8baPreogu4CziQB8qViVZjQra1A4waHjzovt5TCSWjAe7XbnijsFikqvd5LBC6ZUy7W8cfYdl73hJz9mqYih1PIFRg8kfPuzKxnSDYhc7ys5zowbmjINCA9hPlpB+9LsbkrWFQhC/jg9V6rY9IF50Zdvg/oUfAvhnX5tXc7dR/CAtzKcvS+x17RhjEqq933l7UyMNnqe6AzfNG/C0LJinD1WixHp1DWIA5cHN2lsYHn9GlybgAvTF7Q3X6haJ4Go018q6a7Dq8gpDaqv+kcBmUiIWw3WXn6kiq/AdqMFzdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Vcd+S7BTdEHuO5SY3g1RC0k/l84QnptifMWY8qmODM=;
 b=gtiKgjp0r1lf73st4DmaE5U3u7QpXvTdhGi/1jcCdDh1+KdQ9zp5oJ8E/To9bWNYCBMLE1vSiyHP2iriCijFeeVwxYY9nD0pfXDE7RpbIDKd4hsO8/mfLPi39+PcsmX1AvTrg34JuIS4h9i9klv3rqZcrYfM7c1CDDrfQT/sfeQWxMJ+W1L3eTfiZ2PXmNaOhsWwJzkeTtWsuXpOQVTTte3TujRUWOdJQkt0H51aHX9NV5VPCvlxkpaimi4h0RZyIjTVfsFoagFruxWScOpOl1QmhkMPcZvHLlkDazS0/ysrLrjjhAl2IgwRxiK21K35WpwMQz0XMrY+F9q+KVEF0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SN7PR11MB7510.namprd11.prod.outlook.com (2603:10b6:806:349::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 06:21:30 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e%5]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 06:21:29 +0000
Message-ID: <0843fb4d-ab0b-2766-281c-ef32b6031dd7@intel.com>
Date:   Wed, 26 Jul 2023 14:21:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 2/4] madvise: Use notify-able API to clear and
 flush page table entries
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <minchan@kernel.org>,
        <willy@infradead.org>, <david@redhat.com>, <ryan.roberts@arm.com>,
        <shy828301@gmail.com>
References: <20230721094043.2506691-1-fengwei.yin@intel.com>
 <20230721094043.2506691-3-fengwei.yin@intel.com>
 <CAOUHufY2tdO0JNTiY=RzHitR7CB1cM5kA=7bd6nbCUW6KM_OVA@mail.gmail.com>
 <05bc90b6-4954-b945-f0d8-373f565c1248@intel.com>
 <CAOUHufYJE40wcT4HTYFJ_7X5=my3OPbMyMBt+QNZdByuL6j58Q@mail.gmail.com>
 <feb58221-e481-3d71-8707-6ffe90158b66@intel.com>
 <CAOUHufa9rFS-VjbCRG6KGjb4YKOZioH=dLdTyFLWqEFePoL+wQ@mail.gmail.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufa9rFS-VjbCRG6KGjb4YKOZioH=dLdTyFLWqEFePoL+wQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SN7PR11MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: c893ad37-5f16-4234-0e5e-08db8da08cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 70AlZZVATsWD7g0XtsDwzh4ir78+3aXb68iI88w6e2ojOfZxCy3I+2OVembJs9xd1oh95Qop+/osXMVpfcsb6J2Qs5BH1syFjkqRpJNIRkDxhgGzFvRjkncLu9cNXNxdT6CTlOovslhFDuWzDepfwUuO6biiQrClC351C3vcwQQ7Z+4EpRKtl9sSZ1lzqn3cDjrajjbwBoWtd/P/GHcAPPiWBUeUzFDsEjgiOOhmhd1s79St0SQhbawKQm0Nn6SfXZTJMziwB24s8945tC5csy+O+MuYDLyJuSM9xJad8Sz33Jme7Z/vYl2/qGS+C83DCckzhE2C3GQJuCNhYiOm64HdQh/SWn+XMe2Ktso3/TUVXvdUT/jA9iDTW9YEwf0erzs5NqZO8KB4cMX/fdXbGs+V6mbgffuFWdJftiX2wCH9TkPMrz1zeDwCZW8HyZ2b5Sb6hI0ZXLu3t0ZWSfdAuChLaUXBvbU0O1UUR3jGSlddn0zCBBAQxHGSaoZpgtPJF0lY8NDYOTvdYHNj/fMpfiV0Se83LUIIg0bt4/MzH/MXggiAJ8OA4g7Xb8co5+LNRQuj9or2K6bVXWzR9ah4vNpKZKP1c6wjahuBjrot6FEKQ48+2slrB2aLRXxfpFNeufUC+oOGdR1UBLugD43nmVSzL1ezvc5D8Z8h20pkyas=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199021)(8676002)(31686004)(5660300002)(83380400001)(2616005)(186003)(26005)(53546011)(6506007)(86362001)(8936002)(31696002)(6666004)(6916009)(4326008)(316002)(6486002)(66946007)(41300700001)(66556008)(66476007)(6512007)(966005)(478600001)(82960400001)(2906002)(38100700002)(36756003)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bldsWVdOSVVUQmY4RUxnM2xzcUFGeEszd3ZEVUJDZTMvalVQeXdRVCttZERa?=
 =?utf-8?B?Q1NlVjN4QmhUQ2FMV3owemxBb2tBSTB2QVh2KzVJK3F6UjJlSmJEenZBQmFZ?=
 =?utf-8?B?QUFSM0N5eWhBZis3Z3R4OGRoVmVJUHhRMCtaUkJsT0JMdEpYeFNvL3NOKzFW?=
 =?utf-8?B?UjRlOE9aQ3hZQ01HT1psYXJmSmNXV1hiZmtQcUFiZWhqc1o0cnRxWGNzeGdV?=
 =?utf-8?B?TzFKSGwxSkhZa1FXYll2YUFlSDdGdktncVB6OUtTYTdrRHB5aC90V3kwSjVy?=
 =?utf-8?B?RHIyYnVjY0RLY2ViNjdSK1FvOXJTV1YybEJ1bTNQQnUxVkJSN2Z2ei81Rmgx?=
 =?utf-8?B?ell2V0VuaGQra3JFRHZuckRVYWZDN2FOZWI5bUl4NXRCOTFWdEhRWFhRdlFO?=
 =?utf-8?B?N1lWWlJGOFYyQ3pZNlVOem9qajluSWF1SXV0NzJtRU5Jdm9TTWlwWE9wL2dn?=
 =?utf-8?B?VUlvZjk1WmdJNnY4YmRqcDM3bjd3WWZ1T0JaWTYveFFIQmZxeWFkSzJDTWxm?=
 =?utf-8?B?UnBYNndKcVpxYjVFdDlCWXFEMHcvcG4xNTJjcC8ydkJDVjJIVVA2di9RL1RB?=
 =?utf-8?B?RndMOUw2eVFWaUUyclg4NjBuNVQ3Q01IanFaVzM3MXRHWFhZemsvZW1ERmxy?=
 =?utf-8?B?MUxEQ2tqWnBFZHEzcHIvN1Q3cjNmSEhIVmlRRHY1OWM2eGJJWkRjeGVyT2l6?=
 =?utf-8?B?b3UyVUgvL0liOG1MWEdwWC9CeFg1c2p2MlBsejZmL0lFWGFBeGxzUFRBQVB0?=
 =?utf-8?B?bmx5SkpBaUIrNzFiVEZRWWNDVzdFakhTOXNTYmVtcHRUUUkyZmhoOW0rSkRz?=
 =?utf-8?B?S3phZ3pSQVE5NE42ZnBmb3luTjVsUHMwSktyZkN4TmRkc3RzTFBwUzNpdTBt?=
 =?utf-8?B?WDFadytEYmNoeCtRU3Y4aWlGcERnVzllZHVmNEJ3NlJTTUxiWGhIWnZ5VGI4?=
 =?utf-8?B?SVNjZ3ordndRY0psZ3dUNXFFMDRIOC93RlREMGFwYWFsbDVTMUZQSXJhTVpu?=
 =?utf-8?B?Lzl1dXo5WDJpcWNjY3pKejNLVzQzbzBEQXdwMUxUWVUxVmNBeGVIZWFQTmRj?=
 =?utf-8?B?TnYySkpiaWs5Sk5EUEJGYXF3MHIzU3U0VUkvV3A4eVNCdm83STlLNC9Ya2hj?=
 =?utf-8?B?RHFYVXRxQk41SVZNc3ZzWTRTRGdmVzZTb1dISWdUYkpjUVBYdzJiMlJBaHdO?=
 =?utf-8?B?MFp5N0lrNkEvSnFsQkw4Z2d5Y1h1TFlBOVp4Y3N0WHhSWkZWKzBhdHg3cW1V?=
 =?utf-8?B?Rk11SVFORkljbG5KQ2hjMnFZWGZBT3N0ZzRUallaLy9UaU8yTDNwYndqanlI?=
 =?utf-8?B?UzFaRkZhM0oxTmNiT2ZZMGlXeDNrZW9IOVlhOHQweCtyU2VCRDJTN1J5RlBw?=
 =?utf-8?B?T3pJaWR6MlZ5L1JuWXdOTWp5SU5tNllFSms4RmNLalpvTzBiZjFOU2R6dXBD?=
 =?utf-8?B?eVYvd2ZBUTBTMXlKL0wxbHJ4TW9TR1psVHlzNUFaekZEblgrd3dINDNqVWJP?=
 =?utf-8?B?Ym1pZGthZzV2Nks2STFUdFYwam14RUw1a1hXTnIrZjNpVEVCQStKNkNXYWx6?=
 =?utf-8?B?U203ajZxcUNTM3N6ckhNcWMraTdiWDluZndqYmZpcS9yWVgzeXhROVpOMUhm?=
 =?utf-8?B?RjVnL2p3ZHlvbmdteHVUQ3BsQ2VWdHRubDNsbG1qa0Z3NXFsdE1ZaTlSMjV2?=
 =?utf-8?B?OFNCUUxKaktGYXR6K2RqU2srMDdBWUtDL3hUaDgzVGFjSERJMjlCaW9vaVYv?=
 =?utf-8?B?VkxUWjN1YTIrNHBxSDdldTlMQWtCUGZuMjlGNEJ0TnJZaGVMb0c3cG10UnVp?=
 =?utf-8?B?eGpNcUU3MTVYWDc5ZGhubFVkajZwYW1TbkMvc1RWdUpVOHZFQ014anNIVDNh?=
 =?utf-8?B?ZWpmVFhpSjVaNUd6Q08zOXppdjdINlVBY3Rsb2g3aTNBNnNyamdlYkN2cEx5?=
 =?utf-8?B?aDhJM0RtaXdTZHU2VWtiRlYrVytrWkdyZmdZaUFXeHdyYnN0akhIYjI4Y3hI?=
 =?utf-8?B?c09WV2xtZ2s2V0kvNUhSSEZJdHRFVFlmTGp1UzBwdkY3RjZub1Q3elpYVkpk?=
 =?utf-8?B?NVVmcXYybXJLRHdha0I3Sk9SdkxqV3grcFNyM2ZMZmlUUnVpaTBjeEVPNmUx?=
 =?utf-8?B?U1NMcWFRQ3FRbG9BaTFpcUV6QzY0NGVFUm9teGxmeWJtM0QxRW1YcjkvZFlm?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c893ad37-5f16-4234-0e5e-08db8da08cb3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 06:21:29.9402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUpHka+uWu1cPUeSXw/ms7zz9qRNGB/muo7qcuGJ/zKVXSCH5VflzpcVKq40sdNhdKTrBuAF+4ScTF6rER0snw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7510
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/23 13:40, Yu Zhao wrote:
> On Tue, Jul 25, 2023 at 10:44 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>>
>>
>> On 7/26/23 11:26, Yu Zhao wrote:
>>> On Tue, Jul 25, 2023 at 8:49 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>
>>>>
>>>> On 7/25/23 13:55, Yu Zhao wrote:
>>>>> On Fri, Jul 21, 2023 at 3:41 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>>>
>>>>>> Currently, in function madvise_cold_or_pageout_pte_range(), the
>>>>>> young bit of pte/pmd is cleared notify subscripter.
>>>>>>
>>>>>> Using notify-able API to make sure the subscripter is signaled about
>>>>>> the young bit clearing.
>>>>>>
>>>>>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>>>>>> ---
>>>>>>  mm/madvise.c | 18 ++----------------
>>>>>>  1 file changed, 2 insertions(+), 16 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/madvise.c b/mm/madvise.c
>>>>>> index f12933ebcc24..b236e201a738 100644
>>>>>> --- a/mm/madvise.c
>>>>>> +++ b/mm/madvise.c
>>>>>> @@ -403,14 +403,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>>>>>>                         return 0;
>>>>>>                 }
>>>>>>
>>>>>> -               if (pmd_young(orig_pmd)) {
>>>>>> -                       pmdp_invalidate(vma, addr, pmd);
>>>>>> -                       orig_pmd = pmd_mkold(orig_pmd);
>>>>>> -
>>>>>> -                       set_pmd_at(mm, addr, pmd, orig_pmd);
>>>>>> -                       tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
>>>>>> -               }
>>>>>> -
>>>>>> +               pmdp_clear_flush_young_notify(vma, addr, pmd);
>>>>>>                 folio_clear_referenced(folio);
>>>>>>                 folio_test_clear_young(folio);
>>>>>>                 if (folio_test_active(folio))
>>>>>> @@ -496,14 +489,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>>>>>>
>>>>>>                 VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
>>>>>>
>>>>>> -               if (pte_young(ptent)) {
>>>>>> -                       ptent = ptep_get_and_clear_full(mm, addr, pte,
>>>>>> -                                                       tlb->fullmm);
>>>>>> -                       ptent = pte_mkold(ptent);
>>>>>> -                       set_pte_at(mm, addr, pte, ptent);
>>>>>> -                       tlb_remove_tlb_entry(tlb, pte, addr);
>>>>>> -               }
>>>>>> -
>>>>>> +               ptep_clear_flush_young_notify(vma, addr, pte);
>>>>>
>>>>> These two places are tricky.
>>>>>
>>>>> I agree there is a problem here, i.e., we are not consulting the mmu
>>>>> notifier. In fact, we do pageout on VMs on ChromeOS, and it's been a
>>>>> known problem to me for a while (not a high priority one).
>>>>>
>>>>> tlb_remove_tlb_entry() is batched flush, ptep_clear_flush_young() is
>>>>> not. But, on x86, we might see a performance improvement since
>>>>> ptep_clear_flush_young() doesn't flush TLB at all. On ARM, there might
>>>>> be regressions though.
>>>>>
>>>>> I'd go with ptep_clear_young_notify(), but IIRC, Minchan mentioned he
>>>>> prefers flush. So I'll let him chime in.
>>>> I am OK with either way even no flush way here is more efficient for
>>>> arm64. Let's wait for Minchan's comment.
>>>
>>> Yes, and I don't think there would be any "negative" consequences
>>> without tlb flushes when clearing the A-bit.
>>>
>>>>> If we do end up with ptep_clear_young_notify(), please remove
>>>>> mmu_gather -- it should have been done in this patch.
>>>>
>>>> I suppose "remove mmu_gather" means to trigger flush tlb operation in
>>>> batched way to make sure no stale data in TLB for long time on arm64
>>>> platform.
>>>
>>> In madvise_cold_or_pageout_pte_range(), we only need struct
>>> mmu_gather *tlb because of tlb_remove_pmd_tlb_entry(), i.e., flushing
>>> tlb after clearing the A-bit. There is no correction, e.g., potential
>>> data corruption, involved there.
>>
>> From https://lore.kernel.org/lkml/20181029105515.GD14127@arm.com/,
>> the reason that arm64 didn't drop whole flush tlb in ptep_clear_flush_young()
>> is to prevent the stale data in TLB. I suppose there is no correction issue
>> there also.
>>
>> So why keep stale data in TLB in madvise_cold_or_pageout_pte_range() is fine?
> 
> Sorry, I'm not sure I understand your question here.
Oh. Sorry for the confusion. I will explain my understanding and
question in detail.

> 
> In this patch, you removed tlb_remove_tlb_entry(), so we don't need
> struct mmu_gather *tlb any more.
Yes. You are right.

> 
> If you are asking why I prefer ptep_clear_young_notify() (no flush),
> which also doesn't need tlb_remove_tlb_entry(), then the answer is
> that the TLB size doesn't scale like DRAM does: the gap has been
> growing exponentially. So there is no way TLB can hold stale entries
> long enough to cause a measurable effect on the A-bit. This isn't a
> conjecture -- it's been proven conversely: we encountered bugs (almost
> every year) caused by missing TLB flushes and resulting in data
> corruption. They were never easy to reproduce, meaning stale entries
> never stayed long in TLB.

when I read https://lore.kernel.org/lkml/20181029105515.GD14127@arm.com/,

my understanding is that arm64 still keep something in ptep_clear_flush_young.
The reason is finishing TLB flush by next context-switch to make sure no
stale entries in TLB cross next context switch.

Should we still keep same behavior (no stable entries in TLB cross next
context switch) for madvise_cold_or_pageout_pte_range()?

So two versions work (I assume we should keep same behavior) for me:
  1. using xxx_flush_xxx() version. but with possible regression on arm64.
  2. using none flush version. But do batched TLB flush.

Hope this could make things clear. Thanks.

Regards
Yin, Fengwei
