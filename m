Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB4F7AF7C1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 03:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbjI0BsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 21:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjI0BqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 21:46:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B941A59D6;
        Tue, 26 Sep 2023 16:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695770813; x=1727306813;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cHrL7fzU4QiuYcoJch+CPojhogDUJUoR0OZsdXXa4PM=;
  b=KXmZl2ON8RlnDDawkaG64L+f3ldOWauznMgmTmb0EVBoWc051oqpraKC
   J/Bn7/tp+6TgW2mM7JOg1DoXLmXEbmYS90Z10PvHlIDomP/qR30FuAcWL
   1qP56VbSZzHzP0oMwFAnJAOuAlxs3Rn2y0dvzXmooWI1f8k+ncWAEoRTp
   IceyhwB07+Z+UESxf20kZBScUctZjf07bg4uH4ehHdOPrArNsG6wIZkzq
   JZlW7DgJJfwzZ2yCxaLFc+RJrEDIAMCQEjqbyGaef9wLIzhiUiKx9OnHC
   YGcNs7c0aRFhGErfJ+bnx90Tg44TiDs7/rKQh1zrKYLlu3WrCo4kXTn5s
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="467976719"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="467976719"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 16:26:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="752353377"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="752353377"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 16:26:51 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 16:26:51 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 16:26:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 16:26:50 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 16:26:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laIbkzpw2oYCmBT6XBTEEE4rbutsU4sG7cIymKaELPls/qYxIKhIgeyd8cmbAiJLxF/MUkw5sWJlKXpUcWtbk6n3r/alv/omkAHTJYfC/RsnoCttpJ5b3VTlMX29MgO8U0h1WOKQ/3cMv9mIEYG9yaHBfH31/1XlSeB/YMSTVlfol01qLn7eIv0laHvSDQd+xvsiRwjX2H+q45sCU2CbaS9xH5shgZLbvpmRwxJgrnD6tmUFVAwnWcZaJ9BR3snkKf5IMD5VUECzl0c3mkykcZLjjXuEsuT9xlQNJcHS4LQPlg/O0uWtS4VAax9t4MoHaTHqYygreNFD4ql2m3rHjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/u1OuA2ASgdFyZBCZjlhyPmYIYhd3hoCUBH3zqSdzQ=;
 b=KMlURvLd5/n6cb4K67kJlmU4hDnL0KMrfkH/gH3tcGa6/0UTcy2zsKgHZDMzDK4BQzdnJl3byCQNJTBYOvwquvVF94hQBqdwz9VDmMgeu5Y7BBjhZADuNaH20/DRY0Xsu48XcpPx5SQCKeCo8In6OKneANPtwfhnECXnlhxO3ZhPxbZE3R79RffeFW7LtBoYrSGJYjQP6sFJ9j3D1/MaJaHzKKt1rlaYycjOaSxnfKkksXgL7Xk8vtDoqS2FmYqCCqlXUECmBvqKFajgs8iiqJ3Jd+tZ26MakU7c1MJqEUKgoxLxwzCri8WSASuPVodDzWuad3YaTnuoHZ5N/nvaFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3773.namprd11.prod.outlook.com (2603:10b6:208:f6::32)
 by DM4PR11MB5309.namprd11.prod.outlook.com (2603:10b6:5:390::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 23:26:47 +0000
Received: from MN2PR11MB3773.namprd11.prod.outlook.com
 ([fe80::1c12:84a6:8650:2914]) by MN2PR11MB3773.namprd11.prod.outlook.com
 ([fe80::1c12:84a6:8650:2914%6]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 23:26:47 +0000
Message-ID: <aea765f3-2b63-c98b-db64-e886214354e5@intel.com>
Date:   Tue, 26 Sep 2023 16:26:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/9] platform/x86/intel/ifs: Gen2 Scan test support
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Hans de Goede <hdegoede@redhat.com>, <markgross@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <rostedt@goodmis.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <pengfei.xu@intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com>
 <20230922232606.1928026-1-jithu.joseph@intel.com>
 <20230922232606.1928026-5-jithu.joseph@intel.com>
 <c390bdaf-ab5c-bf1f-bd64-29e2827d01f@linux.intel.com>
 <89f48b0a-a6b6-2204-7d96-28ebbe96b18a@intel.com>
 <e22bf1b7-48c1-39e8-f0d3-636a6a61bc48@linux.intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <e22bf1b7-48c1-39e8-f0d3-636a6a61bc48@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:303:6b::32) To MN2PR11MB3773.namprd11.prod.outlook.com
 (2603:10b6:208:f6::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3773:EE_|DM4PR11MB5309:EE_
X-MS-Office365-Filtering-Correlation-Id: 95331bbb-4a00-49a0-341b-08dbbee80d03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uUp+PDK14JcB4Za0E+Ild/9Ypti2p60a/zA7RXFC+0pnQESxDq7CBh4h38EmzfvIZe6jPQocOSqnPMeV547At4jIpbs2+qHBVZnSZXkpFWtbr5ADldzgNbH4OM5f5rvMJ+0vjfd693WMQR8zSfSQvaKYX7Sp5mcOQkyr2PcSaEnyfur7ImgV0Uk/7cZssZrpQlrEb3YkfEUEUDAmn/00b+voc0wboEV6u59WfUoN/IoMfvNkMjJjmLMsZjCbDeMlGdP8/ceqk3pWnN1V6eDgCG9Y4v8W77UuODV9FO4aqsDyfWd467xnZ2mDpdQ2gTBqvwAGaSXqRLmoHcWHUtjVrHONhLtHKba1rhvWjAn+Hb1QVmnAAj446HH0meqhWAQcjVjx6d28kcvSK55Z4gcyVd11gin1yPUSMceuykMa8PkrCTZteQDs9N2AJrgL7P++HupZKeiWiareil16NX9A8EoDSp+q4YlQBQjPAgOQfuMIx78t6Cgo1kox4g+5Go+MTIIR+Nbsxq2uHLS544T96GES+D1kUOPYUa1bGdTFp+m4NQ+Hhu42E1RJMiccwqgHx5940l0u2S1cB/sWZyPPnfxkzrUMe9giQF8zfHLuHRFRQSG5f/4aJeXC2tfBKkGiB+d+13NcydY4xs9XhFcLKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(186009)(451199024)(1800799009)(2906002)(31686004)(7416002)(66476007)(66556008)(316002)(66946007)(54906003)(6916009)(5660300002)(8936002)(478600001)(6666004)(6486002)(6512007)(53546011)(2616005)(26005)(6506007)(66574015)(4326008)(41300700001)(83380400001)(86362001)(36756003)(38100700002)(82960400001)(31696002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE5tdW5UYmxFWlhWYUdWNDZta2pGbkdiV2ovd3lVY1lHR0JETjkwV1pua3BO?=
 =?utf-8?B?WE1BdUhvRG11S0luTWU1bjR5TzhFVzNpTkZ0SmRJMm5mQUpXMTZnR2daeTVV?=
 =?utf-8?B?ekc5SEhaMjJFRzlCd2VuOUFWL29ESnZyc2hoNGQvR0JocjZzSVowcnV0b0E1?=
 =?utf-8?B?N1FVbWFyUGtHMjUrMWkrcllleW1BK1plZFA4ekZTT2w5aDBLVEtZejZOd3A4?=
 =?utf-8?B?Qmd5WWJqbEpaWWcvMmY0czkrWU9hVkZLV0RRNVFZSmJpT3hxL1E1YU5MdHBQ?=
 =?utf-8?B?WjhNUzBmWjRPWUJzY2pLeEx1VnhoRE5TT0pHeG9nSzFPREwzc2dKUVdKa1NR?=
 =?utf-8?B?Q1RtR1lYMU9VL0VxY3R1YkdteHpJdXplYTY2R3VwU3JRQUUzZVpaQzNYSzVv?=
 =?utf-8?B?Y2tXZExtQUdhNHZ3VUZ5eDBkUlFyaWcwTVBURW5LODI0NGNOakJNMXZpdUJ5?=
 =?utf-8?B?d3p5cUNOaE9iWGJ4UWxaU09mc2J0SGFCL1g4eDg5SmFzWHVsc3ZQVGVFQ01r?=
 =?utf-8?B?Wkl0Y0I2M3dOL3ArR2xvbWxnYlBWR3BNeU16ejZUK3NlVTcrN2JNR3VFUjY0?=
 =?utf-8?B?bFk1QjZmU3UzajBhL2Zmd3UxOEhvMUs1ajVWdkxqU21ZNXhRNTNlM1hUL2Jj?=
 =?utf-8?B?bG9yTTN6dzNpbFdYS0tMTEpPMnFOOCtTYmZzL3c0UW03VjBXTHA5ZWFjTkF3?=
 =?utf-8?B?a2ZiNHV1ZW44YytzZHFwc2RRUkZXWUxzZ2NxMTBsZmtLZ1UwRFlxSFJKZG9r?=
 =?utf-8?B?SmROWXhpWkhsT3RHa0UwbDhaeDFuQTlGK05tdnFuWWtSSm10UFFlc1Uwc0Mz?=
 =?utf-8?B?TVpHdWYxaFkwSFRSeU5uR29yMU5LSnVkMi84SER4akdmTzhKK1psTjJSY3Ex?=
 =?utf-8?B?VHNmT0Z5UGJQZ1hZeGo2a1hzb25pOHliREc2SU83bkE2RzIySUtXZm5Jb3BO?=
 =?utf-8?B?emVuWHM4anNJRnd1Y1dzYUxVNlM4RjlhQ2dyQUE2eTlCNFU2VXI5Z0F5amxE?=
 =?utf-8?B?Q2hEUVBpNTFtKzlaWXVEQlh6LzFoQzFGREM1RzJqVXk2T1RpVEN1VUhFMGUw?=
 =?utf-8?B?K0RmUFE1TXU1SlVxUkIvZzMrb08vem9xNFpPN1ZzMlhzc2I5eW1ud3FoM2o0?=
 =?utf-8?B?RmVLYjFGVVFUNmxEMExhanIxbVc5L2tEbnNhbWU3d2F4Vis5Y1YvNE9NLyty?=
 =?utf-8?B?SThxbyt2RlA4UWplV2t3d1VRR3FHeUxmcVcwU28wY054eWE5cWpXdmd2Q21G?=
 =?utf-8?B?SDdXWXhsanp3c05CM051SVh2SURTR24rb3BoQ3hsRnY3R3d5THplZGh3cFIy?=
 =?utf-8?B?RVh6NVg3V202OXBxV0FnRUJab1o2MzF0eWRDUmxiKzBQNW5IcTdKdzVONEg0?=
 =?utf-8?B?Q01URW04TlUwZ0ROaXZBbXJMak1VYksvM3BUZHhoRjNCbUdTcVl1M2M5UWFh?=
 =?utf-8?B?SlE0b0I3NHpNeitjVW9uaGxDY3VPdXppaGN0NTA3WVhBS0EybmI4bTJuU29P?=
 =?utf-8?B?UHMyclFLUS9sQTR5b1dnd2dRaTV2UldabU11UGk1QmxPQWkxRENUNnIvazRu?=
 =?utf-8?B?NmVHQTZIeTBUdGNwZEJvWDVhQnlYZnFDdDQvYlVwSTY1b3h0M3l0ZWd6cmF5?=
 =?utf-8?B?enlWTnpCV1l1QVdOL0tueklUNlNxMmZoUHkrT0ROL1Nkc0twa2JTN1MreWpa?=
 =?utf-8?B?N1g1MGNPUWovc3FIbFlDSEJzMHQ4SmkwNHRrUE11Q2c5dXk0SEw2WGR6T0xU?=
 =?utf-8?B?NUVxbG96ekJTbmhDUnhYTnArUDBJZmxWUVhOWE40ZU5XaHpqeTFlcmUzbVRC?=
 =?utf-8?B?bit4blM3dS9RM0pnNzd6aGdRUk5sRC9vempmYU10MDNkbUkzb1ovYjBMeWlm?=
 =?utf-8?B?aTN6R2Q2UENBS29FK3cvZ2VuMmtmWWRkeGY0YWNHNFBxdkZ0ZlB2dmNyWHp6?=
 =?utf-8?B?NUtjWGtOR3RyRTBrLzBSMDUrWUJFbnJzMDVEcWpVb09WajdZQ1JKY0tLcTA3?=
 =?utf-8?B?V2lDcDJDUmhhN0pvN09mRENJajlybWY4MW85UGNHSXhjbmJqS3E2TXlZak5X?=
 =?utf-8?B?bjJ0UDhsVzFDMWk1dll0YTFHWlNQaGwyelEyZlpib25McXh1V0I2M094RDdy?=
 =?utf-8?B?SU0xWnY2Vlh5QlV3dzNmL1pJWEF3Ym1YSW9pRTgwa29TTnVYb0tYT1A2OGVQ?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95331bbb-4a00-49a0-341b-08dbbee80d03
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 23:26:46.8268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fU0O8+ZGC3ZjQuZIeLWwlKsbzGPUoo7UoC3kcZbQcxEIJYdT+PLny32PZC+QZvH1WKFZrL9Jf7bjnwEFN05Xfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5309
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



On 9/26/2023 3:20 AM, Ilpo Järvinen wrote:
> On Mon, 25 Sep 2023, Joseph, Jithu wrote:
>> On 9/25/2023 8:39 AM, Ilpo Järvinen wrote:
>>> On Fri, 22 Sep 2023, Jithu Joseph wrote:
>>>
>>
>> ...
>>
>>>>  
>>>> -	activate.rsvd = 0;
>>>>  	activate.delay = IFS_THREAD_WAIT;
>>>>  	activate.sigmce = 0;
>>>> -	activate.start = 0;
>>>> -	activate.stop = ifsd->valid_chunks - 1;
>>>> +	to_start = 0;
>>>> +	to_stop = ifsd->valid_chunks - 1;
>>>> +
>>>> +	if (ifsd->generation) {
>>>> +		activate.gen2.start = to_start;
>>>> +		activate.gen2.stop = to_stop;
>>>> +	} else {
>>>> +		activate.gen0.start = to_start;
>>>> +		activate.gen0.stop = to_stop;
>>>> +	}
>>>
>>> Is it okay to not do activate.gen0.rsvd = 0 anymore? If you know it is, it 
>>> would be nice to record that fact into the changelog so that it can be 
>>> found in the history.
>>
>> I did test on a gen0 to check if there is a problem due to this (and it seemed fine).
>> I will make a note in changelog as you suggest
> 
> Actually, I realized activate is a variable in stack and those bits are
> uninitilized without that assignment so don't remove it.
> 

Ok, I will post a v3 with all the suggested changes in a few days ... Thanks for the review

Jithu
