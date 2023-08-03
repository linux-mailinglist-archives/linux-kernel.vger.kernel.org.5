Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC0B76DD54
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 03:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjHCBiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 21:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjHCBhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 21:37:45 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CE0198C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 18:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691026663; x=1722562663;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=QflC3FQGq4rMlt8pGjjDJIZzCXARgEYE8T8KATn0ag4=;
  b=BwTwBUokhRsbPP8QaHNr4hKx3KSQtFx0W8vfBAHMJNGSQ6weGfEci9n2
   jfZeOrCwSvHFxCRhSuR21k9XHHLUaUsJNojLDHCqIuPHHW7qQ/zCCDevy
   uqP7y+jOK5dzUBfCIFr8uQabQ2dYDtfX+WRftWRQ/THZ1G+U/L+IxzzWC
   b9s+GVdOtcAo39Vz+ps06CFc8g3rXKj+v8ekoDw3A8HSeGoeQEUOFPWGb
   XDVS5JJVsNGKQQBU/j2EC2S1uQHI4wSG1+r9dVYQIFVFFxZC8m8mw1Fzp
   2froOWrxfvA4bwtjWLbQvbzChkbemJr63F+hr4fZsOclxygaRtmLeeN4u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="359784630"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="359784630"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 18:37:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="706373338"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="706373338"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 02 Aug 2023 18:37:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 18:37:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 18:37:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 18:37:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 18:37:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGqajKfg33/s6OfJirJDuM3YCth3neLbKDhUwvDWw0OffJrYe4+1ustS8vcYoMGWVve8nJmM8yckh3w/NFsgIipdDWSSTYR/ETuPQBWwLvGhlWtbWiEQch8Si5xBc4osfRyPS2AzkyjM1oHZWTp1NWDFy/GTCO3TLp03JF4wGt7LPt1LW6YagYzm++jfLiNntP+sQAuYJUHvPyx4Xiye2PIan8tE259YlM15gehEvpf2mksHKwdTSQSxGUyMpj6mu0pla8qIXnhIcTqY5rpLVGuswthsfMaFYK6BQIRlWO1eXKhZVVLk6plmQiKiyHrr4mFZFpa99XS+K06lKNBvAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zMiYGB4/kqWvQhnev23KPV11QG4FvdXGdipP6yNlZg=;
 b=WwgauHhPouPmiJnSTgrAWIcmBYrQXoJhEuwKn+op8AO2KRm7VmU+q68oI4wyO/agyuaQhiiXtjj6A8wk0EU/ZDrfJzmYJ5c8pwdisBuo29ul6yG15HR59zqOxqe5mTRDfJoYnAe23IXcU7+kjkRBgygnfaHZ5FMJ9yL3QlUeYGbYeb2voSWFabvOUUOUidKA3psxMukpv0sul18H+OuQCNj7DB72lI3HDMsX8kSeuUpb4VQ5nlaSBW1sdYrIcbfoS/qByn6lxJRr9LoGKzy1+u390/J0+qGAqL1666pyVesh7jELlvhZjQ2Klo2+OKkOABLDjvzBh6BIoh9SKqo4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA1PR11MB5922.namprd11.prod.outlook.com (2603:10b6:806:239::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Thu, 3 Aug
 2023 01:37:39 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 01:37:39 +0000
Message-ID: <89dff38d-f047-1d45-d06d-40eb08443d1a@intel.com>
Date:   Thu, 3 Aug 2023 09:36:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] mm: add functions folio_in_range() and
 folio_within_vma()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <yuzhao@google.com>, <willy@infradead.org>, <david@redhat.com>,
        <shy828301@gmail.com>, <hughd@google.com>
References: <20230728070929.2487065-1-fengwei.yin@intel.com>
 <20230728070929.2487065-2-fengwei.yin@intel.com>
 <55c9e3f7-099d-6f57-32da-1f318a9688a0@arm.com>
 <9bba9369-e3f5-53da-bf8f-8ab887d3c3ae@arm.com>
 <a6ff77ba-18f7-f3ed-3f9a-00f04edccdb3@intel.com>
 <7c7b8c39-b412-a120-368c-ba4ab2cc2a15@arm.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <7c7b8c39-b412-a120-368c-ba4ab2cc2a15@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR0401CA0025.apcprd04.prod.outlook.com
 (2603:1096:820:e::12) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA1PR11MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: a26f40da-0f7a-4be1-91ed-08db93c238b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OwXfutj0jo3qaQDbuagm/ZeyyO4Nj00VqG0gFe3IUMQRPW/TnlBW598s3EUE7Wc3J5Kqfvv0rB3HnMjr5Lf50iStwiyPfRZVfIAszqXuC9RmQXbHlT9wUKY2T0vpXJBXxC5riG7Ls36tSJWTroGJb17/j3b4dm+TbmJsdDnnnkZhO1/eUHVm/LlnqQ0eXOw1LQbwk7+2WKSltmCql5L7BIEduoPgtFMpxnMieYXbv41bVhsigYt5CZ6ndQA9CtY8rDJkbk8ZXc42WWuEpQ38YMZM85CrKq9V0xW3nBTc5m0IyPg0oa5thL2zFRd34QHMH7+9VnddxDEulYArZeNM3PATK/Xs8Q2/qM+CG9VRW/VRanVWKOAtKPzME0xTVguJyzKun0rj9wXVJvFFVpiTLu6lDiKW8kGtwqV0Y/V7PaLT8QCSibKanA0VkbYztQNxC+mbBT0SzEgOl2fepzmbn1IZjW3jdZCAXkon9fRAla7e75gkK4uJCr5LpaD9WrJb+fWBe6C2TETWKU/5Y6jOwZKB7M+loeg13QiT3wHQZzspPE5L80GbCugo/WU8IATa0PSbbXfa2zk9BMqYehITkfzHh6L8ZoIIgeDhZN3KybK5ZCkCi1mxzCdwNZH2xIkSXhX9e3sIKk61ngF1tsTI5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199021)(186003)(2616005)(6512007)(36756003)(316002)(86362001)(478600001)(38100700002)(66556008)(66946007)(6666004)(66476007)(6486002)(82960400001)(31696002)(53546011)(6506007)(41300700001)(26005)(8936002)(8676002)(30864003)(5660300002)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXdwTmQzcXhEWkFhTnVTRWtSdlFweEk5eEhRNDUxTG5jMC9oa21HV1JlN2l6?=
 =?utf-8?B?TFc2QXBzQSt5Z0xaWUE0WHhwcmtnREFqZTRTYSsvMHFhOGJ2a3kyOWVuZFJO?=
 =?utf-8?B?UkFGZ1B3S2VxNTMxQWVpaVFDZEI0cXl1NGlycWM4Mi9QcGR5d3k1cXgyemxa?=
 =?utf-8?B?MDh0QVZlQTl6bU9CKzNmWWVvN3AvT2ZDWGxWMDRydVVpYklrM2pUdkdlOXZr?=
 =?utf-8?B?ekpMdGVuamJjRlNFVDNNa3lQT2tCVmZscGtWVXNUNnNpaTVhc21QQnM0eTUz?=
 =?utf-8?B?NnBaVmVJbmUyWHpHdzR2MUh2eFZZZ1hFYXQ3eTZJb2FEL1hmRGVONllDZG9t?=
 =?utf-8?B?dGZSQnc0U1g3d09iaFNrMGQyTk1ITlBNRHM2dmt1MGZnOEZ6VzBGQU9kWnBt?=
 =?utf-8?B?MTgyQzZMemp6YTdCODI4bm9tcU1DOGtXMzVNS3IxUm1ZL1grRWxFV2RIeDBF?=
 =?utf-8?B?UFRtMWNPd0JqQzhIZjUzc2IrcEhEWnFSbkg4UDJ5aWt3b3ZyOEQwemFlcnEr?=
 =?utf-8?B?eFlST0p3T0R1eVhMNFg4eFE2V1FoWHlwTTcwbzNnSTA4RmN6N0ZZRWdEVXRy?=
 =?utf-8?B?c2ZzQ2ExV1c5Z0RHSm5RczJBRGN6Q2YxTFNicXAvNGd0VHJoWWNiOEdPaVlw?=
 =?utf-8?B?OGE1MHFQQ2xqSVdVQlZFdTVhVVlLSWt1emV5T3ZUQzZPdFpCTXFUem5Hek12?=
 =?utf-8?B?NWIwR3V6cFBYWEVEZ2NUYlpmMnhBaFpQRW5VcnEzY0o5LzlpNko3STJ5ZU43?=
 =?utf-8?B?UnBEOEFUeVdQRTMzVlg0UVp2eW8yTENWSkY2dWJDalZDUkdMLy9tRit4eTFy?=
 =?utf-8?B?UWd5ZFY1cXZ3YSs0Vm4raEZXQysyVWhCSldDOS9FV3ZmQ1hkR3hYdFRzMmdy?=
 =?utf-8?B?UldkTXNNbklMMkJaa2dsV0U5eEFDK0dhMlBZb2xnQU5wM0NiWEVzQTVsZ0h6?=
 =?utf-8?B?SDFRbUpwUkVKcnZGa01hQTRFNWdmK1ZTL2ppTldheEdIZHBENkdEdVVpZkVm?=
 =?utf-8?B?TDY4eHlhT3NDeis3akN2cjNIR1lhTHBGSXNSdFdEZWg1RjJqWlJYdXpSVlpK?=
 =?utf-8?B?UmRJWkFrcnlJT3dIUU54R2NTbmU0Y2dieFJ3S2RNbTNXTW5xbkdZUmVLdXp5?=
 =?utf-8?B?U1plbXFMNHM3b05JNFBhcStrdlBtTzdUb2NuQ0lKSWcyR2lqbUFCKzJubTdh?=
 =?utf-8?B?MjlUWDRLb0hlZ3FocVRUeEcwNkd1cnlSbGxZTGoreFlGYlpTNkV0Q2ZwNXdB?=
 =?utf-8?B?b0ROaWxvTmt4QzZKMVJsRzQ4eWZUeWtyWVBpb2Y3a3ZjYnhPa2ZldGZ4THBR?=
 =?utf-8?B?emtHYURsVWVqaS9aWWUyVWpIN3JmM045WWdUS080d3AzVXpiQTRyaFdjNnQ2?=
 =?utf-8?B?K0ZLM055WUZzRmk1Nmo5ZkJXZEhlQ1R1M2h6WEZrM1lHempBWDNjcFFqL05y?=
 =?utf-8?B?a0pDdjhFMXdobmErNnJEQmJrSjl2S2RPbWFXamFGZzJKMDlhV255dEZneHNI?=
 =?utf-8?B?NzNDMWcybGxST2ZaT1JFMmE3OGlYbVhYeThlNEoxOXVaUHR6V3F0MExwZk1p?=
 =?utf-8?B?RXRyNmxhSzR3RCtYeEo3aEs0MUpIbUZ5d2VzUGVtb0piRUk1Y0N4V0RpdCtj?=
 =?utf-8?B?MFdRNXQzUmhPaTdGa0NaL0F0L0NyTWFWdEM2bkdVM0RHcGNDb3dVQnBQd3JL?=
 =?utf-8?B?RFREVHo2cFdvbHQ4d29ObnBPUkkycVdaRTVrTGpnSUI2Rjk4bjhxRlI3TVZt?=
 =?utf-8?B?WUZvMVl6TU5vZGYvQ1ZyWWNnUEFETU5BMjZ5ak02Y2lzQ0VtY2VaOTlvY0Zn?=
 =?utf-8?B?VEhpTHJpQVBzb2NqTzN2bXc0MjhLSWlDQ1NLOHVtT205QXgwOW9pOWNqZDUr?=
 =?utf-8?B?TVlwWU41d3hwWm4wUkJtNkFBeXpoY0lJeFgzU1FUZDBKYjlPZ2pobmdmcmJ2?=
 =?utf-8?B?MWtybGUxaWZsY0dZTlIxcU8xVmppelNzT1FvMUxBOW4zNTRBSk80eVNFLzB0?=
 =?utf-8?B?cGIzQXE4ZHNvZXN0amw5R1BqZzE3RTRNdkxwZm56aVF1ZUM5ZmhKUm5TMFIv?=
 =?utf-8?B?OXRhZlhUcEgzYWppdG9lNGZpWS9RZlF6d0dPWWUzak1nWHQ3K2dyYUpUaUV1?=
 =?utf-8?B?UmlIYlFTak4zdE5TMXlXUEdCVDUxc3R5a1I2MGlpK0V2aUJJaWdOQllYTVRz?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a26f40da-0f7a-4be1-91ed-08db93c238b7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 01:37:39.0458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4Cd69hvmfOPlibn9WgSMsdwiBr0YE4o7ky/epySvHjawcODpk87BEwbdzLRaRn7XuiwczDWtvGhGib7P9iZSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5922
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/23 23:12, Ryan Roberts wrote:
>>> I also wonder if you should change the name of folio_within_vma() to something
>>> like folio_test_cont_in_vma() to disambiguate from the case where the folio may
>>> be fully mapped with a discontiguity (although perhaps that's not possible
>>> because a mremap would result in distinct vmas... would a new mmap in the hole
>>> cause a merge of all 3?).
>> I don't think it's possible as mremap reuse original pgoff of VMA to new VMA. I suppose
>> it will prevent VMA merging. But I didn't check detail.
> 
> pgoff is not relevant for anon though, right?
anonymous folio->index is related with vma->vm_pgoff.

> 
> FWIW, I wrote a test to check if merging is performed. Interestingly, v5.4 (on x86) *does* merge the VMAs in this case, but v6.5-rc3 (on arm64) *does not* merge the VMAs in this case.
What if you fault in the pages to the mapped VMAs?

> 
> I think you should assume it might be possible in some cases.
I don't think mremap target VMA could be merged with prev/next
unless it's merged back (move the pieces large folio together).


Regards
Yin, Fengwei

> 
> 
> #define _GNU_SOURCE
> #include <stdlib.h>
> #include <stdio.h>
> #include <sys/mman.h>
> #include <unistd.h>
> 
> int main(int argc, char **argv)
> {
> 	size_t pgsize = getpagesize();
> 	char *memarea;
> 	char *memlow;
> 	char *memmid;
> 	char *memhigh;
> 	int ret = 0;
> 
> 	// Get a free vm area big enough for 5 pages.
> 	memarea = mmap(NULL, pgsize * 5,
> 			PROT_NONE,
> 			MAP_PRIVATE | MAP_ANONYMOUS,
> 			-1, 0);
> 	if (memarea == MAP_FAILED) {
> 		perror("mmap 1");
> 		exit(1);
> 	}
> 
> 	// Map 2 pages one page into allocated area.
> 	memlow = mmap(memarea + pgsize, pgsize * 2,
> 			PROT_READ | PROT_WRITE,
> 			MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS,
> 			-1, 0);
> 	if (memlow == MAP_FAILED) {
> 		perror("mmap 2");
> 		exit(1);
> 	}
> 
> 	// Move the second allocated page one page higher.
> 	memhigh = mremap(memarea + pgsize * 2, pgsize, pgsize,
> 			MREMAP_FIXED | MREMAP_MAYMOVE,
> 			memarea + pgsize * 3);
> 	if (memhigh == MAP_FAILED) {
> 		perror("mremap");
> 		exit(1);
> 	}
> 
> 	// We should now have:
> 	// | page 0 | page 1 | page 2 | page 3 | page 4 |
> 	// | NONE   | vma 1  | empty  | vma 2  | NONE   |
> 	printf("Check for 2 vmas with hole: pid=%d, memarea=%p, memlow=%p, memhigh=%p\n",
> 		getpid(), memarea, memlow, memhigh);
> 	getchar();
> 
> 	// Now map a page in the empty space.
> 	memmid = mmap(memarea + pgsize * 2, pgsize,
> 			PROT_READ | PROT_WRITE,
> 			MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS,
> 			-1, 0);
> 	if (memmid == MAP_FAILED) {
> 		perror("mmap 2");
> 		exit(1);
> 	}
> 
> 	// We should now have:
> 	// | page 0 | page 1 | page 2 | page 3 | page 4 |
> 	// | NONE   |          vma 1           | NONE   |
> 	printf("Check for single merged vma: pid=%d, memarea=%p, memlow=%p, memmid=%p, memhigh=%p\n",
> 		getpid(), memarea, memlow, memmid, memhigh);
> 	getchar();
> 
> 	return ret;
> }
> 
> 
> 
> Output on v5.4:
> 
> Check for 2 vmas with hole: pid=171038, memarea=0x7fe6c34d9000, memlow=0x7fe6c34da000, memhigh=0x7fe6c34dc000
> Check for single merged vma: pid=171038, memarea=0x7fe6c34d9000, memlow=0x7fe6c34da000, memmid=0x7fe6c34db000, memhigh=0x7fe6c34dc000
> 
> And maps output at the 2 check points:
> 
> (base) ryarob01@e125769:/data_nvme0n1/ryarob01/granule_perf$ cat /proc/171038/maps
> 55e55c258000-55e55c259000 r--p 00000000 fd:00 5297466                    /data_nvme0n1/ryarob01/granule_perf/merge
> 55e55c259000-55e55c25a000 r-xp 00001000 fd:00 5297466                    /data_nvme0n1/ryarob01/granule_perf/merge
> 55e55c25a000-55e55c25b000 r--p 00002000 fd:00 5297466                    /data_nvme0n1/ryarob01/granule_perf/merge
> 55e55c25b000-55e55c25c000 r--p 00002000 fd:00 5297466                    /data_nvme0n1/ryarob01/granule_perf/merge
> 55e55c25c000-55e55c25d000 rw-p 00003000 fd:00 5297466                    /data_nvme0n1/ryarob01/granule_perf/merge
> 55e55c403000-55e55c424000 rw-p 00000000 00:00 0                          [heap]
> 7fe6c32d2000-7fe6c32f4000 r--p 00000000 fd:02 9573653                    /lib/x86_64-linux-gnu/libc-2.31.so
> 7fe6c32f4000-7fe6c346c000 r-xp 00022000 fd:02 9573653                    /lib/x86_64-linux-gnu/libc-2.31.so
> 7fe6c346c000-7fe6c34ba000 r--p 0019a000 fd:02 9573653                    /lib/x86_64-linux-gnu/libc-2.31.so
> 7fe6c34ba000-7fe6c34be000 r--p 001e7000 fd:02 9573653                    /lib/x86_64-linux-gnu/libc-2.31.so
> 7fe6c34be000-7fe6c34c0000 rw-p 001eb000 fd:02 9573653                    /lib/x86_64-linux-gnu/libc-2.31.so
> 7fe6c34c0000-7fe6c34c6000 rw-p 00000000 00:00 0 
> 7fe6c34d9000-7fe6c34da000 ---p 00000000 00:00 0 
> 7fe6c34da000-7fe6c34db000 rw-p 00000000 00:00 0 
> 7fe6c34dc000-7fe6c34dd000 rw-p 00000000 00:00 0 
> 7fe6c34dd000-7fe6c34de000 ---p 00000000 00:00 0 
> 7fe6c34de000-7fe6c34df000 r--p 00000000 fd:02 9573649                    /lib/x86_64-linux-gnu/ld-2.31.so
> 7fe6c34df000-7fe6c3502000 r-xp 00001000 fd:02 9573649                    /lib/x86_64-linux-gnu/ld-2.31.so
> 7fe6c3502000-7fe6c350a000 r--p 00024000 fd:02 9573649                    /lib/x86_64-linux-gnu/ld-2.31.so
> 7fe6c350b000-7fe6c350c000 r--p 0002c000 fd:02 9573649                    /lib/x86_64-linux-gnu/ld-2.31.so
> 7fe6c350c000-7fe6c350d000 rw-p 0002d000 fd:02 9573649                    /lib/x86_64-linux-gnu/ld-2.31.so
> 7fe6c350d000-7fe6c350e000 rw-p 00000000 00:00 0 
> 7fff39a11000-7fff39a32000 rw-p 00000000 00:00 0                          [stack]
> 7fff39a83000-7fff39a86000 r--p 00000000 00:00 0                          [vvar]
> 7fff39a86000-7fff39a87000 r-xp 00000000 00:00 0                          [vdso]
> ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]
> (base) ryarob01@e125769:/data_nvme0n1/ryarob01/granule_perf$ cat /proc/171038/maps
> 55e55c258000-55e55c259000 r--p 00000000 fd:00 5297466                    /data_nvme0n1/ryarob01/granule_perf/merge
> 55e55c259000-55e55c25a000 r-xp 00001000 fd:00 5297466                    /data_nvme0n1/ryarob01/granule_perf/merge
> 55e55c25a000-55e55c25b000 r--p 00002000 fd:00 5297466                    /data_nvme0n1/ryarob01/granule_perf/merge
> 55e55c25b000-55e55c25c000 r--p 00002000 fd:00 5297466                    /data_nvme0n1/ryarob01/granule_perf/merge
> 55e55c25c000-55e55c25d000 rw-p 00003000 fd:00 5297466                    /data_nvme0n1/ryarob01/granule_perf/merge
> 55e55c403000-55e55c424000 rw-p 00000000 00:00 0                          [heap]
> 7fe6c32d2000-7fe6c32f4000 r--p 00000000 fd:02 9573653                    /lib/x86_64-linux-gnu/libc-2.31.so
> 7fe6c32f4000-7fe6c346c000 r-xp 00022000 fd:02 9573653                    /lib/x86_64-linux-gnu/libc-2.31.so
> 7fe6c346c000-7fe6c34ba000 r--p 0019a000 fd:02 9573653                    /lib/x86_64-linux-gnu/libc-2.31.so
> 7fe6c34ba000-7fe6c34be000 r--p 001e7000 fd:02 9573653                    /lib/x86_64-linux-gnu/libc-2.31.so
> 7fe6c34be000-7fe6c34c0000 rw-p 001eb000 fd:02 9573653                    /lib/x86_64-linux-gnu/libc-2.31.so
> 7fe6c34c0000-7fe6c34c6000 rw-p 00000000 00:00 0 
> 7fe6c34d9000-7fe6c34da000 ---p 00000000 00:00 0 
> 7fe6c34da000-7fe6c34dd000 rw-p 00000000 00:00 0 
> 7fe6c34dd000-7fe6c34de000 ---p 00000000 00:00 0 
> 7fe6c34de000-7fe6c34df000 r--p 00000000 fd:02 9573649                    /lib/x86_64-linux-gnu/ld-2.31.so
> 7fe6c34df000-7fe6c3502000 r-xp 00001000 fd:02 9573649                    /lib/x86_64-linux-gnu/ld-2.31.so
> 7fe6c3502000-7fe6c350a000 r--p 00024000 fd:02 9573649                    /lib/x86_64-linux-gnu/ld-2.31.so
> 7fe6c350b000-7fe6c350c000 r--p 0002c000 fd:02 9573649                    /lib/x86_64-linux-gnu/ld-2.31.so
> 7fe6c350c000-7fe6c350d000 rw-p 0002d000 fd:02 9573649                    /lib/x86_64-linux-gnu/ld-2.31.so
> 7fe6c350d000-7fe6c350e000 rw-p 00000000 00:00 0 
> 7fff39a11000-7fff39a32000 rw-p 00000000 00:00 0                          [stack]
> 7fff39a83000-7fff39a86000 r--p 00000000 00:00 0                          [vvar]
> 7fff39a86000-7fff39a87000 r-xp 00000000 00:00 0                          [vdso]
> ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]
> 
> 
> Output on v6.5-rc3:
> 
> Check for 2 vmas with hole: pid=3181, memarea=0xfffff7ff2000, memlow=0xfffff7ff3000, memhigh=0xfffff7ff5000
> Check for single merged vma: pid=3181, memarea=0xfffff7ff2000, memlow=0xfffff7ff3000, memmid=0xfffff7ff4000, memhigh=0xfffff7ff5000
> 
> And maps output at the 2 check points:
> 
> ubuntu@ubuntuvm:~/linux$ cat /proc/3181/maps 
> aaaaaaaa0000-aaaaaaaa1000 r-xp 00000000 fe:02 8199010                    /home/ubuntu/merge
> aaaaaaab0000-aaaaaaab1000 r--p 00000000 fe:02 8199010                    /home/ubuntu/merge
> aaaaaaab1000-aaaaaaab2000 rw-p 00001000 fe:02 8199010                    /home/ubuntu/merge
> aaaaaaab2000-aaaaaaad3000 rw-p 00000000 00:00 0                          [heap]
> fffff7e00000-fffff7f89000 r-xp 00000000 fe:02 41410085                   /usr/lib/aarch64-linux-gnu/libc.so.6
> fffff7f89000-fffff7f98000 ---p 00189000 fe:02 41410085                   /usr/lib/aarch64-linux-gnu/libc.so.6
> fffff7f98000-fffff7f9c000 r--p 00188000 fe:02 41410085                   /usr/lib/aarch64-linux-gnu/libc.so.6
> fffff7f9c000-fffff7f9e000 rw-p 0018c000 fe:02 41410085                   /usr/lib/aarch64-linux-gnu/libc.so.6
> fffff7f9e000-fffff7faa000 rw-p 00000000 00:00 0 
> fffff7fc2000-fffff7fed000 r-xp 00000000 fe:02 41316494                   /usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
> fffff7ff2000-fffff7ff3000 ---p 00000000 00:00 0 
> fffff7ff3000-fffff7ff4000 rw-p 00000000 00:00 0 
> fffff7ff5000-fffff7ff6000 rw-p 00000000 00:00 0 
> fffff7ff6000-fffff7ff7000 ---p 00000000 00:00 0 
> fffff7ff7000-fffff7ff9000 rw-p 00000000 00:00 0 
> fffff7ff9000-fffff7ffb000 r--p 00000000 00:00 0                          [vvar]
> fffff7ffb000-fffff7ffc000 r-xp 00000000 00:00 0                          [vdso]
> fffff7ffc000-fffff7ffe000 r--p 0002a000 fe:02 41316494                   /usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
> fffff7ffe000-fffff8000000 rw-p 0002c000 fe:02 41316494                   /usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
> fffffffdf000-1000000000000 rw-p 00000000 00:00 0                         [stack]
> ubuntu@ubuntuvm:~/linux$ cat /proc/3181/maps 
> aaaaaaaa0000-aaaaaaaa1000 r-xp 00000000 fe:02 8199010                    /home/ubuntu/merge
> aaaaaaab0000-aaaaaaab1000 r--p 00000000 fe:02 8199010                    /home/ubuntu/merge
> aaaaaaab1000-aaaaaaab2000 rw-p 00001000 fe:02 8199010                    /home/ubuntu/merge
> aaaaaaab2000-aaaaaaad3000 rw-p 00000000 00:00 0                          [heap]
> fffff7e00000-fffff7f89000 r-xp 00000000 fe:02 41410085                   /usr/lib/aarch64-linux-gnu/libc.so.6
> fffff7f89000-fffff7f98000 ---p 00189000 fe:02 41410085                   /usr/lib/aarch64-linux-gnu/libc.so.6
> fffff7f98000-fffff7f9c000 r--p 00188000 fe:02 41410085                   /usr/lib/aarch64-linux-gnu/libc.so.6
> fffff7f9c000-fffff7f9e000 rw-p 0018c000 fe:02 41410085                   /usr/lib/aarch64-linux-gnu/libc.so.6
> fffff7f9e000-fffff7faa000 rw-p 00000000 00:00 0 
> fffff7fc2000-fffff7fed000 r-xp 00000000 fe:02 41316494                   /usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
> fffff7ff2000-fffff7ff3000 ---p 00000000 00:00 0 
> fffff7ff3000-fffff7ff4000 rw-p 00000000 00:00 0 
> fffff7ff4000-fffff7ff5000 rw-p 00000000 00:00 0 
> fffff7ff5000-fffff7ff6000 rw-p 00000000 00:00 0 
> fffff7ff6000-fffff7ff7000 ---p 00000000 00:00 0 
> fffff7ff7000-fffff7ff9000 rw-p 00000000 00:00 0 
> fffff7ff9000-fffff7ffb000 r--p 00000000 00:00 0                          [vvar]
> fffff7ffb000-fffff7ffc000 r-xp 00000000 00:00 0                          [vdso]
> fffff7ffc000-fffff7ffe000 r--p 0002a000 fe:02 41316494                   /usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
> fffff7ffe000-fffff8000000 rw-p 0002c000 fe:02 41316494                   /usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
> fffffffdf000-1000000000000 rw-p 00000000 00:00 0                         [stack]
