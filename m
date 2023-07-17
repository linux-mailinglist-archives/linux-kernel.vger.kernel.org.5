Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167D075709C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjGQXjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjGQXje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:39:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4029D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689637147; x=1721173147;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wWeJgjbj9SKq1Cl2WeQC5LghOjK1+Ineo84Zlmpc4Ow=;
  b=eh7MWro+oUSnevDseBD+q/CO+qPicpwdG49qq4BWNulO9Dgtc3hbE8Bf
   17ENVCP0bhcwFzZec6Qjvsx4k7ppXZP87lwftjN/z6n+Kzm5Pv6SP8Bja
   T/OkqTDDFuCqfehfPZGwFEAZ684iH7lQ9gAk3F12kfybgeI6+kCXRsUEt
   nyx5cHiORlrG04VDJmHE4Xq0wajvjiuASV7L3wlNWVmD0m3g68FQABN3L
   1CMS7/yPskjU9sI8XH3uP3Zn5ZrUnvjx3oiiUZ2WmwGYmds44Uu57KiO1
   83x66FSHNAC6/kGzdJdy3ofVE2w4WRiOzyLwfnl27zzh0dHCgU5wdXbiT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="452441708"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="452441708"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 16:38:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="1054057573"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="1054057573"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jul 2023 16:38:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 16:38:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 16:38:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 16:38:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 16:38:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqoVP6grH+fJaXT1Dbx0lCADDjzGRRWdmWp/T6gYbBtpD/y3LO9qx5H9R0uoN10PqsisHGuF+WYGEIG30KXXkimdXAZ9TOcSH9FZYhOkJDJ/6nEwCKBt7wteh9uQi+WFa1siAEd27kFRllCGSdLTNww4+jJ2GYovPYfSQeORDsFBuOJSfhmlP4jUoG5+aQ2zyQLJz46rQj1POTOHRgYn2Lpw8zHSBpwGcmI+wMGr6JH+jXQmh1fuawfYm7WQWdjX2CjjV+rlZ9p94ZYrDMi0oKRSplDGoRfb3SmLxIOPjJ2Gq/WtR5fCi8DYVHTVgKUoU7q64JKC3iTFr7Q8DYs0yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDJBK58winqIAd4EcTH+63e5KCxJvezlnYdFOFnRtEs=;
 b=h2XJXlrOJeXSmPEIqvzwE5BKcXOoR3b0lk23r1YMcGZ0c6jgMIX8v6gux7Ixvrmh0sMmhfYei58Sjrg1+hPb3EIz/nz/hCC/AR8bcnXsJyEdQmT7ihuLfuYBYQgVQe6f4TFVVPdD576egajJaKPReioSHmLLn1SZfwc6WP/RGN9dG4N6Ah1ZVIpGvmc0mD/Q/O+sPQNVFpsYxfkoPBqXNpBNka+gbS3MA+0Y14nFbpNaIaIVU9J/p9QUOG279077xtm3tqrIxoedHjRytop2AvnfHKXpy7A+HtUabrPbz3Iy/yu8k7nDuZOiVGh/pSvnDubh3i8i/HX2zYYUCpXtkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SJ1PR11MB6228.namprd11.prod.outlook.com (2603:10b6:a03:459::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 23:38:14 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 23:38:14 +0000
Message-ID: <e6dd6f96-b422-419f-3649-631108ffc32a@intel.com>
Date:   Tue, 18 Jul 2023 07:38:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] madvise: make madvise_cold_or_pageout_pte_range()
 support large folio
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>
CC:     David Hildenbrand <david@redhat.com>, Yu Zhao <yuzhao@google.com>,
        Minchan Kim <minchan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <ryan.roberts@arm.com>,
        <shy828301@gmail.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20230713150558.200545-1-fengwei.yin@intel.com>
 <CAOUHufb0zxKvmvEXfG4kySenxyPtagnr_cf4Ms-6si3bQTybGQ@mail.gmail.com>
 <8547495c-9051-faab-a47d-1962f2e0b1da@intel.com>
 <CAOUHufY-edD2j2Nfz3xrObF2ERAGKecjFr_1Qarh5aDwyDGS2A@mail.gmail.com>
 <d024fa03-ca51-632b-9a01-bbdc75543f5d@redhat.com>
 <6C3EFBC6-DC59-4167-B51A-7231A55FE1D5@nvidia.com>
 <eab84d78-6ae6-4db7-0474-35e439435913@intel.com>
 <83A53330-D068-40A3-BCE6-4039BC2C86D6@nvidia.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <83A53330-D068-40A3-BCE6-4039BC2C86D6@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SJ1PR11MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: f040b64e-45a3-4b5a-ba05-08db871ee3c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TsPnl7Qzql7MBDSxdqM0yPlYLGHrr8mwloaVcXfGDpSiOFbeD9U1jSqWF1YKoJEfQNgXs4Aw4uRfQF3iFLJ9r849Gg8u4sMCqBMISlKtYRIOSZ3i9ZcM4jo/cR7PYfTi+k9aBRfJDfbZ1bXHX4+9sLm8NOLOaLWqtpJ4TUTvQ8DxitpSY8f7eYO+uoGqEbVK+BOaWfJhYbe4CNQ3UCIwztxfCwmSb3cmXGpmh35RfN/YksPtSHcPGPTnHNT1UuV6+ohkz5VRx5AlkaQGkg9tcniT94Fz1qoXI55FhbmutNDS7hrPjAyRp8EwMB560bFg7jqlUUM4qVOGgBqWznsuj/2cwa9uBgqRtinSTojWv2hpeZuIJf2tdru8qGYdhmb8BPCgRapr8IuaNK53sq+1t/3lAUiVNWjjudL/bxOaGpCLCDwyU0GxIdwy34cTZ+s/hcNC5Yr0ZPZ48HmGOqyh7tm+UqasNC85TN7nwNBkdCK4wdgWcIEHogXhSCRpw9tQh2JZOVqGk1e2LlTCxshdvCHoGORyEXjSWDlH9WbMAKwG4TypcHNxXNZ1N7cz/AQQxkY1uKereOfHLCn31InE7iXLV5mDZBMVDuIWpumhRCsVQ0JdmTfUIiW3Uiy2EGCdKDj9Xh7n/k30QDRGG7K9pVMh4kRv3E5nyu5taG4fw6bYHJ7vkkwDdFyGywNOGA8X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199021)(2906002)(38100700002)(6512007)(966005)(82960400001)(83380400001)(2616005)(186003)(6506007)(26005)(5660300002)(31696002)(86362001)(53546011)(36756003)(8676002)(7416002)(4326008)(54906003)(478600001)(6486002)(316002)(41300700001)(6916009)(8936002)(66946007)(66556008)(66476007)(31686004)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHdyK1lndTNaN0ZiWndWamFQMC9sZ0RRd21nNkNCOWRxNktqOVpaK3QvSTNG?=
 =?utf-8?B?Wk1jUUxwTGNpcEo4NkpzNnVhYXJ1RWhGUlRjM1I4Z2tiWDU2WUhEV1IzVkhh?=
 =?utf-8?B?WFdGTVdRT3BKY1h3Wm5qb1UwRHRLQUkrNTZjWjJWUVFLdW9oY1pjMWp0YnVU?=
 =?utf-8?B?dk9KTzNLL2RJRWIwWDkrTDBIZWlPRS9rbzBLMnp2WitKMWw5dldnaklndUFH?=
 =?utf-8?B?N0NMejVxRGowQ1I4VTZac3cxSzNaeE83R1UvVXVKL0hZckhvN2lmY2dBR2dq?=
 =?utf-8?B?am05Z3gvUDFBbDBZZlRIRlBnM3NVakF2eWduYW9VWng4RVY5L3pDT00rUDFw?=
 =?utf-8?B?Ni9FU21oWm15aEx3ZnVFVFhpTC9BYVE4LzJMTnlNOTE1SlNYSDVxb294V1V2?=
 =?utf-8?B?T1FUMTJ5Z2ttdk94Q0E2MDcyTlRUNE5jUWpNYTNVNTR1cFFRMHAxVlA5cEZs?=
 =?utf-8?B?ajBOd1lxWjhvb1NtTm9pbG5qbThlQ21EN2ZqOWJBVTFPbStOMzczSFRzTkE1?=
 =?utf-8?B?VnNLdU94U3F5NWJkRUw4ZmRoYkN6d1VUU2ZEektNLzRtNDJGbG1EU0ZRcFpa?=
 =?utf-8?B?QzlxejhTSTlsVktwb1ZXZlNtMWZvTGJYUnNYb0hnY00veGhBb05JakVpQno4?=
 =?utf-8?B?UFREcWNaV2NBNzhMUHcyZGZtcHo3UWtPYzZ2RVlCT0ZrNW9uN2JVNmEycHF5?=
 =?utf-8?B?cDdmbGZwckY2RDNVSk1WVU0rL0tvYzloM3hTUktVcm8xSnJWcC9OeEZvMGR5?=
 =?utf-8?B?Yzh3Y2hUR1JEZ21mQ281UldHbnNkOFFNZW9YMDMxbzA1RkNJOWdmL25wM21M?=
 =?utf-8?B?YUFvR0phMDRPeWtOeGNQQUQ4TFVSMnM3RGJ6ekNmcmxWU0pDZ0NHbzVId3Z3?=
 =?utf-8?B?VjhNMWQvSnBVOFRWTUlxUHdKTEEyR1Jqb3dQVjdraERXUk8rVXp0TUkvanl2?=
 =?utf-8?B?ekptOElDejUvVnlreC90dmRZM05tQnBsSi9QNHRNL0NrK0dXZFg0VnQ4aW1Q?=
 =?utf-8?B?OE96Q0FXSEV6OTFvblIxTDMyZVJidTAvajlnL3ppck4ydXYrbXZuVHgzZ3p2?=
 =?utf-8?B?dnowK3YrQk85dzdJSllHRCt1L0dYWUtqNDRQRHJpaHpWMFJWU283RTNocVpS?=
 =?utf-8?B?UldURE1ZaGFsaW1Pckgxa0w2V3Y3VVBPM1VSOEoyNDAzTkx2ODA5LzVPVGxR?=
 =?utf-8?B?WWZhczhobTc5SXpSNnlPWFpRNTMxNUp0aWttNWZROWs0Q1hqdGtHN2NEaXo3?=
 =?utf-8?B?SHB5OGdHbFNOaHd5VjJIek5uZ01GSTdCWXJOanFMVlJkaGdDd1RuUHNlUURL?=
 =?utf-8?B?aEdvMG5vMUZwemhxdEhuZGhhSEZLUVBORlRhVUN1S0Q2aDA2KzBQcnFCT1Er?=
 =?utf-8?B?d09peHVWQlRmekpYdnNBRmp6aWxMNDBMSitZaS9kZ3pCOFhRMHd4K0dzYUlE?=
 =?utf-8?B?OUZiNE5qU3IwKyttaGppMFl5c3BxZEFnNWhwY2tlb0tQL1dKeDFLMGpiNkph?=
 =?utf-8?B?NGFZUGNsMGRuYU56VFE4TkhJVjlHOWhIckxaNG13ZjRETlpoTU9sTFl2c0pU?=
 =?utf-8?B?SVk1OC94S2oxQXB4MWd4cFN4eE83QzVEUlM3NEZwVEQ5cUlhVGxJd0Z5NTNo?=
 =?utf-8?B?Y3VBQXFiWWN0c2hyNHdiQlptUEZoV2JzTkdNd0l3MUdsNld1c2p3cXJHRDR5?=
 =?utf-8?B?WjRveWd2MWxvTW05S0NORm9aMjg0U0NGMmphZERIZ2Q2TjNyVFVSVjF0MVZU?=
 =?utf-8?B?MUYvYXdXaTVPMFdQdWR3aWdIaEV4MDNObnVVVnFRdUh2L2sxSENFbU5tSlRQ?=
 =?utf-8?B?eUhBcUZkOWY0T2hYYU5ISkQxNm1HVmxJMno2NXo1UHYzSitjRjN0U3BqaEs2?=
 =?utf-8?B?RlZ0Y1llMDlWVFNRTnlKTE5QZENpMWIvU2NiSGJsMThVQmRUUEhxbG1ic1Zz?=
 =?utf-8?B?WUxSOEpQSkpPalZBMzgySDVldVNXMFBUdXhCZTlmZUl5WktMZEdTeHlUVU1n?=
 =?utf-8?B?LzhDZE5ocERSNWJkTGQ5K0drMkJ6MnBkckRucnVya1dLNUNGUWEyajRVZkZ5?=
 =?utf-8?B?WDdtOUFqN1dpNXBkb2hKZEhrcGVWS3FidDVhY2gxbERFZE1DYjRBZVFjTkhp?=
 =?utf-8?B?aVFKb2hFcUR6OCtiZ3dDSU1RWHVFZHY2cGR0K0pLbjd6cnJ3VGhBRWxPNDRT?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f040b64e-45a3-4b5a-ba05-08db871ee3c9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 23:38:14.6291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cYFBQIYNkqeXpjWv2JkslQ1nGoR+gmUuNuz5lETmUEdjXsThDzaI2m5zPLJpf/O09to/AGvZSNBrSDxCw3G+ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6228
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/23 22:38, Zi Yan wrote:
> On 16 Jul 2023, at 20:15, Yin, Fengwei wrote:
> 
>> On 7/14/2023 10:41 PM, Zi Yan wrote:
>>> On 14 Jul 2023, at 3:31, David Hildenbrand wrote:
>>>
>>>> On 14.07.23 05:23, Yu Zhao wrote:
>>>>> On Thu, Jul 13, 2023 at 9:10 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 7/14/2023 10:08 AM, Yu Zhao wrote:
>>>>>>> On Thu, Jul 13, 2023 at 9:06 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>>>>>
>>>>>>>> Current madvise_cold_or_pageout_pte_range() has two problems for
>>>>>>>> large folio support:
>>>>>>>>    - Using folio_mapcount() with large folio prevent large folio from
>>>>>>>>      picking up.
>>>>>>>>    - If large folio is in the range requested, shouldn't split it
>>>>>>>>      in madvise_cold_or_pageout_pte_range().
>>>>>>>>
>>>>>>>> Fix them by:
>>>>>>>>    - Use folio_estimated_sharers() with large folio
>>>>>>>>    - If large folio is in the range requested, don't split it. Leave
>>>>>>>>      to page reclaim phase.
>>>>>>>>
>>>>>>>> For large folio cross boundaries of requested range, skip it if it's
>>>>>>>> page cache. Try to split it if it's anonymous folio. If splitting
>>>>>>>> fails, skip it.
>>>>>>>
>>>>>>> For now, we may not want to change the existing semantic (heuristic).
>>>>>>> IOW, we may want to stick to the "only owner" condition:
>>>>>>>
>>>>>>>    - if (folio_mapcount(folio) != 1)
>>>>>>>    + if (folio_entire_mapcount(folio) ||
>>>>>>>    +     (any_page_within_range_has_mapcount > 1))
>>>>>>>
>>>>>>> +Minchan Kim
>>>>>> The folio_estimated_sharers() was discussed here:
>>>>>> https://lore.kernel.org/linux-mm/20230118232219.27038-6-vishal.moola@gmail.com/
>>>>>> https://lore.kernel.org/linux-mm/20230124012210.13963-2-vishal.moola@gmail.com/
>>>>>>
>>>>>> Yes. It's accurate to check each page of large folio. But it may be over killed in
>>>>>> some cases (And I think madvise is one of the cases not necessary to be accurate.
>>>>>> So folio_estimated_sharers() is enough. Correct me if I am wrong).
>>>>>
>>>>> I see. Then it's possible this is also what the original commit wants
>>>>> to do -- Minchan, could you clarify?
>>>>>
>>>>> Regardless, I think we can have the following fix, potentially cc'ing stable:
>>>>>
>>>>> -  if (folio_mapcount(folio) != 1)
>>>>> +  if (folio_estimated_sharers(folio) != 1)
>>>>>
>>>>> Sounds good?
>>>>
>>>> Adding to the discussion, currently the COW selftest always skips a PTE-mapped THP.
>>>>
>>>>
>>>> For example:
>>>>
>>>> # [INFO] Anonymous memory tests in private mappings
>>>> # [RUN] Basic COW after fork() ... with base page
>>>> ok 1 No leak from parent into child
>>>> # [RUN] Basic COW after fork() ... with swapped out base page
>>>> ok 2 No leak from parent into child
>>>> # [RUN] Basic COW after fork() ... with THP
>>>> ok 3 No leak from parent into child
>>>> # [RUN] Basic COW after fork() ... with swapped-out THP
>>>> ok 4 No leak from parent into child
>>>> # [RUN] Basic COW after fork() ... with PTE-mapped THP
>>>> ok 5 No leak from parent into child
>>>> # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
>>>> ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
>>>> ...
>>>>
>>>>
>>>> The commit that introduced that change is:
>>>>
>>>> commit 07e8c82b5eff8ef34b74210eacb8d9c4a2886b82
>>>> Author: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>>>> Date:   Wed Dec 21 10:08:46 2022 -0800
>>>>
>>>>     madvise: convert madvise_cold_or_pageout_pte_range() to use folios
>>>>
>>>>     This change removes a number of calls to compound_head(), and saves
>>>>     1729 bytes of kernel text.
>>>>
>>>>
>>>>
>>>> folio_mapcount(folio) is wrong, because that never works on a PTE-mapped THP (well, unless only a single subpage is still mapped ...).
>>>>
>>>> page_mapcount(folio) was wrong, because it ignored all other subpages, but at least it worked in some cases.
>>>>
>>>> folio_estimated_sharers(folio) is similarly wrong like page_mapcount(), as it's essentially a page_mapcount() of the first subpage.
>>>>
>>>> (ignoring that a lockless mapcount-based check is always kind-of unreliable, but that's msotly acceptable for these kind of things)
>>>>
>>>>
>>>> So, unfortunately, page_mapcount() / folio_estimated_sharers() is best we can do for now, but they miss to detect some cases of sharing of the folio -- false negatives to detect sharing.
>>>>
>>>>
>>>> Ideally we want something like folio_maybe_mapped_shared(), and get rid of folio_estimated_sharers(), we better to guess the exact number, simply works towards an answer that tells us "yep, this may be mapped by multiple sharers" vs. "no, this is definitely not mapped by multiple sharers".
>>>>
>>>> The "mapped" part of it indicates that this does not catch all cases of sharing. But it should handle most of the cases we care about.
>>>>
>>>>
>>>> There, we can then implement something better than what folio_estimated_sharers() currently does:
>>>>
>>>> static inline bool folio_maybe_mapped_shared(folio)
>>>> {
>>>> 	if (likely(!folio_test_large(folio)))
>>>> 		return atomic_read(&folio->_mapcount) > 0;
>>>>
>>>> 	/* Mapped multiple times via PMD? */
>>>> 	if (folio_test_pmd_mappable(folio)
>>>> 		return folio_entire_mapcount() > 1;
>>>>
>>>> 	/*
>>>> 	 * First subpage is mapped multiple times (especially also via
>>>> 	 * PMDs)?
>>>>          */
>>>> 	if (page_mapcount(folio_page(folio, 0) > 1)
>>>> 		return true;
>>>>
>>>> 	/* TODO: also test last subpage? */
>>>> 	
>>>> 	/* Definitely shared if we're mapping a page multiple times. */
>>>> 	return folio_total_mapcount(folio) > folio_nr_pages(folio);
>>>> }
>>>>
>>>> There are some more things we could optimize for.
>>>
>>> Before jumping into the mapcount, I would like to get some clarification
>>> on "sharer". Does it mean a page is mapped/shared by more than one page
>>> table entry or is mapped/shared by more than one process? Your function
>>> indicates it is the former, but for madvise_cold_or_pageout_pte_range(),
>>> I am not sure that is what we want. What if user wants to page out a
>>> page that is mapped by the same process twice? With current method
>>> or any existing proposals, it will fail undesirably. It will only work
>>> as expect with your creator proposal[1].
>> My understanding here is more than one page table entry based on:
>>   - Original code use mapcount() for normal 4K page. It's for page table.
> Yes.
> 
>>   - If user wants to page out a page mapped to same process twice, maybe
>>     madvise_pageout() should be called twice for different mapping address.
> 
> That could be a reasonable way of handing it, but current code bails out
> once it finds a folio is mapped more than once. This means a process cannot
> page out any page mapped twice no matter if it is mapped to the same process
> or not. Maybe it is worth some clarification in the manpage for this behavior.
This is just a thought when I read this part of code. Especially for mapcount
constrain. Like if the mapcount is larger than 1, unmap the page from the
VMA requested by the syscall this time.

But I am lack of understanding to the user case of this syscall. So it may
be total wrong.

> 
> 
>>   - It has more chance to fail reclaiming if pages mapped twice in page
>>     table entry. And more chance to be faulted in again.
> Only if madvise_cold_or_pageout_pte_range() unmaps the page regardless of
> its mapcount.
This is just my guess why only handle mapcount ==1 case. 


Regards
Yin, Fengwei

> 
> 
> --
> Best Regards,
> Yan, Zi
