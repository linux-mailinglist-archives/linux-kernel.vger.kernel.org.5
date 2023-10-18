Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F198D7CD96B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbjJRKke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjJRKkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:40:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEEBFE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697625629; x=1729161629;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QIg01351iPEcx2KMEmqBwfUgFAp3Nc6/okzsBo7FWuA=;
  b=Q9klaZhqxr0CGvmwJWnva5ptqujMD6OIVYMQbhy0PpIgdNjMnTsSnfBs
   PBusnOwSwpbJwx7WSlJ8q6cPM4Kuopf/D0lRK0T2xsO/3ijR6iiVbqCiI
   olfcXB1LFYGSDaPulzMZYZAP2vN82UvU1bwSp3q6AEIY8dwpjChAPtiY5
   z0OG0Ob/dMx1+wZ8a5O/XwLKgaJCUTJl874vJxpm1Ixs7BmRHheTkpYC5
   BUCtO7X1V9SJ2X/wgC/Up2HttEMxM7OP8+jGBsEkPiaXAyEG8KY7S6OnI
   ZHaDhZWF7/wfm/7GhWOmHnJnspejrAAsgl/+Lwdzv+rJFyzzw/dcZC81w
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384868617"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="384868617"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 03:40:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="1003753209"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="1003753209"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 03:40:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 03:40:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 03:40:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 03:40:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 03:40:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGw4kGMp7xAzMhqgddk39ymMKdKY7emtcHza7wkHARh+zHHinAXNRFSLMBZ/D149tOrn4i/VrWe2HE/4Z0hnjkPncw/TlOf1c2C/jz4Kv4Y9g+MTH414NI8x1yMFKXc6Zv0ctwaW1lRge5aYCy4bvxusgPA+tAEo8WqVIxueYYNbSb6aKfM58GIBYsHispN5+PA3YeL8ryK0fd0JDtJ1a237wloTPdmbm33wPzAVj7MZdYceQchJHSpY7NlZ+xEPs4Ik49j/7VfmFzy0+/KYNBOTzZbDl7ok0o7RVrFq4NBon3PWbEtI6Ild+uKDlXD7dQPTFP4eiWnP+uTaGVrevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFY2hYvZ3ZCJaD+Zhk/Wtf9OEIdtNtIPTZifGE6CAVQ=;
 b=Y84wLRxSboVVVaMCenW5SqinXMrDcvXZw+4tBZ7UV+2g4kfdnDsL8v3UI0L3c0OA3lhlxjcgEoqGp3MQEsG0GqH+doJ3EQtZ1ymYrsfPVU9pMDnU5qNQKPH0bqaSrLq9HLeBLsYx7TDAohZ6tPBIOzsUQAqLMORxn/Oraq0i56wXNQf0XZWF3vSSXO8Sh4BAMfwN+YEvTJWzXvoWXWxybWsHcneMV10pxaLgnniXOmoOZOu6w3a7ooYUPJU3Y3dQAYRKO1+d06u5cfTtEprDv6ao/Dn9rp0HzSgASz5uUGVwyp0XsHssgBhINs8NDd4ladYwV2FdY093Lwe7nNlu3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4243.namprd11.prod.outlook.com (2603:10b6:a03:1c8::16)
 by SJ0PR11MB5582.namprd11.prod.outlook.com (2603:10b6:a03:3aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 10:40:27 +0000
Received: from BY5PR11MB4243.namprd11.prod.outlook.com
 ([fe80::59cb:e244:fe8b:184d]) by BY5PR11MB4243.namprd11.prod.outlook.com
 ([fe80::59cb:e244:fe8b:184d%5]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 10:40:26 +0000
Message-ID: <cf483cb5-7d94-9514-2213-46778b5ac9f4@intel.com>
Date:   Wed, 18 Oct 2023 12:40:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] staging: rts5208: Replace delay function.
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kenechukwu maduechesi <maduechesik@gmail.com>,
        <outreachy@lists.linux.dev>, <shreeya.patel23498@gmail.com>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20231018004300.GA3189@ubuntu>
 <7bc719c4-459f-3d8-7ed-b1e1adf158@inria.fr>
 <1118ec6d-e1e7-79f3-08e4-9a79c996eed1@intel.com>
 <2023101853-axis-stylist-f1b9@gregkh>
 <7dde176b-1059-e9a4-a023-0243cce61d01@intel.com>
 <12b375b1-acd3-476e-17bc-b4db22efba69@inria.fr>
From:   Karolina Stolarek <karolina.stolarek@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <12b375b1-acd3-476e-17bc-b4db22efba69@inria.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::13) To BY5PR11MB4243.namprd11.prod.outlook.com
 (2603:10b6:a03:1c8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4243:EE_|SJ0PR11MB5582:EE_
X-MS-Office365-Filtering-Correlation-Id: ae44ebe0-c787-4779-500e-08dbcfc6a3f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U1hjKQ7l/ilzzQ6BeYjPds0suQyKBtjxYz7lRvRh9rw8cpuPAO1FLxoqV7l80eKiC4DW+gvmIm9cBW0lweCsiujYTqZSSgpfv2oWMKr7SKQH1Ol7KtDvYThMCS2XJYqa93Qa8o45a7F6ZScagyXdx90FTlaeqFGP+fh6o2fJtI+ikBrcnlLNmBrW6ha1eIPoZhPr+SVScsVKTGnp102p2aJF3d28YI+u71J7/n2oicjVhEV6UZ2qprayYKym4qKggmfMLReUlt2MiMtKcWXsQp8z4jHIsOp9GtQbDJBf+1zyli0lGgoV1LgRV5uJ5D44duM9vUj2yPY7m6r9tSiKvYhbJTsFdhXirCsRGIVfnyMbJjGrkoDXsB1FpeB6K7MuJ5UAzKm82YAJ42JszbS3Wv+zmZfwi+hZDSEJEXJwQdmTtMJA7M8wmfmLGsWOG/4ViHAK+7FBKSUe7CTOBVYBGh8eQh2VBTzbOxToO3treFc4KDqOGOTu8UTaoiJNRTt1K/Ox2U+wedxjn6Be/6KUPkKzFMYVzCdTkKAzoZ5yxmXETEy2/n7TOZ9bpAVymHWPPf2eRcyRMFgu3DMjHMxGqnJft2PMyEmPKiq1h+pj/vnLrMwif6AyrxJkhDAEL2ajoYeSZ1xu/IWjFRuzAhDqEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(36756003)(44832011)(5660300002)(31696002)(2906002)(86362001)(83380400001)(36916002)(2616005)(6666004)(6506007)(53546011)(6512007)(6486002)(478600001)(82960400001)(38100700002)(26005)(31686004)(41300700001)(66946007)(4326008)(8936002)(6916009)(66476007)(316002)(66556008)(8676002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEd6U3NpMjl3emtjZXB2K0JuZ29WS1kyY1ZvQjRvZG1ZUGMxWTdnNGpXYjFV?=
 =?utf-8?B?NnpvazZqa2xaSUkyTm81cVZOWXB1ZFRiSW9lZG8xc1NDekk1TElaNzFkSC9V?=
 =?utf-8?B?emdDQ29GQTg5cE5nVkgwQksyMlVvVllrSW90Q3RZSjZYSGxLVXUyRENERVRk?=
 =?utf-8?B?dXVhS2Yzemgxc3dwZVRQWDN2SDJpRTdYellOS0FCL1pyNm5tSm1XTGR4c3ZU?=
 =?utf-8?B?aEpMd0liZVNPbDR2ZEd6bDJFd2VLOTI1NE4yRWNzd255MENjYVUybVkwS255?=
 =?utf-8?B?WEMvMmdDVU83V003Y1IrM2FUQ3IrZnR6Q010S0VrUHdyU25DQklWQzVhWXdl?=
 =?utf-8?B?RjEwMUNDeVcxQ2tKeU1xVkNKRUVoQ3Y0cDlOdmszNDZTbTc4NC9BR09xQkdw?=
 =?utf-8?B?dTBxazZzRUNReVNaTGlXSWRZL1o0YlRjbi9ZVnlMOTM4OG0rVDYrRlZVenFL?=
 =?utf-8?B?cFc4NE9uQk9XQjkxcEhodmdiaHRXeTdaakJvdWM2Q0p1WnUzYXBYUnVDM3V2?=
 =?utf-8?B?VER3NVNBLzQxb1pRUzdDNnBkdlluQlBuVWRPbktEeldydUJGcnVrN2tNM25N?=
 =?utf-8?B?d2k2YkZMN3RPckpFWlEyTUtiS0g4ZTlRVjNGcDU5ZE00am5iU3kxeTYveDZO?=
 =?utf-8?B?UldGSW1WMTdFR1hyVG1VbHVXWHh3VDdzUnRrazgzVXk4OUJ1RzUzSUtnRTVK?=
 =?utf-8?B?WU9STC9VeW10RDc5eWlSUUx1enFGbVhYbVpDeW9Wajk0UUNITHZnazVmQm5s?=
 =?utf-8?B?aUNtN1F1VG42SVdqK3ovbjMwajUvVlltWmZjaXpaM1dYV2RuZUNoS05TK1By?=
 =?utf-8?B?K2hBbWVtM2lmK3czV0Rsb3E5YjNNMUVJeHZtYURibElzNUNET3lUK295K08y?=
 =?utf-8?B?OWozZFdrRVpqcGl0Z0ZOZ0RCdk9KREl6VnRDbC9iQWFrY0ZaWG82NVJ5ZHQ3?=
 =?utf-8?B?WVBGTm9wNzlRMkFYWUFxWVhpWFZqaC8vRFk3UElNc0FtblAwWHRRZGhWd3hB?=
 =?utf-8?B?WEduV3h4U3pZV3d0SkZsaVhJdjJZa2x5TXZoVm9NUm5EUFZrQ3ZMNTRaTVBX?=
 =?utf-8?B?QkxVWkd2emlYWE1LVVFsUFY0TDJDaVV5ckpmWDZPM2lLQ21TS3RBbEE1RVU4?=
 =?utf-8?B?em11RDhUZG14S2JQbEs1WFdxMW9TN0VBZEdYYVpOYy9GWHFQaElPdXlhSERv?=
 =?utf-8?B?S0J1VWJLSm0yT0ovNzk4ckVELzJnTXAzblQzNG9uQWRkMHBhNkpzdEtJUGlG?=
 =?utf-8?B?RVYyWDJqeHcxRStDOFY4TWNYOWFYRDJ2dXpYMDNhT1I3K0RiTnQ3aXl6UWhp?=
 =?utf-8?B?Zjh5blZ2UVE0YXRjL01pYzNPaWVWNldkMGR1eGlLMlE3c01Ub0krcTZxd3No?=
 =?utf-8?B?WG9ERWZJcFNYbVZhZHA4VkdBYUdZME5zdWtCajRtVmxhSmd4K3BIOXlxOVgx?=
 =?utf-8?B?Y0dzMFpzZ2pLMzAxUUY2NEFKTTNacU9UcjZIY0NSVUtLdndZRW1KZHFOWUg0?=
 =?utf-8?B?K2tWS0dnek9GN0Z6RCtpeHZTZlN1RjVqN1phQzhXTnFURDJtdkR2U2ZQaGFy?=
 =?utf-8?B?djhRZkdJZnhicW54R2ZZYWNYNzJWRFB4ZHhqckFkYkFDZjRvaThqWHlHUFFY?=
 =?utf-8?B?NXVMbEI3cy93UlQ0RGROaTJOZ0drZEFDUkV5QkZQR05SU3A5S2dmN2VYVnB5?=
 =?utf-8?B?MU9DUkdjY2dPdENKZGk0UUJPNExQb1pvOWl4SzBkb1pTZUNITjc3aC84UGUv?=
 =?utf-8?B?MEk2WkJMcXBndXZtYVpRMURDaWNqUjNJOTB1VlhrRHc5ZVlRUWVPbzRSSTh5?=
 =?utf-8?B?UzJnOU4xa21GZDM5ZGswaVRQM0pvaXZnNEVhSmtyRFpKcG0rYWQwN0FlMnJT?=
 =?utf-8?B?c1U3YVBxOEdYdmtRTWhRcmRUT0VuZm5CcTM2eENBaStudHVhb3hZY01JZFlJ?=
 =?utf-8?B?b1VLWGx0MTV0VnJnclEwSmkramI2UTdWd0VHR3VLNXJCSGRoMnB0K0tWWWE3?=
 =?utf-8?B?K3Foak1LeWhvVkwvSUl4SnJTUFg4S3hReHQ5Vnh6Z0RTUjJvNjZ6djI4UWtB?=
 =?utf-8?B?VWRmNXdYd09hcTNUOW5GWEh0Q0pMUnNPdWRqRC92V1QwN1NCdWxsdi9ZKzZV?=
 =?utf-8?B?YVJvdFFsTHh0ai9wWGlOYnZPTWdCbUpJV0tQVzNWSHpXcTYxQU5aL2hDUGlo?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae44ebe0-c787-4779-500e-08dbcfc6a3f7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 10:40:26.5595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3nEEYoxoqQTe4lMEgm3pZDFZ8d5o/BiDikJAPRb/oKxlixdcqkc1YZyyo4xqVfj1y+wUJNvRL5ULnb9ECgq/j77TMoLlUOi2cER/buTMU0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5582
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.10.2023 12:28, Julia Lawall wrote:
> 
> 
> On Wed, 18 Oct 2023, Karolina Stolarek wrote:
> 
>> On 18.10.2023 09:45, Greg Kroah-Hartman wrote:
>>> On Wed, Oct 18, 2023 at 09:32:46AM +0200, Karolina Stolarek wrote:
>>>> On 18.10.2023 09:03, Julia Lawall wrote:
>>>>>
>>>>>
>>>>> On Tue, 17 Oct 2023, kenechukwu maduechesi wrote:
>>>>>
>>>>>> Replace udelay() with usleep_range() for more precise delay handling.
>>>>>>
>>>>>> Reported by checkpatch:
>>>>>>
>>>>>> CHECK: usleep_range is preferred over udelay
>>>>>
>>>>> This message is typically not a good candidate for outreachy patches,
>>>>> because you need access to the device to be sure that any change is
>>>>> correct.
>>>>
>>>> Could we add a paragraph on how to pick good checkpatch.pl error to fix to
>>>> the Outreachyfirstpatch docs? This could go to "Find a driver to clean up"
>>>> section, for example.
>>>
>>> The ability to find a "good" error changes over time, so this might be
>>> hard to do.
>>
>> I agree, but we can all agree that experimenting with udelay during Outreachy
>> is not a good idea, and people should know about it
> 
> In general, I think that it is better in the contribution period to do the
> wrong thing and then learn about why it is wrong, but this case comes up
> over and over, and it is always not the right thing to do, so I added an
> appropriate explanation.  Thanks for the suggestion.

Absolutely. Thanks for the docs update. Still, one thing -- is empty 
section after "Some drivers that are on their way out of the kernel 
are:" intentional?

All the best,
Karolina

> 
> julia
> 
>>
>> All the best,
>> Karolina
>>
>>>
>>> good luck!
>>>
>>> greg k-h
>>
