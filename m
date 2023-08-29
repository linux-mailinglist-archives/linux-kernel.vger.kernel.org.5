Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDD878C75B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbjH2OVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236942AbjH2OVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:21:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1459E18D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693318875; x=1724854875;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VJd5K0+a1PCKQW0vbqyms3WQTUc8XPOO7sbq7yi2SHg=;
  b=fgxkO5C8Q31OSWDEajt2b9QmDf9suZpnOyIhHilmEku0hMUyciasQYP/
   /S7jD+ZEnMJ79FEx5lMu/2GklzQYrf9QnMdbnf3fh7RNLJmp+Ek8B4dPv
   bqtlZTLXd5WMqv57ZgBOuEbaLbZUNcgoRuC38QY0mxBaQbjuQPRIFr8p1
   8VmJ+wGuJh5pJv+D92cES2lh9QxZHrYe/Ey8EIrHJQsug6NSAFHyAGPlK
   7suj33fsFAEC/8QIzEytTbBllS0B2Hrr5bRaFIxu8yypLEM5MO1sjUwv7
   XXBjhMWZGOPz2D/xmsANkqQh/TDKwAQi/+C379zfbB5vUh7NrBZs6Iupb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="378097448"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="378097448"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 07:21:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="741830564"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="741830564"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2023 07:21:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 07:21:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 07:21:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 07:21:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wq64toutQ0giMzeT1X8kvIRFoiFNtmyBnY2TgompbzEMlshlk5gJ4alZRWLx3Fyl+cT272nIv56QgrvcP+Mp78QNW4EgzHC2SkHUje5Zu/HytOwFtLGDYR4qcasRTeBE1a8RGXGI7Jya+rdpR3KNv67QhQhZ0CkWqoaR4S2aS6whd+3Fm16I+bBbtQPCK0wdzi5Ni1cuGoF0f9mJ5J9b4doz7V7Eyc5bLpneQ+ZrK8qoEv9sfpfAEcBZIVogH1kUiyzU66sQO14H+SbfX3dv34tYLUU8aaSbKQ0P0luElcZx606AKaTwwg3srti7jb1a1ugIUJr2HXxm3KIPRyZpBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIRoaOJEnDrmMPHplIUyRTb/HdmPqtn1cJXvEFjIyWI=;
 b=kgZtKgfpRNrtSeuB/e1i9mI1ApFiBO4gIyQPfnvXPc6RGagl8Tx9eb6KqZkNvy8DtKzzpYta1bxxnUtpdv4UXmObRf2TFgtuaRUI+K6Kv0T27x8D2JlyuiOyx6fteE/w/4bRlfsEIZJ/xAFZprNwB0F4bWmj3VM9+deauMok4/Ri7Zc9ufLcZiUXFPix3xaaI7oMZy/cgds6WaGbTAkA28X3iopOdqBU6/SC/etB98Nvwt9OeIMug/sbCwFcqiEkrRTwim5qK/9a5bkq2oe43JOS0w62dYcB7dgL72/LtLENhrceQTY08Qc9m4gs5sg4f51VkIoCIbZ2SbuPVUPqjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by MW6PR11MB8412.namprd11.prod.outlook.com (2603:10b6:303:23a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Tue, 29 Aug
 2023 14:21:03 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510%5]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 14:21:03 +0000
Message-ID: <60bea4fb-9044-76f1-fe2b-ddc35c526d5c@intel.com>
Date:   Tue, 29 Aug 2023 16:20:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] ACPI: processor: Move MWAIT quirk out of acpi_processor.c
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     <andriy.shevchenko@intel.com>, <artem.bityutskiy@linux.intel.com>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <lenb@kernel.org>, <jgross@suse.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <c7a05a44-c0be-46c2-a21d-b242524d482b@roeck-us.net>
 <CAJZ5v0jASjc_RYp-SN5KMGJXDv8xbMOqJscLF3wG8rdE2_KJGw@mail.gmail.com>
 <3fd2e62d-0aa9-1098-3eb3-ed45460a3580@intel.com>
 <CAJZ5v0hnNK4O_HyinvTp01YxXR7V4vzpMhf85yW9M2=52-O2Fg@mail.gmail.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <CAJZ5v0hnNK4O_HyinvTp01YxXR7V4vzpMhf85yW9M2=52-O2Fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0299.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::7) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|MW6PR11MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: d416feb9-4b3f-4d86-f1ec-08dba89b2d3e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nB7ZPpmGyxN1Rm64eKsXP+r71vL6QMnjIIvn2AvvLq3J51FaRUFL/8kEPQzdLf+IuZx6KTTEof0/a6XqcxCnpT9o8WRn6UtvbvXC3ctLBjBLil7dA3c0o/l8UAWJvh4EzN1toJn+A5KFqOpWgcYDtTfw4kagwkst2GTi9cUC6U6mGcuKlGMzp2f0iwuecxLXs6QacRsuvlWKDBOCqmvWxP3MqCVl13V4TL3LhqEWpNsVLv1mSfdrJcuzUKXv8Xg/QKOQtRqSltBQXX+bcxjPElEKOkmicVk0L3J1MegGQdUvWq3CCH9aEsGpCPWKUIBeabCs7MIjmTTgpjXo8D/jFgml9/ZFQW68HlltWm1B4PV8t5hKwwlIh9ss4E84MYs+sXGHK23JRO95CSQD255vXnRFiakoVf3krG2AxhWsSUqLcuObfqxtulPSZZqz1DZuqtiTJPRMjBdHZRuHZQdLSKPHc2ny9Ah0fpW6pPdZf4Oij43ZBziIS/nH4f8bTPLAE9E9kimUSpR/zJukRxhzWCIgKAGlImd7BwctdBo0X4FO7bg69kuVkh9+hpw659rYNpf3WjJKHc6u1goHNGlK7zW9dVnd70YeNH3EEFp3wib5VptxEWJ3Ay3EEldHwcGqIwQyAXS4PfqJFYQkernAIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(186009)(1800799009)(451199024)(6506007)(53546011)(6486002)(6512007)(6666004)(83380400001)(38100700002)(86362001)(31696002)(36756003)(82960400001)(316002)(26005)(2616005)(66946007)(110136005)(66556008)(2906002)(41300700001)(66476007)(8936002)(8676002)(4326008)(31686004)(5660300002)(7416002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TittRXZCTEpmTVFBenI5Rk1iYTcrTzhOaWs0OG9oLzNaaEtJUkd2ZjQ4cXg3?=
 =?utf-8?B?ZE1Pek1jcERtMnQveldLdlBWYzVRWFdDQXptQVJnOFU4TlZBcENkeXJiQXpI?=
 =?utf-8?B?c0hVVE1HbElpdEE3UVI3UDNDd01zcVUrYUhGMnBieW1vNVNZQXhySk9Rb0py?=
 =?utf-8?B?eklLa2FiR1d6Tk1Ea29kaWUrcy9IZWhGOStpTWFFT2xpSmJXczZ0SXpUODhY?=
 =?utf-8?B?SWpmbGQ3N3h5czFCUjI5cEJKVGxod054aDdqYS94emFXVUkxS3dHUURrQ2Zm?=
 =?utf-8?B?WEVnWDlpUUxUSXhvZS9TSU9HMSt3NXpTU1dPWS9JNytUbWdISXRmcmZBYmR2?=
 =?utf-8?B?ZStTUlYyZThxeTlHUnhLWEYzSnZYMHJ0ZkFwQXVVTnRBUXRTZFQ2ZFJLWkN3?=
 =?utf-8?B?cktJV2QwcDd4OW11enJwQU1JTFpMTkxpSFhBZ1RIY3BsczNoaFQrL0JqRGln?=
 =?utf-8?B?aDdDMUUxcWxQMWlEZnlCdjJsckllTWQ0RXp6Q0VLRUlFVUhLY2tENzlqQzhD?=
 =?utf-8?B?ekFrQmkvUUo2eXBuZ2lLNDY3bkxaRFJhNFdCOUVOeW1zaDhJeWtNOUlzeXND?=
 =?utf-8?B?QWpmUWxiRjdwRnk3NkRVMEdqRDlNSW5ROFI2czNwQjFva2xjQ1BqSHNEZ2ls?=
 =?utf-8?B?bU5nNzkreVV2YWJvOXFHMUFMZHBnaGZWRk5kdmJSbER0N215cmNpRFR3azNs?=
 =?utf-8?B?OGVqekRad2FKREZjVkZYTzBvSEczeWQwS2xNalRiSTh0bFc2c0JCd3hsYUsw?=
 =?utf-8?B?MWxsWE8vRXdVb3R2dnZwZWwvbElWUlRINTdnaGNCYWVNN1MwMjJsWWM5SEVj?=
 =?utf-8?B?WmhtYW56ZmxPUkpMUWg3OTZTV3dmZWFyTnNhVGdKWjdwNHlwNkRXT3RySlgr?=
 =?utf-8?B?SWJkV1VsdTE2VHJUMncyOVFFUEtFUnBoQ3FjZU1HMWxrOWxzR0g1KzlUV3E3?=
 =?utf-8?B?QmsvcUtsLzdSMVNtdkc3bG5MWkVVMytBZFZNRVp0WnRqL1psQm5UbHc4emZj?=
 =?utf-8?B?ZmN3a0NUVzkwd2diSmhweGs1UjJ6KzNkSDl2akZYU1ZmeEdQWmpWNjR4OTNY?=
 =?utf-8?B?TWpWSis2UTFlcHRCV3V3bDkxTmIxa1B4Zkh6Ti84elBsYldvdncxRUxSZWt6?=
 =?utf-8?B?SWpGWVdobFZsbUVmSks1ZENPNTFFYWtyL256RmJjZTgwRVdlU0dSVnBPSWVH?=
 =?utf-8?B?TmJhNTV3MXBwSk1yNDBtREQvbjhja3lXOEpyb1Q5VlVLRS9YaVZZNDZISWdh?=
 =?utf-8?B?R2ZBU21VZlR4ZWVuQ2NxRHRMdDdTUmhDYkJvb1N3ZEVjMXc1ZzFvVzU5N1Mz?=
 =?utf-8?B?a2hTb0tpNm1FN2VHV1BURUV0KzhkeEdDWndtbGRrVG0rd1IxemVGRkduVnBu?=
 =?utf-8?B?aTFKOU9FUzVqaFV6a0ZQbEZ6TTFOaFFWSWFZUW1DY0RadlNFLzk5cVgxOGJT?=
 =?utf-8?B?VnFlQmFMRzc3dVdsZ1UxOE4xeDVWa2tHWG1iRVJoUW5tbWZQbVZ3YitlZ3RI?=
 =?utf-8?B?dVpRRjlYNE9qOFM1TE1jNnBIdzlzMlhmUUhRU2tWTTdYY1FlTEFYSlk2QmlG?=
 =?utf-8?B?YnUvR2tYQ2c0YzJVb2tBaitCQ3daenVPUG5Vak41dlE5Z1hUK2k0Skk5UTB5?=
 =?utf-8?B?VFZEZXB1QWQxWlE5S2ZtSGZ6WXV1UStLWWlyeUh3eVY0WU1zK2M2aC83RWt0?=
 =?utf-8?B?QnZpaVVsVWM0WnNvWmF4NjNBQlcwNnYySGNSMHh2RzdCa0ZqeXVTbUQ3SFRY?=
 =?utf-8?B?WnlubHRZM3VlUEZMdjhWK3IrempEOEhGTTZkdzg2bzBiQlBQTnY3dEloU1NE?=
 =?utf-8?B?cmpwSk5rbHhCU1lpMkNsc1A4cjRYTGtNNSs2enJ5dmJPU2hiZnRRYjhzTi91?=
 =?utf-8?B?MDgvRW1TNE5tall2bmNLS1Z0eW8vcElHMzYvTlRUbmc5S0dkOW9KTEpGMzE3?=
 =?utf-8?B?SmExRkR1cktBSEhzNWRFcDRuei9lMUlIU3oxbGFwUTlZdUtZMTZlc1Q4T0pp?=
 =?utf-8?B?cnhYUjlzZkw0V1ZHdndZL2F5RHpydDJhWlMraERZSk9DakpyNEtSUlY1T0hF?=
 =?utf-8?B?ZkF4WW51anVnenR6MmxCRmZyZXdJbWprdVA0dFlyQzViMG1pUFhQeEtyVVdj?=
 =?utf-8?B?VExMaGZFTnRWbnlBalREcFVaZkF2T2NVNC9vQmRDMUM3RnNxMXBkekRPdVhV?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d416feb9-4b3f-4d86-f1ec-08dba89b2d3e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 14:21:03.8336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /AlpnOM/qgq0ArW+6Hjghggn3nildHF1cFUTx0DOxCHvMjySRIvKwjGj/xoeV9wU0ool/oDUly7ocHoHncCnM2sMbmcDPbRrJ2ka5liXjWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8412
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/2023 4:03 PM, Rafael J. Wysocki wrote:
> On Tue, Aug 29, 2023 at 3:58 PM Wilczynski, Michal
> <michal.wilczynski@intel.com> wrote:
>>
>>
>> On 8/29/2023 3:54 PM, Rafael J. Wysocki wrote:
>>> On Tue, Aug 29, 2023 at 3:44 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>> On Mon, Jul 10, 2023 at 05:03:29PM +0300, Michal Wilczynski wrote:
>>>>> Commit 2a2a64714d9c ("ACPI: Disable MWAIT via DMI on broken Compal board")
>>>>> introduced a workaround for MWAIT for a specific x86 system.
>>>>>
>>>>> Move the code outside of acpi_processor.c to acpi/x86/ directory for
>>>>> consistency and rename the functions associated with it, so their names
>>>>> start with "acpi_proc_quirk_" to make the goal obvious.
>>>>>
>>>>> No intentional functional impact.
>>>>>
>>>> Except for:
>>>>
>>>> ia64-linux-ld: drivers/acpi/acpi_processor.o: in function `acpi_early_processor_control_setup':
>>>> acpi_processor.c:(.init.text+0x712): undefined reference to `acpi_proc_quirk_mwait_check'
>>>> ia64-linux-ld: drivers/acpi/processor_pdc.o: in function `acpi_early_processor_set_pdc':
>>>> processor_pdc.c:(.init.text+0x72): undefined reference to `acpi_proc_quirk_mwait_check'
>>>>
>>>> which breaks all ia64 builds.
>>>>
>>>> Time to retire that architecture yet ? No one but me seems to even
>>>> build test it.
>>> Including 0-day it seems.  This had been in linux-next for several weeks.
>>>
>>> Michal, can you have a look at this please?
>> Hi,
>> I'll take a look and get back to you with a fix,
> Actually, if I'm not mistaken, the attached patch should be sufficient.

Exactly, adding this empty stub will make sure there is no linker error, this function
is relevant only for x86 anyway.

If ia64 support for 0-day was turned off then I think it was rather recently, cause I've
seen it working I think back in May.

To be honest I'm not sure what is being done in such cases ? Will you send a fix to Linus
directly, or should I prepare a patch and sent in on the list ??

Thanks !
Michał


