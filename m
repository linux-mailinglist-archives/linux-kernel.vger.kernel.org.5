Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD7C7A4FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjIRQwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjIRQwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:52:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CEB181;
        Mon, 18 Sep 2023 09:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695055918; x=1726591918;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WQupkjNY43iZqDY6dt8UeokZqoz4BaZ8W6G4rm7LzrQ=;
  b=ed/P2OlbbDGf9MoQD8Wt7A/yK1S/DZxmrxtCDCjOjLuzPJTf5hPb/O6Y
   ij6UhHS/aTGSqEBpWSvNS9+Cl9f5ko42JhHRiKjRwIcUIANyJ3/eGx77E
   /przTE0X98lUffzE3UZV9HrOhXj6LCONrh5W/yLb8l4hmo+aEBUuNOJte
   iTkntOfuAL0A5mwfLKlhEhFxhH8vPR8p1/InJhNF142OuljNqXWYW9wgm
   md9BVsm16dcYYg2WfDVoET5O6KH0mnbrb4i9lfLpfYPDMdyF07Zjgfsd4
   sWI9uVCC4cPNSscb2d740cfiO8JFGFFa8dBsQHIekFc+NV4e3P/PZBqw/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="443789355"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="443789355"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 09:51:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="775193768"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="775193768"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 09:51:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 09:51:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 09:51:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 09:51:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 09:51:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/dT6SY9HTDgfMv7Xa14FNVRo56r0Bf+VdLXnu0fF07EIVf8o5C4ecKFUFr5Zy+DH99FxTtYwEhBpJg2UqRKIGeK3Zmo5cWKrhRUVEA2tSNMr+HlmEA/A1Aez6vqIhoZnkZsRSx8BhZd1fsQ/MMwxoLjlV0wyvluoCq11W7aMB7+TsE8fmzg9MxkKWSgY75vbygyMCZC4UCkACyEkwkDUVxG+hM1W8Opm/orStGVRHUHVG1gXefuQJz7zk+gdTzynm2MncwEVapj4GNBLpbX/8TQL36MPWh2+w84GbRcHFcqI/IjZLrusTET+pUPp4gCZwwZxBccQwV452sg8zvkxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PcKBs0HXAEC8yZ9zgaG2ihCnM/LNG86ykBSzI0t5lU=;
 b=NXpeBJtkXWPcUZvr5xW6jrRV5m3atBM3OuLM2kTDo7xkdovX4aSsRLe1ZnvKLL/b8yyuZu/ichOpTc1V2fhKO5+KOV9Yn5iSXRv6Xc/HwCEuP/IvVuxMOnZCa4uszg/r7OtY5X6zNH1wl+EXbaj+d3vNUbcwd35bnlZFFyWVVSVgN1qc5K1TRW5lGVeN5jktlTtWV9opUK6nubYdMGuenp1M1lEZCf1OqK4f24QMCEwcDrWXfyywgHL63VQ2k2xqA+pRDBF6T+8OZNldF3rmhG4hjEnWdqFXBFxoKtXoGfGhkG3FLe4530RCAEkJQmuhm334CA2IZCHGJOy/vNrdew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by IA0PR11MB7306.namprd11.prod.outlook.com (2603:10b6:208:438::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Mon, 18 Sep
 2023 16:51:53 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54%7]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 16:51:52 +0000
Message-ID: <826a2b32-bd6a-900a-19fa-e169fcf0d29d@intel.com>
Date:   Mon, 18 Sep 2023 09:51:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 03/10] platform/x86/intel/ifs: Image loading for new
 generations
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com>
 <20230913183348.1349409-4-jithu.joseph@intel.com>
 <ba753b39-1819-35ff-1248-6ce2c2824ae9@linux.intel.com>
 <e084652a-91a0-0c16-7acb-d51a3d2f7ed5@intel.com>
 <10fe57c-c926-9de4-be84-21a0f8abab6d@linux.intel.com>
 <SJ1PR11MB6083A4237D928F180B6DB1E1FCFBA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <56b486ce-2a6e-c4c7-8bc5-ceeb7119ba1@linux.intel.com>
 <SJ1PR11MB608304A84A2B662C78FDB677FCFBA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <a02d2957-3ec4-f89c-ebe-474c3987b237@linux.intel.com>
Content-Language: en-US
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <a02d2957-3ec4-f89c-ebe-474c3987b237@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0023.namprd16.prod.outlook.com (2603:10b6:907::36)
 To BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|IA0PR11MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: 9185d5a6-7f6c-4179-5b38-08dbb8678f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s8Kv0XdpXiYWBxctz0tHCMpbFK6QSnHZuebSw2LJogEvVNiiRfLY6D3EB0XY8hTSp3KPJIobw4xP1oqqg98VnJ6OZVe70MK/g2m4jdsEgHDNOWyVHM6VydZIUtIcHtaWxJl2xsONimnB7JbkAiB0vEac3TD7hgFEGgLi/hh9rP0iHSNsnwOE6nlenpI893/uvU2Rc9wVF/eDVSl8lcTo+ISMWFbG84C4gluB/eYEMIQwbszPNLJsnMoTYLjbN1OL0iMp3dkDkkkmzZzIVujZigi7ZogTJC/cEuZqM4eEAzRbVwYbFMcO9WI2vJDidhA0L0wFW8/GrKkpYNnlhWXeuywlFkjYb7/0fUy6B6Bnrxm7k553K4Re9SNA4Z+bNo03DIHm6cusfSlb3A4EmmS1U88JvNAM4pehchJ8WltZsTgqZpG5zpFnSSAONY+nEvtpcFeAWmlHKRexGqFv3Qr40A2wyQyPiYXP3aVzCopYfR/BxZuO0AnD296y92etPDoONaYj88IdZ+MS+bpzhZtPYjmQXhtX2ivK+6nfDoz5smtjo589yVQ23vrkDXQheYC2/85W3SJFokknUw++2SmXXyr5mxqgnPHfoG5+ClhTbC3mXxnBVKBNtxxzJvnX0XkQU/wi47dupbDmGvqf9z4Rdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199024)(1800799009)(186009)(6486002)(5660300002)(6506007)(53546011)(86362001)(54906003)(316002)(6512007)(66946007)(38100700002)(41300700001)(66556008)(66476007)(110136005)(31686004)(6666004)(478600001)(6636002)(82960400001)(8936002)(2616005)(8676002)(26005)(2906002)(31696002)(66574015)(4744005)(36756003)(4326008)(83380400001)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Slovc05Zbm5Fckl4UHJWUDBnYVhjNndmWDE1WEdVWVdEUnV3UVgrbGlHcWxy?=
 =?utf-8?B?alBBTkhxeThkVERTa2VWZTZIRUhVUWRhUlAySkk3THFLa09BVzdFMTI0Ungv?=
 =?utf-8?B?bzZtb3hkTlFYTmRoNjIwUFYrNHhFZkdyL2E1czN1RERUV2tkSjRFSUNWRUVR?=
 =?utf-8?B?N2lSWkhRYncxQzlSL0FDTDY3TEE4YzM1SFQ1V01vUm0xM1E3V05GVGhSOGhv?=
 =?utf-8?B?UmExRnJ6K0dzSC9sOVdESVFFR3h1ekR6WVhCNzhrVmNpZExkVVN6TUQwQTRI?=
 =?utf-8?B?aHJ5RVFVNU5VZk1RY200Z1pXT1AwSkFnWkZJdzVMd1RZcG5JeXNTc3lENVRp?=
 =?utf-8?B?U0tROEcrTDVneWlqQjQvRG9lekkzdy9WcEROR29icHA0L1Jsc2pWMXdvTUVV?=
 =?utf-8?B?d29xUVNjV0F4ai9JeW9Pckxob0pWMnRHTzZjcnhjNkRGcGo4QjhMUC93WXpY?=
 =?utf-8?B?SUw4cVQ5T21BWjZoNVNBRVlRTGRxMHZMcEtkOVUxa0ZZOCt1ZXFFK0dEVFpa?=
 =?utf-8?B?ZDc3WTVkY1ZYdWtGZGFzbXRlNm9QVEFmem41VjZqaXIxdnFnZy9XWVNUMVBo?=
 =?utf-8?B?ZDQ0dlo5MERZMndxZnk1SzFpdmJ6eGlpZVhSUDdTcitEL20zU1RkWjBXR1ly?=
 =?utf-8?B?QkdLdXR2c0VQV1JsaE1nQkU3WEZDd2hFOWRlc1Q3dVpPU05QamxERmdyR2ZI?=
 =?utf-8?B?NUVFTG8rb01uWkkvUEVPMDdYZHNhUCtNMENBTUQvSGlTcllsZTdDUUhOUHU5?=
 =?utf-8?B?aHphSU9SSWxEYnlVWEhZNHYrUVZ4cVR6WjdwU3I4NExVZ0ZKL2VWdzFyTjNH?=
 =?utf-8?B?SjU5dC9LN0hBcW5SdkNvNEo0SExIS3BNUEo1V1lacm9YYmdyQTAxQWd5OTdl?=
 =?utf-8?B?bEdBZW1ORUdBeld1TTVPbGFON3pUZzRnV2h4RGhPOUQyNnFoN1BvUllHNDhL?=
 =?utf-8?B?QkdtU3NLN1lTMEhuMFpnaVBNVGYyM2I4SVBtcUprZ1FNUVdiYzJHaFFvWDVU?=
 =?utf-8?B?WEl1NDhiaHF0OVE3WWY5dllaQXJsbXpFaDQyM3ppZys4TTNzdTMrblVYVnZ2?=
 =?utf-8?B?Z2FOdC9JTUNHUy9PWmlpUy8vclRONDg0TEY0K0cwUGNTaEs4Vzl1Z1MzYWZ0?=
 =?utf-8?B?clVQOURaaHkyZUVEYi9XcnB4ZlBNbFRJUFRXbzAxcXVBYXgzMklCS002SWY1?=
 =?utf-8?B?OFNlTm9ZRkMzWEEzT0NqRllhaWV4aU04bjRPTjl3MnB3Rk9pbi8zUExPbHNB?=
 =?utf-8?B?SE45cXVrcE1EQWZ5WW5uVDhrc3FyWUw3cTk5UUFqNm9IazJ6Ny9rbXpMaGth?=
 =?utf-8?B?K1pKWUFXL2xITnRkSDNRMGx6anRTYys4MTFFR0YvOEVwYnlEN1BtZjRnYWc0?=
 =?utf-8?B?YzhleW9YMVJrM3lsRkQ5STZqZGpkQXNuT1JIVENuc3NWVzBjNmJNazR5Mk4w?=
 =?utf-8?B?WlFKQnEybkt3UXRuQW01V2tocTB0R1Z4NlZLYTVtQzgrSmVVZXMwSCs4K0FX?=
 =?utf-8?B?UTg1TVdoTFJNakE4L0NROG9tUTFGQnYvbkw3U3ppYUU2NWx0MWlhOUJpU2tN?=
 =?utf-8?B?UEhhOXBzZVVVVHNvOUFqUGc5aVR6SitaUmFHdkFoRnlqV3VHVWIwekZDV0xo?=
 =?utf-8?B?VHAxZENjRGtlNjdoUlBUSFNmdXY1UVhYTGMxcEM4S3RLSzUycTlsN2ZKbHFD?=
 =?utf-8?B?TnpRQXNmN1lLTjFkT3FFUHdiWHB1MTN0SDMxOStscjhOdDZTckl5Um5jTnZF?=
 =?utf-8?B?U1V2QWFOMnFaYVVYRWRxaHpYSEl1cjd2L3lPUU5TUmFXS3pPNVd6K2xhRGho?=
 =?utf-8?B?WW40UVdwREhuTHc3M0VJNHpSSmtmcUlva3VmUERKOG51N1RzMFlqQS9xdGMr?=
 =?utf-8?B?eEp1c1FJdnhjYXZseGtzWEVMNlBacnpjZGZ5d3Q1NTdKNmxUVDQxdlVrSjRl?=
 =?utf-8?B?SGFVZmdtZnZ6R3pMWGl1Vy9iMDh1WmV5QzZWekN3bi91dzlZNGwzbnVueDYx?=
 =?utf-8?B?dVF4WVVVOVVzMmxtYUtxRVdNV1JVUlh4ckF4WDNEYjRGbCtreS9mRG9NNDAv?=
 =?utf-8?B?WUpHWjlFT0JEVmRNaEE4WVlaRGhVMHRvVjRRVTJtQjFXaTRsQkRBQTVaMlEr?=
 =?utf-8?B?bS94dmlkSVJPOERpUSt2Ni9HRGZYTU1IUDVERW5KSE5sSEVkT1dyWVMrYkxp?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9185d5a6-7f6c-4179-5b38-08dbb8678f35
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 16:51:52.8352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nyOWKYUD2vjE8R4Qj0J6mY2Z51eeq4sJ1ua2gazKNehe57BpTpDQXGleXau4MxPoMZToSKs/cCCh6DqFSddvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7306
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/2023 9:29 AM, Ilpo Järvinen wrote:

> 
> In this case it is not just about the bitfield itself nor the bit 
> allocation order but sharing the storage unit with another member, and to 
> further complicate things, members have different alignment requirement 
> too (32-bit aligned u8 followed by u32 bitfield).
> 

I too verified that the size of the whole structure matches that of MSR  64 bits (8 bytes). 

Initially when IFS scan was added the  all MSR structure members were  bit-fields, later there was a suggestion to
use basic C types if applicable during subsequent Array BIST patch series. I followed this approach with the  current patch series . 

I will change the current series to use all bit-field MSR structures in v2, given mixing basic types and bitfields is a a source of confusion

Jithu
