Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED1F79FD4D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbjINHel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbjINHeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:34:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D664F3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 00:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694676873; x=1726212873;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=skTBDR10WOAEW+5JVzdomL9jtBYcDR9pBMBs7kzBmzw=;
  b=eJ+6t5kUNVZsalShDSC3BCnMVwmWs9itQdn5xJyU40IBbXHjbEHQ77mn
   JQYZ91fm1AjvyyI/ZN6KRe/zWa0EyhAdF/hUJQjqyBiZAbLIKL2LR/3ZZ
   8suOj8GHBV+1hORCHD6eR7CKJQaGMCjCpwNccHk1+imEoxLrOZAWE38Zz
   bLRheH0fugLm3Qf/RKG15qIS2DYXxfpvKLCBuCEaMTmvsp2tmRzAtSrRG
   bE0+Q+S7hMHT2Yu16hJLmE+D3LL75Fd/4smhvj3irPp5aBT6YJyz9xGxX
   EObBrxTRRs5nsrMAAaTf/zhWXpLhgGjyFUXY19scBWgQ4qzTCg2JhqetJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="381566943"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="381566943"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 00:34:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="868146031"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="868146031"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 00:33:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 00:33:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 00:33:51 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 00:33:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCmyWg6dp48uOeiKHuRPcC5eh4wOGKH46uhDr0JzpG92bHD8nhOHi8z86QZLMu4LNF3V5g7JtosMsJ4DbCrAJgCytNOYEEOG71kz8pMDve5eaq6U8S8gIW6Ic0ZVL/r9hIVbnRtAdXOvceg9z2TIodxnIbpSMMI+LcJY3oN7JvgK7HrUZhplQeVz0py2SUlxQaaBiYsUxyK9dmcuUXsWjkqvYw2Mx6ccn7HzLUOXoTQRP5tI5xfM4KJAc9D7E4TQ/t+6kNu0FytSx23yucOu2RCkxr18wTtAlaHspl3t/fDLlUWqqms96dY7oaGoLYjrBcvqVKYGSe5J6RITybWf4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0/Bi1QNd/paQDhXSCIK04wayjtBo74/X/oXT0hIo4k=;
 b=LXwmH6zJb8xUNPm/fYycFk58CpuM/WKPT6CwQcy0DbcnN+X7PalieMQ6q1PtPtgsTo0A1n6txasZf9y50YflXWIfTu69Ypi7CJWHkrKfIuup1rW2FGNHRcYI5vXwrDxPcFtYx80ih+6uDlkoXKtsB37ksKtX+KgHkjwrfi2JZojspSkocKHx46Mdsz5MlTZ+irDR0xsCOu3QwxsW7NMS2GujPu1BzIE6vH3R+KBs7vr8SMuXPwg8qD3Py7YifXQhgzvykhWyxNzK8Oia+L7jStkaxeUtqsMnYgsyhLptFfkb4PvmvFc0+q1nliw3Wh8jUoBbJFPF2qx+nrSt4vc8SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS0PR11MB7970.namprd11.prod.outlook.com (2603:10b6:8:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Thu, 14 Sep
 2023 07:33:48 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6%4]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 07:33:48 +0000
Message-ID: <97e59c09-30c8-038a-a6f9-3d862a0d3ede@intel.com>
Date:   Thu, 14 Sep 2023 15:33:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [syzbot] [mm?] BUG: Bad page map (7)
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>
CC:     syzbot <syzbot+55cc72f8cc3a549119df@syzkaller.appspotmail.com>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <syzkaller-bugs@googlegroups.com>
References: <000000000000d099fa0604f03351@google.com>
 <0465d13d-83b6-163d-438d-065d03e9ba76@intel.com>
 <ZP8VcUIXTjvR3z54@casper.infradead.org>
 <f3379aeb-f394-8c99-5143-f93e82400320@intel.com>
 <ZP9D0q5MSVFobNbZ@casper.infradead.org>
 <fb936bdb-6473-a956-8431-fe95f5940acc@intel.com>
 <ZP9mla26MWqKKUZ7@casper.infradead.org>
 <092a9bb2-727e-5849-fa4f-18535b998efc@intel.com>
 <ZP/wLVg1JCvhaEKm@casper.infradead.org>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <ZP/wLVg1JCvhaEKm@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS0PR11MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: c589260f-b7a8-4389-7011-08dbb4f4ef59
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1n3tMh00NOE5XO6SEQDJ4iUlLEORwQaF6PuLcFf63mzfxh4J2Dorv80SVi82BXD/JgM8fbP8mPxixKEgtuiPj9/YQ0V235N8w/L4mWOadyhEgemGvd7avt+zgtEKAu2GxcuudTuEk8zww1XGW3El7tOIvo6J5wjZoTtL9GY/sDAEVEX3lO5e0uKs5Hizk7lRAO6ZPu2ZWjFqWH5bZtN9CIT0eBSOODIR+L2ZfBd5i5xUSOP6f4IR5vIQsr+4OsTivet9z3auOSFFzThuIfcVGb3NtvPb/tJml5owEm3LoMfMLLVSTwV7qA8BqkTEM0B6VbkL21I2j258qzgrvXJaHKBeyp+iTIQG0yAHk4TGQlKSMwXt8MyuxqiNVAz8/8fEhB5KuqumPWEGpNnwJt2MhUrLBoq/U+kKP0qx2rEv+jC/CU8in3S8jl2d5gKyU5hiOldM5ghY7SyZLFepEOCkhVTR4Nb5w1Uvd6tzWmwo8Vz58+YYd2arKTaVQbcLntqWzJ9lvyYmZkyMtSoGHaaH9+2EzyiV7anBy1c+RN71jxgteNKZ+kMP7XJdb/m4oMp9DsnXqtS79oZyCR5zcByzaDGKjlplh0z4p0cJjXBsK+uoG4ylfYy10lSpRDs/TZzPznsmGSdi9uQLKp8yEoZj7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199024)(186009)(1800799009)(41300700001)(66476007)(110136005)(66946007)(66556008)(6636002)(31696002)(316002)(82960400001)(478600001)(38100700002)(2906002)(36756003)(86362001)(4326008)(5660300002)(8676002)(8936002)(26005)(2616005)(31686004)(83380400001)(6486002)(53546011)(6506007)(6666004)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlUycjEwODh3RklocHZIT2x6bUpPVk5YQ0VaakRDZVB0eUZucDFtL2dIWlZM?=
 =?utf-8?B?Q1VaRXorSk9ScWd2YjduWGRsdm9lSWpWSnQ1T1R6V1dYeSsycnVMT3dJUXdk?=
 =?utf-8?B?ckovWkhOYTB2RVFzRW1UQVdxODdLRVQ4TGJHcDlQTTV3bnREbHhoWWFkSm1W?=
 =?utf-8?B?L0thcHE4VklWZmNVNTdvUUlxenhQbUl2N092aFh4UEdYTnJhM1ZGTm1OUkk5?=
 =?utf-8?B?Q014V3BTVFBCOUlCTUwwSWw0b0pndXZ6UCs2clZWbW8vbDZGQlZqK3hXOHJZ?=
 =?utf-8?B?cEY3UHRpNmFVQ0xnczh1QSsxaEVlZnU5ME1USmJ2ZDcwdytWeUNZTC96eDM1?=
 =?utf-8?B?cTZUN1dIR2tWelFJYTJPT0YvZE02RnZjd0NobmV2Zlo3ZTl3eUxEWXRGdkRP?=
 =?utf-8?B?YWdxc0pvb0l5S2l4aHd0SGpMbjkrRUd1T1BSMFd5bUdkOGNER3h4eGJOaUR0?=
 =?utf-8?B?eGZOMFZGZnVOY1N4R1NEalhyWFpNbmZpNVpJWXUrZWw0K1R4NnVRbndsYjlH?=
 =?utf-8?B?UFdwS3hReFdsZmVNbjM5MXI2a0RncUdFa0I5NDM1NVBSS0pEMlZoeHUxNTBM?=
 =?utf-8?B?emtPSUpuK3V5ZzhERHBrTE50WitqVmNHL1Z5Qno1cmcyTWFZcEk5WjR0V3F0?=
 =?utf-8?B?WVVtdFFNUEdzUVpoNGhaR3puY3VyL2h2NUtnZ2NodEpEc2ZMRlRZczAvUjl2?=
 =?utf-8?B?UHRMTFVkWWk5b0pVZDBQNjFxYU1Fam9paDIvdUlZREVpeXB5bmJ4bTUyWUVm?=
 =?utf-8?B?OTB0MmtQd3FuNjZKOGlJN2s3WGg4UFVCd09HMEUyL1NvUjJzM0NLSDExcXJT?=
 =?utf-8?B?Ujk1bk1LQ0ZVcldEOXU4dDdtaS9vblZDQ2dBRmdtckNZK1EyYkFsQnpzL0I1?=
 =?utf-8?B?WnFMZzI1MkZOSVVtV2pkTTdKYmFVWlNDNHlzc0dFV1RITzVVakRXMHRaQUla?=
 =?utf-8?B?aHVVNTBXMWhpWklHQkxJTTFnVkhvdHVLa1lPWmQrS0dTeU1NSitOMG1xTFhP?=
 =?utf-8?B?U3prSHJJL3Y2aW1KYUlNVEgvd3hESFVrZExzZXJuN0pDME5WcytRUkVpNUds?=
 =?utf-8?B?ZW9QQmNRa3grbk5GWTBhQ0Y2cGwzQ1c0TmUySHdQWDYxcGtmMWNDaFV5ODg4?=
 =?utf-8?B?NEkwQVVUWkpURDZWcTRzT2x2aFRCNGNQRUNiVldBejl6My9aRUJjU2F1elhW?=
 =?utf-8?B?aitOSVQ4Z29XLzUvUThpUzZVdEFtTk5sTGNWZFVvdUh4dDRtTDBVUStPZFhW?=
 =?utf-8?B?N0V4S0E4Wk1neUFxdDNKYzBnWnZsMmlHSUhMRTNsUjZvcGx6UnNjL0VYaXBQ?=
 =?utf-8?B?a2xSbFNBSStHY29kb3poYTc0YUdscUhMUDZuN2hQNXlrbGpuMzg1UFNZMzV4?=
 =?utf-8?B?ajhZTldLUWpKalNXV1FpOU1hbDF0RFZhSVlGVm5UUW13ams1YXdTM3ZvcmY0?=
 =?utf-8?B?cUtxZzNUS2VUek5rOU5UenFQUG1kbUYxYTMremxSMi9MdlFEQ0Faa1FtOHBq?=
 =?utf-8?B?ZzNVOHltNXpwc2tlakQrcFZOZUZHV2VlaFU3ZDlyVEllU2hVZEg3Y3JTTHhM?=
 =?utf-8?B?Mkc4cVhPZlE2NTloUi96UW85c0NCVmV6RWJCZlpyVmdpWmlqbk9PS2xpSDV4?=
 =?utf-8?B?ZnJRcThEZkpIcWZCUS9yNkRlQmJXYS8ySEcweTFmYmYzTGwxZWRkN1g4bXRK?=
 =?utf-8?B?R3EyOURtdWliRjFqcVpZVWxXZzV1QlRJd0F3eG5NRzcxL0RDZ2R3ZWRIK2Jv?=
 =?utf-8?B?M3cxd2NHY3dERnFWOFUxNHJHa2doYUNmWndaK0NrR2VIUi9vUkxBREdMcGdW?=
 =?utf-8?B?RU1GZ2NVcERkN3F5a1hDZTU2SE9HR3BzUnVmeGVxVTdsd2ZBVE5WOGNRZ1pQ?=
 =?utf-8?B?YTFkNzhTcFNrcTVkYm0vWVlBeEpnbmRJN00ybWJtWFBLYXRUTmlFQXEzTVlV?=
 =?utf-8?B?T1g5eDMzSGpOVENSeUhrb2tGNmJSemNRV051UVdHcWNiMUpwMmpNZVR6RUVQ?=
 =?utf-8?B?R2Y2NFhwdzVGcFpST3J2aUo2VTNXUHd4djBmTUdaaENEdnhacG1FVUZ5VGFK?=
 =?utf-8?B?aXNFODRUWkwyUXViNG9JbFpYeWtPd3lFS2RBS0JKMFZZcnVNaitiVzQxL0lI?=
 =?utf-8?Q?HDTrpovM7V+spzk2UsVWUT1Kw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c589260f-b7a8-4389-7011-08dbb4f4ef59
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 07:33:48.5573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLPuQvK/iRrWcJ5Z6uIgN0EIkOCcbgosGPIOgb+LiUBkMS6TRubh9kajp5x9lHVECuA59ldcEi45snwVy/7CAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7970
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On 9/12/23 12:59, Matthew Wilcox wrote:
> On Mon, Sep 11, 2023 at 01:22:51PM -0700, Dave Hansen wrote:
>> On 9/11/23 12:12, Matthew Wilcox wrote:
>>> On Mon, Sep 11, 2023 at 09:55:37AM -0700, Dave Hansen wrote:
>>>> On 9/11/23 09:44, Matthew Wilcox wrote:
>>>>> After fixing your two typos, this assembles to 176 bytes more code than
>>>>> my version.  Not sure that's great.
>>>> Maybe I'm a fool, but 176 bytes of text bloat isn't scaring me off too
>>>> much.  I'd much rather have that than another window into x86 goofiness
>>>> to maintain.
>>>>
>>>> Does that 176 bytes translate into meaningful performance, or is it just
>>>> a bunch of register bit twiddling that the CPU will sail through?
>>> I'm ... not sure how to tell.  It's 1120 bytes vs 944 bytes and crawling
>>> through that much x86 assembly isn't my idea of a great time.  I can
>>> send you objdump -dr for all three options if you like?  Maybe there's
>>> a quick way to compare them that I've never known about.
>>
>> Working patches would be great if you're got 'em handy, plus your
>> .config and generally what compiler you're on.
> 
> gcc (Debian 13.2.0-2) 13.2.0
> 
> I don't think there's anything particularly strange about my .config
> 
> If you compile this patch as-is, you'll get your preferred code.
> Remove the #define DH and you get mine.
> 
> I would say that 176 bytes is 3 cachelines of I$, which isn't free,
> even if all the insns in it can be executed while the CPU is waiting
> for cache misses.  This ought to be a pretty tight loop anyway; we're
> just filling in adjacent PTEs.  There may not be many spare cycles
> for "free" uops to execute.
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index d6ad98ca1288..c9781b8b14af 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -955,6 +955,14 @@ static inline int pte_same(pte_t a, pte_t b)
>  	return a.pte == b.pte;
>  }
>  
> +static inline pte_t pte_next(pte_t pte)
> +{
> +	if (__pte_needs_invert(pte_val(pte)))
> +		return __pte(pte_val(pte) - (1UL << PFN_PTE_SHIFT));
> +	return __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
> +}
> +#define pte_next	pte_next
> +
>  static inline int pte_present(pte_t a)
>  {
>  	return pte_flags(a) & (_PAGE_PRESENT | _PAGE_PROTNONE);
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 1fba072b3dac..25333cf3c865 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -205,6 +205,10 @@ static inline int pmd_young(pmd_t pmd)
>  #define arch_flush_lazy_mmu_mode()	do {} while (0)
>  #endif
>  
> +#ifndef pte_next
> +#define pte_next(pte)	((pte) + (1UL << PFN_PTE_SHIFT))
> +#endif
> +
>  #ifndef set_ptes
>  /**
>   * set_ptes - Map consecutive pages to a contiguous range of addresses.
> @@ -223,6 +227,11 @@ static inline int pmd_young(pmd_t pmd)
>  static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>  		pte_t *ptep, pte_t pte, unsigned int nr)
>  {
> +#define DH
> +#ifdef DH
> +	pgprot_t prot = pte_pgprot(pte);
> +	unsigned long pfn = pte_pfn(pte);
> +#endif
>  	page_table_check_ptes_set(mm, ptep, pte, nr);
>  
>  	arch_enter_lazy_mmu_mode();
> @@ -231,7 +240,12 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>  		if (--nr == 0)
>  			break;
>  		ptep++;
> -		pte = __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
> +#ifdef DH
> +		pfn++;
> +		pte = pfn_pte(pfn, prot);
> +#else
> +		pte = pte_next(pte);
> +#endif
>  	}
>  	arch_leave_lazy_mmu_mode();
>  }

I checked the commit message of 6b28baca9b1f0d4a42b865da7a05b1c81424bd5c:
    The invert is done by pte/pmd_modify and pfn/pmd/pud_pte for PROTNONE and
    pte/pmd/pud_pfn undo it.
    
    This assume that no code path touches the PFN part of a PTE directly
    without using these primitives.

So maybe we should always use these APIs even we make x86 specific set_ptes()?

I will find a test machine to measure the performance difference of these two
versions by using xfs + will-it-scale. Will keep you guys updated.


Regards
Yin, Fengwei
