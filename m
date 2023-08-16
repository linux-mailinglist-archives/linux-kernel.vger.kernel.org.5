Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E57177E8D5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345588AbjHPSiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345675AbjHPSh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:37:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB4F2702;
        Wed, 16 Aug 2023 11:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692211071; x=1723747071;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vlfh1XXDkgWWEiL5k6maOT7q/k+9VKhNGdWZNZolXsY=;
  b=byUGl4b2mAMlGZy5VCV3FG6tWWPvldfDvZ0RKT53eHwE+BAXKC1zdnWr
   sD1Q1xnHEorHt+b2+bfZy/U/bLSlP3k4J9ZHei4NEIqHPI9kB4C8Qzr25
   /ljlPURANCgTysY4wCcB7Bpz6SWZTvpfx9E+46DFb/x/nEqXOQ8k2rHAg
   sOI9vUnUfh5+Kr8aETfeQTpBKmen9qeayPQbDNE1mR35+chL+Ki5mtjV4
   DbdCZJysCkYhTNg9tP9FOfo/Cy8W3cfkCNSa/KJoXf4kktAJo4/FiPRZD
   zyVhrJddlzVo2jW4f7FuMiLoowi5ZLrXNIupecNv4V/7MOcIOMux9Hzzx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="370078916"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="370078916"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 11:37:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="737383047"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="737383047"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 16 Aug 2023 11:37:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 11:37:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 11:37:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 11:36:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLj8ejucfAUX7DYn0dtT5eFaAMk6oLzfjvygsEbykpEPd4EH2WzoNW42TMs1kbfi3JvktiE0qxSTToLOyJHIkBp1Wc06Ix3f3i4PxS9F9QDQOLDnt192M5wLqd6SHnuR9xgaEVjlKW1AdtOD/ZvyViKqP/Gf6B/0p7KGBtA/Nu/Sln/nlZd+RB0Snx+9zSpZKo9/Hl7FkuUVdKSMgekNNy+T/9TkJKYgApUWM1AXjNGXer+pX3/IjMAthp94vOeTKl056yRbFe4GfOPs85ZbB6AuQKGhY9AuJ1kgifp4MAasiLd16V64ObRKGSk3BIgEx5XRidwkX1d8W1ffn73mqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qz0d4DaVaDda319g+ORzxxM4tvDq7xkArZDezFAstH0=;
 b=oZLwLy8QLyhe9hSvUMLy2I1Frq1Iwy3giLUWXbD0GPuXaVtMeyIYgJFSa0QRnVM2QTnIsE89Fbe8oLxcKya4EigP6E3M5nYJIhPsRMbzOIIZnzVo3cTqxnAYlhwtU+3pGDgHFFfTTf64JN2Jt1t8SMtOgThH9hL+mfqw4l4kNDQN+p6XJ07AXG213ULkeBMsNtYTJq9o/rOw/xhqL7f0ArPZtABdvK6aAiATStjXBQKKIvPoFZ+0XBwSdvzU5wPit0C+VxgfgsMR7Ka/PH+AAY9dY8ES8jZPK0ytte8B5KJ3w/prv7px3zgtiAXTAy37MvyzreToHIOrqy2RNMpL6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6343.namprd11.prod.outlook.com (2603:10b6:930:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 18:36:57 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 18:36:57 +0000
Message-ID: <25c23223-520b-f6ff-ec8f-678e2524c511@intel.com>
Date:   Wed, 16 Aug 2023 11:36:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v7 4/8] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
 <169178458575.1147205.16331131496340363561.stgit@bmoger-ubuntu>
 <37986ad0-4519-0f16-c09b-86fcf2f8a763@intel.com>
 <c341b2cf-7ebc-f52b-76ba-77a106dc20fc@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <c341b2cf-7ebc-f52b-76ba-77a106dc20fc@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0178.namprd03.prod.outlook.com
 (2603:10b6:303:8d::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: 3264e44a-62c2-47d1-2f73-08db9e87c50e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ZR95zktnkVSN5N4A/bJoX53qFQb9FKkx5gjeQjNrtbSaAVYiRdRuobagh7PP5zkF3lsM20LytJt6i8EiqgGsjPpL6OZD0KcwE292TQ8EUVtPjW8Yd+1GynUVrqQt497OYYgMG9i5Oi5nnc/5sdoGZPkc3LpiywyEAw4kOmCvjRIZXi8zFoFlAWX86XvEkK3850l5fiQI92a7nqJnWmAtccYTC95udnSMC2TFmmbF8wRN6lCqMbc/sfclkhNal65eAE3hG/RmonrbO9yiuftfCmG3Vcfm5EBNgmtdOWPk/Dzy/AaaJ5pVA8k7JiCTm1Kv+VvG9EG1qJYFMf7ZuGYx8UbSFwEs03J2y/XCUzWc0xyf8d31URUGMm/fHlJdWYRHe3RLlxBDv42At+jTJs6R0pgYMK04GHTaw/YnsOFUVm8YoZpjEy0wzX3k4ufb1YdGIKRFSofXQkQRj3lbvkALA6ipcY/RkrM0v9VS4Yz1iCum4yYCSI+w2aF/0nFr70Cg/S77uCnYy3vrwoy1X/UOPSXHcuR2KhT1pRrNibgHtPKFQLgCVPJMsx3jo+lji3dG1TJosjymeVgG5VU2isTupRUeP7v/l6hoDEckbjDHsurk9lqLKDAQV5DgMb1+hf+DR2Qn/pzxziZafaejLnz+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39860400002)(376002)(1800799009)(451199024)(186009)(2906002)(83380400001)(7416002)(7406005)(86362001)(478600001)(6506007)(36756003)(6486002)(2616005)(6666004)(6512007)(53546011)(31696002)(26005)(44832011)(5660300002)(41300700001)(316002)(66946007)(66556008)(66476007)(31686004)(8676002)(8936002)(4326008)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckZBRGt5akdMTzhKTnRHRUYvN2xRa3MrN2R5bDZnd2daSDFZQ0dKeEhmK0xH?=
 =?utf-8?B?OHJzN1E2aXcvWm9CNjFhc0RSR2M4NVJHM0Qreno5M2swSnRoeG9IZlFZNTIx?=
 =?utf-8?B?VmFEaVA1Q2NEYXBRbXJJTzBVYWU4Q2pVQURKaEtSNUN3M1ZUVG9DL25Qa0dL?=
 =?utf-8?B?U2tUZ1lnWU1jWHFxZlZsenU3UFhDOEJXY2c4dnRhZFhoSGpPWDNRam5wMjlP?=
 =?utf-8?B?clpRaHNUSGM0TFBtTHlGNFNaOStvN1J1aU9WeGtGRmhWbE1yL0h4QTNEUGJa?=
 =?utf-8?B?TjZPRDJ0YWx0N29wZ1Brdm5BRHJJSTN1WW5yc2ROSGJLTzJEMW44WTBVaW80?=
 =?utf-8?B?aTgyaCtFVCtiem9CeWlXUUQvZXNMbkFaY2x2MmlqeUdITEJsQVNORHIrOFpP?=
 =?utf-8?B?ZzlDQW8vZjZFSjRWZXRIc3NqTU5uclBva3NDeEFoYjgydGV0ZUNYQTV0THF0?=
 =?utf-8?B?dkJRTUc1M0VIZUU0SnQxV0FIWHc0T3pCK1Y0SFl5eVZOZjd5UTMxQzdURTRn?=
 =?utf-8?B?VHNjVEdyK0o2dFluMTRzRkdlTkFFRnFncklaWXNKRVFLTUlUakZtRTNFWUhV?=
 =?utf-8?B?M2xZcVBLNVNNWGNPTmpOUTNhOFVKYjcyT2ZPMEd3UGJuWklIbEhST1ZScFBk?=
 =?utf-8?B?RlNIY01pMzVHb1NJRzZ4aENwQVpBdXRGTSs5Rk5zZTFHVEdsam5lZHJyQWVG?=
 =?utf-8?B?STRINWR0ZW45SU4yMWw1QTBON0NqbUZTTnkrZ3NUQUZYcjgwYnRVT2pHU2o5?=
 =?utf-8?B?bnRHNE1hUEpVRUpaR1hjR2p6K0lKa3hLaUFZS1hzZGhvQ2ZIdHF4ZnNicVgy?=
 =?utf-8?B?MFh2c0VaTEpRUXhROVdNam45NndKQ3FUbzBML0VuNit3RTBHNmthZVJpK2No?=
 =?utf-8?B?ZEMyT0NWazVLMkNqYjh0VTR5dnBVSERhNUxoc3pGZkU2eHE5SjhvVXpOQmRM?=
 =?utf-8?B?S09OdTlkdy8wdkRyL3VNNUFLOFZwNWZpZGg0Z0UwOCs4NW5zRExRUDBOOGxV?=
 =?utf-8?B?Q2xmNTlZWTV6cExiRW40ZEJWZWRTd0p1WGt5bTl6NW5tdk4yeW9iK3lHem1a?=
 =?utf-8?B?cC8yODErR2NmV3htSXhkUGdLZ2liblFGMm04L3V0eUZvNUpab3QrcmIyTWFU?=
 =?utf-8?B?MzE3WjVSTkVhY3lTdy9TbzVRUXRXREQrSFE5U0w0bU94QmRJclkxRS81SG5t?=
 =?utf-8?B?UC8wVndMT1VlQ0E0VHJ2djIvRmJtczd4Mmg0UXdlWmdBd3ZtbGhhdnh6VS9p?=
 =?utf-8?B?b3dnZ05ITzFoVWE3Ui9CRkxmTThWV3JLeWtXdTdLdE1FbnFWMkVBVDEyRDBw?=
 =?utf-8?B?amViOTNnYlZJaXhoN0c4bkxpNDlGTXdHRFg2WjV2bUVrc0RCRjYyRUp1TUVi?=
 =?utf-8?B?eDlsSnAyOU5LUjlMaW1LTnFxOWJQZ2xIeWs5S3BOUmNSU1RzWTA2M3oyMkto?=
 =?utf-8?B?Ky9YR1RBQWp6OUlDN2NTQS9vNXFEU1hMaHRLY0NtRkl4eW4yTlIrSklIM1pI?=
 =?utf-8?B?SEtDRnB5UktZd1VvZGpOYkZyb05nUWkwZ1FRc1djWWZDaXgxMkpua3R3MWNv?=
 =?utf-8?B?N1NrS2QrbEVoOUhUQXdrOVFjQ0xaSi8yWVZVNy9UbHRLcmNwRXhqWVgxcGhR?=
 =?utf-8?B?a1JFcUt1TFAySDJjbzhOdnBnRnRWaVRJeE5rQ0lNdXlCaUJINlA1eW1LVkZH?=
 =?utf-8?B?NHdBeVU2aW1ndDdBTWFzNFI5M1l0YUtTbGhHZjBGUURZZFdZK3NqUmtSdjVm?=
 =?utf-8?B?aXhycUFkdW93Y3VrN2VQdWxoVU5VRnhQTVRQNFNhUW8xMmYrOVRCejAvRDBK?=
 =?utf-8?B?b3U1bEFwU3ZybWZiUW5tQkVoT2tCTHlRendUcW5sSjhQdHlIWHNsS3NTU0N1?=
 =?utf-8?B?ellvSFVOc0s0WGtvWFVST3hsN2ZsZW13SHpTcjMyRkJHTS9JMWpQUnlqOXg3?=
 =?utf-8?B?NzRabU56a0JtcXh2NTFqem5WQ3Z4WDhJZ0s1SUUrQjBLMHg2MVJDMEVxaWdv?=
 =?utf-8?B?ZEl6UDN6U3dWNW1jRFFhdnh6SW9QWjhRKzY5VTJDYVVXMUVBWHJkTFI1dHdZ?=
 =?utf-8?B?YVZzc1RUeW5pY2dSaXA2RUpCZkxjU1J2TWhvQXpzOXF4V242Q1R6MHNFMzlF?=
 =?utf-8?B?WjdJUk14SlMvNmM5YXIvaTcxSjU3QlNESC8ydW85UVhJc3E1czM5WlVJdnZh?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3264e44a-62c2-47d1-2f73-08db9e87c50e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 18:36:56.8951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBPNvKFhs5EPykqrNl/X/7XhFmcigrOYklyrssKFlP+Ys4nM9iOD2LsobgaTOg3wyC3X9REPJYrhXuizm46UC0bvcxfmZCgNR7zSXXQqW6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6343
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/16/2023 8:34 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 8/15/23 17:45, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 8/11/2023 1:09 PM, Babu Moger wrote:
>>> resctrl uses RFTYPE flags for creating resctrl directory structure.
>>>
>>> Definitions and directory structures are not documented. Add
>>> comments to improve the readability and help future additions.
>>>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>>>  arch/x86/kernel/cpu/resctrl/internal.h |   49 ++++++++++++++++++++++++++++++++
>>>  1 file changed, 49 insertions(+)
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>>> index 2051179a3b91..37800724e002 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>> @@ -240,6 +240,55 @@ struct rdtgroup {
>>>  
>>>  /*
>>>   * Define the file type flags for base and info directories.
>>> + *
>>> + * RESCTRL filesystem has two main components
>>> + *	a. info
>>> + *	b. base
>>> + *
>>> + * /sys/fs/resctrl/
>>> + *	|
>>> + *	--> info (Top level directory named "info". Contains files that
>>> + *	|	  provide details on control and monitoring resources.)
>>> + *	|
>>> + *	--> base (Root directory associated with default resource group
>>> + *		  as well as directories created by user for MON and CTRL
>>> + *		  groups. Contains files to interact with MON and CTRL
>>> + *		  groups.)
>>> + *
>>> + *	info directory structure
>>> + *	------------------------------------------------------------------
>>> + *	--> RFTYPE_INFO
>>> + *	--> <info> directory
>>> + *		--> RFTYPE_TOP_INFO
>>> + *		    Files: last_cmd_status
>>> + *
>>> + *		--> RFTYPE_MON_INFO
>>> + *		--> <L3_MON> directory
>>> + *		    Files: max_threshold_occupancy, mon_features,
>>> + *			   num_rmids, mbm_total_bytes_config,
>>> + *			   mbm_local_bytes_config
>>> + *
>>
>> I think the monitor files need the same split as what you did for
>> control files in this version. That is, there are some files
>> that depend on RFTYPE_MON_INFO and others that depend on
>> RFTYPE_MON_INFO | RFTYPE_RES_CACHE. In above it appears that
>> all files depend on RFTYPE_MON_INFO only.
> 
> ok. Sure.
> 
> 
>>> + *		--> RFTYPE_CTRL_INFO
>>> + *		    Files: num_closids
>>> + *
>>
>> Looking at this closer I can see some potential confusion about where these
>> files appear. A note saying that these files appear in all sub-directories
>> may be helpful because at this point it appears that this file is at the
>> same level as the directories.
> 
> Sure..
> 
> With both these changes. Here is the diff on top of current patch.
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index 37800724e002..412a9ef98171 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -264,12 +264,16 @@ struct rdtgroup {
>   *
>   *             --> RFTYPE_MON_INFO
>   *             --> <L3_MON> directory

I understand that resctrl does not use flags for directories
but I do find it inconsistent how the L3_MON directory is
layered when compared to how the, for example, L3 directory
is layered below. I actually start to wonder if it may not
simplify interpretation if the names of directories
are removed entirely from this documentation

I also think that the current hierarchy is confusing since it
uses combined flags while also creating a hierarchy.
What I mean is, the documentation looks like;

      *	--> RFTYPE_INFO
      *	--> <info> directory
      *		--> RFTYPE_TOP_INFO
      *		    Files: last_cmd_status

If I understand correctly the hierarchy is intended to mean
that all items below flag at that level has that flag set.
The confusing part is when combined flags are also used, like
above where RFTYPE_TOP_INFO is (RFTYPE_INFO | RFTYPE_TOP)
If hierarchy is followed, should it not rather be:

      *	--> RFTYPE_INFO
      *	--> <info> directory
      *		--> RFTYPE_TOP
      *		    Files: last_cmd_status



> - *                 Files: max_threshold_occupancy, mon_features,
> - *                        num_rmids, mbm_total_bytes_config,
> - *                        mbm_local_bytes_config
> + *                 Files: mon_features, num_rmids
> + *
> + *                     --> RFTYPE_RES_CACHE
> + *                         Files: max_threshold_occupancy,
> + *                                mbm_total_bytes_config,
> + *                                mbm_local_bytes_config
>   *
>   *             --> RFTYPE_CTRL_INFO
>   *                 Files: num_closids
> + *                        These files appear in all the sub-directories.
>   *
>   *                     --> RFTYPE_RES_CACHE
>   *                     --> <L2,L3> directories


I made an attempt at capturing all the items I mention
above. Please do not just copy this into your next version but
consider first if it makes sense to you with the goal of
reducing ambiguity.

*	info directory structure
*	------------------------------------------------------------------
*	--> RFTYPE_INFO
*		--> RFTYPE_TOP (Files in top level of info directory)
*		    Files: last_cmd_status
*
*		--> RFTYPE_MON (Files for all monitoring resources)
*		    Files: mon_features, num_rmids
*
*		    --> RFTYPE_RES_CACHE (Files for cache monitoring resources)
*		    Files: max_threshold_occupancy,
*			   mbm_total_bytes_config,
*			   mbm_local_bytes_config
*
*		--> RFTYPE_CTRL (Files for all control resources)
*		    Files: num_closids
*
*			--> RFTYPE_RES_CACHE (Files for cache control resources)
*			    Files: bit_usage, cbm_mask, min_cbm_bits,
*				   shareable_bits
*
*			--> RFTYPE_RES_MB (Files for MBA and SMBA control resources)
*			    Files: bandwidth_gran, delay_linear,
*				   min_bandwidth, thread_throttle_mode
*
*	base directory structure
*	------------------------------------------------------------------
*	--> RFTYPE_BASE (Files for both MON and CTRL groups)
*	    Files: cpus, cpus_list, tasks
*
*		--> RFTYPE_CTRL (Files only for CTRL group)
*	    	Files: mode, schemata, size
*

Reinette



