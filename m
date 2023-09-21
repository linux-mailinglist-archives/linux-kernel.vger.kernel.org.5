Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA9E7A9DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjIUToL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjIUTnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:43:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD7366366
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318615; x=1726854615;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=H6z7pgU3JAwEA7pHfrpkjVK5g5zIlnLkJ6CSuZsHABI=;
  b=iTY/3Vnya08i2mgxMRT2ZosvEbvvhymld0yuEkjKjPNYYvjX3D0h+TPN
   2e3ZSyS5MpdIYmuKkT3sLl53mTSSUSHI6CzIFbgRYGBZSc5yDdABuwB8g
   KYPRtgWwmJj2nf7I2imqaSmXSt4Q/7cTKS3dh4XEqIbUTY9rYmn4xkw/t
   b6KLV9w4rsLP1qYuVusXdWxspm/4C4yLpqIA9p43GVOXIprzRVKFXN7T3
   L487+FikAhVKV7CEqbgHeFRmR8U7FGjTUPCt5PYiVirTQTsOzLOboVo11
   J8ia8B3lVVVQl5rwQ0xa2niMyFP4yxXqnlGexPZY+Li4q4Y7O+EK65QtM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="384298533"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="384298533"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:25:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="782055010"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="782055010"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 01:25:33 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 01:25:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 01:25:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 01:25:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ez0sdrDgL6DNWqGj7Tptd5aSzrutZ6oJYp/UWI8hc9M4wMnyW5LN93wNru02nnHXobepsUhMtfNOJj8lYnX2b3qI8kqlrDJFqoqUsUXDV+Dn76ILJBxOXSSRtPFXGBZybcMwDassLjGgNlV5v1mbMBzcFsSU2plAkXiyKORkinIBsj6zFoLX57N4n/U7pshvXoMmTaricvg73QEFsyhF0iXSXs7K3gWWL31mAtM4LvZbWUAzVg/lgjVhwAsmmclI9COifg9M7BHbwY7tQye9vVFqtncMgqzWWKV1BZ7AGgtHjkzODwwr6xWLRH7CFcqw4DiRRMSN1guFTF82pns+mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DO7kT5jLtZzIkVEYSWf2PtYpGDXf+kptc8rmCokf3AA=;
 b=bUZ15uPElVjJxSZUtkKNu8mqOHrSAdWS5j6GU7VYdlBZLwM+dOKv8Zn6I0C+aQqjG9VuPTbtCB30x2vEDblf8eSoWN38qi52zToJbPL78bHV4WX1yDb6IbRRXYPfnIyicWNzkm4OcIVONc38hm+Wnz1plHrl6DN/uV1hkP98B3JDxhyQIYjoTCKmlvDbkttU4Oi19C5E3HcPUhHZZgFOLqE5hOqYH97raYkGWacc4U6S5WHbfAA0Z7Cknli8cqDiCzMhNkp1gCf72E89dscEocz54L8BcMKZpSv/O/tSrDZzURiMvqRnussuGEhryqbc2GuHrfsYnRNBOZ294GILOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3094.namprd11.prod.outlook.com (2603:10b6:a03:87::25)
 by MW4PR11MB6666.namprd11.prod.outlook.com (2603:10b6:303:1eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Thu, 21 Sep
 2023 08:25:23 +0000
Received: from BYAPR11MB3094.namprd11.prod.outlook.com
 ([fe80::5e3:67e1:e213:c87]) by BYAPR11MB3094.namprd11.prod.outlook.com
 ([fe80::5e3:67e1:e213:c87%6]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 08:25:22 +0000
Date:   Thu, 21 Sep 2023 16:24:57 +0800
From:   Yi Sun <yi.sun@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     <dave.hansen@intel.com>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, <sohil.mehta@intel.com>, <ak@linux.intel.com>,
        <ilpo.jarvinen@linux.intel.com>, <heng.su@intel.com>,
        <tony.luck@intel.com>, <yi.sun@linux.intel.com>,
        <yu.c.chen@intel.com>
Subject: Re: [PATCH v7 1/3] x86/fpu: Measure the Latency of XSAVE and XRSTOR
Message-ID: <ZQv92QD7AtodfDPB@ysun46-mobl.ccr.corp.intel.com>
References: <20230921062900.864679-1-yi.sun@intel.com>
 <20230921062900.864679-2-yi.sun@intel.com>
 <ZQvqvpSbyub6gFZX@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <ZQvqvpSbyub6gFZX@gmail.com>
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To BYAPR11MB3094.namprd11.prod.outlook.com
 (2603:10b6:a03:87::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3094:EE_|MW4PR11MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: 438ee905-330d-421a-4f0e-08dbba7c4b5b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /1zwlKqeT4RefsFFluCOdQbVFAI9DZqz726FfrZZ9U+jkZfYaztYe0Vzlm0nVCmlf6vj4a2sBo0Jd4GvDy+TzJSHQU0nfQIMzWEYleo4VcsjOBZDozv6OB0rqFcZs2W8d7BGEAV1okh6wlnTJf1ZqHTyMc5YG9LvIrikLSyA5JqXfS9rwezAr62f8u0uit0E8iBL61e143XTdJxXU0ylvAJ+CRSDwbbcPUOtThDlL6xva5NyCFbw85jP8WEwRktFeWOIc4lR/i0SeuCGoGk2JI5hoFSEnxtgVqeNhU5qh32hte/xb6sl+XstOyNBOKwCGRXyf6lpdDe6/4QRpTFfs4mSRsrOIsfQNGvd/L6K3Udc9NQ9l2CZeh1EoU/Mf9TyfVbrMam0MmUlEU+hsTDtOf/YATPTI3eUZrMPYFE1h9OkW0B8/jaF6k+yoHFRohbjkbZ+lIT0yRgnka5CX8wIc1m/MNW9awihBqQjJa20eG6e1gSv68u5r4KZcz6wixA8WXo7wWqzWndiVLQ8Lm/pmf+zPtOF8t7ystk9KWbO9j2wVuEsnR3X6BvnE/M8FwCP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3094.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199024)(186009)(1800799009)(82960400001)(38100700002)(86362001)(478600001)(6512007)(6916009)(66556008)(66476007)(6666004)(66946007)(2906002)(316002)(6486002)(6506007)(53546011)(8676002)(8936002)(5660300002)(44832011)(4326008)(41300700001)(26005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzVPcC9VcS9pSEE1Z0RwK3VjRk5kelVVQmRzdmhFTzZKazlzQmp6dDJHMklO?=
 =?utf-8?B?WFJMSFFpOVBuY1kxbWpwR3FJQWxFSHBtOTF2NTlDV2ovcmhjUEVONFB2SDRo?=
 =?utf-8?B?QXRtWVRQU2lCeTJEMUFiZTVwb2hoRXhaU2hVdi91bmRrK0pTekNNaUZxUUZS?=
 =?utf-8?B?MnZQTlFVWHBSVEt1UkxtSnRHbUJVMVNXalpxYWQ0NlBGSXNmQTRGVTU5dW1Z?=
 =?utf-8?B?cHZWZnVuOEc2MlFJamUrQ1l3Zkl5YjlaTFJEcTkxS2ZoYzRMQ0Fkb1hJWmFL?=
 =?utf-8?B?M1krVUJKVnQ4WndXSXhRRUFSYnRrcU5pS1RmU1BFM2o1cTY4Z09ZRGJGT1NR?=
 =?utf-8?B?WDdtUGwySGlsT0xWVU1NNXFsVkZVbHlWSUoxbjlaOXpVWFlMdGh2bTFnSUx4?=
 =?utf-8?B?Z1JxcFdja2JaOXg0MVdXMDJQRE96eVBUZkV1TzU0Nnh2dDRyT2VhcVZCVGpV?=
 =?utf-8?B?a2I5MWRZVCs4anEyVWpPaGVlYkFvYjczMzE1d2k2VTA4QTJXeFAyeVBJMUdI?=
 =?utf-8?B?RnNsMGxjNmw3ZE92dVRWMUhGbGtoMmxkM25yNFA1VUE3aGhwdlFzRXI1Vm5a?=
 =?utf-8?B?YVdtekdIc2F5MklFTy9wajIvYkZCUmtyRitYbW95RUdrNG0vZTdYZ3c2NHdY?=
 =?utf-8?B?VDdWazI5SGd3MTJkOVVIazNqejRJWkRxWWtEZlA2eXNDb1dJTmVtTkRiTHZK?=
 =?utf-8?B?c01Hb29jcVZzVjJiUzJ6UUUwUVF3ZTY1NHBhVEk4ZmcxK3NBSDhRaFFsT1g1?=
 =?utf-8?B?T1Y5bzgvellrc2kvZ25mN1Z5a25TMXowOUw5ZWNVZ0hiOVdEMlBVY0NidnZq?=
 =?utf-8?B?MERTNkZmM3N0Ulp3eUlwcEF4L2RyT2Rac0Z0YUFXOC9XdERZdWtEZHc1Szd2?=
 =?utf-8?B?azlsL2NZRGdpNUhua0xaVTBoYWJVSFdMRi9mbmlMa0ZtdTB4dWlwZWNGdXlj?=
 =?utf-8?B?Ym5RMEM4T2FLc2pjRnpYZ01xRWN1YitjMEp3TEZ2VDd6YXlSc2VaUmZNOWZJ?=
 =?utf-8?B?VTJjK1hyZktPbWlzNFRHRVlZRzJxTkk3cHJsUDF1ejE4emJMTzgvS0pJZmtJ?=
 =?utf-8?B?NFRsY3AxcElQMHU4a3hEYTVMUnl5c0gzbERTRGpjRlVxSzRhUzViVUZ1RXJi?=
 =?utf-8?B?d3dhY3MzbmhNQ0tkb1pGZnArSE1uQ3ZpOEpuYmYrbGVpTUduWmEydnI2UjNC?=
 =?utf-8?B?ZFBjYzVkWFdiOHlWeHBPVHNkTnFoVHpRQWU2a0JHQmxzekU5aXhCRDh6c1VD?=
 =?utf-8?B?UkZuOE5BUmN4eHVVSjNZR3FjUHBkQ1QzbE5GNUc1aEp2M2Y1SU5QQzlmamJG?=
 =?utf-8?B?cVJ3VWU1dUlxYUNMRlF5KzN2M3ZIQnFWUXAwZE9adDJQcVNScXBzQytFYjBw?=
 =?utf-8?B?Z0FPNEtiNjJTTFlEcWYzK1FFQkdOR0R2QlFTT0c4a0tBcjRKZXRNaDZMRjR6?=
 =?utf-8?B?WVB4SzdHZEhqb3kzdVFEdk9xVTd0MjFGaTRVVzJlTWRCL1Y4ZmlKRjFOQldk?=
 =?utf-8?B?UzlYd0dWcXp6ZmhUcHMvQmVFL3R3SXNqMnQ1c1JSLzhBUTNKSUZzdmg3eTkw?=
 =?utf-8?B?UVBBdnNrZjgvQUhraXM1Z2pFb3lrZGRsQlNPalF6YS9GWmVKVVBHWlNhczFl?=
 =?utf-8?B?QndaQk1POWVxeE5MS0Z3ZVFaVWlrSXBKbXl0VSszRDAvaU1tdnFYMnNTYlk0?=
 =?utf-8?B?VDUxei9wSE15MVdKbGJySUJrbWZ4NG0zQ3Q5UHVOSVZ3bU45SWltdnRWNEsv?=
 =?utf-8?B?V2hMR01reTVhd2JpNHF3cmJ4QTRNS3ZDell5Sk80bWNoblh0UWl1TU9rTUlT?=
 =?utf-8?B?a3dnV0NQVE5NTjlpLzduV0h1ZXpYQStNNU5nZWVaYWFYQkVoRm1EYWFVWVUr?=
 =?utf-8?B?NXVTM05HT0trMC9YSDByRlJWVjFzZU5CeW5XcHhuajBmRFVLQW5MMEJoM0Rw?=
 =?utf-8?B?WklmT0M3R0lZTzFJUFR6NFY4Wm5zR0RJMW82VUExSktsNGM5ZnpSODZIYU0v?=
 =?utf-8?B?WURTVEpTTGJ3VDFxUVB5RFdUNFFtekp1WkFTLzYwbGpKcCtqMXZEWWN3dFoy?=
 =?utf-8?B?NHhTWitaMHJhSGpLTEREeVZkaTRPQ1dZWVF4Z3JVZWw3b256NmlSeFlUdldk?=
 =?utf-8?Q?2lJHsyEvVOtyl1VxbL0Yir3Xy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 438ee905-330d-421a-4f0e-08dbba7c4b5b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3094.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 08:25:22.3534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sgl3ok5XLEFKbCyh3A2N7NshKNqeXYfAK3t78ufW24ZC7r4U2OpFaPhmD9TWr0KWqNtBcpOsmPGJd0BcBbrH1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6666
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.09.2023 09:03, Ingo Molnar wrote:
>
>* Yi Sun <yi.sun@intel.com> wrote:
>
>> -#define XSTATE_XRESTORE(st, lmask, hmask)				\
>> +#define __XSTATE_XRESTORE(st, lmask, hmask)				\
>>  	asm volatile(ALTERNATIVE(XRSTOR,				\
>>  				 XRSTORS, X86_FEATURE_XSAVES)		\
>>  		     "\n"						\
>> @@ -140,6 +143,35 @@ static inline u64 xfeatures_mask_independent(void)
>>  		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
>>  		     : "memory")
>>
>> +#if defined(CONFIG_X86_DEBUG_FPU)
>> +#define XSTATE_XSAVE(fps, lmask, hmask, err)				\
>> +	do {								\
>> +		struct fpstate *f = fps;				\
>> +		u64 tc = -1;						\
>> +		if (tracepoint_enabled(x86_fpu_latency_xsave))		\
>> +			tc = trace_clock();				\
>> +		__XSTATE_XSAVE(&f->regs.xsave, lmask, hmask, err);	\
>> +		if (tracepoint_enabled(x86_fpu_latency_xsave))		\
>> +			trace_x86_fpu_latency_xsave(f, trace_clock() - tc);\
>> +	} while (0)
>> +
>> +#define XSTATE_XRESTORE(fps, lmask, hmask)				\
>> +	do {								\
>> +		struct fpstate *f = fps;				\
>> +		u64 tc = -1;						\
>> +		if (tracepoint_enabled(x86_fpu_latency_xrstor))		\
>> +			tc = trace_clock();				\
>> +		__XSTATE_XRESTORE(&f->regs.xsave, lmask, hmask);	\
>> +		if (tracepoint_enabled(x86_fpu_latency_xrstor))		\
>> +			trace_x86_fpu_latency_xrstor(f, trace_clock() - tc);\
>
>This v7 version does not adequately address the review feedback I gave for
>v6: it adds tracing overhead to potential hot paths, and putting it behind
>CONFIG_X86_DEBUG_FPU is not a solution either: it's default-y, so de-facto
>enabled on all major distros...
Hi Ingo,

Appreciate your comments!

What do you think if I were to add a new config here instead of
CONFIG_X86_DEBUG_FPU, and set it as the default value of n?
This way, all the overhead will be removed from the hot paths.
```
#else
#define XSTATE_XSAVE(fps, lmask, hmask, err)
                 __XSTATE_XSAVE(&(fps)->regs.xsave, lmask, hmask, err)
#define XSTATE_XRESTORE(fps, lmask, hmask)
                 __XSTATE_XRESTORE(&(fps)->regs.xsave, lmask, hmask)
#endif
```
>
>It seems unnecessarily complex: why does it have to measure latency
>directly? Tracepoints *by default* come with event timestamps. A latency
>measurement tool should be able to subtract two timestamps to extract the
>latency between two tracepoints...
>
>In fact, function tracing is enabled on all major Linux distros:
>
>  kepler:~/tip> grep FUNCTION_TRACER /boot/config-6.2.0-33-generic
>  CONFIG_HAVE_FUNCTION_TRACER=y
>  CONFIG_FUNCTION_TRACER=y
>
>Why not just enable function tracing for the affected FPU context switching
>functions?
>
>The relevant functions are already standalone in a typical kernel:
>
>   xsave:                # ffffffff8103cfe0 T save_fpregs_to_fpstate
>   xrstor:               # ffffffff8103d160 T restore_fpregs_from_fpstate
>   xrstor_supervisor:    # ffffffff8103dc50 T fpu__clear_user_states
>
>... and FPU context switching overhead dominates the cost of these
>functions.
>
I am aware of these trace points, but we add new ones for two reasons:
1. As I described in the patch comments. It would be more accurate to
calculate the latency in a single trace event, which will NOT include the
latency of the trace functions themselves. The cost of the trace
functions is much longer than the latency of xsaves, by our experiments.

Calculating the latency by subtracting two timestamps has to
contain the latency of trace points, that would make the actual latency
data less prominent.

2. We want to measure with finer granularity. The new added trace points
dump XINUSE and RFBM each time they are called. By doing so, we can
collect the latency and analyze the data grouped according to each FPU
instruction indicated in the XCR0 bits.

Thanks
    --Sun, Yi
