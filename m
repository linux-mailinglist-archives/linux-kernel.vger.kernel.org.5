Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF9B7A56D8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 03:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjISBMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 21:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjISBMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 21:12:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF30110D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 18:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695085919; x=1726621919;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OitC4U0ksYkUoC3asT4fZuQWd1T0e0UhEmU1+taW+FA=;
  b=MW/WkJZTr7ypjAz/K4jzZu4tgj8CiV0hNvWWcTPh1u+ZTM/ok2np4Lvl
   M8Gmh9X3ef+dlLjtJXdlw2zoHo0/7aRC4hv5G+l9VeoB9AJpgsIztKJ7q
   WuWuhtO+3+M03uKamxAP2y6PwqM7jSejLOk739BjtdObX1w3PHNP/tFYx
   OxuTKPi401pnBtg4JGnYG0cC6RQsuNM4wtcpnGXJXANdL9aKqY/HbUIru
   jHe5nUNDLQYKH3Kl+dVTbtvV1MYCkMJjnZSXSEAh3UVuf1zKkxagvVx3a
   Nm2Y20wlaUSwBUcu5fOell4my5x2O2/75VwGasR5v1st9POrB6P4d+3Jt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="379726670"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="379726670"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 18:11:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="746033020"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="746033020"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 18:11:59 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 18:11:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 18:11:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 18:11:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 18:11:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDgCi0BpD2YvjIB+P7/y5q9xXviU7VsXapE6aArFg7S3AMJf1K8GyBHNRXBT4Kt/MDXnWeRyk5eSZKn7rxxVVkR89dTwbkoEQ/ycc1aiQ0yluVFWD03iHqFKX7H8cf3z371Sd/o3Yfigbx6pg9hp5h7ja1pOBv811CRfh4x7hBVb9VbxO6G+spVn7YHdnRFkKspWiBV1iHoMleM+TaivHr5JAUtfrD43RzoOfdUDsxofCl/Rai13b8wVFBqBwPcAD+A00WDM298bJGMLKdPCRpeeYqWZ/IHJS033iO3vlBHFdcWGSplht+iuKh8NT/usAeELB0tN+wZ8K9YHdxy+bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNVhzcb4T98bdyEOjx81FGmqMeY3us9lutUCMgYMIiM=;
 b=KfgbbrYE1oYbiIEx0Ky7nV4kPnZU8cJJkT39wQqpdK4iIX1V4aG7ZJ4SHxGDj3cwqiI64bCEsvvZAVBFkD4dO0X/cuhSMONMMTL7K65BZNI7ZFO2w2Q2ixIrf8U+PEtY5DKKIMbm2Rooq97PSzwHDiz69sn9cCuDLZqmyAyMb0nuCvbPZGuKzz1MuedaHwqNMuZvQ9scPM+ShLvty7ciTmNDmO4QZtbaEm4P2KChcTe+c+ie318dWlqsRoB9+Kqd+nCSSGO1yUtOLE641urXVUsWnaXrp2chE7ItpnX39wrOxEjE9UgjiqqItR+I8fn8E0rU0hNmQDSFKophoxnogg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SJ0PR11MB7155.namprd11.prod.outlook.com (2603:10b6:a03:48d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 01:11:54 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 01:11:54 +0000
Message-ID: <381e4ccd-47ee-955b-f7af-fe192bea0cd4@intel.com>
Date:   Tue, 19 Sep 2023 09:11:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [syzbot] [mm?] BUG: Bad page map (7)
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>
CC:     syzbot <syzbot+55cc72f8cc3a549119df@syzkaller.appspotmail.com>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <syzkaller-bugs@googlegroups.com>,
        Yin Fengwei <fengwei.yin@intel.com>
References: <000000000000d099fa0604f03351@google.com>
 <0465d13d-83b6-163d-438d-065d03e9ba76@intel.com>
 <ZP8VcUIXTjvR3z54@casper.infradead.org>
 <f3379aeb-f394-8c99-5143-f93e82400320@intel.com>
 <ZP9D0q5MSVFobNbZ@casper.infradead.org>
 <fb936bdb-6473-a956-8431-fe95f5940acc@intel.com>
 <ZP9mla26MWqKKUZ7@casper.infradead.org>
 <092a9bb2-727e-5849-fa4f-18535b998efc@intel.com>
 <ZP/wLVg1JCvhaEKm@casper.infradead.org>
 <97e59c09-30c8-038a-a6f9-3d862a0d3ede@intel.com>
Content-Language: en-US
In-Reply-To: <97e59c09-30c8-038a-a6f9-3d862a0d3ede@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:4:188::7) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SJ0PR11MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f0b53a-bcf7-494b-c8c1-08dbb8ad69ad
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JL6QAIRvhT6blcHYdMga0ifPZMOPeVGFq70ULkfpnVJ+hB+h3d3g4LkiVohAPxNwCxiCbe3URFx9EUqMWS+uIZriQTDb5dE8uhQ87yp/jgvxa7ZbazkIxzEZ9TpUdDQeLpUaxG5uVg6OoYA907ICYgQQ21F3oDvV0vgXPSRLYFGGUAHc3ZBEhTiWpQuwA19VQj1/r+0tWIAbDAaTMkLPkQOfABu8zqZ9Le8yt0dfr+2oPF0Q53PEd3hODx3pBqRoSUyHfoxZCcIZ6Thn8scffnnaqIIanYk69PeDwC3yLruXnA8SCRsi9eJREMXUT+919s358xt0lOVjK3BhJPJfCV775GUfa8AiKq6k455Gw92w9UYdeL/jLGN4Z4+JV/YHVb47/jmFuyLEuM97iXAtqW13sODtZWPPgiEcYJzkcz9PGgXq3MFDpcOINGrvWLM3x0PQqeLgIEbxzny8KV0KgB5pXcgtBF4LIH4X5UW8fAfwPJCSU6bbEM5GBwuAV4dsSnkgbfBW6EyMo8QUK6yRUiMXTD/aRXAeUBnXERMA+oWIdn/YnqADJGmixgwD+zRIVTcEZndZWbP/l3abQLGwGioftDeZ0fkJtfz0uziaL7hp94Jv0sc4jg419SJWXCS9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199024)(1800799009)(186009)(82960400001)(36756003)(86362001)(31696002)(38100700002)(31686004)(53546011)(478600001)(66476007)(66556008)(5660300002)(66946007)(8936002)(6666004)(2906002)(54906003)(8676002)(4326008)(966005)(6486002)(6512007)(83380400001)(6506007)(110136005)(41300700001)(6636002)(316002)(26005)(107886003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3B5cGFaeld0R1dINkdYb1J2c1l6TElUVEhCd2xxM3QxRHVGWEtMVmxHa1pR?=
 =?utf-8?B?S1UyRDhKWW9HdWtaLzRwd0ZaeTRxeE9PcHRKWFJIYVF5UVpzTkRJNHBRTHhl?=
 =?utf-8?B?UG5TOG41dHp1ck1haDBLdzdTM2ZvcldULy9EdXh2SmlFMDNlUGlxSjUrQzZm?=
 =?utf-8?B?UU9SanYvcW5rNUFZbk95T2hOaGtSZ3JsYUM3eTAxWTNlY1Foa1FNbHJMNmd0?=
 =?utf-8?B?TnFLVXNrRGFqaHpKMW85OWlnaWJtMTB0c3VUY0xON3FUdHFub2RQcEdiYnFo?=
 =?utf-8?B?dTROWFhicElYaGJkbENTdEQxQkk5cVMycEpCcGhYalhIU04yckRGL01aUmhl?=
 =?utf-8?B?blNGN29rSERPbkgzRk1ObG92d3lmYmVRK3llNE9ad0FRN1I0RlFCeWVrT1lQ?=
 =?utf-8?B?Tnc2NUdTVGlOc1dxTmdpdVFJSWMwWWJtdTRFVmpFNlRaSGJuRUdlRnpVelZC?=
 =?utf-8?B?SS94OThVekJFeVNZU1ZSRTNLZFprZUl2VXFEVXJiUHpsV1J2NFR5K1JpVWFX?=
 =?utf-8?B?TU9mSXdlQ2swQWcrTllqaEVWd0hSQldHUG9GTGZCTlVKZGJuZEF4SnVQdHRj?=
 =?utf-8?B?bWV3RFhZWW52Wjc2d0NydW9SR3NYU2lvZHRJeFlKeDh3YTdyL29TbHc3SndK?=
 =?utf-8?B?b1ZYTURzb3pwOEQ0Tm5vZ1dzdFdMVUJpbHJGNjE1MEJWWXR1U3ducE9rK2pQ?=
 =?utf-8?B?V2diSEVUVm1SZ3RHcGVhS1gyZXUzYlZjc1RBN3VIT0JnejJJZ0crMUUzVkI5?=
 =?utf-8?B?MUQ0RFRLWnhTNGZUZHJzcVd4OFRnbGtiZDBVVFpENGF3UDVraUVKWW8yZ0p4?=
 =?utf-8?B?Wlc0UEJXR0dGb1ZLYTZONmpZNmhuWWZ1NXVBMW5EenJyWWpydm8velBWY3E1?=
 =?utf-8?B?TVRIYTlCWitSN1JFWUNiRnBTY3RBUlMva2pJZEdjRlh3VFphOE41TkFPcFB1?=
 =?utf-8?B?L0NyTlg4YmdNTSttc0lOK3NzR1lzYzZ2YnpnbldnSmtWalVSTVJXMEVqK3hm?=
 =?utf-8?B?cWdmRkpsZEVHQnVISDYxWXkvWHdRYzYyMnU5TlJFY1l2c1U2QmpxUDJSSDg0?=
 =?utf-8?B?OG53YjRiVEFqRUxvNis1NVZzWGkyRUpIeGE2VXNrMHVJcHBHVmpUVzBwNTJ6?=
 =?utf-8?B?ZmhUSC9hRG9kNGVPTU55UXFNaE5PUUQwQkovaXBQNnIzSnp5dFV3OXUvU1ZH?=
 =?utf-8?B?TXZNRTFsbVBTT0IxRlY2TkY0TU45K1JIOWoyYnpsNG9rQWhQUys1QS9kWU1I?=
 =?utf-8?B?bVNiY1FMSXJOSlpQcVNHRlRkZVJZSy9tL29qRzZlLzc1UHhLejRmNzF0RVRy?=
 =?utf-8?B?Rk5GbEtYNTQ1b3ZkVitVTnJWUzQ5aFRLRHFtbW5SNFdTdzdVVndMLzB6R3hp?=
 =?utf-8?B?dkxkdExlTldUelJBSWozR0thTzVKOUN0VHYwMEpZaFE5Z1ZZanB3TEVDdm1C?=
 =?utf-8?B?SUk1U2FaQVJmTFN3VGY2bzUvYVZaRExvTW0vVXZ3K1ZJbXF3KzdoNnBkUm1u?=
 =?utf-8?B?SXhuZlUrQmRSMFlwcFkwVU9zRXJrM2FRcWNFUjJNMEQxVDV5aE1uZHRBSzZx?=
 =?utf-8?B?cVZ0TkoyM1hTR2RnVFdkR2xxMW1EVERqQmZhS1NhWWNDSjQ4dFlTcXFWcWxC?=
 =?utf-8?B?Wk54RE5tQ0svcVBwN3NOREtQUHBVZlQvQ3R4NHpHSk9vdXRJMmV6clFjK2lX?=
 =?utf-8?B?R2w3Q09UcVBVMU15RUxQU01DaFNLVmp5VDRNVzF5bjBxRXlkSGRYaDkxNTRv?=
 =?utf-8?B?M3ZNOE9uVzZqa2ovTGVvTUlsRTNQNFQwalFEWGd6L1YwT2pybS8rdlV5WHo5?=
 =?utf-8?B?WE52UklWU2NqanV0MlJMeEYyU04yT3lvMFVHNC9CczRGWGxVU0kvOXEwOG9v?=
 =?utf-8?B?MnpTaWpqd2IrWEorU2h2aUI2US9IeWkvMDV5OExDN1kzck42eVpHTUJHQ2lm?=
 =?utf-8?B?QUlHb3JYMUk5TmpmM1E4cm5NM3hnMXZTUUY1TUJzSUp5L3lZc3hvMlNEMFBO?=
 =?utf-8?B?Y0xtL3JkZEdiR1NCVHFpRHRIdlN5SGIyS0RNcFp5dEFHa0Q0eGJrRExOSHo3?=
 =?utf-8?B?dHhQTjA0cFk1aXF2d0s5NVp6SUFzVEd5eDVwcmkrYW4zUklob3g4WnhmdjVt?=
 =?utf-8?Q?1wpY6IUqbYfxsk/nIe9VcnUxJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f0b53a-bcf7-494b-c8c1-08dbb8ad69ad
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 01:11:54.8365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZksiiWN3K21tTkwX91DoN2cW8NSMFoyN+mX21QE2mFjNVbNEwx6lCVOlPYZrA/F4XoP3wAbl23r1EDrgeP26Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7155
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

Hi Matthew,

On 9/14/23 15:33, Yin Fengwei wrote:
> Hi Matthew,
> 
> On 9/12/23 12:59, Matthew Wilcox wrote:
>> On Mon, Sep 11, 2023 at 01:22:51PM -0700, Dave Hansen wrote:
>>> On 9/11/23 12:12, Matthew Wilcox wrote:
>>>> On Mon, Sep 11, 2023 at 09:55:37AM -0700, Dave Hansen wrote:
>>>>> On 9/11/23 09:44, Matthew Wilcox wrote:
>>>>>> After fixing your two typos, this assembles to 176 bytes more code than
>>>>>> my version.  Not sure that's great.
>>>>> Maybe I'm a fool, but 176 bytes of text bloat isn't scaring me off too
>>>>> much.  I'd much rather have that than another window into x86 goofiness
>>>>> to maintain.
>>>>>
>>>>> Does that 176 bytes translate into meaningful performance, or is it just
>>>>> a bunch of register bit twiddling that the CPU will sail through?
>>>> I'm ... not sure how to tell.  It's 1120 bytes vs 944 bytes and crawling
>>>> through that much x86 assembly isn't my idea of a great time.  I can
>>>> send you objdump -dr for all three options if you like?  Maybe there's
>>>> a quick way to compare them that I've never known about.
>>>
>>> Working patches would be great if you're got 'em handy, plus your
>>> .config and generally what compiler you're on.
>>
>> gcc (Debian 13.2.0-2) 13.2.0
>>
>> I don't think there's anything particularly strange about my .config
>>
>> If you compile this patch as-is, you'll get your preferred code.
>> Remove the #define DH and you get mine.
>>
>> I would say that 176 bytes is 3 cachelines of I$, which isn't free,
>> even if all the insns in it can be executed while the CPU is waiting
>> for cache misses.  This ought to be a pretty tight loop anyway; we're
>> just filling in adjacent PTEs.  There may not be many spare cycles
>> for "free" uops to execute.
>>
>> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
>> index d6ad98ca1288..c9781b8b14af 100644
>> --- a/arch/x86/include/asm/pgtable.h
>> +++ b/arch/x86/include/asm/pgtable.h
>> @@ -955,6 +955,14 @@ static inline int pte_same(pte_t a, pte_t b)
>>  	return a.pte == b.pte;
>>  }
>>  
>> +static inline pte_t pte_next(pte_t pte)
>> +{
>> +	if (__pte_needs_invert(pte_val(pte)))
>> +		return __pte(pte_val(pte) - (1UL << PFN_PTE_SHIFT));
>> +	return __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
>> +}
>> +#define pte_next	pte_next
>> +
>>  static inline int pte_present(pte_t a)
>>  {
>>  	return pte_flags(a) & (_PAGE_PRESENT | _PAGE_PROTNONE);
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index 1fba072b3dac..25333cf3c865 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -205,6 +205,10 @@ static inline int pmd_young(pmd_t pmd)
>>  #define arch_flush_lazy_mmu_mode()	do {} while (0)
>>  #endif
>>  
>> +#ifndef pte_next
>> +#define pte_next(pte)	((pte) + (1UL << PFN_PTE_SHIFT))
>> +#endif
>> +
>>  #ifndef set_ptes
>>  /**
>>   * set_ptes - Map consecutive pages to a contiguous range of addresses.
>> @@ -223,6 +227,11 @@ static inline int pmd_young(pmd_t pmd)
>>  static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>>  		pte_t *ptep, pte_t pte, unsigned int nr)
>>  {
>> +#define DH
>> +#ifdef DH
>> +	pgprot_t prot = pte_pgprot(pte);
>> +	unsigned long pfn = pte_pfn(pte);
>> +#endif
>>  	page_table_check_ptes_set(mm, ptep, pte, nr);
>>  
>>  	arch_enter_lazy_mmu_mode();
>> @@ -231,7 +240,12 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>>  		if (--nr == 0)
>>  			break;
>>  		ptep++;
>> -		pte = __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
>> +#ifdef DH
>> +		pfn++;
>> +		pte = pfn_pte(pfn, prot);
>> +#else
>> +		pte = pte_next(pte);
>> +#endif
>>  	}
>>  	arch_leave_lazy_mmu_mode();
>>  }
> 
> I checked the commit message of 6b28baca9b1f0d4a42b865da7a05b1c81424bd5c:
>     The invert is done by pte/pmd_modify and pfn/pmd/pud_pte for PROTNONE and
>     pte/pmd/pud_pfn undo it.
>     
>     This assume that no code path touches the PFN part of a PTE directly
>     without using these primitives.
> 
> So maybe we should always use these APIs even we make x86 specific set_ptes()?
> 
> I will find a test machine to measure the performance difference of these two
> versions by using xfs + will-it-scale. Will keep you guys updated.
I'd like to move this bug fixing forward. Based on the test result here:
https://lore.kernel.org/linux-mm/124631ab-eb4c-6584-12d4-f3c91e69c873@intel.com/
There is very small performance delta between your version and Dave's.

What do you think if we propose to merge Dave's version? Or do I need collect
more data? Thanks.


Regards
Yin, Fengwei

> 
> 
> Regards
> Yin, Fengwei
