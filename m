Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0574C778483
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 02:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjHKA1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 20:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjHKA1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 20:27:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1CB2D4F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691713670; x=1723249670;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KUzHhWlExMXw8lIXqmMkNE+hFLtH2IZM7VpsWj1PvGM=;
  b=mvxCf0AOyobYm1kHnIhIqssHKTHf5P05sOQm5MJBGfmOahbdc4JN63wt
   W0uLH5v8WDHaWV86yiAF2sjWFRQAaV86RuRfhLVe7HF+V52PKa1WS9Gpx
   uIGe71zmE5uuwBThwakc82v1r4TWNXtfMetlPw29j8QEV0ptNbuBP7TYX
   0HV8SS4MO4RYO+fuSXShH6niWglE0gKkGqTgwVwOIJEebcFIW4pYnHLKl
   5Dm7lU1KRHCBJJ28vLKjWsq4KCDN5ZcL1js5RSeIGlI89MdlvlIVjl41H
   ztxYWBARHNQVkrL1+gFgsNVWwMYOSaBrUvFm9uSasD/QR/hIKj/VARlQl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="351164380"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="351164380"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 17:27:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="802462115"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="802462115"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 10 Aug 2023 17:27:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 17:27:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 17:27:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 17:27:49 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 17:27:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhyhWxSh6QtGIJot6UnzbR8bvu5BqLBBnbsbHKEbYoONJhWvAPNoZP1GUMy3eXrAl9gnDA0BzJ8Klb/dgI99hzL8OXPww3AMuzLzk3xcX3jv4FNNGmcPJNRYwy+a17mFQ1JDwvd2JKqhNVzWVRRufX1odKtTB7/oxyIXMiqmSnEUh+89ki3uhjWtEOgD47AsAC9XMNNuLHYvOEtT6PHP6OaWcXDCjtcidHB5+ld0Drrn5eHDJjTOqP59gwWqP/h+taNqLvTSo8XLVVes347tqJcRnTkwc0fpweHv2E8w4sn5Iqc3IdMsjFHAjd+ZTZJbgbJWqXFHb7jSCVqLFwURQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8yREuAlp90ryO8WuEgSwggBhkYOFT6n63GlVLxvxmg=;
 b=oJT41fQKQCdfuRggyEDEeLR0wJyix2I2SsRHlNwAPR/unP3sLCjA7ZQgLxJmbkRm7UAV2Pf1pUxYugYt1XUvlN0WCtw+rsJUkPljRDkr5PxhbOBm8vVFbkA86hErV2c3oN9py1GY1yoGGbMwoNPSIMAMX1tuK6N7MCGz9PQXfW0kOGICW4Vl5kroJEYbcF9kOgIY18NxWIxzJgZADWuUZ6AfBKVVhY2PRuIFKUQ040qJetQt1hDT180CtJDG3O/dxwZMSoQV3kNLxln4K/a2xwHYqUVyIRgWgyzS7EGQS2Z9cTPVNasLk3jGs8E7P1t0IAcW2xf1uomZQcK2l8vjlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH7PR11MB8569.namprd11.prod.outlook.com (2603:10b6:510:304::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 00:27:34 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 00:27:34 +0000
Message-ID: <c00d4d4d-0b98-4ac3-98c2-07923a156b1e@intel.com>
Date:   Fri, 11 Aug 2023 08:27:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] mm: LARGE_ANON_FOLIO for improved performance
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, Yu Zhao <yuzhao@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230810142942.3169679-1-ryan.roberts@arm.com>
 <20230810142942.3169679-4-ryan.roberts@arm.com>
 <CAOUHufbUGwc2XvZOBmTCzMsOHxP-eLB60EdysKYzrkRMScOyMg@mail.gmail.com>
 <f97446e3-85d8-4d14-9fc0-683b31925325@arm.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <f97446e3-85d8-4d14-9fc0-683b31925325@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH7PR11MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: d6d6bbe1-473a-4d04-5e3d-08db9a01c1d8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jYcdJU6pTPE0vM1UFHlEz5BugmL+h2jA8PVUaJ67JAa4hUc3eA0YWNjn08U9fDcxMaE16xID5OUFmXo7K31igxtkx3RPZ6HrXNCn/zI1ll66xdfzbbk90fbdn2vGh442hQ3bnTFoVoLj8gaEUni4bBuqX5lQB7ooGpr6FFVmZY6RIgMY/7lXp0eWdDZig8hVhhkqBRPW0esIEgamid9k9bA+EtVC4GIgbXxvLDcFCtc8nlxXWOlMyXOxpkQIuB27L5nsJZvmNkLOeFk9D9Hj4YJWfjUzHJdgSPn3cH1lBDTT5FplE/fJT6NrIOBQ9S1XTX4O6AVlEM2kUw8EJo/GI/CMEGvCJ8b65BiEtDk7jmHDLEufJ7BimRqVw/HANEEoCpGa06SvQhmB94Az20xEPksFVHVVZcwXndGuqIIb8SR5GPab8BtRoM8lbNm753GL1DuX+qgqDHHLepaoRwoJOyyOiDYz5ecK6ekvaH68gD6hEL2m9rCov6BVSyUBNkzei1RAv9Wy9WEuB5zWWWtC86T/3fMM6pxkXu/7PjFbj+KRziuvWBoDxDtitZZQ4qjyNdnQEBKCdkT4oNOuOTqQ5QDldUs6DtoKZg+cD5pvAhCLpxkEYPY6N7JB1VsDv8QlqqNpU/c4nqYTyd/FzwQj5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(136003)(376002)(186006)(1800799006)(451199021)(31686004)(6666004)(6512007)(966005)(6486002)(478600001)(53546011)(6506007)(36756003)(38100700002)(82960400001)(2906002)(26005)(7416002)(83380400001)(2616005)(8936002)(4326008)(86362001)(5660300002)(31696002)(316002)(110136005)(66946007)(8676002)(66476007)(66556008)(41300700001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1A4aEpIWEhSd3dxODhpU0kvbzJPd1UzUzNjbHZHUk5CcFIvcXMrTDkzY2I4?=
 =?utf-8?B?bHVBWFJHbEdpWStMWkhjcDVkK1Rzb0MvOXFKR29CMDRUdGpvb0lONkFaaFhu?=
 =?utf-8?B?ejlwNkhHZVR3Q2FIT214ZW0rU2xkZ1ZycmxHYlpVaTBtRFlJcTJJZGNSdGpu?=
 =?utf-8?B?YmlzajFDM2d1VGhWWXFleGtQZXNteEViUDlWWDl1YjZ5RkFUckxTUzhWN0Nx?=
 =?utf-8?B?SmhTOWYyL2MxenZqZzRDZzBCcWdoZmlTL05IZzlNYlZQM3RqMklpSEhRbVN5?=
 =?utf-8?B?WVE2MWRCVTV0bTNkTVQ3eWdUYy9oNUN5L0N0M3ZPTXU5Wk1QUDQ3NkluSkRO?=
 =?utf-8?B?MnZnM1lxMEg4ZnhLMmRqcHlQVlJiQzVoM2hKdFV2NXhQbHE4aGVaZmVUZnYw?=
 =?utf-8?B?bk9RYUY2WjUyd0ZRUXhYODR5bkdWcU5VMzA3ZWJrREF1c3g0TzdkNVk3ckg2?=
 =?utf-8?B?cTFpSUhwN0NDU2k0WG5Pb05tWHVTb2huUWF0eVo2M0hTb29ReGkvdDhYeVRy?=
 =?utf-8?B?d3hvMTc1MmVESE5mcXlFeFFrcGxMaW5lOS93Wm54UGpXUEZKMVR3NmI4VktG?=
 =?utf-8?B?TGpEcnRZdElKT3JMSVk2WEZ6VTVQVkoranNHZ216Ymh5VGFCT05RNDRmSU9N?=
 =?utf-8?B?RWZMd1lWbGJUSktIYVZxNWtvV2FhQnZHaVV1TXBzYVM4Nko2MXMrMitXMktJ?=
 =?utf-8?B?c2NhcjRlazZoT0tmMXNTUkJtL3BRcTBmMktyNHJMaFVpTzE4R1dqb2tpQ25z?=
 =?utf-8?B?c051ODh2NzVKdzI4TmZZS2UrWUNNRkRmTWR1V29TUmxWUElMRnVCT0xBVE92?=
 =?utf-8?B?aHRhdjR1TlYweUt4dlFxczJweTdQekNHUFpBTFY0TmR2QkpzMmI2by8zRk5m?=
 =?utf-8?B?NW9zQXhBM3hHcmJTRHBoUVpqZGQ5aVRoK3lVWmkrMmxiMHZnTllnZjFvMHdQ?=
 =?utf-8?B?TkxNZkxVVE5Ja0Fld2tBeWhpUHNBajI5VTA3QTZvcGxYakQvQWgvbm5ZRDJP?=
 =?utf-8?B?VEpMdzU4ZmZTVG5nZmJCTFBVWmdZQlNzVFRhcXNjcFB3SktoL3A5ZEVZL1VD?=
 =?utf-8?B?enNieUYxWkhrWWdKWFZKVHVXRzZNRlFyVERLZi94WEZ4VEJoNlNQMFRJYlVl?=
 =?utf-8?B?MWlvYm5rUmc5K2U4OStHOTBhbGRGaEM1citLWVNGbzZZaUNLK0MzenFlb3Nj?=
 =?utf-8?B?MSt1ZlBpYVBPdmx0RzF4R2tEekxaRVZ0MTNlYUF4SmZPR3NGWWF6RHVNeXRw?=
 =?utf-8?B?SjRKM1RBMUpHckdBKzFDTm5kWjFjajQ1V1d6ODFMdG9DaSszdGRETVpDck5N?=
 =?utf-8?B?VisvWFhrb2l3Y2FTa3ZWaHlwcGZOb2FQaTFSOERLRU00d3ArQUd4alI3WXgv?=
 =?utf-8?B?SHFiL1pJUUZBdExKU3NDb2pta3hQSVNhL2ZaRkR5Z0twVnlGcTFldWZJaS9s?=
 =?utf-8?B?S3Q3cTZCdFdTUWh1NkpCWnhkZ2tIQ29MRldqQjFEeVp4MFZBVkltVzJEeU04?=
 =?utf-8?B?c3hQN28xWVRTem1YSHppU2J1S2pSYVVJeTVxMlJWOTdqQUZZN1lIdGRMYk9F?=
 =?utf-8?B?V3drdFZIbUJtamhoZFVZZXpWbzRzb1ptc21uS2VVQjVCczd2ZjloSWh3UmlE?=
 =?utf-8?B?NzhQTFdMampVM2J5RndBTWZNczFmQjBaR1hQUFliRHNQSDMxZjFoMytYVGNm?=
 =?utf-8?B?UXF0ekM3SHRsSFhranRreVdVMFdSL3FaRkJ1Z1lNWWUzWHlxcldDSS93NGRV?=
 =?utf-8?B?VjhRSDM0cUJNNXRwWlZnMjJEd2xQU3RpNlRjV0RkNTVLbFJjVEFuTjJIUGwv?=
 =?utf-8?B?OUhjWTl2aTU4VWJnaTVBZkppdEJydWZTUjZGTDlOMG81bXgySXkyeEVuSEs3?=
 =?utf-8?B?SXh1Q1l5N1pwSnJzY0pvU0JGQzlBK29ObkpCMTB6ZmFvbWNSMnFWNFJTYkh6?=
 =?utf-8?B?ZTJ6V0l5SUszMjdPVnc2RU1wMzJpSENaMkhvaFlzUm44eVlhMEJabmo2aXlG?=
 =?utf-8?B?TGkvVnE3SDV5THlvVk55UXg2c3UwOXg0OWoyV3RkMGpjbENVY2RIVEpRdUl3?=
 =?utf-8?B?ZVQzeEN3TEhoVFVnOFJBU3FZaUVJRndTQVFXUUZ6Z3VVSklDbFVqZ2hwRzI0?=
 =?utf-8?B?NWk2bW81WENrbzZTZ0lDeGFUcWFnVkoxeVhyYitpOHFUV0NUeU9NWUYyd1ds?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d6bbe1-473a-4d04-5e3d-08db9a01c1d8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 00:27:34.2371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qDOrp9LfmKzLBUT0KpOI3PJ44yTb2/YbD0BM9w3NvYMZY4SqVp4mn7eCEsf/O9UthUIuLBBb3F7oHR7riSn+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8569
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/2023 3:12 AM, Ryan Roberts wrote:
> On 10/08/2023 18:01, Yu Zhao wrote:
>> On Thu, Aug 10, 2023 at 8:30 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>
>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
>>> allocated in large folios of a determined order. All pages of the large
>>> folio are pte-mapped during the same page fault, significantly reducing
>>> the number of page faults. The number of per-page operations (e.g. ref
>>> counting, rmap management lru list management) are also significantly
>>> reduced since those ops now become per-folio.
>>>
>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
>>> which defaults to disabled for now; The long term aim is for this to
>>> defaut to enabled, but there are some risks around internal
>>> fragmentation that need to be better understood first.
>>>
>>> Large anonymous folio (LAF) allocation is integrated with the existing
>>> (PMD-order) THP and single (S) page allocation according to this policy,
>>> where fallback (>) is performed for various reasons, such as the
>>> proposed folio order not fitting within the bounds of the VMA, etc:
>>>
>>>                 | prctl=dis | prctl=ena   | prctl=ena     | prctl=ena
>>>                 | sysfs=X   | sysfs=never | sysfs=madvise | sysfs=always
>>> ----------------|-----------|-------------|---------------|-------------
>>> no hint         | S         | LAF>S       | LAF>S         | THP>LAF>S
>>> MADV_HUGEPAGE   | S         | LAF>S       | THP>LAF>S     | THP>LAF>S
>>> MADV_NOHUGEPAGE | S         | S           | S             | S
>>>
>>> This approach ensures that we don't violate existing hints to only
>>> allocate single pages - this is required for QEMU's VM live migration
>>> implementation to work correctly - while allowing us to use LAF
>>> independently of THP (when sysfs=never). This makes wide scale
>>> performance characterization simpler, while avoiding exposing any new
>>> ABI to user space.
>>>
>>> When using LAF for allocation, the folio order is determined as follows:
>>> The return value of arch_wants_pte_order() is used. For vmas that have
>>> not explicitly opted-in to use transparent hugepages (e.g. where
>>> sysfs=madvise and the vma does not have MADV_HUGEPAGE or sysfs=never),
>>> then arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever
>>> is bigger). This allows for a performance boost without requiring any
>>> explicit opt-in from the workload while limitting internal
>>> fragmentation.
>>>
>>> If the preferred order can't be used (e.g. because the folio would
>>> breach the bounds of the vma, or because ptes in the region are already
>>> mapped) then we fall back to a suitable lower order; first
>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>>
>>> arch_wants_pte_order() can be overridden by the architecture if desired.
>>> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
>>> set of ptes map physically contigious, naturally aligned memory, so this
>>> mechanism allows the architecture to optimize as required.
>>>
>>> Here we add the default implementation of arch_wants_pte_order(), used
>>> when the architecture does not define it, which returns -1, implying
>>> that the HW has no preference. In this case, mm will choose it's own
>>> default order.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>  include/linux/pgtable.h |  13 ++++
>>>  mm/Kconfig              |  10 +++
>>>  mm/memory.c             | 144 +++++++++++++++++++++++++++++++++++++---
>>>  3 files changed, 158 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>> index 222a33b9600d..4b488cc66ddc 100644
>>> --- a/include/linux/pgtable.h
>>> +++ b/include/linux/pgtable.h
>>> @@ -369,6 +369,19 @@ static inline bool arch_has_hw_pte_young(void)
>>>  }
>>>  #endif
>>>
>>> +#ifndef arch_wants_pte_order
>>> +/*
>>> + * Returns preferred folio order for pte-mapped memory. Must be in range [0,
>>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires large folios
>>> + * to be at least order-2. Negative value implies that the HW has no preference
>>> + * and mm will choose it's own default order.
>>> + */
>>> +static inline int arch_wants_pte_order(void)
>>> +{
>>> +       return -1;
>>> +}
>>> +#endif
>>> +
>>>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>>>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>>                                        unsigned long address,
>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>> index 721dc88423c7..a1e28b8ddc24 100644
>>> --- a/mm/Kconfig
>>> +++ b/mm/Kconfig
>>> @@ -1243,4 +1243,14 @@ config LOCK_MM_AND_FIND_VMA
>>>
>>>  source "mm/damon/Kconfig"
>>>
>>> +config LARGE_ANON_FOLIO
>>> +       bool "Allocate large folios for anonymous memory"
>>> +       depends on TRANSPARENT_HUGEPAGE
>>> +       default n
>>> +       help
>>> +         Use large (bigger than order-0) folios to back anonymous memory where
>>> +         possible, even for pte-mapped memory. This reduces the number of page
>>> +         faults, as well as other per-page overheads to improve performance for
>>> +         many workloads.
>>> +
>>>  endmenu
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index d003076b218d..bbc7d4ce84f7 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -4073,6 +4073,123 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>         return ret;
>>>  }
>>>
>>> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages)
>>> +{
>>> +       int i;
>>> +
>>> +       if (nr_pages == 1)
>>> +               return vmf_pte_changed(vmf);
>>> +
>>> +       for (i = 0; i < nr_pages; i++) {
>>> +               if (!pte_none(ptep_get_lockless(vmf->pte + i)))
>>> +                       return true;
>>> +       }
>>> +
>>> +       return false;
>>> +}
>>> +
>>> +#ifdef CONFIG_LARGE_ANON_FOLIO
>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
>>> +               (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_SHIFT)
>>> +
>>> +static int anon_folio_order(struct vm_area_struct *vma)
>>> +{
>>> +       int order;
>>> +
>>> +       /*
>>> +        * If the vma is eligible for thp, allocate a large folio of the size
>>> +        * preferred by the arch. Or if the arch requested a very small size or
>>> +        * didn't request a size, then use PAGE_ALLOC_COSTLY_ORDER, which still
>>> +        * meets the arch's requirements but means we still take advantage of SW
>>> +        * optimizations (e.g. fewer page faults).
>>> +        *
>>> +        * If the vma isn't eligible for thp, take the arch-preferred size and
>>> +        * limit it to ANON_FOLIO_MAX_ORDER_UNHINTED. This ensures workloads
>>> +        * that have not explicitly opted-in take benefit while capping the
>>> +        * potential for internal fragmentation.
>>> +        */
>>> +
>>> +       order = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
>>> +
>>> +       if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
>>> +               order = min(order, ANON_FOLIO_MAX_ORDER_UNHINTED);
>>> +
>>> +       return order;
>>> +}
>>
>> I don't understand why we still want to keep ANON_FOLIO_MAX_ORDER_UNHINTED.
>> 1. It's not used, since no archs at the moment implement
>> arch_wants_pte_order() that returns >64KB.
>> 2. As far as I know, there is no plan for any arch to do so.
> 
> My rationale is that arm64 is planning to use this for contpte mapping 2MB
> blocks for 16K and 64K kernels. But I think we will all agree that allowing 2MB
> blocks without the proper THP hinting is a bad plan.
> 
> As I see it, arches could add their own arch_wants_pte_order() at any time, and
> just because the HW has a preference, doesn't mean the SW shouldn't get a say.
> Its a negotiation between HW and SW for the LAF order, embodied in this policy.
> 
>> 3. Again, it seems to me the rationale behind
>> ANON_FOLIO_MAX_ORDER_UNHINTED isn't convincing at all.
>>
>> Can we introduce ANON_FOLIO_MAX_ORDER_UNHINTED  if/when needed please?
>>
>> Also you made arch_wants_pte_order() return -1, and I acknowledged [1]:
>>   Thanks: -1 actually is better than 0 (what I suggested) for the
>>   obvious reason.
>>
>> I thought we were on the same page, i.e., the "obvious reason" is that
>> h/w might prefer 0. But here you are not respecting 0. But then why
>> -1?
> 
> I agree that the "obvious reason" is that HW might prefer order-0. But the
> performance wins don't come solely from the HW. Batching up page faults is a big
> win for SW even if the HW doesn't benefit. So I think it is important that a HW
> preference of order-0 is possible to express through this API. But that doesn't
> mean that we don't listen to SW's preferences either.
> 
> I would really rather leave it in; As I've mentioned in the past, we have a
> partner who is actively keen to take advantage of 2MB blocks with 64K kernel and
> this is the mechanism that means we don't dole out those 2MB blocks unless
> explicitly opted-in.
Even so, I don't think we want to put the ANON_FOLIO_MAX_ORDER_UNHINTED hardcoded
in common mm code as it's useless to other ARCHs.

Another drawback is it brings trouble to do performance testing. People needs
either change code and recompile the kernel or add another knob to configure it.

Considering we are still on the phase to do more testing to understand the impact
of the LAF, I agree with Yu on this. Thanks.


Regards
Yin, Fengwei

> 
> I'm going to be out on holiday for a couple of weeks, so we might have to wait
> until I'm back to conclude on this, if you still take issue with the justification.
> 
> Thanks,
> Ryan
> 
> 
>>
>> [1] https://lore.kernel.org/linux-mm/CAOUHufZ7HJZW8Srwatyudf=FbwTGQtyq4DyL2SHwSg37N_Bo_A@mail.gmail.com/
> 
