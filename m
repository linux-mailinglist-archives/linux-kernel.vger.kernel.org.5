Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034767FA30C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjK0OiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbjK0OiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:38:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77AEE6;
        Mon, 27 Nov 2023 06:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701095895; x=1732631895;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fm4dWuQER+Ufha5siUVxpKAanEAMKbZ40hQaeuvltA8=;
  b=OGQDMI8cihIASeoyyR3kd4GPKV722tx4ZD4fa0S7om36XIXW5lez0JVY
   UCdXDkeHau0b88UdSuNikI/0go/FA1V46F/EUfbf0YcSoyoZzJavN00tk
   cFBNH24kv2mSmzH7t8Cj34ccCnRpMQc8RGpKrHjwHqNlrkFlafwyFVBSF
   bx63GD6A9F17M3X8hzmysnGCZ4yzJuE4MEs34hll/3aGzVFPqwrEvNuFV
   k5v9nJjDwAsqXvQkIBiBfCPpdjmmmjhcpR77rGaSABIyAQQ0RTM2WexRD
   X8eeFMA1M1gO2Zs52xT2MskLsfg+SRprV7YQ179dvaeME53AzFHlw58s0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="395535177"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="395535177"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 06:33:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="838726679"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="838726679"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 06:32:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 06:32:59 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 06:32:59 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 06:32:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTFUf21IXlIslORRu97j5njlib111qlWTIGYsA9Pku+v76CGbqNGhk+zBnGO0ZJfPRP4kU16iTzsvlksxu7j65qJ7nblCRorC7u91cAHWm2nihtQJh+E9QrEhnMTOf/fmPNMoVwC3rjgJ53nI3Vn6LPN0hXheUKszLf0LXCyUJ4rEXebjpMYm+ddJ6ocoNDGeM5z5WNXXgcm+0GrV8HLlzbZuWwKU2MPliSLsfYYDo6kjPr3hVWSTXSvtj+AZHPAt53eXgeKOZfsPqmnOReY1t7Y450WAzNTMoDJeZ/P4/pcr5G1EBrIM9xzUxlQCV5u2lkEzRsws08AL3+98tnRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wK1Pcw3H8q76I8U3aN1plnOZJ42UpfJqDQpZ5nuO7e0=;
 b=V43PDfREJfwaHi8kuTb/cwFFv5Q+LPjkNQBk5mF1TKxuHVHKSFj14S8fES2ZI0xVHXJlF4IBzx2qSltjDP0ZuJvZ7+QlKBpF0iK3LQCR20W70B+QhTWIdOta7ISM+Eb23ZwmR/tKOtx1vmKugi0OxKqLJJdNW/go+CwsykzK3gVit/my1iHtzDI2zC5GtdfRBR7SnX6huQUxCI2l24l/NRsSqaYYtqfzBTfpfy/51BMP121k3TGL95gYP1aYCmy0KZY3XbHZrZiDAu2+NKuFyDaTOU17eOGiv+yKNF15kkTydfKvgHiAZeGLmXGYcQGXcFQUtGVLhaDJbbWFWRa+VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CYXPR11MB8689.namprd11.prod.outlook.com (2603:10b6:930:d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Mon, 27 Nov
 2023 14:32:49 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 14:32:49 +0000
Message-ID: <a1a0c27f-f367-40e7-9dc2-9421b4b6379a@intel.com>
Date:   Mon, 27 Nov 2023 15:32:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 03/14] page_pool: avoid calling no-op
 externals when possible
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>,
        Christoph Hellwig <hch@lst.de>
CC:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
 <20231124154732.1623518-4-aleksander.lobakin@intel.com>
 <6bd14aa9-fa65-e4f6-579c-3a1064b2a382@huawei.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <6bd14aa9-fa65-e4f6-579c-3a1064b2a382@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::9) To BYAPR11MB3624.namprd11.prod.outlook.com
 (2603:10b6:a03:b1::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CYXPR11MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd46896-442c-421c-20c6-08dbef55ba50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDJ0bTRYyzO8g5SfdQhQEwOPSWGUS5hnYFH6buHkoOjX5Zkk5M87REyb6BB/wb9E+w0DYg7ATynSm2wDwZrK5VzYswtd0ms0avs5x+kwVLXHpZZ7wVUbvTNhWYryhzMog03aZHGWnoKeyiKV+FPz2T8AeK1Btv5xGJ4b4/MmgmsyfKvCIg/0fJ4at3YtOGCgSMdVkXK05mv0G7gdKy6eMlFXBqSP/zOWA7EfSeF2QOhN4gVhjGOxE3ym1uoK+Mdg83yrgJZKG/ZkDek+4NUKhnzWxJCnML7+9FGMOxg4mr/BawatYE6DOYIzkDbyNshV6joBC0XkTgIrmuAxAfgScDVlnm+COwa/XE4bS2hdMI0TDLJhQeAwNo2tmcB+iRD2KuGJ88yypa8zXyyFTfsQlDTzupgmNIYgPpXHuQWCE3JUSbytuO2cmuQVIpKPWP2A3YggeqIIaR3Skla1nelRVxR9xBc+7qJv7cRKMOcGCxI9N3UGY8YT/bY0Ip1CG4ml/lSamPXDZVeOB1Krhk3PhrTuLKPYT/vSuc4oPDv2KiB/zkkxAINAS8mVochF3x7KIr7unaqdSoo33U8QAD9imF6/2fzB81N13f3fr9NrD+3GgP5JeUGxjSn7Yq3QcFv+qBlyALuaHkQsr/g667U4lX0B4DN4c34J5j65inVd2O3NviJjF8Ng5RmqxdS4EYrh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(376002)(396003)(230273577357003)(230173577357003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6512007)(6506007)(53546011)(2616005)(6486002)(478600001)(6666004)(83380400001)(7416002)(2906002)(5660300002)(41300700001)(66946007)(110136005)(54906003)(4326008)(66476007)(316002)(8936002)(8676002)(66556008)(38100700002)(82960400001)(86362001)(31696002)(36756003)(31686004)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rlh4RXJZaVI2OTZLcklCbkZvOXplVGtmYWoyVXlTRVU4SDVWekI0Zm9zZ0ha?=
 =?utf-8?B?dmo3YTRaYUVWOCt3OExSOTNLdUZNN2hHVHhzQ0hSLzhLd2I3NWRwZDNuM042?=
 =?utf-8?B?R05OOHIybG9DTnVDZzhFU3c5cS90R0ZRRktuS3FGNDhoQVNaV3I1Y09iVUJJ?=
 =?utf-8?B?ZnBlSDc5MjZuZ09rOGdhaWU1V1BBT1IreUpTbStVdTkvdEhWWkpmb1ZlTDRo?=
 =?utf-8?B?Q3J5bWY5c0d6Z1BZL3NDT1oyQ29hOWlmbjlYV3krL2Ezam9WOTlwcUhVbVJJ?=
 =?utf-8?B?dC9pU2ZqcmlTUzVFTzl6SE41Vkw5MjFoZElNZGZIUGl4MWdwcjBEY1lTVWFR?=
 =?utf-8?B?QlFON3M0SWRFVHJCeWZJY25SYVQ0dUtDQ21Kclo5VlZzRERtbVkwMGg1ZEdR?=
 =?utf-8?B?OElDQlc1ZEk5aHJyYSt1S2ZPU081YUR4TVJNZjkxL0hsTm5SeWF3cFpKWFds?=
 =?utf-8?B?Q2lkMUpva3poR21SdE1DblYydEJodllGMThFcm5IUGRxdzFPWFR1bnFEdVhZ?=
 =?utf-8?B?Qm9vQkh5K1BkTUxrQ2lLeHJ2T2xzL05IcVVCRDRrOGxDRVNZNVNIc2NXWnF6?=
 =?utf-8?B?MkJUTU0xdVkxakRpY0dOU1ptdzZpK3FjRU4xZVhpMlNDajJMSHRLZmt2aEgy?=
 =?utf-8?B?RFNZd0xZYXBaMEdTdnpibW9heWVZYk9lVUtXRWdxZHgzcU1xUFVQQXdSeGhG?=
 =?utf-8?B?eFo0QUo2SHhjakNXQ2tPbFo2OGx1OVlvZXprSTJTWUJjcWMvV0hvKzBTV29G?=
 =?utf-8?B?dCtuSWk5VlpPV25wRzhPYytzNG5wZ3BNTkRwVDhJRkw2N1hmaFg5YWtsNm1z?=
 =?utf-8?B?d1JpeFl3TlBzaFJLeDE1MUlmampsTGtyVVJMV0N3ZkhsTXhueEZqcTYzNEVX?=
 =?utf-8?B?b3NMZC9iaTVtbEZQZ0tXR3lja0tnV3N3TjFBMEFDeWo3dTR5K1hzQy9GV2NZ?=
 =?utf-8?B?K014T1I0RWkrUld4WWtrc2c3WVB0dmhiS1dPZk5yY3BBaEcyOGtxTW9jS3hn?=
 =?utf-8?B?SEt1eE5XUmRnQWF2Sks1MU4rYnVBaFV1SWRvU1JyN1Z3K1p6U3pWdTdWSC96?=
 =?utf-8?B?ak5pQ1kxcG1vZzZnZ1M5aGhtKzd0VHV3UGVBRnVLeHVqWGErTFhmQUY0Ui85?=
 =?utf-8?B?aHVRNWMxc005Rm1kMU5nTWRvMWNlamUzMUovaysvNDBBZ3RybTZ5ZENmUnR6?=
 =?utf-8?B?UU9URkNXOW00S1Rja1RQZFEyZFZuNC9hWi9SOUd2SHpCY2tib0hvaDBraTZM?=
 =?utf-8?B?SFk0OExoV3lEWUNzUDUxNitFcDFneC9EOFRIQzhjaDlkakUxNkRoT3RqVktm?=
 =?utf-8?B?Sm5SdFU2enp5dStJc09LM1o4NUFjVGFvQ1hETHcvZ3RzNlpobE9ZTmprRVhu?=
 =?utf-8?B?UFdiNjlIbDNIRHR6UldHSzBKQkRaczZJdFpXVU9ITllzMlo5d21welEyQlJk?=
 =?utf-8?B?TTRTajBKbE1LNGQrYmxlMU1qeHVUYmp5ZTFONEJkRzN5SFpRN0FYdi82eG1t?=
 =?utf-8?B?T2JqMkR2NUNyNEw0azgwcVQvSDdRYmx6ck5LbE5VODk2aVBiQjZOL3JiSUtX?=
 =?utf-8?B?Ym5uUDAwMkNZY3ZZSjdKbEtQOUtIU2MrM0dFUWxXdUlDZXBERms2ZWZmWUpF?=
 =?utf-8?B?T1lENG5ieWRYNHdhS0pCbnc0aXFLcjVCQmdyOHQzT1ZuS1VoMnV3TyswVWxj?=
 =?utf-8?B?OEFsRWYwQ1NsVmtSQ2hlV3R0enJFOGk1RVJMWVQ0SlRvYnNVRDhFVHdkd2VM?=
 =?utf-8?B?SXhlRU1QU0RxUW8xQzV5aFcxdDlnSng3eGpDSy8rZ3dQazJ0by9NbGYyamR2?=
 =?utf-8?B?Vk9OOWxpODBEODV5NVhCQWJKL1BDdy83L25NemhZUHRqUG5jaE1XZ0Uzb0F1?=
 =?utf-8?B?QzAySGUrR0dhdXJqUmZ5Z3pNMDJjVEVLbmR6bFRWMzZUVTg4N3pFUU4xdURK?=
 =?utf-8?B?ajFwd0VNOUc0ZWk2eUNJc3JsQ2c2bFN3WTZiU0pCMloxN3hRaXV5ejVqaGpi?=
 =?utf-8?B?bEcwa3JwQUQ4UHZ2dzlmeWZrM0w5WDV5YUNsV3BhMFYxdlhSTjkvSTVrbUYy?=
 =?utf-8?B?S001dXpQVGpaSUpia3FJZUd4MmFlQXRPLzVwRU9oRUlWcVc4WmRlMDhZY1Fw?=
 =?utf-8?B?QlZGTDRWTnpIMzNSSFhtaDdRZjdORnlRcmlDTnVRbzQ3T2hWdFNjbTQxNENV?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd46896-442c-421c-20c6-08dbef55ba50
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3624.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 14:32:49.4089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3ptlIcmvkU82EP9sDT5h43ktPsi6weXQhXTrsdDPm+STi5Ttzi93W1l2t5//K2YUkRpQZj0V9HGaUb76moPyoX//YoNBGfEzYAXwPDLpiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8689
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Sat, 25 Nov 2023 21:04:28 +0800

> On 2023/11/24 23:47, Alexander Lobakin wrote:
>> Turned out page_pool_put{,_full}_page() can burn quite a bunch of cycles
>> even on DMA-coherent platforms (like x86) with no active IOMMU or
>> swiotlb, just for the call ladder.
>> Indeed, it's
>>
>> page_pool_put_page()
>>   page_pool_put_defragged_page()                  <- external
>>     __page_pool_put_page()
>>       page_pool_dma_sync_for_device()             <- non-inline
>>         dma_sync_single_range_for_device()
>>           dma_sync_single_for_device()            <- external
>>             dma_direct_sync_single_for_device()
>>               dev_is_dma_coherent()               <- exit
>>
>> For the inline functions, no guarantees the compiler won't uninline them
>> (they're clearly not one-liners and sometimes the compilers manage to
>> uninline 2 + 2). The first external call is necessary, but the rest 2+
>> are done for nothing each time, plus a bunch of checks here and there.
>> Since Page Pool mappings are long-term and for one "device + addr" pair
>> dma_need_sync() will always return the same value (basically, whether it
>> belongs to an swiotlb pool), addresses can be tested once right after
>> they're obtained and the result can be reused until the page is
>> unmapped.
>> Do this test after a successful DMA mapping and reuse the lowest bit of
>> page::dma_addr to store the result, since Page Pool addresses are always
>> page-aligned and the lowest bits are unused.
>> page_pool_{g,s}et_dma_addr() will then take this bit into account and
>> exclude it from the actual address. Call page_pool_dma_sync_for_device()
>> only if the bit is set, shaving off several function calls back and
>> forth. If pool::dma_sync is not set, i.e. the driver didn't ask to
>> perform syncs, don't do this test and never touch the lowest bit.
>> On my x86_64, this gives from 2% to 5% performance benefit with no
>> negative impact for cases when IOMMU is on and the shortcut can't be
>> used.
>>
>> Suggested-by: Yunsheng Lin <linyunsheng@huawei.com> # per-page flag
> 
> Sorry for not remembering the suggestion:(

In the previous versions of this change I used a global flag per whole
page_pool, just like XSk does for the whole XSk buff pool, then you
proposed to use the lowest bit of ::dma_addr and store it per page, so
that it would be more granular/precise. I tested it and it doesn't
perform worse than global, but in some cases may be beneficial.

> 
> If most of cases is that some pages need syncing and some page does not
> need syncing for the same device, then perhaps per-page flag is more
> beneficial, if not, maybe per-device flag is enough too?

Per-device is not.
You never know when dma_alloc_* or dma_map_* will return an address
needing syncs. I realize that in most cases it will always be the same,
but since there is a possibility of more precise optimization, why not
use it :>

> 
> What i wonder is that is there any reason this kind trick isn't done
> in the dma layer instead of each subsystem or driver using dma api
> duplicating this kind of trick?
> 
> At least xsk_buff seems to using the similar trick?
> 
> You may have explained that, it has been a litte long between v4 and v5,
> so I may have forgotten about that.

Yeah, as I wrote previously, there's currently no easy way to combine
these two optimizations.

I can't even use this patch in the XSk layer, since it doesn't operate
with struct page, rather xsk_buff etc., which may not have a direct
pointer to struct page. And in case of DMA sync functions, there are no
pointers to xsk_buff passed there, only xsk_buff_pool and dma_addr_t,
with no direct association with a particular page.
Also note that xsk_buff_pool still needs to be converted to use dma_buf
API. This should be done soon and will involve quite big changes
regarding DMA, it makes no sense to touch anything there prior to this.

Field in the struct device may work out, but in some cases such global
gate might disable this optimization where it could be still enabled for
page_pool or xsk_buff_pool.

Chris, any thoughts on a global flag for skipping DMA syncs ladder?

> 
> 
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> ---
>>  include/net/page_pool/helpers.h | 60 +++++++++++++++++++++++++++++----
>>  net/core/page_pool.c            | 10 +++---
>>  2 files changed, 58 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
>> index 4ebd544ae977..28bec368b8e9 100644
>> --- a/include/net/page_pool/helpers.h
>> +++ b/include/net/page_pool/helpers.h
>> @@ -52,6 +52,8 @@
>>  #ifndef _NET_PAGE_POOL_HELPERS_H
>>  #define _NET_PAGE_POOL_HELPERS_H
>>  
>> +#include <linux/dma-mapping.h>
>> +
>>  #include <net/page_pool/types.h>
>>  
>>  #ifdef CONFIG_PAGE_POOL_STATS
>> @@ -354,6 +356,11 @@ static inline void page_pool_free_va(struct page_pool *pool, void *va,
>>  	page_pool_put_page(pool, virt_to_head_page(va), -1, allow_direct);
>>  }
>>  
>> +/* Occupies page::dma_addr[0:0] and indicates whether the mapping needs to be
>> + * synchronized (either for device, for CPU, or both).
>> + */
>> +#define PAGE_POOL_DMA_ADDR_NEED_SYNC		BIT(0)
> 
> It seems we have less dma space from 32 bit arch with 64 bit dma address:(
> But from my last searching in google, it seems we still have enough bit for
> that:
> 
> arm: Large Physical Address Extension or LPAE, 40 bits of phys addr.
> arc: Physical Address Extension or PAE, 40 bits of phys addr.
> mips: eXtended Physical Addressing or PXA, 40 bits of phys addr.
> powerpc: does not seems to have a name for the feature, and have 36
>          bits of phys addr.
> riscv: large physical address, 34 bits of phys addr.
> x86: Physical Address Extension or PAE, 36 bits of phys addr.

Yeah, 1 bit less, but from I've read, in most cases it will still work.
For 4 Kb pages, shift is 12, so that we're able to address 44 bits.
Eating one bit for DMA sync flag shrinks it to 43 -> still enough for
the cases you described above. Also note that some of these arches may
have bigger pages, where the shift is higher -> even more available bits.

> 
>> +
>>  /**
>>   * page_pool_get_dma_addr() - Retrieve the stored DMA address.
>>   * @page:	page allocated from a page pool
>> @@ -363,27 +370,66 @@ static inline void page_pool_free_va(struct page_pool *pool, void *va,
>>   */
>>  static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
>>  {
>> -	dma_addr_t ret = page->dma_addr;
>> +	dma_addr_t ret = page->dma_addr & ~PAGE_POOL_DMA_ADDR_NEED_SYNC;
>>  
>>  	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
>> -		ret <<= PAGE_SHIFT;
>> +		ret <<= PAGE_SHIFT - 1;
>>  
>>  	return ret;
>>  }
>>  
>> -static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
>> +/**
>> + * page_pool_set_dma_addr - save the obtained DMA address for @page
>> + * @pool: &page_pool this page belongs to and was mapped by
>> + * @page: page to save the address for
>> + * @addr: DMA address to save
>> + *
>> + * If the pool was created with the DMA synchronization enabled, it will test
>> + * whether the address needs to be synced and store the result as well to
>> + * conserve CPU cycles.
>> + *
>> + * Return: false if the address doesn't fit into the corresponding field and
>> + * thus can't be stored, true on success.
>> + */
>> +static inline bool page_pool_set_dma_addr(const struct page_pool *pool,
>> +					  struct page *page,
>> +					  dma_addr_t addr)
>>  {
>> +	unsigned long val = addr;
>> +
>> +	if (unlikely(!addr)) {
>> +		page->dma_addr = 0;
>> +		return true;
>> +	}
> 
> The above seems unrelated change?

Related. We use page_put_set_dma_addr() to clear ::dma_addr as well
(grep for it in page_pool.c). In this case, we don't want
dma_need_sync() to be called as we explicitly pass zero. This check
zeroes the field and exits as quickly as possible.
In case with the call mentioned above, zero is a compile-time constant
there, so that this little branch will be inlined with the rest dropped.

> 
>> +
>>  	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
>> -		page->dma_addr = addr >> PAGE_SHIFT;
>> +		val = addr >> (PAGE_SHIFT - 1);
>>  
>>  		/* We assume page alignment to shave off bottom bits,
>>  		 * if this "compression" doesn't work we need to drop.
>>  		 */
>> -		return addr != (dma_addr_t)page->dma_addr << PAGE_SHIFT;
>> +		if (addr != (dma_addr_t)val << (PAGE_SHIFT - 1))
>> +			return false;
>>  	}
>>  
>> -	page->dma_addr = addr;
>> -	return false;
>> +	if (pool->dma_sync && dma_need_sync(pool->p.dev, addr))
>> +		val |= PAGE_POOL_DMA_ADDR_NEED_SYNC;
>> +
>> +	page->dma_addr = val;
>> +
>> +	return true;
>> +}
>> +
> 

Thanks,
Olek
