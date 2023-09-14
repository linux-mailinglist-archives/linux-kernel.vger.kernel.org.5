Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F33E79FE8B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbjINIiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbjINIiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:38:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8111BFC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694680685; x=1726216685;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sLq5OIMyHjWcck8D4JBHl9GeGPTs1GR8xWpB/4SUhno=;
  b=QwyvIFpz/l5X+D7ZmXZGlydUYtwX5mkDlt9fnHHyxecohzS8gn8EcNg6
   2JsXTeNGygXmPFwQfFSxFnB6AZ6Ub9mO36RcGeOb483z9SGuJXzUo7E4j
   RYCuXN2D8pRegIQektbyOhLn2XW9UXv8HdSKhwylnh29ibfCxh1HatLV6
   2100RO2a+gylBPbkuAem4DYrLKDjXBrDCDgNbTu/vYpmrQtuGxuTcB/k+
   JAfqZjSmzUEIxb5CdJdDMDeT5QEVJIRfmc0OTbBh2GVKnZsRkNx7RR9Qz
   R9fhKI3GEK+NKrWhIp2324rDxloIp2DFGA1AE80q03EXgtK3m88+1iYOT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="465260859"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="465260859"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 01:38:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="809976049"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="809976049"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 01:38:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 01:38:03 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 01:38:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 01:38:03 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 01:38:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lW9I2OAQgJK6QJ671vJU5CT9wA6uM9DZGPi8FrzMJ5DpnEwbjJYaveXc9VlPW32Y0YFXTUyhclwia9SAomkHZl4fP/OB7SHqo/bTAhdOrmRr11AY8FZkr2ePbFx3cZOPiPoJ3sdSLlWALm700w93tJl6NMjrKIk2MnrDCVrOMp5C1C794HMeIVVpeLyv+ywPjCsXngSF/g7+0FQVw9TUv2kwf0UEdjoPmmwyfMK9ZSaQ7n/z+qlzrPJ4LmqcvVJ6IQR0VzVn/Dtq1rg9g7DHas5dJTaqvh0ZNIBom1eLJOOFOpI1I4B/C2QtMqAzd/qiJhKGzGl+CgzHwzpyNtzpdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UltMoiuNeQgcUyiMIj+R+a6qUSWCq+K5uCkjq59ukTY=;
 b=Lfk4C2YVePTLr8lF8REWmnKBgEMz3hPKWag4s6P6sAbE5sbzWNEEsBrh1LDp2yiz882hj2G5Ohj3lUU7ELlDARwjSfIRbKjEFPZ1lnuV9E86QAFJ9LMepGzXoz+ggQtey4xKjE7JHv2SeghwTWqSo+Ehx1vMXuy5ezOYit2yOYvjnMCaur3e8pJFKZcitJ4FmVT93Qf1MWUmEyCf2P1XS0RRdiobtmorBLk+jcruBU0R0wrh1BVOTqcx0jeaGmI5KZaT+e1vUzilTU1X5i/2uG4Bni7YHJuIjviWDSkHjUBZEzir3qIHdOzZGNTnnarQA/oSpBZq5HTRkzS7ULJa7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CH0PR11MB5475.namprd11.prod.outlook.com (2603:10b6:610:d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 08:38:01 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6%4]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 08:38:01 +0000
Message-ID: <124631ab-eb4c-6584-12d4-f3c91e69c873@intel.com>
Date:   Thu, 14 Sep 2023 16:37:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [syzbot] [mm?] BUG: Bad page map (7)
Content-Language: en-US
From:   Yin Fengwei <fengwei.yin@intel.com>
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
 <97e59c09-30c8-038a-a6f9-3d862a0d3ede@intel.com>
In-Reply-To: <97e59c09-30c8-038a-a6f9-3d862a0d3ede@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:54::23) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CH0PR11MB5475:EE_
X-MS-Office365-Filtering-Correlation-Id: fdaa8a3d-f0f1-4689-0f12-08dbb4fde7c4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1zPNT9rucilnogCjkGZSRD1YBiFL9rnkD1z5fUzXI1n9XZHo3aeUe6jV2KJqqE6WcqFebJkLS/AlG1ChzwI5CM13l5YfYY9OESl03hP6nVhX7Fcmfon//gwBKatooJndrdg4Tnbt/Cq974O4V4i7yUF5PMLhuCWlCEHvEjE+cuiyY0cKRhweJUt220OMBQLbS4z5WnjQjcwsJhwd9swVvQL9SqK7O0rsXrurPsVcEs5gdDttIetrt88HhRLWXzIV9It8y5tCQ8sTeexl9Gc4YMl4PZ/i+YWsh4fNwjd3EQ7KFoNrDY4ofm0+SxjgIUECIJ5tThCsrh0+33FTySTkrTWqOcsPvNT027Xn6kcThkcTsc3Uqa2jrL0nvwtvhmaxXc0NJ1wsHfwoG6XDQ0lwgW6PIehQc7r8jXlvDddn4ErUNwuCRtIZRNxKXO8pbpyWmpd0RsY9kjPt/3McAXeyf+HYGrbgOKc9Q4LRUVWUmczACNqnIHtZ0dZFesYJqpIQGOhYDks40HXA0P1oPSZIAXN7jPPDot/c/ijh1s96dpc20IL4ptDFpKVUdGIXoyfoNijjmIcT5/nd2/bAGQnE/wr9ieZPwCHxF7v6FBvvk2YJLDfhwrq41e3R7Zve87NLPJBrXYKawpMiwp8CA+HKkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199024)(186009)(1800799009)(26005)(2616005)(478600001)(6666004)(6512007)(6506007)(53546011)(6486002)(82960400001)(2906002)(31696002)(5660300002)(8676002)(4326008)(36756003)(8936002)(41300700001)(86362001)(66556008)(66946007)(66476007)(110136005)(31686004)(316002)(6636002)(83380400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sng0QXQ5bGxUNXVEY3o3aEh3MUl0NzFSK2F0WGRjNzlBNC8xTmxRWmkvK0Yz?=
 =?utf-8?B?dWpCbXVVTVZNUERzeWFHcnN6QzgxTXpld1JVWlR6QktPVGNkN0V6YnRiVHNk?=
 =?utf-8?B?SVdTT3FjQlpWbTVtUGlrTlZEc2ZoN2cxbi8vSWtsOXFSK2huSTluaVBwSVhn?=
 =?utf-8?B?UXNsSGNFV1hpSFFqaHNxZlhiWVNGSDhPZFZhN3RGZUJadnFIdS9zK1lENzhy?=
 =?utf-8?B?bDl6NldVdWlpUVpva3RraFVHWnMxZXA5QzBHT2JMWEc3UGh4T1Nud0JEcnRi?=
 =?utf-8?B?TGFZVDZOTGZJNzFUNUpnU1h2Tk0wcXNUUHlIRURDemNjekJsZW5hM0VvVGsv?=
 =?utf-8?B?Nkx2RUptVG40SUtEUytQdFFma2pWMzRXMk5BNDg4cUNtVDNaYWlWdVdjV0Y0?=
 =?utf-8?B?QWtweUUzSzFVOEk3WGVjNGwvM1FKTjRXZytMV2hHYUJSWjh3MEV5dm1jbms1?=
 =?utf-8?B?SmFiN3RDZ2I0WXNtRUhDa3lSZHFkdlV2OHhqRVFJN1VpZUpRQlpzcHdGOWdh?=
 =?utf-8?B?eG5FTTl3QzltVDN0cVRBcndpbzZlMGJKSlZzb2hXTXFkY2M3VVIyMCtrWm5o?=
 =?utf-8?B?czJ3RHdidCtOWTZOOFhXMWVoYXRkZWQxT0Y3WXhoOXJHV0V4aEM4NUdFeEdT?=
 =?utf-8?B?MVRRaEdxMGtpcmhRaUdacTE2cmNvZVRvQm4ycmN1eFZNdnQ0QnQvVVRjU0xq?=
 =?utf-8?B?aWlLVTNBL2tYKytxTlN2QnQ0TTQyVFlrVllUbUJ5RVJQRnNGd3VHVGJ3V3Jh?=
 =?utf-8?B?S0crVFRCam9IUUpORDdyVXFFdUtDdG9GRFFuTUtKd1hNNnIvUFlUUWIxOEhn?=
 =?utf-8?B?U3liOXRqWTh6NFduc3FEaXFVaHVtSldLRndzazNXZHhRdk81MUxjVHdNQmVw?=
 =?utf-8?B?d1RkNWlLMXJ5OEhERHhVTTgzeHhJM0MvUXBvSHJHcDBmUkJTTUN2OTNZRkdB?=
 =?utf-8?B?UVZPeGtkdkxCVHd4R2gwVHljYXZOTnovN2FIWFd4emdhYUhDazZQdk54OSs2?=
 =?utf-8?B?eDBRakR1N1RMaDFENWJKVEhhUklOSHE5MTJjYy9tNWQ5OU9YZXEyY3ErL2dV?=
 =?utf-8?B?aEc3UklqMzdCMHQ0Tkc2TlE2cjZ1Wlp5L0F3RGJBZGIxNGVEckVwY05CMDho?=
 =?utf-8?B?Y2lNbFgxNDNrQnFZbFV6V0pPN3RsRjQ3ZG1CWC9rWmZVWHQrNERDSldpN1RL?=
 =?utf-8?B?cnlhOWZKY0EvMVhpQXZCQjlGOVNuRk1MVFp4YXk0NmhHODIwM1NjaUF2WEVI?=
 =?utf-8?B?VWhuWm9zemRUZEYvUUJVYVRvVk94bFp5RGNWU1ZhZjA3NGxadU5lbDhzZy9s?=
 =?utf-8?B?SEl4VWVxdkNBNXdGdFhSRlhYblgrM0tCMVh3Kyt5T1czYjNGSGFlVWdaK1d4?=
 =?utf-8?B?aHpnYjF0MUV4UnlXcFcvM2JhMjhzOUxFWWMvcWNvTEVpQ1p1MzRMc3l2cm95?=
 =?utf-8?B?YmNBR05oRTY3NU0yc1lnQlorS0VJQTlZQVZsWnNKYmJxUHFCeGdLNGo3MGVJ?=
 =?utf-8?B?Q3NEZ1U1U25zQzdsU2FpRU96NE9HSHNNSURxZW1wN2ZuSTRLQzUrVnVRYkRu?=
 =?utf-8?B?eHNLajJnYWd2UVZkVmJlbGFHZXpWNGQ4b2daaXMzcnlhZ3pnWnhHY2JMN3Vl?=
 =?utf-8?B?MW40M290UzZxTjZIS1pJdUxBNkpONElLM2xmV2lxNEhueDU1RDV2MGczWUdL?=
 =?utf-8?B?MzZyZHRzaHIxcFlPcmhJdnNabTcxU1cwYlVGYlhSM2VOaXVKV05jMjVscHdu?=
 =?utf-8?B?ZXVrYXBoR0VQSmZJSHpWOFk3Z2xrejhhVDB4L0ZXbkptL1dmcE5DWXV0YVY0?=
 =?utf-8?B?Z3dWUWtLZEp5cTVYYnMwaFlwclovOU5MOWk2Y2hBekpaeXVEM0pPWDZFSHpJ?=
 =?utf-8?B?ekluRFF3YWNxRGl6OGVCVjJERVNUVTRvazUvVHhHU1lwcVdUUUt6Qk91YTNa?=
 =?utf-8?B?bEhveDMxVU0xYzVweDlCVldYcTRNNkZqNzE5N1UrVVZKeFRSaXQ5ZXdyRVpn?=
 =?utf-8?B?dWFsbk8rdXZaR3BqclFzbjEzSW56QVRSWFVaM3JDQVZqK3FwaytSMjdybDVt?=
 =?utf-8?B?c050b0wyYlorTDJ3M1VxZzZlZDJFRDNrYkhyY2F1TXZxcUYvWnRjZXhNVVV4?=
 =?utf-8?Q?CzWy1+8cWEpTnchdScz8GSi5R?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fdaa8a3d-f0f1-4689-0f12-08dbb4fde7c4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 08:38:01.1994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLwfP8NfW5mavhM+FNgrVVelpkwk0kh+526oR3+Pj6mTd88xGdXkMYqllKbF9wSrha0uaEiZiKUcG0dPEU08rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5475
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



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
I run the test from here (https://github.com/antonblanchard/will-it-scale/pull/37)
on an IceLake with 48C/96T + 192G RAM.


The host filesystem is ext4 (I can't change it to xfs). So I create a diskimage,
format it as xfs and mount it to test directory.


The test result is like following:
	Matthew's version			Dave's version
run1	379045929				375241566
run2	377870413				373950068
run3	378623159				371884035
run4	376890127				372391340
avg	378107407				373366752.3			-1.23%
stddev	0.20%					0.40%

run1,2,3,4 uses: page_fault4_processes -s 2 -t 96


run5	9696280					9599164
run6	9683840					9579984
run7	9684832					9595912
run8	9697936					9617408
avg	9690722					9598117				-0.96%
stddev	0%					0%

run5,6,7,8 uses: page_fault4_processes -s 2 -t 1


Conclusion: Dave's version is a little slower than Matthew's version. But the difference
is very small from what I can tell. Let me know if you have any question. Thanks.


Regards
Yin, Fengwei

> 
> 
> Regards
> Yin, Fengwei
