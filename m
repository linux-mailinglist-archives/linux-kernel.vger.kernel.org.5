Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A75D779BD6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 02:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbjHLAXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 20:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbjHLAXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 20:23:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD87030DB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 17:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691799812; x=1723335812;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X2fjZ+gTwWQ8aASaDzhrEfr4bRk5nKHSSui3psdN79U=;
  b=MIWgA5NrIZIgko+3uq9we8aBtl8TinN36+d/cxQZnKAxIr0TCDmSwT39
   BYZvipwoBPNoPOE5DP/H+EMzwbCOCvfo5GGnD3mClBXCKjV54zMlAIiRr
   LGN2wY7PpIr2Rzl3LXqvZLwwiaYL9RTuciWQEmA0ssOa2fBFwh2g49fV1
   W29KelmMfU5GMybbA62IXZ09u5Q5dhHy+0IbvGypcHoEejANAqTUOG5Xo
   9lGmlFqZXet0INBc2/fO4SUCFGk3qCOAleMDsNVJUEiaLBtSuM6j04l8R
   ZpPrD+Bi8zyc/YR/1IKDyjdQG2+YwBbV4DbS6Dgm9/3RIm/PZK9AFBylV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="351393244"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="351393244"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 17:23:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="767832366"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="767832366"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 11 Aug 2023 17:23:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 17:23:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 17:23:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 11 Aug 2023 17:23:30 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 11 Aug 2023 17:23:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELLdiB7GJx6Q0VY55cNJlKMc3rpNcxFUeHcfONWyAM+kk2TPjlkbSXrrHoSAwAmj6EXaXGbIc0+ohbHYq0RO7FKcEd22MuwBcdQHYJlpSXO3QmtiNYxAOUtjqxKsytNrDuoFLjEN28J09YeLh0pyxIwp87YaUE0mXVyKJsYDzyZrU1eTMWpqILGAZ4ljNw0lPpIo6jF6WeMHrwcj5KzQrYhgg5jG95aoXL5G/7Fim8DwizkCHpEFGnwXRK4hle6VCmqYxVh17061pdtT4wG37Lg0YED7LFlcw2aoXNkYBVNABlxhYGOFUv0d5tgUGWD/ERnkmfatJhKJLvtHj7/Vsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5j2TsGOg1HWRgP2VXIPytkrhIWLoeWjGsNfyTgp7xOE=;
 b=AkE+a/fc097taV8rqgqcwbpNZP1ZO71+lNFBMLek3Z+d48O0meBySaauKvxMn0+oEzzjkpNAHj0FYI38SsXk/+7CPDRyBLrQkBRZnIdCpCAX9ga6BzOwdnBCIRFOzbCU/6e75HhnbFfL0WX9p20HQ8/44MDhetkqcMKY5tJGVt4DtqzQaDctMkzilbWc0wI+hN/3xFMm5o+xEVbl/neXdMJvdQH8M4HZyihPYbvzbgF2reEit+flycOA6zny4nq2mLyJrCVPjc1sXLnf/EOPLuZ7kF1HV08Ij3JvSdGtBTW4pm4oOKdHrpY5ZhfTrsTZ2J2iTyIssSt2511e1VVekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS0PR11MB7311.namprd11.prod.outlook.com (2603:10b6:8:11e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.22; Sat, 12 Aug
 2023 00:23:28 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6678.020; Sat, 12 Aug 2023
 00:23:28 +0000
Message-ID: <606ec06a-7598-4511-844a-2568bace3d1d@intel.com>
Date:   Sat, 12 Aug 2023 08:23:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] mm: LARGE_ANON_FOLIO for improved performance
To:     Zi Yan <ziy@nvidia.com>
CC:     Ryan Roberts <ryan.roberts@arm.com>, Yu Zhao <yuzhao@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230810142942.3169679-1-ryan.roberts@arm.com>
 <20230810142942.3169679-4-ryan.roberts@arm.com>
 <CAOUHufbUGwc2XvZOBmTCzMsOHxP-eLB60EdysKYzrkRMScOyMg@mail.gmail.com>
 <f97446e3-85d8-4d14-9fc0-683b31925325@arm.com>
 <16B84D1E-F234-414E-BA54-5893B6318E57@nvidia.com>
 <627c9081-68f6-49df-a270-1a5e47741d31@intel.com>
 <E657B3C2-6E44-461D-9AED-D37FB708FD4D@nvidia.com>
 <6f9c7746-6081-4eb5-a98c-575cebd09617@intel.com>
 <0514E8BE-4510-4DED-A50D-147211ED0CEA@nvidia.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <0514E8BE-4510-4DED-A50D-147211ED0CEA@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS0PR11MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: f952a9f3-8a3f-43c9-ad23-08db9aca591a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kq5UwUt4Sq1m+GEDg84O5AEI7vfWio/Dey3FW5yAMXv0iCl8CJD86PuVLIFhEQou6xqismqbm4PIxwZzUgbd+XZW80GaT8jCoHuDYEegxazqP3JK7mXCMI9kujvr+9HMIdrk2+LPdxITaxeBMqR+IyWYxnqIDNHlFJfLd8uRGuEgVv+usO8P4NUNRpcZHNwUghL10ERNVdykEtnUUP1RFlvlAUfd4GHblyQlAiRc18MAUZI/C/FeRMZpuZKH2o3g1/QVmWQ4/YEAhGrI7UiwIk0Dp4tJLjK7Ju3GzyFp2k/zDF6jIcfKccP+GIoVY4gmIUL/BDu88a9wQJhQ1jszhGWkSGU8D6qaLOPUrYxoijxVnvzg9qvOOcK5gNqCEl79OtdTBnag73pKB8ZOLY7IRajmCC+iUiGRJvUgCGVaZ5G577pFBWR/h5SRl3lRw2ZOzpXxnNpbvhv4I04AAuM4IzsLTmNSK2FQnMjGamfBlTN/H8wb1sDdbs5CzXZenF49kYpXDE2bKXoN2gDEuKMS55WN8X4L7wldcWjB1ZPNsoZGswWNa5cf/V0aRfg3MyqnmiBAIOyypmbodQkpmJbLDY4pxOFE6Akk9BfhUENBdjyjKXDp8zdChV2G7MQ/0QwkijjKUjkxnB/gwhKn97hKew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199021)(186006)(1800799006)(6486002)(6666004)(6512007)(966005)(54906003)(478600001)(2616005)(53546011)(26005)(6506007)(2906002)(30864003)(316002)(4326008)(6916009)(66476007)(66556008)(66946007)(41300700001)(5660300002)(7416002)(8676002)(8936002)(38100700002)(86362001)(31696002)(36756003)(83380400001)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHN1cSt2cEVUUzRLck96aW5ZWEVTbXU2ZG5pdlJyRmgvcTVONE5HUVdrV2h6?=
 =?utf-8?B?YmV1dTFvUyt2aWZhVFk5MGR5blc3WVByRStwbDR0WEs0UVM0aGF0QUFlcUFT?=
 =?utf-8?B?YW84M2U3U3phaGVNd2tWR2ZQaERQN1B3ODNLRDUzRXV5NzQ3OXJwSWhVMlZV?=
 =?utf-8?B?NmNjUzNoajRuR1JFekFKb1krdFZwU2RoR2tTalRiRnJMWW5lS1lUVmszOHhV?=
 =?utf-8?B?cXN3UkFTSUIwOHVUMHlkLzFaR1hWTG5sZUhQcXIwNUc3cE5TTDM4Ukx2RExj?=
 =?utf-8?B?N0UvQWxzZXVpaGZsNWxZSEpNQS9EbXBYOTVRWWZWaGQybnFSTW4wT0t5MkpN?=
 =?utf-8?B?SEgwRk1pKy9abkxQSTZaMXgvQ2JTU21uSHZOclo5VzlPa1kxOXdnYlF6QlZn?=
 =?utf-8?B?SExUZG95ZC80NXhUc3ZPbWZabkZEbDJXQ3hyb0V4QVBTNkx6cmZrSTIrdmZw?=
 =?utf-8?B?emtmS1NZZ1F3TFk2Y1JqZ0VVOUExZDQyTm9UNXRlcDBVakQxSWFQa3h4MTJ1?=
 =?utf-8?B?b1NoOHhYNlJtWENOS1h6ZHI4Qnl1WU8ydHhXNE9zM1pOMFpyVDZuMFAwTjIw?=
 =?utf-8?B?NzNEaVRDTG5zOGl2c2JoeVNLTThqSDdYakNHWHN1UXFJTnJGdEk3K0dsYjh2?=
 =?utf-8?B?ZDRGVkZqVXJsYndkdHo5ZjI1dVIyd1JzRXhSNzgwdm1aUCtwWkdKckE5dzZ5?=
 =?utf-8?B?eVFXL1ZzeDhtRklLbEg1SkNFNUV0QWw2akFxelBHYko0NzVPa1pwUEY4OU9B?=
 =?utf-8?B?NnNaay90UVgxb3FkNzhFdWNTR3RTcFhDVUdSdU5Gd2VIbmZYdEZERDVCTFoz?=
 =?utf-8?B?Q3VIUkhMZ1FtKzA0L3dUYU14SDhoWXI0VENvdi9OZ0Nxck9HaWhQUG9IUnlS?=
 =?utf-8?B?TUlmSjN2Tm4rUVZaS3Fna3pFeW1GTmtBY3hBV0RXaFJEVVJ5YTVFNTFuVGlI?=
 =?utf-8?B?Y2FLeDRLVEpkNDFSaUtNZ1BsSVVLQ0htMWhCbFM3aEV0SWVEQTZsdGZMTXVB?=
 =?utf-8?B?R3AvUjlzRlBEc3AvOTl4cWJPa241bFhxOW1zSEJudHlPRFhUMnJDdXdNdHN1?=
 =?utf-8?B?L2t1cWxveGxCbFRPb3ZaQXRLU05xTTZId0Z6U1JISThEUkxKdm52VWJMQjc2?=
 =?utf-8?B?ZG10clRGc3lTM2lCdnNXZkMvMUp3YldHZFNaRU8wN2I0cWpuRFR4YjRZazEx?=
 =?utf-8?B?WWhpSytoeS9zaE5PUjNCSTVXZnpOT1VYNElrR1FrVm9hekVmSUorcy8wTlJO?=
 =?utf-8?B?T3VOc3RwYjNVL0VGQ1A3TklHdDhSNVNpZUp3VjRsZWVZTlJYckE3Sk5LUUV0?=
 =?utf-8?B?UElqczNyQ1hoc1dBd0RSbExjd2tDZ1J5VU0rbWsycmZFZEFta3F0RUQ4MERj?=
 =?utf-8?B?dVRDbTQ4cERKdjB2VXR3dCtuYUt1ckhzbUsyWUtJV2NQR2V3NlBNdGsrLzJr?=
 =?utf-8?B?SVYwc0Q0SjdJbUNzRGkzRFd2N1FmUG1DS0c1SllTOWhlcThaQ2RqL09LRXdH?=
 =?utf-8?B?Q3RWdHhjeTJ4Rm95TDRGQml3TmFJOFcvTGZjNkluZUpyNU5rQng1WnphOFd2?=
 =?utf-8?B?b3kyUlVFSkVnYWlZQVA0UkF3d0xzU051aWI5c2hsL0ZzbkREdWtkbW1BYVVj?=
 =?utf-8?B?Sk1Va2hWTC9QUVRWREhaZTU3MzNtQ09ZVHBxSittRnR4dlNvbWpqVXI5ZGpz?=
 =?utf-8?B?dUtzcVZzTDNpZG9naG5qTHArUS9xVDl4VHovRjg4WlNURmpmZlRZcmlLVWZK?=
 =?utf-8?B?OStpTS82TmUyc2N4dWZRdjduYllWTDlHd09XNGNVSXA3dlVUTTV2MWFZcU9O?=
 =?utf-8?B?RjZJbU1zenhtN1g2TlZIOGJaRjZVa1lpaTIzeTdpcUVwdGU2NzcvOWNzcnFP?=
 =?utf-8?B?bnpnbWpRbG16T05KcjF2ZEIwcnJQRHJtQitOZVgyQmFZYTh6RXAvMytaeUsw?=
 =?utf-8?B?V3ZwR0hnd1hjZnVBbkZRSjJqcmJ1M1Awb1cxRkZCd25VeFIrQjBhQUNWcTBh?=
 =?utf-8?B?empTRldCLzhjSUVjc0x5WWdsbVlJaVVycjFvczkxRGNZTUpBM0VJUHh5aXJH?=
 =?utf-8?B?dFBoUGlYUVlNSkhXaXQ3eVd2bVZEVnBtc3Rwc0ZkcGZUYktYZU10R0N6NHFW?=
 =?utf-8?B?aHN2N0xZRnJ2QTRNRmVwdHRROFN1OStoQ2xNL0YzU3p4T09mdFJ5bTQwcC9h?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f952a9f3-8a3f-43c9-ad23-08db9aca591a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2023 00:23:27.9991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unIOEozav9o81qEt+T159UJnnzKxOki0O9UXKXCJHvb3FVsCdaZia4Ca+n3dxEf0wfSpTABDbe6zc0fLk5MwVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7311
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/2023 10:33 PM, Zi Yan wrote:
> On 11 Aug 2023, at 1:34, Yin, Fengwei wrote:
> 
>> On 8/11/2023 9:04 AM, Zi Yan wrote:
>>> On 10 Aug 2023, at 20:36, Yin, Fengwei wrote:
>>>
>>>> On 8/11/2023 3:46 AM, Zi Yan wrote:
>>>>> On 10 Aug 2023, at 15:12, Ryan Roberts wrote:
>>>>>
>>>>>> On 10/08/2023 18:01, Yu Zhao wrote:
>>>>>>> On Thu, Aug 10, 2023 at 8:30 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>>>
>>>>>>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
>>>>>>>> allocated in large folios of a determined order. All pages of the large
>>>>>>>> folio are pte-mapped during the same page fault, significantly reducing
>>>>>>>> the number of page faults. The number of per-page operations (e.g. ref
>>>>>>>> counting, rmap management lru list management) are also significantly
>>>>>>>> reduced since those ops now become per-folio.
>>>>>>>>
>>>>>>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
>>>>>>>> which defaults to disabled for now; The long term aim is for this to
>>>>>>>> defaut to enabled, but there are some risks around internal
>>>>>>>> fragmentation that need to be better understood first.
>>>>>>>>
>>>>>>>> Large anonymous folio (LAF) allocation is integrated with the existing
>>>>>>>> (PMD-order) THP and single (S) page allocation according to this policy,
>>>>>>>> where fallback (>) is performed for various reasons, such as the
>>>>>>>> proposed folio order not fitting within the bounds of the VMA, etc:
>>>>>>>>
>>>>>>>>                 | prctl=dis | prctl=ena   | prctl=ena     | prctl=ena
>>>>>>>>                 | sysfs=X   | sysfs=never | sysfs=madvise | sysfs=always
>>>>>>>> ----------------|-----------|-------------|---------------|-------------
>>>>>>>> no hint         | S         | LAF>S       | LAF>S         | THP>LAF>S
>>>>>>>> MADV_HUGEPAGE   | S         | LAF>S       | THP>LAF>S     | THP>LAF>S
>>>>>>>> MADV_NOHUGEPAGE | S         | S           | S             | S
>>>>>>>>
>>>>>>>> This approach ensures that we don't violate existing hints to only
>>>>>>>> allocate single pages - this is required for QEMU's VM live migration
>>>>>>>> implementation to work correctly - while allowing us to use LAF
>>>>>>>> independently of THP (when sysfs=never). This makes wide scale
>>>>>>>> performance characterization simpler, while avoiding exposing any new
>>>>>>>> ABI to user space.
>>>>>>>>
>>>>>>>> When using LAF for allocation, the folio order is determined as follows:
>>>>>>>> The return value of arch_wants_pte_order() is used. For vmas that have
>>>>>>>> not explicitly opted-in to use transparent hugepages (e.g. where
>>>>>>>> sysfs=madvise and the vma does not have MADV_HUGEPAGE or sysfs=never),
>>>>>>>> then arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever
>>>>>>>> is bigger). This allows for a performance boost without requiring any
>>>>>>>> explicit opt-in from the workload while limitting internal
>>>>>>>> fragmentation.
>>>>>>>>
>>>>>>>> If the preferred order can't be used (e.g. because the folio would
>>>>>>>> breach the bounds of the vma, or because ptes in the region are already
>>>>>>>> mapped) then we fall back to a suitable lower order; first
>>>>>>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>>>>>>>
>>>>>>>> arch_wants_pte_order() can be overridden by the architecture if desired.
>>>>>>>> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
>>>>>>>> set of ptes map physically contigious, naturally aligned memory, so this
>>>>>>>> mechanism allows the architecture to optimize as required.
>>>>>>>>
>>>>>>>> Here we add the default implementation of arch_wants_pte_order(), used
>>>>>>>> when the architecture does not define it, which returns -1, implying
>>>>>>>> that the HW has no preference. In this case, mm will choose it's own
>>>>>>>> default order.
>>>>>>>>
>>>>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>>>>> ---
>>>>>>>>  include/linux/pgtable.h |  13 ++++
>>>>>>>>  mm/Kconfig              |  10 +++
>>>>>>>>  mm/memory.c             | 144 +++++++++++++++++++++++++++++++++++++---
>>>>>>>>  3 files changed, 158 insertions(+), 9 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>>>>>> index 222a33b9600d..4b488cc66ddc 100644
>>>>>>>> --- a/include/linux/pgtable.h
>>>>>>>> +++ b/include/linux/pgtable.h
>>>>>>>> @@ -369,6 +369,19 @@ static inline bool arch_has_hw_pte_young(void)
>>>>>>>>  }
>>>>>>>>  #endif
>>>>>>>>
>>>>>>>> +#ifndef arch_wants_pte_order
>>>>>>>> +/*
>>>>>>>> + * Returns preferred folio order for pte-mapped memory. Must be in range [0,
>>>>>>>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires large folios
>>>>>>>> + * to be at least order-2. Negative value implies that the HW has no preference
>>>>>>>> + * and mm will choose it's own default order.
>>>>>>>> + */
>>>>>>>> +static inline int arch_wants_pte_order(void)
>>>>>>>> +{
>>>>>>>> +       return -1;
>>>>>>>> +}
>>>>>>>> +#endif
>>>>>>>> +
>>>>>>>>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>>>>>>>>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>>>>>>>                                        unsigned long address,
>>>>>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>>>>>> index 721dc88423c7..a1e28b8ddc24 100644
>>>>>>>> --- a/mm/Kconfig
>>>>>>>> +++ b/mm/Kconfig
>>>>>>>> @@ -1243,4 +1243,14 @@ config LOCK_MM_AND_FIND_VMA
>>>>>>>>
>>>>>>>>  source "mm/damon/Kconfig"
>>>>>>>>
>>>>>>>> +config LARGE_ANON_FOLIO
>>>>>>>> +       bool "Allocate large folios for anonymous memory"
>>>>>>>> +       depends on TRANSPARENT_HUGEPAGE
>>>>>>>> +       default n
>>>>>>>> +       help
>>>>>>>> +         Use large (bigger than order-0) folios to back anonymous memory where
>>>>>>>> +         possible, even for pte-mapped memory. This reduces the number of page
>>>>>>>> +         faults, as well as other per-page overheads to improve performance for
>>>>>>>> +         many workloads.
>>>>>>>> +
>>>>>>>>  endmenu
>>>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>>>> index d003076b218d..bbc7d4ce84f7 100644
>>>>>>>> --- a/mm/memory.c
>>>>>>>> +++ b/mm/memory.c
>>>>>>>> @@ -4073,6 +4073,123 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>>>>>         return ret;
>>>>>>>>  }
>>>>>>>>
>>>>>>>> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages)
>>>>>>>> +{
>>>>>>>> +       int i;
>>>>>>>> +
>>>>>>>> +       if (nr_pages == 1)
>>>>>>>> +               return vmf_pte_changed(vmf);
>>>>>>>> +
>>>>>>>> +       for (i = 0; i < nr_pages; i++) {
>>>>>>>> +               if (!pte_none(ptep_get_lockless(vmf->pte + i)))
>>>>>>>> +                       return true;
>>>>>>>> +       }
>>>>>>>> +
>>>>>>>> +       return false;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +#ifdef CONFIG_LARGE_ANON_FOLIO
>>>>>>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
>>>>>>>> +               (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_SHIFT)
>>>>>>>> +
>>>>>>>> +static int anon_folio_order(struct vm_area_struct *vma)
>>>>>>>> +{
>>>>>>>> +       int order;
>>>>>>>> +
>>>>>>>> +       /*
>>>>>>>> +        * If the vma is eligible for thp, allocate a large folio of the size
>>>>>>>> +        * preferred by the arch. Or if the arch requested a very small size or
>>>>>>>> +        * didn't request a size, then use PAGE_ALLOC_COSTLY_ORDER, which still
>>>>>>>> +        * meets the arch's requirements but means we still take advantage of SW
>>>>>>>> +        * optimizations (e.g. fewer page faults).
>>>>>>>> +        *
>>>>>>>> +        * If the vma isn't eligible for thp, take the arch-preferred size and
>>>>>>>> +        * limit it to ANON_FOLIO_MAX_ORDER_UNHINTED. This ensures workloads
>>>>>>>> +        * that have not explicitly opted-in take benefit while capping the
>>>>>>>> +        * potential for internal fragmentation.
>>>>>>>> +        */
>>>>>>>> +
>>>>>>>> +       order = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
>>>>>>>> +
>>>>>>>> +       if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
>>>>>>>> +               order = min(order, ANON_FOLIO_MAX_ORDER_UNHINTED);
>>>>>>>> +
>>>>>>>> +       return order;
>>>>>>>> +}
>>>>>>>
>>>>>>> I don't understand why we still want to keep ANON_FOLIO_MAX_ORDER_UNHINTED.
>>>>>>> 1. It's not used, since no archs at the moment implement
>>>>>>> arch_wants_pte_order() that returns >64KB.
>>>>>>> 2. As far as I know, there is no plan for any arch to do so.
>>>>>>
>>>>>> My rationale is that arm64 is planning to use this for contpte mapping 2MB
>>>>>> blocks for 16K and 64K kernels. But I think we will all agree that allowing 2MB
>>>>>> blocks without the proper THP hinting is a bad plan.
>>>>>>
>>>>>> As I see it, arches could add their own arch_wants_pte_order() at any time, and
>>>>>> just because the HW has a preference, doesn't mean the SW shouldn't get a say.
>>>>>> Its a negotiation between HW and SW for the LAF order, embodied in this policy.
>>>>>>
>>>>>>> 3. Again, it seems to me the rationale behind
>>>>>>> ANON_FOLIO_MAX_ORDER_UNHINTED isn't convincing at all.
>>>>>>>
>>>>>>> Can we introduce ANON_FOLIO_MAX_ORDER_UNHINTED  if/when needed please?
>>>>>>>
>>>>>>> Also you made arch_wants_pte_order() return -1, and I acknowledged [1]:
>>>>>>>   Thanks: -1 actually is better than 0 (what I suggested) for the
>>>>>>>   obvious reason.
>>>>>>>
>>>>>>> I thought we were on the same page, i.e., the "obvious reason" is that
>>>>>>> h/w might prefer 0. But here you are not respecting 0. But then why
>>>>>>> -1?
>>>>>>
>>>>>> I agree that the "obvious reason" is that HW might prefer order-0. But the
>>>>>> performance wins don't come solely from the HW. Batching up page faults is a big
>>>>>> win for SW even if the HW doesn't benefit. So I think it is important that a HW
>>>>>> preference of order-0 is possible to express through this API. But that doesn't
>>>>>> mean that we don't listen to SW's preferences either.
>>>>>>
>>>>>> I would really rather leave it in; As I've mentioned in the past, we have a
>>>>>> partner who is actively keen to take advantage of 2MB blocks with 64K kernel and
>>>>>> this is the mechanism that means we don't dole out those 2MB blocks unless
>>>>>> explicitly opted-in.
>>>>>>
>>>>>> I'm going to be out on holiday for a couple of weeks, so we might have to wait
>>>>>> until I'm back to conclude on this, if you still take issue with the justification.
>>>>>
>>>>> From my understanding (correct me if I am wrong), Yu seems to want order-0 to be
>>>>> the default order even if LAF is enabled. But that does not make sense to me, since
>>>>> if LAF is configured to be enabled (it is disabled by default now), user (and distros)
>>>>> must think LAF is giving benefit. Otherwise, they will just disable LAF at compilation
>>>>> time or by using prctl. Enabling LAF and using order-0 as the default order makes
>>>>> most of LAF code not used.
>>>> For the device with limited memory size and it still wants LAF enabled for some specific
>>>> memory ranges, it's possible the LAF is enabled, order-0 as default order and use madvise
>>>> to enable LAF for specific memory ranges.
>>>
>>> Do you have a use case? Or it is just a possible scenario?
>> It's a possible scenario. Per my experience, it's valid use case for embedded
>> system or low end android phone.
>>
>>>
>>> IIUC, Ryan has a concrete use case for his choice. For ARM64 with 16KB/64KB
>>> base pages, 2MB folios (LAF in this config) would be desirable since THP is
>>> 32MB/512MB and much harder to get.
>>>
>>>>
>>>> So my understanding is it's possible case. But it's another configuration thing and not
>>>> necessary to be finalized now.
>>>
>>> Basically, we are deciding whether LAF should use order-0 by default once it is
>>> compiled in to kernel. From your other email on ANON_FOLIO_MAX_ORDER_UNHINTED,
>>> your argument is that code change is needed to test the impact of LAF with
>>> different orders. That seems to imply we actually need an extra knob (maybe sysctl)
>>> to control the max LAF order. And with that extra knob, we can solve this default
>>> order problem, since we can set it to 0 for devices want to opt in LAF and set
>>> it N (like 64KB) for other devices want to opt out LAF.
>> From performance tuning perspective, it's necessary to have knobs to configure and
>> check the attribute of LAF. But we must be careful to add the knobs as they need
>> be maintained for ever.
> 
> If we do not want to maintain such a knob (since it may take some time to finalize)
> and tweaking LAF order is important for us to explore different LAF configurations
> (Ryan thinks 64KB will perform well on ARM64, whereas Yu mentioned 16KB/32KB is
> better in his use cases), we probably just put the LAF order knob in debugfs
> like Ryan suggested before to move forward.
Works for me.

> 
> 
>>>
>>> So maybe we need the extra knob for both testing purpose and serving different
>>> device configuration purpose.
>>>
>>>>>
>>>>> Also arch_wants_pte_order() might need a better name like
>>>>> arch_wants_large_folio_order(). Since current name sounds like the specified order
>>>>> is wanted by HW in a general setting, but it is not. It is an order HW wants
>>>>> when LAF is enabled. That might cause some confusion.
>>>>>
>>>>>>>
>>>>>>> [1] https://lore.kernel.org/linux-mm/CAOUHufZ7HJZW8Srwatyudf=FbwTGQtyq4DyL2SHwSg37N_Bo_A@mail.gmail.com/
>>>>>
>>>>>
>>>>> --
>>>>> Best Regards,
>>>>> Yan, Zi
>>>
>>>
>>> --
>>> Best Regards,
>>> Yan, Zi
> 
> 
> --
> Best Regards,
> Yan, Zi
