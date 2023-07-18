Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4B9758638
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjGRUn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 16:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjGRUnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:43:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F385919A0;
        Tue, 18 Jul 2023 13:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689713032; x=1721249032;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TJ8/eczyq5bosRxLxl4W1NDcbqUg7F7wXIwGUrWsk90=;
  b=iDgm+LqdpH9Z/hd8K7NDYJp0vwx5XT55EoISSlAWuuptkXWjb8r36qvZ
   KDbMnQXnWud4UxwOhoA9YyZMZYw42TUaSf9JW2tt5Q6Wa71N2ELVWWf69
   Dl/pH+71QpfLd6g9u33CKPuIaXiG7KFX40v/ye4ClIZnuiY1o7Ei2HPxW
   wXCwTtnmxgsiRz7oqtUACDX+YJoM04Rn1QoqU/Z4uGnWCJ0iMowvenotW
   VEsEiDdEIoHYo1i8crMUgMtIXrf+00yDSxTMZZQ3sAQ3MChrekstdgZI5
   XLNyiM0+V/m0cqcnnPuxLKHAp9YXgPV5sRAJf1AmUOvB8VPhOOAT7uoAA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="369867178"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="369867178"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 13:43:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="793760864"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="793760864"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 18 Jul 2023 13:43:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 13:43:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 13:43:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 13:43:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYXTnBlXibVdjzE4HH3j75q26QcrXzJdyfC2V1Q+WDlHWxParK/x2FuQfvhWWSugMnUX2qgU1dRN5aXEmjpo201GdHzIrUv/0RRzBKwwPUqrLWfnRf8Awooesd6/+KC1SfUKVs50pnxLOiuqQJwx63mPDayAk9HWHNm503X7EVj+RYG15qwGF7d+49FFCwZFXIN74QsTSckPy7QFI2lQZEflbIwzI8tRfLJlu8QYVDGgSeCv/ENL1KOTOeKxjgs9ktHHm29UFl0AiK/uIDMbMKwcI57dJIsZIW6hQfzdMUnOIpF0inU8PubDJi1J6HvnUgpFikqhAJcpUAK3y+m6Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUteJq2SgQvx2sjTgxRvpnmN1n9nS/e+nm3tH/1IQhw=;
 b=G9z3YwrLk2E23yzL+ioYJi1elNgEPCuGhBub9nU4oTzNg6zbpdkIGsSzaQY7YwpmuiosW8ef80P5LulmC5yveCC6ArEKVzjnL0OJuRZ9yGjGg3E2EEfUxtoIJR6AjtR3+iYblzn249VynGC1sVFHcyXn1jIDUZ7U1oaqMT570GVT+B6LHOQ4F2joXRWsmvSkPPOZQYxGhMv0+VyHboy8dEow0bO2Z0cnpFQ3ylk2D6HPuN40boVLmhizF1eLT1LLyFwgWX6x+vrGWBXHOA8H3mYm+kfh05nU6iLaQSRk6C4AjeWcGnXf0vAZ7R+gz5F3Eo787WXuZhgVPwKAcwxhMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6346.namprd11.prod.outlook.com (2603:10b6:208:38a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 20:43:48 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28%5]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 20:43:48 +0000
Message-ID: <ef5b5a4b-d8b1-b82f-243f-170213883f05@intel.com>
Date:   Tue, 18 Jul 2023 13:43:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v3 5/8] x86/resctrl: Add package scoped resource
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230713163207.219710-6-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230713163207.219710-6-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:303:2b::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 37b217ba-dfd5-44d5-04a4-08db87cfaffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J7xs3JMexALVl85zkQixWJxuZD7dZq+94deFOsiVFVcB7s72oDjbUaxkpeRugXj9OCGBiNalOEQjbCS1TxyA2EFJ8c1q5GNXHVyFr81kVs5S6GB6UaCY+A6sSS9R1hpdDwwSa1A+5YVjnR3iQPEOxw8089Qqll58B18Q1hTC8a7YoNibmk20DmcvIXSXYdJt5Ko+4Hf4vLOHeCp0CTHo8WywNqMD63RgW+7pSMXFL2djDlal1tstBwB85rMDohSwv8K+is4vkoyJ5B+f+woTgfUqFezuLnUaTtCA8ID7LK0fwMx09hq8LuqzGxmjIRti9X4TkHw2OVIGnXaH2qE0pWbjCgmL0pvAN0tweRvL18/fPYjXfD0a8HGrs2MGxSjLP5Qo4QOrWSQ5x6jcQmvQnxlp0p3n9gBwOgBxoAb3tD0xxQcoA47j9PoaNg+xurKPvpPhrY4nPdjJIMx/V2Ab/XqL0QPAP9FQHXvz5/OuFV59WqoOCLT5xt0L3UwpHnjasGIWCxmxZkdad1hH2wIsKZoxeDJ1KtYwmKsps249Aljk2it6JFydXbUv6fxeE7jl1lawT4xCQ0M0+0DFdIINRlKiAKvK+spe07wUYGRkYhAEc9iVxuWFzjhE32bwezTjIDUmvs0w9RarBpF5waAydg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199021)(110136005)(478600001)(6486002)(6666004)(54906003)(53546011)(6506007)(186003)(6512007)(26005)(2906002)(4744005)(44832011)(4326008)(316002)(66556008)(66946007)(41300700001)(7416002)(36756003)(8676002)(5660300002)(8936002)(82960400001)(38100700002)(66476007)(86362001)(31696002)(2616005)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2crLzR4RW84R2tYZnpFMFhVU0REYW9PdW9ldStjR3JXSk9XQUdDRzZGcDdO?=
 =?utf-8?B?SDVncU9zb3JKT1VrRGRSaWNseTdWTnoyRWxvVTBhUVZvK28rWUFreWNEbEVR?=
 =?utf-8?B?eFh4Q09Bd3M1Y1ozT3J0bW1Pcmc0RHgzMW4xVXdyczNCZ2xSYWtyUnlhLzZB?=
 =?utf-8?B?VCtxTzk4YlJMWk1UTXJVdGNNOXdMZjdxa21ldlZMRFNwSVlqdHdSTzl3UnFK?=
 =?utf-8?B?R0dTWXpKU29QT2xQUzd0MGJlbmJPMTBPUml2R0NmcTBBcHdTNGRLQXNtQkE2?=
 =?utf-8?B?VVB3NmRjRzhGODVFYW9sZVlKL3ptSnBic0lFWlhnK1dObDdBLzJwYVNmUVRF?=
 =?utf-8?B?ZExUYUJRR2JHWktaRFVpSmJlRmtocU4wQUU1R241N3NKekFjRDgxVEltN0tK?=
 =?utf-8?B?ZmVZQWJlT1NieGpKQWFseUx6SVROeXRGTzVKNHVHNkp0WnhQQndYQXFzM0VZ?=
 =?utf-8?B?bGl2Rm94YnNLZ3JnS3VnYXdqSmVENWFKbm54OHRHMUFvaE1GRW94QVZMREtz?=
 =?utf-8?B?YXhRTjFQNnhYR0t6RmtCZWZGNE5veDc2UGxtcjh3UjNMc0R1YmgwWk14ZnRV?=
 =?utf-8?B?OVp1QkdqejY4dlFpb3V0ZjFZak9xOWhMUnR2L28xemJwWkNoY0VQSXRXVWhS?=
 =?utf-8?B?cDBNTk1zemcrb1FIY3FLNWhmNXkvazJ1TlJLdlE2WksvYkFJMnBLS2pmekhU?=
 =?utf-8?B?RTNEN2U3TlRjanNRSHlPY20zQ0JVOXZxSml5d0IzVHJLKzVHbjlQTnU1RHRr?=
 =?utf-8?B?ZlV5WUc3emxCd21tRVFGWnBBSVBhQlNZVVVpaGZZd2xNVGNDT1JNK3RKWkY4?=
 =?utf-8?B?Z3E4dnpUelJ2SmNScEE0MWlZTGRNUTcyMTdzZWQ4Y0RhWEJCOFBoV1k4RHlC?=
 =?utf-8?B?dWlxcUFPZHpmdVUzUDJZUVdqMU5ybHJuWW01bU5pWjdmZjRHL0FZZGlLU0d2?=
 =?utf-8?B?eDBVQTlkcHp4emdGNFh1anhvaXJzak1nbmRscWl6dEQ4VFhZZWdRK0JzeHNY?=
 =?utf-8?B?aDdwNFlqZDRZajU1WDVCMTRHL3dZaTZVcGVyVXhncWg4SHpNdmNCdUw4Zzk1?=
 =?utf-8?B?dlNSaEdpMEg5Uk0yUDhMOVdEMW1EMjNkS0oyS252bDV0eW1wTXhHNXZlaUlE?=
 =?utf-8?B?TEF4VE01UDhWSXJPVGJ4VzdlMk81aUFqK2FvZHpGc2hsUVpaV1ZPWGJPVzB6?=
 =?utf-8?B?bHc4Vm9VVGkrZDRHc0tGQlBrWFZHN3YrVFJkZHRzS2tBdlpudlNlOSthcjA4?=
 =?utf-8?B?Vjg0UlpWVStOTlhlQlA5YmNRaWdsVkl3bHVldGx2ZlAwZXJLOHBSTjlxK0Vl?=
 =?utf-8?B?N1JuNnJYTGNtenBvc1Q0cSs0UTJQSmVDVy90Nkh0NXVHUjFzSzRmMlhvdU9G?=
 =?utf-8?B?UWs3SzVTdXdpNGRQTzF5S2lWNVBNMXUzaGtKS3VvRFJPYUtMZ0l1MGR4Z2V5?=
 =?utf-8?B?ZnZDQjM5S2JxMk4vUzlwek1YN25xRHhqWGVsa0ZkV0FJTURnRlNMbm5YcUtV?=
 =?utf-8?B?TkJhN2VobmF5RVhPNThmQlAwczVxcEMzTkYvNG80S3BCNTBjZ0p3bUVQdXlz?=
 =?utf-8?B?bVIzQ2VYeHdlR09rUkkwNnBDOE1wRmw2Y0g3dXdwR3BCSk00blhidU5IRzBL?=
 =?utf-8?B?V25uYXJhQ1oyNmFQQ3hxQ1QzZHBBaWw4K1dJRHF6T21FaXpxUS8ycFRMMEw0?=
 =?utf-8?B?dEdmd0NDcXQ2b0pNTWwyWFk5RGlzUUNiL0l3QWwreEp0OFYvUnFhMlkzYUJ2?=
 =?utf-8?B?RWwrcmRrVkdWKzhaYjdxUEsyTTl6LzF0RjFyR1VrSnlNcGxKakhKMERtVXR3?=
 =?utf-8?B?WFk3ckZZYlh3amdFVHhvOEk2MldzUTd3aHBVbGhpR2wxUjY0KzFrR2ZTeVU4?=
 =?utf-8?B?cGxSRk9ZaUhTdzd6SHl1cmNGRVVLcURWa1ExcENMOWxzdVpQWGI5aWYraXUr?=
 =?utf-8?B?aGhRWDV3dDYxQWpFeStoWTQ3bkNONkJIMDRjMUhiZUpRd05kQUpUVFIwL3Vh?=
 =?utf-8?B?SmFZd3JydmhUMDYzYThwZFFFUXBGWkdtcE5hZ2lIOGNEWGg3VnNCRFM4eElR?=
 =?utf-8?B?Uk44NjZZa2tkRUkwM0hlZUpDQyt6bWVGSU0wb0k2UWN6dk9CNDRzeDNuby8w?=
 =?utf-8?B?bzJZWm9nZUZJSzlUWFdHZFZwdW50WjFpRWZCWWgrOVBWSUZnSmgyNlN4ZW50?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b217ba-dfd5-44d5-04a4-08db87cfaffb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 20:43:48.5222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPxc22/8XXB63cIW1fh72skcWw1MmRF+LusIbCy7kWCwO3TyOa4M/qvjyh4NdFIrsmbxqJV1ur5imt4tR9w3JzhfG+IlnXJWP9QUjkGNEzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6346
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 7/13/2023 9:32 AM, Tony Luck wrote:
> Some Intel features require setting a package scoped model specific
> register.
> 
> Add a new resource that builds domains for each package.

If I understand correctly the only purpose of this new resource
is to know when the first CPU associated with a package
comes online. Am I not reading this right? Using a resctrl resource
for this purpose seems inappropriate and unnecessary while also
making the code very hard to follow.

Reinette
