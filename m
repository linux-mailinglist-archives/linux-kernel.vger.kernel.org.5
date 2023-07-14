Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE48753519
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbjGNIfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbjGNIeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:34:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E079F1BF4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689323687; x=1720859687;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I4L4JfuR3JZVa+z3t6T3xIqnUuvyUN6ETQPXJ78SUOA=;
  b=AavsWzfuM9wgZfxHPAHQNEC1h2VTs0JFJdZU0k/fERaejZJzGup0pb2Y
   0+JbNRpZzW5HpmJRQMYn46Vr0B8sLv3YX1viyXcPfmXM1ZBydeSg1Qp2a
   aja4rXJXITDb70wlXIxj8pni7G3ri6IOHdWulqWB9Be2ZH9mDyCQAwflE
   midNPux4NI4vM9Z4SmoWg8AVhMiovzT0rlGUEMrJ7hXXeGmNMcq9cTnJn
   6GHPln+TDWp44j/sNE4GsE5jGwtObpQXhBv5N32GLA+cCjteo+M+/b605
   +bzLfWM4SuvLHpbUs3saB4ZFV6JmjaRth5xvcZCAMkLSM25Vt1yHJjhbF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="350294819"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="350294819"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 01:34:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="812343782"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="812343782"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jul 2023 01:34:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 01:34:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 14 Jul 2023 01:34:45 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 14 Jul 2023 01:34:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dg5K+W4l8qI21A8D3moMhXMknjAoXdn4MoNvpp0XqIIkspP4fpdX15HPEsMFqYGNEj8LTMSfrYa4zhaJHHRWkqTWKPYlu1vH68arYkVbiK7KJjah8GNGIUau/W0UszYOvGqNUzHnGXV8FJrDenOoFpBLj0o1lOWBXAsmBNZaxbhmGr0ozz2v+X3hpyjlqIlkJX7fWBilAwwAG2+yjQumgoEPKn4HkAB3b44KFHRwEb2tyo7zOFGwfjM8O1buAl4B3rxBxfOKzkzXlvmuTYlckvc0H5cAnqIoEDZJCNs3IDjK9Skq7tSuF9SSSd5S+rDng5cRe11JvoheqkoADirxJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbOy9A7F1wlGHvKVbXrKT8wyT+w9pxG/8y+LD5BwGow=;
 b=kaP90jn9ISQfgW2E/zYxG//N+sl+p1Nxsj/8DLipQgVnitnIF7ayMiLaQWQLf6qB2ZevRd0QtJjZf1SsHCfl4FmzLblcRZkFUvabX/W867flrPRiwUcP5ilooIN8G9LKxSw8SPiRb8hgVnldMe+wDvZQPdZbYu786iknCM+v7hw5JGr3hvs8ks2DLnt5xWtHgV3h6x5MhnyyAYb0j+EheitrpEVf3XecCI1HuRf6AvB4CqQ/xY9M5x5foX2Rtkepaqfh5DN3H+Uc6BHq1P5Q//Lof//jysMc4bubzQoYFDFeJal/vR1deZmfFZhn2RtMO85UP6oH+gOi5ClG+QcnUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by BL3PR11MB6338.namprd11.prod.outlook.com (2603:10b6:208:3b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 08:34:38 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 08:34:38 +0000
Message-ID: <2cbf457e-389e-cd45-1262-879513a4cf41@intel.com>
Date:   Fri, 14 Jul 2023 16:34:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] madvise: make madvise_cold_or_pageout_pte_range()
 support large folio
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, Yu Zhao <yuzhao@google.com>,
        Zi Yan <ziy@nvidia.com>
CC:     Minchan Kim <minchan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <ryan.roberts@arm.com>,
        <shy828301@gmail.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20230713150558.200545-1-fengwei.yin@intel.com>
 <CAOUHufb0zxKvmvEXfG4kySenxyPtagnr_cf4Ms-6si3bQTybGQ@mail.gmail.com>
 <8547495c-9051-faab-a47d-1962f2e0b1da@intel.com>
 <CAOUHufY-edD2j2Nfz3xrObF2ERAGKecjFr_1Qarh5aDwyDGS2A@mail.gmail.com>
 <d024fa03-ca51-632b-9a01-bbdc75543f5d@redhat.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <d024fa03-ca51-632b-9a01-bbdc75543f5d@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|BL3PR11MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dda40a8-77f0-4f30-4c0e-08db8445293a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpbT3hUMEkFkxB/z9LqjOKQfakrpZVOvFJmzDrTnHpCAowRHBUBm6v+zg3bXl/oDleVqmnMARQI7H27YRaMGknaFx/aisKP7kd5s5XcwjPKygwqj8x+QOWe/z0JxlF4Hxuc9/7EhHPyTrgjHfn4OwCJpceN3ITb+kn8wN6Iu4bpOpcUQX6ql2TKEGqzSsf2yjfnYpod0JclJHGrGX8AtQsKcMZn2ZREZah3sZcbrzQqohhaYHgudBgd2+n124giufLO8Hz4+4rue7sQXirp4yvJiaOjZbziqJTdDj8dWqTIkLsUPe1JSqHGgFjdMii5lwPxTWBqeV2XYfIITbY6RzGy6+A3b+TwJu4HWkthGD9hj950UTcFwofyLP6tieyO+gODnKTgMh6BXvmF7lRk/Xj+nvmH4Mvrxf2avHb0+KVC/l1CMSLwDVRxI5kEXhwJSbh6IMk/zBtVyYqqd5ixkLKmBXWXEvMqbtO3QTbmGUswY5Wq6/rV5ILHOW5Z+ORPn+wUDlKdp+nLlTxbWKMvBlppfGTrzjvr23nzscKNCFl0yNyUKywCP/83YCun1sI1CdhIwYGeFTVD7jJDM5WMAZQF9rFWfNDDAH4DDIH6b0IFAtt+TuctVK0qTrEeyt364xpAbsFqQpE3ROdTx6RdSyK3EtA73fMls9ILHzF3OieYwp71ZkGr28a2k7CInGrLu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199021)(6512007)(966005)(6486002)(6666004)(83380400001)(186003)(2616005)(36756003)(38100700002)(31696002)(86362001)(82960400001)(26005)(53546011)(6506007)(66556008)(66476007)(4326008)(66946007)(7416002)(54906003)(110136005)(41300700001)(5660300002)(31686004)(316002)(8936002)(8676002)(66899021)(2906002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THVYcHdRU2VkbzcvYkUrMWRWRlp0M1orQ2dqRjNpUXdlMHJEY01ad1pGdzQr?=
 =?utf-8?B?RlU2R0VZYW9XMjZMWlhvUVZlMmNmZlFzU0V4MlFYSVZZbG5aRHBkUmtLVDFZ?=
 =?utf-8?B?RmMrMlorMTcwRUhaem9lTDYrVDV2dTk5bWlORUUzRW1QakJ3b3ZuVlRpRlUz?=
 =?utf-8?B?aE9ROFJGUVFxbGJhc0xlR1UwRjR6YWZmYVY2UWxPZDVZVmZWYTQwaGVXbVlJ?=
 =?utf-8?B?ZGRwSjYxdVREYksrRjV6ZG5lbGkza204ZHZNZ1F2RjhtbXlWR0o0MGxxYXRy?=
 =?utf-8?B?TTRNazlrQ3FReW5yamtwN2oxMHhuWWxWZnVJSW5uUEljVm1hZVlDNWx3TTFQ?=
 =?utf-8?B?eHl5VVFxYlBvaExKLy83MWVaVlBxYXUzdHNIdlJRb0xuRFZ6aTF0YWRoRlJo?=
 =?utf-8?B?UWx6c3BHLy9rTDdtekw4bjRJUWFVTDc0SEhkMmRlRnJiMnlFbmtCZ2pSSFZr?=
 =?utf-8?B?czVQM3YwekVJcWd4L3Zpc20xWldkcFhtQU1Vc1ZzaU5jYWI5VkdLcWx1TENC?=
 =?utf-8?B?bXFTL0pQK2ZNcFlwbE5nYVhXS01ZSE1nVmRqYmpEK2dqZHFsYXQwa2Z0cUZU?=
 =?utf-8?B?ZStXYndIWGhGNzdrQ2lIU3NRdzBITHM3OXpJQVNMaEkxUkZCcWY5dFRPVlY2?=
 =?utf-8?B?VmtKSzhRbWdFa1ZGRHRTU2RoRGl2OG5adXNMREIxd29kdG52RDYvOS9oVlNH?=
 =?utf-8?B?MGpKR09FMjFRNTYxb213ZU05S2JCQkpNaXhXRzR2TmRuUkt2Zi9pV0Zpa1RO?=
 =?utf-8?B?N2Y4aVdyakFqYi8xa3ZsS0p1UjlXdTg4b1Ixd3FLbGxPcENPYlQ0dWxDU0lG?=
 =?utf-8?B?Nlo4ZnBqQmpsRUwyVWk5RmVKaWx4WHorS3N6UTBtSC8zdFVPOWc3TXdjdUZz?=
 =?utf-8?B?akNNVjJEdjRMZ1grUVM2MWtJMDBiOFRybG95akZHaWFGZHAyQjQxa3krNXEy?=
 =?utf-8?B?NWQ3NVhpYWVTLzRKSjR3MFRVV2o2eXBseS80Mis0NVZmYlhkWjI5cmpYbkJJ?=
 =?utf-8?B?YlhjK3VNSlpSbzd4Vk1PYkNYWGdWSUdDN1hXS09NcDR2REtCSTJJZHFSVGda?=
 =?utf-8?B?dFgwakhxQ2lSNk5FcXorQWJUYUp3ckw3NDdUdFh4RmhraGhsSFRUTzdvMlkz?=
 =?utf-8?B?S09aNFN2ekFMNDlTV25sZlBIYWhkbjRpOWluVmt1d0pGM2ZWNUpkRURIcnJZ?=
 =?utf-8?B?SlpveGFkTlVSNGJVMjYwVmRmbFFOdVllNWlwd1pBdk8veThpaXk4RVdBT05j?=
 =?utf-8?B?RVo2QkNvQ3FkMjlVMnN2b1Fqc0wreFVzc2R1UUFDdWEzSFMxcWEyRDR2bGsy?=
 =?utf-8?B?VXJwMmQzeFE5U1BjeWJVems4Q1dhTFdVaGVEWGZiMXlLaHdEcE41cUxoZVhj?=
 =?utf-8?B?S01weDV5WDliN25FVS8wYk00eVJvR1NoNVlmSi9QcThQME5aa0ZXSmJGMEtE?=
 =?utf-8?B?QVV3UzFkWHJxMkdlNytTOUpFZ081V2tubmFTOWhTVGVSRmxmR3JLWUdhcUVp?=
 =?utf-8?B?NDlxZmlXQXduTiswaGhYNDVzc2NsQm1jS1IrZi9WL3Q4bFFGcHd5MUp6RHJk?=
 =?utf-8?B?RlVHZHV1VVZwMFVmRktsa2Iyai9EUWFxNVdYNlZ0alRDZm5Ccm96TWp3eENj?=
 =?utf-8?B?OVZWTDg5bGp3WnlqN05nMm10V3FVWTA5RmJPdGV2Yy9EOWFwK0VadHJheUF3?=
 =?utf-8?B?RWhDZGFISzF4VDRoSDdMdnlvRTIvdFJVeHJKU1B4WGt0WUJIN2tDY2wyK1Zn?=
 =?utf-8?B?dWJIU1BZTGpacjBlOW82YXpxWkdWcHQ5MmE4NXdIZW9qaTFQa0xyR1Rtd0ZU?=
 =?utf-8?B?Ui9qSFNWOW90SWN3ZWxyZG1JVTBFSDA4Mi9IMmF2bXlzcHVPbnpkTDFJbm5s?=
 =?utf-8?B?L1R4RG0zSnFmM1B5L0FPanp2RzBMenJoV2xRa3BYV1pYamJSenNoSXZEditB?=
 =?utf-8?B?RkphMjB2QXpPZ1ZDNEQ1em9PM3ZiOTJ6Z2V6cUo1M2paT0lSNGJJMWpPaGJC?=
 =?utf-8?B?WlJ6eFNnblRqdFZpTHFrUVdXdmJNSGtmb0pBSnBSU3g1bzk3Q2FGOC84d2la?=
 =?utf-8?B?eTQxdG1SMFZCNUpzSlhrQ1IzSllrWXRwcEVPZ3Q2bmpkTlcwcXozczROeDdD?=
 =?utf-8?Q?UWm+Jv4Rjgxgmo8dZCOYXd7Pu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dda40a8-77f0-4f30-4c0e-08db8445293a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 08:34:38.3207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxrxrjCoMp8B/QfE931p2i0udn8FYDFDj2RrRkMWf+Sm0/ovWtEHh7Bi7havfNYBHVmpzOlyfdDv7ujDBPq8ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6338
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

Hi David,

On 7/14/2023 3:31 PM, David Hildenbrand wrote:
> On 14.07.23 05:23, Yu Zhao wrote:
>> On Thu, Jul 13, 2023 at 9:10 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>
>>>
>>>
>>> On 7/14/2023 10:08 AM, Yu Zhao wrote:
>>>> On Thu, Jul 13, 2023 at 9:06 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>>
>>>>> Current madvise_cold_or_pageout_pte_range() has two problems for
>>>>> large folio support:
>>>>>    - Using folio_mapcount() with large folio prevent large folio from
>>>>>      picking up.
>>>>>    - If large folio is in the range requested, shouldn't split it
>>>>>      in madvise_cold_or_pageout_pte_range().
>>>>>
>>>>> Fix them by:
>>>>>    - Use folio_estimated_sharers() with large folio
>>>>>    - If large folio is in the range requested, don't split it. Leave
>>>>>      to page reclaim phase.
>>>>>
>>>>> For large folio cross boundaries of requested range, skip it if it's
>>>>> page cache. Try to split it if it's anonymous folio. If splitting
>>>>> fails, skip it.
>>>>
>>>> For now, we may not want to change the existing semantic (heuristic).
>>>> IOW, we may want to stick to the "only owner" condition:
>>>>
>>>>    - if (folio_mapcount(folio) != 1)
>>>>    + if (folio_entire_mapcount(folio) ||
>>>>    +     (any_page_within_range_has_mapcount > 1))
>>>>
>>>> +Minchan Kim
>>> The folio_estimated_sharers() was discussed here:
>>> https://lore.kernel.org/linux-mm/20230118232219.27038-6-vishal.moola@gmail.com/
>>> https://lore.kernel.org/linux-mm/20230124012210.13963-2-vishal.moola@gmail.com/
>>>
>>> Yes. It's accurate to check each page of large folio. But it may be over killed in
>>> some cases (And I think madvise is one of the cases not necessary to be accurate.
>>> So folio_estimated_sharers() is enough. Correct me if I am wrong).
>>
>> I see. Then it's possible this is also what the original commit wants
>> to do -- Minchan, could you clarify?
>>
>> Regardless, I think we can have the following fix, potentially cc'ing stable:
>>
>> -  if (folio_mapcount(folio) != 1)
>> +  if (folio_estimated_sharers(folio) != 1)
>>
>> Sounds good?
> 
> Adding to the discussion, currently the COW selftest always skips a PTE-mapped THP.
You always have very good summary of the situation. Thanks a lot for
adding the following information.

Add Zi Yan as this is still about mapcount of the folio.

> 
> 
> For example:
> 
> # [INFO] Anonymous memory tests in private mappings
> # [RUN] Basic COW after fork() ... with base page
> ok 1 No leak from parent into child
> # [RUN] Basic COW after fork() ... with swapped out base page
> ok 2 No leak from parent into child
> # [RUN] Basic COW after fork() ... with THP
> ok 3 No leak from parent into child
> # [RUN] Basic COW after fork() ... with swapped-out THP
> ok 4 No leak from parent into child
> # [RUN] Basic COW after fork() ... with PTE-mapped THP
> ok 5 No leak from parent into child
> # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
> ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
> ...
> 
> 
> The commit that introduced that change is:
> 
> commit 07e8c82b5eff8ef34b74210eacb8d9c4a2886b82
> Author: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Date:   Wed Dec 21 10:08:46 2022 -0800
> 
>     madvise: convert madvise_cold_or_pageout_pte_range() to use folios
> 
>     This change removes a number of calls to compound_head(), and saves
>     1729 bytes of kernel text.
> 
> 
> 
> folio_mapcount(folio) is wrong, because that never works on a PTE-mapped THP (well, unless only a single subpage is still mapped ...).
> 
> page_mapcount(folio) was wrong, because it ignored all other subpages, but at least it worked in some cases.
> 
> folio_estimated_sharers(folio) is similarly wrong like page_mapcount(), as it's essentially a page_mapcount() of the first subpage.
> 
> (ignoring that a lockless mapcount-based check is always kind-of unreliable, but that's msotly acceptable for these kind of things)
> 
> 
> So, unfortunately, page_mapcount() / folio_estimated_sharers() is best we can do for now, but they miss to detect some cases of sharing of the folio -- false negatives to detect sharing.
> 
> 
> Ideally we want something like folio_maybe_mapped_shared(), and get rid of folio_estimated_sharers(), we better to guess the exact number, simply works towards an answer that tells us "yep, this may be mapped by multiple sharers" vs. "no, this is definitely not mapped by multiple sharers".
> 
So you want to accurate number. My understanding is that it's required for COW case.

> The "mapped" part of it indicates that this does not catch all cases of sharing. But it should handle most of the cases we care about.
> 
> 
> There, we can then implement something better than what folio_estimated_sharers() currently does:
> 
> static inline bool folio_maybe_mapped_shared(folio)
> {
>     if (likely(!folio_test_large(folio)))
>         return atomic_read(&folio->_mapcount) > 0;
> 
>     /* Mapped multiple times via PMD? */
>     if (folio_test_pmd_mappable(folio)
>         return folio_entire_mapcount() > 1;
> 
>     /*
>      * First subpage is mapped multiple times (especially also via
>      * PMDs)?
>          */
>     if (page_mapcount(folio_page(folio, 0) > 1)
>         return true;
> 
>     /* TODO: also test last subpage? */
>     
>     /* Definitely shared if we're mapping a page multiple times. */
>     return folio_total_mapcount(folio) > folio_nr_pages(folio);
> }
> 
> There are some more things we could optimize for.
> 
> 
> 
> While it's better than what we have right now:
> 
> (a) It's racy. Well, it's always been racy with concurrent (un)mapping
>     and splitting. But maybe we can do better.
> 
> (b) folio_total_mapcount() is currently expensive.
> 
> (c) there are still false negatives even without races.
> 
> 
> For anon pages, we could scan all subpages and test if they are PageAnonExclusive, but it's also not really what we want to do here.
I was wondering whether we could identify the cases as:
  - bold estimated mapcount is enough. In this case, we can use
    current folio_estimated_sharers() for now. For long term, I
    am with Zi Yan's proposal:  maintain total_mapcount and just use
    total_mapcount > folio_nr_pages() as estimated number.

    The madvise/migration cases are identified as this type.

  - Need some level accurate. Use estimated mapcount to filter out obvious
    shared case first as estimated mapcount is correct for shared case.
    Then use some heavy operations (check anon folio if pages are
    PageAnonExclusive or use pvmw) to get more accurate number.

    Cow is identified as this type.

> 
> 
> I have some idea to handle anon pages better to avoid any page table walk or subpage scan, improving (a), (b) and (c). It might work for pagecache pages with some more work, but it's a bit more complicated with the scheme I have in mind).
> 
Great.

> 
> First step would be replacing folio->_nr_pages_mapped by folio->_total_mapcount. While we could eventually have folio->_total_mapcount in addition to folio->_nr_pages_mapped, I'm, not sure if we want to go down that path
> 
I saw Zi Yan shared same proposal.

> 
> That would make folio_total_mapcount() extremely fast (I'm working on a prototype). The downsides are that
> 
> (a) We have to make NR_ANON_MAPPED/NR_FILE_MAPPED accounting less precise. Easiest way to handle it: as soon as a single subpage is mapped, account the whole folio as mapped. After all, it's consuming memory, so who cares?
> 
> (b) We have to find a different way to decide when to put an anonymous folio on the deferred split queue in page_remove_rmap(). Some cases are nasty to handle: PTE-mapped THP that are shared between a parent and a child.
>
It's nasty because partial mapped to parent and partial mapped to child? Thanks.


Regards
Yin, Fengwei

> I have to do some more thinking about (b), I'd be happy about thoughts on that.
> 
