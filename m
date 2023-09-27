Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02827B0F6D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 01:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjI0XC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 19:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjI0XCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 19:02:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5099DF5;
        Wed, 27 Sep 2023 16:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695855739; x=1727391739;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qfntqU8hU1GK78R/+vkT4g2sxiR9q5uv4WVleQshNlM=;
  b=j3r5tmvKs3KR1+yauxS+/4s+8nnEwcLE1m2+/5VON7otZ3XMfs23gaNR
   hOBJpZpsMguxtuRlrr+sCYt+hHq1KUa8AazvKLjMKWk2WHK7qJnC3TZ2y
   JNJBXhu4yMctj038qj2tgNHAeIBgaXCQvWhek7UN9Ew/3p7pD5h38gdq6
   Ngi6BfuLT9qmc3rWy9dFop8v0hXx11atasuR30RRtWRqxFzFz7YI8xuDm
   bDNRuiHfwVDEcEtkNMc3rSjsqRjocIzAasTvnncW55WXbwfv2F9XIq4hR
   4SbLsSoUVGIueS9i9oz04NEvRCNxflrf94wzPxziLIpdMNXr1eMNBbgQ9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="384741344"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="384741344"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 16:02:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="778705902"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="778705902"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 16:02:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 16:02:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 16:02:07 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 16:02:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJ9gMZYBr9jHuQELGsGmeoT7BHhzI2KtHNJFGmj8nsL0gnum+wvsOMYuw47U8uG6n3WKFtlP3+SyAm3wSH1m+zDXOaKJ8DyOeSCFO8rJt0oZcAPZg1MI0cZy1LMngkNimdmM9B1NoWluNeOdTo39xYxGlDnlqjgow/C7ff7OtPDqu9oBwfgRN9v+cQc1RARtidiFH1QQv/4+lWstQ5MnSXRgFKnI7ydgu1IgocISuOzoV2SwlaNtWXgVPo6hbICtvZ+2Vw/f4e/4c/ZqUkvtpfPDhowpQ51F5yCH9jCafKnEx+Gz92KWdzdjdm5soK7xTN9xVnPpFdwYu2VVQcuLmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teJ/3CpOcnRKTcX2+MpOjsbJ8hDDBHsYlHfQ9HZiuSk=;
 b=Qa46cp/oY7DOPqRGoTTdBGFI2ADxXeBstiNljXg3CmkPg/xrt8Bv0wk/Ac7LFAuvoX1TPEXZNgA38QFXTBWzi9ipXem1FHjjrwyLyOzzOK7eAjksTncsLtrM/S2FyQHbk+4jieMZAISM/KIGwfx/Ldqg1QG/R1r1pRHCDx8ft/M9RVLgLZrMT/MvA1nd3QzFsbIXeXTiwEVu7ET11LUprxrTVQ794iqkwxzVb5ZCl1U/YGcys24//oX4S0iVxlG7vQ6wgmC6KpWlPvJqHMoks/jvHjwRX1b9qstS98X9P+VhDeKFeMIvaDVuD8AtOstzJfd6I6wHI2v935ZIktnOaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DS0PR11MB7506.namprd11.prod.outlook.com (2603:10b6:8:151::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Wed, 27 Sep
 2023 23:02:04 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::cdca:c91f:da79:a1db]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::cdca:c91f:da79:a1db%3]) with mapi id 15.20.6792.024; Wed, 27 Sep 2023
 23:02:04 +0000
Message-ID: <c5ddb511-cc14-34f8-dd80-6471a9a72a81@intel.com>
Date:   Wed, 27 Sep 2023 16:02:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/4] Documentation/x86: Document resctrl's new
 sparse_masks
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, <babu.moger@amd.com>,
        "Maciej Wieczor-Retman" <maciej.wieczor-retman@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <cover.1695371055.git.maciej.wieczor-retman@intel.com>
 <308c92438288a45a12330af83aa0088a31f60343.1695371055.git.maciej.wieczor-retman@intel.com>
 <17079b9e-4efd-4258-2b5f-afc6d3ae2c0f@amd.com>
 <bced7bc7-c489-7a57-374f-62818cbfded6@intel.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <bced7bc7-c489-7a57-374f-62818cbfded6@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0191.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::16) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DS0PR11MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: df796ab6-d5fe-4eff-0c33-08dbbfadc42f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RPsmUZ9tJZeIYNj+dwnSYBm7dZvvvlynGAm7g4Sh3LoId5KBHyISJAUdYpL4iWhomXpiVCtGpcfYx9odduwT0nOXe4M2BELlt4vlXZrdhJhNxPcMp/AjOkc3SwdFGm+cjuTOgfTciAMxGDbxKpkr/PrAlSRxR4nmmltI6yZ2xbUhRK5DrjVtTWRglADX5vXVFDxrSL0AOyzHd5JiOCvlqY5q/MoYJAaXeCUjiePykTkq1gSBF2AGWJT+ynLBItFHHeSPVpURV9VMjHuIryOdVprGSpyf+ABuOlU39PHCtrBnFIET5SlpGIF7A2lc26m3IC4WT09apad+a17pIH2NrsQCEFbM4QmStBnqCvlFYxH7lJS/pLd0dma4TGniruejO/wsJQygyjVScH21/F7Hsbcr46XQ/BDOGgnsZSK4ypXRkSfDFwZ21bGXNd9ulxjHJxSiLfl78xvldCVnbBFGPTb3IGGZHLqeQQbNYbXciAOcCxFqTQp5n8AINBnjlSPJLNXisXCDGcjyt/sP3bwtSzhOE8HXjxKPLU8280llCSfcN89SzmxT5l9L8tuC0xlRBM17Y1OQq8jHIsmDAFFGT464F0+69xa8ohcuv7X1ZHAvkCFQ19uThFIzCrzCiUDw+ltnVfhZXUdtMUe0STJ6Go7Q1/M3p4t+PCnHYIJs4Go=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(316002)(41300700001)(921005)(82960400001)(110136005)(66476007)(66946007)(66556008)(478600001)(2616005)(6506007)(53546011)(6512007)(6486002)(83380400001)(26005)(5660300002)(44832011)(86362001)(31696002)(38100700002)(4326008)(8936002)(8676002)(36756003)(7416002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjZHZU9IaHdNWHlNRWs2YUt6ZHk4bTQ2NkU0QUVFWGg2UXVsYnk0czFOejJi?=
 =?utf-8?B?QUlIMDFvR3FHQ055bjh4Vmh1enlBUU9UWE5ZSXA3ZlU1Ullib05PRDB6c0pi?=
 =?utf-8?B?TFFwQTJqaTRiQkpIVGNYRzhxSnNjZlRYdlZOZVZsK1hJRFVBZUFGeURFMkRV?=
 =?utf-8?B?UzdzYXNTMCtEMHBuZG9MbkNVOEFYOVhQL1RwR1VobXRwQzdPQk1la3dPd3E1?=
 =?utf-8?B?UzNOTThONnhxZ0ZBMForQVRyRFovQ2FPTTZ3YmN0clNEc3VXVDlNbFkwZzFR?=
 =?utf-8?B?b0V3LytUa2toN2xqOEthQnZXMjg0S0R3SjdSK3k2RmtCcy9CRkhyY1JyUUo1?=
 =?utf-8?B?RjNqVzg4SlRYVEYrVzZaVENJRDZEQ3d3STMyaWtvWFA1L1dwaEZQQTNLeGhv?=
 =?utf-8?B?dlM4NVgzWURkUFI4WDJYTTNKQlcrYVVucUJPazFMbVN2S1c0QWQrSnNuZnl6?=
 =?utf-8?B?U210d0hWOFpla3k4KytMV3FmcE41QXREb3VIZHRnYk1Da0hpZEhYNmpVTVZx?=
 =?utf-8?B?OFpNWDVOMGxBUVh3L0h5bklQT3d0dC9Sd0FmcndBMjNBc1loUW5mMTAwQVBS?=
 =?utf-8?B?aDlPVm5lZmVNY3dhOEM0aFZ2ZXRKanh6OTF2TVIrU1N2VGdPWGgrUERQYW5v?=
 =?utf-8?B?a1FycEpoY2d0emxWdklmZllhNDhIbFNBYzhMZ1BmTmxjelZEZzBoSS9JRkdk?=
 =?utf-8?B?cGUyOXNJMXgvSlBaOVlVTjQ4RVNXVkZLcitLaVFnYkNkZGM0d1llNWpsejVP?=
 =?utf-8?B?eVVRcUcxa0lsTG9hNzRoa29NWTE0V0R1d2VRQWc0am9tWVhvZmcrY2FxZVJG?=
 =?utf-8?B?Rmw1N0Jac3FMNVl0RzdWSWhDNDVvMmp0cEpwVEpEUjNOcVVkbnVYRXp6RTlH?=
 =?utf-8?B?Vk1Rb2JiaUdLemp6RndxQlRmZlhFZnB5Zk9jQlNBMEREaFJtL2EzWkVCdTRP?=
 =?utf-8?B?NmZWNTY3NFFKUDdYTHBEcDhBZ0FEbG1rMm9qeWcwS1dtWFlRR0lrZXpxNlNz?=
 =?utf-8?B?QVMrQ0lIYitSRlc0RDNld3E2RUltZmFROXB3Nk9SRjlYL0N6YmlPbng2Znho?=
 =?utf-8?B?WiszSjhPNUVKQkgxRTE1MjFGOVQralNYQ2wzdlYyeUtXL3ZDV2VNOTFRSzVT?=
 =?utf-8?B?T0syd2VoSUJoU0Vpb0NsSXh0M1BDZ3dsUHZkRkVjc2hrbmdPd3FyU0ZXNFRw?=
 =?utf-8?B?ZVM0VHk5cWoxYjFjNFRPQUlMZzZuWUJxeUY1bnJVL1I4OFVmVXBGWDg4dC9U?=
 =?utf-8?B?Ri9PczU2ZHA5b0p5a1FIeFgrV1lVSnNlVVBhZTU1c2pVYnBLSWx4RVQ4RGpG?=
 =?utf-8?B?K2daYlBtMUFZaG92Yjg0anpBaDd6SHI0TjBYalNJVmlDNExxYXpPU2NnTHVh?=
 =?utf-8?B?QUIvZGZOZGpYdEhOWmJ1VHF4ckFEZjJzbFo3Si96RlNMclYzeXhKZ2svelVT?=
 =?utf-8?B?a1RoOUJpT1R6T2lSa1hIL2k0TFJ1eVVTaWtKc1VWbWlUOGFiNm9DK0c3RnlM?=
 =?utf-8?B?QmE3MXB3bTcvWWxFelU3bExZeTg3SXB1OGtaQno0OWlUR29wdVdlTjVyU3Vz?=
 =?utf-8?B?L2NOZS9OODhleEhPYkxQMGVJcVQ3cDg5a1htSUFnK1doNTU5VGxBOTFKS2c5?=
 =?utf-8?B?YWIvSnpsWjNiUUg5dW8rYWZMU3RkNmpIRytNSU9aZ0EzY1lSaVYyQUFiZjMv?=
 =?utf-8?B?dDhZY3pzY2ZZb2hrZDJkZXNEblRIOVE5SktZVUNZazI0NGEwaFhha3ZyMVMr?=
 =?utf-8?B?U3ZPbmJLTldqeGM1VHdvV1F0b2JSTjVWb05aV2ZvcW9vMEF2eFhyclZlNXdR?=
 =?utf-8?B?Wms1eUxQTExuU2dqQXN4MlZ2NzRMZVlxMUFyTWVVTHdScDJWb09JUnN6RERp?=
 =?utf-8?B?SDlMNUNub3NqaGJOQ2lhaHhlNEM2S0Frd1M1TFhKakFQMU53dzJ5TTF6T2Fj?=
 =?utf-8?B?eHVHbEVnNlpBdTZpbjlQMWdJZGFnTzRsQkh1VnlHT1RacEZMZXpDbGZhQlFM?=
 =?utf-8?B?NTkyd0pRbExSSnJCckhxZkJzYm4yeFJpRXVrMHRCcFRuRDVtMmNQSTdkcW1n?=
 =?utf-8?B?RG01NTdpeEErM2ZGY1VXYVBTMm5pdnZtZnpMNWY2MzBTVlMxU1BocGgwYkRO?=
 =?utf-8?Q?RNYxeon4SIAbeZT+J0GBmWPLd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df796ab6-d5fe-4eff-0c33-08dbbfadc42f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 23:02:04.7022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5TzAF0oUEcHT8xMfCy8Pbm2UsTOoqz8OO7wuNUt3CPQgtQOF/FJTxfC1Xxq1EUnFFLXZ3nM0o09If4C+v6M8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7506
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/23 15:58, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/27/2023 3:47 PM, Moger, Babu wrote:
>> On 9/22/2023 3:48 AM, Maciej Wieczor-Retman wrote:
>>> From: Fenghua Yu <fenghua.yu@intel.com>
>>>
>>> The documentation mentions that non-contiguous bit masks are not
>>> supported in Intel Cache Allocation Technology (CAT).
>>>
>>> Update the documentation on how to determine if sparse bit masks are
>>> allowed in L2 and L3 CAT.
>>>
>>> Mention the file with feature support information is located in
>>> the /sys/fs/resctrl/info/{resource}/ directories and enumerate what
>>> are the possible outputs on file read operation.
>>>
>>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
>>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>>> ---
>>> Changelog v2:
>>> - Change bitmap naming convention to bit mask. (Reinette)
>>>
>>>    Documentation/arch/x86/resctrl.rst | 16 ++++++++++++----
>>>    1 file changed, 12 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>>> index cb05d90111b4..4c6421e2aa31 100644
>>> --- a/Documentation/arch/x86/resctrl.rst
>>> +++ b/Documentation/arch/x86/resctrl.rst
>>> @@ -124,6 +124,13 @@ related to allocation:
>>>                "P":
>>>                      Corresponding region is pseudo-locked. No
>>>                      sharing allowed.
>>> +"sparse_masks":
>>> +        Indicates if non-contiguous 1s value in CBM is supported.
>>> +
>>> +            "0":
>>> +                  Only contiguous 1s value in CBM is supported.
>>
>> This is little confusing. How about?
>>
>> Non-contiguous 1s value in CBM is not supported
>>
> 
> It is not clear to me how changing it to a double
> negative reduces confusion.
Agree with Reinette.

The original statement is clearer and more direct to explicitly state 
what is supported without introducing a negative assertion (not supported).

Thanks.

-Fenghua
