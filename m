Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398DF76D301
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbjHBPyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbjHBPx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:53:59 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8CA1735;
        Wed,  2 Aug 2023 08:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690991580; x=1722527580;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Eg8kYX9owgzogRsJFq6m5xh/3LwE9ZSMUk6epLYrCg4=;
  b=fCLbEKQd22ZpGn1C/KucSg/d8n7QMWg/yCQSz7v+2oqiONkfd+Qlkg6t
   uI8+a35DzeH0UICegEHexI2oosI7w0KVIe+m2SgbNzpJXrC5FLhEhRflS
   VZbEK+/Ci+6ltMPdftDC8N+C8jv4jRdqR9RN3fLb2QAHYSBQ68kTmOKGN
   CBUhXHa+iOOX2vT0t4bp+vY2P+9ITbs26mjPYyiAxUyM6Y6kA5hj28GeB
   dEgf2/e8a2DMDe8TYTMaIazVh6whBkECYIsGnXjdjRCWwq6YGsBtamPaE
   HAslYOONpnS3MX+0WyIJaeIVdPRIz+I0rFH6j/to6glMtjb5NMfK1zYym
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="349221694"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="349221694"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 08:51:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="758794292"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="758794292"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 02 Aug 2023 08:51:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 08:51:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 08:51:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 08:51:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 08:51:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aM4exV7wR/Un/iJW0L3QrVdNgU3GhVxE4OUyzjEowobTa2oLmdu77EkQs7Bku3CYSk8Wy/fMF3xxJEQB2y/deCx5R9n+bcIyzg7HvYLggqLD18Uc+t05QNfteg61GsqBacVL98upDPQr2VsPNF9yxgC7NRAA/oZMtQ2+WN6ZCPxXGDZjQWxzPEbhGXPEzwyA5bInrGYghBYXnk7DlV6GyjQkgAmZUeeOiL2NwKNLoMu//QevlY+Oz2sg9N6pa5jBnUxbJ8v+e9EINfxbApOsJYahqhlziy7nJSEf962qOfg6HIEULAm85YuDbCbtyKQz1T7oVJS8wlfB9IQuiyv1rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRewjsOUXfHGau6fENRz9xxH6FaEwd3mf9WYEZWSKFY=;
 b=YJ1f0n0LpBT2+3FchYDq2pGzj4JALAs1ILffo8kJd+bfPT2d1akdSrMtAqFSW3C4gVHchJ1AdKDVvH3luWtGukq9yYk+M30Ge3RmRvHAQAEH6V2UrB212LkdbU110wMZBqsmdy61WksZn2Z1cenzQiRz/GZKboEp4snOOrjMABwCvmQV1BYsCOLm+3q9Zyax6VOmc13FMl2SGcPcYSPmKCcvXRETmZoURVSSi+hiIUg4NKIK36i46WGPmCfgfCsT3/TZ1PGa9iTS8PSb7ckD2KUFUJcVYG29CvrgDIihaQwt1P+WaSvn5zq0CmC6mCAPg1hZ8gdmzFT8G9OWNsCK0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CYXPR11MB8663.namprd11.prod.outlook.com (2603:10b6:930:da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Wed, 2 Aug
 2023 15:51:08 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 15:51:07 +0000
Message-ID: <e32d7283-edfb-7803-58e4-b715714c86a1@intel.com>
Date:   Wed, 2 Aug 2023 17:49:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next 6/9] page_pool: avoid calling no-op externals
 when possible
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
 <20230727144336.1646454-7-aleksander.lobakin@intel.com>
 <a79cc7ed-5355-ef7d-8865-0ba9673af5c6@huawei.com>
 <604d4f6c-a6e7-e921-2d9a-45fe46ab9e79@intel.com>
 <799ebbaf-961d-860a-6071-b74e10360e29@huawei.com>
 <1644b9d0-27a5-0c2b-c530-bcaa347f73c2@intel.com>
 <00695c43-b376-169d-a62d-c1a373cde90c@huawei.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <00695c43-b376-169d-a62d-c1a373cde90c@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0266.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::15) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CYXPR11MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: 98051fd9-8e22-48c9-1c41-08db937048f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c4S41dPnziXsPUgcq2/SdtXqpaf7QQgtuARtpBffU5M+NUHGSlzl1OtlcyplLoz36Gh1gYTwVkjPjuSEpP4vJFaWN6qHrY+dNNC06Ah8JCLfzjbdSz0KnYflkIfisXeHWuGAeb20/FYURCwLEyUsKgt3P94zVSgEi/37eA4UE306Neu/t3g4ktzufRVw+DmlX8Eyh4AgLumVSgLaDHLQKuY0ufDUdkPDn5cMsHI/EI/kFE5PYbmQu2CoEu0IA35DmxkG1KdYpnLhxddTy57TOpvSxyth2bl0cQflz88tNUyEU0FJiZp15ZDLN1w4S23Y5gD5oHuhh4HepeLIdXDq+aBTM7H8Z3vPjKgfQI8HKjOjvAPf+8Za6EFZ5X3kkBZ1VttJXIl3/l762M7fCi4TslgEIXcy+LEUdKLPuQKP43+dPDxzaHZt0QljvSV6H9HYWo767D3EMraOohQ0vEctsFMFd912EKRHA2NGBIvJ0LKoc/RdSzolowvaMDLTQXIhGQDKP+0chNCHnakriJG/80/3Vvhsfg4poatkmUvN6f2nKrqDeGLHiy/Sdbf89dF8HVQPZeIfM8UDqjsF4cecuV1CMDopAFNI6u/6ADewPZ02J5ZssQKWz2z6w5Q8qZDP3aLDfa92GSn5gXHXd1uSMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199021)(478600001)(38100700002)(82960400001)(86362001)(31696002)(36756003)(966005)(6512007)(6666004)(6486002)(2616005)(186003)(26005)(53546011)(8676002)(6506007)(8936002)(7416002)(5660300002)(66946007)(66556008)(66476007)(54906003)(31686004)(4326008)(316002)(41300700001)(2906002)(6916009)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlpRd09oMmVZNkxzSzZnM3J2TTNUdk9OODIvQld1eklhVXkrckdVUUlLMUFI?=
 =?utf-8?B?Yld3M3YyeEl6RStkT2xLMEwxbEttVWpXY25KVGR6MTh5WmZWV1BqUS94Lzdi?=
 =?utf-8?B?a1dtQytIcWZNNm9iK1k4ekdlTmc1UXpTUENURFVPajEvWnQxL0tHYU55TU1B?=
 =?utf-8?B?OEErWnZEbEt0cUxwY1FFTzFPZU1zTHFFOVdDdkR6MWhzbjNjd2t1OU5TSGZm?=
 =?utf-8?B?UHZ4THlqM0RSWFBoODRKWHdjL0NUajQ2NVZQVXAwdGVHdVpwQjBqdU1paXND?=
 =?utf-8?B?ZXRtOGZsRmRJdHJKZUQxUFNRK05tMWo2RjRWWnhkaGxDRzlkQkZhQm93MWtZ?=
 =?utf-8?B?UUFNVzdzUVJ5ZmZKaW1USjZPMTJlV21kNVozNUJHdWZodlA0TVFOWGdzVmNX?=
 =?utf-8?B?cTR3M3EvNTV5NUlqa2gvYVBzYjNPSmNIdXRkdU5idTFQUmlORGxqZ2EycGNa?=
 =?utf-8?B?Ri85MjBtaHE5NXlmZ3c0dlhKUjZRTm9uTFdJY1RMbllCZ1dzTGZVY3ZxMGxY?=
 =?utf-8?B?Zk5MbFh6T09uT3ZMMFBwZVVSZGh2cThWdFF1N3FRS0Nra0NaOHBQM0xmVHBz?=
 =?utf-8?B?Z0h0LzJxMllEVE9ZcEdYYkZCRlNGcVVQZGI1OVFLU0lhNnFOSEtoQmwxYTQy?=
 =?utf-8?B?Yi9nS3FCMTg1VklaTGI2YzBVeFpNdGpNZDFvbnNNVHhhU20yV3RRWWl5ZHZh?=
 =?utf-8?B?SW1wWU5sMVB5REpyZGNlYTNiRytzS3oyQTJhenV0UStjVERjd044a3FaZWxz?=
 =?utf-8?B?alZLcXJUOFV3NTNOSENhWGRNNlVXT29NVHN0NU12ZDB3Mkw2dGtjWGFMNk9U?=
 =?utf-8?B?ZXliT2VuNDdTK2dkdkZNYjgrYW5rRUlaNU02dnlSNUxGV2E2S0lnQ25EYXk1?=
 =?utf-8?B?VVd2WmdJUklQaEJhSEFMWXlQbngvUGdLL1dtdytMWVNaMWRGeDdmY3pyc1VU?=
 =?utf-8?B?SHJwV0Z0c0xiNlhUZXBVbjcwbFFXRXdFQlNtR2N4MXBGTkgwcTFUVWtqN21t?=
 =?utf-8?B?eEZOK0JjbEJwT1Q2eERSdngvUU4zSzdFQU1ETlZzUldvVGhaSWZ3bFltMGF2?=
 =?utf-8?B?WFdkRmhmZUd2dVQ2VG50d3FXeWZEMG1qMzRBS09oYmd6TDJQVlBORXc3emwx?=
 =?utf-8?B?Ri91MzJBSnpDWHpSUnFNYmNsY0hHd1pQclA0Yk12Ym91R3BzUTNOdDZaalE3?=
 =?utf-8?B?V2cydEVGMjljNG5INy9FcTNnTVRnaHRENU9tM0VSczMyc3lRalFqOFBBVGFn?=
 =?utf-8?B?ZXZQQ1NkM2lNYkhRY2VGa3JKYkFMVlJrWXdVenU2U2NWelZ2QnRlaVdiSk03?=
 =?utf-8?B?ZUx2MEY5UXY4MkFFczVMTWh2UGxhdjhISDNUSmkvU2gyU1VhTnEwOVZwek5y?=
 =?utf-8?B?MmZSMkJhZ3FpVkZQN2pRM3Z0YVJFeGdNNTlINDU1ZDZQYUZMb1ZGK1FncFdN?=
 =?utf-8?B?USs4MnhUeEUxOWtnNndVM2JjWnpQK2xMcCtZbTRpeGVqVDkycTU1ZTJXcGZl?=
 =?utf-8?B?NloyVlMyL1dYMlpZSnQwb0tKcHlEa0JLOEFYbHgrbnRZK2R5Mm95ZjhHaE9E?=
 =?utf-8?B?TXdLdnJWRmFsL1lheGgyY1BpVlZBeWlsMXA1eHA2eHdFTlU1ajFNZmlqZ2lN?=
 =?utf-8?B?cVNSVlVKV3phNUxuSTN2K2lObGxmbWNVdzM4anBISUhQa0Q4ZDBQNUg1aTJE?=
 =?utf-8?B?SEFlVEF6QU5YaWpQMXRDaDJjYndHTm55NmhNTGFUblFDTVZSdzJReTVrZ3dv?=
 =?utf-8?B?ai96THdrekFMYklmejErbStLN1lIRURzOU1ZRjlHeUVwd3pzd2Vab0hFVXg2?=
 =?utf-8?B?R3cyNGVDUkJTeDcvVmU1TU1WV05zOG55dThSVC80enlhNHlJaDdVcFhiMWNh?=
 =?utf-8?B?OGIyTWFjZHltcjRKS3VwbXg0dnBLMkxOSysxQm1rY21tbmg4Z2dMN2ZzWWZH?=
 =?utf-8?B?THQzMi9vZjFvbm94bThnaTJGeGR3a0cwWEw3Z2lkM1R6UzcveWZzMENLME83?=
 =?utf-8?B?Y2hvYVAvVE5aSHcwM3U0NHRBQTFJN0JlRzFWY2EraENOcVA1V1FTZXhDVWdM?=
 =?utf-8?B?eXNhUis5azRLcGRINzQ3TmZCaHdINk40VE5odmF0TWtpa2JjVHRoa3JiaGlT?=
 =?utf-8?B?VmZiZFhiSFZnQ2xzRU5ocmJFK0N3cTFKdnZmK013N09ORS9JNWRjU0ROcllK?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98051fd9-8e22-48c9-1c41-08db937048f7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 15:51:07.5416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWD6rCegjg5vwaMRERFB6lbHak6y25u2NTp/nHcFGy5i2q0vvtJGGb7eogYOSDy3wZIWmOMFtCSLooN/Ek0bZPSJ/u+Gsceb2dUoneRpbz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8663
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

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Wed, 2 Aug 2023 19:37:35 +0800

> On 2023/8/1 21:42, Alexander Lobakin wrote:
> ...
> 
>>>>>
>>>>> It seems other subsystem may have the similar problem as page_pool,
>>>>> is it possible to implement this kind of trick in the dma subsystem
>>>>> instead of every subsystem inventing their own trick?
>>>>
>>>> In the ladder I described above most of overhead comes from jumping
>>>> between Page Pool functions, not the generic DMA ones. Let's say I do
>>>> this shortcut in dma_sync_single_range_for_device(), that is too late
>>>> already to count on some good CPU saves.
>>>
>>> We can force inline the page_pool_dma_sync_for_device() function if it
>>> is 'the good CPU saves' you mentioned above.
>>>
>>>> Plus, DMA sync API operates with dma_addr_t, not struct page. IOW it's
>>>> not clear to me where to store this "we can shortcut" bit in that case.
>>>
>>> It seems we only need one bit in 'struct device' to do the 'shortcut',
>>> and there seems to have avaliable bit at the end of 'struct device'?
>>
>> dma_need_sync() can return different results for two different DMA
>> addresses within the same device.
> 
> Yes, that's why we need a per device state in order to do the
> similar trick like this patch does.

Per-device state is dev_is_dma_coherent()[0]. The rest is
adderss-dependent (or almost).

> 
>>
>>>
>>> Is it possible that we do something like this patch does in
>>> dma_sync_single_range_for_device()?
>>>
>>> One thing to note is that there may be multi concurrent callers to
>>> dma_sync_single_range_for_device(), which seems to be different from
>>> atomic context for page_pool_dma_map(), so it may need some atomic
>>> operation for the state changing if we want to implement it in a 'generic'
>>> way.
>>>
>>>>
>>>> >From "other subsystem" I remember only XDP sockets. There, they also
>>>> avoid calling their own non-inline functions in the first place, not the
>>>> generic DMA ones. So I'd say both cases (PP and XSk) can't be solved via
>>>> some "generic" solution.
>>>
>>> If PP and XSk both have a similar trick, isn't it a more clear sight
>>> that it may be solved via some "generic" solution?
>>
>> Both shortcut their own functions in the first place, so I don't know
>> what generic solution could be to optimize non-generic functions.
> 
> If we are able to shortcut the generic functions, for the page_pool
> and XSK case，it seems the non-generic functions just need to be
> inlined if I understand your concern correctly.
> 
> And for that we may be able to shortcut the generic functions for
> dma_sync_single_range_for_device() used in driver too?

dma_sync_single_range_for_device() takes: @dev, @addr, @offset, @size,
@dir. Where are you planning to put/get a flag indicating the sync is
[not] needed?
The thing with the PP shortcut or XSk shortcut is that they're local. We
have limited number of DMA mappings with certain direction and for
certain purpose.
A global device flag with the same logics (i.e. which gets disabled as
soon as you get the first address requiring sync) is way less optimal.
The same device that you use for Page Pool, is used for Tx mappings.
There, you can get kmalloced skb head, or highmem frag page, or anything
else more complicated than pure lowmem low-order pages that we use for
Rx or XSk pools.
That said, some odd skb will eventually disable your shortcut, even
though it was perfectly legit for your Page Pool.

> 
>>
>>>
>>> Is there any reason there is no a similar trick for sync for cpu in
>>> XSk as below code indicates?
>>> https://elixir.free-electrons.com/linux/v6.4-rc6/source/include/net/xsk_buff_pool.h#L152

[0]
https://elixir.bootlin.com/linux/v6.5-rc4/source/include/linux/dma-map-ops.h#L268

Thanks,
Olek
