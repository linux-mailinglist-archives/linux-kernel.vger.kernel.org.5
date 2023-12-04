Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E418780395C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343913AbjLDQAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjLDP76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:59:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB4C83
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701705604; x=1733241604;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QPeoHCqJ9cahWosE/O7O7toe+aGMUANBhJKGl0/E49s=;
  b=S1bggKvFg5idvp6SZA5j+DsXXF4CPdILk6pDUvQUMvyrClwrh691xs9b
   yf5mwGBmlNW3hKoXnNJU9af3EveLeh3TZZAhHBFZR9eYAavh/H7qmhB/e
   OhzAkwoOXLDDjQ0yuWX8dMhTiBZ+lCuCDiUcMS1xUu2npptb4vdNZaqsH
   7C3/h5RcxnnDd8UlGt6XiL7dHE2Nvh+k2ZeeWnu4odfkT20tjrMrb65V/
   1+8B/4W32WBL2sUCCWc0NIT8QFVSe84Ytl2gg55tAGVRpuSHvlos9daoC
   bb+hImk1Is82bzBmTPmFTjyHQk2lqd5XWi67FOs0Q30sf6T9yci4/srB/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="807216"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="807216"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 07:56:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="774295480"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="774295480"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 07:56:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 07:56:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 4 Dec 2023 07:56:21 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 07:56:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnWcs7ZwQIQnZHLolpXPYR8QJ/GAnIUqFHDQ+0ZxCdQcziTkV8H6Y0wrb9PLn97ud7FuVRLRTaqI0BDWHvP1+SkVQIw7D4wHBppNIi4sC8Pgk2IVFfrAmVg4ZnwiZJa4A5KImBolJR8Fk5xUN2wHZ0nWvnxRbeK2N4gW5wKvxyUsiWakzFQKNkfYJzIr9lpPlq2pJRO0kbtkyMId+xuI7ltW0NmXU30sVN+Sb1I4kE+OpjwWdOtrsd3w9Z87Zg0DP+SANF2niWZ0gCEYjBIqPoI18UDtRbK1aursN9pdXK3VJHj1/pPj9pQYaDer1T55jfpnrGVcE6iPAJCuijbyzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ryxe/61qfgGvIl02n10W/fif5bTe9SDnmC19mlOuQ4=;
 b=RnU6aXHy1qDe6DgeaGMWaSXFBhJ21JB5Bk01mDck6gbnfB+zfbKNcOqizQvCtT5tvZYSPo1UhQiiPPw/AO1T+gfewCbRdnWIqezHn5SyoG3/o+FWe1godLKXxeezrJa8L4fVQiBJi6K37pIGOW8Ss1gDJpn88QjoFPNwskQ3KXDjDPnEjnWr5ZqD2QMHpTwdeLHn26zYuVoSYJBjsJmh/QOD0bhnDB6sXFMylJT4lozStnF0+0l7JoOl1aKZpjmBszLLSTc7TdtDEhs2JqJEcaqXNdIo/AQJwBO8RpIgsqQaXRnXNYQyYkyf/8zMFOfCBUbprKdNyf9vxk4eJ//O5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by IA1PR11MB6467.namprd11.prod.outlook.com (2603:10b6:208:3a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 15:56:13 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 15:56:12 +0000
Message-ID: <ee9b60fb-8c79-44d8-8f4b-63db7e34b596@intel.com>
Date:   Mon, 4 Dec 2023 16:54:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/3] lib/bitmap: add bitmap_{read,write}()
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>,
        Alexander Potapenko <glider@google.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>, <pcc@google.com>,
        <andreyknvl@gmail.com>, <andriy.shevchenko@linux.intel.com>,
        <linux@rasmusvillemoes.dk>, <alexandru.elisei@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <eugenis@google.com>,
        <syednwaris@gmail.com>, <william.gray@linaro.org>,
        "Arnd Bergmann" <arnd@arndb.de>
References: <20231109151106.2385155-1-glider@google.com>
 <CAG_fn=U7EV0ohaNFRwQ83cvwVn-Fer1pHXOjPevbP_XpYGDCYA@mail.gmail.com>
 <ZW3gnNbnzpZwtrMa@yury-ThinkPad>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ZW3gnNbnzpZwtrMa@yury-ThinkPad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::11) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|IA1PR11MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b6902e-98bf-4d8f-f52b-08dbf4e18a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O55dyyGl6aBRizpNFb9X4c3PB2WDINsQGbu4tMKu5Qr+iaUtSJ5br5G58Z56Z9bVt0sMdhrz0liML3lBxydy1yN5DrviJLDu22KsL9FOdM4CMZ/UCzhC32dlKtgCpYeQMT7+0mBj1FjkjGcyw3eeLS5GTfWTnFIJfrC6gOVCl0WSuOlJjrTIjb0zKDryyPYPus9+ycW8Sw0xp0lLVIuHfGX7742HAKn0BQasqIEBHJoNCnntMEoU2935NeFpiK8t6XI+OqvsfmhCsaGMVNAcTmVN8mo2VUDwcgotfHAW3Li9vQigXqpBdoF9p02HHnXFN+TI06G5/UURcOa8IvCcWq8Olv2802LK5rttmdqy0uxYQ3RmBUoVFESazjdc5GqYlhGIxdtmGTAYaUILB+77wDmuDEkKxuWIEbmE1XsDoeqgQbOwI76JzkZ5AurvXt9Vk1w6EaZY1+TN7/YoF9/5hjJwqKiv+Mpxw27BpU+M1bKCDKRwiJCaWdqCK45Ng/YGHMhrEL5cTcDjfS9uJCq5kzExFg7FrzIL1k+A3nkw7rE/OViR08/KiBSPgOr+YIYlte7exi3K8IZ9hMftN3FxmeVBUEVgUE2u6ieqDVyhWFGqSKJ+0SRAgnJGeVjb9qPflJsJYONwucoN32C1rugbtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31696002)(5660300002)(7416002)(86362001)(4326008)(8676002)(8936002)(2906002)(41300700001)(36756003)(2616005)(6512007)(6506007)(82960400001)(53546011)(966005)(6486002)(478600001)(26005)(6666004)(38100700002)(31686004)(110136005)(316002)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3pwNnBqNytVS3BtbGpDbVR6MUNIb1VLR01DbXVZbUI0NS85RXBRUnpLVVNF?=
 =?utf-8?B?NmdsdE01aENaTGJLZ0srZXE3M1NkVmVhbmh5U25zcDdIalZuandnaHA1N3FG?=
 =?utf-8?B?cXBYT2hxVFFyZjdURC9UdUlBeGpRcHh2cjNtRHl0UGpyMnpsU1pLSVFacGVY?=
 =?utf-8?B?MkMrU3NScFVVdVVYQU1vcTQzN3FTekxHazJNTFRucmdjWXlrY3I1a0tqV1pF?=
 =?utf-8?B?eit2UlU4NGhHb0dXeWdITGhJOFpSNzBiaUpCZzN5MXVId2RoRXAxYU42Zk94?=
 =?utf-8?B?VG1nOVkza0dyUEJuWjRVYnR2M0NzQWR0RFZLZEt6dzhqY0lkRi81aU5iYmxP?=
 =?utf-8?B?M0ltS2Q1N1FwQmRvYlUzdUpxbUVFektlM2JZZUJxN2dhR2hTai8vTTdJSVVp?=
 =?utf-8?B?RUJYdkFRdGhXTVBWcEFBeHhtRDhMeks3aEdpT2VzRmJEb21FdXE3MHFNM1VF?=
 =?utf-8?B?Q3ViUUd6MlB3ZDhCVWY4eDh2MVFXQllEVTRZN3NidnJOekxITDZmTzM2ejBr?=
 =?utf-8?B?T3RNMDdOV3JYaUp5SW5FKzdmTVJUZGZmQk5UQ2tWRVQzeUVkUTlQZ1Vqa052?=
 =?utf-8?B?TTR5WldtSlNBWmhtVk1RakV5R05ZUWd4MGwwTUNtVVE3VGVTRnZ6SC9TU1hk?=
 =?utf-8?B?WDh5MHJoN2preS9pVWl4L3FNN1N3K25xYkQ5bHFYV1hVYmtGV2JOV1EyN3pP?=
 =?utf-8?B?RU9PUEExWUoraG11MVBDTnRuaEo1UFRlL0pTbEduU2ZvbURLNnFGQ2szR3lQ?=
 =?utf-8?B?bWdoaGVRT0JxT2hsd0xuR2FxTXNUOWwxZU14MlVjRUo4R3lNNUpvSzZhMmhQ?=
 =?utf-8?B?TWJxbnhsYitydm5vS2xNcUZ0clNua1ppL2ZiZXBHNkhVZzQ1WGtpczJRVFY3?=
 =?utf-8?B?bllTN0NvT1ZpbEFWMEpyelVsRnhqc3lNc3Fpakk2MWR6L1pVc1lQUy82WEgr?=
 =?utf-8?B?RmFvS1ZuclFpMjEvVXBJcHFIZlpsejNXbXdEcFVXekY4ckMvU0kvQ09LOHRt?=
 =?utf-8?B?SXpSODVqZ21ueFhrZm5lTHh5UW1OMDlQRGNmbkNqY0VsQXY1OS91Ty9UT2VG?=
 =?utf-8?B?NXZqZkpPS09aTXZSTE9jM2lyNmZrcGpIY25BYS91Y0loYVJxK0JGcldjbC90?=
 =?utf-8?B?N2NlaU52SzVmMTdjRDBvQ09aWklaaTZCR1IvMjJQTG9xRVFnY0c2dC96OG11?=
 =?utf-8?B?cW5zTm1NQStvNXF3UTR5RkFqRlU3Y1hpdDJxQk9vdWxLTkRzOWMrQloxZFlm?=
 =?utf-8?B?VFlVSDlIQVlad1hzQnNIdk00a3lzQk5pUWhUUE1ZZ3A5TkIxampLOS9jNHM1?=
 =?utf-8?B?VEhiOWRsbE1FeGFDTzZ6ZUV0Yk9FcWRnUWdBK2QyT1BqT3pFd0dscDJjZTFa?=
 =?utf-8?B?bDFETDExd1hUQm1iaTZkWlVvQUdDOWFwbDY3WXc4UTNCWTVKYWpra0hwcnVX?=
 =?utf-8?B?bXJFV210MEhEL2hKaUZQdU4xbXpCYmcyRGw2ZFFpQXRySFJSaEMzUldoNGhC?=
 =?utf-8?B?dG5lZGpDVlJGL1N1ZSszTWMzL3ZRY1lYb0RBSVBPb0UvcGJCZWQvaFhsYjVM?=
 =?utf-8?B?SXIzR1pYT2ZtbE4xOXdsblR4WW5IZklSOUpyZ1o3bkFTK1Q3NUV2U1hEY2Mx?=
 =?utf-8?B?NXo3cXZoREErTmtQREE5N090c2NiczRsMWF6ck5yQ2V2RlducG4rVTZ3QlpN?=
 =?utf-8?B?Zm81SG0zU1Y5UHdCRnJ6UGFrdWx6NGVtOWNmS0o3Z21GVmZQeU94V2xyZCti?=
 =?utf-8?B?UHg5ZkJLMlI5WnlMRGFibWxqeXpodVBua0lYSFpxR3R2cU00SkRzM0tnZmJ4?=
 =?utf-8?B?eTF2RVJkajVZRTZuWEdvSGdsUHIwbWM5V0VEc1dZT3BKbkd3Z3NrUEE0UG1m?=
 =?utf-8?B?WDMxOXpaT1czeTFTUzZZdzdxVnpxTzBvaTlWcFk1dTk2K0FYVWluVlllaEFB?=
 =?utf-8?B?Mk9wZlVUUHhxREEzaGVuSDViSW9lZUh2TVcwTE9qa0xJZnB3SEpvU3plNTJ4?=
 =?utf-8?B?YUR5alZyVFBSK0FRYysxTHpVOVBKOXBxeEZjbStEQWlaamtiNkxYSE9jNjNx?=
 =?utf-8?B?b1I1WTNJdTZDV2NVTWxzdEdMd09LZXV4anF4YkhXSEh3Y09UaU1BQkJycWZx?=
 =?utf-8?B?cE4remRHV2VrSitxSkJBcjMxa0xGTVdpcFhLT0hlOThsUXRQQjV3QUQ3VWg0?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b6902e-98bf-4d8f-f52b-08dbf4e18a2a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 15:56:12.8595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cC+dwN983XdoA2OOyUmssjBN1HqzuI8FBZ0eTz2KZ2lbphzg7gtHxjR5Lsm1D05E5U9v7rgzdPnT2BsvdcvvB6Te11+X+rsKiVJ8oXzIQ2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6467
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

From: Yury Norov <yury.norov@gmail.com>
Date: Mon, 4 Dec 2023 06:22:20 -0800

> On Mon, Dec 04, 2023 at 02:28:09PM +0100, Alexander Potapenko wrote:
>> On Thu, Nov 9, 2023 at 4:11 PM Alexander Potapenko <glider@google.com> wrote:
>>>
>>> From: Syed Nayyar Waris <syednwaris@gmail.com>
>>>
>>> The two new functions allow reading/writing values of length up to
>>> BITS_PER_LONG bits at arbitrary position in the bitmap.
>>>
>>> The code was taken from "bitops: Introduce the for_each_set_clump macro"
>>> by Syed Nayyar Waris with a number of changes and simplifications:
>>>  - instead of using roundup(), which adds an unnecessary dependency
>>>    on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
>>>  - indentation is reduced by not using else-clauses (suggested by
>>>    checkpatch for bitmap_get_value());
>>>  - bitmap_get_value()/bitmap_set_value() are renamed to bitmap_read()
>>>    and bitmap_write();
>>>  - some redundant computations are omitted.
>>>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
>>> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
>>> Link: https://lore.kernel.org/lkml/fe12eedf3666f4af5138de0e70b67a07c7f40338.1592224129.git.syednwaris@gmail.com/
>>> Suggested-by: Yury Norov <yury.norov@gmail.com>
>>> Co-developed-by: Alexander Potapenko <glider@google.com>
>>> Signed-off-by: Alexander Potapenko <glider@google.com>
>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> Yury, Andy, do you think anything else is needed for this series?
>> If not, whom should we ask to take it?
> 
> I probably need to revisit it, but generally it looks OK.
> 
> But I can't take new API without having real users. Now that your MTE
> series is delayed, and Alexander's 'ip_tunnel flags' is not moving as
> well, there's non-zero chance to merge dead code.

One of the PFCP developers had a quick vacation, we'll send PFCP with
the ip_tunnel bitmap conversion this week.
I'll tell Jakub he'd need to pull boys' tree :D

> 
> If you want it to be merged, I'd advise you to walk through the kernel
> sources and find good cases where bitmap_read() and bitmap_write() can
> be used. Then append this series with such conversions, and I'll be
> able to move it.
> 
> Thanks,
> Yury

Thanks,
Olek
