Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F6575BCBB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 05:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjGUDTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 23:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjGUDTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:19:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D58272A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 20:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689909555; x=1721445555;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HfZVuBjmzf8k2nk4Gsk1ECMQW/eN8PwP+f4Kka1WvjY=;
  b=nRUIfC8+8F9Xm7d16k8k5rPzc5CIQs27kPe8XFyOYk0Byy088gm2l389
   Sg1s3xQbF6bUoM/s4hhB63fWsMaeSFuFO3GS4Dq+m+ENpdWoVLVSsD5Ds
   1feXuIRIDGfuY/cDSXk4w/NBOaIkKbScWaPwYfslbzX4F/rr4DBcjJVm1
   KyQusRBbK6Jo1ZYkhcrpVDIYkBnKV65yu+rgAhkyD0KzC9Peu5PHKLH+L
   /MaRDmr/9PJsS5oakNvK1amIM5Pfq0GGiiQ7C8Ub1mQEGkf+7+hfixk9q
   2WQAjwLq8d7Hw02XuJLRPa+4Pn2PZKbp/mUSSWJ39Qni0QGUOBf+TTvpe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="453301109"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="453301109"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 20:19:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="759803602"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="759803602"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 20 Jul 2023 20:19:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 20:19:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 20:19:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 20:19:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0PmSiB63NaER3239aVO/vlYPa+VRH7ZZ2t9f1jy0nI0WhOKqAnBWAcmhNHyw4ZziDovKolBjuOTBPQCGM39hxJfRjb47BbMyUD6xhE25vyiGdUyqx0D2cy7r9t0b3bmu8Ef5QT4PXSdz/kcF7avMG/cAHoohnZcFOF6bsO8OCIIHWP2NAXXQA/BImUjWE/CqOMICaS16+KBc8zJlUoHhBszMMSvoBS9V0iWrl2BbuJaVeF0VpAOlUaBfSBCie3qEIJqlPZCK9PSsnURWN6qt9/2aUQ521SqdVZM5wO9y9RAiWXuJMJoCb7RIVjKWOksXnvtwiMOxD3LFHUjoG49Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C411Cb5ZhKhgISYo/Lm7gUCi4B3poYoZqGDIHZrcDDQ=;
 b=oVkW8QpasRqZNqD0fzLru3V/m62DdzOtgGhWuZaN356uJ/Mq4d+nuIzDEiCnlFTaIOXEQYrkxqNZy3c8o4MFEv3vk+3DAlIr0GQ2dwYLozn07TqsXl7HMkMBmgayHsGwpust9hqX53LJIbaZdHLz7atkaD9oQqM9oUvxrOhFSk3UT6bKbdyFHmGVxh1l9NxwTV14u0iq8yg8rAHjjlurLE6CcvvERCgwh13hsU1VFb/Q6sgzFJizph8NpD+kwKfFAm2OwoCngp9Q1PMEOpvzPugtg3n6JJDgrg8vECP+Va0zWEb/MVH4EQybO9OiQRz+4LVuoF1mYoWj9vM++vIGHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH7PR11MB6497.namprd11.prod.outlook.com (2603:10b6:510:1f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 03:19:06 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e%5]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 03:19:06 +0000
Message-ID: <c9b53e12-80bc-7447-af2e-71920e4179d0@intel.com>
Date:   Fri, 21 Jul 2023 11:18:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 3/3] mm: mlock: update mlock_pte_range to handle
 large folio
To:     Yosry Ahmed <yosryahmed@google.com>
CC:     Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <david@redhat.com>, <ryan.roberts@arm.com>, <shy828301@gmail.com>
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <CAJD7tkYAkVOE2caqEj_hTmm47Kex451prBQ1wKTRUiOwnDcwNA@mail.gmail.com>
 <b995e802-1500-6930-79d0-8cc4bfe89589@intel.com>
 <CAJD7tkZtHku-kaK02MAdgaxNzr9hQkPty=cw44R_9HdTS+Pd5w@mail.gmail.com>
 <CAJD7tkZWXdHwpW5AeKqmn6TVCXm1wmKr-2RN2baRJ7c4ciTJng@mail.gmail.com>
 <208aff10-8a32-6ab8-f03a-7f3c9d3ca0f7@intel.com>
 <CAJD7tkYT6EZMwit8C9MTftUxMmuWtn2YpZ+NSVhy0xVCYuafsg@mail.gmail.com>
 <438d6f6d-2571-69d9-844e-9af9e6b4f820@intel.com>
 <CAJD7tkYWH8umBFgmxPmeOkRF=pauVW=MvyyN+z17XMHN+q8JKg@mail.gmail.com>
 <e3044d46-3b38-dc2e-b8d2-8ec1033f85e7@intel.com>
 <79f6822-f2f8-aba4-b517-b661d07e2d@google.com>
 <CAJD7tkaMycnAaY-8Gu=kUwbYqDzihP4BQDzCC2M4BTYAKgG6Qg@mail.gmail.com>
 <d2ae87ee-8ee3-0758-a433-8c937e5e3fb5@intel.com>
 <CAJD7tkbuU9Op_TmUET9N+Mug=AS7N3S16tZifVajVBL0yaYv4w@mail.gmail.com>
 <c8ea2617-df48-a1cf-e910-71eeba353d67@intel.com>
 <CAJD7tkYH-9YoLMSc4RLd0P4hmMcV4mzko8oijLXNOA_dquHJqA@mail.gmail.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAJD7tkYH-9YoLMSc4RLd0P4hmMcV4mzko8oijLXNOA_dquHJqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH7PR11MB6497:EE_
X-MS-Office365-Filtering-Correlation-Id: ce72024f-f602-4bc5-0c02-08db89993dc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lXKAS1yUSysbzx6xBLzUqnnI76OzyFxdjBmZ2DGf3NjitOCqNHvqVTCvlY5hC3oHOqTB6pfY8y/yQPH+SkJKUi2k6yqdNHCnnbrjosIpJoXFpG9MWEzys+6UkSp7HDd9WJ/hto7YE9jwEFsLfWevgj8/YxUQvCkM0k5vLd3SIF0HUPlH9cfe7TOvLWfy0TDF1ROEUgmyAsnGm1FRuKkKzPjiRAyuUDmx17kwbsOO4K7h/ybiZJ594lXz9EhhHscXb+EwZ4BX/qErgZKf6M3t8MPjrsE9B/Ouypb169a237Rpzz+k+M87dhFgEE7uvxHbTDtecjii/pWEiZAVpnB8RRT/XM7gEesHLbuX4E4fEcfJs34zyAf7+sQrPxbWaZc6xK+YgN3LPrG6kiG0A964O5pg7f+rbgua5N7Q7YJnV3foad1pIEJ6lwGtE7TG4fFNZdJ/ORFYkx8g+IoDw2LeFtrzMbJVKR5M4cm7Vj1ONSUYWvyenpxRlZLdD58mvp2W8RU4IKEF3uz/WNS1qfCE20OAMr6EZxY04jWJp2E14LlW+/lXdUpJUyJuv0+TJDw8YZZlDJj4LufcOUoChxE+k0T2KQhpp7fbQCX9+MgVrlHnpsAQAmQ0QagWaclb3UKFx39psgT721ttaA1xAGg4Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(83380400001)(2616005)(2906002)(15650500001)(38100700002)(82960400001)(66556008)(316002)(66946007)(478600001)(4326008)(6486002)(6916009)(53546011)(41300700001)(6506007)(26005)(186003)(66476007)(31686004)(6512007)(54906003)(31696002)(36756003)(5660300002)(8936002)(8676002)(86362001)(7416002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEI1bzUxRkhMblpZU1djQnZrcEF6WGd4UmhybCtENkIxTjJoem93SnBoRmVo?=
 =?utf-8?B?SUFaWTRSSEVuTm1UMCtEc2ZuUVlkOUhJMG01RUVNUTN5aWY2OUJBQ2RGT3Jw?=
 =?utf-8?B?VmE0bGx1c21OQzNhc2lSejAxaGVISnVGTm1yUVdkSVlNeUU4Mi9LOW8xN0dr?=
 =?utf-8?B?T0l4S0hIWXpJMnVhejVDeVRiQ1c4aFlmK3lFRXdjd3Q5ZlFBV0pmQ3hZbmRl?=
 =?utf-8?B?dHlaMkkrNkJjdWR5R213MHI2V1Zydis4ZWxubnJ5cUthUmF3RmhmR2QxQTI4?=
 =?utf-8?B?N3hUbFdTVUlKWktFY0JVT3JnKysyOTNWVXBuNTVxbUtCYUNZcjlGRmJmcEVm?=
 =?utf-8?B?bTJiVUxBVzBMQTZSV1UxOEhlb1hkd3ErZ09iZlRkRG5ZdGVtMDF1WWNhOUJo?=
 =?utf-8?B?blBrYStxOExJOWhxUE1uU3FQOG0xWkRoT1E2NVJBdnczSnROaTdJMWdxMkJX?=
 =?utf-8?B?aWRDZlRSOVlyVlJ6bFltYVNqaVlhNTg5citub3lJUGxRTUg3aW5keFdXZjBE?=
 =?utf-8?B?NkRvODRUMDZEQkt0MjJaNUREa2NYMkk0VkxIbDZpaXBXRy9aUlF6WDZUdEpX?=
 =?utf-8?B?a2pJWkhTL2JjS3pLdjVNcmdWRWE2eHZFZ2lvSDJzMUQzTjVnUGZvMHFCTi9l?=
 =?utf-8?B?enVGRGxBNkRJYlhWbGR4UWdBOThySlRsb3ROTTdUQWdZVXFLdEN6SFVkdVp5?=
 =?utf-8?B?OU9kUlprR1hBdTNzU2NvWWVmY3lVL0hkY1Myd0thcFpxYzFNY2ovYnJvODZs?=
 =?utf-8?B?TGlaY29od1d6SjRTd2tMQmRCcnBFSXVTdVdlc2V0VlBaRmt4dFZhUk42OURS?=
 =?utf-8?B?L0IzR1lRWVZQYjl1K2tCR0N4aHJHc3NlV0ZPaEt1WXFJR3dSMkcrS00reUNy?=
 =?utf-8?B?V203WUg2bUZ3UXZ2MDBLRkE1TWt6eU00a0RGY1BRdFA1TTVpWngzMmExR1ox?=
 =?utf-8?B?SzdpcE9EL2x0QThOSktFNVJ4RVN6NnVEeStnK1M0T1hTaXpaQVZNZWhzc1JR?=
 =?utf-8?B?N2VKOStSaGxtenJuUjBCN3BCTG11b1VjNXJDUHBRcXRFaGN0S2VGWFU3NGFJ?=
 =?utf-8?B?K1NPbWxZMFZvYjBVU1BZdW5lT05MbXpOcE1JV2VJZXFZZEdYdVNwQnUvellC?=
 =?utf-8?B?WUN3cXJlMStoSTdKT3lzOFZOemtzZFUwQzMreHZkcmZ3d1lKbU5hY1FiVks5?=
 =?utf-8?B?YUxGcHl1bzd0WW1yd011ZVVZOUxDaEJKL3MrWGdHaU9kQU1XcURBM3NXUnAv?=
 =?utf-8?B?bHBZTklrMWRmUmxGaHFmalJOT2pqSjI0aTM2RS9yM0NSTko1dkg4K2Y1NWdH?=
 =?utf-8?B?UEZFQVNuMDdrYStYdTZoVDh0RXo3R3JiVXY0R24rc2xyQktUcS9Jd1NQa1N6?=
 =?utf-8?B?SGZzR2dZLzl3VEwxdEtpYUJnb2xtY01hSnNLNDc0czhzZW5hK3lBWmZJdUhx?=
 =?utf-8?B?ZmYwR2lzbFpTaGdydEE1YXRwbHh1OG9Jd2ROWUgwNjBGNDNobjlnK1F2NmRI?=
 =?utf-8?B?bkM1MFZYUnVDZVNXRkxGbFRVaVZtMWtWb2xxN0JlZlNWMDhsSEdoT3J2Qzhs?=
 =?utf-8?B?R2ZPRTRjdU01SGpuNjhhZmpXd0hPQlhzYlRlT3Jtb2NoOWx3SlExY0ZXMHlF?=
 =?utf-8?B?cVIvVDFkcTZkMzF1aWtYcnpaN2lxTGdDclB2aVJSeHQrOG4zQUNNR0orVmdv?=
 =?utf-8?B?RDFpc3lRWkJJd1FiNmo2aFhkR0p2VG56NTMvQXBIVWJlZVpRMENQYW9YVEI2?=
 =?utf-8?B?Zk4rUG1PN2VucENlLzA3OWx6K3RhVFB0dGs3SHdoUDNwczZwQTNvL3ZvNjBR?=
 =?utf-8?B?c0gzR1lYdWcxQlhPMU9vaDlwK0QvMUxiNHFkSWxYVkZndVh4Vmpic0NrdWcy?=
 =?utf-8?B?NmFjaFpvZGRQaC9kWFJwSUhwQkNoZmxzb3pKNDJRczBpKzFseTVVeHpiTEM4?=
 =?utf-8?B?OHpRMWpZY0U4VWQwaFZaRmkvME8wa0UySmFpbTI3VEoyQVc4alR4bCsyZ2lI?=
 =?utf-8?B?RDlvZi93a2lpaTlxZlhYS1VuTVlxbzVOemVJbDVVeTFEQU55ZFd5K1YwajZW?=
 =?utf-8?B?MXNpdnIxTXdhK2FJZWFSRis5VEc5Z2JyTVpKRE5RcEhSSmZTZ294QWlsbDlD?=
 =?utf-8?Q?NUg78A2WwZicKxmHqrzkq95IL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce72024f-f602-4bc5-0c02-08db89993dc1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 03:19:06.3226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JUAeaCk2Ixv1j33M+1R2XofX8HE+7Dxe8tpOVD4XY8IjwG4HypqjOegdBnGyR1A1Do2Z16Vq54jorUO9lnbbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6497
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



On 7/21/2023 9:35 AM, Yosry Ahmed wrote:
> On Thu, Jul 20, 2023 at 6:12 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>
>>
>>
>> On 7/21/2023 4:51 AM, Yosry Ahmed wrote:
>>> On Thu, Jul 20, 2023 at 5:03 AM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 7/19/2023 11:44 PM, Yosry Ahmed wrote:
>>>>> On Wed, Jul 19, 2023 at 7:26 AM Hugh Dickins <hughd@google.com> wrote:
>>>>>>
>>>>>> On Wed, 19 Jul 2023, Yin Fengwei wrote:
>>>>>>>>>>>>>>>> Could this also happen against normal 4K page? I mean when user try to munlock
>>>>>>>>>>>>>>>> a normal 4K page and this 4K page is isolated. So it become unevictable page?
>>>>>>>>>>>>>>> Looks like it can be possible. If cpu 1 is in __munlock_folio() and
>>>>>>>>>>>>>>> cpu 2 is isolating the folio for any purpose:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> cpu1                        cpu2
>>>>>>>>>>>>>>>                             isolate folio
>>>>>>>>>>>>>>> folio_test_clear_lru() // 0
>>>>>>>>>>>>>>>                             putback folio // add to unevictable list
>>>>>>>>>>>>>>> folio_test_clear_mlocked()
>>>>>>>>>>>>                                folio_set_lru()
>>>>>>> Let's wait the response from Huge and Yu. :).
>>>>>>
>>>>>> I haven't been able to give it enough thought, but I suspect you are right:
>>>>>> that the current __munlock_folio() is deficient when folio_test_clear_lru()
>>>>>> fails.
>>>>>>
>>>>>> (Though it has not been reported as a problem in practice: perhaps because
>>>>>> so few places try to isolate from the unevictable "list".)
>>>>>>
>>>>>> I forget what my order of development was, but it's likely that I first
>>>>>> wrote the version for our own internal kernel - which used our original
>>>>>> lruvec locking, which did not depend on getting PG_lru first (having got
>>>>>> lru_lock, it checked memcg, then tried again if that had changed).
>>>>>
>>>>> Right. Just holding the lruvec lock without clearing PG_lru would not
>>>>> protect against memcg movement in this case.
>>>>>
>>>>>>
>>>>>> I was uneasy with the PG_lru aspect of upstream lru_lock implementation,
>>>>>> but it turned out to work okay - elsewhere; but it looks as if I missed
>>>>>> its implication when adapting __munlock_page() for upstream.
>>>>>>
>>>>>> If I were trying to fix this __munlock_folio() race myself (sorry, I'm
>>>>>> not), I would first look at that aspect: instead of folio_test_clear_lru()
>>>>>> behaving always like a trylock, could "folio_wait_clear_lru()" or whatever
>>>>>> spin waiting for PG_lru here?
>>>>>
>>>>> +Matthew Wilcox
>>>>>
>>>>> It seems to me that before 70dea5346ea3 ("mm/swap: convert lru_add to
>>>>> a folio_batch"), __pagevec_lru_add_fn() (aka lru_add_fn()) used to do
>>>>> folio_set_lru() before checking folio_evictable(). While this is
>>>>> probably extraneous since folio_batch_move_lru() will set it again
>>>>> afterwards, it's probably harmless given that the lruvec lock is held
>>>>> throughout (so no one can complete the folio isolation anyway), and
>>>>> given that there were no problems introduced by this extra
>>>>> folio_set_lru() as far as I can tell.
>>>> After checking related code, Yes. Looks fine if we move folio_set_lru()
>>>> before if (folio_evictable(folio)) in lru_add_fn() because of holding
>>>> lru lock.
>>>>
>>>>>
>>>>> If we restore folio_set_lru() to lru_add_fn(), and revert 2262ace60713
>>>>> ("mm/munlock:
>>>>> delete smp_mb() from __pagevec_lru_add_fn()") to restore the strict
>>>>> ordering between manipulating PG_lru and PG_mlocked, I suppose we can
>>>>> get away without having to spin. Again, that would only be possible if
>>>>> reworking mlock_count [1] is acceptable. Otherwise, we can't clear
>>>>> PG_mlocked before PG_lru in __munlock_folio().
>>>> What about following change to move mlocked operation before check lru
>>>> in __munlock_folio()?
>>>
>>> It seems correct to me on a high level, but I think there is a subtle problem:
>>>
>>> We clear PG_mlocked before trying to isolate to make sure that if
>>> someone already has the folio isolated they will put it back on an
>>> evictable list, then if we are able to isolate the folio ourselves and
>>> find that the mlock_count is > 0, we set PG_mlocked again.
>>>
>>> There is a small window where PG_mlocked might be temporarily cleared
>>> but the folio is not actually munlocked (i.e we don't update the
>>> NR_MLOCK stat). In that window, a racing reclaimer on a different cpu
>>> may find VM_LOCKED from in a different vma, and call mlock_folio(). In
>>> mlock_folio(), we will call folio_test_set_mlocked(folio) and see that
>>> PG_mlocked is clear, so we will increment the MLOCK stats, even though
>>> the folio was already mlocked. This can cause MLOCK stats to be
>>> unbalanced (increments more than decrements), no?
>> Looks like NR_MLOCK is always connected to PG_mlocked bit. Not possible
>> to be unbalanced.
>>
>> Let's say:
>>   mlock_folio()  NR_MLOCK increase and set mlocked
>>   mlock_folio()  NR_MLOCK NO change as folio is already mlocked
>>
>>   __munlock_folio() with isolated folio. NR_MLOCK decrease (0) and
>>                                          clear mlocked
>>
>>   folio_putback_lru()
>>   reclaimed mlock_folio()  NR_MLOCK increase and set mlocked
>>
>>   munlock_folio()  NR_MLOCK decrease (0) and clear mlocked
>>   munlock_folio()  NR_MLOCK NO change as folio has no mlocked set
> 
> Right. The problem with the diff is that we temporarily clear
> PG_mlocked *without* updating NR_MLOCK.
> 
> Consider a folio that is mlocked by two vmas. NR_MLOCK = folio_nr_pages.
> 
> Assume cpu 1 is doing __munlock_folio from one of the vmas, while cpu
> 2 is doing reclaim.
> 
> cpu 1                                        cpu2
> clear PG_mlocked
>                                                  folio_referenced()
>                                                    mlock_folio()
>                                                      set PG_mlocked
>                                                        add to NR_MLOCK
> mlock_count > 0
> set PG_mlocked
> goto out
> 
> Result: NR_MLOCK = folio_nr_pages * 2.
> 
> When the folio is munlock()'d later from the second vma, NR_MLOCK will
> be reduced to folio_nr_pages, but there are not mlocked folios.
> 
> This is the scenario that I have in mind. Please correct me if I am wrong.
Yes. Looks possible even may be difficult to hit.

My first thought was it's not possible because unevictable folio will not
be picked by reclaimer. But it's possible case if things happen between
clear_mlock and test_and_clear_lru:
    folio_putback_lru() by other isolation user like migration
    reclaimer pick the folio and call mlock_folio()
    reclaimer call folio

The fixing can be following the rules (combine NR_LOCK with PG_mlocked bit)
strictly.


Regards
Yin, Fengwei

> 
>>
>>
>> Regards
>> Yin, Fengwei
>>
>>>
>>>>
>>>> diff --git a/mm/mlock.c b/mm/mlock.c
>>>> index 0a0c996c5c21..514f0d5bfbfd 100644
>>>> --- a/mm/mlock.c
>>>> +++ b/mm/mlock.c
>>>> @@ -122,7 +122,9 @@ static struct lruvec *__mlock_new_folio(struct folio *folio, struct lruvec *lruv
>>>>  static struct lruvec *__munlock_folio(struct folio *folio, struct lruvec *lruvec)
>>>>  {
>>>>         int nr_pages = folio_nr_pages(folio);
>>>> -       bool isolated = false;
>>>> +       bool isolated = false, mlocked = true;
>>>> +
>>>> +       mlocked = folio_test_clear_mlocked(folio);
>>>>
>>>>         if (!folio_test_clear_lru(folio))
>>>>                 goto munlock;
>>>> @@ -134,13 +136,17 @@ static struct lruvec *__munlock_folio(struct folio *folio, struct lruvec *lruvec
>>>>                 /* Then mlock_count is maintained, but might undercount */
>>>>                 if (folio->mlock_count)
>>>>                         folio->mlock_count--;
>>>> -               if (folio->mlock_count)
>>>> +               if (folio->mlock_count) {
>>>> +                       if (mlocked)
>>>> +                               folio_set_mlocked(folio);
>>>>                         goto out;
>>>> +               }
>>>>         }
>>>>         /* else assume that was the last mlock: reclaim will fix it if not */
>>>>
>>>>  munlock:
>>>> -       if (folio_test_clear_mlocked(folio)) {
>>>> +       if (mlocked) {
>>>>                 __zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
>>>>                 if (isolated || !folio_test_unevictable(folio))
>>>>                         __count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
>>>>
>>>>
>>>>>
>>>>> I am not saying this is necessarily better than spinning, just a note
>>>>> (and perhaps selfishly making [1] more appealing ;)).
>>>>>
>>>>> [1]https://lore.kernel.org/lkml/20230618065719.1363271-1-yosryahmed@google.com/
>>>>>
>>>>>>
>>>>>> Hugh
