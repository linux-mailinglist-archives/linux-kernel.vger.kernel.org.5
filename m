Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D9478E3D0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 02:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244451AbjHaAOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 20:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245285AbjHaAOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 20:14:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE448CDD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693440878; x=1724976878;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zN0e24RZCi10BHG/PH++qmxzhWzbDkwHntiWCn9CWUY=;
  b=Ed6xTUCGtZG+GTCqsff4QzfFzC/bTeO1cVnxfXT2IfD/GOM4PY8jIL4Q
   fGxgXvdJFcUWX/PSE4P7iU7+Nfq8Lwcij7TFAys7JUsZWxQZbberMoMKa
   9K0ErlkW0hVm1ysvBup/pb+GKe4u3FmWPYDiGCN0EnNyA84X3JvMYZARc
   ZEwxd7XiUGdJeThEbkAtwfUxWMylTmC6+fVhp41QpMb0RvmJSKjr9vqle
   yCOI9ijfDnUvvHzZSZjf1AZ7+P7CDGwJC82vUQQIEHFFMxZODaf17onOS
   VZZehgRWGmK4mrvgdKS//t5rW4IdYL2lNkZVjEo3TowiMngcsbwlhUqAf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="375733133"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="375733133"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 17:14:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="689099162"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="689099162"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2023 17:14:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 17:14:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 17:14:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 17:14:36 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 17:14:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFi5e7sbcworAM/do5qjyriJnZ/L5aw9Q1ikXlT2g5OJ2u+plsatwklKVpu5GakD6JjsJepflbVjzYEl0pkrayuFuL0FDpr1PeFJOpSqGi8vYApMAuz9HXNUbCMU2camgCcmhQ6BYRnEU/1HRfj78oxKR47OsCpjgq7ydcM0oevGORaAUYWuRaUwXvXZZ1iSoNzozJOOHcteLCer/zyd049zW+1xgCBgAGlbn591nC/NXkz13N57qUY/6LyM31YGSE1RTNgpWnIbDwhh3yW1nDJwAXL1qu0g2q2Er8wZj4/F4ep2rw1+hcimIDpyE/POXTf15qQyac8xmkvg25LqIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCQWZSab7IXrIpH2lfLtxauTLWC5LxZEa+mdFq5Cqa8=;
 b=nlZUyVLl/YgshuhEIe9iISRxvH8pbnQ1reqL7u+krvpi+EInHjAg4xLeRouPlMgGWhqrlaHtNIkrLZHZfZdZevLGs6MdEXlYA83OW6JGnLvnU2iJ8yVx8x6F2uD4FWBvAKRMWWahSEbxNRrJ0AOGYc6X7pWZ4MkflgbiKQJkKHME0iNJyb+XIQutsup0HHFyBN+Abi0D5eB3c+pM++Yy0KO6oFWYvA1AV3GRwQk4DLdveFNtJKADh/m7RUXTA8kT4/R4f7doylKpwA3GTpcvsHEaedQna59Vk3mCTwku+vFLjBluH0f2SvN8alGtpznDN1Z4vDZcQTr0uNKtyQkdmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH8PR11MB6708.namprd11.prod.outlook.com (2603:10b6:510:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 00:14:31 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6%4]) with mapi id 15.20.6745.015; Thu, 31 Aug 2023
 00:14:31 +0000
Message-ID: <c56c72ea-b523-4a6a-bf29-9ed30f48b989@intel.com>
Date:   Thu, 31 Aug 2023 08:14:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] mm: LARGE_ANON_FOLIO for improved performance
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>
CC:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
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
 <606ec06a-7598-4511-844a-2568bace3d1d@intel.com>
 <1311d7de-65fc-4212-b112-b2ee398a4082@arm.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <1311d7de-65fc-4212-b112-b2ee398a4082@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH8PR11MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5b788b-24ea-48aa-5f1d-08dba9b73f75
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HApFO+/MvKowQ+DZ7sye2q1biC9G0oVxlrnMPknujIICp/au0ExcGxItnDqi3mLt9HzzT92VI9DxPAwxMcXViSaBcwcD9SB/VbwfZjgWCuqK8tPDLzbLKWYnuzuekTYzZQECgoltg1vw4Seoapev0rQtTRID51h3qYF+K+5qFYdUqNuN5Q+vWzClfNoyPiPmfft3g0I+e9Dw6tjQRT5I2rjxk3TUDhwdb4z8w3vCYhge2XDRxXfHW+a1OHgN3/ENhvSQQCDNknkiNEk3k17ZCdLEEZitlFzX2YU2UPoiQLsuaje/9h3thGziXGI0p+9VNzzO7JQDT7SN05CYElQO/4Qp5wLteWNFpJKfFnp47bOqCUsF1R92vMyrNhxBl45aN1gd4gilL1PwWw9O9+ESX5h1OOn7JNl3UspJegrmG98DlYzd08SB23/uvjLq92v4IXEAzl7SI5ag+adLG7zz27YFzqaQJm4gQNfbNfKTY1+loeDBTFX/hIhtfogjf+cPYNWTpIGy66y7+72Bt2LmbVMYX4BGy6CnPGDVPVFiGlqUA7uCZcMBgmrVGIRRXgfl6p/tZEkoNsn6YW067IKTPGdLIdNAjXLY0j1r4AziNsDURl1nmLtFlxmuAA9qp6GmDEHxO6+O1/Is1iXhLM6yEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(1800799009)(186009)(451199024)(478600001)(66899024)(54906003)(66476007)(66946007)(66556008)(82960400001)(316002)(38100700002)(110136005)(966005)(2906002)(30864003)(31696002)(7416002)(41300700001)(8676002)(86362001)(8936002)(5660300002)(6512007)(4326008)(83380400001)(6486002)(26005)(53546011)(6506007)(6666004)(2616005)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkhjZFZ4VU5ubXpyaGRyOWFmSVJuMXFteE94V3B2ZTA3bTgzamtrNURsN1M5?=
 =?utf-8?B?eFhSU3ZPd1BaQ25OVU5jQmhaVGVvVFg3Ty9RdHFJUVp4dGYzTzFMc0VoSUtX?=
 =?utf-8?B?dkkyUUVkdU9VTiswaFhZRlRPRmpzSzZLS3FSbHRTSnprbUtjbTdmZGJCc0hP?=
 =?utf-8?B?dTFRVjdXaktLeWZ1SjFKSENDTnozaytZVklBMFJrb05KdDNIZ0xSc1UzbVEx?=
 =?utf-8?B?Unk1eE1CTDlYOTVwcU90Um5JcXRra2Q5YTBHVzUyRzdvQWxpSHl6OGJvbXRm?=
 =?utf-8?B?clFPQzM1M0FwMnUwY1FIblY2c3A5LzcxVWJ6ZFJrbnBmTHZtcjVBOGlRdVBV?=
 =?utf-8?B?RVg3Q05HZnAzUzRMM0RCdkQ1NitHN1h6Q3JXZkYraDRRV0VCLzFDaUhCMmNM?=
 =?utf-8?B?d3AxS1Vnd3J0Umo5WCs3cTBwQTlaUHBadjUxS3M4cWVtc1F2WU5ZeVErVkxx?=
 =?utf-8?B?MzQ2RXBKM0xyWVZJOFQzbkpMMGFsU1RHRUtFeUwyNmp4S3VnRGsxL0xsRktG?=
 =?utf-8?B?R2ROb0dsZHE5SVRQOGZHWEhhcUpSK2pVZ1o0VE9pajFZNWJ4Mm9uVVExL1VQ?=
 =?utf-8?B?Z0ZWUVZZelJHTUxwbHBRQzdLTmkvdnZDckZVNUErZVBSN1lBWjlKbnMxYmFi?=
 =?utf-8?B?TGZIWEsyajloYktDVjN4SGdPOTBQbm1ZRHBOSGlJYUtIa1FDNkNLTkt4Vkxs?=
 =?utf-8?B?MWExeUZVNEhtQ1pUNDVobWpDZWZuZmVJaHdCaytqQXF5SzdxY1ZSSXA1MWNi?=
 =?utf-8?B?enpXb09EKzFRVlVRWS8rcGlBditkc0tJU3VZbWpUbERxSGxpY3V3Rmpzd1NO?=
 =?utf-8?B?cFpzZDd0ZzRaMjRialpYcmxQcXJXeGsrMEhIRGduMDE4MzhGWFZNRHFLWmZq?=
 =?utf-8?B?QTlDcE9wMzNkMWZvR2pYSU1GS1pNS1dEOVVuTUZMYjdZVTlKSGxHcXplSDgv?=
 =?utf-8?B?aXhsUGlubWZtd2svVXNybURlbVc4Z1VKdjdraEJBTjY1TUlXTUorcm1nQUY3?=
 =?utf-8?B?MzQzZFMyb29VNzRrYUd3OEovWURvQnFDMXo0R0hyaVdJZHYwUkZiU3lTUHVD?=
 =?utf-8?B?TFo1dVIyTTMxMjFWRVlKYUlmdGJIdERaUVgrMld2RHdsVXJtRTRHTm80bWl4?=
 =?utf-8?B?dXMySG5xbXNFU3REUFhJeEVLblFtanNLYkI5eC9nOTJXOFhRZllwZit0Kyt5?=
 =?utf-8?B?bm02K0VsaTQwSHdPUGRoVk9YRkZpZ1RlZzZON0NSNVRneWRiYy9ZRDl4NkRa?=
 =?utf-8?B?K3NNMzl6clUvWUFvTktudVR2OHRyVGZHK1hxWmlwQ2hTYzZTQ1dvSlptS1ND?=
 =?utf-8?B?bWVTRTdndUNaSFFkVHRlUE1MMVlMbFVNM2t0cEE1SXNOTWhNbVgydmZmcVpl?=
 =?utf-8?B?VTZXRVl4L1dJT3FDeTI3b2krYWlLZk1NeHIyV01hZG52dk5hN2l3YUtUVGxH?=
 =?utf-8?B?aTFrVnJiOTQ0SUhYY1h1UDg3a3NLQ3FxcWw4SWhLUEVRaUtCOWlsVlRNOGRw?=
 =?utf-8?B?aE5tZFB2ZWpCczZnWDYwN2RoUHJheU13SmJHN0w4MGpMVUhxK003bmJObDJu?=
 =?utf-8?B?OFFCakd6WHRwc2I1NDdnK3JKRkErenZkNTUwQVRkVUxScHBnVHRlYWJ5djN3?=
 =?utf-8?B?T2xPa2grRFRqMi84cmQ2bVFaNXg3V3V6VDlmYlVQUTMrSlJoUE5rWkZXRzhM?=
 =?utf-8?B?RkxrSlJ5aE8rdmgwVGN0eDZnemswbEZoZWZnNkg5N2dqcW9PTjNKRUluaHhv?=
 =?utf-8?B?WE54QkJkTlJSNElQa3hXMy8wWEZRWGtDaEwreVUwL3dRTzNQbm8vWkhyQzdm?=
 =?utf-8?B?UkhPM1dPTENsajQzcVdOMWROWTk1aVp4d24yYkNZQ3dFQUVKNmpRbzVXbmpW?=
 =?utf-8?B?TGY2cWNaOVUzNGtjWWFIUmxyc0o1R25oL3RIKzhRYkJzQWt1WE9qWWZkZUw4?=
 =?utf-8?B?TEZwTU1JUjlrM3U2SUtNUzd3d050TElEY05CK0NBVTJJdVlDTTNTdVRJSDVV?=
 =?utf-8?B?L21EdVhmUS9HYW9ONy9FSzBjaHYyVzcyUkt4WmxiSU9vVWNiRnFTdFhEa29B?=
 =?utf-8?B?dXR1ZDYvTk4xdGpzWTg3N2hiVStVWnZSQjRYYU1wTWNrWTYwMTl5aWk0SXZk?=
 =?utf-8?B?RWVndEhvbzNxR2VpNkFEa08vcmpRNmVnNVp6VHArS1hqbndCNmxZUDJlc0h5?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5b788b-24ea-48aa-5f1d-08dba9b73f75
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 00:14:31.2664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VmVHNGxstYIzbJ78iAMMKtaDNSuqfVgQLH+ooB3ZIutixEPBfXsQPfiH+SYDWGBjcF9GLq4qXMuiBB5qsUGlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6708
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/2023 7:41 PM, Ryan Roberts wrote:
> Sorry for the delay in responding (I've been out on holiday). Questions for Yu,
> Zi and Yin below...
> 
> 
> On 12/08/2023 01:23, Yin, Fengwei wrote:
>>
>>
>> On 8/11/2023 10:33 PM, Zi Yan wrote:
>>> On 11 Aug 2023, at 1:34, Yin, Fengwei wrote:
>>>
>>>> On 8/11/2023 9:04 AM, Zi Yan wrote:
>>>>> On 10 Aug 2023, at 20:36, Yin, Fengwei wrote:
>>>>>
>>>>>> On 8/11/2023 3:46 AM, Zi Yan wrote:
>>>>>>> On 10 Aug 2023, at 15:12, Ryan Roberts wrote:
>>>>>>>
>>>>>>>> On 10/08/2023 18:01, Yu Zhao wrote:
>>>>>>>>> On Thu, Aug 10, 2023 at 8:30 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>>>>>
>>>>>>>>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
>>>>>>>>>> allocated in large folios of a determined order. All pages of the large
>>>>>>>>>> folio are pte-mapped during the same page fault, significantly reducing
>>>>>>>>>> the number of page faults. The number of per-page operations (e.g. ref
>>>>>>>>>> counting, rmap management lru list management) are also significantly
>>>>>>>>>> reduced since those ops now become per-folio.
>>>>>>>>>>
>>>>>>>>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
>>>>>>>>>> which defaults to disabled for now; The long term aim is for this to
>>>>>>>>>> defaut to enabled, but there are some risks around internal
>>>>>>>>>> fragmentation that need to be better understood first.
>>>>>>>>>>
>>>>>>>>>> Large anonymous folio (LAF) allocation is integrated with the existing
>>>>>>>>>> (PMD-order) THP and single (S) page allocation according to this policy,
>>>>>>>>>> where fallback (>) is performed for various reasons, such as the
>>>>>>>>>> proposed folio order not fitting within the bounds of the VMA, etc:
>>>>>>>>>>
>>>>>>>>>>                 | prctl=dis | prctl=ena   | prctl=ena     | prctl=ena
>>>>>>>>>>                 | sysfs=X   | sysfs=never | sysfs=madvise | sysfs=always
>>>>>>>>>> ----------------|-----------|-------------|---------------|-------------
>>>>>>>>>> no hint         | S         | LAF>S       | LAF>S         | THP>LAF>S
>>>>>>>>>> MADV_HUGEPAGE   | S         | LAF>S       | THP>LAF>S     | THP>LAF>S
>>>>>>>>>> MADV_NOHUGEPAGE | S         | S           | S             | S
>>>>>>>>>>
>>>>>>>>>> This approach ensures that we don't violate existing hints to only
>>>>>>>>>> allocate single pages - this is required for QEMU's VM live migration
>>>>>>>>>> implementation to work correctly - while allowing us to use LAF
>>>>>>>>>> independently of THP (when sysfs=never). This makes wide scale
>>>>>>>>>> performance characterization simpler, while avoiding exposing any new
>>>>>>>>>> ABI to user space.
>>>>>>>>>>
>>>>>>>>>> When using LAF for allocation, the folio order is determined as follows:
>>>>>>>>>> The return value of arch_wants_pte_order() is used. For vmas that have
>>>>>>>>>> not explicitly opted-in to use transparent hugepages (e.g. where
>>>>>>>>>> sysfs=madvise and the vma does not have MADV_HUGEPAGE or sysfs=never),
>>>>>>>>>> then arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever
>>>>>>>>>> is bigger). This allows for a performance boost without requiring any
>>>>>>>>>> explicit opt-in from the workload while limitting internal
>>>>>>>>>> fragmentation.
>>>>>>>>>>
>>>>>>>>>> If the preferred order can't be used (e.g. because the folio would
>>>>>>>>>> breach the bounds of the vma, or because ptes in the region are already
>>>>>>>>>> mapped) then we fall back to a suitable lower order; first
>>>>>>>>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>>>>>>>>>
>>>>>>>>>> arch_wants_pte_order() can be overridden by the architecture if desired.
>>>>>>>>>> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
>>>>>>>>>> set of ptes map physically contigious, naturally aligned memory, so this
>>>>>>>>>> mechanism allows the architecture to optimize as required.
>>>>>>>>>>
>>>>>>>>>> Here we add the default implementation of arch_wants_pte_order(), used
>>>>>>>>>> when the architecture does not define it, which returns -1, implying
>>>>>>>>>> that the HW has no preference. In this case, mm will choose it's own
>>>>>>>>>> default order.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>>>>>>> ---
>>>>>>>>>>  include/linux/pgtable.h |  13 ++++
>>>>>>>>>>  mm/Kconfig              |  10 +++
>>>>>>>>>>  mm/memory.c             | 144 +++++++++++++++++++++++++++++++++++++---
>>>>>>>>>>  3 files changed, 158 insertions(+), 9 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>>>>>>>> index 222a33b9600d..4b488cc66ddc 100644
>>>>>>>>>> --- a/include/linux/pgtable.h
>>>>>>>>>> +++ b/include/linux/pgtable.h
>>>>>>>>>> @@ -369,6 +369,19 @@ static inline bool arch_has_hw_pte_young(void)
>>>>>>>>>>  }
>>>>>>>>>>  #endif
>>>>>>>>>>
>>>>>>>>>> +#ifndef arch_wants_pte_order
>>>>>>>>>> +/*
>>>>>>>>>> + * Returns preferred folio order for pte-mapped memory. Must be in range [0,
>>>>>>>>>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires large folios
>>>>>>>>>> + * to be at least order-2. Negative value implies that the HW has no preference
>>>>>>>>>> + * and mm will choose it's own default order.
>>>>>>>>>> + */
>>>>>>>>>> +static inline int arch_wants_pte_order(void)
>>>>>>>>>> +{
>>>>>>>>>> +       return -1;
>>>>>>>>>> +}
>>>>>>>>>> +#endif
>>>>>>>>>> +
>>>>>>>>>>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>>>>>>>>>>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>>>>>>>>>                                        unsigned long address,
>>>>>>>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>>>>>>>> index 721dc88423c7..a1e28b8ddc24 100644
>>>>>>>>>> --- a/mm/Kconfig
>>>>>>>>>> +++ b/mm/Kconfig
>>>>>>>>>> @@ -1243,4 +1243,14 @@ config LOCK_MM_AND_FIND_VMA
>>>>>>>>>>
>>>>>>>>>>  source "mm/damon/Kconfig"
>>>>>>>>>>
>>>>>>>>>> +config LARGE_ANON_FOLIO
>>>>>>>>>> +       bool "Allocate large folios for anonymous memory"
>>>>>>>>>> +       depends on TRANSPARENT_HUGEPAGE
>>>>>>>>>> +       default n
>>>>>>>>>> +       help
>>>>>>>>>> +         Use large (bigger than order-0) folios to back anonymous memory where
>>>>>>>>>> +         possible, even for pte-mapped memory. This reduces the number of page
>>>>>>>>>> +         faults, as well as other per-page overheads to improve performance for
>>>>>>>>>> +         many workloads.
>>>>>>>>>> +
>>>>>>>>>>  endmenu
>>>>>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>>>>>> index d003076b218d..bbc7d4ce84f7 100644
>>>>>>>>>> --- a/mm/memory.c
>>>>>>>>>> +++ b/mm/memory.c
>>>>>>>>>> @@ -4073,6 +4073,123 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>>>>>>>         return ret;
>>>>>>>>>>  }
>>>>>>>>>>
>>>>>>>>>> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages)
>>>>>>>>>> +{
>>>>>>>>>> +       int i;
>>>>>>>>>> +
>>>>>>>>>> +       if (nr_pages == 1)
>>>>>>>>>> +               return vmf_pte_changed(vmf);
>>>>>>>>>> +
>>>>>>>>>> +       for (i = 0; i < nr_pages; i++) {
>>>>>>>>>> +               if (!pte_none(ptep_get_lockless(vmf->pte + i)))
>>>>>>>>>> +                       return true;
>>>>>>>>>> +       }
>>>>>>>>>> +
>>>>>>>>>> +       return false;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +#ifdef CONFIG_LARGE_ANON_FOLIO
>>>>>>>>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
>>>>>>>>>> +               (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_SHIFT)
>>>>>>>>>> +
>>>>>>>>>> +static int anon_folio_order(struct vm_area_struct *vma)
>>>>>>>>>> +{
>>>>>>>>>> +       int order;
>>>>>>>>>> +
>>>>>>>>>> +       /*
>>>>>>>>>> +        * If the vma is eligible for thp, allocate a large folio of the size
>>>>>>>>>> +        * preferred by the arch. Or if the arch requested a very small size or
>>>>>>>>>> +        * didn't request a size, then use PAGE_ALLOC_COSTLY_ORDER, which still
>>>>>>>>>> +        * meets the arch's requirements but means we still take advantage of SW
>>>>>>>>>> +        * optimizations (e.g. fewer page faults).
>>>>>>>>>> +        *
>>>>>>>>>> +        * If the vma isn't eligible for thp, take the arch-preferred size and
>>>>>>>>>> +        * limit it to ANON_FOLIO_MAX_ORDER_UNHINTED. This ensures workloads
>>>>>>>>>> +        * that have not explicitly opted-in take benefit while capping the
>>>>>>>>>> +        * potential for internal fragmentation.
>>>>>>>>>> +        */
>>>>>>>>>> +
>>>>>>>>>> +       order = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
>>>>>>>>>> +
>>>>>>>>>> +       if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
>>>>>>>>>> +               order = min(order, ANON_FOLIO_MAX_ORDER_UNHINTED);
>>>>>>>>>> +
>>>>>>>>>> +       return order;
>>>>>>>>>> +}
>>>>>>>>>
>>>>>>>>> I don't understand why we still want to keep ANON_FOLIO_MAX_ORDER_UNHINTED.
>>>>>>>>> 1. It's not used, since no archs at the moment implement
>>>>>>>>> arch_wants_pte_order() that returns >64KB.
>>>>>>>>> 2. As far as I know, there is no plan for any arch to do so.
>>>>>>>>
>>>>>>>> My rationale is that arm64 is planning to use this for contpte mapping 2MB
>>>>>>>> blocks for 16K and 64K kernels. But I think we will all agree that allowing 2MB
>>>>>>>> blocks without the proper THP hinting is a bad plan.
>>>>>>>>
>>>>>>>> As I see it, arches could add their own arch_wants_pte_order() at any time, and
>>>>>>>> just because the HW has a preference, doesn't mean the SW shouldn't get a say.
>>>>>>>> Its a negotiation between HW and SW for the LAF order, embodied in this policy.
> 
> Yu, I never saw a reply to this. Have I managed to convince you? I'm willing to
> put the vma param back into arch_wants_pte_order() and handle the policy in the
> arch, if you consider that a less bad solution.
> 
>>>>>>>>
>>>>>>>>> 3. Again, it seems to me the rationale behind
>>>>>>>>> ANON_FOLIO_MAX_ORDER_UNHINTED isn't convincing at all.
>>>>>>>>>
>>>>>>>>> Can we introduce ANON_FOLIO_MAX_ORDER_UNHINTED  if/when needed please?
>>>>>>>>>
>>>>>>>>> Also you made arch_wants_pte_order() return -1, and I acknowledged [1]:
>>>>>>>>>   Thanks: -1 actually is better than 0 (what I suggested) for the
>>>>>>>>>   obvious reason.
>>>>>>>>>
>>>>>>>>> I thought we were on the same page, i.e., the "obvious reason" is that
>>>>>>>>> h/w might prefer 0. But here you are not respecting 0. But then why
>>>>>>>>> -1?
>>>>>>>>
>>>>>>>> I agree that the "obvious reason" is that HW might prefer order-0. But the
>>>>>>>> performance wins don't come solely from the HW. Batching up page faults is a big
>>>>>>>> win for SW even if the HW doesn't benefit. So I think it is important that a HW
>>>>>>>> preference of order-0 is possible to express through this API. But that doesn't
>>>>>>>> mean that we don't listen to SW's preferences either.
>>>>>>>>
>>>>>>>> I would really rather leave it in; As I've mentioned in the past, we have a
>>>>>>>> partner who is actively keen to take advantage of 2MB blocks with 64K kernel and
>>>>>>>> this is the mechanism that means we don't dole out those 2MB blocks unless
>>>>>>>> explicitly opted-in.
> 
> Yu, would appreciate any comments here.
> 
>>>>>>>>
>>>>>>>> I'm going to be out on holiday for a couple of weeks, so we might have to wait
>>>>>>>> until I'm back to conclude on this, if you still take issue with the justification.
>>>>>>>
>>>>>>> From my understanding (correct me if I am wrong), Yu seems to want order-0 to be
>>>>>>> the default order even if LAF is enabled. 
> 
> Zi, I think you are incorrect; Yu does not want order-0 to be the default. He's
> just pointing out the that original "default return value that actually means
> PAGE_ALLOC_COSTLY_ORDER" was 0 and that was not an ideal choice because 0
> _could_ be a legitimate preference from the HW. So -1 is preferred for this
> purpose. Yu - correct me if wrong!
> 
>>>>>>> But that does not make sense to me, since
>>>>>>> if LAF is configured to be enabled (it is disabled by default now), user (and distros)
>>>>>>> must think LAF is giving benefit. Otherwise, they will just disable LAF at compilation
>>>>>>> time or by using prctl. Enabling LAF and using order-0 as the default order makes
>>>>>>> most of LAF code not used.
>>>>>> For the device with limited memory size and it still wants LAF enabled for some specific
>>>>>> memory ranges, it's possible the LAF is enabled, order-0 as default order and use madvise
>>>>>> to enable LAF for specific memory ranges.
>>>>>
>>>>> Do you have a use case? Or it is just a possible scenario?
>>>> It's a possible scenario. Per my experience, it's valid use case for embedded
>>>> system or low end android phone.
>>>>
>>>>>
>>>>> IIUC, Ryan has a concrete use case for his choice. For ARM64 with 16KB/64KB
>>>>> base pages, 2MB folios (LAF in this config) would be desirable since THP is
>>>>> 32MB/512MB and much harder to get.
> 
> Yes I have a real use case for my choice. But as I said above, I'm willing to
> move that policy into the arch impl of arch_wants_pte_order() if its acceptable
> to pass the vma in (this is how I was doing it in the original version, but
> preference was to remove the parameter).
> 
>>>>>
>>>>>>
>>>>>> So my understanding is it's possible case. But it's another configuration thing and not
>>>>>> necessary to be finalized now.
>>>>>
>>>>> Basically, we are deciding whether LAF should use order-0 by default once it is
>>>>> compiled in to kernel. From your other email on ANON_FOLIO_MAX_ORDER_UNHINTED,
>>>>> your argument is that code change is needed to test the impact of LAF with
>>>>> different orders. That seems to imply we actually need an extra knob (maybe sysctl)
>>>>> to control the max LAF order. And with that extra knob, we can solve this default
>>>>> order problem, since we can set it to 0 for devices want to opt in LAF and set
>>>>> it N (like 64KB) for other devices want to opt out LAF.
>>>> From performance tuning perspective, it's necessary to have knobs to configure and
>>>> check the attribute of LAF. But we must be careful to add the knobs as they need
>>>> be maintained for ever.
>>>
>>> If we do not want to maintain such a knob (since it may take some time to finalize)
>>> and tweaking LAF order is important for us to explore different LAF configurations
>>> (Ryan thinks 64KB will perform well on ARM64, whereas Yu mentioned 16KB/32KB is
>>> better in his use cases), we probably just put the LAF order knob in debugfs
>>> like Ryan suggested before to move forward.
>> Works for me.
> 
> I would really rather avoid adding any knob for now if we possibly can. We have
> discussed this in the past and concluded we should avoid. It was also raised
> that if we do add a knob, then debugfs is not sufficient because you can't
> access it in some environments.
I see this knob a temporary knob instead of official knob. It will be used to
make performance evaluation of LAF with different order easier. We don't need to
rebuild the kernel to change the max LAF order.

But it's possible if we add it, we may need to maintain it for ever because
there always is new workload need be tuned with different LAF order.


Regards
Yin, Fengwei

> 
>>
>>>
>>>
>>>>>
>>>>> So maybe we need the extra knob for both testing purpose and serving different
>>>>> device configuration purpose.
>>>>>
>>>>>>>
>>>>>>> Also arch_wants_pte_order() might need a better name like
>>>>>>> arch_wants_large_folio_order(). Since current name sounds like the specified order
>>>>>>> is wanted by HW in a general setting, but it is not. It is an order HW wants
>>>>>>> when LAF is enabled. That might cause some confusion.
> 
> Personally I don't think it makes much difference. "large folio" does not make
> it clear that its for pte-mapped memory only. How about
> arch_prefers_pte_order(), if it really must be changed?
> 
>>>>>>>
>>>>>>>>>
>>>>>>>>> [1] https://lore.kernel.org/linux-mm/CAOUHufZ7HJZW8Srwatyudf=FbwTGQtyq4DyL2SHwSg37N_Bo_A@mail.gmail.com/
>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> Best Regards,
>>>>>>> Yan, Zi
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
