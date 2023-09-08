Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDE0797F9F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 02:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbjIHAYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 20:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbjIHAYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 20:24:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC73D1BCD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 17:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694132679; x=1725668679;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=M70igHAh3r30MpobZsibOCwztHsflBDTuXFI5Nw4Y7g=;
  b=WHPygxZBy7gmLbIqUkPB7OoiN9fc07mfEGq6PjFDMo7eOSLszO0XzRoZ
   YuA+vSA42Ftl9No2H2Q+Jqdr/rK5k7ZmeDivNt1rHhjJ6MJXncl44mO3O
   Y3V7bYY1ugMoG8k7IK+zBkCzdE299PhQPqRFS0gJjeashfOljNG996lt1
   EWqKU6GJtE09RFiNvyIuCo4onNKfPmjMGUtCaE6jgTdWNOvHhVUE/PRNf
   s9HREzTm542fyX4Uchk5nlnthu3KeJXYPtjn0VBO56ApInEqNE4PYgsj3
   dHELl0t+vEgX2K1GTtE1CcrJ1IqpReFoemsPOvSscqsIA1QAd9PNRiSgg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="408506762"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="408506762"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 17:24:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="718923117"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="718923117"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Sep 2023 17:24:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 17:24:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 7 Sep 2023 17:24:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 7 Sep 2023 17:24:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcnKE1A47/igF+7zV93bsdMajJTIeLL18hCETWmE7TjiLkANtafOBycFDoEBztYUym9g83S+inPM7NNW+902My536m4b7okpoWDDBMjz3/zfgRql8X3uSEq+bngWnwlNXzm2ZPyNH4R+95rPA1Q0hZjVveDUWhrV7UH3xzOP8SxwipanVrnVbqtZRPnfLj8Xmiv74+QEUMrHM9wUFh67W3pRcU0K1oj8i04kmmpriOyirv6SY6NImLLUVAGnE1wBZLEivHrN1xKcnzHZgRkOgznZQKHOg3isuYQdB//MPJK1W+N+Xibz9c00h5eCcIWPccOjlled5lKZdY2CHZMDNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IFeQV/zlr8g05oGRgymHEWSPY3cfrJwjDYmDishfI0=;
 b=UcF6EunAQJtgSMruHt/ftYd+LvOeVYM9BiMdBdlzg83B5m418tF67U4KcxLw7IBGja3upk1bKnvqF/QxviLXmHb7ogbddymPU+Hqbu/8aSbp+iTYxc/CoJgnjJEG9AWpnt9dDhWYIBPZFrN1i/YhNaJQqUno7gZmn5jjRmdVvc+8eyj/YniRDk1Guy2sAhM3JGnRiUdv0xpxRmyXhbv4Sovw0SSmqozrpSAEiQ4aq0SMoen2qJQyvqSU+0DKX1HIHFP1GNDJDwqfzqdM8to00TLj7ZmjoWpdfX8+X4uUa15idh3tEUllrDO7w9ldZqqJ0eDoZdl3v62Zrct1ih7DXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3094.namprd11.prod.outlook.com (2603:10b6:a03:87::25)
 by PH0PR11MB5062.namprd11.prod.outlook.com (2603:10b6:510:3e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Fri, 8 Sep
 2023 00:24:20 +0000
Received: from BYAPR11MB3094.namprd11.prod.outlook.com
 ([fe80::5e3:67e1:e213:c87]) by BYAPR11MB3094.namprd11.prod.outlook.com
 ([fe80::5e3:67e1:e213:c87%5]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 00:24:20 +0000
Date:   Fri, 8 Sep 2023 08:24:04 +0800
From:   Yi Sun <yi.sun@intel.com>
To:     Ingo Molnar <mingo@kernel.org>, <dave.hansen@intel.com>
CC:     Andi Kleen <ak@linux.intel.com>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <sohil.mehta@intel.com>, <ilpo.jarvinen@linux.intel.com>,
        <heng.su@intel.com>, <tony.luck@intel.com>,
        <dave.hansen@linux.intel.com>, <yi.sun@intel.intel.com>
Subject: Re: [PATCH v6 1/3] x86/fpu: Measure the Latency of XSAVES and XRSTORS
Message-ID: <ZPpppPyeob9O8Yy4@ysun46-mobl.ccr.corp.intel.com>
References: <20230901143414.1664368-1-yi.sun@intel.com>
 <20230901143414.1664368-2-yi.sun@intel.com>
 <ZPMTVNM2oBCdSYjJ@gmail.com>
 <ZPOIVmC6aY9GBtdJ@tassilo>
 <ZPhD7B+pXyeP2BPS@ysun46-mobl.ccr.corp.intel.com>
 <08dd36d0-08e1-cf55-355e-5c21132c44fb@intel.com>
 <ZPj3BpLlGkBeYcW7@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <ZPj3BpLlGkBeYcW7@gmail.com>
X-ClientProxiedBy: SG2PR02CA0134.apcprd02.prod.outlook.com
 (2603:1096:4:188::14) To BYAPR11MB3094.namprd11.prod.outlook.com
 (2603:10b6:a03:87::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3094:EE_|PH0PR11MB5062:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e91b12c-32c0-43b6-db66-08dbb001f1f6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HZDvSDR/iASp2ztJMGL8h/rJSH8xztHNTB9EutIaW+kvtHXWlT4MwqneYG6h+paGbjAGzb3x8rSqKOIaorBSffxHhli+HOdgL3zd8D6URGCJHQ82iQbvaEsf6FrxiOfSZI9x5aXCvspbzpbFBqmeC+zs3aChx/qNfX97KTO3qESKrd6JlzzMMfdcZ4MQd5tKtLVK1lB318qqf3X6R4UQXfecOungI1oOKV+wp7GnY2CPQ7EpKXYHvll1uUyu33zOHoXJwCUl2poNdN3/a2uNunULFZhsVYHqxf8/SOZALSOVjdQCjRLbIv1rZOSggOJfMsmbcC3FvQIUjuM+ULesxmsQqOPVGIN9B0WPIJIuvvVKQXYU2hQeZXtQKrev9zs0pyZAZLFUPn4/HyJvLeQd1ThNPz/m9Ih8c9erKXjsPast6NvIkvhAUzKay2bby1rfCooG7dR0RsjxE8L8oshPTneGVphSD3YjnCiQoxGC3HbZd/ecw/ECQzhrWgeo78mZmY7+ThCaSbqR+zzXcrfqG4QNhcQ05PZQnFx76qp2jA4uJcPF+ES28imfBIJEsJtk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3094.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199024)(1800799009)(186009)(6486002)(6506007)(53546011)(6666004)(478600001)(2906002)(6512007)(26005)(6636002)(41300700001)(66476007)(66556008)(316002)(44832011)(66946007)(8676002)(4326008)(5660300002)(8936002)(86362001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1h4SXBIb09hak1rNVNXVmd4TnJ0REpINzcwOHZZNnlUUlNDbXVPRjhVODNH?=
 =?utf-8?B?eCtWcGZFQWVRZk9UM1A2MEdHTlFSa1F5eU5MSXlKMXNoRmV3UFpnMGlkVG8r?=
 =?utf-8?B?RXJvNk82RGtPTGhsbXZnNzB2M29RRXdtaGx6dnZxaytqYU5ZR3o4MkF4VER5?=
 =?utf-8?B?Ri8vQ2dLREZNamw5RmZ3SHpOTlh1N24vVzRUQjFja0xtVmpLcm9JZ2dVK2pP?=
 =?utf-8?B?R2VYSnZPazdjVjY2Z2tBNEo2Z1M4NXhEVzZENFlGVGJuclAyMkczektjOHVI?=
 =?utf-8?B?RXBNS21RU2JnVnF1ck1UTDJEb1A5VlJkOXdBSDkzUlZzMENScHk0UWtUQUtG?=
 =?utf-8?B?RVp4OUhIbmJOcWhCU1JyejBXZjU1cXFMVmM3aWxFUS9tZWhMdk5xY25IMzd3?=
 =?utf-8?B?ZUlhVXBuR0JQTXdkZ0pnSU5OUVBkQllSWkw1UTFkL016WERrVExHTU5ZZ011?=
 =?utf-8?B?RTBIUGQ0Mlo3QWZiNC9zZmlBaG1LNkV4a0pCbXpnMmEvelpVc1JXNmtrc0ZV?=
 =?utf-8?B?RlNFNGtxKzZGWkgvQzRRNi91V1g5bitZNXMvVm1uUElrb2lTK3ArTVl1WVJ1?=
 =?utf-8?B?YlMydkY2WFk3THlsTVQ2V1hWQW9CZEIwRlNNcGRTajhHcUJvUHJtajJNV3lz?=
 =?utf-8?B?T0tyR1lCS29iOGhQczVsaTI2cmgrU2tJckZnYmxmbHoxSFJpd0JCZHdpL2s2?=
 =?utf-8?B?QVZRbkVlYTBYaWtMaGkvR25ibXlQQXFYTjBnZFFOL3dpVDgrN3FaNitVY1lK?=
 =?utf-8?B?VHVRczVKajArK1Z5SjY2b2sxczd0ZEdncHBtMjVYdHlidEtBMi8wTFFmSHM0?=
 =?utf-8?B?Uk9vOWR3N3F3ZVhWWHlremUxOEdNWDNRMndRR2NhZzFobWhjam82SWVlNGM2?=
 =?utf-8?B?YThJcWhSR2RYWXp1KzdTUXJjNkJra3NhRFRJL2M1Zkx1Rk9kY0NzS0N2ZE4z?=
 =?utf-8?B?Ni9jQ3NKYWxZKzVvcGlvWSs4bjVyUEJraHgzQThmS3ZIeWp2L01kRldkVTZl?=
 =?utf-8?B?a0h3U21vaEpHa0pSblJCNUtwMXI2TFA0UnNDRmVqeGZJL3BmQjRsUVl1T3ZX?=
 =?utf-8?B?b3V0WG9pNHAyT2NmNklKVkEyNHdIWHpXQ3Y1Z1pYUDh2Yk1QR3B4SjZLWEJX?=
 =?utf-8?B?aU5iUzM4cnUvbmkrTXlPWWE5ZHUrdytxY1UwenBRWmNha2hxR29hZXNDeEs5?=
 =?utf-8?B?NjVXVG9YOHVNSUpPZ0lLQ1hJalJhT1gzQ3hOZ2o4dmQ5anVsRkMyc3VFQjlE?=
 =?utf-8?B?bEh0M3ZRTDc3TTV6ckc3OU1KbllyZVVIc2FDQWZMY0V5VXJJYWRlVW1xNE5m?=
 =?utf-8?B?THRmSHZzKzRzZ0IrSmRZdkZUSFdTeExOaDJOYmlrbWNsZ04weTBYdVltS0c0?=
 =?utf-8?B?SURDQWdkeU1razZWZ2Vhd2d1bzFLcTlpeEMvQ09hZFAyNnpXOEhoZEE2czNu?=
 =?utf-8?B?SnR0b3ZDU2JuRm8rTUFFOXJjdENaMlBMQ3lTczZ5dlZ0SEUreDliRlc0TGtW?=
 =?utf-8?B?Z0w5N01KaU5veUdLNjlxYXR0R3B2ZEhnaXJERzg1eC9QYlh3Yk5Id2VkcU5Y?=
 =?utf-8?B?aUJhMFFRdFJxVW1vbEpRMWpac2Z6cDQrMlFMSmZ2L3lkb09rNU4rejFQdlJl?=
 =?utf-8?B?NTF0dncyYXNtaCtKa29wWTc1anJNUHhnZmZuNE9IWTFOVmNyZVg4d0prUGdy?=
 =?utf-8?B?d05id3VzUmxxaitsNUdqY21aSnpGUUdHczVLOW1jNXRpL0xzRWVJVXhkWjhz?=
 =?utf-8?B?UGNsRU85eXdJOVJQY3cxaEtaeDVsb0twV2RPNnpIekZub2gxbXRmazlURURw?=
 =?utf-8?B?RERXaWFoZHY1S3N1cW5EVFljOUd4UkFSUjhhUjVnNzV0ZWVLd0JPK2xmZmxP?=
 =?utf-8?B?aGtQaVVUM2VtNnJLRlQ4UTQrMDBnZ2pFNmg5clVpdDBxY3RqVmRKa3g5d25z?=
 =?utf-8?B?dUVhVlNGeWN2ald0K1RWRE5pRVdIejRIRWhQRXNHZkpPajZQaW1hYzdkcjVL?=
 =?utf-8?B?NDB3SFpJM2NmdzR0b3NLYjQxZzJjb0xSUy9UL01CdFF6Ylh4MXBhTEhnT0dy?=
 =?utf-8?B?Ym00VHJTRHA4MUUxSmFEUVBRMTJxVTV5TDJlZGFRL1BxeFNSeU1vcHRZbHNP?=
 =?utf-8?Q?EST3gEr6V7M142yB4IIivSdtw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e91b12c-32c0-43b6-db66-08dbb001f1f6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3094.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 00:24:20.6152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6eMjIAMtIN+iY85OtwEraDAUktr5HxdqjlZdew0cgTlpDQfB3digF3c8vg2ghQUSrxuGMV+5/I71TV/cwSjaqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5062
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.09.2023 00:02, Ingo Molnar wrote:
>
>* Dave Hansen <dave.hansen@intel.com> wrote:
>
>> On 9/6/23 02:18, Yi Sun wrote:
>> > Or just use PT
>>
>> I'd really like to be able to use this mechanism across a wide range of
>> systems over time and vendors.  For instance, if Intel's AVX512 XSAVE
>> implementation is much faster than AMD's, it would be nice to show some
>> apples-to-apples data to motivate AMD to do better.  We can't do that
>> with PT.
>
>Ack - and with the explicit tooling support, it's also very easy to provide
>such numbers.
>
>As long as the regular FPU code paths do not get new tracing overhead
>added, this looks like a useful tool.
>
>Thanks,
>
>	Ingo
Hi Ingo and Dave,
We have been running the tool since kernel v5.19, and the patch set has
been tested in our internal repository for several months.
Additionally, we have implemented a test suite of micro-benchmark in user
space that works with this kernel trace, and it will be open-sourced soon.
With all these tools, we have obtained useful data, and we haven't
encountered any issues.

It would be great for the quality of X86 SIMD instructions if the patch
could catch up kernel v6.6.

Thanks
   --Sun, Yi
