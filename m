Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733457FD7C0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjK2NSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbjK2NSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:18:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CC110DD;
        Wed, 29 Nov 2023 05:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701263897; x=1732799897;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FC2EGVlvStyw6H50iRJ5CQK1kwxkYx8xP4UxeTMhd0c=;
  b=oFJgQRs94+vcEGHW0/lpIWk4eeuKkJuNwB95UzIoiBsMQPYlDZ8Lq0+h
   R1PgcNN7ufEJLfq4YqMIGZZRCjXkqxobwV/6woIrQTIcu5GeNgu8U+c5a
   XTyw4GMHSyynr81CczKR/HmmYp73ueZAlWoRjRBSqdrnAhE2x7CNrWbuo
   YmT/Fz1w7Y8g4/mg5iJu+qmLlZIPjVOvlMPAqzvyYZ7edrlahro1fbT2x
   Wb9eq9NbP3HBzhyuUKgVWqf8kT0Wt5VC4BuwRXqYF5pQdmYz5MMxDjw54
   wxVewfnX/A/ToRlhf0EuHSOjYYlzjPqvoKI978XBkJmUMHwAbC0brLBkk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="479361643"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="479361643"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 05:18:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="762314264"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="762314264"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2023 05:18:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 05:18:15 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 29 Nov 2023 05:18:15 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 29 Nov 2023 05:18:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hER4Sg/Sb058oLMfcjT2qV1wc8PkZ+EIHrD9wT5x6qtqrEEJ/p5ntk2AAbdrliOCAxxJpExLQOW6escZFhiGiqHFxbNy+AS0klYOhxk2OFTxpDK5/1OpZEHRyxNvvEQF7NIxeyY/Vs7BXsxIqpCzlaHqjZH0OoofBhbIofXFRLy6s5157z8J1qLJpg1x0kMNwIHYb2GPAa0ykbi0+EElELGiXwrJYDZzSrdmx6zgLFcfJvEboQYOneqBrKvP4vG31nVgvxVDsD3S1SIKKjOdKtIljkCQporOX7O/HQXit0/ZX97fFbLiN6JFyatCtI6oTRytjuHcndsi3NRZQZAMHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ay9ZKEedrO4dKftZWtvmFRrjLsw+WN+sfJg8wBVVRY=;
 b=aEEr9Kg19gQTtahLI7VytSaald8/F0IoSHxt6OxUlAM/V5XV5AQRcegQPjQMfRQVVz1cRxYzLmg+606RSEV2nFYQ0N7WXE6U5tWpw4PC2QlXK1NPsL/GgVua7ybCg+HsT2F6rjmxS0rkuZyB4XHdoqh/qSOlxeQ+L/dXhYuaJLdfAq4cqFREuXbmE8w/KK2n9WlovBL4xRL9Dc5SxPE0De+un/V4W34rVyGXU0dNjVtysvpQ8Y6km97PMf0sZQe9qrxpLFg1VXZvDJdE774pizC0vRX4LtpNnxjwL8mcEZ23svrE8iu9IcuQYHJK0yiRSpIlngIARnDiPmSTZMcPnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CO1PR11MB4788.namprd11.prod.outlook.com (2603:10b6:303:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 13:18:10 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 13:18:10 +0000
Message-ID: <8c6d09be-78d0-436e-a5a6-b94fb094b0b3@intel.com>
Date:   Wed, 29 Nov 2023 14:17:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v5 03/14] page_pool: avoid
 calling no-op externals when possible
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>,
        Christoph Hellwig <hch@lst.de>
CC:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        <netdev@vger.kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        <intel-wired-lan@lists.osuosl.org>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
 <20231124154732.1623518-4-aleksander.lobakin@intel.com>
 <6bd14aa9-fa65-e4f6-579c-3a1064b2a382@huawei.com>
 <a1a0c27f-f367-40e7-9dc2-9421b4b6379a@intel.com>
 <534e7752-38a9-3e7e-cb04-65789712fb66@huawei.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <534e7752-38a9-3e7e-cb04-65789712fb66@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::13) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CO1PR11MB4788:EE_
X-MS-Office365-Filtering-Correlation-Id: faa2c98c-0599-47c2-095b-08dbf0dda1c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NHEk40f0YsriUwvrsX56ckJZYGod+/R+629oaZh4F9pi7tAFOw+HA37nu7NNKfS+2w6UYPAMqZlM//ZS9/wHs+qSpCcECnMtagUl26lyZHTqGAYkCindVy4p83BS8RCm8tWX1E/gtag7T1B9PnJ1xFKq/Bs49MUmtSBrjo9rPb5wFNn4Ewy+0SCYpUrqUfg2E9DVfS1OK4awMgtfxsa4vX1qtGMkP6iTLlCYrHaWZ6okMOrEKDCEkbYhGhqNfKoBhqbP1xrrRmn3xpW4RNSnpg4RKc9G9UCW6wvlT1wKAoZ9hxvtBt0QhhWo5NvN+VfyDcbL5WFvr8ZUhtNESw1fKxtYV2HnPzqo1dIYQ44F4vdzwkhKyPCJXDDY2WXXJN8UZgrtZGCRHmbEX5cTgZ7rl4NvVwacWv4FrPLn6zLF18HqBVfH8P4J6ayJzwo3uwEM+Q86/3vJy7yLLI/xvH/kFJSOtdaFkBVMn2yYCgZieqZKnjWdQ2lRytO5B1aB7jb45pRfJ7R9p3F/WXwnoLLEGDY2KXbAtuTWkHTH+3i1QMwdhTn3tlA0YhkVoT9GYYpq4QaUZm9u00SmDY59V/ZRgjzUjOhSXjAc97MF7qHXSUIIFzec3W6XHNOyZsJt1fGzf0wXRU8NZ/ip1vJYD+LUDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(366004)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(53546011)(6506007)(6666004)(41300700001)(31696002)(38100700002)(8676002)(4326008)(8936002)(6512007)(36756003)(966005)(478600001)(110136005)(6486002)(2906002)(2616005)(7416002)(86362001)(31686004)(66946007)(316002)(5660300002)(54906003)(66476007)(66556008)(26005)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW95Rnc5WEIzUGVPTkZibmErWmN5Z0dqVDVnUENCMENqS0hmL2xRTTQ5bFd2?=
 =?utf-8?B?NmhrSW1TRTVlVnZzVVhKcDdVMFhXaUZ5aXBha0FPWmtUUE1KMnlmR2NpZlg0?=
 =?utf-8?B?S3R3YnE2UlM4WXlOdklWOXVSY0NnYXZZWXdsaUtwRDB4M0swY20zc0o5Y2pT?=
 =?utf-8?B?dVdPV0NBKzQ0a1hWend6WWFoaUg0R3d3QmQwMkNKeXVPeU8yVVlFa3NBZFJL?=
 =?utf-8?B?RXhCaXBKY2svQkx3TDVncU03bmlHaEFJTm9BdFQrNUpsa1NMWHhneEsyZjdZ?=
 =?utf-8?B?Z3NQanlQSjRUWHdvclhMeG84RGIzU28yRnREaHVodzNzamh3RnA2ZlR5YW5L?=
 =?utf-8?B?bU0xaUJJKzFTd1JBbzNIN2l5N0pQTkRqaXVzR0xlOE1CM2QzVmpsZEZ3N253?=
 =?utf-8?B?V21ucDExTUxXa0FYaWQwMWw2bGV1dWtlckt1WkFwajhYdWVybGFNaGxUL20x?=
 =?utf-8?B?Ums0eHpsdENleHB3bEg1aXRwQy9Yczk3eklNVzd5K1R2eDJuZ3BBWUNRQXlp?=
 =?utf-8?B?ZkxWb3JBdVA0UTdpV2gxVkV3WVozeGZyam5ZTVFpcHBxVktLL0tHdXhtdC8y?=
 =?utf-8?B?UjhaT0pGcFlOeDFFNnoxRVdjUVkzUHpJWVdZNURza05CN0prc3NCcHdrdmZU?=
 =?utf-8?B?VnMwVHY1WXBiSmZJWWhNeHRxc2VNN3QwVkp1ZU5QVFdEbk1Mc0RyalJYMnVK?=
 =?utf-8?B?WkxEbUQ2MWdDT3psZzBFS3g3Q2xNQ0NkbXBOWEMybVpDVjAxQW1NMjlqZjNs?=
 =?utf-8?B?ZmF4eTFLclpkdS9jMXVqSnZHWjdsVVI2Z0gzM3RkRFdzTE1NbEhONXpScFI3?=
 =?utf-8?B?QW5iN1I4dWc3dk8rbm9aRGp0emZ3Vm5DUXlMbnBkNG1jaEZOU294eklMdHNO?=
 =?utf-8?B?eWttUE9NNzhxRGR3WG1jUTY3QmVza3ZENUFmUXVKZmkxbXJodE9Da01TMi9M?=
 =?utf-8?B?WTJVOGo5Q3JQUFVtZjZpek80d2NVQXUvRkVsVE0wWWRaTGdIS2IyN2Mzdisv?=
 =?utf-8?B?U2ZpQUsycm8rNVlDb1hYZDUzQVhzT21YeCs5R1NiSFBMMmZqV2JmU0hsRzdH?=
 =?utf-8?B?by81emJpTnVZMGl0QmU2LzBVQ1AzYkxyVzhrTFRjbjRxa25ZSFpnbzd6R2hK?=
 =?utf-8?B?emhFWGdjdy90Y0RlR1pHREh2bHR2ZU9zV2xMenE4bmJzU0tGS2hJem9hMGIv?=
 =?utf-8?B?SjFLZEZaeXZ2dDdERDROYWFMaUsvZFRyWmJJbVRMVVRPVytzNEl1M0w0NXlT?=
 =?utf-8?B?SElMYmw4MmR1VG1QTnR2aHdsQU1SNU4xNTErakE4RS9nVWllMmhKOFJ4Z21V?=
 =?utf-8?B?YmNxYVFpeGJYRWhDQVBCTUgwOHJUV3RiYStYbmZCQmE3ZmVqb3NVVEpZdW8r?=
 =?utf-8?B?WmtqaWpjVmpaZ1MwMk4ybjlDREZpWkFiY2MrMS9rZGVtMEp6N2g2SXg0UTha?=
 =?utf-8?B?LytNMm1oSVV3dmE0NGkwZWg2TTBXa2lTOEZVUnRvZy9lM3lCbjFvdWovcUtj?=
 =?utf-8?B?Tnp2OC9SeGxMVXVUMjkvYlh0cEhUajdIRklmREp4VVc2K1EyMDluOVJUTFFN?=
 =?utf-8?B?UGhMckRYN3pEWkJSQ0tRd2Z0cmFUaHhHUjBJaWtHcUxYNllJOVd2UG53SlI0?=
 =?utf-8?B?blVQazJ3b1d4aUMyVGtIK1pyRXlOc2dxL2xNQ3kxd0o5cGlUUjdwa3JsN2k4?=
 =?utf-8?B?bHhtMzlFTHRzNFR5MCtHQ2R5TUxsbzRjWVQrWjl6ZGYwOEFUSmFpdXZNQnF0?=
 =?utf-8?B?YVIvT2NvODA5Zlc2bmlDQlBYeEx6QVQxVVFsd3BEMW5JWVJTME9FODZqTzM1?=
 =?utf-8?B?Y042ZEtRSXZldWZuTk44UkFNRjJYWSthWERNWWEyQmRiWDhqMjE4empxRU9w?=
 =?utf-8?B?M0NUUmJ4QWRWUUt2MlNtUzlUZzdNSGhtMnk4WUMzNzE2TzVnWTFZZ3hZK1Zt?=
 =?utf-8?B?TVlHN0F5ZE9YNCsvRmZBbUg5WENDRVJhNFNwRzVSaFhUclBLREE0eXpqS05v?=
 =?utf-8?B?Y3FpVVI4aG5McHExSFdGYW12b21BSEZEbFhvcE1FT0w2aVBqWmJ2T2ZXdEZ5?=
 =?utf-8?B?ZUNkbzAzN052clFKaTVtR1MzZ3laOENMTjNyazlXZGVpZFFCT1NrSUxTZGhK?=
 =?utf-8?B?YnlzQTNFUkhFWlJIL3FaWnZMWHNmMk40Vk1JV1pCUUtjcXpSTFQ1VGhPSWVq?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: faa2c98c-0599-47c2-095b-08dbf0dda1c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 13:18:09.8217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FO2qM7ZXj7PU6SVeOWMXiYXTxZWkoGikLOhWJjon5J9mGCFhki4JuVxzSK/c8AJdXgHazFNASSomzMFrhrjnODrOpCcFTLmmYrDgdSP6xZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4788
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Wed, 29 Nov 2023 11:17:50 +0800

> On 2023/11/27 22:32, Alexander Lobakin wrote:
>>
>> Chris, any thoughts on a global flag for skipping DMA syncs ladder?
> 
> It seems there was one already in the past:
> 
> https://lore.kernel.org/netdev/7c55a4d7-b4aa-25d4-1917-f6f355bd722e@arm.com/T/

It addresses a different problem, meaningless indirect calls, while this
one addresses meaningless direct calls :>
When the above gets merged, we could combine these two into one global,
but Eric wasn't active with his patch and I remember there were some
problems, so I wouldn't count on that it will arrive soon.

> 
>>
>>>
>>>
> 
>>>> +static inline bool page_pool_set_dma_addr(const struct page_pool *pool,
>>>> +					  struct page *page,
>>>> +					  dma_addr_t addr)
>>>>  {
>>>> +	unsigned long val = addr;
>>>> +
>>>> +	if (unlikely(!addr)) {
>>>> +		page->dma_addr = 0;
>>>> +		return true;
>>>> +	}
>>>
>>> The above seems unrelated change?
>>
>> Related. We use page_put_set_dma_addr() to clear ::dma_addr as well
>> (grep for it in page_pool.c). In this case, we don't want
>> dma_need_sync() to be called as we explicitly pass zero. This check
>> zeroes the field and exits as quickly as possible.
> 
> The question seems to be about if we need to ensure the LSB of
> page->dma_addr is not set when page_pool releases a page back to page
> allocator?

But why do we need to call dma_need_sync(0) when freeing a page wasting
CPU cycles on relatively hot path?

> 
>> In case with the call mentioned above, zero is a compile-time constant
>> there, so that this little branch will be inlined with the rest dropped.

Thanks,
Olek
