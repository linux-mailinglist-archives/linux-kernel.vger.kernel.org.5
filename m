Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814D1779BCC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 02:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbjHLAPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 20:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjHLAPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 20:15:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDB8E42
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 17:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691799349; x=1723335349;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U6+MxScdJrC6NGku2MlH53aDmCYq/U+AjmfUGOMVaOI=;
  b=j0pnDTi1f9D5JdpyDY9/zHfDKZD+FZoUwKH935/X9CfWocDkx4s4bHdm
   A4QFlk+QlHG3T+T9wR2C1Dwn6l+X26MIsnf4UbwNV8iNnqGOG0E9YSsjT
   RbtiF32oARzdPt2opQnu/4mXegexoGs95o8uAhAklidcUm8f4XR/AfMmt
   RsMzbXQUWLAcW95v+AzKOFDZUJXf7qwSnDC2hjmanRE4K+aqJI6AEXlbu
   B7nvhw2CRUGnt2J/vTriljxJVC8PA/WfijSOf1OAh44lNmpYqi69lQyER
   Xwd2S7c9erufCaf4GoBs+5arylJrSRa4spvZxFYHhMBsvgN04wBpOIMmy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="369258218"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="369258218"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 17:15:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="798206876"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="798206876"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 11 Aug 2023 17:15:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 17:15:48 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 17:15:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 11 Aug 2023 17:15:48 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 11 Aug 2023 17:15:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGWN7Rcf3PqVLTATc7pRmmJuN2tf7cCx4neQ5yujE0o5MExIybraYKiTf20QnWsLra7G4GGaHngMoOnUqOdSAVTge9IX7gYsTzSPKGf4oGsjAfepcJCCnnNR8waj+xiCSeBuZ1uf3E2EUjrk8hr684UgC3q7kuFEYEagx5lMxtBVmr4KmqjXjWZENndX2X3+VXc/GUi+vJSGkMjtDOONJ8pnPl87wtl/8B2ik0VduETgTiVjLvIK3GNoLQkfn/1A4w08/lFDI44E9R9nRgNLTlT/ZkxGofXz+JOy8r+ITJCugkg/T87tL4Mlrbv0XBvHg3cMiMMZt9jh9BLhoUHiBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDxhiK0mw82OFvVebFnhUp3+BWIKBMUNT/HlsKXyh+8=;
 b=Yw+G4d4WJ+8gOeYPfZM/nPftCUJamXVpKm17CiMkviHrOyHO1F5tFYVrHNp1EGfbouxSSksctbOPFNVwK/5wHExe2iDyfMStGZKdcTnGsubuVyjxim5G/oq51N5qgWYEJ+mf8LT1ZkkkZySfbLHUxU7nJ1gi3+DPcG+yxi9P/EEd6Lr/4i7bQNdPFvrwpVu+hKq+2XtGBMPQftd++MR41ZcmspHDoLWPXGGmpfwRNibBZCgyYdU7PHYUgTfyYEgXWn6mGJbB83rscUObQZBZEb+0cIxoF5usVOeco/hvdcTODEtjnfFvM0zKRxArz3fRfYKvgBKzaURn6svlU/7Vrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS0PR11MB7879.namprd11.prod.outlook.com (2603:10b6:8:f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.22; Sat, 12 Aug
 2023 00:15:40 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::ad4c:86ce:d99e:9740]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::ad4c:86ce:d99e:9740%3]) with mapi id 15.20.6652.029; Sat, 12 Aug 2023
 00:15:39 +0000
Message-ID: <5b657203-3a02-4b7a-4726-2e5ab2d7f099@intel.com>
Date:   Fri, 11 Aug 2023 17:15:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/1] x86/pti: Fix kernel warnings for pti= and nopti
 cmdline options.
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
        <linux-kernel@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <luto@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>
CC:     <x86@kernel.org>, <bp@alien8.de>, <tglx@linutronix.de>,
        <hpa@zytor.com>
References: <20230811213628.40428-1-jo.vanbulck@cs.kuleuven.be>
 <20230811213628.40428-2-jo.vanbulck@cs.kuleuven.be>
 <295ea2ef-3480-856b-b93a-9ae36f7b2286@cs.kuleuven.be>
 <d76126be-9eda-d426-1fa5-a35fd4ca3d57@intel.com>
 <3a4bf401-0781-492f-a952-3c96c1507551@intel.com>
 <b9bbb279-fa8f-0784-900f-114ce186cbb3@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <b9bbb279-fa8f-0784-900f-114ce186cbb3@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0380.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::25) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS0PR11MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d32caa-b6ea-4a59-8f55-08db9ac94227
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UTNDq1MLghmTTPhV1+bEyjrfLeglu7azmjbqXRzRZRJSw3B0Vebfv7yzCjjX5vF31E9zPEab7Ge1ONc8jRIq4US37wl8g9ez+7W9Cepw3W5H4/AHQyPxEs5A6y/+T/WdOVB6kW9TDFmWOTDk4al4cqCGxPxD5HssfhNME+eW6DVGxJt5NbcEMB307EIa+RG57RVlH5ABmXH0UqzybCl6LWjiwhgR7j2wx+12kRAFLctfrpDT7x9smr+TQj+DTg68kkZqrtTcRv0o/71slSTpLZkYv4r3wfGz+91wHJb78l5I2quOe9qHJZk14sf9lNm3qefRgxni6FIknElu+9JvZbzdrCLJjDX2p+we+hGkMmdy/4n7hXw5HZPfCkRW/z8b+SpLYzAcnmNqmo06xkwWaoaYeIFQjB1WraBP0CQr61Djblcu7ZXWg9KcXu9oMqpVy7EBxvjWpnCIp7KTttndBlmQ3m+TJ/by5DrDf+LHHTA7Xw5Ei7/cU4Ydqmp3KBdF8//z/wk5GDrsanTGuSJNx+oanOEf+UquxrDnmynDm0AHPhhap5MVL3vE6v7b5lzqAr4HptEBkQy+pomaM0KoW9oHXPpEjZ0XoPnB36lZnSychfI64yFAFJ03raZIul66j+dFwttkuwvYsgHyw8gUtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199021)(186006)(1800799006)(6486002)(6506007)(6512007)(53546011)(478600001)(2616005)(26005)(2906002)(4744005)(7416002)(316002)(41300700001)(66556008)(110136005)(66946007)(66476007)(5660300002)(44832011)(4326008)(8676002)(8936002)(86362001)(31696002)(38100700002)(36756003)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmVqdWZjeGJBNG1FeGpvKzNZQ1o4NFNmcTFRREhEempPVENMUExhelV3SGVH?=
 =?utf-8?B?eTlWRkljbVhhQ0xqSytPSmtwdkxGd0JTMHE2cnpubjJpdWpYblBRMzQweDFZ?=
 =?utf-8?B?L1BKU0k4ZEFrU041bjBLcmNlMFA5Qm40VW0vQ1k0Skx4NTZEYXEzSHQybXJv?=
 =?utf-8?B?Ykh1RmFrNkZvWXJjRjV1VkVId3RCbDl5Tk9hcnhLek1HMFJteWxrQXZBMW5J?=
 =?utf-8?B?WmdwSGhJZ3ROc3oydnhDNUlMbHVJL3JoL3NNb0tad1J2UFhROWVYNmw3bGEz?=
 =?utf-8?B?bGpKZG12eFhYM0RhTE5uQ3JSM2s0TlB1dTMzaXlhOWMvSnNlMGxDRFlNSTF5?=
 =?utf-8?B?RjhxaUIwU2JTTzUxVFZQT3ZTeERWK2NJNXUzaTBTSVp1cEpMblpSbjB0dTAy?=
 =?utf-8?B?c2F0QkZoNndkdFBTN2taNDd3RUFkeHJMMUE1bVhhWUplem9UQmI0dStYalp5?=
 =?utf-8?B?Z0g1b1kxMmJ5dEE3d1ZvQytGWHpxRUE0SjNvU3JpTWhyd2kxd3pJQTQ4a2hv?=
 =?utf-8?B?enI1VUIrWnV5U0lsZUVHTE1temFBajQ2QUI0K2tDdEtORmF6ZUVHb2E5aVNU?=
 =?utf-8?B?OXFvR2hVMXZQcU4vRExBcFE5NXhWSjEwNFJGTVgyUTJITERmSWlacUViUXJ6?=
 =?utf-8?B?WXZuMWkxTjRGK202aUhIZDBybU9GS2RLRlAyd1pQR21NRTdWdzVKQThNVGdr?=
 =?utf-8?B?dktqL0JPS1d5UHFrMHJXY2NSK1ptemFxaDRLdjlzcWFBOGdmUDNwVHhuWjlj?=
 =?utf-8?B?RGFXMUl2UnNxTVdLeWRuZCtaZ1dUQ3oxU0k1dDV3UmtkVHF4bjZ2eGlzcUQw?=
 =?utf-8?B?WVE4NlQwTHJ0YjZzMzlYYlcrelo1UnVBMDgxb25XUENoTkR2TlAya0kyanAx?=
 =?utf-8?B?RW5RYmYrZXlobDF0R3g2QkFFNDhLVS9rQjVWdnUyMVUwQmR4NVpzM3ZBKzBF?=
 =?utf-8?B?WTk5SWQ2bVJkL3prNDhaWG1VaE1FVG5Ha0wyeVF4WVp4QUpCNXAyQmxKdytP?=
 =?utf-8?B?alNUcnJHc1MrODlxUGtRWDcvMXFycDRVTHlOdDZydWFTYysyNU56L09CS2RG?=
 =?utf-8?B?ZFFZaDZRVGpLOFJEU0ExbWQwTlFZd09xbldqeElZR3FEQzZDbEczRTc5OFps?=
 =?utf-8?B?RTVhVTI2Zkx3eWgwQkxNWmRWOUF6YnhTVXFsVlZjRFVVZUJMMTR4ekgwZktm?=
 =?utf-8?B?dXRtYzR3Z1puVVlndENSSW9lU29JWEt4WE5XbzQrTTY0Zmx4bGdmNFFtVEIx?=
 =?utf-8?B?bnBGQzZqMlJFdWRMKzdCNlFpMmxKU3FNVjJTVzVIWU16NW5TRTdRUU41c1Fp?=
 =?utf-8?B?RkNqanU3eXVKeGVoRXdTU1MrMGRid3VzREdjN2w1bjBrci9GYkY4amlPRjhm?=
 =?utf-8?B?ZTQrQ1ptNU1GbXAxRGFJSDZTaGVvM3ZienpTQ3N6bm5MT3p5Z1Z6dVR0c0xj?=
 =?utf-8?B?cTFXZTdkdE50d25YRzNPQnBhTTU2bDlZNUR5Y3E4eGJ4WnlNWmV3bWFIeGFh?=
 =?utf-8?B?c1NiRldhaVNnTjRJaWlQVGhOWWZWd3FZSGh5RHlNQVZKYUtaR1FUWldSY1dE?=
 =?utf-8?B?d3BSZklCWkZlNXVPU1NEaG5EN0tmd2JCNUJseEdrUlZTUWJxNGtiKzExWmlK?=
 =?utf-8?B?WWYrUW9CbTVEbVJiYm9aeWNFaHdEREZjUkdsaWFvOHo1Vkx6R3l3cFhXRzNm?=
 =?utf-8?B?TEJnbkgvYmg2QW5rTE40VldCZzI5ckVLUWpZSFpmUzd4bklHT013L2dDcW5a?=
 =?utf-8?B?L0xoaFBKYnRtQ0VGTjNSVEJqSVcyWGJuTmc4MlFCWlFZT3c2OEV0cnI0MFZm?=
 =?utf-8?B?NDQ5citTMGI2UjlNMzZBa2FDeHNuVVI5Y2RlOUtzR0pxUW52alpqcXZNQXEv?=
 =?utf-8?B?elhsUmlyS1BUdXNWNmx4RVVkbHNmUmI3clVPOVM1dko1aG9xZkVTNHk2ZUhO?=
 =?utf-8?B?SmtWb3djd21yYzdaV1Fta3RadTk4ekc5c1VjK3VJMHdQT0tNU3d5dFdaNTVo?=
 =?utf-8?B?OUttak41cTBaTnZSNEdvYlVYTWhUdHFPZUxsWUdMS1RSUGVwbGtsSEVXREh5?=
 =?utf-8?B?dGxwUThXWkw4QWkyZnBqVW1paEZDUE9KM2tNK3JJQ1YrcmRpWFZoSGpac3ZY?=
 =?utf-8?Q?hSMZ/tH/xPWC4gzXRGMJJvUkx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d32caa-b6ea-4a59-8f55-08db9ac94227
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2023 00:15:39.2896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YeozwulEDLwtjwDp0zr3w+W/56OBrTOwEpTZNevwlpV/wRPHnQJHMkZNO10x/FLfwVueTmMkj271D25TEkxA0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7879
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/2023 5:08 PM, Dave Hansen wrote:
> It's worth *ZERO* hassle.  The docs say:
> 
>>         mitigations=
> ...
>>                         off
>>                                 Disable all optional CPU mitigations.  This
>>                                 improves system performance, but it may also
>>                                 expose users to several CPU vulnerabilities.
>>                                 Equivalent to: 
> ...
>>                                                nopti [X86,PPC]
> 
> That's 100% unambiguous.
> 

Ah! I missed that. Sorry about the trouble.




