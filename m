Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0084B76B61F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjHANo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjHANoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:44:54 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425B6ED;
        Tue,  1 Aug 2023 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690897493; x=1722433493;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ajqumk0g5vNzXiC1B43/+fSH09QEZuSaRKIY+OPYad4=;
  b=lNx9qHjKgY75Kidnj4VntdbbR3hjyffUO0VFXR4X8Dxv025Wm/fZY2OX
   GTa6drpAPuZlTFvivEOtYgwqe04PcqIGZnhkd4a6MFe/QiXLHfP2dTDsq
   Kf3uyfobsHq8BSdqQWqLyJybKwV3VBLCyEa1IZuPPFeZEvX/pDcXboC8r
   KPz/wm8FC8D8UrWk7j64xcDNdSsJfkH2msCkyHsN+9e9L3ePucrwOZEsE
   p1qDwjsC8G1sVhB6/WH/kYX4zRfvgeHEWyeBZZa2nZXWRQKUaSQY0RkMg
   fm0WZGmLf1hW81RJG8QahmepV10NqFbbCb3p8YI4YBpR04G59aJvcm/gO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="348900649"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="348900649"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 06:44:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="902554631"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="902554631"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 01 Aug 2023 06:44:52 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 06:44:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 06:44:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 06:44:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5iVZqSTYc9cTtoFbVqcilnPM2R2e55/eIkZbH06yzhlBrsbPVLBVc1jXJB6eZx6DJB7LhDiB+PMgy23nMLEmQXw/vanPfw0l+c4m/MAKwDZWox1wvGFUh61hgfefFi4K1sZIBJY5GRT73TofIoNJi8xF4ieaGz9+jYR8g4JbeK6WVKRXeUbzB/4QHAS+zO8wu4vay+BliShmmyziHmcQ1PCZFhNnecmvQBZ8Xbb1BgCGNi/uPVwG8I66F3pU4OHRIz1iRy8POmMA5JnAVXbv4eL5W5C+UrHOcAykvcquAp/98xnUv6sA1U7ZOkQorFYjyV0a3rSq+yZUV0qfMm3Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUzix8VZvYWhisF5jZ16qrZjp3B7/J+T6isswlXOiTA=;
 b=bTZ1iC2OmsuKr4jbZJcEsNcmH9uAXelIM61ZZqGqd/OsDJL0eIHEo36cr47icGuGCF40z+voO8BBPqrNQMxlOGF1rCkK2PcMuhnxyEF2OfLKhCjJkaIn7raSSiUIOqosNsxmgfOWcAjERvOpkoyVVLhwEdLgauE6WtWUiX68RVn1eJCEaPR1gcstDK3C9sA+8OV2YKW89aCElcNvbZP5Fb4Gd7tLp3H8AHrmAzmdUPwuiNzQbmF8K6Ip9FIJ+DHLM9MjBtAdy6hMdPmzGX/VcQO3v4hYuEALGX+LSMuAyogwb96zx78pp7/vj6CVp1N5vrc5J5s7GH2SbA1pqeSLtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SA2PR11MB5212.namprd11.prod.outlook.com (2603:10b6:806:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 13:44:47 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 13:44:47 +0000
Message-ID: <1644b9d0-27a5-0c2b-c530-bcaa347f73c2@intel.com>
Date:   Tue, 1 Aug 2023 15:42:59 +0200
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
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <799ebbaf-961d-860a-6071-b74e10360e29@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0322.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::16) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SA2PR11MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: 764bd0cb-e375-4fc6-3300-08db92957824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: deAp0wRJQOOYfvfa+2aBuAsZDl+toEcn88xX3DGbJT7YEsI16m8BLiSlRmTL1ubqDAaSkj/AYzBsg1MhbTryrJ2YA/USUqoPIqxjLrCuL0HfuouJHPaqgtRQ1uILBuMWkiELSL/4pRxHu5F59ZBcMdEAXkcpE3AbZrfvpxelFgZYJeqskE0hE9RtwUlJzUf2TWcNBI1b4vL6HJZ6T3TvoDQIQD/0oXjTQtHVloBOoTYsXMw4Mier9vjxzh7yLTthdHBDgp+vtjtC6rJ1kEpeNRp2DM8sFQnn9ITghJ5O/ztwlFCVbLRXVCo5jjtsKUj0XNGhq2C9XrXkY08Ly5gVwrlPJ0GEY6P7YZzNlk6IWU9He/9GyiM0WfwKR1E2D7ZEPJZnwwVB7LmJ0Ki+Htjn2K2nOowLngV/q3U8wtVFIJJ4WJ2iRdQUuVo254Gj2waVa9lltIkpwTPrbSEWzVpCb6LViZeImaVnYEXS65FJpQ9uLrJYr4ORcnEbtQK70QZMBmxHFK786k+KKofAA8bI+hqudlLjltUBW4sO1jQjtcvVL+5xkycvHsvzXInsIcHQFLasD8q0MeJQq2hCRp0PE+G3fTv8o4hFOV7i/CaYYtYSxklkPaZE0ER6V/Ec0l6/g4jCuIH+pk/0d8/sVEdfmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199021)(31686004)(2616005)(5660300002)(82960400001)(38100700002)(36756003)(2906002)(31696002)(316002)(26005)(7416002)(478600001)(4326008)(8676002)(53546011)(186003)(6506007)(8936002)(41300700001)(966005)(86362001)(6486002)(6666004)(6512007)(66556008)(66946007)(6916009)(66476007)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3hSM0ZyQXh0UmljeFB6c05LY0I4RmUxa1JiQmtjUXVKMkRjSC9BUDdNTGRX?=
 =?utf-8?B?QmdEcFVSRU0rQXZ1alkzRDhRa0FpanlmbUU2UmFKVnBMTERMdytwTHB3NWtM?=
 =?utf-8?B?ZWhHT1dhN21NaXNBZGVaaEZya2FqZzc3Uk1BbmJ0NkZSY1pPRWRva20zOGlP?=
 =?utf-8?B?eCt0OUdwQUVPSVAvUktCaGN2UDJmODVrV2U2VS9IaGpRZEhNOHJFR2Vha1Vz?=
 =?utf-8?B?Rng4NU15TFdBS0tJRmY5VWl1YVZ2Y3dMcTRmampiTEdDa0VnaHFyWTZQZ3NG?=
 =?utf-8?B?U2wvZ3REcXgzSk1EMDR2dWRFOEZNOEhyWStzWFZuMTFOM092dTNmd0ZhRXVm?=
 =?utf-8?B?dkJEU1BmSEFHQllPM3I2N0RPVHQ4VDVWb2l4TE5tci85THZSNDZwTDEwVDFN?=
 =?utf-8?B?dmJob3BPRnp0NGJkWUlsU3JwWjRyOWNaenoxMXVWbnBQZDdBdlpieUJ5dEZB?=
 =?utf-8?B?WEZlUWc4amhRMnQ4UDdJWVR1MituTlpOVUhOc1N5dmlkNUdiV2pwL1BTbFZq?=
 =?utf-8?B?bTd1akxLMXd3SVRYTmJYRW1YVzNJUSs3eUhWVkpySkswazJvU1NPUWF6Z1kv?=
 =?utf-8?B?aTZabWxGaklHSXdoa1lieUUzSVZwRjEzK0FQc3Z1L1VlVWllQ1d1R25ET0Rr?=
 =?utf-8?B?ODFwanpyQTRIY05PK2d1cTZvOUtBWXpCV3ArYTBLa0V1cEtabTVhazJEM0FM?=
 =?utf-8?B?eGxaOW84NmlOa0t6OTl3Z01zRnQxVWtWS0tQZjlxQjZhRjVrWUJCTExtSjhy?=
 =?utf-8?B?MFNscW9jSjk5cUtvOS9vTFNMQmo4UkUyS1pMOTZqUmR3U0pDMzFJM25oYlBS?=
 =?utf-8?B?NjBOam9CaDhCQjJIdlBsUXFaS0JHRkI5NUhQckNWNUdhbnN0bzJYVlhaYnNW?=
 =?utf-8?B?bzdqQ3dBUDcrb3NpRFc5Q2QwT3BmNDhSSmNOZHVXVmhmTnY0QnptSjVqaXhC?=
 =?utf-8?B?Wmx1TjZ1bGV1K2hGb0VOK1Y5MmE4V080Y3grMFNwY2NoVFVVZ3hML21pK28v?=
 =?utf-8?B?YlU0eXMxUWwrcENRbE5xY3ZmYW15WU9pb1FIamc5c3p1NEFqSW1NRkhzcUVz?=
 =?utf-8?B?eE02b3ZweHlEVnVZTjZGWkxnb0ViUkhubVh3RFdFaTg1Mm9Oa0Vxa3A1V3cz?=
 =?utf-8?B?dGUwMHJaU05uNHFjN2h2OW1LYTFIb0xuczUwdmJuNGloVkRKOVV6b1NYK0wy?=
 =?utf-8?B?TDVoWlBnL3dIUkpWL29ORWRJdUhqZ1hrYmRMWGZkSjlBbnA0L3B2NEJka2ZV?=
 =?utf-8?B?OVJkaWdhQ25PdmkrdGpLZGNITkk5b0N1UGVybi9YZ0xLTXBRMWxCb2RZME92?=
 =?utf-8?B?eklVUlFkUlJVcUxCVDF6ckpCZ2V5aWc0UGJUTk1jZmpPaUc2NGlWSmdGT21M?=
 =?utf-8?B?M1g3U3hhR211KzdNOHdMRUErVHRiMmtHL001TVpyclhXbWVRc0NVNmhwbXk5?=
 =?utf-8?B?WW9hbEJ6U2tIUXJUektmNThCaExyUkVIYUIzb3ZNdjVodUYzUGlYdFRNSzVz?=
 =?utf-8?B?YVpMZDBOQ0ZuTmR6RitXQ2F4OXhMcytPQ0ZYQjVLWXNZQzYzSjBOSUgrbjI4?=
 =?utf-8?B?RXBxdU9qNEZmOVFNRlpwdk1yMEZWaUNVN1BDZHpzazFxaGluSlFWdnFxaGhy?=
 =?utf-8?B?ZXRmYisvTVJDMFdBbkh3dXNDWGhpNEk4c3NuTFpZblFKdlhUVDFzNXBiaTBW?=
 =?utf-8?B?OE5sNzFObDJDREZxTTJ2cmVySDBMVytrZDFIMmxYY29tNFJqRkRLT2VYOFdS?=
 =?utf-8?B?cXNmbjRLSzgwUG50WUdTei9qbW1qckh5ajFkN29JeGpFY0RhMURwaTU5T0gv?=
 =?utf-8?B?WjZOdnh5eW9vYmRjeW5jTlBZSElnQlBMK1dMQUJ5QWJrTTRDUkkwc3FBSHh4?=
 =?utf-8?B?MS9DeFRiZEtzWVdTUFhEM3VyNVdHVVNVeXZzVTMwOG50THM3WjNtQlBob2Nq?=
 =?utf-8?B?WXA1ZkNoOC90TGNuRG1XelpkRUZWNFpXVUNtV0g0V1o2UUhKUXhsZEJwOVov?=
 =?utf-8?B?Y2FxVk1OM3pMZjFiWTkyd3BxYjBNdExDaGhLakVvd3hDRFNGV1NaWEszcjd2?=
 =?utf-8?B?K2U5R2gxWWFTN1VCNDhIWE1OMXpiR0hxc2M5c3F6TFphc1FFQkxSZEkzVm5N?=
 =?utf-8?B?NWVlVTZTbFBSemM1bEgySGV0MGJibnp6cVE4bTdUOEVPaWFuR2w5T2dqa0xo?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 764bd0cb-e375-4fc6-3300-08db92957824
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 13:44:46.8901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACfNn6zuOsGchhrkt6Wcb9s09rdUiqOv1igJzam+6AXr0ozHPJ6CfUyuMcCgz5T4ZIuE5K2kN1fK+U8Lk4tKrkLdsZm2jOrRD0FCw0tv/Vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5212
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
Date: Sat, 29 Jul 2023 20:46:22 +0800

> On 2023/7/28 22:14, Alexander Lobakin wrote:
>> From: Yunsheng Lin <linyunsheng@huawei.com>
>> Date: Fri, 28 Jul 2023 20:39:24 +0800
>>
>>> On 2023/7/27 22:43, Alexander Lobakin wrote:
>>>> Turned out page_pool_put{,_full}_page() can burn quite a bunch of cycles
>>>> even when on DMA-coherent platforms (like x86) with no active IOMMU or
>>>> swiotlb, just for the call ladder.
>>>> Indeed, it's
>>>>
>>>> page_pool_put_page()
>>>>   page_pool_put_defragged_page()                  <- external
>>>>     __page_pool_put_page()
>>>>       page_pool_dma_sync_for_device()             <- non-inline
>>>>         dma_sync_single_range_for_device()
>>>>           dma_sync_single_for_device()            <- external
>>>>             dma_direct_sync_single_for_device()
>>>>               dev_is_dma_coherent()               <- exit
>>>>
>>>> For the inline functions, no guarantees the compiler won't uninline them
>>>> (they're clearly not one-liners and sometimes compilers uninline even
>>>> 2 + 2). The first external call is necessary, but the rest 2+ are done
>>>> for nothing each time, plus a bunch of checks here and there.
>>>> Since Page Pool mappings are long-term and for one "device + addr" pair
>>>> dma_need_sync() will always return the same value (basically, whether it
>>>> belongs to an swiotlb pool), addresses can be tested once right after
>>>> they're obtained and the result can be reused until the page is unmapped.
>>>> Define the new PP DMA sync operation type, which will mean "do DMA syncs
>>>> for the device, but only when needed" and turn it on by default when the
>>>> driver asks to sync pages. When a page is mapped, check whether it needs
>>>> syncs and if so, replace that "sync when needed" back to "always do
>>>> syncs" globally for the whole pool (better safe than sorry). As long as
>>>> the pool has no pages requiring DMA syncs, this cuts off a good piece
>>>> of calls and checks. When at least one page required it, the pool
>>>> conservatively falls back to "always call sync functions", no per-page
>>>> verdicts. It's a fairly rare case anyway that only a few pages would
>>>> require syncing.
>>>> On my x86_64, this gives from 2% to 5% performance benefit with no
>>>> negative impact for cases when IOMMU is on and the shortcut can't be
>>>> used.
>>>>
>>>
>>> It seems other subsystem may have the similar problem as page_pool,
>>> is it possible to implement this kind of trick in the dma subsystem
>>> instead of every subsystem inventing their own trick?
>>
>> In the ladder I described above most of overhead comes from jumping
>> between Page Pool functions, not the generic DMA ones. Let's say I do
>> this shortcut in dma_sync_single_range_for_device(), that is too late
>> already to count on some good CPU saves.
> 
> We can force inline the page_pool_dma_sync_for_device() function if it
> is 'the good CPU saves' you mentioned above.
> 
>> Plus, DMA sync API operates with dma_addr_t, not struct page. IOW it's
>> not clear to me where to store this "we can shortcut" bit in that case.
> 
> It seems we only need one bit in 'struct device' to do the 'shortcut',
> and there seems to have avaliable bit at the end of 'struct device'?

dma_need_sync() can return different results for two different DMA
addresses within the same device.

> 
> Is it possible that we do something like this patch does in
> dma_sync_single_range_for_device()?
> 
> One thing to note is that there may be multi concurrent callers to
> dma_sync_single_range_for_device(), which seems to be different from
> atomic context for page_pool_dma_map(), so it may need some atomic
> operation for the state changing if we want to implement it in a 'generic'
> way.
> 
>>
>> >From "other subsystem" I remember only XDP sockets. There, they also
>> avoid calling their own non-inline functions in the first place, not the
>> generic DMA ones. So I'd say both cases (PP and XSk) can't be solved via
>> some "generic" solution.
> 
> If PP and XSk both have a similar trick, isn't it a more clear sight
> that it may be solved via some "generic" solution?

Both shortcut their own functions in the first place, so I don't know
what generic solution could be to optimize non-generic functions.

> 
> Is there any reason there is no a similar trick for sync for cpu in
> XSk as below code indicates?
> https://elixir.free-electrons.com/linux/v6.4-rc6/source/include/net/xsk_buff_pool.h#L152
> 
>>
>> Thanks,
>> Olek
>>
>> .
>>

Thanks,
Olek
