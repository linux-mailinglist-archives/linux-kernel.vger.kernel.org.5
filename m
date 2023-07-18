Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C945757194
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 04:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjGRCH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 22:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGRCH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 22:07:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8D410C2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 19:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689646044; x=1721182044;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nVWyIY6W2KuTxAo9HyV2qjMzdn+J8Ui8UQBgmdI/EIQ=;
  b=Nn9gk2UX5LxUwMax3ueUCiWICljRZJR3s2FaxXSypaFFShXnrVXwFLGs
   81/B5Wh2e21lnHO/ynwNKQvSnRndGlHuuxBTllOSrkuBxGmcTuZOqLees
   uqHCDpjLvLYTy63hqwedSP4/ID+hhasw441UIumBv+HX13180fJLHrpKG
   a3PDRb8hK8MWhY1rC1r0ntx8WlSoh7ykiIL1DOhmaPCvYmMh+a0cmLiwB
   o/+pREWKhgFRSHEty/pbDZPawL5yqzZxM/D4x/A/SdTb+l+3r2ttwHgst
   ff0TYqqTzG1bTePkVjmQLIRKcxWTZZMOFhdHTsSrG61S+B+QEajA0El3r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="432263465"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="432263465"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 19:07:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="723413035"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="723413035"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 17 Jul 2023 19:07:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 19:06:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 19:06:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 19:06:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjZYn8tgmj581yHcyM/tRtDdLweaXkFZH46D6BEP//JeXJQ6TuMJgZotfX6SOF1T2vLrVc+bSWKtrbmdWg8/FoUwj2YGcv9d8zeTCFJLYjO2vJBNagatoVqJrd31/IE9CnEo5GfWbsM8uFD00okYUCkIzYdAZFKXv2EssLUxtkc6hEUIsDyveayg2hL4wEUJ4qkZVW37rhrGSj6aV6d96MWzuFPp5iEPkZg03HkFGQl/X3tTXhv7nCjuRpi7B+bYIgl7LHTdnEEQNCDe0Y+HXx8alatrGEGBLRzajGmWrVus+xOM662QHracoib92wwbeJ/KmH4zIA6MXoPUxZXYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syV4YAGkxzPgBIIwkbweeSGM16j38HehBUEFlV0y/uY=;
 b=JBRpUB51hPgN72DUIUe1ff8/fX7pEgG1J7XND8w53vkBu2Iy137BB5BqfnaT6LLh7JKcWLlURAHYMinMSXWNXxR9tvS1BVtIb4UzZz5UZmQF6Kqfv1x0SBvWabPvWf3u0ySxHsSnNAZMsBS9a21/vodPMWBvueyk9DsS4SjJ+BFsBYc0E3UtMGL1CJ6EwWY55sK+6Sf/fY2wj9VbCxygnNbnBTeVYsiBbwb6LDzDEkUNEg9X/BAcRxu9x6DiYuQnTaLDzBsrlrThiFYgjtx+XUZJi65RvK9QiqGIIdOk8IkUmCFku8wrwICBnWXqeJuysjaMunf4LxxrSr+PHNwj8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CO1PR11MB5044.namprd11.prod.outlook.com (2603:10b6:303:92::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 02:06:49 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e%5]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 02:06:49 +0000
Message-ID: <045fe36e-ed5b-2b02-a40d-c185796464b2@intel.com>
Date:   Tue, 18 Jul 2023 10:06:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 3/3] mm: mlock: update mlock_pte_range to handle
 large folio
Content-Language: en-US
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     Yu Zhao <yuzhao@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <david@redhat.com>, <ryan.roberts@arm.com>, <shy828301@gmail.com>
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <20230712060144.3006358-4-fengwei.yin@intel.com>
 <CAOUHufYef--8MxFettL6fOGjVx2vyZHZQU6EEaTCoW0XBvuC8Q@mail.gmail.com>
 <CAOUHufZ6=9P_=CAOQyw0xw-3q707q-1FVV09dBNDC-hpcpj2Pg@mail.gmail.com>
 <40cbc39e-5179-c2f4-3cea-0a98395aaff1@intel.com>
 <CAOUHufZHyEvU-c2O6B6stM_QVMxc22zV4Szn52myYqjdZvptUA@mail.gmail.com>
 <d93030e9-938e-f394-8067-a7307f6acd30@intel.com>
In-Reply-To: <d93030e9-938e-f394-8067-a7307f6acd30@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0186.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::14) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CO1PR11MB5044:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4fa280-85d8-472d-ef7d-08db8733a574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /xLbwUXP8tIzop+doLZR3vBG2ggsV8/vR7sb661c48xW9cQF86Ew6N1afazixvyTpTxI2nDIXyEHDEfl0bNo8FPK/Z8Y1A0ksW48vGZhM3qQk63v3FraJicJ8cUW219YlIy3Fb0yum9JiNPTWC57h6M67d3YpX3S3YOMJzRz/KaD82PtI73jzB5UOvDxlv3Ac/2gNd0XoHjAMlKqfRva5IYfznsZbrmF4SaQLqeVV3wOo/V3xhja98FUj1IOJhkYlErxWYK9lDbMJlH1/7OmYMXZoJ63+wGzmk0kZsYfhfOcnmlThyajEI/eX2Mm9ZU/D8q2gPez74/ir5dZ8kGinvgp2Cy/Cs+piUonYt8JFt33bTexS4mtokwm9lJCsE52YTWSA/bfojNJjaXl/EcBMfou2okbn8Pnl8WfQZHsf1vzQNrfhQbFFSSdgmryEOCFCIoLYoQQ4FJt11/JqygmwiXOxIdZtwk/03k4go1ce5NVv+0PSzPqa2luCNH6fNtAxRaX7RmQvWD71MuAMjI/rg7vm//cMiBnUPY4V8Z+yrZCmfvOKkedg0YmxgbVvq6UOUIm1Q8quZnsINZfzRRvdof8/0kmVeY9xdnveQa3Uigc+j4hQIx2UDZ7CuyTuaUeVmSnx4gs5P7MoO9JczVk3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199021)(82960400001)(31696002)(6506007)(83380400001)(38100700002)(186003)(26005)(478600001)(53546011)(6666004)(6486002)(66476007)(8676002)(41300700001)(66946007)(2906002)(8936002)(66556008)(6916009)(316002)(4326008)(5660300002)(36756003)(6512007)(2616005)(31686004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm82SU91Zlp4WXgvSjVQVnkrVXYrMUpONU9ZVitzMFhQdDQ1R3drWGdJQ3dl?=
 =?utf-8?B?aTRZcm82YjRXL0dVVWZhYWNwT2tBWjlKdFFlSlhHUEQ4QThYYkxMenlReStN?=
 =?utf-8?B?VUNDS1U4SWFVa1RvWHdtN3BMYnZMT2E3TVk1UFRsNGsrUE0wdUVVczRGUW5W?=
 =?utf-8?B?YW9CaWg2dG5veTNIZWtUYWM4MWxBTnkyLzNLYW5pY3BRS0VVb0tGb05EOUc4?=
 =?utf-8?B?R3pGTDVXWXBMMkNWS1pOUnBSbDNIMGt4S096NGNKVHpjTzhkOFlWc1M4REFC?=
 =?utf-8?B?a2tEdENCeXA1bXdaYVlzOWNuUjEzQW5wR3BGYURMcFQ1aTExaXNHdXVDMzBx?=
 =?utf-8?B?MG8zTmZIT3IvK1BHdFhaOWlyall1bEZudmg5dVJQMVkrZ1BLRDJtNVcrT1Ax?=
 =?utf-8?B?WVpObFluenVuWEhDZy9SeEEwcTl6bDEzNldIMGFoMXRZWk1BZExqWUNSY3pi?=
 =?utf-8?B?RXZRVDJKVEF1cVZvSVV4R3NOUEVQcU9ZbGZZblVBMnZVYitpY1YxWk9rT3dv?=
 =?utf-8?B?c3JxVTF0dHBoZmR4bm5na2pqU1pSOFdMcDkzeTRlVFBkZ1NiQmtZZ29DUjV1?=
 =?utf-8?B?NDNyK1BQeWdTYUJiaGh0ZGh6OGJQRTRYTVcxUkFTbUl6KzA1aE5nZnExVkpN?=
 =?utf-8?B?NGtTQjlEdVhkRUQvMDZNM0FUV3plSXpoWS9mY3hUd1h0M0JJSTJrYVdUaDNU?=
 =?utf-8?B?YU5lWFJQNGR2d3pxeXp3MGRONkNkUE1qSDA3dnpvdDV1Z2h3S2xtWHVWTHZk?=
 =?utf-8?B?Nzc0Qmx6dk9qQTB6TytNOUoyVmZHb2Q2OU9tbS81YnNQU252c3ZreUhmZ0x5?=
 =?utf-8?B?c0h5VGlMTTJ2VUtWS2QvS1ppKzFiWjlqblA4MmtrbklrRDAveXNORkVSbDdL?=
 =?utf-8?B?c25kN01SNFNFRE5lOWc1Zk5ZSmcwdmNMRlVXRkdtR2FVNStCelNUZXRyc3Vt?=
 =?utf-8?B?bXpKWE44SjVvS0grUHBGcnhidXlDVTB1N3Uva21jKzIwZzByVUlCK25wc1d4?=
 =?utf-8?B?R0gzemdQQ2RyUW1HTUNGck1nZ1RFYjZ6S1kvWWg5OHh3UlYrSWhQNjhaZ2xN?=
 =?utf-8?B?QmdRNTBVVHNHMGlUQWpwSUU5d0phc05qQVlERzZlZ0EwQTlWUWxEZXdGM1BJ?=
 =?utf-8?B?anNGMkZzaWxYemMxdlFuQ05lRzZIZzRLcjBDbVRsaVpsZU42QVFVODk0OHZD?=
 =?utf-8?B?bVlYVERVRWRCWEtydmpjTHZPNHRNUE1PL2RrbHkxc1R5R0czb2dGamRtVStV?=
 =?utf-8?B?d3FISUR4T3pGQnlucjd1dlJvV3doRHBNRENJRmRoV2xYTnlhTG80bGFYaFlU?=
 =?utf-8?B?OVpmREQ4SWJscjJjUFhQalpXcG45dkVycE8zdkpMMjB6VkE3Wi9HSmxmUUlz?=
 =?utf-8?B?QmtSMTFnNXpPUzZ6TTl6c0VhcG5sR2U2V1lYUGRkUTQ0QjJZNHpDMi9YaExX?=
 =?utf-8?B?ZXV0U1N5clp6dlRONnNrTVJHQXdWd3RrcTg3MGdSekw3amNpcG9wTzQra044?=
 =?utf-8?B?YU5QV2xvZnVsRXZZVGs5Mlhkbmw2bWZxWVpPR3dPS1d0OXYyUUkzcUZsaXN2?=
 =?utf-8?B?Sk1CbndiWG9TN2NyVTlNZjc1MjFrVXdmSyt5Vkc0eGRDOEVxRnNsamx3OUFR?=
 =?utf-8?B?VE5RYk5VSC83MlRJdGpaZGpLZFUySkNzK1VFcGhhVEhRU2dzeXBCbUhERCs0?=
 =?utf-8?B?c2V4aGlnT3J6alRnRnE2WDYzRW9YKzVvczFKWmhBbXVnV0tqdjl4NGpyNHA2?=
 =?utf-8?B?dzgvc0p3ejFHWEVOV0hiSmtEQi9CTW5tZDVXajFNbE55dGYrcy9xZnF2ajlQ?=
 =?utf-8?B?Q0ljdHVaZmpUOGhsRndWMmRpZVNaUHBuZW1zdVJqUmpFNlk1S1dBZUppTW9k?=
 =?utf-8?B?YkNvTmQ5eVIyak84NExXV0Z5NThsV3pLbHZXaXAwYzFGdFRiRjlZYTFnNk9i?=
 =?utf-8?B?bFVkSVE4M2l0YjBqTUZLMVNPSnZDRlpIUUR6bXlpZHZxYUdBeTdzaWFaTWVN?=
 =?utf-8?B?NU45L2lQL0I1T1Rocmk4em5aT2dVM01TM3lVMEF5aFNvSExYYjJpOTk4aDJR?=
 =?utf-8?B?STZRdElvYzlBTE5UQk5NRUgwUDAxR0Y4VE9OQTlBd2NqNkFrOW94T2NYQ3Vq?=
 =?utf-8?B?ampwWkZ4WUFNN0lEU1VLSGN4NVFTYjJhSE9rRC9Sa2J0VlEwWWJwYk5hRE85?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4fa280-85d8-472d-ef7d-08db8733a574
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 02:06:49.4423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRXnrkThyZx90uC//fkubKmVDHlx6XfbHg4wcpMoFKoHeLpsIW0Iwu+dMJ6xxDyQg5iVYZUsB9wbQjXqGxgjQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5044
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/23 16:12, Yin Fengwei wrote:
> 
> 
> On 7/17/23 08:35, Yu Zhao wrote:
>> On Sun, Jul 16, 2023 at 6:00 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>
>>> On 7/15/2023 2:06 PM, Yu Zhao wrote:
>>>> There is a problem here that I didn't have the time to elaborate: we
>>>> can't mlock() a folio that is within the range but not fully mapped
>>>> because this folio can be on the deferred split queue. When the split
>>>> happens, those unmapped folios (not mapped by this vma but are mapped
>>>> into other vmas) will be stranded on the unevictable lru.
>>>
>>> This should be fine unless I missed something. During large folio split,
>>> the unmap_folio() will be migrate(anon)/unmap(file) folio. Folio will be
>>> munlocked in unmap_folio(). So the head/tail pages will be evictable always.
>>
>> It's close but not entirely accurate: munlock can fail on isolated folios.
> 
> I suppose normal 4K page can hit this problem also and following patch could
> fix it:
No. This patch is not necessary as unevictable folio will not be picked up by
page reclaim. It's not possible to munlock the isolated folio from lru list.

The possible cases I am ware are: page_migrate, madvise and damon_pa_pageout and
lru_gen_look_around. The first three already handle this case correctly by call
  folio_putback_lru().

If folio is isolated, the split_folio() will just fail. So looks we are fine
for this corner case. Let me know if I miss something here.


Regards
Yin, Fengwei

> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 1080209a568bb..839b8398aa613 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2498,7 +2498,7 @@ static unsigned int move_folios_to_lru(struct lruvec *lruvec,
>  
>                 VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
>                 list_del(&folio->lru);
> -               if (unlikely(!folio_evictable(folio))) {
> +               if (unlikely(!folio_evictable(folio) || folio_test_unevictable(folio))) {
>                         spin_unlock_irq(&lruvec->lru_lock);
>                         folio_putback_lru(folio);
>                         spin_lock_irq(&lruvec->lru_lock);
> @@ -2723,7 +2723,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
>                 folio = lru_to_folio(&l_hold);
>                 list_del(&folio->lru);
>  
> -               if (unlikely(!folio_evictable(folio))) {
> +               if (unlikely(!folio_evictable(folio) || folio_test_unevictable(folio))) {
>                         folio_putback_lru(folio);
>                         continue;
>                 }
> @@ -5182,7 +5182,7 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
>         sc->nr_reclaimed += reclaimed;
>  
>         list_for_each_entry_safe_reverse(folio, next, &list, lru) {
> -               if (!folio_evictable(folio)) {
> +               if (!folio_evictable(folio) || folio_test_unevictable(folio)) {
>                         list_del(&folio->lru);
>                         folio_putback_lru(folio);
>                         continue;
> 
> 
> 
> Regards
> Yin, Fengwei
> 
