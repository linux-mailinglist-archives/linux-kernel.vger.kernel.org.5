Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBFE7636BD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjGZMuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjGZMuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:50:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5904119BE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690375822; x=1721911822;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qTqsfvwMNjbLMZZ7ffz8Nd/z+Jr9cW46dhlZXj5NX8k=;
  b=O3McNTKJ8VpADLuVcRgjcWU/80acbwnBMScZdvLpXOsAXqk83WKr3mk/
   qaF2ePY/9i6KIhBg+aeNr2IoF8q9ve/X4FSvT5pTEUrST3uEYJSim+L37
   wFaxyTMl3oZ9xR7YVQcGIDU2e+PV7bAV8x+f4+G8w9+oE4dE0E+FgbxbX
   2VGY406/bbYnj5WDmZthyGn/FKBuKUIxyIPfPqTM4wYohVlbqOADhTPup
   HtLCZ+odF9AIafD/k5yP4m3c+tmb96a9e6Z5Db4TvZPzRU8ji1TDM89lf
   1UC9OE8V5Ahn0aMAu5LbzGotLeQYX4JKQhRZu8picjc2/PDB5s0LvHJDc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="348285527"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="348285527"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 05:49:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="900415478"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="900415478"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 26 Jul 2023 05:49:49 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 05:49:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 05:49:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 05:49:49 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 05:49:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqxO+dtL2IjqRsKAaWyYtw+ClgLAOQTekKvUsde7uh2p2H/sgiA0qnksStJZgo0KPctfIs0eJ25xOIXi5GB/iGDzaoiQLbafIHviWZhKniq1NertmA7PiJUiT3CtqFWFKRchTuLibflzN3d+QJV7prZQDdXo9OyhjG2Zcaox6zKiFRHd8ONbCJgtrtU/m8p295bbtWtz8PX99DM6XZ2mbDvkRayCf5A8epfk7B4yX1oVnpbJiS4xXJ79bNBgDTI9Sq+IhruXNKOGopUdthF7rSXfbofBsFNmRQzuWrILxlWdIV9e+7qv7ZHdAmmGBn2Y47+Bk78xJTqb2dE/by+Siw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoGxBhCM0tRWl/z/Jkxh6IzcD/uCtC25r6r9hG0QtrI=;
 b=BkkXNBGpXOl8fse2vgWBEqbIE5tUtMqd7/rR5YT1pGduqG7VAU8sJehSC/lff+aZCP+9OA/26u1m2Psfpj/i/dWL6UaYlgWGQwxe3ZXyvY8Ur8C462WYOqrRastlNLXW6Pqth4d65Fn/puHWVQLx92glxkL4DB6VK2SewsaWmgF6Yzr6RgIew/KnmGj0tSr49kjeMsfJGTZ50cefyQaVIgtctkrK2/YX/IbJ+Zsk1n0nHKGDl+F/HduRV9+xhhSS/+b3VNZwWaEJvGkdBwo44Hso9Gvm7joGIdSDXy8QUBCkYoMWOOq4qUaVB7f1AIbH1Z4dSn+1uzs14teFrEgdpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS0PR11MB7928.namprd11.prod.outlook.com (2603:10b6:8:fe::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Wed, 26 Jul 2023 12:49:47 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e%5]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 12:49:47 +0000
Message-ID: <3bd7b290-91ad-347f-b1b5-5d45ac566f69@intel.com>
Date:   Wed, 26 Jul 2023 20:49:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
From:   Yin Fengwei <fengwei.yin@intel.com>
Subject: Re: [RFC PATCH v2 3/3] mm: mlock: update mlock_pte_range to handle
 large folio
To:     Yu Zhao <yuzhao@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <david@redhat.com>, <ryan.roberts@arm.com>, <shy828301@gmail.com>
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <20230712060144.3006358-4-fengwei.yin@intel.com>
 <CAOUHufYef--8MxFettL6fOGjVx2vyZHZQU6EEaTCoW0XBvuC8Q@mail.gmail.com>
 <CAOUHufZ6=9P_=CAOQyw0xw-3q707q-1FVV09dBNDC-hpcpj2Pg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAOUHufZ6=9P_=CAOQyw0xw-3q707q-1FVV09dBNDC-hpcpj2Pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS0PR11MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: a11736b4-a5af-4ac1-6a91-08db8dd6cada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ssCOQN8jUkkmpOq/T58tAoCKBvr7fdZraRjUIyRUH9n0N3kxPU/c+Va+OYA7lijobBjprEM5mbsCIhMpEzrL3YqXQ5Uk/K/G5YRsv9IWMCbc0chh9titdviMMIgqEyB+TR5Y0ecUONrJba0rzCEReSi1bowRy/Gw+eD5+z/BkggP/+0OdKgy9KEuNlITogSliPdQCnjnGAVoEzp/kn36Op0xFyUS9AwRI5xpmd//PwMb3VS1DKXumDdMHW6g2p7FksjObFbuZDx5P6E1BDutJVGj8YzmwI7fkVALw4sIbpYe0++Go4yukQ2rVuLUvcR6SmKKrkTodf5J1nWHpV7sFZ8dIMsKQvt+MIWou+IYx3OGFwCTgTw3TBxecYOBcanydtvcyFvwfk7V9Hseq1Bd499wfrMywh7nXZ9kNvnTnvxEQ7ajvJJ9usGGm3K/mSFJULLUpqQ6mw6mYBARE1VgUG0eMq8K4Oq9VFx8KVi4LYw/nvAzK5i9YtssB2fQww3W5HICC7E+PTzaASuKL2GXW0pSlQpHhY44EDidGZ+lGHPMtaAckyb1G9dKwqwIzqrrwjow3fNHezfZk4U3d/yMnVc4eK+M3uT6F4b0NEy7NyEqU+lzlilH7lfo6qj1/Eruw5YOO2tfyKWaH3m0SQ5tig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(86362001)(31696002)(36756003)(31686004)(2906002)(478600001)(38100700002)(82960400001)(26005)(186003)(2616005)(6506007)(53546011)(41300700001)(5660300002)(6666004)(6486002)(6512007)(66476007)(66556008)(316002)(66946007)(8676002)(83380400001)(6916009)(4326008)(8936002)(15650500001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWpvT0tpaGEwTUxLbElZWmptcGNhVG4ydm16NlhuTmRpQlpPOE0xeWF0QWNP?=
 =?utf-8?B?TFk3RENsQnh6MHZsK28zTGJlcnNPeWRNdUlZYlFNVUhmVDQrdDJuV1kxWlBu?=
 =?utf-8?B?ZG82MTYvRFo1OTVlRmc0MkNsNUJkOU11RHpJZGNKYkZmMTZHd3llNHh3L3pO?=
 =?utf-8?B?ZDgxdlFkRkhDS1BOekdWdlJJVkNzLzhDVmo2blkwWURTc1lDZ2YxZUZ6S2RT?=
 =?utf-8?B?RE9HanBOdUdObzdqRDJGQ1YyOVQwbHo3TjFwa0VrenE1bkhBNFpQblptOXg4?=
 =?utf-8?B?ZytWMGhQQTBPWkthd1YrR2Z3cFFXWU1oOU91eHZWbkZGZFFCUHlNalZ1UzVr?=
 =?utf-8?B?OXlmNVZ6bmxFQjV5d1IrSFhoN1lnQkY3OXRUZ0U4N3ovMEZuZ0ZTamk3VjR4?=
 =?utf-8?B?TTZDOXhYNWRKQ3NZTlY4VWk5RDZxNDByUTJGUUhNRXAzNForRVhFUFlFQm9o?=
 =?utf-8?B?VEErZWNkb1dlYjVhbEtLQXdvSE4wd0NUZlBMU3hFeVBUM3dndDFRQ2RyY2NG?=
 =?utf-8?B?UXhaZDZJM0RMbnhGeGMwVUhqckZHU3ZlSFE3YlpEc0cyZXcrcDNVbFdISFhT?=
 =?utf-8?B?N1c3VkdobE5QbmZQWGtEUytxSTRpTmpUSmtLcllWSkdiVHYwWUxQVklpZjE4?=
 =?utf-8?B?akR3dERNb2U5RkVDRE84Q0w5MzdlZ3Qxcms3bDUxcDl1citseGxGOHJxZXhK?=
 =?utf-8?B?VXg5ajBlU2RNaFdPUTBhelcvZGpQMFR5a1NsSmd0ZlpiYWJxeTgybVREUmVN?=
 =?utf-8?B?MzNBUWt3OWxvdXBOcXZhaUNhYVNYNGw3VUlSU2JZRjVoOVhUTDdWbTYxYkYy?=
 =?utf-8?B?dytESDZLMG1KZk42N2RaLzNLcitVZEZWSnJmMDRRTnlBaXFMVlN3cmxuQVdq?=
 =?utf-8?B?UTlLVW5xTUVvTkE3K3pKK2VJaXR0dmdCY241aCtrR2xUZXVQYjVzTDlWcVBB?=
 =?utf-8?B?bkw1OElYWGU2ZGgvTEpqUW5FdC9kRkIvWEJaSkVoTUdaTzRPSmpPUmtxWUZk?=
 =?utf-8?B?WmhwMDF2MlI2VkNydjBvZU5laEx2bFpjOHczdzBkcGFQMXB4VzhmN1dXVjdx?=
 =?utf-8?B?ZStlZXBwaHB1YWlZZE1jZEprOTFiZXpzK3ZiS3lnWGswcHUzdzdUN2IyMjd5?=
 =?utf-8?B?ZW5vRUVRWUI0SS9iSTZoVFZTa3MzM0JDWDVqN25QdTlWMWxHTDhYZHlKR0w2?=
 =?utf-8?B?ZU8vUkllWERXL0pnQ3Z5T2wyUlFwTU40bnVPS2psMTlDZkVoamk2MDUzNzA5?=
 =?utf-8?B?Z0RMd2dLcTFjWWFRdnNKTkR0cEd6K0tlc1VJR3BqQ21NVEMrVVFsdzlJeTAw?=
 =?utf-8?B?N2RraWZYaFFXeWl0NHB5djdDWDJValBrTGpDWUdQR2o2Y3l1a2NnU3lQdEwx?=
 =?utf-8?B?aXcvcVJzUzl2cmNBWGNiKzE2bW1xbkh5MEUwdjRRV2lHZVpXcjcxTWszV2tH?=
 =?utf-8?B?US8xK0pJM0NzTGdsNFIyMUljK3E2QUNtLzRNVHBhWkpMQzVNNEhBYkdudmcz?=
 =?utf-8?B?QUlhdGxISFc5WVRMUVM3RGx6N1ZscGUzNTFtWVhQemNOSlBLTWZyTnZjVlZn?=
 =?utf-8?B?akU5UklKTWtNd2hkQTMzYnRvZmdVN3k1WUttRzJZdm40aUFRTXQwL0RNZXZ0?=
 =?utf-8?B?K2ZJK3pkNEY3OERUcjI5UWtwSmk2RjFuVmlwbnhtSlBJeTVEdlRGc2xoMHha?=
 =?utf-8?B?K1c0bGlnWnVyNStjYy9OT0EwcDlUSmVHN2lJaHQvV05oTmV4Uk1oS1l5MkdB?=
 =?utf-8?B?dmFpeDRUbjRjcFVEWnFaK0M5TmJKL1J1SUZUc1IrbGlUZms3bFNrWjZWZ1Vh?=
 =?utf-8?B?TWtKYWViMTlPWWdSNGJFeVMwVWFoZ0Y3UUJabnRSM21mUzYySEpMNlZhVXpr?=
 =?utf-8?B?Z3BXVlJMYUV5S3JNVEVYU2Y3NlE1UjVEMS8vU3BwMC9GY001VjU0U0lkMjdS?=
 =?utf-8?B?VGl6bllnTTRId2hLcE8zN1lHVFErTlFIMHlJOTdTZHZQQldKM2hLTWFhRjJk?=
 =?utf-8?B?MWpQbytXbEtVZzJmWWtVems5V1lnM1dzSFdPNWJtZWtWQmRpRlZlcisxU0I1?=
 =?utf-8?B?UGhCcTBGd0Y0alJ1emRKd0V2ZUl6QjBaVzA3aGwyUkluNE1OS0oraDJmM2Vx?=
 =?utf-8?B?NE8xRGtwZkJnNlE1ODhCZTZrd1Y1UzV0WFdqQUg4cms5REZvSXhZdElnYUJs?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a11736b4-a5af-4ac1-6a91-08db8dd6cada
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 12:49:46.9859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nr7yiJm7W40np7Q/q6tldsVdTR0HYvKcdOkyKShWwREAVMH5txlYy0hFlJKRwRFykrg/5o0T8TRSRPhvDZljw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7928
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



On 7/15/23 14:06, Yu Zhao wrote:
> On Wed, Jul 12, 2023 at 12:31 AM Yu Zhao <yuzhao@google.com> wrote:
>>
>> On Wed, Jul 12, 2023 at 12:02 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>
>>> Current kernel only lock base size folio during mlock syscall.
>>> Add large folio support with following rules:
>>>   - Only mlock large folio when it's in VM_LOCKED VMA range
>>>
>>>   - If there is cow folio, mlock the cow folio as cow folio
>>>     is also in VM_LOCKED VMA range.
>>>
>>>   - munlock will apply to the large folio which is in VMA range
>>>     or cross the VMA boundary.
>>>
>>> The last rule is used to handle the case that the large folio is
>>> mlocked, later the VMA is split in the middle of large folio
>>> and this large folio become cross VMA boundary.
>>>
>>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>>> ---
>>>  mm/mlock.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++---
>>>  1 file changed, 99 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/mm/mlock.c b/mm/mlock.c
>>> index 0a0c996c5c214..f49e079066870 100644
>>> --- a/mm/mlock.c
>>> +++ b/mm/mlock.c
>>> @@ -305,6 +305,95 @@ void munlock_folio(struct folio *folio)
>>>         local_unlock(&mlock_fbatch.lock);
>>>  }
>>>
>>> +static inline bool should_mlock_folio(struct folio *folio,
>>> +                                       struct vm_area_struct *vma)
>>> +{
>>> +       if (vma->vm_flags & VM_LOCKED)
>>> +               return (!folio_test_large(folio) ||
>>> +                               folio_within_vma(folio, vma));
>>> +
>>> +       /*
>>> +        * For unlock, allow munlock large folio which is partially
>>> +        * mapped to VMA. As it's possible that large folio is
>>> +        * mlocked and VMA is split later.
>>> +        *
>>> +        * During memory pressure, such kind of large folio can
>>> +        * be split. And the pages are not in VM_LOCKed VMA
>>> +        * can be reclaimed.
>>> +        */
>>> +
>>> +       return true;
>>
>> Looks good, or just
>>
>> should_mlock_folio() // or whatever name you see fit, can_mlock_folio()?
>> {
>>   return !(vma->vm_flags & VM_LOCKED) || folio_within_vma();
>> }
>>
>>> +}
>>> +
>>> +static inline unsigned int get_folio_mlock_step(struct folio *folio,
>>> +                       pte_t pte, unsigned long addr, unsigned long end)
>>> +{
>>> +       unsigned int nr;
>>> +
>>> +       nr = folio_pfn(folio) + folio_nr_pages(folio) - pte_pfn(pte);
>>> +       return min_t(unsigned int, nr, (end - addr) >> PAGE_SHIFT);
>>> +}
>>> +
>>> +void mlock_folio_range(struct folio *folio, struct vm_area_struct *vma,
>>> +               pte_t *pte, unsigned long addr, unsigned int nr)
>>> +{
>>> +       struct folio *cow_folio;
>>> +       unsigned int step = 1;
>>> +
>>> +       mlock_folio(folio);
>>> +       if (nr == 1)
>>> +               return;
>>> +
>>> +       for (; nr > 0; pte += step, addr += (step << PAGE_SHIFT), nr -= step) {
>>> +               pte_t ptent;
>>> +
>>> +               step = 1;
>>> +               ptent = ptep_get(pte);
>>> +
>>> +               if (!pte_present(ptent))
>>> +                       continue;
>>> +
>>> +               cow_folio = vm_normal_folio(vma, addr, ptent);
>>> +               if (!cow_folio || cow_folio == folio) {
>>> +                       continue;
>>> +               }
>>> +
>>> +               mlock_folio(cow_folio);
>>> +               step = get_folio_mlock_step(folio, ptent,
>>> +                               addr, addr + (nr << PAGE_SHIFT));
>>> +       }
>>> +}
>>> +
>>> +void munlock_folio_range(struct folio *folio, struct vm_area_struct *vma,
>>> +               pte_t *pte, unsigned long addr, unsigned int nr)
>>> +{
>>> +       struct folio *cow_folio;
>>> +       unsigned int step = 1;
>>> +
>>> +       munlock_folio(folio);
>>> +       if (nr == 1)
>>> +               return;
>>> +
>>> +       for (; nr > 0; pte += step, addr += (step << PAGE_SHIFT), nr -= step) {
>>> +               pte_t ptent;
>>> +
>>> +               step = 1;
>>> +               ptent = ptep_get(pte);
>>> +
>>> +               if (!pte_present(ptent))
>>> +                       continue;
>>> +
>>> +               cow_folio = vm_normal_folio(vma, addr, ptent);
>>> +               if (!cow_folio || cow_folio == folio) {
>>> +                       continue;
>>> +               }
>>> +
>>> +               munlock_folio(cow_folio);
>>> +               step = get_folio_mlock_step(folio, ptent,
>>> +                               addr, addr + (nr << PAGE_SHIFT));
>>> +       }
>>> +}
>>
>> I'll finish the above later.
> 
> There is a problem here that I didn't have the time to elaborate: we
> can't mlock() a folio that is within the range but not fully mapped
> because this folio can be on the deferred split queue. When the split
> happens, those unmapped folios (not mapped by this vma but are mapped
> into other vmas) will be stranded on the unevictable lru.
Checked remap case in past few days, I agree we shouldn't treat a folio
in the range but not fully mapped as in_range folio.

As for remap case, it's possible that the folio is not in deferred split
queue. But part of folio is mapped to VM_LOCKED vma and other part of
folio is mapped to none VM_LOCKED vma. In this case, page can't be split
as it's not in deferred split queue. So page reclaim should be allowed to
pick this folio up, split it and reclaim the pages in none VM_LOCKED vma.
So we can't mlock such kind of folio.

The same thing can happen with madvise_cold_or_pageout_pte_range().
I will update folio_in_vma() to check the PTE also.

Regards
Yin, Fengwei

> 
> For that matter, we can't mlock any large folios that are being
> shared, unless you want to overengineer it by checking whether all
> sharing vmas are also mlocked -- mlock is cleared during fork. So the
> condition for mlocking large anon folios is 1) within range 2) fully
> mapped 3) not shared (mapcount is 1). The final patch should look like
> something like this:
> 
> -  if (folio_test_large(folio))
> +  if (folio_pfn(folio) != pte_pfn(ptent))
> +    continue;
> +  if (!the_aforementioned_condition())
> 
> There is another corner case I forgot to mention: for example, what if
> a folio spans two (the only two) adjacent mlocked vmas? No need to
> worry about this since it's not worth optimizing.
