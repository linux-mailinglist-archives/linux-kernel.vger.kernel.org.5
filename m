Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA6E76BEFA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjHAVK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjHAVK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:10:26 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DCEE7C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 14:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690924226; x=1722460226;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=rXV7C3siBGGIYJBuq6cA3Qd4ajhbx/5PQUkXXPJWy1s=;
  b=UZU9dqDQPfXo9KfeP9JPo+5TgZpPv12jVm1vPWfw5/9y8lDaBjtD7uBm
   uRlql0GzL2cBKNz64KgS6H5TT2Yj7Px5q6fvUFGLwdx9NZJGyOf4Ozl1J
   IpZtQWf/NnWTMy0tKuuK/Qj3sqnoaB6r85PIZlEB35XVnWP+MCCig7OQp
   zVrwNJNifaCkyjLYCj5ojyDHAAwnfRuErEFvMRBuOc5fac3jI8xs6POdl
   /ewPV+3Iw6qPqdTae00i6FxPb01+Biy/1gYkanYwEtllyLPzmT4RwL54v
   InWSh39EaFj7mQIg7DHj1WTDz//JW1LYnxT5LDNCRUAxHZjaPkhtSt9Ai
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="354341631"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="354341631"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 14:10:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="975439649"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="975439649"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 01 Aug 2023 14:10:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 14:10:25 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 14:10:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 14:10:24 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 14:10:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8geJ/KxJ+BPaUgMaBtcS519jCkqxHK/rC9F79OeQc+8yGh6IGGM9zk6qck82WIiZLwFo3A3RrjZrWGe7gP8XRwLplMsHQ6THyLpK64hIsiR7cjQGaTQ0UyBmRVG/OAAVUDh2qQ/U4ZBDCDAsDi3RxPNo7tzQPHJpppYpwBoptlkz8fvqAu52qJ+8z4RYIoRH2w5d5+kVRsnC69GIMa2gZCX+UL+X1+Xkbppshi8opreGClMYBL+s8PzI/84z+2rAsxGQ86x5ilFV9nPnOKVNS3ZRjejKYirvcFkFTsul0rwWKpZ6DHrtl3jd1f5ktO5OicMWMLtb86iKfyVFwxgDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLFwYPcXWPa0tXun+fLGVrByBuGCFudhwygXj9dysfQ=;
 b=oGf9T8b9yCGbIjlk4A8G9jIPJpqewn+CG3TYInpAG8VfyU7JEfytL0hUEegrQGTZI3xojAriaWgv8fbNRomclhTsq7W38po6bWBYGa88dnUY5dlkYOESLkQo2rgVuGhx6ebOYoske2Te2VxqtVcvywn9RM5H2JWiXMgo7CT3N2mj58RoePQ5MSKHFrQGwIds1AYxsMUy3npUPFGhg8AHmQGyVCZTR2I7tQ+q/bJ5b/iHPh+JN4rtR1bMgrWnhY5B6+d2cHiXAEdosp1HmdmuGofAmOs4i/+VibZiYnk7rXYErSpipwJ4JzlIHzq3kAXBLzGlhrgEtXIlyD1k/QUD+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SA0PR11MB4685.namprd11.prod.outlook.com (2603:10b6:806:9e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 21:10:22 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::b5c2:7049:2735:2943]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::b5c2:7049:2735:2943%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 21:10:21 +0000
Message-ID: <a947a270-dad6-5486-2e11-feb288aa9210@intel.com>
Date:   Tue, 1 Aug 2023 14:10:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 03/12] x86/alternatives: Disable LASS when patching
 kernel alternatives
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>
References: <20230609183632.48706-1-alexander.shishkin@linux.intel.com>
 <20230609183632.48706-4-alexander.shishkin@linux.intel.com>
 <40ac9a487c723eff9eb069a5795760b1caf02f18.camel@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <40ac9a487c723eff9eb069a5795760b1caf02f18.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0023.namprd21.prod.outlook.com
 (2603:10b6:a03:114::33) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SA0PR11MB4685:EE_
X-MS-Office365-Filtering-Correlation-Id: a2859a27-1894-4a58-20c7-08db92d3b76b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lr+t/R8xDts/gbVhIDdRJSwQx9nKcdKRMpP3vK496/GsNUjGaW3N1Un8Ml5W0vpEj2Nqx4N3C+d9oUzxZFxKmClL8GtSdaAlPCV967qH6k6BnNfMHtP+Ks7G2ybuH5xQZl+Dhtqj8mv9x8l240F85s60yCVgJPXqw2I8l4gc0zqt7AEgrlBitIUG6xjUY8grMt4TqY1EnyvaeOfKH0hRWzv4AgSr9s6/M3lzgwnQvQozNmhOuB/dvDtnQO6YaEOm5gmgyeFc6U1GlJxwLW8iW7zZn7hx8IelIHRec178M0t42sYFXV8ebUJRpFFfYYULWmk8eOzxasE1BDr3W1/w/t0XXnz57swNUkQN7aglPkO8t+a+sP2a+NYoOzQi65RqKhcfKT0YHGWmcZJznFx81RYzR4zPFvpWMpcooS98wqLVN/M2E+KnOx8WyKkLyxS6CmVpzCfFovi3KKzRY6PfapSEj0jTE5ofTQKLwjNHJtZFgNERujJcV+DBCI4T998gU2rT0xECxVbL9Fm6CTDna/VU+JiSnSmDLZASc2rJdTJPE0eFvzLYMWz0ORjPKm6rnbkgLpIWMfOdD4RERouMiBvLjR4LTusvswy2vUzEd8hxmhNMNghq+Qd2BTo+GZY/U6JnbKJ/fPHojaFi48wzQ44wnFNKfHi5QhWXxIRkKYA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199021)(44832011)(316002)(8936002)(8676002)(66946007)(66556008)(6636002)(66476007)(41300700001)(31696002)(5660300002)(86362001)(36756003)(2906002)(26005)(6506007)(186003)(6486002)(6512007)(83380400001)(2616005)(31686004)(921005)(82960400001)(110136005)(38100700002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzFQWGdYZTdUSnN5bU1HZDhISjdTOUJwQ2RFTUVFS3FXTFJCVXZkOEwvSXAv?=
 =?utf-8?B?TXF4V2lBQ081c2pKQUpieXl3SWJobVRZOHV3MW1iWjJBTkhXWk1DQXlTbVJw?=
 =?utf-8?B?eVQ2djRqOUpkSm9QTEdLNjdSVGVKQzd1TFVDeElPUlVDOWZlYzN4N2tHSHVr?=
 =?utf-8?B?VlQ0OWNhZTB6eXR3YmYvanVzM3FhZXNKTjk4aEJrVjdPelNCMmF6dmgvS3Nk?=
 =?utf-8?B?SFVsZSs3UUx5dHRWNjFYTXNlUXcxUXFjZHlJc3ZGT0ovQ25jNjRvVXpXbEJQ?=
 =?utf-8?B?bVlqdWdGSmpxcGhsMWVvbk1jeWdNd09BNm9uS1JBOVBrWFhvRkNuSzVFVFlF?=
 =?utf-8?B?SG1aaUJNZVZyN2lNRm9jNkhzSHA0MGRLTGZPeS92L0lGSlNiQTl0RUx6YWI2?=
 =?utf-8?B?MjNHaG50eFRZbkwvYXQ5ZnlmMEQ3b1czTG9KdWRyU2gxL3dsZUV1clVRL1ZX?=
 =?utf-8?B?VEoxeDVYejh3SUVUakpyb1drQVlSKzZyYS9Bc1lacWtxOUN5ZU5uRFAwcHZ4?=
 =?utf-8?B?VVpWcHBVQWFMekgrR0dVNTA1OGhJUDRlME9HcFhNdUpwRG8yTDd0R2Q0UEcx?=
 =?utf-8?B?OVVJZ0lwWFdGdHlMYjE3UUJKK2p0UE82d3NNOXpiaUcvNHFPUjcxeUNmQVVn?=
 =?utf-8?B?djZjR0tCRDdWV1l1SlJnT1hFN2lpWjFyZEpIYURKeUlOLzdsZHJPSVFMT29Y?=
 =?utf-8?B?cG9Xamw3WjhWcEhmQ0tYZTdreU16b1ZFa0ZTMDVWSzhlOGdLY3p1RE80U2xW?=
 =?utf-8?B?a0ptZC9hdTlrRVVDb2hxMGNYNUZOdnFESTJkd2srOW55OEs2V09WZE1BY2dR?=
 =?utf-8?B?MjNETnFwalV3VDlKK0Q1T252Vkg0QmdIdE9FdUF3Tm5VTGNTVkZYczl3Y1Qv?=
 =?utf-8?B?OU0weDRWbVdnaWNtU1hjUVlNVTZ2b0xNQnB0aDlIcW1EeHpPWDVDUmg4TVBy?=
 =?utf-8?B?SlB2N1JaRG9nR00yNW1ZcHRiVFVoZFl6Y3h4OTZRTHlobDcxaGtodE12WDdL?=
 =?utf-8?B?UkpPKzVEM0FUcGRweGZWQjl2UC9OS2tBRUhSV20yTy9Cd0E3NzJSQkJkd2Zh?=
 =?utf-8?B?RHppYkRmTytTWHZTNU9OVjB2aGdGbXFUQWQrMnQ1Qm9FN2NnL0d5MTlvYTJm?=
 =?utf-8?B?Y2E3aWREVmhhNHNmR1htVC9Dc0RnOXYvd1dNTHB4WXo5Z01MWkV0emlYL2c2?=
 =?utf-8?B?L3J3YVExVmN3dzAxY1NaL0FyWHVQdExpS2FuUzRBTzlXT1ZCMnQ4d0V0Q2Yx?=
 =?utf-8?B?ZDdCUWJNeHppNGNtb29ZU05jeWZUUkRpRjJOb2xPd3NlSzYrYW9SRkFpK2dJ?=
 =?utf-8?B?em9WZlVTaHBZU1R3VXUzUFl4NnROaWg1eUhuakpGNGY3bGgzOUNEdEhra2Fi?=
 =?utf-8?B?UE5qdUdBaEVVYWREazRWUTVWbTV6L0FyOE1KQnFPOXF3UThVUlNCVVNCWmRs?=
 =?utf-8?B?TDlwM2ZlTEJraHZNc25zUWZRaGhVYTJqcUlLNW5hTzhVWFhuejNvazNNTmt1?=
 =?utf-8?B?WmUzRFNFaHdIRmFaMXB4S053Tlp6cFU2MksycnV6RzI4WmMwZlA0RE9mcm9k?=
 =?utf-8?B?ekoxMnE0SVNvaU5pTnM1UlQ5ckl6QkZURmJsK0EyRWNTcWxOenpIWS85d051?=
 =?utf-8?B?aXB0MDJaRno3WWJvMHFzc0tycUl5NnNQOE5hMEN6MjlQclh2UllpTFQyQWpF?=
 =?utf-8?B?SWNJc1BVaFRoUUZZSWtZSTNnYU9tMlptTW1kNFdqdWlNMGRMM3BKZ0x5aVBj?=
 =?utf-8?B?M0xBaXNIN0ZWMW04a3RaUUIzYlU1NzNGUUxCaWl2emMvaUx2SzFHQnZmRnRP?=
 =?utf-8?B?QmxYMGFLRHBPdnpJMWpxQnZrV1pqdUVOSnd0ZkJlY25yVXR0T2ZrNUJkZjFN?=
 =?utf-8?B?d3FCNmwyNzVkUkJQNE94TEFreC9WY3VCcXVybjJ2alJrYWhDNlEyYUJicFV6?=
 =?utf-8?B?Y096amRSVGs2TTdqdVdzSUZudDlYSFpleTRQQUtkMnQraVVHRWdEYU84cXdH?=
 =?utf-8?B?S0ZyMlcyOFo5R0dlMHk3c0FVWGUrczBXWnZueUVXRzloYUd2bjNmQUZVWG9J?=
 =?utf-8?B?cTV6VE9zZk56cllFaWlZZEQzTHFOVnd1ZmUyamxwSHAxYVdGTW9vQ2l1UWxu?=
 =?utf-8?Q?VJS75FJ8JleevL4agYHvOdopy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2859a27-1894-4a58-20c7-08db92d3b76b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 21:10:21.7431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3s2U2ZU55WtPUqE674tY7if/zz7Iiuga6l+9YwjfjRCPoLnEj74E6OmU0BeieiJXdaJDWFMlbF3q7UYTIC8IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4685
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Why not do stac/clac in a single place inside __text_poke()?

It would mostly look something like this:
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 0fbf8a631306..02ef08e2575d 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -1781,7 +1781,9 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
>         prev = use_temporary_mm(poking_mm);
> 
>         kasan_disable_current();
> +       stac();
>         func((u8 *)poking_addr + offset_in_page(addr), src, len);
> +       clac();
>         kasan_enable_current();
> 
>         /*

Since, __text_poke() uses a dynamic function to call into
text_poke_memcpy() and text_poke_memset(), objtool would still complain.

> arch/x86/kernel/alternative.o: warning: objtool: __text_poke+0x259: call to {dynamic}() with UACCESS enabled

We could change __text_poke() to not use the dynamic func but it might
be a bit heavy handed to save a couple of lines of stac/clac calls. The
current trade-off seems reasonable to me.

Did you have something different in mind?

Sohil


