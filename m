Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10339778426
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 01:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjHJXbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 19:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjHJXbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 19:31:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8726C2713
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 16:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691710262; x=1723246262;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=inDh516bLjYLxTNAo4kUTVjLG9litJrwRBFFLOfioT0=;
  b=fRErvHgvVMhxkXBCzryFsk3l19zG/Jqi3kxpD5F2wXkEGnDybY8hdc56
   DwuxJpvwyRtJvGtN8dOgOt+b2KfjIeHMAAreNl3V87pXX27P8iCNhWJiY
   WQdA7WdSum3i0CiQWERfX41u29ltaPWE8CD2YFz41t7F+FB6nckn+WY/N
   /kC9x++PEaTvgB2UIeMXzKnZRx0uLHtn1pQan2W5qT3ho0XTs3mimohuq
   mbcZwNbNsobjZi6z678ytLMMSV+k2E6a74oshTQshFU59uoao0pfyAihA
   dOXhElERV8pOhH405gQBMVhjZI9LXjITdUvmUjEg8XfP2jUoEubLnPpyL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="356512590"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="356512590"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 16:30:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="875933557"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 10 Aug 2023 16:30:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 16:30:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 16:30:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 16:30:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPBI6IkDWtqJlpura6ywLZFwSeOpXshfL1QBB857Ed1EsTfq3jses0CTvIYKTzsHLmQBLnqxZWM9XGJP5mCLjzZ9kLNeDsJHt1GAMjwrbPvlLDMG2shAYmNwIJU7XE4MJkTiDVoMgnVl21XRJtj0T5MhLsTE+Qy3mKAOB7mAMqNmjLORe67tVByERMFXxkc+gEtSn6hEHux+msxiGQ3nmN4mZHP1vm0hFVpuwKb1m6oM9GaA1mfm/3GSe2Uo/kTQuERG5sUi6yN4P7bMlTJPcvy+GKcSQudjPquV4BPEYWreRspYFra8QJSxJ/mfohcnPamrd0jLnh7XDLZVY5UR/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wq4HgX35qIk324xqksdSvfUDbz6LdcGgi3DWn/hmV/Y=;
 b=WpUemTkyd6V0GfB8hc+AhduyTJr/VMzKuulOxM0rUIIlJuhR2+LOhgfBq9x0Ao0/YuHVUXibqP2UMG4uTRo24HSvMOPGVhIhCf8KVxkm4FTqfF2OyJF94I9mL5D4kymmuSIN6++wp9L0e2Ocnoz95fQ2MIZb/O5xetNFL1kIM06JY7xuYVwJu4mo/nH8tIlFmFkkTtQq9NjEJYqZ+2E/9ax8j/yPp/0bMTP/NJDVXkMsyYX8PskaOU3GruKk9I5mWfTgeyYnDO8nXKz7WiKXLtOo4yQzsz0G2Dx45+KacpOpKjTVBOTEoW62uEJ5KrzPl/uyyWVuEWZDW6xosOPKtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 23:30:49 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 23:30:49 +0000
Message-ID: <3732dd16-148d-4ac6-8295-86a12f89365b@intel.com>
Date:   Fri, 11 Aug 2023 07:30:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zswap: don't warn if none swapcache folio is passed to
 zswap_load
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
CC:     Yu Zhao <yuzhao@google.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <hannes@cmpxchg.org>
References: <20230810095652.3905184-1-fengwei.yin@intel.com>
 <CAOUHufYb2LiZYqhyk7GZ2roUbHUEUf3iKkvmSThHBS21EewHiw@mail.gmail.com>
 <26949c92-95a0-414f-918a-8b8cc11e3e9c@intel.com>
 <CAJD7tkZRjSKrGBhBQmFsc+45TNAcii2QRMwwhnsgP3_3o8Jxug@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAJD7tkZRjSKrGBhBQmFsc+45TNAcii2QRMwwhnsgP3_3o8Jxug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 6634d6b6-95ac-434a-9a9c-08db99f9d416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0ZodQxQRrfyr876Q0SWEwZPkURgEG/jMW2rloxYCr4u7AR2Ed1f7gaYHiYWDSOxi/+cv/MMQqkq6UNTX9zisoTpbKx+DH868Wm3V7YM5lkHQxGe3iD7/QAAUGlnR5t1jojxoWD6xoyeuwto3pFO0wJDgXxrXOQkR2q2ahUGV0dnMzoO8B5oF9SJ1nLObTKoKSzH9OXE19smJkddmTQJeH7tSwkocGTEhYPsVbeKUxNiG3+wE8hODkatfyBjt0kdSWYE48mDhCtBAbJBoru9PY56W9xKuHK2UUtXS9neCr/q8aBTVmPqAvou5z17eN8cHiTIz2X8JFOzZl7OBxyFBGYeZ5F+pjrW9sANYEIG4WTenHATHGlz6UNyuBBDNhgwacaEJhSjLWEH7OHQT0f2IZBFTWDJ+QnhyoUsq+educWgIng2CCR85Ekd+lSnXXA2TpJRYe2YgJlL+Whs0qje2M4fIsTvClNePhhDk+LAu5RtJtFNlVQ70qw+iVXp5VtIIASLaWb+wv5JieYPZ7VAmyLGrtx2cStBKd5OV6xt63wjlBioOC9am5AxzUwrZox7zRFf9Gmf+tLyreV77RNDOhMpHrCaf5SUVVkD163JMUO+u3kQagJNAKHiojkM3Os/ccJq6Ej1YS8ANMNR/yCZ5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(186006)(1800799006)(6506007)(26005)(8676002)(8936002)(53546011)(41300700001)(36756003)(83380400001)(2906002)(38100700002)(2616005)(82960400001)(86362001)(31696002)(66946007)(66476007)(66556008)(478600001)(4326008)(6512007)(110136005)(31686004)(6666004)(6486002)(5660300002)(45080400002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnRQcWlLWXlOUW1hRlRUbHY4RytreHJ1YXZGRHlWZllEY0RnQ2lQWi9HQy9L?=
 =?utf-8?B?cHBOSlFXeWJJek4yUzZhc1BWcjBrYmdXUGZnaUxJbjJIS0o0QTczTWJTYmo4?=
 =?utf-8?B?SHI5Q3g1VTVlNHpsaXZzb3NwZStDeXNTQitkTDBVRFR0NXdtL3hYYktBWGoz?=
 =?utf-8?B?UTVCeU5sK0JxYTM5cHZiQm5mNndidmNRMnNLYVZ4ellLZmV4Q2RIRG9RQjZZ?=
 =?utf-8?B?QldKWWtteUlzOEZ2aXJlMVAwWmxML2hwSVFnQ01RakI4L0N3MjZkR2ttdWZp?=
 =?utf-8?B?anVLa3lLWDF2UWY0K0NFR09YSjBJbzhGWm1GMnVaMlJ6dXB3Q3Y5aTBWSjdh?=
 =?utf-8?B?SnhtZHgra1oyWFdEVC9MQXVrWkhHM0Zkd21YWFhyUDcwa3BvTXB0enFXM0dq?=
 =?utf-8?B?YVo2KzZxK2kzNlVFYmZHaGI5TTk3QVpjZFJWbVNTRDhSaUoyRHhIeE1HOVBG?=
 =?utf-8?B?NjBUMTkyeXJTbTErcjF0MHhZTFRiOXRra1M5K3dLSFZJS0FLQ3lnT0F3TEhv?=
 =?utf-8?B?WWxyUEFnUENIRDRUalRWSWxGb21GeS9xTFRudG1qbE84V2YyYVJoVmhjdFA0?=
 =?utf-8?B?YXcxZU1XSXp6MDVaRWRWODNoQ2NYRnUzTzRVeVhKcjN5ZzE2ampsaGJ0TjM4?=
 =?utf-8?B?UCtYZk5DYm5CQ2VVN0VJaDIxYnhpUXJFdXBjZmdCSDduWEMrTXpTVmRXMEp6?=
 =?utf-8?B?alJ4U1pTTGQ1MHFZRFBuQ1A4RjhhQWNvM21aOWp2eU5hdlBCeU1pajlxUGxN?=
 =?utf-8?B?RlVaTFlKbkFJRmdXTlZLRWRSTVYrcDl3NnFxbDVCaVFGME56dG1QVFRFNmxl?=
 =?utf-8?B?b1pQdEVkM3huRngxQ2VmZXhCQnh3MHVyTmNUYWJKRFFmaDdDZERuRTRoL21h?=
 =?utf-8?B?eDd0ZjZFNDB4Vll4d2NFTWxTdXdWZFlEbFBmdzNVLzRqOHNOblhrdHg4blZk?=
 =?utf-8?B?Q3ZnckRvNUE3M0RndGVtZW50cVN4YkxwT2ltVlVMTC9hU253RkM2bVJPTk9N?=
 =?utf-8?B?aWtzVk9rejdQb0tkR0JsY2dKWExJU21NcVNwVkh3YzhydFZuVUV6N0dGeStD?=
 =?utf-8?B?cXg4elZyekZPYzJ1Yy9NSVVCV2o5VzdrR3lkcUJoYnp4TXo0MWwwU3l6YmtX?=
 =?utf-8?B?NUcvZTduN0xIYkVSaVpOaXJaZlNLUDV1QmVPQU16WXRhalRhQlY3a3VmcVRF?=
 =?utf-8?B?c3Y3bi9lWjFMV0dOb3NmWlBGejhFcFNQdVZrY3RpeE1SNm5uaDJ5K0dzeXlx?=
 =?utf-8?B?eVViOS8rZTdmTlpjTTlheE5tdU1IVnlCY20wMHJnRTJ2WXlVMCtjOVd6Vkg4?=
 =?utf-8?B?U0NwVkwwZXhvSC9aV0NnMDZrK0xKMmsrSUhXY25vdVdvTTR2aUpvK25yRWtR?=
 =?utf-8?B?cjZzRnBzZDE0b1YzSTNTbWZqbkJpVCtMdTUwMFRFTFlwTXczMWFBMkY4Qisx?=
 =?utf-8?B?clBKZllheXU4OWZjU2NHd3RBWFl0UkZ6ZXRnRklJQjl0eVVKcUhtNHNSeVd5?=
 =?utf-8?B?MCsvZFI3MldmQVV1Sm41bUUydzd2dlVFUzQvWXRyRXJZNVc1bHhpYUtWZENp?=
 =?utf-8?B?cUVDWm5DVVN6MkNtSmViNTAxUGIzRUk4aHlzdWo3Z1NFbGsybEhMTGhkYzBM?=
 =?utf-8?B?NHNyemUxWWtQUWhsZ1ZGVmo1anEwRTIxeWdadmZMT0xtcnpGUFRwWlREVU5i?=
 =?utf-8?B?L3ZSK3VCck1QNU1wRGN0M0Q4Q0lnYm8wWW1xL3k3UDlQNUlkd2xmVkMvcllL?=
 =?utf-8?B?dTczYlgxN0RnL25qbW1lbEtqMnNnZ3ZaQVB2OWc1QUpBbUZkVVFOa0hnTzZO?=
 =?utf-8?B?N3pYV0NlR210c2ZoWXgyTFVlNDdzTlYvV2JpYTMzbEhIUFdmOWs5K1BNRC82?=
 =?utf-8?B?aERQQ0F2ajdLNGprc2tSN05xZWxYVjhEYjJteDA5UXhXZlQ5SUZTczdqd3Nq?=
 =?utf-8?B?OWd6VjhJSFVjZGVuMkNmQmVlMUIxMFhleHlncEVwVis4YlhTNmt0STFkUTkx?=
 =?utf-8?B?UHBiblN4WGI5aFVVUGF0NVVheHdxbzJNTzQwY2lEQ204azdsYjhCa3BMeGhL?=
 =?utf-8?B?aUZvZmtleDJaWFlDS0loY0VTU2RNakhkajFIZ1N2RTZZMXJldTNPdFhLTDMw?=
 =?utf-8?B?L0FHUU1BNEd2QVkyNWhCWEJsSU9Ed2ZvVmFmMGhpNWxjdkpnQ2drSlJqa21u?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6634d6b6-95ac-434a-9a9c-08db99f9d416
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 23:30:49.0150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 292897KMmZL6MW1N/uFWCaXLno/eG46yZyNe5rip3SxfVhLflualXgmFBr1l2rxTP+5QDsrpuiTpX/KbmPIELQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/2023 7:15 AM, Yosry Ahmed wrote:
> On Thu, Aug 10, 2023 at 4:09 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>
>>
>>
>> On 8/11/2023 2:44 AM, Yu Zhao wrote:
>>> On Thu, Aug 10, 2023 at 3:58 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>
>>>> With mm-unstable branch, if trigger swap activity and it's possible
>>>> see following warning:
>>>> [  178.093511][  T651] WARNING: CPU: 2 PID: 651 at mm/zswap.c:1387 zswap_load+0x67/0x570
>>>> [  178.095155][  T651] Modules linked in:
>>>> [  178.096103][  T651] CPU: 2 PID: 651 Comm: gmain Not tainted 6.5.0-rc4-00492-gad3232df3e41 #148
>>>> [  178.098372][  T651] Hardware name: QEMU Standard PC (i440FX + PIIX,1996), BIOS 1.14.0-2 04/01/2014
>>>> [  178.101114][  T651] RIP: 0010:zswap_load+0x67/0x570
>>>> [  178.102359][  T651] Code: a0 78 4b 85 e8 ea db ff ff 48 8b 00 a8 01 0f 84 84 04 00 00 48 89 df e8 d7 db ff ff 48 8b 00 a9 00 00 08 00 0f 85 c4
>>>> [  178.106376][  T651] RSP: 0018:ffffc900011b3760 EFLAGS: 00010246
>>>> [  178.107675][  T651] RAX: 0017ffffc0080001 RBX: ffffea0004a991c0 RCX:ffffc900011b37dc
>>>> [  178.109242][  T651] RDX: 0000000000000000 RSI: 0000000000000001 RDI:ffffea0004a991c0
>>>> [  178.110916][  T651] RBP: ffffea0004a991c0 R08: 0000000000000243 R09:00000000c9a1aafc
>>>> [  178.112377][  T651] R10: 00000000c9657db3 R11: 000000003c9657db R12:0000000000014b9c
>>>> [  178.113698][  T651] R13: ffff88813501e710 R14: ffff88810d591000 R15:0000000000000000
>>>> [  178.115008][  T651] FS:  00007fb21a9ff700(0000) GS:ffff88813bc80000(0000) knlGS:0000000000000000
>>>> [  178.116423][  T651] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [  178.117421][  T651] CR2: 00005632cbfc81f6 CR3: 0000000131450002 CR4:0000000000370ee0
>>>> [  178.118683][  T651] DR0: 0000000000000000 DR1: 0000000000000000 DR2:0000000000000000
>>>> [  178.119894][  T651] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:0000000000000400
>>>> [  178.121087][  T651] Call Trace:
>>>> [  178.121654][  T651]  <TASK>
>>>> [  178.122109][  T651]  ? zswap_load+0x67/0x570
>>>> [  178.122658][  T651]  ? __warn+0x81/0x170
>>>> [  178.123119][  T651]  ? zswap_load+0x67/0x570
>>>> [  178.123608][  T651]  ? report_bug+0x167/0x190
>>>> [  178.124150][  T651]  ? handle_bug+0x3c/0x70
>>>> [  178.124615][  T651]  ? exc_invalid_op+0x13/0x60
>>>> [  178.125192][  T651]  ? asm_exc_invalid_op+0x16/0x20
>>>> [  178.125753][  T651]  ? zswap_load+0x67/0x570
>>>> [  178.126231][  T651]  ? lock_acquire+0xbb/0x290
>>>> [  178.126745][  T651]  ? folio_add_lru+0x40/0x1c0
>>>> [  178.127261][  T651]  ? find_held_lock+0x2b/0x80
>>>> [  178.127776][  T651]  swap_readpage+0xc7/0x5c0
>>>> [  178.128273][  T651]  do_swap_page+0x86d/0xf50
>>>> [  178.128770][  T651]  ? __pte_offset_map+0x3e/0x290
>>>> [  178.129321][  T651]  ? __pte_offset_map+0x1c4/0x290
>>>> [  178.129883][  T651]  __handle_mm_fault+0x6ad/0xca0
>>>> [  178.130419][  T651]  handle_mm_fault+0x18b/0x410
>>>> [  178.130992][  T651]  do_user_addr_fault+0x1f1/0x820
>>>> [  178.132076][  T651]  exc_page_fault+0x63/0x1a0
>>>> [  178.132599][  T651]  asm_exc_page_fault+0x22/0x30
>>>>
>>>> It's possible that swap_readpage() is called with none swapcache folio
>>>> in do_swap_page() and trigger this warning. So we shouldn't assume
>>>> zswap_load() always takes swapcache folio.
>>>
>>> Did you use a bdev with QUEUE_FLAG_SYNCHRONOUS? Otherwise it sounds
>>> like a bug to me.
>> I hit this warning with zram which has QUEUE_FLAG_SYNCHRONOUS set. Thanks.
> 
> Does it make sense to keep the warning and instead change it to check
> SWP_SYNCHRONOUS_IO as well? Something like:
> 
> VM_WARN_ON_ONCE(!folio_test_swapcache(folio) &&
> !swap_type_to_swap_info(type)->flags && SWP_SYNCHRONOUS_IO);
> 
> Of course this is too ugly, so perhaps we want a helper to check if a
> swapfile is synchronous.
My understanding was that the WARN here is zswap_load() doesn't expect
a folio not in swapcache. With zram, swap_readpage() must accept the
folio not in swapcache. So this warn should not be there.

But your comment make more sense to me. I will update the patch not
to remove this WARN. Thanks.

Regards
Yin, Fengwei

> 
>>
>>
>> Regards
>> Yin, Fengwei
>>
>>
> 
