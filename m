Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876CF77E4D7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344075AbjHPPNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344057AbjHPPND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:13:03 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3566198C;
        Wed, 16 Aug 2023 08:13:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSbtW5d119rHuk7zvkgtz9fFMTF52CGHwNcTLb2sLsYJSfWuWo/jCvjL9WK0cMUzTx3f989W8BLeYCZTVXfBDsuk7aWpeQPSWFtvjRGYuqIn4+GBHwbrCgWrKlrjGvd/EmyVDMSL3tGMPEjYzfF4DTcVk00apob3LOXeBDmYwRRaf/vREgllk0Rb3nRzM4eQM3klO76+JdZmmFQ0MUqueGwFBBs5UybKeUDcVo0S63tqq347ad6SKSluDTliYJ87TAMyah0APyrsw9UJ/g/Wi/GIgS9vydtnu3UIyLzO0zUxFo5/p4+s1/Zz5mmUVld9Yrz9OZ8Jhzk8cFF+jpNVNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKR/q7V28CGO7VhJ/3q75c8sQvy0n3AOaBFV0CRWahc=;
 b=hWSXjF1bzwK02a48uBrxX/DtNCFvxv6dAu6e04XQ7CJGZgPPWQkXK5eC6YsvR25OgJvSzd+paSlxegRLhrrv7zJfbHZsJAtMYFz5ZbNawa/SO3Sp/8H+GcwcaoLUU8Cpgwu8NUbBgKC5+WGq8wJwnUMaQhQ6fuYotlcTcyQBftvs3jXFTRtYbCtoFAD5hopU0aSM0CpmY3NgvLhf5njQeFsNn6SCql9VbaJASlH+7xlv7rGtLQR6Yb4QNHD59gYwj6ok7c3fCqrw/WhnN6mpJeWUgrxm7JZSDGCLsXQpAwGIsULvLedVEjyqpH34fWLAi3Doqa1aQQwpRycg+1LiVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKR/q7V28CGO7VhJ/3q75c8sQvy0n3AOaBFV0CRWahc=;
 b=hPSuXVPtjJM4aGgWgwPKENGX7b2lL0ieIS4OAWWxs0MhfE/Xc8efkNAwa8IAB9io28pxpGd3i7bnVo5whFQU81iS9NXuFy6+tNJS5aW+C4Qx5DOFmEvfp+FIgxaINthcb3IxJuDsX4hbPBVTQx+m2mJbqZY9Lg+gycNn/fS63rU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 15:12:58 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::1352:c7fd:4b4b:cc18]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::1352:c7fd:4b4b:cc18%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 15:12:58 +0000
Message-ID: <f7d0e554-b6ac-49ee-4caf-640967bc1053@amd.com>
Date:   Wed, 16 Aug 2023 10:12:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC] Proposal to relax warnings of htmldocs
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Avadhut Naik <Avadhut.Naik@amd.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
References: <85964510-4f88-58d2-2687-f7fa76013cf9@amd.com>
 <87v8dgtb9o.fsf@meer.lwn.net>
 <CANiq72=8DH8SZS2TZF+nHzCq3onXz-OuyE-xmYZncDmiKqVfzQ@mail.gmail.com>
 <ZNvGz4v2QYowrhk0@casper.infradead.org> <87bkf79row.fsf@intel.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <87bkf79row.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR18CA0009.namprd18.prod.outlook.com
 (2603:10b6:806:f3::17) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|SA1PR12MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: b61626fd-4586-4be4-8b37-08db9e6b464f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yocbbro8nHk78fEmlg7dXJ4towjyntGLWDCx9T+M219EPCPAE5d+WxJHwbxwY/fusZyCH9DdAGnWPDeyAzB2PAl/FzkNx1Bc9XEPSVkIHZyjFId2B7rdFY7kxJAkvmxprkDIqedjaVKjSs50/ri3z0g6s4DDC/yFnBgG7sxM80zAsNvgx9ylR3uqrxD2XSIh3rDb1c6UlzHq77MyqtXCDx4Z4i1tadG6Eh3Qw1mJ+jbetAg6r63ZrdKfiSfXf13y0rPClAe8VQ8rGgyDCEJlAHC2RdRXRElYj4aCxBxfrTBbg9PCUx3AOugYD5OgGkFXAVwfLlY/RSBLPVdQ+1qnBGLleuu9+ljVzGHQQ6GBBe1B2nB9DH/XUSr2YsEoQXERa6F8nsWCUw4LRlWgw7qeENvJNsixGNkuCgW2Q8btKswLtutsEDKT2woabSML4tZ6L7Zd3Isk26EMF4YaOoFyij3u420HIZlCAAvE2Cc0ORke4AeVpYz45LYkbFh5QgwvjFO0Goz3VQeTi9LnpRgNQ17mum72idGZTCTDqRFCz0NNgcOn1J63DPiuM41rV+j2NNamuApxsqqITFR3W2ORiwTiG8aLiGuj1piaILsqYKqvuP9iVQkPHiHWXFyrsEXdNpAGvOmu9LnFANMCAob2wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(54906003)(66946007)(110136005)(66476007)(66556008)(41300700001)(5660300002)(44832011)(38100700002)(31686004)(8676002)(4326008)(8936002)(2906002)(83380400001)(26005)(478600001)(86362001)(31696002)(6512007)(53546011)(6506007)(36756003)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0dhN2VCWEt0c0x4UmxFTWhvT2Rpd0xUVGk4QnFXNUxsbVY4VzJiWU5zdjBX?=
 =?utf-8?B?ZFA4N3h5N3FDOHVpZFV5VmdveDVuSWV0Q1FPNWdaWE9MTXZ2a3BxRTl6c3p4?=
 =?utf-8?B?ZDRrUVVMQ0JSVSt4bzdKZGZ3Tkt2RmNVRkpNY2tkYW5taktjWG12WE5OUzFy?=
 =?utf-8?B?Qyt4dnB1YmRPakhsd0w5ZnpPZE1pdEVQa1oveVlScHUzTlRBUVk0REhlNEVs?=
 =?utf-8?B?WlExazJPZ0pkOGh3dVNxaTEvbFlXNUlqMDFoTlZjQWE0eGh0UHA1RXZ0MGQr?=
 =?utf-8?B?V3pmMkxsNkpiWWEwZVhaZFRFOFlJQ056T0VOWWI5NDl4OWZ1aWNDbWd5ZlpW?=
 =?utf-8?B?UWlQNWlKdXpQSFVoelNOUFdVVUFQNGRkYjlDQ0VQVW13ZFVuSzFqMDAxelNQ?=
 =?utf-8?B?NUlHd01SMnRPUTZYL1FsU1JQd29tUWEzZUN0NG5uSSsyTmFLL2haYjlWcEZT?=
 =?utf-8?B?anNMRUdtWWdYcEVhSldWM3VPSldYZWJ1aTRvdVdlaWxkQUZTL0dKOXpTVzZr?=
 =?utf-8?B?UlpWNTJ0TmdOZldzWnh1R3NhOTA4VkNXOUVMNnpBQ3JtWWVBZ1BSRTkzSnBm?=
 =?utf-8?B?bXNxZVUxQzl4c3R1NXh1T3RqU01LOTY3OWVZVExQOHpiWEQ2am1WVTIyZHdm?=
 =?utf-8?B?L0VDNTlYMk5MZnd2TlJrTkszTEM3Uy9qNXRQQjNzcjFyb0w5WWl0WFNEQ1Bu?=
 =?utf-8?B?Y2R2OUxweWgxcGsyRVhxa3NRenNmSEY5bkg4TzlMclpMZXVBb2R1OXk0dDV6?=
 =?utf-8?B?dS82NnJJSDdVdFRrMGRyOC81SzdpaXpVQjhBQ2R1Y1pVUmVKYjNTVEhIaDQ5?=
 =?utf-8?B?YlBBaVFpWkJtMFZMQkZqVVQyUUt3RTdwdC8yTTZYN0Z4QjNFZkE3L3N4cjlm?=
 =?utf-8?B?TTdtMTArVUlsTVdURFVrMXRRUVRuUjdyUTBhVnFCY0crWXFvYVB1c24zSUVI?=
 =?utf-8?B?YTYwaHEwS0J5Z2dleVkxd3RRRHBjR1ZNbkowTEtHZTZQWXBONUREREdSSlBY?=
 =?utf-8?B?TEdrNlNmaXgvMGdtMGhRaWU4clptRkQ2TGhhenZudDNKdWRKUFQwUS9yTnRB?=
 =?utf-8?B?RllEOVJ3VE9iZ0NmTEVtekx4K2ExR0UwVGpPM1dnRTEzUEwvdVdxSGo3aEMv?=
 =?utf-8?B?Q09KRXJHUEJ0VDJha25BbmN2TjAzbDhxWFNtTlpGNDU3YkhWRTFQaXhSSEV1?=
 =?utf-8?B?bkUxVEVLdkp6N0RsKzNTVlBXZWx3bzBJWlZuZlR2ZzEyWGFqSlc1UFdFMW16?=
 =?utf-8?B?N1RJYlorWGdlOUJKd1hHa0llTDUyWjYvWG9LSUh1Zi91OVQ2TDdOOG12Wjkr?=
 =?utf-8?B?bnRpV2w5NmFtNUlWV2Fva0J5Q2lwUVhuWFIvcTN5cTh5U1kzQUpqYWdrQ1dr?=
 =?utf-8?B?eERJRDBHb2duaThWNmtpT0VvTjVvT0FYRzVaYnU1OUlRUWlHeWw1dDM0U1dp?=
 =?utf-8?B?R3RhQ3czSWpwS25DSXlIcU9vd3V1L1doUFoxOFdOMzBlQTdBem50eHJrd25Q?=
 =?utf-8?B?d2ZaVDQxY0c0aG9qWVc1L25RVmxML0dDYVVXOFRNRlo1ZlZ0Z1JhaXNuOEFX?=
 =?utf-8?B?aFNWcmpMNndFZU1MV1U5azc3QWp4TkRaSTg5Y0FSR1JENHY4VU9BbGViWEhK?=
 =?utf-8?B?c09OZUpXREVTZnRGbkowTTFxYXRLMmEzbUJ5NGNmNFdTNXF0S2J6SVhxclEv?=
 =?utf-8?B?WDh4Q2RyZ1QxYlk4Vll1Y3ZDTmpuMGp1dUN2TGxhbnhlWEdJUk9qelpXbnJF?=
 =?utf-8?B?anNUYi93NnNUb1RIQmdIN2FHdlhQK1hvMndzTzVBZEJCelRIU3cxUWtlSnN2?=
 =?utf-8?B?c3JxTm5vYTlFbTFqRlZwWEV1cHpGU08rOWZUYU9sbDdOY041SU01ajUwSDFM?=
 =?utf-8?B?b0Y3bUhqL00yclVtSDVuYXJHcEZlTXRhTTFKTEt5RG9lZkJFb05FZVplSjJq?=
 =?utf-8?B?TW1xY05oN1hwMkwwdFErNDZROG9vd255RzUrbTdWVyswbVVibXV1VzgwWStJ?=
 =?utf-8?B?LzNjVnRabTZFYU8yT01XYVVWRGpCNkxPWTdTMEFQSDVDODgrQkRRSW1OcDFy?=
 =?utf-8?B?QUw2QVlDOFpiNE41VWlDN0xIQ0tESElmQURVdG9HNDdrWUJWcytSekM4ZnhR?=
 =?utf-8?Q?3niXdklPLBI6YrJP0dluw0L4o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61626fd-4586-4be4-8b37-08db9e6b464f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 15:12:58.2412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4BMxWEhUkXx7lf4q4TOF1cpv9GUwwIbCYWGOZ7fHvBowEBGp/mrRth1US6YpyczLcRFuUmgzAR9Ex58sb2EDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/23 06:01, Jani Nikula wrote:
> On Tue, 15 Aug 2023, Matthew Wilcox <willy@infradead.org> wrote:
>> On Tue, Aug 15, 2023 at 08:35:40PM +0200, Miguel Ojeda wrote:
>>> On Tue, Aug 15, 2023 at 8:23 PM Jonathan Corbet <corbet@lwn.net> wrote:
>>>>
>>>> As an alternative, of course, we could consider turning off those
>>>> specific warnings entirely for normal builds.
>>>
>>> It could be nice to get to enforce warning-free builds as soon as possible.
>>>
>>> Perhaps we could move those to a `W=1`-like group and clean them over
>>> time instead? Or do we have that already?
>>
>> I think the problem is that we don't run kernel-doc by default.  Instead,
>> it's only run for W=1 (and higher) builds.  That's why Carlos doesn't
>> see the problems he is introducing in his own builds.  Of course, if
>> AMD required building with W=1 then they'd see these problems earlier
>> in their own testing.  Apparently they don't.
>>
>> Is it time to just run kernel-doc by default?  There aren't _that_
>> many kernel-doc warnings now.  Not compared to how they used to be.
>> And enabling them for everyone means that new ones won't sneak in.
>> I haven't timed how much extra time kernel-doc adds to a build.
>> Perhaps that's infeasible.
> 
> Personally, I believe it's easier to get at a warning free build (both
> compiler W=1 warnings as well as kernel-doc) by doing it driver and
> subsystem at a time, instead of, say, one warning at a time across the
> entire kernel. It's just too much of a burden to fix the entire kernel
> to enable a warning across the board.
> 
> To that end, the i915 Makefile enables a lot more warnings than the
> defaults, and the developers and CI run the compiler and kernel-doc with
> -Werror. No new warnings get introduced.
> 
> What I'd hope for is build system support to enable W=1
> compiler/kernel-doc warnings for a subdir with a few lines at most,
> instead of duplicating and copy-pasting tens of lines from
> scripts/Makefile.extrawarn like we have to do now.

That sounds feasible but, well, I actually proposed the opposite approach.
I wanted to "relax" the warnings (see RFC Subject) rather than making them
more strict by default.

My concern is that W=1 (by default) may theoretically result in a clean
`make htmldocs` but it won't in practice. Not all developers prioritize
good documentation like the folks from i915, and that may lead to
unaddressed warnings or worst, less interest in documenting the code. Isn't
it the case that some of these higher-control warnings don't really have
much effect in real life? And shoukd W=1 become the default, are we going
to be able to enforce that level of control?

If W=1 is decided to be the best approach I'm happy to help with that.

> 
> 
> BR,
> Jani.
> 
> 

Thanks,
Carlos
