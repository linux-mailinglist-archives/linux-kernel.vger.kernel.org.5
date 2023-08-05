Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7C4770D5B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 04:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjHECug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 22:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHECue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 22:50:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A709E19B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 19:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691203827; x=1722739827;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RA/z9evkyaAMrXitrChaeoL0Mqn8KOeKKPJLv/ThhOs=;
  b=llzbECGcpzOdQppcamoxLcpiyu67acjwNOIR8wEosMs+bsqWEFmHIwz3
   CmX2gFeQOHLWemFU2/AWzmKiIn7j5nnrv9IoFggPdfprBGyEr0h7QL6sc
   mcQRz/P/tr+I10q17fIeu7PqSemmmUNAoVt2JQ8xqPWrICgLa0wAH6K2k
   uL/kHKD9BeHUO8tVQGrtzWWju0XJNz4Q/y1cfhG9ypyPWVCDSrPKoJ1Ms
   KjKmmGWdBcCIq35tEHNF/ZUL05IkHiiruM5Jey9fZTcpSNPMLITJDA9v5
   jCh3qf51Rp6ihedIybizRg7oJVN/Ea2fVTUbzJsZ78/U/49dPt8bYglgx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="436608929"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="436608929"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 19:50:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="820364848"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="820364848"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Aug 2023 19:50:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 19:50:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 19:50:26 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 19:50:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNu7YLWr5acj6EjQ1unV7Q/TWZ/PU6H4Cb0Kc0E40ndptAY3z58iryNrt95fVFgkcrBGvEPz7PyxgbmVIzqiVKMsaY+LFW7TQV3soq6sIIdipzGQDQEsDXIXTRmWsvVLM2G1u3HTSiuRIiOeQdE9KIgCBOLvbk7YQHfP4jbpRSmeKvtDva2kbKyzXzmpr5iylt+p3MZAqI6ErGqe67lYMfLnvQAbCymjGXS50rhZ1O52L7c4cKPr7YDkhTQf5aje0I58SaoPjvVLWTkwpi76Qv8QZV+EsO5nCO02jBC+yN54hexfQaO9npfH4a07sTzQtE5JtyAnN4is9iKwnnFkjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWTlXKuHZ0ndlhuPR/o5gfym/YaojAxYouFDEJ354Ac=;
 b=WBKrU42QWizGKfUwC5hrzcKNnpNul7aJTs4WLdSORn1ZmDfEqHOiw8h3FV6DRUw5YsXRslF8Ont3MWfjdNtjhFwqAy1NDXSicI2z0C2yob6IZJUu5DnAZo1pqnKE+6IZ+Dp1asQY5HLIA0sbEC5SPjL2nBISjlP6flPH3AtczziT+Xqj153pzG/j0Zdl6c65pTjonVzt7Zi9rmigtsjkNO6XPK4OxdLh1DVd5gG55vNnJxOLsHXV6sB5lHkYmQu2+8Orre4H4hbck8E/kv8Ri49Wmtf+N46na7nojUQMj9MN77EFibo9PjsCoL+DmfOTciZHM5YAKsyHNAj/eVtaCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW4PR11MB6689.namprd11.prod.outlook.com (2603:10b6:303:1e9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Sat, 5 Aug
 2023 02:50:18 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6652.022; Sat, 5 Aug 2023
 02:50:17 +0000
Message-ID: <5781b962-9e0b-1f61-7eb7-9621ace76d90@intel.com>
Date:   Sat, 5 Aug 2023 10:50:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
To:     Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>
CC:     Yu Zhao <yuzhao@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com>
 <c02a95e9-b728-ad64-6942-f23dbd66af0c@arm.com>
 <CAOUHufaHH3Ctu3JRHSbmebHJ7XPnBEWTQ4mwOo+MGXU9yKvwbA@mail.gmail.com>
 <5e595904-3dca-0e15-0769-7ed10975fd0d@arm.com>
 <b936041c-08a7-e844-19e7-eafc4ddf63b9@redhat.com>
 <CAOUHufafd4GNna2GKdSyQdW6CLVh0gxhNgeOc6t+ZOphwgw7tw@mail.gmail.com>
 <259ad8fc-c12b-69b9-ba16-adb9e3e6d672@redhat.com>
 <CAOUHufbbrDrSv2Ak0tyyaw7qrekkQ-p2vjCqWsXFG7b-+EP=5g@mail.gmail.com>
 <0d502268-ebdc-8462-d88c-e6a41578d9ae@redhat.com>
 <60070B7E-5DC2-4CE1-8089-1A05DDDABA4C@nvidia.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <60070B7E-5DC2-4CE1-8089-1A05DDDABA4C@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0126.apcprd02.prod.outlook.com
 (2603:1096:4:188::11) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|MW4PR11MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc5c5ec-e2fd-491c-c2ea-08db955eb39c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kGzlTc+dOUmKdo8v3tubaW9F/FWCF6mDkww43qiV+ALjxfmFWqjDti8N9sB0peLqe42p69XsuhxvbARQetgKociZcAFO3yfo77vF3lZGBbrb5kPIGpx9KnO1CwFf1p2v9UyhOaoltXq2LT2SpE4lPiPaXl4kPVRCq0WzjRNzLPD+pkBuzFj/BSCw02BreDFOcNdMxbpGxvWWrDCy0epM3yG/9p//FfiN6JRgh3bCiHCKemJ7VKMufB6uMl4zSCBU6zMaourd+XF36CAMCRIt3J5Dgc68pK42QmDz4TJqTMQIhcaaP/JSgeRxyiLbuzZZpvkPZGToQxVm/FV1Oa4T1ssjYt/RnpbriGUR5WZP7NgEeStSKwJ7B/XmgqICOq2kI1NqVhV91Rhz9ssQ12jq8Nb10TGRjUhzU9hQaQHLPDwACnIiFDT6cNCo/kZ0D55V0L/wTFgYrJbAtTK+6Kx2J1UbR0g+fHUV5/LdcStzr00W3SOiY6EX2BYmz5aZPLFE9d0eaNlRta5y9Mm3OB6a21OI5Fvrea/J8CRDy0wO9rsmRbfiPvbqaKHuGIJwqpE3ooi50f9zEJHWyKt6Gquw/gbofyxf1ypNCIt1GA/vrOV/bCZJgSb/8lf5cl8FLlNEnkmiV/yubsQRWJFsfS208w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199021)(1800799003)(186006)(36756003)(86362001)(31696002)(31686004)(66899021)(54906003)(478600001)(110136005)(82960400001)(38100700002)(6512007)(53546011)(2616005)(83380400001)(6506007)(26005)(6486002)(6666004)(41300700001)(8936002)(30864003)(66476007)(4326008)(2906002)(66556008)(5660300002)(7416002)(66946007)(316002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUVETXZ2MkQrdDlLU25PcW1iVEt1VllicTlOQnViL1RVUTFKbWV2WFZHbUJQ?=
 =?utf-8?B?eHJKWVJ0elJDMlRBdVpxdDByZWVuTlo3UXdjRWNLTG80U0VSM0UyZUgyMXZR?=
 =?utf-8?B?RTM1Z1pkYmdpTzJ3eDFLZSs1ckp5eUdmb1ExZG9IYWpQM0w1QVNjQnFRWG9K?=
 =?utf-8?B?ZU1aamNYL01JTkZMQ1Uzc3VPZEpZdTRXRnRNcHlhTDFWKzM4Tkh0L3lxL1Ns?=
 =?utf-8?B?Wm9WTzJLTzBYUnVoMnNHMEhSMUdqUEYyR2NoY2xMYUxXM3U3K0JkbzM5TUwx?=
 =?utf-8?B?K1dleUtWZW11d0lhL0xMbEpFZi8vRnM2MjdtdUc2cmR5ZGhMSm1lOFlHek1x?=
 =?utf-8?B?ZmdxQUlhV2RGUGNwb0xHcUcwdkFmTW1Ib2hiVk9yYWdYS0NTSHR5Q0xnWW1Y?=
 =?utf-8?B?akVBNVZlaUExdTRxcUZkWWJOOVRkdy9kSkNNc1RLZ3g0K2RkRDhUVUt3a29s?=
 =?utf-8?B?Zy9iTWpjT0lrRUd0N21kTlh4Qk91eW9oWlRPTUQ0aWx6N2RKUU12TGtsRldw?=
 =?utf-8?B?QlllWmhvYXBpdzZOdktEZXhRMFlFZUs1Y3d1am93TzhaNnNCQnQrM2hsemt6?=
 =?utf-8?B?Z3FlUlVPdklzWFJScHo4RG1UenJGUVRLNHY3cFZPbHFLSkVpTzlTd1BIdjVU?=
 =?utf-8?B?amt0cjlaQ1BmRU5lYVdWaWxjeFRtRmcrSGtlNlVvbUIxRmlSaVpTc3lpVXM0?=
 =?utf-8?B?RmZWUWRpQ0NYQmdTVnpyL0o3SXBVMWR1SThLU1pMcEtuVWtLaEtEYVlOVXcr?=
 =?utf-8?B?dDlSVmVJb2RyOFRkclJISFpIbkwvK3QxbGh0elp4ZzA5QlVyenNiam0zZkJx?=
 =?utf-8?B?STZtdy9UcHArUGZ4UERFdHBxbHcySnNZcndIVGZSa0hodmlLR2p3OGRCaVda?=
 =?utf-8?B?Q2x0WlRFbjZCci83S2UrRHJlMkRNbmk1RFpEcE16Uko0b1NnWElMWmhRczBZ?=
 =?utf-8?B?V1YyMCtRaVR5c0RjZWVGeXdESjVJbzVwUzN1bmExZS9iMFFsaXdtRHAxVjlP?=
 =?utf-8?B?dkJVVi83VWQvRnUveWVPQjRsU2JpUlR3b3VYTlBSOGppWm92NG0yUkhqMEdv?=
 =?utf-8?B?SXVnam1uUHRGWDlWZW8vSWdValBIN0ttakx2WllvZGlmZVM3Qi9TOC9MWVpK?=
 =?utf-8?B?SUNoWnV6dVZmc2FYYVZxNDFXNVFOV016dlJ3RzlNaFRVMk1QMDRId2Z0RTdD?=
 =?utf-8?B?QnNIU0t2UXhCUTM3d3BkSktpL0p4U2ZVa0lSaUdMQ1IxWUVxdEwyQjJoTXd4?=
 =?utf-8?B?alJCWkIyK1piWW40bGdodEJaZGdtM2Y2Ung5ZnNDblhUUC9jL3RHM25sMmxo?=
 =?utf-8?B?RGM3d3hBcG1nTVROWDJTclFNN2ZDY21xcWFvVFZMMFBvK21pV3ZsZFpHUXUr?=
 =?utf-8?B?dVJjRGgwTnpWRzlleDAzM2dISGZIWnhKcHYxRks2L3JCazVaVjNIWkpYZSs0?=
 =?utf-8?B?bnBwVzFXNnBKcU5qU1AwZ0xSVTA4Y1VaUllNdEdLT3NBNUsreVZ2MXZsYlFD?=
 =?utf-8?B?STYyUHd6dzErUmlFM1B1SGZ0Z2pzbWtuaXZQZVpReGViREVsd3RydEdwL1Ew?=
 =?utf-8?B?UXpHWU9tbVRzMGREcjhDQXMvRFNLTTVCYVFtZ09iQW15eFJ3VHN4bzAzNlUx?=
 =?utf-8?B?U3pONHRzU2JRSUZWVldjc1ZtZS9xYlRPSS9kUk4vYmQwUVN2QVo5TmhscUM3?=
 =?utf-8?B?UjZ1MzBwdTlYdjdJc2I1M3pMVEpER05Cekc3bFNNZnB4MHRRaWlYZG5QWGlT?=
 =?utf-8?B?b1QwL3FyaUYwU00xVzE3enZQWjVjMzk5Z3VNSW9BMjVPYXBJT1pSVWo3T1li?=
 =?utf-8?B?MGlUS3pqaUNwTW1FTk9WblMzQVRJcmRJVjJrMThyN1pRcW44OXR5OTgrRlQ3?=
 =?utf-8?B?Um5OSGltK2RvT3o5NXd3K0tyWDh0N1Vta1diMmVieEhIZlFJM3pEeWczNUtF?=
 =?utf-8?B?T1R4N1RrbjJ4TXlJK2loZGpZeWhNbkJFMmNoUlNYYll1ZUdWOHZSSkg2Zm5h?=
 =?utf-8?B?ZUE0SytpVWt1bU5PVW1jaGJmTlRUYURqWjhFM2hscUxDWTlPSU53L2lNc2pZ?=
 =?utf-8?B?MjBuVjdJa0FyVWNPNHQ0QTlQNzU1a204M2pxOXNRWE4vWjRNdmhXU2RTb01J?=
 =?utf-8?Q?ad1R8p0Awp37aruL+VweP5Lg3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc5c5ec-e2fd-491c-c2ea-08db955eb39c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2023 02:50:17.8112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMnseG+w/vaFiX8fAskCf4pVN5t6vzIFEU0FC0oGg7Ai9Jqfza3rVpe2vQCsjyhoOCcyMHUCd0LHExgZWOZ9MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6689
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/5/2023 5:58 AM, Zi Yan wrote:
> On 4 Aug 2023, at 17:30, David Hildenbrand wrote:
> 
>> On 04.08.23 23:26, Yu Zhao wrote:
>>> On Fri, Aug 4, 2023 at 3:13 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 04.08.23 23:00, Yu Zhao wrote:
>>>>> On Fri, Aug 4, 2023 at 2:23 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>>
>>>>>> On 04.08.23 10:27, Ryan Roberts wrote:
>>>>>>> On 04/08/2023 00:50, Yu Zhao wrote:
>>>>>>>> On Thu, Aug 3, 2023 at 6:43 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>>>>
>>>>>>>>> + Kirill
>>>>>>>>>
>>>>>>>>> On 26/07/2023 10:51, Ryan Roberts wrote:
>>>>>>>>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
>>>>>>>>>> allocated in large folios of a determined order. All pages of the large
>>>>>>>>>> folio are pte-mapped during the same page fault, significantly reducing
>>>>>>>>>> the number of page faults. The number of per-page operations (e.g. ref
>>>>>>>>>> counting, rmap management lru list management) are also significantly
>>>>>>>>>> reduced since those ops now become per-folio.
>>>>>>>>>>
>>>>>>>>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
>>>>>>>>>> which defaults to disabled for now; The long term aim is for this to
>>>>>>>>>> defaut to enabled, but there are some risks around internal
>>>>>>>>>> fragmentation that need to be better understood first.
>>>>>>>>>>
>>>>>>>>>> When enabled, the folio order is determined as such: For a vma, process
>>>>>>>>>> or system that has explicitly disabled THP, we continue to allocate
>>>>>>>>>> order-0. THP is most likely disabled to avoid any possible internal
>>>>>>>>>> fragmentation so we honour that request.
>>>>>>>>>>
>>>>>>>>>> Otherwise, the return value of arch_wants_pte_order() is used. For vmas
>>>>>>>>>> that have not explicitly opted-in to use transparent hugepages (e.g.
>>>>>>>>>> where thp=madvise and the vma does not have MADV_HUGEPAGE), then
>>>>>>>>>> arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever is
>>>>>>>>>> bigger). This allows for a performance boost without requiring any
>>>>>>>>>> explicit opt-in from the workload while limitting internal
>>>>>>>>>> fragmentation.
>>>>>>>>>>
>>>>>>>>>> If the preferred order can't be used (e.g. because the folio would
>>>>>>>>>> breach the bounds of the vma, or because ptes in the region are already
>>>>>>>>>> mapped) then we fall back to a suitable lower order; first
>>>>>>>>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> ...
>>>>>>>>>
>>>>>>>>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
>>>>>>>>>> +             (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_SHIFT)
>>>>>>>>>> +
>>>>>>>>>> +static int anon_folio_order(struct vm_area_struct *vma)
>>>>>>>>>> +{
>>>>>>>>>> +     int order;
>>>>>>>>>> +
>>>>>>>>>> +     /*
>>>>>>>>>> +      * If THP is explicitly disabled for either the vma, the process or the
>>>>>>>>>> +      * system, then this is very likely intended to limit internal
>>>>>>>>>> +      * fragmentation; in this case, don't attempt to allocate a large
>>>>>>>>>> +      * anonymous folio.
>>>>>>>>>> +      *
>>>>>>>>>> +      * Else, if the vma is eligible for thp, allocate a large folio of the
>>>>>>>>>> +      * size preferred by the arch. Or if the arch requested a very small
>>>>>>>>>> +      * size or didn't request a size, then use PAGE_ALLOC_COSTLY_ORDER,
>>>>>>>>>> +      * which still meets the arch's requirements but means we still take
>>>>>>>>>> +      * advantage of SW optimizations (e.g. fewer page faults).
>>>>>>>>>> +      *
>>>>>>>>>> +      * Finally if thp is enabled but the vma isn't eligible, take the
>>>>>>>>>> +      * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_UNHINTED.
>>>>>>>>>> +      * This ensures workloads that have not explicitly opted-in take benefit
>>>>>>>>>> +      * while capping the potential for internal fragmentation.
>>>>>>>>>> +      */
>>>>>>>>>> +
>>>>>>>>>> +     if ((vma->vm_flags & VM_NOHUGEPAGE) ||
>>>>>>>>>> +         test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
>>>>>>>>>> +         !hugepage_flags_enabled())
>>>>>>>>>> +             order = 0;
>>>>>>>>>> +     else {
>>>>>>>>>> +             order = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
>>>>>>>>>> +
>>>>>>>>>> +             if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
>>>>>>>>>> +                     order = min(order, ANON_FOLIO_MAX_ORDER_UNHINTED);
>>>>>>>>>> +     }
>>>>>>>>>> +
>>>>>>>>>> +     return order;
>>>>>>>>>> +}
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hi All,
>>>>>>>>>
>>>>>>>>> I'm writing up the conclusions that we arrived at during discussion in the THP
>>>>>>>>> meeting yesterday, regarding linkage with exiting THP ABIs. It would be great if
>>>>>>>>> I can get explicit "agree" or disagree + rationale from at least David, Yu and
>>>>>>>>> Kirill.
>>>>>>>>>
>>>>>>>>> In summary; I think we are converging on the approach that is already coded, but
>>>>>>>>> I'd like confirmation.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> The THP situation today
>>>>>>>>> -----------------------
>>>>>>>>>
>>>>>>>>>     - At system level: THP can be set to "never", "madvise" or "always"
>>>>>>>>>     - At process level: THP can be "never" or "defer to system setting"
>>>>>>>>>     - At VMA level: no-hint, MADV_HUGEPAGE, MADV_NOHUGEPAGE
>>>>>>>>>
>>>>>>>>> That gives us this table to describe how a page fault is handled, according to
>>>>>>>>> process state (columns) and vma flags (rows):
>>>>>>>>>
>>>>>>>>>                    | never     | madvise   | always
>>>>>>>>> ----------------|-----------|-----------|-----------
>>>>>>>>> no hint         | S         | S         | THP>S
>>>>>>>>> MADV_HUGEPAGE   | S         | THP>S     | THP>S
>>>>>>>>> MADV_NOHUGEPAGE | S         | S         | S
>>>>>>>>>
>>>>>>>>> Legend:
>>>>>>>>> S       allocate single page (PTE-mapped)
>>>>>>>>> LAF     allocate lage anon folio (PTE-mapped)
>>>>>>>>> THP     allocate THP-sized folio (PMD-mapped)
>>>>>>>>>>          fallback (usually because vma size/alignment insufficient for folio)
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Principles for Large Anon Folios (LAF)
>>>>>>>>> --------------------------------------
>>>>>>>>>
>>>>>>>>> David tells us there are use cases today (e.g. qemu live migration) which use
>>>>>>>>> MADV_NOHUGEPAGE to mean "don't fill any PTEs that are not explicitly faulted"
>>>>>>>>> and these use cases will break (i.e. functionally incorrect) if this request is
>>>>>>>>> not honoured.
>>>>>>>>
>>>>>>>> I don't remember David saying this. I think he was referring to UFFD,
>>>>>>>> not MADV_NOHUGEPAGE, when discussing what we need to absolutely
>>>>>>>> respect.
>>>>>>>
>>>>>>> My understanding was that MADV_NOHUGEPAGE was being applied to regions *before*
>>>>>>> UFFD was being registered, and the app relied on MADV_NOHUGEPAGE to not back any
>>>>>>> unfaulted pages. It's not completely clear to me how not honouring
>>>>>>> MADV_NOHUGEPAGE would break things though. David?
>>>>>>
>>>>>> Sorry, I'm still lagging behind on some threads.
>>>>>>
>>>>>> Imagine the following for VM postcopy live migration:
>>>>>>
>>>>>> (1) Set MADV_NOHUGEPAGE on guest memory and discard all memory (e.g.,
>>>>>>        MADV_DONTNEED), to start with a clean slate.
>>>>>> (2) Migrates some pages during precopy from the source and stores them
>>>>>>        into guest memory on the destination. Some of the memory locations
>>>>>>        will have pages populated.
>>>>>> (3) At some point, decide to enable postcopy: enable userfaultfd on
>>>>>>        guest memory.
>>>>>> (4) Discard *selected* pages again that have been dirtied in the
>>>>>>        meantime on the source. These are pages that have been migrated
>>>>>>        previously.
>>>>>> (5) Start running the VM on the destination.
>>>>>> (6) Anything that's not populated will trigger userfaultfd missing
>>>>>>        faults. Then, you can request them from the source and place them.
>>>>>>
>>>>>> Assume you would populate more than required during 2), you can end up
>>>>>> not getting userfaultfd faults during 4) and corrupt your guest state.
>>>>>> It works if during (2) you migrated all guest memory, or if during 4)
>>>>>> you zap everything that still needs migr
>>>>>
>>>>> I see what you mean now. Thanks.
>>>>>
>>>>> Yes, in this case we have to interpret MADV_NOHUGEPAGE as nothing >4KB.
>>>>
>>>> Note that it's still even unclear to me why we want to *not* call these
>>>> things THP. It would certainly make everything less confusing if we call
>>>> them THP, but with additional attributes.
>>>>
>>>> I think that is one of the first things we should figure out because it
>>>> also indirectly tells us what all these toggles mean and how/if we
>>>> should redefine them (and if they even apply).
>>>>
>>>> Currently THP == PMD size
>>>>
>>>> In 2016, Hugh already envisioned PUD/PGD THP (see 49920d28781d ("mm:
>>>> make transparent hugepage size public")) when he explicitly exposed
>>>> "hpage_pmd_size". Not "hpage_size".
>>>>
>>>> For hugetlb on arm64 we already support various sizes that are < PMD
>>>> size and *not* call them differently. It's a huge(tlb) page. Sometimes
>>>> we refer to them as cont-PTE hugetlb pages.
>>>>
>>>>
>>>> So, nowadays we do have "PMD-sized THP", someday we might have
>>>> "PUD-sized THP". Can't we come up with a name to describe sub-PMD THP?
>>>>
>>>> Is it really of value if we invent a new term for them? Yes, I was not
>>>> enjoying "Flexible THP".
>>>>
>>>>
>>>> Once we figured that out, we should figure out if MADV_HUGEPAGE meant
>>>> "only PMD-sized THP" or anything else?
>>>>
>>>> Also, we can then figure out if MADV_NOHUGEPAGE meant "only PMD-sized
>>>> THP" or anything else?
>>>>
>>>>
>>>> The simplest approach to me would be "they imply any THP, and once we
>>>> need more tunables we might add some", similar to what Kirill also raised.
>>>>
>>>>
>>>> Again, it's all unclear to me at this point and I'm happy to hear
>>>> opinions, because I really don't know.
>>>
>>> I agree these points require more discussion. But I don't think we
>>> need to conclude them now, unless they cause correctness issues like
>>> ignoring MADV_NOHUGEPAGE would. My concern is that if we decide to go
>>> with "they imply any THP" and *expose this to userspace now*, we might
>>> regret later.
>>
>> If we don't think they are THP, probably MADV_NOHUGEPAGE should not apply and we should be ready to find other ways to deal with the mess we eventually create. If we want to go down that path, sure.
>>
>> If they are THP, to me there is not really a question if MADV_NOHUGEPAGE applies to them or not. Unless we want to build a confusing piece of software ;)
> 
> I think it is good to call them THP, since they are transparent huge (>order-0) pages.
> But the concern is that before we have a reasonable management policy for order>0 &&
> order<9 THPs, mixing them with existing order-9 THP might give user unexpected
> performance outcome. Unless we are sure they will always performance improvement,
> we might repeat the old THP path, namely users begin to disable THP by default
> to avoid unexpected performance hiccup. That is the reason Yu wants to separate
> LAF from THP at the moment.
> 
> Maybe call it THP (experimental) for now and merge it to THP when we have a stable
> policy. For knobs, we might add "any-order" to the existing "never", "madvise"
> and another interface to specify max hinted order (enforcing <9) for "any-order".
> Later, we can allow users to specify any max hinted order, including 9. Just an
> idea.
I suspect that all the config knobs (enable/disable mixing mode, define "any-order"
or "specific-order") will be exist long term. Because there are always new workloads
need be tuned against these configs.


Regards
Yin, Fengwei

> 
> 
> --
> Best Regards,
> Yan, Zi
